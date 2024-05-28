Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B970AC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 18:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC1vz-0008Cg-07; Tue, 28 May 2024 14:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sC1vw-0008AQ-I1
 for qemu-devel@nongnu.org; Tue, 28 May 2024 14:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sC1vu-0006Rp-Ei
 for qemu-devel@nongnu.org; Tue, 28 May 2024 14:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716922345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MeeXLFm+KVSfOePyQktJC5DxygFFlOUukqRds/wiLRA=;
 b=hjd2lWCRL4OmugfHYQIu3HX78TGbj6FU2aI07zbSTB8wM/8oehDv2CpmS/Z//YKclIx+Qr
 BK4eHrctb/hkwkW8oulo7KahwH78Q70I+lOQGFV/vmt7eFRXRQ+bOz6SoQsgbcbCQSuvfq
 68M3126/yufRh0qasOs/7Nnddt11Olc=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-Zz0ShnB_PmWaRFGQNS5uPQ-1; Tue, 28 May 2024 14:52:23 -0400
X-MC-Unique: Zz0ShnB_PmWaRFGQNS5uPQ-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-4e4effcc887so80931e0c.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 11:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716922343; x=1717527143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MeeXLFm+KVSfOePyQktJC5DxygFFlOUukqRds/wiLRA=;
 b=D5jsh4+0Qo4d0Q4pZR/D6IUJm2CgGIV5uP97IbVIrdk2AE6e7LCE0Al8vnSlFFhNuQ
 7TVzhn9ZK8nw2sFNN6lrbR38Hqj28+HBTfQQYYzQL92CD7f7brw1Uepf+oo725hkGb0S
 2A1Tt5Y2rCaSwtP8s8iPTlgVVPoqILotjkXgeqfTv+3bvwQrZqliEdNFt775JFSXHQr7
 x81UtD4PS9DShXnr1jy3SEEfKhIM5zq0VxHJGuTYzvS9T2q79piotmwtdhsYhmjnxX3J
 DC4sJOMRHlMRWQORupWFlQXJ2crN9N8cuKbwlVAyC4SNLtmUl2V2o6UaIzW74PoLShvL
 XqyA==
X-Gm-Message-State: AOJu0YzRQ7wygohLfVkkShUJjtt+y0A8tuZyAhWzhgjTg6VPHmZFlgzs
 hnakysjINpAkd5sBxYkn70vrWaj8i+GXhPLe66AlBvdXftwK+lMkLYAztj3E4c2NKxcK17kz1P1
 w9B8vX1eHi44WuHChH6/hpWFgZRH0EpAed1jiD4gYbgEa7Nc3NOlY
X-Received: by 2002:a05:6122:4a09:b0:4e4:ea87:ec75 with SMTP id
 71dfb90a1353d-4e4f02a8099mr12783644e0c.1.1716922342744; 
 Tue, 28 May 2024 11:52:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMZJyN3rPXjVHXggHrRCwsQ6YVPY7FdJWVc5mwKM1o0c29f3FNl6RRPn9zSOuz4hDIvfjG1w==
X-Received: by 2002:a05:6122:4a09:b0:4e4:ea87:ec75 with SMTP id
 71dfb90a1353d-4e4f02a8099mr12783611e0c.1.1716922341939; 
 Tue, 28 May 2024 11:52:21 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abd46ab7sm400890885a.136.2024.05.28.11.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 11:52:21 -0700 (PDT)
Date: Tue, 28 May 2024 14:52:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Het Gala <het.gala@nutanix.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [RFC PATCH 4/4] ci: Add the new migration device tests
Message-ID: <ZlYn45awm6kT5D9u@x1n>
References: <20240523201922.28007-1-farosas@suse.de>
 <20240523201922.28007-5-farosas@suse.de> <ZlT4f368xO8fXsUY@x1n>
 <87ttiig62j.fsf@suse.de> <ZlX8sNDh2gIFa2Kp@x1n>
 <87mso9g63b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mso9g63b.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

On Tue, May 28, 2024 at 03:10:48PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, May 27, 2024 at 08:59:00PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Thu, May 23, 2024 at 05:19:22PM -0300, Fabiano Rosas wrote:
> >> >> We have two new migration tests that check cross version
> >> >> compatibility. One uses the vmstate-static-checker.py script to
> >> >> compare the vmstate structures from two different QEMU versions. The
> >> >> other runs a simple migration with a few devices present in the VM, to
> >> >> catch obvious breakages.
> >> >> 
> >> >> Add both tests to the migration-compat-common job.
> >> >> 
> >> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> >> ---
> >> >>  .gitlab-ci.d/buildtest.yml | 43 +++++++++++++++++++++++++++++++-------
> >> >>  1 file changed, 36 insertions(+), 7 deletions(-)
> >> >> 
> >> >> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> >> >> index 91c57efded..bc7ac35983 100644
> >> >> --- a/.gitlab-ci.d/buildtest.yml
> >> >> +++ b/.gitlab-ci.d/buildtest.yml
> >> >> @@ -202,18 +202,47 @@ build-previous-qemu:
> >> >>    needs:
> >> >>      - job: build-previous-qemu
> >> >>      - job: build-system-opensuse
> >> >> -  # The old QEMU could have bugs unrelated to migration that are
> >> >> -  # already fixed in the current development branch, so this test
> >> >> -  # might fail.
> >> >> +  # This test is allowed to fail because:
> >> >> +  #
> >> >> +  # - The old QEMU could have bugs unrelated to migration that are
> >> >> +  #   already fixed in the current development branch.
> >> >
> >> > Did you ever hit a real failure with this?  I'm wondering whether we can
> >> > remove this allow_failure thing.
> >> >
> >> 
> >> I haven't. But when it fails we'll go through an entire release cycle
> >> with this thing showing red for every person that runs the CI. Remember,
> >> this is a CI failure to which there's no fix aside from waiting for the
> >> release to happen. Even if we're quick to react and disable the job, I
> >> feel it might create some confusion already.
> >
> > My imagination was if needed we'll get complains and we add that until
> > then for that broken release only, and remove in the next release again.
> >
> >> 
> >> >> +  #
> >> >> +  # - The vmstate-static-checker script trips on renames and other
> >> >> +  #   backward-compatible changes to the vmstate structs.
> >> >
> >> > I think I keep my preference per last time we talked on this. :)
> >> 
> >> Sorry, I'm not trying to force this in any way, I just wrote these to
> >> use in the pull-request and thought I'd put it out there. At the very
> >> least we can have your concerns documented. =)
> >
> > Yep that's fine.  I think we should keep such discussion on the list,
> > especially we have different opinions, while none of us got convinced yet
> > so far. :)
> >
> >> 
> >> > I still think it's too early to involve a test that can report false
> >> > negative.
> >> 
> >> (1)
> >> Well, we haven't seen any false negatives, we've seen fields being
> >> renamed. If that happens, then we'll ask the person to update the
> >> script. Is that not acceptable to you? Or are you thinking about other
> >> sorts of issues?
> >
> > Then question is how to update the script. So far it's treated as failure
> > on rename, even if it's benign. Right now we have this:
> >
> >             print("Section \"" + sec + "\",", end=' ')
> >             print("Description \"" + desc + "\":", end=' ')
> >             print("expected field \"" + s_item["field"] + "\",", end=' ')
> >             print("got \"" + d_item["field"] + "\"; skipping rest")
> >             bump_taint()
> >             break
> >
> > Do you want to introduce a list of renamed vmsd fields in this script and
> > maintain that?  IMHO it's an overkill and unnecessary burden to other
> > developers.
> >
> 
> That's not _my_ idea, we already have that (see below). There's not much
> reason to rename fields like that, the vmstate is obviously something
> that should be kept stable, so having to do a rename in a script is way
> better than having to figure out the fix for the compatibility break.
> 
> def check_fields_match(name, s_field, d_field):
>     if s_field == d_field:
>         return True
> 
>     # Some fields changed names between qemu versions.  This list
>     # is used to allow such changes in each section / description.
>     changed_names = {
>         'apic': ['timer', 'timer_expiry'],
>         'e1000': ['dev', 'parent_obj'],
>         'ehci': ['dev', 'pcidev'],
>         'I440FX': ['dev', 'parent_obj'],
>         'ich9_ahci': ['card', 'parent_obj'],
>         'ich9-ahci': ['ahci', 'ich9_ahci'],
>         'ioh3420': ['PCIDevice', 'PCIEDevice'],
>         'ioh-3240-express-root-port': ['port.br.dev',
>                                        'parent_obj.parent_obj.parent_obj',
>                                        'port.br.dev.exp.aer_log',
>                                 'parent_obj.parent_obj.parent_obj.exp.aer_log'],
>         'cirrus_vga': ['hw_cursor_x', 'vga.hw_cursor_x',
>                        'hw_cursor_y', 'vga.hw_cursor_y'],
>         'lsiscsi': ['dev', 'parent_obj'],
>         'mch': ['d', 'parent_obj'],
>         'pci_bridge': ['bridge.dev', 'parent_obj', 'bridge.dev.shpc', 'shpc'],
>         'pcnet': ['pci_dev', 'parent_obj'],
>         'PIIX3': ['pci_irq_levels', 'pci_irq_levels_vmstate'],
>         'piix4_pm': ['dev', 'parent_obj', 'pci0_status',
>                      'acpi_pci_hotplug.acpi_pcihp_pci_status[0x0]',
>                      'pm1a.sts', 'ar.pm1.evt.sts', 'pm1a.en', 'ar.pm1.evt.en',
>                      'pm1_cnt.cnt', 'ar.pm1.cnt.cnt',
>                      'tmr.timer', 'ar.tmr.timer',
>                      'tmr.overflow_time', 'ar.tmr.overflow_time',
>                      'gpe', 'ar.gpe'],
>         'rtl8139': ['dev', 'parent_obj'],
>         'qxl': ['num_surfaces', 'ssd.num_surfaces'],
>         'usb-ccid': ['abProtocolDataStructure', 'abProtocolDataStructure.data'],
>         'usb-host': ['dev', 'parent_obj'],
>         'usb-mouse': ['usb-ptr-queue', 'HIDPointerEventQueue'],
>         'usb-tablet': ['usb-ptr-queue', 'HIDPointerEventQueue'],
>         'vmware_vga': ['card', 'parent_obj'],
>         'vmware_vga_internal': ['depth', 'new_depth'],
>         'xhci': ['pci_dev', 'parent_obj'],
>         'x3130-upstream': ['PCIDevice', 'PCIEDevice'],
>         'xio3130-express-downstream-port': ['port.br.dev',
>                                             'parent_obj.parent_obj.parent_obj',
>                                             'port.br.dev.exp.aer_log',
>                                 'parent_obj.parent_obj.parent_obj.exp.aer_log'],
>         'xio3130-downstream': ['PCIDevice', 'PCIEDevice'],
>         'xio3130-express-upstream-port': ['br.dev', 'parent_obj.parent_obj',
>                                           'br.dev.exp.aer_log',
>                                           'parent_obj.parent_obj.exp.aer_log'],
>         'spapr_pci': ['dma_liobn[0]', 'mig_liobn',
>                       'mem_win_addr', 'mig_mem_win_addr',
>                       'mem_win_size', 'mig_mem_win_size',
>                       'io_win_addr', 'mig_io_win_addr',
>                       'io_win_size', 'mig_io_win_size'],
>     }
> 
>     if not name in changed_names:
>         return False
> 
>     if s_field in changed_names[name] and d_field in changed_names[name]:
>         return True
> 
>     return False

Ouch, I didn't notice that..  Ok that's a fair request then!

> 
> 
> >> 
> >> > I'd still keep running this before soft-freeze like I used to
> >> > do, throw issues to others and urge them to fix before release.
> >> 
> >> Having hidden procedures that maintainers run before a release is bad
> >> IMHO, it just delays the catching of bugs and frustrates
> >> contributors. Imagine working on a series, everything goes well with
> >> reviews, CI passes, patch gets queued and merged and a month later you
> >> get a ping about something you should have done to avoid breaking
> >> migration. Right during freeze.
> >
> > I understand your point, however I don't yet see a way CI could cover
> > everything.  CI won't cover performance test, and I still ran multifd tests
> > at least smoke it too before soft-freeze.
> >
> > If there's something done wrong, we notify the sooner the better.  Now it
> > looks to me the best trade-off is like that - we notify at soft-freeze once
> > per release considering that's pretty rare too, e.g. 9.0 has no such outlier.
> 
> We should notify before merging any code. If there is a tool that can
> catch the bug, there's no point in wasting everyone's time carrying that
> patch forward. That's the purpose of a CI setup. These tests are very
> light in terms of resources.
> 
> Now, you're making the point that these issues are rare, which they may
> very well be, I haven't ran this long enough to know. I also don't know
> how to measure that, I believe our CI already has a large amount of
> tests that never catch anything, so I'm not sure how much we should take
> it in consideration when adding tests to the CI.
> 
> About the possibly false results, we'll have to hold merging this for a
> few releases and gather more data, see how much of a bother it is to
> keep updating these fields. I expect to have more bugs caught by the
> script than any renames happening.

When looking (trying to fill up the whilelist for 8.2 machine type on
"esp"), I found one more thing. See:

commit b46a43a2241476d13486e016a0809b690b65f90e
Author: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date:   Fri Jan 12 12:53:48 2024 +0000

    esp.c: remove unused PDMA callback implementation
    
    Note that this is a migration break for the q800 machine because the extra PDMA
    information is no longer included.
    
    Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
    Tested-by: Helge Deller <deller@gmx.de>
    Tested-by: Thomas Huth <thuth@redhat.com>
    Message-Id: <20240112125420.514425-57-mark.cave-ayland@ilande.co.uk>
    Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

It deliberately wants to break migration.  That might be a problem now
since it means it'll reliably fail the vmstate checker CI test, then
people'll say "this is expected", then should the maintainer merge such
change?  As long as merged, everything running the vmstate checker will
fail it always.

Maybe we'll need to add another whiltelist to ignore some devices?  It
gets a bit hairy..

-- 
Peter Xu


