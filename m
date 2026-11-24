Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FCF606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VOmPnrwc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVjZe-0001CK-Ta; Tue, 24 Nov 2026 01:00:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xVjZc-0001B8-Pq; Tue, 24 Nov 2026 01:00:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xVjZb-0000Aa-2I; Tue, 24 Nov 2026 01:00:12 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO359781261188; Tue, 24 Nov 2026 05:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nkHNLS
 AKjzUxIB1hIvJ21b+oil2FwtCGdwKIXUA+PA8=; b=VOmPnrwcFR3cG/8DqcxOJs
 mILP31ktY0N6exOZEreBmmOA16sbJ9uM1chEPjWrNlgOVcZqShIFBnPqAYRHnURi
 7sOy3JVbGdwktDRdQNUq60mkuP2xOlPdRnxqO89GsXlgFEKNeyen17sWV3P8RE43
 XuTJJbczb9zehaeyMNAmQ2snu4LV5N2FveYkTzECvDED3c1Py0x2/5oqVQyqcXBp
 406dgYav4ROCt/zK7j0jaGpYvp2bKvakIfKdTAx2rssdvgVLRsO+o9BxlWkojvAF
 2YHXgInn4gS/FmNyvRE6M+kMWfCAJbGRmRCyIXdXxmi8BZ55uMdHSnERBM/EoM1w
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkeart-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 05:59:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO2nE891669359; Tue, 24 Nov 2026 05:59:46 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3qufs9t1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 05:59:46 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AO5xjpn31064812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Nov 2026 05:59:45 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66AFA5805A;
 Tue, 24 Nov 2026 05:59:45 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D6115805E;
 Tue, 24 Nov 2026 05:59:40 +0000 (GMT)
Received: from [9.43.59.24] (unknown [9.43.59.24])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Nov 2026 05:59:39 +0000 (GMT)
Message-ID: <7672e73a-2945-49d9-94a8-a3d187be300d@linux.ibm.com>
Date: Tue, 24 Nov 2026 11:29:38 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PReP] Maintainer status check for PReP machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth
 <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>, Helge Deller <deller@gmx.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>, Chinmay Rath <rathc@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
References: <250f899a-51c0-4007-99dc-54bd336f0693@linux.ibm.com>
 <e29c8bc1-0a25-4dfc-b429-6805c373b5cd@oss.qualcomm.com>
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <e29c8bc1-0a25-4dfc-b429-6805c373b5cd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyMiBTYWx0ZWRfX68cOC7ylMvMm
 2Ekd4hEUtJMzG2TUb6nmlyFob5HANUvAh61mzv6owyUADt8DMGcsTQWFBZ2jFqBbm8kA45AQskM
 8ndYjlSyPdhIJo3t0lJpBGst7fUAf0jSsB+NhmS/673tkluZ3kb9REyKgQiUbuO2R+LY1nPCfM2
 004rDr6EhJXq+x4ItB1xk3lxXVHiPVPEKyJJkdwtdMfYgH3zlNMNlxeafmsvak36PMqGQd1FOph
 JlRa26VXxe1MHGvHjvMedHxE2qcrheZJi9Mdv/HQPCVVd55/EjDDmvbliPOsLmGyBID2/3t1QVh
 nWcQ5eKtB6xTqeXO/rLLSUw8ldrEUg+2JUE1Qa5t2nlWlLO45womZQrp9TDqaI39pTF5qDjBidM
 zQcolVt99WOmJ3SdnV5NJiiREzDbxZAZfXXCIezWvDmqT2ZxodSkBX6ws4rD9Ph2+/XOh83Hygz
 JoJ7Ur1AxkE94C0HRFw==
X-Proofpoint-ORIG-GUID: th_CLyJtb1AZgGnTEF5YRNYZkkq4zWcQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyMiBTYWx0ZWRfX41MCYiFpCOeo
 YkZmUtlnbP0DOX1YcLaLIgUGgBioyCEttYDnb/a/fyMGscvOSQhqzhOlkMuxMiCrVOaLX6StvZq
 ytq+e3Q0XF0o7V9bQ6jZd8ZL8VRDKME=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b0527d3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=oQNAQU3PBjka-gP_mOQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FSkb9083FlEwmxdoyE7Qys27cAw8sOtn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Philippe,

On 11/23/26 11:02 PM, Philippe Mathieu-Daudé wrote:
> Hi Utkarsh,
> 
> On 23/11/26 18:14, Utkarsh Verma wrote:
>> Hi Hervé,
>>
>> I wanted to check whether you are still interested in maintaining the 
>> PReP machine in QEMU.
>>
>> Your name is currently listed as the maintainer for PReP in the 
>> MAINTAINERS file. However, we haven't seen much recent maintenance 
>> activity for this subsystem, and I wanted to check whether you would 
>> like to continue in this role.
>>
>> If you are still interested, it would be great to have you continue as 
>> the maintainer. Alternatively, if you are no longer actively involved 
>> or would prefer to step down, please let us know.
>>
>> In the absence of a response, we are considering sending a small 
>> MAINTAINERS cleanup patch to remove your name from the entry and mark 
>> PReP as Orphan, so that the file accurately reflects its current 
>> maintenance status. This would not affect the PReP implementation or 
>> its functionality.
>>
>> Please let us know your preference.
> 
> Are there any PReP patches pending review / left unattended?
> 
> This machine works well enough, is tested; what is your issue with it?

This is more about reflecting the correct status in MAINTAINERS file as 
the currently listed maintainer (Hervé) have been inactive for about 3 
years, although the patches are getting reviewed by other community members.
It will be good to have someone listed in the MAINTAINERS entry for PReP 
who is active in the community or we should change the status to orphan, 
so that it encourages others to step up to maintain it.

Regards,
Utkarsh

> 
> Regards,
> 
> Phil.


