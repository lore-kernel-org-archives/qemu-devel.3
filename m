Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94A2C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weh26-00021l-Tq; Tue, 30 Jun 2026 18:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weh24-00021N-To
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:34:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weh23-0000QH-AL
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:34:20 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDePY2948596
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Iq64WAf+M2J7bGKnLVuF1weIPUb3SOWZAPQhRshpvwU=; b=oOzWbj/RUkueMqf3
 p/o42xdvz52778pxQUIxV9KJEgETfB+5xMJk08/VVs1+LiGrfNwqTXHVw79VeFeS
 5DEEsOdW2PwGUh4ONL7pNU8JGfVmQ5/iIiCccY/co8XrJubTZiQI168HBIBnVHur
 LcGAT2t62ffJeVfWX8Lv2GKVvOLFZbhRJeWnQ30yUEgHbPOYD5l7Sl5lSkW1hP/x
 XGH4wbc89p+Hc7Lgqyw5cME7HUg1YNWVFp8uup8y14ZWMqFccTkPiwHrR53m1dhx
 MYjvf7AM1PpoN53UHtDhDR+toBzbyUOZshF2tmPiav3ZWSxLzgPDnBOXC3n3mf6Q
 snXnIQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw0swb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:34:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so1116885a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782858856; x=1783463656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Iq64WAf+M2J7bGKnLVuF1weIPUb3SOWZAPQhRshpvwU=;
 b=PE5CulnfVI1clz75GRZryL+lP0zt/BsgPsWl1WMZw+m/WnA6HSSx7S3SH5OSoA0dm7
 9ZGPAMPNGKxCWfBM4CfcpQ7BKRfs4T1qlpb/MZawPS/AAVz5E+gmb0na6104Erh2R+Nj
 tM5XOcxHvoX/QoEf68Kiq5HRfobLMv3boyvDEu8EQyL+AFY6jfYMRJ3W35Deb7nKOGLm
 qripEH9puQG7j70ZXwpSVzjFRtC7bqsUYGBLBrRICYBlZ+R6q+YJ2OjDFmU4p6ZTQars
 jAFNQz5dF5+IqkUcnQZQ5IAPiqQiwxSqlY81xvFoHKxY3gbDauMmm8IJ8KhEfPpoyOHH
 0V5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782858856; x=1783463656;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Iq64WAf+M2J7bGKnLVuF1weIPUb3SOWZAPQhRshpvwU=;
 b=PGEUTZCjQyPUsXXOkw8Rx4tqT8Z1HgDpt1TFX5Na6vZUKcTZkpr4I1HDO1B4QMt8Z5
 gMi239ML+z9KCs9YhdT/OVt/4kXof85ELxBaf5cu0tXv+SG/AkNCFifz9ZHEEaOzMBKe
 s+BO7d+A318YB3RNFyPLq8VsQdPztMkFzxitOXFJ79CoRTjc/GB8MlDLzi3GkP91QHOv
 PbqJCiBzGQx2UwHH6zfizbc8twzZ/7xZoNmb6X7Ng0M0UAUmAf+ReGedJOS6gioZGFMB
 YfQSZYb8tO7+vTZDIvgVeMMG8fIAkGBfSeOQ3Iw4+4f9LKAvIFmFpIjcTfJ+VoRQ2NNu
 34/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vXeJDa/TE/XWB9awYB4/x14UVMi4GyMehOe0wSHyHqPebLCXxURkU7DsycNBLRlb5JlvIVgfXBlm5@nongnu.org
X-Gm-Message-State: AOJu0YyMvU1kWaTYowxQrkoFCF4yFCHJlWe290rt3zkC2+r6HsxaYrTm
 d7gdKMDfGC+377WESnn4HZyJT2tOz/6ZaXZvzZiZRzXvSD8jIhCJ77ZZmlziMbtfawhw9yU/u6Y
 e48Y7dTIbIux7d2DEbaz0KpRD3J8i2KVwAyon3cNfYfnIIoiC53vLyS0d+w==
X-Gm-Gg: AfdE7ckwv4yefkwRyS8gSxe+XFlQGUF7VqGJf5W65RDIYIv3RgB1uqar5cwXbQhAGD2
 F2A+22ssCtsaiBA8q0/KL94FFII/Ld9dzijYQmxerBpunZMXPqOI7fFk/NuIr6DwqtDfce9haAZ
 ieE9yOtuWMEjAHiX2vHn0yfub8iXoK4y9wvLij4V6WhOSvpwLsxPy/89OFl1EuSzwUPp+NeY4cO
 FVEvLjwP7RjoL/Ux4S5E6Ls2EAjlSmETcrRwIDjiM4xJOAZ7RMTY42N5TeEbGwcIRnU4coZGdIt
 jD1lIW5fYwoDvdPxzngyyHHwSNKs+5n/bzMqToS5E+RrOASs2ge5twRnQes+WVChRvfzzHuvsRM
 lAAkLNuK3N63B+FYzr9GBcTaLMK8LYfLRTK+PQSYhirnULNniqDtFqTr0yMlBAQ==
X-Received: by 2002:a05:620a:3713:b0:915:83fa:b3e0 with SMTP id
 af79cd13be357-92e62462fc4mr909124785a.5.1782858856211; 
 Tue, 30 Jun 2026 15:34:16 -0700 (PDT)
X-Received: by 2002:a05:620a:3713:b0:915:83fa:b3e0 with SMTP id
 af79cd13be357-92e62462fc4mr909119985a.5.1782858855567; 
 Tue, 30 Jun 2026 15:34:15 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47563d194bbsm10140436f8f.3.2026.06.30.15.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 15:34:14 -0700 (PDT)
Message-ID: <3697e939-0d8d-41ca-9af3-0729ef589bd2@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 00:34:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] target/loongarch: do_vldrepl_vl: Fix endianness when
 reading from guest memory
Content-Language: en-US
To: shankerwangmiao@gmail.com, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>, b4-sent@kernel.org
References: <20260701-loong64-be-v1-0-9c7d65e00697@gmail.com>
 <20260701-loong64-be-v1-5-9c7d65e00697@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260701-loong64-be-v1-5-9c7d65e00697@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a444469 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: agIgs_aEq651DcINbTV9NufcYzsDd-pb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIyMCBTYWx0ZWRfX2TWJiZrOed3J
 7qCLbNmsWgOkERzB/azL4Rv6Kv54Fu2RRsvcIk3el3XFo6WGhTyWU0ajOnI7uMuxc8l8/tv8BRP
 7/FULjqWKgcWcckfFL80f2ZOsGEf0XI=
X-Proofpoint-GUID: agIgs_aEq651DcINbTV9NufcYzsDd-pb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIyMCBTYWx0ZWRfX1ui2tTMXqzGA
 AwRaBnTg5RlmL7YuvAx0sgJRjubeyvEuUZXY3iqPl3Z8gOfkiY6rua56ry0Hm8tqUAczIcOdf8x
 de/YpK02HzKGkkAoJDK425U+JtToitKvZI8P9fP4INSJPA6FGXF7zwds0Kgob4uY6qk66+e5uMW
 r3y3KjVl1Ju+42B05rVH3qMSaYmTYA2kqZ3TrE0LDpWMvd9AjivMb3Jy7R3Me/f/G6k/dXVzQRJ
 TFtvabX8ybu5ElkyDbJCRIBhpUipw6DKmHvQ+utK+f4TG4ZfCwHaj6hsBdCaoAgVNandipgNuuk
 kpLAtbMsbMODS8VnDyKIwKYSub49Vn/R4GUnZxPC4nU496O3SznxboSkUOhX4WcvQ6R41dGl+Lj
 sfnPFRqUBuz6Zv/RB2POMF+oHn+u9Ql4cGck0Z8YsT/ENXLythMMiptR0/sNk7QIh0yUA+jc2C8
 6As6b+uW4lhJPYvtMaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300220
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

On 1/7/26 00:15, Miao Wang via B4 Relay wrote:
> From: Miao Wang <shankerwangmiao@gmail.com>
> 
> When reading from guest memory into vector registers, endianness should
> be considered since the data in guest memory is in guest endianness and
> the values in vector registers is in host endianness. Add MO_LE flag to
> tcg_gen_qemu_ld_i64() to fix this.
> 
> Fixes: 4a26512f01e0 ("target/loongarch: Implement xvld xvst")
> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> ---
>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> index 03938b1f052335190cdc437fc2d453b4f4fe16a4..91b1e15b61cac5d119892df1abd2ecf8a4c8e59d 100644
> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> @@ -5397,7 +5397,7 @@ static bool do_vldrepl_vl(DisasContext *ctx, arg_vr_i *a,
>   
>       addr = make_address_i(ctx, addr, a->imm);
>   
> -    tcg_gen_qemu_ld_i64(val, addr, ctx->mem_idx, mop);
> +    tcg_gen_qemu_ld_i64(val, addr, ctx->mem_idx, mop | MO_LE);
>       tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd), oprsz, ctx->vl / 8, val);
>   
>       return true;
> 

Missing counterpart in do_vstelm_vl(), otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


