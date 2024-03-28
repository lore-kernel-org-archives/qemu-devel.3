Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF6FC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 07:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpkal-00064G-Tm; Thu, 28 Mar 2024 03:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rpkaj-00061Q-F8
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 03:54:29 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rpkah-0001zC-9j
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 03:54:29 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-dcc80d6006aso619501276.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 00:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1711612463; x=1712217263; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QbC5cWd3WAP709PDHIqZn6WUv4KT91ju291e26yekHU=;
 b=N9/T4a39rksD7R+ZbCYyKFqSv2p+TLMqCningNcIJY5mnZ8SuPrq8nEx543dXCu4cp
 POoeCU/xoic0N1+AnD0/o8xBYKELCuNcdanGYLWlprmrbsZ3KPonWHCwK2F15kMrDtB9
 GEP6giDxT2GjDUNjE+CFq4PSFwhjx+DNHwrc6C3g54y2Hjv1Mu0c5uvcDfon0W2g2sl1
 hA7kOoh3zZzEICbOs4yBWmEKBXss4MDOn7n6hvdCa8htL6g5JeRwK2T0VHXs+qp6rPro
 wkm9ZFXoSuLZdY8YQS92xdaQX/LzfImEvUCUgN2hGXqi9QRcpmX9YoDQoTFAjb/BFXMS
 d1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711612463; x=1712217263;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QbC5cWd3WAP709PDHIqZn6WUv4KT91ju291e26yekHU=;
 b=wtWZ6WdLNpmFhmqpy3xsK1o/Nnu+DKKCm5VLT6q/2KVwndrMY5dh8q2yOu64xBD1bc
 Y+x2YVTJc9j8bOMOsn3vowqVrrhU15XzYnuwyNjHybcGj3lyVKRDaatEGVY6kZfVoCcP
 XvCtcK0+Gl2IHnKiwn1sE/gGR7JVR7l7BN0dLfcNqQeo7jJCVgh2VzdbhNSjYvj6dqZp
 p8ewArqH4/7e13a8KHnMa0dOcqZbTE2Z1oTqDQThjOCbteD1Lc/QGbo9KI4u0XfOb8BB
 M7SNe3JG0BkWropUkOJA8ag2F0F22lxpQCYvR7E8kV+2Y1FqMj9JZOalhzlxMvYU8GWd
 qzvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEO/6vJOZv8EEJjk1plmV7eUP2JRIZTk82Rfccx42Nr9nteYjlF51zql5ZWgV4iZwf1UPVy9jyS3T5F1vyhQY0LprkKIw=
X-Gm-Message-State: AOJu0YwELku7TjprO8fUXGBetrygAVsu78EP27FYfDG8kvx2NHH7xS9I
 MtkPLozHICiBaMsCsCJnRYfO9XnbIs8+ROavGraDaOisO1h5l+7lk5D3k2RdNFmMvw9DljyxLRy
 NvDVFJSVNbZDoZcS0S6yXzQlJKkG+to04b21S+g==
X-Google-Smtp-Source: AGHT+IEdkLQhpRPn4k1IyjPDs5Vv2uuU8cYVmBxxxsVzJXO5QupQAGy5BtVXsboyybOzZeHVOtwZZhZHHoOjBTG7fIw=
X-Received: by 2002:a25:ab26:0:b0:dc6:a223:bb3b with SMTP id
 u35-20020a25ab26000000b00dc6a223bb3bmr2099954ybi.46.1711612463662; Thu, 28
 Mar 2024 00:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240327072729.3381685-1-horenchuang@bytedance.com>
 <20240327072729.3381685-3-horenchuang@bytedance.com>
 <87v857kujp.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87v857kujp.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Thu, 28 Mar 2024 00:54:13 -0700
Message-ID: <CAKPbEqrhBLQ67ciUTukGTB0eC3G_JHcTEMfbiw_PtnGBSv=ksw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6 2/2] memory tier: create CPUless memory
 tiers after obtaining HMAT info
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com,
 mhocko@suse.com, 
 tj@kernel.org, john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
 Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
 Alistair Popple <apopple@nvidia.com>,
 Srinivasulu Thanneeru <sthanneeru@micron.com>, 
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
 nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org, 
 Hao Xiang <hao.xiang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=horenchuang@bytedance.com; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Mar 27, 2024 at 6:37=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>
> [snip]
>
> > @@ -655,6 +672,34 @@ void mt_put_memory_types(struct list_head *memory_=
types)
> >  }
> >  EXPORT_SYMBOL_GPL(mt_put_memory_types);
> >
> > +/*
> > + * This is invoked via `late_initcall()` to initialize memory tiers fo=
r
> > + * CPU-less memory nodes after driver initialization, which is
> > + * expected to provide `adistance` algorithms.
> > + */
> > +static int __init memory_tier_late_init(void)
> > +{
> > +     int nid;
> > +
> > +     mutex_lock(&memory_tier_lock);
> > +     for_each_node_state(nid, N_MEMORY)
> > +             if (!node_state(nid, N_CPU) &&
> > +                     node_memory_types[nid].memtype =3D=3D NULL)
>
> Think about this again.  It seems that it is better to check
> "node_memory_types[nid].memtype =3D=3D NULL" only here.  Because for all
> node with N_CPU in memory_tier_init(), "node_memory_types[nid].memtype"
> will be !NULL.  And it's possible (in theory) that some nodes becomes
> "node_state(nid, N_CPU) =3D=3D true" between memory_tier_init() and
> memory_tier_late_init().
>
> Otherwise, Looks good to me.  Feel free to add
>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>
> in the future version.
>

Thank you Huang, Ying for your endorsement and
the feedback you've been giving!

> > +                     /*
> > +                      * Some device drivers may have initialized memor=
y tiers
> > +                      * between `memory_tier_init()` and `memory_tier_=
late_init()`,
> > +                      * potentially bringing online memory nodes and
> > +                      * configuring memory tiers. Exclude them here.
> > +                      */
> > +                     set_node_memory_tier(nid);
> > +
> > +     establish_demotion_targets();
> > +     mutex_unlock(&memory_tier_lock);
> > +
> > +     return 0;
> > +}
> > +late_initcall(memory_tier_late_init);
> > +
>
> [snip]
>
> --
> Best Regards,
> Huang, Ying



--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

