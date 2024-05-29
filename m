Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94CDC27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJj1-0006wV-4X; Wed, 29 May 2024 09:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCJiy-0006qZ-DW
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:52:16 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCJiw-00038I-MD
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:52:16 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-529b4011070so2546796e87.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 06:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716990733; x=1717595533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d9YpsjaIZLNwdQwS/D25zq3vVF2SnGjIO0zM0Ve47k0=;
 b=K1jdoC2QCVWD30w9up2VOi4IvPKjgAk0/Un0LXsz1740gSbzyjmJALLf79G3n5Y/Lf
 wYWXmYz3yNHtOjPdGGx9JrvxN8iuIs1FkAOMBh5SQntbVBPJ9RnrIHxjIDH5P1ZtcitW
 1Qelx+qlzp2TM8EO1ROFcmSrA5NwcVGWI/CsmZdwZXq5Q/rRAG/vTZMO8E/eFbltIoQe
 2+hKTOxAD1D7SHRL6QrGlJcEwBBR4xNO/ukmzfpsfG+CCv3WwOBH8GEvdyiT3kzq29xQ
 oF1VL+hKLGVmxy4mGLw5si4fBuCZGGDEBF6acD9SVlg6AbudVdWGxJ+TSeCmCbmvO74Q
 McBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716990733; x=1717595533;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d9YpsjaIZLNwdQwS/D25zq3vVF2SnGjIO0zM0Ve47k0=;
 b=FJfMeVSVnAqlGo1j/RnP/qhQrKQK0C9RvhIxXrLGQqrFoY/9raVrKZISlgRYxR+oXU
 9Pto9dD9hWg18DP6dQ9J14/mQNiY8DNF+kh3pr8np2vZH1jeYZ6LLYrTYQZsf4NdOqEL
 mEQOc4Ngfd6Lv6hKy3Dxi+uldHsKinsCYzEZWpbhoigpL7Xe7UZUJQ9WriK46Jcku2sI
 hrxzNPKELeaOmLkY8qaZTxtH1o+1Fy69/iDPakIj0sn7gJwGZDEcrfdIGEODyv5gf1in
 Cvyd5wJvCorTWokFFQyLlbjc2wwAZFaMkMz2MHuDzaeZV43L0psvQgJlvrFRQBhjedRm
 BMnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1EA+swg+DKp0glj5g72PsGvykhKkBdKxWjJwOYo2bwk4jWJzNpRO9niMHcTMZUA3gYa+AoqC71CzozAkagLPKoJAgZ8E=
X-Gm-Message-State: AOJu0YxziK3jV4EyBKKCLmZar7rhWGy168OD7SphUuj8rTIpukgSGiw/
 Q+ETrLRn9G9+MglQCyNAffHs8VPBbsbe8BnWwx9oIoTgbJRJXqWTIV+TyNYqavE=
X-Google-Smtp-Source: AGHT+IFxa7v6SVRYVrtiKvHZogCQOfleuuMtO1ebVcpxT1OW4EDawz+C/Ib38ksF/E+2kIpY3JXGng==
X-Received: by 2002:a05:6512:48c3:b0:52b:51f9:a37d with SMTP id
 2adb3069b0e04-52b51f9a3d6mr864470e87.56.1716990731822; 
 Wed, 29 May 2024 06:52:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100ef1207sm211566765e9.10.2024.05.29.06.52.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 06:52:11 -0700 (PDT)
Message-ID: <219da54c-7c9d-4baf-ba0c-d4afb6101cbe@linaro.org>
Date: Wed, 29 May 2024 15:52:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net: prevent potential NULL dereference
To: Oleg Sviridov <oleg.sviridov@red-soft.ru>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Jason Wang
 <jasowang@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20240529110804.3636963-1-oleg.sviridov@red-soft.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240529110804.3636963-1-oleg.sviridov@red-soft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 29/5/24 13:07, Oleg Sviridov wrote:
> Pointer, returned from function 'spapr_vio_find_by_reg', may be NULL and is dereferenced immediately after.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Oleg Sviridov <oleg.sviridov@red-soft.ru>
> ---
>   hw/net/spapr_llan.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> index ecb30b7c76..f40b733229 100644
> --- a/hw/net/spapr_llan.c
> +++ b/hw/net/spapr_llan.c
> @@ -770,6 +770,10 @@ static target_ulong h_change_logical_lan_mac(PowerPCCPU *cpu,
>       SpaprVioVlan *dev = VIO_SPAPR_VLAN_DEVICE(sdev);
>       int i;
>   

Trying to change a MAC when no NIC is present is dubious, we could
at least report this using qemu_log_mask(LOG_GUEST_ERROR).

> +    if (!dev) {
> +        return H_PARAMETER;
> +    }
> +
>       for (i = 0; i < ETH_ALEN; i++) {
>           dev->nicconf.macaddr.a[ETH_ALEN - i - 1] = macaddr & 0xff;
>           macaddr >>= 8;


