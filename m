Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5275FCEE358
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 20:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLSeo-0006S2-Jk; Tue, 18 Nov 2025 15:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1vLSem-0006Q8-Oy
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 15:50:32 -0500
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1vLSel-0005mU-0Z
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 15:50:32 -0500
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-4331709968fso22788055ab.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 12:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1763499029; x=1764103829; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MvvQcPaXbrQ32ZzYnn+d/9VYMwCtYgnid3bfy7U/bFM=;
 b=VXyRnwLdDVoDN7JukX2oVvoHI8tbW4Vr48W0FBcOy5MxdLxZ3LmJSkrTbryVrO3e/L
 uZSLya8vRDRHfR8gW9KM24aA3jFaDA9VnB4FXa6Si8L42GUI4ez6FT91ZsUQSGCaVKnx
 lvbVmZRmzbwfUwitxLCMUiS+QxV81BzQq2HRA60O/Zzeze61ikP4uSDzYSLIJD7XGNeM
 alffvOkMVRI428upd+jqX2yLxyVt/YQh+4xuFVx6LngV1cla7DqgirXuJVVEapVc7EWx
 gx9Mxe9ILH5EdqpRIuMdOJvDWpY9A9k4NV1g5JXK78BRKh1yJypqcEPmvM+o2OS3qy69
 484A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763499029; x=1764103829;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvvQcPaXbrQ32ZzYnn+d/9VYMwCtYgnid3bfy7U/bFM=;
 b=HaInd0SuxGR/d1FkypFUASXJP8LtG66v2jhgmaEhd8FfLqiyki5VItRQzC7IbwuaVh
 IR4AiwiJM9nOPmx9FsZHngDLFR2y0bBWn5+gmeBMIYJudAgskigDM2A+HGuFu1CIHyL4
 k9VuCf9PKhE9XnKzWEfZRoJb5IygXYhUC/uoOTmEdfnlnVNiHInNcHjPhTqbP8/0VpE7
 DO+P08ylN8k4rm7hMYIwSGf4cMcOpoSNIjoNhpMDz3Q6Kx+7x8PuoMx+JqpgH+WFpcwm
 LVZ7Z0CJELKN0dfJiOHld/DcZ/Ge7iXKQd+GQhTqGC0ZtEvGC1LSE/V2qr2Fz0Uw7E4y
 E9IQ==
X-Gm-Message-State: AOJu0YzLd4rv8qU/Zwjstisrtopv9DcYv/6ICR8RdAunzlIOEoEDDzUt
 +fVNeW8DzNB83iJGHEynWKJzeQakTvIOoaI1PyHjWvnz3iiW/tlu/5YGM9V4fghg7Hs=
X-Gm-Gg: ASbGncsbumE4mG8T/fgzW2rvtsVnKW1amcwbhfjOJfGEQfFiw8Zi84TkdyUP/5/lCNh
 sMo2aqBMWjgXksG/Qt7LGmoVMN5awA2Tz8divTnFGZQpgZwOUsSktHKdMB3nB/H/3pq1qptOWMO
 3Pyxvh9+sb3Qhmy0pZoN4Qbu+pTYZGjduqHPptHVDVywPPqjUGHp5fqWQ33UF2wGFjsp0hLAv25
 XddwnLcv0WSFRqQvmJahHFWY0+WRulCtkHFJDSlt8w4dDgEmCO3qQk62RXXOwUzdYiVZQv8mD8z
 DJwtQKU1KTbLUkpcFbxOA8Uaf2WVcWLT28n/8IsTntTb6R2Yp4nrCc7o1RWdHpVYyfDGH7axXUd
 O5Svvpr38UhVUfbc0Oa2etngQAC/8P5NKvACaLFg5lQJHBtl8lFkBG/gY4IFhj4MC5p10lAOQO5
 ahulK03WHORKgW
X-Google-Smtp-Source: AGHT+IFDXzPaM7SEC4rT0TNdQLaPiXqrdXAlE2nq1quEsGlMYNlbq7yKVxItdbJi3A9/dN5JN3kOIw==
X-Received: by 2002:a05:6e02:2183:b0:433:29c3:c512 with SMTP id
 e9e14a558f8ab-4359fe883a7mr1406115ab.21.1763499028699; 
 Tue, 18 Nov 2025 12:50:28 -0800 (PST)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-434838c24a1sm85912795ab.15.2025.11.18.12.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 12:50:27 -0800 (PST)
Date: Tue, 18 Nov 2025 14:50:26 -0600
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 Fei Wu <wu.fei9@sanechips.com.cn>
Subject: Re: [PATCH v4 3/5] hw/riscv: experimental server platform reference
 machine
Message-ID: <20251118-93789449fcd7e0189113a949@orel>
References: <20251111182944.2895892-1-dbarboza@ventanamicro.com>
 <20251111182944.2895892-4-dbarboza@ventanamicro.com>
 <20251111-a6e8ae9a0d6809ba0e62ba2e@orel>
 <265ca0e7-b331-4158-8e11-8f31921cfcc0@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <265ca0e7-b331-4158-8e11-8f31921cfcc0@ventanamicro.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=ajones@ventanamicro.com; helo=mail-il1-x133.google.com
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

On Tue, Nov 18, 2025 at 05:15:54PM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 11/11/25 8:36 PM, Andrew Jones wrote:
> > On Tue, Nov 11, 2025 at 03:29:42PM -0300, Daniel Henrique Barboza wrote:
> > > From: Fei Wu <wu.fei9@sanechips.com.cn>
> > ...
> > > +static char *rvsp_ref_get_aia_guests(Object *obj, Error **errp)
> > > +{
> > > +    RVSPMachineState *s = RVSP_REF_MACHINE(obj);
> > > +    char val[32];
> > > +
> > > +    sprintf(val, "%d", s->aia_guests);
> > > +    return g_strdup(val);
> > > +}
> > > +
> > > +static void rvsp_ref_set_aia_guests(Object *obj, const char *val, Error **errp)
> > > +{
> > > +    RVSPMachineState *s = RVSP_REF_MACHINE(obj);
> > > +
> > > +    s->aia_guests = atoi(val);
> > > +    if (s->aia_guests < 0 || s->aia_guests > RVSP_IRQCHIP_MAX_GUESTS) {
> > 
> > The minimum is 5 for the server platform, so we should enforce that. Also
> > I suggest we bump RVSP_IRQCHIP_MAX_GUESTS since it's only 7 right now.
> > 
> > > +        error_setg(errp, "Invalid number of AIA IMSIC guests");
> > > +        error_append_hint(errp, "Valid values be between 0 and %d.\n",
> > > +                          RVSP_IRQCHIP_MAX_GUESTS);
> > > +    }
> > > +}
> > > +
> > > +static void rvsp_ref_machine_class_init(ObjectClass *oc, const void *data)
> > > +{
> > > +    char str[128];
> > > +    MachineClass *mc = MACHINE_CLASS(oc);
> > > +    static const char * const valid_cpu_types[] = {
> > > +        TYPE_RISCV_CPU_RVSP_REF,
> > > +    };
> > > +
> > > +    mc->desc = "RISC-V Server SoC Reference board (EXPERIMENTAL)";
> > 
> > We could (and probably should) version this machine type from the get go.
> > If we do that, then we could simply give it a version 0.9, which would
> > match the current spec. When the spec is ratified and this model is
> > complete, then it can be bumped to 1.0. Going that route would allow us
> > to avoid the EXPERIMENTAL "flag".
> 
> There has been some discussions offline on this and I'll bring them here.
> 
> A minor point: it was suggested to rename the board to 'rvserver' instead
> of 'rvsp-ref'. I like this idea mostly because I keep misspelling rvsp-ref
> as rsvp-ref.

I do like the '-ref' suffix though.

> 
> As for the "version this machine type": in this case is different with what we do
> with other QEMU machines. They have a new version for every QEMU release, e.g.
> ARM's newest virt board is virt-10.2, in the next QEMU release it will be virt-11.0
> and so on. We wouldn't do the same thing here - 'versioning' in this case is name
> the board in a way that makes reference to the spec it implements. So this current
> emulation would be named 'rvsp-ref-0.9', with an alias 'rvsp-ref' pointing to it.
> 
> Changing the emulation to comply with spec version 1.0 will create a rvsp-ref-1.0
> board while keeping rvsp-ref-0.9 as is. Usually QEMU does that by using compat flags
> that changes the behavior of the board, and we'll probably go this route.

Yes, as long as we point out what the version numbers mean somewhere, e.g.
in the machine description, then I guess people will get it.

I'm not sure I want a 0.9 board to live on after a ratified 1.0 is
released, though. So maybe an 'experimental'  board makes more sense
if we need to call it that in order to reserve the right to delete it.

> 
> One thing worth considering is that we can't just version stamp the board, we need to
> do the same with the CPU. So we would have a rvsp-ref-cpu-0.9, rvsp-ref-cpu-1.0 and
> an alias to point to the newest available emulation.

ack

> 
> Also note that we're not 0.9 compliant either since we're missing sdext. So unless
> we're willing to name this current board as rvsp-ref-0.9-beta or something like that,
> maybe it's a good idea to postpone this work until we have 'sdext' implemented.

Yes, let's prioritize sdext so we can match the current spec (which is
unlikely to change much before ratification) before we merge the reference
board at all.

Thanks,
drew

