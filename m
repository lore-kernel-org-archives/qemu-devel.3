Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C8FC531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmoZB-0001mU-Oi; Thu, 23 Jul 2026 04:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmoZ6-0001kV-SC
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:14:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmoZ4-0004iE-Oy
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:14:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N7BmBm3158250
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cE11xcKfBHr3K/YVBoYn9qdqVuZ9xJl3/FIT4mC8e+s=; b=JrQvD+lxwRShIbfj
 GOsTxrOzYtH5INjZVDnEOgLfRDuqHiIa8fRfJxAX5eETlT/qMe6LADZWMWQtyiY2
 09Um/Aod3LNY+x+h+s2iP8ra4AxPqcEYALpOeldCyDuOln+nQ/pe60W2Lk2qKvI/
 rNTdsrkdv4FGynLyYEmtHJ/kngwth2GLIKc2J9i1USIdRkgEzIkc2Hps5HJDJ6u5
 r3oEJ2wyIRtnktmRVwGlB4WH9nWAHkJlt3Rsuh4FlFNNGSxvR0c4e1TYM7cU09ND
 dJXyWouqYWNSJWxTBbYmjXPXeh/NgGTyMaUdNv26y3cFqGnLerscMZyd22aGhyC4
 SfNALw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke0krahc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:13:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so6125321cf.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 01:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784794432; x=1785399232; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cE11xcKfBHr3K/YVBoYn9qdqVuZ9xJl3/FIT4mC8e+s=;
 b=NvBCYDl3Mshi1iIuyHvA2zuu315ZM3WV6rSDuWToU1kG3NVb3aaiI/cwX9VPzxcHUn
 uL1M2suh1cpMd+/REfAfonyNjU2XDFp5pAtz9VLQxXO789FBKE8stZ3ityXn4yDhxcHM
 r12/cZu2vYRF86ozvN1wG98rnDwms3QsvPxeGRuQEIw18Ld5lkcYPXRwcilNzx7fHfAv
 FxvjxZVa5uS7NPzCanVJ1M2ry4o71u5CKF0wSvIwzdy/QTCZhM2wKZpCfl3MfK2t7UkL
 V5Q0qz1EP9sfv/JcEFxFSQERoTLJX2x4gz9yeCOCX5kxcxtfYFbNLKhcmdn7Sf4dTIA+
 dUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784794432; x=1785399232;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cE11xcKfBHr3K/YVBoYn9qdqVuZ9xJl3/FIT4mC8e+s=;
 b=cvogDkqAZGsnt4HVrj09kRGKtKl0YXFVpXZkPVRq4ofYzpyji1Xjj445XJWdbW3NL/
 42DiXRaIR0Nu/IK8wRbnacAbnir8Kxda6MMj/g4Bw/yuD/0+463xNPe2Ev8fliPkmzbq
 kFEyCsWTv4HnREHnAxcckFBawhotE4Nf/e+ZOwmpktIj5Cbb55zQB+04XGsj4O7EOg4O
 YbQQq2PV515uWld+4VVe1MpBmFYNd5R0v7IY1T6yDEGjVdTQeLpDWci1oosEq8iTYzmX
 Qy10hDW2S8GvXCOvXOqDWvBuv0JkjdeLRDy7YGYYzEUwnBjesBSfJnqQNck1j2T41ouc
 vsmg==
X-Forwarded-Encrypted: i=1;
 AHgh+RopSE531EodE4iA+PpsOjZz1veUbVFFQrBcbKoh4pK65F8IrvqRBUs7v2OYvUCWi3Z+BLIO76K8nGCO@nongnu.org
X-Gm-Message-State: AOJu0YxsCQ55nTp6Mx0sUDVOMCcBkNU8IKNJaSfftElNbhaC/mV0cYiT
 +UxbX7sPjI+WSzMsRPDfJfi0PsME4SPPi4pqb9CIFlfypiYNHtI8+o6mGnFksuJbbq6RSxwajwP
 2+MxPEhI9UmxGTSX+w5YC6I4ccyRDgbtjzdDDnTaE4XxhhgICogB8G1a+BA==
X-Gm-Gg: AR+sD12oKqFO26iRDHTuMTwHWUKDcvWDIv6rQzvIflwPVfI/4rrbXBLcizJ9XYJBsfp
 G34wNhTrgEy+FHx5duNq3nJGF8DhogXsCbYCNsjonOUQYTl2HIdl4CVHmYtfh520RYr0AiKHPNw
 SJEnI9RFw4pg2K+S/PfTn/iVy7embUk8M7ixJ+iaWqebkpuUavpKasH6wpVAMPjmUes3lXfps/r
 c0YKbgQTQ6YUfdYvvX2Xy+d/AVl2Q+Ljs7EQR7u8+C0pI0yGjQRLBdHd+czEHkNiCozT+VIH0na
 HoZpTdJ/Fl+ZF8dKNc0kL2OGQ4RlqhnNiKD9vSyJhLhJkG5lf0Z7yanOM/h59mzZVVBVYKwWs1F
 UkkW0YGMYpjAOHxIuGZHEgxYdTKgN5OwbfkS+dA1WDxmhszlD+Ck=
X-Received: by 2002:a05:622a:2595:b0:51c:1fa1:80da with SMTP id
 d75a77b69052e-5283df4fdfemr18925371cf.40.1784794431914; 
 Thu, 23 Jul 2026 01:13:51 -0700 (PDT)
X-Received: by 2002:a05:622a:2595:b0:51c:1fa1:80da with SMTP id
 d75a77b69052e-5283df4fdfemr18925291cf.40.1784794431583; 
 Thu, 23 Jul 2026 01:13:51 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b4e8885sm87631385e9.0.2026.07.23.01.13.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 01:13:50 -0700 (PDT)
Message-ID: <6b9145ab-7fa4-4817-aa62-17b48baa63cb@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 10:13:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] hw/net/can/flexcan: Remove RX SMB raw view
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
References: <20260723070059.6332-1-shentey@gmail.com>
 <20260723070059.6332-10-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723070059.6332-10-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aknFxpfWPtezn0wMorD8Xu181laa9K7w
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA4MSBTYWx0ZWRfX2tGlBuswGtgW
 X8vae1eG2eEdu92pDGPL1s6QmGFy3YFXlSW+XvMAOMZNblnBySC3A51Dq1eNaUh6xl16VFW6q3+
 KaEAgqjSl2+C9MKcIkoz5zAFDdYG1Ls=
X-Authority-Analysis: v=2.4 cv=S7DpBosP c=1 sm=1 tr=0 ts=6a61cd40 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: aknFxpfWPtezn0wMorD8Xu181laa9K7w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA4MSBTYWx0ZWRfXz3qUN3gLwwGf
 5/mexCt8DgZzMn31WMtvlaGQXxk0TcPD+ocx6k6umPBoPet2ms9nHWTPsyXQQGi/icRmtGKeuif
 0wBtvjgCgkRex1at5ogde3Ww92hZl4AYFfPd3aAsBEFf4X3aMZRR3TwYG92hngkOYpq2nBSmOm7
 +QFEjzjGCV0GB/q/xRFD6W/UXbMWiH3kXyV9r2AsYZSQYoXyHUntoaDKwSukhikcu2tQlIR5H+G
 nAJG4JwJ9DafxqC9XMYW1LC9BLJcEfdnwkuAZzfxlpEXmF02WALmSDNdLkajVwdeyFDUwaNxqIB
 4xdEavZuSUSbQ/HTIC7/yPugzqQG6tBTt4rOF2zSyYkgN7xVf2f+3SWUAkthUNZIgYjDwlKivhC
 e+oDg2Lk5E0YGMNVs/oTaJvU8gwBQhwYBVlYrhOsVSruPxfGGl5KrTbNPFDfkBSeN3dN0qyaK3H
 7Uxk9838w7IJKCqniFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230081
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

On 23/7/26 09:00, Bernhard Beschow wrote:
> Use the existing `rx_smb0` message buffer view for register masks instead
> of the raw register array. Since all accesses now use the structured view,
> remove the redundant `rx_smb0_raw` union member.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/net/flexcan.h |  5 +----
>   hw/net/can/flexcan.c     | 12 ++++++++++--
>   2 files changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

