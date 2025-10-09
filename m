Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8684CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6wVq-0004y5-Qa; Thu, 09 Oct 2025 15:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v6wVm-0004w3-Tl; Thu, 09 Oct 2025 15:41:15 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v6wVh-0002pu-AL; Thu, 09 Oct 2025 15:41:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 1EF2B80880;
 Thu, 09 Oct 2025 22:41:01 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:162::1:3a] (unknown
 [2a02:6bf:8080:162::1:3a])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id xeQCW81FHiE0-PKWaTcgd; Thu, 09 Oct 2025 22:41:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760038860;
 bh=NS/2jIAq0ooWt5/38OaH35MEeg/o3+vvINK0je5y9xk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=QI98M7929vGCGDJY01IeAHWG1jY3RbYY9oQDeqYQkD/ht+5gjSENmPC77Q1BvMqcn
 2kxAcy4HC0kcXU9+N/F6QD/PvYgrR2IkPmgDO+gHW20TrKou7mFIdTIvhqKVKYifHe
 Gp+9w3kl6uP0UCVb8S/Q1E6OjIJblrkpXOWWXEr8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <05a27d8b-af59-4eb9-9f61-48324c92c869@yandex-team.ru>
Date: Thu, 9 Oct 2025 22:40:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/33] vhost: make vhost_dev.features private
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael@enfabrica.net, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-7-vsementsov@yandex-team.ru>
 <CAFubqFtQNGxbiuC+r8g=28tvC=qz5c+1HfqT-jAG6T8xM_Wv9A@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFubqFtQNGxbiuC+r8g=28tvC=qz5c+1HfqT-jAG6T8xM_Wv9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 09.10.25 21:58, Raphael Norwitz wrote:
> On Wed, Aug 13, 2025 at 12:58 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> It's hard to control where and how do we use this field. Let's
>> cover all usages by getters/setters, and keep direct access to the
>> field only in vhost.c. It will help to control migration of this
>> field in further commits.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---

[..]

>> +/**
>> + * vhost_dev_has_feature() - check if vhost device has a specific feature
>> + * @dev: common vhost_dev structure
>> + * @feature: feature bit to check
>> + *
>> + * Return: true if the feature is supported, false otherwise
>> + */
>> +bool vhost_dev_has_feature(struct vhost_dev *dev, uint64_t feature);
>> +
>> +/**
>> + * vhost_dev_features() - simple getter for dev->features
>> + */
>> +uint64_t vhost_dev_features(struct vhost_dev *dev);
>> +
>> +void vhost_dev_clear_feature(struct vhost_dev *dev, uint64_t feature);
> 
> Why not define these as static inline helpers in the header file?
> 

Agree, will do.

> 
>> +
>>   #ifdef CONFIG_VHOST
>>   int vhost_reset_device(struct vhost_dev *hdev);
>>   #else



-- 
Best regards,
Vladimir

