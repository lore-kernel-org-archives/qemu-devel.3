Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E11BC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 14:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLkO7-0004or-1X; Mon, 24 Jun 2024 10:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLkO5-0004nP-EH
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLkO3-0000hX-Fd
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719238178;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SW/uFAw4V6reigCHixEt4ovWgNXrMbGzDEuXfjfsmn4=;
 b=Xz++g9RQfhFycGoAG4o/aXhmcuVKdY4KyvGffoBh4a2ehOEXU228BilPuNxceOemvOEKm4
 S2+pZwSVk+XmgOIDmO72njyaoRZBWnTFf1CloWnqTG0M91d/1VMUcdTpmNcdyoin9CDA+O
 aw/HpJf4zxqw+cphjkTkzlSbzUh3F84=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-LK82E_QWOc2i7oOX3UXE4Q-1; Mon,
 24 Jun 2024 10:09:35 -0400
X-MC-Unique: LK82E_QWOc2i7oOX3UXE4Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EBAC19560B5; Mon, 24 Jun 2024 14:09:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.226])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C4CE3000219; Mon, 24 Jun 2024 14:09:25 +0000 (UTC)
Date: Mon, 24 Jun 2024 15:09:22 +0100
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
Subject: Re: [PATCH v3 09/15] docs/system: Add documentation on support for
 IGVM
Message-ID: <Znl-EjTr30PrNe4F@redhat.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
 <b666f4e30e8785de3dc944ac8dbefd0a23f49f5d.1718979106.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b666f4e30e8785de3dc944ac8dbefd0a23f49f5d.1718979106.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Jun 21, 2024 at 03:29:12PM +0100, Roy Hopkins wrote:
> IGVM support has been implemented for Confidential Guests that support
> AMD SEV and AMD SEV-ES. Add some documentation that gives some
> background on the IGVM format and how to use it to configure a
> confidential guest.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  docs/system/i386/amd-memory-encryption.rst |   2 +
>  docs/system/igvm.rst                       | 157 +++++++++++++++++++++
>  docs/system/index.rst                      |   1 +
>  3 files changed, 160 insertions(+)
>  create mode 100644 docs/system/igvm.rst

> diff --git a/docs/system/igvm.rst b/docs/system/igvm.rst
> new file mode 100644
> index 0000000000..b6e544a508
> --- /dev/null
> +++ b/docs/system/igvm.rst

> +Running a Confidential Guest configured using IGVM
> +--------------------------------------------------
> +
> +To run a confidential guest configured with IGVM you need to add an
> +``igvm-cfg`` object and refer to it from the ``-machine`` parameter:
> +
> +Example (for AMD SEV)::
> +
> +    qemu-system-x86_64 \
> +        <other parameters> \
> +        -machine ...,confidential-guest-support=sev0,igvm-cfg=igvm0 \
> +        -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=1 \
> +        -object igvm-cfg,id=igvm0,file=/path/to/guest.igvm

Perhaps also illustrate use of your 'buildigvm' tool for creating
the igvm file first, assuming that's the tool users are most likely
to end up needing ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


