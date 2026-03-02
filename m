Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BAEEB3620
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 17:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx6kH-0006wW-84; Mon, 02 Mar 2026 12:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx6kF-0006vK-VY
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:07:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx6kD-0006d2-0W
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772471263;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+oQpBNNo4gl3vWw7Uae51pb033vs0p612iY93+q2Xc=;
 b=fDrDsXU6Z/Clc45yToR8sz2tP+K5zFLZxgQ50MPrhWEuKcnszu2XIdjUWl0T4WOudVFn5B
 ShoKzYQXtkBTx+cKpU6WjPDhSpaOwaqZbH8L00pCYD1IAg9hZF4zQNr6MgB9+HDW3KI/Km
 3Cr5w8cy1ulUnKf51D6qjtjOAVuTHM0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-vWLG6bvTPCOiuaPy0BhsiA-1; Mon, 02 Mar 2026 12:07:41 -0500
X-MC-Unique: vWLG6bvTPCOiuaPy0BhsiA-1
X-Mimecast-MFC-AGG-ID: vWLG6bvTPCOiuaPy0BhsiA_1772471260
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836c819456so32556465e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 09:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772471260; x=1773076060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+oQpBNNo4gl3vWw7Uae51pb033vs0p612iY93+q2Xc=;
 b=ww8gaw+O9LR1JPXVNDOggRNg0FS7qpYFj7T/TQy2oyDg3gYbXaePWSNuMjQ8wKHST+
 uM/x8zfUiFoKaKOQYOciDBemATgM8VY3ZG4ruCHS7gzzNTcEvO6/tkccx2JlBfnu86yY
 LK2dZUO5yKYUSciGN9GDzSkqKdSitCT6J9529fXPJF+Zz5/WR6H6tLG9fRFvEzy7aP04
 OOcELd24IFKyJQm26GdFCJlYEFQ01uyoiE11rJncLBAFnluk2vSisI61M5PpD06Zut1f
 EK2h1iy+H8m2rtiIblYEbj9dMg8E5SE+LmpldGPhb0BQTVcpUjpE1rmcQz/0ACdiqqHC
 M4EA==
X-Gm-Message-State: AOJu0YzSQhrG8hO7UoWt3KIjzdYEYJ/qlp4nFV/fgrjs1MSEFCeIRr4S
 k42jU2jjSV1OplK4u0NPhKUjYtmQHnMWUtO4cy9swyIElca5XMtTVKOBFYtScPRSPUM9/NozjrC
 VX47bOeOWAfuLFrgYrdfJXJdzC9D9NvWTbPOn310S0qswjgff9QbVu9xe
X-Gm-Gg: ATEYQzy2rBx6zi5dSZB5J/DLot+w+4/1fgfhSrBNoDfGZnZWURBlkxesyh58x0xZw9Q
 Tw7/T+qn1930Qjse8nVQHmYj9y78dIhY+m4IH7zMJOSvRfworb0XJ4C/b2g3pFXk/TiB7C3i57v
 4llo+OMLvKIMwQPEFt7VBlKkgm26TQsofn6lbKpPS7XuuDhrhetbWGO+hRhh5hbmHqUqyPFG4ed
 5itdqzM5KXLeMLuxTDx705hQevKhh4B/RcrcYrMn/nF2xQ5eSj/oXMzVF6ErOGGEIzTc3WMHwFM
 vHQniWOGWzm2kBvT20eEv5/+H70tOMsHMEA3stVCUbK5/QjFmI9NuHiPr1BRjgq7Pant/qi6EfX
 ZoKnoiOO/yskQIOVLkvD/McYcOsrHPhy8zU3mUTtuvxQQN9TMbVYnNyrkXWKsISZPXzn+HA==
X-Received: by 2002:a05:600c:8106:b0:47e:e8de:7420 with SMTP id
 5b1f17b1804b1-483c9c1d4bamr211427965e9.22.1772471260401; 
 Mon, 02 Mar 2026 09:07:40 -0800 (PST)
X-Received: by 2002:a05:600c:8106:b0:47e:e8de:7420 with SMTP id
 5b1f17b1804b1-483c9c1d4bamr211427245e9.22.1772471259939; 
 Mon, 02 Mar 2026 09:07:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb29715sm310318445e9.0.2026.03.02.09.07.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 09:07:39 -0800 (PST)
Message-ID: <67ce2d21-0b7e-4f21-aa3a-d4a7dc52a059@redhat.com>
Date: Mon, 2 Mar 2026 18:07:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 11/31] hw/arm/smmu: Add PTE NS/NSTable helpers
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101544.2992355-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260221101544.2992355-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/21/26 11:15 AM, Tao Tang wrote:
> Add helper macros for NS and NSTable bits and group PTE attribute
> accessors for clarity. No functional change beyond the new helpers.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmu-internal.h | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
> index d143d296f34..a0454f720da 100644
> --- a/hw/arm/smmu-internal.h
> +++ b/hw/arm/smmu-internal.h
> @@ -58,16 +58,28 @@
>      ((level == 3) &&                                                    \
>       ((pte & ARM_LPAE_PTE_TYPE_MASK) == ARM_LPAE_L3_PTE_TYPE_PAGE))
>  
> +/* Block & page descriptor attributes */
Maybe use the spec terminology:
Stage 1 attribute fields in VMSAv8-64 Block and Page descriptors
vs 7 Stage 1 VMSAv8-64 Table descriptor fields

By the way AF belongs to both

> +/* Non-secure bit */
> +#define PTE_NS(pte) \
> +    (extract64(pte, 5, 1))
> +
>  /* access permissions */
>  
>  #define PTE_AP(pte) \
>      (extract64(pte, 6, 2))
>  
> +/* access flag */
> +#define PTE_AF(pte) \
> +    (extract64(pte, 10, 1))
> +
> +
> +/* Table descriptor attributes */
>  #define PTE_APTABLE(pte) \
>      (extract64(pte, 61, 2))
>  
> -#define PTE_AF(pte) \
> -    (extract64(pte, 10, 1))
> +#define PTE_NSTABLE(pte) \
> +    (extract64(pte, 63, 1))
> +
>  /*
>   * TODO: At the moment all transactions are considered as privileged (EL1)
>   * as IOMMU translation callback does not pass user/priv attributes.
Eric


