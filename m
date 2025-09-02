Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E70FCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 11:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utPWL-0002Ue-Qv; Tue, 02 Sep 2025 07:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1utPWJ-0002U7-4S
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 07:49:51 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1utPW8-0002ie-4I
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 07:49:49 -0400
Received: from mailgate02.uberspace.is (mailgate02.uberspace.is
 [IPv6:2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id C9DDB60E38
 for <qemu-devel@nongnu.org>; Tue,  2 Sep 2025 13:49:23 +0200 (CEST)
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id B545517F73B
 for <qemu-devel@nongnu.org>; Tue,  2 Sep 2025 13:49:23 +0200 (CEST)
Received: (qmail 2530 invoked by uid 990); 2 Sep 2025 11:49:23 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Tue, 02 Sep 2025 13:49:23 +0200
MIME-Version: 1.0
Date: Tue, 02 Sep 2025 11:49:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <57608ff3c13b6e45e515abebeb4173d17ace4122@nut.email>
TLS-Required: No
Subject: Re: [PATCH v5 00/25] tcg-plugins: add hooks for discontinuities
To: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
In-Reply-To: <87o6rtyx2t.fsf@draig.linaro.org>
References: <cover.1747666625.git.neither@nut.email>
 <87o6rtyx2t.fsf@draig.linaro.org>
X-Rspamd-Bar: /
X-Rspamd-Report: BAYES_HAM(-0.058024) MIME_GOOD(-0.1)
X-Rspamd-Score: -0.158024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=CXOV2iadcOoV8ZpyKjJlCcBl8aOzV/cCHk9lWW4U5q4=;
 b=V/3JEl1LlG7L36N0hjR4y0fdLym1YBEWfWDwR2fsF4ZJRMWEcHVfi8nIBmz7vNwJ0Fc9AxE5+P
 G0znq+ZjGu2veMb0XF7guouZUbYw+SU8pHU10cE+1uWTxZjS/Q49J5qTsLm5AFE1tx/yR6qSm0oG
 RBRRPOZktwCHL1sHFKdhRLqDGVBzBjxs+fcLqj54SmliB6pCTLIW+eW9iZ6gRtY54yIcs7j5FQXf
 iA3Q3d5F/MJltraTNXcL0SbjGB9iQL8ZZ5GID1GNNNlzK//81oC4wmyFGcIKzAqpeJqFjOSbS5MQ
 oQYHlCPj4KcKhn1FZgSdtBHU6G3otJPkD5KMuZtAKL9z0sui0m/KKPQsGmRpegEmzqEoFF551PKV
 K9YE7TGlVoy9XHXo4InFaLFLOFMiSfe+GZ4cMnmY0wlqx3c9LbpG2Cuw6L5XwBhLAA8GVIAYP+P5
 JpPqH0pO/3FahpURmVpieL2lcwToPt5NbslulX8URzCvnfA9wqICzRsiTLFDpRRq5cCBXUFHkAfX
 whnSiYWytW4eMnabrbzMxX86mPFH9a2zV3XPxMMPcTXIJesXC2kwzImdgGwTQwUKOU1vrSkh2uWj
 47UVxUzwArtfyvHtH+K5ow93LjNaSBjuDn/H51HrfnxKYiLHQoyFpoAJeFRMW0Ve7EWdHxOD78rQ
 k=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

September 2, 2025 at 12:20 PM, "Alex Benn=C3=A9e" wrote:
> Julian Ganz <neither@nut.email> writes:
>=20
>=20>=20
>=20> Some analysis greatly benefits, or depends on, information about
> >  certain types of dicontinuities such as interrupts. For example, we =
may
> >  need to handle the execution of a new translation block differently =
if
> >  it is not the result of normal program flow but of an interrupt.
> >=20
>=20>  Even with the existing interfaces, it is more or less possible to
> >  discern these situations, e.g. as done by the cflow plugin. However,
> >  this process poses a considerable overhead to the core analysis one =
may
> >  intend to perform.
> >=20
>=20>  These changes introduce a generic and easy-to-use interface for pl=
ugin
> >  authors in the form of a callback for discontinuities. Patch 1 defin=
es
> >  an enumeration of some trap-related discontinuities including somewh=
at
> >  narrow definitions of the discontinuity evetns and a callback type.
> >  Patch 2 defines the callback registration function. Patch 3 adds som=
e
> >  hooks for triggering the callbacks. Patch 4 adds an example plugin
> >  showcasing the new API.
> >=20
>=20>  Patches 5 through 22 call the hooks for all architectures but hexa=
gon,
> >  mapping architecture specific events to the three categories defined=
 in
> >  patch 1. We don't plan to add hooks for hexagon since despite having
> >  exceptions apparently doesn't have any discontinuities associated wi=
th
> >  them.
> >=20
>=20>  Patch 23 supplies a test plugin asserting some behavior of the plu=
gin
> >  API w.r.t. the PCs reported by the new API. Finally, patches 24 and =
25
> >  add new tests for riscv which serve as test-cases for the test plugi=
n.
> >=20
>=20>  Sidenote: I'm likely doing something wrong for one architecture or
> >  the other. These patches are untested for most of them.
> >=20
>=20>  Since v4:
> >  - Fixed a typo in the documentation of the
> >  qemu_plugin_vcpu_discon_cb_t function type (pointed out by Pierrick
> >  Bouvier)
> >  - Fixed a reference in the documentation of the
> >  qemu_plugin_vcpu_discon_cb_t function type
> >  - Added hooks for SuperH and TriCore targets
> >  - Fixed typos in commit messages (pointed out by Daniel Henrique
> >  Barboza)
> >=20
>=20Hi Julian,
>=20
>=20Just checking what the status of these patches are. It looks like you
> have a number of comments to address but the number of reviewed patches
> is going up each revision.
>=20
>=20Do you think you will be able to spin a new revision and look to get
> this merged in the 10.2 cycle?

I did plan to send the next revision, but got swept up by other work.
I'll try to get the series ready over the next few days and stay
engaged until the patches are accepted. I am aiming at the 10.2 cycle.

Regards,
Julian

