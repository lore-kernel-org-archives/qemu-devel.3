Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B273D606A337
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EYsJN8ZO;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RrUj3nPW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU7Fd-0005ok-IQ; Thu, 19 Nov 2026 13:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xU7Fa-0005nx-9m
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:52:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xU7FY-0002QB-L9
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795114367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3xU1AfNzARCfJJvjM8RgferpX/JP5+MUWt/2XG6xSfM=;
 b=EYsJN8ZO/37mkDHd71uMQ0HVgMSU8rhBicZqUkjZYU0G74k/QDFmE4DEFBZToNVvZeVfPQ
 or9YmBCf+e/ZrDUALdb/YfO1urWnrA9yyzA0h2om2aebNl8brZSrA3xe2ckhKEGYgykMMn
 S/idDCvjHPaD3713r6fEzS+2YBp1PAw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-IEvsn3R9Oh2JMUh78cPyTw-1; Thu, 19 Nov 2026 13:52:45 -0500
X-MC-Unique: IEvsn3R9Oh2JMUh78cPyTw-1
X-Mimecast-MFC-AGG-ID: IEvsn3R9Oh2JMUh78cPyTw_1795114365
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9210a12765eso3141756d6.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 10:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795114365; x=1795719165; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3xU1AfNzARCfJJvjM8RgferpX/JP5+MUWt/2XG6xSfM=;
 b=RrUj3nPWlCPHgD1iIIB1IJk1gvfQC52muYblCAGWfeRlxC8WfTz+nVdE57Fga2uABz
 JVwkhGv1Mhm/L4K6weEK/GbH+Cnv/ZpXzER4ijsXnIXkXGyhhIgzlqIFgPZWldzz9Hu7
 vpmPFN+nQhyV7gTuOeAtdiUR/RmBLa6S0vXOToa5bU/v9aU+gDRTy4+SJufal3n6SXA6
 I/uWLc/iRxm9ZrtcUBQAR4WZhmM4qrQ0Rs3EGj2/o6AiphCejuIvAkrXH8Emz9I+KtJz
 jHrY17TYS/kgPWYt96MxzEg754bzg0q80B4cOjwzfBdHItHXptiXApXehDrJotDdWjEH
 XS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795114365; x=1795719165;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3xU1AfNzARCfJJvjM8RgferpX/JP5+MUWt/2XG6xSfM=;
 b=OHITCvHstRmLUd8mG/dlPezQhsxFkvPilfFK3+TLpyJU1cXVNhRQcSyR3x2sgOTa0P
 NLXwoljyWRMHRu/shayGdhdnGz9ztrvWu4RkogAQ9kGTV+EkxLXdzCpiTyE3uO6XPDmX
 XSaaMIBoFQYp7iAdpZZ2Tr+yb5HaAy2MdfJonsDmU+y68TTiTE+mY9ygvYZwi13ki69e
 awbUp5RHB2sU/1Mm4J/LGmaXpkB72Ee+HGeWPY0FU2S38CoArVGsk8wyjBpWQk14NBh1
 3wm03QzH3Z4Wb/QareFj8iHA22XxDnKvs+D8rer+1jo5FBkd345yW4FuKc4S3KFYkOSH
 J4pQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHKikYVC5/7dqoSmDYyPB0Uj338pRvHqulGXC2Agjkx9mNKqvwPdt0f3xAud3+AwMDrl/hiRFIyNp4C@nongnu.org
X-Gm-Message-State: APuU4Z97JAUQe/cU+9pTMctrJ0HSWc8YTFdR36ZsoMMCyc5M5jxUeyHq
 p88y7Tsf6QEDkz05Ly/3yk27HR+5qx3QHFJlSdAr3r8WAzqHdFrBFvk8lMPAd9XpImx7coPid4k
 l6J6orgaOac3CUwhmPVioEbLofX6C8ombNcETTaEQjL3DwY5ajdUAzDOA
X-Gm-Gg: AZFdTZdv0xv3jgN0evgX67tI7xG9PKjEkm43AinR3DuPbl0xe6ClT4S8XpuViNnEQsP
 IvyrB9vRDi860qalSVkhLjvJC6rL4tu4L3P+a+sO3RNPi3kKW1xjKyQGvh0z2H5rcRMHnEaOR2l
 vyocXdxlRuQ/4XS4WSoCDjapXBcb8hTet/7NMfayMchILyw530F8VvSgIyTIklA5cCPuqYLeuSg
 aZ/isn6MJ4kDNpWW73WTOBAMIJ5XKu8Uplv90viODjXlyRgwwUf9p9xhXRXrGI8+BM7znni1Qwd
 jBpg/Wt3O7MRDk6APpVzxMogsN9xVFekBtLkniMp/q2PxVbpQYVuOM3jQ5JOlm8weTfha47mNVD
 YeGEqD0Y8poUrtPAzw+P3JToh6bxfG9bX3vFPw2zfRKCD
X-Received: by 2002:a05:6214:62d1:20b0:921:2cb9:4506 with SMTP id
 6a1803df08f44-92134b73592mr6901276d6.45.1795114364642; 
 Thu, 19 Nov 2026 10:52:44 -0800 (PST)
X-Received: by 2002:a05:6214:62d1:20b0:921:2cb9:4506 with SMTP id
 6a1803df08f44-92134b73592mr6900846d6.45.1795114364014; 
 Thu, 19 Nov 2026 10:52:44 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921349cdfbasm5474456d6.17.2026.11.19.10.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 10:52:43 -0800 (PST)
Date: Thu, 19 Nov 2026 13:52:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "open list:nvme" <qemu-block@nongnu.org>
Subject: Re: [RFC PATCH] tests/functional: add migration diagnostics and pace
 nvme activity (HACK!)
Message-ID: <av9FeuY9pnYHXblq@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260921190345.1709227-1-alex.bennee@linaro.org>
 <asZIy2Rm8QF4TSca@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAJqdLrqxJF4tgfRYrm27rGivP-HyLUX=YCNUiaFqq4nDq0a5pQ@mail.gmail.com>
 <as6RsuZP6jkZ8twC@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAJqdLrpQLJtXptSURtnT4xo4LJTduhksqAKnoPHCHbbfdVhW0w@mail.gmail.com>
 <as_rOWkhyPnWsMfL@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAJqdLrqxmTQeSUziBAtuhb94mVEjU1G_oEx1N1sLwKT3O=gDTA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJqdLrqxmTQeSUziBAtuhb94mVEjU1G_oEx1N1sLwKT3O=gDTA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 06:06:46PM +0200, Alexander Mikhalitsyn wrote:
> Am Mi., 14. Okt. 2026 um 22:51 Uhr schrieb Peter Xu <peterx@redhat.com>:
> >
> > On Wed, Oct 14, 2026 at 10:18:45AM +0200, Alexander Mikhalitsyn wrote:
> > > > - for this test, should we remove snapshot=on but instead create an
> > > >   explicit overlay that will be used on both src/dst qemu?
> > >
> > > This should solve the issue too, at the same time if test is R/O I'm
> > > not sure if we really need this.
> >
> 
> Dear Peter,

Hi, Alexander,

> 
> sorry for such a long delay with reply. Was busy plumbing some other stuff :-(

Same here. :(

Let's fix this first, or it'll be forgotten!

> 
> > Then.. maybe no need to bother. :)
> >
> > I think we should better remove snapshot=on no matter what, then whoever
> > sends a patch add migration blocker for it won't fail this test.  Seems the
> > /tmp mount is still needed then.
> 
> Yeah, if we really gonna make snapshot=on to be a migration blocker (which seems
> like a clean way to protect users from doing weird stuff like I
> accidentally did in my test :-D).
> 
> I need to look on the option you've earlier suggested with "explicit
> overlay that will be used on both src/dst qemu".
> I'll get back to you ;-)
> 
> Btw, does my fix with mounting tmpfs actually solves the problem for
> you? I'm just curious,
> because I wasn't able to reproduce the problem locally tho... And if
> so, then probably we should
> land this tmpfs-mount change for now, while we can prepare a better
> and generic fix to get rid of snapshot=on,
> add migration blocker for it and so on. WDYT?

I agree.

I tested your patch, it works for me, used to fail almost certainly but now
it passes in a seq of runs.  I just thought it wasn't a good enough fix,
but considering my poor speed on reply (which is this one me to blame), I
think we should fix it first.

You can send a formal patch and attach:

Tested-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


