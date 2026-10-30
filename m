Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F25606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MqUbkF+6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R+tn/NVe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMaSO-0002nK-9x; Thu, 29 Oct 2026 20:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMaSM-0002mG-OE
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:26:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMaSJ-0002WT-Fq
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:26:54 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TNKi2p4163324
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 00:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 foXxwhCW3khCIFXES04OM6mBb3CYvtvvXN2R1XX2dDY=; b=MqUbkF+6SZLhDT5F
 c0wZ1dneoItCKE5cigFe4K6IR9TDvAR+07B7FHd/SBliWfd6i6cjrTH/vGX8qmid
 2cdexWDgIW2/qOctcI8aeDldIjP0dQaS7O7QsN+KZgDDmObIJwt94/r4spYO6QlM
 ByFtabUtoE7cch3GGs91IGBbW8bSPuC5phkCv5m0jHtJWCHlgXF/drm2Z2MIS200
 ZEy+cDTFswbwBYtMi+PFIxZ/doxosETbxrCHAmHJPNHtzqXRLXLzDoYrPv5CrUDr
 7dwWwAGM2jdczgbrh8c3QksKIYMmm8Krybh9G8HktCNAmgzGGmHURjs/oZFpmpZQ
 q8qMyg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pgetp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 00:26:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53664911d46so3423401cf.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793320009; x=1793924809; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=foXxwhCW3khCIFXES04OM6mBb3CYvtvvXN2R1XX2dDY=;
 b=R+tn/NVea4UG7wyKfCPnW5ZMPHyKS7RnnEKFv2v4WO/181vJyEWrG03CsWR2YkAdpo
 swvKOYxiRBWyDMoqx8HQpM0+S9XjW2ZOGlzk9Ruq9Ka3B1GbK94nJxgFmIwMNF0pb6A5
 rr7jXZGCS2vbLmy2wvGCio8T9CsLBFrTELh67fmsa47Y6KQPhbZj7d91lABBA/XlXZvW
 SzqTgUOlSfC5jXItzutptBVPHzwWgMAxL4b4TEa4dbpDCREUxI+QVmYIp9Kx0I5dHTxu
 ugzJ850uY40xFqRBaJ6PYCP141dUzaCYV7851zS1dnFdFvTVpSkX6NB73N7g5cbCW4eu
 AaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793320009; x=1793924809;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=foXxwhCW3khCIFXES04OM6mBb3CYvtvvXN2R1XX2dDY=;
 b=D33NCDGrv5EwW1e1BW0sZdJzI5Ti8NEzirIqTEwG4/GuiB1pgZFnJYZfNJEbqvRKWH
 59NIYHSwzX5iYf7UbEJl8g4qF2yPVqIwubxlAYckSZP0oyw+lXAfDj9+/SV8YkYe6bhh
 Ow97dQkifNTah3HwIeNR/PDPfCL4seiAjs7YBoJyKIUdgNf00yF4cyksTJsuuapdUsSq
 QnQ+P5WGr+ixlWX2oD6/MfyOqOp7irV3ZXcl8Sq9698g89TgpiYM2+C/keiG30FhJfxx
 MsgjgMuQbfrYTgnjVe1TnEY3s3ay48Jwi71L/pt9sP03NZ102bz6wr2K03crE6EPGBie
 6x9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxW/aWp3X+M/iXirzrZ3NLjJVZNJsGiuNN90vVdMnrnfuNSWNdlqEfhIdg64+Qwre5eib2UVkyC45dB@nongnu.org
X-Gm-Message-State: AFq9FYLwQXJ/mCejHO7Owb7S1OlgJH0uSqMDtFXUaLEndZ2x1gKJRWbf
 BoprpmFoOU4nt5VR2a8beipGyVcPs/TfyFvIMVlFnMIVQO+s8UKzFy+WAOF9yQP9npOgiWue+B3
 m9zPXrBHgGQs52ZlgH6APeFdbUB+YX37lpCUZapkcTwb56DwbxDR8p9sSHA==
X-Gm-Gg: AYBFou3bG09EvJ4U6bJPCxJF2BZflMkiEqNEeoSyJKHoJ4AZN270Hn1axEAy5n/vTSt
 T7ZD95c8SYzAL2l2abiXrBxSqH4VM0v8kVwbqQe6H1XrGnQW+cJu5zsEaEptJfcNvHeVBNCwphX
 fgCROhU3FEIOYPrldWEWAQjsv8Z2oV1HamuLiTu8oqldWngSEqRxxUhm/R2T5efEeiBLLrTu8Sx
 212PAzAOgIGMbRvp8ifnX56HqwOuUqFAmWXS3fDaEMgFXIGdRqf6WAIPH4wrIYWD/lXAIPjlFcS
 taXyEDwIBiwhP8GpwR5g7HEJFMXS2zPFGryzAjd6eJEYd4Fd5x2x54mg3vOjm9J66is1VxDCgyt
 RAz+WeiK12QRGV3u+kX1tLoWOYtqsnJ05iuBYMZcDw0+LsSJQm73I0/Cwne7O7Acsv5Uju9nYtX
 Ty2GAyMqYQPG1OcGGYVfaohWiYJc9tPd/0PC3zNuiFvWBL23qFdJ1h
X-Received: by 2002:a05:622a:449:b0:536:645f:c901 with SMTP id
 d75a77b69052e-542b7ff3d7dmr12545551cf.67.1793320008361; 
 Thu, 29 Oct 2026 17:26:48 -0700 (PDT)
X-Received: by 2002:a05:622a:449:b0:536:645f:c901 with SMTP id
 d75a77b69052e-542b7ff3d7dmr12545111cf.67.1793320007642; 
 Thu, 29 Oct 2026 17:26:47 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-542f7fb982csm1118401cf.28.2026.10.29.17.26.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 17:26:46 -0700 (PDT)
Message-ID: <331950f7-0279-453a-8493-41b34c96e11c@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 19:26:44 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] target/hexagon: decode HLX packets and add load and
 store
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-14-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-14-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfX74I/W/8Xhf7f
 rOiN6xQ+VvD8xCu8Eyt+5AOAok8FakpMylZVyS+XSbCpenxrLl0z7L9nvnraqOB+bEwILpftZ/j
 pRR5Dxz8lLjpmdqI2u3HDW0T5m2wJTmHctviLOXb+uWxik3DeqTK3zy0G7h1SwAwM6h0moBw3Kx
 JVaq74Jwu0GpOsh6eKHRB819V0AJpRfSjnr8NEes8/HUkIaNdTnQs9uj9otS8Ewbz4PnPRkFqlk
 OzNMPrNKcLel/+i+di6X7TnsCTJ7lHSpZux0LSl5my5qzQ/dJTzmCfSftNCcRv10vQ0XCskXYbo
 SLNRHTJUs9MeiwINXCiXkOneJamL6ZlRvDG9E4DP7kmONkOIFMmIoOHKImmjyYj9NJ1Vz0ynJM5
 TPgbZLRwqTquHuBx6v3/wH+epynI1BvyeFj71Cotya/EsfBzatFY5mg9vAuhxkPjFXny19w4U4J
 N0i1v1aJGP9eEf18mTQ==
X-Proofpoint-ORIG-GUID: UWLHSihvnYnZTtlTOVJq7eUZH0Sj5WsH
X-Proofpoint-GUID: UWLHSihvnYnZTtlTOVJq7eUZH0Sj5WsH
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae3e44a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=4jJKWQJYo4hhRDydyqsA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfXxITGkyka7/E/
 +eUBQz3DOemYbD4fi1YEeuzt0Bdh1hyn/NDp/zcuzs+42nNGPVHWw3CkHN7ByHCzxxA0XgF9gZQ
 Gmm1thfkrpXE4msTyk/K658M9T4aoQU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300001
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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


On 10/29/2026 12:44 PM, Marco Liebel wrote:
> Generate the HLX decoder and apply its packet rules. Add HLX loads and
> stores, including .tmp load forwarding and .new store handling.
>
> HLX .new fields name the forwarded L register. A store without a
> producer writes zeroes.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/attribs_def.h.inc           |   5 +
>   target/hexagon/decode.c                    | 118 ++++++++++++++++-----
>   target/hexagon/gen_dectree_import.c        |   9 +-
>   target/hexagon/gen_hlx_ext.py              |  25 +++++
>   target/hexagon/gen_idef_parser_funcs.py    |   3 +
>   target/hexagon/gen_tcg_funcs.py            |   3 +
>   target/hexagon/imported/allext.idef        |   6 ++
>   target/hexagon/imported/allextenc.def      |   4 +
>   target/hexagon/imported/hlx/encode_ext.def |  18 ++++
>   target/hexagon/imported/hlx_ext.idef       |  45 ++++++++
>   target/hexagon/insn.h                      |   1 +
>   target/hexagon/meson.build                 |  39 +++++++
>   target/hexagon/opcodes.h                   |   1 +
>   target/hexagon/translate.c                 |  12 +++
>   14 files changed, 259 insertions(+), 30 deletions(-)
>   create mode 100755 target/hexagon/gen_hlx_ext.py
>   create mode 100644 target/hexagon/imported/hlx/encode_ext.def
>   create mode 100644 target/hexagon/imported/hlx_ext.idef

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/target/hexagon/attribs_def.h.inc b/target/hexagon/attribs_def.h.inc
> index a02261ee5e..e9779a33ee 100644
> --- a/target/hexagon/attribs_def.h.inc
> +++ b/target/hexagon/attribs_def.h.inc
> @@ -19,6 +19,9 @@
>   DEF_ATTRIB(AA_DUMMY, "Dummy Zeroth Attribute", "", "")
>   
>   /* Misc */
> +DEF_ATTRIB(FAKEINSN, "Not a real instruction", "", "")
> +DEF_ATTRIB(MAPPING, "Not real -- asm mapped", "", "")
> +DEF_ATTRIB(CONDMAPPING, "Not real -- mapped based on values", "", "")
>   DEF_ATTRIB(EXTENSION, "Extension instruction", "", "")
>   
>   DEF_ATTRIB(NA_NT, "Non-Allocating Non-Temporal instruction", "", "")
> @@ -228,5 +231,7 @@ DEF_ATTRIB(HVX_IEEE_FP_OUT_32, "HVX IEEE FP 32-bit output", "", "")
>   DEF_ATTRIB(CVI_VX_NO_TMP_LD, "HVX multiply without tmp load", "", "")
>   DEF_ATTRIB(HVX_FLT, "This a floating point HVX instruction.", "", "")
>   
> +DEF_ATTRIB(NO_IDEF_PARSER, "Skip idef-parser for this instruction", "", "")
> +
>   /* Keep this as the last attribute: */
>   DEF_ATTRIB(ZZ_LASTATTRIB, "Last attribute in the file", "", "")
> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
> index 0ac87bbee0..0c3dc67e12 100644
> --- a/target/hexagon/decode.c
> +++ b/target/hexagon/decode.c
> @@ -23,6 +23,7 @@
>   #include "insn.h"
>   #include "printinsn.h"
>   #include "mmvec/decode_ext_mmvec.h"
> +#include "hlx/decode_ext_hlx.h"
>   
>   #define fZXTN(N, M, VAL) ((VAL) & ((1LL << (N)) - 1))
>   
> @@ -69,6 +70,7 @@ static int shift_left(DisasContext *ctx, int x, int n, int immno)
>   /* Include the generated decoder for 32 bit insn */
>   #include "decode_normal_generated.c.inc"
>   #include "decode_hvx_generated.c.inc"
> +#include "decode_hlx_generated.c.inc"
>   
>   /* Include the generated decoder for 16 bit insn */
>   #include "decode_subinsn_a_generated.c.inc"
> @@ -102,40 +104,77 @@ void decode_send_insn_to(Packet *packet, int start, int newloc)
>       }
>   }
>   
> -/* Fill newvalue registers with the correct regno */
> -static void
> +/* An HLX .new N-field names its producer register. */
> +static int hlx_find_new_value_producer(Packet *packet, int consumer,
> +                                       int lreg)
> +{
> +    for (int i = 0; i < packet->num_insns; i++) {
> +        Insn *insn = &packet->insn[i];
> +
> +        if (i != consumer && GET_ATTRIB(insn->opcode, A_HLX) &&
> +            insn->dest_idx != -1 && insn->regno[insn->dest_idx] == lreg) {
> +            return i;
> +        }
> +    }
> +    return -1;
> +}
> +
> +/* Fill newvalue registers with the correct regno. */
> +static bool
>   decode_fill_newvalue_regno(Packet *packet)
>   {
>       int i, use_regidx, offset, def_idx, dst_idx;
>   
> -    for (i = 1; i < packet->num_insns; i++) {
> +    for (i = 0; i < packet->num_insns; i++) {
>           if (GET_ATTRIB(packet->insn[i].opcode, A_DOTNEWVALUE) &&
> -            !GET_ATTRIB(packet->insn[i].opcode, A_EXTENSION)) {
> +            (!GET_ATTRIB(packet->insn[i].opcode, A_EXTENSION) ||
> +             GET_ATTRIB(packet->insn[i].opcode, A_HLX))) {
>   
> -            g_assert(packet->insn[i].new_read_idx != -1);
> +            if (i == 0 && !GET_ATTRIB(packet->insn[i].opcode, A_HLX)) {
> +                continue;
> +            }
> +            if (packet->insn[i].new_read_idx == -1) {
> +                return false;
> +            }
>               use_regidx = packet->insn[i].new_read_idx;
>   
> -            /*
> -             * What's encoded at the N-field is the offset to who's producing
> -             * the value.  Shift off the LSB which indicates odd/even register,
> -             * then walk backwards and skip over the constant extenders.
> -             */
> -            offset = packet->insn[i].regno[use_regidx] >> 1;
> -            def_idx = i - offset;
> -            for (int j = 0; j < offset; j++) {
> -                if (GET_ATTRIB(packet->insn[i - j - 1].opcode, A_IT_EXTENDER)) {
> -                    def_idx--;
> +            if (GET_ATTRIB(packet->insn[i].opcode, A_HLX)) {
> +                def_idx = hlx_find_new_value_producer(
> +                    packet, i, packet->insn[i].regno[use_regidx]);
> +                if (def_idx < 0) {
> +                    /* No producer means a 2KB zero store. */
> +                    packet->insn[i].hlx_new_zero = true;
> +                    continue;
> +                }
> +            } else {
> +                /*
> +                 * What's encoded at the N-field is the offset to who's
> +                 * producing the value.  Shift off the LSB which indicates
> +                 * odd/even register, then walk backwards and skip over the
> +                 * constant extenders.
> +                 */
> +                offset = packet->insn[i].regno[use_regidx] >> 1;
> +                if (offset == 0 || offset > i) {
> +                    return false;
> +                }
> +                def_idx = i - offset;
> +                for (int j = 0; j < offset; j++) {
> +                    if (GET_ATTRIB(packet->insn[i - j - 1].opcode,
> +                                   A_IT_EXTENDER)) {
> +                        def_idx--;
> +                    }
>                   }
> -            }
>   
> -            /*
> -             * Check for a badly encoded N-field which points to an instruction
> -             * out-of-range
> -             */
> -            g_assert(!((def_idx < 0) || (def_idx > (packet->num_insns - 1))));
> +                /*
> +                 * Check for a badly encoded N-field which points to an
> +                 * instruction out-of-range
> +                 */
> +                if (def_idx < 0 || packet->insn[def_idx].dest_idx == -1) {
> +                    return false;
> +                }
> +            }
>   
>               /* Now patch up the consumer with the register number */
> -            g_assert(packet->insn[def_idx].dest_idx != -1);
>               dst_idx = packet->insn[def_idx].dest_idx;
>               packet->insn[i].regno[use_regidx] =
>                   packet->insn[def_idx].regno[dst_idx];
> @@ -147,6 +186,7 @@ decode_fill_newvalue_regno(Packet *packet)
>                   packet->insn[def_idx].slot;
>           }
>       }
> +    return true;
>   }
>   
>   /* Split CJ into a compare and a jump */
> @@ -422,7 +462,12 @@ static void decode_remove_extenders(Packet *packet)
>   static SlotMask get_valid_slots(const Packet *pkt, unsigned int slot)
>   {
>       if (GET_ATTRIB(pkt->insn[slot].opcode, A_EXTENSION)) {
> -        return mmvec_ext_decode_find_iclass_slots(pkt->insn[slot].opcode);
> +        if (GET_ATTRIB(pkt->insn[slot].opcode, A_HLX)) {
> +            return hlx_ext_decode_find_iclass_slots(
> +                       pkt->insn[slot].opcode);
> +        }
> +        return mmvec_ext_decode_find_iclass_slots(
> +                   pkt->insn[slot].opcode);
>       } else {
>           return find_iclass_slots(pkt->insn[slot].opcode,
>                                    pkt->insn[slot].iclass);
> @@ -491,7 +536,8 @@ decode_insns(DisasContext *ctx, Insn *insn, uint32_t encoding)
>   {
>       if (parse_bits(encoding) != 0) {
>           if (decode_normal(ctx, encoding) ||
> -            decode_hvx(ctx, encoding)) {
> +            decode_hvx(ctx, encoding) ||
> +            decode_hlx(ctx, encoding)) {
>               insn->generate = opcode_genptr[insn->opcode];
>               insn->iclass = iclass_bits(encoding);
>               return 1;
> @@ -614,8 +660,11 @@ decode_set_slot_number(Packet *pkt)
>           }
>       }
>   
> -    /* Fix the exceptions - mem insns to slot 0,1 */
> +    /* HLX instructions already have extension-assigned slots. */
>       for (i = pkt->num_insns - 1; i >= 0; i--) {
> +        if (GET_ATTRIB(pkt->insn[i].opcode, A_HLX)) {
> +            continue;
> +        }
>           /* First memory instruction always goes to slot 0 */
>           if ((GET_ATTRIB(pkt->insn[i].opcode, A_MEMLIKE) ||
>                GET_ATTRIB(pkt->insn[i].opcode, A_MEMLIKE_PACKET_RULES)) &&
> @@ -671,8 +720,9 @@ decode_set_slot_number(Packet *pkt)
>           }
>       }
>       /* Is slot0 empty and slot1 used? */
> -    if ((!slot0_found) && slot1_found) {
> -        /* Then push it to slot0 */
> +    if ((!slot0_found) && slot1_found &&
> +        !GET_ATTRIB(pkt->insn[slot1_iidx].opcode, A_HLX)) {
> +        /* Push it to slot 0. HLX loads remain in slot 1. */
>           pkt->insn[slot1_iidx].slot = 0;
>       }
>   
> @@ -688,6 +738,10 @@ bool opcode_supported(uint16_t opcode, const HexagonCPUDef *hex_def)
>       if (hex_version == HEX_VER_ANY) {
>           return true;
>       }
> +    /* HLX was added in V85. */
> +    if (GET_ATTRIB(opcode, A_HLX) && hex_version < HEX_VER_V85) {
> +        return false;
> +    }
>       if ((info.introduced != HEX_VER_NONE && hex_version < info.introduced) ||
>           (info.removed != HEX_VER_NONE && hex_version >= info.removed)) {
>           return false;
> @@ -773,9 +827,12 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
>   
>       pkt->encod_pkt_size_in_bytes = words_read * 4;
>       pkt->pkt_has_hvx = false;
> +    pkt->pkt_has_hlx = false;
>       for (i = 0; i < num_insns; i++) {
>           pkt->pkt_has_hvx |=
>               GET_ATTRIB(pkt->insn[i].opcode, A_CVI);
> +        pkt->pkt_has_hlx |=
> +            GET_ATTRIB(pkt->insn[i].opcode, A_HLX);
>       }
>   
>       /*
> @@ -808,11 +865,16 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
>               return 0;
>           }
>       }
> -    decode_fill_newvalue_regno(pkt);
> +    if (!decode_fill_newvalue_regno(pkt)) {
> +        return 0;
> +    }
>   
>       if (pkt->pkt_has_hvx) {
>           mmvec_ext_decode_checks(pkt, disas_only);
>       }
> +    if (pkt->pkt_has_hlx && !hlx_ext_decode_checks(pkt, disas_only)) {
> +        return 0;
> +    }
>   
>       if (!disas_only) {
>           decode_shuffle_for_execution(pkt);
> diff --git a/target/hexagon/gen_dectree_import.c b/target/hexagon/gen_dectree_import.c
> index 87f20c14f1..8ed369f699 100644
> --- a/target/hexagon/gen_dectree_import.c
> +++ b/target/hexagon/gen_dectree_import.c
> @@ -79,6 +79,7 @@ static const char * const opcode_enc_class_names[XX_LAST_ENC_CLASS] = {
>       "SUBINSN_S2",
>       "EXT_noext",
>       "EXT_mmvec",
> +    "EXT_hlx",
>   };
>   
>   static const char *get_opcode_enc(int opcode)
> @@ -94,11 +95,15 @@ static const char *get_opcode_enc_class(int opcode)
>   {
>       const char *tmp = opcode_encodings[opcode].encoding;
>       if (tmp == NULL) {
> -        const char *test = "V6_";        /* HVX */
> +        const char *test_hvx = "V6_";
> +        const char *test_hlx = "LX_";
>           const char *name = opcode_names[opcode];
> -        if (strncmp(name, test, strlen(test)) == 0) {
> +        if (strncmp(name, test_hvx, strlen(test_hvx)) == 0) {
>               return "EXT_mmvec";
>           }
> +        if (strncmp(name, test_hlx, strlen(test_hlx)) == 0) {
> +            return "EXT_hlx";
> +        }
>       }
>       return opcode_enc_class_names[opcode_encodings[opcode].enc_class];
>   }
> diff --git a/target/hexagon/gen_hlx_ext.py b/target/hexagon/gen_hlx_ext.py
> new file mode 100755
> index 0000000000..d0385c3ac7
> --- /dev/null
> +++ b/target/hexagon/gen_hlx_ext.py
> @@ -0,0 +1,25 @@
> +#!/usr/bin/env python3
> +
> +##
> +##  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +##  SPDX-License-Identifier: GPL-2.0-or-later
> +##
> +
> +"""Process HLX extension instruction definitions."""
> +
> +import sys
> +
> +def main():
> +    """Copy preprocessed HLX instruction definitions."""
> +    input_file = sys.argv[1]
> +    output_file = sys.argv[2]
> +
> +    with open(input_file, "rt") as infile:
> +        with open(output_file, "w") as outfile:
> +            for line in infile:
> +                # Skip preprocessor directives.
> +                if not line.startswith("#"):
> +                    outfile.write(line)
> +
> +if __name__ == "__main__":
> +    main()
> diff --git a/target/hexagon/gen_idef_parser_funcs.py b/target/hexagon/gen_idef_parser_funcs.py
> index 9293be4c39..3f5879ce19 100644
> --- a/target/hexagon/gen_idef_parser_funcs.py
> +++ b/target/hexagon/gen_idef_parser_funcs.py
> @@ -62,6 +62,9 @@ def main():
>           for tag in hex_common.tags:
>               if hex_common.tag_ignore(tag):
>                   continue
> +            ## Skip instructions that explicitly request no idef-parser
> +            if "A_NO_IDEF_PARSER" in hex_common.attribdict[tag]:
> +                continue
>               ## Skip the priv instructions
>               if "A_PRIV" in hex_common.attribdict[tag]:
>                   continue
> diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
> index 4305eda996..eb2e5f3a7e 100755
> --- a/target/hexagon/gen_tcg_funcs.py
> +++ b/target/hexagon/gen_tcg_funcs.py
> @@ -118,6 +118,9 @@ def gen_tcg_func(f, tag, regs, imms):
>           arguments = ", ".join(["ctx", "ctx->insn", "&ctx->pkt"] + declared)
>           f.write(f"    emit_{tag}({arguments});\n")
>   
> +    elif hex_common.is_hlx_inline_tag(tag):
> +        hex_common.gen_hlx_inline(f, tag, regs)
> +
>       elif hex_common.skip_qemu_helper(tag):
>           if "A_FPOP" in hex_common.attribdict[tag]:
>               f.write("    TCGv pkt_need_commit = ")
> diff --git a/target/hexagon/imported/allext.idef b/target/hexagon/imported/allext.idef
> index 9d4b23e9de..fa17b0de5d 100644
> --- a/target/hexagon/imported/allext.idef
> +++ b/target/hexagon/imported/allext.idef
> @@ -23,3 +23,9 @@
>   #include "mmvec/ext.idef"
>   #undef EXTNAME
>   #undef EXTSTR
> +
> +#define EXTNAME hlx
> +#define EXTSTR "hlx"
> +#include "generated_hlx_ext.idef"
> +#undef EXTNAME
> +#undef EXTSTR
> diff --git a/target/hexagon/imported/allextenc.def b/target/hexagon/imported/allextenc.def
> index 39a3e93fad..c72807c4b1 100644
> --- a/target/hexagon/imported/allextenc.def
> +++ b/target/hexagon/imported/allextenc.def
> @@ -18,3 +18,7 @@
>   #define EXTNAME mmvec
>   #include "mmvec/encode_ext.def"
>   #undef EXTNAME
> +
> +#define EXTNAME hlx
> +#include "hlx/encode_ext.def"
> +#undef EXTNAME
> diff --git a/target/hexagon/imported/hlx/encode_ext.def b/target/hexagon/imported/hlx/encode_ext.def
> new file mode 100644
> index 0000000000..10d13db376
> --- /dev/null
> +++ b/target/hexagon/imported/hlx/encode_ext.def
> @@ -0,0 +1,18 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#define CONCAT(A,B) A##B
> +#define EXTEXTNAME(X) CONCAT(EXT_,X)
> +#define DEF_ENC(TAG,STR) DEF_EXT_ENC(TAG,EXTEXTNAME(EXTNAME),STR)
> +
> +DEF_ENC(LX_L16b_tmp,"1001100----sssssPP-10----000dddd")
> +DEF_ENC(LX_L16b_p_tmp,"1001100----sssssPP-10vv--100dddd")
> +
> +DEF_ENC(LX_S16b_new,"1010-1001--sssssPP000----000uuuu")
> +DEF_ENC(LX_S16b_p_new,"1010-1001--sssssPP000vv--100uuuu")
> +
> +#undef DEF_ENC
> +#undef EXTEXTNAME
> +#undef CONCAT
> diff --git a/target/hexagon/imported/hlx_ext.idef b/target/hexagon/imported/hlx_ext.idef
> new file mode 100644
> index 0000000000..3685596e5e
> --- /dev/null
> +++ b/target/hexagon/imported/hlx_ext.idef
> @@ -0,0 +1,45 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef EXTINSN
> +#define EXTINSN Q6INSN
> +#define __SELF_DEF_EXTINSN 1
> +#endif
> +
> +#ifndef NO_HLX
> +
> +/* HLX vectors hold 1024 halfwords or 512 words. */
> +#define HLX_FOR_EACH_CODE(CODE) \
> +{ \
> +    fHIDE(int i;) \
> +    fLVFOREACH(1024, i) { \
> +        CODE ; \
> +    } \
> +}
> +
> +EXTINSN(LX_L16b_tmp,"Ld16.tmp=mem(Rs32)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_NOTE_HLX_MEM,A_HLX_MEM,A_VTCM_ALLBANK_ACCESS,A_LOAD,A_RESTRICT_SLOT1ONLY,A_HLX_TMP),"Aligned HLX load",
> +{ fEA_REG(RsV); fLOADMML(EA,LdV,false,false);})
> +
> +EXTINSN(LX_L16b_p_tmp,"if (Pv4) Ld16.tmp=mem(Rs32)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_NOTE_HLX_MEM,A_HLX_MEM,A_VTCM_ALLBANK_ACCESS,A_LOAD,A_RESTRICT_SLOT1ONLY,A_HLX_TMP,A_CONDEXEC),"Aligned HLX load",
> +{ fEA_REG(RsV); if(fLSBOLD(PvV)){fLOADMML(EA,LdV,false,false);} else {LOAD_CANCEL(EA);};})
> +
> +EXTINSN(LX_S16b_new,"mem(Rs32)=Ku16.new",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_NOTE_HLX_MEM,A_HLX_MEM,A_VTCM_ALLBANK_ACCESS,A_STORE,A_HLX_NEW,A_DOTNEWVALUE,A_RESTRICT_SLOT0ONLY),"Aligned HLX new halfword store",
> +{ fEA_REG(RsV); fSTOREMML(EA,fNEWLREG(KuN),false,false);})
> +
> +EXTINSN(LX_S16b_p_new,"if (Pv4) mem(Rs32)=Ku16.new",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_NOTE_HLX_MEM,A_HLX_MEM,A_VTCM_ALLBANK_ACCESS,A_STORE,A_HLX_NEW,A_DOTNEWVALUE,A_RESTRICT_SLOT0ONLY,A_CONDEXEC),"Aligned HLX new halfword store",
> +{ fEA_REG(RsV); if(fLSBOLD(PvV)){fSTOREMML(EA,fNEWLREG(KuN),false,false);} else {STORE_CANCEL(EA);};})
> +
> +Q6INSN(LX_LL16b_tmp,"Ldd16.tmp=mem(Rs32)",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from Ldd16.tmp=mem(Rs32) to LWd.tmp=mem(R)",
> +fASM_MAP("Ldd16.tmp=mem(Rs32)","LWd.tmp=mem(R)"))
> +
> +Q6INSN(LX_SS16b_new,"mem(Rs32)=Kuu16.new",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from mem(Rs32)=Kuu16.new to mem(R)=KWnew",
> +fASM_MAP("mem(Rs32)=Kuu16.new","mem(R)=KWnew"))
> +
> +#endif /* NO_HLX */
> +
> +#ifdef __SELF_DEF_EXTINSN
> +#undef EXTINSN
> +#undef __SELF_DEF_EXTINSN
> +#endif
> diff --git a/target/hexagon/insn.h b/target/hexagon/insn.h
> index 5751c9ced9..cfd4072669 100644
> --- a/target/hexagon/insn.h
> +++ b/target/hexagon/insn.h
> @@ -49,6 +49,7 @@ struct Instruction {
>                                 */
>       bool extension_valid;   /* Has a constant extender attached */
>       bool is_endloop;   /* This is an end of loop */
> +    bool hlx_new_zero; /* HLX .new store without a producer. */
>       int32_t immed[IMMEDS_MAX];    /* immediate field */
>   };
>   
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index f9e820286e..3bffbef6c1 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -22,6 +22,26 @@ gen_tcg_h = meson.current_source_dir() / 'gen_tcg.h'
>   gen_tcg_hvx_h = meson.current_source_dir() / 'gen_tcg_hvx.h'
>   gen_tcg_sys_h = meson.current_source_dir() / 'gen_tcg_sys.h'
>   idef_parser_dir = meson.current_source_dir() / 'idef-parser'
> +imported_dir = meson.current_source_dir() / 'imported'
> +
> +#
> +# Create the HLX ext.idef.
> +#
> +preprocessed_hlx_ext = custom_target(
> +    'hlx_ext.preprocessed.idef',
> +    output: 'hlx_ext.preprocessed.idef',
> +    input: imported_dir / 'hlx_ext.idef',
> +    command: meson.get_compiler('c').cmd_array() +
> +             ['-x', 'c', '-E', '-o', '@OUTPUT@', '@INPUT@']
> +)
> +generated_hlx_ext = custom_target(
> +    'generated_hlx_ext.idef',
> +    output: 'generated_hlx_ext.idef',
> +    input: preprocessed_hlx_ext,
> +    depend_files: [hex_common_py],
> +    command: [python, files('gen_hlx_ext.py'), '@INPUT@', '@OUTPUT@'],
> +)
> +hexagon_ss.add(generated_hlx_ext)
>   
>   #
>   #  Step 1
> @@ -30,6 +50,7 @@ idef_parser_dir = meson.current_source_dir() / 'idef-parser'
>   gen_semantics = executable(
>       'gen_semantics',
>       'gen_semantics.c',
> +    sources: generated_hlx_ext,
>       native: true, build_by_default: false)
>   
>   semantics_generated = custom_target(
> @@ -123,6 +144,15 @@ hvx_decode_generated = custom_target(
>   )
>   hexagon_ss.add(hvx_decode_generated)
>   
> +hlx_decode_generated = custom_target(
> +    'hlx_decode_generated',
> +    output: 'hlx_decode_generated',
> +    depends: [iset_py, semantics_generated],
> +    env: {'PYTHONPATH': meson.current_build_dir()},
> +    command: [python, files('gen_decodetree.py'), semantics_generated, 'EXT_hlx', '@OUTPUT@'],
> +)
> +hexagon_ss.add(hlx_decode_generated)
> +
>   subinsn_a_decode_generated = custom_target(
>       'subinsn_a_decode_generated',
>       output: 'subinsn_a_decode_generated',
> @@ -190,6 +220,15 @@ decode_hvx_generated = custom_target(
>   )
>   hexagon_ss.add(decode_hvx_generated)
>   
> +decode_hlx_generated = custom_target(
> +    'decode_hlx_generated.c.inc',
> +    output: 'decode_hlx_generated.c.inc',
> +    input: hlx_decode_generated,
> +    env: {'PYTHONPATH': meson.current_build_dir()},
> +    command: [python, files(decodetree_py), hlx_decode_generated, '--static-decode=decode_hlx', '-o', '@OUTPUT@'],
> +)
> +hexagon_ss.add(decode_hlx_generated)
> +
>   decode_subinsn_a_generated = custom_target(
>       'decode_subinsn_a_generated.c.inc',
>       output: 'decode_subinsn_a_generated.c.inc',
> diff --git a/target/hexagon/opcodes.h b/target/hexagon/opcodes.h
> index 0ee11bd445..d6bc2de21c 100644
> --- a/target/hexagon/opcodes.h
> +++ b/target/hexagon/opcodes.h
> @@ -35,6 +35,7 @@ typedef enum {
>       SUBINSN_S2,
>       EXT_noext,
>       EXT_mmvec,
> +    EXT_hlx,
>       XX_LAST_ENC_CLASS
>   } EncClass;
>   
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 41b7d3b0fb..ce0f215230 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -1264,6 +1264,15 @@ static void gen_commit_hvx(DisasContext *ctx)
>       }
>   }
>   
> +/* A .new store without a producer reads zeroed future_LRegs. */
> +static void gen_hlx_new_zero(Insn *insn)
> +{
> +    int rnum = insn->regno[insn->new_read_idx];
> +
> +    tcg_gen_gvec_dup_imm(MO_64, offsetof(CPUHexagonState, future_LRegs[rnum]),
> +                         sizeof(HLXVector), sizeof(HLXVector), 0);
> +}
> +
>   static void gen_commit_hlx(DisasContext *ctx)
>   {
>       int i;
> @@ -1490,6 +1499,9 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
>                           continue;
>                       }
>                       ctx->insn = insn;
> +                    if (insn->hlx_new_zero) {
> +                        gen_hlx_new_zero(insn);
> +                    }
>                       if (GET_ATTRIB(insn->opcode, A_HLX) &&
>                           trace_event_get_state_backends(
>                               TRACE_HEXAGON_HLX_OP)) {

