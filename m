Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F028606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ThpYmLEF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQobS-0006Q3-PP; Tue, 10 Nov 2026 11:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xQoaw-00068K-K7
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:21:16 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xQoas-00048S-KV
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:21:13 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b65d69f5c2so2935993a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 08:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794327667; x=1794932467; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kII7F4ctUkYgoQt59X+qcLkhPHev2NgMkYmPxI5mmz8=;
 b=ThpYmLEFn/LHGJUGse+a+YJYmqNMib3Cdv0ITbC7pbAbvBYon93XuEGzSO384PHn1e
 Ev7+MXAeK3khTTH5PVxW+ZIztVjhSTEVbDLgECGg7HiO+QhZR3q64H+DFUNzGH7L2vF+
 GekL5GxXrSDRVhs0kSwBDR8K4kJ34JWuF/LvVmH5mFsAcrdG/IZ/Wo4MowJ3dZzujSaq
 +WBNS2sITVspNO9ZG3qrARg8sJfXrbO1lR1NR1lrACVeoXfTOd5H47IQhgdCAl0lSYK6
 nWOkSDaGWNuWgZUSYMIASkXf6NghcH/fXVHTeobQHFW1ik+iuFUSaK5o2VDBXGZwt6T6
 g3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794327667; x=1794932467;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kII7F4ctUkYgoQt59X+qcLkhPHev2NgMkYmPxI5mmz8=;
 b=uzKF9szUyQ2jEq51nhX9l5Q4Qu8ikSXqNPMVFyydkmb/dmW03Oh8I8XgFmcohgARoo
 DHUHdGBKFEYLl8LpkKmPQULgQTjVit6H4yJIi+8TG4aRl06QydMHtNKH4PK3I84z37hR
 acuFUK0dlG7UbrZOroWD3h3p+32A9Y+3qi61awCgcRlXiGaQunK8ueYQokH28L2GdTDi
 QTsioTQ0OmHuQUmktkP/8gz4WfNrofOLLt9H7Z0TSl8KNxwAsygyNhHiPaM2YZknq6Vz
 qCdA20kp19FS3vqM1XDwRCXTEm9S8yxpfeyt8vbaU4H24xOmQxuRbCB+DWDtUBkq+2oi
 lJiw==
X-Gm-Message-State: APuU4Z+I74N8sKiocT9AaD1lS+ooMlSFqqWXqvRvkfan3ubMr0YZnJ74
 FAW1M2LH+7eWhWe/qpAQsaDBvujMWd4+aTdpCUNfG2V/D6d91NPiVNLevaslMnBQdto=
X-Gm-Gg: AYBFou1d/y+XjCMEvixuAQvdHXfi6QDOe/otMkhsaYgUIO562qQOsIuszTnmJNvwdHg
 d1q0KY3L5uBHDAGPg+D5ov8r9Fjq4sc5j98rZewZ3/vmu9Slk5KzDqPa1mbjzHJYqWAoYGi5+aB
 20YNembleqZagxOm+DPuOB3v9Qw2AwTXISSB/Cz5CRNpDdWnIYNYoZ+SmqT6Y3w6H8hgtZGjZx/
 cUHtJ9Ri18UDwMawb03baVmO8pwcYFkYvtm0RDrR40ki4ch9zwY6rnUDrDthKQd2pgW3s7yYU4h
 WZeoJYK2P0QvWvGljvRFPzMqndBPVT4oYswsyCeeEZze0v5oPTpn+jfJi7tGsuFgrbcCCElEsw+
 gKG4H+6YLW17F46p/W/r2e/7KF0NyJnhqopbJ/gPu0bh8BITeRmwgCQxxWwQVrFlrIC+OLM1vr9
 pWwm3htrMSjKCs5E4o8uDyWvJNdiXOq2VK0CuwR4g1k7chOtXZqVLHdxSP+AfHVIPLD1N/re7e+
 3EjjyOU0XmPC7IFdeItaqgYfHK/jLW1OJQTj9nHMYMz41Jm7ytl8Xi3El3sT/BduVTyz9MFmPdN
 LIAWrvtQeVJ0s5O4ugaxksLGpY9oB584HzOi8dfB3+r77w4LJ4NKsQ==
X-Received: by 2002:aa7:d58c:0:b0:6b5:875a:c2a0 with SMTP id
 4fb4d7f45d1cf-6b756aeabeemr1808887a12.24.1794327667180; 
 Tue, 10 Nov 2026 08:21:07 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:aa96:7f3b:af27:16e8])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b75790caffsm1283679a12.32.2026.11.10.08.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 08:21:05 -0800 (PST)
Date: Tue, 10 Nov 2026 16:21:03 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Gustavo Romero <gromero@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] hw/arm/smmuv3: define Root registers
Message-ID: <avNEb_ScXZ-A6uDF@linaro.org>
References: <20261016-jmac-smmu-root-registers-v1-0-e78e8879d347@linaro.org>
 <20261016-jmac-smmu-root-registers-v1-1-e78e8879d347@linaro.org>
 <isr4ew27ud6xmfrk444mdme2rqdtd5wgpbgjblgaavmzhpyppt@hhmxurpxh766>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <isr4ew27ud6xmfrk444mdme2rqdtd5wgpbgjblgaavmzhpyppt@hhmxurpxh766>
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ed1-x533.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 11:20:56PM +0100, Gustavo Romero wrote:
> > +/*
> > + * Check we are from the Root PA space to read from or write to the
> > + * SMMU Root register area.
> > + */
> > +static bool smmu_check_root_access(SMMUv3State *s, MemTxAttrs attrs,
> > +                                     hwaddr offset, bool is_read)
> 
> Indentation is off ---------------------^
> 
> I think it makes sense also to call this function smmu_root_access(), but no
> strong preference here.

Noted indentation fault. I would prefer to have a verb in the function name,
but similarly have no strong preferences on it.

> 
> 
> > +{
> > +    /* Check if the access is from Root PA */
> > +    if (!(attrs.space == ARMSS_Root)) {
> 
> Could we use the comparison operator (!=) instead of the logical one here? I
> think it's clearer than a negation.
> 
Good point, that is clearer.

> > +    case A_ROOT_GPT_BASE2:
> > +        *data = s->root.gpt_base2;
> > +        return MEMTX_OK;
> > +    case A_ROOT_GPCBW:
> > +        /* Optional, not implemented. Present if ROOT_IDR0.GPTS == 0 */
> 
>                                          GPTS == 1 here? -----^
Correct, thank you.

> > @@ -411,6 +411,28 @@ REG32(EVENTQ_IRQ_CFG2,     0xbc)
> >  
> >  #define A_IDREGS           0xfd0
> >  
> > +#define SMMU_ROOT_REG_START 0x20000
> 
> The base address for the Root Control Page is implementation defined, hence
> 0x20000 is not always true and depends on the machine/platform. We could add
> property to set it externaly but it would also complicate unnecessarily the
> offset math. So I think it's ok to follow what FVP is doing. Please just add a
> note saying it's impl. defined so it might require a tweak in the
> future.
> 
> I think we can follow TF-A code here and rename this macro. So how about
> renaming it to:
> 
> SMMUV3_ROOT_REG_OFFSET ?
> 
I'll add another comment and yes, that name change makes sense.

...

> > +typedef struct SMMUv3RootRegBank {
> 
> How about naming this struct simply SMMUv3Root?

I don't mind renaming it to something other than 'Bank' to avoid conflicts
with another meaning of register bank (e.g. the actually banked registers),
for example SMMUv3RootControlPage would be fine. If it's just to save space
on punch cards, I'm less keen, but will happily follow code conventions.

> 
> 
> > +    uint32_t idr0;
> > +    uint32_t iidr;
> > +    uint32_t cr0;
> > +    uint32_t cr0ack;
> > +    uint64_t gpt_base;
> > +    uint64_t gpt_base_cfg;
> > +    uint64_t gpf_far;
> > +    uint64_t gpt_cfg_far;
> > +    uint64_t gpt_base2;
> 
> Looking at ARM IHI 0070 H.a Non-confidential spec I don't see
> 
> 0x0068 SMMU_ROOT_GPT_BASE_UPDATE 32-bit, R/W and
> 0x0070 SMMU_ROOT_GPCBW 64-bit, R/W
> 
> as Optional like I see SMMU_ROOT_TLBI and SMMU_ROOT_TLBI_CTRL.
> 
> Should they be declared as well?

GPT_BASE_UPDATE is an unusual case; it has side effects when writing hence
I was reluctant to include it as a normal config register, however, it
shouldn't do any harm to add it - users will just see the 'update' bit stick
as 1 forever if they write it.

SMMU_ROOT_GPCBW is RES0 unless ROOT_IDR0.GPTS == 1 as noted above, and we
don't define that bit at the moment, so making storage for it seemed
unnecessary.

> 
> 
> > +} SMMUv3RootRegBank;
> > +
> >  struct SMMUv3State {
> >      SMMUState     smmu_state;
> >  
> > @@ -80,6 +92,7 @@ struct SMMUv3State {
> >      OnOffAuto cmdqv;
> >  
> >      Notifier machine_done;
> > +    SMMUv3RootRegBank root;
> >  };
> >  
> >  typedef enum {
> > 
> > -- 
> > 2.43.0
> > 
> > 
> 
> General comments:
> 
> smmu_read_mmio_root
> smmu_write_mmio_root 
> 
> I think we can drop the "mmio_" for both functions. It's ok to have "mmio_" in
> the "trace_smmuv3_write_mmio" trace function because afaics it has a generic use,
> so its use is not tied to any bank.
Yep, fine by me.

> 
> 
> I think we're missing to reset some registers in smmuv3_reset()? Like:
> 
> s->root.cr0 = 0;
> s->root.cr0ack = 0;
> s->root.gpf_far = 0;
> s->root.gpt_cfg_far = 0;

Good point, we are missing those, thanks.

Thanks for the review!

Jim

