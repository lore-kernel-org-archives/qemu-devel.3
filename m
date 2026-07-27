Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8478C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woLS0-00041e-Bz; Mon, 27 Jul 2026 09:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1woLRp-00040E-Be; Mon, 27 Jul 2026 09:32:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1woLRi-000387-W1; Mon, 27 Jul 2026 09:32:44 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RAJc0j1958833; Mon, 27 Jul 2026 13:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QstVPY
 XloQ9fF//s8g2nG8EFLsl3sX0dPhrFWXAPx1k=; b=S1Qv2Mw2WWssfXYk+aU6/e
 bBYcasCfJTh0++O7VuqKXUdkSkXvRcIufq8gcEHaZin1KlyQIes9Z/5yBrGt8c53
 BMr1TrWMLIqKShC8uIrxcbF6FSA3XA854qaernNNIss1MaumXg+vA5cmq3O6vqa8
 4AsS1qIqStgtdAxJITbKCN3MuRazPNIpjwKLuFaytOtHYQ7k6DTAEut5mkn6pEbb
 KdTwjlwrah7Ezu8O/YPjXdD06j6IiZnwlgJpXpNEFyW/PuUKh9g4kcY+gm9kpLPm
 pSjJzKPbw91CDLXanW305dfU5QCNjVBa8SH1TugZOTMjA/r72/ckcFbSNQSRrUfg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xg822-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 13:32:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RDQMwj022566;
 Mon, 27 Jul 2026 13:32:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjwj4v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 13:32:37 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66RDWax531523456
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 13:32:36 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29E0E58056;
 Mon, 27 Jul 2026 13:32:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BE4F5804E;
 Mon, 27 Jul 2026 13:32:31 +0000 (GMT)
Received: from [9.39.23.56] (unknown [9.39.23.56])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 13:32:30 +0000 (GMT)
Message-ID: <720b6dee-23cf-427d-872a-a9ff2b61bc7a@linux.ibm.com>
Date: Mon, 27 Jul 2026 19:02:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc/cpu_init: make cpu listing determnistic
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260720192403.66694-1-pierrick.bouvier@oss.qualcomm.com>
 <a9766fa1-7c20-44a2-b12a-9d3455cb9198@oss.qualcomm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <a9766fa1-7c20-44a2-b12a-9d3455cb9198@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: fTOAf-Tknhy1ePKhnBD-CuNYVORrHKBL
X-Proofpoint-ORIG-GUID: YhkqZ6-8uTfYi8Tk49IoqgnJOcEA262e
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEyOSBTYWx0ZWRfXx4vPOyV84wYl
 UjewndEqeyPwKo5O1wTZinxGI9cBPrmk46aSHn2+KVqImQ1uRYfxiCXdVghcC84GHMNaVEL62Kz
 Y0fkF4NdkPw1kEblx3L3g45YipRmHj0=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a675df7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=EUspDBNiAAAA:8
 a=zIbHmUs0OD_xiEY_IgQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEyOSBTYWx0ZWRfX2ndXx8MoYD6l
 dO1UV93AkJpQ1jjmZ4HGCB7t3RTR8lUH27OPQpEEXKQopKWHE4lB5meu+TqPi8ynfz6ElTQszLu
 9QvITqQmNoe5/x6IG66U+sJlW30avWIkCGL8lwbNA/0k82YHPb3w45jC703os9SKqWyLCpYoK5q
 zxY9fJAuGFtKAixNr0hr87fcrZfJaTSrDCJdsTDKULHmVdRfA9xVdQY3ev4Rst4OwB+PVpyGnpv
 suBOlg5yLsvon0dkvQO0mJCibPPh0NcgKDBZ0YbP8+jdqC1U/cWfMW6gWmD+tPPaUB1OnMWvcTm
 DVCYQK2X7GylSpGHoJ2nqSzem0Ivip+n6xsmiDHHUgEqiLERNEIzVpwatgRGh2F6kQdR+Cq1qOQ
 TOQW3Eie65vlvMhYxuD65QGw4OrqPeewDSa6CfV/sXTAXbkh7uWe2Jl/h8cK2bSLwmR92Yp5uEf
 v2prdYecGj4Gl7ofTYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270129
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 7/22/26 21:42, Pierrick Bouvier wrote:
> On 7/20/2026 12:24 PM, Pierrick Bouvier wrote:
>> The existing compare function only make sure that we list cpus with PVR
>> order. However, we never compare cpu names.
>> As a result, while cpus are grouped per PVR, the order within a group is
>> non deterministic. Depending on QOM type initialization order, we get
>> different results for -cpu help.
>>
>> For instance, previous output could be:
>> Available CPUs:
>>    755_v1.0         PVR 00083100
>>    745_v1.0         PVR 00083100
>>    755_v1.1         PVR 00083101
>>    745_v1.1         PVR 00083101
>>
>> While a sorted output should be:
>> Available CPUs:
>>    745_v1.0         PVR 00083100
>>    755_v1.0         PVR 00083100
>>    745_v1.1         PVR 00083101
>>    755_v1.1         PVR 00083101
>>
>> Fix it by comparing cpu names to have a stable result.
>> This allows us to record and compare various command line results across
>> versions to make sure we didn't break anything while working on
>> single-binary.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   target/ppc/cpu_init.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>> index f404c7e549d..3443dbeeb01 100644
>> --- a/target/ppc/cpu_init.c
>> +++ b/target/ppc/cpu_init.c
>> @@ -7130,7 +7130,7 @@ static gint ppc_cpu_list_compare(gconstpointer a, gconstpointer b, gpointer d)
>>           } else if (pcc_a->pvr > pcc_b->pvr) {
>>               return 1;
>>           } else {
>> -            return 0;
>> +            return strcmp(name_a, name_b);
>>           }
>>       }
>>   }
> Any chance one of ppc maintainer could send this for the upcoming release?
> This would help us to compare command lines across QEMU versions to make
> ]sure there is no regression.
Hi Pierrick,

Thanks for the patch. Looks good to me.
Since this a minor user visible change and also not a regression fix, 
IMO this would be a better candidate for 11.2 ?

Regards,
Chinmay


>
> Regards,
> Pierrick

