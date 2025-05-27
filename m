Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5669C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 15:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJvy4-0003XW-00; Tue, 27 May 2025 11:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uJvy2-0003VR-1K
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uJvxx-0007Te-TY
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748358700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3sNGWd+VHncxTjaN1bnDQMjw95tKvwRYm31+HLIC/bU=;
 b=AK/J1WdLreePHrooEY0IXgVBbQ8Oxl3x1RMfNZVSA59Zz7dra8PMQeUJ9qbXXrFIeiQL0/
 +HMwGJXW3xBbwmS0+ewXgXgwoSKjq4gE3ap6qn5KPBQbD41nStKWPozAr5hiTsjMTsiWjL
 XnsuHEW2lOResCfXy9VE+NL3rtrZZhA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-abpbSy9aOiqnZCR8odGHtQ-1; Tue, 27 May 2025 11:11:32 -0400
X-MC-Unique: abpbSy9aOiqnZCR8odGHtQ-1
X-Mimecast-MFC-AGG-ID: abpbSy9aOiqnZCR8odGHtQ_1748358692
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4d6453521so1271578f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 08:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748358692; x=1748963492;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3sNGWd+VHncxTjaN1bnDQMjw95tKvwRYm31+HLIC/bU=;
 b=VtuMXIpIxEoLvnuSINA1fTngAanYlklkq3eBFztvqC+8EsCHbhwzIRyaV0s6/Re7Dj
 ccP/Nzg0KuwPgRk+S9x0HJ+v5LjFxDxnwiPNSe//zsygPlI+ow9d4N3OjLArwzzeheFg
 QINDI0FilsiLvXxgw/E21b2KMsNscGyHLwupVtaJTwmPnz+larRlvVqpmfZwSNPfUn1z
 GhuPVZytYWz49tURBYCiJljKwLveuoR4xn3O/FtGnq/fDU9GT6zeBtHfFhIn5YmorZz7
 85vRyGt5UcQcLfkkumXz5fm+v0vTZsWYN3oWhP6SBzVSCZppkfcfloLhGTcILqfFaJF8
 v/Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrHO8GvOJqClN9z1/zg8iB9+EjXAq5lNAsO0yGI94izSpxLUqR+sRdvWOj6xanvnHc0ajWxDs4B9oz@nongnu.org
X-Gm-Message-State: AOJu0YzcKtnPuYWWVi+D62CekGrgSTQahPK3TSlkkzEuhnj7ll7QF3VC
 RqX3TXE9mexLKmRU6hIA5iZ5MMmmteZ2TSDmTg5AeahjgXjlJyVPusbDEaPDAHUQF5RZ4eJaG/9
 FGTUMGNtAAJb38atGZOFVrrt0hKXtTTBISPp8778Fbe7fW58I28rpvCfc
X-Gm-Gg: ASbGncvXVXt/QMyZByHgPGxKqWxVHMdr8NYY5vJUwyBNQjJ91173RS0Pm9QMCxcLgXr
 DitkEKVpzETDNAvtWUzmYO20RVjGTYkhBezvj0pt6ee/JLmqOw1nCR4ARGbpu1eZiK4yWDhJvhd
 yEG7vBZBcB2yFpqwhtDP2hrNIQXvW51/Erhh40PBp2LEwCxtmB2KaDkgj7zJ73yb4461hQF20cd
 2XvkDu/FAVcMl/ASG1xkZTHRTYyun264MBFFqUhwW+5rONn4wpPtwEH/IjDjcTypwXQwgT+Cx3E
 Kq9GkV+6q9Io8d8uvUIC8B7JJ1SL6VQSEtMTSyl3
X-Received: by 2002:a05:6000:40da:b0:3a3:685b:118 with SMTP id
 ffacd0b85a97d-3a4cb46302fmr10550249f8f.24.1748358691598; 
 Tue, 27 May 2025 08:11:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu1dnxnH0u+HATulQxNzYzh40wJKdh+9zKQT2XJvaMhG87xn+pQ4ztUklerpiVi9CwGHDptw==
X-Received: by 2002:a05:6000:40da:b0:3a3:685b:118 with SMTP id
 ffacd0b85a97d-3a4cb46302fmr10550208f8f.24.1748358691179; 
 Tue, 27 May 2025 08:11:31 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-26.web.vodafone.de. [109.42.50.26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cfcece9dsm9676491f8f.5.2025.05.27.08.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 08:11:30 -0700 (PDT)
Message-ID: <33015b21-bd6b-473f-8066-1df6c0c731aa@redhat.com>
Date: Tue, 27 May 2025 17:11:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/functional/test_aarch64_hotplug_pci: Update SHA
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 eric.auger@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org
References: <20250527150229.1617074-1-gustavo.romero@linaro.org>
 <20250527150229.1617074-2-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250527150229.1617074-2-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

On 27/05/2025 17.02, Gustavo Romero wrote:
> Update SHA for 'linux' and 'initrd.gz' images.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   tests/functional/test_aarch64_hotplug_pci.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
> index fa1bb62c8f..bb2c121503 100755
> --- a/tests/functional/test_aarch64_hotplug_pci.py
> +++ b/tests/functional/test_aarch64_hotplug_pci.py
> @@ -20,12 +20,12 @@ class HotplugPCI(LinuxKernelTest):
>       ASSET_KERNEL = Asset(
>           ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
>            'current/images/netboot/debian-installer/arm64/linux'),
> -        '3821d4db56d42c6a4eac62f31846e35465940afd87746b4cfcdf5c9eca3117b2')
> +         'd92a60392ce1e379ca198a1a820899f8f0d39a62d047c41ab79492f81541a9d9')
>   
>       ASSET_INITRD = Asset(
>           ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
>            'current/images/netboot/debian-installer/arm64/initrd.gz'),
> -        '2583ec22b45265ad69e82f198674f53d4cd85be124fe012eedc2fd91156bc4b4')
> +        '9f817f76951f3237bca8216bee35267bfb826815687f4b2fcdd5e6c2a917790c')

If the images reside in a subfolder of a folder called "current" there, and 
are changed in the course of time, that's a good indication that we should 
use different location for the test images instead, otherwise we'll continue 
to play SHA-updating-whack-a-mole forever here.

Could you please try whether it works with the images from the "20230607" or 
the "20230607+deb12u11" folder, too, instead? (see 
https://ftp.debian.org/debian/dists/stable/main/installer-arm64/ ).

  Thanks,
   Thomas


