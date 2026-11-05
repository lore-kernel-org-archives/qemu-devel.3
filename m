Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED411606A335
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pr40bPWj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P73cXC/u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOseN-0003bW-WC; Thu, 05 Nov 2026 03:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xOse8-0003aF-9G
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:16:38 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xOse6-0007nc-3u
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:16:31 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56ULuY1018101
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 08:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L5CYWS+NbxiemEtQv75+52bbpvTURJZfZRF82lC7GUQ=; b=Pr40bPWjHSCANoIw
 5UQORPqXULqymOdM/vE3lq7MOle/hEYsQs5XJQbjZ4bTN1nUI5iXsIbJeA5i3j8U
 VJfoKjjyRLgyUJ1I27Q+sypP/lnSWHpuc6rRGnDor+nQov3xhLDAdR+SUHr20fN+
 7NE4WCgccJhT8SvgPseuo6NDKmKH3cktb1tIeDRtBL3zpZBTZqVA3u90PDqKkiZR
 RyGwEeKo3ZNVQWR3bpilr4iOVjp9uLrbZIRjCiW+aFCcaGVCPEJ5Ffpf6gPNk/Om
 bRoFiivuKr99kpsxmfvzDLjc0+iAiDAnf1oJ0a+1ytnJ1fqwFqN1eYpmRBjVUUDr
 vyRfxw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bnm0b3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 08:16:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36d69ab3c2bso1584774eec.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793866578; x=1794471378; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L5CYWS+NbxiemEtQv75+52bbpvTURJZfZRF82lC7GUQ=;
 b=P73cXC/u+nm+uHw5RU0jy8LJMN4906Sh6bYFUcDW9r9XSUDd0zY11aVTx3tLyIfh6P
 RTbuk18KKT8enyTFbgpYkDtDP9OoC9nramqkFMAmYuJkyPnjrtMx/EjhEc+04seIIcru
 /h+j9V54cFnDKGaQadkgAkgNn4Z/ShNVD1g+UDa0WKPjCEn9xvkk+Z5gaGo7pDEeLANH
 CEtiVcReznYC5lTksqjv+zFXoSHzgpkVdq0P9AxQCNJOjTvbnactdZH+BtxZtd14RNr1
 3nmP/WKWs29DahmDgjO0tdeMSEe8LUGLAUGGQDW+MuxjQJt9m74QCye5N1ckt8rdxqBu
 ycjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793866578; x=1794471378;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L5CYWS+NbxiemEtQv75+52bbpvTURJZfZRF82lC7GUQ=;
 b=rSQku84dKNxluGxQ/+UNlfCXWFDKGfvCi3g7SiFArymwUE9Qhx9fYI8im7iHwAFi5u
 faDmyb0BYVCSh3uF7AzJkaO//6d3u56IJiNmtsE1gWhdbxY/T1T5wZl3PypICTqDRSj6
 JFqtQSMEFvr/KNegenSXPd/FgH4Jlq7YwgLe+LFdQZgSfa9hqTnimmSTokcDIjkq0fT7
 Xt79SVd572D/WKK1qAXYF5t6CEFOoJ28yGBV+J60kgKldSkH3CJtIbvw91FeiQ2wQ9/L
 pXvyTQTACN2WUQRRtQ9329raRP00cKM/YuIDI9TucsYEj8mTQi6cG1ffzWpvcX6Z89Sf
 24QA==
X-Forwarded-Encrypted: i=1;
 AKwUvByMS1BAWbK/zT2zg8DUCmBCu411D/io+Y437SAfv0waDHyuW6xtk5QNQ816Hcre3jGLEKsc2ej7g75q@nongnu.org
X-Gm-Message-State: APuU4Z/l6GM6FfOEd7ZLDfPF983Fj6cKxjWCxP/jeZPHoRaPS2i+z0Vb
 27AeudourysVMwEfavL4hILu/4aYv0EHYT8tzhZVYCXAU7lSwmiHMRlKB9SrJ9o42x/2cbaEdMm
 sGoCw3wyKZ9kGcJ3XLDtOlBXy3f4ULj1g0ScJdMj0s7mKPHXnBDgWp4eqqg==
X-Gm-Gg: AYBFou37EywojRzPQgdIKeObVLlaOxOMOc+SaGbxMsp0NyaFLo30f3/39qhYra2wm+0
 WNSSoOM01ne7U8AHIA8kERpmO3ez5zgubpaimb3sE44760h+IErm2sq+SSACYAx32mv4V6KYo1s
 qpLhQiKvtri3VD5BSy7sxUs+nUVWygcWX6AZ8Det1eWyXL3vJ/Aa7O3b4R1VABBB19WefO4sfmK
 n1Bx0WgSThOPqD2KcEMKoUvg6acD03dECuoHz7r9ckupYzX2nEj+xZ47sn5JHMYyDMOIdbfPZca
 FOz/OG2tQxwsNFsFYQKQMMQlcO36nqFWNLXeSLXuFVhbYhcpbp2Lqqh7TV2wk+6hghSZNDll+p0
 bPRh3H3z/mrDw+xIYvmIyDY10uUhU5c2YOaWoe52n/vwSym9K0aBVetTmb/5NllSkkUmW0jj9SD
 CUlmpUWLkG89v7qpKPof9UbOSGlWhRa4owKXBC3KBQNw==
X-Received: by 2002:a05:693c:65c6:b0:36c:a44c:1763 with SMTP id
 5a478bee46e88-36ca44c1938mr6722299eec.32.1793866577693; 
 Thu, 05 Nov 2026 00:16:17 -0800 (PST)
X-Received: by 2002:a05:693c:65c6:b0:36c:a44c:1763 with SMTP id
 5a478bee46e88-36ca44c1938mr6722270eec.32.1793866577077; 
 Thu, 05 Nov 2026 00:16:17 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38a6d3dsm17327960eec.7.2026.11.05.00.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 00:16:16 -0800 (PST)
Message-ID: <66a0a4e7-3e3c-462f-9a1e-bed93e9bc3bd@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 00:16:14 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel/testing: iotests check script should be run
 via 'run'
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261103110805.2010679-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261103110805.2010679-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX7vv1xRn8GaGf
 o6KzfFWkDpBBWGgRt2ixLBaONXK22Dnigc61Cee7SnvzmGiAMkarn9AZ0/LVqLMnUXRIePYROET
 kk9FB54xNIKqA3YAEtNtgx08/QbG2zvrHyEXCfjnhZ4SSniG9AEb8BkHZ8om6dZgKDM6MLi1P3t
 VkIGjRUbz9mnAZkGeCQ4mu6WrY3nOSMOwyEv4IgGlkWOZEfWVYfyogr8Z5kFiGT4+ss20GbgN42
 1s94RkRGHUcukuyejR6YNL4fs8UbrcaTAWN+VGnqqIu8uehD01x9oeeC/DopSWTpb7oaPZEAh5b
 K5dJcGJTXUqT2Cc5ejp3eUzGgoHqLP+Dfg9vtp7wbidBifV0YuL/mTWvhX+d50EXzvvC8etOKHt
 MZyogRKfKyUbPJHEA2CrX1oaMpQtmbEey1ysmBxBaD8p+LOhFwsmnQg2zA7ivi1rw9EKuRibbKv
 sOlrAy3rRcymVgJu3Qg==
X-Authority-Analysis: v=2.4 cv=KLLPn1Fo c=1 sm=1 tr=0 ts=6aec3b52 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=XJM29XU31OyHbsU3JpoA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: CfWq0cZTpv3HaP18vD03IAPDKcxfsaeL
X-Proofpoint-GUID: CfWq0cZTpv3HaP18vD03IAPDKcxfsaeL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfXwC676Y3/fofi
 CJ9UAAMMfAnM5yaM+zGfaPsaZFUxVzNeb7qorIf4AHYDe2CzBAZLDsz5zNoAqKcdl2998Cu/UIY
 p0NxzTDkDWQKX/VHH2ICIkthoGDwn9Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050032
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

On 11/3/2026 3:08 AM, Peter Maydell wrote:
> The iotests section of the testing documentation suggests directly
> running the "./check" script.  However if you do this then the
> script complains:
> 
> WARNING: iotests is being run from outside of the configure-time python virtual environment
> [...]
> Please use the meson run script:
>         /home/pm215/qemu/build/x86-tgt-san-dbg/run ./check
>

A bit a side question,

Does it bring anything useful compared to:
./build/run meson test <this_test or suite>?
If not, maybe we can remove all this, including the extra doc.

We can also add test suites if that's the missing piece to run a
specific group of tests.

> Update the documentation to match this.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/devel/testing/main.rst | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> index b0ca37fe2ba..e26b8af0c79 100644
> --- a/docs/devel/testing/main.rst
> +++ b/docs/devel/testing/main.rst
> @@ -272,8 +272,12 @@ scripts.  The testing success criteria is golden output comparison, and the
>  test files are named with numbers.
>  
>  To run iotests, make sure QEMU is built successfully, then switch to the
> -``tests/qemu-iotests`` directory under the build directory, and run ``./check``
> -with desired arguments from there.
> +``tests/qemu-iotests`` directory under the build directory, and run
> +the ``check`` script via the ``run`` wrapper which sets up the environment:
> +
> +.. code::
> +
> +   ../../run ./check [args]
>  
>  By default, "raw" format and "file" protocol is used; all tests will be
>  executed, except the unsupported ones. You can override the format and protocol
> @@ -282,16 +286,16 @@ with arguments:
>  .. code::
>  
>    # test with qcow2 format
> -  ./check -qcow2
> +  ../../run ./check -qcow2
>    # or test a different protocol
> -  ./check -nbd
> +  ../../run ./check -nbd
>  
>  It's also possible to list test numbers explicitly:
>  
>  .. code::
>  
>    # run selected cases with qcow2 format
> -  ./check -qcow2 001 030 153
> +  ../../run ./check -qcow2 001 030 153
>  
>  Cache mode can be selected with the "-c" option, which may help reveal bugs
>  that are specific to certain cache mode.


