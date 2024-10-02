Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A29CF6D2C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 14:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw0Xu-0000b7-05; Wed, 02 Oct 2024 10:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw0Xr-0000am-R4; Wed, 02 Oct 2024 10:41:39 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw0Xl-0000nV-T4; Wed, 02 Oct 2024 10:41:38 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:1301:0:640:a2b5:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C6C1960D0B;
 Wed,  2 Oct 2024 17:41:25 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8026::1:2f] (unknown
 [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Ofc49m1IduQ0-X6K2iRg7; Wed, 02 Oct 2024 17:41:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727880085;
 bh=XC3crJxlRJjb/4x5Gb5JGWDx9Iy3ysTnlWNlw7GG5uo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=GgicBUg5rG+7h0WrnyWuaOx4+aTnj+zD12j6CGITqc5gaqEmxw2ossWIy6rIiPms7
 iAA4WobNr/DBblE+CG2TxQqIBw/vBwmKaAh31Efxv6f0pSs0GixZnDuazEyFRB0ROy
 l6Ymw/2xaoYjZr6Bs4Xnq8QOV13xJT7wtu1qNw5I=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <992e1551-6d75-441f-af6e-5df9e6c85c31@yandex-team.ru>
Date: Wed, 2 Oct 2024 17:41:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/7] qapi: add blockdev-replace command
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com
References: <20240626115350.405778-1-vsementsov@yandex-team.ru>
 <20240626115350.405778-5-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240626115350.405778-5-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 26.06.24 14:53, Vladimir Sementsov-Ogievskiy wrote:
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index df5e07debd..0a6f08a6e0 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -6148,3 +6148,91 @@
>   ##
>   { 'struct': 'DummyBlockCoreForceArrays',
>     'data': { 'unused-block-graph-info': ['BlockGraphInfo'] } }
> +
> +##
> +# @BlockParentType:
> +#
> +# @qdev: block device, such as created by device_add, and denoted by
> +#     qdev-id
> +#
> +# @driver: block driver node, such as created by blockdev-add, and
> +#     denoted by node-name
> +#
> +# @export: block export, such created by block-export-add, and
> +#     denoted by export-id
> +#
> +# Since 9.1
> +##
> +{ 'enum': 'BlockParentType',
> +  'data': ['qdev', 'driver', 'export'] }
> +
> +##
> +# @BdrvChildRefQdev:
> +#
> +# @qdev-id: the device's ID or QOM path
> +#
> +# Since 9.1
> +##
> +{ 'struct': 'BdrvChildRefQdev',
> +  'data': { 'qdev-id': 'str' } }
> +
> +##
> +# @BdrvChildRefExport:
> +#
> +# @export-id: block export identifier
> +#
> +# Since 9.1
> +##
> +{ 'struct': 'BdrvChildRefExport',
> +  'data': { 'export-id': 'str' } }
> +
> +##
> +# @BdrvChildRefDriver:
> +#
> +# @node-name: the node name of the parent block node
> +#
> +# @child: name of the child to be replaced, like "file" or "backing"
> +#
> +# Since 9.1
> +##
> +{ 'struct': 'BdrvChildRefDriver',
> +  'data': { 'node-name': 'str', 'child': 'str' } }
> +
> +##
> +# @BlockdevReplace:
> +#
> +# @parent-type: type of the parent, which child is to be replaced
> +#
> +# @new-child: new child for replacement
> +#
> +# Since 9.1
> +##
> +{ 'union': 'BlockdevReplace',
> +  'base': {
> +      'parent-type': 'BlockParentType',
> +      'new-child': 'str'
> +  },
> +  'discriminator': 'parent-type',
> +  'data': {
> +      'qdev': 'BdrvChildRefQdev',
> +      'export': 'BdrvChildRefExport',
> +      'driver': 'BdrvChildRefDriver'
> +  } }
> +
> +##
> +# @blockdev-replace:
> +#
> +# Replace a block-node associated with device (selected by
> +# @qdev-id) or with block-export (selected by @export-id) or
> +# any child of block-node (selected by @node-name and @child)
> +# with @new-child block-node.
> +#
> +# Features:
> +#
> +# @unstable: This command is experimental.
> +#
> +# Since 9.1
> +##
> +{ 'command': 'blockdev-replace', 'boxed': true,
> +  'features': [ 'unstable' ],
> +  'data': 'BlockdevReplace' }


Looking back at this all, I now have another idea: instead of trying to unite different types of parents, maybe just publish concept of BdrvChild to QAPI? So that it will have unique id. Like for block-nodes, it could be auto-generated or specified by user.

Then we'll add parameters for commands:

device-add
    root-child-slot-id: ID

block-export-add
    block-child-slot-id: ID

and for block-drivers we already have BlockdevRef structure, it only lacks an id.

{ 'alternate': 'BlockdevRef',
   'data': { 'definition': 'BlockdevOptions',
             'reference': 'str' } }

hmm.. Could it be as simple as


{ 'alternate': 'BlockdevRef',
   'base': { '*child-slot-id': 'str' },
   'data': { 'definition': 'BlockdevOptions',
             'reference': 'str' } }

?

Unfortunately, no: "../qapi/block-core.json:4781: alternate has unknown key 'base'"

Anyway, I believe, some solution should exist, probably by improving QAPI generator. Or, add "child-slot-id" to base of BlockdevOptions, and add virtual "reference" BlockdevDriver, to handle case with reference.


----

And finally, the new command becomes as simple as:

{ 'command': 'blockdev-replace',
   'data': {'child-slot': 'str', 'new-child': 'str' } }

-- 
Best regards,
Vladimir


