Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC175C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 04:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rce06-0003Vy-JH; Tue, 20 Feb 2024 23:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rce05-0003Vj-7E
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 23:14:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rce03-0002g2-Py
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 23:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708488866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tPjQ2PYeT22Sg8KrAmsvMc0tPq2PUn8ulGtZZiVX/tQ=;
 b=HkIjxcjf8udQjeCYOvxvw5kQGSdDSp3ccJ7FBmwpUk7ltoB4dIp3g1JDBOyba1au4vrW8k
 22ht8pNVuGX8jquw5ygUJvCyxo4KP5moiucUC20JvvFuuZfHIoA5yrdvF1zxge1md3ENeC
 mQ3KTTOVUus4FA4QiIVhNkfnQdcPl6E=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-rMA2Ll5zNiKfM9NE0YxOtA-1; Tue, 20 Feb 2024 23:14:24 -0500
X-MC-Unique: rMA2Ll5zNiKfM9NE0YxOtA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-29a16254a66so78906a91.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 20:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708488863; x=1709093663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tPjQ2PYeT22Sg8KrAmsvMc0tPq2PUn8ulGtZZiVX/tQ=;
 b=oDVGhdYVvpA2GI7IYHWC+V7FijnGes8DBu5NZagtHPhMQWHIEe0LPmdCxvqvyUs4Sz
 pB4+Y9J3ZVvbxs05zNDg6/od8nzuWvWvzfDj1hRANJEGqIToLYqleReDfWRgaSTsmqq0
 FdHBig+1R36czRHdGTyk5BubrQNrEQaXjldNYGLnnRnd35FOYZdDpEdL0jm4hUXdr907
 2LGY1x5Ye8eZVguaOOtlNDc/ApRPlLR3eNhlEPDK/LSk0hy4OYDQ8ptLsN8wO5+e5JCa
 FgQB7EBYAse5JX9sojVqU/7IBh6J52L0XSyWFt7TYgV/5qUAzjgxdw7Ykz9JCrC4Eyi5
 Dl4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHhEdcEdCssk6M2nDYrw4PPZ6ZL0xNLWBkedI5jwFY+IYHzOZPNUYtFvS+HtBmi429HexeamfTK0yX2p5s0zbZA8bzHvA=
X-Gm-Message-State: AOJu0YzYzMHp7S06zt8e6dtjT1CtCWwj0SSrkqg3v0C5mNwa55FCpwPH
 EF6tjGbUiPseQzsr8MJSingr2ISFjFPQs7RwIu5biAK7HYkrStc7O6N3jbTJrVmga6DFRv+lmXc
 bydJE8CSvXzhoouwYdtTNNT4/uUX2UCXwKlouyHCeTxIRkV0hug22
X-Received: by 2002:a17:90a:6d24:b0:299:dddb:3a92 with SMTP id
 z33-20020a17090a6d2400b00299dddb3a92mr3462694pjj.1.1708488863227; 
 Tue, 20 Feb 2024 20:14:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsTXx36jIxpl/xRs07Y1I4iGYUFyl1D9t+I/RTnt4sBqIG28A2ARVs0UyEG+2m/9rmPf7OZw==
X-Received: by 2002:a17:90a:6d24:b0:299:dddb:3a92 with SMTP id
 z33-20020a17090a6d2400b00299dddb3a92mr3462683pjj.1.1708488862899; 
 Tue, 20 Feb 2024 20:14:22 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 qj15-20020a17090b28cf00b002961a383303sm532509pjb.14.2024.02.20.20.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 20:14:22 -0800 (PST)
Date: Wed, 21 Feb 2024 12:14:11 +0800
From: Peter Xu <peterx@redhat.com>
To: maobibo <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 5/5] tests: Add migration test for loongarch64
Message-ID: <ZdV4k4rckpV7bjRx@x1n>
References: <20240220124126.1164081-1-maobibo@loongson.cn>
 <20240220124126.1164081-6-maobibo@loongson.cn>
 <ZdVnmiT94SciVNBn@x1n>
 <2c298d69-f7d2-829f-c700-e6d6e1f86080@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c298d69-f7d2-829f-c700-e6d6e1f86080@loongson.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Feb 21, 2024 at 11:47:27AM +0800, maobibo wrote:
> Now loongarch virt machine type is not full-featured, it will be long-term
> issue to keep compatible ability access different qemu versions or kernel
> versions. It is a big challenge for us, now the main purpose of migration
> test is that it can check whether modification with kvm mmu part is correct
> or not.

That's fine then.  Feel free to pick this patch up through the loongarch64
branch when ready.  Thanks.

-- 
Peter Xu


