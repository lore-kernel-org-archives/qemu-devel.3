Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B41D2D0EA
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 12:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfdtG-0002Ab-KS; Tue, 13 Jan 2026 07:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfdtF-0002AG-2e
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:52:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfdtD-00080C-Gs
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768308770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pYl56Zuka5bgsR8HEX5UGVasP1wHkolHhPXgrIwBX2U=;
 b=fvslVCSqAlshAD/vMwdbnnSuvqylpPTHkt0Y4ln7eto0ctjynjzm7p1osmO7drclawwir0
 xrAKstQ4q6S9B+grWsmH3MrsVKoiYjdztD5hTDndtJJd341KDaBcpTEaZwSI8IegKCxqqq
 09BSyCTfOaHp+jwqRPx77U47gNJO0zc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-NqWiZ-GZM8mhftcnlXN1uQ-1; Tue, 13 Jan 2026 07:52:48 -0500
X-MC-Unique: NqWiZ-GZM8mhftcnlXN1uQ-1
X-Mimecast-MFC-AGG-ID: NqWiZ-GZM8mhftcnlXN1uQ_1768308768
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d1622509eso48752715e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 04:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768308767; x=1768913567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pYl56Zuka5bgsR8HEX5UGVasP1wHkolHhPXgrIwBX2U=;
 b=GoTyfixKhp+DF9Ytja17JMCeEt6x+ivSgvQVK/EDVYQuZ2/lUdyRzX+yqJTYnRDKf6
 hFE+Mo3ep/c6Em7IHLdqvB45mX9PZtPyGn4S6cOHh4K6Zwyhyjc4h8+fujpRoFHRyYIE
 ymJzn+25xqDxYwFfK3lEXA8Qqs3A/BslU4L2kIZAT7UPepQyYOPlNapOFv4ZoDpHlETY
 9oYxaU5da5L+EgHAxvUDaOSoYi/+KPOPu1tspkSSIQa3mytEfTmSFQJhX8mpuELBPtyM
 RlUyBozRh/iwG557lRxWA5IwY7qJiU4wtnxmnH2l+tSq6LaBRtdlrVERadu60Ou+Iu37
 W3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768308767; x=1768913567;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYl56Zuka5bgsR8HEX5UGVasP1wHkolHhPXgrIwBX2U=;
 b=ReD+Oq519rFtrp9wX79K2VKA90x6qX4xnBlYjk2JNXaeXdmjx2oq/bc2oS2t38jsYC
 5OKaIKjump4qP5X90DoFlixZ58YGkStZSUgLnSR6KmrStJ17t8IyasNRYLVi8T3+moAQ
 92lu5AlYn06mRpoQU4JoAIMyzyNrNpRqdBMfEJZ3Tl4ropZgWDyRFXqhbgtdvX+8ytan
 jKsAf7eNLjqXjiYXThfUscTA3+GVEP6YT4L2fqhYFlXhTEkJxY56sLPun56B3VvsmYqa
 9NKUYH4bYMMnfEeqb6MeKxa7sdvSb63soRpwx6jSiAcejpOymH00H/XwVua6ybBlLhEP
 rXnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV232Mj6cI3JAreGSTwp6RlJUBxgduObZiq5mcn5wfQgk9Cq9wezfdv+0pnKPw7AA+hECZCJfiCkw75@nongnu.org
X-Gm-Message-State: AOJu0YwmY6G5k0/mBbJpt9U1SvkNL3WtPYKDtDq1PyKEKftdm6xtQKQG
 d5t4pewO9LhT/VrBLgIutzFNVvY7T1xRprGewE7IrZY0/eYDKAKeF8y7pSzhhXqKWMeQ73dVl0u
 lfn4OP03DAgaDg62u6JaP+ajpTFm/WCWZFfkos2kpIMuft7BdfHf09qV/
X-Gm-Gg: AY/fxX6W5d1Vu3ksE6+lLRvXabsLXffmI1t5Oj9mYHMvmW5Ot4Iy0tFY/7ESmuwAfq7
 PJ6afu0vccV4BHfMihPoHmjuo/W0Sx/iK+XcP2CybwXVfJJnI6Fw7aNoQe95Bp9BpJOmUUt/SMt
 +R3EBzK/M/HDsWhgnqtR/AsOWzxh93L/cCul6G7UUO12whhEUK7UfMwRBoMuxChgkD5fxEdokgy
 40VWxmM7gdNqy5h6jB+5zzPk5B3wtjDKI6v6ECMV60M2syJ2x8kyAIiqMBJqPZNhJjIBIBIbhxU
 tAHDXN6pyTEe3R8nTYRgavw619qs/FZVI8oOROYJEwjsDA8N0r9wqzE2c6Yu1Z+6oZsSBrek9QG
 xt8b02YU=
X-Received: by 2002:a05:600c:4e86:b0:46f:b32e:5094 with SMTP id
 5b1f17b1804b1-47d84b5b4fcmr236546035e9.32.1768308767630; 
 Tue, 13 Jan 2026 04:52:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEldY9NhMfRYIXXAz5McGYlUS9v7i8V4Uzg4EOCfCcfDC/CQoMVlSC8GQaY73f1YwncXO/mjA==
X-Received: by 2002:a05:600c:4e86:b0:46f:b32e:5094 with SMTP id
 5b1f17b1804b1-47d84b5b4fcmr236545645e9.32.1768308767158; 
 Tue, 13 Jan 2026 04:52:47 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f4184e1sm395725935e9.4.2026.01.13.04.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 04:52:46 -0800 (PST)
Message-ID: <7840ab4d-9991-4018-9546-6a221ab70307@redhat.com>
Date: Tue, 13 Jan 2026 13:52:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] tests: add nbd and luks to the I/O test suites
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260112204026.710659-1-berrange@redhat.com>
 <20260112204026.710659-10-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260112204026.710659-10-berrange@redhat.com>
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
> This introduces new suites for running I/O tests on NBD and LUKS
> drivers, giving new make targets
> 
>   * make check-block-luks
>   * make check-block-nbd
> 
> as well as adding their tests to 'make check-block SPEED=thorough'
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   docs/devel/testing/main.rst    | 4 ++--
>   tests/qemu-iotests/meson.build | 4 +++-
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> index ec29cf7708..910ec11ab4 100644
> --- a/docs/devel/testing/main.rst
> +++ b/docs/devel/testing/main.rst
> @@ -235,8 +235,8 @@ formats. The most comprehensive test plan can be run by defining
>   ``SPEED=thorough``, which enables all available tests for every format.
>   
>   This set of formats currently enabled for make integration are

Should we change the wording now to "formats/protocols" since "luks" is 
rather a protocol than a format?

> -``parallels``, ``qcow2``, ``qed``, ``raw``, ``vdi``, ``vhdx``,
> -``vmdk``, and ``vpc``.
> +``luks``, ``nbd``, ``parallels``, ``qcow2``, ``qed``, ``raw``, ``vdi``,
> +``vhdx``, ``vmdk``, and ``vpc``.
>   
>   Each of formats also has its own dedicated make target, named
>   ``make check-block-$FORMAT`` which will run all available tests for
> diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
> index 66b09d6b97..744d0b6e88 100644
> --- a/tests/qemu-iotests/meson.build
> +++ b/tests/qemu-iotests/meson.build
> @@ -15,12 +15,14 @@ qemu_iotests_env = {'PYTHON': python.full_path()}
>   qemu_iotests_formats = {

And change it to "qemu_iotests_blockdrivers" (or just "blockdrivers") now?

>     'qcow2': 'quick',
>     'raw': 'slow',
> +  'luks': 'thorough',
> +  'nbd': 'thorough',
>     'parallels': 'thorough',
>     'qed': 'thorough',
>     'vdi': 'thorough',
>     'vhdx': 'thorough',
>     'vmdk': 'thorough',
> -  'vpc': 'thorough'
> +  'vpc': 'thorough',
>   }
>   
>   foreach k, v : emulators

  Thomas


