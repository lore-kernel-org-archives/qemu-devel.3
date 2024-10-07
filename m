Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26745CFB44D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 17:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxrSI-0006NT-H0; Mon, 07 Oct 2024 13:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxrSD-0006LR-Cq
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 13:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxrSB-0005ai-LS
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 13:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728321806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g3QTRSN1vhr5+ZxV0vNlKkPmaXPfbCZxEsz9ytNIPCc=;
 b=WqALumlLzowAnD3DH6yTF0Rlu39YI9f4kfBl+TEm1QaoF8Z0B+ew4ece2XDbNJKKxGxF53
 GLwlvDfUA2DyD5ro07VCED2/+T37V0iafDl1PLn7v4cRWrOh56B3Nw6iZOh6cCEfhnO2Lv
 qo8AWWBAeBA2jQJwRFKDTDBdSD3v2GQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-y1CCU0ULOA-EujHZLwCbXw-1; Mon, 07 Oct 2024 13:23:25 -0400
X-MC-Unique: y1CCU0ULOA-EujHZLwCbXw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37ccc96d3e6so1778779f8f.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 10:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728321803; x=1728926603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g3QTRSN1vhr5+ZxV0vNlKkPmaXPfbCZxEsz9ytNIPCc=;
 b=NQ1h00ZzFV96b8E/bwIVVA/2YIffP39jCWYmzIJDwldOWzlv5h5bwj0VpsCghnQGhJ
 5ejrFK8C0cDATG68P5PHNt5JAU9I94cPq3UN0ERR0aPvMxW/K2f93nztc45JiGx56V8h
 BFNJdDXS7VB/PN0RS1rIr8g3zJVV5AYK8Of9wy6oQx/fohfVvUOCoudOlH2AdefLBcrZ
 3IdxyUXZi8D1fdEwVUdw4rVZvYvoqxx577+A7XzMWekqeTKbXSdcMLW7PcEFwxEaopKC
 BpKu2R58BNhJ3MTsbj62RGjH7TXG7Sf2FvOSSAVC9WFR9iJcFsv2FwpJHa439MgWfoBa
 V6DQ==
X-Gm-Message-State: AOJu0Yxx3lA06PNpDqDCGW668+bZpTPw2wUTKRYpB4tsqvjIUlAr4/rC
 Y/LoQ9U0pvbLHWT58Qx/RbiSKDfveDmOQRIIkAYSnWZbPylh1RQeIv8M7pRDQghAyZlO0I2rJvZ
 OXLJ1clNNMfklYhpejsksu0Eojirw4ImWcPkOtRYkxgyUn3i5qNK1dJAaBcANxFdOxP6Xo2mAsc
 X30vLdbvWs1kiEf9I3N2A+bKkRB3BZCOOLAvjM53Y=
X-Received: by 2002:a5d:6147:0:b0:37c:d53a:6132 with SMTP id
 ffacd0b85a97d-37d0e77f6f3mr7386488f8f.31.1728321803479; 
 Mon, 07 Oct 2024 10:23:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSHuwArw90GWBFykgu2auvyWB3GyNYYCJwuJENElgp/J4wk7K/tK9sI8U7PQrPPEfIFuIsTA==
X-Received: by 2002:a5d:6147:0:b0:37c:d53a:6132 with SMTP id
 ffacd0b85a97d-37d0e77f6f3mr7386464f8f.31.1728321802971; 
 Mon, 07 Oct 2024 10:23:22 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f89e858d2sm81082275e9.10.2024.10.07.10.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 10:23:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, alex.bennee@linaro.org, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-stable@nongnu.org
Subject: [PATCH 1/2] meson: define qemu_isa_flags
Date: Mon,  7 Oct 2024 19:23:15 +0200
Message-ID: <20241007172317.1439564-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241007172317.1439564-1-pbonzini@redhat.com>
References: <20241007172317.1439564-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Create a separate variable for compiler flags that enable
specific instruction set extensions, so that they can be used with
cc.compiles/cc.links.

Note that -mfpmath=sse is a code generation option but it does not
enable new instructions, therefore I did not make it part of
qemu_isa_flags.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 76335bb2a51..65ea45cef03 100644
--- a/meson.build
+++ b/meson.build
@@ -335,6 +335,10 @@ elif host_os == 'windows'
   endif
 endif
 
+# Choose instruction set (currently x86-only)
+
+qemu_isa_flags = []
+
 # __sync_fetch_and_and requires at least -march=i486. Many toolchains
 # use i686 as default anyway, but for those that don't, an explicit
 # specification is necessary
@@ -351,7 +355,7 @@ if host_arch == 'i386' and not cc.links('''
     sfaa(&val);
     return val;
   }''')
-  qemu_common_flags = ['-march=i486'] + qemu_common_flags
+  qemu_isa_flags += ['-march=i486']
 endif
 
 # Pick x86-64 baseline version
@@ -367,29 +371,31 @@ if host_arch in ['i386', 'x86_64']
     else
       # present on basically all processors but technically not part of
       # x86-64-v1, so only include -mneeded for x86-64 version 2 and above
-      qemu_common_flags = ['-mcx16'] + qemu_common_flags
+      qemu_isa_flags += ['-mcx16']
     endif
   endif
   if get_option('x86_version') >= '2'
-    qemu_common_flags = ['-mpopcnt'] + qemu_common_flags
-    qemu_common_flags = cc.get_supported_arguments('-mneeded') + qemu_common_flags
+    qemu_isa_flags += ['-mpopcnt']
+    qemu_isa_flags += cc.get_supported_arguments('-mneeded')
   endif
   if get_option('x86_version') >= '3'
-    qemu_common_flags = ['-mmovbe', '-mabm', '-mbmi', '-mbmi2', '-mfma', '-mf16c'] + qemu_common_flags
+    qemu_isa_flags += ['-mmovbe', '-mabm', '-mbmi', '-mbmi2', '-mfma', '-mf16c']
   endif
 
   # add required vector instruction set (each level implies those below)
   if get_option('x86_version') == '1'
-    qemu_common_flags = ['-msse2'] + qemu_common_flags
+    qemu_isa_flags += ['-msse2']
   elif get_option('x86_version') == '2'
-    qemu_common_flags = ['-msse4.2'] + qemu_common_flags
+    qemu_isa_flags += ['-msse4.2']
   elif get_option('x86_version') == '3'
-    qemu_common_flags = ['-mavx2'] + qemu_common_flags
+    qemu_isa_flags += ['-mavx2']
   elif get_option('x86_version') == '4'
-    qemu_common_flags = ['-mavx512f', '-mavx512bw', '-mavx512cd', '-mavx512dq', '-mavx512vl'] + qemu_common_flags
+    qemu_isa_flags += ['-mavx512f', '-mavx512bw', '-mavx512cd', '-mavx512dq', '-mavx512vl']
   endif
 endif
 
+qemu_common_flags = qemu_isa_flags + qemu_common_flags
+
 if get_option('prefer_static')
   qemu_ldflags += get_option('b_pie') ? '-static-pie' : '-static'
 endif
-- 
2.46.1


