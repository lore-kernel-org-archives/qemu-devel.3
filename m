Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B322C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk2fK-0003GU-8f; Wed, 15 Jul 2026 12:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk2fH-0003D0-0n
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 12:40:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk2fC-0003kE-Kf
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 12:40:52 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FE3YUj3926041
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 16:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AmFbL+vRPCP/uWrO0lb+RhA07gxVor/lKwHlBllbF/g=; b=PUlgbluHtGn/OQMX
 DwTKoKR+jflOKxabx9DC+BodqtjVvKZT64Sqy634YRjsC/rWwhVM3YyqW1qMPGqz
 X0rfmGD5crwCAIAShwW09+MdJzyG9UGl8ef/zo1MI2a7klpBfXKrZkRq1ltJ+Z7t
 Ew0IGoxjvVZCzR4TgqpPnqldNBdVXBwPbxzKxLs77OhpJhfJjNxwJ2xva0KqBpuR
 KAlRXwJt2UU+ewWmgRwA9tOK4ckQmeawkbfn2ERo6vJNmEZ7A891ScleXcKp+AND
 XN8qWm0MqWk5DXYeipNEjiS7rqMVpHUKfF41n4B0SlX3wDZsfnaJrgSq24T3GyCN
 YrzhuQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7q61t5q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 16:40:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so8298436a12.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784133645; x=1784738445; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AmFbL+vRPCP/uWrO0lb+RhA07gxVor/lKwHlBllbF/g=;
 b=GTI8Wj7UFVbXWpXpYascd+1L0ayCuPB8lxRIxs3JLp+7DzMl/wcWe16EXaMsVCkK8+
 X1V9LZ3DIkkJz5Nr0GkN8CsmaynJRIh0GW6F3XBp99FSYklCRHaxytz/F2Czx9Q5FmDJ
 +pJTpqV9vxxoSKCw3u1WIB9j0h4YWbi0yKNz0S5jzMO05Red2UvXvuPihvvlvR3C1ZkQ
 WMTiYi6IIrwJ44HZdIKfEmstcS18ujLlQeuIdiDwX8DFcVtlyyHeHVtm1Wgpi2oxF5Ag
 v48cNJoTxWesw5uWPdYb1QMgHj+/5nRrLaejvKjZuMjOmw+S07bOozPycjObPP/5HO9X
 ZwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784133645; x=1784738445;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AmFbL+vRPCP/uWrO0lb+RhA07gxVor/lKwHlBllbF/g=;
 b=MCLcUIEKIy3benAe0HKpBEKc4IjxITj3zphdc6jS+7LLDlxTUit7RH2g+pBpHdagD8
 OMsrRsTmlUl0jN7k/j2gsIs1AFtnitJ5VRZBoNta8lgvV6qVVFDZBpzdExZGNOZgFgu9
 3X8G7feyL7OVZb9ShRXz23Knb5/94cOVv3YddW4LBOkUbDsRv8+lftb4Hz6Vn6Ho381C
 BzEKoQBIHni3a95WMyQJgEgFEtqmiCnNgP/tRnoRNbj5bbl271+yz4H76GQlR+2P2+KD
 KrqgRD/jPrVD4Y6OMHux5SC7zzJshUAFdME5RjxF+GQEfjzSygeic8xXWb73dbrfuqQz
 GHHA==
X-Gm-Message-State: AOJu0YyxnWG/2ga2ya0f1tgE5CF4JQjWk2kpkrQoHKElsHyy+ttFSVtm
 e7/DPiwAl2/35AaN/owRxYTyyV1+qy0MZ4LCVcSSCEGfRyLhGYuJGAj7M1GRrrwLYvijA0wM8Ya
 UiUU6nU1anqXii4iu75hDT/M9dylUQSck1jsXO71rxEldK/8tJOxeVJ1ZVA==
X-Gm-Gg: AfdE7cnrDBf7/JslXdpk8MRDVO3jODlsZLmHC5RIH4fUEPoEtwaRQgySU9Ig2in4Mkc
 qtlmMBasP4z0/n4i+o2hN5ReP9DThm1zqa3BVGwJz+vugOj05Lkccc4okOKW8exdNZCbL2hOcTQ
 dOAp8mDBmLzM3yS0APEa2nmtOKA/XVC7Z4yF20Yipcl3dW4r6JuJItdoMXShozfVRydtg0nv9Jp
 dr29wAkqnvb5G1CBz7NEq5Kq1MjOjUu90NHGDd0UW+Q8woqLvysIw5c3DlB6+wmCVzraqlZvjBU
 luI0+9bgoV64BSpT0pNTgNgBkAHEFoQP6b6kgJqQdPg5F5ZHAaOw+pxr7t2zLNHB9e26738uNjM
 225FwC9YSQ04X/JPciU+h5IESRn/vszl1e3x1lSbFzGAaN4QB6pZvkpxcK6Nm8Gaa4NY4AMxO3j
 XhIqA=
X-Received: by 2002:a05:6a21:4849:b0:3c3:791e:5e18 with SMTP id
 adf61e73a8af0-3c3791e6d11mr1612280637.7.1784133644914; 
 Wed, 15 Jul 2026 09:40:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:4849:b0:3c3:791e:5e18 with SMTP id
 adf61e73a8af0-3c3791e6d11mr1612247637.7.1784133644303; 
 Wed, 15 Jul 2026 09:40:44 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6ec32bsm2293037eec.29.2026.07.15.09.40.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 09:40:43 -0700 (PDT)
Message-ID: <19f8e055-5e2a-4400-b972-0169333e0674@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 09:40:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/docker: ensure container command is probed at
 most once
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260715104218.1110301-1-berrange@redhat.com>
 <e3932087-16c8-4e34-98cf-c20cf7db9531@oss.qualcomm.com>
 <aleyWsC-JqqnIV8k@redhat.com>
 <2bd87f8d-c5f2-44c1-9a3b-994e7607cd72@oss.qualcomm.com>
 <ale137WxCZrnk7US@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ale137WxCZrnk7US@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE2NiBTYWx0ZWRfX4MCOXEHJgIp1
 dhf9LDZZTbUnrdTlaHxUG73/f4QXS3be83TWlmKzrZIyTXkAUW51KuIHjU2LOh4rM7fV+gVxAvL
 FMy22h+/PKxFDvJKO3mt6H4c1N7tR5w=
X-Proofpoint-ORIG-GUID: c8LG7LzzyOIaxjW0p5s3J3Y-4kqZQQMy
X-Proofpoint-GUID: c8LG7LzzyOIaxjW0p5s3J3Y-4kqZQQMy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE2NiBTYWx0ZWRfX1raGNVrpfOdZ
 BlW5BhA2tE5EK1JyG6sAhrxHn0q0ciKsgDCZzWFckrB+Yr0Kf+cT24N1Jpxx6mOpqRbHkZPl+ME
 Y0+zj39Uus6a82rAk6LNvZ8eB5wmJkv2EbWhBkVXdANMwb0/+fGR8wC3iwnd8L0GV1Ta5a5y1Kd
 uLfdeCZbSmYl/B7xW8P0V/FyXrzQAq3RLrsLiztm2sW/Vju3uzeijgnB2OGw4+GUkY63qUlIM+h
 QSc3D9RLUtZOYxecdIpSM/bDXOI96jF0cxBWJevi8YgDZ0rPNYCEhfZ1DWCTXof0//SE7gPG86K
 EnAxCQabODrjV1u0CJjZiXqkGpf6JWVHDs7z8N1F1kKu6QQhnVSuajiS5yE15c4rYI6TmupOsxU
 MhIoaaohmPT6+y3RQaerPkW4R2DvOmKttFV3DiDBqYrmpTjf5+JD35pKDoNXEHSQ5zJj1rJKbsZ
 so3/+iWVCgXEB2TLT9Q==
X-Authority-Analysis: v=2.4 cv=BajoFLt2 c=1 sm=1 tr=0 ts=6a57b80e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8
 a=d1pjAn385mXbiR3C2r4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150166
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

On 7/15/2026 9:31 AM, Daniel P. Berrangé wrote:
> On Wed, Jul 15, 2026 at 09:22:05AM -0700, Pierrick Bouvier wrote:
>> On 7/15/2026 9:16 AM, Daniel P. Berrangé wrote:
>>> On Wed, Jul 15, 2026 at 09:07:18AM -0700, Pierrick Bouvier wrote:
>>>> On 7/15/2026 3:42 AM, Daniel P. Berrangé wrote:
>>>>> The '--engine' arg accepts either 'podman' or 'docker', which is
>>>>> not sufficiently granular to map directly to a command. This
>>>>> means that  docker.py still has to then probe the exact command
>>>>> to use.
>>>>>
>>>>> Meanwhile the 'probe' command prints out the full command to use
>>>>> but this cannot be passed back to docker.py to avoid probing
>>>>> again, so the caching is only useful in the few case where we
>>>>> run a container directly bypassing docker.py.
>>>>>
>>>>> Address this by replacing --engine with --command for docker.py.
>>>>>
>>>>> This in turn requires the --container-engine configure arg to be
>>>>> replaced with --container-command.
>>>>>
>>>>> With these changes the container command is probed at most once
>>>>> during configure and never again, while running in an unconfigured
>>>>> tree will still probe on demand.
>>>>>
>>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>> ---
>>>>>
>>>>> In v2:
>>>>>
>>>>>  * Don't set container_command to "no" if 'probe' finds
>>>>>    not viable binaries.
>>>>>
>>>>>  configure                     | 25 +++++++------
>>>>>  tests/docker/Makefile.include | 13 ++++---
>>>>>  tests/docker/docker.py        | 67 ++++++++++++-----------------------
>>>>>  3 files changed, 40 insertions(+), 65 deletions(-)
>>>
>>>
>>>>
>>>> I still observe the same error when running make-tcg without
>>>> podman/docker installed.
>>>> bash: line 1: no: command not found
>>>>
>>>> And I will suggest again to include in your series:
>>>> https://lore.kernel.org/qemu-devel/20260710214343.2065491-27-pierrick.bouvier@oss.qualcomm.com/
>>>> and detect if probe command worked or failed, and adapt behavior based
>>>> on it. Existing behavior to compare to a string "no" is a very
>>>> unfamiliar pattern for any command. `which` does not return no for instance.
>>>
>>> That didn't do anything for me when I tested it, and this current
>>> patch did fix the problem. Are you testing on top of a vanilla
>>> git master, or did you have other patches that aren't merged
>>> upstream.
>>>
>>
>> Originally caught on GitHub.
>> If you can survive to have to log on this evil platform:
>> https://github.com/p-b-o/qemu-ci/actions/runs/29410261308/job/87335442476
>>
>> Which I reproduced on my machine locally using the command I posted at
>> the end of my email.
>> Top of master + this patch, without any other patch.
>>
>>> When /usr/bin/podman was absent
>>>
>>>  $ ./configure --target-list=s390x-linux-user
>>>  ...
>>>  $ grep CONTAINER build/config-host.mak 
>>>  <no match>
>>>  
>>>  $ make run-tcg-tests-s390x-linux-user
>>>   changing dir to build for make "run-tcg-tests-s390x-linux-user"...
>>>   make[1]: Entering directory '/home/berrange/src/virt/qemu/build'
>>>   ninja: no work to do.
>>>   /home/berrange/src/virt/qemu/build/pyvenv/bin/meson introspect --targets --tests --benchmarks | /home/berrange/src/virt/qemu/build/pyvenv/bin/python3 -B scripts/mtest2make.py > Makefile.mtest
>>>   make[1]: *** No rule to make target 'run-tcg-tests-s390x-linux-user'.  Stop.
>>>
>>> configure has correctly skipped setup of the tcg cross
>>> compiler targets.
>>>
>>> When /usr/bin/podman was re-instaled it once again
>>> worked
>>>
>>>
>>>   $ ./configure --target-list=s390x-linux-user
>>>   ...
>>>   $ grep CONTAINER build/config-host.mak 
>>>   CONTAINER_COMMAND=podman
>>>
>>>   $ make run-tcg-tests-s390x-linux-user
>>>   changing dir to build for make "run-tcg-tests-s390x-linux-user"...
>>>   make[1]: Entering directory '/home/berrange/src/virt/qemu/build'
>>>   ninja: no work to do.
>>>   /home/berrange/src/virt/qemu/build/pyvenv/bin/meson introspect --targets --tests --benchmarks | /home/berrange/src/virt/qemu/build/pyvenv/bin/python3 -B scripts/mtest2make.py > Makefile.mtest
>>>     BUILD   debian-s390x-cross
>>>     BUILD   s390x-linux-user guest-tests
>>>   tests/tcg/s390x-linux-user: -march=z14 detected
>>>   tests/tcg/s390x-linux-user: -march=z15 detected
>>>   ...tests running...
>>>
>>>> You can test next patch using podman (which it seems you have):
>>>> ```
>>>> podman build \
>>>> -f tests/docker/dockerfiles/debian-all-test-cross.docker -t all
>>>> podman run -it --rm all -w $(pwd) -v $(pwd):$(pwd) all \
>>>> bash -c "./configure && cd build && make all -j32 &&make check-tcg -j32"
>>>> ```
>>>
>>
>> Try to run the exact command above, and we'll see if you can reproduce
>> or not.
> 
> Oh it is the bash-ism  test "==" vs "="
>

Maybe next time, you can try the repro before saying "it works on my
machine"™️ :). Someone with your experience knows that something
unexpected can always happen.

> With regards,
> Daniel


