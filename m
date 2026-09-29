Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181DCCA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBPX7-0005mM-RB; Tue, 29 Sep 2026 00:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBPX6-0005m0-30
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 00:33:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBPX4-0005Vh-Kf
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 00:33:35 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47Ycv3242098
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 04:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 430JWjEgr62QaEjikqEaUKiyLNIOLP7cl7lk3bAOOko=; b=MaW08szCbHjN2yqJ
 TdcM0wMKHXZ4i+ymO0TbPobNFBp8vXx54uuj1BlXJC4A99Oy3hubO6nMrc9yFhi4
 XBNepSiPJFCrriFd6vTpaybGaGKqaxWWaQaXTqAHdnWelxN5lBnIFdZ7fxrppiYM
 4l6u4qZKZ5S3OQVina4OfdVGh/4tpieKPtIv6SDdkkMJyC/efu44sQmVA41hhG+e
 LXnVZ+SGPD11io7eoSqKCAlOFPYjIrHBiVkqooOnnOkXvD6KvnudCROkTpg35tQO
 jZiPZjSQ3/3F0mGuTL076TWXtSwdCnwie25XuniYnz/3V+qUKwBqsIP6U5pEk2Vr
 vyXi+w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0144s29v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 04:33:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-53328840cbcso73505851cf.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 21:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656412; x=1791261212; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=430JWjEgr62QaEjikqEaUKiyLNIOLP7cl7lk3bAOOko=;
 b=kP6LubDqyQnBHRD1n6SB2/cDgLAUlT6ksClM6KtCpplyyuFZOF2v+c3V7znswm9G+s
 oMTrhT42ggDEAJwifVqRKSw4faHW/MiCYoTJUYZe+w/vimaCZni2OF3uGahK5eUNFNCE
 ID2iR5Uo9rdyDskUtCYG5VbMhCQ8O1VDLoI/xPHnR1uELRGrI3DHMcF4roQ2PmkWV48j
 Y9JwKFZxDoJW2oKXV4YBMnLzA+SU126Iz71NIz5faI4M6UC4kN3tG7RT+rOaU71ATYq/
 v4EBhcQG9w3ShZhjWzlYZP+lTZXFTRWUlmGQA0d2gV4W7FsV6b5//OuLpYliIoiOZ2uT
 rNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656412; x=1791261212;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=430JWjEgr62QaEjikqEaUKiyLNIOLP7cl7lk3bAOOko=;
 b=B8GccPNPUqik1RuO/R9+MKiPkvIVR7g7xjZGC9kWd2Hwx/45phMk2p8EoXrWT0/PGA
 hYx8hXAUqqdWottTIFC7W9R4Ay0ckr1WkXXtb8jRaq3Jis5TDoAs5DQlw8SRDD2GSB80
 RpEPOH9ZiEt+0La6sDQs3gJgqycS0x5bWTbEgdv7ewUg37Skw+q/fYvi9T1mvXfnHdSD
 12EYLdnwE08ZdKQGd+pPSlWtXxRfv4rbW5utcNkKZfZbu8EYWiKRrT2RAfReZc9J+5M4
 Th+HRZNAOswNX7IPVEnFLe59YqYrORNLDwIdDy4GU+ph+k1JX8mZLOiusEUkPr6k+TeA
 G77Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwy2bK2uVJzs6JgP6W9arinvtwDoTwdV6i7YpWSdUGYUiarWQUQTNmvgAxK7nPoMt++iJ5qSX0XCh99@nongnu.org
X-Gm-Message-State: AFuF++kAY+wOXXKZjf/34L3Pk/WK4rqNriUD69au1v8dUSjltCl9VQxt
 SuY2vXlqnnRNWeaf5mUChMIgWjht5VimLKPwVy2n8QTwn/oKsPeZue/MWreGKWB0PlN5iW1gxbh
 zRt49DX+nfHIZARPjs2RHAT8rSVAH464N6VNLOg6W9fDr7Sc9rMbiOajbEw==
X-Gm-Gg: AYBFou1mDBNANj1Hik7KzhJGO9hg+CAWgBfMHN5xAZWiAmUiY3Wm9T2BRn5rHzR5Pl+
 ZXZSihkPA7QccbZlxMLy3jSTAKb8BVzGboGqI9TyU0PhBXkxi1Yq7LfivtHRpLY1FMSbVDD3voN
 +FFKU7AibPTs/9I2KSF5P8IDbxQcr7vM9qyTk0l4ZN57Z0FNiZ7SMd3WJKAya1dsj6iYGtweHzG
 MVdCwsn0/L+EXCbrNhevxCuWbJsGU0Fz82FgZUkKG+QD2+5eC6C7fen8E3mN7T431bVDg2GqXsd
 LwSPPD1O4ib6FplMv60oezNwUEr9zyO6zjXPjv3bWb7A8ni/1toqsXCfMAgvWwwZJSKsVZ62EEL
 i+dQ9BuOK023PXz+IgKs=
X-Received: by 2002:a05:620a:1b92:b0:93c:3d7e:6e90 with SMTP id
 af79cd13be357-93c4749a6c1mr2235236585a.32.1790656412179; 
 Mon, 28 Sep 2026 21:33:32 -0700 (PDT)
X-Received: by 2002:a05:620a:1b92:b0:93c:3d7e:6e90 with SMTP id
 af79cd13be357-93c4749a6c1mr2235232385a.32.1790656411551; 
 Mon, 28 Sep 2026 21:33:31 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.52])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af508b13fsm601732f8f.27.2026.09.28.21.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 21:33:30 -0700 (PDT)
Message-ID: <a6554812-f075-406f-b364-8b8eb6caac1f@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 06:33:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/char/dw8250: Fix leak when creating child device
To: portias@oss.tenstorrent.com, qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Joel Stanley <joel@jms.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Michael Ellerman <mpe@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260929031644.1016354-1-portias@oss.tenstorrent.com>
 <20260929031644.1016354-2-portias@oss.tenstorrent.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260929031644.1016354-2-portias@oss.tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX9KOQAXU5o+Eu
 1hotfbjavJYwA6ebsZWsyNRK1zbiF+CkYcjYc336NRpkEjkmUjlsPxgf16/1jHjCF2TTo+dOQKW
 64R/od++ePFWQL/PfopYmvusHyYUaG9inGStpZzXaSsZxx44fG1HFonqklPmEV1Cq5VCYgYSm+E
 4OtNOIQ9B57z+X81aw8npkC/oURYwc9wYJmA/vnmmy4n5ZUtzogII9qJ3/i7Fn/TxL2xPWtm462
 +Kfni8NFjuyO+k/jBmFWQv7gkuLOXAPuIkgqfPjafTqh0uxgD7aLCcO/LqPbkosLuMr6q4EYQHP
 Oj+08VK/q+SzLGkX+dOU7Q7ksOt4shqgAR3ZL5zu1TbrE+5P8Avb82T5M5ytLbYxkfxEuoGuDd1
 zRnDOTAKDlKKhR75yYzmXanuP5s5hvA/j32+YO7M4DgmX0OX/jLu6uD7bRBdCDxf3WCROp3+jk0
 3zkk95VbnkNhQiQh9nQ==
X-Authority-Analysis: v=2.4 cv=FJSOVOos c=1 sm=1 tr=0 ts=6abb3f9c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=QTt6BuOzr45adi7bDCnRgQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=t9496tuAAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-ORIG-GUID: 9ZJta1op0ZfsNNvfnoiLDfeH4vGKu53t
X-Proofpoint-GUID: 9ZJta1op0ZfsNNvfnoiLDfeH4vGKu53t
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXzZyXvOID5HC5
 cMHKKFTKZRLIAt3ZYIDiReaN8TyKmdC2dwVn0pinwecbyQP7lm+iXjTuKi/XbivjqN/cei8ur91
 XXSHxQ0BldMJQjYOPF/lmiB/A69Pxuw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290017
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 2026-09-29 5:16, portias@oss.tenstorrent.com wrote:
> From: Portia Stephens <portias@oss.tenstorrent.com>
> 
> dw8250_instance_init() creates two references for serial_mm, one from
> qdev_new() and one from object_property_add_child() which leaks the
> serial_mm object. Fix embedding the SerialMM struct in the DW8250State.
> 
> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> ---
>   hw/char/dw8250.c         | 11 +++++------
>   include/hw/char/dw8250.h |  3 ++-
>   2 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

