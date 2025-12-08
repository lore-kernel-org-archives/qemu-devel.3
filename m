Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3F6D3B7DD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 09:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSXHh-0000ww-ON; Mon, 08 Dec 2025 04:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vSXHg-0000w6-1S
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:11:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vSXHe-0000kU-96
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765185112;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S5ZHQX8XjV0q7JDoSVFnVIDa3CAkVKa0BPMd1Ujjs/M=;
 b=bpDkdb3rgoyn7k56B4gKDX4QfZ43yJrtU5JEYTsXq8UQ/xvV5lMTDk0j+TXeux5xc6yObG
 DKcVOVaTOvHkM2vaKTLE7NJ1NcU0JSPAoFdVJyo3mnyXwEI/zgmRL0ovUBTUbs7PjMrYK3
 MwQD46g5OZnAe7YV2AQsiMXJGB4gZCs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-r9kCaY2UNGmmtR9feyWXxQ-1; Mon,
 08 Dec 2025 04:11:49 -0500
X-MC-Unique: r9kCaY2UNGmmtR9feyWXxQ-1
X-Mimecast-MFC-AGG-ID: r9kCaY2UNGmmtR9feyWXxQ_1765185108
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1EC318002C0; Mon,  8 Dec 2025 09:11:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AF7019560B0; Mon,  8 Dec 2025 09:11:43 +0000 (UTC)
Date: Mon, 8 Dec 2025 09:11:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 05/11] tests/lcitool: add nettle to the minimal deps
Message-ID: <aTaWTJTWcAXO11Mc@redhat.com>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
 <20251204194902.1340008-6-alex.bennee@linaro.org>
 <f077e5e1-53b7-42d8-b457-90fdf775c71b@redhat.com>
 <87a4zxrt5y.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a4zxrt5y.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Dec 05, 2025 at 12:48:25PM +0000, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
> > On 04/12/2025 20.48, Alex Bennée wrote:
> >> Technically we don't need a crypto library to do the base build but
> >> I couldn't see an easy way to skip iotests which would otherwise fail.
> >> Besides libnettle is a fairly small library even if its not the
> >> fastest crypto implementation.
> >
> > I think we added checks to some of the iotests in the past already to
> > skip if the crypto stuff is not available? So I think it might be
> > better to fix the related iotests instead.

We have _require_working_luks called by "_supported_fmt luks"
in the shell tests, and iotests.verify_working_luks called
in the python tests. Possibly we didn't call them in all the
required places ? Or there is a non-luks related test that
uses crypto we missed ?

> >
> > Which test is failing for you?
> 
> I did have 049 qcow failing and two others but I can't remember exactly
> which combo it was. The error messages where all about missing crypto
> functions stopping the run.
> 
> Where are the crypto library tests done? I couldn't find them.
> 
> But I'm happy to drop this patch until we find out:
> 
>   https://gitlab.com/stsquad/qemu/-/pipelines/2197896632

Is that the right pipeline ?  I'm not seeing crypto failures
in any of the 8 failed jobs in that pipeline, unless I missed
it in the noise of one of them.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


