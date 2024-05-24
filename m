Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B7EC25B7D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 10:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sASX6-0006hF-V3; Fri, 24 May 2024 06:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sASWz-0006aS-TK
 for qemu-devel@nongnu.org; Fri, 24 May 2024 06:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sASWy-0007gp-7y
 for qemu-devel@nongnu.org; Fri, 24 May 2024 06:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716547931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HOXliB5ia07tz3pxdjbnnoak2gShZc7/83V5Pn1UrGw=;
 b=Usd76OjY9ygudhTMdUkAJiMoeYhrl96FbvkV0oh3ESHUuBfm3X+DxVc4tGMEN2HAQM8qnx
 84toHARV+JEEGFEl2EpMoL4YfXwnwuD/wN8h042mJduNc+jdUwLhcIRYc1QWBgaaHQOl0y
 pm6vtuDHIjFuhqDMiWWQoi4LFtnmEV4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-iVCXjl1-PISUxQzNLDgovw-1; Fri, 24 May 2024 06:52:10 -0400
X-MC-Unique: iVCXjl1-PISUxQzNLDgovw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-354f75df76dso82816f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 03:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716547929; x=1717152729;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HOXliB5ia07tz3pxdjbnnoak2gShZc7/83V5Pn1UrGw=;
 b=dv8eTtVP/xqPycTDw1U6GUpCgNFBKXXTYjMDhwZwzNBcJZGvfPDR+yZpiS9EETleZ4
 mGorTk7kRlkfpJssjTnVHyF6asf6Aix767MS5IQYkYmrBZyIF/+daP/rO2ZUGbyB+x3c
 7zQMxiWiRbj25Zb6GznpmsITsUj/AHUE4p/t13Li5lTAeA0fABgb22cgOMBt4pyqFdKw
 GfqEiabNMM5B+9rTK+YDmGItYwK/RSMzspV+NKzhi7ox6pREYUl5cuJpj7wJcANFfP11
 Q26d6V7unpJ4/2PKzgNcPIU2FDVc/+B8Izi4QO/2cz+6nAecHYnjxyJXB7FMZYdg5/VO
 BmLQ==
X-Gm-Message-State: AOJu0YzWSQ0085Vck/lth/Is0bNv2FTh2XjZZZcCgUV4cyS+8CAedpyb
 9b1Z1oiCz6BUfbQt1TiFWKaz3Oeje30P6t90XnLTBGkVDzTUYhdJKueBZn024syW+jsTQZ16LAM
 qEKYQKwZxweOgyLwUxItCZuE4JtnJ4hBi4KlchJpVvBkI/PLA1crwLy1N77T9O0TMGNtGageO3I
 2z1r2RzqhhIJ0YsJZpy42k5O7ksA4=
X-Received: by 2002:adf:ffc8:0:b0:355:1759:db18 with SMTP id
 ffacd0b85a97d-35526c37e21mr1988282f8f.29.1716547928964; 
 Fri, 24 May 2024 03:52:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbt7olHpq5GHMGAi4Yqb2Sobe0hjG67S8H6J+jZi19rBQq0Qpx0d5HXfepjKdaMQHKN13QYpfrl0RXT3gV5j0=
X-Received: by 2002:adf:ffc8:0:b0:355:1759:db18 with SMTP id
 ffacd0b85a97d-35526c37e21mr1988264f8f.29.1716547928669; Fri, 24 May 2024
 03:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-2-farosas@suse.de>
In-Reply-To: <20240523190548.23977-2-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 24 May 2024 16:21:52 +0530
Message-ID: <CAE8KmOw7yULgf9hstkYL+E+azpG7RRhj_eGMMDeZK4qvcuLv0g@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] migration: Fix file migration with fdset
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, 
 Peter Xu <peterx@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Jim Fehlig <jfehlig@suse.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 24 May 2024 at 00:38, Fabiano Rosas <farosas@suse.de> wrote:
> This is further indicated by the presence of the 'offset'
> argument, which indicates the start of the region where QEMU is
> allowed to write.
>
> Fix the issue by replacing the O_TRUNC flag on open by an ftruncate
> call, which will take the offset into consideration.
>
> +    if (ftruncate(fioc->fd, offset)) {
> +        error_setg_errno(errp, errno,
> +                         "failed to truncate migration file to offset %" PRIx64,
> +                         offset);
> +        object_unref(OBJECT(fioc));
> +        return;
> +    }
> +

* Should 'offset' be checked for > zero while ftruncating? Else it'll
be same as O_TRUNC. Otherwise it looks fine.

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


