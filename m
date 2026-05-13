Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE9ACD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 15:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNBxK-0007Zf-4s; Wed, 13 May 2026 11:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNBxD-0007Yp-Fr
 for qemu-devel@nongnu.org; Wed, 13 May 2026 11:57:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNBxA-0004Oq-St
 for qemu-devel@nongnu.org; Wed, 13 May 2026 11:56:58 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64D9jiHi3007657
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 15:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PDt1sljeK8Nly/YoXu1Ze3O2j8BUKFnTDWYR6etGZH0=; b=doQoNDliSJMo0Io6
 QHv0OGEAn4iK87JsnK7SBOd1qD96xQ77AIWvdKGuakNYvZKCTCneo5TGE8Pi3D7R
 oRoIC0R/TbnSRdmuHbRh1pZXV0H9llN7yaCjPvViDZEwuMcGdS20a5aklujOgx9I
 eBQSTSe2/lNCaLRnJlOO8nAVbviHBAzmYTlVWYR6Bh4eN7si12eDV6aF22f9t/Xk
 f6bo/7EZZIDEBs+nYTUanjyJfX/yXC5/gD7reCZV2RqcO7Tqb5YD50UnEiX2fbJx
 V63wkS5YhKc1o804bF1s0420chzgRbVKzS21K7dmh3PuJLuIB675gv2q53i2BgT5
 DfJ6zQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4py0hdft-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 15:56:54 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30230e64087so321907eec.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778687813; x=1779292613; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PDt1sljeK8Nly/YoXu1Ze3O2j8BUKFnTDWYR6etGZH0=;
 b=duoWMxCRpy51iAHnT5N/iARAJcQGp4EI8l1Pm2ClU788YmjNCTWRdpDXuNzPGxP2IL
 4ScK+UWU6ac3ZeUlDdeow7PmzR3ra9+RP61kbzVvfhu8f9hz8BSL4WrvvSq7OSElFkUk
 lfsNZWlNSS1eZho9h+fLdXdbVD6x8502oZLz9pyV/QJ/2UQQG3zx5oJMq8zxIt/HFVE5
 rwhFgnlwpvWRlpbJx5HKt6QUqCJssTi/cJOe1VvLJGNDeSmkF+Z/nVW2vZP1inNh0AiO
 ix1Yjh2Zg0E72om4YhGikA3DMbP5X+X0Tk2Fqgc3lSmGbFm6ZP+xryalVtmnmeug5Zx7
 wLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778687813; x=1779292613;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PDt1sljeK8Nly/YoXu1Ze3O2j8BUKFnTDWYR6etGZH0=;
 b=Qtfjl+r0/k8tK9KffB6bJLTBxjqHkzOSWYPu98fkz5zpS/wGVDWBnDhjA9zdpoOavh
 1TKIORZ4tojGEB/AlPdJjDslsC/EDSEwy+NkJUYlGc6fHjFUU0dyLkhlQCuM1tPbWbvT
 w/yixAGB4p28F0/05F1mw6Za065y1j06r/wvS/iGTB1wBTt15xMnAP1+mTf/wZPX6Ysz
 t4Rj5KhEJIj1FyhDjGLqfQ0dasTWsrPs56+jQvreFYmTiCcNqGN8+1eUBx735l5hPMn1
 xCJN5WlDIfb8QMESJgaZIBiml/NkdsQVi69BQ5i93riMhgXkICN9p1yU5GVAtaSAIm7o
 2l/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Rm3pa6hBnp3ZqJteDGOHMvYTtiDEWc2U1QxATsEXcQynpYuQQVIaSxmWFwbp2dmdAvr4yEoJ9Tf/H@nongnu.org
X-Gm-Message-State: AOJu0YyFjKusZS070j+/TslWiRJB7V+sue8kIYHU6nxxRpZw4KEVRvLY
 EQkPcGIu1dymf3rphttknaIIJqlVPtdwx0LchPKI8JNbGDsyjOzevOAwj+GJt2mnTXa3nnLKS6Y
 Q3BNTS2HrrJOPwHk+G5F7lVAg81RI4LT8wWFLk5hsk4TMhvBC6NPnf2YNgw==
X-Gm-Gg: Acq92OHebketAWPKJFzEmCamX2r8sKb6cBMk/TfY6LlhuTrl0j1/A/VADDTLv6356qU
 V8QRZs0YqHh4lD62sLWlEvv/GAu2lyHFtrY/MwygFITt5yYciIQRSIePzrmDFbFWB6JK3nicNRk
 mYvzPj7OEUgdyI5h9b/2YTbcOoCGpsMfQjXjtp1nYrfYjL3mHoZMVn144dDME+qfRet/MZxBJus
 FF0bot4hi60FLwSLrFWoFNzFMk63SxE8ufdRpAa0ZdptA5L8szlugmsSKWnsiNUmYQGWThTZgrT
 3F5y9euBeHj/4jWmmjdmXj0Bz0ubMkAR5wVunTG9obgCRZDLKlzHrjYrotzEYMckbeX1vOKESPm
 D2rT+JkPfbNX2sWC5IMSOqC6A3qSp+yoKyviaesFdroasZe9oGR6if5ieAtMBiJfCGmeDpwIPLN
 p/CBC7mv/zec84dw==
X-Received: by 2002:a05:7301:5807:b0:2d2:129a:1694 with SMTP id
 5a478bee46e88-301556537d9mr1829271eec.18.1778687813248; 
 Wed, 13 May 2026 08:56:53 -0700 (PDT)
X-Received: by 2002:a05:7301:5807:b0:2d2:129a:1694 with SMTP id
 5a478bee46e88-301556537d9mr1829251eec.18.1778687812690; 
 Wed, 13 May 2026 08:56:52 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f88885b87dsm27511644eec.21.2026.05.13.08.56.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 08:56:52 -0700 (PDT)
Message-ID: <d6617060-9d96-4a8a-b0f8-f23532e286c7@oss.qualcomm.com>
Date: Wed, 13 May 2026 08:56:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/16] tests: validate dmsetup result in test 128
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20260513120003.226790-1-berrange@redhat.com>
 <20260513120003.226790-13-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260513120003.226790-13-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2MiBTYWx0ZWRfX8Kix2qvaEGbu
 mByvZYa9cYkRupR9hyf/3Ru8R9z2D8cFHuc2R/dM9oNkerou3BZycfYeqfjtbdUpJFmrgtZJlS6
 yNqwU3qFEEctBnIzRT0mYLjaRzzZOEV7dTsR9mHj0S9ex9PgwmQqxxeJSIi+Q9gR9DwqG/iL/Ko
 kImYHi0gGSAJuZFNCAIiRBNjDfXMkRjaoZqYlIiHosMCqjAYdtJWIQrL7H3eWLedNYt0YHZ/vlj
 yiVf6ZjKOA7G6FyL3/hy9prW5K0yXy+eG2INHZ7fys/Jmobn8pErinUsG1y9c+255gnt7elCztQ
 aF79mVQsSFqleM1kS5SM4C908PKUCzVaHOsAOgCtVpVzojM39LtH/HuDvjCWCm5vwyAKYJRsXhj
 tvGC1eFOYCq0jbQMhSvV01HqG35XgEQSPDseRItq0HkTS6iNdINAm4YQ/9FodhLpYWpaMRTkViT
 jp/OqrvyK0Jb2U9dtpQ==
X-Authority-Analysis: v=2.4 cv=XqXK/1F9 c=1 sm=1 tr=0 ts=6a049f46 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=SQPxrGs833apBfTXCeIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: GUerkqvgDJ3Ys77WC2hgYFQRG8QismhR
X-Proofpoint-GUID: GUerkqvgDJ3Ys77WC2hgYFQRG8QismhR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130162
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

On 5/13/2026 4:59 AM, Daniel P. Berrangé wrote:
> The I/O test 128 uses 'dmsetup create' to create a device, optionally
> using sudo to elevate privileges.
> 
> This dmsetup command works in GitLab CI, however, the test then fails
> with a missing device name:
> 
>   1..1
>   # running raw 128
>   not ok raw 128
>   ----------------------------------- stderr -----------------------------------
>   --- /builds/berrange/qemu/tests/qemu-iotests/128.out
>   +++ /builds/berrange/qemu/build/scratch/raw-file-128/128.out.bad
>   @@ -1,5 +1,5 @@
>    QA output created by 128
> 
>    == reading from error device ==
>   -read failed: Input/output error
>   +qemu-io: can't open device /dev/mapper/eiodev16546: Could not open '/dev/mapper/eiodev16546': No such file or directory
>    *** done
> 
>   (test program exited with status code 1)
> 
> It is believed that this is due to the build env using a manually
> populated /dev, such that the device mapper node won't ever appear.
> It is not a race, since a test adding a sleep did not result in the
> device appearing.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  tests/qemu-iotests/128 | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Resending my R-B here for convenience:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

