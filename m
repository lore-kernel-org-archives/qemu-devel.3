Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018C7CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 11:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWN3-0000up-N1; Tue, 29 Sep 2026 07:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1xBWN1-0000u0-Fc
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 07:51:39 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1xBWMz-00085h-AG
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 07:51:39 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:1224:0:640:741a:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 84A3680A55;
 Tue, 29 Sep 2026 14:51:32 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d49::1:34] (unknown
 [2a02:6bf:8080:d49::1:34])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id UpgjOfGXU0U0-Dkt4NiL6; Tue, 29 Sep 2026 14:51:32 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1790682692;
 bh=r1ojmZkxKYtbylkAR9KTKCcR+iipLNfqd82VLTzhOYU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=LiPVQl/tmAj/yFXJqbDuV4RQ3ibuuxuBwL5Cx2swsOu/yur3Da2xi9F2KByMfMdIk
 bGdLl5Mul/xKlcxLantwGtvoH4FXlNr5kVSXWn1GYiLQVKnqBVWTd+u/QrwV4zkCQj
 ebEQh6Gug++T+ScM9HbOHcShpLmASTHCjhjrmJHE=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3cc370e8-a7f8-4285-b2b8-8e2bcef3e17d@yandex-team.ru>
Date: Tue, 29 Sep 2026 16:51:30 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-user: add missing stub for
 vhost_user_has_protocol_feature()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260929101623.1352299-1-dtalexundeer@yandex-team.ru>
 <aruTFz6mgOJpcQAi@sgarzare-redhat>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <aruTFz6mgOJpcQAi@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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


On 9/29/26 15:54, Stefano Garzarella wrote:
> On Tue, Sep 29, 2026 at 03:16:23PM +0500, Alexandr Moshkov wrote:
>> Currently, building with --disable-vhost-user fails to link when other
>> vhost backends are enabled: vhost.c calls 
>> vhost_user_has_protocol_feature(),
>> but its implementation is not built.
>>
>> Add a stub returning false to fix the link error.
>>
>
> Should we add Clément's tag?
>
> Reported-by: Clément Chigot <chigot@adacore.com>
>
>
> Fixes tag?
>
> Fixes: 5eb2347867 ("vhost-user: add skip_drain param to 
> do_vhost_virtqueue_stop")
>
>
> Is this one, right? 

Thanks for reply! Yes, you right. Sorry, I forget about this tags..

>
> Looking better at that commit, can we avoid to call 
> vhost_user_has_protocol_feature() at all in do_vhost_virtqueue_stop() 
> and put an assert in vhost_user_get_vring_base_skip_drain() to check 
> that the feature is negotiated?
>
> That said, not sure if it should be an assert TBH.
>
> Thanks,
> Stefano 

Thanks, I'll see what I can do.

>
>
>> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>> ---
>> hw/virtio/vhost-user-stub.c | 5 +++++
>> 1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/virtio/vhost-user-stub.c b/hw/virtio/vhost-user-stub.c
>> index 45559788dd..9d2e521788 100644
>> --- a/hw/virtio/vhost-user-stub.c
>> +++ b/hw/virtio/vhost-user-stub.c
>> @@ -4,3 +4,8 @@
>> void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
>> {
>> }
>> +
>> +bool vhost_user_has_protocol_feature(struct vhost_dev *dev, uint64_t 
>> feature)
>> +{
>> +    return false;
>> +}
>> -- 
>> 2.34.1
>>
>

