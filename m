Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F856C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 16:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpUol-0003HK-GY; Tue, 04 Mar 2025 11:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tpUoS-00038v-QK
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 11:08:14 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tpUoO-0000GF-M4
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 11:08:07 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524A088P015969
 for <qemu-devel@nongnu.org>; Tue, 4 Mar 2025 16:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dT/OKDUb8BEdF3KZi7hnLN5ziaHbIdc0H7Y2B4qlni4=; b=hx2OAYVtCrxpK8zG
 98Xr82osg/v8w+/vJgMItWndxgZ5cDHHn7IU3ELH+suXj/AJ4KwsKmJuRhkFaEqd
 N7wG8IQZkXnkCf3W45KmTaQwmj4qasIocEmCHa7AlAChoxPq6og0mIOSQWp4hZEU
 cFXWAtTJwQwp/NeUmh3jbgfdJ9+AmtaQnUGMSGYEJV9vLzW4MY0+QcpVA+4OXQ3a
 /vBAThmvIhAqY+WTpTK6+vH1LUf0AfCfHdGOvymtQ74U0kjm9QyuenZPKzwnfw0C
 LjJj1tnTSrgpHpRFw4yncyhVwMY0wXD0nRHLkLq+SkuZ2XlIThkHEhCiaQ4dNJTY
 qz/3fQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6tje5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:07:59 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6e8c68dae82so51504436d6.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 08:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741104478; x=1741709278;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dT/OKDUb8BEdF3KZi7hnLN5ziaHbIdc0H7Y2B4qlni4=;
 b=kygaNHpslHHpgOAAINcoV4XaxG5cRGme8b8r1yM2IycveLj2SHbau8njRRiF07RwrT
 rGLllZ8SetOrip3QYya2A4TYjPb+sOAio4pYgEiwmcA7ON5joWX1sWDW/n9LYxQ/BPtD
 66rJMe9mm5DtUrhm+tjclvddJdNLfDyE1W9OyLYsrY3IsINheR97ADQ8OZ5G4nNKSoR3
 bRts+jR74SXRkeGo5XR/jbco0VpSynR2y0OQluFDiuCClamV84WnkGci7HeO0vUKOTVl
 qUoz0ZkJdxaC3HiTqeaWUt/Eo8zBiEAC7qTAfsEUuiDDTGJvHtXB2I46YmMAMdyF+/7v
 YR4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4AN3tGGSequf979nmvgRgHFqPC5ceASWZPGklmxOMdTbsQCiW5QeWKLWqZa6Ocj+TSQ0SEfpFpoZd@nongnu.org
X-Gm-Message-State: AOJu0Yx9cyC0ZfQfKkp8mbTgpQOoWhJSJHDs893T8vsfAZlZ/c4thMCF
 WpBu3r7EksC/oxUcnRQdxcQDokJs3eJ25Vd/Jzz+MRfQvaVwbwMouTrMENjKs/HYCwzvtTc8zLS
 mBl3IxMptSJCSYvW0eH0NkunHHyNrydlIdXeYypC1xrJmf3lJqqrsBQ==
X-Gm-Gg: ASbGncuG1muJze8Yhkw1mjnnfak8d2Yxi5xzyT3AzT1IdAhxrFMZn7kYp8Ov0uWLaj1
 gRjWD4XJhc2+GpW4UmOJPArniY585qDiph6MdCJx1eiWwSTyw159XBxQy0QyvUSAVuyH3Cn91jV
 POSXOp0HiOnKjz+DNxzP4DHOCalqne77i/UtJtpgmYE5Fc5xdJu2XefpNNHnaes26XxWhR4byiH
 5T4rWwnZPv7agSbMNXpjoW55KwRZ8stJAeiGe2QnyxKrCEPaiIKA67niyGUTdn4OsawZPOV0VOc
 9+pxQyZYhKBSA9oewYo1GbZaKYLSd8FpQ+OMu4Yw9rWcB+rpbSykoTW2UanH/NwUTiwdefGCmXD
 /PLdXb02Qpqra2/lS
X-Received: by 2002:a05:6214:20aa:b0:6e8:8b11:b6cd with SMTP id
 6a1803df08f44-6e8a0d95eaamr272133616d6.35.1741104478518; 
 Tue, 04 Mar 2025 08:07:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGr7NqH7kZPBX30+e5W62nu+1DQG447qJaW8Osy7DYui7H9FLK+knsoasPurZv7AM2ss8Fo8w==
X-Received: by 2002:a05:6214:20aa:b0:6e8:8b11:b6cd with SMTP id
 6a1803df08f44-6e8a0d95eaamr272132676d6.35.1741104477494; 
 Tue, 04 Mar 2025 08:07:57 -0800 (PST)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8976da260sm67932026d6.106.2025.03.04.08.07.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 08:07:57 -0800 (PST)
Message-ID: <afaf3629-2ac6-42e0-ad60-91033c676bc7@oss.qualcomm.com>
Date: Tue, 4 Mar 2025 10:07:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <38afa09a-6b3f-4f4f-a9a3-78bab25f0e3a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PMb1+eqC c=1 sm=1 tr=0 ts=67c7255f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=NEAV23lmAAAA:8 a=qC_FGOx9AAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=qxR4naJY7gb3rGwDWEMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=fsdK_YakeE02zTmptMdW:22 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: uDmQbGa0Q0zXkAeHfN3ibsBvbKCPSIdM
X-Proofpoint-GUID: uDmQbGa0Q0zXkAeHfN3ibsBvbKCPSIdM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040131
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
lands?  Or would you prefer to see semihosting be included here before 
this test is enabled?

>> +
>> +if __name__ == '__main__':
>> +    QemuSystemTest.main()
>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>

