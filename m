Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5AF606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DRNEwhJq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKEWJ-0002lh-Bh; Fri, 23 Oct 2026 08:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xKEWC-0002kz-64
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xKEW9-0005KH-SP
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792759023;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwllUNLAVdeDAy41fbtopy9g58xX4SZbMsb4StQicOk=;
 b=DRNEwhJqaVz+O6BUlUnbLyZR0zwy5FjxiB601aVBIXYGwF0jmPtLHducK/tbBPci1Bckmq
 t6CElHi/U00cZotE6+J6bx+icoCUhHupoeBTDCgNseqUrr/m6W727pBYWPN0GlaBbYJmF3
 vic0hamG1lsvKemJo6sKMYl+996VG/Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-BfDOqJ9sP5CNLoQHXiPAkg-1; Fri,
 23 Oct 2026 08:37:00 -0400
X-MC-Unique: BfDOqJ9sP5CNLoQHXiPAkg-1
X-Mimecast-MFC-AGG-ID: BfDOqJ9sP5CNLoQHXiPAkg_1792759019
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C76F1944CE5; Fri, 23 Oct 2026 12:36:59 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AADAA1800347; Fri, 23 Oct 2026 12:36:56 +0000 (UTC)
Date: Fri, 23 Oct 2026 13:36:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: qemu-system-x86_64 appears to have sgx-epc, but not
 memory-backend-epc
Message-ID: <attU5UAI225QGa9J@redhat.com>
References: <87zew5j3iv.fsf@pond.sub.org> <ats0_RfeVugAofN9@redhat.com>
 <CAFEAcA_wabjzp0KF69-ay75QoOk=jE-TygrD-T-b60dw1iOs=g@mail.gmail.com>
 <attACqgQQ-Lxt5Pj@redhat.com>
 <CAFEAcA-2Zkw-xhZ59nAfFOEbGz8W2XSOdi8d4eD5F8U4T1YE-Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-2Zkw-xhZ59nAfFOEbGz8W2XSOdi8d4eD5F8U4T1YE-Q@mail.gmail.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 12:50:24PM +0100, Peter Maydell wrote:
> On Fri, 23 Oct 2026 at 12:08, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > The memory backends are all implementing the UserCreatable
> > interface, which provides a "complete" method where they
> > could gracefully report lack of the feature via 'errp'.
> 
> I didn't realize UserCreatable was a thing. It seems unfortunate
> that we have accumulated three different kinds of object
> creation/destruction life cycle:
> 
> - instance_init / instance_finalize

This is all stuff that is supposed to be basic self contanied
initialization/cleanup with no side effects or dependencies,
and impossible to fail, which is pretty clear semantics.
During init, no external properties have been set yet, and
during finalize it is already disconnected from the QOM tree.
Essentially these should be basic memory allocs/free, mutex
inits/destroys, setting default int values if non-zero, etc.

> - instance_init / realize / unrealize / instance_finalize
> - instance_init / complete / prepare_delete / instance_finalize

These two have clear overlap in that they both take place after
user specified properties have been set, and deal with types of
initialization/setup/cleanup that can fail and have external
depedencies.

UserCreatable has another aspect in that it is the witness
flag for whether a QOM type is permissible to create using
-object / object_add.

I've periodically wondered if we could make them the same, but
the realize/unrealize phases have significantly more complexity
and dependancies than the complete/prepare_delete and most
notably, 'realize' has a 'bus' parameter.

I think that an approach to unification would end up with the
'Device' class implementing UserCreatable and providing a
'complete' method which in turn called the 'realize' method.
IOW, nothing much would really change in terms of impls, as
all Device subclasses would carry on using realize/unrealize.
It would merely make Device tree available to -object/object_add.
There are probably quite a few edge case problems hiding in
there though if one were to actually try to do this, so the
pragmatic option is really to ignore this all and accept the
different APIs for Device vs non-Device QOM.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


