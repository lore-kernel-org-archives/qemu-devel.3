Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16DBCF256E
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 16:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szfFI-0000Qs-3C; Sat, 12 Oct 2024 12:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1szfFG-0000Qe-NS
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 12:45:34 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1szfFF-00048j-8H
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 12:45:34 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7d916b6a73aso1883905a12.1
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2024 09:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728751531; x=1729356331; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YdGm22jIsMNWJ95nUbuRPsBcSr0cR/4+DAhND22GdII=;
 b=ECWM3iQ3O0RDEuGwORRR1yfi4/t08phOdum/iZzFA9fxVoROgVYL1hGeL79cPZ+cyi
 CxETs32HWbD+zL5GdJUUzV+s6tbHfvx37rmJJazrZc2nTwDTQacvn5y1LE3FWq3yghR7
 pAgqahpavIPqZfsguh3X/PkhiOByLsBzzVTvM7NS0k4vxZPki2fmRXPz6zeCyJHlVtav
 T3EybdXYq6FkW/QcwAlIL2N4a1zArARr6/fv6t/cFAMAO2uKHN1TzDJ02AC/lb1amcae
 Og9oSeDq+Y4N9bHfdX5DnRlRXcOpHM7kshro33zgzChcmtu5/OBCDOM4BVANwCfjHvEe
 GOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728751531; x=1729356331;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YdGm22jIsMNWJ95nUbuRPsBcSr0cR/4+DAhND22GdII=;
 b=Lrnu/x8uy92ZpZ3wFIV7bhuG0cLw8JeQzUMYeLvcC8i+T3yszozn/DX4SXELvVJbse
 G9cvB6qpGyb9qTKMkrNUMOCiI+euqJLn100MkYzng1GRzav+H0KfvestASi7fiydLI7d
 Y0aN7CS+AXEtcD49rASLy5KiSw4os3P5qSiqUrW8hhOM1ZTaj0l9rB0+RUbyqbxvmn8U
 i4tYDs5ld7nbvA/6aKS4x8ee2kDshX1WPie+uqXLdoTLBji5fhTEtYZ115SmGqqoDqgW
 Hb5e2igfyUJisS1EQnH8SttclYQpawGpol8PG3E9uKgA6DD1mAUOYzZRIMTDAVZV4TQe
 OFjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqvl67YQfEr11/wCwu4cJ9pOMOrxgBPVH42cBlOdgPQRDvcwLuiK66vkLKr34lq5SlKVlshAUdT33p@nongnu.org
X-Gm-Message-State: AOJu0YxNGTRVTe3ewRDFWBH6ctyzvnGFVPu7mGLsYXAJ451sSp9io9kg
 WOCwvg71ZWb+uh+1/clRzcQaDmYq1/7GXiQsxhFsNllOmznJrdTzyoBkqXEHlWI=
X-Google-Smtp-Source: AGHT+IHETjtirJwykVq2JJ4HM7mBOEgd6Gm39u75Ikdenwzm32PAlC5YqL3a+3rmlT4xHzd10DczGw==
X-Received: by 2002:a17:90a:6886:b0:2e2:d16e:8769 with SMTP id
 98e67ed59e1d1-2e2f0aa8914mr7851128a91.15.1728751530636; 
 Sat, 12 Oct 2024 09:45:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5eeafe8sm5270680a91.13.2024.10.12.09.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 09:45:30 -0700 (PDT)
Message-ID: <099dcc82-aa36-42c3-892b-0f961d436adc@linaro.org>
Date: Sat, 12 Oct 2024 09:45:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] exec/tswap: Massage target_needs_bswap() definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20241010175246.15779-1-philmd@linaro.org>
 <20241010175246.15779-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241010175246.15779-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/10/24 10:52, Philippe Mathieu-Daudé wrote:
> Invert target_needs_bswap() comparison to match the
> COMPILING_PER_TARGET definition (2 lines upper).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-Id: <20241004162118.84570-2-philmd@linaro.org>
> ---
>   include/exec/tswap.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/include/exec/tswap.h b/include/exec/tswap.h
> index b7a41913475..ecd4faef015 100644
> --- a/include/exec/tswap.h
> +++ b/include/exec/tswap.h
> @@ -28,7 +28,7 @@ bool target_words_bigendian(void);
>   #ifdef COMPILING_PER_TARGET
>   #define target_needs_bswap()  (HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN)
>   #else
> -#define target_needs_bswap()  (target_words_bigendian() != HOST_BIG_ENDIAN)
> +#define target_needs_bswap()  (HOST_BIG_ENDIAN != target_words_bigendian())
>   #endif /* COMPILING_PER_TARGET */
>   
>   static inline uint16_t tswap16(uint16_t s)


