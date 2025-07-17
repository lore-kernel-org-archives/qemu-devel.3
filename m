Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4965CC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 19:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucUYc-0003zx-2j; Thu, 17 Jul 2025 15:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucRzi-0003yn-Mf
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 13:02:12 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucRzY-0001Fg-QU
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 13:01:59 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-70f862dbeaeso12185717b3.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752771714; x=1753376514; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ub39l2dQ71LYNt6PgO4S8d/6RMMH3mqe1xUAkmld2Dc=;
 b=e17XayxVQy/gWsVKi6K4XabSToAHUS2AkTgh9I6eu6E5LWLacTFzeArBgX6TYir4uW
 VDK5UR7TTn3rH3e58dtGJNSp2aQ6LMIkKse57fM8hbcCwEnK3TPC7XugcViotsnK2kqZ
 fjgPdRwPuOwOs3dOn7NHEJPJyv1sSm3I6KapG95at1QAAR31C1pwVJedAzbWUsncsQMj
 9HNEU5sqX1Ar9qzQzMPO6azdw1RluANGOyV2Gn6We2YXY9tHm5o3SZn1VZc4OWbFJQG/
 wUwljTaN8fHNjPqYDC7IoKEfPRr2WOuQA2NrkFEfhLJIkV3lZBM2nPZV+1rhzSnHdDwv
 9Qog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752771714; x=1753376514;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ub39l2dQ71LYNt6PgO4S8d/6RMMH3mqe1xUAkmld2Dc=;
 b=sGDKtMbbMILQCFJO+1pdkuwVvNBIDGPHVLYq7YkReXVjDaqY1EI37Dmldz96UzDPUs
 YeHGx6aAFuXOE2djHU9d74rhfptwa5sOqrOw3RJ4pFsW8lT/vtnQMTYHY4r1bIrZn6zC
 FqywvAkOPMMRu8gScUvreh28dpPzRn5spKR8kQSO4nlwu/1syae41fwneTe5OZfRqvP1
 +3WWvz/3kMIFl7+j+i4tEfQf0eVgPYoeOXuwZOf7Nx3wqSOD9pmKEDpuiD47q72glovi
 ij3S42Av/IqaiC8Agtt19xQsnhlzVXN5eBOopYwhBfrxXtWA8QN+l5tRRSIoFB5UvmoC
 hdTA==
X-Gm-Message-State: AOJu0YzUqrAwC24WlvOAbJu0aCI9wxAuqMwUpGP5WdySTY1WydWh6weD
 B/nvtAWO3Ukibj4/RFBMaztOI8MWrqcgav8nhG54JSNck+xCNEMl5y/VxUBvMUenhrtdlLvb1Gj
 jjBYENQlrfoCvaGgveKkr4o8GVQJR69EqocKIf+9Ppg==
X-Gm-Gg: ASbGnctsRaDKWbzoM6e8zFZxJc1NtjSfUeG7DrjqHNQu+5gz4jKscp/iIYqC4keUVAQ
 4qWFn31+z1VJSMvdWIvH+k/sFhMOErB4m3pR+ZX4ATdWEGH/josgV25fWzoT1M+mq1Rte6Z4caj
 yjUSu3blXeZTw2Kkaor6OBaKZikUTa1zQjCWXuXNw1O2l9maEpAS19fARou9FPlDQaikvv78pJN
 ZGgmtIw
X-Google-Smtp-Source: AGHT+IGmIG3CZuJ/cVKUhqKgqlqwq0GtJvMoiKZh2KeZklKX/E0I+VDF/2c+eXsaNFo5P3h0JSVIMg74ZioKVgZcPh8=
X-Received: by 2002:a05:690c:744a:b0:70e:15e7:59e2 with SMTP id
 00721157ae682-7183710a656mr110379947b3.24.1752771714450; Thu, 17 Jul 2025
 10:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250715061904.97540-1-clg@redhat.com>
In-Reply-To: <20250715061904.97540-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jul 2025 18:01:41 +0100
X-Gm-Features: Ac12FXzCCW1o0dT0QiRnSHLHcNAkqfwfNi2EH-Y6isnNU6PCmI8vi9svSefAgoU
Message-ID: <CAFEAcA8B4gh68qYH+NK_G3V+FViTRtCmKLbyayJCbgBqtV1_Qw@mail.gmail.com>
Subject: Re: [PATCH] docs: Fix Aspeed title
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Ed Tanous <etanous@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 15 Jul 2025 at 07:19, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> commit ad8e0e8a0088 removed the "=3D=3D=3D=3D=3D=3D" underlining the file=
 title
> which broke documentation rendering. Add it back.
>
> Fixes: ad8e0e8a0088 ("docs: add support for gb200-bmc")
> Cc: Ed Tanous <etanous@nvidia.com>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---

Thanks for the patch; I'll pick it up via target-arm.next since
I'm doing a pullreq for rc0 anyway.

-- PMM

