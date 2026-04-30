Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68D0FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 06:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wILIY-0002a6-AS; Thu, 30 Apr 2026 02:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wILIV-0002Xd-QB; Thu, 30 Apr 2026 02:54:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wILIS-00042O-4h; Thu, 30 Apr 2026 02:54:54 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TLdfC73991826; Thu, 30 Apr 2026 06:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6aeizv
 b4lydQmRbpkqxznmiUtvccayBrX1xDy6Wt+Ks=; b=GUF/tGeEmSSoPZghab2MUG
 ae3mwDNcIVfSmzB3E0E+rmMPL/QHzC3ova8iuAna/slvc7XYh0gHRlP7XbNwvWGG
 aAslFrgCtatC6UEZgSGcHpcn4mhl+KbBEIf4FFusyHJXomOCoo3REfki+8TALdVP
 D+gdw0yFZ7AbuAFSi5U+4i3at1ClbwHEuP/jU53+r3ZNPBB5Rlo6suN5InRpM5QX
 EM3AnYFEdHCS08YBq1MsRnqw06WcABNTIO7smfqKJvYSMNWVdIVZwlanv/Ll9eSh
 tY9R0tVjbxK4WfYfbT5a5AckVMhbHeEapsHL6GZc4jjCgpiNFDSF6mdqQGidjQoA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44xeyc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 06:54:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U6s0Sk002279;
 Thu, 30 Apr 2026 06:54:47 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqhx5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 06:54:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63U6sk0S24511074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 06:54:46 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D77E58059;
 Thu, 30 Apr 2026 06:54:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFDCD58043;
 Thu, 30 Apr 2026 06:54:42 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 06:54:42 +0000 (GMT)
Message-ID: <7629e08d-7d9e-496b-8310-27a075d52430@linux.ibm.com>
Date: Thu, 30 Apr 2026 12:24:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] ppc/ppc405: Remove CPU
Content-Language: en-GB
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Glenn Miles <milesg@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Chinmay Rath <rathc@linux.ibm.com>
References: <20250110141800.1587589-1-clg@redhat.com>
 <20250110141800.1587589-4-clg@redhat.com>
 <1c294e9e-8774-4e3c-874c-d64bcc0f7ce7@linaro.org>
 <08932dd4-f4d2-4eae-b237-2975c820cec1@linaro.org>
 <D71LX5ZNBHSB.9MP9IHEN5WLU@gmail.com>
 <bd1941e9-bc24-4bed-9f27-3020ae6ab54d@redhat.com>
 <52d11eed-751c-4272-b31c-c14f13a5c829@linaro.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <52d11eed-751c-4272-b31c-c14f13a5c829@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: -FRDm6JcIeU6BG75i1RkyaewsYzsHsBA
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f2fcb8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=NEAV23lmAAAA:8 a=55QFw1BMmN9-tpSSZukA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DpdoQAXqtI-bQttsEFNnfzinsdTJf7P6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA2NSBTYWx0ZWRfX9I3y+ZGgFowK
 7fNFvbcsJUez51vbpeKj6zFO8WX8crj/Cmlcy+LvkXM9D2GvpDdpgju4inMkGDA8ZmTYToGqAtX
 9rjaZMzLjrmnT+R0mc6f5rF0PE52E1Div0iyPd/sgqVGo5BfhbhBxe7w5pwc3XKKa7CrU952LkQ
 EABsOEE87yvk6sRmAuYazF8PbC+Wu/DzKHFxCmIhCni0G3Vk+dCDFvBXNIus2nRe7XNOrRYU3G6
 KYRNASMgZN5p9375vHqpHLfGekC6zUysBOR+sQJ6sNXo80s0LyqIw2mhD14/YmvZDxd4yjRrVAM
 i6BNdqYcDaA+1IOlN8ioW2mmrXH95M8NSfoIdCAqgsgDGrKR59qTYhGpMFMIQEnDSxPB4zIQoVR
 NvuSsWzh0Az08kcTegA/di10kaK6aTtY/ZtY12yat8RJ6xKQg1kBheHrrxLf1wW8bcHfMY5JjXJ
 v1tmBz9xgE2CdlrFVRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300065
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

Adding Glenn (since PPE42 seems to make use of CONFIG_PPC405)

Glenn,
Please take a look and let us know your thoughts.

regards,
Harsh

On 30/04/26 11:00 am, Philippe Mathieu-Daudé wrote:
> On 14/1/25 08:47, Cédric Le Goater wrote:
>> On 1/14/25 08:11, Nicholas Piggin wrote:
>>> On Sat Jan 11, 2025 at 2:25 AM AEST, Richard Henderson wrote:
>>>> On 1/10/25 08:15, Philippe Mathieu-Daudé wrote:
>>>>> Hi Cédric,
>>>>>
>>>>> Cc'ing Laurent & Richard for user emulation.
>>>>>
>>>> ...
>>>>> The deprecation message (see previous patch) was about the
>>>>> "ppc ``ref405ep`` machine". Is that OK we remove these CPUs
>>>>> for user emulation?
>>>>>
>>>>> $ qemu-ppc -cpu help|fgrep 405
>>>>> PowerPC 405d2            PVR 20010000
>>>>> PowerPC 405gpa           PVR 40110000
>>>>> PowerPC 405gpb           PVR 40110040
>>>>> PowerPC 405cra           PVR 40110041
>>>>> PowerPC 405gpc           PVR 40110082
>>>>> PowerPC 405gpd           PVR 401100c4
>>>>> PowerPC 405gp            (alias for 405gpd)
>>>>> PowerPC 405crb           PVR 401100c5
>>>>> PowerPC 405crc           PVR 40110145
>>>>> PowerPC 405cr            (alias for 405crc)
>>>>> PowerPC 405gpe           (alias for 405crc)
>>>>> PowerPC npe405h          PVR 414100c0
>>>>> PowerPC npe405h2         PVR 41410140
>>>>> PowerPC 405ez            PVR 41511460
>>>>> PowerPC npe405l          PVR 416100c0
>>>>> PowerPC 405d4            PVR 41810000
>>>>> PowerPC 405              (alias for 405d4)
>>>>> PowerPC 405lp            PVR 41f10000
>>>>> PowerPC 405gpr           PVR 50910951
>>>>> PowerPC 405ep            PVR 51210950
>>>>
>>>> Up to the ppc maintainers.  I don't know of anything interesting at 
>>>> the user-only level
>>>> wrt these cpus.
>>>
>>> Just getting back to things after the break...
>>>
>>> We are looking at modeling some microcontrollers on the POWER
>>> chips. There is an OCC power management controller which is a 405
>>> and some other weird cut down 405 derivatives, we're not up to
>>> those yet but we want to model them.
>>>
>>> We should be able to remove a bunch of boards and CPUs, I just
>>> haven't started looking, so might be easier to wait for a bit.
>>> If it's not causing others too much problem, could we leave this
>>> in for the time being?
>>
>> Sure. We will need a new SoC for the OCC and a firmware image. I think
>> these can be built from https://github.com/open-power/occ or, if not,
>> they should be made available.
> 
> Should we proceed with this removal now than v11.0.0 is released?
> 




