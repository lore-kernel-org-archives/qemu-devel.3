Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A39C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 23:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmMON-0000nN-DZ; Mon, 18 Mar 2024 19:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmMOL-0000mo-2m
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 19:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmMOJ-0005HV-2W
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 19:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710804457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tz4rZrOAnV5BFMENb1hPCzeQZvusSgbLFaXI22NiMok=;
 b=aESUtmj5XEqGmNe3qM06hXWpKvI6lLXykPs6+Q3Zyu3jj+KNXgaiMTwb0e7CeDsgCf3uBP
 5a+KsP19pkuFiR/Hv9Usu3kOLHRU40urv0Ssdp+/xxb/izLmz8kY6n8JFgFxL0R89vpD8a
 FNsMVRYG2DktEe2QlYeiec0Gc73sAaQ=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-tepcVpu5NhyM1xSa_dNG9w-1; Mon, 18 Mar 2024 19:27:35 -0400
X-MC-Unique: tepcVpu5NhyM1xSa_dNG9w-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-4d453adea04so208736e0c.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 16:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710804455; x=1711409255;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tz4rZrOAnV5BFMENb1hPCzeQZvusSgbLFaXI22NiMok=;
 b=TROjh0R8CURc3KwnrD4RPy2bNCzNAv8IrJ2HVus/KSMkisYyFthk0ZNzlQaNm9oL5O
 +KXYmK6QHMQxxFHUMmMZDMBhVG2IGHizmQoHQRCZ6w/hu9hhtQD1b/aXMdl1guyCgTBY
 UVt0Fqd7hF4DYkPMTT0W+dMFDkjvkqBFS0tM517jY0VTWDxSNXnYA6G8oh74RnGSFcRA
 eM+Os9nbeAUeNZDNSdH5cS/e0OdubGmr7gUkPoZqcSm6P0YwOL5LzbUHAR1gIiZX4+6G
 mDZYE2appzN25GI7N1K79Swhbkj1/OA6my6+CKJKXDw+z5G7w5Vue5xOCL8Fl+JmqS8w
 9T6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcGFYiBqMVmVunpxgYjaY/q0D0V1i4d4Ma5Fb5lmu6tvBr7fNOWSLdthrRIXKgRP2+640oB1bylmvjzgc5L4nn+d12Ris=
X-Gm-Message-State: AOJu0YzLdrS039trDuxSkYh9q7CenLPPUiXQV7rC8MznLHS+XxTu7SZT
 qP2uOpGGkSLzsA3oa3hCR6hbjIWcATD7PXUAqqqGrQlfLBzQtPQKvDUWKdUez4OpY4m2/kJUXmw
 4HM5NcQgumc8QWXTXQcRBVNxb7lyQOzRfJXySWygEA+QO6bsLUaIU
X-Received: by 2002:a05:6122:e61:b0:4c9:225d:cece with SMTP id
 bj33-20020a0561220e6100b004c9225dcecemr559317vkb.1.1710804454812; 
 Mon, 18 Mar 2024 16:27:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3YjTxaejo4QCs/6mgxulopr7jY2WamEDJcVnMAb7FFiutcU8GMmJdxRZUmTTVkTNnWA0NDw==
X-Received: by 2002:a05:6122:e61:b0:4c9:225d:cece with SMTP id
 bj33-20020a0561220e6100b004c9225dcecemr559298vkb.1.1710804454254; 
 Mon, 18 Mar 2024 16:27:34 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 jx12-20020a0562142b0c00b0068ff8bda6c7sm5773198qvb.92.2024.03.18.16.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 16:27:33 -0700 (PDT)
Date: Mon, 18 Mar 2024 19:27:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Maksim Davydov <davydov-max@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 jsnow@redhat.com, philmd@linaro.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PULL 0/4] machine development tool
Message-ID: <ZfjN5LYZgymP8Tp2@x1n>
References: <20240304135145.154860-1-davydov-max@yandex-team.ru>
 <CAFEAcA9acSfGP6PcErqp1rTmSd3G+AwUUx_aF-5KJy4iS6BqaQ@mail.gmail.com>
 <874jdkn3he.fsf@pond.sub.org> <ZefNfJ3BwudA-M7t@x1n>
 <117b4556-aadd-4287-909c-e5cf988214b5@yandex-team.ru>
 <ZeqKZOxF1MlgeRE3@x1n>
 <91a88010-8822-4628-9deb-bc581e536c44@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91a88010-8822-4628-9deb-bc581e536c44@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 18, 2024 at 08:08:29PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 08.03.24 06:47, Peter Xu wrote:
> > On Thu, Mar 07, 2024 at 12:06:59PM +0300, Maksim Davydov wrote:
> > > 
> > > On 3/6/24 04:57, Peter Xu wrote:
> > > > On Tue, Mar 05, 2024 at 03:43:41PM +0100, Markus Armbruster wrote:
> > > > > Peter Maydell<peter.maydell@linaro.org>  writes:
> > > > > 
> > > > > > On Mon, 4 Mar 2024 at 13:52, Maksim Davydov<davydov-max@yandex-team.ru>  wrote:
> > > > > > > The following changes since commit e1007b6bab5cf97705bf4f2aaec1f607787355b8:
> > > > > > > 
> > > > > > >     Merge tag 'pull-request-2024-03-01' ofhttps://gitlab.com/thuth/qemu  into staging (2024-03-01 10:14:32 +0000)
> > > > > > > 
> > > > > > > are available in the Git repository at:
> > > > > > > 
> > > > > > >     https://gitlab.com/davydov-max/qemu.git  tags/pull-compare-mt-2024-03-04
> > > > > > > 
> > > > > > > for you to fetch changes up to 7693a2e8518811a907d73a85807ee71dac8fabcb:
> > > > > > > 
> > > > > > >     scripts: add script to compare compatibility properties (2024-03-04 14:10:53 +0300)
> > > > > > > 
> > > > > > > ----------------------------------------------------------------
> > > > > > > Please note. This is the first pull request from me.
> > > > > > > My public GPG key is available here
> > > > > > > https://keys.openpgp.org/vks/v1/by-fingerprint/CDB5BEEF8837142579F5CDFE8E927E10F72F78D4
> > > > > > > 
> > > > > > > ----------------------------------------------------------------
> > > > > > > scripts: add a new script for machine development
> > > > > > > 
> > > > > > > ----------------------------------------------------------------
> > > > > > Hi; I would prefer this to go through some existing submaintainer
> > > > > > tree if possible, please.
> > > > > Migration?  QOM?  Not sure.  Cc'ing the maintainers anyway.
> > > > Yeah this seems like migration relevant.. however now I'm slightly confused
> > > > on when this script should be useful.
> > > > 
> > > > According to:
> > > > 
> > > > https://lore.kernel.org/qemu-devel/20240222153912.646053-5-davydov-max@yandex-team.ru/
> > > > 
> > > >           This script runs QEMU to obtain compat_props of machines and
> > > >           default values of different types of drivers to produce comparison
> > > >           table. This table can be used to compare machine types to choose
> > > >           the most suitable machine or compare binaries to be sure that
> > > >           migration to the newer version will save all device
> > > >           properties. Also the json or csv format of this table can be used
> > > >           to check does a new machine affect the previous ones by comparing
> > > >           tables with and without the new machine.
> > > > 
> > > > In regards to "choose the most suitable machine": why do you need to choose
> > > > a machine?
> > > > 
> > > > If it's pretty standalone setup, shouldn't we always try to use the latest
> > > > machine type if possible (as normally compat props are only used to keep
> > > > compatible with old machine types, and the default should always be
> > > > preferred). If it's a cluster setup, IMHO it should depend on the oldest
> > > > QEMU version that plans to be supported.  I don't see how such comparison
> > > > helps yet in either of the cases..
> > > > 
> > > > In regards to "compare binaries to be sure that migration to the newer
> > > > version will save all device properties": do we even support migrating
> > > > _between_ machine types??
> > > > 
> > > > Sololy relying on compat properties to detect device compatibility is also
> > > > not reliable.  For example, see VMStateField.field_exists() or similarly,
> > > > VMStateDescription.needed(), which are hooks that device can provide to
> > > > dynamically decide what device state to be saved/loaded.  Such things are
> > > > not reflected in compat properties, so even if compat properties of all
> > > > devices are the same between two machine types, it may not mean that the
> > > > migration stream will always be compatible.
> > > > 
> > > > Thanks,
> > > 
> > > In fact, the last commit describes the meaning of this series best. Perhaps
> > > it should have been moved to the cover letter:
> > > Often, many teams have their own "machines" inherited from "upstream" to
> > > manage default values of devices. This is done because of the limitations
> > > imposed by the compatibility requirements or the desire to help their
> > > customers better configure their devices. And since machine type has
> > > a hard-to-read structure, it is very easy to make a mistake when
> > > transferring
> > > default values from one machine to another. For example, when some property
> > > is set for the entire abstract class x86_64-cpu (which will be applied to
> > > all
> > > models), and then rolled back for a specific model. The situation is about
> > > the same with changing the default values of devices: if the value changes
> > > in the description of the device itself, then you need to make sure that
> > > nothing changes when using the current machine.
> > > Therefore, there was a desire to make a dev tool that will help quickly
> > > expand
> > > the definition of a machine or compare several machines from different
> > > binary
> > > files. It can be used when rebasing to a new version of qemu and/or for
> > > automatic tests.
> > 
> > OK, thanks.
> > 
> > So is it a migration compatibility issue that you care (migrating VMs from
> > your old downstream binary to new downstream binary should always succeed),
> > or perhaps you care more on making sure the features you wanted, i.e., you
> > want to make sure some specific devices that you care will have the
> > properties that you expect?
> 
> Actually both things.
> 
> 1. We need a tool to analyze, what exactly changes between MT-s. Do we want to move on new upstream MT or not, how much it is different from our downstream MT and so on.
> 2. It also could be used to check, that new MT is correctly defined (not breaking old MT's)
> 
> > 
> > I think compat properties are mostly used for migration purposes, but
> > indeed it can also be used to keep old behaviors of devices, even if the
> > migration could succed with/without such a compat property entry.
> > 
> > If it's about migration, I'd like to know whether vmstate-static-checker.py
> > could also help your case (under scripts/), perhaps in a better way,
> > because it directly observes the VMSD structures (which is the ultimate
> > form on wire, after all these compat properties applied to the devices).
> 
> Hmm, vmstate-static-checker.py checks a concrete device configuration. So it's a different thing.

I don't think so - 'qemu -dump-vmstate' should dump all device states that
it ever supports.  Feel free to have a look at dump_vmstate_json_to_file(),
or just try give it a dump.

> 
> > 
> > If it's not about migration, then maybe it's more QOM-relevant, and if so I
> > don't have a strong opinion. It seems still make some sense to have a tool
> > simply dump the QOM tree for a machine type with all properties and compare
> > them between machines with some binaries.  For that I'll leave that to
> > Markus to decide.
> 
> Markus ACKed :)

I didn't see Markus acked all the patches yet, but if so that's okay then.
Even if so, I think what Peter Maydell suggested is then this series should
go through the QOM tree, rather than a separate pull.

Thanks,

-- 
Peter Xu


