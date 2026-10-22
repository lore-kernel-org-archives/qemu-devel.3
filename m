Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86232606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 00:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nkvoPDcH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJh7j-0007XE-4v; Wed, 21 Oct 2026 20:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xJh7g-0007Wv-NZ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 20:57:36 -0400
Received: from mail-lr2-x00.google.com ([2a00:1450:4864:38::])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xJh7d-0004nC-3J
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 20:57:36 -0400
Received: by mail-lr2-x00.google.com with SMTP id
 38308e7fff4ca-3ab1cf59ff4so8107151fa.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 17:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792630651; cv=none;
 d=google.com; s=arc-20260327;
 b=eRo28ilcTS/rK23IIvpykY+mN59RRYF6Jpot75Yi80DpMiHK40NNgfDiiiOO/tyOQC
 KRpYVjvT0QDXGbSUJtv4tb7PBWekXXFsRKR3sIOhn8I5wVjKIX5DzfFcxgHupFOaquf0
 knLoL51CCQH6/KekRaaUySrpR8AGwXMC8jbr4/TVG5gulxEPo8Il9s+K05crmdDb9WC4
 aq+PV33/SfVsWYh9CkJ4sc6hED1GYir4fupJfpdjqkd5r7UjdrWxlja83+uXiAVkeg15
 5P3jtXfu330K7G+g0VIf7r1vLcQMl/KGX/+UhonGiuGMmvHHPlw1Qrd/SLRbcswB0hg2
 2qUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4KR69lccP3UeOPB6Gwt9LlvpYc9o0HnK+C5Rwlxwf8k=;
 fh=3Nzsb1BpsJEOMtEyzyUUYbIOlBJspT857nO7AVfU1hM=;
 b=o9zoszmOwBY9Ty5NwxCZH8UamTyJt6XpNMAi3QDrG6ygA2DDFoZerEOvDRj5gZup/9
 Ue/+TFarg0CfUkdAxasjeDan4BdTHLHF6pKIL5NrJKYEM69RV5UnougnBI7xsnz/4V0f
 BDNduxYWsvk+YySORzvbap+lS980egScV1TP9SWx2eFMdGq6L8tJ4OIGjh+k9wqwJQ3u
 0OxgGzzLE8VgFR0iU9VZ6+KsGYoyvIPvavlm1YSFB4wAgf6SbPRB9v1bqESQSb7zNZso
 TLBQAnrmSlI/WZh6ETERbwaz3FxJ6AHGto+mMWr7fzBF5eqm+NvB6wCCviTZNwr0dR0I
 PH0g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792630651; x=1793235451; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4KR69lccP3UeOPB6Gwt9LlvpYc9o0HnK+C5Rwlxwf8k=;
 b=nkvoPDcHs4UyEGH/Q6yHmWgVvEOT430dXZ5x+6NtcjyRAQEY2gIwCgqZCs5bO7RMSt
 dSLwhjOJ8JqUMqag1T1X5p0IcV16gBug8MtZ7tS6bTN0K3SzovNr2+gistprzo15E/HV
 4QMDN9jFpkKxP6wrzIl9x4/fmblzpJPzeikj3gFKFa8mC2WvZ6mmEvCQWc3aXc0WS3Eu
 8wkRtSTl0/R2rGL6rnC3UXhnLznr7omGj5bs9FKdcHXukPu/jatEE18CKLR7kiLNA6fj
 TpxxzoKT4rFYtth2PDBlVwuU4HUiSwTWyIooO7VElbR8NU1XpKFiK+4DuIVXdGJtoI4S
 6OUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792630651; x=1793235451;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4KR69lccP3UeOPB6Gwt9LlvpYc9o0HnK+C5Rwlxwf8k=;
 b=Udf8JIPm/4fNJCe+CiUHi7hIjdesFQYxj/UlBbCVj8XFh8Re4W2s5SwuyDtN37pi71
 65vZZgaK14viCaWX3487oMzbQIjO8XCrYW+yyMMVwwz+h6h5K1TxUtAJgpauevdLvpv5
 htVkcSVYY0QWi4LPuiIfGlM8ONblvSJlQrSxjpdGg8qWZ+GiGnTatgs2NW3RCnDZaULF
 UE4Uk/R8ONeyv9P6/LMzbUsDjSYuWSn8qkMq0+uIkTe+tmwdIasSC/f4x6+r/OOmJxBh
 FETCRw1erkQMQ9YMosUC2bgCBgcHha7HLZxa3lUkYCE0eBbvIfIAoNDtcE4C6cNXAYJt
 v10Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwP+UEOki79FLzUHwJ4P++fzrByOnSOqk9r/Vjj4lJFn514WCg7LwOtzwjQfffdAkz25xXvkNW92xcD@nongnu.org
X-Gm-Message-State: AFq9FYIteL/EHfnc5LMTddJDQO1ad3WFFUUvIQOrjjtwaXkA9H43S1v2
 tDDFBegtGeDlQ8mRcEiolTvFgz7iaK/2wI4G6x4W4jxhGsIrcdgsyZUrnxD6VVOVfAboLjbdYac
 rb+pBPcOzX5d+zyh0IOoBbRIYWpZvBoc=
X-Gm-Gg: AYBFou3X75OExQ1YnPe3uTAauulMmEEfBDsGcN7VYedl1xIR/idvgT3FfTg6GUnSHyN
 51DVXOyQyTXOtl/Vl08nBlfsQqkqQe+aT47iTNY6Dax/SvFB0AivHMWthokohWsIFnIBAPYFNBD
 WXcaCjZPRMv3Il6eo5OboX6D2AcxpCIhk+pntJgaEu9BhL2/MSUOGyp6BqjdeRjxGwQW0PbCn98
 n68E+ydpfNaI0LM2FhDEi6SrsSLoK3pHi2TWjsYNePGXYISs2cEw9517ojQz0RxP+ukWpj9BVng
 jKFyb+KYIWKNgcPG+E4PCiupLoILlJafGWI+Tvu0iRenbHYtVKBIv3WOcO8FVMLYA7FV+Kikdzv
 2uehZnpujSRVceytfCRaTpIZc3UiO9RR34RlcaZYUxR5uPipdim7fdd45hOw=
X-Received: by 2002:a2e:be05:0:b0:3aa:fc64:a92c with SMTP id
 38308e7fff4ca-3ac4409fb42mr10443401fa.1.1792630650118; Wed, 21 Oct 2026
 17:57:30 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016090832.38530-1-fritchleybohrer@gmail.com>
 <1b6f2ec9-2918-46c7-bbfd-6c7b0269f71c@oss.qualcomm.com>
In-Reply-To: <1b6f2ec9-2918-46c7-bbfd-6c7b0269f71c@oss.qualcomm.com>
From: Zephyr Li <fritchleybohrer@gmail.com>
Date: Thu, 22 Oct 2026 08:57:18 +0800
X-Gm-Features: AclHuK9to6P-30XfXf0uGBOhSUfbC4YWpupKqg9PMA7zFZ_UL3ZbA7qPtiQp9CQ
Message-ID: <CAN4PorXcxHeZpqMHKfZqrN3XNmzZRQps_p6Ux_dRsGbB0YwG5Q@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: encode debug translation ranges
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: alistair.francis@wdc.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com, 
 pbonzini@redhat.com
Content-Type: multipart/alternative; boundary="0000000000001d24ce065e635932"
Received-SPF: pass client-ip=2a00:1450:4864:38::;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-lr2-x00.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000001d24ce065e635932
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Thanks for letting me know, and sorry about the malformed patch.

I'll regenerate the patch, verify that it applies cleanly with git am, and
resend it as v2.

Thanks,
Zephyr

On Wed, Oct 21, 2026 at 7:57=E2=80=AFPM Daniel Henrique Barboza <
daniel.barboza@oss.qualcomm.com> wrote:

> Hi Zephyr,
>
> I am unable to apply this patch because git got nervous with a "corrupt
> file error":
>
> $ git am \[PATCH\]\ hw_riscv_riscv-iommu_\ encode\ debug\ translation\
> ranges\ -\ Zephyr\ Li\ \(fritchleybohrer@gmail.com\)\ -\ 2026-10-16\
> 0608.eml
> Applying: hw/riscv/riscv-iommu: encode debug translation ranges
> error: corrupt patch at line 243
> Patch failed at 0001 hw/riscv/riscv-iommu: encode debug translation range=
s
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> Tried the usual stuff with 'dos2unix', redownloading the patch and so on
> but
> still the same error.
>
>
> Can you please re-send?  Thanks,
> Daniel
>
> On 10/16/2026 6:08 AM, Zephyr Li wrote:
> > The debug translation response aligns the translated physical address t=
o
> > the effective translation range, but always reports S=3D0. For a reques=
t
> > inside a superpage, the response therefore identifies the wrong 4 KiB
> > physical page.
> >
> > For effective ranges larger than 4 KiB, set S and encode the range size
> > using trailing ones in the PPN field. Keep the existing response format
> > for 4 KiB translations.
> >
> > The RISC-V IOMMU specification permits reporting a 4 KiB translation ev=
en
> > when the page tables use superpages. Reporting the effective range is a=
n
> > implementation choice; this change does not claim that S=3D1 is mandato=
ry
> > for every translation through a superpage mapping.
> >
> > Add debug-response tests for S-stage-only 4 KiB, 64 KiB NAPOT, and 2 Mi=
B
> > translations, G-stage-only 2 MiB translations, and nested S4K/G2M,
> > S2M/G4K, and S2M/G2M mappings. Check requests inside large ranges and a=
t
> > both ends. The mixed nested cases verify that the response uses the
> > smaller effective translation granularity.
> >
> > Fixes: a7aa525b93c3 ("hw/riscv/riscv-iommu: add DBG support")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3552
> > Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> > ---
> >   hw/riscv/riscv-iommu.c         |  14 ++-
> >   tests/qtest/iommu-riscv-test.c | 193 ++++++++++++++++++++++++++++++++=
+
> >   2 files changed, 206 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> > index
> 323a041b4a558136819b1cd41452e96481ba164a..67d8456b9d3ed34308ca794e8d70066=
4ebacce0f
> 100644
> > --- a/hw/riscv/riscv-iommu.c
> > +++ b/hw/riscv/riscv-iommu.c
> > @@ -2281,8 +2281,20 @@ static void
> riscv_iommu_process_dbg(RISCVIOMMUState *s)
> >           if (fault) {
> >               iova =3D RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) fau=
lt)
> << 10);
> >           } else {
> > +            uint64_t ppn;
> > +
> >               iova =3D iotlb.translated_addr & ~iotlb.addr_mask;
> > -            iova =3D set_field(0, RISCV_IOMMU_TR_RESPONSE_PPN,
> PPN_DOWN(iova));
> > +            ppn =3D PPN_DOWN(iova);
> > +
> > +            if (iotlb.addr_mask > TARGET_PAGE_SIZE - 1) {
> > +                /* Encode the translation range as trailing ones in th=
e
> PPN. */
> > +                ppn |=3D PPN_DOWN(iotlb.addr_mask) >> 1;
> > +                iova =3D RISCV_IOMMU_TR_RESPONSE_S;
> > +            } else {
> > +                iova =3D 0;
> > +            }
> > +
> > +            iova =3D set_field(iova, RISCV_IOMMU_TR_RESPONSE_PPN, ppn)=
;
> >           }
> >           riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE, iova);
> >       }
> > diff --git a/tests/qtest/iommu-riscv-test.c
> b/tests/qtest/iommu-riscv-test.c
> > index
> 26380248912cc281e313e20a3daf1831be1eded3..1cd753c4f243f207dc34b7acbe41ef0=
d55772cba
> 100644
> > --- a/tests/qtest/iommu-riscv-test.c
> > +++ b/tests/qtest/iommu-riscv-test.c
> > @@ -19,6 +19,12 @@
> >
> >   #define DMA_LEN           4
> >
> > +#define DBG_PAGE_SIZE           0x1000ull
> > +#define DBG_NAPOT_SIZE          0x10000ull
> > +#define DBG_SUPERPAGE_SIZE      0x200000ull
> > +#define DBG_TRANSLATED_PA       0x90000000ull
> > +#define DBG_NESTED_GPA          0x200000ull
> > +
> >   /* RISC-V virt machine PCI configuration */
> >   #define RISCV_GPEX_PIO_BASE        0x3000000
> >   #define RISCV_BUS_PIO_LIMIT        0x10000
> > @@ -35,6 +41,64 @@ typedef struct RiscvIommuTestState {
> >       uint64_t iommu_base;
> >   } RiscvIommuTestState;
> >
> > +typedef struct RiscvIommuDbgTest {
> > +    const char *name;
> > +    QRIOMMUTransMode mode;
> > +    uint64_t s_page_size;
> > +    uint64_t g_page_size;
> > +    uint64_t pa;
> > +    uint64_t expected_response;
> > +} RiscvIommuDbgTest;
> > +
> > +static const RiscvIommuDbgTest debug_tests[] =3D {
> > +    {
> > +        .name =3D "page-4k",
> > +        .mode =3D QRIOMMU_TM_S_STAGE_ONLY,
> > +        .s_page_size =3D DBG_PAGE_SIZE,
> > +        .pa =3D DBG_TRANSLATED_PA + DBG_PAGE_SIZE,
> > +        .expected_response =3D 0x24000400ull,
> > +    }, {
> > +        .name =3D "napot-64k",
> > +        .mode =3D QRIOMMU_TM_S_STAGE_ONLY,
> > +        .s_page_size =3D DBG_NAPOT_SIZE,
> > +        .pa =3D DBG_TRANSLATED_PA,
> > +        .expected_response =3D 0x24001e00ull,
> > +    }, {
> > +        .name =3D "superpage",
> > +        .mode =3D QRIOMMU_TM_S_STAGE_ONLY,
> > +        .s_page_size =3D DBG_SUPERPAGE_SIZE,
> > +        .pa =3D DBG_TRANSLATED_PA,
> > +        .expected_response =3D 0x2403fe00ull,
> > +    }, {
> > +        .name =3D "g-stage-superpage",
> > +        .mode =3D QRIOMMU_TM_G_STAGE_ONLY,
> > +        .g_page_size =3D DBG_SUPERPAGE_SIZE,
> > +        .pa =3D DBG_TRANSLATED_PA,
> > +        .expected_response =3D 0x2403fe00ull,
> > +    }, {
> > +        .name =3D "nested-s4k-g2m",
> > +        .mode =3D QRIOMMU_TM_NESTED,
> > +        .s_page_size =3D DBG_PAGE_SIZE,
> > +        .g_page_size =3D DBG_SUPERPAGE_SIZE,
> > +        .pa =3D DBG_TRANSLATED_PA,
> > +        .expected_response =3D 0x24001000ull,
> > +    }, {
> > +        .name =3D "nested-s2m-g4k",
> > +        .mode =3D QRIOMMU_TM_NESTED,
> > +        .s_page_size =3D DBG_SUPERPAGE_SIZE,
> > +        .g_page_size =3D DBG_PAGE_SIZE,
> > +        .pa =3D DBG_TRANSLATED_PA,
> > +        .expected_response =3D 0x24001000ull,
> > +    }, {
> > +        .name =3D "nested-s2m-g2m",
> > +        .mode =3D QRIOMMU_TM_NESTED,
> > +        .s_page_size =3D DBG_SUPERPAGE_SIZE,
> > +        .g_page_size =3D DBG_SUPERPAGE_SIZE,
> > +        .pa =3D DBG_TRANSLATED_PA,
> > +        .expected_response =3D 0x2403fe00ull,
> > +    },
> > +};
> > +
> >   static void riscv_config_qpci_bus(QGenericPCIBus *qpci)
> >   {
> >       qpci->gpex_pio_base =3D RISCV_GPEX_PIO_BASE;
> > @@ -264,6 +328,129 @@ static void test_riscv_iommu_nested(void)
> >       run_riscv_iommu_translation(&cfg);
> >   }
> >
> > +static void riscv_iommu_dbg_map_leaf(QTestState *qts, uint64_t l1_pa,
> > +                                    uint64_t l2_pa, uint64_t va,
> uint64_t pa,
> > +                                    uint64_t page_size)
> > +{
> > +    uint64_t pte =3D ((pa >> 12) << 10) | QRIOMMU_LEAF_PTE_RW_MASK;
> > +    uint64_t pte_addr;
> > +
> > +    g_assert_cmphex(pa & (page_size - 1), =3D=3D, 0);
> > +
> > +    if (page_size =3D=3D DBG_SUPERPAGE_SIZE) {
> > +        pte_addr =3D l1_pa + (((va >> 21) & 0x1ff) * sizeof(uint64_t))=
;
> > +        qtest_writeq(qts, pte_addr, pte);
> > +    } else if (page_size =3D=3D DBG_NAPOT_SIZE) {
> > +        /* A 64 KiB NAPOT PTE has N=3D1 and PPN[3:0]=3D1000. */
> > +        pte |=3D BIT_ULL(63) | (8ull << 10);
> > +        va &=3D ~(DBG_NAPOT_SIZE - 1);
> > +        for (unsigned i =3D 0; i < DBG_NAPOT_SIZE / DBG_PAGE_SIZE; i++=
) {
> > +            pte_addr =3D l2_pa + ((((va >> 12) + i) & 0x1ff) *
> > +                                sizeof(uint64_t));
> > +            qtest_writeq(qts, pte_addr, pte);
> > +        }
> > +    } else {
> > +        g_assert_cmphex(page_size, =3D=3D, DBG_PAGE_SIZE);
> > +        pte_addr =3D l2_pa + (((va >> 12) & 0x1ff) * sizeof(uint64_t))=
;
> > +        qtest_writeq(qts, pte_addr, pte);
> > +    }
> > +}
> > +
> > +static uint64_t riscv_iommu_dbg_translate(RiscvIommuTestState *state,
> > +                                         uint64_t iova)
> > +{
> > +    uint64_t request;
> > +
> > +    qtest_writeq(state->qts,
> > +                 state->iommu_base + RISCV_IOMMU_REG_TR_REQ_IOVA, iova=
);
> > +    request =3D ((uint64_t)state->testdev->devfn << 40) |
> > +              RISCV_IOMMU_TR_REQ_CTL_GO_BUSY;
> > +    qtest_writeq(state->qts,
> > +                 state->iommu_base + RISCV_IOMMU_REG_TR_REQ_CTL,
> request);
> > +
> > +    request =3D qtest_readq(state->qts,
> > +                          state->iommu_base +
> RISCV_IOMMU_REG_TR_REQ_CTL);
> > +    g_assert_cmpuint(request & RISCV_IOMMU_TR_REQ_CTL_GO_BUSY, =3D=3D,=
 0);
> > +
> > +    return qtest_readq(state->qts,
> > +                       state->iommu_base + RISCV_IOMMU_REG_TR_RESPONSE=
);
> > +}
> > +
> > +static void test_riscv_iommu_dbg(gconstpointer data)
> > +{
> > +    const RiscvIommuDbgTest *cfg =3D data;
> > +    RiscvIommuTestState state =3D { 0 };
> > +    uint64_t iova =3D QRIOMMU_IOVA & ~(DBG_PAGE_SIZE - 1);
> > +    uint64_t s_pa =3D cfg->pa;
> > +    uint64_t page_size =3D cfg->mode =3D=3D QRIOMMU_TM_G_STAGE_ONLY ?
> > +                         cfg->g_page_size : cfg->s_page_size;
> > +    uint64_t response;
> > +
> > +    if (!riscv_iommu_test_setup(&state)) {
> > +        return;
> > +    }
> > +
> > +    riscv_iommu_check(state.qts, state.iommu_base, cfg->mode);
> > +    qriommu_build_translation(state.qts, cfg->mode,
> state.testdev->devfn);
> > +
> > +    if (cfg->mode =3D=3D QRIOMMU_TM_NESTED) {
> > +        uint64_t g_l1_pa =3D QRIOMMU_SPACE_OFFS + QRIOMMU_G_L0_PTE_VAL=
;
> > +        uint64_t g_l2_pa =3D QRIOMMU_SPACE_OFFS + QRIOMMU_G_L1_PTE_VAL=
;
> > +        uint64_t offset =3D iova & (DBG_SUPERPAGE_SIZE - 1);
> > +        uint64_t gpa =3D DBG_NESTED_GPA + offset;
> > +        uint64_t pte_addr;
> > +        uint64_t pte;
> > +
> > +        /* Map all S-stage page tables through one 2 MiB G-stage leaf.
> */
> > +        riscv_iommu_dbg_map_leaf(state.qts, g_l1_pa, g_l2_pa, 0,
> > +                                 QRIOMMU_SPACE_OFFS,
> DBG_SUPERPAGE_SIZE);
> > +
> > +        if (cfg->g_page_size =3D=3D DBG_PAGE_SIZE) {
> > +            pte_addr =3D g_l1_pa + (((gpa >> 21) & 0x1ff) *
> sizeof(uint64_t));
> > +            pte =3D ((g_l2_pa >> 12) << 10) | QRIOMMU_NON_LEAF_PTE_MAS=
K;
> > +            qtest_writeq(state.qts, pte_addr, pte);
> > +        }
> > +        riscv_iommu_dbg_map_leaf(state.qts, g_l1_pa, g_l2_pa, gpa,
> > +                                 cfg->pa + (offset & ~(cfg->g_page_siz=
e
> - 1)),
> > +                                 cfg->g_page_size);
> > +        s_pa =3D gpa & ~(cfg->s_page_size - 1);
> > +        page_size =3D MIN(page_size, cfg->g_page_size);
> > +    }
> > +
> > +    if (cfg->mode =3D=3D QRIOMMU_TM_G_STAGE_ONLY) {
> > +        riscv_iommu_dbg_map_leaf(state.qts,
> > +                                 QRIOMMU_SPACE_OFFS +
> QRIOMMU_G_L0_PTE_VAL,
> > +                                 QRIOMMU_SPACE_OFFS +
> QRIOMMU_G_L1_PTE_VAL,
> > +                                 iova, cfg->pa, cfg->g_page_size);
> > +    } else {
> > +        riscv_iommu_dbg_map_leaf(state.qts,
> > +                                 QRIOMMU_SPACE_OFFS +
> QRIOMMU_L0_PTE_VAL,
> > +                                 QRIOMMU_SPACE_OFFS +
> QRIOMMU_L1_PTE_VAL,
> > +                                 iova, s_pa, cfg->s_page_size);
> > +    }
> > +    qriommu_program_regs(state.qts, state.iommu_base);
> > +
> > +    /*
> > +     * The specification permits reporting a smaller range. These test=
s
> > +     * verify QEMU's choice to report the effective translation range.
> > +     */
> > +    response =3D riscv_iommu_dbg_translate(&state, iova);
> > +    g_assert_cmphex(response, =3D=3D, cfg->expected_response);
> > +
> > +    if (page_size > DBG_PAGE_SIZE) {
> > +        /* Check the first and last pages, in addition to the interior=
.
> */
> > +        iova &=3D ~(page_size - 1);
> > +        response =3D riscv_iommu_dbg_translate(&state, iova);
> > +        g_assert_cmphex(response, =3D=3D, cfg->expected_response);
> > +        response =3D riscv_iommu_dbg_translate(&state,
> > +                                            iova + page_size -
> DBG_PAGE_SIZE);
> > +        g_assert_cmphex(response, =3D=3D, cfg->expected_response);
> > +    }
> > +
> > +    riscv_iommu_test_teardown(&state);
> > +}
> > +
> >   int main(int argc, char **argv)
> >   {
> >       g_test_init(&argc, &argv, NULL);
> > @@ -275,5 +462,11 @@ int main(int argc, char **argv)
> >                      test_riscv_iommu_g_stage_only);
> >       qtest_add_func("/iommu-testdev/translation/ns-nested",
> >                      test_riscv_iommu_nested);
> > +    for (unsigned i =3D 0; i < G_N_ELEMENTS(debug_tests); i++) {
> > +        g_autofree char *path =3D
> g_strdup_printf("/iommu-testdev/debug/%s",
> > +                                               debug_tests[i].name);
> > +
> > +        qtest_add_data_func(path, &debug_tests[i],
> test_riscv_iommu_dbg);
> > +    }
> >       return g_test_run();
> >   }
>
>

--0000000000001d24ce065e635932
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hi Daniel,</p><p>Thanks for letting me know, and sorry =
about the malformed patch.</p><p>I&#39;ll regenerate the patch, verify that=
 it applies cleanly with git am, and resend it as v2.</p><p>Thanks,<br>Zeph=
yr</p></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Oct 21, 2026 at 7:57=E2=80=AFPM Danie=
l Henrique Barboza &lt;<a href=3D"mailto:daniel.barboza@oss.qualcomm.com">d=
aniel.barboza@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Hi Zephyr,<br>
<br>
I am unable to apply this patch because git got nervous with a &quot;corrup=
t<br>
file error&quot;:<br>
<br>
$ git am \[PATCH\]\ hw_riscv_riscv-iommu_\ encode\ debug\ translation\ rang=
es\ -\ Zephyr\ Li\ \(<a href=3D"mailto:fritchleybohrer@gmail.com" target=3D=
"_blank">fritchleybohrer@gmail.com</a>\)\ -\ 2026-10-16\ 0608.eml<br>
Applying: hw/riscv/riscv-iommu: encode debug translation ranges<br>
error: corrupt patch at line 243<br>
Patch failed at 0001 hw/riscv/riscv-iommu: encode debug translation ranges<=
br>
hint: Use &#39;git am --show-current-patch=3Ddiff&#39; to see the failed pa=
tch<br>
When you have resolved this problem, run &quot;git am --continue&quot;.<br>
If you prefer to skip this patch, run &quot;git am --skip&quot; instead.<br=
>
To restore the original branch and stop patching, run &quot;git am --abort&=
quot;.<br>
<br>
Tried the usual stuff with &#39;dos2unix&#39;, redownloading the patch and =
so on but<br>
still the same error.<br>
<br>
<br>
Can you please re-send?=C2=A0 Thanks,<br>
Daniel<br>
<br>
On 10/16/2026 6:08 AM, Zephyr Li wrote:<br>
&gt; The debug translation response aligns the translated physical address =
to<br>
&gt; the effective translation range, but always reports S=3D0. For a reque=
st<br>
&gt; inside a superpage, the response therefore identifies the wrong 4 KiB<=
br>
&gt; physical page.<br>
&gt; <br>
&gt; For effective ranges larger than 4 KiB, set S and encode the range siz=
e<br>
&gt; using trailing ones in the PPN field. Keep the existing response forma=
t<br>
&gt; for 4 KiB translations.<br>
&gt; <br>
&gt; The RISC-V IOMMU specification permits reporting a 4 KiB translation e=
ven<br>
&gt; when the page tables use superpages. Reporting the effective range is =
an<br>
&gt; implementation choice; this change does not claim that S=3D1 is mandat=
ory<br>
&gt; for every translation through a superpage mapping.<br>
&gt; <br>
&gt; Add debug-response tests for S-stage-only 4 KiB, 64 KiB NAPOT, and 2 M=
iB<br>
&gt; translations, G-stage-only 2 MiB translations, and nested S4K/G2M,<br>
&gt; S2M/G4K, and S2M/G2M mappings. Check requests inside large ranges and =
at<br>
&gt; both ends. The mixed nested cases verify that the response uses the<br=
>
&gt; smaller effective translation granularity.<br>
&gt; <br>
&gt; Fixes: a7aa525b93c3 (&quot;hw/riscv/riscv-iommu: add DBG support&quot;=
)<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items=
/3552" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project=
/qemu/-/work_items/3552</a><br>
&gt; Signed-off-by: Zephyr Li &lt;<a href=3D"mailto:fritchleybohrer@gmail.c=
om" target=3D"_blank">fritchleybohrer@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/riscv/riscv-iommu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 14 ++-<br>
&gt;=C2=A0 =C2=A0tests/qtest/iommu-riscv-test.c | 193 +++++++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A02 files changed, 206 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c<br>
&gt; index 323a041b4a558136819b1cd41452e96481ba164a..67d8456b9d3ed34308ca79=
4e8d700664ebacce0f 100644<br>
&gt; --- a/hw/riscv/riscv-iommu.c<br>
&gt; +++ b/hw/riscv/riscv-iommu.c<br>
&gt; @@ -2281,8 +2281,20 @@ static void riscv_iommu_process_dbg(RISCVIOMMUS=
tate *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fault) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iova =3D RISCV_I=
OMMU_TR_RESPONSE_FAULT | (((uint64_t) fault) &lt;&lt; 10);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t ppn;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iova =3D iotlb.t=
ranslated_addr &amp; ~iotlb.addr_mask;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iova =3D set_field(0, RISCV=
_IOMMU_TR_RESPONSE_PPN, PPN_DOWN(iova));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ppn =3D PPN_DOWN(iova);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iotlb.addr_mask &gt; TA=
RGET_PAGE_SIZE - 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Encode the=
 translation range as trailing ones in the PPN. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ppn |=3D PPN_=
DOWN(iotlb.addr_mask) &gt;&gt; 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iova =3D RISC=
V_IOMMU_TR_RESPONSE_S;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iova =3D 0;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iova =3D set_field(iova, RI=
SCV_IOMMU_TR_RESPONSE_PPN, ppn);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_iommu_reg_set64(s, RISCV=
_IOMMU_REG_TR_RESPONSE, iova);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; diff --git a/tests/qtest/iommu-riscv-test.c b/tests/qtest/iommu-riscv-=
test.c<br>
&gt; index 26380248912cc281e313e20a3daf1831be1eded3..1cd753c4f243f207dc34b7=
acbe41ef0d55772cba 100644<br>
&gt; --- a/tests/qtest/iommu-riscv-test.c<br>
&gt; +++ b/tests/qtest/iommu-riscv-test.c<br>
&gt; @@ -19,6 +19,12 @@<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#define DMA_LEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04<=
br>
&gt;=C2=A0 =C2=A0<br>
&gt; +#define DBG_PAGE_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1000u=
ll<br>
&gt; +#define DBG_NAPOT_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x10000ull<b=
r>
&gt; +#define DBG_SUPERPAGE_SIZE=C2=A0 =C2=A0 =C2=A0 0x200000ull<br>
&gt; +#define DBG_TRANSLATED_PA=C2=A0 =C2=A0 =C2=A0 =C2=A00x90000000ull<br>
&gt; +#define DBG_NESTED_GPA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x200000ull<=
br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/* RISC-V virt machine PCI configuration */<br>
&gt;=C2=A0 =C2=A0#define RISCV_GPEX_PIO_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x3=
000000<br>
&gt;=C2=A0 =C2=A0#define RISCV_BUS_PIO_LIMIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1=
0000<br>
&gt; @@ -35,6 +41,64 @@ typedef struct RiscvIommuTestState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t iommu_base;<br>
&gt;=C2=A0 =C2=A0} RiscvIommuTestState;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +typedef struct RiscvIommuDbgTest {<br>
&gt; +=C2=A0 =C2=A0 const char *name;<br>
&gt; +=C2=A0 =C2=A0 QRIOMMUTransMode mode;<br>
&gt; +=C2=A0 =C2=A0 uint64_t s_page_size;<br>
&gt; +=C2=A0 =C2=A0 uint64_t g_page_size;<br>
&gt; +=C2=A0 =C2=A0 uint64_t pa;<br>
&gt; +=C2=A0 =C2=A0 uint64_t expected_response;<br>
&gt; +} RiscvIommuDbgTest;<br>
&gt; +<br>
&gt; +static const RiscvIommuDbgTest debug_tests[] =3D {<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;page-4k&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .mode =3D QRIOMMU_TM_S_STAGE_ONLY,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .s_page_size =3D DBG_PAGE_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa =3D DBG_TRANSLATED_PA + DBG_PAGE_SIZE=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .expected_response =3D 0x24000400ull,<br>
&gt; +=C2=A0 =C2=A0 }, {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;napot-64k&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .mode =3D QRIOMMU_TM_S_STAGE_ONLY,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .s_page_size =3D DBG_NAPOT_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa =3D DBG_TRANSLATED_PA,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .expected_response =3D 0x24001e00ull,<br>
&gt; +=C2=A0 =C2=A0 }, {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;superpage&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .mode =3D QRIOMMU_TM_S_STAGE_ONLY,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .s_page_size =3D DBG_SUPERPAGE_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa =3D DBG_TRANSLATED_PA,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .expected_response =3D 0x2403fe00ull,<br>
&gt; +=C2=A0 =C2=A0 }, {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;g-stage-superpage&quot;,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .mode =3D QRIOMMU_TM_G_STAGE_ONLY,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .g_page_size =3D DBG_SUPERPAGE_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa =3D DBG_TRANSLATED_PA,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .expected_response =3D 0x2403fe00ull,<br>
&gt; +=C2=A0 =C2=A0 }, {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;nested-s4k-g2m&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .mode =3D QRIOMMU_TM_NESTED,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .s_page_size =3D DBG_PAGE_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .g_page_size =3D DBG_SUPERPAGE_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa =3D DBG_TRANSLATED_PA,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .expected_response =3D 0x24001000ull,<br>
&gt; +=C2=A0 =C2=A0 }, {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;nested-s2m-g4k&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .mode =3D QRIOMMU_TM_NESTED,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .s_page_size =3D DBG_SUPERPAGE_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .g_page_size =3D DBG_PAGE_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa =3D DBG_TRANSLATED_PA,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .expected_response =3D 0x24001000ull,<br>
&gt; +=C2=A0 =C2=A0 }, {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;nested-s2m-g2m&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .mode =3D QRIOMMU_TM_NESTED,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .s_page_size =3D DBG_SUPERPAGE_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .g_page_size =3D DBG_SUPERPAGE_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .pa =3D DBG_TRANSLATED_PA,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .expected_response =3D 0x2403fe00ull,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static void riscv_config_qpci_bus(QGenericPCIBus *qpci)<br=
>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qpci-&gt;gpex_pio_base =3D RISCV_GPEX_PIO_BA=
SE;<br>
&gt; @@ -264,6 +328,129 @@ static void test_riscv_iommu_nested(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0run_riscv_iommu_translation(&amp;cfg);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static void riscv_iommu_dbg_map_leaf(QTestState *qts, uint64_t l1_pa,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t l2_pa, ui=
nt64_t va, uint64_t pa,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t page_size=
)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint64_t pte =3D ((pa &gt;&gt; 12) &lt;&lt; 10) | QRIOM=
MU_LEAF_PTE_RW_MASK;<br>
&gt; +=C2=A0 =C2=A0 uint64_t pte_addr;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(pa &amp; (page_size - 1), =3D=3D, 0);<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (page_size =3D=3D DBG_SUPERPAGE_SIZE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pte_addr =3D l1_pa + (((va &gt;&gt; 21) &=
amp; 0x1ff) * sizeof(uint64_t));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qtest_writeq(qts, pte_addr, pte);<br>
&gt; +=C2=A0 =C2=A0 } else if (page_size =3D=3D DBG_NAPOT_SIZE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* A 64 KiB NAPOT PTE has N=3D1 and PPN[3=
:0]=3D1000. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pte |=3D BIT_ULL(63) | (8ull &lt;&lt; 10)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 va &amp;=3D ~(DBG_NAPOT_SIZE - 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (unsigned i =3D 0; i &lt; DBG_NAPOT_S=
IZE / DBG_PAGE_SIZE; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pte_addr =3D l2_pa + ((((va=
 &gt;&gt; 12) + i) &amp; 0x1ff) *<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(uint64_t));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qtest_writeq(qts, pte_addr,=
 pte);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmphex(page_size, =3D=3D, DBG_PA=
GE_SIZE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pte_addr =3D l2_pa + (((va &gt;&gt; 12) &=
amp; 0x1ff) * sizeof(uint64_t));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qtest_writeq(qts, pte_addr, pte);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint64_t riscv_iommu_dbg_translate(RiscvIommuTestState *state,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint64_t iova)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint64_t request;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_writeq(state-&gt;qts,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0state-&=
gt;iommu_base + RISCV_IOMMU_REG_TR_REQ_IOVA, iova);<br>
&gt; +=C2=A0 =C2=A0 request =3D ((uint64_t)state-&gt;testdev-&gt;devfn &lt;=
&lt; 40) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_IOMMU_TR_REQ_C=
TL_GO_BUSY;<br>
&gt; +=C2=A0 =C2=A0 qtest_writeq(state-&gt;qts,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0state-&=
gt;iommu_base + RISCV_IOMMU_REG_TR_REQ_CTL, request);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 request =3D qtest_readq(state-&gt;qts,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 state-&gt;iommu_base + RISCV_IOMMU_REG_TR_REQ_CTL);<b=
r>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint(request &amp; RISCV_IOMMU_TR_REQ_CTL_G=
O_BUSY, =3D=3D, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return qtest_readq(state-&gt;qts,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0state-&gt;iommu_base + RISCV_IOMMU_REG_TR_RESPONSE);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void test_riscv_iommu_dbg(gconstpointer data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const RiscvIommuDbgTest *cfg =3D data;<br>
&gt; +=C2=A0 =C2=A0 RiscvIommuTestState state =3D { 0 };<br>
&gt; +=C2=A0 =C2=A0 uint64_t iova =3D QRIOMMU_IOVA &amp; ~(DBG_PAGE_SIZE - =
1);<br>
&gt; +=C2=A0 =C2=A0 uint64_t s_pa =3D cfg-&gt;pa;<br>
&gt; +=C2=A0 =C2=A0 uint64_t page_size =3D cfg-&gt;mode =3D=3D QRIOMMU_TM_G=
_STAGE_ONLY ?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0cfg-&gt;g_page_size : cfg-&gt;s_page_size;<br>
&gt; +=C2=A0 =C2=A0 uint64_t response;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!riscv_iommu_test_setup(&amp;state)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_check(state.qts, state.iommu_base, cfg-&gt;=
mode);<br>
&gt; +=C2=A0 =C2=A0 qriommu_build_translation(state.qts, cfg-&gt;mode, stat=
e.testdev-&gt;devfn);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (cfg-&gt;mode =3D=3D QRIOMMU_TM_NESTED) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t g_l1_pa =3D QRIOMMU_SPACE_OFFS +=
 QRIOMMU_G_L0_PTE_VAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t g_l2_pa =3D QRIOMMU_SPACE_OFFS +=
 QRIOMMU_G_L1_PTE_VAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t offset =3D iova &amp; (DBG_SUPER=
PAGE_SIZE - 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t gpa =3D DBG_NESTED_GPA + offset;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t pte_addr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t pte;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Map all S-stage page tables through on=
e 2 MiB G-stage leaf. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_dbg_map_leaf(state.qts, g_l1_=
pa, g_l2_pa, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QRIOMMU_SPACE_OFFS, DBG_SU=
PERPAGE_SIZE);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cfg-&gt;g_page_size =3D=3D DBG_PAGE_S=
IZE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pte_addr =3D g_l1_pa + (((g=
pa &gt;&gt; 21) &amp; 0x1ff) * sizeof(uint64_t));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pte =3D ((g_l2_pa &gt;&gt; =
12) &lt;&lt; 10) | QRIOMMU_NON_LEAF_PTE_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qtest_writeq(state.qts, pte=
_addr, pte);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_dbg_map_leaf(state.qts, g_l1_=
pa, g_l2_pa, gpa,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cfg-&gt;pa + (offset &amp;=
 ~(cfg-&gt;g_page_size - 1)),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cfg-&gt;g_page_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s_pa =3D gpa &amp; ~(cfg-&gt;s_page_size =
- 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 page_size =3D MIN(page_size, cfg-&gt;g_pa=
ge_size);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (cfg-&gt;mode =3D=3D QRIOMMU_TM_G_STAGE_ONLY) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_dbg_map_leaf(state.qts,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QRIOMMU_SPACE_OFFS + QRIOM=
MU_G_L0_PTE_VAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QRIOMMU_SPACE_OFFS + QRIOM=
MU_G_L1_PTE_VAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iova, cfg-&gt;pa, cfg-&gt;=
g_page_size);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_dbg_map_leaf(state.qts,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QRIOMMU_SPACE_OFFS + QRIOM=
MU_L0_PTE_VAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QRIOMMU_SPACE_OFFS + QRIOM=
MU_L1_PTE_VAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iova, s_pa, cfg-&gt;s_page=
_size);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 qriommu_program_regs(state.qts, state.iommu_base);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* The specification permits reporting a smaller r=
ange. These tests<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* verify QEMU&#39;s choice to report the effectiv=
e translation range.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 response =3D riscv_iommu_dbg_translate(&amp;state, iova=
);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(response, =3D=3D, cfg-&gt;expected_resp=
onse);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (page_size &gt; DBG_PAGE_SIZE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check the first and last pages, in add=
ition to the interior. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iova &amp;=3D ~(page_size - 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 response =3D riscv_iommu_dbg_translate(&a=
mp;state, iova);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmphex(response, =3D=3D, cfg-&gt=
;expected_response);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 response =3D riscv_iommu_dbg_translate(&a=
mp;state,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 iova + page_size - DBG_PAGE_SIZE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmphex(response, =3D=3D, cfg-&gt=
;expected_response);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_test_teardown(&amp;state);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_test_init(&amp;argc, &amp;argv, NULL);<br>
&gt; @@ -275,5 +462,11 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 test_riscv_iommu_g_stage_only);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qtest_add_func(&quot;/iommu-testdev/translat=
ion/ns-nested&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 test_riscv_iommu_nested);<br>
&gt; +=C2=A0 =C2=A0 for (unsigned i =3D 0; i &lt; G_N_ELEMENTS(debug_tests)=
; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *path =3D g_strdup_printf=
(&quot;/iommu-testdev/debug/%s&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0debug_tests[i].name);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qtest_add_data_func(path, &amp;debug_test=
s[i], test_riscv_iommu_dbg);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return g_test_run();<br>
&gt;=C2=A0 =C2=A0}<br>
<br>
</blockquote></div>

--0000000000001d24ce065e635932--

