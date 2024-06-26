Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEECC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 06:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMLhr-0002lt-08; Wed, 26 Jun 2024 02:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sMLhp-0002lT-1b
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 02:00:33 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sMLhm-0007DG-My
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 02:00:32 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-706a1711ee5so713036b3a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 23:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1719381629; x=1719986429; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gzDXvjrewE5wEaK8y3NuO9xksd/BS2FHACDJu8v7xLA=;
 b=YVsCyN/8dt5vtmF2ts4m2R+tQqDA1cBVyjc85BGoE7ZLtMZ1R+G/WkEp6SLq9BSpDK
 X8zw4iSj6ycPpiGg+XpmXlqUyk92OSWfXxcgKgDQc5QchC/99UmTNJg4atqPj4nUI0Z2
 NeaPr6xPFE2pFKRumSeup95nOi9K2+Sel1W65PL3z+omU77qBRNJheTBKBdUQf8m9Je7
 AiEU3cW1toe0P+I+8z3Ju9i37hJRSwSyDNZaYLTmmCcEDq+2OQEOWRVXMcxFU8iVYOCu
 tw9H/0a4jBMOxtzTlZpdpmkZhvkrAbNInkx0zGxImWso3d/TmHeNrf+IRtCD9k4KJIfp
 nbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719381629; x=1719986429;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gzDXvjrewE5wEaK8y3NuO9xksd/BS2FHACDJu8v7xLA=;
 b=rmGx+A5stnn/cNzxMmTFwFc9rrNVk8mP9QIP412jX/2xX1YEb+g8S5ecHtDeAEc9f9
 h5+d/MtbACEDVJLN7pYw1Cpt2XVELqTopAdrwhUQuTlo1c3cr9IXT4huuJf9y2x/uee6
 UCLgmuECJCiw09ICpEcbadnuuSa48OIDsYZGrBlnqkf4WXNzsReMp/XnWvgWuNGAFhpX
 HVTxZiRwUYnfFuXc4hYSyLV8JZCUogI6D2uLftjR2/j2s2m7effrdQokIa5RTIQvrbmA
 7W4ebKheU69G+cBOdC7AsxTIX0MnQYyVloI9CC/wltUdQvCwA0mmUF/Pm66EIEBGIxv6
 AB+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8fm9K6LMc82tZf8JubLD46rWf+Z8u2kOzMTFg4DLhV0hsv24nSWwXTxovZgtHU6EbsA4ErwNb77n5fqXkGjCo4fRDnok=
X-Gm-Message-State: AOJu0YyAUsR3Cu85xPphJhyFpOOHCFlN+Dl48/Szg+Fdozwgy/5U515V
 9Yr1+vS7Y9zPb1TtMYivT17eLQKHhZsOPC28PxnQ1RXmerj/gBlxxRzk3XhETQY=
X-Google-Smtp-Source: AGHT+IG6Gq76L5Hm2zcw/2fSm2/HH2n/RogzzeA1C1IQStXp6YpObZqFuzbjJS/+UUw0bE1Qs1S4KQ==
X-Received: by 2002:a05:6a00:1715:b0:706:6af8:e088 with SMTP id
 d2e1a72fcca58-7067459c778mr8814239b3a.3.1719381628456; 
 Tue, 25 Jun 2024 23:00:28 -0700 (PDT)
Received: from [192.168.100.252] (59-124-168-89.hinet-ip.hinet.net.
 [59.124.168.89]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7068998497esm4583814b3a.15.2024.06.25.23.00.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 23:00:26 -0700 (PDT)
Message-ID: <96b7ad39-a4ae-427a-b886-d533a1441ca5@sifive.com>
Date: Wed, 26 Jun 2024 14:00:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] target/riscv: Add Control Transfer Records CSR
 definitions.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org
References: <20240619152708.135991-1-rkanwal@rivosinc.com>
 <20240619152708.135991-3-rkanwal@rivosinc.com>
Content-Language: en-US
From: Jason Chien <jason.chien@sifive.com>
In-Reply-To: <20240619152708.135991-3-rkanwal@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=jason.chien@sifive.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Hi Rajnesh,

On 2024/6/19 下午 11:27, Rajnesh Kanwal wrote:
> The Control Transfer Records (CTR) extension provides a method to
> record a limited branch history in register-accessible internal chip
> storage.
>
> This extension is similar to Arch LBR in x86 and BRBE in ARM.
> The Extension has been stable and the latest release can be found here
> https://github.com/riscv/riscv-control-transfer-records/release
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>   target/riscv/cpu_bits.h | 154 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 154 insertions(+)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 86e15381c8..71ddccaf1a 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -242,6 +242,17 @@
>   #define CSR_SIEH            0x114
>   #define CSR_SIPH            0x154
>   
> +/* Machine-Level Control transfer records CSRs */
> +#define CSR_MCTRCTL         0x34e
> +
> +/* Supervisor-Level Control transfer records CSRs */
> +#define CSR_SCTRCTL         0x14e
> +#define CSR_SCTRSTATUS      0x14f
> +#define CSR_SCTRDEPTH       0x15f
> +
> +/* VS-Level Control transfer records CSRs */
> +#define CSR_VSCTRCTL        0x24e
> +
>   /* Hpervisor CSRs */
>   #define CSR_HSTATUS         0x600
>   #define CSR_HEDELEG         0x602
> @@ -339,6 +350,7 @@
>   #define SMSTATEEN0_CS       (1ULL << 0)
>   #define SMSTATEEN0_FCSR     (1ULL << 1)
>   #define SMSTATEEN0_JVT      (1ULL << 2)
> +#define SMSTATEEN0_CTR      (1ULL << 54)
>   #define SMSTATEEN0_HSCONTXT (1ULL << 57)
>   #define SMSTATEEN0_IMSIC    (1ULL << 58)
>   #define SMSTATEEN0_AIA      (1ULL << 59)
> @@ -854,6 +866,148 @@ typedef enum RISCVException {
>   #define UMTE_U_PM_INSN      U_PM_INSN
>   #define UMTE_MASK     (UMTE_U_PM_ENABLE | MMTE_U_PM_CURRENT | UMTE_U_PM_INSN)
>   
> +/* mctrctl CSR bits. */
> +#define MCTRCTL_U_ENABLE        BIT(0)
> +#define MCTRCTL_S_ENABLE        BIT(1)
> +#define MCTRCTL_M_ENABLE        BIT(2)
> +#define MCTRCTL_RASEMU          BIT(7)
> +#define MCTRCTL_STE             BIT(8)
> +#define MCTRCTL_MTE             BIT(9)
> +#define MCTRCTL_BPFRZ           BIT(11)
> +#define MCTRCTL_LCOFIFRZ        BIT(12)
> +#define MCTRCTL_EXCINH          BIT(33)
> +#define MCTRCTL_INTRINH         BIT(34)
> +#define MCTRCTL_TRETINH         BIT(35)
> +#define MCTRCTL_NTBREN          BIT(36)
> +#define MCTRCTL_TKBRINH         BIT(37)
> +#define MCTRCTL_INDCALL_INH     BIT(40)
> +#define MCTRCTL_DIRCALL_INH     BIT(41)
> +#define MCTRCTL_INDJUMP_INH     BIT(42)
> +#define MCTRCTL_DIRJUMP_INH     BIT(43)
> +#define MCTRCTL_CORSWAP_INH     BIT(44)
> +#define MCTRCTL_RET_INH         BIT(45)
> +#define MCTRCTL_INDOJUMP_INH    BIT(46)
> +#define MCTRCTL_DIROJUMP_INH    BIT(47)
> +
> +#define MCTRCTL_INH_START       32U
> +
> +#define MCTRCTL_MASK (MCTRCTL_M_ENABLE | MCTRCTL_S_ENABLE |       \
> +                      MCTRCTL_U_ENABLE | MCTRCTL_RASEMU |         \
> +                      MCTRCTL_MTE | MCTRCTL_STE |                 \
> +                      MCTRCTL_BPFRZ | MCTRCTL_LCOFIFRZ |          \
> +                      MCTRCTL_EXCINH | MCTRCTL_INTRINH |          \
> +                      MCTRCTL_TRETINH | MCTRCTL_NTBREN |          \
> +                      MCTRCTL_TKBRINH | MCTRCTL_INDCALL_INH |     \
> +                      MCTRCTL_DIRCALL_INH | MCTRCTL_INDJUMP_INH | \
> +                      MCTRCTL_DIRJUMP_INH | MCTRCTL_CORSWAP_INH | \
> +                      MCTRCTL_RET_INH | MCTRCTL_INDOJUMP_INH |    \
> +                      MCTRCTL_DIROJUMP_INH)
> +
> +/* sctrctl CSR bits. */
> +#define SCTRCTL_U_ENABLE          MCTRCTL_U_ENABLE
> +#define SCTRCTL_S_ENABLE          MCTRCTL_S_ENABLE
> +#define SCTRCTL_RASEMU            MCTRCTL_RASEMU
> +#define SCTRCTL_STE               MCTRCTL_STE
> +#define SCTRCTL_BPFRZ             MCTRCTL_BPFRZ
> +#define SCTRCTL_LCOFIFRZ          MCTRCTL_LCOFIFRZ
> +#define SCTRCTL_EXCINH            MCTRCTL_EXCINH
> +#define SCTRCTL_INTRINH           MCTRCTL_INTRINH
> +#define SCTRCTL_TRETINH           MCTRCTL_TRETINH
> +#define SCTRCTL_NTBREN            MCTRCTL_NTBREN
> +#define SCTRCTL_TKBRINH           MCTRCTL_TKBRINH
> +#define SCTRCTL_INDCALL_INH       MCTRCTL_INDCALL_INH
> +#define SCTRCTL_DIRCALL_INH       MCTRCTL_DIRCALL_INH
> +#define SCTRCTL_INDJUMP_INH       MCTRCTL_INDJUMP_INH
> +#define SCTRCTL_DIRJUMP_INH       MCTRCTL_DIRJUMP_INH
> +#define SCTRCTL_CORSWAP_INH       MCTRCTL_CORSWAP_INH
> +#define SCTRCTL_RET_INH           MCTRCTL_RET_INH
> +#define SCTRCTL_INDOJUMP_INH      MCTRCTL_INDOJUMP_INH
> +#define SCTRCTL_DIROJUMP_INH      MCTRCTL_DIROJUMP_INH
> +
> +#define SCTRCTL_MASK (SCTRCTL_S_ENABLE | SCTRCTL_U_ENABLE |       \
> +                      SCTRCTL_RASEMU | SCTRCTL_STE |              \
> +                      SCTRCTL_BPFRZ | SCTRCTL_LCOFIFRZ |          \
> +                      SCTRCTL_EXCINH | SCTRCTL_INTRINH |          \
> +                      SCTRCTL_TRETINH | SCTRCTL_NTBREN |          \
> +                      SCTRCTL_TKBRINH | SCTRCTL_INDCALL_INH |     \
> +                      SCTRCTL_DIRCALL_INH | SCTRCTL_INDJUMP_INH | \
> +                      SCTRCTL_DIRJUMP_INH | SCTRCTL_CORSWAP_INH | \
> +                      SCTRCTL_RET_INH | SCTRCTL_INDOJUMP_INH |    \
> +                      SCTRCTL_DIROJUMP_INH)
> +
> +/* sctrstatus CSR bits. */
> +#define SCTRSTATUS_WRPTR_MASK       0xFF
> +#define SCTRSTATUS_FROZEN           BIT(31)
> +#define SCTRSTATUS_MASK             (SCTRSTATUS_WRPTR_MASK | SCTRSTATUS_FROZEN)
> +
> +/* sctrdepth CSR bits. */
> +#define SCTRDEPTH_MASK              0x7
> +#define SCTRDEPTH_MIN               0U  /* 16 Entries. */
> +#define SCTRDEPTH_MAX               4U  /* 256 Entries. */
> +
> +/* vsctrctl CSR bits. */
> +#define VSCTRCTL_VU_ENABLE         MCTRCTL_U_ENABLE
> +#define VSCTRCTL_VS_ENABLE         MCTRCTL_S_ENABLE
> +#define VSCTRCTL_RASEMU            MCTRCTL_RASEMU
> +#define VSCTRCTL_VSTE              MCTRCTL_STE
> +#define VSCTRCTL_BPFRZ             MCTRCTL_BPFRZ
> +#define VSCTRCTL_LCOFIFRZ          MCTRCTL_LCOFIFRZ
> +#define VSCTRCTL_EXCINH            MCTRCTL_EXCINH
> +#define VSCTRCTL_INTRINH           MCTRCTL_INTRINH
> +#define VSCTRCTL_TRETINH           MCTRCTL_TRETINH
> +#define VSCTRCTL_NTBREN            MCTRCTL_NTBREN
> +#define VSCTRCTL_TKBRINH           MCTRCTL_TKBRINH
> +#define VSCTRCTL_INDCALL_INH       MCTRCTL_INDCALL_INH
> +#define VSCTRCTL_DIRCALL_INH       MCTRCTL_DIRCALL_INH
> +#define VSCTRCTL_INDJUMP_INH       MCTRCTL_INDJUMP_INH
> +#define VSCTRCTL_DIRJUMP_INH       MCTRCTL_DIRJUMP_INH
> +#define VSCTRCTL_CORSWAP_INH       MCTRCTL_CORSWAP_INH
> +#define VSCTRCTL_RET_INH           MCTRCTL_RET_INH
> +#define VSCTRCTL_INDOJUMP_INH      MCTRCTL_INDOJUMP_INH
> +#define VSCTRCTL_DIROJUMP_INH      MCTRCTL_DIROJUMP_INH
> +
> +#define VSCTRCTL_MASK (VSCTRCTL_VS_ENABLE | VSCTRCTL_VU_ENABLE |     \
> +                       VSCTRCTL_RASEMU | VSCTRCTL_VSTE |             \
> +                       VSCTRCTL_BPFRZ | VSCTRCTL_LCOFIFRZ |          \
> +                       VSCTRCTL_EXCINH | VSCTRCTL_INTRINH |          \
> +                       VSCTRCTL_TRETINH | VSCTRCTL_NTBREN |          \
> +                       VSCTRCTL_TKBRINH | VSCTRCTL_INDCALL_INH |     \
> +                       VSCTRCTL_DIRCALL_INH | VSCTRCTL_INDJUMP_INH | \
> +                       VSCTRCTL_DIRJUMP_INH | VSCTRCTL_CORSWAP_INH | \
> +                       VSCTRCTL_RET_INH | VSCTRCTL_INDOJUMP_INH |    \
> +                       VSCTRCTL_DIROJUMP_INH)

Do you think it's a good idea to define these macros like below?

+/* CTR control register commom fields */
+#define XCTRCTL_U                        BIT_ULL(0)
+#define XCTRCTL_S                        BIT_ULL(1)
+#define XCTRCTL_RASEMU           BIT_ULL(7)
+#define XCTRCTL_STE                    BIT_ULL(8)
+#define XCTRCTL_BPFRZ               BIT_ULL(11)
+#define XCTRCTL_LCOFIFRZ         BIT_ULL(12)
+#define XCTRCTL_EXCINH             BIT_ULL(33)
+#define XCTRCTL_INTRINH            BIT_ULL(34)
+#define XCTRCTL_TRETINH           BIT_ULL(35)
+#define XCTRCTL_NTBREN            BIT_ULL(36)
+#define XCTRCTL_TKBRINH           BIT_ULL(37)
+#define XCTRCTL_INDCALLINH     BIT_ULL(40)
+#define XCTRCTL_DIRCALLINH     BIT_ULL(41)
+#define XCTRCTL_INDJMPINH       BIT_ULL(42)
+#define XCTRCTL_DIRJMPINH       BIT_ULL(43)
+#define XCTRCTL_CORSWAPINH  BIT_ULL(44)
+#define XCTRCTL_RETINH             BIT_ULL(45)
+#define XCTRCTL_INDLJMPINH     BIT_ULL(46)
+#define XCTRCTL_DIRLJMPINH     BIT_ULL(47)
+
+#define XCTRCTL_MASK (XCTRCTL_U | XCTRCTL_S | XCTRCTL_RASEMU | 
XCTRCTL_STE | \
+                                            XCTRCTL_BPFRZ | 
XCTRCTL_LCOFIFRZ | XCTRCTL_EXCINH | \
+                                            XCTRCTL_INTRINH | 
XCTRCTL_TRETINH | XCTRCTL_NTBREN | \
+                                            XCTRCTL_TKBRINH | 
XCTRCTL_INDCALLINH | \
+                                            XCTRCTL_DIRCALLINH | 
XCTRCTL_INDJMPINH | \
+                                            XCTRCTL_DIRJMPINH | 
XCTRCTL_CORSWAPINH | \
+                                            XCTRCTL_RETINH | 
XCTRCTL_INDLJMPINH | XCTRCTL_DIRLJMPINH)
+
+/* CTR mctrctl bits */
+#define MCTRCTL_M                      BIT_ULL(2)
+#define MCTRCTL_MTE                 BIT_ULL(9)
+
+#define MCTRCTL_MASK              (XCTRCTL_MASK | MCTRCTL_M | MCTRCTL_MTE)
+#define SCTRCTL_MASK                XCTRCTL_MASK
+#define VSCTRCTL_MASK              XCTRCTL_MASK

> +
> +#define CTR_ENTRIES_FIRST                  0x200
> +#define CTR_ENTRIES_LAST                   0x2ff
> +
> +#define CTRSOURCE_VALID                    BIT(0)
> +#define CTRTARGET_MISP                     BIT(0)
> +
> +#define CTRDATA_TYPE_MASK                   0xF
> +#define CTRDATA_CCV                         BIT(15)
> +#define CTRDATA_CCM_MASK                    0xFFF0000
> +#define CTRDATA_CCE_MASK                    0xF0000000
> +
> +#define CTRDATA_MASK            (CTRDATA_TYPE_MASK | CTRDATA_CCV |  \
> +                                 CTRDATA_CCM_MASK | CTRDATA_CCE_MASK)
> +
> +#define CTRDATA_TYPE_NONE                   0
> +#define CTRDATA_TYPE_EXCEPTION              1
> +#define CTRDATA_TYPE_INTERRUPT              2
> +#define CTRDATA_TYPE_EXCEP_INT_RET          3
> +#define CTRDATA_TYPE_NONTAKEN_BRANCH        4
> +#define CTRDATA_TYPE_TAKEN_BRANCH           5
> +#define CTRDATA_TYPE_RESERVED_0             6
> +#define CTRDATA_TYPE_RESERVED_1             7
> +#define CTRDATA_TYPE_INDIRECT_CALL          8
> +#define CTRDATA_TYPE_DIRECT_CALL            9
> +#define CTRDATA_TYPE_INDIRECT_JUMP          10
> +#define CTRDATA_TYPE_DIRECT_JUMP            11
> +#define CTRDATA_TYPE_CO_ROUTINE_SWAP        12
> +#define CTRDATA_TYPE_RETURN                 13
> +#define CTRDATA_TYPE_OTHER_INDIRECT_JUMP    14
> +#define CTRDATA_TYPE_OTHER_DIRECT_JUMP      15
I prefer using typedef enum {} for the instruction types, since there is 
type checking for function parameters.
> +
>   /* MISELECT, SISELECT, and VSISELECT bits (AIA) */
>   #define ISELECT_IPRIO0                     0x30
>   #define ISELECT_IPRIO15                    0x3f

