Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84FAC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weWGn-00060H-Hs; Tue, 30 Jun 2026 07:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1weWGm-0005zw-KB; Tue, 30 Jun 2026 07:04:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1weWGk-0005u2-UG; Tue, 30 Jun 2026 07:04:48 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9mvCM1647021; Tue, 30 Jun 2026 11:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=p637Vo
 8GTcPc11xlHFzMbjyb6EiPlAKwGfKxeoz3sL0=; b=OiSub7OIOrTYbCYV9Emyvv
 8g7ZUWWLQJKCLqQK+k94/os22pAjGqYFDCj2OJiwC7slyrsb8+F9jTxcLBHPfisP
 llC6rdvGG45ufevofVrHl6Vv7jOaTzsg5Uk+GFw7wlorFnrUAHmlYOMKZQtWjRyJ
 oPaU57mfBu5TZ2tP71yl5Ll99kIqdcxrLJRwWgPEtNbRLStB1Y2pu9fEHfwrQ/2Y
 XI9cGOqAQR/HMrfatFNB6sZojlqkgpMQMqBtVek5/+6ciOJwI/nfas+HQi/wFAcu
 +vx1EjJQSavN8//D/X/S9j7CxCOveGOruE68nNJzcVHmwMMkkzz7Skhmd+8uFFqg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5pa6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 11:04:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UB4edo007595;
 Tue, 30 Jun 2026 11:04:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w1wx2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 11:04:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UB4bY848628116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 11:04:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B28BD20043;
 Tue, 30 Jun 2026 11:04:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 588B420040;
 Tue, 30 Jun 2026 11:04:32 +0000 (GMT)
Received: from [9.123.10.203] (unknown [9.123.10.203])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 11:04:32 +0000 (GMT)
Message-ID: <b489fbd0-a1f8-429a-90f0-9ed950cfda1a@linux.ibm.com>
Date: Tue, 30 Jun 2026 16:34:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] tests/functional: Add remote interrupts test for
 PowerNV
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20260629110411.3051274-1-adityag@linux.ibm.com>
 <20260629110411.3051274-2-adityag@linux.ibm.com>
 <71cffeef-3398-44e6-8e13-130266e789c1@redhat.com>
 <akJXAebIn7BHhPRS@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <99726741-229a-4230-b19e-63a7f27ba9f0@redhat.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <99726741-229a-4230-b19e-63a7f27ba9f0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5OCBTYWx0ZWRfXyOn2n8yBwHxz
 aphjvogEmwz5lMG+7nuSeKE7X4AYCGM8xNfjjzIKgNvUIhy9ygEfe23OiDXBDYhH2Tv0ag15QxG
 4Ph+ERcE2+KiGmfmdOxyOXjv1TQtAr8tMWPxog/JsVTFWq8rFrGWqpnGOIprWvWR5LW4UDyEjlz
 kD9i1i+XvSomRXrgZrg88LD8dOm5f6mwmvhGLWcKLd0QwKDz7FqE0bFE68w5iKMfz6ImQ3T0rHO
 0tscuBQHfGWhMZJS81GISO2ve9MuS2DC5zZh9i8sxfCkgE/m3WAnNSzYi9PB1RJUHQvaC6vWyBj
 ks9H74iTX+3y42FIThieeoRAIJlgwXvqh1gbbnbmMv1ggi7/ywwczMIOOaWIitJvr5/T7BrO3as
 MFYnaoC/uuwCKUBGECX+H9+zSWzrIAtz0jFdHEYsChJAUp9tN1QxG84LwWk416/M1FuNSIjNGmk
 tU9zY9TvPyIaNJz6rvA==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a43a2cb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=iwaJfe35vvhaYKSfLwYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TpDGdy-qLs_HN0XJ2IQLCzQ29TShOsb3
X-Proofpoint-GUID: 1X1mrKOCAymXUolzHQA1BeY_br-2Yc_s
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5OCBTYWx0ZWRfXzmcXD2ltV6QP
 cROUd6M6pBQkb6Qb1vU2YTCKNRPT0JMKGhTTW/v5vkUbGNemSI/UnsAOhI32iYLO5qgZZCPQXRD
 yafCpn1XUj4/kdtSPBL9xVVUmYwOMd0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300098
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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


On 29/06/26 20:13, Cédric Le Goater wrote:
> On 6/29/26 13:39, Aditya Gupta wrote:
>> On 26/06/29 01:20PM, Cédric Le Goater wrote:
>>> On 6/29/26 13:04, Aditya Gupta wrote:
>>>> In the past there have been hard to recreate issues where XIVE changes
>>>> cause qemu crashes due to multi-socket interrupts such as in [1].
>>>>
>>>> Add a functional test explicitly to test whether remote interrupts 
>>>> work.
>>>>
>>>> The test can also work as additional boot test for multi-socket boot,
>>>> initrd boot test, as well as a check for e1000e to be working in 
>>>> powernv,
>>>
>>> you should consider moving to a more modern nic model: igb, which
>>> has sr-iov support too.
>>
>> yes, can do. with igb i see multiple irqs, so test will have to take sum
>> of all rx irqs, and compare:
>>
>>     2026-06-29 17:00:46,288: cat /proc/interrupts | grep eth0
>>     2026-06-29 17:00:46,391: 135:          0          0 0  
>> PNV-PCI-MSI 2416443392 Edge      eth0
>>     2026-06-29 17:00:46,393: 136:          0          6 0  
>> PNV-PCI-MSI 2416443393 Edge      eth0-rx-0
>>     2026-06-29 17:00:46,394: 137:          0         14 0  
>> PNV-PCI-MSI 2416443394 Edge      eth0-rx-1
>>     2026-06-29 17:00:46,395: 138:          0          4 0  
>> PNV-PCI-MSI 2416443395 Edge      eth0-rx-2
>>     2026-06-29 17:00:46,397: 139:          0          4 0  
>> PNV-PCI-MSI 2416443396 Edge      eth0-rx-3
>>     2026-06-29 17:00:46,398: 140:          0         16 0  
>> PNV-PCI-MSI 2416443397 Edge      eth0-tx-0
>>     2026-06-29 17:00:46,399: 141:          0          6 0  
>> PNV-PCI-MSI 2416443398 Edge      eth0-tx-1
>>     2026-06-29 17:00:46,399: 142:          0          6 0  
>> PNV-PCI-MSI 2416443399 Edge      eth0-tx-2
>>     2026-06-29 17:00:46,400: 143:          0          4 0  
>> PNV-PCI-MSI 2416443400 Edge      eth0-tx-3
>>
>> I feel e1000e suffices for this test, should i stay with e1000e or use
>> igb here ?
>
> or use a single cpu per socket config. Which seems better for the test.


The test uses single cpu per socket, since i have `-smp 
4,sockets=4,threads=1`. Was this what you meant ?

Thanks,
- Aditya G



