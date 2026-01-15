Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE50BD46638
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 23:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgWZu-0008IH-2L; Thu, 15 Jan 2026 18:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgWZs-0008I2-8m
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 18:16:32 -0500
Received: from p-west3-cluster2-host8-snip4-10.eps.apple.com ([57.103.74.43]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgWZl-0003Wn-0O
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 18:16:32 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id
 7A3691800718; Thu, 15 Jan 2026 23:16:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=XQ9IX2IgnBfWVWOVqJ582MV3sTnpqDcY2ymArRkVAmc=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=IiyAspNcHBvm/dHnrJHO2Vx4B0UjKFASpHMMTu9LchMBIN7k4CQNgUUbmn3fNyM+iyx01fWO0yEQSzJ8KUZr8Ido3lcsG5rXOif1Z6v6lN/D18G+aUApqb36NEykuYH8yNzZ9N0nIFbmpB8OQ98/Wh+QTiNC5xaFNAcM7B1sg/jvtWT9XuJJQ/SFHzwfsM6wYTqhRXJ68qDqU6mfqdQTCZOAYdYDOtwQgxN1hxY+GQQgyL73AJg5SyMppmjSvBhLYU0m8IreXLorGjziTT+SmyZ1UqPNTptBO+RGSNvdt8n5cH752LX3S1GqshcC3Dk+IAhmIj57dhxRr/Pu40jTjA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id
 1A9B7180012A; Thu, 15 Jan 2026 23:16:06 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <3A97241E-F8F2-4699-A20F-1B3B6574128B@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_103B3248-7813-4D13-8DEC-F7B535F809FF"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v15 15/26] whpx: add arm64 support
Date: Fri, 16 Jan 2026 00:15:54 +0100
In-Reply-To: <696b6da1-08b8-4121-aa5b-f18861b10c2e@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
 <20260115001505.57237-16-mohamed@unpredictable.fr>
 <696b6da1-08b8-4121-aa5b-f18861b10c2e@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-GUID: _Tyhzx_f7i_J0MmdeTxnyzX6QyRgwhFa
X-Authority-Info: v=2.4 cv=VbD6/Vp9 c=1 sm=1 tr=0 ts=69697543
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=f023661Gd3cv2F1CgyEA:9 a=dGoYUFej5rHzBAPe:21
 a=CjuIK1q_8ugA:10 a=02CKbAGvoj3OQ8BfocEA:9 a=DheVAsNe9Md5yAjs:21
 a=_W_S_7VecoQA:10
X-Proofpoint-ORIG-GUID: _Tyhzx_f7i_J0MmdeTxnyzX6QyRgwhFa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE4NCBTYWx0ZWRfX3lOiFTx8d/r5
 sy+enKvwMQIFfFn/lthyiVOK6ptx5cUkXkj/eggPSr3L5m1+sX2ORUD2ZOmllxh2bFds6bOImKn
 /M+r91jcewc/6c+WUBQsXFc6S1+0zJpG+9a/PVAxx3VvpCN1rPalBbBr7x6eWveIt+CF5dAlUPY
 4/6Ct7dd77lpGb0ivv6NzbwCak/EKQLo8UPJYfScr3R7eVs4vx3DF2lSRBMk4OunwNXhbk0K/aX
 26Lm8aiUBzleMX1IHAf1FHaHFTfRP9aFzbSnZ0XXU7sm8+K01/I/8qNG2lwkkU2hyZAtN2zn69k
 imUinEbtitYz6oh37Uy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_07,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1030 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601150184
X-JNJ: AAAAAAAB5oxnPz7psCbr/jUJAFDEICR396YO+nOW8eUFNJJRQuVSVFnMpkn290b0mydqSV5jFz2lSwAWEwCua6vYntedl3hmEQDcoFDQNYJ8aRXnawaofWvHQQZMzhGLTiFhCQ76VwHm8Jiv98Wdw8R/Dm1bvuektbaCkozDVulu8sD2EI6CYEzW2MBmUlmY0HVuTQVgEKvzNMo8QjxMsq5cg89dl2+pRqQlPQbqTJiSD0R0tyYRM9yFgibC73ctuUzJzMEU3D1TGv8Upe9H+cEoo4z9dWVc9ZWv3LfHST6NOH0RqaDXoBcmp8sUomv3tXYtoyjizlsMvYWY67spPizTL10IGYJ7zLlalWpqCHgcfIBU2UVhhmrOlkCOP+5ejeCRh9vg/FQD746l+LI6oKYxXytSMHArWn3w6EuT44TDS58IGC325s+whW6mJUjeJFiz01uqv/5ukJ1h5uXEFjsVa5tP41yqe2dBJcnzdSpJjIEPjDKCLx338dEjQETY4D95n1m2bQ6kQFg0tBFJ0K46cNRT9Gf/bpnurEcxlP9I/B0J1WNkE7Ra+EF4PScAPKxwYPRhCpAZ9m1pN/4AKdGgM3L//18OhDViSay9B0BnZ6NHwC3CxjA+4R2RuT8V4Vx/dc7vQExXR2gTZmtK4mKwlS046IWop/em0PbsVhPiZHavrvo0zf3y1rhGNJAkBgK/o0Ky5Vm8ptnksS9TQ5NGjjVvrbxV3+jkxC01w0nWapul/do97CUbQIUUoAxdr/uw5WH7OJx13cNqWeNLs29JeaAos9ZoYcauDSTZJKXV19dHnqwRpcWFZOBIKWW7CBn2+7BERjT+foZx3xN7tF0o1t6JWoESCY5W/ahfpxP0aMURQGnakLxtmSoUMZZo+1ygPoXTErTiW9dAislCO3h9KruUdTggk9oNU68G0WRyqPKndiNrLrgOLTVUFT5G68coIQ==
Received-SPF: pass client-ip=57.103.74.43;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--Apple-Mail=_103B3248-7813-4D13-8DEC-F7B535F809FF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 15. Jan 2026, at 07:18, Akihiko Odaki =
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>=20
> On 2026/01/15 9:14, Mohamed Mediouni wrote:
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  accel/whpx/whpx-common.c    |   1 +
>>  target/arm/meson.build      |   1 +
>>  target/arm/whpx/meson.build |   3 +
>>  target/arm/whpx/whpx-all.c  | 815 =
++++++++++++++++++++++++++++++++++++
>>  4 files changed, 820 insertions(+)
>>  create mode 100644 target/arm/whpx/meson.build
>>  create mode 100644 target/arm/whpx/whpx-all.c
>> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
>> index 05f9e520b7..827f50f3e0 100644
>> --- a/accel/whpx/whpx-common.c
>> +++ b/accel/whpx/whpx-common.c
>> @@ -12,6 +12,7 @@
>>  #include "gdbstub/helpers.h"
>>  #include "qemu/accel.h"
>>  #include "accel/accel-ops.h"
>> +#include "system/memory.h"
>>  #include "system/whpx.h"
>>  #include "system/cpus.h"
>>  #include "system/runstate.h"
>> diff --git a/target/arm/meson.build b/target/arm/meson.build
>> index 462c71148d..ce155ba9b4 100644
>> --- a/target/arm/meson.build
>> +++ b/target/arm/meson.build
>> @@ -59,6 +59,7 @@ arm_common_system_ss.add(files(
>>  ))
>>    subdir('hvf')
>> +subdir('whpx')
>>    if 'CONFIG_TCG' in config_all_accel
>>     subdir('tcg')
>> diff --git a/target/arm/whpx/meson.build =
b/target/arm/whpx/meson.build
>> new file mode 100644
>> index 0000000000..1de2ef0283
>> --- /dev/null
>> +++ b/target/arm/whpx/meson.build
>> @@ -0,0 +1,3 @@
>> +arm_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
>> +  'whpx-all.c',
>> +))
>> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
>> new file mode 100644
>> index 0000000000..62fda15597
>> --- /dev/null
>> +++ b/target/arm/whpx/whpx-all.c
>> @@ -0,0 +1,815 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * QEMU Windows Hypervisor Platform accelerator (WHPX)
>> + *
>> + * Copyright (c) 2025 Mohamed Mediouni
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "cpu.h"
>> +#include "system/address-spaces.h"
>> +#include "system/ioport.h"
>> +#include "gdbstub/helpers.h"
>> +#include "qemu/accel.h"
>> +#include "accel/accel-ops.h"
>> +#include "system/whpx.h"
>> +#include "system/cpus.h"
>> +#include "system/runstate.h"
>> +#include "qemu/main-loop.h"
>> +#include "hw/core/boards.h"
>> +#include "qemu/error-report.h"
>> +#include "qapi/error.h"
>> +#include "qapi/qapi-types-common.h"
>> +#include "qapi/qapi-visit-common.h"
>> +#include "migration/blocker.h"
>> +#include "accel/accel-cpu-target.h"
>> +#include <winerror.h>
>> +
>> +#include "syndrome.h"
>> +#include "cpu.h"
>> +#include "target/arm/cpregs.h"
>> +#include "internals.h"
>> +
>> +#include "system/whpx-internal.h"
>> +#include "system/whpx-accel-ops.h"
>> +#include "system/whpx-all.h"
>> +#include "system/whpx-common.h"
>> +#include "hw/arm/bsa.h"
>> +#include "arm-powerctl.h"
>> +
>> +#include <winhvplatform.h>
>> +#include <winhvplatformdefs.h>
>> +
>> +struct whpx_reg_match {
>> +    WHV_REGISTER_NAME reg;
>> +    uint64_t offset;
>> +};
>=20
> As per docs/devel/style.rst, this should be:
>=20
> typedef struct WHPXRegMatch {
>    WHV_REGISTER_NAME reg;
>    uint64_t offset;
> } WHPXRegMatch;
>=20
Hello,

Applied the change to this for the next rev. Do you have tips on how to =
automate this
(inherited this from the HVF code style as are a lot of your other =
reviews in this series really)

Thank you,
-Mohamed
>> +
>> +static const struct whpx_reg_match whpx_reg_match[] =3D {
>> +    { WHvArm64RegisterX0,   offsetof(CPUARMState, xregs[0]) },
>> +    { WHvArm64RegisterX1,   offsetof(CPUARMState, xregs[1]) },
>> +    { WHvArm64RegisterX2,   offsetof(CPUARMState, xregs[2]) },
>> +    { WHvArm64RegisterX3,   offsetof(CPUARMState, xregs[3]) },
>> +    { WHvArm64RegisterX4,   offsetof(CPUARMState, xregs[4]) },
>> +    { WHvArm64RegisterX5,   offsetof(CPUARMState, xregs[5]) },
>> +    { WHvArm64RegisterX6,   offsetof(CPUARMState, xregs[6]) },
>> +    { WHvArm64RegisterX7,   offsetof(CPUARMState, xregs[7]) },
>> +    { WHvArm64RegisterX8,   offsetof(CPUARMState, xregs[8]) },
>> +    { WHvArm64RegisterX9,   offsetof(CPUARMState, xregs[9]) },
>> +    { WHvArm64RegisterX10,  offsetof(CPUARMState, xregs[10]) },
>> +    { WHvArm64RegisterX11,  offsetof(CPUARMState, xregs[11]) },
>> +    { WHvArm64RegisterX12,  offsetof(CPUARMState, xregs[12]) },
>> +    { WHvArm64RegisterX13,  offsetof(CPUARMState, xregs[13]) },
>> +    { WHvArm64RegisterX14,  offsetof(CPUARMState, xregs[14]) },
>> +    { WHvArm64RegisterX15,  offsetof(CPUARMState, xregs[15]) },
>> +    { WHvArm64RegisterX16,  offsetof(CPUARMState, xregs[16]) },
>> +    { WHvArm64RegisterX17,  offsetof(CPUARMState, xregs[17]) },
>> +    { WHvArm64RegisterX18,  offsetof(CPUARMState, xregs[18]) },
>> +    { WHvArm64RegisterX19,  offsetof(CPUARMState, xregs[19]) },
>> +    { WHvArm64RegisterX20,  offsetof(CPUARMState, xregs[20]) },
>> +    { WHvArm64RegisterX21,  offsetof(CPUARMState, xregs[21]) },
>> +    { WHvArm64RegisterX22,  offsetof(CPUARMState, xregs[22]) },
>> +    { WHvArm64RegisterX23,  offsetof(CPUARMState, xregs[23]) },
>> +    { WHvArm64RegisterX24,  offsetof(CPUARMState, xregs[24]) },
>> +    { WHvArm64RegisterX25,  offsetof(CPUARMState, xregs[25]) },
>> +    { WHvArm64RegisterX26,  offsetof(CPUARMState, xregs[26]) },
>> +    { WHvArm64RegisterX27,  offsetof(CPUARMState, xregs[27]) },
>> +    { WHvArm64RegisterX28,  offsetof(CPUARMState, xregs[28]) },
>> +    { WHvArm64RegisterFp,   offsetof(CPUARMState, xregs[29]) },
>> +    { WHvArm64RegisterLr,   offsetof(CPUARMState, xregs[30]) },
>> +    { WHvArm64RegisterPc,   offsetof(CPUARMState, pc) },
>> +};
>> +
>> +static const struct whpx_reg_match whpx_fpreg_match[] =3D {
>> +    { WHvArm64RegisterQ0,  offsetof(CPUARMState, vfp.zregs[0]) },
>> +    { WHvArm64RegisterQ1,  offsetof(CPUARMState, vfp.zregs[1]) },
>> +    { WHvArm64RegisterQ2,  offsetof(CPUARMState, vfp.zregs[2]) },
>> +    { WHvArm64RegisterQ3,  offsetof(CPUARMState, vfp.zregs[3]) },
>> +    { WHvArm64RegisterQ4,  offsetof(CPUARMState, vfp.zregs[4]) },
>> +    { WHvArm64RegisterQ5,  offsetof(CPUARMState, vfp.zregs[5]) },
>> +    { WHvArm64RegisterQ6,  offsetof(CPUARMState, vfp.zregs[6]) },
>> +    { WHvArm64RegisterQ7,  offsetof(CPUARMState, vfp.zregs[7]) },
>> +    { WHvArm64RegisterQ8,  offsetof(CPUARMState, vfp.zregs[8]) },
>> +    { WHvArm64RegisterQ9,  offsetof(CPUARMState, vfp.zregs[9]) },
>> +    { WHvArm64RegisterQ10, offsetof(CPUARMState, vfp.zregs[10]) },
>> +    { WHvArm64RegisterQ11, offsetof(CPUARMState, vfp.zregs[11]) },
>> +    { WHvArm64RegisterQ12, offsetof(CPUARMState, vfp.zregs[12]) },
>> +    { WHvArm64RegisterQ13, offsetof(CPUARMState, vfp.zregs[13]) },
>> +    { WHvArm64RegisterQ14, offsetof(CPUARMState, vfp.zregs[14]) },
>> +    { WHvArm64RegisterQ15, offsetof(CPUARMState, vfp.zregs[15]) },
>> +    { WHvArm64RegisterQ16, offsetof(CPUARMState, vfp.zregs[16]) },
>> +    { WHvArm64RegisterQ17, offsetof(CPUARMState, vfp.zregs[17]) },
>> +    { WHvArm64RegisterQ18, offsetof(CPUARMState, vfp.zregs[18]) },
>> +    { WHvArm64RegisterQ19, offsetof(CPUARMState, vfp.zregs[19]) },
>> +    { WHvArm64RegisterQ20, offsetof(CPUARMState, vfp.zregs[20]) },
>> +    { WHvArm64RegisterQ21, offsetof(CPUARMState, vfp.zregs[21]) },
>> +    { WHvArm64RegisterQ22, offsetof(CPUARMState, vfp.zregs[22]) },
>> +    { WHvArm64RegisterQ23, offsetof(CPUARMState, vfp.zregs[23]) },
>> +    { WHvArm64RegisterQ24, offsetof(CPUARMState, vfp.zregs[24]) },
>> +    { WHvArm64RegisterQ25, offsetof(CPUARMState, vfp.zregs[25]) },
>> +    { WHvArm64RegisterQ26, offsetof(CPUARMState, vfp.zregs[26]) },
>> +    { WHvArm64RegisterQ27, offsetof(CPUARMState, vfp.zregs[27]) },
>> +    { WHvArm64RegisterQ28, offsetof(CPUARMState, vfp.zregs[28]) },
>> +    { WHvArm64RegisterQ29, offsetof(CPUARMState, vfp.zregs[29]) },
>> +    { WHvArm64RegisterQ30, offsetof(CPUARMState, vfp.zregs[30]) },
>> +    { WHvArm64RegisterQ31, offsetof(CPUARMState, vfp.zregs[31]) },
>> +};
>> +
>> +struct whpx_sreg_match {
>> +    WHV_REGISTER_NAME reg;
>> +    uint32_t key;
>> +    bool global;
>> +    uint32_t cp_idx;
>> +};
>> +
>> +static struct whpx_sreg_match whpx_sreg_match[] =3D {
>> +    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 4) =
},
>> +    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 5) =
},
>> +    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 6) =
},
>> +    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 7) =
},
>> +
>> +    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 4) =
},
>> +    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 5) =
},
>> +    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 6) =
},
>> +    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 7) =
},
>> +
>> +    { WHvArm64RegisterDbgbvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 4) =
},
>> +    { WHvArm64RegisterDbgbcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 5) =
},
>> +    { WHvArm64RegisterDbgwvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 6) =
},
>> +    { WHvArm64RegisterDbgwcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 7) =
},
>> +
>> +    { WHvArm64RegisterDbgbvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 4) =
},
>> +    { WHvArm64RegisterDbgbcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 5) =
},
>> +    { WHvArm64RegisterDbgwvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 6) =
},
>> +    { WHvArm64RegisterDbgwcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 7) =
},
>> +
>> +    { WHvArm64RegisterDbgbvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 4) =
},
>> +    { WHvArm64RegisterDbgbcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 5) =
},
>> +    { WHvArm64RegisterDbgwvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 6) =
},
>> +    { WHvArm64RegisterDbgwcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 7) =
},
>> +
>> +    { WHvArm64RegisterDbgbvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 4) =
},
>> +    { WHvArm64RegisterDbgbcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 5) =
},
>> +    { WHvArm64RegisterDbgwvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 6) =
},
>> +    { WHvArm64RegisterDbgwcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 7) =
},
>> +
>> +    { WHvArm64RegisterDbgbvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 4) =
},
>> +    { WHvArm64RegisterDbgbcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 5) =
},
>> +    { WHvArm64RegisterDbgwvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 6) =
},
>> +    { WHvArm64RegisterDbgwcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 7) =
},
>> +
>> +    { WHvArm64RegisterDbgbvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 4) =
},
>> +    { WHvArm64RegisterDbgbcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 5) =
},
>> +    { WHvArm64RegisterDbgwvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 6) =
},
>> +    { WHvArm64RegisterDbgwcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 7) =
},
>> +
>> +    { WHvArm64RegisterDbgbvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 4) =
},
>> +    { WHvArm64RegisterDbgbcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 5) =
},
>> +    { WHvArm64RegisterDbgwvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 6) =
},
>> +    { WHvArm64RegisterDbgwcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 7) =
},
>> +
>> +    { WHvArm64RegisterDbgbvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 4) =
},
>> +    { WHvArm64RegisterDbgbcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 5) =
},
>> +    { WHvArm64RegisterDbgwvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 6) =
},
>> +    { WHvArm64RegisterDbgwcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 7) =
},
>> +
>> +    { WHvArm64RegisterDbgbvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, =
4) },
>> +    { WHvArm64RegisterDbgbcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, =
5) },
>> +    { WHvArm64RegisterDbgwvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, =
6) },
>> +    { WHvArm64RegisterDbgwcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, =
7) },
>> +
>> +    { WHvArm64RegisterDbgbvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, =
4) },
>> +    { WHvArm64RegisterDbgbcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, =
5) },
>> +    { WHvArm64RegisterDbgwvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, =
6) },
>> +    { WHvArm64RegisterDbgwcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, =
7) },
>> +
>> +    { WHvArm64RegisterDbgbvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, =
4) },
>> +    { WHvArm64RegisterDbgbcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, =
5) },
>> +    { WHvArm64RegisterDbgwvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, =
6) },
>> +    { WHvArm64RegisterDbgwcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, =
7) },
>> +
>> +    { WHvArm64RegisterDbgbvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, =
4) },
>> +    { WHvArm64RegisterDbgbcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, =
5) },
>> +    { WHvArm64RegisterDbgwvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, =
6) },
>> +    { WHvArm64RegisterDbgwcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, =
7) },
>> +
>> +    { WHvArm64RegisterDbgbvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, =
4) },
>> +    { WHvArm64RegisterDbgbcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, =
5) },
>> +    { WHvArm64RegisterDbgwvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, =
6) },
>> +    { WHvArm64RegisterDbgwcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, =
7) },
>> +
>> +    { WHvArm64RegisterDbgbvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, =
4) },
>> +    { WHvArm64RegisterDbgbcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, =
5) },
>> +    { WHvArm64RegisterDbgwvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, =
6) },
>> +    { WHvArm64RegisterDbgwcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, =
7) },
>> +#ifdef SYNC_NO_RAW_REGS
>> +    /*
>> +     * The registers below are manually synced on init because they =
are
>> +     * marked as NO_RAW. We still list them to make number space =
sync easier.
>> +     */
>> +    { WHvArm64RegisterMidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 0) },
>> +    { WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 5) },
>> +    { WHvArm64RegisterIdPfr0El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 0) =
},
>> +#endif
>> +    { WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, =
1), true },
>> +    { WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, =
0), true },
>> +    { WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, =
1), true },
>> +    { WHvArm64RegisterIdAa64Isar0El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, =
0), true },
>> +    { WHvArm64RegisterIdAa64Isar1El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, =
1), true },
>> +#ifdef SYNC_NO_MMFR0
>> +    /* We keep the hardware MMFR0 around. HW limits are there anyway =
*/
>> +    { WHvArm64RegisterIdAa64Mmfr0El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, =
0) },
>> +#endif
>> +    { WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, =
1), true },
>> +    { WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, =
2), true },
>> +    { WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, =
3), true },
>> +
>> +    { WHvArm64RegisterMdscrEl1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 2) },
>> +    { WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 0) },
>> +    { WHvArm64RegisterCpacrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 2) },
>> +    { WHvArm64RegisterTtbr0El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 0) },
>> +    { WHvArm64RegisterTtbr1El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 1) },
>> +    { WHvArm64RegisterTcrEl1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 2) },
>> +
>> +    { WHvArm64RegisterApiAKeyLoEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, =
0) },
>> +    { WHvArm64RegisterApiAKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, =
1) },
>> +    { WHvArm64RegisterApiBKeyLoEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, =
2) },
>> +    { WHvArm64RegisterApiBKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, =
3) },
>> +    { WHvArm64RegisterApdAKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, =
0) },
>> +    { WHvArm64RegisterApdAKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, =
1) },
>> +    { WHvArm64RegisterApdBKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, =
2) },
>> +    { WHvArm64RegisterApdBKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, =
3) },
>> +    { WHvArm64RegisterApgAKeyLoEl1, ENCODE_AA64_CP_REG(2, 3, 3, 0, =
0) },
>> +    { WHvArm64RegisterApgAKeyHiEl1, ENCODE_AA64_CP_REG(2, 3, 3, 0, =
1) },
>> +
>> +    { WHvArm64RegisterSpsrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 0) },
>> +    { WHvArm64RegisterElrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 1) },
>> +    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 0, 0) },
>> +    { WHvArm64RegisterEsrEl1, ENCODE_AA64_CP_REG(5, 2, 3, 0, 0) },
>> +    { WHvArm64RegisterFarEl1, ENCODE_AA64_CP_REG(6, 0, 3, 0, 0) },
>> +    { WHvArm64RegisterParEl1, ENCODE_AA64_CP_REG(7, 4, 3, 0, 0) },
>> +    { WHvArm64RegisterMairEl1, ENCODE_AA64_CP_REG(10, 2, 3, 0, 0) },
>> +    { WHvArm64RegisterVbarEl1, ENCODE_AA64_CP_REG(12, 0, 3, 0, 0) },
>> +    { WHvArm64RegisterContextidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, =
1) },
>> +    { WHvArm64RegisterTpidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, 4) =
},
>> +    { WHvArm64RegisterCntkctlEl1, ENCODE_AA64_CP_REG(14, 1, 3, 0, 0) =
},
>> +    { WHvArm64RegisterCsselrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 2, 0) =
},
>> +    { WHvArm64RegisterTpidrEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 2) =
},
>> +    { WHvArm64RegisterTpidrroEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 3) =
},
>> +    { WHvArm64RegisterCntvCtlEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 1) =
},
>> +    { WHvArm64RegisterCntvCvalEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, =
2) },
>> +    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 4, 0) },
>> +};
>> +
>> +static void flush_cpu_state(CPUState *cpu)
>> +{
>> +    if (cpu->vcpu_dirty) {
>> +        whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
>> +        cpu->vcpu_dirty =3D false;
>> +    }
>> +}
>> +
>> +HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
>> +{
>> +    if (exceptions !=3D 0) {
>> +        return E_NOTIMPL;
>> +    }
>> +    return ERROR_SUCCESS;
>> +}
>> +void whpx_apply_breakpoints(
>> +    struct whpx_breakpoint_collection *breakpoints,
>> +    CPUState *cpu,
>> +    bool resuming)
>> +{
>> +
>> +}
>> +void whpx_translate_cpu_breakpoints(
>> +    struct whpx_breakpoints *breakpoints,
>> +    CPUState *cpu,
>> +    int cpu_breakpoint_count)
>> +{
>> +
>> +}
>> +
>> +static void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, =
WHV_REGISTER_VALUE* val)
>> +{
>> +    struct whpx_state *whpx =3D &whpx_global;
>> +    HRESULT hr;
>> +
>> +    flush_cpu_state(cpu);
>> +
>> +    hr =3D =
whp_dispatch.WHvGetVirtualProcessorRegisters(whpx->partition, =
cpu->cpu_index,
>> +         &reg, 1, val);
>> +
>> +    if (FAILED(hr)) {
>> +        error_report("WHPX: Failed to get register %08x, hr=3D%08lx", =
reg, hr);
>> +    }
>> +}
>> +
>> +static void whpx_set_reg(CPUState *cpu, WHV_REGISTER_NAME reg, =
WHV_REGISTER_VALUE val)
>> +{
>> +    struct whpx_state *whpx =3D &whpx_global;
>> +    HRESULT hr;
>> +    hr =3D =
whp_dispatch.WHvSetVirtualProcessorRegisters(whpx->partition, =
cpu->cpu_index,
>> +         &reg, 1, &val);
>> +
>> +    if (FAILED(hr)) {
>> +        error_report("WHPX: Failed to set register %08x, hr=3D%08lx", =
reg, hr);
>> +    }
>> +}
>> +
>> +static void whpx_get_global_reg(WHV_REGISTER_NAME reg, =
WHV_REGISTER_VALUE *val)
>> +{
>> +    struct whpx_state *whpx =3D &whpx_global;
>> +    HRESULT hr;
>> +
>> +    hr =3D =
whp_dispatch.WHvGetVirtualProcessorRegisters(whpx->partition, =
WHV_ANY_VP,
>> +         &reg, 1, val);
>> +
>> +    if (FAILED(hr)) {
>> +        error_report("WHPX: Failed to get register %08x, hr=3D%08lx", =
reg, hr);
>> +    }
>> +}
>> +
>> +static void whpx_set_global_reg(WHV_REGISTER_NAME reg, =
WHV_REGISTER_VALUE val)
>> +{
>> +    struct whpx_state *whpx =3D &whpx_global;
>> +    HRESULT hr;
>> +    hr =3D =
whp_dispatch.WHvSetVirtualProcessorRegisters(whpx->partition, =
WHV_ANY_VP,
>> +         &reg, 1, &val);
>> +
>> +    if (FAILED(hr)) {
>> +        error_report("WHPX: Failed to set register %08x, hr=3D%08lx", =
reg, hr);
>> +    }
>> +}
>> +
>> +static uint64_t whpx_get_gp_reg(CPUState *cpu, int rt)
>> +{
>> +    assert(rt <=3D 31);
>> +    if (rt =3D=3D 31) {
>> +        return 0;
>> +    }
>> +    WHV_REGISTER_NAME reg =3D WHvArm64RegisterX0 + rt;
>> +    WHV_REGISTER_VALUE val;
>> +    whpx_get_reg(cpu, reg, &val);
>> +
>> +    return val.Reg64;
>> +}
>> +
>> +static void whpx_set_gp_reg(CPUState *cpu, int rt, uint64_t val)
>> +{
>> +    assert(rt < 31);
>> +    WHV_REGISTER_NAME reg =3D WHvArm64RegisterX0 + rt;
>> +    WHV_REGISTER_VALUE reg_val =3D {.Reg64 =3D val};
>> +
>> +    whpx_set_reg(cpu, reg, reg_val);
>> +}
>> +
>> +static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT =
*ctx)
>> +{
>> +    uint64_t syndrome =3D ctx->Syndrome;
>> +
>> +    bool isv =3D syndrome & ARM_EL_ISV;
>> +    bool iswrite =3D (syndrome >> 6) & 1;
>> +    bool sse =3D (syndrome >> 21) & 1;
>> +    uint32_t sas =3D (syndrome >> 22) & 3;
>> +    uint32_t len =3D 1 << sas;
>> +    uint32_t srt =3D (syndrome >> 16) & 0x1f;
>> +    uint32_t cm =3D (syndrome >> 8) & 0x1;
>> +    uint64_t val =3D 0;
>> +
>> +    assert(!cm);
>> +    assert(isv);
>> +
>> +    if (iswrite) {
>> +        val =3D whpx_get_gp_reg(cpu, srt);
>> +        address_space_write(&address_space_memory,
>> +                            ctx->Gpa,
>> +                            MEMTXATTRS_UNSPECIFIED, &val, len);
>> +    } else {
>> +        address_space_read(&address_space_memory,
>> +                           ctx->Gpa,
>> +                           MEMTXATTRS_UNSPECIFIED, &val, len);
>> +        if (sse) {
>> +            val =3D sextract64(val, 0, len * 8);
>> +        }
>> +        whpx_set_gp_reg(cpu, srt, val);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void whpx_psci_cpu_off(ARMCPU *arm_cpu)
>> +{
>> +    int32_t ret =3D arm_set_cpu_off(arm_cpu_mp_affinity(arm_cpu));
>> +    assert(ret =3D=3D QEMU_ARM_POWERCTL_RET_SUCCESS);
>> +}
>> +
>> +int whpx_vcpu_run(CPUState *cpu)
>> +{
>> +    HRESULT hr;
>> +    struct whpx_state *whpx =3D &whpx_global;
>> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
>> +    AccelCPUState *vcpu =3D cpu->accel;
>> +    int ret;
>> +
>> +
>> +    g_assert(bql_locked());
>> +
>> +    if (whpx->running_cpus++ =3D=3D 0) {
>> +        ret =3D whpx_first_vcpu_starting(cpu);
>> +        if (ret !=3D 0) {
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    bql_unlock();
>> +
>> +
>> +    cpu_exec_start(cpu);
>> +    do {
>> +        bool advance_pc =3D false;
>> +        if (cpu->vcpu_dirty) {
>> +            whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
>> +            cpu->vcpu_dirty =3D false;
>> +        }
>> +
>> +        if (qatomic_read(&cpu->exit_request)) {
>> +            whpx_vcpu_kick(cpu);
>> +        }
>> +
>> +        hr =3D whp_dispatch.WHvRunVirtualProcessor(
>> +            whpx->partition, cpu->cpu_index,
>> +            &vcpu->exit_ctx, sizeof(vcpu->exit_ctx));
>> +
>> +        if (FAILED(hr)) {
>> +            error_report("WHPX: Failed to exec a virtual processor,"
>> +                         " hr=3D%08lx", hr);
>> +            ret =3D -1;
>> +            break;
>> +        }
>> +
>> +        switch (vcpu->exit_ctx.ExitReason) {
>> +        case WHvRunVpExitReasonGpaIntercept:
>> +        case WHvRunVpExitReasonUnmappedGpa:
>> +            advance_pc =3D true;
>> +
>> +            if (vcpu->exit_ctx.MemoryAccess.Syndrome & BIT(8)) {
>> +                error_report("WHPX: cached access to unmapped =
memory"
>> +                "Pc =3D 0x%llx Gva =3D 0x%llx Gpa =3D 0x%llx",
>> +                vcpu->exit_ctx.MemoryAccess.Header.Pc,
>> +                vcpu->exit_ctx.MemoryAccess.Gpa,
>> +                vcpu->exit_ctx.MemoryAccess.Gva);
>> +                break;
>> +            }
>> +
>> +            ret =3D whpx_handle_mmio(cpu, =
&vcpu->exit_ctx.MemoryAccess);
>> +            break;
>> +        case WHvRunVpExitReasonCanceled:
>> +            cpu->exception_index =3D EXCP_INTERRUPT;
>> +            ret =3D 1;
>> +            break;
>> +        case WHvRunVpExitReasonArm64Reset:
>> +            switch (vcpu->exit_ctx.Arm64Reset.ResetType) {
>> +            case WHvArm64ResetTypePowerOff:
>> +                =
qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>> +                break;
>> +            case WHvArm64ResetTypeReboot:
>> +                =
qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>> +                break;
>> +            default:
>> +                g_assert_not_reached();
>> +            }
>> +            bql_lock();
>> +            if (arm_cpu->power_state !=3D PSCI_OFF) {
>> +                whpx_psci_cpu_off(arm_cpu);
>> +            }
>> +            bql_unlock();
>> +            break;
>> +        case WHvRunVpExitReasonNone:
>> +        case WHvRunVpExitReasonUnrecoverableException:
>> +        case WHvRunVpExitReasonInvalidVpRegisterValue:
>> +        case WHvRunVpExitReasonUnsupportedFeature:
>> +        default:
>> +            error_report("WHPX: Unexpected VP exit code 0x%08x",
>> +                         vcpu->exit_ctx.ExitReason);
>> +            whpx_get_registers(cpu);
>> +            bql_lock();
>> +            qemu_system_guest_panicked(cpu_get_crash_info(cpu));
>> +            bql_unlock();
>> +            break;
>> +        }
>> +        if (advance_pc) {
>> +            WHV_REGISTER_VALUE pc;
>> +
>> +            flush_cpu_state(cpu);
>> +            pc.Reg64 =3D vcpu->exit_ctx.MemoryAccess.Header.Pc + 4;
>> +            whpx_set_reg(cpu, WHvArm64RegisterPc, pc);
>> +        }
>> +    } while (!ret);
>> +
>> +    cpu_exec_end(cpu);
>> +
>> +    bql_lock();
>> +    current_cpu =3D cpu;
>> +
>> +    if (--whpx->running_cpus =3D=3D 0) {
>> +        whpx_last_vcpu_stopping(cpu);
>> +    }
>> +
>> +    qatomic_set(&cpu->exit_request, false);
>> +
>> +    return ret < 0;
>> +}
>> +
>> +static void clean_whv_register_value(WHV_REGISTER_VALUE *val)
>> +{
>> +    memset(val, 0, sizeof(WHV_REGISTER_VALUE));
>> +}
>> +
>> +void whpx_get_registers(CPUState *cpu)
>> +{
>> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
>> +    CPUARMState *env =3D &arm_cpu->env;
>> +    WHV_REGISTER_VALUE val;
>> +    int i;
>> +
>> +    for (i =3D 0; i < ARRAY_SIZE(whpx_reg_match); i++) {
>> +        whpx_get_reg(cpu, whpx_reg_match[i].reg, &val);
>> +        *(uint64_t *)((char *)env + whpx_reg_match[i].offset) =3D =
val.Reg64;
>> +    }
>> +
>> +    for (i =3D 0; i < ARRAY_SIZE(whpx_fpreg_match); i++) {
>> +        whpx_get_reg(cpu, whpx_reg_match[i].reg, &val);
>> +        memcpy((char *)env + whpx_fpreg_match[i].offset, &val, =
sizeof(val.Reg128));
>> +    }
>> +
>> +    whpx_get_reg(cpu, WHvArm64RegisterPc, &val);
>> +    env->pc =3D val.Reg64;
>> +
>> +    whpx_get_reg(cpu, WHvArm64RegisterFpcr, &val);
>> +    vfp_set_fpcr(env, val.Reg32);
>> +
>> +    whpx_get_reg(cpu, WHvArm64RegisterFpsr, &val);
>> +    vfp_set_fpsr(env, val.Reg32);
>> +
>> +    whpx_get_reg(cpu, WHvArm64RegisterPstate, &val);
>> +    pstate_write(env, val.Reg32);
>> +
>> +    for (i =3D 0; i < ARRAY_SIZE(whpx_sreg_match); i++) {
>> +        if (whpx_sreg_match[i].cp_idx =3D=3D -1) {
>> +            continue;
>> +        }
>> +
>> +        if (whpx_sreg_match[i].global) {
>> +            /* WHP disallows us from accessing global regs as a vCPU =
*/
>> +            whpx_get_global_reg(whpx_sreg_match[i].reg, &val);
>> +        } else {
>> +            whpx_get_reg(cpu, whpx_sreg_match[i].reg, &val);
>> +        }
>> +        arm_cpu->cpreg_values[whpx_sreg_match[i].cp_idx] =3D =
val.Reg64;
>> +    }
>> +
>> +    assert(write_list_to_cpustate(arm_cpu));
>> +    aarch64_restore_sp(env, arm_current_el(env));
>> +}
>> +
>> +void whpx_set_registers(CPUState *cpu, int level)
>> +{
>> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
>> +    CPUARMState *env =3D &arm_cpu->env;
>> +    WHV_REGISTER_VALUE val;
>> +    clean_whv_register_value(&val);
>> +    int i;
>> +
>> +    assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
>> +
>> +    for (i =3D 0; i < ARRAY_SIZE(whpx_reg_match); i++) {
>> +        val.Reg64 =3D *(uint64_t *)((char *)env + =
whpx_reg_match[i].offset);
>> +        whpx_set_reg(cpu, whpx_reg_match[i].reg, val);
>> +    }
>> +
>> +    for (i =3D 0; i < ARRAY_SIZE(whpx_fpreg_match); i++) {
>> +        memcpy(&val.Reg128, (char *)env + =
whpx_fpreg_match[i].offset, sizeof(val.Reg128));
>> +        whpx_set_reg(cpu, whpx_reg_match[i].reg, val);
>> +    }
>> +
>> +    clean_whv_register_value(&val);
>> +    val.Reg64 =3D env->pc;
>> +    whpx_set_reg(cpu, WHvArm64RegisterPc, val);
>> +
>> +    clean_whv_register_value(&val);
>> +    val.Reg32 =3D vfp_get_fpcr(env);
>> +    whpx_set_reg(cpu, WHvArm64RegisterFpcr, val);
>> +    val.Reg32 =3D vfp_get_fpsr(env);
>> +    whpx_set_reg(cpu, WHvArm64RegisterFpsr, val);
>> +    val.Reg32 =3D pstate_read(env);
>> +    whpx_set_reg(cpu, WHvArm64RegisterPstate, val);
>> +
>> +    aarch64_save_sp(env, arm_current_el(env));
>> +
>> +    assert(write_cpustate_to_list(arm_cpu, false));
>> +
>> +    /* Currently set global regs every time. */
>> +    for (i =3D 0; i < ARRAY_SIZE(whpx_sreg_match); i++) {
>> +        if (whpx_sreg_match[i].cp_idx =3D=3D -1) {
>> +            continue;
>> +        }
>> +
>> +        val.Reg64 =3D =
arm_cpu->cpreg_values[whpx_sreg_match[i].cp_idx];
>> +        if (whpx_sreg_match[i].global) {
>> +            /* WHP disallows us from accessing global regs as a vCPU =
*/
>> +            whpx_set_global_reg(whpx_sreg_match[i].reg, val);
>> +        } else {
>> +            whpx_set_reg(cpu, whpx_sreg_match[i].reg, val);
>> +        }
>> +    }
>> +}
>> +
>> +static uint32_t max_vcpu_index;
>> +
>> +static void whpx_cpu_update_state(void *opaque, bool running, =
RunState state)
>> +{
>> +}
>> +
>> +int whpx_init_vcpu(CPUState *cpu)
>> +{
>> +    HRESULT hr;
>> +    struct whpx_state *whpx =3D &whpx_global;
>> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
>> +    CPUARMState *env =3D &arm_cpu->env;
>> +    int ret;
>> +
>> +    uint32_t sregs_match_len =3D ARRAY_SIZE(whpx_sreg_match);
>> +    uint32_t sregs_cnt =3D 0;
>> +    WHV_REGISTER_VALUE val;
>> +    int i;
>> +
>> +    hr =3D whp_dispatch.WHvCreateVirtualProcessor(
>> +        whpx->partition, cpu->cpu_index, 0);
>> +    if (FAILED(hr)) {
>> +        error_report("WHPX: Failed to create a virtual processor,"
>> +                     " hr=3D%08lx", hr);
>> +        ret =3D -EINVAL;
>> +        goto error;
>=20
> Simpler: return -EINVAL;

Thanks, allowed to get rid of the goto error later as this was the only =
user of it.
>> +    }
>> +
>> +    /* Assumption that CNTFRQ_EL0 is the same between the VMM and =
the partition. */
>> +    asm volatile("mrs %0, cntfrq_el0" : =
"=3Dr"(arm_cpu->gt_cntfrq_hz));
>> +
>> +    cpu->vcpu_dirty =3D true;
>> +    cpu->accel =3D g_new0(AccelCPUState, 1);
>> +    max_vcpu_index =3D MAX(max_vcpu_index, cpu->cpu_index);
>> +    qemu_add_vm_change_state_handler(whpx_cpu_update_state, env);
>> +
>> +    env->aarch64 =3D true;
>> +
>> +    /* Allocate enough space for our sysreg sync */
>> +    arm_cpu->cpreg_indexes =3D g_renew(uint64_t, =
arm_cpu->cpreg_indexes,
>> +                                     sregs_match_len);
>> +    arm_cpu->cpreg_values =3D g_renew(uint64_t, =
arm_cpu->cpreg_values,
>> +                                    sregs_match_len);
>> +    arm_cpu->cpreg_vmstate_indexes =3D g_renew(uint64_t,
>> +                                             =
arm_cpu->cpreg_vmstate_indexes,
>> +                                             sregs_match_len);
>> +    arm_cpu->cpreg_vmstate_values =3D g_renew(uint64_t,
>> +                                            =
arm_cpu->cpreg_vmstate_values,
>> +                                            sregs_match_len);
>> +
>> +    memset(arm_cpu->cpreg_values, 0, sregs_match_len * =
sizeof(uint64_t));
>> +
>> +    /* Populate cp list for all known sysregs */
>> +    for (i =3D 0; i < sregs_match_len; i++) {
>> +        const ARMCPRegInfo *ri;
>> +        uint32_t key =3D whpx_sreg_match[i].key;
>> +
>> +        ri =3D get_arm_cp_reginfo(arm_cpu->cp_regs, key);
>> +        if (ri) {
>> +            assert(!(ri->type & ARM_CP_NO_RAW));
>> +            whpx_sreg_match[i].cp_idx =3D sregs_cnt;
>> +            arm_cpu->cpreg_indexes[sregs_cnt++] =3D =
cpreg_to_kvm_id(key);
>> +        } else {
>> +            whpx_sreg_match[i].cp_idx =3D -1;
>> +        }
>> +    }
>> +    arm_cpu->cpreg_array_len =3D sregs_cnt;
>> +    arm_cpu->cpreg_vmstate_array_len =3D sregs_cnt;
>> +
>> +    assert(write_cpustate_to_list(arm_cpu, false));
>> +
>> +    /* Set CP_NO_RAW system registers on init */
>> +    val.Reg64 =3D arm_cpu->midr;
>> +    whpx_set_reg(cpu, WHvArm64RegisterMidrEl1,
>> +                              val);
>> +
>> +    clean_whv_register_value(&val);
>> +
>> +    val.Reg64 =3D deposit64(arm_cpu->mp_affinity, 31, 1, 1 /* RES1 =
*/);
>> +    whpx_set_reg(cpu, WHvArm64RegisterMpidrEl1, val);
>> +
>> +    return 0;
>> +
>> +error:
>> +    return ret;
>> +}
>> +
>> +void whpx_cpu_instance_init(CPUState *cs)
>> +{
>> +}
>> +
>> +int whpx_accel_init(AccelState *as, MachineState *ms)
>> +{
>> +    struct whpx_state *whpx;
>> +    int ret;
>> +    HRESULT hr;
>> +    WHV_CAPABILITY whpx_cap;
>> +    UINT32 whpx_cap_size;
>> +    WHV_PARTITION_PROPERTY prop;
>> +    WHV_CAPABILITY_FEATURES features;
>> +
>> +    whpx =3D &whpx_global;
>> +    /* on arm64 Windows Hypervisor Platform, vGICv3 always used */
>> +    whpx_irqchip_in_kernel =3D true;
>> +
>> +    if (!init_whp_dispatch()) {
>> +        ret =3D -ENOSYS;
>> +        goto error;
>> +    }
>> +
>> +    whpx->mem_quota =3D ms->ram_size;
>> +
>> +    hr =3D whp_dispatch.WHvGetCapability(
>> +        WHvCapabilityCodeHypervisorPresent, &whpx_cap,
>> +        sizeof(whpx_cap), &whpx_cap_size);
>> +    if (FAILED(hr) || !whpx_cap.HypervisorPresent) {
>> +        error_report("WHPX: No accelerator found, hr=3D%08lx", hr);
>> +        ret =3D -ENOSPC;
>> +        goto error;
>> +    }
>> +
>> +    memset(&features, 0, sizeof(features));
>> +    hr =3D whp_dispatch.WHvGetCapability(
>> +        WHvCapabilityCodeFeatures, &features, sizeof(features), =
NULL);
>> +    if (FAILED(hr)) {
>> +        error_report("WHPX: Failed to query capabilities, hr=3D%08lx",=
 hr);
>> +        ret =3D -EINVAL;
>> +        goto error;
>> +    }
>> +
>> +    if (!features.Arm64Support) {
>> +        error_report("WHPX: host OS exposing pre-release WHPX =
implementation. "
>> +            "Please update your operating system to at least build =
26100.3915");
>> +        ret =3D -EINVAL;
>> +        goto error;
>> +    }
>> +
>> +    hr =3D whp_dispatch.WHvCreatePartition(&whpx->partition);
>> +    if (FAILED(hr)) {
>> +        error_report("WHPX: Failed to create partition, hr=3D%08lx", =
hr);
>> +        ret =3D -EINVAL;
>> +        goto error;
>> +    }
>> +
>> +    memset(&prop, 0, sizeof(prop));
>> +    prop.ProcessorCount =3D ms->smp.cpus;
>> +    hr =3D whp_dispatch.WHvSetPartitionProperty(
>> +        whpx->partition,
>> +        WHvPartitionPropertyCodeProcessorCount,
>> +        &prop,
>> +        sizeof(prop));
>> +
>> +    if (FAILED(hr)) {
>> +        error_report("WHPX: Failed to set partition processor count =
to %u,"
>> +                     " hr=3D%08lx", prop.ProcessorCount, hr);
>> +        ret =3D -EINVAL;
>> +        goto error;
>> +    }
>> +
>> +    if (!whpx->kernel_irqchip_allowed) {
>> +        error_report("WHPX: on Arm, only kernel-irqchip=3Don is =
currently supported");
>> +        ret =3D -EINVAL;
>> +        goto error;
>> +    }
>> +
>> +    memset(&prop, 0, sizeof(prop));
>> +
>> +    hr =3D whp_dispatch.WHvSetupPartition(whpx->partition);
>> +    if (FAILED(hr)) {
>> +        error_report("WHPX: Failed to setup partition, hr=3D%08lx", =
hr);
>> +        ret =3D -EINVAL;
>> +        goto error;
>> +    }
>> +
>> +    whpx_memory_init();
>> +
>> +    return 0;
>> +
>> +error:
>> +    if (whpx->partition !=3D NULL) {
>> +        whp_dispatch.WHvDeletePartition(whpx->partition);
>> +        whpx->partition =3D NULL;
>> +    }
>> +
>> +    return ret;
>> +}


--Apple-Mail=_103B3248-7813-4D13-8DEC-F7B535F809FF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dus-ascii"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 15. Jan 2026, at 07:18, Akihiko Odaki =
&lt;odaki@rsg.ci.i.u-tokyo.ac.jp&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On 2026/01/15 9:14, Mohamed Mediouni =
wrote:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;">Signed-off-by: Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt;<br>---<br>&nbsp;accel/whpx/whpx-common.c =
&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 +<br>&nbsp;target/arm/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 =
+<br>&nbsp;target/arm/whpx/meson.build | &nbsp;&nbsp;3 =
+<br>&nbsp;target/arm/whpx/whpx-all.c &nbsp;| 815 =
++++++++++++++++++++++++++++++++++++<br>&nbsp;4 files changed, 820 =
insertions(+)<br>&nbsp;create mode 100644 =
target/arm/whpx/meson.build<br>&nbsp;create mode 100644 =
target/arm/whpx/whpx-all.c<br>diff --git a/accel/whpx/whpx-common.c =
b/accel/whpx/whpx-common.c<br>index 05f9e520b7..827f50f3e0 100644<br>--- =
a/accel/whpx/whpx-common.c<br>+++ b/accel/whpx/whpx-common.c<br>@@ -12,6 =
+12,7 @@<br>&nbsp;#include "gdbstub/helpers.h"<br>&nbsp;#include =
"qemu/accel.h"<br>&nbsp;#include "accel/accel-ops.h"<br>+#include =
"system/memory.h"<br>&nbsp;#include "system/whpx.h"<br>&nbsp;#include =
"system/cpus.h"<br>&nbsp;#include "system/runstate.h"<br>diff --git =
a/target/arm/meson.build b/target/arm/meson.build<br>index =
462c71148d..ce155ba9b4 100644<br>--- a/target/arm/meson.build<br>+++ =
b/target/arm/meson.build<br>@@ -59,6 +59,7 @@ =
arm_common_system_ss.add(files(<br>&nbsp;))<br>&nbsp;&nbsp;&nbsp;subdir('h=
vf')<br>+subdir('whpx')<br>&nbsp;&nbsp;&nbsp;if 'CONFIG_TCG' in =
config_all_accel<br>&nbsp;&nbsp;&nbsp;&nbsp;subdir('tcg')<br>diff --git =
a/target/arm/whpx/meson.build b/target/arm/whpx/meson.build<br>new file =
mode 100644<br>index 0000000000..1de2ef0283<br>--- /dev/null<br>+++ =
b/target/arm/whpx/meson.build<br>@@ -0,0 +1,3 =
@@<br>+arm_system_ss.add(when: 'CONFIG_WHPX', if_true: files(<br>+ =
&nbsp;'whpx-all.c',<br>+))<br>diff --git a/target/arm/whpx/whpx-all.c =
b/target/arm/whpx/whpx-all.c<br>new file mode 100644<br>index =
0000000000..62fda15597<br>--- /dev/null<br>+++ =
b/target/arm/whpx/whpx-all.c<br>@@ -0,0 +1,815 @@<br>+/* =
SPDX-License-Identifier: GPL-2.0-or-later */<br>+/*<br>+ * QEMU Windows =
Hypervisor Platform accelerator (WHPX)<br>+ *<br>+ * Copyright (c) 2025 =
Mohamed Mediouni<br>+ *<br>+ */<br>+<br>+#include =
"qemu/osdep.h"<br>+#include "cpu.h"<br>+#include =
"system/address-spaces.h"<br>+#include "system/ioport.h"<br>+#include =
"gdbstub/helpers.h"<br>+#include "qemu/accel.h"<br>+#include =
"accel/accel-ops.h"<br>+#include "system/whpx.h"<br>+#include =
"system/cpus.h"<br>+#include "system/runstate.h"<br>+#include =
"qemu/main-loop.h"<br>+#include "hw/core/boards.h"<br>+#include =
"qemu/error-report.h"<br>+#include "qapi/error.h"<br>+#include =
"qapi/qapi-types-common.h"<br>+#include =
"qapi/qapi-visit-common.h"<br>+#include =
"migration/blocker.h"<br>+#include =
"accel/accel-cpu-target.h"<br>+#include =
&lt;winerror.h&gt;<br>+<br>+#include "syndrome.h"<br>+#include =
"cpu.h"<br>+#include "target/arm/cpregs.h"<br>+#include =
"internals.h"<br>+<br>+#include "system/whpx-internal.h"<br>+#include =
"system/whpx-accel-ops.h"<br>+#include "system/whpx-all.h"<br>+#include =
"system/whpx-common.h"<br>+#include "hw/arm/bsa.h"<br>+#include =
"arm-powerctl.h"<br>+<br>+#include &lt;winhvplatform.h&gt;<br>+#include =
&lt;winhvplatformdefs.h&gt;<br>+<br>+struct whpx_reg_match {<br>+ =
&nbsp;&nbsp;&nbsp;WHV_REGISTER_NAME reg;<br>+ &nbsp;&nbsp;&nbsp;uint64_t =
offset;<br>+};<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">As per docs/devel/style.rst, this should =
be:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">typedef struct WHPXRegMatch {</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&nbsp;&nbsp;&nbsp;WHV_REGISTER_NAME =
reg;</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&nbsp;&nbsp;&nbsp;uint64_t =
offset;</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">} WHPXRegMatch;</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"></div></blockquote><div>Hello,</div><div><br></div>Applied the =
change to this for the next rev. Do you have tips on how to automate =
this</div><div>(inherited this from the HVF code style as are a lot of =
your other reviews in this series really)</div><div><br></div><div>Thank =
you,</div><div>-Mohamed<br><blockquote type=3D"cite"><div><blockquote =
type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;">+<br>+static const struct whpx_reg_match whpx_reg_match[] =3D =
{<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterX0, =
&nbsp;&nbsp;offsetof(CPUARMState, xregs[0]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterX1, &nbsp;&nbsp;offsetof(CPUARMState, xregs[1]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterX2, =
&nbsp;&nbsp;offsetof(CPUARMState, xregs[2]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterX3, &nbsp;&nbsp;offsetof(CPUARMState, xregs[3]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterX4, =
&nbsp;&nbsp;offsetof(CPUARMState, xregs[4]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterX5, &nbsp;&nbsp;offsetof(CPUARMState, xregs[5]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterX6, =
&nbsp;&nbsp;offsetof(CPUARMState, xregs[6]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterX7, &nbsp;&nbsp;offsetof(CPUARMState, xregs[7]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterX8, =
&nbsp;&nbsp;offsetof(CPUARMState, xregs[8]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterX9, &nbsp;&nbsp;offsetof(CPUARMState, xregs[9]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterX10, &nbsp;offsetof(CPUARMState, =
xregs[10]) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterX11, =
&nbsp;offsetof(CPUARMState, xregs[11]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterX12, &nbsp;offsetof(CPUARMState, xregs[12]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterX13, &nbsp;offsetof(CPUARMState, =
xregs[13]) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterX14, =
&nbsp;offsetof(CPUARMState, xregs[14]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterX15, &nbsp;offsetof(CPUARMState, xregs[15]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterX16, &nbsp;offsetof(CPUARMState, =
xregs[16]) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterX17, =
&nbsp;offsetof(CPUARMState, xregs[17]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterX18, &nbsp;offsetof(CPUARMState, xregs[18]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterX19, &nbsp;offsetof(CPUARMState, =
xregs[19]) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterX20, =
&nbsp;offsetof(CPUARMState, xregs[20]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterX21, &nbsp;offsetof(CPUARMState, xregs[21]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterX22, &nbsp;offsetof(CPUARMState, =
xregs[22]) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterX23, =
&nbsp;offsetof(CPUARMState, xregs[23]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterX24, &nbsp;offsetof(CPUARMState, xregs[24]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterX25, &nbsp;offsetof(CPUARMState, =
xregs[25]) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterX26, =
&nbsp;offsetof(CPUARMState, xregs[26]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterX27, &nbsp;offsetof(CPUARMState, xregs[27]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterX28, &nbsp;offsetof(CPUARMState, =
xregs[28]) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterFp, =
&nbsp;&nbsp;offsetof(CPUARMState, xregs[29]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterLr, &nbsp;&nbsp;offsetof(CPUARMState, xregs[30]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterPc, =
&nbsp;&nbsp;offsetof(CPUARMState, pc) },<br>+};<br>+<br>+static const =
struct whpx_reg_match whpx_fpreg_match[] =3D {<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterQ0, &nbsp;offsetof(CPUARMState, vfp.zregs[0]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ1, &nbsp;offsetof(CPUARMState, =
vfp.zregs[1]) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ2, =
&nbsp;offsetof(CPUARMState, vfp.zregs[2]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterQ3, &nbsp;offsetof(CPUARMState, vfp.zregs[3]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ4, &nbsp;offsetof(CPUARMState, =
vfp.zregs[4]) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ5, =
&nbsp;offsetof(CPUARMState, vfp.zregs[5]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterQ6, &nbsp;offsetof(CPUARMState, vfp.zregs[6]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ7, &nbsp;offsetof(CPUARMState, =
vfp.zregs[7]) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ8, =
&nbsp;offsetof(CPUARMState, vfp.zregs[8]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterQ9, &nbsp;offsetof(CPUARMState, vfp.zregs[9]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ10, offsetof(CPUARMState, =
vfp.zregs[10]) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ11, =
offsetof(CPUARMState, vfp.zregs[11]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterQ12, offsetof(CPUARMState, vfp.zregs[12]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ13, offsetof(CPUARMState, =
vfp.zregs[13]) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ14, =
offsetof(CPUARMState, vfp.zregs[14]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterQ15, offsetof(CPUARMState, vfp.zregs[15]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ16, offsetof(CPUARMState, =
vfp.zregs[16]) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ17, =
offsetof(CPUARMState, vfp.zregs[17]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterQ18, offsetof(CPUARMState, vfp.zregs[18]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ19, offsetof(CPUARMState, =
vfp.zregs[19]) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ20, =
offsetof(CPUARMState, vfp.zregs[20]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterQ21, offsetof(CPUARMState, vfp.zregs[21]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ22, offsetof(CPUARMState, =
vfp.zregs[22]) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ23, =
offsetof(CPUARMState, vfp.zregs[23]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterQ24, offsetof(CPUARMState, vfp.zregs[24]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ25, offsetof(CPUARMState, =
vfp.zregs[25]) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ26, =
offsetof(CPUARMState, vfp.zregs[26]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterQ27, offsetof(CPUARMState, vfp.zregs[27]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ28, offsetof(CPUARMState, =
vfp.zregs[28]) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ29, =
offsetof(CPUARMState, vfp.zregs[29]) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterQ30, offsetof(CPUARMState, vfp.zregs[30]) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterQ31, offsetof(CPUARMState, =
vfp.zregs[31]) },<br>+};<br>+<br>+struct whpx_sreg_match {<br>+ =
&nbsp;&nbsp;&nbsp;WHV_REGISTER_NAME reg;<br>+ &nbsp;&nbsp;&nbsp;uint32_t =
key;<br>+ &nbsp;&nbsp;&nbsp;bool global;<br>+ &nbsp;&nbsp;&nbsp;uint32_t =
cp_idx;<br>+};<br>+<br>+static struct whpx_sreg_match whpx_sreg_match[] =
=3D {<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr0El1, =
ENCODE_AA64_CP_REG(0, 0, 2, 0, 4) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 5) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 0, =
2, 0, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr0El1, =
ENCODE_AA64_CP_REG(0, 0, 2, 0, 7) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 4) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 1, =
2, 0, 5) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr0El1, =
ENCODE_AA64_CP_REG(0, 1, 2, 0, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 7) =
},<br>+<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr2El1, =
ENCODE_AA64_CP_REG(0, 2, 2, 0, 4) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 5) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr2El1, ENCODE_AA64_CP_REG(0, 2, =
2, 0, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr2El1, =
ENCODE_AA64_CP_REG(0, 2, 2, 0, 7) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 4) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr3El1, ENCODE_AA64_CP_REG(0, 3, =
2, 0, 5) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr3El1, =
ENCODE_AA64_CP_REG(0, 3, 2, 0, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 7) =
},<br>+<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr4El1, =
ENCODE_AA64_CP_REG(0, 4, 2, 0, 4) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 5) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr4El1, ENCODE_AA64_CP_REG(0, 4, =
2, 0, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr4El1, =
ENCODE_AA64_CP_REG(0, 4, 2, 0, 7) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 4) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr5El1, ENCODE_AA64_CP_REG(0, 5, =
2, 0, 5) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr5El1, =
ENCODE_AA64_CP_REG(0, 5, 2, 0, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 7) =
},<br>+<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr6El1, =
ENCODE_AA64_CP_REG(0, 6, 2, 0, 4) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 5) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr6El1, ENCODE_AA64_CP_REG(0, 6, =
2, 0, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr6El1, =
ENCODE_AA64_CP_REG(0, 6, 2, 0, 7) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 4) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr7El1, ENCODE_AA64_CP_REG(0, 7, =
2, 0, 5) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr7El1, =
ENCODE_AA64_CP_REG(0, 7, 2, 0, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 7) =
},<br>+<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr8El1, =
ENCODE_AA64_CP_REG(0, 8, 2, 0, 4) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 5) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr8El1, ENCODE_AA64_CP_REG(0, 8, =
2, 0, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr8El1, =
ENCODE_AA64_CP_REG(0, 8, 2, 0, 7) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 4) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr9El1, ENCODE_AA64_CP_REG(0, 9, =
2, 0, 5) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr9El1, =
ENCODE_AA64_CP_REG(0, 9, 2, 0, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 7) =
},<br>+<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr10El1, =
ENCODE_AA64_CP_REG(0, 10, 2, 0, 4) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 5) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr10El1, ENCODE_AA64_CP_REG(0, =
10, 2, 0, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr10El1, =
ENCODE_AA64_CP_REG(0, 10, 2, 0, 7) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 4) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr11El1, ENCODE_AA64_CP_REG(0, =
11, 2, 0, 5) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr11El1, =
ENCODE_AA64_CP_REG(0, 11, 2, 0, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 7) =
},<br>+<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr12El1, =
ENCODE_AA64_CP_REG(0, 12, 2, 0, 4) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 5) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr12El1, ENCODE_AA64_CP_REG(0, =
12, 2, 0, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr12El1, =
ENCODE_AA64_CP_REG(0, 12, 2, 0, 7) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 4) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr13El1, ENCODE_AA64_CP_REG(0, =
13, 2, 0, 5) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr13El1, =
ENCODE_AA64_CP_REG(0, 13, 2, 0, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 7) =
},<br>+<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr14El1, =
ENCODE_AA64_CP_REG(0, 14, 2, 0, 4) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 5) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr14El1, ENCODE_AA64_CP_REG(0, =
14, 2, 0, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr14El1, =
ENCODE_AA64_CP_REG(0, 14, 2, 0, 7) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 4) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr15El1, ENCODE_AA64_CP_REG(0, =
15, 2, 0, 5) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr15El1, =
ENCODE_AA64_CP_REG(0, 15, 2, 0, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 7) =
},<br>+#ifdef SYNC_NO_RAW_REGS<br>+ &nbsp;&nbsp;&nbsp;/*<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;* The registers below are manually synced on =
init because they are<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* marked as NO_RAW. =
We still list them to make number space sync easier.<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;*/<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterMidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 0) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(0, 0, =
3, 0, 5) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterIdPfr0El1, =
ENCODE_AA64_CP_REG(0, 4, 3, 0, 0) },<br>+#endif<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 1), true =
},<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterIdAa64Dfr0El1, =
ENCODE_AA64_CP_REG(0, 5, 3, 0, 0), true },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 1), true =
},<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterIdAa64Isar0El1, =
ENCODE_AA64_CP_REG(0, 6, 3, 0, 0), true },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterIdAa64Isar1El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, 1), true =
},<br>+#ifdef SYNC_NO_MMFR0<br>+ &nbsp;&nbsp;&nbsp;/* We keep the =
hardware MMFR0 around. HW limits are there anyway */<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterIdAa64Mmfr0El1, =
ENCODE_AA64_CP_REG(0, 7, 3, 0, 0) },<br>+#endif<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 1), true =
},<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterIdAa64Mmfr2El1, =
ENCODE_AA64_CP_REG(0, 7, 3, 0, 2), true },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 3), true =
},<br>+<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterMdscrEl1, =
ENCODE_AA64_CP_REG(0, 2, 2, 0, 2) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 0) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterCpacrEl1, ENCODE_AA64_CP_REG(1, 0, =
3, 0, 2) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterTtbr0El1, =
ENCODE_AA64_CP_REG(2, 0, 3, 0, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterTtbr1El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 1) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterTcrEl1, ENCODE_AA64_CP_REG(2, 0, 3, =
0, 2) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApiAKeyLoEl1, =
ENCODE_AA64_CP_REG(2, 1, 3, 0, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterApiAKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 1) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApiBKeyLoEl1, ENCODE_AA64_CP_REG(2, =
1, 3, 0, 2) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApiBKeyHiEl1, =
ENCODE_AA64_CP_REG(2, 1, 3, 0, 3) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterApdAKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 0) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApdAKeyHiEl1, ENCODE_AA64_CP_REG(2, =
2, 3, 0, 1) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApdBKeyLoEl1, =
ENCODE_AA64_CP_REG(2, 2, 3, 0, 2) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterApdBKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 3) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApgAKeyLoEl1, ENCODE_AA64_CP_REG(2, =
3, 3, 0, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApgAKeyHiEl1, =
ENCODE_AA64_CP_REG(2, 3, 3, 0, 1) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterSpsrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 0) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterElrEl1, ENCODE_AA64_CP_REG(4, 0, 3, =
0, 1) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterSpEl1, =
ENCODE_AA64_CP_REG(4, 1, 3, 0, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterEsrEl1, ENCODE_AA64_CP_REG(5, 2, 3, 0, 0) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterFarEl1, ENCODE_AA64_CP_REG(6, 0, 3, =
0, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterParEl1, =
ENCODE_AA64_CP_REG(7, 4, 3, 0, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterMairEl1, ENCODE_AA64_CP_REG(10, 2, 3, 0, 0) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterVbarEl1, ENCODE_AA64_CP_REG(12, 0, =
3, 0, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterContextidrEl1, =
ENCODE_AA64_CP_REG(13, 0, 3, 0, 1) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterTpidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, 4) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterCntkctlEl1, ENCODE_AA64_CP_REG(14, =
1, 3, 0, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterCsselrEl1, =
ENCODE_AA64_CP_REG(0, 0, 3, 2, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterTpidrEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 2) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterTpidrroEl0, ENCODE_AA64_CP_REG(13, =
0, 3, 3, 3) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterCntvCtlEl0, =
ENCODE_AA64_CP_REG(14, 3, 3, 3, 1) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterCntvCvalEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 2) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, =
4, 0) },<br>+};<br>+<br>+static void flush_cpu_state(CPUState =
*cpu)<br>+{<br>+ &nbsp;&nbsp;&nbsp;if (cpu-&gt;vcpu_dirty) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_set_registers(cpu, =
WHPX_SET_RUNTIME_STATE);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cpu-&gt;vcpu_dirty =3D =
false;<br>+ &nbsp;&nbsp;&nbsp;}<br>+}<br>+<br>+HRESULT =
whpx_set_exception_exit_bitmap(UINT64 exceptions)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;if (exceptions !=3D 0) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return E_NOTIMPL;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+ &nbsp;&nbsp;&nbsp;return =
ERROR_SUCCESS;<br>+}<br>+void whpx_apply_breakpoints(<br>+ =
&nbsp;&nbsp;&nbsp;struct whpx_breakpoint_collection *breakpoints,<br>+ =
&nbsp;&nbsp;&nbsp;CPUState *cpu,<br>+ &nbsp;&nbsp;&nbsp;bool =
resuming)<br>+{<br>+<br>+}<br>+void whpx_translate_cpu_breakpoints(<br>+ =
&nbsp;&nbsp;&nbsp;struct whpx_breakpoints *breakpoints,<br>+ =
&nbsp;&nbsp;&nbsp;CPUState *cpu,<br>+ &nbsp;&nbsp;&nbsp;int =
cpu_breakpoint_count)<br>+{<br>+<br>+}<br>+<br>+static void =
whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE* =
val)<br>+{<br>+ &nbsp;&nbsp;&nbsp;struct whpx_state *whpx =3D =
&amp;whpx_global;<br>+ &nbsp;&nbsp;&nbsp;HRESULT hr;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;flush_cpu_state(cpu);<br>+<br>+ &nbsp;&nbsp;&nbsp;hr =3D=
 whp_dispatch.WHvGetVirtualProcessorRegisters(whpx-&gt;partition, =
cpu-&gt;cpu_index,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;reg, 1, =
val);<br>+<br>+ &nbsp;&nbsp;&nbsp;if (FAILED(hr)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("WHPX: Failed to =
get register %08x, hr=3D%08lx", reg, hr);<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+}<br>+<br>+static void whpx_set_reg(CPUState =
*cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE val)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;struct whpx_state *whpx =3D &amp;whpx_global;<br>+ =
&nbsp;&nbsp;&nbsp;HRESULT hr;<br>+ &nbsp;&nbsp;&nbsp;hr =3D =
whp_dispatch.WHvSetVirtualProcessorRegisters(whpx-&gt;partition, =
cpu-&gt;cpu_index,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;reg, 1, =
&amp;val);<br>+<br>+ &nbsp;&nbsp;&nbsp;if (FAILED(hr)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("WHPX: Failed to =
set register %08x, hr=3D%08lx", reg, hr);<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+}<br>+<br>+static void =
whpx_get_global_reg(WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE =
*val)<br>+{<br>+ &nbsp;&nbsp;&nbsp;struct whpx_state *whpx =3D =
&amp;whpx_global;<br>+ &nbsp;&nbsp;&nbsp;HRESULT hr;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;hr =3D =
whp_dispatch.WHvGetVirtualProcessorRegisters(whpx-&gt;partition, =
WHV_ANY_VP,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;reg, 1, =
val);<br>+<br>+ &nbsp;&nbsp;&nbsp;if (FAILED(hr)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("WHPX: Failed to =
get register %08x, hr=3D%08lx", reg, hr);<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+}<br>+<br>+static void =
whpx_set_global_reg(WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE =
val)<br>+{<br>+ &nbsp;&nbsp;&nbsp;struct whpx_state *whpx =3D =
&amp;whpx_global;<br>+ &nbsp;&nbsp;&nbsp;HRESULT hr;<br>+ =
&nbsp;&nbsp;&nbsp;hr =3D =
whp_dispatch.WHvSetVirtualProcessorRegisters(whpx-&gt;partition, =
WHV_ANY_VP,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;reg, 1, =
&amp;val);<br>+<br>+ &nbsp;&nbsp;&nbsp;if (FAILED(hr)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("WHPX: Failed to =
set register %08x, hr=3D%08lx", reg, hr);<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+}<br>+<br>+static uint64_t =
whpx_get_gp_reg(CPUState *cpu, int rt)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;assert(rt &lt;=3D 31);<br>+ &nbsp;&nbsp;&nbsp;if (rt =
=3D=3D 31) {<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0;<br>+ &nbsp;&nbsp;&nbsp;}<br>+ &nbsp;&nbsp;&nbsp;WHV_REGISTER_NAME reg =
=3D WHvArm64RegisterX0 + rt;<br>+ &nbsp;&nbsp;&nbsp;WHV_REGISTER_VALUE =
val;<br>+ &nbsp;&nbsp;&nbsp;whpx_get_reg(cpu, reg, &amp;val);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;return val.Reg64;<br>+}<br>+<br>+static void =
whpx_set_gp_reg(CPUState *cpu, int rt, uint64_t val)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;assert(rt &lt; 31);<br>+ =
&nbsp;&nbsp;&nbsp;WHV_REGISTER_NAME reg =3D WHvArm64RegisterX0 + =
rt;<br>+ &nbsp;&nbsp;&nbsp;WHV_REGISTER_VALUE reg_val =3D {.Reg64 =3D =
val};<br>+<br>+ &nbsp;&nbsp;&nbsp;whpx_set_reg(cpu, reg, =
reg_val);<br>+}<br>+<br>+static int whpx_handle_mmio(CPUState *cpu, =
WHV_MEMORY_ACCESS_CONTEXT *ctx)<br>+{<br>+ &nbsp;&nbsp;&nbsp;uint64_t =
syndrome =3D ctx-&gt;Syndrome;<br>+<br>+ &nbsp;&nbsp;&nbsp;bool isv =3D =
syndrome &amp; ARM_EL_ISV;<br>+ &nbsp;&nbsp;&nbsp;bool iswrite =3D =
(syndrome &gt;&gt; 6) &amp; 1;<br>+ &nbsp;&nbsp;&nbsp;bool sse =3D =
(syndrome &gt;&gt; 21) &amp; 1;<br>+ &nbsp;&nbsp;&nbsp;uint32_t sas =3D =
(syndrome &gt;&gt; 22) &amp; 3;<br>+ &nbsp;&nbsp;&nbsp;uint32_t len =3D =
1 &lt;&lt; sas;<br>+ &nbsp;&nbsp;&nbsp;uint32_t srt =3D (syndrome =
&gt;&gt; 16) &amp; 0x1f;<br>+ &nbsp;&nbsp;&nbsp;uint32_t cm =3D =
(syndrome &gt;&gt; 8) &amp; 0x1;<br>+ &nbsp;&nbsp;&nbsp;uint64_t val =3D =
0;<br>+<br>+ &nbsp;&nbsp;&nbsp;assert(!cm);<br>+ =
&nbsp;&nbsp;&nbsp;assert(isv);<br>+<br>+ &nbsp;&nbsp;&nbsp;if (iswrite) =
{<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;val =3D =
whpx_get_gp_reg(cpu, srt);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;address_space_write(&amp;address=
_space_memory,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;ctx-&gt;Gpa,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;MEMTXATTRS_UNSPECIFIED, &amp;val, len);<br>+ =
&nbsp;&nbsp;&nbsp;} else {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;address_space_read(&amp;address_=
space_memory,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;ctx-&gt;Gpa,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;MEMTXATTRS_UNSPECIFIED, &amp;val, len);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (sse) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;val =3D =
sextract64(val, 0, len * 8);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_set_gp_reg(cpu, srt, =
val);<br>+ &nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;return =
0;<br>+}<br>+<br>+static void whpx_psci_cpu_off(ARMCPU =
*arm_cpu)<br>+{<br>+ &nbsp;&nbsp;&nbsp;int32_t ret =3D =
arm_set_cpu_off(arm_cpu_mp_affinity(arm_cpu));<br>+ =
&nbsp;&nbsp;&nbsp;assert(ret =3D=3D =
QEMU_ARM_POWERCTL_RET_SUCCESS);<br>+}<br>+<br>+int =
whpx_vcpu_run(CPUState *cpu)<br>+{<br>+ &nbsp;&nbsp;&nbsp;HRESULT =
hr;<br>+ &nbsp;&nbsp;&nbsp;struct whpx_state *whpx =3D =
&amp;whpx_global;<br>+ &nbsp;&nbsp;&nbsp;ARMCPU *arm_cpu =3D =
ARM_CPU(cpu);<br>+ &nbsp;&nbsp;&nbsp;AccelCPUState *vcpu =3D =
cpu-&gt;accel;<br>+ &nbsp;&nbsp;&nbsp;int ret;<br>+<br>+<br>+ =
&nbsp;&nbsp;&nbsp;g_assert(bql_locked());<br>+<br>+ &nbsp;&nbsp;&nbsp;if =
(whpx-&gt;running_cpus++ =3D=3D 0) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
whpx_first_vcpu_starting(cpu);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ret !=3D 0) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
ret;<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;bql_unlock();<br>+<br>+<br>+ =
&nbsp;&nbsp;&nbsp;cpu_exec_start(cpu);<br>+ &nbsp;&nbsp;&nbsp;do {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bool advance_pc =3D =
false;<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(cpu-&gt;vcpu_dirty) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_set=
_registers(cpu, WHPX_SET_RUNTIME_STATE);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cpu-&gt;=
vcpu_dirty =3D false;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(qatomic_read(&amp;cpu-&gt;exit_request)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_vcp=
u_kick(cpu);<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hr =3D =
whp_dispatch.WHvRunVirtualProcessor(<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx-&gt=
;partition, cpu-&gt;cpu_index,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;vcp=
u-&gt;exit_ctx, sizeof(vcpu-&gt;exit_ctx));<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (FAILED(hr)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_re=
port("WHPX: Failed to exec a virtual processor,"<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" =
hr=3D%08lx", hr);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
-1;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<b=
r>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;switch =
(vcpu-&gt;exit_ctx.ExitReason) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case =
WHvRunVpExitReasonGpaIntercept:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case =
WHvRunVpExitReasonUnmappedGpa:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;advance_=
pc =3D true;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(vcpu-&gt;exit_ctx.MemoryAccess.Syndrome &amp; BIT(8)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;error_report("WHPX: cached access to unmapped =
memory"<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;"Pc =3D 0x%llx Gva =3D 0x%llx Gpa =3D 0x%llx",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;vcpu-&gt;exit_ctx.MemoryAccess.Header.Pc,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;vcpu-&gt;exit_ctx.MemoryAccess.Gpa,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;vcpu-&gt;exit_ctx.MemoryAccess.Gva);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+<b=
r>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
whpx_handle_mmio(cpu, &amp;vcpu-&gt;exit_ctx.MemoryAccess);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<b=
r>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case =
WHvRunVpExitReasonCanceled:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cpu-&gt;=
exception_index =3D EXCP_INTERRUPT;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
1;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<b=
r>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case =
WHvRunVpExitReasonArm64Reset:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;switch =
(vcpu-&gt;exit_ctx.Arm64Reset.ResetType) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case =
WHvArm64ResetTypePowerOff:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN=
);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case =
WHvArm64ResetTypeReboot:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);<br>=
+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;default:=
<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;g_assert_not_reached();<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bql_lock=
();<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(arm_cpu-&gt;power_state !=3D PSCI_OFF) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;whpx_psci_cpu_off(arm_cpu);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bql_unlo=
ck();<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<b=
r>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case =
WHvRunVpExitReasonNone:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case =
WHvRunVpExitReasonUnrecoverableException:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case =
WHvRunVpExitReasonInvalidVpRegisterValue:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case =
WHvRunVpExitReasonUnsupportedFeature:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;default:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_re=
port("WHPX: Unexpected VP exit code 0x%08x",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vcpu=
-&gt;exit_ctx.ExitReason);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_get=
_registers(cpu);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bql_lock=
();<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_sys=
tem_guest_panicked(cpu_get_crash_info(cpu));<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bql_unlo=
ck();<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<b=
r>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (advance_pc) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WHV_REGI=
STER_VALUE pc;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flush_cp=
u_state(cpu);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pc.Reg64=
 =3D vcpu-&gt;exit_ctx.MemoryAccess.Header.Pc + 4;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_set=
_reg(cpu, WHvArm64RegisterPc, pc);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ &nbsp;&nbsp;&nbsp;} =
while (!ret);<br>+<br>+ &nbsp;&nbsp;&nbsp;cpu_exec_end(cpu);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;bql_lock();<br>+ &nbsp;&nbsp;&nbsp;current_cpu =3D =
cpu;<br>+<br>+ &nbsp;&nbsp;&nbsp;if (--whpx-&gt;running_cpus =3D=3D 0) =
{<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_last_vcpu_stopping(cpu);<br=
>+ &nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;qatomic_set(&amp;cpu-&gt;exit_request, =
false);<br>+<br>+ &nbsp;&nbsp;&nbsp;return ret &lt; =
0;<br>+}<br>+<br>+static void =
clean_whv_register_value(WHV_REGISTER_VALUE *val)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;memset(val, 0, =
sizeof(WHV_REGISTER_VALUE));<br>+}<br>+<br>+void =
whpx_get_registers(CPUState *cpu)<br>+{<br>+ &nbsp;&nbsp;&nbsp;ARMCPU =
*arm_cpu =3D ARM_CPU(cpu);<br>+ &nbsp;&nbsp;&nbsp;CPUARMState *env =3D =
&amp;arm_cpu-&gt;env;<br>+ &nbsp;&nbsp;&nbsp;WHV_REGISTER_VALUE =
val;<br>+ &nbsp;&nbsp;&nbsp;int i;<br>+<br>+ &nbsp;&nbsp;&nbsp;for (i =3D =
0; i &lt; ARRAY_SIZE(whpx_reg_match); i++) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_get_reg(cpu, =
whpx_reg_match[i].reg, &amp;val);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*(uint64_t *)((char *)env + =
whpx_reg_match[i].offset) =3D val.Reg64;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;for (i =3D 0; i &lt; =
ARRAY_SIZE(whpx_fpreg_match); i++) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_get_reg(cpu, =
whpx_reg_match[i].reg, &amp;val);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;memcpy((char *)env + =
whpx_fpreg_match[i].offset, &amp;val, sizeof(val.Reg128));<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;whpx_get_reg(cpu, =
WHvArm64RegisterPc, &amp;val);<br>+ &nbsp;&nbsp;&nbsp;env-&gt;pc =3D =
val.Reg64;<br>+<br>+ &nbsp;&nbsp;&nbsp;whpx_get_reg(cpu, =
WHvArm64RegisterFpcr, &amp;val);<br>+ =
&nbsp;&nbsp;&nbsp;vfp_set_fpcr(env, val.Reg32);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;whpx_get_reg(cpu, WHvArm64RegisterFpsr, =
&amp;val);<br>+ &nbsp;&nbsp;&nbsp;vfp_set_fpsr(env, =
val.Reg32);<br>+<br>+ &nbsp;&nbsp;&nbsp;whpx_get_reg(cpu, =
WHvArm64RegisterPstate, &amp;val);<br>+ =
&nbsp;&nbsp;&nbsp;pstate_write(env, val.Reg32);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;for (i =3D 0; i &lt; ARRAY_SIZE(whpx_sreg_match); i++) =
{<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(whpx_sreg_match[i].cp_idx =3D=3D -1) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;continue=
;<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (whpx_sreg_match[i].global) =
{<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* WHP =
disallows us from accessing global regs as a vCPU */<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_get=
_global_reg(whpx_sreg_match[i].reg, &amp;val);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} else {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_get=
_reg(cpu, whpx_sreg_match[i].reg, &amp;val);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arm_cpu-&gt;cpreg_values[whpx_sr=
eg_match[i].cp_idx] =3D val.Reg64;<br>+ &nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;assert(write_list_to_cpustate(arm_cpu));<br>+ =
&nbsp;&nbsp;&nbsp;aarch64_restore_sp(env, =
arm_current_el(env));<br>+}<br>+<br>+void whpx_set_registers(CPUState =
*cpu, int level)<br>+{<br>+ &nbsp;&nbsp;&nbsp;ARMCPU *arm_cpu =3D =
ARM_CPU(cpu);<br>+ &nbsp;&nbsp;&nbsp;CPUARMState *env =3D =
&amp;arm_cpu-&gt;env;<br>+ &nbsp;&nbsp;&nbsp;WHV_REGISTER_VALUE =
val;<br>+ &nbsp;&nbsp;&nbsp;clean_whv_register_value(&amp;val);<br>+ =
&nbsp;&nbsp;&nbsp;int i;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;assert(cpu_is_stopped(cpu) || =
qemu_cpu_is_self(cpu));<br>+<br>+ &nbsp;&nbsp;&nbsp;for (i =3D 0; i &lt; =
ARRAY_SIZE(whpx_reg_match); i++) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;val.Reg64 =3D *(uint64_t =
*)((char *)env + whpx_reg_match[i].offset);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_set_reg(cpu, =
whpx_reg_match[i].reg, val);<br>+ &nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;for (i =3D 0; i &lt; ARRAY_SIZE(whpx_fpreg_match); =
i++) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;memcpy(&amp;val.Reg128, (char =
*)env + whpx_fpreg_match[i].offset, sizeof(val.Reg128));<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_set_reg(cpu, =
whpx_reg_match[i].reg, val);<br>+ &nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;clean_whv_register_value(&amp;val);<br>+ =
&nbsp;&nbsp;&nbsp;val.Reg64 =3D env-&gt;pc;<br>+ =
&nbsp;&nbsp;&nbsp;whpx_set_reg(cpu, WHvArm64RegisterPc, val);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;clean_whv_register_value(&amp;val);<br>+ =
&nbsp;&nbsp;&nbsp;val.Reg32 =3D vfp_get_fpcr(env);<br>+ =
&nbsp;&nbsp;&nbsp;whpx_set_reg(cpu, WHvArm64RegisterFpcr, val);<br>+ =
&nbsp;&nbsp;&nbsp;val.Reg32 =3D vfp_get_fpsr(env);<br>+ =
&nbsp;&nbsp;&nbsp;whpx_set_reg(cpu, WHvArm64RegisterFpsr, val);<br>+ =
&nbsp;&nbsp;&nbsp;val.Reg32 =3D pstate_read(env);<br>+ =
&nbsp;&nbsp;&nbsp;whpx_set_reg(cpu, WHvArm64RegisterPstate, =
val);<br>+<br>+ &nbsp;&nbsp;&nbsp;aarch64_save_sp(env, =
arm_current_el(env));<br>+<br>+ =
&nbsp;&nbsp;&nbsp;assert(write_cpustate_to_list(arm_cpu, =
false));<br>+<br>+ &nbsp;&nbsp;&nbsp;/* Currently set global regs every =
time. */<br>+ &nbsp;&nbsp;&nbsp;for (i =3D 0; i &lt; =
ARRAY_SIZE(whpx_sreg_match); i++) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (whpx_sreg_match[i].cp_idx =
=3D=3D -1) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;continue=
;<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;val.Reg64 =3D =
arm_cpu-&gt;cpreg_values[whpx_sreg_match[i].cp_idx];<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (whpx_sreg_match[i].global) =
{<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* WHP =
disallows us from accessing global regs as a vCPU */<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_set=
_global_reg(whpx_sreg_match[i].reg, val);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} else {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_set=
_reg(cpu, whpx_sreg_match[i].reg, val);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+}<br>+<br>+static uint32_t =
max_vcpu_index;<br>+<br>+static void whpx_cpu_update_state(void *opaque, =
bool running, RunState state)<br>+{<br>+}<br>+<br>+int =
whpx_init_vcpu(CPUState *cpu)<br>+{<br>+ &nbsp;&nbsp;&nbsp;HRESULT =
hr;<br>+ &nbsp;&nbsp;&nbsp;struct whpx_state *whpx =3D =
&amp;whpx_global;<br>+ &nbsp;&nbsp;&nbsp;ARMCPU *arm_cpu =3D =
ARM_CPU(cpu);<br>+ &nbsp;&nbsp;&nbsp;CPUARMState *env =3D =
&amp;arm_cpu-&gt;env;<br>+ &nbsp;&nbsp;&nbsp;int ret;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;uint32_t sregs_match_len =3D =
ARRAY_SIZE(whpx_sreg_match);<br>+ &nbsp;&nbsp;&nbsp;uint32_t sregs_cnt =3D=
 0;<br>+ &nbsp;&nbsp;&nbsp;WHV_REGISTER_VALUE val;<br>+ =
&nbsp;&nbsp;&nbsp;int i;<br>+<br>+ &nbsp;&nbsp;&nbsp;hr =3D =
whp_dispatch.WHvCreateVirtualProcessor(<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx-&gt;partition, =
cpu-&gt;cpu_index, 0);<br>+ &nbsp;&nbsp;&nbsp;if (FAILED(hr)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("WHPX: Failed to =
create a virtual processor,"<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" hr=3D%08lx", hr);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D -EINVAL;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
error;<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Simpler: return -EINVAL;</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"></div></blockquote><div><br></div><div>Thanks, allowed to get =
rid of the goto error later as this was the only user of =
it.</div><blockquote type=3D"cite"><div><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;">+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;/* Assumption that =
CNTFRQ_EL0 is the same between the VMM and the partition. */<br>+ =
&nbsp;&nbsp;&nbsp;asm volatile("mrs %0, cntfrq_el0" : =
"=3Dr"(arm_cpu-&gt;gt_cntfrq_hz));<br>+<br>+ =
&nbsp;&nbsp;&nbsp;cpu-&gt;vcpu_dirty =3D true;<br>+ =
&nbsp;&nbsp;&nbsp;cpu-&gt;accel =3D g_new0(AccelCPUState, 1);<br>+ =
&nbsp;&nbsp;&nbsp;max_vcpu_index =3D MAX(max_vcpu_index, =
cpu-&gt;cpu_index);<br>+ =
&nbsp;&nbsp;&nbsp;qemu_add_vm_change_state_handler(whpx_cpu_update_state, =
env);<br>+<br>+ &nbsp;&nbsp;&nbsp;env-&gt;aarch64 =3D true;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;/* Allocate enough space for our sysreg sync */<br>+ =
&nbsp;&nbsp;&nbsp;arm_cpu-&gt;cpreg_indexes =3D g_renew(uint64_t, =
arm_cpu-&gt;cpreg_indexes,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sregs_=
match_len);<br>+ &nbsp;&nbsp;&nbsp;arm_cpu-&gt;cpreg_values =3D =
g_renew(uint64_t, arm_cpu-&gt;cpreg_values,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sregs_match_=
len);<br>+ &nbsp;&nbsp;&nbsp;arm_cpu-&gt;cpreg_vmstate_indexes =3D =
g_renew(uint64_t,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arm_cpu-&gt;cpreg_vmstate_indexe=
s,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sregs_match_len);<br>+ =
&nbsp;&nbsp;&nbsp;arm_cpu-&gt;cpreg_vmstate_values =3D =
g_renew(uint64_t,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arm_cpu-&gt;cpreg_vmstate_values,<br>+=
 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sregs_match_len);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;memset(arm_cpu-&gt;cpreg_values, 0, sregs_match_len * =
sizeof(uint64_t));<br>+<br>+ &nbsp;&nbsp;&nbsp;/* Populate cp list for =
all known sysregs */<br>+ &nbsp;&nbsp;&nbsp;for (i =3D 0; i &lt; =
sregs_match_len; i++) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;const ARMCPRegInfo *ri;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint32_t key =3D =
whpx_sreg_match[i].key;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ri =3D =
get_arm_cp_reginfo(arm_cpu-&gt;cp_regs, key);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ri) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;assert(!=
(ri-&gt;type &amp; ARM_CP_NO_RAW));<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_sre=
g_match[i].cp_idx =3D sregs_cnt;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arm_cpu-=
&gt;cpreg_indexes[sregs_cnt++] =3D cpreg_to_kvm_id(key);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} else {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx_sre=
g_match[i].cp_idx =3D -1;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+ &nbsp;&nbsp;&nbsp;arm_cpu-&gt;cpreg_array_len =3D=
 sregs_cnt;<br>+ &nbsp;&nbsp;&nbsp;arm_cpu-&gt;cpreg_vmstate_array_len =3D=
 sregs_cnt;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;assert(write_cpustate_to_list(arm_cpu, =
false));<br>+<br>+ &nbsp;&nbsp;&nbsp;/* Set CP_NO_RAW system registers =
on init */<br>+ &nbsp;&nbsp;&nbsp;val.Reg64 =3D arm_cpu-&gt;midr;<br>+ =
&nbsp;&nbsp;&nbsp;whpx_set_reg(cpu, WHvArm64RegisterMidrEl1,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;val);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;clean_whv_register_value(&amp;val);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;val.Reg64 =3D deposit64(arm_cpu-&gt;mp_affinity, 31, =
1, 1 /* RES1 */);<br>+ &nbsp;&nbsp;&nbsp;whpx_set_reg(cpu, =
WHvArm64RegisterMpidrEl1, val);<br>+<br>+ &nbsp;&nbsp;&nbsp;return =
0;<br>+<br>+error:<br>+ &nbsp;&nbsp;&nbsp;return =
ret;<br>+}<br>+<br>+void whpx_cpu_instance_init(CPUState =
*cs)<br>+{<br>+}<br>+<br>+int whpx_accel_init(AccelState *as, =
MachineState *ms)<br>+{<br>+ &nbsp;&nbsp;&nbsp;struct whpx_state =
*whpx;<br>+ &nbsp;&nbsp;&nbsp;int ret;<br>+ &nbsp;&nbsp;&nbsp;HRESULT =
hr;<br>+ &nbsp;&nbsp;&nbsp;WHV_CAPABILITY whpx_cap;<br>+ =
&nbsp;&nbsp;&nbsp;UINT32 whpx_cap_size;<br>+ =
&nbsp;&nbsp;&nbsp;WHV_PARTITION_PROPERTY prop;<br>+ =
&nbsp;&nbsp;&nbsp;WHV_CAPABILITY_FEATURES features;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;whpx =3D &amp;whpx_global;<br>+ &nbsp;&nbsp;&nbsp;/* =
on arm64 Windows Hypervisor Platform, vGICv3 always used */<br>+ =
&nbsp;&nbsp;&nbsp;whpx_irqchip_in_kernel =3D true;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;if (!init_whp_dispatch()) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D -ENOSYS;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto error;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;whpx-&gt;mem_quota =3D =
ms-&gt;ram_size;<br>+<br>+ &nbsp;&nbsp;&nbsp;hr =3D =
whp_dispatch.WHvGetCapability(<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WHvCapabilityCodeHypervisorPrese=
nt, &amp;whpx_cap,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sizeof(whpx_cap), =
&amp;whpx_cap_size);<br>+ &nbsp;&nbsp;&nbsp;if (FAILED(hr) || =
!whpx_cap.HypervisorPresent) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("WHPX: No =
accelerator found, hr=3D%08lx", hr);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D -ENOSPC;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto error;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;memset(&amp;features, 0, =
sizeof(features));<br>+ &nbsp;&nbsp;&nbsp;hr =3D =
whp_dispatch.WHvGetCapability(<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WHvCapabilityCodeFeatures, =
&amp;features, sizeof(features), NULL);<br>+ &nbsp;&nbsp;&nbsp;if =
(FAILED(hr)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("WHPX: Failed to =
query capabilities, hr=3D%08lx", hr);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D -EINVAL;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto error;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;if =
(!features.Arm64Support) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("WHPX: host OS =
exposing pre-release WHPX implementation. "<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"Please =
update your operating system to at least build 26100.3915");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D -EINVAL;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto error;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;hr =3D =
whp_dispatch.WHvCreatePartition(&amp;whpx-&gt;partition);<br>+ =
&nbsp;&nbsp;&nbsp;if (FAILED(hr)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("WHPX: Failed to =
create partition, hr=3D%08lx", hr);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D -EINVAL;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto error;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;memset(&amp;prop, 0, =
sizeof(prop));<br>+ &nbsp;&nbsp;&nbsp;prop.ProcessorCount =3D =
ms-&gt;smp.cpus;<br>+ &nbsp;&nbsp;&nbsp;hr =3D =
whp_dispatch.WHvSetPartitionProperty(<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx-&gt;partition,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WHvPartitionPropertyCodeProcesso=
rCount,<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;prop,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sizeof(prop));<br>+<br>+ =
&nbsp;&nbsp;&nbsp;if (FAILED(hr)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("WHPX: Failed to =
set partition processor count to %u,"<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" hr=3D%08lx", =
prop.ProcessorCount, hr);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D -EINVAL;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto error;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;if =
(!whpx-&gt;kernel_irqchip_allowed) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("WHPX: on Arm, =
only kernel-irqchip=3Don is currently supported");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D -EINVAL;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto error;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;memset(&amp;prop, 0, =
sizeof(prop));<br>+<br>+ &nbsp;&nbsp;&nbsp;hr =3D =
whp_dispatch.WHvSetupPartition(whpx-&gt;partition);<br>+ =
&nbsp;&nbsp;&nbsp;if (FAILED(hr)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("WHPX: Failed to =
setup partition, hr=3D%08lx", hr);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D -EINVAL;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto error;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;whpx_memory_init();<br>+<br>+ &nbsp;&nbsp;&nbsp;return =
0;<br>+<br>+error:<br>+ &nbsp;&nbsp;&nbsp;if (whpx-&gt;partition !=3D =
NULL) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whp_dispatch.WHvDeletePartition(=
whpx-&gt;partition);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;whpx-&gt;partition =3D =
NULL;<br>+ &nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;return =
ret;<br>+}</blockquote></div></blockquote></div><br></body></html>=

--Apple-Mail=_103B3248-7813-4D13-8DEC-F7B535F809FF--

