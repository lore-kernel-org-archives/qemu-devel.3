Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D54606A32C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=v+awj7zA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTONY-000458-AI; Tue, 17 Nov 2026 13:58:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTONW-000440-84
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:58:02 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTONU-0004sW-CW
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:58:01 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2e987a2ba0cso716555ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794941879; x=1795546679; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fNp/TgWNF+Y893iY26CLSz02Mzcjnw4y+DfS4adgyj4=;
 b=v+awj7zAQroGqYfxiSA+zbJujApdBRrWN4iYO5YObquScPKCR6erVB2mIMPKoKh/5i
 KBJBfG2ji5FwhOa3gXNkTPRV3F/NmYbyxVmsc8tPTdHpQS8rkQTYr5qyfSquv+k0Wmdc
 SbheqtUSsNTA5TYLwb8lhRQKN3v6Sx9nUNxjGJf1KBHL7+d45xmxOSoeUnIUjqV6Bt13
 WR/LC6NP4Kbw+ykGbtgWVBTtYoWXYWCJL4pTL/+vDwReHRTxEFY32r8AtkZvZ2qwsRap
 +C7oKUi+6q0ur4hrfOLSTaGxWAgXaWJDEmgLv2RSeceZ9Clis1rX0pS1XU3VXt7La5DW
 qITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794941879; x=1795546679;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fNp/TgWNF+Y893iY26CLSz02Mzcjnw4y+DfS4adgyj4=;
 b=RlGB0D6ScZqMl8wBMoLp0zRqJuJQbivX/ylOKWQVDpoQyWO6boatnorHAVwN6t33xm
 nl6Xd5TnVRhto36ohrbkLAjy7hBph2/RJBLn6L9joTAI/rqPRwfjfhHmQx/5PthNlnO1
 aIR2HHgWZiew4jXFn6AWICHkO3p6aQRCtZe2+ujR2nfeXebTZEcc3YvACWeEYzTAWoSM
 Tgg68xKIYHj1IcAhlmlvejVxAF1AiO34yEppZeqfCezdHhj8OoIk7ckBJWZn1gfC6wHo
 thNDnoVvh1Ddeg4auPW1K+rVk0aTxtB/WN/y2D7ZIBg+P/Q30oqy0S5KtXl3ND0xptfM
 crKw==
X-Forwarded-Encrypted: i=1;
 AL+hErGFxYKykcpcZd54bTgJWGLgles6vaWEPss8H2WbFzTe53JlTdpUUW99aQCVmjgz7adEj7mz2VtjqrGK@nongnu.org
X-Gm-Message-State: APuU4Z97H6SasbzYvFKVmny/6xFs0uE+EAry+6iyxK96yw+swb85i/9b
 RkvwDPH/X/UCGj573TNIxwJRr99N/RAPC95qxwpZsJxXuU+xQopxYG5dMYqf9X0P5Vk=
X-Gm-Gg: AZFdTZcQabXM9q2JadjXY7uBojpwRVav8cVi2+hLO3B7Pji17QPWIsQNx1rJxAYbG7G
 AwHXQCs02qlkQ/72Y26P5Sehf/dtbyjRu80CNNsNMOpdCcvxme1FOX9s9V7lr80nFnikQaTAmOr
 85MvTiZqjhwQlDOhGR3gXhjBLTjTbQ4km/dOSA3IFD8xvzcjig7LVNoG1iHagCFyPhwHrarPo4M
 KNbYVNARIn/UjiOfL0cdb1NfbirJIiKj9QGm/ALDT1wu3KO/THeZMYMwX1SepLnTVL8ScCQDaMq
 t9ZgFZ0OGHUKPetcOil4+foY1FvEQpiVRhtWeYWiruyX3moVNH5Do+tEUtG7RMO7g+yImjJr80N
 e4ErWg8fOBaxeNZXth8jTnJD0HnP7N7wweYy/Ma45Uz2bEFmeantWdpbrc2MYVSVu856dB9eQND
 7iJrKMSiS3B0LngOdMmZ25HfVm+372781DUZ/PP6LMqBetG7obwT74P3AKUYFWXNrXe0SKZmLPi
 Xo32unEk6n2TfMlbG8NUzNKSMd9BC5CSiL80aujLeE5Zz8IV0wKLoZo54/87lxARejBhFd5HfOt
 DkU7cNn0VVq6EUvRO8hI2YbXFCjXJDCwYidNMSFF6KThQ2Swf8vGMAt6w28syP6xGc+U7/8pVhz
 kv/wmBcEwVem0Il8w
X-Received: by 2002:a17:902:d08b:b0:2ed:697:884b with SMTP id
 d9443c01a7336-2eff72e607emr1388965ad.12.1794941878745; 
 Tue, 17 Nov 2026 10:57:58 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eff62842b6sm1545185ad.60.2026.11.17.10.57.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 10:57:58 -0800 (PST)
Message-ID: <d6be6a5b-975d-4358-881c-6c4d3895c96f@linaro.org>
Date: Tue, 17 Nov 2026 10:57:56 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] target/mips: Require rt == 0 when decoding
 BLEZL/BGTZL
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-3-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
> The BLEZL and BGTZL encodings fix rt to 00000. The legacy
> decoder ignored rt on non-R6 CPUs, executing reserved encodings
> as BLEZL/BGTZL instead of raising Reserved Instruction. On R6
> these opcodes are the compact branches, which already reject
> rt == 0.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/translate.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

