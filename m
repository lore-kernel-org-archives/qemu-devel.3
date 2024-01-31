Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B5DC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 03:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV19m-0003OX-3Q; Tue, 30 Jan 2024 22:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1rV19i-0003LZ-SV
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 22:20:54 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1rV19f-0000V2-L0
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 22:20:54 -0500
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8DxfeuMvLll8cEIAA--.26114S3;
 Wed, 31 Jan 2024 11:20:45 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx7xOJvLll6XQpAA--.868S2; 
 Wed, 31 Jan 2024 11:20:43 +0800 (CST)
Subject: Re: [libvirt PATCH V2 0/4] add loongarch support for libvirt
To: Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: devel@lists.libvirt.org, maobibo@loongson.cn, lichao@loongson.cn,
 jiyin@redhat.com
References: <cover.1704369486.git.lixianglai@loongson.cn>
 <CABJz62MxNvFfs4aCRyp+7YANupU2T4k7x1C6avm=curjB+NmkA@mail.gmail.com>
 <17234d81-cc17-6859-720a-f033206780da@loongson.cn>
 <CABJz62OtwrfUj_OogStyzwk0zoh6U1+dFKRN9Y0t_y5r66WhZQ@mail.gmail.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <6edc28f0-bc21-cbe3-4ce2-94c8f6073f61@loongson.cn>
Date: Wed, 31 Jan 2024 11:20:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CABJz62OtwrfUj_OogStyzwk0zoh6U1+dFKRN9Y0t_y5r66WhZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cx7xOJvLll6XQpAA--.868S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3uw1UWryDCF1fKr4fKF1UXFc_yoW8Jr18Ao
 WY9F17Aw1UJrn8WF17Jan5JFW5Aw1UJFnrXrykXa4DGr1Uta1UCrWUX348Gay3Jr1rGryU
 J34aq3s8ArW7Jryfl-sFpf9Il3svdjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUYG7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8JVW8Jr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
 xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
 6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
 1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
 JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
 vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
 x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
 xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
 wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU88Ma5UUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.281,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

>
>> Hi Philippe:
>>
>>      When developing libvirt on loongarch, we encountered some problems
>> related to pflash.
>>
>> libvirt and qemu met some difficulties in the coordination of UEFI loading.
>>
>> I think we need your suggestions and opinions on the solution.
>>
>>> Anyway, I fetched and installed this. The firmware descriptor looks
>>> like:
>>>
>>>     {
>>>        "interface-types": [
>>>          "uefi"
>>>        ],
>>>        "mapping": {
>>>          "device": "memory",
>>>          "filename": "/usr/share/edk2/loongarch64/QEMU_EFI.fd"
>>>        },
>>>        "targets": [
>>>          {
>>>            "architecture": "loongarch64",
>>>            "machines": [
>>>              "virt",
>>>              "virt-*"
>>>            ]
>>>          }
>>>        ],
>>>        "features": [
>>>            "acpi"
>>>        ]
>>>      }
>>>
>>> This is not what I expected: specifically, it results in libvirt
>>> generating
>>>
>>>     -bios /usr/share/edk2/loongarch64/QEMU_EFI.fd
>>>
>>> So only one of the two files is used, in read-only mode, and there is
>>> no persistent NVRAM storage that the guest can use.
>>>
>>> This is what I expected instead:
>>>
>>>     {
>>>        "interface-types": [
>>>          "uefi"
>>>        ],
>>>        "mapping": {
>>>          "device": "flash",
>>>          "mode": "split",
>>>          "executable": {
>>>            "filename": "/usr/share/edk2/loongarch64/QEMU_EFI.fd",
>>>            "format": "raw"
>>>          },
>>>          "nvram-template": {
>>>            "filename": "/usr/share/edk2/loongarch64/QEMU_VARS.fd",
>>>            "format": "raw"
>>>          }
>>>        },
>>>        "targets": [
>>>          {
>>>            "architecture": "loongarch64",
>>>            "machines": [
>>>              "virt",
>>>              "virt-*"
>>>            ]
>>>          }
>>>        ],
>>>        "features": [
>>>            "acpi"
>>>       ]
>>>     }
>>>
>>> I've tried installing such a descriptor and libvirt picks it up,
>>> resulting in the following guest configuration:
>>>
>>>     <os firmware='efi'>
>>>       <type arch='loongarch64' machine='virt'>hvm</type>
>>>       <firmware>
>>>         <feature enabled='no' name='enrolled-keys'/>
>>>         <feature enabled='no' name='secure-boot'/>
>>>       </firmware>
>>>       <loader readonly='yes'
>>> type='pflash'>/usr/share/edk2/loongarch64/QEMU_EFI.fd</loader>
>>>       <nvram template='/usr/share/edk2/loongarch64/QEMU_VARS.fd'>/var/lib/libvirt/qemu/nvram/guest_VARS.fd</nvram>
>>>       <boot dev='hd'/>
>>>     </os>
>>>
>>> which in turn produces the following QEMU command line options:
>>>
>>>     -blockdev '{"driver":"file","filename":"/usr/share/edk2/loongarch64/QEMU_EFI.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"discard":"unmap"}'
>>>     -blockdev '{"node-name":"libvirt-pflash0-format","read-only":true,"driver":"raw","file":"libvirt-pflash0-storage"}'
>>>     -blockdev '{"driver":"file","filename":"/var/lib/libvirt/qemu/nvram/guest_VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,"discard":"unmap"}'
>>>     -blockdev '{"node-name":"libvirt-pflash1-format","read-only":false,"driver":"raw","file":"libvirt-pflash1-storage"}'
>>>
>>> Unfortunately, with this configuration the guest fails to start:
>>>
>>>     qemu-system-loongarch64: Property 'virt-machine.pflash0' not found
>>>
>>> This error message looked familiar to me, as it is the same that I
>>> hit when trying out UEFI support on RISC-V roughly a year ago[1]. In
>>> this case, however, it seems that the issue runs deeper: it's not
>>> just that the flash devices are not wired up to work as blockdevs,
>>> but even the old -drive syntax doesn't work.
>>>
>>> Looking at the QEMU code, it appears that the loongarch/virt machine
>>> only creates a single pflash device and exposes it via -bios. So it
>>> seems that there is simply no way to achieve the configuration that
>>> we want.
>>>
>>> I think that this is something that needs to be addressed as soon as
>>> possible. In the long run, guest-accessible NVRAM storage is a must,
>>> and I'm not sure it would make a lot of sense to merge loongarch
>>> support into libvirt until the firmware situation has been sorted out
>>> in the lower layers.
>> In the qemu code, loongarch virt machine does only create a pflash,
>>
>> which is used for nvram, and uefi code is loaded by rom.
>>
>> In summary, loongarch virt machine can use nvram with the following command:
>>
>> -------------------------------------------------------------------------------------------------------
>>
>> qemu-system-loongarch64 \
>> -m 8G \
>> -smp 4 \
>> -cpu la464 \
>> -blockdev '{"driver":"file","filename":"./QEMU_VARS-pflash.raw","node-name":"libvirt-pflash0-storage","auto-read-only":false,"discard":"unmap"}' \
>> -blockdev '{"node-name":"libvirt-pflash0-format","read-only":false,"driver":"raw","file":"libvirt-pflash0-storage"}' \
>> -machine virt,pflash=libvirt-pflash0-format \
>> -bios ./QEMU_EFI.fd
>>
>> -------------------------------------------------------------------------------------------------------
>>
>>
>> This is really a big difference from the following boot method, and it still
>> looks weird.
>>
>> -------------------------------------------------------------------------------------------------------
>>
>> -blockdev '{"driver":"file","filename":"/usr/share/edk2/loongarch64/QEMU_EFI.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"discard":"unmap"}'
>> -blockdev '{"node-name":"libvirt-pflash0-format","read-only":true,"driver":"raw","file":"libvirt-pflash0-storage"}'
>> -blockdev '{"driver":"file","filename":"/var/lib/libvirt/qemu/nvram/guest_VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,"discard":"unmap"}'
>> -blockdev '{"node-name":"libvirt-pflash1-format","read-only":false,"driver":"raw","file":"libvirt-pflash1-storage"}'
>>
>> -------------------------------------------------------------------------------------------------------
>>
>> However, during the development of qemu loongarch,
>>
>> we also used a RISCV-like solution to create two pflash,
>>
>> but the qemu community suggested that we put uefi code in rom for the
>> following reasons:
>>
>>
>> https://lore.kernel.org/qemu-devel/2f381d06-842f-ac8b-085c-0419675a4872@linaro.org/
>>
>> "
>>
>> Since you are starting a virtual machine from scratch, you should take
>> the opportunity to learn from other early mistakes. X86 ended that way
>> due to 1/ old firmwares back-compability and 2/ QEMU pflash block
>> protections not being implemented. IIUC if we were starting with a
>> UEFI firmware today, the layout design (still using QEMU) would be
>> to map the CODE area in a dumb ROM device, and the VARSTORE area
>> in a PFlash device. Since Virt machines don't need to use Capsule
>> update, having the CODE area in ROM drastically simplifies the design
>> and maintainance.
>>
>> "
>>
>> Well, anyway, now that we have an issue with qemu loongarch using nvram that
>> is incompatible with libvirt,
>>
>> here I have come up with two solutions to solve this problem:
>>
>>
>>     Option 1:
>>
>> If the interface type "rom-uefi" is added and the device type "rom-flash" is
>> added, the json file should be written like this:
>>
>> -------------------------------------------------------------------------------------------------------
>>
>> {
>>     "interface-types": [
>>       "rom-uefi"
>>     ],
>>     "mapping": {
>>       "device": "rom-flash",
>>       "executable": {
>>         "filename": "/usr/share/edk2/loongarch64/QEMU_EFI.fd",
>>         "format": "raw"
>>       },
>>       "nvram-template": {
>>         "filename": "/usr/share/edk2/loongarch64/QEMU_VARS.fd",
>>         "format": "raw"
>>       }
>>     },
>>     "targets": [
>>       {
>>         "architecture": "loongarch64",
>>         "machines": [
>>           "virt",
>>           "virt-*"
>>         ]
>>       }
>>     ],
>>     "features": [
>>         "acpi"
>>     ]
>>
>>   -------------------------------------------------------------------------------------------------------
>>
>> Then add the parsing of the new interface types in libvirt and load
>> QEMU_CODE.fd as -bios and QEMU_VARS.fd as nvram
>>
>> when creating the command line, generating commands like the following:
>>
>>   -------------------------------------------------------------------------------------------------------
>>
>> -blockdev '{"driver":"file","filename":"/usr/share/edk2/loongarch64/QEMU_VARS.fd/","node-name":"libvirt-pflash0-storage","auto-read-only":false,"discard":"unmap"}' \
>> -blockdev '{"node-name":"libvirt-pflash0-format","read-only":false,"driver":"raw","file":"libvirt-pflash0-storage"}' \
>> -machine virt,pflash=libvirt-pflash0-format \
>> -bios /usr/share/edk2/loongarch64///QEMU_EFI.fd \
>>
>> -------------------------------------------------------------------------------------------------------
>>
>>     Option 2:
>>
>> Solution 2 mainly starts from qemu. Now the rom that bios is loaded into is
>> a memory region that cannot be configured with attributes,
>>
>> so we imagine abstracting rom as a device, creating it during machine
>> initialization and setting "pflash0" attribute for it.
>>
>> Then create a pflash and set its property to "pflash1", so our startup
>> command will look like this:
>>
>>   -------------------------------------------------------------------------------------------------------
>>
>> -blockdev '{"driver":"file","filename":"/usr/share/edk2/loongarch64/QEMU_EFI.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"discard":"unmap"}' \
>> -blockdev '{"node-name":"libvirt-pflash0-format","read-only":true,"driver":"raw","file":"libvirt-pflash0-storage"}' \
>> -blockdev '{"driver":"file","filename":"/usr/share/edk2/loongarch64/QEMU_VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,"discard":"unmap"}' \
>> -blockdev '{"node-name":"libvirt-pflash1-format","read-only":false,"driver":"raw","file":"libvirt-pflash1-storage"}' \
>> -machine virt,pflash0=libvirt-pflash0-format,pflash1=libvirt-pflash1-format \
>>
>>   -------------------------------------------------------------------------------------------------------
>>
>> This way, without modifying libvirt, QEMU_CODE.fd can be loaded into the
>> rom,
>>
>> but it is still a little strange that it is clearly rom but set a "pflash0"
>> attribute, which can be confusing.
> We recently had a very similar discussion regarding EFI booting on
> RISC-V.
>
> Personally I would prefer to see the approach with two pflash
> devices, one read-only and one read/write, adopted. This is pretty
> much the de-facto standard across architectures: x86_64, aarch64 and
> riscv64 all boot edk2 this way.
>
> I understand the desire to simplify things where possible, and I am
> sympathetic towards it. If we could boot from just rom, without using
> pflash at all, I would definitely see the appeal. However, as noted
> earlier, in the case of EFI having some read/write storage space is
> necessary to expose the full functionality, so going without it is
> not really an option.
>
> With all the above in mind, the cost of loongarch64 doing things
> differently from other architectures seems like it would outweight
> the benefits, and I strongly advise against it.
>
Hi Andrea :

     So, just to be clear, you're not suggesting either of the options I 
suggested above,

     are you? And still recommend that we use a two-piece pflash 
solution similar to other architectures,

      right?


Hi Philippe :

   I look forward to your reply and the comments of other members of the 
qemu community very much.

  If everyone has no opinions,

I will submit a patch to the community to change the loading mode of 
qemu under loongarch architecture to UEFI with two pieces of pflash.


Thanks,

Xianglai.



