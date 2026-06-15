Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DE8CD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZCog-0005UX-Ow; Mon, 15 Jun 2026 15:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZCoc-0005Tv-19
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:17:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZCoa-0004U0-9h
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:17:45 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIxOlL781835
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h2QZCy6L2cj1MB52Y5T0MDhByTi2yLhWGTJtNrhGWIk=; b=P2tGS/mWTbm9wK7l
 ldQdKM2/c81QRKul0Oxz2STLcGNqD0MJoqJ7zfSGHDZGSO+yNtPHTab3sdQ+f64G
 By+98UudRv8Ze6qZBmNVCcUhlDjqHqH7t8JvMhjxVOn3EA03Yk/se1RC99QWFnHM
 /dAEzBIOsK5XwH9nKnl1lfjCKo2ccxSd2foIS8qI0Lz/CuWuoynzxukGWHqWjhEZ
 1Tes20hfaFz8LinD4bc1f4XJSCzuEwPJIJbzzVMghDdvHNrFE3In9m5tP+o3EtGx
 vOavEaIS2hdt9pQMycg/moWdkbRKkzBLgznbsRXQUmcA0hwlGAQLKCWTSb/UAS9E
 wzYPgg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjtkc3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:17:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304f1820babso5646358eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781551060; x=1782155860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h2QZCy6L2cj1MB52Y5T0MDhByTi2yLhWGTJtNrhGWIk=;
 b=KKk5XNXmMQFn2es/fiiss08goKgnDKeujGetMhrTZBpZdRUH5yd8iGs+SfaF+Ycfdp
 S/cGNJaQx4rVnWdsZbYadKqTeyah6oFxdqyHRc7vgAVjUQyU0A9A0sdDI/y0A9XIRv0Y
 5othKK2xnPRs7gYplv8uMpB5W4nIMYTHTAe1y07OVsYWxBwmlPvTcZ+inOVZebeZjNo0
 JFrsgSCCTs1a4o32ald5XXnmxfpuqfsdOiybLCt2+uNNIuKBFO36Bi//WU6JU0mC61HA
 hQLZ4TEao/8bA3xa7ZjeDrl6SWufr8Aaih6+B+t7bAho88FJZYag6YvUC/Wex//g5taJ
 YX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781551060; x=1782155860;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h2QZCy6L2cj1MB52Y5T0MDhByTi2yLhWGTJtNrhGWIk=;
 b=tTJeC3X+x4q86r9Fhw2viiins6lzCSigIj3d7WEdp9t5qSBHddByr9EIzJz2lUh4Dm
 KoS9vZvIuUkELWU+8zRt1Kv/uoMbjWwmH1NcJSmY1EMy5L2PSIbkVNy4Ls2M5zcLg9oT
 w7pNWdRq8iKYFVfGMoLJ2hMGsV/tTKdz9Rz573uAViRJ53Jy9m6ntKENFAfYudyv/Om0
 hyeMePKPr4hl/oyTIR9sUj2boFt1WqXkx6QCVluVrlt+0QhEL8M1u3ToHH+wDB99PqIE
 LcmeEHqquCVoarpwftobdhQsp5Z2n56iV6u9eBVxBNqcVwraM4Yr857H9kxDmfb9pkqd
 TXXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/o6oq/69f8z+KtI5Es69uYPDjTXSRHWwB4felodkHscyRfv5WCRShErvvfg2AL+3nlUQ32qW/odE/j@nongnu.org
X-Gm-Message-State: AOJu0Yzq+W3LDqC3vwN3Q5N0gcukTafmedNznw2w4W0sQordFWK0+Dzx
 QuSC8J+DwIXUbjlguC3mS8rV1HXz8FDIs0IJ+wQBfXvp97u3IqbJSgGySqQsq3o8fK3oIPmQNaS
 I7v/aZk2ezqBrCKieILHgdOYY0S+AwppKKZ0CU0hMrED5LTpSs50JJ93OEg==
X-Gm-Gg: Acq92OEVIdD1wQwzb8Q/0jnd1grsvDMVbLVgfgkEwcOgOkZELsDXJ/A2sO0TPDtMs0B
 hA1IRpkJ50KAekcvLa9FJifXmG3RaA91FJDre/XQserpDGhh0Va9934wunaaNZVCPcKYyM5Tked
 H+lm6tJ73Xmy2S6TNleBAe+BEB8shIQBMG9UwXfUQJhte0sn+09SkKu0eWPdVZDe1ghHRXV6cOE
 f7zAoct3J8+DAegwogb4j/3M2T9YawQigxJqm/7gkOyiIyP7eALaLBPh8xQbxB1RZ0j2GRP868l
 FDJYsWwMTwLLbEYmPE9r7nfGj2mF3X1IMntfApK2mONkpb+TvMr+V5bb6BYCJLtATxbwtiEhpRu
 rhyOIs7c//ZLxS5Px8hm4iGa4tAgGtg84yR48ur6wuCzLh6c238HxZvz5l+g69rMivX0cm/GKYk
 xVJ2HMf7YyVBLSKQ==
X-Received: by 2002:a05:7301:1f17:b0:30a:e530:ebc6 with SMTP id
 5a478bee46e88-30ba59fe62cmr348508eec.12.1781551059620; 
 Mon, 15 Jun 2026 12:17:39 -0700 (PDT)
X-Received: by 2002:a05:7301:1f17:b0:30a:e530:ebc6 with SMTP id
 5a478bee46e88-30ba59fe62cmr348483eec.12.1781551059021; 
 Mon, 15 Jun 2026 12:17:39 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081ea4f7a0sm14535523eec.24.2026.06.15.12.17.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 12:17:38 -0700 (PDT)
Message-ID: <41b0c228-0c28-4e6f-9ac0-c94c415671f8@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:17:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/25] scripts/checkpatch: remove check on forbidden space
 before '[' in C++
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-25-pierrick.bouvier@oss.qualcomm.com>
 <tggedi.3834rhzuw09kn@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tggedi.3834rhzuw09kn@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwMyBTYWx0ZWRfX9iI7o+XUFlLr
 ubYigzVOD+ts0QVExe4Pke91/BbFFyu89JFcse5rmwx5laupGDWCQeqws6pzTIP77O56W1F0aeQ
 YmRDD53LqxO0QNL7A6sRo+phDHWrYtUPrYkOflaOdzJ/sr+5D5F6ukBn8imhmULpf/7d1yT0vqn
 pE9Og52DdLHyUuOoZ5qs1+PCxLu0yLui0f0lKl3VdLnNVvLzVV60r/i2jtBp6c5euTnJCnEiE5g
 1KuzSxwkn9Vs14duYzISjqIv4RuoM8q1XQi2XAy4CcAY61bPUbvBSXmaEHIdPzvfYvw2apyvLno
 Hj2mATm1vR/BFL+K30egXEwSeK8lWu8cOTMe8PwmoiBOTN2mT76LKEos4YXCh/KwkELH2GDog6g
 N1ovZzMedhtHcpHcSquwb5vTXZnT90HdeihWXqCmntknqimR/ggDW5LdiP8QtKvslrI7TB7fO75
 7bfYg/MtIi0m591rPGQ==
X-Proofpoint-ORIG-GUID: avQFxATzyjVEXOuQqgxz3J4SNpgDPvwp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwMyBTYWx0ZWRfX5B/MVQi8aPHz
 YdMF3QnhjeLtv9B2LmSkEnLTyYL1k3ImEWESUR1cvVkdfq4q7TtZ5dgwTqvsSBU8cRUHInqHCrX
 JbpvNWFtcAjfkm0WxIuZ5arvbnGKVI4=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a304fd4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=WigQF9hC4yk2IfyIaP4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: avQFxATzyjVEXOuQqgxz3J4SNpgDPvwp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150203
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/10/2026 11:07 PM, Manos Pitsidianakis wrote:
> On Wed, 03 Jun 2026 23:51, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>> Lambdas are very confusing for checkpatch, so just relax this check.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
> 
> cpp lambdas are confusing for a lot of people I guess
>

The concept are pretty close from what you'll see in Rust to be honest.
A data accessed by lambda can be either captured by:
- [&] or [&var] reference (hidden pointer to it)
- [=] or [var] copied
- [var=std::move(var)] moved in (similar to move)
- [] no capture, and address of lambda can be taken
You can also add a return type(`[]() -> T {`), but most of usages rely
on type deduction.

Of course, to the opposite of Rust, you're on your own to deal with
lifetime issues.

> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
>> scripts/checkpatch.pl | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index c74ec070c53..d90aca6fcbf 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -2423,7 +2423,8 @@ sub process {
>> #  3. inside a curly brace -- = { [0...10] = 5 }
>> #  4. after a comma -- [1] = 5, [2] = 6
>> #  5. in a macro definition -- #define abc(x) [x] = y
>> -        while ($line =~ /(.*?\s)\[/g) {
>> +        my $cpp = $realfile =~ /(\.cpp)$/;
>> +        while (!$cpp && $line =~ /(.*?\s)\[/g) {
>>             my ($where, $prefix) = ($-[1], $1);
>>             if ($prefix !~ /$Type\s+$/ &&
>>                 ($where != 0 || $prefix !~ /^.\s+$/) &&
>> -- 
>> 2.43.0
>>
>>


