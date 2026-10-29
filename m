Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EC5606A33A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hap3rfc/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OA0PetGN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVtd-0005AP-VD; Thu, 29 Oct 2026 15:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMVtc-0005AC-3J
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:34:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMVta-0007Hd-CG
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:34:43 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDXUj3234253
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cjRGbaKFnZjrXnAUl+H0bvaGDoydFr9dUa3bwQl8OcQ=; b=Hap3rfc/E2Q349/u
 ebpo2C0Hjav84CECLo1xBrvavCBs5XOfdvP268vR1RvuvPgwW5QY0OAxotGY01df
 0LnWx6gbdXXwrIQ5X3szAbMzTC4Hxq+gbReJHuQ7ev/8GsnjdP75QYB8qsoQJLp4
 ofho2pq1X3qYGDnXHkez4QdeBNRGJf/bw9g9kguLjL6evryOf9PE56PeCLw+Iqs5
 Vy/WfL60BFnnQwt2x0hR6P9WOmNoI9tMB/oXABRqDoCbZW16mYEBRNIF8fVxIgHH
 kPy1XniZT36/TOioXEDhhSS5Vp+J1V8o/tmM1ugJVrpYGGftEJAfZZDTbfVsLmfn
 wdR6iA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b2t61-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:34:40 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36a26fe9521so1045806eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793302480; x=1793907280; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cjRGbaKFnZjrXnAUl+H0bvaGDoydFr9dUa3bwQl8OcQ=;
 b=OA0PetGNoq+1FJmdZQSGwt7c8KTFNId9EKwu9WyVIzgX5lqwsqJnXJR7KnHflU1ln8
 2qT8N+8NicoTK/MoGnjsIQzHnHEHc/tGp4gO5waxSojqa2SuO0T6SK01eIb0xa7JooqI
 pxdRshhSndWs6sriC+1RLJwhHlZck13rUcwxWGoVV9HuhvdsWn1hS6Ks/BEX4zr+O0Zs
 XvE4jsNTbNsQPo26kaP4IkT7B7ECRCTID+In1vgZy8Ix3JWwfdvE7mhwGKBho/HDPiQN
 kJKoHySlGMBKprtQL4qmgfTvSQqLlBLax2V0GayCTlO1vFXmEhuBDH+GcwDP5hErH9R+
 /CWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793302480; x=1793907280;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cjRGbaKFnZjrXnAUl+H0bvaGDoydFr9dUa3bwQl8OcQ=;
 b=qodgxzADPY4PMr3riNbS9Y6PGQ4c9KV4dkYlgIQSxJ7/Z/N0L6nZdKZXVfXWQ+3e4k
 zpGodSdbsVPs23gOoAP4GoUvv/UI6DyZ8ui8uxM7uLRvJxA390dbSDd1usLMulT7IiFN
 1JSQUil+n17YNRAGTzegmiOTBu7MqfnkP8V8kNfUMx+NzPRPGJjdxbr+NSMMm8sStPj5
 pk6pl9zkq/p+BlGfs/+pzrB4fJpWb34OQusfstRO20VB+zYiURySZfwCwk6NbTFI0LRC
 MY1bk8WnKoEy0tV4N4HgLfYO3f5tRzPhkj9mf1MkvIF7AaoOZh0+87PkhAc90utpuUF5
 YIaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwusMXAaFGjSE5VQV/RWF3ub0Xy0ICfh95waVUK9SMDqAU01RNpQQCQydbAbCbAV3du1yNb0bYHJ18j@nongnu.org
X-Gm-Message-State: AFq9FYLNYoZbZ3iPrvDw+bK9blMbNWe7J1b7zKpmB4TaIkLSQis6n+6c
 J+l4M81mDvoKga3VZrvS4vvN5JsX08j6rPfao3wXWIZqGRg/DGoy3n0YX8jiYhcBH5T3eFqhKez
 9YWDGfa48n/2CGwyWSypda3l7oF6Ik0FmdHjfKWLZk1kKJnLZCiOFgJsz+w==
X-Gm-Gg: AYBFou3WM/BYDIgf91lRoX0cGX7X10kTJt4wWH312b6rCQDvcvu6FysCdh38zg/RYOI
 xA8SHQCcn2keRpbvx3yhKG1LV+/gQRQv1XmLIzfoDZ2FTqajR41AFPRncjXcLIpxsEI4Q1QAyrw
 Gr/+vrVbNRfto7cz4AOnVS466GQblbqN769KRZNHq0LZtbGN5VsCI+WdBzEtA+m2nqMf42rsJRe
 8TvpJ2saN6pwAqqE9GexGhAraszbM/cwCJlz8AGJO6AWOvZR9JgnGIR9t4JtHmiXqIOO+t0K2uO
 GFmRLg0hO5VtkCKWF0+4vOB1z110AVstoy9NEoQR/5Ix12BUxcUjS0RsEANP01NnZk1JAnPkU9q
 n2a/pHDP5vM5x+0d7Hnq2DvBEfTiH4LEhovF/J2hjlr7JpoUiDOlNmK4wJFVVa9eeTmbDQpM+2K
 p4VeteajoaVvH0bt+crjAYLsSSEDI5+1I5FIgWDxwrXEs=
X-Received: by 2002:a05:7022:3f0d:b0:14e:37c7:2b20 with SMTP id
 a92af1059eb24-1a9453ad9d7mr4932462c88.20.1793302479197; 
 Thu, 29 Oct 2026 12:34:39 -0700 (PDT)
X-Received: by 2002:a05:7022:3f0d:b0:14e:37c7:2b20 with SMTP id
 a92af1059eb24-1a9453ad9d7mr4932402c88.20.1793302478300; 
 Thu, 29 Oct 2026 12:34:38 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193bb38asm933658c88.12.2026.10.29.12.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 12:34:37 -0700 (PDT)
Message-ID: <2053470f-427a-4574-85a9-01939f26ae9b@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 11:34:37 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] tests/tcg: Add MIPS32 Release 6 tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261029174434.27985-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3NiBTYWx0ZWRfXzn1x52ntwtkd
 SheINh+uLRcYw2e5Mlh6qVJ5yjp4e0XgMhKFIcmIg7Teb8wAWerYQ21y5Dxy50UaR9LUtmC7NyY
 vF8FByACXcomqybv3J70Yk6TfE9AOcw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3NiBTYWx0ZWRfX60VaKjkXdlca
 UB9OKy6V+Bhnf2M945xlK3GMIemzfiQcRcx6rhtZn+nJ1LDZKYxSjm1o8NjfqmoLDXdMGei0OaW
 3aLFGZWEQM/ONV7dSEc1pIf0ivoANMwG7ervcn0unj7Z6iZUnrecFlvd59RK6EQ84q6jdy6oEJK
 OptJUg1b2DIIIo77VfzeLH5XDizm+u0conlARELFrJE2b/6njnMNjLZjqb0jqvuNiRvrBxI5Jcm
 OU7xyaJQnfSXbEE7gvc5GNei0DlTLcTihm0cua3fWCIDPqUGCDIDOO/u5VcSm4RoLS9QUXT+FGf
 vyZ5qyEK3WNMMpiFvBC8/8jW1/AYeKyBIk6T1858YFTxXZzT25clo2uIy95ufeNvMUbOhvACdwn
 Uc5evYfhMyX4ZftjmPnyGVi9wUhD0ySRdOtlZ52+rMj9CK2tsnx/VwRpWgHIl+gESthTUgNINHW
 N6n4S0p6HqlI86QIN+g==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae39fd0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=82romyct_BllB2JXcBMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: fddMb7OSSqa_HH2wIXAQW4wEhfT7yUXN
X-Proofpoint-ORIG-GUID: fddMb7OSSqa_HH2wIXAQW4wEhfT7yUXN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290076
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/2026 9:44 AM, Philippe Mathieu-Daudé wrote:
> - Include Bootlin mips32r6el toolchain in debian-all-test container
> - Wire it to meson
> - Cover all the 32-bit opcodes tested in MIPS64 Rel6 (using TAP)
> 
> Based-on: <20261029172319.25766-1-philmd@oss.qualcomm.com>
> 
> Philippe Mathieu-Daudé (12):
>   tests/docker: Add the mips32r6el toolchain
>   meson: Add the tcg_tests_cross_cc/cflags options for mips32r6el
>   tests/tcg/mipsel: Add MIPS32R6 logic tests
>   tests/tcg/mipsel: Add MIPS32R6 shift tests
>   tests/tcg/mipsel: Add MIPS32R6 bit operation tests
>   tests/tcg/mipsel: Add MIPS32R6 multiply tests
>   tests/tcg/mipsel: Add MIPS32R6 PC-relative tests
>   tests/tcg/mipsel: Test MIPS32R6 SELEQZ and SELNEZ
>   tests/tcg/mipsel: Test MIPS32R6 DIV, MOD, DIVU and MODU
>   tests/tcg/mipsel: Test MIPS32R6 LSA
>   tests/tcg/mipsel: Test MIPS32R6 BALC
>   tests/tcg/mipsel: Test MIPS32R6 JIALC and JIC
> 
>  tests/tcg/mips/include/wrappers_mips32r6.h    |  91 +++++++++++++
>  tests/tcg/mipsel/test_mips32r6_bitops.c       |  82 +++++++++++
>  tests/tcg/mipsel/test_mips32r6_branch.c       | 128 ++++++++++++++++++
>  tests/tcg/mipsel/test_mips32r6_logic.c        |  68 ++++++++++
>  tests/tcg/mipsel/test_mips32r6_multiply.c     | 108 +++++++++++++++
>  tests/tcg/mipsel/test_mips32r6_pcrel.c        |  95 +++++++++++++
>  tests/tcg/mipsel/test_mips32r6_shift.c        |  84 ++++++++++++
>  .../dockerfiles/debian-all-test-cross.docker  |  13 ++
>  meson_options.txt                             |   4 +
>  scripts/meson-buildoptions.sh                 |   2 +
>  tests/tcg/mipsel/meson.build                  |  34 +++++
>  11 files changed, 709 insertions(+)
>  create mode 100644 tests/tcg/mips/include/wrappers_mips32r6.h
>  create mode 100644 tests/tcg/mipsel/test_mips32r6_bitops.c
>  create mode 100644 tests/tcg/mipsel/test_mips32r6_branch.c
>  create mode 100644 tests/tcg/mipsel/test_mips32r6_logic.c
>  create mode 100644 tests/tcg/mipsel/test_mips32r6_multiply.c
>  create mode 100644 tests/tcg/mipsel/test_mips32r6_pcrel.c
>  create mode 100644 tests/tcg/mipsel/test_mips32r6_shift.c
> 

Out of the comments on two first patches, the rest looks good to me.

Regards,
Pierrick

