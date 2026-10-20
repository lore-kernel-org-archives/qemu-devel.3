Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97BB606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BzE1fQIS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OhYB+xcM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFCs-0002r5-6d; Tue, 20 Oct 2026 15:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFCP-0002o8-MB
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:08:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFCO-0006EN-2f
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:08:37 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGtl91764316
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6CpdtXEMrThvoNHibICoCrzKlZVFU8dTPzHv6DrFB1A=; b=BzE1fQISc8tYKgYQ
 CW3D3XhdFKcnOoBS+E5x1Hy9tUbWorZpTLwwGCfYonizaGW87frRbbrTZjg27x/8
 axDD44AWn9zyxaZ1cLtNxN+N7PWcNBE3z35CRtILyEhGeVQJm2Tl7Hgo0nJ52wDt
 DH8rqFX1ANzzihHUQBCgGv7Os74z8UwsvDECvGOWAUPaj51gxhpoKTxQVh53vX+6
 tE4nwmCWIib64c8QbyeMiU7dKSb9rgN5dlLpj8ynZzhCZGx1qytf/LCxi6SKpife
 L0zbncYGXpMcl0dNRVlsO52asoMC1M7prdeaRgSCMO+mn89PMfUcwVICCLzcJ2YA
 Lvvntw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7hv9qge-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:08:34 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36696c9f55bso715588eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523314; x=1793128114; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6CpdtXEMrThvoNHibICoCrzKlZVFU8dTPzHv6DrFB1A=;
 b=OhYB+xcMn43YRw7Jlj5ny4y/qqa+XenLnu/jeHgkf219mvIBHdcEUOZAr7iqK+f0NE
 ZXh81d1zmVRMTEf42lXonNHVRZY4xzvZDb99DkYNqh5Btst/e0wzo9p82XfSKv0hGdTO
 +zFv4VA0fb5fI7oRN4l6g7VivIMgJhSYi+N+Ie5GgKOg3gsI1U2GlC4d8ywXUo8dKxe2
 Dr2J4gh15Dd4WJVS8exaPpiWHboqaS8GEFeKyKgthXfAucNbrt3Vs3RBS6no/vOdun0j
 pW8PMKbFHduqA3eyMnSOQ383WqmnjNjwa+eQtgwiTuIB+4FZnaMAGCCX8cix8aprBlDJ
 IsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523314; x=1793128114;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6CpdtXEMrThvoNHibICoCrzKlZVFU8dTPzHv6DrFB1A=;
 b=bsuseX8GqvXmacfU0dZDVaYyzXdO4VOOBHTKGJdv43CapsbNbtpfpoto+Gn1lTfucS
 uXUziEqBnRDY8iSf51PdOhVj3bU04cwzBK+bbTP4Ytkmiow5WlAJDCivwLPLMOd+nrwS
 mQD9htfQzYZwA9SVmrwEedLQx1gO7he7EI7mRoWS/pPonrOtZUSd040Kd+VNtNvctF/T
 OH7UZZ42/7S4/9zVLVD7Pjo0wa52NVYSU4d9j9O5kiWihRX0txX/dkwiFK3Bd6sACrzZ
 jA4x0E0xsZLes5SyrV77V8oKedDoJEs/IuWdG7keEjaD+LhElEelWTjBmqnke6BSzLyd
 935w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVH7KTDwv+wwKZl9SAJv5cgWwWT9yVVdcZ0LIObfQixe9PtWtF8mn/ZzmKbmGoghZld8PmOX+stIMc@nongnu.org
X-Gm-Message-State: AFq9FYLEI1+sSkePBIFNQ/hDzlNLcP38MltPuPIsxmcz2XG1dQNHJiHS
 WLsvSF1fxqt7HXkcUVk8e4xKNHTfQndhWf4AuFSUOpwdqWQpfGTCRORPX+tR7Kf7W1MNIWhpKXT
 ctkK4CwZ6Or8boV7LyH4U+9YPVdacDs0CAMjI8hyiHndczXFAi+wUEWaUjA==
X-Gm-Gg: AYBFou0oDZOQeJ0NcUPd439M/Pdu8inPMIkrqdYXRXI/j4zXMAjdwUIv0BVoJydcC5i
 dV0Y46AWxlFchpwRfRdui/7mYo1QzFimRKSKjf4uEn8Tgb7NiWzehR2Z7zmKycn/DBUDBJ04Feo
 gqoJNXFM4qwzRSpNEhKa/4YYd3EMrzSZ+HUmM6JpNgcF5Pf65/fHYtxvsOpJeu1JLJefWeY0Kwt
 5Fh/71aJ+KwtUMI65SB4aZ7EmWCyrNPRHt8Oe+2jpC4rg4gHbxAs+pPCshjXUMZfpRIIGUG6Qe0
 P4oIL95bWIeLerjl7sW/rI7uhCjWZAfu24BUW1Rt86RREl/gSuEZDzfqvAMHIK9YqSTa89lugL2
 2Fnv6GG//iLSY4N7uc2bxSiloMJZ+kcbV1Zy0OIU3XjP1H61jaC/eMtWQDH2kP/eguLBTCg==
X-Received: by 2002:a05:7300:e7a4:b0:353:5d7a:cabe with SMTP id
 5a478bee46e88-365fad8dd2dmr5724690eec.13.1792523313775; 
 Tue, 20 Oct 2026 12:08:33 -0700 (PDT)
X-Received: by 2002:a05:7300:e7a4:b0:353:5d7a:cabe with SMTP id
 5a478bee46e88-365fad8dd2dmr5724647eec.13.1792523313198; 
 Tue, 20 Oct 2026 12:08:33 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ed295sm604772eec.9.2026.10.20.12.08.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:08:32 -0700 (PDT)
Message-ID: <064eb6ca-5441-45ea-811d-4a74a11bd583@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:08:31 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/27] target/m68k: Register CPUClass::exception_name()
 handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-12-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-12-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfXyn3Tc6B9M1Ii
 k9243kuvwaxmLPe0xPnb8QXm+0v1mTrUl+Ws5tW3flzRN/Y52MtTwAclOSUcBLt87+S6iakTC1A
 GYOC9xEltG6guMWgFQiHIvkXrWFUcWCeViuKPC2Zq/KBd1mB2NQrSQOtAGnbM/svCvBHCB+2EeH
 rMs36GgfzT0wh94P/t7hVDwPaBv6LeIqUctj0+UmwHNo3V6ebA8w3G/NdciS0ONRwEedcgOPEUy
 gdCUZ2gofu1blFmMxdrQ8NQYG7TqriMwAi+7foqhrGZrEB3yEsZa620iDAMf0HsoVEkX0QHgkd0
 DNvUfl7h359URpWcdU+pXR1To4Er6IDYRNCqhrL0gX5fyrIxciuw6PfmJxTi5LvsiNQX+1nE8vh
 gcQzcaV6RIWnQdlVhN7eZq/eMalGjXX7voVcy5CvMontqE4OqkpBzdnbh9DpxDyyrPrzkHeWrIe
 V7yRlZUbK24NV7gKzBw==
X-Proofpoint-ORIG-GUID: HKDAq3juGf_U13q6VGbMGnJ5RzaP8AH1
X-Proofpoint-GUID: HKDAq3juGf_U13q6VGbMGnJ5RzaP8AH1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX20NVpZUnQWw0
 KWHeaZgW/qhWYuYnqZDuYTLaZ8AWYOaka0sDkXSjzH7qsw3LMOC41N9uvECU5uQPQdf8vsA+61R
 R5x8pe+2KFyc06dnVZ0fZHLYB2W2S+I=
X-Authority-Analysis: v=2.4 cv=NppE4MdJ c=1 sm=1 tr=0 ts=6ad7bc32 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=DG-MmU-WljwgTTUveXQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
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

On 10/7/2026 2:44 AM, Philippe Mathieu-Daudé wrote:
> Expose m68k_exception_name() prototype and register it
> as the CPUClass::exception_name() handler, so the common
> exception logging can resolve M68k exception codes to names.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/m68k/cpu.h       | 2 ++
>  target/m68k/cpu.c       | 1 +
>  target/m68k/op_helper.c | 8 ++++++--
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

