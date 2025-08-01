Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABD1C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 20:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhwc4-00076O-Bu; Fri, 01 Aug 2025 16:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhvTe-00013i-1l
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 15:31:40 -0400
Received: from p-east3-cluster2-host11-snip4-7.eps.apple.com ([57.103.87.238]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhvTb-0001bH-Ba
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 15:31:37 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 65FA318000BC; Fri,  1 Aug 2025 19:31:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=m9aOBhHYluiEzP1Fe8L7CvRnRtfyMLcYoUFHyL4pT5A=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=dqus3K6nQ+zc5LCtOYMFuN/CyAjtIFXSzWu6HVUmtIfXIkAsXSwaDOJTmR8tFYlO+5OR/y1afijRkik1bOmSVnqi8GyDXnu2a3wPRyA4wyyV/MWPksSHl8qtjj/oa/Fql3RuvSYUSa5LmZdSZDmAWSiRzOSGkilBvjCZ6bcKZczZcKSfO4vJdP91Urk2NqiDwmmzIWsjqTCBXxCtinJpSW+TeVu4aJytm3b6YY80faZb4yiCxCiPjJouznjkZWQExGMc1d+3a0rGUiGqExOz0WtU8gmfR2DFu0WLdx1BjuL8Y0sxbu9vYcMOkGq+EKMbNf8Z1OcAeKv+2RKpQTlwqw==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 0C2EC18008B1; Fri,  1 Aug 2025 19:31:31 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [RFC 0/9] WHPX support for Arm
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <d495bae3-d252-4b79-883a-3f5f815c5feb@linaro.org>
Date: Fri, 1 Aug 2025 21:31:20 +0200
Cc: qemu-devel@nongnu.org,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A71E199-4C6E-467D-9E9B-04DE9EF1A9CC@unpredictable.fr>
References: <20250731052753.93255-1-mohamed@unpredictable.fr>
 <8af5e691-da19-4141-8874-51ca685288ac@linaro.org>
 <864AC97D-2C45-402A-92AF-D0FDDB72C40E@unpredictable.fr>
 <21266cf2-887d-4bf3-8c9a-7633bffd8cd2@linaro.org>
 <17413DE3-C53B-4DA6-9777-3E772D2C2C2D@unpredictable.fr>
 <d495bae3-d252-4b79-883a-3f5f815c5feb@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE1NCBTYWx0ZWRfX8ibm30O+BkQ/
 MfYfYl7MKOgHmYTc46J7S2vwNi3CtoFvbuHnr/0+hpRfFQEiS4i6oM2e3/bb+iYgYELTt7urTtE
 I1tdjIceu6aLMHW4M/4vB2Vdv5p0uQ0KwHgwCZycdHPJhoebxJLcB8qkJ/fZMXFl9OqFjIluG97
 FJhZIvt3YxGwV9bvCy+HB52CRCSjZHKjdVBNZ4cNEMk0bcZvt6tG4VjyEFc3ZatT6JpV+soZG4+
 Mn4ihNoX7SdlmSgF6YOPCFAEI31mBsZOefXGnpX5xP2cvaAsVOJVsPSQZQTGfILQMifNKmhcs=
X-Proofpoint-GUID: 0OMBQFUWRd963MbMW4-VWal3zlMLiLEb
X-Proofpoint-ORIG-GUID: 0OMBQFUWRd963MbMW4-VWal3zlMLiLEb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_06,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1030 spamscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508010154
Received-SPF: pass client-ip=57.103.87.238;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 1. Aug 2025, at 21:16, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>=20
> On 8/1/25 11:52 AM, Mohamed Mediouni wrote:
>>> On 1. Aug 2025, at 19:22, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>>>=20
>>> On 8/1/25 5:43 AM, Mohamed Mediouni wrote:
>>>>> On 1. Aug 2025, at 03:15, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>>>>>=20
>>>>> Hi Mohamed,
>>>>>=20
>>>>> On 7/30/25 10:27 PM, Mohamed Mediouni wrote:
>>>>>> This one took way longer for me to publish than I should have.
>>>>>> There are a number of lingering bugs in this one including u-boot =
not working.
>>>>>> Interrupt controller save/restore is entirely missing in this =
RFC, and some other state
>>>>>> bits are likely still missing too.
>>>>>> ITS not blocked by default yet, remember to use its=3Doff when =
testing this series.
>>>>>> You might also want the GICv3 + GICv2m support patch as part of =
the HVF vGIC patch series, which
>>>>>> is not duplicated here.
>>>>>> PS: on both this and HVF, interrupt controller initialisation =
needs to be done early so I ended
>>>>>> up with hardcoded addresses. Wonder if the right way to go might =
be to defer virt and vCPU initialisation
>>>>>> until late in the process post-gic_realize...
>>>>>> Other than that, this boots both EDK2 and Linux in SMP, when =
using devicetree or ACPI.
>>>>>=20
>>>>> thanks for posting this, that's an exciting series!
>>>>>=20
>>>>> I applied it on top of your other series =
(20250728134114.77545-1-mohamed@unpredictable.fr) and solved the =
conflicts.
>>>>> However, it would really help if you could push that exact branch =
somewhere, so people can easily pull it and try.
>>>>> I'm fine if you want to duplicate gic patches in this series as =
well.
>>>> Hello,
>>>> My branches are at https://github.com/mediouni-m/qemu
>>>>=20
>>>=20
>>> Thanks, it's worth adding it in cover letter for next versions.
>>>=20
>>>> whpx-v1 corresponding to this RFC, but latest rev of the whpx =
branch has some fixes
>>>> Have some additional notes and binaries here too: =
https://github.com/mediouni-m/qemu/releases/tag/whpx-v1.1
>>>> Thank you,
>>>> -Mohamed
>>>>> I tried to direct boot a kernel (6.15 defconfig) and ran into this =
error [1]:
>>>>> $ ./build/qemu-system-aarch64.exe -M virt,its=3Doff -cpu =
cortex-a76 -m 2G -nographic -accel whpx -kernel out/Image.gz =
out/host.ext4
>>>> Syntax that I use is -M virt,accel=3Dwhpx,its=3Doff -m 2048-cpu =
cortex-a72 -bios share/edk2-aarch64-code.fd.
>>>> And on some kernel versions, you=E2=80=99ll also need =
irqchip.gicv3_nolpi=3D1.
>>>>> Could you please share your exact command line?
>>>>> Does it work with direct kernel boot also?
>>>>>=20
>>>>> Kind Regards,
>>>>> Pierrick
>>>>>=20
>>>>> [1] Error when booting:
>>>>> [    1.381525] Internal error: Oops: 0000000096000002 [#1]  SMP
>>>>> [    1.458060] Modules linked in:
>>>>> [    1.461172] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted =
6.15.0-00001-g7797e43a2520 #1 PREEMPT
>>>>> [    1.470502] Hardware name: linux,dummy-virt (DT)
>>>>> [    1.475102] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT =
-SSBS BTYPE=3D--)
>>>>> [    1.482023] pc : pci_generic_config_read+0x38/0xb8
>>>>> [    1.486970] lr : pci_generic_config_read+0x24/0xb8
>>>> I don=E2=80=99t think I saw this particular one before=E2=80=A6 =
which Windows version and hardware are you testing this on?
>>>>=20
>>>=20
>>> I see the same error as before.
>>>=20
>>> I tried also binaries from =
https://github.com/mediouni-m/qemu/releases/tag/whpx-v1.1, when directly =
booting kernel, I still see the same pci issue with both binaries and my =
compiled whpx-v1.3.
>>> When booting edk2 provided, I ran into this other error instead with =
both binaries [1].
>>>=20
>>> I'm running latest Windows 11 (stable channel, fully updated), on a =
microsoft volterra (devkit). It might be an issue specific to this =
platform.
>>>=20
>> I didn=E2=80=99t test anything on the stable branch for now but only =
on Canary so far.
>> Just cursorily tested (EDK2 only) an X Elite device on prod =
(26100.4652) and this issue doesn=E2=80=99t appear.
>> I have 8cx Gen 3 and 8cx Gen 1 (SQ1) devices around, will test on =
those older SoCs later and see.
>> Random idea for testing: what if you put -M highmem=3Doff, does that =
change anything?
>>=20
>=20
> Good guess, it solves the problem with edk2, and direct boots linux =
kernel successfully now.
>=20

If you don=E2=80=99t mind, could you please test the latest commit I =
just put on the Git repo (whpx branch)? It should address this properly.

Thank you,
-Mohamed


