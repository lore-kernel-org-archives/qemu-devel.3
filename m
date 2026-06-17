Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1562CD98EE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjfx-0001tq-2x; Wed, 17 Jun 2026 02:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjJ2-0004O6-Bg; Wed, 17 Jun 2026 01:59:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjJ0-0007Yc-U2; Wed, 17 Jun 2026 01:59:20 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLmdUZ2746645; Wed, 17 Jun 2026 05:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TNBHPB
 u6FVSPkX45PYGSq/dMq/VZnd5wBbvFt7inwes=; b=BIntQSC90pkbTUjRPkGEJF
 xhcJkPTaxxRcnf+vg/OGXMnx7yZyzs8bg2ADAG5AGk/ZkSc7Oa5TFtN3jz+DfxvK
 DNDoyFv4MvLeUjoIuKOaUUN0o9PQVlA2bk5zZgKtySPhcLTm3CsJQDqY+MTL55GL
 u2BJQN3vgmWSMmrlax++zW4IlmYXIIdD1pDGyByFCJ81jWZsZCvd+5t5fkjP4+gH
 nUxYbrKQZEe8183BWwle1OZEJX75ymD9P0KumSP4gzzeVbJAH8CRtIchS9OImsA2
 1+lUWvyp01sgQrVNGYKe0vgQ64M68aI7aaWwNlmAhTn/jCDdb0SlpajESxz9iRPw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqthej0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 05:59:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H5neYh005738;
 Wed, 17 Jun 2026 05:59:07 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudva9r99-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 05:59:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H5x5H036438738
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 05:59:05 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8325D5803F;
 Wed, 17 Jun 2026 05:59:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3809858056;
 Wed, 17 Jun 2026 05:59:01 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 05:59:00 +0000 (GMT)
Message-ID: <5ceda019-6ec5-4743-95d8-249702d8776f@linux.ibm.com>
Date: Wed, 17 Jun 2026 11:28:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] qtest/phb4: Add testbench for PHB4
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-2-saif.abrar@linux.vnet.ibm.com>
 <af9FJIWPOH5Bej7y@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.ibm.com>
In-Reply-To: <af9FJIWPOH5Bej7y@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 5B6iGCaALcMiMEft7nA2zF5RmPOElAIh
X-Proofpoint-GUID: kD2hgG5gIoBnEvHU065kapTLufjSu6Xm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA1MSBTYWx0ZWRfX0XhnRYLqzcur
 KN0vMoK2GQABVHg1Evdw0NDXpe4CyfET4SqJ5iuAcOYp3pcmUYEGIUfyGvFo52qXu5FGDUV7q6v
 OZPRCS93LIjpAnhiK11DuhEUqkOz5cMWWqfgkCxcCDYQBVQaUYBD/BXOC9OoD8DuJUSed7XxaLT
 DuzX4tg/UEoc+YymwJsu52JMnZ3a7d1KBC+UK1XyDR56yA/QkX9tvw7zz7o5DoGaQ0qwQ5kPibB
 bZ5D07IiilKi7NkrVIrZyZetxDoQvfd+XPYt3OGLicyMc7de0EecKk2J3PZIFAH8kgPlwntUHMF
 8xdajr7DNcjZ8V6mT3Wu71DFtC5JJKpCAcMW7PJLJBx+QEO9Xo/NFaQ8i8+W5xYq1uHszP18dAN
 dhcjSt4zCZXax2pZlOfn4uCTO+ICmGyddsGnb12AtoUxc86H752N6Nh2RtAmZWuZMsRO4r1zJR8
 sa6iNcnJFQT3GSPlulQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA1MSBTYWx0ZWRfXwpX4zQ3PROLf
 ig2HZYrQex2x2UJ0NhfSX8tOK59z7+QA04j69yg3pAPyzNevjVXpLlMqQOLl11I6SunE8X6IPFl
 +R3aLeQvLWiJrv1NcyhP+/PT7fWnCrQ=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a3237ac cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=zjctwEK5lmB8oGVZkGgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170051
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jun 2026 02:22:58 -0400
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


On 09-05-2026 20:03, Aditya Gupta wrote:
> On 26/03/05 12:09AM, Saif Abrar wrote:
>> <...snip...>
>>
>> +#define PHB3_PBCQ_SPCI_ASB_ADDR      0x0
>> +#define PHB3_PBCQ_SPCI_ASB_DATA      0x2
>> +
>> +/* Index of PNV_CHIP_POWER10 in pnv_chips[] within "pnv-xscom.h" */
>> +#define PNV_P10_CHIP_INDEX      3
> nit: this is unused as of this patch.


Removed from this patch.


>
> rest looks good to me. i had comment about using p11, but noticed none
> of the qtest having it, maybe that can be done separately.


POWER11 uses same PHB5 as POWER10.


>
> Thanks,
> - Aditya G


Thanks,

Saif



