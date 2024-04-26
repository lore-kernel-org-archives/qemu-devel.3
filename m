Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2672CC19F4E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 09:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0HSj-00036x-QK; Fri, 26 Apr 2024 05:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s0HSe-00036I-JO
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:01:41 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s0HSb-0000dW-Qa
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:01:40 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3c74abe247bso1149820b6e.3
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 01:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1714121974; x=1714726774;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lLRISAUx5dGOdtkrcexaLB1Ku2kM+BYGJQXR98E67Hg=;
 b=SsJ1gHK2pwtakNuRuwqPRMN2ethORKdFl5ykXW19DE+EeAP1+V2bBAYPr3yIHQYCTw
 ksC8WGhD+c+kncYO+x5wlTwRRohggzOgbZi1S+hMa1CcrZBmZ4M32gzQEK5pjrEJ5wFt
 TW0UhT9s3DFNKrsLOH0xOAHF6umfDPj/GXBzmgsmptAxG5un9uu5o1SuJU+Ng/v5BGPJ
 +TQm9UeD0XxtnsY61fXw1cm9vIZ/ix8mfsLTnpWFWjPs32nCoCmkc2Wx1nwXlj2iy9V/
 /cKqfBznQ7dPNNnKgn9MMawEkGJH2/VzRPFTN9WxGF/CfY5bntnFMfCaK9ZMpjvLztYn
 q4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714121974; x=1714726774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lLRISAUx5dGOdtkrcexaLB1Ku2kM+BYGJQXR98E67Hg=;
 b=YRutcJk7PCMNXYJIHUhTghzJeTnB1q/0iCOqGOzF6+zVyXtJWvYA6iybi0g1yskOWN
 3IdptyeVVWktGhKQklbD1p2boGijlhDnOsXj2YaW96KEb1aDOuWo9Jzz1SAhyK69mOxj
 9zGrrwpT8h6iJsvGPerXEeUh7uSHQhZISY5y0NkGGi20L6HPLXrAyb8PURL+lDNV5yJb
 mO1/bLZlF3lBU0/mzUqi3ZGi/O1+3mUNROek6VUdHrF7Ak/oJIHvgz7+OmibvfTCQU9A
 wYzyLnNN86NPlzPvdQBzUjzjvv4ew+Op4zCBxcwfw4SWEXwYbzQmhn33iSoQPLtYnvgD
 kPUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSwwB8R7lKsApimxBDHimsgvrpPlGPAxuuoiOI2GqOxWTMme1CjPPHo3eod5ei2vbvJpChr6qatuA/7a1KrcPpNP6Yt9Q=
X-Gm-Message-State: AOJu0YyyxstN0p6brf5Ft6oTPERoddxX2u0QPgZmHlHJyL9UcPkUzOYI
 y8ZqBk97HMVE7pX5gcS3LMoM54Sf5LL04nG5ns9UT4uyYTWGXo1cntAw0hVYRTI=
X-Google-Smtp-Source: AGHT+IHzLgIp8R0Ms0m03NqoTjKekuS8lN+f8AS0hiNyZO+f4RWVueFXCd45PVeWqhxu41W8cEpAqw==
X-Received: by 2002:a05:6808:1286:b0:3c7:bdc:c6db with SMTP id
 a6-20020a056808128600b003c70bdcc6dbmr2451624oiw.58.1714121974292; 
 Fri, 26 Apr 2024 01:59:34 -0700 (PDT)
Received: from localhost.localdomain.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a63e44d000000b005d8b89bbf20sm14038848pgk.63.2024.04.26.01.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 01:59:33 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here),
 Raphael Norwitz <raphael@enfabrica.net>
Cc: Yajun Wu <yajunw@nvidia.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Li Feng <fengli@smartx.com>
Subject: [PATCH 0/2] Fixed the problem of vhost-user reconnection
Date: Fri, 26 Apr 2024 16:58:37 +0800
Message-ID: <20240426085855.665813-1-fengli@smartx.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::236;
 envelope-from=fengli@smartx.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Previous discussion here:
https://lore.kernel.org/all/f86d6159-5610-476c-a69e-cd3a717f9e40@nvidia.com/

The merged version cannot fully cover all possible scenarios. Here we revert the previous
fixes and then use new methods to fix them.

Li Feng (2):
  Revert "vhost-user: fix lost reconnect"
  vhost-user: fix lost reconnect again

 hw/block/vhost-user-blk.c      |  2 +-
 hw/scsi/vhost-user-scsi.c      |  3 +--
 hw/virtio/vhost-user-base.c    |  2 +-
 hw/virtio/vhost-user.c         | 18 ++----------------
 include/hw/virtio/vhost-user.h |  3 +--
 5 files changed, 6 insertions(+), 22 deletions(-)

-- 
2.44.0


