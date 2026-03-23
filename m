Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19218EC01D4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4e09-0006LV-7X; Mon, 23 Mar 2026 08:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1w4e03-0006Kd-ET
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:03:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1w4e01-0004jU-Mf
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:03:15 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NAEKAc3541579
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 12:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3WT5rwORObuW+82ZkW9sh8NCXCDSK8V0YImiEwCqSIE=; b=c8G7I77qgwGPBQYd
 YDGf0rYdbS63D4iZK0CnsxZkShLMpfHd7Ow87SIe3IAEBJA4jMLP0jes3GjWVdO0
 EmnP4F4iVm79Ty8QP0fA1SVI9jhMhPYPqS7Jo0x+9xSvtRvRi91mdp99sVANxDxv
 EzYMLuKK+M5SX2T3pgiqEBfzODPf3QJt3k7jggLFqvmZFvvdTfgraLR3o8woVZAx
 csIDPkxmcVsu1PfNN8ZgLqVLodQlrTE7V/czwhEGL3dNv46/i5RodbdC7Dmsa6BB
 wWP+UhJx5fXdl8ZSDnAGMRX8dA21YRvkegZP5lHl83LD9ecJWiuKdJ/5n5GWZ5jt
 zlsFBQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d33k30bv6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 12:03:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-509219f94b0so13442191cf.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 05:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774267392; x=1774872192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3WT5rwORObuW+82ZkW9sh8NCXCDSK8V0YImiEwCqSIE=;
 b=SwOId6ts7IIpXNkWC0lDHnrwZuvSCj/adTRlHYQPOanE8eciEstaZdKBwmGei8s/Ws
 Z9y2FrvW7h2mjHIBxe7ZvmPJG9as8PzHoqw3ZJuqSLogGEXqNB4ULV7i/Ra6eSOzhDTv
 hBg25ghLsYfrcqH4sTFhK6Hzz2y36LtQPWLKzhP5yutngMXfh4G0V5boboOUR2Z/N9E4
 5kwJ4fiDT1KJvcgY5RaUaXIgo29LkO3UneSkFKyH0JgQU9EkRlvFEsh+SA7zXxKRgA+7
 z7RFFhN7P+BHNNJaIRjFmo2rqVHYmmm1fjXTl54/7PZwcs86QbiEHqt1jAi2b86O644E
 F7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774267392; x=1774872192;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3WT5rwORObuW+82ZkW9sh8NCXCDSK8V0YImiEwCqSIE=;
 b=deCJSvgNiLVVGyxvkhjFH0n0DUDgV6sNWj5B7D4v6/wYRVfHu9TJcdKsSl3J189Emc
 BKkg+0d2XFIZMVQE1YjK1OrvLumtejGizYhnfKnXDE3HpqwJGJxV6wlqmfSEaHqezHJY
 Oel6g6VPTXOx4C9f2u8z4AYUtnfUH99GQg79y1QWuHRRowSJcVJq0ZOGiYrtxyhU3ddb
 IzzIr67aXInQW6yROhxP4Ru3ZcdGvaS7Y2G7uSRWYxIBF1gXwFiYw3UkhWIMOPczkYC/
 cO4UlEOsCgQN24CG9jERQGpiNh3jce1xgMRtt40eDRzmlmcpG5nMjZCDbFW0iuawbz2I
 F+bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrEqUMGmIi132n+7T9ELko5PnshsMkSSNEev+kfHAjcqbQ4u2gPwmyzgfNw3gAG2CcTvh1423RrzAq@nongnu.org
X-Gm-Message-State: AOJu0Ywd5NOdI53bJsmpacTaYkbLzJ4T5Tl4N1ReU6yS+qnDHljvRwWL
 KnHGAuGTZtEeVHxkdxjE8fUQ76JT1hW7iM3IokJ7J+sMfTIS1yQCnsJn7Yb9DVOWEQqAYz0OXOZ
 YkdphTAVq+KkpjmqU6eisZjfUtmNTFh9CNYpjb3vraYZS6nAGsoII4qIpvA==
X-Gm-Gg: ATEYQzwf/q8+CAbohpO8nPxoJnakNDU00GA+dTdwvUL+UnqTtQObaKiKxQsJskthUYH
 5/hb503NW6EswutTYs0TvhPM/CiLcELs7NFaPhVn83Gb6k/5DFHEgiaDkQCc/MCwc71dJBzC8sY
 UcpFELROcVQ1ea1MkmZBAvfjdcvBaR+cQ2FmMXjRfJlmV3hWE8Iy6xhhx7d5mGiQD6t7DoiUo7u
 7VlWL70paWri1tsTgtu67rQG1py0Q9YmpiDZxKXCQQFU7Am2jOejcNevgoNOVAGpw9zdvZAQMZx
 IT5seMlP/wgvSrG4Xa6NqF2M83HClAUha8FOrl5jaNpD829UrJPQhikBlhLS4GnAudtoe3IQ9So
 O6JLvlJx8SLyKMWUkFsfuBBQkfdvkbVXFVdBm4sd0zl8KzwY8fSkCqOnYubk=
X-Received: by 2002:a05:622a:17cc:b0:50b:4a84:aa94 with SMTP id
 d75a77b69052e-50b4a84add8mr103699061cf.7.1774267386795; 
 Mon, 23 Mar 2026 05:03:06 -0700 (PDT)
X-Received: by 2002:a05:622a:17cc:b0:50b:4a84:aa94 with SMTP id
 d75a77b69052e-50b4a84add8mr103698231cf.7.1774267385982; 
 Mon, 23 Mar 2026 05:03:05 -0700 (PDT)
Received: from [192.168.68.100] ([152.250.131.245])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36d23237sm102440001cf.13.2026.03.23.05.03.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 05:03:05 -0700 (PDT)
Message-ID: <ef1abb04-d456-4bfb-bf0d-ea1e1fbb1737@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 09:03:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 00/10] monitor: Remove need of per-target handlers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>
References: <20260320160811.28611-1-philmd@linaro.org>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260320160811.28611-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CYYFJbrl c=1 sm=1 tr=0 ts=69c12c00 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=HedkDXwelbZAeRtZ4KMHrg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=AfwxLLwCQG5pQSTL0wMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA5MyBTYWx0ZWRfXyAvNYlNuF5pl
 Gxkb0onBrKlmAN+rqPdgFwgloYRThg9biDQQLsGLHcZ4lnRs8MbOFK82EALFOl1prH3ljXEl4Xm
 Qe96w8ptYiiZHViurOuL3aruATvft1iKY/0ojY2PqoxlTliAfL0g1GjVjdDPkJx+ox3jH90xT0Q
 jWUm1bg0if1gKyI4uTnW9XqAZM4HDv23K3XOmAec6LtNbaIGG7MvqnTVrI5hFf+J+IrqK8/SlZI
 I7Wwze9iB1Uw7/98ajiLnZSFfwtcd60ZJXOm3+5etOtbEI5bFcSoHt8g1BWgDpsmNdAnROaDAiq
 9vKrSnqBQFrgx90x9UR4dWKabxsNvlzrw/QMT9wOmbacXh3xYWdeIW3MP1EWLnM3X6Q7nKqiHt8
 BLAP9V5fwi/JOp6+6BHiABe5EXr0rbNXW7EMv0zngIv+SIQVZvKkLhfRaCX6UA9fX0s3UVR76/J
 WP+pGN6GBo1S5TAs+6A==
X-Proofpoint-GUID: VDa0pSbdgixocLU1lpcehV9sJZr5P-u1
X-Proofpoint-ORIG-GUID: VDa0pSbdgixocLU1lpcehV9sJZr5P-u1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230093
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 3/20/2026 1:08 PM, Philippe Mathieu-Daudé wrote:
> Convert target_monitor_defs() and target_monitor_defs()
> to CPUClass fields, adapting the 4 targets using these
> legacy code.

So I saw in patch 3 this explanation:


+ * @legacy_monitor_defs: Array of MonitorDef entries. This field is legacy,
+ *                       use @gdb_core_xml_file to dump registers instead.


I can move target/riscv to gdb_core_xml_file and get out of your way in
deprecating this API so you have one less target to worry about.  I'll
see what other targets are doing w.r.t gdb_core_xml_file.

In fact, depending on the amount of pain involved, we should just convert
all targets and remove the legacy API completely.  Or maybe I'm not fully
appreciating the scope of what you're doing here: will we impact users if
we just convert all users to gdb_core_xml_file?  Do we have HMP/QMP commands
that will be impacted?  Because if not we should consider just convert everything
and be done with it - there's not 'turn legacy for a couple of releases
before removing it' for internals APIs.


Thanks,
Daniel

> 
> Philippe Mathieu-Daudé (10):
>    monitor: Extract completion declarations to 'monitor/hmp-completion.h'
>    monitor: Forward-declare the MonitorDef type
>    cpus: Introduce CPUClass::legacy_monitor_defs hook
>    target/i386: Replace legacy target_monitor_defs -> legacy_monitor_defs
>    target/m68k: Replace legacy target_monitor_defs -> legacy_monitor_defs
>    target/sparc: Replace legacy target_monitor_defs ->
>      legacy_monitor_defs
>    monitor: Remove target_monitor_defs()
>    cpus: Introduce CPUClass::legacy_monitor_get_register() hook
>    target/riscv: Register target_get_monitor_def in CPUClass
>    monitor: Remove target_get_monitor_def()
> 
>   MAINTAINERS                      |  1 +
>   include/hw/core/cpu.h            |  8 +++++++
>   include/monitor/hmp-completion.h | 40 ++++++++++++++++++++++++++++++++
>   include/monitor/hmp.h            | 28 ++--------------------
>   include/qemu/typedefs.h          |  1 +
>   target/i386/cpu.h                |  2 ++
>   target/m68k/cpu.h                |  2 ++
>   target/riscv/internals.h         |  3 +++
>   target/sparc/cpu.h               |  2 ++
>   chardev/char-hmp-cmds.c          |  1 +
>   migration/migration-hmp-cmds.c   |  1 +
>   monitor/hmp-target.c             |  1 +
>   monitor/hmp.c                    |  8 +++++--
>   net/net-hmp-cmds.c               |  1 +
>   qom/qom-hmp-cmds.c               |  1 +
>   stubs/target-get-monitor-def.c   | 29 -----------------------
>   stubs/target-monitor-defs.c      |  7 ------
>   system/qdev-monitor.c            |  1 +
>   system/runstate-hmp-cmds.c       |  1 +
>   target/i386/cpu.c                |  1 +
>   target/i386/monitor.c            |  7 ++----
>   target/m68k/cpu.c                |  1 +
>   target/m68k/monitor.c            |  5 +---
>   target/riscv/cpu.c               |  1 +
>   target/riscv/monitor.c           |  4 +++-
>   target/sparc/cpu.c               |  3 +++
>   target/sparc/monitor.c           |  9 +++----
>   trace/trace-hmp-cmds.c           |  1 +
>   ui/ui-hmp-cmds.c                 |  1 +
>   stubs/meson.build                |  2 --
>   30 files changed, 91 insertions(+), 82 deletions(-)
>   create mode 100644 include/monitor/hmp-completion.h
>   delete mode 100644 stubs/target-get-monitor-def.c
>   delete mode 100644 stubs/target-monitor-defs.c
> 


