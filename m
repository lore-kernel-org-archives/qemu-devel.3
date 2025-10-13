Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63965CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 07:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8CbW-0003JV-DC; Mon, 13 Oct 2025 03:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8CbT-0003Il-4M
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 03:04:19 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8CbO-0002cn-AR
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 03:04:18 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 8F06BC02DE;
 Mon, 13 Oct 2025 10:04:01 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a50::1:2a] (unknown
 [2a02:6bf:8080:a50::1:2a])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 04IE362FLiE0-A6RhBwbV; Mon, 13 Oct 2025 10:04:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760339041;
 bh=HpPKYO5wB4E39U7vq7Bb3wIFV9l5T5jYFJgbxv08H3c=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Sq3xvJdZyPKbBuLuCF5zBzfvlXjZ1VNBKqxJENFZ2F7bEmdAgNr9TOX4bYo+ZJSkv
 DWu1N0l6uwljnmkWsbDNsMwSFWVPM/14DoxtL7KNBDqavOgrRU9MkL6a7QsTvY6s0u
 wGflEONqg5vn1Qtgk4TYD5xh4uGzuegEb1D2t1vM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a6d054c9-6e1e-4ef2-ad63-9fedfdae1181@yandex-team.ru>
Date: Mon, 13 Oct 2025 10:04:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] qapi: docs: width=70 and two spaces between
 sentences
To: Thomas Huth <thuth@redhat.com>, armbru@redhat.com
Cc: qemu-devel@nongnu.org, eblake@redhat.com
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
 <2e4da035-4996-4d1e-b3e1-9285a9c880e3@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <2e4da035-4996-4d1e-b3e1-9285a9c880e3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 13.10.25 09:11, Thomas Huth wrote:
> On 11/10/2025 15.56, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> Let's bring the documentation in line with the requirements. And
>> do check these requirements in QAPI parser, to avoid later
>> further violations.
>>
>> Vladimir Sementsov-Ogievskiy (33):
>>    qapi: Add documentation format validation
>>    qapi/acpi.json: docs: width=70 and two spaces between sentences
>>    qapi/audio.json: docs: width=70 and two spaces between sentences
>>    qapi/block-core.json: docs: width=70 and two spaces between sentences
>>    qapi/block-export.json: docs: width=70 and two spaces between
>>      sentences
>>    qapi/block.json: docs: width=70 and two spaces between sentences
>>    qapi/char.json: docs: width=70 and two spaces between sentences
>>    qapi/crypto.json: docs: width=70 and two spaces between sentences
>>    qapi/dump.json: docs: width=70 and two spaces between sentences
>>    qapi/introspect.json: docs: width=70 and two spaces between sentences
>>    qapi/job.json: docs: width=70 and two spaces between sentences
>>    qapi/machine-s390x.json: docs: width=70 and two spaces between
>>      sentences
>>    qapi/machine.json: docs: width=70 and two spaces between sentences
>>    qapi/migration.json: docs: width=70 and two spaces between sentences
>>    qapi/misc-arm.json: docs: width=70 and two spaces between sentences
>>    qapi/misc-i386.json: docs: width=70 and two spaces between sentences
>>    qapi/misc.json: docs: width=70 and two spaces between sentences
>>    qapi/net.json: docs: width=70 and two spaces between sentences
>>    qapi/qdev.json: docs: width=70 and two spaces between sentences
>>    qapi/qom.json: docs: width=70 and two spaces between sentences
>>    qapi/replay.json: docs: width=70 and two spaces between sentences
>>    qapi/rocker.json: docs: width=70 and two spaces between sentences
>>    qapi/run-state.json: docs: width=70 and two spaces between sentences
>>    qapi/sockets.json: docs: width=70 and two spaces between sentences
>>    qapi/stats.json: docs: width=70 and two spaces between sentences
>>    qapi/tpm.json: docs: width=70 and two spaces between sentences
>>    qapi/trace.json: docs: width=70 and two spaces between sentences
>>    qapi/transaction.json: docs: width=70 and two spaces between sentences
>>    qapi/ui.json: docs: width=70 and two spaces between sentences
>>    qapi/vfio.json: docs: width=70 and two spaces between sentences
>>    qapi/virtio.json: docs: width=70 and two spaces between sentences
>>    qga/qapi-schema.json: docs: width=70 and two spaces between sentences
>>    qapi/acpi-hest.json: docs: width=70 and two spaces between sentences
> 
> Oh my, that's a lot of code churn for very few gain. Why do we have a different standard (70 columns) for qapi docs than for the rest of the code (80 columns)? That's confusing and will always cause mistakes in the future, I guess...
> 

Note, I've sent "[PATCH v2 00/33] qapi: docs: width=70 and two spaces between sentences", with not doubled patches (again, sorry for that :/.

That since 9d167491cb2577d "docs/devel/qapi-code-gen: Update doc comment conventions" (2023), by Markus, written in
qapi-code-gen.rst:

     For legibility, wrap text paragraphs so every line is at most 70
     characters long.

     Separate sentences with two spaces.

And I always forget it, when preparing my patches. Checking these rules during review, and than fixing is rather boring,
so, I decided to try fix them all. Assised by AI, of course... Or, maybe AI assisted by me.

If we decide, that it is too huge, we can proceed with some list of exclusions, to cover existing violations and avoid new ones.


-- 
Best regards,
Vladimir

