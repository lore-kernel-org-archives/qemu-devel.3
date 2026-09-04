Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B49C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WWB-0001eV-74; Fri, 04 Sep 2026 12:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2WW5-0001dA-QT
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:11:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2WW1-0007tv-Hh
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:11:48 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684EjK7N4158892
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 16:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 319RC2bK5JelNNshAyAdW1rnMQ1Dm5h0J3wBGe6Q/n8=; b=KyMa+m/FQpPXp1Hq
 fMQLyvVyyiWbhBz9cOOfUp7J/w76vQaOjJFT0S6gYIq8hSQX5hsuYnqZmIbyrafg
 XsSnpMDtmeHVnNHAxkxaoNB6T20UEkooCLs/H98VAPLPT+oTam+mZ3OwZfoG3vUw
 HHzNDPAutA1nA3MSt7QUk8z8rT6OnaHXMNkPxAEM8RtIvCEvPkYiiDFOSdHPeJuX
 E4xm/pthrS8FR3TeKmXBbyQ/ski/WRS3FLW4Hp53IAcQvQUs0d0uid2yTktfCG1Z
 21oxr8DkZgKAJvbFWHabvJcHn+sYSoRSZgitXR6cwCm9nzra9A68GkcOsq1NHksf
 y3lGhQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg011gnv5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 16:11:42 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-785b66a7017so300033137.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788538302; x=1789143102; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=319RC2bK5JelNNshAyAdW1rnMQ1Dm5h0J3wBGe6Q/n8=;
 b=CTpMPUDr1t9L63xz275nsJHzk+gE7QVY4gJpO7MgBlS+LQYCdyo09oYnmW0aj/AzX2
 fXK+xQQzZSkRuJiqsMz5y2vlo9ldKjmRIt70+cTAcaBaoaANhFcQKJkbTK0dGjH//WJa
 KQBVZVfvwUuZ5ZX9acxP1QblYVju/WM+wzDPp6ed6CymRB118hh1sNLvfwQFFWZnVpHE
 vusMYHShLMUoRipHbp45EWXBUMK+X9PCwn8ea5Sk+u3ALE8zOLImYmEBEwMU+QLObqLf
 XPhH/4BXVdktqsDHHiCgcm2CaIXPWzxKO68VPJpBIRehUsh3OMX5/+813wu1sxZXvb4R
 ya8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788538302; x=1789143102;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=319RC2bK5JelNNshAyAdW1rnMQ1Dm5h0J3wBGe6Q/n8=;
 b=K6XK2AE/UqJr2ytKBGvYu43BvdO4We5y+UjeIPUmHFnhyTVKbWdVVAg8FqNiNZ/ybh
 fAOlnvRA0Ea9nsZW7/8JQSr8cf9jwyZTeGPsaYgIqFFKM6EeSfAre5N6421aUVUeCRCV
 t0eFqFOyMULriANTMlez3KxIyfVUaLDmT9C18Ze21EJd5zko8MzyywBBFu33vXMCGq28
 2DL8r7pNmxYNKhey9gZlN3NfACm5kl5Wv/dWotBrt3y3Y53CToO2lxpx8Qv8fjkQ7O9X
 etMKaaVXFzk+SCCJmd5LSs/XacFxDBPV4spRkdMSYdMnWYNqdtlpikGroHpBB9ZqVMNB
 DBrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0L0NEKey36ZEAJEp8u6wtGHO1HiHd6HbK0fosVlu8jMNBV69GvWrF8g5rsieeFt8XVFZykmVHY5eB@nongnu.org
X-Gm-Message-State: AFuF++mSobMXakt9G1ut2EMhFra1om2Xd6hq+fQBfGCuV4K6IuldzAZY
 iinE2binnSF8+FHOROjsfXtINhvOxidg67+otX5Zjfjq00gCyICaxkX84Y4j6JGqoYCeN2fWXkp
 cGVw7pjK5/Rb+RVLzPuUcMkW9Dw6UV/lfhSAt021BHPg1AoXehxDtQZSZRA==
X-Gm-Gg: AYBFou2b8gMQsMZdKhTspkA7RBm3VFJOTN4S4CPHfzQDM4DMjWKlp1pBurJNp7Bak8E
 yR32IGR5VQF9CjV2ddJf9vf2R4I4BKkWT3bWiMuwmnh/Ae0zCDUDGVSRHKOKKFU+JtTPNa0SRw8
 DIUK6LDrPHHwOIZCkPCvgo6isP7JeZp1Hlp2py8MW4izpPkhI2jrJQNjGGOVT3zgRxVZOG4LXde
 puszo3LcKy8G4uxovlmN29Czj510zaJbhjlPzYL3V300yZ++DStGpBMQ3VwFbl9VeSUSea2Q1f1
 LE3t1ocsFkwrJAJL7/BLPFMlYIoArF3WCcvosLX2cpk9WBsfqM/KFw0Lc7Bx8VUYPJSEr985f+y
 68aoSv12x57jK03d7ll9G6c1PW6VkegbZWQ==
X-Received: by 2002:a05:6102:943:b0:782:de7b:eead with SMTP id
 ada2fe7eead31-78a4a68089bmr2218817137.1.1788538301572; 
 Fri, 04 Sep 2026 09:11:41 -0700 (PDT)
X-Received: by 2002:a05:6102:943:b0:782:de7b:eead with SMTP id
 ada2fe7eead31-78a4a68089bmr2218793137.1.1788538301030; 
 Fri, 04 Sep 2026 09:11:41 -0700 (PDT)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858ac2b4cdsm5738768f8f.16.2026.09.04.09.11.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 09:11:40 -0700 (PDT)
Message-ID: <7a6ef890-a630-46b3-aedf-a687fec487cc@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 18:11:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/24] hw/riscv: Restore Microchip PolarFire SoC Icicle
 Kit firmware boot
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bin Meng <bmeng.cn@gmail.com>, Chao Liu <chao.liu@processmission.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Thomas Huth <thuth@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org
References: <20260904155758.3833179-1-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260904155758.3833179-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0NyBTYWx0ZWRfX+M+2wLJf/Joa
 yy03r4tEj7ArcvYkFRYRIfzNH5wbb/tO6MF9izzrSdhbdEsxAmbN+dhZfgjvxI871RBxFFdvXl/
 6a9TFdGK0AiBsyMSxnevx7M/86ULvEj194jtUHJ2sBSv7x7kOjUx/VNiER+O51wkKxEMMpXxorP
 jV/ym8JCc2aZzJ2gGVrQCd/zgLS6DdLH36rnQhvSb7VVxrv5i49Bg3Omy95xq2QIcsRY7Fldvjc
 cVLPy9aWCFrZqtB2QAyxGr8OCKja66XD5vWAzreWDb8sCDt8xQuYVCY8dHRZ8UPcL0e8OF5zIjs
 x1W2h8uvUWT6kD4t14hJ5xgPZVaRV/QAWrfls/JjW6n8SuWPwo0hkaHrB4/UOxtQ8nXd7qO6Dog
 EgjnB12ivb58/kGoJN4VWjBZr9I+1nXEUSrxGRRUMe3tMyRJaCS87FGreHN0BW9UFXEoq6mwRHh
 dvw+EkBoa+/ARX6f/UA==
X-Proofpoint-GUID: albAhsLJdlmRRIB4ojT-9LZ6uqv8Uqej
X-Proofpoint-ORIG-GUID: albAhsLJdlmRRIB4ojT-9LZ6uqv8Uqej
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0NyBTYWx0ZWRfX9xwFALXnheEp
 WeCjYTS8WQR+6T74ibH+WlX7/YQYjC+Q9DNqzEZ8VXV1Wv3fufkeLP/NP5TBWUFBrg0ifodzG6Q
 emycpxdS2O4Z53UhCoXLqxysZ39o8F8=
X-Authority-Analysis: v=2.4 cv=Ibi3n2qa c=1 sm=1 tr=0 ts=6a9aedbe cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=fSYeKqFsUNyXvTew9nkA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040147
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 4/9/26 17:57, Bin Meng wrote:

> Bin Meng (23):
>    hw/riscv: pfsoc: Correct the L2LIM maximum mapped size
>    hw/riscv: pfsoc: Map the L2 zero device window
>    hw/misc: pfsoc: Support DDR training with newer HSS
>    hw/misc: pfsoc: Model L2 cache controller registers
>    hw/riscv: pfsoc: Couple L2CC to L2-LIM
>    tests/qtest: Add PolarFire SoC L2CC coverage
>    hw/sd: sdhci: Run ADMA independently of MMIO
>    hw/sd: sd: Keep high-capacity memory blocks at 512 bytes
>    hw/sd: cadence: Add 64-bit system bus property

FYI I tagged this series (in particular the SD/HCI patches)
to review but won't be able to until Sept 21. Not a blocker
although if Alistair think the series is ready.

>    hw/riscv: pfsoc: Enable 64-bit SDHCI system bus support
>    hw/misc: pfsoc: Model PolarFire SoC serial number service
>    hw/rtc: Add PolarFire SoC RTC model
>    hw/riscv: pfsoc: Add PolarFire SoC RTC to Icicle Kit
>    tests/qtest: Add PolarFire SoC RTC coverage
>    hw/misc: pfsoc: Honor PolarFire service notification requests
>    hw/riscv: pfsoc: Correct PolarFire SoC DDR aliases
>    hw/riscv: pfsoc: Fix Icicle Kit RAM size at 2 GiB
>    hw/riscv: pfsoc: Fix Icicle Kit hart count at five
>    docs/system/riscv: Document Icicle Kit HSS boot
>    docs/system/riscv: pfsoc: Document CLINT topology for direct Linux
>      boot
>    tests/functional/riscv64: Add Icicle Kit firmware boot test
>    MAINTAINERS: Add PolarFire SoC Icicle Kit maintainer
>    MAINTAINERS: Move Conor Dooley to PolarFire SoC reviewer


