Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65424C1B0FF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnely-0001yG-EK; Thu, 27 Feb 2025 09:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnel7-0007td-Od
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:21:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnel6-0003sa-8Q
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DNRcGZG9VCey+RCXjFT/3nzg+eoPhsw8VV+4T8TIEPQ=;
 b=T97BhxVtfB13999Y3V3mF+81Jhy4jWQxwFMgeWSMD66CE+gzqsF0dDmZ7Aaw0Bhb7UeKe5
 mtaRwYRCZR6ATA6UQD2IEHjRbLh4LSvqt3qA0EjgcvSv762Wctil0ITOM/VqbdFk0hEXwa
 afmtZsBivsq/IGWIQOlKWzzzaTDiQb4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-HqeMUlXXNjCa1QNAXe7YHA-1; Thu, 27 Feb 2025 09:21:02 -0500
X-MC-Unique: HqeMUlXXNjCa1QNAXe7YHA-1
X-Mimecast-MFC-AGG-ID: HqeMUlXXNjCa1QNAXe7YHA_1740666061
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-abf16f47749so73159266b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666060; x=1741270860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DNRcGZG9VCey+RCXjFT/3nzg+eoPhsw8VV+4T8TIEPQ=;
 b=Cxq34rnA5fZIXN/6ZHYBplt90slKQNRcUuGyWbnNV7ger9ryk0eCh+x33o1CJ3dcg+
 aIl37LoWPommi5mY+IGAszrhMQnrbvvXNimr9Q/kABPulWnK05Prp0yepRaQ0RsL/vnP
 Is3Zde8DR9T45oZEPfDo2sLmdmAXK6cW2+3BvB3MeY9F2YvmIvSV+AxUTx0+XFSbshzC
 HKgTFnCSHztyL31uciFNWG4q0T/hmgz9GM6EiWJOIgeN9tuU6+hZaJcQmkF4wFMKLCyt
 eAxA0ZppQgasNdEcQeP3sq+rOyjISgtp5tirFo9lqJn47IpCstpBkmWvUWVOdhcDFR0i
 DJkQ==
X-Gm-Message-State: AOJu0YziTFwJ5NxP5EBZiuO/vvIH7pVl3pCPX3ewWHX7wFJsR3TSV8Z9
 ZcmpRUUDf9Fu+F9wK+oOCpCsfyuQKmadv/iG80MQQSPkysEo07j5MW/wF+TUysGYnYxH+t2kDfn
 ly44NqQrqLYxMkftz3zRIK4yMxuX9B7DBZ8hdIG0i38kTHSaPSi4p9toBL5iMJvaVPJaXLUy66s
 UOyiL+a9tatK2HG8tmOgdvgw2sw2nbeayRsPkcwwU=
X-Gm-Gg: ASbGncu+yMYLQd9tKH9fPSNP++/o/Ehy/hV5ru0WxCWlb35dkGm67whnbk+9zaIEM1v
 kHrSPL/E+3F7dOdgZInuze/7nntCNgDIX1/bUnDoBSwwsUvSvaKfd+mBzDd5MDup6XBlolBUhYW
 3ctJXausyXnjNmeTvkw/cbellWPEYyd6JlnxmJG8PR+6diBpFJU46S9oGDm4931NwG5/K3rsLWF
 DsoPQODow9fGUkapAoJtnp617UGtL1ujYyoVXubsxTHqoy6fKj5dmjRYDWqVpn8C5XZy/v+UAmM
 Q5Z731/X4fNrsOsjILKv
X-Received: by 2002:a17:907:96ac:b0:ab7:d34a:8f83 with SMTP id
 a640c23a62f3a-abf0609c4d0mr495584566b.17.1740666060479; 
 Thu, 27 Feb 2025 06:21:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTX43Of/Epghw8hmGmiD6O53NB4l4EKHhhOOXLQoiHx+uUS/N88FvCkGJmZEDfGpdAio5RTA==
X-Received: by 2002:a17:907:96ac:b0:ab7:d34a:8f83 with SMTP id
 a640c23a62f3a-abf0609c4d0mr495580966b.17.1740666059998; 
 Thu, 27 Feb 2025 06:20:59 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf1da15621sm48601066b.106.2025.02.27.06.20.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/34] target/riscv: move 128-bit check to TCG realize
Date: Thu, 27 Feb 2025 15:19:48 +0100
Message-ID: <20250227141952.811410-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Besides removing non-declarative code in instance_init, this also fixes
an issue with query-cpu-model-expansion.  Just invoking it for the
x-rv128 CPU model causes QEMU to exit immediately.  With this patch it
is possible to do

  {'execute': 'query-cpu-model-expansion',
   'arguments':{'type': 'full', 'model': {'name': 'x-rv128'}}}

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c         | 7 -------
 target/riscv/tcg/tcg-cpu.c | 9 +++++++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0dcde546e47..d7ecf729d05 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -700,13 +700,6 @@ static void rv128_base_cpu_init(Object *obj)
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
 
-    if (qemu_tcg_mttcg_enabled()) {
-        /* Missing 128-bit aligned atomics */
-        error_report("128-bit RISC-V currently does not work with Multi "
-                     "Threaded TCG. Please use: -accel tcg,thread=single");
-        exit(EXIT_FAILURE);
-    }
-
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 0a137281de1..d7e694fdb3d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1014,6 +1014,7 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
 static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
 
     if (!riscv_cpu_tcg_compatible(cpu)) {
         g_autofree char *name = riscv_cpu_get_name(cpu);
@@ -1022,6 +1023,14 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
+    if (mcc->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
+        /* Missing 128-bit aligned atomics */
+        error_setg(errp,
+                   "128-bit RISC-V currently does not work with Multi "
+                   "Threaded TCG. Please use: -accel tcg,thread=single");
+        return false;
+    }
+
 #ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
 
-- 
2.48.1


