Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F0EE63C82
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 07:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjuTA-0001OS-Li; Sun, 25 Jan 2026 02:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vjuT6-0001La-Bc
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 02:23:32 -0500
Received: from p-west3-cluster3-host11-snip4-4.eps.apple.com ([57.103.72.215]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vjuT3-0007rw-Tg
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 02:23:32 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-2 (Postfix) with ESMTPS id
 283D718002B9; Sun, 25 Jan 2026 07:23:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769325806; x=1771917806;
 bh=pbUN0bad51piuPdxJck2CgS41UaOD7HfrrQPg5RO+tk=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=d1trKkMCr/+lsqMveHXMrPMANLTeuHsTl1z3oGwfkMcYCo+8kwFzy3ZYomKagD9h9S73OlBOcM+HoiyeIm4qlA37AXIx3P2njP6LA+OCSl/L/ms+3eEY+6N4xUXVXGTFi+nm1plfoEzrY/Ba0QxFHxNWTxhcK0/igiDs5gOxZTpSgpRA0yf2wRW+IqXWMI7akmAD21NZPalQe5Vik/uT1eIbe7NgYknqAPUz04BE/t0YLugw6u9miSx8Q6t/FhwunfAqY/R9L9CeQmM8Xr7x9/FVFQp9Jhs+qA6ZcLeYrP7IuzeSCxIqsu6Hely3C/dHlxmqt4TywSP1QhaNL4O+iw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-2 (Postfix) with ESMTPSA id
 4151C18000B9; Sun, 25 Jan 2026 07:23:21 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v4 0/3] hw/arm/virt: Remove the lower bound of HighMem IO
 Regions
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260125-virt-v4-0-00d726b27224@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 25 Jan 2026 08:23:08 +0100
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <11A957F3-794E-40DD-8E39-4DB8589B1657@unpredictable.fr>
References: <20260125-virt-v4-0-00d726b27224@rsg.ci.i.u-tokyo.ac.jp>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-GUID: r3BOI3mxxgdM9a7OWRpRd9RVyxMHRxZU
X-Authority-Info-Out: v=2.4 cv=R64O2NRX c=1 sm=1 tr=0 ts=6975c4ed
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=AXKS_Qr3ttDk3pQ_6E8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI1MDA2MCBTYWx0ZWRfX7g8OJy9KnMa6
 aaVtfWUGSmrN7j/fkQbpRfInKTqH5JSu/m/LDoqqU/D13+9pcwsMyFJIcqqdGYjh0LtrpFKTGdY
 X/BGv8BILh5XaPgQmXXkDhHMZEch7WCbX2Vj4TwZYNPyek3H1aXiP2pV0jA8QEVXeyyS99OA5Y6
 l5Av8qboTcf8dLawWeo/29KsRraOs52s+j+Ry2UR8MUGfjywe4G7+kfQNbKiDEayU286q+EKfjj
 i1qRNeCuPifhzl4ObCUVKUlw5kWX3O4WhGko1KwFXAkViSqQK/rqLimkFbu95CzGtJIqytFp+xd
 FNJ21wibXkKWjhNA2e6
X-Proofpoint-ORIG-GUID: r3BOI3mxxgdM9a7OWRpRd9RVyxMHRxZU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-25_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0 clxscore=1030
 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601250060
X-JNJ: AAAAAAAB7r2jhAXotCX1opdVSeoWNr3UqI7a80v3au3FYb9WAno6+O1Xj65NF/h3xtuzNGVgPHz5PjvWcgcJwbwMM4AtUrf3YN2XAo387LUgTyQLdk+93/wg9WUqaeiYTjO1g6yZQUxuyTkl18L9uz1yhkuTt320RU2IkiK8BH8OMPWqio3dWYlLTsPpRNozggUDo8b63x5w6nVpMLtAx7th0K3D2AH6gjIHJixqtoib0MWWY4Hcko7SAtEnR8xhSrYOq4VYghQ01SQDwkbIJi/HOfXIb0Dcq/k9hOomfEZQ9t8IYk8jLr0K2L3jr3lazOkaxdtjtpAJg8uVRrhTCeOwTMhah7KbtQPO3AzFpteDfxALlrDdPHFDJ+y0zFo+fP4kxLdwR/W2skpjNghJmnqjvcEpJgI+/2fcyngbJYPExhzHC0gIkhFEVquF/ZfcGPOlkeZeME0h+mtrrmnZGN+w6VqX+TqsDImfhzeu+YxnmnOrg/eCajTBlbPIch1EzQwETLqT2ChSAYkloGRkCdvKFWFcGncLF3J+aFnWjr/0SwyT/lIOt2lc4hArKPFr67HTh8z9/824Ji5lnZjJxT7gjTDVmbIuScZ4w9TWVYNAhoPKPWDua+wa+4JAeX8NYTjpnlskXuuK4tWP4OFyiAWTERMQjZqjqcniGBWar5A9VgiEFfAMzPR5ACIy3FzqE0nz51p+TtpjGd/jSHepeKTEzmPFCBM43TBC171R97hZy9WGVKWZnryc2ern6pHY9JgC
Received-SPF: pass client-ip=57.103.72.215;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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



> On 25. Jan 2026, at 06:46, Akihiko Odaki =
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>=20
> Remove the lower bound of the Highmem IO Regions' addresses for the
> latest machine version to increase the chance to fit the regions in =
the
> PA space.
>=20
> The lower bound was especially problematic when using virt-install on
> Apple M2. virt-install 5.0.0 adds multiple pcie-root-port devices that
> require sufficient space in the ECAM region. However, the Highmem ECAM
> region did not fit in the limited PA space on the hardware, and the =
ECAM
> region size was limited to 16 MiB. If virt-install had added more than
> 16 devices to the root bridge, the region overflowed, which prevented
> edk2-stable202505 from scanning PCI devices, including the boot disk,
> causing boot failures.
>=20
> Ideally, a virtual machine with more than 16 devices added to the root
> bridge should just work so that users and management layers do not =
have
> to care whether they use constrained hardware.
>=20
> The base address of the Highmem IO Regions was fixed when commit
> f90747c4e8fb ("hw/arm/virt: GICv3 DT node with one or two =
redistributor
> regions") added the first Highmem IO Region. Later, commit =
957e32cffa57
> ("hw/arm/virt: Dynamic memory map depending on RAM requirements")
> allowed moving the Highmem IO Regions to higher addresses to =
accommodate
> RAM more than 255 GiB, but the lower bound remained to keep the legacy
> memory map.
>=20
> Remove the lower bound for the latest machine version to accommodate
> more devices with the root bridge. Keeping the lower bound for the old
> machine versions ensures the compatibility is still maintained.
>=20
> The hardcoded memory map in tests/qtest/libqos/generic-pcihost.c is =
also
> updated.
>=20
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Changes in v4:
> - Rebased.
> - Edited the patch message to avoid confusing git am.
> - Link to v3: =
https://lore.kernel.org/qemu-devel/20251027-virt-v3-0-fa2a2f37e32d@rsg.ci.=
i.u-tokyo.ac.jp
>=20
> Changes in v3:
> - Fixed test failures reported by Peter Maydell.
> - Link to v2: =
https://lore.kernel.org/qemu-devel/20250901-virt-v2-1-ac2379402c80@rsg.ci.=
i.u-tokyo.ac.jp
>=20
> Changes in v2:
> - Rebased.
> - Link to v1: =
https://lore.kernel.org/qemu-devel/20250728-virt-v1-1-0ab9682262c8@rsg.ci.=
i.u-tokyo.ac.jp
>=20
> ---
> Akihiko Odaki (3):
>      test/acpi: aarch64/virt: Allow DSDT and MCFG changes
>      hw/arm/virt: Remove the lower bound of HighMem IO Regions
>      test/acpi: aarch64/virt: Update golden masters for DSDT and MCFG
Hi,

Would it be a good idea to have a new test configuration that keeps the =
old memory map? To make sure that older machine versions don=E2=80=99t =
regress

Thank you,
-Mohamed
>=20
> include/hw/arm/virt.h                            |   1 +
> hw/arm/virt.c                                    |  16 =
++++++++++++----
> tests/qtest/libqos/generic-pcihost.c             |   2 +-
> tests/data/acpi/aarch64/virt/DSDT                | Bin 5337 -> 5333 =
bytes
> tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt   | Bin 5423 -> 5419 =
bytes
> tests/data/acpi/aarch64/virt/DSDT.acpipcihp      | Bin 6246 -> 6242 =
bytes
> tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex | Bin 5391 -> 5387 =
bytes
> tests/data/acpi/aarch64/virt/DSDT.memhp          | Bin 6698 -> 6698 =
bytes
> tests/data/acpi/aarch64/virt/DSDT.pxb            | Bin 7812 -> 7808 =
bytes
> tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev     | Bin 10274 -> 10270 =
bytes
> tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy  | Bin 10274 -> 10270 =
bytes
> tests/data/acpi/aarch64/virt/DSDT.topology       | Bin 5539 -> 5535 =
bytes
> tests/data/acpi/aarch64/virt/DSDT.viot           | Bin 5354 -> 5350 =
bytes
> tests/data/acpi/aarch64/virt/MCFG                | Bin 60 -> 60 bytes
> tests/data/acpi/aarch64/virt/MCFG.memhp          | Bin 0 -> 60 bytes
> 15 files changed, 14 insertions(+), 5 deletions(-)
> ---
> base-commit: d03c3e522eb0696dcfc9c2cf643431eaaf51ca0f
> change-id: 20250728-virt-833dafa6c11b
>=20
> Best regards,
> -- =20
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>=20
>=20


