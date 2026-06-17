Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E947CCD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZpnJ-0001fa-TW; Wed, 17 Jun 2026 08:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZpnI-0001fE-TQ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:55:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZpnH-0003o5-46
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:55:00 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8UEUN1735068
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 12:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h6y+BJ/cQMMyqhId7tuAY56wbONoXd7cForu4LUQMRI=; b=TmUMifBywmpyAHW6
 YNgH3Xme51a9jW6WZ5BgHHabyr+5WY2Zmcap92fjqQCV1wGRhl2znqA5nLg5IHkL
 saq2taPgDd9BpWy8AvdrJjEwAUDGYKBQGb8RxslkSGROQUPhJP6rS5njel+OBSur
 BIHQ8FShONye0JJrYjF8Lt286osrroMSvJ9Zzu90tEMva2WRS+0Bg00p8oSMkV05
 NqBsbxV4UsoaDe6jD9e6VCtr6Ayv2rjRMjcDyNzmU2Gr0jr37NuZnhcySBkWqkSX
 uC0LaLU2H8cBdae8OZ6W/lU9Lkje3tZEwsp2i03Pt1iNt8Nw6PfmMQwCBZec7G0R
 IrcL2Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueemk6rm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 12:54:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-519c01e3b88so3593531cf.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 05:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781700895; x=1782305695; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h6y+BJ/cQMMyqhId7tuAY56wbONoXd7cForu4LUQMRI=;
 b=bcb0j3erO3IA6bDZKU3iOGSMZCQbZlbGfih6kTos3dnLJnt9H5qxz8qCl8i6a4J3jv
 Md073LgFej7NR3pKB9s3NONQv2Djr1CghNfzLwF4TXRYITXZtioksx+lNmvM7mOlRcDu
 zsGwadChwCT93GnDPdiCMCjEviGhjkv4M6VU5Ha3JTdf2JrGetnCu8DSX7CB+eSnVqoa
 KcYyWzTlyGP3IiXaZKXVs15fNbHBjct9fXbFqCkMYwZGUeZsAn2hrlgIH5Yfo6XDewKf
 n2EsRIIhPgORP8pU1d0V8LuFZXJUnpHuech3NjIHB1lVcltB1SvLyVWSE5AIzfwy7bVl
 4C+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781700895; x=1782305695;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h6y+BJ/cQMMyqhId7tuAY56wbONoXd7cForu4LUQMRI=;
 b=GsXqlDYrQvM8VpxrIdLYpSyxTYmiBHlFhl754758jXeDHkLYc/qVRgjn6up1GG9c6k
 5mr/aNknnk1ZYec7HSMbnIewvDT8aFPT6qzLAuCiIDHraC98kpezhd/ijs/5dCHNhJNN
 FxGIc/Xl0Ti8T69Q6rzFOR6IGzhC84KGRMwM9pnA79SK5pd4b/dCo9JCnCXntq1jE/8p
 02P+HHsriqRQ12hdBrAn7j2D1089D+nEvnotOR3jXYhBh6CNj3c4LuGmIsN1VCqzoZVD
 UVBMsfJF/M/iWfZR+P8RcQr0i01jKbrr25nGYSLy8pSAO2w/4qUL7JpP0bZOuCbrWHws
 rB1A==
X-Gm-Message-State: AOJu0Yxn2JeR6Em5zG/vvr8+FsmfLSACejn69Jmh2qjmUYDAcUyMU3nG
 lreWR+BspqpyLghyWZ0rgPkDRwgBEqSL6mVFUL0Nh16ZlnGxFsG160qmQvqfar0nT/vZHUXw/Iz
 AQJdoma7olF51WAUuKNSmFGgWsvkcUk+D0czhkltxWVSVXW8tF5eAA0zX7w==
X-Gm-Gg: Acq92OHuVsf68rgtFDJIjdkUaAY2mTxbPzJP7awnwHvF90xu+npbJAeUOAETK5bnLkz
 ARvvIxmo0YgqmL9dayYGbPnm1q8tQPKXJxpkCMKbiwUentq5c0MoKJ0ON/grnKYgNxa7I9Tn6/o
 F++DMHcCwiu8lU/UJpumyLxo+1SFaScfAQbMk5h8/Z7XcRcUU5AgDu8JXZAIgdhlC1cWc2kTWqp
 JZLSoaW3XKdJHLIjMN87MVxmktccdyTZ3eI25LG2CNPzyVRyzOCrkiV5xUfYnN/SPnmZtouFAQY
 3fh2/Bdz9TBmpw8l1ll2rAe/sT6Eg6iQ7Kf2P+qyyfjhNOE9H4sOcmGf79g11u5pTqjJ8bj7ZsF
 9iYf87mb0j/RBRGLuxnb8F2iPPgtyAXJTXNioRiSYNX23O/8=
X-Received: by 2002:a05:622a:4a0c:b0:517:599d:ce19 with SMTP id
 d75a77b69052e-519a901afa0mr52113471cf.48.1781700895023; 
 Wed, 17 Jun 2026 05:54:55 -0700 (PDT)
X-Received: by 2002:a05:622a:4a0c:b0:517:599d:ce19 with SMTP id
 d75a77b69052e-519a901afa0mr52113211cf.48.1781700894681; 
 Wed, 17 Jun 2026 05:54:54 -0700 (PDT)
Received: from [192.168.68.103] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb7a00desm180182361cf.19.2026.06.17.05.54.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 05:54:54 -0700 (PDT)
Message-ID: <a7eb3b7f-1fa6-47f2-bbac-49316db5f2d9@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 09:54:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] target/riscv: parametrize debug trigger number
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, philmd@oss.qualcomm.com
References: <20260611123412.2135600-1-daniel.barboza@oss.qualcomm.com>
 <CAKmqyKMUN-iDhhAF176eZsVsdDd7_-soL4CYL0vYfxGHkFEKhw@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAKmqyKMUN-iDhhAF176eZsVsdDd7_-soL4CYL0vYfxGHkFEKhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEyMyBTYWx0ZWRfXyc5vDacWkgBl
 90FRsXXIN62tfTJu8oEbDipVj7tOlcG5v4PNOzraci+8MotdjF5dvu7AQEAYYQMbC9HKNpAt+++
 O3l7Ey71RoipUgbBzVH5e3mx/I0FdIQ=
X-Authority-Analysis: v=2.4 cv=D4d37PRj c=1 sm=1 tr=0 ts=6a329920 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6xgfUjCFO5uoiGiy0l4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: aROgzOqvEgzkVrA1zziMLs5U0_RF-5_g
X-Proofpoint-ORIG-GUID: aROgzOqvEgzkVrA1zziMLs5U0_RF-5_g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEyMyBTYWx0ZWRfX0w+HgddBA2ON
 T5fV3Yk+7VC8FXB2qYA0i68ZEm1D0b9w+k9BgXnRQgB54zOU/bpLS0mVUmJDq69Ksy5cnDM/eDI
 MVL354hhJbq3zYQgmppgPf9k4upE/+z7NhGIfo6WtPaMYhUDjy7kW7EWauLlnyEfaITA8Z7pUHC
 hKc4ZMoi/huj0zPOD8NUD193rbJd9FM1Hw7BTbs5XA0/J1UBcPNGNXARTitQXo5A1NorkM+LGCx
 3bOSEUEYGkATvlyYQoXzL8XO2UWad06R9y46V7ttIPHkk1fy/k9Sm2TNhKVXlUFqh5H5CoYSIck
 Mp/pgJelnNff5dOsr0w+i+YPIdKSI3LTfmiiBCAO2JWkKuEHJ/2lAOnQudwToxDXaqFbNCQ6gRz
 aO/64ttv3+/jq8z5+Msue1f8urQG8zDsOVmSKmeU8sTB5uJDK0VntjZxCwrUW64hPskU3PjawBG
 h8Ut/moDCxOv8ZSGh6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170123
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 6/16/2026 2:37 AM, Alistair Francis wrote:
> On Thu, Jun 11, 2026 at 10:34 PM Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>>
>> Hi,
>>
>> In this new version we're adding Phil's comments in v2, in particular
>> the need for an unrealize() callback to free the stuff we're now
>> allocating.
>>
>> Patches based on alistair/riscv-to-apply.next.
> 
> Hmm... I can't get this to apply. Mind resending?

Sure thing.  I'll rebase and send a v4.

Cheers,
Daniel

> 
> Alistair
> 
>>
>> Changes from v2:
>> - patch 1 (new):
>>    - add RISC-V CPU unrealize callback
>> - patch 2 (former 1):
>>    - free allocated debug trigger arrays during unrealize()
>>    - change version_id and minimum_version from vmstate_debug
>> - patch 3 (former 2):
>>    - do not touch vmstate_debug version_id/minimum_version_id
>>    - added Phil's R-b
>> - v2 link: https://lore.kernel.org/qemu-devel/20260610205457.1868701-1-daniel.barboza@oss.qualcomm.com/
>>
>>
>> Daniel Henrique Barboza (3):
>>    target/riscv/cpu: add CPU unrealize callback
>>    target/riscv: dynamic alloc of debug trigger arrays
>>    target/riscv: add 'num-triggers' debug property
>>
>>   target/riscv/cpu.c     | 26 ++++++++++++++++++++++++
>>   target/riscv/cpu.h     | 39 ++++++++++++++++++++++++++++-------
>>   target/riscv/csr.c     |  2 +-
>>   target/riscv/debug.c   | 46 ++++++++++++++++++++++++++++++++++--------
>>   target/riscv/debug.h   |  1 +
>>   target/riscv/machine.c | 16 ++++++++++-----
>>   6 files changed, 109 insertions(+), 21 deletions(-)
>>
>> --
>> 2.43.0
>>
>>


