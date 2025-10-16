Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21E4CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 19:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9TfZ-0004kG-GE; Thu, 16 Oct 2025 15:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9TfW-0004k6-Tt
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 15:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9TfN-0000EJ-61
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 15:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760642973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sh/c3gjMFU4DOOCnIRSgipo34r+ZHERWoZkUM+nsVa4=;
 b=TIrlXqcKpjv3iWdWNzzApCWQNLTx7YwV2bhMHhB9dRDdhRiHK+YMPSr9DZ2o3Xet47i/7c
 nbybRQn2kH+s0B4cjwvs+B9fFWWKShaF1b2r2Qs7vXe4a7e0sSAqkxUf67ULowBEEABjTx
 cQP1rwsWeWkyXIH5ZeWdyEaopxgTXq8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-90oGzNapOMmXt7bxbzllqA-1; Thu, 16 Oct 2025 15:29:31 -0400
X-MC-Unique: 90oGzNapOMmXt7bxbzllqA-1
X-Mimecast-MFC-AGG-ID: 90oGzNapOMmXt7bxbzllqA_1760642971
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-89090e340bfso44858085a.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 12:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760642971; x=1761247771;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sh/c3gjMFU4DOOCnIRSgipo34r+ZHERWoZkUM+nsVa4=;
 b=RhHEr0Wna1XFaoAwzfgcFcizVg0jmhHNnVOFP4ebECKlvRYDD4WZp0sK6UfFRsZe0k
 j1+wGOU4QOxhcm/VBf1zxjXLgHn8oKTRn1VSHk0O9GWs5XaZmOhMzFMtZiXuikmKzHf7
 L755QsjG92NiZAPvagagxENkpW5zRx9ppNNnF8g+u5l5gbRWeUPE2ygJRonUSPKPleIj
 PeiWLFaoOti3w2fYdxkZR1Klmi2VxftMbBFF4RgOO+num+iAQGiron2o4Tml+5NLJBOu
 CpA1kcMV/9AZL0QRy9606+vUkEqrO/cx/u5U0EKokgcxcNoa8nhvhQlfGKhvr6viCb0n
 i+fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR54IuLLbRIq49Qwv/1T0YG948fjK1tVlVEvDHmcQS1YUn9c0rTYh0WQiHZSRwL8uliZ4jZUO0KUNr@nongnu.org
X-Gm-Message-State: AOJu0YyjcLI7m5zkDLQ+fpBoLBOVnMeB9xTVEyjBpj9C+JFcjGhVLm7L
 Eufmh9Jqm+jJa9fbKWWyN7OvUbVekpHQbsDE+N/mL7l3fu/7yil/i58fWVhn0NeA4+Dk9KlGNrd
 2M36vDpsvuQ77kABEQeM2N4AWXVnIhIGbWlLiSWxjeIXmZ/7o3UB8wTSh
X-Gm-Gg: ASbGncvgPjz8S6xTL4n2fnlLUbvD2Br5ZuXVWCG1Fn6roi2WPaDntjGDfF1/gms2In1
 D2pHEwPEetR0zTXCLKocXj4bdvXZXkFBlsPR1PmI1f4ks6hdeJmAlcTpuiYZPvRVCNVxDRjkKNL
 nlJPTauG35vv04tmgDr1AD8Cte1RIpIG1zTaJji/3MO6IKtktVkAyg85VaP8JVnfBhQt4vvV18e
 VCJmfq6JZOgfFfft5Mjym6FumzLIvmXGWLqZLwmKb0qIp8jF5cTu/V/FK9k0KHriSNxAEBtFhkM
 rOveuqYnPbPvrqA789TLQF6PjfV/C0oi9rVW/0LAY3uH4iDegeoo2KJzrSlnrt8fWRs=
X-Received: by 2002:ac8:7e89:0:b0:4e8:8bf2:dfdd with SMTP id
 d75a77b69052e-4e89d1fb99cmr17430781cf.7.1760642971009; 
 Thu, 16 Oct 2025 12:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+CUxk1hP0JrBUE1IbJphV/1Pg0e4Cp477seTbFUTuRjOOR90AMPcLjcQTee8XJiW2EaPr1g==
X-Received: by 2002:ac8:7e89:0:b0:4e8:8bf2:dfdd with SMTP id
 d75a77b69052e-4e89d1fb99cmr17430451cf.7.1760642970379; 
 Thu, 16 Oct 2025 12:29:30 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e891a4a98csm27906831cf.31.2025.10.16.12.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 12:29:29 -0700 (PDT)
Date: Thu, 16 Oct 2025 15:29:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 mst@redhat.com, jasowang@redhat.com, farosas@suse.de,
 sw@weilnetz.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 michael.roth@amd.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
Message-ID: <aPFHl3VWV0pCmzd1@x1.local>
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
 <20251015132136.1083972-17-vsementsov@yandex-team.ru>
 <aO_ll4Lf0bq6vgdm@x1.local>
 <3b9f1da4-6264-45d4-ade1-a6273cc6fa1e@yandex-team.ru>
 <aO_--QWDJO7iOhR4@x1.local>
 <8c575b3a-7d1f-446d-8f6d-4b2e4b851731@yandex-team.ru>
 <aPCtkB-GvFNuqlHn@redhat.com>
 <29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru>
 <aPE8Oo5D3oesB7sV@x1.local> <aPE-vmyg1mLDO4pf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPE-vmyg1mLDO4pf@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 16, 2025 at 07:51:42PM +0100, Daniel P. Berrangé wrote:
> On Thu, Oct 16, 2025 at 02:40:58PM -0400, Peter Xu wrote:
> > On Thu, Oct 16, 2025 at 12:23:35PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On 16.10.25 11:32, Daniel P. Berrangé wrote:
> > > > On Thu, Oct 16, 2025 at 12:02:45AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > 1. Remote migration: we can't reuse backends (files, sockets, host devices), as
> > > > > we are moving to another host. So, we don't enable "backend-transfer". We don't
> > > > > transfer the backend, we have to initialize new backend on another host.
> > > > > 
> > > > > 2. Local migration to update QEMU, with minimal freeze-time and minimal
> > > > > extra actions: use "backend-transfer", exactly to keep the backends
> > > > > (vhost-user-server, TAP device in kernel, in-kernel vfio device state, etc)
> > > > > as is.
> > > > > 
> > > > > 3. Local migration, but we want to reconfigure some backend, or switch
> > > > > to another backend. We disable "backend-transfer" for one device.
> > > > 
> > > > This implies that you're changing 'backend-transfer' against the
> > > > device at time of each migration.
> > > > 
> > > > This takes us back to the situation we've had historically where the
> > > > behaviour of migration depends on global properties the mgmt app has
> > > > set prior to the 'migrate' command being run. We've just tried to get
> > > > away from that model by passing everything as parameters to the
> > > > migrate command, so I'm loathe to see us invent a new way to have
> > > > global state properties changing migration behaviour.
> > > > 
> > > > This 'backend-transfer' device property is not really a device property,
> > > > it is an indirect parameter to the 'migrate' command.
> > 
> > I was not seeing it like that.
> > 
> > I was treating per-device parameter to be a flag showing whether the device
> > is capable of passing over FDs, which is more like a device attribute.
> > 
> > Those things (after set by machine type) should never change, and the only
> > thing to be changed is the global "backend-transfer" boolean that can be
> > set in the "migrate" QMP command, and should be decided by the admin when
> > one wants to initiate the migration process.
> > 
> > > > 
> > > > Ergo, if we need the ability to selectively migrate the backend state
> > > > of individal devices, then instead of a property on the device, we
> > > > should pass a list of device IDs as a parameter to the migrate
> > > > command in QMP.
> > 
> > I doubt whether we would really need that in reality.
> > 
> > Likely the admin should only worry about whether setting the global
> > "backend-transfer", the admin may not even need to know which device, and
> > how many devices, will be beneficial to this feature enabled.
> > 
> > It just says, "we're doing local migration and via unix sockets, so
> > whatever devices can try to reuse their backends if possible".
> 
> An individual device can only use backend transfer if both the old and
> new QEMU agree that it can be done. At the time we start the origin
> QEMU we know which set of devices are capable of doing an outgoing
> backend transfer, but we don't know what set of devices are capable
> of doing an incoming backend transfer.
> 
> If we don't have a per-device toggle at time of migration, then we
> have to assume that the target QEMU can always support at least the
> same set of incoming backends as the src QEMU outgoing backend. This
> feels like a potentially risky assumption.

When using machine properties, these things should already be set by the
machine types.

E.g. if this is a new QEMU with an old machine type, we should have this
per-device property set to OFF forever when booting the VM, and should keep
it like that after any rounds of migrations.  Because any VM using the old
machine type _might_ be migrated back to an older QEMU that won't support
it.  So IIUC that strictly follows how we use versioned machine types.

What Vladimir mentioned previously would be something very special, but
indeed when there's no machine type versioning we may need to toggle this
before each migration.  However since upstream is following the machine
type properties way of doing this since N years ago, do we need to worry
about that?

> 
> Another scenario is where you are doing a localhost migration as a
> mechanism to let you change a device backend. In that case you'll
> want to do a backend transfer of all devices, except the one that
> you want to change.

Right, this might be a real need if it exists.  Said that, it's so special
that I'm not sure whether the admin can easily migrate with global
backend-transfer to OFF in this rare case.

In general, I would prefer avoiding to introduce any form of list of
devices into the migration system if ever possible.  I agree if we must
introduce that it should at least be a list of IDs rather than adhoc array
of strings.  However I still want to see whether we can completely avoid
it.

Thanks,

-- 
Peter Xu


