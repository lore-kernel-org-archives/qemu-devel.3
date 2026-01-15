Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01859D46605
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 17:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgRD4-0005VQ-P7; Thu, 15 Jan 2026 12:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vgRD2-0005Ts-4p
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:32:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vgRCy-0004cB-Cm
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768498350;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LttDJVM+2ACjrkyMP76zqD9alqtTU48uei/jzftems8=;
 b=Nyg/39z8HoZaHALvc3FGYu5BoymmHrt0WAN+Wu11rI+8fL+aSF+FKNIuEf94KShlYrzYOJ
 ZxBrp2ThvwQTcdqe7Ff7aRzJjVqWXnUXB72Zvzg8Zf7V7svXB2BOlrEPn4rkn6hJZjjeOr
 HJY0gjgWsFJTw0120kNKBXkAsGxbieg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-OXyrAlxHNDatTFDSq20M7w-1; Thu, 15 Jan 2026 12:32:29 -0500
X-MC-Unique: OXyrAlxHNDatTFDSq20M7w-1
X-Mimecast-MFC-AGG-ID: OXyrAlxHNDatTFDSq20M7w_1768498348
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47d4029340aso10139715e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 09:32:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768498348; x=1769103148;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LttDJVM+2ACjrkyMP76zqD9alqtTU48uei/jzftems8=;
 b=gbcNB3npAAUfV6s7giIXu69FCCUlcZwHKyvjsZwhXG0BopkdYmfAtMqxRkStKc4QZj
 WrD54HJHxQ2kM1AMlJTZ6uc+3PUhNZyVNi7VG5oQutT3weoFptZJS5d0KdlJe4Wg0SO7
 Dlk7ivf2i8TRRkGZIacQlZEvJmaY4XEmbBmhq2Y42XhbkSYmdWar+E2H4wAQiM+X9QtG
 00RlJWKFbnd6N5q+kyAg2ay1Fc1JLcZKhZtj0o3W9op8yCiLIOA8ciWF6xwnE865BRkW
 i3Mhx41uqxDvw3uVNt7jP5BAYIdhkOt4tyNZtalwbQrxH98Jbd56d4xr2CHHBy+3Nkf4
 euiA==
X-Gm-Message-State: AOJu0YxGneF4HNBcgyTsGA8YTNsNSgBVwgqVWr0kPLynScwEi6vQluBf
 GE4Yx8Vjoyg3nQKfrCWu8354kORSD7IXkOLj/Jy6xtZ6Zgbt/1ki+CxTIoX3peZ+6pOveWl5ccy
 0OtnC+qVcT6DRejfHaH97AnQdWCJ2VHyjaT50QXjJJJdSIUiWAIjKktpo
X-Gm-Gg: AY/fxX5mNf6XmuJfAbxq7NZSP6AlzRU1R6yyPtJqrbWmtRQMI/yluLBsgs4ODnDT3gW
 a7ufGqi7bk1CL2OSxYqfQKszyHobE5k7ExiAsLGSUbTYrjzRpolKMR+snsZILJG1UOosOD3sRfS
 R4TIYUc+YPZsKB91cGp7ALHQY50g4kRh0QBlfbD12Cjwl2tkqv5XZkxlh28lkLdkZe2Pyr50mkN
 kwq7jeBRJvtRoYkN5xWkFvaii8AEekS78EEWwoyUToGdGJCktxYiB+im7rqwSZc7QgsN7nzw7Is
 JRnLC3hmJF4G78SLY6zlFJNFdzAutdG28v5HVk2DOGYo5D8rVcvu5d+YjctgfM2fxXttp+RnFoM
 zJQ6QU7X9L7lRdJiA56ihidX/11C5tNQJ4iSNdHeUxvIrEpmbDi8AXgTPSQ==
X-Received: by 2002:a05:600c:1994:b0:477:9814:6882 with SMTP id
 5b1f17b1804b1-4801e2fdd2cmr6661895e9.5.1768498348273; 
 Thu, 15 Jan 2026 09:32:28 -0800 (PST)
X-Received: by 2002:a05:600c:1994:b0:477:9814:6882 with SMTP id
 5b1f17b1804b1-4801e2fdd2cmr6661585e9.5.1768498347881; 
 Thu, 15 Jan 2026 09:32:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428bb0b5sm57423555e9.8.2026.01.15.09.32.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 09:32:27 -0800 (PST)
Message-ID: <212e3a9e-b8e9-4252-8197-617d057a3e02@redhat.com>
Date: Thu, 15 Jan 2026 18:32:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 4/7] hw/arm/smmuv3-common: Add NSCFG bit definition for CD
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <20251224034647.2596434-5-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251224034647.2596434-5-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 12/24/25 4:46 AM, Tao Tang wrote:
> Add NSCFG bit definition for CD structure. This allows proper
> configuration of non-secure access settings in CD.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/hw/arm/smmuv3-common.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
> index b6da2fd62c..7f7dd02221 100644
> --- a/include/hw/arm/smmuv3-common.h
> +++ b/include/hw/arm/smmuv3-common.h
> @@ -123,11 +123,13 @@ REG32(CD_1, 4)
>      FIELD(CD_1, A, 14, 1)
>      FIELD(CD_1, ASID, 16, 16)
>  REG32(CD_2, 8)
> +    FIELD(CD_2, NSCFG0, 0, 1)
>      FIELD(CD_2, HAD0, 1, 1)
>      FIELD(CD_2, TTB0_LO, 4, 28)
>  REG32(CD_3, 12)
>      FIELD(CD_3, TTB0_HI, 0, 19)
>  REG32(CD_4, 16)
> +    FIELD(CD_4, NSCFG1, 0, 1)
>      FIELD(CD_4, HAD1, 1, 1)
>      FIELD(CD_4, TTB1_LO, 4, 28)
>  REG32(CD_5, 20)
> @@ -155,6 +157,9 @@ REG32(CD_5, 20)
>  #define CD_R(x)          FIELD_EX32((x)->word[1], CD_1, R)
>  #define CD_A(x)          FIELD_EX32((x)->word[1], CD_1, A)
>  #define CD_ASID(x)       FIELD_EX32((x)->word[1], CD_1, ASID)
> +#define CD_NSCFG(x, sel) ((sel) ?                                         \
> +    FIELD_EX32((x)->word[4], CD_4, NSCFG1) :                              \
> +    FIELD_EX32((x)->word[2], CD_2, NSCFG0))
>  #define CD_HAD(x, sel)   ((sel) ?                                         \
>      FIELD_EX32((x)->word[4], CD_4, HAD1) :                                \
>      FIELD_EX32((x)->word[2], CD_2, HAD0))


