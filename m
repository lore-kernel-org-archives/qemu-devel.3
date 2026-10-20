Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF8E606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=maA+Hejm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SMo+jCtI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFDh-0004Df-9j; Tue, 20 Oct 2026 15:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFDf-0004Ap-FC
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:09:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFDd-0006ON-NA
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:09:55 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI7lBg3499185
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MMArQjBhvzvQAX0pW010qgMdiBC9+op1ou5UB8/h3aw=; b=maA+HejmKnuRLcDr
 TocwoReaLgBpFpFl+FWabs/RPMRYfn1E9f1pnDjWM4iBuphqg4uPasml/sCEpoFx
 jOmu/1geCiOFpeESEf5XySO8MljRo7sMhspVc7uBH0JuvbXnBtxALDyv1Me3N722
 gmfeHqBp6woG+L2cqNZJr8Zh6qM6wRb6tWuxEttA8Pouyyp2GLN0yX44LnoQTOKc
 44gn0fBGz4YaW9N3PrRJg0LMu6jMH2DVZZzO1V/L8fgU5klp+4gp7uzaaL5nt7Ol
 EPqI5MaEX8LUigdG45p+3riq2A4A3xfV8L4St3X7P+EFd6KukpTVjYdj03w8C8Nw
 IZljHQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabg7f8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:09:52 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so6195645eec.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523392; x=1793128192; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MMArQjBhvzvQAX0pW010qgMdiBC9+op1ou5UB8/h3aw=;
 b=SMo+jCtIOmA1UDo9CNqqbDIPzy4RUtvKaLrFjt4+C+TnKdneiE/J9nlpHC+NFebsW9
 hmWk0+SCGrHRK6uBXQoFnL2fG8EtUSFefWg9Rxjz+pJq6/G+dorIO3/tFiQTFoimdove
 D8i0z6ic/LIJMl9Tho2YUBOLmAXJrRat994sHG5Ftpvy3VKA7WqI21tgDzyxgA6lWJKa
 wHhv0AGq+f0zhA+rEXPCAmAidin4L6Ko6/F4Ilq+1WYWuFN/h5p30g+vHn3n02OOvFfc
 x6R9AnclYX6MezIGluKKJ1euZEAbNNi7B0Rth/BxSoJJBJSHMoCRwyeDUG26XFuOGDdk
 bnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523392; x=1793128192;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MMArQjBhvzvQAX0pW010qgMdiBC9+op1ou5UB8/h3aw=;
 b=dyn9cIgltvmXgCGaK6fJYXLyBKigIaEe1JtZhdgZKxx/LmQ3Vq8SqIBG5/3k8m8tSA
 FMOoGbD/x/SxLpPrqgKQiw9fJTEyrbWeInfUFbb5WOdkTxLJ3UBqanO9bxTCQd6HTrCb
 9Vijn/JgaXJjqoUhYurPu0Lrf1uXVYbymXoSguU7axfr3FR7KNLud2+q/Via+LGojpac
 B+fRr2CsoKA3KeLX21aGuc2XAkwiStDfLgQ6DPT7f/jmWDIGLyip5rtDNJkXxALWnTm8
 ftWx6jSuYmCrni4317AROnSm1Rv8YwrBjqkgWVETY4tRCMDoaIMgItkkWeor/vPviIiO
 e3qQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxC3EZBcR9sHVOQA839/HBlv0qiroRAlYLJbapZikcBqF9rz3A9uGiK8bOAJxL3+t7j0FHJt2swWA55@nongnu.org
X-Gm-Message-State: AFq9FYKdhKveF3xE5iTVZlms/1kpsm7l5JUP4R1xblVH/6Jsr1XFxB2M
 Ounzch6mNVrGard5JGliyRQ2GV964RHIqXtAyTZYxj4FgmehDjYjuDYtlm4DlOp0XYKHtTM00lC
 SOeprp8DwnILmHQCNs3IhE160LpBr0npzhSfQy74FJP+TlOBPQBZszPLsuw==
X-Gm-Gg: AYBFou1M0Jyg6oM8+fwdS5c9MJr/iNjuIHXqTkgfhC2lrP5Fo49zp76gsEtdUgRRQWQ
 cNhFYK0HnisHjvwDVjz+JboG1T008h/XId9OREXFnYX6HzBhjs/MKQ4YMIUZm8Pl6JJ4RLtAGjP
 4nIDtk8ipja6/6njO2woSaqEWZhBfKEvP6SkxkxnClz+RwYqaLVK2Cudek6UtaccqZ0u/ziqsyl
 EQstnCOR39o+8Plr2WMgokH3d/VFoRTjdSOYVKC33N/jgOg6jWPOip67IP/JR72UwAXBog/hzG6
 zpkkhcMKJgLXytv4TummXcwfOYBop09oAONqvP21TTzgZuZf6mJoNRkC4qTuVHLn3uyCsACWnbl
 5k4rldUy7ViEt/ULUcN51vza2EcV61ytO7pi8MFOz+hA4BCc0U/0l3gowDxSgsQ+C0iRZqw==
X-Received: by 2002:a05:7301:144a:b0:35d:363b:c115 with SMTP id
 5a478bee46e88-3674db4c591mr195155eec.30.1792523391544; 
 Tue, 20 Oct 2026 12:09:51 -0700 (PDT)
X-Received: by 2002:a05:7301:144a:b0:35d:363b:c115 with SMTP id
 5a478bee46e88-3674db4c591mr195140eec.30.1792523390996; 
 Tue, 20 Oct 2026 12:09:50 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3674206e08esm469631eec.29.2026.10.20.12.09.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:09:49 -0700 (PDT)
Message-ID: <a2b0f82e-72a3-413b-b717-e0662b54fe82@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:09:48 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/27] target/or1k: Register CPUClass::exception_name()
 handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Stafford Horne <shorne@gmail.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-16-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-16-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX/UAih3QazSHh
 F1OILx9AZ3aSrlC8P8AOYqsCweKGIs6/P6OIS25NHSd4l/E9lPu2VOW+9ajkPW9F5LiOxgBZFVd
 6w3DpY1GZ4w9MlkTqHa7YW45krc4UFE=
X-Proofpoint-ORIG-GUID: b6OQ_nJgLNTD5vLexDRJbs_LFfV9EyJR
X-Proofpoint-GUID: b6OQ_nJgLNTD5vLexDRJbs_LFfV9EyJR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfXyOc276suEl9d
 6KTK999Ks5CdwtFLkQUAZLTWDM/yLPpn6cV8xG5jpa8wPk0PE8B9fBXl3KxK+jXNyBX8vWr5oNf
 vfx27GCAEdvVl7lUNirg2bZnAxyzWpgAdIkwtOSWSWk28wF4n0xpN81++T7iSi5knc9ffGj4GFO
 hOcE0DyFu8xlBHAjDdejUWgWIvN9RDHRKQ4aLlQwWBHx1tJ3EYhembhXoxUg8QjI/lNrYYPkzS7
 KZw+HJyK8JwR9ZmDgbTnf1h0QbifBY0kKhr/1he+lcig6Lvdu05yo9mk8b9Ks5VZtq5Qj5OIcy+
 +mPAd3n3bFn3jwmOAGhh9BsHujj8tocCU2NWj/Ra0LkUMxlaos6UpJfm9t/M2g9ctUB9tKorPJk
 3zlFscye+fCdtPY6wqGXMNWUGDzGxtJCHHyGyw7mepyIOUbib5AhgY/zQYOL8FzxR2QqYRW5cFM
 CjCRxTZ6/UylYqDEQUg==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad7bc80 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=2Xjb7_H0Pm7iUzIoXRMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200076
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
> Factor openrisc_excp_name() out of openrisc_cpu_do_interrupt()
> and register it as the CPUClass::exception_name() handler, so
> the common exception logging can resolve OpenRISC exception
> codes to names.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/or1k/cpu.h       |  2 ++
>  target/or1k/cpu.c       |  1 +
>  target/or1k/exception.c | 24 ++++++++++++++++++++++++
>  target/or1k/interrupt.c | 19 +------------------
>  4 files changed, 28 insertions(+), 18 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

