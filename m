Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A4D606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OMLkLur1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XjKyUvP0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTgjh-0005v8-Vs; Wed, 18 Nov 2026 09:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTgjV-0005s9-Ih
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 09:33:58 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTgjT-000841-0h
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 09:33:56 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIDQ9MP376568
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 14:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FVfpuZ1nA+BAiyFq7owCoIeeYqW1PBPjuyzwZaUfE4U=; b=OMLkLur1VE/rYbXH
 Mk/7Hy5M2y5XsELROmNTCohMw7bQx/kelWJxubLVe1OFR+WdVhZXrNNx2AY8q2+K
 f3yuxbCquR8kPZwnJc/Y1TBienoR68qqAHcG5qNgiCh+hLC/vSokRMwi/HUsLf1O
 ubWTifRrEFsQUjnhtAuSj5FPthUwFB1mrN1qDR2Q5LCIINmbaoNbZnoOx89xciBE
 /2f2w7kA+YEL1w2cv4q0z8fRm34jgPk4PjexH2XWDyptJnKm1iUNk4DDG6xOGAQq
 R9yZh4MqPje2gBUNlxqhx/hpmRoZnmekq37UB6Dj5k2ip7zaX8xjfKe6QIaZ8tqh
 lsGxIw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9kcqu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 14:33:49 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8b4bfc0b441so14606907b3.2
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 06:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795012429; x=1795617229; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FVfpuZ1nA+BAiyFq7owCoIeeYqW1PBPjuyzwZaUfE4U=;
 b=XjKyUvP09RkdKYnRe6JL+yWAnUCrttmJfwf8yXOo5CywOOgCOJ6BPQpO2JWdSsdEc0
 /Vs1MUAFsJ5sgJ+jH7wdfWFfiGDuevHixkSxcSo/PRM48gyREVZxBD1bLQzppkQByZeg
 Cuxs4MZTtX38T3HWA8lCuCw4Vdm5XO4bpQM4goC051h5CH5U7yW8XngHELl9RMgVlV5/
 IJh7KiPBPrmcch5cD7qqSuXWtOiCHGfo6PcuWjsF3WvjxN+5x31siz+bYo/YzPiUCoBt
 0DI3q6XAoQjVJet6YASSeGZ63MhIsyZyhkXHfLEJiDZ+7R2rd/V5elBL6eYYoI5HhyhR
 eLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795012429; x=1795617229;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FVfpuZ1nA+BAiyFq7owCoIeeYqW1PBPjuyzwZaUfE4U=;
 b=SNazhOa3jY3FiVdUWK/TBVCRNFnIGxuO/51fQ7lD+swZ3x1eF4R8FC1BEZzUded4gM
 BgVnVwAKKIr32NzKcK2Kd15pgjr7p9kwsijwvSVef1QoxNZaBFabZjWNlTF9Xjrtjwuo
 dqSTHCByH6aHVVemCzuoEFZlZxtiGljomE8c/5depQ9gbtgeMwwpp0Em24a5zBfbP/s9
 HAMlDeUxWeevRbj8PouIpFryjjcNJUPy8Pus/jEXDviiXI4ApwmgmyUSDaGsJIH2X77s
 wSREzV43YFwLwFu+js7T1r5aVyWaypmhPek+fU0ZBQkfYqbQy0nH1eg37owNvZNQDxnX
 Jn+g==
X-Forwarded-Encrypted: i=1;
 AL+hErGulvB3tWpZoG9hGOFkUq+LkED8h1IV/wjDy85ZravSX7XI5NpLQsDv/FlXwN0f5AMjYCBtjNBKqqLv@nongnu.org
X-Gm-Message-State: APuU4Z9GuUVHiXWtl3KJAomfhiIzq3f8+IAEca/0SDU52UGddcv6KmFO
 pC/6p0SS6SXFFtGA6gnV2TkNtzZHNVnDDREnRVAutz9qFu0rIg37dQCpk+Wi/4nNdRXmPlOpN2w
 IuQmjDl5sa0e4sxd1dA+Lzshpy87PWOshAnj7D3d5GjAiH0+u/9jLgURu3A==
X-Gm-Gg: AZFdTZeQVCX9wTvSMjRxWp9BZgIJBBJMy1DsQ7tlCeggJm6Dr0DSbQuGNfNJq51mvaT
 3uJhqnky2Dr1PIhY0Dx38KrPIixkRpp5kcmONh5mG0Fift4eDnG/2xder8MuAjaRZ7OLE1kThrE
 P9e3y87YZVlumbRlGLrDxizkEBH9XQS9lvExmS3sc/14VKEWphNugFEGR76FpnAMOfeLQ3KviT5
 cE19YwblUpIr1Dv1kg/zLrL5clOHCLqxgYwHZP9p5+jOGH2oF3ZkveUq4AjvX41ghJws6Eh6foM
 R2Tt/T9usClLdCos1zVCXhOJCNGicmJ9QyAyHibsKjVKX/8kn3CKSzZVW2mw25P7ayegIuLJDDh
 BRF2aimwU2veSDdS2BeqRaGWqwwwYMt+AmoyC4b4it7gQGs0sYa9olVxRUJYZmxkLUxRiGcR6ZU
 hAHwSXphk=
X-Received: by 2002:a05:690e:1686:b0:676:eb57:bba6 with SMTP id
 956f58d0204a3-67dd3f87bedmr1314267d50.58.1795012428865; 
 Wed, 18 Nov 2026 06:33:48 -0800 (PST)
X-Received: by 2002:a05:690e:1686:b0:676:eb57:bba6 with SMTP id
 956f58d0204a3-67dd3f87bedmr1314256d50.58.1795012428274; 
 Wed, 18 Nov 2026 06:33:48 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a650d2efcdsm5042529f8f.5.2026.11.18.06.33.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 06:33:47 -0800 (PST)
Message-ID: <a15a57a4-4520-46b4-83cb-2b8c872ff028@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 15:33:46 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Test CF_NO_GOTO_PTR in cflags, not in TB flags
Content-Language: en-US
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, mattst88@gmail.com,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20261117080843.8314-1-philmd@oss.qualcomm.com>
 <97ba694e-756a-4e6f-93d4-85fb316149d5@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <97ba694e-756a-4e6f-93d4-85fb316149d5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0zulMnxlbZUPExOA3jfkoK2hBeW7UK1b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfX9SZps2N+HK7J
 jy04zUHt4jIEUQaITIYeYhHv8iKzOCBs8xd90ZBFb/F4rcmn/NDgZF/QAxLQajWWZ4678Wd5jvi
 w1UEXS3/oeGKwMvFxJRytgWHpNYGnbw=
X-Proofpoint-ORIG-GUID: 0zulMnxlbZUPExOA3jfkoK2hBeW7UK1b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfX7PxocOtU10xX
 FJXqAxuTSM1fJ9sL+f+4tjKx6V3HT1rLLWAbjZPt6xJ9ibea34ibzTNFn11eAG2AhhouO8GYfop
 UdQNtt3vAItUmj0I6Lxgly01xhQFoYbNqHWTjHVhwRdVL16F0Eu2vp+bswwzSDlXKg2guMNYYo9
 aOOr5SQyL5TIlQ9yxL/w0pxYJNN7rsQZPLE4Y4ETgh6HYuMhSeh3pEN6T8Z6Bc8NQssP7xFUQT6
 wEpL6egq2sMg5fALY8oFlf6h/d6wtLogcFPg6s/oue5pwuEtEs17+hRgpP0LenE0hrSqLKDlG2m
 2LEKZa4ONCsSkwtkVbGnDxuwQF4H0+2SPT6oBl/HiApm7LItTkN00Wco11uf8Q7Oxa5JJ656rWI
 qLMpz37K9sfQ/Xg93kO2Z9VNiwE3pL7gsLDdzYfLeyPkn1O9WqSdh/beCvmcJIAv33wdDssAsru
 46dTO3qclTeb0pdHz/w==
X-Authority-Analysis: v=2.4 cv=RYIFmFtv c=1 sm=1 tr=0 ts=6afdb74d cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Y5MKoESTlb9BZQlvKpgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180057
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 18/11/26 12:28, Chinmay Rath wrote:
> 
> On 11/17/26 13:38, Philippe Mathieu-Daudé wrote:
>> CF_NO_GOTO_PTR is a TB cflags bit, but it was tested against
>> tb->flags, where bit 10 is HFLAGS_SE. Use tb_cflags().
>>
>> Fixes: 46d396bde988 ("target/ppc: enable PMU instruction count")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   target/ppc/translate.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index 467b8f3d4ec2..dccae25bb4ec 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -2645,7 +2645,7 @@ static void gen_lookup_and_goto_ptr(DisasContext 
>> *ctx)
>>            * tcg_gen_lookup_and_goto_ptr will exit the TB if
>>            * CF_NO_GOTO_PTR is set. Count insns now.
>>            */
>> -        if (ctx->base.tb->flags & CF_NO_GOTO_PTR) {
>> +        if (tb_cflags(ctx->base.tb) & CF_NO_GOTO_PTR) {
>>               pmu_count_insns(ctx);
>>           }
>> @@ -5160,7 +5160,7 @@ static void ppc_tr_tb_stop(DisasContextBase 
>> *dcbase, CPUState *cs)
>>            * tcg_gen_lookup_and_goto_ptr will exit the TB if
>>            * CF_NO_GOTO_PTR is set. Count insns now.
>>            */
>> -        if (ctx->base.tb->flags & CF_NO_GOTO_PTR) {
>> +        if (tb_cflags(ctx->base.tb) & CF_NO_GOTO_PTR) {
>>               pmu_count_insns(ctx);
>>           }
> Hi Philippe,
> Thanks for addressing the review comments brought up by Anton and Matt 
> on the original patch :
> https://lore.kernel.org/qemu-devel/20261104163854.87398-1- 
> richard.henderson@linaro.org/

Amusing, I was not aware of this patch, we figured it within a 2 week
interval :) The ppc_tr_tb_stop() path is not updated however. Richard,
do you rather respin your patch with the ppc_tr_tb_stop() change or
keep this one?

> 
> I think it'd be correct to include the original "Reported-by" and 
> "Reviewed-by"s from the above mentioned patch as well.

Sure.

> 
> +cc : Matt and Anton
> 
> Regards,
> Chinmay
> 


