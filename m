Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB253C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 09:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEiN-0004CZ-1n; Fri, 25 Jul 2025 05:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ufEiL-00047H-3W
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:27:41 -0400
Received: from p-east1-cluster4-host5-snip4-10.eps.apple.com ([57.103.89.53]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ufEi9-0002cC-PE
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:27:35 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-2 (Postfix) with ESMTPS id
 5DF681800B17; Fri, 25 Jul 2025 09:27:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=vZzp+8SYqnoPIS5lJhgmB+JFs0JghYM9gs1dDIxZiio=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=tvMoLc1NLKgb+m5JM9RX+e7aKhZeLW8/iS3BTzc9kVrE7U2fthaYx3BBz2GUYiZJcXWo70qRJWK974Mtl0gbaIieuAaKiO3LQt9zJK2wjQBfg81vO6Gl4JO/MKcVAVXIpvnV/VHbpaC0Pl26Je0BhCiyC65lrQaUnnaA1hKDWczNwBJvkfkZ+pm63EN7h5CSaRbQkJsv1qu8rBX2mHidoQYzc287otWOybcHaWpzipN2t3WxIq3JnoZ71qLJ/Lw/8hdMOknQX6Ig2JiaH7MqClqFmqBSDYS5gE7l2wMKQHLG7QS7xh9Sq7xjWK1K7/lHbhjAEJ+opjfu8KerMnCqfA==
X-Client-IP: 212.60.126.184
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-2 (Postfix) with ESMTPSA id
 30DC81800090; Fri, 25 Jul 2025 09:27:21 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 0/9] HVF: Add support for platform vGIC and nested
 virtualisation
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250725085545.93619-1-mohamed@unpredictable.fr>
Date: Fri, 25 Jul 2025 11:27:06 +0200
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <36579635-89D1-4177-BECC-0A2DB170395E@ynddal.dk>
References: <20250725085545.93619-1-mohamed@unpredictable.fr>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-GUID: dNqIHK3YnKeYxAI0UfZeMXiDQBXIF78b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4MCBTYWx0ZWRfX1AhS+ea78lEF
 m7Esj6OM0K4roZPSc3YTbHNLWF1Q7x0ZUFGhBX7/Cih08xSCbf/byoZ7zL4Mv+F6aZFja2qwYzK
 ISR6kxZ1cr4gZ79ONzlnrIAJ1WJQsNwerdtQ6xgYwRR1jMNmKr3FIdy9MhoU07GuAZSV1y3Hf4x
 bBEZaJAgyu8LUBIFfj7gNdd/5EwKXRioCsF5aARNXNLK+A3LE9xNLqJfz4uSIvZHDEbCurxz/UP
 92vdvqemqqIIJmfgbrP/KPTdRE1y+wHYcT9etcKi8ZZ/WEgwcWDPSPzKh+UyB1r1AYhprInzg=
X-Proofpoint-ORIG-GUID: dNqIHK3YnKeYxAI0UfZeMXiDQBXIF78b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 clxscore=1030 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507250080
Received-SPF: pass client-ip=57.103.89.53; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


> On 25 Jul 2025, at 10.55, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> Early series.
>=20
> Known issues:
> - when nested virt is enabled, no UI response within EDK2
> and a permanent wait. Workaround: -boot menu=3Don,splash-time=3D0
> - Save/restore of GIC state isn't complete yet.
> - Save/restore of HVF state when EL2 is enabled isn't complete yet.
> - This series doesn't contain EL2 physical timer emulation, which is
> needed if not leveraging the Apple vGIC.
>=20
> However, this is usable and there seems to be some interest for it. =
Hopefully
> it'll be at least somewhat useful.
>=20
> PS: I can step up to maintain HVF support if needed. WHPX arm64 patch =
series
> is coming soon too.
>=20
> v1->v2:
> Oops. I did a mistake when preparing my patches.
>=20
> - Add hvf_arm_el2_enable(_) call to virt_set_virt
> - Fix nested virt support check to add HVF
>=20
> Mohamed Mediouni (9):
>  target/arm: hvf: stubbing writes to LORC_EL1
>  accel, hw/arm, include/system/hvf: plumbing changes for HVF vGIC
>  target/arm: hvf: instantiate GIC early
>  target/arm: add asserts for code paths not leveraged when using the
>    vGIC
>  hw/intc: Add hvf vGIC interrupt controller support
>  hw/arm, target/arm: nested virtualisation on HVF
>  target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
>  hw/arm: virt: add GICv2m for the case when ITS is not available
>  target/arm: hvf: use LOG_UNIMP for CNTP_CVAL_EL0/SYSREG_CNTP_CTL_EL0
>=20
> accel/hvf/hvf-all.c        |  44 +++
> accel/stubs/hvf-stub.c     |   1 +
> hw/arm/virt-acpi-build.c   |   4 +-
> hw/arm/virt.c              |  34 +-
> hw/intc/arm_gicv3_common.c |   3 +
> hw/intc/arm_gicv3_hvf.c    | 624 +++++++++++++++++++++++++++++++++++++
> hw/intc/meson.build        |   1 +
> include/hw/arm/virt.h      |   2 +
> include/system/hvf.h       |   3 +
> system/vl.c                |   2 +
> target/arm/hvf-stub.c      |  15 +
> target/arm/hvf/hvf.c       |  91 ++++++
> target/arm/hvf_arm.h       |   3 +
> 13 files changed, 817 insertions(+), 10 deletions(-)
> create mode 100644 hw/intc/arm_gicv3_hvf.c
>=20
> --=20
> 2.39.5 (Apple Git-154)
>=20

Great patch set to see! I was working on the same functionality before
going on vacation. If you give me a bit of time, then I'll make sure to
review it.=

