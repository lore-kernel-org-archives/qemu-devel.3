Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93FACD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpRQ-0001py-8q; Tue, 12 May 2026 11:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpRC-0001od-8R
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:54:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpR8-0006A1-Qz
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:54:24 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CCKwlE545082
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O7eYDhWxNAzLHs1hC4odOlGkaDTo3jaTtU+G5yC12tI=; b=O8XFKVIh9Uhqmy0G
 +k23gaFi4W9eyt19kjIvJtILhM/qMtkrOq7SxIcOM85N9C1K70tL2DXkUe4XNFiy
 UA0+X7fOVk+KHPPJ7IXQASniCL9JrTjye+VL74EX9oQXoOGFWYrS+PZyk10NkebA
 kS0EWc6JxFDD7vR+uMMUHgyFSN/uJM2Bdo95+GHJlTcSvCi/K9WB1tAxe8pMyoLg
 eyjK5R3lLvewHA99URCde1DrJ8YM3NXtSaUamm0w9Zr0uBo8Zv9koGbPfQ5OOVqP
 IX59PsPlllW5RAaca3mRnRARmdSgV41B5VEjBm7LDC9YyhEQr2wsUBNRplaPT2n1
 U/5yfw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e444srth6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:54:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2f3eb8f3419so4782990eec.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778601255; x=1779206055; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O7eYDhWxNAzLHs1hC4odOlGkaDTo3jaTtU+G5yC12tI=;
 b=DodB0MpiaZVpx02J+BMB8M22zR+5A2aCHDQCireh7g0e8l9vIP8xHApwcGW2kLtrF7
 ht+VbLY/PO/AdT3/aqi9w9hoP9Xpu8A3/pTw6R/BefU89TRO0r2ZgTTNHSyFe/TrL8qF
 s4rjEj7IE4hWuhQE3zWIhNtipYHtxhW3r8RKjjvn654A/u6uwgRGcBLd78ZSRcympQxr
 pQi/zLHJ5yADYYdLwt4zYuOkv+S1y5lg7cVUB1vpMTrRfq3R71X1eGtMELGsNAz95IdZ
 dS/g5Vt3KjGgxqFeTW9EWSWeDYfdPCMGk+/QR/RkEEJQh3L/uA8B4D8PiKZSURQFMBFy
 ly5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778601255; x=1779206055;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O7eYDhWxNAzLHs1hC4odOlGkaDTo3jaTtU+G5yC12tI=;
 b=Twu0epDwjgzzDPyw7+lpB2gES9QHPJGkrSEbbVJl6v8c9FKzY/N5LkNI8nLJdX+dDV
 U1/L4O7+VsU9fmMSDrCkistr4OCgkznc6zKh3CEH5h1XRGjto5uUpBDFS6bS5QTBbmZx
 U0bqe8pdlztUyjlmPDKps3qE419tIJnxyHe9GdhJzXZZvDikugDPIRTJ5VJsP2sVumJh
 mzXQ9rG8CFE+kXdeGQBpLWTFixzF52gzwk435P5Z586xY+WU0rLUQz6rrij+fdxejN5a
 lHC5ie/PTvC+pTVfKm3jY1KvNGKKaoFYGEhQXSKT1Tvj7JD8RXA1LmxF04R921nRJ1k0
 d9Ww==
X-Forwarded-Encrypted: i=1;
 AFNElJ8lFZ1d1EK8DwVoUC3aX+93andlBbK4TVDBSZ9lq8rQKtoRKlYCu+0GoSrJHN/fAUURq4fAtF6Z/xsy@nongnu.org
X-Gm-Message-State: AOJu0YzRb81hRTkKNQknkM3ZIt+E8+uzdVEv1pQi48VwAYo8DT/MH4Ub
 09idyyABew58kOuCAezYpIt5szR7fHyeBVTlUBSOLj5sc/+yHH/0WiH3Ou+lAl57522k432d/bN
 cywmnaWAqUncANZbX7h4m0hn4392OK0zQ9aKdTH1czPcQkCnZd3HI7m0efA==
X-Gm-Gg: Acq92OFDA8hnehSmMiIWx6LUcdfkULk6+JLydLNCc5upEr1JcU+USeAdjnrW/dN4eD4
 Y2/fQSsHa8hpvGc3tXWvYTtXvHP91EsYIphEWqato94rCC578Wdnk051vYYaVZjTt4tYOvyRsWG
 NhIZibq+6wKjoQzdWIk6wuj3JAOR1EoXkJtuEMT/HjDJU3uS+o37YCCsIX6Azut5845fjlFXlVj
 PwSkUSkppU2L1jKxERXcRfoakpQHFPVVf/HyZuO9K3BbjNW2ZGhfarZZYOPZhOfl2ge0BZL9mQl
 Ff4OWSQj8fi3G1yLhs6WwTlIvPbGr2316tsh38YFcrR8yWmIG8HYD8Po3Kt4MFHNd8EkdRF0I47
 guP03rpJjh8ZmVC8JZhTmHr+m23yqasNTpYWTXoeRbSvqakkrLv51kvFH2Hq096gxPC4GgBzhEu
 IgxeM+EQj7WBBlBg==
X-Received: by 2002:a05:7300:b213:b0:2e5:8ec2:82c9 with SMTP id
 5a478bee46e88-2ffd77ed8ffmr2382981eec.26.1778601254961; 
 Tue, 12 May 2026 08:54:14 -0700 (PDT)
X-Received: by 2002:a05:7300:b213:b0:2e5:8ec2:82c9 with SMTP id
 5a478bee46e88-2ffd77ed8ffmr2382952eec.26.1778601254422; 
 Tue, 12 May 2026 08:54:14 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884752ccsm17798411eec.17.2026.05.12.08.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:54:13 -0700 (PDT)
Message-ID: <c2c5c5c4-b063-4451-b324-cb8de7d55768@oss.qualcomm.com>
Date: Tue, 12 May 2026 08:54:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] tests: fix check for sudo access in LUKS I/O test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-14-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424154205.364268-14-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Jjp7152gTOmONKh_kY2NwTlut2XtWFWj
X-Authority-Analysis: v=2.4 cv=OcKoyBTY c=1 sm=1 tr=0 ts=6a034d27 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=g6XHugeJElscH7bmr7MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: Jjp7152gTOmONKh_kY2NwTlut2XtWFWj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2NSBTYWx0ZWRfX3ADEEsM9/0m9
 l+tVAhcJCH80tD56dyaUhoKLB3A7vcy/uvc6lOQgsiQwWIXo4mU8N2xTSMq590TqigF8uOVb8R+
 m0IgIqNZ48wnXyjcVlpsVuKNj2aesELCjPT8IB1E53HtXlZ1NMfxtvExziT8FTH01xLfplokgiE
 KKiyMJmR6JfgpkVZwb9p2qy5h7amQHSi6JRd2aW+d8IZ99d87S0vkjpzy3ubOMIYHvgSRC7FJQY
 x0cegGNtCdDKhhNgEHFh6iCYsbv4D2KSnPSp1Ar0NLibFlb4ZFuuC5/RNe6tagM5x3YmkXQmrGf
 OJpfIIzih9WNg+WB48bvmjwTskc/b6eZCxZcH/q755SppgS6yGI7U334fIA8VNVCqv29kwkewIp
 fHCekD1IZIRED3Tu1upFkl7EB3RJhkO3d1zBdLHBb5gsK/67pZZfAmhexX59K4Ph5GmRRTUCj92
 KqEegWCBGLQjyPTgrlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120165
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/24/2026 8:42 AM, Daniel P. Berrangé wrote:
> The test did not cope with the possibility that 'sudo' was not installed
> at all, merely that it was not configured. This broke tests in any CI
> env which lacks 'sudo'.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  tests/qemu-iotests/149 | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

