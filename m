Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00B2C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAG5-00017j-GC; Tue, 07 Jul 2026 14:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whAG3-00016f-34
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:10:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whAG1-0005cU-Aj
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:10:58 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTLnl018214
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /o8HkvavQ3xIiyENp402b6pzpwfiDy/rXl1+rUNHS+0=; b=M/h2g/Wm9d9Jx5Ce
 e5DEvltbkJRRZoKaPoRaV/+jsqaW7zzkeb7hEu4nJwVDGAj2q7MWW6k/A+UFEATH
 40zyp49qaVT3E1nKntMWH1hNtSgrRTR8FNEt7cfLR0OcWlQtXLorDVzudObNeeTw
 aOjpKiIzEoT/wDJNGyt8ZO6recrsHD6R2lHic3QvpvtBwl4D0gKCz0jjZFJt7SPi
 dciDPoxSNQt/ZziVJzarQ4w3OhlD19Od0Lxib4XJDzch0+oZh9Np8XOVox3o39lf
 oE89s/O0KcgrKSIXioMVRZY+r4RuUDLp2w7z0MvoU3CVXV9DA30Gx6+IadDF4K2P
 CYm14A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8wep2mps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:10:55 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c96b4f58ddcso4106446a12.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783447854; x=1784052654; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/o8HkvavQ3xIiyENp402b6pzpwfiDy/rXl1+rUNHS+0=;
 b=CvJ1z3Qrk8R8cciAbfw/hftMoI5nBa6GeSrwvouDhiJH86Uz5ddKtHkMgTSvEP2xDR
 AEO96E3iqofVi/4cFMcKi0eyOJ4GLjb7ppM8wKmRn+TsNrI+4SJZbxjHr5+wyinEGZAU
 aI+VEAkXe8UWCIAxXd8++6Qg4E7Q8SR4OEBDRkiy9q+WXlr5jn8RP1S6MqwWTyl2jycu
 uK1JmYavJyfU5NmqCdpswlR8Cp49ItyHG5npchTA8m45uabIPKf5FVpdDlT/ixqgcsec
 X+AljrCKDakH6kSxdEtaEQjNc53m5HOTYf7s91U7oN/iZkQK/fRdaJzdtisMuqunldn3
 PX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783447854; x=1784052654;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/o8HkvavQ3xIiyENp402b6pzpwfiDy/rXl1+rUNHS+0=;
 b=N34wTCpbss+0AfK631kg3PUX+FJockF1Vs4vHmeKsZWCL5SfdmUAYGLDjXkBoyijqd
 /FD3z+g59LjMFIRwHzkb1eQxZKAbBOR4H/htUIdHnzg9K8jyNRc5IKgjTUs2bHMavizv
 NSnBeCN5u+5DFtbCm4u8E/ThKG+qYcQk8FE8SNeJJBIsS9Jmf6stmUEXIKwXXw3oSELt
 uMGUt/IXc+fLiIPFzs4b6qkcTwppyzLuzK8OagqQO1U88KzQQFJ2VUV626z3pB8bo1vk
 CN0rC/XGCAOYWURfSeJygAUGXWQYuIDpeUVR91TXQ1x74hi9h/D/TnkSbts2RnBWEQGI
 9SRQ==
X-Gm-Message-State: AOJu0YwlUAOIKo3JHelWDnRzxnIur3gxJLj10GSc40m2nPXD+5RXKPZn
 w87Lgd11ZkwTcr+77/u/2kTH0oDPr4e2q4TpE4ECcMXVjfiBY/H1YvjStXApY2O1lFcL7gCkYrg
 nw0ZwdZrlzF/bSFAFOPE2Q6XuurQF0FaD//ZaL0OIZbeXBPPnjBDrj0wnZMocZTwUTA==
X-Gm-Gg: AfdE7cnN7TvErTRTG+PQPh4yqhf0EqRN4WpxAugr5vwhvCr6cTSdClXdiluyv4WE29+
 nDujBJ3m4KIdPLIz8g8EyyjyndGDBZ85xt1AVbUNzwBE/JfdOGqqSIBgRkKris59X51cU5FvoVg
 CfhTCbKBKtr0StBMSBU3OrYBR8+D4N1zIWsrMB1NI7SLE9rUIi7ZmTYapCgnubj2jYSQVNEwIyd
 XxNopFiWEiT+20XxfeHVxaQ6mTzJsY01aEUI9wF5KWBNUpNwXzVfoftlaqGG5Js9hH4eBlugJbf
 KESwv/wXT0VCE9+GMRRylW5JzuhC0x80vS0R4hzh0GrO9vcdzysGOmUxabp880f+Yjk1FnPRucX
 gy7jLBgGLljzIoMqwu6rBJFVKHfpUonVAi/4cNym1XeYCtvvqSrama2S/OjZy70WbjTdVua676c
 Y3O68=
X-Received: by 2002:a17:90b:55cd:b0:36d:5d1c:c4ad with SMTP id
 98e67ed59e1d1-38755478040mr5629072a91.9.1783447854543; 
 Tue, 07 Jul 2026 11:10:54 -0700 (PDT)
X-Received: by 2002:a17:90b:55cd:b0:36d:5d1c:c4ad with SMTP id
 98e67ed59e1d1-38755478040mr5629023a91.9.1783447854022; 
 Tue, 07 Jul 2026 11:10:54 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118389d9bcsm3173381eec.20.2026.07.07.11.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 11:10:53 -0700 (PDT)
Message-ID: <84fddbf3-e523-4a23-b95e-cc6102e459c3@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:10:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 87/91] tests/tcg/xtensa/crt.S: align .text section
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-88-pierrick.bouvier@oss.qualcomm.com>
 <CAMo8BfJg09ca6Kxw0WLLj0SQLBcOCwYmSN=e3u063oY-fgrdfw@mail.gmail.com>
 <99d7064e-50f3-4947-884a-6f6c14f2cee2@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <99d7064e-50f3-4947-884a-6f6c14f2cee2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Hhp_SnBJiBlB-qxRXdtWbX5tJ1hqOKb_
X-Proofpoint-ORIG-GUID: Hhp_SnBJiBlB-qxRXdtWbX5tJ1hqOKb_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OCBTYWx0ZWRfXwi46SWczFTTq
 BCXUJKvz5ZMBkMUGMU4cNQplB7mDJQYD2VBDyrE3XrdTU+jRVyQIG8oT9Nau82ip8gt9L9cWDDS
 nhW9ZI0lysA1Upzf23paz9Z01+aCR4L9r4KrCCWhdo0ksDJV2bxXq1CiX1QlBJq8EBn0xU/V26I
 IgWbJE2xR0Bjjk1AsoZ8Ys/W5UCtaruISA2o2k0avaF+GgaabSrIOgZ/xx1Bf706RDmtGi/w/9x
 2zP6JMOmmuXdJuFuMA644H5HYPbv+p4Zq8kqASZrhfe+je95NcKkYmFZiZ0VZNP9FfA85zr42FF
 EAif7pmNvBKIVf08Zi1St8NV/pDttGyNjmqjQyG3AsPlZDEc7TKff5+XBpcNwobCsXtVvwdH4R9
 UfKLrrxNp64HrQ4tIbPua+5eMSypqPosErj65vt2/mLrWlubHR9I0bQqQdZsVm22itSpRdDV+3S
 6NQMKXS/RxdsR0I/L6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OCBTYWx0ZWRfX5aQ1tIadj8Ny
 hB04efqlwlZqTBP6hmLK2iXFdvjMsgZRUG6gScvamcJp+tQgjMzqpi7ydh3px+pDLaJGugBt/q8
 k/qJ2Co8DmvGbVB0nl4dmWhI7vBNmEc=
X-Authority-Analysis: v=2.4 cv=atSCzyZV c=1 sm=1 tr=0 ts=6a4d412f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=2J9dMSujsegm34KpHbMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070178
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

On 7/7/2026 9:30 AM, Pierrick Bouvier wrote:
> On 7/7/2026 6:45 AM, Max Filippov wrote:
>> On Mon, Jul 6, 2026 at 3:43 PM Pierrick Bouvier
>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>
>>> Needed, else we get this error:
>>> dangerous relocation: l32r: misaligned literal target: .text
>>
>> This flag wasn't needed before because crt.S hasn't been built
>> with text-section-literals, why is it needed now?
>>
> 
> Previously, .S and .c were compiled in different steps, with different
> options. Now, with meson, we have to provide a single compiler command
> for all the files (no intermediate steps), which is a *hard* requirement
> to save user from dealing with compilation details in arch files.
> 
> One consequence is that .c + .S combination gets
> -mtext-section-literals, which triggers this. Easily fixed by adding the
> .align section.
> 
> I can add this in commit description, if you're ok with this
> explanation, and accept the patch.
> 
> Regards,
> Pierrick
> 
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>  tests/tcg/xtensa/crt.S | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tests/tcg/xtensa/crt.S b/tests/tcg/xtensa/crt.S
>>> index 909872cd385..de8fd8c1cd7 100644
>>> --- a/tests/tcg/xtensa/crt.S
>>> +++ b/tests/tcg/xtensa/crt.S
>>> @@ -6,6 +6,7 @@
>>>      jx      a2
>>>
>>>  .text
>>> +.align 4
>>>  .global _start
>>>  _start:
>>>  #if XCHAL_HAVE_WINDOWED
>>> --
>>> 2.47.3
>>>
>>>
>>
>>
> 

While at it, any chance you could give some hints about how to compile
for xtensaeb? I didn't find any compiler flag, and out of modifying
target/xtensa/core-dc232b/core-isa.h to set XCHAL_HAVE_BE to 1, I'm stuck.

I doubt it's the right way to do considering that it was not needed before.

Regards,
Pierrick

