Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8266B606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=P+rOlg9O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWab7-0000BZ-7X; Thu, 26 Nov 2026 09:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWaaF-0007h3-Er
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:36:24 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWaa8-0001i9-Js
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:36:23 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so91497375e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 06:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795703775; x=1796308575; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eEscgXF99ld8shnMdvdJBGyWeRugvNpmyFH04KfioNQ=;
 b=P+rOlg9OVIR9AWiVYh9yr7++yb1hvzt0WhfLRazJOz4cu4P669C62PPap1iF3mwgJR
 iR9DPGy4hl3pvqT6p4mMT5nB/twDcy+Ll8INXuLejA+ewdGpCf9PciUoRhdJhL5/M0hY
 CeV83E/WSpC6qNKHpsI8rMvLLH2OLX89lEr7gZQ5HBf+p28Cjn1S1qCkMNtQtJdvhRkX
 ADtjp3F4/vRXcQNVnVWb8EH+uhkvvlBaTsqmGA1UERnHrvcLOvuFeHobOhhyebF42pdN
 SYjJubY0i6v3kkXwZiL5jyT8w+FvcTXEF0nY5dag2b2krGFGAtn8Xrxe9yVJy0T1p0jd
 /VqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703775; x=1796308575;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eEscgXF99ld8shnMdvdJBGyWeRugvNpmyFH04KfioNQ=;
 b=Y4GcS3whWMUh1D0juF8A2ahjqiRta9pvzKQvrU2Lki57LOiTeJS9lNuCVEnnnGt0vY
 dpW6kzK8VduNXUKqqvD5Lkfzcps6G3qK+r+/kqdGPG4ok/Okm2W8lYsvsdJ1VrzV2DnO
 1ssLnQ8ZlSEUGjgDJZhPAavgfegwB60PaZ15vJ1Oc5IW7ynObx9FkCfiL0uI+qS7iOUE
 7AZJETszKMKMHuvMY9G9GKY9nJdSgw4/FpN/rVSDQGbt/+JCDvA9z7+jLpp+ab+qq0f3
 oo9eT2SLlLKPPc8n+hSxeW5HPZ8mjEcAq73jDvEFGpHeYndRxoG9We+AayDI3q53oEzT
 iqvw==
X-Gm-Message-State: APuU4Z+VvFMGZUALgA8B17KwQ6RsCsFw/JGkvg1T+v5eAuHdvxS7sltN
 AcgQyVGQvJa/yop1pCUCeBEyKTP9cGaGgFVubcLH14MjQ3SssqSboQ2XFbqNmOf8uSQ=
X-Gm-Gg: AZFdTZdUl6MGmsD6uHg5f8eQxcCJC0iFIkIt47v+HAWMTY5ibUYHefjafb92HOhmZik
 6CpjfVKcDQrAnOTcAYNDmLQDdqbI0S7X65qD7971AHOdVQlqJgDZmfiryPtbv2b/wt360XPPrTV
 SevPLbG/zPtl8iTyxVGegu1CD1Lum3b2nc0Jh7zq45SZ7s2OxWzuNaAou06qrsXz56G0/OIp3lL
 K3fIlLsm6KG8Xs7oXNU5TZqfAbec+TyL4Ft3P+WptUFqXP1MC1rcrmP3bHSkLnq7ynbNM4IsjCd
 nfq26+tZ+f8foW5ju5z7dhtUC5RsqwYvoiZeVNpwG6LK+vmQbSt536Uj1l3b0MOZ84xuaPBNA+8
 cgaGL9h/4fKA9la1gDCDocOA56XceXkN6pOZyrV/Rpv35ciTygRZw62bzljhRBUDOb2FWyKI+5B
 d2i63hWwNEKISOYEPCGZuEuYKQXKV+eMc7/ld/gHYwPMSNXjPKh27/L+Ilgl9owjR0XFp7liNzB
 /O10LZbCkQJrktu/lzKIPIvte1CH7KMkTQBWZRDBtGodSmIIBngD5hzi48EMorufTX2111jLubS
 QmwX9TfnaqeuuGuHmt9HCX6vUYHK
X-Received: by 2002:a05:600c:6749:b0:4bb:5d38:259f with SMTP id
 5b1f17b1804b1-4bb8881099cmr409445515e9.12.1795703774997; 
 Thu, 26 Nov 2026 06:36:14 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906640a2sm340780515e9.0.2026.11.26.06.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:36:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F225B5FA55;
 Thu, 26 Nov 2026 14:36:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-riscv@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Chao Liu <chao.liu@processmission.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Ellerman <mpe@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 5/8] tests/functional: use immutable tuxboot kernel URLs
Date: Thu, 26 Nov 2026 14:36:04 +0000
Message-ID: <20261126143607.2374676-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261126143607.2374676-1-alex.bennee@linaro.org>
References: <20261126143607.2374676-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

tuxboot rebuilds the 6.18.54 kernel images in place, so the URLs
without a datestamp now serve content that does not match the recorded
hashes and the tuxrun tests fail to fetch their assets. Point the
x86_64, arm64 and s390 tests at the immutable 20260930 snapshots and
keep the hashes that were recorded against them, instead of implicitly
switching to the rebuilt images.

Do the same for the riscv64 6.11.9 kernel assets, which still used
non-datestamped URLs; their recorded hashes already match the 20241122
snapshot.

Fixes: 8ac1aab21fca ("tests/functional: update arm64 tuxrun images")
Fixes: 09961fafc5a0 ("tests/functional: update s390x tuxrun images")
Fixes: 467c9eb7dd31 ("tests/functional: update x86_64 tuxrun images")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20261112133320.418012-2-marcandre.lureau@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/aarch64/test_tuxrun.py      | 4 ++--
 tests/functional/riscv64/test_milkv_duo.py   | 4 ++--
 tests/functional/riscv64/test_tt_atlantis.py | 2 +-
 tests/functional/riscv64/test_tuxrun.py      | 2 +-
 tests/functional/s390x/test_tuxrun.py        | 4 ++--
 tests/functional/x86_64/test_tuxrun.py       | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/functional/aarch64/test_tuxrun.py b/tests/functional/aarch64/test_tuxrun.py
index 2ff321582d3..035984d8e3e 100755
--- a/tests/functional/aarch64/test_tuxrun.py
+++ b/tests/functional/aarch64/test_tuxrun.py
@@ -17,10 +17,10 @@
 class TuxRunAarch64Test(TuxRunBaselineTest):
 
     ASSET_ARM64_KERNEL = Asset(
-        'https://storage.tuxboot.com/kernels/6.18.54/arm64/Image.gz',
+        'https://storage.tuxboot.com/kernels/20260930/6.18.54/arm64/Image.gz',
         '39f4633bbcb444267d4d829bd28d8868a287c4c160cda64b0fd23fb090571c4e')
     ASSET_ARM64_VMLINUX = Asset(
-        'https://storage.tuxboot.com/kernels/6.18.54/arm64/vmlinux.xz',
+        'https://storage.tuxboot.com/kernels/20260930/6.18.54/arm64/vmlinux.xz',
         '6487eb113ef6e841aedab6cb6fa704006377d68f64dd544570aa42f462a52b85')
     ASSET_ARM64_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20260924/arm64/rootfs.ext4.zst',
diff --git a/tests/functional/riscv64/test_milkv_duo.py b/tests/functional/riscv64/test_milkv_duo.py
index 6a7e2a5d196..fdc83d7c828 100755
--- a/tests/functional/riscv64/test_milkv_duo.py
+++ b/tests/functional/riscv64/test_milkv_duo.py
@@ -14,11 +14,11 @@ class MilkvDuoMachine(LinuxKernelTest):
     timeout = 120
 
     ASSET_KERNEL = Asset(
-        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
+        'https://storage.tuxboot.com/kernels/20241122/6.11.9/riscv64/Image',
         '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0'
     )
     ASSET_DTBS = Asset(
-        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/dtbs.tar.xz',
+        'https://storage.tuxboot.com/kernels/20241122/6.11.9/riscv64/dtbs.tar.xz',
         '97e5e65a7e6c68303e53486af120c0846ee8df572e9c15f0c4dccb831d0cef4b'
     )
     ASSET_ROOTFS = Asset(
diff --git a/tests/functional/riscv64/test_tt_atlantis.py b/tests/functional/riscv64/test_tt_atlantis.py
index 48abd5cd27c..7cd5234432d 100755
--- a/tests/functional/riscv64/test_tt_atlantis.py
+++ b/tests/functional/riscv64/test_tt_atlantis.py
@@ -14,7 +14,7 @@
 class TTAtlantis(LinuxKernelTest):
 
     ASSET_KERNEL = Asset(
-        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
+        'https://storage.tuxboot.com/kernels/20241122/6.11.9/riscv64/Image',
         '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0')
     ASSET_ROOTFS = Asset(
         ('https://github.com/groeck/linux-build-test/raw/'
diff --git a/tests/functional/riscv64/test_tuxrun.py b/tests/functional/riscv64/test_tuxrun.py
index 6203a45060c..b470c05300a 100755
--- a/tests/functional/riscv64/test_tuxrun.py
+++ b/tests/functional/riscv64/test_tuxrun.py
@@ -17,7 +17,7 @@
 class TuxRunRiscV64Test(TuxRunBaselineTest):
 
     ASSET_RISCV64_KERNEL = Asset(
-        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
+        'https://storage.tuxboot.com/kernels/20241122/6.11.9/riscv64/Image',
         '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0')
     ASSET_RISCV64_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20241119/riscv64/rootfs.ext4.zst',
diff --git a/tests/functional/s390x/test_tuxrun.py b/tests/functional/s390x/test_tuxrun.py
index 1dd662aaaf0..420e7146bb1 100755
--- a/tests/functional/s390x/test_tuxrun.py
+++ b/tests/functional/s390x/test_tuxrun.py
@@ -17,10 +17,10 @@
 class TuxRunS390xTest(TuxRunBaselineTest):
 
     ASSET_S390X_KERNEL = Asset(
-        'https://storage.tuxboot.com/kernels/6.18.54/s390/bzImage',
+        'https://storage.tuxboot.com/kernels/20260930/6.18.54/s390/bzImage',
         '5efeb31754b211440e1595ab11355bb006fe78a2c0604ed0a8c55c4598b71aec')
     ASSET_S390X_VMLINUX = Asset(
-        'https://storage.tuxboot.com/kernels/6.18.54/s390/vmlinux.xz',
+        'https://storage.tuxboot.com/kernels/20260930/6.18.54/s390/vmlinux.xz',
         '5bbd4d34e0950f88053a9bfd16078896df4b1ee1696fc2ad62488e681a6bdd8e')
     ASSET_S390X_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20260924/s390/rootfs.ext4.zst',
diff --git a/tests/functional/x86_64/test_tuxrun.py b/tests/functional/x86_64/test_tuxrun.py
index 1a1138d16ae..d2e6008ae70 100755
--- a/tests/functional/x86_64/test_tuxrun.py
+++ b/tests/functional/x86_64/test_tuxrun.py
@@ -17,10 +17,10 @@
 class TuxRunX86Test(TuxRunBaselineTest):
 
     ASSET_X86_64_KERNEL = Asset(
-        'https://storage.tuxboot.com/kernels/6.18.54/x86_64/bzImage',
+        'https://storage.tuxboot.com/kernels/20260930/6.18.54/x86_64/bzImage',
         '24a3ade610c2cc426ff821050de8a35930b0371357d94cc2c334abac6658552b')
     ASSET_X86_64_VMLINUX = Asset(
-        'https://storage.tuxboot.com/kernels/6.18.54/x86_64/vmlinux.xz',
+        'https://storage.tuxboot.com/kernels/20260930/6.18.54/x86_64/vmlinux.xz',
         '77bf44cca48c9c1b9c142e16a2311d58b8ae3462b61bce44bcaf9243b5f26628')
     ASSET_X86_64_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20260924/x86_64/rootfs.ext4.zst',
-- 
2.47.3


