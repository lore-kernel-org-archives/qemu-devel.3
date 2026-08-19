Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E51C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhSA-0000b2-RQ; Wed, 19 Aug 2026 10:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@sourceandstack.com>)
 id 1wwhS9-0000ao-8U
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:39:41 -0400
Received: from sourceandstack.com ([159.223.220.208])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@sourceandstack.com>)
 id 1wwhS7-0005CG-CM
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:39:41 -0400
Received: from [192.168.1.59] (82-225-132-210.subs.proxad.net [82.225.132.210])
 by sourceandstack.com (Postfix) with ESMTPSA id EFCBC4803FA2;
 Wed, 19 Aug 2026 14:39:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceandstack.com EFCBC4803FA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sourceandstack.com;
 s=mail; t=1787150376;
 bh=y33y/aV9iEwwdJCTnKZk8XVU4xfieHh8vWX0Fkic1Y0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ClmOWu6zRZ/VgZgAhk+tF39BFMfsDZU6wqRgDngHl3U9vbwR+kuK2wmJeJDozyJ3/
 M+pW/8kc87DtVWI9H9VM+A0nZY4yQzbz1Od4egrKP7tdRiq2R2Px3cIW+EeQJWWTx/
 G1afDUzTiNKJWRlw07QMqO5ORtOCk8IEUxnqi/8U=
Message-ID: <e32a2d8b-e701-492e-b09b-f83eeb44da1e@sourceandstack.com>
Date: Wed, 19 Aug 2026 16:39:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 1/1] ui/dbus: add org.qemu.Display1.UIInfo interface
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Chengyang Zhu <colazcyg@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20260818134543.654949-1-colazcyg@gmail.com>
 <20260818134543.654949-2-colazcyg@gmail.com>
 <CAJ+F1C+-EhCgeM2cK9QfZrN9c9OezuRO4E7NGmHiTFN=cHQLKA@mail.gmail.com>
Content-Language: en-US
From: Christian Hergert <christian@sourceandstack.com>
In-Reply-To: <CAJ+F1C+-EhCgeM2cK9QfZrN9c9OezuRO4E7NGmHiTFN=cHQLKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EFCBC4803FA2
X-Spamd-Result: default: False [-0.10 / 15.00]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_ZERO(0.00)[0]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:12322, ipnet:82.225.128.0/19, country:FR];
 FREEMAIL_TO(0.00)[redhat.com,gmail.com];
 MID_RHS_MATCH_FROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; LOCAL_OUTBOUND(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Action: no action
X-Rspamd-Server: sourceandstack.com
Received-SPF: pass client-ip=159.223.220.208;
 envelope-from=christian@sourceandstack.com; helo=sourceandstack.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

I have concerns with any sort of stateful tracking and/or application of 
properties as they are prone to data races.

If we want something more extensible for the future, we can use `a{sv}` 
with well-known keys.

-- Christian


On 8/18/26 5:01 PM, Marc-André Lureau wrote:
> That looks good to me. I am aware of concerns about refresh_rate unit
> (https://gitlab.gnome.org/GNOME/libmks/-/merge_requests/53#note_2834466),
> but I guess we will address this in due course
> 
> Christian, does this new interface look right to you?


