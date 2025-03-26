Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1541C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 13:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txQzC-0008OU-Vp; Wed, 26 Mar 2025 09:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txQz5-0008Lz-LV
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:39:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txQz0-0000ov-O2
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742996384;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LeQkt2IuYTyr4XDk0FlNiWrsm07L59YTJwlvktEcskY=;
 b=HKutMpTOReCFns1n/O52T0NC1dnh0javlCBDni1U89Iy8ZN2kdy5zJN/khwWy6YQiIi01s
 o3Q/ArZiaZjFhd0MLmckMwHYfalqPy3bbgWrAm74TVc4l4bQUbZjgG+fYfwoqGOHfA9dhc
 yyvUtw/qFSuQ2pKCtZstLVzGhpAzU3s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-kodNo_vxO0Wh_mTySG-qhQ-1; Wed, 26 Mar 2025 09:39:40 -0400
X-MC-Unique: kodNo_vxO0Wh_mTySG-qhQ-1
X-Mimecast-MFC-AGG-ID: kodNo_vxO0Wh_mTySG-qhQ_1742996380
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d734da1a3so8832195e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 06:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742996380; x=1743601180;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LeQkt2IuYTyr4XDk0FlNiWrsm07L59YTJwlvktEcskY=;
 b=pe7pTcrjGDkQ86jiP9jV5bWWLwc6A5fvLC2lwcZjhC2HXsubTtG2rppC8YbSK03GEI
 pW2sUXSYibKFxyI5IxITnem4QcV+tccGzcyCeUeZ0h5qCl5lb3o4/zbADGnp40644X9d
 nLRVIcRnP0ONphGJs+I9HCgms3b8N3hcZZbEMjTMeHf+XySYT93rQFHUpmxgNxNeBPCi
 m9oxh9RDDAj33vGGj3dgl/oCyzgjvUsSavelBu4IC1U+8JP1ruD5oWfXOilDERA8yNER
 LvRVypvQSOWekUv36ZubfXddgDS64wa7USg4UCJhjROjeR7ykcFnME9D4fAYf1b0nLQk
 U6Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRAaZrYDfHHnRNDdrvQGOj2igv3p9N/gLOpV8WX2SYTl0puUJfnTpDhg3HUpUW1leeSsP2WkFc/evk@nongnu.org
X-Gm-Message-State: AOJu0Yz4uk6GbS451u5Qke09Z9cNguLtbGxVvRrQm8mS3Vlkz8YpYn90
 b6WnvAnJxWIDvz6KB2c1/Tg75o5DiffWQmXMbhEF+1gdTPtc2PxQtWnrLxPyW1LbCXyG/tl+Bqx
 xeUH6rzuQA2c6nfKLlwc+6B6uEjqqxsY8XqufIapxNaQLYJr5MboO
X-Gm-Gg: ASbGncswfwND7Vn25uX3syXyW212q8FzvXUahGspcFUC3ccMMMtwvtUBUJXi1U5uLm7
 dJW11LdJETVBKbThk5E1ZsBDZDViwwTonoJkY703+WZ9U8tXOkRi3CGUiOrHN3J+aZCpjp6PkbR
 kTLTsxuC0LnRb83uScWHP/x5Xsl8uw99eZKCmUL5b4DHxOyuIlkhefKncWC5WtBaaSEd6MzcO5n
 07y+HjTiFigtmzyz4YNSw2gAlwudShGM+s4IzwZkJ/x7uIKHyYHWNyHqv1Y0t28gdkW7x0LZdf4
 cfOrwiQyLg+0vLEyyQsVFT60YAd3NRU6TCyMGLH29H1ikaNkckqEK7KtnmSTUgE=
X-Received: by 2002:a05:600c:1913:b0:43d:649:4e50 with SMTP id
 5b1f17b1804b1-43d509f67d4mr193754065e9.13.1742996379696; 
 Wed, 26 Mar 2025 06:39:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfpMZZvtuel94Pq5Aw+yEO5ml7rnu3TsT0ENpdA+B5Zm8bAH4vgakO8emO32YzRYRhP5qtjQ==
X-Received: by 2002:a05:600c:1913:b0:43d:649:4e50 with SMTP id
 5b1f17b1804b1-43d509f67d4mr193753725e9.13.1742996379309; 
 Wed, 26 Mar 2025 06:39:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d830f59d0sm2159035e9.28.2025.03.26.06.39.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 06:39:38 -0700 (PDT)
Message-ID: <a3d32485-90c9-46da-bcf6-577bd880ce81@redhat.com>
Date: Wed, 26 Mar 2025 14:39:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 14/20] hw/arm/smmuv3: Install nested ste for
 CFGI_STE
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-15-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-15-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> Make use of smmuv3_accel provided _install_nested_ste() for CFGI_STE.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index ea63731d61..83159db1d4 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1286,6 +1286,7 @@ smmuv3_invalidate_ste(gpointer key, gpointer value, gpointer user_data)
>      if (sid < sid_range->start || sid > sid_range->end) {
>          return false;
>      }
> +    smmuv3_accel_install_nested_ste(sdev, sid);
>      trace_smmuv3_config_cache_inv(sid);
>      return true;
>  }
> @@ -1353,6 +1354,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>  
>              trace_smmuv3_cmdq_cfgi_ste(sid);
>              smmuv3_flush_config(sdev);
> +            smmuv3_accel_install_nested_ste(sdev, sid);
>  
>              break;
>          }
Given the small code diff I would merge this in the patch that introduces 

smmuv3_accel_install_nested_ste


Eric


