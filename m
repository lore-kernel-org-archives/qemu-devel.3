Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4469CA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 09:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sllsY-0002QL-II; Wed, 04 Sep 2024 05:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sllsS-0002P1-ND
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 05:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sllsQ-0005SP-IY
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 05:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725440432;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nrq/5iF4+48nyfFkgVhnvKIV3GPVvD28oJEr6bNukhY=;
 b=RsFTmPXY6hmbauWh4RZvh5Jl7YFdTERrIh+Lc/uuEsQSQRm28orsy+EAxzdu4KLD8IANGo
 bvHtgkZShz/JPgodnnHLDTLOhokm/jtnJbiLryf5BPrYa4/cKG0V2DrF0HY4k8saz8kt89
 WIgEIiR/KSWwn/fJDQJEs10kT9Csgrk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-SeQOiDo2N5-ZZmd52jGN_g-1; Wed,
 04 Sep 2024 05:00:28 -0400
X-MC-Unique: SeQOiDo2N5-ZZmd52jGN_g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2324F196CDF5; Wed,  4 Sep 2024 09:00:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D120A19560AA; Wed,  4 Sep 2024 09:00:24 +0000 (UTC)
Date: Wed, 4 Sep 2024 10:00:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] tests/unit: always build the pbkdf crypto unit test
Message-ID: <Ztgho-3qtdT0mSyT@redhat.com>
References: <20240830110533.2544070-1-berrange@redhat.com>
 <20240830110533.2544070-3-berrange@redhat.com>
 <2d0ade1c-42db-49ce-85b1-9c73a34ef015@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d0ade1c-42db-49ce-85b1-9c73a34ef015@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Sep 02, 2024 at 09:45:04PM +0200, Philippe Mathieu-Daudé wrote:
> On 30/8/24 13:05, Daniel P. Berrangé wrote:
> > The meson rules were excluding the pbkdf crypto test when gnutls was the
> > crypto backend. It was then excluded again in #if statements in the test
> > file.
> > 
> > Rather than update these conditions, remove them all, and use the result
> > of the qcrypto_pbkdf_supports() function to determine whether to skip
> > test registration.
> > 
> > Also add CONFIG_DARWIN to the remaining condition, since we have a way
> > to measure CPU time on this platform since commit bf98afc75efedf1.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/unit/meson.build         | 4 +---
> >   tests/unit/test-crypto-pbkdf.c | 9 ++++++---
> >   2 files changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> > index 490ab8182d..972d792883 100644
> > --- a/tests/unit/meson.build
> > +++ b/tests/unit/meson.build
> > @@ -121,9 +121,7 @@ if have_block
> >     if config_host_data.get('CONFIG_REPLICATION')
> >       tests += {'test-replication': [testblock]}
> >     endif
> > -  if nettle.found() or gcrypt.found()
> > -    tests += {'test-crypto-pbkdf': [io]}
> > -  endif
> > +  tests += {'test-crypto-pbkdf': [io]}
> >   endif
> >   if have_system
> > diff --git a/tests/unit/test-crypto-pbkdf.c b/tests/unit/test-crypto-pbkdf.c
> > index 43c417f6b4..034bb02422 100644
> > --- a/tests/unit/test-crypto-pbkdf.c
> > +++ b/tests/unit/test-crypto-pbkdf.c
> > @@ -25,8 +25,7 @@
> >   #include <sys/resource.h>
> >   #endif
> > -#if ((defined(CONFIG_NETTLE) || defined(CONFIG_GCRYPT)) && \
> > -     (defined(_WIN32) || defined(RUSAGE_THREAD)))
> > +#if defined(_WIN32) || defined(RUSAGE_THREAD) || defined(CONFIG_DARWIN)
> 
> Add CONFIG_DARWIN in a subsequent commit?

Yes, classic trap. If you have "Also ..." in a commit message then you've
just told yourself it should have been a separate commit :-)

> 
> >   #include "crypto/pbkdf.h"
> >   typedef struct QCryptoPbkdfTestData QCryptoPbkdfTestData;
> > @@ -422,13 +421,17 @@ int main(int argc, char **argv)
> >       g_assert(qcrypto_init(NULL) == 0);
> >       for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
> > +        if (!qcrypto_pbkdf2_supports(test_data[i].hash)) {
> > +            continue;
> > +        }
> > +
> >           if (!test_data[i].slow ||
> >               g_test_slow()) {
> >               g_test_add_data_func(test_data[i].path, &test_data[i], test_pbkdf);
> >           }
> >       }
> > -    if (g_test_slow()) {
> > +    if (g_test_slow() && qcrypto_pbkdf2_supports(QCRYPTO_HASH_ALG_SHA256)) {
> >           g_test_add_func("/crypt0/pbkdf/timing", test_pbkdf_timing);
> 
> While here, rename test_pbkdf_timing -> test_pbkdf_sha256_timing?

Will do

> 
> >       }
> 
> Anyway,
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


