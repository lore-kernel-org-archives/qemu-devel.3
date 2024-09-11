Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DACAEE0204
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE76-0001Jv-9N; Tue, 10 Sep 2024 23:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE73-0001Cy-V2
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:33:50 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE72-0001U5-Dv
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:33:49 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-718e2855479so2937140b3a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025627; x=1726630427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=plMlL2j34dtlZACNB1ICmczvQhVWSouMWarMxv0jQg8=;
 b=V0pmIBDAZbV44IXgAT4ugLE9qIuxvPO2pVzl7h+RvnHFAnCgBsFjlU4DEJwH1HtlrY
 rTz10iCxhmpCm42h1T9LnD4vCQrK/en8ZiP/Izm7JiZcLK+1l70k2/Oils3A+HEWvBRa
 voOWQ4C5krNCHM/T8Qkpi90nXiwUCWSyITjM7b2sd5U95o9iRfLmHeVHqCEyneBx5wKv
 q0e1Vpa1ibWF1fldC6wydTrdiYSoXwG//f002Qld6lA+FgglS77fTj9mepZnHtE6i9lw
 SNyBk/ZckUWU+DKQ0LuRZaGilYvd8IjeKqO/OQFALS/qZHAqZ9Bw90hLTdwV4e7/Bylo
 Flgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025627; x=1726630427;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=plMlL2j34dtlZACNB1ICmczvQhVWSouMWarMxv0jQg8=;
 b=O6oeenfvJIEjN9VjLXt7WXIC34gmPdHXI7iDa9ZwbrT5nRxKrSrOX4jusu8QBUcnH8
 NzhC/Jvfl/WZgAk18aOXql2Q4NCycDrom4hL0MneUu794AnHQWd07KNi8YcawuVB23Ox
 Hyk1lXOf129QTotolxcNHFU0uJjQFUCTv82dFLo2Cs6zkMUze2lYihQs792Yh0ElLjPY
 Wb9O5iosYyCz7LBR9OQS9BxSnyij+eoW6nxUU4Npeai/9xiivTjXspltfR6y2M6TTN5Y
 SHaf990+UP2pYjFT/H9VbSlIJVc1GCMi48aW5y5k3ATUXLEGawx+dQ/cqfpsFrtWV0Df
 C/lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlXqi7nhOOY6w3XfRLkvghPoKMY7dQ5+/OkvR/FY3pZhW7jzK72AQiT6Np8dmXZaQ+vmxIskiz11su@nongnu.org
X-Gm-Message-State: AOJu0YzXrGNLWBbv8q5TsAfxuAWY9OYIbQouVipmZepHSOQnouepC3gr
 NMtmOi89UYFfymD7hz67alkg/qfE4MQlej2bJSeyNAnTkEVYV8IcXee44j2gND0AGXrjXyCWriB
 g
X-Google-Smtp-Source: AGHT+IH000Bo9zainZa9DibTmyQxhShy+hh6P/muqkJsX5TgeY5Ai/KrLfMUql/bcsyf5PhR1C9Fmg==
X-Received: by 2002:a05:6a20:d80c:b0:1cf:3996:744e with SMTP id
 adf61e73a8af0-1cf5e1571b0mr3609566637.39.1726025626671; 
 Tue, 10 Sep 2024 20:33:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090adecesm2060055b3a.155.2024.09.10.20.33.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:33:46 -0700 (PDT)
Message-ID: <12e8a6a6-28b4-4e45-9d60-6ae42b8d8900@linaro.org>
Date: Tue, 10 Sep 2024 20:33:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/39] target/arm: remove break after
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-34-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-34-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 9/10/24 15:16, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/hyp_gdbstub.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
> index f120d55caab..1e861263b3d 100644
> --- a/target/arm/hyp_gdbstub.c
> +++ b/target/arm/hyp_gdbstub.c
> @@ -158,7 +158,6 @@ int insert_hw_watchpoint(target_ulong addr, target_ulong len, int type)
>           break;
>       default:
>           g_assert_not_reached();
> -        break;
>       }
>       if (len <= 8) {
>           /* we align the address and set the bits in BAS */

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

