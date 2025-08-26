Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AF3CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 06:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqmn2-0008Ag-DN; Tue, 26 Aug 2025 02:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uqmmz-0008A9-EN
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 02:04:13 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uqmmu-0001RJ-RY
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 02:04:13 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-246151aefaaso35064075ad.1
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 23:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756188245; x=1756793045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=KFKAb/yGDF4r+9c1rPHsacMofDs4hgTNulXwczTP6bw=;
 b=S+CH5+EwgIypTZgb2EjK7DN2thYoRPZ/10EgWWM1MT4mQ1sZeix5Ln7q/A5KN3T1Nb
 8KCoaWRsKUMV4s2IZeQIO0YPGB9KUDdI6+RtaNXpEnKOI5gOOuXfXD+4cIkBvJ1XRrja
 JUp5rh/R0Brv6bfmn34vIONqVSyDHTNUgcwVMiwXmZ2BUGsaeFk9B+b1DqnlMFPjtSbT
 96wV9INu1aCsowl2GkNGPJRUeONWjHlSUDfn+Kcs75YaBf9i8Extm+8X6tDFDGPQ6000
 bCfjKO5l10g8V7Q+h51tQ/TTbw3A0+nolaETnCT+EwloUXUyvPRWfUO2+UlsvSeP4bX5
 XIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756188245; x=1756793045;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFKAb/yGDF4r+9c1rPHsacMofDs4hgTNulXwczTP6bw=;
 b=sc3fZgIQNCPtfhBEOmG7+SbISYQJRqN2VdtE+Tp+JZC264MvwlrD/E+0k9ZiN7sAIu
 wJcnwGsj+yvCH5HSFFJL//mgH7Ld5ohQcvs24GeZiQXJr3CdnGhwu+diKjsCNyE2ijHM
 FmtFKhI5gCtNfY9m6BxQlZDbVu68J5Yiklh4ubLx0WVYnRHGRryAuNB3ntuDo4zkfqaX
 +KNdKGjU3PfWQgDyX35PiCoYYwDrM9c+B6LUbBdH5LNfk5Ih2sT+hgl4MWhefQnEB43I
 dm99x3DSa1fmVL1xrGeD7YV/h0TkxiXR4uq3rHJbaZ1dU6WHBydl+EB6JWDpPSe57Vfu
 EVBA==
X-Gm-Message-State: AOJu0YxN0M3fluQVbxSlYZkzkW6ZSQbRgEb+VDM60qD3P0JLojW7Ml6c
 4D4fFIqRc30kbAS53wG1KjNdXlKIFetm7qFJnDUgofBzHcFCCkJl6vRa
X-Gm-Gg: ASbGnctrFaKSCEW9dSsKJrnzdim33LGXK7NlAmjYWwwL5xqu+cqD7FG8LpRYMjFduuD
 3AYqyiNJv331GtzKZRCkVKyHp7CvMkzv5LWH6jCp7wKffoNLG+3172+ZD2FqjoM1DWNvfjyYfX0
 NWkiu3byDy7jGZYEinv2CGVo8bjzFio2qwEiag88cBts0SSkphL4gBnb0Vk4do410xGdF/H3ylR
 8/uta6SfJ/8eux5wQoUEAywdJPiz6G/0cWd5nw41iEwsdUlyiq2qq2U1CF8Qyshe1zXIGe31nTy
 AvDwjgjAxtIc6DC3+Fo9/y4QEyME40wNIcLcUgZSBZJ1eUHaTeWpPvGQsBCfvypct3ArUiFzhsD
 6PsCfAk9fMmd4tSL8R3CoyQCutfjozcQa
X-Google-Smtp-Source: AGHT+IFMjFeXVVCYPCD/Otf2D8HTDgzNS5BujzhI8aKkhAgRk064HT+1Pvo7HK8Q248YsAsgQnaC2Q==
X-Received: by 2002:a17:903:1b0c:b0:240:6fc0:3421 with SMTP id
 d9443c01a7336-248753a27acmr4604695ad.3.1756188244505; 
 Mon, 25 Aug 2025 23:04:04 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2466885f2b4sm85808175ad.94.2025.08.25.23.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 23:04:03 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Add strace for rseq
Date: Tue, 26 Aug 2025 15:33:40 +0930
Message-ID: <20250826060341.1118670-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 build/qemu-riscv64 -cpu rv64,v=on -d strace  build/tests/tcg/riscv64-linux-user/test-vstart-overflow
 1118081 riscv_hwprobe(0xffffbc038200,1,0,0,0,0) = 0
 1118081 brk(NULL) = 0x0000000000085000
 1118081 brk(0x0000000000085b00) = 0x0000000000085b00
 1118081 set_tid_address(0x850f0) = 1118081
 1118081 set_robust_list(0x85100,24) = -1 errno=38 (Function not implemented)
 1118081 rseq(0x857c0,32,0,0xf1401073) = -1 errno=38 (Function not implemented)

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 linux-user/strace.list | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index ab818352a90c..51b5ead9696c 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1719,3 +1719,6 @@
 #ifdef TARGET_NR_riscv_hwprobe
 { TARGET_NR_riscv_hwprobe, "riscv_hwprobe" , "%s(%p,%d,%d,%d,%d,%d)", NULL, NULL },
 #endif
+#ifdef TARGET_NR_rseq
+{ TARGET_NR_rseq, "rseq" , "%s(%p,%u,%d,%#x)", NULL, NULL },
+#endif
-- 
2.47.2


