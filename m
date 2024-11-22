Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E679D75E36
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 12:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tESs3-0006Ho-At; Fri, 22 Nov 2024 07:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tESs1-0006HP-9P
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 07:34:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tESrz-0004mi-63
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 07:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732278882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/0BFpYQLSJFJ77251FrOXxkrn9zcg20M8pGoj3GUaRE=;
 b=QUzqROSMesMDcA0/ZU81bnZQbWp07e9CSgS8LjEnw0ECJ/yNl9R6DKhXa/3hKaWnpe0w02
 hoC3Poc9Eu9cmFZavF60LWlDOgA//BmcXHNt+TTFaaoctIqupTKy02BP0kgU2XQTmBXFUD
 dnJlMBW2J6Ge+AQIvkW+Pr+lZKSgLTU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-E4ER40hANw2jDIghvRbV-g-1; Fri,
 22 Nov 2024 07:34:39 -0500
X-MC-Unique: E4ER40hANw2jDIghvRbV-g-1
X-Mimecast-MFC-AGG-ID: E4ER40hANw2jDIghvRbV-g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 193051956048; Fri, 22 Nov 2024 12:34:38 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.157])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32EBC1955F40; Fri, 22 Nov 2024 12:34:33 +0000 (UTC)
Date: Fri, 22 Nov 2024 13:34:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, pbonzini@redhat.com
Subject: Re: [PULL v3 0/8] Block layer patches
Message-ID: <Z0B6V-C5iWwZrYd_@redhat.com>
References: <20241120105106.50669-1-kwolf@redhat.com>
 <CAFEAcA9M_-4=UdOTwV251qOxuELAxXtJW8QaZWTs4bUq7dJwxw@mail.gmail.com>
 <Z0BaQ0ahUn4ORhPS@redhat.com> <Z0BkMMOEDKBuFz-X@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0BkMMOEDKBuFz-X@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 22.11.2024 um 12:00 hat Daniel P. Berrangé geschrieben:
> On Fri, Nov 22, 2024 at 11:17:39AM +0100, Kevin Wolf wrote:
> > Am 20.11.2024 um 14:19 hat Peter Maydell geschrieben:
> > > On Wed, 20 Nov 2024 at 10:52, Kevin Wolf <kwolf@redhat.com> wrote:
> > > >
> > > > The following changes since commit e6459afb1ff4d86b361b14f4a2fc43f0d2b4d679:
> > > >
> > > >   Merge tag 'pull-target-arm-20241119' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-11-19 14:23:34 +0000)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   https://repo.or.cz/qemu/kevin.git tags/for-upstream
> > > >
> > > > for you to fetch changes up to 83987bf722b6b692bc745b47901be76a1c97140b:
> > > >
> > > >   vl: use qmp_device_add() in qemu_create_cli_devices() (2024-11-20 11:47:49 +0100)
> > > >
> > > > ----------------------------------------------------------------
> > > > Block layer patches
> > > >
> > > > - Fix qmp_device_add() to not throw non-scalar options away (fixes
> > > >   iothread-vq-mapping being silently ignored in device_add)
> > > > - Fix qdev property crash with integer PCI addresses and JSON -device
> > > > - iotests: Fix mypy failure
> > > > - parallels: Avoid potential integer overflow
> > > > - Fix crash in migration_is_running()
> > > 
> > > Hi; the hotplug_blk.py:HotPlug.test avocado seems to be failing:
> > > 
> > > https://gitlab.com/qemu-project/qemu/-/jobs/8423313170
> > > https://gitlab.com/qemu-project/qemu/-/jobs/8423313162
> > > 
> > > [stdlog] 2024-11-20 12:49:35,669 avocado.test test L0740 ERROR| FAIL
> > > 1-tests/avocado/hotplug_blk.py:HotPlug.test -> AssertionError: 1 != 0
> > > : Guest command failed: test -e /sys/block/vda
> > > 
> > > https://qemu-project.gitlab.io/-/qemu/-/jobs/8423313162/artifacts/build/tests/results/latest/test-results/09-tests_avocado_hotplug_blk.py_HotPlug.test/debug.log
> > > 
> > > Looks like the test called device_add, it succeeded, but
> > > it didn't see the /sys/block/vda node appear in the guest.
> > > 
> > > (The test logic of "try the command, if it fails sleep for 1
> > > second then try a second time and if that fails call it a
> > > test error" doesn't seem super robust in the face of slow
> > > CI runners, but OTOH it failed the same way on both jobs,
> > > so I don't think that is the culprit here.)
> > 
> > This looks like a bug in the test case that was previously cancelled out
> > by a QEMU bug. :-/
> > 
> > {
> >   "execute": "device_add",
> >   "arguments": {
> >     "driver": "virtio-blk-pci",
> >     "drive": "disk",
> >     "id": "virtio-disk0",
> >     "bus": "pci.1",
> >     "addr": 1
> >   },
> >   "id": "__qmp#00002"
> > }
> > 
> > What it actually meant is "addr": "1". It's an unfortunate interface,
> > but string "1" and integer 1 mean different things for PCI address
> > properties... Going through QemuOpts turned everything into strings, so
> > that masked the bug in the test case.
> 
> I never realized that "1" and "1" mean different things in PCI
> addresses !
> 
> IIUC, "1" decodes as slot 1, function 0, while integer 1  decodes as
> slot 0, function 1 .  ie raw integer value is "slot << 3 | function"
> IIUC from the code ?
> 
> This is both majorly surprising, and rather obscure - did we document
> the integer value encoding semantics anywhere ?

Did we document anything about most QOM properties anywhere?

But yes, I think your understanding is right. Before Stefan's patch,
when it was interpreted as string "1", it resulted in "addr = 01.0" in
info qtree, now that it's interpreted as integer, we get "addr = 00.1".
And adding merely a function without the device it is part of, it makes
sense that the guest doesn't see it.

> AFAICT, they first arrived back in
> 
>   commit 768a9ebe188bd0a6172a9a4e64777d21fff7f014
>   Author: Paolo Bonzini <pbonzini@redhat.com>
>   Date:   Thu Feb 9 09:53:32 2012 +0100
> 
>     qdev: accept both strings and integers for PCI addresses
>     
>     Visitors allow a limited form of polymorphism.  Exploit it to support
>     setting the non-legacy PCI address property both as a DD.F string
>     and as an 8-bit integer.
> 
>     The 8-bit integer form is just too clumsy, it is unlikely that we will
>     ever drop it.
> 
> 
> I'm guessing that last sentence is a mistake - refering to the new
> integer syntax as clumsy & unable to be dropped doesn't make sense.
> I assume it was referring to the historical string syntax as the
> clumsy part.

It's not completely clear to me what this commit actually intended.

But before it, .set was integer-only, it was only .parse that accepted
strings (and only strings). I'm not familiar enough with qdev history to
tell which was used for which case. I suppose .set was mostly for
internal users and .parse for external interfaces (command line, HMP,
maybe also QMP?)

So if that is right, it added strings to internal users, and integers to
external users. Not sure which part was actually needed and for what
reason.

> > Should I just fix the test case and move on, or are we concerned about
> > other users having a similar bug and want to move the change to 10.0,
> > keeping device_add with iothread-vq-mapping broken in 9.2?
> 
> I think neither syntax really makes sense from a pure QAPI design
> POV, as both are inventing a special way to encode 2 distinct
> fields within one field which is a QAPI anti-pattern. The "right"
> QAPI answer is to express them as 2 distinct fields at the QAPI
> level.

Right. qdev and QAPI still live in two separate worlds. This was never
modelled as a QAPI type/command, device_add doesn't have a schema.

Before the patch in this pull request, you couldn't even have non-scalar
properties, so it wouldn't even have been possible to split it like
that. Unless you make it two totally separate properties, but then you
could set one without the other, which feels like it would only add more
strange cases.

> Having two distinct ways to express the same concept is redundant.
> Perhaps passable if one syntax was actually following QAPI best
> practice, even better if one syntax were deprecated.
> 
> 
> Is it worth thinking about going through the tedium of deprecating
> both of them and replacing the syntax with a preferred QAPI design
> pattern ?

Not sure if it's worth it. But at least it's possible to add the
preferred syntax, by adding a dict branch to the alternate.

> If we don't want to replace the existing string format which is
> widely used, then is the integer format compelling enough to keep
> as an option, given it will easily surprise people who don't read
> the non-existant docs about it ? ie deprecate integer syntax and
> leave ony the string syntax ?

I don't expect many users of our external interfaces to use the integer
syntax, so removing it shouldn't hurt from that point of view.

Internal users in the C code still use the integer version. We would
have to change that first. In a quick grep, I see 14 callers, so that
seems doable.

I also see that the property getter is still always integer. So if you
query the device, that's what you get even in external interfaces. Not
sure if anyone relies on that, though. Probably not.

> FWIW, the options for a QAPI design following best practice
> design would be
> 
> 1. "slot" and "function" properties at top level
> 
>  {
>    "execute": "device_add",
>    "arguments": {
>      "driver": "virtio-blk-pci",
>      "drive": "disk",
>      "id": "virtio-disk0",
>      "bus": "pci.1",
>      "slot": 1,
>      "function": 0,
>    },
>    "id": "__qmp#00002"
>  }
> 
> 
> 2. two element array
> 
>  {
>    "execute": "device_add",
>    "arguments": {
>      "driver": "virtio-blk-pci",
>      "drive": "disk",
>      "id": "virtio-disk0",
>      "bus": "pci.1",
>      "addr": [1, 0]
>    },
>    "id": "__qmp#00002"
>  }
> 
> 
> 3. As 1 but with nested struct
> 
>  {
>    "execute": "device_add",
>    "arguments": {
>      "driver": "virtio-blk-pci",
>      "drive": "disk",
>      "id": "virtio-disk0",
>      "bus": "pci.1",
>      "addr": {
>        "slot": 1,
>        "function": 0
>      }
>    },
>    "id": "__qmp#00002"
>  }

If you ask me, 3. is the only correctly modelled interface. Addresses
are set as a single unit, and they are not just a list of same things,
but the two values have different meanings.

Kevin


