Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE48CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXenA-0004c4-VF; Thu, 11 Jun 2026 08:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXemy-0004Xi-F4
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:45:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXemw-0000mM-Io
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:45:40 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCT0SJ630660
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9bHiMKFjKb1LKmtVMXu/kITMmbYgKgqrhMZ/ChTKtO0=; b=H9xC12kJB3dPeCol
 7Ep6YIHPY8jj3eC+FrovtfB8GSvautFZhTSXxk3oGP3vIQk7dXMx8/+433vevlqJ
 5kQ/EOei+XZ9ZJu6DP5UbI1npmD+Qla2Hmp5B0WtwDCAP+t/Ofp3HZHnQU1espbl
 mZJn3y5MLGQCSxsllie5omaIdHQV4zH1UV8kkdmW4UUYpPE+o/xHMBxP6SWwnM/I
 1D5QCwdtYHI408hhNwtqXnO8pYDRpb9fs6kcVWf/QbA9YAPVuo08ZYVpMXVVVhMH
 22u31Bwr98coTDnctDqcXzayCZ4V5VfIbH1ymfTnZ81bc/TkOBzkfOEqiebFPJkE
 Thpuyg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqtb5gqab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:45:37 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-517dadd84f8so48810961cf.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781181937; x=1781786737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9bHiMKFjKb1LKmtVMXu/kITMmbYgKgqrhMZ/ChTKtO0=;
 b=ePYVrdB7Lm1EWiwVorwvFfUldMi+JcpfjZboGFinwiE8AmUIfTWj6+k/ProvDl0GLg
 AGw9pkryHb93A0kMgB1JDIKMPZ1qEpMuRf/8euFYad+FMvM8VJ7qAVLZJ34N3BKFlvnH
 Tkahg5U5rEDvp1TgBu5jaq2LLtLMFfTgFKvLNKIQtw2Ou3WC2yB4R1SR0W1F8ywzq6LZ
 xq8jlxYX5DUSNb4iHgN+9YriHvoDGVW4q3d7UYN4gD0bqYuIicZ4ZT8fSH991ExpJxLy
 JM8/u8tDjWnmd3adE4l5xjcYSizRu8h+212Bf/vDq6q8AGXc9EGL5Y1rp09kePwrDIEM
 cI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781181937; x=1781786737;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9bHiMKFjKb1LKmtVMXu/kITMmbYgKgqrhMZ/ChTKtO0=;
 b=iRa/EGunk5iLZWs/b8R6haV+vE0qgTmZxe2B02EwdzV0a70umSLcBJOWKxAHUiTMYy
 vkT0x+/Kdd3ALjMqu0pD8wNlaqTJWHW0s26+SD67xa3sC1m9ixfU1nZWqJhsCkzy8g++
 RVR3Omrp/qpsMNww/iJxGqAyQ9isgxxG3hnzovR23HiqKsudpg6Gr9mLgUP0/I1fp6g6
 BlfzAYz3Qb2O9iFlhVZ2KOhqpnxmVZbDTqg3ZChLNfomfmU/N2c6h1WNaM9W2e96k7dd
 LzpOwTeJ8d/xNC3YmlMvbU718jUqAOx/Ty2tnwDN9YntIgTsHBRvMjyq9JPqSzFM0EG3
 8BtQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/i6Jp5YdKQpfFnUAOYhas7HziUmFpfnUXnvnzfP1OJwfNtWwRO3iQguptQbWvbld22KmzJ195HrLsB@nongnu.org
X-Gm-Message-State: AOJu0YzynR5K4coOjQCwAxx8fhdRFOxsTBD+DTTmIFAshCNdhOPK68zq
 I38Ztpvyah/PcyoT1KxHSvUHnvsODFjDqT7EybfiqiGxUGq8xcgRWplfy28je8RoVSGd8SxspfX
 UP+jGrLxQeyTlAY9TPNaRHtIJMNUo6koLi+LhO7BQ6eusjpzfnShRid7laA==
X-Gm-Gg: Acq92OHn9FjGtjQSN9F5nIFBzL/ppbR6vnAEDcZ8yMJVSZLoeYacHGa3WosPGq7kLGV
 O0AqscdaILJX1prAd5FZIConnlbIiJeBzdSXSUVAykc8BBtGqvO0+/4urbmISnHUdTBGr7snS1n
 EtEJwWuMiupR/D5YtLtKhtoAbGVajWw5wPGFN3fo//4RcpPEmP3GYnMo/zNQsoiIaCTwh9sH0Rm
 h194wOpGjYU+EPJy5X8A13FZ/OmcTSYSDh0E+Z5XYnHzwIw0M/XHTiZS6KQpqxz6oDLgzsYl5+Z
 Khye14YfxwRCMV7xftcG3crfxFXOngwtYM9caRwVDYEm8io/pkFPbU8COxYFIrjQrAls0VnUPs0
 YSbr1OJ1JLcUetUdGXo3Wdr8WEM+t4+msG4x0IjlkDbG1Pz6h0QLwJ/BYz7M/8ifuFFqsKXA+d7
 xjCm4yha4=
X-Received: by 2002:ac8:5ac9:0:b0:517:2a27:bc84 with SMTP id
 d75a77b69052e-517ee1bf755mr39528151cf.35.1781181936546; 
 Thu, 11 Jun 2026 05:45:36 -0700 (PDT)
X-Received: by 2002:ac8:5ac9:0:b0:517:2a27:bc84 with SMTP id
 d75a77b69052e-517ee1bf755mr39525421cf.35.1781181934314; 
 Thu, 11 Jun 2026 05:45:34 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfcb0f15621sm60383666b.13.2026.06.11.05.45.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 05:45:33 -0700 (PDT)
Message-ID: <a3be798d-4645-4b7e-986e-a42690e3f460@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 14:45:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] target/riscv: dynamic alloc of debug trigger arrays
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260611123412.2135600-1-daniel.barboza@oss.qualcomm.com>
 <20260611123412.2135600-3-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260611123412.2135600-3-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyOCBTYWx0ZWRfX7s4KecKaIAy6
 t6of9+6OKpZyvxMyyqPq640bymDSZR/cejPxtCRSY2NZa/d0IFckArky+fSkBoYaU1lTdFPK1Rg
 j3mwkeA6HpLmLKDha4G9vcG9/EYksUVP4MGm+8OtQqWA/yxOewFefO8/nMHYOfxn6LBwQsVTmOD
 bzOe9//l0o0CxyDEC9lD9f++CgHzxHpFOQZChTGPjlNrUtnpTcJmL05ZlpdPbSg9HdvFI5SPz4B
 QWX1newL9wyGmK03FrT1Wp6Y9L3StXVhVq0j/rCKwYKnuYLzvWtNiD+7Iew55/28kyoqfqlCwUK
 yxJIr4MJIlbh1FwyI1+hW+3I60uaPrgq+UudU1TBGYdwl0yk7v52auJFfaMFO4aZ8iHyQyN4Ell
 9vp8MeSsRxYo6BVoG6Eb91zV5jdBdYAjcQ+YB5G9m4XIe+eDeWs1bH4QoascKsWPvr/4lx77Mg6
 a/BgtjSDvDREgD9yQbA==
X-Proofpoint-ORIG-GUID: B3Sw8gVpcgLz_HB51PE1hlaf3IY2O85x
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyOCBTYWx0ZWRfXxcFCi6psxQoP
 hAfaADoobhr2/JUcwi+71PYRdK6cWHs7n/Y2eRsdtEYcmUp0BBQ2OSV3ViHjGSSQrTfUk6+u4y+
 d6nUi7yP7L+R5rVHe0nQlBp97SAjCZ0=
X-Authority-Analysis: v=2.4 cv=e6g2j6p/ c=1 sm=1 tr=0 ts=6a2aadf1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9E-04Aa4SPOfiErpu9cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: B3Sw8gVpcgLz_HB51PE1hlaf3IY2O85x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110128
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

On 11/6/26 14:34, Daniel Henrique Barboza wrote:
> The debug trigger facility consists of a set of arrays: tdata1-3,
> cpu_breakpoint, cpu_watchpoint and itrigger_timer.  All of them are
> static allocated with RV_MAX_TRIGGERS (2).  This means that all RISC-V
> cpus will have 2 triggers per hart.
> 
> The RISC-V Server Ref demands at least 11 triggers per hart, and several
> CPUs in the wild works with 4+ triggers.  We need more flexibility, ergo
> we need to parametrize the amount of triggers and make it configurable.
> 
> Before doing that we need to handle a situation faced in a previous
> attempt [1].  We were unable to set the tdataN array length in
> vmstate_debug, meaning that we would always migrate RV_MAX_TRIGGERS
> regardless of the actual amount of triggers in play. To fix that we need
> to change the tdata arrays from static to dynamic, allowing us to use
> VMSTATE_VARRAY_UINT32().  This also means that, in contrast with [1], we
> have the opportunity to turn all trigger arrays into dynamic allocation
> and reduce the amount of stuff being carried by CPURISCVState, or in
> other words, we can carry just what we're using instead of a static max
> value.
> 
> All the forementioned trigger facility arrays are now dynamic.  They are
> allocated and freed during realize/unrealize, and their size is
> expressed by env->num_triggers.  All relevant code is changed to use
> env->num_triggers instead of the RV_MAX_TRIGGERS to loop through each
> array.
> 
> This will make it easier for the next patch to parametrize
> env->num_triggers.
> 
> [1] https://lore.kernel.org/qemu-devel/94c772b0-5231-40e4-9cab-6ac39b9e4d45@oss.qualcomm.com/
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/cpu.c     |  6 ++++++
>   target/riscv/cpu.h     | 18 +++++++++++------
>   target/riscv/csr.c     |  2 +-
>   target/riscv/debug.c   | 46 ++++++++++++++++++++++++++++++++++--------
>   target/riscv/debug.h   |  1 +
>   target/riscv/machine.c | 16 ++++++++++-----
>   6 files changed, 69 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

