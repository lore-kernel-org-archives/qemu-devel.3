Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE381062884
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IbE-0004NE-9U; Wed, 11 Mar 2026 08:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w0Ib7-0004N2-UI; Wed, 11 Mar 2026 08:23:34 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w0Ib4-0001Z0-JM; Wed, 11 Mar 2026 08:23:33 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id ACF0AC01EC;
 Wed, 11 Mar 2026 15:23:25 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:d28::1:5])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ONFZe30AgW20-WMEZntLP; Wed, 11 Mar 2026 15:23:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1773231805;
 bh=Wnz2UuNiumDUica7DAmbDu3dZ8T+Si/TMYchefJNgv0=;
 h=In-Reply-To:Subject:Cc:Message-Id:Date:References:To:From;
 b=EkvA/zSFD91QZb2A3Mcu7WLP1INSVIxXn6DEUZQwNnWjvsfiSHY7c6hjYJ9UVI39r
 XU4s/Xph+XpPmWjUCiRyf5u1L1W9Mp81vNC1S4AFny/9skQeTMLTYJn4bxISd8iGW0
 uwv239zQz3ZLiwynF4z5Ba2CrUK0Z7jWbj86kqJg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 17:23:23 +0500
Message-Id: <DGZY7OWVZUVM.3EXO0OXP0OCGO@yandex-team.com>
To: "Peter Maydell" <peter.maydell@linaro.org>, "Sergei Heifetz"
 <heifetz@yandex-team.com>
Cc: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: Re: [PATCH v3 3/4] system/physmem.c: remove useless assertion of block
From: "Sergei Heifetz" <heifetz@yandex-team.com>
X-Mailer: aerc 0.21.0-119-g0a449d4a7ff3
References: <20260208103958.121455-1-heifetz@yandex-team.com>
 <20260208103958.121455-4-heifetz@yandex-team.com>
 <CAFEAcA92MKa1Q1xwamjsFja=-V5ag-JH4kM8xTFiu07RDCBbTQ@mail.gmail.com>
In-Reply-To: <CAFEAcA92MKa1Q1xwamjsFja=-V5ag-JH4kM8xTFiu07RDCBbTQ@mail.gmail.com>
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1a.mail.yandex.net
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

On Wed Mar 11, 2026 at 3:51 PM +05, Peter Maydell wrote:
> On Sun, 8 Feb 2026 at 10:41, Sergei Heifetz <heifetz@yandex-team.com> wro=
te:
>>
>> It is useless to assert that block is not NULL because
>> it is already dereferenced in the first line of the function.
>>
>> We could split the declaration and initialization of oldsize,
>> but then we would need to remove the const qualifier.
>> This seems worse, as the assertion would be almost useless anyway.
>>
>> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
>
> The commit message fails to note the information found during
> review of the previous version:
>  * this function is called from only two places
>  * those places already either assert or assume that the
>    block argument is not NULL
> So the assertion is not getting us anything.
>
> With the commit message updated:
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> thanks
> -- PMM

Sorry, I should've included this information in the commit
message in the first place. I'll update it and resubmit
the series. Thank you.

