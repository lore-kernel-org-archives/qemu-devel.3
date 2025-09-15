Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408BBCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 18:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyDj0-00009Y-Ex; Mon, 15 Sep 2025 14:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyDiu-00008L-T7; Mon, 15 Sep 2025 14:14:45 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyDij-00086D-3L; Mon, 15 Sep 2025 14:14:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 2D394C0152;
 Mon, 15 Sep 2025 21:14:19 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:184::1:6] (unknown [2a02:6bf:8080:184::1:6])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id IEUHLJ1Gv4Y0-5992I1O5; Mon, 15 Sep 2025 21:14:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757960058;
 bh=GAlMigeMbIB0iEWMicV6FYWXbZTwaeXiQt/ssdunjU4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=jxxVX8hbCzin0b8Vv/V5iUcxyvl/GD+KsKi0eZQHLWCr+HaC6GFy3VOruiDR4s402
 N6PtdPFw4mTvmxuu4LfwmcoQCmN/57ctCS/b9Mi/MLVwKTKhrYL7+bPsoHlw2Cf+2h
 J1MUR2Lr6OV+gZcSnlj/cepG3Ve1Qb+UpgHbUxW4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c1907e57-d279-40fa-b181-3b54441c49d7@yandex-team.ru>
Date: Mon, 15 Sep 2025 21:14:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/13] util/error: add &error_reporter
To: Peter Xu <peterx@redhat.com>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
References: <20250915132211.135095-1-vsementsov@yandex-team.ru>
 <20250915132211.135095-5-vsementsov@yandex-team.ru>
 <aMg0l0xgq3hdiDnh@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aMg0l0xgq3hdiDnh@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 15.09.25 18:45, Peter Xu wrote:
> On Mon, Sep 15, 2025 at 04:22:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Add a pair to &error_warn helper, to reduce the pattern like
>>
>>      Error *local_err = NULL;
>>
>>      ...
>>
>>      if (!foo(..., &local_err)) {
>>          error_report_err(local_err);
>>          return false;
>>      }
>>
>> to simply
>>
>>      if (!foo(..., &error_reporter)) {
>>          return false;
>>      }
>>
>> Of course, for new interfaces, it's better to always support and handle
>> errp argument. But when have to rework the old ones, it's not always
>> feasible to convert everything to support/handle errp.
>>
>> The new helper is used in following commits.
> Could we add some explanation of why we need this if we already have
> error_warn?
> 
> I don't see much difference except error_warn will prepend it with
> "warning: ", but that doesn't sound like a real problem..

Yes, seems it's the only difference.

For me it seems strange to call it "warning", when we actually go to failure branch of the code logic.
Finally, we do have error_report() and warn_report(). Seems not a problem to have corresponding "magic" variables.

If have only one special error variable to simply report the error, I'd prefer it not have "warning: " prefix.
I.e. drop error_warn, and keep only error_reporter (or some better name?).



-- 
Best regards,
Vladimir

