Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B484AC5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wweIM-0002WS-AY; Wed, 19 Aug 2026 07:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wweIL-0002WD-04
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 07:17:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wweII-0003pF-Ap
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 07:17:20 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JA7PH81018947
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 11:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l/qNuko4bcfaJ6oPDX5gayjrFqqR5dg1l6+zPcL0Qrg=; b=akmiWcx+53b2qjcr
 SwtCFeCimDLCDT7aXSMdn1UYRntTAQ8t5/QdgNy03jc8iBhwN7+l2zRVeho/JK0j
 5+cTUpzQWZuSKu1CsY46+o+iynhhBKUhVZNUE0ZDJWmVed2iPiii+0aKZkFBervs
 rsE6IHKL4P2agnHvViQppyQCym5tmuRY04mNpKkv5yA5aB2MyIN8ucoi3iAu+GhG
 OvHz9JBdkK8vi1NxSVzesJcmkC8dxCdfBy43Os9tQXtPrUL7aAtDn/rIZLrAYje4
 KDhV7/oh71DTSfXH94ixu3d+dgj2AeI2nq5mIOWd9wFXZ98MfnpOK5ext3RS5YJ4
 FE2z3A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm2vyt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 11:17:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9349c5af52bso150486585a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 04:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787138234; x=1787743034; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l/qNuko4bcfaJ6oPDX5gayjrFqqR5dg1l6+zPcL0Qrg=;
 b=aLnNBnQ7tRWruv+lNXb2minW/1ZrqG/LiDXLdxHPKUgNpRAGavLVbf96Fij5JXTncy
 deYqMN+p2YeZQ4et1X6+thVmIXZ+EEv3WxkVxSyd7cD4VpW6kP+ZfktC2fIx+bD5Ug4+
 GmPa2vhlH42i6pMLPlPz1k+VDCP/oDSATuclGBFosyScpwmZbXOQqpZOFqb/RCR4kfqp
 VpTnriQEcjX/8HLFYjUm71iMTA9BRgQ5ZDT4T4GTofaN/ijp4joYYysudNtDCL2KmOKQ
 IBauMHXr0Q6xyJjeZEDrFzp9jbDjCODEodTvaLXP/zcPo9p8mbhYU5zMdojo6ln8CyHF
 xl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787138234; x=1787743034;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l/qNuko4bcfaJ6oPDX5gayjrFqqR5dg1l6+zPcL0Qrg=;
 b=nH0rE9MLsKAaWbr2KKHEKHHaDcio0VKEfjF1Jxs+lLwIYd5uwCDzcyIxnQHBwjDBKj
 +Bx4VWzT0nFylvzEbrpS9/Bru6e+aT/lEEek/RAmrIokAlwV+nvf+vR+pqQqRdgXqJ17
 uWtCU321mv5w1lDM5A2cBx3tUQK1smmfn2sEUHEVM5DRFLxdwoGyfehJIoxJpdgT+i9q
 3G0iz92FChNFCZFhgi+xmyAQrXPnpPg9AeMdVwQntW5qy42Od0uXRGVR/BpRhmPOzKnD
 5nr+B9oq6F8vvGxkLszru+HbB9itWVe1Hjj3tqxSOGC6C8rsEBHj9cgrgiCC4EOoWtho
 BdJA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqif5HuCS3pl+A4YEHJHQdopMjFsc7Rn5t+XX+aqAyZcMuUNvNRlHE4gMvqzdSQ8BmGxnR6s/pS1JjX@nongnu.org
X-Gm-Message-State: AOJu0YwXt+Ob3UXOSA9FlyS3HvEHfc4kCgDnE5bx5SOA4cIkXBnbYSIN
 D1srABHjBY3J/nfi9guvkTpgR+v7DmRRaxYG551I5c6/59hb8tOnJwobs89sXg6c/0Glm8logc4
 KcDf2Msla+i0yt5ToN6qlLe74ZfvYANgawYxvoNn5YzKH9ElOXgTG466Q6Q==
X-Gm-Gg: AR+sD12fUQoMvD07zIGTweVA0wBy5IVZbcOa2mvZTTjg+SMCGIW6v8JHa4fjkJ9893G
 a4n5IK1ypVEfeVAKtQRwLRPRWyzIuf5Hf2lQABPyA12I5vyv+cVK8cn6ZnzjlOchQ53V+FNpKJm
 UOViX+T163AUMh6sUw7H8Hjo/WIOzpDvps3XBE4XYQLypSWJi1l3+lzh4rtERR1V4cXCyLHLHNR
 fSTL8IXvByr4+I36MuAi6y8V4Q/hUPBlXgLFnXsSAO87+UJGGLytXANw+HcbZ7B1avsKp4Xv+tf
 sKgjvFizo0AAcyBek2YNdmj2mcp31+hQXoyvWdl3W0JF5cKw/Hd7ClhxiqAJ+lGjNNSXhbw+bRV
 4f5g8pKj1t/1Y8bTHFUUglKKkrH3Q/cGVruA=
X-Received: by 2002:a05:620a:2814:b0:92e:6122:130c with SMTP id
 af79cd13be357-9371e30bce8mr377540385a.34.1787138234041; 
 Wed, 19 Aug 2026 04:17:14 -0700 (PDT)
X-Received: by 2002:a05:620a:2814:b0:92e:6122:130c with SMTP id
 af79cd13be357-9371e30bce8mr377533885a.34.1787138233526; 
 Wed, 19 Aug 2026 04:17:13 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9aa1594sm50480115e9.0.2026.08.19.04.17.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 04:17:12 -0700 (PDT)
Message-ID: <c459a001-57c5-44db-b292-45adb70d26d5@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 13:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/riscv: Handle [ms]status updates for rv128
Content-Language: en-US
To: frederic.petrot@univ-grenoble-alpes.fr, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260819105655.33391-1-frederic.petrot@univ-grenoble-alpes.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260819105655.33391-1-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA4NyBTYWx0ZWRfX97EChnbAwtgL
 NLFjU1QvvIxO2PydDRSLPJADs9JckRG83XY/3sFNQHExvNLCZMMlqK2bkuQwECR7u2uaq2d9uvv
 nKjnzL69onmVGc9oT6eCWGRl4WFqEU4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA4NyBTYWx0ZWRfX5WIfL8KP/XbP
 W8eahjn7n0P0fIkgEUoJyR4+M4kaTTHtis6jpe4GKIjqn5V8pzIaEeYua3bIm5CayN7PuZNwRmM
 ybpInrrevgqSf2ScEGiw2LLmKkbXp/qnhmbhL8VrJlKlLNqJ2Xzb2kvvT89NHd3S5V4Z103h8Pd
 fbaYFaLORuYdKVriV5hqqrJQbiAcKT/cD681w/8WgNR56/cX5tBaT6XQfBU48cDSj5w/omqoHIT
 D8k8LMJhaL3fAcU7XaXKtp1FYfe2e1rq+FLWbHr/tBDSYTlKqODBryAIwylOOb0p+8rbefaVOuo
 D+BoE1rq7egAOaxV1EyArQ8bGC3q+Lf9RPA+qFpZPtqB2UNynauMFakUoAUiADOrdCKzAxKvqLX
 maqSUu3ZX8Y200De6bHfJ3Krtng/oLmdmJlY3YiWeTmKu18e7tdi08J8PmKKo3pMyTOP4Nu9xVY
 uKRbLA6Bgn0jA6JRA1A==
X-Proofpoint-ORIG-GUID: 4G_0aSRetNtuDNgfdwKRM51g_TzABTyT
X-Authority-Analysis: v=2.4 cv=bN0m5v+Z c=1 sm=1 tr=0 ts=6a8590bb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=4iTf41tvTbLCZYnf8zQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 4G_0aSRetNtuDNgfdwKRM51g_TzABTyT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi Frédéric,

On 19/8/26 12:56, frederic.petrot@univ-grenoble-alpes.fr wrote:
> From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> 
> Correct sstatus update and allow support for rv128 in mstatus,
> provided the cpu is an rv128.
> 
> Changes compared to v1:
> - add cover letter
> - add the Reviewed-by tags
> 
> Frédéric Pétrot (2):
>    target/riscv: Fix sstatus update in rv128
>    target/riscv: Allow UXL to be 3 in mstatus on rv128

How can we test this series?


