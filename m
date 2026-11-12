Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7227606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 05:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lHuN6qjM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GEvislH7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRNBJ-0004M7-5g; Thu, 12 Nov 2026 00:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRNBC-0004LO-Q4
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 00:16:58 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRNBB-0004Uv-6J
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 00:16:58 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2aLob3814540
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 05:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 is+Sy4y/vsJi6CDCmTi2xqmUzzSfXSDYr+Fxqs+VG5s=; b=lHuN6qjMrbUNSghT
 OqltWaze/ZXItP6/R2ueVa82NM3IklDXBYLIDNp+u8iH1KyUBqzN4iNJ2RGLW7Ee
 J97rgHGBLZlxTwzefAcH/2nkPtHd/vxPa/6Xm8drH840oS6JbJ7jzMShhYxddS+w
 5NB8CozhJDPQJU6iHPxLJw1AsajpmM7Y2dd9JrbTe97C0wcmB5ArolUcQseJdbCP
 BRMzNusHPnG0OhcRnqmZhR9oufHEU8Vc26S/fL0wQzbm4Mj1JDAD/JyG6NLbtfK5
 +YE8GPAh/B7im4fvQLbUocnMPJ08FlfFvc4zqIM0dg2Qt2SV9/Ko8M9bqkyiB6DW
 NG3KFg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvvw0j7tu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 05:16:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f33438950so809076885a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 21:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794460614; x=1795065414; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=is+Sy4y/vsJi6CDCmTi2xqmUzzSfXSDYr+Fxqs+VG5s=;
 b=GEvislH7WXvA2g3Ojr9OlH9UXkxMGv/tXwP4OcAEn1NWCGBObAVCAkJzxMeAi2IKXZ
 xauYMRL1vFVu/lxAUBi2gQn/3qLoJeQMkdpT0nALfL1091iXJtHzLn/0uSPQc2GY9gLs
 kI3feRhUx7VIBKqd0b0bXo2XQqh7yyZ9AZiAiTv67felnQIm67kISGke2wmZr8Bfp38B
 X7mZrKESzo1IYCxr18/Uk5y7Nkzs6OIC310gM+DK/WErwxIzz7omNH8efloRS6sRlLi4
 DG/tC9OP8DLUYo5ecarh7KRC3aa7X8QvQ1BjrVHnYSk40DQWH5q0SFPtGMvhbAqGk6P6
 zLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794460614; x=1795065414;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=is+Sy4y/vsJi6CDCmTi2xqmUzzSfXSDYr+Fxqs+VG5s=;
 b=yI+irfz5XWanKolLwSkQ3/XME7tvNFRwLL0cJUkmu1w3+MsbTjCbH6C4PSGuELuGZP
 ZEAnObuucMPTEGu854FYiuHCCpVpv6QDhS9Pqb+3H6atxr68yvGhWCkhFvUgUi1oFYPU
 MwcUwOWrhrfM+PgsPXGIhNMB3RMO3IlkJl49ySA3+o7/T3r7qcCG4mZO/qq9DP3C6AJI
 fw7cI9a25xowAzpeMpUDS8ZT91/45URaYxj5Zc0gXSzW2xKiB3VsHiQ+s6BAVWHIkDjq
 +fZEJaHL76lIBwk+W+QMyzFzG8mx8qttUuSkwZO4KthuCmOn5ZZ/EGwUErkGtyo6562s
 rSIw==
X-Forwarded-Encrypted: i=1;
 AL+hErHWvwBqxcWl5JdwrLGrlYSF8GToJ2BrxKqt19NqhQfGJNM6PS4nK2DzVVoQKZCjjpATN2rV/rFhAXj9@nongnu.org
X-Gm-Message-State: APuU4Z9e4LX4zl9CZXUvPcW2k71jY4Wls+79ReLxBAo1DXiQ5pgcFdx3
 QtiX18N496M/MbS9YXnsXzqdIeJh7C1ZoSxOBzgj8VHJbm/ctGiTHY8anduFuLY8XopDVKpoXlk
 XkJfoesqvgIahyeg+GJ5meLTOQvtY+O2nMid6dMcVp5k51eOkd6OBSnGPCg==
X-Gm-Gg: AYBFou12KkdUi3FwgsBRbxKOaaYHFUY8SKOp2FXVcsininuyumT8GQj7CiUL3Gq7PPL
 Bn/AgbeeEo+nonNuFOf/aKy+u67mhN6p8XmTTB0pvuAjKr5mZhZnD5nSR9QBHBLEImMnlhsj9cI
 sohqAxHYsUmVgY4TEWVlQrMH0hLWvjzBT65nE3Aqdw19yxl7t5wu4ujeoy86q7O2UCNtQlkA1E4
 2duHJmaSqTzZYNG1Yysev0+8W8aHkE2aCK8M0REPCl6e0lrsYbrUW3cO1PExy6SGETiZbWssO/H
 BNSb+rt3qEKM9kSTjIYq4pHIQoFStl3qdfwLVofeP/1tw7+cS0zuSZOT7hSxQg7rT639rUGlfPt
 3QIl/O6ZP94vTIFj/kFSxiO1eFU7djBGJGEP7v4Vo3yHLfcWlEN/n1d/j0YYl1rQ5RwZVyNxWl3
 t17D3vhjc=
X-Received: by 2002:a05:620a:2890:b0:945:f099:8776 with SMTP id
 af79cd13be357-947afcd01e9mr804556785a.4.1794460613901; 
 Wed, 11 Nov 2026 21:16:53 -0800 (PST)
X-Received: by 2002:a05:620a:2890:b0:945:f099:8776 with SMTP id
 af79cd13be357-947afcd01e9mr804554385a.4.1794460613421; 
 Wed, 11 Nov 2026 21:16:53 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49895f4e6ffsm13404622f8f.16.2026.11.11.21.16.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 21:16:52 -0800 (PST)
Message-ID: <3f58ecbf-7774-4447-9ee8-eaa4fb4c26bf@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 06:16:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Qemu-devel] [PULL v5 04/46] target/mips: Prevent switching mode
 related to Config3 ISA bit for nanoMIPS
Content-Language: en-US
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Aleksandar Rikalo <arikalo@gmail.com>,
 Stefan Markovic <smarkovic@wavecomp.com>
References: <1535033941-861-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1535033941-861-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <1535033941-861-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: daDlcmTVooHmtHuZZ3BC233yEhr4g7GK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyMCBTYWx0ZWRfXxjzDo0Ad2Odd
 oP9j0vNng0yHWsNBQpl74FsIroX/muf977GJqT2kCzquyMezaWNGx4tQW2GcjY+cbqlOgACF27V
 qdAwf6ivzsCNcHGw7AwjXOMhDDSpWJnqL4qA07xs77+WG+hCtekyn0elSAC4W2HnaWe3EyRy+gh
 N6MP/yuWIx4XIN0vPY8qckmVSKh8h43I/NnkvPY4iHSrl9ED30JxrATgoK0j7s0/bBUsD14oulZ
 +cNpVdR5qJeNr+0D00/vdecDO/qx9KcJC9gXP1iuC2gVTl2dpm6Naku02CUkv6d9sh/qfEHBFrw
 Lw8DgROiLv9SyCpV6Ma7azjGfkMaeVAjMPo12Ue8OSi9ctmlb2U3UGTmcx4V179cSR09STYOC3+
 rxTcmxfhnW3nesGhOo/12EyyOSsKCKBNLZUhTXNFQvttfAtXTnkLF2BIHwRFSTgqwNXwh34J8E/
 4TqGYTrH9vOCUV99jhQ==
X-Proofpoint-ORIG-GUID: daDlcmTVooHmtHuZZ3BC233yEhr4g7GK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyMCBTYWx0ZWRfXxW811L8wL234
 SEiVSpo4pYYmJK1PDRDoNdTyPXmkCZHAaf1MxJEee1/31RZk2s++7AguaXd/uigrPl9RIiJ7ilR
 tssFU9CxIkRaqFWpWcqXysyLX2HBi0w=
X-Authority-Analysis: v=2.4 cv=ct8OAF4i c=1 sm=1 tr=0 ts=6af54bc6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=FyogFE7hAAAA:8 a=E05dM5_EIKoRRw5XvQYA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=p2WyBLmlf5vdw_nX_QRo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120020
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

(now commit 0bbc0396809f6caaaf96863dafe738e94f9b73ea)

On 23/8/18 16:18, Aleksandar Markovic wrote:
> From: Stefan Markovic <smarkovic@wavecomp.com>
> 
> Only if Config3.ISA is 3 (microMIPS), the mode should be switched in
> cpu_state_reset(). Config3.ISA is 1 for nanoMIPS processors, and no mode
> change should happen.
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   target/mips/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 4f95b9a..7fb322b 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -21841,8 +21841,8 @@ void cpu_state_reset(CPUMIPSState *env)
>           env->CP0_Status |= (1 << CP0St_FR);
>       }
>   
> -    if (env->CP0_Config3 & (1 << CP0C3_ISA)) {
> -        /*  microMIPS on reset when Config3.ISA == {1, 3} */
> +    if (env->CP0_Config3 & (1 << CP0C3_ISA) & (1 << (CP0C3_ISA + 1))) {

(1<<n) & (1<<(n+1)) is always 0, so no CPU ever resets into
microMIPS mode. I suppose you meant:

        if ((env->CP0_Config3 >> CP0C3_ISA) & 0x3) == 3) {

> +        /*  microMIPS on reset when Config3.ISA is 3 */
>           env->hflags |= MIPS_HFLAG_M16;
>       }
>   


