Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70E9CAC5AA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 01:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0rsX-0007wm-FW; Mon, 22 Sep 2025 21:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1v0rsT-0007vZ-Nz; Mon, 22 Sep 2025 21:31:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1v0rsI-0003j1-BR; Mon, 22 Sep 2025 21:31:32 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MILXqt027350;
 Tue, 23 Sep 2025 01:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9wVzPJ
 x2EbSMWRnu2BW5jh7MAdOJodEQMnDMPVZJbuA=; b=pBvSfSAQJFd5+cZyVii+HC
 V1gD1ftKyy0aE5LEpojuCwq7g4W0LHpPfgREuzTN/1LnzVlmgVWCunpRuIKEnYDN
 z9Ks2TLok2ga15/gwCdXUdVIonrqj7zOMUwka80LA7R70o6NGR2hLrWxSDyR7MOB
 JQnn4hkUs3UQAGV58jVQvyFB2nlt449VRRUAnt9R7tpJtjpTkCS/VxkWAsed3lJC
 mH8b/v32CpCnSMXDNjL8WKf3OF8adBY0Ywh1vUwfiIk3zQS0bT0WYehS0XJicbqh
 ENvBANjJi+Os9MAKYesu6CGBKB1htvB5vXdgt/cLVrtPhBhebTVPVEv4oxGqRngg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwydjp5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 01:31:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58N0qQDf031129;
 Tue, 23 Sep 2025 01:31:13 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49b9vd1vk3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 01:31:13 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58N1VCu627656744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Sep 2025 01:31:13 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E75C858058;
 Tue, 23 Sep 2025 01:31:12 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7E2A58057;
 Tue, 23 Sep 2025 01:31:11 +0000 (GMT)
Received: from [9.61.109.241] (unknown [9.61.109.241])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 23 Sep 2025 01:31:11 +0000 (GMT)
Message-ID: <e1a0d95d-7a67-479e-ae0d-d840ac207636@linux.ibm.com>
Date: Mon, 22 Sep 2025 21:31:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/28] Add boot-certs to s390-ccw-virtio machine type
 option
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-2-zycai@linux.ibm.com> <87ldmcz1so.fsf@pond.sub.org>
 <aMvE7Phd7sLvgj-J@redhat.com> <87348kywgv.fsf@pond.sub.org>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <87348kywgv.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d1f862 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=ea03lzvqYZLvFwxVDnUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NbieVnX2h2U3Tf3BdFu1thW7Uad6TCVi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfX5IbEKS2Zc4Bn
 9qLbUIgsfnvfXYk/6GvuXfeJip3Rbv7SHE5BfTisy75GcI4oEqmfl6CrlyhRfm8aftRspi4x5mt
 qoc44wk7csfeMz+vLCRJ9LMqZndP1mI6qVRQ/10XTbjJXUYkRSBd1/b/OtwU3+x6SbLrQJCWx9j
 MPlj8NASGk2AucBhw20qNjm00zxm4HyxThHwOIs+KXkl/MEunj6ocC+IDcs4nQwah0pGy1e4OTL
 x93/0QnVyolTX7P7886Plr4jPtCbBp/++A5QDQcnACJWWMebEGTNt1b0tIW4NjvPGQV3aWHBfNh
 99qQSZ6TX56tYZcBcRwmr8Pn8TSSQCEbrueq/Ie3UseVOTTbaaGIyR3RFVuEEQgR83Dv13fDOYH
 KjTZeNQL
X-Proofpoint-ORIG-GUID: NbieVnX2h2U3Tf3BdFu1thW7Uad6TCVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/18/25 4:51 AM, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Thu, Sep 18, 2025 at 08:56:39AM +0200, Markus Armbruster wrote:
>>> Zhuoying Cai <zycai@linux.ibm.com> writes:
>>>
>>>> Introduce a new `boot-certs` machine type option for the s390-ccw-virtio
>>>> machine. This allows users to specify one or more certificate file paths
>>>> or directories to be used during secure boot.
>>>>
>>>> Each entry is specified using the syntax:
>>>> 	boot-certs.<index>.path=/path/to/cert.pem
>>>>
>>>> Multiple paths can be specify using array properties:
>>>> 	boot-certs.0.path=/path/to/cert.pem,
>>>> 	boot-certs.1.path=/path/to/cert-dir,
>>>> 	boot-certs.2.path=/path/to/another-dir...
>>>
>>> Given we can specifiy a directory containing any number of certificate
>>> files, is the ability to specify multiple paths worth the additional
>>> complexity?
>>
>> The typical scenario would be point to somewhere in /etc/pki
>> for some globally provided certs, and then also point to
>> somewhere local ($HOME) for custom extra certs. So IMHO it
>> is reasonable to want multiple paths, to avoid copying around
>> certs from different locations.
> 
> Thanks.
> 
> Preferably with BootCertificate renamed to BootCertificates
> Acked-by: Markus Armbruster <armbru@redhat.com>
> 

I'll rename it in the next version. Thanks for the review!


