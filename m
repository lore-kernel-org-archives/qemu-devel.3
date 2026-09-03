Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC387C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25dq-00079O-Ve; Thu, 03 Sep 2026 07:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1x25dp-00072g-58
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 07:30:01 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1x25dn-0007e3-Cs
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 07:30:00 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 869EB5835C8;
 Thu, 03 Sep 2026 13:29:55 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id BD_z5mcEP1Dd; Thu,  3 Sep 2026 13:29:52 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6CC125835CA; Thu, 03 Sep 2026 13:29:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6ADE15835C9;
 Thu, 03 Sep 2026 13:29:52 +0200 (CEST)
Date: Thu, 3 Sep 2026 13:29:52 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>, 
 Warner Losh <imp@bsdimp.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH v2 0/4] docs/devel, AGENTS.md: a completely new policy
 on AI-generated contributions
In-Reply-To: <CAFEAcA8s=P6_SUFss9AikhfpLrFOi8p81idM6YZ=De-Z488RCQ@mail.gmail.com>
Message-ID: <45c9de8b-4686-3c9a-cdb2-d6a7e54bfc78@eik.bme.hu>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <CAFEAcA8s=P6_SUFss9AikhfpLrFOi8p81idM6YZ=De-Z488RCQ@mail.gmail.com>
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

On Wed, 2 Sep 2026, Peter Maydell wrote:
> On Tue, 1 Sept 2026 at 17:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> WARNING: this is *intentionally* a full U-turn from the previous policy
>> and discussions.  This is not a refusal of the arguments presented in
>> those discussions.  It is also a request for comments, and not something
>> that is ready to go.
>
>
>> Paolo Bonzini (4):
>>   docs/devel: introduce a new policy on AI-generated contributions
>>   AGENTS.md: Let agents know what the participation rules are
>>   AGENTS.md: make the human part of the design process
>>   agents: add CLAUDE.md and GEMINI.md
>
> Could somebody write a short AGENTS.md which is *just* an
> encoding of *current* AI policy, please? I think this is now

I'm not familiar with AGENTS.md but would just putting "See Use of 
AI-generated content section in docs/devel/code-provenance.rst." in it be 
enough to let AI tools warn the users if they don't do that already?

Regards,
BALATON Zoltan

