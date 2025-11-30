Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B06CFD376
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Nov 2025 09:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPdy8-0005Kn-UN; Sun, 30 Nov 2025 04:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vPdxz-0005Jf-8o
 for qemu-devel@nongnu.org; Sun, 30 Nov 2025 04:43:39 -0500
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vPdxx-0001Nj-3t
 for qemu-devel@nongnu.org; Sun, 30 Nov 2025 04:43:38 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 546A560D21
 for <qemu-devel@nongnu.org>; Sun, 30 Nov 2025 10:43:23 +0100 (CET)
Received: (qmail 16593 invoked by uid 990); 30 Nov 2025 09:43:23 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 30 Nov 2025 10:43:23 +0100
MIME-Version: 1.0
Date: Sun, 30 Nov 2025 09:43:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <4a79aaed42d1800b36bab77ace699a946be24722@nut.email>
TLS-Required: No
Subject: Re: [PATCH 5/5] plugins/core: allow reading of registers during
 discon events
To: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Paolo Bonzini" <pbonzini@redhat.com>, "Markus Armbruster"
 <armbru@redhat.com>, "Mahmoud Mandour" <ma.mandourr@gmail.com>, "Pierrick
 Bouvier" <pierrick.bouvier@linaro.org>, "Alexandre Iooss"
 <erdnaxe@crans.org>, "=?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?="
 <berrange@redhat.com>, "=?utf-8?B?QWxleCBCZW5uw6ll?="
 <alex.bennee@linaro.org>, "Thomas Huth" <thuth@redhat.com>,
 "=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=" <philmd@linaro.org>
In-Reply-To: <20251128182157.4125745-6-alex.bennee@linaro.org>
References: <20251128182157.4125745-1-alex.bennee@linaro.org>
 <20251128182157.4125745-6-alex.bennee@linaro.org>
X-Rspamd-Bar: -
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.999999) MIME_GOOD(-0.1)
X-Rspamd-Score: -1.599999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=TOz/PB3x0kOVxJH2ioHu8aFrURW9JVscAHUW1tH0xF8=;
 b=UJAV0FArwiYs2He845/dLrl2TseesaWOe8wTQgq13Zj13jw4wWJfR0n2xHGsn+EkuEWgb7BW6i
 Mg0OV88cfq+/13ukTHamtrIkRDOGOCotjAQF0H/i4ML7lSFeKUep1sbawL/A/sFlPjPbgx/jVCSK
 sPrxaPqJ4+Jt2/ijScVKTj6ss2dAdcuZ5eY/R23muJpjyz7M6oMFCSyx5V743iVe6yuK9v/l4MgB
 3Ehs7vrqS0uTfcOlbgxhHEkx4npWYEbS7Erz4P+gu4/VleX5UrxDYjrZrvlfwsznQ7/OXfEVwva4
 ozSwaAt22NspytDHCVgkNV/mb8VR7f96nxfLQBJv3VRyXrKu10CzviDsCgWwWIS+nLtQYxGSbKqM
 o7e4m7/xEHsM0lytlCuaEmAZPff4ypY7cFFEnKT7QmmLYDlygzJjOIUNEA6jDTWm1P9wpB0p8pPx
 CdbMkPGR46ByFSFfhqsEr8maM8WtX39Wmw5RTnRoLaxXIcADUW9EdkLKcDw3qA83VTT9H72TrPBC
 Q1zLOXPI3aB1szdlRikXSyefdjIk0ISd5PmyBWg+lzeiz9Mfc01mn84hUm+qo5kfXuXFVviMUvRF
 Nyv7e8UVaxR013lw7X2uMG38aSpO5xyc4dehUqPOUBooFwaCZkeNdTXp0PNlGedKn8Vc9V2AUNie
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

Hi Alex,

November 28, 2025 at 7:21 PM, "Alex Benn=C3=A9e" wrote:
> We have protections that prevent callbacks that didn't declare
> themselves as wanting to access registers. However for discontinuities
> the system state is fully rectified so they should always be able to
> read the register values.
>=20
>=20a1688bc86ce (plugins: add hooks for new discontinuity related callbac=
ks)
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Julian Ganz <neither@nut.email>
> ---
>  plugins/core.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
>=20diff --git a/plugins/core.c b/plugins/core.c
> index 8f8bc7219c2..b4b783008f7 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -119,6 +119,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
>  struct qemu_plugin_cb *cb, *next;
>  uint64_t to =3D cpu->cc->get_pc(cpu);
>=20=20
>=20+ qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
>  if (cpu->cpu_index < plugin.num_vcpus) {
>  /* iterate safely; plugins might uninstall themselves at any time */
>  QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
> @@ -127,6 +128,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
>  func(cb->ctx->id, cpu->cpu_index, type, from, to);
>  }
>  }
> + qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>  }

Yes, we definitely want this.

Reviewed-by: Julian Ganz <neither@nut.email>

Regards,
Julian

