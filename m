Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5ECC369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 07:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBqKz-0001rM-FQ; Mon, 05 May 2025 03:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBqKy-0001ov-8l
 for qemu-devel@nongnu.org; Mon, 05 May 2025 03:34:04 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBqKw-0005Ob-BA
 for qemu-devel@nongnu.org; Mon, 05 May 2025 03:34:03 -0400
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-af6a315b491so3818302a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 00:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746430440; x=1747035240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6hl9Fr5Uut2e5yH4oyz2jftsKh3FXLn7pkoz9p3lp0k=;
 b=UGBPYlkisoRCYhIn8mF+HN68iiW2sN1oGbyHfPoC41hxI09cjKVE5kmgRfONcT+k7Q
 Q1I1WP43j3+CyCZ7QEA+PCGPqw5GnNJrktYYd2TPFIPCc1CA0d6x4OBOAcZhbn9XwQwT
 TfoUrrHn8dVvDN8LgIetTy9PxXiuygOJuUIREkuFEAu0SenDQp4rD/w/Lrb489VZcWUD
 /qEeQRm4eiesUvDVqdquU39ovoF7T/11IO+shT63T3BUpU3WiNiZiTDa4t3uNnJ9MKd2
 zFBtOplni4eMNsspdyizVijsLsbjtbVqkb0bMFuWdQRviMSMUowMNytK5KjdCQKpVLD0
 +D1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746430440; x=1747035240;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6hl9Fr5Uut2e5yH4oyz2jftsKh3FXLn7pkoz9p3lp0k=;
 b=vlr7yf9SEpJZC4JvyHn9MRFXvuUvqXH5XzUqsmHXB8M4sx+OQuAknX5BgABZHl3VaD
 stJT7SGhI4HGTkvQM+K3P4l8pWlKS+HHjlAFeyqbsUMcAVIkvhew1bvHSwmJ8Z15djyU
 epoBVbGMn5rNLgEPm+nc11CsOJJ6MC4FqS46hJm9YpDg0QNyApb3pOsy20+1/KelT+JU
 zx9gSmT61Y0iqbAQZOmRaEVYhMAXfVhXmlu3/O6n29Vm2gNOcGdlykzoQKPWnd3I1VjN
 fMEO9Je0lRFxN8eUWlYAkCDD2/8CMgHfthBsLgeOPeXEgAvTDGcQv4nccn0lnsvSr6DU
 Y7SQ==
X-Gm-Message-State: AOJu0YyZNUUBOoRGlrVGAJbWFoNgSa4EHmqQfBBYE9tmkfuGnNp0ODHS
 Dw65zSSSqLjTEbyVT+0VHcVypteS/nZw5KmiN3tZH/CPhqs2xVM=
X-Gm-Gg: ASbGncsrCEI8ntIO4/FmTPMswzowzoIG3cVyUMNqTINaOu65sojbNnbxBwExDbvs8/f
 uRBXS81CJng2gwzo6VnGCKxTjAqjVUb24ZAUGSYdQLxvppECfPLRY/DmG7gkJgH59OhP1+UrBuX
 8A6HVL8M73aEvLDh8cRa/qdyom8PS4GodvbtRcRkHVLRTRvPsSMU0YFZcmVDosBqHHeIJBh3mfw
 xkFlyo6zmTC4xN+4DCrPrdGpOXE7pY8+8BfZnSXmoVlFtrXoUabjallDBox6AxBUkdfl5j9cfrF
 EOqpe7YpxyPZ5jP2SQnVW7/UrEBW5F+HyH8JBj5tdfkWpbU=
X-Google-Smtp-Source: AGHT+IFBlKvJ77NDrDIfTPOChZIo9r0WK7zWLP7MkdJsOhsxtR08ERw8/462fL7qnC+UOfpEF0/7WQ==
X-Received: by 2002:a05:6a21:6801:b0:1f5:7280:1cdb with SMTP id
 adf61e73a8af0-20e96605cc6mr8599548637.16.1746430440391; 
 Mon, 05 May 2025 00:34:00 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.17.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3b62502sm4909155a12.32.2025.05.05.00.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 00:33:59 -0700 (PDT)
Message-ID: <92f3d3f6-d90a-4010-b67f-b282ed5f3c91@gmail.com>
Date: Mon, 5 May 2025 15:33:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] vfio/igd: Detect IGD by OpRegion and enable OpRegion
 automatically
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <c.koehne@beckhoff.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
Autocrypt: addr=tomitamoeko@gmail.com; keydata=
 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
In-Reply-To: <20250428161004.35613-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x543.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I forgot adding v2 in subject, sorry for my mistake.

Moeko

On 4/29/25 00:09, Tomita Moeko wrote:
> As proposed in a previous discussion [1], detect IGD devices based on
> whether it has VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION exposed by kernel
> and enables OpRegion access by default. This enables out-of-the-box
> display output support for IGD passthrough without having to manually
> set x-igd-opregion=on, which probably saves effort for libvirt users.
> 
> This patchset also limits legacy mode to Gen6-9 devices, as Intel no
> longer provides CSM support and VBIOS on newer IGD, and Seabios does not
> support setting up the 64 bit BDSM register on Gen 11+ devices. Exposing
> VGA ranges to guests by default on platforms without VGA mode support is
> undesirable.
> 
> Additionally, as we enables OpRegion on IGD devices by default, and
> Intel removes the BDSM register from Meteor Lake [2]. There seems to be
> no extra register quirks rather than OpRegion required on newer devices.
> To support them (and probably future devices), the generation limit is
> removed, with BDSM quirk only applied to known Gen 6-12 devices. 
> 
> Note: I have not been able to test this on Meteor Lake or newer
> platforms due to lack of hardware.
> 
> 
> [1] https://lore.kernel.org/qemu-devel/20250325172239.27926-1-tomitamoeko@gmail.com
> [2] https://edc.intel.com/content/www/us/en/design/publications/14th-generation-core-processors-cfg-and-mem-registers/d2-f0-processor-graphics-registers/
> 
> Changelog:
> v2:
> * Removed "Allow hotplugging with OpRegion enabled", hotplugging is
>   always forbidden.
> * Test device is not hotplugged and get opregion in a single function.
> * Update documentation along with code changes.
> * Minor code style fixes.
> Link: https://lore.kernel.org/qemu-devel/20250421163112.21316-1-tomitamoeko@gmail.coms
> 
> Tomita Moeko (9):
>   vfio/igd: Restrict legacy mode to Gen6-9 devices
>   vfio/igd: Always emulate ASLS (OpRegion) register
>   vfio/igd: Detect IGD device by OpRegion
>   vfio/igd: Check vendor and device ID on GVT-g mdev
>   vfio/igd: Check OpRegion support on GVT-g mdev
>   vfio/igd: Enable OpRegion by default
>   vfio/igd: Allow overriding GMS with 0xf0 to 0xfe on Gen9+
>   vfio/igd: Only emulate GGC register when x-igd-gms is set
>   vfio/igd: Remove generation limitation for IGD passthrough
> 
>  docs/igd-assign.txt |  11 ++-
>  hw/vfio/igd.c       | 218 ++++++++++++++++++++++++++------------------
>  hw/vfio/pci.c       |   2 +-
>  3 files changed, 137 insertions(+), 94 deletions(-)
> 


