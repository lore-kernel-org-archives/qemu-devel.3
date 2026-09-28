Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD34CC9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8Fx-0006OV-58; Mon, 28 Sep 2026 06:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB8Fv-0006MF-Fo
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:06:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB8Ft-0001E7-Sk
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:06:43 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MMI0806308
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CljvZEFQAdMtbaPvMfiOFg0AK10LzPiqYmEnv2ZTMec=; b=djzaeNZnmtCVTeAv
 Lq7uI+8RAd3leXu7xRDaDKLPWuDKlNt4j+ajhWfnpZpOG6jVFa+vMuArlYvarxwV
 ABgEHuGWhHG76DzkYnNRCu+H7zfEQPLDXUfNlHnbiqxQlvMUc36BlyCtHeCcmVo8
 61bVeIWG2fiqM/mGerFHT591byAiEA5Oa9XRrL5wqvidELump/7KWbWAz9cVmKXh
 x9iyBeGsSRoQ9Z3caRFwR84fIcwYUTPQpkkFRfisOQUBFEvCfg7RgC5M5SAdPu5B
 tc73WB9rYus90PXLo/XCgAEfkh8DoSus9y1r7t+8er6HmTgoGYec5F9az6UmR6JZ
 PMCIqQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyk5mrsnd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:06:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a183a0e93so631248085a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 03:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790590000; x=1791194800; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CljvZEFQAdMtbaPvMfiOFg0AK10LzPiqYmEnv2ZTMec=;
 b=DjFAt177RladVfIk8RDPgppzsUa5I4WmW7VIFZmJecUsfplqv3M2b5QRnFpU3ng8sR
 oC2dB3TDCmpORZQ7e9OLsWesT456KPQ7HzATAvOwNCNG07QYhG0YtTu/mJZsvm7mGOaS
 nLjGZWYOCqa2aiABdXIjsLP2NKOTpARMuhJiGRIXXF7L/bI/t7JT7UEp4Stvcx++jL8J
 nRYoACsW0VOWEm+v65dZaexULInyqyli+N6EeyBPR1qKjR6Hd6oU9W/U3vYsWG2y4C/N
 5Zx3Oxy8aeU69/9rg7aiWxsUWXDF6ZYJd8THDRnDQPDIYL7+Dmiua9x9xblX+H7i2I6O
 Bikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790590000; x=1791194800;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CljvZEFQAdMtbaPvMfiOFg0AK10LzPiqYmEnv2ZTMec=;
 b=opj3EwYg6LkDAwyowiB1/Tvjzw2OFdjiBEFAylOiUiPND7VFCcoB51iArXunfVELOW
 Fz3XZWyJ35c5x1H2mCH4c1R74NRNPM/njtzcV/wMD8zGYMjYETzF/zBwc9IQ+alJOhRF
 pvbgB3vviZMkXXH5R0fJwQ5PTFRs122Bxd2BO0W+rRKYDJWKI9ouqhtPoexfQgLwFNnh
 L11PDZYI/O8AgDkj9IIRS0HQjf0GqNGb2HoQTzmgvM9K4xHXH4x69IRRGco+7n1qSpup
 kg0ADR+ewcoeHWaKot9xtFz5ZhBQsxC47GmhV457AKk7lPmUnNLx0txIa9nO+wLkQOMu
 1MqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJv52yglVSOecP9+kHd/HWNSiIJEbgaZrZsdKDCPM7+QHqjWWQ24ZD12t3SuR88Bqz9NBWHQ/mSWUT@nongnu.org
X-Gm-Message-State: AFuF++lpEWWiM+x9SewxfRcmMRG7yx/3TcjuK/ZS01yf9GVbdlMSJmhU
 k4ahVkjg1lZoax+JfWBo36NvfmUFEE5YCGk4sSlTViho+N7fGud4LEK8MmOSR6xri7ty4OSjIg2
 5ce43HEuK0BYonYa7VPDemesnMAJIW5tGbCWICBoMR3EvyWYyyI4dD7r35w==
X-Gm-Gg: AYBFou1hHwE9vx4qa3g1ESCt7PEDB/QB8TOfHT747gvT0iLiM3WkbYHcNeAs3lUUFkY
 UG131piZIa/8Rx0s4g9aJgtc4PdcgE2MK15PmNVUR+AglJ+bg2KQGupfYH7woVlP8FeSKxHPjBa
 IlxMaHPaKyciUQoWN1UWghxx9jv7eOqZWLOVYAGvESBO0RRhMVUvoz9u4eQ/oqTB+0KGQLqts7W
 yoX/82KR2fhMCLl4sHeAix8lMV0Zhgxga5jfKfT4xRPpvFhETq5dDp+TPDcniXApBsoxKT+FTDB
 AlO3bBowCnL7OrxrmNySLEM0BXr0eveVMG1fMe91CvMzZ2IRSrk4p8uPNChu2m4RVSLq6gjBFrr
 F8hUfFusGAjoj/sPxghnKKHeZzBixkorjNA==
X-Received: by 2002:a05:620a:2548:b0:93a:2d07:142f with SMTP id
 af79cd13be357-93c43b833c3mr2024215885a.7.1790589999367; 
 Mon, 28 Sep 2026 03:06:39 -0700 (PDT)
X-Received: by 2002:a05:620a:2548:b0:93a:2d07:142f with SMTP id
 af79cd13be357-93c43b833c3mr2024210785a.7.1790589998880; 
 Mon, 28 Sep 2026 03:06:38 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a3625ccsm28028826f8f.22.2026.09.28.03.06.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 03:06:37 -0700 (PDT)
Message-ID: <b08562d9-cb3f-4e91-a20b-794576079708@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 12:06:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/55] target/arm: allow -cpu host with Nitro
Content-Language: en-US
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-16-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260926070057.1234-16-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iY-lh6DgCxccOPEvcrQP6f6DW6qZjkea
X-Proofpoint-GUID: iY-lh6DgCxccOPEvcrQP6f6DW6qZjkea
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MCBTYWx0ZWRfX/78NcnH23GRF
 t0S+VCXVvBQ0HyI9hxU33n18CsPDZzc0yQ4+Y9M0qdr6B9FVUMS+hCf4tPZyZG1QuZaVZMjZ+Kg
 RXTrYwZBbQyZOxNhQdYj4iV81miw+2/5i89Q3QBSdcElSB9Fx/Ljb01+ehuArw16gncYdKKz052
 EaAhYT6zKqMtwv0gHDP9AD/qR8VFf6voIlICchbjY7zqp9kj5q+kd3b4IB5qAlk33WFDd7hctWu
 p+NRp778LnzCqH9zux/sa19y/2KD6n8szde+SBNUcPpCtuLng8NxF+UU1p0FmOEzPD7KaDsNF7/
 hxy1d3De9s+FwqlwI88Knnkjw8TicYfFs+NRcMmogY/zw9vKPpaiyBdkw2/lsaAfIFUkwXjHyIW
 Jh4Ara9MXUndy/ofmDuRTe1zcZCjXYeNggwGOI61SjSYvwSB5mHOnaGfVlgFJYiGsC+YiQM1tFL
 zl2zLEuiHdbQ/pKvmyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MCBTYWx0ZWRfX/nyB25rm18Db
 y6cEBaXJm3TtZ965iDGH3s7eKKPGqwqCFSD1fPHwfcz3qxifXAVZzNL0Oh4rga2LjumYvVqjeBO
 Q9KO/FFPAxf2S0xlpx7Q1SJ3BgkYBM0=
X-Authority-Analysis: v=2.4 cv=asYnmiZV c=1 sm=1 tr=0 ts=6aba3c30 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=ZfbxjF3Mmzy_Fv5pO5cA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280040
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

On 26/9/26 09:00, Yonggang Luo wrote:
> Register the AArch64 host CPU when CONFIG_NITRO is set, matching
> the existing initfn early-return for nitro_enabled().
> 
> - Add CONFIG_NITRO to the aarch64_cpus host type guard
> - Treat nitro_enabled() like the other accels in realize
> - Mention Nitro in the host-CPU realize error
> - Set host_cpu_probe_failed instead of asserting when only Nitro
>    is compiled in and it is not selected
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   target/arm/cpu.c   | 5 +++--
>   target/arm/cpu64.c | 5 +++--
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 090470da40a..c138c4c0587 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1835,8 +1835,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>        * this is the first point where we can report it.
>        */
>       if (cpu->host_cpu_probe_failed) {
> -        if (!kvm_enabled() && !hvf_enabled() && !whpx_enabled()) {
> -            error_setg(errp, "The 'host' CPU type can only be used with KVM, HVF or WHPX");
> +        if (!kvm_enabled() && !hvf_enabled() && !whpx_enabled() &&
> +            !nitro_enabled()) {
> +            error_setg(errp, "The 'host' CPU type can only be used with KVM, HVF, WHPX or Nitro");

if (!hwaccel_enabled()) { "'host' CPU type can only be used with 
hardware accelerator" } ?

>           } else {
>               error_setg(errp, "Failed to retrieve host CPU features");
>           }


