Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA4EC3064D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 02:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMGNB-0007GR-LR; Tue, 25 Jun 2024 20:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMGN3-0007Fh-Bq
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:18:46 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMGMb-0002ei-I0
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:18:39 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-700ca6171f1so533271a34.2; 
 Tue, 25 Jun 2024 17:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719360974; x=1719965774; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=icE7KUda0aflLaUQ7QVxek6fWXIxy/umMmoPVJLruvs=;
 b=KQEHpilonhUeGwrCJvx0V1vlw7SR8JsVRl5bn44E8jyl9VVO9yUC1h0Qai4Mvf+/QV
 EiY41x0Et/rtc3SodLXm3Ll7Yi9j4IkQWxasceKRAS6rh91+ihvQufNPajQVxcG9hkF3
 DXyBrwVK6Ut9xhY6WFTf+VPj9gZPRQFdRBUUiMFS/+ccUqcpFMLu6KAEAXfOxmCR0EZx
 V+LDFebW5dhHuJFnlV5MLBowkQKrkE86Au+v3ub1bIAl3cPBgdKrhpPaTxz9NbUJfefW
 h8pCchdaV8Iwxj4aOf9jzPSb1gBikoeXNgCnRasPzf7Ee6fY4N8GpIaiybgtLuNBFmXi
 N4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719360974; x=1719965774;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=icE7KUda0aflLaUQ7QVxek6fWXIxy/umMmoPVJLruvs=;
 b=eHPfR1vdlOYqiTj2gaK2KAYXa1dyAZZrA4yp6SkT5E24IBjz+M365chvDZelpnfYya
 Aip5r9mreyDvHfi2O7Ur2+p+090Ce1W7EUi/pzg7DY9LVEnNFEpPc7ZlM7KBnUtbKKGQ
 eNXdQJpLBisxcOrHeQTFtoV1/3O0sZFwHHZY38YEHA9fUXY0OxKxPmJiyIEAZuURe3XP
 vxcnJq9LD/yYhO8O8aulYsJFn7msCn8tRDSXVM/x3X1dwuDCZtKyAGR3khqC5X/u73kD
 3Ver1uXoyo73oLnOYgwjxGXFrBo+nNcKp/uiihYdt1OzMUbCvyOQGP0JZmf4wIk8W+Bt
 bsBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIszdwKFcMQ1O7ZkmnwCzX3nivhg0dAYRYQITscRcafXe3HyOb7NLW5PjKgQiM4s4Ioz3T544bXbchBk3zNjTXr6PaHQ8=
X-Gm-Message-State: AOJu0YwD7COxwrk434gsNsJLnZD977rew0tpbJLyJqWEzjAAzuvUz3pX
 0ie4m7gv9hnUHkBVQb6yT0GoAvHiD2DfewYUxn8wf17mwO5BcBDhq4PTX4kJIhRhpevWXywOS9D
 RW6fyute+kzildBYZyXk7zuDG9tAkYA==
X-Google-Smtp-Source: AGHT+IGm2eFN8/LzLMd8IdMa5V9GB9qmCATREmMgCEaTXXqKrUOqDbtNAtwc3PkmI3MeEbt2Vd2/oVmSnAEh9wgIkrA=
X-Received: by 2002:a67:e356:0:b0:48f:4778:929d with SMTP id
 ada2fe7eead31-48f52b9ace6mr8806117137.27.1719360479734; Tue, 25 Jun 2024
 17:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240619152708.135991-1-rkanwal@rivosinc.com>
 <20240619152708.135991-3-rkanwal@rivosinc.com>
In-Reply-To: <20240619152708.135991-3-rkanwal@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Jun 2024 10:07:33 +1000
Message-ID: <CAKmqyKMBxD2NZcvL8=pkGh2SaVkv8efzuq2+nEoW8xCUNdYNRw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] target/riscv: Add Control Transfer Records CSR
 definitions.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org, 
 jason.chien@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
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

On Thu, Jun 20, 2024 at 1:28=E2=80=AFAM Rajnesh Kanwal <rkanwal@rivosinc.co=
m> wrote:
>
> The Control Transfer Records (CTR) extension provides a method to
> record a limited branch history in register-accessible internal chip
> storage.
>
> This extension is similar to Arch LBR in x86 and BRBE in ARM.
> The Extension has been stable and the latest release can be found here
> https://github.com/riscv/riscv-control-transfer-records/release

Specific version please. Also the spec is not yet ratified, so it
isn't actually stable in the general sense.

>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>

Otherwise

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_bits.h | 154 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 154 insertions(+)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 86e15381c8..71ddccaf1a 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -242,6 +242,17 @@
>  #define CSR_SIEH            0x114
>  #define CSR_SIPH            0x154
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
>  /* Hpervisor CSRs */
>  #define CSR_HSTATUS         0x600
>  #define CSR_HEDELEG         0x602
> @@ -339,6 +350,7 @@
>  #define SMSTATEEN0_CS       (1ULL << 0)
>  #define SMSTATEEN0_FCSR     (1ULL << 1)
>  #define SMSTATEEN0_JVT      (1ULL << 2)
> +#define SMSTATEEN0_CTR      (1ULL << 54)
>  #define SMSTATEEN0_HSCONTXT (1ULL << 57)
>  #define SMSTATEEN0_IMSIC    (1ULL << 58)
>  #define SMSTATEEN0_AIA      (1ULL << 59)
> @@ -854,6 +866,148 @@ typedef enum RISCVException {
>  #define UMTE_U_PM_INSN      U_PM_INSN
>  #define UMTE_MASK     (UMTE_U_PM_ENABLE | MMTE_U_PM_CURRENT | UMTE_U_PM_=
INSN)
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
> +#define SCTRSTATUS_MASK             (SCTRSTATUS_WRPTR_MASK | SCTRSTATUS_=
FROZEN)
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
> +
>  /* MISELECT, SISELECT, and VSISELECT bits (AIA) */
>  #define ISELECT_IPRIO0                     0x30
>  #define ISELECT_IPRIO15                    0x3f
> --
> 2.34.1
>
>

