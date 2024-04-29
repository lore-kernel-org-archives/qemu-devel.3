Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884E6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 18:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1WAH-0000vN-2c; Mon, 29 Apr 2024 14:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1WAF-0000vD-KO
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 14:55:47 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1WAD-0001L0-VO
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 14:55:47 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2a564ca6f67so4289540a91.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 11:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714416944; x=1715021744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a8RtbTgZuvpd4sfdnfyEMD88ux9EoqeM+didkSgNM74=;
 b=Y2pG8x0P8I8okkHvkILkrb3sd24MeCwUSnL2VinZZ1wMOrCy3ONVnwxmiUjgzeB7mn
 3N7Q16fFkUU68aiy9eovVXgE8kvpJlfXHYHdkR4IBu7w2bgqxh7iWkbMYF87h3wJ0niz
 DpG9AMPw78mGXRw1cbrTYRJ+ukzzlAdeGL1RQACc8IGr2tWJkDUV8JCeFvCxabghSSQt
 JGQMu4rbP3FXfI7o5ohFNjQHAO3s2K//elEeUJzuZ0oqkQ8g7YhgswTEvsu1qic72uxK
 aQqV2GVrwiTNKPbMiZsnk7Yc2OXmCCBYM/FUwVj0yHGlqM5inxo4IXE6wx1MNIsrKRiv
 31EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714416944; x=1715021744;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a8RtbTgZuvpd4sfdnfyEMD88ux9EoqeM+didkSgNM74=;
 b=LBNw47Jt3kcwEbJsZZNq5C21MoTrXETlqth16sBNN9fhEmuTwLxX7aHmHF9lBq+xyL
 m5lQ8RWf3xvGYMbUFT4D8Q2saVVAVkpdTut5gKSu+hx6yusdPcWMM6P7Z8guImPI9ZP9
 SiR4cafZKVDA6hoKxOx4HDijlaeLYmv73MNA2vtGgirLJaRnuRcLTwOI6NiWI5C1pS4j
 EDJszBxYoHud9LRps2Xj0neonc+TRbTyXZENnGi9RER9QoTgKITyzMTgAk0T/ArVxG+T
 J/jwNi3dCtFlgVJQUAHHkgamkm0DCS0rrUn4PZs3aW2gOJuCZZ3dq+islMZdjfcmHCFp
 O8eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUA/rvZPw0TC3mQHQQsVts9U1ow0/tam8Qq0fqpK7b1Y5bDOAaD87TRIU+YDqqtpXU6O9SMOdu3hBAY83L9l/EfAe2rBo=
X-Gm-Message-State: AOJu0YzZs1GzgPnFZE84I1z+j/b0LgZoe6KcyPj4rkCyrQ6QZX+ALvwJ
 Ss1Au7llpkA98xgFm4wSUVo6e0j6G8pPXwu7E6RcATseQhHpopOZs3YksFx5oj9aa/T3mmQAfZG
 v
X-Google-Smtp-Source: AGHT+IFuApMSB5ZAhvvXVIZAQnrCHGsTe0xd54ljYcsqORhOiJ3UWzg3XLMG9fxbnAOq6I5KFDjZTw==
X-Received: by 2002:a17:90b:713:b0:2a2:acf3:4108 with SMTP id
 s19-20020a17090b071300b002a2acf34108mr581312pjz.0.1714416944350; 
 Mon, 29 Apr 2024 11:55:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 eu6-20020a17090af94600b002aeb05d6e97sm11282670pjb.21.2024.04.29.11.55.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 11:55:43 -0700 (PDT)
Message-ID: <84e4fd25-8149-44cc-b4d4-cb1b112ffebe@linaro.org>
Date: Mon, 29 Apr 2024 11:55:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/alpha: Split out gen_goto_tb
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240424234436.995410-1-richard.henderson@linaro.org>
 <20240424234436.995410-4-richard.henderson@linaro.org>
 <19885855-e0e9-4bb8-9155-a694ff9ea1df@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <19885855-e0e9-4bb8-9155-a694ff9ea1df@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 4/29/24 09:58, Philippe Mathieu-Daudé wrote:
> On 25/4/24 01:44, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/alpha/translate.c | 61 ++++++++++++++--------------------------
>>   1 file changed, 21 insertions(+), 40 deletions(-)
> 
> 
>>   static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
>>   {
> 
>>       /* Notice branch-to-next; used to initialize RA with the PC.  */
>>       if (disp == 0) {
>> -        return 0;
> 
> This is the single case in the code base of returning a non-DISAS_foo
> as DisasJumpType :)
> 
>> +        return DISAS_NEXT;

Yes.  Note that DISAS_NEXT == 0, so this worked accidentally.
But of course using the correct name is better.

r~




