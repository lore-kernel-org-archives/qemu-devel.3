Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9317EC3271E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 15:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPOro-0002cv-M0; Thu, 04 Jul 2024 11:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sPOrb-0002aT-TI
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sPOrV-0004yU-Ne
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720108748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cNJC9YkzsIoYupo2wb4nu+BVtsZ3vk289bF2kXRFtpA=;
 b=VelVMkAYQbLm31RfV/Y1HFEe7SDocka39EKlg586/z86YD5gQiJHqKvK5RRKxgsVGMrD58
 nPYgTtwce0fsz3yYCXghMp60xIQHN3KgGoGvGIZehiSPum/csED8y41ggpfuzcBkP4lCgW
 Se/tusDlOS/5JPqUUC4YK6jC6vbQ94s=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-n2fIKrq-P2CZNNip418Veg-1; Thu, 04 Jul 2024 11:59:07 -0400
X-MC-Unique: n2fIKrq-P2CZNNip418Veg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-44671e02749so1725641cf.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 08:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720108746; x=1720713546;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cNJC9YkzsIoYupo2wb4nu+BVtsZ3vk289bF2kXRFtpA=;
 b=a+9IH4ZQF0ViwxkRUWlBZmf4LKlI6BmBEvSDnqk8i2hBrTSzxlq3IPdil2Lqh1lhCI
 sMUvIUTHarBJBcNPWBIxCjC6raIM5UrJVcyz5+YLeeFiSzdPBrJdffiJn18dTkIK0is6
 7wOMRRs0rKpWNCjs3zkct1GUt83IV0KX4l1Jp7LZ1u37LMCGQ44UwkaafdhGGYOG/97g
 OOxvwds+DPMMZTaOj5ch9yvRUq8WZqvwgXxYT+SC3a/lyh2wUvBUs2Cpez0bz3RacyJg
 eE20CVIKIPrwCt/J4VBcUDYqKYB7s4eXnjR9XtbFcic3j52gFJTbSl9u3D7qKCel7kqb
 QzDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJRTxZDzAav2WXEzJDHklv6h5ACvSjb1DiVU6ouXIVgYckBJWRfjM9V13xv1k+9QvYUTXaDw5ut1FRQfkazIcPdTxOWoc=
X-Gm-Message-State: AOJu0YyWO2i6aPB+xikz0xuJ52vNayhhT0lX9xfIoczdaW76Qj0uieNU
 ML3b3Olq5g+URq0rPRGNyI1qUvhV000OMxVzIYFfGssuIo+FGL1/V4nv0hDJxmU5LLbhk5ubiW+
 w2gQ8xJ8FXRApmp0KPjRlYMjRFVLNsb9PaRGUmwtfZrG5ciADcfnr
X-Received: by 2002:a05:620a:4088:b0:79c:103b:af39 with SMTP id
 af79cd13be357-79eee298dfamr216466985a.7.1720108746524; 
 Thu, 04 Jul 2024 08:59:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsY+afl4Zz/yT9YrN9buSnNkBZZeLC39uC9q24yz2c4vfSoyXhyyMsKdvnN12ljvhmBlmK3w==
X-Received: by 2002:a05:620a:4088:b0:79c:103b:af39 with SMTP id
 af79cd13be357-79eee298dfamr216465685a.7.1720108746179; 
 Thu, 04 Jul 2024 08:59:06 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79d6925ecbesm686095985a.24.2024.07.04.08.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 08:59:05 -0700 (PDT)
Date: Thu, 4 Jul 2024 11:59:03 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Wang, Lei4" <lei4.wang@intel.com>, Jiri Denemark <jdenemar@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH v1] target/i386: kvm: Block migration when enfore_cpuid
 is set to false
Message-ID: <ZobGx3KORPLQfBNC@x1n>
References: <20240703144912.130988-1-wei.w.wang@intel.com>
 <ZoWSdR1IOQ0iIxZC@x1n>
 <DS0PR11MB6373852F86A43ED9E1AFC7B7DCDE2@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DS0PR11MB6373852F86A43ED9E1AFC7B7DCDE2@DS0PR11MB6373.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Jul 04, 2024 at 03:10:27PM +0000, Wang, Wei W wrote:
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c index
> > > 4c2e6f3a71..7db4fe4ead 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -8258,7 +8258,7 @@ static Property x86_cpu_properties[] = {
> > >      DEFINE_PROP_UINT32("hv-version-id-snumber", X86CPU,
> > > hyperv_ver_id_sn, 0),
> > >
> > >      DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
> > > -    DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
> > > +    DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, true),
> > 
> > I assume in many cases people can still properly migrate when the hosts are
> > similar or identical, so maybe we at least want the old machine types keep
> > working (by introducing a machine compat property)?
> 
> You meant keeping "enforce_cpuid=false" for old machine types (e.g. before 9.1)?
> This will make them non-migratable with this patch, but they were migratable (by
> default) as "migratable" wasn't enforced by "enforce_cpuid". Should we keep them
> being migratable by default (e.g. enforce_cpuid=true) as well?

Ah, this is trickier than I thought..

The issue is if we make them silently switch to enforce_cpuid=true on old
machines, there's chance they start to fail boot, am I right?

    if (cpu->enforce_cpuid && x86_cpu_have_filtered_features(cpu)) {
        error_setg(&local_err,
                   accel_uses_host_cpuid() ?
                       "Host doesn't support requested features" :
                       "TCG doesn't support requested features");
        goto out;
    }

I suppose we still need to keep all the old worlds running all fine without
breaking them when people do an QEMU upgrade.  It needs to work both on
booting fine, and on allowing to migrate.

So maybe we actually need two things?

  - One patch introduce forbit_migration_if_cpuid_mismatch property, when
    set, block migration if not enforced, otherwise it should still allow
    migration even if enforce_cpud=fales.  It should default to on, but off
    on old machines.

  - One patch change default value of enforce_cpuid to on, but turn it off
    on old machines.

Does that look right?

Thanks,

-- 
Peter Xu


