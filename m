Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E417C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 12:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZqT0-0000Jb-PH; Thu, 10 Jul 2025 08:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZqSy-0000Bw-FB
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:33:32 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZqSw-0007QM-1v
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:33:32 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7176c66e99cso10098437b3.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 05:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752150808; x=1752755608; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Otedy5+cyDaimCV6qRHVcBbOwuz1PhwjpZz7f2pmIJg=;
 b=vfKzYGHZ4S95FY7+NhLALZ2LyzF4BYE2YMg4eFJNGJaRwocs164VkwX62q0GGFq/mL
 WULJzDNc6na4PspCUwV89v0NwOJxagtZzgUnF5a4l2N7yhZqguJzIjNo4yZn4il5Wb66
 U6mFpbGuet0AxAtS6hcxfMFFdIsPkChwYprIor5CxnTUpg8h0v85tg9D29q/bt9z7Fps
 FZN2axmds9By7D+x9hewVyMuICAGT/oxrZaVuQ6lN2Bh0UHyZQwgdGEu5rMSHpmWYqgR
 fExgDyLF1C1q/YpdihZf7HI4rtdGo5FDkijy5Lid6PbIK55xdJRD1xOtuhjWuDmhcCyh
 jM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752150808; x=1752755608;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Otedy5+cyDaimCV6qRHVcBbOwuz1PhwjpZz7f2pmIJg=;
 b=BCGc8dpgp31tx/nOXyZ7pFLO4FsEF2SeLtiyR+SYfzJI2j2a1gutr2+GOtd8qucw3g
 SG3sxOITgUWQczWu8qvs4xniNJqZa/FwTWI105m019UWWrtqzFIVXuBDaZKiq1N3YioI
 fq/kKFdYX6o9F7WzKvOiC4z9LLyBMyc8+jNkb9fynU6Dug7BCqjUfp8LOKVGASGKobDy
 1Gl68HdntDdaFEe7pCBB/oA6QlriVA7jb/uW9kOacsihlcoEivd+YwJ4+nrRTT2lDi8K
 bKJzbmJxp5oFQABVZ9bVROwla6jvEObGl3+YlrhIvk/HXniFna8f8GGMXTj+hmlnwjr5
 rNtA==
X-Gm-Message-State: AOJu0Yxx/zDTlElttapS9MBdUo4q/0Kc5oDPJOXaYLzmMCi6bqeLW/Ia
 JGHtPrC7g6YcdRUS8xvpHa2cOvN4oBwATzlqB+QFL+DR1pc9buvzSLsDHNP4njl0mHLs32T3i8h
 9+enOaP/DZPpOsqbzpd5ZtcgwvnRln29TkZFOmFSLGQ==
X-Gm-Gg: ASbGnctyUykMxJmbsydwjvMimBv8+2CoUEWhgdPfaCCoBd+dcutzm8XPYmRIZTRbUh+
 WExp6YTkU9igKj/sXwfzSoxCMO4Kw2DbYntk9zhG/LthCIWkUs6WVp3ZcIs/NxBjcFBTayX9K1D
 XvqKWubTmQCTPQXsBtWNlO2LjbnPkanN573ii0Lada0aGp
X-Google-Smtp-Source: AGHT+IE6qyW6EFU6fmrMrJ5zT8AEdI8YW8rDBvyQZ2e/3TKHCRMHrUHEmVJcMjnfWC9dfTLV05UZOe0P9TS0SswmECM=
X-Received: by 2002:a05:690c:6602:b0:70e:6333:64ac with SMTP id
 00721157ae682-717c4656a02mr33542557b3.10.1752150808298; Thu, 10 Jul 2025
 05:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250626074529.1384114-1-clg@redhat.com>
 <20250626074529.1384114-9-clg@redhat.com>
In-Reply-To: <20250626074529.1384114-9-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 13:33:17 +0100
X-Gm-Features: Ac12FXw7Qo8VP6e3lulPDO4p0YKbY_5LRISt2NyN_VSuMWFLtLVccm-XGNJTfQ8
Message-ID: <CAFEAcA9qtR40k6KAiMk2ij4kArVSdLJAH+zRVnTxaVOhOYr1jw@mail.gmail.com>
Subject: Re: [PULL 08/25] vfio-user: connect vfio proxy to remote server
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 John Levon <john.levon@nutanix.com>, John Johnson <john.g.johnson@oracle.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 26 Jun 2025 at 08:51, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> From: John Levon <john.levon@nutanix.com>
>
> Introduce the vfio-user "proxy": this is the client code responsible for
> sending and receiving vfio-user messages across the control socket.
>
> The new files hw/vfio-user/proxy.[ch] contain some basic plumbing for
> managing the proxy; initialize the proxy during realization of the
> VFIOUserPCIDevice instance.

Hi; Coverity points out an issue with this code (CID 1611806):

> +void vfio_user_disconnect(VFIOUserProxy *proxy)
> +{
> +    VFIOUserMsg *r1, *r2;
> +
> +    qemu_mutex_lock(&proxy->lock);

[...]

> +    /*
> +     * Make sure the iothread isn't blocking anywhere
> +     * with a ref to this proxy by waiting for a BH
> +     * handler to run after the proxy fd handlers were
> +     * deleted above.
> +     */
> +    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_cb, proxy);
> +    qemu_cond_wait(&proxy->close_cv, &proxy->lock);

qemu_cond_wait() has essentially the same semantics as
pthread_cond_wait(), for which it is a wrapper.
pthread_cond_wait() is allowed to wake up spuriously, so
any use of it must be in a loop that checks for whatever
the actual thing you were waiting for was:
  while (something) {
      qemu_cond_wait(...);
  }

What is the condition this code should be checking ?

thanks
-- PMM

