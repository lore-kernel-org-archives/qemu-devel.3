Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F43FC9832A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 19:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhCFm-0002eR-Rm; Sat, 17 Jan 2026 14:46:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhCFh-0002cb-PY
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 14:46:30 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhCFe-0002mh-Uk
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 14:46:29 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 918148083F;
 Sat, 17 Jan 2026 22:46:18 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:57b::1:29] (unknown
 [2a02:6bf:8080:57b::1:29])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GkdaBr0A8W20-SPooiaMh; Sat, 17 Jan 2026 22:46:18 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768679178;
 bh=YdnHjTyZT7Y8lFNv0KUFm8Ebi0J6dwR8j3PfYkp8+IA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=lg+0mARGeMohkxKwaVAPcjVZsvWl0TKXFEq4YWRoo9qMTXE5cXa28EQixKdSUgbkA
 0cFkgTJa3SaFf/BnkYC+OY+UkmU5zXtgFiiuwKjoP8JpbSRv2Mmiqf3/7q++chlk5G
 sjlGMfmZ+lF/Bi9bRTaxAcQHxUTBUUBG9AGoChiU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <5350dd32-3c08-420f-a53b-817d3bcb0172@yandex-team.ru>
Date: Sat, 17 Jan 2026 22:46:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] char: add option to inject timestamps into logfile
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 qemu-devel@nongnu.org, philmd@linaro.org
References: <20251204202653.597319-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251204202653.597319-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

Ping !)

On 04.12.25 23:26, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> The ability to correlate the QEMU log and the guest log can be useful
> for investigating problems. So, I suggest an option to inject timestimps
> into logfile while writing it.
> 
> v2: do not make real_time_iso8601 static inline
> 
> Vladimir Sementsov-Ogievskiy (3):
>    char: qemu_chr_write_log() use qemu_write_full()
>    error-report: make real_time_iso8601() public
>    chardev: add logtimestamp option
> 
>   chardev/char.c              | 73 +++++++++++++++++++++++++++++--------
>   include/chardev/char.h      |  2 +
>   include/qemu/error-report.h |  6 +++
>   qapi/char.json              |  6 ++-
>   util/error-report.c         |  3 +-
>   5 files changed, 71 insertions(+), 19 deletions(-)
> 


-- 
Best regards,
Vladimir

