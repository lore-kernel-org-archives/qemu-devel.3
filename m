Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BD2C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1oSn-00075c-3q; Tue, 30 Apr 2024 10:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1s1oSj-00074h-ET
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:28:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1s1oSU-0008US-2a
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714487264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j7zsDVy3L3Qacv5EF9ymdXqfbRbkLZETYwZ1Xh3+vkM=;
 b=aRau/Ualp72bz+izkRgQ743lSbbLCv5+L943cWSx79vY1SdHAOEd8WZ6wVyWAeN+tme7uV
 5AwS26St1DZni4iQ8aOYih4hXC7xGk93xdkAGBpzhJWHR6M95maooSrT560YRaTRlTKq2O
 KuQin5VjfrFSu7ym9m5uXKytK70N8GI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-wqH0DcrpNt6W5v1MYmf5cg-1; Tue, 30 Apr 2024 10:27:42 -0400
X-MC-Unique: wqH0DcrpNt6W5v1MYmf5cg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2df7b174b87so32388881fa.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714487261; x=1715092061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j7zsDVy3L3Qacv5EF9ymdXqfbRbkLZETYwZ1Xh3+vkM=;
 b=nX6O5+ejcvb8MIAPLBoQ1LmS7an2ISVlYwq1JNo5KBmzZIvaTQwEGgl3m9hGZlATAS
 7Wemmc+8xMPWH4J2rFxR10Dlzhf5YDa5uPyQP5RW3KzeU/jC6RpjYgS9NPk0MxuFdaTv
 kZi/EYYbLnFKPngcR6YSjy9l0V+0IMa5sOl/PY1dEFF5jGjixwYBhzUHtJ+5nA9T9/04
 7wA0Uf3JwahOh4LTQ2C/l8HwXOP/KrHA6IunfoJQAe0lSfnugAL2Bf4qSEYX8a8Yxhyo
 X4g02Sdf2+HBM7QY9NwThVpXRs/bj1LBiVTPHaOI3vg6d+pjYnR9OkjTgEP6719gyLBj
 E5Hw==
X-Gm-Message-State: AOJu0YxD4hexdjE0svMxQaDrNe6Phc2U/AKP+dd/RldGopUEyW9u5CoO
 YHrQxksi1LYNdRdIQZkKDDXWh0NIFskoSvc00DuMn/wI9TAq1jUFRA1pFkIbEjUwoR6198Lo0XA
 rISbA7ATE3Nm6y/wM2HQ1OeFojoMntfZL2qSfjTXKRmLld3f2Jkt+
X-Received: by 2002:a2e:a987:0:b0:2de:8685:d07b with SMTP id
 x7-20020a2ea987000000b002de8685d07bmr2369109ljq.46.1714487261488; 
 Tue, 30 Apr 2024 07:27:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1EwDPo8NjuKjQuq9omzMazcvSnw6h1CtvuDTKyDOqDVOen+dB+Jr9oUSevRnUrKiv+s5rUQ==
X-Received: by 2002:a2e:a987:0:b0:2de:8685:d07b with SMTP id
 x7-20020a2ea987000000b002de8685d07bmr2369090ljq.46.1714487261042; 
 Tue, 30 Apr 2024 07:27:41 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 d7-20020a05600c34c700b0041b086d664fsm23584652wmq.6.2024.04.30.07.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 07:27:40 -0700 (PDT)
Date: Tue, 30 Apr 2024 16:27:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, mlevitsk@redhat.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru, boris.ostrovsky@oracle.com
Subject: Re: [PATCH] system/qdev-monitor: move drain_call_rcu call under if
 (!dev) in qmp_device_add()
Message-ID: <20240430162739.7a6e65de@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231103105602.90475-1-ds-gavr@yandex-team.ru>
References: <20231103105602.90475-1-ds-gavr@yandex-team.ru>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri,  3 Nov 2023 13:56:02 +0300
Dmitrii Gavrilov <ds-gavr@yandex-team.ru> wrote:

Seems related to cpu hotpug issues,
CCing Boris for awareness.

> Original goal of addition of drain_call_rcu to qmp_device_add was to cover
> the failure case of qdev_device_add. It seems call of drain_call_rcu was
> misplaced in 7bed89958bfbf40df what led to waiting for pending RCU callbacks
> under happy path too. What led to overall performance degradation of
> qmp_device_add.
> 
> In this patch call of drain_call_rcu moved under handling of failure of
> qdev_device_add.
> 
> Signed-off-by: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>
> ---
>  system/qdev-monitor.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 1b8005a..dc7b02d 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -856,19 +856,18 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
>          return;
>      }
>      dev = qdev_device_add(opts, errp);
> -
> -    /*
> -     * Drain all pending RCU callbacks. This is done because
> -     * some bus related operations can delay a device removal
> -     * (in this case this can happen if device is added and then
> -     * removed due to a configuration error)
> -     * to a RCU callback, but user might expect that this interface
> -     * will finish its job completely once qmp command returns result
> -     * to the user
> -     */
> -    drain_call_rcu();
> -
>      if (!dev) {
> +        /*
> +         * Drain all pending RCU callbacks. This is done because
> +         * some bus related operations can delay a device removal
> +         * (in this case this can happen if device is added and then
> +         * removed due to a configuration error)
> +         * to a RCU callback, but user might expect that this interface
> +         * will finish its job completely once qmp command returns result
> +         * to the user
> +         */
> +        drain_call_rcu();
> +
>          qemu_opts_del(opts);
>          return;
>      }


