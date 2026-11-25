Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52514606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 20:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=guk1Kuu2;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=uOBaPOFV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWJbl-0004yx-OM; Wed, 25 Nov 2026 15:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWJbj-0004wc-EK
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 15:28:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWJbh-0007OG-8g
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 15:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795638523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/u1HPvpYaXUfrMG1QI92Km4RL67LsmGRRjh2a17tnuQ=;
 b=guk1Kuu29duU1bgGSDJbH121d2wOOz1D2LxXlpRtasFLiLUvVZ/5UVOo3FspRB0sHVmAkx
 6Rhy/ItsgCHDgZUEASKcaWhnUGGtB76cSLm7kYgezOSk2TKRiWYlWtiz2J8VxxBZ+bUgn+
 ioeLxMt/rR8HyBA4nWHpTTIH8DuL/yc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-5eZlpx_1OhKJOg4HsBxy6Q-1; Wed, 25 Nov 2026 20:28:41 +0000
X-MC-Unique: 5eZlpx_1OhKJOg4HsBxy6Q-1
X-Mimecast-MFC-AGG-ID: 5eZlpx_1OhKJOg4HsBxy6Q_1795638521
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f5844e383so951935785a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 12:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795638521; x=1796243321; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/u1HPvpYaXUfrMG1QI92Km4RL67LsmGRRjh2a17tnuQ=;
 b=uOBaPOFV2+4dsu/oLDDNg5U35vDQ1pkk71Gvn0w/J+rcW2+LhNhGLtpyVZrl8zcsqE
 HnLJP+7TUXT456WYuSY8bT7WekqYtkwA5GYRLZqyNiUyzyuk1OzonnKwf3PPkFXP/AR2
 iFXjQ8x6tcUP9G/FxhfCKCtDefm6J9BNHFOk2HMDqffwolFTEXBsJScCrhZvmDmNEJbF
 dB+8oZJ9mujpmGE6ERU5fm9E7KOTkADk4/njEbrAduHOq5NqB1OTjVOof11KI6zt2/d9
 uKVGlIkO8X8yKIX3M4wSxOhPTXTOEIIynJFSE7aKrVPuKrZgfBsU4Ff1C0MRj8Q/9tYr
 RJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795638521; x=1796243321;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/u1HPvpYaXUfrMG1QI92Km4RL67LsmGRRjh2a17tnuQ=;
 b=CQikPh8HjjUHb70Y0poGZhMKCDTcP6sMKR4MnShDCDUbmi9/uE3y5tvVIUXA1w/6zq
 ne/iO0MSUWvxjF3cBobdRb0pDNmK+cTZKvyHR0ZDjZnI//gGwfARojuw1MFNeJKz4FmM
 EtzJTU8PxMZjYWskDEy5QTOVSlQrAHrUya6ZGBKT4eM5vrjgyffGH5HZvd5uGJV+bJQ/
 povyWcPCF10T2J9S+y5kZUvMnfSFDATqtcDq4ZPhRF6IOoc+iZPZBafXdTY08Jn2yh+Q
 15IndHdSbvX8KlGWeqPQr5EGzMQcZFPSmss/dzHvzwHgLghfAVdlELMlBaOiTV+lptfG
 IEDw==
X-Gm-Message-State: APuU4Z9ieb0AqYnzH5Lj5jWYx4uTKfs51d3gE9nLOHApS+EFuZ1SenPb
 Lm0k2RvRU6c4zR3YnUqygSpJnkrEK1Af3OwzvyUNqlM4QG87rgtX9lqxLfrMttzal7tcVWOgqWG
 ZDvld/j+fTDz5PbHdavc7aeE8oBnhGZk51dDsXPGt9pM+W535qN+l+Hre
X-Gm-Gg: AZFdTZcP2KVi7GYWoJHK7WaOMkhsPjW8fsnP5+/8a3Hnqb1uZCiqaPw6KR1vuaHjSyg
 lbdeKlO6TRuTdPjO9uze0N3y6KdAcJ3c34mOSncbb2D87XD5mAsMCUuPLd8+JEmfn6XpA0tmIiO
 7dW/zfOhKzJxd1nrfUz3AUvX0JY6gX3lR2eDNYTe5urXmL8iZnY3JYzzL2SSdHFpwHyMPI787u4
 sHhrhSyHC94bR+4wix6V55Amj5rrdDJOWgWs7dUz7AWPLEBxg94famkAzJaTq3vHAXX0GPjwpez
 e0D+xmESsLgMND0aX2oDAB2GN7Hwtxc54vwB3e8TD2VBOMTLTzCJ9fARWN+lweLB9pqQDOx8j0Z
 F6uc62fu7vnASzg14v/CXOhqxyvxBbEC6l5P+A8J0dN7c
X-Received: by 2002:a05:620a:538e:10b0:94a:8bf:19bb with SMTP id
 af79cd13be357-94a08bf1c54mr340991685a.33.1795638521083; 
 Wed, 25 Nov 2026 12:28:41 -0800 (PST)
X-Received: by 2002:a05:620a:538e:10b0:94a:8bf:19bb with SMTP id
 af79cd13be357-94a08bf1c54mr340988685a.33.1795638520452; 
 Wed, 25 Nov 2026 12:28:40 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb3ba04bsm1423731085a.24.2026.11.25.12.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 12:28:39 -0800 (PST)
Date: Wed, 25 Nov 2026 15:28:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org
Subject: Re: [PATCH for-12.0 2/6] hw/gpio/zaurus: Move VMSTATE_VALIDATE()
 check into post_load_errp()
Message-ID: <awdE9g3mio3cXNct@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261120124923.1656220-1-peterx@redhat.com>
 <20261120124923.1656220-3-peterx@redhat.com>
 <CAFEAcA8i1-QX-x+fvcfEMknia1owTAukRxNQ1Rb0H6KnwCKt2w@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8i1-QX-x+fvcfEMknia1owTAukRxNQ1Rb0H6KnwCKt2w@mail.gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 12:21:37PM +0000, Peter Maydell wrote:
> > -static int scoop_post_load(void *opaque, int version_id)
> > +static bool vmstate_scoop_validate(ScoopInfo *s)
> > +{
> > +    return !(s->prev_level & 0xffff0000) &&
> > +        !(s->gpio_level & 0xffff0000) &&
> > +        !(s->gpio_dir & 0xffff0000);
> > +}
> > +
> > +static bool scoop_post_load(void *opaque, int version_id, Error **errp)
> >  {
> >      ScoopInfo *s = (ScoopInfo *) opaque;
> >      int i;
> >      uint32_t level;
> >
> > +    if (!vmstate_scoop_validate(s)) {
> > +        error_setg(errp, "irq levels are not 16-bits");
> > +        return false;
> > +    }
> 
> I would put the condition inline rather than into a function
> (especially since the function name is not very informative).
> Otherwise this looks good to me.

Will do.

-- 
Peter Xu


