Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF2EC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcGh-0005mF-19; Sun, 16 Aug 2026 10:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcGf-0005ly-5M
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:55:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcGd-0002sJ-QU
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:55:20 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDl8hg2398211
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uTC43qbSo69kYEW5XM8mPrtlwBF7sPekkWgrT/RX2Gc=; b=Ca6/RT6ylvwK7ahB
 J3+v4GS2A6Qnseu4aIjGYo2+6/Ce/C8hKZr/xP7ofjJV1ejrCUVSlWkDwrjX80r2
 vy1I+/eFz3Dl8wPNpAb5WRMT6HK0JKkTNm8CgLvwP7qOPYyGepbgUfj12CZ1IcxF
 patwpSl1Gwv2VOAkmDOVuSgZqrb+Dw+QLAbsSLg4Wc91uFx1ih+7lpjs3ho09tG2
 NLWeeQCurfeu/Z+Yn/GytrljEtxGipjYlh0ph75cnXW8fYpTbJNFYqsRctXV0OYd
 EWxqdQOb463v2FGA5huphthVLQGZf2e5bW5vMCFDHT0aj6A+Pdxal9NQMoELhVmv
 jRVg4Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghq3p3b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:55:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52d9cef8d15so16802111cf.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786892118; x=1787496918; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uTC43qbSo69kYEW5XM8mPrtlwBF7sPekkWgrT/RX2Gc=;
 b=fe/GACSNJw0MX8UrxMdhuJRIsuJMPpmeeo42lt7xfTkLneNKnndCggfq8xff4hN/mQ
 wRpGU05nmDLmvWcvgLdLIKPaezlaVZmgEsZ3uuOWlcYmkrjR1r2taxQIuVzfm7vdRMWj
 jRVmAG+J3ocqYkbOxdLsTqZuPJiYp9m63mTFpc1TR5wATHyM/WBi2ChuLWdwP/82Nvu/
 0qU6pMKp4VmLBxNUS7ivRxN0JMz0fBhQaTA2ns1CC4U2jX01ZQvA5F3a7SfORhsodoAU
 cff82ly4wSVeS1RQACSxh+F2qd6O43YuvSPR9Md8iEQhkAH6EgtxxmA3tWYdohpfxW34
 2/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786892118; x=1787496918;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uTC43qbSo69kYEW5XM8mPrtlwBF7sPekkWgrT/RX2Gc=;
 b=enzHKxsnR4UdO5bGYqRw+IK16A96NZsYLxFppxRfmyCfaDqsy8fmOyaPdOPXp1a/iV
 FqqaDPZleSeEFPDAfqM6tg+zUxAekYfFGVVpw7pp1dMk683iIFf7jFpfOINnfAfvUhg9
 AeoG7ti4XC4X6JNeCpDGOnu50sh9elPZvLItTHRiGh8gJXIWXh5wuQXoTrzsIpjIzOj1
 7tjNLFVsNBw29D9Pnp/bwywyvO9n+dlSPXStwsTNDhbLU+1+JZP0ZUYhpH2ZVCKJESvz
 6QY/5wo/eEVUpj/6UWmo+1tpz1gGXXw3mZnbIkzJbphcBCWufVkyvBHs0x//FdNX/vkE
 UExQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoIpdwGSHvLOeQLdjcy9JpAJhkyyaRICn+FCZdnOcDA6XBUFrYRAMWQ6aV4GNWqQeZbbP12HkT8tsH2@nongnu.org
X-Gm-Message-State: AOJu0YwhQaYpAIrS5A+sQx56BAVWYEm4mGxmwda7UUW3BpJGP0e3675a
 xWFtFJuH5hBKLIE2n9TpKfdSCzIEMM/3UKVUN4PX+30/ThKLrPfd6MvBHkU52SemJV7IzmDcuPw
 331ouu7vIZZDjSlQPuKVII2qF6Icup9hNWROOxwtAdQSk0NB5QZlj9kG9OA==
X-Gm-Gg: AR+sD12XtJb+caOU63YA0W4W933usznhX58x88OlsS9rmwhzF1Yst5w9kHpIqt0H+4w
 ehUUsgltsAMHSM4vRkKxPVPFUsNboafDc6J41J2Wp7u9KsCagXhhaZYQYJKbEE/6JjxrMNbFhWD
 gercA4OzIn+Ktwm4RfOsBBlCXTFqgapKwrsbDrP3eQKU4rUc/Mn5e1ydFdcCVebKvF6q3R4J5vy
 c1Qk6tkFR4iQajU6B4CeEQCeziiZYE5KtSPNumh9OIlpIXhp7yo4H99h6zhegEWmg7L7uEM0EuY
 r/kLSmiaa9Srri13NJxK7n6UaQVTATf8mmb82NkJz97ol7ocAIXk8Z8D4qRrlqP5jPUD1o2Aws7
 ewvRs81GCg5p1TxIiYOOu+dr5R3Hm03SQ9go=
X-Received: by 2002:a05:622a:2446:b0:51b:ee11:e71e with SMTP id
 d75a77b69052e-52d852fd473mr224734181cf.1.1786892117860; 
 Sun, 16 Aug 2026 07:55:17 -0700 (PDT)
X-Received: by 2002:a05:622a:2446:b0:51b:ee11:e71e with SMTP id
 d75a77b69052e-52d852fd473mr224733791cf.1.1786892117479; 
 Sun, 16 Aug 2026 07:55:17 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996109652sm71478465e9.4.2026.08.16.07.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 07:55:16 -0700 (PDT)
Message-ID: <d5204740-8f52-4e82-a9c4-a739b528e9cd@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 16:55:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/20] hw/arm: aspeed_ast27x0-fc: Store boot info in
 the machine state
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org
References: <20260816131300.51799-1-bin.meng@processmission.com>
 <20260816131300.51799-3-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260816131300.51799-3-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX8r8m0Eb28SOL
 XfAgJ0XA1J65M9ghEKw7yrkjy5kyIg58rpSwwdXdeGTplFQSw4HaK+NXcm+cUFHR5njb1ogWPYl
 J5cj67g/aEcNCe5xnsF28tPGGiDAmwKGHjAY2w60l2F+lcsqTKFwlxZiBDZmsQ08Ind8D7HSbg3
 sKIBSRBrUdZN83bb4DxA3JbhVXjWGeQfrt3QcfMW6IDliD9/hGegf+6n34cy7Yn1MNEdwDrUr9r
 5LM/BJstRAlUsyKLLMumZkMJ0lT/edSWazgdmFwhVfKSDUvxMJFbxSjIdJm3Intc5F8pAGclCUD
 gK6JXgiCTZZwIzUbX2l6O2iZMyTcfd4pyZu2IpLafcXsh87Ogr0wUkEGEqzCvdTErEMwcE6iAUo
 /HsbcKf/M8YYMZ0wB1paRbAOXV07za1AtTIhsVmofdwD42RBE+kEeuGVUExcOIvIQC6jBDWf+sq
 gsQA8pWHMkpbDXGD0MA==
X-Proofpoint-ORIG-GUID: 00ejKb0AwIxgaxOc_ncSmbjrg4IAFSoT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfXz5LoBX3/r5m2
 NxpxRlMjYQi9G7U/pmOSyGMGW9qifqD5oJq+7N+yRNQtVtGQqpcHHRK5qWVcv0Ii92j1q5xEPoO
 8AZSmPTKsFLm0RYn10cFOonl05FPgTU=
X-Proofpoint-GUID: 00ejKb0AwIxgaxOc_ncSmbjrg4IAFSoT
X-Authority-Analysis: v=2.4 cv=dvHrzVg4 c=1 sm=1 tr=0 ts=6a81cf56 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=P5mgNStSnDlmL_58Bq4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160119
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 16/8/26 15:12, Bin Meng wrote:
> arm_load_kernel() keeps a pointer to the boot info struct for the
> lifetime of the VM, so the struct logically belongs to the machine
> rather than to a file scoped static object.
> 
> Move the boot info into the existing Ast2700FCState.
> 
> As in the xlnx-zcu102 and raspi machines, the boot info belongs to
> the machine rather than to a static object:
> 
> 4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
> 0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   hw/arm/aspeed_ast27x0-fc.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

