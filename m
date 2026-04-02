Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31655D6AAF0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 16:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8KvO-0003Sj-S0; Thu, 02 Apr 2026 12:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8KvN-0003SE-Ne
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 12:29:41 -0400
Received: from p-east2-cluster2-host10-snip4-10.eps.apple.com ([57.103.78.83]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8KvL-0007G9-LD
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 12:29:41 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-3 (Postfix) with ESMTPS id
 B0E741800692; Thu, 02 Apr 2026 16:29:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775147377; x=1777739377;
 bh=O/Dofj7+TkM8iI43wo2UtVTTxw/tMXz4UJ/3PMH3qog=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=f/HE8ggupe6RQbCBc+ge8X2R1esQblzm+l+biOijXLIQklHVjce+spzWb5Fie94GxUZPWHUhcC3ftNBR7IjIVCS4Iyq7C3poG7EFfneOow1/yyWz0NKDRiT6eauhBVvwfgZv5hv0WbUluAEUn8cDd7KZ0xuP4WxL4NMvmYc0lj2V+YhbSouFt2u9IlbhJW2l5Bzp1zebW4wI695WvCag11vx1+Wcy7j+0wKbfohMFEWsUexdzD8kDvFMmTSyDu0H/BNRv7OjIQzhwvytdSSHgQfhRQJNEm5yofCenEgORIklkRDX0OTwLPxCaJpCHkz1eHD/uV1KQFwp7m0bBdZbsA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-3 (Postfix) with ESMTPSA id
 65B9A18000B0; Thu, 02 Apr 2026 16:29:34 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2 06/14] accel/mshv: add arch-specific accelerator init
 hook
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260402-mshv_accel_arm64_supp-v2-6-754895c15e9e@linux.microsoft.com>
Date: Thu, 2 Apr 2026 18:29:22 +0200
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1FF5E7B0-E916-47CC-865B-F6A87342B109@unpredictable.fr>
References: <20260402-mshv_accel_arm64_supp-v2-0-754895c15e9e@linux.microsoft.com>
 <20260402-mshv_accel_arm64_supp-v2-6-754895c15e9e@linux.microsoft.com>
To: Aastha Rawat <aastharawat@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-ORIG-GUID: fbuWjbXXDJEQavEW1mQFSZrT7XHKRlfX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE0OCBTYWx0ZWRfXyWMD219iVY21
 yDGB4LW7jQGfhX/pp2wqLPzpB3RfNoRCoNFUalxo+6vcykUsBSexfNvtf/JIP+8vSdqA6DclQAH
 YN+2D6fiZYPa42yR4btVmiKH93MGv4wjSEA0YM5SisVG59BSF7J15Ecv/JXNtt5dp8GheGUoMQm
 GGjzVE2tIpRtbT6PqKFtHlYRZaY3nySrfAejXYDnGxYXpZ9+fZCYbPyET1+CUk7+xjeGfqlydyo
 PnT7QYE24SR/xwPYBzhg/4qfzhrPeL85aXqMMsFSvvVAYKOVCDKw4MdWMqbH6/VCSHrNGfzEcfZ
 v6ULxETPQyH6/6I1Qm+nc4uDyxqsS12TeKJLYzQaqHnF0qOoJ9g5PuvFa+cIDI=
X-Proofpoint-GUID: fbuWjbXXDJEQavEW1mQFSZrT7XHKRlfX
X-Authority-Info-Out: v=2.4 cv=KuBAGGWN c=1 sm=1 tr=0 ts=69ce9971
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=tFGNSmrwAAAA:8
 a=DTTB39wiqv9MXZW_aZsA:9 a=CjuIK1q_8ugA:10 a=LpD6Tdepsyerr7eS-Jg7:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1030 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=924
 suspectscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020148
Received-SPF: pass client-ip=57.103.78.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 2. Apr 2026, at 14:52, Aastha Rawat =
<aastharawat@linux.microsoft.com> wrote:
>=20
> From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
>=20
> Introduce mshv_arch_accel_init() as an arch-specific hook called early
> in mshv_init(), before VM creation. This allows each architecture to
> perform platform-specific initialization at accelerator init time.
>=20
> For arm64, the hook queries the hypervisor for the supported IPA bit
> size and validates it against the guest memory map via the machine's
> get_physical_address_range callback, following the same pattern used =
by
> HVF and WHPX. This also populates the memory map which comes in handy
> later when retreiving the vGIC layout.
>=20
> For x86, the hook calls mshv_init_mmio_emu() which was previously =
called
> directly from the common init path. Also move =
set_unimplemented_msr_action()
> and mshv_arch_post_init_vm() from mshv-cpu.c to the new mshv-all.c, as
> they are not vCPU-specific.
>=20
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>


