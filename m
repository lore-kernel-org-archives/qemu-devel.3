Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEAAC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjIi-0007Ku-Dr; Mon, 06 Jul 2026 09:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjIh-0007K0-3N
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:23:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjIf-00081u-Js
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:23:54 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxOq7245846
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X7WMc+n75AIeEaz0vOa03BmlwZRHVpbkoxgIF1OKn+0=; b=U8BLJpP7yO+9gSVt
 62sxD5yQDkiC3BrXBPkXRxzq9/bwDsSHFK3CcrDWA2fFrehQpjLO5/XE2j43+iO7
 7y42aGX4KWFfw8Wu7JfZhVi2CN9A9hFk9qLZi1h4LK3OmOgILsUbUZyRYtJHbA9N
 EA+3rxQAw2sHuORAMY/XCYAPEyovgTtnsr54jSRsfm7wqsZZEGvWIogKgZyiy0ad
 7QeKA8TsmRL8bIOdcJY3BA2nOfZV8rZLnZhIDI9r8aTJAkFUQCt+aXbINe6PQXIT
 lb2MREqLkbCMiWejynK8k6wxNUeORTFmHMYv5yxqpHXewrEOn2vlZxAkpBrdwzBA
 +QM7kA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98gr0e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:23:51 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8eeba1d9e47so36910916d6.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783344231; x=1783949031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X7WMc+n75AIeEaz0vOa03BmlwZRHVpbkoxgIF1OKn+0=;
 b=IF+EN1fiCgo8dMumnC0IuE14lNO7m1XDNC1/KIs6WIVF0NMxze+NjaIjjHFUI+TC4a
 jhYjKqEkyWEtQw7Ut4FIBvokMGsyL2FrH6ktwms8u6SiF8MqI6QQyOo0cZ+AYJrKFP1H
 QgiMBnoxRql3/24cd/UpsuiYPy48yZPqZyEDVb1oyriiy/8oDAkpdktHNb3r4JMtuL/G
 UbkMwTlbjQwowe6GIsXEDxXRsp3RtRFbRUJ5MyVUKQ4digm+0gWwgHsVmZGHV6YntIHZ
 ECBSn8kyPZ91Do6XrZebeCX3mzZzXOhKF5rMYTkxKjCQvfiSvNlOXtvm4zn8VDULTGN9
 oMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783344231; x=1783949031;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X7WMc+n75AIeEaz0vOa03BmlwZRHVpbkoxgIF1OKn+0=;
 b=jNoldYZjXqzwcaLRUrcFU5VyT2p5IUXPShqjvNdJkTMxR0uWstocKFqNWOZck/pkkm
 bxnnoPHcTpyNA88NxN584NIgS6Zvj6DLh0+5nnAk9dKlURENtDKcFKlxhC0MaH9iLGIo
 zt/dNkx4hMBJFjJ1KGvRC+FcJ1IitZZOQSuIlsXyGyxz3IYVfv1kCJB0Ex+qM9U3WNtk
 n8+2KUmJl1JMklXZK4fW+LNHV09ixwEsyx3DydGNTwvpI0pkKdJedTlkbRwlGhnhFlv5
 ScG9VmTVI5XJ9852O8yW3IFnEAHN/E4Pk6LlzKytWyrqdlCRQUPFjlJuQoZx8+qTJyU7
 M5Sw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhY9AQCMKYKakyJvUaYG1JxefHgLnLKv78EsiYsRt/mUfzlLMPwiXKxZRRX/XAebcQ4hZE77pDA7Tg@nongnu.org
X-Gm-Message-State: AOJu0Yzrk9kiFhk87s0kXUSMCbyjX22AEiu6tY8foiktz6NRm86FOrMR
 RjJ0aoImii+7RkL9A12jpJrKPtfkzxsoSr3mnAD0bkDjwcn2Aaw1WYJudEVS4agpy8d30ZaL+Zb
 vEMsB5RMCvVzRv+NQJSH3HJia9Uz97N9aP8rJmRmGqf+lVZm1ZcNyVW69wQ==
X-Gm-Gg: AfdE7ckSWMg2E9OkrcJS+LwCtEwSh3w6bUrz7t1GOFu3rHGCa4B81Vp4h8bOpezi+Bd
 wsCcsyTyvX+fbTmgi7YQPOe/AKr2EuQw6P4U8tNF13cDNJTDqDW4D2V4o5k7sGS93NV5sD8c7DL
 SdFj/bG1Ok1HpHa8xkCr0FvNyYD965lQ8bmwEwK7eb6/xx5OfG9OUoDai8QHbQyat5P8lJG+oBg
 iaT6lCXgnn4VSI/u3nQXTDWsD07esOu4ePlIzAuOLxL59APSpzBq/XTPxoEj4XaNXotav/a9SYZ
 AaiXurq4RWpk4hVU/EhpvKdRQyTj92ZQcPNXXNzeFqbjGy7ghOQtcLi8w5y0R1fq7riGRz35Tc9
 C4QIBvqrBnlCQ6UksucspozWwIv8CBQK+BqNcbdefuc4TnFrq0Q==
X-Received: by 2002:a05:620a:6403:b0:92b:67e6:8ac0 with SMTP id
 af79cd13be357-92ebb5d3671mr66990185a.74.1783344229390; 
 Mon, 06 Jul 2026 06:23:49 -0700 (PDT)
X-Received: by 2002:a05:620a:6403:b0:92b:67e6:8ac0 with SMTP id
 af79cd13be357-92ebb5d3671mr66983885a.74.1783344228831; 
 Mon, 06 Jul 2026 06:23:48 -0700 (PDT)
Received: from [10.237.61.207] (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef1807asm322546955e9.1.2026.07.06.06.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 06:23:48 -0700 (PDT)
Message-ID: <34d3c169-95fd-4ff0-b0a4-503c3b07fbb0@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 15:23:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] hw/net/can/flexcan: Subclass TYPE_CAN_FLEXCAN
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, Paolo Bonzini
 <pbonzini@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Francisco Iglesias <francisco.iglesias@amd.com>
References: <20260702184038.178196-1-shentey@gmail.com>
 <20260702184038.178196-3-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260702184038.178196-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4bac67 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzNyBTYWx0ZWRfX6ml0UAIwAVHW
 P9e3OAgRob5a7NDNaDWx7jO08OfReuMTG2De7KJqt9IVmRIxF2qEjWPkVMztRaWbXAJMRAM0ixq
 VdAFak9Li8xMvxqSStUrjfIVZijLmZL+VJJI/Zhv/yCmm0bWgQZDUHbYlrUiyltI8p691d0O7Tz
 yaMbToQxCejI9x+OgOyL6GMR1FwlPJ6fYfSh44pT4amwXWj6AbAtuLhxXzer9OTPvvSI5xm/g5R
 W9UPDQsvksj/fhtXFWTNXa/Ty7dLf4vBUqBX5+0LAfMsjJhx5fMEAx2ROUiCb0SUiwFjdDfPJGF
 XP2euRo8tOQH8494FznYF7xgQcrNQz4WUOKhgHRLixJQzbCvgye1CmMmArmlIZ+gMrO3n8b06ap
 u+Pmm2uhB3rUJDGa7PdIYZQRMkE3pw9q71zx5Z1Z1IzJd4sqUGrf95Erzm/QZBOfHI2ik6dg79A
 kXxah3iCt/S+MDxsiLQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzNyBTYWx0ZWRfX8gJHTBkY8/mI
 4rH8CCPVMEu4W84UDgw+s8A0foLXzIPODj7nD7t9zQiiWlSsyoI74PmC7vgWsjsarGY2e3TUHS9
 BXfk9I68E1syFYUaPWRbXUpTc7QsUB4=
X-Proofpoint-GUID: sBXOJwhd9W3FSsCWVhKPE6mJsboXLf0e
X-Proofpoint-ORIG-GUID: sBXOJwhd9W3FSsCWVhKPE6mJsboXLf0e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060137
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

On 2/7/26 20:40, Bernhard Beschow wrote:
> Subclass TYPE_CAN_FLEXCAN, yielding TYPE_CAN_FLEXCAN2 and
> TYPE_CAN_FLEXCAN3.
> Since TYPE_CAN_FLEXCAN is now abstract, TYPE_FSL_IMX6 needs to use
> TYPE_CAN_FLEXCAN2. TYPE_CAN_FLEXCAN3 will be used in TYPE_FSL_IMX8MP.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/net/flexcan.h |  4 ++-
>   hw/arm/fsl-imx6.c        |  2 +-
>   hw/net/can/flexcan.c     | 78 ++++++++++++++++++++++++++++++++--------
>   3 files changed, 68 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

