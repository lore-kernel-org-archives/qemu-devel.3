Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167F7606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a1aezt+I;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DNILxCTb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJtJR-0007AR-Ue; Thu, 22 Oct 2026 09:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJtJF-00077a-2h
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:58:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJtJC-0006yY-Kg
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:58:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MCNhW0171211
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ivyeBBl3C09azsij2h2ImNWZdlnAai13tiXtJdlBhvI=; b=a1aezt+IGqtEjPY3
 sw+D7xdYoJbokllsND32VQWMdQ5faoVVkwu8+0ECytbkCCKyoxkfElgzXH8sBb5P
 9OKUoX1KqDW9xBztOph2gKgxe8AU3zw6yQH+4vi/8YpfTuyw7fXI00gJ9sKq0djs
 rD86LWJwngzSB5H46oHATqLGBinh9lSaDv9KayrjM4s9oJxTsfVMKdcZoHyatMIM
 flB837a+gpihnRzKTdgl+S2Ea8ktaGvKnl5YpUyR6J/DBLknl+DzqSspzTunmi2k
 Gp7a+C3+fEYYpp/qyNILOD8ZPeWqqpzBVAn/6LYkFpXFnHQTdfdNXkG3LihgDPjk
 kskRxg==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93cbyp2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:58:16 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b150adb80cso4923917b3.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 06:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792677496; x=1793282296; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ivyeBBl3C09azsij2h2ImNWZdlnAai13tiXtJdlBhvI=;
 b=DNILxCTbHL52pBOpa13I9DeaN8OYrIspiR+To5UjWk0uoz5LIuSNdFg3qJWg+b1DfR
 PSNes9iIG5VxCE1h90LGGVL7mmmhBzGyNNHYYFs3HtLNOcR5r9pSCr1eeTDd6MKu2Dc8
 CmhEvVZbXAk0vspO0GKdt01MD2sWoPrRF70lvPKY8Vnq1wnVq5oMCLTLINa4+xMAA4BP
 eAkjE+Lo047KnL/fqOtShbgEgCA/cbTnuoNZCIJBDyaZzb4suATHMs851Gq1T0/Tzbha
 geMowgZ4haYpO9hij6LLEqrlVVQAuuq408CRhlL7kOuGglacRmKFMPsDGTMHOJy6Pkku
 r5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792677496; x=1793282296;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ivyeBBl3C09azsij2h2ImNWZdlnAai13tiXtJdlBhvI=;
 b=S61g1EMOa9grq0REn7KKaHW+GzT3b49DsH7kfIWd27VcZWSnSO5xUYh15tBS6Af8X7
 Ay9yrb8tVOXoiw0BkH9n139E1FOapnxpSL/X7GcyXEC/ZIALkmcHiejy8GfbDJtZ5JGF
 efQ/oJjRG7S1D9GGix2linEryBWJP8Cv/ARwRGhxcbd9jrrjo0busnHjgH3EZ0wsqAxA
 9Nfb2Zu5rrqEB/yhQoX8Q1p0no1Z7wPtqcCyE1dn2kVrALWS5724pjSr09jD5Nbpqp48
 A2OJexy6XY9McWfaNQfB64vn9vYvZD2XB9sk4T+ZeBZ6tdR/ps3zxYr9OT4LXdEhO5OH
 w0Jw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6JVvK+XLP1IwWSCI/KKd3vvp/uw0vCczZDHM11ZUTUHUgURS1DkUVFLivmyVnUIaP3SzM9bPCqkR7@nongnu.org
X-Gm-Message-State: AFq9FYLiLjHMCOp9qmhbIk9m8F//XC+GeODUNaa/v4Tj/5TD9X85ryGG
 4Mhm+FmY3QB4mL1AyK2cMTIlBYu/wE7Tw/WqASoeguKn/Kwg98gStIt1ZCnqzhJo1ROFXjBhuyr
 Ke4JKwzzpAVTvIbqNjFJ2t5S040nZAiz6eNbpScEOuDPE/Ascs/nOVGtcqg==
X-Gm-Gg: AYBFou04euXvwTN/fzVJmvqb9V52X6TO4zpFTudFXMRNfs/T7hk4juedQ9RDCLEVMT3
 t1pSNUOgPHApmbEMYTr3yeSZaaO7cDe6hAzwyTVdeVhACGSoUPt1a0TZpjIaQqi93ImqxjTwM8H
 MGt+EWZuT59lVRBkHshphx2efz6iMkEUY/vPOW7aJcd6STGjn9NScrZSndabbjFApO3iUiyZwGD
 kpwutURJNlyVfGA4xMAKqhN8xEJ4s+q4SPYv7jNlRTSmBtabnMIHL12sMWIErxwFRjtkE/tae/C
 TO1IT5t7vTdBGpMT/gjEPFCzNMl4BWbXxL/W+Ox9EFyDiFTP+/Z1lqX/WApsrKb0xSsjUhT2qZP
 M2SLJI7InuCzILCgkzwDdPEfbpyO+5JZ5phKN/Gl27XPOa3+LxdTlT4xyQ5sLa0Cf
X-Received: by 2002:a05:690c:e005:10b0:8b0:e13c:2856 with SMTP id
 00721157ae682-8b14550fdb3mr12099807b3.5.1792677496118; 
 Thu, 22 Oct 2026 06:58:16 -0700 (PDT)
X-Received: by 2002:a05:690c:e005:10b0:8b0:e13c:2856 with SMTP id
 00721157ae682-8b14550fdb3mr12099747b3.5.1792677495727; 
 Thu, 22 Oct 2026 06:58:15 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b13018e0d1sm26035787b3.41.2026.10.22.06.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 06:58:15 -0700 (PDT)
Message-ID: <05bcee71-1241-40e9-9af9-ddd1524b3de5@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 08:58:13 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/hexagon: Convert to translate_for_debug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Song Gao <17746591750@163.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261022125858.310252-1-peter.maydell@linaro.org>
 <20261022125858.310252-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261022125858.310252-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1NSBTYWx0ZWRfX5aZl32+I3jAA
 qVij2mby2j1eCvn5r414qZDf6Nk90fXA8Hgtpm0/dEAqCFvEjqnmnRYgwh26zRoHaAmiubOw3JI
 tDVcXGWFpQw1rUd4UlEAQaPMaivQtYk=
X-Authority-Analysis: v=2.4 cv=ReAFmFtv c=1 sm=1 tr=0 ts=6ada1678 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=9Ev9HhkF4gHvCLiwTCEA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: wEx5o306so7Lw-zGxzbz-DoxfahzDtD0
X-Proofpoint-ORIG-GUID: wEx5o306so7Lw-zGxzbz-DoxfahzDtD0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1NSBTYWx0ZWRfXyzt8ZrqIAzBA
 sdVlFMlWzaSDfXUg205QO5kh+8V8ehtdQI7Q77u4/1QWvSMWz6GmPl8ht0dm7aicUcztczklG/t
 5hV7gtNr8Ydb8LpS5Mlq0uaT8TGezv9FIKdLK8bm5snU7zSEhSyIWoSicLQ+OwDxwGRlA3EuhuP
 97goonQKd8IKR2n5YlUx4Po/m2ktY8XDTpv2ChvcDu5ESlHcdt+xDhnqwbuvphC6ltzR3owWZDJ
 H5f4ZEtWGvSfq4+JLDybcsRY/dD1QmHLEVnvZwlNComotY7GxwPaOCJwKE7JEgLxiyXPO1cdGBl
 fZ8kmow01sy4rjos4e3lxKJQeO6qkU1T1l+PQMNcLqoeVr3pK7Kyk1kcQLwnEYc+0erRoOQMou1
 gEjcsJDO9v19eRE+X/qv/b6m3KJc+siX+YYW5XoH0gwgpUmiZlrKsnY1MgdyeO0meKg/YJtMShX
 uhvBec3+7JC3/wgRAuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220055
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 10/22/2026 7:58 AM, Peter Maydell wrote:
> Convert hexagon to providing the translate_for_debug method rather
> than the deprecated get_phys_addr_debug method.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   target/hexagon/cpu.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index f20d6de6f63..5e99e84b075 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -612,7 +612,8 @@ static void find_qemu_subpage(vaddr *addr, hwaddr *phys, uint64_t page_size)
>       *phys += offset;
>   }
>   
> -static hwaddr hexagon_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
> +static bool hexagon_cpu_translate_for_debug(CPUState *cs, vaddr addr,
> +                                            TranslateForDebugResult *result)
>   {
>       CPUHexagonState *env = cpu_env(cs);
>       hwaddr phys_addr;
> @@ -626,10 +627,16 @@ static hwaddr hexagon_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
>           vaddr page_offset = addr & (TARGET_PAGE_SIZE - 1);
>           find_qemu_subpage(&addr, &phys_addr, page_size);
>           phys_addr += hexagon_cpu_mmu_enabled(env) ? page_offset : 0;
> -        return phys_addr;
> +
> +        *result = (TranslateForDebugResult) {
> +            .physaddr = phys_addr,
> +            .lg_page_size = TARGET_PAGE_BITS,
> +            .attrs.debug = 1,
> +        };
> +        return true;
>       }
>   
> -    return -1;
> +    return false;
>   }
>   
>   
> @@ -755,7 +762,7 @@ static bool hexagon_tlb_fill(CPUState *cs, vaddr address, int size,
>   
>   static const struct SysemuCPUOps hexagon_sysemu_ops = {
>       .has_work = hexagon_cpu_has_work,
> -    .get_phys_addr_debug = hexagon_cpu_get_phys_addr_debug,
> +    .translate_for_debug = hexagon_cpu_translate_for_debug,
>   };
>   
>   static bool hexagon_cpu_exec_interrupt(CPUState *cs, int interrupt_request)

