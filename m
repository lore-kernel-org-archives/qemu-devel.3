Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDE8C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 12:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riZ1l-0005Xl-76; Fri, 08 Mar 2024 07:08:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1riZ1a-0005VP-6F
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 07:08:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1riZ1Y-0003kS-9M
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 07:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709899704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d9cnQoxlSww8PFNWbPNPZ18kY4VSP6lMzK2JGzgNAxQ=;
 b=VWKE3yfwyCacoVqyFSEbeoGogsE8kcIsDyU1jFSl94rXdHgjsSNI1Jlu0kk6wNsgWaeGFW
 ssafTdCfMoctnrGyElK/w0cpbChAeg2qcAMoL2JYk1v7X0uPrkCboLjB1hCE1TVDOPWewt
 WJEp6d9bYEmaiX+k10zmYygTyZLIxOc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-2VnRYxf1PB6_FE_E54CRVw-1; Fri, 08 Mar 2024 07:08:22 -0500
X-MC-Unique: 2VnRYxf1PB6_FE_E54CRVw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33d7e755f52so955799f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 04:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709899701; x=1710504501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d9cnQoxlSww8PFNWbPNPZ18kY4VSP6lMzK2JGzgNAxQ=;
 b=lBhsDILyE9EOnJ+TOvoHUAetanwG7dIlOz8VY8+Ae+q6fX5zO6wN/RLdVoIaWze+xA
 u+dyYnCH5lL127iuBMON7l4dAdHTOJo4W+7KpCDqOYreHLFPyZksqgLM4+UBKBprs3Yi
 HQ8FfzCKuAzGQQJGByvlwVPj0BDi0ztwUWHB5Sqp4toUICLGuay6/Yko5fqQMbQh4AEh
 H7GsvLE6Og4u3tD13PCLcvs01lqYNqfrry/bV6sOjSu4yZyPHg2ziBY4vrPs5u8I+xGH
 PSrzYB6NGScFizTuuAEcOknqOiQZxik+hVlMkxqfulwuv6qukAAu5JSMoy2o1TcOVRnP
 QGSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNE/IxTFmhWLT0QD1sQpsul22L9Cf+gUuY7pwXpzHbJgAcXXnojpUzMnFE8dC0u8wH0fiyYvoQkyps3jFQSZrNRi/rLi4=
X-Gm-Message-State: AOJu0Yz5NLBwoevhK1BIfb2hhWcmLYlKHBfUb84ZxeECe9bgcIjizFOJ
 TyqmYFzHObAwz7/v1ArICAEkJ/AZkDXQREtzgPfD/6E02tyaEjOusZRpSIJaVnk22cm9lWEqHrC
 mNbqGJ0qT9uPaeepwflmtpv6lYEh/aQR8IZWP5WhOiABhHnycTwiR7mGYTiUohTGWyjcrCTqa0K
 BWXoNaVkl+90wkNlQtfmnqcab2x5c=
X-Received: by 2002:a5d:6986:0:b0:33e:1832:c09c with SMTP id
 g6-20020a5d6986000000b0033e1832c09cmr13682987wru.10.1709899701722; 
 Fri, 08 Mar 2024 04:08:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4pfb+WmLmlSHzXYHU11lMEk4gG6zAyBPW/4tZFxb1eIG7KWuE/bGD4Fn22E0Ov5iHafPShNgSKuDwp/Hl+zE=
X-Received: by 2002:a5d:6986:0:b0:33e:1832:c09c with SMTP id
 g6-20020a5d6986000000b0033e1832c09cmr13682977wru.10.1709899701381; Fri, 08
 Mar 2024 04:08:21 -0800 (PST)
MIME-Version: 1.0
References: <20240307114744.1135711-1-ppandit@redhat.com>
 <ZenGQZE4hlOR6J4V@redhat.com>
 <CAE8KmOzQVFrK3kh6M3-TAm_=hsGB7KP+wjN8synRotd68A_O-Q@mail.gmail.com>
 <ZerU1a6U8Xx0_R6s@redhat.com>
In-Reply-To: <ZerU1a6U8Xx0_R6s@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 8 Mar 2024 17:38:04 +0530
Message-ID: <CAE8KmOyzt+dhfeJ2ZM=kmy1zFOnhqi74AeGUFsRLAcBYcX8CzQ@mail.gmail.com>
Subject: Re: [PATCH] linux-aio: add IO_CMD_FDSYNC command support
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Kevin,

On Fri, 8 Mar 2024 at 14:35, Kevin Wolf <kwolf@redhat.com> wrote:
> Hm... This might make it more challenging because then not only one
> specific request fails, but the whole submission batch.

* Yes exactly.
* I've updated yesterday's patch to return an error (-EINVAL) from
ioq_submit to laio_co_submit and fallback on thread-pool as you said.
It seems to be working fine when the kernel supports an AIO_FDSYNC
call. I'm trying to test it against the Fedora-26 kernel, which was <
4.13.0, and did not support the AIO_FDSYNC call.

> Do we know if it can include unrelated requests?

* Unrelated requests?

> It passes the return value to the request:
>
>     if (ret < 0) {
>         /* Fail the first request, retry the rest */
>         aiocb = QSIMPLEQ_FIRST(&s->io_q.pending);
>         QSIMPLEQ_REMOVE_HEAD(&s->io_q.pending, next);
>         s->io_q.in_queue--;
>         aiocb->ret = ret;
>         qemu_laio_process_completion(aiocb);
>         continue;
>     }
>
> laio_co_submit() then fetches it from laiocb.ret and returns it to its
> caller (in this case, your new code).

* I did not get what's happening here. It looks like when 'io_submit'
returns an error, ioq_submit plucks out the first 'laiocb' object from
QSIMPLEQ and sets the error code (-EINVAL) in it, and continues to
submit further requests in the batch. But what if 'io_submit' of those
further requests also returns an error? ie. For each error code the
first object in the queue is removed and error code is saved in it?
But in laio_co_submit() it is only looking at the 'ret' value of one
local laiocb object, not all in the batch. So which return code 'ret'
is it really checking against -EINPROGRESS?

* If a user submits DEFAULT_MAX_BATCH 32=aio requests, in
laio_co_submit() there does not seem to be a way to see 'io_submit'
return value for all of them, right? Should it check the io_submit
status of them all?

Thank you.
---
  - Prasad


