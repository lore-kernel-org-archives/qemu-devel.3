Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F6DC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJeS-0007uD-G4; Fri, 10 Jul 2026 18:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJeR-0007u5-8J
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:24:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJeP-0006uW-Hn
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:24:54 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3ifx1648591
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A0yMlc6kOSOUzcOlMfm3lyJlOINaFv+YROvmLMxaT3Y=; b=Ko8kpCqdN8ERfKfS
 c/g+5ajL51xN3cPP80IeU3nQZkHWHsm4k9QfQsg6Y3VVGcpHQkrhbVPzxu+tudGE
 N0YwOkes1wGgMhAbOEsTLmCJZDEV4MHBLkBmz3TpdWPETEIqeKua7GtJktFIahky
 URS3wskcfomlLoKZUuKemnvArM2x8GKjB2dpdltFU2SIlu8BQR3xWJoxwi+ERuPa
 XNO76rdRJzU7/Vd2FvMf6+gS5UmIv+OV5ExryCzP3FkBunC1DuiaGEiLQB12nTDN
 Jb4wlzmdoiggTkDEL+KU3+oNPPBzLTiLnF2sn4N1Zxz8YyQVdy+rk9164Aw8pymx
 a2T0FQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2txhgp8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:24:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so26513551cf.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783722292; x=1784327092; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=A0yMlc6kOSOUzcOlMfm3lyJlOINaFv+YROvmLMxaT3Y=;
 b=aesjbf/OVDpHCWdjOEk6K4pP9ExaZTYDvFJt49v4LtbB5sfGDal69Q7T0z8Jh3/gxZ
 Xf2VgXDgRGQTHd3kC4Cvx+H6BOTvxUvdU1pf/PLE2s9fu8ifRGEoFgwXze5uB9EXX7qH
 eO3/F/mNLjXwD3CH+GzcwgSDe1WWuWCmy28wWruOof6RmSs4zwFU/SOVMvNgezwW9XLU
 MpmOfJXF1vSMDt/toYfVNn3u+Rj80EOyQaRy6T9f48RfOAUSHYV9koPtauxoU/mRf9j7
 K7PLYqHizoIEAocpNc6uy4F41Q20khD4plbZ8ktZbKdMOgE8zXoBCyzoMQGvL2V3d2mA
 6KFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783722292; x=1784327092;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A0yMlc6kOSOUzcOlMfm3lyJlOINaFv+YROvmLMxaT3Y=;
 b=XS/V0fzp2kB1u9D1QVJVYqC6h9kfN8TbgMgVyI3HmeQiwQ5FFC9tgLoxK+ctWf0cXA
 zgkLEKmoI/TteP4/Wsz/9Dvj1TWoPZoFUSr26SCCsafaW/VE7GpHZlLGoocBzP/8UNUj
 TBOl2FlFdeoHCGNjnbvHdwnE7oAs0/olhFifnBeFJMdJsBltndkRmwplKOD9Q+HnuMJZ
 DsSXCxFqMJXlOTOzDagMbyxkjYqrqz76jeTj//NieQyTZphOZSQ3x7JsUUfontdgIY0t
 pzCEDgQwdqK4WK7Yr7ufoZP0PyR/FatXsTRKi0aWLzQBYPWnPPXBnFRc+rL5T+Qv/z/R
 SZOg==
X-Forwarded-Encrypted: i=1;
 AHgh+Roqt7kVJd7sL8rDu2xgXaJqiSjI54HJXKkTsu179bE3H+PJQv/exN+3u86+pJWOwApp7LAe0B3mPN8B@nongnu.org
X-Gm-Message-State: AOJu0YyMdaShs/9ct2lj5t10ajP1wWDOrp04Kw/I2cQQua/P450zEw3l
 Gg4WBfqb9j/t3Udb70rCMVee6wG1g9p7tsY2s/mMv4Cw1pwjFAuEgMqD68MqSw6xgP1uQk+i3gY
 ktUKhaOCmL7DW4HIJJ1KAQZYZyZXGePLNZc/c54yOQhZGzGGuWr9hSDUXqg==
X-Gm-Gg: AfdE7ckz7f0QP2woUjRiXtaZCml+O4+aWqniJKx10MM8VVsKmsGs8q/m05HGqSGiXtu
 pNW6h2cGKM6a+5JdiH/F/SAmfBbl+CFI985AROIwoK51919hK54+aC223au6kd4sxMumyDtmneN
 VkpWVLg2XSN3fXZ2nuU+kygGzHhsvefdU17e+/TQH/FAoM4EZIE0gFFdk0fh/Ey7ms+oYxRPFOv
 zZBUGY7OzDnQiiKaU7Ldug5S5AW64WK1xyVFVVpEeT/zvQoV6kUdm92KsYzvoz5JFIBxIJOcAj3
 Wb3A9ln+jIgGMm8IdSwQI6UD9EIJ+CkIVgJdNYq+s4SaU6PFgC7eiufnJ/2sHyv/aPcNp3lMnrm
 qlKFFuP/v/pMahuUUjIqG5G0X/dt6G9tMqDnZme1r7RhJmHfXF8bs96XpVtu/+A==
X-Received: by 2002:ac8:5e46:0:b0:51c:11ba:c51e with SMTP id
 d75a77b69052e-51cbf276df7mr8767181cf.56.1783722291682; 
 Fri, 10 Jul 2026 15:24:51 -0700 (PDT)
X-Received: by 2002:ac8:5e46:0:b0:51c:11ba:c51e with SMTP id
 d75a77b69052e-51cbf276df7mr8766871cf.56.1783722291313; 
 Fri, 10 Jul 2026 15:24:51 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f4f09f89sm109517455e9.10.2026.07.10.15.24.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:24:50 -0700 (PDT)
Message-ID: <eac788e5-bb7a-4644-8355-110975562531@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:24:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 51/98] tests/tcg/hppa: user tests
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
 <20260710214343.2065491-52-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710214343.2065491-52-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ELM2FVZC c=1 sm=1 tr=0 ts=6a517134 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VhZoG7EWoENQx3OTD4gA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: jjpMDIsjXA_4XJJh5MMPJknZLQolu8NY
X-Proofpoint-GUID: jjpMDIsjXA_4XJJh5MMPJknZLQolu8NY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyNSBTYWx0ZWRfX3bw0l6zT57fq
 AWfJAJdQsU7gql/s6nI3mdO8J3uTMcJWEWLZM4ZV3GGdV7XjDV5w67sk24Z6G+4qjJSxgf55j66
 7NcTR/XvRPRDPc8m3f2WMxSueE0nAJFOTURz3PSd4vmVgAZ5Fq1V2l0lIZfcIeW1NKoQldFATSE
 mR1iKPyhOUq8X1Ts+VqZ9O4XhQv/p8reqbRu6rh0wcqN1n+0RjuyHALK68qmp2t2hj3LWB0k4Ws
 O5JXBenhYtqQL+/r6rfR5EX64TuvxnsVb8W+d+Iot8wAyP+iEork1SpBQZpJGSXNB1u4Wz8XRZT
 qfecMvPVDgzy3Yntl5TRIt0XYMT1J+gpnEXyhvxc1anOooAPTKoy+xW93PVxnZMRB/00ry4Eazf
 PYKGWg8i9tJuvI4NR4dU1EeTANbeNpdnQ/6oLCj5Ec5nAWvIkNhvXQ2Oq6yHFO2xMYHYVkSACHB
 hxKxd0W8KjpC7RKdUsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyNSBTYWx0ZWRfX6KOh2NOw7EeY
 cpH+VdF58+/jrEBZU9Dk2dyNnReJtnwAyV2e0WvH+Yh9h1ZQkm+Q/PxcjW5y/0G1DxqifvhTe6G
 M3Cs7HVWsrMczsyodj6c6eO0z+h+Y2A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100225
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
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/hppa/Makefile.target | 14 --------------
>   tests/tcg/hppa/meson.build     | 22 ++++++++++++++++++++++
>   tests/tcg/meson.build          |  1 +
>   3 files changed, 23 insertions(+), 14 deletions(-)
>   delete mode 100644 tests/tcg/hppa/Makefile.target
>   create mode 100644 tests/tcg/hppa/meson.build
> 
> diff --git a/tests/tcg/hppa/Makefile.target b/tests/tcg/hppa/Makefile.target
> deleted file mode 100644
> index ea5ae2186df..00000000000
> --- a/tests/tcg/hppa/Makefile.target
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -# -*- Mode: makefile -*-
> -#
> -# HPPA specific tweaks - specifically masking out broken tests
> -
> -# This triggers failures for hppa-linux about 1% of the time
> -# HPPA is the odd target that can't use the sigtramp page;
> -# it requires the full vdso with dwarf2 unwind info.
> -run-signals: signals
> -	$(call skip-test, $<, "BROKEN awaiting vdso support")
> -
> -VPATH += $(SRC_PATH)/tests/tcg/hppa
> -TESTS += stby
> -
> -stby: CFLAGS += -pthread
> diff --git a/tests/tcg/hppa/meson.build b/tests/tcg/hppa/meson.build
> new file mode 100644
> index 00000000000..9ca8f29fa93
> --- /dev/null
> +++ b/tests/tcg/hppa/meson.build
> @@ -0,0 +1,22 @@
> +tests = []
> +
> +tests += tcg_tests['multiarch-linux-user']['tests']
> +
> +tests += {
> +  'stby.c': {'cflags': ['-pthread']},

Should we mention the 'signals' test?

> +}
> +
> +if 'qemu-hppa' in emulators
> +  tcg_tests += {
> +    'hppa-linux-user': {
> +      'cc': 'hppa-linux-gnu-gcc',
> +      'cc_dockerfile': 'debian-all-test-cross',
> +      'cc_docker_host_arch': ['x86_64'],
> +      'cc_feat_cflags': cc_feat_cflags,
> +      'folder': 'hppa',
> +      'gdb_arch': 'hppa',
> +      'qemu': emulators['qemu-hppa'],
> +      'tests': tests,
> +    }
> +  }
> +endif
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index e6206ae670a..018bc480e18 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -138,6 +138,7 @@ subdir('aarch64_be')
>   subdir('alpha')
>   subdir('arm')
>   subdir('hexagon')
> +subdir('hppa')
>   
>   image_targets = {}
>   exe_targets = []


