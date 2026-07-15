Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE932C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk2NF-0003RQ-E9; Wed, 15 Jul 2026 12:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk2NC-0003RG-3D
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 12:22:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk2N9-0001OE-QA
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 12:22:13 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FE3clf3806280
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 16:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cUpcyrggQi4C7UrmzE+NfJE17nGpcXOdgO3g1x3vbH8=; b=K6Du/b2RBpYkOH8C
 5dN9OKalT0YNmssDlai4I8dTOBbNYjbTdzJ9A0Igfu03xJYWBxAxNCCKKQg8UQOH
 9Jvos1lF1NQPsGyRLuumNvFUQpIJ8IYy9UXPvjs0p+k1m+Qc9G4CVj+AAk9GKjSq
 wj9FdO3gCxSnVyNa4P8T7BKZrQNeOzqMAAclltG+qKzUR3/Wcmzn5DkO76aMdnBP
 lnucGkxzq5/Mag5E/RFZ1wRhh7E68Cga2gxLsA2v+Lbft7k2oTfwHjwrjCW7Qeqz
 B1diWUndJUgCQgNCAanzAzkZp0bbmVH9nH5zS2wtbG9RZRqu19WxaID42y180WFI
 SOmRpw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe56hadam-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 16:22:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cc86a9ef97so120256575ad.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 09:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784132528; x=1784737328; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cUpcyrggQi4C7UrmzE+NfJE17nGpcXOdgO3g1x3vbH8=;
 b=SChjHhRLpjdYEOb9NnxwitD/M0V54VyUBy+a6iqNX61zmuJsI+TKXGPF4zc7lWPn6j
 WR7CFdMKMSBVcoINSyt+Js+C9FFenFAcVOshtgJCP73Ro8ktP8u1H8Yb7vrws7vTOsv8
 xheRJIma4sRuDgm/69ZDYRBt/0kR5bwrmqEp/El3wkXlCsu/Ot60H6aJCgeNW+InrWXO
 Dzber0kNXjy+TU9NxrM6W1LRTz382MFjEJkseMjyj30FID8L8/MI3qk4se5P62WCeqHo
 ONyuB0TOJrFSZ9Ac5NgtimaSe/t2h8Li7/fsrQu3Qpp+kKc4NLnLKF0cqHu6jAUJcHBS
 xjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784132528; x=1784737328;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cUpcyrggQi4C7UrmzE+NfJE17nGpcXOdgO3g1x3vbH8=;
 b=gVINpOSqUDNI3Ec10Wgzmt1zJAJRSsOYdmIA/Rm5Pa8znQ2C39aDfxWgTM0TSO+UEN
 Ucq6OSUGGAf9Nt6JDjrhX/1qSlAZXxHT7C8AAbSlHI6WTIbPahNFEi0E2ae8k+gB7uS5
 PXMv1/m4uo2J/FmYULaTNbgEDhjV6FGrmxvQMofz2qEvCi5zLYReRUbRHMgi7VNXHI3Y
 8HT7Gcn+5/tf4ot9GNthJkdgL+KKFaN3UX+JU0T3CsxoiymKT2jp9f6V+KNUEYyYY+rk
 HbOEysKaAskELUtYDbfhaIwI5e0SLx5cUG0qiqjmRsGZtpZVmubBrh4LFtLq1kNkS9c8
 GsTQ==
X-Gm-Message-State: AOJu0YxphpZ94+swo97CkdIb0R2gGIfUMTICfGhezz9tc2Y/2597iIjU
 v88S7Q4fH2mN7F4kUg+XWSpHDq61X0z0RAYZQHq3kF7qfvU86f7Prp5SpKdAowIpIcVwWFTqrjh
 faNg6HaQ+cRf6ZU1gsPWJtTVbEksMxowZ+q+maUsszS25/m4jmPea+uRIbQ==
X-Gm-Gg: AfdE7cksikjPa3gJJOdFAjLscuQbtMMmD5LCkZsrSXJAU4VC3HP3vHw6149d4A9VLgQ
 2djEZv7IcHAJwkb2WvKtEtwCedYiq4VKZ+ZJrOLwbX0BX1XEWLitBF8ZgO6AAvIYqAqdyb1tEdH
 IGq7VeePuYfxAa/TiugqYHO8CS19AyLDvicAn76PCHqfABiiTcvKgDB3yrVKyDCbXvce5+mdUsG
 kY4aY1X+owvZ8WAXKL0s2M5e412ve87LmMJQtH25ZVzqHwOv63QDVpOXbipw801Vge+jT8aa8Cn
 DsskiyNCOoCehDWsQeNb1DjbIQckUqlSzz+P2drInC0c/LCCug8fheCVY8K+HjK7JIcuzkc3JPm
 B7HobpDA15MPAjfWsFfO+3NWUET+VLbJx6JAd3preDiq5O6v8+Dh+OdyXTAKFY5UdHX2b9LRVz0
 Hps40=
X-Received: by 2002:a05:6a20:2590:b0:3bf:ba89:5236 with SMTP id
 adf61e73a8af0-3c34d615499mr8596077637.33.1784132527797; 
 Wed, 15 Jul 2026 09:22:07 -0700 (PDT)
X-Received: by 2002:a05:6a20:2590:b0:3bf:ba89:5236 with SMTP id
 adf61e73a8af0-3c34d615499mr8596035637.33.1784132527169; 
 Wed, 15 Jul 2026 09:22:07 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6c10dcsm3280164eec.23.2026.07.15.09.22.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 09:22:06 -0700 (PDT)
Message-ID: <2bd87f8d-c5f2-44c1-9a3b-994e7607cd72@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 09:22:05 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aleyWsC-JqqnIV8k@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE2MiBTYWx0ZWRfX0OJZVtLJnIoU
 v6oWC+SESDB0e0jzRwIuX7qTJePZS+eChsuT54T2Oy/6mnPWcJNhg2rnyLYhSvwX01guIkU9cuz
 B1KgRPx1I3D3l1Ws/GHxzuYSdmBZ84Q=
X-Proofpoint-ORIG-GUID: aN3SGp9uUQLKLydIo2ce28asEoqkfqgZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE2MiBTYWx0ZWRfX21X8Ejo48/1C
 UmWfn+JVLpESTxG+btACoNgZ/2gO3hCD9VPNSg9ol5wNqeJtiXVQkV0ETY8nO/M0iqFN8V6XRSi
 0xWYEa8RDNzBNcOOHJG5+7lvKdVmChEC6zlNuNJc87kSsyPjuKpLJ8VV2NQ7fmEhvBnPu4TSDkV
 vT/8v04md9GSuxyx2osmxluTeOk2PuHUpdw+okiFbC9z9JwI1ZZIBKgbe1WU6np19leI9JZYt/0
 mjWN1y6+NXdtkS9oAssKbuBaFA/+jrhToFk+Zro0fjkAOJHp6QXYUs/a/v3XZlNlVWOgA3EvqhJ
 e3xMv/avJwugeBwpc8kQU9E8UCPJJVT3ygc2RsvMpnxmv/M1w8zlBa/wHytbseYnCztjYZyQBXq
 +maVvo3kKuUHWA6wnJkazLoXiemp3pPaaXF+6QDWx86AKYacCrzvFatrflnPGVKdmzLZteBCy9P
 +wUoxJqaAHaAKAuOCPQ==
X-Authority-Analysis: v=2.4 cv=LpKiDHdc c=1 sm=1 tr=0 ts=6a57b3b0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8
 a=d1pjAn385mXbiR3C2r4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: aN3SGp9uUQLKLydIo2ce28asEoqkfqgZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150162
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

On 7/15/2026 9:16 AM, Daniel P. Berrangé wrote:
> On Wed, Jul 15, 2026 at 09:07:18AM -0700, Pierrick Bouvier wrote:
>> On 7/15/2026 3:42 AM, Daniel P. Berrangé wrote:
>>> The '--engine' arg accepts either 'podman' or 'docker', which is
>>> not sufficiently granular to map directly to a command. This
>>> means that  docker.py still has to then probe the exact command
>>> to use.
>>>
>>> Meanwhile the 'probe' command prints out the full command to use
>>> but this cannot be passed back to docker.py to avoid probing
>>> again, so the caching is only useful in the few case where we
>>> run a container directly bypassing docker.py.
>>>
>>> Address this by replacing --engine with --command for docker.py.
>>>
>>> This in turn requires the --container-engine configure arg to be
>>> replaced with --container-command.
>>>
>>> With these changes the container command is probed at most once
>>> during configure and never again, while running in an unconfigured
>>> tree will still probe on demand.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>
>>> In v2:
>>>
>>>  * Don't set container_command to "no" if 'probe' finds
>>>    not viable binaries.
>>>
>>>  configure                     | 25 +++++++------
>>>  tests/docker/Makefile.include | 13 ++++---
>>>  tests/docker/docker.py        | 67 ++++++++++++-----------------------
>>>  3 files changed, 40 insertions(+), 65 deletions(-)
> 
> 
>>
>> I still observe the same error when running make-tcg without
>> podman/docker installed.
>> bash: line 1: no: command not found
>>
>> And I will suggest again to include in your series:
>> https://lore.kernel.org/qemu-devel/20260710214343.2065491-27-pierrick.bouvier@oss.qualcomm.com/
>> and detect if probe command worked or failed, and adapt behavior based
>> on it. Existing behavior to compare to a string "no" is a very
>> unfamiliar pattern for any command. `which` does not return no for instance.
> 
> That didn't do anything for me when I tested it, and this current
> patch did fix the problem. Are you testing on top of a vanilla
> git master, or did you have other patches that aren't merged
> upstream.
>

Originally caught on GitHub.
If you can survive to have to log on this evil platform:
https://github.com/p-b-o/qemu-ci/actions/runs/29410261308/job/87335442476

Which I reproduced on my machine locally using the command I posted at
the end of my email.
Top of master + this patch, without any other patch.

> When /usr/bin/podman was absent
> 
>  $ ./configure --target-list=s390x-linux-user
>  ...
>  $ grep CONTAINER build/config-host.mak 
>  <no match>
>  
>  $ make run-tcg-tests-s390x-linux-user
>   changing dir to build for make "run-tcg-tests-s390x-linux-user"...
>   make[1]: Entering directory '/home/berrange/src/virt/qemu/build'
>   ninja: no work to do.
>   /home/berrange/src/virt/qemu/build/pyvenv/bin/meson introspect --targets --tests --benchmarks | /home/berrange/src/virt/qemu/build/pyvenv/bin/python3 -B scripts/mtest2make.py > Makefile.mtest
>   make[1]: *** No rule to make target 'run-tcg-tests-s390x-linux-user'.  Stop.
> 
> configure has correctly skipped setup of the tcg cross
> compiler targets.
> 
> When /usr/bin/podman was re-instaled it once again
> worked
> 
> 
>   $ ./configure --target-list=s390x-linux-user
>   ...
>   $ grep CONTAINER build/config-host.mak 
>   CONTAINER_COMMAND=podman
> 
>   $ make run-tcg-tests-s390x-linux-user
>   changing dir to build for make "run-tcg-tests-s390x-linux-user"...
>   make[1]: Entering directory '/home/berrange/src/virt/qemu/build'
>   ninja: no work to do.
>   /home/berrange/src/virt/qemu/build/pyvenv/bin/meson introspect --targets --tests --benchmarks | /home/berrange/src/virt/qemu/build/pyvenv/bin/python3 -B scripts/mtest2make.py > Makefile.mtest
>     BUILD   debian-s390x-cross
>     BUILD   s390x-linux-user guest-tests
>   tests/tcg/s390x-linux-user: -march=z14 detected
>   tests/tcg/s390x-linux-user: -march=z15 detected
>   ...tests running...
> 
>> You can test next patch using podman (which it seems you have):
>> ```
>> podman build \
>> -f tests/docker/dockerfiles/debian-all-test-cross.docker -t all
>> podman run -it --rm all -w $(pwd) -v $(pwd):$(pwd) all \
>> bash -c "./configure && cd build && make all -j32 &&make check-tcg -j32"
>> ```
>

Try to run the exact command above, and we'll see if you can reproduce
or not.

> I've run 'make check-tcg' and it correctly skips all tests when
> podman is absent
> 
>   $ make check-tcg
>   changing dir to build for make "check-tcg"...
>   make[1]: Entering directory '/home/berrange/src/virt/qemu/build'
>   make[1]: Nothing to be done for 'check-tcg'.
>   make[1]: Leaving directory '/home/berrange/src/virt/qemu/build'
>
> 
> With regards,
> Daniel

Regards,
Pierrick

