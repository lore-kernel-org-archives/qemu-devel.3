Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC42C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfGRv-0008AK-VK; Thu, 02 Jul 2026 08:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfGRv-00087Y-11
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:23:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfGRr-0008DS-PA
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:23:22 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662BoIRJ360401
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 12:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TdOWjJrFhcfu0N9QuPSG7Xh70uZuGgsGTqHGVrVvIFc=; b=efuMBwhp8VOAY04Z
 RDNkSWOkSPfyA3bCFONY5iRXYnKdRGOo+WMEeQTA2Iyp/k6apw9Z6jSxfVIz/Map
 SuZwpug7LUSUkJ4euZuLpg9R9GyFwSiWSvXxT98nPaP1cbR8iZVcthDDvzT7qjik
 DRpfx7ykVT022c/DqNs4RC/CYf8DoWtbKYzbk8K4RRHV8k5SI+SwDtkZn+NE+JuK
 5fi3uH3ZTS68xGB4YytIFC/kwq3fa77xqxne1zfaGIfSZBsHzJmDNIoDMOHSnX0T
 FXbuupFTf0afWuZyZP7SWicosuQhQvYme1NiOBqOix3lgRz7BAJfxvA3lNOMNAqb
 5lzEbA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qfc04ax-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 12:23:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e6ed4fe99so317608885a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 05:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782994989; x=1783599789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TdOWjJrFhcfu0N9QuPSG7Xh70uZuGgsGTqHGVrVvIFc=;
 b=h7kxsk0VH+8+WFKIC/VaGFzgwB3e0btcFk3LRPs5WqC4+xyELi2bcUqPlrsfwqYCu6
 DeOk+F1f5Id787/RkmtIndJntPzMdmnPcK8xq/H8bUJt0hz2mdm5246jzEwJKt/w65wG
 nnseFFKv26Z56hzx+6wOFJgOdbByuuEqCKeWVBMk1z/O/8MkziYxPZLmQ8hp9GmZsrsH
 qsYYryjFk3BZ/WqYQEifTQuHkO8W2OVTvC1pbVvELb638Z39mK0wPNKWnkpMUc9y+inT
 NiifHy3o+9KUfXni6xDXBIPZpUBm3nkaX6CXHyeTeX2JiLkdkplCDWdiVUrvzwyg86gl
 zqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782994989; x=1783599789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TdOWjJrFhcfu0N9QuPSG7Xh70uZuGgsGTqHGVrVvIFc=;
 b=RnpMaN8ZWHvlbdmNAvBoZswBiRAmMCqXxdvbNFCUr5Wxs3v8QuXInjl/EzuWW3AsdK
 hm6C17AE2YW9qwcJy+9sJZUTG9T7auENt1rzOzL+sZvCECAm0H5BZaZOtcXXzZVEjEDn
 QOArXtYEr8O5iQdkHrKa8l0tqm0p6I7YTy+gx8m3ovsJEM9ESzRrxKFmjnFIAgbbUoOW
 NEu7QxQnef3K5dR4Je5sImE7U7jGhNsFO3J0P8ZnTl1Bac7PsD9PgZzg6oe9TeYSG4Uy
 fyddAA3y/jGykxn+GZrSjU2ndMs5kxKK0AwY9haiXeg5TNh3WAp0KnpO9LG/Ax2R/IEq
 s3Kg==
X-Forwarded-Encrypted: i=1;
 AFNElJ988f1Lz35+hSvwatkr4EXjyVJrPo9cReM67VTUlzSfnqTfVqTTE0UCYWOYtQBD6Kd/Hzm3rQ4sLb3N@nongnu.org
X-Gm-Message-State: AOJu0YwJWpmM8jREUMrhU2Uom60z9a4zCHBbjwKAdSI5XnT/RvAwu1mh
 R1DIVqYMt20l2Llkbx0dkvJuh55YCgMbD8lef+M26kf3dK695Q5v3HXOkOlob+eIeALXMrE7CYA
 dvFqVou88MtOAJGlJbluDorzxPPZQabSF/6sp+4McSgq3sldp61PC9Udgvg==
X-Gm-Gg: AfdE7cm4XaAONm5h/ZWayRbZbPT3TprnBjhtg3GK709Sf/nEkZAEh+mCgWOMQQWwx7O
 XFdJQSy6P5VWUL0qrCEZN0Nce4o5EsY83ArVV3DJfqMJXpaar5Yc2rbMOnqbpwqPcICGIDMKpmx
 MB+7x48MTgRiR37UsQR6TKh5vP9FyXZSnAx6izd5J2r5JQupr9k/MF86+/fANFDlbaDOlCRBhqb
 3R5K2SqNXMfhELWtxGSJIadbYg5m+aGVWKacA2zTL+xFp3xc5I2fyxYVqVy410ceZAuhcpBQ/gy
 q7Tx0iqN66aPG/tx6Dg6UKT74ebwwswbhWZVWFxSf1yCMMWZH+vvCDV67mOx4UJg13BZzGq2bJE
 yZa6OlZQnjUgZy+eAhi8b88mDvg2MfKt26UyelpyYsy8WhWkwpxOecCoSz7GzzA==
X-Received: by 2002:a05:620a:40cc:b0:92e:5ce3:ba2e with SMTP id
 af79cd13be357-92e7825b26cmr866249085a.25.1782994988912; 
 Thu, 02 Jul 2026 05:23:08 -0700 (PDT)
X-Received: by 2002:a05:620a:40cc:b0:92e:5ce3:ba2e with SMTP id
 af79cd13be357-92e7825b26cmr866242085a.25.1782994988287; 
 Thu, 02 Jul 2026 05:23:08 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63ba971sm67339325e9.13.2026.07.02.05.23.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 05:23:07 -0700 (PDT)
Message-ID: <c38b14d7-2a14-4d2a-815c-b4fdebc6576e@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 14:23:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/arm/imx8mp-evk: Open code DEFINE_MACHINE_AARCH64
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260701224612.48342-1-shentey@gmail.com>
 <20260701224612.48342-3-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260701224612.48342-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7EEKytB2OVkD4V2H_5LH7OZmP1KhAW9y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMCBTYWx0ZWRfXw2QGqalAwUPc
 D6rSYvkqZXvfZHc6fCTq2OWZFkamfG9qxfMjbNuLWKJIceU+Ebd2HUlFPjIRhi4Qu0sWXIZ0+Aa
 sv2aZl8bW+2PQn/y9+TVY6GXml2B1RYmOeiHeKqq3fIRxO7z/JYsXTgqHPe6muPQGI2Q0oRMlhL
 8gaFmbusnkTKjEZEos7pwuhs5pmJx6U6gru6b82tmixzPbff8ywNlV9dRoH3wZvn9Jcaxhus989
 0uRgsYlyKSD0iIvVP4RIeVQIYN3MMr9u1f2qrUkSr8dQ5iZWlIRA+R6CAyG8zM41sCihlFMQEzU
 FVcjOW7GWiL7dXxPqYCJ5vh9PMkZ9ihaqqXh2vyvdlFmLFCE1UcuixCDgfS+wT1BCyMlvQdgMy4
 0I/24yCv/yMw7O0XvDvdNNZR7cM+V9/D2lrRKbR85aw2ou3R53WX42GsuhhMI3huFKbfTJTTAwp
 65i9DARopdSmNTWdknQ==
X-Authority-Analysis: v=2.4 cv=dvXrzVg4 c=1 sm=1 tr=0 ts=6a46582e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 7EEKytB2OVkD4V2H_5LH7OZmP1KhAW9y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzMCBTYWx0ZWRfX4ZzNohJGJ8HM
 lsYpCnXms9RTA1YBSMUF71hd9GdnwKcVOzlZRqqRWvOnB+76/aHFuyYbUjRofteRqTzfMEVOLVa
 Zf5WxJyxrPiRawB/VijDVUODLRE78pU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020130
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

On 2/7/26 00:46, Bernhard Beschow wrote:
> Open code the DEFINE_MACHINE_AARCH64 macro in preparation of creating
> FslImx8mpEvkState class, needed for FlexCAN emulation.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/imx8mp-evk.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

