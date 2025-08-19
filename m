Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EDACA0EF5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 08:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoHue-0001J2-TF; Tue, 19 Aug 2025 04:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uoHua-0001Ii-It
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 04:41:45 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uoHuX-0000Mm-KL
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 04:41:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8c:0:640:7006:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 8F044C018E;
 Tue, 19 Aug 2025 11:41:36 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b25::1:17] (unknown
 [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ZfMX2I0G0mI0-ZpLLiiFE; Tue, 19 Aug 2025 11:41:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755592896;
 bh=hUrLMDIPUL1c+sXNLCecIkOQkofyobImHvhfC74ZOEg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=bjp1Fub+GoPYRd/oiTVCqMON/MgiiAhqz3PeM52on8IN8iVBL8wadAh7DBqAvbZQ8
 B7uvtD14P63PQ34X/O87A2dsuU89bSFlcRX1yt+qoV8lTEMCKdWagZggmLcBgJ/rwj
 DBSo3C6KiUDmrSWrmoCZC7DNRVYY4Zp8jXB/1DBU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <bcc0adcc-4d50-454c-abf9-334e15c712e4@yandex-team.ru>
Date: Tue, 19 Aug 2025 11:41:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] TAP initialization refactoring
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250818140645.27904-1-vsementsov@yandex-team.ru>
 <CACGkMEvHXy0=vwAGS+2S7jCa5TjLxOso-SYb15TTE5q=VtPA2A@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CACGkMEvHXy0=vwAGS+2S7jCa5TjLxOso-SYb15TTE5q=VtPA2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 19.08.25 05:45, Jason Wang wrote:
> On Mon, Aug 18, 2025 at 10:06 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> Hi all!
>>
>> As preparation for further development of TAP live local migration
>> (passing open fds through unix socket),
> 
> I'm not sure I understand this, but I think it has been supported now,
> or anything I miss?
> 

Hmm, may be I missing something, but where?

I see no code which put TAP fd into migration channel. Nothing about migration in tap.c at all.

So, normally, to make local migration with TAP device, you have to create a new TAP for new QEMU
process.

I want to add a migration state, which will include needed part of TAPState, including fd,
to continue using same TAP device in target process, avoiding also any initialization steps
on that fd.

-- 
Best regards,
Vladimir

