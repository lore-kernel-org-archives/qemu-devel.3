Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3F1CA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDqM0-0002A5-FW; Mon, 05 Oct 2026 17:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDqLy-00029I-Kd
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:36:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDqLu-0002D6-N3
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:36:10 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695KN1t42596508
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 21:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BiSWqrkzn0BBjZDFsWSmAxCl8B1DhnA3pNxkB4wfPKo=; b=EfQMlfBXZJwsZYMB
 KbCBiR9oCXAPLCPjbBlxtwEx3VZWQvtKKy9SHrrattgZx/GF0zZIiVZFOFOdi/HT
 bJyfRSMPyaguC8oxh64limQObvh/x3jgMPHIyFQEoMj7Mev1YjVT3IAf6BujHfP7
 J16R1+4VhJjBffwcRqimK8S5sHH0SzzyqPHgkYCLjEahmhrkfsh0XcyaMEQqEU9Z
 Z/zj8CITrWqpGuldxmqocaK+2PiEosDADhlBx3SQUMnNUWnCvONln3wK5xCiZ1uD
 JvknKPpvfMjF8C25t/Ty6olGhKZnoYRbVe41OmJncSjJkd9AirrUSks7GaFy3VBI
 O1i8Kw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4a7dtdny-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 21:36:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30f1b904861so2638249eec.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 14:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791236164; x=1791840964; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BiSWqrkzn0BBjZDFsWSmAxCl8B1DhnA3pNxkB4wfPKo=;
 b=ar94egZktqv1lfXiMHAMmhKnXjg3GTuFoZU1V2wIVqiffW9Wc536P4yHeH1dHmVThX
 rqi2S2kpStAYz5lWol2Ehfv1XdCvK7Jc1wZ+dfpkUWtFyH/YkUqvmES92oOPq/xjjwgn
 12GzBkXvHFZ1xwMFsxfea5xA+iPU9CzINnjl4rP2CpV6Sm6HaErpBl2PomoxmqvMEE3Q
 9szPH1y+eP+SCqOjYltIWOlmtWjPh2zJzVOzQuU70IMg9j3sKQBt0hUXo91wsFQJQkAD
 kHfca2pMlmXQ1VXZXY9RfY7osLeDir5aqZym2f3/aG0KbQLraXUTV60jZ2rRru2WDZSS
 /ySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791236164; x=1791840964;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BiSWqrkzn0BBjZDFsWSmAxCl8B1DhnA3pNxkB4wfPKo=;
 b=J9bepzEYzFYlYYr1BxHhS1OHe/LeakVzX4SamXnX0/qQkuJ01YCaJFrzlYb/sL4m66
 NY+MVsmPFG3I/oeayr3Bgcvm7n8ihky18+oXHZx/FuBvIyaHUJQer3OZhhWUWaSQCCNo
 oJicRKjmd6zES/2upTBeIUveF90x3IVSjIEz/Z0DoVmf2Rkmto42OLOUD2XVpHIscpU2
 NEiAoPe7K7U+ULl3mZcpfHY9RaP5L2PyXZpkrKIrZ1lZ4nCaDCxwv/e5Xy/pHf2Ub/f+
 H5aKtPcFO3ExzQWZbImZsFdud2t5lL81s/dV+uat7mebwsFAQUk1AWsT332az29KzdzM
 TgiA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwvNkxHdpM9NTRUECofRYltLbWcjRZsXDVt0RHOMqdXgQudSl3b5UvYnQ8kGaVbb5GT7YnKMr+48Od@nongnu.org
X-Gm-Message-State: AFq9FYIo1lRSWe0O4DXod3RIcJjVaMoeOMIH5WOOwF/xlJLjguTmyrZB
 g4OJGZ2DqULJTmp5z5VKuC+T17l74FE3gF0Z0pRDzzQTVNsnxpjlYELxPLSmueiRuv5eh19cE+v
 42zymISZll50rakDjrwi+Wj+CIWWsK2JFkzJbC4KXiyWFaYVkvzCoV6rDHA==
X-Gm-Gg: AYBFou3JerkLuXipyocn2+baTRDE9j2ZaIknj/Tc2vxIgDHwJZ6p3oWDXd3QfJlSRgf
 kwQ8P9bDEWXTaT0EJwK5D5k80oM6srjfJo0sxANQqj0l60J4FRhjin+fpQGruytaUe90cJFlnes
 cnTCGpxAg2TKs9FenmMetQcia50ufzXdRlkUlJ6yaGLcWH4NVK9mEeCyR1Pt2/iQY5O/osbyZZ/
 KnGWeLVLYeatVPH6bTphnvbDXAqb1bfOzfCz4datCM82R7L0XbIjqMW7GxhUitChbR384ylhvIw
 7H4AvqOCALRS7JGQRbs5oP3PcHNZoZ+FrbojW9HQdKR1vwfWOxJIL7fLEL5vL6t6tNzaFR+6czi
 4F/jA8wZYgv5m6G/S++RG1Uy4+wwb8rbTH31mhH480ABW/zWxYPKhMnmZD9FBp2LpOl6c8g==
X-Received: by 2002:a05:693c:88c8:10b0:34b:7c9c:9a71 with SMTP id
 5a478bee46e88-3512e446222mr5489508eec.1.1791236163139; 
 Mon, 05 Oct 2026 14:36:03 -0700 (PDT)
X-Received: by 2002:a05:693c:88c8:10b0:34b:7c9c:9a71 with SMTP id
 5a478bee46e88-3512e446222mr5489468eec.1.1791236162261; 
 Mon, 05 Oct 2026 14:36:02 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-351469f75fesm1083041eec.5.2026.10.05.14.36.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 14:36:01 -0700 (PDT)
Message-ID: <37303d83-8197-46bd-be25-5c9e4961d314@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 14:36:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] target/hexagon: use vector payload size for HVX
 operations
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, richard.henderson@linaro.org,
 Helge Deller <deller@gmx.de>, marco.liebel@oss.qualcomm.com
References: <20261005032616.1293829-1-brian.cain@oss.qualcomm.com>
 <20261005032616.1293829-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261005032616.1293829-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4NSBTYWx0ZWRfX2HvDOMOkCeit
 OFfbdUmt11yYhTLea/5uZOhVe6/yYjz+51BBMCWZUk+QsSZ8JDhlzSU0bbgpZHmk0L4RaUr3DTh
 CjROhfuGUSt9hZzd2fCNjisfL+Ju01M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4NSBTYWx0ZWRfX44/qNKp5PPFt
 ktWqwKTwx1cGVnCrZUMc8AA9rPyH/s44GsU7bYQJANKyAdKEobBmOVsi4b1/DRlOnXi7w62YMf6
 EndhWu9Rvlc7Xgn8oClbGA0Gy/CWvr5FVggy8PAuAEn0CSbfIKBI39kmslLJEMLDm8IwOIJbFFE
 RmhZDtDDaN8sbuVtFZzEd3c46Q9yaf+k2Hnpd8STkyj5H74Fd7BzSwhfCX51R3/SteC3PVzXyuX
 Oaz3aeW7M/ki1I+XIq1U5u/OxqJBUK85386QPJi7bv0yk8hdKrSccy29kk0x4Wt6m15nSTZi8kI
 aTqoGccnibnzIkBdA9Z/rbNk817dfj8jhEcgP5ShtkOFPFLK4Eyyat+QkuBaqLcRUAF3NtDIG5p
 cayNsqxgLb9Lyq4eUpg7JRyt3z7sC1SX3OFtP2H7pfQx0ayiKu8d/jA/mqzpXLA5YACtkbaIKIK
 4S4VXlzqjCef/AXBAsQ==
X-Proofpoint-GUID: iU34mqhLRsEQ5fRvS2felya1V3D0jCW2
X-Authority-Analysis: v=2.4 cv=SvwFe/O0 c=1 sm=1 tr=0 ts=6ac41844 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=B1fUGuU_DLEMwcfbZTMA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: iU34mqhLRsEQ5fRvS2felya1V3D0jCW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050085
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

On 10/4/2026 8:26 PM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg_hvx.h            | 242 ++++++++++++------------
>  target/hexagon/mmvec/macros.h           |   8 +-
>  target/hexagon/genptr.c                 |  18 +-
>  target/hexagon/mmvec/system_ext_mmvec.c |   8 +-
>  target/hexagon/op_helper.c              |  34 ++--
>  5 files changed, 152 insertions(+), 158 deletions(-)
> 
> diff --git a/target/hexagon/gen_tcg_hvx.h b/target/hexagon/gen_tcg_hvx.h
> index 548b49b4156..e439b0817f2 100644
> --- a/target/hexagon/gen_tcg_hvx.h
> +++ b/target/hexagon/gen_tcg_hvx.h
> @@ -126,19 +126,19 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>  
>  #define fGEN_TCG_V6_vassign(SHORTCODE) \
>      tcg_gen_gvec_mov_var(MO_64, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                         sizeof(MMVector), sizeof(MMVector))
> +                         VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>  
>  #define fGEN_TCG_V6_vassign_tmp(SHORTCODE) \
>      tcg_gen_gvec_mov_var(MO_64, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                         sizeof(MMVector), sizeof(MMVector))
> +                         VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>  
>  #define fGEN_TCG_V6_vcombine_tmp(SHORTCODE) \
>      do { \
>          tcg_gen_gvec_mov_var(MO_64, VddV_base, VddV_off, VvV_base, VvV_off, \
> -                             sizeof(MMVector), sizeof(MMVector)); \
> +                             VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>          tcg_gen_gvec_mov_var(MO_64, VddV_base, VddV_off + sizeof(MMVector), \
> -                             VuV_base, VuV_off, sizeof(MMVector), \
> -                             sizeof(MMVector)); \
> +                             VuV_base, VuV_off, VECTOR_SIZE_BYTE, \
> +                             VECTOR_SIZE_BYTE); \
>      } while (0)
>  
>  /*
> @@ -150,19 +150,19 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>      do { \
>          if (VddV_off != VuV_off) { \
>              tcg_gen_gvec_mov_var(MO_64, VddV_base, VddV_off, VvV_base, \
> -                                 VvV_off, sizeof(MMVector), sizeof(MMVector)); \
> +                                 VvV_off, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>              tcg_gen_gvec_mov_var(MO_64, VddV_base, \
>                                   VddV_off + sizeof(MMVector), VuV_base, \
> -                                 VuV_off, sizeof(MMVector), sizeof(MMVector)); \
> +                                 VuV_off, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>          } else { \
>              intptr_t tmpoff = offsetof(CPUHexagonState, vtmp); \
>              tcg_gen_gvec_mov_var(MO_64, tcg_env, tmpoff, VuV_base, VuV_off, \
> -                                 sizeof(MMVector), sizeof(MMVector)); \
> +                                 VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>              tcg_gen_gvec_mov_var(MO_64, VddV_base, VddV_off, VvV_base, \
> -                                 VvV_off, sizeof(MMVector), sizeof(MMVector)); \
> +                                 VvV_off, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>              tcg_gen_gvec_mov_var(MO_64, VddV_base, \
>                                   VddV_off + sizeof(MMVector), tcg_env, tmpoff, \
> -                                 sizeof(MMVector), sizeof(MMVector)); \
> +                                 VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>          } \
>      } while (0)
>  
> @@ -174,7 +174,7 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>          tcg_gen_andi_tl(lsb, PsV, 1); \
>          tcg_gen_brcondi_tl(TCG_COND_NE, lsb, PRED, false_label); \
>          tcg_gen_gvec_mov_var(MO_64, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                             sizeof(MMVector), sizeof(MMVector)); \
> +                             VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>          gen_set_label(false_label); \
>      } while (0)
>  
> @@ -190,62 +190,52 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>  /* Vector add - various forms */
>  #define fGEN_TCG_V6_vaddb(SHORTCODE) \
>      tcg_gen_gvec_add_var(MO_8, VdV_base, VdV_off, VuV_base, VuV_off, VvV_base, \
> -                         VvV_off, sizeof(MMVector), sizeof(MMVector))
> +                         VvV_off, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>  
>  #define fGEN_TCG_V6_vaddh(SHORTCYDE) \
>      tcg_gen_gvec_add_var(MO_16, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                         VvV_base, VvV_off, sizeof(MMVector), \
> -                         sizeof(MMVector))
> +                         VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
> +                         VECTOR_SIZE_BYTE)
>  
>  #define fGEN_TCG_V6_vaddw(SHORTCODE) \
>      tcg_gen_gvec_add_var(MO_32, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                         VvV_base, VvV_off, sizeof(MMVector), \
> -                         sizeof(MMVector))
> +                         VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
> +                         VECTOR_SIZE_BYTE)
>  
> -#define fGEN_TCG_V6_vaddb_dv(SHORTCODE) \
> -    tcg_gen_gvec_add_var(MO_8, VddV_base, VddV_off, VuuV_base, VuuV_off, \
> -                         VvvV_base, VvvV_off, sizeof(MMVector) * 2, \
> -                         sizeof(MMVector) * 2)
> +#define fGEN_TCG_PAIR_ADDSUB_BASIC(OP, VECE) \
> +    do { \
> +        tcg_gen_gvec_##OP##_var(VECE, VddV_base, VddV_off, \
> +                                VuuV_base, VuuV_off, VvvV_base, VvvV_off, \
> +                                VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
> +        tcg_gen_gvec_##OP##_var(VECE, VddV_base, \
> +                                VddV_off + sizeof(MMVector), VuuV_base, \
> +                                VuuV_off + sizeof(MMVector), VvvV_base, \
> +                                VvvV_off + sizeof(MMVector), \
> +                                VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
> +    } while (0)
>  
> -#define fGEN_TCG_V6_vaddh_dv(SHORTCYDE) \
> -    tcg_gen_gvec_add_var(MO_16, VddV_base, VddV_off, VuuV_base, VuuV_off, \
> -                         VvvV_base, VvvV_off, sizeof(MMVector) * 2, \
> -                         sizeof(MMVector) * 2)
> -
> -#define fGEN_TCG_V6_vaddw_dv(SHORTCODE) \
> -    tcg_gen_gvec_add_var(MO_32, VddV_base, VddV_off, VuuV_base, VuuV_off, \
> -                         VvvV_base, VvvV_off, sizeof(MMVector) * 2, \
> -                         sizeof(MMVector) * 2)
> +#define fGEN_TCG_V6_vaddb_dv(SHORTCODE) fGEN_TCG_PAIR_ADDSUB_BASIC(add, MO_8)
> +#define fGEN_TCG_V6_vaddh_dv(SHORTCYDE) fGEN_TCG_PAIR_ADDSUB_BASIC(add, MO_16)
> +#define fGEN_TCG_V6_vaddw_dv(SHORTCODE) fGEN_TCG_PAIR_ADDSUB_BASIC(add, MO_32)
>  
>  /* Vector sub - various forms */
>  #define fGEN_TCG_V6_vsubb(SHORTCODE) \
>      tcg_gen_gvec_sub_var(MO_8, VdV_base, VdV_off, VuV_base, VuV_off, VvV_base, \
> -                         VvV_off, sizeof(MMVector), sizeof(MMVector))
> +                         VvV_off, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>  
>  #define fGEN_TCG_V6_vsubh(SHORTCODE) \
>      tcg_gen_gvec_sub_var(MO_16, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                         VvV_base, VvV_off, sizeof(MMVector), \
> -                         sizeof(MMVector))
> +                         VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
> +                         VECTOR_SIZE_BYTE)
>  
>  #define fGEN_TCG_V6_vsubw(SHORTCODE) \
>      tcg_gen_gvec_sub_var(MO_32, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                         VvV_base, VvV_off, sizeof(MMVector), \
> -                         sizeof(MMVector))
> +                         VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
> +                         VECTOR_SIZE_BYTE)
>  
> -#define fGEN_TCG_V6_vsubb_dv(SHORTCODE) \
> -    tcg_gen_gvec_sub_var(MO_8, VddV_base, VddV_off, VuuV_base, VuuV_off, \
> -                         VvvV_base, VvvV_off, sizeof(MMVector) * 2, \
> -                         sizeof(MMVector) * 2)
> -
> -#define fGEN_TCG_V6_vsubh_dv(SHORTCODE) \
> -    tcg_gen_gvec_sub_var(MO_16, VddV_base, VddV_off, VuuV_base, VuuV_off, \
> -                         VvvV_base, VvvV_off, sizeof(MMVector) * 2, \
> -                         sizeof(MMVector) * 2)
> -
> -#define fGEN_TCG_V6_vsubw_dv(SHORTCODE) \
> -    tcg_gen_gvec_sub_var(MO_32, VddV_base, VddV_off, VuuV_base, VuuV_off, \
> -                         VvvV_base, VvvV_off, sizeof(MMVector) * 2, \
> -                         sizeof(MMVector) * 2)
> +#define fGEN_TCG_V6_vsubb_dv(SHORTCODE) fGEN_TCG_PAIR_ADDSUB_BASIC(sub, MO_8)
> +#define fGEN_TCG_V6_vsubh_dv(SHORTCODE) fGEN_TCG_PAIR_ADDSUB_BASIC(sub, MO_16)
> +#define fGEN_TCG_V6_vsubw_dv(SHORTCODE) fGEN_TCG_PAIR_ADDSUB_BASIC(sub, MO_32)
>  
>  #define fGEN_TCG_V6_vaddbsat(SHORTCODE) \
>      tcg_gen_gvec_ssadd_var(MO_8, VdV_base, VdV_off, VuV_base, VuV_off, \
> @@ -278,8 +268,14 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>                            VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>  
>  #define fGEN_TCG_PAIR_ADDSUB(OP, VECE, DBASE, DST, ABASE, SRC_A, BBASE, SRC_B) \
> -    tcg_gen_gvec_##OP##_var(VECE, DBASE, DST, ABASE, SRC_A, BBASE, SRC_B, \
> -                           2 * VECTOR_SIZE_BYTE, 2 * VECTOR_SIZE_BYTE)
> +    do { \
> +        tcg_gen_gvec_##OP##_var(VECE, DBASE, DST, ABASE, SRC_A, BBASE, SRC_B, \
> +                                VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
> +        tcg_gen_gvec_##OP##_var(VECE, DBASE, DST + sizeof(MMVector), \
> +                                ABASE, SRC_A + sizeof(MMVector), \
> +                                BBASE, SRC_B + sizeof(MMVector), \
> +                                VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
> +    } while (0)
>  
>  #define fGEN_TCG_V6_vaddbsat_dv(SHORTCODE) \
>      fGEN_TCG_PAIR_ADDSUB(ssadd, MO_8, VddV_base, VddV_off, \
> @@ -458,7 +454,7 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>          TCGv shift = tcg_temp_new(); \
>          tcg_gen_andi_tl(shift, RtV, 15); \
>          tcg_gen_gvec_sars_var(MO_16, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                              shift, sizeof(MMVector), sizeof(MMVector)); \
> +                              shift, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>      } while (0)
>  
>  #define fGEN_TCG_V6_vasrh_acc(SHORTCODE) \
> @@ -467,10 +463,10 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>          TCGv shift = tcg_temp_new(); \
>          tcg_gen_andi_tl(shift, RtV, 15); \
>          tcg_gen_gvec_sars_var(MO_16, tcg_env, tmpoff, VuV_base, VuV_off, \
> -                              shift, sizeof(MMVector), sizeof(MMVector)); \
> +                              shift, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>          tcg_gen_gvec_add_var(MO_16, VxV_base, VxV_off, VxV_base, VxV_off, \
> -                             tcg_env, tmpoff, sizeof(MMVector), \
> -                             sizeof(MMVector)); \
> +                             tcg_env, tmpoff, VECTOR_SIZE_BYTE, \
> +                             VECTOR_SIZE_BYTE); \
>      } while (0)
>  
>  #define fGEN_TCG_V6_vasrw(SHORTCODE) \
> @@ -478,7 +474,7 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>          TCGv shift = tcg_temp_new(); \
>          tcg_gen_andi_tl(shift, RtV, 31); \
>          tcg_gen_gvec_sars_var(MO_32, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                              shift, sizeof(MMVector), sizeof(MMVector)); \
> +                              shift, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>      } while (0)
>  
>  #define fGEN_TCG_V6_vasrw_acc(SHORTCODE) \
> @@ -487,10 +483,10 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>          TCGv shift = tcg_temp_new(); \
>          tcg_gen_andi_tl(shift, RtV, 31); \
>          tcg_gen_gvec_sars_var(MO_32, tcg_env, tmpoff, VuV_base, VuV_off, \
> -                              shift, sizeof(MMVector), sizeof(MMVector)); \
> +                              shift, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>          tcg_gen_gvec_add_var(MO_32, VxV_base, VxV_off, VxV_base, VxV_off, \
> -                             tcg_env, tmpoff, sizeof(MMVector), \
> -                             sizeof(MMVector)); \
> +                             tcg_env, tmpoff, VECTOR_SIZE_BYTE, \
> +                             VECTOR_SIZE_BYTE); \
>      } while (0)
>  
>  #define fGEN_TCG_V6_vlsrb(SHORTCODE) \
> @@ -498,7 +494,7 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>          TCGv shift = tcg_temp_new(); \
>          tcg_gen_andi_tl(shift, RtV, 7); \
>          tcg_gen_gvec_shrs_var(MO_8, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                              shift, sizeof(MMVector), sizeof(MMVector)); \
> +                              shift, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>      } while (0)
>  
>  #define fGEN_TCG_V6_vlsrh(SHORTCODE) \
> @@ -506,7 +502,7 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>          TCGv shift = tcg_temp_new(); \
>          tcg_gen_andi_tl(shift, RtV, 15); \
>          tcg_gen_gvec_shrs_var(MO_16, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                              shift, sizeof(MMVector), sizeof(MMVector)); \
> +                              shift, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>      } while (0)
>  
>  #define fGEN_TCG_V6_vlsrw(SHORTCODE) \
> @@ -514,7 +510,7 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>          TCGv shift = tcg_temp_new(); \
>          tcg_gen_andi_tl(shift, RtV, 31); \
>          tcg_gen_gvec_shrs_var(MO_32, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                              shift, sizeof(MMVector), sizeof(MMVector)); \
> +                              shift, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>      } while (0)
>  
>  /* Vector shift left - various forms */
> @@ -523,7 +519,7 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>          TCGv shift = tcg_temp_new(); \
>          tcg_gen_andi_tl(shift, RtV, 7); \
>          tcg_gen_gvec_shls_var(MO_8, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                              shift, sizeof(MMVector), sizeof(MMVector)); \
> +                              shift, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>      } while (0)
>  
>  #define fGEN_TCG_V6_vaslh(SHORTCODE) \
> @@ -531,7 +527,7 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>          TCGv shift = tcg_temp_new(); \
>          tcg_gen_andi_tl(shift, RtV, 15); \
>          tcg_gen_gvec_shls_var(MO_16, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                              shift, sizeof(MMVector), sizeof(MMVector)); \
> +                              shift, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>      } while (0)
>  
>  #define fGEN_TCG_V6_vaslh_acc(SHORTCODE) \
> @@ -540,10 +536,10 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>          TCGv shift = tcg_temp_new(); \
>          tcg_gen_andi_tl(shift, RtV, 15); \
>          tcg_gen_gvec_shls_var(MO_16, tcg_env, tmpoff, VuV_base, VuV_off, \
> -                              shift, sizeof(MMVector), sizeof(MMVector)); \
> +                              shift, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>          tcg_gen_gvec_add_var(MO_16, VxV_base, VxV_off, VxV_base, VxV_off, \
> -                             tcg_env, tmpoff, sizeof(MMVector), \
> -                             sizeof(MMVector)); \
> +                             tcg_env, tmpoff, VECTOR_SIZE_BYTE, \
> +                             VECTOR_SIZE_BYTE); \
>      } while (0)
>  
>  #define fGEN_TCG_V6_vaslw(SHORTCODE) \
> @@ -551,7 +547,7 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>          TCGv shift = tcg_temp_new(); \
>          tcg_gen_andi_tl(shift, RtV, 31); \
>          tcg_gen_gvec_shls_var(MO_32, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                              shift, sizeof(MMVector), sizeof(MMVector)); \
> +                              shift, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>      } while (0)
>  
>  #define fGEN_TCG_V6_vaslw_acc(SHORTCODE) \
> @@ -560,74 +556,74 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>          TCGv shift = tcg_temp_new(); \
>          tcg_gen_andi_tl(shift, RtV, 31); \
>          tcg_gen_gvec_shls_var(MO_32, tcg_env, tmpoff, VuV_base, VuV_off, \
> -                              shift, sizeof(MMVector), sizeof(MMVector)); \
> +                              shift, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>          tcg_gen_gvec_add_var(MO_32, VxV_base, VxV_off, VxV_base, VxV_off, \
> -                             tcg_env, tmpoff, sizeof(MMVector), \
> -                             sizeof(MMVector)); \
> +                             tcg_env, tmpoff, VECTOR_SIZE_BYTE, \
> +                             VECTOR_SIZE_BYTE); \
>      } while (0)
>  
>  /* Vector max - various forms */
>  #define fGEN_TCG_V6_vmaxw(SHORTCODE) \
>      tcg_gen_gvec_smax_var(MO_32, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                          VvV_base, VvV_off, sizeof(MMVector), \
> -                          sizeof(MMVector))
> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
> +                          VECTOR_SIZE_BYTE)
>  #define fGEN_TCG_V6_vmaxh(SHORTCODE) \
>      tcg_gen_gvec_smax_var(MO_16, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                          VvV_base, VvV_off, sizeof(MMVector), \
> -                          sizeof(MMVector))
> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
> +                          VECTOR_SIZE_BYTE)
>  #define fGEN_TCG_V6_vmaxuh(SHORTCODE) \
>      tcg_gen_gvec_umax_var(MO_16, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                          VvV_base, VvV_off, sizeof(MMVector), \
> -                          sizeof(MMVector))
> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
> +                          VECTOR_SIZE_BYTE)
>  #define fGEN_TCG_V6_vmaxb(SHORTCODE) \
>      tcg_gen_gvec_smax_var(MO_8, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                          VvV_base, VvV_off, sizeof(MMVector), \
> -                          sizeof(MMVector))
> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
> +                          VECTOR_SIZE_BYTE)
>  #define fGEN_TCG_V6_vmaxub(SHORTCODE) \
>      tcg_gen_gvec_umax_var(MO_8, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                          VvV_base, VvV_off, sizeof(MMVector), \
> -                          sizeof(MMVector))
> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
> +                          VECTOR_SIZE_BYTE)
>  
>  /* Vector min - various forms */
>  #define fGEN_TCG_V6_vminw(SHORTCODE) \
>      tcg_gen_gvec_smin_var(MO_32, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                          VvV_base, VvV_off, sizeof(MMVector), \
> -                          sizeof(MMVector))
> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
> +                          VECTOR_SIZE_BYTE)
>  #define fGEN_TCG_V6_vminh(SHORTCODE) \
>      tcg_gen_gvec_smin_var(MO_16, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                          VvV_base, VvV_off, sizeof(MMVector), \
> -                          sizeof(MMVector))
> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
> +                          VECTOR_SIZE_BYTE)
>  #define fGEN_TCG_V6_vminuh(SHORTCODE) \
>      tcg_gen_gvec_umin_var(MO_16, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                          VvV_base, VvV_off, sizeof(MMVector), \
> -                          sizeof(MMVector))
> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
> +                          VECTOR_SIZE_BYTE)
>  #define fGEN_TCG_V6_vminb(SHORTCODE) \
>      tcg_gen_gvec_smin_var(MO_8, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                          VvV_base, VvV_off, sizeof(MMVector), \
> -                          sizeof(MMVector))
> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
> +                          VECTOR_SIZE_BYTE)
>  #define fGEN_TCG_V6_vminub(SHORTCODE) \
>      tcg_gen_gvec_umin_var(MO_8, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                          VvV_base, VvV_off, sizeof(MMVector), \
> -                          sizeof(MMVector))
> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
> +                          VECTOR_SIZE_BYTE)
>  
>  /* Vector logical ops */
>  #define fGEN_TCG_V6_vxor(SHORTCODE) \
>      tcg_gen_gvec_xor_var(MO_64, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                         VvV_base, VvV_off, sizeof(MMVector), \
> -                         sizeof(MMVector))
> +                         VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
> +                         VECTOR_SIZE_BYTE)
>  
>  #define fGEN_TCG_V6_vand(SHORTCODE) \
>      tcg_gen_gvec_and_var(MO_64, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                         VvV_base, VvV_off, sizeof(MMVector), \
> -                         sizeof(MMVector))
> +                         VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
> +                         VECTOR_SIZE_BYTE)
>  
>  #define fGEN_TCG_V6_vor(SHORTCODE) \
>      tcg_gen_gvec_or_var(MO_64, VdV_base, VdV_off, VuV_base, VuV_off, VvV_base, \
> -                        VvV_off, sizeof(MMVector), sizeof(MMVector))
> +                        VvV_off, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>  
>  #define fGEN_TCG_V6_vnot(SHORTCODE) \
>      tcg_gen_gvec_not_var(MO_64, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                         sizeof(MMVector), sizeof(MMVector))
> +                         VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>  
>  /* Q register logical ops */
>  #define fGEN_TCG_V6_pred_or(SHORTCODE) \
> @@ -659,8 +655,8 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>      do { \
>          intptr_t tmpoff = offsetof(CPUHexagonState, vtmp); \
>          tcg_gen_gvec_cmp_var(COND, TYPE, tcg_env, tmpoff, VuV_base, VuV_off, \
> -                             VvV_base, VvV_off, sizeof(MMVector), \
> -                             sizeof(MMVector)); \
> +                             VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
> +                             VECTOR_SIZE_BYTE); \
>          vec_to_qvec(SIZE, QdV_base, QdV_off, tcg_env, tmpoff); \
>      } while (0)
>  
> @@ -690,8 +686,8 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>          intptr_t tmpoff = offsetof(CPUHexagonState, vtmp); \
>          intptr_t qoff = offsetof(CPUHexagonState, qtmp); \
>          tcg_gen_gvec_cmp_var(COND, TYPE, tcg_env, tmpoff, VuV_base, VuV_off, \
> -                             VvV_base, VvV_off, sizeof(MMVector), \
> -                             sizeof(MMVector)); \
> +                             VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
> +                             VECTOR_SIZE_BYTE); \
>          vec_to_qvec(SIZE, tcg_env, qoff, tcg_env, tmpoff); \
>          OP(MO_64, QxV_base, QxV_off, QxV_base, QxV_off, tcg_env, qoff, \
>             sizeof(MMQReg), sizeof(MMQReg)); \
> @@ -762,29 +758,29 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>  
>  /* Vector splat - various forms */
>  #define fGEN_TCG_V6_lvsplatw(SHORTCODE) \
> -    tcg_gen_gvec_dup_i32_var(MO_32, VdV_base, VdV_off, sizeof(MMVector), \
> -                             sizeof(MMVector), RtV)
> +    tcg_gen_gvec_dup_i32_var(MO_32, VdV_base, VdV_off, VECTOR_SIZE_BYTE, \
> +                             VECTOR_SIZE_BYTE, RtV)
>  
>  #define fGEN_TCG_V6_lvsplath(SHORTCODE) \
> -    tcg_gen_gvec_dup_i32_var(MO_16, VdV_base, VdV_off, sizeof(MMVector), \
> -                             sizeof(MMVector), RtV)
> +    tcg_gen_gvec_dup_i32_var(MO_16, VdV_base, VdV_off, VECTOR_SIZE_BYTE, \
> +                             VECTOR_SIZE_BYTE, RtV)
>  
>  #define fGEN_TCG_V6_lvsplatb(SHORTCODE) \
> -    tcg_gen_gvec_dup_i32_var(MO_8, VdV_base, VdV_off, sizeof(MMVector), \
> -                             sizeof(MMVector), RtV)
> +    tcg_gen_gvec_dup_i32_var(MO_8, VdV_base, VdV_off, VECTOR_SIZE_BYTE, \
> +                             VECTOR_SIZE_BYTE, RtV)
>  
>  /* Vector absolute value - various forms */
>  #define fGEN_TCG_V6_vabsb(SHORTCODE) \
>      tcg_gen_gvec_abs_var(MO_8, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                         sizeof(MMVector), sizeof(MMVector))
> +                         VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>  
>  #define fGEN_TCG_V6_vabsh(SHORTCODE) \
>      tcg_gen_gvec_abs_var(MO_16, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                         sizeof(MMVector), sizeof(MMVector))
> +                         VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>  
>  #define fGEN_TCG_V6_vabsw(SHORTCODE) \
>      tcg_gen_gvec_abs_var(MO_32, VdV_base, VdV_off, VuV_base, VuV_off, \
> -                         sizeof(MMVector), sizeof(MMVector))
> +                         VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>  
>  /* Vector loads */
>  #define fGEN_TCG_V6_vL32b_pi(SHORTCODE)                    SHORTCODE
> @@ -826,12 +822,12 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>      fGEN_TCG_PRED_VEC_LOAD(fLSBOLD(PvV), \
>                             fEA_REG(RxV), \
>                             VdV, \
> -                           fPM_I(RxV, siV * sizeof(MMVector)))
> +                           fPM_I(RxV, siV * VECTOR_SIZE_BYTE))
>  #define fGEN_TCG_PRED_VEC_LOAD_npred_pi \
>      fGEN_TCG_PRED_VEC_LOAD(fLSBOLDNOT(PvV), \
>                             fEA_REG(RxV), \
>                             VdV, \
> -                           fPM_I(RxV, siV * sizeof(MMVector)))
> +                           fPM_I(RxV, siV * VECTOR_SIZE_BYTE))
>  
>  #define fGEN_TCG_V6_vL32b_pred_pi(SHORTCODE) \
>      fGEN_TCG_PRED_VEC_LOAD_pred_pi
> @@ -860,12 +856,12 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>  
>  #define fGEN_TCG_PRED_VEC_LOAD_pred_ai \
>      fGEN_TCG_PRED_VEC_LOAD(fLSBOLD(PvV), \
> -                           fEA_RI(RtV, siV * sizeof(MMVector)), \
> +                           fEA_RI(RtV, siV * VECTOR_SIZE_BYTE), \
>                             VdV, \
>                             do {} while (0))
>  #define fGEN_TCG_PRED_VEC_LOAD_npred_ai \
>      fGEN_TCG_PRED_VEC_LOAD(fLSBOLDNOT(PvV), \
> -                           fEA_RI(RtV, siV * sizeof(MMVector)), \
> +                           fEA_RI(RtV, siV * VECTOR_SIZE_BYTE), \
>                             VdV, \
>                             do {} while (0))
>  
> @@ -950,7 +946,7 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>      } while (0)
>  
>  #define fGEN_TCG_NEWVAL_VEC_STORE_pi \
> -    fGEN_TCG_NEWVAL_VEC_STORE(fEA_REG(RxV), fPM_I(RxV, siV * sizeof(MMVector)))
> +    fGEN_TCG_NEWVAL_VEC_STORE(fEA_REG(RxV), fPM_I(RxV, siV * VECTOR_SIZE_BYTE))
>  
>  #define fGEN_TCG_V6_vS32b_new_pi(SHORTCODE) \
>      fGEN_TCG_NEWVAL_VEC_STORE_pi
> @@ -958,7 +954,7 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>      fGEN_TCG_NEWVAL_VEC_STORE_pi
>  
>  #define fGEN_TCG_NEWVAL_VEC_STORE_ai \
> -    fGEN_TCG_NEWVAL_VEC_STORE(fEA_RI(RtV, siV * sizeof(MMVector)), \
> +    fGEN_TCG_NEWVAL_VEC_STORE(fEA_RI(RtV, siV * VECTOR_SIZE_BYTE), \
>                                do { } while (0))
>  
>  #define fGEN_TCG_V6_vS32b_new_ai(SHORTCODE) \
> @@ -992,22 +988,22 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>      fGEN_TCG_PRED_VEC_STORE(fLSBOLD(PvV), \
>                              fEA_REG(RxV), \
>                              VsV, ALIGN, \
> -                            fPM_I(RxV, siV * sizeof(MMVector)))
> +                            fPM_I(RxV, siV * VECTOR_SIZE_BYTE))
>  #define fGEN_TCG_PRED_VEC_STORE_npred_pi(ALIGN) \
>      fGEN_TCG_PRED_VEC_STORE(fLSBOLDNOT(PvV), \
>                              fEA_REG(RxV), \
>                              VsV, ALIGN, \
> -                            fPM_I(RxV, siV * sizeof(MMVector)))
> +                            fPM_I(RxV, siV * VECTOR_SIZE_BYTE))
>  #define fGEN_TCG_PRED_VEC_STORE_new_pred_pi \
>      fGEN_TCG_PRED_VEC_STORE(fLSBOLD(PvV), \
>                              fEA_REG(RxV), \
>                              OsN, true, \
> -                            fPM_I(RxV, siV * sizeof(MMVector)))
> +                            fPM_I(RxV, siV * VECTOR_SIZE_BYTE))
>  #define fGEN_TCG_PRED_VEC_STORE_new_npred_pi \
>      fGEN_TCG_PRED_VEC_STORE(fLSBOLDNOT(PvV), \
>                              fEA_REG(RxV), \
>                              OsN, true, \
> -                            fPM_I(RxV, siV * sizeof(MMVector)))
> +                            fPM_I(RxV, siV * VECTOR_SIZE_BYTE))
>  
>  #define fGEN_TCG_V6_vS32b_pred_pi(SHORTCODE) \
>      fGEN_TCG_PRED_VEC_STORE_pred_pi(true)
> @@ -1032,22 +1028,22 @@ static inline void assert_vhist_tmp(DisasContext *ctx)
>  
>  #define fGEN_TCG_PRED_VEC_STORE_pred_ai(ALIGN) \
>      fGEN_TCG_PRED_VEC_STORE(fLSBOLD(PvV), \
> -                            fEA_RI(RtV, siV * sizeof(MMVector)), \
> +                            fEA_RI(RtV, siV * VECTOR_SIZE_BYTE), \
>                              VsV, ALIGN, \
>                              do { } while (0))
>  #define fGEN_TCG_PRED_VEC_STORE_npred_ai(ALIGN) \
>      fGEN_TCG_PRED_VEC_STORE(fLSBOLDNOT(PvV), \
> -                            fEA_RI(RtV, siV * sizeof(MMVector)), \
> +                            fEA_RI(RtV, siV * VECTOR_SIZE_BYTE), \
>                              VsV, ALIGN, \
>                              do { } while (0))
>  #define fGEN_TCG_PRED_VEC_STORE_new_pred_ai \
>      fGEN_TCG_PRED_VEC_STORE(fLSBOLD(PvV), \
> -                            fEA_RI(RtV, siV * sizeof(MMVector)), \
> +                            fEA_RI(RtV, siV * VECTOR_SIZE_BYTE), \
>                              OsN, true, \
>                              do { } while (0))
>  #define fGEN_TCG_PRED_VEC_STORE_new_npred_ai \
>      fGEN_TCG_PRED_VEC_STORE(fLSBOLDNOT(PvV), \
> -                            fEA_RI(RtV, siV * sizeof(MMVector)), \
> +                            fEA_RI(RtV, siV * VECTOR_SIZE_BYTE), \
>                              OsN, true, \
>                              do { } while (0))
>  
> diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
> index 74c277fc06f..2bf360dd2c1 100644
> --- a/target/hexagon/mmvec/macros.h
> +++ b/target/hexagon/mmvec/macros.h
> @@ -221,7 +221,7 @@
>  #define SCATTER_OP_WRITE_TO_MEM(TYPE) \
>      do { \
>          ra = GETPC(); \
> -        for (int i = 0; i < sizeof(MMVector); i += sizeof(TYPE)) { \
> +        for (int i = 0; i < MAX_VEC_SIZE_BYTES; i += sizeof(TYPE)) { \
>              if (test_bit(i, env->vtcm_log.mask)) { \
>                  TYPE dst = 0; \
>                  TYPE inc = 0; \
> @@ -244,7 +244,7 @@
>      } while (0)
>  #define SCATTER_OP_PROBE_MEM(TYPE, MMU_IDX, RETADDR) \
>      do { \
> -        for (int i = 0; i < sizeof(MMVector); i += sizeof(TYPE)) { \
> +        for (int i = 0; i < MAX_VEC_SIZE_BYTES; i += sizeof(TYPE)) { \
>              if (test_bit(i, env->vtcm_log.mask)) { \
>                  for (int j = 0; j < sizeof(TYPE); j++) { \
>                      probe_read(env, env->vtcm_log.va[i + j], 1, \
> @@ -329,8 +329,8 @@
>  #endif
>  #define fVFOREACH(WIDTH, VAR) for (VAR = 0; VAR < fVELEM(WIDTH); VAR++)
>  #define fVARRAY_ELEMENT_ACCESS(ARRAY, TYPE, INDEX) \
> -    ARRAY.v[(INDEX) / (fVECSIZE() / (sizeof(ARRAY.TYPE[0])))].TYPE[(INDEX) % \
> -    (fVECSIZE() / (sizeof(ARRAY.TYPE[0])))]
> +    ARRAY.v[(INDEX) / (fVECSIZE() / (sizeof(ARRAY.v[0].TYPE[0])))] \
> +        .TYPE[(INDEX) % (fVECSIZE() / (sizeof(ARRAY.v[0].TYPE[0])))]
>  
>  #define fVSATDW(U, V) fVSATW(((((long long)U) << 32) | fZXTN(32, 64, V)))
>  #define fVASL_SATHI(U, V) fVSATW(((U) << 1) | ((V) >> 31))
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index cd4ae2f6838..845854f7bb7 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -1508,9 +1508,9 @@ static void gen_vreg_load(DisasContext *ctx, TCGv_ptr dstbase,
>  {
>      TCGv_i64 tmp = tcg_temp_new_i64();
>      if (aligned) {
> -        tcg_gen_andi_tl(src, src, ~((int32_t)sizeof(MMVector) - 1));
> +        tcg_gen_andi_tl(src, src, ~((int32_t)MAX_VEC_SIZE_BYTES - 1));
>      }
> -    for (int i = 0; i < sizeof(MMVector) / 8; i++) {
> +    for (int i = 0; i < MAX_VEC_SIZE_BYTES / 8; i++) {
>          tcg_gen_qemu_ld_i64(tmp, src, ctx->mem_idx, MO_LE | MO_UQ);
>          tcg_gen_addi_tl(src, src, 8);
>          tcg_gen_st_i64(tmp, dstbase, dstoff + i * 8);
> @@ -1532,15 +1532,15 @@ static void gen_vreg_store(DisasContext *ctx, TCGv EA, TCGv_ptr srcbase,
>      tcg_gen_movi_tl(hex_vstore_pending[slot], 1);
>      if (aligned) {
>          tcg_gen_andi_tl(hex_vstore_addr[slot], EA,
> -                        ~((int32_t)sizeof(MMVector) - 1));
> +                        ~((int32_t)MAX_VEC_SIZE_BYTES - 1));
>      } else {
>          tcg_gen_mov_tl(hex_vstore_addr[slot], EA);
>      }
> -    tcg_gen_movi_tl(hex_vstore_size[slot], sizeof(MMVector));
> +    tcg_gen_movi_tl(hex_vstore_size[slot], MAX_VEC_SIZE_BYTES);
>  
>      /* Copy the data to the vstore buffer */
>      tcg_gen_gvec_mov_var(MO_64, tcg_env, dstoff, srcbase, srcoff,
> -                         sizeof(MMVector), sizeof(MMVector));
> +                         MAX_VEC_SIZE_BYTES, MAX_VEC_SIZE_BYTES);
>      /* Set the mask to all 1's */
>      tcg_gen_gvec_dup_imm(MO_64, maskoff, sizeof(MMQReg), sizeof(MMQReg), ~0LL);
>  }
> @@ -1555,12 +1555,12 @@ static void gen_vreg_masked_store(DisasContext *ctx, TCGv EA,
>  
>      tcg_gen_movi_tl(hex_vstore_pending[slot], 1);
>      tcg_gen_andi_tl(hex_vstore_addr[slot], EA,
> -                    ~((int32_t)sizeof(MMVector) - 1));
> -    tcg_gen_movi_tl(hex_vstore_size[slot], sizeof(MMVector));
> +                    ~((int32_t)MAX_VEC_SIZE_BYTES - 1));
> +    tcg_gen_movi_tl(hex_vstore_size[slot], MAX_VEC_SIZE_BYTES);
>  
>      /* Copy the data to the vstore buffer */
>      tcg_gen_gvec_mov_var(MO_64, tcg_env, dstoff, srcbase, srcoff,
> -                         sizeof(MMVector), sizeof(MMVector));
> +                         MAX_VEC_SIZE_BYTES, MAX_VEC_SIZE_BYTES);
>      /* Copy the mask */
>      tcg_gen_gvec_mov_var(MO_64, tcg_env, maskoff, bitsbase, bitsoff,
>                           sizeof(MMQReg), sizeof(MMQReg));
> @@ -1580,7 +1580,7 @@ static void vec_to_qvec(size_t size, TCGv_ptr dstbase, intptr_t dstoff,
>      TCGv_i64 zero = tcg_constant_i64(0);
>      TCGv_i64 ones = tcg_constant_i64(~0);
>  
> -    for (int i = 0; i < sizeof(MMVector) / 8; i++) {
> +    for (int i = 0; i < MAX_VEC_SIZE_BYTES / 8; i++) {
>          tcg_gen_ld_i64(tmp, srcbase, srcoff + i * 8);
>          tcg_gen_movi_i64(mask, 0);
>  
> diff --git a/target/hexagon/mmvec/system_ext_mmvec.c b/target/hexagon/mmvec/system_ext_mmvec.c
> index 081cadd814a..3777f68d6e7 100644
> --- a/target/hexagon/mmvec/system_ext_mmvec.c
> +++ b/target/hexagon/mmvec/system_ext_mmvec.c
> @@ -21,15 +21,13 @@
>  
>  void mem_gather_store(CPUHexagonState *env, target_ulong vaddr, int slot)
>  {
> -    size_t size = sizeof(MMVector);
> -
>      env->vstore_pending[slot] = 1;
>      env->vstore[slot].va   = vaddr;
> -    env->vstore[slot].size = size;
> -    memcpy(&env->vstore[slot].data, &env->tmp_VRegs[0], size);
> +    env->vstore[slot].size = MAX_VEC_SIZE_BYTES;
> +    memcpy(&env->vstore[slot].data, &env->tmp_VRegs[0], MAX_VEC_SIZE_BYTES);
>  
>      /* On a gather store, overwrite the store mask to emulate dropped gathers */
> -    bitmap_copy(env->vstore[slot].mask, env->vtcm_log.mask, size);
> +    bitmap_copy(env->vstore[slot].mask, env->vtcm_log.mask, MAX_VEC_SIZE_BYTES);
>  }
>  
>  void mem_vector_scatter_init(CPUHexagonState *env)
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 4f00ca773f3..4d948d548bc 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -191,7 +191,7 @@ void HELPER(commit_hvx_stores)(CPUHexagonState *env)
>                  g_assert_not_reached();
>              }
>          } else {
> -            for (int i = 0; i < sizeof(MMVector); i++) {
> +            for (int i = 0; i < MAX_VEC_SIZE_BYTES; i++) {
>                  if (test_bit(i, env->vtcm_log.mask)) {
>                      cpu_stb_data_ra(env, env->vtcm_log.va[i],
>                                       hexagon_mmvec_get_byte(&env->vtcm_log.data,
> @@ -491,7 +491,7 @@ static void probe_hvx_stores(CPUHexagonState *env, int mmu_idx,
>                  g_assert_not_reached();
>              }
>          } else {
> -            for (int i = 0; i < sizeof(MMVector); i++) {
> +            for (int i = 0; i < MAX_VEC_SIZE_BYTES; i++) {
>                  if (test_bit(i, env->vtcm_log.mask)) {
>                      probe_write(env, env->vtcm_log.va[i], 1, mmu_idx, retaddr);
>                  }
> @@ -1408,14 +1408,14 @@ void HELPER(vhist)(CPUHexagonState *env)
>      MMVector *input = &env->tmp_VRegs[0];
>  
>      for (int lane = 0; lane < 8; lane++) {
> -        for (int i = 0; i < sizeof(MMVector) / 8; ++i) {
> +        for (int i = 0; i < MAX_VEC_SIZE_BYTES / 8; ++i) {
>              unsigned char value = hexagon_mmvec_get_byte(input,
> -                (sizeof(MMVector) / 8) * lane + i);
> +                (MAX_VEC_SIZE_BYTES / 8) * lane + i);
>              unsigned char regno = value >> 3;
>              unsigned char element = value & 7;
>  
>              hex_hvx(env)->VRegs[regno]
> -                .uh[(sizeof(MMVector) / 16) * lane + element]++;
> +                .uh[(MAX_VEC_SIZE_BYTES / 16) * lane + element]++;
>          }
>      }
>  }
> @@ -1425,15 +1425,15 @@ void HELPER(vhistq)(CPUHexagonState *env)
>      MMVector *input = &env->tmp_VRegs[0];
>  
>      for (int lane = 0; lane < 8; lane++) {
> -        for (int i = 0; i < sizeof(MMVector) / 8; ++i) {
> +        for (int i = 0; i < MAX_VEC_SIZE_BYTES / 8; ++i) {
>              unsigned char value = hexagon_mmvec_get_byte(input,
> -                (sizeof(MMVector) / 8) * lane + i);
> +                (MAX_VEC_SIZE_BYTES / 8) * lane + i);
>              unsigned char regno = value >> 3;
>              unsigned char element = value & 7;
>  
> -            if (fGETQBIT(env->qtmp, sizeof(MMVector) / 8 * lane + i)) {
> +            if (fGETQBIT(env->qtmp, MAX_VEC_SIZE_BYTES / 8 * lane + i)) {
>                  hex_hvx(env)->VRegs[regno].uh[
> -                    (sizeof(MMVector) / 16) * lane + element]++;
> +                    (MAX_VEC_SIZE_BYTES / 16) * lane + element]++;
>              }
>          }
>      }
> @@ -1443,7 +1443,7 @@ void HELPER(vwhist256)(CPUHexagonState *env)
>  {
>      MMVector *input = &env->tmp_VRegs[0];
>  
> -    for (int i = 0; i < (sizeof(MMVector) / 2); i++) {
> +    for (int i = 0; i < (MAX_VEC_SIZE_BYTES / 2); i++) {
>          unsigned int bucket = fGETUBYTE(0, input->h[i]);
>          unsigned int weight = fGETUBYTE(1, input->h[i]);
>          unsigned int vindex = (bucket >> 3) & 0x1F;
> @@ -1458,7 +1458,7 @@ void HELPER(vwhist256q)(CPUHexagonState *env)
>  {
>      MMVector *input = &env->tmp_VRegs[0];
>  
> -    for (int i = 0; i < (sizeof(MMVector) / 2); i++) {
> +    for (int i = 0; i < (MAX_VEC_SIZE_BYTES / 2); i++) {
>          unsigned int bucket = fGETUBYTE(0, input->h[i]);
>          unsigned int weight = fGETUBYTE(1, input->h[i]);
>          unsigned int vindex = (bucket >> 3) & 0x1F;
> @@ -1475,7 +1475,7 @@ void HELPER(vwhist256_sat)(CPUHexagonState *env)
>  {
>      MMVector *input = &env->tmp_VRegs[0];
>  
> -    for (int i = 0; i < (sizeof(MMVector) / 2); i++) {
> +    for (int i = 0; i < (MAX_VEC_SIZE_BYTES / 2); i++) {
>          unsigned int bucket = fGETUBYTE(0, input->h[i]);
>          unsigned int weight = fGETUBYTE(1, input->h[i]);
>          unsigned int vindex = (bucket >> 3) & 0x1F;
> @@ -1490,7 +1490,7 @@ void HELPER(vwhist256q_sat)(CPUHexagonState *env)
>  {
>      MMVector *input = &env->tmp_VRegs[0];
>  
> -    for (int i = 0; i < (sizeof(MMVector) / 2); i++) {
> +    for (int i = 0; i < (MAX_VEC_SIZE_BYTES / 2); i++) {
>          unsigned int bucket = fGETUBYTE(0, input->h[i]);
>          unsigned int weight = fGETUBYTE(1, input->h[i]);
>          unsigned int vindex = (bucket >> 3) & 0x1F;
> @@ -1507,7 +1507,7 @@ void HELPER(vwhist128)(CPUHexagonState *env)
>  {
>      MMVector *input = &env->tmp_VRegs[0];
>  
> -    for (int i = 0; i < (sizeof(MMVector) / 2); i++) {
> +    for (int i = 0; i < (MAX_VEC_SIZE_BYTES / 2); i++) {
>          unsigned int bucket = fGETUBYTE(0, input->h[i]);
>          unsigned int weight = fGETUBYTE(1, input->h[i]);
>          unsigned int vindex = (bucket >> 3) & 0x1F;
> @@ -1522,7 +1522,7 @@ void HELPER(vwhist128q)(CPUHexagonState *env)
>  {
>      MMVector *input = &env->tmp_VRegs[0];
>  
> -    for (int i = 0; i < (sizeof(MMVector) / 2); i++) {
> +    for (int i = 0; i < (MAX_VEC_SIZE_BYTES / 2); i++) {
>          unsigned int bucket = fGETUBYTE(0, input->h[i]);
>          unsigned int weight = fGETUBYTE(1, input->h[i]);
>          unsigned int vindex = (bucket >> 3) & 0x1F;
> @@ -1539,7 +1539,7 @@ void HELPER(vwhist128m)(CPUHexagonState *env, int32_t uiV)
>  {
>      MMVector *input = &env->tmp_VRegs[0];
>  
> -    for (int i = 0; i < (sizeof(MMVector) / 2); i++) {
> +    for (int i = 0; i < (MAX_VEC_SIZE_BYTES / 2); i++) {
>          unsigned int bucket = fGETUBYTE(0, input->h[i]);
>          unsigned int weight = fGETUBYTE(1, input->h[i]);
>          unsigned int vindex = (bucket >> 3) & 0x1F;
> @@ -1556,7 +1556,7 @@ void HELPER(vwhist128qm)(CPUHexagonState *env, int32_t uiV)
>  {
>      MMVector *input = &env->tmp_VRegs[0];
>  
> -    for (int i = 0; i < (sizeof(MMVector) / 2); i++) {
> +    for (int i = 0; i < (MAX_VEC_SIZE_BYTES / 2); i++) {
>          unsigned int bucket = fGETUBYTE(0, input->h[i]);
>          unsigned int weight = fGETUBYTE(1, input->h[i]);
>          unsigned int vindex = (bucket >> 3) & 0x1F;

It seems that this patch do different kind of changes, and uses various
values:
- keep sizeof(MMVector) is some macros (?), like fGEN_TCG_PAIR_ADDSUB_BASIC.
- use MAX_VEC_SIZE_BYTES
- use VECTOR_SIZE_BYTE

What's the difference between those cases?

Regards,
Pierrick

