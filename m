Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF746C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Vgg-0000o2-PL; Tue, 15 Sep 2026 12:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6Vge-0000mb-UC
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:07:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6Vgb-0004aw-Vr
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:07:12 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFAa4l291131
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5iAa170kCbY9eaMNNDdWAmTqxLc9QnCBNgkjf7GMXuc=; b=XWEMjCYidBufG57H
 7B0VjL18DNnDCvCCq0xIqe+K/cxcilNh57cpMBF4o0EXxl/hDfm9BZJXvWzET4mK
 nUDwxE+kridyUekRDamV5eSAWa8pEb9JEMEPGOoJ/6but9XIhmDspQ7LRQaZsMEp
 IEAE2XNlfGRfDakuP+dkP4f5+6pFPm1AEdYF3PWMdFxTh8kvabYFQPmi46Rxg9IR
 6mk2+jpEqLA8jQ6zZHxgxnMECk9CyqncXv9n0TKelhkCRoTyiR8G7/6cCBMdr5nz
 2S5PNzKbjq/tnkkue2/J56Vrp8yo1LdPoVLj0pwKPoHc0p1DLQJrMlLcw5mc/Rwx
 cGcDgQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpyux2sat-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:07:07 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7f8931a803cso4447906a34.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789488427; x=1790093227; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5iAa170kCbY9eaMNNDdWAmTqxLc9QnCBNgkjf7GMXuc=;
 b=MAr52e38fB6fyb6BFr/s3A/Xw2n0JPtmikHI+2ZcCjB5mkSvc93vV2WLX7ObyORTWo
 5fJR4Twog1XclyiKPrO7FQkWhvRL6CxyFjlMz4jySJImt3GEpMponBve3rTJBarLuDzq
 qKPI+rIEI6U5ongvwQMbBQm9ZA03NkcpcSTi0joDeNyzLq1tNZbnYSNKqWF/girGbcXB
 mZUgb4u5Ri6v+yhjIMiNc/umnYkYgjtdrbMUVdd0WW2s8vymYFK4MNKb9xEWMSe/89pQ
 tjeywN2kz83DR0+mulz1sxIVuI7j5Nm3UawWoK75Hj/DJOEfh0//40gtsDIqHDuWb+zD
 sVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488427; x=1790093227;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5iAa170kCbY9eaMNNDdWAmTqxLc9QnCBNgkjf7GMXuc=;
 b=10nwhEEvtqbRiDBtbdcAgSIO2843Ttqlbwqv0/iI/0h6hSpcEzHQF81teohdMnFL8Q
 FjqoV6fCoM/0umHZTk6VIHAKgr6MX10wDxRY03ZVeRBmWBASIUqBS/s0dQvvBlhiJZmK
 70dVr590Bo8O2UQ+b5Q0NVEtBmMh6h6+fDiUdE8jxJ0+9UdkqafwK1Em87hk9KYSbjDc
 7oiUvbmZWPibBcxEo3k5mPNlsXm41p4cRAKsEbW19ckINx7OPkP4NwiwnEVZVuBJSPxf
 tbXH6b+ahT9uscPZTLah2lIDVsTtyAMGjRt8CI2gqhJnx+/HiuEok5CYzQ3tvCa3utLV
 WH6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzg8SXobXDYajM3n1KlAD61lKZ8JaUrEl4j0vmpuc4gYtoCP2mBML6E5nOUymG39O5evpNP9ih4F/pf@nongnu.org
X-Gm-Message-State: AFuF++lCsX9mm12R82f66EGZI3MQzJhTIFzysyl1cXELlKdpYAo12RK8
 x/XzY0XH0pIWYdRcdWYPh3p/5i/YhLMDhqAIAh32eB4V0bgBAeijv4f781nnPcywVZYGHxG+bEL
 heGURwXr05TxE75W6Ws9YWkfB5w7tB1a9SQcqLCI3uY1wJjwrLZ9b0+NPEw==
X-Gm-Gg: AYBFou3zUPrDzSLQnVEittzXwa0/yANbWH1EPAsqc+4WI1y2/hPF2x8PMhssz4xUxoG
 zL+UCCIN2vsD1tuAIXJ8FHvqs6pD8qdUJElu/Z2Oa0smwfI+uiGiX2UwpheklMUPWXvqVQcSpgA
 8sS+suHvs9LudOZgwT7LDe2iO+b7s4e+IfJG+/NJLISR/pQLF8yJHYQDRiXzbzQ7dUcdpFFyi6p
 c1Zej4qtkHMsNBMDzc829Uf3N8Kjt+smVjTAdjHnroyAoZHlbJ7K9B2gqkL7vMqqONHJu9FxwNZ
 kJ/n7yBUL3kSVLmQs4O7wV8gQkEzenHwbBF21lRYXtu6Z1PZVvhuLk0YPYdnFc7fVAUkbU49lkZ
 Ilv7zUQxIrE2umXmA/xGZ9yHh7AlH1CVXvwgZMr09+lbiybOm100P3u+iorYCOMo/cstD
X-Received: by 2002:a05:6820:200f:b0:6b7:46e9:9702 with SMTP id
 006d021491bc7-6c541555548mr5098467eaf.50.1789488426977; 
 Tue, 15 Sep 2026 09:07:06 -0700 (PDT)
X-Received: by 2002:a05:6820:200f:b0:6b7:46e9:9702 with SMTP id
 006d021491bc7-6c541555548mr5098378eaf.50.1789488425988; 
 Tue, 15 Sep 2026 09:07:05 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d64805sm31371c88.13.2026.09.15.09.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 09:07:05 -0700 (PDT)
Message-ID: <d04e6cbe-f8cf-4205-97cf-40a39d5eb081@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 09:07:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
 <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
 <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
 <CABgObfZnyHenuVJ6maVs+jMNQCJeYhtcnXtXOqN1G3NcbvDt7g@mail.gmail.com>
 <aqfX2414cAMCcI18@redhat.com>
 <5cc8dd29-9093-4082-b8e5-32823f21c71d@oss.qualcomm.com>
 <CABgObfY68FT-V=G1Sks865FtEwEwB9SKyHx1YTLtG_4x9WDseA@mail.gmail.com>
 <871pavd8ry.fsf@draig.linaro.org>
 <1a8155b3-92f2-452c-bd0f-884c3e0bef69@oss.qualcomm.com>
 <858ea3b2-689c-4110-92e2-237b7aa87fb6@oss.qualcomm.com>
 <8897d12c-096e-4032-822c-ca752a0ccc01@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8897d12c-096e-4032-822c-ca752a0ccc01@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzMyBTYWx0ZWRfXwUmzZ8bCrQTo
 lfzSI+Mqu9x9fS4FbxUUafYo9QVZSio3P3l1YC8+bGKS04Fm4veYS/RFekzAtUUdWyE64vGmc/2
 SKiCLJnb7oCkkTYrfPHZz0EUkMWdL/XSNU22OCgBaslTwKpcPEov61DVCZ/SXTlqVhmtHK+v64X
 vig9A9XlNQ3a4tisxpcQZPDTeF6imX3FEJlz87TBeyxI6YEiImDcCuAQqzjVZFzmyZvwsXPI1I8
 lNijOGs5lJZrKc3TlVl9+QqqxPPMPN83+Bu8m3/siu4MiBNYATZ1Iw1OGhu2EXlEodUBHNKzQmm
 YgdIl264Hh3yrsTu1ajrgkNi07AU5uPkt1cMb6iSIlBj9zPGGM+MTMoxvdo19xomfhyRoF7OPBJ
 +ZmOHTi4pLvF8tfOulUrVfyYxWt3HoMMLtQbfAj2E22Q2/ZXPl0mCE+yaZTz/p+THlM5ahvrVVA
 4VveXU9quntzrtjeuEA==
X-Proofpoint-ORIG-GUID: LzucUdO9XHv4lj1lq1y-64Q0K2yk0Cbn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzMyBTYWx0ZWRfXx++0L0jVd2FK
 Y2Oco/yuZYxXS4JlwDt3DGEjy/aamcsfh21m++dqi2rm7mG65ffInXZmi+9OAaaH7DOHywc3SSJ
 nk7PnNp89R0w5fGFIiqNqxwIEeuJcHw=
X-Proofpoint-GUID: LzucUdO9XHv4lj1lq1y-64Q0K2yk0Cbn
X-Authority-Analysis: v=2.4 cv=QYLzLcbv c=1 sm=1 tr=0 ts=6aa96d2b cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=DCXRcPs6ibjNb_wRdlkA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150233
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 9/15/2026 1:09 AM, Richard Henderson wrote:
> On 9/14/26 08:09, Pierrick Bouvier wrote:
>>> If vdso rely on this, we need to keep .mak files for now. They
>>> definitely would deserve to be buildable using meson though.
>>>
>>
>> For vdso, we could simply build them as part of tests/tcg and tcg-tests
>> target, without having tests associated. This way they are always built,
>> and people can update them by simply copying them if needed.
> Why would linux-user depend on tests/tcg/?
>

Currently, vdso build depends on mak generated for tests/tcg, though
it's arguable that it depends on configure, and not tests/tcg/meson.build.

https://gitlab.com/qemu-project/qemu/-/blob/master/linux-user/aarch64/Makefile.vdso?ref_type=heads#L1

No good reason though.

> It seems to me that the cross-compiler infrastructure belongs at top-
> level, not in tests/tcg/, for use by everything else in the tree, vdso
> and roms included.
>

My mistake was definitely to assume it was only used for tests/tcg, and
declare compilers along each arch in tests/tcg:

https://gitlab.com/qemu-project/qemu/-/blob/master/tests/tcg/hppa/meson.build?ref_type=heads#L12

From Alex message, he will send a revert soon to bring it back top level.

> 
> r~
> 

Regards,
Pierrick

