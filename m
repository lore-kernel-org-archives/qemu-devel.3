Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA00CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 14:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux4iM-0005xM-Fv; Fri, 12 Sep 2025 10:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ux4iJ-0005vm-Ow
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:25:23 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ux4iB-0003ab-Pa
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:25:23 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 09183C016F;
 Fri, 12 Sep 2025 17:25:09 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b3c::1:2f] (unknown
 [2a02:6bf:8080:b3c::1:2f])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 8PNaTs0GqqM0-cYXVvwCf; Fri, 12 Sep 2025 17:25:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757687108;
 bh=Rt5WbGTY7r/RlvH96bkr+1KLHy6A23lZiYnVdqDcjgk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=QNSWruB66MR3H/wI95ThQ/F4A9ZY2M51HFenoRnqBGkmnBeWV7tsdx84OzX+oRuI1
 q+kKXwIZ70LRtJSbe0vYER9edjjAZV3t6TlMtK0rcWQ+xeahl94vO8TbF+tsd4pUmv
 E5GJ473bjY6Qglb6Eur/U8lNLceDlR6Ws5z9N+yw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ee11ef02-764a-42c2-a2ab-f1af489a86ae@yandex-team.ru>
Date: Fri, 12 Sep 2025 17:25:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] qapi: net/tap: deprecate vhostforce option
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org
References: <20250901153943.65235-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250901153943.65235-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

ping)

On 01.09.25 18:39, Vladimir Sementsov-Ogievskiy wrote:
> This option doesn't make sense since long ago (10 years!)
> commit 1e7398a140f7a6 ("vhost: enable vhost without without MSI-X").
> 
> Prior 1e7398a140f7a6, to enable vhost for some specific kind of guests
> (that don't have MSI-X support), you should have set vhostforce=on
> (with vhost=on or unset).
> 
> Since 1e7398a140f7a6, guest type doesn't matter, all guests are equal
> for vhost-enabling options logic.
> 
> The current logic is:
>    vhost=on / vhost=off : vhostforce ignored, doesn't make sense
>    vhost unset : vhostforce counts, enabling vhost
> 
> Currently you may enable vhost several ways:
> - vhost=on
> - vhostforce=on
> - vhost=on + vhostforce=on
> - and even vhost=on + vhostforce=off
> 
> - they are all equal.
> 
> Let's finally deprecate the extra option.
> 
> Also, fix @vhostforce documentation.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
> 
> v3: - two spaces between sentences for vhostforce description
>      - add r-b by Markus
> 
>   docs/about/deprecated.rst |  7 +++++++
>   qapi/net.json             | 11 +++++++++--
>   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index d50645a071..b17a5a41aa 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -516,6 +516,13 @@ Stream ``reconnect`` (since 9.2)
>   The ``reconnect`` option only allows specifying second granularity timeouts,
>   which is not enough for all types of use cases, use ``reconnect-ms`` instead.
>   
> +TAP ``vhostforce`` (since 10.2)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The ``vhostforce`` option is redundant with the ``vhost`` option.
> +If they conflict, ``vhost`` takes precedence.  Just use ``vhost``.
> +
> +
>   VFIO device options
>   '''''''''''''''''''
>   
> diff --git a/qapi/net.json b/qapi/net.json
> index 78bcc9871e..bab26e0c5d 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -346,13 +346,20 @@
>   # @vhostfds: file descriptors of multiple already opened vhost net
>   #     devices
>   #
> -# @vhostforce: vhost on for non-MSIX virtio guests
> +# @vhostforce: enable vhost-net network accelerator.  Ignored when
> +#    @vhost is set.
>   #
>   # @queues: number of queues to be created for multiqueue capable tap
>   #
>   # @poll-us: maximum number of microseconds that could be spent on busy
>   #     polling for tap (since 2.7)
>   #
> +# Features:
> +#
> +# @deprecated: Member @vhostforce is deprecated.  The @vhostforce
> +#    option is redundant with the @vhost option. If they conflict,
> +#    @vhost takes precedence.  Just use @vhost.
> +#
>   # Since: 1.2
>   ##
>   { 'struct': 'NetdevTapOptions',
> @@ -369,7 +376,7 @@
>       '*vhost':      'bool',
>       '*vhostfd':    'str',
>       '*vhostfds':   'str',
> -    '*vhostforce': 'bool',
> +    '*vhostforce': { 'type': 'bool', 'features': [ 'deprecated' ] },
>       '*queues':     'uint32',
>       '*poll-us':    'uint32'} }
>   


-- 
Best regards,
Vladimir

