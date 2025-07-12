Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A747C83F20
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Jul 2025 13:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaaHQ-0007fN-Bw; Sat, 12 Jul 2025 09:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uaaHL-0007dl-Es
 for qemu-devel@nongnu.org; Sat, 12 Jul 2025 09:28:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uaaHJ-00039G-HJ
 for qemu-devel@nongnu.org; Sat, 12 Jul 2025 09:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752326909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NvkNgqLKsXpfmLf4idce9IyO9fOJ2IHj3aUNZS4ffhE=;
 b=dJWhsNzPLp1Q/gEfpFHiKHcuGaS9dPvuDgCEJbZzi93yX7hFBt0yhxKuM5t/E7SRawVDr7
 6MzVmvmUvtdjIVbL0qt4Jzu4o/KvY1vWyxVP/3+XXgDgWq2w7VZQQL1JhtlWjO/rjZyatq
 dpYv2yuxTFkygq15PvEadRjY6xByDoU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-QQIAQQv6PcWV6HB8EuIUbw-1; Sat, 12 Jul 2025 09:28:27 -0400
X-MC-Unique: QQIAQQv6PcWV6HB8EuIUbw-1
X-Mimecast-MFC-AGG-ID: QQIAQQv6PcWV6HB8EuIUbw_1752326906
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451ac1b43c4so15963255e9.0
 for <qemu-devel@nongnu.org>; Sat, 12 Jul 2025 06:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752326906; x=1752931706;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NvkNgqLKsXpfmLf4idce9IyO9fOJ2IHj3aUNZS4ffhE=;
 b=ZGyEM64QeXtM2ErLERYFnuxyaNrWL3t9ggvHMfIoRTVfLrxmyXM7936HMqKjQpNrjg
 AASkPfWwiecmCx3YuoJXL9/ukyH1ut4Dh2RVMCxiEPeUE9h0lOODi+z1nKl2nptKdvhn
 /gUltjmYVhinq1BiAyqslh4fr+ev8KYToEtIaNvJCvO/m89Kzp2s2P7m6PdAK0zO/+Ia
 S2wZY0ltkzcbC1keDA+gGM01pzpfAUJeKfPUZy2gemNF6XJIW8MZejuqCvmrh2Gqig8S
 asfB7oLTMP8pIJLVNglUsEyccumTYpQWrBzxj7K1Wo/ev363muhPhla2wUsjrVkCw9/V
 P4cQ==
X-Gm-Message-State: AOJu0YwmCeEjO8+/sEZaq4mKJM0tkNB1pxpQq1IwxUw0/A+8VnakNY4n
 c9uK5ggosLcCcYKA6za+rsiMlgbXRtdISJv6TyS7WgfquSkt3gyBaO7ZMkTQOICruwslEhJjGsc
 cRomJjUH+MfgW51QNkUpt7VpNiOZ9Ft6dDIZR7f5aIiJtPgMTqd8jtOGJjh6Wb2BE3BClcD2kIf
 S+r0wVx5YDaXCasdSTJwNdShYgGINgq8fZrzvejY9g
X-Gm-Gg: ASbGnctx2Ikw2S10cN3utMOXgMGNNgkAIUaLBfQH7mulMInABK335MYk4e4s+XmVV1K
 GHZEWTjK1DkOxL//h38P4t76y7B8OcYafYUIMfzv7SHJQo9PdNdz5eK/Ynx7/6m0KMWfKhR2a2q
 UAAlHPbmhqHYQ6JDVU8fE6qaDKQBUStVOQ4Q/x83UMiqkyMpl1DMWBvgu5sGc8942wLQ/ne1uNC
 85cCneZnFrOf4VjN3HUMkZzkTFfkdhkbW4diheQUILQ/x6T6FNGKK8wshxzCLwos4t5x5hcJAEc
 NG5Wxo/JWlMh3zmTcmEBtUpKMAm5H5hT5A6jhJNzxCQI
X-Received: by 2002:a05:6000:471d:b0:3a4:dc42:a0c3 with SMTP id
 ffacd0b85a97d-3b5f18e813amr6826226f8f.56.1752326905733; 
 Sat, 12 Jul 2025 06:28:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDeNOwHwqIxUBmVQ8rvcPgFPWN6vaOYTMS4k0W4yXb7fw/y8QJHCJI4d0v2AUvmAfEhA7tLA==
X-Received: by 2002:a05:6000:471d:b0:3a4:dc42:a0c3 with SMTP id
 ffacd0b85a97d-3b5f18e813amr6826202f8f.56.1752326905095; 
 Sat, 12 Jul 2025 06:28:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26f7bsm7411033f8f.95.2025.07.12.06.28.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Jul 2025 06:28:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/vm: bump FreeBSD image to 14.3
Date: Sat, 12 Jul 2025 15:28:24 +0200
Message-ID: <20250712132824.69275-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vm/freebsd | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 74b3b1e520a..2e96c9eba52 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -28,8 +28,8 @@ class FreeBSDVM(basevm.BaseVM):
     name = "freebsd"
     arch = "x86_64"
 
-    link = "https://download.freebsd.org/releases/CI-IMAGES/14.1-RELEASE/amd64/Latest/FreeBSD-14.1-RELEASE-amd64-BASIC-CI.raw.xz"
-    csum = "202fe27a05427f0a86d3ebb97712745186f2776ccc4f70d95466dd99a0238ba5"
+    link = "https://download.freebsd.org/releases/CI-IMAGES/14.3-RELEASE/amd64/Latest/FreeBSD-14.3-RELEASE-amd64-BASIC-CI.raw.xz"
+    csum = "ec0f5a4bbe63aa50a725d9fee0f1931f850e9a21cbebdadb991df00f168d6805"
     size = "20G"
 
     BUILD_SCRIPT = """
-- 
2.50.0


