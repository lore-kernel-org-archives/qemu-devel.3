Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCCFC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 20:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpYyn-0007LX-3f; Tue, 04 Mar 2025 15:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tpYyl-0007LL-D3
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 15:35:03 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tpYyi-00070q-T3
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 15:35:03 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524AIbtj006113
 for <qemu-devel@nongnu.org>; Tue, 4 Mar 2025 20:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 87XvOPLGwX718jNxrlQ1Oj8IB0U5ctm63GkeNZlGnTA=; b=HkYIzz5dMQU2oV4S
 6pd9e5/H7PvuFknWZqFdMdl2HyqZCaQmhsqqoG6AhJVm2Az26DZiNz4vDrMctc8y
 vmkZnyLazcruvzv3SvhbbsRwyhJhxKtq+XFrb6P6erlraGoa/3ye5j9SsfCuPfEA
 HY+BPiJ3jg25WlxubXe0XnUqr7+G7OPpQ6wrurAaDXpduRKJCMkwikv5PHx9Gh9s
 LXWAiXXs932oDdia48K4IpaOc0acagCHSouY3LOnZsc4Pm57MG6rXXwLQZBa+hfj
 L0k+ekEIR2vRWhU1GtOiouUre1oOblOeivqRtJLQGJw03eSaZ8LzBZVsapcDkLgt
 /IjOAA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6tk3qv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 20:34:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c3b4bea51eso388188885a.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 12:34:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741120472; x=1741725272;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=87XvOPLGwX718jNxrlQ1Oj8IB0U5ctm63GkeNZlGnTA=;
 b=YvPmnGrxc/dXosnrnNeuLq5OjPKnZafcYoJSUtgOuka9zI1gdY7U0pzX5xKiuOIFaD
 aIyEx53NgtTKrNS2TPidM5PCb5ohHR35k+dR0yZPZmsYZOKLZ5hpdOw6GGRSXLZwWO5q
 4/1/oupLmeu5yG7HyIhBCGv+BOJmxAWSZ/sALfDpE2wj9/jfl2CH3qP0wkmWyt2Uih5n
 wtr/gnGDNMzWUNjuTgX0aPz+TlEZM/8xkJmcZb+00vcaZA6GOfnAsWZE2AUVsV4y8O2H
 yNKIyJhHY9bOlajZeRk58DWbtagnrKeyDQwANP0oCYbPULnD5wAjK8FoW420u3JHEpBe
 Qnkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ+gb3wZoJ+PjSjMkwDuD9D5flZy6R7ARlXUF8JN9z9gOr1Wnyn+C/HaipwawqWt7a7eB4PpSbHVNL@nongnu.org
X-Gm-Message-State: AOJu0Yx4C445Hpnq1P3Bi66pIB7v1wC0m+EhArjsrti729nXk+hwhADu
 s9PKr0mJT5uZQAQfe/zjq6rXh/k8a3P5nxLhU67V0cZn7Hq74H7V2pIPKryPwe3xqY0imQdR+h5
 gwUWPf1RWrPYXikrtYexIcGxLxgN5Rt/4pZgJECDea70KxxVRhYRTPw==
X-Gm-Gg: ASbGncuCO0JNnGmRcakzazk/g/veW7J6rk4+5ptOrYmZjzJ1bzklbX/KJd4SP2DCG7q
 30EK8G+S93xuFPmmt1zStSe3CYSbCr0HSmO4tm02n8xvL/8lWd11gCgL01Jfn1Zd/X/EcPSmBZM
 RvKtontPHI9KoAKxS65kSV/6SevoPNFcIiUx52SC8nswQaC8rtl9fBRX4iOP6iIoDsGB3zMO2eJ
 MQixslpHZHxEFaws1vHL3eIHZAoZ+7UUoQeyPHkdif9LEjuxc/ueNQW6BGLGQ843mJA+aIm6b2T
 kSUvHkDlyBkeSjfLh/+MNe8Glx++/R/kZRT8YexWdUmPUB57uB9CmlVkMPqVb4z2wK9axV9waQ=
 =
X-Received: by 2002:a05:620a:2b44:b0:7c3:c077:fbf2 with SMTP id
 af79cd13be357-7c3d8ee8505mr113786085a.45.1741120472301; 
 Tue, 04 Mar 2025 12:34:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOA7ceWJ6DIHDKjB9r/nHTIPOKBTeIYYjgTJyXgN+ssjXkD8k/27SBPg7hEhbqSl7U0QxZ3w==
X-Received: by 2002:a05:620a:2b44:b0:7c3:c077:fbf2 with SMTP id
 af79cd13be357-7c3d8ee8505mr113782185a.45.1741120471810; 
 Tue, 04 Mar 2025 12:34:31 -0800 (PST)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c36fee8aafsm783797485a.13.2025.03.04.12.34.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 12:34:31 -0800 (PST)
Message-ID: <c0c5abed-a2d8-4c01-a82f-59c906185c11@oss.qualcomm.com>
Date: Tue, 4 Mar 2025 14:34:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] tests/functional: Add a hexagon minivm test
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng,
 anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>, Thomas Huth <thuth@redhat.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-9-brian.cain@oss.qualcomm.com>
 <38afa09a-6b3f-4f4f-a9a3-78bab25f0e3a@linaro.org>
 <c58840a3-fe99-43f4-8221-410e416914c7@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c58840a3-fe99-43f4-8221-410e416914c7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HZbuTjE8 c=1 sm=1 tr=0 ts=67c763f0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=NEAV23lmAAAA:8 a=qC_FGOx9AAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=UZOu9q-QDl8NGz5zwnUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=fsdK_YakeE02zTmptMdW:22 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: z6Az0o7rKwzOKSww_1iTJmKL9eqFL3Q8
X-Proofpoint-ORIG-GUID: z6Az0o7rKwzOKSww_1iTJmKL9eqFL3Q8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_08,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2503040165
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/4/2025 10:15 AM, Brian Cain wrote:
>
> On 3/4/2025 9:46 AM, Philippe Mathieu-Daudé wrote:
>> Hi Brian,
>>
>> On 1/3/25 18:20, Brian Cain wrote:
>>> From: Brian Cain <bcain@quicinc.com>
>>
>> A bit opaque...
>>
> Whoops -- will fix it.
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   MAINTAINERS                             |  1 +
>>>   tests/functional/meson.build            |  8 +++++
>>>   tests/functional/test_hexagon_minivm.py | 42 
>>> +++++++++++++++++++++++++
>>>   3 files changed, 51 insertions(+)
>>>   create mode 100755 tests/functional/test_hexagon_minivm.py
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index deeb7878c8..48a5e7c005 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -247,6 +247,7 @@ F: gdb-xml/hexagon*.xml
>>>   F: docs/system/target-hexagon.rst
>>>   F: docs/devel/hexagon-sys.rst
>>>   F: docs/devel/hexagon-l2vic.rst
>>> +F: tests/functional/test_hexagon_minivm.py
>>>   T: git https://github.com/quic/qemu.git hex-next
>>>     Hexagon idef-parser
>>> diff --git a/tests/functional/meson.build 
>>> b/tests/functional/meson.build
>>> index 111d8bab26..78b42e58f9 100644
>>> --- a/tests/functional/meson.build
>>> +++ b/tests/functional/meson.build
>>> @@ -135,6 +135,14 @@ tests_i386_system_quick = [
>>>     'migration',
>>>   ]
>>>   +test_timeouts += {
>>> +  'hexagon_minivm': 180,
>>> +}
>>> +
>>> +tests_hexagon_system_quick = [
>>> +  'hexagon_minivm',
>>> +]
>>> +
>>>   tests_i386_system_thorough = [
>>>     'i386_tuxrun',
>>>   ]
>>> diff --git a/tests/functional/test_hexagon_minivm.py 
>>> b/tests/functional/test_hexagon_minivm.py
>>> new file mode 100755
>>> index 0000000000..2ba92bcce3
>>> --- /dev/null
>>> +++ b/tests/functional/test_hexagon_minivm.py
>>> @@ -0,0 +1,42 @@
>>> +#!/usr/bin/env python3
>>> +#
>>> +# Copyright(c) 2024-2025 Qualcomm Innovation Center, Inc. All 
>>> Rights Reserved.
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +import os
>>> +from glob import glob
>>> +from qemu_test import QemuSystemTest, Asset
>>> +from qemu_test import wait_for_console_pattern
>>> +
>>> +class MiniVMTest(QemuSystemTest):
>>> +
>>> +    timeout = 180
>>> +    GUEST_ENTRY = 0xc0000000
>>> +
>>> +    REPO = 'https://artifacts.codelinaro.org/artifactory'
>>> +    ASSET_TARBALL = \
>>> +        Asset(f'{REPO}/codelinaro-toolchain-for-hexagon/'
>>> +               '19.1.5/hexagon_minivm_2024_Dec_15.tar.gz',
>>> + 'd7920b5ff14bed5a10b23ada7d4eb927ede08635281f25067e0d5711feee2c2a')
>>> +
>>> +    def test_minivm(self):
>>> +        self.set_machine('virt')
>>> +        self.archive_extract(self.ASSET_TARBALL)
>>> +        rootfs_path = 
>>> f'{self.workdir}/hexagon-unknown-linux-musl-rootfs'
>>> +        kernel_path = f'{rootfs_path}/boot/minivm'
>>
>> $ readelf -h hexagon-unknown-linux-musl-rootfs/boot/minivm
>>   Entry point address:               0xffff0000
>>
>> I suppose this is a bootloader which runs guest code at
>> GUEST_ENTRY = 0xc0000000.
>>
> Yes, this is indeed the case.  The source for minivm and the test 
> cases is found at https://github.com/quic/hexagonMVM
>>> +
>>> +        assert(os.path.exists(kernel_path))
>>> +        for test_bin_path in glob(f'{rootfs_path}/boot/test_*'):
>>> +            print(f'# Testing "{os.path.basename(test_bin_path)}"')
>>
>> $ ls -1 hexagon-unknown-linux-musl-rootfs/boot/test_*
>> hexagon-unknown-linux-musl-rootfs/boot/test_interrupts
>> hexagon-unknown-linux-musl-rootfs/boot/test_mmu
>> hexagon-unknown-linux-musl-rootfs/boot/test_processors
>>
>> I'd rather 1 test per binary to easily see which one failed.
>>
> Okay, I'll make that change.
>>> +
>>> +            vm = self.get_vm()
>>> +            vm.add_args('-kernel', kernel_path,
>>> +                  '-device',
>>> + f'loader,addr={hex(self.GUEST_ENTRY)},file={test_bin_path}')
>>> +            vm.launch()
>>> +            vm.wait()
>>> +            self.assertEqual(vm.exitcode(), 0)
>>
>> ...
>> ----------------
>> IN:
>> 0xc0000000:  0x6a09c019 { R25 = C9/pc }
>> 0xc0000004:  0x00004040 { immext(#0x1000)
>> 0xc0000008:  0x7800c018  R24 = ##0x1000 }
>> 0xc000000c:  0xf318d918 { R24 = add(R24,R25) }
>> 0xc0000010:  0x00004000 { immext(#0x0)
>> 0xc0000014:  0x7800c03a  R26 = ##0x1 }
>> 0xc0000018:  0x0c004000 { immext(#0xc0000000)
>> 0xc000001c:  0x7800c001  R1 = ##0xc0000000 }
>> 0xc0000020:  0x0ffc4000 { immext(#0xffc00000)
>> 0xc0000024:  0x7601c001  R1 = and(R1,##0xffc00000) }
>> 0xc0000028:  0x8c01d622 { R2 = lsr(R1,#0x16) }
>> 0xc000002c:  0xc402d840 { R0 = addasl(R24,R2,#0x2) }
>> 0xc0000030:  0xb0e1f8a1 { R1 = add(R1,#0xfc5) }
>> 0xc0000034:  0x00044000 { immext(#0x400000)
>> 0xc0000038:  0x7800c002  R2 = ##0x400000 }
>> 0xc000003c:  0x601ac008 { loop0(PC+4,R26) }
>> 0xc0000040:  0xab80c108 { memw(R0++#0x4) = R1 }
>> 0xc0000044:  0xf3018201 { R1 = add(R1,R2)
>> 0xc0000048:  0x7f00c000  nop }  :endloop0
>> ...
>> do_raise_exception: 0x00000002, @ 20000090
>>  hexagon_cpu_do_interrupt: event 0x2:(null), cause 0x25(37)
>>  hexagon_cpu_do_interrupt: event 0x9:HEX_EVENT_TRAP1, cause 0x1(1)
>> 0x20000104:  0x5400c000 { trap0(#0x0) }
>>
>>  hexagon_cpu_do_interrupt: event 0x8:HEX_EVENT_TRAP0, cause 0x0(0)
>>  hexagon_cpu_do_interrupt: event 0x9:HEX_EVENT_TRAP1, cause 0x1(1)
>>
>> 0xc00002a0:  0x7060c002 { R2 = R0 }
>> 0xc00002a4:  0x5480c20c { trap1(R0,#0x13) }
>>
>>  hexagon_cpu_do_interrupt: event 0x9:HEX_EVENT_TRAP1, cause 0x13(19)
>> 0xffff0518:  0x5800c02a { jump PC+84 }
>> 0xffff056c:  0x6460c000 { stop(R0) }
>>
>> How can we be sure errors won't exit(0) or hang?
>>
> The most likely failure mode for errors seems like a hang to me. Which 
> is good that it's at least detected but I would agree that it would be 
> preferable to
>> (qemu) info mtree
>> address-space: memory
>>   0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>     0000000000000000-00000000ffffffff (prio 0, ram): ddr.ram
>>     0000000010000000-0000000010000fff (prio 0, i/o): pl011
>>     0000000011000000-00000000110001ff (prio 0, i/o): virtio-mmio
>>     0000000012000000-00000000120001ff (prio 0, i/o): virtio-mmio
>>     00000000d81e0000-00000000d81effff (prio 0, i/o): fast
>>     00000000d8400000-00000000d87fffff (prio 0, ram): vtcm.ram
>>     00000000de000000-00000000de0001ff (prio 0, rom): config_table.rom
>>     00000000fc910000-00000000fc910fff (prio 0, i/o): l2vic
>>
>> Could we have minimal debug output on the console?
>>
> Hmm - there's no UART support in minivm nor its tests.  But it is easy 
> enough to add debug output via semihosting.  Since semihosting spec is 
> still under review, I've omitted that from these initial series.
>
>
> How about we revise the minivm tests to emit some debug output and we 
> can also use that kind of thing to verify correctness?  But would it 
> suffice to land the test design as-is and follow up after semihosting 
> lands?  Or would you prefer to see semihosting be included
>

Oh - I see these tests do already emit `PASS` or `FAIL` via 
semihosting.  See 
https://github.com/quic/hexagonMVM/blob/ca5704e8fd7aa0b856c947933fca045ff7a9dadd/tests/test_processors.S#L109-L116 
for an example.

Would it be okay to just check for this output after that semihosting 
lands?  And do you prefer more detailed debug output beyond PASS/FAIL?


>>> +
>>> +if __name__ == '__main__':
>>> +    QemuSystemTest.main()
>>
>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>

