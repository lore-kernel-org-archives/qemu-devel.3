Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8646EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so2JR-0004m2-LR; Tue, 10 Sep 2024 10:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@caoua.org>) id 1so2JP-0004fw-2H
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:57:47 -0400
Received: from vm1.arverb.com ([185.82.219.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <alex@caoua.org>) id 1so2JL-0004Bd-Vm
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=6z294Wy0V6JJ
 s53h/hNTCRJJqlG0w9DGc2zSqPT3lSQ=;
 h=in-reply-to:references:subject:cc:
 to:from:date; d=caoua.org; b=Qh2r43Lrh3atN1Qf6gOxehhG3NLOUgnb23F8bxUaO
 zdkHm/STmU65Qemjig4o8gmOxDKvlm8EVPui3SRg86HBWkG7vAVl1C/AB5qDdBVxlwB2uN
 YUTq33niCj6/K7ge+6//DwadekeP7xOdf7Qzi3lRKdm6c98/1cO/GPYXKSYs=
Received: from localhost (vm1.arverb.com [local])
 by vm1.arverb.com (OpenSMTPD) with ESMTPA id b86052ba;
 Tue, 10 Sep 2024 16:57:38 +0200 (CEST)
Date: Tue, 10 Sep 2024 16:57:38 +0200
From: Alexandre Ratchov <alex@caoua.org>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Bandan Das <bsd@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [PULL 20/24] audio: Add sndio backend
Message-ID: <ZuBeYjju389c8MoI@vm1.arverb.com>
References: <20220927081912.180983-1-kraxel@redhat.com>
 <20220927081912.180983-21-kraxel@redhat.com>
 <fc493743-5ab0-49eb-98ed-dd260f0f60d6@linaro.org>
 <ZuBXqSoohgbS-rF6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuBXqSoohgbS-rF6@redhat.com>
Received-SPF: pass client-ip=185.82.219.62; envelope-from=alex@caoua.org;
 helo=vm1.arverb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 10, 2024 at 03:28:57PM +0100, Daniel P. Berrangé wrote:
> > 
> > This is the single use of the ISC license in the more than 10k
> > files in the repository. Just checking IIUC this document:
> > https://www.gnu.org/licenses/quick-guide-gplv3.en.html
> > 
> > ISC -> LGPLv2.1 -> GPLv2 -> GPLv3
> > 
> > So ISC is compatible with GPLv2-or-later. Is that correct?
> 
> ISC is a permissive license that's semantically pretty much equivalent
> to either MIT or BSD 2 clause licenses and thus is broadly compatible
> with most other licenses, including the various GPL variants/versions.
> 
> None the less, since sndioaudio.c was a new file, it should have been
> submitted using the GPLv2+, unless there was a reason it needed to
> diverge and use ISC.
> 
> An example justification for divering is if the new code is derived
> from some non-QEMU source that was already ISC.
> 

The ISC license is more permissive than GPLv2+ and compatible with it.
The file uses this license for history reasons: initial versions of it
used to be part of the OpenBSD ports repository, which uses ISC.

If ISC is not appropriate for qemu, I agree to use GPLv2+ instead (I'm
the author this file).

