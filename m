Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7D4C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 21:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtXID-0008SG-9V; Mon, 10 Aug 2026 17:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wtXIC-0008S2-Br
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:12:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wtXIA-0005KP-GF
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:12:20 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AL9Ae82830718
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=gkPT94BBZfugYf1OzcN54hnt
 Qtu8wQFgEr/yvUlt0g8=; b=gJdoCFT/6PJKCmm2vJ+TRGiqveRz+aVUaVbtF8Bb
 sz5ycJFizeCAIbX/qu7UdzkpT34n34h7tfDWkWNb8ApYH8XH2k+N0ICOh6ESxicD
 VI3DdXhE/p/9KjyDF1kJTHle4uDuBFUL17uWy13KFUnWSxXpvvYs+A+Z8XBXy8PT
 hIun2aR+uOf2Hc4ZmG9b3o28sRYSofZVoI5/Pkp27yBTb2s+KMYwzmqV9cz4kY+P
 vy5otWt/9AFKvwCdCruCs04/wnaMqq/sAaFBDpXqZQr/v7qWArCsTBcDGFmJfznu
 C6PxkTS7eR8w39I/CIQAJVF9h0xgoFM0XegdCzvhUY5l9A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk2132n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:12:15 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8f0ed4fe79aso41154396d6.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 14:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786396334; x=1787001134; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gkPT94BBZfugYf1OzcN54hntQtu8wQFgEr/yvUlt0g8=;
 b=XUDDLpBDIkp+GzlPFdhoOsOHPjOrMZGQvnmoMjC1P/3pVw8PKSMLkCZnxmkVStGx1a
 iwwvW0nlO5Usa/nTgKriqj8MsBRadS5+QkqxlRcp1x6JNkssdsh6f3McJR4Jvd/z5R3I
 WEhl9BaZvq+7mBuAR91tlgvzoERySaFOtUVFHJIzxAZP3kisrdJZQPuUWfGjh5vwD2f4
 DGXu8GGdzMJnWxLZyjox/5B4LtNHxJOJlNXekyh/+WiOj3EAgv0PwHzpV28k9MrmFgAo
 AFmPQGda5GPIzACWwpP7L/g3q0OccLVa+N/xY6Xf3qPEiiHxof1xAvs0VliPf0Jg3ObL
 +Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786396334; x=1787001134;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gkPT94BBZfugYf1OzcN54hntQtu8wQFgEr/yvUlt0g8=;
 b=NG/Bd/2bB10W4Gv9OGwYK52zgmtyUBoinbHQty2ylGvNtgOq+p7yycRRTJSEV75fT5
 ee4cAugwsa31tyoTtgHDKlPadnRw3kXndlhcAh8Er1hsf4iTJHhiRfEs9QzysIbfjz8l
 R2DHo5PeGaOjxyEWPPpHX1DnImMUcayMaot/GPN5IHP44TK8rZQgNWvVg/qgTAEzKTtJ
 oF0gYwsSYfuejIA/dLqfF7K3UDshX17fYaavPHXEFLiFqauKyDg12QInEj6+7wlu4n6x
 t76juZCL8R73u21doJjAn4lFrL9cP+v9ivD1pJ8ffs9suVQJaJPpxnBvBB26iV9rfhyJ
 64wA==
X-Gm-Message-State: AOJu0YyK8Tc6L+lV6wX91EXHrVmeUCZP6oYjDreUpHaRyIq2rSMuRscw
 hNFzM8F6twa0cj5de3be1r8TR41tMxviw/2OhFERVDhvM5VphEXLlzLulMQVIQDlty2vljGGav0
 XuvCmKbwTfo0E/KB7N3fz4AcrE5k3M9Z8VTdR+ppBKpvOP1puK1xpUnaxKQ==
X-Gm-Gg: AR+sD12dN6VLjHElIDRuCoKDyFfReLVpMOqDkO+XjD8HCxGvYTNbVqYyX1Op7a8xyh4
 DOi5+w4GyzzQRj4ce9lQYmcmxiLnioIAjyUNmfxFMiimVhRRATV6bzPaokQ81sp4MHKwcM0zV2f
 upSdDFrvOFQ3xmgO03HVwwI2yNGRGhX7S8G8O565o3mVJKMIr44W7+AKENieudRRlzzA9EPUOa/
 ElMOc2vVx7jAOXLAa6lkFX1bIWQ0OZfaQClzHWWdbVvrIHjjrVCDYnl5/JyE9/emP4AKmTSyHz2
 LQzcvqz6J21qc5eTclH261a172SCDcP9vSBFJIBgPHfhjr/tiImfLWBmXkFrsche9cwCBOYzErv
 xEKQo2+oZZ6eeReRmlp1xLDowh9+bZVsREHtNDmy8+TzERuQ4vnNqG8tswvleqJhP
X-Received: by 2002:a05:6214:488:b0:8ca:f47:25ea with SMTP id
 6a1803df08f44-90a34388f0bmr292576626d6.0.1786396334405; 
 Mon, 10 Aug 2026 14:12:14 -0700 (PDT)
X-Received: by 2002:a05:6214:488:b0:8ca:f47:25ea with SMTP id
 6a1803df08f44-90a34388f0bmr292575976d6.0.1786396333933; 
 Mon, 10 Aug 2026 14:12:13 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908a932ce88sm79815236d6.38.2026.08.10.14.12.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 14:12:13 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------vIm42PuPmkLbhcBtQBFsKYxr"
Message-ID: <b6f8c765-4e17-4aa1-990c-5518224971ef@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 16:12:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Hexagon (target/hexagon) Clean up disassembly of control
 and system regs
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
References: <20260810182804.27310-1-ltaylorsimpson@gmail.com>
 <57bf1075-cf49-4ccd-8893-94d32d4be313@oss.qualcomm.com>
 <CAATN3NoX9jxBv4mjXwRxJ3puooZFEJrE5_LnoPMabnX=WwD0sg@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAATN3NoX9jxBv4mjXwRxJ3puooZFEJrE5_LnoPMabnX=WwD0sg@mail.gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE3OCBTYWx0ZWRfX9ToNb7e3/DbK
 CHXerNX4pH77HiKSbE1ImOPKY+uvevPxdJs41E5mkzh8aREUeWG2Xbg4Q8/NQJfzx1nlhR1IAs7
 tC1vzUOKaWDwGVPRRH9nCHeBj7bVYK8=
X-Proofpoint-GUID: 7RtmQzR3q_8R3eH2B9X-tRhq1homXW7P
X-Proofpoint-ORIG-GUID: 7RtmQzR3q_8R3eH2B9X-tRhq1homXW7P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE3OCBTYWx0ZWRfXxue++oKkZNiu
 MlEDii9wkX/MoMWZJlgQSeGy6Bvb+ocaUCcmJG/j3kdHoD0nKHwf68R45Ny7gt/S4mdUg3+eMPw
 GUBXCdFASTxN6yI6/cvDNgnZy80C5cIYpQyW3nszKyGiqbXagzu0Khre6t/ZMyY7jTvfVXnaBf4
 KA7ms5yK+VAVHKv339lkvC/pw2c8fTNCiAKmyq3juL2FMHXAlsLnM+Unr/FahTsQ/iT1exm3h9H
 J/LVKABo4BtqlHDF5fjdbvz69ZW+w5g2S9HufDonzVLg88EljUfwAFQhBPlKBCnobZ29tudKT96
 GuBveqbmU562YIX9BKapzWn93JEPG5zx9TrncGKYo3uQXeP1MLabV9WQRqdRbH21NrBV0Z1IUOn
 av492oenfqOJ8VLFUBpvS2oVdktWu0Hmmd/Asi4VUS/n4PHaxmvtO6ePy9v35edcNnv0ihJFQhB
 oKWCwqjkbNoAvofaPiw==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=6a7a3eaf cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=TbYU7SO1IfFAHSwTUY8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=X4mkYMJfH2cZhL8tF-EA:9 a=YKJ2WzC7VqSuMe77:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100178
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

This is a multi-part message in MIME format.
--------------vIm42PuPmkLbhcBtQBFsKYxr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/10/2026 3:53 PM, Taylor Simpson wrote:
>
>
> On Mon, Aug 10, 2026 at 1:34 PM Brian Cain 
> <brian.cain@oss.qualcomm.com> wrote:
>
>
>     On 8/10/2026 1:28 PM, Taylor Simpson wrote:
>     > Change disassembly of control regs from C{num}/{name} to {name}
>     > Change disassembly of system regs from S{num}/r{num} to {name}
>     >
>     > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>     > ---
>     >   target/hexagon/printinsn.c      | 22 ++++++++++++++++++----
>     >   target/hexagon/gen_printinsn.py | 14 ++++++++------
>     >   2 files changed, 26 insertions(+), 10 deletions(-)
>     >
>     > diff --git a/target/hexagon/printinsn.c b/target/hexagon/printinsn.c
>     > index a7e46f4bcd..b55d3b0b35 100644
>     > --- a/target/hexagon/printinsn.c
>     > +++ b/target/hexagon/printinsn.c
>     > @@ -23,18 +23,32 @@
>     >   #include "internal.h"
>     >   #include "decode.h"
>     >
>     > +static char regstr[10];
>     > +
>     >   static const char *sreg2str(unsigned int reg)
>     >   {
>     > -    if (reg < TOTAL_PER_THREAD_REGS) {
>     > -        return hexagon_regnames[reg];
>     > +#ifndef CONFIG_USER_ONLY
>     > +    if (reg < NUM_SREGS) {
>     > +        return hexagon_sregnames[reg];
>     >       } else {
>     > -        return "???";
>     > +        snprintf(regstr, sizeof(regstr), "S%d", reg);
>     > +        return regstr;
>     >       }
>     > +#else
>     > +    snprintf(regstr, sizeof(regstr), "S%d", reg);
>     > +    return regstr;
>     > +#endif
>     >   }
>     >
>     >   static const char *creg2str(unsigned int reg)
>     >   {
>     > -    return sreg2str(reg + HEX_REG_SA0);
>     > +    unsigned int gpr = reg + HEX_REG_SA0;
>     > +    if (gpr < TOTAL_PER_THREAD_REGS) {
>     > +        return hexagon_regnames[gpr];
>     > +    } else {
>     > +        snprintf(regstr, sizeof(regstr), "C%d", reg);
>     > +        return regstr;
>     > +    }
>     >   }
>     >
>
>
>     Seems like this change also depends on some kind of mutex around
>     regstr[] so that we know it's not being used concurrently by multiple
>     threads.  Translation is single-threaded but if we gained another
>     caller
>     we wouldn't remember to come back and remediate this.
>
>     I suppose we could take an input buffer/length.  Or maybe we just add
>     another static _regnames[] array to solve the lifetime/race problems?
>
>
> How about putting a regstr field in the Insn struct (and pass Insn* to 
> these two functions)?
>

A character array?  Sure: seems like that should work.

But if we have a static array for the others why not leverage that here 
too?  We can statically fill these values, right?


> Thanks,
> Taylor
>
--------------vIm42PuPmkLbhcBtQBFsKYxr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/10/2026 3:53 PM, Taylor Simpson
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAATN3NoX9jxBv4mjXwRxJ3puooZFEJrE5_LnoPMabnX=WwD0sg@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <br>
        <div class="gmail_quote gmail_quote_container">
          <div dir="ltr" class="gmail_attr">On Mon, Aug 10, 2026 at
            1:34 PM Brian Cain &lt;<a
              href="mailto:brian.cain@oss.qualcomm.com"
              moz-do-not-send="true" class="moz-txt-link-freetext">brian.cain@oss.qualcomm.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
            On 8/10/2026 1:28 PM, Taylor Simpson wrote:<br>
            &gt; Change disassembly of control regs from C{num}/{name}
            to {name}<br>
            &gt; Change disassembly of system regs from S{num}/r{num} to
            {name}<br>
            &gt;<br>
            &gt; Signed-off-by: Taylor Simpson &lt;<a
              href="mailto:ltaylorsimpson@gmail.com" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">ltaylorsimpson@gmail.com</a>&gt;<br>
            &gt; ---<br>
            &gt;   target/hexagon/printinsn.c      | 22
            ++++++++++++++++++----<br>
            &gt;   target/hexagon/gen_printinsn.py | 14 ++++++++------<br>
            &gt;   2 files changed, 26 insertions(+), 10 deletions(-)<br>
            &gt;<br>
            &gt; diff --git a/target/hexagon/printinsn.c
            b/target/hexagon/printinsn.c<br>
            &gt; index a7e46f4bcd..b55d3b0b35 100644<br>
            &gt; --- a/target/hexagon/printinsn.c<br>
            &gt; +++ b/target/hexagon/printinsn.c<br>
            &gt; @@ -23,18 +23,32 @@<br>
            &gt;   #include "internal.h"<br>
            &gt;   #include "decode.h"<br>
            &gt;   <br>
            &gt; +static char regstr[10];<br>
            &gt; +<br>
            &gt;   static const char *sreg2str(unsigned int reg)<br>
            &gt;   {<br>
            &gt; -    if (reg &lt; TOTAL_PER_THREAD_REGS) {<br>
            &gt; -        return hexagon_regnames[reg];<br>
            &gt; +#ifndef CONFIG_USER_ONLY<br>
            &gt; +    if (reg &lt; NUM_SREGS) {<br>
            &gt; +        return hexagon_sregnames[reg];<br>
            &gt;       } else {<br>
            &gt; -        return "???";<br>
            &gt; +        snprintf(regstr, sizeof(regstr), "S%d", reg);<br>
            &gt; +        return regstr;<br>
            &gt;       }<br>
            &gt; +#else<br>
            &gt; +    snprintf(regstr, sizeof(regstr), "S%d", reg);<br>
            &gt; +    return regstr;<br>
            &gt; +#endif<br>
            &gt;   }<br>
            &gt;   <br>
            &gt;   static const char *creg2str(unsigned int reg)<br>
            &gt;   {<br>
            &gt; -    return sreg2str(reg + HEX_REG_SA0);<br>
            &gt; +    unsigned int gpr = reg + HEX_REG_SA0;<br>
            &gt; +    if (gpr &lt; TOTAL_PER_THREAD_REGS) {<br>
            &gt; +        return hexagon_regnames[gpr];<br>
            &gt; +    } else {<br>
            &gt; +        snprintf(regstr, sizeof(regstr), "C%d", reg);<br>
            &gt; +        return regstr;<br>
            &gt; +    }<br>
            &gt;   }<br>
            &gt;   <br>
            <br>
            <br>
            Seems like this change also depends on some kind of mutex
            around <br>
            regstr[] so that we know it's not being used concurrently by
            multiple <br>
            threads.  Translation is single-threaded but if we gained
            another caller <br>
            we wouldn't remember to come back and remediate this.<br>
            <br>
            I suppose we could take an input buffer/length.  Or maybe we
            just add <br>
            another static _regnames[] array to solve the lifetime/race
            problems?<br>
            <br>
          </blockquote>
          <div><br>
          </div>
          <div>How about putting a regstr field in the Insn struct (and
            pass Insn* to these two functions)?</div>
          <div><br>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>A character array?  Sure: seems like that should work.  <br>
      <br>
    </p>
    <p>But if we have a static array for the others why not leverage
      that here too?  We can statically fill these values, right?</p>
    <br>
    <blockquote type="cite"
cite="mid:CAATN3NoX9jxBv4mjXwRxJ3puooZFEJrE5_LnoPMabnX=WwD0sg@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <div>Thanks,</div>
          <div>Taylor</div>
          <div><br>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------vIm42PuPmkLbhcBtQBFsKYxr--

