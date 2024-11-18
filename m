Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8E0D43FE3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 07:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCwD9-0008Bd-5a; Mon, 18 Nov 2024 02:30:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tCwCP-00082j-PF; Mon, 18 Nov 2024 02:29:29 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tCwCM-0003sy-8U; Mon, 18 Nov 2024 02:29:29 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a1f:0:640:ba2e:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 36AD360CB9;
 Mon, 18 Nov 2024 10:29:16 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:210::1:15] (unknown
 [2a02:6b8:b081:210::1:15])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BTKeqS0IkeA0-ZGme229n; Mon, 18 Nov 2024 10:29:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1731914955;
 bh=ISTZ80YC6HnocmfM2ObFXWEp+q9pmqNwH9E6QB5G+tY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=lPPbNrHIp6zMI1EpYBY5/VQJD0lSdvDNUkYyczD29c4+WHWnjxsgYTQRAnK1Jxw4A
 M5vHtBUxPZ6OJYcofSFAkdPtYy3o5n+cPHfNC1Xna03NdVrusf7/FZbTNvpAMDBkAc
 jPnl7HuMdsBkP9b/IGna+ZKTiGn2rd24VqvtnBRs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <36d5ee08-684b-4f33-b033-3e594bdca0d6@yandex-team.ru>
Date: Mon, 18 Nov 2024 10:29:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd-server: Silence server warnings on port probes
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
References: <20241115195638.1132007-2-eblake@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20241115195638.1132007-2-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 15.11.24 22:55, Eric Blake wrote:
> While testing the use of qemu-nbd in a Pod of a Kubernetes cluster, I
> got LOTS of log messages of the forms:
> 
> qemu-nbd: option negotiation failed: Failed to read flags: Unexpected end-of-file before all data were read
> qemu-nbd: option negotiation failed: Failed to read flags: Unable to read from socket: Connection reset by peer
> 
> While it is nice to warn about clients that aren't following protocol
> (in case it helps diagnosing bugs in those clients), a mere port probe
> (where the client never write()s any bytes, and where we might even
> hit EPIPE in trying to send our greeting to the client) is NOT
> abnormal, but merely serves to pollute the log.  And Kubernetes
> really  likes to do port probes to determine whether a given Pod is
> up and running.
> 
> Easy ways to demonstrate the above port probes:
> $ qemu-nbd -r -f raw path/to/file &
> $ nc localhost 10809 </dev/null
> $ bash -c 'exec </dev/tcp/localhost/10809'
> $ kill $!
> 
> Silence the noise by not capturing errors until after our first
> successful read() from a client.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


