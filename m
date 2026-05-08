Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0861CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 17:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLOYj-0000ve-GE; Fri, 08 May 2026 13:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wLOYY-0000tB-In
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:00:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wLOYV-0003y6-8p
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:00:06 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648G47TR1093543
 for <qemu-devel@nongnu.org>; Fri, 8 May 2026 16:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jfLhEgDyBEl/r7dqFFO7k3oEISsjAlu9Ud3kSrG6FWE=; b=EQXiOzpuSzmciw4P
 Ac6ClPk8oj4LDYCHNZTfST3fpaE7b99UDxofJxWWF98bQ441VesTS25mFjdSIode
 4HTukHGgGFwpYAQ1dHwZ3h7AZ5feKGDUnOEgFWEWxiVPA7cBQJOlF5teqSt+5pyq
 +QWLbU5OzPngbh1lE7y0tpQXB1lbOeVqaA8M8clkUk8MGHjMqHt2Z/gDzPAAoRkY
 xYNsyB0tMYIo6YNIPA+PTxMrUE3mWMGr56jzLWmCVOKlDWpGOrsHyMUNCNXbpCqm
 2/aeFzlNQfuvVgp8H89sQaSdVFyWoON4gp4DEq3pQZdtovE7sLgxFQD6X1JMbSrB
 iIJYUA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1k1d06mt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 16:59:57 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-95d5f0ac588so1227959241.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 09:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778259596; x=1778864396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jfLhEgDyBEl/r7dqFFO7k3oEISsjAlu9Ud3kSrG6FWE=;
 b=PvKMrlxoekKQ+PsCxq4VCUMle9jWP6hcYyl9/lCh48sMANAXWUjZiJYAWhl2YEyAXM
 3t9kCWshm+8//i3mPDL/8BhjxrZeFkS7CetaE0Mviex9NDJ0OF28E+GqNAPwSvrM0CO7
 92ELMSVhjCflyd4lguaK9RyzqpB55HC7l11wsHj1Pk593LViOYtHjFni7IzW9vAI/gwr
 mbhHk8npxfUTrQjM8nI1rd6U3IM3p0KBmd4iBHi14hPrtu/tu76mAetwEJ1TS+bU1gj+
 lUdx57pUzdlsfgWbk5ZDSTFYAIyMTHxKc/dkfaGUDO0KrgqwdvExe2o2g2R0yVkcsXC8
 dojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778259596; x=1778864396;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jfLhEgDyBEl/r7dqFFO7k3oEISsjAlu9Ud3kSrG6FWE=;
 b=OQIalriH14cR+9VcUjxFornRnlm/esi8nQzThL8o2fZRYwkyfAZmxQr04TeodPCPHq
 5ZwW+y6/Qqt3UZMRtNWh8jjbKGM8gWhMkkfXVDoDF/Gfnqtt+3GxjQcq0iQ4ZR4AgKqc
 /irvfL3ssUlOKHFZuBIH2jcVXr7p5GJ3fjtnrp7U+PswzzhdKxaZFd0L6kQvoKW4qfAn
 Ylw/9St9SBTQBzUnaPKGlLCGRXV86sOpwdc5p/AyFYD0bh/NK1ea3Vwqj7bsD/xBOUg7
 0ClI4Yu2XlM+3z7PDzlqZTs61SnG+ZPuTSXvjzK5RahCXFa/4P+NTkkxy6SqlTZ2WSjN
 E1mw==
X-Gm-Message-State: AOJu0YzZ9iLD4miGi4xSF7KijxW0Tbxi6V3ZZobRTDvzXqL1R1tmBkCw
 V+eGml6p6rx2E2+di/oVY/FmqxXkDBl3RLyiBHPkUTXMDgWVW4G2VPDr3Ovh+WnbPRtaODBbYr3
 TdQs3f19q7I5zKgKQNgUcfUWTpEK1mRQanUaiQvqJ8uq5HBKS4YO2v20ZJA==
X-Gm-Gg: Acq92OHNStK9oNhSutcGo53zczxcy6uJZxRhx/QpwX2OXzUz0pGWvaFbcMJsbKAJgGs
 GcqJJ1N2tQ0hbZpPyuprzh2G02ieldWzx2ArxuJbhsUaelX3lMWszxpmsa+0SArS3NasJHbdO5B
 m5ttbJmcRD/czpg5SlGmtsmCK4txyJrJvYDyfvGzfykDoD06A2YUh+nCF7UlViz2nqz+7zoa5pq
 NegbURS9ohAY8lrHcM7ffAmg/51+HSWNUpRTQatotejPYZ1JpYBYjz6VwlHatBf5SKjCUdVL21C
 sXWCwsapTBFrsaSwq+iQ09ALIUvvi+fuSlCChNHq8F36imRgp+lKcggVaAPvL6ByDjehoKDdvtZ
 ZTBczAi0bADfohhYISOypTtfNwjVdmgKrkqLm49GJxHgl9CQ8SeVYcoJK/fQrPajLKeDGlQ==
X-Received: by 2002:a05:6102:304e:b0:62e:79ee:4cda with SMTP id
 ada2fe7eead31-630f8e6ad78mr7796554137.3.1778259596189; 
 Fri, 08 May 2026 09:59:56 -0700 (PDT)
X-Received: by 2002:a05:6102:304e:b0:62e:79ee:4cda with SMTP id
 ada2fe7eead31-630f8e6ad78mr7796538137.3.1778259595488; 
 Fri, 08 May 2026 09:59:55 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.237.136])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-6314005a6acsm1271398137.5.2026.05.08.09.59.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 09:59:55 -0700 (PDT)
Message-ID: <e172e568-5419-41a3-8a83-baf30e774f0c@oss.qualcomm.com>
Date: Fri, 8 May 2026 13:59:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] hw/riscv: server platform reference machine
To: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, leif.lindholm@oss.qualcomm.com,
 Fei Wu <wu.fei9@sanechips.com.cn>
References: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
 <20260424191129.1494381-4-daniel.barboza@oss.qualcomm.com>
 <CAKmqyKNZiA=rYVD6ighyFO+qmhdYVk=UgbaznBHrZ2yt1ZvOtA@mail.gmail.com>
 <wazisnbumueun37qskfnjz7n5ioqhpshesebjsczgucjmxxhia@va7avfk77xlr>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <wazisnbumueun37qskfnjz7n5ioqhpshesebjsczgucjmxxhia@va7avfk77xlr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE2OSBTYWx0ZWRfX6GT/wLsc/tu1
 P4SuNFIVA4VrOpCoJvKTCIqnVejt9r4yzDee5iJ0DomtHjAg5LrCHt72e+h/ITWCi02E6DGD4Aq
 8xAuaEJd0Z9+HOXXD56GZnuaRmjNnmoI9H3+vn+/cCEmL/h0i+rCICS17c/GP1ikiZJy8n86gEk
 53fxTufoPxYe5/u0zxdXfhUcG+VuvHvFwhbNxe+VQrLL8Cj9qCFlBE6c0qKEsIokeLWcdjB/JDO
 15MobppQW4xwCRkd4V0BhtCfYlpQYlVf5cdlPMFshMZHF9bYBdaDZOzxpJZcb0xblaSzvCoJoFO
 4I+bN8GFHnC0W7W76JVfGTb1HvEibOd0PLO0hfr1NstuvOBEpdiBTj8tSgmlLcIENiBW2R0AE3i
 m+S8W2rdISXRriKzBlqc980ja4nHecWXE4uGrlllO2/zSNiw4IQ8s1oQemthHCD3HJvIBKq3L5n
 SCIbhj2NKZldwE6qDIA==
X-Authority-Analysis: v=2.4 cv=GLU41ONK c=1 sm=1 tr=0 ts=69fe168d cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=IZaa5BNpKBTNMhuJoHisKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=RB1i_c-AkP-gTAHhIr8A:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: CPtKbDP4OpOwN6tv-hQIR-fgJZO9FtsR
X-Proofpoint-GUID: CPtKbDP4OpOwN6tv-hQIR-fgJZO9FtsR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080169
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 5/7/2026 4:23 PM, Andrew Jones wrote:
> On Fri, May 01, 2026 at 01:27:41PM +1000, Alistair Francis wrote:
> ...
>>> [1] https://github.com/riscv-non-isa/riscv-server-platform
>>
>> The first line of the README says:
>>
>> """
>> This document is capturing discussions at the Server Platform TG.
>> These are not official specifications and everything in this document
>> may change.
>> """
> 
> The README should have said frozen instead of "everything may change".
> It was my fault for not having updated it. I have updated it now, though,
> but not to frozen, because v1.0 is now ratified.
> 
>>
>> So this machine needs to start out with version support (like the ARM
>> virt board)
>>
> 
> I'm happy to follow ARM's reference board's lead on this, at least for
> now. I only wonder if we may not want to use the QEMU machine versioning
> support to bind machine model versions to ratified and experimental
> platform specifications at some point. For example,
> 
>   rv-server-ref      -- new, bleeding edge platform implementation which
>                         may include experimental bits
>   rv-server-ref-v1.0 -- versioning ensures the implementation matches v1.0
>                         of the spec
>   rv-server-ref-v2.0 -- versioning ensures the implementation matches v2.0
>                         of the spec - likely backward compatible with v1.0,
> 		       but not necessarily
> 
> I'm not sure if [ab]using the QEMU machine versioning support in this way
> would cause confusion or other problems though.

IMO we shouldn't use the QEMU machine versioning in this case.  We can
instantiate a new board in the same server_platform_ref.c file that has a
different init(), memmaps and etc that would reflect the new spec.  We can
do that once every time a new major spec version is created (so ... once
every 2+ years?) instead of having to cope with the all the compat_props
machinery from the regular QEMU versioning design every single QEMU
release.


Cheers,
Daniel

> 
> Thanks,
> drew


