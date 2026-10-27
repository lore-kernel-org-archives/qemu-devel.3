Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A87606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hkIyWqPp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLdhA-0007m4-Lx; Tue, 27 Oct 2026 05:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1xLdh1-0007lL-Jm; Tue, 27 Oct 2026 05:42:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1xLdgz-00016r-Mb; Tue, 27 Oct 2026 05:42:07 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5ijn04073455; Tue, 27 Oct 2026 09:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5EztWB
 aL5yLa2a5YVOc6++1LhikRB3TGbFC03/BequQ=; b=hkIyWqPpUwW5sq21Va7utp
 ZdqvrAs0gR/w3QWsonnZ6dWY8edKGlRkhQ/kqaUTj+0LxOjrBlKpCEdjOw+LDO8B
 tLr4LRk3ziZGLL+IyB/pPttOIGNc8iPiuioir/HkuYrkztktrCyqHsYFcv//snwD
 buDHdp+B/Re0JAxx7leJxT6wFtfJUAXtEJl2TSTKRnKGYC42JLv5vV1rTKjDUzRW
 QxTI0VDYPOYgebxYvW1vigywgmYIiThDbuqVk5lcjzA3774SC8rzJUprn+2/DlUj
 9/jtwsvVgTWODK8coszi6WMP6hyW4gijwwFJZDZZhTlW1/Q7xsJ048eVLq1My9Jg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbsxn8s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 09:42:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5Z0nS3747118; Tue, 27 Oct 2026 09:41:59 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh9py9v7r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 09:41:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69R9fwSJ6029922
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2026 09:41:58 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BF6F58069;
 Tue, 27 Oct 2026 09:41:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9453558056;
 Tue, 27 Oct 2026 09:41:51 +0000 (GMT)
Received: from [9.43.105.244] (unknown [9.43.105.244])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Oct 2026 09:41:51 +0000 (GMT)
Message-ID: <aa3bcc6f-d528-4ab3-b20f-f8df7977f160@linux.vnet.ibm.com>
Date: Tue, 27 Oct 2026 15:11:48 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/9] pnv/phb5: Add reset logic to PHB5
To: Aditya Gupta <adityag@linux.ibm.com>, Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
 <20260831123005.1485518-3-saif.abrar@linux.ibm.com>
 <aqVHph2Un4WtjRms@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
In-Reply-To: <aqVHph2Un4WtjRms@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzNiBTYWx0ZWRfX4Wke9/g2fhgX
 8/+qTzgS1GHcn/Xa9m14Q9CRodPCZUlpKRxZV/4b+keiRaiLErm99poUXRW9OyOKkUQIkvRaJL1
 jgrtmE0IYGJqt1trLnUt8RNFS9GFT4MlxN1gitGR3KVgl76hLUrhhKj9lTvIxhq2pM4KSdlNTP1
 KZLCjPv1pd2aBZkuP7AVJweWce3FCDXPANdYuk6rbpnAvVzIoUCpcBlr7Mb+hPjWl0Ol5FTfHrK
 5mJGaBpI70bKlCGj6QoI7Ci1tiueIizUvDnwXaDijwxkruabrO2l1Hvjz2YCUGE6KOVnvnYTI2x
 urcsR1VsNZApMZJwp+DjuIoFMu4RkaLzYhxQwDgMRA3rh0OACBcMnzWSU+BfyPfHN3gCFfHhtEB
 nC9JQ536meelzT5ze7HexHIKsGN/5ESsLg/7uM7d1nd2OrjyNVz6F/mozlKu8TjHWV38GG8oLOs
 RuQp6kHh3DtuDlmy8FQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzNiBTYWx0ZWRfXxO9bekRKeKkU
 vYsJwGrmjzM4xgkDwz06ByqTEh/1qK8uzGDbNE5GfO2757hWOXMKDdrF5RBTWOgnx/zDxXItIsL
 ufUM2SYCCl/hSFuyd9FLxIfPoa8HhWY=
X-Proofpoint-ORIG-GUID: voO6RLe36qDvWJCY7y2iMXpcaOrusNL4
X-Proofpoint-GUID: tIItwis-6uEkqJ6tJsTwcNwubQoCwQwT
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae071e9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=5DxDo9H3wAwLEOz4OLEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270036
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks Aditya, updated in v7.


Regards,

Saif


On 12-09-2026 18:09, Aditya Gupta wrote:
> On 26/08/31 07:29AM, Saif Abrar wrote:
>> From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
>>> <...snip...>
>> --- a/hw/pci-host/pnv_phb4.c
>> +++ b/hw/pci-host/pnv_phb4.c
>> @@ -1,7 +1,8 @@
>>   /*
>>    * QEMU PowerPC PowerNV (POWER9) PHB4 model
>> + * QEMU PowerPC PowerNV (POWER10) PHB5 model
> minor nit: maybe leftover, no more true ?
>
>> --- a/tests/qtest/pnv-phb-test.c
>> +++ b/tests/qtest/pnv-phb-test.c
>> @@ -17,7 +17,8 @@
>>   #define PHB3_PBCQ_SPCI_ASB_DATA      0x2
>>   
>>   /* Index of PNV_CHIP_POWER10 in pnv_chips[] within "pnv-xscom.h" */
>> -#define PHB4_XSCOM              0x40084800ull
>> +#define PHB5_XSCOM              0x40084800ull
>> +#define PNV_P10_CHIP_INDEX      3
> this is index 2 now, after removal of p8e/nvl

