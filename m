Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D50CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNP9-00029N-1b; Mon, 11 May 2026 05:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMNP7-000287-Cz
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:58:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMNP5-0006XX-9N
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:58:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B5NjR92793068
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bhmaDY9VzTgslEvXamPy28hZVa33UqTb/Vz+CNYDC7s=; b=GxqENqMHkDUSFgcB
 7T/UpHsLJ+XH/kF2GOQg+utT8mtBJYbcXCxWmfDQr4lvGbK3kOECl/BQ+ZHokz3a
 EUoYV1x46uG9Mvu4T1lXWyDKPvYopdXKY/IlQ3qBJwlsBGtr90ucSzN6puHsVlgi
 POfmMFDxodI1VSafzxozMPDgCKO7LCcy1Mr374kzXpGIlYnjV/aeQhRWml4J2NqL
 75XxSEqzzTJuEYATjhvb5iihR8vm76lH5f5Wh3G3eCpvunRt2k28WZgt+8TUGXRd
 16Ck8rQ6Axdv6g0Jy7+gQJEzu0oj1jKBXZXrD/usJgme3dPFJzhWbyxKMYE90H4N
 coMFHA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e240h4kf3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:30:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51306c1076dso31614411cf.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 02:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778491804; x=1779096604; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bhmaDY9VzTgslEvXamPy28hZVa33UqTb/Vz+CNYDC7s=;
 b=aYawteJBB4yrk+7trEy3lLGL645744/RfnLMwDwnx6gD1zKpien0+7+SNnv4nH75VX
 blHK1G09U4+YBD5whbLdD4DWDBJoABE4T5rcOWQxHSSIDUvQKThRESMvbg+yOssx6+pi
 rrywwJQ5D1EOSh/nivTngdNRiuHZxncwdyDUGSpmJdFS6Ty4FJ4fY6z4O21hg6MuZFg4
 b/sSITgt2jlILFbQ/CX+PiDqI25M9nOz4o9oDLCL8A2ipV/Y2Vs764zrC8YpTjLisqwf
 5Dz4mfSPBT543pbORxABBFOm3DYnOcM2FItEjpLAFvImiPoLRtov01FfiTIdmcagN54S
 Iv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778491804; x=1779096604;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bhmaDY9VzTgslEvXamPy28hZVa33UqTb/Vz+CNYDC7s=;
 b=Lu2sKArHnm6FBQGd4qCeS9yLvfTwlZVcYl88JncP7yq0bvF15UGt4KKfqDWE0wVABY
 lny9ykrrte/J/mVAWBziRTn8k5bIm+vdL9bAZ48vEFHndCeT0qoOxrurDrCIeBPosKum
 vLMgK3YYh59ExSFYNVkwjExYNUefMW/Hwz3zvvGDJc8q+EdsxFdpyRTZB4l1vNxEEL1a
 ieyRzVz0Z++w8jpOu/Iav7T73MnnX1i9mAFJl6m5iE9qIIlGT/BWUOYO32TyCTEeYwbA
 NHGhLQ3Gx6aVqbQb98QYjcBmmta0bnm0D6T3nPU6LlJmhbtP+ZhiM+wjnurDZCQgU/iF
 TXcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ//2ZnxkBE5rGpQ5aZBHP6CxXXK8OazzS/+mCLf111rh1oLneLg4sJ1zl+LWdBDhjfqlow6QXJyScGy@nongnu.org
X-Gm-Message-State: AOJu0Yw5rZ+0OEaInyBkez92K0PIlh8qzos1eCPTtJZiPZUFyNtEI542
 ZluiqBhJjRsYZDfxPWXxQ6nxP2EyyWzt/VU0byxp8qbMtUdVlAM5zB+dfkPQGxSlfZc17+LUrL+
 4IqyZWq04260wBNgoKNfSSrPnzVJ3oH9gaj4tWpRBaH8UmjQ2JOwiuZftR7Srok3Cuw==
X-Gm-Gg: Acq92OGHIrGcC1gutfqwWT4MbgMydaF+J1f1bHPfgiD3w39LD5U4TR8Tu0riZlB1vlF
 FzNcabvs2XCukSaMQWZcpWCS8BjmGyhv/ovZ/43DWisRWB8EDwwGw0JQGhR7zeTK4ANCusNWf/E
 mS4Qj9AR9T4TvAbPCiaWk8TJW+TMZ77GMaSp1DPn+J9CrDVTHQK3SwaD1PqfdX6xvnLNnmfgrBW
 H56rQMOxg9huJwI9REJ364sUirnAXiJKTG1eajiEtA/OewBzsSKNCOJyYA3DEwJX2OCaixC5Zpq
 9KQGoMbCEdM5p2lzx46VduXCkgfcESt//lh0HFgNzdRQANIKbbxxpR/W9zep037bDtwO0Cb2mfv
 Tv+GY/0O6jhXHAoPpi0RVJ9VGd/egFMGWqlv721SH7u7Jdoei/DHkVuRVmEA0rohjdpPfvQ==
X-Received: by 2002:a05:622a:6096:b0:50d:7f4d:93cf with SMTP id
 d75a77b69052e-51461bdb40cmr317421931cf.8.1778491803705; 
 Mon, 11 May 2026 02:30:03 -0700 (PDT)
X-Received: by 2002:a05:622a:6096:b0:50d:7f4d:93cf with SMTP id
 d75a77b69052e-51461bdb40cmr317421731cf.8.1778491803222; 
 Mon, 11 May 2026 02:30:03 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf3aed1fe1sm89729456d6.8.2026.05.11.02.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 02:30:02 -0700 (PDT)
Message-ID: <e0144605-d8b5-4c9a-9c6f-af0715be1189@oss.qualcomm.com>
Date: Mon, 11 May 2026 06:29:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] target/riscv: Implement Smsdid and Smmpt extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com, liwei1518@gmail.com
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEwMyBTYWx0ZWRfXyxTJHSlwwV5h
 eKNXzaLm4A9p1SmO3udh7PRxtQeYqAV4HrW/Rj6F/7Cr2hVd7uwU1XM070qYAHXZrwvMeeGMOOH
 4JVHC3Urp6id7WjyveRrWBNmtV15iO4lqgby9ewyCo15PUJmq3VyRNY6Fw2LMvk4BeojtfFMn53
 5mELWnxuxH3wKUfOeeS/5sScG7/u97XANdy8ocGI9neDIUuUSEtZ5X28nL+GRGGEXnXtSW+Pypf
 PLxwQYrL4pDHd6qX4UDPoc8NFEs+feuFvh2S9LQGuVq8v0A02J0tfxnJUuD1BST3IxCa75eKLcq
 D/Kla9iLnU7lFo/S6NK0JUfUGukXWuR+j/FNqmF3m8LJNlDGut7fsg8+apOX1IDvBY0aSl49GrP
 JVzUMP0cZIdtUiL2joPdhos7CKvGEJ6P8V5BRiSeZQT4WaV1u3tckcF9GOwS8em1tFlsDMkoBSE
 apdfntLKMxns0DW2jng==
X-Proofpoint-GUID: oCL0JpXcziv4j8cWNJUiqYqT47lmotUR
X-Authority-Analysis: v=2.4 cv=X5Bi7mTe c=1 sm=1 tr=0 ts=6a01a19c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=xvfqbYfxAAAA:20 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=DQkqan4mAAAA:8
 a=mDV3o1hIAAAA:8 a=vP247Ezzpv3FjxYnrLQA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=KMCQiJZ4DbJMxDiuRDX8:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: oCL0JpXcziv4j8cWNJUiqYqT47lmotUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110103
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi Zhiwei,

I was re-reading the code and the version history and I realized that
these patches seems to be based on version v0.34.  At least this is
what is mentioned on the v1 cover:

"This patch set implements the v0.3.4 version of Smmpt"
(https://github.com/riscv/riscv-smmtt/releases/tag/v0.3.4).
https://lore.kernel.org/qemu-devel/20250909132533.32205-1-zhiwei_liu@linux.alibaba.com/


Seeing the changelog from 0.34 to the current version (0.49) there's
a lot of differences, including opcode values.

I think it's worth bumping the patches to the latest spec version in
v6.  Even if v6 takes more time (there were some IOMPT register changes
that landed on v0.42).  Latest version 0.49 is staled since January 26,
ratification target set to Q32026:

https://riscv.atlassian.net/browse/RVS-1345

Thus I think we're in good shape implementing v0.49 it without the risk of
changing behind our backs.


Thanks,
Daniel


On 4/8/2026 11:06 AM, LIU Zhiwei wrote:
> This patch set introduces support for the RISC-V Smmpt (Supervisor
> Memory-tracking and Protection Table) extension. Smmpt provides a
> hardware mechanism for fine-grained memory protection, checked after
> address translation, which is particularly useful for supervisor-level
> sandboxing and security monitoring.
> 
> The rfc patch set:
> https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html
> 
> v4->v5:
>      1. Rebase to master.
> v3->v4:
>      1. Add missing review tags.
> v2->v3:
>      1. Fix build error in patch 2.
>      2. Rebase to master.
> 
> rfc->v2:
>      1. When ext_smmpt is false or BARE mode, make other fields in mmpt
>         CSR zero.
>      2. Add patch 5 to fix smrnmi ISA string order.
>      3. Fix patch 6 smmpt and smsdid ISA string order.
>      4. Make smmpt and smsdid experiment extensions.
>      5. Add review tags.
> 
> 
> LIU Zhiwei (6):
>    target/riscv: Add basic definitions and CSRs for SMMPT
>    target/riscv: Implement core SMMPT lookup logic
>    target/riscv: Integrate SMMPT checks into MMU and TLB fill
>    target/riscv: Implement SMMPT fence instructions
>    target/riscv: Fix smrnmi isa alphabetical order
>    target/riscv: Enable SMMPT extension
> 
>   target/riscv/cpu.c                            |   6 +-
>   target/riscv/cpu.h                            |   9 +-
>   target/riscv/cpu_bits.h                       |  27 ++
>   target/riscv/cpu_cfg_fields.h.inc             |   2 +
>   target/riscv/cpu_helper.c                     |  81 +++++-
>   target/riscv/csr.c                            |  95 ++++++
>   target/riscv/insn32.decode                    |   2 +
>   .../riscv/insn_trans/trans_privileged.c.inc   |  30 ++
>   target/riscv/meson.build                      |   1 +
>   target/riscv/pmp.h                            |   3 +
>   target/riscv/riscv_smmpt.c                    | 274 ++++++++++++++++++
>   target/riscv/riscv_smmpt.h                    |  36 +++
>   12 files changed, 560 insertions(+), 6 deletions(-)
>   create mode 100644 target/riscv/riscv_smmpt.c
>   create mode 100644 target/riscv/riscv_smmpt.h
> 


