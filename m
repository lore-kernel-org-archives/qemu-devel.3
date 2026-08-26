Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E58C61DC7
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzMVN-0005ts-1R; Wed, 26 Aug 2026 18:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzMVL-0005sx-Sg
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:53:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzMVK-0000xI-9k
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:53:59 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QKe4Ph1888044
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0kMAYgi1qonFKa8UVB01lyM70IA0zH7wLRqcKAp7RdM=; b=IH/hbTUybTz3egVm
 TNYSnNLnX1PgJ6n6NMjBhaEpl8GnAvftv7IfXTtq4Qr/bwX+CNzl9UX/i1fF0BH9
 wl8dmywVOlneMWu+E38uxW9HBjgx2sKV4DYnzUV4z2eTWWAAyB2A9JdkfoI8/SL1
 H1dvJTLEkQ0kr7sD9CZMAZsHB75+cvYvWxvQ5q1Zhxw+CIZdKZyusZnIYtgWAMbH
 zDA9lV6jL1AY7wo/PzPmSH0G+52SBPikByQfAO2xEEiUQ4dKwsc19d6ZitFzG/kn
 fJyfc9smZfxd03xU58hB9LbzoPPVDB0faNsgvlTdCkGdS9et9wSc0NW0Pa44IJam
 rP52xA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9x2n2td4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:53:57 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38fa7b09921so2085078a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787784836; x=1788389636; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0kMAYgi1qonFKa8UVB01lyM70IA0zH7wLRqcKAp7RdM=;
 b=PpoPcBbj5L5IxGz5PUel7/lPwq9GReDS6NYvbUE0mQBW9W5BG+cj+q+7hZdEig1r2W
 LOxqbATGoGCrSoPZVU3+TNh+W9x1S29OLCJnxF7Mr2gwmaxRAJ3FCCBAdnmP7pqpcBOl
 3RbsbSHE+TCzS+Vyz19eohQ14csxucS/SHolYH/IENAHEP8nJ0E9gXMjZthM99W98UA6
 yFZXkWWmSlEqUooSYDiDbI5qsqa2DznfcC5PTus2dUFUxJ36IKNEWXDvRLk+5YnPd+2s
 cX3Hlx2u2Y7V+xCOyC/IWJ9yvbhJBPyPmdFPfP0uqzFlK1B906xMYBCGypAoeTKTv6ra
 2U2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787784836; x=1788389636;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0kMAYgi1qonFKa8UVB01lyM70IA0zH7wLRqcKAp7RdM=;
 b=XrYE7DU1v5Q6iZn3diaXAqzB2WAh4/iRrO1Y4jsLL0ouTjKprmyDi/29yRyfvzvuvh
 tjyBuAl16fGlPLIQtF0w/BbJ6TeKVP/Q/I3A55oeRHBEDMCn9mSX/CWEaugtQTTzOIio
 +kBwJ4FJO8sXlC1kG3smr9ra27lZS5g9FF6QSQv98IyGBBeQrpBbpw+6ewe2XSRO16Bb
 B3g8vb5p344wfLMM27l64YXbdxu06ncTrVx4tSESMRL4qacWmJPC8UiwoJ8qrKFPBvfo
 GmPNxeQwyM2K97sn7C0jAHyARwNmwxSxU39JhizwSIwlcjiTIwHwZMnBw0fZcV+TtsEj
 AqVQ==
X-Gm-Message-State: AFuF++lceCYQqW1vgsfOWjv9AdyCpozUuULw9kQrXMz0Pgp3V69ioNqf
 h5toLZFpJpxwHeBFJozU7iajPYe0dUCjWtzDqOa2nb0cQgC9cboAwl0u3jqGEZn+pp8XJwoq8Nk
 B6hXGakz8xiMZ5GrxY3ouaAgz9M0sap8Bb2BN/WpiPel2d5s0urFfS5ODjMWfXshI5g==
X-Gm-Gg: AR+sD11uB0U9DuYUjQFPKfMJL65XAKrUeICFLetBJjq6s2JE0+HLz6y28EcUZ4mLuXi
 /LhzmtlhADK52kVmlIF9fb0SBoS+YCYlKk5BAFPIorPbXreza9z6DcWrh2e9M8ewhReKqWi9Vst
 ujic4H8mbkehIeipCVNUzsO8oZd5Iv5EsHfiCw0x7/hlhwR1NMeBchc31plAcqRf1VNjXHLYQWZ
 AVBconNgcRzs8Clvlz12YCD0+MM3rj6fLng/FasyXlr+Dqoy9UwBBWCFAxxD6kfDm1QUKf4rYLK
 /01jZO5EL5aizeRTF460WD1UzlTrEdXlIyXIEGdRlW/BdRvwENepLYRctEkLFh9WLO3zFMDbCrp
 Fux/OcxydEdVkGNrX8xy4yYdKxHzbaDUY/zkO3EXH/8Za2mCBoZuTvn8ku1RnnzVwSNeT
X-Received: by 2002:a17:90a:c10f:b0:390:8361:a532 with SMTP id
 98e67ed59e1d1-3966d373968mr23772008a91.7.1787784836332; 
 Wed, 26 Aug 2026 15:53:56 -0700 (PDT)
X-Received: by 2002:a17:90a:c10f:b0:390:8361:a532 with SMTP id
 98e67ed59e1d1-3966d373968mr23771935a91.7.1787784835845; 
 Wed, 26 Aug 2026 15:53:55 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d60b59dsm12061845eec.3.2026.08.26.15.53.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 15:53:55 -0700 (PDT)
Message-ID: <fde5bdef-b8f5-40ad-bb4d-bb1f1a9c588c@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:53:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/tcg/cpu32: make compilation unit common
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20260821213536.433273-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260821213536.433273-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: n8tMX2PmP7P1JScZguAH-DrXgRclz9xw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE5MyBTYWx0ZWRfX56FXZzYTgDv3
 e6cBsVrRDhKWZMpRjIq2CiuqGalzMI4kq5dHO/FSWcmyVeveZu1iZGPU+1DXMhI77f5/rrHeThw
 mss2Ct1decBFP2SX3votRpwyZmkBJ7U=
X-Proofpoint-GUID: n8tMX2PmP7P1JScZguAH-DrXgRclz9xw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE5MyBTYWx0ZWRfX0SUUqASLovgV
 RLIsOj1uqhdWuejGs2LvE8hnOlJFhbr+KuWYhTul/fHBzlwUbyRIVw40AsEh9iQx0VL5ZvMA/RE
 NaGn8+6mmlERXjD3K4EpPgbB0WXh8S8erOZLDblnjKdV8jo1cS3ox8q0Jvz9yOkeo59LlNja8nO
 qPDJy/zltCoUMeWQYNrgctNcpUeptmx5BecSK5cArvMO7nJxUIcus6wl1CHsRF0BgeeV3uf6uvD
 kyomhEE3Wx2gDnNfoHx0B6PUVJATDHHdBVj28Ws0RKBIdhQQe5Xj0kNfOGW+IiaUSC7Gx4uRQ2l
 kRc/VQKrQmAN1pAzPt7Ujn3TOm7TKJn2BYuQlRQ7kSisiM6vsvsZkSHtraaQImBOvLnhpHChhwT
 +5wHqwqov9lxxbKJbo4UK2ESJgbe+ZIDPLh/3y9RZLypluXHVEzG5/8JmiiscblFJGXCA6ZAp7t
 fHrrUzW2YE10M699tjA==
X-Authority-Analysis: v=2.4 cv=PPQ/P/qC c=1 sm=1 tr=0 ts=6a8f6e85 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=hC4PQK_1UmcdZ9DT30UA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260193
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 8/21/2026 2:35 PM, Pierrick Bouvier wrote:
> We just need to remove TARGET_AARCH64. Simply expose all the code and
> conditionnally register types.
> This fixes single-binary with arm + aarch64 targets.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  target/arm/tcg/cpu32.c     | 13 +++++++------
>  target/arm/tcg/meson.build |  2 +-
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 

Ping for this simple patch.

Regards,
Pierrick

