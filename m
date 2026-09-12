Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32344C88E45
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 02:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5DZO-0008Jo-G4; Fri, 11 Sep 2026 22:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5DZM-0008Jb-Ma
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 22:34:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5DZJ-0006eG-Ob
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 22:34:20 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68C2WXDl1099025
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 02:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kr4uws+fQEIJRxGEAyk1gmtz2RVB10wR7+0/USduD3o=; b=N3uWhV1NkGTtG9sR
 CU20ml4KZBVVN0Ttmn8PbyQhj7gnwf3C8cCO9zKcKOepNFBq/0sQ1Ea8Vqulys8f
 hHfJfHjWbzTISe9RBP0N7FqRZSqV5TzmG055omdWa7mL57daRv4XT1scysj6Kvwd
 mPDIHJmsdqQYFwRO3m8w5UtztJaxbuodnwVXdAfoVFFjoPd1Wv5Ue255mjkYoru2
 k4v/c4JJ1Od0mB9OGEwSdwsu5snvB56i8rtL/7RePpnZZdK6spWZfUHA+Yts0M90
 T3kKc8/GmeqU6VlV1lxOvS4cQe+35xM6z0hi41w5mFglsgjXgUEkfGeJg8Q0EAh3
 yOvD2Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmwt400y6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 02:34:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936708f129aso221322185a.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 19:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789180454; x=1789785254; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kr4uws+fQEIJRxGEAyk1gmtz2RVB10wR7+0/USduD3o=;
 b=czpWiHHe2in5jd/awmCgp0D8oGAy/mVM2kl7ul6af5vQ82v1/uunJid5z6q0g7QuXi
 G56k7r8y1ZL4O4DH7TG37yAOqyRsI6d3Jwr24Xt8+xCAZVrXzpaGv1xxJJ6UyVs8HgaJ
 j1LBbjIVUfBL+B0dzmk9L0/nOAHPZRFCvIGe+8QO3MEzSGPpLdhbKKui06Paxt2kmL48
 Ouz9Fo6AAJH6nxouatpL9e0evnWJjVXcA42F5fSuHC2TUNqvZTrdxjdXiQ8YGuTrsw+U
 hEe/XfjLi/0zWa7IR+m//UVZTsSf7XcKZKrEvjDM9oSVwSye3zZi0/kBun3J3lNF8Ppb
 W40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789180454; x=1789785254;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kr4uws+fQEIJRxGEAyk1gmtz2RVB10wR7+0/USduD3o=;
 b=GWoHQ5JWo8typDeUsydFN5badG4ZZYznBqzsC/K5mtCG+c1NheP/b9ns442oc9ronl
 QLi0UgV5JosQlHCclGVSJ16DP2kBqWhOiJ/HBO29iO1BWoPsC7WuGvv0eZg3/ox5F8h9
 XK6Nwb1s2/uL96gYHXoCb0TeT420oafBBuRxcEAGdmPIro6ltY9NdjZPrahbiaQ21v6C
 W1F1DOHXAp+nCiibAkpuV7LdtH8LlLzcaPfmKAh1v/eOebZGIp3hhiomDf5D+CK2gJ9/
 wfgVDPOc3qymZmrmafdPssKZD+wy3UJzhnSzTN0/BrGMbiWOkMNwd86usDLj5zqSAZhG
 TrEA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwX9Glevk+G9oO1RS6bcd8A0zzPBt+UVY9bMRif6gm27PwGAfj3jZqo2vEkf+w9BAA6cKo7Wzziz2ji@nongnu.org
X-Gm-Message-State: AFuF++kDmq6qFcJk5vSWxJksYYdBZ5k/9m0fnmSoaJdaLaFKEz5BuNNv
 OS0QPfFVzJkpp6nwSnPon3zD0fBJsVhfDgtN86MHkFq0mSVNlax1W9fTf+XH/sMFNTDBnUsuhvX
 iWNkdQUS4mHX79yKypGwSHckboQrIzungV3HkUf11OP1XcG05ca5X9x5RoQ==
X-Gm-Gg: AYBFou0/WC3tWWedjmm9TngARDqgWbzCYVL4mL9mMPvOr4CwmOHcZZlR+gJlErHzZZQ
 aowjs+btktAq00RuiDplrkiH+0oCDLXDaNXQjuDlsZxcCSeWwuDG277xnDqNypro5uSNFPyikwk
 rjrtd1KE+E3iC2ciPLI+djx40y38g2HMzc/XXY8IpNjruBtl8Gm+KlyqGfSdAL36DTX+AtVN96v
 vAA8no7jIoLCO1ZKUz1FTOV5OaMh6gNEigbXEFWR/NOLvJbNQdCqttJEpcIsBTH5l13MqU8ozIX
 Ys1TWS+CKbf2aIhXhkgZDIo8b54POtumqDzqOBa3PXlU7MEnmvjl/rczhaZ4txLa9G10/OWRlqn
 i+FEVIfFr6EW7CWGkmoxR6abUCsOu3DrsNWcfejI3wltmbL20n+K0xruXiBuhrIVI7oxjmkyJpt
 /37/Pv
X-Received: by 2002:a05:620a:7111:b0:939:6de9:d52c with SMTP id
 af79cd13be357-939ea1ffbffmr924342485a.49.1789180454358; 
 Fri, 11 Sep 2026 19:34:14 -0700 (PDT)
X-Received: by 2002:a05:620a:7111:b0:939:6de9:d52c with SMTP id
 af79cd13be357-939ea1ffbffmr924339385a.49.1789180453838; 
 Fri, 11 Sep 2026 19:34:13 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939f81b022esm214637085a.25.2026.09.11.19.34.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 19:34:12 -0700 (PDT)
Message-ID: <8e57b80a-1f0e-4471-8804-257971ee781b@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 21:34:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] Hexagon (target/hexagon) Check for multiwrites
 in analyze_packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDAzMiBTYWx0ZWRfX7HYZWzqN0Vev
 MCr3F2pRdo5VGVe8Sua0zltOynhQlJ63CjBzfLVG32KZoBdNF4gZSQ4mfxEsGXEtKRNilj+pcUO
 QKmBTV1e7Fy1dkpYq82gGDexFP2uLnoXIDd0iKl51U6Gl29I+ZQlIERFqibCOkmITQ3rcO6GNOV
 oJ4I6oJWQrKccL+7uyPO/sHYZHQLIBbMIo9lYld35vpaY1+nAc1p/wDNWMCJCmk7ms3QBQxR10P
 bK6qJXRk+tfj8PSLwrikQm/5ju6Hi/ESabY4wiemq0FApYGBktd+GV6CYAnjBH6nEZ1WFDtV65a
 yKZrcudNOGxaCSX5eUMerttJGPD2ldA08FtUH2zmqsRF/QLPyhRuKTEXuj1pGvT2h0vMgGHtqaJ
 /+pPDqv+60r3Tx+P5KDtW2bowC1dmPKT82HX+us5srxzpeZUEkmpgoxW6PCxcsaeRNzS53j8lao
 FvtuX/u1anufEzXXS6w==
X-Proofpoint-GUID: gWF5ok8tl-KtTmJSDOKSsOQsG_XYHrjB
X-Proofpoint-ORIG-GUID: gWF5ok8tl-KtTmJSDOKSsOQsG_XYHrjB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDAzMiBTYWx0ZWRfX4gMw/KJHFcrf
 cCAdzHS05HFL9KW2UpNU1Xn8Ga0nDdao3QXioAjsJ/iodAcmrZlYtBDEr8do0T+6ng4/bzIG2KE
 zVqHdRYlTK+9eZmT+EvQaMDdiLUpFxY=
X-Authority-Analysis: v=2.4 cv=XtxvqlF9 c=1 sm=1 tr=0 ts=6aa4ba27 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=YewATkuy8WJuXZ8dQloA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_01,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120032
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 9/11/2026 5:08 PM, Taylor Simpson wrote:
> Currently, we check for register multiwrites during packet decode. The
> downside of this approach is that it only checks a single destination
> register for each instruction.  During analyze_packet, we can check
> for more than one write per instruction.  Further, we can check for
> different types of registers.  This series adds checks for HVX
> v-registers and q-registers.
>
> Note that multiple writes to a predicate register are allowed on Hexagon.
>
> Changes in v2
> - Rebase against latest sources, including Hexagon system mode
> - Add checks for multiple writes to system registers
>
> Taylor Simpson (10):
>    Hexagon (target/hexagon) Move code out of gen_start_packet
>    Hexagon (target/hexagon) Check for GPR multiwrite in analyze_packet
>    Hexagon (tests/tcg/hexagon) Add tests for multi-destination
>      instructions
>    Hexagon (target/hexagon) Check for vreg multiwrite in analyze_packet
>    Hexagon (tests/tcg/hexagon) Add tests for vreg multiple writes
>    Hexagon (target/hexagon) Check for qreg multiwrite in analyze_packet
>    Hexagon (tests/tcg/hexagon) Add tests for qreg multiple writes
>    Hexagon (target/hexagon) Check for greg multiwrite in analyze_packet
>    Hexagon (target/hexagon) Check for sreg multiwrite in analyze_packet
>    Hexagon (target/hexagon) Remove old way of detecting register
>      multiwrites

The greg multiwrite change seems to have an issue here. clear_pkt_ctx() 
needs to clear gregs_multi_write?

You can reproduce the test failures locally with `make check-functional`.


>
>   target/hexagon/insn.h               |   4 -
>   target/hexagon/translate.h          |  47 ++++++++--
>   target/hexagon/decode.c             |  54 ------------
>   target/hexagon/translate.c          |  88 ++++++++++++++-----
>   tests/tcg/hexagon/multiple-writes.c | 129 ++++++++++++++++++++++++++++
>   target/hexagon/gen_trans_funcs.py   |  10 ---
>   tests/tcg/hexagon/meson.build       |   2 +-
>   7 files changed, 239 insertions(+), 95 deletions(-)
>

