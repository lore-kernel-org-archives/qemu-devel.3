Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46646606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 23:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YjOtCKpd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gaMHF7or
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLqMF-0002Y3-Nx; Tue, 27 Oct 2026 19:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLqMD-0002Xb-9h
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 19:13:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLqMB-00074I-HZ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 19:13:28 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RKtGG52253464
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 23:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zbnrPQoQWCO63bXkZ8ugZuxVMM66OODq+Zy3HoMNx+Q=; b=YjOtCKpd1r1C7qv9
 6HHEBW8uyZyMS45wtBie5gGxHlr9yyWZ03iTyFT+UYPxosXASKn29qJBMsoclx5v
 j0AsyE/6SXRs2YJLesTnNvEAhJ0ev5Tw8l3xfOIWdLRFGCCfJe0wlOBJonCzJ71C
 dAyhVSYal1Tdj1GyBalDim/OtsZbrqqKozkKDv3gbfwLoQb51PcUeEYVbUJKJvrY
 c+WptWY2uALh0KicwDFzpdLcXxpomqrIobE7T2GMVqYErYMY6ykFx5VgxxZV4Ri8
 6G8tGltAiGiJTNSIdmlrtAVlKhEXLqUnCJlpQ3TY1IVQFYUAu0MVzFHfanlhggZJ
 kuftuw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux9ahum-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 23:13:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso839325eec.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 16:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793142804; x=1793747604; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zbnrPQoQWCO63bXkZ8ugZuxVMM66OODq+Zy3HoMNx+Q=;
 b=gaMHF7orMA01UIE+m4fCAYDxII1EOoTRslrz3O+G1YG+WwUjiWkWhvY44xOciFCpB/
 WFblXzBS4tRYtd5tWt8vo08swEQuWVW+mnG6GtNbtoeKCRe6+JzPPCghLAWiPtFP3Y4C
 jq4iOWViSs5TlsuPIMo9CKEJTszLzD6r3rCo+KDtoEjTGW1pLQSvVRxuK73ZD9qFQcGL
 5Lx5FirLLzrB/KHfTTVnIDeDmE52O41qOV+h1K0dT1e0A/bueaH1tKBBJglPSLuOjH0a
 Iszc8WKV6ANTHfFApIMSZvM8Emnac8msjMhipto7nZrwJxFBnYKe9nF6ClW4UKdF6bro
 p8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793142804; x=1793747604;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zbnrPQoQWCO63bXkZ8ugZuxVMM66OODq+Zy3HoMNx+Q=;
 b=k/e1srbNtW+KSjcLJ2+seMxHJmjvR0xVrPms+YJk+Tp7uznSL6+QfiHl7tayO/FnLn
 18uuADb3S7IRak+OF146MJowuzlTv/9gigoC+e1PTEfSDZ2rZHcYO04xU67AkSDWRxAw
 d9SlMUtTpWP26t+tKzQU2odOHWa4VyfPsL1rgkJQvChvsJwrZMq+7mfrJWkjPTRa7r/I
 jQWdWhxsGQmmXvW2OvI9BE3jU9vDnn3KhmCccuCyalgPLLdAcUhdT5dh4RSzyTiVbCCn
 Pxzgy1/4Z/TGCRPuSMoHvivNDlywKgFKmViwM+ME530fpWEjyvlRPP5bC1N/ZsyRrGFd
 jiYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzO4PzfEoKM55lX+9XjpKnJp/LEenH9UwrfwF9vpexJjw6yBJR+WKtgtImAX3BETF3NXCcwvY47qOG/@nongnu.org
X-Gm-Message-State: AFq9FYIfaJZ7fnPyYTQHYAjJSEIgv+ehR21y31h+Gd4foAHAo4IcBUZa
 BpVxtP7I6pMYEgDwAezRix4nm/Qk8xoSfhJyIculhYhbWhej/zay3vUSZN/Y3HssHuW8ad4q5ea
 EJMoByu5p3hHMdcu9bqM7vA38+3gIoU/bEXJo0zIHcAWIyN/5C63JbCFLnQ==
X-Gm-Gg: AYBFou3S4//q2c+O7/vLnypT8qgUk5NF5/Of84NZLe20xJ5M8WAZn7j0WBQnqxc6UQE
 HtiERp2mXxhiq4J4Oyxffd8/GqhNCLKinkS5+tGqun8fr4becOleLZj7Ar7bhq3dHs1V6hbug8D
 HJV5AIOOFIJ0Jp27wZpJKUFNbhISZbuvJGSpP3+7/sWiHZ/NBlGLHlepMNqSYRiJXkka5+qMoia
 eYxHS7VeSTr+A6GylGyujErT6vr8y/mK+++5mySSwncuDsg1janOl0g2Q3CVjrKJEmbV7sLQYfB
 Wm0mSf99L1FoJFzcws3OmDUZSLGbcctZglzc0bYBLtnQQJrY0mVfTCUmP+oDVePx1BlXgoBq2rV
 oMHtszGup/JQsCnGqiZRoaCVGzZO5+nu4ykvKwrZwb38+E7mFuUivdQ4yKg9AkhUJOMAjnw==
X-Received: by 2002:a05:693c:41d7:20b0:367:3d68:8480 with SMTP id
 5a478bee46e88-36a20115c41mr1095285eec.0.1793142804128; 
 Tue, 27 Oct 2026 16:13:24 -0700 (PDT)
X-Received: by 2002:a05:693c:41d7:20b0:367:3d68:8480 with SMTP id
 5a478bee46e88-36a20115c41mr1095251eec.0.1793142803438; 
 Tue, 27 Oct 2026 16:13:23 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a01fa4c58sm49796355eec.21.2026.10.27.16.13.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 16:13:22 -0700 (PDT)
Message-ID: <f2a3462b-a3a6-4506-b6ed-a3f15132a73f@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 15:13:19 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Adjust NONNULL annotation on *_diff functions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20261027230816.201808-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261027230816.201808-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae13015 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=XXW6PjBa8LV8YPU5GTwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Avp2UBKdbFR8dLNTjfGFQ4f2mTh6FCJe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA5MyBTYWx0ZWRfX1lKGO6TgE9dq
 dBjLdF74I2EwzxW4Ja1C3GxYDpFFs3XJ/rGsE1lwt3B7CgCNsA2yUIf6Absgr5xwguVoF05yBEh
 XdbIR3bfwJ9eeYV5R9J5+eBxtmc4oDWZyWHRBwVVTwHzSclK47an9iqSxDHEM8roJYKwCyjAzcB
 biFbEf0LorkrZmGNSOwpIAE9jAVzi7KV1uS93K8Aj8ty+kLa5hrjdXA9Iwojk6t/qhWQAf/g0Rv
 OaNgD/QvWQZAX3PdU3RfpFrWCEFM6dbVMlZZb7ZVpNWxcSyQxh7n0lnIh9Kt/sTu663Kq31WWMl
 hCUByA/PM3PwCnAq+/SdSOO/KLRLavllwpBME+OZmUmNh3SJEwNM/Dgix6T0tzApGw3cP8z+HnM
 IpDZrQgRgSfhSBRrFrrAwo3c/3CwBEiREsWC4g/Hu2W7wLjnkI2DuphAQf5dz/hJyfjNy4WgH4z
 s315dzwGHjWG6Spgh0Q==
X-Proofpoint-GUID: Avp2UBKdbFR8dLNTjfGFQ4f2mTh6FCJe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA5MyBTYWx0ZWRfX6nvl5RUkbRh1
 iXsK4/hRcuCmsUqVLJLFBYWPIThJLhVIc+T1kx//+ORHiBelHWHxnsDA06D+8r1/gin9z+nameZ
 iwPjmGFbpyXNx7tQk/DwadX3NOLPmhg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270093
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

On 10/27/2026 3:08 PM, Richard Henderson wrote:
> In tcg/sparc64 we use tcg_tbrel_diff with NULL as a negative
> addend in a relocation.
> 
> Fixes: b0b6701a4018 ("tcg: Annotate functions in tcg.h with QEMU_*_NONNULL")
> Reported-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Compiles successfully on a sparc64 cross container.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

