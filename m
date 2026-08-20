Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E20C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwuk8-0002XI-Hq; Thu, 20 Aug 2026 00:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwuk7-0002X7-3D
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 00:51:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwuk5-0004Hn-2v
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 00:51:06 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JL7hKi1438918
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 04:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cymq3yefnzOl2bJFNLYcjmLqrmZYRSC1TOWzI1kUXa0=; b=cXHd0l39SVGZXsSY
 SLnC0TcCZS4CvZI6ca6xI/hDkWydtIjjSfAKgewGIyaUA0/LiDcv2TGX6Jcgre+C
 ubOSLdmp0/ITF9fb6FFdaidCTF4YocBm350CkATDDv/eva6GSX3fGAYuuZr1SaVs
 PD6iSRfd8yaB1EE23pyWXInSzX6/RLUaBqVztVvgGn1p5cd7oml3/ne/YMPZZ6oh
 VNvniNcTe+8PI2YRKTFJc8k/5Dgn2EGbbXBZ0MRLxXGyYJb/kvHo1KJyX7m9Vgzw
 uwkaqXGNWwiP4Nmud0dZL8WbPN4Z8PHgw8mSbE3uA2aTV2RGQ/1E4bfOZ0ipSy8+
 nyhp7w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5daa3n1d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 04:51:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-930edb4362dso190365985a.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 21:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787201460; x=1787806260; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cymq3yefnzOl2bJFNLYcjmLqrmZYRSC1TOWzI1kUXa0=;
 b=SbogYrog6DGYrWa88WCfbfnMkyCm4f6Y+UiuxC6hGN/vsFtwRLWSjmBlS2ro2sygHD
 8FtEBBriNTnANT1OlJdhjngnR3HP8sbrMBT61bDXBJ8/BrCRBdEcNSdzFM4j/6vkxiAu
 TeCIzmh6zbvPr5z5CPbKW+CWWiKgvGdWkhpbDbCrNGLX1/lnquPikVO2COMicGMMlxi8
 DFzKCJSNBm98TRxIIABjMF0+/wrkFYi+wZ0fS4HQPUqeuQC0k+bXRFddwEb6h8XyyXHk
 PsQ8Xow4CwggGGBCT8mH6m7D2OH7Cv+sMMuG6oIgtAduHfGZHLHTGXA26cimdJZtWih/
 KRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787201460; x=1787806260;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cymq3yefnzOl2bJFNLYcjmLqrmZYRSC1TOWzI1kUXa0=;
 b=TfzxNX5tkPbHeEslh7I+t4N/pvtwSRaJS/LJbQpS3TKggeNk48mOWYitliNczPHfPl
 mbEC+ymLMFusXacNNgco4gOFc2ZH6+I2wArK63NBWqSyzCFna8+53GqEWGvtA+jGRuTa
 Y7LItU13m+iOtk5rO9mIf3TKe/nkpfc/e8nSC2yBIZRaWc4ibo2ub4vL+Hi2FkmZDCvq
 vBzZpRfV7XZ+/24m7TkwMHr5dJ3Q97pj89rL8C3KIq/BKYrVXE2vuaroVoPoiWnW8GhR
 QUPrHsvyaVCy+3N4ogU8znQhpZlJMa0+tZu3oQ+rA3sw5c/+7Qfc0BpMS8pdMIqBwgaL
 wXXA==
X-Gm-Message-State: AOJu0YzEC/7pJEycxl3DaGYhay7FpCs/EzOlLsIPLdBDjgYDwPiw2IRU
 /xLVaBABVW3fiFW2yCxQ2W/DWeyFjh+bN/X2MjUyuciX6Zp2DcCMUQwzHHF5YdwRbPLOR9WnUcF
 DVpGjeLpkRrLsW2Y9WfKkN3Ecpv/m974U+7fo2hzmjq70zopn3mZreKSPxg==
X-Gm-Gg: AR+sD11CBV9RjOvZeqzj9f2ovuxEojsDbWtYrf/b2hVag+Yryilr+nG+xD71Flqk8+K
 1b0gm84dOWjC01cZjDPwovMWi7L7vu5bCvHrNUn7i1Wf3dcMJ2voZI06Opwv6FReXmOK5EB5Qp1
 dN1EdT2/J4hIJTOfIUiTphsFbwJBLvk99ktcdIAaUdWJ+nSkWRKKoicIKxC5JUqNJUhSFLN6z7F
 oMtsS9/DkLbMJqHIsGVyLT3rmnNIc3gsevn5NPIWmEFZA3oZ+b5yHnawOl3KLMlVDpWUEqN+XL6
 rUqK+/5PzZFnwFghG/XpSQfIDdAbw6EG5xqgkkwQuKtfK17yNyksu1U4BWVHWWwEyNBtQGBy6Bn
 0pwILuxhFaA1LBjn29xPDcQsh4MIiHYPv3k8=
X-Received: by 2002:a05:620a:4388:b0:936:d833:6c48 with SMTP id
 af79cd13be357-9371e2d0905mr1001369585a.27.1787201459996; 
 Wed, 19 Aug 2026 21:50:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4388:b0:936:d833:6c48 with SMTP id
 af79cd13be357-9371e2d0905mr1001367385a.27.1787201459551; 
 Wed, 19 Aug 2026 21:50:59 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e805a4sm126018045e9.4.2026.08.19.21.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 21:50:58 -0700 (PDT)
Message-ID: <8647a93d-8e77-405d-bf50-85bb588247be@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 06:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] hw/arm/raspi4b: Drop board_rev for 32bit hosts
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
 <20260818172012.3052821-9-peterx@redhat.com>
 <c5e8b837-5921-41a5-8314-d61a629c7057@oss.qualcomm.com>
 <aoXlTZQQ-ywdCIAJ@x1.local>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aoXlTZQQ-ywdCIAJ@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fv3sol4f c=1 sm=1 tr=0 ts=6a8687b4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=lMcZDcQH4ua99yDYivsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: H9dXZ-Rkd6kUosfGsZjVoq_W7pEUo9Rp
X-Proofpoint-ORIG-GUID: H9dXZ-Rkd6kUosfGsZjVoq_W7pEUo9Rp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDAzMiBTYWx0ZWRfX72gFZgxH+qTS
 tdcqb4LqvEbD91JDvuEpBrnsdgdJn2ew2Y/bSe4C3Op28kl03Vd82FKVnezQbsEaGdBYv05u3L7
 jisUlIrOHwH4BpmyWJO5ImHbFzXq6LA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAzMiBTYWx0ZWRfX4TygrWBoAI4T
 QkQqWc2qBhzO3DXJHAmiZXTP2tZacOqdKvqf1M0XLE6j4BqVioOnJ3alhnWs0EQqrSCQ0d1Sir1
 8YuYM/9LAkmZww3+I3wkWBkwVwGtZv63BBfmEX4+NwYZi2pIHvmEnuN04ub9QMtW0Nis8BB6tir
 6unvaxIHz/+znvKHtUXqwuW4Xd7a/kGG8+1n4bv2tebn3LJhb7HvVtHT5AJ/JgsN+Z1eWuvDFGz
 /1nt+uOoLXmoR7WbsuangJ5jvg7LpPQnhL5Cx2t4S/fXan9JlxfJzUGr13ueEcku/wfLiDwZOrj
 WvE7vdUr1OeCZwjV0NC7CKw9OE2SGmFSONGlJvZR/WEANCL5QtFP8lMaR6tJwh+WKWEO/8KZeus
 KpDQNKWhI438MGCzjwE0+RlDBabfqI/5ljTOz5b2ida5DgOc2gJWPAZSUwPeF0bAQCMUSHM2uJ6
 0tjeaZsc0SQI8O41JHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200032
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

On 19/8/26 19:18, Peter Xu wrote:
> On Wed, Aug 19, 2026 at 02:54:23AM +0200, Philippe Mathieu-Daudé wrote:
>> On 18/8/26 19:20, Peter Xu wrote:
>>> QEMU has switched to 64bit-only hosts for all system/user emulations.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    hw/arm/raspi4b.c | 4 ----
>>>    1 file changed, 4 deletions(-)
>>>
>>> diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
>>> index e1595a875f..5f7abbb4c4 100644
>>> --- a/hw/arm/raspi4b.c
>>> +++ b/hw/arm/raspi4b.c
>>> @@ -111,11 +111,7 @@ static void raspi4b_machine_class_init(ObjectClass *oc, const void *data)
>>>        MachineClass *mc = MACHINE_CLASS(oc);
>>>        RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
>>> -#if HOST_LONG_BITS == 32
>>> -    rmc->board_rev = 0xa03111; /* Revision 1.1, 1 Gb RAM */
>>> -#else
>>>        rmc->board_rev = 0xb03115; /* Revision 1.5, 2 Gb RAM */
>>> -#endif
>>>        raspi_machine_class_common_init(mc, rmc->board_rev);
>> Here I'd rather keep the machine. IIRC someone already suggested
>> to adapt the board_rev with the CLI provided memory size.
>> An improvement for tomorrow, meanwhile:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> Sure, I can also drop this one for now.  Thanks,

No, keep it, this is dead code :)

What I meant is I'd like to get the Raspi 4B with 1GB (rev1.1)
re-introduced, but I'm not asking you to do it (and I'm adding
a note on my infinite QEMU TODO list).

