Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F3BD2D0E9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 12:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfdoy-0005Sm-Pb; Tue, 13 Jan 2026 07:48:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfdos-0005OP-Ou
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:48:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfdoq-0007VT-DA
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768308497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ORZBJY+zsWCXimL2uSlbrGm8F2Mu1FFxUSoT9/fHn4k=;
 b=YYwR0Qe07c5XJG8h1PALAcU//BPnNEW+s7Y1OBCVGLIOLChS7CtepmfLhbJTd8I5SgwbW9
 ri5UIr4+K+log8R/aMYmfylIjHYct2wMpp59aB5plV+h/V7pR9pEOxuV2Oz9zF9ELUwebI
 Vy9J8RuwbQM1PMNb9UYuNayyJ9jJ3O0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-LNob5pdMNSq0cwoqfDl6dw-1; Tue, 13 Jan 2026 07:48:16 -0500
X-MC-Unique: LNob5pdMNSq0cwoqfDl6dw-1
X-Mimecast-MFC-AGG-ID: LNob5pdMNSq0cwoqfDl6dw_1768308495
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477563a0c75so46229155e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 04:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768308495; x=1768913295; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ORZBJY+zsWCXimL2uSlbrGm8F2Mu1FFxUSoT9/fHn4k=;
 b=opCtocUhifgzJTjqJrr/uS7kAVDkKgqlnFqAlvG2mNKswEy1LCUj4YVMgUyzUcwmFD
 WwXCDUDiONNr9wqJqt/XRdTzCPUi2jZhsbFP/qhSK/xPNlfQhYBXt/MPigJmhxlLmOIA
 9AGCxLHoQiX0KaInWrX4Q1XZ6hZzQjEfxExNxYUpn0ppMQrhdOIHvOf8+1QGV4Hzs1Dc
 dTA2D9vvlbx1c9Q+4AKb2d5ijNW6QjRSh5aSYQE35ioZp65mm0OEgmLcbquYnCTDGpRX
 eeFEilZWwFmeUvbzO20P0YPCJ0hxYp2M8y/kz2PFO3MXhxbm1KK7RzA2tyElv4qdWZvV
 TduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768308495; x=1768913295;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ORZBJY+zsWCXimL2uSlbrGm8F2Mu1FFxUSoT9/fHn4k=;
 b=N1ODNN7rHUfqnWLDQgz1WX4YKxQaiSo0Kf84818ivCuWYMP+Or2dbn4AOIcSP4Fejo
 aKzylViiDSehVrUaId8253UzmCqiPdIpzXWDv/rwUvEuVj6g5o9E6uVlOc6sXwV0dd8m
 gobb8FvAT7QRqo+WrW7a7o/+DDElVkC8eEfKDFAbNrSWpeO5PeKjqyTfAGDMEeZHe4mV
 +YGnxqU72oOWLgZcK3VLwWr9qe9AXB61OH58/TvjkmrMNMwZFBUY9jusz2yLhuVZTfYL
 Nw0XxqlSlJ/5DdN3wVpmTun1EqdJNxU6ismf4styQotFzqoPjytqE4Ztz6jthemYoBzp
 yRlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvXke88v6VxGXKK/8koWzLEGQUiyE3h9yDGNARiwLcQ8DfMZvifdb3seDHbS9TOSAp78ainhkHzHQs@nongnu.org
X-Gm-Message-State: AOJu0YwJQd3CX+p0crTPvX2pfTnXfQcmGRK3n21dufx8FKHuupmnWboD
 /LGsrOHbBIBSy+eTni4j4eEYFaeJWRMQiPBQpUrYB198zGB9yTgtKFvRtvA7kJp+OifU8SaDC0C
 ZDv7qG4Dl6l0jRF6beHxPkCi93tZyoNh+gG0VkG26VuTUpoF3movVn1/U
X-Gm-Gg: AY/fxX4LmZwSAI8Tddl3s6TiNVES/oijYfApc5QtavWI/Yz6nZTWgJ56xGZbZtK3Wcu
 WuSLj51iiJqUeNvtFGi6r9Kj2/0I4VnyYoAWKYgc1c6xMnjJ7kkV7aorldrtTKB9LwWtFX5oyHd
 ZMEuSAvTwc7HKSJMFIHMUR+W3cQOILwtGSkdqW7z+hpIx3slE9ivBpFXekNVC8Gw8yrwgobvP0F
 RPo8tIDqQU7/Z3s1Qvtc5PLBT9ga/BvHNUPnW2uUzJnClGLDEZB/Nz9M5JdWt6eTGOlrqM4EHeW
 aIGdaoIoSqxJTKAGrlud1vqJlmBSOHHJeLml5WCBcrt0ndnklPL/o2tZtTmi6dGLlD0iSrfhYG8
 s8I+AsDY=
X-Received: by 2002:a05:600c:c054:b0:47e:df86:e83d with SMTP id
 5b1f17b1804b1-47edf86e90amr8430375e9.31.1768308494921; 
 Tue, 13 Jan 2026 04:48:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8bJ8mgoiblnl/rrb5CJOaC4/reO0JbT+2hUfm73gEC1xnlBWenJvPtw3dj+/iAENWC8f/Cw==
X-Received: by 2002:a05:600c:c054:b0:47e:df86:e83d with SMTP id
 5b1f17b1804b1-47edf86e90amr8430115e9.31.1768308494445; 
 Tue, 13 Jan 2026 04:48:14 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6953fasm394327285e9.5.2026.01.13.04.48.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 04:48:14 -0800 (PST)
Message-ID: <3dc0b082-a13b-4221-910a-09bddac57f34@redhat.com>
Date: Tue, 13 Jan 2026 13:48:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] docs/devel/testing: expand documentation for
 'make check-block'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260112204026.710659-1-berrange@redhat.com>
 <20260112204026.710659-9-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260112204026.710659-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/01/2026 21.40, Daniel P. Berrangé wrote:
> Explain in greater detail what 'check-block' will run for each format,
> and also document the new format specific targets.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   docs/devel/testing/main.rst    | 27 ++++++++++++++++++++++++---
>   tests/qemu-iotests/meson.build |  2 ++
>   2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> index 0662766b5c..ec29cf7708 100644
> --- a/docs/devel/testing/main.rst
> +++ b/docs/devel/testing/main.rst
> @@ -221,9 +221,30 @@ same commit that alters the generator code.
>   check-block
>   ~~~~~~~~~~~
>   
> -``make check-block`` runs a subset of the block layer iotests (the tests that
> -are in the "auto" group).
> -See the "QEMU iotests" section below for more information.
> +There are a variety of ways to exercise the block layer I/O tests
> +via make targets.
> +
> +A default ``make check`` or ``make check-block`` command will exercise
> +the ``qcow2`` format, using the tests tagged into the ``auto`` group
> +only.
> +
> +These targets accept the ``SPEED`` variable to augment the set of tests
> +to run. A slightly more comprehensive test plan can be run by defining
> +``SPEED=slow``, which enables all tests for the ``qcow2`` and ``raw``
> +formats. The most comprehensive test plan can be run by defining
> +``SPEED=thorough``, which enables all available tests for every format.

I'd maybe rather say "for most formats" instead of "for every format" since 
we still don't check stuff like "qcow1" etc.

Apart from that, patch looks fine to me, so with that change:
Reviewed-by: Thomas Huth <thuth@redhat.com>


> +This set of formats currently enabled for make integration are
> +``parallels``, ``qcow2``, ``qed``, ``raw``, ``vdi``, ``vhdx``,
> +``vmdk``, and ``vpc``.
> +
> +Each of formats also has its own dedicated make target, named
> +``make check-block-$FORMAT`` which will run all available tests for
> +the designated format and does not require the ``SPEED`` variable
> +to be set.
> +
> +See the "QEMU iotests" section below for more information on the
> +block I/O test framework that is leveraged by these ``make`` targets.
>   
>   .. _qemu-iotests:
>   
> diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
> index 16a5e39476..66b09d6b97 100644
> --- a/tests/qemu-iotests/meson.build
> +++ b/tests/qemu-iotests/meson.build
> @@ -10,6 +10,8 @@ endif
>   
>   qemu_iotests_binaries = [qemu_img, qemu_io, qemu_nbd, qsd]
>   qemu_iotests_env = {'PYTHON': python.full_path()}
> +# If altering this definition, also update docs/devel/testing/main.rst
> +# section on 'check-block' targets to reflect the changes
>   qemu_iotests_formats = {
>     'qcow2': 'quick',
>     'raw': 'slow',


