Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3627FDEE31
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFy3O-0001Ox-Fh; Thu, 23 Apr 2026 13:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wFy2f-0001Mj-IE
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:40:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wFy2a-0002Dl-Kg
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:40:44 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NFFds7179321
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 17:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hD8vEibP2YZ2VCom7/1erJ7kkaDP6Mp2Jj80Ick5EWs=; b=kB94Mo7wxn07t3fJ
 T2KbzEgksLFflzkH1c6UvhS4cSdTCEVDkf8hRkp18BhyqAXjZs5+f4psWqdk3fX0
 02c8d/BBIPovykDE1wwncdnYAhPvcivOubWRES8sohGALVRoE1hK0tMQUparUBeN
 htxW4VknXP+ntBtgWvo3Eo2AiXwD4V4d/M0HxdlEw6TETS5q6MoQigrNGQYgXTGM
 DBH0q9ewyp2d73w/6pbSVimN6BBSKfcNxgXqgWJjDvQ1PKMHpejGc6DR/+Z3cllW
 6NBp8vJOmYE036c3ecdjbiEQxV594zdcHWnAkzLlUrz333O7TPPR5blycXAHgWve
 0w0Q+w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqe62jrsp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 17:40:31 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2de07c12745so13812083eec.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776966031; x=1777570831; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hD8vEibP2YZ2VCom7/1erJ7kkaDP6Mp2Jj80Ick5EWs=;
 b=RG+OYXKxIEJVYdicTa0RX29U/nfXrK+kkYGT4PA7bIgWHLD5Rg7KNqj1ty4Y55xQwz
 W7Vk7/XRCJCyb6PYrR/K2BpHa3sIBpDOZjwNStG6v0+A6Wr1wFIfgJsfgz7G0aX6Y10a
 y1vbijA7DLfRzWL/tiM/KkgL4i7IbtLcHbXmX3NU6+60F0SkekC+Wh0n5PvT9OjOvWGz
 PkrjXcGyEeTT6qacI4p9hqfyoGyoG0cMhKtkbcogJ8DG7VcyCiCIRMoKB0XdKIeGBMPx
 OYsUidBVSGmI4u7KdcyMeHD/3lCaOtaKBPNkpCNWk+xt22IOU3aPEP8b90I5hUTR0WM6
 35/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776966031; x=1777570831;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hD8vEibP2YZ2VCom7/1erJ7kkaDP6Mp2Jj80Ick5EWs=;
 b=Ut0u/QH4QzfKrmlZ4Cll2lWD4+FfUgEV5UzfTur120JEyTZJLdD57ldzx5+LuvXEkX
 q98YvNxIbPP9iXoap0WeCnoe05o3abgBYVdQIIAYpE03qJoggCqNSyCTQpz0QDC15o8p
 deze3EStRRr2Ur8hx+AuJj9bi31E3CY4tqkyOgbSYUwcIgiMwvyRi04zaqqU9xn5N4bp
 DVhddVo8GHXteqn3zuqHB7qQae1EAHY/9bDAyXPZYXxiMAdhRHpqtT4p/NpaT9sEP4Cu
 aA7bgm8tGj+aeRAB3Tw3FKZgy/qjIhNXSvLjssBR1rPKpVD9jAmBFbPsuNISd3+y8yQf
 aFWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ZemN6jm+Th18gwtr7bNww4uwmFROBDj0u2g9XVenB1FKKmSCg6nW5clRgNWMoR4Vqg+1vOgJxiDYD@nongnu.org
X-Gm-Message-State: AOJu0YwCuNmbemqFRrX3K7+Hn58HuQ8iHusQUGXHxgJVnC8s/nZ8GeGM
 AUtPSBhLkuXiJEOq4Eaay3lVlNNnpFTmaM4egkXkvxEF1kKQsH5g625q8+wQeu8HVaUV1y5S3mW
 An35C8n0fEeUUItZX2eBTZ8VxUefSmWlZTlPcn4AkhVwuu0P6wg/vnzq34Q==
X-Gm-Gg: AeBDietVzX4CdmCq+LuI54Os3xFjk0VkUT4soX1uK8IEoQKW8qDkYrxfTFSB1tLImLa
 w2yRSe7uAl5ZtgetXdqUbaHcMnQrqt7t6Lm9330faTOviuIZBATllpcDZ3hl+Q598t8RzJIcYVJ
 M5jB+phwgM5Dim/DND+BGobrnXRjoqctKBQBq9BYfpx56L4XGIbKruJL7yEH/dw24BMxipIkrSZ
 Rbu6hlLWpMA0IVo75aBZcKp2VM2HkH3oBVeI3AC890VS/I00Unax3nr0/Y3AriPvyb15K2fHMYS
 Q8b7olPHbUjnGay23FyFeZnjeBsIf8EC8ikWY4AyPjlXkN5DrpVqOt5TID7706sQjg60Qorr02x
 101JvUPKOpDVZlSBj1MhymCt0Z+wsKXVEJHPm0r1zBl51fBLgYTlRVhwE5GKQwzhV65rol2Ulvv
 FVrhaZKgkv9J12UddYae1pPgL7
X-Received: by 2002:a05:7301:3808:b0:2d8:7302:d21 with SMTP id
 5a478bee46e88-2e479724538mr15323453eec.16.1776966030715; 
 Thu, 23 Apr 2026 10:40:30 -0700 (PDT)
X-Received: by 2002:a05:7301:3808:b0:2d8:7302:d21 with SMTP id
 5a478bee46e88-2e479724538mr15323423eec.16.1776966030062; 
 Thu, 23 Apr 2026 10:40:30 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53ccd2564sm29203108eec.18.2026.04.23.10.40.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 10:40:28 -0700 (PDT)
Message-ID: <9d593f79-c02e-4436-aad8-9b58bc347f10@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 10:40:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Remove unused tcg_gen_vec_*_tl() API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
References: <20260423101904.36131-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260423101904.36131-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zJ477bfLNQ8_nOtu2stACh-fZ5K0_tYU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3MiBTYWx0ZWRfX14iQ+3ECnhrK
 X8m1SXWQH41pymG8KqSJtU4RFdfGpEIia/SC7hDJF2jJIwqs5SgHccZsycxLIlsSCZh4noTTwqU
 5/s7MjLiWv8mWtRC/7NytsUkwsxbWP4/jXLwpCqAvLk8kh0RKFwmfx+anlldOej2mpHC09gxAsI
 RNAdNH1uMKjVHtHqSRd2na4HK02HEQGCqUaIyGSPt7DnTDURF09ZR/MxIctYElmVElx+rRMkuYt
 mFFQ7etIQpYfYnUy01a9mnEt21+oKTITht7Atk5W/lWCE6KJVAGNl2zYBqqZlJjKZ/+fIbR+ajl
 Y+JXXx62IG5KFplJcqXqMy3bHbXlA1YdBse6hWL0ixtatsCFOaFG7R4pnBs86cg+vdLDNILdPrG
 1XvHc+1Kl71DbJkMD2fLP5yIuQGPJAhxcd7vJIup5HUh4J4EJNZcBT0CO9PX5EOgx71qJhdSqkE
 8Ou3TROLntPF2djqKYA==
X-Proofpoint-ORIG-GUID: zJ477bfLNQ8_nOtu2stACh-fZ5K0_tYU
X-Authority-Analysis: v=2.4 cv=Nv7htcdJ c=1 sm=1 tr=0 ts=69ea598f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=_O3DOGVWAAAA:8 a=JF9118EUAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=SRrdq9N9AAAA:8 a=69wJf7TsAAAA:8 a=jyyEr-mQQu-dVf9PX0EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=cvBusfyB2V15izCimMoJ:22 a=2TKV-7w1aU1AVAwN0oqT:22 a=xVlTc564ipvMDusKsbsT:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230172
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 4/23/2026 3:19 AM, Philippe Mathieu-Daudé wrote:
> No code uses the tcg_gen_vec_*_tl() API. Better to
> remove it now, since to compile as translation unit
> files once we need to avoid target_ulong uses.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Now this file only defines tcg_gen_gvec_dup_tl(), which
> is used only once in target/riscv/insn_trans/trans_rvv.c.inc:
> 
> 2156 static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
> 2157 {
> 2158     if (require_rvv(s) &&
> 2159         vext_check_isa_ill(s) &&
> 2160         /* vmv.v.x has rs2 = 0 and vm = 1 */
> 2161         vext_check_ss(s, a->rd, 0, 1)) {
> 2162         TCGv s1;
> 2163
> 2164         s1 = get_gpr(s, a->rs1, EXT_SIGN);
> 2165
> 2166         if (s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
> 2167             if (get_xl(s) == MXL_RV32 && s->sew == MO_64) {
> 2168                 TCGv_i64 s1_i64 = tcg_temp_new_i64();
> 2169                 tcg_gen_ext_tl_i64(s1_i64, s1);
> 2170                 tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
> 2171                                      MAXSZ(s), MAXSZ(s), s1_i64);
> 2172             } else {
> 2173                 tcg_gen_gvec_dup_tl(s->sew, vreg_ofs(s, a->rd),
>                       ^^^^^^^^^^^^^^^^^^^
> 2174                                     MAXSZ(s), MAXSZ(s), s1);
> 2175             }
> 2176         } else {
> 
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Weiwei Li <liwei1518@gmail.com>
> Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Cc: Chao Liu <chao.liu.zevorn@gmail.com>
> Cc: qemu-riscv@nongnu.org
> ---
>   include/tcg/tcg-op-gvec.h | 24 ------------------------
>   1 file changed, 24 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

