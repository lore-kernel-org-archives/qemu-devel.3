Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07595FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 12:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI3nw-0003YA-Jh; Wed, 29 Apr 2026 08:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI3nn-0003Wx-3V
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:14:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI3nl-000884-2T
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:14:02 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TB5X7b2943552; Wed, 29 Apr 2026 12:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hnhvPm
 2yU+88WK5l/4Czffc1JWL6RpD5SnnsG8wrBfM=; b=VeHF7Kcn3JK1jeFc1WdeWt
 yU9TJwsL900HeLTOG3W7Uyx29MYVQ8bEJo7EgmOvAdWvQ6fB4xXvgOrKtz9cTJBg
 101nQXKDe6UahUQpjLXZzKuXpy5ZUX1QPwkUnaTJ4HafgtHg7kFP1B+VaqD1yaNX
 LlcvpAwgGyoM/+oiBJIW9GzIujvBEKhi1lnuAoBDbTLFm7mJ3ALgJcPJhwNo6vlE
 aF+FXMzLyH0sQ2O+hTGgQAbu9MqhveVP7SPdzObeN5Zr1VYSKWkcoX0a1+tz4gUr
 2TzqCBGEzMbI13Xf/SANBlPhNRI6pXHZlCYRRC3TtKlPNu4oo1fotCnFP7d8VhNg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb5abr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 12:13:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TC8jol002147;
 Wed, 29 Apr 2026 12:13:56 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avx8vs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 12:13:56 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TCDt8O32244270
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 12:13:55 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D5EF58066;
 Wed, 29 Apr 2026 12:13:55 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E28DB5804B;
 Wed, 29 Apr 2026 12:13:54 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 12:13:54 +0000 (GMT)
Message-ID: <4208e277-05eb-4bb7-af42-62e255e281f8@linux.ibm.com>
Date: Wed, 29 Apr 2026 08:13:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] tests: Implement aspeed_i2c_restart to reenable
 selection of master
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
References: <20260428130718.1325177-1-stefanb@linux.ibm.com>
 <20260428130718.1325177-6-stefanb@linux.ibm.com> <afHsM-XJk_yq54aw@fedora>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <afHsM-XJk_yq54aw@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f1f605 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=ZwfPkkqzTLwIGs-ka7UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEyMCBTYWx0ZWRfX0zLicJcaUhoF
 Fw+h/zuCrjboO2PI0cYDt0AxM+4ouKrWZ/rVSyqcj5yl2knJpIjK+JGoozPqacJjv/4IpbXY6V2
 d9yKeT0UHVHrGNmRhQJX8hY08kGcjijvvYex4PJ3Z8XrXd5ZwKzSsVv/RkjzZkk+xjaGXgG8nwX
 YOUMz5iJufoMOqa1dVGUQvysA++H7W24de+1ttcX5iuC1qEmwXy/grtNu789wHIYCXHjT9OhHVp
 hQgM9tZE/PBFCX80AgHiJ+vfHpBncHz2M0PuQX6CR/hLUrUO3d5jh9AfjgWC6ejYUbE8U+v5i5r
 fNl/kp6rpTNWANUScorABYLqkUeVqQNxu7ZuspAPLO+9cqG+rfqs2ukTX6KFQegrqjoj+zL/Vk9
 8t7+ga+9ioZAY9xlN/e0+L+8iRWcji/0iCZ814fiC2KYcHeoNP88x4ynfvvodgfWTR/4a0oQ89S
 pMyQvd/wPpgZTT+DP8w==
X-Proofpoint-GUID: 0a0nlJHBNRjv5PyTPNoWOgEb9CmOfVFc
X-Proofpoint-ORIG-GUID: 0a0nlJHBNRjv5PyTPNoWOgEb9CmOfVFc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290120
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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



On 4/29/26 7:32 AM, Arun Menon wrote:
> Hi,
> 
> On Tue, Apr 28, 2026 at 01:07:17PM +0000, Stefan Berger wrote:
>> For some TPM  I2C tests it is important to be able to reenable the
>> selection of the master. Implement aspeed_i2c_restart to enable this.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   tests/qtest/qtest_aspeed.c | 8 +++++++-
>>   tests/qtest/qtest_aspeed.h | 2 ++
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/qtest_aspeed.c b/tests/qtest/qtest_aspeed.c
>> index f6da9adea9..13934cc660 100644
>> --- a/tests/qtest/qtest_aspeed.c
>> +++ b/tests/qtest/qtest_aspeed.c
>> @@ -15,11 +15,17 @@
>>   #include "qtest_aspeed.h"
>>   #include "hw/i2c/aspeed_i2c.h"
>>   
>> +static int once;
> 
> can we make this a boolean?
> 
>> +
>> +void aspeed_i2c_restart(void)
>> +{
>> +    once = false;
>> +}
>> +
>>   static void aspeed_i2c_startup(QTestState *s, uint32_t baseaddr,
>>                                  uint8_t slave_addr, uint8_t reg)
>>   {
>>       uint32_t v;
>> -    static int once;
> 
> Can we check if the A_I2CD_MASTER_EN bit is set directly without having
> the need to store a global static variable? For example:
> 
> static bool is_aspeed_i2c_master_enabled(QTestState *s, uint32_t baseaddr)
> {
>      uint32_t reg_val;
> 
>      return ((qtest_readl(s, baseaddr + A_I2CC_FUN_CTRL)
>              & A_I2CD_MASTER_EN) != 0);
> }
>>   
> and use it here:
>>       if (!once) {
> if (!is_aspeed_i2c_master_enabled(s, baseaddr)) {
> 
> 
> for restarts, we can directly write to the register
>    qtest_writel(s, bus_addr + A_I2CC_FUN_CTRL, 0);
> and the subsequent call to aspeed_i2c_startup() will handle the init properly.

Yes, that's better. Thanks.

> 

