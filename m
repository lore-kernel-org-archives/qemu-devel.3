Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DF1C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 16:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpUvP-0005UH-K0; Tue, 04 Mar 2025 11:15:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tpUvK-0005U2-Gq
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 11:15:15 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tpUvG-0001a3-Ej
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 11:15:14 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249rdn1006166
 for <qemu-devel@nongnu.org>; Tue, 4 Mar 2025 16:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 //+PSdaJNeEnFisNk8tLPsymsCA9raZcSKexI8UKtQ0=; b=D3lxjGHPqwH6B+2x
 2pgNz2qe0Xi5nqWlzqgLTrtGp5YUULGF/tif6BzEF9qKugHq4Pb9a5H+CI7txJ6c
 pp/je/Hxd82jU/HV8krMeDbX6g/ZRwM53SfOYmCV0dtHQpji9Xcbj70bK7eG3v29
 MYr5oltA3q4EREIG+/Rnl8UKN1l8/iKWJjqx8w9fmLfWFWQ69WefF0hXYKekTu7K
 ogrBWmF4RS+btPamRCFqOG5lUKQcw7Oo8DZ+9UdGdV2Vf7/7u2IflOhDzce5LEEJ
 Y2UiEGQrQknJB2Sd7KOrKgo+qA/I3/ign6sf4J8B7IGpQ241P4DzlT/lY8gXD1Dz
 BocWDA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6tjdvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:15:07 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6e89808749eso136878566d6.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 08:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741104907; x=1741709707;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=//+PSdaJNeEnFisNk8tLPsymsCA9raZcSKexI8UKtQ0=;
 b=H5HHH7+Vig5Nh7W//Ll3bkg+vfnOmhvGS/JdDA31Z3MTnT/HPv0HpB1xPJfwOm40L1
 fwW1aawf2CzK0UmXEkbTW++rrS13SAnTitfgD2wbMx/vFHbusYTOf0rzVrbbpyTRJEyA
 dWEkWTxyrTvcL52/+4yHvZ17mvM2/2EjDbHnHIh5YmJStICNLMINRxPsarLOYE1XyKIT
 iVlJ7gqqJ9QJovwNKzi3QvRCsdi/QDqf5B6R/OteFAoUWoiMFFxHE/fLcDpRDyXvWH7w
 J3aN8No7O0XOm7XHfaDr7y6LKyKNRC9lbMe3/bbYyW6Q4UU4zjq2OHa9ttMP/jvUrEPz
 HMWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqBqhK9xhY6lza2FxBdQFgyqjjIwGofvZEZN+eOCI3iVOWRrgg93rqbhgCOQ9x+fA5j9s0eS6QVRNW@nongnu.org
X-Gm-Message-State: AOJu0YzdQkIdbnlhMFWv/frbUBuolgeRQqSRPSe9JHg4PV/Q9VV3PKkT
 epXfMHgnJ3vGFW/GRK9GLalbSGDtrzCgXCH67ZXBk2UOsPQHh2iazxLR3MuZqjE4564LiQUNAnM
 l5jXGVzErItaXSXvklYhaKxwugoIcNsWp6hnNxbqj1higKOtfBEuaVQ==
X-Gm-Gg: ASbGncvX3x68JzzWTEr9GakhoqX+Goa54q003n6yNVAeqrHtFVyMGliAKKVNbwGcfc6
 fbcNCR2190Jz8lL4bjjb3kEwxB7CNEpK/zH4mDd8iCDA6NFjoZytRC+L41x0zz9Y4MDAGJVPhU+
 IGQ/ufJ5dapibcWVhdtKTrI+kpU8WnKeovykHz+P0ZQ4jlEfabCvvjy73WO1WJHGjQTdfFQL91s
 1BSHtp3PqZjNHHR/NAXmNqbrtrQsxygwaldmy3dXMCAZlxo5Liy+A2mvNutAH00zQ9LQfqyrYcI
 Lf07ul05GSnBu522MX/gYqzUOJkLiEWvGeRkUKByT1HaHwfL84yF+C8keIElx0Ooty27lT+um/z
 DWbVVLAJVyDizfd8e
X-Received: by 2002:a05:6214:226b:b0:6e6:61f1:457f with SMTP id
 6a1803df08f44-6e8a0d00641mr290942366d6.18.1741104906987; 
 Tue, 04 Mar 2025 08:15:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT18/9hakWc0L5Vw5fa4scLLbnHDCMrs0h8h3fGNSRAunHv1K5iB698Ay/V5capDUNs+Y3ew==
X-Received: by 2002:a05:6214:226b:b0:6e6:61f1:457f with SMTP id
 6a1803df08f44-6e8a0d00641mr290941846d6.18.1741104906572; 
 Tue, 04 Mar 2025 08:15:06 -0800 (PST)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8976347acsm68078636d6.4.2025.03.04.08.15.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 08:15:06 -0800 (PST)
Message-ID: <c58840a3-fe99-43f4-8221-410e416914c7@oss.qualcomm.com>
Date: Tue, 4 Mar 2025 10:15:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Cain <brian.cain@oss.qualcomm.com>
Subject: Re: [PATCH 8/8] tests/functional: Add a hexagon minivm test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng,
 anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>, Thomas Huth <thuth@redhat.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-9-brian.cain@oss.qualcomm.com>
 <38afa09a-6b3f-4f4f-a9a3-78bab25f0e3a@linaro.org>
Content-Language: en-US
In-Reply-To: <38afa09a-6b3f-4f4f-a9a3-78bab25f0e3a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HZbuTjE8 c=1 sm=1 tr=0 ts=67c7270b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=NEAV23lmAAAA:8 a=qC_FGOx9AAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=qxR4naJY7gb3rGwDWEMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=fsdK_YakeE02zTmptMdW:22 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: dGj3GiTc0ozyqWP29C4AgBvOrgpfRmX2
X-Proofpoint-ORIG-GUID: dGj3GiTc0ozyqWP29C4AgBvOrgpfRmX2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2503040131
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


On 3/4/2025 9:46 AM, Philippe Mathieu-Daudé wrote:
> Hi Brian,
>
> On 1/3/25 18:20, Brian Cain wrote:
>> From: Brian Cain <bcain@quicinc.com>
>
> A bit opaque...
>
Whoops -- will fix it.
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                             |  1 +
>>   tests/functional/meson.build            |  8 +++++
>>   tests/functional/test_hexagon_minivm.py | 42 +++++++++++++++++++++++++
>>   3 files changed, 51 insertions(+)
>>   create mode 100755 tests/functional/test_hexagon_minivm.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index deeb7878c8..48a5e7c005 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -247,6 +247,7 @@ F: gdb-xml/hexagon*.xml
>>   F: docs/system/target-hexagon.rst
>>   F: docs/devel/hexagon-sys.rst
>>   F: docs/devel/hexagon-l2vic.rst
>> +F: tests/functional/test_hexagon_minivm.py
>>   T: git https://github.com/quic/qemu.git hex-next
>>     Hexagon idef-parser
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 111d8bab26..78b42e58f9 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -135,6 +135,14 @@ tests_i386_system_quick = [
>>     'migration',
>>   ]
>>   +test_timeouts += {
>> +  'hexagon_minivm': 180,
>> +}
>> +
>> +tests_hexagon_system_quick = [
>> +  'hexagon_minivm',
>> +]
>> +
>>   tests_i386_system_thorough = [
>>     'i386_tuxrun',
>>   ]
>> diff --git a/tests/functional/test_hexagon_minivm.py 
>> b/tests/functional/test_hexagon_minivm.py
>> new file mode 100755
>> index 0000000000..2ba92bcce3
>> --- /dev/null
>> +++ b/tests/functional/test_hexagon_minivm.py
>> @@ -0,0 +1,42 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Copyright(c) 2024-2025 Qualcomm Innovation Center, Inc. All Rights 
>> Reserved.
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import os
>> +from glob import glob
>> +from qemu_test import QemuSystemTest, Asset
>> +from qemu_test import wait_for_console_pattern
>> +
>> +class MiniVMTest(QemuSystemTest):
>> +
>> +    timeout = 180
>> +    GUEST_ENTRY = 0xc0000000
>> +
>> +    REPO = 'https://artifacts.codelinaro.org/artifactory'
>> +    ASSET_TARBALL = \
>> +        Asset(f'{REPO}/codelinaro-toolchain-for-hexagon/'
>> +               '19.1.5/hexagon_minivm_2024_Dec_15.tar.gz',
>> + 'd7920b5ff14bed5a10b23ada7d4eb927ede08635281f25067e0d5711feee2c2a')
>> +
>> +    def test_minivm(self):
>> +        self.set_machine('virt')
>> +        self.archive_extract(self.ASSET_TARBALL)
>> +        rootfs_path = 
>> f'{self.workdir}/hexagon-unknown-linux-musl-rootfs'
>> +        kernel_path = f'{rootfs_path}/boot/minivm'
>
> $ readelf -h hexagon-unknown-linux-musl-rootfs/boot/minivm
>   Entry point address:               0xffff0000
>
> I suppose this is a bootloader which runs guest code at
> GUEST_ENTRY = 0xc0000000.
>
Yes, this is indeed the case.  The source for minivm and the test cases 
is found at https://github.com/quic/hexagonMVM
>> +
>> +        assert(os.path.exists(kernel_path))
>> +        for test_bin_path in glob(f'{rootfs_path}/boot/test_*'):
>> +            print(f'# Testing "{os.path.basename(test_bin_path)}"')
>
> $ ls -1 hexagon-unknown-linux-musl-rootfs/boot/test_*
> hexagon-unknown-linux-musl-rootfs/boot/test_interrupts
> hexagon-unknown-linux-musl-rootfs/boot/test_mmu
> hexagon-unknown-linux-musl-rootfs/boot/test_processors
>
> I'd rather 1 test per binary to easily see which one failed.
>
Okay, I'll make that change.
>> +
>> +            vm = self.get_vm()
>> +            vm.add_args('-kernel', kernel_path,
>> +                  '-device',
>> + f'loader,addr={hex(self.GUEST_ENTRY)},file={test_bin_path}')
>> +            vm.launch()
>> +            vm.wait()
>> +            self.assertEqual(vm.exitcode(), 0)
>
> ...
> ----------------
> IN:
> 0xc0000000:  0x6a09c019 { R25 = C9/pc }
> 0xc0000004:  0x00004040 { immext(#0x1000)
> 0xc0000008:  0x7800c018  R24 = ##0x1000 }
> 0xc000000c:  0xf318d918 { R24 = add(R24,R25) }
> 0xc0000010:  0x00004000 { immext(#0x0)
> 0xc0000014:  0x7800c03a  R26 = ##0x1 }
> 0xc0000018:  0x0c004000 { immext(#0xc0000000)
> 0xc000001c:  0x7800c001  R1 = ##0xc0000000 }
> 0xc0000020:  0x0ffc4000 { immext(#0xffc00000)
> 0xc0000024:  0x7601c001  R1 = and(R1,##0xffc00000) }
> 0xc0000028:  0x8c01d622 { R2 = lsr(R1,#0x16) }
> 0xc000002c:  0xc402d840 { R0 = addasl(R24,R2,#0x2) }
> 0xc0000030:  0xb0e1f8a1 { R1 = add(R1,#0xfc5) }
> 0xc0000034:  0x00044000 { immext(#0x400000)
> 0xc0000038:  0x7800c002  R2 = ##0x400000 }
> 0xc000003c:  0x601ac008 { loop0(PC+4,R26) }
> 0xc0000040:  0xab80c108 { memw(R0++#0x4) = R1 }
> 0xc0000044:  0xf3018201 { R1 = add(R1,R2)
> 0xc0000048:  0x7f00c000  nop }  :endloop0
> ...
> do_raise_exception: 0x00000002, @ 20000090
>  hexagon_cpu_do_interrupt: event 0x2:(null), cause 0x25(37)
>  hexagon_cpu_do_interrupt: event 0x9:HEX_EVENT_TRAP1, cause 0x1(1)
> 0x20000104:  0x5400c000 { trap0(#0x0) }
>
>  hexagon_cpu_do_interrupt: event 0x8:HEX_EVENT_TRAP0, cause 0x0(0)
>  hexagon_cpu_do_interrupt: event 0x9:HEX_EVENT_TRAP1, cause 0x1(1)
>
> 0xc00002a0:  0x7060c002 { R2 = R0 }
> 0xc00002a4:  0x5480c20c { trap1(R0,#0x13) }
>
>  hexagon_cpu_do_interrupt: event 0x9:HEX_EVENT_TRAP1, cause 0x13(19)
> 0xffff0518:  0x5800c02a { jump PC+84 }
> 0xffff056c:  0x6460c000 { stop(R0) }
>
> How can we be sure errors won't exit(0) or hang?
>
The most likely failure mode for errors seems like a hang to me. Which 
is good that it's at least detected but I would agree that it would be 
preferable to
> (qemu) info mtree
> address-space: memory
>   0000000000000000-ffffffffffffffff (prio 0, i/o): system
>     0000000000000000-00000000ffffffff (prio 0, ram): ddr.ram
>     0000000010000000-0000000010000fff (prio 0, i/o): pl011
>     0000000011000000-00000000110001ff (prio 0, i/o): virtio-mmio
>     0000000012000000-00000000120001ff (prio 0, i/o): virtio-mmio
>     00000000d81e0000-00000000d81effff (prio 0, i/o): fast
>     00000000d8400000-00000000d87fffff (prio 0, ram): vtcm.ram
>     00000000de000000-00000000de0001ff (prio 0, rom): config_table.rom
>     00000000fc910000-00000000fc910fff (prio 0, i/o): l2vic
>
> Could we have minimal debug output on the console?
>
Hmm - there's no UART support in minivm nor its tests.  But it is easy 
enough to add debug output via semihosting.  Since semihosting spec is 
still under review, I've omitted that from these initial series.


How about we revise the minivm tests to emit some debug output and we 
can also use that kind of thing to verify correctness?  But would it 
suffice to land the test design as-is and follow up after semihosting 
lands?  Or would you prefer to see semihosting be included

>> +
>> +if __name__ == '__main__':
>> +    QemuSystemTest.main()
>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>

