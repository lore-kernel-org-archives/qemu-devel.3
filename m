Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522FFD1CDAC
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 23:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQwPG-0007Gm-T4; Wed, 03 Dec 2025 18:37:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vQwPE-0007G8-Bi
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 18:37:08 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vQwPC-0001Ai-4E
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 18:37:08 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B3MShEj1536507
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 23:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=yMr7Vw3Ceb5+UKTxz0br2Fem
 G0e5fLQAqyNp6p8Q5pg=; b=pb7J1+IMbjBosElsFLCcq8AwgtJdrD4I9Fx7gBag
 FeGpWavZT7DvpbnYl7NkAV/KU1oSuh74aiFt0TvcAh2/TTlPuixrYHMVQ81nY5cN
 xgyMA1iYK2E4XJLH2by+ZnxRfdiJKIBpucLlDgEPwvKe+2wHWyI/DhVcx1g7irJi
 th3iwLOAei9NRKl8FE+sq/RdjHfabkT4RBjpDPSi00PcOCESajDEqI1Vrsmgx3E4
 TOK2RoZpXiiP2J4WTFQJlXqoFNIiDhtPl3Gp52kKaSkijSuv0qf/vVfDtbq4DQYz
 iuo2J//bygDYEBqGvRnvGmusZGWimvnMPU2qB/Pktb+NHg==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atm0ht2vx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 23:37:03 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-78817da4711so5619707b3.3
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 15:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1764805023; x=1765409823; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yMr7Vw3Ceb5+UKTxz0br2FemG0e5fLQAqyNp6p8Q5pg=;
 b=eOZy2Ja/L/FJAZNSXcHVK9boGlAtGW99o0wR6G231sqaCbFIWfVeyAHUHpqxvS+ilG
 JOjcLPrXnpL61YSZJWooHHwsZwuPC93t+OM9qqnl6T5tqwrZZyNi9DxBQOfkJJSfl1RX
 v4KwWyNiXcy6KBwcZdrPfnT5WS3JDLNjtkzjscg2AF1xck1XAARVyxibg5Z/4vMyL61/
 LHzdtEmpuDrSt5SizPuXWJRO+k/lf41CbzYhi8wZ/3xuCEIdYrpa0doFhS2XJrsaZ1x7
 vRwnUfWX80hJ294peiBeXB196EHLeqVJgO3iQKLAlUs61NeJ3/Nxoo+ow1qg5vNuy4NQ
 /R/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764805023; x=1765409823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMr7Vw3Ceb5+UKTxz0br2FemG0e5fLQAqyNp6p8Q5pg=;
 b=oTIqNSzJFdVydZD3kh4Sm679hAsrs4k5gjMb6jCqTxZGL5wEo46tut+LCpAB0QgW0c
 dj95ZwH1lhCX4+WyqsO2eC/9cG+AVEzDWruA6taW5c1jxn/h1iIIYxfyrBzYWU/s0MUL
 NevZDfdTwlCcyGiJpH7aeemmgxSs4yy99fBnvTEnqTBEE9uBDfa8/4PagS58mklNQno/
 KOFhVdXjvTUvr7h3uVdQbmChpIdgm/qjmVuXMngDV3HU75G9Q4Sd8OlChukI/tKak42k
 rLmKVvj0JdMPucKVuKe4zdgud0sFTCj5WVEGlEZhVAK46/xG4I24BNB/93gsc7dz7lWL
 geHw==
X-Gm-Message-State: AOJu0YwNE81E361xGlvMImpbftNtUDf/84zeAdOYgFe/NE2qnYnkxWkU
 6hnGS6WsajhAgFCDvCfiL1YFLGoQYZv9uWgsqEbjcPOY4uZG4f1J8FU+Dav+mXD9IcrMxq1ss13
 IioAyvT2072g30OP/8P6ppJV2vDbja/ZY70lnc+lbrPvLMz+Awi3ziwtmEZZhqJv56sFYkuLIK7
 lsSqH0pyzrt/C5qWu7opkC4crUVSlrqE/86VoWUK2Q588=
X-Gm-Gg: ASbGncs4uE8wlpyjP2uAgnNc/A5U8JMogO1vNMuEWDsI6ZgeHMPXDEM90NnzUo7QrFt
 k3WuCaI6N2RsA0I6KHQUoJ5TfraVS+h9zEegl7K8vXNlzlIbaVnfJxHGcMrtM0Pbqf07Jrn8o8/
 xAxmNdcvLGGefslO3QL0VqJaQpPjRTz2FrR9xl7eKtknzoGSSm8AcXuwK6NICo+919B6JR1q9ER
 oGPyCnCCGABDPyEHJjbTzrISbo=
X-Received: by 2002:a05:690c:660c:b0:786:61c6:7e57 with SMTP id
 00721157ae682-78c0bff94famr36822917b3.42.1764805022657; 
 Wed, 03 Dec 2025 15:37:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2pVWQ2nSHXOuOutMrXBO44hsBef4WLrGj6DfIHxZEqMI89i75vOygokBLyDu8IVhrPh8gqxQOX1kz2RdkscA=
X-Received: by 2002:a05:690c:660c:b0:786:61c6:7e57 with SMTP id
 00721157ae682-78c0bff94famr36822747b3.42.1764805022245; Wed, 03 Dec 2025
 15:37:02 -0800 (PST)
MIME-Version: 1.0
References: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
 <20251114230013.158098-3-ltaylorsimpson@gmail.com>
In-Reply-To: <20251114230013.158098-3-ltaylorsimpson@gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 3 Dec 2025 17:36:49 -0600
X-Gm-Features: AWmQ_bnnyD2lCp9ht33R622x8QZlEVooJ6WxWhi2oXye069W6fa14uu_edgcbAY
Message-ID: <CAEqNhNZ8wdQ1k74X2ufBi3+r6GhkG2W2Cj7HfH8+8_OCzyFn7A@mail.gmail.com>
Subject: Re: [PATCH 2/4] Hexagon (target/hexagon)
 s/gen_log_pred_write/gen_pred_write
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
Content-Type: multipart/alternative; boundary="00000000000072f609064514b065"
X-Proofpoint-ORIG-GUID: LfCkUh3_5oFsQpstlcaBwYUfe-X-SW4v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE4OCBTYWx0ZWRfX4V5g8gEmtOVT
 +PH0k+ckXunSwtjs9pSWLrTmwP5VU03LtObTjz3mL4Qa5k3G96BQgqPGQCDXcBLwM0IziIrnHqB
 CTFBW19ANo/7FmCTndQgUf9633WSUDui6Pv3XLhLHZYgF5sMvnZfGj4RCItii9R5vSss8ugaqc8
 GGSIB1tST/VWUA1cRe6Rx0lsix+4wTo58u9ZWbKbiYWBMJzlzR/bIwlWZZ20w9lE0Or0pHIbFRb
 x6eWr9pFq0RqGuEocn2M6ZNBJM855YIm8G6O09cmPcYmu17BQkui9DVp4bLdazrjn2z5bTFS1JP
 +uRsYt+9eZUBUbJ2tdtSieLfiTGhp8DJWESrn4XyHB/tAnQMaaVv9noGnlNa8DSOqVkYcUWsA7P
 Ar3Wya5oPJEQ9ocJIC2GiGeGTGiSiw==
X-Proofpoint-GUID: LfCkUh3_5oFsQpstlcaBwYUfe-X-SW4v
X-Authority-Analysis: v=2.4 cv=V5lwEOni c=1 sm=1 tr=0 ts=6930c99f cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=DeMdU55MHGWuzAfkZSUA:9 a=QEXdDO2ut3YA:10 a=hUoHwt2IWzEh9g5Gs6AA:9
 a=iTSsRrpuIL8w7IK8:21 a=lqcHg5cX4UMA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_03,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030188
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000072f609064514b065
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 5:00=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com>
wrote:

> The function doesn't "log" anything, it just generates the write
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  target/hexagon/gen_tcg.h                    |  4 ++--
>  target/hexagon/genptr.h                     |  2 +-
>  target/hexagon/genptr.c                     | 14 +++++++-------
>  target/hexagon/idef-parser/parser-helpers.c |  2 +-
>  target/hexagon/hex_common.py                |  4 ++--
>  5 files changed, 13 insertions(+), 13 deletions(-)
>
>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>



> diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
> index 10123336b1..60f3d295da 100644
> --- a/target/hexagon/gen_tcg.h
> +++ b/target/hexagon/gen_tcg.h
> @@ -599,7 +599,7 @@
>          TCGv p0 =3D tcg_temp_new(); \
>          gen_helper_cabacdecbin_pred(p0, RssV, RttV); \
>          gen_helper_cabacdecbin_val(RddV, RssV, RttV); \
> -        gen_log_pred_write(ctx, 0, p0); \
> +        gen_pred_write(ctx, 0, p0); \
>      } while (0)
>
>  /*
> @@ -914,7 +914,7 @@
>      do { \
>          TCGv p0 =3D tcg_temp_new(); \
>          gen_comparei(TCG_COND_EQ, p0, RsV, uiV); \
> -        gen_log_pred_write(ctx, 0, p0); \
> +        gen_pred_write(ctx, 0, p0); \
>      } while (0)
>
>  #define fGEN_TCG_J2_jump(SHORTCODE) \
> diff --git a/target/hexagon/genptr.h b/target/hexagon/genptr.h
> index d932255042..228d7f1d7d 100644
> --- a/target/hexagon/genptr.h
> +++ b/target/hexagon/genptr.h
> @@ -37,7 +37,7 @@ TCGv gen_read_reg(TCGv result, int num);
>  TCGv gen_read_preg(TCGv pred, uint8_t num);
>  TCGv get_result_gpr(DisasContext *ctx, int rnum);
>  TCGv get_result_pred(DisasContext *ctx, int pnum);
> -void gen_log_pred_write(DisasContext *ctx, int pnum, TCGv val);
> +void gen_pred_write(DisasContext *ctx, int pnum, TCGv val);
>  void gen_set_usr_field(DisasContext *ctx, int field, TCGv val);
>  void gen_set_usr_fieldi(DisasContext *ctx, int field, int x);
>  void gen_set_usr_field_if(DisasContext *ctx, int field, TCGv val);
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index e58021ed6c..bfbbd61c33 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -120,7 +120,7 @@ TCGv get_result_pred(DisasContext *ctx, int pnum)
>      }
>  }
>
> -void gen_log_pred_write(DisasContext *ctx, int pnum, TCGv val)
> +void gen_pred_write(DisasContext *ctx, int pnum, TCGv val)
>  {
>      TCGv pred =3D get_result_pred(ctx, pnum);
>      TCGv base_val =3D tcg_temp_new();
> @@ -215,7 +215,7 @@ static void gen_write_p3_0(DisasContext *ctx, TCGv
> control_reg)
>      TCGv hex_p8 =3D tcg_temp_new();
>      for (int i =3D 0; i < NUM_PREGS; i++) {
>          tcg_gen_extract_tl(hex_p8, control_reg, i * 8, 8);
> -        gen_log_pred_write(ctx, i, hex_p8);
> +        gen_pred_write(ctx, i, hex_p8);
>      }
>  }
>
> @@ -557,7 +557,7 @@ static void gen_ploopNsr(DisasContext *ctx, int N,
> TCGv RsV, int riV)
>      tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC0), RsV);
>      tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx->pkt->pc + riV=
);
>      gen_set_usr_fieldi(ctx, USR_LPCFG, N);
> -    gen_log_pred_write(ctx, 3, tcg_constant_tl(0));
> +    gen_pred_write(ctx, 3, tcg_constant_tl(0));
>  }
>
>  static void gen_ploopNsi(DisasContext *ctx, int N, int count, int riV)
> @@ -597,7 +597,7 @@ static void gen_cmpnd_cmp_jmp(DisasContext *ctx,
>      if (ctx->insn->part1) {
>          TCGv pred =3D tcg_temp_new();
>          gen_compare(cond1, pred, arg1, arg2);
> -        gen_log_pred_write(ctx, pnum, pred);
> +        gen_pred_write(ctx, pnum, pred);
>      } else {
>          TCGv pred =3D tcg_temp_new();
>          tcg_gen_mov_tl(pred, ctx->new_pred_value[pnum]);
> @@ -654,7 +654,7 @@ static void gen_cmpnd_tstbit0_jmp(DisasContext *ctx,
>          TCGv pred =3D tcg_temp_new();
>          tcg_gen_andi_tl(pred, arg, 1);
>          gen_8bitsof(pred, pred);
> -        gen_log_pred_write(ctx, pnum, pred);
> +        gen_pred_write(ctx, pnum, pred);
>      } else {
>          TCGv pred =3D tcg_temp_new();
>          tcg_gen_mov_tl(pred, ctx->new_pred_value[pnum]);
> @@ -834,7 +834,7 @@ static void gen_endloop0(DisasContext *ctx)
>      TCGLabel *label1 =3D gen_new_label();
>      tcg_gen_brcondi_tl(TCG_COND_NE, lpcfg, 1, label1);
>      {
> -        gen_log_pred_write(ctx, 3, tcg_constant_tl(0xff));
> +        gen_pred_write(ctx, 3, tcg_constant_tl(0xff));
>      }
>      gen_set_label(label1);
>
> @@ -908,7 +908,7 @@ static void gen_endloop01(DisasContext *ctx)
>       */
>      tcg_gen_brcondi_tl(TCG_COND_NE, lpcfg, 1, label1);
>      {
> -        gen_log_pred_write(ctx, 3, tcg_constant_tl(0xff));
> +        gen_pred_write(ctx, 3, tcg_constant_tl(0xff));
>      }
>      gen_set_label(label1);
>
> diff --git a/target/hexagon/idef-parser/parser-helpers.c
> b/target/hexagon/idef-parser/parser-helpers.c
> index f5802ceadb..70bfa64432 100644
> --- a/target/hexagon/idef-parser/parser-helpers.c
> +++ b/target/hexagon/idef-parser/parser-helpers.c
> @@ -1713,7 +1713,7 @@ void gen_pred_assign(Context *c, YYLTYPE *locp,
> HexValue *left_pred,
>      /* Extract first 8 bits, and store new predicate value */
>      OUT(c, locp, "tcg_gen_andi_i32(", left_pred, ", ", &r, ", 0xff);\n")=
;
>      if (is_direct) {
> -        OUT(c, locp, "gen_log_pred_write(ctx, ", pred_id, ", ", left_pre=
d,
> +        OUT(c, locp, "gen_pred_write(ctx, ", pred_id, ", ", left_pred,
>              ");\n");
>      }
>  }
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index 093def9386..1277fec9a2 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -571,7 +571,7 @@ def decl_tcg(self, f, tag, regno):
>          """))
>      def log_write(self, f, tag):
>          f.write(code_fmt(f"""\
> -            gen_log_pred_write(ctx, {self.reg_num}, {self.reg_tcg()});
> +            gen_pred_write(ctx, {self.reg_num}, {self.reg_tcg()});
>          """))
>      def analyze_write(self, f, tag, regno):
>          f.write(code_fmt(f"""\
> @@ -608,7 +608,7 @@ def decl_tcg(self, f, tag, regno):
>          """))
>      def log_write(self, f, tag):
>          f.write(code_fmt(f"""\
> -            gen_log_pred_write(ctx, {self.reg_num}, {self.reg_tcg()});
> +            gen_pred_write(ctx, {self.reg_num}, {self.reg_tcg()});
>          """))
>      def analyze_read(self, f, regno):
>          f.write(code_fmt(f"""\
> --
> 2.43.0
>
>

--00000000000072f609064514b065
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 14,=
 2025 at 5:00=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpso=
n@gmail.com">ltaylorsimpson@gmail.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">The function doesn&#39;t &quot;log&quo=
t; anything, it just generates the write<br>
<br>
Signed-off-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.co=
m" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/gen_tcg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A0target/hexagon/genptr.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0target/hexagon/genptr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 14 +++++++-------<br>
=C2=A0target/hexagon/idef-parser/parser-helpers.c |=C2=A0 2 +-<br>
=C2=A0target/hexagon/hex_common.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A05 files changed, 13 insertions(+), 13 deletions(-)<br>
<br></blockquote><div><br></div><div><div>Reviewed-by: Brian Cain &lt;<a hr=
ef=3D"mailto:brian.cain@oss.qualcomm.com">brian.cain@oss.qualcomm.com</a>&g=
t;</div><br class=3D"gmail-Apple-interchange-newline"></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h<br>
index 10123336b1..60f3d295da 100644<br>
--- a/target/hexagon/gen_tcg.h<br>
+++ b/target/hexagon/gen_tcg.h<br>
@@ -599,7 +599,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv p0 =3D tcg_temp_new(); \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_helper_cabacdecbin_pred(p0, RssV, Rtt=
V); \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_helper_cabacdecbin_val(RddV, RssV, Rt=
tV); \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_pred_write(ctx, 0, p0); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_pred_write(ctx, 0, p0); \<br>
=C2=A0 =C2=A0 =C2=A0} while (0)<br>
<br>
=C2=A0/*<br>
@@ -914,7 +914,7 @@<br>
=C2=A0 =C2=A0 =C2=A0do { \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv p0 =3D tcg_temp_new(); \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_comparei(TCG_COND_EQ, p0, RsV, uiV); =
\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_pred_write(ctx, 0, p0); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_pred_write(ctx, 0, p0); \<br>
=C2=A0 =C2=A0 =C2=A0} while (0)<br>
<br>
=C2=A0#define fGEN_TCG_J2_jump(SHORTCODE) \<br>
diff --git a/target/hexagon/genptr.h b/target/hexagon/genptr.h<br>
index d932255042..228d7f1d7d 100644<br>
--- a/target/hexagon/genptr.h<br>
+++ b/target/hexagon/genptr.h<br>
@@ -37,7 +37,7 @@ TCGv gen_read_reg(TCGv result, int num);<br>
=C2=A0TCGv gen_read_preg(TCGv pred, uint8_t num);<br>
=C2=A0TCGv get_result_gpr(DisasContext *ctx, int rnum);<br>
=C2=A0TCGv get_result_pred(DisasContext *ctx, int pnum);<br>
-void gen_log_pred_write(DisasContext *ctx, int pnum, TCGv val);<br>
+void gen_pred_write(DisasContext *ctx, int pnum, TCGv val);<br>
=C2=A0void gen_set_usr_field(DisasContext *ctx, int field, TCGv val);<br>
=C2=A0void gen_set_usr_fieldi(DisasContext *ctx, int field, int x);<br>
=C2=A0void gen_set_usr_field_if(DisasContext *ctx, int field, TCGv val);<br=
>
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c<br>
index e58021ed6c..bfbbd61c33 100644<br>
--- a/target/hexagon/genptr.c<br>
+++ b/target/hexagon/genptr.c<br>
@@ -120,7 +120,7 @@ TCGv get_result_pred(DisasContext *ctx, int pnum)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-void gen_log_pred_write(DisasContext *ctx, int pnum, TCGv val)<br>
+void gen_pred_write(DisasContext *ctx, int pnum, TCGv val)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TCGv pred =3D get_result_pred(ctx, pnum);<br>
=C2=A0 =C2=A0 =C2=A0TCGv base_val =3D tcg_temp_new();<br>
@@ -215,7 +215,7 @@ static void gen_write_p3_0(DisasContext *ctx, TCGv cont=
rol_reg)<br>
=C2=A0 =C2=A0 =C2=A0TCGv hex_p8 =3D tcg_temp_new();<br>
=C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; NUM_PREGS; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_extract_tl(hex_p8, control_reg, i=
 * 8, 8);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_pred_write(ctx, i, hex_p8);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_pred_write(ctx, i, hex_p8);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -557,7 +557,7 @@ static void gen_ploopNsr(DisasContext *ctx, int N, TCGv=
 RsV, int riV)<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC0), RsV);<=
br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx-&=
gt;pkt-&gt;pc + riV);<br>
=C2=A0 =C2=A0 =C2=A0gen_set_usr_fieldi(ctx, USR_LPCFG, N);<br>
-=C2=A0 =C2=A0 gen_log_pred_write(ctx, 3, tcg_constant_tl(0));<br>
+=C2=A0 =C2=A0 gen_pred_write(ctx, 3, tcg_constant_tl(0));<br>
=C2=A0}<br>
<br>
=C2=A0static void gen_ploopNsi(DisasContext *ctx, int N, int count, int riV=
)<br>
@@ -597,7 +597,7 @@ static void gen_cmpnd_cmp_jmp(DisasContext *ctx,<br>
=C2=A0 =C2=A0 =C2=A0if (ctx-&gt;insn-&gt;part1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv pred =3D tcg_temp_new();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_compare(cond1, pred, arg1, arg2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_pred_write(ctx, pnum, pred);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_pred_write(ctx, pnum, pred);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv pred =3D tcg_temp_new();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_mov_tl(pred, ctx-&gt;new_pred_val=
ue[pnum]);<br>
@@ -654,7 +654,7 @@ static void gen_cmpnd_tstbit0_jmp(DisasContext *ctx,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv pred =3D tcg_temp_new();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_andi_tl(pred, arg, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_8bitsof(pred, pred);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_pred_write(ctx, pnum, pred);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_pred_write(ctx, pnum, pred);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv pred =3D tcg_temp_new();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_mov_tl(pred, ctx-&gt;new_pred_val=
ue[pnum]);<br>
@@ -834,7 +834,7 @@ static void gen_endloop0(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0TCGLabel *label1 =3D gen_new_label();<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_brcondi_tl(TCG_COND_NE, lpcfg, 1, label1);<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_pred_write(ctx, 3, tcg_constant_tl(0xf=
f));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_pred_write(ctx, 3, tcg_constant_tl(0xff));=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0gen_set_label(label1);<br>
<br>
@@ -908,7 +908,7 @@ static void gen_endloop01(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_brcondi_tl(TCG_COND_NE, lpcfg, 1, label1);<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_pred_write(ctx, 3, tcg_constant_tl(0xf=
f));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_pred_write(ctx, 3, tcg_constant_tl(0xff));=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0gen_set_label(label1);<br>
<br>
diff --git a/target/hexagon/idef-parser/parser-helpers.c b/target/hexagon/i=
def-parser/parser-helpers.c<br>
index f5802ceadb..70bfa64432 100644<br>
--- a/target/hexagon/idef-parser/parser-helpers.c<br>
+++ b/target/hexagon/idef-parser/parser-helpers.c<br>
@@ -1713,7 +1713,7 @@ void gen_pred_assign(Context *c, YYLTYPE *locp, HexVa=
lue *left_pred,<br>
=C2=A0 =C2=A0 =C2=A0/* Extract first 8 bits, and store new predicate value =
*/<br>
=C2=A0 =C2=A0 =C2=A0OUT(c, locp, &quot;tcg_gen_andi_i32(&quot;, left_pred, =
&quot;, &quot;, &amp;r, &quot;, 0xff);\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0if (is_direct) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 OUT(c, locp, &quot;gen_log_pred_write(ctx, &qu=
ot;, pred_id, &quot;, &quot;, left_pred,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 OUT(c, locp, &quot;gen_pred_write(ctx, &quot;,=
 pred_id, &quot;, &quot;, left_pred,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;);\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py<br=
>
index 093def9386..1277fec9a2 100755<br>
--- a/target/hexagon/hex_common.py<br>
+++ b/target/hexagon/hex_common.py<br>
@@ -571,7 +571,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def log_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_pred_write(ctx, {self.re=
g_num}, {self.reg_tcg()});<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_pred_write(ctx, {self.reg_nu=
m}, {self.reg_tcg()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def analyze_write(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
@@ -608,7 +608,7 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def log_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_pred_write(ctx, {self.re=
g_num}, {self.reg_tcg()});<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_pred_write(ctx, {self.reg_nu=
m}, {self.reg_tcg()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def analyze_read(self, f, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--00000000000072f609064514b065--

