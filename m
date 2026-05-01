Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70871CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIlZP-0003QL-DI; Fri, 01 May 2026 06:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wIlZM-0003QA-A6
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wIlZK-0006O9-5F
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777633079;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YhKd/UwyQX8ik+dMU0aJi04Dy5FcW5hQWROwkvyv1p0=;
 b=Nbzo/QqtOs+fMfuvcanF20JNkyiKTaSo7JqTCzM7l9/R4JB91GmH5156H+jzkRI02LKrzZ
 5ros5a1TwgSIVv7UwJdCF6vgSdYnykbXbgVAuA2fdyBCOUEjgKVs3c0LxOxNrsGC06Egah
 q2kjAR8d0oo8tcOWjNd54ALIYqlqDkc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-4ox1cvc1MRG6ela3pSY4qg-1; Fri,
 01 May 2026 06:57:56 -0400
X-MC-Unique: 4ox1cvc1MRG6ela3pSY4qg-1
X-Mimecast-MFC-AGG-ID: 4ox1cvc1MRG6ela3pSY4qg_1777633075
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 206861956088; Fri,  1 May 2026 10:57:55 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A51101800906; Fri,  1 May 2026 10:57:52 +0000 (UTC)
Date: Fri, 1 May 2026 11:57:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PULL 14/42] tests/functional: add a module for handling asset
 download & caching
Message-ID: <afSHLJD0psvA8q8i@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
 <20240904103923.451847-15-thuth@redhat.com>
 <CAFEAcA_TgEt2+=737G_XRU1+bWV=zypHFo0WTTG_Ms_DyyB5+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_TgEt2+=737G_XRU1+bWV=zypHFo0WTTG_Ms_DyyB5+g@mail.gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, May 01, 2026 at 11:02:48AM +0100, Peter Maydell wrote:
> On Wed, 4 Sept 2024 at 11:41, Thomas Huth <thuth@redhat.com> wrote:
> >
> > From: Daniel P. Berrangé <berrange@redhat.com>
> >
> > The 'Asset' class is a simple module that declares a downloadable
> > asset that can be cached locally. Downloads are stored in the user's
> > home dir at ~/.cache/qemu/download, using a sha256 sum of the URL.
> >
> > [thuth: Drop sha1 support, use hash on file content for naming instead of URL,
> >         add the possibility to specify the cache dir via environment variable]
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Message-ID: <20240830133841.142644-15-thuth@redhat.com>
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> An old change, but I've just noticed:
> 
> > +        try:
> > +            with tmp_cache_file.open("wb+") as dst:
> > +                copyfileobj(resp, dst)
> > +        except:
> > +            tmp_cache_file.unlink()
> > +            raise
> > +        try:
> > +            # Set these just for informational purposes
> > +            os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
> > +                        self.url.encode('utf8'))
> > +            os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
> > +                        self.hash.encode('utf8'))

snip

> I guess since they're only for "informational purposes" we can
> safely just skip them on non-Linux -- what's the Python way
> to check for "do we have this" ?

  if hasattr(os, "setxattr"):
     ...blah...

With regards,
Daniel


