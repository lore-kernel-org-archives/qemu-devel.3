Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D44C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u16W9-0003Zd-N2; Sat, 05 Apr 2025 12:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vitalif@yourcmc.ru>)
 id 1u16W6-0003ZN-T6; Sat, 05 Apr 2025 12:37:11 -0400
Received: from yourcmc.ru ([195.209.40.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vitalif@yourcmc.ru>)
 id 1u16W4-0000gZ-O9; Sat, 05 Apr 2025 12:37:10 -0400
Received: from yourcmc.ru (localhost [127.0.0.1])
 by yourcmc.ru (Postfix) with ESMTP id 452E5FE0665;
 Sat,  5 Apr 2025 19:37:03 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yourcmc.ru; s=mail;
 t=1743871023; bh=5R8m72JIE9u9RhhCZugjk/Qev6hwl5jq63sbOpQGMjU=;
 h=Date:From:Subject:To:Cc:In-Reply-To:References;
 b=Iz3FRsiJ96+0m+AEjSwOYaRh7R6XCmLd+X0DiX5eF/NFEgzrnEeNC92y84PUEXLQl
 onww4BtKKaBmFogQxgFlJVhs9kqst5g7L4S3L6dNSunF27KWUFUsTnqRGg0AQ06FRm
 RGq5coUtWulUkrj+eJ3mmhEsrNmRB1Qhc/JdxnoE/6hq92V+UIHn53CzQIN3i3H3WJ
 hIAuVPlAGEWEg34vAUI08uwY1B2NvK7wEUfBG1Mgz8hgeJt0e5aiqI0Ho58O1FF2rK
 JZDKliByGJqRUr4vyTLsQQfIFrBJHT9xjKSsIQKLXfPLHkn9ZAhZ+40F8O0k7TR6c9
 TTwUQPsJIjUMQ==
Received: from rainloop.yourcmc.ru (yourcmc.ru [195.209.40.11])
 by yourcmc.ru (Postfix) with ESMTPSA id 17D85FE065E;
 Sat,  5 Apr 2025 19:37:03 +0300 (MSK)
MIME-Version: 1.0
Date: Sat, 05 Apr 2025 16:37:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.14.0
From: vitalif@yourcmc.ru
Message-ID: <ec93005bdebf0507ea90719f4d445fc7@yourcmc.ru>
Subject: Re: Can I contribute Vitastor block driver? Or maybe introduce a
 QAPI plugin system?
To: "Markus Armbruster" <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, "Peter Maydell"
 <peter.maydell@linaro.org>, "Stefan Hajnoczi" <stefanha@redhat.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>
In-Reply-To: <871pukb08s.fsf@pond.sub.org>
References: <871pukb08s.fsf@pond.sub.org>
 <bd5c6126f8c345b1eeac617d4023fa58@yourcmc.ru>
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=195.209.40.11; envelope-from=vitalif@yourcmc.ru;
 helo=yourcmc.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ok, thank you very much for the information!=0A=0ASo I should first try t=
o make my library available in one of the distros used for CI. As I under=
stand these are Alpine, Ubuntu, Debian, Fedora, CentOS and OpenSUSE. OK, =
I'll try it first :)=0A=0ARegarding QAPI, I'd say it would be cool if it =
was allowed... I'm not sure if GPL circumvention is a real risk, because =
in some way it's already possible via the vhost-user protocol %). But it'=
s up to you to decide of course :)=0A=0A> I'm not speaking for the QEMU p=
roject. I hope to be helpful anyway. I=0A> am the QAPI maintainer, so my =
thoughts carry a bit more weight there.=0A> =0A> I understand your block =
driver depends on your libvitastor_client=0A> library.=0A> =0A> Dependenc=
ies that aren't available on at least one supported build=0A> platform (a=
nd thus covered by CI) are problematic. For Linux,=0A> "available" genera=
lly means "provided by the distribution". I doubt=0A> there's a way aroun=
d getting your library packaged by distributions.=0A> =0A> The QAPI schem=
a is (for better or worse) fixed at compile time by=0A> design. Changing =
that would be a major undertaking. Whether the=0A> benefits could justify=
 the costs and risks seems rather doubtful to me.=0A> =0A> In my experien=
ce, the project invites contributions, not out-of-tree=0A> extensions. Th=
e latter require external interfaces, which can only be=0A> harder to mai=
ntain than internal ones. There's also the risk of abuse=0A> to circumven=
t the GPL (I have absolutely no reason to assume you'd try=0A> that!).

