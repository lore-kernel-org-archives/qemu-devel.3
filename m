Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822D2C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXu8-0003hR-7Z; Fri, 23 Feb 2024 10:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXhj-0004oi-8p; Fri, 23 Feb 2024 10:43:15 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXhf-000655-MH; Fri, 23 Feb 2024 10:43:14 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dc49b00bdbso8035985ad.3; 
 Fri, 23 Feb 2024 07:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708702990; x=1709307790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EbqCxehm0a8dcFpNHIyygMku+fKTrkl8BbyDwKaDinw=;
 b=lchO0CkdiZI2lSBOvFfUCN8kdOzqwGRxv1+tEPH6/oaCIbGHM19a3yMfUZ+5TFCE86
 9v3GslyzUJLXiUuMaQuX5P2lUqbghUqKgz10S4slsvgngsqL9gDPiGlRsnSAANmCDxDb
 48NHemEeHBWxMAAPnz2OzHfKmhlPGVL3+4AHCj9upeDiWTAnnOfHiwZ07CHFRrFOLt16
 e+pKwXxe0UCFePKx/C5C1E9bDsiKqusDvc/+zw2a6hYXaSnGfFmnZw/DW+PoP4vWregU
 tf6+Q5i7CQ/ZvX/tVimihAjtXzpkXHwBpIqdARlkrT02AcvzY/iOd651W543uPvGS/Tj
 4spA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708702990; x=1709307790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EbqCxehm0a8dcFpNHIyygMku+fKTrkl8BbyDwKaDinw=;
 b=SpP9yainQgJxcGUVz6li2eLtmV90Z3lbT22jvtpnpwplUKcO7ryCNgP1tsPKi4PslH
 0EvWNTukRq2UvCEX9t5aXQ9aieLqs5LYFVQp6QirCN12lejDAfVXKku3J+u8ZWKpTBEW
 BlLQF4VG1MktQFrh/7GHlDFO2toAGed5XOEFS0XusyOXENs26jowaIPkxpAvt9RFnvoa
 xPXJ/nAXhA+t7aESqnfVaeoMlbp5xcUolOomSXMAAvcaaNLRCpzLSK8XP6J+8m4BRlwt
 5bwhL7C+gqbqBKV/wLJlxidw8iCJAcmRrbBbx1E2kfMqPhvZhXX+XjGZ0pw/JmFLRY9u
 yKsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU66DlEWkDd5aWu/LL4CYvGS2/MlVAtuQP+f2banDeCGS+Cbmd+MUrkXV5bqA/V3z5vgv3ZYChV76/fowwA1rh81bD
X-Gm-Message-State: AOJu0YxiICrGcvRN2II5PUUXzjFNE1HzNADcDbTjgYNY/mte4BYmNhf/
 KUR3kIKfK+f+f9VCWzAG1XqVmXXGy4Pk/7J1pFPI1xvMDvZP2DiDim77wE0l
X-Google-Smtp-Source: AGHT+IFTETRb627SrVBa2l0sr9u7KSrcjmro7J1PyLWCSQaWwBbNdOjux+ykKWwct90NMHZ5qEIwFw==
X-Received: by 2002:a17:902:c943:b0:1db:916e:d77a with SMTP id
 i3-20020a170902c94300b001db916ed77amr192679pla.2.1708702990032; 
 Fri, 23 Feb 2024 07:43:10 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:43:09 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 05/47] tests/avocado: ppc add powernv10 boot_linux_console test
Date: Sat, 24 Feb 2024 01:41:24 +1000
Message-ID: <20240223154211.1001692-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add test for POWER10.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/boot_linux_console.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index af104fff1c..a00202df3c 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -1387,6 +1387,14 @@ def test_ppc_powernv9(self):
         """
         self.do_test_ppc64_powernv('P9')
 
+    def test_ppc_powernv10(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv10
+        :avocado: tags=accel:tcg
+        """
+        self.do_test_ppc64_powernv('P10')
+
     def test_ppc_g3beige(self):
         """
         :avocado: tags=arch:ppc
-- 
2.42.0


