Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811B3D116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 20:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQAyX-00018P-Ik; Mon, 01 Dec 2025 15:58:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@caoua.org>) id 1vQAyU-00017g-FH
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:58:22 -0500
Received: from vm3.arverb.com ([116.202.17.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@caoua.org>) id 1vQAyQ-0007jV-7t
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=l/rePmsVReWp
 dAJHcBrNg/Fp01phWduHiGfdYPs4Wp8=;
 h=in-reply-to:references:subject:cc:
 to:from:date; d=caoua.org; b=ld7gS0J7nSIEyd5AhWdKLWS2s8stnHLCvqybR96k1
 SKIbqrfFhNBhUFuNWRRy6CDv7uFI+Bj4z/z/9V7CwykSjr0816c0gKfEykWnfWzyte+Dtr
 uaNUNpf7NYS6QNADDETBP3voCNmKdqPE+ymClaRu4Am1p1KKMeAnNlLRHnW0=
Received: from localhost (vm3.arverb.com [local])
 by vm3.arverb.com (OpenSMTPD) with ESMTPA id 94a4eb30;
 Mon, 1 Dec 2025 21:58:13 +0100 (CET)
Date: Mon, 1 Dec 2025 21:58:13 +0100
From: Alexandre Ratchov <alex@caoua.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>,
 geoff@hostfission.com
Subject: Re: [RFC 00/24] audio: add GStreamer backend
Message-ID: <aS4BZZnzQPUHzbaD@vm3.arverb.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <e6ada475-da8a-4643-4986-2ffc1d5b9c66@eik.bme.hu>
 <CAMxuvayr-qyjzsexWL1wt72mJA_-Dew9JAofjELhSVYC_w8SvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvayr-qyjzsexWL1wt72mJA_-Dew9JAofjELhSVYC_w8SvA@mail.gmail.com>
Received-SPF: pass client-ip=116.202.17.78; envelope-from=alex@caoua.org;
 helo=vm3.arverb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 01, 2025 at 10:20:49PM +0400, Marc-André Lureau wrote:
> > cases. Also when using jack you'd want to have a QEMU backend for it not
> > going through multiple layers. So adding a GStreamer backend has its use
> >
> 
> I wonder what are the advantages of using JACK compared to ALSA, or
> pulse/pipewire, tbh.
> 

Jack can connect programs with deterministic latency. My wild guess is
that it would be to run a synths in the vm.

> > as another audio backend but not as a replacement for QEMU's audio
> > handling logic and backends.
> >
> 
> It would be great if people with very specific or constrained requirements
> on qemu audio could check if the GStreamer backend fits their need.

I'm thinking mainly about their simplicity.

Dropping the system API backends would add an extra sophisticated
layer (GStreamer) between the system and the program. In theory, an
unlimited number of software layers may be stacked in a program, but
the more layers there are, the more fragile the program tends to
be. Based on my limited experience, when things went wrong, the system
backends were simpler to debug and make work than the big frameworks.

IMHO, the system API backends won't hurt GStreamer users, so I see no
reason to remove them.

My 2 cents.

