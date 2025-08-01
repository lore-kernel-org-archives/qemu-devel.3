Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBA5C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 13:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhpbq-0007Z2-3a; Fri, 01 Aug 2025 09:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhp7P-0007Ki-0D
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 08:44:23 -0400
Received: from p-east3-cluster7-host1-snip4-10.eps.apple.com ([57.103.84.141]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhp7K-0007Y2-Cv
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 08:44:12 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-0 (Postfix) with ESMTPS id
 D38351800388; Fri,  1 Aug 2025 12:44:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=Ig5FUx53rIxaYHvKqq5JbmxF3Pt6fGzEa61QzozIUkc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Od1mnefQdnMZiAD+fgYvzOJletwcgphgQQuGdEnBf2MdfBQxfYsGal3k6ouBALLicWPYRgrgF+G2wrDxy/GqUYnbsgPgG2DAUdZFXzMfEWt335zckBSwZIiW+5+WkGeV70dfGfXf+ab3hVidZGRq5dHtpRngLAM4cYvJrTuW/o7TLh6o+m1+P/IxkHn87PVHq6DqjyY3uX1Vfw1qT3olYVArep9A/pcHYPGvRL5gs/xBmSoQLvt+KfpvEwBR0OmmHQdyfmX4k9Bqrgn7RyVEtFib7HRIb7oNvpYCuK2JlmeRMJkBptIJRJHrXn7OltJxjPRrNZOjz/jM098Ev6j7WA==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-0 (Postfix) with ESMTPSA id
 D71271800153; Fri,  1 Aug 2025 12:43:59 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [RFC 0/9] WHPX support for Arm
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <8af5e691-da19-4141-8874-51ca685288ac@linaro.org>
Date: Fri, 1 Aug 2025 14:43:48 +0200
Cc: qemu-devel@nongnu.org,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <864AC97D-2C45-402A-92AF-D0FDDB72C40E@unpredictable.fr>
References: <20250731052753.93255-1-mohamed@unpredictable.fr>
 <8af5e691-da19-4141-8874-51ca685288ac@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-GUID: caS-lB2uvxxiT7S2FFAVsbzO-WATyl3O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA5NiBTYWx0ZWRfXzlEHa88k5Ql5
 ocAilHEKQTr5Mu+zHswJy+2ajmEvo22M90+kJrcCk+lCM7pfSAflHzHXRfDLK/LeZOYQv68ny59
 M3vdwm/D5vCvZSyhczp3yFX3cCmhQMldQ103BIPOaqRlMUCN56mRNjUjVFB+9mWNQKyOWWphpjR
 6crscNN96Zi3quvYuVIiWRxC/vbFyTLLCcWSltoie89/J2+bSMQ2A8EeuLDXHsuGS25Cgl77BlE
 5b8yd1MZbBC5D1x4bwnD64MPmvN9PfpssOE027ztPT+so2cdj73ftP8j5bG2ZhTYMjpo+16Vo=
X-Proofpoint-ORIG-GUID: caS-lB2uvxxiT7S2FFAVsbzO-WATyl3O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1030 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2508010096
Received-SPF: pass client-ip=57.103.84.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 1. Aug 2025, at 03:15, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>=20
> Hi Mohamed,
>=20
> On 7/30/25 10:27 PM, Mohamed Mediouni wrote:
>> This one took way longer for me to publish than I should have.
>> There are a number of lingering bugs in this one including u-boot not =
working.
>> Interrupt controller save/restore is entirely missing in this RFC, =
and some other state
>> bits are likely still missing too.
>> ITS not blocked by default yet, remember to use its=3Doff when =
testing this series.
>> You might also want the GICv3 + GICv2m support patch as part of the =
HVF vGIC patch series, which
>> is not duplicated here.
>> PS: on both this and HVF, interrupt controller initialisation needs =
to be done early so I ended
>> up with hardcoded addresses. Wonder if the right way to go might be =
to defer virt and vCPU initialisation
>> until late in the process post-gic_realize...
>> Other than that, this boots both EDK2 and Linux in SMP, when using =
devicetree or ACPI.
>=20
> thanks for posting this, that's an exciting series!
>=20
> I applied it on top of your other series =
(20250728134114.77545-1-mohamed@unpredictable.fr) and solved the =
conflicts.
> However, it would really help if you could push that exact branch =
somewhere, so people can easily pull it and try.
> I'm fine if you want to duplicate gic patches in this series as well.
Hello,

My branches are at https://github.com/mediouni-m/qemu

whpx-v1 corresponding to this RFC, but latest rev of the whpx branch has =
some fixes

Have some additional notes and binaries here too: =
https://github.com/mediouni-m/qemu/releases/tag/whpx-v1.1

Thank you,
-Mohamed

> I tried to direct boot a kernel (6.15 defconfig) and ran into this =
error [1]:
> $ ./build/qemu-system-aarch64.exe -M virt,its=3Doff -cpu cortex-a76 -m =
2G -nographic -accel whpx -kernel out/Image.gz out/host.ext4

Syntax that I use is -M virt,accel=3Dwhpx,its=3Doff -m 2048-cpu =
cortex-a72 -bios share/edk2-aarch64-code.fd.

And on some kernel versions, you=E2=80=99ll also need =
irqchip.gicv3_nolpi=3D1.

> Could you please share your exact command line?
> Does it work with direct kernel boot also?
>=20
> Kind Regards,
> Pierrick
>=20
> [1] Error when booting:
> [    1.381525] Internal error: Oops: 0000000096000002 [#1]  SMP
> [    1.458060] Modules linked in:
> [    1.461172] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted =
6.15.0-00001-g7797e43a2520 #1 PREEMPT
> [    1.470502] Hardware name: linux,dummy-virt (DT)
> [    1.475102] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS =
BTYPE=3D--)
> [    1.482023] pc : pci_generic_config_read+0x38/0xb8
> [    1.486970] lr : pci_generic_config_read+0x24/0xb8
I don=E2=80=99t think I saw this particular one before=E2=80=A6 which =
Windows version and hardware are you testing this on?

(Message was sent from the wrong email alias on mobile, resending)
Thank you,
-Mohamed


