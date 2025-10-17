Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D0ECCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9m0P-0003WV-9x; Fri, 17 Oct 2025 11:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9m0M-0003Vo-6t
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:04:31 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9m0I-00053a-Qj
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:04:29 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-290c2b6a6c2so16048755ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 08:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760713460; x=1761318260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FB4uPsKUvfxDI/xHGrQPwnqmY0GAdDoQ0lmWWFawRng=;
 b=uW+6+sU+QF+fcYn9Hl3P82O3E0Ljb2aZYyqXo+uuNYJMryLTxotEELNngawcq99jEt
 n43SScz1/CXjKHvAozrCZroSiAm9lAaYW2LzWuPSw3H39XY9tK4OO1U4So0y55q1kGfe
 VDHGqpPbfpiav5ZSp4CzOR/On5PlFkAZpOMMzXN0vYdYF7voXFeAxaPtjKj25vLlyQl3
 X39VSTvd8lsyCVYS13fYQkGJ5FlkWKsRbZocT10O3VE9UNCcFp08UYMrfsfjpeZwz7XB
 nWTPsV7cTtRhBkkm87/jBoyA2Um786YjoADoYQYSJ48uhZKb/uv8rSX+bPF45NC4RNX+
 61bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760713460; x=1761318260;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FB4uPsKUvfxDI/xHGrQPwnqmY0GAdDoQ0lmWWFawRng=;
 b=etwSWbtNWZ+7hdlQi7tNpwep3ADadXPwTTPlvIwzbYkYLTEqlzodkZa6ekBV8FoLdK
 HE9UuuPwi1Gw+CIiKeebzXoKjWvKM52aM6n1IxPLMOFrQMUJas3cf5zEMMjh5AO6X+QQ
 UGXq9qdbOFxrwd7fjQRyi3D05Yk/lMlcETAftUIDTMJ0Uv9SGNipYlrcqquXBIxl2veE
 oFQ40I+uLM0dFSvFgjsLYVg69gWpZKJEDr9M4hcghvZDSifGU8sl57aeuoE3FaYq2FAB
 s0WfTPwQuri3UyHU2hzRsWEl/VgeYn3kH9/KsL1wRy2M4LNPlGeIYRuB39lPHE8eg3gt
 2Lvg==
X-Gm-Message-State: AOJu0Yz5P4hPS2tehCSYS8iNcbu2EsKCu3rDrt6ytTBOoXkLGUiOgjha
 6QU9lLyMDpdDfP6RBDslM9NrCzuK0+MSRl7RYSvPbl60HG8sCgvMHSFa+8UxVvbpKtw=
X-Gm-Gg: ASbGncvajk2/ctlnLY9b5jM/yL3Wj6lShNabl0T/cuITsKjLcDwdc1MIRexDPCIwtJF
 lUCv/98xB3Tty8eWkwbXo32w+1Qg6AGGgHyxzwa2kffg75x/NbeaJEbhTMRbIvmKFUHhHRZSPsf
 12m5GoEx2pIpw2FQlxGU9Fjj0VyZ3QdIWfmdqGzwpRYRRUBOJ3NR31oZ53DgPGzQgH6sc8BROfL
 Vze1uvYDiGkFYjCjnGGh8tf2lk7aob4Kb9X+zlxw5J25A/g+vBNQvti1WC79RDieISwP72YUcyF
 pEN62yEUo8IWVYbSRAcBe8lvGu/z2mzz4rSuSt/gvJlzx4Rl0vJCmRJmyt9+n341rDEcc9D6LV8
 OsRr7BVFici3oEVTeQ6MNn0Ba0vbCztZcCQO7f0p8DWDcITWIUbNAnD3bqyjATcBIX99ZM0jDw+
 y3ZN/5eeNJmj/zvifK/IqxH67Y
X-Google-Smtp-Source: AGHT+IFjao3vTa7QUMBjxsOFLMWpniy1ifVimslSGVfrButv8o3exEm/TyT99Gn8oKYEAVO09pQ0UQ==
X-Received: by 2002:a17:903:8c6:b0:26d:353c:75cd with SMTP id
 d9443c01a7336-290c9cc30b8mr51220315ad.21.1760713460243; 
 Fri, 17 Oct 2025 08:04:20 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099b00fcfsm66847885ad.117.2025.10.17.08.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 08:04:19 -0700 (PDT)
Message-ID: <3fdbc69d-9f08-42f5-9c59-8332c1481e97@linaro.org>
Date: Fri, 17 Oct 2025 08:04:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/37] target/arm: Add read_raw_cp_reg128,
 write_raw_cp_reg128
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-8-richard.henderson@linaro.org>
 <CAFEAcA-OoeSq9iOrtf_23-x8tZBCyZJ2wQ2ckrYo6tY8e2w9FQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-OoeSq9iOrtf_23-x8tZBCyZJ2wQ2ckrYo6tY8e2w9FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 10/17/25 06:11, Peter Maydell wrote:
> On Tue, 14 Oct 2025 at 21:12, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Add the functions and update raw_accessors_invalid to match.
>> Add assertions for !ARM_CP_128BIT in read_raw_cp_reg and
>> write_raw_cp_reg.
>>
> 
>> +__attribute__((unused))
>> +static void write_raw_cp_reg128(CPUARMState *env, const ARMCPRegInfo *ri,
>> +                                Int128 v)
> 
> Why does this one take an Int128 rather than a lo/hi pair?

I still represent the migration stream as Int128.
See patches 12, 15, 16.

r~



