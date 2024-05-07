Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500E6C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 08:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Flp-0005Av-BG; Tue, 07 May 2024 04:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s4Flo-0005AG-5f
 for qemu-devel@nongnu.org; Tue, 07 May 2024 04:01:52 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s4Flk-00018k-6F
 for qemu-devel@nongnu.org; Tue, 07 May 2024 04:01:51 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-51f1bf83f06so3439191e87.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 01:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715068905; x=1715673705; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JoHUFtgB5S9APLp2RzVw2JEkbwtOfY/99RuKvWPvenc=;
 b=NbbdTFICTqKnOilJcWxT01W0w0/INC4CZCtywJ9+wq0X8eq45Z70tFmh2QBQTCvuQy
 DhVwTQh8TDqhKl4By8qTHbYhdqmbT35ZjydeYMqorFCAiBLwcLafeqBkuXZ52L8rfMgb
 2aoVUXW55BIcV94yz6hX40hgsvuZw4Uh5fRyFTbhpRJC6VVwMouEzTjiVX7ktVkpk7WH
 jhUSUIdQiuu0GyuIze1OwwwKLt1lt4isaU5qeNAspKOrqzgJDoaepnrOOzeSjwXQlfKa
 IvWsV9avAbMwPhQTzqkJp/ynj2BKQ7JRL7BoAJY+ForWLqTi10302h+wWvw17iKBrevE
 rRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715068906; x=1715673706;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JoHUFtgB5S9APLp2RzVw2JEkbwtOfY/99RuKvWPvenc=;
 b=eaL5fhL7i7Wb9Kj/ahRAnVABpNmzigZ73lwuW4i9kzvci70ZORgTHsDo9oP0yJGFG6
 f1QHyYEBHhf7JvkxwJ5yBlXC4ZMW6xYRaVjbdNTa1AwlD5bATcrJfUsPMl0bdutpn1QK
 MGcGBKNMaCLCqix1BUCTVyv44SY+3y7872v0nmLvC3G4nYGmQkbC6HqvJxOz/v+WSEvI
 Yl70I8ACsGlgV3xA41m2M3VqMOYnWJfIyNOKwbUlFW45soeA4DdESdGQqBXLGe4xZoS9
 naMKQc20N455WFTf0eI8N/DSlJ0gKAQcQ2Lz1EFmjMn4OfG+NT9vXGolqoevpcqnrIVC
 lgNw==
X-Gm-Message-State: AOJu0YyJs6AYwva6NJtIzpmyHmFZPK2tiXlQ9PnP7bIYKAMV39ytaEMx
 VlIeZOY8znxijRpccHZwPR172Rr7SYSl+XCZi1Z/W6sr5tE6Gq+hlccsnEZRjLgXV3zEUrayaee
 NpNvyXTONJzx6BxZhvNc+7shza+Kdm+0YJCUfSmhGH06dvn7eMVl5v+8Kl8GZkH2ABEpdNvFJ58
 uyVGUSOD+B26xkEjArvLTnxN2vHOa/CGI7PQi7MCDuGA==
X-Google-Smtp-Source: AGHT+IGYNHhtJoS/CJyin4cKp6/hf0FKN+wPyscmh1kuPIb2YDBYBjNG4RxfkblVN5Gl9fqmBYAX9g==
X-Received: by 2002:a05:6512:3441:b0:51c:441d:9bc2 with SMTP id
 j1-20020a056512344100b0051c441d9bc2mr6847002lfr.27.1715068905322; 
 Tue, 07 May 2024 01:01:45 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com.
 [209.85.208.178]) by smtp.gmail.com with ESMTPSA id
 be36-20020a056512252400b005204f6ab0edsm1012850lfb.286.2024.05.07.01.01.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 01:01:44 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-2e3e18c24c1so7081301fa.1; 
 Tue, 07 May 2024 01:01:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWH0+MT11u1Vfa2EPDBYKDzNi/yNLkqwQJVCJnrxprTm4uH5Z1haj5Mip9LM3kOsiqb2XrE5yK1BWHbQM8wtNcJcwMoYLw=
X-Received: by 2002:a05:651c:201c:b0:2dd:c9fc:c472 with SMTP id
 s28-20020a05651c201c00b002ddc9fcc472mr7232315ljo.26.1715068904373; Tue, 07
 May 2024 01:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-14-dbarboza@ventanamicro.com>
In-Reply-To: <20240307160319.675044-14-dbarboza@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 7 May 2024 16:01:30 +0800
X-Gmail-Original-Message-ID: <CANzO1D15=7kif7Dutut=cvsv4DZbu8C99b020AmrUAYv49E_Gg@mail.gmail.com>
Message-ID: <CANzO1D15=7kif7Dutut=cvsv4DZbu8C99b020AmrUAYv49E_Gg@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] qtest/riscv-iommu-test: add init queues test
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Frank Chang <frank.chang@sifive.com>

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=B9=B4=
3=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:06=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Add an additional test to further exercise the IOMMU where we attempt to
> initialize the command, fault and page-request queues.
>
> These steps are taken from chapter 6.2 of the RISC-V IOMMU spec,
> "Guidelines for initialization". It emulates what we expect from the
> software/OS when initializing the IOMMU.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  tests/qtest/libqos/riscv-iommu.h |  29 +++++++
>  tests/qtest/riscv-iommu-test.c   | 141 +++++++++++++++++++++++++++++++
>  2 files changed, 170 insertions(+)
>
> diff --git a/tests/qtest/libqos/riscv-iommu.h b/tests/qtest/libqos/riscv-=
iommu.h
> index 8c056caa7b..aeaa5fb8b8 100644
> --- a/tests/qtest/libqos/riscv-iommu.h
> +++ b/tests/qtest/libqos/riscv-iommu.h
> @@ -58,6 +58,35 @@
>
>  #define RISCV_IOMMU_REG_IPSR            0x0054
>
> +#define RISCV_IOMMU_REG_IVEC            0x02F8
> +#define RISCV_IOMMU_REG_IVEC_CIV        GENMASK_ULL(3, 0)
> +#define RISCV_IOMMU_REG_IVEC_FIV        GENMASK_ULL(7, 4)
> +#define RISCV_IOMMU_REG_IVEC_PIV        GENMASK_ULL(15, 12)
> +
> +#define RISCV_IOMMU_REG_CQB             0x0018
> +#define RISCV_IOMMU_CQB_PPN_START       10
> +#define RISCV_IOMMU_CQB_PPN_LEN         44
> +#define RISCV_IOMMU_CQB_LOG2SZ_START    0
> +#define RISCV_IOMMU_CQB_LOG2SZ_LEN      5
> +
> +#define RISCV_IOMMU_REG_CQT             0x0024
> +
> +#define RISCV_IOMMU_REG_FQB             0x0028
> +#define RISCV_IOMMU_FQB_PPN_START       10
> +#define RISCV_IOMMU_FQB_PPN_LEN         44
> +#define RISCV_IOMMU_FQB_LOG2SZ_START    0
> +#define RISCV_IOMMU_FQB_LOG2SZ_LEN      5
> +
> +#define RISCV_IOMMU_REG_FQT             0x0034
> +
> +#define RISCV_IOMMU_REG_PQB             0x0038
> +#define RISCV_IOMMU_PQB_PPN_START       10
> +#define RISCV_IOMMU_PQB_PPN_LEN         44
> +#define RISCV_IOMMU_PQB_LOG2SZ_START    0
> +#define RISCV_IOMMU_PQB_LOG2SZ_LEN      5
> +
> +#define RISCV_IOMMU_REG_PQT             0x0044
> +
>  typedef struct QRISCVIOMMU {
>      QOSGraphObject obj;
>      QPCIDevice dev;
> diff --git a/tests/qtest/riscv-iommu-test.c b/tests/qtest/riscv-iommu-tes=
t.c
> index 13b887d15e..64f3f092f2 100644
> --- a/tests/qtest/riscv-iommu-test.c
> +++ b/tests/qtest/riscv-iommu-test.c
> @@ -33,6 +33,20 @@ static uint64_t riscv_iommu_read_reg64(QRISCVIOMMU *r_=
iommu, int reg_offset)
>      return reg;
>  }
>
> +static void riscv_iommu_write_reg32(QRISCVIOMMU *r_iommu, int reg_offset=
,
> +                                    uint32_t val)
> +{
> +    qpci_memwrite(&r_iommu->dev, r_iommu->reg_bar, reg_offset,
> +                  &val, sizeof(val));
> +}
> +
> +static void riscv_iommu_write_reg64(QRISCVIOMMU *r_iommu, int reg_offset=
,
> +                                    uint64_t val)
> +{
> +    qpci_memwrite(&r_iommu->dev, r_iommu->reg_bar, reg_offset,
> +                  &val, sizeof(val));
> +}
> +
>  static void test_pci_config(void *obj, void *data, QGuestAllocator *t_al=
loc)
>  {
>      QRISCVIOMMU *r_iommu =3D obj;
> @@ -84,10 +98,137 @@ static void test_reg_reset(void *obj, void *data, QG=
uestAllocator *t_alloc)
>      g_assert_cmpuint(reg, =3D=3D, 0);
>  }
>
> +/*
> + * Common timeout-based poll for CQCSR, FQCSR and PQCSR. All
> + * their ON bits are mapped as RISCV_IOMMU_QUEUE_ACTIVE (16),
> + */
> +static void qtest_wait_for_queue_active(QRISCVIOMMU *r_iommu,
> +                                        uint32_t queue_csr)
> +{
> +    QTestState *qts =3D global_qtest;
> +    guint64 timeout_us =3D 2 * 1000 * 1000;
> +    gint64 start_time =3D g_get_monotonic_time();
> +    uint32_t reg;
> +
> +    for (;;) {
> +        qtest_clock_step(qts, 100);
> +
> +        reg =3D riscv_iommu_read_reg32(r_iommu, queue_csr);
> +        if (reg & RISCV_IOMMU_QUEUE_ACTIVE) {
> +            break;
> +        }
> +        g_assert(g_get_monotonic_time() - start_time <=3D timeout_us);
> +    }
> +}
> +
> +/*
> + * Goes through the queue activation procedures of chapter 6.2,
> + * "Guidelines for initialization", of the RISCV-IOMMU spec.
> + */
> +static void test_iommu_init_queues(void *obj, void *data,
> +                                   QGuestAllocator *t_alloc)
> +{
> +    QRISCVIOMMU *r_iommu =3D obj;
> +    uint64_t reg64, q_addr;
> +    uint32_t reg;
> +    int k;
> +
> +    reg64 =3D riscv_iommu_read_reg64(r_iommu, RISCV_IOMMU_REG_CAP);
> +    g_assert_cmpuint(reg64 & RISCV_IOMMU_CAP_VERSION, =3D=3D, 0x10);
> +
> +    /*
> +     * Program the command queue. Write 0xF to civ, assert that
> +     * we have 4 writable bits (k =3D 4). The amount of entries N in the
> +     * command queue is 2^4 =3D 16. We need to alloc a N*16 bytes
> +     * buffer and use it to set cqb.
> +     */
> +    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_IVEC,
> +                            0xFFFF & RISCV_IOMMU_REG_IVEC_CIV);
> +    reg =3D riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_IVEC);
> +    g_assert_cmpuint(reg & RISCV_IOMMU_REG_IVEC_CIV, =3D=3D, 0xF);
> +
> +    q_addr =3D guest_alloc(t_alloc, 16 * 16);
> +    reg64 =3D 0;
> +    k =3D 4;
> +    deposit64(reg64, RISCV_IOMMU_CQB_PPN_START,
> +              RISCV_IOMMU_CQB_PPN_LEN, q_addr);
> +    deposit64(reg64, RISCV_IOMMU_CQB_LOG2SZ_START,
> +              RISCV_IOMMU_CQB_LOG2SZ_LEN, k - 1);
> +    riscv_iommu_write_reg64(r_iommu, RISCV_IOMMU_REG_CQB, reg64);
> +
> +    /* cqt =3D 0, cqcsr.cqen =3D 1, poll cqcsr.cqon until it reads 1 */
> +    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_CQT, 0);
> +
> +    reg =3D riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_CQCSR);
> +    reg |=3D RISCV_IOMMU_CQCSR_CQEN;
> +    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_CQCSR, reg);
> +
> +    qtest_wait_for_queue_active(r_iommu, RISCV_IOMMU_REG_CQCSR);
> +
> +    /*
> +     * Program the fault queue. Similar to the above:
> +     * - Write 0xF to fiv, assert that we have 4 writable bits (k =3D 4)
> +     * - Alloc a 16*32 bytes (instead of 16*16) buffer and use it to set
> +     * fqb
> +     */
> +    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_IVEC,
> +                            0xFFFF & RISCV_IOMMU_REG_IVEC_FIV);
> +    reg =3D riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_IVEC);
> +    g_assert_cmpuint(reg & RISCV_IOMMU_REG_IVEC_FIV, =3D=3D, 0xF0);
> +
> +    q_addr =3D guest_alloc(t_alloc, 16 * 32);
> +    reg64 =3D 0;
> +    k =3D 4;
> +    deposit64(reg64, RISCV_IOMMU_FQB_PPN_START,
> +              RISCV_IOMMU_FQB_PPN_LEN, q_addr);
> +    deposit64(reg64, RISCV_IOMMU_FQB_LOG2SZ_START,
> +              RISCV_IOMMU_FQB_LOG2SZ_LEN, k - 1);
> +    riscv_iommu_write_reg64(r_iommu, RISCV_IOMMU_REG_FQB, reg64);
> +
> +    /* fqt =3D 0, fqcsr.fqen =3D 1, poll fqcsr.fqon until it reads 1 */
> +    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_FQT, 0);
> +
> +    reg =3D riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_FQCSR);
> +    reg |=3D RISCV_IOMMU_FQCSR_FQEN;
> +    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_FQCSR, reg);
> +
> +    qtest_wait_for_queue_active(r_iommu, RISCV_IOMMU_REG_FQCSR);
> +
> +    /*
> +     * Program the page-request queue:
> +     - Write 0xF to piv, assert that we have 4 writable bits (k =3D 4)
> +     - Alloc a 16*16 bytes buffer and use it to set pqb.
> +     */
> +    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_IVEC,
> +                            0xFFFF & RISCV_IOMMU_REG_IVEC_PIV);
> +    reg =3D riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_IVEC);
> +    g_assert_cmpuint(reg & RISCV_IOMMU_REG_IVEC_PIV, =3D=3D, 0xF000);
> +
> +    q_addr =3D guest_alloc(t_alloc, 16 * 16);
> +    reg64 =3D 0;
> +    k =3D 4;
> +    deposit64(reg64, RISCV_IOMMU_PQB_PPN_START,
> +              RISCV_IOMMU_PQB_PPN_LEN, q_addr);
> +    deposit64(reg64, RISCV_IOMMU_PQB_LOG2SZ_START,
> +              RISCV_IOMMU_PQB_LOG2SZ_LEN, k - 1);
> +    riscv_iommu_write_reg64(r_iommu, RISCV_IOMMU_REG_PQB, reg64);
> +
> +    /* pqt =3D 0, pqcsr.pqen =3D 1, poll pqcsr.pqon until it reads 1 */
> +    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_PQT, 0);
> +
> +    reg =3D riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_PQCSR);
> +    reg |=3D RISCV_IOMMU_PQCSR_PQEN;
> +    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_PQCSR, reg);
> +
> +    qtest_wait_for_queue_active(r_iommu, RISCV_IOMMU_REG_PQCSR);
> +}
> +
>  static void register_riscv_iommu_test(void)
>  {
>      qos_add_test("pci_config", "riscv-iommu-pci", test_pci_config, NULL)=
;
>      qos_add_test("reg_reset", "riscv-iommu-pci", test_reg_reset, NULL);
> +    qos_add_test("iommu_init_queues", "riscv-iommu-pci",
> +                 test_iommu_init_queues, NULL);
>  }
>
>  libqos_init(register_riscv_iommu_test);
> --
> 2.43.2
>
>

