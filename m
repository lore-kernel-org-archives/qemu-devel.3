Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FE3C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 07:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp0LC-0000kO-DA; Mon, 03 Mar 2025 02:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tp0LA-0000jy-J8
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 02:35:52 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tp0L8-0001xR-NX
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 02:35:52 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e5491eb37dso1203722a12.0
 for <qemu-devel@nongnu.org>; Sun, 02 Mar 2025 23:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740987349; x=1741592149; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2RilEHcR8+9/PvFTn64OzknuBBMJY6yz4dKNbK2z4g=;
 b=LlK4xM/7e8e6dAwLIdCNgz7AmwfcN8PAKbttcJbh/gYuAmwEh8KBrdln5/iTxfWlK7
 9HPUnHx7pvF5wUh4xpOcKDOfvaDuBY3CP37JeOsCM0SxskgroJ97R9F3pQ4qOsYRiatJ
 SMhWKecTJJQEtB1VU4RU8P0BdwoAf5IASwHhGvRHNI0iFMLDXhlG6VWK5aklQBGW3Mf9
 jYCXOZM9/6R1Yth+ufuz7lXlvZ39881H2C2Q3fU5XKjQfNmhnpjvWydcyC4DGnq3DiVm
 pb+5lK8ABLNIdjz42PLnRDPazmdHd8MNT8hGvyn9ouC44kTb9dgmvueqYxu4w4uJmNLO
 QYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740987349; x=1741592149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2RilEHcR8+9/PvFTn64OzknuBBMJY6yz4dKNbK2z4g=;
 b=dOvyevNi3b7RDOyUYABPzzSe9ZGg5zE2mkr7xZvXalHPQDbLlpxqadwUjhDpZLWDmk
 1ewhL5ihJLsCe9xahijUb78m657JiNgl2dkR4B8dAOzP4rzmpMzL8afUK0F6BSrZvr0X
 g82I1Wirv630uz0jnXheGnr/1W4dZFgiIYkpwsmfrTCiiGZEmZPC7F+uOCbxTGKxWTiQ
 1z7zJtYUfMSvrQV6Wpe9YTX+D4tsOkeQ75QorvVFb5y4BaAd30fDQHcaFqRtwckTf//P
 ajp8yZbSQyY5aBovDMhWiilO34EW3EzwmqknnMFi3RQ1hWRh0yrJn4CfgusAf/y8y9Gy
 uLMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeVaebJS/FAp5xxIuiClatClvZuIKHZGvO0bdkntLdvU/Ns+1nGt8nJbADVZ/hEiuyuJgtE3hyaXCB@nongnu.org
X-Gm-Message-State: AOJu0YxFQiUovAXEFTE+ssDP54qi3obTTyM7wTtPsmGzTFlkJGpb3iEI
 TkB8Mdj8CJTw0r1JtyTn+hiiyVUBAPHI4hgQ5BN0Lxu61fuu8N9iloe2b0ujiks11qm+Yi53l5s
 q32QkloCtRnM+Kjm7GaOG6LeROSw=
X-Gm-Gg: ASbGncvrFnYI8NDgGsl/US0SuBqi8qO+l9g2zW1L9qog3j/GbiW7MeNvV2b+vMxvgvS
 cqNQ9d0+rZ1ZJLC8caQ+6PJRdk1pGRTImkWF9fAt6hBxVsm5qcr/YvEdYLHgDi6GvwBVnbY+9Gi
 6jR1Rv4awXzEmKjuHc/TFGpSY3nw==
X-Google-Smtp-Source: AGHT+IGIOZ90Y+RtfUg60xFZv4hxYS+qnWh4qZim7Vo6Gjy3ugiAUoa3e2XX4ThgjjoP9CRasxC6em7MKn0LBDimx90=
X-Received: by 2002:a05:6402:3221:b0:5e5:49af:411d with SMTP id
 4fb4d7f45d1cf-5e549af47f8mr3208887a12.17.1740987348894; Sun, 02 Mar 2025
 23:35:48 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QUk77GViTBgBpfYH-AbAmQ5aUwi0K6UTH9iv=1mVb0Wbw@mail.gmail.com>
 <803732f6-6ab1-4298-a956-660496664f67@redhat.com>
In-Reply-To: <803732f6-6ab1-4298-a956-660496664f67@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 3 Mar 2025 15:35:36 +0800
X-Gm-Features: AQ5f1JoyudKm91henuN7YkbcZtqcO5U4HuDEOXET3vDSkFiaWr_tAKUKi6upnkY
Message-ID: <CAJSP0QUN_tCSZ=WOk+C9kR3TMqkTaZMNF7qaAsFPiauzN0r_QA@mail.gmail.com>
Subject: Re: Kubernetes gitlab-runner jobs cannot be scheduled
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Camilla Conte <cconte@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sat, Mar 1, 2025 at 2:36=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> On 3/1/25 07:19, Stefan Hajnoczi wrote:
> > Hi,
> > On February 26th GitLab CI started failing many jobs because they
> > could not be scheduled. I've been unable to merge pull requests
> > because the CI is not working.
> >
> > Here is an example failed job:
> > https://gitlab.com/qemu-project/qemu/-/jobs/9281757413
>
> Hi Stefan,
>
> until February 26th the Digital Ocean runners were not enabled; I tried
> enabling them (which is what caused the issue) to start gauging how much
> credit we would need to be able to move from Azure to DO for CI.  I
> posted a note on IRC, I'm sorry if you missed that.

There is a new type of timeout failure:
https://gitlab.com/qemu-project/qemu/-/jobs/9288349332

GitLab says:
"There has been a timeout failure or the job got stuck. Check your
timeout limits or try again"

Duration: 77 minutes 13 seconds
Timeout: 1h (from project)

It ran 17 minutes longer than the job timeout.

Any idea?

Stefan

