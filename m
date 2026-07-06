Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D1AC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgmdg-0000i0-M6; Mon, 06 Jul 2026 12:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgmdO-0000Ze-9g
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:57:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgmdK-0003he-P8
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:57:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FFB9t900866
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 16:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Gj6HlwvS9PoUx1quZztZM7xjiFVGtjWQVlaSsiyyZDM=; b=N/y5HcWT83lm6bqb
 SeABu6JUHeYZUac625k0vJdeSjlu62sw4tvHg7Y3rXlwu6SzbfYJzuZZnfcQQt1s
 br0Nr3dMFCX+B1glWIpVUq0Gb4RO8thoWO9P3yGvsCoFyIcIyeGpiGjrlg3yoXGU
 v0WmdTs6V9Ibl3PeqMTrNQ8yvibmGi/i3EAtn2a86NQTfhMPDkVIQi6Ba20QF1C8
 2hqjPh4oESwJ9IdEbeiS2sC1lIe4dBlETL+uUrZSw2seLhZ1ErIR7KUZjhUImq5t
 FOXvGXDptVRrBFdajFlgf9pW2aRG+GApp+meHAwoCh9jDARP0A3B6MLRzWeVQ3qq
 fF2qcw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7jkep-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 16:57:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e695a3b28so1647585a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 09:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783357044; x=1783961844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gj6HlwvS9PoUx1quZztZM7xjiFVGtjWQVlaSsiyyZDM=;
 b=AA2xwWU33KQLmo2q0HYMmhlxtrJTJYMZGkUJzN5olnAMoCyJe4Wc5F0SuYNXLySUIQ
 l+fBWKYAHIGfCb8/6giApOjDGU0pT1TpFb2P0nrOwd8sSwaRPm+SoWO3OnlHM++qPAWt
 cBIskaV5Ptk+No4+dVeiPFjnJlDkv+dlKeU+UR+PEhPyLhGvYR/Y2Oa4TjPLL+07RXMD
 RXSCNc/QoJErKG3wLzhHry8/a2b8yIAWB7fXVy/RfuKRFJKnRrntkIBcv6f23UctK99i
 jdAi9uw/h+8zCgeEjaFcbeDJyZUZ+q5EONvlCj2sRQV1ME2SFgcnVr/W5K1N82AGWCPR
 JTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783357044; x=1783961844;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gj6HlwvS9PoUx1quZztZM7xjiFVGtjWQVlaSsiyyZDM=;
 b=p9SXocTOki8Ye/cN2L96HexxBW+34PNNgMZcUeFJe/4KWDgN65P9bYpCmTau9PdtIO
 q/Cyp9bAh1BwUCD8LGvnM+GXOhXsui3aJlFz6e56HrrOpcDkmhIX5a8OrxzshZfRI80Z
 UmPj/vhA5Io0EFrip2XL535x0SY8ZltzWzN4yiOT2fmd9FaklHBA1dSYMtU9TqKnG9R+
 If/WhyFgZaZPXles/RFSSi4ekrJKWDa51/VVqloNyiKHtERXplkq1XOtnH6ockoPu0An
 o+Rgkd1jSBu9P0csAAvRYuivW0+bkYO6FF38guBXc+KftnbE8jTOLeyEunTz2Up7tOkz
 JT9A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpaFbmeqeKRIUL9uz9/fsnDwdiqdxmyDdXyEPCDY+TUSXjZ3plaSQ2BRqNuj5WJg1bgECF8NoVOX39r@nongnu.org
X-Gm-Message-State: AOJu0YyIVWpe7F0chdKBMjTFLLlhdUQo8XaTlkQU42RkapJybvmd9LcA
 UIiMKj5otF908urTaqXEcmegAJv11zAqy37PX35CgP2m+ra91LVvEU3SNPGkBNVtAAItQVLeh3i
 OvCWXzlmvHZoM74BOyB+S26ag1slGFAn83O6sOJfuoqwUMBfUAQvTYv4pkg==
X-Gm-Gg: AfdE7clqQjDgOojrwJ9apf9U7zeYXJLkdWFsVxrIQ2zmh50Dft2boBGAWzXjCsAOwkJ
 7eN1V7QX8hwo+xRnBOuAjn7xiW9NLHxutA/hRNROvKTiVdhBtGK3a63+KyUMqY+/vhL8GnuIQ4r
 eBc32p2l0EjKCDo3qKROH6EBeVflVeq0Xhov0sIaryUBgLn+R1eQr45TxRtW4OgtzZzb8vfykIG
 1mh7o+H25oslQfLrlBJT6HfrcsFWJBAJU86g9qNFoTxVpJRfRkz6m/iOC9iFFOeuYbGWE2zY5xm
 /mcl8SVn6GXAKa5zpVFl9t9OSjdJGLOiWnd72FrXs62BQIhoS4KyBx8FYTmROkTWf6cXhmo9B0h
 cN/HkSV5tywEFeSdn5FMGh/v3xSHZXDYx+gz0X82A3ARaP55QdjwBsATGgNEF3g==
X-Received: by 2002:a05:620a:371a:b0:90f:786c:4a82 with SMTP id
 af79cd13be357-92e8b5a8d5bmr2200674185a.39.1783357044035; 
 Mon, 06 Jul 2026 09:57:24 -0700 (PDT)
X-Received: by 2002:a05:620a:371a:b0:90f:786c:4a82 with SMTP id
 af79cd13be357-92e8b5a8d5bmr2200669885a.39.1783357043322; 
 Mon, 06 Jul 2026 09:57:23 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e785sm25955462f8f.8.2026.07.06.09.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 09:57:22 -0700 (PDT)
Message-ID: <346b848d-465b-4560-9615-bd0575967b29@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 18:57:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 12/21] target/mips: add Octeon HSH COP2 helpers
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
 <20260608-mips-octeon-missing-insns-v2-v16-12-daef7a0d8b04@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260608-mips-octeon-missing-insns-v2-v16-12-daef7a0d8b04@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfXxEYEF83wvhY/
 wCuHvDYNekaLvrCsK9HIcf4Gp1IZSPQkiWeBAtMzikIF7PXbrdM3sGpz4sxE+bAF668w7YN1Tnx
 bQ9VMTYgd7GJW2IeSUnQ/uk+VHhMIiHvZhbr8bDUEg0x9EgEw6W5N5cYQl/ZvejVpmepOGKeh6b
 bXcizHFSfFmWKrPl1/Ca4RcZu7uAVY4nzfKhYQpVMSXKf8K1gvPe+SjO2FkEAFSo4znN0USS+eC
 pIpfBjDCs79oiv1VgcV7tTfDCo/MTA1h/F1YzGV9vwCjcG6mReSS22G/q9Ke04A6Cv2UGuVCXQL
 eFM4EcqRiMt/GVdcJi/HlLKjo/ejRPTw7itfS27m63Jh0SK//fsejf4wuqA+ojPY7O0eZgaygGq
 P98/J5benkuZFCtvfZ94bCPsVhyPBoR6FWsVbBZ9v58TZ3Dk3O4AEvEcgVAyBfHFC5M3RKQVIKq
 oowINnGCFMatFzE8bNw==
X-Proofpoint-ORIG-GUID: gCByLiCAxpCRwcEUz3N2XaKaWunqFI4O
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfX2SQIq71q4tfx
 nJzmgLKWc2he7cp0TK0YQmI/3nS8J+/d2fgHCxNfIjvTfvU42huErro3dFhcizs2PE3pSF92Glv
 lIAbxZVtpri7D1Yj54r5eW8iWwpThX4=
X-Proofpoint-GUID: gCByLiCAxpCRwcEUz3N2XaKaWunqFI4O
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4bde74 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=DyQNBBfsy8OHsxO8MXcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060170
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

Hi James,

On 8/6/26 20:59, James Hilliard wrote:
> Add helper support for the Octeon HSH hash selectors. This includes the
> base HSH data/IV windows, MD5, SHA1, SHA256, and SHA512 transform paths,
> and the shared HSH/SHA512 register-window readback and write operations.
> 
> The SHA512 path shares the wide HSH register bank with SHA3, SNOW3G, and
> ZUC. Keep the aliased readback and write paths centralized so selector
> decode can route register accesses through these helpers when side
> effects are required.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v13 -> v14:
>    - Keep HSH narrow DAT/IV state updates in the low 32-bit halves of the
>      architectural HSH register bank so paired selector transfers preserve
>      the wide shared-window state.
> 
> Changes v10 -> v13:
>    - Keep the 0x0057 SDK compatibility path as an explicit STARTSHA1
>      compatibility helper instead of a generic STARTSHA name.
> 
> Changes v9 -> v10:
>    - Remove references to shared-mode tracking; aliased state is kept in the
>      architectural HSH register banks.
> 
> Changes v8 -> v9:
>    - Split HSH/SHA helpers into their own COP2 helper patch.
>    - Replace generic selector dispatch with per-operation HSH helpers.
>    - Keep shared-window readback and write helpers grouped with HSH.
>    - Add matching helper.h declarations with the helper implementation.
> ---
>   target/mips/helper.h            |   5 +
>   target/mips/tcg/octeon_crypto.c | 375 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 380 insertions(+)
> 
> diff --git a/target/mips/helper.h b/target/mips/helper.h
> index 71b7a2b30e..834f2d0769 100644
> --- a/target/mips/helper.h
> +++ b/target/mips/helper.h
> @@ -69,6 +69,11 @@ DEF_HELPER_2(octeon_cp2_mt_des3_dec, void, env, i64)
>   DEF_HELPER_2(octeon_cp2_mt_camellia_fl, void, env, i64)
>   DEF_HELPER_2(octeon_cp2_mt_camellia_flinv, void, env, i64)
>   DEF_HELPER_2(octeon_cp2_mt_camellia_round, void, env, i64)
> +DEF_HELPER_2(octeon_cp2_mt_hsh_startsha1_compat, void, env, i64)
> +DEF_HELPER_2(octeon_cp2_mt_hsh_startmd5, void, env, i64)
> +DEF_HELPER_2(octeon_cp2_mt_hsh_startsha256, void, env, i64)
> +DEF_HELPER_2(octeon_cp2_mt_hsh_startsha, void, env, i64)
> +DEF_HELPER_2(octeon_cp2_mt_hsh_startsha512, void, env, i64)
>   
>   /* microMIPS functions */
>   DEF_HELPER_4(lwm, void, env, tl, tl, i32)
> diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
> index 67959618cc..9523c84667 100644
> --- a/target/mips/tcg/octeon_crypto.c
> +++ b/target/mips/tcg/octeon_crypto.c
> @@ -153,6 +153,348 @@ static void octeon_gfm_mul64_uia2(const uint64_t x[2], const uint64_t y[2],
>       out[1] = revbit64(res);
>   }
>   
> +static inline uint32_t octeon_hsh_get32(const uint64_t *regs,
> +                                        unsigned int index)
> +{
> +    return regs[index];
> +}
> +
> +static inline void octeon_hsh_set32(uint64_t *regs, unsigned int index,
> +                                    uint32_t value)
> +{
> +    regs[index] = (regs[index] & ~(uint64_t)UINT32_MAX) | value;
> +}
> +
> +static inline void octeon_hsh_set_pair(uint64_t *regs, unsigned int index,
> +                                       uint64_t value)
> +{
> +    octeon_hsh_set32(regs, index * 2, value >> 32);
> +    octeon_hsh_set32(regs, index * 2 + 1, value);
> +}
> +
> +static void octeon_md5_transform(MIPSOcteonCryptoState *crypto)
> +{
> +    static const uint32_t k[64] = {
> +        0xd76aa478U, 0xe8c7b756U, 0x242070dbU, 0xc1bdceeeU,
> +        0xf57c0fafU, 0x4787c62aU, 0xa8304613U, 0xfd469501U,
> +        0x698098d8U, 0x8b44f7afU, 0xffff5bb1U, 0x895cd7beU,
> +        0x6b901122U, 0xfd987193U, 0xa679438eU, 0x49b40821U,
> +        0xf61e2562U, 0xc040b340U, 0x265e5a51U, 0xe9b6c7aaU,
> +        0xd62f105dU, 0x02441453U, 0xd8a1e681U, 0xe7d3fbc8U,
> +        0x21e1cde6U, 0xc33707d6U, 0xf4d50d87U, 0x455a14edU,
> +        0xa9e3e905U, 0xfcefa3f8U, 0x676f02d9U, 0x8d2a4c8aU,
> +        0xfffa3942U, 0x8771f681U, 0x6d9d6122U, 0xfde5380cU,
> +        0xa4beea44U, 0x4bdecfa9U, 0xf6bb4b60U, 0xbebfbc70U,
> +        0x289b7ec6U, 0xeaa127faU, 0xd4ef3085U, 0x04881d05U,
> +        0xd9d4d039U, 0xe6db99e5U, 0x1fa27cf8U, 0xc4ac5665U,
> +        0xf4292244U, 0x432aff97U, 0xab9423a7U, 0xfc93a039U,
> +        0x655b59c3U, 0x8f0ccc92U, 0xffeff47dU, 0x85845dd1U,
> +        0x6fa87e4fU, 0xfe2ce6e0U, 0xa3014314U, 0x4e0811a1U,
> +        0xf7537e82U, 0xbd3af235U, 0x2ad7d2bbU, 0xeb86d391U,
> +    };
> +    static const uint8_t s[64] = {
> +        7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22,
> +        5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14, 20,
> +        4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23,
> +        6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21,
> +    };
> +    uint32_t m[16];
> +    uint32_t a, b, c, d;
> +    uint32_t aa, bb, cc, dd;
> +    int i;
> +
> +    for (i = 0; i < 16; i++) {
> +        m[i] = bswap32(octeon_hsh_get32(crypto->hsh_dat, i));
> +    }
> +
> +    a = bswap32(octeon_hsh_get32(crypto->hsh_iv, 0));
> +    b = bswap32(octeon_hsh_get32(crypto->hsh_iv, 1));
> +    c = bswap32(octeon_hsh_get32(crypto->hsh_iv, 2));
> +    d = bswap32(octeon_hsh_get32(crypto->hsh_iv, 3));

The MD5 algorithm is little-endian, so I think for these we want
cpu_to_le32(), ...

> +    aa = a;
> +    bb = b;
> +    cc = c;
> +    dd = d;
> +
> +    for (i = 0; i < 64; i++) {
> +        uint32_t f, g, tmp;
> +
> +        if (i < 16) {
> +            f = (b & c) | ((~b) & d);
> +            g = i;
> +        } else if (i < 32) {
> +            f = (d & b) | ((~d) & c);
> +            g = (5 * i + 1) & 0xf;
> +        } else if (i < 48) {
> +            f = b ^ c ^ d;
> +            g = (3 * i + 5) & 0xf;
> +        } else {
> +            f = c ^ (b | (~d));
> +            g = (7 * i) & 0xf;
> +        }
> +
> +        tmp = d;
> +        d = c;
> +        c = b;
> +        b = b + rol32(a + f + k[i] + m[g], s[i]);
> +        a = tmp;
> +    }
> +
> +    a += aa;
> +    b += bb;
> +    c += cc;
> +    d += dd;
> +    octeon_hsh_set32(crypto->hsh_iv, 0, bswap32(a));
> +    octeon_hsh_set32(crypto->hsh_iv, 1, bswap32(b));
> +    octeon_hsh_set32(crypto->hsh_iv, 2, bswap32(c));
> +    octeon_hsh_set32(crypto->hsh_iv, 3, bswap32(d));

... and le32_to_cpu() here.

> +}
> +
> +static void octeon_sha1_transform(MIPSOcteonCryptoState *crypto)
> +{
> +    uint32_t w[80];
> +    uint32_t a, b, c, d, e;
> +    uint32_t orig[5];
> +    int i;
> +
> +    for (i = 0; i < 16; i++) {
> +        w[i] = octeon_hsh_get32(crypto->hsh_dat, i);
> +    }
> +    for (i = 16; i < 80; i++) {
> +        w[i] = rol32(w[i - 3] ^ w[i - 8] ^ w[i - 14] ^ w[i - 16], 1);
> +    }
> +
> +    for (i = 0; i < 5; i++) {
> +        orig[i] = octeon_hsh_get32(crypto->hsh_iv, i);
> +    }

SHA is big-endian so we are good, but watch out this CPU could switch
endianness.

Maybe safer to use cpu_to_be32() and be32_to_cpu()?

> +    a = orig[0];
> +    b = orig[1];
> +    c = orig[2];
> +    d = orig[3];
> +    e = orig[4];
> +
> +    for (i = 0; i < 80; i++) {
> +        uint32_t f, k, temp;
> +
> +        if (i < 20) {
> +            f = (b & c) | ((~b) & d);
> +            k = 0x5a827999;
> +        } else if (i < 40) {
> +            f = b ^ c ^ d;
> +            k = 0x6ed9eba1;
> +        } else if (i < 60) {
> +            f = (b & c) | (b & d) | (c & d);
> +            k = 0x8f1bbcdc;
> +        } else {
> +            f = b ^ c ^ d;
> +            k = 0xca62c1d6;
> +        }
> +
> +        temp = rol32(a, 5) + f + e + k + w[i];
> +        e = d;
> +        d = c;
> +        c = rol32(b, 30);
> +        b = a;
> +        a = temp;
> +    }
> +
> +    orig[0] += a;
> +    orig[1] += b;
> +    orig[2] += c;
> +    orig[3] += d;
> +    orig[4] += e;
> +    for (i = 0; i < 5; i++) {
> +        octeon_hsh_set32(crypto->hsh_iv, i, orig[i]);
> +    }
> +}
> +
> +static void octeon_sha256_transform(MIPSOcteonCryptoState *crypto)
> +{

(ditto)

> +}
> +
> +static void octeon_sha512_transform(MIPSOcteonCryptoState *crypto)
> +{

(ditto)

> +}

