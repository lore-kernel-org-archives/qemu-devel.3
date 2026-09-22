Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB01DC982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 04:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8sZa-0000Sl-FU; Tue, 22 Sep 2026 00:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8sZX-0000My-S0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:57:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8sZV-0001kW-WB
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:57:39 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M1Axjc2173289
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D4Zs/PJsocnUTD44j0r5dzq9vFL0yAinHuWuzm60m28=; b=LddEM/7x42XHRyy8
 WZ06ZqpfXX7wJAI1Gh1Kb3E9hbtGDyKnx/oF8iJbwLEVNkPolss4rQRA6fQKWqRG
 3JsDd2IaCSHk5B1ipeVYAEU4AvUPA4h0pz2uWLHQVW5elPblXCTVmNNv0h6LxDnw
 YV7dfP6DYLGZ0g8Xe2REL18A7OKO1oyn040x8QVW9aU+rQx4wuv/Y+pgjIeRLAfB
 uOvky/4igKe0l1sxYJbgsKWheaxVQ/ThcXM5ujWev9qYlDZbAca8jUfYca5XKnfO
 ns37SFrbm12pjfodoeFWjokpCfxpLGrjwK47p/EeedV5HsNvdEYOO/rlb0Ii+yP4
 sCRHGA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufsq8ns7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:57:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934963b2bc0so584949385a.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 21:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790053055; x=1790657855; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D4Zs/PJsocnUTD44j0r5dzq9vFL0yAinHuWuzm60m28=;
 b=i4nXmPU+uDSG+iiAs1t2EEm81E0c+zu2shSiQRaG4baKrpPeBSNwrQgXYgBmd8SlKy
 Vb7Um6AzqlvhyXU3J1VYRw88UVDOUihmXnQlJZB0M57v9s0IzWUp1kZu5h89xSAZTw/t
 Fi9ueogEFsUZFnqTwcmvKuEp1jo4svNfO9wg9cXxPAB1QJuJSnqHblPDsax+F4gVbc8+
 e7ABgVCGO7u/c8EYxbP+7kg78wpfJ4PORJyl7jyXBWZYkK4kLOk8WmnUmg77NYQsNmkw
 GhEWR3s2vPwdUA7iwyamHgc01fpgSsmYrJTBQni82rXxRo5R6F4KD/+zk1fH0dhi86Qc
 6uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790053055; x=1790657855;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D4Zs/PJsocnUTD44j0r5dzq9vFL0yAinHuWuzm60m28=;
 b=KZNTQn3z6DJYirFHz6+WCtnsTIMoY/PrCDuwf/8tQzGv6r5Xl2Y5j9WRh0CzrVXJps
 FIz5G+9+cbG7MmP4W4GdORIaSaYnShbiUuUZ9xNog4DtKkAasGzta0UgrOSkt8bDJfIc
 XnNdacUeLr321ZBfbFBzV8ScktL+7G253yUFfYSS/YMeSbaZbK5pTRBuReCAh3pC2JdL
 OAYy+I/CdLknmUfswRpjh0kZe4eYibB/Dk0LwbS02mYz03U53PZ1AfwVcvNlF19SG9aP
 ymCrjhE8LVtf5gholnJRJa34TSEmD4K9z/xkMj97M/BRzZsdRe2QPHD2F04nuq5FZv6P
 yzvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBws+N1yd8XLDrVZQu9V0zef9B+SkkMxdYUAa7W0XYPlEZzPN+6FDIg6bu5AUJRqi2Xv0c+S5dsw+gry@nongnu.org
X-Gm-Message-State: AFuF++k5BxAMooaTKz8mIT55xNg8u8dfRRfNKEjd2goWoSrKx04lz1Xb
 WcOwUciFXAIYCZE+eMtO8zHKTFrB+zzDiqBIzCmfl0cQg80lmiMp5vu4X6vn+oazRTzKMPYY2JM
 kRhRVZFdBO4ObU59NPDFt4t6H0ijSVKzGkBuU+pZeZoGEZrUloHdlLucGEtBxV61Ydw==
X-Gm-Gg: AYBFou2RRZqfyFSw8dw9lBQe5ZSEfjJktayxKacyh4awQijLNXE/saQr34SeTLXUTa8
 STG9Khnwdkx9qmI0FHS3PrOw9IwYOdTUrhHultHV0Pcn08nmE/m+sVyiodoYnqQ0Esqh0oTEZ5m
 Oug//YbTbU4fafDuADeyrPC20CvYrjVVhUQqlWHGichN27YDK4PiFwZuyB/Y8LMGzNThqnvzmWV
 ussK4KPtg5bFveR1Lne2d62cxaKnycScGfdak7LGZ0MECwmtvD73K8/iRWKO0qf39QGuzqevl0X
 QcWXMdOlZXSQfGA59Um28RhVIXutIzetX/owvKXFNYldBc0E7x7uaZRyeZn3WlhW4jzG5b7cqmh
 C15kExYCPwDPW3KeNX1+GcUWzSbm+nwWEgQ==
X-Received: by 2002:a05:620a:2b86:b0:93b:d79a:c46d with SMTP id
 af79cd13be357-93c15ed99cdmr331696985a.69.1790053055422; 
 Mon, 21 Sep 2026 21:57:35 -0700 (PDT)
X-Received: by 2002:a05:620a:2b86:b0:93b:d79a:c46d with SMTP id
 af79cd13be357-93c15ed99cdmr331695785a.69.1790053055047; 
 Mon, 21 Sep 2026 21:57:35 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdab8ae6dsm43543515e9.0.2026.09.21.21.57.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 21:57:34 -0700 (PDT)
Message-ID: <4ede31c8-2000-44aa-a222-270f9e5a31fe@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 06:57:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tests/qtest/usb-hcd-xhci: test isoch pacing with
 MFINDEX above 2^32
Content-Language: en-US
To: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Feifan Qian <bea1e@proton.me>
References: <cover.1789968699.git.junjie.cao@intel.com>
 <eb57b4b9bd78f08d248fa1ae7ed5d2d5958c9ef4.1789968699.git.junjie.cao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <eb57b4b9bd78f08d248fa1ae7ed5d2d5958c9ef4.1789968699.git.junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UKv7MmmlNTGwB7W4cJFZIbR1Y-T6D0JE
X-Proofpoint-GUID: UKv7MmmlNTGwB7W4cJFZIbR1Y-T6D0JE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA2OCBTYWx0ZWRfXxILn283i/P7d
 duSjLW6/Y7FSEWxBK/FOHPV2aYwNi59dnj2+Rbf0hnbx0IKPjsEbMorqBAVfvEgoURseCs/2UPn
 kJUfVyv4iKM32i0sSoYGd5rBSqCIx6I=
X-Authority-Analysis: v=2.4 cv=NKBAaE6g c=1 sm=1 tr=0 ts=6ab20ac0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA2OCBTYWx0ZWRfX64ahFDyaBtL7
 YoN6f00WFii1jBj9QqcuwDL2xzpVQReRSTGO7G3OF4i4eX1Er5jQUu5OX/OG2098WMyiVg8+Wyz
 BFVyjQMP3pPdx60qisy50fcMG2qQ2QB53x0aT8Nu7fR8Rst9rg8pHOx7WvEhzhFvsmAs8DvwPMw
 5jsXgscjGFuG/HyE0H/zd87WnXLzjjXgJ68igqyiBsP0NCDxTaYqPflzCsTgOfDDpZNV2BlXHUP
 moBN8kIS0G6uAHJYI2PPAlURMGD6YffH+WKia8jxtXowA08Yc9FOzGn6/6paY/oisX0KO+xxgoF
 E51taLlqXWIb+NnycBc/1q8EaJxRRB4JtwKkINqerZnenDTIf/42vg6xNeI+UXACopnFiJjZL0h
 0yAHUK+mC4xBs+CmCeC40GpeDcft6WsUWknpdIFHd6UqbCkTkldy0pKAVANBaXEqa/hHK5/TojX
 sctksfVvX2a1+fR2q5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220068
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

On 21/9/26 07:46, Junjie Cao wrote:
> Add the minimum needed to drive a transfer ring from the test. Use it to
> queue an isoch TD with SIA on usb-audio after stepping the clock past
> 2^32 microframes, and check that the TD waits for the next interval
> boundary. Before the ROUND_UP() change it completed as soon as the
> doorbell was rung.
> 
> The machine is started with pit=off. With the i8254 present the clock
> step takes 26s in an ASan build instead of well under a second.
> 
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
> 
> Notes:
>      Nick Piggin's v4 series has a fuller xhci ring harness for qtest:
>      https://lore.kernel.org/qemu-devel/20250502033047.102465-1-npiggin@gmail.com/
>      The helpers here are self-contained so that the fixes do not depend on
>      it. I can rebase onto that harness if it is revived.
> 
>   tests/qtest/usb-hcd-xhci-test.c | 283 ++++++++++++++++++++++++++++++++
>   1 file changed, 283 insertions(+)

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

