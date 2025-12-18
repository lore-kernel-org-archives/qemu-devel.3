Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD91D6E2AD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 15:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWGNV-00065h-Il; Thu, 18 Dec 2025 10:57:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan.weil@weilnetz.de>)
 id 1vWGNT-00065V-Bx
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:57:19 -0500
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan.weil@weilnetz.de>)
 id 1vWGNR-0007oi-9m
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:57:19 -0500
Received: from [192.168.178.140] (p5b151e44.dip0.t-ipconnect.de [91.21.30.68])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTPSA id 790CBDA07A3;
 Thu, 18 Dec 2025 16:57:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weilnetz.de; s=dkim1; 
 t=1766073434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XusXlGntoiFgg58UGGBWq0cn40/teBYDA3GMVfQYJRU=;
 b=gS7Zcj3xI2qvN2wS4fHMTds1BKSiyvtMQxn1iiq5qkNKxGE8zR0bHtUTO0+6H8X0Fz1zGh
 BrKdHg7/IUtkw5W9h7uOCqIEWkcIK/Y1MVf0LNO7fg6Jyu4kxR5Fl91ods+CMzn+Qfc5gp
 Q30++wFF/xZNLeWy6AvoO06Mv89Uh+c=
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=stefan.weil@weilnetz.de
 smtp.mailfrom=stefan.weil@weilnetz.de
Message-ID: <97a6f77e-7a86-4bbc-a20a-b1e1c7bdb537@weilnetz.de>
Date: Thu, 18 Dec 2025 16:57:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Report on MAINTAINERS coverage
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87h5toc61n.fsf@pond.sub.org>
Autocrypt: addr=stefan.weil@weilnetz.de; keydata=
 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
In-Reply-To: <87h5toc61n.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: v2201612906741603
X-Rspamd-Queue-Id: 790CBDA07A3
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.10 / 12.00]; BAYES_HAM(-3.00)[99.99%];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_ZERO(0.00)[0];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[weilnetz.de:s=dkim1]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:email,sub.org:email]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=37.120.169.71;
 envelope-from=stefan.weil@weilnetz.de; helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Stefan Weil <stefan.weil@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 18.12.25 um 13:45 schrieb Markus Armbruster:
> Back in 2014 (time flies), I posted
> 
>      Subject: MAINTAINERS leaves too many files uncovered
>      Message-ID: <87mw8rumhb.fsf@blackfin.pond.sub.org>
>      https://lore.kernel.org/qemu-devel/87mw8rumhb.fsf@blackfin.pond.sub.org/
> 
> I updated my findings in 2015, 2016 (at commit e00da552a0d), 2018 (at
> v3.1.0-rc2), and 2023 (at commit 36e9aab3c56, close to v8.2.0).  This is
> another update, at v10.2.0-rc4.


These two files were contributed by me and most of my initial code is 
still unmodified, so I could be added as their maintainer:

hw/nvram/eeprom93xx.c
include/hw/nvram/eeprom93xx.h

I had two contributions to the eeprom93xx.c (one made by Thiemo in my 
name). Other authors had also two or more contributions:

       2 Author: Alex Williamson <alex@shazbot.org>
       2 Author: Anthony Liguori <anthony@codemonkey.ws>
       2 Author: Aurelien Jarno <aurelien@aurel32.net>
       2 Author: Marc-André Lureau <marcandre.lureau@redhat.com>
       3 Author: Blue Swirl <blauwirbel@gmail.com>
       3 Author: Juan Quintela <quintela@trasno.org>
       3 Author: Paolo Bonzini <pbonzini@redhat.com>
       5 Author: Markus Armbruster <armbru@redhat.com>

I am not sure about the desired order in MAINTAINERS. Therefore I don't 
intend to send a patch but would be happy if someone else updates this file.

For the other files which are von covered by MAINTAINERS, the copyright 
notice might help to find possible maintainers:

grep --no-filename -r -o "Copyright.*" $(cat FILELIST)|sort -i|uniq -ci

Thanks
Stefan W.


