Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92FFC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 04:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBRe3-0005aS-3f; Mon, 27 May 2024 00:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1sBRe0-0005aC-Nr
 for qemu-devel@nongnu.org; Mon, 27 May 2024 00:07:32 -0400
Received: from esa8.hc2706-39.iphmx.com ([216.71.140.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1sBRdw-0005MB-Sm
 for qemu-devel@nongnu.org; Mon, 27 May 2024 00:07:30 -0400
X-CSE-ConnectionGUID: /3mGaIqoTUuDYbX9Xb10Bg==
X-CSE-MsgGUID: F3WpVUqnRyOJ48ZqjxzSwA==
X-IronPort-RemoteIP: 209.85.221.199
X-IronPort-MID: 364167163
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:lf7K8q1JWN28IuOFUvbD5Zhwkn2cJEfYwER7XKvMYLTBsI5bpz1Tz
 TRJD2nXPqvZZTP3KdslPNvi8kNVvJPSn9I3SFM4qSg9HnlHl5H5CIXCJC8cHc8zwu4v7q5Dx
 59DAjUVBJlsFhcwnj/0b/686yA6jfzVLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtH8CA6W0
 T/Ii5S31GSNhXgsYgr414rZ8Ekz5Kmo5mtC1rADTasjUGH2xiF94K03ePnZw0vQGuF8AuO8T
 uDf+7C1lkux1wstEN6sjoHgeUQMRLPIVSDW4paBc/H/6vTqjnVaPpcTbZLwW28O49m6t4kZJ
 OF2iHCFYVxB0psgOQgqe0Iw/ylWZcWq8VJcSJS1mZX7I0buKhMAzxjyZa2f0EJxFutfWAlzG
 fIkxD8lKUuGqOuX2bWHd/RAt84TffnhZds1tSQ1pd3ZJa5OrZHrRqzL4ZpG3251iJkfTLDRY
 M0WbTcpZxPFC/FNEg1PWdRuwaHy3CC5KmwJwL6WjfNfD2z7xQhh1rT3GNDIPNGGWK25m27D+
 D6foTugXEpy2Nq352G66kyRn+n1jATZBNIgDb+o5MV1qQjGroAUIFhMPbehmtGgh0ujHt5SN
 UEQ0iwpq6c06QqsVNaVYvGjiHuNvxpZRdkJVuNjuVDLxa3T7AKUQGMDS1atdeAbiSP/fhRyv
 nfhoj8jLWYHXGG9IZ5FyoqpkA==
IronPort-HdrOrdr: A9a23:YShBUatr0FvstRHXlezh9sPX7skDQtV00zEX/kB9WHVpm62j9v
 xG+c5xvyMc5wxhO03I9ersBED4ewK7yXct2/hpAV7AZmfbUQmTQL2KhLGKqwEJcUXFh5ZgPM
 xbHJSWZueRMbB35fyKgjVRHr4bsb66GKrBv5a6859jJTsaD51d0w==
X-Talos-CUID: 9a23:xOiRDGxnlK1lYdpFsyOsBgVTQcUKe1zEy0vtPmOJA1Y4eLfMEXWfrfY=
X-Talos-MUID: 9a23:XoStowUuBJsj0R/q/BG3uylcCd5u2bWJKhxdo4wEq9u/KgUlbg==
Received: from mail-vk1-f199.google.com ([209.85.221.199])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2024 00:07:23 -0400
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-4e135bbcf09so1362904e0c.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 21:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1716782842; x=1717387642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rmrrBkMtRPeIdIGVRuVDGZayuz0E+hH76slDUK5591s=;
 b=o+1Y/6Y+Ag1PKg3ODKeItJuhMdqm1aabF5g1AcfmLNzq1oaJ8rAFEiqfCDQgeiMGrV
 o5wFHjhqouVSXbgBESbPeZ7DZc5FO40jVdGpxWZReB4apQfyBzL9JLP4/qAGEpKBTv43
 g6kVNcsHkJaWaund//0RPg1yg3FWP1UA6RUXKIu7WNyw+A8u6lm5J2pEPcA799hW/7ce
 Biv4gxn7Nag5nlwbwVyxdtUrzXIjIiU+egFmvfoe2l7J32dYdT60rJ56jeIOvpu2a4G0
 kN6vkaU4VV8N4f1+ZQssX3PKagczXC75cXRr5oGf416gkcWyy9AzLwcHf+6rCjw20d/I
 p8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716782842; x=1717387642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rmrrBkMtRPeIdIGVRuVDGZayuz0E+hH76slDUK5591s=;
 b=SbG1JBGGhBeBNip/CPRe+KerhHZAOXg3HcJ7F4TQB8k/yTS7+eOMS/s4mmZU28YDXJ
 tM8cnwZkGSKEK3wlLI7eUaeOT6FhwmWVV9BcaYbh3nO1V0xtCUmL+4Qoe73blNOAunnD
 vOyDUqjO+aiicZ2U29NRjPGlrsfIMFyGyUt5I1QVmuKVrr05J3Vq5aRcX2YpFvq4Kt0R
 vkBRxkIYLlnDKmyA9scJTDfMakeq2EgiGq73Kmb9I4IumCGTfuozbZCLNva4C2jXXT1i
 PzDS1ZPuQDDQ62vCCSTo3kyDElEbJtYYhAjAhejMglTLwru1p0fn6JPHYk0dQPHPam08
 Xypw==
X-Gm-Message-State: AOJu0YzxBfAPjSw6cvxFTGXiPUhtFbPiGp7eVEuAidFaGvAHsKDpBNmr
 Chc5BB8YcdFiWrSpyqe+kFqmGtvDKh2sJxmunssXFYz8C9OgRqntPH8Axm0fxLp2EBjc8vEHdUZ
 fnsWsPvYbHcVoXX/Bc1RaWTANSL5QQaMasTpncXaTasVU9apKnTmqZU9+R0/BuBZBCiLWn04JdA
 ==
X-Received: by 2002:a67:bd14:0:b0:486:11ff:65b2 with SMTP id
 ada2fe7eead31-48a386a7023mr8088750137.29.1716782842068; 
 Sun, 26 May 2024 21:07:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2zoAOgkhNxshRVtVCuTpC0sph+X9P9JmdHwOkbhgTvQv3mxRERhGmlT8e7XyFR4kMu4V/xw==
X-Received: by 2002:a67:bd14:0:b0:486:11ff:65b2 with SMTP id
 ada2fe7eead31-48a386a7023mr8088703137.29.1716782840236; 
 Sun, 26 May 2024 21:07:20 -0700 (PDT)
Received: from mozz.bu.edu (pool-173-48-150-109.bstnma.fios.verizon.net.
 [173.48.150.109]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcdbc69sm268552785a.68.2024.05.26.21.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 21:07:19 -0700 (PDT)
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] fuzz: specify audiodev for usb-audio
Date: Mon, 27 May 2024 00:07:05 -0400
Message-ID: <20240527040711.311865-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.140.196; envelope-from=alxndr@bu.edu;
 helo=esa8.hc2706-39.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fixes test-failure on Fedora 40 CI.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/generic_fuzz_configs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
index 4d7c8ca4ec..ef0ad95712 100644
--- a/tests/qtest/fuzz/generic_fuzz_configs.h
+++ b/tests/qtest/fuzz/generic_fuzz_configs.h
@@ -150,7 +150,8 @@ const generic_fuzz_config predefined_configs[] = {
         "-chardev null,id=cd0 -chardev null,id=cd1 "
         "-device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid "
         "-device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1 "
-        "-device usb-tablet -device usb-wacom-tablet -device usb-audio",
+        "-device usb-tablet -device usb-wacom-tablet "
+        "-device usb-audio,audiodev=snd0 -audiodev none,id=snd0",
         .objects = "*usb* *uhci* *xhci*",
     },{
         .name = "pc-i440fx",
-- 
2.43.0


