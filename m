Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DA8CC6B2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6Sj-0002p7-Fj; Wed, 14 Oct 2026 17:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Si-0002n9-0A
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:24:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Sg-0002HO-5a
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:24:35 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EFpaUv1672232
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o3ZdItaeuz8D1EPF3/ILEZwco0BpqPH8sqn8vbPtjJs=; b=el+7wZmKniOaHJt/
 jlTv1e9m1o/yLb/+UGU2MghRp9kGgtISd/4emEr2Dalplv+ddXwCejWI0jCvYfsM
 /k6Ieu+DSu7xMLJusPiDHETxGDeTqvrDuoDfgNeScjEcftCOTdIiGYEdctmtgil/
 Di60OFks0X+98Su97RUaJWNS6JZyC3LFsCFB5ue7QIwaWOTOPq3pqI9ewjuwXT+X
 D/9cox8yD0doYluguqpNV6esG6LRn8oRkSAqN3m6s0tN1SFhpD3vPL0sQnG9obnR
 1zqo2j47v2iw3kGjLy47VhVGoBakFsDdg6mj4PbYaIapDMbtpUAjo+t334kzi5Dz
 6RtcsQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacrh96me-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:24:31 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso9736145eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792013071; x=1792617871; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o3ZdItaeuz8D1EPF3/ILEZwco0BpqPH8sqn8vbPtjJs=;
 b=Y4tVRaqU5pfxLweQzyY0JYIyPqe84vFdRwMLI6EJpgN0M6b4sA2vphAACZ6mIg4nh0
 M/A7keRRqrcHiEICC/GZfRClgAhuSfNbZT4L3mZBgJKhw7lk3JNhgwtZ0AvYl+Njq0qz
 8Dq6uyBQCruA2jb3yPqYITKfJ6RblAbo6beje2wIgqNvg1b3cE4c7T1JGYirCdNZgk+O
 j5qTyEk2lM+0g8SunnGYER2kxzPiBu0TRNEH9flI++OVsd8DAQBkkhdTClvDFCvFFFJp
 40bZpawd985seI0fS2ZBcDnr2pLJkRAChc1KWHaRSBZTyYhR6fqulnlPChpdxdEzvD8K
 OHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792013071; x=1792617871;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o3ZdItaeuz8D1EPF3/ILEZwco0BpqPH8sqn8vbPtjJs=;
 b=AVjF1SZzShC3PBalplO/nzhd+44mXJzR9I4x83siitGL3L9llNolE7zhPy84dlqEGa
 DAQKjgq9O+5Q+4WVKJykHQKCtrBZSlv6vVepuXf5tYK2xiTbBC9p6Xwf48IWBxwA9RtQ
 Mc/wyxOkKL+aquE9LJQczC21UeHHl64tmEXjQMKmayHLN8hdsqnwPP8N+DoJ07NaVR+7
 CszWsqMz1KHXL2TgylM4Dkqxj3IkhQeeCqb9zGUj/ylaH+preAPr/xdMXqwTDTdBTMP1
 HG55Dsg/SsUksRVdkQ/Vp9xWZAfSzbU7bcOMc32YSC/jk6jqhx74MKt5SJdxuVDTKk0L
 ssQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx70+hcD+zECbL6y9iarIijK1XPNJrbQwq5vX1njiIlKKI/4dtWlSSHOMa1BIPx+j6W7Zum4pVM3AMT@nongnu.org
X-Gm-Message-State: AFq9FYLBZiJd+WiC6JBzTSCJqGXodt4yQ0DRxgH+YvjnisrgOamiwG2U
 qv6bolNZC6gS9sWJlnkpYtfkuxdBSgn87rVGDlc/i3ZohuzRil+P2pkMtZOSqd7jxoKM4+eo3T3
 5C75xFfE3q7j/dKfEtBIpqmCKyaimJhP6iPOZsIxYeW3aLGMkIYPlGJEDzw==
X-Gm-Gg: AYBFou1TvrjfI8eQktEdNO0GBKSViodvBDtncAUGJHlcCcscwr2r+UyMb2EoO7OWej1
 lWz+ULdIgwLsBoiUb5kCtA9jTyaQ+mo2pRvE1IGv5wiSVFSFNRl0W0hLrjmnZqfLNfmW8qmnTHE
 4MNUZxVbuPqxVNoL0/16r1JuMJuDgRh4Wz0bcFQQDUhBtkk4zwIq9Z/QFKOlcrT/bD+5+eePU+d
 UyxAwTfLkXU4AA7UBOoaOFFCIfo5F7TP97reGTarLLMJTcMp+AmTS0RlXrzY/ZJglN0RszQgX4v
 XxrU5rI4Cp+Wm2HFwPd0uotfaRn2z0b8GIz5La121VafwpfPNrDlwrqxwZ5z/opRnhrz5e3KyTr
 W++9N15kCvJgxKjwQvDjyMP5p8iMSitDZpLBbONmuuEojjM2MjCMeYnD8WlYb/XPRFcU6WQ==
X-Received: by 2002:a05:7300:c01b:20b0:354:b5d7:5a8f with SMTP id
 5a478bee46e88-354b5e69defmr24891944eec.30.1792013071108; 
 Wed, 14 Oct 2026 14:24:31 -0700 (PDT)
X-Received: by 2002:a05:7300:c01b:20b0:354:b5d7:5a8f with SMTP id
 5a478bee46e88-354b5e69defmr24891899eec.30.1792013070495; 
 Wed, 14 Oct 2026 14:24:30 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c61eaa0sm61485345eec.0.2026.10.14.14.24.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 14:24:30 -0700 (PDT)
Message-ID: <14457301-e847-4d71-b4cc-3405e29b744d@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 14:24:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] tests/tcg/hexagon: add v85 scalar tests
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-13-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014195223.3233623-13-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: C8xjCEADJtFAudg7X0tzWJviWMbyj_Nx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NSBTYWx0ZWRfXz/B3O/qSytJb
 nGB8ZRb0BEoyqnoEwyeUZh+U4WstAddnKf9rEdK+qHpcB+hH3voSsXrj1EqzSacPh/T0TFB4lp7
 9eJSm2QZUX7ihHbEL6FPbOjdScMCMjY=
X-Proofpoint-GUID: C8xjCEADJtFAudg7X0tzWJviWMbyj_Nx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NSBTYWx0ZWRfXw2hKwVRY9mBD
 NkhM/woEBkHh3VS6SRWiebxNxfMTPmSvutFaZuGSHKoj1rDqV3CUjboHOkJjJzapDi/MroZTXPt
 HKPEt5XL8MqUiRsqAdFbk65t6/ABXVMP6vUHxRPGxEtl4MzFXf4ZYUDWqDAcHJzg0/uqBBxmai3
 uqWcogXtQ0BDjndIgYInPw/cgq1APf6GeQU1GBrocadojtgxsc4gMu/jVd2zDOgVAx16ucJhRgo
 KXNJhaPgLmrRpELDlEd7HM/sWwnoatAGbVtss+1PoL+9K5i5R7DAc7GA80z64xVQZGsPTaXXNAb
 5nByC8BGmaFEA36Tl3TAgFTzgV62qYx5HVwiHa2tAihE7BzFp/B3ajVCS2+VlyOsECvc6vkywfH
 GZMgNj6t+R6RbJBTxHih4c7uGSzE0xoiowUjhvs/ElWhnMjC/plcX4I2ijUxi8OZdwg1hauH1QG
 GwNrk0nHSa5EJlA+MGQ==
X-Authority-Analysis: v=2.4 cv=SYZi5fRu c=1 sm=1 tr=0 ts=6acff30f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=NVj3bG-vobQe6hkj9ksA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140085
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

On 10/14/2026 12:52 PM, Brian Cain wrote:
> Add tests for: vallocframe, atomics, trap2, CFI/restricted branches, and
> scalar fp instructions.
> 
> New instructions not yet supported by the toolchain are manually encoded
> with .word directives.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/cfi_tgts.h         |  16 +++
>  tests/tcg/hexagon/atomics.c          | 102 +++++++++++++++++
>  tests/tcg/hexagon/cfi_user.c         |  63 +++++++++++
>  tests/tcg/hexagon/check_rev_gating.c |  10 ++
>  tests/tcg/hexagon/invalid-encoding.c |  20 ++++
>  tests/tcg/hexagon/trap2.c            |  34 ++++++
>  tests/tcg/hexagon/v83_scalar_fp.c    |  98 +++++++++++++++++
>  tests/tcg/hexagon/vallocframe.c      | 111 +++++++++++++++++++
>  tests/tcg/hexagon/cfi_tgts.S         | 157 +++++++++++++++++++++++++++
>  tests/tcg/hexagon/meson.build        |  19 +++-
>  10 files changed, 628 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tcg/hexagon/cfi_tgts.h
>  create mode 100644 tests/tcg/hexagon/cfi_user.c
>  create mode 100644 tests/tcg/hexagon/trap2.c
>  create mode 100644 tests/tcg/hexagon/v83_scalar_fp.c
>  create mode 100644 tests/tcg/hexagon/vallocframe.c
>  create mode 100644 tests/tcg/hexagon/cfi_tgts.S
> 

...

> diff --git a/tests/tcg/hexagon/invalid-encoding.c b/tests/tcg/hexagon/invalid-encoding.c
> index 639d7f24959..7c4dd244559 100644
> --- a/tests/tcg/hexagon/invalid-encoding.c
> +++ b/tests/tcg/hexagon/invalid-encoding.c
> @@ -89,6 +89,25 @@ static int test_invalid_nonduplex(void)
>      return sig;
>  }
>  
> +/* L4_loadw_phys bit 7 was reserved beginning with v83. */
> +static int test_v83_loadw_phys_reserved_bit(void)
> +{
> +    int sig;
> +
> +    asm volatile(
> +        "r0 = #0\n"
> +        "r1 = ##1f\n"
> +        "memw(%1) = r1\n"
> +        ".word 0x9200e080\n"

Please add a comments saying which instruction this is encoding.

...
>  
>  tests += {
> -  'atomics.c': {'cflags': cflags},
> +  # The cross assembler does not know v85; v85 instructions in atomics.c
> +  # are encoded with .word directives.
> +  'atomics.c': {'cflags': cflags, 'qemu_args': ['-cpu', 'v85']},
>    'brev.c': {'cflags': cflags},
> +  # The cross assembler does not know v83; cfi_tgts.S uses raw encodings.
> +  'cfi_user.c': {
> +    'cflags': [cflags, '-O0', files('cfi_tgts.S')],

-O0 is part of default flags for tcg tests, no need to set it here.

---

Overall, looks good to me.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

I guess we don't have yet a public toolchain available yet, but if there
is one (even without source code available), it would be better,
especially for cfi_tgts.S.
If there is a v85 toolchain available somewhere, feel free to update the
hexagon dockerfile as part of this series.

Regards,
Pierrick


