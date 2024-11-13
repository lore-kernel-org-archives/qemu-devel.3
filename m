Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26629D462DA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 16:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBGNq-0004Qd-43; Wed, 13 Nov 2024 11:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1tBGNo-0004QR-VE
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 11:38:20 -0500
Received: from esa12.hc2706-39.iphmx.com ([216.71.137.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1tBGNn-0007ON-3v
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 11:38:20 -0500
X-CSE-ConnectionGUID: 1T+LWpgWSiCzOmbu+UTNRQ==
X-CSE-MsgGUID: U79gf5QITse2W0AUS0M3/g==
X-IronPort-RemoteIP: 209.85.222.200
X-IronPort-MID: 2524138
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:V1Xi4q8goSb3ljEqHPuUDrUDyX+TJUtcMsCJ2f8bNWPcYEJGY0x3z
 mVMWzuOP/7YazakKtkgbtiy8k9U6pHSzNYyHgFt+ygxFiIbosf7XuiUfxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG86yQ6jOfQG+eU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCkaGt
 MiaT/f3YTdJ4BYqdDtOg06/gEk35qir4WpD5gZWic1j5zcyqVFEVPrzGonsdxMUcqEMdsamS
 uDKyq2O/2+x138FFtO/n7/nRVYBS7jUMBLmoiI+t3+K20UqSoQai87XBdJFAatlo2zhc+NZk
 b2hgaeNpTIBZcUgrgi8vy5wSEmSNYUekFPOzOPWXca7liUqeFO1qxli4d1f0ST1NY+bDEkXn
 cH0JgzhYTjau6GS/6q0ddJtrdYEKcP2f74jnEtZmGSx4fYOGfgvQo3P7N5cmS4z34VAR66GI
 cUebjVrYVLLZBgn1lU/Uspv2rf1wCOlKXsC8Ar9SakfugA/yCR41KjrPMD9cMHMSMlI9qqdj
 jibpTigWUFy2Nq39GXU/Xzxv87zhi6hZ9o7KYbg06UtjwjGroAUIFhMPbehmtGgh0ujHt5SN
 UEQ0iwpq6c06QqsVNaVYvGjiHuNvxpZQtkJVuNgsFnLxa3T7AKUQGMDS1atdeAbiSP/fhRyv
 nfhoj8jLWcHXGG9IZ5FyoqpkA==
IronPort-HdrOrdr: A9a23:t79uyapJj6SHYQNIbFTDP0kaV5rueYIsimQD101hICG9vPbo8P
 xG+85rqCMc7Qx6ZJhOo6H4BEDtewK4yXcX2/hqAV7BZnifhILAFugLhvqB/9SJIVycygc379
 YHT0ERMqyVMXFKyezX2k2XKeoB/fWw2JyUpI7lvgtQZDAvRKd68Q9jBwqXVmFwThJXHIc0Gf
 OnivavZADORZ3UVKmG77U+PtQr3+e7764OqCRpZyIa1A==
X-Talos-CUID: =?us-ascii?q?9a23=3ALyadw2hiV0xyGVUPw9Jy4ESoAzJuK0Ge6EjILHC?=
 =?us-ascii?q?DCE17b7ifVBytxIVeqp87?=
X-Talos-MUID: 9a23:ij6pmwXG6Pr4NMfq/AKz1T5saf5J37+jUn9VuKg94+zfciMlbg==
Received: from mail-qk1-f200.google.com ([209.85.222.200])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Nov 2024 11:38:12 -0500
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b155e23851so953182185a.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 08:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1731515891; x=1732120691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gyV4NoyEKu85Hk8fMFhdhW263pOKxShPE3rnVYLIG28=;
 b=TAC4UIQ4xeiuD7YWbBq4I8LGsq+jFABgXKmWB/1Jqb6R3VtmB+QWLcxeI01SRRArwN
 YFo4kTeB/g8IHtvR2z9SR1m/h3D6OE3GpCQzTlrNyk/VdNPV61LUqF2M0UvpTJM+sKUu
 nfVbC6vSWrpPpFfTJ7bgDHX5LVkjvQih7+QCS8W41eytLOKyMlrpfrxCHwE0HbKOjsO8
 CzP31sAtytDQH+lJjeb7mNFS87CdzgwZ77DYp+CnfNkl5k1VEAgsk6cMSA+p9Ev19L4k
 TFeiGk6jtVqHUwFdBVMxtndta+U8gg+E0dsYK68Mvd2vkqbTuIpoKk5PygEkKalx0BXs
 3olQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731515891; x=1732120691;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gyV4NoyEKu85Hk8fMFhdhW263pOKxShPE3rnVYLIG28=;
 b=mK3cSdEVKxr1ClT75Y2XYT6FOKy99Jnc+Mffl7PNJP6oiAjFLaDa4DlULWdDL/TCML
 3zSnK65OGRFS6eH32/JLcJQ/Ib4nGfs+SW/ekOmnu9VQvcexHSWQUMvM0+WinkuhMwa3
 qExNNTB9Go5X1vvFRqMXoWXOTK3LsQuO9d2PbBOcj4W7OcB54ryQoQASGm5QXkkUzftf
 +SUWFO/GbwooX0PK7Fa9f4lNZDkbIekzzi3yN/kMz6k6Vrf7c8ZVdFEwcxiTmBNjjM5C
 kyVycgipPZMLz5UYnAKm0ziZpvSOiHkSIo+3MWrn3ewvVVd38XeCqGFvah98qhJY2hx9
 QEuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfFm5AbfebvvQAizM9IaB2lJ1pQ+wsw3KklisqtbZ19RnMsCk3mXZo7vJ4KU7CDlHoB7apzdVYak+s@nongnu.org
X-Gm-Message-State: AOJu0Yx40iocWmD206sVDf2SoTgX/rD9qyD8shIguJGtr44DMpx/q0dK
 ZmK3cwJhLSWxU2EdStF6H98oZTsxkCRybJXanEkqhxOLwa8YpRVJeE3IXfI8dhi6jRDR4tNB/r4
 n/fhP/8KNNXLwhCJmIXjsBVeC32sCt1hW3nRQyEZhz8SKsE9le6AZ/Zz5hBs8tE5SmQ==
X-Received: by 2002:a05:620a:17a3:b0:7af:cb6b:b4fb with SMTP id
 af79cd13be357-7b3529e6975mr400152585a.52.1731515890043; 
 Wed, 13 Nov 2024 08:38:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHO4bQtIOpPi8duQ7X+9xrLqJ4601VhmFaU5RuNAtoD8cdUIeNa2sbIfnw2xwNPinRKFPoHeA==
X-Received: by 2002:a05:620a:17a3:b0:7af:cb6b:b4fb with SMTP id
 af79cd13be357-7b3529e6975mr400138185a.52.1731515888255; 
 Wed, 13 Nov 2024 08:38:08 -0800 (PST)
Received: from bos-mail01.vrmnet (pool-173-48-150-109.bstnma.fios.verizon.net.
 [173.48.150.109]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32ac4ff94sm708967885a.41.2024.11.13.08.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 08:38:07 -0800 (PST)
From: Alexander Bulekov <alxndr@bu.edu>
To: 
Cc: Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH] fuzz: disable tcg for OSS-Fuzz builds
Date: Wed, 13 Nov 2024 11:37:56 -0500
Message-ID: <20241113163800.355547-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.137.82; envelope-from=alxndr@bu.edu;
 helo=esa12.hc2706-39.iphmx.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.054,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

OSS-Fuzz builds have been failing due to some strange issues that seem
to be related to color codes from libffi:
https://oss-fuzz-build-logs.storage.googleapis.com/log-8d5435ee-1677-40af-9656-b4162fa881e1.txt

Disable tcg to disable libffi.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 scripts/oss-fuzz/build.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index 7398298173..095f7a90e3 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -65,7 +65,7 @@ mkdir -p "$DEST_DIR/lib/"  # Copy the shared libraries here
 # Build once to get the list of dynamic lib paths, and copy them over
 ../configure --disable-werror --cc="$CC" --cxx="$CXX" --enable-fuzzing \
     --prefix="/opt/qemu-oss-fuzz" \
-    --extra-cflags="$EXTRA_CFLAGS" --target-list="i386-softmmu"
+    --extra-cflags="$EXTRA_CFLAGS" --target-list="i386-softmmu" --disable-tcg
 
 if ! make "-j$(nproc)" qemu-fuzz-i386; then
     fatal "Build failed. Please specify a compiler with fuzzing support"\
@@ -83,7 +83,7 @@ if [ "$GITLAB_CI" != "true" ]; then
     ../configure --disable-werror --cc="$CC" --cxx="$CXX" --enable-fuzzing \
         --prefix="/opt/qemu-oss-fuzz" \
         --extra-cflags="$EXTRA_CFLAGS" --extra-ldflags="-Wl,-rpath,\$ORIGIN/lib" \
-        --target-list="i386-softmmu"
+        --target-list="i386-softmmu" --disable-tcg
     make "-j$(nproc)" qemu-fuzz-i386 V=1
 fi
 
-- 
2.45.2


