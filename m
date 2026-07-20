Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50CAC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlm2k-0004He-QX; Mon, 20 Jul 2026 07:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlm2j-0004Fr-MR
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:20:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlm2h-0006BO-KR
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:20:17 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAw3fQ2377666
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O9OhPEnLKTGqWvWkUTBP98bVB6cW26RkxD6Wsctd9PA=; b=CRe0i4KLes8zKpcW
 hbLK/+PQ/xcjZbcrVuD1lo6BWo7EHlGS85S4gYH1JpPkOKKRJsFxFdESDrzD8HOU
 XN4wp9vv6MXf9MXb+qxYphHLYFEu7CBxlbNqQC2qVzxuq23+7ZXXkdsvK8wvMHE4
 iPfqDUqP1C+mLRceR7y2cge5kfOmLG4PpHAIJaavg2ymrAWerLWvTPFQWatShk5A
 M1+0ZmmNLXKLUvHKcdlMtluM/hEL6cCnnr/aeiaA7o1ZvwTzxy2EZgdHKiFZI/xT
 xgGHGOD5iRle38gnnLmNSVRg4tfni9LKFA7onvIADL9DTSHoaGbsPNhrWLKsrWXs
 /cqHdw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgre8m62-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:20:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e4f946461so1802667785a.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784546413; x=1785151213; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O9OhPEnLKTGqWvWkUTBP98bVB6cW26RkxD6Wsctd9PA=;
 b=DGU2NvsN7TI6VwFuhCI3wFE21Z3i8u0ESnFsV3zUge3+0UzLOWuhw5z44kO13kPtKb
 uitWVCQaFmQ/f2YxrPXrKFbiH2CHDhidtJV2RuD4RKfwELvDKJQ1K4s1gvVaTSHUo9Uy
 GFv7EzCiR2q69VDYiDoGwHcuG6h1txG7hS/PyusvOUcVcTJ/bGmb3gBG6TY19CJwfuj1
 pjLOM+E3nBzOJ/CjHBVfSMBP+iopZ78eYbjvQ6icnXQfxyenwnhOjEPkErOfle4MMTVB
 zOmo4SBm8r070Q3c+Dt8fXvnDrV10pda9uRWZ+3qR7aKQrLGXBufikRJyqIqGcwukYF6
 S6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784546413; x=1785151213;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O9OhPEnLKTGqWvWkUTBP98bVB6cW26RkxD6Wsctd9PA=;
 b=Rj37qaOdxp8ELaW7LRunFwbFAaePC9LLeQwmg4sizn4SvWsy7rrdK2/7VrNxGBZSxU
 RJznw0tOCMlg9IBUWNryw093jgQQjl4XyHY5Xbh5msheshVmq4gOZVJbyyDktjVHITEk
 2N732MhEXtr1FXpdjygzi1Qsb2twPcIyJpXw+aW6zNKdqS3U01nIo6UoC2/+4AJv2cD6
 QRh6TL7X2IWBJmc7XWBbH20AQ3GUVkX70LNvZ0ZLEnZBdTf7MLKxoGNg3X7xwWBm2Qfq
 P7IAdfgqh/knMDIdP6ESJ8EkDHM8y8P6e/S6k4RGegoXhMznJApAnt7DkBlzoK3rEgl1
 ukZg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp113KYdpfDqv9dUBZa3ubJ3ymPAP3yefWPyrVcosqBfTS+3Is1JdZUOEOpHpZRyv4uv7mbTZw/0fAH@nongnu.org
X-Gm-Message-State: AOJu0YzTDylq88ZinHiDpjbBhHXA+SFKgrnb8OFPhaS8REOuLRL6JZuu
 cCXDk4hRKmwONVIgSdg3NMMHgKdDssizplRuJ8eoaGNc2i4Ym6IMwX4afAkqCT23kmOd//Z7BAE
 Fl6mMgP/F3QtTtyReBlX9ehY1saPd1TiymUlBqSpkmtA3Mb9ArItDqs2f7Q==
X-Gm-Gg: AfdE7ck6E49uOs4yveoknfgTv5NGuoT4MtXyCqtMBsFURCjwDQs71K0qSTCmxQp7mn9
 9ynjyh0QI1vSQbS3VRDQnPU1iTOZlo6dMrWs3Wg3iPOO/MvwuYNPf4go5rxUrRtp/SG5Kl+kFYM
 mf3roKhf0W6NuhlB0P1ZlKaRBl7jXhM3ViImBVBI3EYQj7mKfuqtgsunci+1ECZqwFD5wmaDbPN
 6SClbbnsafEP83bz9ZDosCDlYTf+VOTR+yzyUsFwXjQwHx7J+HoX9JArD/zItwv63aQSEOvzJMM
 LGLwoYeLnww20EKloKpThHFJnf5+TVutjWrYEoESp6RibiQxya2E0iGLowqLx6tqffMFxvRrFhj
 IEw/qOPituBUlyzpoJxhAKEuJ6BUnVj17En0Uyf7wvORIz/LMAyk=
X-Received: by 2002:a05:622a:351:b0:517:6b31:8058 with SMTP id
 d75a77b69052e-5213e0821f6mr117116041cf.40.1784546412875; 
 Mon, 20 Jul 2026 04:20:12 -0700 (PDT)
X-Received: by 2002:a05:622a:351:b0:517:6b31:8058 with SMTP id
 d75a77b69052e-5213e0821f6mr117115811cf.40.1784546412333; 
 Mon, 20 Jul 2026 04:20:12 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49563e60fd9sm7244245e9.0.2026.07.20.04.20.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 04:20:10 -0700 (PDT)
Message-ID: <9eb83658-c811-4e5c-b382-7423e511710b@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 13:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "target/arm: Build cpu32-system.o as common object"
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260720100312.119894-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260720100312.119894-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyNiBTYWx0ZWRfX5yhksnIrDcYu
 1Utudy4rWeYJDnjufwoivHIPCI2WqOK2TAvULDKpiuNsX6KpMPaxbN95KtBOOD9EYm0E6hDxNA8
 XX4egAePGMq/NiidSfTd00c0eFJIEdQ=
X-Proofpoint-GUID: bAwSLnj_h2v83D6ccL0xx6rNqt2eVNXN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyNiBTYWx0ZWRfX8APfTa8qa7GZ
 vcXp1CYh57hCNK9Hw9+aztOc7KJNfJ0m/YF3bLW/ZX1jYhvkDciP7E0JwkEu7cwm0AGXr0DQQVV
 FZkjCe60ZehErRrNpNcWEiUIU4K9in+KFOzWnbv2HNYn/4jSPbl8wc4TlFg9XkUrD6/StfYMPWz
 qouR4dslz7fHiMTLVJScVywSqJr8O7h5KvmQOagnZbgGKCLQVvSaTNsCNupr1DeTuueOpQ1Yy9M
 tLyfIalyagGMbyRuR03dQbBKvhyCiWk3kIH2R54wQX1xMXmv6D2nuEYpQfl3GpeupsPDn9cVnU4
 8y8po+zs71J6y+d0Oma7n0mb5nfRWw7BIyn7cLvUh+fK2BSmBNUXviYCsLuefGI5fu2ykn3nE2A
 kVi+lgzH301sothcJX0PLlXnK++ZSGDVbDXWwr0dai0liRd4m13VjtJFaWN/9bYyyKjf+brUrUi
 jL3OCWZeLUyY1ZsGIlA==
X-Proofpoint-ORIG-GUID: bAwSLnj_h2v83D6ccL0xx6rNqt2eVNXN
X-Authority-Analysis: v=2.4 cv=foLsol4f c=1 sm=1 tr=0 ts=6a5e046d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=5ksWg3-Fzs99CpwBcB0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200126
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 20/7/26 12:03, Peter Maydell wrote:
> In c8bea1276c we moved cpu32.c and built it as a common object.  The
> commit message says "cpu32.c only contains CPU types used in 32-bit
> system emulation".  However, this is incorrect -- it contains 32-bit
> CPU types used in both system and usermode emulation.  (The case
> where we don't need these CPUs and which we were using ifdefs to
> avoid is specifically the AArch64 usermode qemu-aarch64 binary.)
> 
> The effect is that qemu-arm lost all the named CPU types except
> the M-profile ones (which are in cpu-v7m.c).
> 
> This reverts commit c8bea1276c85855b2e088b740737d043c8556d58.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3962
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The commit reverts cleanly, and looking at the git history
> I don't think we have anything that depends on it, so a simple
> revert seems best to me, especially given that cpu32-system.c
> doesn't reflect the fact that we do need these CPUs in
> usermode too.
> ---
>   target/arm/tcg/{cpu32-system.c => cpu32.c} | 10 +++++++++-
>   target/arm/tcg/meson.build                 |  5 ++++-
>   2 files changed, 13 insertions(+), 2 deletions(-)
>   rename target/arm/tcg/{cpu32-system.c => cpu32.c} (99%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Thanks.

