Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A7A606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RwrSrmqz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RduNWmGr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTSGf-0007xq-DB; Tue, 17 Nov 2026 18:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTSGb-0007vU-C3
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 18:07:09 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTSGZ-0005ef-NC
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 18:07:09 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHMf4GH3559162
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 23:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jf0T7rGXiVaUhzzYSlJNd/OQ2v+mnS1TkEJeYT1YwGU=; b=RwrSrmqz/FAqays/
 /PvoIrYeuZFNMYQJy38uJr5+nL5KGu2XqsJGt0Yd4xIw+c7uFtMRrDKlLtwgORny
 BflbcivwNdBIW5z6rjM5lVQv60CEQrqcXtqKRSwXMHIjTs2ECcdH7bQ7kLDQHUMA
 4SBmBnqH6JhGUSjtm9j8ZS41XV9TkS5+btQfmZ00hQfesemCEG4gn/gR9kKamSqs
 oG6BhGbZuX3PPgGKK6mc/daFp6jq0amA3a7K4dvT6+79O33JP52WnEi3pn8s/coM
 BvWK0Twi1zAFIGBjOeK6SNhYQlD0TuJxPS1xsJ0XU181oau2JCBJozmny5VJAArd
 GlGIdw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvcg5et-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 23:07:05 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7cc06b9ca9eso75168137.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 15:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794956824; x=1795561624; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jf0T7rGXiVaUhzzYSlJNd/OQ2v+mnS1TkEJeYT1YwGU=;
 b=RduNWmGrf/mZXckO0P6jUs/Qv3v8X8EHIZmNfa3oDnaB4gBOxPImwy18bvSCmPCsLe
 rlEeHAHiWaJS4WtERy9DPH8nNp1xFzJoCZhVTrwIn8PfphLuUcDK33drJa8FBaJR+f0T
 tTnnWKKSsNQseRCUrdxZLfKmz5k/b0Do94WyN2FhLMXVt7PglezGr8QVx2uSJ1ung9KF
 1sXMgAJUyz/2LRoeEMau7xRONPknnWelkJHTscxgCDgDvFcF4a2E/mpqzMbV3AEvNRhh
 8yPdNZmV+OoJFBd8lfrJO0UL60bB9LuMEUeyofhMcUCnXavLchw2jkdFs+K5/rGEoMRB
 /vfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794956824; x=1795561624;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jf0T7rGXiVaUhzzYSlJNd/OQ2v+mnS1TkEJeYT1YwGU=;
 b=Vm8BWt/hQ0mCJq664YHQLZ1E+WQ2wCxL7rR1ZeHIlHaev8hqdXCC+zjmcJCTShGuw+
 HYnW+zioIRGVt4kdBJTiOwXR1M1FfkK0sA5eZ9//O2eb+UtJGnyp59JxXrPM57hCbACf
 Ob0iAD/o/EVebJyNhqTMeQYsHVwZMyFRkOQwV61oqYSi18xH2a/EcTtucsbSIYa/wteu
 2QMUVYj4zaubbv0coF9MV5odSbnCk4M/ZVFjObwPkx4E/7TveJk3cZBfj1uk6IdIpfgv
 ybXBE/MtonlaPSLZSh5zVuyRgx/SIWd8K1JzNKcw7EpbEk0NVLRsworWaZ+K6ko6AJrH
 Tuxg==
X-Forwarded-Encrypted: i=1;
 AL+hErH0Clk1A84CBeoDa6PQlE+qvzCsZI+dzhscwsI56FsBw5n2lxzV1VHLupgAyGiNEleuSE+TYL2c61KA@nongnu.org
X-Gm-Message-State: APuU4Z9lf5eyq8eRefMkLCfnPJwcmgS/PyLwKR9nhXbG1bLksb2zr2/v
 p5pmAXof1osR8ApOhBui5OPd2qj8NoYPq9WHlZQN5d7gIeiSuRX8ctClc01noCACJYqrB449rru
 6N/NpOH+MVdy395R/rbwC1iFofaogy2IvgpfuJyFUGiR3ZCe1vUxBzbQpzw==
X-Gm-Gg: AYBFou0ICtuRn2EesLxItlX9NlzjDQNQ5fgeuKMY5uJeuoox3R/vF+mXDXBlpF1oOUx
 pVgV2d/ByCirlJjtRylLrGHN6z+rHY4gpp7yTDtLNInio+/LFoL8lpmBNlyREy4Koz8SM2eC3JS
 +1zS12KJiZSba+z+B7V70tXROQ2WOcFjdiuxMUr0nPB6z9Sazwlhlk/QKy7ngQt7vCfZa4OTYVZ
 J5RiBuEVQSUuNqPH93SsUkWMCB7srsnWmDct5IGHpEkw5e86GdqhWuCIQBWKsAF48Jgz9ZjX0ub
 zldzoG9vI1VPav+yWQVNdne8nYPNsD+w5/OabYlqbFVrcAR9bL/4qVdOgHaST9LfZXsHf6+B868
 aMD+MZr+0sTp2vYypACu49rQSPKYPI7R9ZfvaPuXa7yjWPdrXWUNJdChupIEmZ/u/C28TVYmO3N
 /YyfNyRrs=
X-Received: by 2002:a05:6102:f0a:b0:7d2:75bf:2fd6 with SMTP id
 ada2fe7eead31-7d6ba3b1353mr198086137.18.1794956824587; 
 Tue, 17 Nov 2026 15:07:04 -0800 (PST)
X-Received: by 2002:a05:6102:f0a:b0:7d2:75bf:2fd6 with SMTP id
 ada2fe7eead31-7d6ba3b1353mr198074137.18.1794956824081; 
 Tue, 17 Nov 2026 15:07:04 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7ddd4614sm9245635e9.6.2026.11.17.15.07.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 15:07:03 -0800 (PST)
Message-ID: <3d1087fb-e42d-44aa-bff1-a23f392fc015@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 00:07:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/19] target/mips: Add the NMS check to the nanoMIPS
 CACHE instruction
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-10-philmd@oss.qualcomm.com>
 <224749bf-2ff8-4311-a19c-8a92721cf8c7@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <224749bf-2ff8-4311-a19c-8a92721cf8c7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R5OWitRX c=1 sm=1 tr=0 ts=6afcde19 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=H2C-zZ0mRBWCpT8mqFQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: gQYgYScWQd8MhmvbCSKqv7oZ7vpIV6jb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA5MiBTYWx0ZWRfX9xfhfTcCDVyL
 MNUIT3qwLVLBr58MjVcLb55PU+kvmxLC5WbEBfsBUrB2jhb29oRd1PmqWKWCPqSOsHekqyEDhZl
 SmCztlCPK/0T5Jvfhl95Plw68KxJj4Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA5MiBTYWx0ZWRfX3If7M2j3cGOW
 3A26AKen08K+WjRyaSHyNadyu6b+8apGgw+hl6PMqdGJU8iAYe5lHGEJyPfQkx2i8QkD46GZNFy
 gPoSBEnG3ZpIL9UPdqm0Mt7p4Ptq+vAgCrurRJlswSuaIp8UoE7c6cR9P0V409l6GrKT0HHLxgN
 PpCNaUUD+mhi3qO5FupW4dYGeD8cLJ0w727cKRIQWA6Tr/VNK4Hu4/yR2SPIK7OPTRKgrjkYIJ4
 fMHxPhvG83D4J1zNQTj9RKd8HpSmoLAY4T+4IXd5ezI7FK9aOaPxaXpQutz7C4cW5XI11IclyBy
 rqtWdy50VkWo9Xxztn81GdeFbHaEIsDm3jfmxaEnsmRl24+L5EmFriyCpgqO4LToHzNcxOTrsGr
 YZyvs+PtfHmomlhElxmeB3vTPtEhUdVXs4DSZRlsTDDU1zfnPEEkD0F5jy6w6c83/JcIxEjbz0y
 nYi4u9PB8OjlziWW0KQ==
X-Proofpoint-ORIG-GUID: gQYgYScWQd8MhmvbCSKqv7oZ7vpIV6jb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170092
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17/11/26 20:12, Richard Henderson wrote:
> On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
>> CACHE and CACHEE share pseudo-code raising Reserved Instruction on
>> NMS cores without caches, but only CACHEE performed that check.
>> See MD01247 rev 01.01, "CACHE/CACHEE" (printed page 63).
>>
>> Fixes: 8f1d9b6d6397 ("target/mips: Add emulation of nanoMIPS 32-bit 
>> LD/ST")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   target/mips/tcg/nanomips_translate.c.inc | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/ 
>> tcg/nanomips_translate.c.inc
>> index c883b5514f1c..20e96f2ad9be 100644
>> --- a/target/mips/tcg/nanomips_translate.c.inc
>> +++ b/target/mips/tcg/nanomips_translate.c.inc
>> @@ -4131,6 +4131,7 @@ static int 
>> decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
>>                       }
>>                       break;
>>                   case NM_CACHE:
>> +                    check_nms_dl_il_sl_tl_l2c(ctx);
>>                       check_cp0_enabled(ctx);
>>                       if (ctx->hflags & MIPS_HFLAG_ITC_CACHE) {
>>                           gen_cache_operation(ctx, rt, rs, s);
> 
> Also missing check_eva.

Hmm looking further commit 84c2fdc397b6 ("target/mips: Fix CACHEE opcode
(CACHE using EVA addressing)") added the check at an invalid position;
we check EVA -> CP0 -> NMS; the spec checks NMS -> EVA -> CP0 (in
MD01247 rev 01.01 p.63 pseudo-code block). On a core with NMS=1, no
caches, EVA=1 and CP0 disabled, the spec says RI while we deliver
Coprocessor Unusable.

