Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B54C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFkI-00081q-Vy; Mon, 18 Mar 2024 12:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmFkH-000813-3v
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmFkF-00062A-7o
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778910;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mze+uWWzFSSGRXHftwoyuBA6Olxp/vCU6tWugxyVSjU=;
 b=LLDnQafn4U2qF3xwvY1hTFbdF6NBD7N9YwqrAWNF8NbWr1btVmb4tXybh3akfG8qsTW8QB
 cnKH881MYge4ofmGwP9tiUD66NY/TVDZrvZ+M8fymGQ5j1eQW9hqn8VTcv7yxhTKVmhSIm
 YQ50O5H9KOk55L0YFc8NIt4eZbFiChw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-fOW1NKMLNa-jFI7Cwtg3-w-1; Mon,
 18 Mar 2024 12:21:47 -0400
X-MC-Unique: fOW1NKMLNa-jFI7Cwtg3-w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95A8A3C025B1;
 Mon, 18 Mar 2024 16:21:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E37B10F53;
 Mon, 18 Mar 2024 16:21:43 +0000 (UTC)
Date: Mon, 18 Mar 2024 16:21:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH 9/9] docs/system: Add documentation on support for IGVM
Message-ID: <ZfhqEL0-wCiDJJtm@redhat.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <2f98be192cf6ffd36b984266570ea2eed4dfe364.1709044754.git.roy.hopkins@suse.com>
 <ZeIL9Tco7PCRxdg-@redhat.com>
 <46d91ba880f566e7ced7c01b18682b749185c9ba.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46d91ba880f566e7ced7c01b18682b749185c9ba.camel@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 18, 2024 at 03:59:31PM +0000, Roy Hopkins wrote:
> On Fri, 2024-03-01 at 17:10 +0000, Daniel P. Berrangé wrote:
> > On Tue, Feb 27, 2024 at 02:50:15PM +0000, Roy Hopkins wrote:
> > > IGVM support has been implemented for Confidential Guests that support
> > > AMD SEV and AMD SEV-ES. Add some documentation that gives some
> > > background on the IGVM format and how to use it to configure a
> > > confidential guest.
> > > 
> > > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > > ---
> > >  docs/system/igvm.rst  | 58 +++++++++++++++++++++++++++++++++++++++++++
> > >  docs/system/index.rst |  1 +
> > >  2 files changed, 59 insertions(+)
> > >  create mode 100644 docs/system/igvm.rst
> > 
> > 
> > > +Firmware Images with IGVM
> > > +-------------------------
> > > +
> > > +When an IGVM filename is specified for a Confidential Guest Support object
> > > it
> > > +overrides the default handling of system firmware: the firmware image, such
> > > as
> > > +an OVMF binary should be contained as a payload of the IGVM file and not
> > > +provided as a flash drive. The default QEMU firmware is not automatically
> > > mapped
> > > +into guest memory.
> > 
> > IIUC, in future the IGVM file could contain both the OVMF and SVSM
> > binaries ?
> > 
> > I'm also wondering if there can be dependancies between the IGVM
> > file and the broader QEMU configuration ?  eg if SVSM gains suupport
> > for data persistence, potentially we might need some pflash device
> > exposed as storage for SVSM to use. Would such a dependancy be
> > something expressed in the IGVM file, or would it be knowledge that
> > is out of band ?
> > 
> Yes, the IGVM file can indeed contain both OVMF and SVSM binaries. In fact, that
> is exactly what we are doing with the COCONUT-SVSM project. See [1] for the IGVM
> builder we use to package OVMF, bootloader components and the SVSM ELF binary.
> 
> Data persistence is something that is definitely going to be needed in the SVSM.
> At present, this cannot be configured using any of the directives in the IGVM
> specification but instead requires QEMU to be configured correctly to support
> the application embedded within the IGVM file itself. You could however populate
> metadata pages using IGVM that describe the storage that is _expected_ to be
> present, and validate that within the firmware itself. 
> 
> The real value from IGVM comes from the ability to describe the initial memory
> and initial CPU state which all forms part of the launch measurement and initial
> boot procedure, allowing the expected launch measurement to be calculated from a
> single IGVM file for multiple virtualisation stacks or configurations. Thus,
> most of the directives in the IGVM file directly have an effect on the launch
> measurement. I'm not sure configuring a storage device or other hardware
> configuration fits well with this.

Yeah, I can understand if IGVM scope should be limited to just memory
and CPU setup.

If we use the firmeware descriptor files, we could define capabilities
in that to express a need for a particular type of persistent storage
to back the vTPM. So having this info in IGVM files isn't critical.

> > Finally, if we think of the IGVM file as simply yet another firmware
> > file format, then it raises of question of integration into the
> > QEMU firmware descriptors.
> > 
> > Right now when defining a guest in libvirt if you can say 'type=bios'
> > or 'type=uefi', and libvirt consults the firmware descriptors to find
> > the binary to use.
> > 
> > If the OS distro provides IGVM files instead of traditional raw OVMF
> > binaries for SEV/TDX/etc, then from libvirt's POV I think having this
> > expressed in the firmware descriptors is highly desirable.
> > 
> 
> Whether IGVM is just another firmware file format or not, it certainly is used
> mutually exclusively with other firmware files. Integration with firmware
> descriptors does seem to make sense. 
> 
> One further question if this is the case, would we want to switch from
> specifying an "igvm-file" as a parameter on the "ConfidentialGuestSupport"
> object to providing the file using the "-bios" parameter, or maybe even a
> dedicated "-igvm" parameter?

If the IGVM format is flexible enough that it could be used for any VM
type, even non-confidential VMs, then having its config be separate from
ConfidentialGuestSUpport would make sense. If it is fundamentally tied
to CVMs, then just a property is fine I guess.

Probably best to stay away from -bios, to avoid overloading new semantics
onto a long standing argument.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


