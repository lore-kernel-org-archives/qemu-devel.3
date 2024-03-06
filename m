Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94158C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 16:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhuFV-0000MQ-Ne; Wed, 06 Mar 2024 11:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rhuEz-0000I7-BG
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:35:38 -0500
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rhuEn-0000HS-Db
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:35:36 -0500
Date: Wed, 6 Mar 2024 17:35:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1709742920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IBb9mMQ0RyAeIgmO7RIb3oT471Z8DOcBgnRyIDGIdg0=;
 b=Twv7sETmF4EAIYvDPM2ZVfHhfUTWvzFQvWFUuHR6GsmFhdEj2DE6/CKbaJHVwtSt8ZUIcr
 c3x3F1G9pW5nkiHm9wKPNEzwFgDZW3957MRUSb4X9b2kmKgxKiZ9XArzzRBGn1y/TAmJUo
 doBRVxF9qf95wm2VEIt3OR3YeQUwNet+w5+CF0Flc2lRNnFaI+BhrcmThgZBL9osfKd+K/
 g1SB9iyLLwQsWmY99htfNzIg9B+WFAgLWw+OCWrzXcTWKokUKv238+oiEE5Sb6e2B8Jql5
 OzV7Sj2RKGqd3CVrA1QJ0IVWY5UYrtwQv0eQa85Y6/svcmcVhUVOkD9HOK15VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1709742920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IBb9mMQ0RyAeIgmO7RIb3oT471Z8DOcBgnRyIDGIdg0=;
 b=ImxmQSg1morK1Gkw1QbYdpVIcKduJOb1+3mamyouE5+GduB5kKK0WNntmHsCYICeV1HaEK
 4W5xGt8rd87LlQDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <t-8ch@linutronix.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 0/4] docs/interop/firmware.json: scripts/qapi-gen.py
 compatibility
Message-ID: <20240306173337-20b140dc-af12-4d5b-a48a-5bd1e07ca0a0@linutronix.de>
References: <20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de>
 <d9ce0234-4beb-4b90-b14c-76810d3b81d7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9ce0234-4beb-4b90-b14c-76810d3b81d7@linaro.org>
Received-SPF: pass client-ip=2a0a:51c0:0:12e:550::1;
 envelope-from=t-8ch@linutronix.de; helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Mar 2024 11:36:08 -0500
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

On Wed, Mar 06, 2024 at 05:15:34PM +0100, Philippe Mathieu-DaudÈ wrote:
> On 6/3/24 11:31, Thomas Weiﬂschuh wrote:
> > docs/interop/firmware.json is currently not usable with qapi-gen.py due
> > to various non-functional issues.
> > Fix those issue to provide compatibility.
> 
> Could we add some lines in docs/meson.build to cover this files
> during our CI tests?

Sounds good.

I am also developing a new tool which would use the generated QAPI
files which I plan to submit soonish.

> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> > Thomas Weiﬂschuh (4):
> >        docs/interop/firmware.json: Align examples
> >        docs/interop/firmware.json: Fix doc for FirmwareFlashMode
> >        docs/interop/firmware.json: Use full include paths
> >        docs/interop/firmware.json: Include pragma.json
> > 
> >   docs/interop/firmware.json | 392 +++++++++++++++++++++++----------------------
> >   1 file changed, 197 insertions(+), 195 deletions(-)
> > ---
> > base-commit: db596ae19040574e41d086e78469014191d7d7fc
> > change-id: 20240306-qapi-firmware-json-6fb1213936dd
> > 
> > Best regards,

