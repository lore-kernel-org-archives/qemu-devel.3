Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB84EC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlrDz-0001H7-7w; Mon, 20 Jul 2026 12:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlrDf-00013B-1r
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:52:01 -0400
Received: from mail-244106.protonmail.ch ([109.224.244.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlrDd-0004hd-AZ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pq.io;
 s=protonmail3; t=1784566311; x=1784825511;
 bh=NbtV9KJAWKo+TmeSWqzAjRGuK4rkjSB+Ix/KJYBZb3A=;
 h=From:To:Cc:Subject:In-Reply-To:References:Message-ID:Date:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=IbIlncoXNxb+MQkUAWUMZWgrnkH6b2lgBJSC4OkEnTiS0oGmyHM14/Qiz4uyAyMWA
 FCKNYHJ3kZca1sjAyFuDex3sDyGeAGFAFMzp8g8Vigx9t2dgoshcwdPPgNLWzO54oW
 XP4bOGQLRG0e48u0cpqzsUQxPAEBMnCgH4hv+EJ66VZbDcxji8wYw4iBGE/mtYfhfU
 PqDLOq/sGEX+GrMOvv/5F8lM1E79bNCn8KVSpvgORKiaBQo+ctXthCp1Oi9fqJOiH7
 qtyyeAszmLf12PrAsEIBnMH9Y6ABBZPuHX7r+2tDJYXomUU58aJH2gpW8E/PH05gtq
 G7TsIVv6Vjkzg==
X-Pm-Submission-Id: 4h3mkr74nrz1DFh1
From: Matthew Jackson <matthew@pq.io>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Subject: Re: [PATCH 2/2] hw/usb/dev-hid: add apple-mighty-mouse
In-Reply-To: <CAFEAcA9Mqtk65y9jJCWZgmRUMwgV+Sz7Y=R=Pp5R5huNj8cLjw@mail.gmail.com>
References: <20260719152318.69501-1-matthew@pq.io>
 <20260719152318.69501-3-matthew@pq.io>
 <CAFEAcA9Mqtk65y9jJCWZgmRUMwgV+Sz7Y=R=Pp5R5huNj8cLjw@mail.gmail.com>
Message-ID: <20260720095147.maydell-reply@pq.io>
Date: Mon, 20 Jul 2026 09:51:47 -0700
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=109.224.244.106; envelope-from=matthew@pq.io;
 helo=mail-244106.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 20 Jul 2026 at 08:22, Peter Maydell <peter.maydell@linaro.org> wrote:
> Reading this comment prompts me to check with you whether you have
> read our AI contribution policy, which at present is essentially
> a "no AI generated code or text in contributions" policy:
> https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-gener=
ated-content

Thanks Peter, and fair question -- the answer is yes, AI tooling was
used in producing this series, so under the current policy I should not
have sent it in this form. I apologise for that, and I appreciate you
flagging it directly rather than just dropping the patches.

To be transparent about what that means for these patches: this work
comes out of a project that runs macOS guests on QEMU/KVM, and I use an
AI coding assistant in that project. The comment you quoted is a good
example -- it's essentially the assistant's working notes shipped
verbatim, which is exactly the kind of thing that shouldn't be in an
upstream submission (and, as you say, the development-history narrative
doesn't belong there regardless of how it was written).

What is *not* AI-derived is the hardware ground truth: the USB
descriptors, HID report descriptors and endpoint topology are captured
byte-for-byte from real Apple peripherals, and the design decisions
(which device to emulate, why Mighty Mouse rather than Magic Trackpad,
how it binds in macOS) were mine. But I recognise that doesn't resolve
the DCO clause (b) concern about the generated code and text itself, and
I don't want to hand-wave that.

So I'll withdraw this series for now rather than ask you to review it
under a cloud. If I reimplement the device code and comments myself,
from the captured hardware descriptors as the spec, would a resubmission
be welcome -- or would you rather this category of contribution wait
until the AI policy itself is revisited?

Not looking to litigate the policy -- just want to be straight about
provenance and do the right thing here. Thanks again.

-- Matthew

