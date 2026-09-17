Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65834C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Fe0-0002He-UX; Thu, 17 Sep 2026 13:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7Fdf-0002G3-A5
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:11:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7Fdb-0003W3-0P
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:11:10 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HH5cFm2413145
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X/qzGqqmFA9h9uBfZY89IhzbfuoCEb26SKcQvVBkvb0=; b=n5FcacdanXFmckrn
 hEWigGIhKl1tY2U8l66pXuZr9iql1iaa1yaKnHc33PsfQnFNd3hcA3wbXA1icQrW
 HAt9aLowpDOe8MNfEjjmZT7bjiq0zFtgCu6J5AGt/2Xh08u9edzEaNT6o3AnmvLu
 Txw6Ub43JifQ06TI13SdkU9xLG1h7YGoezwYo1hFfi7cwtXDDUTszgeeqGHl0aRo
 fl29TbxWs0CcqkQPZGoyeYrQs0U+/34XUy2FqBzwCNxFzEVplbgJbPhCNTmNLsGm
 XT9MV8aM23ZnMXNcE9kOhKldqm+oOvY/Zi+rnf4lBcVMTTVdbic6e+TRuKOZgeRJ
 +WPMnQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grgu5h7bj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:11:03 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc42a07d04aso904271a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 10:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789665063; x=1790269863; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X/qzGqqmFA9h9uBfZY89IhzbfuoCEb26SKcQvVBkvb0=;
 b=FicqhjHLBtoY0c08wHtAZKljuj3aV19AGsIWREcAqLncd9DyVaEvLezToludXtgjo6
 a4+VX+7dz3+RW6PzdWNiFG9dHUKgdxvD/Clt1AAA4HO089xCMFhhalx8MIPO5MfDTXu2
 O46eOzzyZ1iqCCzmLAH/cw7u9/1FMHhpP6A8BlIktRovYgvqnW65E8LLGCnp+metJ/iV
 baMt6SSgRBJR/FEJxa75MuZmN95guQZMd6kplKBagb2QTyVxQ4HcvDumxkFMtusD4SjI
 JElEeIHma4p1holNTPdET9NzwgKHp3XAW17WlkyEQ/WHV+VnNUQ08W+51XwAoIf8Lzcu
 9z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789665063; x=1790269863;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X/qzGqqmFA9h9uBfZY89IhzbfuoCEb26SKcQvVBkvb0=;
 b=SxJc7duuJsuBC3M3GXaY3kEowg/cfDdLlYbx8JoR6fnWJ9ALTxaORfGSzdBj7GTxco
 1/IlWgZxC5DaAkuBcwVPwHwum8GhnS2nMbHzIP/McMmzuzQtobNhdcjCe4m2w/m4g0ly
 ISai53CP4DU53bHWmjcIjfOPGQ9BBrN0vhLxD4vi50dZij8giML/1DKZqd8qjc0n3r9C
 zCqYhU+1Ny6zBXmoAxVzD16VfLwVIbeFpkK+I2dDQIzSaTw+yv4XMCBhs0vPJ5vweMme
 +GiweQvgirDV52p9mFUTwX4H5UvEjP15pa1ohZGYEaCxyQNpg4mnGHEBqjd4wqmeNlg5
 F1QQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6afv+7042lALteSITIi7CVw9kqJwzO80XqDMcp3fqgu5BEQLKP9inQelF8Xb834dxVfcr8SFfv9fy@nongnu.org
X-Gm-Message-State: AFuF++mLkDCmKmIGttPnqDwYNfQ95BfmanWV5wqjgTdEvgeHL0pMCQP4
 cKKh9pGv+RA8T4OhK7FZVhVovkk+7X/gEOtWEsKt3otwTlNz0PMiETM4Hbb4CldWXdCEVbbWD/v
 lAFHjDRroavuzR3z8zouq2Rd47wviT0mAQ1+PjTfJZQ5wVxp+Pn6mJjGeIQ==
X-Gm-Gg: AYBFou34SC5OMtWwuyamoAAsXWhWfBmVUhyNMioJJHZRcP0R0mJWfdnIXeTqIWwVxnA
 q6kTyMLWYH0WpJ48TBbR+IIU7inqvyksWGG6FBLrwLetUYvz91YyG6qwc7VoFGE3qABZDjtk4Vk
 G0IBIyylSG/FOYX/61DQgxNz8wkRQPjQFcRswt/7gMrApuZgkg8lxNfJ8n+EgcOX8rvSbYpjQ6I
 AUrBcUc6V7DJdlQeV3vvUpEnCMK+UEdcSSlf2o0OtvFNY9LQCmtRrLw8BEywCldyOg/N2p02/iN
 UvnDOyqQD7avCVZnfnqzD8623KPknz+6Z8wTK3YOsbrQgAlJP8zi5o05wmBI6ppgT1xf3tUR4vv
 oqaS2/nHkWCMWd9MVMszAwMhvmb+ppX0nQaYniO1qAAtK+t5THtgnhQ8ku93xmcAbUarC
X-Received: by 2002:a05:6a20:6a0b:b0:3d3:ae1f:d7f3 with SMTP id
 adf61e73a8af0-3dd5f73ef30mr18598223637.19.1789665062810; 
 Thu, 17 Sep 2026 10:11:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a0b:b0:3d3:ae1f:d7f3 with SMTP id
 adf61e73a8af0-3dd5f73ef30mr18598161637.19.1789665062239; 
 Thu, 17 Sep 2026 10:11:02 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf596e1f6sm19371296eec.1.2026.09.17.10.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 10:11:01 -0700 (PDT)
Message-ID: <686611d2-d6ca-4022-adbd-49cb7b0b943a@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 10:11:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/12] target-info: Introduce target_riscv32
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: luoyonggang@gmail.com
Cc: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
 <20260916-hw-riscv-cpu-int-v4-10-babc367b60f5@rev.ng>
 <f692f936-550b-4e5b-90ee-399edf21de73@oss.qualcomm.com>
 <CAE2XoE9KkW+WPWL1g4hzT6OtkQhfYvaMAopBW4NfFMkXn9hjzQ@mail.gmail.com>
 <ef62c7fc-9db5-43f2-adbc-e86a805757b4@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ef62c7fc-9db5-43f2-adbc-e86a805757b4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI0NSBTYWx0ZWRfX+RGoj3lA48CM
 7xWFF5XemBph2gxWOmrAj2RZML/82cjifldvK9uFMZAKYg3b7xuAfuYL18Hl+smU6OKFc70kilZ
 Fz/RKpxUcHVtfYKhXKaKXP/Jp+B6bsY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI0NSBTYWx0ZWRfX9vfA5dTlneOe
 MvNLrn2VExrZWPuswM0njonmKIHJt+7cHaY2MX1YYN54LXRDvZDmt0g68uhN8fS67zMmJmt4ib9
 jBpRutFXN2n3qdwQcr/Zjhf15qpY+2n469Clqp8itXLFEkQrjzn0sqF1h5TxqlRfnWS/poofSVY
 hFOl4ZAyPWfylpgf6X+t2mqDbsi5eOfqj2ZLEDj9F2uH8ZNc1aYIlHMcZeYZ392lcgI4HZ5IL1Y
 nqMQGJB5ASFbOnQx6Xl6DtjgM4TpakoRfToi/1aC/9wEercr+Yq8zRrX/riUZO3lp+EMX+osS0U
 sc4rY+JTqPl4cs1Wf6kDdX9z1dOxbOTUCvyqFIYtiZ6sw629+TI92Q1Tkk2ASeyBELb0zB0sJwV
 5fuzWbVPN6yJs0xIVqYe05NR+SEziej+a1A+UgWQWaEM2dm3eGSbTVvl2JybR96FnCja2QjLsI3
 VYnReiLK0jZNLApONzA==
X-Proofpoint-GUID: HLGg8ldTF9wpLUrITtLPr9PJpAKdurXf
X-Authority-Analysis: v=2.4 cv=GvbXaU1C c=1 sm=1 tr=0 ts=6aac1f27 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=UNydBOIn-IAKdUVdJZ8A:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: HLGg8ldTF9wpLUrITtLPr9PJpAKdurXf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170245
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 9/17/2026 10:05 AM, Pierrick Bouvier wrote:
> On 9/16/2026 6:00 PM, Yonggang Luo wrote:
>> As I said before, we need the `const TargetInfo*` parameter to for
>> is_avaiable.  I've get all accelerator and i386/x86_64/aarch64/arm/
>> risv32/riscv64/
>>
> 
> In general, on QEMU dev, we can't block other series to do a change
> compatible with a current work in progress. In other words, the first
> merged wins, and the second has to solve the conflicts. That's sometimes
> frustrating, and having worked on single-binary for more than a year,
> yes I confirm it's not always fun to "cleanup" behind people patches.
> That's part of the work though.
>

I should say "request changes" instead of "block", because I know you're
kindly asking for it.

> In this case, this series is based on upstream, which doesn't have or
> need this parameter yet.
> 
> Also, in the series where you introduced this parameter, the usage was
> object.c: is_available(target_info()), which is strictly equivalent to
> what we have today. We asked what was the goal but didn't get an answer.
> 
>>
>>  single_binary_supported_targets = [
>>    'aarch64-softmmu',
>>    'arm-softmmu',
>> +  'i386-softmmu',
>>    'microblaze-softmmu',
>>    'riscv32-softmmu',
>>    'riscv64-softmmu',
>> +  'x86_64-softmmu',
>>  ]
>>  
>>
>> On Thu, Sep 17, 2026 at 1:03 AM Pierrick Bouvier
>> <pierrick.bouvier@oss.qualcomm.com
>> <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
>>>
>>> On 9/16/2026 2:19 AM, Anton Johansson wrote:
>>>> Will be used in the following commit to filter machines using
>>>> TypeInfo::is_available, so a simple !target_riscv64() is not sufficient.
>>>>
>>>> Signed-off-by: Anton Johansson <anjo@rev.ng <mailto:anjo@rev.ng>>
>>>> ---
>>>>  include/qemu/target-info.h | 7 +++++++
>>>>  target-info.c              | 5 +++++
>>>>  2 files changed, 12 insertions(+)
>>>>
>>>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com
>> <mailto:pierrick.bouvier@oss.qualcomm.com>>
>>>
>>
>>
>>  include/qemu/target-info.h | 30 ++++++++++++++++++++++++++++++
>>  target-info.c              | 26 ++++++++++++++++++++++++++
>>  2 files changed, 56 insertions(+)
>>
>> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
>> index 0620a3db84..560d589bcf 100644
>> --- a/include/qemu/target-info.h
>> +++ b/include/qemu/target-info.h
>> @@ -239,6 +239,36 @@ bool target_is_s390x(const TargetInfo *ti);
>>   */
>>  bool target_s390x(void);
>>  
>> +/**
>> + * target_is_base_riscv:
>> + * @ti: TargetInfo to inspect
>> + *
>> + * Returns whether @ti is RISC-V 32-bit or 64-bit.
>> + */
>> +bool target_is_base_riscv(const TargetInfo *ti);
>> +
>> +/**
>> + * target_base_riscv:
>> + *
>> + * Returns whether the target architecture is RISC-V 32-bit or 64-bit.
>> + */
>> +bool target_base_riscv(void);
>> +
>> +/**
>> + * target_is_riscv32:
>> + * @ti: TargetInfo to inspect
>> + *
>> + * Returns whether @ti is RISC-V 32-bit.
>> + */
>> +bool target_is_riscv32(const TargetInfo *ti);
>> +
>> +/**
>> + * target_riscv32:
>> + *
>> + * Returns whether the target architecture is RISC-V 32-bit.
>> + */
>> +bool target_riscv32(void);
>> +
>>  /**
>>   * target_is_riscv64:
>>   * @ti: TargetInfo to inspect
>> diff --git a/target-info.c b/target-info.c
>> index 9083b7bca6..a9fcd1c07b 100644
>> --- a/target-info.c
>> +++ b/target-info.c
>> @@ -250,6 +250,32 @@ bool target_s390x(void)
>>      return target_is_s390x(target_info());
>>  }
>>  
>> +bool target_is_base_riscv(const TargetInfo *ti)
>> +{
>> +    switch (ti->target_arch) {
>> +    case SYS_EMU_TARGET_RISCV32:
>> +    case SYS_EMU_TARGET_RISCV64:
>> +        return true;
>> +    default:
>> +        return false;
>> +    }
>> +}
>> +
>> +bool target_base_riscv(void)
>> +{
>> +    return target_is_base_riscv(target_info());
>> +}
>> +
>> +bool target_is_riscv32(const TargetInfo *ti)
>> +{
>> +    return ti->target_arch == SYS_EMU_TARGET_RISCV32;
>> +}
>> +
>> +bool target_riscv32(void)
>> +{
>> +    return target_is_riscv32(target_info());
>> +}
>> +
>>  bool target_is_riscv64(const TargetInfo *ti)
>>  {
>>      return ti->target_arch == SYS_EMU_TARGET_RISCV64;
>>
>>
>> These are the helpers I needed, that are very important.for subsequent
>> work, otherwise the latter work will be repeated again. and split 
>> target_is_* out again.
>>
>> Those is_avaiable should use target_is_*, that's differ from 
>> target_riscv32 and so on.
>> --
>>          此致
>> 礼
>> 罗勇刚
>> Yours
>>     sincerely,
>> Yonggang Luo
> 
> Regards,
> Pierrick


