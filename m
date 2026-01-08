Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31700D1D494
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxPV-0000P4-WD; Thu, 08 Jan 2026 16:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxPU-0000Oc-PU
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:19:12 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxPT-0005e0-EP
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:19:12 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7f121c00dedso3109106b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767907150; x=1768511950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F2l/DkqAwbUp8/OZf3n1GijcU0xAf9wJT50i0NZ8F1Y=;
 b=vphgFOpFQwJxHZ5Y/zBkXfQK5kMOksMfcBEcXkhPZhES2vEPNK66mEBAX0FJgt4VmH
 6kSrHV5SkWfu5eZ3h3YcXVwItQuvdY40b6bQmB+1W3HggN6AcBnNaAruw7wGOYZ3LgcU
 IdStiw3ViDa+AI7Kjdz3IMfF5wbch+NtKQ/PvbDEE86wQuCY+aUOzDMZaNIlV5TLnEww
 l2NW/SM1/EZD/NgLpl4IvQFVx9jEtwpmXgWgb7xj3Q67g/CPvWZJRvjbJxEJnh/xRGvJ
 aXrdI7hr/kd4bB8x+G77Ga4FzK4/zeobh7C8HXcH7SyYfGOOWc34WxqyFx1I61MwTUwo
 EX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767907150; x=1768511950;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F2l/DkqAwbUp8/OZf3n1GijcU0xAf9wJT50i0NZ8F1Y=;
 b=UuNOiDiJCe4f56tUml1daeS81fJ6vMUHjeEwNDV18HCSXc+dUjpDH/ofWiVsFe5MiP
 GmdHaj8MnCad7+jW5BJpq11OH1RA0KagpU7H/vQqfz/wbGettM0U9s6/X3NKcVSDMQfo
 qOGfsWAmnmORZdv9Ps08KtU3QaFkwQuahWNZtJPYdti4fTvl+5e4cgMnlaceVg77WJNe
 D9bhM16IDybPMQKgD6Z0e7LUiwwE0ITatDs4AhJLzglSmFiWUQ+X3rtB0mfh8VNq6cWf
 a5JTWdQURD9jUS27U2Kopw5KuXKgiZmCUqBuLf3G0ODECMJhjcUk58420XHMj1l1h7Wx
 j3gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn0fCnEhACY2/gf6cCgSQAafNgyUG86b+gfSIznvkjzH/aRnRCFAgAge8kkLUd2G9n6nPSyU0kq/Mo@nongnu.org
X-Gm-Message-State: AOJu0YzjF43wmHP4d6bNxm0SfCYY42kF99qQqdkI53sl6lQGi53/D7Ci
 jlZYtg40YCsZwjgACVPeQHB1muOKVR34xjoAfetSeQHA9Ldnao2FBqZPjUSCVKzGIys=
X-Gm-Gg: AY/fxX48LJ1iZownoAsHfNkeEH1KgKHw0j8/rbMv9UE6l19RL9sAz1YuDny7O2xovV3
 +p6D/E4cd7KBGVDFgkf3tggpmiL03JFeit21OLrc0suNvB6115/nDl8a00xKHetdlGEyBPh+dzf
 Kv+rV5cM19UPj5WTfqN2XfoItGyX4uFBtFtoA8aHOtm/dPOoBCLW+4pFwW/n86dFH5Rj+IudWsi
 Y1FEwK15RLxPPr1vqheiDl5SNzvpboOIj7QVSHI1yuPIHvrupXZ0VDuiUjeL3I5HhT0L0gdpgyH
 Lzjy7e87+7ullwtzfT1kQeIkLbjyFtbxx2VOeSm3WC/rmphw/CxlQzyj7XaLen0kdOxnKJIagMB
 KsO/VzmYFcUUV7ht4ewiXeHwsAI+moaGH1ZGc0ewT1i1FGmYtake/R3bZ5bEgOCqL0ZM+Ax9mi6
 fmIYoup0lwoD/FDVcPcGk749QHVfIUOzTyWMn38qDCB5ahT/C+5egX7Pyk
X-Google-Smtp-Source: AGHT+IHFbGG0z8BJmjctbC0Z6lFNxA0VOoT6i/hArqozZ8io0BHwBrG8tkV/+LAVCnk2/Zoj/KXI/w==
X-Received: by 2002:a05:6a21:3381:b0:35e:b995:7098 with SMTP id
 adf61e73a8af0-3898f8d0267mr6594335637.9.1767907149916; 
 Thu, 08 Jan 2026 13:19:09 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cca06b16fsm9085760a12.31.2026.01.08.13.19.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:19:09 -0800 (PST)
Message-ID: <b6a21771-b676-4daa-a674-fb4282ce11b5@linaro.org>
Date: Thu, 8 Jan 2026 13:19:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 49/50] meson: Remove CONFIG_ATOMIC64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-50-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-50-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 1/7/26 9:30 PM, Richard Henderson wrote:
> This config is no longer used.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   meson.build | 16 ----------------
>   1 file changed, 16 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

