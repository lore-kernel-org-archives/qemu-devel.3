Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E09606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PG4pSCdE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eETJ3YW/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFv7-0008Ut-Nq; Tue, 20 Oct 2026 15:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJFv4-0008Uk-Ud
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:54:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJFv2-0001nj-JD
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:54:46 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGtlUX2278776
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oZ3QtbGq5qI5A5QfCUmpUtu7wsDtWLkCXVpaZVKiw7s=; b=PG4pSCdEaxEAhdix
 ZO1PSnE1DGpF44kJxUwFpDUS0QnS16MHiGXnaYwEOkpbpKmMsgiw7co0sqby0+g7
 gQtlvOJunt8n2yEyPFj1wuhBixS2LEkwcao4udrgIbmTMnqNQvQ3z8PXvSGZOeMi
 wOurWPX4xERtE2f6i2E4URHvmEfhVqrZfV3W/RCQNT+2+/OKv1Ruba9wQH9GQ4WI
 /MdMA1V1TTFIkYf99TqzBwXGl2WLYI92LiL4p+fwhRGLJBzQNeH3tF78x+SwXK77
 YdwFRtkl/sWwlXGE2twvUre+yvhOXHBkFs/Gw9xmZy4BQuL3Hmc+pCQm9WaE9X6q
 WKjcLw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7h29x9v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:54:41 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f5844e383so4533285a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792526080; x=1793130880; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oZ3QtbGq5qI5A5QfCUmpUtu7wsDtWLkCXVpaZVKiw7s=;
 b=eETJ3YW/L8iAU3ad62qW0g8by0s65xtIT5S7khaZ9ywp0ofi1UoCymdJrPaywm37P0
 hCPaXEuSqFkWexZdEucGHS0sHsbMgETSpaQ62nwMJJ3pAvYE+N2hYpazcWYwAsHkjuVN
 5tZyJ6uDhg4Veqe5GLiCFuA191C29w80yf4JbF/MRmxKJm6utKmmS/ZkpegybtqFT7zi
 8MAGgT969c679XApRccA+yaw1f588H41r4sK1WDmxusXqEW0XVPw8ggEFPJvVuS5cUTn
 XhfRYtJl/Y+/BtMq1s/XBrYgJDrU49b344MzLqGnRzIGYVdAqGaea++oWCIi/otzB8ZL
 ZcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792526080; x=1793130880;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oZ3QtbGq5qI5A5QfCUmpUtu7wsDtWLkCXVpaZVKiw7s=;
 b=QJk8JOPdvUwtrd5RZyyT4ae8Hv2s1yobWQOySe/ejomT2XJN7bzdkxeOtP9Dfzx7ot
 UDeKL1nviEJeptkhWMsHmqLv+HvIzIbPvTjDQHOfkqi/xe7/2DI83DH/2YkmacSzyleS
 /dVsLzalZTShQFy5F3EhzLuZtMKAdrLsLHQbXtEwvI81FVNCbxHxjq5VvAbQioZ8d5T6
 w1Nktll+hmAjEOUtTtgxQNwfRnYivF3mlq0EIubT3NohuWaphgjRl/Ch/AcEIYIlB5Ne
 Kw1qCzF8ngG0XR1ywAXb1gVTCKaiWmkOVPuIEKG+AfrUAw/b1TOmdo9amOb8IXOLXzJO
 2gWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBydPhkj7bq4bhFWCuhl/suY0KZ9ZYvbThh+4s0AGA9q/E0FvYVxBDZ8C+jwB7Ry7Ho5+jKV+LhN0AXL@nongnu.org
X-Gm-Message-State: AFq9FYLmdQdSFpS4aIr4xsmVDN3d0480QE89R9cnXpla8akl1ccRHyW5
 n8EAwqeSQ35B/w3ggJfSoTSe2YarOHIF1nNGSb4ccaiZIL2yfv9uvYvzL9SxZIsfqEu4AkTreGj
 d0k+mip2eB8GMAZE7neO17xQy2/GePD6+l/SFjRFKsDpc1LFmQAgxivEMmg==
X-Gm-Gg: AYBFou34XDW+JY+ojcTSCGc2zv0XPOXvlONNkPo1NWSEUxpfNnTJGk/MkUpdck/fhYp
 OvQ9kS3dhfOYKrxt4Bw4HzT6kJ67GC1cySuKusmJZeEzs+eO0QeKtfaXbBkMDLIkPD6Yc0lHPm9
 eojkvPq5JUCVLCqjLd10QRW/Q475WMBnlnW/fTAlc6+6RYScrpG4Vulsdony2Pz/llx5IQwHBTZ
 f7G9/qSJF6Se0zAlkyaaYRgZz09j35YYYHSuUIF/RRzKULaCHePkOtHZFLygVX1OHIgKgMu+ozb
 Iop7/Kz2Gl7oTU8PSOnj1ouqMewGnciqdSXhRs+BHYGGd3VPXrO/k134YwAyzZk6ljsfXj7bvmf
 7+rP0dyB9qSBqCCV25GbrzTVycfQdJC1+Yw==
X-Received: by 2002:a05:620a:4712:b0:93e:c5eb:2230 with SMTP id
 af79cd13be357-93f57f1c936mr58994485a.33.1792526080411; 
 Tue, 20 Oct 2026 12:54:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4712:b0:93e:c5eb:2230 with SMTP id
 af79cd13be357-93f57f1c936mr58990985a.33.1792526079846; 
 Tue, 20 Oct 2026 12:54:39 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583e25asm509150f8f.46.2026.10.20.12.54.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:54:38 -0700 (PDT)
Message-ID: <dcdb1452-5196-4edf-aaee-cb032f581526@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 21:54:37 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] target/sparc: Add the SHA instructions
Content-Language: en-US
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261020145530.3385376-1-stian@itx.no>
 <20261020145530.3385376-7-stian@itx.no>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261020145530.3385376-7-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DcmoLKFlrOWFZWcQxpL928ROJN2lFD4-
X-Proofpoint-ORIG-GUID: DcmoLKFlrOWFZWcQxpL928ROJN2lFD4-
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6ad7c701 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=tHkp1mnqzCffSSkAy20A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3OSBTYWx0ZWRfX4omOTuglqjFq
 URrVc2e7gtheZrRol27xfACHCvb5AI1OaFuFkMxzewKMbM70Q3xgqeOPiApAK9MzTA2lX0H0dF6
 Kf6aFny6DlC9X1EnPA7F1NW/b2XjfMw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3OSBTYWx0ZWRfX1QpNUtcmY6Gj
 LcGtXBCwdC2I+9gEdf4zoe4o2YZrM6/xd59lDZKVTWTHy+uxkivlxOtm3YVNSZjA4mTB9oy3ucu
 lKUFzlJC7lqNW++QsHRZMWtfD+2zmPxydlD6xERAuWRsng+sUmFFxeXuUuSIkNzyFYfzuw2FwUH
 lv/DPweMFac2tH3TAy2JJypuM5yWSq7qFEKdcuks/JwDxevGxdRuF0CgW1ICmPDqSgV1/MjHUPP
 gzq+ZcHHsll8HP98iLuA8SS/hOSDjz0bYxleClWwEStLHKYlsTLvXurEiAm+HikTqeHvNmLv829
 T7GIFGx098qzgHkoPG4lXxUbJTAGn8P+sWZGSopyG4xenfSpzk+3SsfNax5jWzD3nYyVXSsNNzD
 AU05ljIgyyPfaUvQvFQSlPzvC4vukCNFqhEiQvq3F1owimhn3spmMefa2d/ZswHxm6Eg+1g+yuk
 /dofvhO7Us7XynVLK0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200079
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

Hi,

On 20/10/26 16:55, Stian Halseth wrote:
> Implement the SHA1, SHA256 and SHA512 instructions according
> to OSA (Oracle SPARC Architecture) 2011 section 7.115,
> using the algorithms defined in FIPS 180-4.
> 
> Read and update the fixed floating-point registers and mark the
> lower FPR bank dirty. Share the SHA-2 Boolean functions between
> the SHA256 and SHA512 helpers.
> 
> Gated behind the crypto CPU feature and disabled for sparc32.
> 
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>   target/sparc/crypto_helper.c | 272 +++++++++++++++++++++++++++++++++++
>   target/sparc/helper.h        |   3 +
>   target/sparc/insns.decode    |   4 +
>   target/sparc/translate.c     |  18 +++
>   4 files changed, 297 insertions(+)

(Bonus for TCG tests, later).

> +/* Compress 16 numeric message words into the supplied SHA-256 state. */
> +static void sha256_compress(uint32_t state[8], const uint32_t block[16])
> +{
> +    uint32_t a = state[0], b = state[1], c = state[2], d = state[3];
> +    uint32_t e = state[4], f = state[5], g = state[6], h = state[7];
> +    uint32_t w[64];
> +
> +    /* Expand the message into the 64-word round schedule. */
> +    memcpy(w, block, 16 * sizeof(*w));
> +    for (int i = 16; i < 64; i++) {
> +        uint32_t x = w[i - 15], y = w[i - 2];
> +        uint32_t s0 = ror32(x, 7) ^ ror32(x, 18) ^ (x >> 3);
> +        uint32_t s1 = ror32(y, 17) ^ ror32(y, 19) ^ (y >> 10);
> +
> +        w[i] = w[i - 16] + s0 + w[i - 7] + s1;
> +    }
> +
> +    /* Perform 64 rounds with arithmetic modulo 2^32. */
> +    for (int i = 0; i < 64; i++) {
> +        uint32_t s0 = ror32(a, 2) ^ ror32(a, 13) ^ ror32(a, 22);
> +        uint32_t s1 = ror32(e, 6) ^ ror32(e, 11) ^ ror32(e, 25);

The explicit narrowing casts below are a bit awkward, let's precise:

        /* sha_ch/sha_maj are shared with SHA-512; narrow to 32 bits. */

> +        uint32_t t1 = h + s1 + (uint32_t)sha_ch(e, f, g) +
> +                      sha256_k[i] + w[i];
> +        uint32_t t2 = s0 + (uint32_t)sha_maj(a, b, c);
> +
> +        h = g;
> +        g = f;
> +        f = e;
> +        e = d + t1;
> +        d = c;
> +        c = b;
> +        b = a;
> +        a = t1 + t2;
> +    }
> +
> +    /* Add the working words to the original state. */
> +    state[0] += a;
> +    state[1] += b;
> +    state[2] += c;
> +    state[3] += d;
> +    state[4] += e;
> +    state[5] += f;
> +    state[6] += g;
> +    state[7] += h;
> +}
> +
> +/* Compress 16 numeric message words into the supplied SHA-512 state. */
> +static void sha512_compress(uint64_t state[8], const uint64_t block[16])
> +{
> +    uint64_t a = state[0], b = state[1], c = state[2], d = state[3];
> +    uint64_t e = state[4], f = state[5], g = state[6], h = state[7];
> +    uint64_t w[80];
> +
> +    /* Expand the message into the 80-word round schedule. */
> +    memcpy(w, block, 16 * sizeof(*w));
> +    for (int i = 16; i < 80; i++) {
> +        uint64_t x = w[i - 15], y = w[i - 2];
> +        uint64_t s0 = ror64(x, 1) ^ ror64(x, 8) ^ (x >> 7);
> +        uint64_t s1 = ror64(y, 19) ^ ror64(y, 61) ^ (y >> 6);
> +
> +        w[i] = w[i - 16] + s0 + w[i - 7] + s1;
> +    }
> +
> +    /* Perform 80 rounds with arithmetic modulo 2^64. */
> +    for (int i = 0; i < 80; i++) {
> +        uint64_t s0 = ror64(a, 28) ^ ror64(a, 34) ^ ror64(a, 39);
> +        uint64_t s1 = ror64(e, 14) ^ ror64(e, 18) ^ ror64(e, 41);
> +        uint64_t t1 = h + s1 + sha_ch(e, f, g) + sha512_k[i] + w[i];
> +        uint64_t t2 = s0 + sha_maj(a, b, c);
> +
> +        h = g;
> +        g = f;
> +        f = e;
> +        e = d + t1;
> +        d = c;
> +        c = b;
> +        b = a;
> +        a = t1 + t2;
> +    }
> +
> +    /* Add the working words to the original state. */
> +    state[0] += a;
> +    state[1] += b;
> +    state[2] += c;
> +    state[3] += d;
> +    state[4] += e;
> +    state[5] += f;
> +    state[6] += g;
> +    state[7] += h;
> +}


> diff --git a/target/sparc/helper.h b/target/sparc/helper.h
> index 1320f5ebba..4be84622c8 100644
> --- a/target/sparc/helper.h
> +++ b/target/sparc/helper.h
> @@ -134,6 +134,9 @@ DEF_HELPER_FLAGS_2(aes_kexpand0, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>   DEF_HELPER_FLAGS_3(aes_kexpand1, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
>   DEF_HELPER_FLAGS_2(aes_kexpand2, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>   DEF_HELPER_FLAGS_2(crc32c, TCG_CALL_NO_RWG_SE, i64, i64, i64)
> +DEF_HELPER_FLAGS_1(sha1, TCG_CALL_NO_RWG, void, env)
> +DEF_HELPER_FLAGS_1(sha256, TCG_CALL_NO_RWG, void, env)
> +DEF_HELPER_FLAGS_1(sha512, TCG_CALL_NO_RWG, void, env)

Hmm you set TCG_CALL_NO_RWG but the helper do read env->fpr[].
While benign in practice because fpr[] aren't tracked as global
TCG regs, the correct declaration is using no flag at all:

DEF_HELPER_1(sha1, void, env)
DEF_HELPER_1(sha256, void, env)
DEF_HELPER_1(sha512, void, env)

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

