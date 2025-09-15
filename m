Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BB9CAC598
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 18:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyE80-00011g-A2; Mon, 15 Sep 2025 14:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyE7t-00011B-51; Mon, 15 Sep 2025 14:40:33 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyE7j-0003ZR-0n; Mon, 15 Sep 2025 14:40:32 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id B9D018076D;
 Mon, 15 Sep 2025 21:40:07 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:184::1:6] (unknown [2a02:6bf:8080:184::1:6])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6eUttK2GoKo0-zMAojpDq; Mon, 15 Sep 2025 21:40:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757961607;
 bh=3PZ0juCSWOTMh0/tUC4WrNfrN9ovDX22lKa/fLXn6qI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=XxTC1TF8d1YzifHn8uRzASHRFW4Pyniyg68z3jje55+4alEPX6I+489AxW/VS6Mbd
 sOlqFG6eGjF1TAv9zZH4+PXO5t2eZdhnYVN480aMBPy9sT6BOp6EcQMsdE7vylzzU+
 +810i3qXeW6yC2oVtd2EF9flj8DNGWf2rUM5+Yuw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4fbdaecc-8ee5-4f59-857e-d0b302503f51@yandex-team.ru>
Date: Mon, 15 Sep 2025 21:40:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/13] util/error: add &error_reporter
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, leiyang@redhat.com, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
References: <20250915132211.135095-1-vsementsov@yandex-team.ru>
 <20250915132211.135095-5-vsementsov@yandex-team.ru>
 <aMg0l0xgq3hdiDnh@x1.local>
 <c1907e57-d279-40fa-b181-3b54441c49d7@yandex-team.ru>
 <aMhbFcvItNMBtQhN@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aMhbFcvItNMBtQhN@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15.09.25 21:29, Daniel P. Berrangé wrote:
> On Mon, Sep 15, 2025 at 09:14:18PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 15.09.25 18:45, Peter Xu wrote:
>>> On Mon, Sep 15, 2025 at 04:22:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> Add a pair to &error_warn helper, to reduce the pattern like
>>>>
>>>>       Error *local_err = NULL;
>>>>
>>>>       ...
>>>>
>>>>       if (!foo(..., &local_err)) {
>>>>           error_report_err(local_err);
>>>>           return false;
>>>>       }
>>>>
>>>> to simply
>>>>
>>>>       if (!foo(..., &error_reporter)) {
>>>>           return false;
>>>>       }
>>>>
>>>> Of course, for new interfaces, it's better to always support and handle
>>>> errp argument. But when have to rework the old ones, it's not always
>>>> feasible to convert everything to support/handle errp.
>>>>
>>>> The new helper is used in following commits.
>>> Could we add some explanation of why we need this if we already have
>>> error_warn?
>>>
>>> I don't see much difference except error_warn will prepend it with
>>> "warning: ", but that doesn't sound like a real problem..
>>
>> Yes, seems it's the only difference.
>>
>> For me it seems strange to call it "warning", when we actually go to failure branch of the code logic.
>> Finally, we do have error_report() and warn_report(). Seems not a problem to have corresponding "magic" variables.
>>
>> If have only one special error variable to simply report the error, I'd prefer it not have "warning: " prefix.
>> I.e. drop error_warn, and keep only error_reporter (or some better name?).
> 
> FWIW, this whole debate is liable to be a bit of a can of worms that
> will delay your series from getting merged.

Honest

> 
> Can I suggest you repost this without &error_reporter usage, and then
> have a separate standalone series that proposes error_report, and
> converts a handful of files to demonstrate its usage.
> 

Agree.


-- 
Best regards,
Vladimir

