Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1B7606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=tDtwCHAb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7uB-0004uO-TB; Wed, 28 Oct 2026 13:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xM7uA-0004sA-Ob
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:57:42 -0400
Received: from st-2002f-snip6-11.eps.apple.com ([2a01:b747:3001:205::3d]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xM7u9-00006y-0V
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:57:42 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPS id
 4B3A818009FE; Wed, 28 Oct 2026 17:57:37 +0000 (UTC)
X-ICL-RepId: 01a183a9-0f4e-7c5b-9f9e-0881db0cfea4
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0ISxMFUgddTVYNRw9YHlwUFwtHQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wLSwRVAF9xRBRMAFhzRgY2DUEeLw9ed118QAFZACoFRg5ABVV3HlwASx1XBFQfUxJVHR0LRVUSBEAIVlBUHkEEVhVsCVgGUxlX
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793210260; x=1824746260;
 bh=n6CB24kLb4o8PY7Y1F8TypjDTj1toJVoi04FyODzRN0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=tDtwCHAbKeio3KKCCnneiDrrwmRoszWon0jIZt+cicyLDlJ+DZLk0PcIhIPp7KuVi90giklGUlLKlTSrIRpx+vbaisFZOxudmvf/O3bsWg8Bh8W6wlhDGdwH04n1iSkdkZAc4s2Ra/5lcCgy94M/E8nCy8Bs/d4SdgyeMDQlwExOlnNcv6cgDvMQif3CLvr3OXzabvYv9NVKjKSaCuUHTypk8HYAXohUg0wC7HW7gqhbFHmX6i3tFjNZLVjnHRO9oyBI6kkJ5aJIkn+2DSiaVpUDr8sIGirnHdsTDhuuy2v60Llz/fSaOerJbW0kH5ZizrLrUpUzhV8g04+S4wVxgQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPSA id
 3140518014C1; Wed, 28 Oct 2026 17:57:35 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 1/4] target/i386/mshv: fix vCPU run result contract
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20261028125308.147630-2-magnuskulke@linux.microsoft.com>
Date: Wed, 28 Oct 2026 18:57:24 +0100
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <liuwe@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <237874C4-435D-4F49-B85E-E8247A767868@unpredictable.fr>
References: <20261028125308.147630-1-magnuskulke@linux.microsoft.com>
 <20261028125308.147630-2-magnuskulke@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Authority-Info-Out: v=2.4 cv=belmkePB c=1 sm=1 tr=0 ts=6ae23792
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=yb0mVtdw0DiWe4xSqzsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: qN7yD4Lmw46XR_30uHXmtH78aKEVkEew
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3MSBTYWx0ZWRfXyDwHJwpcKccX
 ibXi9Ms073weg/1otZ9vaxtX0LYqulKAgOZh2QKbIRGsvyxkUp/QzAhXRLQAHxc/d9GyhLwNfyv
 35gSutlK32EoeDjkScHUhhfPaNKyQZkl2jS0YK4Fwuj4ctQqDEwHPxIrMLpof9RgbFtaKh6IoJL
 +Qza873FYAiOAcwZ/GXSOIvQ59gJRoMPCTh7Q53vWC0QsWditvmRPo/kF69cxUOgjUBDEtyGo2X
 Fx2Gj9WXd5KT0BNpl3E+KH0iXxJCEUvfyuEu7DAcARwQ213CEzx/5bY0xFaMzatZ47FJx71n5Yu
 mgb2zaql8H8euw/bFN+eQd96p+aY7i+PLZjxD14GkFIBMyZSxNLYTppwGIGruU=
X-Proofpoint-GUID: qN7yD4Lmw46XR_30uHXmtH78aKEVkEew
X-JNJ: AAAAAAAB4un4b/GWFD7OjeKw95UQSr5ATGyOjdXHUj9P5qbHVWAVhVxFVpb3dPOYS8R68I
 VGBs4wjI0P9g1G03TDn+Trzrc4MAd99WAB8mRv8qpLoSZiUAPeFCpwcB++ySecxMJu/W31
 XOiAPX9JL5fbVkdNjYfnO/Uqdmqprz6LT9SfZMqOm10FenKPVaPBH0T85JaZw0SMTvSwEk
 TLuTh/6s6pCO7EY8dXkK9R3MjUqBG+k7VDlGR/ygPyA8hUxICQ/TMJQtslVM0QgfRKm28U
 kprouhcW8GBCki2x7rVquDpLy8ODAupLCbdkx5FPJvITWg7QhcdwzC06+/4CGKZY77lxP+
 muCxbatRSu1Q+rWqCVWGYEwijziSyE6NezsDgEoK/L5IfyXFZrNEGKyzfaDogF6rYeRH4R
 RD22elOrmJMYo7ClnUE+shCseIh1UIFTlwlFCUTyscOYazGG8CThLW2UEQWoE6Wp4PiPmP
 SFmScXd9KawhviLd2nE2g/+ZKnS487QacU5N3o/BjnT/qvERH/6Iiwa3WjIxv82uw0IxRm
 rEol2Z80Zt2P5ItUjKYctbDw8r91ONO4DWRUKhclWifOQXZvrBpXKGJfdaIZOfeFy242we
 4AjQdGQ+SyZ56FafEBLZwhHCOZ5Z3VwmzC8wWMZtKuARMgIhiI929PeTJnm5J/Yu/c5Qqo
 VrhXkhmwF9CChSiJIBE7ljI8hKiA6zuAvuwACVbee0+qG4fMBVNx4Al0QodTeAm/VW1OGu
 AM2LgFI7oskXD2+iXa0Pb43EaRdc4BElz5kovHfnxGtAtsJsbqbtzaw3caL0oQ1/SEew6f
 s1uRlEei7132gq+SpeZURRAg9wJ/1hcluzIRKIzLEEgX5EqkleiBYNURxhttnqsVT8X+FR
 T4
Received-SPF: pass client-ip=2a01:b747:3001:205::3d;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 28. Oct 2026, at 13:53, Magnus Kulke =
<magnuskulke@linux.microsoft.com> wrote:
>=20
> Currently the return semantics of mshv_run_vcpu() are broken. They
> return a mix of int and exit_reason, ignoring the out param *exit.
>=20
> This change propagates errno's to the call site and sets the *exit =
value
> accordingly. We also consider the case when an ioctl has return due to =
a
> qemu-requested interruption of the call, this is a legitimate =
condition
> that should not produce an error.
>=20
> Fixes: 6dec60528c4 (target/i386/mshv: Implement mshv_vcpu_run())
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>  target/i386/mshv/mshv-cpu.c | 28 +++++++++++++++++-----------
> 1 file changed, 17 insertions(+), 11 deletions(-)
>=20
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 4df73bb497..e3c155da2e 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -2124,7 +2124,6 @@ static int arch_set_single_step(CPUState *cpu, =
bool enable)
> int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, =
MshvVmExit *exit)
> {
>     int ret;
> -    enum MshvVmExit exit_reason;
>     int cpu_fd =3D mshv_vcpufd(cpu);
>     bool single_step;
>=20
> @@ -2142,7 +2141,12 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, =
hv_message *msg, MshvVmExit *exit)
>=20
>     ret =3D ioctl(cpu_fd, MSHV_RUN_VP, msg);
>     if (ret < 0) {
> -        return MshvVmExitShutdown;
> +        if (errno =3D=3D EINTR) {
> +            *exit =3D MshvVmExitSpecial;
> +            return 0;
> +        }
> +        error_report("failed to run vCPU: %s", strerror(errno));
> +        return -errno;
>     }
>=20
>     /* disable single stepping by flipping RFLAGS.TF */
> @@ -2154,31 +2158,33 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, =
hv_message *msg, MshvVmExit *exit)
>=20
>     switch (msg->header.message_type) {
>     case HVMSG_UNRECOVERABLE_EXCEPTION:
> -        return MshvVmExitShutdown;
> +        *exit =3D MshvVmExitShutdown;
> +        return 0;
>     case HVMSG_UNMAPPED_GPA:
>     case HVMSG_GPA_INTERCEPT:
> -        ret =3D handle_mmio(cpu, msg, &exit_reason);
> +        ret =3D handle_mmio(cpu, msg, exit);
>         if (ret < 0) {
>             error_report("failed to handle mmio");
> -            return -1;
> +            return ret;
>         }
> -        return exit_reason;
> +        return 0;
>     case HVMSG_X64_IO_PORT_INTERCEPT:
>         ret =3D handle_pio(cpu, msg);
>         if (ret < 0) {
> -            return MshvVmExitSpecial;
> +            error_report("failed to handle PIO");
> +            return ret;
>         }
> -        return MshvVmExitIgnore;
> +        *exit =3D MshvVmExitIgnore;
> +        return 0;
>     case HVMSG_X64_EXCEPTION_INTERCEPT:
>         bql_lock();
> -        ret =3D handle_exception_interrupt(cpu, msg, &exit_reason);
> +        ret =3D handle_exception_interrupt(cpu, msg, exit);
>         bql_unlock();
>         if (ret < 0) {
>             error_report("failed to handle exception intercept");
>             return -1;
>         }
> -        *exit =3D exit_reason;
> -        return exit_reason;
> +        return 0;
>     default:
>         break;
>     }
> --=20
> 2.34.1
>=20
>=20


