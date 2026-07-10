Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19308C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJk6-0000Ox-M9; Fri, 10 Jul 2026 18:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJk4-0000HF-Q9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:30:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJk3-0000zj-7J
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:30:44 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3YFV1846273
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ELJAB/jafcFjTySc4+8l5pohTk5c7o0iB8lEX64HNgg=; b=aotqMVhIL4SORdx5
 ZV/i4Sav9HmxIb5rfkx7SHdaJFgB8Js/whjF7oIYPKoatReJp08NfZLCU9dEBsrf
 f8PiG1E/KwNvDOn7B6H3fkkT8CGVm1DDX+7gQfcVal+E4sVxlLSxcApQVt/l+EoU
 O2Mj13rVptCVgPrFDvqy5YEjj9MTRFpUmPCSgnyAbo2cLWIjRaNClrFzy+7SxyWu
 X2cWGJQ+1wUmOa7lHqOkWBEb+xXBwSWD84WWrDg4CmlJ7ey6ByfW0IoJcRGeoGUE
 FBq4yd3kh5wvIo97vgL3oS8fPJxm+4CClr0IBwlGQilVSbURXJpx8rIye4LdEvZ8
 iFPTjA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb649rp5b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:30:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c2af04aeeso22034431cf.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783722641; x=1784327441; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ELJAB/jafcFjTySc4+8l5pohTk5c7o0iB8lEX64HNgg=;
 b=MZ2EYrbT2CpOehwpVtqACO9gsi9uSLUnlpcKCOlO/8z3QvxhwfNuTMtCoQU7VcR0hJ
 fVFvzGZ87if5teJYKqjTLDYWMczqmGKvTE1/s07xQzmEw9c7Kxg6ot6x0gC0UffQj697
 D8/+9UsF7QQ+ne6Fcr+O/Beh/6NOvus2u6KxMPD6kYoF6ZbsDhHr4jT0FBnEO23re3pp
 +ri8yCOnJo2YuOpIDT6Mepr/43dJ0xMcdW6h0tWjovp1BG0L3oVf3gl5XxogmD9lj6Ss
 FfgVtCq0limqtFYdPC+4zO+rwvdG6reS2UbYutLW60JRA0tyK3B+mXVq786/CvuBpRYz
 H6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783722641; x=1784327441;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ELJAB/jafcFjTySc4+8l5pohTk5c7o0iB8lEX64HNgg=;
 b=UtHDu8Cu9357ZnO56R5/20jEbZqZhE3GT35sAjyVXe7IilAYNJGlnabas4hr/2R2DL
 vWFxNHKFKg3USqQiTe1e+AtuMVWYAmQX91CJpZePyocpFKHM1VrHYxaHJ5b/si5zPYoD
 HQ+pBf+LkWG/iJ0JBkFlmm8ne2i+g8azoO9s9hQ+A+MiSXVBmrUN69covoyVCFC2gLDq
 h6pKhKJbCRWoLymM4Mip93Fzn2Uqc4Yft0hK9i84yU0LB3bz3SZ28eg7+1AvQvL4OtOn
 /uhzl7lKOqo41Bc4J6stEq0HcDGDsXfsvTc4nGxF0eV0dt7ZVvgzTo6gAvROWIcl1gaH
 DF5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKxWiMXd9u0gxQgXOXj7aQZxW+IXeDhX+WD8U7BXeY9gx14DQlhffATK6o4trV/dq3ZbuqVUEj8pe+@nongnu.org
X-Gm-Message-State: AOJu0Yym2PmVpYYc41uBzr7UbEcQ0GVzcQt/hEas5Lz0E+p7q5+FLFCW
 UwEC60Xf9mkoHy8MAfaMEnF5+3X3Rgk8lZUqjjDWGETUPp3heaXIiU2t//dezpqTLIoTRT0MlPB
 g/g6TQVPtwe200DC5tXUxkS3VYN7OFlM8oym67OKgPRg0qU4TAVQpD0sFFA==
X-Gm-Gg: AfdE7ckHkm51pwyaaTvK6eRSeHBrHHF3LY/ZFGYMauK9iX083Z+/fPiWycXT4yrL0eQ
 xafZL7MZimyrmbWfuWiX6LXIcArtZsRpKqRtpD+/BOuCd5myPvC6IrAApkrixiVl3qlhW9hmrdr
 Lqx2U79oGdzXbT3HUuMDvShaQBaSbqQVAHLSByevFf/LA1oenrvAQ5tTa/7+KoLydU/mjECn5iE
 Lq4QJpfGKkVNXJsWm2gOxrMgIRu/z/duqB46g4ki/+wbPoScuv/qq0UOWkdVPOyRxn+5jSn+WkT
 Aod1XTcCbEDpZr5npW98ULIExH241dEr4mT+WNreyJfvzFteQVOGcDn/mh/iqa9xh23N7fNq98p
 2b3pFMNCvghcEKJKKKuIJnJG7Z9fTLRSv4wkl7tBl9QpwX5lmnQl7Mjney2ynQw==
X-Received: by 2002:a05:622a:2511:b0:51b:fb5f:b263 with SMTP id
 d75a77b69052e-51caa02c6camr58942531cf.4.1783722641536; 
 Fri, 10 Jul 2026 15:30:41 -0700 (PDT)
X-Received: by 2002:a05:622a:2511:b0:51b:fb5f:b263 with SMTP id
 d75a77b69052e-51caa02c6camr58942151cf.4.1783722641136; 
 Fri, 10 Jul 2026 15:30:41 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d780csm63456549f8f.11.2026.07.10.15.30.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:30:40 -0700 (PDT)
Message-ID: <56e51914-8768-4316-8960-ec1fe933a708@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:30:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 61/98] test/tcg/mips: user tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-62-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710214343.2065491-62-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GdIp7BFmjLEKGm2D-waFefawBPr51WH6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyNSBTYWx0ZWRfX0rRcI4DQN27M
 5QvQxJCDVdzuua3ZDKA1r/DewMIvWXMETf2GNdrdyUHYx6ld8Ivy8IZ+Ro1N2cPdO+wHrXXAy3F
 AbfvA1NPT5/sBi4Ov+MlthZZoUhpMIQzM9MJYymWvFS++lT6oRo08evJH3NZ8klHp70jpsSnA0p
 +0rDIGHcGNMBrSAt2+/isWLV12B3CP5vCDwN/j2wbOshLuD3SoACwcxk7ghl+qI898rN7ONaek5
 tftiMT8QHgddwdfOYBxwzpP0skOFPn3KySqcOersoNM2DFhHLtau43N46m5Ey/br14ncm+esVfU
 ZWf4SD0dRl8UnZg4yFOAC08M0RprYiaWdSQG3cT/zg3RJ3aZCxbGHaxS3/ZTrriL0gaZoaYPVZc
 mLIrwesccKueNzUWob+VdLWCVQpLxCrVWzl/2y9r5IOBvzzQYKhAEfheYcvrxs3yW4n1PUeGNHF
 lPAxybdj5iXdxPm0iDg==
X-Proofpoint-GUID: GdIp7BFmjLEKGm2D-waFefawBPr51WH6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyNSBTYWx0ZWRfX/baGZcZhnKWd
 ZZ1K1VkG8rDTd+N+QAYTIFiN6DhMWfBeL74kLRk6SbWPBuQQlPuNTKmvp8/U7XJCwadJMTkOlLi
 dS54u7h7vYxKVD0v+uZv/VvkVUx6ACs=
X-Authority-Analysis: v=2.4 cv=VZfH+lp9 c=1 sm=1 tr=0 ts=6a517292 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100225
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/7/26 23:43, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build          |  1 +
>   tests/tcg/mips/Makefile.target | 19 -------------------
>   tests/tcg/mips/meson.build     | 25 +++++++++++++++++++++++++
>   3 files changed, 26 insertions(+), 19 deletions(-)
>   delete mode 100644 tests/tcg/mips/Makefile.target
>   create mode 100644 tests/tcg/mips/meson.build

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

