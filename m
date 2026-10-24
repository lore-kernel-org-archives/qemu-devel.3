Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D4C606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 00:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bWQNnbY0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JWge+JZj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKPFR-0002Wb-Tr; Fri, 23 Oct 2026 20:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKPFN-0002WH-VG
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 20:04:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKPFL-0001D9-1z
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 20:04:29 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvOG94006737
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 00:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rfiBVE+I6JAGg94BbfkmJPozxUJCoR0Nx302pbEMaiQ=; b=bWQNnbY0uaeLp5d/
 0D46qLaRFdNCYUTDxWqbJs65RLsWZKat6uOhpFTMEzC/ELbCqxFHoi6P07+16AJg
 GQKg0PohluUqAIukkYmEphLf0zHpJ2PS3+I4OxH1Kac4AbTZLBWBQu4F8spopg8L
 c4CYA2wMga2KaV8uweC4XC6mDV1TPkX14llpn+7IcLew8uqb1onya2vfCGPai632
 Kxtx5nyqhxFnEqyM6swO7pGaEKMLFZmqpLAtsbPBbI48YCeznK/3rSO6ZkSKNI61
 wvBTIaycsTkhQVZKOsH9gGzRUfZCjonYwTzpPjJm7+b5XkG5ASlaL6zHCY8JUgd9
 I8DHzA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn296g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 00:04:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so3328570eec.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 17:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792800263; x=1793405063; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rfiBVE+I6JAGg94BbfkmJPozxUJCoR0Nx302pbEMaiQ=;
 b=JWge+JZj8ul0EvN3I3hq0R2EFDFbVZ6mXQi30+OGEyOU8XKjFB8isLr1AUJKK/jL/b
 maY0vWS8XzQdvWEgTe5e7ulcBkJbm5oupW3voBLmbjSln0AVwoLWIhHR2ki8odu2Zner
 Y93OiheHodR89ZBFLrj3Ai5v57DjirmKsi3PDjUBo8eSEjOlMASqYIDPbvjM0oaM1qmQ
 vhIz5nABWUuEbbv8pFkmzCtIWO10DbhnHK6kht8pqO16TaeVhENF8CrDgStrzALC0oLT
 GelfdWWfHxI6WTvdu9u/AOCzanp4uPNGQJ6ulYIFxZk9/JnzXT0XTLT2q5cadQDNdH48
 nDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792800263; x=1793405063;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rfiBVE+I6JAGg94BbfkmJPozxUJCoR0Nx302pbEMaiQ=;
 b=0yyUW13KSYfhqqGNgug5YwxlA65z2xwkB92pYDPSiBW2iDW4EW12e+4/kWcdWrFYWn
 WzUxk5hjpVz8Qs8qldVUpjsxvftNO7v3CZmNw/xGi/tg/otXwShwIw528es+1BtXLrs+
 HIjAfaCCuff5fRLwRWTtMZ0JBt94mfqPJQtYTn54FpzjcuogwjIF1ILOAEnf9JAPZkCK
 Xkkprvc5w98/023SRNDR9xv1/FMDDEVHbE5rF4oTUhWkCN5bNGacq2qHWQ7lzJ3SE50Q
 gKc2vW1vCbE01GSs2bSZI0kabxl8zo73TUAQ3dzaDQFGEwAs6a4Kxf9jGMWYrp5zOvON
 D1gg==
X-Gm-Message-State: AFq9FYLhxZ3ilCFmfu3J4VCR36qjOffXTsOLYhA8xqYCtBFXSaec3i+Y
 oHzhgpacdyd/gMCO7bdAV9ODPNY3cOBfnOeGizWScLUS1T0sfwMV+Hb+GLAE595eeAmpUX9IlnW
 QUDU0aGmgtkIThSAHUrf21W79LXEhUrL8iZj57eR0Jgl0RK2xqGhYajTABw==
X-Gm-Gg: AYBFou2Gg4Yhjk3LfNEPNwcgOhEdJGyAPUulJo4gtdOteqaFni/cWaL1MpPWOprmTaW
 w8Jbx0TjJU/qj1g0ivuYDojH8Ub8vwIqJEGfszhU/33r+EpXXOxBvmaKEn8e7GARsH1FgRJuzTo
 5jEU11Kyu3irjPE0+0Akg/ydwMJiSGFymZqyWR+5QNl/ryDB0PYiba9nmHM/H4IiAz74Z2Uqp38
 0jwYRKond8MHQdssgOU1IWECLZHvvejdkSNMzh2MWYk3AZn9qJjti72vLtzsfMrr+2KpII++qns
 1UzITTLHtWZczIDtPEmwpYFS7eDDW3hEuyedJBvnD7Cc4uas2j40gusyY7gbMJT2QnxkPx2inpY
 B3im+7mcUuA0RyhYUGZYlY7Pp5nk0UnGkwHp0hC0Z/eA9GagH5HfipVnZpaF6E7aYUIygbw==
X-Received: by 2002:a05:693c:41c8:20b0:366:cc5e:5b7a with SMTP id
 5a478bee46e88-369e8621badmr970046eec.41.1792800262430; 
 Fri, 23 Oct 2026 17:04:22 -0700 (PDT)
X-Received: by 2002:a05:693c:41c8:20b0:366:cc5e:5b7a with SMTP id
 5a478bee46e88-369e8621badmr970003eec.41.1792800261647; 
 Fri, 23 Oct 2026 17:04:21 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db7b23sm1927981eec.19.2026.10.23.17.04.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 17:04:20 -0700 (PDT)
Message-ID: <10a712f6-5b3f-4c1d-a0e7-d201468d0fc9@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:04:19 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] tests/tcg fixes
To: Eric Farman <farman@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261019185600.2031729-1-farman@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019185600.2031729-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5NCBTYWx0ZWRfX+WXSjQX8GJBn
 7dQTkZaBWMWp+1wYsJy0tCxBzL7hQAYVmthRBHyM5EGWS35wzEiilbtz2P3E/wUXyTS+UJXs3H4
 lF0b11W08FoTtDKKo0vjtEqG/qAVCjvz9Z/BkGujUYzNoU3kVn7L+DCClCHXzIQlp8+h1C9ydJ7
 guCAhDLRskH4fiSCdT9c/TGBY9Bquj2rq+b29y9tlb3O2Xwr8+bNMH1Ietus+H31ihp4YOBcWIy
 24o8wbtqEJqOnZUdUToMwAnrC9vKOref9ei8kcUrIwlYnODeegE0Z9eds6psji32Nk+x5CCBXDr
 mMA+zm6Fz8vZd5Kx3WCgAcDTucsUkPMk7GuLIb9ni6Wn64RViMQaEhZVXYmcTR9eKcdk9i30axU
 ztXUUHJU1y/QSowO4xE+PebgSVx3hRFGQNPpSN0pMUrJK70xFO6z3JblFDY0YizRqwP01fvo3yf
 yo18QOyk3tJ6oAHJMng==
X-Proofpoint-GUID: 9Y67uN5wAawYR7ES9u4by_YKRlVHYxvg
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adbf607 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=vpHPgimwONWjb4lggYAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 9Y67uN5wAawYR7ES9u4by_YKRlVHYxvg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5NCBTYWx0ZWRfX9DpO1Ywl7NmP
 DSgJ9zPCHwDkD3pQLOiTfIBzqjtqv7iwZN9QMv21hcDXjytbNLTXEkS7aLlWZDXHuEbI0lilr7T
 FuulIhglzXo/410/6yXhua5yidSWiP0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230094
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

On 10/19/2026 11:55 AM, Eric Farman wrote:
> Hi,
> 
> Here's a quick turnaround on the tests/tcg fixes to address Pierrick's
> comments on v1.
> 
> Quoting the important part of v1:
> 
>  - Patch 1 addresses an endianness problem that shows up when running
>    on a big-endian (s390) host. It's existed for a while, as I can
>    recreate similar errors (if slightly different messages) at least
>    back to 11.0.0. Just never noticed (or looked into it) before.
>  - Patch 2 addresses a change in behavior that occurs in the powerpc
>    toolchain between power6 and power7 (based on experimentation with
>    gcc -mcpu= settings). The tests as they currently are run fine for me
>    on either an s390 or x86 host running Fedora, but fail on both hosts
>    running Debian. 
> 
> v1->v2:
>  - [PB] Add -mcpu in the loop processing the multiarch tests, rather than
>    skipping it and adding it later.
>  - [PB] Squash patches 2-4 into one
> v1: https://lore.kernel.org/qemu-devel/20261019151233.230172-1-farman@linux.ibm.com/
> 
> Eric Farman (2):
>   hw/i386: ELF endianness fixes
>   tests/tcg/ppc64: Run float_conv* against power8
> 
>  hw/i386/x86-common.c            |   6 +-
>  include/hw/elf_ops.h.inc        |  20 ++++-
>  tests/tcg/ppc64/float_convd.ref | 144 ++++++++++++++++----------------
>  tests/tcg/ppc64/float_convs.ref |  80 +++++++++---------
>  tests/tcg/ppc64/meson.build     |   6 ++
>  5 files changed, 140 insertions(+), 116 deletions(-)
> 

This was merged into master (b6c4b7e86dec12d07f5cac65265b986d38ee9002).
Thank you for your contribution!

Regards,
Pierrick

