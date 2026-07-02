Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD580C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHSE-0001a4-Dd; Thu, 02 Jul 2026 09:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHS8-0001WY-Ue
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:27:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHS7-0004tA-5r
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:27:40 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0arp522887
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 liPCSW8iLXQihqI3hMeeMDE8ZEveD/NlgFIC52K9pCo=; b=KhMWifhTu91ACf1/
 7K19Y3sHD7wUYXhazzbpb28ocofmSpakFGF8UcbnmaWvVRr+n/HM8zI7D9qPsUZi
 XVnD5DyP3MWYgh5Y0HzQchpOgUes1jzwCVyPTocXqbN2h8T//jsoNg32ZTxBRU1b
 5s4u5XOsWe47eHJKKPEB6kO01PULp93ECCznV2Y8GsiGfRrDOrfl19oB6op52OFl
 4MuL/qlNOGA/wg2i3+X9IQAoQ85zeCOF3RcOMvZ8TKII/r0hxm2Z63nPy49epYqb
 SbvjlmDxyyC+w7447/zywQKYkSxqEGYg/eg0flM/EF0UXTYKduZ64yo7HZWPjQKW
 qkYQwQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5541vww6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:27:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-91ed0e140c5so381944985a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782998857; x=1783603657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=liPCSW8iLXQihqI3hMeeMDE8ZEveD/NlgFIC52K9pCo=;
 b=XHF6WXkTn6xQngHo/UEkj/vx/oN2/OyxqogXwb01WMUdoMgWDmOZGStx8AUqejOJOy
 472x+nJIlurk9u13TI04Res/TFt1dIgEEgNTSDn+XYD7oLTlKutfxFuDHQN+G0aSfYgv
 1YOsd2su86z50mrJwEudKJxDRS2dEyFbAUfDLbDr/EY4+UQY5DwXodTGf1SB4y9q5H1U
 wX6dsdS7zZ6v7nn7rNbnXG4NBEgLNz8yQxq5hkF0vAIRJP56fN9iZTa76GbiLDfyd2wl
 uvXlxNaDEZBAtAY2RRAU4atSEC+JnYeO879/7YQ2yhGdehe2AOa+UYCgowun3XS56vF8
 OqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782998857; x=1783603657;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=liPCSW8iLXQihqI3hMeeMDE8ZEveD/NlgFIC52K9pCo=;
 b=k7W5N9YE+RFRJFvqL3tPJxOBnBFS2AB2mrjneG1kl8t7ybfnQP1IylLhSIjtSNuSFH
 1k37e9LjMLIhbXiLOkEArG4nKO+zYXVO9r1SEV8BfO1RUPMpLj32pRs9bRvgKikcsQ5q
 eued+9lRTS/Xt2pacqxFnUYfxojcs6uPWr5P6emrVrjRjmBfnIHg+srfP6el5SLjh9Bx
 Pb7UYsjUv+cI7a3w3ol10UxSiUFnrhsevJjXl0qSg2hHi/EJyXW3HKnWIiu4wwXyr+wf
 EuoKSmXsC7gyYK3BkzTomCanh13aEdiVrR/fE4EyLvrXUKuhcFjqFB41lKnWbHCAfvFK
 RPKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GbNCoME/WSSbwp4sWhjGXbtRjcIpF2q4vVOqirEaYjS1xRtyJHk3d7RQNRkbxbm+wG0QyBZG7Hfn6@nongnu.org
X-Gm-Message-State: AOJu0YxWmUxcFLjZs43iJEeIRx7zOeOh0ayqM6AScvNYNdFpRxIDHqDo
 yeXWXe3G012WfbGZcwekk4I6zwTARMrGL7ApzHLFIwxYI3V0NWKFlXoLzJt1LIqMqXaJXRf/RMM
 JdxjxKK6JJdmgCOyC11ShLORnu9ixZFNUhkw0WnlQNmQHi+iERGwVEAUdhA==
X-Gm-Gg: AfdE7clvBdZoNUmu2W6HQxug+CIkHhjkcOuX6/HZqn0epX+Lcq8HPWj8B+fMUMw/H3C
 JNsGNIGdogANI01XqJb0reGbVIE3h9cPvy5RDfPQ731qsOA4BDYJzEUsae3lyar0nr0ojmXcw48
 KWEgLmFjbzrvfh7Tq1wDCqm0RDDS+mcMygf2ZHiTHHNSkFxYRVjNRlzFPGk4weHsQl75lJ7Bcoe
 itPLezeDaSRXiDQpBhpix7q43tD39ORTz3yedbeoN7MLJqO9mbfqnlQF6IbkxaLI4VZp29hoNS0
 EC7Ta003z0uFVan+OZ64JRMCVqe+cqhHaVDlseRSOW4cyKmmqxkVuV9Hs+wv1+LtqdSGt6Yi3gU
 pKolF9wkoG5es36OBs/YT2il1mftU0bAWwZ07u7ve3nFJ
X-Received: by 2002:a05:620a:470b:b0:92b:6805:918e with SMTP id
 af79cd13be357-92e7853ecd1mr738768685a.70.1782998857453; 
 Thu, 02 Jul 2026 06:27:37 -0700 (PDT)
X-Received: by 2002:a05:620a:470b:b0:92b:6805:918e with SMTP id
 af79cd13be357-92e7853ecd1mr738763985a.70.1782998856959; 
 Thu, 02 Jul 2026 06:27:36 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f46e371d55sm26211606d6.10.2026.07.02.06.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:27:36 -0700 (PDT)
Message-ID: <3e68b894-1dff-4180-80cd-9ed0f498eebc@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:27:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/33] gdbstub/user: Directly call
 gdb_breakpoint_remove_all() in user mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-21-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-21-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pbaXpqq5SQdEsMbzYGEvsVuBd1ZQ_RiS
X-Proofpoint-ORIG-GUID: pbaXpqq5SQdEsMbzYGEvsVuBd1ZQ_RiS
X-Authority-Analysis: v=2.4 cv=Xbm5Co55 c=1 sm=1 tr=0 ts=6a46674a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=mAmSg7GrgAbAGglQsysA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0MCBTYWx0ZWRfX/bsWlg+/BTRE
 ExFcqD1IHMUlgaKhwbQQf6IHcAz3S5RqYTFU/6Xv3TzWdrRkigSWNIkNpQcoylf7w4VTz3daarS
 uLj9M/84SH0zmXeh+vxxgwxpwJMZX6M4hTXsK2nJZMBRnHY3qY6P8FWefTKr3d42FqYKqOe7BDM
 tjI/aYojxcb/EuVprny6nTBfNf31RwKQonae6LYkBLhAujM8YyuL8kcV99UomHBzNAGVO1shY7z
 osFGMhCFXS6BYVcBQgs0jlTIKSE6zLhXtORHt92zgHdLXa2cR3abeFhGq8USvfIZ9raXYpiDT/W
 ETpoGQCdhu6WDbPs4/6TFGVQBpdT4Odd3Kuj79XRqm3LInQN8iqQcHTFAv07LCwP67f4r1aZk9d
 xnfPke/xex48psl572yX4Jnk38WoyPj16NZn9WB4wkrSyDt6AlrXWwt3mvC2PhqqYly/r3ERTCv
 hfwP7PtxSb3aMR7T6fg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0MCBTYWx0ZWRfX+3N/Veza9a0l
 ipFU+so0dSwUMWaqgOkZPiePGI5r41odDgBU2gRuozhHvuO5uc9ox4Q+AC8r0B027KxgyRW8G2T
 etVPT3Xa2CXQkn5lA4/4DJ2WewVNBqw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020140
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 6/30/2026 7:00 PM, Philippe Mathieu-Daudé wrote:
> No need to deref external methods with unused argument to
> end up calling a method defined in the same unit file, call
> it directly.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   gdbstub/user.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index 299388b9f71..90d6ee49fb5 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -557,7 +557,7 @@ static void disable_gdbstub(CPUState *thread_cpu)
>       close(gdbserver_user_state.fd);
>       gdbserver_user_state.fd = -1;
>       CPU_FOREACH(cpu) {
> -        cpu_breakpoint_remove_all(cpu, BP_GDB);
> +        gdb_breakpoint_remove_all(cpu);
>           /* no cpu_watchpoint_remove_all for user-mode */
>           cpu_single_step(cpu, 0);
>       }


