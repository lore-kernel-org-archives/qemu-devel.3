Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B79606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O7j1Ix3c;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zp2nh2Ry
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVih-0002aL-Gs; Thu, 29 Oct 2026 15:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMVif-0002Vk-9h
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:23:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMVic-0006BS-Ji
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:23:25 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THlAGR1323782
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6Fw8/jO0TUa1wWiJaOqGa84BFTrz8pONfVqlD7L0y44=; b=O7j1Ix3c5ry/4ZRA
 QP1IrmuPmtvek62NwMJtz3s1LD2BzptjPJVJqF/M4qaD60zkPFmFV8N1c+KljXx9
 P8HznAMURGcuYErDrkXc7nenesxxlUBk54B3GmxsdCkueSd/zrs93Bj3snvhXwIw
 aZEk8bNq5WQ6RX4n9nHjxp3Ff3wE+fvLUKMtIiAaCP3JNo4GBQDa02kcD3MqraCd
 aP58xLSOYhHfJDvphMESwaI+LnjFxMeJmX+0YEIdTE4Yc6drYnSB0QfCk2af4goW
 Rn3Es9NCpczI76TXg44/ltTesHhECpZsJd13brCZZBntldC33KkKK5EOK8Ln2Kbr
 kMmf4w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmaunhaux-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:23:21 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so56992eec.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793301800; x=1793906600; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Fw8/jO0TUa1wWiJaOqGa84BFTrz8pONfVqlD7L0y44=;
 b=Zp2nh2Ryoj1bB/i64lTePS+wydw8GhQ7XLvK7QzSaOYEshWokpz+inx70ObuS7pAEE
 uAOA7NF18jvm2AAc68c6H890XUY0WhhBXXwa4DczFPfwlfbQZ/n8C0/Zom+Fehbg2sx4
 JNBxPpo0yJoICI+71bgFvUaxoeQaRijjIoR8yNL6KxH56X0hLmR8qn+lbGuSNf9uRnjz
 EB1TF3Pp3C/Evj9cKWI8uK3/ywYxI/6Ont6HRnhz2TFmP2Par9EaJ366B/ReTkCr593B
 McEiBmgQ8Fcf0qGRNRjC6ih98AWzsjsVb29DpvRaGIeLR+LFO9eV7m9ym3fp2q3HE46K
 cAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793301800; x=1793906600;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Fw8/jO0TUa1wWiJaOqGa84BFTrz8pONfVqlD7L0y44=;
 b=Gm0bemX0kytJpwY1Khj8EbDgOaf6op03LXhS9Xh27x1qFm4vgwl8ll8N1bwkyf3CB9
 6v4PeSLoR4o4NF7scvRjP9hqVDxeQOAT2avYaKWgAMcUaA+wzooBizHoyFMdpswK8xbY
 GcOgZfwRaJyg/wwzh5sUjZFqXJjalT/4ZqrCPB+JSuDefTLnUYHOPu2u9NhnB1AZaM8G
 jL/H3QDuSIE0KUPu+0G+m1Zc1u92Mn2VYHn0i3wyLQu98IMgfkQZIn+9UeVIMR9Q9bDm
 lydEG2h2fXJfAjwXY83E9G3uN9FeyLHfJiARlM/B4BfHhixdTG11p2oxYWoN3f7WIFBK
 vn5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAAshmHZN8AWHakHlCTxT1Wp1sUfQ9b5v/ZDlmr/isKgaHW67q9p4TIe+zvcAzA1ObYnj7ngTQ1/cW@nongnu.org
X-Gm-Message-State: AFq9FYJSNF6YE4zguykNqNAf802z/eN1A07se87KLsJvQzrH+DC1Md20
 UH2RAPNQ8Fa7CQHG0ksiakYUnVZDZxQdKUHwUH6oHXwsylFY2KbzrYSDHkut8P7o3QH7XO2Sxk9
 pYfgEvLtDD6/wfgDrUXMifoNUKhh1H2AdNKPJtVzYcEgel6cZw3JdKuhpeA==
X-Gm-Gg: AYBFou2SNUbLK0kZxNyirwmVKS/j+z9wo2GTbGtpBNPD3cFmPdOn/nfcwx+MbiYhqav
 ttvtQcHOUrG+8n+o48fquZfqEFDN6oX0BCMQiYh5yj05UzzFFHMkeLbxBkqC7JLQ+UIatn6XMAa
 Ks3FiNFiBCNhAKkiVcwIt33pwsJSNtv9gpsW8mhYNJ6EPfC7F3hgPClYANEQ0YrAPrF1h0Zc4c8
 N5uxym/6u3LKQehad9WSRogQvGJfMNqF+VflddjQX5xIT2mP9U0UB2AuJV8Nda1jb2zskogzhas
 joOeT0RWp1R1pNp48CsZF22rTxO3YtTectHWAZ7zZblUG7/x0rtp9MgOJNlAQkLW+r5jO1Z1GXH
 w6QUt+0Ze3cXJNtoAjZWa5S4ga8gCnddT8ReL652Kwux/508f6mJLEb8lo9291/Qu71skXMHoW/
 zYa9Any9Qzt3MqC5SRyrUDzwqmhganvPtP3i0uKnc3kfE=
X-Received: by 2002:a05:701b:464b:b0:143:297c:276c with SMTP id
 a92af1059eb24-1a6cf25c939mr7278806c88.33.1793301799913; 
 Thu, 29 Oct 2026 12:23:19 -0700 (PDT)
X-Received: by 2002:a05:701b:464b:b0:143:297c:276c with SMTP id
 a92af1059eb24-1a6cf25c939mr7278773c88.33.1793301799191; 
 Thu, 29 Oct 2026 12:23:19 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1abcd6f1sm615406c88.20.2026.10.29.12.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 12:23:18 -0700 (PDT)
Message-ID: <6d7b237a-6adc-4768-81bd-1279def10381@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 11:23:17 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/31] tests/tcg: Massage MIPS tests for easier
 maintenance
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VhsUJ3V6-b67NZIynrEkf-Q8zEiLirru
X-Proofpoint-GUID: VhsUJ3V6-b67NZIynrEkf-Q8zEiLirru
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3NiBTYWx0ZWRfX3zejL33pZnFw
 jRyS9Ab7c27Ju6jvaO13OoXfVqtEiLWZ6GHd7u8eB8oG4BDGI+VroPdB7pouLaK24ZerNELAuv1
 NopYpb0rsI2/keprKV9GynfawuQsKm9RfNeW+o6MphQlm9Qy7yoyT4WdrusnTdUr/dOyHzESb9F
 CtnNwxe2x6lx9ZSBWJF/UKv4rxFTrienxfsxC2t5RgdjBahohRbN0pBuVeC7LURVKDMhnMqQXqt
 KQ5l5NFRqUb0osTYSTnz23lPZfImzHKV5mWmF3X5LvtI1JiWPuBj22FfehFX1re+VDyQOcqXx+z
 Ga3fUNREpKisq1v1eXKSui3A1mrV364MGL18GUXcS7wFkHCfoi5fURtZ47HGFXvtIkNy3e3uza4
 owbLLP782BO9XoENRT26B1zscKbXGdXUMeOLjyzfuiw/0xZfU+4LRkR0GESlglJ9YOnG3PMKZjX
 Y4jNt+fkv2vckMaTBaw==
X-Authority-Analysis: v=2.4 cv=It2L47/g c=1 sm=1 tr=0 ts=6ae39d29 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=u6_KXaHPFFI_DK04RgIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3NiBTYWx0ZWRfX/+CgThKPxtto
 DTPtTgDPCAi194R8HidmWwqLGjtb+8I6w37qQHt5q3pQP/deVWLwBaEF4S//GeITOwU6a8sKpIz
 WkPmKYzFmmGM33jhkumPu4TDIv4QPJI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290076
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/29/2026 9:22 AM, Philippe Mathieu-Daudé wrote:
> I'm glad we have many MIPS tests but they are in too
> many files, taking time to get compiled. In particular
> on Aarch64 host via x86_64 docker image... Group the
> test in order to reduce CI build time.
> 
> But per v1 review "We can't trade usability for faster
> compilation", so convert to run one test at a time --
> not exiting on the first assert() -- and use TAP
> protocol to get integrated with meson. For example we
> can now list each opcode as a TAP subtest with:
> 
>   $ meson test --suite tcg-mipsel -v
> 
> Now as a maintainer I can relax a bit :)
> 
> Since v1:
> - TAP (pbo)
> - no more assert (pbo)
> - split per group
> - MSA ld/st tests
> 
> Based-on: <20261029152009.19812-1-philmd@oss.qualcomm.com>
> 
> Philippe Mathieu-Daudé (31):
>   tests/tcg/mips: Group DSP acc tests
>   tests/tcg/mips: Group DSP arith tests
>   tests/tcg/mips: Group DSP cmp tests
>   tests/tcg/mips: Group DSP ctrl tests
>   tests/tcg/mips: Group DSP dot tests
>   tests/tcg/mips: Group DSP mul tests
>   tests/tcg/mips: Group DSP pack tests
>   tests/tcg/mips: Group DSP shift tests
>   tests/tcg/mips: Group Release 6 bitops tests
>   tests/tcg/mips: Group Release 6 crc tests
>   tests/tcg/mips: Group Release 6 logic tests
>   tests/tcg/mips: Group Release 6 multiply tests
>   tests/tcg/mips: Group Release 6 shift tests
>   tests/tcg/mips: Group MSA bit-count tests
>   tests/tcg/mips: Group MSA bit-move tests
>   tests/tcg/mips: Group MSA bit-set tests
>   tests/tcg/mips: Group MSA fixed-multiply tests
>   tests/tcg/mips: Group MSA float-max-min tests
>   tests/tcg/mips: Group MSA int-add tests
>   tests/tcg/mips: Group MSA int-average tests
>   tests/tcg/mips: Group MSA int-compare tests
>   tests/tcg/mips: Group MSA int-div-mod tests
>   tests/tcg/mips: Group MSA int-dot-product tests
>   tests/tcg/mips: Group MSA int-max-min tests
>   tests/tcg/mips: Group MSA int-multiply tests
>   tests/tcg/mips: Group MSA int-subtract tests
>   tests/tcg/mips: Group MSA interleave tests
>   tests/tcg/mips: Group MSA logic tests
>   tests/tcg/mips: Group MSA pack tests
>   tests/tcg/mips: Group MSA shift tests
>   tests/tcg/mips: Add MSA load/store tests
> 
>  tests/tcg/mips/include/test_utils_128.h       |   2 +-
>  tests/tcg/mips/include/test_utils_64.h        |   6 +-
>  tests/tcg/mipsel/test_dsp_runner.h            |  39 +++
>  tests/tcg/mips/test_msa_bit_count.c           | 103 +++++++
>  tests/tcg/mips/test_msa_bit_move.c            |  97 ++++++
>  tests/tcg/mips/test_msa_bit_set.c             | 103 +++++++
>  tests/tcg/mips/test_msa_fixed_multiply.c      | 103 +++++++
>  tests/tcg/mips/test_msa_float_max_min.c       |  79 +++++
>  tests/tcg/mips/test_msa_int_add.c             | 187 ++++++++++++
>  tests/tcg/mips/test_msa_int_average.c         | 127 ++++++++
>  tests/tcg/mips/test_msa_int_compare.c         | 151 ++++++++++
>  tests/tcg/mips/test_msa_int_div_mod.c         | 127 ++++++++
>  tests/tcg/mips/test_msa_int_dot_product.c     | 139 +++++++++
>  tests/tcg/mips/test_msa_int_max_min.c         | 175 +++++++++++
>  tests/tcg/mips/test_msa_int_multiply.c        | 103 +++++++
>  tests/tcg/mips/test_msa_int_subtract.c        | 235 +++++++++++++++
>  tests/tcg/mips/test_msa_interleave.c          | 127 ++++++++
>  tests/tcg/mips/test_msa_load_store.c          | 166 +++++++++++
>  tests/tcg/mips/test_msa_logic.c               |  61 ++++
>  tests/tcg/mips/test_msa_pack.c                | 103 +++++++
>  tests/tcg/mips/test_msa_shift.c               | 151 ++++++++++
>  tests/tcg/mips64/test_mips64r6_bitops.c       |  62 ++++
>  tests/tcg/mips64/test_mips64r6_crc.c          |  74 +++++
>  tests/tcg/mips64/test_mips64r6_logic.c        |  50 ++++
>  tests/tcg/mips64/test_mips64r6_multiply.c     |  74 +++++
>  tests/tcg/mips64/test_mips64r6_shift.c        |  62 ++++
>  tests/tcg/mipsel/test_dsp_acc.c               | 112 +++++++
>  tests/tcg/mipsel/test_dsp_arith.c             | 182 ++++++++++++
>  tests/tcg/mipsel/test_dsp_cmp.c               |  87 ++++++
>  tests/tcg/mipsel/test_dsp_ctrl.c              |  47 +++
>  tests/tcg/mipsel/test_dsp_dot.c               | 157 ++++++++++
>  tests/tcg/mipsel/test_dsp_mul.c               |  67 +++++
>  tests/tcg/mipsel/test_dsp_pack.c              | 152 ++++++++++
>  tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r1_absq_s_w.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r1_addq_ph.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r1_addq_s_w.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r1_addsc.c          |   1 -
>  tests/tcg/mipsel/test_dsp_r1_addu_qb.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r1_addwc.c          |   1 -
>  tests/tcg/mipsel/test_dsp_r1_bitrev.c         |   1 -
>  tests/tcg/mipsel/test_dsp_r1_bposge32.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c    |   1 -
>  tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c    |   1 -
>  tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c    |   1 -
>  tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c     |   1 -
>  tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c     |   1 -
>  tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c     |   1 -
>  tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c    |   1 -
>  tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c    |   1 -
>  tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c     |   1 -
>  tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c     |   1 -
>  tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c    |   1 -
>  tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c    |   1 -
>  tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c     |   1 -
>  tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c     |   1 -
>  tests/tcg/mipsel/test_dsp_r1_extp.c           |   1 -
>  tests/tcg/mipsel/test_dsp_r1_extpdp.c         |   1 -
>  tests/tcg/mipsel/test_dsp_r1_extpdpv.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r1_extpv.c          |   1 -
>  tests/tcg/mipsel/test_dsp_r1_extr_r_w.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r1_extr_rs_w.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r1_extr_s_h.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r1_extr_w.c         |   1 -
>  tests/tcg/mipsel/test_dsp_r1_extrv_r_w.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c     |   1 -
>  tests/tcg/mipsel/test_dsp_r1_extrv_s_h.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r1_extrv_w.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r1_insv.c           |   1 -
>  tests/tcg/mipsel/test_dsp_r1_lbux.c           |   1 -
>  tests/tcg/mipsel/test_dsp_r1_lhx.c            |   1 -
>  tests/tcg/mipsel/test_dsp_r1_lwx.c            |   1 -
>  tests/tcg/mipsel/test_dsp_r1_madd.c           |   1 -
>  tests/tcg/mipsel/test_dsp_r1_maddu.c          |   1 -
>  tests/tcg/mipsel/test_dsp_r1_main.c           |   6 -
>  tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c    |   1 -
>  tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c    |   1 -
>  tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c   |   1 -
>  tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c   |   1 -
>  tests/tcg/mipsel/test_dsp_r1_mfhi.c           |   1 -
>  tests/tcg/mipsel/test_dsp_r1_mflo.c           |   1 -
>  tests/tcg/mipsel/test_dsp_r1_modsub.c         |   1 -
>  tests/tcg/mipsel/test_dsp_r1_msub.c           |   1 -
>  tests/tcg/mipsel/test_dsp_r1_msubu.c          |   1 -
>  tests/tcg/mipsel/test_dsp_r1_mthi.c           |   1 -
>  tests/tcg/mipsel/test_dsp_r1_mthlip.c         |   1 -
>  tests/tcg/mipsel/test_dsp_r1_mtlo.c           |   1 -
>  tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c  |   1 -
>  tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c  |   1 -
>  tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c |   1 -
>  tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c |   1 -
>  tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c     |   1 -
>  tests/tcg/mipsel/test_dsp_r1_mult.c           |   1 -
>  tests/tcg/mipsel/test_dsp_r1_multu.c          |   1 -
>  tests/tcg/mipsel/test_dsp_r1_packrl_ph.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r1_pick_ph.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r1_pick_qb.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r1_preceq_w_phl.c   |   1 -
>  tests/tcg/mipsel/test_dsp_r1_preceq_w_phr.c   |   1 -
>  tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbl.c |   1 -
>  .../tcg/mipsel/test_dsp_r1_precequ_ph_qbla.c  |   1 -
>  tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbr.c |   1 -
>  .../tcg/mipsel/test_dsp_r1_precequ_ph_qbra.c  |   1 -
>  tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbl.c  |   1 -
>  tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbla.c |   1 -
>  tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbr.c  |   1 -
>  tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbra.c |   1 -
>  tests/tcg/mipsel/test_dsp_r1_precrq_ph_w.c    |   1 -
>  tests/tcg/mipsel/test_dsp_r1_precrq_qb_ph.c   |   1 -
>  tests/tcg/mipsel/test_dsp_r1_precrq_rs_ph_w.c |   1 -
>  .../tcg/mipsel/test_dsp_r1_precrqu_s_qb_ph.c  |   1 -
>  tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c     |   1 -
>  tests/tcg/mipsel/test_dsp_r1_rddsp.c          |   1 -
>  tests/tcg/mipsel/test_dsp_r1_repl_ph.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r1_repl_qb.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r1_replv_ph.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r1_replv_qb.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r1_shilo.c          |   1 -
>  tests/tcg/mipsel/test_dsp_r1_shilov.c         |   1 -
>  tests/tcg/mipsel/test_dsp_r1_shll_ph.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r1_shll_qb.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r1_shll_s_w.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r1_shllv_ph.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r1_shllv_qb.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c     |   1 -
>  tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r1_shra_ph.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r1_shra_r_w.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r1_shrav_ph.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c     |   1 -
>  tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r1_shrl_qb.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r1_subq_ph.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r1_subq_s_w.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r1_subu_qb.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r1_wrdsp.c          |   1 -
>  tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r2_addqh_ph.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c     |   1 -
>  tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r2_addqh_w.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r2_addu_ph.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r2_adduh_qb.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c     |   1 -
>  tests/tcg/mipsel/test_dsp_r2_append.c         |   1 -
>  tests/tcg/mipsel/test_dsp_r2_balign.c         |   1 -
>  tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c   |   1 -
>  tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c   |   1 -
>  tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c   |   1 -
>  tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c   |   1 -
>  tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c  |   1 -
>  tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c   |   1 -
>  tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c  |   1 -
>  tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r2_mul_ph.c         |   1 -
>  tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c     |   1 -
>  tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c  |   1 -
>  tests/tcg/mipsel/test_dsp_r2_precr_qb_ph.c    |   1 -
>  tests/tcg/mipsel/test_dsp_r2_precr_sra_ph_w.c |   1 -
>  .../tcg/mipsel/test_dsp_r2_precr_sra_r_ph_w.c |   1 -
>  tests/tcg/mipsel/test_dsp_r2_prepend.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r2_shra_qb.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r2_shrav_qb.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c     |   1 -
>  tests/tcg/mipsel/test_dsp_r2_shrl_ph.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r2_subqh_ph.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c     |   1 -
>  tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r2_subqh_w.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r2_subu_ph.c        |   1 -
>  tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c      |   1 -
>  tests/tcg/mipsel/test_dsp_r2_subuh_qb.c       |   1 -
>  tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c     |   1 -
>  tests/tcg/mipsel/test_dsp_shift.c             | 127 ++++++++
>  tests/tcg/mips/meson.build                    | 277 ------------------
>  tests/tcg/mips64/meson.build                  |  63 ++--
>  tests/tcg/mipsel/meson.build                  | 193 ++----------
>  197 files changed, 3694 insertions(+), 641 deletions(-)
>  create mode 100644 tests/tcg/mipsel/test_dsp_runner.h
>  create mode 100644 tests/tcg/mips/test_msa_bit_count.c
>  create mode 100644 tests/tcg/mips/test_msa_bit_move.c
>  create mode 100644 tests/tcg/mips/test_msa_bit_set.c
>  create mode 100644 tests/tcg/mips/test_msa_fixed_multiply.c
>  create mode 100644 tests/tcg/mips/test_msa_float_max_min.c
>  create mode 100644 tests/tcg/mips/test_msa_int_add.c
>  create mode 100644 tests/tcg/mips/test_msa_int_average.c
>  create mode 100644 tests/tcg/mips/test_msa_int_compare.c
>  create mode 100644 tests/tcg/mips/test_msa_int_div_mod.c
>  create mode 100644 tests/tcg/mips/test_msa_int_dot_product.c
>  create mode 100644 tests/tcg/mips/test_msa_int_max_min.c
>  create mode 100644 tests/tcg/mips/test_msa_int_multiply.c
>  create mode 100644 tests/tcg/mips/test_msa_int_subtract.c
>  create mode 100644 tests/tcg/mips/test_msa_interleave.c
>  create mode 100644 tests/tcg/mips/test_msa_load_store.c
>  create mode 100644 tests/tcg/mips/test_msa_logic.c
>  create mode 100644 tests/tcg/mips/test_msa_pack.c
>  create mode 100644 tests/tcg/mips/test_msa_shift.c
>  create mode 100644 tests/tcg/mips64/test_mips64r6_bitops.c
>  create mode 100644 tests/tcg/mips64/test_mips64r6_crc.c
>  create mode 100644 tests/tcg/mips64/test_mips64r6_logic.c
>  create mode 100644 tests/tcg/mips64/test_mips64r6_multiply.c
>  create mode 100644 tests/tcg/mips64/test_mips64r6_shift.c
>  create mode 100644 tests/tcg/mipsel/test_dsp_acc.c
>  create mode 100644 tests/tcg/mipsel/test_dsp_arith.c
>  create mode 100644 tests/tcg/mipsel/test_dsp_cmp.c
>  create mode 100644 tests/tcg/mipsel/test_dsp_ctrl.c
>  create mode 100644 tests/tcg/mipsel/test_dsp_dot.c
>  create mode 100644 tests/tcg/mipsel/test_dsp_mul.c
>  create mode 100644 tests/tcg/mipsel/test_dsp_pack.c
>  delete mode 100644 tests/tcg/mipsel/test_dsp_r1_main.c
>  create mode 100644 tests/tcg/mipsel/test_dsp_shift.c
> 

Series look good to me, minus the comment on MSA tests duplicating their
groups definition between targets.

With this factorized:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

