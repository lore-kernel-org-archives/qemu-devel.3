Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED92ACA5FD9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCJno-0005Cz-UW; Thu, 01 Oct 2026 12:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCJnm-0005CW-O4
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:38:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCJnl-000216-6a
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:38:34 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691Fsmok3109369
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 16:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YnLmvSxuwai6LqW8PYoGV1+G6wneHuvYaC3YyNpsSMY=; b=njxonF4MWNCShQfW
 xscTrIh+O0NhCEQgtHyN/IiIb5HyHoigtH1JvNYEJrlcHgb71RGaq7sv0ZDRtzcL
 /FAGDf4nseyX6l0q1QsDFtAK9Uq2K3TjvWjzpRvTDK4MHo+5DKjCBf39ewfKU/js
 9j1L5icd9A2WLwRuq503oqsqks9VdEuVyu8kRU3C6jUs1VR4+yEQj+IXmWovP4EI
 aFgmurbxT4HfCcRGoVlRyOK1cuB+shC85s/BF8uGR9sMhTVa4dIrUQYtGNxXSPbS
 X/RaDDCFsKlPRAcZkTc10c0nkKUWSSMzWWvolqfRShYUy9myKFmxNQmMgw1/3HVF
 vJcvtw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1jcftmjt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 16:38:31 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33baaba6371so6657249eec.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 09:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790872711; x=1791477511; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YnLmvSxuwai6LqW8PYoGV1+G6wneHuvYaC3YyNpsSMY=;
 b=OmPc/3kky63z7lFsmiLXN7DPgjPqRrS2C+8WpNtEcPR5KYthreWVZ0VXsRZTDRdVZL
 xhFGb6/cJLYS6xCxzm0B3etYdnuKr9zAIurjJEDPUPJeQbO2QuEbGQBEw1gSiPsutOwn
 SW2y/59sPSujlB5c2wM4Z+WaZpMI61JvswgvrwoL/FjelnV2rkqzOaR6uf9yurawkmET
 Fm753o/KfLwRqIodV4QwAQGraTspE3dX3PSlNbHh6UKnAxMRGlyRHNLHxJ+Yv9GhaauJ
 Z3VMkrNVwG3f5LfAtniS+9ElquJ9/tmOvIeSU+VpvJpm03bJdyc0cbHwybbuLMtk5YLL
 GjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790872711; x=1791477511;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YnLmvSxuwai6LqW8PYoGV1+G6wneHuvYaC3YyNpsSMY=;
 b=A0zOcUZ/0v6TnJeX8p6XlYhscrRakZAsDxUdfCu6ap+xAev8PgU5raCH+vD+BP1A4h
 r5P2lDh3o+q6WEUbjkNECIZQ0oupBRHWcf7fLAkiCsRkujYrs2aU6PKjQbySkCRblCjP
 CIAFHhT6fkYpYJLZQU4c+0f2yyLJTL4p6xi90AZgdBtbAuxXvuFyG0gUaRpekTPGWpLe
 iBecOgIWvb1nKHHTA3ME+a8cZjnYN3r+IUUXEr3gFdruJB1E480FJuKg7eoTRA3irmVV
 OK9qnh/oWXCczOliEsIAlRaOi+RgUJeek1u7cXYEuMM1bxwtHR8m0abUPytjkQKL0t5w
 9FhQ==
X-Gm-Message-State: AFq9FYJ2btom5DL10ZqzSA7spcb7bDKKLanUAgvk74GwE/FFuqNcy6Mw
 lW7+BqceWG3QQkuELAKrBDqlt5H8N6HSGdwuK5BSlZibzgdBaMuBS6e1xBqLNqnLQ9OA+ii4zjO
 G+Fun70Y3GnNVfippb7bynFnrGtaqzLCC+5uPzLgh4d3a/wClT9QEQrkUmPZ2Rmj6Yg==
X-Gm-Gg: AYBFou2OgTBxjy6ZHOmCpltttLVOEu4/ooD2nnRq0FsMSg6drv7J0IJ5HMFOT+KXmZr
 VOtMCWSl/+2ACBc/mUqJwnBgOdS+VxWvF4e1Z+hmCV8UWnQYG5FHW1Gx8dleu25QvjyzQ+DFJmq
 nUAC89jB67bU+XFAK5BDlmgkXI55P+b/AI1xitcozavEVOlkByI8qU4Wdn3Y5bBGBzNHeRLy467
 EQbtgvr0a+oZwKIQbfIK6GNhTNWWfktkqGi1nQpZIXgfwo2XJaQQOxHcp64z/DDlMEcftxB/zkz
 IG+ZBQd/CusMEHtTOtj8w+bwXJKwqfm8KEJye+83BRTpUNmjCKva5BXpijcGjUcTLFez+h/ibvA
 xBdzxr5FWU5TDCNoh80z4i5jzdj0nvA9dZFoA4n0SJ2bBx+mzgESqXMz6mHKWZ+iOcthasA==
X-Received: by 2002:a05:7301:420c:b0:34d:9c6f:8af2 with SMTP id
 5a478bee46e88-34d9c6f8d0bmr3645903eec.40.1790872710789; 
 Thu, 01 Oct 2026 09:38:30 -0700 (PDT)
X-Received: by 2002:a05:7301:420c:b0:34d:9c6f:8af2 with SMTP id
 5a478bee46e88-34d9c6f8d0bmr3645692eec.40.1790872706067; 
 Thu, 01 Oct 2026 09:38:26 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34ef8de866dsm48234eec.9.2026.10.01.09.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 09:38:25 -0700 (PDT)
Message-ID: <e1213bc8-dfef-4e3e-b2a7-2bbc8a651716@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 09:38:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tests/tcg/i386: Build test-i386-opt-shr
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, Dominic P
 <gcc@gcc.dp11.uk>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261001163751.172720-1-pierrick.bouvier@oss.qualcomm.com>
 <20261001163751.172720-3-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001163751.172720-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2NiBTYWx0ZWRfX5wf2hCd6nAPS
 5CcrXpB8g45dkBut+Evjp/UmyN8YVvgMZej/8WddDqWVBbOiq+PQ14ds0Y4AUdExtTTnRX/ooEw
 dyhTpr8s/A/L3qNYMDi1iGene/eNE/o=
X-Proofpoint-GUID: D1RAxB4Ti6TD2tSaZKJoVTfbUbFpDNUI
X-Authority-Analysis: v=2.4 cv=b4YncdGx c=1 sm=1 tr=0 ts=6abe8c87 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=yuWYNVxf1J2BtR792vMA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: D1RAxB4Ti6TD2tSaZKJoVTfbUbFpDNUI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2NiBTYWx0ZWRfX6Tem64OzMVXA
 ATZjLvjKTs6uxyVqTt2KaKPh/IphO7A82B0cZsHm7ymDatRlLBUR7yABwmUiTFFk+Hk9341EsA0
 sKrs6oBxcejkvtykCBt4yJxSwmwykJWWXu7Fm72q/9JpEM2+WbgKYERb9zFQIVoqYEqjbxfbTiH
 S3V7gPe0CQNemAlBXSVzGcAOIG/eR08G1UxGmuZcID9knAk/VUVLksqaUSIZEtMkfjktZZezOeG
 edldD4wVI19JWFB23vuC/1bGU2GllZgbS1niFhEOFoFi7fxu2F6vfB/ZIpgcNDZgaHMewGk/cDo
 NN1jFxd3FFrA5bBDFgAOEPBBAD1P1+YsdEeDnq3u9YWcbZnci9wrbAYkGs6jzqSjxFTjRb6UzIb
 41YfdtTuXI5q6Y5arOemwESh6WzhzqMijYb4sVZ7ZFb0p4n6F6erV0qr9ciIg260n+I9Lc6myEX
 lsiy2bPQ4N6LITL+wAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010066
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/1/2026 9:37 AM, Pierrick Bouvier wrote:
> From: Dominic P <gcc@gcc.dp11.uk>
> 
> The old Makefile.target built every tests/tcg/i386/*.c.  The meson
> conversion lists the tests explicitly and missed test-i386-opt-shr.c,
> which 5fe51606146 had added in the meantime, so it is no longer built.
> 
> Fixes: b4e3e90d61 ("tests/tcg/i386: user tests")
> Signed-off-by: Dominic P <gcc@gcc.dp11.uk>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/tcg/i386/meson.build | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

