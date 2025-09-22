Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A72CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 21:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0npv-0006MN-Ca; Mon, 22 Sep 2025 17:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v0npt-0006L0-2J
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 17:12:37 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v0npq-0002jt-EA
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 17:12:36 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 7480960A93
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 23:12:32 +0200 (CEST)
Received: (qmail 7240 invoked by uid 990); 22 Sep 2025 21:12:32 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 22 Sep 2025 23:12:32 +0200
MIME-Version: 1.0
Date: Mon, 22 Sep 2025 21:12:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <6c4cd09a52fc4b671767fda086dc4692f676eeca@nut.email>
TLS-Required: No
Subject: Re: [PATCH v6 22/25] target/xtensa: call plugin trap callbacks
To: "=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=" <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Max Filippov" <jcmvbkbc@gmail.com>
In-Reply-To: <4226caa6-9f8e-4079-a4c6-13e557120eef@linaro.org>
References: <cover.1757018626.git.neither@nut.email>
 <e54cd13ab5f6471e319816d34d50f4882e37c4e3.1757018626.git.neither@nut.email>
 <4226caa6-9f8e-4079-a4c6-13e557120eef@linaro.org>
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-2.999593) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.099593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=FoR+K2x8U4ZXRFWqgjl/oyBAfBjbwq7/vTm8Mhv5LMc=;
 b=dRyUeUnVngNKXbTtkT2vFVEaebflUxKs93T/Mauv9Oc+5I2c/esUHF9IhK8N/Jzm6dFfuCCFGG
 Nzcs8eEH0lchrwuVmGGkgLcE2UC3uNpB/6LdGncmZz+d40nflGl583SFcnTHLf2nPlUdbaFmb+sX
 kGuBmDvUCofE8pso1pIxNiP1fbk4Hr2Qvc3izbwyNr6Gl41kaFtEEup4x9oLZUQR7qVMSyMbt1tz
 15Kv5HBYes9noG7fr2kkWvgZEg8V17XkW+CeR76+moszdIW+8coHVOGsac9xSBOpVWQKhfTtX78i
 geaL+49SCqupy/GsphqRJlIINvNQeAZ2bPzeTVyeaF65XWw3IB4PsJ3amSOQjRxvSTAAmnMBnqNU
 6UHlf5fhbmN2yOaaYtC9w2QBEhVe25PKmBbGQE/wtS8urigpYzPWEQmIrsrzsUGlJMZ7wpsJhxhZ
 uP/XpxgVCX4MI8cJblQns+yYynLjO0nNF6K7t8q1tqR+QVxdfUm4RGITeFlikVwaoUAwva96Rx1A
 FXUwl0gGzpg2o4/cP/I9hMsh0n30mn9y4F4/LFiWc66w52t/lRYQqjqv02x1WxoR+amlrLr/Byvn
 DGVVM3ovp2ojqgzsEqTu0UL5Y1jj6AuKJ3b40K6Ot1omE7HFrywat87NgLLTN9gbPB8OHRC3qvYl
 s=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

September 22, 2025 at 1:47 PM, "Philippe Mathieu-Daud=C3=A9" wrote:
> On 4/9/25 22:48, Julian Ganz wrote:
> > We recently introduced API for registering callbacks for trap related
> >  events as well as the corresponding hook functions. Due to differenc=
es
> >  between architectures, the latter need to be called from target spec=
ific
> >  code.
> >  This change places hooks for xtensa targets.
> >  Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
> >  Signed-off-by: Julian Ganz <neither@nut.email>
> >  ---
> >  target/xtensa/exc_helper.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >  diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
> >  index b611c9bf97..fdc522698d 100644
> >  --- a/target/xtensa/exc_helper.c
> >  +++ b/target/xtensa/exc_helper.c
> >  @@ -32,6 +32,7 @@
> >  #include "exec/helper-proto.h"
> >  #include "qemu/host-utils.h"
> >  #include "qemu/atomic.h"
> >  +#include "qemu/plugin.h"
> >  > void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
> >  {
> >  @@ -207,6 +208,8 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
> >  CPUXtensaState *env =3D cpu_env(cs);
> >  > if (cs->exception_index =3D=3D EXC_IRQ) {
> >  + uint64_t last_pc =3D env->pc;
> >  +
> >  qemu_log_mask(CPU_LOG_INT,
> >  "%s(EXC_IRQ) level =3D %d, cintlevel =3D %d, "
> >  "pc =3D %08x, a0 =3D %08x, ps =3D %08x, "
> >  @@ -218,6 +221,7 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
> >  env->sregs[INTSET], env->sregs[INTENABLE],
> >  env->sregs[CCOUNT]);
> >  handle_interrupt(env);
> >  + qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> >  }
> >  > switch (cs->exception_index) {
> >  @@ -238,9 +242,11 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
> >  env->sregs[CCOUNT]);
> >  if (env->config->exception_vector[cs->exception_index]) {
> >  uint32_t vector;
> >  + uint64_t last_pc =3D env->pc;
> >  > vector =3D env->config->exception_vector[cs->exception_index];
> >  env->pc =3D relocated_vector(env, vector);
> >  + qemu_plugin_vcpu_exception_cb(cs, last_pc);
> >  } else {
> >  qemu_log_mask(CPU_LOG_INT,
> >  "%s(pc =3D %08x) bad exception_index: %d\n",
> >=20
>=20Should we call qemu_plugin_vcpu_hostcall_cb() in SIMCALL opcode?

Probably yes. Thanks for catching that!

Regards,
Julian

