Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47985C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJwI-0003O7-Nh; Fri, 10 Jul 2026 18:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJwG-0003Nt-MB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:43:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJwF-00009k-0a
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:43:20 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3UiO1752825
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4UkTQT02mRjaXo+YKOPrIHu9xtLvzv5kPthUQmrfIv4=; b=C13RDWm+DCYU+UQe
 HYcFpcUBOB80vz+vjp+TYnaRTAhAIQrC7T8WJ1JKuVh59a+VYwiC2ii8dc0k6fUo
 W5+KbRcX7BW72hGtPEsimdnTIt2tubPl8mypm+hSYh5gzfEr8IojOId2mhMlJSSq
 oKfPuCzMnKxa3Kc9+5mewmdI+gIWRBbruKUC92FOPQsbuiAGgAkZFlfe6obO09D+
 L1JdB/VQmEUR+aseztAGxD4S0CAj4+RgwQSSc2f1sjNkFM/wqTNUWVF8wYRBgFyr
 hIPuPKVvhbfZNyUb9PRoIYRwR496914DBlSLqzuqopQMSw3Y0G0cG8OxTHd/6Noq
 PCM+gA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2pc9nbp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:43:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so27629411cf.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783723397; x=1784328197; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4UkTQT02mRjaXo+YKOPrIHu9xtLvzv5kPthUQmrfIv4=;
 b=TLAZD0wuflF0C27kVK7dih8phKX+6L/Pm35QSFVQO5ZtXttDCbv5LsADFxfEV9aB/6
 Xr+K1h2Dyd69G4WA8avZso0n+TVLDoq1VGgk62ZhZowp36WArFklqRjLzSlJ2sUFdtHv
 wd2oZc14SvlZCYEOWXgBTlAJT8qbHE0M1hzLUBMjKB7t6vQquW53V22Awz84B31OZSVM
 VkoHF9bxOC9SAJTuFoZwiyEbKZyOHog7oGVD5zV/syhU3ASV7uVdyFhNtdXsTFq5MPy7
 e7UHH0qten2dGpgelZsxoKXIg2nXClGWpte6xO0iboylo9upNDVwkJOBA8h9/AN94hEg
 Qnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783723397; x=1784328197;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4UkTQT02mRjaXo+YKOPrIHu9xtLvzv5kPthUQmrfIv4=;
 b=SPnZnroS953FI4w17Y/Bhq2Xbn4Oy0Vvl/NtA7OKBE5knZEWaPaf45gzxzTXWDxX5g
 wAO6jlRpbwKviB08Hftalmv2qoNLwy134Fl3x8mIVCVn8L++F4t+08c6o3ofv9BGjTcy
 zlWjeFJg2O5bvSNPi044OzHxKK2gXIwMOHvQ/xUqL+k4yXvkvFeuMJbKJhSh53NAQf2F
 1i2C5KmtjPcXkr362YT69rNjZIKMadiH58G/7I95VJM8Susm98feZQTkNrA6gwtT9CZq
 LHMqII3hbwh589hU00LpxFKBzD6BrF8R5vftPup+14OG37KYO/UokWDGxzWQZWSwjzjI
 Gbog==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro701Xecee/LIEmVbwDL+o5tabXT5g691BLWCRazKYqC6KeMaPnPSLdkak97TFvzTk4/Pv0k7ndzOnX@nongnu.org
X-Gm-Message-State: AOJu0YwHUEXjFqoyttqWJenPaaFsIyRAyrdEdlgx+CMy07SMvxCwZlKm
 j6/+CSSKUdj2MP4XVrTzXakhHPviBRDZJ8GzwA63YGjUV9nk3s8LrPrWJk2vpwIglq5b4IE+BVG
 JDzMoa9ZMVX5wDfIxXKLYxf5+d715bpCvMO55oDxlfupkH26jlBeCDxod6w==
X-Gm-Gg: AfdE7cn6ylTIJ3FqnBJ+rbJBjCSphJdmRPYihvsrM3PD1EQhGzjHWtJs09yD14TLu5V
 lwfVpWlhd7lyvZOJZahwTg0IJWBFK8OlbkmzRToAyLSRbXfQD3szhonSImlv19lQJkyrgp83i8B
 be6SXmE5Agxmt5M1/CisnxyQbKgh+mtHNzyX3ltz1Bngk/OAHXaqJpLcZ0yxzmectPf+Tc/LrIV
 Cy78Enwo4I+n+4hJuqLHUs4vyb1XyUBvWXK+rOPXe/ydQVAQr4+mYsH4LuYQ8Sh9vlQStU12/R1
 +z4FhvJN6vE09So9OzJfGUFHiD1B8OXQNex0nA6Ar4Z2u08KQ68mYZ00YYl381QTsbxZ7W8UMYl
 2HY3NCUYy2A++5Qrf02IUsRLLpHkSOK4AuojsE6ZcXWIAKratEh/jCCH/4U7ayQ==
X-Received: by 2002:ac8:58d2:0:b0:51c:d52:6049 with SMTP id
 d75a77b69052e-51cbf14a05emr9490781cf.28.1783723397179; 
 Fri, 10 Jul 2026 15:43:17 -0700 (PDT)
X-Received: by 2002:ac8:58d2:0:b0:51c:d52:6049 with SMTP id
 d75a77b69052e-51cbf14a05emr9490541cf.28.1783723396749; 
 Fri, 10 Jul 2026 15:43:16 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f4f09f89sm111306985e9.10.2026.07.10.15.43.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:43:15 -0700 (PDT)
Message-ID: <1425950c-0063-498d-9b61-9101bc68f60a@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:43:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 29/98] tests/tcg/meson.build: check host cross cc is
 working
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
 <20260710214343.2065491-30-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710214343.2065491-30-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyOCBTYWx0ZWRfX5Plr0M85SNTi
 d23Y6wWascHQ9i5f5R+n4n8O0Gy5Z8rZU11T/HFAgGird5UgXo8BGvPufe72oLfxsmDMo/2UikU
 IGD/iFPWpdMLLxNS4SyEFG2lWV8EBPm/zs27Qlwrtsjg/I7ca+jb9rPEDGunlz3RS11hiXH1kGO
 HbD4/QGbzfLMWw042+nN63mv7s4XbRnfQZ4Ve5IfLBZPc1KvMmmuTD9y4SB79tnXMptATw5r5a1
 wIsMPgt+Cztm4EBGVM8U9IUNuvc3DaArTiJiIGZ/himm7vQ+oSkpMJPkYZ3/itht6Cc5X1nbpr5
 Rys5OWXAjCW8LwqMac1wM/2aXYGl/1isV/WsbezPI5nFaZLQX4NtBIUh7rvp1azR9NLlZRhT0OK
 Yr0OFYFbabyyod+kVeZZCTQ6fD4+8It+8sDWTJ+zjE4FELOdrvDWNMyhocOe01PHXwnLVHRTTO+
 fDIliAaJUFTFeyjwBvw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyOCBTYWx0ZWRfX21lK8q4Y9N9T
 WX+CvQpYnZF3kDYeiEm1kZVnUqAe4W88sLyh/jDC7VQelrNUWLb4mHE+r/1YwgGqJLOGQZvFOMI
 66TbWNN1jR5Q+a4P8s3d1judlzz1PvY=
X-Proofpoint-ORIG-GUID: gsz-EhtAvm3mcspBpT-AQuV41c7DbCqC
X-Authority-Analysis: v=2.4 cv=J9SaKgnS c=1 sm=1 tr=0 ts=6a517585 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: gsz-EhtAvm3mcspBpT-AQuV41c7DbCqC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100228
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

On 10/7/26 23:42, Pierrick Bouvier wrote:
> On Fedora, cross compilers are provided without runtime or header files.
> Thus, even if program is present, it can't be used to compile files
> directly. Check this, and fallback on docker if not working.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build | 13 +++++++++++++
>   tests/tcg/test_cc.c   |  7 +++++++
>   2 files changed, 20 insertions(+)
>   create mode 100644 tests/tcg/test_cc.c


> diff --git a/tests/tcg/test_cc.c b/tests/tcg/test_cc.c
> new file mode 100644
> index 00000000000..b8a0dae6c8a
> --- /dev/null
> +++ b/tests/tcg/test_cc.c
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include <stdint.h>

Why include this header?

> +
> +int main(void)
> +{

      return 69;

> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


