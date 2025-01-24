Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2622DC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGFc-0006mR-H7; Fri, 24 Jan 2025 04:45:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFU-0006di-6A
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFS-0003rk-F6
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+EjvWyBBLr0j+Oba7qUT580r4IhKj6r/hq6xSJZJ4U=;
 b=akA93CrsLdp/2T1UXBM4IpPrD+mIhFG1ycQ+eZoKWV3KUAGG8mSy30hlkhMsnHw2DxjSs5
 LlOaDg0DOnGqdalPdB9n6NcWK2wEx6iG+FF6Z+F0OW8Pb4JkI+pafclATXEICNL2e79BjG
 ze6dcUWfkGCf0A7XN78L0YU9yWKcSDw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-nGhk_kT6PpWh_5hi8ennjw-1; Fri, 24 Jan 2025 04:45:07 -0500
X-MC-Unique: nGhk_kT6PpWh_5hi8ennjw-1
X-Mimecast-MFC-AGG-ID: nGhk_kT6PpWh_5hi8ennjw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38a35a65575so1231115f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711905; x=1738316705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+EjvWyBBLr0j+Oba7qUT580r4IhKj6r/hq6xSJZJ4U=;
 b=knRqqf6WpbaorqKkTAHsyf6jP3OqdIbeVe6jWT/JOQnpsFjQiUTobQl+g+4uzzsd3d
 tyrPdPli+hz3NQHP+XmmeaGu1+tXb7dnpzyaRxjHgDCkNMfVPpVqumdvGpjmvIE7n09q
 NZ/ntwWNv3jyAf1MNHJ1WX1zUdMcnWS3ibmMHyDYgqDWejtCbQYquQO2Gk9yUv/dForO
 uUbFNCobj0J9xymfHd54Q6CYWChhU/bBbkvXqOTcwAcwXYeGb5bAeSWjfyhJciV4XDjd
 wFBC0Z0SnlTMo2vAkeKWcrygdgmXQ4AQoe7aMCDFLFKrmq3mB5+W6kGIlv4t3HkaxpgF
 /fVQ==
X-Gm-Message-State: AOJu0YwhEwRP8w5kR+crIa6SISnN/IIjCyQvNdRXBqrYNnpFKpKtBavG
 aBjIEDoSgBJVRdfEVpvMnt84PM+VI05f4znNvijerFQk9Tzq7tEaKPcMZsyC4OaFGrgiyiDygfs
 4a37zt0tojDCpuWRi+soYFbWI08a8yhyA+dlA2erfB0vKIpI+yKhYAzXCZgs8R6dGIfg3ZFDl4r
 7bUNrVUfNH4XlS62+7dwQc35H9P27QcFH77fW1aSo=
X-Gm-Gg: ASbGncu+oxsXuUCPLwLkbo9/x9hCLS3zbbmVCpP8NAeaGMNzNxuH4P54rGPbN1sR4qw
 CPnc+QKe7IRpn284AjmBoOyte9MDabmnpiOK1jCOkbbYeZt9U3aQMVU+uzgXU13xZOlne7Tpyu2
 +reJsY9JDe7LHJgZvkSP7VyKFrHwpwc17zrF5mA0IcgtIjO85XxFL8my1YzaH7c8JC/bSpAZuk/
 jxsDckSZ1yNeOm3PNDmr/q8Rl3a1CoLp8Vv8TuycXIme0zNMdFMc9hZ4Ll27mgl0Rjf04FIoQ==
X-Received: by 2002:a05:6000:18a7:b0:386:4312:53ec with SMTP id
 ffacd0b85a97d-38bf5663683mr28192927f8f.17.1737711905568; 
 Fri, 24 Jan 2025 01:45:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn2BYucTSAWxjnLcS3iUiS8XF8nq//l8IrLbf4kksWUcyoKXYKV0x+Rio1bYTuFrVvTK9TLQ==
X-Received: by 2002:a05:6000:18a7:b0:386:4312:53ec with SMTP id
 ffacd0b85a97d-38bf5663683mr28192893f8f.17.1737711905037; 
 Fri, 24 Jan 2025 01:45:05 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188689sm2174083f8f.48.2025.01.24.01.45.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/48] target/i386: do not use gen_op_jz_ecx for repeated
 string operations
Date: Fri, 24 Jan 2025 10:44:04 +0100
Message-ID: <20250124094442.13207-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

Explicitly generate a TSTEQ branch (which is optimized to NE x,0 if possible).
This does not make much sense yet, but later we will add more checks and some
will use a temporary to check on the decremented value of CX/ECX/RCX; it will
be clearer for all checks to share the same logic using TSTEQ(reg, cx_mask).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241215090613.89588-10-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 8bc91c3de31..7a3caf8b996 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1338,6 +1338,7 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
                        bool is_repz_nz)
 {
     TCGLabel *done = gen_new_label();
+    target_ulong cx_mask = MAKE_64BIT_MASK(0, 8 << s->aflag);
     bool had_rf = s->flags & HF_RF_MASK;
 
     /*
@@ -1360,7 +1361,7 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
     tcg_set_insn_start_param(s->base.insn_start, 1, CC_OP_DYNAMIC);
 
     /* Any iteration at all?  */
-    gen_op_jz_ecx(s, done);
+    tcg_gen_brcondi_tl(TCG_COND_TSTEQ, cpu_regs[R_ECX], cx_mask, done);
 
     fn(s, ot);
     gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
-- 
2.48.1


