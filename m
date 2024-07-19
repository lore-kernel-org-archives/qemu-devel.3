Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD392C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 16:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUq2d-0003pq-RL; Fri, 19 Jul 2024 12:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sUq2V-0003dk-Gh; Fri, 19 Jul 2024 12:01:02 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sUq2Q-0004z1-HA; Fri, 19 Jul 2024 12:00:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:2799:0:640:ddd6:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id DE0A062181;
 Fri, 19 Jul 2024 19:00:48 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b41a::1:8] (unknown
 [2a02:6b8:b081:b41a::1:8])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id l0NhOL08Z4Y0-wDTHCBZC; Fri, 19 Jul 2024 19:00:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1721404848;
 bh=N7uqus6oyIrotHvga7kgdYyusVknQndTf1tr8pco5pM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=SdppKNLL0POF9g596JRbzy21zNx/AmSf0X7KXo8tB3LjWEgcCJMMQllMyqRrAzmi1
 Zu6cdgIA9ycCQ4hzPftBewxzQAmtudptrn0nx4Lp9mamR6lnnWb7Pl1Gur7YZjRiUQ
 r49xS6ZnThUifZ+GplKIHnp5MIbh7I/tU6Gv6QAw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <8179f291-0423-48ef-bc30-1adce4e51bc8@yandex-team.ru>
Date: Fri, 19 Jul 2024 19:00:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/7] qapi: add blockdev-replace command
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com
References: <20240626115350.405778-1-vsementsov@yandex-team.ru>
 <20240626115350.405778-5-vsementsov@yandex-team.ru>
 <871q3qc3k9.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <871q3qc3k9.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 18.07.24 15:00, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Add a command that can replace bs in following BdrvChild structures:
>>
>>   - qdev blk root child
>>   - block-export blk root child
>>   - any child of BlockDriverState selected by child-name
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   blockdev.c             | 56 +++++++++++++++++++++++++++
>>   qapi/block-core.json   | 88 ++++++++++++++++++++++++++++++++++++++++++
>>   stubs/blk-by-qdev-id.c | 13 +++++++
>>   stubs/meson.build      |  1 +
>>   4 files changed, 158 insertions(+)
>>   create mode 100644 stubs/blk-by-qdev-id.c
>>
>> diff --git a/blockdev.c b/blockdev.c
>> index ba7e90b06e..2190467022 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -3559,6 +3559,62 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
>>       bdrv_try_change_aio_context(bs, new_context, NULL, errp);
>>   }
>>   
>> +void qmp_blockdev_replace(BlockdevReplace *repl, Error **errp)
>> +{
>> +    BdrvChild *child = NULL;
>> +    BlockDriverState *new_child_bs;
>> +
>> +    if (repl->parent_type == BLOCK_PARENT_TYPE_DRIVER) {
>> +        BlockDriverState *parent_bs;
>> +
>> +        parent_bs = bdrv_find_node(repl->u.driver.node_name);
>> +        if (!parent_bs) {
>> +            error_setg(errp, "Block driver node with node-name '%s' not "
>> +                       "found", repl->u.driver.node_name);
>> +            return;
>> +        }
>> +
>> +        child = bdrv_find_child(parent_bs, repl->u.driver.child);
>> +        if (!child) {
>> +            error_setg(errp, "Block driver node '%s' doesn't have child "
>> +                       "named '%s'", repl->u.driver.node_name,
>> +                       repl->u.driver.child);
>> +            return;
>> +        }
>> +    } else {
>> +        /* Other types are similar, they work through blk */
>> +        BlockBackend *blk;
>> +        bool is_qdev = repl->parent_type == BLOCK_PARENT_TYPE_QDEV;
>> +        const char *id =
>> +            is_qdev ? repl->u.qdev.qdev_id : repl->u.export.export_id;
>> +
>> +        assert(is_qdev || repl->parent_type == BLOCK_PARENT_TYPE_EXPORT);
>> +
>> +        blk = is_qdev ? blk_by_qdev_id(id, errp) : blk_by_export_id(id, errp);
> 
> blk_by_export_id() finds export @exp, and returns the associated block
> backend exp->blk.  Fine.
> 
> blk_by_qdev_id() finds the device, and then searches @block_backends for
> a blk with blk->dev == blk.  If a device has more than one block
> backend, you get the one first in @block_backends.  I figure that's the
> one created first.
> 
> Interface issue: when a device has multiple block backends, only one of
> them can be replaced, and which one is kind of random.
> 
> Do such devices exist?

Hmm.. I expect, they don't. If there is a problem, it's pre-existing, all callers of qmp_get_blk are affected. But honestly, I don't know.

> 
> If no, could they exist?
> 
> If yes, what should we do about it now?

Maybe, continue the loop in blk_by_dev() up the the end, and if two blk found for the device, return an error? Or even abort?

And add check to blk_attach_dev(), that we don't attach same device to several blks.

> 
>> +        if (!blk) {
>> +            return;
>> +        }
>> +
>> +        child = blk_root(blk);
>> +        if (!child) {
>> +            error_setg(errp, "%s '%s' is empty, nothing to replace",
>> +                       is_qdev ? "Device" : "Export", id);
>> +            return;
>> +        }
>> +    }
>> +
>> +    assert(child);
>> +    assert(child->bs);
>> +
>> +    new_child_bs = bdrv_find_node(repl->new_child);
>> +    if (!new_child_bs) {
>> +        error_setg(errp, "Node '%s' not found", repl->new_child);
>> +        return;
>> +    }
>> +
>> +    bdrv_replace_child_bs(child, new_child_bs, errp);
>> +}
>> +
>>   QemuOptsList qemu_common_drive_opts = {
>>       .name = "drive",
>>       .head = QTAILQ_HEAD_INITIALIZER(qemu_common_drive_opts.head),
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index df5e07debd..0a6f08a6e0 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -6148,3 +6148,91 @@
>>   ##
>>   { 'struct': 'DummyBlockCoreForceArrays',
>>     'data': { 'unused-block-graph-info': ['BlockGraphInfo'] } }
>> +
>> +##
>> +# @BlockParentType:
>> +#
>> +# @qdev: block device, such as created by device_add, and denoted by
>> +#     qdev-id
>> +#
>> +# @driver: block driver node, such as created by blockdev-add, and
>> +#     denoted by node-name
> 
> node-name and child?

Hmm. I'd say that parent is denoted only by node-name, as parent is node itself (the fact that we have separate BdrvChild structure as a parent I'd keep as internal realization). But parent may have several children, and concrete child is denoted by @child.

> 
>> +#
>> +# @export: block export, such created by block-export-add, and
>> +#     denoted by export-id
>> +#
>> +# Since 9.1
>> +##
> 
> I'm kind of unhappy with this doc comment.  I feel makes sense only in
> the context of its use.  Let me try to avoid that:
> 
>     # @driver: the parent is a block node, the child is one of its
>     #     children.
>     #
>     # @export: the parent is a block export, the child is its block
>     #     backend.
>     #
>     # @qdev: the parent is a device, the child is its block backend.

Sounds good to me and leaves no questions)

> 
>> +{ 'enum': 'BlockParentType',
>> +  'data': ['qdev', 'driver', 'export'] }
> 
> If you take my comment, change the order here as well.
> 
>> +
>> +##
>> +# @BdrvChildRefQdev:
>> +#
>> +# @qdev-id: the device's ID or QOM path
>> +#
>> +# Since 9.1
>> +##
>> +{ 'struct': 'BdrvChildRefQdev',
>> +  'data': { 'qdev-id': 'str' } }
>> +
>> +##
>> +# @BdrvChildRefExport:
>> +#
>> +# @export-id: block export identifier
> 
> block-export.json calls this "block export id" in some places, and
> "block export identifier" in others.  *Sigh*
> 
> Nothing to see here, move on!
> 
>> +#
>> +# Since 9.1
>> +##
>> +{ 'struct': 'BdrvChildRefExport',
>> +  'data': { 'export-id': 'str' } }
>> +
>> +##
>> +# @BdrvChildRefDriver:
>> +#
>> +# @node-name: the node name of the parent block node
>> +#
>> +# @child: name of the child to be replaced, like "file" or "backing"
>> +#
>> +# Since 9.1
>> +##
>> +{ 'struct': 'BdrvChildRefDriver',
>> +  'data': { 'node-name': 'str', 'child': 'str' } }
>> +
>> +##
>> +# @BlockdevReplace:
>> +#
>> +# @parent-type: type of the parent, which child is to be replaced
> 
> Suggest to scratch ", which child ..."
> 
>> +#
>> +# @new-child: new child for replacement
> 
> Suggest "the new child".
> 
>> +#
>> +# Since 9.1
>> +##
>> +{ 'union': 'BlockdevReplace',
>> +  'base': {
>> +      'parent-type': 'BlockParentType',
>> +      'new-child': 'str'
>> +  },
>> +  'discriminator': 'parent-type',
>> +  'data': {
>> +      'qdev': 'BdrvChildRefQdev',
>> +      'export': 'BdrvChildRefExport',
>> +      'driver': 'BdrvChildRefDriver'
>> +  } }
>> +
>> +##
>> +# @blockdev-replace:
>> +#
>> +# Replace a block-node associated with device (selected by
>> +# @qdev-id) or with block-export (selected by @export-id) or
>> +# any child of block-node (selected by @node-name and @child)
>> +# with @new-child block-node.
> 
> s/block-node/block node/ for consistency with existing usage.
> 
> Likewise, s/block-export/block export/.
> 
>> +#
>> +# Features:
>> +#
>> +# @unstable: This command is experimental.
>> +#
>> +# Since 9.1
>> +##
>> +{ 'command': 'blockdev-replace', 'boxed': true,
>> +  'features': [ 'unstable' ],
>> +  'data': 'BlockdevReplace' }
>> diff --git a/stubs/blk-by-qdev-id.c b/stubs/blk-by-qdev-id.c
>> new file mode 100644
>> index 0000000000..5ec9f755ee
>> --- /dev/null
>> +++ b/stubs/blk-by-qdev-id.c
>> @@ -0,0 +1,13 @@
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "sysemu/block-backend.h"
>> +
>> +BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
>> +{
>> +    /*
>> +     * We expect this when blockdev-change is called with parent-type=qdev,
>> +     * but qdev-monitor is not linked in. So no blk_ API is not available.
>> +     */
> 
> The last sentence is confusing.
> 
>> +    error_setg(errp, "Parameter 'parent-type' does not accept value 'qdev'");
> 
> I suggested this message.  I must have suffered from tunnel vision then.
> 
> The error message is good when the caller is qmp_blockdev_replace().
> Then parameter @parent-type exists, and parameter value "qdev" cannot
> work for any value of parameter "qdev-id" (which is @id here).
> 
> There are several more callers.  They don't use the stub now (or else
> they wouldn't link before this patch).  But future callers may well use
> it, and then the error message will likely be misleading.
> 
> v8 had
> 
>         error_setg(errp, "blk '%s' not found", id);
> 
> instead.  No good, because @id is not a "blk" (whatever that may be),
> it's a qdev ID.  You offered "devices are not supported".  Less than
> ideal, since it doesn't point to the argument that's causing the error,
> but I figure it's the best we can do without refactoring.  Maybe
> "can't select block backend by device ID".  Up to you.

"selecting block backend by device ID is not supported" may be?


> 
>> +    return NULL;
>> +}
>> diff --git a/stubs/meson.build b/stubs/meson.build
>> index 772a3e817d..068998c1a5 100644
>> --- a/stubs/meson.build
>> +++ b/stubs/meson.build
>> @@ -15,6 +15,7 @@ if have_block
>>     stub_ss.add(files('bdrv-next-monitor-owned.c'))
>>     stub_ss.add(files('blk-commit-all.c'))
>>     stub_ss.add(files('blk-exp-close-all.c'))
>> +  stub_ss.add(files('blk-by-qdev-id.c'))
>>     stub_ss.add(files('blockdev-close-all-bdrv-states.c'))
>>     stub_ss.add(files('change-state-handler.c'))
>>     stub_ss.add(files('get-vm-name.c'))
> 

-- 
Best regards,
Vladimir


