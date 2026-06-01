Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B78FCD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 19:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU7vM-0002NI-Br; Mon, 01 Jun 2026 15:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU7vK-0002Mo-5Q
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:03:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU7vE-0008Uh-Iq
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:03:41 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651HoKsY622058
 for <qemu-devel@nongnu.org>; Mon, 1 Jun 2026 19:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dc6tUBe4xqFf/DzRQV/XaRaUiLueLP0BGhUAKDqgiQA=; b=HMPW5kkuDicKFLcU
 rkn1qkQ5X1fal4fO3Q9qz9490P0BTzTaLxFsoOU/l1fsjIe2pArKaRAdoPiGr3dz
 878HO+0BjGEBu7uOFJCNCd7CSZx6rbD2232pXx2dIXJ+uc96DctmdZpo8SZQwkxF
 WsxAthEY148NPFizULj+9QVFqvVf5oKD48Wiisp1/LN+u+3mXDyNXSfRW0fNrUFh
 5QdqRr4IjuP3QGxy9BqtMXqp23Hj3zsq9BHWEvcoqyPSrDb0TLzgErBM9nUu/pO6
 lt5ZqDZad37CMFCv/9B7uUPG727qyCorOk7Fskj131Vd3N5WeRmDRWQZ9CHrhf2n
 ZLYpiQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh954j1p7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 19:03:34 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304e7fbfaf5so4378405eec.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 12:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780340614; x=1780945414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dc6tUBe4xqFf/DzRQV/XaRaUiLueLP0BGhUAKDqgiQA=;
 b=MaPLOKN0fJdTaVojelm7Z0TW7OpfP20rP6vt/JpCqClQnkXO/IZRKOe3JbQ9BHAILw
 6o5tokylmW805qxlxkjNyoZYNSzjSn1Kf+NHqPDc/F/4YwQIKdD9vg7TEej1GdvYTp7Q
 fTtclxx9vPt/BMM+JhD26vMxG59LOv4w7n5zB643J5Xy1elBBU8U25EHVRnZnlh+2LzX
 KXQqZ4GcD8BGkPvVEDHVV/awk1Ebl3NE7hdNmKzldkG8pkg9zFwkCCuBXjkwSdISDbEk
 0S0wBVOdQ8NiRVu1GnQ9i6YuzG2jTBducn0eZEnhDtUDcM3Mdm8ujHFt5kf2mvkgk1S0
 sd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780340614; x=1780945414;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dc6tUBe4xqFf/DzRQV/XaRaUiLueLP0BGhUAKDqgiQA=;
 b=Zjy32ohWlQfNoQG3KN0dgfLdtABSihH31LVXgGTMxgyQufDI2mDAkro593hb+SVh+I
 2HKorNh7OGUS0NdOGCDcmFQOgtoZb0MmdtOejgCnQ9cvX98b0eCW7SOuWQwK2FEk8yrp
 Ce3AnGnbFGY1EveMVk/zR22ESSeuws8XOezff6TK3wqnQpX3HINaBMrVQzEQ0i3xwdPS
 QZiNRgqVjTS8ugJdpQBvrocv+QKjYZ23h4UkwV7AmoSSgtdQtb+nNjJt41xiOyCtI5uM
 CUuStLfNUeJlERs7c1xTkLGmjMsTKDetjtsOB6IGfsKHfotpA1ZPRGT2eKlnmnKTfmne
 H+Ww==
X-Gm-Message-State: AOJu0Yzxb1QK8nSB265jdtSpB7371e4bk7qNAArsYtLHXnQ5vX9U69xY
 9Sfg45rrT97dmn54bNpfd6vylLQ8CdOHLUzyAkz1GPU0ICkG1cibmVtds8ORNzByE95xteKbp+E
 YxeB2c5Ig2Mfi11Dq8II82HoVbcsT2ie1DvJnMWm0DJWK2HwEqODnfOAImA==
X-Gm-Gg: Acq92OFUbKWyd/z7b+Wv1poUd+f8Um34RqQCW9FehKY2wBoDumxb82lzi1xZ++386U6
 UghBYmu+KEH4lp4WsF9sgEVTFbkSTSKp3wIhNRTBcKW9etGfdSIVZhhdb4CZF6x2as8Esa7DU25
 SoLI3EMojoTHKLgbt9+6azWI0J5TUHX+ag32qdCcebaVvXdPn8tsdydy4z3CqGzi1ua6m8dW2Bn
 f42ZX6JlgAPH4nXA8nzm64RvfsD03+1FTO16QqO6fQRzaN9Pn5Vb9oZmpRL291OkGnFoUBzZHKh
 0EwQwG9Nlr4W50MISBeM7vR4UvJtfuQWBRGAd0IN4Ggcvel4dDnqh+ksQhZ44ttjwSYBLh9/vAd
 fCLEGxmUk9U1NTcOv5vPt2cIfXg76YUzniaXD4LKQyjx49+IZ9wAhD1hmkbGS2P6aVLTcGvrlX8
 4PpAD6iHbDO4y9yUoBZBLP+Dwj
X-Received: by 2002:a05:7300:2327:b0:304:b15:17d6 with SMTP id
 5a478bee46e88-304fa49e2c3mr5934343eec.6.1780340613307; 
 Mon, 01 Jun 2026 12:03:33 -0700 (PDT)
X-Received: by 2002:a05:7300:2327:b0:304:b15:17d6 with SMTP id
 5a478bee46e88-304fa49e2c3mr5934311eec.6.1780340612560; 
 Mon, 01 Jun 2026 12:03:32 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed578c48sm9059568eec.20.2026.06.01.12.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 12:03:32 -0700 (PDT)
Message-ID: <c7cc0040-872d-425c-827f-c57db87ee12c@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 12:03:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/39] MAINTAINERS: Fix F: lines
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <cleber@redhat.com>
References: <20260521080511.999266-1-armbru@redhat.com>
 <d52c0fca-3a8a-4d4f-abff-f772605512b8@oss.qualcomm.com>
 <87y0gy8thg.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87y0gy8thg.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DN8TM5lH2cK78ICjHs08qlOCRWNM03-o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE4NyBTYWx0ZWRfXxzfnJpt2vQqo
 cNC9KAib75mQ11aM8QbOQThrV8cLzfvQgJMpjpqxSCGflXElhSJaJm5Bqmnl2dbkPjg49bMWgn3
 FLW2ES9IIVK6YEkjxidj1Oy9wyxV35Y9XRnf0rJ0CFwvQb2CJzUBynqFNbJKACmuzQmq4QsYxMs
 kAgq+OO21BpS2a4Jvs1uIO/iDzH9io6KbolaAqj9EOap8MbWXbS4B+laM1dwSeKx6yAGfs8aqgR
 s61RgarDpdWxh5AUtpbhgrNUcZmlR7CcznaqbqhZOetS3OJys9GybBqggymyPd3ei5eDDTlqMZo
 UzmJ+NPtjtKxWZj+qV9EVg9aOobMseY1RQopKovqW+H0NwVrvYnXoJybUILpBctI4Hm6+SG8wvH
 fYjm5DEYdJg+haI2YPNRwkFAH4kFQVUcWJCFHOO4R6ez8zaPafUXUhWh23XqxNTLAe+WMoQeYZi
 DDJ8ATVwFAEAAyhddig==
X-Proofpoint-GUID: DN8TM5lH2cK78ICjHs08qlOCRWNM03-o
X-Authority-Analysis: v=2.4 cv=VpcTxe2n c=1 sm=1 tr=0 ts=6a1dd786 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=ukH1R-b_AAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8
 a=54paOQyp0KZw2g1SbfMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=zUGFzhdS3I8ccRoxxLmr:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010187
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

On 6/1/2026 3:06 AM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> Hi Markus,
>>
>> On 5/21/2026 1:04 AM, Markus Armbruster wrote:
>>> Quite a few F: lines don't match any files.  The quick & dirty check
>>>
>>>     $ ls `sed -n 's/^F: *//p' MAINTAINERS ` >/dev/null
>>>
>>> finds about fifty.
>>>
>>> Philippe Mathieu-Daudé recently posted a few fixes:
>>>
>>>   MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.docker path
>>>   MAINTAINERS: Cover debian-loongarch-cross.docker with LoongArch section
>>>   MAINTAINERS: Cover debian-xtensa-cross.docker with Xtensa section
>>>   MAINTAINERS: Cover debian-tricore-cross.docker with TriCore section
>>>   MAINTAINERS: Cover python.docker with Python library section
>>>   MAINTAINERS: Fix s390x storage key/attribute device paths
>>>   MAINTAINERS: Fix tcg/s390x/ path
>>>   MAINTAINERS: Correct scripts/coverity-model.c path
>>>   MAINTAINERS: Fix hexagon-linux-user.mak path
>>>
>>> These are in
>>>
>>>    Subject: [PATCH 0/7] docker: Remove LegacyKeyValueFormat warnings
>>>    Date: Mon, 18 May 2026 12:22:15 +0200
>>>    Message-ID: <20260518102222.80735-1-philmd@linaro.org>
>>>
>>>    Subject: [PATCH v2 0/4] buildsys: Stop checking for ESA/390 host
>>>    Date: Tue, 19 May 2026 19:12:36 +0200
>>>    Message-ID: <20260519171240.97420-1-philmd@linaro.org>
>>>
>>>
>>>    Subject: [PATCH] MAINTAINERS: Correct scripts/coverity-model.c path
>>>    Date: Tue, 19 May 2026 19:19:26 +0200
>>>    Message-ID: <20260519171926.98099-1-philmd@linaro.org>
>>>
>>>    Subject: [PATCH] MAINTAINERS: Fix hexagon-linux-user.mak path
>>>    Date: Wed, 20 May 2026 14:39:47 +0200
>>>    Message-ID: <20260520123947.12711-1-philmd@linaro.org>
>>>
>>> This series takes care of the remainder, except for one discussed
>>> below.  It applies cleanly with and without Philippe's patches.
>>>
>>> The exception is the last line in
>>>
>>>     Python scripts
>>>     M: John Snow <jsnow@redhat.com>
>>>     M: Cleber Rosa <crosa@redhat.com>
>>>     S: Odd Fixes
>>>     F: scripts/*.py
>>>     F: tests/*.py
>>>
>>> Both F: are actually wrong here: they match only in the scripts/ and
>>> tests/ not further down.  Left for another day.
>>>
>>> Markus Armbruster (39):
>>>   MAINTAINERS: Improve another "Overall" section headline
>>>   MAINTAINERS: Delete trailing colons in section headlines
>>>   MAINTAINERS: Drop stale F: from "Guest CPU cores (TCG)"
>>>   MAINTAINERS: Drop stale F: in "RISC-V TCG CPUs"
>>>   MAINTAINERS: Drop stale F: in "SPARC TCG CPUs"
>>>   MAINTAINERS: Drop stale F: from "Overall KVM CPUs"
>>>   MAINTAINERS: Drop stale F: from "Overall CPUs other accelerators"
>>>   MAINTAINERS: Drop stale F: from "virtio"
>>>   MAINTAINERS: Fix F: in "Apple Silicon HVF CPUs"
>>>   MAINTAINERS: Drop bad F: in "X86 Xen CPUs"
>>>   MAINTAINERS: Fix F: in "WebAssembly"
>>>   MAINTAINERS: Fix F: in "Allwinner-a10"
>>>   MAINTAINERS: Fix F: in "Raspberry Pi"
>>>   MAINTAINERS: Drop bad F: from "Xilinx Zynq"
>>>   MAINTAINERS: Drop stale F: from "New World (mac99)"
>>>   MAINTAINERS: Drop stale F: from "sPAPR (pseries)"
>>>   MAINTAINERS: Fix F: typo in "sam460ex"
>>>   MAINTAINERS: Fix F: in "SiFive Machines"
>>>   MAINTAINERS: Fix F: typo in "ACPI/HEST/GHES/ARM processor CPER"
>>>   MAINTAINERS: Fix F: in "SSI"
>>>   MAINTAINERS: Fix F: in "vhost"
>>>   MAINTAINERS: Fix F: in "virtio-input"
>>>   MAINTAINERS: Fix bad / stale F: in "virtio-rng"
>>>   MAINTAINERS: Fix F: in "vhost-user-stubs"
>>>   MAINTAINERS: Fix F: in "virtio-snd" and "virtio-gpu"
>>>   MAINTAINERS: Fix F: typo in "pcf8574"
>>>   MAINTAINERS: Drop stale F: from "Block I/O path"
>>>   MAINTAINERS: Fix F: typo in "Dump"
>>>   MAINTAINERS: Drop stale F: from "Human Monitor (HMP)"
>>>   MAINTAINERS: Fix F: in "QDev"
>>>   MAINTAINERS: Fix F: in "QMP"
>>>   MAINTAINERS: Fix F: typo in "I3C"
>>>   MAINTAINERS: Drop stale F: from "EDK2 Firmware"
>>>   MAINTAINERS: Drop stale F: from "TCI TCG target"
>>>   MAINTAINERS: Drop stale F: from "Linux io_uring"
>>>   MAINTAINERS: Fix F: in "VFIO-USER"
>>>   MAINTAINERS: Fix F: in "Build and test automation"
>>>   MAINTAINERS: Drop stale F: from "Sphinx documentation configuration
>>>     ..."
>>>   MAINTAINERS: Fix F: in "Rust build system integration"
>>>
>>>  MAINTAINERS | 73 ++++++++++++++++++-----------------------------------
>>>  1 file changed, 24 insertions(+), 49 deletions(-)
>>>
>>
>> thanks for posting this.
>>
>> In addition, see the patch attached to this email.
>> It integrates checking this directly at configure time, so we never run
>> into any missing entry again in the future.
>>
>> I share this here not for a review, but simply to avoid a duplicated
>> effort, and make sure people know it will be sent after this series.
>>
>> I don't believe in adding this in checkpatch, because it's not enforced
>> systematically unfortunately. Breaking the meson configuration is a good
>> way to make sure it's enforced by design.
> 
> No objection.
> 
>> With your series applied, the left entries are:
> 
> Most of these are fixed in Philippe's patches mentioned above.
>

👍

>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +258:
>> configs/targets/hexagon-linux-user/default.mak
> 
> MAINTAINERS: Fix hexagon-linux-user.mak path
> 
>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +259:
>> docker/dockerfiles/debian-hexagon-cross.docker
> 
> MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.docker path
> 
>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +2956:
>> hw/s390x/storage-keys.h
>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +2965:
>> hw/s390x/storage-attributes.h
> 
> MAINTAINERS: Fix s390x storage key/attribute device paths
> 
>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +3241:
>> scripts/coverity-model.c
> 
> MAINTAINERS: Correct scripts/coverity-model.c path
> 
>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +3468:
>> tests/*.py
> 
> This is the exception I mentioned above.
> 
> The intent is to match *.py below tests/.  It actually matches only in
> tests/, not in its subdirectories.
> 
> Here's a dumb fix:
> 
>     F: tests/*.py
>     F: tests/*/*.py
>     F: tests/*/*/*.py
>     F: tests/*/*/*/*.py
> 

It's acceptable, and nice because it's not ambiguous.
Also, it shows us the first line is not a correct entry (there is no
tests/*.py).

> for however many levels we have.  Same for the scripts/ line next to it.
> Blech.
> 
> The smart fix might be to port N: from the kernel.
> 
> 	N: Files and directories *Regex* patterns.
> 	   N:	[^a-z]tegra	all files whose path contains tegra
> 	                        (not including files like integrator)
> 	   One pattern per line.  Multiple N: lines acceptable.
> 	   scripts/get_maintainer.pl has different behavior for files that
> 	   match F: pattern and matches of N: patterns.  By default,
> 	   get_maintainer will not look at git log history when an F: pattern
> 	   match occurs.  When an N: match occurs, git log history is used
> 	   to also notify the people that have git commit signatures.
> 
> But I wonder: is this section useful at all?
>

I would prefer to use the manual entries approach above, especially if
there is only folder that is concerned.
When we'll have two different use case, maybe we can consider a more
generic approach.

>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +4149:
>> tcg/s390/
> 
> MAINTAINERS: Fix tcg/s390x/ path
> 
>> Once your current series is pulled, I'll fix the remaining and send the
>> attached patch. Or feel free to do it directly if you like the idea :)
>>
>> Regards,
>> Pierrick
> 
> Two remarks inline.
> 
>> From 6c9b49ac7ec06c0159d2b4ba9c9d1081e02ef765 Mon Sep 17 00:00:00 2001
>> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Date: Fri, 22 May 2026 12:23:17 -0700
>> Subject: [PATCH] meson.build: check MAINTAINERS file is consistent with source
>>  tree
>>
>> We add a new script: scripts/check-maintainers-file.py, that will run at
>> configuration time (and not at build time), to not hurt build time.
>> This script runs in 0.2s on my dev VM, which has an old cpu.
>>
>> We can expect things to be mostly in sync since adding or removing a
>> source or test file will trigger a configure step.
>> For the rest, like docs, tcg tests, or remaining files, GitLab CI will
>> build things from scratch and always run the configure step.
>>
>> With this, it should be impossible by design to have an upstream
>> MAINTAINERS file with non existing file entries.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  meson.build                       |  5 +++
>>  scripts/check-maintainers-file.py | 53 +++++++++++++++++++++++++++++++
>>  2 files changed, 58 insertions(+)
>>  create mode 100755 scripts/check-maintainers-file.py
>>
>> diff --git a/meson.build b/meson.build
>> index eeb096c1487..ddfb0b90ca6 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -18,6 +18,11 @@ add_test_setup('thorough',
>>  
>>  meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
>>  
>> +# check our MAINTAINERS file is consistent
>> +check_maintainers = find_program('scripts/check-maintainers-file.py')
>> +maintainers_file = files('MAINTAINERS')
>> +run_command([check_maintainers, maintainers_file], check: true, console: true)
> 
> My version of meson (1.8.5) chokes on console: true.  According to
> https://mesonbuild.com/Reference-manual_functions_run_command.html#run_command_console
> it's new in 1.11.0.
>

Our configure script creates a venv with an updated version of meson,
which is 1.11.1 at the moment.
If you called meson directly (which uses your host meson), it's not how
we're supposed to build QEMU.
How did you try this?

> I tested with it deleted.
> 
>> +
>>  ####################
>>  # Global variables #
>>  ####################
>> diff --git a/scripts/check-maintainers-file.py b/scripts/check-maintainers-file.py
>> new file mode 100755
>> index 00000000000..b001816a401
>> --- /dev/null
>> +++ b/scripts/check-maintainers-file.py
>> @@ -0,0 +1,53 @@
>> +#! /usr/bin/env python3
>> +
>> +# Check incorrect file entries in MAINTAINERS
>> +#
>> +# Author: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import argparse
>> +import glob
>> +import sys
>> +
>> +
>> +def check_one_entry(line) -> bool:
>> +    return True
>> +
>> +
>> +def main() -> None:
>> +    parser = argparse.ArgumentParser(description="Check MAINTAINERS file")
>> +    parser.add_argument("maintainers", help="Path to MAINTAINERS file")
>> +    args = parser.parse_args()
>> +
>> +    found_file_entry = False
>> +    found_incorrect_entries = False
>> +    line_counter = 0
>> +
>> +    with open(args.maintainers) as file:
>> +        for entry in file:
>> +            line_counter += 1
>> +
>> +            if not entry.startswith("F:"):
>> +                continue
>> +            entry = entry[2:].strip()
>> +            found_file_entry = True
>> +
>> +            file_exists = len(glob.glob(entry, recursive=True)) > 0
> 
> I'm afraid this matches files not in git, just like my quick & dirty
> one-liner.  Shouldn't we match against contents of HEAD, say output of
> "git-ls-tree -r --name-only @"?
>

I don't think it's needed to restrict to git ls-tree. The only risk is
that people have a local file they forgot (or didn't want) to add in
git. It will be caught by CI that won't have such a file, so we're safe.

What do you think?

>> +            if file_exists:
>> +                continue
>> +
>> +            found_incorrect_entries = True
>> +            print(
>> +                f"No matching files for {args.maintainers} +{line_counter}: {entry}",
>> +                file=sys.stderr,
>> +            )
>> +
>> +    if not found_file_entry:
>> +        raise Exception("no file entry found - is MAINTAINERS path correct?")
>> +    if found_incorrect_entries:
>> +        raise Exception(f"incorrect entries found in {args.maintainers}")
>> +
>> +
>> +if __name__ == "__main__":
>> +    main()
> 

Regards,
Pierrick

