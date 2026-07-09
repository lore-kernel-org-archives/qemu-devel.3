Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37AFC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whr5p-0002tt-Gx; Thu, 09 Jul 2026 11:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whr5n-0002tj-Nx
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:55:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whr5l-0001n9-Bc
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:55:15 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669FbERP2248370
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 15:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ackWFQeYY/AFuQ/leFWNgGevDLDB+HwIlDF995Y4+Ck=; b=oKNepXzbzdw5JGva
 eKF1fphaZvvgDHCxs6nuqcn9hxnHiG0d6sEfnRjgIWdOXCOgZtED7v5FjHKs3+cG
 6xMjcl5Iixuk/YzbCG3uggfbtsVadNe9xjaY22nyZfxKEiTC0Kaux04X+mKI+V8F
 OJUjELxkU7xIjriGTNwm6H4cwztehmwqjIcIgB2O/okHdohe6xnyW7wj9OoUrg0Y
 0QI3aEi75h85VWBfjNSOYzYXGjap4ZkuE0gWPsRUWWzNKjGo39UDOvWLtnSMd2pE
 o93KhVHx2nOwivhRxTeSjEWHSgbmA0ggWAni83Fi0fqAcVlpworM/ByDGW7luM5/
 H3k4VQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeesr27s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 15:55:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ce7dfd33ffso1562325ad.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 08:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783612511; x=1784217311; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ackWFQeYY/AFuQ/leFWNgGevDLDB+HwIlDF995Y4+Ck=;
 b=DYr9i0PwFJ/znrBK/gjPbPIfQXjuqsG6PmjdGxb5/LVVhmIc2yVmG5I5GoLmEaeNJg
 o1E1Cjhr9J5okitRUK9xnNDxL8a1dlYamZlgaxwWcZn0Y3fHwR8wHHU/NzUqWyyIlE/2
 aSdsQyhVgCnQd+keuMF9cLz02eGcORNDoUcUcFhbLYxev/9X+ci5yb5uYBTTuPPoVYfn
 z9zgLrAkdn/KLVePXdt+t1RwUa/YeWNtePgyeQVPV0FL4GQWojXFDxJd50030YpEUC9f
 KtssW9wsAAdyh+fNXuSwTlHalt9dQD5nVwgQwXcK7a3aCDwWXe33bYJoROMSh+GvxycJ
 8cYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783612511; x=1784217311;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ackWFQeYY/AFuQ/leFWNgGevDLDB+HwIlDF995Y4+Ck=;
 b=jARTJXOU0HgHFlBGE9l+4WBRDOeRrvc5Go+qoI4ZdiTBieIjBp0zIG1MFn7SFey1bS
 0LmQrALO3a/6EsESMGWMpLAIcotth9avz2ZekBEGk0Us8WZ8kP1u4vCfnyol8iIiI3/c
 +AjNM4EuUEqg/IRV2MfJoHE1zcANCL0lZSs9/GbNC8SL7MVSAt3Rq3qac/BsmtZo/Alp
 BznnzdAPD9DrCtwgq71wZBTfT593dTwfOokBwx5YhU2yL/8cYQy2IGUHifJkhIFHW4ja
 93cGFRNRZ+Lozb4uSmTWa1roPires8WeryZNWmtKhIv+txK1cUWHTLJSCQq5DIdPVTHU
 1s3w==
X-Gm-Message-State: AOJu0YyOQPl6+2r4oaH7FeRxQui0tuh8/wSw+wZ3AutDY/khKNjfBrzf
 nqU1N4cDQQGMpbT/nDejENs//DD5xtMOqrYIEHdYS4ikuj30vk+ajQe3lUp6FrNNkEHIoY81ayk
 elrdhESEURiDGJNdhl65ezcGYZuY4mwMfPo1NKENRc4bCYY385Yr2Qd9oNwep0vsSXA==
X-Gm-Gg: AfdE7cnuHcpKcXqT5h1HcxjGHDq9aTVKOYSTc8N5o6Qov33HOlvqLlXLEk2Wr3YlyaP
 1XSRLvHmOwaTjEJbc3PTF3+ECdebDj1hVPybrhn+nPwQJWOW9eKw2vWYD0RG0WY6wuxsGfrPFf9
 DRnbKFs4l6eZY0nuuocskoNcQyrmYpKdT3gRWXJ4d57Vu1wqKmjJjO+DyHh/0c1t8j7Bw6n2+ef
 XXKCb1aotXrRTw4PeysiWECgU076H4LigldFWtjrOAMFrTVVo1rReXjW1dVe3KO/QCdBLyOXbCy
 knM2IEJ/JJZausGLs17AVNNMhEPSYTZJrcd6KloXRPhi86DLR55MVB3KfYtWd3sHm3j0x2n7HtM
 Hbs8rsfDQkSuq0lN+66wFRb8gNz5kL0MY1A2pgzjiKavP36fj06WmJrEi0EktnO4rBK1UxnvMA6
 LthOQ=
X-Received: by 2002:a17:903:2346:b0:2ca:f8ef:33dc with SMTP id
 d9443c01a7336-2ccea477e93mr76396155ad.40.1783612510531; 
 Thu, 09 Jul 2026 08:55:10 -0700 (PDT)
X-Received: by 2002:a17:903:2346:b0:2ca:f8ef:33dc with SMTP id
 d9443c01a7336-2ccea477e93mr76395615ad.40.1783612509940; 
 Thu, 09 Jul 2026 08:55:09 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d59e40sm46609825ad.75.2026.07.09.08.55.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 08:55:09 -0700 (PDT)
Message-ID: <360aa513-7d40-4a49-babc-f579a1ecf441@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 08:55:08 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ak_A20foem8Ry_-M@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dd2Fllzuk7QR-EWxNJLsEDHOHWR3qk6U
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a4fc45f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=8hG23R3pAAAA:20 a=20KFwNOVAAAA:8 a=HfxNxU8e110xYopnPMUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE1NyBTYWx0ZWRfX/cjEjuHINbC4
 CK/A1sjVfJtl6gvxcFAb8iEsU11xaSl6RkLrdpJAjE0F0PAC3wQ/j/c1TuxO4iY/sFtJM9Gnt1P
 SCA51Lr8pFRP9S/cHx6mWRp2eY4lV3M=
X-Proofpoint-ORIG-GUID: dd2Fllzuk7QR-EWxNJLsEDHOHWR3qk6U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE1NyBTYWx0ZWRfX9W42MI7GeCY2
 ojbdTuD/PnTcFxvPwztimbP45R95H0MbFXmN82IO78fV9Yh2IlqmpYB4gaVtTRJYpx34tOB2hWD
 XWQTJTrg/w3bxvl40bmIGDuFpKr6DiVm9WfSp0vDhKIHbgd0evstD9/IzxidjoK1PjoZ0uyEBgT
 CqFDo9vhJihIP8gIgLLRoyiO+n5/myMWHERoKeqm3AL8BB0EAvxnDoqTdTdPMPLRZhMjyRX81DG
 JeTCbkPiFRL5oiwyBf19U6COrQfd2n86UpWDGfLjAWdifQGPua5pMK2PKaisph7x+TLDdhCXRD1
 OnNN9TyJht4OZSm2g5HztA7UR9gPb5MKSPKwvOoCREP/Zms31B0/jUnVEs8p29tJH6AtWdLaBeb
 ld7OdBfQ88Tbg1OV3Fu6K9h4uY4W2TohMemhIqeb+zX8ITWDZAeQLnQfx5we8M51xdGxbjPkUZm
 ML5Nnn5sWfVfEhYwS4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090157
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

On 7/9/2026 8:40 AM, Daniel P. Berrangé wrote:
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
>>
>> On my setup, podman (remote) version fails correctly if it can't
>> establish a connection.
>>
>> The commit description briefly says
>> ```
>> The current 'podman version' check is insufficient to detect the
>> inability to launch containers, so it is replaced with the stronger
>> 'podman info' check.
>> ```
>> but it's not what I observed.
>>
>> Do you have more information about what is the exact reason we can't use
>> 'podman version' for podman-remote?
> 
> My developer env involves toolbox, which is a wrapper around podman:
> 
> "podman version" is not an operational check - it is effectively
> nothing more than a variant of command line "help". Just shows
> the binary can print to stdout.
> 
> By contrast "docker version" is useful as IIUC it shows you can
> connect to docker daemon, but podman is daemonless so the 'version'
> chck doesn't offer any useful proof.
> 
> "podman info" is an operational check that correlates with the
> ability to actually create containers.
> 
> ⚙️  [host:fedora-44 ~]$ toolbox enter almalinux-toolbox-9 
> ⚙️  [podman:almalinux-9.8 ~]$ sudo dnf -y install podman
> ⚙️  [podman:almalinux-9.8 ~] podman version
> Client:       Podman Engine
> Version:      5.8.2
> API Version:  5.8.2
> Go Version:   go1.26.3 (Red Hat 1.26.3-1.el9_8)
> Built:        Tue Jun 16 23:52:20 2026
> OS/Arch:      linux/amd64
> 
> ⚙️  [podman:almalinux-9.8 ~]$ podman info
> Error: fatal error, invalid internal status, unable to create a new pause process: cannot re-exec process to join the existing user namespace. Try running "podman system migrate" and if that doesn't work reboot to recover
> 
> ⚙️  [podman:almalinux-9.8 ~] $ podman --remote info
> OS: linux/amd64
> provider: qemu
> version: 5.8.2
> ..snip...
>

In this case, isn't the problem is that the environment should not have
podman installed if it can't actually create containers?

podman info is not enough neither considering this:
$ podman run -it --rm docker.io/fedora
$ dnf install -y podman
$ podman version && podman info && echo "it works"
$ podman run -it --rm docker.io/fedora
...
Error: unable to copy from source docker://fedora:latest: copying system
image from manifest list: writing blob: adding layer with blob
"sha256:594bd6d79d070efa3007bb9bc092a4889026b51ebcaa7d396d46276a0f315e5e"/""/"sha256:44157061143cb91d5818b1f3d2dc2109476e3efcf3eb9e495c9eb5a7db49c170":
unpacking failed (error: exit status 1; output: potentially insufficient
UIDs or GIDs available in user namespace (requested 0:12 for
/var/spool/mail): Check /etc/subuid and /etc/subgid if configured
locally and run "podman system migrate": lchown /var/spool/mail: invalid
argument)

Considering this, I think it would be better to have a "fast" default,
that only checks version, and leave the rest to the user to make sure
their env is correctly configured (or that they remove podman if that's
not the case).

What do you think?

> 
> With regards,
> Daniel


