Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2500CCCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 14:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92Ei-0007zO-9b; Wed, 15 Oct 2025 10:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92Ef-0007yr-Gv
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:12:13 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92ET-0001od-UO
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:12:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id C49CCC051F;
 Wed, 15 Oct 2025 17:11:54 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a94::1:15] (unknown
 [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id sBRTeC3FwCg0-ykxmhtTq; Wed, 15 Oct 2025 17:11:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760537514;
 bh=Dkzyc6ls6FlNQGCzrZo7rvTIAsbPpEbiXLkIkJBTBzQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=TZN+p3jQJTOC7G1qgecNyeis2bayjhxDQIX1yp4DvruGUY3qes+Y/Js6g/zh3ZxJ/
 Ke7r96HwvzJ1eudYcfR2o1Rk38ID7yNrFBg+QZqLyQIN1G+PR8LGdSVJ85SKGhTpi/
 6YfgyxUCbTj5lLa579NoVMuHVv18gKROqPlymb3g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <433c747c-f7ca-4b5c-a83a-bb35cd872a7d@yandex-team.ru>
Date: Wed, 15 Oct 2025 17:11:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/33] qapi: docs: width=70 and two spaces between
 sentences
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: armbru@redhat.com, qemu-devel@nongnu.org, eblake@redhat.com
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
 <aOy0OtaNT9A48rhQ@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aOy0OtaNT9A48rhQ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 13.10.25 11:11, Daniel P. Berrangé wrote:
> On Sat, Oct 11, 2025 at 05:04:06PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> Let's bring the documentation in line with the requirements. And
>> do check these requirements in QAPI parser.
> 
> This implicitly assumes that the requirements are desirable.
> 
> This is a large number of patches, showing the requirements are widely
> ignored today. When I look at the changes in the patches my overwhealming
> reaction is that they are not beneficial, which in turn makes me believe
> the requirements should be changed to match the reality of the code,
> rather than the reverse.
> 

Markus, what do you think?

Maybe, add existing violations simply as exclusions to parser (maybe a mapping
{ file_name -> number_of_violations } ) ? This way we can add check for
new code, but avoid updating the old one.

Or should we change the requirements?

-- 
Best regards,
Vladimir

