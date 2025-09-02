Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16CECA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIbe-0001Jh-5O; Tue, 02 Sep 2025 00:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIbc-0001Cm-Kg
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:26:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIbZ-0001Up-79
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:26:52 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SBGq010468
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KfIpM40hN6uPTgs4ep53UQFo1UoL1hbtl+c7TjZwZTE=; b=DIi7bQ5uAeOV1mvT
 m9hfXYefs4eY6IIkBEAyG+E1sCgh1jWe6jbQPcBcK382W42LxOxhouPrj+Bmapsc
 p/h2woVdPPosoLlRYHsD3ah6NZMLKyD+cadCPid5496x66s7m9Jd2G5tg/P2rIey
 Zq7BBpbaqbqOylTEI2fbtBIzYzhKZA3PdkE4HDykh5BwxwFBpXIYUrJRvw3PtTWx
 khPl/Cb9JBPJbFzAvd5SdQRH9rmbLZqYA1j2IlxzYned3y1cd8wFcg4pUsdrMB5U
 WH2ShdIg/qttUBVSrNs2iGbxRzrR9DwrBv6vEpSw4LyMp9hY/F9d5QmdsS7bGEeI
 upesGQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjefre-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:26:46 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-718cb6230afso22190366d6.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756787206; x=1757392006;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KfIpM40hN6uPTgs4ep53UQFo1UoL1hbtl+c7TjZwZTE=;
 b=VPO92VmnH+zNYTSoPlHqmoRBclfBD/aCrEVpzwdsf7S/nIWW5Ky86iEvpORkyyETFp
 dZlSq8cFAoiU4pWnXf7Fk8McbNbl46qSkMmI9N9hROZZSNthjUH30CkTJ7D0DeGzsMD+
 uHQyR+cwqX9aSS5bM26jfgYDr/JHqRCuevDUnYiwr2zHu/m/aG2vJnQ7xDAi050qxrNt
 zvmwsm7VhAzloeEvGtu+vWpbDG0zzlEoJ7E3hXFGUSK1Aq9rRI70x+bDqcDgl69ELdfl
 rA3+IKLB1TqY8brvOJsWVP9znnEj5fwODLt/6w7ez+THo0yL9boGoiUV7WW3ka/hgtY5
 6sbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTqbGbxYvOz1UKajxld1bs0yzMpTTh4xuPHokc7k32BQas4e4TYqUlRE3M+p2hQKxyKXN58huFB8oE@nongnu.org
X-Gm-Message-State: AOJu0Yyipjzzbkd6n8XSlxncBWNFZ2dowGV9ho+Ey/jrbZbWXq0vVMIY
 lODqQkXwpR7lpGwpxgYcFdbVt/epNkKOZNZP4EAj6LDqQaxZOsoZgBmD2+MqxlNOav8p0N+M2mH
 LhvUORxJ/kNawS5otFutfuJCFaJsyNGrGiB6NVTEwBk8KYB2PuMLkKcS1AQ==
X-Gm-Gg: ASbGnctWKFJl/kNFoVm0FyWK43ohnwrGXbfO/60yT8tBTqwukspKaEV9Xlxqh2BjO6g
 6VOhWESUOI02rkXlWFn+ez8S5bqriBXuZt6ordHD5Znl4nYQwRI/RA+xtmTO13ZnQw99hnZoiwM
 HwmRm2k6dvdLpNneV+4rZuOv7CvM8sfzm6xilKTFH5dVk95zZZ0Fza3vCKB7CurVXQh5OJigxwD
 9FeWQAinmTvgjUEycXf2YX8kryEjIre2TZPM4ofIdMbEdTLWXpm3vc9Z8kQpDVWX537+fuPqX9H
 hDbRQOMYh3oo31f7jGhap6j+ZmRJT3beKSvzzZw8fup/XZ5hdJPnCNCxEq3MZA==
X-Received: by 2002:a05:6214:4588:b0:721:5247:f8b4 with SMTP id
 6a1803df08f44-7215247f8dfmr4565736d6.4.1756787205868; 
 Mon, 01 Sep 2025 21:26:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa15XAKBFhT8iL6+4chmgd34VL1XXIYch8gr190Hz8Mb+oZGN8QgKqc1Gz6zyzA7JiBXGpRg==
X-Received: by 2002:a05:6214:4588:b0:721:5247:f8b4 with SMTP id
 6a1803df08f44-7215247f8dfmr4565466d6.4.1756787205273; 
 Mon, 01 Sep 2025 21:26:45 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b88007a60sm65955265e9.8.2025.09.01.21.26.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:26:44 -0700 (PDT)
Message-ID: <4c366192-52dc-48f7-a2d9-233573e8998c@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 21:52:18 -0500
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
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b67206 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=qC_FGOx9AAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=WBIJGYwvxY8_UlZRiw8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=fsdK_YakeE02zTmptMdW:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: jy4XI0WXYBXql23StntUcPpgYnUpeq7P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX35tmoANfSKQg
 lpBIZJTCoZ7E2//Siz1WmfSHAC4nSnHhmGKuchyn4pfYK2/uvfpsmrcaQGiM8XEfMWJwjfXzwbr
 fDB6h7OphNHoTkJ5inuU8an7qf2hlyKZWPLecr7n/9fyzJARu1ugZ8oMPcaNm52RIS9EBTsaEke
 lYL2uObOycYBIbxnbmpWk9IELgnz0yvbrTpLz3VfX22xrNz2ISBgw0f0zz4+2Aj/dxMbhPZlPNr
 zf4Br422aVPcK4d+0E6n9EteGrER6UhgpnvuIVTRyrOLpxZn5Zdo115ogirGPyh2ZJBjKmj2wJW
 nsn133yB7KaJGnVcn+C3omHyxYupL5zJ2Gwkvf/p7HURHzi/0qYN/e/ME6b83mGBjaoKRkMVhQz
 AO1wnUUC
X-Proofpoint-ORIG-GUID: jy4XI0WXYBXql23StntUcPpgYnUpeq7P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
> (qemu) info mtree
> address-space: memory
>   0000000000000000-ffffffffffffffff (prio 0, i/o): system
>     0000000000000000-00000000ffffffff (prio 0, ram): ddr.ram
>     0000000010000000-0000000010000fff (prio 0, i/o): pl011
>     0000000011000000-00000000110001ff (prio 0, i/o): virtio-mmio
>     0000000012000000-00000000120001ff (prio 0, i/o): virtio-mmio
>     00000000d81e0000-00000000d81effff (prio 0, i/o): fast
>    00000000d8400000-00000000d87fffff (prio 0, ram): vtcm.ram
>     00000000de000000-00000000de0001ff (prio 0, rom): config_table.rom
>     00000000fc910000-00000000fc910fff (prio 0, i/o): l2vic
>
> Could we have minimal debug output on the console?
>
For now minivm relies on semihosting, which is convenient.  So I can 
postpone this test until after that's introduced if it helps. We have 
the boot-serial-test in this patch series now, so perhaps that's adequate?

Otherwise, I think the above suggestions other than console output have 
been addressed in v2.

>> +
>> +if __name__ == '__main__':
>> +    QemuSystemTest.main()
>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>

