Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609CDCA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEP4A-0000Rh-V5; Wed, 07 Oct 2026 06:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEP3I-0008Ng-LV
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:39:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEP3H-00081E-74
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:39:12 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jReD3298187
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 10:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lzJRKa/HQTPPvRww9hPJ5u8ABX5npk5rxYv0jmRYOfo=; b=hjMeKEWJfyOpYGCh
 p0t3qFu2rGoAtKQmjP122S0AhdUpkcocCUPrmNKHQIDxRnL+LMpoDUyZZBncLxpl
 r93gAQP4oPCV/oXJnNLM7RMKswZaXwr463B6hgns+v3IFQQGEE3YvemEA5qAO8F9
 yYlMaSce68qE4ERuU+DhEXyGHXpKX0lRoY4X9ZZrI2LZGKnydJTD026dUZihDh+R
 5w7PY6Cw+lpeTNPASkYdCCuZCRet2tmWWmWEPPH8GpNtMiOFUSqpqeC9jKJL2IJ6
 e68bH7PiPPS7FVwbEjx5K1f7c6iqcEJnnM64pWRo5bgLsMxj0z8W8jfiMOGZy1vr
 ke+DZQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5hdcrp2x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 10:39:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cc0b31ecaso837374085a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 03:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791369550; x=1791974350; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lzJRKa/HQTPPvRww9hPJ5u8ABX5npk5rxYv0jmRYOfo=;
 b=PRoa7Xvy3gXAtH6sLt6GwYdNq5ZIvR6AeXpxmO6itfQjX/kBXhNwgYB2si34o6y30s
 xDP/qrRqmOlMIqsXQ74B7/Lrm/8lSUpSAOhzXYVeaR4VXGUtiuhSoZ7VjG92OuEIJwgQ
 +/MxLXmaeYT8zlodc7hJNXxP1RdZyjVCpIGOzjefXvvPrrwu8atAS+jY7yvQed8hRboY
 dgOJBlEA/019VuLhzX02toyLvLTCUC/TxPgZJA4kKHhDScWxBXVgYcKWpiW1uJC0Rxpe
 rN6q2D+790QdrxjTgkYzKnEzV0gEe0SM++erfowaBd9PYMxafmmFsU7PSLcUB7DQZdGe
 nmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791369550; x=1791974350;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lzJRKa/HQTPPvRww9hPJ5u8ABX5npk5rxYv0jmRYOfo=;
 b=1xICwLPZVk2aNmoTG4VpX3h9vJALclcjtZIARxCze2xvOETa2Yy24PreixgfiMHsV+
 W/X/oQExhFQqpIxs6yA4sdP1rBXDs6LCR4cFN7+TbSrYTNZG7r1XwSKVxHMdm8L/ZJGK
 NwXk+ghW8WVkyXhn3Cvqj9/w+vsnacb07zV9BUOMCj2RKZ4c0NwPBadyiWNGd1EgHio6
 +XiqWH1oEZVChKLt/nJNogOJNurYlh/0lFZNXeM7B+z6XbimUxkLREepbnOmsQPxQwgg
 4xar1GUr9R/KU1Gu2H7RS05AoiRr/ausNWILQA/eZmkWe8oMfTJDOwy/uvLNlBu+sWP1
 0Amg==
X-Forwarded-Encrypted: i=1;
 AKwUvByOiEEazdKfVMpMEHGwfP4qb5K3xP6PpA/jUPm12k9se66pVGqkxECJze7GJluVYUYyqLupyKe/DzQf@nongnu.org
X-Gm-Message-State: AFuF++nLDvzIU28E5cnsDUEVrNslyEp+p3iKhGwy8NGA1Ygg1guFU30y
 QCh/GHuHCJE+seSaloTHrXe0xZNvG5DFyu92vXg9zUbBK2LN78MNzXzzYh48Cos3xTJynuIEqxl
 98UG/zEE+US8R8hS/fUbvHdjX6g1pzY6K+3D0BAM7zDig9/yy57UPRnoF/A==
X-Gm-Gg: AYBFou3tYVEQPbpxI0pIWTEzN8Jbaurn9sICC2kValqtcXtld0kopn76VZXJQ44Yu99
 wSf/N7K4xRYjnYg+QNdd7qpEAPzV7ohX2FfTKcC5/WF1qhjcxcjtKDRusg2fjmnGAq8QetOuTcE
 pCSc1oiWFAYI9bp4rtUbfzVQALRQ9lxmzWe8iCa6I+HzqPiubqQL4lbBXZVO3Y7M6dXj2oeAcPs
 IfT3MWpQLbUGF2Nxu4mhMzASVbR5QTvZJht06mJeKGVcQPCt3klulfzZzilERlPQXocE3Zsoik+
 oCzC4iCDrYho6tqdPP/t3G1bOPdyGOApcwlKHXXZhb3K3Kasl8G2Tm9UZKORDL85ppRaWupurpm
 1vJy2Na9zyU3JkeBodPXR0dmz9qCOJNoFyA==
X-Received: by 2002:a05:620a:2584:b0:93c:be5f:b807 with SMTP id
 af79cd13be357-93e9b76ca3dmr356459785a.13.1791369549598; 
 Wed, 07 Oct 2026 03:39:09 -0700 (PDT)
X-Received: by 2002:a05:620a:2584:b0:93c:be5f:b807 with SMTP id
 af79cd13be357-93e9b76ca3dmr356457585a.13.1791369549215; 
 Wed, 07 Oct 2026 03:39:09 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d2e2dcsm5380084f8f.42.2026.10.07.03.39.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 03:39:03 -0700 (PDT)
Message-ID: <81100ac4-f8eb-424c-b275-867e25a7237f@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 12:38:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/18] target/riscv: meson, add user and common system
 source sets
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, luoyonggang@gmail.com
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
 <20261007-rv-dedup-v2-2-8a2f0f296a7f@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261007-rv-dedup-v2-2-8a2f0f296a7f@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oEl4SV1cVIEFaf5dYlQwNf6roDpXz1cN
X-Authority-Analysis: v=2.4 cv=aKFlOr9m c=1 sm=1 tr=0 ts=6ac6214e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MiBTYWx0ZWRfXwWzvBdMOHoF9
 thspGHsTcSDJXrxK0sPiDJWVWJuvC0udNE5Cj5Uq2i3OIXLtcRdemZOUjQBWbMneg2wYzMCU/7g
 6HSLfvoO309r0dVwKO5VFejypYK12Io=
X-Proofpoint-ORIG-GUID: oEl4SV1cVIEFaf5dYlQwNf6roDpXz1cN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MiBTYWx0ZWRfX6UkkV9dsag26
 Wqw0g1bTAKYAoVr4eyRoYCI6hpDD3zkMXZFRSTaYIac4giizugqpQQutC4oBMlNocP5YuX+x5qG
 pwwglV8R6Mrd9KrwLHGLtQ22kYyTN9TSuLq7XJwKLH7itVi5nW7slUugFgn0WARpvkBfGR7mcpk
 T8gXWOzAOEMh0O6lECOdVf1vniKH0ijQM7UHQR+17GQd7qmevWA1Zp7dgNUDKHCaIXPnhwppjBY
 g4RhzJEtQBHA8fdtSb5Che/Si5IxKoV41oewf4j2gWFn5TIcgv+A1IY0J+fFEGyf4gXAcM3f8Mu
 R4UWuoDMA3pAE8m3qX/BCW2DAQ7xhtB3qzx1UDKEEslkM3VWD3T+0pGD8fk7OZf18WMKeQG2WlV
 EnWeF9WrJ8mPlLOEkQa0kfqyNYk1a6wJIv6yKvAcIltpHsoTAi3P+yi4ygEw3irCP6HU75KwBcq
 JFCj8CYHMRtXfphvhVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070042
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

On 7/10/26 10:43, Anton Johansson via qemu development wrote:
> This allows us to, in future commits, handle compilation units which
> need to be compiled once for system-, but twice for user-mode.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/meson.build | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

