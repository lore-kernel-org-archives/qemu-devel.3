Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C04C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 11:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpmzT-0002m4-Q7; Wed, 05 Mar 2025 06:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpmzS-0002lb-2p
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:32:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpmzQ-0007uA-8N
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741174359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IjHu/3Bgz3X/E62CO/QRYBgCMS61qawGSVrPFOn9KX4=;
 b=D+U3ffUOGmfTvFJywRraJbLfNaixYwyZL93ubmk4Vm0VVjijtZaa32gAJeQVa1AzfzAIfd
 I8oBpfRQD7TNjLBdrSAeJeqToS0C/e62VoIr1YMitp5tbBSpsxuJccWmDAbDDz/Zg6+HwN
 f6Ty9zBCJCT0afomj10b40nATObY2pU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-u7unNc9vOV-YoDAlvUEqmw-1; Wed, 05 Mar 2025 06:32:34 -0500
X-MC-Unique: u7unNc9vOV-YoDAlvUEqmw-1
X-Mimecast-MFC-AGG-ID: u7unNc9vOV-YoDAlvUEqmw_1741174353
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390df5962e1so355414f8f.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 03:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741174353; x=1741779153;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IjHu/3Bgz3X/E62CO/QRYBgCMS61qawGSVrPFOn9KX4=;
 b=cNH+6pz9R+unUAf/avEvr7XFuFVY5OcU1R4bPLj6et9e7JsLuuyuWDhuLY5q35cvcC
 5iqhU4KvosXTCUhqr7LFsyeylJX0OHa6+1LmBOSUqRXpRZeZVevQrKhhhd+tI+DscJjO
 VnDBxzEhu4DpH/SjzMkFEmKxm3btKhK9D7xc6dPqZ8QnD/PiGtIHxgwxx9dhBNpBCEb/
 tQ6rKqnuxLHGRwn9eW9dOk1lKBW4qj+RssEo4RQqOVqWT5kwEEDjZ/hwMD5i+af5Jb/b
 T/E1hpaJLKulEAkCPjTm4Ep6yM/3Ia9wVvEs7Iid8buX/gJjGW9lRKG932K7UlLMF1Dt
 l+yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvVizOvvdl/kumJbxs3fxdw2JZHYnjq1xy6oh8ptzKri5incawaYJtZ4OdA+KqaCOWn46JiUJX9Ysr@nongnu.org
X-Gm-Message-State: AOJu0Yy/9owW08XSk5hMtWMWZ8aS3NPGmmMpCLsv5AR2eO9j98fP72Ih
 e9OTgVnqPFvHulgnTo5coDsS0HVpE/lZ3b+NtuHpvu6B8m/obm2V9tos8DP+tluZvMVG0OJUWHD
 1dFYmOb0voinJuQsyIshxCMOwgRh0ZPC0B1F/sETMZJCvxSGb45y9
X-Gm-Gg: ASbGnctUb7Eu10eApjYfLulTmj/nWSunP85XfuWpWZMJsmI8tb+5TNt/uf0VgY/wh6S
 g0LLorjLGLHzTxrYaykaq8EVo9j55rEARYPh3ldyOsEMHLt6pCEFDJvGXNdMkyKjm5OM9MUw1GF
 ankj7Rb7YpAGLXJ0mgKRKi/URcm9wJE4ZFw5AzUkSsltGOAgzkg8RlplF7NMI0u8S1vIyg4JQwV
 V2197u5pVjuQnosA4l8BG98WPL4fqlOs2ABm13s8/ZT3k9ARbrO8h8spSaXu0aXdlFytQ/q5vYg
 uTvv7DP/FmeGsjF7RhQhWlXmH/UhShoPFRmCxTkb1ZVg1Gw=
X-Received: by 2002:a5d:6482:0:b0:38f:2c10:da1e with SMTP id
 ffacd0b85a97d-3911ea5482amr2244159f8f.27.1741174353366; 
 Wed, 05 Mar 2025 03:32:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOY8vG/lNX3UdOXv/NFxkidlQsZKJoKa/EHPHuDx4HU28WMwwm6/lPx6LuQ1yRMo9hDaIblg==
X-Received: by 2002:a5d:6482:0:b0:38f:2c10:da1e with SMTP id
 ffacd0b85a97d-3911ea5482amr2244134f8f.27.1741174352971; 
 Wed, 05 Mar 2025 03:32:32 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e479608fsm21047977f8f.14.2025.03.05.03.32.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 03:32:32 -0800 (PST)
Message-ID: <a6f68dd5-379b-4868-959a-5b4b9a7e97ba@redhat.com>
Date: Wed, 5 Mar 2025 12:32:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] tests/functional: skip memaddr tests on 32-bit
 builds
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org
References: <20250228102738.3064045-1-berrange@redhat.com>
 <20250228102738.3064045-6-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250228102738.3064045-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 28/02/2025 11.27, Daniel P. Berrangé wrote:
> If the QEMU binary was built for a 32-bit ELF target we cannot run the
> memory address space tests as they all require ability to address more
> RAM that can be represented on 32-bit.
> 
> We can't use a decorator to skip the tests as we need setUp() to run to
> pick the QEMU binary, thus we must call a method at the start of each
> test to check and skip it. The functional result is effectively the
> same as using a decorator, just less pretty. This code will go away when
> 32-bit hosts are full dropped from QEMU.
> 
> The code allows any non-ELF target since all macOS versions supported
> at 64-bit only and we already dropped support for 32-bit Windows.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/test_mem_addr_space.py | 34 +++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/tests/functional/test_mem_addr_space.py b/tests/functional/test_mem_addr_space.py
> index bb0cf062ca..c8bde77e51 100755
> --- a/tests/functional/test_mem_addr_space.py
> +++ b/tests/functional/test_mem_addr_space.py
> @@ -20,6 +20,25 @@ class MemAddrCheck(QemuSystemTest):
>       # this reason.
>       DELAY_Q35_BOOT_SEQUENCE = 1
>   
> +    # This helper can go away when the 32-bit host deprecation
> +    # turns into full & final removal of support.
> +    def ensure_64bit_binary(self):
> +        with open(self.qemu_bin, "rb") as fh:
> +            ident = fh.read(4)
> +
> +            # "\x7fELF"
> +            if ident != bytes([0x7f, 0x45, 0x4C, 0x46]):
> +                # Non-ELF file implies macOS or Windows which
> +                # we already assume to be 64-bit only
> +                return
> +
> +            # bits == 1 -> 32-bit; bits == 2 -> 64-bit
> +            bits = int.from_bytes(fh.read(1))

This unfortunately fails in the Centos CI job (so I guess there's something 
different with Python 3.8):

  https://gitlab.com/thuth/qemu/-/jobs/9316861212#L131

Looking at the test log:

Traceback (most recent call last):
   File "/builds/thuth/qemu/tests/functional/test_mem_addr_space.py", line 
335, in test_phybits_ok_tcg_q35_intel_cxl
     self.ensure_64bit_binary()
   File "/builds/thuth/qemu/tests/functional/test_mem_addr_space.py", line 
36, in ensure_64bit_binary
     bits = int.from_bytes(fh.read(1))
TypeError: from_bytes() missing required argument 'byteorder' (pos 2)

Could you please have a look?

  Thanks,
   Thomas


