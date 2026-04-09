Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACAFF364A6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAsuS-0002eX-MK; Thu, 09 Apr 2026 13:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAsuR-0002eB-0H
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:11:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAsuO-0007mF-0I
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:11:14 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639D1RFP1972539
 for <qemu-devel@nongnu.org>; Thu, 9 Apr 2026 17:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iqCccMDo7Z5kNFp46pm4Xr1h/v2G9JJjT7l5ImekeL0=; b=bzVxUPvgrudS+gI3
 6KTcysLtRD8uni/ifqeYr4G+YzkHH5y50dRbb4DAx7Bpsw5Ml44XKGSuKipFwZWE
 mbRXgWUU24c34D+l9grvV+KvA8hBrpgMYeXZry8m1fEP0+CbAWosuSWujGYwj42C
 A/ksg3nvN6lOOEo2YTQaChpfdbPdz8jorFGd7KZnJ8hmNALwUh+8G3u0byrEgNK6
 SAOXH2osckhVg2SzwCVd2G8eSL/RKEdpyGfqpfLgzGsEmBY6ak+FbFM5kVFWcmVz
 /4EKz7PgkpD14ynYtfHFxFKDYtWMN8Rtb0BKXDywqdSQRPuS/4sgq22Xoah0zywd
 0mCDSQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decms0y8n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 17:11:06 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1276e71652fso1488025c88.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:11:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775754666; cv=none;
 d=google.com; s=arc-20240605;
 b=Xbb55IV2nB42IJII9Hir3kI+6knoK0YialjqAXJ2Q/a6gsljE0jT8UZ27TrSWf+wVd
 a07VCDvoiLlhubN+ARSWFYBYSe+cqkeXinc796PwNvycDUc1gmXQBHnyojjNUEX5/jmj
 0WPptZsh0PUUJPNo59XocDEktJjjkaIIyhbyrJg0SDvK1Ki0br+CVfH7QR/7EF4FNHsk
 4XWgC7u+Ml3aKJn5JLdbZfKWujd7wleeAUXzrOICLCV5ZJdV6qFAsXqYWX5Zkd/tWwpy
 uMlanfRJUWXyGF5ax4mnPzrRyVmuS+B0PtNbzJ16D+Knjq4pIG9QQS9W0xnk0RADcCOp
 l6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iqCccMDo7Z5kNFp46pm4Xr1h/v2G9JJjT7l5ImekeL0=;
 fh=mrfZO0qQM5eciwqMtrtmvbDllU4euPRvlqU0p6gBO7o=;
 b=EpEgpdqP+JTpnxdhAv0flkZx78It0QT23aygdINzC2PvH4CrccbzgPiMSMrEscsbl1
 O2mzc5+Po4aYkXg2fRNlY+kjRg0tIdV8lLcqFigB8UKl2HXu+yVhehzOx8OhJ8n0CzEn
 pdLJzxDFHSMr83E4pkfqeo/1QBxlTYI9jDeXVan+dBVU6E2zcqEEKwPmDCkX8ktMLEXk
 l2daFTJfeMYyn2Qs8vd2/p6dB/7XxwaQaP+w5yzlY2f1mg60W4r2rd4wfrOlpaU8MyFR
 WC/qeI3IOoRvW+zWxwn8ghuNaZ3YfYaILt07hZEz+2jlYVf7P0zInumv/u3ZJLwEiDko
 YvAg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775754666; x=1776359466; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqCccMDo7Z5kNFp46pm4Xr1h/v2G9JJjT7l5ImekeL0=;
 b=fBF39sH5I/1ROMjoPiOKfo4NEUznPkkOu9Wa5zzbV0hsPvm7Mh/5L72wERXR2p2nW/
 QxsAyOmKe7yCupUCugb5Ofwu1sua18eMKHUQmKRbPZ91v1aqyvObggizYT/04qNr+CPA
 +8VnAo4Q1sfE3cTZ9vwqMiJKUcwV8Xh8vydbMLvVIg0wh7E3LvtSy0QV9PlpWLveB3AS
 XCQY+hHVBFrZ6B41k9dTjJSjceI5WuhhZlwJM9FhJMZ6MLWvoZX0acGmzRictRK5fKk/
 VApRuaXxY40uYqmWOHVGNhe9NJdticK1ANf+7SlwlxObp0lUcqnZBGrCj8AAwlp1cTyE
 D1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775754666; x=1776359466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iqCccMDo7Z5kNFp46pm4Xr1h/v2G9JJjT7l5ImekeL0=;
 b=VdCUeVaFQVZoIK+tZ0ndsrbfn9mRqpEYW2C0hNBETVVOPcYT/J1KY/pMcQ9/Xl8+Fs
 MXVFSL7jwlkwZYSo0wBhmP1i9Lyu0cIuCKYOpTttmGUnhywlkfi9d9VAdvTB6eJYjrrg
 6QgZXwPoHcs1jaVzgBmk6P77O1DyecANCFXHItAXBK1D3b88b3cA7rlirOmRbqBXHMQW
 sMhPpZcvtGpreGFIb4Xe1I2nSzmlAyEbFXeHB1npeTdFj4XcsbAiuyClmgnnLrqghDxF
 mCMa1w1qj4C/+1fOCCRTSpk+DZoacsMYqfyjwnFWl5ve+fOPO8xBvvOW3zQXPDugjTJ6
 151w==
X-Gm-Message-State: AOJu0YxIOlh19tyWX9ZXWnP2N6O79mBecru4QKsbS6Ih16uFlxxQZUDg
 bNNqXwodyFmwxvBgywIZScf6xl1PQS/I+gNukbE7KKk7U24NpeCvLWfpUt57mnAsFrO6h/XdXnK
 lohjLsEDQm1OVqT6sSKg1nJSWc0bNyaFQNk5M30ifvewVyfE1O3n0sVCexaRy1gUE51MupiltkS
 DUrohKeosg9g7EcKCwhdLZW46g2FNkp+Z6
X-Gm-Gg: AeBDieuZtf5V3L1EGXFylo2JhZ7wzw8qRcW9r835A/XUBz0NUpAIKR+un0PVQK+L/fa
 WQDU9IUhpeC2eCvtBbu/+VbF0qO+zIyrI41LXrDYZex2ykYQot+zWKihZQLo9KT4H4GEY39aaMp
 w+tBF6Gf5kCD90LM2b9Jw5xQf2zQy4X0WPv9MRd6YIpkA2kZnKfpX/XGDxWzeXg7b93eVdlGY7B
 2taCx0=
X-Received: by 2002:a05:7022:6ab:b0:123:3488:899f with SMTP id
 a92af1059eb24-12c28c2d224mr2222111c88.32.1775754665313; 
 Thu, 09 Apr 2026 10:11:05 -0700 (PDT)
X-Received: by 2002:a05:7022:6ab:b0:123:3488:899f with SMTP id
 a92af1059eb24-12c28c2d224mr2222070c88.32.1775754664375; Thu, 09 Apr 2026
 10:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260122223423.1076448-1-marco.liebel@oss.qualcomm.com>
 <CAEqNhNYa8xybC2tRKscjZhon7vuW4pn3-OuLaLwOj2Y4PHV8QQ@mail.gmail.com>
In-Reply-To: <CAEqNhNYa8xybC2tRKscjZhon7vuW4pn3-OuLaLwOj2Y4PHV8QQ@mail.gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 12:10:47 -0500
X-Gm-Features: AQROBzA9FOV9SQaVaEGX615osdQNcSLjVsFoT4hFRGJ-BwZ2qtMQcy-Si4ndpUw
Message-ID: <CAEqNhNa6gpBRW65GLDgwFmyk4ULsTPhZUgWXKR55e=c0veAdsw@mail.gmail.com>
Subject: Re: [PATCH] target/hexagon: Change DisasContext packet type
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, ltaylorsimpson@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: tXGDnSxLFC7fgLI5m6XHWCIWhxiZwCmn
X-Proofpoint-GUID: tXGDnSxLFC7fgLI5m6XHWCIWhxiZwCmn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE1NyBTYWx0ZWRfXw6qedx2qrFXw
 E6Me4NxsvqwudEBcDZ0W4J2CCFNRxcDcsixeU+AOJnwvkRvOTOf3eH16qE8pNOegmXbaGSmalZg
 HXC8xOaDcycnd3FpZK63xhoqqgY9t328NbSPyBSFGzVaHK5dqSCUHp5UNj7cLLxeKcvjiIrgTFV
 dZDUnDmwr0ZJP+lxrAHLtDZmE3qAK7gx2+xjrJqibWhLQZLda9Ak3ABbgSpYAwO554B0Vam/hUj
 IDq6czrwWrgo8VNzKgzMXtFn+5QTGkrkiVyUOXrFisLQeWmTVzqrpLBaqaiuygJYZOhaWX0BAn4
 I209F23JP1ackaciuXjuq30IoUPwPGMcxDeqrdUlHCbz0ye+izLlSz7iNOFAG5ca0/vWLqC+Ay4
 A6idJTf4bIwknNwM+U2h3mOX9mZxEiy5NE73ZseMddSa1mnIPZUZbfDU6U+iTWI/5hlfk8bdr1w
 lSq/B4wgrJC7wSWU5wA==
X-Authority-Analysis: v=2.4 cv=N/sZ0W9B c=1 sm=1 tr=0 ts=69d7ddaa cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=ErtwthqZc5DNjmXz0hQA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090157
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Mar 11, 2026 at 7:25=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
>
>
> On Thu, Jan 22, 2026 at 4:34=E2=80=AFPM Marco Liebel <marco.liebel@oss.qu=
alcomm.com> wrote:
>>
>> The pkt variable inside DisasContext is of type Packet * and gets
>> assigned to a local variable in decode_and_translate_packet. Right now
>> there seems to be no problem with it but future changes to e.g.
>> hexagon_tr_transalte_packet are potentially dangerous if pkt is accessed
>> after the local variable goes out of scope.
>>
>> Since packets are being translated one at a time, the type of pkt can be
>> changed to just Packet to avoid risk of having a dangling pointer.
>>
>> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
>> ---
>
>
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

Thanks for the patch Marco - this is queued on my hex-next-express
tree for post-11 inclusion.

>
>
>>
>>  target/hexagon/gen_tcg.h        |   2 +-
>>  target/hexagon/macros.h         |   6 +-
>>  target/hexagon/translate.h      |   2 +-
>>  target/hexagon/decode.c         |   8 +--
>>  target/hexagon/genptr.c         |  14 ++--
>>  target/hexagon/translate.c      | 111 ++++++++++++++------------------
>>  target/hexagon/gen_tcg_funcs.py |   2 +-
>>  target/hexagon/hex_common.py    |   4 +-
>>  8 files changed, 65 insertions(+), 84 deletions(-)
>>
>> diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
>> index 7b96dab918..54562e3ef3 100644
>> --- a/target/hexagon/gen_tcg.h
>> +++ b/target/hexagon/gen_tcg.h
>> @@ -1363,7 +1363,7 @@
>>  #define fGEN_TCG_J2_trap0(SHORTCODE) \
>>      do { \
>>          uiV =3D uiV; \
>> -        tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->pkt->pc); \
>> +        tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->pkt.pc); \
>>          TCGv excp =3D tcg_constant_tl(HEX_EVENT_TRAP0); \
>>          gen_helper_raise_exception(tcg_env, excp); \
>>      } while (0)
>> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
>> index 6c2862a232..eebfe1e5ed 100644
>> --- a/target/hexagon/macros.h
>> +++ b/target/hexagon/macros.h
>> @@ -83,7 +83,7 @@
>>   */
>>  #define CHECK_NOSHUF(VA, SIZE) \
>>      do { \
>> -        if (insn->slot =3D=3D 0 && ctx->pkt->pkt_has_scalar_store_s1) {=
 \
>> +        if (insn->slot =3D=3D 0 && ctx->pkt.pkt_has_scalar_store_s1) { =
\
>>              probe_noshuf_load(VA, SIZE, ctx->mem_idx); \
>>              process_store(ctx, 1); \
>>          } \
>> @@ -94,11 +94,11 @@
>>          TCGLabel *noshuf_label =3D gen_new_label(); \
>>          tcg_gen_brcondi_tl(TCG_COND_EQ, PRED, 0, noshuf_label); \
>>          GET_EA; \
>> -        if (insn->slot =3D=3D 0 && ctx->pkt->pkt_has_scalar_store_s1) {=
 \
>> +        if (insn->slot =3D=3D 0 && ctx->pkt.pkt_has_scalar_store_s1) { =
\
>>              probe_noshuf_load(EA, SIZE, ctx->mem_idx); \
>>          } \
>>          gen_set_label(noshuf_label); \
>> -        if (insn->slot =3D=3D 0 && ctx->pkt->pkt_has_scalar_store_s1) {=
 \
>> +        if (insn->slot =3D=3D 0 && ctx->pkt.pkt_has_scalar_store_s1) { =
\
>>              process_store(ctx, 1); \
>>          } \
>>      } while (0)
>> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
>> index a0102b6cbd..ffbfc3ac0e 100644
>> --- a/target/hexagon/translate.h
>> +++ b/target/hexagon/translate.h
>> @@ -28,7 +28,7 @@
>>
>>  typedef struct DisasContext {
>>      DisasContextBase base;
>> -    Packet *pkt;
>> +    Packet pkt;
>>      Insn *insn;
>>      uint32_t next_PC;
>>      uint32_t mem_idx;
>> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
>> index b5ece60450..c2516d927d 100644
>> --- a/target/hexagon/decode.c
>> +++ b/target/hexagon/decode.c
>> @@ -748,14 +748,12 @@ int disassemble_hexagon(uint32_t *words, int nword=
s, bfd_vma pc,
>>                          GString *buf)
>>  {
>>      DisasContext ctx;
>> -    Packet pkt;
>>
>>      memset(&ctx, 0, sizeof(DisasContext));
>> -    ctx.pkt =3D &pkt;
>>
>> -    if (decode_packet(&ctx, nwords, words, &pkt, true) > 0) {
>> -        snprint_a_pkt_disas(buf, &pkt, words, pc);
>> -        return pkt.encod_pkt_size_in_bytes;
>> +    if (decode_packet(&ctx, nwords, words, &ctx.pkt, true) > 0) {
>> +        snprint_a_pkt_disas(buf, &ctx.pkt, words, pc);
>> +        return ctx.pkt.encod_pkt_size_in_bytes;
>>      } else {
>>          g_string_assign(buf, "<invalid>");
>>          return 0;
>> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
>> index 36968549d5..160edfe756 100644
>> --- a/target/hexagon/genptr.c
>> +++ b/target/hexagon/genptr.c
>> @@ -382,7 +382,7 @@ static inline void gen_store_conditional8(DisasConte=
xt *ctx,
>>  static TCGv gen_slotval(DisasContext *ctx)
>>  {
>>      int slotval =3D
>> -        (ctx->pkt->pkt_has_scalar_store_s1 & 1) | (ctx->insn->slot << 1=
);
>> +        (ctx->pkt.pkt_has_scalar_store_s1 & 1) | (ctx->insn->slot << 1)=
;
>>      return tcg_constant_tl(slotval);
>>  }
>>  #endif
>> @@ -458,7 +458,7 @@ static void gen_write_new_pc_addr(DisasContext *ctx,=
 TCGv addr,
>>          tcg_gen_brcondi_tl(cond, pred, 0, pred_false);
>>      }
>>
>> -    if (ctx->pkt->pkt_has_multi_cof) {
>> +    if (ctx->pkt.pkt_has_multi_cof) {
>>          /* If there are multiple branches in a packet, ignore the secon=
d one */
>>          tcg_gen_movcond_tl(TCG_COND_NE, hex_gpr[HEX_REG_PC],
>>                             ctx->branch_taken, tcg_constant_tl(0),
>> @@ -476,8 +476,8 @@ static void gen_write_new_pc_addr(DisasContext *ctx,=
 TCGv addr,
>>  static void gen_write_new_pc_pcrel(DisasContext *ctx, int pc_off,
>>                                     TCGCond cond, TCGv pred)
>>  {
>> -    target_ulong dest =3D ctx->pkt->pc + pc_off;
>> -    if (ctx->pkt->pkt_has_multi_cof) {
>> +    target_ulong dest =3D ctx->pkt.pc + pc_off;
>> +    if (ctx->pkt.pkt_has_multi_cof) {
>>          gen_write_new_pc_addr(ctx, tcg_constant_tl(dest), cond, pred);
>>      } else {
>>          /* Defer this jump to the end of the TB */
>> @@ -528,7 +528,7 @@ static inline void gen_loop0r(DisasContext *ctx, TCG=
v RsV, int riV)
>>      fIMMEXT(riV);
>>      fPCALIGN(riV);
>>      tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC0), RsV);
>> -    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx->pkt->pc + ri=
V);
>> +    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx->pkt.pc + riV=
);
>>      gen_set_usr_fieldi(ctx, USR_LPCFG, 0);
>>  }
>>
>> @@ -542,7 +542,7 @@ static inline void gen_loop1r(DisasContext *ctx, TCG=
v RsV, int riV)
>>      fIMMEXT(riV);
>>      fPCALIGN(riV);
>>      tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC1), RsV);
>> -    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA1), ctx->pkt->pc + ri=
V);
>> +    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA1), ctx->pkt.pc + riV=
);
>>  }
>>
>>  static void gen_loop1i(DisasContext *ctx, int count, int riV)
>> @@ -555,7 +555,7 @@ static void gen_ploopNsr(DisasContext *ctx, int N, T=
CGv RsV, int riV)
>>      fIMMEXT(riV);
>>      fPCALIGN(riV);
>>      tcg_gen_mov_tl(get_result_gpr(ctx, HEX_REG_LC0), RsV);
>> -    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx->pkt->pc + ri=
V);
>> +    tcg_gen_movi_tl(get_result_gpr(ctx, HEX_REG_SA0), ctx->pkt.pc + riV=
);
>>      gen_set_usr_fieldi(ctx, USR_LPCFG, N);
>>      gen_pred_write(ctx, 3, tcg_constant_tl(0));
>>  }
>> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
>> index e88e19cc1a..b06ed154f3 100644
>> --- a/target/hexagon/translate.c
>> +++ b/target/hexagon/translate.c
>> @@ -156,8 +156,6 @@ static void gen_goto_tb(DisasContext *ctx, unsigned =
tb_slot_idx,
>>
>>  static void gen_end_tb(DisasContext *ctx)
>>  {
>> -    Packet *pkt =3D ctx->pkt;
>> -
>>      gen_exec_counters(ctx);
>>
>>      if (ctx->branch_cond !=3D TCG_COND_NEVER) {
>> @@ -171,7 +169,7 @@ static void gen_end_tb(DisasContext *ctx)
>>              gen_goto_tb(ctx, 0, ctx->branch_dest, true);
>>          }
>>      } else if (ctx->is_tight_loop &&
>> -               pkt->insn[pkt->num_insns - 1].opcode =3D=3D J2_endloop0)=
 {
>> +               ctx->pkt.insn[ctx->pkt.num_insns - 1].opcode =3D=3D J2_e=
ndloop0) {
>>          /*
>>           * When we're in a tight loop, we defer the endloop0 processing
>>           * to take advantage of direct block chaining
>> @@ -252,11 +250,9 @@ static bool need_slot_cancelled(Packet *pkt)
>>
>>  static bool need_next_PC(DisasContext *ctx)
>>  {
>> -    Packet *pkt =3D ctx->pkt;
>> -
>>      /* Check for conditional control flow or HW loop end */
>> -    for (int i =3D 0; i < pkt->num_insns; i++) {
>> -        uint16_t opcode =3D pkt->insn[i].opcode;
>> +    for (int i =3D 0; i < ctx->pkt.num_insns; i++) {
>> +        uint16_t opcode =3D ctx->pkt.insn[i].opcode;
>>          if (GET_ATTRIB(opcode, A_CONDEXEC) && GET_ATTRIB(opcode, A_COF)=
) {
>>              return true;
>>          }
>> @@ -339,8 +335,6 @@ static bool pkt_raises_exception(Packet *pkt)
>>
>>  static bool need_commit(DisasContext *ctx)
>>  {
>> -    Packet *pkt =3D ctx->pkt;
>> -
>>      /*
>>       * If the short-circuit property is set to false, we'll always do t=
he commit
>>       */
>> @@ -348,7 +342,7 @@ static bool need_commit(DisasContext *ctx)
>>          return true;
>>      }
>>
>> -    if (pkt_raises_exception(pkt)) {
>> +    if (pkt_raises_exception(&ctx->pkt)) {
>>          return true;
>>      }
>>
>> @@ -395,11 +389,10 @@ static void mark_implicit_writes(DisasContext *ctx=
)
>>
>>  static void analyze_packet(DisasContext *ctx)
>>  {
>> -    Packet *pkt =3D ctx->pkt;
>>      ctx->read_after_write =3D false;
>>      ctx->has_hvx_overlap =3D false;
>> -    for (int i =3D 0; i < pkt->num_insns; i++) {
>> -        Insn *insn =3D &pkt->insn[i];
>> +    for (int i =3D 0; i < ctx->pkt.num_insns; i++) {
>> +        Insn *insn =3D &ctx->pkt.insn[i];
>>          ctx->insn =3D insn;
>>          if (opcode_analyze[insn->opcode]) {
>>              opcode_analyze[insn->opcode](ctx);
>> @@ -411,8 +404,7 @@ static void analyze_packet(DisasContext *ctx)
>>
>>  static void gen_start_packet(DisasContext *ctx)
>>  {
>> -    Packet *pkt =3D ctx->pkt;
>> -    target_ulong next_PC =3D ctx->base.pc_next + pkt->encod_pkt_size_in=
_bytes;
>> +    target_ulong next_PC =3D ctx->base.pc_next + ctx->pkt.encod_pkt_siz=
e_in_bytes;
>>      int i;
>>
>>      /* Clear out the disassembly context */
>> @@ -454,13 +446,13 @@ static void gen_start_packet(DisasContext *ctx)
>>      bitmap_zero(ctx->pregs_written, NUM_PREGS);
>>
>>      /* Initialize the runtime state for packet semantics */
>> -    if (need_slot_cancelled(pkt)) {
>> +    if (need_slot_cancelled(&ctx->pkt)) {
>>          tcg_gen_movi_tl(hex_slot_cancelled, 0);
>>      }
>>      ctx->branch_taken =3D NULL;
>> -    if (pkt->pkt_has_cof) {
>> +    if (ctx->pkt.pkt_has_cof) {
>>          ctx->branch_taken =3D tcg_temp_new();
>> -        if (pkt->pkt_has_multi_cof) {
>> +        if (ctx->pkt.pkt_has_multi_cof) {
>>              tcg_gen_movi_tl(ctx->branch_taken, 0);
>>          }
>>          if (need_next_PC(ctx)) {
>> @@ -489,7 +481,7 @@ static void gen_start_packet(DisasContext *ctx)
>>       * Preload the predicated pred registers into ctx->new_pred_value[p=
red_num]
>>       * Only endloop instructions conditionally write to pred registers
>>       */
>> -    if (ctx->need_commit && pkt->pkt_has_endloop) {
>> +    if (ctx->need_commit && ctx->pkt.pkt_has_endloop) {
>>          for (i =3D 0; i < ctx->preg_log_idx; i++) {
>>              int pred_num =3D ctx->preg_log[i];
>>              ctx->new_pred_value[pred_num] =3D tcg_temp_new();
>> @@ -528,13 +520,11 @@ static void gen_start_packet(DisasContext *ctx)
>>
>>  bool is_gather_store_insn(DisasContext *ctx)
>>  {
>> -    Packet *pkt =3D ctx->pkt;
>> -    Insn *insn =3D ctx->insn;
>> -    if (GET_ATTRIB(insn->opcode, A_CVI_NEW) &&
>> -        insn->new_value_producer_slot =3D=3D 1) {
>> +    if (GET_ATTRIB(ctx->insn->opcode, A_CVI_NEW) &&
>> +        ctx->insn->new_value_producer_slot =3D=3D 1) {
>>          /* Look for gather instruction */
>> -        for (int i =3D 0; i < pkt->num_insns; i++) {
>> -            Insn *in =3D &pkt->insn[i];
>> +        for (int i =3D 0; i < ctx->pkt.num_insns; i++) {
>> +            Insn *in =3D &ctx->pkt.insn[i];
>>              if (GET_ATTRIB(in->opcode, A_CVI_GATHER) && in->slot =3D=3D=
 1) {
>>                  return true;
>>              }
>> @@ -637,7 +627,7 @@ static bool slot_is_predicated(Packet *pkt, int slot=
_num)
>>
>>  void process_store(DisasContext *ctx, int slot_num)
>>  {
>> -    bool is_predicated =3D slot_is_predicated(ctx->pkt, slot_num);
>> +    bool is_predicated =3D slot_is_predicated(&ctx->pkt, slot_num);
>>      TCGLabel *label_end =3D NULL;
>>
>>      /*
>> @@ -714,13 +704,12 @@ static void process_store_log(DisasContext *ctx)
>>       *  slot 1 and then slot 0.  This will be important when
>>       *  the memory accesses overlap.
>>       */
>> -    Packet *pkt =3D ctx->pkt;
>> -    if (pkt->pkt_has_scalar_store_s1) {
>> -        g_assert(!pkt->pkt_has_dczeroa);
>> +    if (ctx->pkt.pkt_has_scalar_store_s1) {
>> +        g_assert(!ctx->pkt.pkt_has_dczeroa);
>>          process_store(ctx, 1);
>>      }
>> -    if (pkt->pkt_has_scalar_store_s0) {
>> -        g_assert(!pkt->pkt_has_dczeroa);
>> +    if (ctx->pkt.pkt_has_scalar_store_s0) {
>> +        g_assert(!ctx->pkt.pkt_has_dczeroa);
>>          process_store(ctx, 0);
>>      }
>>  }
>> @@ -728,7 +717,7 @@ static void process_store_log(DisasContext *ctx)
>>  /* Zero out a 32-bit cache line */
>>  static void process_dczeroa(DisasContext *ctx)
>>  {
>> -    if (ctx->pkt->pkt_has_dczeroa) {
>> +    if (ctx->pkt.pkt_has_dczeroa) {
>>          /* Store 32 bytes of zero starting at (addr & ~0x1f) */
>>          TCGv addr =3D tcg_temp_new();
>>          TCGv_i64 zero =3D tcg_constant_i64(0);
>> @@ -762,7 +751,7 @@ static void gen_commit_hvx(DisasContext *ctx)
>>
>>      /* Early exit if not needed */
>>      if (!ctx->need_commit) {
>> -        g_assert(!pkt_has_hvx_store(ctx->pkt));
>> +        g_assert(!pkt_has_hvx_store(&ctx->pkt));
>>          return;
>>      }
>>
>> @@ -796,25 +785,23 @@ static void gen_commit_hvx(DisasContext *ctx)
>>          tcg_gen_gvec_mov(MO_64, dstoff, srcoff, size, size);
>>      }
>>
>> -    if (pkt_has_hvx_store(ctx->pkt)) {
>> +    if (pkt_has_hvx_store(&ctx->pkt)) {
>>          gen_helper_commit_hvx_stores(tcg_env);
>>      }
>>  }
>>
>>  static void update_exec_counters(DisasContext *ctx)
>>  {
>> -    Packet *pkt =3D ctx->pkt;
>> -    int num_insns =3D pkt->num_insns;
>>      int num_real_insns =3D 0;
>>      int num_hvx_insns =3D 0;
>>
>> -    for (int i =3D 0; i < num_insns; i++) {
>> -        if (!pkt->insn[i].is_endloop &&
>> -            !pkt->insn[i].part1 &&
>> -            !GET_ATTRIB(pkt->insn[i].opcode, A_IT_NOP)) {
>> +    for (int i =3D 0; i < ctx->pkt.num_insns; i++) {
>> +        if (!ctx->pkt.insn[i].is_endloop &&
>> +            !ctx->pkt.insn[i].part1 &&
>> +            !GET_ATTRIB(ctx->pkt.insn[i].opcode, A_IT_NOP)) {
>>              num_real_insns++;
>>          }
>> -        if (GET_ATTRIB(pkt->insn[i].opcode, A_CVI)) {
>> +        if (GET_ATTRIB(ctx->pkt.insn[i].opcode, A_CVI)) {
>>              num_hvx_insns++;
>>          }
>>      }
>> @@ -843,12 +830,11 @@ static void gen_commit_packet(DisasContext *ctx)
>>       * store.  Therefore, we call process_store_log before anything els=
e
>>       * involved in committing the packet.
>>       */
>> -    Packet *pkt =3D ctx->pkt;
>> -    bool has_store_s0 =3D pkt->pkt_has_scalar_store_s0;
>> +    bool has_store_s0 =3D ctx->pkt.pkt_has_scalar_store_s0;
>>      bool has_store_s1 =3D
>> -        (pkt->pkt_has_scalar_store_s1 && !ctx->s1_store_processed);
>> -    bool has_hvx_store =3D pkt_has_hvx_store(pkt);
>> -    if (pkt->pkt_has_dczeroa) {
>> +        (ctx->pkt.pkt_has_scalar_store_s1 && !ctx->s1_store_processed);
>> +    bool has_hvx_store =3D pkt_has_hvx_store(&ctx->pkt);
>> +    if (ctx->pkt.pkt_has_dczeroa) {
>>          /*
>>           * The dczeroa will be the store in slot 0, check that we don't=
 have
>>           * a store in slot 1 or an HVX store.
>> @@ -875,12 +861,11 @@ static void gen_commit_packet(DisasContext *ctx)
>>                      FIELD_DP32(mask, PROBE_PKT_SCALAR_HVX_STORES,
>>                                 HAS_HVX_STORES, 1);
>>              }
>> -            if (has_store_s0 && slot_is_predicated(pkt, 0)) {
>> -                mask =3D
>> -                    FIELD_DP32(mask, PROBE_PKT_SCALAR_HVX_STORES,
>> -                               S0_IS_PRED, 1);
>> +            if (has_store_s0 && slot_is_predicated(&ctx->pkt, 0)) {
>> +                mask =3D FIELD_DP32(mask, PROBE_PKT_SCALAR_HVX_STORES, =
S0_IS_PRED,
>> +                                  1);
>>              }
>> -            if (has_store_s1 && slot_is_predicated(pkt, 1)) {
>> +            if (has_store_s1 && slot_is_predicated(&ctx->pkt, 1)) {
>>                  mask =3D
>>                      FIELD_DP32(mask, PROBE_PKT_SCALAR_HVX_STORES,
>>                                 S1_IS_PRED, 1);
>> @@ -898,7 +883,7 @@ static void gen_commit_packet(DisasContext *ctx)
>>          int args =3D 0;
>>          args =3D
>>              FIELD_DP32(args, PROBE_PKT_SCALAR_STORE_S0, MMU_IDX, ctx->m=
em_idx);
>> -        if (slot_is_predicated(pkt, 0)) {
>> +        if (slot_is_predicated(&ctx->pkt, 0)) {
>>              args =3D
>>                  FIELD_DP32(args, PROBE_PKT_SCALAR_STORE_S0, IS_PREDICAT=
ED, 1);
>>          }
>> @@ -910,18 +895,18 @@ static void gen_commit_packet(DisasContext *ctx)
>>
>>      gen_reg_writes(ctx);
>>      gen_pred_writes(ctx);
>> -    if (pkt->pkt_has_hvx) {
>> +    if (ctx->pkt.pkt_has_hvx) {
>>          gen_commit_hvx(ctx);
>>      }
>>      update_exec_counters(ctx);
>>
>> -    if (pkt->vhist_insn !=3D NULL) {
>> +    if (ctx->pkt.vhist_insn !=3D NULL) {
>>          ctx->pre_commit =3D false;
>> -        ctx->insn =3D pkt->vhist_insn;
>> -        pkt->vhist_insn->generate(ctx);
>> +        ctx->insn =3D ctx->pkt.vhist_insn;
>> +        ctx->pkt.vhist_insn->generate(ctx);
>>      }
>>
>> -    if (pkt->pkt_has_cof) {
>> +    if (ctx->pkt.pkt_has_cof) {
>>          gen_end_tb(ctx);
>>      }
>>  }
>> @@ -930,7 +915,6 @@ static void decode_and_translate_packet(CPUHexagonSt=
ate *env, DisasContext *ctx)
>>  {
>>      uint32_t words[PACKET_WORDS_MAX];
>>      int nwords;
>> -    Packet pkt;
>>      int i;
>>
>>      nwords =3D read_packet_words(env, ctx, words);
>> @@ -939,16 +923,15 @@ static void decode_and_translate_packet(CPUHexagon=
State *env, DisasContext *ctx)
>>          return;
>>      }
>>
>> -    ctx->pkt =3D &pkt;
>> -    if (decode_packet(ctx, nwords, words, &pkt, false) > 0) {
>> -        pkt.pc =3D ctx->base.pc_next;
>> +    if (decode_packet(ctx, nwords, words, &ctx->pkt, false) > 0) {
>> +        ctx->pkt.pc =3D ctx->base.pc_next;
>>          gen_start_packet(ctx);
>> -        for (i =3D 0; i < pkt.num_insns; i++) {
>> -            ctx->insn =3D &pkt.insn[i];
>> +        for (i =3D 0; i < ctx->pkt.num_insns; i++) {
>> +            ctx->insn =3D &ctx->pkt.insn[i];
>>              gen_insn(ctx);
>>          }
>>          gen_commit_packet(ctx);
>> -        ctx->base.pc_next +=3D pkt.encod_pkt_size_in_bytes;
>> +        ctx->base.pc_next +=3D ctx->pkt.encod_pkt_size_in_bytes;
>>      } else {
>>          gen_exception_end_tb(ctx, HEX_CAUSE_INVALID_PACKET);
>>      }
>> diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_fu=
ncs.py
>> index 87b7f10d7f..e7f90a0da1 100755
>> --- a/target/hexagon/gen_tcg_funcs.py
>> +++ b/target/hexagon/gen_tcg_funcs.py
>> @@ -72,7 +72,7 @@ def gen_tcg_func(f, tag, regs, imms):
>>          for immlett, bits, immshift in imms:
>>              declared.append(hex_common.imm_name(immlett))
>>
>> -        arguments =3D ", ".join(["ctx", "ctx->insn", "ctx->pkt"] + decl=
ared)
>> +        arguments =3D ", ".join(["ctx", "ctx->insn", "&ctx->pkt"] + dec=
lared)
>>          f.write(f"    emit_{tag}({arguments});\n")
>>
>>      elif hex_common.skip_qemu_helper(tag):
>> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
>> index c0e9f26aeb..e37d5a514f 100755
>> --- a/target/hexagon/hex_common.py
>> +++ b/target/hexagon/hex_common.py
>> @@ -1144,7 +1144,7 @@ def helper_args(tag, regs, imms):
>>      if need_pkt_has_multi_cof(tag):
>>          args.append(HelperArg(
>>              "i32",
>> -            "tcg_constant_tl(ctx->pkt->pkt_has_multi_cof)",
>> +            "tcg_constant_tl(ctx->pkt.pkt_has_multi_cof)",
>>              "uint32_t pkt_has_multi_cof"
>>          ))
>>      if need_pkt_need_commit(tag):
>> @@ -1156,7 +1156,7 @@ def helper_args(tag, regs, imms):
>>      if need_PC(tag):
>>          args.append(HelperArg(
>>              "i32",
>> -            "tcg_constant_tl(ctx->pkt->pc)",
>> +            "tcg_constant_tl(ctx->pkt.pc)",
>>              "target_ulong PC"
>>          ))
>>      if need_next_PC(tag):
>> --
>> 2.34.1
>>

