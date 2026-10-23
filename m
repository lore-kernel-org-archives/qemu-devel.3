Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009D3606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VHDBtFCJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Le6BQth+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKLI3-00053O-HO; Fri, 23 Oct 2026 15:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKLHx-00051t-Kj
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:50:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKLHp-0005Fy-GQ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:50:52 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NIZXtc4064866
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 19:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2Q+Zyk5phMnUihRRSPkdwCLau5jaArlWInsFAjadenY=; b=VHDBtFCJ/FejxeU+
 5Cygk1QohgkB5n/TGUQMJxJfpSK+sbLJ+Jed/QdCn6gekUAvIJ48ANkkDdKOlHZL
 ED/IOB3LIsK8QvjCJQYLgk4bXMMdQkETO0gyf/Ev/bsDaUIUJtjvcVtfqFGWgBmZ
 s4D5kQfwRWnyoapqxhUMpV16x+uVs09PKEMmU78vKpPmzQejZCzqaLSu7GnybKid
 VsVzqdyfSUZ1uPe7soqBNLXTtwHyHgwjbQP3rewk5zrfxHnX5Fcw1GmHa0J1OpkV
 Smy+H+REhEta5+cc5fXBDMS7HViKks/syzVpgm5rgTxm2aFEyUwHNlEMRdO5i/zw
 I3dCtQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgarugtaf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 19:50:42 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9179743a76eso27871666d6.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 12:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792785042; x=1793389842; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Q+Zyk5phMnUihRRSPkdwCLau5jaArlWInsFAjadenY=;
 b=Le6BQth+cQDtYtAGW+kHLjoCZK54+/tFmH/1OVxFph/6Btt+lj/n6v10oXvbNS5php
 Uq499vWeOOejFB/TMbqv6pgOEiXx3ubGNL6xznd0aL5f3UMSE96R7WOnlvPH65FeDWkS
 pl5Vd3L/DuIoEjz3ENjfFoF8TrGWuanwMcTgUL65UjXOGSEN+Kux234iLleC9uqSa0nZ
 pd6/0R/yOhqDCt8o/15aXVTlLr6wMLznlWc83B+wTEcw566u/26o/9dtrbo03+qvkfbT
 EGje8qXaZaq1bvyRyufViJh9nQQZ735z0fQeu1Bgq/1n0YZuQODyvweYbHegLB+4WC1w
 AjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792785042; x=1793389842;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Q+Zyk5phMnUihRRSPkdwCLau5jaArlWInsFAjadenY=;
 b=fsl5cZ1sl6tqNtH/qU3P8HvOkhlGrK6BUYS0+/oekmslTi/RjZYTb/44tEgpeUuikL
 1yPAZ9XZnRQPt9yqHDcUVSqhXbad84TklbyN++ckVXULWLmG7N3keMwDa5GVb5XUfaoy
 RvvvbRbmd17qFfgRA9DYatBarfJg+xUpNxPqWXFzQAZIfk/kacTYkHDxk8yprukU2/T8
 60bMZDFisnuA37Zth1xBOEGGxAYAOH8v4lrIoxZ0U1FAmVWPJgDAVl3HTkwbClzzL4Y2
 4JmJnvtgZeamo1yh5YILx++CILXfWha0IK+Qb8CLKpAjHfN4HKQXKFJUn7v63WdfUx0+
 L3Eg==
X-Forwarded-Encrypted: i=1;
 AKwUvBym2BkT3uQYjBiteMlMfTwSWhucYDbAkZtBL9fL+2iPdbSsWP3QLHbBeIvV9ILKkAZB+3ThYI6nlZZv@nongnu.org
X-Gm-Message-State: AFq9FYKe7VwQ8WXbKfccJvyDw+R+SWe2b2n33fFiTMmJaakrTPXUjO+D
 rqjxh+8eWCOZQfSfFv3Gf9Ak32Z5m9I2AedVxbR/sV7QyoDae13NeAx0l42zm0abVDdZpHjGeHv
 df21rEtN5CrFxs6eHrWtiXRApOm8j0XbfVFUef+F3VYenndId5hQnLCdfcg==
X-Gm-Gg: AYBFou3qpbFNMX2GQOdtRtx0d45bQh23SYDNu4gWokusdK4vojEDvAI6VnPBJLMBYAJ
 1Jeqjh2CG3gqjzzUEdxV3oM4L2U9eaaZw2MIoQZ/mcuIf9jIcQHJdv5H9+IuHJkQEAu6GON7xTf
 YXCuI4YF9zhCtkk+fzaSq7fHZZZXCFLGTYz54TddUTzcZ9lR/Jpi4CTa0MjGEiOydsjAncaf/yN
 xH7JHdkdvTSYck2drkFdrxBdBA+0DzUbhe/SGodX7yKzMjpdLG4v3htPqdFBRW4LcaRmkV8FFdo
 sFS+OP21DCgz94kpx4zamymwcWgwfRdADfL7MFIdfBFJmOS1TpP49zwNVh76PtyzMFGGcW5Utj+
 pcXYs0PMBbIijaz42a1oa0zSmpXqT4ev4p5FB
X-Received: by 2002:ad4:5aa5:0:b0:917:7e2b:d732 with SMTP id
 6a1803df08f44-91c4906a1b7mr9606d6.21.1792785041359; 
 Fri, 23 Oct 2026 12:50:41 -0700 (PDT)
X-Received: by 2002:ad4:5aa5:0:b0:917:7e2b:d732 with SMTP id
 6a1803df08f44-91c4906a1b7mr9196d6.21.1792785040574; 
 Fri, 23 Oct 2026 12:50:40 -0700 (PDT)
Received: from [192.168.68.104] ([152.234.125.162])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c48a92ebdsm1016096d6.11.2026.10.23.12.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 12:50:39 -0700 (PDT)
Message-ID: <6a3258d7-99ed-4812-9c58-ad332d1012bb@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 16:50:34 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/18] target/riscv: expose register aliases to
 monitors via gdbstub
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
References: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
 <20261022-query-reg-v3-17-7ad902b9a7cf@redhat.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022-query-reg-v3-17-7ad902b9a7cf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA3OCBTYWx0ZWRfX3ZxxZJKppHnS
 O1tY24pjtqSPLRtYlPf4/5YNKMq7xujA1aErdMkX3U2dyfIiBzKYJIfSS+nfXNyQQYYWx1E7NnO
 rrtTgIAmbA2qHJL2vjf64nlsQl2i3E4=
X-Proofpoint-GUID: 3SDwc763kkg5qma-S0ATh2gwCOUF_vsL
X-Authority-Analysis: v=2.4 cv=SK7Xx+vH c=1 sm=1 tr=0 ts=6adbba92 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=AgQEunjic7gIBKSbIeB6Ag==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=6TZiiwDxetlbl_jET_0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: 3SDwc763kkg5qma-S0ATh2gwCOUF_vsL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA3OCBTYWx0ZWRfX8s0FLmUsylj5
 d028GQ0fELbXzo28h6PQsagmpG1Vzh9dD4Yp7nna0dG0TjSCnqQMmJRogwwggfWhbOgc8MCsshe
 5k1LGfhFEK2I1QFUjGDySu+JkfWcz4SPLh4YNc+E6++onvbGpK3dY0AbJfRDR5DlxsXXra4U30x
 LbkrA1RUuQP2YygJJADCF2iGVKsr+bXd8at6COhFO5r0MYudEK2ufTN+Fl3qFZ9ioBEuyOr8bcB
 sXLffkJmy1DuL5P0qCyqJNoJISrsFrKwSjTAUfr1qaDucgoRHKIrS4RekL8auYq6gRnVebrhezY
 Mx2AjXSTRHRoocHwf6tfqZ2yate8lGHzSKAcqTso0hqoF3ipO7ug33Qj46zwf1sAGOkH0mahIjq
 aKso5YM3GznhyHdMDF7LC8vN61BH8np0zSBjfxA8P4j8ajHrejSG+iymxVAhBP4fYoYXzwD5jTM
 4SIO+dhnGXodkNfOi0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/22/2026 7:56 AM, Marc-André Lureau wrote:
> The core GDB XML uses ABI names (zero, ra, sp, fp, ft0, fs0, etc.)
> but users also refer to registers by their numeric names (x0-x31,
> f0-f31) and the s0 alias for fp. The legacy MonitorDef mechanism
> supported both via split "x0/zero" name matching.
> 
> Register a feature that maps:
>   - x0-x31 and s0 to the corresponding core integer registers
>   - x0h-x31h and their ABI aliases (zeroh, rah, ...) to env->gprh[]
>   - f0-f31 to the corresponding FPU registers (when FPU is present)
> 
> CSR-by-name lookups ($mstatus, $sstatus, ...) keep working, through
> the existing GDB CSR feature rather than the removed csr_ops loop.
> 
> Lookup is now case-sensitive (consistent with all other targets),
> including for the CSR names. Vector registers report "unknown
> register" instead of the target-specific "Unable to print the value
> of vector vreg" message.
> 
> RV32 numeric and high-half aliases now zero-extend into HMP’s 64-bit
> expression value (for example, $x1 containing 0xffffffff evaluates to
> 4294967295, whereas the legacy fallback returned -1). This makes aliases
> consistent with the existing GDB-backed names.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   configs/targets/riscv32-linux-user.mak    |   2 +-
>   configs/targets/riscv32-softmmu.mak       |   2 +-
>   configs/targets/riscv64-bsd-user.mak      |   2 +-
>   configs/targets/riscv64-linux-user.mak    |   2 +-
>   configs/targets/riscv64-softmmu.mak       |   2 +-
>   gdbstub/gdb-xml/riscv-32bit-alias.xml     | 105 ++++++++++++++++++++++
>   gdbstub/gdb-xml/riscv-32bit-fpu-alias.xml |  40 +++++++++
>   gdbstub/gdb-xml/riscv-64bit-alias.xml     | 105 ++++++++++++++++++++++
>   gdbstub/gdb-xml/riscv-64bit-fpu-alias.xml |  46 ++++++++++
>   target/riscv/cpu.c                        |   1 -
>   target/riscv/gdbstub.c                    |  48 ++++++++++
>   target/riscv/internals.h                  |   3 -
>   target/riscv/monitor.c                    | 140 ------------------------------
>   13 files changed, 349 insertions(+), 149 deletions(-)
> 
> diff --git a/configs/targets/riscv32-linux-user.mak b/configs/targets/riscv32-linux-user.mak
> index d88fdf5e1b2f..8ee14fa14383 100644
> --- a/configs/targets/riscv32-linux-user.mak
> +++ b/configs/targets/riscv32-linux-user.mak
> @@ -1,7 +1,7 @@
>   TARGET_ARCH=riscv32
>   TARGET_BASE_ARCH=riscv
>   TARGET_ABI_DIR=riscv
> -TARGET_XML_FILES= riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-32bit-virtual.xml
> +TARGET_XML_FILES= riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-32bit-virtual.xml riscv-32bit-alias.xml riscv-32bit-fpu-alias.xml riscv-64bit-fpu-alias.xml
>   CONFIG_SEMIHOSTING=y
>   CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
>   TARGET_SYSTBL_ABI=32
> diff --git a/configs/targets/riscv32-softmmu.mak b/configs/targets/riscv32-softmmu.mak
> index 5d5016d00832..c717940344f0 100644
> --- a/configs/targets/riscv32-softmmu.mak
> +++ b/configs/targets/riscv32-softmmu.mak
> @@ -1,6 +1,6 @@
>   TARGET_ARCH=riscv32
>   TARGET_BASE_ARCH=riscv
> -TARGET_XML_FILES= riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-32bit-virtual.xml
> +TARGET_XML_FILES= riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-32bit-virtual.xml riscv-32bit-alias.xml riscv-32bit-fpu-alias.xml riscv-64bit-fpu-alias.xml
>   # needed by boot.c
>   TARGET_NEED_FDT=y
>   TARGET_LONG_BITS=32
> diff --git a/configs/targets/riscv64-bsd-user.mak b/configs/targets/riscv64-bsd-user.mak
> index 5b4e138099fc..1d37e018c871 100644
> --- a/configs/targets/riscv64-bsd-user.mak
> +++ b/configs/targets/riscv64-bsd-user.mak
> @@ -1,6 +1,6 @@
>   TARGET_ARCH=riscv64
>   TARGET_BASE_ARCH=riscv
>   TARGET_ABI_DIR=riscv
> -TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml
> +TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml riscv-64bit-alias.xml riscv-32bit-fpu-alias.xml riscv-64bit-fpu-alias.xml
>   TARGET_LONG_BITS=64
>   TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
> diff --git a/configs/targets/riscv64-linux-user.mak b/configs/targets/riscv64-linux-user.mak
> index 35621520c560..564d15aaca8c 100644
> --- a/configs/targets/riscv64-linux-user.mak
> +++ b/configs/targets/riscv64-linux-user.mak
> @@ -1,7 +1,7 @@
>   TARGET_ARCH=riscv64
>   TARGET_BASE_ARCH=riscv
>   TARGET_ABI_DIR=riscv
> -TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml
> +TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml riscv-64bit-alias.xml riscv-32bit-fpu-alias.xml riscv-64bit-fpu-alias.xml
>   CONFIG_SEMIHOSTING=y
>   CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
>   TARGET_SYSTBL_ABI=64
> diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
> index a10dc03c04c8..28bfcdc575fb 100644
> --- a/configs/targets/riscv64-softmmu.mak
> +++ b/configs/targets/riscv64-softmmu.mak
> @@ -1,7 +1,7 @@
>   TARGET_ARCH=riscv64
>   TARGET_BASE_ARCH=riscv
>   TARGET_KVM_HAVE_GUEST_DEBUG=y
> -TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml riscv-32bit-cpu.xml riscv-32bit-virtual.xml
> +TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml riscv-32bit-cpu.xml riscv-32bit-virtual.xml riscv-32bit-alias.xml riscv-64bit-alias.xml riscv-32bit-fpu-alias.xml riscv-64bit-fpu-alias.xml
>   # needed by boot.c
>   TARGET_NEED_FDT=y
>   TARGET_LONG_BITS=64
> diff --git a/gdbstub/gdb-xml/riscv-32bit-alias.xml b/gdbstub/gdb-xml/riscv-32bit-alias.xml
> new file mode 100644
> index 000000000000..a00a86ebdf95
> --- /dev/null
> +++ b/gdbstub/gdb-xml/riscv-32bit-alias.xml
> @@ -0,0 +1,105 @@
> +<?xml version="1.0"?>
> +<!--
> +  SPDX-License-Identifier: GPL-2.0-or-later
> +-->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name="org.qemu.gdb.riscv.alias">
> +  <reg name="x0" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x1" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x2" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x3" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x4" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x5" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x6" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x7" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x8" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x9" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x10" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x11" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x12" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x13" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x14" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x15" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x16" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x17" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x18" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x19" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x20" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x21" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x22" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x23" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x24" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x25" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x26" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x27" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x28" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x29" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x30" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x31" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="s0" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x0h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="zeroh" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x1h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="rah" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x2h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="sph" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x3h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="gph" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x4h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="tph" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x5h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="t0h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x6h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="t1h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x7h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="t2h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x8h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="s0h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x9h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="s1h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x10h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="a0h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x11h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="a1h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x12h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="a2h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x13h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="a3h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x14h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="a4h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x15h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="a5h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x16h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="a6h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x17h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="a7h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x18h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="s2h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x19h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="s3h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x20h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="s4h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x21h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="s5h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x22h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="s6h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x23h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="s7h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x24h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="s8h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x25h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="s9h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x26h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="s10h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x27h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="s11h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x28h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="t3h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x29h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="t4h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x30h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="t5h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="x31h" bitsize="32" type="int" group="qemu-debug"/>
> +  <reg name="t6h" bitsize="32" type="int" group="qemu-debug"/>
> +</feature>
> diff --git a/gdbstub/gdb-xml/riscv-32bit-fpu-alias.xml b/gdbstub/gdb-xml/riscv-32bit-fpu-alias.xml
> new file mode 100644
> index 000000000000..3935f72ea289
> --- /dev/null
> +++ b/gdbstub/gdb-xml/riscv-32bit-fpu-alias.xml
> @@ -0,0 +1,40 @@
> +<?xml version="1.0"?>
> +<!--
> +  SPDX-License-Identifier: GPL-2.0-or-later
> +-->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name="org.qemu.gdb.riscv.fpu-alias">
> +  <reg name="f0" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f1" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f2" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f3" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f4" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f5" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f6" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f7" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f8" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f9" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f10" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f11" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f12" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f13" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f14" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f15" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f16" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f17" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f18" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f19" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f20" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f21" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f22" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f23" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f24" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f25" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f26" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f27" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f28" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f29" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f30" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +  <reg name="f31" bitsize="32" type="ieee_single" group="qemu-debug"/>
> +</feature>
> diff --git a/gdbstub/gdb-xml/riscv-64bit-alias.xml b/gdbstub/gdb-xml/riscv-64bit-alias.xml
> new file mode 100644
> index 000000000000..28781b230226
> --- /dev/null
> +++ b/gdbstub/gdb-xml/riscv-64bit-alias.xml
> @@ -0,0 +1,105 @@
> +<?xml version="1.0"?>
> +<!--
> +  SPDX-License-Identifier: GPL-2.0-or-later
> +-->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name="org.qemu.gdb.riscv.alias">
> +  <reg name="x0" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x1" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x2" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x3" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x4" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x5" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x6" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x7" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x8" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x9" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x10" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x11" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x12" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x13" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x14" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x15" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x16" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x17" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x18" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x19" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x20" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x21" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x22" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x23" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x24" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x25" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x26" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x27" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x28" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x29" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x30" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x31" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="s0" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x0h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="zeroh" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x1h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="rah" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x2h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="sph" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x3h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="gph" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x4h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="tph" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x5h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="t0h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x6h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="t1h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x7h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="t2h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x8h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="s0h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x9h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="s1h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x10h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="a0h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x11h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="a1h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x12h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="a2h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x13h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="a3h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x14h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="a4h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x15h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="a5h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x16h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="a6h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x17h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="a7h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x18h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="s2h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x19h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="s3h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x20h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="s4h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x21h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="s5h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x22h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="s6h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x23h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="s7h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x24h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="s8h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x25h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="s9h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x26h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="s10h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x27h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="s11h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x28h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="t3h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x29h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="t4h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x30h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="t5h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="x31h" bitsize="64" type="int" group="qemu-debug"/>
> +  <reg name="t6h" bitsize="64" type="int" group="qemu-debug"/>
> +</feature>
> diff --git a/gdbstub/gdb-xml/riscv-64bit-fpu-alias.xml b/gdbstub/gdb-xml/riscv-64bit-fpu-alias.xml
> new file mode 100644
> index 000000000000..13e6b341a0f8
> --- /dev/null
> +++ b/gdbstub/gdb-xml/riscv-64bit-fpu-alias.xml
> @@ -0,0 +1,46 @@
> +<?xml version="1.0"?>
> +<!--
> +  SPDX-License-Identifier: GPL-2.0-or-later
> +-->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name="org.qemu.gdb.riscv.fpu-alias">
> +
> +  <union id="riscv_double">
> +    <field name="float" type="ieee_single"/>
> +    <field name="double" type="ieee_double"/>
> +  </union>
> +
> +  <reg name="f0" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f1" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f2" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f3" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f4" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f5" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f6" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f7" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f8" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f9" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f10" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f11" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f12" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f13" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f14" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f15" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f16" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f17" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f18" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f19" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f20" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f21" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f22" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f23" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f24" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f25" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f26" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f27" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f28" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f29" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f30" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +  <reg name="f31" bitsize="64" type="riscv_double" group="qemu-debug"/>
> +</feature>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 08a4d14ea1f6..7b052da6d8b4 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3107,7 +3107,6 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
>       .legacy_vmsd = &vmstate_riscv_cpu,
>   #ifdef CONFIG_TCG
>       .translate_for_debug = riscv_cpu_translate_for_debug,
> -    .monitor_get_register = riscv_monitor_get_register_legacy,
>   #endif
>   };
>   #endif
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index f279f4ab2461..0d89caf8ba36 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -336,10 +336,42 @@ static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
>       return &cpu->dyn_vreg_feature;
>   }
>   
> +/* x0-x31, s0, then pairs of numeric and ABI high-half aliases. */
> +static int riscv_gdb_get_alias(CPUState *cs, GByteArray *buf, int n)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    uint64_t val;
> +
> +    if (n < 33) {
> +        return riscv_cpu_gdb_read_register(cs, buf, n == 32 ? 8 : n);
> +    }
> +
> +    val = cpu->env.gprh[(n - 33) / 2];
> +    if (riscv_cpu_is_32bit(cpu)) {
> +        return gdb_get_reg32(buf, val);
> +    }
> +    return gdb_get_reg64(buf, val);
> +}
> +
> +static int riscv_gdb_set_alias(CPUState *cs, uint8_t *buf, int n)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    CPURISCVState *env = &cpu->env;
> +    const unsigned regsz = riscv_cpu_is_32bit(cpu) ? 4 : 8;
> +
> +    if (n < 33) {
> +        return riscv_cpu_gdb_write_register(cs, buf, n == 32 ? 8 : n);
> +    }
> +
> +    env->gprh[(n - 33) / 2] = ldn(env, buf, regsz);
> +    return regsz;
> +}
> +
>   void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
>   {
>       RISCVCPU *cpu = RISCV_CPU(cs);
>       CPURISCVState *env = &cpu->env;
> +
>       if (env->misa_ext & RVD) {
>           gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
>                                    gdb_find_static_feature("riscv-64bit-fpu.xml"));
> @@ -380,4 +412,20 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
>                                    feature);
>       }
>   #endif
> +
> +    gdb_register_internal_coprocessor(
> +        cs, riscv_gdb_get_alias, riscv_gdb_set_alias,
> +        gdb_find_static_feature(riscv_cpu_is_32bit(cpu) ?
> +                                "riscv-32bit-alias.xml" :
> +                                "riscv-64bit-alias.xml"));
> +
> +    if (env->misa_ext & RVD) {
> +        gdb_register_internal_coprocessor(
> +            cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
> +            gdb_find_static_feature("riscv-64bit-fpu-alias.xml"));
> +    } else if (env->misa_ext & RVF) {
> +        gdb_register_internal_coprocessor(
> +            cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
> +            gdb_find_static_feature("riscv-32bit-fpu-alias.xml"));
> +    }
>   }
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index f17d011d22fb..f4af4636c6ca 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -265,7 +265,4 @@ static inline int insn_len(uint16_t first_word)
>       return (first_word & 3) == 3 ? 4 : 2;
>   }
>   
> -int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
> -                                      int64_t *pval);
> -
>   #endif
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index 7e61ae2a4717..20f3ba57ae57 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -19,10 +19,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "qemu/ctype.h"
> -#include "qemu/qemu-print.h"
>   #include "cpu.h"
> -#include "target/riscv/tcg/csr.h"
>   #include "cpu_bits.h"
>   #include "monitor/monitor.h"
>   #include "monitor/hmp.h"
> @@ -247,140 +244,3 @@ void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
>       mem_info_svxx(hmp, env);
>   }
>   #endif /* CONFIG_HMP */
> -
> -#ifdef CONFIG_TCG
> -static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
> -                                 target_ulong *val, bool is_gprh)
> -{
> -    const char * const *reg_names;
> -    uint64_t *vals;
> -
> -    if (is_gprh) {
> -        reg_names = riscv_int_regnamesh;
> -        vals = env->gprh;
> -    } else {
> -        reg_names = riscv_int_regnames;
> -        vals = env->gpr;
> -    }
> -
> -    for (int i = 0; i < 32; i++) {
> -        g_auto(GStrv) reg_name = g_strsplit(reg_names[i], "/", 2);
> -
> -        g_assert(reg_name[0]);
> -        g_assert(reg_name[1]);
> -
> -        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
> -            g_ascii_strcasecmp(reg_name[1], name) == 0) {
> -            *val = vals[i];
> -            return true;
> -        }
> -    }
> -
> -    return false;
> -}
> -
> -static bool reg_is_u64_fpu(CPURISCVState *env, const char *name, uint64_t *val)
> -{
> -    if (qemu_tolower(name[0]) != 'f') {
> -        return false;
> -    }
> -
> -    for (int i = 0; i < 32; i++) {
> -        g_auto(GStrv) reg_name = g_strsplit(riscv_fpr_regnames[i], "/", 2);
> -
> -        g_assert(reg_name[0]);
> -        g_assert(reg_name[1]);
> -
> -        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
> -            g_ascii_strcasecmp(reg_name[1], name) == 0) {
> -            *val = env->fpr[i];
> -            return true;
> -        }
> -    }
> -
> -    return false;
> -}
> -
> -static bool reg_is_vreg(const char *name)
> -{
> -    if (qemu_tolower(name[0]) != 'v' || strlen(name) > 3) {
> -        return false;
> -    }
> -
> -    for (int i = 0; i < 32; i++) {
> -        if (g_ascii_strcasecmp(name, riscv_rvv_regnames[i]) == 0) {
> -            return true;
> -        }
> -    }
> -
> -    return false;
> -}
> -
> -int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
> -                                      int64_t *pval)
> -{
> -    RISCVCPU *hart = RISCV_CPU(cs);
> -    CPURISCVState *env = cpu_env(cs);
> -    target_ulong val = 0;
> -    uint64_t val64 = 0;
> -    int i;
> -
> -    if (reg_is_ulong_integer(env, name, &val, false) ||
> -        reg_is_ulong_integer(env, name, &val, true)) {
> -        *pval = riscv_cpu_is_32bit(hart) ? (int32_t)val : val;
> -        return 0;
> -    }
> -
> -    if (reg_is_u64_fpu(env, name, &val64)) {
> -        *pval = val64;
> -        return 0;
> -    }
> -
> -    if (reg_is_vreg(name)) {
> -        if (!riscv_cpu_cfg(env)->ext_zve32x) {
> -            return -EINVAL;
> -        }
> -
> -        qemu_printf("Unable to print the value of vector "
> -                    "vreg '%s' from this API\n", name);
> -
> -        /*
> -         * We're returning 0 because returning -EINVAL triggers
> -         * an 'unknown register' message in exp_unary() later,
> -         * which feels ankward after our own error message.
> -         */
> -        *pval = 0;
> -        return 0;
> -    }
> -
> -    for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
> -        RISCVException res;
> -        int csrno = i;
> -
> -        /*
> -         * Early skip when possible since we're going
> -         * through a lot of NULL entries.
> -         */
> -        if (csr_ops[csrno].predicate == NULL) {
> -            continue;
> -        }
> -
> -        if (g_ascii_strcasecmp(csr_ops[csrno].name, name) != 0) {
> -            continue;
> -        }
> -
> -        res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
> -
> -        /*
> -         * Rely on the smode, hmode, etc, predicates within csr.c
> -         * to do the filtering of the registers that are present.
> -         */
> -        if (res == RISCV_EXCP_NONE) {
> -            *pval = riscv_cpu_is_32bit(hart) ? (int32_t)val : val;
> -            return 0;
> -        }
> -    }
> -
> -    return -EINVAL;
> -}
> -#endif
> 


