Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3494C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSHG7-00041X-9F; Fri, 12 Jul 2024 10:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSHG3-0003na-74
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSHG1-0006pM-5A
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720794499;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBvs00NV7QA/bGEpnE2ObZVKglOHtlxUo2DkvUj35k8=;
 b=cR0MIJ5CxB87YdVAedZLJE3v3X43fl0trCSGoHbM4bvFfHRf/8qEEoc78oyStjDHjZIfs5
 FR+kj/uhVj1kCR/AfF3tt+hvw0bBQHeaB7wubwqgEN7o8CV3kfe7C5Cg1NTfLnKLYfMFoA
 cBvlGAswmw0Qjm4Y6G+hh9lqakilJII=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-RTVlqM9nPkGNhcqpoqx0Ew-1; Fri,
 12 Jul 2024 10:28:17 -0400
X-MC-Unique: RTVlqM9nPkGNhcqpoqx0Ew-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD9CD196CDF5; Fri, 12 Jul 2024 14:28:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 334DB3000184; Fri, 12 Jul 2024 14:28:10 +0000 (UTC)
Date: Fri, 12 Jul 2024 15:28:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH 0/8] Convert avocado tests to normal Python unittests
Message-ID: <ZpE9dLXR9gF95TEr@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com> <87jzhsdmd7.fsf@suse.de>
 <68c45f7b-4503-41b5-a858-e93f9dd9f99e@redhat.com>
 <ZpDV-ghgrxb0hvUd@redhat.com> <87y166pu0c.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y166pu0c.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
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

On Fri, Jul 12, 2024 at 03:25:23PM +0100, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Thu, Jul 11, 2024 at 07:44:39PM +0200, Thomas Huth wrote:
> >> On 11/07/2024 16.39, Fabiano Rosas wrote:
> >> > Thomas Huth <thuth@redhat.com> writes:
> >> ...
> >> > > Things that need further attention though:
> >> > > 
> >> > > - All tests that use the LinuxTest / LinuxDistro classes (e.g. based
> >> > >    on cloud-init images) really depend on the Avocado framework,
> >> > >    thus we'd need a solution for those if we want to continue with
> >> > >    this approach
> >> > > 
> >> > > - Same for all tests that require the LinuxSSHMixIn class - we'd
> >> > >    need to provide a solution for ssh-based tests, too.
> >> > 
> >> > These two seem to be dependent mostly avocado/utils only. Those could
> >> > still be used without the whole framework, no? Say we keep importing
> >> > avocado.utils, but run everything from meson, would that make sense?
> >> 
> >> Yes ... maybe ... I can give it a try to see whether that works.
> >
> > We only import about 8 modules from avocado.utils. There are probably a
> > few more indirectly used, but worst case we just clone the bits we need
> > into the QEMU tree.
> 
> Is Avocado still actively developed? I thought you guys used it quite
> widely within RedHat?

Yes it is active:

https://github.com/avocado-framework/avocado/commits/master/

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


