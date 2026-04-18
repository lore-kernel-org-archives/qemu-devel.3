Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AFFF99C88
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 17:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wE9kn-00057n-Ei; Sat, 18 Apr 2026 13:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wE9km-00057e-5l
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 13:46:48 -0400
Received: from p-west2-cluster5-host8-snip4-10.eps.apple.com ([57.103.71.83]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wE9kj-00008n-Rs
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 13:46:47 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-0 (Postfix) with ESMTPS id
 3178A1800155; Sat, 18 Apr 2026 17:46:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776534401; x=1779126401;
 bh=/s6rV3OPbpGqCO2vJgyxdI+AGTAIfaIifIdj6tNLlBA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=eVHuX7c1jjLF2I6WStM3BjC8r34b0pDww79PPaOyfT9FcSPjAWiFmw7kYTPkfSLGfwbCWSdQt5uzr+ZAM7vK+2jFp8TQCQy+BsFkzdye7iHQciwjkMHNKdrFr3QZM+bfR+rcQ/0aUzzz70S4Z9wAqCcRCuBqqP6QRenAvp/NBtxutLfQJEziyyv981ek4uVJ9C1a7B6R5+sEtf77WDpnaF6Vv7CxZlZjiTFvJCcrRRsOC8kfiEN/doUeZB68iDSdIbwODZ4W1nRbRIEYAtmKhPXDY0whG1yT4Nf/9Uz3R/NBURM8sS09SPndnHQGO/dd3ZDfrOIUZR3AiMbc0KsGlQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-0 (Postfix) with ESMTPSA id
 34E1D18000B5; Sat, 18 Apr 2026 17:46:37 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 30/34] target/i386: add de/compaction to xsave_helper
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260417105618.3621-31-magnuskulke@linux.microsoft.com>
Date: Sat, 18 Apr 2026 19:46:25 +0200
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
Message-Id: <83C168E7-02D5-4CD9-9A27-545A88942171@unpredictable.fr>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-31-magnuskulke@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-ORIG-GUID: H3ykXvsMWfb2zIV-QT4XRhlHmDs3jKSP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDE3NyBTYWx0ZWRfXxyvn7KBVLGfq
 IIPtmNQneJQF3S70UZICiqeiUKCUy3qoz8kEQ/Jn4VLhByyMdLKnrzAi0aJk0Y3W4Vag9/ib5Cj
 7TFonesYiS6cmCSEeXTtWrtnnSa5R+Biux4q5EpAP5ZYj2Ei2O6WW0+lU2toso8N8cGHoK/zmGM
 kAmO/Mbos1WSQsVQVkoQQJ2b7hlJiWUX9iKtvsrSIeYVdent9VToShqLAS8M4zCBtbBtcobe971
 IzkS5n26oSW5DpJlu334WwCcy6OhAWiBJowYE/5h1PHU9VbU+cvNF9IV5Nuq6se6UUTJTfI1R0I
 dDaaaKSyNFkLja/rsKxxkg/OhDJf0XVHTGfHF3EK8SoOpi7ZQI5HNFaejVoWrY=
X-Authority-Info-Out: v=2.4 cv=QPllhwLL c=1 sm=1 tr=0 ts=69e3c380
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=DZ2UKWXZgWu71k7g0sQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: H3ykXvsMWfb2zIV-QT4XRhlHmDs3jKSP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1030 mlxlogscore=999 mlxscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604180177
Received-SPF: pass client-ip=57.103.71.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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
> HyperV use XSAVES which stores extended state in compacted format in
> which components are packed contiguously, while QEMU's internal XSAVE
> representation use the standard format in which each component is =
places
> at a fixed offset. Hence for this purpose we add two conversion fn's =
to
> the xsave helper to roundtrip XSAVE state in a migration.
>=20
> - decompact_xsave_area(): converts compacted format to standard.
>  XSTATE_BV is masked to host XCR0 since IA32_XSS is managed
>  by the hypervisor.
>=20
> - compact_xsave_area(): converts standard format back to compacted
>  format. XCOMP_BV is set from the host's CPUID 0xD.0 rather than the
>  guest's XCR0, as this is what the hypervisor expects.
>=20
> Both functions use the host's CPUID leaf 0xD subleaves to determine =
component
> sizes, offsets, and alignment requirements.
>=20
> There are situations when the host advertises features that we want to
> disable for the guest, e.g. AMX TILE. In this case we cannot rely on =
the
> host's xcr0, but instead we use the feature mask that has been =
generated
> in as part of the CPU realization process (x86_cpu_expand_features).
>=20
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Hi,

This patch has a tiny problem.

#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
void *xsave_buf;
uint32_t xsave_buf_len;
#endif

With the "#if defined(CONFIG_KVM) || defined(CONFIG_HVF)=E2=80=9D =
removed,
that fixes a TCG only QEMU build.

Was also able to test that this works as expected on WHPX.


