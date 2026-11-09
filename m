Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AC2606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YDXFi50x;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=etiNJ+aB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQml-0006YP-Q0; Mon, 09 Nov 2026 09:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQQmf-0006Xg-2p
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:55:46 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQQma-00074s-ND
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:55:44 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DFGeK971398
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 14:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0+IFDq/PmlEGOuxxFyftK8bgVsCMdJc+vZ+YTw+yiJA=; b=YDXFi50xJjuN/49E
 FtYSnNrqSkXLXuJpg6bWCFlNSQJmUpl0u8Dpw+1PbL0W99ax59Y2DycIUHvz2Oao
 itu0PUZecPHJD6/he8d6RWQSRUu6j7Bp635uF4C8fGcBXCEQ+hgxjzhwVaxrHRZk
 n7anq5DjgD7+ue3yujwi+Lqo7ugpvl2qePhWYHTIEik9iYLjP41fpOr/3ZdK2sH1
 XdvHVko2fbr4KD+7p/CE00DWtA+KydC2tn8HMou1x7svfAMeWPn1/0BGGXdcmS+p
 Xmxs2Y5sqEDD0CJzPhed4IFyexsbpNR6gEy8tLF+V1YY9vDxt3NIEUTES7w4xp6U
 D77cew==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4htuqm3n9n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:55:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5339739b343so20758421cf.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 06:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794236137; x=1794840937; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0+IFDq/PmlEGOuxxFyftK8bgVsCMdJc+vZ+YTw+yiJA=;
 b=etiNJ+aB/JeoXZMtXZ65nwLXvP8W/3AxyxD+sRTPVdjnfaDEcWEq11icC2Zr7PP+yC
 DSJE8dH6UtgXF3LhE1LyOLRFUlNO55Hchx26EOV7V+7i0iMwo0I7smyJFblZZQ0zKYos
 VqgFlcm5pX976hwWBi1JruTMpSAoO1nY3/DZAYHYSPGHj41OZfvT6HZwOVGMWNpytGR8
 fQKunwpv2/CkNzLuF5Y0R/SjwErf/T1L5kJfdad1E/0eJsyk+m3y8QD9XqVBHLc9Aa/i
 QTJPG/9alBi89gZWSddUgPObjt+97+fmRRFeNE+TVpyyYLey5f9DzD3uEpPL4CUM2SBP
 rWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794236137; x=1794840937;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0+IFDq/PmlEGOuxxFyftK8bgVsCMdJc+vZ+YTw+yiJA=;
 b=F1ZIvtC4rWkl6ipuzEDRAFY+C9RZ2YMlp+BMCzHLvb/TZ1Y2+0z3VFkXVnh7cE3uds
 7XZ84iwwMOMOnv519RUJbd1n4iEmbVDc6BDEtvTN+bLqM+6yeNOKE6jKMP0MTaK6x5QC
 rEuyT3PFnNIsJgWHylblpV6pbXni6v/BYYHGeL9hkoP4F4Nk/Tdb1lALLMSUCODIJQmC
 LmhVRIZYyIcEqPCBnUWYGvFJiiLUfsxmD7Q0xT4K2LvolLJj1585gMFcO/04d6lJ6Cs/
 0Z9w5ku680x+qEIwJgJHEq5PkoQ8viJ3QfPcyqJmYLC9r6a/p/c8727wJgBQG3Tvjrmq
 OwzA==
X-Forwarded-Encrypted: i=1;
 AL+hErHI0mgJuusUM21UPDlRVhXuAI4az/EUkMN91QxVC5be39k03C6lblPDvmfN2pMsaGqMlZK6U+A0lipd@nongnu.org
X-Gm-Message-State: APuU4Z/0nc3GZb5+pgpioEQheWhfQVY6WsMrMdyVd/L1WvPFyveIQJEs
 440XkbNhH9LxiS2+hOfTPQtpvktoaYT6QbIslXSQedI9Q+U3Liz93ctoWXEEEvZpQ00+BA+Tu27
 TyhuWSn/Fg5rP0EttF/qf6M0DTy3uU4mRkPNOBdLWSoJo3A0xVTPAtrOUxQ==
X-Gm-Gg: AYBFou3R7NgnJxveaFQm4y2//iIDCjzVyfd8fAkrYkfcoNUFDpJWFkb+G5nBGy87oZC
 dKoyF87B2kr0v0S3lgyOhY4oVqJUzsQM5N4k82ycYvr3c8uPpjQriRC2pAN/a4OSkXHoYJdZTxK
 So+PTdfvaRDtv4iCkuM9e75wSO4kjV6ixpEsIc7RP7ExhA2pQxeo2Bfk7Z/8biImUt+sLr2A0tC
 lLswknCn35Y6p/+oVFuvf/ugODwOuSYsZcHRtxUxkHsgTJB5xTR22GzOTLUxcHEmA4ymMQSMFbY
 YHT95zaYN752HptblzVFes5ofo53POo+bptfO/adkiCie3jArYuD8SZ/s6/bg/F27I4S7O9xScD
 swNRZoKyYWuOePqeQwbJD2czUP5SsgNhbD/D9w5qzBJ94rpzDhzczWYVHseARsDKMzUKd97hKNS
 +PZQYoOZj0
X-Received: by 2002:a05:622a:138c:b0:535:a5f9:752c with SMTP id
 d75a77b69052e-552a5d63060mr64973531cf.75.1794236136477; 
 Mon, 09 Nov 2026 06:55:36 -0800 (PST)
X-Received: by 2002:a05:622a:138c:b0:535:a5f9:752c with SMTP id
 d75a77b69052e-552a5d63060mr64973051cf.75.1794236135918; 
 Mon, 09 Nov 2026 06:55:35 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-552638912a0sm42210861cf.9.2026.11.09.06.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 06:55:35 -0800 (PST)
Message-ID: <6f668743-7f33-4bf4-ba08-dbdba650de8f@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 11:55:32 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv: write mstatus.GVA on every trap into
 M-mode
To: tewaro <tewaro@theorem.dev>, qemu-devel@nongnu.org
Cc: disclosures@theorem.dev, tewaro <tewaro@tewaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <cover.1793677945.git.tewaro@theorem.dev>
 <9c108816bf40bd4023f23ecc32527a7fc92c1747.1793677944.git.tewaro@theorem.dev>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9c108816bf40bd4023f23ecc32527a7fc92c1747.1793677944.git.tewaro@theorem.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1OSBTYWx0ZWRfXx1vmwopOzqd1
 LQYu1WcdWFS8AcMGVDYnjer6YjnLRrjG9XNu7KZIlcx7dOJdCZpchTPB9/mYW51SEpz28ebe+fs
 IhOl7Xoc1EsIxt3DLyxIEVBStjvYMMg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1OSBTYWx0ZWRfX3JVhnLhPKr0S
 +5IX1Hm/rV4ppJmMW/0OFuYzTxWRrkrIkZzGu5tiajVrWyMs8RivrkAKjuE645OZNbYCD9TTB4F
 2LA40sXjzY7QlYZGYhj9V0YFVtTrwH1ofgz33z6KzOyW87a1AvKnt2uBIebLbLUfKDL//kWptjo
 gpVu+PFcvW0yHiPBUsAtBRcWT2ErxkL9MCcgCDSuqzkA9sQB6vMPDHWpQ5mBp2DW4d/1WnsCzhq
 nJN6jFjNJT/xsktpOMDm/83379v6pQBEYqrVZflSfXXBOr7efSoUzeQOsSgqMLskSNV/01JbAz5
 70L9yu6eOgQOwnUwbrdss3s/v+zeobrZq5c1TrcgjX2DuPFfVRUyw/ERAlxKwVLkqt5vF5rGIM3
 95fbdC59/rcOGQtmU4GXDZteUct6OWMUw67D9Z++dD6YaQTN/4ec7xBn1MX2GLMRvo58gZsIg5r
 egv+oNN977adrKOs2og==
X-Authority-Analysis: v=2.4 cv=JLquIMKb c=1 sm=1 tr=0 ts=6af1dee9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=xvfqbYfxAAAA:20 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=rNDt8dwyJFNyhbOj3TAA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: mQT0AuvBXB8pKLFoWue6lP8GRJrECBC4
X-Proofpoint-ORIG-GUID: mQT0AuvBXB8pKLFoWue6lP8GRJrECBC4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090059
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/3/2026 4:42 AM, tewaro wrote:
> On every trap into M-mode, mstatus.GVA should be set to 1 if mtval
> holds a guest virtual address and to 0 otherwise [1].
> riscv_cpu_do_interrupt() only ever sets it, and only when V = 1 and
> tval is nonzero. That has two effects:
> 
> - GVA is never cleared. After one guest-page fault, every later trap
>    into M-mode, including an ecall, reports GVA = 1.
> - GVA stays 0 when HLV, HLVX or HSV faults, because those run with
>    V = 0. The spec names this case ("SPV=0 but GVA=1").
> 
> The HS-mode path already computes write_gva for hstatus.GVA. Use it
> for mstatus.GVA too.
> 
> [1] Privileged ISA v1.12, 8.2.1
> https://github.com/riscv/riscv-isa-manual/releases/tag/Priv-v1.12
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4594
> Signed-off-by: tewaro <tewaro@theorem.dev>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/cpu_helper.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
> index 063525cfc5..55b370294a 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -2416,9 +2416,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>               }
>               env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
>                                        env->virt_enabled);
> -            if (env->virt_enabled && tval) {
> -                env->mstatus = set_field(env->mstatus, MSTATUS_GVA, 1);
> -            }
> +            env->mstatus = set_field(env->mstatus, MSTATUS_GVA, write_gva);
>   
>               mtval2 = env->guest_phys_fault_addr;
>   


