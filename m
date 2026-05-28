Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08C5CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 19:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSg9d-00031b-J9; Thu, 28 May 2026 15:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSg9c-00030s-5n
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:12:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSg9a-0004fY-0l
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:12:27 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SIOdVN1064841
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KokyjKd6jxuUMQ1Fi97pxhPsMv0ZViojan4rG781nqU=; b=XW2yGRkAJi9aTc5V
 LcBGMXeV7Bv7feVJkTw+tU4ZT25+t8fYiwtf4odoD42WgvfJ0ZVR2fKJIkTnpxvU
 XTNdU8g7pJT4qiQ4RO2yLvW2oA3ZNaIDiR668+krLFsg6+xnG98JS61AjP8ec5F6
 nv7oo9iQEfWze1QHQv+vJkdcURdD0aE6gWCNwC7bYZmXolBlG0TKt4s6TdzmXRHr
 7aelK5khwYYPY/X7E7k0WqFhWikyelfAK0G3rOMk+doUBpB8ZNT2aO24SqYmTUfy
 72Dkc3P2GbstD3w4aIKBe+A/u2JxOD4GBp4X/MAN+saGLqHCfzyGvhaNXl8l5Hu8
 SoYCgw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety5r78u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:12:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304d8e9563eso2701106eec.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779995543; x=1780600343; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KokyjKd6jxuUMQ1Fi97pxhPsMv0ZViojan4rG781nqU=;
 b=hZ6V7qSlB/pQA+sb1KH0v9Q5Nwv5Fedv1GgdoaYFO/PuMOu6O1r5FViVtowWwl8WXA
 7shVPBOZUCNqM+sIZKIhKQFxI5tg0dEmLtzWlTTp6Kk53oOx8ROXYcEoZSUDHVE7L9ju
 GqGlWzWoqXxix5yEo2eaRPWgxBM1ZgminyYbgaobNZJAr6VYo403CHyDxmGw0/k0NmLb
 NhzbMbxOMC2zfiRvn7hE271xKkj3wfSIzCxc27fdkwW7TOfl8AgZUGMqhGdPejTqRL3A
 mXRDLLKuL2uCvCqo1Tg+0/RtSM5bSogFHEhQxBw7SsxidHmJjEswiBEUDKnjIdzSqI1p
 Bt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779995543; x=1780600343;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KokyjKd6jxuUMQ1Fi97pxhPsMv0ZViojan4rG781nqU=;
 b=VdNN+X9FZacSDn5Bivf5+9oJG/iHqfTN6mYK0AWHfWZ0k/J5ZQsar1y35wGRSiPmoM
 iZcQxf0t3Pr9bYEVkEpr9fkdugvSsjCZRGZvEam8CTwjIVUc6TZgMgzZOHs1HoLdfk95
 RCPIL0uNZexvyCBusbtDRmQmUnkWRApGUS2RpRt/F5Ji/9VM5XaKdV+QzZPi1WvonxII
 w/4vLUibnOm9PPoXHm9BQbs9LipWilLeQcudMsLSr0z6oc7GZJMV3XhYoV6XHMAlRBEQ
 TNWYaa5Hf5KCsceK1WsiIkfw703jDHQYHIUMJZkLA5uJ4NAueUGFrwWlc9+qpr+kzBP4
 wwVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ932MuS2vrn2qj00ZiryJnu+Nhnd4RQAebVXkynD25hEC8BFRNy8nfuPHna6HR0I5e++R4PJyzEyZSV@nongnu.org
X-Gm-Message-State: AOJu0YwO3FWmcsNEGNtEEFVtAspYyPkJWdV9Tjl484SVgAYET6sx2DnW
 rljBmd6sFwu96uq/udz5dZyt/eLEADZbSrn3yKc86VgTnL0wiFheaeoni20CM1KmNiPDruf9C3/
 b4I8qs8tFe90MK7OVEaZA4U+r/KWevvA/L6RJkEJ9pBXJchojeyMvyljs+A==
X-Gm-Gg: Acq92OEyUn3qghEA1Zyu8DIRZ8mqM1RK6+7xQQGLd95BFzoiXPHMr1POjXsXoR9gIl/
 PwxZLtiBe/HrzdILrjJ5pIuT8AVeACrZulVbpcBP8zwgTmksgQkr66ap/Q2g+l0071honVxg8or
 dh0eygZMyVVDjYcQEBHqgvsaIlQXbSkyMmOAEwIbm5UIRaL4TN8lhXxJNlkUOtSRcseIdrVG4Jh
 HrGUPd0wTGUM1Tx1Hc5sUa+CWlHvpCCpSTQQsY0bOH8MI43YFk8OV55e1xh6zNP9ccDVOqZj+JM
 64gfJOcsDwwrsJmWdVU8GVqisjFTd5OmACn1xri+c7yI/3OGAppH5RsE7EcxwVWyivPmrEmdhKR
 sfj/kR7MMmu9+ozPqFqgbocm9z1OHYo85ArljZsv9bU6cgPPc/sZOWXHqGE4BfWWBAAfM4TDVI+
 BpD8bvGk5ObG73NySQSb/cPq8s
X-Received: by 2002:a05:7301:168d:b0:2e7:c701:aa85 with SMTP id
 5a478bee46e88-304e9137200mr134738eec.17.1779995542823; 
 Thu, 28 May 2026 12:12:22 -0700 (PDT)
X-Received: by 2002:a05:7301:168d:b0:2e7:c701:aa85 with SMTP id
 5a478bee46e88-304e9137200mr134715eec.17.1779995542318; 
 Thu, 28 May 2026 12:12:22 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304e971361csm114094eec.9.2026.05.28.12.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:12:21 -0700 (PDT)
Message-ID: <9b1dc3cd-e749-47fb-866b-803d228897b7@oss.qualcomm.com>
Date: Thu, 28 May 2026 12:12:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 01/12] target/riscv: Initialize
 DisasContext::mo_endian once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260527201348.29511-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iFdNN1t6AvJPy_l80viMuKb5YOyLFl1o
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a189397 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=ALku5c8DAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=7DLw7mqCjl1eLh2tDsAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=Skunnq644UPbuD6fT1yj:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: iFdNN1t6AvJPy_l80viMuKb5YOyLFl1o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE5MyBTYWx0ZWRfX90iuTAlkMID+
 xXcR8hfEAhKedACV2Z6LzpxmulwQf5hSU864hKgNhj0QcX+ZIArS4DYa/eguPkiGSfB/C/YALqi
 uT6JKsL5x0iG4v8wZquzoZ6MFgi1DAiXrjHg3/7d3h0k5xkjC0ZR1O2Y6OABgMvRoHGnMHpK/Eu
 x1ZJLPp8GL2fY4UfUJvOU0E90sjfWNPE0MpP0/yA84kmpjeg7NSQIGZ+ccoRMUga7cK4i1yswvx
 W+HbCSyAwZkus7uEyRzhnRMjot/rCuup+CkC63+7yhQCOfiu4F8nPuD5q4SlyOH5u2bA+T3/i9q
 fYp4LqOlgkdFZCdyJukPSeWp2kRbFTE7+SWF4ew7fV+f4HCQfbahovtluHBSq5UK2/gvxP0c1or
 mz8yiuW3y/sDCCEMR6GX6omdQh+sHKX6xWTizyA98hWolWDZuklvB9TzrbZwxxJueXD71quxzf6
 6L3Ou6fLGgajokCr2+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280193
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/27/2026 1:13 PM, Philippe Mathieu-Daudé wrote:
> The data access endianness is constant during a translation
> block; rather than calling the mo_endian() method each time,
> initialize the DisasContext::mo_endianness field once in
> TranslatorOps::init_disas_context().
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/riscv/translate.c                      |  9 ++++++---
>  target/riscv/insn_trans/trans_rva.c.inc       |  4 ++--
>  target/riscv/insn_trans/trans_rvd.c.inc       |  4 ++--
>  target/riscv/insn_trans/trans_rvf.c.inc       |  4 ++--
>  target/riscv/insn_trans/trans_rvi.c.inc       |  8 ++++----
>  target/riscv/insn_trans/trans_rvzacas.c.inc   |  4 ++--
>  target/riscv/insn_trans/trans_rvzalasr.c.inc  |  4 ++--
>  target/riscv/insn_trans/trans_rvzce.c.inc     |  4 ++--
>  target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 ++--
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 ++--
>  target/riscv/insn_trans/trans_xmips.c.inc     |  8 ++++----
>  target/riscv/insn_trans/trans_xthead.c.inc    | 16 ++++++++--------
>  target/riscv/insn_trans/trans_zilsd.c.inc     |  4 ++--
>  13 files changed, 40 insertions(+), 37 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

