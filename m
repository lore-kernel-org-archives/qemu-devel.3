Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03264C5CFC1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvp3u-0007VY-00; Mon, 17 Aug 2026 00:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvp3s-0007VK-1B
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:35:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvp3q-0003dF-AS
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:34:59 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLEa71246919
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RcJIUiotUhyjeXquiDILxPeYnM4NxJWwd22+Z+v4eZM=; b=iH50qVOLz0rr6SGK
 IQ2VmiZMxgnmJjaFA+oB2Vryh0q6kfamiWRP6Cp+jSR6k39bf24ZNDiJIC77qVB4
 bOsQ3knhdVd4io8mKnNHZdMu9uySqfIbe9cKmqGOYvf1hTFDSD4D/2imE2LNomep
 C8lA0+2sdmgsQP61GLzEA9d7eP0eTfSx9dV6CSoF8fwGloJf5BJ5F8qpYKulQM9/
 /4bMGkSwVUkJ0Ls35JIxVLWo8u/6U8g8FXAXFbovp0YNaAdnUCK5oNPADBsi9M5W
 Rub7dsq9aOdyy+jFKpCv+T7cdCViOW4xTB/ZHHN7Q7xiM0uXpUzBDRnTRVKL4TJk
 2VlWaA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghf55k9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:34:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-930a098ea19so392267585a.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 21:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786941296; x=1787546096; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RcJIUiotUhyjeXquiDILxPeYnM4NxJWwd22+Z+v4eZM=;
 b=ZNE9D583FtnhJkRmsUGNfBPOjcVSndKz9TlMv6+ddd+c5YVqayAaIPZZqlTSJmXYVQ
 iPwZNy/O1CJ2EmeId7r5rqLrnb4p8N10WG6FMTkiWqwbxYxZuX3xxAyKD+3YAYQQTs4V
 +xOn5M4i4lKO+7OvkLNk8KAosuWVPyM8CPh7rOWhQQxWHUJ/sNTOljxdFrmwafhMX+JK
 cLYxSK4gpJ38qxL0+Zot3LzMHMMl2b4ZZVNrak99tUCa4+zxLggGxVQjMDU86NAXobWk
 0UUz4e9byELiVDqtGsYZ8te2koiE/U8utUtr5+ybsBwBMgtCy9HbdRERv8ASawHdbImS
 +liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786941296; x=1787546096;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RcJIUiotUhyjeXquiDILxPeYnM4NxJWwd22+Z+v4eZM=;
 b=ABeS7g/Ownrn7p6nMZsfACbnBfkntisUfCejKpvvqTYiKnapc4uc6mFOQcmKpwXrcD
 i8N0LpnjJ5cq93me54Vu85kHcM6sl8eqATVe5Oi+f+jpnMXbv8wBU8TRqs5WvP3oS7cu
 8p9U9DVrT3cVYA34K1C2bsBLRaHtSHLkJDwEOWSwaCgzITs+ajvocwEM9DT4pAvjDTUk
 qEPXEdf5k1Of0NJlCGo0LPZT3xbQVIr/3WZcXM5oDOhJC7Cei5fQfU0PfmWQD34BpT+L
 vxEXuyQKX6g7xirjL9eIHZzDFRCpGbMXdO9ZlLwpdPqXii9zGa3NhQK6TThlSZtJnRjE
 +ojA==
X-Forwarded-Encrypted: i=1;
 AHgh+RplRxCj3SHrptRvEsf/wbAkPLo5P704AJW//dDQOCVEq9Ae1VmlO6KuxTKfPGs+i/PEC3bDhsAxu1Iy@nongnu.org
X-Gm-Message-State: AOJu0Yy6P1dTdU3m5lc1+3GaABxOs1RtJHF1gOhstnVuwaNoX1ePC67g
 90HeE01rY0KpsVFM1Rku70aqSBPZk1HYlo2LPqfSkM1jFfyrY9dc1qBfGVO17Sop6VNLBAcManX
 DrM3snmIT71+U9ytdunnQySJ6ZT13cNGn/quuctPasABGx9a25+k5R1wvbg==
X-Gm-Gg: AR+sD13KO1GYU0pNRUuJz2s9XZH4S2WPJnREUdr2WK24T3VuGYY5IGh5ng8Dfs4yNTS
 Ncjvdr7WFbOVbo5kPDEJgFxgOfAabx1Pz729A/SrmCfMlK8MpDOmqp5hZ/OSCM3gYpjD5FRY7KZ
 kfR6qC64+jzZ+kQFKHCbMnz1pl0D61+Vr0hKG3UP0EUYnfeC8K8n1afwWK8Cy+uf65dKVOUylVZ
 amB/H+gga0S3g6mUpbcCgM0MoJrcHNXrzgSvW4Tw99vPne19D7A9Wpz5S4pq8CxEPm5W126qq1r
 XMeN0eurVu33orkI4e6G37aJ9PQl0MIPm/TcCk9ftMeQomvueFLeRyeHRf8lKmTc1SdAJF94cmB
 HsJubfxw/kN6n20++wCxwaF1CBdPrrcmIx2A=
X-Received: by 2002:a05:620a:5e42:b0:936:cf9c:a9ab with SMTP id
 af79cd13be357-936d22403d4mr1879565485a.21.1786941296186; 
 Sun, 16 Aug 2026 21:34:56 -0700 (PDT)
X-Received: by 2002:a05:620a:5e42:b0:936:cf9c:a9ab with SMTP id
 af79cd13be357-936d22403d4mr1879563485a.21.1786941295720; 
 Sun, 16 Aug 2026 21:34:55 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b81766sm542473f8f.36.2026.08.16.21.34.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 21:34:55 -0700 (PDT)
Message-ID: <5ce3a94f-2706-479e-98df-527e21efea8c@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 06:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] target/hexagon: add COREDUMP semihosting
 operation
Content-Language: en-US
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
 <9ac447d68310b348423a416a7aeb1490e2cccc5d.1784568922.git.matheus.bernardino@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <9ac447d68310b348423a416a7aeb1490e2cccc5d.1784568922.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QsVuG1yd c=1 sm=1 tr=0 ts=6a828f70 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=eGIruXNpstnf9Z8YAtsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: J8UavzRW54Wufg7mDZmP2ugs5WT5vRdh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMSBTYWx0ZWRfXzMFYLMitwTLS
 UJ6OyQ3swHpibdCWjn2R+qD/pmve86yBxkbtTkujDxHlCLimaQSkNlNqP+M/j8srXw342AzbRfx
 YroOjRCK2axtKX5BXpdy+rZKUJrRlPiwqEjbMAcNbtycP8dEDuDkDECinUGdXBrJo+unuVdTtG9
 kbHsl4UtSyo1byvW2ReRci+OypN1IuweyvutFOzGmhDoKjUKOj8pFlvqisEK98FJABaHjKKPIQR
 JngNBA6Ajv2ou7eylrRvEGwj4lnwwde4GyLCJKYlFz6I8hjY1NWY5mW+8c89cyhxeRGuJ689eQF
 nVXPQTvrydDQf7kvZnuZMhKXBuIx5kA+3MCSFYNV9z/58dnED6afVdKGQ66qpMHlgF8/w7ftMqw
 TNS+FeU9N/hW9my1C0XEdQPb+zAnJynEA3sCADQ0AAMvBLueynRa9oq+9PJt3BfQZRWbgb4McEL
 nWGWV5k9UhWceiREHHw==
X-Proofpoint-ORIG-GUID: J8UavzRW54Wufg7mDZmP2ugs5WT5vRdh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMSBTYWx0ZWRfXyg46CerWWFcg
 +LF1mW2qGLSqVbVZYR0fHktULPB+33adNXfTOYfIk5hnu+JFOpT65u/X4/8CbngI2Ts7Aw47irM
 adiDqEw42cQRyqqpe219xbw7wbX2VKc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170031
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 20/7/26 19:41, Matheus Tavares Bernardino wrote:
> Baremetal Hexagon programs invoke SYS_COREDUMP (0xCD)
> through semihosting to dump CPU state on a fatal exception.
> Implement the handler to decode the SSR cause field and
> print the full register file, matching hexagon-sim behavior.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>   target/hexagon/internal.h |   1 +
>   target/hexagon/cpu.c      |   2 +-
>   target/hexagon/hexswi.c   | 143 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 145 insertions(+), 1 deletion(-)


> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index e6b2ac1939d..06c378c5e02 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -232,7 +232,7 @@ void hexagon_debug_qreg(CPUHexagonState *env, int regnum)
>       print_qreg(stdout, env, regnum, false);
>   }
>   
> -static void hexagon_dump(CPUHexagonState *env, FILE *f, int flags)
> +void hexagon_dump(CPUHexagonState *env, FILE *f, int flags)
>   {
>       HexagonCPU *cpu = env_archcpu(env);
>   
> diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
> index 6efc00fedf9..564a11e557a 100644
> --- a/target/hexagon/hexswi.c
> +++ b/target/hexagon/hexswi.c
> @@ -162,6 +162,145 @@ static void common_semi_ftell_cb(CPUState *cs, uint64_t ret, int err)
>       common_semi_cb(cs, ret, err);
>   }
>   
> +static void coredump(CPUHexagonState *env)
> +{
> +    uint32_t ssr = arch_get_system_reg(env, HEX_SREG_SSR);
> +    FILE *f = qemu_log_trylock();
> +
> +    if (!f) {
> +        return;
> +    }
> +
> +    fprintf(f, "CRASH!\n");
> +    fprintf(f, "I think the exception was: ");
> +    switch (GET_SSR_FIELD(SSR_CAUSE, ssr)) {
> +    case 0x43:
> +        fprintf(f, "0x43, NMI");
> +        break;
> +    case 0x42:
> +        fprintf(f, "0x42, Data abort");
> +        break;
> +    case 0x44:
> +        fprintf(f, "0x44, Multi TLB match");
> +        break;
> +    case HEX_CAUSE_BIU_PRECISE:
> +        fprintf(f, "0x%x, Bus Error (Precise BIU error)",
> +                HEX_CAUSE_BIU_PRECISE);
> +        break;
[...]

Should this be moved within hexagon_dump() instead? That information
seems available and useful there.

