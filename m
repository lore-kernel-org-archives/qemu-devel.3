Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6313AC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1QxY-0008Hh-L0; Tue, 01 Sep 2026 12:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1x1QxW-0008H4-TO
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:03:38 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1x1QxV-0001UD-AR
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:03:38 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49987367394so2106465e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1788278615; x=1788883415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=q4F26dJ9S5ki5CbSjijwOxlzEcyyjNqV4qCvuR7o8pM=;
 b=IJZY+qkPBZlVfhJT8uuArCKvlq4HT03mrDg/9Pm9WCpKfu+QMINBTP4D1fPe6CUHh+
 7jY+uN97gay1RxOhk9V2LwtGSIcwW2KyjrdU33Ifk8tEdb1d4OBv3aWOul/3OuGgSw8O
 nJzX4e60g8J0nFhIdkddqO7Eo1tUlNdSBPUu1eXGn56hzgrg4mZ/L0h7Z/oFnh6NePgA
 NFRb/jdf0gQlVA6CMLN4Dc4c+7VMEIH1SkLxFhn7fxh5WeZYAuKWNrCRCVZ7/dc3pjJA
 NZzf7A7/FznQTvahJvwT69aZ1i2vL/hwa6zWjdMJrA2uYUIasWArpNCSRw9l2kU7ou70
 DDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788278615; x=1788883415;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q4F26dJ9S5ki5CbSjijwOxlzEcyyjNqV4qCvuR7o8pM=;
 b=cVjOkpOIv+zcrjv4pxOPMgozJ3raDcPY6wbiTHVAfat7r0kBUmeQ8JCxaoOnILcSta
 WlOhC/SXSur5wMpt/sBumi39Jo1dlhteYja/rIScwKMuK5l94kjO9ByRwhmtXO3U9da3
 ySjDDDrDd5uIcXFIldnhDrhxSaEtuJ6M16Z33cE8S24ABrmUvmkr3FIrce3wsZG9AD0x
 5odyNuWpJq/hSCZfNdO2WSc/FmX57sQ2jGSTPjiZNhBl2DMC/8XlwgfWWel81rZMRnax
 uh9+MU3O81BoLMgqqj0DLOF4RAVTFLC2T2wj1STaKyz5E28fVGWLIrpcbQ+FFmlRg8J1
 29Ew==
X-Gm-Message-State: AFuF++mY7bqe42Lu/SV2vzYDg5xGTrVdaj1j1n4dT9dXLN73DlAVM8x2
 32JotLF4u+KcfztRisHNLAPcvlq/xCSlcf4OKXYqjx2iDJWNdeKxWK5NID1Brw782eXQ493x1ia
 A4n2QfYs=
X-Gm-Gg: AR+sD12g5pOGeeBS38YXzdXdcv+HyiHPbzyUy0g2h5mzkrKymQhQkQL/DFEfFjA76+p
 Dd2Rwo0mdQ7oaPIEMnA1Y86fpaEDSVGnthscRyvp17XrMVGqCUwIYEFjXLnkvtz94LJ7KfNhdAf
 SGZ8KaCzl5DvqABXpUORpqOAUsJWcS5bm3m/i4e8eVexPciSSihsZm+2LFxWFdI3zbLt5s3l1Qy
 42hCjY15zVIH025RuBgVpTx3zx49fmPCXw3H2gy1JnoRAwWZEJNb703NqbYBl4FHMszYZyq7l9Q
 NaM/sIXEopWSWFugvmuEg5gYoNuBdfN2GAGLcCLoGYWglwLZ0gPBcv/OTR8Bt2uoFA+eQdmMr7N
 Yb/xxdX2ci4/dpbWWlwnu/Lhhv3HYtVgegJc7Sa8A7jrZiHfBDQbEWTPm67mWmypTkSEco43TCm
 KppxgZ8vjoBFalSD0ni5nUUWT4YDAVoQqtqnmgm0CYDaJW3MHWh8W6fHUvDwzj9Oph4i+AWVkth
 9fx/ctkmy5GFVh1w8VDcX3VybotroPuNwgNz1VAC3EIuxY=
X-Received: by 2002:a05:600c:4712:b0:49b:910c:76fb with SMTP id
 5b1f17b1804b1-49b91c4567dmr207795885e9.2.1788278614878; 
 Tue, 01 Sep 2026 09:03:34 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fkb.profitbricks.net
 ([2001:9e8:1471:a200:e095:5b15:7c12:5f73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce0b456sm87367435e9.2.2026.09.01.09.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 09:03:34 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, yanfei.xu@bytedance.com,
 Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH 0/2] migration/rdma: send small control messages inline
Date: Tue,  1 Sep 2026 17:51:19 +0200
Message-ID: <20260901160333.29859-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::335;
 envelope-from=jinpu.wang@ionos.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Control-channel sends (registration requests, ram block replies, etc.)
carry only a few dozen bytes, but qemu_rdma_post_send_control() still
always memcpy()s them into a pre-registered scratch buffer and lets the
HCA fetch them with a separate local memory read before sending.

This series asks the QP for a little inline send space at creation time
(patch 1) and then, once that plumbing exists, drops the mandatory
memcpy() by pointing the SGEs directly at the header/payload for any
message that fits inline (patch 2). Messages too large to inline keep
using the old copy-into-registered-buffer path, so there is no wire
protocol change.

In testing, this doesn't show an obvious improvement in total migration
time or downtime -- the control channel isn't the bottleneck there.
Still, it seems like the right thing to do: inline sends are supported
by modern HCAs and reduce per-message latency on the control channel by
skipping the extra local memory read, so it should help control-plane
responsiveness (e.g. registration round trips) even where it doesn't
move the overall migration numbers.



Jack Wang (2):
  migration/rdma: send small control messages inline
  migration/rdma: avoid memcpy for inline control sends

 migration/rdma.c | 82 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 63 insertions(+), 19 deletions(-)

-- 
2.43.0


