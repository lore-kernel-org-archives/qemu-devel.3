Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE73CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDoG-00033h-1B; Mon, 28 Sep 2026 12:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDno-0002eJ-3l
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:02:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDnm-0006pR-Gd
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:02:03 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEeAQ31244051
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Re5Q3YTkeKFFF6yVxMcMOnaL61ilILyKocP00U3EuVs=; b=c5aHVJWjf2MwmSBZ
 wxKRsbr//Yx1WNF58uEkHc15zvs5LhIaWLxyLtoJzygBMGYXYcME9WOV86TKfium
 6UH6iDaueGde1Me+cb7WEbDTkNhJqe08zDeLGgOUy0IkqUj39SkvqX+4HeOQzCMf
 QMFOj2Um+GmrtUtW0Awn2GBCes3d77LiQntNxUEqe4bVj4xzlQFdmZHT/IDpV1Cd
 yRv0/2AM2NWrzLkctAAA1mLojLGbG6vqctxjG6aWtdN3e5p8ww2wKoZk8gEUsCWP
 P+H2AEACe9MgWAKDKAs+wXhU7AEEhThIl9dgEShBbKRpsHUozCHGTsAcnjgAyjPy
 ya8eYQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyav4bca3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:01:58 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-98537d1242aso2901342241.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790611317; x=1791216117; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Re5Q3YTkeKFFF6yVxMcMOnaL61ilILyKocP00U3EuVs=;
 b=ghOs2xIW36i0A9OZvRU92iwyycXywioF2wgeq2yrN5nGE9mOwf28tNlqHeUjPLqn/7
 VwFS+Ir5FzZPZq6P+X3sWnh7Qtdcvq2Wzka+2G33Gjpzr6UlFU/vYRfbhJJ7IPuVZ4RT
 8vuIdi6b7sdjPN3mv9yvyc3V6ocyGJbykyNRkGWpWtpRnYziwUHbFzjZ3LNNrMOSjG9k
 1Q48cVx6OE3fkzGtS+BA9wfaxLM9j8mxq28pZBBUIhQLBb5JVO3sb9npyyo/FQPIPpp0
 41tqb392/iisac7sUK8TswG3lO2yfEbbs07NepJTctZnpXUnP4vPbKFFzrYuQEIaRYXM
 E5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790611317; x=1791216117;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Re5Q3YTkeKFFF6yVxMcMOnaL61ilILyKocP00U3EuVs=;
 b=N2NSzxG+tZuuJtN7wllnErPsfhAi+VBJzTwNQU/ugCK8qE5A/Wl3pLsHewDYEuGgW/
 ZCTirqD+a6mToU+jQAr+sRheSASqVrUszXEUpS6K8dfm7leIgVRX4ekEwg3GA7Wxrh9o
 MxR6Y/A5ISHRvQDa5h8k1JZElrrKeMw6iY47/SXWME942CkO2+vtJWhf+yphWwTuZq8a
 YxozfuCv2+ijfULtASyARu3LKT5e3E/0guDraXdhGrZ3jV8SkFA0h778LPMRrFK17qh+
 WZ3K8PdMVkD2vKALjSET4YqYt4NdesJA+EZFE7oVBADotnn44aa77vq4rL6M3WxCK5lu
 7fcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1AxrkFZK1iAu6Mt1yuooswVeAc1l+mtBh0WbGR/yZl4WPhyC0xdhWV+rtMEGm6kcx0pLlKgRO4F0l@nongnu.org
X-Gm-Message-State: AFq9FYLImpZLdZYHjWlVRtOuyRl33br9eT7eE42EXbMog+NnXSTnQt+Z
 lfM17+QXAYQy+nSyuRgCfyonCDnyShaVggGQeFYz/MEvmkFpu4cpvZLSue6iq8zIp1waykJee+C
 eLW5Iy1SXGWsRVKDaMINrE8FIWcrZIZmnVRDa8jCQ2PmWKLzqzfB+cGM3gA==
X-Gm-Gg: AYBFou11LN2tm1gKDnRdGxSAwX6kgTzPfhFIeKnt/u+Kdtm/IgRQM0XS+ntFGl2Qi6P
 QT5RNX8anVZoEkgeoubCkz+rCc2B7KFZFyW4iHevRDismv3H8zxuklked5WXWd6DHOK+OOFrA8P
 TAqVQ7kHle9LQIo4ShGY74zIj0MYGIVLnMmN/92s0ypDuGm21Pu+1lW0kekUrJdW6sV8cfmPYKE
 +MafUkWMvfKZq6/0zQ71R1dkiDsefDMuUYlhePFvnhhnc6Ij53ng3ifLt9mjIyu6U1NbJXIp/Cb
 9cI+aSgb6VE/RcdNVLhwOHFgej3FNEubIH/jUq6mlCTEMJ8q0IyP6dDVeA1pmkNRDLVdaLYLXwe
 WEjZOZdTVUecu0Lsnf7uT8rO1SBJ9Zcy2zw==
X-Received: by 2002:a05:6102:6a81:b0:7b3:5cc:735a with SMTP id
 ada2fe7eead31-7b305cc783bmr2787242137.34.1790611316927; 
 Mon, 28 Sep 2026 09:01:56 -0700 (PDT)
X-Received: by 2002:a05:6102:6a81:b0:7b3:5cc:735a with SMTP id
 ada2fe7eead31-7b305cc783bmr2787225137.34.1790611316338; 
 Mon, 28 Sep 2026 09:01:56 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a648895sm28528172f8f.28.2026.09.28.09.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 09:01:55 -0700 (PDT)
Message-ID: <2faa7ac6-9dc6-425e-a2e6-7836a70db1e8@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:01:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 037/101] tcg: Generic expansion of tcg_gen_remu_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-38-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-38-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dUaeAJXcF7C1ehCvrtAOvpy76hJJ3NBK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MyBTYWx0ZWRfX814eCVnetv+H
 HHpfOYsobiIyIwLptYA+OaH7n/1l9onrizcICZxRKo8aHnHY0C3c8gpY9MUSx2L+A4vRZVcNIzK
 DoWnmtiiJnSH/ysUuC59J0+WoGha5VP5iBNSoIqJiRNZSrIz6Z0rjLk66gP5ksoXC+y1aoGmBXu
 uHdB33e+cADFaDOXlR4dz3Eb6RBL1qk+jbKpgMrX+UeJ9821wgLDKdheEfaCj97QPKtLt2HSjQv
 3OYLLmri0KJDzobYyfR82u08MnbWXNDYh8BHx7bNkcbWJlnj/VlynRend6cqciEfpEcmg7Ryif7
 zTIqHOwTUTrf+TeRO5haiatgh8FujVhv8G9yzKLkH1qE24IOMo0W/ibtD+dsk0O2UMRtFpnKFzj
 eU+Res0Gpe/+mfaEQQxM4hbiIFa8cTT9uN8zcuAIE/vdB+4ky9Pzj6Dg6q+byPLEnD2mga2k3dQ
 X2EsfLQDnV9imw68ccQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MyBTYWx0ZWRfX2poKtwU/VZoA
 5sX2QDfXh2N8tWTRgkDLz4Z2DopwXifppTsMjQ8jJTF+S2YGGseIVzKpqIeI10kT0G0EbbMIZmZ
 BD6qK5qfCCVzS9ltIya0C5ZFUfvc0D8=
X-Proofpoint-ORIG-GUID: dUaeAJXcF7C1ehCvrtAOvpy76hJJ3NBK
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aba8f76 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280063
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 -
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 74 ++++++++++--------------------------
>   3 files changed, 21 insertions(+), 56 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

