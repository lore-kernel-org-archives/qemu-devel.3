Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6985CA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCJKY-0007Rw-Mg; Thu, 01 Oct 2026 12:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCJK5-0007ON-Mp
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:07:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCJK1-0007Fd-CK
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:07:52 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsTR33986866
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 16:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 44gh9W2SuJdAPdLgdjhvXNRTAIjBu3FctSuw4szmWVk=; b=IYI/DmVDJ6Gffvdx
 SVD66JrJ4vG6XcOZXMckuo8QfoqMSCLS0oYxUm2zFAlNYkLdzXOxWZaTqpJGfC/1
 0bM4tgGOOSj73Vz0ziOJgn7CiTS3FYymW8LzZnN8NQM+e/FwT0OZey/Z8HBvMFhx
 R1uRxuJK37l61eRaGyNcOggR2zRF/qCTImknmnlPGSJZtlcSKXeMv4p+vpnL1QzT
 puxmA44p6NvmIj/geT0sBoPmIg6B6MvtvxNiVIqeEDtHvYdHqsafEjGCg3+BYIj9
 TkNS7AE+FGYLukDjC/OOJBtp2JofLKUB65aPIrgOU4RJ8GxtkoVzem57WeOQ3PO7
 pb/qbA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1hvkjmgr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 16:07:44 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34344599f01so7719596eec.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790870864; x=1791475664; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=44gh9W2SuJdAPdLgdjhvXNRTAIjBu3FctSuw4szmWVk=;
 b=ElGZPxqI56YYCbyrf9g6XMMasT/4ayTKIBGc3Nq8jEZjEEyOq0McsX8ZvG020xUm4o
 lgofr8Ig8T/QZAvocFqu2dV/tcSx2U9MiFU8ME+qK3469RMPDf4fBg21n9MWtyIZq7jc
 9xc8qnEoPaoORD/gcdLVPxr6kQWIVdN0KucJ7lL1ZbuVnv8BOcRfZBvIw0pz7pJn908+
 LeSQMHW3dAEK6CKbcDwXwa4qZL+YclheVdR1HkF4fmdgNJ+QNFaE8dfLOLQGIsRM6Nfj
 hhrJCvcCvPbC2gEBHoaGZBozdD3ebiAL/unDQ/xIhcmljL8m4CyFt4aU65bhWtXNeLLY
 Z05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790870864; x=1791475664;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=44gh9W2SuJdAPdLgdjhvXNRTAIjBu3FctSuw4szmWVk=;
 b=TN5Mc7J4txv3h8UYrETt3f2kLTirGvslnVJNBAuHcOUuccBp2Bjs+N2zWd6pPnP6bA
 pYrplDNkGqfOeHrARK4xpdnkJQQTMm6R/62eDIrD9Ry+manP6eQilpyX5eW0XLxJJIw/
 4CiylCoTnhvHm/8H2Bl0MsO2clnq8qAJGxWOAb0rHUck3kdzuRnH917KTfEzBR4IH40y
 f843Xwcsnsj5lGW9WEQZdYdrYE9CjeVXTi6XHb7DHpxuxrEIJWcCMk+SWizZeCsAYJ36
 wkR1KFSVhxP7nBWEAsJ5JRrQB0E/u3UtKFrL1OlEdUWcd8vBlIbSmaXpWZ8DPaNNdZ/C
 tH2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfqeDUlU1FPr6eCcYb0Xo9+MtUqOYfJZjQkG2xrFE7dz1svwfgEV5BHa5OR7Pz8MnLo4uLcCR2PZUs@nongnu.org
X-Gm-Message-State: AFq9FYKiRcPKn0Zh/wMhBAwMPKmLh5aEXeqXI0HTVmwG4QlifI6Ki+lM
 0Zqg1fu6ZwVxsPmL62RdBLOGOCNqnazHKO9mPavwYuhFhzykVFgoxVzO+DhtBngx9b4Yb4GF9Dz
 ndrxJ3MRJGhw3bpSosV+CxFtVuH/JDwvWB5YeE6eZFoPOk5X1tF7Gj0L0Dw==
X-Gm-Gg: AYBFou2cSTHrMg6jLpyhxicz3E7eppu5jX8M5BdrLhNseQZPOKFh7G4CGgWM/Jvokoa
 SxCjltDKeUNN5Vrthwcg9m0hIFctT6BNdotwVVrmjLxdwNlKzBHEuj3XvFwFlpHaSBbRfvRXLxU
 oKFb4OeRwY6LACM+LZDDg7bHUA2zg2Fdf4AFmTfFU72hXAO/MuyvwODP43M6rWwuyREmfGVDLid
 bkCUzozCC4W2umIgPaU4FCJVZPsf+t5wFIJ540ApvrzO8CQg4+X7Ct9ydQ8BpHHJnzBGRj73EVp
 DSbnDmxzMbda9psuGiVWbVp3GGpbE8JCvT0gILpLaQFMy8pduB8VTd8Ju0icS3P4jXnh8n6N2rY
 wRw91g4ekHLz0zT9ZJAJh60aVra6Bq/RZSqFVNFFLOxPZFCIbUrxtYq+yBOhfy4/cDtDQug==
X-Received: by 2002:a05:693c:88cc:10b0:34e:eba0:c413 with SMTP id
 5a478bee46e88-34eeba12b14mr577979eec.7.1790870863689; 
 Thu, 01 Oct 2026 09:07:43 -0700 (PDT)
X-Received: by 2002:a05:693c:88cc:10b0:34e:eba0:c413 with SMTP id
 5a478bee46e88-34eeba12b14mr577930eec.7.1790870862620; 
 Thu, 01 Oct 2026 09:07:42 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34ec65ad6ebsm5474022eec.30.2026.10.01.09.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 09:07:41 -0700 (PDT)
Message-ID: <1bac23ee-6370-490c-bab6-fbd17d437fac@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 09:07:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/tcg/i386: Build test-i386-opt-shr
To: Dominic P <gcc@gcc.dp11.uk>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 pbonzini@redhat.com, qemu-arm@nongnu.org
References: <20260930185124.3036980-1-gcc@gcc.dp11.uk>
 <20260930185124.3036980-4-gcc@gcc.dp11.uk>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260930185124.3036980-4-gcc@gcc.dp11.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2NCBTYWx0ZWRfX+WxgsUxde6r2
 Ejsgtc8B0ZMCpxqeSoSFqJmxrIds8MbM+wdDj9sgCGssZurLCZa9FPSKXaU1eVsQ/GsbRGaoZ4o
 jAGvPEeRkpFnGWfWK6TOBNWRO0SnKoE=
X-Proofpoint-ORIG-GUID: vKLI-Jhr4wq_PLmLe4Kh9M0OCYFbk39D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2NCBTYWx0ZWRfX2z+DoIt1C7aa
 azNl750hrhd/4kEAeH4MnTZFr2w0RdvIdJ/dYQbB+Dd2H+H9Qk9QXuF+3jQK3qSaRd4JCO/qBUb
 wHGqyyHVWicvN+7qnJu6WOegaJQZ8vLTboFzE+rE9E9d5XEWgRj35kN2DCrjGExzVfUT995/195
 qp0wAPVJ1/IFqgJRJyx4hXlAnkBQlEPiIn45Htn3D0TukHLcYOPg/7++Nt45mpo/JKCnc6tQKMy
 V3kaiiUrBz+EhXV7zjEx2bd6grqDoMNgq8Npv6zx9QeiOQ8nojKp5U0HHlqNU6+UlxaGOJyJBZl
 eB9zeFFaWX/ZeCEKFgqbCPTr6I2A4pWv8MWdo14csr3mZEcqkxBdLqg+SV+D01tuJKVmlhI79cj
 ntlEBepPV7Vc1Gvfn7cbpq5HsX3UaiB1+ebPQYHXPwia4iy36k4BEcHKfvf2POHAtBmZQdo8Szv
 bZWVgqCau4XhwoArxkg==
X-Authority-Analysis: v=2.4 cv=IY8Symqa c=1 sm=1 tr=0 ts=6abe8550 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=CP7RdrZA_qBg88vvjUMA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: vKLI-Jhr4wq_PLmLe4Kh9M0OCYFbk39D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010064
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/30/2026 11:51 AM, Dominic P wrote:
> The old Makefile.target built every tests/tcg/i386/*.c.  The meson
> conversion lists the tests explicitly and missed test-i386-opt-shr.c,
> which 5fe51606146 had added in the meantime, so it is no longer built.
> 
> Fixes: b4e3e90d61 ("tests/tcg/i386: user tests")
> Assisted-by: Claude Opus 5 (Anthropic)
> Signed-off-by: Dominic P <gcc@gcc.dp11.uk>
> ---
>  tests/tcg/i386/meson.build | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
> index 4152371a3f..26bd85c05e 100644
> --- a/tests/tcg/i386/meson.build
> +++ b/tests/tcg/i386/meson.build
> @@ -28,6 +28,7 @@ tests += {
>    'test-i386-fxtract.c': {},
>    'test-i386-fyl2x.c': {},
>    'test-i386-fyl2xp1.c': {},
> +  'test-i386-opt-shr.c': {},
>    'test-i386-opt-rol.c': {},
>    'test-i386-pcmpistri.c': {'cflags': ['-msse4.2']},
>    'test-i386-pseudo-denormal.c': {},

Thanks Dominic, this indeed has slipped through the cracks.
I double checked all the rest, and found one missing test for hexagon too.

I'll pull this patch in upcoming tcg tests PR today.

Regards,
Pierrick

