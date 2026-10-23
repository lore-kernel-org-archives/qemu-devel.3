Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA10606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YlCUI0/H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJeL-0006ep-Dh; Fri, 23 Oct 2026 14:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeF-0006aJ-TG
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:47 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeE-0004We-4L
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:47 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso11413975e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792778744; x=1793383544; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WScyW62PqyKcF/Nf0syxYjkj/86hjQh8UnhI40MeJAk=;
 b=YlCUI0/HsUq5nFHCvYKsgNO9LZPrJYplhH94sXbNdrYFFc6Hg64MTQurSrz8ZTt7zO
 Mn0pYMvhtw9MMxDIRICEZ9EBzq2omone3FZWumNAFGyGtYB2j9yFNbwSinqRO3n0/HSt
 4GIBzQE3j1cQyHBZqJsSrmKQXWEbSGsj6g1mEnzovJs4DsZz03DgM5bITR3oaP246UWJ
 Zhqbjguj7UgYWaifOVbik8Yj9tonnWJ6Wm38I6F2b3teGTTCW0v4P9RBBbKfooGcZRMo
 Sf0o2YBgNZJ1Skq418CpY9WMHXythd9a+9255QwPehmcMimIHCGWy1AcsYGI1+M42JR6
 7M6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792778744; x=1793383544;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WScyW62PqyKcF/Nf0syxYjkj/86hjQh8UnhI40MeJAk=;
 b=AL19gglmGKp2dY+KgLGqgDxruS/joJ8Md8OnrOP5KZRbl2zlP1j8zXDZNQbajkBhKf
 HZNgNqBvthVP8nm1qoF3F+ciFIKtQ4D562TQc9MD4tbdDIXkXv1XXOvBWWu/zo0dQAPk
 7YlXWmvusmVAfUPNGuHXkXDoqEL82IYwULpv4VDRFEhZqfjJqERUMtdAns94S+WTID+w
 wrT/PBn5BF8QwPYM/VjxKzG3aJze1Wmb3fUVEB13ysu7Aheqe/jYGnnWH2MKXdry8Iqo
 fHI0e+yy9Gxf58Japj2/guRtPPC14ePVCme/GkAEAgiHkTDY+JD5Euv48fqOQ6CbEPrc
 QbxA==
X-Gm-Message-State: AFq9FYKzquznETSGgqpR8YeTQfxFbKiCh6pwDBSTkJS0TKvsDZdu9hcp
 1JTvmVuzvNfKoP5f6lZLZl+fbzIOMmv4lAgaSEyStn2ClqLlWfvpIACT0XvKSu9LhU0=
X-Gm-Gg: AYBFou3VWPior/H8pZJNgEjVrtclWi7C1LP49oOZx3txrs8FTTfNMiO1To7YMiG5Dxu
 ZDtuRNlJBlsWClwX46oCef/pBlHfrWoJ/RBk4AfdQuq2PiQD93EPSm58sqjzBEKc/nEAuP6ElR0
 pbH4YgL0bFK82nJ+Wgv+C6bRt45S1bPod/khrGSGqAWDkCkseRf/6sfMnHzb/wjxkg4R5/RLu7Q
 X20u69krJUb1nCWcETTd22ETThygu2AfRN9gVHtWRdkEEA3RKqgrcPNUHBen66sXOZIVlFV8aBG
 kCEcDX1RTodh1M59YMcB7Vsw+FIMGDRMqW2itntn7TNhOnh1r4z7jtLueC/1XTdtjndM96bN/7q
 4VnKonqz8OVLCMRn+ipUgcMo7Z3vFLy7WuZ3GGeGl5bn5+kR0bD8RZE4sN0sl5kwhnGWYnh79C5
 3W1YKdBGtMI57JuYC+EnukMRmm1xsQVeEezWLgBq5+VNU8YYgL0QMO0WmdBmaNfvQKezaX49Ihc
 EwM8hENsbVkqPZvrY2fRM/WdJ0v/5yZCVZWVDmDb2Wu7yJsGmz6VNpC
X-Received: by 2002:a05:600c:34c7:b0:4a1:f99e:f22d with SMTP id
 5b1f17b1804b1-4a211c9de3bmr54879135e9.6.1792778744154; 
 Fri, 23 Oct 2026 11:05:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a312fb9b90sm17842395e9.4.2026.10.23.11.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:05:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0BFCF60A9E;
 Fri, 23 Oct 2026 19:05:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/19] tests/functional: split x86_64 tuxrun into tcg and kvm
 run
Date: Fri, 23 Oct 2026 19:05:24 +0100
Message-ID: <20261023180539.1574134-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023180539.1574134-1-alex.bennee@linaro.org>
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an explicit "kvm" run to the tuxrun tests. Although running on an
x86_64 host would probably have defaulted to "kvm" anyway we want to
exercise specific features later.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261019192704.3220373-7-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/x86_64/test_tuxrun.py b/tests/functional/x86_64/test_tuxrun.py
index fcbc62b1b0f..729f6447d05 100755
--- a/tests/functional/x86_64/test_tuxrun.py
+++ b/tests/functional/x86_64/test_tuxrun.py
@@ -24,13 +24,28 @@ class TuxRunX86Test(TuxRunBaselineTest):
         '4b8b2a99117519c5290e1202cb36eb6c7aaba92b357b5160f5970cf5fb78a751')
 
     def test_x86_64(self):
+        self.require_accelerator("tcg")
+
+        self.set_machine('q35')
+        self.cpu="Nehalem"
+        self.root='sda'
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_X86_64_KERNEL,
+                           rootfs_asset=self.ASSET_X86_64_ROOTFS,
+                           drive="driver=ide-hd,bus=ide.0,unit=0",
+                           accel="tcg")
+
+    def test_x86_64_kvm(self):
+        self.require_accelerator("kvm")
+
         self.set_machine('q35')
         self.cpu="Nehalem"
         self.root='sda'
         self.wait_for_shutdown=False
         self.common_tuxrun(kernel_asset=self.ASSET_X86_64_KERNEL,
                            rootfs_asset=self.ASSET_X86_64_ROOTFS,
-                           drive="driver=ide-hd,bus=ide.0,unit=0")
+                           drive="driver=ide-hd,bus=ide.0,unit=0",
+                           accel="kvm")
 
 if __name__ == '__main__':
     TuxRunBaselineTest.main()
-- 
2.47.3


