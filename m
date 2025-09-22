Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87146CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 20:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0nbc-0001Nc-NT; Mon, 22 Sep 2025 16:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v0nbb-0001N8-MF
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 16:57:51 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v0nbZ-0000Rj-Ce
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 16:57:51 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 08B1D60AE6
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 22:57:47 +0200 (CEST)
Received: (qmail 28059 invoked by uid 990); 22 Sep 2025 20:57:46 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 22 Sep 2025 22:57:46 +0200
MIME-Version: 1.0
Date: Mon, 22 Sep 2025 20:57:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <a24c4ba3080e79d67596dd966ec9d29da15e25ba@nut.email>
TLS-Required: No
Subject: Re: [PATCH v6 03/25] plugins: add hooks for new discontinuity
 related callbacks
To: "=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=" <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>, "Alexandre
 Iooss" <erdnaxe@crans.org>, "Mahmoud Mandour" <ma.mandourr@gmail.com>,
 "Pierrick Bouvier" <pierrick.bouvier@linaro.org>
In-Reply-To: <cf87d645-c125-4c3c-b909-4eaabfcaa41c@linaro.org>
References: <cover.1757018626.git.neither@nut.email>
 <03eab59217365665b60ac169723ab689d2a97be4.1757018626.git.neither@nut.email>
 <cf87d645-c125-4c3c-b909-4eaabfcaa41c@linaro.org>
X-Rspamd-Bar: -
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.999999) MIME_GOOD(-0.1)
X-Rspamd-Score: -1.599999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=2M7BrmFT632ZK5zwxj0cVj9OnFwHTx8HFM5zKKJti/U=;
 b=GM4f3IPyYBuIx6MpBNmAMmIlc30A3VtEtqVtyW19c11VswcQkTQrpz2J0USWKlgqenflrRs4wa
 u3JLR2gqRCOetPwAfgJfsYhNF6vIRWyehScohKNbc40GMPGO2yV47jRs6Sg9RSUtbtKt5qn8Lwtz
 BXoMdMRDwclPjLkjjaU+2xBXqYcq3O3Pjyy3irSZll20UTtpRu/rXvQ7ynHDUEHqXk1TJm1aly8b
 MgPO39YnNMfpOxFdLvprKWfCPNwVNTwa3iTSbHJuHpUIA7oyF7YeUaznX7Rx70F+YmXPKW+/oenQ
 UPFj71zIW+Cq11oVF/+kYmF6YQRgsr8mp0ShPe2r0UNKQ2o7bnasDDT/hGxFIRtlWVD5P9uaIBLG
 J7ihqGCjJtdHwVO/1Ctw6zqpklBj5epFpDxSuCdR5cCrDI3eyCHod0IrbYGqmz5vW4AmwNdH6fWL
 cmy1vAM2pHLAmamOv7uUNXl/KeRbsfQ2m9MtHTiFogu65XX9mDO9iDTs8vfx1zg91gdw8wmnzBzM
 Ix9znjFBYof+S1KZPSEdU484N6Nf2BmTMLaf0ZWm9eU/794mAZyd7bf/EURn8bFNlzC+psd0/GXJ
 KPXI+HQNIUCEr7U8tTTHCT6fubhI9HzpepOgv6Q9jKsxXWErlyepWd+MeBrjwVpdpzhS1J8Du/3+
 k=
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

Hi Philippe,

September 22, 2025 at 1:34 PM, "Philippe Mathieu-Daud=C3=A9" wrote:
> On 4/9/25 22:46, Julian Ganz wrote:
>=20
>=20>=20
>=20> The plugin API allows registration of callbacks for a variety of VC=
PU
> >  related events, such as VCPU reset, idle and resume. In addition, we
> >  recently introduced API for registering callbacks for discontinuity
> >  events, specifically for interrupts, exceptions and host calls.
> >  This change introduces the corresponding hooks called from target
> >  specific code inside qemu.
> >  Signed-off-by: Julian Ganz <neither@nut.email>
> >  ---
> >  include/qemu/plugin.h | 12 ++++++++++++
> >  plugins/core.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 54 insertions(+)
> >  diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> >  index 8cf20cd96f..cea0a68858 100644
> >  --- a/include/qemu/plugin.h
> >  +++ b/include/qemu/plugin.h
> >  @@ -161,6 +161,9 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu);
> >  void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *t=
b);
> >  void qemu_plugin_vcpu_idle_cb(CPUState *cpu);
> >  void qemu_plugin_vcpu_resume_cb(CPUState *cpu);
> >  +void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from);
> >  +void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from);
> >  +void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from);
> >  void
> >  qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
> >  uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
> >  @@ -258,6 +261,15 @@ static inline void qemu_plugin_vcpu_idle_cb(CPU=
State *cpu)
> >  static inline void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
> >  { }
> >  > +static inline void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, u=
int64_t from)
> >  +{ }
> >  +
> >  +static inline void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uin=
t64_t from)
> >  +{ }
> >  +
> >  +static inline void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint=
64_t from)
> >  +{ }
> >  +
> >  static inline void
> >  qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, ui=
nt64_t a2,
> >  uint64_t a3, uint64_t a4, uint64_t a5, uint64_t a6,
> >  diff --git a/plugins/core.c b/plugins/core.c
> >  index a04cb2392d..1f0ddebcbf 100644
> >  --- a/plugins/core.c
> >  +++ b/plugins/core.c
> >  @@ -105,6 +105,30 @@ static void plugin_vcpu_cb__simple(CPUState *cp=
u, enum qemu_plugin_event ev)
> >  }
> >  }
> >  > +/*
> >  + * Disable CFI checks.
> >  + * The callback function has been loaded from an external library s=
o we do not
> >  + * have type information
> >  + */
> >  +QEMU_DISABLE_CFI
> >  +static void plugin_vcpu_cb__discon(CPUState *cpu,
> >  + enum qemu_plugin_event ev,
> >  + enum qemu_plugin_discon_type type,
> >  + uint64_t from)
> >  +{
> >  + struct qemu_plugin_cb *cb, *next;
> >  + uint64_t to =3D cpu->cc->get_pc(cpu);
> >  +
> >  + if (cpu->cpu_index < plugin.num_vcpus) {
> >  + /* iterate safely; plugins might uninstall themselves at any time =
*/
> >  + QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
> >  + qemu_plugin_vcpu_discon_cb_t func =3D cb->f.vcpu_discon;
> >  +
> >  + func(cb->ctx->id, cpu->cpu_index, type, from, to);
> >  + }
> >  + }
> >  +}
> >  +
> >  /*
> >  * Disable CFI checks.
> >  * The callback function has been loaded from an external library so =
we do not
> >  @@ -557,6 +581,24 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
> >  }
> >  }
> >  > +void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from)
> >  +{
> >  + plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_EV_VCPU_INTERRUPT,
> >  + QEMU_PLUGIN_DISCON_INTERRUPT, from);
> >  +}
> >  +
> >  +void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from)
> >  +{
> >  + plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_EV_VCPU_EXCEPTION,
> >  + QEMU_PLUGIN_DISCON_EXCEPTION, from);
> >  +}
> >  +
> >  +void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from)
> >  +{
> >  + plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_EV_VCPU_HOSTCALL,
> >  + QEMU_PLUGIN_DISCON_HOSTCALL, from);
> >  +}
> >=20
>=20No blocking question; do we really need one callback for each discon
> type? (can't we just pass the type by argument?).

Yes we could, but the enum would likely end up more noisy. And we would
need to translate discon type to (plugin API) event type again. And we
just got rid of that in the last iteration.

Regards,
Julian

