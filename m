Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95BFC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 14:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVtoU-0002GY-6H; Mon, 22 Jul 2024 10:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sVtoS-0002B3-QF
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sVtoQ-00024i-4Y
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721657688;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YH2HdWk31OF/j29uTTroj2mPTh75IVMdYHocGe8eFhI=;
 b=Ixpkh2np59xV0mnDTDZv4OtXOxvbb/aZDDMm7iUSoexI7pd0Oe/qM011w4EkWiaHFh1SQU
 cWbPBKMci3tTPzk6kdfmk+jcK0xaF3XsQDvD+wHxMyGS1eOEGDJKLzH9BSb8z5y/OI9GYr
 FVWDbdoQYDqTXQRjFzhnYToDpMkcjUg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-wkFxgSLrPBaazEBCECz0EQ-1; Mon,
 22 Jul 2024 10:14:46 -0400
X-MC-Unique: wkFxgSLrPBaazEBCECz0EQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D4CD19560A1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:14:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA4E51955D44; Mon, 22 Jul 2024 14:14:43 +0000 (UTC)
Date: Mon, 22 Jul 2024 15:14:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH for-9.0] qapi: drop unused
 QCryptoBlockCreateOptionsLUKS.detached-header
Message-ID: <Zp5pUDQhOc150ts_@redhat.com>
References: <20240319153908.194975-1-berrange@redhat.com>
 <87jzlyyzo0.fsf@pond.sub.org> <Zp5YICB4dCjh3e-X@redhat.com>
 <8734o134gv.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734o134gv.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 22, 2024 at 04:07:28PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Mar 19, 2024 at 05:06:07PM +0100, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > The 'detached-header' field in QCryptoBlockCreateOptionsLUKS
> >> > was left over from earlier patch iterations.
> >> >
> >> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >> > ---
> >> >  qapi/crypto.json | 5 +----
> >> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >> >
> >> > diff --git a/qapi/crypto.json b/qapi/crypto.json
> >> > index 931c88e688..ad9e3d0297 100644
> >> > --- a/qapi/crypto.json
> >> > +++ b/qapi/crypto.json
> >> > @@ -226,8 +226,6 @@
> >> >  # @iter-time: number of milliseconds to spend in PBKDF passphrase
> >> >  #     processing.  Currently defaults to 2000. (since 2.8)
> >> >  #
> >> > -# @detached-header: create a detached LUKS header. (since 9.0)
> >> > -#
> >> >  # Since: 2.6
> >> >  ##
> >> >  { 'struct': 'QCryptoBlockCreateOptionsLUKS',
> >> > @@ -237,8 +235,7 @@
> >> >              '*ivgen-alg': 'QCryptoIVGenAlgorithm',
> >> >              '*ivgen-hash-alg': 'QCryptoHashAlgorithm',
> >> >              '*hash-alg': 'QCryptoHashAlgorithm',
> >> > -            '*iter-time': 'int',
> >> > -            '*detached-header': 'bool'}}
> >> > +            '*iter-time': 'int' }}
> >> >  
> >> >  ##
> >> >  # @QCryptoBlockOpenOptions:
> >> 
> >> Glad you caught this in time.
> >> 
> >> Acked-by: Markus Armbruster <armbru@redhat.com>
> >
> > Urgh, it appears this patch got lost and was not in fact included in
> > 9.0.  What's your opinion on removing it from 9.1 with no deprecation
> > period ?  Functionally it did absolutely nothing even if used, so
> > removing it at most would cause an incorrect field to now be rejected.
> 
> Doc section "Deprecated features":
> 
>     In general features are intended to be supported indefinitely once
>     introduced into QEMU. In the event that a feature needs to be removed,
>     it will be listed in this section. The feature will remain functional for the
>     release in which it was deprecated and one further release. After these two
>     releases, the feature is liable to be removed. Deprecated features may also
>     generate warnings on the console when QEMU starts up, or if activated via a
>     monitor command, however, this is not a mandatory requirement.
> 
> Note this talks about *features*.
> 
> The software industry has a longstanding habit of declaring bugs
> features.  By removing @detached-header without a deprecation period, we
> effectively do the opposite.  The opposite of something bad must be
> good, right?  ;-)
> 
> Seriously, it's a judgement call.  I'm happy to defer to your judgement
> here.

Ok, I'm going to include this in 9.1.  The chances of something already
using the new 'detached header' feature from 9.0 is small. Out of that
small set, the chances of something setting the (useless) 'detached-header'
QAPI field is even smaller. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


