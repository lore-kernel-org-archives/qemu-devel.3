Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFCBEA855F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 05:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzTXW-0004uH-TM; Mon, 09 Mar 2026 01:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vzTXS-0004tv-Bf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 01:52:22 -0400
Received: from ci-2001l-snip4-11.eps.apple.com ([57.103.91.123]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vzTXQ-0004E3-6J
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 01:52:22 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPS id
 DAEA01800096; Mon,  9 Mar 2026 05:52:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773035538; x=1775627538;
 bh=BNeFINH2oW7uB8b1I9kowtJb1VDxcQHagB0x4EkE8R4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=JjGhwidrzQGhiH7nt/ThE8rx8h7eV9tAYFBUKQoRM4hwOuSGvkUu0pH2iLKG5jN+xygfIaw9beRPziePJs2x25VhlwP0Psdc59USB+lX7/yHM1DumTF/xh9/5MJWANCGIn80LYJ9d9m/0PZQDKwvbMGYaiKoP/UTglaezEUVu/mB/AsNIg+1t91lFqiPKJ4yDpQFF/4pjVf68Td1Sup+iQe8Omb/3ZRSyFEnUKC0Rs1yAVTcAqo6vGrSTOE1PYuZMJ4JXjOtCx5ujL9BKSaJvh49QsSGhr3HomABSQyvGwc/MkbDf0MJ+in0LTjcjVLLytE7OdgVqyiqhvUk8MYYiw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPSA id
 6B25F180010E; Mon,  9 Mar 2026 05:52:15 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [RFC PATCH v2 0/1] target/i386/kvm: Configure proper KVM SEOIB
 behavior
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260309054243.440453-1-khushit.shah@nutanix.com>
Date: Mon, 9 Mar 2026 06:52:03 +0100
Cc: qemu-devel@nongnu.org, shaju.abraham@nutanix.com, jon@nutanix.com,
 mark.caveayland@nutanix.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1710ABF4-BC78-4BD7-8CC5-B2F24F3D051C@unpredictable.fr>
References: <20260309054243.440453-1-khushit.shah@nutanix.com>
To: Khushit Shah <khushit.shah@nutanix.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-ORIG-GUID: mfiEEd9xTDoAiruT37bL3nxo461AOhkj
X-Authority-Info-Out: v=2.4 cv=BLG+bVQG c=1 sm=1 tr=0 ts=69ae6011
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=xRNX9gBGRmSKftgA4nsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mfiEEd9xTDoAiruT37bL3nxo461AOhkj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA1MiBTYWx0ZWRfX+G/tuDkQ8nGD
 njmjvFlW2bDfCaKZBn+uvUV/o60BWfe2yRjagPfX6EZV3BYadsVwTJkIX3KQ9sAQdFO/LuN1Pr8
 MTpPi1oO5urM8xsFsFj+D6q85HOJduEjBpeRFssVTUly+A/eSTlQb0Wxe93V3TkOg6dDEyKaTwx
 vHAP4NdjKhdR4I2DXL0lkILyXYNuz7Q8zbl7dcjEyod5j8E9GPe22TdSyeLIwRfEHy1iz6/jPBh
 UHy3kdisJa+6H2c4hoGcebRNrDT3yb542HMvgqjROU090Wmzhb+N4KFbHHhBi+aNpocQQqkCEar
 sKB43tRwyyxKZd2xCzXxZm9K+HZeZmbeM3LM64rnuczVd9fE4jDhSYIbWCiq2s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1030 spamscore=0
 adultscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603090052
X-JNJ: AAAAAAAByM92vcboCFFyVrs8wnF7BPoGGoW8N0lRjK9eSf4+3kufCjWpmLFok57F7FnPnxSerIhkTq4SSe9Sda3B05bwmjoIfEa5gzHN2gmnMEWw5NAaeW9loQD0ai/xMqhkkt52YQK+ncgaP2pJyFNhJNh+jlR4yFv62srpNLIIlsUOKt6EzMJIz1H41qfpyweIASmx5C7yzzGPYJ5LC6w4YH8/EW+y2xkgMRMMl7BrIvgLGgMahVEKblJK9IeXDHB6jQRrnQ/sEPGUSKLf1ptkkjyGSYvsWFJKzTBArp+6/FDzCH8aC3DoLVKlxevgkI0HruvMY8FB7zDwMdt8sqosWD9J1EKm7pis1OL+GYJzO6DH0wf0bbTFTYiljbbe4bZTsQslIu8XyFMMuWEqBw888o5K6Zs8szQq0c6UIp1qcwCkuaGR107qw/IyXzTNvC/L79wYBr+tz15QxT3l1Hp4U4R7Px3fa6UnEyEpxjhJwtU87bBgrNoDRZV/10KDYBGfA386rPKfD46j9Qs4kySQoj6pYkP0O2Fup46j+fCNEt+8yE0dEDl4RF7SXSCx3NKh1UolEd5m1LT7rh5O5dzI5C1N1ekv6YTHfuYi4Svpyt+Juji7N5kuEwim7Xqzary6pse8EfIBIuLXM/86BUV0ucI7prZvmvw7x1OvdCyf
Received-SPF: pass client-ip=57.103.91.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 9. Mar 2026, at 06:42, Khushit Shah <khushit.shah@nutanix.com> =
wrote:
>=20
> This is an RFC posted for design feedback rather than merge.
>=20
> Problem
> -------
>=20
> In split-irqchip mode, KVM unconditionally advertises x2APIC Suppress =
EOI
> Broadcast (SEOIB) support to the guest. This is wrong in two ways:
>=20
>  - IOAPIC v0x11 has no EOI register, so advertising SEOIB is =
incorrect.
>  - Even with IOAPIC v0x20, KVM ignores the guest's suppression request
>    and continues to broadcast LAPIC EOIs to the userspace IOAPIC.
>=20
> This can cause interrupt storms in guests that rely on Directed EOI
> semantics (e.g. Windows with Credential Guard, which hangs during =
boot).
>=20
> KVM fix
> -------
>=20
> KVM now exposes two new x2APIC API flags to give userspace control:
>=20
>  - KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST
>  - KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST
>=20
> This patch
> ----------
>=20
> This patch wires those flags into QEMU via a machine-level field
> (kvm_lapic_seoib_state) with three policy states:
>=20
>  - SEOIB_STATE_QUIRKED (default): legacy behavior, no flags set
>  - SEOIB_STATE_RESPECTED: advertise SEOIB and honor guest suppression
>  - SEOIB_STATE_NOT_ADVERTISED: hide SEOIB from guest (for IOAPIC =
v0x11)
>=20
> The current implementation automatically selects a policy based on =
IOAPIC
> version at VM power-on time, and migrates the state as a VMState =
subsection.
>=20
> Design challenges
> -----------------
>=20
> The KVM x2APIC API is one-way: once a flag is set, it cannot be =
reverted
> back to the quirked state (consistent with other x2APIC API flags). =
This
> has several implications:
>=20
>  - During incoming migration, we must defer setting the flags until =
after
>    the SEOIB state is loaded from the migration stream, since we =
cannot
>    know the source VM's policy in advance.
>=20
>  - Snapshot restore (loadvm) is problematic: if the running VM has =
already
>    set enabled/disabled, restoring a QUIRKED snapshot cannot revert =
the
>    KVM state. QMP/HMP loadvm makes this worse since it cannot be =
detected
>    at init time.
>=20
>  - The flags only take effect when kvm_apic_set_version() is called =
inside
>    KVM, which happens from limited paths such as IOAPIC initialization =
or
>    APIC state setting. This requires setting the flags before IOAPIC =
is
>    initialized, necessitating fetching the IOAPIC version from global
>    properties rather than from the initialized device.
>=20
>  - Automatic policy selection (current approach) changes behavior for
>    existing machine types without user opt-in, breaking migratability
>    from a new QEMU to an older QEMU for the same machine type.
>=20
>  - Machine-type gating (restrict to 10.2+) helps with older machine =
types,
>    but still breaks migration to a destination with an older kernel =
that
>    lacks the SEOIB API, again without user opt-in.
>=20
> Preferred direction
> -------------------
>=20
> Given the above, I am leaning toward a KVM accelerator property (for
> example, `seoib-policy=3Drespected|not-advertised|quirked`) with the =
default
> being quirked.
>=20
> This approach:
>=20
>  - The user explicitly opts in. But requires user to =
understand/configure
>    the property.
>  - Works with any machine type, no machine-type gating needed.
>  - No need to fetch the IOAPIC version from globals.
>=20
>=20
Hello,

I don=E2=80=99t think that makes much sense. Tying it to a machine model =
version
sounds like it is a much better approach.

And it=E2=80=99d allow to have a saner way to deal with migration too - =
as you=E2=80=99d
never have the quirked state for the new machine model version.

Thank you,
-Mohamed
> Note: The current implementation also does not handle the QMP/HMP
> loadvm corner cases.=20
>=20
> I would appreciate feedback on the preferred approach.
>=20
> Changes in v2:
> 	- Update flags in patch description to match kernel naming.
>=20
> Khushit Shah (1):
>  target/i386/kvm: Configure proper KVM SEOIB behavior
>=20
> hw/i386/x86-common.c         | 99 ++++++++++++++++++++++++++++++++++++
> hw/i386/x86.c                |  1 +
> hw/intc/ioapic.c             |  2 -
> include/hw/i386/x86.h        | 12 +++++
> include/hw/intc/ioapic.h     |  2 +
> include/system/system.h      |  1 +
> system/vl.c                  |  5 ++
> target/i386/kvm/kvm.c        | 43 ++++++++++++++++
> target/i386/kvm/kvm_i386.h   | 12 +++++
> target/i386/kvm/trace-events |  4 ++
> 10 files changed, 179 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.39.3
>=20
>=20


