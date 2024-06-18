Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5C9C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 19:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJeJh-0002r5-0J; Tue, 18 Jun 2024 15:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJeJe-0002qT-L6
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 15:16:27 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJeJc-0006gX-MA
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 15:16:26 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f47f07acd3so51619485ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718738181; x=1719342981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q/KgP50HtbEUc7pjoILc2H+x3vYdxvTugX0tzZiiJZY=;
 b=EoV+HyaPdderkZlNIwjebfhJRhV5BUTtHCDlqlpB+bZfV/fzvRF3WIRw1KRLM1+H36
 3EBBjNtMjvKkhoZoR7wupS1Sa3+SYJQRjYhVJU7PCXSsZkXJC93Us4e9GudzKDUTui/r
 HCVnovI9kx1kVyxBf/zNK/70Ppdz64RnosMWEzAcYHs8iffnguM68Z91mHHPf+AHtEEY
 DiNgnsEcGdjUkFc6twPBuCHmCOEhc/G9woQVV34ZfI1BQMiSuRJ1x1x9DINXDePUZ+Ps
 5EjrogEJTXXYhRkXbcaJOOmaaAa+ueTwmMnsAIYBrdIqcpH/7cw94tEdW6JBQ5fUN9m1
 DJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718738181; x=1719342981;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/KgP50HtbEUc7pjoILc2H+x3vYdxvTugX0tzZiiJZY=;
 b=JDPi22e36vhqj7/BmY+EDci+oViYvqmXNlYrU89exp2tMJGRgwYRqGf/O5SMgCeK8v
 iOeydvGdmxIrdLGUpJnGSPNZHamG+3JtFFYj27bvBH1rmJi5plKmFz35qk7oZJUlXQvb
 6Yx7a/3Xm9ot5xXBZfQdnrRbzFU09JObNAJIMqFWgosNVVGaA3C25alfzwbuir44Ef0j
 JGEwKErHfK/VrsnDI8tvDxdTqHDODl8Lg3Gd/gW907/wL+oIz3puPBdk0Gd8k5ZtCIw0
 ecah12OnNffleALwuYgMKq0ZsJ8zGFGPxDeRoqOId5hSIF4/4G+In61uvSKp0IFh7Kfn
 D/vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYGEn8ZaES5issGYnQS3hcFoQF+uA3KYynF9q8ix3Kc6+XydNDKt+Bj9NeOl0ljle2R9CqQ+14DI4zSaOKElZYBz8dsnk=
X-Gm-Message-State: AOJu0Yz0kH18MzvBMgiiyzm7yZm95P5MWbacWSVzOI+46NRFfooufN6X
 Q3Uq1QeXE5iRB4Wa/t3aOFeAJKzhls/Fj1F6ySRaKW0fwP42p44H6ZAVtn+C+pK+HkIzSBi3k+x
 1
X-Google-Smtp-Source: AGHT+IGTphTY7Stb0fZFFfRKB8qJCNAlLJvGksGG7l10Qf4/+D15OLt1JZIq3XOQNvlOTbkPiphqxQ==
X-Received: by 2002:a17:903:11cc:b0:1f6:ea71:34ee with SMTP id
 d9443c01a7336-1f9aa3ce954mr6650715ad.16.1718738181363; 
 Tue, 18 Jun 2024 12:16:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e73c3csm100678215ad.102.2024.06.18.12.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 12:16:20 -0700 (PDT)
Message-ID: <d306d6e5-622f-4b3f-a385-51ab6bae5a03@linaro.org>
Date: Tue, 18 Jun 2024 12:16:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] tcg/loongarch64: Split out vdvjvk in tcg_out_vec_op
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: git@xen0n.name
References: <20240527211912.14060-1-richard.henderson@linaro.org>
 <20240527211912.14060-14-richard.henderson@linaro.org>
 <7494ab33-5dad-a11c-1614-a640213cc3f9@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7494ab33-5dad-a11c-1614-a640213cc3f9@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 6/17/24 19:28, gaosong wrote:
> 在 2024/5/28 上午5:19, Richard Henderson 写道:
>>       case INDEX_op_andc_vec:
>>           /*
>>            * vandn vd, vj, vk: vd = vk & ~vj
>>            * andc_vec vd, vj, vk: vd = vj & ~vk
>> -         * vk and vk are swapped
>> +         * vj and vk are swapped
>>            */
>> -        tcg_out_opc_vandn_v(s, a0, a2, a1);
>> -        break;
>> +        a1 = a2;
>> +        a2 = args[2];
> Should be args[1]?  Similar to op_not_vec 'a2 = a1'.

Good catch, thanks.  Fixed.

r~


