Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD14C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 17:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc6vt-00006L-GL; Thu, 08 Aug 2024 13:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc6vq-00005N-CQ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 13:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc6vo-0008O6-OZ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 13:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723138086;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HsDM9zIjcOOpaOStoqoyWgOIl+BRi1e48VyBD1+qw4Y=;
 b=OL4aqaQ9q/5RIWgAoBkJD/Gfk3wHHmroumbFpJ+5MMOYC67N3fQgN665lASrZc9PzfgyGA
 YAwYtdHjCrLMwNE8RtuIUtF+8sNEk6DCIcqj5PX3rjEjQgVjPGjbdGGXWqFbFORu97UkFk
 4orYUxWPMw6d/pHQuYtgVlktJEhNXuw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-tUSRnLS1NOCiNKX_i5IkOg-1; Thu,
 08 Aug 2024 13:28:04 -0400
X-MC-Unique: tUSRnLS1NOCiNKX_i5IkOg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE8F8195608D; Thu,  8 Aug 2024 17:28:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.163])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E05F19560A3; Thu,  8 Aug 2024 17:28:02 +0000 (UTC)
Date: Thu, 8 Aug 2024 18:27:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yusuf said =?utf-8?B?w4dvbGFr?= <yusuf.colak3406@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: bug?
Message-ID: <ZrUAHpntjH4N38DZ@redhat.com>
References: <CANwC2_Tph=P2Ho-nm-x5C8wkbz5NX=PXDA5GvuP9cf08Gscrxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANwC2_Tph=P2Ho-nm-x5C8wkbz5NX=PXDA5GvuP9cf08Gscrxw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 08, 2024 at 03:41:46PM +0000, Yusuf said Çolak wrote:
> I installed qemu successfully and downloaded emulator you published on
> github, i runned
> 
> mkdir buildcd build
> 
> but if i run ../configure it gives ;
> 
> 
> 
> 
> ERROR: missing GIT submodules
> This is not a GIT checkout but module content appears to
> be missing. Do not use 'git archive' or GitHub download links
> to acquire QEMU source archives. Non-GIT builds are only
> supported with source archives linked from:
> 
>   https://www.qemu.org/download/#source
> 
> Developers working with GIT can use scripts/archive-source.sh
> if they need to create valid source archives.
> 
> can you help me with this?

Err, the error message above tells you what to do. Get the source release
tarballs from https://www.qemu.org/download/#source, not from github
which generates incomplete tarballs.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


