Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3CCC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlrf4-0002fG-AC; Mon, 20 Jul 2026 13:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wlren-0002S6-9e
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:20:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wlreh-00088e-7b
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:19:56 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KH6hIh3299100
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r4NQI6TQcZPRi5uM6p0v3kUtalHt700vAemQ9ixOK/Q=; b=MGkjN2+P/+jsaFoS
 kRtUOS5VJ5YNPxm5aixSlcYe3J9EDfDOEbtGDg3bRtX+G7NT1kLMSjMOrpGzamHz
 Mqb1tpO573RrF5XCcg9RKGWHO/4fhrn6ORMHLuYA+ojge/O+DFDU9iKb3gJJBlm4
 ky51C9M7vJep6FlhgBKKGMhytMW+vAfeFYeGG8xgW2F1JpylyXr20RWd6qcZrZ4p
 QXbx0HroUvzzbQW1UsEVRuGk0lXKLTTTyHflGl0h8qU/c6OksoNxXl6NnRh2cX6R
 vXWuLXHv3wg1ymS+NFB8PMoZJU2KLVXFK712pEVqRkEYZRqm/maXBZBu0mWxH4J2
 DMv9zg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfvxjh0n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:19:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e632390d2so1371139085a.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784567987; x=1785172787; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=r4NQI6TQcZPRi5uM6p0v3kUtalHt700vAemQ9ixOK/Q=;
 b=SG1/uY5UnRdz4XiZxkyR0De0+Y8xl4DK/jFj54+LkV+Rk+1MKh0im85kshpdCvIPjq
 cJo0SYvrXiuQro20OfxJVJ4Olz9bjpgBtdqd26TbL6IvszR3QdVHYg3f58nWzeX+p16+
 AkOczFrX96rHvTEZoeG49qMoGDc0rVvjm2PtOLOjWq8iUQz6FZDwpL2hLs6nEjZEaLqj
 3KbAB50fu7XZ0me7usBbDvSctR8U61d2rhdHMi/jHl8kRTvTNKxNeZFKTfb+s+Vg3J7f
 B8svMo63zxZViWR/nl4Jr/szVXONPpy9kIgsBqXfKDdRpzQ8nidwKunJPtDnRSUYeXqW
 FZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784567987; x=1785172787;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r4NQI6TQcZPRi5uM6p0v3kUtalHt700vAemQ9ixOK/Q=;
 b=h6K37dKnDDc+5ZNtZ55xdMZCd89KJqcOO30GWJGz/2DiAy30psZgjktnlXEfAYRLc3
 Qhn5UAPnclpuCVb2PDgJ+stZYqbCGH3nHuzWgxnBNlKBSCK0JYzyGSAua4NeHGfRtsVF
 ru3D6bZih26y9MNbnXnm6n4OoFELUwalPjIwCu+eO7mwQQTuzrIKPVq+dVpCPIhgf9V0
 GOcJ0csp82qK2oDfRip0kKFftl1svmC7J9R88jhU6zAZmLaLzhU0jN2mCp2bTA0+Jlom
 11jl+Z8sQKq8/k57lZqlFEb9Dnl3a72cXphO7at430gIIVpJ/6K82UG2+W7E9OBlYsF5
 1Eew==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8NWvU3DeryBw1SXmIQisbbdLKmFok4wI/EM1Pwfr8PjzqAQLf2zPrpbbLNXMIiyYsBAJqcZPA0XfZ@nongnu.org
X-Gm-Message-State: AOJu0YwG4s8SSkW0lIwzuStp2gjssy0ORQvjPL2Sc6kdTc+B7NS+vimk
 RNsoYj/xF8Tj2hhUxIe8htYAf6PZTt/xb/Xsv4P153QVHXdIJl2xEymNFo3GZhepVaDHBNyq4V2
 X2u6GRgiuh9QdSWaZu/mfICpfrmFDs3RJD1mdBz9WSFEIthTX0UkEbAEixQ==
X-Gm-Gg: AfdE7clQBIj+chHyiG3k6DWHxXUdvzO5b9lRaqKhnVqf7um1v02J3RsvQdqfZtbdtK/
 oZ2kGPLnIKaRTtwN4stwI1dsTvugEsIx2vDTnA+FexI7c4bzi3r/SqBgJsgXoHe6dVfUuFhLMbZ
 2hqeteWhggy4TlEHpj7fYlhsXc55jKWYdIatHGFCBUAoaceP3pQaWNSkDvDKx4HVrFIl97IuxBc
 tGVcqY1wXs3si3e6etbFvp74mT4ZgxmXCz//xWnkuyPLslFx1ZoI5G9p9FO94gYHI5Uppddh4/p
 pvJh91Hg8+pzM/e8z9EWGwPmnCAWZY0cyRIbHGZt/E1ymUbIOPC1NoQpUziJo0RAUWHKtt0IHip
 VBF1zbVUwllLgu8mXFxCECP1uYy35fVBXzvrC9kw47NHjBDH/uKExqADff7P9Fm/D
X-Received: by 2002:a05:620a:225a:20b0:92f:279:f8ec with SMTP id
 af79cd13be357-930b41f9ac9mr1062312385a.74.1784567986455; 
 Mon, 20 Jul 2026 10:19:46 -0700 (PDT)
X-Received: by 2002:a05:620a:225a:20b0:92f:279:f8ec with SMTP id
 af79cd13be357-930b41f9ac9mr1062308985a.74.1784567985810; 
 Mon, 20 Jul 2026 10:19:45 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b545f522sm908841585a.37.2026.07.20.10.19.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 10:19:45 -0700 (PDT)
Message-ID: <f7074be1-d583-4d2b-b94d-c79101938241@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 12:19:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] hw/intc: Add l2vic interrupt controller
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 peter.maydell@linaro.org, matheus.bernardino@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, Thomas Huth <th.huth+qemu@posteo.eu>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Sid Manning <sidneym@quicinc.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Damien Hedde <damien.hedde@dahe.fr>
References: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
 <20260715185701.1287176-5-brian.cain@oss.qualcomm.com>
 <96126288-c9aa-4033-84d3-8c0c00c8f79e@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <96126288-c9aa-4033-84d3-8c0c00c8f79e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HKLz0Itv c=1 sm=1 tr=0 ts=6a5e58b4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=vrXBTq6jHGI868DgVSUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MiBTYWx0ZWRfX1Jy2/ya3iLEe
 Sk3EOPKOZ8/cTmVJG7n+QgZJW0Yo92i0V86l0KT5PE1UP+7SPgvraA1JMXClzZMaunnGkJVdQ4V
 mJ1xqCVbQLyG011Eegbj813VzabU8uI=
X-Proofpoint-GUID: AtmlUYL3d-bFMQdAreNv1S6snIxMjh7N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MiBTYWx0ZWRfXyu9jHyExDmiw
 NTkxe2nWHF0rmQbJJ9njF03R8+tHvKkI7/cL71UZnWc3JX6L8xqshDVkH9tBeKoGon+X1xzWq0m
 Iug1PowshroYqbTYqfBM5pOgiikq0+8nuCIb5C9QvwDw6pgvfomEA1Ez3Mb6kSOdpNpWTssLIva
 WkHlUIDuowsYEwtTmbn152kbhIsRktAY/Kp86UHDewk3MhjVWtJjFzrsiFzmfV/S7zI6lnFoELF
 YWNNO8x2uKJDMJBphhmzwvhS2GJ+AVFEakovqBchZ1J0+VbH5kQEOne6hPjnEnxjIXcW/KKBLAA
 /YSApE0s5nWnmFe6M6Wo/OwolJZJZs7hQ5Pspcpqd6l0WBZALLlH2Kw+yFVkWM1eHDsgDYDSCjn
 GEDp/hNlcJnD4307I+82BaZ8T39aOxH6aAvpXuLYOle8JEVbZCN+YHuyK9nfynEAczNnLlxMKxD
 8bK5EvId3raVXazg1Pw==
X-Proofpoint-ORIG-GUID: AtmlUYL3d-bFMQdAreNv1S6snIxMjh7N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200192
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 7/20/2026 9:25 AM, Philippe Mathieu-Daudé wrote:
> Hi Brian,
>
> +Peter for commit 3d7680fb18c ("bitops.h: Define bit operations
> on 'uint32_t' arrays").
>
> On 15/7/26 20:56, Brian Cain wrote:
>> From: Sid Manning <sidneym@quicinc.com>
>>
>> The Hexagon DSP requires an L2VIC to route up to 1024
>> external interrupt sources through 4 VID output groups into
>> the core's 8 interrupt inputs.  This device model implements
>> the register interface, interrupt steering, and edge/level
>> type handling needed by the sysemu machine models.
>>
>> Co-authored-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
>> Co-authored-by: Damien Hedde <damien.hedde@dahe.fr>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                    |   3 +
>>   docs/devel/hexagon-l2vic.rst   |  55 ++++
>>   docs/devel/index-internals.rst |   1 +
>>   include/hw/intc/hex-l2vic.h    |  87 ++++++
>>   target/hexagon/cpu.h           |   2 +
>>   hw/intc/hex-l2vic.c            | 532 +++++++++++++++++++++++++++++++++
>>   target/hexagon/cpu.c           |   2 +
>>   target/hexagon/op_helper.c     |  21 +-
>>   hw/hexagon/Kconfig             |   1 +
>>   hw/intc/Kconfig                |   3 +
>>   hw/intc/meson.build            |   2 +
>>   hw/intc/trace-events           |   4 +
>>   12 files changed, 712 insertions(+), 1 deletion(-)
>>   create mode 100644 docs/devel/hexagon-l2vic.rst
>>   create mode 100644 include/hw/intc/hex-l2vic.h
>>   create mode 100644 hw/intc/hex-l2vic.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ecb8cfdc41e..7281a281632 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -250,6 +250,8 @@ M: Brian Cain <brian.cain@oss.qualcomm.com>
>>   R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>   S: Supported
>>   F: target/hexagon/
>> +F: hw/intc/hex-l2vic.c
>> +F: include/hw/intc/hex-l2vic.h
>>   X: target/hexagon/idef-parser/
>>   X: target/hexagon/gen_idef_parser_funcs.py
>>   F: linux-user/hexagon/
>> @@ -262,6 +264,7 @@ F: gdbstub/gdb-xml/hexagon*.xml
>>   F: docs/system/target-hexagon.rst
>>   F: docs/system/hexagon/
>>   F: docs/devel/hexagon-sys.rst
>> +F: docs/devel/hexagon-l2vic.rst
>>   T: git https://github.com/qualcomm/qemu.git hex-next
>>     Hexagon idef-parser
>> diff --git a/docs/devel/hexagon-l2vic.rst b/docs/devel/hexagon-l2vic.rst
>> new file mode 100644
>> index 00000000000..9cb2a86871e
>> --- /dev/null
>> +++ b/docs/devel/hexagon-l2vic.rst
>> @@ -0,0 +1,55 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +Hexagon L2 Vectored Interrupt Controller
>> +========================================
>> +
>> +
>> +.. code-block:: none
>> +
>> +                +-------------+ +----------------------+
>> +                |    l2vic    |                  |     hexagon 
>> core     |
>> +                |             | |                      |
>> +    IRQ in ---->|             | |                      |
>> +    IRQ in ---->|    VID0    -|----------------->| 
>> irq2                 |
>> +      ...  ---->|             |                  | |                  |
>> +    IRQ in ---->|             |                  | v                  |
>> +                |     ...     |                  | <int 
>> steering>       |
>> +                |             |                  |  /   | |    \     |
>> +    IRQ in ---->|             |                  | t0   t1 t2   t3 ...|
>> +    IRQ in ---->|    VIDN    -| |                      |
>> +      ...  ---->|             | |                      |
>> +    IRQ in ---->|             |                  | Global SREG 
>> File     |
>> +                |             | |                      |
>> +                |    State    | |                      |
>> +                | [      ] <--|==================|==> [ VID  
>> ]          |
>> +                | [      ] <--|==================|==> [ VID1 
>> ]          |
>> +                |             | |                      |
>> +                +-------------+ +----------------------+
>> +
>> +L2VIC/Core Integration
>> +----------------------
>> +
>> +* hexagon core supports 8 external interrupt sources
>> +* l2vic supports 1024 input interrupts mapped among 4 output interrupts
>> +* l2vic has four output signals: { VID0, VID1, VID2, VID3 }
>> +* l2vic device has a bank of registers per-VID that can be used to 
>> query
>> +  the status or assert new interrupts.
>> +* Interrupts are 'steered' to threads based on { thread priority, 
>> 'EX' state,
>> +  thread interrupt mask, thread interrupt enable, global interrupt 
>> enable,
>> +  etc. }.
>> +* Any hardware thread could conceivably handle any input interrupt, 
>> dependent
>> +  on state.
>> +* The system register transfer instruction can read the VID0-VID3 
>> values from
>> +  the l2vic when reading from hexagon core system registers "VID" 
>> and "VID1".
>> +* When l2vic VID0 has multiple active interrupts, it pulses the VID0 
>> output
>> +  IRQ and stores the IRQ number for the VID0 register field. Only 
>> after this
>> +  interrupt is cleared can the l2vic pulse the VID0 output IRQ again 
>> and provide
>> +  the next interrupt number on the VID0 register.
>> +* The ``ciad`` instruction clears the l2vic input interrupt and 
>> un-disables the
>> +  core interrupt.  If some/an l2vic VID0 interrupt is pending when 
>> this occurs,
>> +  the next interrupt should fire and any subsequent reads of the VID 
>> register
>> +  should reflect the newly raised interrupt.
>> +* In QEMU, on an external interrupt or an unmasked-pending interrupt,
>> +  all vCPUs are triggered (has_work==true) and each will grab the IO 
>> lock
>> +  while considering the steering logic to determine whether they're 
>> the thread
>> +  that must handle the interrupt.
>> diff --git a/docs/devel/index-internals.rst 
>> b/docs/devel/index-internals.rst
>> index b89bab9b306..84985973490 100644
>> --- a/docs/devel/index-internals.rst
>> +++ b/docs/devel/index-internals.rst
>> @@ -15,6 +15,7 @@ Details about QEMU's various subsystems including 
>> how to add features to them.
>>      clocks
>>      ebpf_rss
>>      hexagon-sys
>> +   hexagon-l2vic
>>      migration/index
>>      multi-process
>>      reset
>> diff --git a/include/hw/intc/hex-l2vic.h b/include/hw/intc/hex-l2vic.h
>> new file mode 100644
>> index 00000000000..f6519bcd6c2
>> --- /dev/null
>> +++ b/include/hw/intc/hex-l2vic.h
>> @@ -0,0 +1,87 @@
>> +/*
>> + * QEMU L2VIC Interrupt Controller
>> + *
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_INTC_HEX_L2VIC_H
>> +#define HW_INTC_HEX_L2VIC_H
>> +
>> +#include "qom/object.h"
>> +
>> +#define L2VIC_VID_GRP_0 0x0 /* Read */
>> +#define L2VIC_VID_GRP_1 0x4 /* Read */
>> +#define L2VIC_VID_GRP_2 0x8 /* Read */
>> +#define L2VIC_VID_GRP_3 0xC /* Read */
>> +#define L2VIC_INT_ENABLEn 0x100 /* Read/Write */
>> +#define L2VIC_INT_ENABLE_CLEARn 0x180 /* Write */
>> +#define L2VIC_INT_ENABLE_SETn 0x200 /* Write */
>> +#define L2VIC_INT_TYPEn 0x280 /* Read/Write */
>> +#define L2VIC_INT_STATUSn 0x380 /* Read */
>> +#define L2VIC_INT_CLEARn 0x400 /* Write */
>> +#define L2VIC_SOFT_INTn 0x480 /* Write */
>> +#define L2VIC_INT_PENDINGn 0x500 /* Read */
>> +#define L2VIC_INT_GRPn_0 0x600 /* Read/Write */
>> +#define L2VIC_INT_GRPn_1 0x680 /* Read/Write */
>> +#define L2VIC_INT_GRPn_2 0x700 /* Read/Write */
>> +#define L2VIC_INT_GRPn_3 0x780 /* Read/Write */
>> +
>> +#define L2VIC_INTERRUPT_MAX 1024
>> +/*
>> + * Note about l2vic groups:
>> + * Each interrupt to L2VIC can be configured to associate with one of
>> + * four groups.
>> + * Group 0 interrupts go to IRQ2 via VID 0 (SSR: 0xC2, the default)
>> + * Group 1 interrupts go to IRQ3 via VID 1 (SSR: 0xC3)
>> + * Group 2 interrupts go to IRQ4 via VID 2 (SSR: 0xC4)
>> + * Group 3 interrupts go to IRQ5 via VID 3 (SSR: 0xC5)
>> + */
>> +
>> +#define TYPE_HEX_L2VIC "hex-l2vic"
>> +/*
>> + * L2VIC Interface for CPU/GlobalReg interaction
>> + */
>> +#define TYPE_HEX_L2VIC_INTERFACE "hex-l2vic-if"
>> +
>> +typedef struct HexL2VicInterface HexL2VicInterface;
>> +
>> +typedef struct HexL2VicInterfaceClass {
>> +    InterfaceClass parent_class;
>> +
>> +    /* Read VID register for given group */
>> +    uint32_t (*read_vid)(HexL2VicInterface *l2vic, uint32_t group);
>> +
>> +    /* Update VID register value */
>> +    void (*update_vid)(HexL2VicInterface *l2vic, uint32_t group,
>> +                        uint32_t value);
>> +
>> +    /* Clear interrupt using CIAD instruction */
>> +    void (*clear_interrupt)(HexL2VicInterface *l2vic);
>> +} HexL2VicInterfaceClass;
>> +
>> +DECLARE_OBJ_CHECKERS(HexL2VicInterface, HexL2VicInterfaceClass,
>> +                     HEX_L2VIC_INTERFACE, TYPE_HEX_L2VIC_INTERFACE);
>> +
>> +/* Convenience functions for interface users */
>> +static inline uint32_t l2vic_read_vid(HexL2VicInterface *l2vic,
>> +                                       uint32_t group)
>> +{
>> +    HexL2VicInterfaceClass *k = HEX_L2VIC_INTERFACE_GET_CLASS(l2vic);
>> +    return k->read_vid(l2vic, group);
>> +}
>> +
>> +static inline void l2vic_update_vid(HexL2VicInterface *l2vic, 
>> uint32_t group,
>> +                                     uint32_t value)
>> +{
>> +    HexL2VicInterfaceClass *k = HEX_L2VIC_INTERFACE_GET_CLASS(l2vic);
>> +    k->update_vid(l2vic, group, value);
>> +}
>> +
>> +static inline void l2vic_clear_interrupt(HexL2VicInterface *l2vic)
>> +{
>> +    HexL2VicInterfaceClass *k = HEX_L2VIC_INTERFACE_GET_CLASS(l2vic);
>> +    k->clear_interrupt(l2vic);
>> +}
>> +
>> +#endif /* HW_INTC_HEX_L2VIC_H */
>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
>> index 7694fd91fa8..f6c3c639325 100644
>> --- a/target/hexagon/cpu.h
>> +++ b/target/hexagon/cpu.h
>> @@ -39,6 +39,7 @@ typedef struct HexagonGlobalRegState 
>> HexagonGlobalRegState;
>>   #include "qemu/bitmap.h"
>>     #include "target/hexagon/reg_fields.h"
>> +#include "hw/intc/hex-l2vic.h"
>>     #define NUM_PREGS 4
>>   #define TOTAL_PER_THREAD_REGS 64
>> @@ -198,6 +199,7 @@ struct ArchCPU {
>>       uint32_t boot_addr;
>>       HexagonGlobalRegState *globalregs;
>>       uint32_t htid;
>> +    HexL2VicInterface *l2vic;
>>   #endif
>>   };
>>   diff --git a/hw/intc/hex-l2vic.c b/hw/intc/hex-l2vic.c
>> new file mode 100644
>> index 00000000000..6b2dc6bb091
>> --- /dev/null
>> +++ b/hw/intc/hex-l2vic.c
>> @@ -0,0 +1,532 @@
>> +/*
>> + * QEMU L2VIC Interrupt Controller
>> + *
>> + * Arm PrimeCell PL190 Vector Interrupt Controller was used as a 
>> reference.
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/core/irq.h"
>> +#include "hw/core/sysbus.h"
>> +#include "migration/vmstate.h"
>> +#include "qemu/lockable.h"
>> +#include "qemu/log.h"
>> +#include "qemu/module.h"
>> +#include "qemu/bitmap.h"
>> +#include "qemu/bitops.h"
>> +#include "hw/intc/hex-l2vic.h"
>> +#include "trace.h"
>> +
>> +static void bitmap32_write_word(uint32_t *bitmap, int word_offset, 
>> uint32_t val)
>> +{
>> +    bitmap[word_offset] = val;
>> +}
>> +
>> +static void bitmap32_clear_word(uint32_t *bitmap, int word_offset,
>> +                                uint32_t mask)
>> +{
>> +    bitmap[word_offset] &= ~mask;
>> +}
>> +
>> +static void bitmap32_set_word(uint32_t *bitmap, int word_offset, 
>> uint32_t mask)
>> +{
>> +    bitmap[word_offset] |= mask;
>> +}
>> +
>> +static uint32_t bitmap32_read_word(uint32_t *bitmap, int word_offset)
>> +{
>> +    return bitmap[word_offset];
>> +}
>> +
>> +OBJECT_DECLARE_SIMPLE_TYPE(HexL2VICState, HEX_L2VIC)
>> +
>> +#define SLICE_MAX (L2VIC_INTERRUPT_MAX / 32)
>> +#define L2VIC_REG_RANGE_SIZE 0x80
>> +
>> +typedef struct HexL2VICState {
>> +    SysBusDevice parent_obj;
>> +
>> +    QemuMutex active;
>
> Can you describe what is protected by this mutex?
>
>> +    MemoryRegion iomem;
>> +    MemoryRegion fast_iomem;
>> +    /*
>> +     * offset 0:vid group 0 etc, 10 bits in each group
>> +     * are used:
>> +     */
>> +    uint32_t vid_group[4];
>> +    uint32_t vid0;
>> +    /* Enable interrupt source */
>> +    DECLARE_BITMAP32(int_enable, L2VIC_INTERRUPT_MAX) QEMU_ALIGNED(16);
>
> This bitmap alignment here is dubious. I suppose it relates to my other
> comment on find_first_bit32(). If the callee requires alignment, then
> the QEMU_ALIGNED() attribute should be used at the definition IMO, not
> here. Peter, WDYT?


You are correct: QEMU_ALIGNED does not belong here.  In prior reviews, 
it was suggested that we use bitmaps and other QEMU idioms.  And in 
making that change we no longer require the alignment because we no 
longer do direct pointer derefs within these.


I will drop the alignment.


>
>> +    /* Present for debugging, not used */
>> +    DECLARE_BITMAP32(int_pending, L2VIC_INTERRUPT_MAX) 
>> QEMU_ALIGNED(16);
>> +    /* Which enabled interrupt is active */
>> +    DECLARE_BITMAP32(int_status, L2VIC_INTERRUPT_MAX) QEMU_ALIGNED(16);
>
> Apparently int_status is mutex-protected.
>
>> +    /* Edge or Level interrupt */
>> +    DECLARE_BITMAP32(int_type, L2VIC_INTERRUPT_MAX) QEMU_ALIGNED(16);
>> +    /* L2 interrupt group 0-3 0x600-0x7FF */
>> +    DECLARE_BITMAP32(int_group_n0, L2VIC_INTERRUPT_MAX) 
>> QEMU_ALIGNED(16);
>> +    DECLARE_BITMAP32(int_group_n1, L2VIC_INTERRUPT_MAX) 
>> QEMU_ALIGNED(16);
>> +    DECLARE_BITMAP32(int_group_n2, L2VIC_INTERRUPT_MAX) 
>> QEMU_ALIGNED(16);
>> +    DECLARE_BITMAP32(int_group_n3, L2VIC_INTERRUPT_MAX) 
>> QEMU_ALIGNED(16);
>> +    qemu_irq irq[8];
>> +} HexL2VICState;
>> +
>> +typedef enum {
>> +    L2VIC_OP_WRITE,
>> +    L2VIC_OP_CLEAR,
>> +    L2VIC_OP_SET,
>> +} L2VicWriteOp;
>> +
>> +typedef struct {
>> +    hwaddr base;
>> +    size_t state_offset;
>> +    L2VicWriteOp write_op;
>> +    bool write_only;
>> +} L2VicRegRange;
>> +
>> +static const L2VicRegRange l2vic_reg_ranges[] = {
>> +    { L2VIC_INT_ENABLEn, offsetof(HexL2VICState, int_enable),
>> +      L2VIC_OP_WRITE, false },
>> +    { L2VIC_INT_ENABLE_CLEARn, offsetof(HexL2VICState, int_enable),
>> +      L2VIC_OP_CLEAR, true },
>> +    { L2VIC_INT_ENABLE_SETn, offsetof(HexL2VICState, int_enable),
>> +      L2VIC_OP_SET, true },
>> +    { L2VIC_INT_TYPEn, offsetof(HexL2VICState, int_type),
>> +      L2VIC_OP_WRITE, false },
>> +    { L2VIC_INT_STATUSn, offsetof(HexL2VICState, int_status),
>> +      L2VIC_OP_WRITE, false },
>> +    { L2VIC_INT_CLEARn, offsetof(HexL2VICState, int_status),
>> +      L2VIC_OP_CLEAR, true },
>> +    { L2VIC_SOFT_INTn, offsetof(HexL2VICState, int_enable),
>> +      L2VIC_OP_SET, true },
>> +    { L2VIC_INT_PENDINGn, offsetof(HexL2VICState, int_pending),
>> +      L2VIC_OP_WRITE, false },
>> +    { L2VIC_INT_GRPn_0, offsetof(HexL2VICState, int_group_n0),
>> +      L2VIC_OP_WRITE, false },
>> +    { L2VIC_INT_GRPn_1, offsetof(HexL2VICState, int_group_n1),
>> +      L2VIC_OP_WRITE, false },
>> +    { L2VIC_INT_GRPn_2, offsetof(HexL2VICState, int_group_n2),
>> +      L2VIC_OP_WRITE, false },
>> +    { L2VIC_INT_GRPn_3, offsetof(HexL2VICState, int_group_n3),
>> +      L2VIC_OP_WRITE, false },
>> +};
>> +
>> +static uint32_t *l2vic_state_bitmap(HexL2VICState *s, size_t 
>> state_offset)
>> +{
>> +    return (uint32_t *)((char *)s + state_offset);
>> +}
>> +
>> +static bool l2vic_reg_read_range(HexL2VICState *s, hwaddr offset,
>> +                                 uint64_t *value)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(l2vic_reg_ranges); i++) {
>> +        const L2VicRegRange *r = &l2vic_reg_ranges[i];
>> +
>> +        if (offset >= r->base &&
>> +            offset < r->base + L2VIC_REG_RANGE_SIZE) {
>> +            if (r->write_only) {
>> +                *value = 0;
>> +            } else {
>> +                uint32_t *bitmap = l2vic_state_bitmap(s, 
>> r->state_offset);
>> +                *value = bitmap32_read_word(bitmap,
>> +                                            (offset - r->base) >> 2);
>> +            }
>> +            return true;
>> +        }
>> +    }
>> +    return false;
>> +}
>> +
>> +static bool l2vic_reg_write_range(HexL2VICState *s, hwaddr offset,
>> +                                  uint32_t val)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(l2vic_reg_ranges); i++) {
>> +        const L2VicRegRange *r = &l2vic_reg_ranges[i];
>> +
>> +        if (offset >= r->base &&
>> +            offset < r->base + L2VIC_REG_RANGE_SIZE) {
>> +            uint32_t *bitmap = l2vic_state_bitmap(s, r->state_offset);
>> +            int word = (offset - r->base) >> 2;
>> +
>> +            switch (r->write_op) {
>> +            case L2VIC_OP_WRITE:
>> +                bitmap32_write_word(bitmap, word, val);
>> +                break;
>> +            case L2VIC_OP_CLEAR:
>> +                bitmap32_clear_word(bitmap, word, val);
>> +                break;
>> +            case L2VIC_OP_SET:
>> +                bitmap32_set_word(bitmap, word, val);
>> +                break;
>> +            default:
>> +                g_assert_not_reached();
>> +            }
>> +            return true;
>> +        }
>> +    }
>> +    return false;
>> +}
>> +
>> +/*
>> + * Find out if this irq is associated with a group other than
>> + * the default group
>> + */
>> +static uint32_t *get_int_group(HexL2VICState *s, int irq)
>> +{
>> +    int n = irq & 0x1f;
>> +    if (n < 8) {
>> +        return s->int_group_n0;
>> +    }
>> +    if (n < 16) {
>> +        return s->int_group_n1;
>> +    }
>> +    if (n < 24) {
>> +        return s->int_group_n2;
>> +    }
>> +    return s->int_group_n3;
>> +}
>> +
>> +static int find_slice(int irq)
>> +{
>> +    return irq / 32;
>> +}
>> +
>> +static int get_vid(HexL2VICState *s, int irq)
>> +{
>> +    uint32_t *group = get_int_group(s, irq);
>> +    uint32_t slice = group[find_slice(irq)];
>> +    /* Mask with 0x7 to remove the GRP:EN bit */
>> +    uint32_t val = slice >> ((irq & 0x7) * 4);
>> +    if (val & 0x8) {
>> +        return val & 0x7;
>> +    } else {
>> +        return 0;
>> +    }
>> +}
>> +
>> +static inline bool vid_active(HexL2VICState *s)
>> +{
>> +    /* scan all 1024 bits in int_status array */
>> +    const uint32_t size = L2VIC_INTERRUPT_MAX;
>> +    const uint32_t active_irq = find_first_bit32(s->int_status, size);
>
> Is int_status protected here?
>
>> +    return active_irq != size;
>> +}
>> +
>> +static bool l2vic_update(HexL2VICState *s, int irq)
>> +{
>> +    bool pending;
>> +    bool enable;
>> +
>> +    if (vid_active(s)) {
>> +        return true;
>> +    }
>> +
>> +    pending = test_bit32(irq, s->int_pending);
>> +    enable = test_bit32(irq, s->int_enable);
>> +    if (pending && enable) {
>> +        int vid = get_vid(s, irq);
>> +        set_bit32(irq, s->int_status);
>
> Is int_status protected here? Do we want to use the
> set_bit32_atomic() alternative?
>
>> +        clear_bit32(irq, s->int_pending);
>> +        /*
>> +         * Only auto-disable for edge-triggered interrupts (type=1).
>> +         * Level-triggered interrupts (type=0, the default) keep their
>> +         * enable bit set across deliveries -- the firmware enables 
>> once
>> +         * and expects the interrupt to remain enabled.
>> +         */
>> +        if (test_bit32(irq, s->int_type)) {
>> +            clear_bit32(irq, s->int_enable);
>> +        }
>> +        s->vid0 = irq;
>> +        s->vid_group[vid] = irq;
>> +
>> +        qemu_irq_pulse(s->irq[vid + 2]);
>> +        trace_hex_l2vic_delivered(irq, vid);
>> +        return true;
>> +    }
>> +    return false;
>> +}
>> +
>> +static void l2vic_update_all(HexL2VICState *s)
>> +{
>> +    for (int i = 0; i < L2VIC_INTERRUPT_MAX; i++) {
>> +        if (l2vic_update(s, i)) {
>> +            /* once vid is active, no-one else can set it until ciad */
>> +            return;
>> +        }
>> +    }
>> +}
>> +
>> +static void l2vic_set_irq(void *opaque, int irq, int level)
>> +{
>> +    HexL2VICState *s = (HexL2VICState *)opaque;
>> +
>> +    QEMU_LOCK_GUARD(&s->active);
>
> Ah, here you protect int_pending, described as "Present for debugging,
> not used".
>
>> +    if (level) {
>> +        set_bit32(irq, s->int_pending);
>> +    }
>> +    l2vic_update(s, irq);
>> +}
>> +
>> +static void l2vic_write(void *opaque, hwaddr offset, uint64_t val,
>> +                        unsigned size)
>> +{
>> +    HexL2VICState *s = (HexL2VICState *)opaque;
>> +
>> +    QEMU_LOCK_GUARD(&s->active);
>
> Here you protect the whole device via MMIO access.
>
>> + trace_hex_l2vic_reg_write((unsigned)offset, (uint32_t)val);
>> +
>> +    if (!l2vic_reg_write_range(s, offset, val)) {
>> +        qemu_log_mask(LOG_UNIMP,
>> +                      "%s: offset 0x%" HWADDR_PRIx " unimplemented\n",
>> +                      __func__, offset);
>> +    }
>> +
>> +    /* SOFT_INT also sets pending for edge-triggered interrupts */
>> +    if (offset >= L2VIC_SOFT_INTn &&
>> +        offset < L2VIC_SOFT_INTn + L2VIC_REG_RANGE_SIZE && val) {
>> +        int irq = ctz32((uint32_t)val);
>> +        irq += ((offset - L2VIC_SOFT_INTn) >> 2) * 32;
>> +
>> +        if (test_bit32(irq, s->int_type)) {
>> +            set_bit32(irq, s->int_pending);
>> +        }
>> +    }
>> +
>> +    l2vic_update_all(s);
>> +}
>> +
>> +static uint64_t l2vic_read(void *opaque, hwaddr offset, unsigned size)
>> +{
>> +    uint64_t value;
>> +    HexL2VICState *s = (HexL2VICState *)opaque;
>> +
>> +    QEMU_LOCK_GUARD(&s->active);
>
> Yet another whole device via MMIO access guard. What are the other
> uses you want to protect?
>
>> +
>> +    if (offset <= L2VIC_VID_GRP_3) {
>> +        value = s->vid_group[offset >> 2];
>> +    } else if (!l2vic_reg_read_range(s, offset, &value)) {
>> +        value = 0;
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "L2VIC: %s: offset 0x%" HWADDR_PRIx "\n", 
>> __func__,
>> +                      offset);
>> +    }
>> +
>> +    trace_hex_l2vic_reg_read((unsigned)offset, (uint32_t)value);
>> +    return value;
>> +}
>> +
>> +static const MemoryRegionOps l2vic_ops = {
>> +    .read = l2vic_read,
>> +    .write = l2vic_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +    .valid.min_access_size = 4,
>> +    .valid.max_access_size = 4,
>> +    .valid.unaligned = false,
>> +};
>> +
>> +#define FASTL2VIC_ENABLE 0x0
>> +#define FASTL2VIC_DISABLE 0x1
>> +#define FASTL2VIC_INT 0x2
>> +
>> +static void fastl2vic_write(void *opaque, hwaddr offset, uint64_t val,
>> +                            unsigned size)
>> +{
>> +    if (offset == 0) {
>> +        uint32_t cmd = (val >> 16) & 0x3;
>> +        uint32_t irq = val & 0x3ff;
>> +        uint32_t slice = (irq / 32) * 4;
>> +        val = 1 << (irq % 32);
>> +
>> +        if (cmd == FASTL2VIC_ENABLE) {
>> +            l2vic_write(opaque, L2VIC_INT_ENABLE_SETn + slice, val, 
>> size);
>> +        } else if (cmd == FASTL2VIC_DISABLE) {
>> +            l2vic_write(opaque, L2VIC_INT_ENABLE_CLEARn + slice, 
>> val, size);
>> +        } else if (cmd == FASTL2VIC_INT) {
>> +            l2vic_write(opaque, L2VIC_SOFT_INTn + slice, val, size);
>> +        } else {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "%s: invalid write cmd %" PRId32 "\n",
>> +                          __func__, cmd);
>> +        }
>> +        return;
>> +    }
>> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid write offset 0x%08" 
>> HWADDR_PRIx
>> +            "\n", __func__, offset);
>> +}
>> +
>> +static const MemoryRegionOps fastl2vic_ops = {
>> +    .write = fastl2vic_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +    .valid.min_access_size = 4,
>> +    .valid.max_access_size = 4,
>> +    .valid.unaligned = false,
>> +};
>> +
>> +/* L2VIC Interface Implementation */
>> +static uint32_t l2vic_interface_read_vid_impl(HexL2VicInterface *iface,
>> +                                               uint32_t group)
>> +{
>> +    HexL2VICState *s = HEX_L2VIC(iface);
>> +    uint32_t result = 0;
>> +
>> +    QEMU_LOCK_GUARD(&s->active);
>
> Ah, another whole device via MMIO access guard.
>
>> +    if (group == 0) {
>> +        /* VID register: VID1 (bits 16-31), VID0 (bits 0-15) */
>> +        result = deposit32(result, 0, 16, s->vid_group[0]);
>> +        result = deposit32(result, 16, 16, s->vid_group[1]);
>> +    } else if (group == 1) {
>> +        /* VID1 register: VID3 (bits 16-31), VID2 (bits 0-15) */
>> +        result = deposit32(result, 0, 16, s->vid_group[2]);
>> +        result = deposit32(result, 16, 16, s->vid_group[3]);
>> +    }
>> +    return result;
>> +}
>> +
>> +static void l2vic_interface_update_vid_impl(HexL2VicInterface *iface,
>> +                                            uint32_t group, uint32_t 
>> value)
>> +{
>> +    HexL2VICState *s = HEX_L2VIC(iface);
>> +
>> +    QEMU_LOCK_GUARD(&s->active);
>> +
>> +    if (group == 0) {
>> +        /* VID register: unpack VID0 and VID1 */
>> +        s->vid_group[0] = extract32(value, 0, 16);
>> +        s->vid_group[1] = extract32(value, 16, 16);
>> +    } else if (group == 1) {
>> +        /* VID1 register: unpack VID2 and VID3 */
>> +        s->vid_group[2] = extract32(value, 0, 16);
>> +        s->vid_group[3] = extract32(value, 16, 16);
>> +    }
>> +
>> +    l2vic_update_all(s);
>> +}
>> +
>> +static void l2vic_interface_clear_interrupt_impl(HexL2VicInterface 
>> *iface)
>> +{
>> +    HexL2VICState *s = HEX_L2VIC(iface);
>> +
>> +    QEMU_LOCK_GUARD(&s->active);
>
> OK, this is apparently a non-MMIO call via the HexL2VicInterfaceClass.
> Is that why we need this mutex? So far I can not see any consumer of
> this interface in this series.

I will clarify the use of this mutex.

>
>> +    if (s->vid0 < L2VIC_INTERRUPT_MAX) {
>> +        clear_bit32(s->vid0, s->int_status);
>> +    }
>> +    l2vic_update_all(s);
>> +}
>> +
>> +static void l2vic_reset_hold(Object *obj, ResetType type G_GNUC_UNUSED)
>> +{
>> +    HexL2VICState *s = HEX_L2VIC(obj);
>> +
>> +    QEMU_LOCK_GUARD(&s->active);
>> +    memset(s->int_enable, 0, sizeof(s->int_enable));
>> +    memset(s->int_pending, 0, sizeof(s->int_pending));
>> +    memset(s->int_status, 0, sizeof(s->int_status));
>> +    memset(s->int_type, 0, sizeof(s->int_type));
>> +    memset(s->int_group_n0, 0, sizeof(s->int_group_n0));
>> +    memset(s->int_group_n1, 0, sizeof(s->int_group_n1));
>> +    memset(s->int_group_n2, 0, sizeof(s->int_group_n2));
>> +    memset(s->int_group_n3, 0, sizeof(s->int_group_n3));
>> +    memset(s->vid_group, 0, sizeof(s->vid_group));
>> +    s->vid0 = 0;
>> +
>> +    l2vic_update_all(s);
>> +}
>> +
>> +static void reset_irq_handler(void *opaque, int irq, int level)
>> +{
>> +    Object *obj = OBJECT(opaque);
>> +
>> +    if (level) {
>> +        l2vic_reset_hold(obj, RESET_TYPE_COLD);
>> +    }
>> +}
>> +
>> +static void l2vic_init(Object *obj)
>> +{
>> +    DeviceState *dev = DEVICE(obj);
>> +    HexL2VICState *s = HEX_L2VIC(obj);
>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>> +    int i;
>> +
>> +    memory_region_init_io(&s->iomem, obj, &l2vic_ops, s, "l2vic", 
>> 0x1000);
>> +    sysbus_init_mmio(sbd, &s->iomem);
>> +    memory_region_init_io(&s->fast_iomem, obj, &fastl2vic_ops, s, 
>> "fast",
>> +                          0x10000);
>> +    sysbus_init_mmio(sbd, &s->fast_iomem);
>> +
>> +    qdev_init_gpio_in(dev, l2vic_set_irq, L2VIC_INTERRUPT_MAX);
>> +    qdev_init_gpio_in_named(dev, reset_irq_handler, "reset", 1);
>> +    for (i = 0; i < 8; i++) {
>> +        sysbus_init_irq(sbd, &s->irq[i]);
>> +    }
>> +    qemu_mutex_init(&s->active);
>> +}
>> +
>> +static const VMStateDescription vmstate_l2vic = {
>> +    .name = "l2vic",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields =
>> +        (VMStateField[]){
>> +            VMSTATE_UINT32_ARRAY(vid_group, HexL2VICState, 4),
>> +            VMSTATE_UINT32(vid0, HexL2VICState),
>> +            VMSTATE_UINT32_ARRAY(int_enable, HexL2VICState, SLICE_MAX),
>> +            VMSTATE_UINT32_ARRAY(int_type, HexL2VICState, SLICE_MAX),
>> +            VMSTATE_UINT32_ARRAY(int_status, HexL2VICState, SLICE_MAX),
>> +            VMSTATE_UINT32_ARRAY(int_pending, HexL2VICState, 
>> SLICE_MAX),
>> +            VMSTATE_UINT32_ARRAY(int_group_n0, HexL2VICState, 
>> SLICE_MAX),
>> +            VMSTATE_UINT32_ARRAY(int_group_n1, HexL2VICState, 
>> SLICE_MAX),
>> +            VMSTATE_UINT32_ARRAY(int_group_n2, HexL2VICState, 
>> SLICE_MAX),
>> +            VMSTATE_UINT32_ARRAY(int_group_n3, HexL2VICState, 
>> SLICE_MAX),
>> +            VMSTATE_END_OF_LIST() }
>> +};
>> +
>> +static void l2vic_interface_class_init(ObjectClass *klass, const 
>> void *data)
>> +{
>> +    HexL2VicInterfaceClass *k = HEX_L2VIC_INTERFACE_CLASS(klass);
>> +
>> +    k->read_vid = l2vic_interface_read_vid_impl;
>> +    k->update_vid = l2vic_interface_update_vid_impl;
>> +    k->clear_interrupt = l2vic_interface_clear_interrupt_impl;
>> +}
>> +
>> +static void l2vic_class_init(ObjectClass *klass, const void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>> +
>> +    dc->vmsd = &vmstate_l2vic;
>> +    rc->phases.hold = l2vic_reset_hold;
>> +}
>> +
>> +static const TypeInfo l2vic_interface_info = {
>> +    .name = TYPE_HEX_L2VIC_INTERFACE,
>> +    .parent = TYPE_INTERFACE,
>> +    .class_size = sizeof(HexL2VicInterfaceClass),
>> +    .class_init = l2vic_interface_class_init,
>> +};
>> +
>> +static const TypeInfo l2vic_info = {
>> +    .name = TYPE_HEX_L2VIC,
>> +    .parent = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(HexL2VICState),
>> +    .instance_init = l2vic_init,
>> +    .class_init = l2vic_class_init,
>> +    .interfaces = (InterfaceInfo[]) {
>> +        { TYPE_HEX_L2VIC_INTERFACE },
>> +        { }
>> +    },
>> +};
>> +
>> +static void l2vic_register_types(void)
>> +{
>> +    type_register_static(&l2vic_interface_info);
>> +    type_register_static(&l2vic_info);
>> +}
>> +
>> +type_init(l2vic_register_types)
>
> Prefer DEFINE_TYPES() for multiple TypeInfo.


I will make that change.


