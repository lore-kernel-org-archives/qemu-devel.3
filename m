Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8CCC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgeT5-000138-9P; Mon, 06 Jul 2026 04:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgeSj-000123-UJ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:13:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgeSi-0004IL-9I
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:13:57 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66678GEP3976384
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 08:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W4SYNlglxIb+BNGGzPNXPrKnhqZKsB8gN7dgY4BSw6s=; b=SZdkOEondfjEwLer
 klk1RYL+3iYOQ7zzn9kYtBg4EXODQSw9hrjMXAGdCbS0w4oYdGYZtlx1vCf75sLg
 7rAjeNFl6GckB8P5+iNSqHQxvV3T6ypu+PrCgS9Bh+Zo1VmL2Fn4ml+VSeDeR8pi
 5D2cJggz+F9idWhEccHhEL9c3r6JOzSoNdPZ174B92gFoheIcrRKkdAkqEW2R56z
 53oPOwVJBxHecKnUuQFlGshG6tIWha0jUs6i3O0zQmsbCEvty0rYYG+GCturRzyP
 IXk/TBeA1i/sXOlbh2X+xkOabBk8B/LmAZUx+5N12Ti9ePAH+KQhGv/I9jqfktr5
 tBQLKg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7g829-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 08:13:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92da6f3cc81so338396585a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 01:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783325634; x=1783930434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W4SYNlglxIb+BNGGzPNXPrKnhqZKsB8gN7dgY4BSw6s=;
 b=NbuG8EJ7EDSTUXrZflW/91HaaRdzuKesbcIczKtcEPta5RKFOyk3pZuscUATKxCndn
 uKMme8kyqY33ytCuF9lQ/s6VSWgAzLDpQBO1IRzTscaTVpbo6YOKf3q6MdrtWW7Ackxy
 148AeDSugpV1Aiv6bNXgj1pSqyf9y2le6oFCGaBocG13ZtzqwrhcRz4GpPIN4D5fzoAR
 Z3A9If+BKKSpn0pVL+WHYZpwDbLcEmjP6vENAILqPMuyqBZ+sT7csYuXJf/6HCie+chY
 4b6afXOtBNRllQD4J/XfLMcnZXB1biKYbYcIFU6jLuiG9yeiLIT1lj047E0CbJX0H9WV
 85bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783325634; x=1783930434;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W4SYNlglxIb+BNGGzPNXPrKnhqZKsB8gN7dgY4BSw6s=;
 b=MXHuyF9/MXEJCgY7bUKEHUeN6GmEm6rX9MnWAAdYFyjYsj90LPlvL8AtNbA7npC6On
 yynPZ0pFlL9rokaFnaXuhoW05/rndCvprHqHhoVrCluoSke1/6iPsdqxm8iSKN49iU8P
 Q0w3ooaO9TdN0DMowxr/Lia/19NAwlRCzmGL+QD4iRH0RtLBS8BhNRPXiozCT4xI9HZR
 H/uX5eIUT1wBmHv/7hGnonVe6xt24ytZy6fKF9DwfLQxTJ5kWjUHVCYoURcEzqVAEKd9
 oIQ2AIvjOx7ua1cEg+vbeb06laiq8R/Jqk1J7l526Q1ruekPKN8/qm0XEd8XkF0K5Tua
 DfQw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoEJKJXqZZLSnwXxMq6gJBfWbsKXCOd6GYXxcQSlCdPQmN2/D/l+UF232UPezJA4yKrirU9+bcPdtPU@nongnu.org
X-Gm-Message-State: AOJu0Yy58YlW9O77/laiLKS4YSOj7ciR5tFeZr/1PpoJQn91yr+WG+de
 jeEq5bXcGmJYOn1xRL0H6zUUYpTkosFnY/+loK+IFmLz3MFC0p26AD/CNzfJJ6xpe5HDM30pvuf
 sG9QBdrCqqFJu/f3do/80KFtyopmNE1l7fwdMCoIlsMmBKihuxZwq5k87KfrLSUu18A==
X-Gm-Gg: AfdE7ckGs+irB3qfbnajygEcFFkukw1m/zo7m6zyPyPxvmdO/nDtqcfpHyZOV6ba/eh
 NgukTFEZOda02n1/eKgIz/qMLuaDkNOhqaxpZk2YJoyf6T37//0lqsIQuuNYfJQirxALCl9+h7h
 kSUxC14YmYg/E4TwuBYP6ekQqQbKzvvlJ3Cam6/dzSI+yijFt2e56CKuyYby4d9qD8T+hDul5eD
 QdmgYt0ZKyszX9PnSqrjyCLBeflwiaq7ROY4namzPVKU79kxgGoVkY3s4zdGUmjJtCjwm6X+i8P
 FmCU3tnZWKxmmvjtJ1WVlfuMWE/4FpEYwdx/ETfc+ep7Wa3UpK0MLecu5PMd8aiOcLX7OPuHcRo
 +7bYdk5ZBpJmJBBvo+RxEheiMuJGMa7imN7/agDjjdIRHHhGACsY/XFfYhTXAwQ==
X-Received: by 2002:a05:620a:44c3:b0:915:8988:4e55 with SMTP id
 af79cd13be357-92e9a4a150dmr1224552685a.40.1783325634170; 
 Mon, 06 Jul 2026 01:13:54 -0700 (PDT)
X-Received: by 2002:a05:620a:44c3:b0:915:8988:4e55 with SMTP id
 af79cd13be357-92e9a4a150dmr1224551285a.40.1783325633779; 
 Mon, 06 Jul 2026 01:13:53 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce12c40sm446548385e9.13.2026.07.06.01.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 01:13:53 -0700 (PDT)
Message-ID: <806cc48d-210b-4aab-a104-d07b71454572@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:13:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] docs/devel: Document SSI dummy-cycle ownership
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260630135729.466264-1-bin.meng@processmission.com>
 <20260630135729.466264-11-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630135729.466264-11-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MiBTYWx0ZWRfX2d2lXstvSM91
 g6aFJxQT8z9im468c+MLDp2cMX2oRvBYSHqJ4jrqFI8UBY6eYp8tzyYU8uPmmcCpU2ygKtqfzoq
 WhC+1DKLhbj3zcPntUd8YizCwregHncZcw1YbdCN1d3BdZROtzg3Lyz1yJKSQCspa59x7535qGw
 JnJlNTuPhowJ+VyGax98cVWddG0GsKICNPboCBUS8WcAdXr/zvxMq+X72CY+Zv/PVlE1uzEtv1e
 ip3aTzwMMVJCOPJw7YQZ/UdZkutSHDzzpozmvqBr57n5ngEuvOI52F8dJy24kasGZlnwpGJKxeB
 xGQLR6kHmmt5fYrz1SAGwOhFGf+Tm6mdPQJdTuCiAl+MH9eeixL/7PjCXpOoqLmODfqTRg55ha0
 +smqbZlibBUUMp7zFp1mROPOpuKRG/ht2Xg7ae2LEEmjnUJMkxmT4TyFlyy6zOa8PMVpecBaIJm
 VOvBZL9j5vcunIgoGkQ==
X-Proofpoint-ORIG-GUID: LnaWBEFJulV3n--G9HUZIGUpWo-f2QMp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MiBTYWx0ZWRfX7ytolBs+NUwU
 pmVW47jLv7HVm/8jwJ0CMk2DjhNdGMzAmXP6D12i9iFu1X9z5xXE8fspv0jjxRfFDsFtQILgt6r
 hIll3JX5c85EjPG/7OFi1338p1wbAYc=
X-Proofpoint-GUID: LnaWBEFJulV3n--G9HUZIGUpWo-f2QMp
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4b63c2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=A4Rrh0e6378w-Xg4wBkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060082
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

On 30/6/26 15:57, Bin Meng wrote:
> Document the boundary between SPI/SSI controller models and SPI flash
> models when representing fast-read dummy cycles. It explains that
> flash models own command semantics, while controllers own
> hardware-generated dummy transfers and cycle-to-byte conversion.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> 
> ---
> 
>   docs/devel/index-internals.rst |   1 +
>   docs/devel/ssi.rst             | 132 +++++++++++++++++++++++++++++++++
>   2 files changed, 133 insertions(+)
>   create mode 100644 docs/devel/ssi.rst

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

