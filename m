Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BA7C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfL1q-0007B9-WC; Tue, 04 Feb 2025 10:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfL1p-0007Az-Ip
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:39:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfL1n-0005aX-Tn
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738683595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/lr7U9XTShzBstG3cCRwh7lSQHBAgYfQgLbXjYotVL0=;
 b=Nmd3han8K7RBxEvf0wTvoFYiaJVWjF6LoVUqXd5ykdOgaIGbCIBon6mjsruJRhzslE5fq+
 HlmrOrnD6OV2yuDXENJ2VzeGRIw72F7Z3YiRFg8wMK5/vWrW/q8lUJLxyVGZoF+LoeacDe
 csOygXGYXiMi1GfPzzi+kgYN70UAVHE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-ojyWvTJ4MfW5JlRegbMOOw-1; Tue, 04 Feb 2025 10:39:53 -0500
X-MC-Unique: ojyWvTJ4MfW5JlRegbMOOw-1
X-Mimecast-MFC-AGG-ID: ojyWvTJ4MfW5JlRegbMOOw
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-467b19b55d6so60838491cf.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738683593; x=1739288393;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/lr7U9XTShzBstG3cCRwh7lSQHBAgYfQgLbXjYotVL0=;
 b=qBZJC9hvdlkrFTcdqTV7TMenTv3honsWdJZXvBj1GyZAgXemuMcQMCskjGekxFkclP
 eJUudU/8ukOjRUDaGl3XR2GdVGJ26gCx1ebFq78bpBhcYuGTHqY/o3VrJoH4gIhbTXnk
 Q2+vGYe89TpgszSTgbSBAUnYKoCT/8FLBOZO5k0W+0xNOAmo50sxe3a65wXXeOry0Gh/
 SZDBNwUEEG88Ysqm6o3rieAX1Q6u5fviK8LhcvQmwEW7dSkZeb0S4Q+BYIQqhEKPz1P7
 MiEKkXVGn0xK8+OMiXsiKGwRSLt0PsgRqcWnyrfb8RCASbC2SvDhLeFweUN1Bc6Mjzwn
 ndCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVudeS2NeogUCyf4BHfwQlCdtkZp7gv4tCL0kVXFOLRZUi1gGnD3xpYZQAXUB8GETUu5/SeLUV1qvZI@nongnu.org
X-Gm-Message-State: AOJu0YzncTFld+NPENssQXtIbU1m9Z9OcHLBG1Zpz0q0K7c/ylhM/aIz
 b395i3mQx77CZv+yiEg3DgZKL7qkwnVwoJOQqhAGId+NTBh3cqeBYYkSOe7BMizOK0vio/aLmpz
 HZ4eb2We5UguGRd1R/YH7ZIKxqR1wL0kPQ7agmEu31jb+ya9bCgvx
X-Gm-Gg: ASbGncvqgiC6SaGxCsV38AH4lHbIZ1splDWbzYAI1GOlz8XwT8gZeqsr/IjsSRdbMRE
 KJtvTe4LapQBEJ9ZbwBemC+jedtEH+Ja9eCKnL1kzXRLKcYVyGbbPAfvPmGTlSFuAAadejV57mn
 ygVniA9oIghV1E/9ZGIXcJA9IMp2OAVrRqQhN6CONQ7I5ZMttiBRet3PAvQsuvChgtiAz5Jv8+j
 Rjm5srJ/JimV16G4Y/y6wA2LsQIgpPWjpkmP8/6fXa0i1P3YYWflg64fDJXeKQkGRjQ3zXwSrxz
 NWeAUX8JxJC8snkUV10Ak1vW9mNckdNXl+6g+13Z0VHzD7+X
X-Received: by 2002:ac8:7f53:0:b0:467:7725:8b69 with SMTP id
 d75a77b69052e-46fd0b67d83mr358776891cf.40.1738683593302; 
 Tue, 04 Feb 2025 07:39:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJAPPX5ir/iZ8LOh9PFtSoPOgQVqxBTIILP0/5kjUnPAiq0yf/e7i39xrobLX2ZNnvKrREHA==
X-Received: by 2002:ac8:7f53:0:b0:467:7725:8b69 with SMTP id
 d75a77b69052e-46fd0b67d83mr358776641cf.40.1738683592992; 
 Tue, 04 Feb 2025 07:39:52 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0a73fesm60366391cf.16.2025.02.04.07.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 07:39:52 -0800 (PST)
Date: Tue, 4 Feb 2025 10:39:51 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 09/33] migration: postcopy_ram_listen_thread() needs
 to take BQL for some calls
Message-ID: <Z6I0x0hVc-6f1-v4@x1.local>
References: <Z57TPqhRYY4V14BE@gallifrey>
 <d3a27b10-a7a6-4aa6-97ad-9c39f49df4fc@maciej.szmigiero.name>
 <Z59o4u9zui3CPrkm@gallifrey>
 <fafbc505-acee-408e-a2ef-0a62bd30689b@maciej.szmigiero.name>
 <Z6Ef3iwQs7JSFY3c@x1.local>
 <afb27de1-d20a-4b0d-b271-ef6eef0e06ed@maciej.szmigiero.name>
 <Z6Eow-Ei3CvLy1vG@x1.local>
 <af219c2f-5cbe-4107-a35c-26bb0e2be1a4@maciej.szmigiero.name>
 <Z6FK_4p24OjCziOF@x1.local>
 <27e3cb26-43e0-4505-84da-865c79af680a@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27e3cb26-43e0-4505-84da-865c79af680a@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 04, 2025 at 03:57:37PM +0100, Maciej S. Szmigiero wrote:
> The vfio_migration_cleanup() used to just close a migration FD, while
> RAM might end up calling qemu_ram_msync(), which sounds like something
> that should be called under BQL.
> 
> But I am not sure whether that lack of BQL around qemu_ram_msync()
> actually causes problems.

I believe msync() is thread-safe.  So that doesn't need BQL, AFAICT.

Personally I actually prefer not having the BQL requirement if ever
possible in any vmstate hooks.

I think the only challenge here is if VFIO will start to need BQL for some
specific code path that you added in this series, it means VFIO needs to
detect bql_locked() to make sure it won't deadlock.. and only take BQL if
it's not taken.

From that POV, it might be easier for you to define that hook as "always do
cleanup() with BQL" globally, just to avoid one bql_locked() usage in vfio
specific hook.  We pay that with slow RAM sync in corner cases like pmem
that could potentially block VM from making progress (e.g. vcpu
concurrently accessing MMIO regions).

Thanks,

-- 
Peter Xu


