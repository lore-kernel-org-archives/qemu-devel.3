Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28202C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv7v-0005Xp-QK; Tue, 13 Feb 2024 10:55:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZv7u-0005Xb-JX
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:55:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZv7t-0006Io-8z
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707839716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QsAXGkXDi+oY9NLImlm176exbBrLXg78m/3+njz50Zg=;
 b=GswawXpqIJr+nmHp4eEigIgnmOgBApBsUQ1o809Bv5EoUynFfI8e5zoDBuOWBpGl1XGsbH
 FaFQYHZnyqGQyNCZsVjPg3lKJaS1OWkqYjpTcyQ0Vnbl64XqG1vStJ91Aaar1jkBriaZGc
 Jo7xrkIOmqjE4oEcyNOEoLZqxQdhsIQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-BXE0kWwZMRW5tFca-9Dfkw-1; Tue, 13 Feb 2024 10:55:14 -0500
X-MC-Unique: BXE0kWwZMRW5tFca-9Dfkw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33b376cc518so2568788f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:55:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839714; x=1708444514;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QsAXGkXDi+oY9NLImlm176exbBrLXg78m/3+njz50Zg=;
 b=O9GVROaJUfw4xrUDxERAzu+IR+hos6cDW9S3OOPIvmmIvP2gxzebx3Toc9mXFgvtWw
 MRkmaJBD02A32rxnGnC7bcUj+FJVPDfXUOjuuujOdCaEoY8hexBKAUxRYRsYOPwVPoo3
 tIsICY65B0i7jIcZPQLI0biJrYs93I3Z8S+lTrDq9fDw5adT0dh59HMX5CVpnBsfBYzL
 0Ukm7V4oEuQNS+aV2b73zjNBWnILVqxmshsUb3xVFuqC6nbqU0YBjh+C525TU1gcrr5D
 s0z2UjihxFUfcTIysKEQdouWHwKu2nvY1s7wsXjIpl6jRBNTwEyAmBgMeyf0W1NUbW0I
 CptQ==
X-Gm-Message-State: AOJu0Yz4njJwTn5enSLicsI8CX3aCAeQ+CWd1lzauZASRsMLwlnayKSM
 ZkFCnTxLPBu78dl7foIvLihzrNefV57kM5h46ECxiGM3AgbxTOVvxRX65m2gQzdjOsnguA/fjbz
 yPXRRLouLCLlis1ph9mPyDrsh2cobN6oZKaqpotIpGC62XMLhOJNH
X-Received: by 2002:a5d:424c:0:b0:33b:2633:b527 with SMTP id
 s12-20020a5d424c000000b0033b2633b527mr6038633wrr.20.1707839713868; 
 Tue, 13 Feb 2024 07:55:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDy2hj53AooYKQgzg1Sv8HoYOae53M+/PgSmRddO2uo0RJ+Ohmja860yDyEAqUJUKI04ONxA==
X-Received: by 2002:a5d:424c:0:b0:33b:2633:b527 with SMTP id
 s12-20020a5d424c000000b0033b2633b527mr6038613wrr.20.1707839713501; 
 Tue, 13 Feb 2024 07:55:13 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV1mAEgrxf/w3x7cznMX6wPE7D8W8uLER8gt7TmY0FYO24g4KC/rhn34TjlCvkz32159YRZ+VNkmx8WTv0eKxLFJ7X98mfAsHyGYhPPPX6keKRA5qSnpN4WJ1AB/j4sDc0zLGXrmR8Fk10OtIlskUMIXX+3xuy3o7X3/OxVrsYhhnCHEjjw3FSOtbo18z3bRg5/1PspsYcBuAKeqmJ1+W02N+sYJp6JDUokaAPjGAp3TmM+1t7+9+NunOac4VFa5ZLhKti66SPzPjfCQ3pFGXrGDpAN9bCo+Wt0egrqqhYTZIWK8l0mduN4
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 bq14-20020a5d5a0e000000b0033ce3311805sm278668wrb.10.2024.02.13.07.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:55:12 -0800 (PST)
Date: Tue, 13 Feb 2024 10:55:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH 0/7] hw/i386: Cleanups around 'hw/i386/pc.h'
Message-ID: <20240213105455-mutt-send-email-mst@kernel.org>
References: <20240213120153.90930-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240213120153.90930-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 13, 2024 at 01:01:45PM +0100, Philippe Mathieu-Daudé wrote:
> Trivial patches removing uses of "hw/i386/pc.h".

How did you test that it's indeed unused?

> Philippe Mathieu-Daudé (7):
>   target/i386/monitor: Remove unused 'hw/i386/pc.h' header
>   hw/timer: Move HPET_INTCAP definition to "hpet.h"
>   hw/isa/lpc_ich9: Remove unused 'hw/i386/pc.h'
>   hw/i386/acpi: Declare pc_madt_cpu_entry() in 'acpi-common.h'
>   hw/i386/port92: Add missing 'hw/isa/isa.h' header
>   hw/acpi/cpu_hotplug: Include 'pci_device.h' instead of 'pci.h'
>   hw/acpi/cpu_hotplug: Include 'x86.h' instead of 'pc.h'
> 
>  hw/i386/acpi-common.h   | 3 +++
>  include/hw/i386/pc.h    | 6 ------
>  include/hw/timer/hpet.h | 2 ++
>  hw/acpi/cpu_hotplug.c   | 4 ++--
>  hw/i386/acpi-common.c   | 1 -
>  hw/i386/port92.c        | 1 +
>  hw/isa/lpc_ich9.c       | 1 -
>  hw/timer/hpet.c         | 1 -
>  target/i386/monitor.c   | 1 -
>  9 files changed, 8 insertions(+), 12 deletions(-)
> 
> -- 
> 2.41.0


