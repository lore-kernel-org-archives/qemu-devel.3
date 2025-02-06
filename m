Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A70CC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyJB-00035p-EJ; Thu, 06 Feb 2025 04:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfyIp-0002pU-5R
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:36:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfyIk-0007vN-J7
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738834562;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JP2ypGuBJ6Esaewxv7uznPdLYXadsJLRzQ8B1oXABw4=;
 b=ENKk2L+F0lwzalGQ9rOieQjlmcy8GRskddaC0gjsAlNI+w2pF/jSfON2ZJRyW7KLd20mka
 tTPsP1cK4Y/Qeb2i+pLHYb5eFqnxIEQa0Yb59l7oSDJDDO4sG9MHQ2KaoHklnj4Hp3Ia/x
 Q+g2P5PFBTmjgEAoKJTvGWZikETZfOY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-M34ZRRMZPEulRf08eWx3xw-1; Thu,
 06 Feb 2025 04:35:59 -0500
X-MC-Unique: M34ZRRMZPEulRf08eWx3xw-1
X-Mimecast-MFC-AGG-ID: M34ZRRMZPEulRf08eWx3xw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8209F1956096; Thu,  6 Feb 2025 09:35:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.33])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A75B19560A3; Thu,  6 Feb 2025 09:35:57 +0000 (UTC)
Date: Thu, 6 Feb 2025 09:35:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 5/5] tests/functional: skip mem addr test on 32-bit hosts
Message-ID: <Z6SCeWUMuhUa5zGG@redhat.com>
References: <20250205155946.2811296-1-berrange@redhat.com>
 <20250205155946.2811296-6-berrange@redhat.com>
 <18acac8d-271a-4641-893e-93096f31a2ac@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18acac8d-271a-4641-893e-93096f31a2ac@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

On Wed, Feb 05, 2025 at 10:24:08AM -0800, Richard Henderson wrote:
> On 2/5/25 07:59, Daniel P. Berrangé wrote:
> > +
> > +'''
> > +Decorator to skip execution of a test on 32-bit targets
> > +Example:
> > +
> > +  @skipIf32BitTarget()
> > +'''
> > +def skipIf32BitTarget():
> > +    enoughBits = sys.maxsize > 2**32
> 
> This will work for true 32-bit hosts, and possibly for containers running
> emulation, but it won't work for cross-compilation (x86_64 to i686 or
> aarch64 to arm).
> 
> Perhaps "file qemu-system-foo" | grep "ELF 32-bit" ?
> I don't know that we've actually selected the executable at this point though...

The QEMU_TEST_QEMU_BINARY env variable exists at all times, though
grepping for ELF format feels a bit icky.

We also know the location of the build directory, so was wondering if
anything there tells us whether the host target is 64-bit, but it
appears not be the case.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


