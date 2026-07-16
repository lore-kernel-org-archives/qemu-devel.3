Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52F3C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkTed-0000Ka-OG; Thu, 16 Jul 2026 17:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkTeX-0000Iq-Tv
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 17:29:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkTeU-0004r6-MT
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 17:29:57 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJorg33864127
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 21:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DoWinvGjxMcotDt7vPUMDMfcT36pYPz/F9Pr2Yi1m4s=; b=P1jdbL4iKa/eoI45
 wFciZuuBdCx/eyVkckHxpASTokpr0QAEW4coiQh3bXeWp4Uf3PBOrCFy5JVN5lVf
 hruEM5tW8WFQyCQ0qgWaT874Hen2t180tIHllpLLfLl+zUp6CynrUGF9UvqfYKsZ
 cI1TsQtUEnowp1iTtS7Jx5jlUUXGNOpHv2NZ+l6A9LOI4Dmr7lHTkEWEydo7jS8y
 oLQS1saT2/gMGNO1aEWJdYmkd0eRPRv/pPadwpggTlhVgsKOt9/5cYnCXHR8qd4/
 vh/hnZLc1XavfxZDbozAB4AYiFtQsnamILrrWTO3ZUBCexim3nK1XDhLZ2gIjyCG
 F1m7vQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feu10bg9m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 21:29:53 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-ca124bf0189so486785a12.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784237392; x=1784842192; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DoWinvGjxMcotDt7vPUMDMfcT36pYPz/F9Pr2Yi1m4s=;
 b=MATABpkOub0wx1ynFXHVLlSbyRsnTBoJegEpewW8PWDJSrxKJDAZC2afj7A98OJ8Ym
 4VGK32+I9eL/KS+e3VdSThCstIP8Ez4h3bTNErVHJ5LCBul30nf2YJCxzcOk0Q551vqH
 kgkD/ZSLSHvhTW4gm+6NGvnGGszphyQKbS+YGbV6+vcIYqipqZ0MRzFRkyhn0C/nEt+s
 1ojIsJHkUMJDpFo7vZXNLoH/GQ8UIEt5vVzyVzI9VYbDpX3a2Vro56gbpo2ZQI2Iq3kJ
 nLdwgj7jTnEflM4yMhgpAxZs2dnvqB5iYesPvLhBE+vDc/9bQFIzhHOJIhrvOPtnemHg
 UPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784237392; x=1784842192;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DoWinvGjxMcotDt7vPUMDMfcT36pYPz/F9Pr2Yi1m4s=;
 b=MEUbC062LaYNdEWCy92lSZQO/SpbFE/7DC1xNAC6b6HjViF0vAilpdTUcfFX+1bIE1
 Sua8DIb3cVljv3BPoRVPXcFXYtX6sB/8GQsMMabkJ+EmEH2o/JJv7m+aAwMOCHqri/GQ
 LZRUlzakjur5xXcnxpa3dIGX05ngDEHEjcoHKP2lfsa6CEgzyCAJdOWPdnVjITZibYY1
 Oy8icspf/x8Vh+0Ux6xJTTW1N0/p5Tm8aD0WlFWS8LY3/T8Rfd1S9fZql8/DlcU9nIAP
 E4U4/QMeIXeE5xa8snpM2P/Sj+PUihGkWaS0rs0Vn8b4gCx9jSfLdPeJ6mE+XPWolP80
 lQGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZogqmVtleLS5Q3m4aed2QkmD/F0oBU4Y9pEerucw7VandLhTaMt9+WWwBK1spe2CfKXwW+psO0cu/@nongnu.org
X-Gm-Message-State: AOJu0YzKcrAg0es/shrk21e76rwkp5btcHSp7EiRqj2K/wNqEeC6fadL
 FPZgnWfUbljt/mwF7fQZs6i7SQhjgrx6iO8XSXYEGvLfPfZ2UhxyCqxtwU1TGAqBrh5H62wrxOk
 ECEzW6cnafuvOfdRcs99FuaBS2vMQo5A87TSGJzD6t+xnyzWHFQQY0pBpdA==
X-Gm-Gg: AfdE7cl4CjBUVavZliergNezwu0B1FvU/tLglN8ZVEWOG9pw3puxElKvDwl4KG0t05M
 DKgWw2bguQWtKUIOIJ8FyD+TwyuDD9GP7kUf77PKkY4G580/zHeKKMTcC6v1eALKUtHOG8Fxyno
 GWTAcK4qYZ6hps6TXKAzhVK/yGcuKAi9lZMzSJ67e78i607TSGqTx6CQhy+EILN13+7SG8g8PHJ
 rzzre3rYMLUqumz0Vi1q07C6hFV2/cCIN7F3XqKtU/VREDDVwugiHmC91OV6zs0U0fU294ZHTSl
 XrJBoEcDUsRegyTtUTMXwgIzQ2AP8SliI32NtybfWXHV3NLzpchakvT1Z+SAoVJ13dosoG3JClI
 WkFeUnHo5YoUCXyzpFKRRRRtQRz8g5HhOPEq7VFF1YigEtbyPufrrMuXsWIhzlUD7s8b6
X-Received: by 2002:a17:902:cec3:b0:2bc:e299:4b3f with SMTP id
 d9443c01a7336-2cf1f36bc88mr45609905ad.10.1784237392295; 
 Thu, 16 Jul 2026 14:29:52 -0700 (PDT)
X-Received: by 2002:a17:902:cec3:b0:2bc:e299:4b3f with SMTP id
 d9443c01a7336-2cf1f36bc88mr45609635ad.10.1784237391864; 
 Thu, 16 Jul 2026 14:29:51 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf10120292sm25840605ad.18.2026.07.16.14.29.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 14:29:51 -0700 (PDT)
Message-ID: <1cfe6397-3560-407d-aa2d-54ddc0a00241@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 14:29:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tests/functional/hexagon: add arch_tests
 functional test
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260716191555.3397687-1-brian.cain@oss.qualcomm.com>
 <20260716191555.3397687-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260716191555.3397687-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xSkmClioMvIIEyBya4sJMTcgFmulMHtf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIxOSBTYWx0ZWRfXzLTNAC09xm+r
 omeOWdoMxCcK78BZQy2nxpKyS0OGmYSkkuEe4TWiGPMIw5q6gAJffUykJzkQe22iyB0u/LUwxwB
 CMs/uk5sP7zOt7xOHxCBkDC/i+XTL7D3gfwXJqteu/lrlimR5Iw8VGUxK7vBpqJd9XlfcHhR+uM
 8NvUkbdE9acT4b1ZjR8eUY75FAXnLDeDIGjUFG6OdXN6pw+5kmujvU11sF0wuzr6vT5M7gQC5en
 kcq3OBCGqXX8i1MvC8SokDlLr/R4SibmPbqJAbiw4LGNBp7f31YTIEk0iwUVcagKU5naM8l/s4W
 tOEaq5+wlEV0+bD4G661a2qGBcBLCSYx6vxH8yqdRJOzMZRo8OuVRqsQOqm/uNqxB34tX6XbWtM
 CwZolokQ5YAlz3BQeqWiFe97ka3g2QY6gLLsgfFdKVNRUQ8+xWz/7CQbQcp3fiIbFuLBDPTAFzS
 TK7f5NoDV6Yu6A1BKNQ==
X-Proofpoint-GUID: xSkmClioMvIIEyBya4sJMTcgFmulMHtf
X-Authority-Analysis: v=2.4 cv=BPODalQG c=1 sm=1 tr=0 ts=6a594d51 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=8N4RLIQ2Qj8GcsFKxNcA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIxOSBTYWx0ZWRfX4q1+5MKCyn01
 ES0HKlJ1SElnrGoRVD6Tu3awLG4w5p1DqUhYJEDlWa0stft93OcUxNI12oSF7jXWkR51iNMtXiK
 6O/pZmjw5sRfXKDejXxr2oV9NOz52y4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160219
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

On 7/16/2026 12:15 PM, Brian Cain wrote:
> Add new test cases from hexagon-arch-tests to exercise exceptions,
> guest mode.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS                                 |  1 +
>  tests/functional/hexagon/meson.build        |  5 ++
>  tests/functional/hexagon/test_arch_tests.py | 57 +++++++++++++++++++++
>  tests/functional/meson.build                |  1 +
>  4 files changed, 64 insertions(+)
>  create mode 100644 tests/functional/hexagon/meson.build
>  create mode 100755 tests/functional/hexagon/test_arch_tests.py
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

