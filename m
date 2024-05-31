Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02E9C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 04:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCtjs-0002R1-Qv; Fri, 31 May 2024 00:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1sCtjr-0002Qh-Uf
 for qemu-devel@nongnu.org; Fri, 31 May 2024 00:19:35 -0400
Received: from out-185.mta1.migadu.com ([95.215.58.185])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1sCtjp-0002HW-Dt
 for qemu-devel@nongnu.org; Fri, 31 May 2024 00:19:35 -0400
X-Envelope-To: philmd@linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1717129171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cVTDss2dlOigckry4MYMDgbefn+7J2pwfFpvzj3T2Pg=;
 b=S3GvzLGNacstSnWC5KBB8DtfHHqydh3AXMP2MhjGec8jGtRTzvwDruby7EWLIb/OdZYnth
 KqdqX5l33t1zYlVeuRhOHwUBBYdZOBSAUzCVedG2gRGIpncnDJl8JtPV/S6utZtaawcTdB
 SeGnc/Oa+1b4lY1Uzz8LiPsk+OD6zM0=
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
In-Reply-To: <4e7aa598-1a5d-47e1-aaa3-78af05947eeb@linaro.org>
Date: Fri, 31 May 2024 13:19:13 +0900
Cc: qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB05CAA2-9301-45F6-8AE3-A2E27A160CDF@linux.dev>
References: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
 <4e7aa598-1a5d-47e1-aaa3-78af05947eeb@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.185;
 envelope-from=itaru.kitayama@linux.dev; helo=out-185.mta1.migadu.com
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



> On May 30, 2024, at 22:30, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Cc'ing more developers
>=20
> On 30/5/24 06:30, Itaru Kitayama wrote:
>> Hi,
>> When I see a Realm VM creation fails with:
>> Unexpected error in rme_configure_one() at =
../target/arm/kvm-rme.c:159:
>> qemu-system-aarch64: RME: failed to configure SVE: Invalid argument
>> test.sh: line 8:  2502 Aborted                 qemu-system-aarch64 -M =
'virt,acpi=3Doff,gic-version=3D3' -cpu host -enable-kvm -smp 2 -m 512M =
-overcommit 'mem-lock=3Don' -M 'confidential-guest-support=3Drme0' =
-object =
'rme-guest,id=3Drme0,measurement-algo=3Dsha512,num-pmu-counters=3D6,sve-ve=
ctor-length=3D256' -kernel Image -initrd rootfs.cpio -append 'earycon =
console=3DttyAMA0 rdinit=3D/sbin/init' -nographic -net none
>> do I need to suspect first the VMM, QEMU, or the Image? The kernel is =
built with LLVM, does it matter?
>> Thanks,
>> Itaru.
>=20

I=E2=80=99m testing Jean=E2=80=99s repo at:

https://git.codelinaro.org/linaro/dcap/qemu/-/tree/cca/v2?ref_type=3Dheads=


Itaru.=

