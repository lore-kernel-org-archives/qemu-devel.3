Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32874C4450C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 01:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjoRQ-0008Di-1R; Tue, 14 Jul 2026 21:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjoRO-0008DR-Gg
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 21:29:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjoRK-0002Ut-GN
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 21:29:38 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66F0I1wV2222681
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 01:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /UATpcHHr3tX1YCpt4cMOQLG9NEnRQFCJ91E3VwBtlA=; b=KtzscQX2Mcmyf0TN
 2GZzMLLhdTZBSu3e6UypDKRP/Is+b+wr+tJVxyeV8A5kVer1Lfy+BILpsh5Jb5nW
 0V3AXyICmlkzScN3AZpPOGTJpf6RG6/VxahsIkJhj4OEzdkqDb6fOUIk9fQOvFKG
 q1O/rehkWzmnWt3/dwmGc5evQ3AQVGXCpl4L602iAYT8/XbdnRwR+ohxufSYZPPI
 /fgdZ3rs4TkC2Ia6jseOnD4eDxqY0jxDDcXA6ZtcZk2bAlwxkkUXQXrgpnaloTxp
 y6CJDOkqPaKOBv4NOVAn0l/1FyHitnRovY8oWZoNgRrRNO+dTz5Cc8DZXI/F9jw0
 XpaqKQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnutf2p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 01:29:31 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88aab7c1fcso11656929a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 18:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784078970; x=1784683770; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/UATpcHHr3tX1YCpt4cMOQLG9NEnRQFCJ91E3VwBtlA=;
 b=G1y7dCStx7O40POo80MEk/Wa4FhEnrVDIwHs8EHc+85+yyB+SdN4X/7bOrRlj004g+
 ONjnYyxQsaHt7Zc2obgfuEqToo5t6+F0TQiMtbr00GlcVCoBhzsy4FJm0jE0eYLE1/+X
 fU2coG+VgQnFUJQUdrcfBoDNquchHMcdFL1J0HEHyupLgCKa3DOBh/e1Jw76+oXy+6oa
 JpHLbHBIuo9lh+qvPE1PWtDjV50LzEzjYIOGZSPlaL/JBQaUFoy9ivTnZ9+tcPaiexwN
 tIoMYIVtVPgWL3EOslVdWWwxhfarVfQfF//J90DKBA3vmy0/TL7ZrdSLolkH2wuNI1q3
 Vgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784078970; x=1784683770;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/UATpcHHr3tX1YCpt4cMOQLG9NEnRQFCJ91E3VwBtlA=;
 b=dtKwwhgmAgOa+2MY1G3WrsPryC/wMgfkT4EiO64vSsWP7s8oYzfGUKJEmd5vtIS3ws
 BlY4FA6Qul6sKwAul/poH0tzr/ozvxVT/g8VdQq7McIz41gEpluKEhN7NlmV2wVGjH1q
 2Poh0KrcWkR00TNWKgk2gN0Lt8Jpx/D7j/dqUiCt7qo5L8K3Y/Nkg/eeu/2+fnjjxtq+
 haD6nfLTcDJTlHBrjEwcZ0zW80Q6iaHDG00ZlxozU4TSU9RrGpuzl1tFxkX9MFNoVyoZ
 +D9lUhGlMzFwTPbDEFxWrG19s5gduk9Q7c/mIUEK3SiV2I4v2mPG0zNrxbWsl7rqAF5/
 GYTQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqX0k1dymZMsvXC19H6dd7mtvoCEYKBRhG5vIXHfQHQNcOjP1nkffgF3hedeT5/zJJBxXat2qM/6Bco@nongnu.org
X-Gm-Message-State: AOJu0YwkszjYV1M80lyiNaOFndwfcOFs+M5eGpTTiVykD41nzWO7npsp
 GwlCjFU7wwdcZ4mG8906rUuoRjbi+gcUKz5EXmERIs2IMUh+9KU1uV8kLoHC8m24uf7ENLU616H
 0cCkrChr9JgWgi3OsyZPHlX+CSTRDhTGlQvbbmJw41kEKhhWgrCqIhvGSdA==
X-Gm-Gg: AfdE7clpHnE1J4cHssRsYQi/elyNRHAz2ntFB2gSvdrg572c0m5fBd1z3F3VgygNMPh
 yppYBN2UkgxBLiyEJ7ddJnUzM9Zqvv7frgIcHcguvzTN+PR5SjVZlAyQC5medvAbJWSvmsWkKU3
 jTsgcngg1WdTHqsTeOcsIm6mhxZI3bs+8daM73upeB9Cqm6uJADbFU6bjBVG8uA/VjYoUIeABEn
 jTIP7nJ61PUk66rgGG/cOWpybMPonYF1rrfyx0qUNvOn1GHSPLp39vLziTyFJDwpxv6ndGuU3Zk
 NRh0rUUR9LCGyIlyShOAvTr7QeF+t260uzMJNkTauBFMbn+iOA/XlVNJDnz3QstZU/QMU6JZz3v
 JdtmYEqMOFVKoKFIp76G5gYP92i1jk6CVDeXwzF8ujoz7wKx4LleioKrX6uAW67lv8CofA6bRRQ
 EAu/M=
X-Received: by 2002:a05:6a21:689:b0:3bf:e2f1:1b17 with SMTP id
 adf61e73a8af0-3c35723202fmr5263568637.50.1784078970336; 
 Tue, 14 Jul 2026 18:29:30 -0700 (PDT)
X-Received: by 2002:a05:6a21:689:b0:3bf:e2f1:1b17 with SMTP id
 adf61e73a8af0-3c35723202fmr5263534637.50.1784078969672; 
 Tue, 14 Jul 2026 18:29:29 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d87a2sm76667906c88.13.2026.07.14.18.29.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 18:29:29 -0700 (PDT)
Message-ID: <2cb075cb-8bbb-44b7-9486-9fc1a7a36ccc@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 18:29:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] hw/intc: Add l2vic interrupt controller
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 philmd@oss.qualcomm.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Sid Manning <sidneym@quicinc.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Damien Hedde <damien.hedde@dahe.fr>
References: <20260714155126.3509544-1-brian.cain@oss.qualcomm.com>
 <20260714155126.3509544-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260714155126.3509544-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FC1x7cDlK6AnM1GV5dyzuu13noPzlgZL
X-Authority-Analysis: v=2.4 cv=E+v9Y6dl c=1 sm=1 tr=0 ts=6a56e27b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5TlwywzbskBPYgjF-aEA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAxMSBTYWx0ZWRfXxog0qQHfQ2aR
 ISG1SHMJY63ycOGnVe4h+0jI03V5f2JjMPjF/Bgrk11KxrQRvlaDv1ZMLjVLXsZlo9xrR0asx1G
 Q8+k5giTz6OIiVy6+L7WOWwoutizQ2LKV1Ikf6q0I+bZjSOD2Bmvj0I7UO7tjXs5wyPwNG9IiJ8
 GqMwl7GPTwI/2HL0k5fDGmFhFJ175zESqkZv6eMCypp30HQMyyF8qOMjRbgW48Ph2IJdCCNSyF4
 6YhWEo98kjGastIp16BOaoKr0UIZPfXYS8V9EmtsP0iqVgJ7RX5vshT9WmaGqIle/radf5VjTa6
 1SmO2hqLAMiG9oj3/oh/zD/5rwag+UJEt09tTw7lP67pRGwubhpWI7TORx9hM41agVMkXcTfMiy
 Nn4qqfcKhJkqctH+l2juSmzkD0y6T5RmPlShdCkcxM04vpP03b5ESHee7u9QPlcEAh9Xh9m/PXA
 3WkKfX6sqpxGP/1x26w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAxMSBTYWx0ZWRfX7wRC2cGptqBS
 vz24x99OYVLbz6JbfpH69f65FrwtNCnLJwYY3gxHm/wisQkY0P7ueB5tFPeiiU4cIXIgxy9yFfm
 sHo/C0JqVT4avySSt9GQ6YPzx18orZY=
X-Proofpoint-GUID: FC1x7cDlK6AnM1GV5dyzuu13noPzlgZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_01,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150011
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 7/14/2026 8:51 AM, Brian Cain wrote:
> From: Sid Manning <sidneym@quicinc.com>
> 
> The Hexagon DSP requires an L2VIC to route up to 1024
> external interrupt sources through 4 VID output groups into
> the core's 8 interrupt inputs.  This device model implements
> the register interface, interrupt steering, and edge/level
> type handling needed by the sysemu machine models.
> 
> Co-authored-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Co-authored-by: Damien Hedde <damien.hedde@dahe.fr>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS                    |   3 +
>  docs/devel/hexagon-l2vic.rst   |  55 ++++
>  docs/devel/index-internals.rst |   1 +
>  include/hw/intc/hex-l2vic.h    |  87 ++++++
>  target/hexagon/cpu.h           |   2 +
>  hw/intc/hex-l2vic.c            | 511 +++++++++++++++++++++++++++++++++
>  target/hexagon/cpu.c           |   2 +
>  target/hexagon/op_helper.c     |  21 +-
>  hw/hexagon/Kconfig             |   1 +
>  hw/intc/Kconfig                |   3 +
>  hw/intc/meson.build            |   2 +
>  hw/intc/trace-events           |   4 +
>  12 files changed, 691 insertions(+), 1 deletion(-)
>  create mode 100644 docs/devel/hexagon-l2vic.rst
>  create mode 100644 include/hw/intc/hex-l2vic.h
>  create mode 100644 hw/intc/hex-l2vic.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e25df9493c5..1240d180b85 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -250,6 +250,8 @@ M: Brian Cain <brian.cain@oss.qualcomm.com>
>  R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>  S: Supported
>  F: target/hexagon/
> +F: hw/intc/hex-l2vic.c
> +F: include/hw/intc/hex-l2vic.h
>  X: target/hexagon/idef-parser/
>  X: target/hexagon/gen_idef_parser_funcs.py
>  F: linux-user/hexagon/
> @@ -262,6 +264,7 @@ F: gdbstub/gdb-xml/hexagon*.xml
>  F: docs/system/target-hexagon.rst
>  F: docs/system/hexagon/
>  F: docs/devel/hexagon-sys.rst
> +F: docs/devel/hexagon-l2vic.rst
>  T: git https://github.com/qualcomm/qemu.git hex-next
>  
>  Hexagon idef-parser
> diff --git a/docs/devel/hexagon-l2vic.rst b/docs/devel/hexagon-l2vic.rst
> new file mode 100644
> index 00000000000..9cb2a86871e
> --- /dev/null
> +++ b/docs/devel/hexagon-l2vic.rst
> @@ -0,0 +1,55 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Hexagon L2 Vectored Interrupt Controller
> +========================================
> +
> +
> +.. code-block:: none
> +
> +                +-------------+                  +----------------------+
> +                |    l2vic    |                  |     hexagon core     |
> +                |             |                  |                      |
> +    IRQ in ---->|             |                  |                      |
> +    IRQ in ---->|    VID0    -|----------------->| irq2                 |
> +      ...  ---->|             |                  |   |                  |
> +    IRQ in ---->|             |                  |   v                  |
> +                |     ...     |                  | <int steering>       |
> +                |             |                  |  /   |    |    \     |
> +    IRQ in ---->|             |                  | t0   t1   t2   t3 ...|
> +    IRQ in ---->|    VIDN    -|                  |                      |
> +      ...  ---->|             |                  |                      |
> +    IRQ in ---->|             |                  | Global SREG File     |
> +                |             |                  |                      |
> +                |    State    |                  |                      |
> +                | [      ] <--|==================|==> [ VID  ]          |
> +                | [      ] <--|==================|==> [ VID1 ]          |
> +                |             |                  |                      |
> +                +-------------+                  +----------------------+
> +
> +L2VIC/Core Integration
> +----------------------
> +
> +* hexagon core supports 8 external interrupt sources
> +* l2vic supports 1024 input interrupts mapped among 4 output interrupts
> +* l2vic has four output signals: { VID0, VID1, VID2, VID3 }
> +* l2vic device has a bank of registers per-VID that can be used to query
> +  the status or assert new interrupts.
> +* Interrupts are 'steered' to threads based on { thread priority, 'EX' state,
> +  thread interrupt mask, thread interrupt enable, global interrupt enable,
> +  etc. }.
> +* Any hardware thread could conceivably handle any input interrupt, dependent
> +  on state.
> +* The system register transfer instruction can read the VID0-VID3 values from
> +  the l2vic when reading from hexagon core system registers "VID" and "VID1".
> +* When l2vic VID0 has multiple active interrupts, it pulses the VID0 output
> +  IRQ and stores the IRQ number for the VID0 register field.  Only after this
> +  interrupt is cleared can the l2vic pulse the VID0 output IRQ again and provide
> +  the next interrupt number on the VID0 register.
> +* The ``ciad`` instruction clears the l2vic input interrupt and un-disables the
> +  core interrupt.  If some/an l2vic VID0 interrupt is pending when this occurs,
> +  the next interrupt should fire and any subsequent reads of the VID register
> +  should reflect the newly raised interrupt.
> +* In QEMU, on an external interrupt or an unmasked-pending interrupt,
> +  all vCPUs are triggered (has_work==true) and each will grab the IO lock
> +  while considering the steering logic to determine whether they're the thread
> +  that must handle the interrupt.
> diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
> index b89bab9b306..84985973490 100644
> --- a/docs/devel/index-internals.rst
> +++ b/docs/devel/index-internals.rst
> @@ -15,6 +15,7 @@ Details about QEMU's various subsystems including how to add features to them.
>     clocks
>     ebpf_rss
>     hexagon-sys
> +   hexagon-l2vic
>     migration/index
>     multi-process
>     reset
> diff --git a/include/hw/intc/hex-l2vic.h b/include/hw/intc/hex-l2vic.h
> new file mode 100644
> index 00000000000..f6519bcd6c2
> --- /dev/null
> +++ b/include/hw/intc/hex-l2vic.h
> @@ -0,0 +1,87 @@
> +/*
> + * QEMU L2VIC Interrupt Controller
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_INTC_HEX_L2VIC_H
> +#define HW_INTC_HEX_L2VIC_H
> +
> +#include "qom/object.h"
> +
> +#define L2VIC_VID_GRP_0 0x0 /* Read */
> +#define L2VIC_VID_GRP_1 0x4 /* Read */
> +#define L2VIC_VID_GRP_2 0x8 /* Read */
> +#define L2VIC_VID_GRP_3 0xC /* Read */
> +#define L2VIC_INT_ENABLEn 0x100 /* Read/Write */
> +#define L2VIC_INT_ENABLE_CLEARn 0x180 /* Write */
> +#define L2VIC_INT_ENABLE_SETn 0x200 /* Write */
> +#define L2VIC_INT_TYPEn 0x280 /* Read/Write */
> +#define L2VIC_INT_STATUSn 0x380 /* Read */
> +#define L2VIC_INT_CLEARn 0x400 /* Write */
> +#define L2VIC_SOFT_INTn 0x480 /* Write */
> +#define L2VIC_INT_PENDINGn 0x500 /* Read */
> +#define L2VIC_INT_GRPn_0 0x600 /* Read/Write */
> +#define L2VIC_INT_GRPn_1 0x680 /* Read/Write */
> +#define L2VIC_INT_GRPn_2 0x700 /* Read/Write */
> +#define L2VIC_INT_GRPn_3 0x780 /* Read/Write */
> +
> +#define L2VIC_INTERRUPT_MAX 1024
> +/*
> + * Note about l2vic groups:
> + * Each interrupt to L2VIC can be configured to associate with one of
> + * four groups.
> + * Group 0 interrupts go to IRQ2 via VID 0 (SSR: 0xC2, the default)
> + * Group 1 interrupts go to IRQ3 via VID 1 (SSR: 0xC3)
> + * Group 2 interrupts go to IRQ4 via VID 2 (SSR: 0xC4)
> + * Group 3 interrupts go to IRQ5 via VID 3 (SSR: 0xC5)
> + */
> +
> +#define TYPE_HEX_L2VIC "hex-l2vic"
> +/*
> + * L2VIC Interface for CPU/GlobalReg interaction
> + */
> +#define TYPE_HEX_L2VIC_INTERFACE "hex-l2vic-if"
> +
> +typedef struct HexL2VicInterface HexL2VicInterface;
> +
> +typedef struct HexL2VicInterfaceClass {
> +    InterfaceClass parent_class;
> +
> +    /* Read VID register for given group */
> +    uint32_t (*read_vid)(HexL2VicInterface *l2vic, uint32_t group);
> +
> +    /* Update VID register value */
> +    void (*update_vid)(HexL2VicInterface *l2vic, uint32_t group,
> +                        uint32_t value);
> +
> +    /* Clear interrupt using CIAD instruction */
> +    void (*clear_interrupt)(HexL2VicInterface *l2vic);
> +} HexL2VicInterfaceClass;
> +
> +DECLARE_OBJ_CHECKERS(HexL2VicInterface, HexL2VicInterfaceClass,
> +                     HEX_L2VIC_INTERFACE, TYPE_HEX_L2VIC_INTERFACE);
> +
> +/* Convenience functions for interface users */
> +static inline uint32_t l2vic_read_vid(HexL2VicInterface *l2vic,
> +                                       uint32_t group)
> +{
> +    HexL2VicInterfaceClass *k = HEX_L2VIC_INTERFACE_GET_CLASS(l2vic);
> +    return k->read_vid(l2vic, group);
> +}
> +
> +static inline void l2vic_update_vid(HexL2VicInterface *l2vic, uint32_t group,
> +                                     uint32_t value)
> +{
> +    HexL2VicInterfaceClass *k = HEX_L2VIC_INTERFACE_GET_CLASS(l2vic);
> +    k->update_vid(l2vic, group, value);
> +}
> +
> +static inline void l2vic_clear_interrupt(HexL2VicInterface *l2vic)
> +{
> +    HexL2VicInterfaceClass *k = HEX_L2VIC_INTERFACE_GET_CLASS(l2vic);
> +    k->clear_interrupt(l2vic);
> +}
> +
> +#endif /* HW_INTC_HEX_L2VIC_H */
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 7694fd91fa8..f6c3c639325 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -39,6 +39,7 @@ typedef struct HexagonGlobalRegState HexagonGlobalRegState;
>  #include "qemu/bitmap.h"
>  
>  #include "target/hexagon/reg_fields.h"
> +#include "hw/intc/hex-l2vic.h"
>  
>  #define NUM_PREGS 4
>  #define TOTAL_PER_THREAD_REGS 64
> @@ -198,6 +199,7 @@ struct ArchCPU {
>      uint32_t boot_addr;
>      HexagonGlobalRegState *globalregs;
>      uint32_t htid;
> +    HexL2VicInterface *l2vic;
>  #endif
>  };
>  
> diff --git a/hw/intc/hex-l2vic.c b/hw/intc/hex-l2vic.c
> new file mode 100644
> index 00000000000..a284ae8a567
> --- /dev/null
> +++ b/hw/intc/hex-l2vic.c
> @@ -0,0 +1,511 @@
> +/*
> + * QEMU L2VIC Interrupt Controller
> + *
> + * Arm PrimeCell PL190 Vector Interrupt Controller was used as a reference.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/core/irq.h"
> +#include "hw/core/sysbus.h"
> +#include "migration/vmstate.h"
> +#include "qemu/lockable.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/bitmap.h"
> +#include "qemu/bitops.h"
> +#include "hw/intc/hex-l2vic.h"
> +#include "trace.h"
> +
> +static void bitmap32_write_word(uint32_t *bitmap, int word_offset, uint32_t val)
> +{
> +    bitmap[word_offset] = val;
> +}
> +
> +static void bitmap32_clear_word(uint32_t *bitmap, int word_offset,
> +                                uint32_t mask)
> +{
> +    bitmap[word_offset] &= ~mask;
> +}
> +
> +static void bitmap32_set_word(uint32_t *bitmap, int word_offset, uint32_t mask)
> +{
> +    bitmap[word_offset] |= mask;
> +}
> +
> +static uint32_t bitmap32_read_word(uint32_t *bitmap, int word_offset)
> +{
> +    return bitmap[word_offset];
> +}
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(HexL2VICState, HEX_L2VIC)
> +
> +#define SLICE_MAX (L2VIC_INTERRUPT_MAX / 32)
> +
> +typedef struct HexL2VICState {
> +    SysBusDevice parent_obj;
> +
> +    QemuMutex active;
> +    MemoryRegion iomem;
> +    MemoryRegion fast_iomem;
> +    /*
> +     * offset 0:vid group 0 etc, 10 bits in each group
> +     * are used:
> +     */
> +    uint32_t vid_group[4];
> +    uint32_t vid0;
> +    /* Enable interrupt source */
> +    DECLARE_BITMAP32(int_enable, L2VIC_INTERRUPT_MAX) QEMU_ALIGNED(16);
> +    /* Present for debugging, not used */
> +    DECLARE_BITMAP32(int_pending, L2VIC_INTERRUPT_MAX) QEMU_ALIGNED(16);
> +    /* Which enabled interrupt is active */
> +    DECLARE_BITMAP32(int_status, L2VIC_INTERRUPT_MAX) QEMU_ALIGNED(16);
> +    /* Edge or Level interrupt */
> +    DECLARE_BITMAP32(int_type, L2VIC_INTERRUPT_MAX) QEMU_ALIGNED(16);
> +    /* L2 interrupt group 0-3 0x600-0x7FF */
> +    DECLARE_BITMAP32(int_group_n0, L2VIC_INTERRUPT_MAX) QEMU_ALIGNED(16);
> +    DECLARE_BITMAP32(int_group_n1, L2VIC_INTERRUPT_MAX) QEMU_ALIGNED(16);
> +    DECLARE_BITMAP32(int_group_n2, L2VIC_INTERRUPT_MAX) QEMU_ALIGNED(16);
> +    DECLARE_BITMAP32(int_group_n3, L2VIC_INTERRUPT_MAX) QEMU_ALIGNED(16);
> +    qemu_irq irq[8];
> +} HexL2VICState;
> +
> +/*
> + * Find out if this irq is associated with a group other than
> + * the default group
> + */
> +static uint32_t *get_int_group(HexL2VICState *s, int irq)
> +{
> +    int n = irq & 0x1f;
> +    if (n < 8) {
> +        return s->int_group_n0;
> +    }
> +    if (n < 16) {
> +        return s->int_group_n1;
> +    }
> +    if (n < 24) {
> +        return s->int_group_n2;
> +    }
> +    return s->int_group_n3;
> +}
> +
> +static int find_slice(int irq)
> +{
> +    return irq / 32;
> +}
> +
> +static int get_vid(HexL2VICState *s, int irq)
> +{
> +    uint32_t *group = get_int_group(s, irq);
> +    uint32_t slice = group[find_slice(irq)];
> +    /* Mask with 0x7 to remove the GRP:EN bit */
> +    uint32_t val = slice >> ((irq & 0x7) * 4);
> +    if (val & 0x8) {
> +        return val & 0x7;
> +    } else {
> +        return 0;
> +    }
> +}
> +
> +static inline bool vid_active(HexL2VICState *s)
> +{
> +    /* scan all 1024 bits in int_status array */
> +    const uint32_t size = L2VIC_INTERRUPT_MAX;
> +    const uint32_t active_irq = find_first_bit32(s->int_status, size);
> +    return active_irq != size;
> +}
> +
> +static bool l2vic_update(HexL2VICState *s, int irq)
> +{
> +    bool pending;
> +    bool enable;
> +
> +    if (vid_active(s)) {
> +        return true;
> +    }
> +
> +    pending = test_bit32(irq, s->int_pending);
> +    enable = test_bit32(irq, s->int_enable);
> +    if (pending && enable) {
> +        int vid = get_vid(s, irq);
> +        set_bit32(irq, s->int_status);
> +        clear_bit32(irq, s->int_pending);
> +        /*
> +         * Only auto-disable for edge-triggered interrupts (type=1).
> +         * Level-triggered interrupts (type=0, the default) keep their
> +         * enable bit set across deliveries -- the firmware enables once
> +         * and expects the interrupt to remain enabled.
> +         */
> +        if (test_bit32(irq, s->int_type)) {
> +            clear_bit32(irq, s->int_enable);
> +        }
> +        s->vid0 = irq;
> +        s->vid_group[vid] = irq;
> +
> +        qemu_irq_pulse(s->irq[vid + 2]);
> +        trace_hex_l2vic_delivered(irq, vid);
> +        return true;
> +    }
> +    return false;
> +}
> +
> +static void l2vic_update_all(HexL2VICState *s)
> +{
> +    for (int i = 0; i < L2VIC_INTERRUPT_MAX; i++) {
> +        if (l2vic_update(s, i)) {
> +            /* once vid is active, no-one else can set it until ciad */
> +            return;
> +        }
> +    }
> +}
> +
> +static void l2vic_set_irq(void *opaque, int irq, int level)
> +{
> +    HexL2VICState *s = (HexL2VICState *)opaque;
> +
> +    QEMU_LOCK_GUARD(&s->active);
> +    if (level) {
> +        set_bit32(irq, s->int_pending);
> +    }
> +    l2vic_update(s, irq);
> +}
> +
> +static void l2vic_write(void *opaque, hwaddr offset, uint64_t val,
> +                        unsigned size)
> +{
> +    HexL2VICState *s = (HexL2VICState *)opaque;
> +
> +    QEMU_LOCK_GUARD(&s->active);
> +    trace_hex_l2vic_reg_write((unsigned)offset, (uint32_t)val);
> +
> +    if (offset >= L2VIC_INT_ENABLEn &&
> +               offset < (L2VIC_INT_ENABLE_CLEARn)) {
> +        bitmap32_write_word(s->int_enable,
> +            (offset - L2VIC_INT_ENABLEn) >> 2, val);
> +    } else if (offset >= L2VIC_INT_ENABLE_CLEARn &&
> +               offset < L2VIC_INT_ENABLE_SETn) {
> +        bitmap32_clear_word(s->int_enable,
> +            (offset - L2VIC_INT_ENABLE_CLEARn) >> 2, val);
> +    } else if (offset >= L2VIC_INT_ENABLE_SETn && offset < L2VIC_INT_TYPEn) {
> +        bitmap32_set_word(s->int_enable,
> +            (offset - L2VIC_INT_ENABLE_SETn) >> 2, val);
> +    } else if (offset >= L2VIC_INT_TYPEn && offset < L2VIC_INT_TYPEn + 0x80) {
> +        bitmap32_write_word(s->int_type,
> +            (offset - L2VIC_INT_TYPEn) >> 2, val);
> +    } else if (offset >= L2VIC_INT_STATUSn && offset < L2VIC_INT_CLEARn) {
> +        bitmap32_write_word(s->int_status,
> +            (offset - L2VIC_INT_STATUSn) >> 2, val);
> +    } else if (offset >= L2VIC_INT_CLEARn && offset < L2VIC_SOFT_INTn) {
> +        bitmap32_clear_word(s->int_status,
> +            (offset - L2VIC_INT_CLEARn) >> 2, val);
> +    } else if (offset >= L2VIC_INT_PENDINGn &&
> +               offset < L2VIC_INT_PENDINGn + 0x80) {
> +        bitmap32_write_word(s->int_pending,
> +            (offset - L2VIC_INT_PENDINGn) >> 2, val);
> +    } else if (offset >= L2VIC_SOFT_INTn && offset < L2VIC_INT_PENDINGn) {
> +        int irq;
> +        hwaddr byteoffset = offset - L2VIC_SOFT_INTn;
> +
> +        bitmap32_set_word(s->int_enable, (offset - L2VIC_SOFT_INTn) >> 2, val);
> +        if (val) {
> +            irq = ctz32((uint32_t)val);
> +            irq += byteoffset * 8;
> +
> +            if (test_bit32(irq, s->int_type)) {
> +                set_bit32(irq, s->int_pending);
> +            }
> +        }
> +    } else if (offset >= L2VIC_INT_GRPn_0 && offset < L2VIC_INT_GRPn_1) {
> +        bitmap32_write_word(s->int_group_n0,
> +            (offset - L2VIC_INT_GRPn_0) >> 2, val);
> +    } else if (offset >= L2VIC_INT_GRPn_1 && offset < L2VIC_INT_GRPn_2) {
> +        bitmap32_write_word(s->int_group_n1,
> +            (offset - L2VIC_INT_GRPn_1) >> 2, val);
> +    } else if (offset >= L2VIC_INT_GRPn_2 && offset < L2VIC_INT_GRPn_3) {
> +        bitmap32_write_word(s->int_group_n2,
> +            (offset - L2VIC_INT_GRPn_2) >> 2, val);
> +    } else if (offset >= L2VIC_INT_GRPn_3 && offset < L2VIC_INT_GRPn_3 + 0x80) {
> +        bitmap32_write_word(s->int_group_n3,
> +            (offset - L2VIC_INT_GRPn_3) >> 2, val);
> +    } else {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: offset 0x%" HWADDR_PRIx " unimplemented\n",
> +                      __func__, offset);
> +    }

The if cascade is pretty hard to read (same for read function).
Could we solve this with a static const array holding struct with
{offset, size, state_offset_read, state_offset_write, write_only}, and
have a single loop to walk through all the possible subranges?

> +
> +    l2vic_update_all(s);
> +}
> +
> +static uint64_t l2vic_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    uint64_t value;
> +    HexL2VICState *s = (HexL2VICState *)opaque;
> +
> +    QEMU_LOCK_GUARD(&s->active);
> +
> +    if (offset == L2VIC_VID_GRP_0) {
> +        value = s->vid_group[0];
> +    } else if (offset == L2VIC_VID_GRP_1) {
> +        value = s->vid_group[1];
> +    } else if (offset == L2VIC_VID_GRP_2) {
> +        value = s->vid_group[2];
> +    } else if (offset == L2VIC_VID_GRP_3) {
> +        value = s->vid_group[3];
> +    } else if (offset >= L2VIC_INT_ENABLEn &&
> +               offset < L2VIC_INT_ENABLE_CLEARn) {
> +        value = bitmap32_read_word(s->int_enable,
> +            (offset - L2VIC_INT_ENABLEn) >> 2);
> +    } else if (offset >= L2VIC_INT_ENABLE_CLEARn &&
> +               offset < L2VIC_INT_ENABLE_SETn) {
> +        value = 0;
> +    } else if (offset >= L2VIC_INT_ENABLE_SETn && offset < L2VIC_INT_TYPEn) {
> +        value = 0;
> +    } else if (offset >= L2VIC_INT_TYPEn && offset < L2VIC_INT_TYPEn + 0x80) {
> +        value = bitmap32_read_word(s->int_type,
> +            (offset - L2VIC_INT_TYPEn) >> 2);
> +    } else if (offset >= L2VIC_INT_STATUSn && offset < L2VIC_INT_CLEARn) {
> +        value = bitmap32_read_word(s->int_status,
> +            (offset - L2VIC_INT_STATUSn) >> 2);
> +    } else if (offset >= L2VIC_INT_CLEARn && offset < L2VIC_SOFT_INTn) {
> +        /* INT_CLEARn is write-only, return 0 on read */
> +        value = 0;
> +    } else if (offset >= L2VIC_SOFT_INTn && offset < L2VIC_INT_PENDINGn) {
> +        value = 0;
> +    } else if (offset >= L2VIC_INT_PENDINGn &&
> +               offset < L2VIC_INT_PENDINGn + 0x80) {
> +        value = bitmap32_read_word(s->int_pending,
> +            (offset - L2VIC_INT_PENDINGn) >> 2);
> +    } else if (offset >= L2VIC_INT_GRPn_0 && offset < L2VIC_INT_GRPn_1) {
> +        value = bitmap32_read_word(s->int_group_n0,
> +            (offset - L2VIC_INT_GRPn_0) >> 2);
> +    } else if (offset >= L2VIC_INT_GRPn_1 && offset < L2VIC_INT_GRPn_2) {
> +        value = bitmap32_read_word(s->int_group_n1,
> +            (offset - L2VIC_INT_GRPn_1) >> 2);
> +    } else if (offset >= L2VIC_INT_GRPn_2 && offset < L2VIC_INT_GRPn_3) {
> +        value = bitmap32_read_word(s->int_group_n2,
> +            (offset - L2VIC_INT_GRPn_2) >> 2);
> +    } else if (offset >= L2VIC_INT_GRPn_3 && offset < L2VIC_INT_GRPn_3 + 0x80) {
> +        value = bitmap32_read_word(s->int_group_n3,
> +            (offset - L2VIC_INT_GRPn_3) >> 2);
> +    } else {
> +        value = 0;
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "L2VIC: %s: offset 0x%" HWADDR_PRIx "\n", __func__,
> +                      offset);
> +    }
> +
> +    trace_hex_l2vic_reg_read((unsigned)offset, (uint32_t)value);
> +    return value;
> +}
> +
> +static const MemoryRegionOps l2vic_ops = {
> +    .read = l2vic_read,
> +    .write = l2vic_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +    .valid.unaligned = false,
> +};
> +
> +#define FASTL2VIC_ENABLE 0x0
> +#define FASTL2VIC_DISABLE 0x1
> +#define FASTL2VIC_INT 0x2
> +
> +static void fastl2vic_write(void *opaque, hwaddr offset, uint64_t val,
> +                            unsigned size)
> +{
> +    if (offset == 0) {
> +        uint32_t cmd = (val >> 16) & 0x3;
> +        uint32_t irq = val & 0x3ff;
> +        uint32_t slice = (irq / 32) * 4;
> +        val = 1 << (irq % 32);
> +
> +        if (cmd == FASTL2VIC_ENABLE) {
> +            l2vic_write(opaque, L2VIC_INT_ENABLE_SETn + slice, val, size);
> +        } else if (cmd == FASTL2VIC_DISABLE) {
> +            l2vic_write(opaque, L2VIC_INT_ENABLE_CLEARn + slice, val, size);
> +        } else if (cmd == FASTL2VIC_INT) {
> +            l2vic_write(opaque, L2VIC_SOFT_INTn + slice, val, size);
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: invalid write cmd %" PRId32 "\n",
> +                          __func__, cmd);
> +        }
> +        return;
> +    }
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid write offset 0x%08" HWADDR_PRIx
> +            "\n", __func__, offset);
> +}
> +
> +static const MemoryRegionOps fastl2vic_ops = {
> +    .write = fastl2vic_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +    .valid.unaligned = false,
> +};
> +
> +/* L2VIC Interface Implementation */
> +static uint32_t l2vic_interface_read_vid_impl(HexL2VicInterface *iface,
> +                                               uint32_t group)
> +{
> +    HexL2VICState *s = HEX_L2VIC(iface);
> +    uint32_t result = 0;
> +
> +    QEMU_LOCK_GUARD(&s->active);
> +    if (group == 0) {
> +        /* VID register: VID1 (bits 16-31), VID0 (bits 0-15) */
> +        result = deposit32(result, 0, 16, s->vid_group[0]);
> +        result = deposit32(result, 16, 16, s->vid_group[1]);
> +    } else if (group == 1) {
> +        /* VID1 register: VID3 (bits 16-31), VID2 (bits 0-15) */
> +        result = deposit32(result, 0, 16, s->vid_group[2]);
> +        result = deposit32(result, 16, 16, s->vid_group[3]);
> +    }
> +    return result;
> +}
> +
> +static void l2vic_interface_update_vid_impl(HexL2VicInterface *iface,
> +                                            uint32_t group, uint32_t value)
> +{
> +    HexL2VICState *s = HEX_L2VIC(iface);
> +
> +    QEMU_LOCK_GUARD(&s->active);
> +
> +    if (group == 0) {
> +        /* VID register: unpack VID0 and VID1 */
> +        s->vid_group[0] = extract32(value, 0, 16);
> +        s->vid_group[1] = extract32(value, 16, 16);
> +    } else if (group == 1) {
> +        /* VID1 register: unpack VID2 and VID3 */
> +        s->vid_group[2] = extract32(value, 0, 16);
> +        s->vid_group[3] = extract32(value, 16, 16);
> +    }
> +
> +    l2vic_update_all(s);
> +}
> +
> +static void l2vic_interface_clear_interrupt_impl(HexL2VicInterface *iface)
> +{
> +    HexL2VICState *s = HEX_L2VIC(iface);
> +
> +    QEMU_LOCK_GUARD(&s->active);
> +    if (s->vid0 < L2VIC_INTERRUPT_MAX) {
> +        clear_bit32(s->vid0, s->int_status);
> +    }
> +    l2vic_update_all(s);
> +}
> +
> +static void l2vic_reset_hold(Object *obj, ResetType type G_GNUC_UNUSED)
> +{
> +    HexL2VICState *s = HEX_L2VIC(obj);
> +
> +    QEMU_LOCK_GUARD(&s->active);
> +    memset(s->int_enable, 0, sizeof(s->int_enable));
> +    memset(s->int_pending, 0, sizeof(s->int_pending));
> +    memset(s->int_status, 0, sizeof(s->int_status));
> +    memset(s->int_type, 0, sizeof(s->int_type));
> +    memset(s->int_group_n0, 0, sizeof(s->int_group_n0));
> +    memset(s->int_group_n1, 0, sizeof(s->int_group_n1));
> +    memset(s->int_group_n2, 0, sizeof(s->int_group_n2));
> +    memset(s->int_group_n3, 0, sizeof(s->int_group_n3));
> +    memset(s->vid_group, 0, sizeof(s->vid_group));
> +    s->vid0 = 0;
> +
> +    l2vic_update_all(s);
> +}
> +
> +static void reset_irq_handler(void *opaque, int irq, int level)
> +{
> +    Object *obj = OBJECT(opaque);
> +
> +    if (level) {
> +        l2vic_reset_hold(obj, RESET_TYPE_COLD);
> +    }
> +}
> +
> +static void l2vic_init(Object *obj)
> +{
> +    DeviceState *dev = DEVICE(obj);
> +    HexL2VICState *s = HEX_L2VIC(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    int i;
> +

You can move this declaration in the for loop.

> +    memory_region_init_io(&s->iomem, obj, &l2vic_ops, s, "l2vic", 0x1000);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    memory_region_init_io(&s->fast_iomem, obj, &fastl2vic_ops, s, "fast",
> +                          0x10000);
> +    sysbus_init_mmio(sbd, &s->fast_iomem);
> +
> +    qdev_init_gpio_in(dev, l2vic_set_irq, L2VIC_INTERRUPT_MAX);
> +    qdev_init_gpio_in_named(dev, reset_irq_handler, "reset", 1);
> +    for (i = 0; i < 8; i++) {
> +        sysbus_init_irq(sbd, &s->irq[i]);
> +    }
> +    qemu_mutex_init(&s->active);
> +}
> +
> +static const VMStateDescription vmstate_l2vic = {
> +    .name = "l2vic",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields =
> +        (VMStateField[]){
> +            VMSTATE_UINT32_ARRAY(vid_group, HexL2VICState, 4),
> +            VMSTATE_UINT32(vid0, HexL2VICState),
> +            VMSTATE_UINT32_ARRAY(int_enable, HexL2VICState, SLICE_MAX),
> +            VMSTATE_UINT32_ARRAY(int_type, HexL2VICState, SLICE_MAX),
> +            VMSTATE_UINT32_ARRAY(int_status, HexL2VICState, SLICE_MAX),
> +            VMSTATE_UINT32_ARRAY(int_pending, HexL2VICState, SLICE_MAX),
> +            VMSTATE_UINT32_ARRAY(int_group_n0, HexL2VICState, SLICE_MAX),
> +            VMSTATE_UINT32_ARRAY(int_group_n1, HexL2VICState, SLICE_MAX),
> +            VMSTATE_UINT32_ARRAY(int_group_n2, HexL2VICState, SLICE_MAX),
> +            VMSTATE_UINT32_ARRAY(int_group_n3, HexL2VICState, SLICE_MAX),
> +            VMSTATE_END_OF_LIST() }
> +};
> +
> +static void l2vic_interface_class_init(ObjectClass *klass, const void *data)
> +{
> +    HexL2VicInterfaceClass *k = HEX_L2VIC_INTERFACE_CLASS(klass);
> +
> +    k->read_vid = l2vic_interface_read_vid_impl;
> +    k->update_vid = l2vic_interface_update_vid_impl;
> +    k->clear_interrupt = l2vic_interface_clear_interrupt_impl;
> +}
> +
> +static void l2vic_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    dc->vmsd = &vmstate_l2vic;
> +    rc->phases.hold = l2vic_reset_hold;
> +}
> +
> +static const TypeInfo l2vic_interface_info = {
> +    .name = TYPE_HEX_L2VIC_INTERFACE,
> +    .parent = TYPE_INTERFACE,
> +    .class_size = sizeof(HexL2VicInterfaceClass),
> +    .class_init = l2vic_interface_class_init,
> +};
> +
> +static const TypeInfo l2vic_info = {
> +    .name = TYPE_HEX_L2VIC,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(HexL2VICState),
> +    .instance_init = l2vic_init,
> +    .class_init = l2vic_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_HEX_L2VIC_INTERFACE },
> +        { }
> +    },
> +};
> +
> +static void l2vic_register_types(void)
> +{
> +    type_register_static(&l2vic_interface_info);
> +    type_register_static(&l2vic_info);
> +}
> +
> +type_init(l2vic_register_types)
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 42d93e5da47..be56ac0419f 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -65,6 +65,8 @@ static const Property hexagon_cpu_properties[] = {
>      DEFINE_PROP_LINK("tlb", HexagonCPU, tlb, TYPE_HEXAGON_TLB,
>                       HexagonTLBState *),
>      DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU, boot_addr, 0xffffffff),
> +    DEFINE_PROP_LINK("l2vic", HexagonCPU, l2vic,
> +                     TYPE_HEX_L2VIC_INTERFACE, HexL2VicInterface *),
>      DEFINE_PROP_LINK("global-regs", HexagonCPU, globalregs,
>          TYPE_HEXAGON_GLOBALREG, HexagonGlobalRegState *),
>      DEFINE_PROP_UINT32("htid", HexagonCPU, htid, 0),
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 125952aee59..0d88ae65e75 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -40,6 +40,7 @@
>  #include "hw/hexagon/hexagon_globalreg.h"
>  #include "hex_mmu.h"
>  #include "hw/hexagon/hexagon_tlb.h"
> +#include "hw/intc/hex-l2vic.h"
>  #include "hex_interrupts.h"
>  #include "hexswi.h"
>  #endif
> @@ -1557,7 +1558,25 @@ void HELPER(raise_stack_overflow)(CPUHexagonState *env, uint32_t slot,
>  
>  void HELPER(ciad)(CPUHexagonState *env, uint32_t mask)
>  {
> -    g_assert_not_reached();
> +    uint32_t ipendad;
> +    uint32_t iad;
> +    HexagonCPU *cpu;
> +
> +    BQL_LOCK_GUARD();
> +    cpu = env_archcpu(env);
> +    ipendad = cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_IPENDAD,
> +                               env->threadId) : 0;
> +    iad = fGET_FIELD(ipendad, IPENDAD_IAD);
> +    fSET_FIELD(ipendad, IPENDAD_IAD, iad & ~(mask));
> +    if (cpu->globalregs) {
> +        hexagon_globalreg_write(cpu->globalregs, HEX_SREG_IPENDAD,
> +                                ipendad, env->threadId);
> +    }
> +    if (cpu->l2vic) {
> +        l2vic_clear_interrupt(cpu->l2vic);
> +    }
> +    hex_interrupt_update(env);
>  }
>  
>  void HELPER(siad)(CPUHexagonState *env, uint32_t mask)
> diff --git a/hw/hexagon/Kconfig b/hw/hexagon/Kconfig
> index 52065ab3b22..191c6c5d65c 100644
> --- a/hw/hexagon/Kconfig
> +++ b/hw/hexagon/Kconfig
> @@ -2,6 +2,7 @@ config HEX_DSP
>      bool
>      default y
>      depends on HEXAGON
> +    select HEX_L2VIC
>  
>  config HEX_VIRT
>      bool
> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
> index 636d00b7e88..097de4efc5d 100644
> --- a/hw/intc/Kconfig
> +++ b/hw/intc/Kconfig
> @@ -8,6 +8,9 @@ config I8259
>  config PL190
>      bool
>  
> +config HEX_L2VIC
> +    bool
> +
>  config IOAPIC
>      bool
>      select I8259
> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> index fac2d228f9b..9077a3f3297 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -74,6 +74,8 @@ specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('xics_spapr.c', 'spapr_xi
>  specific_ss.add(when: 'CONFIG_XIVE', if_true: files('xive.c'))
>  specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_XIVE'],
>  		if_true: files('spapr_xive_kvm.c'))
> +
> +specific_ss.add(when: 'CONFIG_HEX_L2VIC', if_true: files('hex-l2vic.c'))
>  specific_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
>  specific_ss.add(when: 'CONFIG_LOONGSON_IPI_COMMON', if_true: files('loongson_ipi_common.c'))
>  specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c'))
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index e7d6c304487..7512c6e6004 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -337,6 +337,10 @@ sh_intc_register(const char *s, int id, unsigned short v, int c, int m) "%s %u -
>  sh_intc_read(unsigned size, uint64_t offset, unsigned long val) "size %u 0x%" PRIx64 " -> 0x%lx"
>  sh_intc_write(unsigned size, uint64_t offset, unsigned long val) "size %u 0x%" PRIx64 " <- 0x%lx"
>  sh_intc_set(int id, int enable) "setting interrupt group %d to %d"
> +# hex-l2vic.c
> +hex_l2vic_reg_write(unsigned int addr, uint32_t value) "addr: 0x%03x value: 0x%08"PRIx32
> +hex_l2vic_reg_read(unsigned int addr, uint32_t value) "addr: 0x%03x value: 0x%08"PRIx32
> +hex_l2vic_delivered(int irq, int vid) "l2vic: delivered %d (vid %d)"
>  
>  # loongson_ipi.c
>  loongson_ipi_read(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64


