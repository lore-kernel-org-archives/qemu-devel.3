Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F08DC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 18:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT4Wb-0002Fv-36; Thu, 25 Jan 2024 13:32:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rT4WS-0002EQ-ED
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 13:32:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rT4WQ-0002XX-79
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 13:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706207537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xwfUK9tFV5UXv4mhuaqjzR4NpURKKVgqO2FatkU91pw=;
 b=dHBFmDnrv5Ps7o2nlnlLob7huF8axGaFE/baooEbEzW6vr1o4KCT7FLIw5Kr8Ih0D/H6wY
 KbAwSbxLJle66T4ZrEpo5y0RhCNQSzSYpNw7Tt0s4eTCUgzzEaGDg7PuAS84OTp45W5t6b
 utmTLw7oBVGbHaOQUQlqcUqkrhm8wuQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-AROiZA9zO9-YS3tfGA9faQ-1; Thu, 25 Jan 2024 13:32:15 -0500
X-MC-Unique: AROiZA9zO9-YS3tfGA9faQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40e412c1e65so60503045e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 10:32:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706207534; x=1706812334;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xwfUK9tFV5UXv4mhuaqjzR4NpURKKVgqO2FatkU91pw=;
 b=FR+IH5xw2Lltsxr1lilt2iqn7+BTLWbSmfjyDP5Q3GI2NaI4o4GPZAStYGK7G/9zYE
 TgrtDihdDN2zRYL0sBLpW1FO1GRAt2XCJPUe+NpiNBl6fWnrqYSgznk8aCM+rYYBQnyC
 tPoy2EQS4eObQN0FLnfjdxEU4FYGT9s2RpGOFWUzxS0xaQRWluc8YTnyUXE4zJPkKYVt
 qXlzxy2Ek6UsnNJ88I2JeU8lAC+06roKHzkJd1slLC+L9YanwCos6dZKt0hFyW+h1iJI
 A20UMSS9+mKQpVaS19pjY7k0USVZj2kgLvIPI3NHEkt3ydx/plvTS5emd+ydFEbAj32f
 G3yQ==
X-Gm-Message-State: AOJu0YzdnlSSmMWelbDPc6wGD34WGT4HNOsZlaRxBp/sTc+WqwfZYSw1
 2sDOkYHtKUDsMTwq4/bgi+ZQToyEw/bg0xT/0daCoXJv+oMNDDabe1kXujWXy13K/c5ddiRGWIB
 14gC2F0/C09yWcfoEF3uWO+yApmhYCqEzCs3X3B9eJ6VXv8692XUa
X-Received: by 2002:a05:600c:16ca:b0:40d:8557:9263 with SMTP id
 l10-20020a05600c16ca00b0040d85579263mr108455wmn.130.1706207534505; 
 Thu, 25 Jan 2024 10:32:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQ+TKIvgeT6LME+sEWzxTEDTriJX6t2ZnjcfNYLZFwnvkCTcfHHJ7XeWiQE+Z2D8dT323UXw==
X-Received: by 2002:a05:600c:16ca:b0:40d:8557:9263 with SMTP id
 l10-20020a05600c16ca00b0040d85579263mr108445wmn.130.1706207534231; 
 Thu, 25 Jan 2024 10:32:14 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU1XwoPz7KgF0ubrNiLap66f02FNNbES7Mq4fi1xqWs4q52girvm/Fko//4aeN0k8phnMxrd8qY1sv7rSWGL2P7Qmx+m+I1smwhrP+OLwBsZ3lx7nQgm11ODTjJRnpyf2lvDnJgNr1YKbNTer6CEAjSSPnW6sYnXXKDYDwCRg3BNzv9FaDpybXAhR7ykrgmDeOoth5CYod/LTNPsiZdEsuBcQ==
Received: from ?IPV6:2003:cf:d73b:4169:9eef:dd9f:57fb:1235?
 (p200300cfd73b41699eefdd9f57fb1235.dip0.t-ipconnect.de.
 [2003:cf:d73b:4169:9eef:dd9f:57fb:1235])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a05600c310800b0040e5945307esm3378340wmo.40.2024.01.25.10.32.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 10:32:13 -0800 (PST)
Message-ID: <cb2e1577-9079-49ea-90e4-71d57b78290f@redhat.com>
Date: Thu, 25 Jan 2024 19:32:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio: Keep notifications disabled during drain
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Fam Zheng <fam@euphon.net>
References: <20240124173834.66320-1-hreitz@redhat.com>
 <20240124173834.66320-3-hreitz@redhat.com> <20240125180326.GA36016@fedora>
 <cd6bccd0-abca-40ec-9df0-fe5285d18d97@redhat.com>
In-Reply-To: <cd6bccd0-abca-40ec-9df0-fe5285d18d97@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 25.01.24 19:18, Hanna Czenczek wrote:
> On 25.01.24 19:03, Stefan Hajnoczi wrote:
>> On Wed, Jan 24, 2024 at 06:38:30PM +0100, Hanna Czenczek wrote:

[...]

>>> @@ -3563,6 +3574,13 @@ void 
>>> virtio_queue_aio_attach_host_notifier(VirtQueue *vq, AioContext *ctx)
>>>       aio_set_event_notifier_poll(ctx, &vq->host_notifier,
>>> virtio_queue_host_notifier_aio_poll_begin,
>>> virtio_queue_host_notifier_aio_poll_end);
>>> +
>>> +    /*
>>> +     * We will have ignored notifications about new requests from 
>>> the guest
>>> +     * during the drain, so "kick" the virt queue to process those 
>>> requests
>>> +     * now.
>>> +     */
>>> +    virtio_queue_notify(vq->vdev, vq->queue_index);
>> event_notifier_set(&vq->host_notifier) is easier to understand because
>> it doesn't contain a non-host_notifier code path that we must not take.
>>
>> Is there a reason why you used virtio_queue_notify() instead?
>
> Not a good one anyway!
>
> virtio_queue_notify() is just what seemed obvious to me (i.e. to 
> notify the virtqueue).  Before removal of the AioContext lock, calling 
> handle_output seemed safe.  But, yes, there was the discussion on the 
> RFC that it really isn’t.  I didn’t consider that means we must rely 
> on virtio_queue_notify() calling event_notifier_set(), so we may as 
> well call it explicitly here.
>
> I’ll fix it, thanks for pointing it out!

(I think together with this change, I’ll also remove the 
event_notifier_set() call from virtio_blk_data_plane_start().  It’d 
obviously be a duplicate, and removing it shows why 
virtio_queue_aio_attach_host_notifier() should always kick the queue.)


