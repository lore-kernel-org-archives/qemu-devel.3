Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FA6F9EDC9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFXJk-0001Wf-KY; Wed, 22 Apr 2026 09:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFXJi-0001Tc-II
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:08:34 -0400
Received: from p-west2-cluster3-host8-snip4-1.eps.apple.com ([57.103.69.54]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFXJf-0003L3-Cy
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:08:34 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-11 (Postfix) with ESMTPS id
 E7D191800217; Wed, 22 Apr 2026 13:08:28 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRAEwVSB11NVg1HD1geXBQXFUFDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTABMcFt2KnMxFDp1XwdGBkIJSh5UDl0HXQlAAlwOWXNDAEpyX3ceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776863309; x=1779455309;
 bh=pjFEJ1eB1ud6FWWEeyw9vMEU4zhXWmqigPJjqKRWMKM=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=K9mMOfHP7555gC0gJvbr/3a8FQ79A58F6OPNoMlM+s6PhkfD7yqGfRouReG/kxlmqKiG6EFEVKEUzlsQOWlp0J/MGzllTJtU+OP8sBKvt8YUcPB/ip3JR68gxmUMUqdd7MOSWj5lAEk3ziC0IB8DqWAhz/IcM0er3g7tK3apgSJVy00cMQhMXvMWDVcjHox+8PYA69A834GtIJc1NWTeBA3oP+WEL6TfZNr75UxjQw2vNGzu4CkIKybWql9hfi9SgMrgJTTK0wBcMtmobYjBZIzH+FFRt6BR1oWpmE096hCFSxOYuRwfNKQxVIvFWq2vZrkHur0Q9CH/6CSwmK302w==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-11 (Postfix) with ESMTPSA id
 05D0018000AA; Wed, 22 Apr 2026 13:08:26 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2] whpx: i386, arm: do partition reset on boot CPU reset
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <a8cb94f0-9970-40b8-912b-3ab81a5907f4@linaro.org>
Date: Wed, 22 Apr 2026 15:08:14 +0200
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <94C6AAAA-BF20-4202-9965-081192A392A2@unpredictable.fr>
References: <20260421205749.55060-1-mohamed@unpredictable.fr>
 <a8cb94f0-9970-40b8-912b-3ab81a5907f4@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-ORIG-GUID: uC-xzI9OiKuQxiX_7nUvM98VUwu4dGTi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEyNyBTYWx0ZWRfX804div8TrNVJ
 V5IMrh8BRrk4MUmkNWP0mSKShQPOV31lUQ37nj+FiWAvaFZIm5W4bU+qUrVBjt0FNatAmPWQlvn
 EQ1CYLx7REzyqLx+8OWno1hRZIUOVhYNBpzTNXivStkAWDo1JDWsqCcfLHdJD0YnTm3BVpdkiXI
 CFgZOZ+gEKRsMCKxCqu/65LizoMxKOHWqiiuNUpua4JYudK4iVsxs5t6U+MkKLmw4EkeHIIfwEm
 7fEhHhLg+iNv0CxYn33j9K+zz4PTvOO6acdPf1LPgQch0aaSxB34FyMLeooex7Nkh88hXWH0NGu
 2z+ftNEJ4N7tFIuhL9q5Jcg/iOx1csvUnkQcW4AVxD1YLXNbz9AluUUsjo/wgY=
X-Authority-Info-Out: v=2.4 cv=aNv9aL9m c=1 sm=1 tr=0 ts=69e8c84d
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=_JJPVulPvL2OzXI3qN8A:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: uC-xzI9OiKuQxiX_7nUvM98VUwu4dGTi
Received-SPF: pass client-ip=57.103.69.54;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 22. Apr 2026, at 14:46, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> +Ani
>=20
> On 21/4/26 22:57, Mohamed Mediouni wrote:
>> WHvResetPartition resets partition state, and is not supported on =
Windows 10.
>> On Arm, it's supposed to be used for reboots. The prior location of =
the
>> WHvResetPartition call wasn't right, as other vCPUs might still have
>> been running, causing the call to fail.
>=20
> Is it very different from the conceptual step introduced in commit
> 4003e5e65fe ("hw/accel: add a per-accelerator callback to change
> VM accelerator handle")?

Hello,

The difference is that we reset the partition state but don=E2=80=99t =
have to=20
re-do any of the memory mappings in the Hyper-V case (or otherwise tear
down the context).

We could fallback outright into the CoCo case which would work too.
>=20
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  accel/accel-system.c       |  9 +++++++++
>>  accel/whpx/whpx-common.c   | 13 +++++++++++++
>>  include/accel/accel-ops.h  |  1 +
>>  include/qemu/accel.h       |  3 +++
>>  system/runstate.c          |  5 +++++
>>  target/arm/whpx/whpx-all.c |  2 --
>>  6 files changed, 31 insertions(+), 2 deletions(-)
>> diff --git a/accel/accel-system.c b/accel/accel-system.c
>> index 150af05bf5..5352ccd937 100644
>> --- a/accel/accel-system.c
>> +++ b/accel/accel-system.c
>> @@ -75,6 +75,15 @@ void accel_pre_resume(MachineState *ms, bool =
step_pending)
>>      }
>>  }
>>  +void accel_reset(MachineState *ms)
>> +{
>> +    AccelState *accel =3D ms->accelerator;
>> +    AccelClass *acc =3D ACCEL_GET_CLASS(accel);
>> +    if (acc->reset_vm) {
>> +        acc->reset_vm(accel);
>> +    }
>> +}
>> +
>>  /* initialize the arch-independent accel operation interfaces */
>>  void accel_init_ops_interfaces(AccelClass *ac)
>>  {
>> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
>> index 6fe44d5910..1f7b7d764d 100644
>> --- a/accel/whpx/whpx-common.c
>> +++ b/accel/whpx/whpx-common.c
>> @@ -205,6 +205,18 @@ static void =
do_whpx_cpu_synchronize_pre_loadvm(CPUState *cpu,
>>      cpu->vcpu_dirty =3D true;
>>  }
>>  +/*
>> + * Partition support
>> + */
>> +
>> +static void whpx_partition_reset(AccelState* as)
>> +{
>> +    struct whpx_state *whpx =3D &whpx_global;
>> +    if (whp_dispatch.WHvResetPartition) {
>> +        whp_dispatch.WHvResetPartition(whpx->partition);
>> +    }
>> +}
>> +
>>  /*
>>   * CPU support.
>>   */
>> @@ -622,6 +634,7 @@ static void whpx_accel_class_init(ObjectClass =
*oc, const void *data)
>>      ac->name =3D "WHPX";
>>      ac->init_machine =3D whpx_accel_init;
>>      ac->pre_resume_vm =3D whpx_pre_resume_vm;
>> +    ac->reset_vm =3D whpx_partition_reset;
>>      ac->allowed =3D &whpx_allowed;
>>        object_class_property_add(oc, "kernel-irqchip", =
"on|off|split",
>> diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
>> index f46492e3fe..a1c9f3ae7b 100644
>> --- a/include/accel/accel-ops.h
>> +++ b/include/accel/accel-ops.h
>> @@ -33,6 +33,7 @@ struct AccelClass {
>>      /* system related hooks */
>>      void (*setup_post)(AccelState *as);
>>      void (*pre_resume_vm)(AccelState *as, bool step_pending);
>> +    void (*reset_vm)(AccelState *as);
>>      bool (*has_memory)(AccelState *accel, AddressSpace *as,
>>                         hwaddr start_addr, hwaddr size);
>>  diff --git a/include/qemu/accel.h b/include/qemu/accel.h
>> index d3638c7bfd..0e12aea7db 100644
>> --- a/include/qemu/accel.h
>> +++ b/include/qemu/accel.h
>> @@ -54,6 +54,9 @@ void accel_setup_post(MachineState *ms);
>>    void accel_pre_resume(MachineState *ms, bool step_pending);
>>  +/* Reset accelerator state. */
>> +void accel_reset(MachineState *ms);
>> +
>>  /**
>>   * accel_cpu_instance_init:
>>   * @cpu: The CPU that needs to do accel-specific object =
initializations.
>> diff --git a/system/runstate.c b/system/runstate.c
>> index 2d4e95a216..734e3c037c 100644
>> --- a/system/runstate.c
>> +++ b/system/runstate.c
>> @@ -564,6 +564,11 @@ void qemu_system_reset(ShutdownCause reason)
>>          qapi_event_send_reset(shutdown_caused_by_guest(reason), =
reason);
>>      }
>>  +    if (current_machine) {
>> +        /* Tell the accelerator that the VM is being reset. */
>> +        accel_reset(current_machine);
>> +    }
>> +
>>      /*
>>       * Some boards use the machine reset callback to point CPUs to =
the firmware
>>       * entry point.  Assume that this is not the case for boards =
that support
>> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
>> index 4019a513aa..f345fea4fe 100644
>> --- a/target/arm/whpx/whpx-all.c
>> +++ b/target/arm/whpx/whpx-all.c
>> @@ -472,8 +472,6 @@ int whpx_vcpu_run(CPUState *cpu)
>>              if (arm_cpu->power_state !=3D PSCI_OFF) {
>>                  whpx_psci_cpu_off(arm_cpu);
>>              }
>> -            /* Partition-wide reset, to reset state for reboots to =
succeed. */
>> -            whp_dispatch.WHvResetPartition(whpx->partition);
>>              bql_unlock();
>>              break;
>>          case WHvRunVpExitReasonNone:
>=20
>=20


