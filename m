Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1F9CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuFB-0007ds-A7; Thu, 23 Oct 2025 08:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuEh-0007CM-JO
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:16:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuEb-0006Fq-Uc
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:16:07 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N861D7007748
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6dSKRF
 60TIR5vJBgH42MNJOp7DcfQon13ydrbzMp6Z8=; b=OGXUh7rpril0qCe+dGDKSs
 /ornBMMfJW3F7Cz/YoD//FMESsuwHdZJ6NhoBOMG71F6YQtOAgxeKZJCJM+tOVsX
 p7WYd1QQlQogYBLVz76i6zZso+VMOyPo9tuvtGtwbsgJV/P3qJxFlX1s8hPU8UGc
 8zR37xofAf80iVm75+ad3Za1jPt/Uux0F0fCYP6PVCcuG4+5cHsiiAayrJQCWvhw
 nRaCcRtLZLKPfn4FK7Uz/XMfTqTaP6b3a3v3exMGOCuMBw+lmtBXYJm7yFbZeP7D
 oxGWSxGiQlvApf7yISbb0uou8JPk1LevcM74O8DvHkOdVNbIPeEuS8+92Qe+IG7Q
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3272156-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:15:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAk05e024940
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:15:57 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk5hq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:15:57 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NCFuk663897888
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:15:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5CB15805D
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:15:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A3B458058
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:15:56 +0000 (GMT)
Received: from [9.124.221.73] (unknown [9.124.221.73])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:15:55 +0000 (GMT)
Message-ID: <0f067c89-83cd-44d9-9a15-edbdd4674709@linux.ibm.com>
Date: Thu, 23 Oct 2025 17:45:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/32] ppc-for-10.2 queue
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
References: <20251023114422.3675018-1-harshpb@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20251023114422.3675018-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fa1c7e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8
 a=Kd1HqBJjqnKGIvYUJjEA:9 a=QEXdDO2ut3YA:10 a=oH34dK2VZjykjzsv8OSz:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXxEesK1AyGGI6
 Jh3HPiMnfuTAXJ9xEODLxPGtRXqTYnpVfLnJlT4zlOideU25SFAp8cWDmkniWGz+eemfr/kFGbm
 JZIiz3WmMtS5fkAChFPOsbW4OM20wHNgtWrRqGzhi2Dz+Gz6/aXVHDIITPMld6XrMRMgniNJbRZ
 YJMJeBqaVvnMudHgeh0IgKcG1vv7mMDdxSuFV/GFbGEz5DBVLtQsUOWUT7mIz1cjROyJYqKAmHu
 xfaHJQUFIkxbsoanMOw1OuwW05i1BKQ+9R7tOUlIFBE4JlZiL8h+PaRQxCbtYIzMSMaoCNQShTJ
 kVdEzHuailCwWpNQ25l+Mpm/C0s8kB/WPl2H0ZIN/hTMeYk7tKweMs2+HL5obxgrZj6bU6teybx
 H72cBYkqY95n4Ngb9Kc5KIVJm9HZ5A==
X-Proofpoint-GUID: XB2lPNdc2PmNle6tPnSQgCerw7l9ZEaf
X-Proofpoint-ORIG-GUID: XB2lPNdc2PmNle6tPnSQgCerw7l9ZEaf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
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



On 10/23/25 17:13, Harsh Prateek Bora wrote:
> The following changes since commit c0e80879c876cbe4cbde43a92403329bcedf2ba0:
> 
>    Merge tag 'pull-vfio-20251022' of https://github.com/legoater/qemu into staging (2025-10-22 08:01:21 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-10.2-d2-20251023
> 
> for you to fetch changes up to 5191104c18f44c8d04180ed4959ec97323d906f5:

Please ignore this one as missed GPG key sigining.
Just did a forced update with signed commits.
Will post a PULL RESEND with the signed one.

regards,
Harsh

