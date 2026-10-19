Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E1A606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AQ3cnKlC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jk7kvwiU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIv8C-00064i-0U; Mon, 19 Oct 2026 17:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIv89-00064F-SY
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:42:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIv88-0007d0-6I
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:42:53 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZPL5836428
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v84azXn8xCzQYOzn/oO/6CPfS1Qfxnjj/3b8ZOiQ9s0=; b=AQ3cnKlCtau6g6bG
 NVsoZ/xZlyPsu/qXyzAeHzVPaDtASUQCD0CmUDQy/lLnBScvyvNt+ZWkYkpHafj0
 FGI3z+8YicNGeAKdq6L2l0aOeN+3AGcgp18ckh6+sYqd2QT3gBCydzpXQVJyGebS
 wGMsHSw2nuEKiwkLqQrP6NqLDnSQpuTMoud23UapoRzkNSEjlUfLYANwcLgtaCXB
 Q2RF6/z0aM5N4y65+JB3G1wj9dfAjUqPHyAvqa89c3gE4YDp7GCrZZS/lvC7aEIL
 MSl00QCM+oMDXCEv73Mfnedu+xY2/CaDU69Q13jYe7/YNzg9kU9xgd/AJCD1y0cb
 rCEsxA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47ke9s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:42:50 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso4952115eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792446170; x=1793050970; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=v84azXn8xCzQYOzn/oO/6CPfS1Qfxnjj/3b8ZOiQ9s0=;
 b=jk7kvwiUyszDtsLIiVqp/AQvpb1NljmiUN6liJvY7b7azCHeXWGbRR/pmE7tE29Xbp
 zDZfnlhsdMUvog5ysdgEG03LdFGDNE7R3qaB9sfqDBPtLnND3E6opL3llE7bAtPUZfVv
 obFpyYyib+NWKxvP8TdYZeG0ZPzz4e9AtXHmrjrU+TCPw48H6I0SidSmxF4H+si8k3PB
 IDnj/XUj/T9F+wbWoXnqe6RVR5suEEmLb6DVJEeUKVeqS0G7POnM1VjJUegFZR0cZ5Tg
 /50pPsnUEmSNog20HOu4/b+uWEvg5qwONZiOVKqUOhqUvKT4aHbvv/g9tG/C27dFvhos
 4hqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792446170; x=1793050970;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v84azXn8xCzQYOzn/oO/6CPfS1Qfxnjj/3b8ZOiQ9s0=;
 b=R8P6ozQWAg52rkJc8kq2QCRYsr+Ua6jzQzwEl+XCg3xGIrDBkzxZlcxeNB2PdX2JpA
 Njarfk9HyMRexb3t3SGPpiiaF0zajWjzuyAaDFduEk+HU4AibE4HFlJootA7Xd/oSbE2
 SYPazbZ7MdahTB81IrAC2kF9kuDEi/+ZkpJVjHiNuVauhJBrO60Y8Favm5ZguoDy8e6W
 ZbkR/ladTTzQB8Dn4dCc6scfJKvq9AGwK0l30G13RLeJayuDI/BgvXvM5mmoSMo1QuMC
 td2n5jzGmMLnAfKIG4fRO0/Cqb7qxvKKDYTT9I6VLyjgqjl5sk4i303VfEP87vm46+uj
 0C/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzr0fo6acMrnOXNvat7kxg9YAYjjPuHlrLtvnvVWBoM6k2mTwM3Jlyg4IpDJROfSKjSQ97lNzLoHL2U@nongnu.org
X-Gm-Message-State: AFq9FYICtEg8UzMQ2wCHUv84EGsJVEnrAHW32PPuPRfJnQnyR60oBzem
 xfSniL9UYoIegMwe2wJLnBnDkhoAouQ8X9sxr4Zhfa4RIXEHZD3Jur5y9F2GUOtCSxqMENO/0U8
 q1jlvg+/6tThAyuMAU77HY76+3o4yfjpoqvwWjtrYui9gh6qIU12zvp5hiN5vyLlFSQ==
X-Gm-Gg: AYBFou0X3wBGzF10BsI0BscTjD6Bg5HWsKOA2k2YHF1LubT1PBaRQ8R44Ga6ZP0YUme
 poKV0ZxoOiQkrpSshIU6EX/JJCiUVqks9R2TBrMTRW08RxBTqLhu4t+qxxd+JYVwR4NSCz3gYAW
 gI+wwLd1/eFejcqZ3WATnjk3kUg6spw0BQizfIkCDwaZFkAbJID8aInckf9gJp3M0ki04ulZO/j
 54iHTfXxdxYJPVNS9c7LmoVpm7zznil6XZZEp8pbqOFGkut4mvsd41G+kcmmlMSXhq7u2prY2hM
 JOLxTvoD0kC8W4IBU/O7JTxAiGsFHNAb4p/5m/lcAO5GP9Ms1YRfk2qMntzOfS0cHzUhArj4hv8
 Dg6NYo4e+3diCGg3/z95llQOfeQb5UlrfIU8YF7O+i4DWvGJfy5Q4QBWX4c62MKPHm7Kjvg==
X-Received: by 2002:a05:701b:21c7:b0:168:6ad8:e8c6 with SMTP id
 a92af1059eb24-18512c382d1mr11731026c88.15.1792446169732; 
 Mon, 19 Oct 2026 14:42:49 -0700 (PDT)
X-Received: by 2002:a05:701b:21c7:b0:168:6ad8:e8c6 with SMTP id
 a92af1059eb24-18512c382d1mr11730993c88.15.1792446169185; 
 Mon, 19 Oct 2026 14:42:49 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa411sm35444428c88.4.2026.10.19.14.42.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 14:42:47 -0700 (PDT)
Message-ID: <9770ca62-b58a-43bf-987a-a93671eb2abf@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:42:46 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] hw/hexagon: introduce hex-board abstraction
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019055245.1457795-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: C1ZwgpzbgcKUb-gUggvUEIrL7olq9EkQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX/APMX5LFqiXu
 lUKeSrfBSxDVliNrkX+h/+Sj+i4Khs5fgNBBbFaj5IeO9g5rnM3Z+Hwkl052RCOHS/s8FVZApxx
 K9Rce7HN3UY+QKdVNnLTm8KveAK1st0DOPVXFVqQ2S6r9rtfphG9s3BdOFklOmy2bglttVHgKPc
 ZlgktD6/katalcU2wa4FAqqPHLlUNR9Hmdi7sHVwd8jNf1KlIlG98E7XDmZO9LyCssSO0obyY1x
 HIJkzj7lyonQapKW4uZZd4crEIYCrsK09+/dxVa1q++diEov7sTMKJtkXat5jsyXbWG5N4b7mWz
 YTQGYqyyINOm3eRgmsSbdjCdpcx0+Y+fOYEBadr+gSQ6JmLBpx9EiPYncOnDSeSppBVwRZ7F6Lt
 vcwW4nyLsxxxt79bMV5udRnb5ToRvAXKZ47du5VCefKffCswWq0u1Vmn5CWP4+Bj3lWHtKB57ry
 LuIGy8VgEGRqhXf9zZA==
X-Proofpoint-GUID: C1ZwgpzbgcKUb-gUggvUEIrL7olq9EkQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX5UBEytE6qPPu
 JbN4T8w3g8U8wtyqlDS6gyx6Ur+NaYigMJ0urNEpSFLW9YB+sNsXRtGTzShRnFZkFTE45yk61zp
 o6jm4YKN/0cBxXu81svT6CeSAxi9uHY=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad68eda cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=sKGTi2AOazVunw9h_BAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190086
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/18/2026 10:52 PM, Brian Cain wrote:
> Move what virt.c does to build a board out of it into helpers in a new
> hex-board.c, so that other Hexagon machines that describe themselves
> with a generated device tree can reuse it.
> 
> This will be used by future commits.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS                    |   2 +
>  include/hw/hexagon/hex-board.h |  65 ++++++++
>  hw/hexagon/hex-board.c         | 265 +++++++++++++++++++++++++++++++++
>  hw/hexagon/Kconfig             |   9 +-
>  hw/hexagon/meson.build         |   1 +
>  5 files changed, 340 insertions(+), 2 deletions(-)
>  create mode 100644 include/hw/hexagon/hex-board.h
>  create mode 100644 hw/hexagon/hex-board.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

