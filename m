Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94F8C54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wom46-0003Ro-7x; Tue, 28 Jul 2026 13:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wom45-0003RX-09
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:58:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wom43-00019C-Ku
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:58:04 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SEcbiV3063183
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 17:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PGTPLER6u9Juuvpf/aGZbIJSWFxdxhrHhFLVu22Mv14=; b=B9kMFIFCbmErj7ac
 DLutCzQ086QId5JKHCO9G5Urw6KozMuHZv4Ugco73mih5Q+Nha6zlf2y4xC4mp4m
 cF/ApKZrMr17F9vBrcdbKwT7j4LcHt3VakZXgCCi1hqCPKr06GBPWdXpArbRMYaE
 CTkQ2fwDP8nhKAn00ojn86ZVcOtUE2r03ifOLDTzCHcpaoFwto3Rl06iQwnRcHac
 8Ix7LRNKDXNX5/7ncxFkw2mh/WGbgigciSTl7dR+mFHi5FRwuf+Vuq5k1zSTt/4a
 95R7GH2OEzuorw9zTjiu7AfM9vgjunNWKjeQTeFmQtFc8uOzo4SDiolEmCxg1K3g
 I/70/Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpuyga2cb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 17:58:00 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb48f41343aso1023367a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785261480; x=1785866280; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PGTPLER6u9Juuvpf/aGZbIJSWFxdxhrHhFLVu22Mv14=;
 b=Ow2rd33hwj4Q63jNEXjXAGxakdddzp4EjJuzjB1+u4McgDzhdUMohtII/8yolIReHL
 bYc/wGwwkfnpt2VFe52rJwlfyFq45f2YdqrPpOCYEUkClzkKO3xosFpL7F+ubxnAaPDl
 bIULAqMH+4fTyK5ufzJRiFeNP4l4pJzjDeb9xQn2bBuHdgG3ZrxOxepozm0+RSg7ONHs
 qMoPpo+bixnYI/ifS7P/p/nzIlTrCn9VofejRx8Z+k5Gq4RRICExsT8shBAXxOZpRJlR
 LND/w3q2Tn4JhfhllJK7VNPdHCDRucDXGG7DPd3zHs+q690758ARKiUatTRAtxKy5h8C
 p3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785261480; x=1785866280;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PGTPLER6u9Juuvpf/aGZbIJSWFxdxhrHhFLVu22Mv14=;
 b=jJcjviz7x+4HUiRt1QFiMFCwd+ZS6YWCFW9KeTyVTeqKq6wBsJdX3TZ4Fyh5CSIOqL
 pm+8n8BC7BSkDAmWWd6tGUe4owvXk4AIfGM+Pa1M3xDzE17LOIddmFw7SNj+TO0XOGdS
 ioFY7j4KqTrPBORjNfJXMewLvC4A3+4ODOP0GtIlHy6av7mNSllZb44eb+C1ZQeBIP1r
 8VJRKo1/dSTlNDHnkVxmQPDCvuWodZ/+bHbKoX/5yYDIXrEyhTHjhs3F7Qz7EROOfvgj
 iXvJ3N7c/3Zay+ZD2FtVR0OT3R/t7mlwaVVPlCfNis9A1Wdcl3LYUADYQfFnvMQp9Nlu
 1cMg==
X-Gm-Message-State: AOJu0YxflJQ9G9C7JHiypYYCGCfKQxldt9pqurd/rtD0I4TkISsdOLVC
 2dmA1/E3Ye9tRK2lIHoN4YXf2YAo/+CmhSEfudCoNN/THInONkY0PZgkKFv5iF/TblcB5piwmzW
 IgWghAn1EBJytrMUcB3wCpVzST6VsRwOx3FgqokCezltjkGvnWj6Ww63sB0H/FtLkpQ==
X-Gm-Gg: AR+sD13j00Zc+meKjIgtPsz+tXO5oh0uqdVMlM8I5mI7LZC3QhQxwLXhE1ISjdSqDTn
 TmywsAsNSvsAY9OIpmdbgQbt50ea7Dae5ArqKFzo4UdmFc03y+STVrBKLjO4QQH9FG4hb1z/GD/
 tEEw3aEetb2HSP/NF71i7Wh4uPy7F6L5E3nrqf5myKPP//VtU7ttMLxtwFwtpW2N+beP/HcAM1W
 aLcCtIqnAoYMtAhexuebLNfJMElSwGBZNmbVCP6gj9msHVL44Qsj/8creSv+c9lsE40GyoinKe0
 mC8VMrc4cWd8C/xUXBm8Mav6oDGqcF70bAB9aDJdIp7okD4OU6I+gF0NX9bzMkctMWbeZOUpaZM
 3uxTZeyV4PMxOaxnEr9Sxi97CRRlcktI3vZISh9iwSy61Pjx137umJ6UVGi8S7xQsykpV
X-Received: by 2002:a05:6a21:6f8b:b0:3ba:d7b0:fcac with SMTP id
 adf61e73a8af0-3c8ab0d42f8mr4259123637.5.1785261479838; 
 Tue, 28 Jul 2026 10:57:59 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f8b:b0:3ba:d7b0:fcac with SMTP id
 adf61e73a8af0-3c8ab0d42f8mr4259095637.5.1785261479389; 
 Tue, 28 Jul 2026 10:57:59 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dca6a8sm857549eec.29.2026.07.28.10.57.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 10:57:58 -0700 (PDT)
Message-ID: <54a09c6f-0ed4-49f8-abec-afd916faefcf@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 10:57:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc/cpu_init: make cpu listing determnistic
To: qemu-devel@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 qemu-ppc@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260720192403.66694-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728150627.b0e3b230-14-amachhiw@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260728150627.b0e3b230-14-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 11KG0Am54vECxCDSBjeLWNmPyHIrwuBA
X-Proofpoint-ORIG-GUID: 11KG0Am54vECxCDSBjeLWNmPyHIrwuBA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE1NyBTYWx0ZWRfX9jE5iNa/30Dk
 Au0/NV7nsu5N1Cflq0QSjLSgQtkodpvimVPGH0Rm+ca4abhu3jZuoDKCXSV3wmvNB0GvAir9HQi
 Rc6pTmVPbMKbiYQVSSGZ4/Cc4oFWyxvDEvnE0TcqnmBWyHNUmDtDEYYdRUzWQnHg5D8drCPctdn
 j1iNxljv93fhf8q3i+FWKBuCa5xIGkqQ+oTIbKN/df2E/ZxX9xdrjKI/3S5MYUzCSzNho0kO0xi
 BorzKwmI7x6VQLCwnDL3Or1cpw10txC0J09N5r0aZNq67zdUlhJTbV+DffDsdLVkOVi3iaV1/+Z
 Z4tt7Zmtmst0yN7CmRwOnUwnOBpYiT4paQtep6mIyHNowFyRtPOe+SoC6crgIeJ+Ra6mTPgxgVp
 01QR/R/c/99i61dWuhVOV7ShhLLf+b7V9dbpIStITehXbtl3cfe3mu770iaK0fa0lBSMRFNp5C2
 oVWSMup9LadIztCS9bw==
X-Authority-Analysis: v=2.4 cv=aoWCzyZV c=1 sm=1 tr=0 ts=6a68eda8 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=zIbHmUs0OD_xiEY_IgQA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE1NyBTYWx0ZWRfX7sUcJq4LkEPL
 tk3H+0ps4FBtp8gK9Lq3QSY8gnNd1mAd4E+x8k8ZNaZZAp73vjr0tPr7f4QgIu44bN5YSq+9LAu
 T5h2ZSPvec+qM/Ow+iceTDXK1zqfxgA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280157
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/28/2026 2:40 AM, Amit Machhiwal wrote:
> On 2026/07/20 07:24 PM, Pierrick Bouvier wrote:
>> The existing compare function only make sure that we list cpus with PVR
>> order. However, we never compare cpu names.
>> As a result, while cpus are grouped per PVR, the order within a group is
>> non deterministic. Depending on QOM type initialization order, we get
>> different results for -cpu help.
>>
>> For instance, previous output could be:
>> Available CPUs:
>>   755_v1.0         PVR 00083100
>>   745_v1.0         PVR 00083100
>>   755_v1.1         PVR 00083101
>>   745_v1.1         PVR 00083101
>>
>> While a sorted output should be:
>> Available CPUs:
>>   745_v1.0         PVR 00083100
>>   755_v1.0         PVR 00083100
>>   745_v1.1         PVR 00083101
>>   755_v1.1         PVR 00083101
>>
>> Fix it by comparing cpu names to have a stable result.
> 
> Verified the before/after output of `qemu-system-ppc64 -cpu help`. The
> patch correctly stabilises ordering in all PVR-collision groups.
> 
> No regressions: identical CPU set, ordering only.
> 
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com> 
> Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com> 
> 
> Minor nit: subject line has a typo ("determnistic" should be
> "deterministic").
> 
> Thanks,
> Amit
>

Thanks Amit.

Do you need a v2 with a change, or feel like fixing the typo when
pulling this patch?

Regards,
Pierrick

>> This allows us to record and compare various command line results across
>> versions to make sure we didn't break anything while working on
>> single-binary.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  target/ppc/cpu_init.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>> index f404c7e549d..3443dbeeb01 100644
>> --- a/target/ppc/cpu_init.c
>> +++ b/target/ppc/cpu_init.c
>> @@ -7130,7 +7130,7 @@ static gint ppc_cpu_list_compare(gconstpointer a, gconstpointer b, gpointer d)
>>          } else if (pcc_a->pvr > pcc_b->pvr) {
>>              return 1;
>>          } else {
>> -            return 0;
>> +            return strcmp(name_a, name_b);
>>          }
>>      }
>>  }
>> -- 
>> 2.43.0
>>
>>


