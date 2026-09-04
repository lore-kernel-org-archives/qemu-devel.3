Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8BEC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2U0P-00030w-Jj; Fri, 04 Sep 2026 09:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2U0O-00030j-A2
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:30:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2U0M-0001DR-EH
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:30:56 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AIS7s243782
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 13:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pA6acc3BFAz3F1nB6oy5X6NypGAdxPiDMFNLb3M3qMQ=; b=dAJTbeGg49nemjPb
 B51ajOsJhuuJpWsmE5QL0qciAfd5fJ5XGyaeWMLzuTuTjAKDJFXcYM80LSveQ5Q9
 zMR5QMoB2piEJ1h1H4m3s6bRnQGOBLFVM6f7Dz5XMw9HR6q8Y799To+WwNvg3usK
 N4JuG9VRICxXAoPSge0GTxwK9gbk+68xL9lQBOjqTojx9HTug3lwcCCkmZK7cZoJ
 gZTcyGi1Z4dX69ppu6cF65d+8o09ylxY21xhx7kWW65qDN5BXHqh+mL2+QcKgqvm
 vT7It6+iIJgoWPqWmlS3AEkbqQ69sUsWRkf5w0QhHiF7GZMtTszJDHvwZ7tW89CI
 kNvImQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfusx0rwx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 13:30:51 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9103f4ddce5so11402736d6.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788528651; x=1789133451; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pA6acc3BFAz3F1nB6oy5X6NypGAdxPiDMFNLb3M3qMQ=;
 b=JRmmnCCtYOjqz6odTxhaxfbFYYVL3FE9VLjiKv9YeEWG78qJww3BWGym5rQgQRmkXK
 1exBj6r7ZFWovfs0hF946XfyX2I+niDkr57PUHvmfdMGsfJ3Msh/z5wKS29BRKDv1xm9
 QwlZ0ww8e5tNFrDA8hKLcB7GQ2m9A4GfdWCB1Be1S/bAU4ab8ba2LB2g2/y7zDs7cvIq
 nARuFOWl/WKO8zPDjW1rWo5rusWV3Z6xQ4yj38m5jjoiBtf4BZ1EXqgx/O8xSLXbXTcS
 ncE6vaNCyz8vt6HIgnVBZIA6d6WJ623Ca8P+RlOhdU6YaXEIM50LdUX1jcOATLTAob/9
 jSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788528651; x=1789133451;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pA6acc3BFAz3F1nB6oy5X6NypGAdxPiDMFNLb3M3qMQ=;
 b=naf7pGgXHwl3ZSwwKIdmVkuflT49wgL8fWx0Bx/zfVdU+xxWtrLTSvcYSxIIreRs6i
 3IbSJ2gtmkzuGmM1g9wfXeAsFrfVfHNVTxxAq5ENPavdjrAChBAeQNDi2zUqdGvN1g9T
 kptrr9rkWrWjRGHHm0sBFF+ZlLHaEz5VC619iajkV+3zjLfBujlbZ6gF+7767cKkpLCg
 3BiICVGXdEkkpqS4r+YzGsr5SmlDCrAzKE+3GpI103bHcL0wpe/pvVr5xtXv23qka/Eq
 viqLD5Odoc0RY6k3aHwGD0ybDsP0F/DShNO9Qp/R4kjqsHdZOk9Ubv0Tv9mAk68zntnx
 CLnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDmWPKeB2ADzaPP8mnkhNYt0p+fj8zXPq3v+MZP4Jbk72wK7bx92J/VCNn65BCKZA922b4xoet3nOT@nongnu.org
X-Gm-Message-State: AFuF++lkpZ0MfOKC2zz8RevVeevAGns4IHYXFAQ1TusSoahl0lrFbTME
 2fYi/OV6J4Nc5Wk5B/xTyRYUnMZEYI3iNIWV2LOWkMTWZPB23TpeGbvPwsKd+xplBjI2CiNfnXe
 /4t5KbPamGl5rdFzvk8nZsrhWSruMoDnezCZN/cX8NMcrB486vMOhGzVrzw==
X-Gm-Gg: AYBFou3CjPC+JKG9d2/wNplKL0QfKo1Jy+IcWsPvV/AR2OeS4WNXM9S0py3evsT/LEJ
 7WvN0CHV0Ho1ZWbwDpRjOVxu2R166sQnvkNOX2nroGLKAfy9lYKUugrK2wpTi8WqEEHabzeH0YY
 CzTLyWPnAyGf/EZI88U7Hssismfm7047Ukj5xjEWOwuEuEkBJxMK6nCDEjnlhjhMQkqHSYNul6U
 M6aQ1fNALOyPmZl25Yd69B/0ys7aqt7Bh3hOUpTAPhId2L/b+A5nTCY424EfJOLAt2KGS4VeB8K
 0BMcnuxqe5zZSk9QrJ8baRz3qeQ9Y/KYNNFo4DWObd6UgJZV7S5a9VEKXi2g8gESc87Hj+Rd92P
 hSfUeTogwQQ649rrqMxWHqi9xiE7Y7vf0/w==
X-Received: by 2002:a05:620a:3e83:b0:939:49bd:58c6 with SMTP id
 af79cd13be357-93980433fedmr389176185a.23.1788528650514; 
 Fri, 04 Sep 2026 06:30:50 -0700 (PDT)
X-Received: by 2002:a05:620a:3e83:b0:939:49bd:58c6 with SMTP id
 af79cd13be357-93980433fedmr389169485a.23.1788528649849; 
 Fri, 04 Sep 2026 06:30:49 -0700 (PDT)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce58d1c9esm93143025e9.0.2026.09.04.06.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 06:30:48 -0700 (PDT)
Message-ID: <5457215b-c7fa-4ceb-8223-001c6f0ae3bc@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 15:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] target/hexagon: kick vCPU when re-asserting interrupts
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
 <20260903185622.3234171-4-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260903185622.3234171-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEyMiBTYWx0ZWRfX1A+hjttdTZI6
 YSyFL9yD6N6JpdscHLJlSVJ/AjEqQWJALwe5IGSNaI9DhZsXhD2EQiik9DeEq40E8Fk1lCoMlam
 dJOJ99R8ixaVuxuGfKn6Hw5nyRK9ZvA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEyMiBTYWx0ZWRfXyf9q4ZNCDM/Y
 gyRW2Cu7bc0OmWbWUyEAHl98EupFRpK1rCnaRpFztQE/M0SNYiRskUepiAxPp5Ds1PYfDQBPw2g
 Y2vYKUYkCXsXgrJZuDY8IM4uJVL4Tw+P1EqDIYlTYefhRXW0WfuaUsYo0bQ+6d5ZxQa1e0v+rFm
 5LhJjuiwkne/hxhZaKLBMWLvTmxPiLncW6d56BIqzqj6RmY+KxVMIRcLFHqzGEQcg+zC9Y4dmB5
 wiP/gdBBAceJEw5TTe++NwsUR9VcSe8wJq1uDdKMJa9UDPUxcxlbEmt9saREcGSUs5CCGYlZkRA
 LUE54evDZJ76FxZvGhTQA7/P2vzrFQUgsq5Q/gwMrD+lnsf00VVUdvMBnP5NI/mJQ/qz50K5vhl
 IjfufAUqTa5Hggc+ItDzegkilkAil96kNCH+FSU269j2Ii805pRo9NC7xRB692ZuwgZ/zvvrr3Z
 U3d1ACLpNMErrLQa2mg==
X-Authority-Analysis: v=2.4 cv=NenWEWD4 c=1 sm=1 tr=0 ts=6a9ac80b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VuQ1U3CnszahHFxVAiwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: -dHBRQF1izLWRf9JjN1c_uSwBJyr9QI_
X-Proofpoint-ORIG-GUID: -dHBRQF1izLWRf9JjN1c_uSwBJyr9QI_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040122
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 3/9/26 20:56, Brian Cain wrote:
> hex_interrupt_update() used cpu_resume() to make a halted vCPU notice a
> newly pending interrupt.  cpu_resume() is meant for a vCPU stopped by the
> vm-state machinery: besides kicking the thread it clears cpu->stop and
> cpu->stopped, and resets exception_index to -1.  Clearing the stop flags
> can undo a pause requested via the monitor or by migration, and resetting
> exception_index discards an exception the vCPU had already latched.
> 
> Only the kick is wanted here, so call qemu_cpu_kick() directly.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/hex_interrupts.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/hexagon/hex_interrupts.c b/target/hexagon/hex_interrupts.c
> index 7dde1294b2e..2b2834af95f 100644
> --- a/target/hexagon/hex_interrupts.c
> +++ b/target/hexagon/hex_interrupts.c
> @@ -441,7 +441,7 @@ void hex_interrupt_update(CPUHexagonState *env)
>               const int exe_mode = get_exe_mode(hex_env);
>               if (exe_mode != HEX_EXE_MODE_OFF) {
>                   cpu_interrupt(cs, CPU_INTERRUPT_SWI);
> -                cpu_resume(cs);
> +                qemu_cpu_kick(cs);
>               }
>           }
>       }

This reminded me another patch I'm carrying locally after
your confirmation on
https://lore.kernel.org/qemu-devel/5a6e6e71-7c0e-4cdf-a578-efebcd1e1430@oss.qualcomm.com/:

-- >8 --
Author: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Date:   Fri Aug 14 18:49:50 2026 +0200

     target/hexagon: Do not open-code cpu_resume() in _resume_thread()

     As the name imply, hexagon_resume_thread() wants to resume
     the vCPU. Better call the appropriate cpu_resume() method,
     hidding the vCPU 'kick' API.

     Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
     ---
     FIXME: can we safely remove "cs->halted = 0;"?

diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index 9ce260d7448..ced871f8ea6 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -225,8 +225,7 @@ static void hexagon_resume_thread(CPUHexagonState *env)
      cs = env_cpu(env);
      ASSERT_DIRECT_TO_GUEST_UNSET(env, cs->exception_index);
      cs->halted = false;
-    cs->exception_index = HEX_EVENT_NONE;
-    qemu_cpu_kick(cs);
+    cpu_resume(cs);
  }
---

