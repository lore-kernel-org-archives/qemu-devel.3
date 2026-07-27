Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13882C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 08:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woGIw-0003nI-CV; Mon, 27 Jul 2026 04:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woGIu-0003mt-Al
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:03:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woGIs-0001ni-Pm
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:03:16 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R7SFfh3339673
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 08:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uPk+FJWrBphlWZKNeVpL628YMbFmEVuMnpWtZ6+NoZ8=; b=XdOC3/P990h8kgaX
 mtdyu8nlgfuYnBWwmLEGWPrWID9fRdEg+h5kdY3BdhoFHwYN1N4DAfDsQkT0tOBs
 oBAbzPSC2pCuVba45nhcvvgcXf0Ff2zD2ZRuYgE3VkR0RZiiwrYXHa+N7+/TXWAR
 nVYjppl33LEeUQMLtTvrvOk0gLtoRwcet/su9O69cP7rRk/TDiCzTFx3r6bWhU/6
 bLO63DhQnFKDN6iybluQ0MCopaWIyyYCiLAPv501GuudZ5/+3/NGVeGfVJHYCL/w
 ErEAburKhnfgWn0sq5XArEQd/p5896qCCj92T0its6cfiFIGU1m3iRamMT+C5CiB
 u6bNzg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmm3sd7qu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 08:03:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c083f1818so29828321cf.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 01:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785139391; x=1785744191; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uPk+FJWrBphlWZKNeVpL628YMbFmEVuMnpWtZ6+NoZ8=;
 b=fY2c8jzJ+6cjEBRTe/OOaPgsh0jMlXfEQ4EIzi1jdnI67jrWf21IFi8/Ku5tKkH7mL
 M4En4HORl4CmOtlyEO3fmiHwGfsOq45KklfZ8fsTR/8LbB3ty9V3fpwmdTGs8MwASS00
 WLDw0tszNhFCKsLbMb4f/3NIEB6odzd3APDGIapO2X00dF0zTaFpUScsjBNzGTuacHt+
 RKKvw3DOvJ6A8dUnMmtQiH5/obu+R7KKIqIOTVLX3OfoJZiT2OBo2pNdeqITxSe3+SED
 lsPcp0QZ+MbHcp6+2xjMz6HH91ri+kH/GoSP9/40X5aEOwMI5ZdTpGmfUbgamJfY8Iep
 MFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785139391; x=1785744191;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uPk+FJWrBphlWZKNeVpL628YMbFmEVuMnpWtZ6+NoZ8=;
 b=WVIr/gQw5e0Pz1DNaob2OUsHcgJlPVqJ7tBxFGJ800957gxBV+kWQzkV/ZxuUZFjRa
 L23fnqZyc77jmlj+M6ohvU8og1HhkOsPyExjYDPWva6gNdgSnCT21SGACmX172Y3l8bY
 KFiICPzB46PDZ65gd3okqyf2G1u7FnydOTXl3wy4hn5yIdo19U2Ww6meKq0V0RI3bwLO
 HzrR6YFCxwsJve7iJYmQH2t5MUTNDcuR2geihzdfaJWntniS2fkTLTdd6csRKQ6m6lF/
 qOuT+i4IBLrkJYCFnfZni8Fqmo3dT+d09quLHOLb8PPUtKCJKLTLsWh4C5fQkvLGtCjA
 VxEA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJ+ijFib6LbpKt0BL0NlLwDQTdBZlCzKc9nZp6jLuxdoehKX8zY5wpIQJZwUQfqamy3UYDZ6R6so/w@nongnu.org
X-Gm-Message-State: AOJu0Yw6BuwtzFRQLmlFA34FFazSFxfyVMlkaNne8d+/O3m08Vry89Lb
 Y5YmVs1iG6H06Hjlg315NlkkcFk1V6naoMXRL+yqeB///O263ucLAoDb/O56gIhq1c0eIgcIpHH
 v/JUpTsSFbNZpH5UInbKaY+GOLgsn7jFDsj6A+HPOekwcJZN1fJ1JiU9+ig==
X-Gm-Gg: AR+sD12lEv2vUorWhezd4tCaN7lbKSdlGu882NsKEi7DfHbNdJznUKWUrQfIpM2kZUF
 m60RDlmiBwOW5Ktqcivxfn2nTTnKLhO+OAVeLhUr40Y6p+Q2og6Dd/v5RKd7Nb2nM4nPu4lTZwp
 40Ndz5RMAXzjiC89GpOpoRp5OnytPjCyPdhQ7nDpmXffktR017rjjxQjDKu9BZNe3AAr6/9dVLP
 WoC9HFsrGJw55XScSDfY7NEeVV53kUeQC9xVLGQRtMIdOFvJhjWrmjJot32zsueJzxSTd+uWQIO
 /RMvHDhE6oRiUSG0fFD2iIKHtXvp/+9kufPNP9MHW36FGR7X/6fnViOm2JWQ3uQiV8PosLH9tsp
 tSCn0g3ot486sPpysvjl8c1SpACXVqgQbNSe0CMroNOoUwJMnOUc=
X-Received: by 2002:ac8:5910:0:b0:528:f72:a986 with SMTP id
 d75a77b69052e-529a864cb27mr77572861cf.44.1785139391488; 
 Mon, 27 Jul 2026 01:03:11 -0700 (PDT)
X-Received: by 2002:ac8:5910:0:b0:528:f72:a986 with SMTP id
 d75a77b69052e-529a864cb27mr77572601cf.44.1785139391105; 
 Mon, 27 Jul 2026 01:03:11 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531afsm50974825f8f.24.2026.07.27.01.03.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 01:03:10 -0700 (PDT)
Message-ID: <5d11951b-4fec-4089-a5d2-f4c4b6548c7a@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 10:03:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/14] hw/hexagon: connect l2vic device
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, matheus.bernardino@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
 <20260724183648.190531-6-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260724183648.190531-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA3OSBTYWx0ZWRfX+U+fs1J3N2/4
 62JX/jrFlJFfpFEYiOPGk/ax055SSBoCIAYo7pKUliJsNDxwqr0m13Vp23fGw4vBAi9ATldjPbT
 yKssXZuqi8NoVZ0NWFDOVby7dntJ5iRk3VxdpjG3475NKFlKDNguAhJhmpcNFveHP7ovcguXI3H
 b2fEDFF6MTPhBJ64+DWk+MK+4TfyHNWFaObdCesuabSAMj1rUEdnBt1HPf10XIRq6RcV0EhK+eM
 CgkO+pFSszbf8hz23XxUZoG5gNFO6KFXdLTQ8WrO0/4qPmAU5icwG///rBmP1h36bhGLQvXuoxV
 JRsKp492l+4QDFbKGpUQeMSVoY4CrmWvuhQCRE5GfUMgaLCgVMZSbjS8DFY+J6nYdJNlcgx2+Xe
 l1QPX5xGN/LIGwGERE3ce4faM/Al0ffIdfeFsBKnC8A8VcpwBjLYKvKy8VXs+L5thaAPFmS5zrC
 wpsW33eEqc5/NuCJ7lg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA3OSBTYWx0ZWRfX/EouTv1oJhT5
 L5j321KB4hpf/NtrDAtRozfNtAdAAXNt9i/DLrr4LoGCwXvWNKrnhDAFZl+VQmFCV6KiQu1VjHY
 807nUep0O7+mgJTxk0RrMKt4hyehYjU=
X-Proofpoint-ORIG-GUID: ldwtYR3qAK1a3DquEull9O1fpCUlUGJO
X-Proofpoint-GUID: ldwtYR3qAK1a3DquEull9O1fpCUlUGJO
X-Authority-Analysis: v=2.4 cv=KanidwYD c=1 sm=1 tr=0 ts=6a6710c0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=TYK4cDMJUXeyz2G6wSoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270079
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

On 24/7/26 20:36, Brian Cain wrote:
> Add the l2vic to the shared hex-subsys so both machine models pick it
> up.  Map its register banks, wire the interrupt lines to CPU[0]
> and link each vCPU, globalregs.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   include/hw/hexagon/hex-subsys.h        |  8 ++++--
>   include/hw/hexagon/hexagon.h           |  1 +
>   include/hw/hexagon/hexagon_globalreg.h |  4 +++
>   hw/hexagon/hex-subsys.c                | 38 +++++++++++++++++++++++++-
>   hw/hexagon/hexagon_dsp.c               |  2 +-
>   hw/hexagon/hexagon_globalreg.c         | 25 +++++++++++++++++
>   hw/hexagon/virt.c                      |  2 +-
>   7 files changed, 75 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

