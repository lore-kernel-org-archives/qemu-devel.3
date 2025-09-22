Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61E0CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 20:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0nYR-000087-7h; Mon, 22 Sep 2025 16:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v0nYN-00007X-Qi
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 16:54:32 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v0nYH-0008Nc-MP
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 16:54:31 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 3735C60A94
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 22:54:20 +0200 (CEST)
Received: (qmail 24095 invoked by uid 990); 22 Sep 2025 20:54:20 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 22 Sep 2025 22:54:20 +0200
MIME-Version: 1.0
Date: Mon, 22 Sep 2025 20:54:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <c222d481c7687da93a26da45ddadb877973f7e63@nut.email>
TLS-Required: No
Subject: Re: [PATCH v6 00/25] tcg-plugins: add hooks for discontinuities
To: "=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=" <philmd@linaro.org>,
 qemu-devel@nongnu.org
In-Reply-To: <2506e480-3226-4fdc-bf1d-bf4324132ba4@linaro.org>
References: <cover.1757018626.git.neither@nut.email>
 <2506e480-3226-4fdc-bf1d-bf4324132ba4@linaro.org>
X-Rspamd-Bar: /
X-Rspamd-Report: BAYES_HAM(-0.075441) MIME_GOOD(-0.1)
X-Rspamd-Score: -0.175441
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:subject:date;
 bh=RK1sSxbtTaoqFNvm0wO+lOqlDQm7zy2XvwU8K6uA6uo=;
 b=VeuHdrV22rRuppCHs0MPPFMGUDrAqVKmdksniBbUynlV/xgLiMlNbwH3CEhu53R9pJOtIoan1o
 onD11bxDZf1O/lbK6mX8PeNQFkvAbORRp+orj3DCWpZKiqoyt4QvklRz09YNDEGVvT1quSQ5B3jF
 Pbvrice42iLdJ9TfgLBcZjXsshlaEgk+pm97ILfCQ2Fv5mTxPuibqMeUF5IfxdGrpL3IaBUOco/B
 6QR1M+r3MahXPx9rz3NWBzaBQrd03gMYaEBYGRY0pLkkcDZ0avfqtZhSwa7ouPDg3iQ1ZBWeIJzI
 x8ZPoQ7M/oHiVYvhrkt4TNVAXIpT8hbX1q47+cJPu3phWM78ZC88p3fgVUXfPcYfm1lHkrNPbG1D
 zYJ+51roLHwHCS7CBuE36FuqFJKrDGcYAfMahEFdoKgOsdMQK1gkzd74QFhGMtwcGn+QsUS6JndW
 ijs72Cr+JsioOd7tUo78HEmFXmWSiimmIkQNevoSLzcx64SIuA7bHT44WtdZ6+o2qWmwroro30du
 XG4ORbG6tQ0h0tg3uD9jf8SNUpuW5jr2pz+h15g+DCO9L5Yj/fuYp7cN7vdzqREehIvvHo4pqJcc
 vu2F6psVhmCRzpPz32X8LJn7hnHLkjoc9zZwRtFQ3rkyFgKm4+cR0S5z4y7U/CWe1YUcVhXJexIa
 Y=
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

September 22, 2025 at 1:31 PM, "Philippe Mathieu-Daud=C3=A9" wrote:
> >  Richard Henderson proposed streamlining interrupts and exceptions fo=
r
> >  all targets and calling the hooks from a higher level rather than in
> >  each target code. However, there are a few obstacled and I decided t=
o
> >  not do this as part of this series.
> >=20
>=20Does that mean another part is planned, and when it lands then these
> patches will be reverted?

I don't have any tangible plans for a follow-up series. If I end up
drafting one it will likely take a while.

A follow-up series will likely not straight revert these changes since
they essentially mark points where we would want to return some required
additional information to said higher level. The hooks would instead
vanish one by one as part of a migration.

Regards,
Julian

