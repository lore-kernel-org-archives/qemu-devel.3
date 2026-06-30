Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAC5C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegpZ-0006fg-Rx; Tue, 30 Jun 2026 18:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegpX-0006f9-Sb
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:21:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegpW-00045j-4d
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:21:23 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDajK2959915
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C6kbDf08sF5hfk0yTc0oJczvhS1AginBGEhJTkcOpv4=; b=VKkCmfFgQklC7e7c
 zd9ZfhA+uEKPEzcp/C9kvlE0w3DLy82jCaDVaQY7dOHdMmxKDezj/q+l9XDgt2Jf
 Z3wZyATO98+zx1V2aBvpsYp9tZCdBe0x/2PFZuO323NERhWgZMO5vaM8kz/MtoYj
 kn40rFP06IGdVco5ve3LkaAWPOmD+/PK7GZrp8iPKIngGr78hrY0HE9jVJWIjgeX
 CnNrCYOP4gOjLVR+mB8zgVAtOE2XoV0f0biuOSG3jF3wj1dZiU2/i1x19ojWNxJJ
 kYglB/pDONxm9WoEMT1J3JAtpX1hwTFlmtb9OtmQK+VBBIzc1rMwD64Vs5f/KW3I
 bPJ19g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j9115ps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:21:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92b4b575561so285194685a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782858079; x=1783462879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C6kbDf08sF5hfk0yTc0oJczvhS1AginBGEhJTkcOpv4=;
 b=CsNCsFboDo64Zm60J/65kOLZC/De+kf2aR+GywHMl27Uh1c4YIMmnS/4KssNY4uV5Q
 f+jdnZMSxcvpKd6Rx2HNvFLM+OT9OFDuq8zwIxPJC0IqMvTnzOZ4XOSqcuUkRYROU0RU
 e4pgzSMOkwM/ehA8fldeu1HTf1gZZX4IPVRp4K6ZrGJdXQSbBmtYX7XBVZ2igKUr+eMx
 E0rfA0F8vIdNXMyKYs4WAkBTHO7GfF9Tso/UKNgEO8qifEKCU68JN7dOmn7FJURkxAyT
 j4kePSMVVUe5ISLLHzsJYoPW4Fv1LuY8wFPNJef1Sm8bAj2MGGlb41yJ8fr4+5cIO8KQ
 BG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782858079; x=1783462879;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C6kbDf08sF5hfk0yTc0oJczvhS1AginBGEhJTkcOpv4=;
 b=PC2n6ndyRPe8Bk1GOT/O7izRd21ywZgZZPqtHqNR6l9BjnSQHR2ERl1YUadbc7zo5/
 2XqnhiLfNaKqsUpprrKEDU0hxjj0K8hymIKnlSISlDtZXYmtIRWcZqjMNOktPBYPMRjh
 z7enuotscNI1QHmtbqA0EUuyqvSHuY203Lww3gxusvv03PEKumxgEQ+4nwWys79+S70b
 2bGsAuDCaaOah0YsdZKdihLx/TcXPmE4XVwtngQIXgC7/wplmvXFWD80qz6YXzhG09oo
 qefIOItbMVWQK6iUzr+3PFE8n8q+89lMcwIMNpsL/wMQIJzIIVsy/ataAldU6J4Cu2DK
 HkAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kPvaUMyN4kQZC0HYXrChpnZsykeVi0i39bP/r+uVuWUdwPN5aQ7SudrFgM+mwTOD73KNMj/t5Horq@nongnu.org
X-Gm-Message-State: AOJu0YyfRNFefiU971A1JkFGclGpwAbV9S5FzmojujXimbOxNki5x+ox
 gDSNi9tpXc4D71OBetwNnGV6FAFIAb90v3FfEnLw8OVsHPdOEgqzh5vcC+8ZKAyahdCe83QzgQS
 zdzruHzLaLCSGls8WPRvyiJnbjAeioeGzHFBOS7lGp0fJ9+wWcgK9xHOrxw==
X-Gm-Gg: AfdE7cnOvlxDCJuGX590ccTwbJhHaBVEChs2QMEoBNJus3g5znQMSkFFpavM16k15Uq
 kq+J2wfqJcursaKmhk/OquV71oHeWiyltVUCmVu1dg72er+0uR54g1CtbGjgv1dwvcUKf0MdLS4
 vw1dQwx+gqxAbDPbEn2Tt1/NfUJ7VU5qeQV/xJHE50pv9roL/+n6G1AfmUcXwGZVHyMwTMpWApj
 HopzvI5AvGNgIjDA5f/dIuUSDoZmFEJgw8iwITfKQtki/vktqiYz7W7E8Sif3U6lPXEUsfrZ0CK
 EeAUZ5UcHooqteQd+rIbuRWH3mMVxfYeys7HSQVGQqa7D8kQAjz0i6Ocs0Zvzzpgokn2+zYSWtz
 Hg1xeDxMdGEGEBG8cEoxaJZfQd4+QSRv73Z7gHSJa27aa603BYDGS6+ERTWKYwQ==
X-Received: by 2002:a05:620a:44c7:b0:916:5f5:de22 with SMTP id
 af79cd13be357-92e696e775dmr477582085a.12.1782858078965; 
 Tue, 30 Jun 2026 15:21:18 -0700 (PDT)
X-Received: by 2002:a05:620a:44c7:b0:916:5f5:de22 with SMTP id
 af79cd13be357-92e696e775dmr477578685a.12.1782858078570; 
 Tue, 30 Jun 2026 15:21:18 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756636cf1asm12286428f8f.18.2026.06.30.15.21.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 15:21:17 -0700 (PDT)
Message-ID: <1f52bfdc-f1c4-4e9f-a388-6966294e4482@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 00:21:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] amd_iommu: Decode IRTEs without bitfields
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, mst@redhat.com,
 qemu-devel@nongnu.org
Cc: sarunkod@amd.com, qemu@demindiro.com, imammedo@redhat.com,
 peter.maydell@linaro.org
References: <20260630220806.1758748-1-alejandro.j.jimenez@oracle.com>
 <20260630220806.1758748-5-alejandro.j.jimenez@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630220806.1758748-5-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IYjIBKY2pA_w0t_V2NCe7IuMa8s5Qnjc
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a44415f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: IYjIBKY2pA_w0t_V2NCe7IuMa8s5Qnjc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNyBTYWx0ZWRfX32BaGdy2Jq8R
 Zus8KLnZRrKMGnUWx1bgTYRU43cY8XfJPQ/sNFeBI311seTsaTdHIA/SQ38T6ZwH57B3VSMb9dV
 SgtK9RC8X52okM3b4fKeFFRFZJn8DWggHQbxLRD2xY+uyEkFZrP9ToatG86VJlr5A4n5K7C/rDP
 oBUE0cI8qicmlJKSmh9/7q0OfCOtUuTT+XFArOZHrUKmcHaf7/bC04GD874TPZcmQ/ChqUZUqsF
 JaOncmWtW3n2PbWgTFk+hJ0gbWM8DMdF7vft+x6EToiswUkpNOwXb4m6Z4A2QBBF0YJL1Auwnnz
 b74n18e7Tq+Q8xGae3wAyvFKlu/8n6MJwZc4zXLqKKu9I/CP8ZOd9XtMCIIy6NZNc7d0QPjq3Zi
 sO8CelUqsvwX9sSuiJW8XIWWKCBFkvsy58I1yWwkK5NyQaeqMAHF0r49zkFnTZO5JPq0SG3Efuw
 /YgZSejywgNmD6YZS7w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNyBTYWx0ZWRfX9nAfVdFXAh08
 Flu9yRNsWEIvfKOOw34jFzCDqNc9frngBsofS9Y5eJjpWN2sLzKS//NeApuFQG0YvGwVUTujf4O
 MoRB6xF6km3D3D3ysmX2N7adF6m2JFM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300217
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 1/7/26 00:08, Alejandro Jimenez wrote:
> Interrupt remapping table entries are data stored in guest memory in
> little-endian format. Decoding them with bitfields depends on host bitfield
> layout and the value returned from dma_memory_read() is not portable to
> big-endian hosts.
> 
> Replace the legacy and GA IRTE bitfield definitions with explicit FIELD()
> definitions. Convert the guest memory values returned from dma_memory_read()
> with le32_to_cpu() or le64_to_cpu(), then extract relevant fields using
> FIELD_EX32() or FIELD_EX64() as appropriate to match the IRTE format.
> 
> Fixes: b44159fe0078 ("x86_iommu/amd: Add interrupt remap support when VAPIC is not enabled")
> Fixes: 135f866e609c ("x86_iommu/amd: Add interrupt remap support when VAPIC is enabled")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/i386/amd_iommu.c | 93 +++++++++++++++++++++++++++++++++------------
>   hw/i386/amd_iommu.h | 49 ------------------------
>   2 files changed, 69 insertions(+), 73 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

