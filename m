Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F0BC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdzW-0000kL-Re; Tue, 04 Mar 2025 20:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdzC-0007cn-L3
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:53 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdzA-0000Uf-TE
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:50 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-223cc017ef5so40570025ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139747; x=1741744547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=552MSFU/T799YJkWKsYbkSBXDrPDP/uDH7GO5H2sxJ4=;
 b=MPm+TJWwQvO/afgkXVQMmO9UH1LhtPvwIlzosBOnRemV37m3cHCLyj7SOqduqrcZbb
 fWDw/XQ+dHNHVZlBpviiwT1KBWO/gcgsWfBHi8T+uBAr+j9kMnX/tXdX5/elqOXvIJuE
 BTeV9kW/7GXxB40ILOFusdzCmb3DyObENk1nk6UNLIo6spCJa1XqUeGNzFVGJHNxVUVm
 dcMnL+NHxLiW6SMIqADprve+BehS7v8zA+YP3pLDUkWqtCTpaVIFDG2WZ4F+YVonOV7E
 J0zxgVmRxxqV7pwPwqI5HvVRa5wMHg278Owv8Jprg3MgyR0bAuqpJxxxBij4lYuilzFn
 Qkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139747; x=1741744547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=552MSFU/T799YJkWKsYbkSBXDrPDP/uDH7GO5H2sxJ4=;
 b=MFPO4kx7yO4npP2Cyl/OvyT5uwvFobdCsutYsE2IjNNk2NvS+8hZ1khjxakB/YgyMU
 YDGcBv8b1txE0kvnTKJ4Xh+OdHqScRopRZ3bDXW8DANDUWWBZdfvE2kWjnVZV82/CTbR
 OhRlSEs4n/Oi3BJ1D+VhvG+WZ8swUq+/eAx+HdEKYMDikF1fiaDsJWroJwpIxLCXvkT2
 eYx+w8IY4qxelfybOi0WPG759apQ6i+aVGfHXzHOAIlK/Aze1qzJgaZZbwwqIh8h0+dJ
 axPT2b5Ddr52sMoQSqt7Za5uo86q3SwGhWx02u31Nxb7di9VvI0AP3C1xI7rSmAeNHGG
 LTSQ==
X-Gm-Message-State: AOJu0Yws913BW/VmLEFvHyCcvPwu06lr5KDHCRkDD187+ZzaWwfuFYJM
 dWLagDxG8WUQDuOjYJ+XJEvrG7oyz9P9v9Y15Q6Jtz5bIB4vry8mSX0D7UWz75E=
X-Gm-Gg: ASbGncsdb+cnT74KfjRIUTPMTCsH/ZnIrBH41YFY3Cuu/hEOgyAE+bQr6+4/36Rydvo
 mtJ5NIPhfBKH7KNa8bN+WhvrxUTxhNrfMF5VUr6ebDpXS5KSXJylS6V6NM9J2lL8rfEayha4OvX
 8Eu6eEB55RftnYCp5SOPGJaExGCclX50SsbVDnuEr8IQRFGS1ppjbNe3RljDhga/ISIznd6f9c8
 Zvtb3FYQXIcnW3+UdULfYRjgcqzBTVWbt+TCz6Ly59hDuaV6VBM4Ap5vM19kVAkMphYkmRtv8yn
 qBsipzOapJv3ZKfOv3UA1a4BHouthxiunX912aGJHJJBsvWoq9FbqOkm/Bryjd4DT+FltNoogzo
 fb2eeooeSUA6wkyTMYZSO5jwdUPzS1XeH50oz2GeGrAAtVkQANmM=
X-Google-Smtp-Source: AGHT+IEDJZ6cXlON7JEGLXxfMLEx6n7BXo+rx4KwuwyyPBXPIyHjVQzJ2LHfZ7CU6MTw2LNVOx3wHQ==
X-Received: by 2002:a17:902:fc4f:b0:220:d439:2485 with SMTP id
 d9443c01a7336-223f1ca901bmr28643585ad.29.1741139747373; 
 Tue, 04 Mar 2025 17:55:47 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:46 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrea Bolognani <abologna@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 52/59] binfmt: Normalize host CPU architecture
Date: Wed,  5 Mar 2025 11:53:00 +1000
Message-ID: <20250305015307.1463560-53-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Andrea Bolognani <abologna@redhat.com>

Right now information regarding the family each CPU type belongs
to is recorded in two places: the large data table at the top of
the script, and the qemu_host_family() function.

We can make things better by mapping host CPU architecture to
QEMU target in the few cases where the two don't already match
and then using the data table to look up the family, same as
we're already doing for the guest CPU architecture.

Being able to reason in terms of QEMU target regardless of
whether we're looking at the host or guest CPU architecture will
come in handy to implement upcoming changes.

A couple of entries are dropped in the process: BePC and Power
Macintosh. I'm quite certain neither of those have ever been
reported as CPU architectures by Linux. I believe many more of
the entries that are carried forward could be dropped as well,
but I don't have the same level of confidence there so I
decided to play it safe just in case.

Signed-off-by: Andrea Bolognani <abologna@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20250127182924.103510-3-abologna@redhat.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 scripts/qemu-binfmt-conf.sh | 44 +++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 426f075e31..8d9136a29f 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -144,35 +144,35 @@ loongarch64_magic='\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x
 loongarch64_mask='\xff\xff\xff\xff\xff\xff\xff\xfc\x00\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
 loongarch64_family=loongarch
 
-qemu_get_family() {
-    cpu=${HOST_ARCH:-$(uname -m)}
+# Converts the name of a host CPU architecture to the corresponding QEMU
+# target.
+#
+# FIXME: This can probably be simplified a lot by dropping most entries.
+#        Remember that the script is only used on Linux, so we only need to
+#        handle the strings Linux uses to report the host CPU architecture.
+qemu_normalize() {
+    cpu="$1"
     case "$cpu" in
-    amd64|i386|i486|i586|i686|i86pc|BePC|x86_64)
+    i[3-6]86)
         echo "i386"
         ;;
-    mips*)
-        echo "mips"
+    amd64)
+        echo "x86_64"
         ;;
-    "Power Macintosh"|ppc64|powerpc|ppc)
+    powerpc)
         echo "ppc"
         ;;
-    ppc64el|ppc64le)
-        echo "ppcle"
+    ppc64el)
+        echo "ppc64le"
         ;;
-    arm|armel|armhf|arm64|armv[4-9]*l|aarch64)
+    armel|armhf|armv[4-9]*l)
         echo "arm"
         ;;
-    armeb|armv[4-9]*b|aarch64_be)
+    armv[4-9]*b)
         echo "armeb"
         ;;
-    sparc*)
-        echo "sparc"
-        ;;
-    riscv*)
-        echo "riscv"
-        ;;
-    loongarch*)
-        echo "loongarch"
+    arm64)
+        echo "aarch64"
         ;;
     *)
         echo "$cpu"
@@ -309,7 +309,13 @@ EOF
 
 qemu_set_binfmts() {
     # probe cpu type
-    host_family=$(qemu_get_family)
+    host_cpu=$(qemu_normalize ${HOST_ARCH:-$(uname -m)})
+    host_family=$(eval echo \$${host_cpu}_family)
+
+    if [ "$host_family" = "" ] ; then
+        echo "INTERNAL ERROR: unknown host cpu $host_cpu" 1>&2
+        exit 1
+    fi
 
     # register the interpreter for each cpu except for the native one
 
-- 
2.48.1


