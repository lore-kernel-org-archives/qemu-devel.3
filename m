Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1FCCA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 11:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umVuh-00031c-4c; Thu, 14 Aug 2025 07:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umVue-00031B-F3; Thu, 14 Aug 2025 07:14:28 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umVua-0004rT-Bo; Thu, 14 Aug 2025 07:14:28 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:3c8c:0:640:20c:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 0431A8062A;
 Thu, 14 Aug 2025 14:14:15 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:422::1:1d] (unknown
 [2a02:6bf:8080:422::1:1d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id CEKnEM0G2Sw0-EJNd2Hz7; Thu, 14 Aug 2025 14:14:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755170054;
 bh=NlMDsY3QhJScTm+yyDQeJ17DxZmXn6K4UfV2U8A8xdw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=jgqAJ6F/Rgi3rwFPPyqeXbxJ+gZ3FCsMKCAsKpW9/xPO0l3LVKPLVoAOdjBKypwQS
 oecdItJaVIldNvWXnXsfHNqEDlPiiY9/3sf6ntMihnILTaUKB5jcdjPByKL8O8tohi
 vVFUbiKbXDVfroxpfy1QDFSUR/73roGy/f1C6DH4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <fb84a195-4442-4a8d-a2c5-0b5177fabf69@yandex-team.ru>
Date: Thu, 14 Aug 2025 14:14:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/33] vhost-user-blk: add some useful trace-points
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-23-vsementsov@yandex-team.ru>
 <f3637a8d-04ae-4d46-b5c6-5022f5a4c865@linaro.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <f3637a8d-04ae-4d46-b5c6-5022f5a4c865@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 14.08.25 07:58, Philippe Mathieu-Daudé wrote:
> On 13/8/25 18:48, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   hw/block/trace-events     | 10 ++++++++++
>>   hw/block/vhost-user-blk.c | 15 +++++++++++++++
>>   2 files changed, 25 insertions(+)
>>
>> diff --git a/hw/block/trace-events b/hw/block/trace-events
>> index cc9a9f2460..3b5fd2a599 100644
>> --- a/hw/block/trace-events
>> +++ b/hw/block/trace-events
> 
> 
>> +# vhost-user-blk.c
>> +vhost_user_blk_start(void) ""
>> +vhost_user_blk_start_finish(void) ""
>> +vhost_user_blk_stop(void) ""
>> +vhost_user_blk_stop_finish(void) ""
>> +vhost_user_blk_connect(void) ""
>> +vhost_user_blk_connect_finish(void) ""
>> +vhost_user_blk_device_realize(void) ""
>> +vhost_user_blk_device_realize_finish(void) ""
> 
> Maybe use _in / _out suffixes? Naming is hard...

Agree, will change.

-- 
Best regards,
Vladimir

