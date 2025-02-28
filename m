Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44BDC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxbS-0002Gt-9U; Fri, 28 Feb 2025 05:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbN-0002AN-7v
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbJ-0002xv-7A
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/OUODJrGnYwHiF+Y9XJhzPuPMtc9dGJVlmyfLsL3kg=;
 b=HgPZZMpb6/tXffTammP3140nPySiq8aZbQBXKLu5+/ELW8p1iG3X9pd2sLxN989PVfAFWA
 pb7ZNS+a4AxAk3THPbD0AXn3PrfHIaiH6lZuqIkUtOPWNlyyfT+TYvdRiIlKpwYBGQO/vZ
 rNsRqwq2tn77VIhdXMkZwCihLl1XMvw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-HmyJc7EeOGKUfVBsvQePqg-1; Fri, 28 Feb 2025 05:28:09 -0500
X-MC-Unique: HmyJc7EeOGKUfVBsvQePqg-1
X-Mimecast-MFC-AGG-ID: HmyJc7EeOGKUfVBsvQePqg_1740738489
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390e5214efdso1118083f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738487; x=1741343287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/OUODJrGnYwHiF+Y9XJhzPuPMtc9dGJVlmyfLsL3kg=;
 b=LTblHi1BEBHSa4DPJIr78hdtRoSMcDgwU3RnjCEcdVkDcLVBEHejKurmst3amxSf2f
 e6BWfPqOa4jIu0pJi33B0NcSTjSHtPgg7XuWM7u2xXpxweleSOlC92X/as8PackvtEth
 iB8LS69O6D5e6QD3DD0OMSWCiaItRR5cQqsm01z9j6D444eJ6t9945pOj05fL/hkLe79
 8UQkP0ZqZY32QYGpJtLDK7CWz9Ruw5xGUJSs3n5P8kh4h/MJ96WCNRMEtdNAIFN2SQxG
 CvgfYMOivMVv4Jjh/eWQDqjKyi6H6YiiUeNhpcLKjCpR7I6L1fKffo8O/xqatFM7mi41
 rBZA==
X-Gm-Message-State: AOJu0YxejQns5PmgmDWrp+OOvfYLV3y/qICKRW6LAa82eXk6T0L3sYNi
 zIfIx74QU7ToKmSvrwCRI96lx7mYyGXvw/4ohfiaP/WEVyq+EK/UVdeAc2epHWSTRunY3/eT1uI
 TQJglO3pq/NR0dTaAb22bKYrfl4QL6Ij6tpXUgyTxq1Ako4ksQf0ogBuzG4qyflOiHZrtRrdoFH
 e1pOSAAZtyX2CgQUNBGeBpAF8GcWVDRbFVJbDQURs=
X-Gm-Gg: ASbGncufJK4wY11sjwN87/zlsuoU/+wqw/Bx3O9B8pP4Gsn6pfYQ/RFe8F1pgs+g1TE
 x6B5Gvw0xtNveoYeLysGwlbT9AXLbBrH9FETJsdCYljYeBeNX28yFKZa84fbRkAwcb83re9Fek7
 wLCrAdlZTCXyl7wNfwpebkzz3BTLivJOV40ii2i2J97Rkz58vdhkRG5EWTmgsQNAU+d4ooXC917
 NzerX+ZbxfYYCIixQcdK/2x1zBR+YaX98HjnPG3bBpoh+hQ5zrZIzMRaz/IcukYiaAarAHbiiU6
 gyrq4rjGJ+sX+XL4lAiU
X-Received: by 2002:a05:6000:2cd:b0:38d:d3e2:db32 with SMTP id
 ffacd0b85a97d-390ec7c692fmr2001369f8f.7.1740738486847; 
 Fri, 28 Feb 2025 02:28:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErgbpgAb3GUKjDfZ/ePctu4z7AdyFjS3BFeR1QJI4rhXpJCExZ5op7hJZ4SywFTSxINICY9g==
X-Received: by 2002:a05:6000:2cd:b0:38d:d3e2:db32 with SMTP id
 ffacd0b85a97d-390ec7c692fmr2001347f8f.7.1740738486454; 
 Fri, 28 Feb 2025 02:28:06 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b7a27af83sm53001685e9.30.2025.02.28.02.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:28:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 09/22] target/riscv: do not make RISCVCPUConfig fields
 conditional
Date: Fri, 28 Feb 2025 11:27:33 +0100
Message-ID: <20250228102747.867770-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228102747.867770-1-pbonzini@redhat.com>
References: <20250228102747.867770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Avoid the need for #ifdefs in CPU declarations, keeping them
simple.  After all class_data used to be specified for all
emulators, not just system ones.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu_cfg_fields.h.inc | 2 --
 target/riscv/cpu.c                | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index a42f298017f..a08d85aec26 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -159,9 +159,7 @@ TYPED_FIELD(uint16_t, cbom_blocksize)
 TYPED_FIELD(uint16_t, cbop_blocksize)
 TYPED_FIELD(uint16_t, cboz_blocksize)
 
-#ifndef CONFIG_USER_ONLY
 TYPED_FIELD(int8_t, max_satp_mode)
-#endif
 
 #undef BOOL_FIELD
 #undef TYPED_FIELD
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e9d8126360e..cbb6cde082b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1483,10 +1483,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cbop_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
-
-#ifndef CONFIG_USER_ONLY
     cpu->cfg.max_satp_mode = -1;
-#endif /* CONFIG_USER_ONLY */
 
     env->misa_ext_mask = env->misa_ext = mcc->def->misa_ext;
     riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);
-- 
2.48.1


