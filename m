Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CDCCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnDZ-0007Zf-Iv; Mon, 20 Oct 2025 06:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vAnDT-0007Xd-GA
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:34:15 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vAnDP-0008K4-Mk
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:34:15 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9297:0:640:61e7:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 49E9CC00BB;
 Mon, 20 Oct 2025 13:34:05 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:eb76:dac8:b48b:fd00] (unknown
 [2a02:6bf:803e:400:eb76:dac8:b48b:fd00])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 3YSXxj3FsGk0-RK1sLN1B; Mon, 20 Oct 2025 13:34:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760956444;
 bh=SMrJ6wYxQfAE70KT3RkbL9RPqJAm+EkNMcwbnPXH3pg=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=d2h0QmMt+mBZMQGjgok3GMlV2+d8ITVXGU2Sp4yT5/bsFqZ2Sebqlyv+04TtOLAqa
 t0UxWNXDD2R75JrQ6oWZXWqK+oOfHHUovKnrqe4O7PrkLJkghRNCHw3296l+y0UKMV
 d9czYUMwp5/qI7nVHIsb6bL95oMxWkwf/WAzkAfI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------YMFm8ACjvBmHxJyTvO8fGzWl"
Message-ID: <d6cf9c5e-52da-49b8-ba39-2909a00f28eb@yandex-team.ru>
Date: Mon, 20 Oct 2025 15:34:03 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vhost-user-blk: support inflight migration
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>
References: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
 <20251020054413.2614932-3-dtalexundeer@yandex-team.ru>
 <878qh599tc.fsf@pond.sub.org>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <878qh599tc.fsf@pond.sub.org>
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This is a multi-part message in MIME format.
--------------YMFm8ACjvBmHxJyTvO8fGzWl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for review!

On 10/20/25 14:55, Markus Armbruster wrote:
> Alexandr Moshkov<dtalexundeer@yandex-team.ru> writes:
>
>> In vhost_user_blk_stop() on incoming migration make force_stop = true,
>> so GET_VRING_BASE will not be executed.
>>
>> Signed-off-by: Alexandr Moshkov<dtalexundeer@yandex-team.ru>
> Your cover letter explains why this is useful.  Please work it into your
> commit message.

Ok

> [...]
>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index be0f3fcc12..c9fea59515 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -517,9 +517,13 @@
>>   #     each RAM page.  Requires a migration URI that supports seeking,
>>   #     such as a file.  (since 9.0)
>>   #
>> +# @inflight-vhost-user-blk: If enabled, QEMU will migrate inflight
>> +#    region for vhost-user-blk.  (since 10.2)
>> +#
> Any guidance why and when users would want to enable it?
>
> Is it a good idea to have device-specific capabilities?

Hmm, maybe it's better way to make a parameter for the vhost-user-blk 
instead of migration capability?

What do you think?

>>   # Features:
>>   #
>> -# @unstable: Members @x-colo and @x-ignore-shared are experimental.
>> +# @unstable: Members @x-colo and @x-ignore-shared,
>> +#     @inflight-vhost-user-blk are experimental.
> "and" is misplaced now.  Fix:
>
>     # @unstable: Members @x-colo, @x-ignore-shared, and
>     #     @inflight-vhost-user-blk are experimental.
>
> Use the opportunity and insert a blank line here.
>
>>   # @deprecated: Member @zero-blocks is deprecated as being part of
>>   #     block migration which was already removed.
>>   #
>> @@ -536,7 +540,8 @@
>>              { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>>              'validate-uuid', 'background-snapshot',
>>              'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
>> -           'dirty-limit', 'mapped-ram'] }
>> +           'dirty-limit', 'mapped-ram',
>> +           { 'name': 'inflight-vhost-user-blk', 'features': [ 'unstable' ] } ] }
> Long line.  Obvious line break:
>
>                { 'name': 'inflight-vhost-user-blk',
>                  'features': [ 'unstable' ] } ] }
>
>>   
>>   ##
>>   # @MigrationCapabilityStatus:
Wiil be fixed, thank!

--------------YMFm8ACjvBmHxJyTvO8fGzWl
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Thanks for review!<br>
    </p>
    <div class="moz-cite-prefix">On 10/20/25 14:55, Markus Armbruster
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:878qh599tc.fsf@pond.sub.org">
      <pre wrap="" class="moz-quote-pre">Alexandr Moshkov <a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">In vhost_user_blk_stop() on incoming migration make force_stop = true,
so GET_VRING_BASE will not be executed.

Signed-off-by: Alexandr Moshkov <a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a>
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Your cover letter explains why this is useful.  Please work it into your
commit message.</pre>
    </blockquote>
    <p>Ok<span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:878qh599tc.fsf@pond.sub.org">
      <pre wrap="" class="moz-quote-pre">[...]

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">diff --git a/qapi/migration.json b/qapi/migration.json
index be0f3fcc12..c9fea59515 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -517,9 +517,13 @@
 #     each RAM page.  Requires a migration URI that supports seeking,
 #     such as a file.  (since 9.0)
 #
+# @inflight-vhost-user-blk: If enabled, QEMU will migrate inflight
+#    region for vhost-user-blk.  (since 10.2)
+#
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Any guidance why and when users would want to enable it?

Is it a good idea to have device-specific capabilities?
</pre>
    </blockquote>
    <p>Hmm, <span style="white-space: pre-wrap;">maybe it's better way to make a parameter for the vhost-user-blk instead of migration capability?</span></p>
    <p><span style="white-space: pre-wrap;">What do you think?
</span></p>
    <blockquote type="cite" cite="mid:878qh599tc.fsf@pond.sub.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> # Features:
 #
-# @unstable: Members @x-colo and @x-ignore-shared are experimental.
+# @unstable: Members @x-colo and @x-ignore-shared,
+#     @inflight-vhost-user-blk are experimental.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
"and" is misplaced now.  Fix:

   # @unstable: Members @x-colo, @x-ignore-shared, and
   #     @inflight-vhost-user-blk are experimental.

Use the opportunity and insert a blank line here.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> # @deprecated: Member @zero-blocks is deprecated as being part of
 #     block migration which was already removed.
 #
@@ -536,7 +540,8 @@
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
-           'dirty-limit', 'mapped-ram'] }
+           'dirty-limit', 'mapped-ram',
+           { 'name': 'inflight-vhost-user-blk', 'features': [ 'unstable' ] } ] }
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Long line.  Obvious line break:

              { 'name': 'inflight-vhost-user-blk',
                'features': [ 'unstable' ] } ] }

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 
 ##
 # @MigrationCapabilityStatus:
</pre>
      </blockquote>
    </blockquote>
    Wiil be fixed, thank!<br>
    <br>
  </body>
</html>

--------------YMFm8ACjvBmHxJyTvO8fGzWl--

