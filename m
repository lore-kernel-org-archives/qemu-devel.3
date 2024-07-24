Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C408C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 17:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWfma-0006hk-El; Wed, 24 Jul 2024 13:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWfmY-0006gj-JC
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:28:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWfmV-0005B3-M4
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721842082;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Q6x8beB7lSmJnxIR89C59kGL937iJFplioQ/cGKL2Aw=;
 b=Ee/PyngvKDjagP4R5BuAAYXEDG+gj75prgNwVrmk7M/HkVpXgMee3pHw7uIf2GUasVugak
 jPMaUgDut6KDUnbQx0AT8E8VS26FM7aXwdCH6j5vCxZjo9AEyBGlWG8q9LpUgAa8ZPkAw+
 mET8NCVBanSdIYQh13C1WL0GpJ5HcO4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-nhNY1eU7PyGUvGA2CyQVbw-1; Wed,
 24 Jul 2024 13:27:58 -0400
X-MC-Unique: nhNY1eU7PyGUvGA2CyQVbw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA7C91955D5C; Wed, 24 Jul 2024 17:27:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.141])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3576D1955DC6; Wed, 24 Jul 2024 17:27:49 +0000 (UTC)
Date: Wed, 24 Jul 2024 18:27:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v4 12/17] docs/interop/firmware.json: Add igvm to
 FirmwareDevice
Message-ID: <ZqE5kn9q7cVaDnEg@redhat.com>
References: <cover.1720004383.git.roy.hopkins@suse.com>
 <9021ac8f38090955b162f7bbb6146d4bedd04984.1720004383.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9021ac8f38090955b162f7bbb6146d4bedd04984.1720004383.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 03, 2024 at 12:05:50PM +0100, Roy Hopkins wrote:
> Create an enum entry within FirmwareDevice for 'igvm' to describe that
> an IGVM file can be used to map firmware into memory as an alternative
> to pre-existing firmware devices.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  docs/interop/firmware.json | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index 54a1fc6c10..4a696adc22 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json
> @@ -55,10 +55,17 @@
>  #
>  # @memory: The firmware is to be mapped into memory.
>  #
> +# @igvm: The firmware is defined by a file conforming to the IGVM
> +#        specification and mapped into memory according to directives
> +#        defined in the file. This is similar to @memory but may
> +#        include additional processing defined by the IGVM file
> +#        including initial CPU state or population of metadata into
> +#        the guest address space. Since: 9.1
> +#
>  # Since: 3.0
>  ##
>  { 'enum' : 'FirmwareDevice',
> -  'data' : [ 'flash', 'kernel', 'memory' ] }
> +  'data' : [ 'flash', 'kernel', 'memory', 'igvm' ] }

Further down  'FirmwareDevice' is used as a union discriminator
for 'FirmwareMapping'. So you'll need to extend that union to
list what parameters can be used. I imagine just a copy of the
'FirmwareMappingMemory' struct is sufficient, giving us a simple
filename.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


