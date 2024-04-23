Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58651C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOV2-0005ZN-P4; Tue, 23 Apr 2024 18:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOV1-0005ZF-P5
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOUz-0003A1-QZ
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713910824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZouwIY8z9KojD+IupKSFyIF3Zpov/alvLYnLE3kqRE=;
 b=gRrh22XJquJY9fY1U2We5zd8xApbDnhdHW+img0dj8fiBBViJJsUGsMBgwhfP1nT12Yk7U
 bjuSmUQSoQv7rqexyqlPHG2KgDzavysLFxuKdqB70JbPpjqU0O+/mEnEOYkNU4SFOhwgFA
 skzcvyJtMqJpvzO2YHzk3Rsbzm423T8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-n-2CwOMPNzaG3caTmi8yGg-1; Tue, 23 Apr 2024 18:20:23 -0400
X-MC-Unique: n-2CwOMPNzaG3caTmi8yGg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6a01116b273so18920726d6.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713910823; x=1714515623;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NZouwIY8z9KojD+IupKSFyIF3Zpov/alvLYnLE3kqRE=;
 b=BhPkMw0AOxRc3nowBKVxLV0xk2CekwjSWCC6KneMwm+B6UBhHF/13J5iI91EbY58JD
 ljr6uw8XvtCTU1Bu/NJZbrAJPpOsr5Io13U+FVzpeDU4tNikb+c2O/2/VhknCdV58GSz
 MgvwrhX3W4ocg/MNg1gLHBEn/p9gSx9FHDvFjFbipQ63UkdsHqTEsABAi4+mBGoINyjj
 IY01OGKdggHXZMrOD5pXA9YxQp8APAhA/IH1F68N09JsDlqttDlInS1M4QoLONW8l1pE
 qRuGCuPDpA+5beXSIfr9Bq9OQBrsYkI69I2nDuEmWDx92M4NtcRRarfpx3VkCO95j6z/
 LOTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz1ZCz9sj1fdKUMGeOVRG6vzlWb8uS4PrQtzM+ax41MW5RECSAaSHvZSb2qE1eP25GtZ5RWBEavoTSyIYNZz3pM7XSmAw=
X-Gm-Message-State: AOJu0YxkldM/OJlIS03nJgp4rrXZzW5ovMuucYKGi6XUGaNeNVuat6eC
 2zPU2t91ALgqtSUPa3eGL17aKpiLdas0JwoIDF7SFDdUvbWBH96ejsrxr8eI0cucFvyTa89HLrv
 wJH8hmBMt70aIHzFLVkt2lSa4INvaYTjPABlegmWOT1/YT1MqoabM
X-Received: by 2002:ad4:5ecf:0:b0:6a0:6ffa:c306 with SMTP id
 jm15-20020ad45ecf000000b006a06ffac306mr724406qvb.6.1713910822630; 
 Tue, 23 Apr 2024 15:20:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpw5HKHVeRU8UjyBbLF3xMa1ResAAtYiT4JHQoU6jv0q4061fhJwp5PWVkywKI7Q8fMh0utA==
X-Received: by 2002:ad4:5ecf:0:b0:6a0:6ffa:c306 with SMTP id
 jm15-20020ad45ecf000000b006a06ffac306mr724373qvb.6.1713910821955; 
 Tue, 23 Apr 2024 15:20:21 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 n12-20020a0c8c0c000000b006a050fa22cfsm3047403qvb.145.2024.04.23.15.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:20:19 -0700 (PDT)
Date: Tue, 23 Apr 2024 18:20:16 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 00/26] =?utf-8?Q?Multifd_?= =?utf-8?B?8J+UgA==?=
 device state transfer support with VFIO consumer
Message-ID: <Zig0IPofMCpJdGsn@x1n>
References: <Zh-KF72Fe9oV6tfT@redhat.com>
 <c0b1dbb1-d353-4832-af90-96895b2129fc@maciej.szmigiero.name>
 <Zh_6W8u3H4FmGS49@redhat.com>
 <71ede5c8-857c-418b-9e37-b8d343ddfa06@maciej.szmigiero.name>
 <ZiD4aLSre6qubuHr@redhat.com>
 <aebcd78e-b8b6-44db-b2be-0bbd5acccf3f@maciej.szmigiero.name>
 <ZiF8aWVfW7kPuOtn@x1n> <ZiJCSZvsekaO8dzO@redhat.com>
 <ZiKOTkgEIKo-wj5N@x1n>
 <d7d59001-0800-4073-9def-08327e904b7b@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7d59001-0800-4073-9def-08327e904b7b@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

On Tue, Apr 23, 2024 at 06:15:35PM +0200, Maciej S. Szmigiero wrote:
> On 19.04.2024 17:31, Peter Xu wrote:
> > On Fri, Apr 19, 2024 at 11:07:21AM +0100, Daniel P. Berrangé wrote:
> > > On Thu, Apr 18, 2024 at 04:02:49PM -0400, Peter Xu wrote:
> > > > On Thu, Apr 18, 2024 at 08:14:15PM +0200, Maciej S. Szmigiero wrote:
> > > > > I think one of the reasons for these results is that mixed (RAM + device
> > > > > state) multifd channels participate in the RAM sync process
> > > > > (MULTIFD_FLAG_SYNC) whereas device state dedicated channels don't.
> > > > 
> > > > Firstly, I'm wondering whether we can have better names for these new
> > > > hooks.  Currently (only comment on the async* stuff):
> > > > 
> > > >    - complete_precopy_async
> > > >    - complete_precopy
> > > >    - complete_precopy_async_wait
> > > > 
> > > > But perhaps better:
> > > > 
> > > >    - complete_precopy_begin
> > > >    - complete_precopy
> > > >    - complete_precopy_end
> > > > 
> > > > ?
> > > > 
> > > > As I don't see why the device must do something with async in such hook.
> > > > To me it's more like you're splitting one process into multiple, then
> > > > begin/end sounds more generic.
> > > > 
> > > > Then, if with that in mind, IIUC we can already split ram_save_complete()
> > > > into >1 phases too. For example, I would be curious whether the performance
> > > > will go back to normal if we offloading multifd_send_sync_main() into the
> > > > complete_precopy_end(), because we really only need one shot of that, and I
> > > > am quite surprised it already greatly affects VFIO dumping its own things.
> > > > 
> > > > I would even ask one step further as what Dan was asking: have you thought
> > > > about dumping VFIO states via multifd even during iterations?  Would that
> > > > help even more than this series (which IIUC only helps during the blackout
> > > > phase)?
> > > 
> > > To dump during RAM iteration, the VFIO device will need to have
> > > dirty tracking and iterate on its state, because the guest CPUs
> > > will still be running potentially changing VFIO state. That seems
> > > impractical in the general case.
> > 
> > We already do such interations in vfio_save_iterate()?
> > 
> > My understanding is the recent VFIO work is based on the fact that the VFIO
> > device can track device state changes more or less (besides being able to
> > save/load full states).  E.g. I still remember in our QE tests some old
> > devices report much more dirty pages than expected during the iterations
> > when we were looking into such issue that a huge amount of dirty pages
> > reported.  But newer models seem to have fixed that and report much less.
> > 
> > That issue was about GPU not NICs, though, and IIUC a major portion of such
> > tracking used to be for GPU vRAMs.  So maybe I was mixing up these, and
> > maybe they work differently.
> 
> The device which this series was developed against (Mellanox ConnectX-7)
> is already transferring its live state before the VM gets stopped (via
> save_live_iterate SaveVMHandler).
> 
> It's just that in addition to the live state it has more than 400 MiB
> of state that cannot be transferred while the VM is still running.
> And that fact hurts a lot with respect to the migration downtime.
> 
> AFAIK it's a very similar story for (some) GPUs.

So during iteration phase VFIO cannot yet leverage the multifd channels
when with this series, am I right?

Is it possible to extend that use case too?

Thanks,

-- 
Peter Xu


