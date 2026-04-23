Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359ABFDEE2B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxRK-0000G3-HK; Thu, 23 Apr 2026 13:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFxRC-0000Es-LM
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:02:03 -0400
Received: from qs-2004i-snip4-11.eps.apple.com ([57.103.84.93]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFxR0-0004Ny-LS
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:01:55 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id
 CB6B530010CD; Thu, 23 Apr 2026 17:01:44 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkIeGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVOAV4OKnZDDFVyWQVZH0R9SQRAdlMCQxRAd1QFLXZFCzsKKQ8rRx5JClYJXghGEVsUVkNRGQxQTQFDCAoIRwNNF14yUwRfEVAW
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776963708; x=1779555708;
 bh=DPbUjA6PyvA2vMFDn+Rt/m33kgPZCrx/aEUww7RyKck=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=GabXFiRCDc6763IT4tiJBeBBRrjjF+Bk+IKPWAKJCHCTv/ETqZwGCkDReMD15fWx2Rii2cHf51RC3YM27woiO/zvqXU/P/0kYKqv9DPdw6M7f02sdTOIyZPLN+cvqSX4K7EcnfCvOiu89BMAKD/bf2UWmttF5emFsssNHeM4iJkTw3OJT1deb/336MRDbid3Bs0+xkU5OZjWPEgW9kwiORRdmCE57kt+bMomVL9EvYDZovXVO0L18VknTXXqSVxS65mVj7SvmJEOQwTlyWbMm5weolDCqpdFYM/i+oYgk5lLMKWSlddxNuSLyTIYPQT5GGuQAJatMrexLJoPm7BbsA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id
 62F833000E84; Thu, 23 Apr 2026 17:01:15 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v20 03/15] accel, hw/arm, include/system/hvf:
 infrastructure changes for HVF vGIC
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <07560d55-25cf-4abc-8c58-b386306546b9@linaro.org>
Date: Thu, 23 Apr 2026 19:01:01 +0200
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6239AD35-A422-4D17-A803-8D92FD52C9D8@unpredictable.fr>
References: <20260316130642.13246-1-mohamed@unpredictable.fr>
 <20260316130642.13246-4-mohamed@unpredictable.fr>
 <07560d55-25cf-4abc-8c58-b386306546b9@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-GUID: Nt6VQsk01Nbf2JiDgo8JCsY-BF5qzORY
X-Authority-Info-Out: v=2.4 cv=DOGCIiNb c=1 sm=1 tr=0 ts=69ea507a
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=E-stxHK9gM_wDTnvQtoA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Nt6VQsk01Nbf2JiDgo8JCsY-BF5qzORY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE2OCBTYWx0ZWRfX3tVx674JSG3z
 wi4bL+f/FGytlj6FlCwLoGT5SCiR7k1CHHQHe5CQrLzv2SO8DJ9gTXVqLL5msdbXkWWWvitO3uL
 R4S4UW5rXWIS/+HJAVaBTacLI8e77augGnrImL2BRNhTG6FkK8S1CWZ8CzSrqqHFUeGy6gaKoV8
 YOO2oTUOOoD84MvJ/njdIvYLIFMGCIFKz5vgQ1JtS5zjljh81qDIYuzu2G/K67I3K18uFgi9x+i
 XyOkilaBbtbHrf23yY/dzgJAdsoIJWI4Vr/CHxTVKN6lFnfUb8gUxy0wvspPTckMelHrawDzAvv
 tTUy/Fvk0jaBURHOwrHig1WZLvkSCvVkI+Irra2/HK8GVKLyWI2EwttInkAP1I=
Received-SPF: pass client-ip=57.103.84.93;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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



> On 23. Apr 2026, at 18:10, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 16/3/26 14:06, Mohamed Mediouni wrote:
>> Misc changes needed for HVF vGIC enablement.
>> Note: x86_64 macOS exposes interrupt controller virtualisation since =
macOS 12.
>> Keeping an #ifdef here in case we end up supporting that...
>> However, given that x86_64 macOS is on its way out, it'll probably =
(?) not be supported in Qemu.
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  accel/hvf/hvf-all.c        | 46 =
++++++++++++++++++++++++++++++++++++++
>>  accel/stubs/hvf-stub.c     |  1 +
>>  hw/arm/virt.c              | 23 +++++++++++++++----
>>  hw/intc/arm_gicv3_common.c |  3 +++
>>  include/system/hvf.h       |  3 +++
>>  system/vl.c                |  2 ++
>>  6 files changed, 74 insertions(+), 4 deletions(-)
>=20
>=20
>> diff --git a/accel/stubs/hvf-stub.c b/accel/stubs/hvf-stub.c
>> index 42eadc5ca9..6bd08759ba 100644
>> --- a/accel/stubs/hvf-stub.c
>> +++ b/accel/stubs/hvf-stub.c
>> @@ -10,3 +10,4 @@
>>  #include "system/hvf.h"
>>    bool hvf_allowed;
>> +bool hvf_kernel_irqchip;
>=20
> This (along with hvf_nested_virt and
> hvf_kernel_irqchip_override you add later)
> should go in HVFState.

Hi,

Putting it in HVFState makes the existing
*_irqchip_in_kernel() pattern as a macro
that=E2=80=99s used by other accelerators not work.

For the hvf_kernel_irqchip_override will do
in a future revision, but for the others not
sure it makes that much sense.


