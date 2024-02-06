Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D44CC48286
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 08:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXGrB-00078d-5Z; Tue, 06 Feb 2024 03:31:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXGqw-0006mn-Oc
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 03:30:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXGqu-0002UB-Ry
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 03:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707208245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X6ibFY7ILh3MyXkCDps7rbm2bh/UUeHMKKlbm+gWsNI=;
 b=KGbGDXVbqi1UKfaWGqyqiV+IrsGkKBvgA+EwtQvlPNMRyH+9zJYxbGxvmw5ANLRKJBP+ox
 cprngZb3OZZSFsOY5tHeunYQxbbcVd1uVsPKDUUL+gDMgElq2U9GsQSf7MJm5wElybs5Gc
 Rj/VlzHsFtenM54sQ2LyS9YF7t42i+8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-AE8jsYe9OHmun76Isu53Bg-1; Tue, 06 Feb 2024 03:30:43 -0500
X-MC-Unique: AE8jsYe9OHmun76Isu53Bg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2966922adc2so602677a91.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 00:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707208243; x=1707813043;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X6ibFY7ILh3MyXkCDps7rbm2bh/UUeHMKKlbm+gWsNI=;
 b=iVAxlw1VgmbPDmrZssqPrKDmjT98XYfi2UmSx4InQCkJKd2PftGbf0LZRvL7agOG0e
 D9V624s7yL/cKVlu7/afNsy7Y2W+mNjIovkE9w2iqiaWIoBJXuJyy30rz1fwrC21e1xr
 7Yy5LxEJkZ/P7+vUvty4rHAzwnzYT+2UmT08jV1tkQppD+eaNtvqQEOTvYjFbyT/G5tw
 o0QqQ/rc2u7OnMBO0TAF6oG+Sih/cTV96c51FHsJTImnz4skDgUgW4RoctsorxJLQYGU
 cIF0TzkBXmFV/hMVFvFnUxs0srcVOs6V/Hm8h7We4HOAIPupZZbUSxJ9NdzpCX+j+Wn6
 BWoQ==
X-Gm-Message-State: AOJu0YyTb+zltS8e9G2zy8I33ZT1IGY4/E1H7uwMRVuBkLJP22XxmtJj
 HRwjrhkayAT6CrOyRNriEvXSYKcuxTb+B0Z67RJ2gphtYsxF+S8kZXDx5vIsU28bUCer1imK+R3
 KMQ1p8LmyhFkcejG853JUfgSObQFcxo6I+sRoUPH04FRkTGXWfhEe
X-Received: by 2002:a17:90a:df06:b0:296:cc9e:89f5 with SMTP id
 gp6-20020a17090adf0600b00296cc9e89f5mr519553pjb.4.1707208242740; 
 Tue, 06 Feb 2024 00:30:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWVzQFJII15Js2DOFss7LSBFH7hjlx7Ht/1jOdmg8Tgn0omClrT3+Dhf8kLUZTW1FS9hlV3w==
X-Received: by 2002:a17:90a:df06:b0:296:cc9e:89f5 with SMTP id
 gp6-20020a17090adf0600b00296cc9e89f5mr519535pjb.4.1707208242357; 
 Tue, 06 Feb 2024 00:30:42 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVRJvBYPV6dxJFTtUvebDYZ5qKp6poEp02TexbbmiloBvTuxAFPIjg9OxsVqxZDI1IvPjKEss0eu11dt+7gVO8O4DbzlEIVtFJpK08AdWHCWZX/0XhBZUn04gDhr4MprtLW6yEnx+uWmkrUEMObmE2hRWmE07EeYCOR60mGr6s45ae40w==
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 sb14-20020a17090b50ce00b0029082d10fc4sm910827pjb.39.2024.02.06.00.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 00:30:42 -0800 (PST)
Date: Tue, 6 Feb 2024 16:30:34 +0800
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>
Subject: Re: [PATCH 2/3] ci: Remove tag dependency for build-previous-qemu
Message-ID: <ZcHuKlTQ3kEiDfui@x1n>
References: <20240206063151.215986-1-peterx@redhat.com>
 <20240206063151.215986-3-peterx@redhat.com>
 <ZcHpzsLYCPwFPMUq@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcHpzsLYCPwFPMUq@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 06, 2024 at 08:11:58AM +0000, Daniel P. Berrangé wrote:
> On Tue, Feb 06, 2024 at 02:31:50PM +0800, peterx@redhat.com wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > The new build-previous-qemu job relies on QEMU release tag being present,
> > while that may not be always true for personal git repositories since by
> > default tag is not pushed.  The job can fail on those CI kicks, as reported
> > by Peter Maydell.
> > 
> > Fix it by fetching the tags remotely from the official repository, as
> > suggested by Dan.
> > 
> > [1] https://lore.kernel.org/r/ZcC9ScKJ7VvqektA@redhat.com
> > 
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  .gitlab-ci.d/buildtest.yml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> > index 79bbc8585b..df48c9d31d 100644
> > --- a/.gitlab-ci.d/buildtest.yml
> > +++ b/.gitlab-ci.d/buildtest.yml
> > @@ -189,6 +189,8 @@ build-previous-qemu:
> >      TARGETS: x86_64-softmmu aarch64-softmmu
> >    before_script:
> >      - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
> > +    - git remote add upstream https://gitlab.com/qemu-project/qemu
> > +    - git fetch upstream $QEMU_PRRV_VERSION
> 
>                               Typo^^^

Interestingly, this typo won't affect the function, as QEMU_PRRV_VERSION
will be an empty string, and this cmd will simply pull in all the tags..

After the fix, it should only fetch the tag that we need.

> 
> >      - git checkout $QEMU_PREV_VERSION
> >    after_script:
> >      - mv build build-previous
> 
> With that typo fixed, then
> 
>   Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Thanks.

-- 
Peter Xu


