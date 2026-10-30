Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A465606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fNnCAmkM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMpO0-00054a-C1; Fri, 30 Oct 2026 12:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMpNy-00053w-8n
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMpNw-0007Vd-8u
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793377398;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vpI7/CgII+22iN4phcHpcZUlk8Xk5kdoxrCd5kEeKZU=;
 b=fNnCAmkMPfiF8qSwrki2XI6LAHnFTQV/MRF4nElmco3eY3Xq+r0t/ZnAOo0Fj1TJ9Iao2X
 +LfztqMph4aqD/2CGX7/e6IBbgK/qXlgCFIecB2T0CTpzSUrgOyMP0MXG24U+zuNyLbEr6
 IbU50XO1gmM4c0f0UxIDLMxpUpgQAOY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-PEnqUOhROVisx3Mha1jOvg-1; Fri,
 30 Oct 2026 12:23:13 -0400
X-MC-Unique: PEnqUOhROVisx3Mha1jOvg-1
X-Mimecast-MFC-AGG-ID: PEnqUOhROVisx3Mha1jOvg_1793377389
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F7F31956066; Fri, 30 Oct 2026 16:23:09 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8840E3000738; Fri, 30 Oct 2026 16:23:08 +0000 (UTC)
Date: Fri, 30 Oct 2026 16:23:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] crypto: add glib initialization for SM3 hash
Message-ID: <auTEacvDn1fET0-K@redhat.com>
References: <20261030150413.2999685-1-berrange@redhat.com>
 <20261030150413.2999685-2-berrange@redhat.com>
 <0e31509d-78bd-4f08-83d3-0709fc39fda0@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e31509d-78bd-4f08-83d3-0709fc39fda0@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 05:16:31PM +0100, Philippe Mathieu-Daudé wrote:
> On 30/10/26 16:04, Daniel P. BerrangÃ© wrote:
> > The glib backend for the hmac/hash code must have an explicit
> > initializer for every element, as the default static initializer
> > of zero maps to G_CHECKSUM_MD5 and will lead to incorrect
> > behaviour. This could potentially be a security through use of
> > the wrong hashing algorithm.
> > 
> > Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4786
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   crypto/hash-glib.c | 1 +
> >   crypto/hmac-glib.c | 1 +
> >   2 files changed, 2 insertions(+)
> > 
> > diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
> > index 809cef98aee..39040f1856e 100644
> > --- a/crypto/hash-glib.c
> > +++ b/crypto/hash-glib.c
> > @@ -33,6 +33,7 @@ static int qcrypto_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
> >       [QCRYPTO_HASH_ALGO_SHA384] = G_CHECKSUM_SHA384,
> >       [QCRYPTO_HASH_ALGO_SHA512] = G_CHECKSUM_SHA512,
> >       [QCRYPTO_HASH_ALGO_RIPEMD160] = -1,
> > +    [QCRYPTO_HASH_ALGO_SM3] = -1,
> >   };
> 
> Should we initialize the array with range designator to prevent that?
> 
>   [0 ... QCRYPTO_HASH_ALGO__MAX - 1] = -1,

Oh, I didn't know that syntax exists.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


