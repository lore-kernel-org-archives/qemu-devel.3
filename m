Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E7EC43458
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 05:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkELL-0004G9-7G; Thu, 16 Jul 2026 01:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkELK-0004Fz-0Y
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 01:09:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkELH-0001Tj-PE
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 01:09:05 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G3wRcP1412222
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Gbm1sABu0PZo4uSYBgeUGdIFkFOZsjtcs6LVH/6IJbU=; b=F8klFgXmehlntfsS
 096tfwF5x/WV64bXc7TTGILmoTQ03BN8shIcg/soh1gPvA+2fWrpZlf4wNGzGDtn
 jTU76o9R1FZ/WT0e8KQaGbGjHBhfXDoZzFwbpi/JWzWSCWeKbsl7NWa/AXLLI4Tw
 kGUpaABL9DLbVe2OizF6t3ahGUl+QEDa3MCuvVhlE2alYbtSqPbc4UeP0mchRlh1
 KEeDglnnHFKuXso4kBMxh7WTS3MZTWjFSWoEUqccWRoH7PYWbwD7Tx9Mn71uaF2k
 d+aWtY2faQ6zy8XWp7i4PnJpcoqRjeUarW1PCPA7bdrVHgJ01T1NMFOdwjyuQjFE
 GU3fAg==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7kac6sy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:09:01 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-81e68b02459so162592117b3.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 22:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784178540; x=1784783340; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Gbm1sABu0PZo4uSYBgeUGdIFkFOZsjtcs6LVH/6IJbU=;
 b=jfXwYeNfSFNmnrSu5QvH79iCY89bB3uWqtxgaLkrGdqa66g8Wc42C0OEMja72TFS1Z
 knsWl4b7TaaiT3k49OTYlT7/M7cL64/ClGAMLt5/r2/AtmefNZJfO9k6Ga+0RZwP/Gja
 yAqi1gsZhe9cVAciVqoun7MYJBS3lry4AvWkfojqfeH1g0DG36NGAx4OO+NunlZjhgr7
 ntNChH/Hb1uJ7UVCQSrR4BX1oIkd1enrYOQQOS0jjCfn/H4bw4jDD9S4HNgTOTllOH9t
 TmbhrTU4+iu3n5vNuOc6ypAQrz+wfJVjkNF8hJxTNGaeqjwakhz14FfWFxBphWY3EP1/
 zu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784178540; x=1784783340;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gbm1sABu0PZo4uSYBgeUGdIFkFOZsjtcs6LVH/6IJbU=;
 b=DFGF0YnCEAzrUsBbB/ZA/1iRGLfYs9y+Fw8qqhvhigsjQyMB3MF4rmlxDkIgoQHS9h
 muMpOVOPMo4jEAHUbBnIuesD3L3qvpSoE4GYnU8VwyDw0wrYGmaLik0wD+LTwYfH7GTh
 r23Vt2dhfNySbuOYSH1Hy0h1Qb7EJ0rHZCTYa2tfrsp8Z4ukyGmq0Cje7CWEA+iisb0g
 HE68FfCc5HRXJzR5lyEHi693I+rWJvjCPmmSfldwi2MFyC/oNNnRoJiNT8Jkt3wBlFqD
 CKKJBqVT+ihSYGbuRE+H7ylAuyu/ZOA8KIw36V3qe+0ROlXFC+I8knqiGWrBpFHUwWuO
 q3vA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVxZQ26ec/4axgfYnJeNcdKRGN45u2/EMQsJCsa0+J6XFNacVry7p4OTMEbRF7VLsW36EgbutZpFxo@nongnu.org
X-Gm-Message-State: AOJu0YzERl2Wlp6vyswbsyb5n4CPd/RO+nm4tCluIeJmh50YFKDYUqbp
 y1j51L83uZ2OOsXofzI94S0ZwCLPQjanR6YqstPa4fVnmxAghVTmxkzQqVKvi4lmuZFcb45EyZW
 tvyu+MD+MxFIog7n5Fmf7vRk8KY2L/W5amiZq1y0PIBMgIjAWgtnqtDotVQ==
X-Gm-Gg: AfdE7cnWrcSi++i2OapFNIxl8Mz9eeb1tB33sfIXBBjLzN1uyI27qTEqqIh8WlTjuHA
 lYQhM+TlPErJjWDZsE3p0rwZfdkITu0k5dMQPGqPMBjZRwtni5Qg+z9PzSUEDc8lIaZUd5xBVEi
 Aly6AECC7Ft/3xMkNyUfK8SQLeHPF6q8v/WO6er65L/XPjfQ5O+iuPbxTk4SIiu5qOKtihmUs19
 0fjD5KLHdDussvkHCMnWAYL1jGNjQxxcnEa7UaMZ/C/Mrz5EUryI0kBtzSa0zZs0QO+zO0rivBt
 5na7NUVcwx2ghsjH4HgDf25o9O50g4kcuBhAxxP5SfgNg43WNw0jKkh2zSpIOt28IXbniJuiSUb
 yn/J+Ik2tp7E+mjGFyrKh0etOoRUsbKC4wY4AMnYJUjlwidk4I0oVEPIwdcBI1ryUaBPtoAPfII
 UPNe0L
X-Received: by 2002:a05:690c:360c:b0:81e:6bd6:39a5 with SMTP id
 00721157ae682-81ebb0cd643mr75759667b3.1.1784178540244; 
 Wed, 15 Jul 2026 22:09:00 -0700 (PDT)
X-Received: by 2002:a05:690c:360c:b0:81e:6bd6:39a5 with SMTP id
 00721157ae682-81ebb0cd643mr75759457b3.1.1784178539641; 
 Wed, 15 Jul 2026 22:08:59 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-81e6befb688sm186586917b3.14.2026.07.15.22.08.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 22:08:58 -0700 (PDT)
Message-ID: <0ba08125-d396-477e-8b8b-061954062a78@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 00:08:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] target/hexagon: fix PC advancement for non-COF TB
 terminators
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
 <c0cc9ab4c7df71362178a74d52a813cc01e7ab8f.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <c0cc9ab4c7df71362178a74d52a813cc01e7ab8f.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TMF1jVla c=1 sm=1 tr=0 ts=6a58676d cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=GdRgClu8jNGCi8LXZyQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-GUID: jtbJZU_iaGM9DsBepLza5xEX2nauSlaV
X-Proofpoint-ORIG-GUID: jtbJZU_iaGM9DsBepLza5xEX2nauSlaV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA1MCBTYWx0ZWRfX8T8FWP7dFb6W
 ltwYpblj/BmKcH4Lpokq5Zz2cGw19v0C1Va0T3PRRNgAvVheVqKiMsAVys7fkbmKSOK8npave/M
 VjSADx9iy/Hq31RIMqlwcsxGM64VHzs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA1MCBTYWx0ZWRfXzF5rGnCrLauF
 cYmljcUY9snG+VBAXu9HgO0ms6egG9crZh7bQGlaCbio3egR//i1CXWaaHRwSL/yzvXomO9bGNX
 JVgafZQrxCsRc57Le6pjutXqBOvCa1769vjSQUDFCqaV47k6hZGSjDJzZZB+Aqg3g+UOOqHiCxB
 YlX9wxdnQuIuVFoLCsFOnptTTYbN9BbyNVOYX8oloEbSjy0fjgL6zELqywqYIoYbWJlDIgY+O5Z
 W3/a+TqMK09pVHyjiZTrraX1eg4f3nQwqIbbbbQD8No37LC6cJ5Gg8RbldyDCOJLEjGXpDHorVa
 xWxYZb3USpGRGnrX7DKavOH76tsFKRejvzHNB9e527gwlPy/7prdrcM4wdQU0gTOU/y94nAX+9H
 3FKTkPN+TgsZqfWdv5ty/ITrmLTo3eqqkHyRy9rL9u1rNitNrnNjG5BOLv3yJH26xuu1NshQc/E
 WgHn6qdfaM5tndTI0yA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160050
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 7/13/2026 3:07 PM, Matheus Tavares Bernardino wrote:
> Some packets end a translation block without a change-of-flow. These do
> not update the PC during commit, so gen_end_tb() leaves
> hex_gpr[HEX_REG_PC] pointing at the same packet and the block gets
> re-entered forever. Set PC explicitly to next_PC in that gen_end_tb()
> branch to fix execution of next blocks.
>
> Note that gen_start_packet() used to have a special case for
> tlblock/k0lock, setting ctx->next_PC to the packet's own address. This
> relies on the tlblock/k0lock helpers to properly advance the PC, which
> is never done (only env->next_PC is updated, but that never reaches
> hex_gpr[HEX_REG_PC]).  Drop the special case so these packets advance to
> the following packet like any other non-COF TB terminator.
>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---

Can you try 
https://lore.kernel.org/qemu-devel/20260709230645.3033240-3-brian.cain@oss.qualcomm.com/ 
to see if it works instead of this patch?  I think it should satisfy the 
same need.

>   target/hexagon/translate.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 77235916f4b..06e76a6ba34 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -210,6 +210,12 @@ static void gen_end_tb(DisasContext *ctx)
>           gen_goto_tb(ctx, 0, ctx->base.tb->pc, true);
>           gen_set_label(skip);
>           gen_goto_tb(ctx, 1, ctx->next_PC, false);
> +    } else if (!ctx->pkt.pkt_has_cof) {
> +        /*
> +         * Packet with no deferred COF that still ends the TB. PC is
> +         * not updated during commit, so set it explicitly to next_PC.
> +         */
> +         gen_goto_tb(ctx, 0, ctx->next_PC, true);
>       } else {
>           tcg_gen_lookup_and_goto_ptr();
>       }
> @@ -282,6 +288,7 @@ static bool check_for_attrib(Packet *pkt, int attrib)
>       return false;
>   }
>   
> +#ifndef CONFIG_USER_ONLY
>   static bool check_for_opcode(Packet *pkt, uint16_t opcode)
>   {
>       for (int i = 0; i < pkt->num_insns; i++) {
> @@ -291,6 +298,7 @@ static bool check_for_opcode(Packet *pkt, uint16_t opcode)
>       }
>       return false;
>   }
> +#endif
>   
>   static bool need_slot_cancelled(Packet *pkt)
>   {
> @@ -562,10 +570,7 @@ static void analyze_packet(DisasContext *ctx)
>   static void gen_start_packet(DisasContext *ctx)
>   {
>       Packet *pkt = &ctx->pkt;
> -    target_ulong next_PC = (check_for_opcode(pkt, Y2_k0lock) ||
> -                            check_for_opcode(pkt, Y2_tlblock)) ?
> -                               ctx->base.pc_next :
> -                               ctx->base.pc_next + pkt->encod_pkt_size_in_bytes;
> +    target_ulong next_PC = ctx->base.pc_next + pkt->encod_pkt_size_in_bytes;
>       int i;
>   
>       /* Clear out the disassembly context */

