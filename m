Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4972DC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 21:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdzJg-0002NR-6Y; Tue, 13 Aug 2024 17:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdzJf-0002MN-85
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 17:44:31 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdzJd-000144-9f
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 17:44:30 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-260f1664fdfso3421239fac.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 14:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723585467; x=1724190267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fG12zZMPmWxfuy8J4cWFnf+n0JVkewxIf09wcjDTPBk=;
 b=WdyWUxSqxLuPVWv56N8ng/V8JpECcDdG7tfFXQx77AoBkKo8D8jO4Qbosf4z3hRLvx
 nesSHa6ngxQBtCNi0/SLLDU7/7e/lxkVcZYOHU3eHum7BBzBaSJ7NujLtIWGcApLdMXh
 rXno5Ru1AiVExcPXkIpINtr3Ow96kOCD9/Ci9AAvkCBx8wZo9smC3rDQzpAz2lrxqgHm
 ONgviUNYq+c2lEvxE9pCRUVzaXJnE2HA3bAISZVNs0W10wLl6j0CALm3uziJulikc/HC
 ZZcSA3oazKmjma64QACIVdZGOy+VPwX1nm7sXqUNEQHTfYidkjmpYMqeqbaQvGG/aEL5
 rMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723585467; x=1724190267;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fG12zZMPmWxfuy8J4cWFnf+n0JVkewxIf09wcjDTPBk=;
 b=tbdWKIsYNn0l2iep0LBdRAv1Bxud8uuUs7Gdq9QaeN0oRCgS6f17DB7iIeuNevLHkg
 e98s8FE+vUdWYUtkyX9j/CJSs48tyh1+mffl7LYTnjzsCRelmrAKsJ9Hj+Kpg6lpu7sB
 4xBbAo3T9vWtJcLd2EFoVQmNC+LtJLjtbG/yH7o35QjQPQqpvtoP1lLu3go1F15shdhf
 uFnsPwT+NAC5JVLgRQ3HpAzn6pfZnkVChMZexS6PX5k1PIxHnsrffkz+jidWoC2WHNxI
 jsHaxegbOKLN85gQSq0CKNg/vgehr0tw53e+OpSMHTnQOlcH5zAqC5KDqJm1ysTyjrcy
 4XYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBBXQNfl3JobcyG8p7auBxRHZJRN2FkuYvEn2k3MRMFVjh+TKUbU0gg2kALUaFiBumrkEsHOYUEgYvBXX3rraPiL1KXX0=
X-Gm-Message-State: AOJu0YyoOv0ddFFaHwSiNu3e/jZUAa9WUa/pxfCJ5qYlBVJHiZ59aswE
 huh1cXGRGOUa3jpn+Fzb199GNhyPy8gfg7Ilv/YSUlbVFa1cJHrRQ0d+XoS4XNs=
X-Google-Smtp-Source: AGHT+IE/TxQHekrAuvVjqh108gDIDJ2PqYY6Oe4P1uY9mNYAKedmZGB3hUZDQ5Ik5N2XY5G/w5RUjw==
X-Received: by 2002:a05:6870:f681:b0:260:df8a:52bf with SMTP id
 586e51a60fabf-26fe59d7e1emr1274686fac.2.1723585467119; 
 Tue, 13 Aug 2024 14:44:27 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c69790a278sm1722939a12.0.2024.08.13.14.44.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 14:44:26 -0700 (PDT)
Message-ID: <2580a087-809e-478a-b1e8-3aae9bf1c488@linaro.org>
Date: Wed, 14 Aug 2024 07:44:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v3 1/2] target/mips: Pass page table entry size as
 MemOp to get_pte()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Waldemar Brodkorb
 <wbx@uclibc-ng.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240813135313.96519-1-philmd@linaro.org>
 <20240813135313.96519-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813135313.96519-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

On 8/13/24 23:53, Philippe Mathieu-Daudé wrote:
> @@ -607,11 +607,11 @@ static bool get_pte(CPUMIPSState *env, uint64_t vaddr, int entry_size,
>   }
>   
>   static uint64_t get_tlb_entry_layout(CPUMIPSState *env, uint64_t entry,
> -        int entry_size, int ptei)
> +                                     MemOp op, int ptei)
>   {
>       uint64_t result = entry;
>       uint64_t rixi;
> -    if (ptei > entry_size) {
> +    if (ptei > memop_size(op)) {

entry_size had been 32/64, now you're comparing against 4/8.


Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

