Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB21C54E49
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6Ox-0005Hh-PL; Fri, 01 Mar 2024 12:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rg6Ov-0005G2-On
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:10:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rg6Ot-000359-KY
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709313022;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mr0Zd0ePmuxZCHu2mhQtacyGf5CQPtkvQMMohELTPbs=;
 b=IHzof8XBrzr61WtcuzXbKE7vKvj6Adqq4uVOL+IkCz7eJ1Nkkw30PTuDIK5lz0hgeysXAc
 dgWdkU1ysZiMXtevVj4jhF6JueQkBD6Cgf5aXhnfZh0KhwZAzVmmt36MnRVXsQq25UIyFD
 AJZNxnhPC2BlXR2ePEQ5mIBuNAz2B+Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-TCLtQWUKPii1pBuk9fwZxA-1; Fri,
 01 Mar 2024 12:10:20 -0500
X-MC-Unique: TCLtQWUKPii1pBuk9fwZxA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A26022812947;
 Fri,  1 Mar 2024 17:10:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57FF742422;
 Fri,  1 Mar 2024 17:10:15 +0000 (UTC)
Date: Fri, 1 Mar 2024 17:10:13 +0000
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
Message-ID: <ZeIL9Tco7PCRxdg-@redhat.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <2f98be192cf6ffd36b984266570ea2eed4dfe364.1709044754.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f98be192cf6ffd36b984266570ea2eed4dfe364.1709044754.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 27, 2024 at 02:50:15PM +0000, Roy Hopkins wrote:
> IGVM support has been implemented for Confidential Guests that support
> AMD SEV and AMD SEV-ES. Add some documentation that gives some
> background on the IGVM format and how to use it to configure a
> confidential guest.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  docs/system/igvm.rst  | 58 +++++++++++++++++++++++++++++++++++++++++++
>  docs/system/index.rst |  1 +
>  2 files changed, 59 insertions(+)
>  create mode 100644 docs/system/igvm.rst


> +Firmware Images with IGVM
> +-------------------------
> +
> +When an IGVM filename is specified for a Confidential Guest Support object it
> +overrides the default handling of system firmware: the firmware image, such as
> +an OVMF binary should be contained as a payload of the IGVM file and not
> +provided as a flash drive. The default QEMU firmware is not automatically mapped
> +into guest memory.

IIUC, in future the IGVM file could contain both the OVMF and SVSM
binaries ?

I'm also wondering if there can be dependancies between the IGVM
file and the broader QEMU configuration ?  eg if SVSM gains suupport
for data persistence, potentially we might need some pflash device
exposed as storage for SVSM to use. Would such a dependancy be
something expressed in the IGVM file, or would it be knowledge that
is out of band ?

Finally, if we think of the IGVM file as simply yet another firmware
file format, then it raises of question of integration into the
QEMU firmware descriptors.

Right now when defining a guest in libvirt if you can say 'type=bios'
or 'type=uefi', and libvirt consults the firmware descriptors to find
the binary to use.

If the OS distro provides IGVM files instead of traditional raw OVMF
binaries for SEV/TDX/etc, then from libvirt's POV I think having this
expressed in the firmware descriptors is highly desirable.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


