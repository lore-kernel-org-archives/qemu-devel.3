Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE33C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 07:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTz9P-0007xI-9u; Wed, 17 Jul 2024 03:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTz9G-0007tM-M9
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 03:32:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTz9E-0005O3-Bg
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 03:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721201540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2HapaAQSQTyDTjvwhbRfy0uabK+/9TTtih3fbP4Byx8=;
 b=JbJXI88mzQyr+KENyAQSyCbi/nase2aToYyLya2uh8l5TKsio3j76styNIjYXvlJkAx/V3
 4ZqaRmJLw1/ZSnuYl6fz9fslBoVW+RJoYYsln4XVomIyLRwy2yzdijmKKkwEXFpPCWiDB7
 NsMRcn+DJiUdgqhtd4UHLV+0fNc+22Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-X7NX3k-vM_2F6-_iuKSiHw-1; Wed, 17 Jul 2024 03:32:17 -0400
X-MC-Unique: X7NX3k-vM_2F6-_iuKSiHw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57c93227bbeso5759765a12.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 00:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721201536; x=1721806336;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HapaAQSQTyDTjvwhbRfy0uabK+/9TTtih3fbP4Byx8=;
 b=JpVnCvMoLXFlobDTK8fR3ISeoa0iPtIreG92mlTfH0Gp8FF2YX7/265+xz8S+rKNMq
 5pS77bo/85fP9cPAsUzvKfA4xAVtOHq+MgLGDZlTshfDtUrMD22pa821jEYnCZG4xqnN
 hIww8VMCAL0Blb7KlVCEUaDw2B5v+NkYUWJcCbBlRddJRi06N/IuWUl+ZzFNxfXv4jc0
 HFKGxwSu3NailsASHhsg2RM4H0xF55+fak8/G/c8LQRPGpDZZFa+itrMFcDXo0RDq9dY
 WRNT568krKBsuPMSbkMw8gUURiKEFu4PgSyJfqZO2gn2b8/muq2acHD7vYaYA7hee82r
 BGLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCAxsGY+BwLrVGCAP4naaaqG8ZmSG38bupIxyCj7QGLEa1xq9HTnpL+XVklFsHFZG6tFsI6los4pmMdMtp/keQPo8CVOo=
X-Gm-Message-State: AOJu0YzHuavd39nGeEd5vyLEjirQ+Q6O+Zq/TvPmiYdlzH3SQd1HUZCO
 bT2jdXnSGOpzpjJKlPl23rCuA2S/ez7vorpk8gLL1yNX9TRO8RCDNNIh8xOTw/3Cd21VCTVhtCZ
 IY2gUMm5oJWUlvaVOa702AChpUDSX67ktfYH3LeT+K9w7uo3ibjYZ
X-Received: by 2002:a50:d683:0:b0:58e:2f0a:d5c8 with SMTP id
 4fb4d7f45d1cf-5a05d5c74demr603503a12.38.1721201535835; 
 Wed, 17 Jul 2024 00:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsnFGlw4LlwZ8hs7eytHiOSbYGr327KcU6AQ4BIeHQXPa6nOy0TlO4JRORSpz2iRC4uAOnmA==
X-Received: by 2002:a50:d683:0:b0:58e:2f0a:d5c8 with SMTP id
 4fb4d7f45d1cf-5a05d5c74demr603483a12.38.1721201535393; 
 Wed, 17 Jul 2024 00:32:15 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-177-101.web.vodafone.de.
 [109.43.177.101]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-59f6787bf00sm2183122a12.91.2024.07.17.00.32.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 00:32:14 -0700 (PDT)
Message-ID: <9a58a934-75c2-4f9d-89a6-3c38e9fae747@redhat.com>
Date: Wed, 17 Jul 2024 09:32:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] Convert avocado tests to normal Python unittests
To: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <CAFn=p-bMXm9qCD0hWiikyOmagFRryCZWrTx8xne9+x5j0QeNYQ@mail.gmail.com>
 <CABgObfbVdSDiJxNzv5TdUfOLLB=dLCkB0KgFQOxAcnG02gpDLA@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CABgObfbVdSDiJxNzv5TdUfOLLB=dLCkB0KgFQOxAcnG02gpDLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 16/07/2024 20.03, Paolo Bonzini wrote:
> 
> 
> Il mar 16 lug 2024, 18:45 John Snow <jsnow@redhat.com 
> <mailto:jsnow@redhat.com>> ha scritto:
> 
>     My only ask is that we keep the tests running in the custom venv
>     environment we set up at build time
> 
> 
> Yes, they do, however pytest should also be added to pythondeps.toml if we 
> go this way.
> 
>     If we move to pytest, it's possible we can eliminate that funkiness,
>     which would be a win.
> 
> 
> There is the pycotap dependency to produce TAP from pytest, but that's 
> probably something small enough to be vendored.

The next version is only depending on pycotap now. I'm installing it in the 
venv there that we also install when running the old avocado tests. Not sure 
whether that's the best solution, though. Would it be OK to have it in 
python/wheels/ instead?

> And also it depends on what 
> the dependencies would be for the assets framework.
 >
>     I'm also not so sure about recreating all of the framework that pulls vm
>     images on demand, that sounds like it'd be a lot of work, but maybe I'm
>     wrong about that.
> 
> 
> Yep, that's the part that I am a bit more doubtful about.

As I'm mentioned elsewhere, the tests that really have a hard dependency on 
the Avocado framework are only the tests that use the cloud-init images via 
the LinuxTest class. That's currently onle these files:

- boot_linux.py
- hotplug_blk.py
- hotplug_cpu.py
- intel_iommu.py
- replay_linux.py
- smmu.py

I assume we could continue using avocado.utils for the cloud-init stuff 
there, and just run them via the meson test runner, too. I'll give it a try 
when I get some spare time.

  Thomas


