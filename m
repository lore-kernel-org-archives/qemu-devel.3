Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9017C109C05D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 20:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5UtB-0004wn-Em; Wed, 25 Mar 2026 16:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w5Ut0-0004oi-2G; Wed, 25 Mar 2026 16:31:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w5Usx-0001ne-HE; Wed, 25 Mar 2026 16:31:29 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PHuqwN3105965; Wed, 25 Mar 2026 20:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mM0tck
 /QXvNmGUROMKDiFir/zsc61DJbsrLHIkBfgCw=; b=iNUyqv40G/Ey+9GYLjsfJM
 z11Y2IXJZ0j+QzK6dvEKEqYtA1a8Iru8zqwQxhnVtheuNg3AjnM8gKUZPAfsPwbe
 ck5zTvNwK/SoX87tX5Kj6vD0BIfUg0dhBU26tquJ3t9M641TFl0mp2ewIe+PAHs8
 u5EFPqiSB+hUgnmCs4j9Y89PTVQohYtHZXVmDqn7Dk5ZBWefy69GmT247LhPUES2
 7nOhJgTXtG8d6ayLrEkcgeMkb1lXSqNYhU9EyQX+5iLaV+PRVZL/Tur7Cv2E/Jat
 1HsSuJ03MURiZc0mPXb+RIUyeagAY97dYavtK+mZcGgubgQEU98K4gpyV5/kZpTA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv1f2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 20:31:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PJFd0j009143;
 Wed, 25 Mar 2026 20:31:24 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnr5es-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 20:31:24 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62PKVNg841222758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2026 20:31:24 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D18B058054;
 Wed, 25 Mar 2026 20:31:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF58C5805A;
 Wed, 25 Mar 2026 20:31:22 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Mar 2026 20:31:22 +0000 (GMT)
Message-ID: <07ff064e-bea4-4beb-811a-f5f3485836d6@linux.ibm.com>
Date: Wed, 25 Mar 2026 16:31:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] docs/specs/tpm: document PPI support on ARM64 virt
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Mohammadfaiz Bawa <mbawa@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260324-tpm-tis-sysbus-ppi-v1-0-e59175210954@redhat.com>
 <20260324-tpm-tis-sysbus-ppi-v1-1-e59175210954@redhat.com>
 <c6830a19-c275-4a83-bb17-4430680b3d54@linux.ibm.com>
 <A2BD2FA0-6D5F-47DC-BF2B-017ABE5F31AB@unpredictable.fr>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <A2BD2FA0-6D5F-47DC-BF2B-017ABE5F31AB@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 2e1H_Vd02i8YERmW7U_L5VovVahqqbeD
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c4461d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=GaQpPoNlAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=e2cQRO8BGDtt_-LcLRwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfX/Q0ZR1JRr4T3
 pU8GSwlAwe0splY6AZ/mZ4eCSuLP5snRsUP90AfSuUjtogEpqqxXT09PwhzVcibEPvqDRD711gX
 dDP0k4L+dfuur1oyFRTMd03yvIHeDv4kt8WlyzTpHD0Od8nTrojm+V35UbYZq4HcdWMX6H6iQ7x
 0X/Jqrp+cguqrWtj7ilu78Pad+RsRYnvmmGUE3JLn7xv2apFuQ3NuDqEy6xNfHN3kC+cm8t/kC/
 oFjddHjz0prtil5/Het3R/f0BnECbmhXaS+iKYDGCqu9ydNQw1uyVCRYEq8BmRnS6hjI748v9XR
 UO9gr3AmVaa2qodzURkdml88I1Vwn7R2o357as0oEs/oQ16mHRhCfETs3As3Jq9tlnDKSfDonha
 lGYU5TRMThuk65l5Yms8ziupzHagdxxvuxsr9XsAIsCbxV3Ap8DPeOHx+8WN3p5qqPNFmZ/076E
 rpqg6krgAhwnBkjz4Vw==
X-Proofpoint-GUID: huTJ91tAvbhyDijj3rkSAx76DGmnESfR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 3/25/26 4:22 PM, Mohamed Mediouni wrote:
> 
>> On 25. Mar 2026, at 20:31, Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>> I remember having played around with TPM for QEMU on ARM64 (Raspberry 5(?)) a while ago and had the impression that there was something related to caching that prevented the MMIO interface from working correctly and Peter may have confirmed this back then on IRC .. I am not sure what exactly it was that didn't work correctly when run natively on ARM hardware. It worked well when run in CPU emulation on x86_64 for example. So I am wondering whether there is a minimum requirement for an ARM CPU or ARM CPU features related to caching that someone needs to know about to be able to use TPM TIS successfully? If so, it would probably be good to mention it here as well. If you know.
>>
>> Otherwise this looks good to me.
> 
> Hi,
> 
> There are two things here:
> 
> - For Windows guests it’s a bit complicated
> 
> Windows guests LDP accesses on the TPM register range which doesn’t match ISV=1

oh, yes, right ldp instruction.

> syndrome requirements and needs a workaround in current QEMU.
> 
> I _think_ the QEMU-side workaround described below went in, which is:
> 
> If we map the TPM register range as read directly, trap on write to workaround
> usage of LDP then we hit...
> 
> - FEAT_S2FWB
> 
> This is part of Armv8.4 onwards officially* and allows KVM to force a device
> memory type read to be promoted to write-back.
 > > That allows the (easiest) workaround for (1) to work.
> 
> However that’s not the _only_ workaround, you can remove it and include
> https://patchew.org/QEMU/20260317174740.31674-1-lucaaamaral@gmail.com/ instead.
> 
> That works fine and removes reliance on FEAT_S2FWB.
> 
> * some older Arm chips implement equivalent semantics without signalling it, but
> that might depend on SoC-level integration.


It would be good to mention in the docs what the user needs to know 
about CPU requirements, if anything, so that it can actually work. If 
these recent modifications/patches make the TIS work on any processor, 
then there's nothing to mention...

> 
> Thanks,
> -Mohamed
> 
> 
> 


