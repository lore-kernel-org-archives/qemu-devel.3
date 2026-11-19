Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7140606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K7M5hHM0;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Em8n/KHq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU795-0004Ka-JF; Thu, 19 Nov 2026 13:46:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xU790-0004KB-9r
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:46:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xU78y-0005bx-Dc
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795113958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EkHv0KZK1T/FWXZb25a7sQnpYe9WG3gE5es4+HqArws=;
 b=K7M5hHM0m2CrRoWeGFYw1YUJOc0tRJ6UPF8t/vdZB9zNhppL74uHdpGhpFNuEkaJggGZUu
 g6mLtGNCiu5keM169k9kr3FKLKppu0PVZe9RJVnjhfPJP4fG/8/U45FBdcnLkeiO769gi5
 xvVbponyGsl8dArFo6H/FSsdm/4Cd3k=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-0Ds-lDeYNuyj-hC6o9Gyhw-1; Thu, 19 Nov 2026 13:45:57 -0500
X-MC-Unique: 0Ds-lDeYNuyj-hC6o9Gyhw-1
X-Mimecast-MFC-AGG-ID: 0Ds-lDeYNuyj-hC6o9Gyhw_1795113956
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-946038e22f5so19459985a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 10:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795113956; x=1795718756; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EkHv0KZK1T/FWXZb25a7sQnpYe9WG3gE5es4+HqArws=;
 b=Em8n/KHqgYWrpc/Z04S9aK9iTIgDBTDxKNdrq97iMisGZp/sO+2UV6TKSbP9yL+D6K
 oGDLJFC/Prrtz/o7+klV+qDNKoC1WefXoL1e/UpvWo0s0EkFQy3PnIuCnH3HKWF6WJfc
 B/16TM0wIvY2FGsN+Ek9mObZgC7TxcXORBUgv4aZlSHGkNsslaMAmF8qr7/7zB6qf6j9
 PMg+nosvBHKu8SLINpuh05tyGOUsqWi5Fir7sRHWS2fVG4BfPI+e9MbW96SrfkaFVchM
 eApO+Sbohi3dKeBYFyOOwGKLpvELvNvNwLeMF9MwrVaKmKggWZlPoD80Nzyjw0VOMA15
 cOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795113956; x=1795718756;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EkHv0KZK1T/FWXZb25a7sQnpYe9WG3gE5es4+HqArws=;
 b=2ZjN9uHZeSEsy/cZTrGXYiJKBKfswhhuduoixMyqtW17Be5YI0er/9uzYg+UrRPI9i
 6UN1hkQMjwRtbKUCbxzHElHMChH7igo8kKz9H0lwZ45rVnd+6kv97d0UYifBrAMLUHc7
 ZbQuat6D2y9m4PFuxE3jfc7DJVRz2R+MRNPlY4UrRtdmZQVlvjoagRnN1NDhfcyG8o90
 m/1ta9d72oMjKTHTellVhiQbcLZDIzbRIR26Ry2I1Fs6iw/SnC9o9kq8z6RV//j/t+fC
 L6Bf5EnrWbFydJ1N92w4HW4oPGRsJijBFusqXgxV5VvyyK+4eICrYm2vlZM8W06WHNYs
 RWaw==
X-Gm-Message-State: APuU4Z/N6zAMu5NWDAUNJkznjmSIKmpdDz3V/5F7tw6LXROMgGj/OKCY
 8QNhY6md9ZBksf13T6Egi+Z4uLy10Iz96xyl+IEq/p0M0cWbHhDLcbH/yzbcRlVormmTwZeJfJY
 c/6qDVEx1kj1RcQcKEJ3OIcj55ruibS0QiS16MSb4koVXD0qI3vXuFrdW
X-Gm-Gg: AYBFou3rXUSoY3G4KWXNpHxolMBwDStAbdXhhevpz2RdviOHCB1N+8M0LzepGr+3sQP
 OANYSeolzZLmSZpyvyvdzFtiZLspQ++D5o+yWEa9Q+agdR1eHxACp6vUmufV/zcTdWVjON3Vd7n
 nefMqELjUT31NVOq31153tjVA0oR/64OHI/jXThv9xNV6zsEjhNV17fY2QucMT3HcBTjKNX4cLg
 OrRY9CVjfszk4KqvYM5MpJGi2Ks2xeeGB5xPDeKKHKCvPe+SQiOpFVKzHQ+vJjVnKiPxCyAuqI4
 5cchVuCW9djz5h9LNAGfkU1j2hcC7YgWYyPCEE5oUd21FQbPA5jfVLntmaRf4RZo/eg2VuVUJAO
 YKGejEUgGwNpvkJhzqeaqp8bC7Eh0iCXJLwbanw7frK+l
X-Received: by 2002:a05:620a:1a0e:b0:93c:a40d:e3cf with SMTP id
 af79cd13be357-949ba828099mr99403885a.1.1795113956283; 
 Thu, 19 Nov 2026 10:45:56 -0800 (PST)
X-Received: by 2002:a05:620a:1a0e:b0:93c:a40d:e3cf with SMTP id
 af79cd13be357-949ba828099mr99397485a.1.1795113955628; 
 Thu, 19 Nov 2026 10:45:55 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb0354a9sm30992885a.5.2026.11.19.10.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 10:45:55 -0800 (PST)
Date: Thu, 19 Nov 2026 13:45:54 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Fabiano Rosas <farosas@suse.de>
Subject: Re: VMSTATE_VALIDATE failures on outbound migration
Message-ID: <av9D4pVMM989xNcE@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <CAFEAcA-iAdTGc0M4ZV5LYXscVVj2oEr7FN+Ac=oBo2_oxuygzg@mail.gmail.com>
 <av8k8oiG8lRh5bVI@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA_8EAke9-dk-2HfkQ5BJyuODtcSK+DUcmYKRSKgEf=Wnw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_8EAke9-dk-2HfkQ5BJyuODtcSK+DUcmYKRSKgEf=Wnw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 04:48:31PM +0000, Peter Maydell wrote:
> On Thu, 19 Nov 2026 at 16:34, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Nov 19, 2026 at 03:37:43PM +0000, Peter Maydell wrote:
> > > I'm going to fix the bug which is causing this specific failure,
> > > but is it intentional/the right thing that we assert here rather
> > > than simply aborting the attempted migration ?
> > >
> > > I can kind of see it either way:
> > >  * we can't do this migration, but the VM itself might be fine
> > >    and we might as well continue to let it run
> > >  * failing a VMSTATE_VALIDATE field check on an outbound migration
> > >    indicates that the device is in some unexpected state (i.e. one
> > >    which we would reject on input), which might also be a problem
> > >    for continued running of the VM; so err on the side of caution
> > >    and treat it like an assertion failure, killing the VM
> > >
> > > I note that there is no documentation at all of VMSTATE_VALIDATE
> > > unless you count the one-liner comment
> > > "/* Validate state using a boolean predicate. */"
> > >
> > > and we use it in exactly seven places. This is the kind of
> > > amount of usage where I feel like we should either be using it
> > > a lot more, or not at all :-)
> >
> > I agree.
> >
> > I think assertion isn't good here, it's just that it was since 2014 and
> > maybe we start to hit it only today?
> 
> We only hit it I think if either the validate function is buggy
> or the device code is buggy. So we only hit it now because we made
> a change in target/arm that exposed/created a bug.
> 
> > One reason being that as you said the assert behavior isn't described and
> > not sure if it's always wanted, and also some corrupted device state may
> > not always imply the VM is fully doomed.
> >
> > The other thing is I believe we have proper way to report errors now with
> > either pre_save_errp() or post_load_errp().  We should use them.
> 
> The thing that occurred to me is that post_load_errp() only happens
> after migration of the whole struct is done, and there might be
> cases where you want to validate a field because you're about to
> use it in a following field; for instance vmstate_hpet does:
> 
>         VMSTATE_UINT8(num_timers_save, HPETState),
>         VMSTATE_VALIDATE("num_timers must match", hpet_validate_num_timers),
>         VMSTATE_STRUCT_VARRAY_UINT8(timer, HPETState, num_timers_save, 0,
>                                     vmstate_hpet_timer, HPETTimer),
> 
> and the hpet_validate_num_timers() function is checking the
> incoming num_timers_save before we rely on it as the count
> in the following VMSTATE_STRUCT_VARRAY_UINT8(). The use in
> pcie_aer.c is also like that. However the uses in
> target/arm/machine.c and hw/gpio/zaurus.c are just checking
> incoming data for sanity and could be done in a post_load
> hook instead.

IMO we have multiple way to achieve the same thing without VALIDATE and
without VMS_MUST_EXIST (where I plan to remove both).

Firstly, just to say if we follow the security update on migration, we
trust migration stream so we should have zero concern assuming the
num_timers will be trusted and correct in the first place..

If we don't trust it like above we could have used num_timers in loading
the VMSDs with vmstate_hpet_timer, rather than num_timers_save, which will
guarantee no buffer overflow possible, then post_load_errp() checks the two
integers finally.  Should be functionally the same but safer.

Or, if we really cared, we can also make the UINT8 num_timers_save to be a
STRUCT instead, holding only the UINT8 with a post_load_errp(), that'll do
almost exactly what the existing code do too.

Thanks,

-- 
Peter Xu


