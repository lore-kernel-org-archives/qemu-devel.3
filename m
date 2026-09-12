Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41FDC88E59
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 16:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5R2f-0002wD-AG; Sat, 12 Sep 2026 12:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5R2U-0002vu-DI
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 12:57:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x5R2P-0006Gn-Rp
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 12:57:17 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CEdeYn2073313
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 16:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=aqDi7wOG3/gQTykv6ZHNutyJ
 LXNni8R8k1PEd0A62Ho=; b=kO/p/5tLGmHVhCQPTk1h25ts7wGT+vmtaFyYezLz
 FXughdJcoUwz8B1E8fOmSBxr5nVharWwpfYGnGxB2DhQZqcVs3zTbX2h0Bx6fbQG
 sINvHAv0trrkXyzw/PPvLVIr/iezJXESg/SMwVoTOaXQedJ1WJ1ywO47IQjmPsuK
 8cSEiPAU9PqZNTpwc385L5OmsSODd4WDFanHJ8YMonPXRZ4mdENttEh4gCD2uYe4
 0mFUQGTUSstiaZ96XyFBlfnNMbElsUZFZKS52DUVt2ozaL71kTCHojTjP66JxtS9
 RAyi+Xl08FUPg1Ph5eLzVUQCTP9XYwyu5TUOoKhxtGovhg==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmywh1dqc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 16:57:09 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66ce3040ea9so2779586d50.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 09:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789232229; x=1789837029; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aqDi7wOG3/gQTykv6ZHNutyJLXNni8R8k1PEd0A62Ho=;
 b=U1GdWZva/ydCfTj90TNOHIXKDbnMTqf893WwXgj8/T73z/TJeuUrk/GalPeqJ8uk3G
 DNt2aRVby7c5ZG6q52FCafWvhz3UYH4kJ1bvGAp7OtylyE9zEjP6vGHFv/RpgcgmKMWQ
 AK1KBsds72Z6h+63zrBrkkYII6YzpK5YTEcbkR6G65M9Uiz1Kwb17YnCVgMDDd3H5DuN
 P6IhsFwWFxaL2Kbz5xxGYAnRYOVEv57gtxc2tfEpc3UAFWEvgXbehR+sKvDONNlgSSNh
 VvxSeagoFZFqUi4ReAgioDtaTw6PQTb80Ki/UgL9X1Up/P9wAjPPCesMn5RbMxSowMob
 4LFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789232229; x=1789837029;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aqDi7wOG3/gQTykv6ZHNutyJLXNni8R8k1PEd0A62Ho=;
 b=SaIPnYi8Qp6arLJuZzjRwrtQ5TrESdbWDY/T/7045/T8ZJzwhOMLIltRP/EaDDNz02
 cBZEAt/Sq0aOveYnjWJxQ5ShyG36bxDsWzzQHfS0Am6jnJ6H6MNlm3WOkayTcr81vmWq
 q0lmHpjnUR2sj+QYdWJzB6zjK3HxKJ2bKEBmtpW/1gpBwm4x8S7aSp7DgNFIKYtxEJcE
 jRE2VmdrqLwISRPV0+YGMSOFsckjDLXfSoBz9gaTCkeXy9uZgbYD1vydk6UhR76hBHKl
 Y+ngnimHf3b+AzrzPYnpl+hAhpiY5SIq/Rnhz+IwdBijrskIugXdI1QYFgEyXh3SF1LZ
 Glaw==
X-Gm-Message-State: AFuF++mStJQVRGAyXmfUEbG5lzRFcsCwFZax45HRDaZ5hY7Os91FITxN
 nLxpvR7ZM88gzr0r7Wf8zh0St/xgTNMHVhYotNU2euyUvqTgS5FJgxcxZrGKSYzwxNzTgH0TYy1
 tNJ3Of6BPLcpgoC062912+0R2XN9Tb1EOYdWLXosp3HV9z+Gr8riFmA1CmQ==
X-Gm-Gg: AYBFou323Ax9dKcyPupKgYmFN6XbN9/ItsuCz1jlx4y4UAFFFFboLJaHtxYUY9xcu1t
 4RwPHMmt/nIVWudkOMHUbmobH27x1bic6ftPhShkQG19aCo8jbjJitpfyJYcP6YoPDfPsB36fLx
 wLTim35zk1c9YYh1bQ5XxzXFmA5y2lUEjm0nGxNxD5PiNx49NFab63xwh9npW5X4DAegxHkS/ka
 xDgi76esDj7k6apnx3fh3sa2Zapk/FATVtYCezu5JVj0RIhxDW854zfAEaxivyEXJe1b8qvFt/V
 pnhqOVU0dnrWNAGHGq0IDfFMU3uXBwDIMxU8g5PDJYSPWfDej1b2XwQKyhuAXMMBpWGaw6aQZCZ
 vKxVpm11P40tjI9k8nGy1twyBoPPRjS1VWq+KombWxhnIS1LANd9ytOpSPiOMBrY=
X-Received: by 2002:a05:690e:4894:10b0:668:9230:e266 with SMTP id
 956f58d0204a3-67135aa51cemr439381d50.46.1789232228573; 
 Sat, 12 Sep 2026 09:57:08 -0700 (PDT)
X-Received: by 2002:a05:690e:4894:10b0:668:9230:e266 with SMTP id
 956f58d0204a3-67135aa51cemr439372d50.46.1789232228151; 
 Sat, 12 Sep 2026 09:57:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:1d0:c210:5074:6be0:3873:8495?
 ([2600:1700:1d0:c210:5074:6be0:3873:8495])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67125db4fecsm2421693d50.4.2026.09.12.09.57.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 09:57:07 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------BfA4Z2N68ytXLhSxGEEH00af"
Message-ID: <3c1d0002-0194-47f5-a498-0c045d8dc69e@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 11:57:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] Hexagon (target/hexagon) Check for multiwrites
 in analyze_packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <8e57b80a-1f0e-4471-8804-257971ee781b@oss.qualcomm.com>
 <CAATN3NpNYm+uPgB5-vCTmFH9g_D3ZaaCA35Y7H4VjLcpkC3iEA@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAATN3NpNYm+uPgB5-vCTmFH9g_D3ZaaCA35Y7H4VjLcpkC3iEA@mail.gmail.com>
X-Proofpoint-GUID: h_dUyj6eDuVaCqBRfBWLk3iUMs-tsuyY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDI0NSBTYWx0ZWRfX4zUoWWOmuDHq
 gHeDR4Jvs6gHStkr/vbltVDk/mZ+w7KbQMv1RGc/sldzZdljCk9Ud7qsMdlQKWxtLJrsyxvrLgm
 3aCQy6G1tvaOLdOdNQnMxfyI19AQ9Wxg2KpE+fyVvZp5aT6GSCu7naaV3hgNOYps8l/QN9FnNvg
 X9Ie/uCQOHLLfsna3CJzFuSiPSTYxuABZbOQbHushi1mVZNSraQ4DPfZJ+vVpiTxQZ26zeaO+vg
 4+u5kMwxr0FTaa9Fnrqgiw7Ff6Hn+OInUicxdGozdkAZ+uPdhJfmvU9aYiPkS44GNSRtNjvUnBJ
 LVA/A2/Zj07k4Tm2ASfhftNBinfs/lkLE5rSYaqKD2h6ye96IbpBhi1bAcrXqy08JZeUKit9VrQ
 oo+6Oh4eCpmzDgGnt6CKx6w1aWk/kkhePpYMBZ7BjkAieCFOyELnfMBBh95kSVyi7dd1W/D9HAP
 K0WamFJOichTz6rRgeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDI0NSBTYWx0ZWRfX4S/IehRHgOUO
 rAgdx2O2YuPMOzPl5OPpXp5UnyYzgU5extDr/jKReulPjcqcbY1QesGTiTEjkcY3lJj8/Bf4tYt
 ty8HqP4ByHRxSMOX3gWIgSJXGJ1EYm8=
X-Proofpoint-ORIG-GUID: h_dUyj6eDuVaCqBRfBWLk3iUMs-tsuyY
X-Authority-Analysis: v=2.4 cv=PsUG/AM3 c=1 sm=1 tr=0 ts=6aa58465 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=r77TgQKjGQsHNAKrUKIA:9 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Q_wEWwuDv05XeMSf8WQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pGLkceISAAAA:8 a=dNYBVSffi6h_u8ApPNsA:9
 a=CpB7qjzBardvPV7i:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120245
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
--------------BfA4Z2N68ytXLhSxGEEH00af
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/11/2026 11:19 PM, Taylor Simpson wrote:
>
>
> On Fri, Sep 11, 2026 at 8:34 PM Brian Cain 
> <brian.cain@oss.qualcomm.com> wrote:
>
>
>     On 9/11/2026 5:08 PM, Taylor Simpson wrote:
>     > Currently, we check for register multiwrites during packet
>     decode. The
>     > downside of this approach is that it only checks a single
>     destination
>     > register for each instruction.  During analyze_packet, we can check
>     > for more than one write per instruction.  Further, we can check for
>     > different types of registers.  This series adds checks for HVX
>     > v-registers and q-registers.
>     >
>     > Note that multiple writes to a predicate register are allowed on
>     Hexagon.
>     >
>     > Changes in v2
>     > - Rebase against latest sources, including Hexagon system mode
>     > - Add checks for multiple writes to system registers
>     >
>     > Taylor Simpson (10):
>     >    Hexagon (target/hexagon) Move code out of gen_start_packet
>     >    Hexagon (target/hexagon) Check for GPR multiwrite in
>     analyze_packet
>     >    Hexagon (tests/tcg/hexagon) Add tests for multi-destination
>     >      instructions
>     >    Hexagon (target/hexagon) Check for vreg multiwrite in
>     analyze_packet
>     >    Hexagon (tests/tcg/hexagon) Add tests for vreg multiple writes
>     >    Hexagon (target/hexagon) Check for qreg multiwrite in
>     analyze_packet
>     >    Hexagon (tests/tcg/hexagon) Add tests for qreg multiple writes
>     >    Hexagon (target/hexagon) Check for greg multiwrite in
>     analyze_packet
>     >    Hexagon (target/hexagon) Check for sreg multiwrite in
>     analyze_packet
>     >    Hexagon (target/hexagon) Remove old way of detecting register
>     >      multiwrites
>
>     The greg multiwrite change seems to have an issue here.
>     clear_pkt_ctx()
>     needs to clear gregs_multi_write?
>
>     You can reproduce the test failures locally with `make
>     check-functional`.
>
>
> Correct.  There are problems with both gregs and sregs. I'll make the 
> fixes in V3
>
> Should I add a multi-write test to check-functional?  If so, please 
> advise on the easiest way to do this.
>
If you like, that's fine.  Thankfully the existing tests were able to 
catch it.  IMO tests that are able to build and run with little or no 
dependence on hw device models are suitable/appropriate for check-tcg 
tests.  In system mode, we can write baremetal tests that fit this 
description, and the sreg/guest reg tests seem like they could work 
well.  But it's a bit inconvenient to write the baremetal tests, so I'll 
leave it up to you.  If you prefer to have the multiwrite tests come 
from downloaded-binary cases that run in check-functional, you can 
contribute a PR to https://github.com/qualcomm/qemu-hexagon-testing/ to 
add test case(s), we can tag that change once it lands and then we can 
refer to them in tests/functional/hexagon/ (probably test_systests.py).

But neither of those options needs to gate this commit series.

BTW here is an example sysemu check-tcg test that focuses on translation 
and manages to avoid a hardware dependency - 
https://lore.kernel.org/qemu-devel/20260717214534.1203949-3-brian.cain@oss.qualcomm.com/ 
-- it's not landed yet, unfortunately.

-Brian

--------------BfA4Z2N68ytXLhSxGEEH00af
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
    <div class="moz-cite-prefix">On 9/11/2026 11:19 PM, Taylor Simpson
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAATN3NpNYm+uPgB5-vCTmFH9g_D3ZaaCA35Y7H4VjLcpkC3iEA@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <br>
        <div class="gmail_quote gmail_quote_container">
          <div dir="ltr" class="gmail_attr">On Fri, Sep 11, 2026 at
            8:34 PM Brian Cain &lt;<a
              href="mailto:brian.cain@oss.qualcomm.com"
              moz-do-not-send="true" class="moz-txt-link-freetext">brian.cain@oss.qualcomm.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
            On 9/11/2026 5:08 PM, Taylor Simpson wrote:<br>
            &gt; Currently, we check for register multiwrites during
            packet decode. The<br>
            &gt; downside of this approach is that it only checks a
            single destination<br>
            &gt; register for each instruction.  During analyze_packet,
            we can check<br>
            &gt; for more than one write per instruction.  Further, we
            can check for<br>
            &gt; different types of registers.  This series adds checks
            for HVX<br>
            &gt; v-registers and q-registers.<br>
            &gt;<br>
            &gt; Note that multiple writes to a predicate register are
            allowed on Hexagon.<br>
            &gt;<br>
            &gt; Changes in v2<br>
            &gt; - Rebase against latest sources, including Hexagon
            system mode<br>
            &gt; - Add checks for multiple writes to system registers<br>
            &gt;<br>
            &gt; Taylor Simpson (10):<br>
            &gt;    Hexagon (target/hexagon) Move code out of
            gen_start_packet<br>
            &gt;    Hexagon (target/hexagon) Check for GPR multiwrite in
            analyze_packet<br>
            &gt;    Hexagon (tests/tcg/hexagon) Add tests for
            multi-destination<br>
            &gt;      instructions<br>
            &gt;    Hexagon (target/hexagon) Check for vreg multiwrite
            in analyze_packet<br>
            &gt;    Hexagon (tests/tcg/hexagon) Add tests for vreg
            multiple writes<br>
            &gt;    Hexagon (target/hexagon) Check for qreg multiwrite
            in analyze_packet<br>
            &gt;    Hexagon (tests/tcg/hexagon) Add tests for qreg
            multiple writes<br>
            &gt;    Hexagon (target/hexagon) Check for greg multiwrite
            in analyze_packet<br>
            &gt;    Hexagon (target/hexagon) Check for sreg multiwrite
            in analyze_packet<br>
            &gt;    Hexagon (target/hexagon) Remove old way of detecting
            register<br>
            &gt;      multiwrites<br>
            <br>
            The greg multiwrite change seems to have an issue here.
            clear_pkt_ctx() <br>
            needs to clear gregs_multi_write?<br>
            <br>
            You can reproduce the test failures locally with `make
            check-functional`.<br>
          </blockquote>
          <div><br>
          </div>
          <div>Correct.  There are problems with both gregs and sregs. 
            I'll make the fixes in V3</div>
          <div><br>
          </div>
          <div>Should I add a multi-write test to check-functional?  If
            so, please advise on the easiest way to do this.</div>
          <br>
        </div>
      </div>
    </blockquote>
    <p>If you like, that's fine.  Thankfully the existing tests were
      able to catch it.  IMO tests that are able to build and run with
      little or no dependence on hw device models are
      suitable/appropriate for check-tcg tests.  In system mode, we can
      write baremetal tests that fit this description, and the
      sreg/guest reg tests seem like they could work well.  But it's a
      bit inconvenient to write the baremetal tests, so I'll leave it up
      to you.  If you prefer to have the multiwrite tests come from
      downloaded-binary cases that run in check-functional, you can
      contribute a PR to
      <a class="moz-txt-link-freetext" href="https://github.com/qualcomm/qemu-hexagon-testing/">https://github.com/qualcomm/qemu-hexagon-testing/</a> to add test
      case(s), we can tag that change once it lands and then we can
      refer to them in tests/functional/hexagon/ (probably
      test_systests.py).  </p>
    <p>But neither of those options needs to gate this commit series.</p>
    <p>BTW here is an example sysemu check-tcg test that focuses on
      translation and manages to avoid a hardware dependency -
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20260717214534.1203949-3-brian.cain@oss.qualcomm.com/">https://lore.kernel.org/qemu-devel/20260717214534.1203949-3-brian.cain@oss.qualcomm.com/</a>
      -- it's not landed yet, unfortunately.</p>
    <p>-Brian</p>
  </body>
</html>

--------------BfA4Z2N68ytXLhSxGEEH00af--

