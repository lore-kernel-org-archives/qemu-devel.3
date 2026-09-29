Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3658CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 09:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUcD-0006OI-4e; Tue, 29 Sep 2026 05:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBUcB-0006Nt-Oj
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 05:59:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBUcA-0007hE-3a
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 05:59:11 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7TYXV760458
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xJtH7MTRn7ORBSxOZN/+VzPtzVwbCNDr5t090KUe3/k=; b=BAJeYVkbHK7v2vJC
 wKLg6xZN/7HFU9I7XVbPeETsDptgjumjVbdwwph2FTNEMIFJVoR/mRGhVCEEhcNk
 VPUmjps4NgD6hF4jFOz9TCBtkFMynra57RTW/dvP/NRJBMm/eiEWe8LfjoAldRYk
 WXDm0k6e2H4qNeqIZq+mPkF6RvJpTA68kjRd8dA/FqxCFEMJ8L3Sa/0jhekHLWGI
 yKaZjPx9/gTV9pgpICJFitYCc31d9SNjcnY/8Hw/3m7p0bJcZPpfX33ocs//cLt+
 IDOD7FPv7+mqJx1bwkZtvMaOVtoWdVcqbbuXzv6wM7ozmJSjKrJY//Wt/zWhjmJL
 SXdOrQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyw03kcx4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:59:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c6a0d2122so493627485a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 02:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790675946; x=1791280746; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xJtH7MTRn7ORBSxOZN/+VzPtzVwbCNDr5t090KUe3/k=;
 b=P5E3SZWwNsU48VIr8TMhcMuBGHMvll3v867sCbpIHwOQ5uEp0wTHssBsoNDgkIVmTE
 JAhpQL/Zf1t8yULARULN2fe54oNiMd7x0sSLiYt3bwXgBM6TAM0SrgL1nvxTyhQvkSDN
 WtwwozhOamsWH5fr5LDnjrd3L01qQ9o5lZ4qLuqS6Mn844ESf5PfLlE3+kYr3r0+C7qe
 OrihaVfboMvYp/a2+UrqS9K+oWBedThu2O/ktj1hEFuhoTHLL0ZTxpwR+uvIRJEAZPRW
 Zr0n3aHNimh/kQ3LNQDMEfxd3U5aQvRyYBgsp7rjWq7g+bNXcyG73AhtA9kdUSMtf95j
 T7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790675946; x=1791280746;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xJtH7MTRn7ORBSxOZN/+VzPtzVwbCNDr5t090KUe3/k=;
 b=2o5oYRTyJKLfXBWbC17zWW6fIIHN+mMV/imCALgnEEGia5Eqf2VQEmHmZSQCQ4/kdU
 IYsksSkwDbuyZm2jcatklvJ4KtZ2d/LDHnD33Yx25fzZlAAmaH4YnXJgMIJig4R5KnJw
 qPXJ64Og8IM9Z+DD7vrPr+clJdiJHQsn9o8e1uka+Iu4anaZM6HAnWA0DZG8GGPk+iDR
 4k+j2NQbUdRKMT/vAxV1zmLSGb0W5R6qSLxCIJS8lCcUW6NUZtPEHIi3npn8iPIgFaBe
 7VZZR7f3pQQSOL7Uz59MD1FG+dW4jWHnAqWFBEo3HOPkOX6DeSpBxELilhMBD/TUWQqT
 3yQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeDcFcuCOCKElHVKgVobRwKmhtJ926wONQNGlLX9rXW0CeEnGK7xAhYQ6XpO5LWMM84FULBx0f+R7L@nongnu.org
X-Gm-Message-State: AFuF++nD8GT8OBhlgvVlLG7JnsDQxxYHpclV1IA56lIN49TgJGkDb1xE
 r+0/dmfPhXCN4jTZ5Zs3fWsZCq/5JFp/eRPw3/cvdl2SVB6LUXKV04iDVyf9lmRZwwo0EBMHhTZ
 2qmTe8StulD/MsdexVVOXRT97Gvy8Z9MY4pNerVX8wDTb/EyoSlbGOlM40w==
X-Gm-Gg: AYBFou1XN8k7RqxIDg6Lq4AqCGlPKR35TCQIocsR3IGRIoBt9PKzucOSVeIPWFdFrol
 aL9ajLZX6SMU2JyUqRy3tU3+qrEKdEyh/Z8omW/P+EVPSWyPnN9J8gijmn1+YrMZleFN4Mfihm8
 G3qKuzzoHUqta52d6CTXRurzV1ALBC0E65k67lJkGOswfnD3J1nFShgo9i2/wNrV3OS2mGd8uLz
 //hS/paoVat6mtHc25O0yWmbc4DScUpWvsBGHkUF2m1YVPvuKCG4rfzQehnlFn2xrGAv74GIe75
 22eFweCuL/NmnJ2Rm5HQ3XUkGsMTKrxU7NFVyRW9Je04bXs7gKGVBdLoaUriPtPpHlXuoa+xJ1D
 qYBevMNSc1QpfK/1Q/AE=
X-Received: by 2002:a05:620a:254f:b0:939:f978:c1aa with SMTP id
 af79cd13be357-93c43b7e985mr2630497785a.11.1790675945904; 
 Tue, 29 Sep 2026 02:59:05 -0700 (PDT)
X-Received: by 2002:a05:620a:254f:b0:939:f978:c1aa with SMTP id
 af79cd13be357-93c43b7e985mr2630493485a.11.1790675945323; 
 Tue, 29 Sep 2026 02:59:05 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf869c4sm64993545e9.2.2026.09.29.02.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 02:59:04 -0700 (PDT)
Message-ID: <91c8dd12-1efa-4333-abf3-279a0c239d26@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 11:59:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/19] target/mips/tcg/translate: add sign extension
 for srav
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
 <20260929074007.118970-18-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260929074007.118970-18-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzOSBTYWx0ZWRfXzdQ0ruTuzvAC
 pdPTL9fT5D7TTxROuEwNhv/lmM9zpHymWXB9GO8rsOktFYRP3sbhcVW8r8pxFyVR2i9Y0Ad1MwC
 2BMCjuVONqVM54XdbLTj+aJ8oldKeEM=
X-Authority-Analysis: v=2.4 cv=SIbXx+vH c=1 sm=1 tr=0 ts=6abb8beb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7g8aA7A78AY7OC82r+w+4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Trj8EPfxmUJEcqxUpYwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzOSBTYWx0ZWRfX3jYqW9z6AlPn
 jKD8/dZLj3S+f/7cl4vjcbFFC4Xwds9tLDxtNbvg2GZ4VWJlzomLaae+GYKJ7a/jHRRaFwxXaJ5
 idpzmZ3oW4brAX1xwdIllCew5gUu2gRphq82exBv04z/Eg5U7JpK8YkIqSb6Hl/CtN/ifwCKvpD
 OVXDvnjIaQjScwkVs4Q1j+PmyjiFfKSBjPkh8SupCwZlqu39MS3Raop/qkUgygKZI45TPKOa0JZ
 s2m0ZWG3DbUCtNxkXBCTV7uWj2wF0f1D5PVqZ3mTs5UL60cosIwkfYOWeP+R7zrsLfb96iCYHYv
 Eopt4BzRKK4B/WoyuPITitgjlXCuP8DikDeXGMH5UeDpTA36CspTPPc9i54FeAuhf8FDrnxoVR7
 N3WFy/ufjnRaWMHs2XC7IEshvVY2hFz5GiavJ11Susosd/tBQKTzgEoyECn6SciI2D11/3XEsd8
 dmOr5Gid9r1U3mJGI7A==
X-Proofpoint-GUID: xDSDVfRvOlUs1c1MMmx_O_Qf3SSHbH6n
X-Proofpoint-ORIG-GUID: xDSDVfRvOlUs1c1MMmx_O_Qf3SSHbH6n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290039
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 2026-09-29 9:40, Pierrick Bouvier wrote:
> In next commit, we update references for failing tests.
> One test, test_mips64r6_srav, has an output that is not reproducible
> on my host. After checking, it's coming from UNPREDICTABLE case
> described by mips64 reference manual.
> 
> ```
> Format: SRAV rd, rt, rs MIPS32
> Description: GPR[rd] = GPR[rt] >> GPR[rs] (arithmetic)
> The contents of the low-order 32-bit word of GPR rt are shifted right,
> duplicating the sign-bit (bit 31) in the emptied
> bits; the word result is sign-extended and placed in GPR rd. The
> bit-shift amount is specified by the low-order 5 bits
> Restrictions:
> On 64-bit processors, if GPR rt does not contain a sign-extended 32-bit value (bits 63..31 equal), then the result of the
> operation is UNPREDICTABLE.
> ```
> 
> Current implementation takes advantage of restriction above and does not
> perform sign extension on lower part.
> 
> Given this definition: srav(x,y) ((int64_t)((int32_t)(x)>>(y&0b11111)))
> srav(0xaaaaaaaaaaaaaaaa, 0xffffffffffffffff) = 0xffffffffffffffff
> With qemu-mips64, this instruction returns 0xffffffff55555555 instead.
> 
> While this is not wrong following the spec, it can be surprising. To
> have a more predictable behavior, always perform sign extension on lower
> part. This will give us the advantage of having a test output that can
> be checked on any host.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/mips/tcg/translate.c | 1 +
>   1 file changed, 1 insertion(+)

Or simpler:

'''
   target/mips: Sign-extend the SRAV operand

   SRAV operates on the low-order 32-bit word of its source and
   sign-extends the shifted result. Sign-extend the source before
   shifting to make results deterministic when the source register
   is not already sign-extended.
'''

Fixes: 48d38ca52b6 ("Switch most MIPS logical and arithmetic 
instructions to TCG")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

