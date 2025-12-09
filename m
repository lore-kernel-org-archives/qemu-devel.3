Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA70D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 07:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSrrk-0005UH-Mx; Tue, 09 Dec 2025 02:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSrri-0005U0-Kq
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 02:10:30 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSrrh-0002Av-3A
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 02:10:30 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42e2d02a3c9so3532747f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 23:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765264227; x=1765869027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qdD0GmzB51L5As2+RAWX9UlylQDRtHU42ql/6lpbA9c=;
 b=PZMunt5e3UDZhNajS2gB0JJcinnGpfLVuAKt8SVPqFk92ySFK7xov2BGExhICMInFy
 MBPaf0TH1M131PZ6IuHomxMK5WRJ6TjMoJsA6km2YXJvyFtkHaedk6tUHILce30j3PZc
 MnZCcSb0rxQPqYrYybPVqDu4kAu7sK01lOdnFmmRqeUjXJsGkBp8ibZ9QZnq7sauyEPb
 8lnv0RRAXsOkym356WdYDIMawN/y9W4Zjm79MVhEbo8qCeu6QfyMYYePK4GNqU8s8+qW
 PCJkVKJyRfakc20WvfmGNfBvVBvxqLXt3+Df612pEh1VO/nAa2Ahp/2vtOG57s+MRKL0
 j5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765264227; x=1765869027;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qdD0GmzB51L5As2+RAWX9UlylQDRtHU42ql/6lpbA9c=;
 b=ok5mDjVzmFyOALRVFcSpjFeKmEAeoBzS0dHRUcNC0Z0Osoyc3FTwRrqxExKVP59yDM
 qTBPehMjNpE7TbqJsRDPQXyLVQI6Ujvf5JM95LezLxMj6jEmW+D9FttFUdE49RUyHLa6
 8K2I52OhKltlGU0A6QU2b+43d9na7OvBA8h1Ss4Ww4i5PHh02eYOn+Nwk++DXgmgGs1a
 rTBVdmYZ4B6hJHf55IoqxmH1tQX+buU7N+6qxP5JioeIVAr7+pckWaECf9wmRuw6pA2t
 2Ia8mj8yezMxSs7GMhe+1Tom6+I+dBD6dEUVVP31bfn/dPCvN2Vn02DNl2VzIuxzGLub
 7aog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOxceBFghP8u7nrOXMJR++AA7lD7/pw0O4Azqw7HDoLM6KgwTWGCEH60x2OL+pIj99lMm9WsnNMH0g@nongnu.org
X-Gm-Message-State: AOJu0YwjD3vbLgPP+86BfweHJEtrSl6yQQPmkYjvPZm3eSl8IaEfpHPr
 MTlNItsCa1Iso3YXRGzBR0Z0TVmFKhmSOhBhllkHHWMGTuamv6SSqwoBhAIyTvGLk44=
X-Gm-Gg: ASbGncvmxfJcKC0ruE3lrixF6k214MyB3LC16KJ499XJKvbuV7HPBNnF8WZ+TGXOo91
 5pKxWQvZJbUWBmyUkLVUstP2gupxVtbY/7Ny8WNKf2k6R18KZxO6UseVISzSgpQTquR6U3nrFde
 701EQXyuVqIh+j/tae+beoui6D+kS2R9oi244wqWlZbeFoKpBTprHVeri/yMzZpXGlzAkk0CdsS
 stdh7Bpa/mVWNGF3d5XAbdtk+++oW18/TpDwmoLEaZRj/GxTc7YC1R+VPDdRkHC9suNxeFdpq0U
 s5xgC1noYxJ+uwzvBstJSHjbQRT9MZmfUcDKNTsi8NzC+ERxWV+LTpH4LciwXZVg3+C+i1ILhsJ
 WXq4Gl42CQpoj9q6uq8pWfeX8Lky3n9yAs2UW+/3cKqvJh72VzAJ0Rc7qSEcgXlvVdictMDld5L
 8Hp1iTL174YVGZtMhvqPy1FVeBJmKmlxf1GTaD8X77pYK0ocKP1LrCXg==
X-Google-Smtp-Source: AGHT+IHTp8oFoHRynAp4fP3dX1k5lgngPnoIhHWMn6H+/M0QgKDL81iLtio40BhLGBpyi53/5i7muw==
X-Received: by 2002:a05:6000:290f:b0:427:914:7468 with SMTP id
 ffacd0b85a97d-42f89f0d854mr10904852f8f.15.1765264227118; 
 Mon, 08 Dec 2025 23:10:27 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbfee50sm29754957f8f.14.2025.12.08.23.10.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 23:10:26 -0800 (PST)
Message-ID: <c644d007-263a-4963-9e52-c532b9c4e902@linaro.org>
Date: Tue, 9 Dec 2025 08:10:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2] vhost: Always initialize cached vring data
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20251208113008.153249-1-hreitz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251208113008.153249-1-hreitz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 8/12/25 12:30, Hanna Czenczek wrote:
> vhost_virtqueue_start() can exit early if the descriptor ring address is
> 0, assuming the virtqueue isn’t ready to start.
> 
> In this case, all cached vring information (size, physical address,
> pointer) is left as-is.  This is OK at first startup, when that info is
> still initialized to 0, but after a reset, it will retain old (outdated)
> information.
> 
> vhost_virtqueue_start() must make sure these values are (re-)set
> properly before exiting.
> 
> (When using an IOMMU, these outdated values can stall the device:
> vhost_dev_start() deliberately produces an IOMMU miss event for each
> used vring.  If used_phys contains an outdated value, the resulting
> lookup may fail, forcing the device to be stopped.)
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>   hw/virtio/vhost.c | 38 +++++++++++++++++++++++---------------
>   1 file changed, 23 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


