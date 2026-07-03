Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C66C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhZv-0000LJ-Se; Fri, 03 Jul 2026 13:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wfhZj-0000F8-Sx
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 13:21:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wfhZT-0004z5-4m
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 13:21:15 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GJ7Ox477632
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 17:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DP5AT2M142uT7rptQPbx4cdi40WM4hhoj17SFPd2ApU=; b=bS4reToMF3DMmuqk
 Pr5XJlnZML53hX9wqkyF+Pm+0pGe89qzlRpzEEfFdwYRIWtCqRQW7EzXagjOZqDp
 HisSdU5BK9OUjkmL8fALdP0rIjXkexkPYDI1rKYWfiSk5a6IvPCg+3ooPiVClMx2
 NSb7bpGlzhlRdDpzegE6j257MiIvphdN6hRQu4TnKL67Z7BbtNfDm2/upXDPKLRJ
 iQwvNRD3ZSepVH/NZoYOHEBJLaOyQ2EW/hOWaKe09ODPwXi8gZcTbUaJ1NiEj3Yl
 +Aoi43T8P3vaFn2Et+i0ObQlhI5dnxKnRvDU8gc5T0fG3/bVdUN7ZvJ+kMotmBmY
 yjQlwQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eyc2mn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 17:20:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-381abcccbf4so264918a91.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 10:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783099255; x=1783704055; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DP5AT2M142uT7rptQPbx4cdi40WM4hhoj17SFPd2ApU=;
 b=RPAOKqG2BOqBaPvVJOaXEn3ZZ63eHflHKLazA+fX+XZi7MmbqPenyAXGf6SMVUbxL7
 DYQ4vblh2qgnvtNW37rJ3szIIETWClD2yeoZTAHP8PeqlFNskSGYe44+vo9LCKohn78P
 G2jb7Dpz0PmP/d3yrwDgCcbcxoK/y5ElULV8u4zOTmzeijq+yyZyTUvPqn6Se6ldyQ1O
 6Kahjd8fUc3Q0F0mXMR4nkcXJ4xCKF8+SfJ+OIIjBxcAY54xiZNPRcQWO8JRlpOvkZtC
 tAkl6mRkBRZ9L7mh4gU++dSNdsha3E1cMU3Z6wG2lJqc0xanZri669g32ivYWBcqZHJT
 snNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783099255; x=1783704055;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DP5AT2M142uT7rptQPbx4cdi40WM4hhoj17SFPd2ApU=;
 b=ATv+oaSXbeYy/DOvW88GqZqhecKZkDP0yUsdMU7l3pp0ShfzSe98mPYukRK+GbzcXX
 Ap04Z3wOEIk3qKAj+OUZTRBzgUF5Nt6avyeHs22oeOspoBcwOS6M2CCTAmYt5eA5ftwO
 xyft6YvwRDJYAWSUQaxWZUZQoPY87W+Hjl3EvhrELKoZ0M445dEl37gAVVFP8PcQBn4u
 F36M48FPtRP4F+nQwodeRTUZTFuq/fCwaFomYSQhyA9KB1sFq7b0w4GIbr/EF4AQp5xA
 DSHhwPLwmv+/h4oXcFSw6seF6qeikH01k+l5+YCK4tOBEPZESF80Odp3YVGEEV0zSM5C
 H3Mg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoIWGa07nUOm5BfozD4+mEcKqf6d0IZIlscIXModG22JKndLqssy7esw6jsdKI3alt2z/JoaL0FN6KJ@nongnu.org
X-Gm-Message-State: AOJu0YzBVP+V66cCNpAhBAStAfsQ3l1ov9FMdHEjF59Dm0+lAd4LqLP2
 77jiLDZs8R+8WVCHtYCOpKEKvRqzG3eTIyYEbBwmw2/vxr5Wy+cAZDpd/JZkfk7hoKuXluom17G
 Z6aIR7SsQwJJ7LSG68u7D5RwO9rhHqstR2NwkMmetSWOdyqhCpiPrWDXJ5A==
X-Gm-Gg: AfdE7cnOAlg+ybn2GrGa4OPuKcRp/qSTfASNq9Px6RMEHF/g+QZIEUy/t/gQWWBzL4P
 5u1oJNOWyL8HMm+0QRH9Oqwv0IUCoDny+c9ZX64+knmuN9L6Fp36xfwK6pyqESg7AB5H6ULpXVW
 f0bneVOL9KyPVYorI8TDk8h0ufS6lVYs2wngGkjVKKKFVtEuTpd8hmumM3YDMmeIIeUGDLN643K
 ySMu3tIM8R73k7DQeObzlP6PzR2Af+ZIdcF1hjId0/TxO84Qy/U31i+wOs+PDsE0zcEF/40bvaF
 oXb5f64P8z22dgW8ewcGYA7yNDDTZjhezVuw3TeAEiDPOn/HOZlXOoim46SwkQlNlfk2HROdDAT
 dhaOzLo0Jss8SowRXGd4glYO19KmL86/M0IL4q1kac4RJOmzQSdgJ9b8MdoQCmmceMChQse4TFG
 l8xQU=
X-Received: by 2002:a17:90a:c884:b0:37e:2505:cde9 with SMTP id
 98e67ed59e1d1-38280d9a4c9mr421598a91.13.1783099255100; 
 Fri, 03 Jul 2026 10:20:55 -0700 (PDT)
X-Received: by 2002:a17:90a:c884:b0:37e:2505:cde9 with SMTP id
 98e67ed59e1d1-38280d9a4c9mr421576a91.13.1783099254513; 
 Fri, 03 Jul 2026 10:20:54 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bb84366sm32921013eec.16.2026.07.03.10.20.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 10:20:53 -0700 (PDT)
Message-ID: <e4721201-da0a-4da1-a9cd-4038ab021ff5@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 10:20:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/23] 9p queue 2026-06-29
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
 <8700308.T7Z3S40VBb@weasel>
 <08184eb6-9acd-4afd-9e3b-65dc89fcbb76@oss.qualcomm.com>
 <2300937.NgBsaNRSFp@weasel>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2300937.NgBsaNRSFp@weasel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE3MyBTYWx0ZWRfX08Gc8+MF96v4
 tyt2Di/B2rPdWMjz7P1mZSVirE67dafjUEfp/WcoCXWCecC5Jbc7Nbbv/Ver8Wpsz3pc1eePCBm
 SQXcPb7keKDU/DiknjCo48DXw/OEqP0sXxjPyYAh1gB+zKzCZ0YVo2iJ5Mpego8pHwsv58+Wdky
 qXlWc6FDjCeBsFsSff4Gnnf7lcs1kBKTpbtpQDhf/wxn+U1D+v4tYR2H5YWiVSO2d3mWHBUvI0f
 rfs+GPuxQ1Qn3t3m6ZHICnxLcgpI7pulGNSFouO4gY5HgvEcCnMGh6razc6mapB1FmwCTJ++76S
 6I9GGP3akcanBcSLxKeTwoGVOnaoK996L5Liuu2BUBdXhW3kGE99bipvFvjmkb7ADgk914t+f7m
 Snbj9rPftbte/fSvYvQqH1z/2arLEzt21+ALLgdzPjFODZfRni79KhgWup+aX87i4kN+gn6ZDzY
 +J+tcqnZhEDRmO3zOUQ==
X-Proofpoint-GUID: tp7t4A6g8re7YNqgQYbA51XXIsLeC-uj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE3MyBTYWx0ZWRfXz/fg/0Mtd3zC
 IUH2aGiKoggN+FxegxffEhkCd5z2HYJSr9O9bfNNT7F6z1swAv0yj1Uvlk8gLfxsi0zYvQnFD5i
 st7s0ViBQffrJJDLs2oEeA7JtLvH2Uk=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a47ef78 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=rzH4WIfCfLfOGIAJGRcA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: tp7t4A6g8re7YNqgQYbA51XXIsLeC-uj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030173
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Hi Christian,

On 7/3/2026 7:36 AM, Christian Schoenebeck wrote:
> On Thursday, 2 July 2026 20:21:54 CEST Pierrick Bouvier wrote:
>> Hi Christian,
>>
>> On 7/1/2026 9:20 AM, Christian Schoenebeck wrote:
>>> On Tuesday, 30 June 2026 09:28:48 CEST Pierrick Bouvier wrote:
>>>> Hi Christian,
>>>
>>> Hi Pierrick,
>>>
>>>> This series brought a test regression:
>>>> $ ./build/pyvenv/bin/meson test -C build \
>>>> --setup thorough --print-errorlogs \
>>>> qemu:qtest-aarch64/qos-test
>>>> ...
>>>> ERROR:../tests/qtest/libqos/virtio-9p-client.c:280:v9fs_req_recv:
>>>> assertion failed (hdr.id == id): (7 == 121)
>>>>
>>>> It seems to come test added in patch 19
>>>> "tests/9p: add 3 xattr FID limit test cases (synth fs driver)"
>>>> This test runs only with slow setup, so I suspect it never worked and
>>>> was never ran.
>>>
>>> Of course I ran these slow tests.
>>
>> I should have added "in our CI" sorry. I'm sure you developed, tested
>> and ran those yourself.
>>
>>> I intentionally registered these tests as "slow" tests as they take a long
>>> time to complete and QEMU tests being notorious on exceeding the overall
>>> CI
>>> timeout limit. So these tests are exempted from running in the official CI
>>> pipeline, but not from mine.
>>>
>>> I just reran them with latest master head. However I am unable to
>>> reproduce
>>> your reported test error so far.
>>>
>>> You cropped the output too aggressively. I need to know:
>>>
>>> - Which test exactly failed? (especially whether it's really a synth
>>> backend> 
>>>   or a local backend test that failed)
>>
>> That's the complete log from the command given above.
>> Note: disk is not full, but the error "no space left on device" is very
>> weird.
> 
> OK, I was able to reproduce the test error. Root cause is that ext4 without 
> ea_inode enabled is limited to ~4KB per xattr block. I'll prepare a patch.
>

Just saw it, I'll test and review it. Thanks!

> For the next time: please note that the most important information is always 
> the name of the test case that failed! There are several ways to run the 
> tests. In the way you ran them, the name of the failed test is printed 
> *before* the stderr block:
> 
> ...
> # slow test /aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-9p-
> pci/virtio-9p/virtio-9p-tests/local/deep_absolute_path executed in 1.63 secs
> # Start of xattr_limit tests
> # starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-22413.sock 
> -qtest-log /dev/null -chardev socket,path=/tmp/qtest-22413.qmp,id=char0 -mo
> n chardev=char0,mode=control -display none -audio none -run-with exit-with-
> parent=on -M virt, -cpu max -fsdev local,id=fsdev0,path='/src/bee/qemu/build/q
> test-9p-local-KKOMR3',security_model=mapped-xattr -device virtio-9p-
> pci,fsdev=fsdev0,addr=04.0,mount_tag=qtest  -accel qtest
> not ok /aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-9p-pci/
> virtio-9p/virtio-9p-tests/local/xattr_limit/default - ERROR:../tests/qtest/lib
> qos/virtio-9p-client.c:280:v9fs_req_recv: assertion failed (hdr.id == id): (7 
> == 121)
> Bail out!
> ----------------------------------- stderr -----------------------------------
> ...
> 
> So here the failing test name was /aarch64/virt/generic-pcihost/pci-bus-
> generic/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/xattr_limit/
> default
> 
> Independent of this particular issue here, I wonder whether there is some way 
> to register a test such that it won't break other people's test pipeline. 
> Because these "local" backend xattr tests are sensible on underlying host 
> capabilities. They are useful for me, but that should not mean to stop the 
> world just because an unrelated test environment is missing a capability.
>

There is no mechanism to attach a criteria to run a test.
In this case, the only solution would be to check this attribute at
runtime (in the test itself), and return 0 to indicate success. IMHO,
that's a perfectly valid strategy. Also, it has the benefit to keep all
the information in the test itself, instead of spreading it across
multiple files.

Functional tests are a bit more evolved and offer some skip
possibilities, and I'm not sure it's worth extending this to other tests.

> /Christian
> 
> 
> 
> 

Thanks,
Pierrick.

