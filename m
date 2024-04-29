Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FEDC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 12:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Q1W-0005M3-17; Mon, 29 Apr 2024 08:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Q1N-0005Jw-DK
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:22:14 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Q1B-0000q0-4g
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:22:11 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e36b7e7dd2so35390015ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 05:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714393319; x=1714998119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S8owiYBZJ9txiC/aDrnY9VxX0RMPocD/lMMvVdHKUuE=;
 b=m1jlFJ5tX6nhHrkNF9s0tf9T1QA/xhDRFq/K1/XQKUVItAkwhdedJwCwiprM9/9Ae7
 GJotXr+AM6ysvnVY31neZP95StWhifi/zhkMOnIT9P9iOpWSJuCnl41l+y1ipCxk1Y9b
 UGuJaRFS3dLUN4F9p3qSjJi7jgKhXh3aorsmN3bTsS4sSWShxU5oDR5xStSHcaaNw8PX
 UcxoDPCzgbK7Hf+f25HF6tMO2bDFifvw28FHDqLfbPAPLmrv9u0fZcT182kIZHeJoVk+
 tgy5L2ic0qtj8mBr5zAA8yJrFLUhg5u4xaCoUID8SNHKDyEZwgZVhcijOkA965v3Sw0e
 N6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714393319; x=1714998119;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S8owiYBZJ9txiC/aDrnY9VxX0RMPocD/lMMvVdHKUuE=;
 b=orcm5V/fq/L5noOHK3fWntXeuadscBP6o+hub3jefTK5F7ITLSYAxLlpsFboUNmnT6
 CjeD9koCvCoCVZYRBVIY/g6nBdbJ5L47lXEd5AoOFZBR6KUrnTxV+HBXO3oNug+ad8j8
 WEvbHNnfG17TkRrFQdTCtZdx3nM80MjS1eA6qho2ywV/ZjyEg7lxzO0weXqHMIcbLf+I
 Een4TEKxwZQTSUsifHaQIKM2OEYPzzaKZIT6Xhk25vyea9vlrtnHXsEh3Q3lXppPFBas
 nd5GjnWpYi+sGV7wt7CzPlPlQi8i3El8PmJ25vaur3kUvX7K0AT8F4sRiruJB4Ie6hzh
 b3hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa6RE+4bze78kWbJdU1cFeHz+0UHgSx8h7j2tymGF2msJjXMfAI41SekgC6x5Tylc9j/3z8kIctMsltytK0NnO0CGRrhw=
X-Gm-Message-State: AOJu0Yw8o0kV4DmxMI3I0N53Jwg7gYvV5bSm2hxnZsFCxrSIoBFDZx1K
 KQQT2BYcbSSsCzHh+Dj96BMl8Il9ih/4WIYxCW/z8AYJW2/fQmP0HNsaDU4LE3U=
X-Google-Smtp-Source: AGHT+IHJT8ISWgvOxF57LagBr1NSKfZ60ji86emWNHrV/nwZwi1Zky91sTLkYxFoxtCrHtN4dhp77w==
X-Received: by 2002:a17:902:d4c4:b0:1ea:95f3:b0a5 with SMTP id
 o4-20020a170902d4c400b001ea95f3b0a5mr8998573plg.0.1714393318866; 
 Mon, 29 Apr 2024 05:21:58 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 w3-20020a170902a70300b001e83a718d87sm20253971plq.19.2024.04.29.05.21.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 05:21:58 -0700 (PDT)
Message-ID: <2deb6299-eca1-4611-8977-73ee2d792b5a@linaro.org>
Date: Mon, 29 Apr 2024 05:21:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] hw/arm/sbsa-ref: Enable CPU cluster on ARM sbsa
 machine
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Xiong Yining <xiongyining1480@phytium.com.cn>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: rad@semihalf.com, peter.maydell@linaro.org, quic_llindhol@quicinc.com
References: <20240426073553.326946-1-xiongyining1480@phytium.com.cn>
 <20240426073553.326946-2-xiongyining1480@phytium.com.cn>
 <a25e01c0-5f6e-4568-93ec-970987eb6d07@linaro.org>
 <559cc23e-f581-4f0d-bf59-94a516d1ef56@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <559cc23e-f581-4f0d-bf59-94a516d1ef56@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 4/28/24 23:35, Marcin Juszkiewicz wrote:
> W dniu 26.04.2024 o 18:06, Richard Henderson pisze:
>>
>> Isn't this basically what MPIDR_EL1 is supposed to indicate?
>> We do not yet implement all of that in QEMU, but should.
> 
> QEMU has socket/cluster/core/thread model which could map to
> aff3/aff2/aff1/aff0 (or aff0/1/2/3) of MPIDR_EL1 register, right? But it does not.

Yes, I know, but there's patches on list that started to deal with MPIDR.SMT,

   https://lore.kernel.org/qemu-devel/20240419183135.12276-1-dorjoychy111@gmail.com/

and I suggested that we go whole hog and support all of the -smp options.


r~

