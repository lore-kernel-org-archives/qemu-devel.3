Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEACC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 07:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbbL4-0008G7-3W; Wed, 07 Aug 2024 03:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sbbL2-0008F2-P8
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:44:04 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sbbL0-0001aL-Ef
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:44:04 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52efaae7edfso1067758e87.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723016640; x=1723621440;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s6PZf4AmC0JVvgN57YArSD/aWPIgGOkn6zPh+i54Mkk=;
 b=07zUf68fPb/wL6Q5+tsSb4ABHeHwc66LxbRVZiYMK2X8bhHFnf8mJvp/sD6itgp9k2
 xV4Ni209nSXvmVV+1KtDOVM5lngwMTscIEhwagFjJJUjpeoTH6iNeMK8rCYi6uP4bkr8
 4SqSbPjB9tu64dOnh9ZvuGddBxvEXQlVnKN0qcaMf3P4yfU63kcEsG3JAdE7+ZxD1N8Y
 6kIDKoRGI73S8MauE2H6rYxbpESfztamtX4n4TZdsIo7DgSBCbjG8K6PYHxLtAiugO0F
 EkloFHPFuIaJhrOLeTErpfr1+YPO5ijgOeE5DT0IQvNUiK47CQhO0h48+IT94Ag7bpYM
 9xEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723016640; x=1723621440;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s6PZf4AmC0JVvgN57YArSD/aWPIgGOkn6zPh+i54Mkk=;
 b=huCseJUx/uFcXIfestdNK7qr8BYINUB8O2xubV1bb5nFclrk89v81toCg7GisvSAGr
 3PXWz4peULvH9sz/yRUi6OB0vYstDkqmbyE8ysoIN2YvNa4LcEUjO7kqZ+hlsOAP7D4/
 jdTqueHN89y2UDDMI1NUZ095KA3sITeCSVue4v4KsgI0ffoTZbyrDxMJ3ZkqcvjQi6w8
 SJhX7X+GYMThkHvK7dnDx9W9vmmTSp8KY71v2K/i8osY0tl87u8gBFTbXPs1oQHG3iR7
 QK1LrNx3SQD3xAxZOAuA7me5AxOkLo0uwkYTud6vXfYH0MrLtrDSbNRgRswr4BwbG3la
 uDJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUChVEHBJaErWBoXG7qG0Vq5AZPYIJ/Fqbdcl8zy+CBAxzjbsjwX8jyd0PuSAZlz69sQfNU0/wGmLTA3XJGtZkvKS0PKMs=
X-Gm-Message-State: AOJu0YxJzO/WcMf5EcM/ubTOw/V7at+z6oW7crfwKhYK/CC+PqZDj83m
 w5AcewQNZl99HmcuYD72itbBmBNocW+n5PKNjcNaj72LqY/sXQB0t5rzzp/PNxhBs2TicfWw9RA
 3F5uDIg9FBhCWVnS0uE5D01xu+S95DLP52aq3NQ==
X-Google-Smtp-Source: AGHT+IGTACICxSgR+6mG2LfvXShvTQ0j0Qp86iu03xKuRgb+s+0rDyvkiHX8zKcSQrALrmMRX6WSPHhug0+Ll+eotcw=
X-Received: by 2002:a05:6512:31c6:b0:52c:e402:4dc1 with SMTP id
 2adb3069b0e04-530bb6c7f9cmr12753838e87.55.1723016640070; Wed, 07 Aug 2024
 00:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-13-c4170a5348ca@rivosinc.com>
 <20240806-9fdad33468ec103d83a85e77@orel>
 <3c09bbbe-857b-4566-963a-790497232bbf@ventanamicro.com>
 <CAKmqyKNgJKBFw7OnwbgbqxA65PR4GSjdUEKdKVw-nYv+e0P58w@mail.gmail.com>
In-Reply-To: <CAKmqyKNgJKBFw7OnwbgbqxA65PR4GSjdUEKdKVw-nYv+e0P58w@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Wed, 7 Aug 2024 00:43:49 -0700
Message-ID: <CAHBxVyFFa7mQaS4jPkT=aK4gTF3AshpQZNeRhBiZOHX7bhQQsg@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] target/riscv: Enable PMU related extensions to
 preferred rule
To: Alistair Francis <alistair23@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=atishp@rivosinc.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Aug 6, 2024 at 7:01=E2=80=AFPM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> On Wed, Aug 7, 2024 at 2:06=E2=80=AFAM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
> >
> >
> >
> > On 8/6/24 5:46 AM, Andrew Jones wrote:
> > > On Tue, Jul 23, 2024 at 04:30:10PM GMT, Atish Patra wrote:
> > >> Counter delegation/configuration extension requires the following
> > >> extensions to be enabled.
> > >>
> > >> 1. Smcdeleg - To enable counter delegation from M to S
> > >> 2. S[m|s]csrind - To enable indirect access CSRs
> > >> 3. Smstateen - Indirect CSR extensions depend on it.
> > >> 4. Sscofpmf - To enable counter overflow feature
> > >> 5. S[m|s]aia - To enable counter overflow feature in virtualization
> > >> 6. Smcntrpmf - To enable privilege mode filtering for cycle/instret
> > >>
> > >> While first 3 are mandatory to enable the counter delegation,
> > >> next 3 set of extension are preferred to enable all the PMU related
> > >> features.
> > >
> > > Just my 2 cents, but I think for the first three we can apply the con=
cept
> > > of extension bundles, which we need for other extensions as well. In =
those
> > > cases we just auto enable all the dependencies. For the three preferr=
ed
> > > extensions I think we can just leave them off for 'base', but we shou=
ld
> > > enable them by default for 'max' along with Ssccfg.
>

Max cpu will have everything enabled by default. The problem with max
cpu is that you
may not want to run all the available ISA extensions while testing perf.

> Agreed
>
> >
> > I like this idea. I would throw in all these 6 extensions in a 'pmu_adv=
anced_ops'
> > (or any other better fitting name for the bundle) flag and then 'pmu_ad=
vanced_ops=3Dtrue'
> > would enable all of those. 'pmu_advanced_ops=3Dtrue,smcntrpmf=3Dfalse' =
enables all but
> > 'smcntrpmf' and so on.
> >

I thought distinguishing preferred vs implied would be useful because
it would allow the user
to clearly understand which is mandated by ISA vs which would be good to ha=
ve.

The good to have extensions can be disabled similar to above but not
the mandatory ones.

> > As long as we document what the flag is enabling I don't see any proble=
ms with it.
> > This is how profiles are implemented after all.
>
> I only worry that we end up with a huge collection of flags that users
> need to decipher.
>

My initial idea was a separate flag as well. But I was not sure if
that was good for the
above reason. This additional custom pmu related option would be lost
in that huge collection.

> I guess with some good documentation this wouldn't be too confusing thoug=
h.
>

Sure. It won't be confusing but most users may not even know about it
without digging.
That's why I chose to use a standard extension which covers the basic
PMU access directly in S-mode.

The future extensions such as CTR or Sampling events would also
benefit by just adding the Ssccfg in the preferred rule
which in turn will enable other preferred/mandatory extensions.

> Alistair
>
> >
> > With this bundle we can also use implied rule only if an extension real=
ly needs
> > (i.e. it breaks without) a dependency being enabled, instead of overloa=
ding it
> > with extensions that 'would be nice to have together' like it seems to =
be the
> > case for the last 3 extensions in that list.
> >
> > I believe users would benefit more from a single flag to enable everyth=
ing and
> > be done with it.
> >
> >
> > Thanks,
> >
> > Daniel
> >
> >
> >
> > >
> > > Thanks,
> > > drew
> > >
> > >> That's why, enable all of these if Ssccfg extension is
> > >> enabled from the commandline.
> > >>
> > >> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > >> ---
> > >>   target/riscv/cpu.c | 14 +++++++++++++-
> > >>   1 file changed, 13 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > >> index 22ba43c7ff2a..abebfcc46dea 100644
> > >> --- a/target/riscv/cpu.c
> > >> +++ b/target/riscv/cpu.c
> > >> @@ -2665,8 +2665,20 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_impl=
ied_rules[] =3D {
> > >>       NULL
> > >>   };
> > >>
> > >> +static RISCVCPUPreferredExtsRule SSCCFG_PREFERRED =3D {
> > >> +    .ext =3D CPU_CFG_OFFSET(ext_ssccfg),
> > >> +    .preferred_multi_exts =3D {
> > >> +        CPU_CFG_OFFSET(ext_smcsrind), CPU_CFG_OFFSET(ext_sscsrind),
> > >> +        CPU_CFG_OFFSET(ext_ssaia), CPU_CFG_OFFSET(ext_smaia),
> > >> +        CPU_CFG_OFFSET(ext_smstateen), CPU_CFG_OFFSET(ext_sscofpmf)=
,
> > >> +        CPU_CFG_OFFSET(ext_smcntrpmf), CPU_CFG_OFFSET(ext_smcdeleg)=
,
> > >> +
> > >> +        RISCV_PREFRRED_EXTS_RULE_END
> > >> +    },
> > >> +};
> > >> +
> > >>   RISCVCPUPreferredExtsRule *riscv_multi_ext_preferred_rules[] =3D {
> > >> -    NULL
> > >> +    &SSCCFG_PREFERRED, NULL
> > >>   };
> > >>
> > >>   static Property riscv_cpu_properties[] =3D {
> > >>
> > >> --
> > >> 2.34.1
> > >>
> > >>
> >

