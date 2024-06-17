Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E70C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 15:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJEcS-0003YZ-DF; Mon, 17 Jun 2024 11:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sJEcP-0003Xv-Fq
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:50:05 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sJEcM-0002xm-6w
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:50:05 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-705cffc5bcfso3955077b3a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1718639398; x=1719244198;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w7/U6o+BgH0Tm5LHP61xSs3qxjcfLPKxbfufuaiUDXo=;
 b=kyEInJp3mo2lFdrt6aMrrM+IMGF2cRg4b7jTqv6btk7viW9d7KEwArrr5dcZP8TlTc
 F4zc70WAwEW1Y9cznfAu2+JQfCQ5yRsCH0SSCR1JHacHOi3xF0uHb5yaNZ4rWFtk8qij
 jYWbZLXvsqoHs8vOmUjrDoHSz8T8WFrBUkbliY5J3idUKSa21aIGtr7jbqOlREtDqGRx
 qUylQVwsKT82I3th8z7FX2kBUvgknGIbPXaFvLDdpTcG3+bQH6z2ABI2Rcuu1ncrrXVA
 OM/LZWIB1sF4MTj4MgAjaaNSEmal3mz6vCWrH21DB2cillxGjp97K8JZ5I+L74YxmkNO
 fqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718639398; x=1719244198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w7/U6o+BgH0Tm5LHP61xSs3qxjcfLPKxbfufuaiUDXo=;
 b=W0fYZag3AbBzBY3/FWCo8VG+lnW/oHjPaFbKWdjvj2s77h4dAF09n908Z97COLH+tN
 aRiWLFC72K13oyMYYWBSKkgod8aT6T1HmC6AaL6reuTcWZvq+2gMgO9kfvz9EKvb8lp9
 +qDm7aKoyUzHmWPagyIWSRGNVt/g1U3XAvhDZe4e2Di2rnS5yPlVWhC2Y8YlloAK5rNC
 RC6MxmXocF8UMQ5mg1z/uPcAMPcu2Lro01SeigJy4Be30jYPSYGU31JKYxB4yHTLA6pM
 H8vPzPg4liakfMyXePx2ykoMVsrSD11cqK09UJH4l6qlLBjhY1qy+R8bNln3Ofag+ceo
 2v6A==
X-Gm-Message-State: AOJu0Yzw9ImH0lyTHqciMPKuKBxm+38Sh4V3KdLn3n3G0hfyy7qR37bs
 +X/c6rNA3w6mt7AJ/YaE+1LEyQl+v03xNFHTrTBAHwPz2PbElIl0WPwNm9JSBttz/vyPjasCq/X
 P4K4u0g==
X-Google-Smtp-Source: AGHT+IFvrNghZSun1pJib1ggYRbxKpl/yZ3Jsc9DfVR+TNgkdiaL7ftMuRZoSgNHseDdveqpnAFRaw==
X-Received: by 2002:a05:6a20:9689:b0:1b8:a3f5:3557 with SMTP id
 adf61e73a8af0-1bae7e7d73bmr11514385637.24.1718639397596; 
 Mon, 17 Jun 2024 08:49:57 -0700 (PDT)
Received: from localhost.localdomain ([125.71.94.151])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc924ed0sm7511138b3a.4.2024.06.17.08.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 08:49:57 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 0/1] Dirty page rate and dirty page limit 20240617 patches
Date: Mon, 17 Jun 2024 23:49:50 +0800
Message-Id: <cover.1718638495.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 05ad1440b8428b0ade9b8e5c01469adb8fbf83e3:

  Merge tag 'virtio-grants-v8-tag' of https://gitlab.com/sstabellini/qemu into staging (2024-06-15 20:13:06 -0700)

are available in the Git repository at:

  https://github.com/newfriday/qemu.git tags/dirtylimit-dirtyrate-pull-request-20240617

for you to fetch changes up to e65152d5483b2c847ec7a947ed52650152cfdcc0:

  migration/dirtyrate: Fix segmentation fault (2024-06-17 23:29:21 +0800)

----------------------------------------------------------------
dirtylimit-dirtyrate-pull-request-20240617: Fix a segmentation fault

Please apply, thanks, Yong.

----------------------------------------------------------------
Masato Imai (1):
      migration/dirtyrate: Fix segmentation fault

 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.39.1


