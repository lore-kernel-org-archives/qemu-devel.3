Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765EDC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 05:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whKhP-0001Sg-Ez; Wed, 08 Jul 2026 01:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whKhO-0001SX-0P
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 01:19:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whKhH-0008GV-2e
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 01:19:53 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6685Dk7C1817858
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 05:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wzF9mRT6UyPOl062ium0RAgvmx3DnntU+Axm+q9taXQ=; b=jrvg7TN955HmU9Y9
 NEAgMO2ilFYP0BCWeykOvphHuiAVGCj5cI+rV1coyupStKNtvLAmkzVQsoh3YgqG
 puacI7P0Xil/f2msBQlLfKf59NsDCWRdTmcC+sS1rR6HMfRDDO5muCZqZ+3+bI4Y
 EMOWUTPtlU7wAwKXjRvUCyJaZ3eX3/glsM/lpnepcfVeT0Czc+Ps4BU2+wjpsLf1
 k1ghGtUwm4w7ZUbY+fYevY5NgcbcG2gYEVOQFMu845k9sY2BVpv2XZQYqVcY/V2k
 POS9nW4jO0VFaWhQRGItNbQspYMFPFRiW/DqUL3eEmSdm1j+E9Eoq1KZY4nLE0Yu
 +AJ0Wg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9g7hg0fn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 05:19:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c33f48ee4so3152411cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 22:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783487981; x=1784092781; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wzF9mRT6UyPOl062ium0RAgvmx3DnntU+Axm+q9taXQ=;
 b=jdUX6cAw/lhMECPu97TVHIyGHxwaljsJs/0+MK7Yv/nguWQh7XSahUpY8vJbG+SptG
 pIF8Rccu96bkv/OZ/rf6z9R/r10rSWELKTqqQcf11YjnFhR1/A2bs8LckzpNZTjZtxn6
 v7BW+FrhBm8wRXjJZ4YxO/vrTNB7QNk+J7Bw9ktNQdcLYWrx/GKp3T8LSM6cALsrM08N
 5P03vjLqP1hwb/q1JXGG7HgL5a94jVoYg673sAXLArkKHlcmjSRwpKF5wyCdCm8ymzFV
 zNPWpUSPDDmUVbcMqgDy9xJp3p5YvZi1W7chrL8BS6p3JEYoJdRL8UqgAxBmZZBzsJ7F
 WVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783487981; x=1784092781;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wzF9mRT6UyPOl062ium0RAgvmx3DnntU+Axm+q9taXQ=;
 b=Yiu+dAb3cBkjTEkVLyPIHWzShLYvW7VnJNf48om25nhxvhDYsA/WlSKXM89xZLHftH
 vjfC7CIBwmvcEscJxOGITwY+EZDs7w/7gEgUj7/EzUv3g29soybKLCI2ffODU8OdtPsT
 krdzZXnmzIgm2C8wMPcWC6ndgWMtcPyqZB6YbbE+fxtQ3GN/LWBYeYfgIx7/y2e5xAGL
 eo7iee1dzPH86k3dNWeaEy0+VzuaJV5QCt7I2H1hciPL2bLChRTEJ4a61sHZX//WTSaB
 BRnrGNdtr+9Vuf6AUPgljHO6YgnvIkxfRpZJSqP3JIAu/923sLogsOtQBVXCP0u8s0eG
 WLOw==
X-Gm-Message-State: AOJu0YzqfRL2OsHX5HJQmGamXsEaD510MEp3rp9Qf0VjNXCOKphw23oN
 VGnHsTomwINl8ZrG660ICd2DLLoy6jjgMTuTtnFWoK+8XNTefcoLPo5/bqT1DibErbmv+8rV9L0
 GsYNQMokow3hCEuX9N04xwun7wEnZedcFp8BbmV1FzFUt1eeLB3DWp6NXsGWts6Atlg==
X-Gm-Gg: AfdE7clEWHwmR2H1AddVublNJq10WqBf6Spf53CtQJkWJ1Pahc1n//2L9EsyS0Y727P
 e1PQE2R2VFi7mmJpQ3fLsC4EbsBiW9g9uAiyrIeJucRK+ACCKScF8+w2sovOyfdgKIp94LNdqI8
 EWWC0X+V+zQZSE18UFb54vlZumL8QH6Qv0ImUjzRmhyIvrmyehBplaB7jvMod1qPjFIUMBl/js9
 EOsFiCZxS1c14uMyhk1gT22A7QVl+g3NIs4VnZ5fjkoIl5bGMCFw3/zOj9la6zzQV4qp6GYyQeo
 ri340O08kWtkjioIDnNXCyFKHF/cIAxLQSe3X3m4LyzbfeHYsCAsGrsdY4dYaM+KVm3vIVZFLSv
 0cCS/csn+gM6SZqCpVuZ11YpidsGB+w9SExAge4LP8lKod19Vjv2QANJX4Sw8eA==
X-Received: by 2002:a05:622a:1a92:b0:51c:14b1:8e1f with SMTP id
 d75a77b69052e-51c8b4307cbmr10657841cf.21.1783487981405; 
 Tue, 07 Jul 2026 22:19:41 -0700 (PDT)
X-Received: by 2002:a05:622a:1a92:b0:51c:14b1:8e1f with SMTP id
 d75a77b69052e-51c8b4307cbmr10657611cf.21.1783487980896; 
 Tue, 07 Jul 2026 22:19:40 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa09608d4sm40586081f8f.25.2026.07.07.22.19.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 22:19:40 -0700 (PDT)
Message-ID: <d746dfd8-e61d-44f7-8df5-5fab0c8f131f@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 07:19:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/23] MIPS & SH4 patches for 2026-07-07
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA0OCBTYWx0ZWRfX5D6J/t25PBxp
 x85L5L/8rQuugiut1iXmO5/1Ks4BL3Y+4l8VITyGcxOF7fWGedrIxqpPrzdvSnWEb/fK9tsdLfe
 yCztOP9CojZNLB8AQg4OurrSa+a2ofUjZE8zuiYsqsrC0p/GphaVHMBDDuNqa8HIIQMcWtUV1x4
 RAyKja2Ruc6SzW6XVvJkRm9CZQZV1Avh5yXPnkirAYq//doEQfLuwt6XLT/Yb872T7+L/zkrFuv
 hz5rsbnayaUw7u6z3RuBB5iJIaaSv62oNS6fvPoeBxMFIwPfiMHDMjQrYORj6YOG7yfn0RHPtuI
 V/3bJGVLboEEGHW2Tp/QXQGftNl5PD2GQTuvgvKxLF3iUs8y6gHsU2eFU2rkeIH+vLu/DKBqYJ4
 8iK1yn+KoKQymi2yGgXDixNQzHOqeD5vdq0AJL3lmdhras+BF1/GXcYNwIvfvMAphY3fPk12AXG
 36Z2RYWHuhoPpJYBXXg==
X-Proofpoint-GUID: F1DRcj6bFWhHPm6_oviFw9OL969xB2BZ
X-Authority-Analysis: v=2.4 cv=TMp1jVla c=1 sm=1 tr=0 ts=6a4dddee cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=S56xvJB5AAAA:8 a=hXZgYZo4AAAA:8
 a=jqTOf7lJAAAA:8 a=pGLkceISAAAA:8 a=0saJ9Z6s4-OIB6HC3HkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=MH9Ivq0PDQRhlrFuIVvX:22
 a=37BJPeUnzxYkbV1yBC-1:22 a=rFolWk1O-vXzQ6QHWabK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA0OCBTYWx0ZWRfXx7IrBNw7Ppxe
 Ekqr/Bwiev+UGG5Z2Xv2YEMWzZpdMQv61FtvTwNx2KEC6A4I+q8kPfylHk55MCHvjYnWeCw813I
 6+GjNVGZHEo0da709xDMaapNTaooN5Y=
X-Proofpoint-ORIG-GUID: F1DRcj6bFWhHPm6_oviFw9OL969xB2BZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080048
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

On 7/7/26 20:15, Philippe Mathieu-DaudÃ© wrote:
> The following changes since commit 916ab315cc2b3a3825ebb399d83339660144d5bd:
> 
>    Merge tag 'pull-nvme-20260707' of https://gitlab.com/birkelund/qemu into staging (2026-07-07 07:09:38 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/mips-20260707
> 
> for you to fetch changes up to f086625548aa2f839c119243121ef863ecb606a0:
> 
>    qemu-options: Do not list -enable-kvm on MIPS binaries (2026-07-07 20:14:51 +0200)
> 
> ----------------------------------------------------------------
> MIPS and SuperH patches queue
> 
> - MIPS Octeon COP2 crypto opcodes
> - Fix for SH4 FIPR/FTRV vector math opcodes
> 
> ----------------------------------------------------------------

I forgot to mention I deliberately ignored this checkpatch.pl warning:

3/25 Checking commit b5e013415478 (target/mips: add Octeon COP2 crypto 
helper plumbing)
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
   target/mips/tcg/octeon_crypto.c

$ ./scripts/get_maintainer.pl -f target/mips/tcg/octeon_crypto.c
"Philippe Mathieu-Daudé" <philmd@mailo.com> (odd fixer:MIPS TCG CPUs)
Aurelien Jarno <aurelien@aurel32.net> (reviewer:MIPS TCG CPUs)
Jiaxun Yang <jiaxun.yang@flygoat.com> (reviewer:MIPS TCG CPUs)
Aleksandar Rikalo <arikalo@gmail.com> (reviewer:MIPS TCG CPUs)


