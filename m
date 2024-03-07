Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3950C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 17:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riHP5-00040V-Dg; Thu, 07 Mar 2024 12:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1riHP4-00040D-Cz
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:19:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1riHP2-00050k-OQ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709831971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FWFfue0MrmIi6XhNAHGxvFZRuMoDvKEawI3WDj8n89E=;
 b=Khj4rJelHZ4qV4pMphe7XpjfRE2SFh+XALSIcTngxn9VZ5jPjiiAi0cbJWUPHeV1mPwbpp
 WjJHgUo5smjcHumpk9JW57TCIs5anDVUuRswcqgaMF6qXytc04G5WYMin6xYRw/kpUqUkt
 j+zv6ZjgkV0/rgTRZg5I+3AKOTQrSoA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-tifrb2qvMQOYLKxnpi5hAg-1; Thu, 07 Mar 2024 12:19:29 -0500
X-MC-Unique: tifrb2qvMQOYLKxnpi5hAg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40e435a606aso7171705e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 09:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709831968; x=1710436768;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FWFfue0MrmIi6XhNAHGxvFZRuMoDvKEawI3WDj8n89E=;
 b=buHwX5HJrlMWrS8/j/GhDgpK7+zmjd+6/9hWnQXw8u2HKJeeptw+y9wguSsXoTzs9u
 MM5DufMeAzMpJow+Yp0Wo1JC0VKChR/0zMHFWF6FQKdFiSdyRvSWqOhUPyEXE6O+I3VM
 xoMN9rPkur1fD37AlvicFDQTNHA0up12Zf99eE6XQM5sLg5n/9F4liRRGvTFQ3FI+Ssy
 e5lmqrJ0F3wxb7iqj5QqQPhKGNZ6DykeuqSdUV0BCQ+gbdNoPW7eQW0yEg6hBR8QBg3C
 2jcV2sdzo01bYIlfQ5aIN9bQDTy5/DQ58nHyUHKpND9CYcNT4CDyqaBulM97lOnY/tb7
 sI8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaNZ5D3KbwsRx7KUn88OFmGYFTIM9noCtcODiTbFfkv2D+lB2oMOJ29cZyTUF+uEJ4OPwxKj9lURCOZEGwTT4hZeXou9s=
X-Gm-Message-State: AOJu0YxQJTaJKtO6XVnJGz1K1iGnMtyPF5jseIVSKMFlyjlqOMCFirMX
 mJ3kNysnY9VjOfR/Z4T191ORFvbVSNnNqJRB1MX8sNDP3Xf7OZNx6mgr8S0Dq0DH0iZ0gP9qBNR
 61ph0PO66Z2VN9grDtxUoC/z3VD/UZrnPL6FIOqThKCczD0JvgnULIAE81Y7kyZSwCstRgSB9Mi
 LTv2aGHv4Gk2hvw2GZ2e3HiddmlRg=
X-Received: by 2002:a05:600c:3ba5:b0:412:f979:587b with SMTP id
 n37-20020a05600c3ba500b00412f979587bmr3388006wms.17.1709831968560; 
 Thu, 07 Mar 2024 09:19:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH4SndGG4a9Ag9uhYoR6/XgpnNeIB+wrCsvNQQTrgzg8dfWY1F/NzB3kmNSH4on5Pedt2+QFyr+40JYPvoti4=
X-Received: by 2002:a05:600c:3ba5:b0:412:f979:587b with SMTP id
 n37-20020a05600c3ba500b00412f979587bmr3387988wms.17.1709831968221; Thu, 07
 Mar 2024 09:19:28 -0800 (PST)
MIME-Version: 1.0
References: <20240307114744.1135711-1-ppandit@redhat.com>
 <ZenGQZE4hlOR6J4V@redhat.com>
In-Reply-To: <ZenGQZE4hlOR6J4V@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 7 Mar 2024 22:49:11 +0530
Message-ID: <CAE8KmOzQVFrK3kh6M3-TAm_=hsGB7KP+wjN8synRotd68A_O-Q@mail.gmail.com>
Subject: Re: [PATCH] linux-aio: add IO_CMD_FDSYNC command support
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

On Thu, 7 Mar 2024 at 19:21, Kevin Wolf <kwolf@redhat.com> wrote:
> Kernel support for this is "relatively" new, added in 2018. Should we
> fall back to the thread pool if we receive -EINVAL?

laio_co_submit
  laio_do_submit
    ioq_submit
      io_submit

* When an aio operation is not supported by the kernel, io_submit()
call would return '-EINVAL', indicating that the specified (_FDSYNC)
operation is invalid for the file descriptor. ie. an error (-EINVAL)
needs to reach the 'laio_co_submit' routine above, to make its caller
fall back on the thread-pool functionality as default.

* Strangely the 'ioq_submit' routine above ignores the return value
from io_submit and returns void. I think we need to change that to be
able to fall back on the thread-pool functionality. I'll try to see if
such a change works as expected. Please let me know if there's another
way to fix this.

Thank you.
---
  - Prasad


