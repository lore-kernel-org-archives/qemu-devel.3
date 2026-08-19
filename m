Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EE0C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhcr-0006DM-Dr; Wed, 19 Aug 2026 10:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@sourceandstack.com>)
 id 1wwhcP-00064L-Vj
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:50:18 -0400
Received: from sourceandstack.com ([159.223.220.208])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@sourceandstack.com>)
 id 1wwhcN-0007Zu-4c
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:50:17 -0400
Received: from [192.168.1.59] (82-225-132-210.subs.proxad.net [82.225.132.210])
 by sourceandstack.com (Postfix) with ESMTPSA id 1EF434803FA2;
 Wed, 19 Aug 2026 14:50:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceandstack.com 1EF434803FA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sourceandstack.com;
 s=mail; t=1787151011;
 bh=kPmN4hGywGp/AtJygT3oyAHPdLrFh7/77Gy9JFGhhs4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Z0YrDnItL5E6jAXDdlF0F1pWZhQmadcYf9DjZJmi6n8e8yEp4zIPpOtg6Gv0YCQpx
 K7iMQgcDRw74s42UAnESwWfjiPPDnR4YuOknlUcXqQ74VDZbmjiU/cWGa8ebdDTyrv
 lnSLU0oyERnVmh6Pi0Zn+77hb+WefaYQsn8KOSTk=
Message-ID: <b9e15e18-a92c-4835-8d8b-b27722e14003@sourceandstack.com>
Date: Wed, 19 Aug 2026 16:50:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 1/1] ui/dbus: add org.qemu.Display1.UIInfo interface
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Chengyang Zhu <colazcyg@gmail.com>, qemu-devel@nongnu.org
References: <20260818134543.654949-1-colazcyg@gmail.com>
 <20260818134543.654949-2-colazcyg@gmail.com>
 <CAJ+F1C+-EhCgeM2cK9QfZrN9c9OezuRO4E7NGmHiTFN=cHQLKA@mail.gmail.com>
 <e32a2d8b-e701-492e-b09b-f83eeb44da1e@sourceandstack.com>
 <CAJ+F1CL8kFYjgU-yU67kX2oX9PEapzz301RmW0=dPtnkffN-0Q@mail.gmail.com>
Content-Language: en-US
From: Christian Hergert <christian@sourceandstack.com>
In-Reply-To: <CAJ+F1CL8kFYjgU-yU67kX2oX9PEapzz301RmW0=dPtnkffN-0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1EF434803FA2
X-Spamd-Result: default: False [-0.10 / 15.00]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_ZERO(0.00)[0]; MID_RHS_MATCH_FROM(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:12322, ipnet:82.225.128.0/19, country:FR];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 LOCAL_OUTBOUND(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,nongnu.org];
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



On 8/19/26 4:43 PM, Marc-André Lureau wrote:
> That was his v1. But then we would need to have a way to introspect
> the known keys, and this is not really binding/tools friendly.

I would think that getting the current values is essentially the answer 
to what keys are supported? If you use a `mv` with a nullable you can 
export all the known keys and their values.

But ...

> Maybe we can have a lock on the interface? that would be per
> connection, but it could be enough?

I'm okay with the idea of exporting properties for all the things. I'm 
also okay with them being read/write. I just think they should apply 
immediately if using that API.

And if you want to set all of them "atomically", use either an extended 
SetUIInfo variant (either more parameters or a vardict).

Anyway, just my 2 cents.

-- Christian


