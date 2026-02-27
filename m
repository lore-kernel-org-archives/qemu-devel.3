Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24836FD7F8D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 10:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvuu1-00075x-Rk; Fri, 27 Feb 2026 05:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vvuts-00071x-RN; Fri, 27 Feb 2026 05:16:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vvutr-0001Fo-BU; Fri, 27 Feb 2026 05:16:48 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61QM9Rht2346120; Fri, 27 Feb 2026 10:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mIDGak
 MTs8VJ81AShx7PtzUFV36j2w8+/s6LjbnzZys=; b=Nda2Pqwv7KCUsOHk34UYKd
 pLYGg7vBXnPuWtjcOAKDB56bcCfyUqXFevQMbY3pk5ni/3OWbxw5W0JmbaJD1BnV
 kGmbUNxmyrQ+96aGmYOMebVPnfydPL/znrQxQeBKVoWf6k+HmvveEm9TioAlBwOv
 FWmaQ7ikySfDGyV4jLT2MKuvnvTVGCC1uNMRugDWEJpJ9rsmFKFSYFfkbkT9yyPq
 yZX6RIoStqr93uECZxwb946UBBm86iqVv4/U9rHWppV1yPSEtndyfaxCtwGkAHsj
 nKyAb5fO7Z5hnNhkimnsfn4REeFfFWj4mZ/KN1/rVvKaQIhjUAbDgD351uYZlfNA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch8591km4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 10:16:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61R7i6fX013438;
 Fri, 27 Feb 2026 10:16:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdyhq33-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 10:16:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61RAGdwA31326574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Feb 2026 10:16:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C518D2004D;
 Fri, 27 Feb 2026 10:16:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 419372004B;
 Fri, 27 Feb 2026 10:16:38 +0000 (GMT)
Received: from [9.39.31.246] (unknown [9.39.31.246])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Feb 2026 10:16:38 +0000 (GMT)
Message-ID: <b2278747-0d3b-4067-be59-cea1846dfa21@linux.ibm.com>
Date: Fri, 27 Feb 2026 15:46:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: fix dumpdtb option
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, milesg@linux.ibm.com, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260225081037.21990-1-shivangu@linux.ibm.com>
 <fa672226-0d73-4b38-9104-0ccb826e7c0a@linux.ibm.com>
Content-Language: en-US
From: shivang upadhyay <shivangu@linux.ibm.com>
In-Reply-To: <fa672226-0d73-4b38-9104-0ccb826e7c0a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA4NyBTYWx0ZWRfX5oEgdxhnVYOD
 WLnX4S3+CqwALmwwLg4ik+QF5wd99WIkpw9fe9zMk8r3NH43kWqLoksApKPC4Asso8jt6V/LOc2
 0Cm5oySegMyA3sbNJWIe0xgYIEF54oMIdkr1kcBIryUKA4B1b/gRE1CM4h+bG0P7ehLSVDjXyst
 MVrCh7gChLv4bWyqlahB54Up1NAt2B285F2/QQ9NDy4/WItU7Y2U/D4VH88aQJSm3uVulzcPHDR
 XuNuzFgip/WgGPAU5B3WhJO8k6zFZSGXmQy4XyM7vhwjtxiahc5cBApc9CyD8bYWyXgChhaodXm
 c/d0CbB1uyF5lQrq6v+bVdkEaIiILkrzdQI/p2rsdO/REu6Qa0aXpntOTRNU2C4g5IsKdlxY+X9
 fFlIp5E2UUQQEAHvP3Qf3re4b3mNLt/BHulMgIBtWSL8nrV1EIXCg3uO8AQmikFru+kTc7dn5tS
 8meZPPNLhp3riuICaCg==
X-Proofpoint-GUID: 8e8ciuJaBoffPhe7_f3fXLHv-S1dyvXR
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=69a16f0d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=d83Mw7aKTBdOm27Q890A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: zHqkBOCWXZmRNr-RxtBD72S859xokjXY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270087
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Aditya,

Thanks for your review.

On 2/25/26 6:37 PM, Aditya Gupta wrote:
> On 25/02/26 13:40, Shivang Upadhyay wrote:
>
>> The '-machine dumpdtb' command line option stopped working on
>> PowerPC/pnv systems after recent design change [1].
>>
>> Fixing this by generating fdt blob in `pnv_init`.
>
> Thanks for fixing this Shivang.
>
> The generated dtb is same as the dtb qemu passes to OPAL, which is good:
>
>     # diff original.dts dumpdtb.dts
>     Files original.dts and dumpdtb.dts are identical
>
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
>
>
> Thanks,
>
> - Aditya G
>
>>
>> [1] 
>> https://lore.kernel.org/qemu-devel/20250206151214.2947842-1-peter.maydell@linaro.org/
>>
>> Cc: Aditya Gupta <adityag@linux.ibm.com>
>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
>> ---
>>   hw/ppc/pnv.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 1513575b8f..9861714ad5 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -1261,6 +1261,10 @@ static void pnv_init(MachineState *machine)
>>       if (pmc->i2c_init) {
>>           pmc->i2c_init(pnv);
>>       }
>> +
>> +    if (!machine->fdt) {
>> +        machine->fdt = pnv_dt_create(machine);
>> +    }
>>   }
>>     /*

