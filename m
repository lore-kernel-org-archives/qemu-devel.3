Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA4606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ap2sgfkm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKD8E-0002ap-GA; Fri, 23 Oct 2026 07:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xKD8B-0002aU-Mo
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xKD89-0002p3-Jb
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792753691;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlrj6VqUo1KDxsybJzMjxUc7Hrbb/9znxnQsgc/Q5pU=;
 b=Ap2sgfkmiOTFjC73CNIe12b2za14EIifQQYmrrpeSlb8ZOrmlEpuFn3H6qXpt4GAsS7VoT
 mq9O3iBQkDMqZsg2da/FG8IqurlgICY3t8Yy6ib8uQ/pTlLk91G7jGwXQJH9lnaKZE0axq
 i1qlAzsxhUkJVJwLbWi9oDuGjRhFVJ8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-Wvrh10ELNGKG7V6-KrxN9A-1; Fri,
 23 Oct 2026 07:08:00 -0400
X-MC-Unique: Wvrh10ELNGKG7V6-KrxN9A-1
X-Mimecast-MFC-AGG-ID: Wvrh10ELNGKG7V6-KrxN9A_1792753679
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 325B81801352; Fri, 23 Oct 2026 11:07:59 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C18833000723; Fri, 23 Oct 2026 11:07:56 +0000 (UTC)
Date: Fri, 23 Oct 2026 12:07:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: qemu-system-x86_64 appears to have sgx-epc, but not
 memory-backend-epc
Message-ID: <attACqgQQ-Lxt5Pj@redhat.com>
References: <87zew5j3iv.fsf@pond.sub.org> <ats0_RfeVugAofN9@redhat.com>
 <CAFEAcA_wabjzp0KF69-ay75QoOk=jE-TygrD-T-b60dw1iOs=g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_wabjzp0KF69-ay75QoOk=jE-TygrD-T-b60dw1iOs=g@mail.gmail.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 23, 2026 at 11:44:10AM +0100, Peter Maydell wrote:
> On Fri, 23 Oct 2026 at 11:21, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Thu, Oct 22, 2026 at 02:58:16PM +0200, Markus Armbruster wrote:
> > > My build of qemu-system-x86_64 has device sgx-epc:
> > >
> > >  --> {"execute": "qom-list-types", "arguments": {"implements": "sgx-epc"}}
> > >  <-- {"return": [{"name": "sgx-epc", "parent": "device"}]}
> > >
> > > The device as a link property to a memory-backend-epc:
> > >
> > >  --> {"execute": "qom-list-properties", "arguments": {"typename": "sgx-epc"}}
> > >  <-- {"return": [...
> > >                  {"name": "memdev", "type": "link<memory-backend-epc>"},
> > >                  ...]}
> > >
> > > However, type memory-backend-epc does not exist:
> 
> > There is some rather dubious code that conditionally registers
> > the type
> >
> > static void register_types(void)
> > {
> >     int fd = qemu_open_old("/dev/sgx_vepc", O_RDWR);
> >     if (fd >= 0) {
> >         close(fd);
> >
> >         type_register_static(&sgx_epc_backed_info);
> >     }
> > }
> >
> >
> > Normal practice is for types to be unconditionally registered.  Do we
> > have any examples outside of this SGX case where we conditionally
> > register types ?   Should we change this to follow normal practice ?
> 
> TYPE_MEMORY_BACKEND_MEMFD does the same. I did a quick grep for
> "calls to type_register not indented by exactly 4 spaces" and
> I think the other cases are "misindented" or "data-driven
> type registration" rather than trying to do things conditionally
> (but I didn't actually look at all of them, instead making
> guesses based on variable names, so maybe there's one or two
> more I missed).
> 
> I guess maybe this is trying to work around the fact that the
> memory backend API doesn't give a backend any place to say
> "this is never going to work" early, because instance_init isn't
> allowed to fail, these objects aren't TYPE_DEVICE so they
> don't have "realize", and so the only other option is
> "fail every alloc call" ?

The memory backends are all implementing the UserCreatable
interface, which provides a "complete" method where they
could gracefully report lack of the feature via 'errp'.

This is not obvious since UserCreatable is implemented in
the parent base class, but the subclasses could provide
their own  'complete' impl and chain up the parent impl

m
With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


