Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FDF606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cAX3XJ52;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y/6geetB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVhy-0002Kj-TO; Thu, 29 Oct 2026 15:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMVhx-0002Ka-Er
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:22:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMVhu-00067n-EV
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:22:41 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDWB43234206
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z+3dEQIcnUdRiGJUvbC6z/KGQ29lmyU7AgwsGGEaxPE=; b=cAX3XJ52Ew3CFqH/
 PvxP/7akO/BuRF9ZHngFLGPsiV0OEitE858f6r1XfaKaoO7GZK419mZuOWCdFu5b
 77LoLMLkRQt3cRLrsUtGUUtKKhWzJj2ciZ6QUCUYFiP9OEKB0xXXz/XTyZaVi9pn
 oS7oXb4RIoKBCYgcT+aDHnBlruBnj2A5Mo80/B7tCdjHmusTlhz0h11NzLyOVB7q
 sKTPBUve/19QWspyWS5diNJVXjQPwaY0ZQWqM+r49WRDNhnw7MAugj0ug7rHC62n
 /OHvlkd7xuE9jCDdNZGPDknv3UNUS+fLlNNBckp52fitiCjS0mst5gYbybNAF47Z
 Kt7j9A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b2rvc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:22:33 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c3c370b17so66086eec.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793301748; x=1793906548; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z+3dEQIcnUdRiGJUvbC6z/KGQ29lmyU7AgwsGGEaxPE=;
 b=Y/6geetBD+7jm+Ao/Llqmv+o0cG0nkelFmTmbLsOFy+Co6HzFJzqtyGk2j76iItFKa
 0YImA4NUHA1ZcbkP+8Hv/hpY2tTIn4uZvpy+j2Aj+ku6qd/jEjUzWiSC0COajgIXXdzG
 42+t37+Q8N8WXd9bwFzeIefiquxj/EhQg6ByLxUA/C9euqvu9dT1X/rtsKEs8tNqkFh2
 1Wkb+wjIHbkM1KZ0SzGOYmCn5oP4Mln1xko5OwwWbqiwXhyg1uFhEL2tHgvmSZEZXmfp
 iUoDS1OzydPverbEfBgwUS80PYUBWez1IXknePbImN0t5IjtaJeOBYbdxccLY2mSs0QT
 7qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793301748; x=1793906548;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z+3dEQIcnUdRiGJUvbC6z/KGQ29lmyU7AgwsGGEaxPE=;
 b=ZBZRx0wmx+DNHu27bNZa1w5XM7HkMY1RLlfsOVj5+XvtVTrOXFrEyphGhz9XXLJQmY
 cv0BvoxhT3I5k+d0+n691Mi/mbhy7CvXr2opgMPem/F95mDaJ75vRtxMLCgbpCcDtNK6
 MOMr8ETHYCZysluIPyllFTVu+j4SOgVqWTZQ8DbXYdNPbWqspD2KH2Iu51g3hgAl8WN9
 nn+3u0/t39Yd+wV3pp/TrH5ZPPI/GpYMb17gli4jO+9uf9YgMD1AmRDCSXTx5P99LDc6
 0cv8NmCSSLepIIoLMdkw1aAmW1jdFgs6Z2MwzG6ftH5Izstfkf0Lv1gXUCCgHinusSBW
 X2lg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzd/jaAqKGXr1NJK62OEZ6D2eXaNRcWilPgjfpr1+Ys4g5+gmnSi4yZ41EwljwEF27iPt9u79PIpqLL@nongnu.org
X-Gm-Message-State: AFq9FYIjJBv6Wr0KPLuypSfWIj/IjodsVeJR+ulLBFJS2UglM6kTWdoM
 UXgk21VfYia6YHb9F50X22krTNFM/DyK5QlZ72hQtD+ajyf0xSDDDnrliFAG4VHAuvvwHcmUAnT
 5uISiXofBRrc0L/oWzi4DHGxXtBqo6K3gFhn7zOR3+JJeBAHAE33oVq4R0g==
X-Gm-Gg: AYBFou0CuMuvPqyv8Ogd6RchLYKzwCCI5TXBgWqU1+zGL+A2Wos00BYTRQYqNCnb0Bh
 ce9YTEDkq6QfBWVe+AL/7xJkEX7XlGjgQfhoNN6n9cPwMRyG/GrdoJTC6CoKNORHjpbEtVS3gM4
 NDnPyblgTh1MrQE4XwX88cwnOF2rX5lzsTVreGK2VEg7QhNuZWF40p+8sIKPgv5UTvw+7ngvXi8
 bQoHzJjX+7kSdA38IDZ5NpQkUrAYV4feg57yBjSAihv5xsh3xZlrtGKD+/BQ4jQCU44FOehJiTZ
 fhMZU5QQUxhpGSauIytCsshpXVLsslmbEgm9nZf5D1AvoQV5Bj//iBYO0ABX3yYpv1FYbIT5BQ5
 bnhNXJ2eg97ifWSoLv2oJA6+wwcTauRifJXoL7lHjAB1iIhBSjkJevayGT93EanzeX8Uyh1VOVq
 gZcgn/nHJL4atQWNwYfbBuW/dyL52KGIBjYa0X8UWx68E=
X-Received: by 2002:a05:7023:d04:b0:14f:4b01:40a1 with SMTP id
 a92af1059eb24-1ac4fc00dffmr29459c88.0.1793301747574; 
 Thu, 29 Oct 2026 12:22:27 -0700 (PDT)
X-Received: by 2002:a05:7023:d04:b0:14f:4b01:40a1 with SMTP id
 a92af1059eb24-1ac4fc00dffmr29417c88.0.1793301746674; 
 Thu, 29 Oct 2026 12:22:26 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1845817csm649893c88.5.2026.10.29.12.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 12:22:25 -0700 (PDT)
Message-ID: <13e2766d-cff0-4aca-950d-8f8b182d2b7f@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 11:22:24 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/31] tests/tcg/mips: Group MSA bit-count tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
 <20261029172319.25766-15-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261029172319.25766-15-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3NiBTYWx0ZWRfX+zlClFMzgF7G
 eHmt1eGQqZ1HP7n9UIlB2Ao+AgfIamDZ0eEbEI+axnNoRhsKCA5fLCg+TV9lKvekMvX1kw2A1U5
 yf/KnZarbQHjvb4wu9mDIEsZ/cDN6ks=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3NiBTYWx0ZWRfXw3v3SFT+ok0e
 UcoQc5bbtx7ZJcHMfUvfpkIojlE4FCqxbEk6yUc2Fvv2+0JDAfzd1Iik9pYHpMhsGSri9PYH15f
 lvO+JI5UZrygYmK2d/30dbneu9AYzziS0tiqv9b1q4Rqg2dNdRIIRgXa6XEf7Pe3Q7+Z+eh4bjG
 TRW2JUM3wyWpfMti+I11p+YMU8aFEoCYtAVDpVUb6A51typ9MWJOGU5FlohtH4ZUkWHGJsRi+hW
 tJWfFeWA1x8wIz+LHL3Kdq5PBvHW0cUYnW/0gd+0vjzlAPvqTKoGdxNHkX4sVNZJZdMVUuBb1QJ
 VIUv6b83ffgjqVykmAOVRqUkl7DdNmj4Mkt220mYzglReKw2YCt98ie+0pHus1wocVQEfkQc5H5
 ac6ZwA/ZBvOEjZw8ENDNjUj1wNA3k4sob2j/xVNAEKFaCZ7Kr+kBUGa5L3xELJTDddnZHVRez/z
 UwcyScokpms3Eni2Lrw==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae39cf9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Hz6bjlJzRcTCIs_TmpgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: Uw8M0oW0ehOCJMn6LHw-LefFN-2peCPC
X-Proofpoint-ORIG-GUID: Uw8M0oW0ehOCJMn6LHw-LefFN-2peCPC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290076
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On 10/29/2026 9:22 AM, Philippe Mathieu-Daudé wrote:
> Build the 12 per-opcode bit-count tests as a single executable,
> test_msa_bit_count.c, to reduce the number of test binaries.
> Each opcode reports one TAP line.
> 
> Prefix the per-instruction summary of test_utils_128.h with '# '
> so TAP parsers treat it as a comment.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  tests/tcg/mips/include/test_utils_128.h |   2 +-
>  tests/tcg/mips/test_msa_bit_count.c     | 103 ++++++++++++++++++++++++
>  tests/tcg/mips/meson.build              |  12 ---
>  tests/tcg/mips64/meson.build            |   6 +-
>  tests/tcg/mipsel/meson.build            |   6 +-
>  5 files changed, 114 insertions(+), 15 deletions(-)
>  create mode 100644 tests/tcg/mips/test_msa_bit_count.c
> 
> diff --git a/tests/tcg/mips/include/test_utils_128.h b/tests/tcg/mips/include/test_utils_128.h
> index 0dd38684cf33..9ba877d84b5c 100644
> --- a/tests/tcg/mips/include/test_utils_128.h
> +++ b/tests/tcg/mips/include/test_utils_128.h
> @@ -59,7 +59,7 @@ static inline int32_t check_results_128(const char *isa_ase_name,
>      uint32_t pass_count = 0;
>      uint32_t fail_count = 0;
>  
> -    printf("| %-10s \t| %-20s\t| %-16s \t|",
> +    printf("# %-10s \t| %-20s\t| %-16s \t|",
>             isa_ase_name, group_name, instruction_name);
>      for (i = 0; i < test_count; i++) {
>          if ((b128_result[2 * i] == b128_expect[2 * i]) &&
> diff --git a/tests/tcg/mips/test_msa_bit_count.c b/tests/tcg/mips/test_msa_bit_count.c
> new file mode 100644
> index 000000000000..dacfb619f8fc
> --- /dev/null
> +++ b/tests/tcg/mips/test_msa_bit_count.c
> @@ -0,0 +1,103 @@
> +/*
> + * MIPS MSA tests: Bit Count instructions
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#define main test_msa_nloc_b
> +#include "user/ase/msa/bit-count/test_msa_nloc_b.c"
> +#undef main
> +#undef TEST_COUNT_TOTAL
> +
> +#define main test_msa_nloc_d
> +#include "user/ase/msa/bit-count/test_msa_nloc_d.c"
> +#undef main
> +#undef TEST_COUNT_TOTAL
> +
> +#define main test_msa_nloc_h
> +#include "user/ase/msa/bit-count/test_msa_nloc_h.c"
> +#undef main
> +#undef TEST_COUNT_TOTAL
> +
> +#define main test_msa_nloc_w
> +#include "user/ase/msa/bit-count/test_msa_nloc_w.c"
> +#undef main
> +#undef TEST_COUNT_TOTAL
> +
> +#define main test_msa_nlzc_b
> +#include "user/ase/msa/bit-count/test_msa_nlzc_b.c"
> +#undef main
> +#undef TEST_COUNT_TOTAL
> +
> +#define main test_msa_nlzc_d
> +#include "user/ase/msa/bit-count/test_msa_nlzc_d.c"
> +#undef main
> +#undef TEST_COUNT_TOTAL
> +
> +#define main test_msa_nlzc_h
> +#include "user/ase/msa/bit-count/test_msa_nlzc_h.c"
> +#undef main
> +#undef TEST_COUNT_TOTAL
> +
> +#define main test_msa_nlzc_w
> +#include "user/ase/msa/bit-count/test_msa_nlzc_w.c"
> +#undef main
> +#undef TEST_COUNT_TOTAL
> +
> +#define main test_msa_pcnt_b
> +#include "user/ase/msa/bit-count/test_msa_pcnt_b.c"
> +#undef main
> +#undef TEST_COUNT_TOTAL
> +
> +#define main test_msa_pcnt_d
> +#include "user/ase/msa/bit-count/test_msa_pcnt_d.c"
> +#undef main
> +#undef TEST_COUNT_TOTAL
> +
> +#define main test_msa_pcnt_h
> +#include "user/ase/msa/bit-count/test_msa_pcnt_h.c"
> +#undef main
> +#undef TEST_COUNT_TOTAL
> +
> +#define main test_msa_pcnt_w
> +#include "user/ase/msa/bit-count/test_msa_pcnt_w.c"
> +#undef main
> +#undef TEST_COUNT_TOTAL
> +
> +
> +static const struct {
> +    const char *name;
> +    int32_t (*fn)(void);
> +} msa_tests[] = {
> +    { "nloc.b", test_msa_nloc_b },
> +    { "nloc.d", test_msa_nloc_d },
> +    { "nloc.h", test_msa_nloc_h },
> +    { "nloc.w", test_msa_nloc_w },
> +    { "nlzc.b", test_msa_nlzc_b },
> +    { "nlzc.d", test_msa_nlzc_d },
> +    { "nlzc.h", test_msa_nlzc_h },
> +    { "nlzc.w", test_msa_nlzc_w },
> +    { "pcnt.b", test_msa_pcnt_b },
> +    { "pcnt.d", test_msa_pcnt_d },
> +    { "pcnt.h", test_msa_pcnt_h },
> +    { "pcnt.w", test_msa_pcnt_w },
> +};
> +
> +int main(void)
> +{
> +    int fail = 0;
> +    unsigned i;
> +
> +    printf("TAP version 14\n"
> +           "1..%u\n",
> +           (unsigned)(sizeof(msa_tests) / sizeof(msa_tests[0])));
> +    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
> +        int r = msa_tests[i].fn();
> +
> +        printf("%s %u - MSA %s %s\n", r ? "not ok" : "ok", i + 1,
> +               "Bit Count", msa_tests[i].name);
> +        fail |= r;
> +    }
> +
> +    return fail ? 1 : 0;
> +}
> diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
> index 88d598a4f89b..40984e9b4fcf 100644
> --- a/tests/tcg/mips/meson.build
> +++ b/tests/tcg/mips/meson.build
> @@ -93,18 +93,6 @@ tests_mips_msa = [
>    '../mips/user/ase/msa/int-divide/test_msa_div_u_w.c',
>    '../mips/user/ase/msa/int-divide/test_msa_div_u_h.c',
>    '../mips/user/ase/msa/int-divide/test_msa_div_u_d.c',
> -  '../mips/user/ase/msa/bit-count/test_msa_pcnt_h.c',
> -  '../mips/user/ase/msa/bit-count/test_msa_pcnt_b.c',
> -  '../mips/user/ase/msa/bit-count/test_msa_nloc_h.c',
> -  '../mips/user/ase/msa/bit-count/test_msa_pcnt_w.c',
> -  '../mips/user/ase/msa/bit-count/test_msa_nlzc_h.c',
> -  '../mips/user/ase/msa/bit-count/test_msa_pcnt_d.c',
> -  '../mips/user/ase/msa/bit-count/test_msa_nloc_d.c',
> -  '../mips/user/ase/msa/bit-count/test_msa_nloc_w.c',
> -  '../mips/user/ase/msa/bit-count/test_msa_nloc_b.c',
> -  '../mips/user/ase/msa/bit-count/test_msa_nlzc_d.c',
> -  '../mips/user/ase/msa/bit-count/test_msa_nlzc_w.c',
> -  '../mips/user/ase/msa/bit-count/test_msa_nlzc_b.c',
>    '../mips/user/ase/msa/int-add/test_msa_addv_d.c',
>    '../mips/user/ase/msa/int-add/test_msa_adds_a_h.c',
>    '../mips/user/ase/msa/int-add/test_msa_add_a_h.c',
> diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
> index 894f8e9e23e1..bcc02d955436 100644
> --- a/tests/tcg/mips64/meson.build
> +++ b/tests/tcg/mips64/meson.build
> @@ -39,7 +39,11 @@ foreach src: tests_mips64r6
>    tests += {src: {'cflags': '-march=mips64r6', 'protocol': 'tap'}}
>  endforeach
>  
> -foreach src: tests_mips_msa
> +tests_mips_msa_groups = [
> +  '../mips/test_msa_bit_count.c',
> +]
> +
> +foreach src: tests_mips_msa + tests_mips_msa_groups
>    tests += {
>      src: {
>        'cflags': ['-march=mips64r6', '-mmsa'],
> diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
> index 9e446eed0f6e..8b4e665634ab 100644
> --- a/tests/tcg/mipsel/meson.build
> +++ b/tests/tcg/mipsel/meson.build
> @@ -40,7 +40,11 @@ endif
>  
>  tests = []
>  
> -foreach src: tests_mips_msa
> +tests_mips_msa_groups = [
> +  '../mips/test_msa_bit_count.c',
> +]
> +

For this, and all MSA tests, any reason to duplicate this array between
mips64 and mipsel?

I can hear the "self-contained" meson.build argument, but in this case,
it really feels like duplication.

Regards,
Pierrick

