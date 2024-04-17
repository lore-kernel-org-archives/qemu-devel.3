Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795E8C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 08:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx13S-0000Cb-1e; Wed, 17 Apr 2024 04:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rx13O-0000CM-A5
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 04:54:06 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rx13K-0004aj-Pe
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 04:54:05 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dcc80d6004bso5300400276.0
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 01:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1713344036; x=1713948836; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGwSiMzvAKR+bq3SRViWE8ZoGbeuRmJT21WPOyLk3/o=;
 b=FmBykNi0rQHiwyzA0RBQ1iieTMhYaSFT+vbHpyO8kN9obX/C/ypb/OwJOgFZK68rDu
 7gzAfZMC9obZ/AdtQdS8jd1u9memSvEZ7r/n0JVOGSiqQgwI4IqvGMMdmiAhTGSr/lzV
 LHrMOC2xKuggXrO6bjCZUKqMr2Oai3Ieh6RWgRjxRH7sdAeWBYpr9vY7rDNA1t85gra6
 viubhve2wXy1tm4t1mIUVbOjDBY3dUc8MOdgZUKBYLBFUS6ZyZDth8Qe8CZdwj4pMX2R
 cya3nrpzvQTqR5qsNuGBLcsnhnH24Tz2iieg0sqz1CPO0GlXUydqWnSephMQ6Xdwqwac
 Eb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713344036; x=1713948836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OGwSiMzvAKR+bq3SRViWE8ZoGbeuRmJT21WPOyLk3/o=;
 b=deUnD21yTphgsn8lUReLaJJQitf8nFxeG6wH4fqvz02DsSN4Dlydd0dSp3GCaC9MpA
 I86VN0LqB6Bjc4My7BYqz3tgzdgnVC7kLdIYV+05qyxFvNHqidApDbnZp/MmWgq0Cznd
 d2Oq/k18Dtg1fcTeRbIYcyx//QnBuGdYCucF1BAE62hL9WeOj4TvO7GW4xviR3u4Tkkj
 fWDtwArD58HRCJqU4QvTc/UuPGUqz/sYruxt0HST6K35Ndl+1swLhEFRGApKvnWM04K7
 fq/y6cwP8loJ+HuYGrduKXzT+Sn/W4pfr0mGIs84QfKTnKbZLRckkWT1I3lgN7TFMkU3
 1/AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2hpeOygSM4MByOTJs9+Ug8LlWzNSlLbX22eoS38E7wvyFyBLlyRnZlzDDQZJuO3dajrm/H71ls1CVu7cFXTYwQLARlo4=
X-Gm-Message-State: AOJu0YzEXu1ZngeTs/IMCHn7KhioLwAo+2QJW+cmA4jPugi0yPtC0Z+8
 zA6Lty8/ejEbRh0IFizZu4004aRddwEbeHPYD0u/SVYQV9E/NfaFd6can3wXMTVifEfWQy1yBzx
 TNMkE40nTzVbyvWoynyDFYFsBMgXYX04AmiYgjg==
X-Google-Smtp-Source: AGHT+IFZRZdQbGM2QETddK5D0uyMD/72MA62SJVOkINntmHAAG+laCqSBzT6nP80eg1XWB0b95YnHzUb7Sadw2HRYNM=
X-Received: by 2002:a25:ac42:0:b0:de4:2bc:c715 with SMTP id
 r2-20020a25ac42000000b00de402bcc715mr4797289ybd.8.1713344036496; Wed, 17 Apr
 2024 01:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
 <20240405000707.2670063-3-horenchuang@bytedance.com>
 <20240405150244.00004b49@Huawei.com>
 <CAKPbEqpGM_nR+LKbsoFTviBZaKUKYqJ3zbJp9EOCJAGvuPy6aQ@mail.gmail.com>
 <20240409171204.00001710@Huawei.com>
 <CAKPbEqry55fc51hQ8oUC8so=PD_wWoJMEPiR-eq03BgB5q86Yw@mail.gmail.com>
 <20240410175114.00001e1e@Huawei.com>
In-Reply-To: <20240410175114.00001e1e@Huawei.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Wed, 17 Apr 2024 01:53:45 -0700
Message-ID: <CAKPbEqqbTdyGy_q4P9QeB0x6qzx_XZvnP-oED=A1VW407JabDw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v11 2/2] memory tier: create CPUless memory
 tiers after obtaining HMAT info
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Huang, Ying" <ying.huang@intel.com>,
 Gregory Price <gourry.memverge@gmail.com>, 
 aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org, 
 john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
 Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
 Alistair Popple <apopple@nvidia.com>,
 Srinivasulu Thanneeru <sthanneeru@micron.com>, 
 SeongJae Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linux Memory Management List <linux-mm@kvack.org>,
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, 
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org, 
 Hao Xiang <hao.xiang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=horenchuang@bytedance.com; helo=mail-yb1-xb33.google.com
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

On Wed, Apr 10, 2024 at 9:51=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 9 Apr 2024 12:02:31 -0700
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
>
> > Hi Jonathan,
> >
> > On Tue, Apr 9, 2024 at 9:12=E2=80=AFAM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Fri, 5 Apr 2024 15:43:47 -0700
> > > "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
> > >
> > > > On Fri, Apr 5, 2024 at 7:03=E2=80=AFAM Jonathan Cameron
> > > > <Jonathan.Cameron@huawei.com> wrote:
> > > > >
> > > > > On Fri,  5 Apr 2024 00:07:06 +0000
> > > > > "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
> > > > >
> > > > > > The current implementation treats emulated memory devices, such=
 as
> > > > > > CXL1.1 type3 memory, as normal DRAM when they are emulated as n=
ormal memory
> > > > > > (E820_TYPE_RAM). However, these emulated devices have different
> > > > > > characteristics than traditional DRAM, making it important to
> > > > > > distinguish them. Thus, we modify the tiered memory initializat=
ion process
> > > > > > to introduce a delay specifically for CPUless NUMA nodes. This =
delay
> > > > > > ensures that the memory tier initialization for these nodes is =
deferred
> > > > > > until HMAT information is obtained during the boot process. Fin=
ally,
> > > > > > demotion tables are recalculated at the end.
> > > > > >
> > > > > > * late_initcall(memory_tier_late_init);
> > > > > > Some device drivers may have initialized memory tiers between
> > > > > > `memory_tier_init()` and `memory_tier_late_init()`, potentially=
 bringing
> > > > > > online memory nodes and configuring memory tiers. They should b=
e excluded
> > > > > > in the late init.
> > > > > >
> > > > > > * Handle cases where there is no HMAT when creating memory tier=
s
> > > > > > There is a scenario where a CPUless node does not provide HMAT =
information.
> > > > > > If no HMAT is specified, it falls back to using the default DRA=
M tier.
> > > > > >
> > > > > > * Introduce another new lock `default_dram_perf_lock` for adist=
 calculation
> > > > > > In the current implementation, iterating through CPUlist nodes =
requires
> > > > > > holding the `memory_tier_lock`. However, `mt_calc_adistance()` =
will end up
> > > > > > trying to acquire the same lock, leading to a potential deadloc=
k.
> > > > > > Therefore, we propose introducing a standalone `default_dram_pe=
rf_lock` to
> > > > > > protect `default_dram_perf_*`. This approach not only avoids de=
adlock
> > > > > > but also prevents holding a large lock simultaneously.
> > > > > >
> > > > > > * Upgrade `set_node_memory_tier` to support additional cases, i=
ncluding
> > > > > >   default DRAM, late CPUless, and hot-plugged initializations.
> > > > > > To cover hot-plugged memory nodes, `mt_calc_adistance()` and
> > > > > > `mt_find_alloc_memory_type()` are moved into `set_node_memory_t=
ier()` to
> > > > > > handle cases where memtype is not initialized and where HMAT in=
formation is
> > > > > > available.
> > > > > >
> > > > > > * Introduce `default_memory_types` for those memory types that =
are not
> > > > > >   initialized by device drivers.
> > > > > > Because late initialized memory and default DRAM memory need to=
 be managed,
> > > > > > a default memory type is created for storing all memory types t=
hat are
> > > > > > not initialized by device drivers and as a fallback.
> > > > > >
> > > > > > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > > > > > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > > > > > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > > > >
> > > > > Hi - one remaining question. Why can't we delay init for all node=
s
> > > > > to either drivers or your fallback late_initcall code.
> > > > > It would be nice to reduce possible code paths.
> > > >
> > > > I try not to change too much of the existing code structure in
> > > > this patchset.
> > > >
> > > > To me, postponing/moving all memory tier registrations to
> > > > late_initcall() is another possible action item for the next patchs=
et.
> > > >
> > > > After tier_mem(), hmat_init() is called, which requires registering
> > > > `default_dram_type` info. This is when `default_dram_type` is neede=
d.
> > > > However, it is indeed possible to postpone the latter part,
> > > > set_node_memory_tier(), to `late_init(). So, memory_tier_init() can
> > > > indeed be split into two parts, and the latter part can be moved to
> > > > late_initcall() to be processed together.
> > > >
> > > > Doing this all memory-type drivers have to call late_initcall() to
> > > > register a memory tier. I=E2=80=99m not sure how many they are?
> > > >
> > > > What do you guys think?
> > >
> > > Gut feeling - if you are going to move it for some cases, move it for
> > > all of them.  Then we only have to test once ;)
> > >
> > > J
> >
> > Thank you for your reminder! I agree~ That's why I'm considering
> > changing them in the next patchset because of the amount of changes.
> > And also, this patchset already contains too many things.
>
> Makes sense.  (Interestingly we are reaching the same conclusion
> for the thread that motivated suggesting bringing them all together
> in the first place!)
>
> Get things work in a clean fashion, then consider moving everything to
> happen at the same time to simplify testing etc.
Hi Jonathan,

Thank you and I will do! Could you please take another look and see if
there are any further changes needed for this patchset? If everything
looks good to you, could you please also provide a 'Reviewed-by' for
this patch?

Per discussion, I'm going to prepare another patchset "memory tier
initialization path optimization" and will send it out once ready.

>
> Jonathan

--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

