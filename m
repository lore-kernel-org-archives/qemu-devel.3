Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BB5E92734
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 15:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaFWl-0001hc-Aj; Mon, 29 Dec 2025 10:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasha.tatashin@soleen.com>)
 id 1vaFWg-0001gu-Cl
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:51:19 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pasha.tatashin@soleen.com>)
 id 1vaFWe-0008Sp-Ir
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:51:18 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64bea6c5819so10501467a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 07:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=soleen.com; s=google; t=1767023472; x=1767628272; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vyxgNppp3bLTAxSLgxErF8h273b+i0nEzk5ipKTf0mI=;
 b=EjvFXDeyB5HiKp4qkBFsTkoWe7IW1NNy+rvXE3yvBdEJYZ/nW6L5WMMby3duTC4UaB
 8owuco3xV5N133HTZO+9+CvR3ynBcUE2r0FSKwYrAYHY3fk1MOQwVmT+C9y4kInBaImf
 7VFK78fXUnkDJVweFmEvgbHyy15Lk16ASIJBYycWnbu5Koxj0yVnZldXrXAelaMsCgj0
 1K0URpZNWW8VwLFoPN0AcO+TXr4fwKV77PsRW2ODH7L1U/F1E02yls67u33AczBjBb9J
 O+B6A4VOyqGzn1qy71Dn5PW6gVErj3TJvxrb9yTPbNMR2iTLlzOdY4pXD3wCjthgKLsu
 3Xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767023472; x=1767628272;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vyxgNppp3bLTAxSLgxErF8h273b+i0nEzk5ipKTf0mI=;
 b=MFAEGW6uOsSaMiKTi3MgHbq0mKCpSBBTFRYTwfdL5Rs82Ewytil4Bcrl5V9Sv1Emj7
 SK3AKjJAuNO03xTv00qe18ajgw7wQE6Ltua9Qb85DpCiWiy9lClaq/MEzQkO27kqgzEz
 FcgB0YWSSPXQYBwwFBp0e8/dHU7opLSbqTZ/A+pgJQtAyzfT8U4yfIXas5+BvF3xKPny
 K21mPslXG6pXd6XvVncdXNlzEVoX1gnQ7GS1lU1aRyoSvCF3yA/wJRqI+EIZW7xLZ+pY
 Cje0tk1W5hk7T69EzXMynM83k4NECjpVnA8OAdys87fQ+6pyPZXnY44YfgsqnjQurk3j
 XIWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2a1OOjCr23N7ZvabLoYlS/azhjMX99ky9uWzFENDpN3vHSGGRZ1GRyS+2cNsj/HC+wasPocfGMzfw@nongnu.org
X-Gm-Message-State: AOJu0Yw2yFPdRIqg0Pqe0ScNzqDFsrEOmfXvG/FJ3OlIdQuOe/MN21Ll
 xbsUOZeak80Tv7dhSY9AZD4HMUNdIpwAwr3xAZUwMU1NBjzQit9BcZIsR9Qfw4tuQPeMcnoPZaC
 yOSfJJZi7dNdGY8X40tY01ffk+7eCfmS7i1AOyjQvjg==
X-Gm-Gg: AY/fxX5N1lQ87c9srjv4E/zZ10wIrNZEsDGM/Vbou2C2Jszp2SBCLEO4dev7YMx4LbV
 R0em/eWYfDVjEfKzjI+LOz98yRv8j/WIABSMZQPPhaq0ZZ1ySHPX+3HgHNIms+ktPdYO8HGtSOH
 Hq9Wv67V/IHzXZW+FTC+pWSvOcU7K2BZ/z0GNOHN1gVDL8Va/v32AJ9W1rrvwOyznfFeiSRY8/W
 7H1SfEX4QEU0NvRAkQhSK1X6RP3cJ/ukTXWrcuIrD0pbmSUCcBVKi+cwj2kadG1vk8UiwnaYjNG
 5WlcbIf8eWFAbGCtYFuERhp/zQ==
X-Google-Smtp-Source: AGHT+IG+b1wnWSJEfejISIA0hSn4AJrzSCgMCaKJvgVT99pxzBKoLWtCcq20QgqOtAL7jfnrkxxMHpdWBhNSywSuFek=
X-Received: by 2002:a17:906:f592:b0:b74:983b:4056 with SMTP id
 a640c23a62f3a-b8036ebf5demr3386997266b.8.1767023472449; Mon, 29 Dec 2025
 07:51:12 -0800 (PST)
MIME-Version: 1.0
References: <20251229120839.89817-1-me@linux.beauty>
In-Reply-To: <20251229120839.89817-1-me@linux.beauty>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 29 Dec 2025 10:50:35 -0500
X-Gm-Features: AQt7F2qC89sdfO8_pxrlmxSgqZqHF0MA_ULSO38jOAIcxGbTMqMqhyl0FrZEZeg
Message-ID: <CA+CK2bA1Xv+asZ3d2jALk+VePDdDg+4ao0Y72CWV2i0rg3GsyQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] CPR: shared RAM with /dev/fdset for LUO kexec reboot
To: Li Chen <me@linux.beauty>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, David Matlack <dmatlack@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Alexander Graf <graf@amazon.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=pasha.tatashin@soleen.com; helo=mail-ed1-x533.google.com
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

Hi Li,

Thanks for the series. I have a few comments regarding the interaction
with the LUO agent and the broader architecture.

> In the LUO/KHO update flow [1], a LUO agent coordinates a host kexec reboot
> while keeping VM RAM content intact. LUO creates the guest RAM backing as a
> memfd and passes it to QEMU via -add-fd on the initial launch, so that

I am currently working on the LUO agent (LUOD) documentation, and the
intended behavior differs slightly from this description.

Rather than the agent simply passing FDs, the design involves LUOD
opening /dev/liveupdate and creating a UDS socket (e.g., at
/run/luod/liveupdate.sock). Live-update-capable clients connect to
this socket, create a LUO session, and preserve their resources into
that session. Once all clients notify LUOD that they are ready, LUOD
performs the kexec reboot while keeping /dev/liveupdate open, ensuring
the LUO sessions survive.

After the reboot, the restarted clients reconnect to LUOD via UDS and
request their preserved sessions. The sessions are passed as FDs back
to the clients. From those sessions, the clients retrieve the
resources, restore them, and resume suspended operations. Finally, the
clients "finish" their sessions, fully reclaiming ownership of the
preserved resources from LUO back to userspace.

> memory-backend-file can use it as the shared RAM backing. On update, LUO
> checkpoints QEMU, reboots the host kernel via kexec, and then re-launches QEMU
> to restore vmstate while reusing the same preserved memfd-backed RAM FD.
> Today LUO only supports handing off guest RAM via memfd [2].
>
> To re-attach that preserved RAM backing without reopening non-persistent
> paths, QEMU needs to let memory-backend-file consume the pre-opened FD using
> mem-path=/dev/fdset/<id>. However, memory-backend-file currently uses
> open()/creat() directly, so /dev/fdset/<id> cannot be resolved through the
> fdset mechanism, making this workflow impossible.
>
> This series allows /dev/fdset/<id> for file-backed RAM, documents the setup,
> and adds qtests to validate that x-ignore-shared keeps RAM transfer minimal
> in the cpr-reboot path.

Sessions become particularly relevant when we look beyond guest RAM.
For complex resources like VFIO or IOMMU, simply passing the FD is
insufficient. These resources require specific ioctls to be issued by
clients after the FD is retrieved, but before vCPUs are resumed or the
session is "finished".

Pasha

