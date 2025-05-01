Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092D6C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWos-0004VA-Ir; Thu, 01 May 2025 12:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uAWoq-0004QX-2W
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uAWon-0004z2-4p
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746117082;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7qifL0tV2GYCww7HQklvIonh8Wf0PjOQlTbapNHsGQ=;
 b=R3m9bEoSxri7kbyGZkBFtaU1JIyPtLJ1x0PKJ7Dkd8vgB2w3bCWEJNNp9lee0jDjUldQcF
 nDkwuNs/j0hH8dlqrejqSPAij5dSbzMrYaOu+jq3yopPXjrDRUoYZizVKZyuL2KArM88CC
 tykRJZvBbxoa5HfIgu3erfLrCDdnj0A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-HGtr1OvfN9y60eWPPOeaQQ-1; Thu,
 01 May 2025 12:31:19 -0400
X-MC-Unique: HGtr1OvfN9y60eWPPOeaQQ-1
X-Mimecast-MFC-AGG-ID: HGtr1OvfN9y60eWPPOeaQQ_1746117078
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E25F419560B4; Thu,  1 May 2025 16:31:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.167])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 409E3180087B; Thu,  1 May 2025 16:31:16 +0000 (UTC)
Date: Thu, 1 May 2025 17:31:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 "Hajnoczi, Stefan" <stefanha@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Subject: Re: OSUOSL in trouble
Message-ID: <aBOh0eMEaVsR5py_@redhat.com>
References: <CABgObfa-ViHvve=oqV-Y88ghXGkevu1wTug=+24E4dKuG54c3Q@mail.gmail.com>
 <CAJSP0QVpxQDfuBOQiMyP41ufaJ=56Xh2sRhWSON=FvVuxDabaw@mail.gmail.com>
 <aBOYZsfT0retojQf@redhat.com>
 <CABgObfa9O6V00H9Z7iawvUZWvXqQkj2XsdXejPW0tjXb_a7Erg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfa9O6V00H9Z7iawvUZWvXqQkj2XsdXejPW0tjXb_a7Erg@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 01, 2025 at 06:20:50PM +0200, Paolo Bonzini wrote:
> Il gio 1 mag 2025, 17:51 Daniel P. Berrangé <berrange@redhat.com> ha
> scritto:
> 
> > > Paolo, please let me know how I can help with migrating VMs or setting
> > up a
> > > CI Kubernetes cluster on Amazon.
> >
> 
> Since in the past Camilla did it but I am not sure if she has bandwidth,
> let's run it with Red Hat first. All I did was give her admin privileges on
> Azure.
> 
> In the meanwhile I will start migrating the VMs.
> 
> Please ensure the any new CI machines for gitlab have persistent cache
> > enabled. Our functional test jobs are still downloading images on every
> > run due to lack of configured cache, which makes them unreliable when
> > sites have transient outages, as well as making jobs slower.
> >
> 
> Thanks for the suggestion—just to be clear do the Azure runners have that?

I'm unclear - what I can say is that whatever runners are currently
being used always appear to start with an empty cache, as in the log:

https://gitlab.com/qemu-project/qemu/-/jobs/9853814057

We see countless messages

  Downloading http://ftpmirror.your.org/pub/misc/ftp.software.ibm.com/rs6000/firmware/7020-40p/P12H0456.IMG to /builds/qemu-project/qemu/functional-cache/download/d957f79c73f760d1455d2286fcd901ed6d06167320eb73511b478a939be25b3f...

and in both the restore/save of cache gitlab reports:

   "No URL provided, cache will not be uploaded to shared cache server.
    Cache will be stored only locally. "

which makes me think, if there is a cache, then it is local to the
build env and getting thrown away at the end of the job

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


