Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0881BC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 20:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn1VI-00080V-7x; Tue, 25 Feb 2025 15:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tn1V5-0007yw-UK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:25:56 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tn1V3-0000Ft-Ri
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:25:55 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38f1e8efe84so2325116f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 12:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740515151; x=1741119951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n9CYHYl75+VIRsckPlWCWbKZzGNesjaPb7o/u4SqZW8=;
 b=XdybHxxOsLaSyDs+XBwsqg1oPER2mz6ZD4JdXe+7RMVJz2h7xaFXbrafF9U+Ol5tZi
 seslK4NAMq0QqBOjPaOKUd82VjDYryu+QF9fcjwtknaZAAomOEtp2M+NaVd1d6wO0seO
 1J+C8NQuhDk3Uqi1Sb1ZL4Fef1/uw7NewHaRzz7R9VPwHkqjHASsx8nOA9bHn9AiKPjV
 YitFBDCbSoKqTM4f25SKN1T5hNJx4uP3HIPNPtDQMNshtBS21e5WK8pmhkWiHOMnyBLe
 /5ved1bt++hgORp4hgy1SNUitH12wE8+Voi9OJ525srUEAvpMdvPnowe0hu0iLQMbftX
 eKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740515151; x=1741119951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n9CYHYl75+VIRsckPlWCWbKZzGNesjaPb7o/u4SqZW8=;
 b=sDP3wDUdL/91RIA30e+0+mBuzLA0UACsa73LKKIvORxuiilbhjuuMocXU54PcOQA6u
 SrIdYmtyRSpN++8WEmoxZEpZLgBZKaiIP+ZDSjs8xj/nLXuoeAOgfyJto7Bl8P4DGb/e
 90N8LfwXxj3jSLRMGRYlReX365TCpoAGNowGQVsyk4VZMIqh2g0Ir0ZyauPagcpCrLJr
 bp9OFpcOTKf3JAeheOQ3+uH9l/dvwHdx4yjJbazE/fko9wjTaaxuJ6kgCGBdRQpAdt8/
 G/mddNZk7NqAh9vBmg6TSFgDnPGqJNtMMhrCpDbHxQej9bDa+6Ss09yonrSHsL3rKxI3
 mKmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYEddzq+k9KSsoHw3WpvnGb5UM7m69yJ5p1CWxuD8nhkfC9VIt7+Ol5zJMLjiWM0HlJBWd+BITb872@nongnu.org
X-Gm-Message-State: AOJu0YzLVroJYTLxvXmmzAablGOcdKEicAfgJEVih/Cf+XZcfvxKhzMy
 tV0FLOSIH1DP4YGtdz2NcPbW7nKNxmciovkBQoe/f96RoiYq7NvbSEEmxr7vSFU=
X-Gm-Gg: ASbGncs3H5Hv3uQr2ybY/gDoMc/F7+jt2OyVG8w+A2NJLAYuiC1Ocbfgm2+IbuWc3le
 D6aRJpGl5lN2S4vaI0qo9P/kYNdglH3CVoutyDUE1EDEw0muSFKr819x5h/jD3jy8B2DzCSJW7B
 DPVv5qQShsW8T9BGrVCrmdSzm9NQFY9lFBPWLsfComHWLcTqlK0xYRCI6SbL8YVridn1sARTnX4
 jTpiEhslWcH+zKGj8lhdHPvouor/euOqRpQ+cfgI6VVFpJ1zdet6GVtNUWNOEzvtHoo0dHyz9mG
 qG9c4KMcxu7DyAYgSjs4rN/LUz/5HJXY3E0t+0/pa+RPEXuE4p+hxWW3N5qtCPFU11V8Bg==
X-Google-Smtp-Source: AGHT+IFdIWvrQvfjr+eai0HDRqLXp280JkRKfi4SxdzUdKuUiI0eczbu5QSLAyDA9dtPhDMCrpGvNA==
X-Received: by 2002:a5d:6d0a:0:b0:38d:dd70:d70d with SMTP id
 ffacd0b85a97d-38f6e947399mr17529413f8f.18.1740515151492; 
 Tue, 25 Feb 2025 12:25:51 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd86ce49sm3437850f8f.36.2025.02.25.12.25.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 12:25:50 -0800 (PST)
Message-ID: <e47d7746-435f-4950-ae3b-ad816782f8d7@linaro.org>
Date: Tue, 25 Feb 2025 21:25:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 004/162] tcg: Convert add to TCGOutOpBinary
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-5-richard.henderson@linaro.org>
 <21f85e1d-938e-40e8-b33d-95f8cb4a13a7@linaro.org>
 <61cbdd92-e5c1-443b-87f7-dba148b95b15@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <61cbdd92-e5c1-443b-87f7-dba148b95b15@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 25/2/25 20:20, Richard Henderson wrote:
> On 2/25/25 10:17, Philippe Mathieu-Daudé wrote:
>>> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg- 
>>> target.c.inc
>>> index a0f050ff9c..08106b6e4c 100644
>>> --- a/tcg/loongarch64/tcg-target.c.inc
>>> +++ b/tcg/loongarch64/tcg-target.c.inc
>>
>>
>>> +static const TCGOutOpBinary outop_add = {
>>> +    .base.static_constraint = C_O1_I2(r, r, rJ),
>>
>> So now 32-bit uses 'T' constraint (TCG_CT_CONST_S32) and we get the
>> signed32 cast, OK.
> 
> Yes, TCG_CT_CONST_S32 will match all constants for TCG_TYPE_I32, so 
> there is no change in functionality.
> 
>>> +static const TCGOutOpBinary outop_add = {
>>> +    .base.static_constraint = C_O1_I2(r, r, rT),
>>
>> Similarly, 32-bit uses 'T' constraint (TCG_CT_CONST_S32) and we get the
>> signed32 cast, OK.
> 
> Yes.
> 
>>> @@ -2989,8 +3000,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode 
>>> opc, TCGType type,
>>>                   tcg_out32(s, SUBFIC | TAI(a0, a2, a1));
>>>               }
>>>           } else if (const_args[2]) {
>>> -            a2 = -a2;
>>> -            goto do_addi_32;
>>> +            tgen_addi(s, type, a0, a1, (int32_t)-a2);
>>
>> So do we really need the (int32_t) cast here?
> 
> Interesting question.
> 
> (0) Truncate -INT32_MIN to remain a 32-bit quantity.
> 
> (1) We are *supposed* to have eliminated this case already, converting
>      all subtract of constant to add of negative constant.  That said,
>      patch 9 fixes one more case of this.  (There were rebase conflicts
>      moving patch 9 earlier, so I took the lazy way and left it where it 
> is.)
> 
> (2) The cast goes away when we convert INDEX_op_sub_* and forcefully
>      disallow subtract of constant.
> 
> Because of (1), we *probably* don't need the cast now, but until (2) 
> it's difficult to prove.  On balance I think it's better to have it 
> until we are sure we don't need it.

Got it.

> 
>>> +static const TCGOutOpBinary outop_add = {
>>> +    .base.static_constraint = C_O1_I2(r, r, rJ),
>>
>> Don't we need
>>
>>         .base.static_constraint = C_O1_I2(r, rz, rJ),
>>
>> since commit 1bbcae5adaa ("tcg/sparc64: Use 'z' constraint")?
> 
> Constants should never appear in the first source operand.
> The optimize pass will always swap commutative operands.
> 
> This patch asserts that this has been done:
> 
>> +    case INDEX_op_add_i32:
>> +    case INDEX_op_add_i64:
>> +        {
>> +            const TCGOutOpBinary *out =
>> +                container_of(all_outop[op->opc], TCGOutOpBinary, base);
>> +

OK, I get it, but it was not obvious. Could you add a comment here,

     /* Constants should never appear in the first source operand. */

>> +            tcg_debug_assert(!const_args[1]);
> 
> Therefore, simplify the constraints so that they're not attempting to 
> handle nonsense.

and also comment that in the description?

Thanks for the explanation!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


