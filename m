Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E88C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 06:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x760D-0000ti-4T; Thu, 17 Sep 2026 02:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7607-0000tO-Mr
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 02:53:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7604-0006sx-Nb
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 02:53:42 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60Aco091772
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 06:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VJNNRcKjy8Z+F/Oz3Gn7qvsAvRdIWU11FTvWV/qxmBk=; b=KF5hDlr80Yr1wAHP
 3HYds6JlBqHr3c+/7AqJGkklOR39SLInsi4cbcx3wY2klJobvNKw8eMKCxWjx2Dh
 /jqa9kZSmpN/3URK/tzH1GmYtFyn7InPKybcrdVpGzReaCevj0aPc1obBS3bFRCq
 AIrwlqQLvouseXMFOFSNkvy3etu6JS+0lW80ykSKUFT7xHVJmQM8WzXTbqSY2kL9
 IgIiXdWClALv1Ha+TZysRT5B2vghLrnfqB/0Ur/KlrfJK3P3bBFU9JYZzXZ17OwK
 6GU9+DefYFk6lre5CxKIvQfzCFujBRl1A35rgS78Hs9/IeawxsSCk+Np3J4AuA4W
 +fBVRg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gr8uw0jke-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 06:53:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39e3dad7ab3so462686a91.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 23:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789628012; x=1790232812; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VJNNRcKjy8Z+F/Oz3Gn7qvsAvRdIWU11FTvWV/qxmBk=;
 b=CrLe568cunCf2rvVxCBP79CACe14rnDJdwGqfMAcR6Kg22G7mnnTbc1injdp65pa5r
 0N6eCng3MWt+O3KC7gM9uV8BSh/KRDnm8Mnil+/kcKyZuN4WZRZF9MLFACoqI2eWlyNA
 3jCduCl4/ys7aKYRE5Ck+wzAFe9j+FXh7bIsq+0lOzsDiXEK7vrvp+Al8n8rwzDoSxyP
 TDvMVsoriQVEArHDYfvPT/0erppB64prLpcq5C3/K2ddstAY1IuwP7LXuwPzLOdal3ZG
 GnR8VpZ6dTcgcM5ZPGtiEFzR1xdgdBjYsRulzgLIzUArriL8/nCYTNEy+hgk4iUey2KY
 d/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628012; x=1790232812;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VJNNRcKjy8Z+F/Oz3Gn7qvsAvRdIWU11FTvWV/qxmBk=;
 b=xLlQUdFymrpP8N96NTLHGqR/dSL17X/fHuUQ9nsM6u1zbAvIrRQLFkW5239eVVLbSM
 vW5w2oRl6Q77737kdKE4gq5EWNoCuvZ6e8bLingFoB2j8IVzJoudidmkuYIhwPWAIfm/
 uUWU3Dw9QhZQOfuXUgbS9VjgASMJ3/NQExgclM2faxaeh9Cs3d1x8x//K0bs1zhsSbW9
 PxhS9kj4yhSkk9ZFVYLD6vNMalXzHrTXHFULhVckFb3PGw8ZMiSyhBvf+ipo6W11zKti
 F4qGwcB4aTXCHF7pJ20yddIcNvr3g/XxOx9BIBQCS/W34Zz/InG5ekOBEmLF5NzESfmv
 w6YQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWhb8FJ4snGt40Vt9lNG9qsApWA8dFHndHNeorO1e2Ayzb92ggbBB4eOVHVVUHPcsFyK8tMLtPcAii@nongnu.org
X-Gm-Message-State: AFuF++maA//mQ5EU+NQdjrgWH4PzWygMdV/drjBrhWNfv9qPUAB197k5
 SXuMdsA8DN6fgEcikCf/kixAy5tFspImCOFDEgeAt9AdZB4u0nAdIQHztLhkKCNssy2NQMaGob8
 dbX/S75fpq8Q3AfA2B+oZU6roBsfhltvr7Wp3o94gfnLMqzLChx4YArhpTA==
X-Gm-Gg: AYBFou2vngcxI6dW7NW5b5WDx4M7Dk/Dq95H1fSzYug1kYbTCpEN5cyTn3VuIY6YLpc
 9kdFvdRpAJdv+oDtklm/PJ7RH4beUaFInr2P94B0gPuxky853ZAcVsD7FCUtzKW8RtryKLckpeZ
 udenDpqYA5smAhW3QTdutOrOhF36Kf9B538TkbITipttaaZYLc6+mSkmPCG9y/Ax/tM/gyA73PJ
 zBtubEeLbc99Q8UZUe5jYTU2cd+mxwoTOofplY5c4VnYGlTzAr/8K/avIeixip1r6STJBPSnBzK
 2W54mR5KrekSq69D2mjAAuxWDV+HyIfkbY/bLUNeMiRBN+X4kTopEO/bB3mBIMtIlRB+iRfvl5k
 c+KfN0gn/tqJg9j+fFRuE4KA7Akv2oNLSwlfOrmb4m/jsy9SeDz8F7iBoRnPTL8haJk3Y
X-Received: by 2002:a17:90b:5810:b0:398:9c39:520f with SMTP id
 98e67ed59e1d1-39e1e4923f6mr12898220a91.15.1789628011702; 
 Wed, 16 Sep 2026 23:53:31 -0700 (PDT)
X-Received: by 2002:a17:90b:5810:b0:398:9c39:520f with SMTP id
 98e67ed59e1d1-39e1e4923f6mr12898167a91.15.1789628011213; 
 Wed, 16 Sep 2026 23:53:31 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5a93f1fsm13317596eec.11.2026.09.16.23.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 23:53:30 -0700 (PDT)
Message-ID: <04de7ba1-bc86-4e5e-9a6a-6aefa262094b@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 23:53:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/19] tests/tcg: don't define tests when missing
 compilers
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
 <20260916153013.2134555-10-alex.bennee@linaro.org>
 <863e1541-31bd-4b2f-ba78-0f963138c0be@oss.qualcomm.com>
 <1af97e15-d08f-45e4-a4bf-879667a43c0f@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1af97e15-d08f-45e4-a4bf-879667a43c0f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: r7lp8GrbBzpnaGSObNItGoftQGEO0Dst
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5MCBTYWx0ZWRfXwCxnOT+PTINa
 Bj2lrs2qXg46OiPq5R0YVR013+XF/G0qPqaSeq8E0/a+cLDvKGkybL3g8cV0oFuhmxsuTEDzI6m
 FRDL/Mt0ScdOXbsvFlmApmkC7xWtdYM/fHT0KYnNtFiL23MeeluD7ujwRgUYddEryCFAAspfMh3
 GSRNxt2y8iQSN6d95vodoHib1T/3tRWWvSFUJRs2ojhYTcp/0h14tqF0MCjsWFDFzyp8ip+czrj
 9zAqaG6iPmIgiGhzPYoOFysaJMCFAev07NUJjDFr4iLRI0NCMV+APzVXH/lBz7zx5VqOJMxylWB
 VS5adnvITvIBR9fCfNJKQ8gLEF84NsC4Hvizw9ct13gCjwNfQu+hffgyMVrE6UJc+qlpfYNKbUb
 fggJD8SHCxoRWJMWSImOWSEmzZNsNeSePhnuDKXq+ImxQlgcRhVpEubl0GhshvZYrg7sNTIABfL
 INjG+bgyaN3MwlvDMtA==
X-Proofpoint-GUID: r7lp8GrbBzpnaGSObNItGoftQGEO0Dst
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5MCBTYWx0ZWRfX5whNU6w32t/4
 pyssITKnYRIw6RSeOAUjJxvf7q7Xg2DkujTG0acsbfhsFoXrf70rG8q5V3n82xd0nS/XmFiYnOq
 WGyye7tn8qaKK4/6hWP/FuziS5BeVZ4=
X-Authority-Analysis: v=2.4 cv=dMUzC+Zb c=1 sm=1 tr=0 ts=6aab8e71 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=RQe5vbOVnruMkaE1YSEA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170090
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

On 9/16/2026 5:00 PM, Richard Henderson wrote:
> On 9/16/26 06:41, Pierrick Bouvier wrote:
>> The alternative is to not declare the final test (test() call at the
>> end), in case cc is not present. Reuse skip_test variable, and check if
>> cc is present at this step instead.
>>
>> This way, we keep benefit of checking meson.build, and the benefit of
>> this patch.
> 
> Good idea.
>

Implemented with:

--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -508,10 +508,14 @@ foreach target, plan: tcg_tests
         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
       endif

-      test(test_name, env, args: cmd,
-           depends: test_depends,
-           timeout: 120,
-           suite: ['tcg', 'tcg-' + target])
+      # Do not add a skipped test when compiler is missing,
+      # though we still check all tests are correctly defined.
+      if has_cc
+        test(test_name, env, args: cmd,
+             depends: test_depends,
+             timeout: 120,
+             suite: ['tcg', 'tcg-' + target])
+      endif
       added_tests += {test_name: true}
     endforeach
   endforeach

It can replace current patch.

> 
> r~


