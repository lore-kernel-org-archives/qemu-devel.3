Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91538CA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 20:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCNrX-0001av-VG; Thu, 01 Oct 2026 16:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCNrW-0001al-4R
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 16:58:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCNrU-0003o1-0G
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 16:58:41 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691HV0Hs2353193
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 20:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UJG0EHiovR4BhuDUvc/iv0g5TqDtOxr/MBEBqbOQACI=; b=PevtfwD7Ng56HlQt
 aDRnow13POWOBYuexRjOUF7bqaZtp9i/cj3A9Q2lHmVBBO48n08Nty6wngXslZJg
 UuBXXuyPuG4ktfiKYhY6Wsebt0bGTWcOQ7XE5NheC6lclKxCjca9MV1dWnCI4K7P
 yTPwo9uvNYg32RUYS0vJJfn7Zb09Ptvr3fxolIyPa3XDiZebU7+APgCJcMwLE6ML
 x8AKmm4aZUQuWkTIjco8ZiwTVv0Tk3zTlqgYndgsiDeIX0Qho/7g7rUJQ6CWlhzj
 +LvlKhs6a8yJ8NO9e1pRplxBUJ1RKrb8qKPhCPymWXySCwkgRU9+udK/EqcNwvV1
 hv0uIQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1v030u04-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 20:58:37 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34d62bb27a1so6461115eec.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 13:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790888317; x=1791493117; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UJG0EHiovR4BhuDUvc/iv0g5TqDtOxr/MBEBqbOQACI=;
 b=MXHJbkXJyxwAIs/t7YJ4vYMPCRK/1arQapp3vm0wFK/DkR41KWlibJHE58CL7fiS0v
 VBbepnOBlo2qBy8NP1v7c70744ieFh+rsKBAFn2rRJgs0uDUnpLQgnDcnfjTNgsvU3dJ
 BMJrOuqFOSqQy2CmDtgIemItWKVQxQFGNMfgj/Ep36LtH7NEdg5qRFa0OPlqqlzZXwiH
 LjKk/t3u5PKHdJJMKNSHZJN58DFwMcYWVnA+t9LI9mOknci81jKDK2a67J271F/4jMSZ
 DiJw3HhfgCmTP2ZZNQXpC1Ouw4YI2PqJa205nBDdYjBEsvgE6X3QQ3rHu3nQrJH8p1P2
 xXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790888317; x=1791493117;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UJG0EHiovR4BhuDUvc/iv0g5TqDtOxr/MBEBqbOQACI=;
 b=TKnsb9XHsGDmhzR0j0VCobWN12JPzmQ8AFgeQVlIm0nPqi7EVP4+XMMQBTtjrk6xnC
 0u7dOYq95WHR/bZUy4ekUBK+Nt8nXXuS8eQZrHTkkIHQQyIMJ0sqMRvz18NcbyTcOkOq
 czrXw7VtyL0dGWW/7+3LUkWD8keKBUDtoxDuZchxImFUFQDoqBhe7oDsWrDRcEEpu040
 7Y5XTdlEMV/aP1xkfdvKHeAqDXph6NghRoh+qouZwunm7rD/zanBlqoYT1wqyuv9N494
 Sh4MshiFvps1PV5wtIdbE/xlVY6m15qhCOwzHEi/oROR7e6Wre5ooksmOSHqxu8AlOOk
 7GCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpfI8fZQlHboaxcGIMR3svSM287hKT30GWLUocDZqhwZxdC4pPmOdrRvLe70f02flhLRw6a8s0Ed1h@nongnu.org
X-Gm-Message-State: AFq9FYKWCsu0jri2CxXl1mp9hY4Q1u230cnH8fFi6T93WA5rrPcxkGBC
 Cptl0snxRJ8vn6lTVHGglcq4HROwd+f7IE5X3n/WG6Js+A7fd57waZ30qLrgfRThdHEWs8w6alj
 yxA+84YNB/xctMkfKCulhlg2ve0E0Ivd2SnchCvGJi+D6LSbuZHMtBgxMjQ==
X-Gm-Gg: AYBFou3pAYRK95dwD8CjW9kc4UTL/U18sO7o2WqyPGtFSwzAiU0aUlacHah9v+ftwNq
 9ZGO4s1e8lE+DUbCGdlX5I/U8jf94CtV2rMDVzFFq0r7mtSIjsQfKfwCp0I/jmA0EoM3Pii5c9d
 QnBmk1IaQeRcQYmyOEC/paSt4D0f/0u7bQuVfOkRIS7uxvycLJ9XJWbrsomNjVBDRCkgYa7OQ/n
 k5DT2RNFg732PxG0NCZWe524YSi78yMGAH0JLkFv+hPNceSjY9xkvGBOiJb2WIIJqOTlBa01eQR
 5OxRSojzy3pD93UGqmLPaKz78jAhW8+E12zy4gXl1cnUSh755YxUWTMZoFQ9YMXAx/deRsv7aFp
 yvW8TId93XJHWW5ojhCWCngU0058M92dAyj5XImKBMOeuft1MopV7tfpCSyI3I3EVAPO2qQ==
X-Received: by 2002:a05:7300:72d0:b0:34f:364c:a9de with SMTP id
 5a478bee46e88-34f364caa85mr699529eec.38.1790888316401; 
 Thu, 01 Oct 2026 13:58:36 -0700 (PDT)
X-Received: by 2002:a05:7300:72d0:b0:34f:364c:a9de with SMTP id
 5a478bee46e88-34f364caa85mr699486eec.38.1790888315694; 
 Thu, 01 Oct 2026 13:58:35 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f150248b4sm787064eec.30.2026.10.01.13.58.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 13:58:35 -0700 (PDT)
Message-ID: <42ce6d66-e33a-4455-a1bc-dcda53f143c6@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 13:58:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gdbstub/gdb-xml: Add hexagon sys regs
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260930175108.3592113-1-brian.cain@oss.qualcomm.com>
 <20260930175108.3592113-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260930175108.3592113-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4MyBTYWx0ZWRfX3y5/ggbFlIno
 mh2LV4Ari7pCw+7t48Bb2CRifecorT1SvA99ehT0UDueieroBauYRS6lc0IsP7Y8VaBiExq9UbK
 ZeZvAtVoR2lqUmOyEgJ5wszicpBaglk=
X-Authority-Analysis: v=2.4 cv=GqfXaU1C c=1 sm=1 tr=0 ts=6abec97d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=eU0e3LhYAAAA:20 a=EUspDBNiAAAA:8 a=qfyrJJtqcQFzVa4gbUoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: XS0AnZLtgir0AO7cgo1RnwoBOs39cJtf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4MyBTYWx0ZWRfX7UsqqI5Efyvv
 VMwMEh8op4iQgp6Rfz4UPdK1OfEKCU0Js0mNuR1ZvfeOHVHGyoS9bDSC61oEhsJmE1tiFpuNIVo
 AxYlHeZF35LXHMtD8iSyqBWlk06i9F57LiCTN6qVl8+c8ZqvnUY8bFVykVUmQIL5lIrqPGEDiot
 KzZ9AaIuR0JqltgGkW7M39m0ZPgPCf+hzKYYTd4SoeHBu8JwfJs/FDfS4QIWIp4rOHH9Zvj/jN9
 sZwyvcBDyJuvFsf69XOnZ7ABqnMKuvfdvU5vXmuvEDLVXCQpotdnAaEVtE2Bn1EgoVHPWahqi2x
 4o99X4sACJbziZZQELG16sT6hNEAYmM4Dhua9Y65Uhk+JYwX43tiq3Zcb/HZr2JnGVIhcRrasMO
 yggf4ey2+y5HtDjuDyOsk6yIediPQb9LmrRZrUWEG2bqzdUhq8PoI/xmoef3NAM+4aby2FUsCWe
 xtChKxIPf6FOQBtb1EQ==
X-Proofpoint-ORIG-GUID: XS0AnZLtgir0AO7cgo1RnwoBOs39cJtf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010083
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

On 9/30/2026 10:51 AM, Brian Cain wrote:
> Add the hexagon-sys.xml gdb feature describing the system and guest
> registers.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  configs/targets/hexagon-softmmu.mak |   2 +-
>  gdbstub/gdb-xml/hexagon-sys.xml     | 157 ++++++++++++++++++++++++++++
>  2 files changed, 158 insertions(+), 1 deletion(-)
>  create mode 100644 gdbstub/gdb-xml/hexagon-sys.xml
> 
> diff --git a/configs/targets/hexagon-softmmu.mak b/configs/targets/hexagon-softmmu.mak
> index 6cbdc64be56..1ba6420d205 100644
> --- a/configs/targets/hexagon-softmmu.mak
> +++ b/configs/targets/hexagon-softmmu.mak
> @@ -1,7 +1,7 @@
>  # Default configuration for hexagon-softmmu
>  
>  TARGET_ARCH=hexagon
> -TARGET_XML_FILES=hexagon-core.xml hexagon-hvx.xml
> +TARGET_XML_FILES=hexagon-core.xml hexagon-hvx.xml hexagon-sys.xml
>  TARGET_LONG_BITS=32
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
>  TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
> diff --git a/gdbstub/gdb-xml/hexagon-sys.xml b/gdbstub/gdb-xml/hexagon-sys.xml
> new file mode 100644
> index 00000000000..434f11c0747
> --- /dev/null
> +++ b/gdbstub/gdb-xml/hexagon-sys.xml
> @@ -0,0 +1,157 @@
> +<?xml version="1.0"?>
> +<!--
> +  Copyright(c) 2023-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
> +
> +  SPDX-License-Identifier: GPL-2.0-or-later
> +
> +  Note: this file is intended to be use with LLDB, so it contains fields
> +  that may be unknown to GDB. For more information on such fields, please
> +  see:
> +  https://github.com/llvm/llvm-project/blob/287aa6c4536408413b860e61fca0318a27214cf3/lldb/docs/lldb-gdb-remote.txt#L738-L860
> +  https://github.com/llvm/llvm-project/blob/287aa6c4536408413b860e61fca0318a27214cf3/lldb/source/Plugins/Process/gdb-remote/ProcessGDBRemote.cpp#L4275-L4335
> +-->

small nit - could we reference a specific llvm version (tag) instead of
a commit?

For the rest,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

