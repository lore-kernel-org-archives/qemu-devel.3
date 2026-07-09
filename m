Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF94C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrXz-0008RO-Gr; Thu, 09 Jul 2026 12:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whrXx-0008RF-P6
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:24:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whrXv-0000lJ-Mq
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:24:21 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669EwNtt2062276
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 16:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u95SCJj9XTGLWifBDa9D+sezqzwcsBC8GoBt5yK2Mck=; b=XgpF3VhZOaf1bjMU
 ooHr1tKlGRFNpwql/Dq3QxZfKRKhqSjNtjGF0tJV83GP+rVq37HcR3kDGK4HZYZ1
 qAB7XP6V+/kOU/Qa3vZFg3SnZkCiQ9bZ4iXRpEkfgWxUyGGXLvLjLFj4cbkhO9Q5
 pXgbVK2YFYsl5Px4xSFQK1taXdWuZzrz/CqD9NQj0UNIw0yYI9beohpsx57XQbDE
 GP8X1KL4Xzs5H3n2QOt78SKv9V7dpPrCAHWiMGUMZXJwE2WFonA09qoXxqawjeQR
 E6VZ1V4yTNYotlnB2edBpklGjpBudFjIOLbahBiRCN2yEPh9rjL/knaczLAasTAB
 bRBzgw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvj8eug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:24:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-37d4eede8ccso55226a91.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 09:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783614255; x=1784219055; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u95SCJj9XTGLWifBDa9D+sezqzwcsBC8GoBt5yK2Mck=;
 b=dlXBBKGNfrzMQ1RvjvUCNGMDIW+z2gGSvsWmk8N/1sYSE9yNrJHgkfZedKXi49TEvr
 T7tltfjsglByKfCRlSzjxOzTMgBC1+Ft+G3wzG2nLtKU1x1A3KFjF6GY2puxrClspeUf
 VBUa6+YYNBkzW9Wz1Fs+GvZ510CJVmLML97DzWnIpTm1nSgpO7ls0xDLweqbFSX54YD2
 zGRldNjMwuCimwT36feGI7YFiP53j9OUGFjG1AR/jdn9ql06rsNW/+GSidHcE3qXRGMY
 RC/psOKBpRejXu9Cf3XSoxUeZyBMrHuGGU9LWA5a7CXUMtEqpDPgxeKfUeRMLaQgNPy2
 NfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783614255; x=1784219055;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u95SCJj9XTGLWifBDa9D+sezqzwcsBC8GoBt5yK2Mck=;
 b=sNvc6e8BEkVBo/IxU7QTQIF4wxf6h7YKX2BolR2i8oF7Nf5N0NS8DV9HxszjPaqNzw
 /coQdi4/7a5mdA0T+nOX+XHSF0s+JrgpnZGZVOJLj9V3K/byZJWzssZ525UIrXHp/1n6
 ZjVxlQQvkEw3bcPFRuL3qKQCqUkcja9Rfim1BogspS9gKEll6snYxHQbMMptb7kI3Ugo
 gHnaGg3G684VqDp4Sz64K7K4G6vc/oTBnNOxE3kFTcKMG6ojkpFV7AzZ6r7u41awzm3b
 z0vBP/NGrxJDj56R39zYk8G2yLyNnHK3iUf7Am2xAQB5gZzMJFmtx4VHeBgBfoMlrpsj
 BvGg==
X-Gm-Message-State: AOJu0YxaFDgJUJ8GZZNaQQuzESUHQfg/tTpiwOFwpktCBpk1Jhg69Y7Z
 HaYKcTs+KZx7y7zH4fPSdqQiOLGIHWGTTkDyrOnuQQ1r5mtMIMqiLkp9Iys+5vx/r6g9yvIcY27
 ZrtzvtXY6IFq4d5SJpEBE0eNUsFcWYbNfEUC2cdncUeektnakV+tlgC8Ti8TCiOL5Tw==
X-Gm-Gg: AfdE7clSmylzaHeMdbYo1Tdg1SkVvblmiK3BDpbpY0Qed77hxqO13Gx0z8OOCG32pCR
 LaQgMdOiSjMqZl6nD8WdmCFsicAnHoeA2ca5xEqfgJzR61lyY0tFk/52vGhDhthgugjYKY3jymm
 DICihGLdzOqDnUc23ZlguDW5bbv3JZyE/JzW7s8IsuhiR2GjVgrT+EjGDBS0c2ml0DXokiUFDYA
 xCqT6j2opPWk4JGtF0RNCOUnBdCauJBX8UrbGwRTQ0lRitIMyvldvUCnrZCSeKsu+3r8vfMULkf
 8rhUbCQkMEtyUnPb0o2OvJ5t7IVXakc+xg2JTtU+DVNRf7ICxITp7X5VU5wobj47qOK6XLY+CJK
 N1qGNxpdMLVI5FexzvnTkLKMljkHwHjqndwQUGDgXVbVmtktdr2dlJtbXos+GaEyIlBGCOWkGxo
 efiIQ=
X-Received: by 2002:a17:90b:2d47:b0:368:ed26:15b2 with SMTP id
 98e67ed59e1d1-3893fe5b640mr8872208a91.8.1783614254628; 
 Thu, 09 Jul 2026 09:24:14 -0700 (PDT)
X-Received: by 2002:a17:90b:2d47:b0:368:ed26:15b2 with SMTP id
 98e67ed59e1d1-3893fe5b640mr8872147a91.8.1783614253891; 
 Thu, 09 Jul 2026 09:24:13 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a5516949asm1517716a91.1.2026.07.09.09.24.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 09:24:13 -0700 (PDT)
Message-ID: <947a4843-34ae-43f7-8fbc-80109bc0c077@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 09:24:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] tests/docker: add support for podman remote access
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260210163556.713841-1-berrange@redhat.com>
 <20260210163556.713841-3-berrange@redhat.com>
 <cbc2e0d7-72d6-4350-a906-e0003e8b5964@oss.qualcomm.com>
 <ak_IsMGkkMY8wERc@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ak_IsMGkkMY8wERc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE2MCBTYWx0ZWRfX1nDkvISVghuP
 1RLCq6slX7dRuu7CwidoXjflxl7azmIl7gkgUvWdysh84LjjYSmu2mALRhEPRF36PEnevi8RZA6
 FDxt8q40XThXwoJEdk/JpyXSXw8C23HAhv8PW2ESAUAisFII2EDU6x/Xkpa4vJd+c2Wg5+Sk4i4
 mP94IcnOxnJND56ZUBS0+OHLv0d8INz2W2/is+Oo5cVwdgNw8/VpxJ8UkQiYKPaoQcmG1kYw+Ia
 uZfMUt7suuPUfF4lyaiWf+EzVx5ARQFg4PYRuBNcOit5LwYKhoP2nhDKDGEepcDGwrzmEhufciJ
 NpZrxDdaiyrZbexa5tk89riWp7/9JDI3vuZvDYMBkQKyGkeU/QETh6s0Gt1kp72i+/2xPOWsJiy
 SgYUUKULgta9kEu4nXvg2eR6k5HXYlT+OLMNeXJ2IaDv/QcWsHLp70cGWnseDTisZIjKnAvevm6
 pG3gwaEDepI/xyFKSAg==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a4fcb31 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=8hG23R3pAAAA:20 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=w7__q2GWHIPGuJx3YG4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 7SYwcEpaOslbtdfrF48e14qhgQ4mnACx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE2MCBTYWx0ZWRfX/0RdAWHVGN9u
 fP8XZTayKtaqKhIvxJ+x1Mg4/wThPTllNtqcckmJxRf4NrIOaxHf0lpUMXHQ6zD49ot8fvZc88+
 6GjWrugdZBeJbgtavX9zgp943s0tt8g=
X-Proofpoint-ORIG-GUID: 7SYwcEpaOslbtdfrF48e14qhgQ4mnACx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090160
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

On 7/9/2026 9:13 AM, Daniel P. Berrangé wrote:
> On Thu, Jul 09, 2026 at 07:48:14AM -0700, Pierrick Bouvier wrote:
>> On 2/10/2026 8:35 AM, Daniel P. Berrangé wrote:
>>> When a developer's environment is already within a podman container it
>>> is not possible to use 'podman' again to create containers. It will
>>> usually result in wierd errors such as:
>>>
>>>   Error: fatal error, invalid internal status, unable to create a new pause process: cannot re-exec process to join the existing user namespace. Try running "podman system migrate" and if that doesn't work reboot to recover
>>>
>>> Podman offers the ability to talk to a daemon outside the container,
>>> however, which could be leveraged by QEMU.
>>>
>>> This can be used by invoking "podman --remote", or equivalently the
>>> separate "podman-remote" binary:
>>>
>>>   https://github.com/containers/podman/blob/main/docs/tutorials/remote_client.md
>>>
>>> The current 'podman version' check is insufficient to detect the
>>> inability to launch containers, so it is replaced with the stronger
>>> 'podman info' check.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>  tests/docker/docker.py | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>>> index ff68c7bf6f..9e18b984f4 100755
>>> --- a/tests/docker/docker.py
>>> +++ b/tests/docker/docker.py
>>> @@ -76,14 +76,16 @@ def _guess_engine_command():
>>>      commands = []
>>>  
>>>      if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.PODMAN]:
>>> -        commands += [["podman"]]
>>> +        commands += [["podman"], ["podman-remote"], ["podman", "--remote"]]
>>>      if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.DOCKER]:
>>>          commands += [["docker"], ["sudo", "-n", "docker"]]
>>>      for cmd in commands:
>>>          try:
>>> -            # docker version will return the client details in stdout
>>> -            # but still report a status of 1 if it can't contact the daemon
>>> -            if subprocess.call(cmd + ["version"],
>>> +            # 'version' is not sufficient to prove a working binary
>>> +            # for podman. 'info' is a stronger check that is more
>>> +            # likely to correlate with ability to create containers,
>>> +            # and required to detect the need for podman remote
>>> +            if subprocess.call(cmd + ["info"],
>>>                                 stdout=DEVNULL, stderr=DEVNULL) == 0:
>>>                  return cmd
>>>          except OSError:
>>
>> Taking a look at why tcg tests are slow to compile, I reached this
>> commit. It seems like that calling 'podman info' is 5 to 10 times slower
>> than calling 'podman version'.
>> Thus, a container run now takes +1s when it was 0.2 before.
> 
> Hmmm, but we call 'docker.py probe' in configure and cache the result,
> so that probe should only be done once.  0.2 vs 1s is just noise in
> the context of configure.
> 
> That you're seeing any negative effects suggests that we've got
> something not using the cached probe result, which we should fix.
>

Not really, docker.py --engine X still calls X info.

https://gitlab.com/qemu-project/qemu/-/blob/master/tests/docker/docker.py#L675
https://gitlab.com/qemu-project/qemu/-/blob/master/tests/docker/docker.py#L78

Maybe the fix is to remove the check if user specified an explicit
engine. But in this case, there is a problem with podman-remote not
being detected anymore.

We can fix this by introducing engine=podman-remote, and skip the check
if engine is explicitly set.
What do you think?

I'm open to any other approach as long as we can have something fast
once we initially probed what is available.

> With regards,
> Daniel


