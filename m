Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA15FD3E79A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 10:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8crc-00018p-Jl; Wed, 06 Nov 2024 05:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t8crb-00018T-Rc
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:02:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t8crZ-0000Tz-Ll
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730887327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cOuJ/q03Fr4jVz8Q9vgp7ggbddG7mGV3P2kKkj+Zzvw=;
 b=iRSJLCIT/Fe2rC1OF468weU4o2lCE/7/CRnmsk7gg3VqS3X4jnIevXiRHFvq5ZzpGh4B5h
 BQvbU+lQUyykyi+IKyn+g4i49O+sZqvGE8sDXq+62ieCTivXgv13lGm38oAzf/qyt0p/Au
 a0MTuevb7pizsDzx62jQgrxJZ1lWsMU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-oG2f6UXjOVqkfRS_j7NuUg-1; Wed, 06 Nov 2024 05:02:06 -0500
X-MC-Unique: oG2f6UXjOVqkfRS_j7NuUg-1
X-Mimecast-MFC-AGG-ID: oG2f6UXjOVqkfRS_j7NuUg
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-539fdef0040so5064174e87.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 02:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730887324; x=1731492124;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cOuJ/q03Fr4jVz8Q9vgp7ggbddG7mGV3P2kKkj+Zzvw=;
 b=rM3xctdUYE+HAzR6+zfsmGJw8gH5Tjn0c0yI+0dmxw+Q8XZPQWLMpjLkRpA6ko0OJ7
 JxCYhFA7ki+aklK9vPSZdpwfJxPyOxzvXt3wY05IHSYhv/m2QdOIXDwe0B0wvH8VNb0/
 707ZQyhIJ5f12TwoWhqUPHSHBZSOSXB7TTjSJLfvum91Wbp6dpu1Z5ItH5vtx6JUfPe1
 w6XD6oH6Oa7Fr1qkmmebL6y2AufAHngaFdEUGsiR0jYFrunEFHAaj5jjq8NdaQTKaGON
 DSG5oaYGp+jJlNd+vDFj4sDasbi11aPJJFvJbkLhTiz6LGQM9fTWd70E33pI9GcL+5tD
 x0bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOZxd2/RrQTpAjzi08Rhklt0w/V42N5bDXNIrT70Mo0bd/WdEtHdm75lxP9FGn9nllaGQItyl4i4sg@nongnu.org
X-Gm-Message-State: AOJu0YzUKAc0MC0T4qvQtprFx2Z8U8QTaPJc/JOTNGf3w5iit9+oKUAq
 ogxCDCJs4d4g3tbxgHsy7Nl9Egz/OS9k2t03zXenLS2jH6ltEVt5RV/FXyrXmTmI0HzgwepcohC
 6UrmeAXGTzE/M09w6vZd2XIRy0HREKvJrYZmvxRTJqZLQ6BkIyu+Q
X-Received: by 2002:a05:6512:3c96:b0:530:aa09:b6bf with SMTP id
 2adb3069b0e04-53d65df7628mr9092663e87.24.1730887324425; 
 Wed, 06 Nov 2024 02:02:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI8SXzCpZeWxlz4C7ZqXz/ulWLf0wDy2cz+wxJqXQ7bi39nJXd2J7veDrUZ8J9Zm40yRXkrg==
X-Received: by 2002:a05:6512:3c96:b0:530:aa09:b6bf with SMTP id
 2adb3069b0e04-53d65df7628mr9092636e87.24.1730887323973; 
 Wed, 06 Nov 2024 02:02:03 -0800 (PST)
Received: from [10.33.192.239] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5e56sm16947945e9.2.2024.11.06.02.02.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 02:02:03 -0800 (PST)
Message-ID: <cb02028f-e4a2-4b9f-ab61-1d90f255fa41@redhat.com>
Date: Wed, 6 Nov 2024 11:02:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: refresh package lists with latest libvirt-ci
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20241105152433.344974-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241105152433.344974-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 05/11/2024 16.24, Daniel P. Berrangé wrote:
> This updates the libvirt-ci  submodule to pull in various fixes,
> the most notable being
> 
>   * Removal of the macos-15 target. Cirrus CI has changed their
>     infra to only permit testing of a single macOS version,
>     currently set to 14. Our attempt to test macOS 15 was being
>     quietly converted into a macOS 14 test, which we already
>     have.
> 
>   * Reducing native package sets in cross builds. Some packages
>     were mistakenly marked as native, rather than foreign, in
>     libvirt-ci. Fixing this causes our dockerfiles to pick up
>     the cross arch package instead of native one, thus improving
>     our test coverage in a few areas.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
...
> diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
> index bfa96cb507..5f298a0f50 100644
> --- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
> +++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
> @@ -30,10 +30,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>                         git \
>                         hostname \
>                         libglib2.0-dev \
> -                      libgtk-vnc-2.0-dev \
> -                      libpcre2-dev \
> -                      libsndio-dev \
> -                      libspice-protocol-dev \
>                         llvm \
>                         locales \
>                         make \
> @@ -101,6 +97,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>                         libglib2.0-dev:mips64el \
>                         libglusterfs-dev:mips64el \
>                         libgnutls28-dev:mips64el \
> +                      libgtk-vnc-2.0-dev:mips64el \
>                         libibverbs-dev:mips64el \
>                         libiscsi-dev:mips64el \
>                         libjemalloc-dev:mips64el \
> @@ -112,6 +109,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>                         libnfs-dev:mips64el \
>                         libnuma-dev:mips64el \
>                         libpam0g-dev:mips64el \
> +                      libpcre2-dev:mips64el \
>                         libpipewire-0.3-dev:mips64el \
>                         libpixman-1-dev:mips64el \
>                         libpng-dev:mips64el \
> @@ -123,6 +121,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>                         libselinux1-dev:mips64el \
>                         libslirp-dev:mips64el \
>                         libsnappy-dev:mips64el \
> +                      libsndio-dev:mips64el \
> +                      libspice-protocol-dev:mips64el \
>                         libspice-server-dev:mips64el \
>                         libssh-gcrypt-dev:mips64el \
>                         libsystemd-dev:mips64el \

  Hi Daniel,

sorry, but looks like this breaks the mips64el container:

  https://gitlab.com/thuth/qemu/-/jobs/8281891574

I guess you likely have to add some of these packages to our mappings.yml 
file now like we've done it here:

  https://gitlab.com/qemu-project/qemu/-/commit/c60473d29254b79d9437e#37203e5ef4f28ec1d635ffdb22d85d7ffb8cf714

  Thomas


