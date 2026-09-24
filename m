Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92DDC9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 20:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9px9-0004Es-NQ; Thu, 24 Sep 2026 16:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9px2-0004C6-LA
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 16:21:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9px0-0002kY-8B
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 16:21:52 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIdeIC3247857
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 20:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SPGL/2h28xFlYoAPrqETKXZHcLHl5yrXmASLBNUS7jo=; b=SBc/mfCfirYSjTua
 7ZC9stDFZrzXkpiU9z+RLWjq/zzsltRcOKYWJvbONN8tEb9ltyUpojv2NWR10G9V
 +Ltcudg1LlfSIcg0VKzDJSqkkKS2LGr7siU83grJJXDuzmDgZjs8PJEIYtPJAZBx
 n1IS3eXfTsEU9ySdJOKjE3J6HOUefZQi8q74gr+rEDVwgfe3Gw1ZI2n1wB6aHCiH
 wLNMzV1OMNZ7329bOnX45PTmF+v8nN6yBcHhzhxOb+jRfMoaxgVFDc6fnnzoHAit
 tAcwU9qb8zoaoUpPVQ28d7CNdpahTRYycAl3HAe+BHckXsGl5dzBJak5dZ4tJItd
 L76/7A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw881rpxh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 20:21:48 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso217863eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 13:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790281308; x=1790886108; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SPGL/2h28xFlYoAPrqETKXZHcLHl5yrXmASLBNUS7jo=;
 b=AdeYvKQsB9EAQe3a5c4mtiYbsXDs4OUoA4jZoc5WllWb24Do+2RIH3iQQRT6wfG8fP
 hJBPRjecUdLP5eeb3liNSz8M6mzPFCEMvLFH720ZxD8nrmvsxrwgRrh2To8TkW+kzc6l
 UGuFE49Mg8wvyVl/FcW+Kw3odJ7dRwnuEZsYu5Yd1NZWRxaQd3u7UcddZsZOT+YHO0HT
 F7YatmgjTiOVr5RuEjAlWXe+NzOQHFo3PxJTHbjlU46EzEX/ssK36VSUFIgRQlkX6osh
 T/c9zeUMzJeGg51qCq/zWCxUXkR3wriaSkgV+5lZr4KptSE4IDSXGtDI0NCOl2rIzY5z
 m5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790281308; x=1790886108;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SPGL/2h28xFlYoAPrqETKXZHcLHl5yrXmASLBNUS7jo=;
 b=tSby8V19E0roxyM7yQEVyFOxevml9e/PMRn+8qlOkUMe5DaurZwdTyQ6s490Z1ka/7
 4lTaODwNJ+sleNNAc1/fytMlnxKyX4nFQLV8EwlR08lNsDYT7Nu84Bc6bMwwzkqrucOq
 Y0llKG4V0zH0Xsbztl/dYI8xgsxyFLaOecCzKsiL/VcNiAyE2/KhQA+8VDLn/FFPGH/5
 ilp7sYDqTWp+tIQdYYkiOnqWwNA5djND7WefIrpFSjZGShIwNGc/VC/dY8+epZP2w1gd
 Wp0I3fH5isN/FGXiqB0n9EjgMj/IA96ASlMlHTKAdHUhZDR3wvO045W6LadXdp0GcU1a
 YQ2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwq3/varYcVxWye35RxlL10KRm8jJ4VQ9Q54QvudhK+D6Kw61kQ5TAQG9uG7TfWseWMcq4y5HWR/IX@nongnu.org
X-Gm-Message-State: AFuF++nX65tIhF2izSlNFytT75NQOg83kDzp2Ogj7nT2X7KXYSdvgY2l
 Qmcm4xTJfK3L4oaD7f7VHIrQf8XVeszUL3k8fHpgnXGVPt78X3ZWgbCKaTyMH/dlB4UxR+Z/lyq
 2Xgrv7kkb3+PT5SdbTq4I5cxsLNcjZwyRjeVCOWWrkS9j1F2HWhXYVhjw9Q==
X-Gm-Gg: AYBFou3IpPmh6g8FW7zcNK0Gmilj3LShBJgemcOdwOqhQ/tWOeNAi5WVOPvQnLoQLhQ
 ewJD2Zq6Srgl6WIVUG8Bj0aGD+FatGCdMcre3zeOiZ2O2lnlQ9d+jUY0WEFK/sPZX0UPKXIDOiD
 JCL7BtggSn2uN92Gaqg2Vmhnf14w5oGfBoX2QD2sc7h9YE1eQfyjStNWZSDhEk3JRKOKoHaGpWp
 Pb2URWEXfXAlgqI4sLx+L5HllN6YBs6GAIl0Y8KQHNrS1cSBIQ2Q2BVVbIopsVzG63GJSYN4drK
 1feVScov6D4WHcAzvEgjStLWZMlwHG4gLZfP0EvVPW2GSml+2N9ZKheU0CvCAg6jqqikpXL54y8
 SzQWkT5MkMxL4nRXXmRlcZmdpCoGB9D3sROV7Km+jGN2q8TpZQgBB+zE6nMz1RlXVOlo=
X-Received: by 2002:a05:701a:ca87:b0:143:3617:c595 with SMTP id
 a92af1059eb24-14504037affmr2841993c88.1.1790281307493; 
 Thu, 24 Sep 2026 13:21:47 -0700 (PDT)
X-Received: by 2002:a05:701a:ca87:b0:143:3617:c595 with SMTP id
 a92af1059eb24-14504037affmr2841965c88.1.1790281306675; 
 Thu, 24 Sep 2026 13:21:46 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145acc45f03sm850357c88.7.2026.09.24.13.21.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 13:21:46 -0700 (PDT)
Message-ID: <5e6cfe03-2f7e-4c21-b5de-a285eef342fe@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 13:21:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 092/105] tests/tcg/x86_64: system tests
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Bernhard Beschow <shentey@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Aniket Sahu <asahu1x@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-93-alex.bennee@linaro.org>
 <cae2d17b-571c-421d-98c8-fbc467134141@gmail.com>
 <6b37b050-9d5a-40a1-ac65-4126fa725342@oss.qualcomm.com>
 <353ea82d-9227-4482-80f2-d78788e36e2a@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <353ea82d-9227-4482-80f2-d78788e36e2a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6ab5865c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lee1ZYd2aU0AVthO9K4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4MyBTYWx0ZWRfXzFoDoHOf/yc1
 N5Ae2IpLcz1F6ELfHTjSaxtVk7i0ZCvyxGTJSXb7AVhIqovZfIeDwYoRwYxAu4efeezVWtDm9V1
 cwOFjWEgbhGiZKrFHtCWDJHd1tOqECKe9QcWj2FOTf+rdXuSmI+4zKdASTWGFBgb9IGcSY5UzaQ
 0W5ksk1zPXwribMq3lNFW6nWInvJVsH4NkQZE4wWK4immrS7VbsaShMtaoHx7jXqDDvNwp6hfiM
 4w5Dk4gb8SCvquKvWFLaKcRrP0pwFo7hn78JoP0qQeSSyF3nqYIZ87dhOYIvZUwhIQQl3x7ZHsL
 0jZic1P8piDzZcZ03CnZkyt4ERQAIx/6jZMp122Jfg1EVCG18mj0AdJEMMEUPiEPKXcQfBftva4
 Jr2FGubGaEP8oolMROmFVZJT01NJVt2GCsGIiLM8EolNuoIq6qv6YFDREY6kHQ73HY6ov18R4E8
 plY2yXSLD0pxGc5e3Ug==
X-Proofpoint-ORIG-GUID: 1vLcaMJhTS0-qYUAWYq3w6vGzODmHOFx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4MyBTYWx0ZWRfX0biDUSab9giH
 77i0jGYUf/MpY9/wwNKn5vbJXJ5MdmtjUjtol4gy/7ryHq8QJlEs2huiTjtJkNBrMm4TZFia+lz
 02jUlk25AAM8k4SsRHhTTwgyeiYYHf4=
X-Proofpoint-GUID: 1vLcaMJhTS0-qYUAWYq3w6vGzODmHOFx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240083
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

On 9/24/2026 12:08 PM, Pierrick Bouvier wrote:
> On 9/24/2026 11:30 AM, Pierrick Bouvier wrote:
>> Hi Bernard,
>>
>> On 9/24/2026 11:18 AM, Bernhard Beschow wrote:
>>
>>> With this patch I get under Archlinux:
>>>
>>> $ make tests/tcg/x86_64-softmmu-hello.test
>>> [1/1] Generating tests/tcg/x86_64-softmmu-hello with a custom command
>>> FAILED: [code=1] tests/tcg/x86_64-softmmu-hello.test
>>> /usr/bin/x86_64-linux-gnu-gcc qemu/src/tests/tcg/multiarch/system/
>>> hello.c -o tests/tcg/x86_64-softmmu-hello.test -static -MMD -MF tests/
>>> tcg/x86_64-softmmu-hello.d -Wall -Werror -O0 -g -fno-strict-aliasing -
>>> nostdlib -ffreestanding -Wa,--noexecstack -I qemu/src/tests/tcg/x86_64/
>>> system/../../minilib qemu/src/tests/tcg/x86_64/system/../../minilib/
>>> printf.c ../src/tests/tcg/x86_64/system/boot.S -Wl,-T ../src/tests/tcg/
>>> x86_64/system/kernel.ld -Wl,-melf_x86_64 -Wl,--no-warn-rwx-segments -
>>> Wl,--build-id=none -lgcc
>>> /usr/bin/ld: /tmp/ccRh6mPz.o: in function `print_num':
>>> qemu/src/tests/tcg/x86_64/system/../../minilib/printf.c:45:(.text+0xec):
>>> undefined reference to `__stack_chk_fail'
>>> /usr/bin/ld: /tmp/ccRh6mPz.o: in function `ml_printf':
>>> qemu/src/tests/tcg/x86_64/system/../../minilib/printf.c:136:
>>> (.text+0x549): undefined reference to `__stack_chk_fail'
>>> collect2: error: ld returned 1 exit status
>>> ninja: build stopped: subcommand failed.
>>> make: *** [Makefile:170: run-ninja] Error 1
>>>
>>> Reverting this patch I'm able to run `make check` successfully again.
>>> Any idea what might be causing this?
>>>
>>
>> Thanks for the report.
>> Tests were previously compiled with -fno-stack-protector, and it was
>> unclear which distro/setup required this, so we removed it to find what
>> requires it. It seems like archlinux is one of them.
>>
>> I'll re-add the flag by default.
>>
>> Can you please confirm the command above (x86_64-linux-gcc ...) works
>> with -fno-stack-protector added?
>>
> 
> After testing in a archlinux container,
> I confirm that's the right fix.
> Patch is coming after CI end up running.
>

Please find patch here:
https://lore.kernel.org/qemu-devel/20260924202012.2465-1-pierrick.bouvier@oss.qualcomm.com/T/#u

Reviewed and tested tag are welcome.

>>> Best regards,
>>>
>>> Bernhard
>>>
>>
>> Regards,
>> Pierrick
> 


