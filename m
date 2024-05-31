Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC538C25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 14:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD33x-000345-9m; Fri, 31 May 2024 10:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1sD33v-00033i-BM
 for qemu-devel@nongnu.org; Fri, 31 May 2024 10:16:55 -0400
Received: from out-170.mta1.migadu.com ([95.215.58.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1sD33s-0004Qh-A1
 for qemu-devel@nongnu.org; Fri, 31 May 2024 10:16:55 -0400
X-Envelope-To: jean-philippe@linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1717165008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Ue70eTHlML7+q3TyVUpGkrsdlZzc9QaK4MwSa60L4o=;
 b=hzljrTKxA/yw+MaWWaqN/IYYyaDDZo34m2V8QzDan9ghGXV3qU++mFhVrop982vYG1xpNb
 oNxEMgJTsNcFD2+n4ooSFMTGjr95Y3F7bCMXj1sxxyhjb7thNs+vaOeDA2fQdVy3rI994y
 u73cJ8tUw+f0bBX5TJuHSdypHmtZkqE=
X-Envelope-To: peter.maydell@linaro.org
X-Envelope-To: philmd@linaro.org
X-Envelope-To: qemu-devel@nongnu.org
X-Envelope-To: qemu-arm@nongnu.org
X-Envelope-To: richard.henderson@linaro.org
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: Unexpected error in rme_configure_one() at
 ../target/arm/kvm-rme.c:159
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <20240531102135.GA40178@myrica>
Date: Fri, 31 May 2024 23:16:30 +0900
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E5197AF2-EEB3-4568-9F25-78622AD41AE4@linux.dev>
References: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
 <4e7aa598-1a5d-47e1-aaa3-78af05947eeb@linaro.org>
 <CB05CAA2-9301-45F6-8AE3-A2E27A160CDF@linux.dev>
 <CAFEAcA-gye9B1yJNKyT0fcZzR7TukNvaQyc7QkKQ_1FUGfAaYw@mail.gmail.com>
 <20240531102135.GA40178@myrica>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.170;
 envelope-from=itaru.kitayama@linux.dev; helo=out-170.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Jean,

> On May 31, 2024, at 19:21, Jean-Philippe Brucker =
<jean-philippe@linaro.org> wrote:
>=20
> Hi Itaru,
>=20
> On Fri, May 31, 2024 at 10:57:13AM +0100, Peter Maydell wrote:
>> On Fri, 31 May 2024 at 05:20, Itaru Kitayama =
<itaru.kitayama@linux.dev> wrote:
>>>=20
>>>=20
>>>=20
>>>> On May 30, 2024, at 22:30, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>>>>=20
>>>> Cc'ing more developers
>>>>=20
>>>> On 30/5/24 06:30, Itaru Kitayama wrote:
>>>>> Hi,
>>>>> When I see a Realm VM creation fails with:
>>>>> Unexpected error in rme_configure_one() at =
../target/arm/kvm-rme.c:159:
>>>>> qemu-system-aarch64: RME: failed to configure SVE: Invalid =
argument
>>>>> test.sh: line 8:  2502 Aborted                 qemu-system-aarch64 =
-M 'virt,acpi=3Doff,gic-version=3D3' -cpu host -enable-kvm -smp 2 -m =
512M -overcommit 'mem-lock=3Don' -M 'confidential-guest-support=3Drme0' =
-object =
'rme-guest,id=3Drme0,measurement-algo=3Dsha512,num-pmu-counters=3D6,sve-ve=
ctor-length=3D256' -kernel Image -initrd rootfs.cpio -append 'earycon =
console=3DttyAMA0 rdinit=3D/sbin/init' -nographic -net none
>>>>> do I need to suspect first the VMM, QEMU, or the Image? The kernel =
is built with LLVM, does it matter?
>>>>> Thanks,
>>>>> Itaru.
>>>>=20
>>>=20
>>> I=E2=80=99m testing Jean=E2=80=99s repo at:
>>>=20
>>> =
https://git.codelinaro.org/linaro/dcap/qemu/-/tree/cca/v2?ref_type=3Dheads=

>=20
> Thanks again for testing, you can report issues by replying directly =
to
> my posting, so I can get to them quicker. If you want I can Cc you on =
the
> next one. The latest is:
>=20
> [PATCH v2 00/22] arm: Run CCA VMs with KVM
> =
https://lore.kernel.org/qemu-devel/20240419155709.318866-2-jean-philippe@l=
inaro.org/

Thanks! I wasn=E2=80=99t aware of it The good news is that after whole =
day of try and error attempts I was able to
bring up a Realm VM on FVP. Here=E2=80=99s my version of overlay yaml, =
cca-v2.yaml:

build:
  linux:
    repo:
      revision: cca-full/v2

#  kvmtool:
#    repo:
#      revision: cca/v2

  rmm:
    repo:
      revision: main



  tfa:
    repo:
      revision: master

  kvm-unit-tests:
    repo:
      revision: cca/v2

=E2=80=A6 and the QEMU options are below:

qemu-system-aarch64 -M 'virt,acpi=3Doff,gic-version=3D3' \
-cpu host -enable-kvm -smp 2 -m 512M -overcommit 'mem-lock=3Don' \
-M 'confidential-guest-support=3Drme0' \
-object =
'rme-guest,id=3Drme0,measurement-algo=3Dsha512,num-pmu-counters=3D6,sve-ve=
ctor-length=3D256' \
-kernel Image -initrd rootfs.cpio \
-append 'earycon console=3DttyAMA0 rdinit=3D/sbin/init' -nographic -net =
none

Thanks,
Itaru.

>=20
> That does sound like the KVM host doesn't support SVE, but the QEMU =
VMM
> version is also too old: in the latest series 'sve-vector-length' was
> removed and we use the existing -cpu parameters to configure SVE. =
Please
> make sure that the QEMU branch is cca/v2 to match the Linux KVM =
branch,
> because the older QEMU patches doesn't work with the newest KVM =
patches.
> You'll need to update the command-line as well, because paramaters =
have
> changed for cca/v2.
>=20
> This may be the case of older build directories that aren't properly
> synchronized. They can be removed manually but the quicker way is =
usually
> to remove all source and build directories and start anew.
>=20
> Thanks,
> Jean
>=20
>=20
>>=20
>> OK, we should cc Jean-Philippe then.
>>=20
>> I'm wondering if this is as simple as "RME via KVM doesn't support =
SVE yet",
>> perhaps.
>>=20
>> thanks
>> -- PMM



