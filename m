Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85211CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 13:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSDv2-0005eX-Ru; Wed, 27 May 2026 09:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSDux-0005e7-Sb
 for qemu-devel@nongnu.org; Wed, 27 May 2026 09:03:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSDus-0001zF-Ts
 for qemu-devel@nongnu.org; Wed, 27 May 2026 09:03:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64R8mXVc1176637
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v6UsJ/6dYhMpJoP3Z/opvE0adzRWWrjw2gI+WVgKDks=; b=VPSRFYfcN2jV+xKl
 QzHDtKQorj2Li6snOF8AadvHKunmEGvKO4o1BGE5d2oSF+Wiga0A6GZnmsZ6RRNK
 TDKEXWGmkuEkhSJC/rBC3tMsHQr7vnttEJlIZzmpTCkV8HvNtZKBCd3Jt8E28gXF
 VKYkFTUdqUIuctPuMMpMeVc64mSmnA7NxP3Cws42Hg00Hzy/44Gpli628uHV0nDO
 DKQSe1uBoMM4MmtEnwsd8c7ebCnKOb2FFQKwAoz1tmAIUiVhZqfx9Sq8Jeo41l6f
 ioCQdjmjpfPEwmT+VDb+hdnTFKOXh2kL6rGA9QpdA2Aa0SlBFFA7IbUcYqWrtn4K
 uMh7vA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edndnjk1a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:03:19 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8aca4660827so228231316d6.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779886999; x=1780491799; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v6UsJ/6dYhMpJoP3Z/opvE0adzRWWrjw2gI+WVgKDks=;
 b=jtvswT7+vt2GtdBsxSyeUYlV66KNgz5pnKqMXSdjglRpW7HrbvwFcjBEM9Otk8+QaO
 a7PTqk0EFEUs95IE1crmqc9nDE/6yqfeOLaeCkN4cIUvs/OwyMwICev1okRynySesyls
 PTAPZ7xYSQhOeDy7ZFD1EN1B7yWF7pdwn7/kCOdFEzARpfqLEnGPax8/kGgQrg6mwRzb
 SjH8sWHlQScO/Mp93ekXcL3+OeolEOYZdr1izBJcwIxSKHMN2oyFWW3/2sP+qFVqeK0r
 pctEY++Pa6zvk+HB20LpuVjB2NFFE80Ld35LtK0/cvvRPVr2Q1KNppuNo/xeHVuAXjxt
 zq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779886999; x=1780491799;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v6UsJ/6dYhMpJoP3Z/opvE0adzRWWrjw2gI+WVgKDks=;
 b=o0MmjRjs3JYwTQZucNdLKGGK4BnFFPkay3f98yXfVZEasMjsxeDCHwd7ZgH+e4kF3l
 qUFI8TZuswccAeDUcmACmVzfiNOGSdQ08z9Y+2909vWJtNLAuGwthDKzPnY+p8osUKwi
 6JGYFNatt8BT6sP7M/1ebHHXq7ikblDp77aWd/1ZmhvUWZEolz3Miaky/wtkLm1ac3f0
 RfnwAQlcOjV2FkoUc1WIEfSI1SX+KLh4svNWu3ep5N+sbbkWMAVgoWMj9YOsz7NLKlt4
 U7V5OPLNLEydJrVYeCDavyL77YG6hLr1jV6QA03JP9TvZ7/Og7Ovj1Jwv9BUl8pO4QTE
 5isg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wYWwrxCoLaVqH0UCYSnbz6B1761gURz9B1JqhkpmKN/KVQZk+1FdMMscjMNu4DZzLq0Q0JaPYYPvF@nongnu.org
X-Gm-Message-State: AOJu0YwWPg1fvS/Wm+XgWPb51pg/UxUHyAz+maaaX0VFpOE0NDo2EZDd
 56rPc1eXKNBFU2TIloNnn7AU+Ozr8Nbp7hCcOIBOIAurYBxg6oCbmQMVAgBNZBiVlEBE/Nqk4RI
 1u9ygZ8Zbl/GPGMIwLRoxmJRndPsEZ2+WOUCuxBPoDBjKVNEgfbPFsWkm2g==
X-Gm-Gg: Acq92OH4hDKQmJYGYJ00+Wc9RMllHLyaNjnfy2WZl3VabWTNy+5PjaUpP2FqMF1cmO7
 ZJWF0dNcoWddD96EsL4Hj/IW4YUPqy9hHEI9cL3Lb3jzkNT8hhdFYYRCe6vX0oV/x6BaSNJmaaF
 2egFcOQFoCYWGBtjMUMCiWE/2Emh+zoJU6FsQtnG6Pgcyc5K28jxtSpcvMTAx2I6EfMTyf2F6oq
 4PV1JLFdjklCKqSUIfMokCmuubCd9hsArQUF3O6orNGqjy7yZbTLN2CB6rz6FMUaQzEIbp+S8VO
 MK9JAWKkvpqe+/ypW3Iq+r70AGT88OFL4zMDXIjDxZYMeG/GTWNOCuXhPDc8PnB5FQGU0rJCvIM
 MeJz5t2WEpPe99bKFc4duxWDI8ZhdX7eN3BfrCbTVKUdtwGRjXLTSeqlN1rE=
X-Received: by 2002:a05:6214:5093:b0:8a0:3bd8:5950 with SMTP id
 6a1803df08f44-8cc7b5c0bb4mr360314496d6.23.1779886998477; 
 Wed, 27 May 2026 06:03:18 -0700 (PDT)
X-Received: by 2002:a05:6214:5093:b0:8a0:3bd8:5950 with SMTP id
 6a1803df08f44-8cc7b5c0bb4mr360313896d6.23.1779886997970; 
 Wed, 27 May 2026 06:03:17 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccb377fc60sm48915546d6.17.2026.05.27.06.03.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 06:03:17 -0700 (PDT)
Message-ID: <1e6c1a0a-7d20-492d-ac18-74f6f1630e9a@oss.qualcomm.com>
Date: Wed, 27 May 2026 10:03:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] target/riscv: Add RISC-V Zvfofp8min extension
 support
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, alistair23@gmail.com
References: <20260427060928.2322570-1-max.chou@sifive.com>
 <ahZQDCgHelFQfHQM@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ahZQDCgHelFQfHQM@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PpSjqQM3 c=1 sm=1 tr=0 ts=6a16eb97 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=xvfqbYfxAAAA:20 a=NW8-NIpsAAAA:8 a=pFyQfRViAAAA:8 a=nuMlGqz7nuL4QzUz3m8A:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=FTAPkevyI8KQvgyCdMRv:22
 a=oJz5jJLG1JtSoe7EL652:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: L7uHB-o6lLHbB3N1VioaOtHNC4-mnOwC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEyNyBTYWx0ZWRfX/WlcYCwJrOss
 uBN5Ahok40FI1YE04PIxdF3BCv9DAOBzL/V3zhaY9B4KRD1HLuFIVilRTJtzoUQMBAu1G58tRGq
 uJv6oYCFPIIzyTXe03xvcExqMvNv1K63NB3/S2HAGtfACnLifbMSwLYUTUytDJhKVRUzSg3Jvyb
 gK2pK2C4UbQW2a08D8wOxKleVEb/6E+5DogqH/oJKP4bVUEy3jEnJ55l2wcPP+pHSU/PHcAWTaj
 4itRXGBSrff+EQa/4BG54lVaVanQiFV8QIG+kQuj/KuKkDHkR+3Wy9pfFP7jju2b+EhyP3kZHSK
 DbTaz2rWo1GPs1ZruuKTxYxxlcJLI6uqiWjndIJKFEBfBPH6xDcVaf+i0a4FEKp9xmXXQsewa/o
 PkBhR/tbNmkCALuUu0Jx8OFjdx6zPP+jWclsSgCct87FiTGuWaDVA6P2AYf7etNQR15oKv6Qe9V
 MUsb/fTj9Pw1t6e/qeA==
X-Proofpoint-GUID: L7uHB-o6lLHbB3N1VioaOtHNC4-mnOwC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270127
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

Hi Max!

On 5/26/2026 11:00 PM, Max Chou wrote:
> Gental ping.


I believe we'll need a resend with a rebase due to changes done in the
last PR, in particular a change I did where I removed the riscv_cpu_*
arrays.  In other words: we don't need patch 8 anymore.


Thanks,
Daniel

> 
> On 2026-04-27 14:09, Max Chou wrote:
>> This patchset adds support for the RISC-V Zvfofp8min isa extension that
>> provide conversion operations for OCP FP formats.
>>
>> * riscv-isa-manual tag: https://github.com/riscv/riscv-isa-manual/releases/tag/zvfofp8min-0.9
>>
>> Zvfofp8min (v0.9):
>>    The Zvfofp8min extension provides minimal vector conversion support
>>    for OFP8 formats. It requires the Zve32f extension and leverages the
>>    altfmt field in the VTYPE CSR (introduced by Zvfbfa) to select between
>>    E4M3 (altfmt=0) and E5M2 (altfmt=1) formats.
>>    - Canonical NaN for both E4M3 and E5M2 is 0x7f
>>    - All NaNs are treated as quiet NaNs
>>    Instructions added/extended:
>>    - vfwcvtbf16.f.f.v: OFP8 to BF16 widening conversion
>>    - vfncvtbf16.f.f.w: BF16 to OFP8 narrowing conversion
>>    - vfncvtbf16.sat.f.f.w: BF16 to OFP8 with saturation (new)
>>    - vfncvt.f.f.q: FP32 to OFP8 quad-narrowing conversion (new)
>>    - vfncvt.sat.f.f.q: FP32 to OFP8 with saturation (new)
>>
>> Changes in v5
>> - Drop Zvfofp4min which is not going through the RVIA ratification
>>    process yet.
>> - Fix typos.
>> - Rebase on riscv-to-apply.next (commit bf76a00)
>>
>> Chagnes in v4
>> - Rebase on riscv-to-apply.next (commit 21101a7)
>> - Remove the softfloat library related patches (Thanks for RH's help to
>>    split this part)
>> - Add missing illegal ALTFMT SEW pattern checking for Zvfofp8min in
>>    patch 4 (target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
>>    conversion for Zvfofp8min extension)
>>
>> Changes in v3
>> - Add floatN_nan_is_snan to simply the quiet/signaling NaN checking flow
>>    in patch 2 & 3
>> - Add patch 4 to fix pseudo-NaN handling in FPATAN/FYL2XP1/FYL2X helpers
>>
>> Changes in v2
>> - Merged v1 patch 2 & 3 to v2 patch 3, v1 patch 4 & 5 to v2 patch 4
>> - Added new v2 patch 2 to refactor the IEEE format NaN classification
>>    functions (float16, bfloat16, float32, float64) to use internal helper
>>    functions, reducing code duplication and improving maintainability.
>>    The OCP FP8 NaN classification functions follow the same pattern.
>> - Refactored softfloat implementation to use capability-based FloatFmt
>>    flags (no_infinity, limited_nan, overflow_raises_invalid, normal_frac_max)
>>    instead of monolithic flags
>> - Removed ocp_fp8e5m2_no_signal_nan and ocp_fp8_same_canonical_nan flags
>>    from float_status; now using local float_status with no_signaling_nans
>>    and default_nan_pattern for RISC-V Zvfofp8min instructions
>> - Rebased on latest riscv-to-apply.next with zvfbfa v3 patchset
>>
>> v4: <20260304134006.2908449-1-max.chou@sifive.com>
>> v3: <20260204051756.667397-1-max.chou@sifive.com>
>> v2: <20260127063723.442734-1-max.chou@sifive.com>
>> v1: <20260108151650.16329-1-max.chou@sifive.com>
>>
>> References
>> * OCP FP8 specification:
>>    https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1
>>
>>
>> Max Chou (9):
>>    target/riscv: rvv: Fix NOP_UU_B vs2 width
>>    target/riscv: Add cfg property for Zvfofp8min extension
>>    target/riscv: Add implied rules for Zvfofp8min extension
>>    target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
>>      conversion for Zvfofp8min extension
>>    target/riscv: rvv: Make vfncvtbf16.f.f.w support BF16 to OFP8
>>      conversion for Zvfofp8min extension
>>    target/riscv: rvv: Add vfncvtbf16.sat.f.f.w instruction for Zvfofp8min
>>      extension
>>    target/riscv: rvv: Add vfncvt.f.f.q and vfncvt.sat.f.f.q instructions
>>      for Zvfofp8min extension
>>    target/riscv: Expose Zvfofp8min property
>>    disas/riscv: Add support of Zvfofp8min extension
>>
>>   disas/riscv.c                              |   9 ++
>>   target/riscv/cpu.c                         |  15 ++-
>>   target/riscv/cpu_cfg_fields.h.inc          |   1 +
>>   target/riscv/helper.h                      |  12 +++
>>   target/riscv/insn32.decode                 |   5 +
>>   target/riscv/insn_trans/trans_rvbf16.c.inc |  32 +++++--
>>   target/riscv/insn_trans/trans_rvofp8.c.inc | 105 +++++++++++++++++++++
>>   target/riscv/insn_trans/trans_rvv.c.inc    |  39 ++++++++
>>   target/riscv/tcg/tcg-cpu.c                 |   5 +
>>   target/riscv/translate.c                   |   1 +
>>   target/riscv/vector_helper.c               | 104 +++++++++++++++++++-
>>   11 files changed, 315 insertions(+), 13 deletions(-)
>>   create mode 100644 target/riscv/insn_trans/trans_rvofp8.c.inc
>>
>> -- 
>> 2.52.0
>>


