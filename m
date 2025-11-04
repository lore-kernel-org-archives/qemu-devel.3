Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A572FCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 09:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGDX6-0001wp-Hm; Tue, 04 Nov 2025 04:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGDX3-0001wc-IF
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 04:40:53 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGDX1-0004KE-AY
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 04:40:53 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7888:0:640:a8fd:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id B8BD5C00DB;
 Tue, 04 Nov 2025 12:40:47 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:95c::1:2] (unknown [2a02:6bf:8080:95c::1:2])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kegu0d1GrGk0-ZcGeO6Q1; Tue, 04 Nov 2025 12:40:47 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762249247;
 bh=yaKlWvBJrOJzePNm658H57Asufyh6V3nM6z4flH/DSc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=epBZOdiepAcWzW8yhr02o5JuY0kP+LomyGy+IgLr4GXZCrkLSW6Dya5Ck7HMg7LqV
 YEWoz4HuqdIElXE8/qeutwo0Py9iEsR2CF62UZeA0EnRLKu1S0SJ9cDG47mrzMmcVu
 iY3vzch9bb+HL+qkEXG5NZmdTCTJ7zhacYoVuIaU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2ac9b536-b935-4bdc-b9f9-ea5e6a40f901@yandex-team.ru>
Date: Tue, 4 Nov 2025 12:40:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] chardev: introduce DEFINE_PROP_CHR_NO_CONNECT
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20251031155914.189112-1-vsementsov@yandex-team.ru>
 <20251031155914.189112-8-vsementsov@yandex-team.ru>
 <CAMxuvawdBHuHEkZSQw0LtLmNGwuBAYsh-k8CwX=jfH5T+BFWfA@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAMxuvawdBHuHEkZSQw0LtLmNGwuBAYsh-k8CwX=jfH5T+BFWfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 02.11.25 14:39, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Oct 31, 2025 at 7:59 PM Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> wrote:
> 
>     For further vhost-user-blk backend-transfer migration realization we
>     want to give it (vhost-user-blk) a possibility (and responsibility) to
>     decide when do connect.
> 
>     For incoming migration we'll need to postpone connect at least until
>     early stage of migrate-incoming command, when we already know all
>     migration parameters and can decide, are we going to do incoming
>     backend-transfer (and get chardev fd from incoming stream), or we
>     finally need to connect.
> 
>     Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>>
>     ---
>       chardev/char-fe.c                   | 32 ++++++++++++++++++++++++-----
>       hw/core/qdev-properties-system.c    | 26 ++++++++++++++++++++---
>       include/chardev/char-fe.h           |  8 ++++++--
>       include/hw/qdev-properties-system.h |  3 +++
>       4 files changed, 59 insertions(+), 10 deletions(-)
> 
>     diff --git a/chardev/char-fe.c b/chardev/char-fe.c
>     index c67b4d640f..1132ec0501 100644
>     --- a/chardev/char-fe.c
>     +++ b/chardev/char-fe.c
>     @@ -189,15 +189,26 @@ bool qemu_chr_fe_backend_open(CharFrontend *c)
>           return c->chr && c->chr->be_open;
>       }
> 
>     -bool qemu_chr_fe_init(CharFrontend *c, Chardev *s, Error **errp)
>     +bool qemu_chr_fe_init_ex(CharFrontend *c, Chardev *s, bool connect,
>     +                         Error **errp)
>       {
>           unsigned int tag = 0;
> 
>     -    if (!qemu_chr_connect(s, errp)) {
>     -        return false;
>     -    }
>     -
>           if (s) {
>     +        if (connect) {
>     +            if (!qemu_chr_connect(s, errp)) {
>     +                return false;
>     +            }
>     +        } else {
>     +            /* DEFINE_PROP_CHR_NO_CONNECT */
>     +            if (!s->connect_postponed) {
>     +                error_setg(errp,
>     +                           "Chardev %s does not support postponed connect",
>     +                           s->label);
>     +                return false;
>     +            }
>     +        }
>     +
>               if (CHARDEV_IS_MUX(s)) {
>                   MuxChardev *d = MUX_CHARDEV(s);
> 
>     @@ -210,6 +221,12 @@ bool qemu_chr_fe_init(CharFrontend *c, Chardev *s, Error **errp)
>               } else {
>                   s->fe = c;
>               }
>     +    } else {
>     +        /*
>     +         * connect=false comes only from DEFINE_PROP_CHR_NO_CONNECT,
>     +         * through do_set_chr, which provides chardev ptr.
>     +         */
>     +        assert(connect);
> 
> 
> Is this useful to assert?


Hmm. I started to write "yes, because, if in future we introduce code path, which will
somehow pass s=NULL and connect=false, we'll do a wrong thing.."

But looking more closely at semantics of s=0, looks like connect could be just ignored:
no backend, nothing to connect.. So connect=true with s=0 looks maybe more wrong
than connect=false.

I'll drop the assertion, and add not into qemu_chr_fe_init_ex(), that @connect is ignored
for s=NULL case.

-- 
Best regards,
Vladimir

