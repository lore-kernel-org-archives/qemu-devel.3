Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9239D606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CL56ISUf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QOGo1aPY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX2h4-00066D-Af; Fri, 27 Nov 2026 15:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xX2h2-00064t-5L
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 15:37:16 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xX2h0-0004ld-90
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 15:37:15 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJR8PV2668642
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 20:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mE3wRmb99PdPfmV69eLIzuEMI0ZJkMFKude9cyTAdlU=; b=CL56ISUfe6Cv4yXS
 9mFK9zL6urn1ZOGNbK32p0+E1c3jAIUQSVBslCzMnfSDm41X+uE7lNzgcdQ5Ve6l
 yNdq6Lscud415ZwSfrOpbh8fKJgQIn/A9Vuq0o/xwqW7xfDZ7LIfspfm3KpD6eGI
 ds2/7DcXUv8895QPIrjEqM4QTVHK14msldNJdSTLjOxSa5vxA6v/jDUrqnddF8aL
 6f9yno7xgPrRaNRQkklvmfF+OnU6DxwmcMEwV2c35kQd2RKGd1o2/HvUTccnlVfY
 2qidIPwRX7eXDtmTrwosi6yMa7cFXcQYwpBtHYbMABxcIs+YRYwbrj4MPPQ8HwXw
 4Ui9og==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7g1jg4y2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 20:37:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-382af5cfc58so6495910eec.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 12:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795811832; x=1796416632; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mE3wRmb99PdPfmV69eLIzuEMI0ZJkMFKude9cyTAdlU=;
 b=QOGo1aPYI75a7UHEbriF264HZ3axIwGRR+NnZFfTj66xaNz7Z193Hh2oK9nBk/mNny
 VtWbsHhBErYjcq5oE7fsyMMvTLHjnam52JfXoKVbCLdqJeYmMpzpd0+hbsh69DpKvg8h
 lqCS8f33bxii1PhYzytkpEWof/b1jwTmLEyF1fDPMGne4wpINoxDpHXks9O/y2i+hMsk
 q/b0FOYMEuu/nxLD8Ac3yYmxDl/y6t2pNEUTPOWrtQdM7lrxurLet/4u2Z5pNyx0AhVn
 PUrk4SYoUsTD4FxWl1QeBChpg3U+bL5NGZ0U7Qyljo4JMtCJ+AQfqs2f0e5B1oaBN8Rx
 CRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795811832; x=1796416632;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mE3wRmb99PdPfmV69eLIzuEMI0ZJkMFKude9cyTAdlU=;
 b=leb4jICamWiZdqhHr4qI5uWtJcdcG2NsTz+WyuvhaPn9/9JG2eQg3Nkmwx82Lx95KW
 hH0Rs7uOGOkbCLrhW/+IATIIG5yi0GMRNAbD66Xo8ysKYhLIX6rZTNFyooWcysbuuzWn
 vc55lBgeGirqjUpybaN5rYXlwEuN4ucgPZ0/kwazz/ZLYKwPKBbDo67HCrwbQLgz0L6f
 szchcfV1+WfOO/GrgGICBij5hwjz5BuxJGTrtyEQgft3l8PhBFVw5/kxyVJYUmXCJv84
 KRpinzFlqpRwKZ/NgX1JfVBOqmRxMSK1RnR5hbgDA/Bsi0494wIzrzA1asa8VtLyD0sb
 Q+ZA==
X-Gm-Message-State: APuU4Z+z0OGHn33aEfbbdN5x0VIVegS+kZbKGJ6cIFG2GjcXk1hYE2hz
 708W2fqHRk5EyvPTPw5wzr5PosmGH6xflDQ9q6gOac8fBAR8y5iWP5HA7x9c8UGvwBPYYjNgh+/
 AfRLACGNW11Zpq9nQ/CDjEAZAfeZHRS4mMQAfY2If3KWcRxcTpAA0Ns7BV32xa8cgQw==
X-Gm-Gg: AZFdTZdxEHLuxUnwCqbdQ/XOXc2LGBaXV6nmPQDSQHFvV7Vw5QSr/eXunwv0kArl5jR
 avElP0HjM4MBYYvKH/XiwtprAV31zJ1XazN4OLxPamKEONFxVj7vOCsxstNDFAeSkXT3XlDvMV7
 F+3KjOvqNna8EbGNfB9DgS0GVYLja600oWYnmjUPxneWQufNt5KViB/YirHp+g5hpnTS+kfPnsV
 D1U/NVYWh3KGsgIX9BPMVdKvMPY9ZR+e5FKtc8odluHN8gSnz5rzP8fp7dVa+uaMQcvX0TNIguy
 /g0z1w6LOpBtBf3DqV3o8Tyw2zPqUoeVze6F4LO03IMh1IB6M8ZI1fu6cEeGqtC4q9cDt551Zkw
 gGnXNM+zO1e0I9vBoId/sDlMs13JJn18IIQrZxOYKavYS2MBd48rhEx7JQmcCyM20/O3RAg1x2g
 7e0uxi57ginOcIhpd0uAdea3+TgKQ4FuU6hFspiakIjHxe//qKVsJx
X-Received: by 2002:a05:7301:dd86:b0:351:2958:1740 with SMTP id
 5a478bee46e88-3856fb641famr25206188eec.37.1795811831665; 
 Fri, 27 Nov 2026 12:37:11 -0800 (PST)
X-Received: by 2002:a05:7301:dd86:b0:351:2958:1740 with SMTP id
 5a478bee46e88-3856fb641famr25206155eec.37.1795811830960; 
 Fri, 27 Nov 2026 12:37:10 -0800 (PST)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd40c5sm91477410eec.10.2026.11.27.12.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 12:37:10 -0800 (PST)
Message-ID: <d5685689-93f6-4d35-9adc-d9e9328da595@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 14:37:09 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-12.0 v2 0/5] dump, hexagon: add support for cores
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Ani Sinha <anisinha@redhat.com>
References: <20261127203209.42752-1-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261127203209.42752-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MiBTYWx0ZWRfXyd0OdmO9egxn
 nCGvM5sl/xMC47CJx7tTq+eD6STfzYqWu6ij33+XG7JWg4KLa5GCQgDtctCtrVZ8A9/j5auMqvt
 baO+HNSs/DISO3bJYigLNibOparQ6VV9B4nDo2FVRS97fDWO1TcoMtQARmxteh2d1tcTUWRVQAQ
 BH1w/BR59YidYo9NYEKWRtCkimNdScBQPcQJS0DY5Z61j8ZRxtd05BMAcDhJCvLzGAqOP6bL9bo
 uAxoFf3PD2hst0GfoBiZek992s2PhntgJ+kIU54zerSDvuAR5lHMzla337jHYFcwVlYJ3v7C0Yt
 09JePSDxzfdbs/SSr8G1v21A7E4QMfnaGBXUCxCCq28n2Oug6b6O6NTb5tJEGHMfrqLbctGeRKV
 VdCkiVzxwwNj9uzAYUggO17eQNDMNptZwk+bOkfgc1OpPijxQ5GoiN2eehSUpklyX1bUfP+OgNh
 rJBq9PUW0uW38Pfq2dA==
X-Proofpoint-ORIG-GUID: 1h4aRkGd1S2x9_gS1SGg29-AQaowCk8g
X-Authority-Analysis: v=2.4 cv=QpzLTlyd c=1 sm=1 tr=0 ts=6b09e9f8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FbE0QtbTI5SGvpqK8CkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: 1h4aRkGd1S2x9_gS1SGg29-AQaowCk8g
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MiBTYWx0ZWRfX/nDlaGELsWcB
 NDBdAIWihgqHdDiraNoonULJIXaOh2kB1UjAIOEolVBUK12zKx/Ylb/KysyiMUV/a2TwsM3CjKR
 6dy2XSjUknf6t4RrT1LKzdyznrWKy8g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270082
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/27/2026 2:32 PM, Brian Cain wrote:
> A bugfix and implementation of core dumps for hexagon linux-user and sysemu.
>
> "fix e_ehsize in ELF core headers" seemed like it might not be appropriate
> for -stable, so I've not specifically added it as a Cc/Fixes.  Could it
> cause some incompatibility?  Seems safer to just land it for future releases.
>
> In v2: replaced `if (!cpu->tlb)` with assertions in "dump vector and sys
> regs in cores" and "support ELF core dumps".

v2 is fully reviewed and will be included in a pull req after 12.0 
development opens.


>
> v1: https://lore.kernel.org/qemu-devel/20261125194855.3154845-1-brian.cain@oss.qualcomm.com/
>
> Brian Cain (5):
>    dump: fix e_ehsize in ELF core headers
>    dump: let targets set e_flags in the ELF core header
>    linux-user: let targets add notes to core dumps
>    target/hexagon: support ELF core dumps
>    target/hexagon: dump vector and sys regs in cores
>
>   include/hw/hexagon/hexagon_tlb.h |  10 ++
>   include/system/dump-arch.h       |   1 +
>   linux-user/hexagon/target_elf.h  |   8 +
>   linux-user/loader.h              |   9 ++
>   target/hexagon/core-dump.h       |  89 +++++++++++
>   target/hexagon/cpu.h             |   2 +-
>   target/hexagon/internal.h        |   8 +
>   dump/dump.c                      |   6 +-
>   hw/hexagon/hexagon_tlb.c         |  17 +++
>   linux-user/elfload.c             |  14 ++
>   linux-user/hexagon/elfload.c     |  14 ++
>   target/hexagon/arch_dump.c       | 125 ++++++++++++++++
>   target/hexagon/core_notes.c      | 243 +++++++++++++++++++++++++++++++
>   target/hexagon/cpu.c             |  17 ++-
>   target/hexagon/meson.build       |   2 +
>   15 files changed, 560 insertions(+), 5 deletions(-)
>   create mode 100644 target/hexagon/core-dump.h
>   create mode 100644 target/hexagon/arch_dump.c
>   create mode 100644 target/hexagon/core_notes.c
>

