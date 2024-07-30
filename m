Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13205C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 23:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYvta-0006xh-CO; Tue, 30 Jul 2024 19:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1sYvtY-0006t1-IM
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 19:04:40 -0400
Received: from out-176.mta1.migadu.com ([2001:41d0:203:375::b0])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1sYvtU-0006M4-4O
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 19:04:40 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1722380667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3OFw4TsbunpvM3ZYueHfARU/HyEM2bedWjz9HiQWivg=;
 b=LxowF5062hlIIDazLxDWc22nviGO5sPSc0elJbmnCwmgQ+poF3sbW1nPorXPpAUJx7+x8Y
 p2LGaUoveRsVTDHifCAy0FyHoV/IOtcmCc/zyIMY7wSM8WRDAw1+3P/YvBgn17BPCNit8k
 p/viK8hCE41fFANXqZW9y0sv0783QmE=
From: Itaru Kitayama <itaru.kitayama@linux.dev>
Message-Id: <7F67EEEA-D222-4348-83EF-5C81C94C79D0@linux.dev>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_2ED71E53-A122-45C2-9FE2-38A64E29BCCD"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: QEMU unexpectedly closed the monitor
Date: Wed, 31 Jul 2024 08:04:08 +0900
In-Reply-To: <87le1jc8qi.fsf@draig.linaro.org>
Cc: qemu-devel@nongnu.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <8AFDCC22-C476-45EF-9119-2E3C9A2A91C3@linux.dev>
 <87le1jc8qi.fsf@draig.linaro.org>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::b0;
 envelope-from=itaru.kitayama@linux.dev; helo=out-176.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Apple-Mail=_2ED71E53-A122-45C2-9FE2-38A64E29BCCD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Alex,

> On Jul 30, 2024, at 22:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
> Itaru Kitayama <itaru.kitayama@linux.dev> writes:
>=20
>> Hi,
>>=20
>> Executing virt-install with the following options:
>>=20
>> sudo virt-install --machine=3Dvirt --arch=3Daarch64 --name=3Dtest8 =
--disk
>> =
path=3D/var/lib/libvirt/images/jammy.qcow2,format=3Dqcow2,device=3Ddisk,bu=
s=3Dvirtio,cache=3Dnone
>> --memory=3D2048 --vcpu=3D1 --nographic --check all=3Doff --features =
acpi=3Doff
>> --import --os-variant=3Dubuntu22.04 --virt-type kvm --boot
>> kernel=3DImage-guest-cca-v4,initrd=3Drootfs.cpio,kernel_args=3D'earlyco=
n
>> console=3DttyAMA0 rdinit=3D/sbin/init rw root=3D/dev/vda acpi=3Doff' =
--network
>> none
>>=20
>> receives an error:
>>=20
>> Starting install...
>> ERROR    internal error: QEMU unexpectedly closed the monitor =
(vm=3D'test8'): 2024-07-29T06:23:04.717118Z qemu-system-aarch64: could =
not load kernel '/home/realm/Image-guest-cca-v4=E2=80=99
>>=20
>> I am not sure how to investigate as the kernel Image =
(Image-guest-cca-v4) can work if it is used directly with the =
qemu-system-aarch64, like:
>>=20
>> sudo qemu-system-aarch64 -kernel Image-guest-cca-v4 -initrd
>> rootfs.cpio -cpu host -M virt,gic-version=3D3,acpi=3Doff -enable-kvm =
-smp
>> 2 -m 2048M -nographic -append 'earlycon console=3DttyAMA0
>> rdinit=3D/sbin/init rw root=3D/dev/vda acpi=3Doff' -net none
>=20
> Is there any way to get virt-install to dump its QEMU command line?
> There obviously seems to be something off if it works when you build =
the
> command line by hand.

Not in a form we wish, but structured way, see the attached log with the =
=E2=80=94debug option.

Itaru.


--Apple-Mail=_2ED71E53-A122-45C2-9FE2-38A64E29BCCD
Content-Disposition: attachment;
	filename=log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="log"
Content-Transfer-Encoding: 7bit

/home/realm/qemu-system-aarch64
[Wed, 31 Jul 2024 07:57:39 virt-install 1311] DEBUG (cli:204) Version 4.1.0 launched with command line: /usr/bin/virt-install --machine=virt --arch=aarch64 --name=test8 --disk path=/var/lib/libvirt/images/jammy.qcow2,format=qcow2,device=disk,bus=virtio,cache=none --memory=2048 --vcpu=1 --nographic --check all=off --features acpi=off --import --os-variant=ubuntu22.04 --virt-type kvm --boot kernel=/home/realm/Image-v6.10,initrd=/home/realm/rootfs.cpio,kernel_args=earlycon console=ttyAMA0 rdinit=/sbin/init rw root=/dev/vda acpi=on --network none --debug
[Wed, 31 Jul 2024 07:57:39 virt-install 1311] DEBUG (virtinstall:212) Distilled --network options: ['none']
[Wed, 31 Jul 2024 07:57:39 virt-install 1311] DEBUG (virtinstall:249) --graphics compat generated: none
[Wed, 31 Jul 2024 07:57:39 virt-install 1311] DEBUG (virtinstall:142) Distilled --disk options: ['path=/var/lib/libvirt/images/jammy.qcow2,format=qcow2,device=disk,bus=virtio,cache=none']
[Wed, 31 Jul 2024 07:57:39 virt-install 1311] DEBUG (cli:217) Requesting libvirt URI default
[Wed, 31 Jul 2024 07:57:49 virt-install 1311] DEBUG (connection:128) libvirt URI versions library=10.0.0 driver=10.0.0 hypervisor=8.2.2
[Wed, 31 Jul 2024 07:57:54 virt-install 1311] DEBUG (connection:109) Fetched capabilities for qemu:///system: <capabilities>

  <host>
    <uuid>28dc3674-b910-4898-a6b0-4b6ed12d55ce</uuid>
    <cpu>
      <arch>aarch64</arch>
      <topology sockets='1' dies='1' cores='8' threads='1'/>
      <pages unit='KiB' size='4'/>
      <pages unit='KiB' size='64'/>
      <pages unit='KiB' size='2048'/>
      <pages unit='KiB' size='32768'/>
      <pages unit='KiB' size='1048576'/>
    </cpu>
    <power_management>
      <suspend_mem/>
    </power_management>
    <iommu support='yes'/>
    <migration_features>
      <live/>
      <uri_transports>
        <uri_transport>tcp</uri_transport>
        <uri_transport>rdma</uri_transport>
      </uri_transports>
    </migration_features>
    <topology>
      <cells num='1'>
        <cell id='0'>
          <memory unit='KiB'>3941700</memory>
          <pages unit='KiB' size='4'>985425</pages>
          <pages unit='KiB' size='64'>0</pages>
          <pages unit='KiB' size='2048'>0</pages>
          <pages unit='KiB' size='32768'>0</pages>
          <pages unit='KiB' size='1048576'>0</pages>
          <distances>
            <sibling id='0' value='10'/>
          </distances>
          <cpus num='8'>
            <cpu id='0' socket_id='0' die_id='0' core_id='0' siblings='0'/>
            <cpu id='1' socket_id='0' die_id='0' core_id='1' siblings='1'/>
            <cpu id='2' socket_id='0' die_id='0' core_id='2' siblings='2'/>
            <cpu id='3' socket_id='0' die_id='0' core_id='3' siblings='3'/>
            <cpu id='4' socket_id='0' die_id='0' core_id='4' siblings='4'/>
            <cpu id='5' socket_id='0' die_id='0' core_id='5' siblings='5'/>
            <cpu id='6' socket_id='0' die_id='0' core_id='6' siblings='6'/>
            <cpu id='7' socket_id='0' die_id='0' core_id='7' siblings='7'/>
          </cpus>
        </cell>
      </cells>
    </topology>
    <secmodel>
      <model>none</model>
      <doi>0</doi>
    </secmodel>
    <secmodel>
      <model>dac</model>
      <doi>0</doi>
      <baselabel type='kvm'>+64055:+109</baselabel>
      <baselabel type='qemu'>+64055:+109</baselabel>
    </secmodel>
  </host>

  <guest>
    <os_type>hvm</os_type>
    <arch name='armv6l'>
      <wordsize>32</wordsize>
      <emulator>/usr/bin/qemu-system-arm</emulator>
      <machine maxCpus='512'>virt-8.2</machine>
      <machine canonical='virt-8.2' maxCpus='512'>virt</machine>
      <machine maxCpus='2'>qcom-dc-scm-v1-bmc</machine>
      <machine maxCpus='2'>mori-bmc</machine>
      <machine maxCpus='2'>ast2600-evb</machine>
      <machine maxCpus='1'>borzoi</machine>
      <machine maxCpus='1'>tiogapass-bmc</machine>
      <machine maxCpus='1'>spitz</machine>
      <machine maxCpus='255'>virt-2.7</machine>
      <machine maxCpus='2'>nuri</machine>
      <machine maxCpus='2'>mcimx7d-sabre</machine>
      <machine maxCpus='1'>romulus-bmc</machine>
      <machine maxCpus='512'>virt-3.0</machine>
      <machine maxCpus='512'>virt-5.0</machine>
      <machine maxCpus='2'>npcm750-evb</machine>
      <machine maxCpus='255'>virt-2.10</machine>
      <machine maxCpus='2'>rainier-bmc</machine>
      <machine maxCpus='1'>mps3-an547</machine>
      <machine maxCpus='2'>musca-b1</machine>
      <machine maxCpus='4'>realview-pbx-a9</machine>
      <machine maxCpus='1'>versatileab</machine>
      <machine maxCpus='1'>kzm</machine>
      <machine maxCpus='255'>virt-2.8</machine>
      <machine maxCpus='2'>fby35-bmc</machine>
      <machine maxCpus='2'>musca-a</machine>
      <machine maxCpus='512'>virt-3.1</machine>
      <machine maxCpus='1'>mcimx6ul-evk</machine>
      <machine maxCpus='512'>virt-5.1</machine>
      <machine maxCpus='2'>smdkc210</machine>
      <machine maxCpus='1'>sx1</machine>
      <machine maxCpus='255'>virt-2.11</machine>
      <machine maxCpus='1'>imx25-pdk</machine>
      <machine maxCpus='1'>stm32vldiscovery</machine>
      <machine maxCpus='255'>virt-2.9</machine>
      <machine maxCpus='4'>orangepi-pc</machine>
      <machine maxCpus='1'>quanta-q71l-bmc</machine>
      <machine maxCpus='1'>z2</machine>
      <machine maxCpus='512'>virt-5.2</machine>
      <machine maxCpus='1'>xilinx-zynq-a9</machine>
      <machine maxCpus='1'>tosa</machine>
      <machine maxCpus='1'>mps2-an500</machine>
      <machine maxCpus='255'>virt-2.12</machine>
      <machine maxCpus='2'>mps2-an521</machine>
      <machine maxCpus='4'>sabrelite</machine>
      <machine maxCpus='1'>mps2-an511</machine>
      <machine maxCpus='1'>canon-a1100</machine>
      <machine maxCpus='1'>realview-eb</machine>
      <machine maxCpus='2'>quanta-gbs-bmc</machine>
      <machine maxCpus='1'>emcraft-sf2</machine>
      <machine maxCpus='1'>realview-pb-a8</machine>
      <machine maxCpus='1'>yosemitev2-bmc</machine>
      <machine maxCpus='512'>virt-7.0</machine>
      <machine maxCpus='512'>virt-4.0</machine>
      <machine maxCpus='1'>raspi1ap</machine>
      <machine maxCpus='1'>palmetto-bmc</machine>
      <machine maxCpus='1'>sx1-v1</machine>
      <machine maxCpus='1'>n810</machine>
      <machine maxCpus='1'>g220a-bmc</machine>
      <machine maxCpus='1'>n800</machine>
      <machine maxCpus='512'>virt-7.1</machine>
      <machine maxCpus='2'>tacoma-bmc</machine>
      <machine maxCpus='2'>bletchley-bmc</machine>
      <machine maxCpus='512'>virt-4.1</machine>
      <machine maxCpus='2'>quanta-gsj</machine>
      <machine maxCpus='1'>versatilepb</machine>
      <machine maxCpus='1'>terrier</machine>
      <machine maxCpus='1'>mainstone</machine>
      <machine maxCpus='4'>realview-eb-mpcore</machine>
      <machine maxCpus='1'>integratorcp</machine>
      <machine maxCpus='512'>virt-7.2</machine>
      <machine maxCpus='1'>supermicrox11-bmc</machine>
      <machine maxCpus='512'>virt-4.2</machine>
      <machine maxCpus='1'>witherspoon-bmc</machine>
      <machine maxCpus='2'>qcom-firework-bmc</machine>
      <machine maxCpus='2'>mps3-an524</machine>
      <machine maxCpus='2'>kudo-bmc</machine>
      <machine maxCpus='4'>vexpress-a9</machine>
      <machine maxCpus='4'>midway</machine>
      <machine maxCpus='1'>musicpal</machine>
      <machine maxCpus='1'>lm3s811evb</machine>
      <machine maxCpus='1'>lm3s6965evb</machine>
      <machine maxCpus='1'>supermicro-x11spi-bmc</machine>
      <machine maxCpus='1'>microbit</machine>
      <machine maxCpus='3'>fby35</machine>
      <machine maxCpus='1'>mps2-an505</machine>
      <machine maxCpus='1'>mps2-an385</machine>
      <machine maxCpus='512'>virt-6.0</machine>
      <machine maxCpus='512'>virt-8.0</machine>
      <machine maxCpus='1'>cubieboard</machine>
      <machine maxCpus='1'>ast1030-evb</machine>
      <machine maxCpus='1'>verdex</machine>
      <machine maxCpus='1'>netduino2</machine>
      <machine maxCpus='4'>bpim2u</machine>
      <machine maxCpus='1'>mps2-an386</machine>
      <machine maxCpus='1'>olimex-stm32-h405</machine>
      <machine maxCpus='512'>virt-6.1</machine>
      <machine maxCpus='512'>virt-8.1</machine>
      <machine maxCpus='4'>raspi2b</machine>
      <machine maxCpus='4'>vexpress-a15</machine>
      <machine maxCpus='2'>fuji-bmc</machine>
      <machine maxCpus='512'>virt-6.2</machine>
      <machine maxCpus='1'>sonorapass-bmc</machine>
      <machine maxCpus='1'>cheetah</machine>
      <machine maxCpus='255'>virt-2.6</machine>
      <machine maxCpus='1'>ast2500-evb</machine>
      <machine maxCpus='4'>highbank</machine>
      <machine maxCpus='1'>akita</machine>
      <machine maxCpus='1'>connex</machine>
      <machine maxCpus='1'>netduinoplus2</machine>
      <machine maxCpus='1'>collie</machine>
      <machine maxCpus='1'>raspi0</machine>
      <machine maxCpus='1'>fp5280g2-bmc</machine>
      <domain type='qemu'/>
    </arch>
    <features>
      <cpuselection/>
      <deviceboot/>
      <disksnapshot default='on' toggle='no'/>
      <externalSnapshot/>
    </features>
  </guest>

  <guest>
    <os_type>hvm</os_type>
    <arch name='armv7l'>
      <wordsize>32</wordsize>
      <emulator>/usr/bin/qemu-system-aarch64</emulator>
      <machine maxCpus='512'>virt-8.2</machine>
      <machine canonical='virt-8.2' maxCpus='512'>virt</machine>
      <machine maxCpus='2'>qcom-dc-scm-v1-bmc</machine>
      <machine maxCpus='2'>mori-bmc</machine>
      <machine maxCpus='2'>ast2600-evb</machine>
      <machine maxCpus='1'>borzoi</machine>
      <machine maxCpus='1'>tiogapass-bmc</machine>
      <machine maxCpus='1'>spitz</machine>
      <machine maxCpus='255'>virt-2.7</machine>
      <machine maxCpus='2'>nuri</machine>
      <machine maxCpus='2'>mcimx7d-sabre</machine>
      <machine maxCpus='1'>romulus-bmc</machine>
      <machine maxCpus='512'>virt-3.0</machine>
      <machine maxCpus='512'>virt-5.0</machine>
      <machine maxCpus='2'>npcm750-evb</machine>
      <machine maxCpus='255'>virt-2.10</machine>
      <machine maxCpus='2'>rainier-bmc</machine>
      <machine maxCpus='1'>mps3-an547</machine>
      <machine maxCpus='2'>musca-b1</machine>
      <machine maxCpus='4'>realview-pbx-a9</machine>
      <machine maxCpus='1'>versatileab</machine>
      <machine maxCpus='1'>kzm</machine>
      <machine maxCpus='255'>virt-2.8</machine>
      <machine maxCpus='2'>fby35-bmc</machine>
      <machine maxCpus='2'>musca-a</machine>
      <machine maxCpus='512'>virt-3.1</machine>
      <machine maxCpus='1'>mcimx6ul-evk</machine>
      <machine maxCpus='512'>virt-5.1</machine>
      <machine maxCpus='2'>smdkc210</machine>
      <machine maxCpus='1'>sx1</machine>
      <machine maxCpus='255'>virt-2.11</machine>
      <machine maxCpus='1'>imx25-pdk</machine>
      <machine maxCpus='1'>stm32vldiscovery</machine>
      <machine maxCpus='255'>virt-2.9</machine>
      <machine maxCpus='4'>orangepi-pc</machine>
      <machine maxCpus='1'>quanta-q71l-bmc</machine>
      <machine maxCpus='1'>z2</machine>
      <machine maxCpus='512'>virt-5.2</machine>
      <machine maxCpus='1'>xilinx-zynq-a9</machine>
      <machine maxCpus='6'>xlnx-zcu102</machine>
      <machine maxCpus='1'>tosa</machine>
      <machine maxCpus='1'>mps2-an500</machine>
      <machine maxCpus='255'>virt-2.12</machine>
      <machine maxCpus='2'>mps2-an521</machine>
      <machine maxCpus='4'>sabrelite</machine>
      <machine maxCpus='1'>mps2-an511</machine>
      <machine maxCpus='1'>canon-a1100</machine>
      <machine maxCpus='1'>realview-eb</machine>
      <machine maxCpus='2'>quanta-gbs-bmc</machine>
      <machine maxCpus='1'>emcraft-sf2</machine>
      <machine maxCpus='1'>realview-pb-a8</machine>
      <machine maxCpus='512'>sbsa-ref</machine>
      <machine maxCpus='1'>yosemitev2-bmc</machine>
      <machine maxCpus='512'>virt-7.0</machine>
      <machine maxCpus='512'>virt-4.0</machine>
      <machine maxCpus='1'>raspi1ap</machine>
      <machine maxCpus='1'>palmetto-bmc</machine>
      <machine maxCpus='1'>sx1-v1</machine>
      <machine maxCpus='1'>n810</machine>
      <machine maxCpus='1'>g220a-bmc</machine>
      <machine maxCpus='1'>n800</machine>
      <machine maxCpus='512'>virt-7.1</machine>
      <machine maxCpus='2'>tacoma-bmc</machine>
      <machine maxCpus='2'>bletchley-bmc</machine>
      <machine maxCpus='512'>virt-4.1</machine>
      <machine maxCpus='2'>quanta-gsj</machine>
      <machine maxCpus='1'>versatilepb</machine>
      <machine maxCpus='1'>terrier</machine>
      <machine maxCpus='1'>mainstone</machine>
      <machine maxCpus='4'>realview-eb-mpcore</machine>
      <machine maxCpus='1'>integratorcp</machine>
      <machine maxCpus='512'>virt-7.2</machine>
      <machine maxCpus='1'>supermicrox11-bmc</machine>
      <machine maxCpus='512'>virt-4.2</machine>
      <machine maxCpus='1'>witherspoon-bmc</machine>
      <machine maxCpus='2'>qcom-firework-bmc</machine>
      <machine maxCpus='2'>mps3-an524</machine>
      <machine maxCpus='2'>kudo-bmc</machine>
      <machine maxCpus='4'>vexpress-a9</machine>
      <machine maxCpus='4'>midway</machine>
      <machine maxCpus='1'>musicpal</machine>
      <machine maxCpus='1'>lm3s811evb</machine>
      <machine maxCpus='1'>lm3s6965evb</machine>
      <machine maxCpus='1'>supermicro-x11spi-bmc</machine>
      <machine maxCpus='1'>microbit</machine>
      <machine maxCpus='3'>fby35</machine>
      <machine maxCpus='1'>mps2-an505</machine>
      <machine maxCpus='1'>mps2-an385</machine>
      <machine maxCpus='512'>virt-6.0</machine>
      <machine maxCpus='512'>virt-8.0</machine>
      <machine maxCpus='4'>raspi3ap</machine>
      <machine maxCpus='1'>cubieboard</machine>
      <machine maxCpus='1'>ast1030-evb</machine>
      <machine maxCpus='1'>verdex</machine>
      <machine maxCpus='1'>netduino2</machine>
      <machine maxCpus='4'>bpim2u</machine>
      <machine maxCpus='4'>xlnx-versal-virt</machine>
      <machine maxCpus='1'>mps2-an386</machine>
      <machine maxCpus='1'>olimex-stm32-h405</machine>
      <machine maxCpus='512'>virt-6.1</machine>
      <machine maxCpus='512'>virt-8.1</machine>
      <machine maxCpus='4'>raspi3b</machine>
      <machine maxCpus='4'>raspi2b</machine>
      <machine maxCpus='4'>vexpress-a15</machine>
      <machine maxCpus='2'>fuji-bmc</machine>
      <machine maxCpus='512'>virt-6.2</machine>
      <machine maxCpus='1'>x-remote</machine>
      <machine maxCpus='1'>cheetah</machine>
      <machine maxCpus='1'>sonorapass-bmc</machine>
      <machine maxCpus='255'>virt-2.6</machine>
      <machine maxCpus='1'>ast2500-evb</machine>
      <machine maxCpus='4'>highbank</machine>
      <machine maxCpus='1'>akita</machine>
      <machine maxCpus='1'>connex</machine>
      <machine maxCpus='1'>netduinoplus2</machine>
      <machine maxCpus='1'>collie</machine>
      <machine maxCpus='1'>raspi0</machine>
      <machine maxCpus='1'>fp5280g2-bmc</machine>
      <domain type='qemu'/>
      <domain type='kvm'/>
    </arch>
    <features>
      <cpuselection/>
      <deviceboot/>
      <disksnapshot default='on' toggle='no'/>
      <externalSnapshot/>
    </features>
  </guest>

  <guest>
    <os_type>hvm</os_type>
    <arch name='aarch64'>
      <wordsize>64</wordsize>
      <emulator>/usr/bin/qemu-system-aarch64</emulator>
      <machine maxCpus='512'>virt-8.2</machine>
      <machine canonical='virt-8.2' maxCpus='512'>virt</machine>
      <machine maxCpus='2'>qcom-dc-scm-v1-bmc</machine>
      <machine maxCpus='2'>mori-bmc</machine>
      <machine maxCpus='2'>ast2600-evb</machine>
      <machine maxCpus='1'>borzoi</machine>
      <machine maxCpus='1'>tiogapass-bmc</machine>
      <machine maxCpus='1'>spitz</machine>
      <machine maxCpus='255'>virt-2.7</machine>
      <machine maxCpus='2'>nuri</machine>
      <machine maxCpus='2'>mcimx7d-sabre</machine>
      <machine maxCpus='1'>romulus-bmc</machine>
      <machine maxCpus='512'>virt-3.0</machine>
      <machine maxCpus='512'>virt-5.0</machine>
      <machine maxCpus='2'>npcm750-evb</machine>
      <machine maxCpus='255'>virt-2.10</machine>
      <machine maxCpus='2'>rainier-bmc</machine>
      <machine maxCpus='1'>mps3-an547</machine>
      <machine maxCpus='2'>musca-b1</machine>
      <machine maxCpus='4'>realview-pbx-a9</machine>
      <machine maxCpus='1'>versatileab</machine>
      <machine maxCpus='1'>kzm</machine>
      <machine maxCpus='255'>virt-2.8</machine>
      <machine maxCpus='2'>fby35-bmc</machine>
      <machine maxCpus='2'>musca-a</machine>
      <machine maxCpus='512'>virt-3.1</machine>
      <machine maxCpus='1'>mcimx6ul-evk</machine>
      <machine maxCpus='512'>virt-5.1</machine>
      <machine maxCpus='2'>smdkc210</machine>
      <machine maxCpus='1'>sx1</machine>
      <machine maxCpus='255'>virt-2.11</machine>
      <machine maxCpus='1'>imx25-pdk</machine>
      <machine maxCpus='1'>stm32vldiscovery</machine>
      <machine maxCpus='255'>virt-2.9</machine>
      <machine maxCpus='4'>orangepi-pc</machine>
      <machine maxCpus='1'>quanta-q71l-bmc</machine>
      <machine maxCpus='1'>z2</machine>
      <machine maxCpus='512'>virt-5.2</machine>
      <machine maxCpus='1'>xilinx-zynq-a9</machine>
      <machine maxCpus='6'>xlnx-zcu102</machine>
      <machine maxCpus='1'>tosa</machine>
      <machine maxCpus='1'>mps2-an500</machine>
      <machine maxCpus='255'>virt-2.12</machine>
      <machine maxCpus='2'>mps2-an521</machine>
      <machine maxCpus='4'>sabrelite</machine>
      <machine maxCpus='1'>mps2-an511</machine>
      <machine maxCpus='1'>canon-a1100</machine>
      <machine maxCpus='1'>realview-eb</machine>
      <machine maxCpus='2'>quanta-gbs-bmc</machine>
      <machine maxCpus='1'>emcraft-sf2</machine>
      <machine maxCpus='1'>realview-pb-a8</machine>
      <machine maxCpus='512'>sbsa-ref</machine>
      <machine maxCpus='1'>yosemitev2-bmc</machine>
      <machine maxCpus='512'>virt-7.0</machine>
      <machine maxCpus='512'>virt-4.0</machine>
      <machine maxCpus='1'>raspi1ap</machine>
      <machine maxCpus='1'>palmetto-bmc</machine>
      <machine maxCpus='1'>sx1-v1</machine>
      <machine maxCpus='1'>n810</machine>
      <machine maxCpus='1'>g220a-bmc</machine>
      <machine maxCpus='1'>n800</machine>
      <machine maxCpus='512'>virt-7.1</machine>
      <machine maxCpus='2'>tacoma-bmc</machine>
      <machine maxCpus='2'>bletchley-bmc</machine>
      <machine maxCpus='512'>virt-4.1</machine>
      <machine maxCpus='2'>quanta-gsj</machine>
      <machine maxCpus='1'>versatilepb</machine>
      <machine maxCpus='1'>terrier</machine>
      <machine maxCpus='1'>mainstone</machine>
      <machine maxCpus='4'>realview-eb-mpcore</machine>
      <machine maxCpus='1'>integratorcp</machine>
      <machine maxCpus='512'>virt-7.2</machine>
      <machine maxCpus='1'>supermicrox11-bmc</machine>
      <machine maxCpus='512'>virt-4.2</machine>
      <machine maxCpus='1'>witherspoon-bmc</machine>
      <machine maxCpus='2'>qcom-firework-bmc</machine>
      <machine maxCpus='2'>mps3-an524</machine>
      <machine maxCpus='2'>kudo-bmc</machine>
      <machine maxCpus='4'>vexpress-a9</machine>
      <machine maxCpus='4'>midway</machine>
      <machine maxCpus='1'>musicpal</machine>
      <machine maxCpus='1'>lm3s811evb</machine>
      <machine maxCpus='1'>lm3s6965evb</machine>
      <machine maxCpus='1'>supermicro-x11spi-bmc</machine>
      <machine maxCpus='1'>microbit</machine>
      <machine maxCpus='3'>fby35</machine>
      <machine maxCpus='1'>mps2-an505</machine>
      <machine maxCpus='1'>mps2-an385</machine>
      <machine maxCpus='512'>virt-6.0</machine>
      <machine maxCpus='512'>virt-8.0</machine>
      <machine maxCpus='4'>raspi3ap</machine>
      <machine maxCpus='1'>cubieboard</machine>
      <machine maxCpus='1'>ast1030-evb</machine>
      <machine maxCpus='1'>verdex</machine>
      <machine maxCpus='1'>netduino2</machine>
      <machine maxCpus='4'>bpim2u</machine>
      <machine maxCpus='4'>xlnx-versal-virt</machine>
      <machine maxCpus='1'>mps2-an386</machine>
      <machine maxCpus='1'>olimex-stm32-h405</machine>
      <machine maxCpus='512'>virt-6.1</machine>
      <machine maxCpus='512'>virt-8.1</machine>
      <machine maxCpus='4'>raspi3b</machine>
      <machine maxCpus='4'>raspi2b</machine>
      <machine maxCpus='4'>vexpress-a15</machine>
      <machine maxCpus='2'>fuji-bmc</machine>
      <machine maxCpus='512'>virt-6.2</machine>
      <machine maxCpus='1'>x-remote</machine>
      <machine maxCpus='1'>cheetah</machine>
      <machine maxCpus='1'>sonorapass-bmc</machine>
      <machine maxCpus='255'>virt-2.6</machine>
      <machine maxCpus='1'>ast2500-evb</machine>
      <machine maxCpus='4'>highbank</machine>
      <machine maxCpus='1'>akita</machine>
      <machine maxCpus='1'>connex</machine>
      <machine maxCpus='1'>netduinoplus2</machine>
      <machine maxCpus='1'>collie</machine>
      <machine maxCpus='1'>raspi0</machine>
      <machine maxCpus='1'>fp5280g2-bmc</machine>
      <domain type='qemu'/>
      <domain type='kvm'/>
    </arch>
    <features>
      <acpi default='on' toggle='yes'/>
      <cpuselection/>
      <deviceboot/>
      <disksnapshot default='on' toggle='no'/>
      <externalSnapshot/>
    </features>
  </guest>

</capabilities>

[Wed, 31 Jul 2024 07:57:54 virt-install 1311] DEBUG (cli:220) Received libvirt URI qemu:///system
[Wed, 31 Jul 2024 07:59:05 virt-install 1311] DEBUG (guest:341) Setting Guest osinfo name <_OsVariant name=generic>
[Wed, 31 Jul 2024 07:59:05 virt-install 1311] DEBUG (guest:341) Setting Guest osinfo name <_OsVariant name=ubuntu22.04>
[Wed, 31 Jul 2024 07:59:05 virt-install 1311] DEBUG (installer:542) No media for distro detection.
[Wed, 31 Jul 2024 07:59:05 virt-install 1311] DEBUG (installer:544) installer.detect_distro returned=None
[Wed, 31 Jul 2024 07:59:06 virt-install 1311] DEBUG (osdict:216) No recommended value found for key='n-cpus', using minimum=1 * 2
[Wed, 31 Jul 2024 07:59:06 virt-install 1311] DEBUG (guest:546) Prefer EFI => True
[Wed, 31 Jul 2024 07:59:06 virt-install 1311] DEBUG (guest:1113) Using num_pcie_root_ports=14
[Wed, 31 Jul 2024 07:59:07 virt-install 1311] DEBUG (cli:322) Skipping --check path_in_use error condition 'Disk /var/lib/libvirt/images/jammy.qcow2 is already in use by other guests ['jammy', 'tmp9', 'tmp1', 'tmp19', 'test'].'
[Wed, 31 Jul 2024 07:59:07 virt-install 1311] WARNING (cli:325) Disk /var/lib/libvirt/images/jammy.qcow2 is already in use by other guests ['jammy', 'tmp9', 'tmp1', 'tmp19', 'test'].
[Wed, 31 Jul 2024 07:59:07 virt-install 1311] DEBUG (disk:239) DeviceDisk.check_path_search path=/var/lib/libvirt/images/jammy.qcow2
[Wed, 31 Jul 2024 07:59:07 virt-install 1311] DEBUG (cli:266) 
Starting install...
[Wed, 31 Jul 2024 07:59:08 virt-install 1311] DEBUG (installer:587) Generated initial_xml: None required
[Wed, 31 Jul 2024 07:59:08 virt-install 1311] DEBUG (installer:589) Generated final_xml: 
<domain type="kvm">
  <name>test8</name>
  <uuid>b32a6305-44e2-470e-b514-2c0aff76549b</uuid>
  <metadata>
    <libosinfo:libosinfo xmlns:libosinfo="http://libosinfo.org/xmlns/libvirt/domain/1.0">
      <libosinfo:os id="http://ubuntu.com/ubuntu/22.04"/>
    </libosinfo:libosinfo>
  </metadata>
  <memory>2097152</memory>
  <currentMemory>2097152</currentMemory>
  <vcpu>1</vcpu>
  <os>
    <type arch="aarch64" machine="virt">hvm</type>
    <kernel>/home/realm/Image-v6.10</kernel>
    <initrd>/home/realm/rootfs.cpio</initrd>
    <cmdline>earlycon console=ttyAMA0 rdinit=/sbin/init rw root=/dev/vda acpi=on</cmdline>
  </os>
  <cpu mode="host-passthrough"/>
  <clock offset="utc"/>
  <devices>
    <emulator>/usr/bin/qemu-system-aarch64</emulator>
    <disk type="file" device="disk">
      <driver name="qemu" type="qcow2" cache="none"/>
      <source file="/var/lib/libvirt/images/jammy.qcow2"/>
      <target dev="vda" bus="virtio"/>
    </disk>
    <controller type="usb" model="qemu-xhci" ports="15"/>
    <controller type="pci" model="pcie-root"/>
    <controller type="pci" model="pcie-root-port"/>
    <controller type="pci" model="pcie-root-port"/>
    <controller type="pci" model="pcie-root-port"/>
    <controller type="pci" model="pcie-root-port"/>
    <controller type="pci" model="pcie-root-port"/>
    <controller type="pci" model="pcie-root-port"/>
    <controller type="pci" model="pcie-root-port"/>
    <controller type="pci" model="pcie-root-port"/>
    <controller type="pci" model="pcie-root-port"/>
    <controller type="pci" model="pcie-root-port"/>
    <controller type="pci" model="pcie-root-port"/>
    <controller type="pci" model="pcie-root-port"/>
    <controller type="pci" model="pcie-root-port"/>
    <controller type="pci" model="pcie-root-port"/>
    <console type="pty"/>
    <channel type="unix">
      <source mode="bind"/>
      <target type="virtio" name="org.qemu.guest_agent.0"/>
    </channel>
    <memballoon model="virtio"/>
    <rng model="virtio">
      <backend model="random">/dev/urandom</backend>
    </rng>
  </devices>
</domain>

[Wed, 31 Jul 2024 07:59:10 virt-install 1311] DEBUG (cli:256)   File "/usr/bin/virt-install", line 8, in <module>
    virtinstall.runcli()
  File "/usr/share/virt-manager/virtinst/virtinstall.py", line 1233, in runcli
    sys.exit(main())
  File "/usr/share/virt-manager/virtinst/virtinstall.py", line 1226, in main
    start_install(guest, installer, options)
  File "/usr/share/virt-manager/virtinst/virtinstall.py", line 974, in start_install
    fail(e, do_exit=False)
  File "/usr/share/virt-manager/virtinst/cli.py", line 256, in fail
    log.debug("".join(traceback.format_stack()))

[Wed, 31 Jul 2024 07:59:10 virt-install 1311] ERROR (cli:257) internal error: QEMU unexpectedly closed the monitor (vm='test8'): 2024-07-30T22:59:10.099540Z qemu-system-aarch64: could not load kernel '/home/realm/Image-v6.10'
[Wed, 31 Jul 2024 07:59:10 virt-install 1311] DEBUG (cli:259) 
Traceback (most recent call last):
  File "/usr/share/virt-manager/virtinst/virtinstall.py", line 954, in start_install
    domain = installer.start_install(
             ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/share/virt-manager/virtinst/install/installer.py", line 695, in start_install
    domain = self._create_guest(
             ^^^^^^^^^^^^^^^^^^^
  File "/usr/share/virt-manager/virtinst/install/installer.py", line 637, in _create_guest
    domain = self.conn.createXML(initial_xml or final_xml, 0)
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/libvirt.py", line 4529, in createXML
    raise libvirtError('virDomainCreateXML() failed')
libvirt.libvirtError: internal error: QEMU unexpectedly closed the monitor (vm='test8'): 2024-07-30T22:59:10.099540Z qemu-system-aarch64: could not load kernel '/home/realm/Image-v6.10'
[Wed, 31 Jul 2024 07:59:10 virt-install 1311] DEBUG (cli:272) Domain installation does not appear to have been successful.
If it was, you can restart your domain by running:
  virsh --connect qemu:///system start test8
otherwise, please restart your installation.
Domain installation does not appear to have been successful.
If it was, you can restart your domain by running:
  virsh --connect qemu:///system start test8
otherwise, please restart your installation.

Starting install...

--Apple-Mail=_2ED71E53-A122-45C2-9FE2-38A64E29BCCD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


>=20
>>=20
>> Userland is Ubuntu 24.04, and the host and guest kernels are for the =
protected VM (Realm) execution.
>> Any help would be appreciated.
>>=20
>> Thanks,
>> Itaru.
>=20
> --=20
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro



--Apple-Mail=_2ED71E53-A122-45C2-9FE2-38A64E29BCCD--

