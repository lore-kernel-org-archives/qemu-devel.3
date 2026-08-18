Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF0BC5DF84
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 21:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwRj4-0007gc-6G; Tue, 18 Aug 2026 17:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwRj2-0007gP-K6
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 17:52:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwRj0-0007NB-H7
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 17:52:04 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ILbetS2525554
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 21:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +QHg5DLESD4vqSLz7FwZUA9FY/F7xo+PfYqjL7M/AVw=; b=WcpocVhLpYlKbfUR
 IezmCVVIGub8Jkr1POC7GBOoTPwWaY6p4cRs2jJH8MiEkRva+Jhptb2U3FiGuz2q
 04dMhj0GJ6teEm6AtwtX1G6vRRKx2mslBb99e2X8IuDNJN4fM+1pEbJzn4wuXBj+
 9m6lPp97Epjshxk+kfHVTzp1PeIqIHIiLThkmsxtw1c0DLYWJFg+2+QRnrVUMLaT
 g08XCw9rbzbWfSrQlUqp2pMi0r2qgG8jmJoPZEwjtuHU9N2GN4QZq45p3np1BY3L
 BJbOa2aJUfbUiGGQ1Ry4tT6ILZoRPL+R+KFupmVmz35b6T3dbG9GTcYI2Lyto130
 Z/wqoQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfk838k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 21:51:49 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbee5bab340so279512a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 14:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787089909; x=1787694709; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+QHg5DLESD4vqSLz7FwZUA9FY/F7xo+PfYqjL7M/AVw=;
 b=O1G2iLVG4awuvh9OUQRYW7dglsDaWrR6/vWENGT4C11R9+85Jxjld/l2wBpXx96LiM
 98dNXNXCuHpmHXAb/b9LwHr+2RCrUI+/XGs+Ua+RuJAt2FJQ1dbk7FtRLmy+cPyzYmdv
 Ukj0Mfa6HK5/iNpZeQT/PQU+xFYYKpuLmxmk0TLMICGkKatH+PK9u5S0PGtvwhaXD4Db
 y0ktrnOgESyBb4GNaXWTPU5OTkR2POL927qmoNA70IPGkr9GORQyUBCnHCPhRukpMogt
 b1kx82ElZ+KIrQtk/Uq7wCO4jjYmDBRCxCT/Vh7a6bIwTgbKNoyc/liOweOkAm0cml32
 sV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787089909; x=1787694709;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+QHg5DLESD4vqSLz7FwZUA9FY/F7xo+PfYqjL7M/AVw=;
 b=FvkvRMEN3o2ncyziIi/IJjrGQlX235hEAYgVDEq27weNjWv94sWCwi7GvuVY1cR0xe
 S8raDum5WRA54C6SSw52JFVz+y3l5Xsxd7MQeM+QMh5qvTa6yxGzFvRNmPduZzpiVwO4
 Wk0cnHLB/x97n3ZtEiXoAIZoEEjyXKDJe6O31OtLcKhLeQi2ufZtnGQOCAdiqLVFFFi3
 1aonazbITe27TtvyI3IkiHYORIvCYu4djxPyW10hRhi3CTnfe1rjhww3adKqoYptHA7u
 OnZz6ziOrUmd2ByII72D3rzH4AhXRoRbjXA22eYt+ED0Gfubq4p1NywKCdk8e+EvpZu1
 +HCQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrObyr4EkRsbnA0VUw0H83Ij/cZr1Wv0/HxzH6niz2S5p4s9++oUKTeXg4lgkNqBkUMBIrKRmNcJkYx@nongnu.org
X-Gm-Message-State: AOJu0Yw12knlQdDLtkMYXlenb/lQGkzxqx+0fRrmuSNTmGKRbKauEMIT
 O7YrNQE3ysdAMSIi5yiPZuWV4/PgQUAgaATlM7wxSsTx7I/jegtdtjyugYQn+MmvFLGn26XZCC+
 rCSm9XDIk3q6gEGmNbI3NcWfTuRYrf3eqqkfrrXyWy03eoVuikeY6LHyI5Q==
X-Gm-Gg: AR+sD12fzOXwpmXNV56I7oX+97+cqUdXh34IlQS9h5xkWe7NPDVqeU84hcaGgMfAkw5
 rANsR5olQCmizNaaHykDC68Bq4cHDlwOtY8wsKTQP3iesDd1CTu2xaY29au+De2MHwfyStmuOKz
 NSH0pgS+zw7J409Gu8c8yROJHMOhrSVkHh2HsAhGpGXfBeI9zsib9BMbUUepj1JqAN4p7Veon6Y
 mX5aKYyyjlyUpMLgQUBVCZlkdClZtvJPqDm7BNmue9aHGgQ/2cdQltk+h2xKhdHZqNrSdshm57c
 9zdkQajw8r/UeyP0TUuDEQoNw//fsXHsEOUm6xJkhUJDNVP8LXvnh49EVpO7e00dIalaGuVBJ4G
 SXmhxIrJvcS12zHnG7QGyDx2ssOpf/XpmD8Fb4CN+rNFzq6Z0YKu9mi5BgPSvPP2KmPg1
X-Received: by 2002:a05:6a20:7f99:b0:3c8:f98f:475b with SMTP id
 adf61e73a8af0-3cd0135a14emr285241637.19.1787089908849; 
 Tue, 18 Aug 2026 14:51:48 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f99:b0:3c8:f98f:475b with SMTP id
 adf61e73a8af0-3cd0135a14emr285164637.19.1787089908348; 
 Tue, 18 Aug 2026 14:51:48 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf173b02sm27129eec.27.2026.08.18.14.51.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 14:51:47 -0700 (PDT)
Message-ID: <23eaea1b-e3bf-4845-8942-0e6ffcf056ca@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 14:51:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] RFC: tcg: probe the TB jump cache inline instead of
 calling a helper
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de
References: <20260818174247.649526-1-mattst88@gmail.com>
 <20260818174247.649526-5-mattst88@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260818174247.649526-5-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5-DUvZg73B7tNs5YLe58NDtejQmA1DZ0
X-Proofpoint-ORIG-GUID: 5-DUvZg73B7tNs5YLe58NDtejQmA1DZ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE2MSBTYWx0ZWRfX8V1BGmL4MzhY
 LpqRmKytKetPhFDjQqR2XggeK3EEvrMqFEJE2lX9WU1ewhrMAjv7666gbNfbsBr52JN+HBE0KNo
 +NZQ2T4ZdoyE/06GWA2LDNdrnp6nfUyQDRmy8Yon2OLKI09RsdPRBb9OazOR3V3IaXskmywKrzy
 fUge28TGLmKfKqRqdgTc8L7IOwp/z1nt7vT1acz+TR9Aq3sXf5qVR5QvMpWjgbJybl4wmcCslZy
 QAJqdjUxph/Jq6CBbraBI9TYrq8tXk5JnDlZhcn+AIpC6Nwbtx4HDmeTG5ck4ppVl0fzh6WOr06
 ZQh+P8PJtaNoaPVdQIllg53Sxq0YlNkW6+IDHCuWmOczM22mDo8A4yn00smesa6iqeBh4/ydbMb
 m372bnvBllmKoUDMOyrANWqlmWB7jypGNMRamHsH042G+FMGNXsznY/P1t1RUJmY6HURjBivexU
 Uj/bh6t46L0dqWz7P0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE2MSBTYWx0ZWRfX17Mwyuov4kTs
 qxIJ/tjUaHczbc6aW8xveZw2kmJfXZ/XeZs8DrNJiBQmOAeYxWaqJyHKdaXSY8cWSWSAD+u0RGR
 3uPbmbrtfpTeSUhi53/EgiV6vvFO3LI=
X-Authority-Analysis: v=2.4 cv=fvfsol4f c=1 sm=1 tr=0 ts=6a84d3f5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=6KYHkuE4E4tEOf1rhe8A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180161
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 8/18/2026 10:42 AM, Matt Turner wrote:
> Every indirect branch that cannot use goto_tb ends in
> tcg_gen_lookup_and_goto_ptr(), which calls helper_lookup_tb_ptr(). For an
> emulated compiler that is 8.4 billion helper calls in a single translation
> unit: 24.6% of all TB exits take this path, because jsr/ret/jmp have a
> register destination and because goto_tb is restricted to same-page
> targets.
> 
> The helper itself is already tight, but each call pays for a call frame,
> the can_do_io store, the get_tb_cpu_state() indirect call through
> TCGCPUOps, curr_cflags(), and a breakpoint check, before it gets to the
> jump cache probe that almost always hits (95.8% for this workload).
> 
> Emit the probe inline instead. The destination PC is already in a TCG
> temp, and the flags and cflags the destination must match are constants at
> translation time, so the fast path is a hash, three guarded loads and a
> goto_ptr. Only a miss calls the helper, which still owns filling the cache.
> 
> Two details matter for the generated code. The flags and cflags guards are
> folded into a single aligned 64-bit load and compare, since the fields are
> adjacent. And each path emits its own goto_ptr rather than branching to a
> shared one: a temp live across the label is spilled and reloaded on every
> dispatch, which cost 6.3% on its own.
> 
> Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
> the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, LTO
> build, on top of the preceding three patches:
> 
>     before: 1,402,816,253,499 instructions
>     after:    890,713,633,237 instructions   -36.51%
> 
>     before: 115.75s wall clock
>     after:   84.44s wall clock               -27.05%
> 
> The gap between the two is the point at which this stops being a
> straight-line win: the helper call was highly predictable work that the
> host pipelined well, so removing it retires far fewer instructions than it
> saves time. IPC falls from 2.48 to 2.15 across this patch for that reason.
> 
> Despite emitting more code, this also reduces instruction cache pressure,
> because a dispatch no longer jumps into qemu's .text and evicts translated
> code:
> 
>     before: 11,476,318,964 L1-icache-load-misses
>     after:   6,990,186,701 L1-icache-load-misses   -39.1%
> 
> The mechanism is visible directly in a profile: helper_lookup_tb_ptr()
> falls from 30.97% of samples to 0.42%, and qemu's own .text falls from
> 38.9% to 5.4%, with the balance moving into generated code.
> 
> Combined with the three preceding patches, against an unmodified LTO
> build, 1,647,901,588,726 instructions fall to 890,713,633,237, or -45.95%.
> The emulated compiler produces byte-identical output throughout.
> 
> Open issues, hence RFC:
> 
> - The flags/cflags guards use the *current* TB's values as constants. That
>   assumes the CPU flags feeding get_tb_cpu_state() cannot change within a
>   TB, and that curr_cflags() cannot change under a running TB (gdb
>   attaching to enable single-step would). Both need to be established or
>   the values need to be loaded at runtime.
> - tcg/tcg-op.c has no business including accel/tcg/tb-jmp-cache.h or
>   knowing the CPUJumpCache layout. The probe likely belongs in accel/tcg
>   with a small emit helper exported from tcg/.
> - The jump cache entry is read without qatomic_read(); entries are
>   invalidated concurrently by setting tb to NULL.
> - Only wired up for alpha so far, and only for 64-bit guest PCs.
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  include/tcg/tcg-op-common.h |  2 +
>  target/alpha/translate.c    |  4 +-
>  tcg/tcg-op.c                | 79 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+), 2 deletions(-)
> 

This change breaks following tcg test:
alpha-linux-user/gdbstub-follow-fork-mode-child

Reproduce with:
ninja -C build &&
make -C build/tests/tcg/alpha-linux-user/ &&
make -C build/tests/tcg/alpha-linux-user/ run-gdbstub-follow-fork-mode-child

Need gdb-multiarch and gcc-alpha-linux-gnu installed on your machine.

Regards,
Pierrick

