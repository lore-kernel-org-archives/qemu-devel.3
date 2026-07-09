Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C98CC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrF1-0007g1-2k; Thu, 09 Jul 2026 12:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whrEx-0007fC-OW
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:04:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whrEv-00054G-IB
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:04:43 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669Dwa7D1798218
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 16:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1vfzEid5+r2QsPEEpB6Y6RnKpBtGkzHR/14kW9Mgkn8=; b=bD7Imubv/GOxUY/v
 mSCBsFQr0PAzf5lEUDYO1XVMM7TAJwlRnTb+ReayicrXQEMN/f5gLMJNPtkFuOhL
 Wby1XOPbfVXcKW7stuNpjvs+DUksikvZ4TSLCCTfpVWKxQFqMP49GKWYrZbx/3Xv
 LXyAoIIem3UqoNUoHWQTi36UaoKUbk4FBDkKJvezA0GyWKRCHS/m0KhiKuHDC9I9
 wV0w6J2tmkJvENvVbDnqJEASk5uTqOU1ADBhE99QeuLMMnzaRRumrk3Mczls2hGl
 xJmREA63mGFKm0uC11CkpWy6Kplob735wlA5v3GCmgd52EAB2ap8E/4YVmFxKGBN
 nnnFbg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa55vjx3h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:04:38 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ccb6f6a3f4so39695ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783613078; x=1784217878; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1vfzEid5+r2QsPEEpB6Y6RnKpBtGkzHR/14kW9Mgkn8=;
 b=Cf+l2qNoIA59lAcPkufynMAbKVfQiiFzKxS1m46I75SHbw2CXZ4Mflyll9iuwBdM0f
 8h+SE21VDgisOjNC1JADr/MiYwRCJGBw6liQ9ao/rZxkdtkKk7dosdiuyjvlbTpI25kO
 XaSOMsqcTvE5/YJ1sACNVUzBNXPKhbkD7zUYpFfVdOUGeAEW/x8tByJVEPZKQDccvsDY
 D9/Blk21+f31tuSBmwsZ50sh6KaUWebWIv7sSfdebEachJPWAr39vBE/0xNYu4aQfdx+
 Lbn2IYg1mSmrqRWdGX/LcVN5jg7gSdAgGmIW9SSnCz91EMWfPT03a5SOWJ9W7hvYBIHp
 rRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783613078; x=1784217878;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1vfzEid5+r2QsPEEpB6Y6RnKpBtGkzHR/14kW9Mgkn8=;
 b=IOOwpfXlGDjs0bWtm7Gt8gur2Ttsixu1Bqo4uR0k+YXayK57CPb06eVerYVo9sIKJq
 61snrWpRaZCC3FqLKM6wuYb88XTAxEedTbKbC6GVGpSCu38qs4AmaHYOn5K+pvaGcT3G
 XYM1f1QRWrKQ4DwNrMasXv6RZvInSuAc3AXBa8wiIA2xVEYxbR7NTK59zCpO7qqi96T/
 olA84APegophrLf3MlapmYO61TcEG3MiRZQb4Tih1ql3CORQ/Yzqe+ah3KxmqApGQSAz
 kOH5mbs5eFLvz6DrzTqM26M4je+famg3RJWBtNRXXihvC4PN9vSKEtH5+xxuafrjABj0
 RJFg==
X-Gm-Message-State: AOJu0YzX8Xs1ILm3SwWHW0I3vDIOMkg+mMeVn5Grevb1fuUzqK74v1wh
 OYzIvzJvu/3P885kxEHHAduEfG8V9B99a+WXIFNXjZZ62scYhLzCejUzhaDGGwYfDjSg88fk5o6
 5DO2R+aazZTfl4v4RGlomWpNLkLihn986ka6VlLDstfDw6JEiThgtuRKHmw==
X-Gm-Gg: AfdE7ckiq00ajfLyFcEoxTmMLW/ViSWgxD77yJzYO9UAYetNz0ssRWHTAH0FfteWP0C
 VG6k0BB5q67tLl5EH2XvgGScoeMQdIOlwL7DGvQW4hvxtizVnV8Wkppn5PZh44lI5bMt26Souls
 1n6wtC8I7qOaelPHYycrBImXPC3DMvwEn4FYwLR9hErf2z6pDoM1knRmL3LYo6gfuxi5j6Y84nj
 eIQrCXsXE1GQU7nyHzhQlXHwvP/7gnct2/cpMGr2JZz17MDujEp0LPvB8PlTsaxUiNn/9S0TdLL
 2+RPuRhc23MWh0aY4KxQ6uz4CtiMafIWF6gQ3aU2C1j75KUUj670RSSSfiBuT565eibQjRVqck6
 qI3VVsuO3EvCx5PEHRgzM0mc10QhLZXwgHfYVjCTeDIznNz8DVOA3XL+v+WaVoxJyNp9Z/MWWWQ
 ft7yI=
X-Received: by 2002:a17:902:e743:b0:2cc:92ae:b36 with SMTP id
 d9443c01a7336-2cdebd8f359mr37158165ad.24.1783613077888; 
 Thu, 09 Jul 2026 09:04:37 -0700 (PDT)
X-Received: by 2002:a17:902:e743:b0:2cc:92ae:b36 with SMTP id
 d9443c01a7336-2cdebd8f359mr37157685ad.24.1783613077204; 
 Thu, 09 Jul 2026 09:04:37 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d1e26esm47210995ad.44.2026.07.09.09.04.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 09:04:36 -0700 (PDT)
Message-ID: <27dd2663-725c-486a-ab19-f2914d9b8e93@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 09:04:36 -0700
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
 <ak_A20foem8Ry_-M@redhat.com>
 <360aa513-7d40-4a49-babc-f579a1ecf441@oss.qualcomm.com>
 <ak_F9r-TdJSq8f5m@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ak_F9r-TdJSq8f5m@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE1NyBTYWx0ZWRfX0RxG6ic6g1UM
 WPmqvhqGWmsxFXC6IgYchQWKnttp26FBEyFoKk/Twp0EO9C6UouzlNeFxSg7fTpKP62N07IBOua
 GKEnSoXXPUZSTUuw8hp7K1PMLyBK2+LRhSKU5ei4xPiAKAYxjFH4yTB1OrLLS9sNR7bb8J1yU5O
 QjCrenwqMUV+m+TbYciQT1abeqa4TqrVSnyBBgREBTSCZlffvpz8BxWYs9FuqzDBwy+tztNuPJb
 SWiLvWhVmuTG5Cidh1c+I5j8G0GdivmiUZv3g0Md+3c3q/2Z6f518RON8yNqCvDpMK0KmXdw1Bk
 TJAGvyM71BvA9FySnnIR7RmLxIV436vsUcUrtFwfYKdfo+AQe1I8cj8rxcO8x1MpvUPxdOwpse3
 Zx+4R15pw46zK5v7tWyPxyyID9olPLkQLUEfVfqiH82CzmmXfLBdm2umYC5MLz7Hlsmb2WAn4ga
 v3Q7H1yV2ML/sZLXBgg==
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a4fc696 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=8hG23R3pAAAA:20 a=20KFwNOVAAAA:8 a=4s-1RaJTrzerlqRHsIMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE1NyBTYWx0ZWRfX2drMrYvfl9G9
 9h8qJ0lMYY/8UZ0VigpbeSZ8mdaD2MU7IYf6l6hn1Tc6FLxYkyQCZz/YpSCY+eZ+rCbS9Fvuun4
 HqtT03jUiXe9oAEtcFIbtUr+xxYdqxk=
X-Proofpoint-ORIG-GUID: gYCo59dWkGu6Jq5PcFpiEcb1ioZoCB0C
X-Proofpoint-GUID: gYCo59dWkGu6Jq5PcFpiEcb1ioZoCB0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090157
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

On 7/9/2026 9:01 AM, Daniel P. Berrangé wrote:
> On Thu, Jul 09, 2026 at 08:55:08AM -0700, Pierrick Bouvier wrote:
>> On 7/9/2026 8:40 AM, Daniel P. Berrangé wrote:
>>> On Thu, Jul 09, 2026 at 07:48:14AM -0700, Pierrick Bouvier wrote:
>>>> On 2/10/2026 8:35 AM, Daniel P. Berrangé wrote:
>>>>> When a developer's environment is already within a podman container it
>>>>> is not possible to use 'podman' again to create containers. It will
>>>>> usually result in wierd errors such as:
>>>>>
>>>>>   Error: fatal error, invalid internal status, unable to create a new pause process: cannot re-exec process to join the existing user namespace. Try running "podman system migrate" and if that doesn't work reboot to recover
>>>>>
>>>>> Podman offers the ability to talk to a daemon outside the container,
>>>>> however, which could be leveraged by QEMU.
>>>>>
>>>>> This can be used by invoking "podman --remote", or equivalently the
>>>>> separate "podman-remote" binary:
>>>>>
>>>>>   https://github.com/containers/podman/blob/main/docs/tutorials/remote_client.md
>>>>>
>>>>> The current 'podman version' check is insufficient to detect the
>>>>> inability to launch containers, so it is replaced with the stronger
>>>>> 'podman info' check.
>>>>>
>>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>> ---
>>>>>  tests/docker/docker.py | 10 ++++++----
>>>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>>>>> index ff68c7bf6f..9e18b984f4 100755
>>>>> --- a/tests/docker/docker.py
>>>>> +++ b/tests/docker/docker.py
>>>>> @@ -76,14 +76,16 @@ def _guess_engine_command():
>>>>>      commands = []
>>>>>  
>>>>>      if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.PODMAN]:
>>>>> -        commands += [["podman"]]
>>>>> +        commands += [["podman"], ["podman-remote"], ["podman", "--remote"]]
>>>>>      if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.DOCKER]:
>>>>>          commands += [["docker"], ["sudo", "-n", "docker"]]
>>>>>      for cmd in commands:
>>>>>          try:
>>>>> -            # docker version will return the client details in stdout
>>>>> -            # but still report a status of 1 if it can't contact the daemon
>>>>> -            if subprocess.call(cmd + ["version"],
>>>>> +            # 'version' is not sufficient to prove a working binary
>>>>> +            # for podman. 'info' is a stronger check that is more
>>>>> +            # likely to correlate with ability to create containers,
>>>>> +            # and required to detect the need for podman remote
>>>>> +            if subprocess.call(cmd + ["info"],
>>>>>                                 stdout=DEVNULL, stderr=DEVNULL) == 0:
>>>>>                  return cmd
>>>>>          except OSError:
>>>>
>>>> Taking a look at why tcg tests are slow to compile, I reached this
>>>> commit. It seems like that calling 'podman info' is 5 to 10 times slower
>>>> than calling 'podman version'.
>>>> Thus, a container run now takes +1s when it was 0.2 before.
>>>>
>>>> On my setup, podman (remote) version fails correctly if it can't
>>>> establish a connection.
>>>>
>>>> The commit description briefly says
>>>> ```
>>>> The current 'podman version' check is insufficient to detect the
>>>> inability to launch containers, so it is replaced with the stronger
>>>> 'podman info' check.
>>>> ```
>>>> but it's not what I observed.
>>>>
>>>> Do you have more information about what is the exact reason we can't use
>>>> 'podman version' for podman-remote?
>>>
>>> My developer env involves toolbox, which is a wrapper around podman:
>>>
>>> "podman version" is not an operational check - it is effectively
>>> nothing more than a variant of command line "help". Just shows
>>> the binary can print to stdout.
>>>
>>> By contrast "docker version" is useful as IIUC it shows you can
>>> connect to docker daemon, but podman is daemonless so the 'version'
>>> chck doesn't offer any useful proof.
>>>
>>> "podman info" is an operational check that correlates with the
>>> ability to actually create containers.
>>>
>>> ⚙️  [host:fedora-44 ~]$ toolbox enter almalinux-toolbox-9 
>>> ⚙️  [podman:almalinux-9.8 ~]$ sudo dnf -y install podman
>>> ⚙️  [podman:almalinux-9.8 ~] podman version
>>> Client:       Podman Engine
>>> Version:      5.8.2
>>> API Version:  5.8.2
>>> Go Version:   go1.26.3 (Red Hat 1.26.3-1.el9_8)
>>> Built:        Tue Jun 16 23:52:20 2026
>>> OS/Arch:      linux/amd64
>>>
>>> ⚙️  [podman:almalinux-9.8 ~]$ podman info
>>> Error: fatal error, invalid internal status, unable to create a new pause process: cannot re-exec process to join the existing user namespace. Try running "podman system migrate" and if that doesn't work reboot to recover
>>>
>>> ⚙️  [podman:almalinux-9.8 ~] $ podman --remote info
>>> OS: linux/amd64
>>> provider: qemu
>>> version: 5.8.2
>>> ..snip...
>>>
>>
>> In this case, isn't the problem is that the environment should not have
>> podman installed if it can't actually create containers?
> 
> podman *can* create containers by using the '--remote' flag, which
> is what we made work in QEMU.
> 
>> Considering this, I think it would be better to have a "fast" default,
>> that only checks version, and leave the rest to the user to make sure
>> their env is correctly configured (or that they remove podman if that's
>> not the case).
> 
> My env is correctly configured so that podman --remote works. Doing
> onmly a version check will make QEMU not work once more.
>

In this case, maybe we can test first podman --remote, before podman.
If it can't connect to podman socket, version returns an error as expected.

This way, it *works* on your personal setup, and it's fast for everyone
else.

Sounds like a good compromise?

> With regards,
> Daniel


