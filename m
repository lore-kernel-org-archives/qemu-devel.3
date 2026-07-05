Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64349C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUnN-0002lc-Jh; Sun, 05 Jul 2026 17:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUnL-0002kb-Ls
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:54:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUnK-00076T-5B
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:54:35 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665Hi3qU2353119
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RTK/mFnt7g/C4NSmB/Rhp/pgPja7/UGFxM5qN1XV+Jc=; b=JyVgBmStB4hjfAi2
 jVKpf8fIQtTvnUfrnN5QEbIcz0/DJ3vI9OLf8Xbr4TP52EXlPKM4uo7ft+NatTzt
 qMZlZu3Dk/VfDLcmO1dzp0uWD3QUQIqhiLal7l/mFIz3wWfys7+yv2m57eamG6rU
 3oEgWjln2CIs6q1ICZUgKDV4eFqSp9ynYjYkHphfkVO7bK0XTZG3kdlCNWOzn3TV
 LD88gXK4G3ETHHOVWK+Xa5CsAzU/R873S5dzbx50mRQ19gfHhVY4p5HKGVsjZCuw
 uYFNgDyfYtq9snZdLvLxbu6tn8XRsq0Cg274HK1bM+gehjH6IAQyjUk4ST4ggH3e
 Ni2vLw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4sukxy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:54:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915f6ff639aso443449885a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288471; x=1783893271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RTK/mFnt7g/C4NSmB/Rhp/pgPja7/UGFxM5qN1XV+Jc=;
 b=TqOrch1xcMtyhGo1xEtT7d11bBGsuUM4JfotKiMZpvn+8Ye7rKiEWIN7PfBx0O4WaP
 xUyd3w0ajKPZkpG/VecBHy6fzpllIyHL1HuuohAv3sFVq8LqKVFXaSqMrH5lxxe0Rzko
 OOi+VUG/y0vGaCAtDeKiFSMyHev2iAseTrYZ4PwPrdLWoNVwqqQV74lVIk+ur8k+UiAe
 N2V5Kt+L650i9nv6MUW+P7EUGBqArJVaQzy4rCJ2fHHg50XJU5XYxPFbA45gtZEGOh2/
 xrgY9L63kbeUlr0nmEbsm7XcbnsZnzQkkzlP43fR/9uzb68O9ki8qkYqty5p1dezA2SU
 xJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288471; x=1783893271;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RTK/mFnt7g/C4NSmB/Rhp/pgPja7/UGFxM5qN1XV+Jc=;
 b=bUARAHq1HStUQFdrZ+WF/4r1O6pFJUv3Jlupl57sWdMM35AYQNG7ANV9XLCCLQ/buS
 ZS5PZMQ+AwU6Fm0VDy/wkmRtnqvgNriDzrGCWxUgijb+XZkvAqlWmlclmN0pW0JQEk/O
 NIFoY3VtByXs9wN0ks2d38wL9ZIyk9W5/9BkFX3Pvn1A71JU8BUp8fiFKtwIbArgq99+
 RibO91HpyTNz8iN5YJVx9ECH2WQD0UiPMdbA7LpqVLHd/sQ7NOaUeg0d/kDObZ4L7dDN
 d9PIFrug/eCS8OiOx1wbiuUeQvRSpvVyKkTbidor4YPjs8snF5knBtRNRMxOehEfHY9Y
 Pckg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqycJcbeJDTB34P2Mof8iGoeE5I5I6IyUm2SvyqNf019aR3KQTmpodMetL1I+pdORBHWo0k0HGSNgE+@nongnu.org
X-Gm-Message-State: AOJu0YywcWzUREdzuC3R8uY9ThlSzpqUkxz6AN7hSAjmbQ3l39aLG1WA
 CIaWsxPt+3xs5r2hJQlLo0qwIkE3FnBW/k0OQXYzZ6NYqfFuSbD5uTL1CreFLM8PPd14RQcq452
 5zgVLRQDkiq/fxCAnok3RJgQS7qyDW+NiDP+sp5rkWrTsLZIiV2oXSgNiFw==
X-Gm-Gg: AfdE7cldOOO4rwIRZl0VBZZ6E+ZuxG13nqUWvpHBqlwlw+ze3c3qNF7nzFsDmL++7LA
 dVsPAqYXsbZRBMSjvMf/wVFZHy9ZSXZHI4jBexh7d6Kjqt779/J8A9bcMuLxqiYY/5IScG2zfpi
 /PS6FVc0eRy3pnShazCCxOuVM8NmINAmlYGICpW1vtvJqlzUOuAJfrbjsi9oaJCSLN+nCH9HW16
 F9grD2g8rpAxn++xuI/cNRtYjRX3+2DQOkiPL0JNwmoR86/rgBumg9XB97L5EthPML2RiKRmrbj
 WibSvvvoGKDxI8PvaLaW4T+0ABJLgiOkBUUl8+ZHb9GAJU17HplLycCvMGtsQ2lrwlCA9l2NzCL
 1rHzNjx3+/cPicHrLiWD1KXYt89tVxtaJ12LE7MHIX2TeZM2N7n6Evbbbo6t5vw==
X-Received: by 2002:a05:620a:4710:b0:92e:64b6:d42a with SMTP id
 af79cd13be357-92e9a2f6c4dmr1097999385a.14.1783288471367; 
 Sun, 05 Jul 2026 14:54:31 -0700 (PDT)
X-Received: by 2002:a05:620a:4710:b0:92e:64b6:d42a with SMTP id
 af79cd13be357-92e9a2f6c4dmr1097997685a.14.1783288470828; 
 Sun, 05 Jul 2026 14:54:30 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccd9d607sm294013755e9.2.2026.07.05.14.54.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2026 14:54:30 -0700 (PDT)
Message-ID: <f1aa8bb8-79f4-4dbb-a21a-575333cff5b4@oss.qualcomm.com>
Date: Sun, 5 Jul 2026 23:54:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/33] cpu: Define BreakpointFlags type
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-s390x@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 alex.bennee@linaro.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
 <20260703163757.55500-21-philmd@oss.qualcomm.com>
 <498d4984-58fd-488d-b504-4fbee70cfc70@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <498d4984-58fd-488d-b504-4fbee70cfc70@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX2yRVMpXbDOsF
 fSQCppLY2/xo5f+RYQxW5QtxzkDe0klh08N8dOT0k0NjsrDgEhEPVc9Q00nQkzeUIBfAddLNxrl
 2+rNnJ3G8VoT2keuE5W39F+q0D4P1UM=
X-Proofpoint-ORIG-GUID: P0bU_9pTglqc_GrPbESTLoOUIIlLNUsG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX+3WFDOOC9Z6A
 fg6BAWe20p1wgcZ5Rxv19k6i8h+KLtwsSni1aRXoXvl4GoQOkjuHt56auHkC56xqQw1uo9syivn
 zfm8Mms0Ds20V04HeBW2oQpJZ7yRdZyFJ0IRuZbiQB9oTvyL2mnY2If7ktOo9oDvmD4JqDnRmFf
 GVhxFWCmWO0qWujyeRwdUJTJMRbkbUk22KP/WmDiG/Fb7Y2p+vIYJwxXSw+tU4ezWcZVgKcVEC5
 rnYjRpnIXZrELFGTE2lGxTFfGE8fm/b9BIdnhcRKG8Pc1rkjSg7HLZ3vjXys1ib7oWFsrm0R0Od
 NpcXJyXFcK5wzhFX0rxsjzMzamyXyYtTpn74rhfp23k+PRSz4mH0f1yEHxqkzIP59wVbTpm+4H6
 g3j6z71nCEtlNitu2MEVF843qsDpLNibhP1+tr9KtOMOr5uMcYr4gUTZR6QbgrcmDE1fXHfyJAu
 esRyVg7jE231yShVhaA==
X-Proofpoint-GUID: P0bU_9pTglqc_GrPbESTLoOUIIlLNUsG
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4ad298 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=s7izqW9Ui5_dP-KyNpIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050237
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/7/26 21:56, Richard Henderson wrote:
> On 7/3/26 09:37, Philippe Mathieu-Daudé wrote:
>> --- a/include/exec/breakpoint.h
>> +++ b/include/exec/breakpoint.h
>> @@ -12,6 +12,7 @@
>>   #include "exec/vaddr.h"
>>   #include "exec/memattrs.h"
>> +typedef int BreakpointFlags;
>>   /* Breakpoint/watchpoint flags */
>>   #define BP_MEM_READ           0x01
>>   #define BP_MEM_WRITE          0x02
>> @@ -28,7 +29,7 @@
>>   typedef struct CPUBreakpoint {
>>       vaddr pc;
>> -    int flags; /* BP_* */
>> +    BreakpointFlags flags;
>>       QTAILQ_ENTRY(CPUBreakpoint) entry;
>>   } CPUBreakpoint;
> 
> Missing the replacement in CPUWatchpoint.
> 
>> -void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
>> +void cpu_watchpoint_remove_all(CPUState *cpu, BreakpointFlags flags);
> 
> Please don't rename mask to flags.  Several instances.
> 
> The arguments that are 'flags' are installed/compared exactly (==), and 
> the arguments that are 'mask' are used as bitmasks (&).

Indeed.

