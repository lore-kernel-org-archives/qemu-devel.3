Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B62FEA83B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 10:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5L6J-0004rT-G2; Wed, 25 Mar 2026 06:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5L63-0004ov-O6
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 06:04:20 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5L62-0000YV-4T
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 06:04:19 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439b2965d4bso3455491f8f.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 03:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774433056; x=1775037856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8+bpziVQ1ICo4d3elngv8IvJXEGcFLvZcPeTa72w8qc=;
 b=C4IACY3YWsS710EBoNKgNYCTwUJg/qpGcJqmdSX3r6D9btno2ZpN9rx3hsS0UBXSRG
 jyWZraqOlhg6x+hdgLfbpW9Yf41m9A7KxnWjSuUhVk5iIhSO1n8mFrpH2VbyBIIgl/4i
 H8ZTYWQ7GSwUQnE1ET1cyA0omUgaf92fqDSL3qREU6+kKHhnZ3y6sr74UX+/vJ4OIkYv
 XkhsiaFW7u/HKnWhekERhXVZNfzc8r8PeDpe6hvsR+8lhU0n7uq02rkZBy2KCFc7GVEq
 2fH/itntaMYPCG+wndjSdOq5VovtovHMkLdebZgQejC637LvgCosEwKoJznivffl0SYm
 wD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774433056; x=1775037856;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8+bpziVQ1ICo4d3elngv8IvJXEGcFLvZcPeTa72w8qc=;
 b=okWY4TfmCYXKI7JUDA1iWtQ+kK0jgVKceWSc7PWebSadqx5i7yqCTOXdatNEnn7xE6
 SOoevVH4U+ez2zlz572R2LkJGmS/GfRFFwDLYt0zvUvPUjtprt6RyDe3UJqjheH7lVsl
 u7xiqT7aTn/2omk14C5wBHEheQTcFq3uhwXCzNtFCQfB3/wcUdu6wHz8+C7Vq/ucrxwt
 tYSrAzki8ha129vFRwKKcDHCmjvpIVXSIa+vO+TfnVoxNMzgPDKkyDI3+KJ/txd8rbEL
 g9Y2QNSbdWcl5ZyKSHEQVln535aWSGdUn9DeW65Nb7IIh2Lm5aHmda6d+g9lrsq9bpzX
 LQig==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3m5IdmgVknuDW9QdEwqB8CxfuYK0DpMIUJFn8V4EbTmVHrSRU+4o2/02LwCFcBs1j+FShDCKMKq8M@nongnu.org
X-Gm-Message-State: AOJu0Ywo8zhQn+b29e3V0FBvJ6gexuKBpuzB+deIIVs8AUZRmcOyLzSp
 MyvpniIgPE4CjytfVaEEd58v6uxjcOKWKXzHRmPjTFmSeIv2tFrieywAFXrtNCtBEPNKNiN9B1a
 yTi5cXt4=
X-Gm-Gg: ATEYQzz8TvxpHu9yw+5yQTmdQGgR2dyafglBsgg144oPfo7Hre3dlyDDpjwbW3g0/DM
 iHcusFpA9R1QQXkx+7EcgcJN5knl1xBtrjIgxInXKDrqkXU3GncVHkJpN5XOLxFyjs29gN1DJ23
 QNezG+JsGb6xpMGzNq5kuf7zMHgwEdTF51X6OdxHQST+eYpqkG2ZCIuf17m/VUYeC/5HKuAzK03
 r3/Yr4lK9LfDdfEQOgBWBCgUS0dJYttGkNaRWggYqzIG7SZ/BIp5z0jj++5hsi8aybQS8vpNM7V
 tGQxaaJbvcRtazJoDl+cxpYDib8Yb1abNPsjTmtBGmKsBGSMiQIHkfdDqNXYSpJQF4Br69CwuNF
 eRNeFbDYxn1v6TNiGFOggnvSHSUU5uR6Vz6ikWpu5UJyhlmikZAYyo1dIK0Qa4CdVZ8Y15Zf/z7
 QeH8ReEPIilM066BaHshOCIHx5OW60uazYnZc1p+GGfElg9VIoK8NtCSeoxrJtAfVTLA==
X-Received: by 2002:a5d:588a:0:b0:43b:86ce:27a6 with SMTP id
 ffacd0b85a97d-43b8898d428mr4213650f8f.9.1774433056152; 
 Wed, 25 Mar 2026 03:04:16 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b646b0b0csm43266521f8f.15.2026.03.25.03.04.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 03:04:15 -0700 (PDT)
Message-ID: <ef81a4fd-91df-4028-b1d0-0f8768d7e642@linaro.org>
Date: Wed, 25 Mar 2026 11:04:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tests/functional/qemu_test: Split huge fetch()
 function in asset.py
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260324163543.55503-1-thuth@redhat.com>
 <20260324163543.55503-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260324163543.55503-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/3/26 17:35, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The fetch() function has become really huge and pylint complains about
> that. Extract the internal retry-three-times-download loop into a
> separate function to make it a little bit more readable and to make
> pylint happy about this file again.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/qemu_test/asset.py | 43 ++++++++++++++++-------------
>   1 file changed, 24 insertions(+), 19 deletions(-)


> +    def _try_to_fetch(self, tmp_cache_file):
>           for _retries in range(3):

While here, pass the number as argument to the new function?

Anyhow,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    def fetch(self):
> +        '''Download the asset from the internet'''
> +        if not self.cache_dir.exists():
> +            self.cache_dir.mkdir(parents=True, exist_ok=True)
> +
> +        if self.valid():
> +            self.log.debug("Using cached asset %s for %s",
> +                           self.cache_file, self.url)
> +            self._save_time_stamp()
> +            return str(self.cache_file)
> +
> +        if not self.fetchable():
> +            raise AssetError(self,
> +                             "Asset cache is invalid and downloads disabled")
> +
> +        self.log.info("Downloading %s to %s...", self.url, self.cache_file)
> +        tmp_cache_file = self.cache_file.with_suffix(".download")
> +
> +        if self._try_to_fetch(tmp_cache_file):
> +            return str(self.cache_file)
>   
>           if not os.path.exists(tmp_cache_file):
>               raise AssetError(self, "Download retries exceeded", transient=True)


