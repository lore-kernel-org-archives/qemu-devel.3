Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C8C606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EuDfarTb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LRI2BWKu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXpb-000464-GB; Mon, 09 Nov 2026 17:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQXpZ-00045l-PR
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:27:13 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQXpX-0003Ce-W8
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:27:13 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9LEXsc317315
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 22:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LxZ+bdYOBjJPGtHFXhv61C1vo48xvKKQFW4wWIOJ0kM=; b=EuDfarTbQiMjA12L
 AwlApjPyxoq8pcpQIJ0g8FC37n/3XzghWe8RB9tmzjxSCSQ/3E9+CwuKTF/SHveV
 PCfbxxIC4j/WWaZ1BLeeeHYTDvM5ZcuypDKEEiqK11El84VH6WdjCfEyDSXEUADQ
 tHJs/y1RsrgsHItCMDVgN7peHFIUslrBsSYsQrVctlW7t0rB142vxWjnld7SbWy5
 0UF+STwq6m1MZLTjdbTTptjMgFCWJp5avPSfeP523dBsYv82LekrbYR+SAD+5Rzv
 sfcnfK2vMt38cFcJAs6WthZ4ysm15K+eM4I29aDUQVPs3x/MgYMIfnvb/vHTHifs
 nw/EQw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hunwkg84w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 22:27:10 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7d2d5cc693fso284028137.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794263229; x=1794868029; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LxZ+bdYOBjJPGtHFXhv61C1vo48xvKKQFW4wWIOJ0kM=;
 b=LRI2BWKukmnYsQj3VQhteb1zE5XQJTyhtV/gZs6hBuPCdbyvQGvxoLKEF8ew03KiHN
 pquflhftK/uUz4/BH0TY3wvqeUhRrftLL831PtVOaH0tqiw4MLWe/Bkz928hGQXtD3Zg
 rmLolPVLeA8psUG1F69r3FlrmXTVbw54jQbZAGMJBB90sn3CpxCzUapFuSBXYcK1ttDM
 TMjMLLpMqcr0MW7aOYAaO+kGkz/h71ZvN6hSwEJkYw7pPLvHPloJ+zB4wQ2FOG8IGlKW
 TwGZPsijpoJCs63AFK2H7QGcr1JTUCqL09aoRLqLL105LrF+POpuK6fW/kyOMhLAAKSc
 RZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263229; x=1794868029;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LxZ+bdYOBjJPGtHFXhv61C1vo48xvKKQFW4wWIOJ0kM=;
 b=WR8pxptQI0A93rXT8QMpuqycT5hEbmeOwb+M1qF5cx59uS9EEDOfWT+pPfK2pUDrYd
 nnJFQee6HrRSUxAQI0OSbQsOH8DRLlrUXl9j7QZTyo+oDRvVU6Mq5yytOS1aZTZCcScn
 ToarTMaJ1zKMMEnTB5241rFffWePPpKDJQklK7x7031QLxG54sL/cR8DGWXXWiDh/86s
 eAHUdZ14k5Z/tm9YSGYV7aayYSMbd3xOC/Dn6qsKh2rlctyqejp/w0c5LFiRrJIeNU6s
 IMhmwq4/W9QIoLG7xCTXeAbOrH8JF9nTCkbIBFf6ow7YCEjRYTjBdjANALhN3VhjrfQn
 GiOA==
X-Forwarded-Encrypted: i=1;
 AL+hErEa1wCfifweIe5vpOfBgZu/KVC0g9L6qnAoc+1eWitcW/l419bdnFNx5J1vkKivUyXmjCB5NBCQtVPc@nongnu.org
X-Gm-Message-State: APuU4Z+wRmXcC+Ybqr0r8k9S7anVcjQouaO3wv33cckcc+zDkaZ0FVYV
 RjDaBFsTkwCFe7IoWh3a6UhoERh7imyTuNGLnJgeJJlCHC+7QnVqZBFl0+wJ3+4UuODIKHQbrij
 qgwzv/mqGnEa3s2NdT916OWU0AAIt3vX0wU8NP3lNLIPEVAiwajmtEIwi0Q==
X-Gm-Gg: AYBFou1iGQmer7+ecDsLC2UYiq6fP0D95rMLcgbmqz2wnV29xs2iuqTBoPRcGSudV+K
 Io5Y0l/+kyMQXQzDc728yimFVe0XZpWSdWRxWugd8oM1tPd0yN5s9pjQ7z06bgXZ5sYyerM/56a
 4IB2w+TtcDcU/49zI8PZHWSSuaWQCOwpUYN+OBLlqLCT2+u0j4OZsvyr9PAMGyWfPqDAmqj99kx
 BvuBcUdBAxK/vCX7qcnruvc6XSHPKb5b10kmOplxOVskWDcJQ5NXsYfkyfpEvbch7T7/gOAvbfZ
 z2O0rpHQHL2XK3seNJjT6Xnm+gNhCDWYD26raTW6R/erE8biWzZswJsHvd9k6YHxV2gG4niLIYl
 sKvyvGA8oG+UZec0GQlAuCypb2GNoqANEpXuQpgIT5+7ZNEVeKO46i1A6oCPk/R+EpaLsgKoBTT
 iXnGfPpA==
X-Received: by 2002:a05:6102:6e88:b0:7d2:754c:23e7 with SMTP id
 ada2fe7eead31-7d301c2b6e5mr168391137.35.1794263229566; 
 Mon, 09 Nov 2026 14:27:09 -0800 (PST)
X-Received: by 2002:a05:6102:6e88:b0:7d2:754c:23e7 with SMTP id
 ada2fe7eead31-7d301c2b6e5mr168383137.35.1794263229118; 
 Mon, 09 Nov 2026 14:27:09 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835e20327sm1355947f8f.26.2026.11.09.14.27.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 14:27:08 -0800 (PST)
Message-ID: <28ea0237-45c0-4be7-ac71-0a98938fd6df@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 23:27:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/26] target/mips: fix MIPS64 segment access checks
Content-Language: en-US
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
References: <20261029204609.38989-1-kirill@korins.ky>
 <20261029204609.38989-3-kirill@korins.ky>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261029204609.38989-3-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nFw5hx4PhZZFs3lDlG0BmPRq4NaMeGBB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4OSBTYWx0ZWRfXzfds6tfrSOA/
 ftA3HLLL+xoN5fct5V0rr5nH4kBaeL6uY2Bdkfgc5/gSlhZw+INZlzAYh/mhvMVBFu+GotBuVdx
 u5AkfGPTZM3+uHlcZGLDpmyshWgWJkU=
X-Authority-Analysis: v=2.4 cv=TOrQ2Fla c=1 sm=1 tr=0 ts=6af248be cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: nFw5hx4PhZZFs3lDlG0BmPRq4NaMeGBB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4OSBTYWx0ZWRfX+qhRGwuFCvnb
 7ArquGS8BHx/EGFZB2bPo4Cc7nn7gKw0Nh/1D6Eb9pbgKW1TaJ0sqK3MFgHiaLlZRCAj4VqdBHO
 J2cXWf7NIHhAGSODuki/U+DiLkxPvRl1c2QJjrPjSO/Ezk3SnGEQkvKCeImnnYdjNldd4caXzFb
 yuagMmvxP7+7B2nzY55EiCIrXWZxcQxcMQ0VQ6NWE/rfKDzUezSyYOPkkV2o+n3OvxQgajNc2Rk
 PJY5d45sXMSsyEkrBxx//PRMvzGTvI5C1Ju/hhTsN3JflHoqtKw7C3iqC/oBVo7yKwPmFwYfRFu
 qJxxvmG2cvOZRcuk7yaqPyQbhuN23YVtuOq8aQ2J8LzBIBrSFIDdx7KWTUygyauy3xuM3j6qiOs
 5u7mh0pN9nrjOfzZ6RkniggUG5TCXxl0Vo7jRpEKyBdRxrW3ngIIPzEiVZAQeEcl261KmRJ+3y+
 c0Ki3jNxeUADSrGdPzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090089
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

On 29/10/26 21:43, Kirill A. Korinsky wrote:
> The xuseg and xsseg checks only tested UX and SX respectively; kernel
> and supervisor accesses must instead use the mode bit that applies to
> the current execution mode.
> 
> Allow supervisor and kernel mode to use xuseg when SX or KX is set, and
> allow kernel mode to use xsseg when KX is set.

Indeed. I'll amend:

   Commit 480e79aedd32 ("target/mips: Implement segmentation control")
   fixed the xkphys path (switching it to a per-AM KX/SX/UX table) but
   left xuseg and xsseg exactly as they were, so the mode/extension-bit
   pairing stayed wrong for those two segments.

> 
> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> ---
>   target/mips/system/physaddr.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


