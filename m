Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606F5CA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 04:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC8TX-0000p1-41; Thu, 01 Oct 2026 00:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xC8T7-0000gh-5h
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 00:32:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xC8T3-0004qi-Gr
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 00:32:28 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6913gaUs1754678
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 04:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1n/T3mPdL4zw5yFIgbYHBylRkFQr57TbQ+ObqZp1Ukw=; b=bLqc5h6fr9RGv5np
 rQ5V3Vo5XkZvIzTQ/HZ+vjNxqVSUBO3wzaF9fCC8Uam1dW10bnT3hWqixGqAlfRS
 ZS5LKPxrocxxDlRb9MYrZL0G50tg6whj8xVFnrSeKKVcC8S1YxpmWwWAXUzRFynu
 3iPbnViy0fLUdwz3L2fm/cFIYShHq9UOKMf2jhD8m0Eq+mDaoltnjXrGRuQTnH28
 29XmdSP2COSpbcuL+OUWAmutKwkE8GCdiFAHNhFUlFxhqUe+hW2dLvON/IxxASKK
 YgVRcpbJeqh0KujGcKxfcTTR9FuttIrd2Qf7mBCSIE1z+UG6JPMX56xBfSx5Nc0p
 N1TXcQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h155vtqtc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 04:32:24 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3968bb86fb7so6053906a91.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 21:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790829143; x=1791433943; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1n/T3mPdL4zw5yFIgbYHBylRkFQr57TbQ+ObqZp1Ukw=;
 b=VPbm+cNd12gADAeiTUFSLtUB569RmuRMAJtn4vRR+jyjy6h8qRu/45oMb/Su3Ly0mr
 2lUq/4D4XKFA0uq5T6Z53oX8lS8adwQrwCzoi6DFqonK+edvt3gGYiEhho/ZDalMj5/H
 U1L0Q6CRZiY57ttQVjCA3zafY/ibNOENnNKbn8+IQQcakYZEoj/cAJhUwOXWYABAeU3L
 X5zNz+J9vLwKXJ5VIxRJLNX6E177fQbsyrm3MNvVKCvsW2MsIcb5l11xVZYn8M/TXIqA
 /ZERSXzzB9sTQ2eSUDq86vMXIXrEb+faPJodZXG47JEMnkfBIpHLMMgIefqSGSX+IRSy
 WJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790829143; x=1791433943;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1n/T3mPdL4zw5yFIgbYHBylRkFQr57TbQ+ObqZp1Ukw=;
 b=f90D++F95+TBkehEmUmENRy2WJnAPIMk1ihBjOh+D4ZpoJbqwk7IABAm2t/h3SCa+D
 REOMVtQ+iwlYj6DVvaNrWTbMs5XzMvTfQuA7TpLpx24a7+u9a4pM4xSRILdpnjaCyAT4
 bJcbeoa7E3z1vosiLtDtmhstrL4JDHY7GoFmsPjzODwMeWrNneOd4wfUVTyRZYKqVpOY
 xipozFMV8xgAPnFIWhSygeXRPNmgaGtBvG8yOkgV3CNREsm5QXfDvPaqp6wyBiLBzjEl
 7SJ5mgzMkOl1JxmPJNcaLlEHjtYdR2boTuo9xS80JszCOd22wRLHoz4+TuF4VE3fQ38X
 nu4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzu3GUBAEqlm8NHDL6d5+AcxTpBLF2eo0ZLq9RmILZeLSqMQ2eLSRh8gsVqxhRQYHfPZdZaQeaE4C7j@nongnu.org
X-Gm-Message-State: AFq9FYI8K6bmTMKT6KvHPnLBil1Z7levFIzXnCWRycjj3dqsHUGNWg2r
 LN1ZR8MO1eLcSpmfTYMmYTxENpuXvWCE/aEW2271cdULwkEax4TlSMM96kWQJwIm9llNu/W3XYn
 K6OwvD0G76qpJt7t3BSA2K/dL1b1wj9MAMSweGCy/nR/P3arYRTJ+P9GSnVI7Mr4u8w==
X-Gm-Gg: AYBFou1ODDS1bHmNZEtAIV9lKehde9/GaJrhXi72tUIOYa/v8LGzrQR328eANgfJ+QH
 4u7V0Ekyg4h0HTR1kuM9KAyKLMe0hIa1r3PPg6IidPmwRnWJuP9MlxvsKBGwc/YO2u5zeXDl0BF
 61kx6R4NsPsfV2n7wMhMk/U/ma4APNVeTry+Zh8t2DvAR8fGt62awQzdraJdO+rZMALYxbz0wNo
 ZcaNuExJyYEgoRLkew8qyU188YP1RNRtUnlNaI+CRof6/HdvWSG4nenfDoPaeRnvGEoAR6ohXgR
 J5H7roYOqEF7ukULIRbXdU4IDenHgOGFTsfDG47yDJ8KVz4q7TSXeBftrhbqPbinMjrcq2F4L0c
 R3+NLC1IeVY2rkPLZEaoiVoxvPTOkKjYugDvIXWs2GDXaTRTZtwMm5y0S
X-Received: by 2002:a17:90b:5448:b0:3a5:364:ded with SMTP id
 98e67ed59e1d1-3a5036433a2mr333681a91.39.1790829143078; 
 Wed, 30 Sep 2026 21:32:23 -0700 (PDT)
X-Received: by 2002:a17:90b:5448:b0:3a5:364:ded with SMTP id
 98e67ed59e1d1-3a5036433a2mr333653a91.39.1790829142506; 
 Wed, 30 Sep 2026 21:32:22 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f773c8bdsm775088a91.3.2026.09.30.21.32.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 21:32:22 -0700 (PDT)
Message-ID: <d73301be-afce-464e-b94f-ba28c08a913d@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 21:32:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: use i32 for wait helper PC
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@mailo.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>
References: <20260930103454.647-1-luoyonggang@gmail.com>
 <82f2fea2-1ac9-4832-81fc-f585f4b50d20@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <82f2fea2-1ac9-4832-81fc-f585f4b50d20@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAxNyBTYWx0ZWRfX/1PWOdElHumz
 UWBOhY1UxleYXkDOaPH9U75pEY5Gh/fve6SnQrVDh+f781HkPgzWPpKA4m15PtTUOsIllX/D1O3
 1I/JXANxQUXNEuvX7basbtNIDzQ9Jos=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAxNyBTYWx0ZWRfX4jBGAHZPduEk
 1mo+wSyFdBNju7xBuev/nwltdlggFdVH4KvzaExiH2euW3i/D5HKWfvn6/7IvkICye2NdDwEKs5
 WjHObNs4dUd9225kic4O18f0Zvkwpr67/+4+adVD9UzzZc7SS20D+ZcCCo3CleckRsJb1amOlRg
 mBsP201QHIFDRCum8CJBHQnQhOjnLY7wQUX+McKAtrhRXA3qrSvch5c+oTP2/Chx3qqNpNkd8YB
 Vfd4COcvtCwxfVaLaQz2Mskt8ku9c4PLHqWudb3LMD6DRxhYE4v7C1kPXxRg48wYDgwnDCFhCVH
 QxvqRC0GzgIRHJ/n830UELGFFXmHk2RNY0iH7FU97cvGqvF1h6j6zPc20mT026+Pl3Jk+MXhd7a
 KIMNal+wdaaYqyTnwB2LrI73lcxfdBmVuu5gev88O1rr6fcSbQ3HD7iiv8ajVOIJ3fHjmWIcaqf
 4lDAD18sVpjRbima0fQ==
X-Proofpoint-ORIG-GUID: PVsBo1xmDgPj6sD-udN23uIafjWm-Y0H
X-Proofpoint-GUID: PVsBo1xmDgPj6sD-udN23uIafjWm-Y0H
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6abde258 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=2aFWFHZrbJ7EhV8P2DAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010017
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

On 9/30/26 4:15 AM, Philippe Mathieu-Daudé wrote:
> On 30/9/26 12:34, Yonggang Luo wrote:
>> Fixes: acd2b7a2f19 target/hexagon: Implement wait helper
> 
> Not sure if this one or 40085901dbe or another one.
> 
> DisasContextBase::pc_next is of type vaddr, which expands
> to uint32_t on hexagon. Pierrick has a better view on which
> type is better here.
>

Hexagon arch has a 32-bit address space, so i32 variant is correct when 
manipulating a vaddr. I'm not sure what current commit is supposed to 
fix though.

There are a lot of _tl usage in hexagon, but we agreed (internally) to 
delay the cleanup until all our downstream patches are merged upstream, 
to prevent conflicting with ourselves when rebasing our private branches.

> There is still inconsistency to clean (later), up to the
> maintainers:
> 
> target/hexagon/genptr.c:429:        tcg_gen_movi_tl(dest,
> ctx->base.pc_next);
> target/hexagon/genptr.c:469:        TCGv pc =
> tcg_constant_tl(ctx->base.pc_next);
> target/hexagon/translate.c:251:    target_ulong fail_pc =
> ctx->base.pc_next + nwords * sizeof(uint32_t);
> target/hexagon/translate.c:580:    target_ulong next_PC =
> ctx->base.pc_next + pkt->encod_pkt_size_in_bytes;
> target/hexagon/translate.c:1383:
> tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->base.pc_next);
> 
>>
>> Signed-off-by: Yonggang Luo <yonggang@gmail.com>
>> ---
>>    target/hexagon/gen_tcg_sys.h | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
>> index af5032214c..faec55f502 100644
>> --- a/target/hexagon/gen_tcg_sys.h
>> +++ b/target/hexagon/gen_tcg_sys.h
>> @@ -80,7 +80,7 @@
>>    #define fGEN_TCG_Y2_wait(SHORTCODE) \
>>        do { \
>>            RsV = RsV; \
>> -        gen_helper_wait(tcg_env, tcg_constant_tl(ctx->pkt.pc)); \
>> +        gen_helper_wait(tcg_env, tcg_constant_i32(ctx->pkt.pc)); \
>>        } while (0)
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 


