Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B710C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 13:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPj50-00014u-48; Fri, 05 Jul 2024 09:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sPj4u-00014Z-EW
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 09:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sPj4r-0005p7-Jl
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 09:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720186454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/H7LV2t1nlR7wGQ2dayilpeheOsH+8O2COgkGb2uveY=;
 b=OmW261+BKyzEXI8tYywps/gqh5XX7zW1ppUbqMtMgcpQFJZY1VWxX1S1Qd9m0SDVT1vq89
 7RCL80851PrOzgVsnvfkMw6u6S70aQ7OeRuEVMcCR1yGBSRWpy7x0vtzcQU8eHNiARgRGE
 zovrm1EfHPHDlJpCXVy9msj6fqUrq7o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-vJx3gmwANTuRfP8Eh6u7Pw-1; Fri, 05 Jul 2024 09:34:13 -0400
X-MC-Unique: vJx3gmwANTuRfP8Eh6u7Pw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6b5e99c06efso1697776d6.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 06:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720186453; x=1720791253;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/H7LV2t1nlR7wGQ2dayilpeheOsH+8O2COgkGb2uveY=;
 b=MDR+RMNxGjnAAimA9JUSvAUGTUPZmeD4cR8uX4ecZlE06ySb6DHVYBIiTh1sCubOpZ
 XA1FHBupjITOqj9l7+8WQQ3oivobrkgMqOMjNMMES/Iu4eJ9G5mkjspS8OhcZcGgdaIw
 vmTwz+soo7Brkfg2ESAmFs0Fl17LeR67mUCMpNcoXeygMcyHYIc0oYby5kwbsulecdia
 cW0YxEEK60D1Y7CWiEsyLnkm6ESMJDK70EOUNZbymwSx7pu+otwbfy5iDqkV2KRJwk1p
 iGDvWhm6c8tm8B8s2Q0SJIqmz5F1Ml14JT7bSHIvjZFGPXg165VYrpQActUBalJTniLw
 OzvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdoq4hfxcPvZAc0Tu1Pa7Kg4m0YOyXaFHp50idwyq98/vsYuxJHIBwL0hrkX3ecREfF7EAvUdMKJufsMPADzL35jH6j7c=
X-Gm-Message-State: AOJu0Yw3fdC0Ngojy+R1nNU7W6x+f2ckqL2Pd8WDf7eMrqF86XWeyi1o
 zcxt7kHlROlmJ4nM1ANSzMIthkt72clK+ZxaQ4TfDBTfohp7JE49U5vHI8SsIsmS17UphmIQsZd
 rTrDOcFP68yYe8MlPczMjXo2aUZOJKs1lFp6cXUn+B7zPksQHf8Cr
X-Received: by 2002:a05:620a:4088:b0:79c:103b:af39 with SMTP id
 af79cd13be357-79eee298dfamr483438885a.7.1720186452846; 
 Fri, 05 Jul 2024 06:34:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED9Vl0Ibg455++/iYEsDJIgpQBDhl/jwSD4X2i7uF3SmWSG7btg9aRm7U85KIUJ84FGExUBQ==
X-Received: by 2002:a05:620a:4088:b0:79c:103b:af39 with SMTP id
 af79cd13be357-79eee298dfamr483436385a.7.1720186452375; 
 Fri, 05 Jul 2024 06:34:12 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79d820acc1bsm606892985a.47.2024.07.05.06.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 06:34:11 -0700 (PDT)
Date: Fri, 5 Jul 2024 09:34:09 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Wang, Lei4" <lei4.wang@intel.com>, Jiri Denemark <jdenemar@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v1] target/i386: kvm: Block migration when enfore_cpuid
 is set to false
Message-ID: <Zof2UVtNa4yPDRyF@x1n>
References: <20240703144912.130988-1-wei.w.wang@intel.com>
 <ZoWSdR1IOQ0iIxZC@x1n>
 <DS0PR11MB6373852F86A43ED9E1AFC7B7DCDE2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZobGx3KORPLQfBNC@x1n>
 <DS0PR11MB6373F79B4D34DBF5DAB416F2DCDF2@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS0PR11MB6373F79B4D34DBF5DAB416F2DCDF2@DS0PR11MB6373.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 05, 2024 at 10:22:23AM +0000, Wang, Wei W wrote:
> On Thursday, July 4, 2024 11:59 PM, Peter Xu wrote:
> > On Thu, Jul 04, 2024 at 03:10:27PM +0000, Wang, Wei W wrote:
> > > > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c index
> > > > > 4c2e6f3a71..7db4fe4ead 100644
> > > > > --- a/target/i386/cpu.c
> > > > > +++ b/target/i386/cpu.c
> > > > > @@ -8258,7 +8258,7 @@ static Property x86_cpu_properties[] = {
> > > > >      DEFINE_PROP_UINT32("hv-version-id-snumber", X86CPU,
> > > > > hyperv_ver_id_sn, 0),
> > > > >
> > > > >      DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
> > > > > -    DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
> > > > > +    DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, true),
> > > >
> > > > I assume in many cases people can still properly migrate when the
> > > > hosts are similar or identical, so maybe we at least want the old
> > > > machine types keep working (by introducing a machine compat property)?
> > >
> > > You meant keeping "enforce_cpuid=false" for old machine types (e.g. before
> > 9.1)?
> > > This will make them non-migratable with this patch, but they were
> > > migratable (by
> > > default) as "migratable" wasn't enforced by "enforce_cpuid". Should we
> > > keep them being migratable by default (e.g. enforce_cpuid=true) as well?
> > 
> > Ah, this is trickier than I thought..
> > 
> > The issue is if we make them silently switch to enforce_cpuid=true on old
> > machines, there's chance they start to fail boot, am I right?
> 
> Right for newly launched guests, regardless of whether they are new or old
> machine types, they will fail to boot when the host cannot afford the features
> for the configured vCPU models. This is expected, and actually part of the
> intentions of this patch.
> 
> When there is a need to boot a guest with reduced features, users need to
> explicitly add "enforce_cpuid=false", which marks the new booted guest as
> non-migratable, or a _better_ way, to identify the unsupported features from 
> the host first, and then get it booted with "-cpu CpuModel,-A,-B", this can make
> it migratable with those known reduced features, and the destination guest is
> required to use the same QEMU commands (as usual) to reduce the same set
> of features as the source and get a enforced check by "enforce_cpuid".
> 
> For live update of QEMU for existing running guests (as you mentioned
> below), the impact is only on the running guests that have had features reduced
> from vCPU models (at the time of their original launch). For this case, the
> recommended way to update them to the new QEMU is also to explicitly identify
> the reduced features and update them with "-cpu CpuModel,-A,-B".
> 
> The rationale behind this is that the features reduced from the guest needs to
> be explicitly determined and controllable. In terms of live migration, the
> destination is ensured to have the same set of reduced features as the source
> side.
> 
> > 
> >     if (cpu->enforce_cpuid && x86_cpu_have_filtered_features(cpu)) {
> >         error_setg(&local_err,
> >                    accel_uses_host_cpuid() ?
> >                        "Host doesn't support requested features" :
> >                        "TCG doesn't support requested features");
> >         goto out;
> >     }
> > 
> > I suppose we still need to keep all the old worlds running all fine without
> > breaking them when people do an QEMU upgrade.  It needs to work both on
> > booting fine, and on allowing to migrate.
> > 
> > So maybe we actually need two things?
> > 
> >   - One patch introduce forbit_migration_if_cpuid_mismatch property, when
> >     set, block migration if not enforced, otherwise it should still allow
> >     migration even if enforce_cpud=fales.  It should default to on, but off
> >     on old machines.
> > 
> >   - One patch change default value of enforce_cpuid to on, but turn it off
> >     on old machines.
> > 
> > Does that look right?
> 
> I think this can work. Not sure what you would think about the above explanations.
> If agree, then probably we don’t need to add the extra complexity.
> 
> Also, the above two things seem to impede the upgrade for guests with older machine
> types to incorporate this enforcement. I think the primary goal of live updating to a
> newer QEMU version is to benefit from the enhancements offered by the new QEMU.
> So it seems more beneficial to bring old guests under such enforcements, given
> that this doesn't break functionalities that the guest is running. The only
> requirement for this is to upgrade using more explicit QEMU commands
> (i.e., -cpu CpuModel,-A,-B) when needed.

What you said makes sense.  It's just that the concern still exists, and
I'm not sure whether that'll be too much to ask for a customer.

Also, see this commit:

commit 15e41345906d29a319cc9cdf566347bf79134d24
Author: Eduardo Habkost <ehabkost@redhat.com>
Date:   Wed Aug 26 13:25:44 2015 -0300

    target-i386: Enable "check" mode by default
    
    Current default behavior of QEMU is to silently disable features that
    are not supported by the host when a CPU model is requested in the
    command-line. This means that in addition to risking breaking guest ABI
    by default, we are silent about it.
    
    I would like to enable "enforce" by default, but this can easily break
    existing production systems because of the way libvirt makes assumptions
    about CPU models today (this will change in the future, once QEMU
    provide a proper interface for checking if a CPU model is runnable).
    
    But there's no reason we should be silent about it. So, change
    target-i386 to enable "check" mode by default so at least we have some
    warning printed to stderr (and hopefully logged somewhere) when QEMU
    disables a feature that is not supported by the host system.

    Reviewed-by: Igor Mammedov <imammedo@redhat.com>
    Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

I don't think I know what's the "libvirt assumptions" mentioned, and how it
changed as of today.  I had a vague memory Libvirt constantly set off on
some of the relevant flags last time Jiri explained some cpuid issues to
me; maybe it's "check" not "enforce"? It would be great if Jiri or Dan can
comment here.

Copy Igor too from the commit.

Thanks,

-- 
Peter Xu


