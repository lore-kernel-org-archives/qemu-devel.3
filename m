Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B794606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wi+Lxka2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U6J+nAU3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFD1-000359-3I; Tue, 20 Oct 2026 15:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFCx-0002xX-IC
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:09:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFCw-0006GN-0Q
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:09:11 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGu0tB764803
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /4rdHmmXChvWIi5p7Ro1MxqljHJ4YPH2cINhwFZCzCs=; b=Wi+Lxka2S64059I2
 wr7c30IofdiNHc7BVpQPM33HLoUMv+G52/B/J+n0unWjhX3h1gz/ftPSk8FSG3vT
 qdTtnYO64Xm3/7uuHFeBXy6iPsgIvxw9KFud9AJhPL4975fTF369DrLW0dXzMgkA
 XxNIQ2eZxao9IoxKYfePG3T0tgDKx6xeij5SL2o08J9QNvPAJw3DXMtedwT+Uhf3
 qk2YZHlPvJxA0fI1PenUkpMvIxCrPEcJ1ZBaXXSMRLDc7YCBaqYwrt4XmkdcXS88
 Suf2QktqiZeZwhNIPNwRwr4H5RHrY27bTlgcRyZvoSdU8YrATt5F0IaQcxnsOmlC
 lJqSqw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7hv9qju-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:09:08 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso5509870eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523348; x=1793128148; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/4rdHmmXChvWIi5p7Ro1MxqljHJ4YPH2cINhwFZCzCs=;
 b=U6J+nAU3KUlIBrjEGlLrIHnb6kQLCndlbLN6S4guKuT4JXvsjWKUEsryzwAL7Ce9GA
 1kaaz6EcBjvMjurRAmXM0c0KPv/xFIwtKAmsIPzdBgHxsaiKmG8VC9fEw67L9Z0R/KJ7
 TDy1pZMXVqi//RTZwqZyN7/RXGjA7c0XKJGSlu9A90eT7rRNfzXy+upw2iYgFupokgs8
 4EoCvvFr86oYkfYKvSeJuIqajnBkwIxqyFyvEe1QOVplmqob8Szwtnd3WMe+a3KR+WfB
 VjpZonGgxaAonTf+F556Yn29W1OBYzWk4lAZnbTpmmmQLIgjcitrha3XRDxCUQzdw4MM
 XI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523348; x=1793128148;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/4rdHmmXChvWIi5p7Ro1MxqljHJ4YPH2cINhwFZCzCs=;
 b=ad6fn419Km+7q573jrwJ/7U8rnwodxF9tSA4Rccdy20LAyevO5S0X2MXHkBoE1rj5q
 hGjRJCqPryjHqdtEOauohtv7lcpeCSBWhCspz9MoAR3xqIGIcLt1jdtgz61beejEEAst
 ZmFvQhtFXBA3l5FZuxvO0fVIMRmFMsUWiXoK8xBOx7ie1I9HuzfoWFsXnPCgKz2Arfp3
 OFquCbRdQpm/9gu0Bxp8vrcI68qEvNlp7Eilt9ElKq3hsCm64OOpbHxXWrX6K0wlBoi1
 1Erj9UcO7ZEjH/7VktWUhq+QfZI3L6n6i0t0Cga8NeyTdiXkGP6xm2GY9MPO4saXOpAC
 Zwog==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCS9rB+fIkqD4CCsWCiY5xeYIGgVpgBAMN8D61NNZot6S4q+baL3a+uFLcg3n8o4SIYC5JWDONhnzO@nongnu.org
X-Gm-Message-State: AFq9FYJMJxhQK1M2lAIJtEENhrSy69Azdu4pyXZ9Q7Um8IrhhWjZ+yd/
 PWlOvw7sfW2A31os/Up9anyzuIjaWCGOnLHjwbXZ4l+eIoFug6p4C2VpNktYM1ZlapsO9qrAwGt
 xqA3lriDRjjQiSl7pNp807Ud9EoGDiE8OAmIz/et+fT/vJBOEEwKYfMTD6nPyltpj3A==
X-Gm-Gg: AYBFou0ODNJUoEQ/eDwfvGYSqxQpidEdVSuTwDi1Tha2m/Tb6ANhIhEUuKvMh8qMmY1
 qwLTYlk4uJcEsBX/OrwC6MNeuxCWrhBNUjZvyTI4J/Dke7CV3hyDJUZuH7eJQeQPCfpnUJPk4aj
 5hbpmkO02FZRLeU1hvr3yBP/BRxG//P1euCdFhCqHyGGOGNNEIQEAo26Nn76DF5BfoA3JmkDLsa
 Q4Ms6BGaVYi+G11MhqZBF3NU9ejouKSmzzWQQqrMif/b1McELT4fwldBfCR9FoLO85BMkCXmtiK
 BIj5OoOMUkwTfF5UU946F5rY3QKQVNIC9vUQPy26XtcG9vpT1dNfb3wDuAbkVXjW6CDwOhNqLxR
 0ne0J+qYkvanEFkHz0BPDbaa/gttqfSOkpuiXgZHlNExLznCple2lgYlFZbiJtUSCY3VeuQ==
X-Received: by 2002:a05:7022:ea8a:b0:18d:5ef2:1644 with SMTP id
 a92af1059eb24-18d5f0159cdmr4029076c88.30.1792523347618; 
 Tue, 20 Oct 2026 12:09:07 -0700 (PDT)
X-Received: by 2002:a05:7022:ea8a:b0:18d:5ef2:1644 with SMTP id
 a92af1059eb24-18d5f0159cdmr4029049c88.30.1792523347113; 
 Tue, 20 Oct 2026 12:09:07 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903a275026sm751769c88.5.2026.10.20.12.09.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:09:06 -0700 (PDT)
Message-ID: <91fca115-c7ba-49a1-a902-89b319370259@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:09:05 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/27] target/mips: Remove unuseful EXCP_LAST definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-14-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-14-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfXwjsYENh1sPBS
 L4GBFxpgKWqRnFrthrCWuiW933TVAww6X/iB9QjLsA04jwQaO91PTROVvSxcGhyQyBgnYchOo7+
 EuxOoDNctm11l75DgTEOkhw4DdfVTjgA7drfK6duTp6nIckc8iP45prNusn7UgZjRilu1dmOWxp
 dq9snv3c+GBwpvOlh0ODNn/QT8SaLqfRdWUQ/nMI/bfknge8FJpm/j0uruDsfKzM34JgeOevxps
 ENiQk0dSsKPnA4CtWjm86JaUI6zmGvVm3tG2921xGRBcITHFv3IAJB+wkg4RsIAV4mB0BqKezyn
 CJxrU8RbnKkcVlemvupDf07Qv3scvp4qOcJYoDDo+GcuM6+rj9JzCJy1vSfcy4OarBlBFNnUqkS
 Lgz7zEZ19TUwCtsJmes1gn03oRHDHwxv7SRFxOxiRr/BhdkQyEVwjUt8y46fWGaJNj0/Akcadtp
 dyinSnHimd20cNVbVIw==
X-Proofpoint-ORIG-GUID: DmlxOOwUdssNGMr-tsLST_pqe5oBSplO
X-Proofpoint-GUID: DmlxOOwUdssNGMr-tsLST_pqe5oBSplO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfXw4ZOaRIquZ7L
 EqBX6s9n3S2pWQwReoWWmlCLEPjOtiqQ4mmlGg9Wnv9W1THIBYc2ePienpeV6dbTecQfoclQw7b
 cY0PNEZbIYq/osoPhXJq3Yn/Wm3NdlA=
X-Authority-Analysis: v=2.4 cv=NppE4MdJ c=1 sm=1 tr=0 ts=6ad7bc54 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=o0ODC3-X92SUVCDUmsUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200076
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

On 10/7/2026 2:45 AM, Philippe Mathieu-Daudé wrote:
> Check array boundary with ARRAY_SIZE() macro.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/mips/cpu.h           | 2 --
>  target/mips/tcg/exception.c | 4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

