Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866D606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uw2g3q7P;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=t9+aFQ2C
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTNM2-0006HI-WF; Tue, 17 Nov 2026 12:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xTNM1-0006H2-Dc
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:52:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xTNLw-00031q-Hk
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794937939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5RsskxPgR1RFtj2rDzNM7VhJwTOakHKGLIowySGlWg4=;
 b=Uw2g3q7P5QjOIXftxruhGgVJ24nxNAVWQE5kM7tQBUCiyNTHYBqyOHiSWpfX+NbBiAcRZL
 4/GMhrZl/3HvLoSRAbtTodpLw1MhELFzzQW+0gYEsedWfGcr1nDhj64yUe/3UNUVwx+FOp
 2Btow54XRp/hvwj/7dM6bZDJju5BuYQ=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-jQOmbbGINu6KzloRhVMQiA-1; Tue, 17 Nov 2026 12:52:17 -0500
X-MC-Unique: jQOmbbGINu6KzloRhVMQiA-1
X-Mimecast-MFC-AGG-ID: jQOmbbGINu6KzloRhVMQiA_1794937936
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-67bec5d62ebso10129067d50.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 09:52:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794937936; cv=none;
 d=google.com; s=arc-20260327;
 b=P6MFfnEaAAk+EcIT3Vdt3u0iZqJ2dep+tHoi3Gln0zv+Ex1/MBFb6W3XUXkAxnp5gG
 42q2CIje5OTyW3IYIkdsG7VMzTov4cI7IB4FeelUsu2TAeom64lcPTzxkdDBA7b5YwhW
 hE7ywsHqzQVKWa5NYsDpIpAYPFwBn00MsSK5iqxVIwkF5/NlxwsthzP2ztS26I2HR1I+
 N4C3p3n4TdJpTV9hLf4Ga0QKdt8lIW/1xz17u70g+XE4yAWJr2+douu6VBD4nUxv/YW0
 P1KslFD/xb3zLE/WoF5HA5ua4qLHAcOH4sL7YVV0Z5M5oaQ8RaCp38Z3r0J506qkI/v/
 DFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5RsskxPgR1RFtj2rDzNM7VhJwTOakHKGLIowySGlWg4=;
 fh=aM8heEw08rewKoAzVI8T3Lmgm/CRSAFyugkfKMMnfg8=;
 b=cp3jDXYmvWkUnWjBwLV6kvMotaRgSmw6I7GSkruS8NWClQ7iy4myPZ8VquICjp8mVd
 7VVJcsh8BjBvg5TO3OnJiwHqo7ixHm0eM803kYQ5jqz2AHwxEJZj5mmW7KO3jo4D1Ie+
 6U7/cad4JImR17ajehlf4ukbFR0gZEGeSO5EwH0c8J+kE6Erwg2/N31g99ZGur0wADBD
 5KbQ/nKbb+Duc5kvi+Plk6exDzWEV+t04qdXvpe+pB5ONqd0jRL48yuM2rnvobmkU9YW
 EeXK9q6g2BAt4IyOjb+XkXutBoCQYd2JPZQxvBFn+pJoTAL+iUBm/g2ygr4/J0t/3ui2
 NGDA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794937936; x=1795542736; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5RsskxPgR1RFtj2rDzNM7VhJwTOakHKGLIowySGlWg4=;
 b=t9+aFQ2CesjgNH2UaKEZfdm1xHVSsk6UkRp7stGCsEcU2v9ZiY3ToNH3WmOR7Ncli/
 qV8cN+th2yq4B2ECzPvl5ETJ/sqPqw7DfqCneQdKkRjUvT//Y+YdvBkLaVwcisBmaz6I
 oiAW5whLD+5WdDbtNCCNfPle+wfCvPs0IenZwdHBaMDYHFOiuF+69TDQG8/HlA6j7xhn
 NNcXE5+KX9PByQLVLffQerqB6SDLnlrJXl/VJKVY6/t6SQ5PkLQpWhVQc0bcpoPMb8te
 hA8bmKuyeQbCdZiLyHt87k6dtCILT8OVi1GxgF6hXQKqpotm0MRKQW+C7PKmlW8XOD7H
 MlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794937936; x=1795542736;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5RsskxPgR1RFtj2rDzNM7VhJwTOakHKGLIowySGlWg4=;
 b=JMsz+TsUCojXs9T2E+4MEewOjDLCSvzVyr3H0f3r/1D8fhyMNt8Ppfty9heY7Wm2zp
 tAxx8KR2fLPYYfV2EBg1yNRR0uErE0aUDFCfCrqc198e0cUefCpV8+hcJEKKXDwOA6+P
 +sCXj5Kg/NDy7rco61SnFVwaustb5UO/5vk9WzgPz7xwhWzyIoHEQAaxAB13L1fpr+Zx
 NIo4HdfjCCkkZIwyheplb7c2gz15qsgcdAkbPOo2rB+97BEKGjAEfkE18SVdD7Cs9TDq
 e4cWlqVdmjhg/H/NFaHdTeH2oqxOmpY/tJugvr40+q6DaUeyZQNFaNwggcLfBe3SItsx
 6AbA==
X-Gm-Message-State: APuU4Z9wTGMQp5TbD1al492IcG0fbLQQ2lvEBl3WpLQ68pS7zH4jNo2n
 JGlkvPtm2c2O9VLhruAs6QUjhNpdwBdHhAQvkO2UxCmt90lxyeJVT0fGVcPF4MVsoAjXubRva/N
 hi1po9VOZJ/EkfOEWdARi18iVnm7fFQW8br35BidDKv9M90cP07XaxSCdoJeJomOGVhggSROT6c
 RuLO7AEfK8WOGXYtacrklC7B9CKYUYJiY=
X-Gm-Gg: AZFdTZdiJQhG5SAvVPSmSVPcRzpLqAucYYnwqzaclMGtu/aFCQdBM0FEvYOcXid3Ibs
 ptJeFk0WCb0D03E3emxe2WbpcVB/3ami5yNCI7xw6+DenWdX14JU9lqeYCv9yCvXHxFGz8sm4cy
 v0HVvLjjvhGqM5zgtpk59TSIjJWk3v9NzKs3bwBs0tWfyB4E7Z4mRwWkNtrD/XSABVPwmmkRyr8
 5OrLD08FpWG5L6n
X-Received: by 2002:a05:690e:14c8:b0:67d:bdcc:423a with SMTP id
 956f58d0204a3-67dd3fed186mr125181d50.58.1794937935991; 
 Tue, 17 Nov 2026 09:52:15 -0800 (PST)
X-Received: by 2002:a05:690e:14c8:b0:67d:bdcc:423a with SMTP id
 956f58d0204a3-67dd3fed186mr125164d50.58.1794937935464; Tue, 17 Nov 2026
 09:52:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116165002.30939-1-jsnow@redhat.com>
 <20261116165002.30939-5-jsnow@redhat.com>
 <avxapBFgrHUV3rfp@redhat.com> <avxbAf6FlGMthTCE@redhat.com>
In-Reply-To: <avxbAf6FlGMthTCE@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 17 Nov 2026 12:52:04 -0500
X-Gm-Features: AclHuK9JtHUiSsE0QAX6QkJYOQtVMKTlxiSmWNUJL3alftMy4VMW9ohnAPmR1JQ
Message-ID: <CAFn=p-aDi5Com_BJaO-bFHZoEghqBbBJXgn=Yhsg1mwwhuD+RQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] debug/mem: name pthreads
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 kvm@vger.kernel.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Fabiano Rosas <farosas@suse.de>, Alistair Francis <alistair.francis@wdc.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 8:47=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Nov 17, 2026 at 01:46:12PM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Nov 16, 2026 at 11:49:59AM -0500, John Snow wrote:
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >  meson.build              |  8 ++++++++
> > >  util/qemu-thread-posix.c | 30 ++++++++++++++++++++++++++++++
> > >  2 files changed, 38 insertions(+)
> > >
> > > diff --git a/meson.build b/meson.build
> > > index d7bcb581c18..ef961df2f64 100644
> > > --- a/meson.build
> > > +++ b/meson.build
> > > @@ -2878,7 +2878,15 @@ config_host_data.set('CONFIG_PTHREAD_GET_NAME_=
NP', cc.links(osdep_prefix + '''
> > >      pthread_get_name_np(pthread_self(), buf, sizeof(buf));
> > >      return 0;
> > >    }''', dependencies: threads))
> > > +config_host_data.set('CONFIG_PTHREAD_GETATTR_NP', cc.links(osdep_pre=
fix + '''
> > > +  #include <pthread.h>
> > >
> > > +  int main(void)
> > > +  {
> > > +    pthread_attr_t attr;
> > > +    pthread_getattr_np(pthread_self(), &attr);
> > > +    return 0;
> > > +  }''', dependencies: threads))
> > >  config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCLOCK', cc.links(os=
dep_prefix + '''
> > >    #include <pthread.h>
> > >
> > > diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> > > index 089606c93fb..967e0f15f6d 100644
> > > --- a/util/qemu-thread-posix.c
> > > +++ b/util/qemu-thread-posix.c
> > > @@ -17,6 +17,7 @@
> > >  #include "qemu-thread-common.h"
> > >  #include "qemu/tsan.h"
> > >  #include "qemu/bitmap.h"
> > > +#include "qemu/mmap-vma.h"
> > >
> > >  #if defined(CONFIG_PTHREAD_SET_NAME_NP) || defined(CONFIG_PTHREAD_GE=
T_NAME_NP)
> > >  #include <pthread_np.h>
> > > @@ -362,6 +363,13 @@ static void qemu_thread_atexit_notify(void *arg)
> > >
> > >  void qemu_thread_set_name(const char *name)
> > >  {
> > > +# if defined(CONFIG_PTHREAD_GETATTR_NP)
> > > +    pthread_attr_t real_attr;
> > > +    void *pthread_addr;
> > > +    size_t stacksize;
> > > +    size_t guardsize;
> > > +# endif
> > > +
> > >      /*
> > >       * Attempt to set the thread name; note that this is for debug, =
so
> > >       * we're not going to fail if we can't set it.
> > > @@ -373,6 +381,28 @@ void qemu_thread_set_name(const char *name)
> > >  # elif defined(CONFIG_PTHREAD_SET_NAME_NP)
> > >      pthread_set_name_np(pthread_self(), name);
> > >  # endif
> > > +
> > > +# if defined(CONFIG_PTHREAD_GETATTR_NP)
> > > +    if (pthread_getattr_np(pthread_self(), &real_attr)) {
> > > +        return;
> > > +    }
> > > +
> > > +    if (pthread_attr_getguardsize(&real_attr, &guardsize)) {
> > > +        goto cleanup;
> > > +    }
> > > +
> > > +    if (pthread_attr_getstack(&real_attr, &pthread_addr, &stacksize)=
) {
> > > +        goto cleanup;
> > > +    }
> > > +
> > > +    /* Though there's a guard page, it isn't actually marked RO, so
> > > +     * just label the entire region */
> > > +    qemu_name_vma(pthread_addr - guardsize, stacksize + guardsize,
> > > +                  "pthread (%s)", name);
> >
> > On the one hand this code is pretty sketchy as it is making
> > some assumptions about glibc allocating thread stack. On
> > the other hand qemu_name_vma() is a no-op on non-Linux
> > platforms, and we ignore fails, so we'll degrade nicely if
> > any C libraries (musl) deal with thread stack differently.
> >
> > I feel that glibc itself really ought to set the VMA name
> > in response to pthread_set_name_np but I'm open to us doing
> > this in QEMU though as I think it is safe enough.

libc will label this, but it will give it a very generic name like
"malloc" or something like that. This is a "free upgrade", but you're
right that it is porcelain as it requires us to know a little bit
about the memory layout.

I'll add a better comment in-line here to warn folks that this is not
necessarily *super* reliable, though in testing it works great...

One concern I have is that even though there is a guard page
allocation here, nothing appears to set permissions on said guard
page: it remains fully RW. That's not a particularly effective guard
page, I'd have thought...

>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


