Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A43D606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OJ2Fq+jI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=He78dDY7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtP3-0001ig-9j; Fri, 30 Oct 2026 16:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMtOk-0001Zb-IB
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 16:40:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMtOi-0005A3-9r
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 16:40:25 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UIhmeo487270
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qHGJqcuzg68joUG+BQ30+sMwYnvdXjL7A/ZlallXqDM=; b=OJ2Fq+jIFDAvjwfb
 VS+iTYQ0QvzwzjRYJpElSrzB/gbUPNfzkRMsiV37Biauashe+c0DQH++/q42iTnc
 7gNZ3qNgHqX1xGI1+SPBU1BIT7LnYPz95S4zr6xX4Z7dEKXXZNrN4Ve7jlwznrsX
 5uc+eQW5nO3gur+zuTq0Y1Zv8hLyfdgGF4Uc4cHDZQbXWg8cMAuy8UIIgoT/Odiu
 P6TkUMpj650DwhLZh4SmFGqjGur7reQrelnOz4oIheUEwPn5JN18t0++QULJrG7f
 O9/DDcT+9Ba5DSVRAKMRMkAgxjXgVxf3Nws0tBEpjLhQaD/JamZaMd+rJOKSvH2i
 QIhG0Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn0s70ayh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:40:23 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-351788121cfso5065001eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 13:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793392822; x=1793997622; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qHGJqcuzg68joUG+BQ30+sMwYnvdXjL7A/ZlallXqDM=;
 b=He78dDY75o1n9LHNdX38GywRBItN0g600HKeodAgkco06Q/TDnpzpaQKpZvBmeZ/7m
 Nd+miaRG1roXT9bOgUeSVI4g28ECh2MzBhG/t9r5j2PQP/JzidQ+aVRV6hC0FOhOJNIW
 bSEwQH2aMzOve5Fa3HJVv7AoFwlm3l+Bla0LAKi5Ixh1z5ze/kz704gAAV2h4iFClvkf
 lE5aqhgsGrIEcUXD2Mc5XzRfVnWLKHM+g0nAKWQ+g0HnWGtCn2CwgQdkMAuxC7W9vJJP
 EOcuO+mgoF0MyGTveLks6GfUi0ltPEqGxGlpTKgAEhm5JqE3CZbzuXIFXEw0bzg8ueON
 O8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793392822; x=1793997622;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qHGJqcuzg68joUG+BQ30+sMwYnvdXjL7A/ZlallXqDM=;
 b=sxcTTitr02IlXnHSkY7HASYm8MlS6U+XcW5LqP6aW86JpczANmHlmAlNc3gfg+ezVK
 nK6B4crB51j4W8lETEClCvs6HCj94Y0TLS5tNecap3wAGwmFy0SvxGUxPsf73zDp2I08
 wY1inISO1R9jHg2TFT9VtxLWF2KI0jC/37CYHzA7HUJIhtMfirV2fR6AtToA2YwLvB2M
 trhagafhRQg/epPyGwscpdVN12e6LWZb3RfIK0vpiTnWC/HIJ0zyBJqx6ljC67ukjxjb
 Co1vrOy3EBCcVDorwbXJ146BU0Ps6rlWc/TEYOnwjyptekYI8G4SM3taertj6tBnbGtI
 3iDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRniod1UpeAvDsbToe5U9rHMj1G5d1G5AGnVtaCuGVnJXT+mTjU+mC4wgU0MH4SN5+thnd92CGCd9l@nongnu.org
X-Gm-Message-State: AFq9FYIRFt/cFauZPmW8524Bwa9cFRW3ADfopNPI/euCJJEJn6HtO/XV
 Oiskv86MesbpRpO+sw4wJxOnypQND17obcAFPQG/WHqk+itQqSKd3AVSXk7fAy7JjxEgC+QTo18
 BSQw127S2eCgbebyEia1HWNSy19hQIERm8l+tkBejmjU2Tq+zG8sIZ0Y7mw==
X-Gm-Gg: AYBFou2R0NGsmjscd3om2J/VMAFNGw5XVesxNx345z6NpqX04dqBVgf9Zgd+WBBS4fv
 6GgEQyV13VNxVHc2VeX3Yj3wZXDQKxv80C4Q2dfAPhUTox4lD3/nBccFbC/LyjqR76MkS8+nkeB
 2gv/s4ylnlOIpkwes+HkMNWd5WtVGwm6hIJTS0vkG4x+Gb+e4SYGKfKdFhCwxWNvFEdN0EwXKGu
 VWjVDYkNgsBHtsyuX9N42AAOoYHWwv7/q5JbhRCkEnKyIDwEXxylEmUaaQT/XFcYoqIY8w0ROrS
 AzrZRcAaSnzSlFrM6mNn6tln/Tr41Pf5KM75iQqxArStOfCmGKwJZp6Gq6DEMFX7Z25WCyZJTR9
 gC9bHJn9WOQW7OGgyNIsnm++EE1h1/y1C2JpnMKbsjwLPIqNiNXuU+QmmDCI2XulUxTgzG1CdFi
 AzYizJg5PZOhHb1GTpwjefDxEYx6Hfi5YlHxVogcXzOQU=
X-Received: by 2002:a05:693c:41dc:10b0:351:2958:1740 with SMTP id
 5a478bee46e88-36a42445a8amr4996475eec.37.1793392821972; 
 Fri, 30 Oct 2026 13:40:21 -0700 (PDT)
X-Received: by 2002:a05:693c:41dc:10b0:351:2958:1740 with SMTP id
 5a478bee46e88-36a42445a8amr4996443eec.37.1793392821434; 
 Fri, 30 Oct 2026 13:40:21 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1dfsm9773603eec.7.2026.10.30.13.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 13:40:21 -0700 (PDT)
Message-ID: <6abf8403-886d-4df6-957f-005367ffc840@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 12:40:20 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] tests/functional/hexagon: update release assets to
 v0.3.1
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261029190208.1169519-1-brian.cain@oss.qualcomm.com>
 <20261029190208.1169519-7-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261029190208.1169519-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cooOAF4i c=1 sm=1 tr=0 ts=6ae500b7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=k6hkt-Q96Rm7ybFaZM8A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 33C7bRmqmp57vK3AS7XoZe2CRv0LQN-9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4MiBTYWx0ZWRfX2S9oqCNg2UME
 7GNSIkQBtHA9//hYJ0yBU1YxjInz9+ppw3FJoAh/xuCpf8rShT1zRciJS2Xa+UaRNlx/QCe4wh9
 ptN1V21/V1smvkbCMIgiZQmj0WEk5YtT2+eTISVXCgkLVxRadLSNOajj/q2OEKW3lE44W/rECFm
 kkbTFWeougi52FAP6a1ifyCWIBawJEhFLCO3scI2Zd66uCLFsbcOQBvWS32rknu8psrGRM96O1o
 jjfABHvKK1VBnni09qohlaYdU9e+HtluDtSk+RxIKIS2ruatday22BCK/uoDUJOO+toHZCOt65x
 gdAE4rtdQKuaSIXNfrM3UGLY9DD/+EuaIIADOzpTJvweaeGRRQ8EYPWuZl4cLZRfplYYPP+nGMs
 I4qmjibUcgO7uxA1f5VspESKNHNH6rCUw6bNWUOkfAXT9ZaApZJraLG4AsNR4w0GcztTV3Zav4J
 14CoQDUQgIvwuxXl7DQ==
X-Proofpoint-GUID: 33C7bRmqmp57vK3AS7XoZe2CRv0LQN-9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4MiBTYWx0ZWRfX03eNW8uA1pRa
 EgrRd3oDWjWyny38YbxTI5NvmnKGgcUi7l1PxfEFBSUjBts2jl6z3ZTF30rTlvwDFsTPoQ6QV49
 Fs/CGmyC3pYf1GBhbhOPdjSBLPQocG0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/29/2026 11:02 AM, Brian Cain wrote:
> Move the arch_tests_uart and systests_standalone assets from v0.2.14,
> and arch_tests_semihosting from v0.2.9, to v0.3.1.
> 
> The changes add test bugfixes and additional coverage:
> 
>  - test_guest_mode now covers direct-to-guest events.
>  - test_pagecross_tlbmissx checks ELR on a page-straddling fetch.
>  - pend_wake_wait asserts the thread enable mask and no longer takes
>    k0lock in its ISR, which caused hangs.
>  - lock_verify skipped for now: before v0.2.22 it had bugs exposed by mttcg,
>    and v0.3.1 still has invalid assertions about SWI delivery.
>  - test_l2vic covers VID write, interrupt delivery and ciad-l2vic acks.
>  - test_int_steering didn't iterate enough when waiting and would fail on
>    a heavily loaded system.
>  - The systests package is built with SDK 6.7.0.0.
>  - swi_touch_memory is introduced to cover semihosting buffer
>    alignment/paging.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/functional/hexagon/meson.build        |  1 +
>  tests/functional/hexagon/test_arch_tests.py | 10 ++++++----
>  tests/functional/hexagon/test_systests.py   | 14 +++++++++++---
>  3 files changed, 18 insertions(+), 7 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

