Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5814AC54F30
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 20:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJHlX-0007T7-NZ; Sun, 25 May 2025 16:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uJHlV-0007Sw-5P
 for qemu-devel@nongnu.org; Sun, 25 May 2025 16:16:13 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uJHlS-0004J3-LM
 for qemu-devel@nongnu.org; Sun, 25 May 2025 16:16:12 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id DAB7D17F6BD
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:16:05 +0200 (CEST)
Received: (qmail 30947 invoked by uid 990); 25 May 2025 20:16:05 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 25 May 2025 22:16:05 +0200
MIME-Version: 1.0
Date: Sun, 25 May 2025 20:16:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <3626834acffdaf2f6f2504c1dbb2c457601964f2@nut.email>
TLS-Required: No
Subject: Re: [PATCH v5 05/25] target/alpha: call plugin trap callbacks
To: "Richard Henderson" <richard.henderson@linaro.org>, qemu-devel@nongnu.org
In-Reply-To: <f140b06d-53c7-4d32-ab95-1327d2659a37@linaro.org>
References: <cover.1747666625.git.neither@nut.email>
 <a5ec8863418a946530d167677184d40319470af2.1747666625.git.neither@nut.email>
 <f140b06d-53c7-4d32-ab95-1327d2659a37@linaro.org>
X-Rspamd-Bar: /
X-Rspamd-Report: BAYES_HAM(-0.000555) MIME_GOOD(-0.1)
X-Rspamd-Score: -0.100555
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:subject:date;
 bh=/9H9EHbLdwp660iE190pMmbcgBscG8vKvbGUvP4UxWQ=;
 b=dbs9RaAlYstq4smcfA7x8TKPX6Pkgl03hcnQT2VGdM+1K+4I2CJ3lnBr9DFUhljT4K9wiaKfeM
 0wDRxrTI5SZZuUPnJApix8z2hrUD6onHdVeVNw5kMCxjZyuS1DrFypudQFJhzPrpWLYBObwoML0y
 zNnO9AnH1jnxas8x5qDtic7UVOj79DOxU5AbDzgpEQWJmQMJtPPVKnF1hg0WWsIl5yP2r8nIglwV
 KLv4+PQLuUc0chCreVEZkiEoG7Tvsel8JgSS/uH6aHMa85CM0785SHlQs6Qf3wHOpfhi+uOrfWoz
 MlBJPt57YGBlxs62IyqlEMMYFIBOHyJaiaek12vyBWRF1B7EnNx3arM98QfsUjZLBDJa3/wuKJal
 eS3vyM5MayJ9Wu89gznyMx6c08BFbPRZFT/Rv+ttZUGs67EVZC6qWaS8xf0ufmHc5Er8jem9l+yD
 i9QD0Djv2fYxGWgk7QymIUjMay2iSjpsw0XGMbB+0wa/40ZvrrurHhxwabpMFgvCWkRLUh1YLr+K
 WDMhxZJq3c8ef943v/K0c33hRU2q2r1FLFAevjpu1N/GzouafXtjTBGr2YcGPsVJVvbJCxRTDBJz
 6uBVPRfKUQSWrSd9YbHLG+V2n4Sz4orMRhAej5c3PNR6YIQ13ZvS0vfFRg0ECLuHjyx0kcNMq6N2
 w=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
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

Hi Richard,

May 25, 2025 at 2:14 PM, Richard Henderson wrote:
> Having read the whole series now, I think it would be better to change =
the TCGCPUOps.do_interrupt interface.
>=20
>=20Instead of having each target call qemu_plugin_*, instead have each d=
o_interrupt return the discontinuity type, or 0 if the interrupt is block=
ed so no state change.
>=20
>=20Change to cpu_handle_exception would be of the form:
>=20
>=20 if (qemu_plugin_discon_enabled(cpu)) {
>  vaddr from =3D tcg_ops->get_pc(cpu);
>  unsigned ev =3D tcg_ops->do_interrupt(cpu);
>  if (ev) {
>  qemu_plugin_vcpu_discon_cb(cpu, ev, from);
>  }
>  } else {
>  tcg_ops->do_interrupt(cpu);
>  }

Personally, I'd be in favour of that. However, I do see some obstacles
to that.

Quite a few targets to call their do_interrupt function internally,
usually from their exec_interrupt. We would then handle that function's
return value at the call site?

Also, some targets such as tricore only have a dummy/stub do_interrupt
and handle exceptions differently inside non-returning functions. For
those, we would call the hooks directly from there as we do now?

And then we have some targets that deviate in some other way. For
example, s390x_cpu_do_interrupt effectively contains a loop, and we
potentially need to call one of the hooks for each iteration.

Regards,
Julian

