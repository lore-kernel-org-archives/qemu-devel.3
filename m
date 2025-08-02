Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767C7C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 08:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ui84b-0005GG-C5; Sat, 02 Aug 2025 04:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui7zr-0006Hj-Hc
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 04:53:45 -0400
Received: from p-east3-cluster2-host2-snip4-10.eps.apple.com ([57.103.87.151]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui7zl-0001PW-SF
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 04:53:41 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 8B51218001D5; Sat,  2 Aug 2025 08:53:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=7rCwu6lSiwZbSh3J/ccIn2lZIXTdFoGffU4yCzdojTY=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=O8NfJi1HSpHOvVEFzhzArE3yiyVjcIx3bZumtYK0+LxrIuL8iwn+8b551X+Rp8loSK9/1aWFxwjr14XEYHLHvbY+/K5OEBhjs99/6GEyIYlFLvipgNEXGcGgPMtt7kc6r8mNePfHu0elvrryNKOvAL+y2b1PaDa08zJDncRrv6Wd1G+2is5Tn9t6BjiKKKqlCKLD+TF9Z1BRUcbTEETbr+VivkgqRLlbpY8U55+ZSsL/sO8h9JVJ+c9F3FMpJj+urYjFSdJ7wbeH5lg/M46toivfBxrnlfM4bztjMMcQy81eTDUEWbXxb5HgcOuJOp0qy9M3SzvRu+DZFMDVokP1Rw==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 140F91800204; Sat,  2 Aug 2025 08:53:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <CF3E9804-AE88-4E40-91EA-6055D4CBC5F8@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_6A57F2AD-D1FD-4CFB-9A7F-E696D24B66DF"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [PATCH v3 02/14] whpx: Move around files before introducing
 AArch64 support
Date: Sat, 2 Aug 2025 10:53:18 +0200
In-Reply-To: <20250802081800.76030-3-mohamed@unpredictable.fr>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-arm@nongnu.org, Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
 <20250802081800.76030-3-mohamed@unpredictable.fr>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-GUID: D6NiuIRILKZ5iA0g-Uzw_YoEHJ2NkJqD
X-Proofpoint-ORIG-GUID: D6NiuIRILKZ5iA0g-Uzw_YoEHJ2NkJqD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA3NSBTYWx0ZWRfX8yBkKvulENb7
 L7txL0DssvFHXnjdgzGSxpXs3Ty3lz5uKKqdIB5l8ZKwfMXSvVRiPVO2mZuzn0XcA5P8q8T0dkG
 2L/vA9vkukG+9F/PedhnJakj/GkkcW9eC1QWdBaaUW6o72owMgEXmAc+3jg5tOK7wCgW7wTLcyt
 XsLmhuuB4m6DkE8/pJDX8gpYp9JRiI8mwmnjTw7m51q2Af8ot4bo7v39xz2krAw4cj3LmXNiOQG
 XAdUWfXG9xk0qeuazP11JJB52qMpQNwj3nYJzsmOg9aQ/JHcenh8ekfRmxM3f6jT4fYDbbxFY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 clxscore=1030 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2508020075
Received-SPF: pass client-ip=57.103.87.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--Apple-Mail=_6A57F2AD-D1FD-4CFB-9A7F-E696D24B66DF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Note: I _also_ screwed up this rebase a bit unfortunately but this one =
should be clean: =
https://github.com/mediouni-m/qemu/commit/66f052d80b6b51a60374074cec876f9b=
fc8a756c=20

To not cause too much spam on the ML will most likely batch this when I =
have more changes...

> On 2. Aug 2025, at 10:17, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> Switch to a design where we can share whpx code between x86 and =
AArch64 when it makes sense to do so.
>=20
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> MAINTAINERS                                           | 2 ++
> accel/meson.build                                     | 1 +
> accel/whpx/meson.build                                | 6 ++++++
> {target/i386 =3D> accel}/whpx/whpx-accel-ops.c          | 4 ++--
> {target/i386/whpx =3D> include/system}/whpx-accel-ops.h | 0
> target/i386/whpx/meson.build                          | 1 -
> target/i386/whpx/whpx-all.c                           | 4 ++--
> target/i386/whpx/whpx-internal.h                      | 1 +
> 8 files changed, 14 insertions(+), 5 deletions(-)
> create mode 100644 accel/whpx/meson.build
> rename {target/i386 =3D> accel}/whpx/whpx-accel-ops.c (97%)
> rename {target/i386/whpx =3D> include/system}/whpx-accel-ops.h (100%)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 28cea34271..238065e1c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -542,9 +542,11 @@ F: include/system/hvf_int.h
> WHPX CPUs
> M: Sunil Muthuswamy <sunilmut@microsoft.com>
> S: Supported
> +F: accel/whpx/
> F: target/i386/whpx/
> F: accel/stubs/whpx-stub.c
> F: include/system/whpx.h
> +F: include/system/whpx-accel-ops.h
>=20
> X86 Instruction Emulator
> M: Cameron Esfahani <dirty@apple.com>
> diff --git a/accel/meson.build b/accel/meson.build
> index 25b0f100b5..de927a3b37 100644
> --- a/accel/meson.build
> +++ b/accel/meson.build
> @@ -6,6 +6,7 @@ user_ss.add(files('accel-user.c'))
> subdir('tcg')
> if have_system
>   subdir('hvf')
> +  subdir('whpx')
>   subdir('qtest')
>   subdir('kvm')
>   subdir('xen')
> diff --git a/accel/whpx/meson.build b/accel/whpx/meson.build
> new file mode 100644
> index 0000000000..7b3d6f1c1c
> --- /dev/null
> +++ b/accel/whpx/meson.build
> @@ -0,0 +1,6 @@
> +whpx_ss =3D ss.source_set()
> +whpx_ss.add(files(
> +  'whpx-accel-ops.c',
> +))
> +
> +specific_ss.add_all(when: 'CONFIG_WHPX', if_true: whpx_ss)
> diff --git a/target/i386/whpx/whpx-accel-ops.c =
b/accel/whpx/whpx-accel-ops.c
> similarity index 97%
> rename from target/i386/whpx/whpx-accel-ops.c
> rename to accel/whpx/whpx-accel-ops.c
> index da58805b1a..18488421bc 100644
> --- a/target/i386/whpx/whpx-accel-ops.c
> +++ b/accel/whpx/whpx-accel-ops.c
> @@ -16,8 +16,8 @@
> #include "qemu/guest-random.h"
>=20
> #include "system/whpx.h"
> -#include "whpx-internal.h"
> -#include "whpx-accel-ops.h"
> +#include "system/whpx-internal.h"
> +#include "system/whpx-accel-ops.h"
>=20
> static void *whpx_cpu_thread_fn(void *arg)
> {
> diff --git a/target/i386/whpx/whpx-accel-ops.h =
b/include/system/whpx-accel-ops.h
> similarity index 100%
> rename from target/i386/whpx/whpx-accel-ops.h
> rename to include/system/whpx-accel-ops.h
> diff --git a/target/i386/whpx/meson.build =
b/target/i386/whpx/meson.build
> index 9c54aaad39..c3aaaff9fd 100644
> --- a/target/i386/whpx/meson.build
> +++ b/target/i386/whpx/meson.build
> @@ -1,5 +1,4 @@
> i386_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
>   'whpx-all.c',
>   'whpx-apic.c',
> -  'whpx-accel-ops.c',
> ))
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index b72dcff3c8..5a431fc3c7 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -31,8 +31,8 @@
> #include "accel/accel-cpu-target.h"
> #include <winerror.h>
>=20
> -#include "whpx-internal.h"
> -#include "whpx-accel-ops.h"
> +#include "system/whpx-internal.h"
> +#include "system/whpx-accel-ops.h"
>=20
> #include <winhvplatform.h>
> #include <winhvemulation.h>
> diff --git a/target/i386/whpx/whpx-internal.h =
b/target/i386/whpx/whpx-internal.h
> index 6633e9c4ca..435e0c5046 100644
> --- a/target/i386/whpx/whpx-internal.h
> +++ b/target/i386/whpx/whpx-internal.h
> @@ -117,3 +117,4 @@ typedef enum WHPFunctionList {
> } WHPFunctionList;
>=20
> #endif /* TARGET_I386_WHPX_INTERNAL_H */
> +
> --=20
> 2.39.5 (Apple Git-154)
>=20


--Apple-Mail=_6A57F2AD-D1FD-4CFB-9A7F-E696D24B66DF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;">Note: I _also_ screwed up this rebase a =
bit unfortunately but this one should be clean:&nbsp;<a =
href=3D"https://github.com/mediouni-m/qemu/commit/66f052d80b6b51a60374074c=
ec876f9bfc8a756c">https://github.com/mediouni-m/qemu/commit/66f052d80b6b51=
a60374074cec876f9bfc8a756c</a>&nbsp;<div><br></div><div>To not cause too =
much spam on the ML will most likely batch this when I have more =
changes...</div><div><br></div><div><div><blockquote type=3D"cite"><div>On=
 2. Aug 2025, at 10:17, Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>Switch to a design where =
we can share whpx code between x86 and AArch64 when it makes sense to do =
so.<br><br>Signed-off-by: Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt;<br><br>Reviewed-by: Philippe =
Mathieu-Daud=C3=A9 &lt;philmd@linaro.org&gt;<br>---<br> MAINTAINERS =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 2 ++<br> accel/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 1 =
+<br> accel/whpx/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 6 ++++++<br> {target/i386 =3D&gt; =
accel}/whpx/whpx-accel-ops.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 4 ++--<br> =
{target/i386/whpx =3D&gt; include/system}/whpx-accel-ops.h | 0<br> =
target/i386/whpx/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;| 1 -<br> target/i386/whpx/whpx-all.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;| 4 ++--<br> target/i386/whpx/whpx-internal.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 1 +<br> 8 files =
changed, 14 insertions(+), 5 deletions(-)<br> create mode 100644 =
accel/whpx/meson.build<br> rename {target/i386 =3D&gt; =
accel}/whpx/whpx-accel-ops.c (97%)<br> rename {target/i386/whpx =3D&gt; =
include/system}/whpx-accel-ops.h (100%)<br><br>diff --git a/MAINTAINERS =
b/MAINTAINERS<br>index 28cea34271..238065e1c9 100644<br>--- =
a/MAINTAINERS<br>+++ b/MAINTAINERS<br>@@ -542,9 +542,11 @@ F: =
include/system/hvf_int.h<br> WHPX CPUs<br> M: Sunil Muthuswamy =
&lt;sunilmut@microsoft.com&gt;<br> S: Supported<br>+F: accel/whpx/<br> =
F: target/i386/whpx/<br> F: accel/stubs/whpx-stub.c<br> F: =
include/system/whpx.h<br>+F: include/system/whpx-accel-ops.h<br><br> X86 =
Instruction Emulator<br> M: Cameron Esfahani =
&lt;dirty@apple.com&gt;<br>diff --git a/accel/meson.build =
b/accel/meson.build<br>index 25b0f100b5..de927a3b37 100644<br>--- =
a/accel/meson.build<br>+++ b/accel/meson.build<br>@@ -6,6 +6,7 @@ =
user_ss.add(files('accel-user.c'))<br> subdir('tcg')<br> if =
have_system<br> &nbsp;&nbsp;subdir('hvf')<br>+ &nbsp;subdir('whpx')<br> =
&nbsp;&nbsp;subdir('qtest')<br> &nbsp;&nbsp;subdir('kvm')<br> =
&nbsp;&nbsp;subdir('xen')<br>diff --git a/accel/whpx/meson.build =
b/accel/whpx/meson.build<br>new file mode 100644<br>index =
0000000000..7b3d6f1c1c<br>--- /dev/null<br>+++ =
b/accel/whpx/meson.build<br>@@ -0,0 +1,6 @@<br>+whpx_ss =3D =
ss.source_set()<br>+whpx_ss.add(files(<br>+ =
&nbsp;'whpx-accel-ops.c',<br>+))<br>+<br>+specific_ss.add_all(when: =
'CONFIG_WHPX', if_true: whpx_ss)<br>diff --git =
a/target/i386/whpx/whpx-accel-ops.c =
b/accel/whpx/whpx-accel-ops.c<br>similarity index 97%<br>rename from =
target/i386/whpx/whpx-accel-ops.c<br>rename to =
accel/whpx/whpx-accel-ops.c<br>index da58805b1a..18488421bc =
100644<br>--- a/target/i386/whpx/whpx-accel-ops.c<br>+++ =
b/accel/whpx/whpx-accel-ops.c<br>@@ -16,8 +16,8 @@<br> #include =
"qemu/guest-random.h"<br><br> #include "system/whpx.h"<br>-#include =
"whpx-internal.h"<br>-#include "whpx-accel-ops.h"<br>+#include =
"system/whpx-internal.h"<br>+#include "system/whpx-accel-ops.h"<br><br> =
static void *whpx_cpu_thread_fn(void *arg)<br> {<br>diff --git =
a/target/i386/whpx/whpx-accel-ops.h =
b/include/system/whpx-accel-ops.h<br>similarity index 100%<br>rename =
from target/i386/whpx/whpx-accel-ops.h<br>rename to =
include/system/whpx-accel-ops.h<br>diff --git =
a/target/i386/whpx/meson.build b/target/i386/whpx/meson.build<br>index =
9c54aaad39..c3aaaff9fd 100644<br>--- =
a/target/i386/whpx/meson.build<br>+++ =
b/target/i386/whpx/meson.build<br>@@ -1,5 +1,4 @@<br> =
i386_system_ss.add(when: 'CONFIG_WHPX', if_true: files(<br> =
&nbsp;&nbsp;'whpx-all.c',<br> &nbsp;&nbsp;'whpx-apic.c',<br>- =
&nbsp;'whpx-accel-ops.c',<br> ))<br>diff --git =
a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c<br>index =
b72dcff3c8..5a431fc3c7 100644<br>--- =
a/target/i386/whpx/whpx-all.c<br>+++ b/target/i386/whpx/whpx-all.c<br>@@ =
-31,8 +31,8 @@<br> #include "accel/accel-cpu-target.h"<br> #include =
&lt;winerror.h&gt;<br><br>-#include "whpx-internal.h"<br>-#include =
"whpx-accel-ops.h"<br>+#include "system/whpx-internal.h"<br>+#include =
"system/whpx-accel-ops.h"<br><br> #include &lt;winhvplatform.h&gt;<br> =
#include &lt;winhvemulation.h&gt;<br>diff --git =
a/target/i386/whpx/whpx-internal.h =
b/target/i386/whpx/whpx-internal.h<br>index 6633e9c4ca..435e0c5046 =
100644<br>--- a/target/i386/whpx/whpx-internal.h<br>+++ =
b/target/i386/whpx/whpx-internal.h<br>@@ -117,3 +117,4 @@ typedef enum =
WHPFunctionList {<br> } WHPFunctionList;<br><br> #endif /* =
TARGET_I386_WHPX_INTERNAL_H */<br>+<br>-- <br>2.39.5 (Apple =
Git-154)<br><br></div></div></blockquote></div><br></div></body></html>=

--Apple-Mail=_6A57F2AD-D1FD-4CFB-9A7F-E696D24B66DF--

