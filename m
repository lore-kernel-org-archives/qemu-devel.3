Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B941BCD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 20:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wblee-0004fm-CO; Mon, 22 Jun 2026 16:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbled-0004fN-2I
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:54:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbleb-0007VY-Jo
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:54:02 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZrxc1612646
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 20:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mubbeLuNvHzWTjuopSsGGDHxdDc6q8WAh6XOPWlu+qc=; b=Y1mr09CNjuxKk10f
 xfIBkCxTwPCGr03nkyhCl2HDAUDAW29vaukVx5rp/3xBzpdPEnvCu8AdvjyiBRr3
 fiy/gMJ/U7bgD5PWb3PG7Ama2rj/VJ16CyV5ofAAKlpv36lryT5WCQ8Ibhwedus3
 VAxLbv0AhQhIgJQjGSDI4ldGC3/B8jWzWALUneJIZNCNEiIYM3dqoamfioj/d6ej
 n0Lpa7TkmQQ3SgxV4Q4G33BnARgW4OOhzNW8aBH0QPZXP5ORv4whnbsT2ASfUmXP
 78wsEaB55DImVRJmNbtYIVRkVvrceCcdM00jN4Gup0ze75J16jsNYMQaR7YVnbCT
 lQTx5A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yjaatj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 20:53:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-921634eebdbso613404885a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 13:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782161639; x=1782766439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mubbeLuNvHzWTjuopSsGGDHxdDc6q8WAh6XOPWlu+qc=;
 b=Qg/nnbcRm66ToF+vTvR8wygDIr0D5S6Jqs1lDN54zaXsx8KautMQPT940X2v5Vzi5G
 b9UaEnIa7QFLvFYNKNwUOXMhJ0zzKSXnEr2UY0GROf1+WLxahv7XPa2l0F6xeN6ugKRE
 GjNmcJSTpwBobEo9gdpdwQntFqC82Rch8CpjbX6CDLcfBLB78b/xQOyceSo0OzAcF89R
 gm3y2SkBA2e93DRPNtn6uxvadJUKwZ4Phib+81BFg1tCT1I0FyD0Ml9L8CVLHBR8WHLW
 FvZRahtvzv3hTKmyzD5kGkKX85qcymjM/i4L6Xl1O2mN13Jhn7lCoeINWs8JBZBIN+Lu
 XuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782161639; x=1782766439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mubbeLuNvHzWTjuopSsGGDHxdDc6q8WAh6XOPWlu+qc=;
 b=op8L6M5QRUUuHd03fV46ObytYiKZ3e3WkfWzCl4ALHgTL8Mx6PVntOSJOUCuDj+4zJ
 Z11LQ4j/G41q/EAhh+kIRItDx7xvunnNizwxuHJSDD+qVDg4J+zqLPsU69kGVTU2aMcV
 3CtR3Po5Nv3u7EAKdcWxiOLOhK14tvubNG/1RvLJOAZjb7BJ+x7HWsggMSLv+Rl7pAAp
 vpgwBIPV/9llXIqqdbFzwhc7G/2XZiD3RgEmz0isUE/eMLeY0DscNsQpGndn4753io09
 Kw/SWl8FUUKuqi/aR5CLMNwSjziJmsIvEeaK2BVLip8g1Xdd4E+D9kpn9CGzs4dRpWHA
 A8fQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Hp61V1Vb3IiJV3hR9uY5PJPCra6nu4tweMsdExJMsdkgoHnXnMzQ3TXs+UNzobGP0kAiUXrsAe4eP@nongnu.org
X-Gm-Message-State: AOJu0Yxaqrmfji6ijlYzhXJZcwBGH+dNOLQkirwdtXdtio8o7DOg7x4x
 IfxdYidEHP5UXlUy4nfmWQX6oECEwpXxRTuVOuhE0r0Esb2fLyjSFig2GCXYhfKJAbDY6aRQi70
 ab9zSREy+a+GaLsWCYIH9a6MIvDrNvMrdW+gH/twJy/nrYnLIw22KaBSsTw==
X-Gm-Gg: AfdE7cn2NB82JMjtjW/cLjItaeYWfCZEFe8l29Bz/ws8NJcn3Ewp4/OQlNh5yiB2G3l
 J21iO4oTMej51QJuUuZgKtUBf1p5IEm4h9VQMZC3zYRcs2PzzkjW2bSrSywzjen+aYDAKBUHDtE
 lE9TgCXnWGATw3tmpr6a/jTqbxLIcXInAfqa0MM1GA++WBoupdNDnFYYZkAhZqMCzB99gDlN4Fn
 Xc5XMQ1wuPcG3WodBpLsiG7Yfin8nMCB+/usrF2Z5cgQJ8oeG9dpmxL5zR0I51avcngW9CATTJM
 pCGtbzf99b6CuXcPhjNHMSPrh0aZtVHnLmi9PsioMH8j7E+awW7COtOJ3WP6KfqIOUQhDKi2p53
 XrXwHeY4eSCcD3RWB3iK0obkT2xpfhxVRxZ509hsA+Sa3fTPSqr6YgrCP6Arecg==
X-Received: by 2002:a05:620a:4720:b0:920:946c:45eb with SMTP id
 af79cd13be357-921d0b36169mr1929513485a.3.1782161638883; 
 Mon, 22 Jun 2026 13:53:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4720:b0:920:946c:45eb with SMTP id
 af79cd13be357-921d0b36169mr1929507885a.3.1782161638371; 
 Mon, 22 Jun 2026 13:53:58 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240084928sm336145105e9.15.2026.06.22.13.53.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 13:53:57 -0700 (PDT)
Message-ID: <dde1c145-3c4f-4ed7-a975-e5e154827514@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 22:53:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/24] target/riscv: move pmp files to tcg subdir
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-5-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260622193141.1449724-5-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: irH9-3pIfFg7X7rpfkN2xr8zAWdZUJFC
X-Proofpoint-GUID: irH9-3pIfFg7X7rpfkN2xr8zAWdZUJFC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwMiBTYWx0ZWRfX59HB13skx9lI
 1Qg6AWVKzpwCPHb8cNGvkR2H6Q1c0HkqefGaDFJNKkSvp8f2mIhpPfQxP4+Mlhh7PPhhqXuC/zu
 dBqbq3j33nd/epsTD5ipXzS4fSZnWxY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwMiBTYWx0ZWRfX9it5P8tTUVxL
 bt4wqP2oBBRXUPHnseS1/0gqcxi4jHFAeKMt50n+IxCbPT/bijHjNUNXbVZdwm903BZCqwM2sPm
 VCaylFNt4qpMUQoZAZeRZ3AOqlyiTv6t4AqMbde0zB1tNtJ27dULuqRwqEQ1PQpA8DK7mDMNcg6
 jHT/WnHuywBTYC61w+vZnxC8eZz0/yLyc2QNStC/oOZwvXIqmZTnhEcqNTQo9kzen458kwzvMsX
 BOKmfrtmL8G2+2lY2xvpe+USgJEayz+3QlscdZBLq+A8WUMrhCGvep4EX1Y4I/UJtqks2z1orsv
 YVHJ1kYYd1tikJ0AmtAyAE8IYakgs0xabpJY8Byq7qPoyGpuWmYbdlVVlCNB01AlvbnWBEvhHiD
 2EevWQN64dfvK23JqMdkk3ZedSz+aNW79QZumeImG4UPwOLpbzEweVZlIurpf22UNkNBjZynkl5
 iRPlb15kHdcCen8dI9A==
X-Authority-Analysis: v=2.4 cv=YLSvDxGx c=1 sm=1 tr=0 ts=6a39a0e7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220202
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 22/6/26 21:31, Daniel Henrique Barboza wrote:
> A trivial header change is required too.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/cpu.h           | 2 +-
>   target/riscv/meson.build     | 1 -
>   target/riscv/tcg/meson.build | 1 +
>   target/riscv/{ => tcg}/pmp.c | 0
>   target/riscv/{ => tcg}/pmp.h | 0
>   5 files changed, 2 insertions(+), 2 deletions(-)
>   rename target/riscv/{ => tcg}/pmp.c (100%)
>   rename target/riscv/{ => tcg}/pmp.h (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

