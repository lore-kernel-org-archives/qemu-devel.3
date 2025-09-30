Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5107DCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rmj-0003nh-FH; Tue, 30 Sep 2025 00:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v3Rmc-0003KC-B9; Tue, 30 Sep 2025 00:16:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v3RmR-0001Wx-Oh; Tue, 30 Sep 2025 00:16:09 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TLHQ6n015274;
 Tue, 30 Sep 2025 04:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8Eoore
 pFHPChJfE/9lr9XXlaQsKVarCtgW9UlgihWck=; b=HY3G30cHSJJtAE4HTu8obQ
 742BVYI2UbndU2Y7QV7Bqsapg5LlEPxqosGu5xFBDsGoHOVQE2XltzMZCPcAp3Ea
 BNfcOFEjzybH/qYzP7M55jrZxaJjPUvXdL9nYzD2seq9+8GVAXz16amEjxZg99KN
 7i6laYUsjlH/PGaCUmKwXlW4i8+p0X8qjV08mvdS9VBfaskMptI6ell0Gl7zfPTN
 qN7DSRuXDXw7sB0JCA9sSfNX+TlmAKwPkDPNV68aqtCxqkZD7J0SxFgmg9lG3YJs
 8Spz1zqPgqrRVJFHqkfDTmYW68zEmUGNk/rxQISSyPs4SW0uuDrhHBE8OB7tSjUA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7ku6d5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 04:15:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58TNvrp0020074;
 Tue, 30 Sep 2025 04:15:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8s1pcx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 04:15:43 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58U4FVIQ14156536
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 04:15:31 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75F5558052;
 Tue, 30 Sep 2025 04:15:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9664458045;
 Tue, 30 Sep 2025 04:15:39 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Sep 2025 04:15:39 +0000 (GMT)
Message-ID: <b41baece-09d5-4d22-8117-01a6a32099fb@linux.ibm.com>
Date: Tue, 30 Sep 2025 09:45:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 18/27] hw/intc/xics: Add missing call to register
 vmstate_icp_server
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Fabian Vogt <fvogt@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Gautam Menghani <gautam@linux.ibm.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
 <20250928192629.139822-19-harshpb@linux.ibm.com>
 <7f2acdb2-040d-4056-bcfc-8264ca000cd0@tls.msk.ru>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <7f2acdb2-040d-4056-bcfc-8264ca000cd0@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=68db5970 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=jaIMoFHOYy8bIhQyePYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-GUID: 9AEODzAnQY1P3mh-j8dXDMzSmecFo5FT
X-Proofpoint-ORIG-GUID: 9AEODzAnQY1P3mh-j8dXDMzSmecFo5FT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX8iumtXt9XjHx
 BHGvQ+dyeVLagJ9uAWSn3Z+GI8Vc1ufgLOuDNFLR9LWOQQUgs2I0bnoHuGKcJHDVOBACXC0Gvvz
 T/0yyTjMwUewKT26inno6RB1v/5C3LZY4tuXsHQPN1HSchST0gIToYA0eaTrFuamNDC8GB0f2wQ
 qL9hKd4Lcr1VSNSojhvpydJnMsZCqgkhzNkJQTu8ZFzrSKU1Ra2ugo9vgwZak513Uhm6vjuFBpA
 7khop8fEwbX8o/NEYo0KVH3nSYUciVadZRy8yzAzb8+Ce9MwjoXrZMm4pLs5SBd3URmzY+rVag+
 qysI3DBhtXvV092QMPrifnHazRjTcexkjD4Ws2wp36EbKlgjsnfITVeNMek+47SpgYalOtORuXr
 QrSmd7xuU39ZaK9uJAYsYbqg/yqBEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Michael,

On 9/30/25 01:02, Michael Tokarev wrote:
> On 9/28/25 22:26, Harsh Prateek Bora wrote:
>> From: Fabian Vogt <fvogt@suse.de>
>>
>> An obsolete wrapper function with a workaround was removed entirely,
>> without restoring the call it wrapped.
>>
>> Without this, the guest is stuck after savevm/loadvm.
>>
>> Fixes: 24ee9229fe31 ("ppc/spapr: remove deprecated machine pseries-2.9")
>> Signed-off-by: Fabian Vogt <fvogt@suse.de>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Link: 
>> https://lore.kernel.org/qemu-devel/6187781.lOV4Wx5bFT@fvogt-thinkpad
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Link: https://lore.kernel.org/r/20250819223905.2247-2-farosas@suse.de
>> Message-ID: <20250819223905.2247-2-farosas@suse.de>
> 
> I'm picking this up for both 10.1.x and 10.0.x stable qemu series.
> Please let me know if I understood the previous discussion in a wrong
> way and it should only be picked up for 10.1.x, but not for 10.0.x.

It's applicable for all releases where the commit specified in Fixes: 
(24ee9229fe31) is present.

Thanks
Harsh
> 
> Thanks,
> 
> /mjt
> 
>>   hw/intc/xics.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
>> index d9a199e883..200710eb6c 100644
>> --- a/hw/intc/xics.c
>> +++ b/hw/intc/xics.c
>> @@ -335,6 +335,8 @@ static void icp_realize(DeviceState *dev, Error 
>> **errp)
>>               return;
>>           }
>>       }
>> +
>> +    vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, 
>> icp);
>>   }
>>   static void icp_unrealize(DeviceState *dev)
> 

