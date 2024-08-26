Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7593C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 15:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sibXp-0005k3-Nn; Mon, 26 Aug 2024 11:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sibXn-0005gx-8y
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:22:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sibXl-0002P5-1y
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724685727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rpDUIj+/s2O8U0ZT07mIxbDe+cs2MYIuzBPPtLuP76k=;
 b=D8mT9gRRzDesCCQ1QGsTJL1Bc0+bPOZp7+lMyxzN6vUQE3zgpU9As+WSwRIn7V3HKNfQei
 53VdGg71GYq6mNRJs22f4JlzQ2I/duY8LZiHdyFHguHbhdSkO7wceQQp6vG10A9d3IA2sQ
 qlOqL2SsJooqFSTKQ9rXBtMuUcq+T+w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-NVuLTDoMNtyjXIGB7JFDAw-1; Mon, 26 Aug 2024 11:22:03 -0400
X-MC-Unique: NVuLTDoMNtyjXIGB7JFDAw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-44febfb1ae4so69328701cf.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 08:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724685723; x=1725290523;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rpDUIj+/s2O8U0ZT07mIxbDe+cs2MYIuzBPPtLuP76k=;
 b=B8Vx6g9EWy1tTNHwAbOjVKssjcYxlwaqbk5LaN1bmk/nvnYYDamjIMJzs1mNVt4QYT
 6CZR1Z04aYbQZI7f3BWjQNGGSj3WL6ry4Xb2z5BchMqkysRn4rqjR1LnoxNWn/O16KKJ
 NN2x6tUjZ0mARHSCZLBNuBGAj1luDudVPsVP0T868vw2fhGaLbHXVZBoIIB7MB13S+XX
 SGUAaxoveFBUnrWRf/W/HBrSJVP4a3WEN3fAZC6MQDoqklpruLAAJf9npGDgWU27TQSW
 FZE6dBtA6CfPDzls6phTjf6OND/wcCuHkjc6n4z8zgXeHdbDH7elHMV67SCh7f9+lhfw
 fjFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX89N+zr8BVUkMzca9geoF4+godP7Q5FyITvS9gpVztp0e3BpXecHSP0IJa7jF9mTi56dyMMFjlhSZn@nongnu.org
X-Gm-Message-State: AOJu0YzNnXtxrkf2VuXHtIoiA36+i4+EkpVhrBpF7rfnFpaQBjG9Wry7
 QtTuc1IUVHLNpUEPfOIyJ/QjgygvJ01Ri5ztJZSdWOmeILdSbYfRAbjMxI/VySUh3c7MGyxqfG0
 5VKGbtaWBCxmWZelvvssIZr22Ni7JG88cWrks5S2/EaRKrnJAn0cj
X-Received: by 2002:a05:622a:551b:b0:447:eb43:5d0c with SMTP id
 d75a77b69052e-4550979d7b7mr155932761cf.59.1724685722963; 
 Mon, 26 Aug 2024 08:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqPkRki0Rb4jc+M5wsGa9U2kD3icuGlbDJWO2kBPg94ddCP4gNxvaaPd4tbXf6hw5dgitB/g==
X-Received: by 2002:a05:622a:551b:b0:447:eb43:5d0c with SMTP id
 d75a77b69052e-4550979d7b7mr155932171cf.59.1724685722561; 
 Mon, 26 Aug 2024 08:22:02 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe0d913dsm44541741cf.32.2024.08.26.08.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 08:22:01 -0700 (PDT)
Date: Mon, 26 Aug 2024 11:21:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v4 6/7] memory: Do not create circular reference with
 subregion
Message-ID: <Zsydli9ME1u79A9X@x1n>
References: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
 <20240823-san-v4-6-a24c6dfa4ceb@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823-san-v4-6-a24c6dfa4ceb@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 23, 2024 at 03:13:11PM +0900, Akihiko Odaki wrote:
> memory_region_update_container_subregions() used to call
> memory_region_ref(), which creates a reference to the owner of the
> subregion, on behalf of the owner of the container. This results in a
> circular reference if the subregion and container have the same owner.
> 
> memory_region_ref() creates a reference to the owner instead of the
> memory region to match the lifetime of the owner and memory region. We
> do not need such a hack if the subregion and container have the same
> owner because the owner will be alive as long as the container is.
> Therefore, create a reference to the subregion itself instead ot its
> owner in such a case; the reference to the subregion is still necessary
> to ensure that the subregion gets finalized after the container.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  system/memory.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 5e6eb459d5de..e4d3e9d1f427 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2612,7 +2612,9 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
>  
>      memory_region_transaction_begin();
>  
> -    memory_region_ref(subregion);
> +    object_ref(mr->owner == subregion->owner ?
> +               OBJECT(subregion) : subregion->owner);

The only place that mr->refcount is used so far is the owner with the
object property attached to the mr, am I right (ignoring name-less MRs)?

I worry this will further complicate refcounting, now we're actively using
two refcounts for MRs..

Continue discussion there:

https://lore.kernel.org/r/067b17a4-cdfc-4f7e-b7e4-28c38e1c10f0@daynix.com

What I don't see is how mr->subregions differs from mr->container, so we
allow subregions to be attached but not the container when finalize()
(which is, afaict, the other way round).

It seems easier to me that we allow both container and subregions to exist
as long as within the owner itself, rather than start heavier use of
mr->refcount.

I tend to agree with you in another thread, where you mentioned it's better
we get rid of one of the refcounts. If not trivial to get, we should still
try to stick with one refcount to make it less chaos.

> +
>      QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
>          if (subregion->priority >= other->priority) {
>              QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
> @@ -2670,7 +2672,9 @@ void memory_region_del_subregion(MemoryRegion *mr,
>          assert(alias->mapped_via_alias >= 0);
>      }
>      QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
> -    memory_region_unref(subregion);
> +    object_unref(mr->owner == subregion->owner ?
> +                 OBJECT(subregion) : subregion->owner);
> +
>      memory_region_update_pending |= mr->enabled && subregion->enabled;
>      memory_region_transaction_commit();
>  }
> 
> -- 
> 2.46.0
> 

-- 
Peter Xu


