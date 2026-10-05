Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709A7CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDiqs-0001qO-F7; Mon, 05 Oct 2026 09:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xDiqM-0001aD-Vb
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:35:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xDiqI-0005uQ-Os
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:35:01 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695CFQwC2366042
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 13:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LZ4EJ7lmFpUwukMRrcGizDRsY8ibjTYc8PvBHvmSrfw=; b=CWQVOJdDOTDPbH1O
 NfS9xAxzkpQCdSPPWEAKqjJ+nmQuGnkVpn5Bsynp24goBkSvPYxdVo/R+VFxnxn3
 aCj0S9Z1pgbzBwyAo9eKwPSSP9pnb1vcS2TssOYQOeqor1PFgl9QQxQFIWFI+3xl
 lfe79WT/XIu8gZ8Bl0E/xoWedZMtuBnaXxeaCKjkvZEmebGQJWVmrC1lvMPxgOvY
 QP3M4CZVcyN3HhF6UTwTuXxMxxqdlpKPUyg2IwaJStcRb695yBuKn+yjAHqgAZOA
 j+DOAHHxJZxn03PWrRi3qpJ+KvvHAEFfYSztq9B5k6KKngyanNW8KRoWT+KQYzOz
 x3epNA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h49tvrmx3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 13:34:56 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7c07f9547d9so401805137.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 06:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791207296; x=1791812096; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LZ4EJ7lmFpUwukMRrcGizDRsY8ibjTYc8PvBHvmSrfw=;
 b=E8Kc0wLfXe1HqEwOF4nFK7zp7smxZrG10dz4fiQulZw5EpZ/wdZgKsmyvP2/HxDPSf
 UJ/9PhjLj2ovqCBk8J20IRZra0Zvn7UTFb+5SiNR0h/CjO34j0E8W1D6ImsLtIaLkpue
 weorx0YE6zOsCONbEhj4dKIA8pwl9Ht91yOpMhwuwtkMa/Bg+wyZZ5HZ90+x0rA6qf7r
 8SL7kaJ+chyRtxV77Fk4w1sZOt9Vg9srreiedveOhUsboMMJ0I6aXuOZHQ74olw6H2Ry
 GWQeyC8nMMn8+bvPa3QguW5XYPDBdvC7RtoylwlWSlSiAGipmf9yATKJ//eaw06qo3oH
 l1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791207296; x=1791812096;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LZ4EJ7lmFpUwukMRrcGizDRsY8ibjTYc8PvBHvmSrfw=;
 b=y0tj7GNpnTZg91KiCSkNw7WBhedROCtzTWBrAzTXDi5gPxeVHSiujJEbFqjIwbO5Az
 MYRsCD8abSomsICoZZ5vDOsDtf16qHIU1Ss3aI1bk7pBs+4mVB+NN/BeKaMls4/Nd3qp
 v+q8KlNHPZHKsL3rREVwoPyBzOhw8hXh6di29UKkTuqMQfNOHDzXteiz/LDPPwda/TQI
 OtkVbZiDPo/h15dX6nZKZ0bg2VO0UueQbsaQnMfL0sluOkgkHR6dNdD5jYhnNwTSv/CK
 HK0a4lTq4weUcxu0YEoin1Z3tvqbBFGGGtt27cUHylVUJLLblbL0rFydd3b4ZMFXfBJL
 2KpQ==
X-Gm-Message-State: AFq9FYLJWc5FmZjrKCI847A6OWTkPB5wYxpBxJVhQUPs10nd7Ybetm7O
 WcO+nYQEl1NegaRFg/SYAupwUmKSvRYuEznZzSuFc6LtOYn+LztRdxSZJmrZFkPx84LNl/ZuL/W
 Hq4eDFkwdSErx2WXIJkLgxV5dB9boQ52fVyapH88Is22+xPRzD6jIX5UOLQ==
X-Gm-Gg: AYBFou2U2l30IBQt7c1mZMN3+yeYMvj+5a4eEss8Pr3Bmt2EG+OOiNOG2Qbf+3zc46I
 R7/SogXXDoFqYwREOqZvusH4M9Np/QLUK3MXnWPjzCpZGg4KN6g9XKtmpUy52XW5jx2hqV0N3DA
 Y6vSd3NqkB312/uHBboAhMCpmQSyofjPcbxIUU+zNUV0OFQbwGZ1oHvwVzHAsPn4UQwFSLsrgZT
 PLWuVuMmRKM4Fy4cWaK4GhOuXdumeUV7gSPAj/40tyCZyPiwPOoly3iTfjS+m8h3GGB2EPqlxlG
 tqmukGyOLoarRoulVXnsTjZr31tDU3UXorcu0rd6zyC4BqrLrDmuCTQTYUbUQ+y5XnkbDnFrZzl
 c1cDhcB1LNqKSa4HdvApKmoCsVxbxNxGrbw==
X-Received: by 2002:a05:6102:91b:b0:7c3:881f:b620 with SMTP id
 ada2fe7eead31-7c3881ff813mr919260137.21.1791207294811; 
 Mon, 05 Oct 2026 06:34:54 -0700 (PDT)
X-Received: by 2002:a05:6102:91b:b0:7c3:881f:b620 with SMTP id
 ada2fe7eead31-7c3881ff813mr919248137.21.1791207294089; 
 Mon, 05 Oct 2026 06:34:54 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6773663dsm76912f8f.4.2026.10.05.06.34.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 06:34:53 -0700 (PDT)
Message-ID: <5e64e1e0-d733-4f8e-98b4-8e6b554101b2@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 15:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/28] hw: mark secure machines for x86, s390, ppc, arm,
 loonarch, riscv
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-2-berrange@redhat.com>
 <f1481bad-4dbb-414c-801e-aa24a6977b18@oss.qualcomm.com>
 <asOk6i4CNT9P6Bs-@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <asOk6i4CNT9P6Bs-@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aN9lOr9m c=1 sm=1 tr=0 ts=6ac3a781 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=ID6ng7r3AAAA:8 a=20KFwNOVAAAA:8 a=CtHk5BvZtinuqIhR7bsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-GUID: KGs7Hr4hp0_IsMnL5qCOyJ8f-ymXAQ_s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1MyBTYWx0ZWRfX+6egDmSouxrB
 NZCJuDxAJZdEiep/iPVsz50qG9snwXWXrtYxtGQBnEntTWfd+rBefyDFmZ8xuRaA9HziwbtRuLG
 khHZpIAMzBJi7s1jmbmmJQD4zMHTTaD9KhpFQj5msAdySNv3LZbfGQm11Ip2ttpUGkCNX1iYzKw
 7dlQ7z2B6MrnN1UXW3a3HZOQQhqF4pgVSbACz9OsLIMxOdJGFaH+KlJBLF9q95q3MswtbWIile5
 jp8srIZ0iuY8zCDkdxWnmmvjd+0WvhhzgP6VJ63cuHDCvMO9PvMb28PQRP7ueGNcFGZXk6qr5+F
 nyk4LHNfAHj+rIDbkK+J9ZMYunC4FYduumpqO9WnHZVBaggMQCX55IRpXjHG+V3w83ZFsXwTtXv
 LaQ/G1NHfhWQRHGm/f91Oj6xfF7X3NsyEsMlAvqKBlmqIhVRIyoiwenLgfmU+wByvbQrSz0aKOk
 wker/d4R7hlz6hhiGLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1MyBTYWx0ZWRfX3JKA66FVJ+2U
 h89FtNSlxG5XlF831JBAOA0OXISMBIJ4i9Mv6Y4xB4Eeol+2QIB/usIOo6mT156dyQNN0Qo3Pwz
 Bn2vsB4pqLU+qDXus3a10bwRR78PrJo=
X-Proofpoint-ORIG-GUID: KGs7Hr4hp0_IsMnL5qCOyJ8f-ymXAQ_s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050053
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/10/26 15:23, Daniel P. BerrangÃ© wrote:
> On Mon, Oct 05, 2026 at 03:06:08PM +0200, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 11/9/26 16:36, Daniel P. BerrangÃ© wrote:
>>> The versioned machine types are typically present for use in
>>> virtualization use cases and can be expected to provide a security
>>> barrier. The only exceptions are the m68k versioned machine types
>>> which are only used with TCG. There are also a handful of other
>>> machines declared secure in docs/system/security.rst, notably
>>> the Xen machine variants and microvm.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    hw/arm/virt.c              | 1 +
>>>    hw/arm/xen-pvh.c           | 1 +
>>>    hw/i386/microvm.c          | 1 +
>>>    hw/i386/pc_piix.c          | 4 ++--
>>>    hw/i386/xen/xen-pvh.c      | 1 +
>>>    hw/loongarch/virt.c        | 2 ++
>>>    hw/ppc/spapr.c             | 1 +
>>>    hw/riscv/virt.c            | 1 +
>>>    hw/s390x/s390-virtio-ccw.c | 1 +
>>>    hw/xen/xen-pvh-common.c    | 1 +
>>>    hw/xenpv/xen_machine_pv.c  | 2 +-
>>>    include/hw/i386/pc.h       | 1 +
>>>    12 files changed, 14 insertions(+), 3 deletions(-)
>>
>> This patch should be split per machine / area of maintenance,
>> so maintainers can officially Ack their commitment to security
>> boundary for their machine.
>>
>> I'm not sure LoongArch / RISCV / PPC are. If this was previously
>> discussed, then pointer to the public discussions should be listed
>> in the patch description.
> 
> Those are explicitly documented here:
> 
>    https://www.qemu.org/docs/master/system/security.html#virtualization-use-case
> 
> so this patch is just encoding what has already been defined.

I probably missed when this was accepted, we are good then!

That said, 1/ Nitro Enclave are missing and 2/ this series organization
is not easy to follow to me: I'd rather a per-machine approach, with a
'info qom-tree' output justifying the devices, then finish the series
with busses-based devices expected to be secure. I dont quite follow
this approach. I'm not asking to redo the series since it is already
reviewed.

