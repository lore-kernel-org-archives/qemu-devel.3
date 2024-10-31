Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F33D767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZLV-00078r-H8; Thu, 31 Oct 2024 13:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLU-00075y-8Y
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLS-0007Co-PS
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/xNX/14R4UAkx3NRj9AwvxkIBvWhT+msdr0TPvOnLYU=;
 b=TjnB0UKkiuAPzmxCU+P/4jBtEA9GOfGdU50MLa8Hk0AmdWVxpuRovdvl3QKy5Y01XyJcqG
 OfHjQ+L3QL20TSfTwQrcKbiUWO3sgBHT8e8099rgSxKIPThOdC611QGSTpBj5PimcSVaSE
 Ksh8UeOgTH1R3Jf6shEUPWIBEoZBlCA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-LS5c2i1ANKKtD2q-QteDSg-1; Thu, 31 Oct 2024 13:52:28 -0400
X-MC-Unique: LS5c2i1ANKKtD2q-QteDSg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d67fe93c6so643632f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397146; x=1731001946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/xNX/14R4UAkx3NRj9AwvxkIBvWhT+msdr0TPvOnLYU=;
 b=V0gYi/jFsbraAx/MZPR3fE7+CYC66SA/0l90xuGI2H9RcdJiQCo2nHK2cXVtf8r4Lw
 7zGGniGxxn4waql0+OLHzw8IWOE7c5bXWpp0LrqGTA5XsKYlUXV0h6bNueCLafPl6muM
 Ii1PpPLB37pbtw6YxD5XugtRcFUdfmKsfH0u5/G8Z4W1pnAYW278l2ZH0SCpAn3Sf6Ug
 YSTKqCJRzQLkZGWmTxc0Q8XjPUCMz7JYb0ijo6fw8zSSEaq3DXW4vmzQUryqOSdqSngU
 dBSlVqmf3s67QCd6GicP2/4Uhrax+GqLTcuVUu+S+lWj3I9gttHpa2yc2rNcWes1kcZA
 klkQ==
X-Gm-Message-State: AOJu0YysZEukjVK+RbkjlbvJJayX/Greh4YR4ZEXPSzHI0yUvfye2f0y
 BGJ7lYZAfQx+EzWxuQRUKsC5WoMPQwiy+hvUxsDX2CyqP0bbL7l2VpoEL3wParSSCmQN0/uTGQA
 MxdghH8KRJJvJCXe+1l7tPskJD1z9CUprS35yTkYDlpfiwXA92utH2kEQYmCt/7uvAEzJmgnrGy
 yuBmeMU2IWCstkCd4Y7s2OJTb0SWLuf+bxABP8380=
X-Received: by 2002:a5d:47a2:0:b0:37d:4ef1:1820 with SMTP id
 ffacd0b85a97d-381bea1c0bemr3573365f8f.40.1730397145985; 
 Thu, 31 Oct 2024 10:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGySjoOs2RXldDh2WDJLGWo0wQisVjBCd6/Z4ABH/v+C4W/7ZLa87ne+EKuGmTfTvGW+CaYpw==
X-Received: by 2002:a5d:47a2:0:b0:37d:4ef1:1820 with SMTP id
 ffacd0b85a97d-381bea1c0bemr3573345f8f.40.1730397145526; 
 Thu, 31 Oct 2024 10:52:25 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7bb7sm2796018f8f.3.2024.10.31.10.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/49] configure: detect 64-bit MIPS
Date: Thu, 31 Oct 2024 18:51:30 +0100
Message-ID: <20241031175214.214455-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

While right now 64-bit MIPS and 32-bit MIPS share the code in QEMU,
Rust uses different rules for the target.  Set $cpu correctly to
either mips or mips64 (--cpu=mips64* is already accepted in the case
statement that canonicalizes cpu/host_arch/linux_arch), and adjust
the checks to account for the different between $cpu (which handles
mips/mips64 separately) and $host_arch (which does not).

Fixes: 1a6ef6ff624 ("configure, meson: detect Rust toolchain", 2024-10-11)
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 4a0159e1832..f24940ca77d 100755
--- a/configure
+++ b/configure
@@ -395,7 +395,11 @@ elif check_define _ARCH_PPC ; then
     cpu="ppc"
   fi
 elif check_define __mips__ ; then
-  cpu="mips"
+  if check_define __mips64 ; then
+    cpu="mips64"
+  else
+    cpu="mips"
+  fi
 elif check_define __s390__ ; then
   if check_define __s390x__ ; then
     cpu="s390x"
@@ -1230,7 +1234,7 @@ EOF
       fi
     fi
 
-    case "$host_arch" in
+    case "$cpu" in
     arm)
       # e.g. arm-unknown-linux-gnueabi, arm-unknown-linux-gnueabihf
       write_c_skeleton
@@ -1278,7 +1282,7 @@ EOF
     test "$rust_arch" = arm && test "$rust_os" != linux && rust_arch=armv7
     ;;
 
-  mips|mips64)
+  mips)
     # preserve ISA version (mipsisa64r6 etc.) and include endianness
     rust_arch=${raw_cpu%el}
     test "$bigendian" = no && rust_arch=${rust_arch}el
-- 
2.47.0


