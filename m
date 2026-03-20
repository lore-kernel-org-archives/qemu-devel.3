Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6818108B91B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Z9e-0001DE-FR; Fri, 20 Mar 2026 08:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w3Z9T-0001Ce-Fh
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 08:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w3Z9R-0007Hl-4H
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 08:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774010428;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kTzG1yv3excY4zze3zwMzYBPgaiXOZZaI4t073SIAwM=;
 b=KrvBXIUPE0G22ui2OAXV5FyVmTTMcKxhds5zkX1rXzd7YCyxhrQSwhL0RNojdt5Fk9naGX
 iEaXts5BsXfh3Mi5ADO4bQMKo1CYwCFU//QZbJOXwzrm+D34yPTTfSWMDkUUFqkAk1bvkh
 sa9k909JD6VNEhcHqWN2WDDbBRh4QLI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-B0B35TqaNtyNCdsnjMBL9g-1; Fri,
 20 Mar 2026 08:40:25 -0400
X-MC-Unique: B0B35TqaNtyNCdsnjMBL9g-1
X-Mimecast-MFC-AGG-ID: B0B35TqaNtyNCdsnjMBL9g_1774010424
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B4F81956089; Fri, 20 Mar 2026 12:40:24 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.255])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FC951955D84; Fri, 20 Mar 2026 12:40:18 +0000 (UTC)
Date: Fri, 20 Mar 2026 12:40:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Tommaso Califano <califano.tommaso@gmail.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Eduardo Habkost <eduardo@habkost.net>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eric Blake <eblake@redhat.com>, Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Paolo Bonzini <pbonzini@redhat.com>, Luigi Leonardi <leonardi@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/5] i386/sev: Add sev-emulated QOM object with TCG support
Message-ID: <ab1ALDdqxwSWxPOx@redhat.com>
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
 <20260317113840.33017-2-califano.tommaso@gmail.com>
 <abw3HqBJqEWiY7GP@redhat.com> <87eclfj66v.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eclfj66v.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Fri, Mar 20, 2026 at 08:44:40AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Mar 17, 2026 at 12:38:36PM +0100, Tommaso Califano wrote:
> >> With this change it is possible to run a VM with the SEV CPUID active
> >> adding:
> >> 
> >>     -accel tcg \
> >>     -object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1 \
> >>     -machine memory-encryption=sev0
> >
> > snip
> >
> >> diff --git a/qapi/qom.json b/qapi/qom.json
> >> index c653248f85..35cda819ec 100644
> >> --- a/qapi/qom.json
> >> +++ b/qapi/qom.json
> >> @@ -1057,6 +1057,19 @@
> >>              '*handle': 'uint32',
> >>              '*legacy-vm-type': 'OnOffAuto' } }
> >>  
> >> +##
> >> +# @SevEmulatedProperties:
> >> +#
> >> +# Properties for sev-emulated objects.
> >> +# This object functionally emulates AMD SEV hardware via TCG, so
> >> +# it does not require real hardware to run.
> >> +#
> >> +# Since: 10.1.0
> >> +##
> >> +{ 'struct': 'SevEmulatedProperties',
> >> +  'base': 'SevGuestProperties',
> >> +  'data': {}}
> >
> > This is deriving 'sev-emulated' from 'sev-guest' which means it
> > supports all the properties that 'sev-guest' does, which for
> > the record is:
> 
> Uh, I somehow misread the base as SevCommonProperties!  Had I read
> correctly, I would've had similar questions.

Even SevCommonProperties has stuff that's irrelevant for
emulation that I mentioned.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


