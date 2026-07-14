Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337C9C44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 18:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjiIX-0007h5-Hw; Tue, 14 Jul 2026 14:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjiIU-0007gp-US
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 14:56:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjiIS-0006vG-Pf
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 14:56:02 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EG6lPk1068092
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 18:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0sR/9CAuK7Ccbr9xo+nfLbOG/VIpcfRks7cpbGx+Mfs=; b=VQg1hhaj2Eh+NBRx
 9kVzM9yYf4aMwyLLvybol61Uxo4L6Qzr9ACfJomFHHafDNf0nmcDe2pysv2zZI3N
 XbKeKxOleC5GkxIdHeb8HM0xSzgNRKdLtM7ZDuYr9BYuw7tzFJKW4WhdHdqxcsXH
 FRTm0KegDmtkaFNO9uaXYI9zifNBOHPKxn+qc9jMsZ8BdfrbtO3kqfCo7Yrny6qP
 +qw2vjO835s4FaqRVRKGeKZzHWm+e1e/i+mFNGKTm0z5NAuqflvP/0/TP1w4lYBw
 NhcWF5l7rX9wjZDwe9RQP9GKiq0Opg4C6bTa6u7wmHf+iUVC2Dm3b7/2ZbvUVfHf
 nDDsxw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmjq1qc7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 18:55:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51e4ba1cfabso6220681cf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 11:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784055356; x=1784660156; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0sR/9CAuK7Ccbr9xo+nfLbOG/VIpcfRks7cpbGx+Mfs=;
 b=L1Nz5GaIyj3GcJGFrDBsq363FMdxhd56ip4GvNVIUm+scIckQ5pwEgYVZMOE++34hn
 ePTgAauuhowq555cl7CKXfrGr2r8xHFj6QsuEETC/PJNjGp6i8jJWWAXJW/hSL6Xhmxf
 Mek/raqvyVUcztdGwmftp58Bc7MzNGW+ixuLJJY+z9EGSoRYLZE4pnq9Um8B7Ba4ukCs
 eiWK7+nCf58vF2Nd5V59YD2sk66FJP8KYVuFwjhJVAwSo01PjjfFeX73+nwvYwkSpU9W
 ssT6UI48az3/minYtspr5D2+XwjullkvvLR3EtZtRrG2XhoyL8Zx6/WfmT8luzM82pCj
 zBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784055356; x=1784660156;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0sR/9CAuK7Ccbr9xo+nfLbOG/VIpcfRks7cpbGx+Mfs=;
 b=RvOI+OUK/UTF2qxFpRpW0tBmjU6xxdi8Vi1lwhH/9aNTiRrf0k3EQ8VEB1SkeJDMkF
 2RFty9RcUAKOjjx9dvNpCgFoZLo5YQ8aD72HJa6F5NzPxNdprgmU/odU6CN66NPHYW1A
 c8VZjTnAJiX4nG66BZDPR9wC+5Tz0b4qErvf4cUYhBD/NOtJuNqQVFHUKS5ys9PnPggj
 EISwpOx0G+tgCPe3TDTDZM7mmtu55YFW8GbYNQhLtiTMwhQgeBn4VvrA9r9V9IOeMmSu
 PH3TLKI0d5VZ4qYp2/rxaDPFrZQvRPYNGsCxfdYW6wjpoBBASS/1kbuYELDiwDnZBkL7
 nAyw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoP7ci46plJ0+aaCgXWwcT8eoaaNyrNEv6/rP+JXm723rRu4hNktWwrKQEa/XY10DznKUzFZzF7gJNy@nongnu.org
X-Gm-Message-State: AOJu0Yzo/USlmJp6Oaq85cKBO5LQNJHmc6djuih4bpYEqXx5JTTgYWYS
 lMxHcEQfW5qe1l9s1+6vXOHAdK8XgIqaGC2SX3u19T2G5ZhRQjAT9xn6tLtrE4+tGJzocxdoJO4
 RCo1PZksuSW3qjI/T6NrkLl5fvMS+Jky2819dV2WK3mWvqEjXr9wZXHKKsw==
X-Gm-Gg: AfdE7ck9yybi2a1XlNhjwFCglE6XA14S54Z8O08JSSjxU0kg+phi596UA+Gtv10CZcj
 j6VzFZFz9nlm0xwdSLdWOdikj9TzHCWXU77KlOUWtt/M6xUA5Rs5k3l+MDEmd+2bEyXhuHrBg8m
 7KbaiJ/gG7KEkjxLjnui6OVulKZtAuxzhrqIoqbYJS/bVa2nnPcBUD6zAPUQnOCtMGTIttGVwIs
 fwim3CS+N8B9cJEQEU5qaM+BFxPKm0OlUh5cA5zp3Pg+nnJ+60/3VlF38gweaJGanVBeFlSd4iX
 rVHXbdNQEyuLbIvf6buY4kAET7Cxzwjj3p6C2E4NqfdXbUh8NQ3eyGAeG3Srw5VnSVmiHfjxp7T
 Mhw7c3gfquHkrxwAtEtvFqV79RK/5q+wQ3PkcXlEIOMHuR7Oy8oz/cjQGdZDq+cLOLaIlpclljg
 4=
X-Received: by 2002:a05:622a:5a12:b0:51c:1bb9:137f with SMTP id
 d75a77b69052e-51cbf0e1a95mr138501591cf.24.1784055356518; 
 Tue, 14 Jul 2026 11:55:56 -0700 (PDT)
X-Received: by 2002:a05:622a:5a12:b0:51c:1bb9:137f with SMTP id
 d75a77b69052e-51cbf0e1a95mr138501281cf.24.1784055355906; 
 Tue, 14 Jul 2026 11:55:55 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caae23f42sm117758991cf.19.2026.07.14.11.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 11:55:54 -0700 (PDT)
Message-ID: <fb06f79e-52aa-464a-a27f-f740c5cacc9a@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 13:55:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] hexagon: add semihosting support
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LqmiDHdc c=1 sm=1 tr=0 ts=6a56863d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=G806VX0npQhuxdwwJo8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: t5TR-yQFyjGGCfEsmgUSBl4aPpeC-6dZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE5NCBTYWx0ZWRfXyCdnBxFh7Bdk
 dZyJ0WoknDCyk172joWSnHwkZ2pECz7NY1cA8lkpUbM6oqeFFUCrEPDkQlq9KzSOFIB73JlyGE+
 QCFqv42Ip1HL7Fke/GS534jxpzgsBeTPzhs1Tw65dFm6oz5bSZ1UkKkJM1CxDOfTPc0pTjnIJzg
 9fPlXmg/OiK1+BgdM+lLmcWOa8FAA5O7lta2GfzqkYLObZoTYsmQRBcO5JAo6PmOp8p3HYYq2br
 FfF/wxbehNzFOHeaMmgxzDBTMZ0Y46gsyPd1F5c3xMmAaeIjx6/sJwCSn+z7y+l66xPYd7/A7MC
 EFY7J1KLuvI0uYcJMt51mwYOyQ/Qb7DNXEe2SR5NlmCQqwyW3BNFx5iuXyvvDwnstwFbh70kE9G
 PksYUvRg4hTgp8C2HYwfkxQu7z6vnEyOmcHT1olTOjO/fDvp+ev8sxmgYjocCxGhjx4LW2wPr4j
 qsz0oURZHzRPGXAf3jA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE5NCBTYWx0ZWRfX5T/PJmOytkFu
 5bLYrAce6QYGp2kEKBRUGdM3wOGSH/TVVOOu80AgHfk8Cn9m11jPNH7z5DKwfpLBpkelMuKC/Dm
 sVd9vrsJQs+7HKr7jRGcjbfIytKgkaw=
X-Proofpoint-ORIG-GUID: t5TR-yQFyjGGCfEsmgUSBl4aPpeC-6dZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140194
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 7/13/2026 3:07 PM, Matheus Tavares Bernardino wrote:
> This series adds semihosting support to hexagon system emulation,
> together with functional tests for the added operations.
>
> The Hexagon semihosting spec can be found at:
> https://docs.qualcomm.com/doc/80-N2040-101_102648/topic/semihosting-specification.html

Please also update docs/system/target-hexagon.rst to remove 
"Semihosting is not yet implemented in QEMU hexagon" and add a link to 
the spec.

> Brian Cain (4):
>    semihosting: add APIs for chardev-aware guest fd routing
>    target/hexagon: Add an errno mapping
>    python/machine: support routing semihosting output to the test console
>    tests/functional: Add hexagon semihosting systests
>
> Matheus Tavares Bernardino (10):
>    target/hexagon: fix get_phys_addr_debug with in-page offset
>    target/hexagon: fix PC advancement for non-COF TB terminators
>    target/hexagon: add aux functions for guest mem load/store
>    hexagon: cpu_helper: add reg reading/writing helpers
>    semihosting: add callback to set error
>    target/hexagon: add semihosting support
>    semihosting: add ftruncate helper (to be used for hexagon)
>    target/hexagon: add main arch-specific semihosting operations
>    target/hexagon: add COREDUMP semihosting operation
>    target/hexagon: add OPEN/READ/CLOSE_DIR semihosting operations
>
>   configs/targets/hexagon-softmmu.mak       |   2 +
>   include/semihosting/common-semi.h         |   2 +
>   include/semihosting/console.h             |   9 +
>   include/semihosting/guestfd.h             |   9 +
>   include/semihosting/syscalls.h            |   2 +
>   target/hexagon/cpu.h                      |   1 +
>   target/hexagon/cpu_helper.h               |  24 +
>   target/hexagon/internal.h                 |   1 +
>   hw/hexagon/hexagon_dsp.c                  |   7 +
>   hw/hexagon/virt.c                         |   5 +
>   semihosting/arm-compat-semi.c             |   3 +-
>   semihosting/console.c                     |   5 +
>   semihosting/guestfd.c                     |   8 +
>   semihosting/syscalls.c                    |  29 +
>   target/arm/common-semi-target.c           |   4 +
>   target/hexagon/common-semi-target.c       |  51 ++
>   target/hexagon/cpu.c                      |   4 +-
>   target/hexagon/cpu_helper.c               | 173 +++++
>   target/hexagon/hexswi.c                   | 728 +++++++++++++++++++++-
>   target/hexagon/op_helper.c                |  18 +-
>   target/hexagon/translate.c                |  13 +-
>   target/riscv/common-semi-target.c         |   4 +
>   hw/hexagon/Kconfig                        |   1 +
>   python/qemu/machine/machine.py            |  10 +-
>   qemu-options.hx                           |   8 +-
>   target/hexagon/meson.build                |   3 +
>   tests/functional/hexagon/meson.build      |   9 +
>   tests/functional/hexagon/test_systests.py | 133 ++++
>   tests/functional/meson.build              |   1 +
>   29 files changed, 1236 insertions(+), 31 deletions(-)
>   create mode 100644 target/hexagon/common-semi-target.c
>   create mode 100644 tests/functional/hexagon/meson.build
>   create mode 100644 tests/functional/hexagon/test_systests.py
>

