Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099EEC9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9oDc-0000Wn-07; Thu, 24 Sep 2026 14:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9oDI-0000Vk-Kk
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 14:30:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9oDG-0000tV-Qb
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 14:30:32 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OFeUrp3064799
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5xHYCcs7DHjUHNY/6J7s++5vpNKqVAbch5+w0lVs0gk=; b=S1a7Kx7jRQkPuOYS
 O9oS9O6C6/6SO9bbgJGwTzWPHAaTeBuwyZEcPpwZBLs7lvwEG5qrTSgIHqO9E3nX
 I9WhVzzJfrhWS6sPy9mIatTg3NnxffFEZEWir6gW8akn4bxYR8KBs/AnXatl+XYv
 nyoIaZIwiihIabLI+Q5oU4G1da8yOm5NnTRRYzzJHdFqxhwIuQsWhtuWBkdR4dJS
 6lrQacA8L4BQoM4ngeHtXlZt4COEmuQeIapcsMr9dq1rwdFE+h/HhXktlYKHlvAt
 u1ZWFAnPmYWRyYhaEuom6MaK6y1JuycUc3pUl6tw+/xnxPbXN+qN91zyEJyr4MLf
 EJwQyA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1tjj54y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:30:26 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139b62317d0so443428c88.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 11:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790274626; x=1790879426; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5xHYCcs7DHjUHNY/6J7s++5vpNKqVAbch5+w0lVs0gk=;
 b=ZnltpP+gx+tztydZC3jTfW7d3Y3kWaDj1guoddArQhz1VL+vyeRIVNcE8P+88FhN7k
 J9ZWQfLlgxxZ5twf/8sCXYkvktnItF/HrrvqVgrGxnQ/Gt9hbu+9v8I7yBuKNSpS+jZa
 v1rNAhBj5QuCmfKnamPSIoaRcZLzx1i14CRrnDRg4U8TUleUzssvP5dQ2yrOPMRlU0SX
 EW1llhxmCGxxl2ySFAJmwrWI/pv1djZx51gc+dBP0UHjK3xT0diIPOIfnQMQfk7DaJyz
 hx74o3NqgqdYlzpsHYEFWgh9sxS26lWatSf0cxufWnHNhB18At3vu6UtcBAJd5781Wpi
 S/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790274626; x=1790879426;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5xHYCcs7DHjUHNY/6J7s++5vpNKqVAbch5+w0lVs0gk=;
 b=nCO1QI9Oj8g+ht6X+1BuqW+XNn8DyH+nMGSGQUcJtQFQpwwL2Js86I+dFgTlTinKj/
 QlvHAyMkQAfrDMrFCwUDvTvu+J9XA0y1UJdqNVdsnvGEJgmOLxrJF/xj+lRcW/YvkSD+
 gD5rPtEv+TttzIPGWJyPg12hDbu9pQQ785TKp45QXYLDAv6TgIylgxxdyFcT1VSTHzrY
 FvCyjaoPI3Dzrz552bJWkjXM4j1JmMoTYlT/AP+tu/PBp/Hr/7mQJnrnoFp6A6vzQqkQ
 6oYRJMTA19LvfwAEKbH2vqMFBIUGMOMJOcyqwnmb7W2r+/rz1lJB6/FuWnY078FiNwEv
 onkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWyPZiTCjjf6+D5/ogI1chkdSYPUZHRienDbXLO3vDd6mIc8UUMUtC4brQ2RBVXh1aWEBF1dVVL4aC@nongnu.org
X-Gm-Message-State: AFuF++lJI2s0klSiFRDgyg05hmdkiwCSGnOvzWdaSlTS1WVE0U+mkNxu
 aki/VcCDfb2uV64HK+wGUz8KgPMlIMapUBd12bK/iXwi+fWwA7GnLcyDnSUKvoNG2pyN3ZCGh52
 w6D1li1wSacWAYz6311F00BXLKMj/h9bX3ZCWsPSQfYotGF6Zx7PMXb+2jQ==
X-Gm-Gg: AYBFou0Lo010iL82Nk4m7ZLk0ntEq2jkrPrQSB8cqaCxiNH5xzYxK/BJEVRFzzxBuxX
 53M+AgkpI8llVXdwPqqD2e0j5WBsJRiig5cE72daJLPuA5rWZ80n0f0qD7HwQHjF+4il9sPBxTF
 pbYefkI6lc8ZxMeZ+ZsClozVDEgpI8yV+owjHr8ttGoAZbf/5j5Qiskq/9wdsCHKKlZs9mOva1Z
 7RVeE5bd2H8FMeKus+Jf0lKXO2tmZN7xqyXv5o0lui4bUf2Gl6cj4BLfVUBie/sBL5p4Lxc+WuG
 pu+8LqzdnXSvjDwuS5dVFFNyoQA+TRR6C4CkeZRUdG6xHaA1/PjwTWYDiG8OeLxGVmxaF4C6z9v
 k5OumkEPK8p31xVKy/RxCe2LvWNqhxcI3Rj9ubO+dUA54GHQJajU6+9sN+Me0M1isNYM=
X-Received: by 2002:a05:701b:420c:20b0:141:b2c3:d868 with SMTP id
 a92af1059eb24-14503f85054mr2958974c88.3.1790274625723; 
 Thu, 24 Sep 2026 11:30:25 -0700 (PDT)
X-Received: by 2002:a05:701b:420c:20b0:141:b2c3:d868 with SMTP id
 a92af1059eb24-14503f85054mr2958951c88.3.1790274625088; 
 Thu, 24 Sep 2026 11:30:25 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145acd3d8eesm393163c88.8.2026.09.24.11.30.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 11:30:24 -0700 (PDT)
Message-ID: <6b37b050-9d5a-40a1-ac65-4126fa725342@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 11:30:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 092/105] tests/tcg/x86_64: system tests
To: Bernhard Beschow <shentey@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Aniket Sahu <asahu1x@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-93-alex.bennee@linaro.org>
 <cae2d17b-571c-421d-98c8-fbc467134141@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cae2d17b-571c-421d-98c8-fbc467134141@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: w3orenMoQNNbDFCaM0gGDAg5Q01md8g4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA3NSBTYWx0ZWRfX3tPW8Qit5xzI
 Q1p4bvHiE7vK5nHEs9p+5U47EEJrDI5yLDlaP2f9xWmG/Kw6qGTPKCRRLparpR/MyZkI/CekKEN
 emlzE/lCg55tMzSC+gJilI7DILXxI7MKlhTuvnih07b03e/RwpEBpdC5VX+U6ME0zU5POvSY+WW
 PsJfKGDpwJvHr6hw4SXYdVDQ9QuJCUjqAGe8CX+S0haXO13k4yxlrzFpF9cEmodgljKA6QvBp0L
 OajkXjeM3nThyuOFwio9UYmbB4/sYeTeYNl3wxLwzZAjiP6BUx0go0NZIVQiDJDkUu0CdVo/2jh
 dB4qGxqMQIF4+4zMdfU/KZe21jN+DUEwVcr9kootTjDp3sioytKzIPT86R1yfzSQ963dVFWFBG6
 gubkJyUVjQ7oppbkol7claiNcEXmEQqY+bOBIspEJMtMg5P5fCk7rmav9WBhNVWErup4c+lxCNX
 0X6H1N5hSJeTJ3R+aww==
X-Authority-Analysis: v=2.4 cv=cK11IVeN c=1 sm=1 tr=0 ts=6ab56c42 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=FcFjeIISVmiBXUcpFZoA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: w3orenMoQNNbDFCaM0gGDAg5Q01md8g4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA3NSBTYWx0ZWRfXwbp+qIpyXmMs
 Rx2vF2cTBeA8YNRCkT2DGR2RDLgQvBxBFWH4VdKrIGN7lE2CGznuxkC+Hum4bJrWBiCKczS64mV
 wfwQ27s24PmbctppBmAhWCYyGtMuqk4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240075
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

Hi Bernard,

On 9/24/2026 11:18 AM, Bernhard Beschow wrote:

> With this patch I get under Archlinux:
> 
> $ make tests/tcg/x86_64-softmmu-hello.test
> [1/1] Generating tests/tcg/x86_64-softmmu-hello with a custom command
> FAILED: [code=1] tests/tcg/x86_64-softmmu-hello.test
> /usr/bin/x86_64-linux-gnu-gcc qemu/src/tests/tcg/multiarch/system/
> hello.c -o tests/tcg/x86_64-softmmu-hello.test -static -MMD -MF tests/
> tcg/x86_64-softmmu-hello.d -Wall -Werror -O0 -g -fno-strict-aliasing -
> nostdlib -ffreestanding -Wa,--noexecstack -I qemu/src/tests/tcg/x86_64/
> system/../../minilib qemu/src/tests/tcg/x86_64/system/../../minilib/
> printf.c ../src/tests/tcg/x86_64/system/boot.S -Wl,-T ../src/tests/tcg/
> x86_64/system/kernel.ld -Wl,-melf_x86_64 -Wl,--no-warn-rwx-segments -
> Wl,--build-id=none -lgcc
> /usr/bin/ld: /tmp/ccRh6mPz.o: in function `print_num':
> qemu/src/tests/tcg/x86_64/system/../../minilib/printf.c:45:(.text+0xec):
> undefined reference to `__stack_chk_fail'
> /usr/bin/ld: /tmp/ccRh6mPz.o: in function `ml_printf':
> qemu/src/tests/tcg/x86_64/system/../../minilib/printf.c:136:
> (.text+0x549): undefined reference to `__stack_chk_fail'
> collect2: error: ld returned 1 exit status
> ninja: build stopped: subcommand failed.
> make: *** [Makefile:170: run-ninja] Error 1
> 
> Reverting this patch I'm able to run `make check` successfully again.
> Any idea what might be causing this?
>

Thanks for the report.
Tests were previously compiled with -fno-stack-protector, and it was
unclear which distro/setup required this, so we removed it to find what
requires it. It seems like archlinux is one of them.

I'll re-add the flag by default.

Can you please confirm the command above (x86_64-linux-gcc ...) works
with -fno-stack-protector added?

> Best regards,
> 
> Bernhard
> 

Regards,
Pierrick

