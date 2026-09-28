Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF77FC9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB7hp-0006lc-Mt; Mon, 28 Sep 2026 05:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7hk-0006kV-LM
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:31:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7hi-0006EQ-Bl
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:31:23 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9ME3a954449
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mlLYMWclEEypZifzZbJQKvH45ehRxZZK/lt4vhjXZhg=; b=TCtrFgBH8vm8rsdt
 kfOFMfXyns9RiF5jMzYfJcDJfVc83xirpepe0rKbOgEFK7PJ3b9Ff7xN3YUHKebp
 7VYCPx40n7ZhFYTnCATTMGcpX+6gnbWz1VEyH0L6rXRJHw+Z0WhSGUnVSGGUMKLa
 TCUkjN5xSk1ZR1+YFEG+EP0VYbgZ4UKyfCOuz/XEMo2gh2ekWz9DUoyeF9Kzgajr
 ezLjpJ0pJ8S4H87IRGb+LLBmmOlYuokQW0C4orGr+08/St3qP4G5wkuGnx1952nC
 irMBTsHpy0jaBZ+Vfo5t8A9bnyzUtbzRs1+R0Ygr98Xv/9ogiJUIJLT9+vffqtfo
 kjD7GA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynbc02qb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:31:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-939f248907fso276263285a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790587879; x=1791192679; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mlLYMWclEEypZifzZbJQKvH45ehRxZZK/lt4vhjXZhg=;
 b=gu2FNcVTiiZcf/l9RZpNcbJpSq2DIuvSXRHy7DIRxiQyQPQ+X5i24vpORf5LF45X8g
 uriZwC1swgLRFu6pMm9PzjF2803pyA/ksyFN7v5HzR5Dj7NOumd0oNwqK3BTwOOMhoE3
 hTS7apXYTyZrD3MLu+mdwNxOL3s7YdIe0FkXcBmKc6j1HjDTkQ1HIU8xYAtbCFYaeh/y
 tOHbiwKnlRqXRnXnl7dFcnU3OnpWgmA+ysTM2blB5P5Fpo4C153Sf+z4VCK99ITWLCce
 JcBPSSfoAvM7k8BWQ0cQVg4MNjctbCj1dfVtJVPO7gvfAUthTRPF+HdUTdGTLAWP06fh
 LYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790587879; x=1791192679;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mlLYMWclEEypZifzZbJQKvH45ehRxZZK/lt4vhjXZhg=;
 b=12ioyqxsTyLKVKy0iG6JSjpzlB9PX8J2sXq7cA1nHyMcDuwLIjI09bLazorpJDl+Lt
 WIWAT3AiTjZHfrc8LobQ9w2aqTd14UNcU/UCnKpZW4wK/qGVECixKW31iYwlaajpymQR
 OcAVWtd2iexhScEgA8k298lemdTClEXuVgcwYhDZ/+BfSIM0z0FSZ9g6sfKG+TmrBLgu
 fRc55Mlya/Non8tIMk/AqHAmqEV6FGtQStWWMWpsMuW84jMYJ0rnJmD+RMPWH/wsl8U+
 VoiIXkCEcf8ISQDe+7qCa99squL93nfIAmUE2w0ahTetiI+WQ1aBw1FgRBa0W/XKTck/
 oBAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvVyfSJPbLdVkjFWDoef/NioDV3s12PNusmrUrO09xJpr1QyETbhwW2yw6Tr3zlF2eGLOmVnHlGV73@nongnu.org
X-Gm-Message-State: AFuF++mVgYWY3vhwXHErh5T0drpHk0NEAPp1DUDhU3fKV2unYrrWtqNv
 k2kYXnXAsJ7R2Eqr6hVZfiSpTFyrcRuMnKnKYeSxkY/GrDNvPMCf+h9XzvayhjIi38G0DOat5IH
 bL61SRdbOOtP5DqohvstbXMC12eeGtV4xR+qxUU4Qv3huFQwbGReZnLXfeg==
X-Gm-Gg: AYBFou3NhoS4Wxj38zqyOFZjTZFdW+bhdmfK0shsYAlXB5fZR92rn6qubZicTAKWW4x
 qIOI0emcMG/ZzO1szinutHxZ7Xp9bgZC5KPz4WmPFZzpqTLb/bDXvcwU9Fj4s7BdjACEXLbHbzr
 ydtxb/Z4NBSbsRYF9MWWkAmKYNeyGWKdwoEsRRIOCCdT7peOhM2zyzvpwAWRA0HfpEDtmX1A+lt
 UwJTqHZVR/YImDpd1J1sLqSQT8BQMygaHt+/ThQ/H4EnZ2ueNMabdKHC7Ve36vEIzF7XgDs6TL/
 gW6LPGPPTyt68X7LfB38CO7jNNenRQc5IzZclpLHko8LT9L7ykxcvWESUoKhLcpkR+RLYq3DpWo
 p/g/PDa5LmgG0Vuzor4J59OAiDD9YfmCBwA==
X-Received: by 2002:a05:620a:260e:b0:93b:bce3:5499 with SMTP id
 af79cd13be357-93c43b92b56mr1844167585a.6.1790587878424; 
 Mon, 28 Sep 2026 02:31:18 -0700 (PDT)
X-Received: by 2002:a05:620a:260e:b0:93b:bce3:5499 with SMTP id
 af79cd13be357-93c43b92b56mr1844165185a.6.1790587877962; 
 Mon, 28 Sep 2026 02:31:17 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff13b3c59sm68250415e9.0.2026.09.28.02.31.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:31:16 -0700 (PDT)
Message-ID: <cdac79f2-13c3-4964-96a9-9def889c8eb6@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:31:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/char/stm32l4x5_usart.c: Support 16-bit writes
To: Jacob Whitaker Abrams <jwhitakera@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jacob Whitaker Abrams <satur9nine@gmail.com>,
 Samuel Tardieu <sam@rfc1149.net>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 "open list:STM32L4x5 SoC Family" <qemu-arm@nongnu.org>
References: <20260926175634.2034094-1-satur9nine@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260926175634.2034094-1-satur9nine@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Sq4Fe/O0 c=1 sm=1 tr=0 ts=6aba33e7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=_UJ9raXPv66zcN9uApYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: ApVDyStf020uRCHtgx0Ai0i1qqSMc4I_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzNyBTYWx0ZWRfX8q5jOla0skQh
 0hY4L7yDXL3FtFDTwiCpFYmxgUdxYNR4pQAPGIF5bh10RFLtWzPx1nJs/N3Hw4nFXmpI8whHo38
 uVOTieO3xoXiblP8KrJrGqB3ozK03j1jXhBg0ClzBDHRubbfGFxMY34d9nLTDF1WAdsQ15rv1pq
 B6zDntVyot5trj/q008rhLu6av7DuYkX+hsRMeQlOy8/KmTQ8h1yrYPyMdGmYDufkXUrqlJELdz
 EYWkorEwbmgAf4aZwnzva3N5+tB06jrUZYfakwmFuxHBwluV+uQE4C15QH6322but0jiOi0grMG
 EHqzyTLjrfTSkruYFiGRL9RrmOpHdxVpL/rFpb7mm8Kt4HJRG8QNwGM2HfRsT03okp/MYTkodg+
 m0SQpFQJF2P5GJ3EqFXk7ox5f0kOKiqqgc/5POwhjfM2jPa1n9LOy3IZT7cpyhH8CIP7609+1Tj
 qijXTXfDnuiBF6LKPlQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzNyBTYWx0ZWRfX49+Qs2b/twLK
 mkzT9HPWC4oVKFDS6k9NhlNh33Htq+4Rhx1hvNlhWRxtd38VVz/85uS6H+ALBnuNTpIHPASxn91
 U+V06vaawHFwiuATlpNgRGYq9bKA3jw=
X-Proofpoint-ORIG-GUID: ApVDyStf020uRCHtgx0Ai0i1qqSMc4I_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280037
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

On 26/9/26 19:56, Jacob Whitaker Abrams wrote:
> Official STM32CubeL4 drivers use and require support for 16-bit writes to
> UART registers for proper function despite datasheet claims.
> 
> Signed-off-by: Jacob Whitaker Abrams <satur9nine@gmail.com>
> ---
> v3:
>   - Add suggested comment and set only valid.min_access_size to 4
> v2:
>   - Remove all changes other than supporting 16-bit writes UART regs
> 
>   hw/char/stm32l4x5_usart.c          |  7 ++++++-
>   tests/qtest/stm32l4x5_usart-test.c | 22 +++++++++++++++++++++-
>   2 files changed, 27 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

