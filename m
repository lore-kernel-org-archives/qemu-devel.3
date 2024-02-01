Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65ADC47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 05:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVPtd-0004uw-Jf; Thu, 01 Feb 2024 00:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rVPtc-0004ud-7h
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 00:45:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rVPta-0006PV-Jg
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 00:45:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706766353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwmNk96nNmOhzgSRS5Oifn1NWwiXH8LxKvnwoJR5/uk=;
 b=buFUBqx3MJ9A+w+xl+SP46ZFN4NtGAtzv709v71tRZPQG6z1k//1xa/9aUT1LMNAZgAA9A
 C4uFytlibkrSdVNaPV6qUr++Mk0Yabe2PJcxdMFkUnzqX1VOiQebICGr26p9kD6PyPmeKa
 WBvBu93swvlgD/OvTRnvdsY2wjUu42w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-qI8l7zxYO8mHslfHBGXm8g-1; Thu, 01 Feb 2024 00:45:52 -0500
X-MC-Unique: qI8l7zxYO8mHslfHBGXm8g-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29608f00cbbso457239a91.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 21:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706766351; x=1707371151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwmNk96nNmOhzgSRS5Oifn1NWwiXH8LxKvnwoJR5/uk=;
 b=MENoAC1gc7yWJVvfKHg1EGaRV6ZsAiLsM1ZtJfslgbiEA/yTUPY3gFfY8KS+eP0rUo
 jpfILQOs5SSAJmWsk/oEXitSjPLY4m9Kx6zvUVq2JKi8J/GlUyf3Tr7sj9EotYlrTqYY
 JPF+WgF5CM2558QEujWXUkReHq37zWmsUBdEv2W1xDJtP28XLngUV1B1Anqzk3n7MRXw
 s578aOuNL8pAI806hElA3EOK/h80lwfb0siwE0A8mOd6f3i1iiC+cX+ve/awzXzjiKbc
 vJYQ99Fnrp2iun/pSiwCl2kHIZciTNcq8YoSXe7+L8QW6SSnE5mM9wrX52g57Cx1JyTj
 XVAw==
X-Gm-Message-State: AOJu0YzaJJucv2ic4t+dt9wNiWjqhbmA7j6Yv4qOFFvnqVwaGl3/rVAP
 Qu0M9wlTMw5gRRMeZx1h3MNGlnIKfF5CelvhYh2cXkijlUCTA1bfX1EtvW1bqFaPnNjtKA6u8/V
 FDi1rMxPR/v5UCb2PLomJxplU0rOHXzBxsm8YN9M0MGcbzDaEgr8Wg6ANwhC8uAg/O7NFcLS0Wc
 KDbrZA4xFTqXYDr70I4L6X9Y5H90M=
X-Received: by 2002:a17:90a:f689:b0:295:f5da:a8d8 with SMTP id
 cl9-20020a17090af68900b00295f5daa8d8mr2877678pjb.11.1706766351057; 
 Wed, 31 Jan 2024 21:45:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEd0Z+g61MzsPoZRZkBCtd86jx+Dx4r8RJnNiDKu/H3J6kInnZV7gbYvN/MQV94OEgHmsayZTt3YThzHYQJRQg=
X-Received: by 2002:a17:90a:f689:b0:295:f5da:a8d8 with SMTP id
 cl9-20020a17090af68900b00295f5daa8d8mr2877671pjb.11.1706766350839; Wed, 31
 Jan 2024 21:45:50 -0800 (PST)
MIME-Version: 1.0
References: <20240124104006.335166-1-lvivier@redhat.com>
In-Reply-To: <20240124104006.335166-1-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Feb 2024 13:45:39 +0800
Message-ID: <CACGkMEtzqCA_x1hg-ddp0d-Q-+XLH01k2Pf0KziiYSeLmDwaXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] e1000e: fix link state on resume
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jan 24, 2024 at 6:40=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:
>
> On resume e1000e_vm_state_change() always calls e1000e_autoneg_resume()
> that sets link_down to false, and thus activates the link even
> if we have disabled it.
>
> The problem can be reproduced starting qemu in paused state (-S) and
> then set the link to down. When we resume the machine the link appears
> to be up.
>
> Reproducer:
>
>    # qemu-system-x86_64 ... -device e1000e,netdev=3Dnetdev0,id=3Dnet0 -S
>
>    {"execute": "qmp_capabilities" }
>    {"execute": "set_link", "arguments": {"name": "net0", "up": false}}
>    {"execute": "cont" }
>
> To fix the problem, merge the content of e1000e_vm_state_change()
> into e1000e_core_post_load() as e1000 does.
>
> Buglink: https://issues.redhat.com/browse/RHEL-21867
> Fixes: 6f3fbe4ed06a ("net: Introduce e1000e device emulation")
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>

I've queued this.

Thanks


