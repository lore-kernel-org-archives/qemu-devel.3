Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65344CA5FAD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBjfQ-0003T9-Qp; Tue, 29 Sep 2026 22:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjfN-0003Fz-SU
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:03:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjfL-0003BY-SX
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:03:29 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNPpcr1352957
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KXhM7QbMoegUqTyho0P5yV+ceYIlA2TKB4Ui95Ppc1k=; b=janAbvr6ki7PxDAk
 b2bCgW3khIHSc3Xa6v3k+531rbBHSexGxPHio49Q7FBZp8Qhw2wkNJqQn8kIZtm+
 EWCcuJUoyuxvPPldvMI6ZabS8O8kKwbo5DQMiYTWaNF1gWKjoN+qMRtVQ1/QZ+fN
 YO+WyKC//mfLPUfu2+pzayMYC2ZfQtciU/JtLsoB8BPzD7GFGDXWc0ly9rOJqABg
 nVC/hLlHc2c19GvquTVDRwOwGMZ3gBfd3qMqK1vlTVB5J6jdRuC33+a2D5UpuhN3
 +n/OoC0dRB3w2trpTRP1yyj/QyhBCO+RUop+lwdnYGg0xNUnbeiQYFVIgyJ8WsFf
 9NUywA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0eswjsd1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:03:26 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33baaba6371so18196760eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733806; x=1791338606; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KXhM7QbMoegUqTyho0P5yV+ceYIlA2TKB4Ui95Ppc1k=;
 b=jbOoYq9URVsRyWWG6Z5iG44+UPK0VdXFh0l68lCTKWOaEXMv7yqxp6NOzEFkWa7U5h
 rgbqY5wjO4sWr8Zf6dCz+NjxOdwUw+CucchbAospdpPMhDNsg6Ag0a2Q1hJw4Wo2grmC
 vj5vlHptBk99oqhhajRo4f4D+wkeCI4T+BHTfkE5fQWPUOh17xwhSSnvCpCXv3nbVVW8
 SExmk0cvkUDCf9MkMI/MJm+kaeBXagKo+ACK6oV2122Qy+Ajj6uQRLssRuZLtmht2igF
 Gz7WTv78rqCyEV539vnvoSlsfd6ATl2IP951mCwewFuR0wLB9qeITLIp1kKvsVbyFEiY
 EI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733806; x=1791338606;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KXhM7QbMoegUqTyho0P5yV+ceYIlA2TKB4Ui95Ppc1k=;
 b=DTiWJ/VM7odIE/x2Q4ZZgJ+rO0u4Pu91rlhEGtE0cMDU5rRDJ32crFKAr8nDLM7m/K
 yq3REF7ruDFyJ55fqBgWfBUMdgztsCLt6cisVUZHnb+Ph5bl6Y4eRqFpwQLnewQNqzsJ
 +vSf5QCMWDeijGiIxbT6aNy1UsuXtu2QuopHnKVi9a0KhaAVLXONv/c73Ge2FQ1Ia0px
 mRG3V9L6OKa4C53YeJhDnbmLoUTwcsm7GbdS3sHXtE8nlP3m2omVhHAfLTC7PgQWALdv
 mVgqDbofb9Klv2z8ECjKYK5RBgdshpL4pEOZcLGjpnoqA/bPXMQI/F2igEeR84l7UKwe
 vL4w==
X-Gm-Message-State: AFq9FYLE5z8xekICnCCZA7PK+HSTEKyBjAcRWRphYW2y8wOQY8hoiKp/
 UkBnci6cFf/YBig8QuCpbTzK363lU5HD7xPfZ4gp265IjWrcRqUGPIn8P7ub+5gRd+NdMJv9V2F
 9B8kYF+kHWoBZZZbtkV+2SSFlsjVnRCzVnK+t/+lGY1McP+ErkYM0dqfrYeqDa9jveg==
X-Gm-Gg: AYBFou3Y+KbFeG8WurATcm4xBtebiOkrkHcWuKPMn0gEr5Brd7Gln83p0crFcBHB5My
 yBq2Y2D+bxSd9MQLqbOS17+WaOXTQafEIY7w7qIFpTEcUxqD04WV1tGSPR2BPUxMeSqhJK9HlEN
 SsNs5uE9DktlgLpFA4PoiOZXTdcyzGFs9n32BOWkWtvekoDFzoSwllvOpImWnO6HmzhSVnP/dSN
 QarZBqHefjD359R0t3e+kAfiXIvNHn4zdXRRQfH9Te2CAdMuXfe6wf8v6Syl3EZkx/8Egk+QNPc
 waIv++oGP9JdoFU5tIkbUv/8UC4zLSJgekOou6+XQKgaE5F60Z5jJkEMJ5NsF73rIsnSlJNvexq
 uByRgI6/41POsjUwGOrWw3FMOjVSi3YJ38XLqW+KUVf22uF0/MU4SYQ0450HdRouWpitFhQ==
X-Received: by 2002:a05:7300:e010:b0:342:645a:5cf with SMTP id
 5a478bee46e88-34cdd0aa440mr117757eec.1.1790733805453; 
 Tue, 29 Sep 2026 19:03:25 -0700 (PDT)
X-Received: by 2002:a05:7300:e010:b0:342:645a:5cf with SMTP id
 5a478bee46e88-34cdd0aa440mr117722eec.1.1790733804770; 
 Tue, 29 Sep 2026 19:03:24 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c386b6a49sm2587377eec.17.2026.09.29.19.03.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 19:03:24 -0700 (PDT)
Message-ID: <b0102368-adcf-41c8-be9a-d12f567a94fe@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 19:03:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/21] multi-target: add straightforward architectures
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfXySLc06oUCKli
 Xb/J8RKcGvTfuJregRCUS1BYHXTaPp9EWvvpPAasBjQA8gnAPSOviCaTHXteXEwERUZ4bdixCwZ
 Bma1VH8Jh+DS/x/ChpeTcFoWt3p4NLdVjDvRMB2r8I4ioh4D3zpRWQp4ETc8WHt+ZZl+1biCi2n
 WSnv08K1uqndrxSoKftOrqi9ZygY6QZ1IpNN1NPb7qBHvfJVQGAQ2QdCtcFBSa5RjPPwuhmaCY+
 PtTGrooRMZEK9TxRZ5zbvZyELdJtXkQHPoyFtuOVK3gHCba5Cc+VWCOlw5TUTUYPrKaRxY0nzAg
 vY6yAQ5TkLhPX7D6H1jFbbgBYsDcN93/GLTFlLyvZB+qtArhOgDN3LSSbxRcXyjDAU59CvPBL9r
 WccS4KNn6DpawbUEubh9gbxsvo3zANqV9KTZHGuYr0n3d0ZzvhXRRnN4pKgJ78uJbDaFROpqzlS
 nx7OyeJtgSOrmNZubFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX4ZwGZrOTKWIx
 FteYVP9vlbQaq/qySRrLKLCJO9rMVdaCaDnRqPysoBBqPCEOpCl5GfLFx9Lbtzvhg9/bxzWg4f2
 iRHnryY/FVlGHixXw+FeWh2RM9VhjAw=
X-Authority-Analysis: v=2.4 cv=LaWpeTfi c=1 sm=1 tr=0 ts=6abc6dee cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=j3VKWkTSZNpEev4ELQcA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: HGYl2bGfpHq4c3vBox9M-EI54nCORXaO
X-Proofpoint-ORIG-GUID: HGYl2bGfpHq4c3vBox9M-EI54nCORXaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300007
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/29/2026 7:00 PM, Pierrick Bouvier wrote:
> This series adds all architectures that only require stubs, basic helpers
> renaming, or filtering to be included in multi-target binary.
> 
> List:
> - alpha
> - microblaze
> - m68k
> - hppa
> - rx
> - tricore
> - or1k
> 
> Pierrick Bouvier (21):
>   hw/arm/virt: make virt machines available for base arm targets only
>   meson.build: subdir system before finalizing stubs library
>   system/meson: use stub_ss for dtb stubs
>   target/microblaze: prefix helper conflicting with other arch
>   target-info: add target_m68k
>   hw/m68k/virt: make machine available for m68k target only
>   meson.build: add m68k to multi-target
>   hw/pci-bridge: use stub_ss for pci_expander_bridge_stubs.c
>   target/alpha: prefix divs helper
>   meson.build: add alpha-softmmu to multi-target
>   meson.build: add avr-softmmu to multi-target
>   target/hppa: prefix helpers conflicting with other arch
>   meson.build: add hppa-softmmu to multi-target
>   target/rx: prefix helpers conflicting with other arch
>   meson.build: add rx-softmmu to multi-target
>   target/tricore: prefix helpers conflicting with other arch
>   meson.build: add tricore-softmmu to multi-target
>   target-info: add target_or1k
>   hw/or1k/virt: make virt machine available for or1k target only
>   target/or1k: prefix symbols conflicting with other arch
>   meson.build: add or1k-softmmu to multi-target
> 
>  hw/arm/virt.c                  |  2 ++
>  hw/m68k/virt.c                 | 10 ++++++----
>  hw/or1k/virt.c                 |  1 +
>  hw/pci-bridge/meson.build      |  4 ++--
>  include/qemu/target-info.h     | 14 ++++++++++++++
>  meson.build                    | 10 ++++++++--
>  system/meson.build             |  4 ++--
>  target-info.c                  | 10 ++++++++++
>  target/alpha/fpu_helper.c      |  2 +-
>  target/alpha/helper.h          |  2 +-
>  target/alpha/translate.c       |  4 ++--
>  target/hppa/helper.h           |  6 +++---
>  target/hppa/op_helper.c        |  4 ++--
>  target/hppa/sys_helper.c       |  8 ++++----
>  target/hppa/translate.c        |  6 +++---
>  target/microblaze/helper.h     | 10 +++++-----
>  target/microblaze/op_helper.c  | 10 +++++-----
>  target/microblaze/translate.c  | 10 +++++-----
>  target/or1k/exception.c        |  2 +-
>  target/or1k/exception.h        |  2 +-
>  target/or1k/exception_helper.c |  2 +-
>  target/or1k/helper.h           |  2 +-
>  target/or1k/interrupt_helper.c |  2 +-
>  target/or1k/sys_helper.c       |  6 +++---
>  target/or1k/translate.c        |  2 +-
>  target/rx/helper.h             | 12 ++++++------
>  target/rx/op_helper.c          | 12 ++++++------
>  target/rx/translate.c          | 14 +++++++-------
>  target/tricore/fpu_helper.c    | 12 ++++++------
>  target/tricore/helper.h        | 14 +++++++-------
>  target/tricore/translate.c     | 14 +++++++-------
>  31 files changed, 124 insertions(+), 89 deletions(-)
> 

This is v1, it was sent as v2 due to reusing branch name.

