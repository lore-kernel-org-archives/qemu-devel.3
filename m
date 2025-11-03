Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54457CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFw1z-0008Gh-5v; Mon, 03 Nov 2025 09:59:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFw1w-0008EB-Dy
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:59:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFw1j-0007tX-Hu
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762181958;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GUMmQNsJ4EY099ozgwM+CkiCSbJhC+x0O1MF0oGmAhk=;
 b=MW3NvYYqnKnxecTgFALDAyiinYdJ/ASUbXk0lphyzn07S7WyOiLrseqhuragr2oUTHfTog
 E930stawD5KnSlWbB/Bz6+3y08xq0uaP89JVxPFz14BoH+bHqrs/9F5/0/XwDMFwF6sws4
 GJ23OvlZ3WkzogI/c89uhmcVKaIAdDE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-lhjl55iIOwmNy6lnNCpXSw-1; Mon, 03 Nov 2025 09:59:16 -0500
X-MC-Unique: lhjl55iIOwmNy6lnNCpXSw-1
X-Mimecast-MFC-AGG-ID: lhjl55iIOwmNy6lnNCpXSw_1762181952
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b4626b2d07bso320334466b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 06:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762181952; x=1762786752;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GUMmQNsJ4EY099ozgwM+CkiCSbJhC+x0O1MF0oGmAhk=;
 b=vTJ0PH+f6UE00gq3TZD/RV2DBFqLjahdqvhp4MypVjp/Q71yWQhuh9VaFppIjWFx2F
 qc7nolFrl3IzJwLtXLAbAL1hYFKCK6sq8i4bPklt4TeEriKQp6DgW+FGsTZCRknMR1FH
 YdpFvJP2ieNwR2JDlAeyJyWirw2XPwys/QfOF5ydRYW2tFSiA0pN/MV0HpD5zS2L8g/9
 uwuhB1uh5sxwJLQvVz1Iyyr0TieX6B5bx6iDMwIP2BlI4fPAAhAUOnyLIPSEncinjyIe
 eJOz7wJkjJqXSB7EnFFPhDl7gQRJJkKU2aiusSHdym4c3L0beVjD0/cb8G2MGeocgXjx
 K1HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT5G49WLv3MXbpBfcz37meDLpz0KJGRxo3FLv2g6m6DFyzioSHULaiG7KwlAYs5o/8H34s7NdmmtxN@nongnu.org
X-Gm-Message-State: AOJu0YxfY1E2MwQYvpE6Pa8aSUbMO0gnS78EM3vw52Ij8dHHlErN6sl4
 O1vONork9KnBk6IR6SrQR+7T5yXTNJjrLJgvEdDmHntML/GHE00m+9B1bYlxZ12FlCNUJXnymV3
 VEaZGRUN3dzNDqq084P8MVlv6G9N6GfMXgGrZs1wE4E9Vo9TuFpGX1aXv
X-Gm-Gg: ASbGnctrUkZBqiWYNHSw2tol0XI2/Z70HS1iMbh5G4/CKl/owNc8lmBkQKgistLuJE0
 6VZlHxpfrn7sjEOor9XOGoHqHn+mbk4tanjw/t2fQZaf0GzKxUFJ0mN9pJf+Bj5oQfbm+uL+Om8
 /rAQmo3xJ0/u9mwdAs6idy8vTum3OO/S6B/x1QKWEWPo6iYy7+kOFUMUYd/Yo8HXLMtZte+Nac8
 0qY+AB0YMnHZPmg+RaCHd3vdOi9wYZ5Yxp9sTLAYYECWhJmBRu7pbXbyaLz7XFnqtJ+c+YIeXuB
 L1ruzHs1yeee/mTRxbHEGKuanKtyf/aGKvfYZj552wnfXXlrXojgYV1t9AjSaJGztoN+Uk/hed+
 B9khq2o7Jta9LBHIPVzyGzQZRwSgtLz+nQ2K6U3dH2U1wtw==
X-Received: by 2002:a17:907:9803:b0:b70:b3e8:a363 with SMTP id
 a640c23a62f3a-b70b3e8a77dmr620035266b.48.1762181951621; 
 Mon, 03 Nov 2025 06:59:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwFfTJUrJCYQIjTbtGM01p4oXfFcMhzd+xiooBthSfCpLtbyXqo5hOPPpRTGrTznxF7WXWDg==
X-Received: by 2002:a17:907:9803:b0:b70:b3e8:a363 with SMTP id
 a640c23a62f3a-b70b3e8a77dmr620032466b.48.1762181951151; 
 Mon, 03 Nov 2025 06:59:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077cc4918sm1043588266b.57.2025.11.03.06.59.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 06:59:10 -0800 (PST)
Message-ID: <1a4e33af-ff47-4a6d-aec8-54eeec4ea2ab@redhat.com>
Date: Mon, 3 Nov 2025 15:59:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/32] tests/qtest/bios-tables-test: Prepare for IORT
 revison upgrade
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-23-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251031105005.24618-23-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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



On 10/31/25 11:49 AM, Shameer Kolothum wrote:
> Subsequent patch will upgrade IORT revision to 5 to add support
> for IORT RMR nodes.
>
> Add the affected IORT blobs to allowed-diff list for bios-table
> tests.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..3279638ad0 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,5 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/IORT",
> +"tests/data/acpi/aarch64/virt/IORT.its_off",
> +"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
> +"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


