Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D87DCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMp4-0003kE-Lk; Wed, 07 Oct 2026 04:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEGlK-0006bX-Pv
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:48:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEGlA-0001oK-Ks
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:47:59 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966eDsu2834156
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2026 09:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CKZY6dr1QfyHdY0tRcp1qnRzKAR67bCprUANDw/LjRU=; b=N+bc9wjTBrUBRWaO
 61B6USZb66/zUwk9emOgcb+5dpbM6v3OIaJMuhgzxs0l7/P71/zq2h4lOFgCjQKK
 yuuniOv+6eZdakZBLgmrLdY+STwQzZQmKX9NPkvDb4WjIBa/IBIqmDIyamaPPGX7
 oWzt0AwpJ2JLlgZeUbRLHpE24VazeNKq+6vqJlxhWgqeyWP728vrGBuMBiUE5Kvp
 lMj9f2LWF2qkiJsyAtp8hc1zX+DY1btqmGcSIX1Y/7dw+Jm/M2bCFvwaDrqqnqQQ
 ghDhVheYcAp3hCuVl1PyZbl9xK22OylGDpSc50Km43FgOVsyh5N5r2lIHnnFcU/p
 FwAvPA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4dnckufv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 09:29:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so508772785a.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 02:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791278966; x=1791883766; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CKZY6dr1QfyHdY0tRcp1qnRzKAR67bCprUANDw/LjRU=;
 b=jm2KJ6W9sMuVl7pWF5Gq28mErelSFaLGOu3jP2OK4N5bUUb6W3MDx2jEkob4v0uZq7
 7Q9EAudqeyHYjFEqeVcCuObOIA/vXIwnsQ3Wn3EFfUFyA5MsgRxAbu55faXR0dsSFtk1
 Ev20LDxuMPp+Ad3ltC1xV/cBokPn/EXJwDx4guTwtFzmVqNbcsllZurHJW2LE9H+QErv
 94O2Ljho6uTEeaVypvqybpAUWANl1dA8PDTYlaVEBf7Mh3LKC7dBfzfDbiCeKoo99Mbs
 zEA8StaZSvEds3HRwgJ+XWcLH8/1wT4KLopy6DZK1DogAZ6IGNYAfPu7XQap96sJwYSa
 iG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791278966; x=1791883766;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CKZY6dr1QfyHdY0tRcp1qnRzKAR67bCprUANDw/LjRU=;
 b=OMa8uWHbGlQHiROQPNiRfACi3qZE8KqZ+781jX5C3QDiay1VJviFmVOqmGBci5b6vh
 hUX7E3Szt01qJDdrU/gzWmVw0HUYvqkpKopB4wag+f6jxYefSwBDvX+ycnO19n6Qbxfv
 zVQjKnv11a+Z+9Wpj5CuwTFlB6ZLd2CkPx97I4sosW0tbAe+mqpjInPNtZl/lerYlzvz
 NmCLBZEgx7v5z0CWZXm+B7EoKjDqmbgriyXdIGuBmID+FJTJLvwz+5ahnSAVjSPn/R83
 rW5x2HVWOW5LPI60bmz+dAiKN+tBgMx5PZ1MwjdB7eN6LTwUAoO6bQaSshaFo4EDBPQe
 QiDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxujcRTzUcpu4+lpNhDQZ0WmSgwoxFtR/lJNkamL1GoIjTV/LY65+nxfY8SUX2nc8OE2ZnPOtIMfkBY@nongnu.org
X-Gm-Message-State: AFuF++ngwVfgMrVTyMSq42KHGYg3ybIUJiplpj3a6/VbgnaIpn3hhozE
 KqdfY8ci8PtwqVA+DAatRWKx24WutEd01BBf7R1J7UVD6YnAPhQFZn9CWCpUzrCFhcbcAONDI/h
 WB0h/NfKanfirdqlh6YgEiwbazX8yKQs1eTMO649YozS3MGcCCT6fISxjDQ==
X-Gm-Gg: AYBFou1DcwGBMXqofr41KI4LodZuj1gYbg+498EKbwnIsR8T7FPU7/NK3EIavJDFFLX
 wQomsBL+RyqftL5a8ocMBC18MwWaiA3RXkjoiqAQWAHIB6c8t5wmnmAZcXw55wLa/k20K8HurYs
 O/rEMZmX1Fw2MVdwlsk2b4ByI7UfCO+VpTGYCo81PWCFKJd/PDSilHdrPsl2GWqndDamXd6MOgC
 O6WXo056I3FyqZJ+gTpRWC4cFuoVInpU79bhcaIboz52gWYb2KrMshG1Dkxd43jz7F0pXUGm78j
 WI+syRLOadnO+gNofxd6QJdeuZZFgsRp2HEm6nuqHIa+U8q2pW/zP4fKprMoh1OJ8rVVGmOct48
 GUr6o42L7lLwrJUXv11GPzvIN+LZLRnHgNg==
X-Received: by 2002:a05:620a:4587:b0:939:a003:7127 with SMTP id
 af79cd13be357-93e8f4f965fmr131378385a.52.1791278966475; 
 Tue, 06 Oct 2026 02:29:26 -0700 (PDT)
X-Received: by 2002:a05:620a:4587:b0:939:a003:7127 with SMTP id
 af79cd13be357-93e8f4f965fmr131373585a.52.1791278965759; 
 Tue, 06 Oct 2026 02:29:25 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c53997sm89812555e9.12.2026.10.06.02.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 02:29:25 -0700 (PDT)
Message-ID: <0e335ff5-be4f-43e7-baaa-f82737cc4b60@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 11:29:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/31] Kconfig: Extract config GPIO_IMX from config IMX
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20261006083445.30362-1-shentey@gmail.com>
 <20261006083445.30362-28-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261006083445.30362-28-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzNyBTYWx0ZWRfX5lSAE40MuG3Z
 ZzrMkVT0r7e4BG9YutCI4ISV/L5VuRw2nm7cA6rxjZnlmc8gq6SueZFMl3tc+3wO3kPmqIpEd/S
 aTA/hscuDBSPWfBKV9jQqF6oPGxXlp8=
X-Authority-Analysis: v=2.4 cv=Vdxir1p9 c=1 sm=1 tr=0 ts=6ac4bf77 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=FRSEYCzRAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=vuw0APNMYSraHH0RoQ0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: CJYAqhdAS0Tmakw4Pim149WtkUEeuJPy
X-Proofpoint-ORIG-GUID: CJYAqhdAS0Tmakw4Pim149WtkUEeuJPy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzNyBTYWx0ZWRfX9TwxQU7qiKKs
 bU1qg5RliE/+ZV5FFqP+ifotAg3x5tEYIVBsHSm3r8fDWd32bWO1vKZmqVmBJClEWKesP85I6JD
 pzgseKTmTsi5suOUWrla8e/qTWJXk1r5q+mh67IsWalqP9WFrlfp68ZDHJ7nAtWu80Fagajy+zJ
 /gKIvUFTqSD+ACtWYa1MOD79Re/BFI6ledXyBKw0MF5peOwH2mzyDCA6QvN5xY609Rb73jsdoJM
 yUW9MCHtGsspacVG5+6DxgOsizLnJWrzgYpbo/5tkokERE/spgj72TdyN9SsJDiuRMLAW0nZSjP
 9BAonCw9OoeQAC3nDgza4H46LnqHCR5aVploW0yhGFCgB0GMGouCDnI4G1TbQusRNEqNJOUO5EK
 KEUlsLQ3C6E+EoD4qBwgLHT97kimvvaRVQyfi/wK4zv+lcZoMLMXOBLZ5H7gkjJVpSbCLaXqsck
 hsjSJxL/UYi8uw9gmFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060037
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 6/10/26 10:34, Bernhard Beschow wrote:
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> config GPIO_IMX to eventually eliminate config IMX.
> 
> Reviewed-by: Bin Meng <bin.meng@processmission.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/Kconfig      | 7 +++++++
>   hw/gpio/Kconfig     | 3 +++
>   hw/gpio/meson.build | 2 +-
>   3 files changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

