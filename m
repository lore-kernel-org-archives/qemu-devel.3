Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38C5C54E41
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 03:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riRDN-0004Le-Mq; Thu, 07 Mar 2024 22:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riRDM-0004LU-J0
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 22:48:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riRDK-0003ZW-Ih
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 22:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709869684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9QZgG0AqtPvtDJvXaXHsnEODDZfidvQZXlQa6jSf6aY=;
 b=A4XGzi31iC+xVqH1XinLA1qJR7RAqPoHjfFhrcuS4P3ciAGj9gvD3Hg2h2ToRTy6IbOFHb
 tZdUdbbx5HpAcphrDIlWatRfjfC6Wr7uGkMW3BcWAXaeYoxPdpEV2FfvUPTS1V4iEB0O/y
 v/OyMbYzVKCq9c+ttvSSrBjJbjYNYtY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-H5fJZ93tOyyWYuwpP9Z9cA-1; Thu, 07 Mar 2024 22:48:03 -0500
X-MC-Unique: H5fJZ93tOyyWYuwpP9Z9cA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-563de65ac5dso535521a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 19:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709869682; x=1710474482;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9QZgG0AqtPvtDJvXaXHsnEODDZfidvQZXlQa6jSf6aY=;
 b=m5HU4v3iwci+cJDwSjntBsZIvYGAQPFBkLTBsTiMkV7j9b4VtDDiBM1lIc7zSoBDQN
 kNkFvwy6pvGKQE8mCUc6k7eORdUM2gui4qvLjuam3F8BHcKWsyLjJijQs45WAeJla5GN
 GDwiDMkK/Tw1DJAKGlWj6MQOj7M7GA3VgXDAwhSmoPBQM/ItwP4C5d89CWQFZYzypVW9
 q4YneusZY8UgXu6rljnq09SdZqgv1zecbT3QL9iLZ9sdajUOrvUsQvQ+AgaNJaPqJZFm
 anSEAIi7jQhpOtGTvP4nl+0G36Ro+wBW5hpCwC2N7Skhzb4sVanDdzrXtATT0P7YapX4
 4IDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6BuhvYIXeZ5/lRGXZ0beWM1af1J7G+vzqh42BzJEkxdZjM7h0WzbTBIH7UuBBaMPn2x8NkTBOSiq8e48Cf04LZ4er5HY=
X-Gm-Message-State: AOJu0Yxe45HC/wco7wVYeIxZ51G/o9/+332Cz0NDIqO4vJqITBYOeGrS
 sjsWgiuKGKmSEAgtSMpcwzh76TDOTgChTUEBwn6gzcUyYtIxnhluk8jmHwqt/A3treVCtA+YOJd
 fTTUM5qPiZOG0r4ZYvvw3VmTjn+Q4aCPhro0FsosvsyztzGYtd16C
X-Received: by 2002:a05:6a20:d387:b0:1a1:85d6:e2a4 with SMTP id
 iq7-20020a056a20d38700b001a185d6e2a4mr93817pzb.1.1709869682023; 
 Thu, 07 Mar 2024 19:48:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpysrP/b48frs6LGTCGHRqoUrWBCVJ9pMuaPLcJkpOwwGbO+EluwvPgw1K3wTjvLa0yatYVw==
X-Received: by 2002:a05:6a20:d387:b0:1a1:85d6:e2a4 with SMTP id
 iq7-20020a056a20d38700b001a185d6e2a4mr93794pzb.1.1709869681631; 
 Thu, 07 Mar 2024 19:48:01 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 c17-20020a170903235100b001d9fc6df457sm365444plh.5.2024.03.07.19.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 19:48:01 -0800 (PST)
Date: Fri, 8 Mar 2024 11:47:48 +0800
From: Peter Xu <peterx@redhat.com>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, jsnow@redhat.com, philmd@linaro.org,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PULL 0/4] machine development tool
Message-ID: <ZeqKZOxF1MlgeRE3@x1n>
References: <20240304135145.154860-1-davydov-max@yandex-team.ru>
 <CAFEAcA9acSfGP6PcErqp1rTmSd3G+AwUUx_aF-5KJy4iS6BqaQ@mail.gmail.com>
 <874jdkn3he.fsf@pond.sub.org> <ZefNfJ3BwudA-M7t@x1n>
 <117b4556-aadd-4287-909c-e5cf988214b5@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <117b4556-aadd-4287-909c-e5cf988214b5@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Mar 07, 2024 at 12:06:59PM +0300, Maksim Davydov wrote:
> 
> On 3/6/24 04:57, Peter Xu wrote:
> > On Tue, Mar 05, 2024 at 03:43:41PM +0100, Markus Armbruster wrote:
> > > Peter Maydell<peter.maydell@linaro.org>  writes:
> > > 
> > > > On Mon, 4 Mar 2024 at 13:52, Maksim Davydov<davydov-max@yandex-team.ru>  wrote:
> > > > > The following changes since commit e1007b6bab5cf97705bf4f2aaec1f607787355b8:
> > > > > 
> > > > >    Merge tag 'pull-request-2024-03-01' ofhttps://gitlab.com/thuth/qemu  into staging (2024-03-01 10:14:32 +0000)
> > > > > 
> > > > > are available in the Git repository at:
> > > > > 
> > > > >    https://gitlab.com/davydov-max/qemu.git  tags/pull-compare-mt-2024-03-04
> > > > > 
> > > > > for you to fetch changes up to 7693a2e8518811a907d73a85807ee71dac8fabcb:
> > > > > 
> > > > >    scripts: add script to compare compatibility properties (2024-03-04 14:10:53 +0300)
> > > > > 
> > > > > ----------------------------------------------------------------
> > > > > Please note. This is the first pull request from me.
> > > > > My public GPG key is available here
> > > > > https://keys.openpgp.org/vks/v1/by-fingerprint/CDB5BEEF8837142579F5CDFE8E927E10F72F78D4
> > > > > 
> > > > > ----------------------------------------------------------------
> > > > > scripts: add a new script for machine development
> > > > > 
> > > > > ----------------------------------------------------------------
> > > > Hi; I would prefer this to go through some existing submaintainer
> > > > tree if possible, please.
> > > Migration?  QOM?  Not sure.  Cc'ing the maintainers anyway.
> > Yeah this seems like migration relevant.. however now I'm slightly confused
> > on when this script should be useful.
> > 
> > According to:
> > 
> > https://lore.kernel.org/qemu-devel/20240222153912.646053-5-davydov-max@yandex-team.ru/
> > 
> >          This script runs QEMU to obtain compat_props of machines and
> >          default values of different types of drivers to produce comparison
> >          table. This table can be used to compare machine types to choose
> >          the most suitable machine or compare binaries to be sure that
> >          migration to the newer version will save all device
> >          properties. Also the json or csv format of this table can be used
> >          to check does a new machine affect the previous ones by comparing
> >          tables with and without the new machine.
> > 
> > In regards to "choose the most suitable machine": why do you need to choose
> > a machine?
> > 
> > If it's pretty standalone setup, shouldn't we always try to use the latest
> > machine type if possible (as normally compat props are only used to keep
> > compatible with old machine types, and the default should always be
> > preferred). If it's a cluster setup, IMHO it should depend on the oldest
> > QEMU version that plans to be supported.  I don't see how such comparison
> > helps yet in either of the cases..
> > 
> > In regards to "compare binaries to be sure that migration to the newer
> > version will save all device properties": do we even support migrating
> > _between_ machine types??
> > 
> > Sololy relying on compat properties to detect device compatibility is also
> > not reliable.  For example, see VMStateField.field_exists() or similarly,
> > VMStateDescription.needed(), which are hooks that device can provide to
> > dynamically decide what device state to be saved/loaded.  Such things are
> > not reflected in compat properties, so even if compat properties of all
> > devices are the same between two machine types, it may not mean that the
> > migration stream will always be compatible.
> > 
> > Thanks,
> 
> In fact, the last commit describes the meaning of this series best. Perhaps
> it should have been moved to the cover letter:
> Often, many teams have their own "machines" inherited from "upstream" to
> manage default values of devices. This is done because of the limitations
> imposed by the compatibility requirements or the desire to help their
> customers better configure their devices. And since machine type has
> a hard-to-read structure, it is very easy to make a mistake when
> transferring
> default values from one machine to another. For example, when some property
> is set for the entire abstract class x86_64-cpu (which will be applied to
> all
> models), and then rolled back for a specific model. The situation is about
> the same with changing the default values of devices: if the value changes
> in the description of the device itself, then you need to make sure that
> nothing changes when using the current machine.
> Therefore, there was a desire to make a dev tool that will help quickly
> expand
> the definition of a machine or compare several machines from different
> binary
> files. It can be used when rebasing to a new version of qemu and/or for
> automatic tests.

OK, thanks.

So is it a migration compatibility issue that you care (migrating VMs from
your old downstream binary to new downstream binary should always succeed),
or perhaps you care more on making sure the features you wanted, i.e., you
want to make sure some specific devices that you care will have the
properties that you expect?

I think compat properties are mostly used for migration purposes, but
indeed it can also be used to keep old behaviors of devices, even if the
migration could succed with/without such a compat property entry.

If it's about migration, I'd like to know whether vmstate-static-checker.py
could also help your case (under scripts/), perhaps in a better way,
because it directly observes the VMSD structures (which is the ultimate
form on wire, after all these compat properties applied to the devices).

If it's not about migration, then maybe it's more QOM-relevant, and if so I
don't have a strong opinion. It seems still make some sense to have a tool
simply dump the QOM tree for a machine type with all properties and compare
them between machines with some binaries.  For that I'll leave that to
Markus to decide.

Btw, I tried to apply the patches and build, but failed:

In file included from ../qapi/qapi-schema.json:70:
../qapi/machine.json:224: text required after 'Example:'
[40/2810] Generating trace/trace-hw_ide.h with a custom command
[41/2810] Generating trace/trace-hw_isa.h with a custom command
[42/2810] Generating trace/trace-hw_intc.c with a custom command
[43/2810] Generating trace/trace-hw_mem.h with a custom command
[44/2810] Generating trace/trace-hw_isa.c with a custom command
[45/2810] Generating trace/trace-hw_intc.h with a custom command
[46/2810] Generating trace/trace-hw_mem.c with a custom command
ninja: build stopped: subcommand failed.
make: *** [Makefile:162: run-ninja] Error 1

There also seems to have an assumption that QEMU is built under "build/" in
the script.

+default_qemu_binary = 'build/qemu-system-x86_64'

-- 
Peter Xu


