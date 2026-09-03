Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1059EC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x26OX-0005fU-4p; Thu, 03 Sep 2026 08:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x26OS-0005eA-0j
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:18:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x26ON-0007nI-Ra
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:18:10 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AH7Uv1328109
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 12:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9HCBQ1G6qyBG/+h351XUxQSPKRXBQXMwwEO33OIEhT4=; b=NNF7jzbQrlfN5PgZ
 fjBwj/w6Fma6W7JuMHQ17m9G/0eZibtFXzTLweF2TqGqYwe0/9fFoere5uXILjVi
 PsJQRKMXITGZTGy4onMdxarq0xwaRsQ3lPwCuAUjA+XSOEmL4jKbWaLKUgaoEHvj
 cf/SBJ1e8BLDaoTs0x7sa7OkYzg8IwC3JZtigQQS6r5FN928YUdT8iy25QVBn947
 JFw6QFUox8fd8b7Z26Z3gAPpGRiue6MnJlzlMKcAIeqYyOB+eeOEFP39KMxb0yAD
 PkmIxIWqCNLQqwSpuctld2iGL29oNblcAzqpqF7AZzcwY1HwYDm7db2yLDxTh07Z
 mbKqBA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrnmxnt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:18:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93494cce712so424544485a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 05:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788437884; x=1789042684; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9HCBQ1G6qyBG/+h351XUxQSPKRXBQXMwwEO33OIEhT4=;
 b=Kv9ELmXuIMDoxwlJyDP0gphblKmXeSLSnEvQ+ztHlSy/nuukpR/WVeE1cvsJxhlEWf
 0nStQNfL6sM5ZfXuIaICQ3CwlK9X9JR5AVBKJdJf83TP9DUpCHxFKkqwAOL7UChsk0zn
 A3/UZ9SMXYTbzZEIen6WqFbn1ydz5VBrXmkCEAkCteZPKnPwnwOeZPxEJ1HtKXMkGxWx
 u4ao1oIAIWOndPPgeELC0GgpNGefZmmgJhbLzKIZGbIElFWxT/5c12bF3+BnKQp08W8X
 VFcHXQp7XjOB2VroEdFdgNwLBsnwY4mibev197YWLWUA9uwAEYAx4LcHRcNIoBuKAIMY
 1Z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788437884; x=1789042684;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9HCBQ1G6qyBG/+h351XUxQSPKRXBQXMwwEO33OIEhT4=;
 b=c/tCJu44vp3PiPVhB0C/227r1dM1Hf69EpGAfRmxYYssf/86OuvrKFAffnWRvzYE89
 6meDaPkSHMbqiTi0niGJgeqJzd3ZDCj7otjFAOprdh9fdnfFA8HKt4iu4TkW3fxSJEog
 UNDjJFo8qmFRHiQhQYf4SypQvsVO27shBrmby1YmtGgJF78uRmVPA23JjkUHPKi6t/aP
 ZUTcSli8To5S19I92tUgWBad6QPPNIW/rD3uULt8z4oz+MqNnPni3VbxUKWeQuBv/rCf
 b+1b3huPy0sitdeJfO2efgN8I5RibKdAqZTedbaATb9N8s81eZg7+UeZa/AgEZdWYKkV
 ChZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7EMm42TN/OLk95XuCXKIgunovZX5ChcDwk6iGAgi8KjYUlphr0ElkIgivYz1q8kYpp7sNiixV9keQ@nongnu.org
X-Gm-Message-State: AFuF++kluW7I1A6TwNhEeEdGPn2ETDnQH7rMSvXXjzcl/kJ7729QroWE
 dPwtv74BLk4YnGNM7d5ExS19KJBa0KpKM3rTFXMj40T2gBKkAWJ+L98A4r3/kLYvLPqs8uDZrIl
 uVfFmpwyYDD2fV4xYJJWdBf3KFfiezvPC9jS5LqVE++lEKRWSipLPVHMF9Q==
X-Gm-Gg: AYBFou3xnvMM1A0HeR5ZW1ybjxCIaryxETmHNzpRE250rJkVwjP9okzquLPnBvHw6Uu
 i3JhF+WbHQbuTu0Ir5FmgUhM2B3NTv/fPw9lSBgiLJkDLWFp0Bk1WWEAZ9pweE+GC/OuB+CZbnr
 3c+QD5Ja8oFSQI19g31poI9pij9yQ4ExvyY52h6ofKkBF/j5I2A7vjIxgzd6oL/Io5dYvg2mnRD
 smvNoiZVPfLe9Jb+tulNOe/Zd6ThxKSTRUSVReGoObztrF/kM5+0QlZdgea3tPVnjwgDh7Ks9tp
 YEs7/Xu4pIP6sAuEE5sgGKXcriC8gGaentJFdwne+Yn+CZHDplNk6nAtk/UxaB/d9KYWejU848+
 2DRtjAErbsld76nAkfBWH7Vq7jtFR/ePF+A==
X-Received: by 2002:a05:620a:2f7:b0:936:9525:e952 with SMTP id
 af79cd13be357-93961016c42mr991396585a.41.1788437884163; 
 Thu, 03 Sep 2026 05:18:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2f7:b0:936:9525:e952 with SMTP id
 af79cd13be357-93961016c42mr991390885a.41.1788437883705; 
 Thu, 03 Sep 2026 05:18:03 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d4938sm67201435e9.2.2026.09.03.05.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 05:18:03 -0700 (PDT)
Message-ID: <bcf359bb-5dde-482c-b1e2-6161f6498c0b@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 14:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/25] hw/mips: add Octeon III EBB7304 support
Content-Language: en-US
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
References: <20260903120510.34876-1-kirill@korins.ky>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260903120510.34876-1-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gkFW4R0Xm1nLVD1E2X7LUDl-uoX-xWfg
X-Proofpoint-ORIG-GUID: gkFW4R0Xm1nLVD1E2X7LUDl-uoX-xWfg
X-Authority-Analysis: v=2.4 cv=YKuvDxGx c=1 sm=1 tr=0 ts=6a99657d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=alGDw2F-mSSMp1XgeDQA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEwNiBTYWx0ZWRfX9lACiI33ptkW
 UWu5mQx1tiLjAYIJXkISS6llUnxZe5W68YJyVy6ps+5ju3WDUlpfW28K27ckqBS9PL7Zs/kVcSA
 uK/dSWmSuUmrP1/qeo6TgSPK0IVNC/gUrlkXBBkUbZeiOv+MB+RtRq604rSKa3PTiOoUfhVUyg8
 W/bd7Z1Uu2cIzBaVPvlr24P5cpc3WYx5HrrUlem8BujfW7BgiP1nci7B13q7zExgmytA17vVGzv
 2fVxykSlLcAsnY7LwEgni41Bvu0ahEIvWkA4nLHBpxPtE2O3Lc147rsFvm2FNIKTXQNxv7fUsDA
 UMIziWCXmIUoz+PapEoHkM3MS8dL7A42CTbw99W+1cg7fkrMrAaSFal0NVr/iLcJdoNK1TKNW21
 vHuMsPghlPb9inVwS4Z6Iaq59vWvmYxE2SVyBFdqeFx6LzUmopf9vpII4vrMuwuzteKxk/pMqNu
 KxgVoJ3NgZQ/AzFowkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEwNiBTYWx0ZWRfXw/v2MOyMlkau
 evbPtJc3fpkjfm15RFsA/r1AGAPZrckJQLeC0n7nK6U6A/IaVxICUIRCrwLrtV5hGEhEJiiqX5X
 bCEfNqy08ivt8wwTslaZ7UMM1Sl3rTo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030106
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

Hi Kirill,

On 3/9/26 14:01, Kirill A. Korinsky wrote:
> Greetings,
> 
> This is resend which includes missed maintainer.
> 
> This series adds enough Cavium Octeon III CN73xx and EBB7304 board
> support for upstream U-Boot 2026.04 to boot OpenBSD/octeon from USB
> storage or through PCI e1000 and TFTP; the same machine also reaches
> the prompt of the vendor U-Boot 2013.07 image from the Ubiquiti
> EdgeRouter Infinity ER-8-XG recovery set. The model intentionally
> covers the hardware exercised by these firmware and operating system
> paths.
I'll be offline until the 21th but I tagged your series for review.
Please ping me back then in case I forget :)

> Patch layout:
> 
>    1. target/mips: make CP0 interrupt state atomic
>    2. target/mips: fix MIPS64 segment access checks
>    3. target/mips: drop hidden TLB shadowing for tlbwr
>    4. target/mips: add Octeon CP0 register state
>    5. target/mips: add Octeon CN73xx CPU model
>    6. target/mips: accept Octeon PageMask encodings
>    7. target/mips: allow Octeon unaligned accesses
>    8. hw/mips: add empty Octeon III machine
>    9. hw/mips: add Octeon CPUs and boot memory
>   10. hw/mips: add Octeon reset controller
>   11. hw/mips: add Octeon CIU3 CPU control
>   12. hw/mips: add Octeon CIU3 interrupt routing
>   13. hw/mips: add Octeon legacy CIU
>   14. hw/mips: add Octeon CSR window
>   15. hw/mips: expose Octeon reset CSRs
>   16. hw/mips: add Octeon MIO boot support
>   17. hw/mips: wire the Octeon UART
>   18. hw/i2c: add Octeon TWSI controller
>   19. hw/mips: add Octeon EMM controller
>   20. hw/mips: add Octeon LMC controllers
>   21. hw/mips: add Octeon boot support registers
>   22. hw/usb: add Octeon USB controller
>   23. hw/pci-bridge: add Octeon PCI host bridge
>   24. hw/pci-bridge: add Octeon PCI memory window
>   25. tests/functional: test Octeon III boot
(I'm not sure of the usefulness of listing the default series layout)

