Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AD0606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b+f4+oe2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRWqu-0008Dg-Vj; Thu, 12 Nov 2026 10:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRWqt-0008DW-V9
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 10:36:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRWqs-0004rg-9L
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 10:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794497796;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x8TXOEXmaW9K1AJb3cPwwPBA5pOTDyzgfADmbBgqv1c=;
 b=b+f4+oe2x6qF7z4gyuaFFJVwtMcrna0xwOYZftUK8lbYaDU0iw01W7WP+WOEaylKNVEQEg
 0ooCINoKDyOv1EmIqLROA9nJIpZeeaDBM79XEtxkqXnf3tHMeZzq6Xzk/EllC1YRc4f1+5
 ohWqE5/ywrbrVMlTbBdZaWnxV7KY5pI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-zUOA96OVPcG213oUcSheXw-1; Thu,
 12 Nov 2026 10:36:32 -0500
X-MC-Unique: zUOA96OVPcG213oUcSheXw-1
X-Mimecast-MFC-AGG-ID: zUOA96OVPcG213oUcSheXw_1794497791
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C87F195606A; Thu, 12 Nov 2026 15:36:31 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9004230000E5; Thu, 12 Nov 2026 15:36:28 +0000 (UTC)
Date: Thu, 12 Nov 2026 15:36:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: qemu-system-x86_64 appears to have sgx-epc, but not
 memory-backend-epc
Message-ID: <avXc-Zy8bHroXtTm@redhat.com>
References: <87zew5j3iv.fsf@pond.sub.org> <ats0_RfeVugAofN9@redhat.com>
 <87qzgu2i45.fsf@pond.sub.org> <87wlqiqm8y.fsf@pond.sub.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wlqiqm8y.fsf@pond.sub.org>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 01:15:25PM +0100, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> [...]
> 
> >> Normal practice is for types to be unconditionally registered.  Do we
> >> have any examples outside of this SGX case where we conditionally
> >> register types ?   Should we change this to follow normal practice ?
> >
> > Loosely related: conditional *class* properties.  Example:
> >
> >     static void
> >     memfd_backend_class_init(ObjectClass *oc, const void *data)
> >     {
> >         HostMemoryBackendClass *bc = MEMORY_BACKEND_CLASS(oc);
> >
> >         bc->alloc = memfd_backend_memory_alloc;
> >
> >         if (qemu_memfd_check(MFD_HUGETLB)) {
> >             object_class_property_add_bool(oc, "hugetlb",
> >                                            memfd_backend_get_hugetlb,
> >                                            memfd_backend_set_hugetlb);
> >             object_class_property_set_description(oc, "hugetlb",
> >                                                   "Use huge pages");
> >             object_class_property_add(oc, "hugetlbsize", "uint64",
> >                                       &uint64_type_info,
> >                                       memfd_backend_get_hugetlbsize,
> >                                       memfd_backend_set_hugetlbsize,
> >                                       NULL, NULL);
> >             object_class_property_set_description(oc, "hugetlbsize",
> >                                                   "Huge pages size (ex: 2M, 1G)");
> >         }
> >
> >         [...]
> >     }
> >
> > These properties are also declared in qapi/qom.json if CONFIG_LINUX.
> > QAPI introspection (query-qmp-schema) shows them then.  QOM
> > introspection (qom-list-properties etc.) only shows them when the
> > MFD_HUGETLB check succeeded.
> >
> > Feels undesirable to me.
> 
> [...]
> 
> Conditional turned out to be unnecessary here:
> 
>     Subject: [PATCH 7/7] backends/hostmem-memfd: Add huge TLB properties unconditionally
>     Date: Wed, 11 Nov 2026 13:23:42 +0100
>     Message-ID: <20261111122342.634370-8-armbru@redhat.com>
> 
> I found a few more:
> 
> * Property "loadparm" of scsi-cd, scsi-hd, virtio-blk-pci,
>   virtio-net-pci only if target_s390x()
> 
> * Several properties of xenpvh-machine on ARM and i386 only if
>   ->has_virtio_mmio, ->has_pci, ->has_tpm
> 
> I don't plan to examine these.

The 'loadparm' issue is one that we need to fix for the multi-target
work. We need a unified QOM tree that is invariant across targets,
so that property should become unconditional. Checks for invalid
usage must be done at realize() time instead.

Yonggang had some patches for this which I've included  in a proposed
series I just CC'd you on:

  https://lists.gnu.org/archive/html/qemu-devel/2026-11/msg02739.html
  https://lists.gnu.org/archive/html/qemu-devel/2026-11/msg02740.html

and 'virtio-mem' was another example

  https://lists.gnu.org/archive/html/qemu-devel/2026-11/msg02750.html

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


