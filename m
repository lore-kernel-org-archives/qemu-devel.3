Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E9ACAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v10AW-0002sB-85; Tue, 23 Sep 2025 06:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v10AL-0002ns-8V
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:22:34 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v10A4-0003Io-3m
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:22:24 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0CF15C0160;
 Tue, 23 Sep 2025 13:22:06 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b38::1:12] (unknown
 [2a02:6bf:8080:b38::1:12])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 3MUwHC0GsCg0-BqgHmiqD; Tue, 23 Sep 2025 13:22:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758622925;
 bh=xsXx/X+o0vONPccTKBYTstWs3lavfgjePkDCVoJv/gk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=TT+CTG2/z+u/NN+ECXKKJYrThO9FVWvONq6k+GCOoJmvN99xPGoqetVWvNaDsi1DL
 eb+qmyqvh5ujJkohOnYi+cU3NZariUXzV8Hl96cMe330YgQbWJBtuEsegGs7NxD8NG
 CE/C4zxLorSxCwuFuP/hClwTlQr+/oAl3IQBozkI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d335cd2a-19df-49b7-a187-6afda90e4853@yandex-team.ru>
Date: Tue, 23 Sep 2025 13:22:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] ivshmem-flat: Mark an instance of missing error
 handling FIXME
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20250923091000.3180122-1-armbru@redhat.com>
 <20250923091000.3180122-13-armbru@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250923091000.3180122-13-armbru@redhat.com>
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

On 23.09.25 12:09, Markus Armbruster wrote:
> ivshmem-flat's ivshmem_flat_add_vector() neglects to handle
> qemu_set_blocking() failure.  It used to silently ignore errors there.
> Recent commit 6f607941b1c (treewide: use qemu_set_blocking instead of
> g_unix_set_fd_nonblocking) changed it to warn (without mentioning it
> the commit message, tsk, tsk, tsk).

Yes, my fault.
> 
> Note that ivshmem-pci's process_msg_connect() handles this error.
> 
> Add a FIXME comment to mark the missing error handling.
> 
> Cc: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> ---
>   hw/misc/ivshmem-flat.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
> index e83e6c6ee9..27ee8c9218 100644
> --- a/hw/misc/ivshmem-flat.c
> +++ b/hw/misc/ivshmem-flat.c
> @@ -138,6 +138,8 @@ static void ivshmem_flat_remove_peer(IvshmemFTState *s, uint16_t peer_id)
>   static void ivshmem_flat_add_vector(IvshmemFTState *s, IvshmemPeer *peer,
>                                       int vector_fd)
>   {
> +    Error *err = NULL;
> +
>       if (peer->vector_counter >= IVSHMEM_MAX_VECTOR_NUM) {
>           trace_ivshmem_flat_add_vector_failure(peer->vector_counter,
>                                                 vector_fd, peer->id);
> @@ -154,8 +156,10 @@ static void ivshmem_flat_add_vector(IvshmemFTState *s, IvshmemPeer *peer,
>        * peer.
>        */
>       peer->vector[peer->vector_counter].id = peer->vector_counter;
> -    /* WARNING: qemu_socket_set_nonblock() return code ignored */
> -    qemu_set_blocking(vector_fd, false, &error_warn);
> +    if (!qemu_set_blocking(vector_fd, false, &err)) {
> +        /* FIXME handle the error */
> +        warn_report_err(err);
> +    }
>       event_notifier_init_fd(&peer->vector[peer->vector_counter].event_notifier,
>                              vector_fd);
>   


-- 
Best regards,
Vladimir

