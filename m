Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E69EC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4FK7-00089E-0i; Tue, 07 May 2024 03:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4FK5-000891-Lg
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:33:13 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4FJz-0003aj-Bm
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:33:08 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41ba0bb5837so19397405e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 00:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715067185; x=1715671985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zzGnp97rSg7gvT8i0eSN9694T1KbqRaIo97BDou6Y0E=;
 b=mvSWCxXq+dHA1S832bHNvSmoQ1j4Ww+qCPdy1SCtTdXKVARlej6+2E0IXHm2zRvkg/
 y1ANwImVmCcts1zoSANXjYV3mwdT9QqlrAjFR2Vb/2mee51hTl4gPj+0kqOx2ow310rE
 xFQmegvbaCD7OXyzF2z8Rvt+D6/Mm3UKsaUFomsi5jLTQqH2phcy94y69VDXWaOOdTPx
 rT+MybxYF/Ju2HB+9IUp57BeSZ5mMWyND7NuJGbpN+PrdtemuOyhjsIMpOb4kOwjsfbP
 PFgWk4YCs7/OZK3ycpLQHPTSed7kd+hQB0YdYXGkaozKSoQRRqYtSra/bMXL7axYVY9f
 5QcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715067185; x=1715671985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zzGnp97rSg7gvT8i0eSN9694T1KbqRaIo97BDou6Y0E=;
 b=sVwU987l55vWNAwjzwSrGvbTXqNPay6ag+ime40hIN5IsYbyr6xDEmQVwIeQUfTDSl
 LARHir3E+tEwsrJNGrsI66nnY3Yx5vTTy+im2sdU6TiBt78hZ0NUH30hl9tlO9oj461j
 /SxQgD0I2aMGnxkuyRo1wlGrIXiBUGny1h6R2njwi35GQco4qz7D1T5WNMLH/a36UUqF
 gLuGZiRmSytgIyQmud++vMQW12ZR7salw34QUuaQEmTEpiYyRUN+2Z5rFZWZnyj2bU+H
 Tyxnrpj3lj4df/Bi2AzL9F3dLuOUV9KCC6IvZE0GCijA1DbSv/51e5hpPKs/5eId7IzQ
 427Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLM8/wFHiHzArD+K31Q0ypAND4q27d4GRvP7WMvvrJFp73M+zryP47OImfVnQWPl9C2ITxdJc2wL3JWsI2h+Q9B0GoT3Y=
X-Gm-Message-State: AOJu0YxwdR2qyMrdCPuO3ld5vnUWJ9ms1Tl3CFRjH0uKwRyTqIka3819
 ncAEJXNwGIWupJUP+yC7XQ8HY2w81N9/swuZGvD9ewFTrARKBft6w7FVvmT1Ygg=
X-Google-Smtp-Source: AGHT+IGn0qF4uRtQiRnhtEPfMf4s6NVaFQdttfYrdycNvc8M66l8tTiN5yfnXzbpSL3Bwnmz4sQOEg==
X-Received: by 2002:a05:600c:45cd:b0:419:d841:d318 with SMTP id
 s13-20020a05600c45cd00b00419d841d318mr9377437wmo.29.1715067185193; 
 Tue, 07 May 2024 00:33:05 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 t12-20020a05600c198c00b0041becb7ff05sm18310233wmq.26.2024.05.07.00.33.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 00:33:04 -0700 (PDT)
Message-ID: <ef6df20a-04c9-46bd-95b4-b5bc553364ab@linaro.org>
Date: Tue, 7 May 2024 09:33:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] accel/kvm: Fix segmentation fault
To: Masato Imai <mii@sfc.wide.ad.jp>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "open list:Overall KVM CPUs" <kvm@vger.kernel.org>
References: <20240507025010.1968881-1-mii@sfc.wide.ad.jp>
 <20240507025010.1968881-2-mii@sfc.wide.ad.jp>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240507025010.1968881-2-mii@sfc.wide.ad.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi Masato,

On 7/5/24 04:50, Masato Imai wrote:
> When the KVM acceleration parameter is not set, executing calc_dirty_rate
> with the -r or -b option results in a segmentation fault due to accessing
> a null kvm_state pointer in the kvm_dirty_ring_enabled function. This
> commit adds a null check for kvm_status to prevent segmentation faults.
> 
> Signed-off-by: Masato Imai <mii@sfc.wide.ad.jp>
> ---
>   accel/kvm/kvm-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index c0be9f5eed..544293be8a 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2329,7 +2329,7 @@ bool kvm_vcpu_id_is_valid(int vcpu_id)
>   
>   bool kvm_dirty_ring_enabled(void)
>   {
> -    return kvm_state->kvm_dirty_ring_size ? true : false;
> +    return kvm_state && kvm_state->kvm_dirty_ring_size;

I missed the previous iterations of this patch. I disagree
with this approach, we shouldn't call kvm_dirty_ring_enabled()
if kvm_state is NULL, this is a bad API usage. So I'd rather
assert(kvm_state) here and force the callers to check for
kvm_enabled() before calling.

>   }
>   
>   static void query_stats_cb(StatsResultList **result, StatsTarget target,


