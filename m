Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1BBC19F2E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 15:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnJok-0005ok-Ru; Wed, 26 Feb 2025 10:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnJoa-0005kb-3Q
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:59:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnJoY-00053d-Lm
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740585554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EvpMW5Us6iFxENm8iddIRKVCa+k3xzr2ebPkQ9K6Lhk=;
 b=S9Q9F22PxfEXmWK4e9a0Rz2tlImh2Gf4vYbrJTZO+d4x1lbKLvd+ZB7pDzaZWEKAZe8fvv
 zCusEhMYEZjFjNaODK1jXDJv6ckoboFBuxYeFOKe1v6DLFA/sllZardNI7AbiCYB7DikWm
 w26aznaV9hr1XtrZfXf5ccv7DMA9mvs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-uBrmt28ZP4a-ekPZEryaDQ-1; Wed, 26 Feb 2025 10:59:12 -0500
X-MC-Unique: uBrmt28ZP4a-ekPZEryaDQ-1
X-Mimecast-MFC-AGG-ID: uBrmt28ZP4a-ekPZEryaDQ_1740585551
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4394c747c72so29902195e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 07:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740585551; x=1741190351;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EvpMW5Us6iFxENm8iddIRKVCa+k3xzr2ebPkQ9K6Lhk=;
 b=tjlHYqph7pT9Eo8a0vwFw8UroTqe3BDUe1L8XBl4nFmYKyVhz2RwyhUcb1URyfQ+xi
 SIQ6SwACPjHW7eFOezTLpTPfVuwKkcXLim1aHBsWjIXzoQPTGMlMfdt7mjbtkwllefFD
 iq7iWLRAldzLtIzvC3rh1Rbe4JJo/tDV4wwxXiMTtuj2ZK2LdL5aerUaMSMXQugC4ssU
 onVrTZjqDgEtMtaRqu90/X7C5ikaSrNp0REVr0nRdUDoFsvTY7aJO+59yNUhe9eRL7W4
 odwOQsQTposVbqRDRp1kl9m7XKbSXlTF0yqbgAvcO2bhzBiKM+ByF2sN5cK1yCYFUcy/
 3R7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiQfYK7vUP3ngUKPnJxgmfJ4jxF0CN1COYvG26iEmMkXnAr46GaeYXYhNYP63V44RYWXL/dwLhboGX@nongnu.org
X-Gm-Message-State: AOJu0YyhFvd3YIcN4hGgvvSEsmStSdlE/iFV+FMb/5YzqDmJqsJLnIYr
 5uINKWeDkCUpOEkymx7mA3DPWNjMhBNnqUUzjAZ6uLyiABQnRbSG5xdKasLr6Rp//+ynZ2GuvP4
 u/6j3uotJKmfBOX4/moH2eyqPqkEshRleWudLVW34K1X6BXIBptAs
X-Gm-Gg: ASbGncvxpKX0o00+oxFo/yBkHJjhC2PKDura9IoNOJPMquzMxovm0V9MLxov5J/dL69
 e3CHAoi6D2CRHoDEd3RLaWvXK/o4z+bt9Tafn6luGsmcZnFk8r8TPdWHZiJ17pjLs5mFnZMuIqD
 rg6pnBqJiW7nP1DznJi6Bk5J10PqQgXJenvnIJ4/hyGIk695DiaJ5FrxEafManv32Chmgwzbjus
 IXkHPDDN+Ffh/n8YKh0KJAxQwzONq1iFRUaIJUtxa+geQyFqXPGkXR9nHsmNSopyHbxeKfuAeRn
 QklFieaoWyt0eJrRbDGGNj7ubSCm5Ux/pud3xAdE/KfheVI=
X-Received: by 2002:a05:600c:3c86:b0:439:9d75:9e7d with SMTP id
 5b1f17b1804b1-439ae21d1d0mr164544335e9.22.1740585551404; 
 Wed, 26 Feb 2025 07:59:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZdsSbu3dmRhbAcL3WRLI7VgIcCE7c+7sCvEVYkP2M9tHTsVzFhS4bxKI0O6Q9G0eh21PnZg==
X-Received: by 2002:a05:600c:3c86:b0:439:9d75:9e7d with SMTP id
 5b1f17b1804b1-439ae21d1d0mr164544095e9.22.1740585550989; 
 Wed, 26 Feb 2025 07:59:10 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-245.web.vodafone.de.
 [109.42.49.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba549db4sm25816175e9.35.2025.02.26.07.59.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 07:59:10 -0800 (PST)
Message-ID: <7a7c5550-898b-4ed1-a74b-c2bb9c9d8272@redhat.com>
Date: Wed, 26 Feb 2025 16:59:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/25] tests/functional: ensure we have a GPU device for
 tests
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
 <20250226140343.3907080-4-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250226140343.3907080-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/02/2025 15.03, Alex Bennée wrote:
> It's possible to build QEMU without support for the GL enabled GPU
> devices and we can catch that earlier with an explicit check.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20250219150009.1662688-4-alex.bennee@linaro.org>
> ---
>   tests/functional/test_aarch64_virt_gpu.py | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
> index 06093c6b60..c9463d7285 100755
> --- a/tests/functional/test_aarch64_virt_gpu.py
> +++ b/tests/functional/test_aarch64_virt_gpu.py
> @@ -91,6 +91,9 @@ def _run_virt_gpu_test(self, gpu_device,  weston_cmd, weston_pattern):
>   
>       @skipIfMissingCommands('zstd')
>       def test_aarch64_virt_with_vulkan_gpu(self):
> +
> +        self.require_device('virtio-gpu-gl-pci')
> +
>           gpu_device = "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on"
>           weston_cmd = "vkmark -b:duration=1.0"
>           weston_pattern = "vkmark Score"

Reviewed-by: Thomas Huth <thuth@redhat.com>


