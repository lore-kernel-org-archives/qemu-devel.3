Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA165CCD19A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 08:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9g03-0007gt-Qz; Fri, 17 Oct 2025 04:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9g01-0007gi-DC
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 04:39:45 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9fzv-0003jF-D8
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 04:39:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id D0CB9807DA;
 Fri, 17 Oct 2025 11:39:30 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a93::1:3a] (unknown
 [2a02:6bf:8080:a93::1:3a])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id SdNNFg3FMKo0-GtM0bW8u; Fri, 17 Oct 2025 11:39:30 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760690370;
 bh=NX/smJzEpIrWBdLjWT4Ds3A82mgYntltH6W0IQhiLb0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=TCGYeLBfyzWxyt8x424Ud29E49pDGZ4V4gLrsmp4YrojcFa4T2XJ1S9eFrVhhYHm/
 n7L5R5i/6OBiKuUjMdTeVi/xJ+OAjhtDkOYCpwZp+Ky+6THJ20D/G7LOvVFRvOA159
 kSWknnWQYKL8mvIUoxnORenantbllG8UFpuIGnCw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <89547a23-4880-4192-87b9-249100546cbe@yandex-team.ru>
Date: Fri, 17 Oct 2025 11:39:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, farosas@suse.de, sw@weilnetz.de,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 qemu-devel@nongnu.org, michael.roth@amd.com, steven.sistare@oracle.com,
 leiyang@redhat.com, davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
References: <3b9f1da4-6264-45d4-ade1-a6273cc6fa1e@yandex-team.ru>
 <aO_--QWDJO7iOhR4@x1.local>
 <8c575b3a-7d1f-446d-8f6d-4b2e4b851731@yandex-team.ru>
 <aPCtkB-GvFNuqlHn@redhat.com>
 <29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru>
 <aPE8Oo5D3oesB7sV@x1.local> <aPE-vmyg1mLDO4pf@redhat.com>
 <aPFHl3VWV0pCmzd1@x1.local> <aPFOHjl5BoWEMqSL@redhat.com>
 <aPFVWi1pwxS8yGay@x1.local> <aPH557l6YnXT-3r8@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aPH557l6YnXT-3r8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17.10.25 11:10, Daniel P. Berrangé wrote:
>> If we go with a list of devices in the migration parameters, to me it'll
>> only be a way to workaround the missing of such capability of net backends.
>> Meanwhile, the admin will need to manage the list of devices even if the
>> admin doesn't really needed to, IMHO.
> We shouldn't need to list devices in every scenario. We need to focus on
> the internal API design. We need to have suitable APIs exposed by backends
> to allow us to query migratability and process vmstate a mere property
> 'backend-transfer' is insufficient, whether set by QEMU code, or set by
> the mgmt app.


I now imagine the following:

I already need an additional .pre_incoming migration handler for the feature,
see patch

  [PATCH v8 14/19] migration: introduce .pre_incoming() vmsd handler
.

I can add a boolean backend_transfer parameter to that handler, so that it
informs the device, that it should get the backend state from the migration
stream. And that's a good point to fail, if device doesn't support backend
transfer in current configuration.

If so, it seems logical to add symmetrical .pre_outgoing() vmsd handler,
with same backend_transfer parameter, to inform source devices (or get errors
from them).


Or, otherwise, make a separate VMSD handler .supports_backend_transfer(),
which should be called at start of incoming and outgoing migrations to
check the specified list of IDs, as well as we can also call it on
migrate-set-parameters, to get an earlier failure. And keep the devices
to call some migrate_backend_transfer(dev), to understand, should they
do backend-transfer or not (like in a diff, which I've sent yesterday
in this thread).


-- 
Best regards,
Vladimir

