Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C65C5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 00:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww7fA-0002M2-T8; Mon, 17 Aug 2026 20:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1ww7f8-0002KV-Pi
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 20:26:42 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1ww7f6-0004Il-Rj
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 20:26:42 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-48a0ca07c38so2488659b6e.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 17:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787012800; x=1787617600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pGsJ55D7oCaxHGChmflsrSfJqDyjOVB7e8WxHFWVoOE=;
 b=EIE5hoI2YXCHaOUqhkxXCBJyYQE3zblbEtkG+7zkLwUzbY77HRJEaqZVbXlBjAr2yN
 fTJ6SZTyI9wpG2ZpauL5Ucicmy76SfMTuXjuL3HGZjMnqhn9HALLEPMhWXB9+4q2nuQg
 UgyMvgIGxkihspjCyiOqvDK5Vy2S5Jdwvwu7RvXFupHQGwgQa5k7noGGaawzLUqR2J2A
 VUMCnRaLQ88rHWPpzcApLvN8w3v3falnqeuDGTAC7Gm6y597e3bpzeIMBWbaMdipuUA8
 pFhwHNubJn/j1vAoH+28NINIfPySwwOir+VInW6M4/5KzsYPEf76HvSAX6j1YYjggctr
 ihaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787012800; x=1787617600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pGsJ55D7oCaxHGChmflsrSfJqDyjOVB7e8WxHFWVoOE=;
 b=dSuT9SxGatVtiy6mB5Cat8r3v6xXTIQPhKFOYCX0ilyoR2H2+yijX70splz0xWAU1y
 Wwhchc86j2JqQjQZJUHyQaD3LA5AC9KsjzVuvl3f8YFjW/5FBcDLjTWB6KLJ+pQ9NbAJ
 tQDxZIRfhSG4F4+i+Ko/wk7YBv9zsjz/VUR6q4SrJp51mqT0lxvlaYmH2/W6OtBFOIvw
 ZJM/veZIddXtltzTrrjojZOp0eiCHGvGbjbB0PJ3JBtsx63F3flFYqvNj9ZHXF8MqEWz
 NXPEGW7KAwehD5KKlyN50vVIFZC+Ekd/fx0QDvus6IsDRXIJffa5AY+a19610OOkKBbY
 sytg==
X-Gm-Message-State: AOJu0Yz76RvHPcIJ39A41jGjOIvNb+b/fPJ2FsYfGeBir3z+zIsNCSxL
 r7kjReNhQOUPYDnQdg40tZcO3Tc+MtZcesEGF+i24z6zybdokCeIVeFj0ljZPtgt
X-Gm-Gg: AR+sD12XmmHYEjTeJ6rlzpheWH1f4JrlfHQXwa2WLM5ClXif7dIHxAo+jVzE+oBDG44
 5awbTJJiRh2bh4RLJC9zrMKFm0c6cZmbfl9cQMe3d/nauBOIVDSxCi5SQFc+W2kVTWpJV3lGn37
 /uyZWN1FRucY2EiLlM/M0nt7T9oV0pP9oXe5EgHzSbeT/mde6B9HDwBlmo9UAOOKXRzW5sZ7q5T
 788jt5psaBiTheB0wiLUhUmIe6bfab97JgkHrvFAqBAJrhPl5x8PdjrKmun7ktmdD7JpVMZZEsA
 GVaSfbqpc1lUUdmOfEp9njGphJew8jQlQYR83ch8BPbsGkkK/JOIBXsTvDCcLbOGntKNgNS45MA
 Bzmz6fWVlWONuCj5N6nEIs6bpVuI7xd3s196sf2TF/zzGpPqQ1l7q2oBjCYYtbPaNU+oSlyFlgF
 n8/pe+dDMfc5JFRtNBxejQH61/PXwYv1dQmVYN3qccCJoDVbZOMO0/bMm7oQgyDTHCmRcLXw4sw
 D6buql9gfy98ur3WLscYkA=
X-Received: by 2002:a05:6808:1787:b0:489:352c:5153 with SMTP id
 5614622812f47-4b297757c6cmr4726594b6e.21.1787012799644; 
 Mon, 17 Aug 2026 17:26:39 -0700 (PDT)
Received: from LAPTOP-86EU4LQA.home.local ([23.124.244.239])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2960dfc9bsm1715165b6e.14.2026.08.17.17.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 17:26:38 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Simon Xu <simonxhy0404@gmail.com>, Owen Giles <owen.giles@hpe.com>,
 Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 6/9] hw/misc/iotkit-secctl.c: use GNU C case ranges
Date: Mon, 17 Aug 2026 19:26:26 -0500
Message-ID: <20260818002629.172827-7-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818002629.172827-1-simonxhy0404@gmail.com>
References: <20260818002629.172827-1-simonxhy0404@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oi1-x229.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace case fall throughs with case ranges when register addresses
are continous.

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260805153005.9989-7-simonxhy0404@gmail.com>
---
 hw/misc/iotkit-secctl.c | 112 ++++++----------------------------------
 1 file changed, 16 insertions(+), 96 deletions(-)

diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 9f6fb81088..2d06d6f80f 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -187,36 +187,24 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
     case A_BRGINTEN:
         r = s->brginten;
         break;
-    case A_AHBNSPPCEXP0:
-    case A_AHBNSPPCEXP1:
-    case A_AHBNSPPCEXP2:
-    case A_AHBNSPPCEXP3:
+    case A_AHBNSPPCEXP0 ... A_AHBNSPPCEXP3:
         r = s->ahbexp[offset_to_ppc_idx(offset)].ns;
         break;
     case A_APBNSPPC0:
     case A_APBNSPPC1:
         r = s->apb[offset_to_ppc_idx(offset)].ns;
         break;
-    case A_APBNSPPCEXP0:
-    case A_APBNSPPCEXP1:
-    case A_APBNSPPCEXP2:
-    case A_APBNSPPCEXP3:
+    case A_APBNSPPCEXP0 ... A_APBNSPPCEXP3:
         r = s->apbexp[offset_to_ppc_idx(offset)].ns;
         break;
-    case A_AHBSPPPCEXP0:
-    case A_AHBSPPPCEXP1:
-    case A_AHBSPPPCEXP2:
-    case A_AHBSPPPCEXP3:
+    case A_AHBSPPPCEXP0 ... A_AHBSPPPCEXP3:
         r = s->ahbexp[offset_to_ppc_idx(offset)].sp;
         break;
     case A_APBSPPPC0:
     case A_APBSPPPC1:
         r = s->apb[offset_to_ppc_idx(offset)].sp;
         break;
-    case A_APBSPPPCEXP0:
-    case A_APBSPPPCEXP1:
-    case A_APBSPPPCEXP2:
-    case A_APBSPPPCEXP3:
+    case A_APBSPPPCEXP0 ... A_APBSPPPCEXP3:
         r = s->apbexp[offset_to_ppc_idx(offset)].sp;
         break;
     case A_SECMSCINTSTAT:
@@ -228,18 +216,7 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
     case A_NSMSCEXP:
         r = s->nsmscexp;
         break;
-    case A_PID4:
-    case A_PID5:
-    case A_PID6:
-    case A_PID7:
-    case A_PID0:
-    case A_PID1:
-    case A_PID2:
-    case A_PID3:
-    case A_CID0:
-    case A_CID1:
-    case A_CID2:
-    case A_CID3:
+    case A_PID4 ... A_CID3:
         switch (s->sse_version) {
         case ARMSSE_SSE300:
             r = iotkit_secctl_s_sse300_idregs[(offset - A_PID4) / 4];
@@ -389,10 +366,7 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
     case A_BRGINTEN:
         s->brginten = value & 0xffff0000;
         break;
-    case A_AHBNSPPCEXP0:
-    case A_AHBNSPPCEXP1:
-    case A_AHBNSPPCEXP2:
-    case A_AHBNSPPCEXP3:
+    case A_AHBNSPPCEXP0 ... A_AHBNSPPCEXP3:
         ppc = &s->ahbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_ns_write(ppc, value);
         break;
@@ -401,17 +375,11 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
         ppc = &s->apb[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_ns_write(ppc, value);
         break;
-    case A_APBNSPPCEXP0:
-    case A_APBNSPPCEXP1:
-    case A_APBNSPPCEXP2:
-    case A_APBNSPPCEXP3:
+    case A_APBNSPPCEXP0 ... A_APBNSPPCEXP3:
         ppc = &s->apbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_ns_write(ppc, value);
         break;
-    case A_AHBSPPPCEXP0:
-    case A_AHBSPPPCEXP1:
-    case A_AHBSPPPCEXP2:
-    case A_AHBSPPPCEXP3:
+    case A_AHBSPPPCEXP0 ... A_AHBSPPPCEXP3:
         ppc = &s->ahbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_sp_write(ppc, value);
         break;
@@ -420,10 +388,7 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
         ppc = &s->apb[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_sp_write(ppc, value);
         break;
-    case A_APBSPPPCEXP0:
-    case A_APBSPPPCEXP1:
-    case A_APBSPPPCEXP2:
-    case A_APBSPPPCEXP3:
+    case A_APBSPPPCEXP0 ... A_APBSPPPCEXP3:
         ppc = &s->apbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_sp_write(ppc, value);
         break;
@@ -444,18 +409,7 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
     case A_BRGINTSTAT:
     case A_AHBNSPPC0:
     case A_AHBSPPPC0:
-    case A_PID4:
-    case A_PID5:
-    case A_PID6:
-    case A_PID7:
-    case A_PID0:
-    case A_PID1:
-    case A_PID2:
-    case A_PID3:
-    case A_CID0:
-    case A_CID1:
-    case A_CID2:
-    case A_CID3:
+    case A_PID4 ... A_CID3:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "IoTKit SecCtl S block write: "
                       "read-only offset 0x%x\n", offset);
@@ -482,34 +436,17 @@ static MemTxResult iotkit_secctl_ns_read(void *opaque, hwaddr addr,
     case A_AHBNSPPPC0:
         r = 0;
         break;
-    case A_AHBNSPPPCEXP0:
-    case A_AHBNSPPPCEXP1:
-    case A_AHBNSPPPCEXP2:
-    case A_AHBNSPPPCEXP3:
+    case A_AHBNSPPPCEXP0 ... A_AHBNSPPPCEXP3:
         r = s->ahbexp[offset_to_ppc_idx(offset)].nsp;
         break;
     case A_APBNSPPPC0:
     case A_APBNSPPPC1:
         r = s->apb[offset_to_ppc_idx(offset)].nsp;
         break;
-    case A_APBNSPPPCEXP0:
-    case A_APBNSPPPCEXP1:
-    case A_APBNSPPPCEXP2:
-    case A_APBNSPPPCEXP3:
+    case A_APBNSPPPCEXP0 ... A_APBNSPPPCEXP3:
         r = s->apbexp[offset_to_ppc_idx(offset)].nsp;
         break;
-    case A_PID4:
-    case A_PID5:
-    case A_PID6:
-    case A_PID7:
-    case A_PID0:
-    case A_PID1:
-    case A_PID2:
-    case A_PID3:
-    case A_CID0:
-    case A_CID1:
-    case A_CID2:
-    case A_CID3:
+    case A_PID4 ... A_CID3:
         switch (s->sse_version) {
         case ARMSSE_SSE300:
             r = iotkit_secctl_ns_sse300_idregs[(offset - A_PID4) / 4];
@@ -560,10 +497,7 @@ static MemTxResult iotkit_secctl_ns_write(void *opaque, hwaddr addr,
     }
 
     switch (offset) {
-    case A_AHBNSPPPCEXP0:
-    case A_AHBNSPPPCEXP1:
-    case A_AHBNSPPPCEXP2:
-    case A_AHBNSPPPCEXP3:
+    case A_AHBNSPPPCEXP0 ... A_AHBNSPPPCEXP3:
         ppc = &s->ahbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_nsp_write(ppc, value);
         break;
@@ -572,26 +506,12 @@ static MemTxResult iotkit_secctl_ns_write(void *opaque, hwaddr addr,
         ppc = &s->apb[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_nsp_write(ppc, value);
         break;
-    case A_APBNSPPPCEXP0:
-    case A_APBNSPPPCEXP1:
-    case A_APBNSPPPCEXP2:
-    case A_APBNSPPPCEXP3:
+    case A_APBNSPPPCEXP0 ... A_APBNSPPPCEXP3:
         ppc = &s->apbexp[offset_to_ppc_idx(offset)];
         iotkit_secctl_ppc_nsp_write(ppc, value);
         break;
     case A_AHBNSPPPC0:
-    case A_PID4:
-    case A_PID5:
-    case A_PID6:
-    case A_PID7:
-    case A_PID0:
-    case A_PID1:
-    case A_PID2:
-    case A_PID3:
-    case A_CID0:
-    case A_CID1:
-    case A_CID2:
-    case A_CID3:
+    case A_PID4 ... A_CID3:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "IoTKit SecCtl NS block write: "
                       "read-only offset 0x%x\n", offset);
-- 
2.53.0


