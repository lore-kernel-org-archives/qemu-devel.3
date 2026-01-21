Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414DBC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYL9-0005Zk-Of; Wed, 21 Jan 2026 08:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYKa-0005W8-OB
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:33:12 -0500
Received: from qs-2001a-snip4-11.eps.apple.com ([57.103.87.13]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYKX-0006r5-2f
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:33:07 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-15 (Postfix) with ESMTPS id
 AB034180039B; Wed, 21 Jan 2026 13:33:00 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769002383; x=1771594383;
 bh=wNb5eiry54YOrWs/lZjI4Le9RV9HahCtR9rjd6Jq9Jc=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=P8/Jigvy3NXrQ5elcbML2xLTrN/rU88+oAz1F3oMI0CcVltX+imFUdJZsEG/oGVwYAMCXoTde5Aw7b5jXwOIjsOOA/QBf9jCowUUG/vG22kcxy2jSeEqRNEft++UnH9A0CEfX4g047y33xa1594noMgxfX08UmzpAEDwtieMrjeTQYjRUY9sVrx2txhfgWMR9+wV+uh85hQVsWlJsRCIkuHaWBm4oi/l6xaNu68FRBDfMFfNv0CPCnJRi6ls2e8DR17pkYUgsmlmm+r3w0lxgWJMi3GtbaJnk3cVbFH+/p8bVofZve+KRQ4vHE6XbeXohEnKvaBLl6NR7qswRxa2vw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-15 (Postfix) with ESMTPSA id
 6A7701800177; Wed, 21 Jan 2026 13:32:58 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <3A3AFA55-F23F-4BBE-BC55-7DE1852C7AB0@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_42248C7F-1A32-4D6B-86DC-3179A59B634A"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v16 10/26] whpx: reshuffle common code
Date: Wed, 21 Jan 2026 14:32:46 +0100
In-Reply-To: <344c726f-32d0-44a9-9084-edfc64dedb75@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-11-mohamed@unpredictable.fr>
 <344c726f-32d0-44a9-9084-edfc64dedb75@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Authority-Info-Out: v=2.4 cv=HOrO14tv c=1 sm=1 tr=0 ts=6970d58d
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=2tszAsSru-KCW1Neg1kA:9 a=QEXdDO2ut3YA:10
 a=lfeUBk0vAohLVyIIPfsA:9 a=8J9mXnSVkOHv8ThS:21 a=_W_S_7VecoQA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: bMZpBH6QQgGRb8DMUp6iou27YEjuc1gD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExNCBTYWx0ZWRfXyINjIZ5aFX2Z
 xYirf8NlgPtDmqwapz7OzoeZITTvyYyQorlmyOOxkJT1WcvwPECi/JjB+heVj4LRQPKiRD9S7eL
 BmuuvXpfzDh9ShLJck2KArpRyhl3x5WC42AgcFqzY2NYWB/mBCMwK8mO32ExpOn6AY/blz9qL67
 BARG7IE9VITsa94FFUgknunT7tbyVZ/SYU5Dqvhjh8CZsePVXbAQlNcQdxJDUvrGahdbFsIqdh0
 7rplFiW8mTktbaMCfvjDTfSrcGwfF4Iya1Y2W9XAwUnLvqB2j8ZpkTcPCQQAH4vJrm6f1siFbMZ
 Rm6+vWOAdlyHr0Z8NHQ
X-Proofpoint-ORIG-GUID: bMZpBH6QQgGRb8DMUp6iou27YEjuc1gD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=482 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601210114
X-JNJ: AAAAAAABvpFPVDDv32hxe/R08W8UMsDjK2zalGdDhvhelbn/kmyNdmsY3dbNljS5XIAhu9ej965e4tY2yQczDCXIDBsw/XoECn/HTlN9TxLrVKqE9jb9Pg87RpgvzU8eDrii99mUY9rVQwjob3AysyhNmJ7QBwLqmO62ddQeHnsz+fzevzDXhoznh2MZmVsnAuaCLZPN+otCEmynt3QKGFrgaf6TIK1rsQ3U2wVv0zObtLAGh6M5v7x13yCeHIj1VltZNj87mf/3vimHeSD4kENRFcRXbDc2b9IzFtdkGIfbfanoEauhWL/FpaF2nNPXob0Lpp7rpydSKwEwzOXfJGnNBXNJVEjBGr2ptDk111cOKb2xjtCEGydg8j5/T05hN+bTeIz1tn2G+N0vyZrJhtL1sF3v3eZvUdCKhDZlItLmJeqUw4fb61xV0IrCfVFnzCpWsBubvGU04uKWbk+xRjiKmfGiW6DReborJEQtdCBlUT4fTe/8IKmXuGGbdB4McapmTaNXK9h4lD9Y2TbU12R88IxHnUOPELekynRLkk3XJKF5zkrqqm1WdoWjbwDbGSUeN2a5jx64woItoqh9xF74+fuOunwW0DUr6p75BnwCTfvhDoyIgQE3pM2CfUreJzuEa3JLRnzAsJkdgan0mW1dSl32WA574tmedHw3A5eUJZ3TdiplDsA9i7tHGp3WaSpOUjvE1Ce6kdM7Vd0VH5QTia2DWjLjE3W7cjZuw5595wzrDD45Hd5kv2WDNWFRTRWDZW2JupKaDh62DNr6+LxEPl9vCg+wISpqcCavTlOmUg5zAw==
Received-SPF: pass client-ip=57.103.87.13;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--Apple-Mail=_42248C7F-1A32-4D6B-86DC-3179A59B634A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 16. Jan 2026, at 15:20, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 16/1/26 14:52, Mohamed Mediouni wrote:
>> Some code can be shared between x86_64 and arm64 WHPX. Do so as much =
as reasonable.
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>  MAINTAINERS                  |   2 +
>>  accel/whpx/meson.build       |   1 +
>>  accel/whpx/whpx-common.c     | 558 =
+++++++++++++++++++++++++++++++++++
>>  include/system/whpx-all.h    |  20 ++
>>  include/system/whpx-common.h |  21 ++
>>  target/i386/whpx/whpx-all.c  | 551 =
+---------------------------------
>>  6 files changed, 612 insertions(+), 541 deletions(-)
>>  create mode 100644 accel/whpx/whpx-common.c
>>  create mode 100644 include/system/whpx-all.h
>>  create mode 100644 include/system/whpx-common.h
>=20
>=20
>> diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
>> new file mode 100644
>> index 0000000000..f13cdf7f66
>> --- /dev/null
>> +++ b/include/system/whpx-all.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +#ifndef SYSTEM_WHPX_ALL_H
>> +#define SYSTEM_WHPX_ALL_H
>> +
>> +/* Called by whpx-common */
>> +int whpx_vcpu_run(CPUState *cpu);
>> +void whpx_get_registers(CPUState *cpu);
>> +void whpx_set_registers(CPUState *cpu, int level);
>> +int whpx_accel_init(AccelState *as, MachineState *ms);
>> +void whpx_cpu_instance_init(CPUState *cs);
>> +HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions);
>> +void whpx_apply_breakpoints(
>> +struct whpx_breakpoint_collection *breakpoints,
>> +    CPUState *cpu,
>> +    bool resuming);
>> +void whpx_translate_cpu_breakpoints(
>> +    struct whpx_breakpoints *breakpoints,
>> +    CPUState *cpu,
>> +    int cpu_breakpoint_count);
>> +#endif
>> diff --git a/include/system/whpx-common.h =
b/include/system/whpx-common.h
>> new file mode 100644
>> index 0000000000..e549c7539c
>> --- /dev/null
>> +++ b/include/system/whpx-common.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +#ifndef SYSTEM_WHPX_COMMON_H
>> +#define SYSTEM_WHPX_COMMON_H
>> +
>> +struct AccelCPUState {
>> +    WHV_EMULATOR_HANDLE emulator;
>> +    bool window_registered;
>> +    bool interruptable;
>> +    bool ready_for_pic_interrupt;
>> +    uint64_t tpr;
>> +    uint64_t apic_base;
>> +    bool interruption_pending;
>> +    /* Must be the last field as it may have a tail */
>> +    WHV_RUN_VP_EXIT_CONTEXT exit_ctx;
>> +};
>> +
>> +int whpx_first_vcpu_starting(CPUState *cpu);
>> +int whpx_last_vcpu_stopping(CPUState *cpu);
>> +void whpx_memory_init(void);
>> +struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t =
address);
>> +#endif
> I'd rather rename the target-specific handlers as
> whpx_foo() -> whpx_arch_foo() to help follow in common code
> when we are calling target-specific implementations.
> (can be done on top later if the series is good to go)

Hello,

Going to take care of this one with a post-merge follow-up patch, along
with moving the header location.



--Apple-Mail=_42248C7F-1A32-4D6B-86DC-3179A59B634A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 16. Jan 2026, at 15:20, Philippe Mathieu-Daud=C3=A9 =
&lt;philmd@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On 16/1/26 14:52, Mohamed Mediouni =
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
text-decoration-thickness: auto; text-decoration-style: solid;">Some =
code can be shared between x86_64 and arm64 WHPX. Do so as much as =
reasonable.<br>Signed-off-by: Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt;<br>Reviewed-by: Pierrick Bouvier =
&lt;pierrick.bouvier@linaro.org&gt;<br>---<br>&nbsp;MAINTAINERS =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;2 =
+<br>&nbsp;accel/whpx/meson.build &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;1 +<br>&nbsp;accel/whpx/whpx-common.c =
&nbsp;&nbsp;&nbsp;&nbsp;| 558 =
+++++++++++++++++++++++++++++++++++<br>&nbsp;include/system/whpx-all.h =
&nbsp;&nbsp;&nbsp;| &nbsp;20 ++<br>&nbsp;include/system/whpx-common.h | =
&nbsp;21 ++<br>&nbsp;target/i386/whpx/whpx-all.c &nbsp;| 551 =
+---------------------------------<br>&nbsp;6 files changed, 612 =
insertions(+), 541 deletions(-)<br>&nbsp;create mode 100644 =
accel/whpx/whpx-common.c<br>&nbsp;create mode 100644 =
include/system/whpx-all.h<br>&nbsp;create mode 100644 =
include/system/whpx-common.h<br></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;">diff --git a/include/system/whpx-all.h =
b/include/system/whpx-all.h<br>new file mode 100644<br>index =
0000000000..f13cdf7f66<br>--- /dev/null<br>+++ =
b/include/system/whpx-all.h<br>@@ -0,0 +1,20 @@<br>+/* =
SPDX-License-Identifier: GPL-2.0-or-later */<br>+#ifndef =
SYSTEM_WHPX_ALL_H<br>+#define SYSTEM_WHPX_ALL_H<br>+<br>+/* Called by =
whpx-common */<br>+int whpx_vcpu_run(CPUState *cpu);<br>+void =
whpx_get_registers(CPUState *cpu);<br>+void whpx_set_registers(CPUState =
*cpu, int level);<br>+int whpx_accel_init(AccelState *as, MachineState =
*ms);<br>+void whpx_cpu_instance_init(CPUState *cs);<br>+HRESULT =
whpx_set_exception_exit_bitmap(UINT64 exceptions);<br>+void =
whpx_apply_breakpoints(<br>+struct whpx_breakpoint_collection =
*breakpoints,<br>+ &nbsp;&nbsp;&nbsp;CPUState *cpu,<br>+ =
&nbsp;&nbsp;&nbsp;bool resuming);<br>+void =
whpx_translate_cpu_breakpoints(<br>+ &nbsp;&nbsp;&nbsp;struct =
whpx_breakpoints *breakpoints,<br>+ &nbsp;&nbsp;&nbsp;CPUState =
*cpu,<br>+ &nbsp;&nbsp;&nbsp;int =
cpu_breakpoint_count);<br>+#endif<br>diff --git =
a/include/system/whpx-common.h b/include/system/whpx-common.h<br>new =
file mode 100644<br>index 0000000000..e549c7539c<br>--- /dev/null<br>+++ =
b/include/system/whpx-common.h<br>@@ -0,0 +1,21 @@<br>+/* =
SPDX-License-Identifier: GPL-2.0-or-later */<br>+#ifndef =
SYSTEM_WHPX_COMMON_H<br>+#define SYSTEM_WHPX_COMMON_H<br>+<br>+struct =
AccelCPUState {<br>+ &nbsp;&nbsp;&nbsp;WHV_EMULATOR_HANDLE =
emulator;<br>+ &nbsp;&nbsp;&nbsp;bool window_registered;<br>+ =
&nbsp;&nbsp;&nbsp;bool interruptable;<br>+ &nbsp;&nbsp;&nbsp;bool =
ready_for_pic_interrupt;<br>+ &nbsp;&nbsp;&nbsp;uint64_t tpr;<br>+ =
&nbsp;&nbsp;&nbsp;uint64_t apic_base;<br>+ &nbsp;&nbsp;&nbsp;bool =
interruption_pending;<br>+ &nbsp;&nbsp;&nbsp;/* Must be the last field =
as it may have a tail */<br>+ &nbsp;&nbsp;&nbsp;WHV_RUN_VP_EXIT_CONTEXT =
exit_ctx;<br>+};<br>+<br>+int whpx_first_vcpu_starting(CPUState =
*cpu);<br>+int whpx_last_vcpu_stopping(CPUState *cpu);<br>+void =
whpx_memory_init(void);<br>+struct whpx_breakpoint =
*whpx_lookup_breakpoint_by_addr(uint64_t =
address);<br>+#endif<br></blockquote><span style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">I'd rather rename the target-specific =
handlers as</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
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
display: inline !important;">whpx_foo() -&gt; whpx_arch_foo() to help =
follow in common code</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
display: inline !important;">when we are calling target-specific =
implementations.</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
display: inline !important;">(can be done on top later if the series is =
good to =
go)</span></div></blockquote><br></div><div>Hello,</div><div><br></div><di=
v>Going to take care of this one with a post-merge follow-up patch, =
along</div><div>with moving the header =
location.</div><div><br></div><br></body></html>=

--Apple-Mail=_42248C7F-1A32-4D6B-86DC-3179A59B634A--

