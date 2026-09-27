Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6705C98332
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqwI-0006XK-8D; Sun, 27 Sep 2026 11:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqwG-0006XC-K2
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:37:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqwF-0002fD-62
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:37:16 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R2DrWC1348872
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ry9zCqWvEFD4A7HnROvFUlZYcB4uXu5jJw5/0Vlor2Q=; b=bKfQ7XFGCGDoku0F
 UJAO1MrM4AzPggA37DdlGCIPu358g5HD4TFwDNh7gUhEsXd08mE0q8BadVLtAlMM
 mngFcRo4nCzfxZIprCQE/Dz6n2mrDd6KWf6ha2X2Vv7k3uj6L/VMp5Xmjqw2DBEX
 J+MNGESDUimXDwpMCF4yd/uNVA2WOs61GklU9+0cQ3auHdhtH8OdwEhmEMjf4bId
 XEeYgoUE7mD/zUCnX/HTT6sDwNhyRBUY3NpPEmx6sB0KxwgtX0kA+uJph0wvQVTn
 6JEVfN0QrJgsnbcAM4rqXKpzxCKK3cxg30+yhW33CkCyNDquk/Q9VMtk234vswtV
 t639tw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3dp3gvg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:37:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a0312937eso309124585a.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790523433; x=1791128233; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ry9zCqWvEFD4A7HnROvFUlZYcB4uXu5jJw5/0Vlor2Q=;
 b=CgosjO5FXMIbULnELzE0bFkyaOzCZHmOZBwJor3YTAdicQm+QlyicVVPS1ZnA/Zag1
 doQP5DJ4zHGmP2xIUmvrQhau8zjjBOKQlpOYTu1BxGmlMuKFbiJcSMmyuoCEI5ahNhUQ
 0iRWir4JS62BpOsNguc0Z/OPG+0egtwOmyL26DNCKq0uciW/XniCbY3oIX23StWpzmcb
 lY8lJu+8NWuFjTrm5UNdE6NWftsy4Fv/2BsNyGX9vf81Z/ZshnpkXhKbn4hKGwtg94sG
 n7L8TTB/7jq1nyk+aR24iw2Rk8Y3/f82J9fL1/Ar6KNRUzdfeZLjlhtPAgJmnI9muUTP
 be5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790523433; x=1791128233;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ry9zCqWvEFD4A7HnROvFUlZYcB4uXu5jJw5/0Vlor2Q=;
 b=Zu53smMfjArBsacm7glPCa4JSer21Z993s0vrb0/s1I4R+c5vTXfSD+ntDo8Cl180/
 H051mn1CmiChvPqRcAu+WFu/yy8DxjIaq7TqXu2vJtA2sFHemS8bUUwLXROcxfGRGw6t
 OEOaYUTJvm3kQYPntigZRXbRF96FnTwCAmilO9wm5vnThH8k+pa+8kCEdM2jgPdCO1Xx
 SSwyrVSfkBJbPIAYGF1ehDbp8p5lSZ8L6h9TmFO7NRSGF59eC6eROFnWrv4vcHng+SFP
 O+7FJH4E/Yj82IQtbDn+pAG4TL6Tr2+aYR0togISVesqh0xBhec/9Yvf//SHDPjOKXV7
 jPHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxebf9G4Vk6P3wQAKAniEdtqG08DcIIfV6Zr58kfXvBi6lWyevHiAwFGBLoVqzH/EhQIIarGBYyouPC@nongnu.org
X-Gm-Message-State: AFuF++kDrhKfO1OWywDsmT2twRBQgOv398IFG9gAkBzXpNqjfKkUpMCC
 Oj9Gqv2wZqxolxAtnnVUz4daTPCDf14LEulJWPFNYqvxBVxTb3w7Pezes3Dhd0P275t9jIwG6QE
 0eoSSiCGNmqgGycoavWoh6L1YmHsnoI/ocJseEKP6NLO65ap3PazbKFVtsw==
X-Gm-Gg: AYBFou3IRVggFq/4mT0RuAjrimJ6eXrjg1y8P0eEmf7xORrq+nkDBDXaPuYvUy7M3jo
 GOCYB9x41EFhuVcaLrb0NOvxhsAWbV6o98A1wuDsWUZbOZ5a1ILzr+LtsVigbbnqNGVabrLitTK
 nZntYHhvDzpXVD2rR+KRLU0ERQfrqcARFecQO3d957F9qIr53dEShTugH9sJYY4FSTICX2/7U8B
 2QK1jbyD67IyYsbq4H6cn8nOvlwTTjwBTjhXsjkKoBwRD6u7rhbd9nIv+aQ84A5E3WOq6XOwbe0
 X/YuMFYI10Hi5S/SIV/HtAxpdKmmWlentys8laz2OG6on0idYJ/x9gSklQw6GethL6+y5coATxN
 sB7SgRA5EdIJYzSkjCx6cdOMDeIM3N/dHmw==
X-Received: by 2002:a05:620a:d96:b0:939:3fcd:4c3a with SMTP id
 af79cd13be357-93c43bcaca0mr1571664685a.17.1790523432786; 
 Sun, 27 Sep 2026 08:37:12 -0700 (PDT)
X-Received: by 2002:a05:620a:d96:b0:939:3fcd:4c3a with SMTP id
 af79cd13be357-93c43bcaca0mr1571659685a.17.1790523432303; 
 Sun, 27 Sep 2026 08:37:12 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ffd137346sm93658165e9.1.2026.09.27.08.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:37:11 -0700 (PDT)
Message-ID: <98c3d2c5-0b0b-415e-8824-30c6e92aa63f@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:37:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 032/101] tcg: Generic expansion of tcg_gen_not_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-33-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MiBTYWx0ZWRfX89rgApSrCIJ4
 Om/eBZRsMaUXwJUeYdVLQ4cKme9EaqcIySe+m9OvSLz+prYAFH1tfgOjvF9r2VkwMWAz0CS02vH
 tevMd0No1Vq1o6VsuMcb20loR8dRv5yiW7a5mvbBVooF70IZxY6OcywD++sLOZIHrXufYjlCSQP
 jcTp3uYFMzmxSCGQWXdHCM468y8q/L5+1rvCSwl28Nvw3pljEMYS7UIeBSZgJ7MULJQoCV6Uhfb
 /jDqrhq4q+2WQYUFLQUuyy1t5bqWeWzszUhgXs44f7R6yo+InHn+8lA5yf045bPxkdTaHpdBrFP
 wnjDfbVh1sy52mGmNRNjMiCxNKMeQveL3jjsosLl6Fup867tk4t+g777+Z5KdHwY05KWqVUwVOw
 5x4x7pBRx7v/lH47Z/iEm7goDd6OJeu++RNT+K+wphg6Asopk7uU89Vpq5lZgwGaVsdp+sEXudx
 /UUC/deJudwMOrg9F2Q==
X-Authority-Analysis: v=2.4 cv=QsXLTlyd c=1 sm=1 tr=0 ts=6ab93829 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: C3gTbhBZcUBukSLYN3SDhwXvu3SJaU_x
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MiBTYWx0ZWRfX+uct+qX74UT5
 wR5NJSTEcEWR7DTOwtWFjQyohczYmAxX7kbyzC0/ANVJFf257ThUyfpVMeG51tWaJuWQjzQOLcJ
 iJOMg7Ap6Fxe/6Ovsp8VeTSopZ5RqYw=
X-Proofpoint-ORIG-GUID: C3gTbhBZcUBukSLYN3SDhwXvu3SJaU_x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270062
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  3 ---
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 28 ++++++++++------------------
>   3 files changed, 11 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

