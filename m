Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C74606A332
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=olUua58Z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ROZAT/nz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHjX-0001Rl-4i; Mon, 26 Oct 2026 06:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLHjS-00010q-08
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 06:15:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLHjQ-0001bZ-Ar
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 06:15:09 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4aPr32222502
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 10:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xpl6u8RMcQ6e8P+ND0XugC5IUXDENblf0En6nGh7F0M=; b=olUua58ZdwGGyOKU
 3SADzDMMOs3ra4g4bxepBZ4BYmannbgGOWLFDbYNHyUui1SJl9TRrxGrO5lpK7pX
 4xR5jus6ApLzsAKqv1zm5xm5bNmfELvMOBY+Q/vAST42jfp9g2rV5pIGsUuFspZh
 rcnhNZ8USsqskSvV2vA+JiTCQvy198fLvI1doJSxI+g9dZ6qqv1o6ndiiN3QbS6C
 gZSs7JT2/tlVuH1+VEBDNS1Qypjz0Up2hdFOBq187KYIW4zY3oe9QKHoEmnD7bv6
 elmwh5YB4yPYqqDCopR3bMXFjkfPcu3MgoDqpcEnLUoLCGa6b9w1HVcy6zlJONpg
 EGPelw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd9muv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 10:15:06 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91b994cb09fso72262456d6.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 03:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793009706; x=1793614506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xpl6u8RMcQ6e8P+ND0XugC5IUXDENblf0En6nGh7F0M=;
 b=ROZAT/nzTTj3O5BvyPWSVQKariP8TJJMoXsvruhb3b53vpxdE0wKH+3z2z2EmJD9tz
 lsWxkrqgwmPKHuu2a7mL78O2dRVb/4dONXnmrTFPJexFXMhkDKyc7NK4OeYP0ZOtje8Q
 Ou5/5poXbyxH1LG7JQbXWDoc5GwGJT5Kp5nqtv8V51hfRijRyL1RqFc1qqG7BLafx0dK
 Y+GCrN0Wc3UHYq3BursIxFa9q9+6w5Uuw3wA30C45+HmPxR+eMisG17xetcDGUBWu4PD
 UWRM02Qi88aaSqLVcD5XUr09A3aHHga7ag99IgPVyKniyiWqVDogn0i3YQT5zpCltyKh
 38+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793009706; x=1793614506;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xpl6u8RMcQ6e8P+ND0XugC5IUXDENblf0En6nGh7F0M=;
 b=Usjj9DxV8fC9fsWBg4A8bPVn3vw3dVl/C/fbBZAwtRsTvkFgUmvW7ceY7Rp2gvYGLZ
 Z0KmmIvHyBWCVbyu5/1gcLgcst5vzmC77aDRWt1kZAZkfuuRNAHuXUsLyZMLN8SecO6B
 JQXT5PdNTFc/kmQS7UQclHojxata1l17/tO9YRRQKdHep4wFR2NFCrvE4+o2WQd5XuVx
 rlhl1oYeM9L0V9VgoLCzb5dEWXtxjPjq2ybKLCWdpNoOoPlcLINI5VgPjb/RxBijgXMx
 xj/OoFVfbvDhL12mfsyyziOAbjqFyIgSY1YEJJcLNrEt82dlyyjAl2wwHvPHfZ6P7WCQ
 u2jA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5vyY2pcY2GN3iEjngDD/LSSRibEVtNTytGLHs1AsGxItvD7qhm6ZUmmEv7/eU2h1N4qKpS1IwuL0B@nongnu.org
X-Gm-Message-State: AFq9FYLwzEeSEkB1snpn/ZZdzzXhufDeDxq1D1374rVh9Jn+Y+EVhm15
 oPcHDvyZFj6zf8VLDp1s8U5lNd7QS2aq82bMb/uBH9P6iLrG6XHbJgQlf+4xEX85+THf5oPjp/a
 Y37fFgMWILSWdVOV/0gb6q9G280ohyqZ44EJJ2sN+9Lm+m8S9k3jxYJ09JQ==
X-Gm-Gg: AYBFou0eD5pyYdfvcCj3K3D35c4FC6OeAjtFMVNJRITE9Uk2MY5Bzs03V06bPtv3ZY+
 obL9WvZYEzkJZA8iFf3GSU8ZygSmI39mSTAnEckDmvvmjTSVR+jQrDW0dNQgCPfEeYevulCCigj
 y6XIE4WXxrC4hAqpwCdu1vvW0upnopggnY4jLi5tEdUyFGyI35Ox+6ehdMII1XN/MHm3z9JXKAs
 OcFUSeHux4OyYJtyNItF/C1g3uhhANA39YbPiJTezkZs/JF0QIOLrqskQ+e9GYLx43suKhF6Gdv
 AGdX2gRFeecFuUMpfw6v4IPq/bBVY6svTtkzMuZ6qooVN+tLBBINqQMswVnw68mhtYxeaCeEft+
 WYLg515nwIFa9seQHHgPDkv6zn0mK2W64IA==
X-Received: by 2002:a05:620a:6016:b0:93f:43a4:a48c with SMTP id
 af79cd13be357-940ef964acbmr948917885a.45.1793009706007; 
 Mon, 26 Oct 2026 03:15:06 -0700 (PDT)
X-Received: by 2002:a05:620a:6016:b0:93f:43a4:a48c with SMTP id
 af79cd13be357-940ef964acbmr948915185a.45.1793009705536; 
 Mon, 26 Oct 2026 03:15:05 -0700 (PDT)
Received: from [192.168.69.230] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4bc5sm15352772f8f.34.2026.10.26.03.15.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 03:15:04 -0700 (PDT)
Message-ID: <13944dd6-82d8-4917-aad3-2a1c259114ed@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:15:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: Add a target to run all tests in thorough mode
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261026093034.516604-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261026093034.516604-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _g6JLCn9VyeFY2IHmiuKi2QLmcQgITm0
X-Proofpoint-GUID: _g6JLCn9VyeFY2IHmiuKi2QLmcQgITm0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfX++36+xN+wUJZ
 ExORs8TTxyh6PkvHnhkFkMOluVOUWjehWkjVmTeHdFLP8Vi/Vko2B4dhZQsqrcslEtJNo739iSO
 RhPfwXYSJHVStZwkJ/rNTfaOElQ8nSHmP5ZsDzOwbui8ciuLpgcPqqNSxFwdxTyMkzYvFXjitWo
 Phrl9bqxgAhe9SS4qBYhSJKL4dxsrlt260yCIOML8rMIDdaI3W25PWTLYIizw4YLAdMbrdQ30kw
 bRjxgsk+y4wI4Ff+B2Pasclgl+AwHSEukRb/PAp8E8H4bJB6c91CCLTO1hgDRPeH4V5E2eulzEL
 P1plJhUmggx2F3GW7RALKLR3+zB0TN98VvygxBdaJhfJK1xYSSuPqr896cIMVJ+UhRP/9twmJmx
 beq4HlqtOFQXhGlac7/NE9HxhliNTGXCIYYsrzAws4e1ZqQlk08PaMo8lHpxNDJllBcKFU7vAh8
 4uTKH4FeFJPHbSxgD5A==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf282a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfXyOnmyQVEWgbr
 yDIpbk1Kb/ucTQsiNQDu7gACnPgrYoTj9hS8fS7zcRVO6mzTdHkKt4xaHehGxUys3j+CRx/dCkR
 kuP+DGa/AtCH9slPYAaD+t70sdC2LdQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260040
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 26/10/26 10:30, Thomas Huth wrote:
> "make check SPEED=thorough" is a little bit clunky to type and many
> people are not aware of this nice possibility to run almost all test
> in parallel this way. So add a "check-thorough" target that makes this
> way of running the tests a little bit more accessible.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/Makefile.include | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

