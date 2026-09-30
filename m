Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6FDCA5FBE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBsHd-0006OK-Ob; Wed, 30 Sep 2026 07:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBsHa-0006Nw-EX
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 07:15:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBsHY-0002qB-K2
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 07:15:30 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UB8MtZ2898239
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 11:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AVoAifuMgXXq/4WLHAAeYWum50ZJBFKT3XY+taM+whA=; b=SQG9zJKt6SxL9F0S
 BipFBzZISQB/NPQipU8+/dv0qNzO+FfRPO0IyEh5Tsq5SQKBTfBEyXZUDB0ruX8G
 zGfcbALPaxrIHYKQivn6o1lFOWhXU9MDIxxQmWRabuZ0mPxKt7jBtKdgL7ob9Qoo
 QWSzQKwnCv/PrChvOlfJRtCgabowk2GqarWmLzm6J6Dp6csY+ei+ZWl6TzVSbkDe
 +LSY1V6Sz3S6WG8iM0AOrNDZONvTerF5JxG4P72zLLIWi1lTRqcP0CbROB9v0N1d
 GnH1glYkW1EAp71FH1XwPtEqiyxbo5wNTHLjEQ+GW9aTCvPTYTmeyHjqYf05gZbL
 k/7WRg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0tkn1vq7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 11:15:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93be1861d2dso848852185a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 04:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790766923; x=1791371723; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AVoAifuMgXXq/4WLHAAeYWum50ZJBFKT3XY+taM+whA=;
 b=RcYUGow0WpbniH7gxkbaQV8Fec3C4j5/S9kZJz8BiHwAUPNoMFUXEEiSxKpXKHNaFs
 5hnf5cxe/M/oVSltLb+gj0cdCxu1n3jwjYTiRljK4HkAeIh7YD9pcEVQn61udOOQbXnz
 jFkSeP/IW4bhpZs0c2oPT8whZLGhhqDAtPefJePY2MAcsKaW/beg7q5ERdTOtkm+cjf/
 hT2UfxGwwEXkzqSonG1c4ur/vTYwgvKJbIKCIGLYGaDWsWS452aaEeH1g57UqNhJ7U5q
 LZZ3oI0nXlE867mIlWDS+1TBuVrCMpVRNK1rrxRghLjz2PD66ltE0I/RpN150Iq10S68
 FjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790766923; x=1791371723;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AVoAifuMgXXq/4WLHAAeYWum50ZJBFKT3XY+taM+whA=;
 b=enNE4H9OR246POJIgVea00CXXYyYExwL2naZq6B2Pl5Ey0WT/ARTUN3q6V6dAOKc3d
 doqrL2TAwsP5JVSQM0PebDkIeF3APDpVRAde9nNXdGa61iHSu8mwRuzJPUdmSVfgtgdS
 14kARHWXZ9C7BPuGgHSd0Z8RjEywKpcaqWJ2xBs0zsj+wXFzh3uHIHtudf6cA7Y9O9Dj
 bT3eXhE0RPnX8UzmAKwY5f/exGyzB8gXkc2YXsCKl1KbGdcfR2oc1skW6u7JhrNlj3Rx
 30+LcjlJMD/G11RK7Grz6Z4NSXKGPC3liNitQqMbFa0oNCoGAHUuJ4Gu2ETzHxN0rOgP
 gIlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/m0rFH4ko61ZjhyNEnCV5tr160WBNMFUgaInM28caDywNzlHAcvmm8pEhkLiPWBd2ztGPee0dhK9q@nongnu.org
X-Gm-Message-State: AFuF++mLRIUTGLS7A9ljnMBjlEan23sGw14E/Vef36WGUVAccH5wmBs+
 5Vc9Q3pSJLJQMCaKpQbsG0zj0P/Fwt1nJlnoTzyNpeKD+t8fGuAnYBrqgSro5bjlTLenPFFvN/3
 ml88rm8QclPMyB+bEPtUQoA8tr75ygisZp/QTaseT1WpaNUD8UZ0Be9QzwQ==
X-Gm-Gg: AYBFou2nTeUfJJuilP8Yh/PUXDXyyvkuc1fYxz+oM4q3PGMW/rK1DPqFEyUx9lWkVwX
 1qtQ7EV7cVTaE6r/Fw1tDio592pSwdkJcRJub6vERby4QiIXCWinroSHm9qMd8F9NncwvZa6r17
 evuauswYjUvJvo88fbARaDXXYBOcd1lN6AadqkPxWY23CijGpVu6ED0QI7lPaOP0EJcQFTp3us5
 YwLb0b4azdVdJnLPoNFkaaAQ07OYWOIuqAs3Ed/lvlVaa2gEQDaiQkpgdvKhqF0al2rTD9TQApG
 iVAcCzX/JLGTnJIBHBUemrkNE1pLGkwEZvjwzlyGV4OvW7OQBEuE0sUIjCLLI0S5wFpAjMHxp1f
 D8n6YAWf2QZxIq83MTfPkgAXNGid7l7sH4g==
X-Received: by 2002:a05:620a:3196:b0:93b:d7ed:ff66 with SMTP id
 af79cd13be357-93ca9882244mr166797285a.58.1790766923318; 
 Wed, 30 Sep 2026 04:15:23 -0700 (PDT)
X-Received: by 2002:a05:620a:3196:b0:93b:d7ed:ff66 with SMTP id
 af79cd13be357-93ca9882244mr166789085a.58.1790766922696; 
 Wed, 30 Sep 2026 04:15:22 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b028b237esm3034215f8f.0.2026.09.30.04.15.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 04:15:21 -0700 (PDT)
Message-ID: <82f2fea2-1ac9-4832-81fc-f585f4b50d20@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 13:15:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: use i32 for wait helper PC
Content-Language: en-US
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@mailo.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260930103454.647-1-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260930103454.647-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CKy/zhrD c=1 sm=1 tr=0 ts=6abcef4c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: le5m8lRWnq7-rlPF2mkZGxeQpKAnTaFa
X-Proofpoint-GUID: le5m8lRWnq7-rlPF2mkZGxeQpKAnTaFa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0NCBTYWx0ZWRfX3wTQsJzA6V9O
 uAdZuYlEB1Slyoml42jqJSVZ+B5jm+ZJ29VkpnSkR5NoPphYqjdbrlLHzyMTMVq8AvjuP7WPLXw
 Adu5Rmzb0jy3Sra/pZDpdXJv+5CPcseso1B4T0FCCiq5gEFSNRC37uQ4Mg5HKvyWutAHVT/FOd5
 l5xcqi8XRyRiJIT+f//J1Uc8tveAf+XVnSJTVsQqlegXtpfXovy2kiivtZLfEZn8L0CA87mGj6K
 i0g4rSA8QvZc57tBJaYNxwpOQbL1qmpI/etKIa3veGkBxery+3g2r3rh6RQhbcqFUl00sUI1xTz
 amyU0vefYhYEC5qFBrC2B7jliN60zuIUbTr3KWHXi8xXpQ1eZdSCuqCiLzdSYU1Iu4gcjS/YgtP
 xhCuOOYhBMkwsfWNKRUvZNXMJBi/Vp+3zU7eR3d8+kamVsQNvUKujuSoy+wdzKPchEVqDU6eXk2
 kuiM5yWR+HSYOB1CdRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0NCBTYWx0ZWRfXz4KI4vs/JyF4
 RtVo4zeiXpzKqEd5opChX074fv6iLAhpwGVFc689KpYC/rdHZEtVcC9YPg0TlTVF7XNj3lWmLuc
 BSe04bxpVIAZZNyjvGUqrN+8c5LxsuM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300044
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

On 30/9/26 12:34, Yonggang Luo wrote:
> Fixes: acd2b7a2f19 target/hexagon: Implement wait helper

Not sure if this one or 40085901dbe or another one.

DisasContextBase::pc_next is of type vaddr, which expands
to uint32_t on hexagon. Pierrick has a better view on which
type is better here.

There is still inconsistency to clean (later), up to the
maintainers:

target/hexagon/genptr.c:429:        tcg_gen_movi_tl(dest, 
ctx->base.pc_next);
target/hexagon/genptr.c:469:        TCGv pc = 
tcg_constant_tl(ctx->base.pc_next);
target/hexagon/translate.c:251:    target_ulong fail_pc = 
ctx->base.pc_next + nwords * sizeof(uint32_t);
target/hexagon/translate.c:580:    target_ulong next_PC = 
ctx->base.pc_next + pkt->encod_pkt_size_in_bytes;
target/hexagon/translate.c:1383: 
tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->base.pc_next);

> 
> Signed-off-by: Yonggang Luo <yonggang@gmail.com>
> ---
>   target/hexagon/gen_tcg_sys.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
> index af5032214c..faec55f502 100644
> --- a/target/hexagon/gen_tcg_sys.h
> +++ b/target/hexagon/gen_tcg_sys.h
> @@ -80,7 +80,7 @@
>   #define fGEN_TCG_Y2_wait(SHORTCODE) \
>       do { \
>           RsV = RsV; \
> -        gen_helper_wait(tcg_env, tcg_constant_tl(ctx->pkt.pc)); \
> +        gen_helper_wait(tcg_env, tcg_constant_i32(ctx->pkt.pc)); \
>       } while (0)
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


