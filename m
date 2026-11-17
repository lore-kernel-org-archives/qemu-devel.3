Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F80606A882
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cikHXG4r;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KJy2zMDb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOFD-0000WT-UA; Tue, 17 Nov 2026 13:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTOF8-0000WK-T8
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:49:24 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTOF7-0008KK-5D
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:49:22 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFR2Vq3503886
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pDUgBlgShF0I9TtdikbppEkeSm9or4nzvVqqdrYec4s=; b=cikHXG4rnYZcd33e
 o/LzM55LsDrGHczS1CRQuR0O+IpFJIaLbH9fMAXwEazwlmC1CqwUl5ec+OAGfr2t
 tDC73qoRiDVfY/sU8eIUaN6GGTnurdKrYDamYgivEr+yCbEBv1Odzyn0oTawBIg6
 8vouLsO1bjTwnHlG3nbglmQaYOxwqZsGArzFEW/YSOrLUf+Ym1jbt70qZq6yoVqV
 yFkbDfmvfopBh5YfjieF5Tzp4Yx8qdibwkRTGnKlxFMLpWtbSyA2tsTrZFwonBRX
 qN7A7Z9k5WA8LyQ84kNzM1nym5yGNvma1gnmEUA7fBWr9wZUZTB97vDwBmfXklDR
 n4n92A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0mv126vs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:49:17 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91eb7d1472cso672166d6.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794941357; x=1795546157; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pDUgBlgShF0I9TtdikbppEkeSm9or4nzvVqqdrYec4s=;
 b=KJy2zMDbrLQHF3qUXJZSjhhma7LctuEGejN/T4u7CfLdgcWX/ghvvM1FRg8AqvPvNw
 PFRmrW8DO6mWr3rz38x/lL/qpJG8cJg+NkRJpzeD6waZKH1X5iM6Rq+5jOhQciU0JJ6Y
 5cJ1kQ2JWWcnxK5IX4Wwlebmv3fdeuh41MVHXXUL+xZf6rnFfhUEaPdowxwu3uW9GbUW
 KTvhb0dhKIx+u8uhinunjeNjitIzMowpb043Zc35tNUdoqhw0PeK7Zz8SZ9EyUHqx/WU
 rEBOdTNPC4/BJUqwpSJEi9XlJOaQ8zhMyJWtcA1MoIfbNvs280LW24xEivVIsx85T31e
 myUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794941357; x=1795546157;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pDUgBlgShF0I9TtdikbppEkeSm9or4nzvVqqdrYec4s=;
 b=J4orS0EflF8yNJXuRaqXc7vsVSWLocIw4Rg1P7m/VEPZnUBFDWk1e0rSizjM2rklsR
 RbzbiFnIpK1pU5o46fzfWJ41DLKNsWmnUF8z0OIh+5igy6aJxNIAdW6XppXykbo80DaK
 891YmzaNA9KrEPUVzBqSljCcv4Ua3k2eVbgFLfzrZiDz6MaESt+J6cRecgSqr0dC0B5v
 9gnDojF9VXG/6dnbJuJIV7hct7IBh4lHMcWfF3rD0zm4o35WkqBFcrACLGK8IpVXkEVZ
 4v230DpseI7YtC3Omn4B/u14s7ww6vsafe4xi8Cy+KQqMMTjfnJf/Y3dhRy1cqxUp+s0
 wdQQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFmUEAgRWbKZyhfighKe1k6AZdxeN+OJaXorSgPGIQVYVcV/Qv/N3pe49Y+N/bICFj8dM23Nag4LiyX@nongnu.org
X-Gm-Message-State: APuU4Z8Fg0wUyFi7F8CWBzWrW4D5opCd08feI1GqvN7+uD57/MV24AYc
 yjgcKNWKmI1z0QabGp9u9KyRZtlUVolgrpXIBEl25PnNB4yhvpt4oB8uJu8koi9D/APDuqxaZjG
 EBnFSBEVaNPrMBJDn8t30TpAGmzLQ8v6EYzLkfV0MvlZPJyPXR/YeND+xrBY4UsHh7A==
X-Gm-Gg: AYBFou0LKhrnKoM/COxbxqmfEw8Ct84M2EbCiLURbN3zvfACq+ItrHE346Hrxo7+HM0
 5Zk6WP2rEKw66KQKzkERtOXBGFpzwNCJs32YLpD4hVhhVN2awjVfDcnShuZgXMf/Q5rX/fPgrSC
 qFYxF7Gilofba//T1++/eiIHxs9QQLK0T2ljagPv6OAIsu9vVJ/Jdk/E70XJoIBl/6u0ZlQxWR8
 +gxixI+FC43zNzAk0nk6x53xc5rjsvjILp0oiDwbHnPaDjpo4D6LrtA7eiyvFMEpeq5WiLak6iD
 KgwP0jxfxZd7a0SAfqc3K8t2d73ty7S6W3hxc4NlAg9Vy8sggoInR1ZzB9852A211IVaSEIAPEa
 Fv9wJARo4ubcMQQYxA/RD3kMnOlubwFqb8CepkQccjwzZNUS7xjkUkmA3vHdFJhzy4ho/iuU8Un
 0CR7xygDh8aFy3h/40Dxus1a4w2kaCjduJIjkF6Q==
X-Received: by 2002:ac8:5981:0:b0:55c:840:1308 with SMTP id
 d75a77b69052e-55d5a6a44a6mr2811691cf.60.1794941356739; 
 Tue, 17 Nov 2026 10:49:16 -0800 (PST)
X-Received: by 2002:ac8:5981:0:b0:55c:840:1308 with SMTP id
 d75a77b69052e-55d5a6a44a6mr2811261cf.60.1794941356075; 
 Tue, 17 Nov 2026 10:49:16 -0800 (PST)
Received: from [10.222.168.147] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d59035c68sm3285231cf.11.2026.11.17.10.49.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 10:49:15 -0800 (PST)
Message-ID: <713e5bf4-11e6-4be8-b500-13149d6ff38a@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 12:49:13 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] target/hexagon: suppress LR writes from a losing
 call
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
 <20261117183629.2002840-4-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261117183629.2002840-4-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5AhNDQgKYjDBsoFcTVdSeVWc7kY--_8l
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX6a2zI5sQF97K
 7mBTTipcOQyrTKzB7A76NTaBCwc4maHg2eCj8HUGfwBo1PdKYI2n21b3YChY/yK6+6C7Wf687Rf
 kmGoXqlRaV51M3KzWhhq3f6A6crGzZ4=
X-Proofpoint-ORIG-GUID: 5AhNDQgKYjDBsoFcTVdSeVWc7kY--_8l
X-Authority-Analysis: v=2.4 cv=Cuwq4X4D c=1 sm=1 tr=0 ts=6afca1ad cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=UW2KahRjcqVlf_GIGrMA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX2EjEwdIVmXWF
 GtakFEQaIOUg1dj0fEhIUobDcyTchzbEDwrUAIQKKjzWRnAB6TtyPatY9jj7Vp+mpYn3oUhX4YO
 VF6iF4w8DVF7+tiztHiuAZ6gCTmCev/KLS5iC70lETBDb5tnLiYzFlhpa8pDpX++osEknVI0Os7
 mkCCSBMlEzP/MIEZwPkQXYovwkbdqOUn5GDqrMF5nZuLXzk2bozi/r8W41rUY8DQeIphGCs+Gkg
 SpLn1RNqqyBZVFBBrq2FOP1T7wbJGgam3BFUyvi+r2CEvb47328+7nE8VboPsOULx49eBn9i/PR
 /VBjQikVgBPeWjyAULH2RITQniTWzVETgQN5XV1LbZ43E8S6XJ4Yh7CRFQ5BH3pEZRRPGSWe7aE
 z8bRfjhTFGQOMmxMgID+dehWZfxe08sv3EdnQsTus/ZBz7o/qebHUMXH9O9aTOQBYenEfOV4raQ
 ACnhw+qcp0BmK/de6QQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170074
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


On 11/17/2026 12:36 PM, Marco Liebel wrote:
> A call after a taken branch must not update LR. Guard direct and
> indirect calls with the packet branch state, and preserve LR when a
> multi-branch packet uses deferred register commit.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   target/hexagon/genptr.c         | 14 +++++++++++---
>   target/hexagon/translate.c      |  4 ++++
>   tests/tcg/hexagon/packet_user.c | 26 ++++++++++++++++++++++++++
>   3 files changed, 41 insertions(+), 3 deletions(-)


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index d226cc4ebb..954dea6622 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -1058,27 +1058,35 @@ static void gen_jumpr(DisasContext *ctx, TCGv new_pc)
>   static void gen_call(DisasContext *ctx, int pc_off)
>   {
>       TCGv lr = get_result_gpr(ctx, HEX_REG_LR);
> +    TCGLabel *skip = gen_new_label();
> +    if (ctx->pkt.pkt_has_multi_cof) {
> +        tcg_gen_brcondi_tl(TCG_COND_NE, ctx->branch_taken, 0, skip);
> +    }
>       tcg_gen_movi_tl(lr, ctx->next_PC);
>       gen_write_new_pc_pcrel(ctx, pc_off, TCG_COND_ALWAYS, NULL);
> +    gen_set_label(skip);
>   }
>   
>   static void gen_callr(DisasContext *ctx, TCGv new_pc)
>   {
>       TCGv lr = get_result_gpr(ctx, HEX_REG_LR);
> +    TCGLabel *skip = gen_new_label();
>   
>       new_pc = gen_unalias_gpr_src(new_pc, lr);
> +    if (ctx->pkt.pkt_has_multi_cof) {
> +        tcg_gen_brcondi_tl(TCG_COND_NE, ctx->branch_taken, 0, skip);
> +    }
>       tcg_gen_movi_tl(lr, ctx->next_PC);
>       gen_write_new_pc_addr(ctx, new_pc, TCG_COND_ALWAYS, NULL);
> +    gen_set_label(skip);
>   }
>   
>   static void gen_cond_call(DisasContext *ctx, TCGv pred,
>                             TCGCond cond, int pc_off)
>   {
> -    TCGv lr = get_result_gpr(ctx, HEX_REG_LR);
>       TCGLabel *skip = gen_new_label();
> -    gen_write_new_pc_pcrel(ctx, pc_off, cond, pred);
>       tcg_gen_brcondi_tl(cond, pred, 1, skip);
> -    tcg_gen_movi_tl(lr, ctx->next_PC);
> +    gen_call(ctx, pc_off);
>       gen_set_label(skip);
>   }
>   
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index ec1d79e31f..10ed73590c 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -495,6 +495,10 @@ static void mark_implicit_reg_write(DisasContext *ctx, int attrib, int rnum)
>       if (GET_ATTRIB(opcode, attrib)) {
>           bool is_predicated = GET_ATTRIB(opcode, A_CONDEXEC);
>   
> +        if (rnum == HEX_REG_LR && ctx->pkt.pkt_has_multi_cof) {
> +            is_predicated = true;
> +        }
> +
>           /* LC0/LC1 is conditionally written by endloop instructions */
>           if ((rnum == HEX_REG_LC0 || rnum == HEX_REG_LC1) &&
>               (opcode == J2_endloop0 ||
> diff --git a/tests/tcg/hexagon/packet_user.c b/tests/tcg/hexagon/packet_user.c
> index 1343a0287a..4b23a02a79 100644
> --- a/tests/tcg/hexagon/packet_user.c
> +++ b/tests/tcg/hexagon/packet_user.c
> @@ -47,10 +47,36 @@ static void test_usr_mask(void)
>       check32(value, 0x3fffff7f);
>   }
>   
> +static void test_call_priority(void)
> +{
> +    unsigned lr;
> +
> +    asm volatile(
> +        "r12 = r31\n"
> +        "r31 = ##0x12345678\n"
> +        "r0 = #0\n"
> +        "p0 = cmp.eq(r0,r0)\n"
> +        "{\n"
> +        "    if (p0) jump 1f\n"
> +        "    call 2f\n"
> +        "}\n"
> +        "2:\n"
> +        "r31 = #0\n"
> +        "1:\n"
> +        "%[lr] = r31\n"
> +        "r31 = r12\n"
> +        : [lr] "=&r"(lr)
> +        : : "r0", "r12", "r31", "p0"
> +    );
> +    /* Losing call preserves LR. */
> +    check32(lr, 0x12345678);
> +}
> +
>   int main(void)
>   {
>       test_predicate_read();
>       test_usr_mask();
> +    test_call_priority();
>       puts(err ? "FAIL" : "PASS");
>       return err != 0;
>   }

