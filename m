Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115BAC83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 10:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ue9qD-0003wa-2P; Tue, 22 Jul 2025 06:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ue9q9-0003tR-SR
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 06:03:17 -0400
Received: from p-east3-cluster1-host10-snip4-10.eps.apple.com ([57.103.87.103]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ue9q6-0005tP-Vc
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 06:03:16 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 32D5018000BF; Tue, 22 Jul 2025 10:03:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=slb5zzM0Ut5VBEbJPikDAc9Hdx2QFOQKvqQuOY/j4u4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=YqWepIIxpPMpF4hTDkbt4n8mZCzK4/lTSlERSAkpRZZXdaVl+uix0x59nWdMJgNOCknEnn1rXc2EzkLiHOxrSMLpFtVjrOGN01kHIem1K43uvN9y0rT+1C2hn2PW9HmCp4uzPyjddVh6K4KDxD/4f1qaek0I3GxGlhKj3uGNKgFSoobwWiI5nky6Tn7CWxeAtkFubiwS9STZuOVBqQ8vynYeTQu3bAyERmMvMv0COpAvnA4OiOvpMnoMU+ZSgqu2ucx/LB2uD83loXU0l9a7v1n8tdxd3j7AGIXX9H0gaUBBiUFpACmSHFxc7JMmWi92lyL3C0WvZ7XwAlnVXpYTNA==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 B16BD18000B2; Tue, 22 Jul 2025 10:03:06 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3858.100.10\))
Subject: Re: [PATCH 1/2] target/arm: hvf: add timer frequency note
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <6b86402d-6a3d-45cd-b680-a83fe5818945@linaro.org>
Date: Tue, 22 Jul 2025 12:02:54 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <83CBB3FB-54CD-4908-B6FD-7AC011FCD9EE@unpredictable.fr>
References: <20250721152902.38671-1-mohamed@unpredictable.fr>
 <20250721152902.38671-2-mohamed@unpredictable.fr>
 <6b86402d-6a3d-45cd-b680-a83fe5818945@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3858.100.10)
X-Proofpoint-GUID: FPvSwQHuuxv9D_6oFsqpY-uQfOO338yV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA4MyBTYWx0ZWRfX63wr9oUxVvuY
 H/87zuyHqtaE/GdW25xYAL1sLZhRzfizE3gqSaobpjfb/etrzpYG5SlKvC9bcl4I2ieoIBREx7Y
 St220KqMzIspZC/KDHjfNkNpo8Pk4XsYh2qcpVPXqN8a6a21cgW4IFyJ655PpgxMGvMjnFbOag5
 rheUlvznfBixvpDXy7RYtiB5I39J4dUFMtXBw/Bro7kSSs4BZIz+4QsDaI+fZJu9gs4EwJR6gMx
 bZkLeQQFIvlezm48QEEr+juz62pjuQw62Yp64S0QkTLH/bKSR1ekHy+AO+HuVpdHEj5wpqAIs=
X-Proofpoint-ORIG-GUID: FPvSwQHuuxv9D_6oFsqpY-uQfOO338yV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507220083
Received-SPF: pass client-ip=57.103.87.103;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello,

Nevermind.

It turns out that=E2=80=A6 the timer frequency exposed is different =
depending on the entitlements the program has...

With this tiny test sequence:

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index e67a8105a6..390afb03a4 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -262,7 +262,9 @@ static int hvf_accel_init(AccelState *as, =
MachineState *ms)
             return -EINVAL;
         }
     }
-
+    uint64_t frq;
+    asm volatile("mrs %0, cntfrq_el0" : "=3Dr"(frq));
+    printf("Timer frequency before hvf_arch_vm_create: %" PRIu64 "\n", =
frq);
     ret =3D hvf_arch_vm_create(ms, (uint32_t)pa_range);
     if (ret =3D=3D HV_DENIED) {
         error_report("Could not access HVF. Is the executable signed"

It turns out that:

% ./qemu-system-aarch64-unsigned -M =
virt,accel=3Dhvf,gic-version=3D3,nested=3Don,its=3Doff [=E2=80=A6]
Timer frequency before hvf_arch_vm_create: 1000000000
qemu-system-aarch64-unsigned: Could not access HVF. Is the executable =
signed with com.apple.security.hypervisor entitlement?
% ./qemu-system-aarch64-unsigned -M =
virt,accel=3Dhvf,gic-version=3D3,nested=3Don,its=3Doff [=E2=80=A6]
Timer frequency before hvf_arch_vm_create: 24000000
[=E2=80=A6]

Sigh.

> On 22. Jul 2025, at 07:52, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Hi Mohamed,
>=20
> On 21/7/25 17:29, Mohamed Mediouni wrote:
>> On Apple M3 and later, the timer frequency within apps and VM guests =
are different from each other.
>=20
> Also M1/M2, so all Apple Silicon chipsets IMO.
>=20
> This might be the issue I fixed here:
> =
https://lore.kernel.org/qemu-devel/20250620130709.31073-18-philmd@linaro.o=
rg/
>=20
>> Note that app binaries compiled with older SDKs continue to retain a =
non-1 GHz timer frequency on Apple M3/M4.
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  target/arm/hvf/hvf.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index c9cfcdc08b..4331a3386a 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -1018,6 +1018,13 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>>      int i;
>>        env->aarch64 =3D true;
>> +    /*
>> +     * TODO: This does not correspond to the exposed generic
>> +     * timer frequency to the guest on Apple M3/M4.
>> +     * This is due to a scaled 1GHz counter being exposed
>> +     * to applications built with newer SDKs when running
>> +     * on that silicon, while VMs get an unscaled counter.
>> +     */
>>      asm volatile("mrs %0, cntfrq_el0" : =
"=3Dr"(arm_cpu->gt_cntfrq_hz));
>=20
>=20


