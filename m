Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032F4D1CDC2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 03:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQzdI-0008LO-K0; Wed, 03 Dec 2025 22:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@openatom.club>)
 id 1vQzdG-0008Ka-Jv
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 22:03:50 -0500
Received: from sg-1-19.ptr.blmpb.com ([118.26.132.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu@openatom.club>)
 id 1vQzdD-00089j-TT
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 22:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1764817417;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=/d2cITZ3pJqOyNOHqwT3yT1xNB5DNJUJc6I3ln8peiA=;
 b=YrV2wSDDguc+DZVRI52fnWwZlYElE9WwzmmHoLOBCQck66SpPgerZQ4QjPEvDtpWgc9m+p
 gELP5zbeWNiPs3jK4eh610hZZfhgHDdzTqAgNldjaxWdUFs460tp9onVXNS7W8ErQlI02p
 3nljb3UqRXOng2/fX1FxgNDomN6E81u+5QxXzBlscq7AZMBMXm2qJbFghIAaIz9lPUg4Uz
 dtk8Xuf1lB0iceVDVek1G1RNMwKXcsZI6nhZ/C+pkq12AqJqRciVxGxOcaRGcHEu9ZSwM4
 rOFwGemgOpaBO+TYlEWHGe6mW4GYnFAyAL1eCZ/69LEPgnAY686EkzztRnoPdg==
Date: Thu, 4 Dec 2025 11:03:33 +0800
Message-Id: <b1123953-c106-4cb8-8f80-f5b31cf4a98a@openatom.club>
References: <cover.1764493931.git.chao.liu@zevorn.cn>
 <a303c6a1f48e7ba076bb62d78084d0008ae39526.1764493931.git.chao.liu@zevorn.cn>
 <6163ffd5-b0ff-4993-9db2-36492702487c@ventanamicro.com>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, 
 <hust-os-kernel-patches@googlegroups.com>
X-Original-From: Chao Liu <chao.liu@openatom.club>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
To: "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 "Chao Liu" <chao.liu@zevorn.cn>, <richard.henderson@linaro.org>, 
 <paolo.savini@embecosm.com>, <npiggin@gmail.com>, <ebiggers@kernel.org>, 
 <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>, 
 <zhiwei_liu@linux.alibaba.com>
From: "Chao Liu" <chao.liu@openatom.club>
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] docs/system/riscv: add documentation for k230
 machine
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26930fa07+deea36+nongnu.org+chao.liu@openatom.club>
Received: from [10.13.14.160] ([218.81.29.112]) by smtp.feishu.cn with ESMTPS;
 Thu, 04 Dec 2025 11:03:34 +0800
In-Reply-To: <6163ffd5-b0ff-4993-9db2-36492702487c@ventanamicro.com>
Received-SPF: pass client-ip=118.26.132.19;
 envelope-from=chao.liu@openatom.club; helo=sg-1-19.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/4/2025 1:19 AM, Daniel Henrique Barboza wrote:
> Hi,
>=20
> This patch won't build in my env:
>=20
> [3031/3032] Generating docs/QEMU manual with a custom command
> FAILED: docs/docs.stamp
> /usr/bin/env CONFDIR=3Detc/qemu /home/danielhb/work/qemu/build/pyvenv/bin=
/sphinx-
> build -q -W -Dkerneldoc_werror=3D1 -j auto -Dversion=3D10.1.92 -Drelease=
=3D -
> Ddepfile=3Ddocs/docs.d -Ddepfile_stamp=3Ddocs/docs.stamp -b html -d /home=
/danielhb/
> work/qemu/build/docs/manual.p /home/danielhb/work/qemu/docs /home/danielh=
b/work/
> qemu/build/docs/manual
> /home/danielhb/work/qemu/docs/system/riscv/k230.rst: WARNING: document is=
n't
> included in any toctree
> ninja: build stopped: subcommand failed.
>=20
>=20
>=20
> This diff fixes it:
>=20
>=20
> $ git diff
> diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
> index 89b2cb732c..2103ff6173 100644
> --- a/docs/system/target-riscv.rst
> +++ b/docs/system/target-riscv.rst
> @@ -66,6 +66,7 @@ undocumented; you can get a complete list by running
> =C2=A0.. toctree::
> =C2=A0=C2=A0=C2=A0 :maxdepth: 1
> =C2=A0
> +=C2=A0=C2=A0 riscv/k230
> =C2=A0=C2=A0=C2=A0 riscv/microblaze-v-generic
> =C2=A0=C2=A0=C2=A0 riscv/microchip-icicle-kit
> =C2=A0=C2=A0=C2=A0 riscv/shakti-c
>=20
Nice :)

Thanks, Daniel, for fixing this issue. I will apply this bugfix in PATCH v2=
.

Chao
>=20
>=20
> Thanks,
>=20
> Daniel
>=20
>=20
> On 11/30/25 6:21 AM, Chao Liu wrote:
>> Add documentation for k230 virt reference platform.
>>
>> Signed-off-by: Chao Liu <chao.liu@zevorn.cn>
>> ---
>> =C2=A0 docs/system/riscv/k230.rst | 48 +++++++++++++++++++++++++++++++++=
+++++
>> =C2=A0 1 file changed, 48 insertions(+)
>> =C2=A0 create mode 100644 docs/system/riscv/k230.rst
>>
>> diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
>> new file mode 100644
>> index 0000000000..3e6ca295df
>> --- /dev/null
>> +++ b/docs/system/riscv/k230.rst
>> @@ -0,0 +1,48 @@
>> +Kendryte K230 virt reference platform (``k230``)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>> +The ``k230`` machine is compatible with with Kendryte K230 SDK.
>> +
>> +The K230 is a chip from the AIoT SoC series made by Kendryte =C2=AE =E2=
=80=94 a part of
>> +Canaan Inc. It uses a brand-new multi-heterogeneous unit accelerated co=
mputing
>> +structure.
>> +
>> +This chip has 2 RISC-V computing cores and a new-generation KPU (Knowle=
dge
>> +Process Unit) smart computing unit.
>> +
>> +It has multi-precision AI computing ability, works with many common AI =
computing
>> +frameworks, and for some typical networks, its usage rate is over 70%. =
Besides,
>> +the K230 chip supports many peripheral connections and has several spec=
ial
>> +hardware acceleration units (like 2D and 2.5D accelerators). It can spe=
ed up
>> +different tasks (such as image processing, video processing, audio proc=
essing
>> +and AI computing). It also has many good features: low delay, high perf=
ormance,
>> +low power use and fast start-up.
>> +
>> +For more information, see <https://www.kendryte.com/en/proDetail/230>
>> +
>> +Supported devices
>> +-----------------
>> +The ``k230`` machine supports the following devices:
>> +
>> +* 1 c908 cores
>> +* Core Local Interruptor (CLINT)
>> +* Incoming MSI Controller (IMSIC)
>> +* 2 K230 Watchdog Timer
>> +* 4 UART
>> +
>> +Boot options
>> +------------
>> +The ``k230`` machine can start using the standard ``-bios``
>> +functionality for loading the boot image. You need to compile and link
>> +the firmware, kernel, and Device Tree (FDT) into a single binary file w=
ith
>> +K230 SDK(k230_canmv_defconfig), such as ``uboot``.
>> +
>> +Running
>> +-------
>> +Below is an example command line for running the ``k230``
>> +machine:
>> +
>> +.. code-block:: bash
>> +
>> +=C2=A0=C2=A0 $ qemu-system-riscv64 -machine k230 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -bios k230_sdk/output/k230_canmv_defconf=
ig/little/uboot/u-boot \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -nographic
>

