Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4A3E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 11:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDNO-0002pg-FJ; Fri, 10 Jan 2025 06:40:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tWDNN-0002pS-0H
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:40:29 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tWDNL-0007VH-BZ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:40:28 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 07ABA17F8B0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 12:40:16 +0100 (CET)
Received: (qmail 2356 invoked by uid 990); 10 Jan 2025 11:40:15 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Fri, 10 Jan 2025 12:40:15 +0100
MIME-Version: 1.0
Date: Fri, 10 Jan 2025 11:40:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <c23be5093ca6ce17824377a716a22028259ba267@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 02/11] plugins: add API for registering
 discontinuity callbacks
To: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Alexandre Iooss" <erdnaxe@crans.org>, "Mahmoud 
 Mandour" <ma.mandourr@gmail.com>, "Pierrick Bouvier"
 <pierrick.bouvier@linaro.org>
In-Reply-To: <87r05c6qf5.fsf@draig.linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <e4af8fed4cc5449a7be04fbbf026abf267dc189b.1733063076.git.neither@nut.email>
 <87r05c6qf5.fsf@draig.linaro.org>
X-Rspamd-Bar: -
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-3) MIME_GOOD(-0.1)
X-Rspamd-Score: -1.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=62Svgr2/3DxsuIPp6MMH1qiHSkwPWzbkcBK3EmANw0w=;
 b=czZ1Bpf69PosfenwXnQGYHGNK3wYhkEs/c1v3trfYRoWoUhtAZpbetkhePsnOEEqrlVhIxMKGK
 Ws9FJbI/0IdJRdIAW8Yn+HSC+NO35RfKQHV5NjejdX4GAmdu+u3xPC4dQ00UKRl4cRHyysnY/h1u
 ovnGqw0PVg4HBwbWPCYFfok37BtPya7VzxIk11op9obPSgbps1cDJ2BpioGlICylmqIqGStEgK/K
 vCQ3VP1esd2yo17qxL3RzQIDiSJ34i4JIEqR2uUgnpKvLSmDDx21wH6ekGy+/VY1UjjwaqjyTnMm
 1dD9IkILCTtPJgH62t37Y7gH/TWDKg+b8k2AhZeifzOlYEYAdAgPbzskFxaQV/GR9ZKdXy2hd5Ot
 OCBnMaSe5Y5WXSeTpjAr6MzJt21y4ibpNXJQhUxf/efdVb11ReKZ0jZhnD9U/mTbMfhNiVSq1Eyf
 +4TO2d7EkTfFhrbX4XQ91knKP7Ba7fjjbgjt3tjdfF1AEzuYOkuh07RNWJY4APyQ2mUtwAnfH6Jv
 V1QSs5z7AyHtSp56f1XnqfL2DEe/15X1w9dXly6Bii1RlD1RWN9kEhz6/ipfbSpJXYmPZ9NGAL+A
 F1dmXvPeSiOLqToAyeHnD7hoCQRC4V0fR6BAlmqZRg02xnXXMB/TU6E8YegQB7fXDjR3ZTE7UE9h
 Y=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
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

Hi Alex,

January 9, 2025 at 2:57 PM, "Alex Benn=C3=A9e" wrote:
> Julian Ganz <neither@nut.email> writes:
> >  diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> >  index 9c67374b7e..f998a465e5 100644
> >  --- a/include/qemu/qemu-plugin.h
> >  +++ b/include/qemu/qemu-plugin.h
> >  @@ -273,6 +273,21 @@ QEMU_PLUGIN_API
> >  void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
> >  qemu_plugin_vcpu_simple_cb_t cb);
> >=20=20
>=20>  +/**
> >  + * qemu_plugin_register_vcpu_discon_cb() - register a discontinuity=
 callback
> >  + * @id: plugin ID
> >  + * @cb: callback function
> >  + *
> >  + * The @cb function is called every time a vCPU receives a disconti=
nuity event
> >  + * of the specified type(s), after the vCPU was prepared to handle =
the event.
> >  + * Preparation usually entails updating the PC to some interrupt ha=
ndler or trap
> >  + * vector entry.
> >=20
>=20The "usually" here is a bit of a weasel word. We should be clear what
> the contract is with the plugin. Can we say the PC will be updated to
> the next instruction that will execute after the callback?

The contract is indeed clear: the PC will always be updated to the
instruction that will be executed next, at least if we don't have a
second discontinuity (e.g. jump to an unmapped page). The "usually"
refers to the discontinuity itself: in the case of host calls, we don't
observe a "jump" and the next instruction executed will just be the
instruction following the call.

I could have phrased this better, and will make this more clear in the
next update.

Regards,
Julian

