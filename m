Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146D1C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPrD-0007eR-8q; Mon, 12 May 2025 05:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqw-0007bQ-An
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqu-0000hY-CC
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMXo66W8Fv+oEZ1N8r8N0cJj++ferTBKf7av3RQbUiw=;
 b=hc8RGu+2Nvj5s78rqskMf5xr+xQMVm8FkBS37RXdAGSQJbMGMeea0kerX5blFxSA6/uGeo
 pXI/JPcGHVwzkpGp9ETrbYvd5Ec8G7rzM322sxucWrWtvDa7XC+P+0UqrkZEV/81fuCdg0
 5LpLa+mZ5tJeM0TUGfsfZrR5/gWELSg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-PjzYJFb7Ngix6ELc5mxrdg-1; Mon, 12 May 2025 05:53:38 -0400
X-MC-Unique: PjzYJFb7Ngix6ELc5mxrdg-1
X-Mimecast-MFC-AGG-ID: PjzYJFb7Ngix6ELc5mxrdg_1747043617
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac6ef2d1b7dso430284366b.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043616; x=1747648416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QMXo66W8Fv+oEZ1N8r8N0cJj++ferTBKf7av3RQbUiw=;
 b=NyA1J+xHhAKdtV4OLjptLPB3KmGHTriLKRJ7qOVu9Epz64J7AZ9dMKH+j9HuYEWuui
 zykNewdTlhY821Wh3+7NIZxqnwT2Zss8zm64/VfibSy2fhpY68YnaitEECIZtzFVxXG4
 D0yzNBBDJtm2e8mhRr9+HlCSDkiNGvgOTsFF4AFnRC9JZqi5s46YnuKLasWiypB1lDVf
 WVTpgKQQ4jKvLXmQbx254nlceVQDnePhK1eARSzVGZ18vzhE/03VWs1Ktl9+Usa+H9Qy
 UFkWpueICeYMgpBpzI8SY4vzcUoWfXkte8fnHoQ1ztno2geKdnvf01eUEpynzLStkbdu
 E2SA==
X-Gm-Message-State: AOJu0YynxnO8D3SFZ3w7lipN16WqLrDjPKrgdcP1HqlOi41DxM91SNhm
 cilfSFUpkch+o7SjRudXhe16ASLKTyyu7kHYIcEAglo7BApgYuceKsZe6uWY0+Aahl64VvZ6m+V
 fBdEXVwJ9Iz1KaBEJZBc0Y2sYmXf5e1PCO6ZIUVT9sLMMo+dbLJcoIjZ3g52EuE5uLm4vlOc9hF
 Q8+V3tEO7T8DYn5fPRV4ga1YkxrGTRNKksSmqR
X-Gm-Gg: ASbGncviJVXTmsfbtf+ypG4shK/wY3l56D99wnaJ+FeqdktSr2eI3ec8obnoDiL0GSl
 x8Yr1MMEuCHLyNS6jroL/m7yOMAUCLMcd99D3VSlrvkmuITBe8ZB1bdR46zQeDQdDdt5EEz/K3V
 8c6FLC0gkQ0SHq5taLarWcPss8AevtN4hTlBz8cmZeO7Rs/zj/8kbk2EbZeu5/8AllFxpR5rZa1
 SpmK/6+dmI6LZzyLjAB7ieQUjxxaF/ZSpZPQt4/pi62DaF51PLnLtdCMwfd/XSi0ZuonNazfdrx
 XB+jBwTKNYlH0G8Z31rvElDJz+DYdR2p/BXyW+eVHTJqh80=
X-Received: by 2002:a17:907:cbc9:b0:ad2:3824:4ad7 with SMTP id
 a640c23a62f3a-ad238244c7fmr678746566b.56.1747043616204; 
 Mon, 12 May 2025 02:53:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe3yGp/yfiXWPhSn3WH4LhLMfzBmy7BU8hSZDg3ckZ0GsgDUIVhJSQokKUfcBD1SFrFt7QqA==
X-Received: by 2002:a17:907:cbc9:b0:ad2:3824:4ad7 with SMTP id
 a640c23a62f3a-ad238244c7fmr678744366b.56.1747043615743; 
 Mon, 12 May 2025 02:53:35 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2368735f4sm423770766b.146.2025.05.12.02.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:53:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 09/26] target/riscv: move RISCVCPUConfig fields to a header
 file
Date: Mon, 12 May 2025 11:52:09 +0200
Message-ID: <20250512095226.93621-10-pbonzini@redhat.com>
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

To support merging a subclass's RISCVCPUDef into the superclass, a list
of all the CPU features is needed.  Put them into a header file that
can be included multiple times, expanding the macros BOOL_FIELD and
TYPE_FIELD to different operations.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu_cfg.h            | 163 +---------------------------
 target/riscv/cpu_cfg_fields.h.inc | 170 ++++++++++++++++++++++++++++++
 2 files changed, 173 insertions(+), 160 deletions(-)
 create mode 100644 target/riscv/cpu_cfg_fields.h.inc

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8fa73c8a07d..e9bf75730a6 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -22,166 +22,9 @@
 #define RISCV_CPU_CFG_H
 
 struct RISCVCPUConfig {
-    bool ext_zba;
-    bool ext_zbb;
-    bool ext_zbc;
-    bool ext_zbkb;
-    bool ext_zbkc;
-    bool ext_zbkx;
-    bool ext_zbs;
-    bool ext_zca;
-    bool ext_zcb;
-    bool ext_zcd;
-    bool ext_zce;
-    bool ext_zcf;
-    bool ext_zcmp;
-    bool ext_zcmt;
-    bool ext_zk;
-    bool ext_zkn;
-    bool ext_zknd;
-    bool ext_zkne;
-    bool ext_zknh;
-    bool ext_zkr;
-    bool ext_zks;
-    bool ext_zksed;
-    bool ext_zksh;
-    bool ext_zkt;
-    bool ext_zifencei;
-    bool ext_zicntr;
-    bool ext_zicsr;
-    bool ext_zicbom;
-    bool ext_zicbop;
-    bool ext_zicboz;
-    bool ext_zicfilp;
-    bool ext_zicfiss;
-    bool ext_zicond;
-    bool ext_zihintntl;
-    bool ext_zihintpause;
-    bool ext_zihpm;
-    bool ext_zimop;
-    bool ext_zcmop;
-    bool ext_ztso;
-    bool ext_smstateen;
-    bool ext_sstc;
-    bool ext_smcdeleg;
-    bool ext_ssccfg;
-    bool ext_smcntrpmf;
-    bool ext_smcsrind;
-    bool ext_sscsrind;
-    bool ext_ssdbltrp;
-    bool ext_smdbltrp;
-    bool ext_svadu;
-    bool ext_svinval;
-    bool ext_svnapot;
-    bool ext_svpbmt;
-    bool ext_svvptc;
-    bool ext_svukte;
-    bool ext_zdinx;
-    bool ext_zaamo;
-    bool ext_zacas;
-    bool ext_zama16b;
-    bool ext_zabha;
-    bool ext_zalrsc;
-    bool ext_zawrs;
-    bool ext_zfa;
-    bool ext_zfbfmin;
-    bool ext_zfh;
-    bool ext_zfhmin;
-    bool ext_zfinx;
-    bool ext_zhinx;
-    bool ext_zhinxmin;
-    bool ext_zve32f;
-    bool ext_zve32x;
-    bool ext_zve64f;
-    bool ext_zve64d;
-    bool ext_zve64x;
-    bool ext_zvbb;
-    bool ext_zvbc;
-    bool ext_zvkb;
-    bool ext_zvkg;
-    bool ext_zvkned;
-    bool ext_zvknha;
-    bool ext_zvknhb;
-    bool ext_zvksed;
-    bool ext_zvksh;
-    bool ext_zvkt;
-    bool ext_zvkn;
-    bool ext_zvknc;
-    bool ext_zvkng;
-    bool ext_zvks;
-    bool ext_zvksc;
-    bool ext_zvksg;
-    bool ext_zmmul;
-    bool ext_zvfbfmin;
-    bool ext_zvfbfwma;
-    bool ext_zvfh;
-    bool ext_zvfhmin;
-    bool ext_smaia;
-    bool ext_ssaia;
-    bool ext_smctr;
-    bool ext_ssctr;
-    bool ext_sscofpmf;
-    bool ext_smepmp;
-    bool ext_smrnmi;
-    bool ext_ssnpm;
-    bool ext_smnpm;
-    bool ext_smmpm;
-    bool ext_sspm;
-    bool ext_supm;
-    bool rvv_ta_all_1s;
-    bool rvv_ma_all_1s;
-    bool rvv_vl_half_avl;
-
-    uint32_t mvendorid;
-    uint64_t marchid;
-    uint64_t mimpid;
-
-    /* Named features  */
-    bool ext_svade;
-    bool ext_zic64b;
-    bool ext_ssstateen;
-    bool ext_sha;
-
-    /*
-     * Always 'true' booleans for named features
-     * TCG always implement/can't be user disabled,
-     * based on spec version.
-     */
-    bool has_priv_1_13;
-    bool has_priv_1_12;
-    bool has_priv_1_11;
-
-    /* Always enabled for TCG if has_priv_1_11 */
-    bool ext_ziccrse;
-
-    /* Vendor-specific custom extensions */
-    bool ext_xtheadba;
-    bool ext_xtheadbb;
-    bool ext_xtheadbs;
-    bool ext_xtheadcmo;
-    bool ext_xtheadcondmov;
-    bool ext_xtheadfmemidx;
-    bool ext_xtheadfmv;
-    bool ext_xtheadmac;
-    bool ext_xtheadmemidx;
-    bool ext_xtheadmempair;
-    bool ext_xtheadsync;
-    bool ext_XVentanaCondOps;
-
-    uint32_t pmu_mask;
-    uint16_t vlenb;
-    uint16_t elen;
-    uint16_t cbom_blocksize;
-    uint16_t cbop_blocksize;
-    uint16_t cboz_blocksize;
-    bool mmu;
-    bool pmp;
-    bool debug;
-    bool misa_w;
-
-    bool short_isa_string;
-
-    int8_t max_satp_mode;
+#define BOOL_FIELD(x) bool x;
+#define TYPED_FIELD(type, x) type x;
+#include "cpu_cfg_fields.h.inc"
 };
 
 typedef struct RISCVCPUConfig RISCVCPUConfig;
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
new file mode 100644
index 00000000000..cb86bfc5dc3
--- /dev/null
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -0,0 +1,170 @@
+/*
+ * Required definitions before including this file:
+ *
+ * #define BOOL_FIELD(x)
+ * #define TYPED_FIELD(type, x)
+ */
+
+BOOL_FIELD(ext_zba)
+BOOL_FIELD(ext_zbb)
+BOOL_FIELD(ext_zbc)
+BOOL_FIELD(ext_zbkb)
+BOOL_FIELD(ext_zbkc)
+BOOL_FIELD(ext_zbkx)
+BOOL_FIELD(ext_zbs)
+BOOL_FIELD(ext_zca)
+BOOL_FIELD(ext_zcb)
+BOOL_FIELD(ext_zcd)
+BOOL_FIELD(ext_zce)
+BOOL_FIELD(ext_zcf)
+BOOL_FIELD(ext_zcmp)
+BOOL_FIELD(ext_zcmt)
+BOOL_FIELD(ext_zk)
+BOOL_FIELD(ext_zkn)
+BOOL_FIELD(ext_zknd)
+BOOL_FIELD(ext_zkne)
+BOOL_FIELD(ext_zknh)
+BOOL_FIELD(ext_zkr)
+BOOL_FIELD(ext_zks)
+BOOL_FIELD(ext_zksed)
+BOOL_FIELD(ext_zksh)
+BOOL_FIELD(ext_zkt)
+BOOL_FIELD(ext_zifencei)
+BOOL_FIELD(ext_zicntr)
+BOOL_FIELD(ext_zicsr)
+BOOL_FIELD(ext_zicbom)
+BOOL_FIELD(ext_zicbop)
+BOOL_FIELD(ext_zicboz)
+BOOL_FIELD(ext_zicfilp)
+BOOL_FIELD(ext_zicfiss)
+BOOL_FIELD(ext_zicond)
+BOOL_FIELD(ext_zihintntl)
+BOOL_FIELD(ext_zihintpause)
+BOOL_FIELD(ext_zihpm)
+BOOL_FIELD(ext_zimop)
+BOOL_FIELD(ext_zcmop)
+BOOL_FIELD(ext_ztso)
+BOOL_FIELD(ext_smstateen)
+BOOL_FIELD(ext_sstc)
+BOOL_FIELD(ext_smcdeleg)
+BOOL_FIELD(ext_ssccfg)
+BOOL_FIELD(ext_smcntrpmf)
+BOOL_FIELD(ext_smcsrind)
+BOOL_FIELD(ext_sscsrind)
+BOOL_FIELD(ext_ssdbltrp)
+BOOL_FIELD(ext_smdbltrp)
+BOOL_FIELD(ext_svadu)
+BOOL_FIELD(ext_svinval)
+BOOL_FIELD(ext_svnapot)
+BOOL_FIELD(ext_svpbmt)
+BOOL_FIELD(ext_svvptc)
+BOOL_FIELD(ext_svukte)
+BOOL_FIELD(ext_zdinx)
+BOOL_FIELD(ext_zaamo)
+BOOL_FIELD(ext_zacas)
+BOOL_FIELD(ext_zama16b)
+BOOL_FIELD(ext_zabha)
+BOOL_FIELD(ext_zalrsc)
+BOOL_FIELD(ext_zawrs)
+BOOL_FIELD(ext_zfa)
+BOOL_FIELD(ext_zfbfmin)
+BOOL_FIELD(ext_zfh)
+BOOL_FIELD(ext_zfhmin)
+BOOL_FIELD(ext_zfinx)
+BOOL_FIELD(ext_zhinx)
+BOOL_FIELD(ext_zhinxmin)
+BOOL_FIELD(ext_zve32f)
+BOOL_FIELD(ext_zve32x)
+BOOL_FIELD(ext_zve64f)
+BOOL_FIELD(ext_zve64d)
+BOOL_FIELD(ext_zve64x)
+BOOL_FIELD(ext_zvbb)
+BOOL_FIELD(ext_zvbc)
+BOOL_FIELD(ext_zvkb)
+BOOL_FIELD(ext_zvkg)
+BOOL_FIELD(ext_zvkned)
+BOOL_FIELD(ext_zvknha)
+BOOL_FIELD(ext_zvknhb)
+BOOL_FIELD(ext_zvksed)
+BOOL_FIELD(ext_zvksh)
+BOOL_FIELD(ext_zvkt)
+BOOL_FIELD(ext_zvkn)
+BOOL_FIELD(ext_zvknc)
+BOOL_FIELD(ext_zvkng)
+BOOL_FIELD(ext_zvks)
+BOOL_FIELD(ext_zvksc)
+BOOL_FIELD(ext_zvksg)
+BOOL_FIELD(ext_zmmul)
+BOOL_FIELD(ext_zvfbfmin)
+BOOL_FIELD(ext_zvfbfwma)
+BOOL_FIELD(ext_zvfh)
+BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_smaia)
+BOOL_FIELD(ext_ssaia)
+BOOL_FIELD(ext_smctr)
+BOOL_FIELD(ext_ssctr)
+BOOL_FIELD(ext_sscofpmf)
+BOOL_FIELD(ext_smepmp)
+BOOL_FIELD(ext_smrnmi)
+BOOL_FIELD(ext_ssnpm)
+BOOL_FIELD(ext_smnpm)
+BOOL_FIELD(ext_smmpm)
+BOOL_FIELD(ext_sspm)
+BOOL_FIELD(ext_supm)
+BOOL_FIELD(rvv_ta_all_1s)
+BOOL_FIELD(rvv_ma_all_1s)
+BOOL_FIELD(rvv_vl_half_avl)
+/* Named features  */
+BOOL_FIELD(ext_svade)
+BOOL_FIELD(ext_zic64b)
+BOOL_FIELD(ext_ssstateen)
+BOOL_FIELD(ext_sha)
+
+/*
+ * Always 'true' booleans for named features
+ * TCG always implement/can't be user disabled,
+ * based on spec version.
+ */
+BOOL_FIELD(has_priv_1_13)
+BOOL_FIELD(has_priv_1_12)
+BOOL_FIELD(has_priv_1_11)
+
+/* Always enabled for TCG if has_priv_1_11 */
+BOOL_FIELD(ext_ziccrse)
+
+/* Vendor-specific custom extensions */
+BOOL_FIELD(ext_xtheadba)
+BOOL_FIELD(ext_xtheadbb)
+BOOL_FIELD(ext_xtheadbs)
+BOOL_FIELD(ext_xtheadcmo)
+BOOL_FIELD(ext_xtheadcondmov)
+BOOL_FIELD(ext_xtheadfmemidx)
+BOOL_FIELD(ext_xtheadfmv)
+BOOL_FIELD(ext_xtheadmac)
+BOOL_FIELD(ext_xtheadmemidx)
+BOOL_FIELD(ext_xtheadmempair)
+BOOL_FIELD(ext_xtheadsync)
+BOOL_FIELD(ext_XVentanaCondOps)
+
+BOOL_FIELD(mmu)
+BOOL_FIELD(pmp)
+BOOL_FIELD(debug)
+BOOL_FIELD(misa_w)
+
+BOOL_FIELD(short_isa_string)
+
+TYPED_FIELD(uint32_t, mvendorid)
+TYPED_FIELD(uint64_t, marchid)
+TYPED_FIELD(uint64_t, mimpid)
+
+TYPED_FIELD(uint32_t, pmu_mask)
+TYPED_FIELD(uint16_t, vlenb)
+TYPED_FIELD(uint16_t, elen)
+TYPED_FIELD(uint16_t, cbom_blocksize)
+TYPED_FIELD(uint16_t, cbop_blocksize)
+TYPED_FIELD(uint16_t, cboz_blocksize)
+
+TYPED_FIELD(int8_t, max_satp_mode)
+
+#undef BOOL_FIELD
+#undef TYPED_FIELD
-- 
2.49.0


