Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5231A606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 02:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UK0FzWbw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ko8Ona3c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUE6L-00030j-Ac; Thu, 19 Nov 2026 21:11:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUE6I-00030I-My
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 21:11:42 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUE6F-0006G2-W0
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 21:11:42 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK0GDFF3825948
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 02:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vkO78uJhxhozaaQAF8TJe+38XXinIj3O32KgblYmGMw=; b=UK0FzWbwOi+IkZij
 4PgP0urFs6iPk60HOgswhwMcqew2ElvfspWSh8kr3hmyZpGoWSGb4Dre1zZHlY44
 mntMb++dinN8zFZ8Nh8Jt0euEt91eu0e4vR9QwNhX0+YW+FAPUkvNEhxYwE+eXGi
 7iFKXhsX0BVvgB6ALJzabXwEq1CCNn0C0DI3mc22bJ/3iwF1rG2XstfH3pZBEkov
 DCpjQaf2TipJtn7EGSvre0GJnTbg7QvCQO9Trbt40iO86gk4IJspOIWuOdhm//sg
 FbXL+Yw84567gzPAWzUt32Ky3xoo7fwO78cNESbCpHufETG3C0Tz/QeJmmcKHObB
 9PD8SA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1yx6bsxa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 02:11:35 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1383723dfddso484712c88.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 18:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795140695; x=1795745495; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vkO78uJhxhozaaQAF8TJe+38XXinIj3O32KgblYmGMw=;
 b=Ko8Ona3c5HsbUILYhHxlgHpRuaq0df7AKNwnhnEYnKpc65Bgjm6Dg6ffVJQy/uP7Ch
 a4y74IkSDs4bVPZqro/a+KErw1L3EnB4WrXcFTF/6JA5z591dUqtnsRpprfEfneEW95b
 LUXnr7hpOph28+11G7Ts3Tsp/IGjY6DRyNlQ5EeIFghVLT/iRcMVh6ieh6vGS7EI1g5Z
 pqsyyfbJqkwtYY62KgIRx0e8hYzN49R/v5k8o6nExvYO4N3j3SWi/kkD34YxP3DfDVp/
 UHMEXc1ynMKUpQbpT6iDYg9a/7tpMraPn25jdvGg0WR9DPT4SUlP4Zv3qKBtge1A/pcl
 gCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795140695; x=1795745495;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vkO78uJhxhozaaQAF8TJe+38XXinIj3O32KgblYmGMw=;
 b=Y7h1s96y4rPbMq7P27g7gGAcyaGWdwvtitSUe25Ki+2Vk6DKVVusH+Zth+THgerUpO
 ASbgDScs1zI8zQxt0UsJDLL3CtS67zY49bqqrGQM0Zv1JluuW5ElTeD6Ju9ONHa9skdp
 DKh4ZkvJL/lSF7+1LpIPWvXgSzDTe+l9bRWEIw1ezPAJQSu9dHD5XOnm0A5ErR33Xch0
 VFkKNGfUnwEZ+LEA09rTlHrlLv2Fn/kO0OXLSe83m0thEr0HE5KQACN5ok3Mi5bl/qZu
 Xd6ZdPWLu6nNAVbgFGYJoGq6BqhKz4V6QCyYOALS2Qq0zQkPirLut8gbz6ggajhXYqS+
 gO6A==
X-Forwarded-Encrypted: i=1;
 AL+hErE+YCKz0l0WiRpyQNqB6w3HpNYOiiAL10uuF8kMSeVqC5cfRYoMTmAQ1EFMUjd6UZaL66siGGzAwqtc@nongnu.org
X-Gm-Message-State: APuU4Z8k5K+rxrj/Zc3x0mKVc4bzoP5c9/OvKrtorYmvrZibvjNtCOJu
 jAmyfd/cmJLOgRRJphyMvMivrIgF4MYhhEPtqEmTeLb18sXAeAYEsqr3lsgPa92r7jZwsZR99DP
 u0FLagtdqSXDDubtSHuSkediUEp/kdKgP4a8fdAShlpH6ZG/6A4yFVbu19w==
X-Gm-Gg: AYBFou26MqJMReyxs2JU6HGA4iWY1VDNJMx8rE+UNCtEpzOCWWmwOsLSTUrHa+TND1R
 /sBq2veDCUl7ub3gm+MzLFgbtupP8br61i92dUc9gUgTESRiu1W0cX8qRUmXBucNAKea3mQyZKi
 +lkMTz2SVW0UMmihcZdxK+PCC4g+NCMM2t0lVQwiTcOJSCeXa9Ae7pUHYk7drZMve2oJAEpqT50
 Y3F3y7bVA2bT9fUmBPFbWlOUZ7U4i/kXUJ1rx/YknxVtEWohohVvladBn9bZAOCJ5oFwVc9968T
 8ri84/ekurU+El5nB3JItHbG0eXM4MeHuXfKc3fKaGdBQPqAxFwKSmW/g3GUk3W/G/7Z2pf1Yb4
 VElZb6LaYtZ1DaxvxL6mK9ryzjnIGTqaQIP983Oe7u9NriQXQBZAO67uEx12FSvazV7lH5iRkT0
 LmEHZJLuCj948ZzMjFb9yO+UcXjkeBVjng0NHY7gMNGqfFMLutSLDS
X-Received: by 2002:a05:701b:260b:b0:1a4:3169:cb with SMTP id
 a92af1059eb24-1b5568c581amr1638683c88.17.1795140695038; 
 Thu, 19 Nov 2026 18:11:35 -0800 (PST)
X-Received: by 2002:a05:701b:260b:b0:1a4:3169:cb with SMTP id
 a92af1059eb24-1b5568c581amr1638650c88.17.1795140694494; 
 Thu, 19 Nov 2026 18:11:34 -0800 (PST)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b55682d301sm2559454c88.10.2026.11.19.18.11.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 18:11:33 -0800 (PST)
Message-ID: <cbef6aa8-ddd5-47e6-ad35-9cf705484b89@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 20:11:31 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] target/hexagon: preserve inactive BADVA registers
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
 <20261119215853.987158-11-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261119215853.987158-11-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PcEbdwM9sVyyyDss2DmVq06Y43KVR3bz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAwOCBTYWx0ZWRfX15WZyQYCFmJR
 /yaxLyAPbpyQrDs6GAFmguS/RWJOqOSXwUQzj9GQULDquErjNPwyd6sMdjyAE7msEdwD8zC6GNB
 9vmKhrVWPHZzo/d9KlFclxYyaovekZE=
X-Proofpoint-ORIG-GUID: PcEbdwM9sVyyyDss2DmVq06Y43KVR3bz
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6affac57 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=TfPN7POMABDwGo5NU4UA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAwOCBTYWx0ZWRfX67vE+qWNg2TK
 isqZyzw0g6YEvod0SAupEa3xght7xgTju02mx3uS4bdJ9sOMQmgbuHftT7iq/r4QUEzUFGci+zb
 Qu6tsXRqms9ALpMTuoWU28tMPHxySh9fHOj12hwKnvACOk+HaZaJmAS1GObBMoMHrdb5xtMoTAt
 JsWZx5TfYAgNgs8NlN4Ux1W+lC2rPc37NuzBCiAFEHOcwgwPq5pdR7MHX27MDZZcJLbyht2eoAS
 2JeStVIB/auGx1z1ZQKWFLwSxT1IAndrgoHcfUGT9LdWlclqqnZG/p4ttnCscP7n8zEXwuJ9ups
 mQTlH7Bu9Aa77+wcC0v1CRWL/bPkLlzMXR5v2Umc9FvLmODc4iGBcrw/cymojlCvsDmzcu+vczQ
 niXkb/zTtUpbM0YviAWTxQo1UxrhP4WW8ltIdewy+8wd/H2gBUPeXalgfe4Uhbz5wY7RTgZWhHJ
 rynG5bHuULo59abNPXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200008
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


On 11/19/2026 3:58 PM, Marco Liebel wrote:
> Clear the validity bit without overwriting the inactive slot address.
> Fault handlers can retain BADVA values across exceptions.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.c | 6 ------
>   1 file changed, 6 deletions(-)

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 34f80d6671..5ebe67d024 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -752,8 +752,6 @@ static bool hexagon_cpu_translate_for_debug(CPUState *cs, vaddr addr,
>   }
>   
>   
> -#define INVALID_BADVA 0xbadabada
> -
>   static void set_badva_regs(CPUHexagonState *env, uint32_t VA, int slot,
>                              MMUAccessType access_type)
>   {
> @@ -765,8 +763,6 @@ static void set_badva_regs(CPUHexagonState *env, uint32_t VA, int slot,
>               if (valid & (1U << i)) {
>                   env->t_sreg[HEX_SREG_BADVA0 + i] =
>                       i == slot ? VA : env->mem_access_va[i];
> -            } else {
> -                env->t_sreg[HEX_SREG_BADVA0 + i] = INVALID_BADVA;
>               }
>           }
>           SET_SSR_FIELD(env, SSR_V0, valid & 1);
> @@ -777,12 +773,10 @@ static void set_badva_regs(CPUHexagonState *env, uint32_t VA, int slot,
>   
>       if (access_type == MMU_INST_FETCH || slot == 0) {
>           env->t_sreg[HEX_SREG_BADVA0] = VA;
> -        env->t_sreg[HEX_SREG_BADVA1] = INVALID_BADVA;
>           SET_SSR_FIELD(env, SSR_V0, 1);
>           SET_SSR_FIELD(env, SSR_V1, 0);
>           SET_SSR_FIELD(env, SSR_BVS, 0);
>       } else if (slot == 1) {
> -        env->t_sreg[HEX_SREG_BADVA0] = INVALID_BADVA;
>           env->t_sreg[HEX_SREG_BADVA1] = VA;
>           SET_SSR_FIELD(env, SSR_V0, 0);
>           SET_SSR_FIELD(env, SSR_V1, 1);

