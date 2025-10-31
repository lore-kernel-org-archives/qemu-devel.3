Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDB2CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmlV-0004CQ-Ti; Fri, 31 Oct 2025 06:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEmlQ-00040V-KF
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:53:49 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEmlE-0002wA-24
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:53:46 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 1C0F58088E;
 Fri, 31 Oct 2025 13:53:23 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:546::1:17] (unknown
 [2a02:6bf:8080:546::1:17])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LrdctV0F5W20-fXK9Af8u; Fri, 31 Oct 2025 13:53:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761908002;
 bh=NZdJT1vHcFzL9Y58GomzruN4X9pHbFvKHIdVvz3SkkY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=WSfN05jx8EczuXG1xyRlb5b+woRtUl/vO/iZI5SJFUaC4hmw5+ynmI50xNRd8q932
 qoiAODc+q8u92dJzJhF1jEueNWiUhLuVW/tBjfMBT5kRmrYK5CwGi35iChUIq47miT
 qd0Kwmf+W7Zp33kOHE8bWT+Ul7MDCgBkijhoqGaY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4d7c7507-970b-4eb2-8817-f18fd3693a73@yandex-team.ru>
Date: Fri, 31 Oct 2025 13:53:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] docs/interop: Add test to keep vhost-user.json sane
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, thuth@redhat.com,
 berrange@redhat.com, philmd@linaro.org, kchamart@redhat.com, mst@redhat.com,
 sgarzare@redhat.com
References: <20251031094751.2817932-1-armbru@redhat.com>
 <20251031094751.2817932-9-armbru@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251031094751.2817932-9-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 31.10.25 12:47, Markus Armbruster wrote:
> We did this for firmware.json in commit d4181658dfb (docs: add test
> for firmware.json QAPI).
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/meson.build | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/meson.build b/docs/meson.build
> index 3676f81c4d..7e54b01e6a 100644
> --- a/docs/meson.build
> +++ b/docs/meson.build
> @@ -99,7 +99,12 @@ if build_docs
>     alias_target('man', sphinxmans)
>   endif
>   
> -test('QAPI firmware.json regression tests', qapi_gen,
> -     args: ['-o', meson.current_build_dir() / 'qapi',
> +test('QAPI firmware.json regression test', qapi_gen,
> +     args: ['-o', meson.current_build_dir() / 'qapi-firmware',
>               meson.current_source_dir() / 'interop/firmware.json'],
>        suite: ['qapi-schema', 'qapi-interop'])
> +
> +test('QAPI vhost-user.json regression test', qapi_gen,
> +     args: ['-o', meson.current_build_dir() / 'qapi-vhost-user',
> +            meson.current_source_dir() / 'interop/vhost-user.json'],
> +     suite: ['qapi-schema', 'qapi-interop'])

Hmm, if we have more .json files in docs, we'll need some more
convenient and safe way to cover them all.


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

