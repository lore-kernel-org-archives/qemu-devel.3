Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E9FC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 09:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUjzB-0005Z2-LX; Fri, 19 Jul 2024 05:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUjzA-0005Y5-9j; Fri, 19 Jul 2024 05:33:08 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUjz7-0002mp-CK; Fri, 19 Jul 2024 05:33:08 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4f2e1093abeso624042e0c.1; 
 Fri, 19 Jul 2024 02:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721381584; x=1721986384; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qLHOOHW9mYP7Losco8E6WF8g2ruo4w8k/IcOAptDbYM=;
 b=AEMfM6j/HlBLmdSgfBfdYp6PVlZgGGrU/LoPsKUaOuVFXp0eEX4u4KpJZuiefYcPAJ
 EJwwxhn8P+oDdADGapUGERJ7DqBek1NJ0nemvcgcQrmrlhp6lv+vjnXAvNKhEs+YLLNi
 obg7EsqmCwGuP3/4jwlg6eNsl+qjw3TsL0t33ZvbrMhdyKMwiWJKFz9QccE/7YKma6sq
 qsIx0+p7iNm2Mz+RQtKLuPqiI+vyRtTnoJyHYn8kCduSYDjQAE4IHidaaUM0VKNMOF67
 8diqPGgWRYM3U99LXiM0Tk5hLuU5s2AGuy1+vswS4eWAaXINU8zTY31mdvY7Qf/O6RLL
 Owzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721381584; x=1721986384;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qLHOOHW9mYP7Losco8E6WF8g2ruo4w8k/IcOAptDbYM=;
 b=Wap9T7XP1CyDsUDDllemZAUdYJhFn1xouDF0AxPsojJy+Abs/xkPniSW1DEXPNdVz/
 3rJ0b1fDbXviKCF+Ifbpj0OZnaK1y2eMyq3EkusrzqxkZIGz59BNYFBTAG9u4NtqFQNR
 KduR/aX0C8jGXyBgyOIam0epSWFli7NQNqQRgL/75Cwwuc6+0QW9Ek/wV7b5+y7RTxuC
 jSWp6XwZ/oy8iQcQDNF4AklpFPIj3PiUCLzgIYiRq2D79m5RQMYHjlAr4CEMLPsw3Qzo
 y8d0Pq2fAYvUfYxAjzlhw6rqWHNBINVFq4lKEHSaWurB/Q0KnzopZJUYW5nP6wOuihBj
 CH7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVEUFhKnUgrYWf3WPoAKSk2HvSIu0N8IKYCNMqeWDZnsysnT6FikEdrD+PMmNDTS2VQTSfNWQGFWCB8JHsb09bspoQ+aU=
X-Gm-Message-State: AOJu0YzxzBWF9yOtaKXP85UNdf9Cm0u46CAtCIpLtZtL7MQA4nqKRnpq
 PwjEvv+U8zEpsA0XsXQHAVOHM73Ai6P868P9IkSs8NRHHNdEMxy7Z3Nd2EbOI06J1UJOrBRrxyC
 eKXTnnQQf1mMG/6qVC2n1rN34nno=
X-Google-Smtp-Source: AGHT+IEyOuQbD+aABYxcOWXVQSUbIM0KM9+DpgGt+0q8g7LLmHATWP9RxjqAmgq5TGiHMenMc5m/CT4XR/9WeKp1yNQ=
X-Received: by 2002:a05:6122:130b:b0:4f2:f331:b34d with SMTP id
 71dfb90a1353d-4f4df6e5630mr9744170e0c.7.1721381583663; Fri, 19 Jul 2024
 02:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240708173501.426225-1-dbarboza@ventanamicro.com>
 <20240708173501.426225-13-dbarboza@ventanamicro.com>
In-Reply-To: <20240708173501.426225-13-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Jul 2024 19:32:36 +1000
Message-ID: <CAKmqyKNtAxwUwR+1i+7A44eY_K6yO15uhLs5hz9kSrM6f5rDHg@mail.gmail.com>
Subject: Re: [PATCH v5 12/13] qtest/riscv-iommu-test: add init queues test
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, frank.chang@sifive.com, tjeznach@rivosinc.com, 
 jason.chien@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Tue, Jul 9, 2024 at 3:36=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Add an additional test to further exercise the IOMMU where we attempt to
> initialize the command, fault and page-request queues.
>
> These steps are taken from chapter 6.2 of the RISC-V IOMMU spec,
> "Guidelines for initialization". It emulates what we expect from the
> software/OS when initializing the IOMMU.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/qtest/libqos/riscv-iommu.h |  29 +++++++
>  tests/qtest/riscv-iommu-test.c   | 141 +++++++++++++++++++++++++++++++
>  2 files changed, 170 insertions(+)
>
> diff --git a/tests/qtest/libqos/riscv-iommu.h b/tests/qtest/libqos/riscv-=
iommu.h
> index d123efb41f..c62ddedbac 100644
> --- a/tests/qtest/libqos/riscv-iommu.h
> +++ b/tests/qtest/libqos/riscv-iommu.h
> @@ -62,6 +62,35 @@
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
> index 7f0dbd0211..9e2afcb4b9 100644
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
> 2.45.2
>
>

