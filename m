Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD08FC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzEo7-0006mK-Vm; Wed, 26 Aug 2026 10:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wzEo6-0006kx-9y; Wed, 26 Aug 2026 10:40:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wzEo4-0005pf-Bz; Wed, 26 Aug 2026 10:40:50 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QE1WY8015904; Wed, 26 Aug 2026 14:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=G+dIBf
 ygeYzSuz1SjFE7VEIiF2gnK4f1B/17344b36A=; b=AQrXxdX9XXFzb0Jo++mPAq
 OhBzLGQxiGh5VmIdR3qUoPpYdK/JsV00gifnjtiLq5wHccQ7im46HT+erNIWWnd2
 eiF3SNNfpOFT87T6PiYQNyT1uIlLuUXYJHaYoUnrgAhN5MX7pzezfz7AbucVIH85
 Fv/GneB544gh7NgH2B9BvR2Ja/Yf9CPY2NCWyyUfKR7wz0AoIX2Q83I2hpbiXEdk
 PWfJHgQQIyJrkQgx9JqsHetBig6INlsSDp9sSxsDTZiE0d6+Kl1a7CtJFlcPR9rt
 qU/zKy+yLbTch6j4yWobRONZLuhzhCCq8YkGi8b0IIOZ4UeOBdVsdPYO5jeGw0yw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4yabx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 14:40:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEQNH9026463;
 Wed, 26 Aug 2026 14:40:44 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragjajv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 14:40:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QEehWZ31523514
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 14:40:43 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1EFC5805E;
 Wed, 26 Aug 2026 14:40:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F28858056;
 Wed, 26 Aug 2026 14:40:43 +0000 (GMT)
Received: from [9.61.69.254] (unknown [9.61.69.254])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 14:40:43 +0000 (GMT)
Message-ID: <4e88884a-ce31-4d32-8941-5922fc3c596a@linux.ibm.com>
Date: Wed, 26 Aug 2026 10:40:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] hw/s390x/ipl: Fix incorrect PCI IPL block length
 constant
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 "Jason J . Herne" <jjherne@linux.ibm.com>
References: <20260811144629.866641-1-jrossi@linux.ibm.com>
 <20260811144629.866641-3-jrossi@linux.ibm.com>
 <51730ac3-ff1f-4eca-98f9-b31b47596185@linux.ibm.com>
 <1bf6e2a3-be53-47b3-8694-9b249770a655@linux.ibm.com>
 <0ba0a7aa-623a-48e3-bde9-48ee82331d1a@linux.ibm.com>
 <36b43f47-32d7-4ff0-ad76-2d1ab1df2c7f@linux.ibm.com>
 <a4ffeab2-82d1-4100-ae25-c00c2d562c7e@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <a4ffeab2-82d1-4100-ae25-c00c2d562c7e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xJq32oSWXMIEvjOX8JXevPtbBcR8fa4U
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyMSBTYWx0ZWRfX6olsDsYxqyiy
 htztFpON+/TbwDsIbM+iBQLdcGN2IDFOFa2puF9Z+mBwhqQYQXjl6Uf51AU5/Bdpo9yLIFCDXWA
 B/pLZAOzYF/1vDLni+HEH7JK4gUP0aw=
X-Proofpoint-GUID: xJq32oSWXMIEvjOX8JXevPtbBcR8fa4U
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8efaed cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=clF9_pQHt9C7tqTUgR0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyMSBTYWx0ZWRfX130ubPhInr5P
 1aKfHEXFG6B4O5h+8V865bHUW3BuFhqg6MYgDkhsGUi8aZJyR0Huc+laDOFekTAycYufRFNkpGi
 QpqECljfVp9dppxLfRcJ9wZIlJwq8UbPvHASkx4QYDlGmeEAQhxeerrs7Y10WnGTLJRXJFtnaP3
 lzqTKygfRhLt1pvXlUWhEWmtoJyOj7+KkXI8lj415oZXqP2CAU0cR8nWSYbLPEuCugAFfSONqbd
 iqx9KaD2zuSVYNUxvtSYmdh6yq/luul+j0puC1XeVq6RyxeYYDxuyC8y0Od0I8j5byZ/HBwGjDr
 XT5JU3IS9TAPDa1S4EuAtr89kkcHrhneWguJdQSBgLCV3a5vUJoHjRDG5BBpp0aWkGtCQnt9ZLh
 rEDrzK0myzWebBkXOUfEv8HrPPeZj3A1Dol8J1Mb53wL31rk5mSI29Ych+Yc5biPyJWF7dNHcvS
 E+TRGUJq0iYxfxX9CXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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



On 8/25/26 3:26 PM, Matthew Rosato wrote:
>>>> Given that, should the #define be sizeof(IplBlockPci) + 24?
>>>>
>>> If IplBlockPci is likely to expand in the future, it might make sense to
>>> derive this value from the structure layout. For example,
>>> offsetof(IplParameterBlock, pci) + sizeof(IplBlockPci) could be more
>>> accurate. Otherwise, keeping it as a constant like the other definitions
>>> seems reasonable as well.
>> All of those suggestions would be valid, but I'm leaning toward keeping it
>> defined without using sizeof() for the sake of consistency if nothing
>> else.  The other IPLB types are already defined as fixed numbers and for
>> the IplBlockQemuScsi being used later in this patch series, it actually has
>> a minimum value that is less than the sizeof() itself due to the same
>> struct
>> servicing both PCI and CCW controllers, where the minimum size for CCW is
>> less than PCI.
>>
>> I can envision several ways to improve the definitions and/or naming
>> conventions, but I think it is outside the scope of this series because the
>> changes should be uniformly applied to all definitions, not just PCI.
> Ehh...  If you already think the other definitions should be fixed then
> convention is not a good enough reason to propagate the bad practice to
> new code.  Doing the new definition the right way now in this patch is
> certainly within the scope of this series.
>
> If we have structures that define the entire 336 bytes, I personally
> would much prefer to see that written out with sizeof()s vs a magic
> number that coincidentally must line up with the size of one or more
> well-defined structures.
>
> As for existing definitions, I agree that is out of scope: you could
> follow-up later with one or more patches that cleanup the existing
> definitions.
>
> Thanks,
> Matt

OK.  I will use offsetof(IplParameterBlock, pci) + sizeof(IplBlockPci) for
the new definition, with the intention of cleanly splitting the IPLB header
from Block0 and uniformly updating the definitions in a follow-up series
later.

Regards,
Jared Rossi

