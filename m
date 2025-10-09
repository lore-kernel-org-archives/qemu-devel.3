Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06777CCD18F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6x7q-0003e2-MF; Thu, 09 Oct 2025 16:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v6x7p-0003cm-7R; Thu, 09 Oct 2025 16:20:33 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v6x7i-0007Yw-PW; Thu, 09 Oct 2025 16:20:32 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A53A0807DE;
 Thu, 09 Oct 2025 23:20:22 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:162::1:3a] (unknown
 [2a02:6bf:8080:162::1:3a])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LKRB7L1FvOs0-8eZUl6wa; Thu, 09 Oct 2025 23:20:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760041222;
 bh=rbknOxyLeEzCRoz0KCulvIVgfdZOpYxHXV+SklAXSLY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=MHbhH8EIsu79D9AeZXA9+LZ2YKPXgi82AH/xja8A4Psfc+Q974p6+V9ALyWuS6Dyb
 Obwm7BVMnNL6L6/FH8U+fC5rGuZNURj9IBtqxYa9XBsynmcUv8opOQ20I0Qxey6prB
 Tlc4TmcyaSrI19kgNeSqk80w+GrW56IYCsnUPP/c=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <942f452c-34e5-4b52-90cb-3a418d0ea732@yandex-team.ru>
Date: Thu, 9 Oct 2025 23:20:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/33] vhost: add some useful trace-points
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael@enfabrica.net, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-24-vsementsov@yandex-team.ru>
 <CAFubqFu+CPGKO_-wLLqXQaO5wLr2R6gykZ2ufrC0aHqjebVAmA@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFubqFu+CPGKO_-wLLqXQaO5wLr2R6gykZ2ufrC0aHqjebVAmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 09.10.25 22:08, Raphael Norwitz wrote:
> On Wed, Aug 13, 2025 at 12:58 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
>> ---
>>   hw/virtio/trace-events |  8 ++++++++
>>   hw/virtio/vhost.c      | 16 ++++++++++++++++
>>   2 files changed, 24 insertions(+)
>>
>> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>> index e5142c27f9..bd595fcd91 100644
>> --- a/hw/virtio/trace-events
>> +++ b/hw/virtio/trace-events
>> @@ -10,7 +10,15 @@ vhost_reject_section(const char *name, int d) "%s:%d"
>>   vhost_iotlb_miss(void *dev, int step) "%p step %d"
>>   vhost_dev_cleanup(void *dev) "%p"
>>   vhost_dev_start(void *dev, const char *name, bool vrings) "%p:%s vrings:%d"
>> +vhost_dev_start_finish(const char *name) "%s"
>>   vhost_dev_stop(void *dev, const char *name, bool vrings) "%p:%s vrings:%d"
>> +vhost_dev_stop_finish(const char *name) "%s"
>> +vhost_virtque_start(const char *name, int idx) "%s %d"
>> +vhost_virtque_start_finish(const char *name, int idx) "%s %d"
>> +vhost_virtque_stop(const char *name, int idx) "%s %d"
>> +vhost_virtque_stop_finish(const char *name, int idx) "%s %d"
>> +vhost_dev_init(void) ""
>> +vhost_dev_init_finish(void) ""
> Ditto here - I would think this should also have the VirtIODevice/vdev pointer.

Ok

-- 
Best regards,
Vladimir

