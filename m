Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FA6CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 12:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUkeg-0004Dj-4k; Wed, 03 Jun 2026 08:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUkeM-0004C4-F8
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 08:24:50 -0400
Received: from msg-3.mailo.com ([213.182.54.8] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUke0-0005sU-T2
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 08:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780486749; bh=MERbtZScp6ESI5UIVej1gX6ZW7skJf1XAH5lmBf2miU=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=hX57/RHYwHExCu31m8fbJouDgDG7ovTWQvAjP/TKf7OfgDBx5qKADqzT+r2PJ4MbC
 NTV85te6/FAlJb/KJ0/sCSnZvJ8Ydhbuye7qQVyifjkmdlJOdHSMvmGSVxOhzfT2Wn
 z1f5ZB9J/nTgmn+yT/3bp6I/sN5uscX45zPLDqvw=
Received: by be1-1.in.mailobj.net [192.168.91.11] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 13:39:00 +0200 (CEST)
X-EA-Auth: kCVNMpfcfKsdlm9ORFgWlUHkclNroIYXe0lAFu1a1G48gmK3bxwbjR/LY0QQ5QlEg50+jAWd9aYuO8I8D6L+684HPNV5WZFq
Message-ID: <708d5809-89f3-418c-8bd1-4ec7f9ebdaf7@mailo.com>
Date: Wed, 3 Jun 2026 13:38:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] vfio/migration: Add Error ** parameter to
 vfio_migration_init()
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260602092621.382-1-avihaih@nvidia.com>
 <20260602092621.382-10-avihaih@nvidia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260602092621.382-10-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=213.182.54.8; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

Hi Avihai,

On 2/6/26 11:26, Avihai Horon wrote:
> vfio_migration_init() already has many failure points and a new one will
> be added in next patch.
> 
> Add Error ** parameter to vfio_migration_init() to report a detailed
> error message through it.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   hw/vfio/migration.c | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index a15e877fd3..02ef216712 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -1055,7 +1055,7 @@ static bool vfio_dma_logging_supported(VFIODevice *vbasedev)
>       return !ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
>   }
>   
> -static int vfio_migration_init(VFIODevice *vbasedev)
> +static int vfio_migration_init(VFIODevice *vbasedev, Error **errp)
>   {
>       int ret;
>       Object *obj;
> @@ -1066,21 +1066,31 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>       VMChangeStateHandler *prepare_cb;
>   
>       if (!vbasedev->ops->vfio_get_object) {
> +        error_setg(errp, "no vfio_get_object handler");
>           return -EINVAL;
>       }
>   
>       obj = vbasedev->ops->vfio_get_object(vbasedev);
>       if (!obj) {
> +        error_setg(errp, "failed to get object");
>           return -EINVAL;
>       }
>   
>       ret = vfio_migration_query_flags(vbasedev, &mig_flags);
>       if (ret) {
> +        if (ret == -ENOTTY) {
> +            error_setg_errno(errp, -ret,
> +                             "migration is not supported in kernel");
> +        } else {
> +            error_setg_errno(errp, -ret, "failed to query migration flags");
> +        }
> +
>           return ret;
>       }
>   
>       /* Basic migration functionality must be supported */
>       if (!(mig_flags & VFIO_MIGRATION_STOP_COPY)) {
> +        error_setg(errp, "VFIO_MIGRATION_STOP_COPY is not supported");
>           return -EOPNOTSUPP;
>       }
>   
> @@ -1278,18 +1288,9 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>           return !vfio_block_migration(vbasedev, err, errp);
>       }
>   
> -    ret = vfio_migration_init(vbasedev);
> +    ret = vfio_migration_init(vbasedev, &err);
>       if (ret) {

Only 'ret' boolean part is used now, have the method return a boolean
instead, like other methods with Error **errp last param?

> -        if (ret == -ENOTTY) {
> -            error_setg(&err, "%s: VFIO migration is not supported in kernel",
> -                       vbasedev->name);
> -        } else {
> -            error_setg(&err,
> -                       "%s: Migration couldn't be initialized for VFIO device, "
> -                       "err: %d (%s)",
> -                       vbasedev->name, ret, strerror(-ret));
> -        }
> -
> +        error_prepend(&err, "%s: VFIO migration init failed: ", vbasedev->name);
>           return !vfio_block_migration(vbasedev, err, errp);
>       }
>   



