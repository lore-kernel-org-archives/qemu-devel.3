Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA89C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1cj3-0004DE-WB; Wed, 02 Sep 2026 00:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1cj2-0004D6-Rg
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:37:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1cj1-00089O-ER
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:37:28 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTLCl2468908
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MukMrRe8zJluv0RqDrJBoU9gI1UhIgXzn3VOLaQjsFo=; b=WidW7ZsSXHuYy0xS
 SKFvYL9/KrxBhbl2mLxNBE/sWU3uAEWBtstMtd2oZ7C7u6Gz/VG1CsO6ITzTQcSD
 nDGQbYDTJZT3kjEwTH18ackwkDVMVl152FH6EqVkDp4XXeNscwDnvAXPR4ByWCMF
 GpPljjRx01oSf+M/t8Q2vtd2oJeZVdl5y+bx0taOzJLF0fnBuNGrvjGmVCkMWddx
 AjdOyotBA71WF9suaSyn1D3HRWGIt3ZU80Y+q1Xc/ISLVQ3z2982VOiyamarPrFZ
 0weKjT+sKslCv9ielB89P3X5fLJOb5H8S/PqxjmlNeA2Ws3ZfF2KsZoFfJxgNgBZ
 hcpNrQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge39cj2qx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:37:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93909014c85so134330085a.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788323845; x=1788928645; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MukMrRe8zJluv0RqDrJBoU9gI1UhIgXzn3VOLaQjsFo=;
 b=Twmpyn0m/pVDCvuzfU//NbrtfwClTovgkp+Ofl8LYu5aOS/DT/1VYHa8b0o1Amm5wL
 swP+LVDYK5nve8pqAOMBaGipQUcDFhoRzWmN57o5vcKCQprnp3A9EX0e39ZOCvDWY7Ge
 0BMaAAvvmRK1w6DkhsZnx2u0l65KmY3MjRzXhmw4sTDozw6By7DBSl/cpIQaP+R1ZQTM
 SfobS5eD0KMxmaaJFslRvtvCmNnHRbnkjS9I+9VkRxRCR3a0qwquBA+NfQ7/lPliRVKq
 WnQo2n1dCw9tylNMFPqz5Cg1MaUbLayR6702JF5H1SGvQwXnRQ+93gxOSmInt+coYMQT
 TylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788323845; x=1788928645;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MukMrRe8zJluv0RqDrJBoU9gI1UhIgXzn3VOLaQjsFo=;
 b=q9UjVRl3VKg59mIHJIaQHaImpY9wjGNibZBq9reLXbjfU9OzrxNK1GB1Z0ycwIj08v
 kYjtQEy2PQUSdqzid0Ewxuy992uWkQG88i3m5B2wiBwbOgp1/DkL/MiIeaxGt4eCndrQ
 8DPiOa0VXXGqnInooLM+tZQhuY1M8wdraVlRQS0vsRX6zTqBfLkflpdcmte+/6w0xRX1
 vacO+S5m02yqN0dLN6rtNAf3lq68rdXqEaALCjbjQrfK0uQv4JCDAIYwuS5iygypd/TY
 7+s4DY9HgNOE7eKHcA8FTYKtCAxiuo58fSIvHtbIv+7GfOIGQ+qxlba2Epdj4E/Umu3U
 17Kg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNGNGEUxBCHIvdm6NsYCi9IM/mMy+AxlCMzzferm5hS3oF+E2sAeYFQeyHI42pKeMFnPwaUI24LoaM@nongnu.org
X-Gm-Message-State: AFuF++ndbDE/KpzSRQ4bM/XqQLJXcQMunvNqKdM3w66ckFT3+le5iku8
 e4nAicsrw3rj0+2yOF4jEb/bvEHzBCh/kTinuSqTPbCDhqyplADbrC5t52FVvlwelOOqp1MvjD2
 eepJx2HDLB8P+SQ7IdzK843Yoy/PQDaKm92ZES9oWmhhtl8Vaywj5qdfI/Q==
X-Gm-Gg: AR+sD13SyUMwge07q8Pydk85q50evbioe9HSdlYHkBozsiV1y0TLOV566R1sFYPbcmy
 HBgNF9H2LrGU6oBTlVpPklGxU5EAOYRpmzvF6ihbizeSr3jBHEme6mKmiMXWH/LJRr3ZQlecvsK
 j2BK2noA75DJtuZuEmBZ7WkU78ErQ1HziaQWKIKem/6dVx/c4fg03ePO57IsbmpbBcNEy4A8X2W
 vwIy0+IJEf1snNvjtDyJluJ5xCvzpdlRmfRGIiaJ2rMGF2PIrf7KXMpIVeowGJFN8GsWwNS8CTv
 23WLEdLw6gszHfTd8dLIUsoU4+BqQiR5g6mzBzCrHqNAftYWCzvig0R0v7IMCSnNsrksfus4WRR
 xtnSx/VgAbqkFjwr0yYhCIgO1mRWWm4Q5cQ==
X-Received: by 2002:a05:620a:8d87:b0:936:a407:98bb with SMTP id
 af79cd13be357-93960cb9f31mr192362985a.9.1788323844744; 
 Tue, 01 Sep 2026 21:37:24 -0700 (PDT)
X-Received: by 2002:a05:620a:8d87:b0:936:a407:98bb with SMTP id
 af79cd13be357-93960cb9f31mr192361785a.9.1788323844314; 
 Tue, 01 Sep 2026 21:37:24 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce45f4f93sm36319505e9.0.2026.09.01.21.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 21:37:23 -0700 (PDT)
Message-ID: <e5a17a8a-2e7f-4216-96a3-9d2f14bd2934@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 06:37:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] hw/arm: remove TYPE_TARGET_{AARCH64,ARM}_MACHINE
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <20260901202043.26532-8-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260901202043.26532-8-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=T968ifKQ c=1 sm=1 tr=0 ts=6a97a805 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: e7hq1dLQV8bOjZR3XD5JAS0zgFihghXU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfXz0zDg/58mNhJ
 FJy0yAyq6mlI57lZN6c/UmQOTeUatKqGNGkEaZuwofRKQ3FC4Lj3oZM8RGXfImdSz+l4kRTopk6
 qSLP9QuAoHVDU/htsCDEoROXoAjz/tI=
X-Proofpoint-GUID: e7hq1dLQV8bOjZR3XD5JAS0zgFihghXU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfX8/IyLcodr75j
 2PV9tfTziiw69h6gYX/ybwjpGbhrvDSS0il31U4GpVZl3IP7GaGVr5kA8Pyrl28nONun+0nWWaP
 lq69XoLphfOeh8jGyv6rx3ogVse6Tmh8IApi60a9lejyzV7F802o+/uOsK7LhCe1vtId0+GGOMG
 VrAOUuPoE3HGt9hGh9/T7UMw1Fs//9Pu/pc1DpiGeHled8w+OCtYeXZzhyI1dcDx3CHwo9b0c92
 1Fl9eJ0CqOrSdYOO6EXapOU6Xcj0NSdrQR6DW41ZCNmDGoR8dTvLSU/kJzhDtrZjCMcQ1FkR+vG
 D9pYdzGQTe8sq2hqv7sPp9H6S+KPFR2E2MNppXqI88JmNuwpw596FB2cjOrJrO11f9KZq4SBmvW
 KHIVnY7qT1qhhTaNm4pttYaTo+v/RtS7ITeY+ankCVsmYpnUsWOVlxn6T+hwLIoyIsMhIS/Pu9a
 4fk5br94oZJKm5s67TQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020039
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

On 1/9/26 22:20, Pierrick Bouvier wrote:
> We don't need those types anymore.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   hw/core/null-machine.c        | 2 --
>   hw/nitro/machine.c            | 5 -----
>   hw/remote/machine.c           | 2 --
>   include/hw/arm/machines-qom.h | 6 ------
>   target-info-qom.c             | 8 --------
>   target/arm/machine.c          | 5 -----
>   6 files changed, 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

