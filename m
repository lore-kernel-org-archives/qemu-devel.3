Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0097C47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 09:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVTbx-0006sg-Fm; Thu, 01 Feb 2024 04:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVTbw-0006sT-EN
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 04:43:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVTbu-0003Q9-RC
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 04:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706780633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KoXOp6pRgDhbQLLsc6S7bRm0i2514bvY0ox1O/Hk4CM=;
 b=FypV9HuQRn7wkuLDGKVrBsREFvUjqRNep9Iqp1fWL58IdQaJrPoDV0cLucW5b7tXlJXw8O
 36Ux5GPKV8t+69kbd7uzIs2BEECwqIAuqjHwq4+w5m1Q08Yhseh8kD1g1FVA8VTa5pvg7i
 E4qvVgvfAQV4+KSmYtxUK5B/vM/XtAg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-viKmVG4OPo6gHNZy482keQ-1; Thu, 01 Feb 2024 04:43:51 -0500
X-MC-Unique: viKmVG4OPo6gHNZy482keQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40e4478a3afso2729055e9.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 01:43:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706780630; x=1707385430;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KoXOp6pRgDhbQLLsc6S7bRm0i2514bvY0ox1O/Hk4CM=;
 b=jWBZHkeKDC84Gjkx0s78bgupnZF8ekXzhiE76D6mngfLRsXYqABiXP/Ap4ZVNriLaR
 kySjuOZua+xl1hBW6YJKeZCat4KcNkTlsQ0ry8K9HdsqBTX6tn2M43TcXuI3m/GXCG7p
 FfndiaBEGYOBrYvxxIRJQELYXWQtLlfNMd5ygbFIpQ7Iq4ujY7fnEisJcSSafx5ByAVO
 W5NUGJD2SQV4wfAGCmtkSNRuS3S0uzBAHy+vcci6nQnoRzUnC+eCTGRZkBeXjd39lU+L
 d0SLnJld0Nx3iZoKsoURxP+9OIkWFKCsjYSHhMnk8U+F4/gc5BCVM4aS/OjMVIqXJKgF
 R+bw==
X-Gm-Message-State: AOJu0YwcMTSfQcW0ykctda+/DpM7wVchSd6JKZ1Yyu5aV/iAD9sFb8cW
 L2n3jqTrVF1lS+LOdX3hPyFKU/S2aASwiZ4u+cU2Z/aDIxdwvtVGSPM834l64isiwDZCCb94bvc
 QbgUs67IFn+6TKkGfLfW0h3e1c3oCWAmANVsfhlTi70qjv9S99FTU
X-Received: by 2002:a05:600c:524f:b0:40e:8655:d48f with SMTP id
 fc15-20020a05600c524f00b0040e8655d48fmr6243812wmb.11.1706780630397; 
 Thu, 01 Feb 2024 01:43:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHZElhMRUxfuvFceubSWnQpcl1fYTE7Q8UFPFw9Tce5wRtULO6+++VbGOqmytU1rFEgSZgUg==
X-Received: by 2002:a05:600c:524f:b0:40e:8655:d48f with SMTP id
 fc15-20020a05600c524f00b0040e8655d48fmr6243792wmb.11.1706780630032; 
 Thu, 01 Feb 2024 01:43:50 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVrFSFXK4rRnjQkUcFnR3cjXKr+Xww5KlV+/e0mEs3yBGa2RoEi2xe/PkzbNuBO45L+eP+2YujOcnIM3hiuofNnarE7R9a/bXok/W/EhRRLmYClhuajxITU2QI=
Received: from ?IPV6:2003:cf:d73b:4137:edbf:522e:3a5a:e7ed?
 (p200300cfd73b4137edbf522e3a5ae7ed.dip0.t-ipconnect.de.
 [2003:cf:d73b:4137:edbf:522e:3a5a:e7ed])
 by smtp.gmail.com with ESMTPSA id
 cl3-20020a5d5f03000000b0033afd49cac7sm5902754wrb.43.2024.02.01.01.43.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 01:43:49 -0800 (PST)
Message-ID: <ed004630-5b85-4ad2-a22f-475571d0df33@redhat.com>
Date: Thu, 1 Feb 2024 10:43:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/33] scsi: only access SCSIDevice->requests from one
 thread
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
References: <20231221212339.164439-1-kwolf@redhat.com>
 <20231221212339.164439-12-kwolf@redhat.com>
 <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
 <Za_zAj11uwavd2va@redhat.com>
 <23796a78-e88e-4047-b5a5-7db760c50929@redhat.com>
 <ZboeJIXKDP7OP9YD@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <ZboeJIXKDP7OP9YD@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 31.01.24 11:17, Kevin Wolf wrote:
> Am 29.01.2024 um 17:30 hat Hanna Czenczek geschrieben:
>> I don’t like using drain as a form of lock specifically against AioContext
>> changes, but maybe Stefan is right, and we should use it in this specific
>> case to get just the single problem fixed.  (Though it’s not quite trivial
>> either.  We’d probably still want to remove the assertion from
>> blk_get_aio_context(), so we don’t have to require all of its callers to
>> hold a count in the in-flight counter.)
> Okay, fair, maybe fixing the specific problem is more important that
> solving the more generic blk_get_aio_context() race.
>
> In this case, wouldn't it be enough to increase the in-flight counter so
> that the drain before switching AioContexts would run the BH before
> anything bad can happen? Does the following work?

Yes, that’s what I had in mind (Stefan, too, I think), and in testing, 
it looks good.

Hanna

>
> Kevin
>
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index 0a2eb11c56..dc09eb8024 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -120,17 +120,11 @@ static void scsi_device_for_each_req_async_bh(void *opaque)
>       SCSIRequest *next;
>   
>       /*
> -     * If the AioContext changed before this BH was called then reschedule into
> -     * the new AioContext before accessing ->requests. This can happen when
> -     * scsi_device_for_each_req_async() is called and then the AioContext is
> -     * changed before BHs are run.
> +     * The AioContext can't have changed because we increased the in-flight
> +     * counter for s->conf.blk.
>        */
>       ctx = blk_get_aio_context(s->conf.blk);
> -    if (ctx != qemu_get_current_aio_context()) {
> -        aio_bh_schedule_oneshot(ctx, scsi_device_for_each_req_async_bh,
> -                                g_steal_pointer(&data));
> -        return;
> -    }
> +    assert(ctx == qemu_get_current_aio_context());
>   
>       QTAILQ_FOREACH_SAFE(req, &s->requests, next, next) {
>           data->fn(req, data->fn_opaque);
> @@ -138,6 +132,7 @@ static void scsi_device_for_each_req_async_bh(void *opaque)
>   
>       /* Drop the reference taken by scsi_device_for_each_req_async() */
>       object_unref(OBJECT(s));
> +    blk_dec_in_flight(s->conf.blk);
>   }
>   
>   /*
> @@ -163,6 +158,7 @@ static void scsi_device_for_each_req_async(SCSIDevice *s,
>        */
>       object_ref(OBJECT(s));
>   
> +    blk_inc_in_flight(s->conf.blk);
>       aio_bh_schedule_oneshot(blk_get_aio_context(s->conf.blk),
>                               scsi_device_for_each_req_async_bh,
>                               data);
>


