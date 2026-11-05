Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D0C606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bQGYI4wP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ru0TlVId
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP1ZR-0004e6-Mw; Thu, 05 Nov 2026 12:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xP1ZP-0004d0-Qc
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:48:15 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xP1ZO-0001z8-21
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:48:15 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeMPJ526082
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 17:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rQ5VZOA/Cznakkw2p2PXAqTosUo9OpE4mn0f4M6X7NI=; b=bQGYI4wPun3leaJy
 37gjRoQqIFsB5fS01doBhE/daQ7GlLUv+l3k5zrFdUyA2vkNAd6uPA/GigH+Fchr
 jk1gNO3oBRt/UNPeAjV5SP1Dp34vkRSC3jzGH9epc+1wK691IFWV6StqsuM+ljhG
 YNSUSuQEml2yjy9YXOdSvyE3mVm94akSszmQTUgbOv2fbWqsLXTe8LPMRtb8nib3
 3miI7PHCB1mZJlP0T4jO0dc8C5uqVxH6gZUzlxRTrw3YiYYuYi6aYH0k5l3Wm9wc
 jI4DerSHP7FusZD4FslaYXUeZ5onCdK8mgSi2KTDvtheMi0rE75ZBpeHcscLAmnr
 EfV7cA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrj43kg7n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 17:48:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5339739b343so41566391cf.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 09:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793900890; x=1794505690; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rQ5VZOA/Cznakkw2p2PXAqTosUo9OpE4mn0f4M6X7NI=;
 b=Ru0TlVIdqDDBj0xJMJH7LqRTwD5ngLVTtyvn/Kb1JqKFy7n/LIJZlGgTgt27PgqXSe
 0vFgKq7KVXhwD7ViVvMGvcnvRrLoFy0Qw908D4yWvT0wwjImt8L9XIpmuk7QnW4EQWEs
 qbHvWZa7wzlj5bi2/tm41kfrhIRomtgcpWWReP7P/ZTuTVJSeXux9xLQ5UFpOYZWdhpe
 n9/poiOUt7uajd45WfvdCnrj7MPqD+SyF1lFiAvo/XmdTVHYaqr36GoAsqmxvkGLSYNI
 oDfsy0TtiQbyGyXOkpqQXtzIESJjoxrIaookGz9EPYmTNBU8cYNebJHt1oQv9HVj8ojS
 wzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793900890; x=1794505690;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rQ5VZOA/Cznakkw2p2PXAqTosUo9OpE4mn0f4M6X7NI=;
 b=sajJ9x2TojDLgkMjdZoytDfGZoA0V12M21r2Fe8z5bdBXqm7k6tT4Mt7BqxlawvJFS
 sUoy1e+aJxeNWNCQuB1MeJ5WfPeguOBUtEC7g29g8raBbON1PwklIKBD/STHMBQ+lh4u
 up29vNRvuT0BWFKyW1tjtEiLU+VDekQvGs+ngtstv9tHLLlLShXuKhdAi3Hh03zkign6
 SQNl1J5H2uxPr861BUPlQoTmtGJ/uHo5kfbE5LscDkvcl3RejSQVyP0lsO6hLtBvA9qX
 E9AmFGhHoD7fOmbaMLviGuv9of8oOFq+NrXYEft4aUqYyf5d7HMBGxlcri1GEtrexhmi
 Ya3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwW+anwHCTDTwSIWzt/AHBMA/xOThuNFynNvnig96QvUV9AtMkyfq7CfguGi1yy+PtPSwxAQFQCAdnF@nongnu.org
X-Gm-Message-State: APuU4Z/OJFCZiu+DLpS9QgQFkYuLQa2BMW7UloT9Hl4kjYWpdVbG8J0K
 C5bvjbk1cEkN3/cSq+SlNhL5pdTB3gifjhhDCXF69VJNjstcHl087QtGN52Sw2fHLNEM7rjez2A
 sTp3F1I62MuUrsZiZ/7fh2jZ7wJMHkBC85UK6+RzoNZ1ojWuqZYlPhNsBug==
X-Gm-Gg: AYBFou31TY9AKW3D1qWABr1eqyKQBb9lQl4QlxdhAdCUkszAyG2vT1rmzON38EM4p+j
 SmgRZ0a1xNb4WsQ+S+FEQFxeGhBQavVwV7uQQwIHZeMukemxTrCa3wkwLW01hxagMKV891Cpj0b
 Cn3/xng0wnzEo1pST0eLA8ycVHdJcYcBTIjo0bT/Yojf79jsOt1J4Nw00JHbbL0Xye1uGWutW7B
 U96tJt+DSAIUSWmmM0VoyIa1Q3hgNUfXn/WZl8QKUH2T6Sl6l9pJN6I3DjcWEO8cglCeGZXGWo6
 u8x08YctbR2j4uuTwHeuDmXdTvYysvXtQCjWGFxB1ruUyHahxS1uMgwWJcYtZgMK2JNNN60cJZP
 vfX7VfOyaKEA2qsa1klwXMheGRDOHUpV0B4pZIbcplKv4UqRjksq+JFiQpSG/o+iFj0iWLU2wHk
 F3pMr5LZRwr+hgEvuRiQ+R8KYGVDH6yZoMdig0
X-Received: by 2002:a05:622a:4d8f:b0:532:9ef1:729e with SMTP id
 d75a77b69052e-54e102f0ec6mr1109411cf.10.1793900890186; 
 Thu, 05 Nov 2026 09:48:10 -0800 (PST)
X-Received: by 2002:a05:622a:4d8f:b0:532:9ef1:729e with SMTP id
 d75a77b69052e-54e102f0ec6mr1109031cf.10.1793900889472; 
 Thu, 05 Nov 2026 09:48:09 -0800 (PST)
Received: from [10.222.169.242] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ea6900a78sm1255506d6.6.2026.11.05.09.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 09:48:08 -0800 (PST)
Message-ID: <ba086c82-739d-4131-b74e-61bfbc902ef9@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 11:48:04 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] target/hexagon: HLX, preserve scalar :mem_noshuf
 ordering
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, marco.liebel@oss.qualcomm.com
References: <20261105114633.597-1-anjo@rev.ng>
 <20261105114633.597-2-anjo@rev.ng>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261105114633.597-2-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: NxSOENLnjYOYCXvt0wK1SzOs18mEo4YQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MCBTYWx0ZWRfXzFbYPJUpjzSo
 mWQHF9gjIN1Mh6t/azqoNMyiWCelsuHGQlfq7p5DfYr9OscWctNKBFuqFQYkksitUbcyrql6YZP
 ItUi2ccp251YlYApTo08hdOdBAqc9f6VwlYyULvKzprvzD2QSUe4NvQdYd+4Lkc2apAPHyy0UQf
 jHd05ZJp9kO7+0if0gXaDzS0WXF9iIW11Ocb7kc6UUVeMgCgRVKOXfdXs3GxglNhZ76cOfNmeR8
 fhnvtOVOkwd0ZrOK4zh5Rn7MBc0xhxhbBZiOZjABpBeTxNhYu7LVKX3T8y0teMQ/Vis7YjTSSNy
 Js73IqJwTIl5kKP7fq6ZyxeW3a0w0MgH9YKMaHbyiJUBEwnXXrTt6pvjB/Lj0fK1WG5/mgOQksT
 g5eLL6xsgpJpFW13faNzeZEwjxXanuzhNyrWQFThNTqGfQN8YtiC8Kc5KggAG5vdR0WukYpAyzH
 ejtG/yQm1lZ2QDg/KLQ==
X-Proofpoint-GUID: NxSOENLnjYOYCXvt0wK1SzOs18mEo4YQ
X-Authority-Analysis: v=2.4 cv=SZdi5fRu c=1 sm=1 tr=0 ts=6aecc15b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=MJCHFBCSyhHv4GaXv4cA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MCBTYWx0ZWRfX8Oi7rSvt70zO
 claf69VTxJxB85PI8WPpuHnfiHoAUEJNCjwHLXA+TXhP3oCuMdWEDzpyfNsCb+REqZmPObGs8rS
 WTDt+lz1Llczg070nz7uDheFzkRDXxg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050070
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


On 11/5/2026 5:46 AM, Anton Johansson wrote:
> A packet containing HLX instructions currently defers all stores to the
> end of the packet, this breaks scalar :mem_noshuf ordering.  Only
> reorder HLX stores.
>
> Fixes: a6fae6da070d66b9 ("target/hexagon: translate packets with HLX instructions")
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hexagon/translate.c  |  7 ++++---
>   tests/tcg/hexagon/hlx_mem.c | 22 ++++++++++++++++++++++
>   2 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 8ab28d40d3..f9d4c3fb66 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -1525,8 +1525,10 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
>               for (int pass = 0; pass < 3; pass++) {
>                   for (i = 0; i < ctx->pkt.num_insns; i++) {
>                       Insn *insn = &ctx->pkt.insn[i];
> +                    bool hlx = GET_ATTRIB(insn->opcode, A_HLX);
>                       bool tmp = GET_ATTRIB(insn->opcode, A_HLX_TMP);
> -                    bool store = !tmp && GET_ATTRIB(insn->opcode, A_STORE);
> +                    bool store = !tmp && hlx &&
> +                                 GET_ATTRIB(insn->opcode, A_STORE);
>                       if (pass != (tmp ? 0 : store ? 2 : 1)) {
>                           continue;
>                       }
> @@ -1534,8 +1536,7 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
>                       if (insn->hlx_new_zero) {
>                           gen_hlx_new_zero(insn);
>                       }
> -                    if (GET_ATTRIB(insn->opcode, A_HLX) &&
> -                        trace_event_get_state_backends(
> +                    if (hlx && trace_event_get_state_backends(
>                               TRACE_HEXAGON_HLX_OP)) {
>                           gen_helper_hlx_trace_op(tcg_env,
>                               tcg_constant_i32(insn->opcode));
> diff --git a/tests/tcg/hexagon/hlx_mem.c b/tests/tcg/hexagon/hlx_mem.c
> index 643b499fd9..f5af95115a 100644
> --- a/tests/tcg/hexagon/hlx_mem.c
> +++ b/tests/tcg/hexagon/hlx_mem.c
> @@ -229,6 +229,25 @@ static void test_store_fault(void)
>       check_h("LX_S16b_new (fault)", buf_out, expected, HLX_HALF_ELEMS);
>   }
>   
> +static void test_preserve_scalar_noshuf(void)
> +{
> +    uint32_t ret = 0;
> +    uint32_t ptr = 0;
> +    uint32_t val = 0x1234;
> +    asm volatile("{\n"
> +                 ".word 0xe5007822\n"
> +                 "    memw(%1) = %2\n"
> +                 "    %0 = memw(%1)\n"
> +                 "}:mem_noshuf\n"
> +                 : "=r"(ret)
> +                 : "r"(&ptr), "r"(val)

IMO it's a nice-to-have to use named-parameter substitution for inline 
asm instead of enumerated parameters.

If you decide to make that change: great.

Regardless,

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

> +                 : "memory");
> +    if (ret != val) {
> +        printf("FAIL broken scalar :mem_noshuf ordering\n");
> +        err++;
> +    }
> +}
> +
>   int main(void)
>   {
>       init_vtcm();
> @@ -253,6 +272,9 @@ int main(void)
>       /* Store in a faulting packet */
>       test_store_fault();
>   
> +    /* Make sure HLX packets preserve scalar :mem_noshuf ordering */
> +    test_preserve_scalar_noshuf();
> +
>       puts(err ? "FAIL" : "PASS");
>       return err;
>   }

