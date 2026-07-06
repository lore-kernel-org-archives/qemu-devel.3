Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA1DC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgeYZ-0002Nj-Sw; Mon, 06 Jul 2026 04:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgeYN-0002Kq-Om
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:19:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgeYL-0005ow-2P
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:19:47 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641U213623853
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 08:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 acUH6e5oOeBr+Cko9BRdr9TQwBnwFSwXZjhn4kQ3eWM=; b=GmrFM1XTYLxa8P2y
 3QimuoUXBb27lFeDFIwum+09NMX7oysMX89k4cmP2KJ0/1x45XTryPEeFgVgBxlv
 H8cbIkehJQp5Fxs3hb+YJz4M4StfYh8COE0Grwkw1K4Gnv2dAGJJsNxg6neF1T3i
 TWvGqhodWXkpuOGeVaN9gQCs9OrTIPjacqwKNNso04MyK10gA3kxfCFaCF7FePpE
 lD4sn/UZUrA0B19RhJHLJu66VQz1hsjjox5ZCFDnWUTR3jpThvCGcCuEAO2d7HvK
 y2VquXtHiYAu9wDq0t6BW2UkS7WBNJZJUAAAJlAG5CsE13tw7023e+cXISgMQy05
 mRsQAg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4swcm5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 08:19:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e632390d2so524923985a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 01:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783325982; x=1783930782; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=acUH6e5oOeBr+Cko9BRdr9TQwBnwFSwXZjhn4kQ3eWM=;
 b=KIjNzcMOSpj9INz3tYCbqkNkLZTJTe/tNkPc2ON4482fACVOB3TxvDugoYzEorGJnn
 au9OYlVJyVfKXKm0A9GxlCrsFyyjqAZV60BsvV0EtDQYCZKrHAAtmOKZoiGlUiHpjOCE
 RYo6K8ay0JYzOAyE3q+RG8awLwe/j5+u4Pv3E7oGh/qao1KDNpm9KlMdmzJfelRDSXQb
 ocgZaMAd8d8RdZlE1txMQTi/GiZwwUk8cPR+fpEFuLu6tFiL5Xbv4s2CV3yXRl5DcQ+1
 TiDFGMYzUktD6x2+8SN9SqVIGVBvD6xEKnZUN7Ob6VJyDtOMIyXEzEnIg5VeZ7b2CRg3
 tFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783325982; x=1783930782;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=acUH6e5oOeBr+Cko9BRdr9TQwBnwFSwXZjhn4kQ3eWM=;
 b=HpcWRtkoq64WFsUlTkzd/T/VJLQZziTdB0hguXAikj1pzPWolmml9SpvWGJBBlp1X8
 4+aOAdB5DM7nnrWKPjI+qtwkOVRWqyj5VibQqFa3x3cUgp8uXFHI3V0XMAJxN9o2L8Xk
 7OkUCJpRWvpX5Bob9l589nAmXXynGXTr/1LBjPoV8UMdx3SBUUgySGHwSDW9/cAy8/7q
 g8m2volMtHjjaiq2rM70lQKymesytF95x6DZ00DRuQIMe9acL4wLyQw8PU/z/ea/aWU3
 z0Qg93qdX40an5SCoFXv1ZSWULVD1d63zSPcfQFvVgnmrBgI6ubjfrtDp9I8EpwhfhH5
 5UPw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1pmoeIIhb8XjXCY2sFLeKFHuGwnVyvZ+FRljslsI7+ONxEYncapApfHKCBqLSzU6QF0mXFLiyZCoX@nongnu.org
X-Gm-Message-State: AOJu0YyZAZMehyJM95N/Bfx8nD/5TImghVuXN8QGX0SFQtfLVR0DRV6z
 51Ix7gEnju4GaSMpzVSG2bYFGyFS4zTCngKn5exQXSnhHHQhGe6ySPM4qsRgT05Uev4qk/SDJ3/
 UyIfzP1LDcNd/9TmMnj+nrw6KDOMde+PN3CsipUhTM4/g9qsh8aqUUVh7Kw==
X-Gm-Gg: AfdE7cl58ePPxLtV5gkxN6o+vV00BOA+WPDV5d4XnBzehewrcbgJZ2ohzSvcy6nPWVm
 cjY6NjAfwuyQuvBD7ijChIDzmTLj4hwz9BxhTAq2qdD+1lHCi8TFEFvGGqG/CMGBjHxUG2DGaDC
 1P5PwgKYCYPYgZdIlMnd6Zp9EysyLK4uofqwjsObnj2BPrOHeAMN+1lJndNhuxp1OMKf6ZGKbaD
 214PQYRZUzpibllqtPCzAuXNn+rPVFqpfpcrMBf29Ys4OmB8UJ6MlhNvWZHKKA1gidsJ1zju4qq
 ptijuyhzAcfI+MT/7ZNMmfeYvWRp9qNNrEDFA7QCQSC2btCtaWWxHUfioj6lrfYu8FEXI433D97
 HufSWtRQ4aLcGMdtgNJqKNua/cVuEMPtQsGneUhcr26/EzotVNPnJrfi6Ko+lqg==
X-Received: by 2002:a05:620a:1a18:b0:915:6758:24d8 with SMTP id
 af79cd13be357-92e9a41d6a9mr1190958685a.42.1783325982308; 
 Mon, 06 Jul 2026 01:19:42 -0700 (PDT)
X-Received: by 2002:a05:620a:1a18:b0:915:6758:24d8 with SMTP id
 af79cd13be357-92e9a41d6a9mr1190952485a.42.1783325980772; 
 Mon, 06 Jul 2026 01:19:40 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b62c2d37sm684884566b.42.2026.07.06.01.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 01:19:40 -0700 (PDT)
Message-ID: <bb4b7240-ea2c-4738-80e1-83e259f3ef4b@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:19:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] hw/{block,ssi}: Fix spi-nor flash dummy byte
 handling
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goat?= =?UTF-8?Q?er?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org
References: <20260630135729.466264-1-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630135729.466264-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MiBTYWx0ZWRfXz8RLh66oAgQw
 2sjDdLPMuCS1fiA/nblFl1416l6q27xitx0Y2w0vQTdDq4Vhm/WzzCLaYBrE+uN4tRUNvO6wFMY
 lbxio8JZJc9rYBIUy+pjFuLpyUrCbGs=
X-Proofpoint-ORIG-GUID: Rux3Axm1v62-bqgVzgG9W1JnTKQ_CFbD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MiBTYWx0ZWRfX05wpOQ/A0hIS
 ZIOWj66yBSzJl7Z/JVu6cyZp/2YSdSaBOqtSX/GKHa+IMi6GlF+V4ypfJw3QkmdeyEsytS+jbCi
 QulZ/PsFZQVzmdcbhWD+akIbptAKN39DC4A08Or0IJMgwWlt8pCCY+/cHANtPKW+6ZevJQdUwSg
 PWnE2xl1kFQHsWfZrP0KXxuVbXRy4oAnL6Nfl6Q6CIyz/XiO3q21Fqz0uRAKm5nt18fq9SW1SKq
 K72QLYg6TBjtoTqvhpngcOuyTi6ukskAzKWP/U48a7LG8AXrvfLrDO5vUzDuCeEk0ERuT0dIpeD
 Mf+6KpdSm+CvPoDp3q0+DpD5XuZrLyL+SopIgxtYmLGpKMiHbhjngMSJeYdNg4wIcgt1N3SR38f
 yeRjYRFp3Ewo62zQ+4ep6fMHye1Y0yl8U1SWuHieUvTO5QyJFkoTElOZ+sVBrA3w1T0cBDuOxc+
 cpoQB9j53EeHtgTXKrg==
X-Proofpoint-GUID: Rux3Axm1v62-bqgVzgG9W1JnTKQ_CFbD
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4b651f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=B6AAU58NjM16s_FHVf8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060082
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

Hi Bin,

On 30/6/26 15:57, Bin Meng wrote:
> 
> This series fixes dummy-cycle accounting for SPI NOR fast-read
> operations across the m25p80 flash model and several SSI controller
> models.
> 
> The root problem is that the affected code paths mixed two different
> units. Flash datasheets and controller registers often describe
> fast-read dummy phases in clock cycles, while the SSI bus interface used
> by these models transfers byte-sized words to the flash. As a result,
> some paths treated cycle counts as byte counts directly, and other paths
> compensated in controller-specific ways that duplicated flash command
> semantics.


> The final patch documents the intended ownership boundary: flash models
> own command semantics and dummy-byte consumption, while controller
> models own hardware-generated dummy phases and cycle-to-byte conversion.

I'd blame the API. I'd feel safer having the block/ layer use bit
cycles, and a core layer converting bits to bytes when calling the
SSI layer. Maybe too late to improve. The documentation you added
is helpful, but I'm pretty sure we'll introduce more regressions.
Anyway, thanks for your work :)

> Some background:
> 
> While recently working on some device modeling, I hit this issue
> again. I then realized that I had sent a fix series for it more than
> five years ago, but it never made it upstream.
> 
> This series picks up that old work, refreshes it against the current
> tree, and fixes several issues in the SPI controller models. The original
> series is available at [1]. I have tried to verify all the SPI controller
> changes by booting real-world guest software to ensure the change does
> not break anything.
> 
> [1] https://lore.kernel.org/qemu-devel/20210114150902.11515-1-bmeng.cn@gmail.com/

(Could we add this as a functional test?)

