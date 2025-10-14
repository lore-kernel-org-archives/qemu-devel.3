Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B3FCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gFH-00087I-NX; Tue, 14 Oct 2025 10:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8gFG-00086B-29
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:43:22 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8gFC-0001WX-8D
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:43:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 163BE80867;
 Tue, 14 Oct 2025 17:43:11 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a8a::1:35] (unknown
 [2a02:6bf:8080:a8a::1:35])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 9hQtEl2FbiE0-QRxXGi3F; Tue, 14 Oct 2025 17:43:10 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760452990;
 bh=WzxQZrynPC932qLoAnTUeiu6ZgUJq7V4LTnnzwbnCIU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=rQyoZVmM6O5m/XppeFVdjO9859ivGmmySr60F75xB0zSEI7mJuIBeQaXhhmSqpMjB
 5xrwBsUhBNO9ijna6/TYaGxmUoV3jkEG4BwIUyBHfTHBGigfGs1L8BFSzq2setPazW
 ojEzmaKuWhRnONCpwp8enlQsmPYAJCpnphSrJgv4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c541a8e4-15b4-415e-9a57-0fc4ba75e623@yandex-team.ru>
Date: Tue, 14 Oct 2025 17:43:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] chardev: postpone connect
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20251013133836.852018-1-vsementsov@yandex-team.ru>
 <aO5Sv8i4rxLFi-XF@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aO5Sv8i4rxLFi-XF@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 14.10.25 16:40, Daniel P. Berrangé wrote:
> On Mon, Oct 13, 2025 at 04:38:29PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> That's a preparation for backend-transfer migration of
>> vhost-user-blk. For such migration we are going to transfer
>> vhost-user-blk fds, including backend chardev fd to the target
>> in migration stream (backed by UNIX domain socket).
>>
>> So, on the target, we want to know, should we call connect(),
>> or is it a backend-transfer migration, and we should wait for
>> incoming fd.
>>
>> But at initialization time we can't know it: user may setup
>> migration parameters (enabling backend-transfer) later.
>>
>> So, let's postpone chardev open/connect phase up to attaching
>> to frontend. At this point we can check:
>>
>> - if it's vhost-user-blk, do nothing, let vhost-user-blk decide
>>    when to do connect()
>> - otherwise, do connect() at this point
> 
> I'm finding it quite unpleasant that we've created a new set of
> callbacks just for the socket backend, and not the other chardev
> backends.
> 
> Conceptually it feels like the problem of transferring in pre-
> opened FDs from a previous QEMU should be conceptually relevant
> to all the backend types. If it is, then I very much want us to
> convert all the backends instead of leaving a pile of technical
> debt for someone else in the future.

Agree. If the design is approved, I'll try to update all other
chardevs as well.

> 
> This series also doesn't illustrate usage of the new model with
> pre-opened FDs, so I'm finding it hard to validate whether
> this design is effective or not.
> 

Understand, of course.

[PATCH v2 00/?] vhost-user-blk: live-backend local migration

is coming soon, so the whole picture will be seen.

Still, I'll first resend this one (chardev: postpone connect) and

[PATCH v2 00/23] vhost refactoring and fixes

to base future v2 vhost-user-blk: live-backend local migration
on clear base.

-- 
Best regards,
Vladimir

