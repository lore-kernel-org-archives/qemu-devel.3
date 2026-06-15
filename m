Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082D7CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZDm9-0006ig-Q5; Mon, 15 Jun 2026 16:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZDm6-0006iT-DS
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:19:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZDm3-0005tt-U8
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:19:14 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ1L8j1433230
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MuEQ94fWEAjRWJR755R2B82QlWHvXPqwt5ISDOC+OGw=; b=b/SkOQgUBqIBgSaY
 FurczhnUTnxvvwhnrBPaRGLKnXLplUB3vLuO37nEySRRdPsVDcui5iXy7hjvhxol
 xAdkG+Zwzo5vawyGhJPTNvMA8FNtweggH3YFtIUm6T722+P9MBUx5Z6ur5VOY05r
 7XwtpLS0hlyivTmM2059cqQRgu4NxZLcq+ZGEA5FhDSI7UWMZ884Bkw5lkT+r8I2
 gjbvvNpXcstpaBwycM8SzVhWAmPRQqUMP4Rb+eHllMKGSL/ojFRon6vS9Zzkhp+U
 m3ZffOkdowK1m1fP0ovxVmE1jdHU79PT//o3SyYm7uHNaQ3C+eutRU37t+iA5Zhp
 aM87LA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etgvhjamn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:19:09 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304dd917645so7875348eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 13:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781554748; x=1782159548; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MuEQ94fWEAjRWJR755R2B82QlWHvXPqwt5ISDOC+OGw=;
 b=AXkIrCj/VIBCmDyfR6frnuWSqSWCp7UYX+htsx2q0cwnoJpPuCWQ7GF6PD/pdGB1NP
 pF0H1FPVeqKufR+BrbgnRYs0MsJtrsKFOvMnX6sLsNr+ryf1WIHd5xKhiSm//b0Srzbd
 9kic3SfuU+kfS4OxOBtqP1u1APDYwyvz+xMrfUmlc18fDY+wcS6AVZTPQXmQm8z32z+8
 QPpQglTumxMG97WxlrSMfaKyMoMh99ImtSEJXtzzH8i8wZ2mkR0bGOSxRZLhr1vbqY6J
 vICWMOJk18T5e2998Yb3zxLyJ/KHYOrMRISUsyEFqSX2cDmPW+OJqAM1lQVlNtYDjPEE
 mLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781554748; x=1782159548;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MuEQ94fWEAjRWJR755R2B82QlWHvXPqwt5ISDOC+OGw=;
 b=ni8vXcKPH0vyfEFOYBgDa89swTh8tzqJ8JSImR/lkgr/jzlM6ieSw3VCqhy7OcJ0pv
 lmEdevQqwtn+hYlXGtM2e7XdQoPVOt02QXdynbXfCZr2iEjA5La1izvbWdLKweI8gZP0
 lFVOegAwznEHpk8i8KcfCmfzPLucWhCxXwcmIdv9MQ0s8ZVaCghM3XtDxFmL4quQJ4eQ
 NuU94RozFNXbadZBqLUWKYQSUI8xDWrTab3NNqpf0fesNXvKmMfKFbIIVfXU0ayivvAX
 JRm6q0yUSg1LdnixQn4x0c9axVM2huAw9i3cnkfby4YHdfkjz0F59NB7336cgrdG0aO7
 UDPg==
X-Gm-Message-State: AOJu0YzZLXMegIhE50aoaTWoNf2/pZwj92cUmimwLQRlAJ/KQPgvGnzn
 KzrJ07MYlU7TD+L5OG8sBfSj29YCb58I1x/Mb378WxZtaaSBo+AZlmCa4QrzYc+BaCPeNZ5HOoc
 YjxROYT+//H0Gi2S7XcQ1eSF5g5MI3Od6Eum5A5qQwo4OgQfrzO+6jenOnA==
X-Gm-Gg: Acq92OFl+JgnCQTwnhTRPJ9xZAfkw9oeqpSyeFv2s1dQdeQD3opqnMeIK2jWonBIi9R
 qKnwKBsWM389z+MJowfh1Vht2ixNoLMVQOqGnO8RXaO8g+rVtzoBqpV10jF4+vEI4wZugLTXv8t
 1nuUXaAvRY9UuQjDMxdLOYgcf9AUpS3ClWeakwcRb5pSISqdxFJsk0mDS5qQ3bpSO32ProsvfQ0
 SeE7bg/1iWnSRgHnvQf7PvSanLCEU/+Fvzj5cwLrAQcKr19mwIpMM2Wbys0e7aIozuzNsjldfQm
 7PzfwmeaNqYLo1IluqVSJQ6YazkUIBpvI9lEiGDB6q5FZ2RnaGHik7dS8kKN8dAttrL58n7//li
 6SneRoK9FNlN36WKwjVBEM4Gl3EBRv3xIkW5kQ2XcDzBcBrJLzNzV6tSOiSUycXcB7SDZNYmaGt
 fvNPAJOEfEmTb6IA==
X-Received: by 2002:a05:7300:641b:b0:2ef:8b72:1b9 with SMTP id
 5a478bee46e88-3081fcd0213mr7698461eec.0.1781554748430; 
 Mon, 15 Jun 2026 13:19:08 -0700 (PDT)
X-Received: by 2002:a05:7300:641b:b0:2ef:8b72:1b9 with SMTP id
 5a478bee46e88-3081fcd0213mr7698436eec.0.1781554747937; 
 Mon, 15 Jun 2026 13:19:07 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e489536sm16217918eec.2.2026.06.15.13.19.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 13:19:07 -0700 (PDT)
Message-ID: <18006fbb-c1ed-43c8-802f-a8f0d89275bd@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 13:19:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/39] MAINTAINERS: Fix F: lines
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
References: <20260521080511.999266-1-armbru@redhat.com>
 <d52c0fca-3a8a-4d4f-abff-f772605512b8@oss.qualcomm.com>
 <871pedhen2.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <871pedhen2.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIxNSBTYWx0ZWRfX8D7V35y5hZzx
 nFPZskTSjmiGz7LKMkknqYsFVFcizn1R0eAzfusJ0v9kQTsbQhFoL+onmQms6KENfV4qE9AS+TS
 t7pRYiClE+rjml359xK1ThFE4G9gtgU=
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a305e3d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=UBODv89aScNfMy1T3gAA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 69Mauz3faOCi8eYI8eiP0rHiwZVLG6VU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIxNSBTYWx0ZWRfX5Kc0izmkbT9V
 4t88mi1Z6SO18fJEWh/kqu+tM5nzI4YtxYJXqEngIDpiyTiMaScle05iHOFBIh3+1xZSzoSFMep
 5q5LztTtKZx7ySZJZO5QE9YruCJEJsun5taE69VZIhns+FARpkNvf1ekwfIn2TwI0v57w1x2QTt
 eG4aLYL26tIrRWDyNuxP3srY7qNJNAhSkmIuyoK/ZpWnWbt7SA9AGya3ShGKIwjOVJAsjYG/hLx
 OW6V1hEVCpU5DS8an5DOHBjZVYvwV2eZ1Ju3RgDCoE6nyAEkIVklCYVyd2FgItXsNrztIOXj6v5
 vISntQG5ceit0JxY6LSSrEAjgS8OhHfd4T1sxtBDAr1PelTVtJ0q/rPRl3T+77yDf8BhS/hDtym
 mhOIPCkML6XIooEUe35deDz+Zjie+Ic7cBByE3RSFbG02bxPXUYpTgirM5vavHLsaChMXzZKCaR
 t3qQ8ZCXEwnEzljnHmg==
X-Proofpoint-ORIG-GUID: 69Mauz3faOCi8eYI8eiP0rHiwZVLG6VU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150215
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 6/10/2026 9:42 PM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> Hi Markus,
>>
>> On 5/21/2026 1:04 AM, Markus Armbruster wrote:
>>> Quite a few F: lines don't match any files.  The quick & dirty check
>>>
>>>     $ ls `sed -n 's/^F: *//p' MAINTAINERS ` >/dev/null
>>>
>>> finds about fifty.
> 
> [...]
> 
>>> This series takes care of the remainder, except for one discussed
>>> below.  It applies cleanly with and without Philippe's patches.
>>>
>>> The exception is the last line in
>>>
>>>     Python scripts
>>>     M: John Snow <jsnow@redhat.com>
>>>     M: Cleber Rosa <crosa@redhat.com>
>>>     S: Odd Fixes
>>>     F: scripts/*.py
>>>     F: tests/*.py
>>>
>>> Both F: are actually wrong here: they match only in the scripts/ and
>>> tests/ not further down.  Left for another day.
> 
> [...]
> 
>> thanks for posting this.
>>
>> In addition, see the patch attached to this email.
>> It integrates checking this directly at configure time, so we never run
>> into any missing entry again in the future.
> 
> [...]
> 
>> Once your current series is pulled, I'll fix the remaining and send the
>> attached patch. Or feel free to do it directly if you like the idea :)
>>
>> Regards,
>> Pierrick
> 
> master is now clean except for "F: tests/*.py".
> 

Thanks Markus,
I sent this series to follow up on this:
https://lore.kernel.org/qemu-devel/20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com/T/#

Cheers,
Pierrick

