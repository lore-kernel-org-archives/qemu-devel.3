Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A8606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fdhprTkG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJeP-0006if-IZ; Fri, 23 Oct 2026 14:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeL-0006f0-61
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:53 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeJ-0004YN-9Z
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:52 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso821238f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792778750; x=1793383550; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZVPlNFpe92Khx9HLWBieKWnx7EUQQdvDo91S3GrHQ48=;
 b=fdhprTkGYdONU7y5yCG41ZUNtEgtybLciWnIcAHYLLeXrZaox9pKWCLAWNkXKCjFYC
 s/cyBGf0O561j5L9KhC6DJ9vvqr8wLjncW3ZNubCRai+x2Auc6Qj+ZP6TUGwWBydC5Te
 JV2DFeVMos4H1PsCDqCvts3ejvRHfGJNok3Ds9khkTYt3+1LJsNNALzPDvwPV2TtgxZG
 r+Q7s3GQ0qlBx5oO8H+ApzV5CZ+SIloBg9n8YK9l14+iBIrZiWBbRg354xaIaswcXmRD
 DLbtbqg70F4afEofmdY3THDKYSm0B6mJLyNtZ7EqSRrJcmeFdoXpfMWqjHECXtXk5fIl
 H8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792778750; x=1793383550;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZVPlNFpe92Khx9HLWBieKWnx7EUQQdvDo91S3GrHQ48=;
 b=tI71KAjNqxWnEIFuq6GU0eIFdgPznmk7s4eNNREho9wzuZmM1GmnfzqaGXhBUM19cG
 QwqX7vhR5w++ODMPlAbxBlyvHqw0AG8pvV97Jw50ktzw2Dn4bpgHCylEBMWss/huToER
 Xclvsu9kU2aSPrlrXapYOTjdCrQdPvGws+2Ab6qvSf8WQ2ZNRaooNR9Ne05mdCLvsu79
 kBmre8OKJ1E6m/rz/ZddbL3+1B8SjU+GOxJxHu0EA59uEccs7O1DBpw92Ha4pgCJxpTp
 JhMe6qb46MxzmgbH2gQ65oT7VX2n7GRtvl8OhC+rn6lRpPrWBaVbGEAb+AubcPcOWiiX
 eDYA==
X-Gm-Message-State: AFq9FYKpTZzwfYxeORAXQCAMnau9ZMf994H/nY2Xqd3DYzpSThXVmsja
 jTke8GE2BpANg3NfypCERrxcBnTxZ/vR2iLpVXEcMhqvJQ8y5KdYwoKNbmdG4jUXMNo=
X-Gm-Gg: AYBFou1hWQpSCV/pyclpRcnde1S+bZWaqemWXPl3JvqYPVpKjVdmwHxScdgxH3slWQZ
 nDklCxl7eL9/ifu/Q+CapiwBpYqoLGgi3P6PK6niz1DPJOql4t2Mn/JaOPOtmP5xyKJr/hqmP8D
 lv0GEn43iq1qRQKWfpSzkQIGUu09wnb19q3ynQ/Tg75i/SkeVNk0kzGBOv8wbIx03mYFf2kDfKn
 ItfP4Fg7RbEnNoipFEAsb7OBjdcJ1NTU8ZUcKv9ipFVhzlE3Er7Xqi4qBQ1GaKrzTvwakDwsZFL
 KAcI9ujO5LqsblHuM4Y62jEPdPibcl8HhvhQ4VB8ikfFXP/wF1BBwhNk3Xoh8ZwpBEKV5gg0DuJ
 KztzoZQ8RwUDEXJPxFpJ5+PIhtw1s3fjk8N/TPODm7uzU0gQtRcsdDLJ/792bf3Vq6gUYEYSXLB
 6CFSGeEXbvtGBAb0ESm2FK0JtfN5j1oVzQoH5q9ylF0Sq+sq417jrQh832KdeNu/+SlGNpGbFHf
 4/38prlMEuEl2lW+ulZ3YAPlFeUwC2PW7gtf60PqY94UjC/IhZN43EKN2mg0NOLdMNlp6dXB8zE
X-Received: by 2002:a05:6000:4382:b0:48e:38e:3102 with SMTP id
 ffacd0b85a97d-48e3859af6dmr5668074f8f.29.1792778749898; 
 Fri, 23 Oct 2026 11:05:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3ee6d8sm1241629f8f.14.2026.10.23.11.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:05:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CFDAC610CB;
 Fri, 23 Oct 2026 19:05:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 13/19] tests/functional: add tuxrun kvm gdb test for x86_64
Date: Fri, 23 Oct 2026 19:05:31 +0100
Message-ID: <20261023180539.1574134-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023180539.1574134-1-alex.bennee@linaro.org>
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

With all the bits in place we can now exercise the KVM gdb interfaces.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261019192704.3220373-14-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/x86_64/test_tuxrun.py b/tests/functional/x86_64/test_tuxrun.py
index 026b373accb..1a1138d16ae 100755
--- a/tests/functional/x86_64/test_tuxrun.py
+++ b/tests/functional/x86_64/test_tuxrun.py
@@ -11,7 +11,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import Asset
+from qemu_test import Asset, skipIfMissingEnv
 from qemu_test.tuxruntest import TuxRunBaselineTest
 
 class TuxRunX86Test(TuxRunBaselineTest):
@@ -19,6 +19,9 @@ class TuxRunX86Test(TuxRunBaselineTest):
     ASSET_X86_64_KERNEL = Asset(
         'https://storage.tuxboot.com/kernels/6.18.54/x86_64/bzImage',
         '24a3ade610c2cc426ff821050de8a35930b0371357d94cc2c334abac6658552b')
+    ASSET_X86_64_VMLINUX = Asset(
+        'https://storage.tuxboot.com/kernels/6.18.54/x86_64/vmlinux.xz',
+        '77bf44cca48c9c1b9c142e16a2311d58b8ae3462b61bce44bcaf9243b5f26628')
     ASSET_X86_64_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20260924/x86_64/rootfs.ext4.zst',
         '8e310455b0244414ccff29c507f7ccfd4032e3587cc405e49ab0322738e3e27c')
@@ -47,5 +50,20 @@ def test_x86_64_kvm(self):
                            drive="driver=ide-hd,bus=ide.0,unit=0",
                            accel="kvm")
 
+    @skipIfMissingEnv("QEMU_TEST_GDB")
+    def test_x86_64_kvm_gdb(self):
+        self.require_accelerator("kvm")
+
+        self.set_machine('q35')
+        self.cpu="Nehalem"
+        self.root='sda'
+        self.wait_for_shutdown=False
+        self.common_tuxrun_gdb(kernel_asset=self.ASSET_X86_64_KERNEL,
+                               vmlinux_asset=self.ASSET_X86_64_VMLINUX,
+                               rootfs_asset=self.ASSET_X86_64_ROOTFS,
+                               drive="driver=ide-hd,bus=ide.0,unit=0",
+                               accel="kvm")
+
+
 if __name__ == '__main__':
     TuxRunBaselineTest.main()
-- 
2.47.3


