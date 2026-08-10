Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98820C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 22:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtYtV-0003DU-PV; Mon, 10 Aug 2026 18:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wtYtL-0003Cz-Qm
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 18:54:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wtYtI-0004ii-Q5
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 18:54:47 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMqeuK3011239
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 22:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fpBdnm7zza3lWROc+mw/QUeR
 iFeDgqHMiCKbMXrbVdM=; b=DGa4kha2s1t0+SHe8XsNxtln8oe2pNAK4Q9n7hU2
 vRuuqPyyZPGl17aCDMjGWepOn/bHCs/9scRmWLqFXY6NXfPnxdxEaBF/G+Bz6McR
 sceIHRDh2y0VECe+lm5qxrLnKcRLsi6YMAb7dYpl0ik0/0IWu5et1mzTakjlLgag
 CyFd3YJf22y0UofKefgTfng7fGjxOIVIg/ZKfq+WJXWdZvV32EKUu4Rp9dMZ9tpX
 UDcWdH7OsusaOqlQx0KA0T9eZo7hzUMHAxAPXCzAPlTW7SvuCtS6TBBIgqSdkRqr
 /6vs2NA+UID4wS0ogl0oI/aM8/RIFLbnoMMVMpvb4e0Xzg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjthc0v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 22:54:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-930a098ea19so294433485a.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 15:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786402480; x=1787007280; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fpBdnm7zza3lWROc+mw/QUeRiFeDgqHMiCKbMXrbVdM=;
 b=bPj7kscFAxnZ7Kgb/ew3Ys3YPGL0KOfjdyypfy5QQDB0sS8jzq7Hlsa7VORoIpxFuS
 DM7OZfuuNCSr4DSamvZKfen8nq3IdixU3pUOP/jppmhwjWYmNRWb8l6wcOXzssC9iriy
 mslQnYJ4NVc8H83JwiiTC6ACSA1RPmG7yj/Ad0j5549KTVrfWwdfL40N2N1jIWrIcwrh
 BOdTpb+LAD4jw7rr9zt0US5vcwmNJ0vCkRQQl6VQhMpznZSWziN4KRMuV3AcygkSeqR9
 wnWwGAeR8AtX+yQELvACWKzXAVBNvMZekGGdvO05NKGWxorUHAUgWhtsX+pDgLLCE8Yg
 NBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786402480; x=1787007280;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fpBdnm7zza3lWROc+mw/QUeRiFeDgqHMiCKbMXrbVdM=;
 b=L8XquWhvEt+WVdMcRtd11VlBZXJ6FW3VsYbXSqYZI4j9AqzxLIo7QX5URshPDwbLQf
 4Lq6rhm/4xjPrCpvclvuRHY8M50DzMyrJaRexQCZuAMFEGefmkUP/nY7uOKru0x3cgZL
 2ASYfjAvBsoeKUvazCPjNtaDx2H+Zk01RLEpwR+jUGwdIgUVYMvVPmPg+JUPVSEK1UmA
 /H52jzZ7jFR2Xz+uWjPqmVnflU3w3DiS6sm2jlHca8BFaWKFXYQkdrRPucX7IoX+GXHW
 CPLeADqcySPsnGO7F58JYxiOcQr1N6FAm5WARaEiqc1Ob4CSUm//EiFVqraAmyDeaWy0
 XKrQ==
X-Gm-Message-State: AOJu0YyG9kaVyqbykYNhyaShtnusZGzyJEH5qr+9qQzWWDFlDvqfyy/i
 x5leMHnXGtjxDice2hl3JGVP+aLCsGT4fZLy2Werog4lOFi/cUXK1QyfH0gCelRE5grJ71iJUQS
 0z4GNfyWbCOtEyOa9Tmqd3qURcgx9wgV4os0HssGPufmge/NloYkzVKWgZA==
X-Gm-Gg: AR+sD10nMlBBuUhIpk2xSTxT+0hHmd/9AAXb1bOEaSsiLoIY+KbooAvvEFztBPdlzn0
 qKEZhUaBSL22wcp4UH9zuWeKCl2vRQ7C8djiFRn+8lRLlaFWVgyxGkswMTW8Jv7LlN01uVHkPhD
 mtmoOr8O+CWfKfOtSgFWvb1/bCZPWNZILWZumB20+MFjlMzdgUPTJaBcocHRUSG3oHtRaC55Vie
 iEEYZjLHLDgVORiOXfsseD7RkKA4/ZdfNA0LdI4syRO1c2+lwXjoQgQJFZ8jrstgSbGHw86/Cxx
 RyJNq25KcI1zsRHH/OLt4SdX+20/Bb0HIyOe7u6H1QQTb0S0ZeP1Rr7kMTcUJfMWp3g/YVhHDDB
 BJLvvvCbGZZA2E1LYtgqJeKEKX8vINQtlZsJ5UB0Qt9cF7zz2LRwBmsaSbVOFddglcsuVk5WWZc
 KpnThR
X-Received: by 2002:a05:620a:40ca:b0:936:4955:e5ef with SMTP id
 af79cd13be357-93671eae246mr2577767985a.22.1786402479766; 
 Mon, 10 Aug 2026 15:54:39 -0700 (PDT)
X-Received: by 2002:a05:620a:40ca:b0:936:4955:e5ef with SMTP id
 af79cd13be357-93671eae246mr2577764685a.22.1786402479285; 
 Mon, 10 Aug 2026 15:54:39 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e03aeadsm887266185a.3.2026.08.10.15.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 15:54:38 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------2zZLFmMeMwnzXX0LkZJIbyoe"
Message-ID: <9db1ef83-7c05-4327-a6f3-539d1769df9d@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 17:54:36 -0500
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
 <b6f8c765-4e17-4aa1-990c-5518224971ef@oss.qualcomm.com>
 <CAATN3NrvDzJ_+7pnx2E2dLcQmmDsVRqPGvcVSVA4e+j_AiMGdA@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAATN3NrvDzJ_+7pnx2E2dLcQmmDsVRqPGvcVSVA4e+j_AiMGdA@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE5NCBTYWx0ZWRfX6S1Sl+LRKJcL
 5XPcGScp74DXXwnDG/mPb6Hq4Zz/7DP9H/z748al5YZd6ADHy0GG4azj0fwPQifOaWVCZSIe2BY
 iKVgMQuOiqE9vwBx4BBrkvNrkYbprtxFoWKDRTv+gaDq0LDu2FphAcbvHwRuE2zfN7EuZy0PA/S
 9upQAE0+EyxL8n5tuGWCdhxh8BAkQdVRQ8fJJ9Df5mgcmhAI2f32DnITUOC7wY1XxxKYnfqv9Km
 7Veng5zpUmtuRatz2GRDHx0Dl5GX34kiuZgsKrh1DuMjKyBjLEHJ3t9M2KG0TjKAENAW1sM6vpS
 54z0Pmki59l8N+OF4P/PD6FIrFIf++yT8yO72l4Kbtm7OeLQNVJxBJTqUeTiZDDVouvtm0t3zJD
 bqiXPZg8jnZVQh8A1ILyATxpnxZ/rKJf9mmpWisw6sZ+cxbAwWTzGK2XSWjUz+osJbQp/RYcbOo
 WUFnYLriUaWxhf+FRnQ==
X-Proofpoint-ORIG-GUID: 4e-V9q8pHdaHXrlEGEN-CAbfu24XlUz3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE5NCBTYWx0ZWRfXyhmkdS2Yn4Om
 1levuWSUr0CPmcVUJu5Gv5WkL+KwNpoj0+YgrLSkg0tnq2KE4/I8iVyMUiHJqf3zgbx10SUm6KA
 vZhQVR+NoCGE0HNkUoJR1Lb4UigDg6w=
X-Proofpoint-GUID: 4e-V9q8pHdaHXrlEGEN-CAbfu24XlUz3
X-Authority-Analysis: v=2.4 cv=JsHBas4C c=1 sm=1 tr=0 ts=6a7a56b0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=oA4ofaE83iibCVGMRL0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TqKbhGCr5fgxf99J02oA:9 a=L6CHnQDNeuppI5oN:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100194
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
--------------2zZLFmMeMwnzXX0LkZJIbyoe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/10/2026 4:32 PM, Taylor Simpson wrote:
>
>
> On Mon, Aug 10, 2026 at 3:12 PM Brian Cain 
> <brian.cain@oss.qualcomm.com> wrote:
>
>
>     On 8/10/2026 3:53 PM, Taylor Simpson wrote:
>>
>>
>>     On Mon, Aug 10, 2026 at 1:34 PM Brian Cain
>>     <brian.cain@oss.qualcomm.com> wrote:
>>
>>
>>         On 8/10/2026 1:28 PM, Taylor Simpson wrote:
>>         > Change disassembly of control regs from C{num}/{name} to {name}
>>         > Change disassembly of system regs from S{num}/r{num} to {name}
>>         >
>>         > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>>         > ---
>>         >   target/hexagon/printinsn.c      | 22 ++++++++++++++++++----
>>         >   target/hexagon/gen_printinsn.py | 14 ++++++++------
>>         >   2 files changed, 26 insertions(+), 10 deletions(-)
>>         >
>>         > diff --git a/target/hexagon/printinsn.c
>>         b/target/hexagon/printinsn.c
>>         > index a7e46f4bcd..b55d3b0b35 100644
>>         > --- a/target/hexagon/printinsn.c
>>         > +++ b/target/hexagon/printinsn.c
>>         > @@ -23,18 +23,32 @@
>>         >   #include "internal.h"
>>         >   #include "decode.h"
>>         >
>>         > +static char regstr[10];
>>         > +
>>         >   static const char *sreg2str(unsigned int reg)
>>         >   {
>>         > -    if (reg < TOTAL_PER_THREAD_REGS) {
>>         > -        return hexagon_regnames[reg];
>>         > +#ifndef CONFIG_USER_ONLY
>>         > +    if (reg < NUM_SREGS) {
>>         > +        return hexagon_sregnames[reg];
>>         >       } else {
>>         > -        return "???";
>>         > +        snprintf(regstr, sizeof(regstr), "S%d", reg);
>>         > +        return regstr;
>>         >       }
>>         > +#else
>>         > +    snprintf(regstr, sizeof(regstr), "S%d", reg);
>>         > +    return regstr;
>>         > +#endif
>>         >   }
>>         >
>>         >   static const char *creg2str(unsigned int reg)
>>         >   {
>>         > -    return sreg2str(reg + HEX_REG_SA0);
>>         > +    unsigned int gpr = reg + HEX_REG_SA0;
>>         > +    if (gpr < TOTAL_PER_THREAD_REGS) {
>>         > +        return hexagon_regnames[gpr];
>>         > +    } else {
>>         > +        snprintf(regstr, sizeof(regstr), "C%d", reg);
>>         > +        return regstr;
>>         > +    }
>>         >   }
>>         >
>>
>>
>>         Seems like this change also depends on some kind of mutex around
>>         regstr[] so that we know it's not being used concurrently by
>>         multiple
>>         threads.  Translation is single-threaded but if we gained
>>         another caller
>>         we wouldn't remember to come back and remediate this.
>>
>>         I suppose we could take an input buffer/length. Or maybe we
>>         just add
>>         another static _regnames[] array to solve the lifetime/race
>>         problems?
>>
>>
>>     How about putting a regstr field in the Insn struct (and pass
>>     Insn* to these two functions)?
>>
>
>     A character array?  Sure: seems like that should work.
>
>     But if we have a static array for the others why not leverage that
>     here too?  We can statically fill these values, right?
>
>
> These are for cases where there is some sort of error and the reg 
> number is larger than NUM_SREGS/TOTAL_PER_THREAD_REGS.  So, we 
> wouldn't know how to size these without looking at the number of bits 
> in the encoding of each instruction that has one of these. However, 
> that could change over time if the architecture adds new instructions.
>
Ah, okay, right.

Okay - any solution that mitigates the race should suffice, then.


> The regno field in the Insn struct is a uint8_t, so we could create 
> static arrays with 256 entries and
>
> We could revert back to returning "???".  Alternatively, S<unknown> or 
> C<unknown> would be more readable.
>
> Thoughts?
>
>
>
--------------2zZLFmMeMwnzXX0LkZJIbyoe
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
    <div class="moz-cite-prefix">On 8/10/2026 4:32 PM, Taylor Simpson
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAATN3NrvDzJ_+7pnx2E2dLcQmmDsVRqPGvcVSVA4e+j_AiMGdA@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <br>
        <div class="gmail_quote gmail_quote_container">
          <div dir="ltr" class="gmail_attr">On Mon, Aug 10, 2026 at
            3:12 PM Brian Cain &lt;<a
              href="mailto:brian.cain@oss.qualcomm.com"
              moz-do-not-send="true" class="moz-txt-link-freetext">brian.cain@oss.qualcomm.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <p><br>
              </p>
              <div>On 8/10/2026 3:53 PM, Taylor Simpson wrote:<br>
              </div>
              <blockquote type="cite">
                <div dir="ltr">
                  <div dir="ltr"><br>
                  </div>
                  <br>
                  <div class="gmail_quote">
                    <div dir="ltr" class="gmail_attr">On Mon, Aug 10,
                      2026 at 1:34 PM Brian Cain &lt;<a
                        href="mailto:brian.cain@oss.qualcomm.com"
                        target="_blank" moz-do-not-send="true"
                        class="moz-txt-link-freetext">brian.cain@oss.qualcomm.com</a>&gt;
                      wrote:<br>
                    </div>
                    <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
                      On 8/10/2026 1:28 PM, Taylor Simpson wrote:<br>
                      &gt; Change disassembly of control regs from
                      C{num}/{name} to {name}<br>
                      &gt; Change disassembly of system regs from
                      S{num}/r{num} to {name}<br>
                      &gt;<br>
                      &gt; Signed-off-by: Taylor Simpson &lt;<a
                        href="mailto:ltaylorsimpson@gmail.com"
                        target="_blank" moz-do-not-send="true"
                        class="moz-txt-link-freetext">ltaylorsimpson@gmail.com</a>&gt;<br>
                      &gt; ---<br>
                      &gt;   target/hexagon/printinsn.c      | 22
                      ++++++++++++++++++----<br>
                      &gt;   target/hexagon/gen_printinsn.py | 14
                      ++++++++------<br>
                      &gt;   2 files changed, 26 insertions(+), 10
                      deletions(-)<br>
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
                      &gt;   static const char *sreg2str(unsigned int
                      reg)<br>
                      &gt;   {<br>
                      &gt; -    if (reg &lt; TOTAL_PER_THREAD_REGS) {<br>
                      &gt; -        return hexagon_regnames[reg];<br>
                      &gt; +#ifndef CONFIG_USER_ONLY<br>
                      &gt; +    if (reg &lt; NUM_SREGS) {<br>
                      &gt; +        return hexagon_sregnames[reg];<br>
                      &gt;       } else {<br>
                      &gt; -        return "???";<br>
                      &gt; +        snprintf(regstr, sizeof(regstr),
                      "S%d", reg);<br>
                      &gt; +        return regstr;<br>
                      &gt;       }<br>
                      &gt; +#else<br>
                      &gt; +    snprintf(regstr, sizeof(regstr), "S%d",
                      reg);<br>
                      &gt; +    return regstr;<br>
                      &gt; +#endif<br>
                      &gt;   }<br>
                      &gt;   <br>
                      &gt;   static const char *creg2str(unsigned int
                      reg)<br>
                      &gt;   {<br>
                      &gt; -    return sreg2str(reg + HEX_REG_SA0);<br>
                      &gt; +    unsigned int gpr = reg + HEX_REG_SA0;<br>
                      &gt; +    if (gpr &lt; TOTAL_PER_THREAD_REGS) {<br>
                      &gt; +        return hexagon_regnames[gpr];<br>
                      &gt; +    } else {<br>
                      &gt; +        snprintf(regstr, sizeof(regstr),
                      "C%d", reg);<br>
                      &gt; +        return regstr;<br>
                      &gt; +    }<br>
                      &gt;   }<br>
                      &gt;   <br>
                      <br>
                      <br>
                      Seems like this change also depends on some kind
                      of mutex around <br>
                      regstr[] so that we know it's not being used
                      concurrently by multiple <br>
                      threads.  Translation is single-threaded but if we
                      gained another caller <br>
                      we wouldn't remember to come back and remediate
                      this.<br>
                      <br>
                      I suppose we could take an input buffer/length. 
                      Or maybe we just add <br>
                      another static _regnames[] array to solve the
                      lifetime/race problems?<br>
                      <br>
                    </blockquote>
                    <div><br>
                    </div>
                    <div>How about putting a regstr field in the Insn
                      struct (and pass Insn* to these two functions)?</div>
                    <div><br>
                    </div>
                  </div>
                </div>
              </blockquote>
              <p><br>
              </p>
              <p>A character array?  Sure: seems like that should
                work.  <br>
                <br>
              </p>
              <p>But if we have a static array for the others why not
                leverage that here too?  We can statically fill these
                values, right?</p>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>These are for cases where there is some sort of error and
            the reg number is larger than
            NUM_SREGS/TOTAL_PER_THREAD_REGS.  So, we wouldn't know how
            to size these without looking at the number of bits in the
            encoding of each instruction that has one of these. 
            However, that could change over time if the architecture
            adds new instructions.</div>
          <div><br>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Ah, okay, right.</p>
    <p>Okay - any solution that mitigates the race should suffice, then.</p>
    <br>
    <blockquote type="cite"
cite="mid:CAATN3NrvDzJ_+7pnx2E2dLcQmmDsVRqPGvcVSVA4e+j_AiMGdA@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <div>The regno field in the Insn struct is a uint8_t, so we
            could create static arrays with 256 entries and </div>
          <div><br>
          </div>
          <div>We could revert back to returning "???".  Alternatively,
            S&lt;unknown&gt; or C&lt;unknown&gt; would be more readable.</div>
          <div><br>
          </div>
          <div>Thoughts?</div>
          <div><br>
          </div>
          <div><br>
          </div>
          <div><br>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------2zZLFmMeMwnzXX0LkZJIbyoe--

