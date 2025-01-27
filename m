Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5882CC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 13:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPcX-0002T6-EG; Mon, 27 Jan 2025 08:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcPcT-0002PP-Ok
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:57:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcPcS-0007jU-3M
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737986258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z+2qpu+pzyZMtIosZMr8wzknKrRPJP2BuWInY845pQE=;
 b=E0RHg906wrLtfczl7fQ/QazhIHUwVxFlP2QSLAKAQn7jG9+4jkO9pWuIowBvVRNq0xLTGP
 3rTk9jJ/OdLLnxgFrzU3OZyR+NMpu/+yavpQWGJXPUvrTIHAXp4Hi01k6BfeDSoaT2yoIB
 IhgLU+d8LOzGVNvgZFmWad7kLlw0Lwk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-lH4AXUX4Pfm0TeEtBs_t1Q-1; Mon, 27 Jan 2025 08:57:37 -0500
X-MC-Unique: lH4AXUX4Pfm0TeEtBs_t1Q-1
X-Mimecast-MFC-AGG-ID: lH4AXUX4Pfm0TeEtBs_t1Q
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43646b453bcso22603635e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 05:57:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737986256; x=1738591056;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+2qpu+pzyZMtIosZMr8wzknKrRPJP2BuWInY845pQE=;
 b=etyJPl331tKtSfA5Y8Z2Bpjg7puVtu91mibJrXqoRJO4/UVsNWJCCT7aX2/IbNQVlz
 rFRYV94BMMm0qiQBkrIssyegMWSpBejdepzbpdUV4fTtH5XH2nPugrZ0qb0/8jRunOpI
 U17fe6OqFhoA562tExKUmWkenNre77LJX1IryQDd4K9MYTm0H9FgsqkfVB77TfakL5vH
 j9Z0NtKRRsh04jTqoPOWlP2S16DQivO6s6cvCDVpJDKrd4Z+p+A4QX60+Zjm2ikLK/fi
 Z7LDegkAtt52JSZ1pAAH73oN6i27fF6E+wQNSpWM/rqOL5g5XMSz9QghTAG9EMr5Cg0N
 NjXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUsX4MU//8DGQl/Nw8NSr/GWD2M3hoS+h45YjhB+KZbsiJHmNQvtbjwd46tYiDFVvO1QtGW2+fAFhM@nongnu.org
X-Gm-Message-State: AOJu0YzUiBFvDwqwZAWrgn2VQPxf1PmO+Hc3sJMkGtDJEqh1quE9ROLi
 5vfu0ukqhojHCP5L3m+X5IFyUcoxbr7dvz8I1hQDD33GmeKjchBEjwJvY3ekZxThC0+CkGXeH9z
 40SkxkNlDgJ6PXkq8LXAlFEU8ShlsuIJ3Hqv1oOavtA4/nP3RXISS
X-Gm-Gg: ASbGncvJSeyRgL4KinnEtT+ddKn+1SqImt0xg19BaYcO41Be4cNkQJn8YiM3+pV0XpO
 aTLUQR3zS8gNwMZ6yhxXucFOLS5Uv7vtLsPRp70oHTThCR6E6JwnmVfZ5N23VjMNBwR0cCg2sxY
 eMpOGbxb3z+crgocMYa07XJ56MeFoCEFkElDVoaRvdnrGwsjc/+Zi2S5BNjp4Onrh8dEL9Pm/FM
 Ax3ETdGzQO4vCuF46h+VAqiTx6RPrHD4EVUdwCHCAueHUi3WIPsvDf6/IIsaLwQ/EHn0ifbik/g
 xn61i4WOR6tD1NTOgtgw8CDntJRsoA==
X-Received: by 2002:a05:600c:5012:b0:434:9e46:5bc with SMTP id
 5b1f17b1804b1-438913ca718mr409945585e9.10.1737986255890; 
 Mon, 27 Jan 2025 05:57:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkFtPjvysQ05pXD7uyX10iWD6KoXRTMn6RClJ8WbJGdhnicdJ3lTaLa2oYBxTHOEO6mJvBag==
X-Received: by 2002:a05:600c:5012:b0:434:9e46:5bc with SMTP id
 5b1f17b1804b1-438913ca718mr409945285e9.10.1737986255532; 
 Mon, 27 Jan 2025 05:57:35 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd54c0ecsm134745655e9.30.2025.01.27.05.57.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 05:57:35 -0800 (PST)
Message-ID: <c364ee71-7f0c-43d2-8ded-a7b8156c0839@redhat.com>
Date: Mon, 27 Jan 2025 14:57:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] target/arm: Set disassemble_info::endian value in
 disas_set_info()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
References: <20250127115426.51355-1-philmd@linaro.org>
 <20250127115426.51355-4-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250127115426.51355-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 27/01/2025 12.54, Philippe Mathieu-Daudé wrote:
> Have the CPUClass::disas_set_info() callback set the
> disassemble_info::endian field.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index f9fdf708653..9de8c799c77 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1220,6 +1220,8 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>   #else
>           info->endian = BFD_ENDIAN_BIG;
>   #endif
> +    } else {
> +        info->endian = BFD_ENDIAN_LITTLE;
>       }

I'd maybe rather go with something like this:

     info->endian = BFD_ENDIAN_LITTLE;
#if TARGET_BIG_ENDIAN
     if (bswap_code(sctlr_b)) {
         info->endian = BFD_ENDIAN_LITTLE;
     }
#endif

What do you think?

  Thomas


