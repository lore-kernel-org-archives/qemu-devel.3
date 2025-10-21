Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A17ACCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJ7q-0001FA-Rg; Tue, 21 Oct 2025 16:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vBJ7o-0001DR-L1
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:38:32 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vBJ7l-0007mu-QJ
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:38:32 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id F20B860E3A
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 22:38:23 +0200 (CEST)
Received: (qmail 21228 invoked by uid 990); 21 Oct 2025 20:38:23 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Tue, 21 Oct 2025 22:38:23 +0200
MIME-Version: 1.0
Date: Tue, 21 Oct 2025 20:38:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <20bf0927d2331f70d92048726362558d78caa4a8@nut.email>
TLS-Required: No
Subject: Re: [PATCH v8 05/25] target/alpha: call plugin trap callbacks
To: "=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=" <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Richard Henderson" <richard.henderson@linaro.org>
In-Reply-To: <2a0a4cde-1427-4d87-a331-f4ed6fa64aa2@linaro.org>
References: <cover.1760884672.git.neither@nut.email>
 <78ba254c812a91105bf52f6f0ce73774ee2be265.1760884672.git.neither@nut.email>
 <2a0a4cde-1427-4d87-a331-f4ed6fa64aa2@linaro.org>
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-2.999996) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.099996
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=1IARiEa4pidO8jEUcrex2Yhx+c0PT4Z63mvUTn3sJhA=;
 b=aZUyvYqDtKkkC8psK4IyUboNUuT4fUsMHTCGS8feeNZeQCu/HdaPNMrvMsQdLHhpJEbNZXykco
 wIp3+ky+UIR+n3LCfZXqnbicRKyHEfEklVXonT0TeXdwkTne0aJIC2dr7Wn0wKPIM1ytJQBY55jV
 wKBCxvlnEJafeImVWM7CPongynIG7iyi/DZdnBN3QBOvkw0A1BXYildrWqeeb/ovbk4pkTcn6YKJ
 AoNcGfVUyqjkiEKCfn5vxOzJTcCgIQ3jtoq4feU+m4NdGJ8F1VAVP9IXH8cSRVTbpVqN3FCXrT4A
 C6T5BlIhVcSqxSG3US5fd7wS7saICn4l0qHjcUKnmbjoMjASduHnIB5bBUMS6Br2IMp1pJYn/JBQ
 BQ+qjV2pt/PObgNNHD1aR3oZPbj0zf1DjAIGifAN7DTMshPXZfafGA6iytv81Ta8TOFm1Amwh8hs
 Ax8eiwrR3wrU1SzlD3PLMF/m3y5vxlaueV3hRBVru7IxdmRjr8WyFL6FL1dfeiBRswbWsjHVKJKX
 xm+LESMXpY/yEAwevV9Dgt/OOIZXnAqV12wUv1aPigEfvM9Y32mCB23iy2N4fxFwPe3zrWv+wvaX
 NBPAiBiz+IQcpca5ax5zwcJgA7scSCBpvmdm9e5XvFdrEA6QHBFP+9Ipd2Id87u75ieaLQdAbzpY
 8=
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

October 21, 2025 at 10:10 PM, "Philippe Mathieu-Daud=C3=A9" wrote:
> On 19/10/25 17:14, Julian Ganz wrote:
> > We recently introduced API for registering callbacks for trap related
> >  events as well as the corresponding hook functions. Due to differenc=
es
> >  between architectures, the latter need to be called from target spec=
ific
> >  code.
> >  This change places hooks for Alpha targets.
> >  Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >  Signed-off-by: Julian Ganz <neither@nut.email>
> >  ---
> >  target/alpha/helper.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >  diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> >  index 096eac3445..a9af52a928 100644
> >  --- a/target/alpha/helper.c
> >  +++ b/target/alpha/helper.c
> >  @@ -27,6 +27,7 @@
> >  #include "exec/helper-proto.h"
> >  #include "qemu/qemu-print.h"
> >  #include "system/memory.h"
> >  +#include "qemu/plugin.h"
> >  > > #define CONVERT_BIT(X, SRC, DST) \
> >  @@ -328,6 +329,7 @@ void alpha_cpu_do_interrupt(CPUState *cs)
> >  {
> >  CPUAlphaState *env =3D cpu_env(cs);
> >  int i =3D cs->exception_index;
> >  + uint64_t last_pc =3D env->pc;
> >  > if (qemu_loglevel_mask(CPU_LOG_INT)) {
> >  static int count;
> >  @@ -431,6 +433,17 @@ void alpha_cpu_do_interrupt(CPUState *cs)
> >  > /* Switch to PALmode. */
> >  env->flags |=3D ENV_FLAG_PAL_MODE;
> >  +
> >  + switch (i) {
> >  + case EXCP_SMP_INTERRUPT:
> >  + case EXCP_CLK_INTERRUPT:
> >  + case EXCP_DEV_INTERRUPT:
> >  + qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> >  + break;
> >  + default:
> >  + qemu_plugin_vcpu_exception_cb(cs, last_pc);
> >  + break;
> >=20
>=20Shouldn't we handle EXCP_CALL_PAL with qemu_plugin_vcpu_hostcall_cb()=
?

Host calls are exclusively calls that are handled outside the emulation,
on the host, regardless of whether they are hypervisor calls or not. In
that respect EXCP_CALL_PAL looks to me like a regular exception that is
handled by translated code within the emulation.

Regards,
Julian

