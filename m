Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9905CCD185
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 13:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v67lS-0000uA-32; Tue, 07 Oct 2025 09:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v67lO-0000so-SX
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 09:29:59 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v67lH-00050o-3I
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 09:29:57 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 1EA9360B64
 for <qemu-devel@nongnu.org>; Tue,  7 Oct 2025 15:29:35 +0200 (CEST)
Received: (qmail 5587 invoked by uid 990); 7 Oct 2025 13:29:35 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Tue, 07 Oct 2025 15:29:34 +0200
MIME-Version: 1.0
Date: Tue, 07 Oct 2025 13:29:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <ceaeff0c68fadcc2069c359aee72dc6c6fd52f90@nut.email>
TLS-Required: No
Subject: Re: [PATCH v7 08/25] target/hppa: call plugin trap callbacks
To: "Richard Henderson" <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: "Helge Deller" <deller@gmx.de>
In-Reply-To: <411110f3-dcc6-457e-a64b-c038e616d8ae@linaro.org>
References: <cover.1759744337.git.neither@nut.email>
 <bfdf4d5590d40c345a96fda9bc2dda992721f073.1759744337.git.neither@nut.email>
 <411110f3-dcc6-457e-a64b-c038e616d8ae@linaro.org>
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-3) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=VoVzrYSDAloUDSyi6cibVfjX5xf9YTuNptxyuwIC92o=;
 b=ch9gyHXqaqV+C1oGqA6Fa243sHqMtVdoIYkKuqsXFs067+AtMUQjPKXcglPVElHulOCdMMrrvw
 RM/zkjMl9Ty3lAlyXDs5nS2LeJcT/3+d5uaF985TR4nk114XXZd6BPbUXwWzHuGAh1ElJlwt4QF5
 TixlxQACaHrOSycgiUxq8kAzGgbaYn/Js903sEeRh8NcEIFvYBOX+noyxKIbQeyj187hU9SfQCb5
 fG2Hse1K5A+qqfEK7jf6uxdH1hjuOIcqFLXnOvey9Xfc7QN1Cp3nQx2paQ9x57My1DB7X7DpjIj1
 o5xOv6txzYFGcr1oYJzlEX5gyGyuZaeGSyJ3BEiQoZG06un1trG9wzT9cwLdospBzfERuYpKRgi1
 ebwOG1vdn5aTkqH2NL+adnWHTh+06p5AP5O+BeK74FUj0MEY4TP0M1Fw2nxqIduwiny2aJlQcmNm
 OP9OeHGdN9tnm+UhiYWXpiyF07eGwcU0bjJSCFAqjpkLJTGsYZ/nFG0NPTYFS67P6nLD6s4EbfdX
 3wWWY7mYF9NfJiy6zEZYsLaDhhqhBAUs0Eg1PsXMMDWM3IuDCdYPu6ENku4Tu18JiJZw2CoUr9gi
 jj9wDs9IGHyQG93THNpB5eqcmMu/wkd25a2c83Za9cxM5fQM0i92HLGPLGTAARxyPKQiNR1qdtWa
 w=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Richard,

October 7, 2025 at 12:38 AM, "Richard Henderson" wrote:
> On 10/6/25 02:57, Julian Ganz wrote:
> > @@ -212,6 +214,48 @@ void hppa_cpu_do_interrupt(CPUState *cs)
> >  env->iasq_f =3D 0;
> >  env->iasq_b =3D 0;
> >  > + switch (i) {
> >  + case EXCP_HPMC:
> >  + case EXCP_POWER_FAIL:
> >  + case EXCP_RC:
> >  + case EXCP_EXT_INTERRUPT:
> >  + case EXCP_LPMC:
> >  + case EXCP_PER_INTERRUPT:
> >  + case EXCP_TOC:
> >  + qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> >  + break;
> >  + case EXCP_ITLB_MISS:
> >  + case EXCP_IMP:
> >  + case EXCP_ILL:
> >  + case EXCP_BREAK:
> >  + case EXCP_PRIV_OPR:
> >  + case EXCP_PRIV_REG:
> >  + case EXCP_OVERFLOW:
> >  + case EXCP_COND:
> >  + case EXCP_ASSIST:
> >  + case EXCP_DTLB_MISS:
> >  + case EXCP_NA_ITLB_MISS:
> >  + case EXCP_NA_DTLB_MISS:
> >  + case EXCP_DMP:
> >  + case EXCP_DMB:
> >  + case EXCP_TLB_DIRTY:
> >  + case EXCP_PAGE_REF:
> >  + case EXCP_ASSIST_EMU:
> >  + case EXCP_HPT:
> >  + case EXCP_LPT:
> >  + case EXCP_TB:
> >  + case EXCP_DMAR:
> >  + case EXCP_DMPI:
> >  + case EXCP_UNALIGN:
> >  + case EXCP_SYSCALL:
> >  + case EXCP_SYSCALL_LWS:
> >=20
>=20These last two are linux-user syscalls. Don't you want hostcall?

Hostcalls only really exist in system emulation mode. For regular
syscalls, we do want to observe the exception in that mode since the
kernel code we switch to is also emulated. For consistency's sake, we
handle it the same for user mode. And there's already a syscall API for
user mode emulation, so it doesn't make much sense to handle them as
host calls.

>=20
>=20>=20
>=20> + qemu_plugin_vcpu_exception_cb(cs, last_pc);
> >  + break;
> >  + default:
> >  + qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> >=20
>=20g_assert_not_reached().

So that implies that there are no exceptions or interrupts that are not
represented by a EXCP_* constant/definition? In that case I'll rewrite
this with just the interrupts and a default case for all "proper"
syncroneous exceptions.

Regards,
Julian

