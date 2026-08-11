Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D22C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrVF-0004v2-KV; Tue, 11 Aug 2026 14:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtrVA-0004oM-Ju; Tue, 11 Aug 2026 14:47:05 -0400
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtrV9-0005Vz-75; Tue, 11 Aug 2026 14:47:04 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0301014000E4;
 Tue, 11 Aug 2026 14:47:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 11 Aug 2026 14:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786474022; x=1786560422; bh=zyYQEt5tpf04nzEd9voAg9GlAzbCxWvS
 nfi9RHOXikk=; b=lA/r5JyNHl7oeekrzYWAX5MgJRH/ZYhF7n8qFEPGV6yi2I0t
 LLX0U1uQ+1nPU8zfzXEljFqz6evEPQq3wu0Tdi2bvuQU8CvKsyM3mpSrwEuL6OS3
 DRJpeYIcIpiTMmKUlXG117hP/O5rP/7vff4/131UjWYZOPzHFDScLtaQxnZtUBkP
 BYR8QxPDBAsN4IIhVWKQz9wD4/f6EIAOLJVFN9xBet1LlR/phk+1r/++ngwPTNRw
 6QcfCvqhirtlJZ+kQRb6vwvJIvylh/EHS5VBGT8Q0jQHpuc/YJeiFXLs037In6Pd
 wg8DGu4iTJhu31KeK8MqOnZ3qUwjwtKy+TZsdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786474022; x=
 1786560422; bh=zyYQEt5tpf04nzEd9voAg9GlAzbCxWvSnfi9RHOXikk=; b=M
 NXKPmtSb8SXY35d28+7twGqefmVuurmvpEvoRbFUnKStv2civTePTc3Q6B0R3wo0
 SkuFK2inIDNGn2HlBtkSuHTK0KIpUbJVp8hEBWFt+wL9bJk1A3fN8dgGU0mv+5XD
 +YQ8IBBK064A1zF74XvRYU0Y7Paj2v7EmQ+t3TQZTEWz8pGDO1rY4cuKFvKMA+Rn
 +XFHQ5eugAMks8491FV9N3rkBoN0EI2QHbMWlXBXxphgi7ra/6f86Ruf2ROBowJJ
 8nMB7oSED91HYgg/7p+yvFeeBRZb61JuMmBdW3TZREJUW/cj/4lLnIqAYUlBI+C1
 NvMUE4RQWI2S2mEbLU6UQ==
X-ME-Sender: <xms:JW57alcOtZJAyAqRn97hVCi-8LYuM-O_VKFAZoZLFXLgEv4CKW1ypg>
 <xme:JW57arZVn47GWl3g12YakJRG1HM2IwX_s7PZ_QdOL6cadCh9n2lSUksD1oPNRGnRZ
 d-13sz_kotEuDxtdR1pR0mUEIid9O9eRLycuOvDmnu3it5Og_3Rvw>
X-ME-Received: <xmr:JW57aqHEG0L_y7FVPSPaJKc8mDc1j7TIJy_Dike-TxS2kodvI7upUPGZwMIDPtsLjkMXHQ>
X-ME-Proxy-Cause: dmFkZTFiKM2t7ZNIi9lv0kXig/tXHX68iKpfrt4Gi3AYBLxyNPUg4pE8sLyyLUKSlfxPCI
 pWUTx8p2Tw6K1+rsOgwxlND1imirOFgqV/I4/sXHq3RK2S7gFpLuFgrB4JgfCHXTYce0XG
 N4JH1a6WDQOnOvDYbAKOflcniVSSb3y3izfev5jLrr1HvVBPKsMFjC0ZKBbfpEJvKeWLmL
 hCzG54p7RICYLJNwS5fyYcDHigjMofzJibm5Bd/WX/mPgLi/Iyv0q1Gzm+kobVC4VUznk/
 7c4ePskJLQ2XN+NBOqhmoDlq6TPtS17HievTSJsZBqmr80+Rnyk8H75SrLVz5RAX/1ErGd
 RSBCRLBUKc6L4u25PR4raE1wvXSR5p2C58pNytcrjhfjg5BviIwMdOz1+WT6A+MeCBeSKJ
 gv3v9DV15KNxMaaMWP5bIKH1ngRyKDtkvYJOVbrpEurfRs7dj5OqftYazW3DAY0oIx/vyx
 OGHvUMpE5abugbdYT7QjIoYH7V0PisDWfllrY2Aw9M9MIKQh/H3jDFDa/Uw4Qbmgvet5Ap
 3EouBTWOUIbAgpZr9TsNd4kRtmPSj6wMQI5D2HBKgIpzir1xqg60cTa12vvBIq7el4exyO
 +Ehihq/44RBbkvl9jp7Iz/RbMywj5KSazwOMWo95sea94TPBfe7YHbajT41A
X-ME-Proxy: <xmx:JW57apnkX13x0IXPMt94R7JQO40Dt85jE6ge9JGDp02-PV-b6aQgtw>
 <xmx:JW57atcOkEunb0YVrQWp9JBozHO2m-yi6H0RJCar-0YMNu6puGCWzw>
 <xmx:JW57anFOxLDvTO3BkkPKo7xnFTNQLnQQI_QNOXWxIPk9ujiwL_O7xQ>
 <xmx:JW57ajgHBsCx129mQBVnRD_fxPwqpIqsm0ngNcFUNata1LAxpuBSyg>
 <xmx:JW57ansfn-S55iArs_NDjmG0fEoFy-g5k6k6l__DFMIebHWxGpWkMqbM>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 14:47:00 -0400 (EDT)
Message-ID: <17c24ef9c8cf17091ac6eb46adc8090fdd18747f.camel@alistair23.me>
Subject: Re: [PATCH v11 0/2] target/riscv: Fix riscv64 KVM migration
From: Alistair <alistair@alistair23.me>
To: Xie Bo <xb@ultrarisc.com>, qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com, qemu-riscv@nongnu.org, alistair23@gmail.com, 
 pbonzini@redhat.com, anup@brainfault.org, alistair.francis@wdc.com, 
 rkrcmar@ventanamicro.com, palmer@dabbelt.com,
 daniel.barboza@oss.qualcomm.com
Date: Wed, 12 Aug 2026 04:47:00 +1000
In-Reply-To: <20260808125157.1220511-1-xb@ultrarisc.com>
References: <20260730051926.7322-1-xb@ultrarisc.com>
 <20260808125157.1220511-1-xb@ultrarisc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.156;
 envelope-from=alistair@alistair23.me; helo=fhigh-a5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 2026-08-08 at 20:51 +0800, Xie Bo wrote:
> This series revives v9, which was applied to riscv-to-apply.next but
> did
> not reach QEMU master.
>=20
> RISC-V KVM migration currently loses two pieces of vCPU state: the
> privilege mode core register and KVM MP state. The latter leaves
> secondary
> vCPUs in their reset STOPPED state on the destination.
>=20
> Synchronize the privilege mode through the existing generic CPU
> VMState,
> and carry MP state in a capability-gated KVM-only subsection. The
> subsection
> keeps KVM state out of TCG migration streams. Bump the generic RISC-V
> CPU
> VMState version and minimum version to 12 as required by the new
> pre_load
> hook and subsection.
>=20
> Changes from v10:
> - Bump the RISC-V CPU VMState version_id and minimum_version_id to
> 12.
> - Add Daniel's Reviewed-by tags.
>=20
> Testing on a native riscv64 host with Linux 6.6.20 and GCC 13.3.0:
> - KVM build: riscv64-softmmu, --enable-kvm.
> - Non-KVM build: riscv64-softmmu, --disable-kvm.
> - Four-vCPU KVM migration on unmodified master: all vCPUs failed to
> run
> =C2=A0 after migration and the guest reported RCU stalls.
> - The same migration with this series: CPU0 through CPU3 all ran
> after
> =C2=A0 migration.
> - Four user-mode busy workers, one pinned to each vCPU, all made
> forward
> =C2=A0 progress across migration to exercise privilege-mode restoration.

Thanks!

Applied to riscv-to-apply.next

Alistair

>=20
> Xie Bo (2):
> =C2=A0 target/riscv/kvm: Synchronize privilege mode
> =C2=A0 target/riscv/kvm: Preserve MP state across migration
>=20
> =C2=A0target/riscv/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 4 +++
> =C2=A0target/riscv/kvm/kvm-cpu.c=C2=A0=C2=A0 | 62 +++++++++++++++++++++++=
+++--------
> --
> =C2=A0target/riscv/kvm/kvm_riscv.h |=C2=A0 2 +-
> =C2=A0target/riscv/machine.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 49 +++=
+++++++++++++++++++++++--
> =C2=A04 files changed, 98 insertions(+), 19 deletions(-)

