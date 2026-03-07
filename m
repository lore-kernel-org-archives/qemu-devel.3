Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1021F55100
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 16:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyu6r-0005vD-Uk; Sat, 07 Mar 2026 11:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyu6q-0005uO-6s
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 11:02:32 -0500
Received: from ci-2004e-snip4-4.eps.apple.com ([57.103.89.47]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyu6m-0004px-Pm
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 11:02:31 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPS id
 DD21F180012B; Sat,  7 Mar 2026 16:02:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772899347; x=1775491347;
 bh=VtFqobNxz+eAHKsmBEnCemCe2d1yAO1MK7/R7kh/Yh4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=NNVp+yx8VbjgLdMvpOKGcjLXIedcfspXvuUwkwlWDzJJy+8VPiVkQkNTTl3ZItpXci3cu74fr6PznJiiz6kj0s3aKnVzU3x4uAxrj8kqzFd8YEzcdYav2hde6cktmzdYbn6AJchWXQx22R2ZJ3lIrk20xmqUzWIg6EhzA5L9dHrxPPuL/Q1yXrLURrZTYyLyQrHhwDkF2J7HgSp4r5r9dlnDqpc2RhGExqu47CHc3hqpBVbR7sGkKI7XOZieoe/GPwpKwXjFEtdR6K7MHI/3KcdyJXysZKL4lLJqrm5+b9huxGGP0kh+PY5VBxo4njVrBhUEwO/vjD90+95Dp+QU3w==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPSA id
 BFC70180054C; Sat,  7 Mar 2026 16:02:22 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v5 7/9] whpx: make Hyper-V enlightenments configurable
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <ef4e4171-e4fe-43a9-91c5-a720ba0612d3@linaro.org>
Date: Sat, 7 Mar 2026 17:02:10 +0100
Cc: qemu-devel@nongnu.org,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Wei Liu <wei.liu@kernel.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E2315EF6-0393-48F7-BA6D-2ADF18007D8D@unpredictable.fr>
References: <20260307154104.84567-1-mohamed@unpredictable.fr>
 <20260307154104.84567-8-mohamed@unpredictable.fr>
 <ef4e4171-e4fe-43a9-91c5-a720ba0612d3@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE1MiBTYWx0ZWRfX4O9HVlQl4Mjb
 MMxLPtlsyzDir/79EAlG8lqCva98gCTl3uHhejoTILLLDQJNpU4S2oQuhn2uLzRVAz9X3dmqXFu
 Rawq6u231K+HZ0Cg5nF4Tn0gEZ6SyWiVjpaMigIIVNhEjauGRksq236sPcev93Ybqf/3K/TWQFz
 jQ5VAKIghA+agyaUNRmics5eWmR7CmpD5mSXngJaZDI6pGqlqZnfy9jEHXxRBeH23aQkmLX7Xyn
 sdavt+4zfoOhsOhs4RQSm1SFKDEykITQEIwqd3KxElSrNnBIF9uylKV5gjqm2IhmBiDBJN42Mqe
 JSnQIkqwZsIADo2amF45mRaDV5NWYbq/Hke4KVwtH5Ufml0EOTyV5l9H+XJ2gc=
X-Proofpoint-ORIG-GUID: tO0LoZ8Hx4EdUFyW3UMY3PrVR0Yoi3SP
X-Authority-Info-Out: v=2.4 cv=MNRtWcZl c=1 sm=1 tr=0 ts=69ac4c11
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=gHRI74mPg0AvJkQz970A:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tO0LoZ8Hx4EdUFyW3UMY3PrVR0Yoi3SP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1030 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=999 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070152
X-JNJ: AAAAAAABjNikGbz3y/amYZpqg94//2XY32lRCRaT/pDRQ2Jzb+EyQ3AtYSXeI99bqc+x05d8p2C7nSdaEnLANJ7gv/p8tKWfzxGuZqagAt4YTDSzP4Bm2ZwvpdPAlfJ5jH6uqfRcoKYViPfMx96PK7eXElrTf+JDX8S4nFJcwfWQ6k8uo38QSK5Qm34ASaUbRYW8GdKS+/MKP8kBFSx7I37/EiJd7ZUscOMXBnWZ3APoYJ3EVBAwBM284wmgkFS+Xjsj1jVUNt0JNez4GpA6LVo+QuuoCogf/EOnupJ+kvMCgZiJAXehu9H5FexNoEodiZlqyZp+wu36yKiFflPM2rqKjzeQboXXPbKfhEW6IW7DMFAD2Dy+/hPpXs7xf50r7OBB5Xr40eTobq2uoCoUQyH/9a/zVOxGGDgnHS9gH6SpuwtiuWhI5WAnOv1RxXXDavz2fAgjPy+941RUAZuW5S2i2gQ/DrCrM3MZ56k5hC56Q+lUE3tQvX4QldD/pCZp9mYTCcuqExS8D8ACr2TR5KZsDwIdX/vmUOZc0lEdRN/9pwb6YDyxMftiEygFhy4Ux8hi60iEAMC3NADQ+3JlYsavNAmHpz3af61w3eVQfT95+ydh4oK+sPpUK3ZJKzfyuTkks2Nskk7xpeCXQH+g6iwTihm1EBd9QEl95RLtZl9XayYz9jraY7IKbj8HrwON03heMWMA4xu2lu4pohtGKGh/tOk6NiBZ4qNx0R7Q/uYYmXnW2Yc0QpS6hrx0hBYxkOG1tczVzy+YB2vsHuvx7akaXwKIRg==
Received-SPF: pass client-ip=57.103.89.47;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 7. Mar 2026, at 16:53, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 7/3/26 16:41, Mohamed Mediouni wrote:
>> Have them be a machine option instead of a CPU one, to have something =
available, even if not ideal...
>> The existing Hyper-V enlightenments configuration mechanism is part =
of per-CPU configuration, which happens too late for this.
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  accel/whpx/whpx-common.c       | 44 =
++++++++++++++++++++++++++++++++++
>>  include/system/whpx-internal.h |  4 ++++
>>  target/i386/whpx/whpx-all.c    | 20 +++++++++-------
>>  3 files changed, 59 insertions(+), 9 deletions(-)
>> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
>> index 4863fc8663..dae9ff0800 100644
>> --- a/accel/whpx/whpx-common.c
>> +++ b/accel/whpx/whpx-common.c
>> @@ -25,6 +25,7 @@
>>  #include "qapi/qapi-visit-common.h"
>>  #include "migration/blocker.h"
>>  #include "accel/accel-cpu-target.h"
>> +#include "qemu/target-info.h"
>=20
> I suppose you meant "qapi/qapi-types-common.h=E2=80=9D?

Skipping including the line at all :)

Context: in an earlier iteration added an arch check added here with =
using the target_aarch64() function*,
but changed it for this rev.

* at the end, decided to use a bifurcated =
hyperv_enlightenments_allowed/hyperv_enlightenments_required
design like for kernel-irqchip, with enlightenments off by default on =
arm64 but on by default for x86, because=20
arm64 virt is cleaner architecturally by enough that enlightenments =
don=E2=80=99t really matter there.

>=20
>>  #include <winerror.h>
>>    #include "system/whpx-internal.h"
>> @@ -470,6 +471,41 @@ static void whpx_set_kernel_irqchip(Object *obj, =
Visitor *v,
>>      }
>>  }
>>  +static void whpx_set_hyperv(Object *obj, Visitor *v,
>> +                                   const char *name, void *opaque,
>> +                                   Error **errp)
>> +{
>> +    struct whpx_state *whpx =3D &whpx_global;
>> +    OnOffAuto mode;
>> +
>> +    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
>> +        return;
>> +    }
>> +
>> +    switch (mode) {
>> +    case ON_OFF_AUTO_ON:
>> +        whpx->hyperv_enlightenments_allowed =3D true;
>> +        whpx->hyperv_enlightenments_required =3D true;
>> +        break;
>> +
>> +    case ON_OFF_AUTO_OFF:
>> +        whpx->hyperv_enlightenments_allowed =3D false;
>> +        whpx->hyperv_enlightenments_required =3D false;
>> +        break;
>> +
>> +    case ON_OFF_AUTO_AUTO:
>> +        whpx->hyperv_enlightenments_allowed =3D true;
>> +        whpx->hyperv_enlightenments_required =3D false;
>> +        break;
>> +    default:
>> +        /*
>> +         * The value was checked in visit_type_OnOffAuto() above. If
>> +         * we get here, then something is wrong in QEMU.
>> +         */
>> +        abort();
>> +    }
>> +}
>> +
>>  static void whpx_cpu_accel_class_init(ObjectClass *oc, const void =
*data)
>>  {
>>      AccelCPUClass *acc =3D ACCEL_CPU_CLASS(oc);
>> @@ -498,6 +534,11 @@ static void whpx_accel_class_init(ObjectClass =
*oc, const void *data)
>>          NULL, NULL);
>>      object_class_property_set_description(oc, "kernel-irqchip",
>>          "Configure WHPX in-kernel irqchip");
>> +    object_class_property_add(oc, "hyperv", "OnOffAuto",
>> +        NULL, whpx_set_hyperv,
>> +        NULL, NULL);
>> +    object_class_property_set_description(oc, "hyperv",
>> +        "Configure Hyper-V enlightenments");
>>  }
>>    static void whpx_accel_instance_init(Object *obj)
>> @@ -507,6 +548,9 @@ static void whpx_accel_instance_init(Object *obj)
>>      memset(whpx, 0, sizeof(struct whpx_state));
>>      /* Turn on kernel-irqchip, by default */
>>      whpx->kernel_irqchip_allowed =3D true;
>> +
>> +    whpx->hyperv_enlightenments_allowed =3D true;
>> +    whpx->hyperv_enlightenments_required =3D false;
>>  }
>=20


