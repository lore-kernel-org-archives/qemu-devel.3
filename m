Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFF5C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 22:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6yL-0002iC-QU; Sun, 26 Jul 2026 18:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wo6yK-0002hg-Ir
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 18:05:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wo6yG-0002ep-QL
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 18:05:24 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66QJvcv31558120
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 22:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8CdnHh48O25MlOnyPHWnihToOKTN0B14adJmgFsYU40=; b=kJayR7OKwWEjhRbi
 yikVO9ae3sbwqXfwUIK/2W/adh9v2FFg2M9XluS7OkhvNx976J56zvxsq6DNtFaQ
 fV7ABVvnwLlvs809BYtqYN5MkLSiB0pUEtpn6cSCNghEp70cgyqdTAGf22fMyw1L
 Fyi0yf+oUOU6XtHwFI6Iw0qmr5Tm6ynvzi3UhthANn23ml9jWAf0JC4SR7/xJHjV
 3Pxerx5gHHebzLiJPH7QDyOnleADMGMjwmJ497Qz6pjSEmv9JiWNSWEgbzTit42U
 YQnHQEyegxHJPxyuclMxKd3YY7RN3idGPjIGDEwE30UpUICH+Ay76ia998lVgtUp
 n4Tnsg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmmfguv5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 22:05:18 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8e934385db1so32898846d6.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785103518; x=1785708318; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8CdnHh48O25MlOnyPHWnihToOKTN0B14adJmgFsYU40=;
 b=ImdLjbf8m/KJkCitzsvqBboUhSibYcVL/mPthAhgTaiqtCXh2wZHf9Quf0KtjjgTma
 P+T76BqsVUDCKYpsplUKzxdUGO0angopRYVMOoUETWz6fK7uiLbEmDkM6yZqKePkv8w4
 gXv/U7b2oGY7wPocuq7PSgpRm0sUdIs0vRb1J62PgF1Z4waTDTuSbHqC1eo6oV+cN8A+
 Y0PaEZ8XeDbUxPVHRVDc9Nw40A1Qiu3NzhBDHyVXVk1ZBVot0NdRrLO0NTW2Fe/hyRbn
 BCS4rgKwcs2+9n78h5rU+hIbgc2hfli9RxWPOH6lRJNcdWvsT7NrJ1M3GUQNoM1xGi1o
 RFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785103518; x=1785708318;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8CdnHh48O25MlOnyPHWnihToOKTN0B14adJmgFsYU40=;
 b=I3wvThP4uooS6P3lp3nQREfTF4DnkeT5PUTt5jAe67d2vi2VDlJ5oD5NiuaIbza217
 OgSrPOT7BVng41XyNSIXQlLnHXV7FgHWsuybjn8ljGeHE89bkQ+ZJ0g+19o8WIX2p8No
 TJ29qD/CUeEXT2lZP2rMGIq8PHK/F9tQWkxkc0JUmEyRxo8/I7U1gPT82OcxJl4tSsQh
 9K8mGoNFcgUsDSupXMdx3iNGT6liu11ywp+ZtaOAwuZLqMaDmU65mRTFWBjsSwA1m6dt
 E36PhfExVKDMWCu46l6NdMYak/QjnN+YV2WeFMpCYNf7nVWlvBlSU/yVLy3lMVOY1vXq
 BNNg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpfqw5DVH+tP5/H5ao8skPx2deyxCLqYRDETjR+1nHpiCmbwrtLfUCEceHQo5ktzS2VynB7QiVRda+B@nongnu.org
X-Gm-Message-State: AOJu0YzQDIErCFY8eH1szqIqVUPIpRLp3sSQKOlVafYIDvBoxQCCzl4r
 8UC8Pt4icuC0pLIe2H5k3TiEtvgf2TwKD4NiRext6rMKBa+RgSi14hSyvcsbE/yl8cpwGoYuS6d
 KrIjeca4XxUbtzyqD3btfvHWOfUXw0yyGjNlls5RHehAMXvYWM2NI5ajp+w==
X-Gm-Gg: AR+sD12p9KpE2aqk5MnLTq6s3PR2JOHd58W1lUp606vWG9vYQEpmr+dHL/RSlSn0vBy
 EXl+Cwp/G834xZk0bXHzXgKHJiclqB82yaS0pLDX0FBVNCyHDIC/2WRRKA5Row6WBXmU0Qwoho/
 bLvM8dqthF/z9O0okfxan19W3Bo+oZwcU9dWt0DDSN0hh7PX55a7oCRmOVYMpAd7AdhNHUQGx3X
 OJ0ZmZCHQR3S4WMhWPkJsO9h+mgu8uK4I9Vn2rrRJAEpvysinDcy5+eGPgLutoRxV3Nl2ApLjq2
 wonFLODWsDXQIftVIePlUoLf/63BtuzM6uUzHujq8OJJp+8qIU/cBxZvHkC1j/iIgus0KLPVJB7
 GqfvE0bU5Rmhi5wbt/8VqTQ+ifaCdtnd7yl9u8Q==
X-Received: by 2002:a05:6214:238f:b0:8ca:1e0f:f20c with SMTP id
 6a1803df08f44-907ec726dedmr74226326d6.4.1785103518136; 
 Sun, 26 Jul 2026 15:05:18 -0700 (PDT)
X-Received: by 2002:a05:6214:238f:b0:8ca:1e0f:f20c with SMTP id
 6a1803df08f44-907ec726dedmr74225856d6.4.1785103517496; 
 Sun, 26 Jul 2026 15:05:17 -0700 (PDT)
Received: from [192.168.68.104] ([191.202.238.134])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907e86a1b73sm50281986d6.32.2026.07.26.15.05.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jul 2026 15:05:16 -0700 (PDT)
Message-ID: <b659a5af-cc90-42ec-a7b0-6edadb119139@oss.qualcomm.com>
Date: Sun, 26 Jul 2026 19:05:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/18] target/riscv: Add packed SIMD arithmetic
 instructions
To: Molly Chen <xiaoou@iscas.ac.cn>, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Chao Liu <chao.liu@processmission.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
 <3935baa46fdc44f7b68e2b740c7bedf8b7c0b974.1784280142.git.xiaoou@iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3935baa46fdc44f7b68e2b740c7bedf8b7c0b974.1784280142.git.xiaoou@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OU1cpYEXcCCSseURkbG7r-dqJtMQaWtC
X-Proofpoint-ORIG-GUID: OU1cpYEXcCCSseURkbG7r-dqJtMQaWtC
X-Authority-Analysis: v=2.4 cv=GdYnWwXL c=1 sm=1 tr=0 ts=6a66849f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=krItrnN2KmZux9Htc+7Wjw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=tOG0ScjQcxZWyau1J64A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDIyNCBTYWx0ZWRfX5z/Hw4Vy/puD
 6lS8owhiI3CIBY7DkYECmNKAsQb2vvhQei8oktgTuNsVsOBnIcs28laTd1+0l/5x7X07lWzjPB1
 FO2jCyH+Ae4djGj5TwporDpCG26pAMk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDIyNCBTYWx0ZWRfXxATbHNGMLdTf
 n4kbjd7g7Fr71bbpRiPdEiHliCAVYpQjkKd8oRCaWsFL3s06dubiIGvU0KoHQdic/FMBPgMxvIU
 bdBC+t06guYFqwxHg0sKBEqAq713y9tv+fcnmYbhpR3yGZLafNdCLeA8oMFMfhUSU1W4rpk8S+R
 +Ya5HjCt0E735slWqc7Bz8f7U+zdse72VVxU9N8kxXwuFD618bojkvTXfVf8yrvNwZOwPcSuEkl
 0DJUqPuViX1x28InhKykHAbEA/h8qtsnZXDexFNpMotcCjVrElWPzc7KMpFe5P8Iv27G2z8zMa8
 cd7UvwCFcGWrhFIEmQMIh1msSlv1NdUtFhwdPR7rQC87SxKjNRDhSieiVbFhEzNJdfHQzetuMub
 RoDRgnYJo0q5b6eJx9foXWf6UNe41TQ9YmazZu4g8CJ8mhibqF799KLG1SCdWe6IWDUs2s8OuR7
 t3u1qI6qzbF1+wLIzxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_06,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607260224
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 7/17/2026 7:06 AM, Molly Chen wrote:
> Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/helper.h                       |  41 ++
>   target/riscv/insn32.decode                  |  63 +++
>   target/riscv/tcg/insn_trans/trans_rvp.c.inc | 547 ++++++++++++++++++++
>   target/riscv/tcg/psimd_helper.c             | 114 ++++
>   target/riscv/tcg/translate.c                |   4 +
>   5 files changed, 769 insertions(+)
>   create mode 100644 target/riscv/tcg/insn_trans/trans_rvp.c.inc
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 542b7c264fc..eebb2febd95 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1358,3 +1358,44 @@ DEF_HELPER_1(ssamoswap_disabled, void, env)
>   
>   /* Zalrsc SC write probe */
>   DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
> +
> +/* Packed SIMD */
> +/* Packed SIMD - Arithmetic Operations(Non-Saturating and Saturating) */
> +DEF_HELPER_3(padd_b, tl, env, tl, tl)
> +DEF_HELPER_3(padd_h, tl, env, tl, tl)
> +DEF_HELPER_3(padd_w, i64, env, i64, i64)
> +DEF_HELPER_3(padd_bs, tl, env, tl, tl)
> +DEF_HELPER_3(padd_hs, tl, env, tl, tl)
> +DEF_HELPER_3(padd_ws, i64, env, i64, i64)
> +DEF_HELPER_3(psub_b, tl, env, tl, tl)
> +DEF_HELPER_3(psub_h, tl, env, tl, tl)
> +DEF_HELPER_3(psub_w, i64, env, i64, i64)
> +DEF_HELPER_3(psh1add_h, tl, env, tl, tl)
> +DEF_HELPER_3(psh1add_w, i64, env, i64, i64)
> +DEF_HELPER_3(pssh1sadd_h, tl, env, tl, tl)
> +DEF_HELPER_3(pssh1sadd_w, i64, env, i64, i64)
> +DEF_HELPER_3(ssh1sadd, i32, env, i32, i32)
> +DEF_HELPER_3(psadd_b, tl, env, tl, tl)
> +DEF_HELPER_3(psadd_h, tl, env, tl, tl)
> +DEF_HELPER_3(psadd_w, i64, env, i64, i64)
> +DEF_HELPER_3(psaddu_b, tl, env, tl, tl)
> +DEF_HELPER_3(psaddu_h, tl, env, tl, tl)
> +DEF_HELPER_3(psaddu_w, i64, env, i64, i64)
> +DEF_HELPER_3(sadd, i32, env, i32, i32)
> +DEF_HELPER_3(saddu, i32, env, i32, i32)
> +DEF_HELPER_3(pssub_b, tl, env, tl, tl)
> +DEF_HELPER_3(pssub_h, tl, env, tl, tl)
> +DEF_HELPER_3(pssub_w, i64, env, i64, i64)
> +DEF_HELPER_3(pssubu_b, tl, env, tl, tl)
> +DEF_HELPER_3(pssubu_h, tl, env, tl, tl)
> +DEF_HELPER_3(pssubu_w, i64, env, i64, i64)
> +DEF_HELPER_3(ssub, i32, env, i32, i32)
> +DEF_HELPER_3(ssubu, i32, env, i32, i32)
> +DEF_HELPER_3(psati_h, tl, env, tl, tl)
> +DEF_HELPER_3(pusati_h, tl, env, tl, tl)
> +DEF_HELPER_3(psati_w, i64, env, i64, i64)
> +DEF_HELPER_3(pusati_w, i64, env, i64, i64)
> +DEF_HELPER_3(sati_32, i32, env, i32, i32)
> +DEF_HELPER_3(usati_32, i32, env, i32, i32)
> +DEF_HELPER_3(sati_64, i64, env, i64, i64)
> +DEF_HELPER_3(usati_64, i64, env, i64, i64)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 21272fdb504..8da13669d73 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -40,6 +40,9 @@
>   %imm_z6   26:1 15:5
>   %imm_mop5 30:1 26:2 20:2
>   %imm_mop3 30:1 26:2
> +%imm_p_ui16 20:4
> +%imm_p_ui32 20:5
> +%imm_p_ui64 20:6
>   
>   # Argument sets:
>   &empty
> @@ -60,6 +63,7 @@
>   &k_aes     shamt rs2 rs1 rd
>   &mop5 imm rd rs1
>   &mop3 imm rd rs1 rs2
> +&p_ui imm rs1 rd
>   
>   # Formats 32:
>   @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
> @@ -105,6 +109,10 @@
>   @mop5 . . .. .. .... .. ..... ... ..... ....... &mop5 imm=%imm_mop5 %rd %rs1
>   @mop3 . . .. .. . ..... ..... ... ..... ....... &mop3 imm=%imm_mop3 %rd %rs1 %rs2
>   
> +@p_ui16 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui16 %rs1 %rd
> +@p_ui32 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui32 %rs1 %rd
> +@p_ui64 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui64 %rs1 %rd
> +
>   # Formats 64:
>   @sh5     .......  ..... .....  ... ..... ....... &shift  shamt=%sh5      %rs1 %rd
>   
> @@ -1084,3 +1092,58 @@ sb_aqrl  00111 . . ..... ..... 000 ..... 0101111 @atom_st
>   sh_aqrl  00111 . . ..... ..... 001 ..... 0101111 @atom_st
>   sw_aqrl  00111 . . ..... ..... 010 ..... 0101111 @atom_st
>   sd_aqrl  00111 . . ..... ..... 011 ..... 0101111 @atom_st
> +
> +# *** P Experimental Extension Version v020 ***
> +# Packed SIMD - Arithmetic Operations(Non-Saturating and Saturating)
> +padd_b     1000010 ..... ..... 000 ..... 0111011 @r
> +padd_h     1000000 ..... ..... 000 ..... 0111011 @r
> +padd_w     1000001 ..... ..... 000 ..... 0111011 @r
> +padd_bs    1001110 ..... ..... 010 ..... 0011011 @r
> +padd_hs    1001100 ..... ..... 010 ..... 0011011 @r
> +padd_ws    1001101 ..... ..... 010 ..... 0011011 @r
> +psub_b     1100010 ..... ..... 000 ..... 0111011 @r
> +psub_h     1100000 ..... ..... 000 ..... 0111011 @r
> +psub_w     1100001 ..... ..... 000 ..... 0111011 @r
> +psh1add_h  1010000 ..... ..... 010 ..... 0111011 @r
> +psh1add_w  1010001 ..... ..... 010 ..... 0111011 @r
> +pssh1sadd_h   1011000 ..... ..... 010 ..... 0111011 @r
> +{
> +  ssh1sadd    1011001 ..... ..... 010 ..... 0111011 @r
> +  pssh1sadd_w 1011001 ..... ..... 010 ..... 0111011 @r
> +}
> +psadd_b    1001010 ..... ..... 000 ..... 0111011 @r
> +psadd_h    1001000 ..... ..... 000 ..... 0111011 @r
> +{
> +  sadd     1001001 ..... ..... 000 ..... 0111011 @r
> +  psadd_w  1001001 ..... ..... 000 ..... 0111011 @r
> +}
> +psaddu_b   1011010 ..... ..... 000 ..... 0111011 @r
> +psaddu_h   1011000 ..... ..... 000 ..... 0111011 @r
> +{
> +  saddu    1011001 ..... ..... 000 ..... 0111011 @r
> +  psaddu_w 1011001 ..... ..... 000 ..... 0111011 @r
> +}
> +pssub_b    1101010 ..... ..... 000 ..... 0111011 @r
> +pssub_h    1101000 ..... ..... 000 ..... 0111011 @r
> +{
> +  ssub     1101001 ..... ..... 000 ..... 0111011 @r
> +  pssub_w  1101001 ..... ..... 000 ..... 0111011 @r
> +}
> +pssubu_b   1111010 ..... ..... 000 ..... 0111011 @r
> +pssubu_h   1111000 ..... ..... 000 ..... 0111011 @r
> +{
> +  ssubu      1111001 ..... ..... 000 ..... 0111011 @r
> +  pssubu_w   1111001 ..... ..... 000 ..... 0111011 @r
> +}
> +psati_h    11100 001.... ..... 100 ..... 0011011 @p_ui16
> +pusati_h   10100 001.... ..... 100 ..... 0011011 @p_ui16
> +{
> +  sati_32  11100 01..... ..... 100 ..... 0011011 @p_ui32
> +  psati_w  11100 01..... ..... 100 ..... 0011011 @p_ui32
> +}
> +{
> +  usati_32 10100 01..... ..... 100 ..... 0011011 @p_ui32
> +  pusati_w 10100 01..... ..... 100 ..... 0011011 @p_ui32
> +}
> +sati_64    111001 ...... ..... 100 ..... 0011011 @p_ui64
> +usati_64   101001 ...... ..... 100 ..... 0011011 @p_ui64
> diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
> new file mode 100644
> index 00000000000..056ccfb486e
> --- /dev/null
> +++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
> @@ -0,0 +1,547 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* RISC-V translation routines for the P Standard Extensions. */
> +/* Copyright (c) 2026 ISRC ISCAS. */
> +
> +/* Save a 64 bit data in src to dst and dst + 1 */
> +
> +static bool require_rvp(DisasContext *ctx)
> +{
> +    uint32_t opcode = ctx->opcode & 0x7f;
> +
> +    if (!has_ext(ctx, RVP)) {
> +        return false;
> +    }
> +
> +    /*
> +     * P_VXSAT_EXCP is encoded in the TB flags only when P is implemented
> +     * without Zve*, where stateen0.VXSAT controls the whole OP-32 and
> +     * OP-IMM-32 P instruction spaces.  When Zve* is present, this field
> +     * remains NONE and vxsat access is checked by the VS path instead.
> +     */
> +    if ((opcode == 0x3b || opcode == 0x1b) &&
> +        ctx->p_vxsat_excp != P_VXSAT_EXCP_NONE) {
> +        ctx->virt_inst_excp =
> +            ctx->p_vxsat_excp == P_VXSAT_EXCP_VIRTUAL;
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static bool prepare_rvp_vxsat(DisasContext *ctx)
> +{
> +    if (!ctx->cfg_ptr->ext_zve32x) {
> +        return true;
> +    }
> +
> +    if (ctx->mstatus_vs == EXT_STATUS_DISABLED) {
> +        return false;
> +    }
> +
> +    mark_vs_dirty(ctx);
> +    return true;
> +}
> +
> +#define REQUIRE_RVP(ctx) do {             \
> +    if (!require_rvp(ctx)) {              \
> +        return false;                     \
> +    }                                     \
> +} while (0)
> +
> +#define GEN_SIMD_TRANS_BODY(NAME, VXSAT)                    \
> +do {                                                        \
> +    REQUIRE_RVP(ctx);                                       \
> +    if (VXSAT && !prepare_rvp_vxsat(ctx)) {                 \
> +        return false;                                       \
> +    }                                                       \
> +    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
> +    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);             \
> +    TCGv dest = dest_gpr(ctx, a->rd);                       \
> +    gen_helper_##NAME(dest, tcg_env, src1, src2);           \
> +    gen_set_gpr(ctx, a->rd, dest);                          \
> +    return true;                                            \
> +} while (0)
> +
> +#define GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)                 \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    return true;                                           \
> +}
> +
> +#define GEN_SIMD_TRANS_UNAVAILABLE_64(NAME)                 \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_64BIT(ctx);                                     \
> +    return true;                                           \
> +}
> +
> +#define GEN_SIMD_TRANS(NAME)                                \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    GEN_SIMD_TRANS_BODY(NAME, false);                       \
> +}
> +
> +#define GEN_SIMD_TRANS_VXSAT(NAME)                         \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    GEN_SIMD_TRANS_BODY(NAME, true);                        \
> +}
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_32(NAME)                             \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)  \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    GEN_SIMD_TRANS_BODY(NAME, false);                       \
> +}
> +#define GEN_SIMD_TRANS_32_VXSAT(NAME)                      \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    GEN_SIMD_TRANS_BODY(NAME, true);                        \
> +}
> +#else
> +#define GEN_SIMD_TRANS_32(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
> +#define GEN_SIMD_TRANS_32_VXSAT(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_64(NAME) GEN_SIMD_TRANS_UNAVAILABLE_64(NAME)
> +#define GEN_SIMD_TRANS_64_VXSAT(NAME) GEN_SIMD_TRANS_UNAVAILABLE_64(NAME)
> +#else
> +#define GEN_SIMD_TRANS_64(NAME)                             \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)  \
> +{                                                           \
> +    REQUIRE_64BIT(ctx);                                     \
> +    GEN_SIMD_TRANS_BODY(NAME, false);                       \
> +}
> +#define GEN_SIMD_TRANS_64_VXSAT(NAME)                      \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_64BIT(ctx);                                     \
> +    GEN_SIMD_TRANS_BODY(NAME, true);                        \
> +}
> +#endif
> +
> +#define GEN_SIMD_TRANS_ACC_BODY(NAME, VXSAT)                \
> +do {                                                        \
> +    REQUIRE_RVP(ctx);                                       \
> +    if (VXSAT && !prepare_rvp_vxsat(ctx)) {                 \
> +        return false;                                       \
> +    }                                                       \
> +    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
> +    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);             \
> +    TCGv dest = dest_gpr(ctx, a->rd);                       \
> +    TCGv t = tcg_temp_new();                                \
> +    gen_helper_##NAME(t, tcg_env, src1, src2, dest);        \
> +    gen_set_gpr(ctx, a->rd, t);                             \
> +    return true;                                            \
> +} while (0)
> +
> +#define GEN_SIMD_TRANS_ACC(NAME)                            \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    GEN_SIMD_TRANS_ACC_BODY(NAME, false);                   \
> +}
> +
> +#define GEN_SIMD_TRANS_ACC_VXSAT(NAME)                     \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    GEN_SIMD_TRANS_ACC_BODY(NAME, true);                    \
> +}
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_ACC_32(NAME)                         \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    GEN_SIMD_TRANS_ACC_BODY(NAME, false);                   \
> +}
> +#else
> +#define GEN_SIMD_TRANS_ACC_32(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_ACC_64(NAME) GEN_SIMD_TRANS_UNAVAILABLE_64(NAME)
> +#else
> +#define GEN_SIMD_TRANS_ACC_64(NAME)                         \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_64BIT(ctx);                                     \
> +    GEN_SIMD_TRANS_ACC_BODY(NAME, false);                   \
> +}
> +#endif
> +
> +#define GEN_SIMD_TRANS_R1_BODY(NAME, VXSAT)                 \
> +do {                                                        \
> +    REQUIRE_RVP(ctx);                                       \
> +    if (VXSAT && !prepare_rvp_vxsat(ctx)) {                 \
> +        return false;                                       \
> +    }                                                       \
> +    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
> +    TCGv dest = dest_gpr(ctx, a->rd);                       \
> +    gen_helper_##NAME(dest, tcg_env, src1);                 \
> +    gen_set_gpr(ctx, a->rd, dest);                          \
> +    return true;                                            \
> +} while (0)
> +
> +#define GEN_SIMD_TRANS_R1(NAME)                             \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    GEN_SIMD_TRANS_R1_BODY(NAME, false);                    \
> +}
> +
> +#define GEN_SIMD_TRANS_R1_VXSAT(NAME)                      \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    GEN_SIMD_TRANS_R1_BODY(NAME, true);                     \
> +}
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_R1_64(NAME) GEN_SIMD_TRANS_UNAVAILABLE_64(NAME)
> +#define GEN_SIMD_TRANS_R1_64_VXSAT(NAME) GEN_SIMD_TRANS_UNAVAILABLE_64(NAME)
> +#else
> +#define GEN_SIMD_TRANS_R1_64(NAME)                          \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_64BIT(ctx);                                     \
> +    GEN_SIMD_TRANS_R1_BODY(NAME, false);                    \
> +}
> +#define GEN_SIMD_TRANS_R1_64_VXSAT(NAME)                   \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_64BIT(ctx);                                     \
> +    GEN_SIMD_TRANS_R1_BODY(NAME, true);                     \
> +}
> +#endif
> +
> +#define GEN_SIMD_TRANS_IMM_BODY(NAME, VXSAT)                \
> +do {                                                        \
> +    REQUIRE_RVP(ctx);                                       \
> +    if (VXSAT && !prepare_rvp_vxsat(ctx)) {                 \
> +        return false;                                       \
> +    }                                                       \
> +    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
> +    TCGv imm = tcg_constant_tl(a->imm);                     \
> +    TCGv dest = dest_gpr(ctx, a->rd);                       \
> +    gen_helper_##NAME(dest, tcg_env, src1, imm);            \
> +    gen_set_gpr(ctx, a->rd, dest);                          \
> +    return true;                                            \
> +} while (0)
> +
> +#define GEN_SIMD_TRANS_IMM(NAME)                            \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    GEN_SIMD_TRANS_IMM_BODY(NAME, false);                   \
> +}
> +
> +#define GEN_SIMD_TRANS_IMM_VXSAT(NAME)                     \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    GEN_SIMD_TRANS_IMM_BODY(NAME, true);                    \
> +}
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_IMM_32(NAME)                         \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    GEN_SIMD_TRANS_IMM_BODY(NAME, false);                   \
> +}
> +#define GEN_SIMD_TRANS_IMM_32_VXSAT(NAME)                  \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    GEN_SIMD_TRANS_IMM_BODY(NAME, true);                    \
> +}
> +#else
> +#define GEN_SIMD_TRANS_IMM_32(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
> +#define GEN_SIMD_TRANS_IMM_32_VXSAT(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_IMM_64(NAME) GEN_SIMD_TRANS_UNAVAILABLE_64(NAME)
> +#define GEN_SIMD_TRANS_IMM_64_VXSAT(NAME) GEN_SIMD_TRANS_UNAVAILABLE_64(NAME)
> +#else
> +#define GEN_SIMD_TRANS_IMM_64(NAME)                         \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_64BIT(ctx);                                     \
> +    GEN_SIMD_TRANS_IMM_BODY(NAME, false);                   \
> +}
> +#define GEN_SIMD_TRANS_IMM_64_VXSAT(NAME)                  \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_64BIT(ctx);                                     \
> +    GEN_SIMD_TRANS_IMM_BODY(NAME, true);                    \
> +}
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_REG_PAIR_SCALAR_OP(NAME, SRC2)       \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    REQUIRE_RVP(ctx);                                       \
> +    TCGv_i32 src1 = get_gpr(ctx, a->rs1, EXT_NONE);         \
> +    TCGv_i32 src2 = SRC2;                                   \
> +    TCGv_i64 t = tcg_temp_new_i64();                        \
> +    gen_helper_##NAME(t, tcg_env, src1, src2);              \
> +    set_pair_regs(ctx, (a->rd) * 2, t);                     \
> +    return true;                                            \
> +}
> +
> +#define GEN_SIMD_TRANS_REG_PAIR_SCALAR(NAME) \
> +    GEN_SIMD_TRANS_REG_PAIR_SCALAR_OP(NAME, get_gpr(ctx, a->rs2, EXT_NONE))
> +
> +#define GEN_SIMD_TRANS_REG_PAIR_SCALAR_IMM(NAME) \
> +    GEN_SIMD_TRANS_REG_PAIR_SCALAR_OP(NAME, tcg_constant_i32(a->imm))
> +#else
> +#define GEN_SIMD_TRANS_REG_PAIR_SCALAR(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
> +#define GEN_SIMD_TRANS_REG_PAIR_SCALAR_IMM(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_REG_PAIR_OP(INSN, HELPER, SRC2_0, SRC2_1, VXSAT) \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)       \
> +{                                                                 \
> +    REQUIRE_32BIT(ctx);                                           \
> +    REQUIRE_RVP(ctx);                                             \
> +    if (VXSAT && !prepare_rvp_vxsat(ctx)) {                       \
> +        return false;                                             \
> +    }                                                             \
> +    TCGv src1_0 = get_gpr(ctx, (a->rs1) * 2, EXT_NONE);           \
> +    TCGv src2_0 = SRC2_0;                                         \
> +    TCGv dest_0 = dest_gpr(ctx, (a->rd) * 2);                     \
> +    TCGv src1_1 = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);       \
> +    TCGv src2_1 = SRC2_1;                                         \
> +    TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);                 \
> +    gen_helper_##HELPER(dest_0, tcg_env, src1_0, src2_0);         \
> +    gen_helper_##HELPER(dest_1, tcg_env, src1_1, src2_1);         \
> +    gen_set_gpr(ctx, (a->rd) * 2, dest_0);                        \
> +    gen_set_gpr(ctx, (a->rd) * 2 + 1, dest_1);                    \
> +    return true;                                                  \
> +}
> +
> +#define GEN_SIMD_TRANS_REG_PAIR_LANE(INSN, HELPER)                   \
> +    GEN_SIMD_TRANS_REG_PAIR_OP(INSN, HELPER,                       \
> +        get_gpr(ctx, (a->rs2) * 2, EXT_NONE),                     \
> +        get_gpr(ctx, (a->rs2) * 2 + 1, EXT_NONE), false)
> +
> +#define GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(INSN, HELPER)            \
> +    GEN_SIMD_TRANS_REG_PAIR_OP(INSN, HELPER,                       \
> +        get_gpr(ctx, (a->rs2) * 2, EXT_NONE),                     \
> +        get_gpr(ctx, (a->rs2) * 2 + 1, EXT_NONE), true)
> +
> +#define GEN_SIMD_TRANS_REG_PAIR_LANE_IMM(INSN, HELPER)               \
> +    GEN_SIMD_TRANS_REG_PAIR_OP(INSN, HELPER,                       \
> +        tcg_constant_tl(a->imm), tcg_constant_tl(a->imm), false)
> +
> +#define GEN_SIMD_TRANS_REG_PAIR_LANE_IMM_VXSAT(INSN, HELPER)        \
> +    GEN_SIMD_TRANS_REG_PAIR_OP(INSN, HELPER,                       \
> +        tcg_constant_tl(a->imm), tcg_constant_tl(a->imm), true)
> +#else
> +#define GEN_SIMD_TRANS_REG_PAIR_LANE(INSN, HELPER) \
> +    GEN_SIMD_TRANS_UNAVAILABLE_32(INSN)
> +#define GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(INSN, HELPER) \
> +    GEN_SIMD_TRANS_UNAVAILABLE_32(INSN)
> +#define GEN_SIMD_TRANS_REG_PAIR_LANE_IMM(INSN, HELPER) \
> +    GEN_SIMD_TRANS_UNAVAILABLE_32(INSN)
> +#define GEN_SIMD_TRANS_REG_PAIR_LANE_IMM_VXSAT(INSN, HELPER) \
> +    GEN_SIMD_TRANS_UNAVAILABLE_32(INSN)
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_OP(INSN, HELPER, VXSAT)     \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)    \
> +{                                                              \
> +    REQUIRE_32BIT(ctx);                                        \
> +    REQUIRE_RVP(ctx);                                          \
> +    if (VXSAT && !prepare_rvp_vxsat(ctx)) {                    \
> +        return false;                                          \
> +    }                                                          \
> +    TCGv src1_0 = get_gpr(ctx, (a->rs1) * 2, EXT_NONE);        \
> +    TCGv dest_0 = dest_gpr(ctx, (a->rd) * 2);                    \
> +    TCGv src1_1 = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);        \
> +    TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);                  \
> +    TCGv src2   = get_gpr(ctx, a->rs2, EXT_NONE);              \
> +    gen_helper_##HELPER(dest_0, tcg_env, src1_0, src2);        \
> +    gen_helper_##HELPER(dest_1, tcg_env, src1_1, src2);        \
> +    gen_set_gpr(ctx, (a->rd) * 2, dest_0);                     \
> +    gen_set_gpr(ctx, (a->rd) * 2 + 1, dest_1);                 \
> +    return true;                                              \
> +}
> +
> +#define GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR(INSN, HELPER)              \
> +    GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_OP(INSN, HELPER, false)
> +
> +#define GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_VXSAT(INSN, HELPER)       \
> +    GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_OP(INSN, HELPER, true)
> +#else
> +#define GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR(INSN, HELPER) \
> +    GEN_SIMD_TRANS_UNAVAILABLE_32(INSN)
> +#define GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_VXSAT(INSN, HELPER) \
> +    GEN_SIMD_TRANS_UNAVAILABLE_32(INSN)
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_REG_PAIR_LANE_UNARY_OP(INSN, HELPER, VXSAT)     \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)    \
> +{                                                              \
> +    REQUIRE_RVP(ctx);                                          \
> +    if (VXSAT && !prepare_rvp_vxsat(ctx)) {                    \
> +        return false;                                          \
> +    }                                                          \
> +    TCGv src1_0 = get_gpr(ctx, (a->rs1) * 2, EXT_NONE);        \
> +    TCGv dest_0 = dest_gpr(ctx, (a->rd) * 2);                  \
> +    TCGv src1_1 = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);    \
> +    TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);              \
> +    gen_helper_##HELPER(dest_0, tcg_env, src1_0);              \
> +    gen_helper_##HELPER(dest_1, tcg_env, src1_1);              \
> +    gen_set_gpr(ctx, (a->rd) * 2, dest_0);                     \
> +    gen_set_gpr(ctx, (a->rd) * 2 + 1, dest_1);                 \
> +    return true;                                               \
> +}
> +
> +#define GEN_SIMD_TRANS_REG_PAIR_LANE_UNARY(INSN, HELPER)               \
> +    GEN_SIMD_TRANS_REG_PAIR_LANE_UNARY_OP(INSN, HELPER, false)
> +
> +#define GEN_SIMD_TRANS_REG_PAIR_LANE_UNARY_VXSAT(INSN, HELPER)        \
> +    GEN_SIMD_TRANS_REG_PAIR_LANE_UNARY_OP(INSN, HELPER, true)
> +#else
> +#define GEN_SIMD_TRANS_REG_PAIR_LANE_UNARY(INSN, HELPER) \
> +    GEN_SIMD_TRANS_UNAVAILABLE_32(INSN)
> +#define GEN_SIMD_TRANS_REG_PAIR_LANE_UNARY_VXSAT(INSN, HELPER) \
> +    GEN_SIMD_TRANS_UNAVAILABLE_32(INSN)
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_REG_PAIR_ACC(NAME)                   \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    REQUIRE_RVP(ctx);                                       \
> +    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
> +    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);             \
> +    TCGv_i64 t = tcg_temp_new_i64();                        \
> +    if (a->rd == 0) {                                         \
> +        tcg_gen_movi_i64(t, 0);                             \
> +    } else {                                                  \
> +        get_pair_regs(ctx, t, (a->rd) * 2);                   \
> +    }                                                       \
> +    gen_helper_##NAME(t, tcg_env, src1, src2, t);           \
> +    set_pair_regs(ctx, (a->rd) * 2, t);                       \
> +    return true;                                           \
> +}
> +#else
> +#define GEN_SIMD_TRANS_REG_PAIR_ACC(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_REG_PAIR_PREDSUM(NAME)               \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    REQUIRE_RVP(ctx);                                       \
> +    TCGv_i32 src1_l;                                        \
> +    TCGv_i32 src1_h;                                        \
> +    TCGv_i32 src2 = get_gpr(ctx, a->rs2, EXT_NONE);         \
> +    TCGv_i32 dest = dest_gpr(ctx, a->rd);                   \
> +    if (a->rs1 == 0) {                                        \
> +        src1_l = tcg_temp_new_i32();                        \
> +        src1_h = tcg_temp_new_i32();                        \
> +        tcg_gen_movi_i32(src1_l, 0);                        \
> +        tcg_gen_movi_i32(src1_h, 0);                        \
> +    } else {                                                  \
> +        src1_l = get_gpr(ctx, (a->rs1) * 2, EXT_NONE);        \
> +        src1_h = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);      \
> +    }                                                       \
> +    gen_helper_##NAME(dest, tcg_env, src1_l, src1_h, src2); \
> +    gen_set_gpr(ctx, a->rd, dest);                          \
> +    return true;                                           \
> +}
> +#else
> +#define GEN_SIMD_TRANS_REG_PAIR_PREDSUM(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_PN_OP(NAME, SRC2, VXSAT)            \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    REQUIRE_RVP(ctx);                                       \
> +    if (VXSAT && !prepare_rvp_vxsat(ctx)) {                 \
> +        return false;                                       \
> +    }                                                       \
> +    TCGv_i64 s1 = tcg_temp_new_i64();                       \
> +    if (a->rs1 == 0) {                                      \
> +        tcg_gen_mov_i64(s1, 0);                             \
> +    } else {                                                \
> +        get_pair_regs(ctx, s1, a->rs1 * 2);                 \
> +    }                                                       \
> +    TCGv src2 = SRC2;                                       \
> +    TCGv dest = dest_gpr(ctx, a->rd);                       \
> +    gen_helper_##NAME(dest, tcg_env, s1, src2);             \
> +    gen_set_gpr(ctx, a->rd, dest);                          \
> +    return true;                                            \
> +}
> +
> +#define GEN_SIMD_TRANS_PN_OP_IMM(NAME) \
> +    GEN_SIMD_TRANS_PN_OP(NAME, tcg_constant_tl(a->imm), false)
> +
> +#define GEN_SIMD_TRANS_PN_OP_IMM_VXSAT(NAME) \
> +    GEN_SIMD_TRANS_PN_OP(NAME, tcg_constant_tl(a->imm), true)
> +
> +#define GEN_SIMD_TRANS_PN_OP_REG(NAME) \
> +    GEN_SIMD_TRANS_PN_OP(NAME, get_gpr(ctx, a->rs2, EXT_NONE), false)
> +
> +#define GEN_SIMD_TRANS_PN_OP_REG_VXSAT(NAME) \
> +    GEN_SIMD_TRANS_PN_OP(NAME, get_gpr(ctx, a->rs2, EXT_NONE), true)
> +#else
> +#define GEN_SIMD_TRANS_PN_OP_IMM(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
> +#define GEN_SIMD_TRANS_PN_OP_IMM_VXSAT(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
> +#define GEN_SIMD_TRANS_PN_OP_REG(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
> +#define GEN_SIMD_TRANS_PN_OP_REG_VXSAT(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
> +#endif
> +
> +/* Packed SIMD - Arithmetic Operations(Non-Saturating and Saturating) */
> +GEN_SIMD_TRANS(padd_b)
> +GEN_SIMD_TRANS(padd_h)
> +GEN_SIMD_TRANS_64(padd_w)
> +GEN_SIMD_TRANS(padd_bs)
> +GEN_SIMD_TRANS(padd_hs)
> +GEN_SIMD_TRANS_64(padd_ws)
> +GEN_SIMD_TRANS(psub_b)
> +GEN_SIMD_TRANS(psub_h)
> +GEN_SIMD_TRANS_64(psub_w)
> +GEN_SIMD_TRANS(psh1add_h)
> +GEN_SIMD_TRANS_64(psh1add_w)
> +GEN_SIMD_TRANS_VXSAT(pssh1sadd_h)
> +GEN_SIMD_TRANS_64_VXSAT(pssh1sadd_w)
> +GEN_SIMD_TRANS_32_VXSAT(ssh1sadd)
> +GEN_SIMD_TRANS_VXSAT(psadd_b)
> +GEN_SIMD_TRANS_VXSAT(psadd_h)
> +GEN_SIMD_TRANS_64_VXSAT(psadd_w)
> +GEN_SIMD_TRANS_VXSAT(psaddu_b)
> +GEN_SIMD_TRANS_VXSAT(psaddu_h)
> +GEN_SIMD_TRANS_64_VXSAT(psaddu_w)
> +GEN_SIMD_TRANS_32_VXSAT(sadd)
> +GEN_SIMD_TRANS_32_VXSAT(saddu)
> +GEN_SIMD_TRANS_VXSAT(pssub_b)
> +GEN_SIMD_TRANS_VXSAT(pssub_h)
> +GEN_SIMD_TRANS_64_VXSAT(pssub_w)
> +GEN_SIMD_TRANS_VXSAT(pssubu_b)
> +GEN_SIMD_TRANS_VXSAT(pssubu_h)
> +GEN_SIMD_TRANS_64_VXSAT(pssubu_w)
> +GEN_SIMD_TRANS_32_VXSAT(ssub)
> +GEN_SIMD_TRANS_32_VXSAT(ssubu)
> +GEN_SIMD_TRANS_IMM_VXSAT(psati_h)
> +GEN_SIMD_TRANS_IMM_VXSAT(pusati_h)
> +GEN_SIMD_TRANS_IMM_64_VXSAT(psati_w)
> +GEN_SIMD_TRANS_IMM_64_VXSAT(pusati_w)
> +GEN_SIMD_TRANS_IMM_32_VXSAT(sati_32)
> +GEN_SIMD_TRANS_IMM_32_VXSAT(usati_32)
> +GEN_SIMD_TRANS_IMM_64_VXSAT(sati_64)
> +GEN_SIMD_TRANS_IMM_64_VXSAT(usati_64)
> +
> diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
> index 2948bbb2a86..52c58e0287e 100644
> --- a/target/riscv/tcg/psimd_helper.c
> +++ b/target/riscv/tcg/psimd_helper.c
> @@ -1654,3 +1654,117 @@ uint32_t HELPER(NAME)(CPURISCVState *env, uint64_t s1, uint32_t shamt)    \
>   
>   /* Basic addition operations (non-saturating) */
>   
> +GEN_PSIMD_BINOP(padd_b, target_ulong, uint8_t, uint8_t,
> +                EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_ADD)
> +GEN_PSIMD_BINOP(padd_h, target_ulong, uint16_t, uint16_t,
> +                EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_ADD)
> +GEN_PSIMD_BINOP(padd_w, uint64_t, uint32_t, uint32_t,
> +                EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD)
> +
> +GEN_PSIMD_BINOP_SCALAR(padd_bs, target_ulong, uint8_t,
> +                       EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_ADD)
> +GEN_PSIMD_BINOP_SCALAR(padd_hs, target_ulong, uint16_t,
> +                       EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_ADD)
> +GEN_PSIMD_BINOP_SCALAR(padd_ws, uint64_t, uint32_t,
> +                       EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD)
> +
> +/* Basic subtraction operations (non-saturating) */
> +
> +GEN_PSIMD_BINOP(psub_b, target_ulong, uint8_t, uint8_t,
> +                EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_SUB)
> +GEN_PSIMD_BINOP(psub_h, target_ulong, uint16_t, uint16_t,
> +                EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_SUB)
> +GEN_PSIMD_BINOP(psub_w, uint64_t, uint32_t, uint32_t,
> +                EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB)
> +
> +/* Shift-left-by-one and add operations */
> +
> +GEN_PSIMD_SHADD(psh1add_h, target_ulong, uint16_t,
> +                EXTRACT16, INSERT16, ELEMS_H, 1)
> +GEN_PSIMD_SHADD(psh1add_w, uint64_t, uint32_t,
> +                EXTRACT32, INSERT32, ELEMS_W, 1)
> +
> +GEN_PSIMD_SAT_SHADD(pssh1sadd_h, target_ulong, int16_t, int32_t,
> +                    EXTRACT16, INSERT16, ELEMS_H, 1, -0x4000, 0x3fff,
> +                    SAT_MIN_H, SAT_MAX_H, signed_saturate_h)
> +GEN_PSIMD_SAT_SHADD(pssh1sadd_w, uint64_t, int32_t, int64_t,
> +                    EXTRACT32, INSERT32, ELEMS_W, 1, -0x40000000,
> +                    0x3fffffff, SAT_MIN_W, SAT_MAX_W, signed_saturate_w)
> +
> +GEN_PSIMD_SAT_SHADD(ssh1sadd, uint32_t, int32_t, int64_t,
> +                    EXTRACT32, INSERT32, ELEMS_W, 1, -0x40000000,
> +                    0x3fffffff, SAT_MIN_W, SAT_MAX_W, signed_saturate_w)
> +
> +/* Saturating addition operations */
> +
> +GEN_PSIMD_SAT_BINOP(psadd_b, target_ulong, int8_t, int32_t,
> +                    EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_ADD,
> +                    signed_saturate_b)
> +GEN_PSIMD_SAT_BINOP(psadd_h, target_ulong, int16_t, int32_t,
> +                    EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_ADD,
> +                    signed_saturate_h)
> +GEN_PSIMD_SAT_BINOP(psadd_w, uint64_t, int32_t, int64_t,
> +                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD,
> +                    signed_saturate_w)
> +
> +GEN_PSIMD_SAT_BINOP(psaddu_b, target_ulong, uint8_t, uint32_t,
> +                    EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_ADD,
> +                    unsigned_saturate_b)
> +GEN_PSIMD_SAT_BINOP(psaddu_h, target_ulong, uint16_t, uint32_t,
> +                    EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_ADD,
> +                    unsigned_saturate_h)
> +GEN_PSIMD_SAT_BINOP(psaddu_w, uint64_t, uint32_t, uint64_t,
> +                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD,
> +                    unsigned_saturate_w)
> +
> +GEN_PSIMD_SAT_BINOP(sadd, uint32_t, int32_t, int64_t,
> +                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD,
> +                    signed_saturate_w)
> +GEN_PSIMD_SAT_BINOP(saddu, uint32_t, uint32_t, uint64_t,
> +                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD,
> +                    unsigned_saturate_w)
> +
> +/* Saturating subtraction operations */
> +
> +GEN_PSIMD_SAT_BINOP(pssub_b, target_ulong, int8_t, int32_t,
> +                    EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_SUB,
> +                    signed_saturate_b)
> +GEN_PSIMD_SAT_BINOP(pssub_h, target_ulong, int16_t, int32_t,
> +                    EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_SUB,
> +                    signed_saturate_h)
> +GEN_PSIMD_SAT_BINOP(pssub_w, uint64_t, int32_t, int64_t,
> +                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB,
> +                    signed_saturate_w)
> +
> +GEN_PSIMD_USUB_SAT(pssubu_b, target_ulong, uint8_t,
> +                   EXTRACT8, INSERT8, ELEMS_B)
> +GEN_PSIMD_USUB_SAT(pssubu_h, target_ulong, uint16_t,
> +                   EXTRACT16, INSERT16, ELEMS_H)
> +GEN_PSIMD_USUB_SAT(pssubu_w, uint64_t, uint32_t,
> +                   EXTRACT32, INSERT32, ELEMS_W)
> +
> +GEN_PSIMD_SAT_BINOP(ssub, uint32_t, int32_t, int64_t,
> +                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB,
> +                    signed_saturate_w)
> +GEN_PSIMD_USUB_SAT(ssubu, uint32_t, uint32_t,
> +                   EXTRACT32, INSERT32, ELEMS_W)
> +
> +/* Saturation instructions (SAT, USAT) */
> +
> +GEN_PSIMD_SATI(psati_h, target_ulong, int16_t, int64_t,
> +               EXTRACT16, INSERT16, ELEMS_H, 0x0f)
> +GEN_PSIMD_USATI(pusati_h, target_ulong, int16_t, uint16_t, uint32_t,
> +                EXTRACT16, INSERT16, ELEMS_H, 1U)
> +GEN_PSIMD_SATI(psati_w, uint64_t, int32_t, int64_t,
> +               EXTRACT32, INSERT32, ELEMS_W, 0x1f)
> +GEN_PSIMD_USATI(pusati_w, uint64_t, int32_t, uint32_t, uint64_t,
> +                EXTRACT32, INSERT32, ELEMS_W, 1ULL)
> +GEN_PSIMD_SATI(sati_32, uint32_t, int32_t, int64_t,
> +               EXTRACT32, INSERT32, ELEMS_W, 0x1f)
> +GEN_PSIMD_USATI(usati_32, uint32_t, int32_t, uint32_t, uint32_t,
> +                EXTRACT32, INSERT32, ELEMS_W, 1U)
> +GEN_PSIMD_SATI(sati_64, uint64_t, int64_t, int64_t,
> +               EXTRACT64, INSERT64, ELEMS_D, 0x3f)
> +GEN_PSIMD_USATI(usati_64, uint64_t, int64_t, uint64_t, uint64_t,
> +                EXTRACT64, INSERT64, ELEMS_D, 1ULL)
> +
> diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
> index 9684dbe7528..0df9d4190f1 100644
> --- a/target/riscv/tcg/translate.c
> +++ b/target/riscv/tcg/translate.c
> @@ -103,6 +103,7 @@ typedef struct DisasContext {
>       bool vstart_eq_zero;
>       bool vl_eq_vlmax;
>       bool altfmt;
> +    uint8_t p_vxsat_excp;
>       CPUState *cs;
>       TCGv zero;
>       /* actual address width */
> @@ -1199,6 +1200,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>   #include "insn_trans/trans_rvh.c.inc"
>   #include "insn_trans/trans_rvv.c.inc"
>   #include "insn_trans/trans_rvb.c.inc"
> +#include "insn_trans/trans_rvp.c.inc"
>   #include "insn_trans/trans_rvzicond.c.inc"
>   #include "insn_trans/trans_rvzacas.c.inc"
>   #include "insn_trans/trans_rvzabha.c.inc"
> @@ -1333,6 +1335,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       ctx->vstart_eq_zero = FIELD_EX32(tb_flags, TB_FLAGS, VSTART_EQ_ZERO);
>       ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
>       ctx->altfmt = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, ALTFMT);
> +    ctx->p_vxsat_excp = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS,
> +                                   P_VXSAT_EXCP);
>       ctx->misa_mxl_max = mcc->def->misa_mxl_max;
>       ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
>       ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);


