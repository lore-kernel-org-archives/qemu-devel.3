Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A87CCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBIvM-0003gc-RP; Tue, 21 Oct 2025 16:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vBIvI-0003fp-CG
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:25:36 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vBIvF-0004Oa-Sv
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:25:35 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id CD8E960DC7
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 22:25:22 +0200 (CEST)
Received: (qmail 5199 invoked by uid 990); 21 Oct 2025 20:25:22 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Tue, 21 Oct 2025 22:25:22 +0200
MIME-Version: 1.0
Date: Tue, 21 Oct 2025 20:25:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <a8d2f909aa7e429b3b5b1d0a342e9656e1492f59@nut.email>
TLS-Required: No
Subject: Re: [PATCH v8 18/25] target/s390x: call plugin trap callbacks
To: "=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=" <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "David Hildenbrand" <david@redhat.com>, "Richard Henderson"
 <richard.henderson@linaro.org>, "Ilya Leoshkevich" <iii@linux.ibm.com>,
 "Thomas Huth" <thuth@redhat.com>, "open list:S390 TCG CPUs"
 <qemu-s390x@nongnu.org>
In-Reply-To: <ad294ba0-5c22-4583-9f24-8514c6bef633@linaro.org>
References: <cover.1760884672.git.neither@nut.email>
 <50a092042a41f7d679df2b6577edcba1d9316829.1760884672.git.neither@nut.email>
 <ad294ba0-5c22-4583-9f24-8514c6bef633@linaro.org>
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-2.999986) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.099986
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=LOP5Mx3H01ca9E+MwnFHQV8LoDAmmU1BTeX96MAcMZc=;
 b=eeaiDk3xV1W6iK2MNl0xkS60ncElRkZ4XNBKfkhucY98b+mAXjrt3YTsOnGBpw2EH3262wMXxC
 c3TqRFQvkUT0JITIB3E9slUfaxeeoYRWQEyTk0V+oYi9+lwU5PrfazsN1fHnzMPUOrcIY8aNbr3t
 ON+fI7ogK3ktf6xChKufq9buqaX1EJt9xOyDR8QjMdyzc1Z7ZR2MkjL6ABLsHO9pvbfolhGmy9Fc
 oxcJRoFd4daidjU6vSW+hunGColztgW8WzGJaAE0ULK/FYIRkSL+mkBFtWP/3dV6ObxV2gK1CWBm
 oJx3VNHd6c3KVXgTdgsn0lJL2PIsvrEIvYYzT4wpvOMPXkTRrQ8Sc9JFpIBea7ob5LaUKYR5o0qx
 ltXlNMOjOkg+42dFiR9kaX6oviTGFERJRlYkGCvyqlG4SAFU12PBXTelMWmuIIkAP5n0wgkYk7us
 Vd027JG6XvYlHpVEqT8MLe2QnvcSA/oUslcTdUL6kFFmiRgdJ3lYAhL4iF2GH0KZQarP8JZvxZVF
 ORGsxfExqDLH5nxBSXAOg84h6F4Ur56WSJmiTjLytZ02/ovL4zG91RU5i+SgcpNJ/J0m/9Zo8vF5
 ygZb7fvoOHfu6j+e7+lHDBUVJpkg+18t0Rq7yyQqq9S3O6PFEyfWDmrrffr5Oo+Jsn+LNsUzzzbi
 U=
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

October 21, 2025 at 10:07 PM, "Philippe Mathieu-Daud=C3=A9" wrote:
> On 19/10/25 17:15, Julian Ganz wrote:
> >  @@ -531,21 +533,27 @@ try_deliver:
> >  switch (cs->exception_index) {
> >  case EXCP_PGM:
> >  do_program_interrupt(env);
> >  + qemu_plugin_vcpu_exception_cb(cs, last_pc);
> >  break;
> >  case EXCP_SVC:
> >  do_svc_interrupt(env);
> >  + qemu_plugin_vcpu_exception_cb(cs, last_pc);
> >  break;
> >  case EXCP_EXT:
> >  do_ext_interrupt(env);
> >  + qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> >  break;
> >  case EXCP_IO:
> >  do_io_interrupt(env);
> >  + qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> >  break;
> >  case EXCP_MCHK:
> >  do_mchk_interrupt(env);
> >  + qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> >  break;
> >  case EXCP_RESTART:
> >  do_restart_interrupt(env);
> >  + qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> >  break;
> >  case EXCP_STOP:
> >  do_stop_interrupt(env);
> >=20
>=20Shouldn't we also track the STOP interrupt?
>=20
>=20 qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>=20
>=20If not, please mention why in the patch description.

My expectation was that this exception is not observable in software
running on the target anyway, and that is would lead to a VCPU exit. For
which we already have qemu_plugin_register_vcpu_exit_cb. If I'm wrong
about that than we do want to also track STOP interrupts. If not I'll
add a sentence about that in the commit message.

Regards,
Julian

