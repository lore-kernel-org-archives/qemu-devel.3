Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DAC606A32F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J+sMRlka;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AeLVb9pa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTIAi-0002v3-2Q; Tue, 17 Nov 2026 07:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTIAc-0002t8-SM
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 07:20:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTIAb-00019f-7C
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 07:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794918016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xbz+UAOwro+MgOYX+zRlSeI4RX8q5d0fHP5no+EK8S4=;
 b=J+sMRlkaWCKwGNmrBjDfy8f4KPLJnjkN4cqmTULJx7HhyZ9cFfkLmH6Q+oxfvRdvwfer/G
 pTfSoOj3n4g8Q1dpPprghAPspLaVu9VLnQql1okibnuGCPLAmQ8IV1XFQ9rc4qYFwCkk5D
 Rvg88XZisIQZ/f94PUYMyRrFCGflZSE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Uk5eYq6PN9yG8GLouBrGnA-1; Tue, 17 Nov 2026 07:20:14 -0500
X-MC-Unique: Uk5eYq6PN9yG8GLouBrGnA-1
X-Mimecast-MFC-AGG-ID: Uk5eYq6PN9yG8GLouBrGnA_1794918013
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a359b714f8so25007645e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 04:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794918013; x=1795522813; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xbz+UAOwro+MgOYX+zRlSeI4RX8q5d0fHP5no+EK8S4=;
 b=AeLVb9paAzMmsxwKMGD+tMO75sICs5rimKVbte74U1QVejaU9H5bGaw3+09cnj+LC3
 4NRUCL+Idmwu9ZT3B5y0KhP/iGvesUg8shqDC9EBEgn8K3j8D7dmVFm9Pm3SIAzptFxU
 75veZSC/fxxUjCm5NyyW/V1OfTRgfFhRN8OQQzlP1Ko/2EtCSwf+oUMA5eKJBg4Rrjam
 MZBOMZVbO6CGeQfjnIYY5tN3yM0Jug1ZwcGz6nHYIe6xblIkfjSs6QA0jRcP8fjru4UY
 SQ0RIR3qWEXN3mucrwCrczp8I+lTDOI32kZ0eAuo6AHk0Rqfcy7wbehZOBOw3cyX31OO
 exjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794918013; x=1795522813;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xbz+UAOwro+MgOYX+zRlSeI4RX8q5d0fHP5no+EK8S4=;
 b=BzlXz9F96rkG156r3uE0SMsFb8/oGK9H+ZiSYAp0H+iGzsLzmn640C0+ivnbIbJXqA
 3tcW+5m1B3PR6eHChLODaktxGS9JG6xQO/StH8MfbrRnHt1rdAggPs1DGOi8o1LRhFIT
 AJknTNhvvygonld0PSFWrvrpoSdhNi6eeI23/DElZ+saQUHSLQ+X+D7oz9l469TZb+jy
 utOGRBonLOSMr17yDDqnlwvQQVin+/E4BUA2XNii1XvTEgAzeEVH0OPTNcGa0D1XEDy8
 xs1lR+d7hXv1rkQNRuxMgfRV14OmdMe8/4+X+j6E5Ec8yglFGktKf8Q17WaFnMR/iXrK
 fE9A==
X-Gm-Message-State: APuU4Z9hdnGYSh0q3xpa0exy3a3Yv2fSdIq1DkqRZuQ1/i8UP6zczWjv
 +TJ99cxSM5nTXlqz9CV0rSaVA6Fwv5uWUZsMkaCSwC2wp9HMsIDWYsLz7uUcHoS7U82WTSIVgdk
 GdwXCFlT0X8Kw1lCqbO3dtMho1EY2q4BuPTGkCSIOq31GF5EYsuFHhxD8
X-Gm-Gg: AYBFou32nQUk4IxbkHrxzprjflTU715x/iHyzR5y+amBtIqsFzNFVa01BTORRZDPcKb
 mxQv/oLsCui8JM59h6oTyagJF5XnOOjUmh+X9dZqdX9Vg6qaHhFbWJ/xleezY1g9PDbgAqg0vWj
 YxKkJWmdKaDXjOuAF+3JV4aSTaa4/FOObyrMQ4W6LFVEtaBz9pgCri88N6X5aRxMUvY7yoGShRO
 wm0D8G/sUUyd1MCqWVLGb5bzFKihSTBU7tbElz5OJtsConk7QKWYTztNjnHtarKebBrpRdsVF5i
 vHmjEUI9J51gVtoy4TnVnVec/sk92idxvLz6d91U74okD/qEP/+zHv86PM8/vwroyThLgmJV9OF
 N00yZBTIlLqMv0RXyw3dx5pLLqqJ7VLQv90iYUGfjXUA=
X-Received: by 2002:a05:600c:1d0e:b0:4a1:825a:56fd with SMTP id
 5b1f17b1804b1-4bb55aa28e9mr298035525e9.32.1794918013018; 
 Tue, 17 Nov 2026 04:20:13 -0800 (PST)
X-Received: by 2002:a05:600c:1d0e:b0:4a1:825a:56fd with SMTP id
 5b1f17b1804b1-4bb55aa28e9mr298034415e9.32.1794918012251; 
 Tue, 17 Nov 2026 04:20:12 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783854cesm100381835e9.1.2026.11.17.04.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:20:10 -0800 (PST)
Date: Tue, 17 Nov 2026 07:20:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anton Kuchin <antonkuchin@nebius.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, NB-CoreTeam@nebius.com
Subject: Re: [PATCH 2/2] hw/acpi/aml-build: Avoid overflow when advancing the
 free_base cursor
Message-ID: <20261117071926-mutt-send-email-mst@kernel.org>
References: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-0-0cede42456c4@nebius.com>
 <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-2-0cede42456c4@nebius.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-2-0cede42456c4@nebius.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Nov 07, 2026 at 12:59:49AM +0100, Anton Kuchin wrote:
> crs_replace_with_free_ranges() advances its cursor past each used
> range by adding one to the range's limit. If the limit is
> UINT64_MAX,

when is it UINT64_MAX?

> the cursor wraps to zero, potentially producing free
> ranges outside the requested window or overlapping used resources.
> 
> Adjust free_base and stop processing when a used range reaches or
> exceeds the interval's upper bound to avoid cursor wrapping and
> final free range insertion.

was this tested? how?

> 
> Signed-off-by: Anton Kuchin <antonkuchin@nebius.com>
> ---
>  hw/acpi/aml-build.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 90837b513e69..b71d82b5e8a9 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -154,6 +154,12 @@ void crs_replace_with_free_ranges(GPtrArray *ranges,
>              crs_range_insert(free_ranges, free_base, used->base - 1);
>          }
>  
> +        /* avoid free_base overflow when used->limit equals UINT64_MAX */
> +        if (used->limit >= end) {
> +            free_base = end;
> +            break;
> +        }
> +
>          free_base = used->limit + 1;
>      }
>  
> 
> -- 
> 2.43.0


