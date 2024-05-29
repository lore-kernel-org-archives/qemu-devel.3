Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8C6C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJeZ-000496-Hc; Wed, 29 May 2024 09:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCJeX-000485-01
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:47:41 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCJeV-0002F3-7P
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:47:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42101a2ac2cso17817915e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716990457; x=1717595257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m9sa+GDxC4qFRJKHoWuuuwlmCyjqHA49y7MLQBK3FpQ=;
 b=Q5/gB8XxPKJlKKMIK6PzY/UaS9E+UpTMZej3N++XwOS8pQG8JDN6Jm4OYVE8f+qEP6
 PqyE7tEHwVdmbBbTJJNXstDK5oBF6r9H+h+hCr9dhZUDRkC6MRGXTz3eQDyRB94H2GvO
 vngMO38A5joovbexzSg1BfFerjtSypPPm3p+CUKQXyDj00KGDZQc4cBJXvrCZa93+L7w
 NMWlyJsAto5F3uDEaJo4fP5yLzt7PEuci86/Q/16jzKYmlAY3zleLxudFUgza4tP9rAI
 Ihs0zIJ9J3sHSuwAfJkDJPQKSvDEvO1yGzgRqfrJZ69z2bHFQ2tOGzSCxfZ+5929Yu8I
 FlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716990457; x=1717595257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m9sa+GDxC4qFRJKHoWuuuwlmCyjqHA49y7MLQBK3FpQ=;
 b=eUrtxa6jNmNhwWktQt+dPB5NtbqeaMwJO8Dl16vOwN4cdWcT/VUT97zvoSapvJANNm
 IcrvXKAknep/90fBk5JSKXc8gNWTj+yMR98yR63x1NXQ3eeAjgXWjLMsx8CEEaUu/mXj
 5iqXZeVeC1dLH9gGkrqILISkm8QZF8O1G5mgzA2aW6BvijMcLfVeWpwjbqeOnYLJjCJj
 uUPyE5YSJdAWSTOxWA3HeZkFA/dNOLX6D7iXM7hUTalXCfuiaahpe+DI8qqWS/wLD9r7
 pLn2MfMCt/ZHvl9vGha5KRJ51f1NFYkm5C1DKrUo7xPs4yny0J/JYoNNIqXKsor+EGCA
 b0Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI4F4DLeBCoS/W93iMNZxZ3HIf0R6oZbjt5TmIHzT4knyLL9mykDc/QrH4o1V3EDcUUxldvG+688qfpzuNJRwNirJcK5w=
X-Gm-Message-State: AOJu0Yzxk83nA/BmsP1RFIj/DGFcx2dNjVgfG8BhcidVo028IaiVMJf7
 mOaUDwKB/yv/DFcAMUxjVGC/2T1JVagVKHmLmQ7tBn3xfWkE1TYKxYWZmgbicuc=
X-Google-Smtp-Source: AGHT+IGmSF1wjoZxhpUS+FataIX12UZRxjkrA1rM91I8MA6kdn9bmh4iYphhPaWicG+GY5BA6Bl3xw==
X-Received: by 2002:a05:600c:5641:b0:41b:85bf:f3a8 with SMTP id
 5b1f17b1804b1-42108a0ba39mr134242055e9.35.1716990457467; 
 Wed, 29 May 2024 06:47:37 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100ee806esm212628655e9.3.2024.05.29.06.47.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 06:47:36 -0700 (PDT)
Message-ID: <fc6c2828-f869-4f5e-af06-785002000f98@linaro.org>
Date: Wed, 29 May 2024 15:47:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: prevent potential NULL dereference
To: Oleg Sviridov <oleg.sviridov@red-soft.ru>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20240529113643.3638618-1-oleg.sviridov@red-soft.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240529113643.3638618-1-oleg.sviridov@red-soft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Oleg,

On 29/5/24 13:36, Oleg Sviridov wrote:
> Pointer, returned from function 's390_ipl_get_iplb_pv', may be NULL and is dereferenced immediately after.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Oleg Sviridov <oleg.sviridov@red-soft.ru>
> ---
>   hw/s390x/ipl.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index e934bf89d1..2fa6a340a1 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -706,9 +706,14 @@ int s390_ipl_prepare_pv_header(Error **errp)
>   {
>       IplParameterBlock *ipib = s390_ipl_get_iplb_pv();
>       IPLBlockPV *ipib_pv = &ipib->pv;

I suppose ipib_pv being NULL here is a bug elsewhere. You should
add here:

        assert(ipib_pv);

and look at the backtrace or audit the code.

> -    void *hdr = g_malloc(ipib_pv->pv_header_len);
> +    void *hdr;
>       int rc;
>   
> +    if (!ipib_pv) {

(If this is a legit error you have to set errp here before returning).

> +        return -1;
> +    }
> +
> +    hdr = g_malloc(ipib_pv->pv_header_len);
>       cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
>                                ipib_pv->pv_header_len);
>       rc = s390_pv_set_sec_parms((uintptr_t)hdr, ipib_pv->pv_header_len, errp);
> @@ -722,6 +727,10 @@ int s390_ipl_pv_unpack(void)
>       IPLBlockPV *ipib_pv = &ipib->pv;
>       int i, rc = 0;
>   

Ditto assert.

> +    if (!ipib_pv) {
> +        return -1;
> +    }
> +
>       for (i = 0; i < ipib_pv->num_comp; i++) {
>           rc = s390_pv_unpack(ipib_pv->components[i].addr,
>                               TARGET_PAGE_ALIGN(ipib_pv->components[i].size),


