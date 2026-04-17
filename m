Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A35F43695
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDhn3-00028i-2e; Fri, 17 Apr 2026 07:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wDhn0-00027X-6j
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:55:15 -0400
Received: from p-east2-cluster5-host11-snip4-4.eps.apple.com ([57.103.79.67]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wDhmy-00027v-5t
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:55:13 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 D0988180015B; Fri, 17 Apr 2026 11:55:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776426908; x=1779018908;
 bh=nXqnTXy+699GTVHqkhAMQn3H9jefinE2ZXkW9yCUYZc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=WL+1oB3Wth99iv4Cuntx7z3uffNZER1TqHkbvgo0aIx4VPoiYRdzRZlXPqikFx4QQfHNA6uIec5HjQ1bGyP4oEUcqQK3EtAZ3KbMrofZgKtPbtfwRkB8FCZJxAambrnu++fJ9HsWd1rqKr4p8CxJ154U6igwrN80e3B/TXyfw0f2V7EBqtGBOyWCNuSDszbtRFQj5XCCc746whyqSkIKT4ueQPudb2if2esTAolJG6y1vgXKsZg+/1ym4kj1rLCfHU4VwBKFr45sdlgfbP3olr6yNUNoUCQr/dXb2SqWrzmE4pq2x/vtFkW/vRWmh+7Qb66BJZ+uEwDtCcW3vpYv6A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 D1B16180060E; Fri, 17 Apr 2026 11:55:00 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 16/34] target/i386/mshv: migrate LAPIC state
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
Date: Fri, 17 Apr 2026 13:54:48 +0200
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <liuwe@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E651C54B-3AE5-45B6-A275-26C415EA0582@unpredictable.fr>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDExOSBTYWx0ZWRfX4HkXDuQJlgoH
 5KaA38QdO+yP0GeJVkjkE22PQnCtMhWGUytg9NAL5FItcuu4xkA2c9qCRU8wUnjqpAGu+4kh9HT
 ISJzOz8Mfmo0CAWiOyaSNhjmWLLDYXpMGhjZuWDknnAWSspv8GteO54VgF2bNJjW8pvoRDdFfOm
 ikNH7i2e9fEn8yGpRUhBaK+zCa2Rf1i2vA6ZiAOQNHPYSPhB6c+T9zy0n/nQn6qsK2fgpQBpNGL
 7j6H5GbLxyTfie2W2+IbprEIFYt/gScsC6u1mtrShUYrTIWndpHMyscvIuttuQ+W/BRaSh0/cyA
 u9txctmi1mQI6SNQGTvY/Q37lMuID65Yn/fZVf4JllIIe4Vu7CGhO3/wpz11G4=
X-Proofpoint-ORIG-GUID: k0V9sTe-vipaBHgdrdyeAM49YqEk1ogZ
X-Proofpoint-GUID: k0V9sTe-vipaBHgdrdyeAM49YqEk1ogZ
X-Authority-Info-Out: v=2.4 cv=e+8LiKp/ c=1 sm=1 tr=0 ts=69e21f9a
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=a1E2onep4z3RYCm5l0cA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=765 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 clxscore=1030 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604170119
Received-SPF: pass client-ip=57.103.79.67;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 17. Apr 2026, at 12:56, Magnus Kulke =
<magnuskulke@linux.microsoft.com> wrote:
>=20
> This change implements loading and storing the hyperv lapic state as
> part of the load/store routines for a vcpu.
>=20
> The HyperV LAPIC is similar to the the split-irqchip in KVM, it will
> only handle MSI/X interrupts. PIC and IOAPIC have to be handled in
> userland.
>=20
> An opaque blob is added to the APICCommonState, guarded behind a flag,
> hence it will be covered by a migration, as we declare VMSTATE_BUFFER
> for the hv_lapic_state field.
>=20
> In the future we might want to introduce a dedicated class for MSHV, =
that
> would require us to wire up an IOAPIC delivery path to QEMU's userland
> emulation.
>=20
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Hi,

Is there a way to make this not opaque in a way that retains the ability =
to
Save-restore between KVM and MSHV?=20

Or is that not a wanted goal?



