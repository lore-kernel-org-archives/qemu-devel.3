Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19082CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxsj-0005nY-74; Tue, 09 Jun 2026 10:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wWxsh-0005mw-Ti
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:56:43 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wWxsg-0006gn-G5
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:56:43 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2bf36a6905cso40044195ad.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 07:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781017001; x=1781621801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FTyRYlHDF4A+tpM5ZrsdMAFRIGvC7esWplDHNbgqS20=;
 b=KR+U24Sy96VDu3dLhhdbQE/DuVpdHQ9WEyTX8Tx10gdbzcAz/lBLK1T7PfYhgMiq9R
 xxSFI9WjYPTByi6eOAvY1de3PaUUVvUgy0hfNCMvhzlBDUuKp85BOE/KxDLXml63bc4s
 pKnGVkNVOqJZEPB3Hk14N4WTSyAZF4hLdCfNiRMtwjFSgP+yKwrzW+f1CNrKdGSdreFT
 qOp6mQmHOr+0QO4hds8IzA35gBQoMyn7fcTPiN871ZrS54Aqbk0X5xdNYCv66lHQ9EN+
 77473ks1HVnDeg5dG2GTb5zXwFJRGTORdcWRpRM3S84mjTIC5JEloiMoHodzmrR73wtK
 TQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781017001; x=1781621801;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FTyRYlHDF4A+tpM5ZrsdMAFRIGvC7esWplDHNbgqS20=;
 b=nfzxe7n/6K+9ghuoELi4Vuxd3OqhQmbHFnqTJ7KqtYd6iUBndY2tfjYBgEAwwmVUAq
 pFgCGFMMxWGnzd4i09L1z9ftGx/BsTqwcal1KI5o07Y05uDWeQ2jPfS/X0rjoZNx1ZGo
 dSSO1aZRSvYx7mBnOLxTOp65sI/E3fXsT2y58TriAAhHg84XltjCAQpye83YoFY9PE4Z
 c9shcEI1AVmZsgGaoRiu5CtuBkhHDnSZHik2tnWpFFu1B0QFb77RMlwZrn+P7GnQXi97
 6gzb5b8Eqnx4SPatGSMpEaqHLOj20oV4tRmmL3/UetTXoYONdn5vyrsuUYGXKwtBlZep
 uneg==
X-Gm-Message-State: AOJu0YxSObX/kt3V8ii3DFGaGhOSRaZFqHJuykTX9eHT1PcT+0ERmU12
 h7UtM++/bE8n7FwfubXFoHqjnJggwpBOw1GmD3yISeZFU0C3RGSs2ifihUSkmHaoOuI=
X-Gm-Gg: Acq92OEW22i1tfcpjTilm0MB5LIhx3+/XADgJWlsyfLAUyBELELahfedgOaHbAS0djw
 4/HqucUBzihlVTkE3yVpdYgySMMVIxTxtoCf//6SvZ9gj+B50VTDsF97zN/bNivRKHk+9ZtfnNF
 WBYx7BQyZ8V8q8Ch9F6pRx9WCvMvuWcojuXtJoTYW6fB1hbPoZLUyzvZL4zkqzd5ww00s4Szczg
 Vqc+/cnfu5b7HZtSPfc9+ZSZiPHQ+y5AxM6LWJqFxgerXIj0/MrGG91gXpUlm5TPSr/TaIhTekb
 i2M50PcxlCUBBq1LfBO/fHqLwoJCnM7cD09GJC7HVTX0YFu4hTzO8NMBKmATgAkxErQk7qPbimQ
 0h/asde2eAQgKMJXy87/isr0WJTaDnCA1WtMaNYnV65/KMyqa2qw9rWQpKB9lNMhEDj2/5G4Rta
 sgOfE63IPSiMriT+95C8sbHvJngo/uG54hUUra+bYsaMIleMI=
X-Received: by 2002:a17:902:da88:b0:2c1:ef9:450e with SMTP id
 d9443c01a7336-2c2a1c86746mr42961455ad.27.1781016996300; 
 Tue, 09 Jun 2026 07:56:36 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609e2e2sm211005955ad.49.2026.06.09.07.56.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 07:56:35 -0700 (PDT)
Message-ID: <0906ae00-b2f6-4530-b90f-5ff7f9b15ad5@linaro.org>
Date: Tue, 9 Jun 2026 07:56:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 14/45] target/arm: Implement BFCVTN for SVE
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-15-richard.henderson@linaro.org>
 <CAFEAcA-RzkAX4k2xqN3pwfSUZ3LDmCa0Or9bKo-Rpwbk1aXQNg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-RzkAX4k2xqN3pwfSUZ3LDmCa0Or9bKo-Rpwbk1aXQNg@mail.gmail.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/9/26 01:52, Peter Maydell wrote:
> On Wed, 3 Jun 2026 at 04:32, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
>> index c47e79637e..eccb5b191c 100644
>> --- a/target/arm/tcg/translate-sve.c
>> +++ b/target/arm/tcg/translate-sve.c
>> @@ -4100,6 +4100,9 @@ TRANS_FEAT_STREAMING_IF(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
>>   TRANS_FEAT_STREAMING_IF(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
>>                           do_f8cvt, a, gen_helper_sve2_bfcvt, true, true)
>>
>> +TRANS_FEAT(BFCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
>> +           a, gen_helper_sve2_bfcvtn_bh, false, false)
> 
> The pseudocode has
> 
> if IsFeatureImplemented(FEAT_SME2) then CheckSVEEnabled(); else
> CheckNonStreamingSVEEnabled(); end;
> 
> so shouldn't this be TRANS_FEAT_STREAMING_IF(..., aa64_sme2, ...) ?

Yep.

r~

