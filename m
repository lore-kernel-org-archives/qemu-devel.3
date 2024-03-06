Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2B2C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 20:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhxV4-0006Xt-9Y; Wed, 06 Mar 2024 15:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rhxV2-0006XP-3f
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:04:24 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rhxUx-0007Kx-U4
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:04:23 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6e5027608a9so80535a34.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 12:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709755458; x=1710360258; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iroqX7Bbaz9mpJpRO8he7rH6TWj+86PBVrUrlNXUp2E=;
 b=Igv92Uxi7Tach7pK68ofG+25jLJk1YwNhYkV3a9Zr+q0CaCzQd+Sz16El0Z8hardI1
 WTodGb/11KdrizZOW407YQDJKXd4Tt1mywVfth+rtPlWakfYDacjUt3ulozDCO/JTYsg
 ZDOKJbBGk3ICi94hXudgMcs2Ykenerx9Q82+vNPD9oM+GExtqbOROxw67eKl+64r8rZJ
 rYQQG+Ba+etkBYCc/AdrK0DWM4Mkc4PQ3e/2zDe/dTSh+SjIv2mX+SCHVPSTvQELPy7a
 drktxsZJdRtK5jGRoX1QZnBo8KrbXakxbOlYyy6Ye7x6Q21smFDbe6aCVmxtcF1Bxv6s
 8FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709755458; x=1710360258;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iroqX7Bbaz9mpJpRO8he7rH6TWj+86PBVrUrlNXUp2E=;
 b=lblWCZkSSDxyCAIQ+8bBmyQmYTi6l7W/a9repaGTdA0VykCx4aJJ6iV9tnYZDBz9bu
 eUzC8UzaJRxrvRnIs6HDrX9lUEUXfFCgrQRFYjO1gxwfJPXwvXbJpr0VU1GRjRV4zLTV
 3N/DAG/jSmVJBVG1Z6BVyVekhwSegvycI9bUBsL1R6a75rHNn0bQAk27rW4+sU6BAHJf
 vu0kBHp6MB87V4O7QdQjDn74YCrS/wGSY/a/E78LZcK61QNliHNJSwqylDrJY8kEmWuK
 HM/Gt7h9KETcqCuWx5CwR4UPVjw8f0so27/CQ4zDFje5+Qm/OnnOvimib6OAMmrAfWQq
 /umQ==
X-Gm-Message-State: AOJu0YytBytDK+qa/+O5WcVlEMsrgYvW1jGAutu+u2LJMDXIgPlonRT6
 TG2DJprRRZCo2eM/El1vsVXLgcbpvV/BNH0NP4vC6k2z5I0xK/xoQJ1emOZCaUxdXSXqeQdY3Po
 dV00xUuj9PWEvRE76OQJgcp5RXck=
X-Google-Smtp-Source: AGHT+IGt6hbSaxdNwDLiiw7xJW7HAwABHnxW+osg9bKJsBUDBiHm6SVmp+B4BihqgeUDFdc19htpUBkStKrAzWhOFAQ=
X-Received: by 2002:a05:6870:d28b:b0:220:c9cd:b2b6 with SMTP id
 d11-20020a056870d28b00b00220c9cdb2b6mr6765208oae.14.1709755458187; Wed, 06
 Mar 2024 12:04:18 -0800 (PST)
MIME-Version: 1.0
References: <2048170974.2556839.1709754757016@webmail.strato.de>
In-Reply-To: <2048170974.2556839.1709754757016@webmail.strato.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 6 Mar 2024 15:04:05 -0500
Message-ID: <CAJSP0QWcE=SxYqFKj8XiGJgwSK40M9HZzAEAsvhNrTJWNR8T1A@mail.gmail.com>
Subject: Re: no target for a link in the post "How to access libvirt domains
 in KubeVirt"
To: info@maximka.de
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 6 Mar 2024 at 14:52, <info@maximka.de> wrote:
>
> Hello, thank you for the post.
>
> The href in the link
> <a href="https://kubevirt.io/user-guide/debug_virt_stack/">Virtualization Debugging</a>
>
> should be replaced by
> https://kubevirt.io/user-guide/debug_virt_stack/logging/

Hi Alexei,
Thanks for pointing out the broken link! The blog post has been updated.

Stefan

