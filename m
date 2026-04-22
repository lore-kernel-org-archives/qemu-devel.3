Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4E2FA1FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 15:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFZkW-0005AC-RM; Wed, 22 Apr 2026 11:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFZkV-0005A3-Cc
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 11:44:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFZkP-0002FY-CP
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 11:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776872655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oe8TFO+Er/Cbxvq4Z2dOw+Mmhn9kLfcLqSlhcfpwQyY=;
 b=agu/OY/wsgGVG62I1W1f89WmDpBJRKKNjGXA92c4yr3Ur+oWU5WsP3nhN6Yy44b1GhH+Hy
 sb/oC6lfVjSju3Cp1O9T4CikTbeabS8VCAcNRBsDZOjLVW7yUGrOVmk/i1r2/K+rH19TCM
 gXcbSrWXC/rNx08jZNck7rvXr1wl6bM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-aHGMhLXMPw-_jRICcmsLWA-1; Wed, 22 Apr 2026 11:44:14 -0400
X-MC-Unique: aHGMhLXMPw-_jRICcmsLWA-1
X-Mimecast-MFC-AGG-ID: aHGMhLXMPw-_jRICcmsLWA_1776872654
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50e423a05c8so37474311cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776872654; x=1777477454; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oe8TFO+Er/Cbxvq4Z2dOw+Mmhn9kLfcLqSlhcfpwQyY=;
 b=bt2Uhu7BGoWey9EXAGViWPtUdjRUFUYWML///G7zwDqvkSC26+Wn4jBXEBkgCcpOW1
 TuNCZnETX/L04O0JRvTmxdB8zVC63Fae7ALnznlIYo3N+lIiYKIesD9V3sBbrYAsteVe
 IUquAwRjT1xxbAf89JUanPltK4P9R9MlHAj1s+Uz5C6HnRg5Da7PoiKu9MklzobDjSGu
 LzTYXn1DgECtDHLh8wiZpXfGnaTXbAquaafos975qrEQ8szNUiuzK69MSr1dWeNQ5a88
 sNNmsxr7RCe7mq0Miaa6H5rMeGC5ISFsSh0ff2MOmM+pAnS7ALeojAZQCP2n3j5KMCnj
 z35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776872654; x=1777477454;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oe8TFO+Er/Cbxvq4Z2dOw+Mmhn9kLfcLqSlhcfpwQyY=;
 b=ix2GrVjbqmPikqFs0nT6eaR7q3p2EmhTToGwvlLoqZgboWhbwfpb8B60kvVfX28Cxt
 YqJEkjlkrasfJGcPIFUZY6tksDcOdls2cXCnIgOVYNZBrkwb+UCLeeoreE90HKaCUEdT
 50TjoQva/zPor5PTnVZ5FjJIT/qvOovfrFl0KnSP0JR/SnUUDmYh5XZX1SSFpzJzWLyx
 qMk0OeX+byeDuGSA+QjHjj/RuGj5u3fw7LmRPclZvfT3pgp+gaB+5fFU59iJBgpoDmx3
 lQtXKZE/h/fceG83BSxygQy5VcvfS7oZkJjdMc6Jfuw39AyudjWD90tAYsp+Hg5IqDrD
 4agw==
X-Gm-Message-State: AOJu0Yz25uYCZzTIaeRrad0jdeikZQ5p0LoGDz9fefgd7fsAPfbvIe2x
 yUN70CjtXd3px4Hm+uw6YSwGhJOZPs38Ld5pUKuk3y23D3eULsNTlSsGiFcyXfDBje+njCEY3CC
 ZU05yKZatHjI+hxJZ4txvUyfePHdt2zaBuKp+863th6Zha5X9mUwa0D1F
X-Gm-Gg: AeBDieu//WKX5lwXHm8/3RLW3wR6Zv4jcARwSsq6UUD7L243BhlenmGxWgD6Mtv2S8X
 V6U+lExbmPJM5L9fk4DVle2sWimMP58ZrH4+EHxHNRRjw/DPbWt30i/1sv0WRbwjT8tQC1y/rc8
 pxX2WCB8DQEZzuZxjQ0bWq9zOtyq++PMP0GLHKy8v2hUrampd6GLRoJaEkso2mWf6Odw1j7Pn3M
 1jg/+t19IQmjUGxvXKfnpmWK4OmN087WXwMsT57BnCAnJ3J2aYV529di5GD+WvikR0Jvu18Ybbo
 ELgaZovX85Zj7G8vW/WxAd2tXLR/7zeyeTl0aR5IvoXKNsXsHlEnJoJM8FidAqsMqigdxZw+R6S
 0HPV3+1DpYShOanoVdZVtC7Hfr7T8IhW+sdbMw8FNBU8MdiOOzwMpyWAgTg==
X-Received: by 2002:a05:622a:1b23:b0:50f:1b95:675a with SMTP id
 d75a77b69052e-50f1b956fdfmr154215491cf.4.1776872653776; 
 Wed, 22 Apr 2026 08:44:13 -0700 (PDT)
X-Received: by 2002:a05:622a:1b23:b0:50f:1b95:675a with SMTP id
 d75a77b69052e-50f1b956fdfmr154214861cf.4.1776872653225; 
 Wed, 22 Apr 2026 08:44:13 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50fafe9674csm70241771cf.3.2026.04.22.08.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 08:44:12 -0700 (PDT)
Date: Wed, 22 Apr 2026 11:44:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Zhiyi Guo <zhguo@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, "Jason J. Herne" <jjherne@linux.ibm.com>
Subject: Re: [PATCH v2 05/16] migration/treewide: Merge
 @state_pending_{exact|estimate} APIs
Message-ID: <aejsyzDCh5yOt9CW@x1.local>
References: <20260421202110.306051-1-peterx@redhat.com>
 <20260421202110.306051-6-peterx@redhat.com>
 <13359e7d-be22-4165-acf2-67de2fa3e7fd@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13359e7d-be22-4165-acf2-67de2fa3e7fd@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 22, 2026 at 11:29:11AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 21.04.26 23:20, Peter Xu wrote:
> > These two APIs are a slight duplication.  For example, there're a few users
> > that directly pass in the same function.
> > 
> > It might also be error prone to provide two hooks, so that it's easier to
> > happen one module report different things via the two hooks.
> > 
> > In reality, they should always report the same thing, only about whether we
> > should use a fast-path when the slow path might be too slow, as QEMU may
> > query these information quite frequently during migration process.
> > 
> > Merge it into one API, provide a bool showing if the query is an exact
> > query or not.  No functional change intended.
> > 
> > Export qemu_savevm_query_pending().  We should use the new API here
> > provided when there're new users to do the query.  This will happen very
> > soon.
> > 
> > Cc: Halil Pasic<pasic@linux.ibm.com>
> > Cc: Christian Borntraeger<borntraeger@linux.ibm.com>
> > Cc: Eric Farman<farman@linux.ibm.com>
> > Cc: Matthew Rosato<mjrosato@linux.ibm.com>
> > Cc: Richard Henderson<richard.henderson@linaro.org>
> > Cc: Ilya Leoshkevich<iii@linux.ibm.com>
> > Cc: David Hildenbrand<david@kernel.org>
> > Cc: Cornelia Huck<cohuck@redhat.com>
> > Cc: Eric Blake<eblake@redhat.com>
> > Cc: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
> > Cc: John Snow<jsnow@redhat.com>
> > Reviewed-by: Jason J. Herne<jjherne@linux.ibm.com>
> > Reviewed-by: Juraj Marcin<jmarcin@redhat.com>
> > Reviewed-by: Avihai Horon<avihaih@nvidia.com>
> > Signed-off-by: Peter Xu<peterx@redhat.com>
> 
> 
> Probably too late after all these r-b-s, but it would be simpler to review,
> if renaming and reworking the documentation of the fields, moving them
> to a separate structure, and combining two handler functions into one
> would all be different patches.

Split of the patch might involve some code added then quickly removed
again, which I also want to avoid.

Considering the reviews done on this series (and the challenge of finding
hardwares to test..), I'd appreciate if you're OK we land this sooner then
rework whatever thing on top if the changes will be cosmetic.  That is, I
agree your question with the documentation for using "can" in the new API:
it is a bit ambiguous indeed.  I'll see how I will integrate them best, it
may depend on whether there're other reasons for a full repost / retest.

Thanks,

-- 
Peter Xu


