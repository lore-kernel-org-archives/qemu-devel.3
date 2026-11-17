Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F89606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 02:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R1wpwT3C;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HX7XJByF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT8hZ-0001xW-Ej; Mon, 16 Nov 2026 21:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xT8hX-0001xB-Bd
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 21:13:39 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xT8hV-0003fP-BQ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 21:13:39 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGNQ8pf1096230
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 02:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0iw8TyN65VcKBhnZLeFKeEnFCCq5AytZR5L76Srhh0E=; b=R1wpwT3CuJbZd5gN
 pPPymv16J7vimcyAH5cuT5gFun5Zei82S9DBCYBuszJKaOeR6YEQ7b8L+9JjE05w
 xUbNMf2NArgi4EWs0itFbrXWOnCO4p/kPo/CbFL0EMUSH21yFcpIhlm7EqFiZSYL
 MQUZ703wjFVhiwzyZcAHkz3FCa3gQ1nTOypdHgU5u1dgAoaAZIDzrAF+e1uZvBQZ
 a1ReR+OVpDdxBGL+z8UqW1RWx/wZOUiDYGI7pJlsvVwtsi42IYVSovHknTN2dW5n
 1Rj34t2sO7JASo3p5v1we4N8bDEvNwyvLv8hG2s6LpwWIDn+UOm15KgjvYD25V4T
 duSHdA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyy6gkkf9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 02:13:35 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8b4cc42ac12so32152327b3.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 18:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794881615; x=1795486415; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0iw8TyN65VcKBhnZLeFKeEnFCCq5AytZR5L76Srhh0E=;
 b=HX7XJByFYmGt34my3ALJne1gu82acBWV8XBzbW/WlX8v5z69vlE5oy6fIBNgzHKl71
 ECTH/+RAtxniz4KQYgGWC4TJmzJ/W+LJW3I6UJ0sonDAc3TRVRi5ZH+WATYAP8t8cXRv
 lCKZmLrbketw2Pcf23g3MNCtdeIlYMx/OxthQPAAVfvY/TJq7EXKleqPHrdDg2b2D8kB
 v5Tnf5+f6aCEAY4mvdqa4b52WFEOJH5nlv3f90DRPM93bNVg7AGZw7LFzE2EZlmLCPsb
 ZCb+FprIfdzeWkVa28SqCsu8tc/A+vSiFhkVzFNIJ4NJk0rdXIwTnF3YW9l9X1XfJGgs
 QTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794881615; x=1795486415;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0iw8TyN65VcKBhnZLeFKeEnFCCq5AytZR5L76Srhh0E=;
 b=Tmo9vQP7jfOkRZ/A6TndQ+dlBgtYODaMRaodhbFWm+Ez5DCM7UcXxsoPF5R8QACjrA
 bKIXF0uNLzF1ouMkkrT4wllsLncyw4eiIWgUSGkPAXYZnQTP6CBW6MD9vwmj5p1VmReN
 fL8MuMgc2qHYAstRG0ExJ5KfEzOXy6yWDqVx8YRGQNjsctgOycCInADwbdKp3sKSjFhq
 2Plvgpl/OWzlvmZ+H1PmMszEcqUySYrJjTL4w4ZMnOVUE4CxoYbLgf6G93AKvPeCZLpw
 jbp+IfJOh/Gfx+HCkFgAjVo5UyiUj96YSmg/h3mZYSkgewnjL1Qgh4aSZvE4gLtE+D5S
 wclw==
X-Forwarded-Encrypted: i=1;
 AL+hErE53eUEGeZwt3Bp8SAan1f2Tz+uY3gauaP2waxGKsa3shYuCvGSbSgHfHcpDKWTM5yky14Fb3fp9HRw@nongnu.org
X-Gm-Message-State: APuU4Z9Db9Tp/P8G5Wp79m5xZUVkMEOZ5cIB/8H/Lik0ojMyJ+5sGyEw
 GZF0TSh3F1B+LPrztxlDvciMHq/tEwZeoRJOq+WkjZ7GhJ6WNbmU0+eWVA52ij6fgxN6DtLFuL3
 g/SpDIWx/PJHnV/YCFFKzFQKf+/D92wpZFtxqAGtIoqZl4jLpq18gKsXDHA==
X-Gm-Gg: AZFdTZdW9f4QaneRk1sV4kbZS33hBCal1TKS44iyTfFZlLi15JI07s2gamxgidrSs6K
 iHEt2QCXmoKtJQFSsjDoA1SeLyqkZQzxFo/fDK4SjNCAg3PX5mEg4eYc8HiOQ9i9yPV4t20y2vY
 IhHZbVBUj0DfWX7aKRBpee2wKM4FPeC6XChW+Zh8lVtE5xDJtP9ox6I34VQQClxF9ZfYwBcr0ao
 WIyyvVpj3snhPNcLjAUQwqPJp2e2ASmSHloCbWijUxJfV5EfRkbubiilogOvXvxcct4vLCyPvc6
 4hVfCxwt5g2NfCW/s/cGCSMgyxEm2KrOqBXbfijiScTILhEPurdaaru3/2haPlhc/KtXTWBVU57
 Mx2zudzLAovVTdyxkdekZ8BZ//Tv3pUr+FX/G/x4gnkE/vEHab1q5TBt8ymne7GCKPekeVnQ02I
 ZrbYALD5D9xWAB864f3UbCg94zkojhKfhhylBTTgEKaOsCjh+/Lv3d
X-Received: by 2002:a05:690c:d94:b0:8b0:d785:b850 with SMTP id
 00721157ae682-8b4aa2e15bdmr73607537b3.29.1794881614891; 
 Mon, 16 Nov 2026 18:13:34 -0800 (PST)
X-Received: by 2002:a05:690c:d94:b0:8b0:d785:b850 with SMTP id
 00721157ae682-8b4aa2e15bdmr73607327b3.29.1794881614357; 
 Mon, 16 Nov 2026 18:13:34 -0800 (PST)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4ebc1b53bsm13756677b3.15.2026.11.16.18.13.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 18:13:33 -0800 (PST)
Message-ID: <bac3eba7-ccac-458a-befc-63a7c15fe21d@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 20:13:32 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] target/hexagon: HLX, search for .new values in
 pair high register
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, marco.liebel@oss.qualcomm.com
References: <20261112232032.396-1-anjo@rev.ng>
 <20261112232032.396-3-anjo@rev.ng>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261112232032.396-3-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAwOCBTYWx0ZWRfX6cNHOO7LWU4A
 dxG0UlvN8df6KbQJ2watkJ/9TNik1lsUxbHEuvm0npAhQzqPYwAxidc9HT1bvxJJgJ/kOHruwY2
 z2orquxfmN05hmL6CANmuxsMhjUMJdLsZwzdCvoD4urWRW+bGqNIfCFDMqVyXIS14n9uchsPwnp
 G68vYFA5+kACrwa0AnayF9IsjzzR44wp25j9V9GGrmBt8+3uOnLvOD2ktyND/718IdwgaYTqTGp
 iwilLWgAG/cfyyLO9l48SJAIF+tZLgcsOT8U6LZDwMEiJOLuSxsMV1RUa6/zuyefDzONn2juf6x
 UW7GHyLZ/eEzKg0QjCAmNnOEhNgoF/i8IM0pED39ftm9doxWwIDk3qX33oYPsOkh87qo/U6FIHW
 d1oWj8FxFU0KBkaB4KG2n7iXF8GWH/7pKkzp9y0EM5LfED9iTEZlWmyS/QvMIA8aV98vQqnZCwF
 M/UnamOfwQcVpUhK6+Q==
X-Proofpoint-GUID: _EWju4_UpU__hNvm5SlX8gde2e3Zb04J
X-Proofpoint-ORIG-GUID: _EWju4_UpU__hNvm5SlX8gde2e3Zb04J
X-Authority-Analysis: v=2.4 cv=D/DSufRj c=1 sm=1 tr=0 ts=6afbb84f cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=RZq-YDj2851ijcVIyn8A:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAwOCBTYWx0ZWRfXyuRd9LsIBRy0
 s3bKp1Bj2BQVkhKgAw9xlHPgI9R+0x+oOkN6Zkf7rq8f5xcrShdo4XZlaVeDdmf78M2bMSvj7s1
 ArXyDF/YVhWkdgqdW1/WGSXluGsfvGo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170008
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


On 11/12/2026 5:20 PM, Anton Johansson wrote:
> Otherwise, the following packet
>
>    {
>        L7:6 = combine(L0, L2)
>        mem(R7) = L7.new
>    }
>
> results in mem(R7) being zero-initialized, compared to L6.new which
> would correctly write the lower bytes of the pair.
>
> Compared to scalar and HVX .new instructions, HLX encodes the register
> number rather than an offset to the producing instruction + an odd/even
> bit.  In order to find possible producers which write to register pairs
> without the odd/even bit, a Instruction::has_pair_dest field is added
> for scalar, HVX, and HLX registers.
>
> Lastly, we move the new-regno patching in decode_fill_newvalue_regno()
> to the non-HLX scalar path to avoid overwriting the consumer L7 with the
> base register L6 of the producer destination L7:6.  This is safe as the
> patching is only required for replacing the scalar offset+odd/even
> bit with the actual producer.
>
> Fixes: ef81d1b047337e81 ("target/hexagon: decode HLX packets and add load and store")
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hexagon/insn.h               |  1 +
>   target/hexagon/decode.c             | 29 +++++++++++++++++++-----
>   tests/tcg/hexagon/hlx_assign_conv.c | 35 +++++++++++++++++++++++++++++
>   target/hexagon/gen_trans_funcs.py   |  5 +++++
>   target/hexagon/hex_common.py        |  2 ++
>   5 files changed, 66 insertions(+), 6 deletions(-)

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>
> diff --git a/target/hexagon/insn.h b/target/hexagon/insn.h
> index 0dd36d2931..37a3111374 100644
> --- a/target/hexagon/insn.h
> +++ b/target/hexagon/insn.h
> @@ -42,6 +42,7 @@ struct Instruction {
>       int32_t new_read_idx;
>       int32_t dest_idx;
>       bool has_pred_dest;
> +    bool has_pair_dest;
>   
>       bool part1;              /*
>                                 * cmp-jumps are split into two insns.
> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
> index d48630da87..08fa9aee2a 100644
> --- a/target/hexagon/decode.c
> +++ b/target/hexagon/decode.c
> @@ -110,9 +110,25 @@ static int hlx_find_new_value_producer(Packet *packet, int consumer,
>   {
>       for (int i = 0; i < packet->num_insns; i++) {
>           Insn *insn = &packet->insn[i];
> +        uint8_t regno;
>   
> -        if (i != consumer && GET_ATTRIB(insn->opcode, A_HLX) &&
> -            insn->dest_idx != -1 && insn->regno[insn->dest_idx] == lreg) {
> +        /*
> +         * Skip ourselves, instructions without return values, and
> +         * any non-HLX instructions.
> +         */
> +        if (i == consumer || !GET_ATTRIB(insn->opcode, A_HLX) ||
> +            insn->dest_idx == -1) {
> +            continue;
> +        }
> +
> +        regno = insn->regno[insn->dest_idx];
> +
> +        /*
> +         * Compare against the base register number, and against the top
> +         * register for instructions returning pairs.
> +         */
> +        if (regno == lreg ||
> +            (insn->has_pair_dest && regno + 1 == lreg)) {
>               return i;
>           }
>       }
> @@ -172,12 +188,13 @@ decode_fill_newvalue_regno(Packet *packet)
>                   if (def_idx < 0 || packet->insn[def_idx].dest_idx == -1) {
>                       return false;
>                   }
> +
> +                /* Now patch up the consumer with the register number */
> +                dst_idx = packet->insn[def_idx].dest_idx;
> +                packet->insn[i].regno[use_regidx] =
> +                    packet->insn[def_idx].regno[dst_idx];
>               }
>   
> -            /* Now patch up the consumer with the register number */
> -            dst_idx = packet->insn[def_idx].dest_idx;
> -            packet->insn[i].regno[use_regidx] =
> -                packet->insn[def_idx].regno[dst_idx];
>               /*
>                * We need to remember who produces this value to later
>                * check if it was dynamically cancelled
> diff --git a/tests/tcg/hexagon/hlx_assign_conv.c b/tests/tcg/hexagon/hlx_assign_conv.c
> index 8192882b8e..bca902a6e5 100644
> --- a/tests/tcg/hexagon/hlx_assign_conv.c
> +++ b/tests/tcg/hexagon/hlx_assign_conv.c
> @@ -120,6 +120,40 @@ static void test_assign_rw(void)
>       check_wp("LX_assign_rw", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
>   }
>   
> +static void test_combine_assign_hi(void)
> +{
> +    /*
> +     * Tests that a combine operation acts as a producer of a .new value for
> +     * the high vector in a pair.
> +     */
> +    HLX_Vector l_lo;
> +    HLX_Vector l_hi;
> +
> +    fill_w(pw_a_lo, pw_a_hi, VAL_W);
> +
> +    l_lo = Q6_L_tmp_mem_A(pw_a_lo);
> +    l_hi = Q6_L_tmp_mem_A(pw_a_hi);
> +
> +    hlx_put_v(0, l_lo);
> +    hlx_put_v(2, l_hi);
> +    /*
> +     * {
> +     *     L7:6 = combine(L0, L2)
> +     *     mem(R7) = L7.new
> +     * }
> +     */
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xef24602d\n"
> +                 ".word 0xa487c007\n"
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    Q6_mem_Ku16_new_AL(buf_a, hlx_get_v(7));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected[j] = VAL_B;
> +    }
> +    check_h("LX_assign_w (hi only)", buf_a, expected, HLX_HALF_ELEMS);
> +}
> +
>   
>   static void test_combine_w(void)
>   {
> @@ -336,6 +370,7 @@ int main(void)
>       test_assign_s();
>       test_assign_u();
>       test_assign_rw();
> +    test_combine_assign_hi();
>   
>       /* Combine and mux */
>       test_combine_w();
> diff --git a/target/hexagon/gen_trans_funcs.py b/target/hexagon/gen_trans_funcs.py
> index 93125bdfe4..7e65438565 100755
> --- a/target/hexagon/gen_trans_funcs.py
> +++ b/target/hexagon/gen_trans_funcs.py
> @@ -74,6 +74,7 @@ def mark_which_imm_extended(f, tag):
>   ##         insn->new_read_idx = -1;
>   ##         insn->dest_idx = 0;
>   ##         insn->has_pred_dest = false;
> +##         insn->has_pair_dest = false;
>   ##         return true;
>   ##     }
>   ##
> @@ -94,6 +95,7 @@ def gen_trans_funcs(f):
>           dest_idx = -1
>           dest_idx_reg_id = None
>           has_pred_dest = "false"
> +        has_pair_dest = "false"
>           for regno, (reg_type, reg_id, *_) in enumerate(regs):
>               reg = hex_common.get_register(tag, reg_type, reg_id)
>               f.write(code_fmt(f"""\
> @@ -108,6 +110,8 @@ def gen_trans_funcs(f):
>                       dest_idx_reg_id = reg_id
>               if reg_type == "P" and reg.is_written() and not reg.is_read():
>                   has_pred_dest = "true"
> +            if reg.is_written() and reg.is_pair():
> +                has_pair_dest = "true"
>   
>           if len(imms) != 0:
>               mark_which_imm_extended(f, tag)
> @@ -132,6 +136,7 @@ def gen_trans_funcs(f):
>               insn->new_read_idx = {new_read_idx};
>               insn->dest_idx = {dest_idx};
>               insn->has_pred_dest = {has_pred_dest};
> +            insn->has_pair_dest = {has_pair_dest};
>           """))
>           f.write(textwrap.dedent(f"""\
>                   return true;
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index f85f063f52..8d68d8dad9 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -805,6 +805,8 @@ def is_hvx_reg(self):
>           return True
>       def is_hlx_reg(self):
>           return False
> +    def is_pair(self):
> +        return len(self.regid) == 2
>       def hvx_off(self):
>           return f"{self.reg_tcg()}_off"
>       def hvx_base(self):

