Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679BF606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fo+1H96n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIt41-0004UB-UY; Mon, 19 Oct 2026 15:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIt1E-0000bm-5F
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:27:36 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIt1B-0003Bv-B9
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:27:35 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a01933b584so17760975e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 12:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792438052; x=1793042852; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0EjCsLzxCc6Z1J6Avt4waW7BwoDGH1cC4bpSsprV0z0=;
 b=fo+1H96ny8BH1wp4r6Zd29oWL3ulE8oleagZD6mikn++fG2AKPBfgb5cKizTqicrma
 d3aGZuSkFk4Lr2igFMKxB1bH81uby5WuF4PRTvwQIC6pFhFM/YItRPLBU1bFF/VmK6sL
 8NTokppdhaZ+qNQv3hmGB1ccciOQ3ZZZY92MEBgFE2O+n5Bwzo4lbxs1VGdy4zpvketL
 qXm9Llwdl7CGNR7Gm3PPsrJz1nW9gqA/jiWETkJIa5twbnkBWu7RmHNMMTcs5/nirxRl
 Lj6LLaKapT3eWb+0Lea8+Zpgz+SAFw+jTsqct+VXTBLJjE1i7a7vGoV2eV114bJxQ3Rl
 PiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792438052; x=1793042852;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0EjCsLzxCc6Z1J6Avt4waW7BwoDGH1cC4bpSsprV0z0=;
 b=gFVLur5n2msQnQqK91Bl8xAMhDqnBdzTG5eU8DJbZRf14ggIA10jKAUGAQo5viRZOW
 0KBHonxkVlIzC8yqm8fEICMyiiLnq2S1l0T1ZBGMN0xhBisKWdW4OxTSDVUjWR2sQ+1W
 PJ121cdd057i+0/McOcqev+tHD/g2Dr8z/YrPmqFiC9emNxjZXetYTcVQVu0VaSyATja
 z8Z3wQAlxJVHpGO/m1wAD1JEl5CXki2b2Vf60bsiLnVYDeAGNpWMNvSXkHx+kdxLdsJy
 6mxh2XyvZrueZlZf1L7DAB6X9ZtFQt786M7T0qSUAs3GZr9PINTWAsfo15x/7rTJN7Gs
 6POQ==
X-Gm-Message-State: AFq9FYL6uZWrbKmda5o5NopwekPoAWU3xG01HZM4ztSKZ8mn19AJSC+x
 le7CGdWgJZLrTncdbIf55IQnR8cduvHC0zTOmCsZyCD0q0P9zpfo0/mZ5lxAuLMbyEM=
X-Gm-Gg: AYBFou29xOySqGI47nAJ7z+tHZGGBPZw1TE8lHcpuLCZoOXUs4HBmjwG5Qbyheu8BZn
 BVl2+iJH9j4H/XWYTj4qlS7nptjlkugekOc4WH10q7wOPfa6UR1GUj2zBvBkY7H1oFobGfIcZgi
 y8sBd+KZlp4STZEK+ftIgJe+/QrNAf2BW6yJ0aX9jtcndo9+CuwuArCwsQx0jFbfTRmhP8wDHcQ
 UU9AiEpmXVh6UECk5NFpdQ9U47DYBrIqgmULBQOk94vqb+/mei/RfNLomO4Vl1rWAn8/Zteolv9
 tPdXLHzT9U8dmXWOsEQKEpb/Mt5QYrvC6k1/voWrWVB3JqmGo8aa3ZvboSjullulXc2mCMnO86Y
 y7S1sNJKhSCjIrHrc9Ocf8PTqRZTZ5ssPT3jCooEL+CTW3Cj1uRE1Gfi4IW5a2pEK7p9aIc/gjN
 hiitXFRMXtmqNXNTg44QCUGwXZQJJMPvRJOiLPehd5SHd4oSiUYH9iepzx0dafk7FGdbUz+Q==
X-Received: by 2002:a05:600c:1906:b0:4a1:e6c8:ff74 with SMTP id
 5b1f17b1804b1-4a1e6c8ffd4mr94637325e9.29.1792438051703; 
 Mon, 19 Oct 2026 12:27:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f37f7fc3sm4616095e9.2.2026.10.19.12.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 12:27:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6299D5FD54;
 Mon, 19 Oct 2026 20:27:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>, Anders Roxell <anders.roxell@linaro.org>,
 qemu-arm@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Klaus Jensen <its@irrelevant.dk>, John Snow <jsnow@redhat.com>
Subject: [PATCH v3 13/19] tests/functional: add tuxrun kvm gdb test for x86_64
Date: Mon, 19 Oct 2026 20:26:58 +0100
Message-ID: <20261019192704.3220373-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019192704.3220373-1-alex.bennee@linaro.org>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With all the bits in place we can now exercise the KVM gdb interfaces.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260930164649.433573-14-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/x86_64/test_tuxrun.py | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

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


