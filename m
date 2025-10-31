Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E27CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElpM-0006WC-55; Fri, 31 Oct 2025 05:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vElpH-0006Ve-P4
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:53:43 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vElpD-00088i-0t
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:53:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 84DE58089A;
 Fri, 31 Oct 2025 12:53:32 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:546::1:17] (unknown
 [2a02:6bf:8080:546::1:17])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VrcbOQ0Fo4Y0-MtnuDgoM; Fri, 31 Oct 2025 12:53:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761904412;
 bh=k05jR+uh0VRifgOVnWrv6cbXOEF+IYlYI/WlqxL/SBE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=LAxaf7l9yDCYBgtLRA+pN1+yI+sdzCtYWYFneiYZW+qH8Fu4zEJDENCmQxdSRjuLH
 4eJuHZ3DW25n2HgyuBCEnSTWjKVqjquYlijXObRqe5prC+jIpm9qeb9vE9R/IALgVD
 Zp/soHkqztvRi+xZQy5q9QE6pbNO+oBv14MI9mmg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <1313b150-57dc-4bd2-a593-63529e0026b0@yandex-team.ru>
Date: Fri, 31 Oct 2025 12:53:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] qapi/audio: Fix description markup of
 AudiodevDBusOptions @nsamples
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, thuth@redhat.com,
 berrange@redhat.com, philmd@linaro.org, kchamart@redhat.com, mst@redhat.com,
 sgarzare@redhat.com
References: <20251031094751.2817932-1-armbru@redhat.com>
 <20251031094751.2817932-2-armbru@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251031094751.2817932-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 31.10.25 12:47, Markus Armbruster wrote:
> The description of Member @nsamples is indented incorrectly.  Comes
> out like
> 
>      Members:
>              [...]
> 	    nsamples (int, optional) – set the number of samples per read/write calls (default to 480,
> 
>      10ms at 48kHz).
> 
> Fixing the indentation makes it come out like
> 
>      Members:
>              [...]
> 	    nsamples (int, optional) – set the number of samples per read/write calls (default to 480, 10ms at 48kHz).
> 

I'm not sure this example worth breaking recommendation to
" not use lines that are longer than 76 characters in your commit message" :)

> Fixes: 19c628f2f579 (dbus: add -audio dbus nsamples option)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> ---
>   qapi/audio.json | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/audio.json b/qapi/audio.json
> index 53142080f7..2df87b9710 100644
> --- a/qapi/audio.json
> +++ b/qapi/audio.json
> @@ -76,8 +76,8 @@
>   #
>   # @out: options of the playback stream
>   #
> -# @nsamples: set the number of samples per read/write calls (default to 480,
> -# 10ms at 48kHz).
> +# @nsamples: set the number of samples per read/write calls
> +#     (default to 480, 10ms at 48kHz).
>   #
>   # Since: 10.0
>   ##


-- 
Best regards,
Vladimir

