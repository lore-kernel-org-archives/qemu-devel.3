Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B18C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqX9b-0003Fz-VS; Fri, 07 Mar 2025 07:50:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tqX9a-0003Fg-08
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:50:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tqX9X-0007oI-Ut
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741351811;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cgV/pvMnRUZe3L0K1px6mUMs3Y2qJX8dFvbLZsIPMG8=;
 b=Pz1O511DDTOjgyj/3EnwFOFhgPRpESYbKpXBYbfXVG5gGXbVlTFZzd4uRBP0RJ1Yk2bikE
 dCgD1oD54G8nEh7h36V+uGoO2pSi4CW83HdUesVHsAi+S/IOYY37n9FWG2vxftHXrPEE+6
 wlobEqKO/BjcZN5N7pxnVBqftu8+RKs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-rEC5AfvEPDKUn5G-Tvwjew-1; Fri,
 07 Mar 2025 07:50:07 -0500
X-MC-Unique: rEC5AfvEPDKUn5G-Tvwjew-1
X-Mimecast-MFC-AGG-ID: rEC5AfvEPDKUn5G-Tvwjew_1741351806
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CABDB180035E; Fri,  7 Mar 2025 12:50:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB00718009AE; Fri,  7 Mar 2025 12:50:02 +0000 (UTC)
Date: Fri, 7 Mar 2025 12:49:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: Re: New git repository for Go bindings
Message-ID: <Z8rrd8DoLUVh_Je1@redhat.com>
References: <xu3qsijvpbguwdnlj6ovomlkd2wggd76x2lvfusmczljhnmx4f@kgw6di2754ta>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xu3qsijvpbguwdnlj6ovomlkd2wggd76x2lvfusmczljhnmx4f@kgw6di2754ta>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 07, 2025 at 01:30:38PM +0100, Victor Toso wrote:
> Hi,
> 
> I've been working on and off in having Go bindings for QEMU's
> QAPI specification. The last version [0] seems to be accepted so
> far but we would like not to have that in qemu.git.
> 
> In the past [1], Daniel suggested creating a repo per each
> generated schema: go-qemu.git, go-qga.git, go-qsd.git
>
> While that works well from the point of view of Go applications
> and is neat organized too, afaict they are all bounded to QEMU's
> release schedule so it might be enough to create a single repo
> such as:
> 
> qapi-generators.git
> └── golang
>     ├── module.py # The go generator
>     ├── qemu      # For qapi/qapi-schema.json
>     │   ├── doc.go
>     │   ├── gen_iface_command.go
>     │   ├── gen_iface_event.go
>     │   ├── gen_type_alternate.go
>     │   ├── gen_type_command.go
>     │   ├── gen_type_enum.go
>     │   ├── gen_type_event.go
>     │   ├── gen_type_struct.go
>     │   ├── gen_type_union.go
>     │   ├── go.mod
>     │   ├── protocol.go
>     │   └── utils.go
>     ├── qga # qga/qapi-schema.json
>     └── qsd # storage-daemon/qapi/qapi-schema.json
> 
> Or perhaps a per language repo?

I'd suggest we keep the repo dedicated just for 'go' language, as mixed
language repos are more trouble than they are worth when it comes to
dealing with language specific build tools.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


