Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB0BCD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjN4-0006J4-RN; Fri, 22 Mar 2024 14:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjN3-0006IY-NN
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjMo-0006yo-SD
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n3mpida+7pBeEIwF72SudzUqBOgjk+1wmiY+VpH0hr4=;
 b=LDbmR9VP7DPpcpribQMFJXPUx1J/evsOJ4b8DHXFhv9KO9Xq68T8+z5iIfvhbmvyL3/iTO
 E72e73fyr50LVvx8Sa4JrwLu+nXkiDPxIAdxF4aQq3Hw04QfexNYBMt3FiraiSaFcUEXhW
 HdpAkYGc1yDU70m9XBoGhkz+WW1Ry1E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-QIlTppkNMxWOWs7_xpJs-g-1; Fri, 22 Mar 2024 14:11:44 -0400
X-MC-Unique: QIlTppkNMxWOWs7_xpJs-g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a3fcf5b93faso134586666b.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131103; x=1711735903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n3mpida+7pBeEIwF72SudzUqBOgjk+1wmiY+VpH0hr4=;
 b=O1GYMK3g+Y0jJ19RzT1c0FtROqswvCYZehFN0YB/aI3zSRxYOey+TaW7yxVkRm/DWk
 RIcTmOWwUmG9ytad5wXUG7WAEeypsokUkjEochLXJXgFXP2dI7bywPqunZTW7HPXzEwd
 mxh/6TbzG4D/JHXbXHeD2ML4Y6cyDQzHA7Mk3ZPOze5n5yvcg+LEOatckXU316HSAbrr
 9sV/n1RtUnbHDzbgNluawBtEG8m0YQ6Za1RkSLrdYg3J10NInAzeLkEb1XWpqbq2ihOw
 D7gyy+5ysRq0WbhjhTlqKNW5i++GKz6iioh61PFWiUB0HDiNSGgQwXmuSAtzbR7L0UcK
 yEpg==
X-Gm-Message-State: AOJu0Yzwh5ojlTXKboq0kZaO99ePkY93kLoHUKT8nyhu5m+V1tH5DhH/
 kD9/JbXpzlAZG6r2sttlpifgf48M9Dv8svv8+przGfvMGUIo+JBvk4LAMRKpbqALlv+hdmMGTEy
 ik5QcObRKVco5ughSFhkoDwceVtlhAkLFBh6gXSMfqT4PH7RDkzVKHO5ApWqCTHSxnDnL83eEQ5
 NfC7u+tr4t17bDU1h5jw/22p4NTxyTVHrNjM2p
X-Received: by 2002:a17:906:2c50:b0:a46:c8e2:40f6 with SMTP id
 f16-20020a1709062c5000b00a46c8e240f6mr357697ejh.1.1711131103266; 
 Fri, 22 Mar 2024 11:11:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdwrecA19EZNVuKHa/SnI+wEQv1erICzTyxdF4SpKQ4r+Unm+dPWBtEgWsiRkkkCLSTUri3g==
X-Received: by 2002:a17:906:2c50:b0:a46:c8e2:40f6 with SMTP id
 f16-20020a1709062c5000b00a46c8e240f6mr357687ejh.1.1711131102984; 
 Fri, 22 Mar 2024 11:11:42 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a170906504c00b00a46ab33f970sm68696ejk.163.2024.03.22.11.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:11:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 07/26] scripts/update-linux-headers: Add setup_data.h to
 import list
Date: Fri, 22 Mar 2024 19:10:57 +0100
Message-ID: <20240322181116.1228416-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Michael Roth <michael.roth@amd.com>

Data structures like struct setup_data have been moved to a separate
setup_data.h header which bootparam.h relies on. Add setup_data.h to
the cp_portable() list and sync it along with the other header files.

Note that currently struct setup_data is stripped away as part of
generating bootparam.h, but that handling is no currently needed for
setup_data.h since it doesn't pull in many external
headers/dependencies. However, QEMU currently redefines struct
setup_data in hw/i386/x86.c, so that will need to be removed as part of
any header update that pulls in the new setup_data.h to avoid build
bisect breakage.

Because <asm/setup_data.h> is the first architecture specific #include
in include/standard-headers/, add a new sed substitution to rewrite
asm/ include to the standard-headers/asm-* subdirectory for the current
architecture.

And while at it, remove asm-generic/kvm_para.h from the list of
allowed includes: it does not have a matching substitution, and therefore
it would not be possible to use it on non-Linux systems where there is
no /usr/include/asm-generic/ directory.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/update-linux-headers.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index a0006eec6fd..d48856f9e24 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -61,7 +61,7 @@ cp_portable() {
                                      -e 'linux/const' \
                                      -e 'linux/kernel' \
                                      -e 'linux/sysinfo' \
-                                     -e 'asm-generic/kvm_para' \
+                                     -e 'asm/setup_data.h' \
                                      > /dev/null
     then
         echo "Unexpected #include in input file $f".
@@ -77,6 +77,7 @@ cp_portable() {
         -e 's/__be\([0-9][0-9]*\)/uint\1_t/g' \
         -e 's/"\(input-event-codes\.h\)"/"standard-headers\/linux\/\1"/' \
         -e 's/<linux\/\([^>]*\)>/"standard-headers\/linux\/\1"/' \
+        -e 's/<asm\/\([^>]*\)>/"standard-headers\/asm-'$arch'\/\1"/' \
         -e 's/__bitwise//' \
         -e 's/__attribute__((packed))/QEMU_PACKED/' \
         -e 's/__inline__/inline/' \
@@ -155,11 +156,14 @@ for arch in $ARCHLIST; do
                "$tmpdir/include/asm/bootparam.h" > "$tmpdir/bootparam.h"
         cp_portable "$tmpdir/bootparam.h" \
                     "$output/include/standard-headers/asm-$arch"
+        cp_portable "$tmpdir/include/asm/setup_data.h" \
+                    "$output/standard-headers/asm-x86"
     fi
     if [ $arch = riscv ]; then
         cp "$tmpdir/include/asm/ptrace.h" "$output/linux-headers/asm-riscv/"
     fi
 done
+arch=
 
 rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
-- 
2.44.0


