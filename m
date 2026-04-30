Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9EDFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITp1-0006Sa-5m; Thu, 30 Apr 2026 12:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wITol-0006PM-4M
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:01:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wIToe-0006dI-Kl
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:00:41 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UEd5VD2932084; Thu, 30 Apr 2026 16:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QshvW5
 LIMMYO9Qy5MvI9WO+6U2DnJmm9L7L3fE4iSn8=; b=V9U8uxwBCW0IJFGx+64DwT
 sqleY4zY79OLMfCOgYTel/zNZjnmODaaGtG3q8riSDcOxv5xCV5tqXp76iZIiKyR
 wssEZJMFJepXQjOKLpknx2MV+riXcOIeKDg2+72ngC31EBJJDwz6QxSr4diyTnC6
 83j1qCsvOz7fr/SnyfFX9iKtWek4tQ8KnBJRwXBHjc4jXt5plgrP94cghr/Z6Pko
 5lSY2BYXxin8QzXMA3som6EHZ0JEAZ9RYpCkbF4D30QbWpoXHU2nBu/uT9WZrJwY
 2y2DCWZKxLNzWDGskFoX+iHpeEjw8PLAEzhazuG6Hysn+9OrV93C48XC/OJTxIog
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rgmxj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 16:00:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UFrneP015780;
 Thu, 30 Apr 2026 16:00:37 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamykfdq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 16:00:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63UG09Ud26411760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 16:00:09 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A2DC58051;
 Thu, 30 Apr 2026 16:00:36 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C3A55805E;
 Thu, 30 Apr 2026 16:00:36 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 16:00:36 +0000 (GMT)
Message-ID: <b7e36906-04f3-4018-8e02-338567f488a6@linux.ibm.com>
Date: Thu, 30 Apr 2026 12:00:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tpm_emulator: Reject a buffer size larger than
 what was requested
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com
References: <20260430142337.2104726-1-stefanb@linux.ibm.com>
 <20260430142337.2104726-2-stefanb@linux.ibm.com>
 <3a981e61-67d4-45ee-8bb8-efce9c8849d0@linaro.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <3a981e61-67d4-45ee-8bb8-efce9c8849d0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EZpjh9zDI-0hUlrp16hMSouDWR5Z3IPH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE2MyBTYWx0ZWRfX+4IvvZ9420kc
 qyY9Xuk1CQsHGj2NtyjbrNqAFCsMW6KobgWz/jXIjDJHtu5UxuhhQ0XYHv+jHtV2Dk8WRio6dQn
 06Vqm0Gopa2RQtf8ZuvrJSAYZj4rMUFWF4lmx5YSbvc5ag+/EK/nhaQXKtEgE6Ip4FTPB0Jw/59
 OAVrHS9ix/6r3TpYhg4p59Gw1thKnBRKEXq8D697IuNhbqfIubM8BCCxb9f/h89YlFMIKUE27Db
 kqKwtpDVwQYrT5XKzc3+grb5oP43VM038CCmBUoxTOE4PECZSd98Jqi2dnAYSUbLclgqmLYn8+R
 LZhXZh7O8t/UEpb3vWAUkSxCE8JpIBzm3G1QmX6B+iwOQAECpbR6r0pYWQrBlZt4piYK8i04h02
 wv4QI/iOX3SbvzLN5l6Xsw0aDhW5qLRPEK4P2DJxyLbg1gy2MLNdNIEZ77sLdJbZqgg7HXCBtWm
 omv1Cc5HQ3xdnmQ/ccQ==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f37ca6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=KKVpSTfhNPv512mO7v0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: EZpjh9zDI-0hUlrp16hMSouDWR5Z3IPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300163
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



On 4/30/26 11:39 AM, Philippe Mathieu-Daudé wrote:
> On 30/4/26 16:23, Stefan Berger wrote:
>> When the TIS, SPAPR, or CRB frontends negotiate a buffer size with the
>> TPM backend, then the tpm_emulator (swtpm) could still adjust this size
>> of the buffer to within bounds supported by swtpm+libtpms if the chosen
>> size was outside the acceptable range. This could theoretically lead to
>> the TPM 2 using a bigger buffer than what was requested and memory
>> allocated for. In practice this would not happend since the requested 
>> size
>> of 4096 bytes for TIS and SPAPR and 3968 bytes for CRB are in the
>> (currently) supported range of ~2.5kb to 4096 bytes. With PQC support
>> the range will have an upper bound of 8kb and a lower bound that will
>> support the (pre-PQC) CRB with 3968 bytes.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   backends/tpm/tpm_emulator.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
Thanks. I changed this also for v3 to require and exact match of buffer 
sizes.

