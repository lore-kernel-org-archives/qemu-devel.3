Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47C3C47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 09:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUjyp-0007Vn-Q8; Tue, 30 Jan 2024 04:00:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1rUjyY-0007Si-Da
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:00:19 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1rUjyS-0000dk-Ku
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:00:14 -0500
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8Cx77uOurhldUYIAA--.5898S3;
 Tue, 30 Jan 2024 16:59:59 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxb8+JurhlFbUnAA--.9668S2; 
 Tue, 30 Jan 2024 16:59:55 +0800 (CST)
From: lixianglai <lixianglai@loongson.cn>
Subject: Re: [libvirt PATCH V2 0/4] add loongarch support for libvirt
To: Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: devel@lists.libvirt.org, maobibo@loongson.cn, lichao@loongson.cn,
 jiyin@redhat.com
References: <cover.1704369486.git.lixianglai@loongson.cn>
 <CABJz62MxNvFfs4aCRyp+7YANupU2T4k7x1C6avm=curjB+NmkA@mail.gmail.com>
Message-ID: <17234d81-cc17-6859-720a-f033206780da@loongson.cn>
Date: Tue, 30 Jan 2024 16:59:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CABJz62MxNvFfs4aCRyp+7YANupU2T4k7x1C6avm=curjB+NmkA@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------6C01E8F29BC60E10B8AC954D"
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bxb8+JurhlFbUnAA--.9668S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9fXoWfGr1DZrykXFW3uryxZrWDGFX_yoW8Gw48Wo
 WfuF47Aw4UGr1DGF17Jrs5JF15A348KrnrX3s7Wa4DGF1UtF4UG3yUW34UGa43Jr1rGryU
 X34xX3s8AFW7Jryfl-sFpf9Il3svdjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn1kqx4xG6xAqzII2Y4kfWbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVr
 nRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6r
 Wj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
 1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j
 6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrV
 CF54CIxcxKerWlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvj
 eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCjr7xvwVCIw2I0I7xG6c02F41lc7I2V7
 IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
 0s026c02F40E14v26r106r1rMI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
 0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
 0xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
 IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZE
 Xa7IUb_Ma5UUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-4.241, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is a multi-part message in MIME format.
--------------6C01E8F29BC60E10B8AC954D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andrea:

     I'm sorry for taking so long to reply you!

Hi Philippe:

     When developing libvirt on loongarch, we encountered some problems 
related to pflash.

libvirt and qemu met some difficulties in the coordination of UEFI loading.

I think we need your suggestions and opinions on the solution.


> On Fri, Jan 12, 2024 at 02:32:43PM +0800, Xianglai Li wrote:
>> Hello, Everyone:
>>    This patch series adds libvirt support for loongarch.Although the bios
>> path and name has not been officially integrated into qemu and we think
>> there are still many shortcomings, we try to push a version of patch to
>> the community according to the opinions of the community, hoping to
>> listen to everyone's opinions. Anyway we have a version of libvirt that
>> supports loongarch.
>>
>>    You can also get libvirt's patch from the link below:
>> https://gitlab.com/lixianglai/libvirt
>> branch: loongarch
>>
>>    Since the patch associated with loongarch has not yet been submitted to
>> the virt-manager community, we are providing a temporary patch with
>> loongarch for the time being patch's virt-manager, the open source work
>> of virt-manager adding loongarch will be followed up later or
>> synchronized with the open source libvirt.
>>
>>    You can get the virt-manager code with loongarch patch from the link below:
>> https://github.com/lixianglai/virt-manager
>> branch: loongarch
> It's really great that you're considering the entire stack, all the
> way up to virt-manager, while working on this! :)
Oh! Thanks!

:)

>>    loongarch's virtual machine bios is not yet available in qemu, so you can get it from the following link
>> https://github.com/lixianglai/LoongarchVirtFirmware
>> (Note: You should clone the repository using git instead of downloading the file via wget or you'll get xml)
>> We named the bios QEMU_EFI.fd, QEMU_VARS.fd is used to store pflash images of non-volatile
>> variables.After installing qemu-system-loongarch64,You can install the loongarch bios by executing the script
>> install-loongarch-virt-firmware.sh
> To clarify, loongarch support has been merged into upstream edk2
> already, right? And the contents of this repository are just for
> convenience, since loongarch builds of edk2 have generally not made
> it into distros yet? I think I might have asked about this already,
> sorry O:-)

Don't mention it.

All right, The loongarch support has been merged into upstream edk2 already.

And you can see a detailed description of loongarch uefi in the link below:

https://github.com/tianocore/edk2-platforms/blob/master/Platform/Loongson/LoongArchQemuPkg/Readme.md

this repository are just for convenience. :)


> Anyway, I fetched and installed this. The firmware descriptor looks
> like:
>
>    {
>       "interface-types": [
>         "uefi"
>       ],
>       "mapping": {
>         "device": "memory",
>         "filename": "/usr/share/edk2/loongarch64/QEMU_EFI.fd"
>       },
>       "targets": [
>         {
>           "architecture": "loongarch64",
>           "machines": [
>             "virt",
>             "virt-*"
>           ]
>         }
>       ],
>       "features": [
>           "acpi"
>       ]
>     }
>
> This is not what I expected: specifically, it results in libvirt
> generating
>
>    -bios /usr/share/edk2/loongarch64/QEMU_EFI.fd
>
> So only one of the two files is used, in read-only mode, and there is
> no persistent NVRAM storage that the guest can use.
>
> This is what I expected instead:
>
>    {
>       "interface-types": [
>         "uefi"
>       ],
>       "mapping": {
>         "device": "flash",
>         "mode": "split",
>         "executable": {
>           "filename": "/usr/share/edk2/loongarch64/QEMU_EFI.fd",
>           "format": "raw"
>         },
>         "nvram-template": {
>           "filename": "/usr/share/edk2/loongarch64/QEMU_VARS.fd",
>           "format": "raw"
>         }
>       },
>       "targets": [
>         {
>           "architecture": "loongarch64",
>           "machines": [
>             "virt",
>             "virt-*"
>           ]
>         }
>       ],
>       "features": [
>           "acpi"
>      ]
>    }
>
> I've tried installing such a descriptor and libvirt picks it up,
> resulting in the following guest configuration:
>
>    <os firmware='efi'>
>      <type arch='loongarch64' machine='virt'>hvm</type>
>      <firmware>
>        <feature enabled='no' name='enrolled-keys'/>
>        <feature enabled='no' name='secure-boot'/>
>      </firmware>
>      <loader readonly='yes'
> type='pflash'>/usr/share/edk2/loongarch64/QEMU_EFI.fd</loader>
>      <nvram template='/usr/share/edk2/loongarch64/QEMU_VARS.fd'>/var/lib/libvirt/qemu/nvram/guest_VARS.fd</nvram>
>      <boot dev='hd'/>
>    </os>
>
> which in turn produces the following QEMU command line options:
>
>    -blockdev '{"driver":"file","filename":"/usr/share/edk2/loongarch64/QEMU_EFI.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"discard":"unmap"}'
>    -blockdev '{"node-name":"libvirt-pflash0-format","read-only":true,"driver":"raw","file":"libvirt-pflash0-storage"}'
>    -blockdev '{"driver":"file","filename":"/var/lib/libvirt/qemu/nvram/guest_VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,"discard":"unmap"}'
>    -blockdev '{"node-name":"libvirt-pflash1-format","read-only":false,"driver":"raw","file":"libvirt-pflash1-storage"}'
>
> Unfortunately, with this configuration the guest fails to start:
>
>    qemu-system-loongarch64: Property 'virt-machine.pflash0' not found
>
> This error message looked familiar to me, as it is the same that I
> hit when trying out UEFI support on RISC-V roughly a year ago[1]. In
> this case, however, it seems that the issue runs deeper: it's not
> just that the flash devices are not wired up to work as blockdevs,
> but even the old -drive syntax doesn't work.
>
> Looking at the QEMU code, it appears that the loongarch/virt machine
> only creates a single pflash device and exposes it via -bios. So it
> seems that there is simply no way to achieve the configuration that
> we want.
>
> I think that this is something that needs to be addressed as soon as
> possible. In the long run, guest-accessible NVRAM storage is a must,
> and I'm not sure it would make a lot of sense to merge loongarch
> support into libvirt until the firmware situation has been sorted out
> in the lower layers.


In the qemu code, loongarch virt machine does only create a pflash,

which is used for nvram, and uefi code is loaded by rom.

In summary, loongarch virt machine can use nvram with the following command:

-------------------------------------------------------------------------------------------------------

/qemu-system-loongarch64 \//
//-m 8G \//
//-smp 4 \//
//-cpu la464   \//
//-blockdev 
'{"driver":"file","filename":"./QEMU_VARS-pflash.raw","node-name":"libvirt-pflash0-storage","auto-read-only":false,"discard":"unmap"}' 
\//
//-blockdev 
'{"node-name":"libvirt-pflash0-format","read-only":false,"driver":"raw","file":"libvirt-pflash0-storage"}' 
\//
//-machine virt,pflash=libvirt-pflash0-format  \//
//-snapshot \//
//-bios ./QEMU_EFI.fd  \//
//-serial stdio/

-------------------------------------------------------------------------------------------------------


This is really a big difference from the following boot method, and it 
still looks weird.

-------------------------------------------------------------------------------------------------------

/-blockdev 
'{"driver":"file","filename":"/usr/share/edk2/loongarch64/QEMU_EFI.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"discard":"unmap"}' 
-blockdev 
'{"node-name":"libvirt-pflash0-format","read-only":true,"driver":"raw","file":"libvirt-pflash0-storage"}' 
-blockdev 
'{"driver":"file","filename":"/var/lib/libvirt/qemu/nvram/guest_VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,"discard":"unmap"}' 
-blockdev 
'{"node-name":"libvirt-pflash1-format","read-only":false,"driver":"raw","file":"libvirt-pflash1-storage"}'/

-------------------------------------------------------------------------------------------------------

However, during the development of qemu loongarch,

we also used a RISCV-like solution to create two pflash,

but the qemu community suggested that we put uefi code in rom for the 
following reasons:


https://lore.kernel.org/qemu-devel/2f381d06-842f-ac8b-085c-0419675a4872@linaro.org/

"

Since you are starting a virtual machine from scratch, you should take
the opportunity to learn from other early mistakes. X86 ended that way
due to 1/ old firmwares back-compability and 2/ QEMU pflash block
protections not being implemented. IIUC if we were starting with a
UEFI firmware today, the layout design (still using QEMU) would be
to map the CODE area in a dumb ROM device, and the VARSTORE area
in a PFlash device. Since Virt machines don't need to use Capsule
update, having the CODE area in ROM drastically simplifies the design
and maintainance.

"

Well, anyway, now that we have an issue with qemu loongarch using nvram 
that is incompatible with libvirt,

here I have come up with two solutions to solve this problem:


    Option 1:

If the interface type "rom-uefi" is added and the device type 
"rom-flash" is added, the json file should be written like this:

-------------------------------------------------------------------------------------------------------

/{//
//   "interface-types": [//
////"rom-uefi"//
//   ],//
//   "mapping": {//
////"device": "rom-flash",//
//     "executable": {//
//       "filename": "/usr/share/edk2/loongarch64/QEMU_EFI.fd",//
//       "format": "raw"//
//     },//
//     "nvram-template": {//
//       "filename": "/usr/share/edk2/loongarch64/QEMU_VARS.fd",//
//       "format": "raw"//
//     }//
//   },//
//   "targets": [//
//     {//
//       "architecture": "loongarch64",//
//       "machines": [//
//         "virt",//
//         "virt-*"//
//       ]//
//     }//
//   ],//
//   "features": [//
//       "acpi"//
//   ]/

  -------------------------------------------------------------------------------------------------------

Then add the parsing of the new interface types in libvirt and load 
QEMU_CODE.fd as -bios and QEMU_VARS.fd as nvram

when creating the command line, generating commands like the following:

  -------------------------------------------------------------------------------------------------------

/qemu-system-loongarch64 \//
//-m 8G \//
//-smp 1 \//
//-cpu la464   \//
//-blockdev 
'{"driver":"file","filename":"////usr/share/edk2/loongarch64/QEMU_VARS.fd/","node-name":"libvirt-pflash0-storage","auto-read-only":false,"discard":"unmap"}' 
\//
//-blockdev 
'{"node-name":"libvirt-pflash0-format","read-only":false,"driver":"raw","file":"libvirt-pflash0-storage"}' 
\//
//-machine virt,pflash=libvirt-pflash0-format  \//
//-snapshot \//
//-bios /////usr/share/edk2/loongarch64///QEMU_EFI.fd \//
//-serial stdio/

-------------------------------------------------------------------------------------------------------


    Option 2:

Solution 2 mainly starts from qemu. Now the rom that bios is loaded into 
is a memory region that cannot be configured with attributes,

so we imagine abstracting rom as a device, creating it during machine 
initialization and setting "pflash0" attribute for it.

Then create a pflash and set its property to "pflash1", so our startup 
command will look like this:

  -------------------------------------------------------------------------------------------------------

/qemu-system-loongarch64 \//
//-m 8G \//
//-smp 1 \//
//-cpu la464   \//
//-blockdev 
'{"driver":"file","filename":"/usr/share/edk2/loongarch64/QEMU_EFI.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"discard":"unmap"}' 
\//
//-blockdev 
'{"node-name":"libvirt-pflash0-format","read-only":true,"driver":"raw","file":"libvirt-pflash0-storage"}' 
\//
//-blockdev 
'{"driver":"file","filename":"/usr/share/edk2/loongarch64/QEMU_VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,"discard":"unmap"}' 
\//
//-blockdev 
'{"node-name":"libvirt-pflash1-format","read-only":false,"driver":"raw","file":"libvirt-pflash1-storage"}' 
\//
//-machine 
virt,pflash0=libvirt-pflash0-format,pflash1=libvirt-pflash1-format \//
//-snapshot \//
//-serial stdio/

  -------------------------------------------------------------------------------------------------------

This way, without modifying libvirt, QEMU_CODE.fd can be loaded into the 
rom,

but it is still a little strange that it is clearly rom but set a 
"pflash0" attribute, which can be confusing.


>>    Since there is no fedora operating system that supports the loongarch
>> architecture, you can find an iso that supports loongarch at the link
>> below for testing purposes:
>>    https://github.com/fedora-remix-loongarch/releases-info
>>
>>    Well, if you have completed the above steps I think you can now install loongarch virtual machine,
>> you can install it through the virt-manager graphical interface, or install it through vrit-install,
>> here is an example of installing it using virt-install:
>>
>> virt-install  \
>> --virt-type=qemu \
>> --name  loongarch-test \
>> --memory 4096 \
>> --vcpus=4 \
>> --arch=loongarch64 \
>> --boot cdrom \
>> --disk device=cdrom,bus=scsi,path=/root/livecd-fedora-mate-4.loongarch64.iso \
>> --disk path=/var/lib/libvirt/images/debian12-loongarch64.qcow2,size=10,format=qcow2,bus=scsi \
>> --network network=default \
>> --osinfo archlinux   \
>> --video=virtio  \
>> --graphics=vnc,listen=0.0.0.0
> Regardless of what I said above, this actually worked quite well! I
> was able to boot the MATE image and, ignoring the expected slowness
> caused by emulation, things were generally fairly smooth.
>
> Note that I tried the LXDE image first, expecting it to be a bit
> smaller and faster, but in that case I wasn't able to get a
> successful boot: edk2 loaded up just fine, but the guest OS was never
> started and I was dropped into the edk2 shell instead. Maybe that's a
> known issue, but I thought I'd point it out.

Thank you very much for pointing out the problem,

lxde iso is missing efiboot.img file so that the virtual machine UEFI 
can not recognize efi partition

caused by the problem has been notified to the relevant personnel,

I believe that the next version of libvirt patch will be shipped to use 
lxde iso.


Thanks,

Xianglai.

> [1]https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg06258.html

--------------6C01E8F29BC60E10B8AC954D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Andrea:</p>
    <p>    I'm sorry for taking so long to reply you!</p>
    <p>Hi Philippe:</p>
    <p>    When developing libvirt on loongarch, we encountered some
      problems related to pflash. <br>
    </p>
    <p>libvirt and qemu met some difficulties in the coordination of
      UEFI loading.</p>
    <p> I think we need your suggestions and opinions on the solution.</p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CABJz62MxNvFfs4aCRyp+7YANupU2T4k7x1C6avm=curjB+NmkA@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Fri, Jan 12, 2024 at 02:32:43PM +0800, Xianglai Li wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Hello, Everyone:
  This patch series adds libvirt support for loongarch.Although the bios
path and name has not been officially integrated into qemu and we think
there are still many shortcomings, we try to push a version of patch to
the community according to the opinions of the community, hoping to
listen to everyone's opinions. Anyway we have a version of libvirt that
supports loongarch.

  You can also get libvirt's patch from the link below:
<a class="moz-txt-link-freetext" href="https://gitlab.com/lixianglai/libvirt">https://gitlab.com/lixianglai/libvirt</a>
branch: loongarch

  Since the patch associated with loongarch has not yet been submitted to
the virt-manager community, we are providing a temporary patch with
loongarch for the time being patch's virt-manager, the open source work
of virt-manager adding loongarch will be followed up later or
synchronized with the open source libvirt.

  You can get the virt-manager code with loongarch patch from the link below:
<a class="moz-txt-link-freetext" href="https://github.com/lixianglai/virt-manager">https://github.com/lixianglai/virt-manager</a>
branch: loongarch
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">It's really great that you're considering the entire stack, all the
way up to virt-manager, while working on this! :)</pre>
    </blockquote>
    Oh! Thanks! <br>
    <pre class="moz-quote-pre" wrap="">:)</pre>
    <blockquote type="cite"
cite="mid:CABJz62MxNvFfs4aCRyp+7YANupU2T4k7x1C6avm=curjB+NmkA@mail.gmail.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">  loongarch's virtual machine bios is not yet available in qemu, so you can get it from the following link
<a class="moz-txt-link-freetext" href="https://github.com/lixianglai/LoongarchVirtFirmware">https://github.com/lixianglai/LoongarchVirtFirmware</a>
(Note: You should clone the repository using git instead of downloading the file via wget or you'll get xml)
We named the bios QEMU_EFI.fd, QEMU_VARS.fd is used to store pflash images of non-volatile
variables.After installing qemu-system-loongarch64,You can install the loongarch bios by executing the script
install-loongarch-virt-firmware.sh
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">To clarify, loongarch support has been merged into upstream edk2
already, right? And the contents of this repository are just for
convenience, since loongarch builds of edk2 have generally not made
it into distros yet? I think I might have asked about this already,
sorry O:-)</pre>
    </blockquote>
    <p><span style="color: rgb(25, 27, 31); font-family: -apple-system,
        BlinkMacSystemFont, &quot;Helvetica Neue&quot;, &quot;PingFang
        SC&quot;, &quot;Microsoft YaHei&quot;, &quot;Source Han Sans
        SC&quot;, &quot;Noto Sans CJK SC&quot;, &quot;WenQuanYi Micro
        Hei&quot;, sans-serif; font-size: medium; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: start; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
        255); text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;">Don't mention it. <br>
      </span></p>
    <p><span style="color: rgb(25, 27, 31); font-family: -apple-system,
        BlinkMacSystemFont, &quot;Helvetica Neue&quot;, &quot;PingFang
        SC&quot;, &quot;Microsoft YaHei&quot;, &quot;Source Han Sans
        SC&quot;, &quot;Noto Sans CJK SC&quot;, &quot;WenQuanYi Micro
        Hei&quot;, sans-serif; font-size: medium; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: start; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
        255); text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;"><span style="color: rgb(51, 51, 51);
          font-family: &quot;PingFang SC&quot;, &quot;Lantinghei
          SC&quot;, &quot;Microsoft YaHei&quot;, arial, 宋体, sans-serif,
          tahoma; font-size: 16px; font-style: normal;
          font-variant-ligatures: normal; font-variant-caps: normal;
          font-weight: 400; letter-spacing: normal; orphans: 2;
          text-align: start; text-indent: 0px; text-transform: none;
          white-space: normal; widows: 2; word-spacing: 0px;
          -webkit-text-stroke-width: 0px; background-color: rgb(255,
          255, 255); text-decoration-thickness: initial;
          text-decoration-style: initial; text-decoration-color:
          initial; display: inline !important; float: none;">All right</span>,</span>
      The loongarch support has been merged into upstream edk2 already.</p>
    <p>And you can see a detailed description of loongarch uefi in the
      link below:</p>
    <p><a class="moz-txt-link-freetext"
href="https://github.com/tianocore/edk2-platforms/blob/master/Platform/Loongson/LoongArchQemuPkg/Readme.md">https://github.com/tianocore/edk2-platforms/blob/master/Platform/Loongson/LoongArchQemuPkg/Readme.md</a><br>
    </p>
    <pre class="moz-quote-pre" wrap="">this repository are just for convenience. :)
</pre>
    <p><br>
      <span style="color: rgb(25, 27, 31); font-family: -apple-system,
        BlinkMacSystemFont, &quot;Helvetica Neue&quot;, &quot;PingFang
        SC&quot;, &quot;Microsoft YaHei&quot;, &quot;Source Han Sans
        SC&quot;, &quot;Noto Sans CJK SC&quot;, &quot;WenQuanYi Micro
        Hei&quot;, sans-serif; font-size: medium; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: start; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
        255); text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;"></span></p>
    <blockquote type="cite"
cite="mid:CABJz62MxNvFfs4aCRyp+7YANupU2T4k7x1C6avm=curjB+NmkA@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">Anyway, I fetched and installed this. The firmware descriptor looks
like:

  {
     "interface-types": [
       "uefi"
     ],
     "mapping": {
       "device": "memory",
       "filename": "/usr/share/edk2/loongarch64/QEMU_EFI.fd"
     },
     "targets": [
       {
         "architecture": "loongarch64",
         "machines": [
           "virt",
           "virt-*"
         ]
       }
     ],
     "features": [
         "acpi"
     ]
   }

This is not what I expected: specifically, it results in libvirt
generating

  -bios /usr/share/edk2/loongarch64/QEMU_EFI.fd

So only one of the two files is used, in read-only mode, and there is
no persistent NVRAM storage that the guest can use.

This is what I expected instead:

  {
     "interface-types": [
       "uefi"
     ],
     "mapping": {
       "device": "flash",
       "mode": "split",
       "executable": {
         "filename": "/usr/share/edk2/loongarch64/QEMU_EFI.fd",
         "format": "raw"
       },
       "nvram-template": {
         "filename": "/usr/share/edk2/loongarch64/QEMU_VARS.fd",
         "format": "raw"
       }
     },
     "targets": [
       {
         "architecture": "loongarch64",
         "machines": [
           "virt",
           "virt-*"
         ]
       }
     ],
     "features": [
         "acpi"
    ]
  }

I've tried installing such a descriptor and libvirt picks it up,
resulting in the following guest configuration:

  &lt;os firmware='efi'&gt;
    &lt;type arch='loongarch64' machine='virt'&gt;hvm&lt;/type&gt;
    &lt;firmware&gt;
      &lt;feature enabled='no' name='enrolled-keys'/&gt;
      &lt;feature enabled='no' name='secure-boot'/&gt;
    &lt;/firmware&gt;
    &lt;loader readonly='yes'
type='pflash'&gt;/usr/share/edk2/loongarch64/QEMU_EFI.fd&lt;/loader&gt;
    &lt;nvram template='/usr/share/edk2/loongarch64/QEMU_VARS.fd'&gt;/var/lib/libvirt/qemu/nvram/guest_VARS.fd&lt;/nvram&gt;
    &lt;boot dev='hd'/&gt;
  &lt;/os&gt;

which in turn produces the following QEMU command line options:

  -blockdev '{"driver":"file","filename":"/usr/share/edk2/loongarch64/QEMU_EFI.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"discard":"unmap"}'
  -blockdev '{"node-name":"libvirt-pflash0-format","read-only":true,"driver":"raw","file":"libvirt-pflash0-storage"}'
  -blockdev '{"driver":"file","filename":"/var/lib/libvirt/qemu/nvram/guest_VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,"discard":"unmap"}'
  -blockdev '{"node-name":"libvirt-pflash1-format","read-only":false,"driver":"raw","file":"libvirt-pflash1-storage"}'

Unfortunately, with this configuration the guest fails to start:

  qemu-system-loongarch64: Property 'virt-machine.pflash0' not found

This error message looked familiar to me, as it is the same that I
hit when trying out UEFI support on RISC-V roughly a year ago[1]. In
this case, however, it seems that the issue runs deeper: it's not
just that the flash devices are not wired up to work as blockdevs,
but even the old -drive syntax doesn't work.

Looking at the QEMU code, it appears that the loongarch/virt machine
only creates a single pflash device and exposes it via -bios. So it
seems that there is simply no way to achieve the configuration that
we want.

I think that this is something that needs to be addressed as soon as
possible. In the long run, guest-accessible NVRAM storage is a must,
and I'm not sure it would make a lot of sense to merge loongarch
support into libvirt until the firmware situation has been sorted out
in the lower layers.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>In the qemu code, loongarch virt machine does only create a
      pflash, <br>
    </p>
    <p>which is used for nvram, and uefi code is loaded by rom.</p>
    <p> In summary, loongarch virt machine can use nvram with the
      following command:</p>
    <p>-------------------------------------------------------------------------------------------------------</p>
    <p><i>qemu-system-loongarch64 \</i><i><br>
      </i><i>-m 8G \</i><i><br>
      </i><i>-smp 4 \</i><i><br>
      </i><i>-cpu la464   \</i><i><br>
      </i><i>-blockdev
'{"driver":"file","filename":"./QEMU_VARS-pflash.raw","node-name":"libvirt-pflash0-storage","auto-read-only":false,"discard":"unmap"}' 
        \</i><i><br>
      </i><i>-blockdev
'{"node-name":"libvirt-pflash0-format","read-only":false,"driver":"raw","file":"libvirt-pflash0-storage"}'
        \</i><i><br>
      </i><i>-machine virt,pflash=libvirt-pflash0-format  \</i><i><br>
      </i><i>-snapshot \</i><i><br>
      </i><i>-bios ./QEMU_EFI.fd  \</i><i><br>
      </i><i>-serial stdio</i></p>
    <p>-------------------------------------------------------------------------------------------------------</p>
    <p><br>
    </p>
    <p>This is really a big difference from the following boot method,
      and it still looks weird.</p>
    <p>-------------------------------------------------------------------------------------------------------</p>
    <pre class="moz-quote-pre" wrap=""><i>  -blockdev '{"driver":"file","filename":"/usr/share/edk2/loongarch64/QEMU_EFI.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"discard":"unmap"}'
  -blockdev '{"node-name":"libvirt-pflash0-format","read-only":true,"driver":"raw","file":"libvirt-pflash0-storage"}'
  -blockdev '{"driver":"file","filename":"/var/lib/libvirt/qemu/nvram/guest_VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,"discard":"unmap"}'
  -blockdev '{"node-name":"libvirt-pflash1-format","read-only":false,"driver":"raw","file":"libvirt-pflash1-storage"}'</i>
</pre>
    <p>-------------------------------------------------------------------------------------------------------</p>
    <p>However, during the development of qemu loongarch,</p>
    <p> we also used a RISCV-like solution to create two pflash,</p>
    <p> but the qemu community suggested that we put uefi code in rom
      for the following reasons:</p>
    <p><br>
    </p>
    <p><a class="moz-txt-link-freetext"
href="https://lore.kernel.org/qemu-devel/2f381d06-842f-ac8b-085c-0419675a4872@linaro.org/">https://lore.kernel.org/qemu-devel/2f381d06-842f-ac8b-085c-0419675a4872@linaro.org/</a></p>
    <p>"</p>
    <pre id="b" style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 0, 51); white-space: pre-wrap; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Since you are starting a virtual machine from scratch, you should take
the opportunity to learn from other early mistakes. X86 ended that way
due to 1/ old firmwares back-compability and 2/ QEMU pflash block
protections not being implemented. IIUC if we were starting with a
UEFI firmware today, the layout design (still using QEMU) would be
to map the CODE area in a dumb ROM device, and the VARSTORE area
in a PFlash device. Since Virt machines don't need to use Capsule
update, having the CODE area in ROM drastically simplifies the design
and maintainance.</pre>
    <p>"</p>
    <p>Well, anyway, now that we have an issue with qemu loongarch using
      nvram that is incompatible with libvirt,</p>
    <p> here I have come up with two solutions to solve this problem:<br>
    </p>
    <h2>Option 1:  <br>
    </h2>
    <p>If the interface type "rom-uefi" is added and the device type
      "rom-flash" is added, the json file should be written like this:</p>
    <p>-------------------------------------------------------------------------------------------------------<br>
    </p>
    <i>{</i><i><br>
    </i><i>   "interface-types": [</i><i><br>
    </i><i>    </i><i><font color="#ff0000"> "rom-uefi"</font></i><i><br>
    </i><i>   ],</i><i><br>
    </i><i>   "mapping": {</i><i><br>
    </i><i>     </i><i><font color="#ff0000">"device": "rom-flash",</font></i><i><br>
    </i><i>     "executable": {</i><i><br>
    </i><i>       "filename": "/usr/share/edk2/loongarch64/QEMU_EFI.fd",</i><i><br>
    </i><i>       "format": "raw"</i><i><br>
    </i><i>     },</i><i><br>
    </i><i>     "nvram-template": {</i><i><br>
    </i><i>       "filename":
      "/usr/share/edk2/loongarch64/QEMU_VARS.fd",</i><i><br>
    </i><i>       "format": "raw"</i><i><br>
    </i><i>     }</i><i><br>
    </i><i>   },</i><i><br>
    </i><i>   "targets": [</i><i><br>
    </i><i>     {</i><i><br>
    </i><i>       "architecture": "loongarch64",</i><i><br>
    </i><i>       "machines": [</i><i><br>
    </i><i>         "virt",</i><i><br>
    </i><i>         "virt-*"</i><i><br>
    </i><i>       ]</i><i><br>
    </i><i>     }</i><i><br>
    </i><i>   ],</i><i><br>
    </i><i>   "features": [</i><i><br>
    </i><i>       "acpi"</i><i><br>
    </i><i>   ]</i><br>
    <p> -------------------------------------------------------------------------------------------------------</p>
    <p>Then add the parsing of the new interface types in libvirt and
      load QEMU_CODE.fd as -bios and QEMU_VARS.fd as nvram</p>
    <p>when creating the command line, generating commands like the
      following:</p>
    <p> -------------------------------------------------------------------------------------------------------</p>
    <p><i>qemu-system-loongarch64 \</i><i><br>
      </i><i> -m 8G \</i><i><br>
      </i><i> -smp 1 \</i><i><br>
      </i><i> -cpu la464   \</i><i><br>
      </i><i> -blockdev '{"driver":"file","filename":"</i><i><i>/usr/share/edk2/loongarch64/QEMU_VARS.fd</i>","node-name":"libvirt-pflash0-storage","auto-read-only":false,"discard":"unmap"}' 
        \</i><i><br>
      </i><i> -blockdev
'{"node-name":"libvirt-pflash0-format","read-only":false,"driver":"raw","file":"libvirt-pflash0-storage"}'
        \</i><i><br>
      </i><i> -machine virt,pflash=libvirt-pflash0-format  \</i><i><br>
      </i><i> -snapshot \</i><i><br>
      </i><i> -bios </i><i><i><i>/usr/share/edk2/loongarch64/</i></i>QEMU_EFI.fd 
        \</i><i><br>
      </i><i> -serial stdio</i><br>
    </p>
    <p>
-------------------------------------------------------------------------------------------------------</p>
    <h2>Option 2: </h2>
    <p>Solution 2 mainly starts from qemu. Now the rom that bios is
      loaded into is a memory region that cannot be configured with
      attributes,</p>
    <p> so we imagine abstracting rom as a device, creating it during
      machine initialization and setting "pflash0" attribute for it. <br>
    </p>
    <p>Then create a pflash and set its property to "pflash1", so our
      startup command will look like this:</p>
    <p> -------------------------------------------------------------------------------------------------------</p>
    <p><i>qemu-system-loongarch64 \</i><i><br>
      </i><i>-m 8G \</i><i><br>
      </i><i>-smp 1 \</i><i><br>
      </i><i>-cpu la464   \</i><i><br>
      </i><i>-blockdev
'{"driver":"file","filename":"/usr/share/edk2/loongarch64/QEMU_EFI.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"discard":"unmap"}'
        \</i><i><br>
      </i><i>-blockdev
'{"node-name":"libvirt-pflash0-format","read-only":true,"driver":"raw","file":"libvirt-pflash0-storage"}'
        \</i><i><br>
      </i><i>-blockdev
'{"driver":"file","filename":"/usr/share/edk2/loongarch64/QEMU_VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,"discard":"unmap"}'
        \</i><i><br>
      </i><i>-blockdev
'{"node-name":"libvirt-pflash1-format","read-only":false,"driver":"raw","file":"libvirt-pflash1-storage"}'
        \</i><i><br>
      </i><i>-machine
        virt,pflash0=libvirt-pflash0-format,pflash1=libvirt-pflash1-format 
        \</i><i><br>
      </i><i>-snapshot \</i><i><br>
      </i><i>-serial stdio</i><br>
    </p>
    <p> -------------------------------------------------------------------------------------------------------</p>
    <p>This way, without modifying libvirt, QEMU_CODE.fd can be loaded
      into the rom, <br>
    </p>
    <p>but it is still a little strange that it is clearly rom but set a
      "pflash0" attribute, which can be confusing.</p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CABJz62MxNvFfs4aCRyp+7YANupU2T4k7x1C6avm=curjB+NmkA@mail.gmail.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">  Since there is no fedora operating system that supports the loongarch
architecture, you can find an iso that supports loongarch at the link
below for testing purposes:
  <a class="moz-txt-link-freetext" href="https://github.com/fedora-remix-loongarch/releases-info">https://github.com/fedora-remix-loongarch/releases-info</a>

  Well, if you have completed the above steps I think you can now install loongarch virtual machine,
you can install it through the virt-manager graphical interface, or install it through vrit-install,
here is an example of installing it using virt-install:

virt-install  \
--virt-type=qemu \
--name  loongarch-test \
--memory 4096 \
--vcpus=4 \
--arch=loongarch64 \
--boot cdrom \
--disk device=cdrom,bus=scsi,path=/root/livecd-fedora-mate-4.loongarch64.iso \
--disk path=/var/lib/libvirt/images/debian12-loongarch64.qcow2,size=10,format=qcow2,bus=scsi \
--network network=default \
--osinfo archlinux   \
--video=virtio  \
--graphics=vnc,listen=0.0.0.0
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Regardless of what I said above, this actually worked quite well! I
was able to boot the MATE image and, ignoring the expected slowness
caused by emulation, things were generally fairly smooth.

Note that I tried the LXDE image first, expecting it to be a bit
smaller and faster, but in that case I wasn't able to get a
successful boot: edk2 loaded up just fine, but the guest OS was never
started and I was dropped into the edk2 shell instead. Maybe that's a
known issue, but I thought I'd point it out.</pre>
    </blockquote>
    <p>Thank you very much for pointing out the problem, <br>
    </p>
    <p>lxde iso is missing efiboot.img file so that the virtual machine
      UEFI can not recognize efi partition</p>
    <p>caused by the problem has been notified to the relevant
      personnel,</p>
    <p> I believe that the next version of libvirt patch will be shipped
      to use lxde iso.</p>
    <p><br>
    </p>
    <p>Thanks,</p>
    <p>Xianglai.<br>
    </p>
    <blockquote type="cite"
cite="mid:CABJz62MxNvFfs4aCRyp+7YANupU2T4k7x1C6avm=curjB+NmkA@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
[1] <a class="moz-txt-link-freetext" href="https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg06258.html">https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg06258.html</a>
</pre>
    </blockquote>
  </body>
</html>

--------------6C01E8F29BC60E10B8AC954D--


