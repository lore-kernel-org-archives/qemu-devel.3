Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91323103E2F5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 00:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Ts5-0000zw-AN; Wed, 11 Mar 2026 20:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Ts3-0000zm-FW
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 20:25:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Tru-0002MF-Ci
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 20:25:47 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62BMMmUK4132496
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 00:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=M0jpNn6DFUHT95CqUIjzy0P8
 Cds/wa94aY0t7RM3Sno=; b=bQcr+0KR09UkR6tNzlkDmRht7QNFaKXFRcGaNRnh
 Ej7XX/UIwoYv2urn1S8QNHtT7Znn0WyeNJy67Ad0/YfDtsmbnK6a2RNN1X1E0oq+
 dM7tcf5iRdkq4HcJTjGERaRtNhGugXs2HMo8Rz88U+l7cev61C7f6eKkA1aB/DXR
 L4Ohqq1n8BNHcU+IzMZaDtMgIr6E2TFagJ0qDUeuPOgbgwk+WCRHoyfxOYvHv4QP
 Vow5bO28k0iHASVCdziC2+KMtlaqEKOhRO8s9XhKWlUtUUZNItPs0k8P9QVi3dV8
 7pi5fPh5lpvwtnYK2rcxFK5opnk5MJ/+e5a49EdfgGaOPQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh4w09v1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 00:25:30 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-79885818011so12472637b3.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 17:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773275130; cv=none;
 d=google.com; s=arc-20240605;
 b=YfxdhsrcFSnEXBcoLKDMghPE84cwE2WLL+TNwjlTyyGjiZ8tzWTDbgR7wKAWviE6G3
 pVaNoJsr/68M3NOxWEP9kbc3+dxjTsbmtYZcWZ6hHSpQAbrGpHoGAVWhPEbTkQ2czREO
 FOWLwzK7FUiz0FWwKRrcjm35VHdBCh3wA5dDm/Mvxq8FxhXIXLA+y+oupUTfZBCQJDTL
 mbqcJJWFMhmsbm183ENmun3/x4OAWZWYx3JGssudiQGKzcpkUY2/ychcfYphY3IhIZYK
 ZEFHnyur7tbVSvucouvmTy3Y0MFC7NPxaBcAM6VdDJ2g1UyCIKIsz6pzPj0Naunt5wrr
 CTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=M0jpNn6DFUHT95CqUIjzy0P8Cds/wa94aY0t7RM3Sno=;
 fh=mrfZO0qQM5eciwqMtrtmvbDllU4euPRvlqU0p6gBO7o=;
 b=aKeXdFesKEbwFhYYT9BfMqN11Zik2Y+Qw9AvTnJDRpXA1A796Iy6WnzW8hChrGMeab
 67AyHInk09PFl2LFZwlZdttY7SDFq8THTGbQq459W9VS+M5sEyNV0T0Q/QFizb40qiKu
 7W1kFe/Kcibd1ExAoRS2NE0igdnbIdU3a7n/HMphVgV1YpUt5stEsTca6R/LA0N/u7tk
 w9gjNxT9ivDPsTKUmChpejPjqMkWk0CyEzVKJ6vhtL1eKt7TuLtteesHxmbEG/Ff2u8I
 PqvVCvNu8iyxQnpj7xB2S5NcLXus934RrqaTZXoN2GHFVyKh97Fz+w5sdYBk35gU2xki
 pLZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773275130; x=1773879930; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M0jpNn6DFUHT95CqUIjzy0P8Cds/wa94aY0t7RM3Sno=;
 b=LUB9ZNxBq3bVNUxBSE7YQZmsXPrK4utZ2ejV0J8KsTv66F8GZW7tvZQH0fnmJsGFum
 sqj2zm92OHIRdmaIkj7aPzaj4Ske56rcdPx+rDJeq2wOU22y05DhwTy/5VZHv4O73iNJ
 Avyb7HWjPHbMjgklZzRw2I0b/h4/lHhXNuQJTC2MotX7wQ/S08TkK4Gj0aKCvqspfqS5
 rWpo7g5CWLKhLOsYYU69bU6ELkU3KNcST3VjPz8Ht+QY9UAavyJEM9YvP1d1br19ISiU
 kliJh/USvDj7i7WjTGIPISN1HWKb1SDaUAI3v7LahDNtks5uC/iW396AMQQvImpqooum
 U3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773275130; x=1773879930;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M0jpNn6DFUHT95CqUIjzy0P8Cds/wa94aY0t7RM3Sno=;
 b=omkgi/zuMluYhaGbY0pAoJXEAYZDkzLQ7vZhnCuKId9dTlnbZGUO4nXG1MzcBFedTX
 rvttphYvQL79cxpPtQ21W9yTgWk+oq4gBGWfE++mGNQ3U/KMJ659nA68TheWB0+2o74v
 2bYDMC4IIl86s4LmLdbx+eZEuQ2F+yGsPndU+LCrq4jF7HlLzJv4z7qphOvsI87I2S1I
 5PRl10RuwX4BBs0e8KkClk2lMKTihhhRhLmRrGin/ndy4yGmT0S6RBb+cq2ut4bL7gee
 IZPfowAZFaY9ljjrNt1/55BjwJa8uimJuB3M3WEyzibGtcVM9gLPd4h7pnC00GNh5tpm
 kwJQ==
X-Gm-Message-State: AOJu0YytmRgIrn6qXQXVfskgxi8a/mDSJD/QW4Lev1lhi3+s7CrdDMzJ
 W2z20Gda+uEHwe8eeUib5HW1LPkoy+g9FdGJdy3TmRluSG9s+G9/vR/TfNpm3+1um3zziuc3ze4
 76zBnrXO2Go5f+KfLeUAyGkq3d+Kt5vkyh837NG0fcSpvH1EFzoYJ1bG+WEL375doNQdsnXOmtz
 V2f+HC3t6sHmAxaVs3HtAp6BWKJCYrCekK
X-Gm-Gg: ATEYQzwulHdwLgLBPjE5ZrAcCL6jCuCfGO3lBjJvO+Sm104EAQXHkKD4plokY9z0Bns
 EeIYjwkyWrhGlwx9qfw4v1gQ3RNJcVHLWrHURVRTD9aKgGjNb+WWSxFPsT4tgxRyNrKOsI/Jw6X
 VoqdwvLK3Ocj3EBRGoqBDBqInyfdK8EKOuXtd0JeKFxjhEsxNJscjNVwPjy+4Bg+17p6I5/pTMk
 QQSTdBJ
X-Received: by 2002:a05:690c:6b01:b0:799:394:bd4d with SMTP id
 00721157ae682-79917f6a004mr42691047b3.34.1773275129753; 
 Wed, 11 Mar 2026 17:25:29 -0700 (PDT)
X-Received: by 2002:a05:690c:6b01:b0:799:394:bd4d with SMTP id
 00721157ae682-79917f6a004mr42690867b3.34.1773275129245; Wed, 11 Mar 2026
 17:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260122223423.1076448-1-marco.liebel@oss.qualcomm.com>
In-Reply-To: <20260122223423.1076448-1-marco.liebel@oss.qualcomm.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 19:25:13 -0500
X-Gm-Features: AaiRm53L0QR-bc7hQvwjXzqV8PX6UTQ10Xw8q98HYcaWV1_SagEmrQld24b5x2M
Message-ID: <CAEqNhNYa8xybC2tRKscjZhon7vuW4pn3-OuLaLwOj2Y4PHV8QQ@mail.gmail.com>
Subject: Re: [PATCH] target/hexagon: Change DisasContext packet type
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, ltaylorsimpson@gmail.com
Content-Type: multipart/alternative; boundary="0000000000002b03ad064cc8ca4f"
X-Proofpoint-GUID: 56_qJh4gG2zdIf9j1lQvJCGVJ6Hm_7en
X-Authority-Analysis: v=2.4 cv=Cpays34D c=1 sm=1 tr=0 ts=69b207fa cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=fAlD8lbxKIBA9FXA9egA:9 a=QEXdDO2ut3YA:10
 a=-Q7CsVOoc5fpf6MUhYAA:9 a=GDKeJh5gqH_atB6I:21 a=lqcHg5cX4UMA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-ORIG-GUID: 56_qJh4gG2zdIf9j1lQvJCGVJ6Hm_7en
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDAwMiBTYWx0ZWRfX5nLdtdNajbno
 GCqGFqCrk4edKMj/4JUCm6Gws85YyUWTlg1KMIvXjpOvB+YuQ+MTzQEN+Zn8RgUTsrxKyinVuWL
 KQ7d5azFucvz3P3tIjvBCM+19x3fVxOPYOu69v8aqoofOTmo3VnkF/rK8JLU5Y6YWv0qCGuQeMM
 swXH+zigqzeJZ7ixyDkPXRrdLTcZbpAXrw2RZzuPkaYgn+1twCzLDhsCYmplVGHKEPuy2/NSNW1
 FGP+bWc8N5sclHUIPHt3xQvwwrtD0yWrFhqx11duunQODbR4ebKAJ1W8MC//R8x/I0SLOaKGzRs
 zF9ICzgr9IZQBtgBO90st/CAcrKQ8WqS0/+Hic1IWXkkvcKcdQ9t3qsxU5FLGXIHk1bzZeCaKM8
 E/7D1HwCeDoLx8b1KwcGshpB9B7eVBlmlNH+O8NujWEO5piwnjfpqrjJ/dZ2Kh/biAZAkd7TXBF
 1LtgdbFA7YMcVF/RLtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120002
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000002b03ad064cc8ca4f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 4:34=E2=80=AFPM Marco Liebel <marco.liebel@oss.qual=
comm.com>
wrote:

> The pkt variable inside DisasContext is of type Packet * and gets
> assigned to a local variable in decode_and_translate_packet. Right now
> there seems to be no problem with it but future changes to e.g.
> hexagon_tr_transalte_packet are potentially dangerous if pkt is accessed
> after the local variable goes out of scope.
>
> Since packets are being translated one at a time, the type of pkt can be
> changed to just Packet to avoid risk of having a dangling pointer.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>



>  target/hexagon/gen_tcg.h        |   2 +-
>  target/hexagon/macros.h         |   6 +-
>  target/hexagon/translate.h      |   2 +-
>  target/hexagon/decode.c         |   8 +--
>  target/hexagon/genptr.c         |  14 ++--
>  target/hexagon/translate.c      | 111 ++++++++++++++------------------
>  target/hexagon/gen_tcg_funcs.py |   2 +-
>  target/hexagon/hex_common.py    |   4 +-
>  8 files changed, 65 insertions(+), 84 deletions(-)
>
> diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
> index 7b96dab918..54562e3ef3 100644
> --- a/target/hexagon/gen_tcg.h
> +++ b/target/hexagon/gen_tcg.h
> @@ -1363,7 +1363,7 @@
>  #define fGEN_TCG_J2_trap0(SHORTCODE) \
>      do { \
>          uiV =3D uiV; \
> -        tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->pkt->pc); \
> +        tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->pkt.pc); \
>          TCGv excp =3D tcg_constant_tl(HEX_EVENT_TRAP0); \
>          gen_helper_raise_exception(tcg_env, excp); \
>      } while (0)
> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
> index 6c2862a232..eebfe1e5ed 100644
> --- a/target/hexagon/macros.h
> +++ b/target/hexagon/macros.h
> @@ -83,7 +83,7 @@
>   */
>  #define CHECK_NOSHUF(VA, SIZE) \
>      do { \
> -        if (insn->slot =3D=3D 0 && ctx->pkt->pkt_has_scalar_store_s1) { =
\
> +        if (insn->slot =3D=3D 0 && ctx->pkt.pkt_has_scalar_store_s1) { \
>              probe_noshuf_load(VA, SIZE, ctx->mem_idx); \
>              process_store(ctx, 1); \
>          } \
> @@ -94,11 +94,11 @@
>          TCGLabel *noshuf_label =3D gen_new_label(); \
>          tcg_gen_brcondi_tl(TCG_COND_EQ, PRED, 0, noshuf_label); \
>          GET_EA; \
> -        if (insn->slot =3D=3D 0 && ctx->pkt->pkt_has_scalar_store_s1) { =
\
> +        if (insn->slot =3D=3D 0 && ctx->pkt.pkt_has_scalar_store_s1) { \
>              probe_noshuf_load(EA, SIZE, ctx->mem_idx); \
>          } \
>          gen_set_label(noshuf_label); \
> -        if (insn->slot =3D=3D 0 && ctx->pkt->pkt_has_scalar_store_s1) { =
\
> +        if (insn->slot =3D=3D 0 && ctx->pkt.pkt_has_scalar_store_s1) { \
>              process_store(ctx, 1); \
>          } \
>      } while (0)
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index a0102b6cbd..ffbfc3ac0e 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -28,7 +28,7 @@
>
>  typedef struct DisasContext {
>      DisasContextBase base;
> -    Packet *pkt;
> +    Packet pkt;
>      Insn *insn;
>      uint32_t next_PC;
>      uint32_t mem_idx;
> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
> index b5ece60450..c2516d927d 100644
> --- a/target/hexagon/decode.c
> +++ b/target/hexagon/decode.c
> @@ -748,14 +748,12 @@ int disassemble_hexagon(uint32_t *words, int nwords=
,
> bfd_vma pc,
>                          GString *buf)
>  {
>      DisasContext ctx;
> -    Packet pkt;
>
>      memset(&ctx, 0, sizeof(DisasContext));
> -    ctx.pkt =3D &pkt;
>
> -    if (decode_packet(&ctx, nwords, words, &pkt, true) > 0) {
> -        snprint_a_pkt_disas(buf, &pkt, words, pc);
> -        return pkt.encod_pkt_size_in_bytes;
> +    if (decode_packet(&ctx, nwords, words, &ctx.pkt, true) > 0) {
> +        snprint_a_pkt_disas(buf, &ctx.pkt, words, pc);
> +        return ctx.pkt.encod_pkt_size_in_bytes;
>      } else {
>          g_string_assign(buf, "<invalid>");
>          return 0;
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index 36968549d5..160edfe756 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -382,7 +382,7 @@ static inline void gen_store_conditional8(DisasContex=
t
> *ctx,
>  static TCGv gen_slotval(DisasContext *ctx)
>  {
>      int slotval =3D
> -        (ctx->pkt->pkt_has_scalar_store_s1 & 1) | (ctx->insn->slot << 1)=
;
> +        (ctx->pkt.pkt_has_scalar_store_s1 & 1) | (ctx->insn->slot << 1);
>      return tcg_constant_tl(slotval);
>  }
>  #endif
> @@ -458,7 +458,7 @@ static void gen_write_new_pc_addr(DisasContext *ctx,
> TCGv addr,
>          tcg_gen_brcondi_tl(cond, pred, 0, pred_false);
>      }
>
> -    if (ctx->pkt->pkt_has_multi_cof) {
> +    if (ctx->pkt.pkt_has_multi_cof) {
>          /* If there are multiple branches in a packet, ignore the second
> one */
>          tcg_gen_movcond_tl(TCG_COND_NE, hex_gpr[HEX_REG_PC],
>                             ctx->branch_taken, tcg_constant_tl(0),
> @@ -476,8 +476,8 @@ static void gen_write_new_pc_addr(DisasContext *ctx,
> TCGv addr,
>  static void gen_write_new_pc_pcrel(DisasContext *ctx, int pc_off,
>                                     TCGCond cond, TCGv pred)
>  {
> -    target_ulong dest =3D ctx->pkt->pc + pc_off;
> -    if (ctx->pkt->pkt_has_multi_cof) {
> +    target_ulong dest =3D ctx->pkt.pc + pc_off;
> +    if (ctx->pkt.pkt_has_multi_cof) {
>          gen_write_new_pc_addr(ctx, tcg_constant_tl(dest), cond, pred);
>      } else {
>          /* Defer this jump to the end of the TB */
> @@ -528,7 +528,7 @@ static inline void gen_loop0r(DisasContext *ctx, TCGv
> RsV, int riV)
>      fIMMEXT(riV);
>      fPCALIGN(riV);
>      tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC0), RsV);
> -    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx->pkt->pc + riV=
);
> +    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx->pkt.pc + riV)=
;
>      gen_set_usr_fieldi(ctx, USR_LPCFG, 0);
>  }
>
> @@ -542,7 +542,7 @@ static inline void gen_loop1r(DisasContext *ctx, TCGv
> RsV, int riV)
>      fIMMEXT(riV);
>      fPCALIGN(riV);
>      tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC1), RsV);
> -    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA1), ctx->pkt->pc + riV=
);
> +    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA1), ctx->pkt.pc + riV)=
;
>  }
>
>  static void gen_loop1i(DisasContext *ctx, int count, int riV)
> @@ -555,7 +555,7 @@ static void gen_ploopNsr(DisasContext *ctx, int N,
> TCGv RsV, int riV)
>      fIMMEXT(riV);
>      fPCALIGN(riV);
>      tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC0), RsV);
> -    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx->pkt->pc + riV=
);
> +    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx->pkt.pc + riV)=
;
>      gen_set_usr_fieldi(ctx, USR_LPCFG, N);
>      gen_pred_write(ctx, 3, tcg_constant_tl(0));
>  }
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index e88e19cc1a..b06ed154f3 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -156,8 +156,6 @@ static void gen_goto_tb(DisasContext *ctx, unsigned
> tb_slot_idx,
>
>  static void gen_end_tb(DisasContext *ctx)
>  {
> -    Packet *pkt =3D ctx->pkt;
> -
>      gen_exec_counters(ctx);
>
>      if (ctx->branch_cond !=3D TCG_COND_NEVER) {
> @@ -171,7 +169,7 @@ static void gen_end_tb(DisasContext *ctx)
>              gen_goto_tb(ctx, 0, ctx->branch_dest, true);
>          }
>      } else if (ctx->is_tight_loop &&
> -               pkt->insn[pkt->num_insns - 1].opcode =3D=3D J2_endloop0) =
{
> +               ctx->pkt.insn[ctx->pkt.num_insns - 1].opcode =3D=3D
> J2_endloop0) {
>          /*
>           * When we're in a tight loop, we defer the endloop0 processing
>           * to take advantage of direct block chaining
> @@ -252,11 +250,9 @@ static bool need_slot_cancelled(Packet *pkt)
>
>  static bool need_next_PC(DisasContext *ctx)
>  {
> -    Packet *pkt =3D ctx->pkt;
> -
>      /* Check for conditional control flow or HW loop end */
> -    for (int i =3D 0; i < pkt->num_insns; i++) {
> -        uint16_t opcode =3D pkt->insn[i].opcode;
> +    for (int i =3D 0; i < ctx->pkt.num_insns; i++) {
> +        uint16_t opcode =3D ctx->pkt.insn[i].opcode;
>          if (GET_ATTRIB(opcode, A_CONDEXEC) && GET_ATTRIB(opcode, A_COF))=
 {
>              return true;
>          }
> @@ -339,8 +335,6 @@ static bool pkt_raises_exception(Packet *pkt)
>
>  static bool need_commit(DisasContext *ctx)
>  {
> -    Packet *pkt =3D ctx->pkt;
> -
>      /*
>       * If the short-circuit property is set to false, we'll always do th=
e
> commit
>       */
> @@ -348,7 +342,7 @@ static bool need_commit(DisasContext *ctx)
>          return true;
>      }
>
> -    if (pkt_raises_exception(pkt)) {
> +    if (pkt_raises_exception(&ctx->pkt)) {
>          return true;
>      }
>
> @@ -395,11 +389,10 @@ static void mark_implicit_writes(DisasContext *ctx)
>
>  static void analyze_packet(DisasContext *ctx)
>  {
> -    Packet *pkt =3D ctx->pkt;
>      ctx->read_after_write =3D false;
>      ctx->has_hvx_overlap =3D false;
> -    for (int i =3D 0; i < pkt->num_insns; i++) {
> -        Insn *insn =3D &pkt->insn[i];
> +    for (int i =3D 0; i < ctx->pkt.num_insns; i++) {
> +        Insn *insn =3D &ctx->pkt.insn[i];
>          ctx->insn =3D insn;
>          if (opcode_analyze[insn->opcode]) {
>              opcode_analyze[insn->opcode](ctx);
> @@ -411,8 +404,7 @@ static void analyze_packet(DisasContext *ctx)
>
>  static void gen_start_packet(DisasContext *ctx)
>  {
> -    Packet *pkt =3D ctx->pkt;
> -    target_ulong next_PC =3D ctx->base.pc_next +
> pkt->encod_pkt_size_in_bytes;
> +    target_ulong next_PC =3D ctx->base.pc_next +
> ctx->pkt.encod_pkt_size_in_bytes;
>      int i;
>
>      /* Clear out the disassembly context */
> @@ -454,13 +446,13 @@ static void gen_start_packet(DisasContext *ctx)
>      bitmap_zero(ctx->pregs_written, NUM_PREGS);
>
>      /* Initialize the runtime state for packet semantics */
> -    if (need_slot_cancelled(pkt)) {
> +    if (need_slot_cancelled(&ctx->pkt)) {
>          tcg_gen_movi_tl(hex_slot_cancelled, 0);
>      }
>      ctx->branch_taken =3D NULL;
> -    if (pkt->pkt_has_cof) {
> +    if (ctx->pkt.pkt_has_cof) {
>          ctx->branch_taken =3D tcg_temp_new();
> -        if (pkt->pkt_has_multi_cof) {
> +        if (ctx->pkt.pkt_has_multi_cof) {
>              tcg_gen_movi_tl(ctx->branch_taken, 0);
>          }
>          if (need_next_PC(ctx)) {
> @@ -489,7 +481,7 @@ static void gen_start_packet(DisasContext *ctx)
>       * Preload the predicated pred registers into
> ctx->new_pred_value[pred_num]
>       * Only endloop instructions conditionally write to pred registers
>       */
> -    if (ctx->need_commit && pkt->pkt_has_endloop) {
> +    if (ctx->need_commit && ctx->pkt.pkt_has_endloop) {
>          for (i =3D 0; i < ctx->preg_log_idx; i++) {
>              int pred_num =3D ctx->preg_log[i];
>              ctx->new_pred_value[pred_num] =3D tcg_temp_new();
> @@ -528,13 +520,11 @@ static void gen_start_packet(DisasContext *ctx)
>
>  bool is_gather_store_insn(DisasContext *ctx)
>  {
> -    Packet *pkt =3D ctx->pkt;
> -    Insn *insn =3D ctx->insn;
> -    if (GET_ATTRIB(insn->opcode, A_CVI_NEW) &&
> -        insn->new_value_producer_slot =3D=3D 1) {
> +    if (GET_ATTRIB(ctx->insn->opcode, A_CVI_NEW) &&
> +        ctx->insn->new_value_producer_slot =3D=3D 1) {
>          /* Look for gather instruction */
> -        for (int i =3D 0; i < pkt->num_insns; i++) {
> -            Insn *in =3D &pkt->insn[i];
> +        for (int i =3D 0; i < ctx->pkt.num_insns; i++) {
> +            Insn *in =3D &ctx->pkt.insn[i];
>              if (GET_ATTRIB(in->opcode, A_CVI_GATHER) && in->slot =3D=3D =
1) {
>                  return true;
>              }
> @@ -637,7 +627,7 @@ static bool slot_is_predicated(Packet *pkt, int
> slot_num)
>
>  void process_store(DisasContext *ctx, int slot_num)
>  {
> -    bool is_predicated =3D slot_is_predicated(ctx->pkt, slot_num);
> +    bool is_predicated =3D slot_is_predicated(&ctx->pkt, slot_num);
>      TCGLabel *label_end =3D NULL;
>
>      /*
> @@ -714,13 +704,12 @@ static void process_store_log(DisasContext *ctx)
>       *  slot 1 and then slot 0.  This will be important when
>       *  the memory accesses overlap.
>       */
> -    Packet *pkt =3D ctx->pkt;
> -    if (pkt->pkt_has_scalar_store_s1) {
> -        g_assert(!pkt->pkt_has_dczeroa);
> +    if (ctx->pkt.pkt_has_scalar_store_s1) {
> +        g_assert(!ctx->pkt.pkt_has_dczeroa);
>          process_store(ctx, 1);
>      }
> -    if (pkt->pkt_has_scalar_store_s0) {
> -        g_assert(!pkt->pkt_has_dczeroa);
> +    if (ctx->pkt.pkt_has_scalar_store_s0) {
> +        g_assert(!ctx->pkt.pkt_has_dczeroa);
>          process_store(ctx, 0);
>      }
>  }
> @@ -728,7 +717,7 @@ static void process_store_log(DisasContext *ctx)
>  /* Zero out a 32-bit cache line */
>  static void process_dczeroa(DisasContext *ctx)
>  {
> -    if (ctx->pkt->pkt_has_dczeroa) {
> +    if (ctx->pkt.pkt_has_dczeroa) {
>          /* Store 32 bytes of zero starting at (addr & ~0x1f) */
>          TCGv addr =3D tcg_temp_new();
>          TCGv_i64 zero =3D tcg_constant_i64(0);
> @@ -762,7 +751,7 @@ static void gen_commit_hvx(DisasContext *ctx)
>
>      /* Early exit if not needed */
>      if (!ctx->need_commit) {
> -        g_assert(!pkt_has_hvx_store(ctx->pkt));
> +        g_assert(!pkt_has_hvx_store(&ctx->pkt));
>          return;
>      }
>
> @@ -796,25 +785,23 @@ static void gen_commit_hvx(DisasContext *ctx)
>          tcg_gen_gvec_mov(MO_64, dstoff, srcoff, size, size);
>      }
>
> -    if (pkt_has_hvx_store(ctx->pkt)) {
> +    if (pkt_has_hvx_store(&ctx->pkt)) {
>          gen_helper_commit_hvx_stores(tcg_env);
>      }
>  }
>
>  static void update_exec_counters(DisasContext *ctx)
>  {
> -    Packet *pkt =3D ctx->pkt;
> -    int num_insns =3D pkt->num_insns;
>      int num_real_insns =3D 0;
>      int num_hvx_insns =3D 0;
>
> -    for (int i =3D 0; i < num_insns; i++) {
> -        if (!pkt->insn[i].is_endloop &&
> -            !pkt->insn[i].part1 &&
> -            !GET_ATTRIB(pkt->insn[i].opcode, A_IT_NOP)) {
> +    for (int i =3D 0; i < ctx->pkt.num_insns; i++) {
> +        if (!ctx->pkt.insn[i].is_endloop &&
> +            !ctx->pkt.insn[i].part1 &&
> +            !GET_ATTRIB(ctx->pkt.insn[i].opcode, A_IT_NOP)) {
>              num_real_insns++;
>          }
> -        if (GET_ATTRIB(pkt->insn[i].opcode, A_CVI)) {
> +        if (GET_ATTRIB(ctx->pkt.insn[i].opcode, A_CVI)) {
>              num_hvx_insns++;
>          }
>      }
> @@ -843,12 +830,11 @@ static void gen_commit_packet(DisasContext *ctx)
>       * store.  Therefore, we call process_store_log before anything else
>       * involved in committing the packet.
>       */
> -    Packet *pkt =3D ctx->pkt;
> -    bool has_store_s0 =3D pkt->pkt_has_scalar_store_s0;
> +    bool has_store_s0 =3D ctx->pkt.pkt_has_scalar_store_s0;
>      bool has_store_s1 =3D
> -        (pkt->pkt_has_scalar_store_s1 && !ctx->s1_store_processed);
> -    bool has_hvx_store =3D pkt_has_hvx_store(pkt);
> -    if (pkt->pkt_has_dczeroa) {
> +        (ctx->pkt.pkt_has_scalar_store_s1 && !ctx->s1_store_processed);
> +    bool has_hvx_store =3D pkt_has_hvx_store(&ctx->pkt);
> +    if (ctx->pkt.pkt_has_dczeroa) {
>          /*
>           * The dczeroa will be the store in slot 0, check that we don't
> have
>           * a store in slot 1 or an HVX store.
> @@ -875,12 +861,11 @@ static void gen_commit_packet(DisasContext *ctx)
>                      FIELD_DP32(mask, PROBE_PKT_SCALAR_HVX_STORES,
>                                 HAS_HVX_STORES, 1);
>              }
> -            if (has_store_s0 && slot_is_predicated(pkt, 0)) {
> -                mask =3D
> -                    FIELD_DP32(mask, PROBE_PKT_SCALAR_HVX_STORES,
> -                               S0_IS_PRED, 1);
> +            if (has_store_s0 && slot_is_predicated(&ctx->pkt, 0)) {
> +                mask =3D FIELD_DP32(mask, PROBE_PKT_SCALAR_HVX_STORES,
> S0_IS_PRED,
> +                                  1);
>              }
> -            if (has_store_s1 && slot_is_predicated(pkt, 1)) {
> +            if (has_store_s1 && slot_is_predicated(&ctx->pkt, 1)) {
>                  mask =3D
>                      FIELD_DP32(mask, PROBE_PKT_SCALAR_HVX_STORES,
>                                 S1_IS_PRED, 1);
> @@ -898,7 +883,7 @@ static void gen_commit_packet(DisasContext *ctx)
>          int args =3D 0;
>          args =3D
>              FIELD_DP32(args, PROBE_PKT_SCALAR_STORE_S0, MMU_IDX,
> ctx->mem_idx);
> -        if (slot_is_predicated(pkt, 0)) {
> +        if (slot_is_predicated(&ctx->pkt, 0)) {
>              args =3D
>                  FIELD_DP32(args, PROBE_PKT_SCALAR_STORE_S0,
> IS_PREDICATED, 1);
>          }
> @@ -910,18 +895,18 @@ static void gen_commit_packet(DisasContext *ctx)
>
>      gen_reg_writes(ctx);
>      gen_pred_writes(ctx);
> -    if (pkt->pkt_has_hvx) {
> +    if (ctx->pkt.pkt_has_hvx) {
>          gen_commit_hvx(ctx);
>      }
>      update_exec_counters(ctx);
>
> -    if (pkt->vhist_insn !=3D NULL) {
> +    if (ctx->pkt.vhist_insn !=3D NULL) {
>          ctx->pre_commit =3D false;
> -        ctx->insn =3D pkt->vhist_insn;
> -        pkt->vhist_insn->generate(ctx);
> +        ctx->insn =3D ctx->pkt.vhist_insn;
> +        ctx->pkt.vhist_insn->generate(ctx);
>      }
>
> -    if (pkt->pkt_has_cof) {
> +    if (ctx->pkt.pkt_has_cof) {
>          gen_end_tb(ctx);
>      }
>  }
> @@ -930,7 +915,6 @@ static void
> decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
>  {
>      uint32_t words[PACKET_WORDS_MAX];
>      int nwords;
> -    Packet pkt;
>      int i;
>
>      nwords =3D read_packet_words(env, ctx, words);
> @@ -939,16 +923,15 @@ static void
> decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
>          return;
>      }
>
> -    ctx->pkt =3D &pkt;
> -    if (decode_packet(ctx, nwords, words, &pkt, false) > 0) {
> -        pkt.pc =3D ctx->base.pc_next;
> +    if (decode_packet(ctx, nwords, words, &ctx->pkt, false) > 0) {
> +        ctx->pkt.pc =3D ctx->base.pc_next;
>          gen_start_packet(ctx);
> -        for (i =3D 0; i < pkt.num_insns; i++) {
> -            ctx->insn =3D &pkt.insn[i];
> +        for (i =3D 0; i < ctx->pkt.num_insns; i++) {
> +            ctx->insn =3D &ctx->pkt.insn[i];
>              gen_insn(ctx);
>          }
>          gen_commit_packet(ctx);
> -        ctx->base.pc_next +=3D pkt.encod_pkt_size_in_bytes;
> +        ctx->base.pc_next +=3D ctx->pkt.encod_pkt_size_in_bytes;
>      } else {
>          gen_exception_end_tb(ctx, HEX_CAUSE_INVALID_PACKET);
>      }
> diff --git a/target/hexagon/gen_tcg_funcs.py
> b/target/hexagon/gen_tcg_funcs.py
> index 87b7f10d7f..e7f90a0da1 100755
> --- a/target/hexagon/gen_tcg_funcs.py
> +++ b/target/hexagon/gen_tcg_funcs.py
> @@ -72,7 +72,7 @@ def gen_tcg_func(f, tag, regs, imms):
>          for immlett, bits, immshift in imms:
>              declared.append(hex_common.imm_name(immlett))
>
> -        arguments =3D ", ".join(["ctx", "ctx->insn", "ctx->pkt"] + decla=
red)
> +        arguments =3D ", ".join(["ctx", "ctx->insn", "&ctx->pkt"] +
> declared)
>          f.write(f"    emit_{tag}({arguments});\n")
>
>      elif hex_common.skip_qemu_helper(tag):
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index c0e9f26aeb..e37d5a514f 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -1144,7 +1144,7 @@ def helper_args(tag, regs, imms):
>      if need_pkt_has_multi_cof(tag):
>          args.append(HelperArg(
>              "i32",
> -            "tcg_constant_tl(ctx->pkt->pkt_has_multi_cof)",
> +            "tcg_constant_tl(ctx->pkt.pkt_has_multi_cof)",
>              "uint32_t pkt_has_multi_cof"
>          ))
>      if need_pkt_need_commit(tag):
> @@ -1156,7 +1156,7 @@ def helper_args(tag, regs, imms):
>      if need_PC(tag):
>          args.append(HelperArg(
>              "i32",
> -            "tcg_constant_tl(ctx->pkt->pc)",
> +            "tcg_constant_tl(ctx->pkt.pc)",
>              "target_ulong PC"
>          ))
>      if need_next_PC(tag):
> --
> 2.34.1
>
>

--0000000000002b03ad064cc8ca4f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 22, 2026 at=
 4:34=E2=80=AFPM Marco Liebel &lt;<a href=3D"mailto:marco.liebel@oss.qualco=
mm.com">marco.liebel@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">The pkt variable inside DisasContext i=
s of type Packet * and gets<br>
assigned to a local variable in decode_and_translate_packet. Right now<br>
there seems to be no problem with it but future changes to e.g.<br>
hexagon_tr_transalte_packet are potentially dangerous if pkt is accessed<br=
>
after the local variable goes out of scope.<br>
<br>
Since packets are being translated one at a time, the type of pkt can be<br=
>
changed to just Packet to avoid risk of having a dangling pointer.<br>
<br>
Signed-off-by: Marco Liebel &lt;<a href=3D"mailto:marco.liebel@oss.qualcomm=
.com" target=3D"_blank">marco.liebel@oss.qualcomm.com</a>&gt;<br>
---<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=
=3D"font-family:monospace">Reviewed-by: Brian Cain &lt;<a href=3D"mailto:br=
ian.cain@oss.qualcomm.com">brian.cain@oss.qualcomm.com</a>&gt;</div><br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0target/hexagon/gen_tcg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +=
-<br>
=C2=A0target/hexagon/macros.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A06 +-<br>
=C2=A0target/hexagon/translate.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0target/hexagon/decode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A08 +--<br>
=C2=A0target/hexagon/genptr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 14 +=
+--<br>
=C2=A0target/hexagon/translate.c=C2=A0 =C2=A0 =C2=A0 | 111 ++++++++++++++--=
----------------<br>
=C2=A0target/hexagon/gen_tcg_funcs.py |=C2=A0 =C2=A02 +-<br>
=C2=A0target/hexagon/hex_common.py=C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A08 files changed, 65 insertions(+), 84 deletions(-)<br>
<br>
diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h<br>
index 7b96dab918..54562e3ef3 100644<br>
--- a/target/hexagon/gen_tcg.h<br>
+++ b/target/hexagon/gen_tcg.h<br>
@@ -1363,7 +1363,7 @@<br>
=C2=A0#define fGEN_TCG_J2_trap0(SHORTCODE) \<br>
=C2=A0 =C2=A0 =C2=A0do { \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uiV =3D uiV; \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx-&gt;p=
kt-&gt;pc); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx-&gt;p=
kt.pc); \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv excp =3D tcg_constant_tl(HEX_EVENT_T=
RAP0); \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_helper_raise_exception(tcg_env, excp)=
; \<br>
=C2=A0 =C2=A0 =C2=A0} while (0)<br>
diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h<br>
index 6c2862a232..eebfe1e5ed 100644<br>
--- a/target/hexagon/macros.h<br>
+++ b/target/hexagon/macros.h<br>
@@ -83,7 +83,7 @@<br>
=C2=A0 */<br>
=C2=A0#define CHECK_NOSHUF(VA, SIZE) \<br>
=C2=A0 =C2=A0 =C2=A0do { \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (insn-&gt;slot =3D=3D 0 &amp;&amp; ctx-&gt;=
pkt-&gt;pkt_has_scalar_store_s1) { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (insn-&gt;slot =3D=3D 0 &amp;&amp; ctx-&gt;=
pkt.pkt_has_scalar_store_s1) { \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0probe_noshuf_load(VA, SIZE,=
 ctx-&gt;mem_idx); \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process_store(ctx, 1); \<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} \<br>
@@ -94,11 +94,11 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGLabel *noshuf_label =3D gen_new_label(=
); \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_brcondi_tl(TCG_COND_EQ, PRED, 0, =
noshuf_label); \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GET_EA; \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (insn-&gt;slot =3D=3D 0 &amp;&amp; ctx-&gt;=
pkt-&gt;pkt_has_scalar_store_s1) { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (insn-&gt;slot =3D=3D 0 &amp;&amp; ctx-&gt;=
pkt.pkt_has_scalar_store_s1) { \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0probe_noshuf_load(EA, SIZE,=
 ctx-&gt;mem_idx); \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_set_label(noshuf_label); \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (insn-&gt;slot =3D=3D 0 &amp;&amp; ctx-&gt;=
pkt-&gt;pkt_has_scalar_store_s1) { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (insn-&gt;slot =3D=3D 0 &amp;&amp; ctx-&gt;=
pkt.pkt_has_scalar_store_s1) { \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process_store(ctx, 1); \<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} \<br>
=C2=A0 =C2=A0 =C2=A0} while (0)<br>
diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h<br>
index a0102b6cbd..ffbfc3ac0e 100644<br>
--- a/target/hexagon/translate.h<br>
+++ b/target/hexagon/translate.h<br>
@@ -28,7 +28,7 @@<br>
<br>
=C2=A0typedef struct DisasContext {<br>
=C2=A0 =C2=A0 =C2=A0DisasContextBase base;<br>
-=C2=A0 =C2=A0 Packet *pkt;<br>
+=C2=A0 =C2=A0 Packet pkt;<br>
=C2=A0 =C2=A0 =C2=A0Insn *insn;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t next_PC;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t mem_idx;<br>
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c<br>
index b5ece60450..c2516d927d 100644<br>
--- a/target/hexagon/decode.c<br>
+++ b/target/hexagon/decode.c<br>
@@ -748,14 +748,12 @@ int disassemble_hexagon(uint32_t *words, int nwords, =
bfd_vma pc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0GString *buf)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DisasContext ctx;<br>
-=C2=A0 =C2=A0 Packet pkt;<br>
<br>
=C2=A0 =C2=A0 =C2=A0memset(&amp;ctx, 0, sizeof(DisasContext));<br>
-=C2=A0 =C2=A0 ctx.pkt =3D &amp;pkt;<br>
<br>
-=C2=A0 =C2=A0 if (decode_packet(&amp;ctx, nwords, words, &amp;pkt, true) &=
gt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprint_a_pkt_disas(buf, &amp;pkt, words, pc);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return pkt.encod_pkt_size_in_bytes;<br>
+=C2=A0 =C2=A0 if (decode_packet(&amp;ctx, nwords, words, &amp;ctx.pkt, tru=
e) &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprint_a_pkt_disas(buf, &amp;ctx.pkt, words, =
pc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ctx.pkt.encod_pkt_size_in_bytes;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_string_assign(buf, &quot;&lt;invalid&gt=
;&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c<br>
index 36968549d5..160edfe756 100644<br>
--- a/target/hexagon/genptr.c<br>
+++ b/target/hexagon/genptr.c<br>
@@ -382,7 +382,7 @@ static inline void gen_store_conditional8(DisasContext =
*ctx,<br>
=C2=A0static TCGv gen_slotval(DisasContext *ctx)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int slotval =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (ctx-&gt;pkt-&gt;pkt_has_scalar_store_s1 &amp;=
 1) | (ctx-&gt;insn-&gt;slot &lt;&lt; 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (ctx-&gt;pkt.pkt_has_scalar_store_s1 &amp; 1) =
| (ctx-&gt;insn-&gt;slot &lt;&lt; 1);<br>
=C2=A0 =C2=A0 =C2=A0return tcg_constant_tl(slotval);<br>
=C2=A0}<br>
=C2=A0#endif<br>
@@ -458,7 +458,7 @@ static void gen_write_new_pc_addr(DisasContext *ctx, TC=
Gv addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_brcondi_tl(cond, pred, 0, pred_fa=
lse);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (ctx-&gt;pkt-&gt;pkt_has_multi_cof) {<br>
+=C2=A0 =C2=A0 if (ctx-&gt;pkt.pkt_has_multi_cof) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* If there are multiple branches in a pa=
cket, ignore the second one */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_movcond_tl(TCG_COND_NE, hex_gpr[H=
EX_REG_PC],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;branch_taken, tcg_constant_tl(0),<br>
@@ -476,8 +476,8 @@ static void gen_write_new_pc_addr(DisasContext *ctx, TC=
Gv addr,<br>
=C2=A0static void gen_write_new_pc_pcrel(DisasContext *ctx, int pc_off,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGCond cond, TCGv pre=
d)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 target_ulong dest =3D ctx-&gt;pkt-&gt;pc + pc_off;<br>
-=C2=A0 =C2=A0 if (ctx-&gt;pkt-&gt;pkt_has_multi_cof) {<br>
+=C2=A0 =C2=A0 target_ulong dest =3D ctx-&gt;pkt.pc + pc_off;<br>
+=C2=A0 =C2=A0 if (ctx-&gt;pkt.pkt_has_multi_cof) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_write_new_pc_addr(ctx, tcg_constant_t=
l(dest), cond, pred);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Defer this jump to the end of the TB *=
/<br>
@@ -528,7 +528,7 @@ static inline void gen_loop0r(DisasContext *ctx, TCGv R=
sV, int riV)<br>
=C2=A0 =C2=A0 =C2=A0fIMMEXT(riV);<br>
=C2=A0 =C2=A0 =C2=A0fPCALIGN(riV);<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC0), RsV);<=
br>
-=C2=A0 =C2=A0 tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx-&gt;pk=
t-&gt;pc + riV);<br>
+=C2=A0 =C2=A0 tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx-&gt;pk=
t.pc + riV);<br>
=C2=A0 =C2=A0 =C2=A0gen_set_usr_fieldi(ctx, USR_LPCFG, 0);<br>
=C2=A0}<br>
<br>
@@ -542,7 +542,7 @@ static inline void gen_loop1r(DisasContext *ctx, TCGv R=
sV, int riV)<br>
=C2=A0 =C2=A0 =C2=A0fIMMEXT(riV);<br>
=C2=A0 =C2=A0 =C2=A0fPCALIGN(riV);<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC1), RsV);<=
br>
-=C2=A0 =C2=A0 tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA1), ctx-&gt;pk=
t-&gt;pc + riV);<br>
+=C2=A0 =C2=A0 tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA1), ctx-&gt;pk=
t.pc + riV);<br>
=C2=A0}<br>
<br>
=C2=A0static void gen_loop1i(DisasContext *ctx, int count, int riV)<br>
@@ -555,7 +555,7 @@ static void gen_ploopNsr(DisasContext *ctx, int N, TCGv=
 RsV, int riV)<br>
=C2=A0 =C2=A0 =C2=A0fIMMEXT(riV);<br>
=C2=A0 =C2=A0 =C2=A0fPCALIGN(riV);<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC0), RsV);<=
br>
-=C2=A0 =C2=A0 tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx-&gt;pk=
t-&gt;pc + riV);<br>
+=C2=A0 =C2=A0 tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx-&gt;pk=
t.pc + riV);<br>
=C2=A0 =C2=A0 =C2=A0gen_set_usr_fieldi(ctx, USR_LPCFG, N);<br>
=C2=A0 =C2=A0 =C2=A0gen_pred_write(ctx, 3, tcg_constant_tl(0));<br>
=C2=A0}<br>
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c<br>
index e88e19cc1a..b06ed154f3 100644<br>
--- a/target/hexagon/translate.c<br>
+++ b/target/hexagon/translate.c<br>
@@ -156,8 +156,6 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_=
slot_idx,<br>
<br>
=C2=A0static void gen_end_tb(DisasContext *ctx)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 Packet *pkt =3D ctx-&gt;pkt;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0gen_exec_counters(ctx);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (ctx-&gt;branch_cond !=3D TCG_COND_NEVER) {<br>
@@ -171,7 +169,7 @@ static void gen_end_tb(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_goto_tb(ctx, 0, ctx-&gt=
;branch_dest, true);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} else if (ctx-&gt;is_tight_loop &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkt-&gt;insn[pkt-&g=
t;num_insns - 1].opcode =3D=3D J2_endloop0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;pkt.insn[ct=
x-&gt;pkt.num_insns - 1].opcode =3D=3D J2_endloop0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * When we&#39;re in a tight loop, we def=
er the endloop0 processing<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * to take advantage of direct block chai=
ning<br>
@@ -252,11 +250,9 @@ static bool need_slot_cancelled(Packet *pkt)<br>
<br>
=C2=A0static bool need_next_PC(DisasContext *ctx)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 Packet *pkt =3D ctx-&gt;pkt;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0/* Check for conditional control flow or HW loop end */=
<br>
-=C2=A0 =C2=A0 for (int i =3D 0; i &lt; pkt-&gt;num_insns; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t opcode =3D pkt-&gt;insn[i].opcode;<br=
>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; ctx-&gt;pkt.num_insns; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t opcode =3D ctx-&gt;pkt.insn[i].opcode=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (GET_ATTRIB(opcode, A_CONDEXEC) &amp;&=
amp; GET_ATTRIB(opcode, A_COF)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -339,8 +335,6 @@ static bool pkt_raises_exception(Packet *pkt)<br>
<br>
=C2=A0static bool need_commit(DisasContext *ctx)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 Packet *pkt =3D ctx-&gt;pkt;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * If the short-circuit property is set to false, we&#3=
9;ll always do the commit<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
@@ -348,7 +342,7 @@ static bool need_commit(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (pkt_raises_exception(pkt)) {<br>
+=C2=A0 =C2=A0 if (pkt_raises_exception(&amp;ctx-&gt;pkt)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -395,11 +389,10 @@ static void mark_implicit_writes(DisasContext *ctx)<b=
r>
<br>
=C2=A0static void analyze_packet(DisasContext *ctx)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 Packet *pkt =3D ctx-&gt;pkt;<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;read_after_write =3D false;<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;has_hvx_overlap =3D false;<br>
-=C2=A0 =C2=A0 for (int i =3D 0; i &lt; pkt-&gt;num_insns; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Insn *insn =3D &amp;pkt-&gt;insn[i];<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; ctx-&gt;pkt.num_insns; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Insn *insn =3D &amp;ctx-&gt;pkt.insn[i];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;insn =3D insn;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (opcode_analyze[insn-&gt;opcode]) {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0opcode_analyze[insn-&gt;opc=
ode](ctx);<br>
@@ -411,8 +404,7 @@ static void analyze_packet(DisasContext *ctx)<br>
<br>
=C2=A0static void gen_start_packet(DisasContext *ctx)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 Packet *pkt =3D ctx-&gt;pkt;<br>
-=C2=A0 =C2=A0 target_ulong next_PC =3D ctx-&gt;base.pc_next + pkt-&gt;enco=
d_pkt_size_in_bytes;<br>
+=C2=A0 =C2=A0 target_ulong next_PC =3D ctx-&gt;base.pc_next + ctx-&gt;pkt.=
encod_pkt_size_in_bytes;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Clear out the disassembly context */<br>
@@ -454,13 +446,13 @@ static void gen_start_packet(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0bitmap_zero(ctx-&gt;pregs_written, NUM_PREGS);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Initialize the runtime state for packet semantics */=
<br>
-=C2=A0 =C2=A0 if (need_slot_cancelled(pkt)) {<br>
+=C2=A0 =C2=A0 if (need_slot_cancelled(&amp;ctx-&gt;pkt)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_movi_tl(hex_slot_cancelled, 0);<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;branch_taken =3D NULL;<br>
-=C2=A0 =C2=A0 if (pkt-&gt;pkt_has_cof) {<br>
+=C2=A0 =C2=A0 if (ctx-&gt;pkt.pkt_has_cof) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;branch_taken =3D tcg_temp_new();<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pkt-&gt;pkt_has_multi_cof) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ctx-&gt;pkt.pkt_has_multi_cof) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_movi_tl(ctx-&gt;bra=
nch_taken, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (need_next_PC(ctx)) {<br>
@@ -489,7 +481,7 @@ static void gen_start_packet(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0 * Preload the predicated pred registers into ctx-&gt;n=
ew_pred_value[pred_num]<br>
=C2=A0 =C2=A0 =C2=A0 * Only endloop instructions conditionally write to pre=
d registers<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 if (ctx-&gt;need_commit &amp;&amp; pkt-&gt;pkt_has_endloop) =
{<br>
+=C2=A0 =C2=A0 if (ctx-&gt;need_commit &amp;&amp; ctx-&gt;pkt.pkt_has_endlo=
op) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ctx-&gt;preg_log_idx=
; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int pred_num =3D ctx-&gt;pr=
eg_log[i];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;new_pred_value[pred=
_num] =3D tcg_temp_new();<br>
@@ -528,13 +520,11 @@ static void gen_start_packet(DisasContext *ctx)<br>
<br>
=C2=A0bool is_gather_store_insn(DisasContext *ctx)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 Packet *pkt =3D ctx-&gt;pkt;<br>
-=C2=A0 =C2=A0 Insn *insn =3D ctx-&gt;insn;<br>
-=C2=A0 =C2=A0 if (GET_ATTRIB(insn-&gt;opcode, A_CVI_NEW) &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 insn-&gt;new_value_producer_slot =3D=3D 1) {<b=
r>
+=C2=A0 =C2=A0 if (GET_ATTRIB(ctx-&gt;insn-&gt;opcode, A_CVI_NEW) &amp;&amp=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;insn-&gt;new_value_producer_slot =3D=
=3D 1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Look for gather instruction */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i &lt; pkt-&gt;num_insns; i+=
+) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Insn *in =3D &amp;pkt-&gt;insn[i=
];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i &lt; ctx-&gt;pkt.num_insns=
; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Insn *in =3D &amp;ctx-&gt;pkt.in=
sn[i];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (GET_ATTRIB(in-&gt;opcod=
e, A_CVI_GATHER) &amp;&amp; in-&gt;slot =3D=3D 1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -637,7 +627,7 @@ static bool slot_is_predicated(Packet *pkt, int slot_nu=
m)<br>
<br>
=C2=A0void process_store(DisasContext *ctx, int slot_num)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 bool is_predicated =3D slot_is_predicated(ctx-&gt;pkt, slot_=
num);<br>
+=C2=A0 =C2=A0 bool is_predicated =3D slot_is_predicated(&amp;ctx-&gt;pkt, =
slot_num);<br>
=C2=A0 =C2=A0 =C2=A0TCGLabel *label_end =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
@@ -714,13 +704,12 @@ static void process_store_log(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0 *=C2=A0 slot 1 and then slot 0.=C2=A0 This will be imp=
ortant when<br>
=C2=A0 =C2=A0 =C2=A0 *=C2=A0 the memory accesses overlap.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 Packet *pkt =3D ctx-&gt;pkt;<br>
-=C2=A0 =C2=A0 if (pkt-&gt;pkt_has_scalar_store_s1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(!pkt-&gt;pkt_has_dczeroa);<br>
+=C2=A0 =C2=A0 if (ctx-&gt;pkt.pkt_has_scalar_store_s1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(!ctx-&gt;pkt.pkt_has_dczeroa);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process_store(ctx, 1);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (pkt-&gt;pkt_has_scalar_store_s0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(!pkt-&gt;pkt_has_dczeroa);<br>
+=C2=A0 =C2=A0 if (ctx-&gt;pkt.pkt_has_scalar_store_s0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(!ctx-&gt;pkt.pkt_has_dczeroa);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process_store(ctx, 0);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
@@ -728,7 +717,7 @@ static void process_store_log(DisasContext *ctx)<br>
=C2=A0/* Zero out a 32-bit cache line */<br>
=C2=A0static void process_dczeroa(DisasContext *ctx)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if (ctx-&gt;pkt-&gt;pkt_has_dczeroa) {<br>
+=C2=A0 =C2=A0 if (ctx-&gt;pkt.pkt_has_dczeroa) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Store 32 bytes of zero starting at (ad=
dr &amp; ~0x1f) */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv addr =3D tcg_temp_new();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_i64 zero =3D tcg_constant_i64(0);<br=
>
@@ -762,7 +751,7 @@ static void gen_commit_hvx(DisasContext *ctx)<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Early exit if not needed */<br>
=C2=A0 =C2=A0 =C2=A0if (!ctx-&gt;need_commit) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(!pkt_has_hvx_store(ctx-&gt;pkt));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(!pkt_has_hvx_store(&amp;ctx-&gt;pkt))=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -796,25 +785,23 @@ static void gen_commit_hvx(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_gvec_mov(MO_64, dstoff, srcoff, s=
ize, size);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (pkt_has_hvx_store(ctx-&gt;pkt)) {<br>
+=C2=A0 =C2=A0 if (pkt_has_hvx_store(&amp;ctx-&gt;pkt)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_helper_commit_hvx_stores(tcg_env);<br=
>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
=C2=A0static void update_exec_counters(DisasContext *ctx)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 Packet *pkt =3D ctx-&gt;pkt;<br>
-=C2=A0 =C2=A0 int num_insns =3D pkt-&gt;num_insns;<br>
=C2=A0 =C2=A0 =C2=A0int num_real_insns =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int num_hvx_insns =3D 0;<br>
<br>
-=C2=A0 =C2=A0 for (int i =3D 0; i &lt; num_insns; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pkt-&gt;insn[i].is_endloop &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !pkt-&gt;insn[i].part1 &amp;&amp=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !GET_ATTRIB(pkt-&gt;insn[i].opco=
de, A_IT_NOP)) {<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; ctx-&gt;pkt.num_insns; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ctx-&gt;pkt.insn[i].is_endloop &amp;&amp;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !ctx-&gt;pkt.insn[i].part1 &amp;=
&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !GET_ATTRIB(ctx-&gt;pkt.insn[i].=
opcode, A_IT_NOP)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_real_insns++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (GET_ATTRIB(pkt-&gt;insn[i].opcode, A_CVI))=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (GET_ATTRIB(ctx-&gt;pkt.insn[i].opcode, A_C=
VI)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_hvx_insns++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -843,12 +830,11 @@ static void gen_commit_packet(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0 * store.=C2=A0 Therefore, we call process_store_log be=
fore anything else<br>
=C2=A0 =C2=A0 =C2=A0 * involved in committing the packet.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 Packet *pkt =3D ctx-&gt;pkt;<br>
-=C2=A0 =C2=A0 bool has_store_s0 =3D pkt-&gt;pkt_has_scalar_store_s0;<br>
+=C2=A0 =C2=A0 bool has_store_s0 =3D ctx-&gt;pkt.pkt_has_scalar_store_s0;<b=
r>
=C2=A0 =C2=A0 =C2=A0bool has_store_s1 =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (pkt-&gt;pkt_has_scalar_store_s1 &amp;&amp; !c=
tx-&gt;s1_store_processed);<br>
-=C2=A0 =C2=A0 bool has_hvx_store =3D pkt_has_hvx_store(pkt);<br>
-=C2=A0 =C2=A0 if (pkt-&gt;pkt_has_dczeroa) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (ctx-&gt;pkt.pkt_has_scalar_store_s1 &amp;&amp=
; !ctx-&gt;s1_store_processed);<br>
+=C2=A0 =C2=A0 bool has_hvx_store =3D pkt_has_hvx_store(&amp;ctx-&gt;pkt);<=
br>
+=C2=A0 =C2=A0 if (ctx-&gt;pkt.pkt_has_dczeroa) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The dczeroa will be the store in slot =
0, check that we don&#39;t have<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * a store in slot 1 or an HVX store.<br>
@@ -875,12 +861,11 @@ static void gen_commit_packet(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0FIELD_DP32(mask, PROBE_PKT_SCALAR_HVX_STORES,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HAS_HVX_STORES, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (has_store_s0 &amp;&amp; slot=
_is_predicated(pkt, 0)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FIEL=
D_DP32(mask, PROBE_PKT_SCALAR_HVX_STORES,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0S0_IS_PRED, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (has_store_s0 &amp;&amp; slot=
_is_predicated(&amp;ctx-&gt;pkt, 0)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D FIELD_DP3=
2(mask, PROBE_PKT_SCALAR_HVX_STORES, S0_IS_PRED,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (has_store_s1 &amp;&amp; slot=
_is_predicated(pkt, 1)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (has_store_s1 &amp;&amp; slot=
_is_predicated(&amp;ctx-&gt;pkt, 1)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mask =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0FIELD_DP32(mask, PROBE_PKT_SCALAR_HVX_STORES,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 S1_IS_PRED, 1);<br>
@@ -898,7 +883,7 @@ static void gen_commit_packet(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int args =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FIELD_DP32(args, PROBE_PKT_=
SCALAR_STORE_S0, MMU_IDX, ctx-&gt;mem_idx);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (slot_is_predicated(pkt, 0)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (slot_is_predicated(&amp;ctx-&gt;pkt, 0)) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FIELD_DP32(ar=
gs, PROBE_PKT_SCALAR_STORE_S0, IS_PREDICATED, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -910,18 +895,18 @@ static void gen_commit_packet(DisasContext *ctx)<br>
<br>
=C2=A0 =C2=A0 =C2=A0gen_reg_writes(ctx);<br>
=C2=A0 =C2=A0 =C2=A0gen_pred_writes(ctx);<br>
-=C2=A0 =C2=A0 if (pkt-&gt;pkt_has_hvx) {<br>
+=C2=A0 =C2=A0 if (ctx-&gt;pkt.pkt_has_hvx) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_commit_hvx(ctx);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0update_exec_counters(ctx);<br>
<br>
-=C2=A0 =C2=A0 if (pkt-&gt;vhist_insn !=3D NULL) {<br>
+=C2=A0 =C2=A0 if (ctx-&gt;pkt.vhist_insn !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;pre_commit =3D false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;insn =3D pkt-&gt;vhist_insn;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkt-&gt;vhist_insn-&gt;generate(ctx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;insn =3D ctx-&gt;pkt.vhist_insn;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;pkt.vhist_insn-&gt;generate(ctx);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (pkt-&gt;pkt_has_cof) {<br>
+=C2=A0 =C2=A0 if (ctx-&gt;pkt.pkt_has_cof) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_end_tb(ctx);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
@@ -930,7 +915,6 @@ static void decode_and_translate_packet(CPUHexagonState=
 *env, DisasContext *ctx)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t words[PACKET_WORDS_MAX];<br>
=C2=A0 =C2=A0 =C2=A0int nwords;<br>
-=C2=A0 =C2=A0 Packet pkt;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0nwords =3D read_packet_words(env, ctx, words);<br>
@@ -939,16 +923,15 @@ static void decode_and_translate_packet(CPUHexagonSta=
te *env, DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 ctx-&gt;pkt =3D &amp;pkt;<br>
-=C2=A0 =C2=A0 if (decode_packet(ctx, nwords, words, &amp;pkt, false) &gt; =
0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkt.pc =3D ctx-&gt;base.pc_next;<br>
+=C2=A0 =C2=A0 if (decode_packet(ctx, nwords, words, &amp;ctx-&gt;pkt, fals=
e) &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;pkt.pc =3D ctx-&gt;base.pc_next;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_start_packet(ctx);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; pkt.num_insns; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;insn =3D &amp;pkt.insn[i=
];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; ctx-&gt;pkt.num_insns; i+=
+) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;insn =3D &amp;ctx-&gt;pk=
t.insn[i];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_insn(ctx);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_commit_packet(ctx);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;base.pc_next +=3D pkt.encod_pkt_size_i=
n_bytes;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;base.pc_next +=3D ctx-&gt;pkt.encod_pk=
t_size_in_bytes;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_exception_end_tb(ctx, HEX_CAUSE_INVAL=
ID_PACKET);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs=
.py<br>
index 87b7f10d7f..e7f90a0da1 100755<br>
--- a/target/hexagon/gen_tcg_funcs.py<br>
+++ b/target/hexagon/gen_tcg_funcs.py<br>
@@ -72,7 +72,7 @@ def gen_tcg_func(f, tag, regs, imms):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for immlett, bits, immshift in imms:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0declared.append(hex_common.=
imm_name(immlett))<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 arguments =3D &quot;, &quot;.join([&quot;ctx&q=
uot;, &quot;ctx-&gt;insn&quot;, &quot;ctx-&gt;pkt&quot;] + declared)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 arguments =3D &quot;, &quot;.join([&quot;ctx&q=
uot;, &quot;ctx-&gt;insn&quot;, &quot;&amp;ctx-&gt;pkt&quot;] + declared)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(f&quot;=C2=A0 =C2=A0 emit_{tag}({=
arguments});\n&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0elif hex_common.skip_qemu_helper(tag):<br>
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py<br=
>
index c0e9f26aeb..e37d5a514f 100755<br>
--- a/target/hexagon/hex_common.py<br>
+++ b/target/hexagon/hex_common.py<br>
@@ -1144,7 +1144,7 @@ def helper_args(tag, regs, imms):<br>
=C2=A0 =C2=A0 =C2=A0if need_pkt_has_multi_cof(tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args.append(HelperArg(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;i32&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tcg_constant_tl(ctx-&gt;pk=
t-&gt;pkt_has_multi_cof)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tcg_constant_tl(ctx-&gt;pk=
t.pkt_has_multi_cof)&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;uint32_t pkt_has_mult=
i_cof&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0))<br>
=C2=A0 =C2=A0 =C2=A0if need_pkt_need_commit(tag):<br>
@@ -1156,7 +1156,7 @@ def helper_args(tag, regs, imms):<br>
=C2=A0 =C2=A0 =C2=A0if need_PC(tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args.append(HelperArg(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;i32&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tcg_constant_tl(ctx-&gt;pk=
t-&gt;pc)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tcg_constant_tl(ctx-&gt;pk=
t.pc)&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;target_ulong PC&quot;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0))<br>
=C2=A0 =C2=A0 =C2=A0if need_next_PC(tag):<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--0000000000002b03ad064cc8ca4f--

