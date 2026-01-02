Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E08EED628
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 17:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbj6W-0002lW-In; Fri, 02 Jan 2026 12:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vbj6T-0002kt-9I
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 12:38:21 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vbj6R-0000QK-3W
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 12:38:21 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6029VwFj784381
 for <qemu-devel@nongnu.org>; Fri, 2 Jan 2026 17:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=cSiMVynS1K2jXxCVGNwZfi2I
 QH8ie/GeCr7aIcWPkFI=; b=WLq/TXQ3MP4a2LRa2VnR4/mk2JjNodvwVHdWeLkp
 rAOa4neRtmjMn/maNGzfXDmYy7HE3THdrjyT/bShtRF7/6KV0/Gx/6xwo0nAniMr
 Qo8Evi7e+g+B+RxgXc6W9vsuv4l8Q6iLP1EJRkxMvi19uaIfAEKt1IIFQA4j2uRF
 XOruviNRNvhjq9YoG9iUJQjC8Xvm1eHflKjcnt+bz5e0ePxamLGLjzEPBlyi2IvG
 veBXztg63CmJhRFxv4B7DT/j/vJY4S7ZbF76tAntZV3dYGB3XgCrP8If1F2S6OZD
 V6JAdOCO+RiBtYMi3R9exRCdjyDkAhL1CZGwv4gxbqDXBQ==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd7vtkyt8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 17:38:13 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-64695f90497so9272455d50.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 09:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767375493; x=1767980293; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cSiMVynS1K2jXxCVGNwZfi2IQH8ie/GeCr7aIcWPkFI=;
 b=Zb+1/8ng1HwoJ7P59I1BshRvfazjam+Yi8Qx1xltu2MOqgjVeQERh5Ud5fq7QFk4s6
 Po4nj5+SzsxClxUm3ywUKPRb2g5o9q1DCFCZdIivTzy3Q+11W1pQyR71VXrwMVzetaMK
 mWb9poe6kR9WOIrcS8F0kN3eV3aVp/wcP2iiQoTZ37hxDIDxC2R9mwgrHunHrrUcM6Mv
 fxZOCLnTExtWS61sIGYwlBxeE14VRNQNDLJBL/9HK1FTejolACs2OvOR5b0PIVSjxmEw
 1fwAZ68oNuBwUj+NJTrG4DnNkxzy4O8QXq8gvO6i2bmyu0mmQ9LOKbFqpVSRn19LEmsa
 vFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767375493; x=1767980293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cSiMVynS1K2jXxCVGNwZfi2IQH8ie/GeCr7aIcWPkFI=;
 b=YzFFe0cTs7cShNDeu8P0qhOoIw8LhgN0rQ01BpMLntxpIfgWLpCKwjqdMdmWE/Mfai
 X0XCY2ajbJNyLYjdGWSyWEZOqjVx/NTkMnU5GH0eb1PJCT+Z3J3i0MWHpQtqPrKDAKwS
 lmVOCfl4heKbM6rGJz13uEH1KrHmfunzI79/B2yZxXa8rWx5eazOm9WUyzQULLye+jii
 bJ2qJH6Exur9sEAK6hpGdwGgqc3QxiiwCYuwH96cNdApsU4Ui0G3+pZk3uJfhL8aRsTl
 NHuFhx4LCWhjN4ICD48nR0p9OytHSv13dWAqFIO4eHYsnNo1guTP3qOc1/A0LjCcPwbE
 cdNg==
X-Gm-Message-State: AOJu0YzPLRwJ5yDvEvQvDzfKS7LRTLI+6gcRJTCAvqSkzdzt9TkMrhlB
 ckcZnFj4cP1eLywDo7hUNNFF75GwnKkpO+2w9mzK61q02rgOrROtkwHolGjsnqaOZns4Ob1Bnqz
 +KNh39l9EKZsOWTxUi4NTi3VFk4BuczshX4GUYE5Iu6enNrFncutD47enJs6GJq1F4G0VMXZixl
 okIbcaB64K6mbtgjtglHnJiQxaxr/lPCJh
X-Gm-Gg: AY/fxX5aerkxdwrPFFgc0Nr3b8VwZul0sfisY1UZyIDz29BGFxNaguInpOH8iy6BYY+
 BNC1DPhW8H6XXaBcCgPhAJsu2JuJUYWruMjQMFATwnM3T8z7HRDaKI6qju1ATV23nlJ67+/bNpQ
 jWrc7RzN/goi28wS7qle9sP4fxXlvRkpU2LTH3LtH1nAf2AEmjsS31xImNgfVnV7URuKzH
X-Received: by 2002:a53:c404:0:b0:641:f5bc:697c with SMTP id
 956f58d0204a3-6466a8bb25fmr30391840d50.72.1767375493156; 
 Fri, 02 Jan 2026 09:38:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7y3o23WPcRtKjjZDa2PS9Ng5tzlBw2pTJpEQnrUf52q3H92nU+29udg+qUaFU7QYvCA0cBntHDCFmSLXzA3I=
X-Received: by 2002:a53:c404:0:b0:641:f5bc:697c with SMTP id
 956f58d0204a3-6466a8bb25fmr30391823d50.72.1767375492706; Fri, 02 Jan 2026
 09:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20251221142232.22738-1-anjo@rev.ng>
In-Reply-To: <20251221142232.22738-1-anjo@rev.ng>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Fri, 2 Jan 2026 11:37:56 -0600
X-Gm-Features: AQt7F2opPDVuWQ0QhwYXEyULVWpGUT5B-hxatSbQ_LdToBeZw6yBgY4RCdqANE4
Message-ID: <CAEqNhNb7nxESWg1LzO6NPNEXjLf0MFG+-m08Qf0Q0=E_PsOhOQ@mail.gmail.com>
Subject: Re: [PATCH] target/hexagon: Widen MemLog::width to 32 bits
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000006d82dc06476b2c29"
X-Authority-Analysis: v=2.4 cv=NMbYOk6g c=1 sm=1 tr=0 ts=69580285 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ghhuflt2Ilr34hSUVSwA:9
 a=QEXdDO2ut3YA:10 a=jTosBtNegoNbMBADmMAA:9 a=ByXcpH4uUTiX-HOU:21
 a=lqcHg5cX4UMA:10 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-ORIG-GUID: hv2mkeyaW4cE-vDyEugjo6i6fcYsUhyS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE1NyBTYWx0ZWRfX2r58779ZzDOh
 nfr8JWPaZwJ30BcEx7pdkhuhPxZT2zyY05iWYvJeYoWh9OPfjo3XgyVDWEOj7c6vYmNeqGRYhhm
 4SG979pPXqovsbKnCFOFnlU/LBgyxW079snj4rP7s3evKR3S4C0+zoRaOFx367SN0dQAqPezSMn
 ZRwnb52ojJr28qPdhlgeL4dR/hDV/Ss/tbjpKQcu0So9iS3S9Bs7kuZSVlX7Svn5UZbkex9A46j
 LOGIQeW3nDb0bqfa7kHQkuYYnD1ZpAseCRwhJsaXHC4MdZFHzMuQBUXc9Cu+lNoB3psRS/yath6
 8uwFgaf419YKmyHZ/IzcVf6uvPdaqR9h4ApvtIWVA3UCa+vqMX2SsCD0iBQldhTthNg/hDFnE41
 01/rTngD7lyoL1pcrfFiD8CVDr5tFARDJGMXU3H/dIu98JtIF8oxtSzV8eQxaiK67gpRbltIwpP
 9NdOboK5dJe6qs2X/YA==
X-Proofpoint-GUID: hv2mkeyaW4cE-vDyEugjo6i6fcYsUhyS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020157
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

--0000000000006d82dc06476b2c29
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 8:19=E2=80=AFAM Anton Johansson <anjo@rev.ng> wrote=
:

> MemLog::width is a uint8_t value mapped to a TCGv (32 bit), the only
> reason this currently works is because MemLog::width is padded to 32
> bits.  Widen the field to uint32_t and fix the size of the TCGv
> operations as well.  Use uint8_t when passing around the
> field as an immediate to retain previous truncation behaviour.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

 target/hexagon/cpu.h       | 2 +-
>  target/hexagon/op_helper.h | 4 ++--
>  target/hexagon/translate.h | 2 +-
>  target/hexagon/genptr.c    | 6 +++---
>  target/hexagon/op_helper.c | 4 ++--
>  target/hexagon/translate.c | 4 ++--
>  6 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 43a854f517..9d3df84ee6 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -46,7 +46,7 @@
>
>  typedef struct {
>      target_ulong va;
> -    uint8_t width;
> +    uint32_t width;
>      uint32_t data32;
>      uint64_t data64;
>  } MemLog;
> diff --git a/target/hexagon/op_helper.h b/target/hexagon/op_helper.h
> index 66119cf3d4..ff65a94d57 100644
> --- a/target/hexagon/op_helper.h
> +++ b/target/hexagon/op_helper.h
> @@ -20,8 +20,8 @@
>
>  /* Misc functions */
>  void log_store64(CPUHexagonState *env, target_ulong addr,
> -                 int64_t val, int width, int slot);
> +                 int64_t val, uint8_t width, int slot);
>  void log_store32(CPUHexagonState *env, target_ulong addr,
> -                 target_ulong val, int width, int slot);
> +                 target_ulong val, uint8_t width, int slot);
>
>  #endif
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index d251e2233f..9e8f54edb5 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -271,7 +271,7 @@ extern TCGv hex_pred[NUM_PREGS];
>  extern TCGv hex_slot_cancelled;
>  extern TCGv hex_new_value_usr;
>  extern TCGv hex_store_addr[STORES_MAX];
> -extern TCGv hex_store_width[STORES_MAX];
> +extern TCGv_i32 hex_store_width[STORES_MAX];
>  extern TCGv hex_store_val32[STORES_MAX];
>  extern TCGv_i64 hex_store_val64[STORES_MAX];
>  extern TCGv hex_llsc_addr;
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index cecaece4ae..9c66ca181a 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -401,10 +401,10 @@ static TCGv gen_slotval(DisasContext *ctx)
>  }
>  #endif
>
> -void gen_store32(TCGv vaddr, TCGv src, int width, uint32_t slot)
> +void gen_store32(TCGv vaddr, TCGv src, uint8_t width, uint32_t slot)
>  {
>      tcg_gen_mov_tl(hex_store_addr[slot], vaddr);
> -    tcg_gen_movi_tl(hex_store_width[slot], width);
> +    tcg_gen_movi_i32(hex_store_width[slot], width);
>      tcg_gen_mov_tl(hex_store_val32[slot], src);
>  }
>
> @@ -444,7 +444,7 @@ void gen_store4i(TCGv_env tcg_env, TCGv vaddr, int32_=
t
> src, uint32_t slot)
>  void gen_store8(TCGv_env tcg_env, TCGv vaddr, TCGv_i64 src, uint32_t slo=
t)
>  {
>      tcg_gen_mov_tl(hex_store_addr[slot], vaddr);
> -    tcg_gen_movi_tl(hex_store_width[slot], 8);
> +    tcg_gen_movi_i32(hex_store_width[slot], 8);
>      tcg_gen_mov_i64(hex_store_val64[slot], src);
>  }
>
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index e2e80ca7ef..823307696d 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -52,7 +52,7 @@ G_NORETURN void HELPER(raise_exception)(CPUHexagonState
> *env, uint32_t excp)
>  }
>
>  void log_store32(CPUHexagonState *env, target_ulong addr,
> -                 target_ulong val, int width, int slot)
> +                 target_ulong val, uint8_t width, int slot)
>  {
>      env->mem_log_stores[slot].va =3D addr;
>      env->mem_log_stores[slot].width =3D width;
> @@ -60,7 +60,7 @@ void log_store32(CPUHexagonState *env, target_ulong add=
r,
>  }
>
>  void log_store64(CPUHexagonState *env, target_ulong addr,
> -                 int64_t val, int width, int slot)
> +                 int64_t val, uint8_t width, int slot)
>  {
>      env->mem_log_stores[slot].va =3D addr;
>      env->mem_log_stores[slot].width =3D width;
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 8fce219c0d..6151bdd4a6 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -51,7 +51,7 @@ TCGv hex_pred[NUM_PREGS];
>  TCGv hex_slot_cancelled;
>  TCGv hex_new_value_usr;
>  TCGv hex_store_addr[STORES_MAX];
> -TCGv hex_store_width[STORES_MAX];
> +TCGv_i32 hex_store_width[STORES_MAX];
>  TCGv hex_store_val32[STORES_MAX];
>  TCGv_i64 hex_store_val64[STORES_MAX];
>  TCGv hex_llsc_addr;
> @@ -1079,7 +1079,7 @@ void hexagon_translate_init(void)
>              store_addr_names[i]);
>
>          snprintf(store_width_names[i], NAME_LEN, "store_width_%d", i);
> -        hex_store_width[i] =3D tcg_global_mem_new(tcg_env,
> +        hex_store_width[i] =3D tcg_global_mem_new_i32(tcg_env,
>              offsetof(CPUHexagonState, mem_log_stores[i].width),
>              store_width_names[i]);
>
> --
> 2.51.0
>
>

--0000000000006d82dc06476b2c29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Dec 21, 2025 at=
 8:19=E2=80=AFAM Anton Johansson &lt;<a href=3D"mailto:anjo@rev.ng">anjo@re=
v.ng</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">MemLog::width is a uint8_t value mapped to a TCGv (32 bit), the only<br=
>
reason this currently works is because MemLog::width is padded to 32<br>
bits.=C2=A0 Widen the field to uint32_t and fix the size of the TCGv<br>
operations as well.=C2=A0 Use uint8_t when passing around the<br>
field as an immediate to retain previous truncation behaviour.<br>
<br>
Signed-off-by: Anton Johansson &lt;<a href=3D"mailto:anjo@rev.ng" target=3D=
"_blank">anjo@rev.ng</a>&gt;<br>
---<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"fo=
nt-family:monospace">Reviewed-by: Brian Cain &lt;<a href=3D"mailto:brian.ca=
in@oss.qualcomm.com">brian.cain@oss.qualcomm.com</a>&gt;</div><div class=3D=
"gmail_default" style=3D"font-family:monospace"><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
=C2=A0target/hexagon/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0target/hexagon/op_helper.h | 4 ++--<br>
=C2=A0target/hexagon/translate.h | 2 +-<br>
=C2=A0target/hexagon/genptr.c=C2=A0 =C2=A0 | 6 +++---<br>
=C2=A0target/hexagon/op_helper.c | 4 ++--<br>
=C2=A0target/hexagon/translate.c | 4 ++--<br>
=C2=A06 files changed, 11 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h<br>
index 43a854f517..9d3df84ee6 100644<br>
--- a/target/hexagon/cpu.h<br>
+++ b/target/hexagon/cpu.h<br>
@@ -46,7 +46,7 @@<br>
<br>
=C2=A0typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0target_ulong va;<br>
-=C2=A0 =C2=A0 uint8_t width;<br>
+=C2=A0 =C2=A0 uint32_t width;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t data32;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t data64;<br>
=C2=A0} MemLog;<br>
diff --git a/target/hexagon/op_helper.h b/target/hexagon/op_helper.h<br>
index 66119cf3d4..ff65a94d57 100644<br>
--- a/target/hexagon/op_helper.h<br>
+++ b/target/hexagon/op_helper.h<br>
@@ -20,8 +20,8 @@<br>
<br>
=C2=A0/* Misc functions */<br>
=C2=A0void log_store64(CPUHexagonState *env, target_ulong addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int64_t val,=
 int width, int slot);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int64_t val,=
 uint8_t width, int slot);<br>
=C2=A0void log_store32(CPUHexagonState *env, target_ulong addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong=
 val, int width, int slot);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong=
 val, uint8_t width, int slot);<br>
<br>
=C2=A0#endif<br>
diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h<br>
index d251e2233f..9e8f54edb5 100644<br>
--- a/target/hexagon/translate.h<br>
+++ b/target/hexagon/translate.h<br>
@@ -271,7 +271,7 @@ extern TCGv hex_pred[NUM_PREGS];<br>
=C2=A0extern TCGv hex_slot_cancelled;<br>
=C2=A0extern TCGv hex_new_value_usr;<br>
=C2=A0extern TCGv hex_store_addr[STORES_MAX];<br>
-extern TCGv hex_store_width[STORES_MAX];<br>
+extern TCGv_i32 hex_store_width[STORES_MAX];<br>
=C2=A0extern TCGv hex_store_val32[STORES_MAX];<br>
=C2=A0extern TCGv_i64 hex_store_val64[STORES_MAX];<br>
=C2=A0extern TCGv hex_llsc_addr;<br>
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c<br>
index cecaece4ae..9c66ca181a 100644<br>
--- a/target/hexagon/genptr.c<br>
+++ b/target/hexagon/genptr.c<br>
@@ -401,10 +401,10 @@ static TCGv gen_slotval(DisasContext *ctx)<br>
=C2=A0}<br>
=C2=A0#endif<br>
<br>
-void gen_store32(TCGv vaddr, TCGv src, int width, uint32_t slot)<br>
+void gen_store32(TCGv vaddr, TCGv src, uint8_t width, uint32_t slot)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_mov_tl(hex_store_addr[slot], vaddr);<br>
-=C2=A0 =C2=A0 tcg_gen_movi_tl(hex_store_width[slot], width);<br>
+=C2=A0 =C2=A0 tcg_gen_movi_i32(hex_store_width[slot], width);<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_mov_tl(hex_store_val32[slot], src);<br>
=C2=A0}<br>
<br>
@@ -444,7 +444,7 @@ void gen_store4i(TCGv_env tcg_env, TCGv vaddr, int32_t =
src, uint32_t slot)<br>
=C2=A0void gen_store8(TCGv_env tcg_env, TCGv vaddr, TCGv_i64 src, uint32_t =
slot)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_mov_tl(hex_store_addr[slot], vaddr);<br>
-=C2=A0 =C2=A0 tcg_gen_movi_tl(hex_store_width[slot], 8);<br>
+=C2=A0 =C2=A0 tcg_gen_movi_i32(hex_store_width[slot], 8);<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_mov_i64(hex_store_val64[slot], src);<br>
=C2=A0}<br>
<br>
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c<br>
index e2e80ca7ef..823307696d 100644<br>
--- a/target/hexagon/op_helper.c<br>
+++ b/target/hexagon/op_helper.c<br>
@@ -52,7 +52,7 @@ G_NORETURN void HELPER(raise_exception)(CPUHexagonState *=
env, uint32_t excp)<br>
=C2=A0}<br>
<br>
=C2=A0void log_store32(CPUHexagonState *env, target_ulong addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong=
 val, int width, int slot)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong=
 val, uint8_t width, int slot)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;mem_log_stores[slot].va =3D addr;<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;mem_log_stores[slot].width =3D width;<br>
@@ -60,7 +60,7 @@ void log_store32(CPUHexagonState *env, target_ulong addr,=
<br>
=C2=A0}<br>
<br>
=C2=A0void log_store64(CPUHexagonState *env, target_ulong addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int64_t val,=
 int width, int slot)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int64_t val,=
 uint8_t width, int slot)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;mem_log_stores[slot].va =3D addr;<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;mem_log_stores[slot].width =3D width;<br>
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c<br>
index 8fce219c0d..6151bdd4a6 100644<br>
--- a/target/hexagon/translate.c<br>
+++ b/target/hexagon/translate.c<br>
@@ -51,7 +51,7 @@ TCGv hex_pred[NUM_PREGS];<br>
=C2=A0TCGv hex_slot_cancelled;<br>
=C2=A0TCGv hex_new_value_usr;<br>
=C2=A0TCGv hex_store_addr[STORES_MAX];<br>
-TCGv hex_store_width[STORES_MAX];<br>
+TCGv_i32 hex_store_width[STORES_MAX];<br>
=C2=A0TCGv hex_store_val32[STORES_MAX];<br>
=C2=A0TCGv_i64 hex_store_val64[STORES_MAX];<br>
=C2=A0TCGv hex_llsc_addr;<br>
@@ -1079,7 +1079,7 @@ void hexagon_translate_init(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0store_addr_names[i]);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(store_width_names[i], NAME_LEN, =
&quot;store_width_%d&quot;, i);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hex_store_width[i] =3D tcg_global_mem_new(tcg_=
env,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hex_store_width[i] =3D tcg_global_mem_new_i32(=
tcg_env,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offsetof(CPUHexagonState, m=
em_log_stores[i].width),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0store_width_names[i]);<br>
<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>

--0000000000006d82dc06476b2c29--

