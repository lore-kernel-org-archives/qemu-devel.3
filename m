Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DA0C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 14:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM7YT-0003PS-3I; Tue, 25 Jun 2024 10:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sM7YR-0003PI-C0
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sM7YP-0003DH-AG
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719327229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=psFvaDsfNpT2kdAw5hKL25zir7DuUtiaws6a8L4uLW4=;
 b=bPoPF/QfY4U9NGviw1U9+Fd/ZGWnMOmktJI92bC65IFLGPMbp5UbD+WyIs+UcRjAQ5p3IK
 ZtbYw5dDUU5DN1jgYwRfeXCmUG0DZV2HV0F5OUPvrv8uLZzT3W3dTMBjaXaU21GFXFFzmU
 MxMGeBhoZhUr7fAzEMZEepmEqxSKWSk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-XSrXJUFkNuOgqZ6hPZmOXA-1; Tue, 25 Jun 2024 10:53:46 -0400
X-MC-Unique: XSrXJUFkNuOgqZ6hPZmOXA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b511d8ac63so2497576d6.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 07:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719327226; x=1719932026;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=psFvaDsfNpT2kdAw5hKL25zir7DuUtiaws6a8L4uLW4=;
 b=v7fPaTdI8LzuCNCP0jKlaYx8PbnWS50ld1k2uFBQRjtsriCdzOyBddB/vVxNkF6Hbf
 JJ8ikX292vs93FFY4iNCwsaidLTzb8JYpIx5U+fflzoujPsMGhCNnn4U3wGyreFWhusB
 ujI6gKZ9/I28b0GCIhpjR29BUhjQsKsFB9rE1HxeGNKvQ5fQ2xBEoXiheMOcHBl6iwyw
 JkIjwMStG45YGBvooBEBWsVH5Q4GSx3Kedjb4FXMnD7I+xQUiDM2WruzlyYtUzWx+AKM
 FS+pTF8dsSwglf5Lw9Zso1eV3BupZx46WfZBHT8PNkeq0eGX5lZ5fF+FavQcSzoSVBrZ
 NI0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmxBWi/0P6WyJH+afUa9iakbYtjTL/WyxYLcUuR5nFdh35qLOo+kmizQJizQg1ZostdXku0sjpKxBAcdtPnFbG2xlACM0=
X-Gm-Message-State: AOJu0YztZdq3OcOJN+EEn4dzMYh+aZ5TOc3B4ke1XUIILjJVVOFoLVys
 Zem7Kz33k9SUmZfGrSTTCpdaVbdU10bJma8ldD9/CKHAcW9W5ADF/pQIDcG1ujutlTi2XWz/z8o
 QOqRI8cK1ad5tgYuqKpClmbigQPh6NtIV61XWYE0yUqOq+AF9LDan
X-Received: by 2002:ad4:5aea:0:b0:6b5:3c38:5238 with SMTP id
 6a1803df08f44-6b53c3853abmr99239446d6.5.1719327225745; 
 Tue, 25 Jun 2024 07:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGji939cBSHtYprPjkUCVKqRpEfYM9MNfwJZqC8B9BLHq0LlurOsLpHtxsWM5tRbWVI0QeGEA==
X-Received: by 2002:ad4:5aea:0:b0:6b5:3c38:5238 with SMTP id
 6a1803df08f44-6b53c3853abmr99239226d6.5.1719327225257; 
 Tue, 25 Jun 2024 07:53:45 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b526616900sm39178476d6.66.2024.06.25.07.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 07:53:44 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:53:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-devel@nongnu.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com
Subject: Re: [PATCH RFC 2/2] migration: abort on destination if switchover
 limit exceeded
Message-ID: <ZnrZ9W6WpvmDBpgv@x1n>
References: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
 <20240621143221.198784-3-elena.ufimtseva@oracle.com>
 <ZnnL42_iDip3hfUh@x1n>
 <9eeea2a9-b3ef-4791-94de-fb06ad2bd9b4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9eeea2a9-b3ef-4791-94de-fb06ad2bd9b4@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

On Tue, Jun 25, 2024 at 12:38:50PM +0100, Joao Martins wrote:
> On 24/06/2024 20:41, Peter Xu wrote:
> > On Fri, Jun 21, 2024 at 07:32:21AM -0700, Elena Ufimtseva wrote:
> >> @@ -2659,6 +2698,18 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis,
>  >>      if (!check_section_footer(f, se)) {
> >>          return -EINVAL;
> >> @@ -2714,6 +2765,19 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis,
> >>                                      se->instance_id, end_ts - start_ts);
> >>      }
> >>  
> >> +    if (migrate_switchover_abort() && type == QEMU_VM_SECTION_END &&
> >> +        mis->downtime_start) {
> >> +        mis->downtime_now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >> +        uint64_t dst_downtime = mis->downtime_now - mis->downtime_start;
> >> +        if (mis->src_downtime + dst_downtime >= mis->abort_limit) {
> >> +            error_report("Shutdown destination migration, migration abort_limit (%lu ms)"
> >> +                          "was reached.", mis->abort_limit);
> >> +            trace_qemu_loadvm_downtime_abort(mis->abort_limit, dst_downtime,
> >> +                                             mis->src_downtime);
> >> +            return -EINVAL;
> >> +        }
> >> +    }
> > 
> > So this traps both iteration and non-iteration phase.  What if the downtime
> > was caused by after these, or unluckily at the last non-iterator device
> > state?
> > 
> > After trying to think about it, I figured this is not easy to do right.
> > Also, I start to doubt whether it's definitely a good idea on having this
> > in the first place.
> > 
> > Firstly, I'm wondering how we should treat this new feature
> > v.s. downtime_limit.  It's about how the user should set both.
> > 
> > If this is about "cancel migration if downtime more than xxx",
> > then.. AFAICT that's exactly what downtime_limit was "designed" to be..
> > It's just that downtime_limit says the other way round, as: "don't
> > switchover if the downtime will be more than xxx".
> > 
> > Then, if the user has option to set both these parameters, what would be
> > the right thing to do?  Shouldn't they simply always set both parameters to
> > be the same value already?  But if so, what's the point on having two?
> > 
> > This caused me to think whether the 2nd parameter is needed at all, instead
> > whether we should simply make downtime_limit more accurate, so that it will
> > start to account more things than before.  It won't be accurate, but the
> > same case here: making this new feature "accurate" can also be very hard.
> > 
> 
> The way I think about it is that current downtime-limit captures nicely the data
> part as the only calculations it cares about is how much outstanding data it
> sends to the destination (be it VF device state or RAM). This second parameter
> captures what is *not* related to data, i.e. costs of hypervisor quiescing the
> VM or added latencies in hypervisor *in addition* to sending outstanding data to
> destination.
> 
> If we were to merge this all into a single parameter (aka downtime-limit) we are
> possibility artificially increasing the downtime thanks to relaxing the
> oustanding data part, as opposed to trying to capture the switchover cost (hence
> the name the parameter) that can't be reflected in the former equation.
> 
> So I feel like this needs two parameters whereby this second new parameter
> covers 'switchover cost' (hence the name) with current migration algorithm.

Then the question is how should we suggest the user to specify these two
parameters.

The cover letter used:

  migrate_set_parameter downtime-limit 300
  migrate_set_parameter switchover-limit 10

But it does look like a testing sample only and not valid in real world
setup, as logically the new limit should be larger than the old one,
afaict.  If the new limit is larger, how larger should it be?

So far I can understand how it works intenrally, but even with that I don't
know how I should set this parameter, e.g., when downtime_limit used to be
300ms, I'd say 500ms could be a suitable value, but is it?  In that case,
perhaps the 500ms is the "real" limit that I don't want a VM to be halted
for more than 500ms, but in that case the user should have already setup
downtime_limit to 500ms.

I also don't know how should an user understand all these details and
figure out how to set these.  Note that currently we definitely allow the
user to specify downtime_limit and it's so far understandable, even though
the user may assume that contains the whole blackout phase (that's also
what we wish it can achieve..), rather than the fact that it only takes
ram/vfio/... reported remaining data into account v.s. the bandwidth.

Maybe we could consider introducing the parameters/caps in some other form,
so that we can keep the downtime_limit to be "the total downtime", instead
of a new definition of downtime.  E.g., it's at least not fair indeed to
take the whole "downtime_limit" for data transfers, so maybe some ratio
parameter can be introduced to say how much portion of that downtime can be
used for data transfer, and then it might be ok to work with the new cap
introduced so that when total downtime is over the limit it will abort the
migration (but without a new "max downtime" definition which might be
confusing).

Said that, I also wonder whether you have thought about improving
downtime_limit itself.  It'll be definitely better if we simply don't
switchover at all if that won't make it.  IOW, I wonder whether there can
be case where user specifies these parameters, migration simply keeps
switching over and keep aborting, requiring a retry.  That's pretty
unwanted.  We may simply doesn't allow that switchover to happen at all.

Thanks,

-- 
Peter Xu


