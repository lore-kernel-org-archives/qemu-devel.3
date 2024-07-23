Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4788C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 04:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW7bb-0003Yi-Ac; Tue, 23 Jul 2024 00:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sW7bY-0003Xg-Hu
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 00:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sW7bW-0004PD-Hu
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 00:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721710703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XPnurABD4IVPzwdohfGDBiRjKL4Mr9keph5NcwqfvQ0=;
 b=fPA0zf1cWLlwxfl8PTsDJrgn0sjtm63o8uzcwi5kW5SfkD/X9PwlmcIPiXz6aJJiDqu2Cm
 C+LjmyIxK/bcULTmAC0hefUQnaw6WAFbRVpAW1XVB7USrFmKO3EUTnxCESx0dFugKhCFZb
 s+V6GmM00rJH0Qpt9D1F2OItknn6Du4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-U0TfveMuOJquG3JVHnpbUw-1; Tue, 23 Jul 2024 00:58:19 -0400
X-MC-Unique: U0TfveMuOJquG3JVHnpbUw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4279c75c44dso36052725e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 21:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721710698; x=1722315498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XPnurABD4IVPzwdohfGDBiRjKL4Mr9keph5NcwqfvQ0=;
 b=tiZUGJuL62cEN8Nu70axzEDh0BRnGBeoMGSe93ZNb19VneiXdggeKHwNXo0M5A6ztw
 XMTI4uAK6ZDl736U7AKxFgbOB0jHEcOpvnGnrTRMoMM8grA4B9glDvnvGGLCoM8W1A/T
 uIH5/+z/2+G/1LUdZ4xe1xvo9aUGxv6mD60rkhSBUud4lLwPYu2bathIpX13iwke8h/2
 +7P+O+5EzdjWKk1zeTWAzcWxtfDYsSaVH/2+4Z4svj3dCPk6hBRmh0xywG6q7QTIt8qe
 0mHOnlL8FSgh9uvHLrXqGqqU1p+KdjBmhVPvBW135awNPQZxmB33oURfc4R3bpMTkvXq
 9wHg==
X-Gm-Message-State: AOJu0Yy8p6mV/K9WXH7bHgEnN03rgK6fQDNHZFYYPHpicc/UHTQPEIGZ
 9nQbrzppcDE6X7iP87G8FIrcY+KqvHyhT/ZKC2V/+majIY0Jlzfn2dCvv6LANXk061cFaBhoCyI
 iz/J5qXtf9biz6+lXxyInDVQ2HRTqkOXsTfBmU1BvpUX6cqnnmGkB+01Ma+88oYW/dOrR5SLlj8
 Yvhp/Y+fb31RGEeqxdKZxAGvJtJ+s=
X-Received: by 2002:a05:600c:4fcb:b0:424:ad14:6b79 with SMTP id
 5b1f17b1804b1-427dc51610cmr59592245e9.8.1721710698542; 
 Mon, 22 Jul 2024 21:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9pPRQ31+0AbxTGstTmXXN+YXiVbmvN3/NhN2WjPt7T7PRWyKZUByFMGBZGZnLhy+rqn+UqBGyUPb0GjcC9TU=
X-Received: by 2002:a05:600c:4fcb:b0:424:ad14:6b79 with SMTP id
 5b1f17b1804b1-427dc51610cmr59592175e9.8.1721710698187; Mon, 22 Jul 2024
 21:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240711131424.181615-1-ppandit@redhat.com>
 <20240711131424.181615-2-ppandit@redhat.com>
 <20240720153808-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240720153808-mutt-send-email-mst@kernel.org>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 23 Jul 2024 10:28:01 +0530
Message-ID: <CAE8KmOy4ZjNPAQxChGd3AYEeE1_NZLAU8OS-jT0DtSnH_it9yA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vhost-user: add a write-read lock
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Jason Wang <jasowang@redhat.com>,
 mcoqueli@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, 21 Jul 2024 at 01:11, Michael S. Tsirkin <mst@redhat.com> wrote:
> So it's not a rw lock. It's just a mutex.
> Lock should be named after what they protect, not
> after where they are held.
> In this case, this ensures only 1 request is
> outstanding at a time.
> So vhost_user_request_reply_lock

Okay, will do this change. Thank you.
---
  - Prasad


