Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636E9C47BE0
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 10:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd4Qz-0004sl-HT; Tue, 06 Jan 2026 05:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vd4Qw-0004rR-OT
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 05:37:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vd4Qu-0005Qp-QW
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 05:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767695818;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=scbGoCiGuXqnVAnFisQnAT8pgOMnEQNLFv8NMO2gxR8=;
 b=fElHzRCaUkjDCR2k7nXPtD2k8CejplwD2hS2yQUAIL8QPaIn6rBGfixjsItxDwxvYu9XQJ
 pCWF07pzhGQ7I6jAGGMgH1N0QR+RKXHhboEsE+1UQiy6UEHmnJIgkqDu1C2ZFUeLMSkZtj
 ylEAQbBKNERcTJzMy9x5ksf2Q38YhZM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-uPojwUPnNgC4Z-XHTLPPUw-1; Tue,
 06 Jan 2026 05:36:56 -0500
X-MC-Unique: uPojwUPnNgC4Z-XHTLPPUw-1
X-Mimecast-MFC-AGG-ID: uPojwUPnNgC4Z-XHTLPPUw_1767695816
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEA48195605A; Tue,  6 Jan 2026 10:36:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.217])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6A761800577; Tue,  6 Jan 2026 10:36:53 +0000 (UTC)
Date: Tue, 6 Jan 2026 10:36:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/2] docs/interop/firmware: Introduce extended syntax for
 FirmwareMappingMemory
Message-ID: <aVzliFd70KWKcMJR@redhat.com>
References: <20251228232649.1708400-1-abologna@redhat.com>
 <20251228232649.1708400-3-abologna@redhat.com>
 <aVvNV0X0uZ4lVBWv@redhat.com>
 <aVzbqk5FSrG9rSuM@dobby.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aVzbqk5FSrG9rSuM@dobby.home.kraxel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 06, 2026 at 11:13:33AM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > IMHO we could add merely a new "uefi-vars-service" such that it looks
> > like this:
> > 
> >      {
> >          "mapping: {
> >              "device": "memory",
> >              "filename": "/path/to/firmware.bin",
> > 	     "uefi-vars-service": {
> > 	       "template": "/path/to/firmware.json",
> > 	     }
> >          }
> >      }
> 
> I'm wondering whenever it makes sense to put this into the firmware
> description at all?  The reason this is done for flash images is that
> code and vars can not be matched freely.  This is simply not the case
> with host-managed variable stores.

True, though our schema of course allows us to list the exact same
json file against multiple firmware binaries. The more significant
problem is probably in the opposite direction - there are can
arbitrarily many json vars files that are valid for use with any
single firmware binary. This would require us to have multiple
firmware descriptors pointing to the same binary, each with a
differnt json file. Essentially the descriptors need to define
the combinatorial expansion of firmware + json files, and this
feels like it is getting a bit silly.

> Maybe have separate json files describing the variable store template
> only, and expect libvirt searching for one in case the firmware
> descriptor has the 'host-uefi-vars' feature flag set?

Or just have the host-uefi-vars feature flag alone, and then libvirt
can just invoke virt-firmware in whatever way it needs to create the
json templates and not worry about providing any pre-defined json
files.  All the default microsoft CAs are ultimately embedded in
virt-firmware and spat out when given the right args.

If libvirt doesn't want to run  virt-firmware every time, libvirt
could cache some common templates itself.

> Many fields of the firmware descriptor format continue to make sense
> in that case.  Description obviously.  Architecture too (the dbx
> revocation list is arch specific, so x86 / arm need different
> templates).  Also some features, specifically 'enrolled-keys'.
> 
> For the template filename we could use mapping->device = 'hostvars' with
> mapping->filenname (somewhat quirky), or simply replace mapping with
> something else.
> 
> I think this also fits better with the long-term plan that libvirt can
> generate distro-specific variable stores based on libosinfo information
> instead of using some template file.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


