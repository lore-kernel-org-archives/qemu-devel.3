Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48AD10F9973
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYGp-0004Zz-7U; Wed, 08 Apr 2026 15:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wAYF9-00034m-HM; Wed, 08 Apr 2026 15:07:24 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wANsx-0004x6-LD; Wed, 08 Apr 2026 04:03:42 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:7605:0:640:8d9a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 74CA58065F;
 Wed, 08 Apr 2026 11:03:32 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:495::1:13] (unknown
 [2a02:6bf:8080:495::1:13])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id V3ALbN0KjeA0-nUJGDohs; Wed, 08 Apr 2026 11:03:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1775635411;
 bh=Oq+j4cr3frwBNfvkqGrnpLuInzt0C2ftjw0KtTcIMJQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=TrG/l59pK9ONtvp/yOrfeXuIW3U6fw+VB6p5ujlcCPrekIafzV+NqeBtCR4AOd1id
 wuw/iBaT+xQc/mXfJ19tjWTKfSYVLaHXzbfQO91tayi16w7jbkjQUsiPczyyI+hKHJ
 03923DGrcZK7K1uPtmpLoJpqcTwjB1RVM/k5NnOY=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <fa352330-32a8-4491-b045-812eb8a05966@yandex-team.ru>
Date: Wed, 8 Apr 2026 11:03:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu-nbd: Support -s and -l at the same time
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20260408021636.794794-2-eblake@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260408021636.794794-2-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 08.04.26 05:16, Eric Blake wrote:
> qemu-nbd already has the ability to wrap a read-write layer on top of
> the export of a read-only image (-s) and the ability to export an
> internal snapshot rather than the main image in a qcow2 file (-l
> SNAPID).  But it gave a confusing error message when trying to mix the
> two, because the snapshot overlay created first no longer has access
> to the internal snapshots of the image being wrapped.
> 
> WIth a bit of finesse, this useful scenario is now supported.
> 
> https://gitlab.com/qemu-project/qemu/-/work_items/159
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Some optional suggestions below:

> +
> +echo
> +echo "=== Main image in snapshot mode ==="
> +echo
> +
> +nbd_server_start_unix_socket -s -f qcow2 "$TEST_IMG"
> +$QEMU_IO -c 'r -P 2 3M 1M' -c 'w -P 3 3M 1M' -f raw \

Maybe, add read command after write, to check write correctness. [*]

> +  nbd:unix:$nbd_unix_socket | _filter_qemu_io
> +nbd_server_stop
> +
> +echo
> +echo "=== Read-only snapshot access ==="
> +echo
> +
> +nbd_server_start_unix_socket -l snap -f qcow2 "$TEST_IMG"
> +$QEMU_IO -r -c 'r -P 1 3M 1M' -f raw \

Suggest, add write command, to check that it fails.

> +  nbd:unix:$nbd_unix_socket | _filter_qemu_io
> +nbd_server_stop
> +
> +echo
> +echo "=== Combine -s and -l for read-write internal snapshot access ==="
> +echo
> +
> +nbd_server_start_unix_socket -s -l snap -f qcow2 "$TEST_IMG"
> +$QEMU_IO -c 'r -P 1 3M 1M' -c 'w -P 3 3M 1M' -f raw \

[*] and here

> +  nbd:unix:$nbd_unix_socket | _filter_qemu_io
> +nbd_server_stop
> +
> +echo
> +echo "=== Check that original image is unchanged ==="
> +echo
> +



-- 
Best regards,
Vladimir

