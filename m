Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616E4C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 15:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnJPV-0002iC-4u; Wed, 26 Feb 2025 10:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnJP5-0002Xq-9J
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:33:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnJP0-0001oH-87
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740583968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iy51FRMmXdWB9ecHiyxXotEaAghHQLo7dDxjuuWhQgU=;
 b=DlMcRFeHbDHr6K07W+cQT6632xPR8qVRg+t1ja9rmWTApC7wZU8Sw1gl+n2+N7hAuwpEFH
 K2k5NUD3UBTIm0v62oIJuzK1KaJyLKjaKWqlxKcMH9WM9iGZwR7GYCu2mPg51y4YvDXUAy
 dCe4fHMQGns0mr2drVBD5GXe5WSwb+I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-juFppXhoMtKNRDkI0XJYOA-1; Wed, 26 Feb 2025 10:32:46 -0500
X-MC-Unique: juFppXhoMtKNRDkI0XJYOA-1
X-Mimecast-MFC-AGG-ID: juFppXhoMtKNRDkI0XJYOA_1740583966
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43935e09897so47534585e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 07:32:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740583966; x=1741188766;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iy51FRMmXdWB9ecHiyxXotEaAghHQLo7dDxjuuWhQgU=;
 b=XCvJqbJ5KYNLBgKLxz7lSNImP80VEvoAoIGnfs9Ux94bTbQzo8pDOJOn2n3jCvRfis
 rKRofqkPJq89OV8m/ntSsvq1h8BQRstBxB4RvRn1J4TyZBXdodz8D835p7hohSKsQcRS
 V+kVRD/vdFq15oslhjq9wj9hhfuO7tUhTIh79mL4wpIyi9OWvaobt+XlRIrOk/NS58dU
 zVLpy5CrMgEPfgl9ihRaX5yl4TuwnBtsKC6r77RNxG8TPm9qeDc3ivQGmxYFkt7RhmbV
 oDRP+auqVIiE3LpY9arF90H2pFnFR4ya3LBb6oPsxG2A6Qz7/1PWyf3B6q/f5/4bkAJE
 FJ8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQB9iQN40q/NeosBLDIfhEcXbmzVPuHq425L44v6AKdCX6x00yFrANGCDvbC9aB2rUcss3CoLvKFAm@nongnu.org
X-Gm-Message-State: AOJu0YxBKWHKTMjYmWPhvq5Iq+B0CqSPcu9NPGkSFupTut6OP3BjBZ/d
 MCg2wsPnTgF36wO40hn96th1pwDh5VEWhV1g+VEpmnezIY7iSwgm3UQlWkJKBfgcZMKX1ep+baW
 oD3j11CL+oyF8tFRxTWz10G2JeNbaavocetXPTSWGwXhahUgrJF2v
X-Gm-Gg: ASbGncv7l6n/9KFDDtgus2VRw9fyJdDyX7Zq2PXC2q/U2yRVMM67+RdVXwIoLq4gTkw
 o70rXZ5130clDu0QcnND9+D9BPY8K67wGvoPn79MC4+nZ+VolzrAMQ52Tyg/3SvFOWlkKQJCPRu
 cpb6pW3Yn22CF6By7R0WIcF7zR0DEuzDh8UysSlvfFNWbE9uWBLW5E21EWEUWXFaeZ5Pn80AR9Q
 cg1yZIBP3nm8Wln0ua1FBcnUjurBBZkFSVesWw0RHIp82zK//g8csZYZTKaTZw8XvUqj3n2uylE
 RW2fENnmpfa9uBR+uiVXRO/6KUHVYQQFPsTAWEPvNYjzY40=
X-Received: by 2002:a05:6000:144a:b0:38f:4e50:8b1a with SMTP id
 ffacd0b85a97d-390d4f43021mr3847250f8f.25.1740583965676; 
 Wed, 26 Feb 2025 07:32:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrHFX8OTNvTMocyrA9X3UCtt3XKvyQMtUtM3GwNjMmxir+jjQDsGVqw7GYyyr5nQ79AaomUQ==
X-Received: by 2002:a05:6000:144a:b0:38f:4e50:8b1a with SMTP id
 ffacd0b85a97d-390d4f43021mr3847210f8f.25.1740583965289; 
 Wed, 26 Feb 2025 07:32:45 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-245.web.vodafone.de.
 [109.42.49.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd86c9ccsm5960982f8f.21.2025.02.26.07.32.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 07:32:44 -0800 (PST)
Message-ID: <849db12d-868c-48e0-bb0a-5677a612abef@redhat.com>
Date: Wed, 26 Feb 2025 16:32:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/25] tests/functional: factor out common code in gpu test
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
 <20250226140343.3907080-3-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250226140343.3907080-3-alex.bennee@linaro.org>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> In preparation for handling more tests split out the common machine
> setup details from the test specific stuff.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20250219150009.1662688-3-alex.bennee@linaro.org>
> ---
>   tests/functional/test_aarch64_virt_gpu.py | 30 +++++++++++------------
>   1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
> index f21ae18392..06093c6b60 100755
> --- a/tests/functional/test_aarch64_virt_gpu.py
> +++ b/tests/functional/test_aarch64_virt_gpu.py
> @@ -39,12 +39,7 @@ def wait_for_console_pattern(self, success_message, vm=None):
>           'rootfs.ext4.zstd',
>           '792da7573f5dc2913ddb7c638151d4a6b2d028a4cb2afb38add513c1924bdad4')
>   
> -    @skipIfMissingCommands('zstd')
> -    def test_aarch64_virt_with_vulkan_gpu(self):
> -        # This tests boots with a buildroot test image that contains
> -        # vkmark and other GPU exercising tools. We run a headless
> -        # weston that nevertheless still exercises the virtio-gpu
> -        # backend.
> +    def _run_virt_gpu_test(self, gpu_device,  weston_cmd, weston_pattern):
>   
>           self.set_machine('virt')
>           self.require_accelerator("tcg")
> @@ -62,10 +57,10 @@ def test_aarch64_virt_with_vulkan_gpu(self):
>                            '-kernel', kernel_path,
>                            '-append', kernel_command_line)
>           self.vm.add_args("-smp", "2", "-m", "2048")
> -        self.vm.add_args("-device",
> -                         "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
> -        self.vm.add_args("-display", "egl-headless")
> -        self.vm.add_args("-display", "dbus,gl=on")
> +        self.vm.add_args("-device", gpu_device)
> +        for opt in ["egl-headless", "dbus,gl=on"]:
> +            self.vm.add_args("-display", opt)

What's the advantage of changing the two -display lines here? The code is 
hardly shorter and IMHO rather more difficult to read...?

Anyway,
Reviewed-by: Thomas Huth <thuth@redhat.com>


