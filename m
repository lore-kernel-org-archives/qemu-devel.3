Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E848C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 16:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnJtK-0000MG-Ct; Wed, 26 Feb 2025 11:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnJt8-0000KD-U1
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 11:03:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnJsy-00067Q-7U
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 11:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740585826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Vys1crufxgV8URf90WVmjfVw0TwUnvqSFz1bm5BPLPw=;
 b=eeo9v61wGiqyns8SSRCGCCLSyuCZXoH0bHGbLzxI56/ZUL8BDrSI5GXv18yu9KusJXsoy+
 evqW4l2c0IPAHnpH6hHzMgz9BSSfmg1xjH/+1RgvXXcf7zIodHdDFUKmw4hjuQDhXzgFr+
 HxWnTxmJWVLgoKEgB8hn/iOXgpJ1l+0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-L8a5OG4TP4S5W1iK32Nnrg-1; Wed, 26 Feb 2025 11:03:43 -0500
X-MC-Unique: L8a5OG4TP4S5W1iK32Nnrg-1
X-Mimecast-MFC-AGG-ID: L8a5OG4TP4S5W1iK32Nnrg_1740585822
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-439858c5911so33256825e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 08:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740585822; x=1741190622;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vys1crufxgV8URf90WVmjfVw0TwUnvqSFz1bm5BPLPw=;
 b=cOImYCjdbasi030XaiJWWNwcMkfPAua2fMyy3vKS+Tv75IQbRPDs37sOotg7M+TwKA
 BjViUgRhgIumFuujmZw2J4IKDmzcvZu8FVLFlctVHuZ2BXLaUZyNhWc57t1D1NgmIpgy
 mpnPDP8yBYAe7BJXV9xq4GQRpqTTXQd0I8iwYvsjivyOVxrjEBqAbEXR5bH4upjRldMB
 cUkFKxUqOUTbo0U0XBdS/U282vvC2Cx2sqpyosmsMaIjHnYtOZUBn3fEEpQ0RYp9SVo8
 7xwth1seSXAplM+W8Ra98jXlF4iqxXufDc37ZQBL/cLp9DvP5fL7SWd1gZAH3lUoRzEV
 AjLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWupJ8QNiHXo5XyYRJAvx9QJiS+be0rXWzVuoQ3rFYeHuKEDSIqlfe1C4RAbnJq+pRUOXxbEZtDm7j@nongnu.org
X-Gm-Message-State: AOJu0Ywd30eBKF81pxltrFkEZoqNebo+vpToygz238n9vlmyYSTIIRPK
 8Bm6AJ29e/84ya9R7xg1jIEXxlyJBpX4Hi2gcD0mehe59zu3gZU9M6/cZQDses9iJ96Vm7qzBKV
 iybAustMkJSxqysjQLJ/Gs7D3Q0w8NKYrJc1swGwuZNflGeYqIG2h
X-Gm-Gg: ASbGnctHWpmLDnd/vizTy0lRJ5pB7T4Ia4x0pn+S+QELYvsKM/xjbv55P9MuOWnr+iw
 J1mq+93ybDOwIazzhrW9fpoR/9CHOPbE7Gw2GIs9tXtTMO1oaGvJK+n74I8Q6/PHe3LfmhF4PQm
 FNwWkraseJ6wbDpYP6m2h1HFFojC9TFBpvpTLurr2IvaCzllljsyoXjeQ2JvR6c4CVtRwdFodQ1
 XRy+cKMZbAChBbcJwiG/cfxz5zZ5P3eTzpYkdbZ9bu6iPoTuG7ZgpztXANsCvisWGf3Cref7Yuk
 olGPCxyWxReZJgGqivfcb5cODqwHTX9HPO0KOlCirMo8W0A=
X-Received: by 2002:a05:600c:35c3:b0:439:8a8c:d3ca with SMTP id
 5b1f17b1804b1-43ab903c452mr38623965e9.29.1740585822399; 
 Wed, 26 Feb 2025 08:03:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENnTBYtOc9iEkE1XT4saZrvV1CB4YsE3Qeee8jbgrx55GdQLj8nabr+eA09LJmMIaLDdnlwg==
X-Received: by 2002:a05:600c:35c3:b0:439:8a8c:d3ca with SMTP id
 5b1f17b1804b1-43ab903c452mr38623105e9.29.1740585821875; 
 Wed, 26 Feb 2025 08:03:41 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-245.web.vodafone.de.
 [109.42.49.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba52b97bsm26608115e9.8.2025.02.26.08.03.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 08:03:41 -0800 (PST)
Message-ID: <e5339f5d-aaf5-4b90-a14f-b73e9af294bc@redhat.com>
Date: Wed, 26 Feb 2025 17:03:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/25] tests/functional: expand tests to cover virgl
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
 <20250226140343.3907080-5-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250226140343.3907080-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/02/2025 15.03, Alex Bennée wrote:
> Add two more test modes using glmark2-wayland to exercise the OpenGL
> pass-through modes with virgl. Virgl can run with or without the
> hostmem blob support.
> 
> We might want to eventually add more directed tests and individual
> features later on but the glmark/vkmark tests are a good general
> smoke test for accelerated 3D.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20250219150009.1662688-5-alex.bennee@linaro.org>
> ---
>   tests/functional/test_aarch64_virt_gpu.py | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
> index c9463d7285..7a8471d1ca 100755
> --- a/tests/functional/test_aarch64_virt_gpu.py
> +++ b/tests/functional/test_aarch64_virt_gpu.py
> @@ -89,6 +89,26 @@ def _run_virt_gpu_test(self, gpu_device,  weston_cmd, weston_pattern):
>           full_cmd = f"weston -B headless --renderer gl --shell kiosk -- {weston_cmd}"
>           exec_command_and_wait_for_pattern(self, full_cmd, weston_pattern)
>   
> +    @skipIfMissingCommands('zstd')
> +    def test_aarch64_virt_with_virgl_gpu(self):
> +
> +        self.require_device('virtio-gpu-gl-pci')
> +
> +        gpu_device = "virtio-gpu-gl-pci"
> +        weston_cmd = "glmark2-wayland -b:duration=1.0"
> +        weston_pattern = "glmark2 Score"
> +        self._run_virt_gpu_test(gpu_device, weston_cmd, weston_pattern)
> +
> +    @skipIfMissingCommands('zstd')
> +    def test_aarch64_virt_with_virgl_blobs_gpu(self):
> +
> +        self.require_device('virtio-gpu-gl-pci')
> +
> +        gpu_device = "virtio-gpu-gl-pci,hostmem=4G,blob=on"
> +        weston_cmd = "glmark2-wayland -b:duration=1.0"
> +        weston_pattern = "glmark2 Score"
> +        self._run_virt_gpu_test(gpu_device, weston_cmd, weston_pattern)
> +
>       @skipIfMissingCommands('zstd')
>       def test_aarch64_virt_with_vulkan_gpu(self):
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>


