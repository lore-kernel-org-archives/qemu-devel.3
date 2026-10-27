Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F14606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d4yBSzhK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLagS-0002DB-9q; Tue, 27 Oct 2026 02:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagJ-00021A-5j
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:11 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagG-0008BW-VR
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:10 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cd3310348d2so261984a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082548; x=1793687348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LXzkCZpV6bqmoObK6Cvt8+obfwm+PZhfAab9OJZFDhA=;
 b=d4yBSzhKctew/2K80EX+d+eCnMR8N6kWqUn8gG80ZNXmPBzNAr9MqASn3LJ6cBgyxs
 CRdDuMIyoyjxpRlltraEv/Obgosue7LX6qbyp7GygoucM+cTMWMWIiekqPH1+loWn8bl
 9UjUcKzNcyBOWqP6UYjfd4UuPLtsmSNZzcO/ADGXPCJHAjXw9Eio3nS/gd7cnhKBSM4e
 t2zMAalehRoRmVF7pFHbJDzQrkGZ8bI4e41wSXziyM82D/nF/EjWH6hQZjfzBHJPjiP1
 vG49eHtSunfFUJNiJEYCPv1BvLVJrH3L8EbE07e7Xj3vASO4Q+vQAsPI+k9sib7TyhWh
 7yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082548; x=1793687348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LXzkCZpV6bqmoObK6Cvt8+obfwm+PZhfAab9OJZFDhA=;
 b=V2eqpTrMS7+a6f0XIHrz5GlaPcqZ/7R//YuKZPFxiwP36pNj/gFD7tQnmcm8JWFahX
 uVLEthwMsnOzM9GzEMapqrD45IQzliN1R0NDaapZJTawRIY8bJ3gRtOxW+L05Qm/p7Ri
 33qCZfTMlQ6VxQUYpKYITkKYpyBOxiPpZM9HhKl8n65nyGKtRedFl4fHFbXMx90QHGZy
 xCsAv7Lozo1Oy05uCW7kBCuIchuWQ7Z2N66kRDF21AU697Q5hxpaeRiA8FPt9cQMM9VR
 pPS7Q5n2vyprBU2BM4WMT1nfSw0BrYIB36MCFrNNgC+FRqSOW/NmLY82sCtL3pb7eSPY
 lFeg==
X-Gm-Message-State: AFq9FYKFnI2GQ+zRe0IE96tfnE2ZaCBJH3bz0o1NdGR6tJVeIgX5qEPR
 ZrDYlXHSX3WQ22hdumUavX42KF1wkQx9jYldwtmV/NWG314qpjNZiCXa7ZaGYQ==
X-Gm-Gg: AYBFou2sxjHP7gIQASN4RJd3iGRKRewB4d0DtKQby/0iMi62z6Ky8Z0b8ri1W+k0VAZ
 K11hFJ2spvoGRysmX2AANCM+iuMtLyQJ07GuN1IpnzTdx0UrOrzDf7MwqA4TklDbdwEsXKTc+Qo
 zMdm1k8HspYs8jlv9SXyGArLZaoxVHuQqdb/PswiPgtT/gqYnb4m5iYEhK+HEepdYTCuy8m4g0r
 Jv0sp28Nj65OqPI5bX3Pgr4V/gPDnbwg1Nx5UtEHmp2zFmERZbebgBvQONUtLNWpGQkfx0e0hmR
 eANrOrMdeC6b+HVIQLfPkO8eDnTKxcSRbbmpib5rc4pjB5UnVb8+8bcviAbu7gWYPZz95zMSzsh
 g7jsxHWVklNOZnZkWpswjep6ogc7b8lcyJtZ4aOKf9IivsM0rBq1Uk+O4gkSYJ8acPcDDMBkNvr
 TYtq0KJ5kg9doOvKgaKIrprdgEhfE30B3Uenf9TiSXq+Y0CTm6lb4iF2asAKcnHUXhUi9LG14vM
 ThFqOUQwZdEu5zYPQ3IeoM4FEuatISeUTGdqrA8lIoMCa72dHKU7Uswn3X0uXXow/aK/EarVV9X
 apFbYMNYitLvTFs1LWjG5QzzptdrMuNAUv2G/axeubgPTMI=
X-Received: by 2002:a17:90b:1b0e:b0:3a4:9416:a2f8 with SMTP id
 98e67ed59e1d1-3ae403dd71fmr1124509a91.9.1793082547597; 
 Mon, 26 Oct 2026 23:29:07 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:07 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tao Ding <dingtaodtdt@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, Tao Ding <dingtao0430@163.com>
Subject: [PULL 13/29] qtest: fix k230_decomp_gzip test integer handling issues
Date: Tue, 27 Oct 2026 16:27:52 +1000
Message-ID: <20261027062808.1995205-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tao Ding <dingtaodtdt@gmail.com>

Cast slot to hwaddr before multiplication to prevent 32-bit overflow when
calculating the SRAM input address.

Resolves: Coverity CID 1685516

Reported-by: Alistair Francis <Alistair.Francis@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
Message-ID: <20261018141006.16398-5-dingtao0430@163.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/k230-decomp-gzip-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/k230-decomp-gzip-test.c b/tests/qtest/k230-decomp-gzip-test.c
index e80113fd28b3..249c8ae82cef 100644
--- a/tests/qtest/k230-decomp-gzip-test.c
+++ b/tests/qtest/k230-decomp-gzip-test.c
@@ -46,7 +46,7 @@ static inline hwaddr k230_sram_addr(hwaddr off)
 static inline hwaddr k230_sram_input_addr(unsigned int slot)
 {
     return k230_sram_addr(K230_DECOMP_GZIP_SRAM_IN_BASE +
-                          slot * K230_DECOMP_GZIP_BLOCK_SIZE);
+                          (hwaddr) slot * K230_DECOMP_GZIP_BLOCK_SIZE);
 }
 
 /*
-- 
2.55.0


