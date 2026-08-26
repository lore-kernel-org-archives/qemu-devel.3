Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DFDC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzH5G-0002yY-TB; Wed, 26 Aug 2026 13:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzH5A-0002xl-Ah
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:06:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzH58-0004w9-LG
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:06:36 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGuuBe2103523
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x+vHbcCOGg9r3Oj2tQqjK4YN3769UUMamEjDLlTTcGs=; b=dlz+86z082Ls6bQd
 0EfFtqX37KoOh0cwJPBjYphtLwJPbanOY+xObYsfqx2E7pPGRufkmWbymhePmQ4n
 rYg5r39Ivx0nfOkHOMuD2DkWojJtQdOVjMDZwYiiOdcGBIP3AMG49vDB9VDFsOPZ
 R6VC4H6j51JdG2PzCtlEmI0DqjuRyQgTSAKfak5o3V42EwpezS5u1B/GEkQXKEy9
 woKbgv5RPSZnvFUuMuYSZ4NYoWmfnKoK1Vk5YAoQAeGB0XWsMRO4Sv/6Q//i2zJ5
 NC5v6ILksrW6tv9ukGIZGiTwTKAc8EtVyaUyjh4a2ysHHEsvYSb4xmtDJ0+3cBf1
 OtRmFg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga0wbrwpk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:06:32 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90cd16a0bc1so7542016d6.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787763991; x=1788368791; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=x+vHbcCOGg9r3Oj2tQqjK4YN3769UUMamEjDLlTTcGs=;
 b=Xfkihknx7IEzsI+gOicnDTCs43iqGVmyE32VgqGFPnQoyMkYDzdK/J3j9vPXl7MvPj
 X6YbJS2TnIIN6TnTKKrLVorBQTZ+1lUKr0nCRQraYxoetrf2eUwc3V4t2sWgWpsuvF51
 uBiHPCWvWEb3RRyJ4FkyC5LeqDh0+LkZ3/qbKc6yXvn0/waoBKQkbWdBgdPbwTPYTviv
 czyIAqrQiGCIMHp2+Vc5Ll0GwX7N+VWyu7IrJdkxaGjx/2604tDjQ8JiphV3aoks9zf3
 ni/FT4U8PUGyyKYGK423cOyHPDemFyX13SoJE88BkPxOK7TkfbcYavpWrAXMKG2w3+Mt
 SY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787763991; x=1788368791;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x+vHbcCOGg9r3Oj2tQqjK4YN3769UUMamEjDLlTTcGs=;
 b=cRUERMJwARFPxjYNa3fG5d8ypk6SNg7un11XV7DnC7uYd7lxvT/9Lpl82eZkPc/SFw
 JOJh20t7/vtQPFRDlkl+x0FFikDIJuPF78Y9N+phD2lPvt4QBVn0UpyXpfdGOtsb+KyZ
 6/Pa+aG9khqFsXuxS1/2ATlKBq80ilv5dH3XtnY8vF0gnIqIzl17KV+gl42EbklrEiAW
 HKzUWwdQoh93zQrLuUzOIcXfyq8YyEpWh+HLg8CVr1o/59WBQEkTBIAiOwBblbg03drj
 GzjTNRr3FBa03P+KcJUQdVelQVPawTUTVP956ZRaSPcJv6eWbziVAxipyrSqhzMdWF1n
 Bp5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RooCSFUoArAT4SV7gHAAQaIi4jbpi+P5BNpq5HORPTwzMsBJMzO+UWEpV8NnUE5i3p0PgAZy6+VBo6t@nongnu.org
X-Gm-Message-State: AFuF++lnbTsEf0MqT9N9yDZRNXTa7HNeocplZz68AwtsAiNymKC8R3P8
 M+WSPj7n4IdHIZuEiqYcL4Gr3qsIeYyUmzWm52fV5ACvowzsCcBcmBRRiH19H6rF4xOTc4mQjxk
 t22d0uMWxbctA37zCaj+LDnFKcf0vH27arDj4cSvld4Z8uYvNijRPtOi7RQ==
X-Gm-Gg: AR+sD13LSVW+0BYzch+2hFkqufjdpyK5Q57H4p7wbddkRpbL/jFGyS0lNInxE/qqoF3
 hLrWz2mWpV1rc/ztsyHBGqdT6ot8+XMrDN0ZFKToVTwD8h3mEZajBaSk0rb3rCkYU56mU+lijiq
 dg39ba41Md8X9paSzK0EfYaw9qAscqqazO034LIlU+pW2w9A4XLRm/PbK4abBIUl+nAjCQVr+iH
 KyDMlWPIacBgOEVlMGLs7uYtouX3wXCHTtJa1WnsWpnC8EUNf1oR+GTt94gzZMwxOPk+A+hXumo
 zrhPO96vtRnxWvzEo4p+SFJwHWAHkj3H+tmMY5jVraLfKibKInDOkdTUXMqoFKTc6dFWovcoKPU
 up51pEzC2IZOYqdVJCXRiY8koGyFaVxefQcH5RLCvpxI6
X-Received: by 2002:ac8:5747:0:b0:51b:e92f:ec5 with SMTP id
 d75a77b69052e-52e4222de12mr87735211cf.3.1787763991347; 
 Wed, 26 Aug 2026 10:06:31 -0700 (PDT)
X-Received: by 2002:ac8:5747:0:b0:51b:e92f:ec5 with SMTP id
 d75a77b69052e-52e4222de12mr87734351cf.3.1787763990880; 
 Wed, 26 Aug 2026 10:06:30 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8b5fd6sm5281600a12.1.2026.08.26.10.06.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:06:30 -0700 (PDT)
Message-ID: <a434a0e7-f603-470a-973c-c1e3334ea200@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:06:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] hw/riscv/fdt-common, virt.c: add
 create_fdt_flash()
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
 <20260826164814.44335-2-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826164814.44335-2-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CNXmOmx_X7mREaPoFD7EDpIykgha4mhX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0MyBTYWx0ZWRfXwTXmMw+b80qb
 MDr8jXgYtPeRpYaS6RMjQ9lc2PAZQRypvkLg6n2eJNwpUG4K/R4ufeFyrV3AdQypxbICYo/4EYq
 IRxVbWmkud49FYTvugon9Nz7Lc0l2o4=
X-Proofpoint-GUID: CNXmOmx_X7mREaPoFD7EDpIykgha4mhX
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=6a8f1d18 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=0j8F8ELDiVD0ozaknXMA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0MyBTYWx0ZWRfX1P9LzeaXh/EI
 ZAng4v4TVwjWwnLcMr3LD3xzyc106tVnDb6LEtBhq6BHLFv3cQ7YBz7ef8O441XiC43fXXT5akW
 RIqgk4m0/2OILxdfNdNgYiAICK3+5Xed2L05aw/ce4inGRtVRakXK9GRTIlpeaIZln5h4u4aJtt
 0mN+XQaNGDDKLv/lyxwK2a9i4kyZ3B0ZM9Jg6BUY0bs1XpfgVhLG/pmTmmpjdbIpVboc6Y/HfqM
 G2FFs6vkUCYGGcbu6147bfwfInlPHvWrHKY/+h9Qyhxo/u5+n2XrILWUKJiYU5mWYPnswRNzk8D
 kyv4YYCT18wpY1B8ucDdGS0tQoX7xdK8DoGV7/5k6Y1k1KonN5JegaLjDy5wanaFTz55CF3y0BN
 ssV8nqPyXIT2iC7jRqgmKfnuXJiqMAlKqeAVmrt3Ga6Fj3HrOGq6GXxDAEjffQb0z/hEwTwtUVU
 fODZgMAj+VP+njM+uhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260143
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

On 26/8/26 18:48, Daniel Henrique Barboza wrote:
> Add a common helper to create a cfi-flash compatible flash subnode.
> 
> This change only affects the existing 'virt' board for now but it will
> be used by the future 'riscv-server-ref' board in the future.
> 
> No FDT changes intended.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   hw/riscv/fdt-common.c         | 12 ++++++++++++
>   hw/riscv/virt.c               | 18 ++----------------
>   include/hw/riscv/fdt-common.h |  1 +
>   3 files changed, 15 insertions(+), 16 deletions(-)


> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
> index 1729a6abc6..6e438e0278 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -36,4 +36,5 @@ void create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
>                        uint32_t cells_size, uint32_t ndev_sources,
>                        bool numa_enabled, int socket);
>   void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
> +void create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize);

Generic comment for the whole series, if you make this API public then
please prefix with 'riscv_' to avoid name clashes when linking with
distinct targets in the future.

>   #endif


