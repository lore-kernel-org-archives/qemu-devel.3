Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1A6CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 17:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNw5u-0004Xs-Le; Fri, 15 May 2026 13:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw5s-0004XO-3c
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:13:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw5o-0004WC-3d
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:12:59 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBI1pv655050
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z4G45KNh5mtw3tCQnXrBJ09n+JWxPWHf+JyDhgCO5LU=; b=ZW8vWGgDqGqjEjiJ
 aQ8EyWg7mcPuKzlJuMiEfmCSfM+jHE/O0S/n5LIrhGkQa2I5po8wc+ucdPiNF4Rf
 OVPa4tjuDMlpPjvUM7ynEfx9ENmmrrjYhUFzz7zJgXaD27aLCQ+LW2Lmyvf0f8fP
 aCUk5G5c7o6Bp4n6a5PEx7MPRT1cgLyhzvOZ8xfgV1q9wzCG/xrOFxOvN0D+vsRR
 kIuk3fSbkraALONPeqtQAe6jyyi13r1wz8ndviU8EqBIBqYtrANyc1KPikStFpbZ
 CsQGtLWzyc4fs9Ef8tw+/5iUwfIdfdhiTr9wGZDEQwBh9NaHBueBWeslmbjCJcej
 SpyX1w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1pv7kq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:12:53 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2fe1cf409a1so76192eec.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 10:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778865172; x=1779469972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z4G45KNh5mtw3tCQnXrBJ09n+JWxPWHf+JyDhgCO5LU=;
 b=acC6PgVeJ9NzqB/j1g5U3TstguREdyQf6H5A+ygdluSnnyaecIgA2ABKUyRXrD3VR+
 yvlXNtXpkabUQnTWUNV7jimbGFT6J7CfNDqTdruYmhnyhIjGH/8Z4XRpZjkpnvBoG1eL
 8QLZZSmJiuP8merhBeEMMq0taKXg0AKiGaMEo+9X/cQQ//CG/1ZjapNTmlEzGo/nmhGe
 vFlAqD6lCJm7RjR1nh+65kHC9qXl2MAhZr77FeGB8UufTCUdwT8MT/SYceZe4UggkCii
 xg/VBD4hUxmJ9MR1kdzzgkU/AomLnNoXezS0NzdWkIkqiRnEUy5nUl/J/vbcQe5PGoCM
 kXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778865172; x=1779469972;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z4G45KNh5mtw3tCQnXrBJ09n+JWxPWHf+JyDhgCO5LU=;
 b=p9dRfbFAkajawtUvafj2ZmKpmy9tAdzdfaEJtd7Vuf1G7dtFdFB+tdlddnLHWrZ9DI
 +zK1CDpQA+gLh5kt0dSuuB/HvkIWnpGshDHTtC/gNXxxD6iwlYvqJodFFM/qwnoXHoGk
 jgA0XQyUdrIok1WfqTe7lsvIs3cojqFyiiPcCFB7YId0+faI6dVdXselYDrC0Y4cr0lE
 7mgjozarFEZ/iQaLDd3sPR33Qpyw6W2l+T8NnxV5g8tW8J+RBEc/9rcXixiiqtx2PSO4
 TWPYmruvshA1AdQVKTM/YoVYqidSoVijc68xjg2cfprJOXuv9HopFZK1d5L013+fUwxw
 g1nQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+R5G1s56nVU/X+bZ41qx/tdqBQ8K3Rrl+S6DwlL/YzVlFRm+PO5zCgMNKh/l2jUpTwbV0PWmS+xRKe@nongnu.org
X-Gm-Message-State: AOJu0Yzg1Ppwxeg9opCRrbgYZZcIC2k4629oSzBKVecuuZIstYIjMOIP
 82KmHAUGgTrvSU7Dz0Y9oEkdK2qUzW1OHG+7QGhSIqRfFNy6dny34ofdz/poJPnr79l+ladsMsO
 OuoSxkqla+TgJpF9ArvbMghTuYXG430+CIBI4WmJaamGPBQe9/hFoCx6SFg==
X-Gm-Gg: Acq92OH9V4eXBVwV7tXogX1Wu+kW9EnO4k4tR9HGW7RrRkAZNcL9vdKk+6rArGzEcvt
 T+AQGYcRg5JCzAjJPoHJ9RpWK3GVqiVFnjIbHRIVTNJ0bAF0Y/GXYNuulIN+rc/u6O7V80ucPMM
 PwOlN/J8WbqNU72c+v00d0Q1S1lFl1r1YjxuI2EvjSKRgoX6bxl5KzWMT54JlHRAOve/aHHpYvN
 SXiY3MwBDXH2jsxrLIK9lub+v8LMt9NMC1O2iNSMov/3xj95ZiJuhsPwqtVcvtuGlsuZIxm/99S
 2jZcwoW/jjL5zJfBXR9PcVdjqtoTkpwTyt6rfXHQR/2OIw4m1+v6WKxNUc1RtLB30dSXd0qnMUq
 EEjA4KDL0iYb2e//hwKQ99pX1+qtgLB+JzdnNPTJAYg/DpBNKp4tcJxb6BvX19Gxii05ph9/axk
 OSxH6xcmFRUi+QRiVeLLfN86K8
X-Received: by 2002:a05:7300:7255:b0:2d0:239a:23c9 with SMTP id
 5a478bee46e88-30398677161mr2544241eec.16.1778865172398; 
 Fri, 15 May 2026 10:12:52 -0700 (PDT)
X-Received: by 2002:a05:7300:7255:b0:2d0:239a:23c9 with SMTP id
 5a478bee46e88-30398677161mr2544204eec.16.1778865171735; 
 Fri, 15 May 2026 10:12:51 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcb6adsm8548774eec.15.2026.05.15.10.12.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 10:12:51 -0700 (PDT)
Message-ID: <1866da2b-774b-4c55-9ada-dbeff66f2d20@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:12:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/20] target/arm: Re-use common
 aarch64_aa32_a57_init() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-18-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515141032.3271-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PlMXV_xs3twW7GyRy7kml0Jib8OHQo8k
X-Proofpoint-ORIG-GUID: PlMXV_xs3twW7GyRy7kml0Jib8OHQo8k
X-Authority-Analysis: v=2.4 cv=GrhyPE1C c=1 sm=1 tr=0 ts=6a075415 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=yCTr-NPhZduzRAWXByIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=PxkB5W3o20Ba91AHUih5:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NSBTYWx0ZWRfX2pJ+rUmeDBND
 BB/Tz2YsZ3KDEjUIhe9SpOHNFt/sS5aQNB23cHQh4HuYB7kKAasT9C7wJcgwXFDizsucdIzRN40
 Ly82OcsNjfyj1hYDGkwGB3LgAFV9ihvjh6si9KUuQ8dD7E4R8mV0lABYLfNL/G2+Q6ug8jWGkof
 PEGuptx7so8O2SyDsMI9AzxsG+C1nkYHxGz8+fRU0Kc3lBXsYqLGD1acLdfIPCJknvg+XYRdjn5
 3p6nOO4fdRdJzdGw2zqiSYZZBG3Stez4uxetqenp6PtgP06gkOhxHoktHstXhcrA6QvZNvq9Fzf
 yXkQ/61wSSuTYFCdo9gLig1Kt++Eowthk93N8ZEvCI8D3ulMQSvx19X5tNofM/VYW1jWL7yvsLh
 1iwPGHxj2I+TXlIhUQX95354FTUIbe9s5iLX7xcpJpyz6ARX9/7BUoBxXLGNJxTjatJH9N8j+N/
 FfhoaUnMWhCoE5u+yXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150175
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

On 5/15/2026 7:10 AM, Philippe Mathieu-Daudé wrote:
> Make aarch64_aa32_a57_init() common by exposing its prototype
> and defining it in cpu-max.c. Call it in arm_max_initfn()
> restricted to AArch32.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/arm/internals.h |  1 +
>  target/arm/cpu-max.c   | 74 ++++++++++++++++++++++++++++++++++++++++++
>  target/arm/cpu64.c     | 71 ----------------------------------------
>  target/arm/tcg/cpu32.c | 48 ++-------------------------
>  4 files changed, 77 insertions(+), 117 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

