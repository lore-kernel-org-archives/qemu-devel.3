Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D16F459F7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBEXH-0005lL-Qs; Fri, 10 Apr 2026 12:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBEXF-0005lC-2U
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:16:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBEXC-00021K-P9
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:16:44 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AApMZ83743154
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 16:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U8apjm1hj5fZyb7cTMdh/d0UzrQUUImdMvS32G49hjY=; b=LNpCHgzOaegDMwnZ
 zeeoEjiykTYM97HyWUqvpUjSwq0zc9WssBd0ogJREWCchHI79rLh+iBrXQ0QrX4W
 OVPT67WCipcq039FotnlhYccJay5vVdouprb+gUCxyuqe0mW4acZaN7Wkkn3QWM5
 Liusd9fWyCAhy7VhKnnb1uiXs8yZqqojcPJsHSBSKygtUlravoKc60gTGtteLJeB
 sq5vDjCqwUeG656zQpUTWuIkWHCqBETbOkyV28gu1u/9dRj9cYn5Uiwn/P/5qBcX
 I9PvGnwotbFhe3wzo8162IHrD2nnjBp/wR1e3rORHgT7GLMF3tvqKi+xZQytSG2H
 41Bq8w==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deytngybp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 16:16:39 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-409037c3f0bso1722320fac.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 09:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775837799; cv=none;
 d=google.com; s=arc-20240605;
 b=dt6arLklq4y9muoPBiQnfJrDQWEft/6NA0A80ZXwKfcUysKhbCPQmsYGV3RdlZWEB6
 UcGDkE0ViZju3W2wfQXVLlD1nf67CIO/BTH/p74hEr8PBByp3R4OSa86cB8zdcLnhxpg
 X9HIljGEQqqG7Lw+6Dksbw/aPR9plAvcQd08I3MRfMhvnVe9rxt3n0H8HWMlaL6hHyCR
 rPd+TXqDES3phdBJmUaj55rydf8cB8JRvgX1UYhR6MGyt9i0rLTVLuQqkArTFCOX+zaG
 qz2L+pHDVeYLtNm+Wq5fXMKTcENgDuWyug0VG543lAJu4x//JHHu6rp0eeKdPgeaEWhp
 d8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U8apjm1hj5fZyb7cTMdh/d0UzrQUUImdMvS32G49hjY=;
 fh=GnmuetGqaJ1war6gxxmTGQNqKfwOxvG4yU92WoV01Vo=;
 b=TRuzEvoXa61M6bxHj6TyvGtT7pKWTvVhhTcUubfNLPCGpCtVjp2I67Ivjg66+tX8l7
 vwuiUjkkY6TGyv/LrboJw71xYV20zGvfend3OGFcPRYKDbgpDFLCpZq16YTwkL9IBqY6
 ntDrlV5UlEZUlJQddmLATwaNkcVwv0Jtzqd/r9PbLesBG/LAQByj61qxrATcXuURJii3
 C8XxJycWaECkJ4YTEdX9q0lEK640RUSLzAPgicu03obloMvDUmscLcP5iok/bOEFSNIR
 HPCYy5AUkakdSLr6xuMqz3lK2QQIgdy9x78smSZsF+KKSiKoJnHK+s1ukvuL57JtgMKE
 gdSg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775837799; x=1776442599; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8apjm1hj5fZyb7cTMdh/d0UzrQUUImdMvS32G49hjY=;
 b=Zz0xs42vIXhXExd1jD7xtv0VMVFk3NpJZFgKIkawZGOW6Rv5ATYt4KBppHASHBcJ09
 UJ9BvcHbTqwHoYXdw2h6JUON9mSYuG1hgJacKjPovSUpr4NdeNCQGMj7dzl3FRbUBhhV
 wpYjpwexYYAbKSr4tthrmLN8j3V5aOdKHtfuUoMZiBKtKoPbaJB76o1+ZeWLBZyjoDl8
 6rxGeQGMO3jZVU9wEmoMQiA2VU8Rh0eWSXIQXfXfAyq9EgDVO+n9nxa+cAwG+tPKamSE
 dXeS5S47JezTbwydl65jEAJONb5FVYeYZVObp0OYpKh5AA/ZpQOtzgqXShmnECRQGp9C
 rTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775837799; x=1776442599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U8apjm1hj5fZyb7cTMdh/d0UzrQUUImdMvS32G49hjY=;
 b=eF/UI3DwUMtN/WJ8Xq9FZolzz6x+PUG08lFBV06QjiOHwZ78xDKwSLiCIl3xVZ/W8W
 Dap0+pHbac98LwoU9d53vDtWNBwJo/0Tnlzmp37wlSrF9ZFg85vYQb1m4yqtBO53nfxH
 PpsHFNOhyStlv4S0Oc9wh7HndthxfsDEfVVStzjifU6pLWrzOY6YaRfrLUKsfeqtudsk
 DFeSL93WX6f5QrdouQF2vRpNDWxtE5QcHnu+xq+8IeYXS1zh/ruPil0X4x/UAe3Md4GT
 pbSbFBSqbMLVI/ch4hnjJ2MmyGxkx2pREsLQFxezNShITVvZvfdz4lI6ooSH8rOe+T/C
 tr4A==
X-Gm-Message-State: AOJu0Yy0bemLSmlB1LcgmJh5IY+mwpm/8otGzrJfkwoywoDBpFxiJbRN
 NYW5HwzA/v0Onm3vlz/bxYVpzvg80/WuqbsAnaClJaHg0mHUFBY5Gm1ElC8tJMi7QwvmWphULfp
 aUpUpw8bl7t/BlgmGTsac8e2dbVjNYUbVA42y5DsRiqwAK74fFXDnErZwxTdltBM6SSTAkuSS8H
 UUvJ/OxAf7JbOjFVCQ3xaQ+6Dd4JlU9VeS
X-Gm-Gg: AeBDiev9DO9wZUFLZ76tOAQ+LAyZV/P581H/Yw8CGWAjBOh+yimt5NUceBAath8V86+
 +jX64GfkQso7/F+1GQU19wT8eipCgGiSKQpkOc+54kAGFVZ75CtSpq9FHVKb2hRLw504tft1u8p
 Rfz4xcA1uY34P6FQCzgojP1tva7la2eeMeqClIvN00PiWgeREjWaA01THilvLTUElPaIMB9hrBi
 4Rp7Zdf
X-Received: by 2002:a05:6870:75c5:b0:41c:4423:5f0 with SMTP id
 586e51a60fabf-423e0e8bd76mr2575026fac.14.1775837798559; 
 Fri, 10 Apr 2026 09:16:38 -0700 (PDT)
X-Received: by 2002:a05:6870:75c5:b0:41c:4423:5f0 with SMTP id
 586e51a60fabf-423e0e8bd76mr2574966fac.14.1775837797911; Fri, 10 Apr 2026
 09:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
 <bd05d9aa88d98453e25e5f3189f1a5d7bdbbc9af.1775665981.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3NqVHaLtTYc46YKvHo6V8U4LZc9b7w6COnLNR4_3wmePdA@mail.gmail.com>
In-Reply-To: <CAATN3NqVHaLtTYc46YKvHo6V8U4LZc9b7w6COnLNR4_3wmePdA@mail.gmail.com>
From: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 13:16:25 -0300
X-Gm-Features: AQROBzCCZE6VUgEULIyzlsdv08AciMW3SJTym1S3KSndD7lUUnNJ8t32OselVtk
Message-ID: <CABrGZ+Ec6Ayf_FS988yLrZQj9znWqg8i=Pz7NLZaBrq-22Gh7g@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] target/hexagon/cpu: add HVX IEEE FP extension
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng,
 anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: BaBAmFOLjjoClTs_cCWejlUD11YCvbKv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE1MiBTYWx0ZWRfXxOa6aH2KhrOt
 ByifmAikLRuq1E0QCojyxzSqTaFsKe9feM3ap8LWSAGHBOvaweo2c6MhLH6qWuZSfsm53zjIHQP
 JogBVPa3zVhhlCb4t/OnXvb60elQQrB6WX8F+GD4RY8E5k6ofZqTHsNiExxjFOzrLgjefHzKpii
 ItQLo/siP569JUyX9D+CSMBenNCwhjo4Sbh6YOI0W5LIezfQP+W/EOw6tgsgSZgbkD8snbo+OdZ
 +8NiBa4ZpdE7SkqvIUw2NqsBM3tZ8kkvAC/IIVsKFk5ueuPEuafqwQ6IlJYLfwjSFEFZ0u/eZva
 3AW/EL7867OdKyunEEa6zUVk9OC2l3VOD3YZHnmnlidIRryzryyw/MYb2iMzLpLqbpJB/rZ7a4p
 d1AJ6gxmfyrezghRcjErJUXXnC5JGXJjkdsCvopueFgzMnxthqlvKPqvlUUZJ4nQX9of8aIfQi4
 nlVWYkrU2AY/XBWG1Rg==
X-Proofpoint-GUID: BaBAmFOLjjoClTs_cCWejlUD11YCvbKv
X-Authority-Analysis: v=2.4 cv=crGrVV4i c=1 sm=1 tr=0 ts=69d92267 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=TiDXa0I_IdYBfGhkClIA:9 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100152
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On Wed, Apr 8, 2026 at 6:56=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmail=
.com> wrote:
>
>
>
> On Wed, Apr 8, 2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino <mathe=
us.bernardino@oss.qualcomm.com> wrote:
>>
>> This flag will be used to control the HVX IEEE float instructions, which
>> are only available at some Hexagon cores. When unavailable, the
>> instruction effectively only set the destination registers to 0.
>>
>> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualco=
mm.com>
>> ---
>>  target/hexagon/cpu.h             |  1 +
>>  target/hexagon/translate.h       |  1 +
>>  target/hexagon/attribs_def.h.inc |  3 +++
>>  target/hexagon/cpu.c             |  1 +
>>  target/hexagon/translate.c       |  1 +
>>  target/hexagon/gen_tcg_funcs.py  | 11 ++++++++++
>>  target/hexagon/hex_common.py     | 35 ++++++++++++++++++++++++++++++++
>>  7 files changed, 53 insertions(+)
>>
>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
>> index 85afd59277..77822a48b6 100644
>> --- a/target/hexagon/cpu.h
>> +++ b/target/hexagon/cpu.h
>> @@ -127,6 +127,7 @@ struct ArchCPU {
>>      bool lldb_compat;
>>      target_ulong lldb_stack_adjust;
>>      bool short_circuit;
>> +    bool ieee_fp_extension;
>>  };
>>
>>  #include "cpu_bits.h"
>> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
>> index b37cb49238..516aab7038 100644
>> --- a/target/hexagon/translate.h
>> +++ b/target/hexagon/translate.h
>> @@ -70,6 +70,7 @@ typedef struct DisasContext {
>>      target_ulong branch_dest;
>>      bool is_tight_loop;
>>      bool short_circuit;
>> +    bool ieee_fp_extension;
>>      bool read_after_write;
>>      bool has_hvx_overlap;
>>      TCGv new_value[TOTAL_PER_THREAD_REGS];
>> diff --git a/target/hexagon/attribs_def.h.inc b/target/hexagon/attribs_d=
ef.h.inc
>> index 9e3a05f882..c85cd5d17c 100644
>> --- a/target/hexagon/attribs_def.h.inc
>> +++ b/target/hexagon/attribs_def.h.inc
>> @@ -173,5 +173,8 @@ DEF_ATTRIB(NOTE_SHIFT_RESOURCE, "Uses the HVX shift =
resource.", "", "")
>>  DEF_ATTRIB(RESTRICT_NOSLOT1_STORE, "Packet must not have slot 1 store",=
 "", "")
>>  DEF_ATTRIB(RESTRICT_LATEPRED, "Predicate can not be used as a .new.", "=
", "")
>>
>> +/* HVX IEEE FP extension attributes */
>> +DEF_ATTRIB(HVX_IEEE_FP, "HVX IEEE FP extension instruction", "", "")
>> +
>>  /* Keep this as the last attribute: */
>>  DEF_ATTRIB(ZZ_LASTATTRIB, "Last attribute in the file", "", "")
>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>> index ffd14bb467..8b72a5d3c8 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -54,6 +54,7 @@ static const Property hexagon_cpu_properties[] =3D {
>>      DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_ad=
just, 0,
>>                           qdev_prop_uint32, target_ulong),
>>      DEFINE_PROP_BOOL("short-circuit", HexagonCPU, short_circuit, true),
>> +    DEFINE_PROP_BOOL("ieee-fp", HexagonCPU, ieee_fp_extension, true),
>>  };
>>
>>  const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS] =3D {
>> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
>> index 633401451d..fa8f615a9e 100644
>> --- a/target/hexagon/translate.c
>> +++ b/target/hexagon/translate.c
>> @@ -988,6 +988,7 @@ static void hexagon_tr_init_disas_context(DisasConte=
xtBase *dcbase,
>>      ctx->branch_cond =3D TCG_COND_NEVER;
>>      ctx->is_tight_loop =3D FIELD_EX32(hex_flags, TB_FLAGS, IS_TIGHT_LOO=
P);
>>      ctx->short_circuit =3D hex_cpu->short_circuit;
>> +    ctx->ieee_fp_extension =3D hex_cpu->ieee_fp_extension;
>>  }
>>
>>  static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu)
>> diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_fu=
ncs.py
>> index 87b7f10d7f..b752ec883c 100755
>> --- a/target/hexagon/gen_tcg_funcs.py
>> +++ b/target/hexagon/gen_tcg_funcs.py
>> @@ -22,6 +22,14 @@
>>  import string
>>  import hex_common
>>
>> +def gen_disabled_ieee_insn(f, tag, regs):
>> +    f.write("    if (!ctx->ieee_fp_extension) {\n")
>> +    for regtype, regid in regs:
>> +        reg =3D hex_common.get_register(tag, regtype, regid)
>> +        if reg.is_hvx_reg() and reg.is_written():
>> +            reg.gen_zero(f)
>
>
> What happens to the non-HVX registers that are written (e.g., address for=
 a post-increment load)?  I assume they should also be set to zero.

None of these instructions write to non-HVX registers.

>>
>> +    f.write("        return;\n")
>> +    f.write("    }\n")
>>
>>  ##
>>  ## Generate the TCG code to call the helper
>> @@ -62,6 +70,9 @@ def gen_tcg_func(f, tag, regs, imms):
>>          i =3D 1 if immlett.isupper() else 0
>>          f.write(f"    int {hex_common.imm_name(immlett)} =3D insn->imme=
d[{i}];\n")
>>
>> +    if "A_HVX_IEEE_FP" in hex_common.attribdict[tag]:
>> +        gen_disabled_ieee_insn(f, tag, regs)
>> +
>>      if hex_common.is_idef_parser_enabled(tag):
>>          declared =3D []
>>          ## Handle registers
>> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
>> index c0e9f26aeb..32a61505ce 100755
>> --- a/target/hexagon/hex_common.py
>> +++ b/target/hexagon/hex_common.py
>> @@ -723,6 +723,11 @@ def decl_tcg(self, f, tag, regno):
>>                  TCGv_ptr {self.reg_tcg()} =3D tcg_temp_new_ptr();
>>                  tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_o=
ff()});
>>              """))
>> +    def gen_zero(self, f):
>> +        f.write(code_fmt(f"""\
>> +                tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
>> +                    sizeof(MMVector), sizeof(MMVector), 0);
>> +            """))
>>      def gen_write(self, f, tag):
>>          pass
>>      def helper_hvx_desc(self, f):
>> @@ -789,6 +794,11 @@ def decl_tcg(self, f, tag, regno):
>>                  TCGv_ptr {self.reg_tcg()} =3D tcg_temp_new_ptr();
>>                  tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_o=
ff()});
>>              """))
>> +    def gen_zero(self, f):
>> +        f.write(code_fmt(f"""\
>> +                tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
>> +                    sizeof(MMVector), sizeof(MMVector), 0);
>> +            """))
>>      def gen_write(self, f, tag):
>>          pass
>>      def helper_hvx_desc(self, f):
>> @@ -821,6 +831,11 @@ def decl_tcg(self, f, tag, regno):
>>                                   vreg_src_off(ctx, {self.reg_num}),
>>                                   sizeof(MMVector), sizeof(MMVector));
>>              """))
>> +    def gen_zero(self, f):
>> +        f.write(code_fmt(f"""\
>> +                tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
>> +                    sizeof(MMVector), sizeof(MMVector), 0);
>> +            """))
>>      def gen_write(self, f, tag):
>>          f.write(code_fmt(f"""\
>>              gen_vreg_write(ctx, {self.hvx_off()}, {self.reg_num},
>> @@ -854,6 +869,11 @@ def decl_tcg(self, f, tag, regno):
>>                  TCGv_ptr {self.reg_tcg()} =3D tcg_temp_new_ptr();
>>                  tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_o=
ff()});
>>              """))
>> +    def gen_zero(self, f):
>> +        f.write(code_fmt(f"""\
>> +            tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
>> +                sizeof(MMVectorPair), sizeof(MMVectorPair), 0);
>> +        """))
>>      def gen_write(self, f, tag):
>>          pass
>>      def helper_hvx_desc(self, f):
>> @@ -913,6 +933,11 @@ def decl_tcg(self, f, tag, regno):
>>                  TCGv_ptr {self.reg_tcg()} =3D tcg_temp_new_ptr();
>>                  tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_o=
ff()});
>>              """))
>> +    def gen_zero(self, f):
>> +        f.write(code_fmt(f"""\
>> +            tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
>> +                sizeof(MMVectorPair), sizeof(MMVectorPair), 0);
>> +        """))
>>      def gen_write(self, f, tag):
>>          f.write(code_fmt(f"""\
>>              gen_vreg_write_pair(ctx, {self.hvx_off()}, {self.reg_num},
>> @@ -946,6 +971,11 @@ def decl_tcg(self, f, tag, regno):
>>                  TCGv_ptr {self.reg_tcg()} =3D tcg_temp_new_ptr();
>>                  tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_o=
ff()});
>>              """))
>> +    def gen_zero(self, f):
>> +        f.write(code_fmt(f"""\
>> +            tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
>> +                sizeof(MMQReg), sizeof(MMQReg), 0);
>> +        """))
>
>
> Do any of these instructions write QRegs?  If not, this isn't needed.

They do not. Let me remove this.

