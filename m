Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBA5CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ff6-0002nR-A1; Tue, 14 Oct 2025 10:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v8ff4-0002nE-Kh
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:05:58 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v8fex-0004xU-RK
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:05:57 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id A20B260D1A
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 16:02:53 +0200 (CEST)
Received: (qmail 15923 invoked by uid 990); 14 Oct 2025 14:02:53 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Tue, 14 Oct 2025 16:02:51 +0200
MIME-Version: 1.0
Date: Tue, 14 Oct 2025 14:02:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <e0f46145b784eaa324211af8a381c9edd1e4fa72@nut.email>
TLS-Required: No
Subject: Re: [PATCH v7 10/25] target/loongarch: call plugin trap callbacks
To: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Richard Henderson"
 <richard.henderson@linaro.org>, "Song Gao" <gaosong@loongson.cn>
In-Reply-To: <87347ln469.fsf@draig.linaro.org>
References: <cover.1759744337.git.neither@nut.email>
 <21a5bf2e810e2c1a3d278ba3ed98f4d4491763cb.1759744337.git.neither@nut.email>
 <87347ln469.fsf@draig.linaro.org>
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-2.994982) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.094982
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=ILXEg2Bq9Yjbq9TUn+/MRTYaUrBUQiI0pDSb40KPjQM=;
 b=PUjQx6nwIQUEXx1dioL5Ub/0ElWtCt2PO2Ef+/bpDxETm7K8m0C4luR0FkKFlzJ1xX6lBRmGVI
 gJY0xlnDCGZ+xK6N5Pf44nhXMJIG6jr0pkAjcbsGxm3zW0Qm04nPFthaWj/TGKnnEOtY+iUFv9UA
 g7zE5h1ZxEcuhdnHTcCz11RdSizeYQXevyQXgUvlhqw0QxB5TylUcWBBDrSIF/Py8tnHZ2KhHgOk
 izUe2Y5c4FLGneTM2+IkYnQ1KR8+7okXQ+X/g/bzOSZPtAKxGTgZr2trzORniHno8GM0J0Kl//T9
 nA4bk+G/T5Hs0nv5XUOAz//r1l7l0SN7CkM/zeNN9hKUODDbfnBsW6r4ZPtQyJd+wV4vjcLanJwR
 gDPoaf3kqvXyfzt+/JGLSQWimEgqF3Yx3CulrBLgatlPztRGtQqo4smHKCQWWQTcIRgxXCPgXEcU
 bEQqFo+vFAvzfYTRy8LR0+rexr2ZJeKkLwWNHXNXd8KWMESKgMTiaJ6fzzFqjCzJ2NhSTw2eGvMR
 zbu6VHOplz+u7++EU/q+49OJQU0UzY7QcfrZimeKEZ2HS5TUXkVYP/2fT/3d91YPQNgcHJY5mBi3
 gGFBjDY6Ovkhww7CgXXo4XN2yu5Amzza1HwC0PRK5T2VjL2PL9G1KHxdA0YDIF1vmsIhOKTmbxwG
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

Hi Alex,

October 14, 2025 at 12:55 PM, "Alex Benn=C3=A9e" wrote:
> Julian Ganz <neither@nut.email> writes:
>=20
>=20>=20
>=20> We recently introduced API for registering callbacks for trap relat=
ed
> >  events as well as the corresponding hook functions. Due to differenc=
es
> >  between architectures, the latter need to be called from target spec=
ific
> >  code.
> >=20
>=20>  This change places hooks for loongarch targets. This architecture
> >  has one special "exception" for interrupts and no host calls.
> >=20
>=20>  Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >  Signed-off-by: Julian Ganz <neither@nut.email>
> >  ---
> >  target/loongarch/cpu.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
>=20This fails to apply now - I think because the TCG functions have move=
d
> to target/loongarch/tcg/tcg_cpu.c

Yes, I already had rebased and fixed this locally.

Regards,
Julian

