Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB67ACCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 08:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5gHF-0004Ft-Ox; Mon, 06 Oct 2025 04:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1v5gHC-0004FR-DG
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 04:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1v5gH9-0007MS-Bm
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 04:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759738132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iBAKB/WMDUohDrw8hUiKctvrSeJ2P8HJbxYH7OJO0Ds=;
 b=grQ3jkfCNAe/4oomPezEXUuxpW74TQcEzRaXU5oDPqN/I7mQH1RdAKknnBDFHQcFhxbR0G
 jS/5M/C/J65YLwO0aZTRuKxAjWhOOAzCjKcivaVL5tu1k+BE7uOp40CciVw618+Ss8Mufu
 7u/hE25F2EKmk2ip8y9e3EYmOQ8kxGY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-ScjDW1X8P7iVHsjLMXfisw-1; Mon, 06 Oct 2025 04:08:51 -0400
X-MC-Unique: ScjDW1X8P7iVHsjLMXfisw-1
X-Mimecast-MFC-AGG-ID: ScjDW1X8P7iVHsjLMXfisw_1759738131
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4e0fcbf8eb0so113127001cf.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 01:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759738131; x=1760342931;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iBAKB/WMDUohDrw8hUiKctvrSeJ2P8HJbxYH7OJO0Ds=;
 b=Tm3yqSEGnm3kjrHfpwQhfmu0Ipq7U4EqpE7SQMa7UVQQIRpfraLq2u/CGG/rfxTO0l
 S1V8nS3BglDhzp152sfZtYSDf03pMnAU+YsHl7Am7x9xudT8wGU7Mshi2h+Sz17407k4
 tbZ5umHqKRllvJYTHIQLzhDy9DSlg6wHaRkcJSY3uAbY2LsFO4aE5+dJ/lTYmyozVjvm
 d1fQzQ+13cDwx/7v5qGSXdU/21bTO2VlPWSI6hhErUwukKK438y7KXqLxXKwuWpBe2Wq
 lig4uWMZXCPAepq0hIhrNCRQFRxEMQOmgWY05ntiVwcVSiFRvH1FVEGmdCdqHt8sd5WY
 On0w==
X-Gm-Message-State: AOJu0Ywr65mTYD5nNjdSUcOF+b0yKHVCo1IbkOvEP2Ld+VdiYW9eksK6
 p+Iek8YKCu6smKbDPKtxIU1YHMvRbJY1uC1X7g8C/0W+SZxdZ9SKpBC75CUsra2IEGWlEparlws
 n06o0FlhIrU7gZJ9+B2kBI5YqJvPdf6tebZPwAUUKMkEyBESk7jj+xJb3WVjQcRPg0P3gwMPN5z
 GZZwpA7dqjW9QjnYchIAXQLasFaDoxi5A=
X-Gm-Gg: ASbGncslX+MQCPONY3kNdqtnCscmOFnBTMs4nYeHFUWMk2693S0SHMnumw9GsUHqb1m
 Dr+69hHP7D7thL+QUEnu4DTWrqT2fAkReEWCZgAfs1HoYPT8Z0icXG/ojksguTmVKHr3Y6utGaq
 fyQj2XXM5eZ2SxhmwfVuDfQUyS5Tw=
X-Received: by 2002:a05:622a:1346:b0:4b1:103b:bb6b with SMTP id
 d75a77b69052e-4e576b14ec2mr128332631cf.61.1759738130581; 
 Mon, 06 Oct 2025 01:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM29w/6KFD9lmju+CoIPYqKNM5J0mquGfrseDCFKYS0WshCURDZshgMP5eOxjKeIQpO7J7zYgYoj7pvkeY0UY=
X-Received: by 2002:a05:622a:1346:b0:4b1:103b:bb6b with SMTP id
 d75a77b69052e-4e576b14ec2mr128332341cf.61.1759738129759; Mon, 06 Oct 2025
 01:08:49 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Oct 2025 01:08:48 -0700
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Oct 2025 01:08:48 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <20250910121501.676219-1-abologna@redhat.com>
 <5893cfcf-a23b-41f9-a8db-dbd2c5e15fcb@tls.msk.ru>
MIME-Version: 1.0
In-Reply-To: <5893cfcf-a23b-41f9-a8db-dbd2c5e15fcb@tls.msk.ru>
Date: Mon, 6 Oct 2025 01:08:48 -0700
X-Gm-Features: AS18NWAX1cjlwKcw7P2_U0nbuRTcUaD48zboipLq626FTydZ0Gd9X9lv4qM2F70
Message-ID: <CABJz62OFH4YjpxuHrS8SBjz9Ts03WH7foy_E4+o0SwW77OkQyw@mail.gmail.com>
Subject: Re: [PATCH] docs/interop/firmware: Add riscv64 to FirmwareArchitecture
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Oct 04, 2025 at 10:03:45AM +0300, Michael Tokarev wrote:
> On 9/10/25 15:15, Andrea Bolognani wrote:
> > Descriptors using this value have been shipped for years
> > by distros, so we just need to update the spec to match
> > reality.
>
> Hm.  Probably to my shame, I never shipped this file in
> debian/ubuntu - neither the updated one nor the original,
> and have no idea what it is used for :)
>
> What's the context where it's used?

I don't think the file is used directly. It just defines what
firmware descriptors (shipped by edk2 and other firmware packages)
should look like.

> BTW, should I perhaps pick this change up to qemu-stable
> too?

No harm in doing that, but I would say it's unnecessary.

-- 
Andrea Bolognani / Red Hat / Virtualization


