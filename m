Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79127606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EH/GFm6l;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AjhBeFuW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnrv-0006hH-Ow; Fri, 30 Oct 2026 10:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMnrg-0006Yp-1T
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:45:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMnrd-0005U6-Qe
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:45:55 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERAsA4102848
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oSWU3UW3mVw3k3mRfVEiFDnhJjVI3iFOdt7KzgCSWn0=; b=EH/GFm6lvXIjG/mM
 2BU4Fzt+3NKZ+xcX3Akm15IcjwunJcIVTkr7FIQrZmmfDw8g2NDmILciXlbXjQFn
 vuD+06P1GDPzudkTop844Z79ZstBDtqmlMEET49NYRKJXGUHhg/hZXfTpjzdI5SZ
 rxnzwXGt++i/kN/Kh16yhHFgWboq/whYn80iSjk4OHqeOGfDXx01HkLymLeMwsL0
 IwolhbqUBQH74MLesK79+k+f0R3f5Lbr0nl7HfQ2M0Ush5gD2QHvMbOpns0S8RFT
 +9cygl3IiFD2WO1YgprTKXbvaCFN4ZhvJN2+otcXb7SCKfM/OMjRgACOVFloztDA
 UgsVGw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkja6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:45:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934963b2bc0so162147985a.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793371552; x=1793976352; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oSWU3UW3mVw3k3mRfVEiFDnhJjVI3iFOdt7KzgCSWn0=;
 b=AjhBeFuWJk0x2PbfJYHk00NkjXH32PS3Xqf5/wVJ8x8ArZsiPtOw9YOw2ktoDClRxA
 jFSh+4rpZavfSlOytGCy4QMCgKl7mWlik7atNPTUtZIGV8Sk8yOTzZD7RUiV8RcH+eyB
 uiZNPwjaI6fbfhinSmauH2+8RtI2XP03uUR6dFkhba2CueZc5hu/QM0XfUfF4hVrMs/D
 guaFt2lqmRgV7kb0PkMSIcfuK8V/fo2cYM1fo8yOhrr4Z+8Zr+x8O7FZkEIx+XApH4Mv
 colCJky/+DproSjkAo0DuqsN769VgEMKd9OA+lSUnonD4/x6HiY/13t7Wnwlij3uGTWF
 W8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793371552; x=1793976352;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oSWU3UW3mVw3k3mRfVEiFDnhJjVI3iFOdt7KzgCSWn0=;
 b=TL9LgSjFbb3oYdGUEQf1g4fNtTd+ZEVTolweJCNSHAnwVSOqIwoyqjhqqEN8JvPEVw
 yapW+Ee9Z0w4UOXoS+vO3RU12nM4XOclV+O/WJsw1LSPdrd2lM7bLEtTvt++7k+pGlbV
 EYmxFaATrLrabOOS9hMg9M1VdSXYh1LDyDEZ6mgP7wjzmp0uF9B9jwoxASWI3RmagMFd
 pcIEScERO6j/IPkwQLXqrnUAeRkFajxqSgYSTR483IwmNkIUt68sBCNmn9IOyve7k+e0
 f0dq7vgpQsWywOpGMIWdhnuYsqPZhJz/YLJPT8FHS4asUhggPg0EhljkdbqnDcuBcl4t
 weng==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkJGyHDwc+VQBdyz7WXhpjaV1ywyqMU4zYrvzTwBPmv9v2O8SvfY6UMad61TD04danJpNC5X9s/yyr@nongnu.org
X-Gm-Message-State: AFq9FYLGcNFqB/03KXFoXCq00MNwYI2GDYA+66Y34zOlkKmUfo5Tp48V
 60ZIJuAWfxeDNDvmHUiUe2lTCs3fie4dwAg72Bl71ZL6wqeDWYe+BWzOPxqnuUZT2zTdL67bGpL
 VoHzXOSekrCeWKn3UwOE1+QhhCpku+z0maRR6OCKUOCHKMb0kUX4x23IPAg==
X-Gm-Gg: AYBFou1riGxFtPzyIf5Sqp9ZxQMIvhqOpIqGy/0SR59AkqQ7LbGBloHXTu6G/p6T+gM
 WEdhUvWfFJkD0pmbIuw76H+oKMxlhVRQp3RJObeIvJmcvhRqovgFBstD+opg4vW91LerF/HZCYb
 PGBZQ9UWE7p0P25HDfFZPRUoZR3IzobmfQA61oNca0N5PlZ6UWEEnOF41zkU7m2GJsmT91jc+aM
 mJZ30Yu9q31OWV71Yao0jaE83WhbdNoeKIGMl5zCEiiHee3wZVfmaK1sp2tbTuxNdNenWN3Da2V
 IcacnMFm4WwEBuhAIGibzjolHF0OSpSDasNHfu67kZIvAQWJgVk+Y0JU246gq0tpo7q0cLEORLI
 OuKx1s0/mYa/DotK19g3uUq8ioS1Z76X4r5SQjH+zNtNUrVJDwOeVGG8L8gv8+6VByTa41uOl5+
 zZgW8K9H+YmdnbMb0oXczkfER3GjHfh0LIk24ryA==
X-Received: by 2002:a05:620a:808d:b0:93e:e531:b78d with SMTP id
 af79cd13be357-944214cb80amr427869685a.7.1793371551767; 
 Fri, 30 Oct 2026 07:45:51 -0700 (PDT)
X-Received: by 2002:a05:620a:808d:b0:93e:e531:b78d with SMTP id
 af79cd13be357-944214cb80amr427860985a.7.1793371550988; 
 Fri, 30 Oct 2026 07:45:50 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94425a6d761sm156735985a.29.2026.10.30.07.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 07:45:50 -0700 (PDT)
Message-ID: <3e101b90-c864-48f8-aa59-47e0aa9344c9@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 09:45:48 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/20] target/hexagon: expose HLX registers through the
 gdbstub
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-19-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-19-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX5RvubW8H0vaC
 dWSBgOhRsNyLpD3PXKDop2W5MvC1xlOTW/OPm5I8XtZwVOC06mXEUChUu6GUIylPqKqLbpYxQ9v
 i01T0ZO0y6uS2Snhktuu+fjGA4olyNTf5VNIMuAo+X3zgekJSFeoFRW0EecQOGUq1YsrKr53oWQ
 f/0MYu6WnJnlivYxW9pPzJXnS/bDqiRLvsxj4gL5JENMYAINewmYZSsU6x0weZ2jnY90v2hO75n
 XfDFkxTYOmYyiulE3Hdsy59U1MzM7WYNiXztAyY44d314aLD32ephR+1VyCLH9SnqSzA9YTz3+v
 ft1iaiIMu2DCqRzwIzVw/8zzPF9EB24epyZMKyzPAchVWrV+nxpv9Dll3ceT5OZFf9A9WRJtpmN
 CsMvHf9ZoNd5YhWoU55TnImL8YXVehffp1qqEEwFkM0oF8ztN7mc402kunov2yp90Xyy3udAHVi
 16ZnZA/A7hQiLKAv5GA==
X-Proofpoint-ORIG-GUID: HMdMUzThS_iZrbc_fmZ311yqkuS-LdvM
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae4ada0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=eU0e3LhYAAAA:20 a=EUspDBNiAAAA:8 a=BPrPlLiY8F0ivCQlOwwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX4Kv/IIoUfrI9
 NEHwrofIktJDdBnZvoUF4QEd2MVJVJyVfObh/ZrP3VLIABKxVYjeqChb19SgJCebaxjTkUHQslr
 92S4mZgbuvoc/bwQ5B7fBxGLGCm3Xxc=
X-Proofpoint-GUID: HMdMUzThS_iZrbc_fmZ311yqkuS-LdvM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300058
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/29/2026 12:44 PM, Marco Liebel wrote:
> Add GDB register access for the active HLX context and register the
> feature for V85 CPUs with HLX support.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   configs/targets/hexagon-linux-user.mak |  2 +-
>   configs/targets/hexagon-softmmu.mak    |  2 +-
>   gdbstub/gdb-xml/hexagon-hlx.xml        | 51 ++++++++++++++++++++++++++
>   target/hexagon/cpu.c                   | 18 +++++++++
>   target/hexagon/gdbstub.c               | 46 +++++++++++++++++++++++
>   target/hexagon/internal.h              |  2 +
>   6 files changed, 119 insertions(+), 2 deletions(-)
>   create mode 100644 gdbstub/gdb-xml/hexagon-hlx.xml

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/configs/targets/hexagon-linux-user.mak b/configs/targets/hexagon-linux-user.mak
> index 51fde5d60e..10ae1943a5 100644
> --- a/configs/targets/hexagon-linux-user.mak
> +++ b/configs/targets/hexagon-linux-user.mak
> @@ -1,5 +1,5 @@
>   TARGET_ARCH=hexagon
> -TARGET_XML_FILES=hexagon-core.xml hexagon-hvx.xml
> +TARGET_XML_FILES=hexagon-core.xml hexagon-hvx.xml hexagon-hlx.xml
>   TARGET_SYSTBL=syscall.tbl
>   TARGET_SYSTBL_ABI=common,32,hexagon,time32,stat64,rlimit,renameat
>   TARGET_LONG_BITS=32
> diff --git a/configs/targets/hexagon-softmmu.mak b/configs/targets/hexagon-softmmu.mak
> index 1ba6420d20..8c3a9cd4b1 100644
> --- a/configs/targets/hexagon-softmmu.mak
> +++ b/configs/targets/hexagon-softmmu.mak
> @@ -1,7 +1,7 @@
>   # Default configuration for hexagon-softmmu
>   
>   TARGET_ARCH=hexagon
> -TARGET_XML_FILES=hexagon-core.xml hexagon-hvx.xml hexagon-sys.xml
> +TARGET_XML_FILES=hexagon-core.xml hexagon-hvx.xml hexagon-sys.xml hexagon-hlx.xml
>   TARGET_LONG_BITS=32
>   TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
>   TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
> diff --git a/gdbstub/gdb-xml/hexagon-hlx.xml b/gdbstub/gdb-xml/hexagon-hlx.xml
> new file mode 100644
> index 0000000000..91040762ea
> --- /dev/null
> +++ b/gdbstub/gdb-xml/hexagon-hlx.xml
> @@ -0,0 +1,51 @@
> +<?xml version="1.0"?>
> +<!--
> +  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +  SPDX-License-Identifier: GPL-2.0-or-later
> +
> +  LLDB uses fields that GDB can ignore. See:
> +  https://github.com/llvm/llvm-project/blob/287aa6c4536408413b860e61fca0318a27214cf3/lldb/docs/lldb-gdb-remote.txt#L738-L860
> +-->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name="org.gnu.gdb.hexagon.hlx">
> +
> +  <!-- Sixteen 2048-byte HLX L-registers. -->
> +  <vector id="hlx_ud" type="uint64" count="256"/>
> +  <vector id="hlx_d"  type="int64"  count="256"/>
> +  <vector id="hlx_uw" type="uint32" count="512"/>
> +  <vector id="hlx_w"  type="int32"  count="512"/>
> +  <vector id="hlx_uh" type="uint16" count="1024"/>
> +  <vector id="hlx_h"  type="int16"  count="1024"/>
> +  <vector id="hlx_ub" type="uint8"  count="2048"/>
> +  <vector id="hlx_b"  type="int8"   count="2048"/>
> +  <union id="hlx_vec">
> +    <field name="ud" type="hlx_ud"/>
> +    <field name="d"  type="hlx_d"/>
> +    <field name="uw" type="hlx_uw"/>
> +    <field name="w"  type="hlx_w"/>
> +    <field name="uh" type="hlx_uh"/>
> +    <field name="h"  type="hlx_h"/>
> +    <field name="ub" type="hlx_ub"/>
> +    <field name="b"  type="hlx_b"/>
> +  </union>
> +
> +  <!-- dwarf_regnums 124-139 follow HVX q0-q3. -->
> +  <reg name="l0"  bitsize="16384" offset="0"     encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="124"/>
> +  <reg name="l1"  bitsize="16384" offset="2048"  encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="125"/>
> +  <reg name="l2"  bitsize="16384" offset="4096"  encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="126"/>
> +  <reg name="l3"  bitsize="16384" offset="6144"  encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="127"/>
> +  <reg name="l4"  bitsize="16384" offset="8192"  encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="128"/>
> +  <reg name="l5"  bitsize="16384" offset="10240" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="129"/>
> +  <reg name="l6"  bitsize="16384" offset="12288" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="130"/>
> +  <reg name="l7"  bitsize="16384" offset="14336" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="131"/>
> +  <reg name="l8"  bitsize="16384" offset="16384" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="132"/>
> +  <reg name="l9"  bitsize="16384" offset="18432" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="133"/>
> +  <reg name="l10" bitsize="16384" offset="20480" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="134"/>
> +  <reg name="l11" bitsize="16384" offset="22528" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="135"/>
> +  <reg name="l12" bitsize="16384" offset="24576" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="136"/>
> +  <reg name="l13" bitsize="16384" offset="26624" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="137"/>
> +  <reg name="l14" bitsize="16384" offset="28672" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="138"/>
> +  <reg name="l15" bitsize="16384" offset="30720" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="139"/>
> +
> +</feature>
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index c3930ab4e4..dfa9e1d3af 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -540,6 +540,18 @@ static void hexagon_cpu_disas_set_info(const CPUState *cs,
>       info->target_info = &cpu->cfg;
>   }
>   
> +static bool hexagon_cpu_has_hlx(HexagonCPU *cpu)
> +{
> +    if (cpu->cfg.hex_def->hex_version < HEX_VER_V85) {
> +        return false;
> +    }
> +#ifdef CONFIG_USER_ONLY
> +    return true;
> +#else
> +    return cpu->hlx && cpu->hlx->num_contexts > 0;
> +#endif
> +}
> +
>   static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
>   {
>       CPUState *cs = CPU(dev);
> @@ -559,6 +571,12 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
>                                hexagon_hvx_gdb_write_register,
>                                gdb_find_static_feature("hexagon-hvx.xml"));
>   
> +    if (hexagon_cpu_has_hlx(cpu)) {
> +        gdb_register_coprocessor(cs, hexagon_hlx_gdb_read_register,
> +                                 hexagon_hlx_gdb_write_register,
> +                                 gdb_find_static_feature("hexagon-hlx.xml"));
> +    }
> +
>   #ifndef CONFIG_USER_ONLY
>       gdb_register_coprocessor(cs, hexagon_sys_gdb_read_register,
>                                hexagon_sys_gdb_write_register,
> diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
> index 5b79e42c4d..1065f3a826 100644
> --- a/target/hexagon/gdbstub.c
> +++ b/target/hexagon/gdbstub.c
> @@ -217,3 +217,49 @@ int hexagon_hvx_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>   
>       g_assert_not_reached();
>   }
> +
> +int hexagon_hlx_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
> +{
> +    CPUHexagonState *env = cpu_env(cs);
> +    int total = 0;
> +
> +    BQL_LOCK_GUARD();
> +
> +    if (n < 0 || n >= NUM_LREGS) {
> +        g_assert_not_reached();
> +    }
> +
> +    /* Return zeroes when no HLX context is active. */
> +    if (env->hlx_ctx == NULL) {
> +        for (int i = 0; i < HLX_VEC_SIZE_BYTES; i++) {
> +            g_byte_array_append(mem_buf, (const guint8 *)"\0", 1);
> +        }
> +        return HLX_VEC_SIZE_BYTES;
> +    }
> +
> +    for (int i = 0; i < (int)ARRAY_SIZE(env->hlx_ctx->LRegs[n].uw); i++) {
> +        total += gdb_get_reg32(mem_buf, env->hlx_ctx->LRegs[n].uw[i]);
> +    }
> +    return total;
> +}
> +
> +int hexagon_hlx_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    CPUHexagonState *env = cpu_env(cs);
> +    BQL_LOCK_GUARD();
> +
> +    if (n < 0 || n >= NUM_LREGS) {
> +        g_assert_not_reached();
> +    }
> +
> +    /* Ignore writes without an active context. */
> +    if (env->hlx_ctx == NULL) {
> +        return HLX_VEC_SIZE_BYTES;
> +    }
> +
> +    for (int i = 0; i < (int)ARRAY_SIZE(env->hlx_ctx->LRegs[n].uw); i++) {
> +        env->hlx_ctx->LRegs[n].uw[i] = ldl_le_p(mem_buf);
> +        mem_buf += 4;
> +    }
> +    return HLX_VEC_SIZE_BYTES;
> +}
> diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
> index 073de10284..6def331a83 100644
> --- a/target/hexagon/internal.h
> +++ b/target/hexagon/internal.h
> @@ -24,6 +24,8 @@ int hexagon_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>   int hexagon_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>   int hexagon_hvx_gdb_read_register(CPUState *env, GByteArray *mem_buf, int n);
>   int hexagon_hvx_gdb_write_register(CPUState *env, uint8_t *mem_buf, int n);
> +int hexagon_hlx_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n);
> +int hexagon_hlx_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n);
>   #ifndef CONFIG_USER_ONLY
>   int hexagon_sys_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n);
>   int hexagon_sys_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n);

