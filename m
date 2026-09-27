Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43005C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAljc-0007H6-1x; Sun, 27 Sep 2026 06:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xAljZ-0007Gi-H9
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 06:03:49 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xAljX-00059j-JD
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 06:03:49 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 635A4583393;
 Sun, 27 Sep 2026 12:03:41 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id a-RzEncSQzFX; Sun, 27 Sep 2026 12:03:39 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 519B8583382; Sun, 27 Sep 2026 12:03:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4F4F95832AF;
 Sun, 27 Sep 2026 12:03:39 +0200 (CEST)
Date: Sun, 27 Sep 2026 12:03:39 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: "Michael S. Tsirkin" <mst@redhat.com>
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>, 
 Warner Losh <imp@bsdimp.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <20260927052335-mutt-send-email-mst@kernel.org>
Message-ID: <81d65154-74ce-c6c0-ab40-fb2156d53fba@eik.bme.hu>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com> <arEvLLYK9A5MKNdE@redhat.com>
 <arP7TDfz7lz699KJ@redhat.com> <87ik3vyp3i.fsf@draig.linaro.org>
 <arT_kefzEhqg8-FB@redhat.com> <arUJxE0F7Q3Cw5sk@redhat.com>
 <arZHWKAgr-GYvoeX@redhat.com> <arZZhpR5_nPybOUo@redhat.com>
 <e030a85d-a5d5-8fc6-5d1a-41167f7a95bf@eik.bme.hu>
 <20260927052335-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Sun, 27 Sep 2026, Michael S. Tsirkin wrote:
> On Fri, Sep 25, 2026 at 02:20:49PM +0200, BALATON Zoltan wrote:
>> Not directly related to this patch but as an input to this discussion I'd
>> like to bring to your attention how some people use AI now. With LLMs being
>> able to do more, some users who have no idea about coding or QEMU internals
>> but want to use QEMU for things that we could not deliver, now just maintain
>> a fork and let the AI add features and fix bugs they find without ever
>> contacting us or reporting these back.
>
> More power to them I say. There's no way to find gold in this sand. Let
> them be.

Sure they are free to do whatever they want and I don't want to stop this 
but I'd like to see that effort eventually improving QEMU and not lost for 
us or need to be redone from scratch. So some kind of AI policy is needed 
and a strict no-AI policy does not help to get these efforts defragmented. 
While goal oriented use of AI tools without caring for code quality leads 
to non-upstreamable patches maybe we could encourage these people to learn 
and even use an AI to redo their patches in a way that can at some point 
be upstreamed after some human review but since we don't have enough 
maintainers who could do that for them this should be done by the 
contributors. With the current no-AI policy they are locked out from 
contributing so they won't even try. By now they have implemented features 
we wanted for years but still could not get them due to not enough people 
being able to write code and while the AI generated patches can be mostly 
sand there are some gold in them that actually fixes issues or add 
features that could be useful if there was a way to upstream them. With 
current policy I can't even use the AI patches to look at them and clean 
them up for upstreaming (not that I want to do that due to the lot of 
nonsense to sift through but for some simpler patches this could be an 
option or if the patches would be made higher quality by better guarding 
what the AI does). Currently all I can say to these people is that QEMU 
does not accept AI generated patches but maube it would be better to say 
that while they cannot just submit their AI slop they should try to tell 
their AIs to do these again cleaning up all the nonsense and distill the 
gold from it and then there should be some way to let that improve QEMU 
without drowning the maintainers and putting all this effort on them.

Regards,
BALATON Zoltan

