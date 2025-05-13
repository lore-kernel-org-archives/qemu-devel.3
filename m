Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524B4C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqju-0003Ge-EA; Tue, 13 May 2025 10:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEqjr-0003G5-JF
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:36:12 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEqjn-0008UH-RT
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:36:11 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22fb33898bbso70623785ad.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747146965; x=1747751765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UkHClKw2p4tVXZ8FBXxTzKaa+162QbJ7dG0yrCSWS8I=;
 b=jrMq5//3uoYzh2dgHmcM1sRaUw63+PMcfRTZ8T6AvjYqIAkqgk2JKRY1uOfLpkWhrb
 cex5SphOkMVLAb8gPeklRA/jtLD3laG+mYpcvZ2vq+WDFtXJSOkwoMm8+FksQYR+V88B
 ttYS1r3kA0NbKvhHFqNb1CCIcg1pF7e8tUKxI4YTXSehtnZSyNEBi1H8as0yPGpfvz5N
 gSicjPH5mpuwZ9xwW2YXj+HEJZz7pYREttyyQprnDlu5+NpZLwgYHrp0cGYcbp0ScS6b
 acur76SX0FyFnizueLrbhMxuIdk41XkdtHK3JQw4v7lyXJYNjoDULe9kkMdO67NxIBWV
 OSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747146965; x=1747751765;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UkHClKw2p4tVXZ8FBXxTzKaa+162QbJ7dG0yrCSWS8I=;
 b=FYGSyqqJHAYeL9dk7o2xswfbPT2ma7nYnoAdwFLxWFdHNSM9T0hR8XrbsEVxyD/+q1
 htyKSjh+MBl/aGtD02XkQDooU9qVCA0FGPKt741ual+qB6H3L5q8+u+cDVsjl85ADlfk
 pyt+QAsyd4k0D7yB32vUr2OcU6KI9Da8O1Bdwsy6uKByqArDGl7htzS4oAaoKv49nqBE
 7KbVtWGeeSXqNSMGfYVd6+Bared0DygnWxwcW7t4lj0S+CFVPihcHwVvCqGWXL1UE2bC
 CWMESzgSB4tTBdZuPPNq20Q/Z71NAcpfaWcpMfXoC2UBLL0xb3tnFt2906xDJIsM+CtS
 FQ+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzecZs3W3+N1y+1m3dA4ghtziSXJW7+pvMCyedzj2sVPK7Or24mQaNPOpBiUFyMMwCMcHqEXoxdOAk@nongnu.org
X-Gm-Message-State: AOJu0Yy+0+aPW1TgLN2cuTSLjtk5+dgA/y+ajXlBCI+masxNfm346Q3a
 LLdktYRnCtqo+r3wrqADiLxy7wt1r7+Rn05i747zTabJ4ugeMdAVQEWicQdy3ZM=
X-Gm-Gg: ASbGnctKXEEooXxGmUAXy/XZM5uzv+VXLFtyFxIVRPDE2UiMcr1fr4aablMl9s0T2Z/
 tRD5X9P1fumc8gLWBtuoG/fSxbrfroHFRl/HewpqeyB2ZXcCm/0Xlu4RvbyBa2/phKdZ9qCyxXg
 MuQdfPBxh3u6Z51dxdAVbtwWKYlLDoWiZSxYqvIkm74UOvSYqpnjTH/dReSNPHatMThyXsCEOMo
 Qj1Y/4yUKc4rqjVxV5ftyMlIYeyQiIjYlDPpfRB7ENWl0SXIdde8lg4YIcXJo6r9i7t6EF9/JDo
 h08C5y//iVBH2COes7usQnvhGZkMpk/IAY54Njq2Y9+HW0PWAZtOnFFoOy1qk7dC
X-Google-Smtp-Source: AGHT+IHpDBpQw7oTxKesy58GKYFLHbQP11NvPVqr6A+6kMbuymY0sTmZvNn+5VRP4qc38YVm3h287g==
X-Received: by 2002:a17:902:e0c4:b0:231:7f29:bda0 with SMTP id
 d9443c01a7336-2317f29c031mr30036095ad.52.1747146964987; 
 Tue, 13 May 2025 07:36:04 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc77421b2sm82745255ad.70.2025.05.13.07.36.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 07:36:04 -0700 (PDT)
Message-ID: <61564c23-833c-4ea9-9d93-af6c5be95eb9@linaro.org>
Date: Tue, 13 May 2025 07:36:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/10] qapi: remove all TARGET_* conditionals from the
 schema
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250508135816.673087-1-berrange@redhat.com>
 <87y0v4zuec.fsf@pond.sub.org> <aCJAaawKsNFAtSmy@redhat.com>
 <26fb50ca-36fd-4aca-908c-272c5a109bac@linaro.org>
 <87v7q5gcuz.fsf@pond.sub.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87v7q5gcuz.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 5/13/25 12:59 AM, Markus Armbruster wrote:
>> Just for information, I'll apply a Signed-off-by with my name to all
>> patches posted (including the ones I won't touch) simply because I use
>> git rebase --signoff by default, and don't want to have to do this
>> manually and selectively, as I work with a single master, with stacked
>> branches and update-refs.
> 
> We actually expect you to add your S-o-B to patches that go through your
> tree whether you changed them or not.
>

Oh ok, it's good then!
I was thinking it was deserved to "I'm the author of this patch".

Thanks,
Pierrick

