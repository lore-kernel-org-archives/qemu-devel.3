Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BC4C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzifB-0006Bd-MJ; Thu, 27 Aug 2026 18:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzif9-0006AV-VP
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:33:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzif8-0003CP-B3
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:33:35 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLtca848970
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OHbtcIizDFWDmRf+Cf2iGCORBWVae9EF7wcS/BY9x/M=; b=BB+QMHVI3YvZG/jD
 yStIQz+iwddQIE+3Hyy25j/6EnkyeHssUw//P0wHrOAV3NeobhaLo/0xt9gw75CR
 QNRCNM7ZmZNJxEP3pfN5l8K4EoSz44qc1aTk/GCJCxDb1B1YIQq/noJRZXvoAz2u
 KlFCeWGtrIqHrL2+z2UNRVw8s6fJfSGYlXrTgtvIMMAsroGoESjBHZ8g6kOnr0gs
 dok6EDGPIkxDWF4USpMyVZWyYDmOw6oRv6d5OD0mrSV2oFzvN8MJvK/teoGNfRkq
 /t3WXyGipCilCA3yefUYvD6x5XytJb2/TKkY2XL8f94KCdQTdd8oAh++ppxA5FyQ
 gdkjQA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ganr6a8my-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:33:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d6f710f066so3121015ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787870012; x=1788474812; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OHbtcIizDFWDmRf+Cf2iGCORBWVae9EF7wcS/BY9x/M=;
 b=eWW5Veo3dYsZc1w0sblrUB6Zbz0gvsylkJZf+hIC0fx70E1KQoitxR2Qbi8iAFX9+J
 0zOq11Oiwr+cNHzWSfooJa/4fKlMIi5cwF0AAifBb/NhzDngLQbbggHfY7Cy41e4zntm
 Sy4sR6e+wjnCIocnUIH9b1T3LmS9W/FgNH5hwmAuio4sAbYPpvVliSh9DYIi3+fSVKBu
 CpcsTcq1Yp3xqE6YWRbL2cqUmIM5Vnz+beCr5IhwIPFd80obaZByRCSVuc4bh7ntQoUa
 QCHkAb4S25R1xEAT4hZJOcz7hlK+cu+wJELcsMiqke1GJtJU1ye9/L+norR3muK/z/fo
 h9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787870012; x=1788474812;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OHbtcIizDFWDmRf+Cf2iGCORBWVae9EF7wcS/BY9x/M=;
 b=ZajjVtcAygmoCCkS6+xO7ioX2X6dMCtcq4J6c1JabpwdVV3gli3mg1IiAYvInXm66m
 ctKuH6vU9/pIgI0M8AHtwoPgOhB3L/mlJZ94HrJzQIMyWyIgQJZF3cptc/oALhjNqddK
 mDUq0/aCT/lw62OLoWWFimXdhKOM/N4gEJZvNls6JdTuCnQazxlK0Gaa61nDcawZdRKX
 rkFKqELQ5euXpTHWJRlrD/9dQN84IMZE9E4LCl5p57quFMX33LoHyB9vvNksiblIOMv5
 rS2uCmMgUZdYVoO2st6HxIqKjLrdQsumccMvvZesn6SuQKzFLNhADqaD1zs8/fVdhqCE
 NamQ==
X-Gm-Message-State: AFuF++kCtMZZg8FNagGOLn5q93fgrHP8sZstwQ2/3sLsN2Gk04Xk/3OS
 XMGs1j0h1jVHkJTumK/UTvzOg8S5InTZtQlDb82v2ZP1SucCOevXZgM0vZ38EEmUiZhCf/jADuI
 An1CoOejC0zpi5X0iVsqb79IrfF+xiebeNiAjwLXwMMmGX4M4sFi9omB4OHJ9Osxprw==
X-Gm-Gg: AR+sD13VH0njLcrW7oyWPZrHUztyK6LIxSwFV86RQP6/7p0rmrHUHU2Nhjgmg2Az4fr
 WZNyswarkneOdGt8b9DZVSlCA4ixCVu6KgPoupwvK2K5o1le7w7WDL7nEWZ1I3nuwZhMHwOhMWv
 CEjzpfDDVpBiEnAIAvp2XzAh5j8i1rCX4eIyaisgd6Ugg1SPBEYMKNC0w5fqjvtfth6s0scAdW4
 Ml+W7GgjMvenQ5E7bBrHmjBIPoiUcjLXlua187Xc3dVQLZ/nmgEmLGFy8Z7h7eUtfXCwWsP6xZv
 LDA6gqLmsXu92yUxq12acPS9ZBR52Rsw0ab54KL6D4q5Oo1kXlI7CSC8KoBSxqtb/EJ6f7tJUyh
 FiaO72U03OjCdbTsiUvc0/AeKaVI5oGLnN5UjLPSaIn3YTAXsHLN4sji8Q8cSVhfnhPG5
X-Received: by 2002:a17:902:f68a:b0:2d3:c3b:c7cc with SMTP id
 d9443c01a7336-2d725df6dc7mr111678365ad.3.1787870011675; 
 Thu, 27 Aug 2026 15:33:31 -0700 (PDT)
X-Received: by 2002:a17:902:f68a:b0:2d3:c3b:c7cc with SMTP id
 d9443c01a7336-2d725df6dc7mr111677985ad.3.1787870011213; 
 Thu, 27 Aug 2026 15:33:31 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d60c2b4sm34781181eec.5.2026.08.27.15.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 15:33:30 -0700 (PDT)
Message-ID: <3c76b5de-9b90-4d2b-921b-34b83d7e6f09@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 15:33:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 000/104] tests/tcg: run tests with meson
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MSBTYWx0ZWRfX0KiM2XqBZIam
 3CEbWKPsWaYvIAe76OLohgAn+rNXCAIwlT3R3ogScmkQYEdWQNcRMNOpHu+/mrMwEb6PT//vETz
 eMTWCChiJfjsTNxryOPMrkIX0a7dZk+4uSuDU//crrQTSU4w+qsNdJMDwZR+JwSXBwS6TVjK6+0
 sLs57qx/A39FCblM8lvC5ZJGvqqIvZoQyTmvI/zHmcWBrt/eBt/w1Msu4HEwMMZwXfu9bjml1ux
 NQqB6hlchKWII0NVvBBmHYP7ziSXG0Mjh03jzDdvwQtGKS0n/w5bmt/zilVK9fp++FBQSxOVeXz
 kgDK6pItx80d6G6zvyUQZdWjlMD3vR5WJxbfgrSoLBL+V1RFJ8cF9VxqnN6X4TD8woq7guwyI2n
 WG1g8zi75zCL0I0G3ZkvwlwQBggXSe/+XbkzZrlOQOi4RmTRbcAxmDh1bfpPJdpyUd+8FgKHhpl
 5Ged5mHrZgn5YiZAnrg==
X-Authority-Analysis: v=2.4 cv=d5DFDxjE c=1 sm=1 tr=0 ts=6a90bb3c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Qr_2lOKh5adN_g70dskA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: NXuqklJMZghu-HcLPDCcCAfM2fzu0ifi
X-Proofpoint-ORIG-GUID: NXuqklJMZghu-HcLPDCcCAfM2fzu0ifi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MSBTYWx0ZWRfXw3s2pRjG4Hxf
 UQI7DGNIelaybJDbg9DhMSPgAaol9GTz4HYeMYu++sBrYsr6OrXT7DGsRTnP72/3wGsbCtX3p8X
 TT3+Ofv/4QWybZfvYcDORWzs3lpibgM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270191
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

Posted v8, we are now only missing review for tests per target:
https://lore.kernel.org/qemu-devel/c6825ac0-9e0e-49fa-864b-c5f7dc5e963c@oss.qualcomm.com/T/#

Regards,
Pierrick

