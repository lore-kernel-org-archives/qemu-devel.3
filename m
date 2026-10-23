Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE0D606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P3WBgI2j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKCOS-0000od-Gz; Fri, 23 Oct 2026 06:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xKCOR-0000oT-71
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 06:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xKCOP-0004aP-6S
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 06:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792750855;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=UMBFXq+G0YQMy58Yz/izyom/SBj/bU1W9hVaC0yfuMQ=;
 b=P3WBgI2jAyEu+lTiCwwOItql6wV7LbE6J1I7t83lFPkVkKx0G96nWdnrxx9EiKZIIpOHaW
 ufyqX8yoMg5N0YGBUpmby5icTz89DCsmv6NwKmdnqsCy8+5NaaT5oZXbnjnZOQpXnVXBk0
 8TjqOawJy6FciRwAPgWEeouqYuFfS0s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-6YkwwYFkOAmMYb3Wne4G_g-1; Fri,
 23 Oct 2026 06:20:51 -0400
X-MC-Unique: 6YkwwYFkOAmMYb3Wne4G_g-1
X-Mimecast-MFC-AGG-ID: 6YkwwYFkOAmMYb3Wne4G_g_1792750851
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C629D180059B; Fri, 23 Oct 2026 10:20:50 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 972F6195608C; Fri, 23 Oct 2026 10:20:48 +0000 (UTC)
Date: Fri, 23 Oct 2026 11:20:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: qemu-system-x86_64 appears to have sgx-epc, but not
 memory-backend-epc
Message-ID: <ats0_RfeVugAofN9@redhat.com>
References: <87zew5j3iv.fsf@pond.sub.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zew5j3iv.fsf@pond.sub.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 22, 2026 at 02:58:16PM +0200, Markus Armbruster wrote:
> My build of qemu-system-x86_64 has device sgx-epc:
> 
>  --> {"execute": "qom-list-types", "arguments": {"implements": "sgx-epc"}}
>  <-- {"return": [{"name": "sgx-epc", "parent": "device"}]}
> 
> The device as a link property to a memory-backend-epc:
> 
>  --> {"execute": "qom-list-properties", "arguments": {"typename": "sgx-epc"}}
>  <-- {"return": [...
>                  {"name": "memdev", "type": "link<memory-backend-epc>"},
>                  ...]}
> 
> However, type memory-backend-epc does not exist:
> 
>  --> {"execute": "qom-list-types", "arguments": {"implements": "memory-backend"}}
>  <-- {"return": [{"name": "memory-backend-ram", "parent": "memory-backend"}, {"name": "memory-backend-file", "parent": "memory-backend"}, {"name": "memory-backend-memfd", "parent": "memory-backend"}, {"name": "memory-backend-shm", "parent": "memory-backend"}]}

There is some rather dubious code that conditionally registers
the type

static void register_types(void)
{
    int fd = qemu_open_old("/dev/sgx_vepc", O_RDWR);
    if (fd >= 0) {
        close(fd);

        type_register_static(&sgx_epc_backed_info);
    }
}


Normal practice is for types to be unconditionally registered.  Do we
have any examples outside of this SGX case where we conditionally
register types ?   Should we change this to follow normal practice ?

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


