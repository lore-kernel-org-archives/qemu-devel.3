Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84F3CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGiks-0007yD-OL; Tue, 13 Oct 2026 16:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGikn-0007vP-IU
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 16:05:41 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGikg-0003MW-Hr
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 16:05:37 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-3282db206d3so669676eec.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 13:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791921933; x=1792526733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yxG2+ZsQuPaa6XaQtgeEOUrziz4q34X+31ZaFbfef6k=;
 b=MrqEWpxqMu4CkVneHJ8UUOI81OEoZQ57CUp7nBeD0jS8auUPdNInzLHSbbthjzK6/Q
 u8OISn9DANY7pCqrHLFudTWPSHwHhqQZdfkk0poxFoFBfSNv4py4TNiAxAN0ty8RwKSE
 /ljVgdfcd23hnJccJk9DYzerUKFZ2fSFTxhwtKSToQX+D9Z5Tz8s58HGjN+foROcS5wu
 SpXRXArHxF1IrJdCMg/HESe0bk0VTrv5xonv7GiYYIHM+zKh8M7e7+VZ4V9C5x6wkVTZ
 NK3uKQIesdSK7ZqjRUlYMmqO5awD/ILeJzMadGL8THurRw77zBqJsRxz+voFlr4G2JF1
 v6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791921933; x=1792526733;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yxG2+ZsQuPaa6XaQtgeEOUrziz4q34X+31ZaFbfef6k=;
 b=yoILXmm6w87ZGCBppSvrRRNNckj2wxWsT2TS1+4IU/i2fFfwvYsx77DJzkGg3Ydjs7
 7R99j7pZQuAIGdZm84bKZfQKc6Tq5rPsSQ9RGr+lPrHYU3f4uxieSdiw1SgUjJl7uu2d
 ToPsqaEu+IAR/DuFFSGtCCvpDl1Ty3VaTZBSyEwuEylzX2VJ9BCmELaBH4tfaz/BIutn
 Z7N2451Z9yvLEnydxP+5TkRzoN7DxcyztLKSgmvyslq4EPxF/0Lx/CPrEb1gBCvZ/tKr
 RlQ++WEnl28vyXkT7+JdhlI08urY2pobgGKIIn+hbRnjeykLv9DXVgiddOph1uoKySLh
 bknA==
X-Gm-Message-State: AFq9FYK1lTsmDgvTd44I3yrpr6NHpSnQUEp6qG5w6rrqeGWn4RseCK6L
 dteVF696DUftuXLFIAkFIwXzudeWKbrGG6VxY0lZa5sSDPzqaqDazx8O8FjM5A0a
X-Gm-Gg: AYBFou0zKUkgBSeRcYcE99lwf/CIara1mhGbB6Sl91Yk5VkIJ8yOSwHOsiVD3BYW98m
 B0L+No1zNFik6Uku7r48gKBcTeRG3QrELNJk85PrKF3BjlFfZL0p6NlZSeNPclIgR1QRvJmsW0c
 29DGZbVpWDrNR7c7+I+tOcFtQUu6/gtWwMh1AXxekCjc4ERdvSmULZBvhpHs2Xw1e4C6lspsYu/
 A/GclMah1VGZy7AKQBtuMGTWL7QMjetym6Yd4jsj4IanumPObIbMew3HUqZhaQJfGHXkc/E7Hx1
 bYPEuLdK8QMRrFGHQ8COlfYIKGr32lJui7KrYhxllHwnTy2Gjhbb10aCbJW5X8uye3BF2JFDSwQ
 XWZCwMq5ZPuTPEpQUCjEAXzbq9EHkwUz9x+Cv5SLs+E1TawaO9+O17vOCZ/XDfFXPKwqV3vqKyl
 FNcR9+Vf25hMWa30MUI9/pq9W/Fyko0BBg214aStelbsowxl9yGHAMELHi6mpVuRDSTLh8+9Z/g
 lT83JHpUjrTWBAYxw==
X-Received: by 2002:a05:693c:809b:b0:359:6187:48bf with SMTP id
 5a478bee46e88-359618749c4mr13828943eec.25.1791921932455; 
 Tue, 13 Oct 2026 13:05:32 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-35b29c2f861sm25568233eec.11.2026.10.13.13.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 13:05:31 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@kernel.org>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 0/3] hw/(pci/scsi/virtio-mem): Avoid call to target_info() in
 class_init
Date: Wed, 14 Oct 2026 04:05:21 +0800
Message-ID: <20261013200525.1340-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now we are going to delay the target select to machine select.
So that avoid call to target_info() in class_init so that we wont
face a NULL target_info() error when do class_init. This is because
class_init is called under object_class_get_list(TYPE_MACHINE, false)

Yonggang Luo (3):
  hw/pci: Avoid guard loadparm with target_s390x() for s390x in
    class_init
  hw/scsi: Avoid guard loadparm with target_s390x() for s390x in
    class_init
  hw/virtio/virtio-mem: Avoid call to target_info() in class_init

 hw/pci/pci.c           | 18 ++++++++++--------
 hw/scsi/scsi-disk.c    | 18 ++++++++++--------
 hw/virtio/virtio-mem.c | 12 +++++-------
 3 files changed, 25 insertions(+), 23 deletions(-)

-- 
2.55.0.windows.3


