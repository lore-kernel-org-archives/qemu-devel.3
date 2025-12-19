Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554B4E66882
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfVS-0001da-OG; Fri, 19 Dec 2025 13:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfVP-0001dR-SP
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:47:12 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfVO-000274-B2
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:47:11 -0500
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-430f2ee2f00so1044760f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 10:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766170028; x=1766774828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lXulevsygpLhCzDahjrFfVsUs7povEXPCGNktbRANr8=;
 b=SnQ2JfmxyZEJ7yhnty6axAOHjr8dZ5TR46j5DAzzJnGTqpneG9zv0eYsvBlA0ymToI
 ENd87rmz2CGrlbJ65n1luh3dGJrFdaNp5TfCg2YzyFoims+W5OpJPh6xBbp8CfcoS8e9
 fVUrlODJmohovu2TuUuaqWR67Nq+IFxOljxL2i2HfCop74jrSfmh0Lo3dMLW9W76232L
 Z8Qu+9Qe74N5pEAcBjBKMU/H3tGDe51+6rG6a/1Nf+TzJJVGoGk6j8zLV17g0Fhi64on
 G1M2HBw5Fnyhpru/cfA4OyLENpQEyluWvfHde6E2IlixTNWUsDFuoWDP5LithykMS3At
 tg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766170028; x=1766774828;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lXulevsygpLhCzDahjrFfVsUs7povEXPCGNktbRANr8=;
 b=HHi5AoDIKLszi7LUA50vSpqpZ0nM9c/HBsELevvOJUlEpZjYmqx1kS5g/EQa4+iElR
 M0hE4GQjIHu5dkR6McoG6yV+ju/DsRV//dwfP4MedYPOqze2lLWUZsPNjKWkV726AhFd
 KkU5hUmJMJd4gpHJ8zLLgqP9IQVLVdO+ReBrjvx8lyKCqcb2QYcaNKGT2/YiztYsvYoN
 9dx9+ajnOFuLUWiE5L3EdD+75NREO3esQtRjNfk4njWbfNdQHevE0A+6OkkoOwLq0c9U
 arIvb4+wwtP8y+saJ4QWQC+V090MhLunIiz3a6LXe/18CkP2jxlOdIYd6TIaFz8qMCZd
 CKMg==
X-Gm-Message-State: AOJu0Yx9MBF6CndNGXhermmoB0TJdVI8Cpqfccb5GwT/+I0PbX4FjVzJ
 fqi7sYmeuR/xUwR3Fr3gs49VC2iz3gr1bzufX1bUUGyrHDNOaQNzzTw0M99c9j3rv+bZQQyMqNJ
 uuADabEU=
X-Gm-Gg: AY/fxX5w27RfFwpZmyufuyPRgJULTY6cpCXDZk2qqLUli9wOIEjd28xOgNXS9YAPrTn
 Skqr7jy4Zd94z729AcLYJeLtl8xZV3VIm55jw+06t/i9uBcLNw+CfRKQ8+2ovOY9xrBcNHHf/Up
 T8v2m8S6Gslmqv3+UQMO/OXaBaalOBNqpu6uMtILUuedDJhL50rvnyPGmZuw/kzdh74AKc4K4Lz
 AOrXQafVafCSNqsy/MYP92x6aogjsvkLlCHqAhkp+w4klPj6IH46oqb76m8slQQOKKAiYbqsQ5f
 KwR0MCdvwTtNhIpITZSGdia+K0VF7Vn4V1fmqFxANftpOI3l7/o9FEaH3RhyGUJE8KNPtxN+5KG
 cJUZRbSBVuD8IFoj6ozqI0/BlmPFKhDzWJ0g9iT83rO938p9c0OfRWcWgVh9/VFQJuux7I8jZPc
 rHmg3YUj7ysl8Prteu/+LvI+9KTh3TWafN0d1icBizTwk66tMsM/Vl35VWTvwFcRiV
X-Google-Smtp-Source: AGHT+IEpBD4KW81P2tD4G4PfEu2ThV2o1qupHEmtIZVRl7+q7+QnGxCVivt2KcKrDPKukPm8k8I0LQ==
X-Received: by 2002:a05:6000:22c9:b0:430:f742:fbb4 with SMTP id
 ffacd0b85a97d-4324e50daf5mr4647159f8f.43.1766170027742; 
 Fri, 19 Dec 2025 10:47:07 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea2278dsm6517036f8f.18.2025.12.19.10.47.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 10:47:07 -0800 (PST)
Message-ID: <68dd5e12-c7aa-45df-9655-af7ca1c22c2f@linaro.org>
Date: Fri, 19 Dec 2025 19:47:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/hexagon: Use little-endian variant of
 cpu_ld/st_data*()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain <brian.cain@oss.qualcomm.com>
References: <20251219184345.96786-1-philmd@linaro.org>
 <20251219184345.96786-3-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251219184345.96786-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x443.google.com
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

On 19/12/25 19:43, Philippe Mathieu-Daudé wrote:
> We only build the Hexagon target using little endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the little
> endian declarations. Use the explicit little-endian variants.
> 
> Mechanical change running:
> 
>    $ tgt=hexagon; \
>      end=be; \
>      for op in data mmuidx_ra; do \
>        for ac in uw sw l q; do \
>          sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>        for ac in w l q; do \
>          sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hexagon/op_helper.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

I did something wrong while rebasing... Part of the original
patch is missing:
https://lore.kernel.org/qemu-devel/20251126202200.23100-2-philmd@linaro.org/

I'll repost.

