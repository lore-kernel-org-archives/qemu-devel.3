Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85C9C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 09:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl39l-0000Et-1y; Thu, 20 Feb 2025 04:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tl39i-0000EI-M9
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:47:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tl39g-0006p5-HJ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740044858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MQji0mc6jUiguvvHEq4lM0Es1SoyzJOCCbijdg63Opk=;
 b=QlJe8vSYv2/7zmjkbOOhF3H6haGaAR59UIReR57m14+2e82/T5DZWLxU41jt4xRuuCW0yy
 tyKhqVa7Znz6vu0Q1fC6+wHROf/R7ayugB5kMEyuPAZe9NJKq48rfGc4O7SBTCs7PRW8XM
 xDqJ4A9bd7thB078IvSIuGLwwXRl0WM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-jZbZQPH0N92TZY4QnDN_GA-1; Thu, 20 Feb 2025 04:47:36 -0500
X-MC-Unique: jZbZQPH0N92TZY4QnDN_GA-1
X-Mimecast-MFC-AGG-ID: jZbZQPH0N92TZY4QnDN_GA_1740044855
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4393e8738b3so5360635e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 01:47:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740044855; x=1740649655;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MQji0mc6jUiguvvHEq4lM0Es1SoyzJOCCbijdg63Opk=;
 b=XlZne6sAaSfxIMw5hNYTW+JNlEuMIEAzahWKFnbgaFa+8TQim5M/oXQpD8ZHtTP2aQ
 AM1PyQ4Bv64jAMkW3BEq2MGuG3BZS4DEe9AnFtftiv7MdopCB78WT+0LPaukCUGNyEPC
 ys4KCjWU00MaBmaqjSPJQQDpFN1MOJ/LU7UVGmJNU/Ywc2oRAnBF3H3Mlf6nong41UYZ
 yMYDAi5I+bESvNUFcdN7h1+cIo/t/z8y3twGuoFatKXPGIvzh+CbfGmG4rma2+y4bs4o
 tKIs3/YLdwVtq8tEMCOUuLr2Wb03nXI9Go6uVBayV9RfPMqxfQHNcTWXm+a5j55+I3Td
 3ZjQ==
X-Gm-Message-State: AOJu0YxGnlASqirNBEflp+IEMO/NvW8s9fe14Za4X/l15vM0qGFqiAGk
 9bkxn5vwaadkOhIHQMunPBJ/m+WXiRjBjYieDwxNv6dZy5ajOvqGu6XuiCw5ZWveRJP2WGHUnzp
 9Wlz1Yw+xHb9p3xsTKnUgPnTbh9iyRzwrfT8vKLemWnDd8EkKTtwRKgPAfMdGUlLh0GjJe1W3BM
 QJN1aot/yr3j97cnOfc4cuyHtHgM8=
X-Gm-Gg: ASbGncuej8rIvcdzaq8XemgCRz0FzsQQfYv2NPStMX9Z1Ehw+L5AH9H8YCx1Oi8ol6z
 +GkcschqQEy52rOQvYyuY+I17gV+7oe+32WVi1/Q/X1h95Ybews1rINyTm0MVFwVS
X-Received: by 2002:a05:600c:46cf:b0:439:88bb:d002 with SMTP id
 5b1f17b1804b1-43999dd1e04mr65018605e9.23.1740044855252; 
 Thu, 20 Feb 2025 01:47:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdMBdilweyz66J/7ff13aEtTjCn69ALBzMjs57CD5JCO9+fCnInIqtUAuurt9N6f3FcqJ4ljlxRWPoQqfA0Fc=
X-Received: by 2002:a05:600c:46cf:b0:439:88bb:d002 with SMTP id
 5b1f17b1804b1-43999dd1e04mr65018265e9.23.1740044854566; Thu, 20 Feb 2025
 01:47:34 -0800 (PST)
MIME-Version: 1.0
References: <20250215123119.814345-1-ppandit@redhat.com>
 <20250215123119.814345-3-ppandit@redhat.com>
 <87y0y4tf5q.fsf@suse.de>
 <CAE8KmOxYE=10+xjMjH5ZhbMmRJHgxJKHj2wH-nB-qiBSHEVh1w@mail.gmail.com>
 <878qq39vu3.fsf@suse.de>
 <CAE8KmOyy=ybDaRFpFr0DTJWScyjCX+99PKHzLibv6zhtUpw8Ng@mail.gmail.com>
 <87r03t97ep.fsf@suse.de>
In-Reply-To: <87r03t97ep.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 20 Feb 2025 15:17:17 +0530
X-Gm-Features: AWEUYZlKAkovBsSe8_f_HDYvUqrvZmigozuNw0OzG093AAw5B-JCyCvNuhu7Vfw
Message-ID: <CAE8KmOyzkLS3zvb7a32CUVJuvS-VEkZwSAfJUZwQqT-xiZLnJw@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] migration: enable multifd and postcopy together
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello,

On Wed, 19 Feb 2025 at 22:53, Fabiano Rosas <farosas@suse.de> wrote:
> I don't see anything stopping postcopy_start() from being called in the
> source in relation to multifd recv threads being setup in the
> destination. So far it seems possible that the source is opening the
> preempt channel while multifd still hasn't seen all threads. There's
> also pre-7.2 machines which create the postcopy channel early.

* If we can not predict the sequence/timings of when different types
of connections are initiated and processed, maybe source and
destination QEMUs could work in tandem. ie. before initiating a
connection, source QEMU could send an 'initiate' message saying I'm
initiating 'X' connection. Only when destination QEMU says 'okay',
source QEMU could proceed with actual connection.

     QEMU-A  -> Initiate connection type X -> QEMU-B
     QEMU-A  <-            okay           <-        <- QEMU-B
     QEMU-A ->       connect type X            -> QEMU-B

   (thinking out loud)

>>> > * migration_needs_multiple_sockets()
>> Then it should return 'True' when both migrate_multifd() and postcopy_preempt() are enabled.
> Why?

* I was thinking multiple_sockets is multiple types of sockets:
multifd & postcopy. But it seems here multiple sockets is any type of
multiple sockets.

> I thought you meant the CH_MAIN stuff. So now I don't know what you
> mean. You want to do away with multifd?

* Yes, CH_DEFAULT -> CH_MAIN was introduced in this series to identify
channels and accordingly call relevant functions.

* Not to do away with multifd, but more of making it same as the main
channel, ex: virsh migrate --threads <N> N = 1...255. All precopy
threads/connections behave the same. Differentiation of precopy and
postcopy shall still exist, because they operate/work in opposite
directions.

> Continue with this patch and fix the stuff I mentioned. You can ignore
> the first two paragraphs of that reply.
>
> https://lore.kernel.org/r/87y0y4tf5q.fsf@suse.de
>
> I still think we need to test that preempt + multifd scenario, but it
> should be easy to write a test for that once the series is in more of a
> final shape.

* Okay.

> We can't add magic values, as we've discussed.

Okay.

Thank you.
---
  - Prasad


