Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1F7CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf2w-00018p-Ua; Mon, 08 Sep 2025 12:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvf2u-00018N-Iy
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:48:48 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvf2l-0000kk-DQ
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:48:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 6184EC0148;
 Mon, 08 Sep 2025 19:48:34 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b64::1:1] (unknown [2a02:6bf:8080:b64::1:1])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Wmon275GnmI0-AjB3goHo; Mon, 08 Sep 2025 19:48:33 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757350113;
 bh=V/+yCocOQ+eUXm5DVD36zv0yCpVtMtUgdQCNrP0l2pE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=hxZwO3Ru+03pBzaSIQjlrMYdL2rxoLGtYCOc+ER9B3PY/ijoJt74h6HLq+t7LF/gJ
 jvjDMYVHB4ZfbflrRyL8v2DO0bof6TEc6SMMRYI+m9KYiGApivywPWRNU3AN1RvxOu
 iqxXQjfgnB1Ve3yCqFu42SGRmIIQO3c5wnzr8/BQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <81a31fa8-a3ec-43d5-abbc-93d1716d37dd@yandex-team.ru>
Date: Mon, 8 Sep 2025 19:48:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] virtio-net: support local tap migration
To: Peter Xu <peterx@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, mst@redhat.com,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 philmd@linaro.org, berrange@redhat.com
References: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
 <20250905135039.2202924-7-vsementsov@yandex-team.ru>
 <aL75seOzauBDqk5j@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aL75seOzauBDqk5j@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 08.09.25 18:43, Peter Xu wrote:
> On Fri, Sep 05, 2025 at 04:50:36PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> @@ -3525,6 +3609,15 @@ static const VMStateDescription vmstate_virtio_net_device = {
>>            * but based on the uint.
>>            */
>>           VMSTATE_BUFFER_POINTER_UNSAFE(vlans, VirtIONet, 0, MAX_VLAN >> 3),
>> +        {
>> +            .name = "tap",
>> +            .info = &(const VMStateInfo) {
>> +                .name = "virtio-net vhost-user backend state",
> 
> Just randomly spot this line; likely we need s/vhost-user/tap/..
> 

Of-course

> But of course it'll be much better if this can be a subsection, as
> commented previous..
> 

Will do.

>> +                .get = virtio_net_tap_load,
>> +                .put = virtio_net_tap_save,
>> +            },
>> +            .field_exists = virtio_net_is_tap_local,
>> +        },
> 


-- 
Best regards,
Vladimir

