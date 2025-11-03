Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E544CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuR5-0002EW-A2; Mon, 03 Nov 2025 08:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFuQs-00028q-KK
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:17:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFuQe-0000Pu-RE
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762175812;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/y1A7Wv9IGnQ1yrnkvyXQhjR1x6a6i3Z/9tB3vLQpg8=;
 b=MrbG3/Eeo73+LeC7wa88yPxpphKyoj5ZGnJS1rp72J1Hc4Rit5L6kJk9d6O+QDcJ8EDwpR
 HN9Jy6LVhQ3hP52JF2cEzQNgRZWNWkOgOVmLpRwECL0G+QB+en2dC8h57NuFt0AE5kcKTp
 IdiHgaeVHtVrxqimYFye6Elyi1UhNyo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-FFZ-30RXNg6A2gjIk0qMQg-1; Mon, 03 Nov 2025 08:16:51 -0500
X-MC-Unique: FFZ-30RXNg6A2gjIk0qMQg-1
X-Mimecast-MFC-AGG-ID: FFZ-30RXNg6A2gjIk0qMQg_1762175810
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-475dabb63f2so21143295e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 05:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762175810; x=1762780610;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/y1A7Wv9IGnQ1yrnkvyXQhjR1x6a6i3Z/9tB3vLQpg8=;
 b=scNVoMNuhWXOtZaFwKowUVvylCuhYUJ73wBIycJA+5DQrv78OFpOdwizsIDGJbVcW+
 BsVDkwC+TZ9ciFnGulfEYyBPyBUtIGGewefGNRml+PP/fkdL/fuT8Hlwl3vuUB4BpJ4w
 yyrsuL/nsoiVT1UhzpyYna7KMDWLOvMSyLtdyBtxMDQ8h8MKVBDLBDqRu7TnDFSnOhm7
 ooRx/UHzUK7Xl2vfBng9ovLVNBZgHC7mSUE3FfP4a7bELIRp+xeWI/oqsSPYgb72SQFs
 EfLOzGLBWjVCB1kLYMfEmWR3d7tB/FXGve7m+SEYMPLQ49K4X2Kh9WUnyHF3DwoPZOvn
 wSaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtJM1/Hf7dhtlH2Mnv3cswVz8r9aDeDfomJrUOZFPgBZ5SGl499eUBVwaepMlCVhygiZCV3GNr7Qp1@nongnu.org
X-Gm-Message-State: AOJu0Yw59+5a9cde+Tk4NZC8uiILRCjnJi4JSP6W4XjG23lkkz1fI8OQ
 7V0j8UI+BVN8TOji6SJgr3s5TVOim4FPRKoZnH54lvYzptA7pkVh87fA+zv/7qefstxjG4mymoY
 oSRSatKypDTN3e9lK9o54w4Dgo3DCnxi6GN/I0Y2jMaVUDvtqS4f+zOrbBmL+JF5u
X-Gm-Gg: ASbGnctRtEAniLg9kdBxIzvG20quCqw78KErM35H5Fziyxb/uXAwlffiPbdQe6aWGi8
 p6NUd1qUtr2MO04QHJ9lEQaFmYpv7UMXT9/xyzQDVHMcXESXpz47BRtAor15kMG0D3MBXZsNd4B
 HskYz298bwUO0CruOJJvE1sVo0xI5gzLteACsywAJQSey4Zeh3A9JFyYWAiPE/FJN6HngSr4cnX
 GX2euKy7Sb9MiytXBpg78D5JjE5aoV+WV4FCLOvzTZww/p1+T7PlgR39zkkqOLYSrrGwa52MywG
 kxCkyhRA4RSnaDgN0fnK6AXDUt5rA5kpPjxn1dG3NQJJg1C9fB+ph4E8/MkLASCcTgC0mUPpwN5
 OaY/7Pp1RpQk36+lmQBJQxogEkFSj25xp5YP0JKk89rIfFA==
X-Received: by 2002:a05:600c:a345:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-477307c3595mr81274305e9.10.1762175809825; 
 Mon, 03 Nov 2025 05:16:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnUlUTC4J0S30TjFnwwvbwlLyIfdoJ5azeQcE7dEeYPZNjiQL2ekQckwklxIXoVg4mTaZ/xw==
X-Received: by 2002:a05:600c:a345:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-477307c3595mr81274075e9.10.1762175809382; 
 Mon, 03 Nov 2025 05:16:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c3a77b1sm157525835e9.17.2025.11.03.05.16.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 05:16:48 -0800 (PST)
Message-ID: <ba7d04b0-a93b-4776-8c91-412367aedf2f@redhat.com>
Date: Mon, 3 Nov 2025 14:16:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 21/23] intel_iommu: Add migration support with x-flts=on
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-22-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251024084349.102322-22-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/24/25 10:43 AM, Zhenzhong Duan wrote:
> When x-flts=on, we set up bindings to nested HWPT in host, after
> migration, VFIO device binds to nesting parent HWPT by default.
> We need to re-establish the bindings to nested HWPT, or else device
s/else/otherwise
> DMA will break.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

> ---
>  hw/i386/intel_iommu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index edd1416382..8fec61be3e 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4360,6 +4360,13 @@ static int vtd_post_load(void *opaque, int version_id)
>       */
>      vtd_switch_address_space_all(iommu);
>  
> +    /*
> +     * Bindings to nested HWPT in host is set up dynamically depending
> +     * on pasid entry configuration from guest. After migration, we
> +     * need to re-establish the bindings before restore device's DMA.
restoring
> +     */
> +    vtd_replay_pasid_bindings_all(iommu);
> +
>      return 0;
>  }
>  
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


