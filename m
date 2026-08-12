Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8807DC5CFEB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGLM-0000as-LD; Wed, 12 Aug 2026 17:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGLK-0000Bp-09
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGLI-0007o2-26
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:33 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2SML246406
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vvKhPPo1PodGZTWBcV3exYJ00sm/DXPnXhGuxdQP8fQ=; b=pNl8He/dG3UHRb4c
 AGkTmVrA4HG3f7+7a7zAqVU3oW343/Fk9kdd4Uw6w2sTM4o8/C9+r+nXNcqonePl
 ze3xGpGCQcJ6KL95X87SC54+Z1hJ60LOVbsIMZr0yFSAMkhJCAyp9TVg883jCSmh
 Evkszo0SRq6tY0v9lGk6tagsULJPY6VZdWnZ+/2uQ9UUH4dnjRPHk7HqLkKLMGFM
 3D8qMgJ92/wNqJxEC7KovBb3Ms9n8S1AKs9t1Wqq3FeUKt722VVELK7soIhV125t
 h41ybJS7dJnHSitDqZiHUg0Q+wpe1rndVAWmD1UmpGqa8TJrAN88y/oe9k2UyKOu
 kbZpUA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0uts1eps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:18:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52ce3c7cb2eso24875311cf.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569510; x=1787174310; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vvKhPPo1PodGZTWBcV3exYJ00sm/DXPnXhGuxdQP8fQ=;
 b=Qa7AD7OoKyG9LrpSe+RBY35dl1x1CUNpUy8ekJKgaT2uEG1PU84lsd1XoAXRCaPkUs
 ZeuvMzZf03GCuszOfwk75ty0GZ1YIo1tVDKcrkFAjOXZI2c3YjO1AhYEjqpJaTZYBQwf
 XuRq4oeAg8KMFlaNFcGmA73rEvbaTVv98J7vnJjjrdgbfYBYWY2rRMbWtUUSVUq9asj3
 RrzJ5WmNVhVvpLu2E+Ga/pgrWRJX0qco7psUABaq2Sya/gN4bV/FRW8PNVVINQWRjV5z
 YdI16MzwX8gp7NIyvWyD3E1Uydlg9fi/ZW1IzEzlc1ULLLpnX2KEKBGJkvvYdfjpIp4g
 byDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569510; x=1787174310;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vvKhPPo1PodGZTWBcV3exYJ00sm/DXPnXhGuxdQP8fQ=;
 b=NjMWDFSTm56CHzr7jqWXR37X72y5626lcmlyCdU0O5kUZNWU5eF4mzmXxZUgFDSBFX
 9kwZaElikqxNrIhtNCnUrqDRTKwMHc5s5zWTOTlN4gFn/vX+x7DeS/zMP1i7SuLjiRdd
 lrwq/3LUy4J+zo+/FSm0flUjvhqXZ3S4CV2Rj0s+Z9vLiRPuZfDMAo6T9gNWYXL5z9sg
 AnjG1rlwYtT3ND+2PC/2Knf9jQl+TeMdcHQxDRNEn30MQokLHQ/9N7OscxF6+ReZX6oH
 5+3LQxnv9lAKH55uwRRQng+bkFXqJ/+9HhvWMJzHUDbLw/wjL7FM3PnDvmAUAotIbZdR
 6rKA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rphb/2I/UrfNSUJBQ9OgriaEdCR969rodgoiRrht+Emr3SsnOwsaOZvs2UycQMIFXDQzJIJzHk+JsHX@nongnu.org
X-Gm-Message-State: AOJu0YwImpyNhZZdKNUDCogm93YBqVMkF+Z2vZkfWph9Q/+6fK5/o2qW
 3nB+PmyTGZHT5555GVMMfaH8i4ZQx6dv9krj3v4B9arHrFtWK6i9Wx46q4x4jB0VLLSiL6uS54m
 AY2KgXaKJEsAdEcwEDnXgq0YO8WVwTqSj/qjGXfr5gv8+w4phbKPYQtKi8blTiIcj6Q==
X-Gm-Gg: AR+sD12vdRFcSuIRhwsTyC03QI8cnqJMLvQYSHzhT7yz1fJUjPVLibZpYDWCyOY55Pu
 4R4NzaPR9TmtXME19b6nB42dSb8u/k3rO8JVmkYFxsX6QpGAMo7Tr9JO/RpVnqTlzAbGSRuYE5r
 ZKI9atnsD6upHFJrSSVxwI9LZ3uNgzn/u1Z9MNxspFG/ihNpsOK1WRayQcqMWlX9b/ff3FD973I
 byFB5VkgAVFo6twQbIFAAZirWVM58ucs98Uhvt+a0jSjaKZV2xJIC+saPZpYLZKTHtfNsF6LBj1
 Xe6LHbCQoVTPq0iPxCADjV5odBw6iyRc0QA/2diTxf7FhzPi56teuDB3rklL6bn+mIZQw1a0Hcz
 NKPfeT3MfQcUW0QzpHULmcvRo/GBbbtv6BH8=
X-Received: by 2002:a05:622a:1354:b0:527:edca:8761 with SMTP id
 d75a77b69052e-52d73c79dc3mr11865621cf.19.1786569509716; 
 Wed, 12 Aug 2026 14:18:29 -0700 (PDT)
X-Received: by 2002:a05:622a:1354:b0:527:edca:8761 with SMTP id
 d75a77b69052e-52d73c79dc3mr11865331cf.19.1786569509375; 
 Wed, 12 Aug 2026 14:18:29 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499821652dbsm5647325e9.9.2026.08.12.14.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 14:18:28 -0700 (PDT)
Message-ID: <f5f09dd8-b562-4c6f-aa29-92eea8057c41@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 23:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] target/arm: Split out aarch32_max_tcg_init
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260812204435.295067-1-richard.henderson@linaro.org>
 <20260812204435.295067-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812204435.295067-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GCBkjObfwyB4BYIiQUUBZRYyWrgQWLCx
X-Authority-Analysis: v=2.4 cv=aPDAb79m c=1 sm=1 tr=0 ts=6a7ce326 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: GCBkjObfwyB4BYIiQUUBZRYyWrgQWLCx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX8mQR/6XV0GUM
 xHba1KAhkhUciwzhio4EEhW9FkDF0eAq94gENGVy7nXxHOnmRLhgKjAcpZUCZokcv7H2Xes7nP2
 Zi6qs8Acpw5oQc6Im6UsnqvpuXc6tDw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX9wQRpwA82Ico
 Byg0OyLCVHG0qxIYpsmXADJJnewPpitR4r01SIcZKTRnglrItrbxdbrrCC4h/LcjzQ5hy1z6179
 o7Jxbut9orOVDzLDQgXn8wFbN6ZPi7U2xcQ098xolcEgJLqgBxea+nbLJQzjb0c9Itlib6uUyJd
 bC43z4yOYC6heKvNfNo4YyYDeKnYgYyrhM6o7KmPfBVb5x6Ef83RC5F7nXega8YiextZQZBZ5P9
 ZqdU4JgupxG0RKjQZQ2iC/FUa5499vNZrh9h3vlfmb/tvxRR9FMG2JP0xo17EQA4lG1ff+oOyq1
 GKmnYWGxwWYRF5A0OG33KarCC2Qsry0oAPxiQKpeZX/98rraafrnRip34lVl6e3iHf/EtdsbLVC
 FXLyasyHAi8zxjy9yNg5xtTUHm7vmet7NuXzg4MNGxew3Ok8/hNCm0fuv3MCEyEMOEayA8EkmxR
 Ejc+KPIWHBYlrkmOQ/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120171
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 12/8/26 22:44, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h |  1 +
>   target/arm/cpu-max.c   | 16 +---------------
>   target/arm/tcg/cpu32.c | 15 +++++++++++++++
>   3 files changed, 17 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

