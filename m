Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD96CC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPqo-0007aM-Gz; Mon, 12 May 2025 05:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqb-0007Ys-67
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqY-0000fe-Sp
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kEA8gwAABu9nmeknGeEHK1bKLRjIK+6tDEYM+UBOQHw=;
 b=gQHSDVgJJ726aq6vjcJvILfIA+L0NUAtXV2YSpkunrvjX5oA4zUUvE3A1xutsAJbP2pYdm
 U3YU1QYbhaIi7v6XtTFg6ktRvJk5crice51oMNwooLdWhttCWGvlmbWxgj4ZznVaBXAk7w
 jiAoxsSX+qWRWypcBCphSmZ/mDguZik=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-sJHrNIssOXOHZrIe89OGAQ-1; Mon, 12 May 2025 05:53:16 -0400
X-MC-Unique: sJHrNIssOXOHZrIe89OGAQ-1
X-Mimecast-MFC-AGG-ID: sJHrNIssOXOHZrIe89OGAQ_1747043595
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad22aaa20f7so160243966b.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043594; x=1747648394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kEA8gwAABu9nmeknGeEHK1bKLRjIK+6tDEYM+UBOQHw=;
 b=qQB1CJg5+9dmB0tH+2Ys/rxs5mhrHmQfk8HH36Swj2FZ6NT551ZwDhrsC3VPadR21y
 gxy8phfEAxFhWJ/cF8aOJYnr8jxAPzbHQmV8YOWSlFGBSH+uv0cRwodV/jhTZpsqDYq9
 qX06NNB8zsB5j/hxpyasQFDpEcIPndHhoSCydgF1f+K8kdAhI6enDiIe6r00cjWcwWt/
 36cSZqgqPJfKUbd0T4rBkKAjxbSHnWhwAcKwBF038/eeSOQ0/Ib/w1+Tz6ky1VF4eefA
 ETT1iBTTb9iRWL/6UvE1GTN5/EKG5Ujs72i62+qQ9dugXMrn+7Njq3iOOnMldTDgPOrc
 DvYg==
X-Gm-Message-State: AOJu0YxEPcAHcTgwbUB8pZVYBTQOV2t+y39ov0tUVy5J76gJLa7Cg7bO
 bpvFAAy0qw2olwAPHaO3FwyuvIJxs1BO7LAstu9ABTo6kOVRcc6UAp8F1Rnl8cwAnSatBIeuVjI
 5o767CIiOhYrBFmIOFEmxK539FMgrDOiH/Uf2bayNQnVJ3CZyOItXkOtgvrlUNJyAwIvoNdIl9z
 7eAto3SJcDVTiDYoie0p8NReTvW7zlnKAtdWvl
X-Gm-Gg: ASbGnct7nEtFziqNQj23DSiXWtk/qf74iL1Nihtm3tSoEefYEMKIDSDv9TInbOFkoeb
 sjnsJQlsxn6MqOz+n95m/S06jrSbbQRqmkaFGBbFLOKme6RvsKAifRLUluscl3ixjVsQePdwi2x
 hEYJCfjNTJBLuK5BmmJRK7sElyuCi29o48MasPpAHhVSI/OGdSnBTAkvDg+TijFmGEQ7MVneLrM
 /ColOJzhonB26Hjr/X3pczQGhylBzMt9rWwAxQMnu6QQ7ZjmETYL8FRC3aMCID//6Isjf6SX1n+
 lDsjy7x3xFJrlk+j//agOzai2/raTxw3B+xoAaRNA/IAR0Y=
X-Received: by 2002:a17:907:cbc9:b0:ad2:3824:4ad7 with SMTP id
 a640c23a62f3a-ad238244c7fmr678672766b.56.1747043594398; 
 Mon, 12 May 2025 02:53:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxFCna/eTMMuaM7GMhWxY3UBlVmp17tUsJ55JR2g3TqaZtPt5QGqU8r/qFMFwWuW0JnZoDjw==
X-Received: by 2002:a17:907:cbc9:b0:ad2:3824:4ad7 with SMTP id
 a640c23a62f3a-ad238244c7fmr678670866b.56.1747043593907; 
 Mon, 12 May 2025 02:53:13 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2231ac35bsm526036466b.34.2025.05.12.02.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:53:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 02/26] target/riscv: cpu: store max SATP mode as a single
 integer
Date: Mon, 12 May 2025 11:52:02 +0200
Message-ID: <20250512095226.93621-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512095226.93621-1-pbonzini@redhat.com>
References: <20250512095226.93621-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The maximum available SATP mode implies all the shorter virtual address sizes.
Store it in RISCVCPUConfig and avoid recomputing it via satp_mode_max_from_map.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/cpu.c         | 11 +++++------
 target/riscv/tcg/tcg-cpu.c |  3 ++-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index cfe371b829d..c8ea5cdc870 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -196,6 +196,7 @@ struct RISCVCPUConfig {
 
     bool short_isa_string;
 
+    int8_t max_satp_mode;
     RISCVSATPMap satp_mode;
 };
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0f7ce5305be..32c283a6628 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -446,6 +446,7 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu,
     }
 
     assert(cpu->cfg.satp_mode.supported & (1 << satp_mode));
+    cpu->cfg.max_satp_mode = satp_mode;
 }
 
 /* Set the satp mode to the max supported */
@@ -1172,16 +1173,13 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 {
     bool rv32 = riscv_cpu_is_32bit(cpu);
-    uint8_t satp_mode_map_max, satp_mode_supported_max;
+    uint8_t satp_mode_map_max;
 
     /* The CPU wants the OS to decide which satp mode to use */
     if (cpu->cfg.satp_mode.supported == 0) {
         return;
     }
 
-    satp_mode_supported_max =
-                    satp_mode_max_from_map(cpu->cfg.satp_mode.supported);
-
     if (cpu->cfg.satp_mode.map == 0) {
         if (cpu->cfg.satp_mode.init == 0) {
             /* If unset by the user, we fallback to the default satp mode. */
@@ -1210,10 +1208,10 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
     satp_mode_map_max = satp_mode_max_from_map(cpu->cfg.satp_mode.map);
 
     /* Make sure the user asked for a supported configuration (HW and qemu) */
-    if (satp_mode_map_max > satp_mode_supported_max) {
+    if (satp_mode_map_max > cpu->cfg.max_satp_mode) {
         error_setg(errp, "satp_mode %s is higher than hw max capability %s",
                    satp_mode_str(satp_mode_map_max, rv32),
-                   satp_mode_str(satp_mode_supported_max, rv32));
+                   satp_mode_str(cpu->cfg.max_satp_mode, rv32));
         return;
     }
 
@@ -1473,6 +1471,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cbop_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
+    cpu->cfg.max_satp_mode = -1;
 }
 
 static void riscv_bare_cpu_init(Object *obj)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 55e00972b79..ab8659f3044 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -816,8 +816,9 @@ static bool riscv_cpu_validate_profile_satp(RISCVCPU *cpu,
                                             RISCVCPUProfile *profile,
                                             bool send_warn)
 {
-    int satp_max = satp_mode_max_from_map(cpu->cfg.satp_mode.supported);
+    int satp_max = cpu->cfg.max_satp_mode;
 
+    assert(satp_max >= 0);
     if (profile->satp_mode > satp_max) {
         if (send_warn) {
             bool is_32bit = riscv_cpu_is_32bit(cpu);
-- 
2.49.0


