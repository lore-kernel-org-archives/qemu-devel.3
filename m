Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5725606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jwhkR+7P;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S4ujcFat
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMpgn-0000vp-Ls; Fri, 30 Oct 2026 12:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMpgj-0000uX-6y
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:42:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMpgf-0001Mc-7c
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:42:44 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERKOg2968111
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 16:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TU8jHmk2uLMgwuwk13Gs2rXwiuyZ9eCjry52indLm2w=; b=jwhkR+7PfRtLQV5T
 0hpjqgqxY4dUbFenl03AwC8LnQPkifzaptAfHQ4PP5HY8NpiLSfriXADV7tqOYI9
 mzZZjz6fpDTMUHzn9RYznjF0pxDfDDfGIS2/vMU8l/1SxmL34P8dXcc8WRaO22qS
 688LLf4ecQvuTfb2EBjom0NMbjYwS0E7Xa2N8+oLb3neHtSJd7w7TXbBO/RIEDKd
 qP1+dYQFIv/EEAd5Ss3JkQL15mC6Ge6LSBPCDzi4GoZXquSHQsu46KO2E/5Beqfu
 eOzxCb/anZiyYvb9kyhcfUUJfYr0z+XBnU4KaNo09jWfU9u083gXVVF1FCExJ7ve
 WLutFA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qm2dw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 16:42:39 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-917a7c17166so18947366d6.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793378558; x=1793983358; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TU8jHmk2uLMgwuwk13Gs2rXwiuyZ9eCjry52indLm2w=;
 b=S4ujcFatT3sMehPVsV0djnEbDAoEsUKWPGT8/xBskzHb3nKJ0RfDkTo8AcF8QFDiCV
 hZ/16cC2cfZgTm+8Cq9mM0nqqnZLgsAUEU2ns3mhBkLDtg2npSc/CpbOJc1GY3yXJDLV
 CvQ9Id1IsThzTFvCFMv24f2aLTVA2jCm4mCEVvcQOSO+R5b9lH+68wVb09ARorQnerJa
 Fcm+d5Lr1R2umTwEPmZqkKl0W69pjFUJ7XAcSJLglBjGLYYq/w2l+W0lPTR7PGqSUNTD
 zQGKayUfPkey8GQf7JCB9ogMRMLiCbJFa+tboeX+ixRCtfv+CadB/axKDCud7f95Zt35
 sTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793378558; x=1793983358;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TU8jHmk2uLMgwuwk13Gs2rXwiuyZ9eCjry52indLm2w=;
 b=B7JNAot0inJROMGFXlLqNx/dCXF+Fl4zdzMYDGq7aNSwzmXRfg3yDpRziQfGs49/Kb
 /BHOQqyQu4MgF+kZ4Rg0ObSlUradDWANv+iSHnof36xoiMF1Q6/SwVPx5hKiv7H8T+Ek
 6geZESWA8/Ils3zU8cgfd2+/SNxAVGV5LV7cEdNiW9zcBskYNCeoAwLKVvDh1cat+2b3
 /jukw/QhC/rCnTybf+EnLSn4UmO56gbearCfDylXLi/peHM7p5a5t5eqQvq//lEzv5gC
 O5MO9F1QSIHcsjBG/uFk94I6DpBIWVojuB97G6IzA0cx6Re3nHSMB8hnbxvWD2WeHBuL
 mKZw==
X-Forwarded-Encrypted: i=1;
 AKwUvByy6yfGT/VQEjVmO/vlFUYavbD8NetwZb+pCOqJNnihGHhC+4GNlkrm65UD/XtPmW+yhnMxSWGMcZuk@nongnu.org
X-Gm-Message-State: AFq9FYLHadt8mQEShreyYfsc96UyiUVMzax0ynkwuPEE1/b7EVXoUHPr
 buy25lcuO4EX/xyq5ZDTeXrknme6aAJ1c8qit3OhkR5j8CV+c0VOwyA4Ngq8WZlJFJxxdXRJUmX
 kyZKqJ5Hs2ArkYrn14VClc9/mODpsF5IW/PrhbHEbKvxE4aX0IdmXXiyLkcC0zLI3Xw==
X-Gm-Gg: AYBFou3Cca9g0SPNSHAlWfM/dYgoU/Osd94gVlBng+4vJTuxpK7uPgDVoyWAFPVNil+
 UtEy3fgV37nfTyfC4JOrTGHAgkB0BTApLv9WZe1uinrskZS7cC6P68DtLLOY77zJY6p/PUzBiaR
 P05TsqsY6CCiRCeW40PQd49avRGPddly/XNFBQ/fRuxcWQLEHxT3ELm0NFn4EAFQoJasTmSgm/B
 +SOESYaoyEfnj7FgQPQsRqjJ1uU0QFClG72C4gXjFCMgYPT9/vRWIVvdaN1j1+L1XalNg92/IJY
 E8CgDoAUvR1nxDR+xaMjKhjlwdaVCk76I1DsfZnPF74XggPY6Tr70VA9Ki0dddWzT76g4rt4bUv
 7sr0wPeWvrdDACiQCv40ANZUGe80/zfRMB63Lir6/MRvvQTvmoheO+qBdgU3Xb42Nm28+pLy2xg
 9yHTrvrn7VQlnMNR5onv4wwWcx/frrilamV4gncw==
X-Received: by 2002:a05:6214:4016:b0:91c:61e9:7b76 with SMTP id
 6a1803df08f44-91ca4b1d39dmr41662996d6.26.1793378557871; 
 Fri, 30 Oct 2026 09:42:37 -0700 (PDT)
X-Received: by 2002:a05:6214:4016:b0:91c:61e9:7b76 with SMTP id
 6a1803df08f44-91ca4b1d39dmr41662446d6.26.1793378557183; 
 Fri, 30 Oct 2026 09:42:37 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca7f3f903sm19219806d6.17.2026.10.30.09.42.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 09:42:35 -0700 (PDT)
Message-ID: <a06084bd-6995-4174-8d88-557ce087b4d1@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 11:42:34 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/20] target/hexagon: emit basic HLX vector operations
 inline
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-8-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-8-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2NiBTYWx0ZWRfX2kI5L0mAKKHL
 ROBW+yX57hvAJG2mKVhzCQIAKgTbGPqGTj3eNjycuOGMttKCY+oITSVXlqWTbYKnKK5cQCrwmsl
 suIloCaV6ifreiTM8ZMJyywT4NerrEhazhE41oAZ65KOhzo0LxRwjKqoHFwy56Mp9e/w8AYj5Nh
 6RZWA6xIBdSSqDZAFim0WObXCb9M80ldW2ZwCuxjTXMVUn/tmwPfBMLkB9qVhPbZx33R6kMuTKw
 /5gadRRIGtxjKTHgC5Vdb2AOUB9wJqx8GTpn7sCiyFG4AEWFdbwxuMF6irgP2T/oETrm8ep82ZL
 cM6Zoa53n2yZ3YmInKKSTGD6Iq2zkvnRzsS+uatFoPVVRHa6r0EGNA2aMUUSjcAU13tHM0fLlrw
 a/9iWX78ecKAxN9195WNuxh1WJBoixXTBNKsvzq6uWM+MjVK1d0DHmq+vLwjimN0gMyVrR0PJpb
 voKhSZbtpcSZEOFmg1A==
X-Proofpoint-GUID: fCANdF9OYoZVsjJ2C_X-dD0aBL68w7IP
X-Proofpoint-ORIG-GUID: fCANdF9OYoZVsjJ2C_X-dD0aBL68w7IP
X-Authority-Analysis: v=2.4 cv=IumL47/g c=1 sm=1 tr=0 ts=6ae4c8ff cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=00npYO4BYMms5FIVoiYA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2NiBTYWx0ZWRfX3cmWRvqR3CLc
 4BYXei3RLvMPDOVlZCEsdv0KqqdUF2Z/sfQshfvyWpNBwTUsgGuKvL/gP7oFt3aXna9PvatVxyv
 PuxmH3dUU9t7y6cldsm8Qpkihpl9OLI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300066
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


On 10/29/2026 12:44 PM, Marco Liebel wrote:
> Emit basic HLX arithmetic, logical, min, max, and abs operations with
> gvec instead of helpers.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/genptr.c      |   1 +
>   target/hexagon/hex_common.py | 149 +++++++++++++++++++++++++----------
>   2 files changed, 107 insertions(+), 43 deletions(-)

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index fd3f6a1edf..808caf4289 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -18,6 +18,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
>   #include "cpu.h"
> +#include "hw/hexagon/hexagon_hlx.h"
>   #include "internal.h"
>   #include "tcg/tcg-op.h"
>   #include "tcg/tcg-op-gvec.h"
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index 091c1bf7ef..a6ac84d792 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -321,6 +321,63 @@ def skip_qemu_helper(tag):
>       "LX_assign_w":   {"op": "mov",          "vece": "MO_64",
>                         "size": "2 * sizeof(HLXVector)"},
>       "LX_combine_w":  {"op": "combine_pair", "vece": "MO_64"},
> +    "LX_add_h_sat":  {"op": "gvec3_fn", "fn": "ssadd",
> +                      "vece": "MO_16"},
> +    "LX_add_uh_sat": {"op": "gvec3_fn", "fn": "usadd",
> +                      "vece": "MO_16"},
> +    "LX_sub_h_sat":  {"op": "gvec3_fn", "fn": "sssub",
> +                      "vece": "MO_16"},
> +    "LX_sub_uh_sat": {"op": "gvec3_fn", "fn": "ussub",
> +                      "vece": "MO_16"},
> +    # Word forms use helpers because their halfwords are split.
> +    "LX_add_hp_sat": {"op": "gvec3_fn", "fn": "ssadd",
> +                      "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
> +    "LX_add_uhp_sat":{"op": "gvec3_fn", "fn": "usadd",
> +                      "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
> +    "LX_sub_hp_sat": {"op": "gvec3_fn", "fn": "sssub",
> +                      "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
> +    "LX_sub_uhp_sat":{"op": "gvec3_fn", "fn": "ussub",
> +                      "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
> +    "LX_and":        {"op": "gvec3_fn",     "fn": "and",
> +                      "vece": "MO_64"},
> +    "LX_or":         {"op": "gvec3_fn",     "fn": "or",
> +                      "vece": "MO_64"},
> +    "LX_xor":        {"op": "gvec3_fn",     "fn": "xor",
> +                      "vece": "MO_64"},
> +    "LX_andn":       {"op": "gvec3_fn",     "fn": "andc",
> +                      "vece": "MO_64"},
> +    "LX_orn":        {"op": "gvec3_fn",     "fn": "orc",
> +                      "vece": "MO_64"},
> +    "LX_and_w":      {"op": "gvec3_fn",     "fn": "and",
> +                      "vece": "MO_64", "size": "2 * sizeof(HLXVector)"},
> +    "LX_or_w":       {"op": "gvec3_fn",     "fn": "or",
> +                      "vece": "MO_64", "size": "2 * sizeof(HLXVector)"},
> +    "LX_xor_w":      {"op": "gvec3_fn",     "fn": "xor",
> +                      "vece": "MO_64", "size": "2 * sizeof(HLXVector)"},
> +    "LX_andn_w":     {"op": "gvec3_fn",     "fn": "andc",
> +                      "vece": "MO_64", "size": "2 * sizeof(HLXVector)"},
> +    "LX_orn_w":      {"op": "gvec3_fn",     "fn": "orc",
> +                      "vece": "MO_64", "size": "2 * sizeof(HLXVector)"},
> +    "LX_min_h":      {"op": "gvec3_fn", "fn": "smin",
> +                      "vece": "MO_16"},
> +    "LX_max_h":      {"op": "gvec3_fn", "fn": "smax",
> +                      "vece": "MO_16"},
> +    "LX_min_uh":     {"op": "gvec3_fn", "fn": "umin",
> +                      "vece": "MO_16"},
> +    "LX_max_uh":     {"op": "gvec3_fn", "fn": "umax",
> +                      "vece": "MO_16"},
> +    "LX_min_hp":     {"op": "gvec3_fn", "fn": "smin",
> +                      "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
> +    "LX_max_hp":     {"op": "gvec3_fn", "fn": "smax",
> +                      "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
> +    "LX_min_uhp":    {"op": "gvec3_fn", "fn": "umin",
> +                      "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
> +    "LX_max_uhp":    {"op": "gvec3_fn", "fn": "umax",
> +                      "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
> +    "LX_abs_uh":     {"op": "gvec2_fn", "fn": "abs",
> +                      "vece": "MO_16"},
> +    "LX_abs_uhp":    {"op": "gvec2_fn", "fn": "abs",
> +                      "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
>   }
>   
>   def is_hlx_inline_tag(tag):
> @@ -449,27 +506,29 @@ def reg(i):
>                                      {b}_base, {b}_off,
>                                      {oprsz}, {maxsz}, &{table});
>               """))
> -    elif op == "gvec3_arr":
> -        # Like gvec3, but table is a GVecGen3[4] indexed by vece.
> +    elif op == "gvec3_fn":
>           d, a, b = reg(0), reg(1), reg(2)
> -        table = desc["table"]
> +        fn = desc["fn"]
>           if pair_dst:
>               f.write(code_fmt(f"""\
> -                tcg_gen_gvec_3_var({d}_base, {d}_off,
> -                                   {a}_base, {a}_off,
> -                                   {b}_base, {b}_off,
> -                                   {oprsz}, {maxsz}, &{table}[{vece}]);
> -                tcg_gen_gvec_3_var({d}_base, {d}_off + sizeof(HLXVector),
> -                                   {a}_base, {a}_off + sizeof(HLXVector),
> -                                   {b}_base, {b}_off + sizeof(HLXVector),
> -                                   {oprsz}, {maxsz}, &{table}[{vece}]);
> +                tcg_gen_gvec_{fn}_var({vece},
> +                                      {d}_base, {d}_off,
> +                                      {a}_base, {a}_off,
> +                                      {b}_base, {b}_off,
> +                                      {oprsz}, {maxsz});
> +                tcg_gen_gvec_{fn}_var({vece},
> +                                      {d}_base, {d}_off + sizeof(HLXVector),
> +                                      {a}_base, {a}_off + sizeof(HLXVector),
> +                                      {b}_base, {b}_off + sizeof(HLXVector),
> +                                      {oprsz}, {maxsz});
>               """))
>           else:
>               f.write(code_fmt(f"""\
> -                tcg_gen_gvec_3_var({d}_base, {d}_off,
> -                                   {a}_base, {a}_off,
> -                                   {b}_base, {b}_off,
> -                                   {oprsz}, {maxsz}, &{table}[{vece}]);
> +                tcg_gen_gvec_{fn}_var({vece},
> +                                      {d}_base, {d}_off,
> +                                      {a}_base, {a}_off,
> +                                      {b}_base, {b}_off,
> +                                      {oprsz}, {maxsz});
>               """))
>       elif op == "combine_pair":
>           dd, u, v = reg(0), reg(1), reg(2)
> @@ -486,7 +545,7 @@ def reg(i):
>                                    {single}, {single});
>           """))
>       elif op == "gvec2":
> -        # Two-operand op: dest and one source.  table is a const GVecGen2.
> +        # Two-operand op: dest and one source. table is a const GVecGen2.
>           d, a = reg(0), reg(1)
>           table = desc["table"]
>           if pair_dst:
> @@ -504,46 +563,50 @@ def reg(i):
>                                      {a}_base, {a}_off,
>                                      {oprsz}, {maxsz}, &{table});
>               """))
> -    elif op == "gvec2_arr":
> -        # Like gvec2, but table is a GVecGen2[4] indexed by vece.
> +    elif op == "gvec2_fn":
>           d, a = reg(0), reg(1)
> -        table = desc["table"]
> +        fn = desc["fn"]
>           if pair_dst:
>               f.write(code_fmt(f"""\
> -                tcg_gen_gvec_2_var({d}_base, {d}_off,
> -                                   {a}_base, {a}_off,
> -                                   {oprsz}, {maxsz}, &{table}[{vece}]);
> -                tcg_gen_gvec_2_var({d}_base, {d}_off + sizeof(HLXVector),
> -                                   {a}_base, {a}_off + sizeof(HLXVector),
> -                                   {oprsz}, {maxsz}, &{table}[{vece}]);
> +                tcg_gen_gvec_{fn}_var({vece},
> +                                      {d}_base, {d}_off,
> +                                      {a}_base, {a}_off,
> +                                      {oprsz}, {maxsz});
> +                tcg_gen_gvec_{fn}_var({vece},
> +                                      {d}_base, {d}_off + sizeof(HLXVector),
> +                                      {a}_base, {a}_off + sizeof(HLXVector),
> +                                      {oprsz}, {maxsz});
>               """))
>           else:
>               f.write(code_fmt(f"""\
> -                tcg_gen_gvec_2_var({d}_base, {d}_off,
> -                                   {a}_base, {a}_off,
> -                                   {oprsz}, {maxsz}, &{table}[{vece}]);
> +                tcg_gen_gvec_{fn}_var({vece},
> +                                      {d}_base, {d}_off,
> +                                      {a}_base, {a}_off,
> +                                      {oprsz}, {maxsz});
>               """))
> -    elif op == "cmp_gt":
> -        # a > b is done as b < a, with the less-than descriptor in "table"
> +    elif op == "cmp":
>           d, a, b = reg(0), reg(1), reg(2)
> -        table = desc["table"]
> +        cond = desc["cond"]
>           if pair_dst:
>               f.write(code_fmt(f"""\
> -                tcg_gen_gvec_3_var({d}_base, {d}_off,
> -                                   {b}_base, {b}_off,
> -                                   {a}_base, {a}_off,
> -                                   {oprsz}, {maxsz}, &{table});
> -                tcg_gen_gvec_3_var({d}_base, {d}_off + sizeof(HLXVector),
> -                                   {b}_base, {b}_off + sizeof(HLXVector),
> -                                   {a}_base, {a}_off + sizeof(HLXVector),
> -                                   {oprsz}, {maxsz}, &{table});
> +                tcg_gen_gvec_cmp_var({cond}, {vece},
> +                                     {d}_base, {d}_off,
> +                                     {a}_base, {a}_off,
> +                                     {b}_base, {b}_off,
> +                                     {oprsz}, {maxsz});
> +                tcg_gen_gvec_cmp_var({cond}, {vece},
> +                                     {d}_base, {d}_off + sizeof(HLXVector),
> +                                     {a}_base, {a}_off + sizeof(HLXVector),
> +                                     {b}_base, {b}_off + sizeof(HLXVector),
> +                                     {oprsz}, {maxsz});
>               """))
>           else:
>               f.write(code_fmt(f"""\
> -                tcg_gen_gvec_3_var({d}_base, {d}_off,
> -                                   {b}_base, {b}_off,
> -                                   {a}_base, {a}_off,
> -                                   {oprsz}, {maxsz}, &{table});
> +                tcg_gen_gvec_cmp_var({cond}, {vece},
> +                                     {d}_base, {d}_off,
> +                                     {a}_base, {a}_off,
> +                                     {b}_base, {b}_off,
> +                                     {oprsz}, {maxsz});
>               """))
>       elif op == "conv_h_to_w_pair":
>           # lo = the source; hi = zeros (zxt) or the source >> 15 (sxt)

