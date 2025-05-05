Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B1CC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 15:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBxsH-0003B7-R0; Mon, 05 May 2025 11:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBxsC-00038k-Bp
 for qemu-devel@nongnu.org; Mon, 05 May 2025 11:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBxs9-0002H4-G0
 for qemu-devel@nongnu.org; Mon, 05 May 2025 11:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746459407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Kirt7mx/FCCLhLi53i0GO46F0nGGil0HMiOb2vDKf8E=;
 b=Uu/uoJi9tOTNqEvZYXU2gYxuTIsuX4SOynSVPjfohJmZTNMZOLu7f3490zWo6eUfnJ87yR
 ysnQ23V7kFKSr+xSxXG3VE9yEVdQ4piYq0LocbNMEsl3JPBDYRiDF+McJs09e4b2SvYczh
 ywx2YiNoHif8mPulHSifu/s32cZP6NE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-nhLVNME-PuWj2upj_3t73g-1; Mon, 05 May 2025 11:36:45 -0400
X-MC-Unique: nhLVNME-PuWj2upj_3t73g-1
X-Mimecast-MFC-AGG-ID: nhLVNME-PuWj2upj_3t73g_1746459404
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39134c762ebso1348761f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 08:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459404; x=1747064204;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kirt7mx/FCCLhLi53i0GO46F0nGGil0HMiOb2vDKf8E=;
 b=lCI6NajO5Q0ScyB4jhuSxndY3tAlcHQrsLRJtGTa77USk4i3peKF9qId2SS7y//2wJ
 8dGq4zw+yUzCqjL2TOMPmCoxyWWVaOEGAP2NEVYiqvscRgqoilZopyJR+ala3IlDlrG4
 VtGgbc+NcyUUeJq20yrYEq4mb1sJn8HJ0DMIwUrb1B1FTaJP2ybjka0Vy8VbMfsI9QNC
 Vx6Y+eqRDuu8qygJEBzZxKzPLRTeYvVnZVE7fJmX3b9td403yC7RuRuwEbBvoE1DmQwP
 BXZvu3r8x+oQqyU6KOFgcuRai9qJ9CC8I9OVqyf13GttZNkwYouX67MGnIxqzboHT+l7
 cusA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI9sP7qWN1slwSK4hxlW32BXb5yqJeULxcB6EEgOeQXkPmCiuHSjLkUx0CT08zKVkz+mNLmM6hpR32@nongnu.org
X-Gm-Message-State: AOJu0YxaE/WPlKrsK6ElPeeikuo12fh2wQlYs8YKgvGZpGSO6LmdjzC2
 m5U4DmSGt7sFQsQL1HFr0J0oyE01voh2ozx5d587ghYa04xiBATcitsoHIiu6eFbLwRlmiHf8Sb
 ejCdROhXgJWOKTq97oh1P7LcDXqsA1JcJunveeWm0xLJVbKMJr8ld
X-Gm-Gg: ASbGncsU7a7h/6VUCv+olbnZ1gHxx/SYPLPY6qZEuJjqw48tROASLE1twl4eMV2kkxO
 9WHkS3MKfjuatfpsuEeRmNQlrODqGjviAVrz1P1R9hW6hVR9IT4bNFLWiEao0UuqVYwVrkMm6Ws
 ntBi4Gc48G9pt2jbTcxHBp5zgiXTnKy5mUNx64xxmzPOy59WlN5yXIH39eupokmIrNcllv+4t1t
 u6+zBkNA/9D58epb1xUclY0SKCxKKSygfgL489r1NK6+LVHwMhZ2/41TAg/UJLMjh4T//ExyLWz
 DViHfUOEPZoTwUA=
X-Received: by 2002:a05:6000:2912:b0:399:7f2b:8531 with SMTP id
 ffacd0b85a97d-3a09cf1e20bmr7594528f8f.38.1746459403848; 
 Mon, 05 May 2025 08:36:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTZwz9vZ39DJ/j/j4NX+v9w9NoUjjVrXgePT50oYeaplSqw43VPiRWozZfkJj9Bf8meu827g==
X-Received: by 2002:a05:6000:2912:b0:399:7f2b:8531 with SMTP id
 ffacd0b85a97d-3a09cf1e20bmr7594510f8f.38.1746459403427; 
 Mon, 05 May 2025 08:36:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-441b89ed4f5sm138508045e9.18.2025.05.05.08.36.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 08:36:42 -0700 (PDT)
Message-ID: <881635e2-8b95-4e3f-9ef0-e8cccf675436@redhat.com>
Date: Mon, 5 May 2025 17:36:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] docs: Bump sphinx to 8.2.3
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: devel@daynix.com, John Snow <jsnow@redhat.com>
References: <20250505-sphinx82-v1-0-85f2418b33b1@daynix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250505-sphinx82-v1-0-85f2418b33b1@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/5/25 14:19, Akihiko Odaki wrote:
> Supersedes: <20250120-sphinx-v1-0-65151b4441ac@daynix.com>
> ("[PATCH 0/2] docs: Bump sphinx to 8.1.3")

Sphinx 8 requires Python 3.11 on the other hand; not an objection, just 
a reminder for myself to add a note to the Changelog if this patch is 
merged.

Paolo

> sphinx 5.3.0 fails with Python 3.13.1:
> 
> ../docs/meson.build:37: WARNING: /home/me/qemu/build/pyvenv/bin/sphinx-build:
> Extension error:
> Could not import extension sphinx.builders.epub3 (exception: No module named 'imghdr')
> 
> ../docs/meson.build:39:6: ERROR: Problem encountered: Install a Python 3 version of python-sphinx and the readthedoc theme
> 
> Bump sphinx to 8.2.3 and also sphinx_rtd_theme as required for the new
> sphinx version.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Akihiko Odaki (2):
>        docs: Bump sphinx to 8.2.3
>        MAINTAINERS: Add docs/requirements.txt
> 
>   MAINTAINERS           | 1 +
>   docs/requirements.txt | 4 ++--
>   pythondeps.toml       | 4 ++--
>   3 files changed, 5 insertions(+), 4 deletions(-)
> ---
> base-commit: 1da8f3a3c53b604edfe0d55e475102640490549e
> change-id: 20250505-sphinx82-ebb3f0bde7d7
> 
> Best regards,


