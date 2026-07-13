Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB29AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 21:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjOYp-0007nY-CG; Mon, 13 Jul 2026 17:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjOYn-0007nG-Ee
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 17:51:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjOYl-0004W5-Jh
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 17:51:33 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9QLK2256819
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 21:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KKHMr9bFfcq/0D6lX10S27Fe3wdgOv4r77LhsbDFkEY=; b=N0p122fl+53n3oe5
 Lkw3xESCcdCJa0dgZapXtvnC0WkDJtr4n3ntWpA0o6YuG0+tTH31uOKIyy4ZQ7tM
 /AZ/O3iwr7CDCqE+6HKNXGW60hXE8kubsD4B8pR1LAhw0VCzZbBmNcCYxC8QvJ4n
 gT3JQ6GCtiGoKxUQUJVn1sgB24BPzLt1Z8lG1yx38AeSkk2hEZCyyXnBdEJ37amZ
 eb7irZmkJMTQAOIWnyqUiCMwtGeKgL07O3mnLJkkxzk9dNWl/JSJcYRzLewDYIQC
 LWVRb9l1d5TZ09KATeIAUj/jLLN2ifDw+Rl2D5l/XebT/0Cx57494nqs3IU/zvG8
 eA5jXg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk9tp6p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 21:51:29 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3810960140eso3861290a91.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 14:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783979489; x=1784584289; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KKHMr9bFfcq/0D6lX10S27Fe3wdgOv4r77LhsbDFkEY=;
 b=TWDUS79EPidG7xH+i2Vo9cNMl6+WGJ7E29HT6GrJ548nViHJAOlbNDfwgNSqyMxeVW
 V5ITrfRSgO0zIVnn3c+wyzsQjqXelzA6SSRbbjAgANii94bkZcsTHz6wZlOSrsq1WUhh
 Po4XfQ1yHSy5savCdZCs234vq0jdWQKW99raJlxZLYRp7kH+xmHzB0imLafduN71tkB2
 Ex1DU+GPKwDmFHFG5DimmjEd4JK4XzSK8CXYNWBLkOtrG/VzjTflHDsUMKPRJ7a0cBeO
 SjXgBBOLwV64/F0FtrGbVMtyfLTjSCn9jcw3rR+HT7oDCpbHsgK15xKXB/0hw8BsoAEh
 4rFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783979489; x=1784584289;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KKHMr9bFfcq/0D6lX10S27Fe3wdgOv4r77LhsbDFkEY=;
 b=Qom2on8ADYDlG9CVooWnASGi0LvE68xGltIxlAIt6CbuLeXeOTDzz8CUVFD+0vzTqv
 IRsfWdMM81ytAL0oR5xEon/Xy4XYUNE9X3t0PPEWSofrQ++0tYxGgmkFNs0U8nZs0dgJ
 2PM39LQx/IS6jmWqhEgYK4evQ4qYtvb+2WeAH8NO29qNNo1KEyKsmoQZ6tYRCiKDE4kQ
 KJOa/7Um/BSwsFqOdOfjyCN179UYesu5f4ii0RsY+qFjGT5TFpNiPEolKH3SdPHe2HIt
 8gTD78pNtI6drFIvPe6DT9L9b64DY/BbOMn7vJN2Ja7Vvpu/gz5lP1z0/nfMZGgruFJP
 N6Eg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7+UB3joTZ7SInKAjfMoKNLYx3EXVFvQQjkG0ejoELmB444EhxYSgeuLN6nGtA3m/aSfflN1J+CRZz@nongnu.org
X-Gm-Message-State: AOJu0Yx6WvkFwcFuZpt4KloQNJbrPy8eZrLk8urHQq68IQMas12Nmxke
 UXpf7cgUsWViVns5VC9xKiX1PqvKC4NptPXZPf6kRhLmzbtI1Fs9vtof/ANLVs6ixI97kDYz8fq
 i0BCRfdNTzc3iYGKonROlR7EXJxZg3NQmG3G9NxOEENmDhL2ZWWx9dix8Zg==
X-Gm-Gg: AfdE7cmFaI5tKkVLFKWbrF89rr/AfiRq1PsZnBhSZzZ3qytjulsDUTVU9x+mcYt6Fxx
 XZlaNa794Bg+1HapP2JtN++SvldiNWVbi+IXGhwqnHQGjesgOHjLscd5GoGw3w8QL4Z7rzvSDiV
 L5QSi/u3Wix/4rHcbXw7M2YeR+K9doV3ZYlDbCDuq44GBPi+FiczznSkDUm2AZISYhTXEZI0R2n
 nTOxB/KWuDCgYR2U/sHRAHiNJBGTJpjiTaLxWLojRgkw+kZWcGtzttnQyEkJtS9Sf/dd7KXoAlM
 +HmTE2s0loML3doRhZ6BFEu5DQkaphnAI75blAd73h6JzpuXC68pP6e7Rp7rkp2NQpLtu8hSZk6
 3RlkSVyNsM3BvanzP2KPzLnec0IYEA8J6Utjs5OZ4yz9oOiwrNCwfouCyJEb99NCPtXjyVMwcHS
 BKn5Y=
X-Received: by 2002:a05:6a20:6a11:b0:3b4:8f2c:6805 with SMTP id
 adf61e73a8af0-3c34d719ccdmr1126471637.42.1783979488699; 
 Mon, 13 Jul 2026 14:51:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a11:b0:3b4:8f2c:6805 with SMTP id
 adf61e73a8af0-3c34d719ccdmr1126425637.42.1783979488119; 
 Mon, 13 Jul 2026 14:51:28 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm125969373c88.14.2026.07.13.14.51.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 14:51:27 -0700 (PDT)
Message-ID: <810b6cc9-1691-4671-9acc-15e42193a386@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:51:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] hexagon: add semihosting support
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIyMyBTYWx0ZWRfX919+NMSfLEdv
 rYOqcnB2A6qsVYPK0j0eIGoYIro7neS/AEaTs87l3aBSL2LU3yp9ha5zulshVgrP82Sbhs/NQut
 GUDDp0f/0/gsCcfcqOTSwRV/gNbjIo5u9yNO8qvYSDXMtxGVoPHYKMK0U9urWuvxiZewjloDPml
 ZaT/p9vmfc7PXGfQ+KfdBgsytg1iEwSESpUGx9H/3c65TlYmmgPaScH52L3t1Ddkz/JoBEBQO6a
 jwHHOMApnCBRO5gWMOkzbfPIwTLPOVobYHwrTJNBs1cZDG6swwdscv+Jmk/aeIatAafV35cKubg
 sCipD6wxttqvGOyk/0Ct3iYnb9f+Bii4tlcKA8TJbrJKneyFkUTKU1VzPkYLhJMTTWGSo3JD4UL
 y4DumOmMkNPNbe96Z6SoSCloWLpdESBa2r1fsaqv2UZxv1ZtELMePMEDjnCoBClxvJ4K5R0GoMq
 LqDdVguqBKfkqRHYLNw==
X-Proofpoint-ORIG-GUID: RN5E5h6MyITf4_8gDzAv1ZDqgHybu6k_
X-Authority-Analysis: v=2.4 cv=UMHt2ify c=1 sm=1 tr=0 ts=6a555de1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=qvhtsxRReycOrm-o9RwA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: RN5E5h6MyITf4_8gDzAv1ZDqgHybu6k_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIyMyBTYWx0ZWRfXw8ZBML6weItM
 beb1Qv2rY5K/oF9NSgiUEFzvRiz4kPWLepJjUB+oMDfkS6lCFgg+ZsBiH0FMmB+wpCebOAzdkU0
 M0pm6dOjoctdZjnm8Jo/fBsvj/jPYyU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130223
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Hi Matheus,

On 7/13/2026 1:07 PM, Matheus Tavares Bernardino wrote:
> This series adds semihosting support to hexagon system emulation,
> together with functional tests for the added operations.
> 
> The Hexagon semihosting spec can be found at:
> https://docs.qualcomm.com/doc/80-N2040-101_102648/topic/semihosting-specification.html
> 
> Brian Cain (4):
>   semihosting: add APIs for chardev-aware guest fd routing
>   target/hexagon: Add an errno mapping
>   python/machine: support routing semihosting output to the test console
>   tests/functional: Add hexagon semihosting systests
> 
> Matheus Tavares Bernardino (10):
>   target/hexagon: fix get_phys_addr_debug with in-page offset
>   target/hexagon: fix PC advancement for non-COF TB terminators
>   target/hexagon: add aux functions for guest mem load/store
>   hexagon: cpu_helper: add reg reading/writing helpers
>   semihosting: add callback to set error
>   target/hexagon: add semihosting support
>   semihosting: add ftruncate helper (to be used for hexagon)
>   target/hexagon: add main arch-specific semihosting operations
>   target/hexagon: add COREDUMP semihosting operation
>   target/hexagon: add OPEN/READ/CLOSE_DIR semihosting operations
> 
>  configs/targets/hexagon-softmmu.mak       |   2 +
>  include/semihosting/common-semi.h         |   2 +
>  include/semihosting/console.h             |   9 +
>  include/semihosting/guestfd.h             |   9 +
>  include/semihosting/syscalls.h            |   2 +
>  target/hexagon/cpu.h                      |   1 +
>  target/hexagon/cpu_helper.h               |  24 +
>  target/hexagon/internal.h                 |   1 +
>  hw/hexagon/hexagon_dsp.c                  |   7 +
>  hw/hexagon/virt.c                         |   5 +
>  semihosting/arm-compat-semi.c             |   3 +-
>  semihosting/console.c                     |   5 +
>  semihosting/guestfd.c                     |   8 +
>  semihosting/syscalls.c                    |  29 +
>  target/arm/common-semi-target.c           |   4 +
>  target/hexagon/common-semi-target.c       |  51 ++
>  target/hexagon/cpu.c                      |   4 +-
>  target/hexagon/cpu_helper.c               | 173 +++++
>  target/hexagon/hexswi.c                   | 728 +++++++++++++++++++++-
>  target/hexagon/op_helper.c                |  18 +-
>  target/hexagon/translate.c                |  13 +-
>  target/riscv/common-semi-target.c         |   4 +
>  hw/hexagon/Kconfig                        |   1 +
>  python/qemu/machine/machine.py            |  10 +-
>  qemu-options.hx                           |   8 +-
>  target/hexagon/meson.build                |   3 +
>  tests/functional/hexagon/meson.build      |   9 +
>  tests/functional/hexagon/test_systests.py | 133 ++++
>  tests/functional/meson.build              |   1 +
>  29 files changed, 1236 insertions(+), 31 deletions(-)
>  create mode 100644 target/hexagon/common-semi-target.c
>  create mode 100644 tests/functional/hexagon/meson.build
>  create mode 100644 tests/functional/hexagon/test_systests.py
> 

see some build failures on windows and macos.
(feel free to ignore other one, seems to be a network outage issue).
Also, a few checkpatch style issues.
https://github.com/p-b-o/qemu-ci/actions/runs/29283651823

Regards,
Pierrick

