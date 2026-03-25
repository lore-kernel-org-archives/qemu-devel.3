Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3A3FEA83A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 09:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5KNo-0003XE-2h; Wed, 25 Mar 2026 05:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w5KNi-0003Wk-4l
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 05:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w5KNe-0004El-AO
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 05:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774430304;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=q7odQe46fSul21qNLzBEjCx3OlL08F4B8HH7byekOM4=;
 b=V7SCXpXfdmqIPpUkTVnfFcs489EKUrTO6n0mmyDkEmjBMKm9IWqTwFAM3zlWMcMlFgJTUs
 WmjQ6z9r6I3S74S/gMvDqzRhOcqAgdsjKzlvgK1xLq1bzH6wPgbYuBBMavkLTjGMYtHavb
 mhs3GxP2Lif3gm3vVK5ufnlbENUkuxw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-8EFFFxqSOVO2Km7Zhivi6Q-1; Wed,
 25 Mar 2026 05:18:21 -0400
X-MC-Unique: 8EFFFxqSOVO2Km7Zhivi6Q-1
X-Mimecast-MFC-AGG-ID: 8EFFFxqSOVO2Km7Zhivi6Q_1774430300
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D61541800763; Wed, 25 Mar 2026 09:18:19 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2A141800107; Wed, 25 Mar 2026 09:18:16 +0000 (UTC)
Date: Wed, 25 Mar 2026 09:18:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Development <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: QEMU requires a 64-bit CPU host architecture?
Message-ID: <acOoVWw3jXfkfion@redhat.com>
References: <2c0d6ae0-eb06-4eed-87fe-0954ae59d951@tls.msk.ru>
 <fc32bb67-ea52-4244-9ad7-c18db3be339e@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc32bb67-ea52-4244-9ad7-c18db3be339e@tls.msk.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Wed, Mar 25, 2026 at 11:08:41AM +0300, Michael Tokarev wrote:
> On 20.03.2026 09:45, Michael Tokarev wrote:
> > Hi!
> > 
> > Is it intentional that qemu does not build utilities on 32bit hosts
> > anymore?
> 
> This is
> 
> commit 372ec46b9f1215f48a4717f2b7ed969f65bfadc6
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Thu Dec 18 09:56:27 2025 +1100
> 
>     meson: Reject 32-bit hosts
> 
>     32-bit hosts have been deprecated since 10.0.
> 
> How would one build qemu-img and especially qemu-guest-agent, say,
> on i386 or armhf?
> 
> I tried removing this error message from meson.build (in $subject),
> but it fails to build even the qga due to errors in atomic.h, -
> even if these aren't used by qga.
> 
> That smells like a bad decision, - to drop qga and qemu-img support
> on 32bit architectures.  Especially qga.

IMHO dropping the block related tools is reasonable, as if you keep
that, the dependencies that need to remain 32-bit compatible ripple
out across a very large part of the codebase.

Not having qga though feels like a pretty undesirable consequence,
given our message overall is that we were dropping host support but
keeping 32-bit emulation.

IMHO, the qga probably ought to be a separate project, but it has
a core dependancy on the QAPI code generator, and some of the related
shared C code (qobject/, qapi/ and some parts of util/), but even that
is quite a tangled web of deps.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


