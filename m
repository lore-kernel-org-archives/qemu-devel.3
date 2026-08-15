Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F094AC5AD5A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 13:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvEo3-0003nN-VL; Sat, 15 Aug 2026 09:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvEny-0003gG-Ue
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 09:52:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvEnv-0002SS-NJ
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 09:52:09 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67FDMGo7219108
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1JWImf+Dhv9RqeqR9XP+j0RUd7qOflO4VcouI/KZrK4=; b=cbInQVMMAUgMhWKz
 iTsnU43F1ROKkPfCcswmSZYpB1+J3W54Kn1UEDs7x6iFWBUSgHhZNHWX5N2tEbsD
 LSIZ41ear+HOvA1U2i9ujNUqd7MDZkB8JruzkMvDeQjuC6CrKjvOmduLlPTz/9sv
 f54M4X/PPoPrylI6HV9Xe93BgnVCmUIr3JOdCJSvY/RbmApqJKHOxk++glzY7vzA
 6eCpHNb82yUKna6K5kwpPECctIfuK2krWe0D/sjXkBRCx9gnmT4ZxBHLDfg6Cuat
 lvKmLYNJx3l+Sm19LYr4gxF/I4nNZMlnPxe1EJrujpwKWQwmmXUeq0ih1j0gbLxJ
 G6QvSA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2hd7rxrs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:52:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936cadb0e8bso173733485a.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 06:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786801925; x=1787406725; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1JWImf+Dhv9RqeqR9XP+j0RUd7qOflO4VcouI/KZrK4=;
 b=bVuOWzYYxzLqi4sTISEzhZVdMA4g9rVLcKdzEwg7y0VWU6MY8yCiatnmcMRSs/Ymid
 74yPwOnXUwcrsvKCk+MvLePZXUFi55MbdznyvhZm2yKQzvMeNBspiorhYqfpBlbUfEuB
 RkWzbnaOmQc91ba4bjNq7024OsHAWOQR/gFu+q0D1N5PHLtciwcJ+mQwMltp4Hiit3CX
 0pzoMEAkYwaMdGw6juLmBUZ1wGPmUITB9trvzO9utYMYk3otRbD/IDzChJaRureY1Rs3
 M9k2ajIK5HvBhtoASsIPSUy4ecFP6FkQkaD1pdhP/GRFVevFGyavC+O0pQ4mqP14kp8i
 4p1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786801925; x=1787406725;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1JWImf+Dhv9RqeqR9XP+j0RUd7qOflO4VcouI/KZrK4=;
 b=XFtcuLdrEjCu2bcl5+nWgMHB2s2NbV+2Hesy5k3LDYL0W5WN7lSfRHgrRT4D/fnzHq
 jzmiOluD8duQkdAPt2qQcbFS1qoffDAoslXrx8NYZIB7Po1TlRiI1f+AWX0QUPSqBa8a
 SzVQzNjMQvY71hu9DdMTJ85GRUjcXSZ2asNYpP1rxSk4lyhC2Git78as62DFBMzcgegp
 5W8Hs58hhGhlS7eqv3v15+N5GMjoV/Om7YLhVWz4xgn9KnnISmoDMHcedRSlDKVSnXFR
 H35s4hVY5xMoGH1s5vsAYYCkwnwFrG/g6Yv5mNuX2k+7UoupgBAnwu5qdrPGfTLyP7Fa
 Lv5w==
X-Gm-Message-State: AOJu0YyFB6tkF2KTF826J3V2rwRWDSeGeiMiK7kAlEL6OmnuiVU3huXE
 +jk/pnc0SAG4KFQJXdTPcxk2Vri8irwu0B5iUD4ep4+kLj7agpcrvjcfO5MYY9Q2h4hUl7G/XtS
 WeaAQgw5+n6+rxNiwohqBkR9PbB0hhi5ESKRpnitvK+5lr0ig0SjyUxo7P4fawZNuZ9RU
X-Gm-Gg: AR+sD11d2gMmN5/uAHoC6XXP18MlFf+KFarBud/KHNKpDO3xR0TMtsJA/65Kfaf47WF
 q4/8V1ft9NX8KMt+M20oFd5i+rUk/WD/rAcF/dsDsvimzdhpZ0bUV6S85PBWoOObpG9O2FypkDi
 vYg2hY1Wi22Qt6tQYSdusPKh/0il/Emw4F0AWKKzWv62xNDdaHEqx/wRTSeA10naSt8tN56iylz
 BZP3NB2lLRqhgrKtQzjsqPELru/slpXHBjdmcUaC3vQThHI/R0NeqFJ/+/DNdH3G1odmMANBBnV
 9mZ5fD3U/1xw8AdkZaDuehTmoTXYoJduNZqUxtmWzE0bqcUDjKqgSu68MnxZyAdd4lH5rVbFyJb
 CwgOo3KnfDWuyxVqFtjr+mJ78NC4/OpAVNQo=
X-Received: by 2002:a05:620a:2889:b0:92e:7cc9:a888 with SMTP id
 af79cd13be357-936d1fd98c4mr1390221985a.2.1786801924825; 
 Sat, 15 Aug 2026 06:52:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2889:b0:92e:7cc9:a888 with SMTP id
 af79cd13be357-936d1fd98c4mr1390217385a.2.1786801924391; 
 Sat, 15 Aug 2026 06:52:04 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f219f7bsm16844631f8f.13.2026.08.15.06.52.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 06:52:03 -0700 (PDT)
Message-ID: <f5beef33-4e39-4458-8d2d-33663de77849@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 15:52:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] hw/cpu: Slightly sanitize CPU API
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org
References: <20260811183410.22428-1-philmd@oss.qualcomm.com>
In-Reply-To: <20260811183410.22428-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEwMCBTYWx0ZWRfX73NaXAblA4Vg
 SFd2BvAh6liC2+FiVGOGpPCRPcCLNaTGRvx7eNPrQ5do7OzYxc/YFIB2X50vVbXIP06YReP1LAl
 wHc5QvCEB3vOc7+udDW0L0leYUMyYsdNKOD+MUqxfPi0+u8n1rXZuSYsnMCvP0OacD14bd7P2aM
 nrPrkSPj1LNXmoNqr8OAJ9L9/bLvKo1iQUtJxsxoJ8eatnNToK1Vxw35LyISib4Fa7I68oU8kbh
 x6+FDEiKTWdRtyqj/Cejl6JTdEzvkSzWwEXDuUHjDeonp3m6bbQbOxioaAdAr40sLkiSnGXZkwz
 G0t1rpdc+cUeETRqno5fvA+I3LXBuNal07/PVPxMP/cGzn47vi4siljlr9QmkQyPkjYNE+//bXw
 /vydbgLKTLV5CHun/+ka4fpkVqPkVmlhIEN+OPMRNo7bSu3tqjJIRg04SvvVLcQBKsq9JyOy3qg
 7oYSLY87HVpXzldHQSA==
X-Proofpoint-GUID: IaGmdhxXj9MdvtK7Vg7pb_cZiTsqUfTd
X-Authority-Analysis: v=2.4 cv=Ja2Ma0KV c=1 sm=1 tr=0 ts=6a806f05 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=Ql7IHVpF8h-uniIvIrkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: IaGmdhxXj9MdvtK7Vg7pb_cZiTsqUfTd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEwMCBTYWx0ZWRfX3rR5Lwxg8Va0
 aGv+rn5vK3IGlAt2IXSoiM7odv0TM1r0MLhiTaET5s6o+guUvSCLOueFdk/yh1UTmiK1MLvkcfp
 jYiFNBJZgYY44vxbiiIOfozVgUN3DfU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150100
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

On 11/8/26 20:34, Philippe Mathieu-DaudÃ© wrote:
> API cleanups, mostly removing system-specific code out of
> cpu-common.c. Code churn renaming functions, in the hope
> to make things a bit simpler to understand.
> 
> Small patch set extracted from a series clarifying CPU /
> accel synchronization, itself a preliminary work to introduce
> split acceleration, eventually.
> 
> Philippe Mathieu-Daudé (8):
>    hw/cpu: Correct CPU_GET_CLASS() comment
>    hw/cpu: Include missing 'qemu/accel.h' header
>    hw/cpu: Move internal declarations to new 'cpu-internal.h' header
>    hw/cpu: Rename cpu_common_realizefn() -> cpu_exec_realize()
>    hw/cpu: Rename cpu_exec_realizefn() -> cpu_common_realize()
>    hw/cpu: Rename cpu_exec_unrealizefn() -> cpu_common_unrealize()
>    hw/cpu: Extract cpu_exec_realize() out of cpu_common_realizefn()
>    hw/cpu: Move system-specific cpu_exec_realize() to cpu-system.c

Series queued.

