Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B079606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=OsVtvVJx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXCZ-0002bx-TG; Mon, 26 Oct 2026 22:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qingwei.hu@bytedance.com>)
 id 1xLXCX-0002bG-HY
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 22:46:13 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <qingwei.hu@bytedance.com>)
 id 1xLXCV-0004Am-1W
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 22:46:13 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3ae0852df46so379142a91.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 19:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1793069164; x=1793673964; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZYyUoShhDQQGcmceO4mUZ4L6sM0baDNPk9CgoYhzhqY=;
 b=OsVtvVJxr894Fv8jco/iPUWCbXzBByTkFS7ktiOp8sBkOBQmweKUExpfYryUYdRm3i
 J8cdU9J/lpS4uwBQCnRL/qgARBDgrv99KTR49DDOySdRYzI1zZR1ckLbO2aFYKE7Dgtd
 nLDq5OuefYLjaxc2ZD5mH5EGI9xtAN31fKFNNRk7QCRMsFHY/qcAQsapu6EeauITTL5W
 B5KT152v+I1NCm1lggIqwbk3AuACm1soa5rf5g0cOVmt35vZ9DhyOzmjWR6boVMIC0up
 zMkzjcH7oeWRySluYgydETlXpMFDWtZmOQ2IQb9+a8yAlUJP+qWi8hns/mcFVFrPVAK6
 MuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793069164; x=1793673964;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZYyUoShhDQQGcmceO4mUZ4L6sM0baDNPk9CgoYhzhqY=;
 b=U0OZgEij9ZCoNmvtYKAOifVAPEYdTgRFSAcl/AkYsVzLqDdXcFgtMIV+2sq9h3OQVP
 m04Jr/mVCSE0W8VWFWUQCJN99m6JdehwomNOzZYQDm22TgvzxGM8i75XytM4tkBMdCT/
 Xm9vlrM02vNplrSY+XPxrnhgKHRlGWihcEwQf/o+PCbV8a5X42lyERPrhO3EY4U4s76Y
 Xj61rkUQ12UuQzUD38eleOPsj7sPRYwoDVliprZKqgx8hZpK3jrhL4UyVspN7zV57gqw
 l1et5nBkOHEm1J0M3KJtH37JL82LecTqtll6U9q28bSFITn3VxU8bWsASmX1pRcnw4Ix
 RMow==
X-Gm-Message-State: AFq9FYITBpdGkcnhZNCj5UQkhjcEJi13NjkcX1TJLk9J31J262u6ed2X
 ZubHrZ8CEIICBVUvr5WDGuAmnc3bNwptSUTNxaVrDVm/l4lWlFI5Julh9DsG1NaRtdI=
X-Gm-Gg: AYBFou0XIhab9izHLWOleFMKIgzmE5LxM+0HNWBhUnBh3aTSHD0muQrb0LjiSIQZF8Y
 z3sC176RqYayE9TIcWrBheLIr2n/BaIv93uNn9WmowwiofS07ZuaGNhuJNa5MpHM8be8Ea+wmy8
 wQ2t002z3ORD+y17H6fdxjdfSw4m6VoghJnb0F32+kxpi80okJdXDL7okESQTPKvXU+Jbg57c3K
 UwqNdXFeU/cIiXMwx2ZhLk+tQcXWiXzewPNSoa7chL7QRYDjJapzm9l7yBRGfWN/QxW1Mn+mNFr
 PUvmqJ5ILKaK6XQs31I1H/LAlApLBDR3FfrUVzWwtUnYEHLM4akOXZlp7A6AyhGQdBQD/U0r2u8
 si8lpPAR8jGA9ikPmYfo2uhjcMioCnHsOQsolS9+92/EfJnieuFPM/2TJftqluqkhPWIzksnxwY
 Rndv7FlCJiDaeC/wFmVlon/QWVxZwyRvAhRT73XmwjPwOvNag68/r4GoyCSeR3k31HU677gvx3M
 mMtgQD7PDzRDp9Eho9JcFVBwdjx+TF/cKt/8IwW+OK5A4gSCcPWezPtCEbRhAa/lnm52n+ntwH5
 TV6n5WVpGg==
X-Received: by 2002:a17:90b:4b12:b0:3a7:9ec3:ea0e with SMTP id
 98e67ed59e1d1-3ae4029ab1amr729523a91.22.1793069163653; 
 Mon, 26 Oct 2026 19:46:03 -0700 (PDT)
Received: from smtpclient.apple ([186.240.245.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae40456f65sm1566619a91.13.2026.10.26.19.45.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Oct 2026 19:46:03 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 4/4] hw/riscv/virt: Limit interrupt identities to what KVM
 AIA supports
From: Qingwei Hu <qingwei.hu@bytedance.com>
In-Reply-To: <AB465835-0ECC-4A80-A410-FBC0C945140F@bytedance.com>
Date: Tue, 27 Oct 2026 10:45:46 +0800
Cc: qemu-devel@nongnu.org, Sunil V L <sunilvl@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <50141629-8EFA-4AD1-9BB6-75EBE845649A@bytedance.com>
References: <20260928-spacemit-k3-v1-0-8c57d0596b87@butz.st>
 <20260928-spacemit-k3-v1-4-8c57d0596b87@butz.st>
 <AB465835-0ECC-4A80-A410-FBC0C945140F@bytedance.com>
To: Stefan Butz <mail@butz.st>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=qingwei.hu@bytedance.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


> On Oct 6, 2026, at 10:53, Qingwei Hu <qingwei.hu@bytedance.com> wrote:
>=20
> Hi Stefan,
>=20
>> On Sep 28, 2026, at 14:06, Stefan Butz via <qemu-riscv@nongnu.org> =
wrote:
>>=20
>> The number of interrupt identities supported by the host's KVM AIA
>> is limited. On Spacemit K3 and Tenstorrent Atlantis to 63.
>> virt machine alwayas aks for 255 identities, so it fails if on those
>> platforms.
>>=20
>> Read and apply host limit from KVM AIA device and apply.
>>=20
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4599
>>=20
>> Signed-off-by: Stefan Butz <mail@butz.st>
>> ---
>> hw/riscv/virt.c              | 12 +++++++++++-
>> target/riscv/kvm/kvm-cpu.c   | 16 ++++++++++++++++
>> target/riscv/kvm/kvm-stub.c  |  5 +++++
>> target/riscv/kvm/kvm_riscv.h |  1 +
>> 4 files changed, 33 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index 28fa31d538..2af85ec5c3 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -78,6 +78,16 @@ static bool =
virt_use_emulated_aplic(RISCVVirtAIAType aia_type)
>>    return riscv_use_emulated_aplic(msimode);
>> }
>>=20
>> +static void virt_kvm_aia_create(RISCVVirtState *s)
>> +{
>> +    kvm_riscv_aia_create();
>> +
>> +    s->num_msis =3D MIN(s->num_msis, kvm_riscv_aia_get_num_ids());
>=20
> The host may support more than 255 guest interrupt identities, but
> this MIN() keeps num_msis capped at the default value of 255.
> Is this intentional to preserve the existing default? Would it make
> sense to allow users to configure a higher value when the host
> supports it?
>=20
>> +    if (!virt_use_emulated_aplic(s->aia_type)) {
>> +        s->num_sources =3D MIN(s->num_sources, s->num_msis);
>=20
> The value of num_sources has been modified here, while the value of
> aplic_props.irqchip_num_sources set in create_fdt_sockets still uses
> the default hard-coded value.
>=20
>> +    }
>> +}
>> +
>> static bool virt_aclint_allowed(void)
>> {
>>    return tcg_enabled() || qtest_enabled();
>> @@ -734,7 +744,7 @@ static void virt_machine_init(MachineState =
*machine)
>>    }
>>=20
>>    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
>> -        kvm_riscv_aia_create();
>> +        virt_kvm_aia_create(s);
>>    }
>>=20
>>    /* Initialize sockets */
>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>> index 1098581e7a..0409af3255 100644
>> --- a/target/riscv/kvm/kvm-cpu.c
>> +++ b/target/riscv/kvm/kvm-cpu.c
>> @@ -1870,6 +1870,22 @@ void kvm_riscv_aia_create(void)
>>    }
>> }
>>=20
>> +uint64_t kvm_riscv_aia_get_num_ids(void)
>> +{
>> +    uint64_t num_ids;
>> +    int ret;
>> +
>> +    ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
>> +                            KVM_DEV_RISCV_AIA_CONFIG_IDS,
>> +                            &num_ids, false, NULL);
>=20
> The KVM CONFIG_IDS GET attribute writes a u32, so num_ids should
> be uint32_t. With the current uint64_t variable, the upper 32 bits
> remain uninitialized and may affect the MIN() result.
>=20
> The return type, declaration, and non-KVM stub should also be
> updated accordingly.
>=20
>> +    if (ret < 0) {
>> +        error_report("KVM AIA: failed to get number of msi");
>> +        exit(1);
>> +    }
>> +
>> +    return num_ids;
>> +}
>> +
>> void kvm_riscv_aia_init(MachineState *machine, uint64_t group_shift,
>>                        uint64_t aia_irq_num, uint64_t aia_msi_num,
>>                        uint64_t aplic_base, uint64_t imsic_base,
>> diff --git a/target/riscv/kvm/kvm-stub.c =
b/target/riscv/kvm/kvm-stub.c
>> index 672f635b08..f5f5418b3c 100644
>> --- a/target/riscv/kvm/kvm-stub.c
>> +++ b/target/riscv/kvm/kvm-stub.c
>> @@ -14,6 +14,11 @@ void kvm_riscv_aia_create(void)
>>    g_assert_not_reached();
>> }
>>=20
>> +uint64_t kvm_riscv_aia_get_num_ids(void)
>> +{
>> +    g_assert_not_reached();
>> +}
>> +
>> void kvm_riscv_aia_init(MachineState *machine, uint64_t group_shift,
>>                        uint64_t aia_irq_num, uint64_t aia_msi_num,
>>                        uint64_t aplic_base, uint64_t imsic_base,
>> diff --git a/target/riscv/kvm/kvm_riscv.h =
b/target/riscv/kvm/kvm_riscv.h
>> index 532e42b0df..d8ae73fa1e 100644
>> --- a/target/riscv/kvm/kvm_riscv.h
>> +++ b/target/riscv/kvm/kvm_riscv.h
>> @@ -24,6 +24,7 @@
>> void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>> void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
>> void kvm_riscv_aia_create(void);
>> +uint64_t kvm_riscv_aia_get_num_ids(void);
>> void kvm_riscv_aia_init(MachineState *machine, uint64_t group_shift,
>>                        uint64_t aia_irq_num, uint64_t aia_msi_num,
>>                        uint64_t aplic_base, uint64_t imsic_base,
>>=20
>> --=20
>> Git-157)
>>=20
>=20
> Best regards,
> Qingwei Hu

Hi Stefan,

Are you already working on v2 of your AIA series? If it would help, =
I=E2=80=99d be
happy to prepare an updated version based on your patchset, addressing =
the
review comments.

Please let me know if you have changes in progress so we can avoid =
duplicating work.

Thanks,
Qingwei


