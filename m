Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2243BCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 16:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7FWZ-0004Yq-L9; Fri, 10 Oct 2025 11:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1v7FWV-0004Y3-Ki
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:59:15 -0400
Received: from esa13.hc2706-39.iphmx.com ([216.71.137.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1v7FWM-0005CE-6H
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:59:12 -0400
X-CSE-ConnectionGUID: qh3R2NiWSh+3MuTgdXCBLA==
X-CSE-MsgGUID: 1cWgiASRT+qlAqlxR26IBg==
Authentication-Results: ob1.hc2706-39.iphmx.com;
 dkim=pass (signature verified) header.i=@bu.edu;
 spf=SoftFail smtp.mailfrom=alxndr@bu.edu;
 dmarc=pass (p=quarantine dis=none) d=bu.edu
X-IronPort-RemoteIP: 74.125.224.69
X-IronPort-MID: 82381094
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:OFsztqleqqFxQBwDrS6L8ETo5gzVJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xJNCGnUbvaCMTDyeNl/bomy8U8D6MfWzdE1SAZrry8yFS4T+ZvOCOrCEkqhZCn6wu8v7a5EA
 2fyTvGacajYm1eF/k/F3oDJ9Cc6jefTAOKgVIYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE/
 Nj/uKUzAnf8s9JPGjxSsvPrRC9H5qyo5WpA5wRmP5ingXeF/5UrJMNHTU2OByagKmVkNrbSb
 /rOyri/4lTY838FYvu5kqz2e1E9WbXbOw6DkBJ+A8BOVTAb+0Teeo5iXBYtQR4/Zwehxrid+
 /0U3XCEcjrFC4WX8Agrv7u0JAklVUFO0OevzXFSKqV/xWWfG5fn66wG4E3boeT0Uwu4aI1D3
 aVwFdwDUvyMr/u2m4jhbOhTvcRgd+z2AIwTilpK6RiMWJ7KQbibK0nLzdpR3TN1l9AXWPiAN
 owWbj1gaBmGaBpKUrsVIM1i2r7y2z+lKWEe9gP9SakfugA/yCR41KjrPMD9cMHMSMlI9qqdj
 jKcpDSgWkBGXDCZ4WOOzX2tr9T1oWDiXKsLEK2CrKBLqlLGkwT/DzVTDzNXu8KRk0O7RpdTJ
 lIZ/gIoqq498lHtScPyNyBUu1aBtx8YHstASqg0tlDLxa3T7AKUQGMDS1atdeAbiSP/fhRzv
 nehlc6vCDBy2IB5g1rEnltIhVte4RQoEFI=
IronPort-HdrOrdr: A9a23:n2sRc6k4PqwgkztON5Zy32fhoCDpDfIa3DAbv31ZSRFFG/Fw9v
 re+sjzsCWftN9/Yh4dcLy7VpVoBEmslqKdgrN8AV7BZniChILAFugLhubfKn/baknD39VQz6
 tmbuxbBMfrBVZ3yebWiTPIcerIq+PnzEnev4fjJhlWPGZXgoJbnn5ENjo=
X-Talos-CUID: 9a23:w5P5VWNjSu3lFu5DQSk8zhQyG/8ecj6G6WrsLEOIIkxNYejA
X-Talos-MUID: =?us-ascii?q?9a23=3AkTadpQ0yTFjsksdUGPjugvjr6DUjuq+RB0Ekqq8?=
 =?us-ascii?q?6+NCAHDV0Kw3H0hWdTdpy?=
Received: from mail-yx1-f69.google.com ([74.125.224.69])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 10 Oct 2025 11:58:56 -0400
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-63b781aecedso4815085d50.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1760111936; x=1760716736; darn=nongnu.org;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=GCQGT03hqSGUSkCs+YndRioYG7YpMxLgGKhCHaOGDFs=;
 b=oahbJzwQkf22jVNLoyoB6dg4a/+ZK0upa7OVrhtZb/hltmQwYnRW5CKsRoULC5QaMO
 TgYGVOjg5+/OO+Y+cSsn8JxMt/j6Kfj4DB9fg8GkVfC0o2J4omua8izv3/3nI562k0SI
 zVFWEOXzlxnldlm8bLHtiv/v/8pjE2w5ocJqalPidbYZ4aUu6kwMzZwE3110GnLn7i38
 +XVF9UlJ+I9e8UOrapH4iUjT4tAXzQ0Q7bAb+9WGxYXb+SpH8OX9AK+cidpo1D5QLRUw
 Zdnv8azrJf4kauNx6IYZS8IHR82xd5y0YhSDaxCKVb8wKHtgEWZKrQUhbNzqyHAWOBUn
 UO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760111936; x=1760716736;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GCQGT03hqSGUSkCs+YndRioYG7YpMxLgGKhCHaOGDFs=;
 b=E6aQiCyT//hN1ZNgUKMfJcWE3qyQ7m0vg+rcCgtsiRp6KOSXh/B69+mUqwaR0zpiMi
 lq+Da4SndtE5Mw2pFZ8Oaeso79FqNJT/8L+YJFPAg4MmKYtnOs7Ai+QBJZ9fspxiyRnf
 ChP0Mkl9o+5+kvmuY4+sLY5ybATrMj2AINHSdZqgbPvHwIJPBlW29PvgHlTH6fuSkm22
 gou99QKW7gaRTIWT8Wl5Kgt9GCQ5Q0AXbik1YhwaS7+Y4oEY9lXFVRPfZ/6xCrkf6wmr
 rzuoXCTVu6Q7C55wOd1WP8gPMq4AIBj8GB3B1PJFOWt3ilNZyAchanL+VonIYdJrXteB
 Gdgg==
X-Gm-Message-State: AOJu0Yztzhj62fSjq+Sp7i2oL9kUn1g6kHgzxPAz0kD15GnliE/lWJ/2
 AdYiNxTKszu8M/Q8pbq93F49sMpoGPYIZGfuEmCgdu4NX8a8VuLurhABxsweG0OzcE7E7ZhsY5Y
 Av0KlHfcGfLIIRZ3YwaHYz387KQUHYLSbfi9EZN59E9U7nOnOGmVVroa6v5N4F1YOkr9NcScZOV
 M8P8btn51g8RYDeEtlBLlP1j32N3iFR9LZyLiTJbTdN6CX
X-Gm-Gg: ASbGncukT2xhkVtWN4eOeEKZ1WE5jKwGAmsR3LFTe1uOrvzfhjhtRvAX/JnNYzHnouw
 FZKy7XBjgDrZ4Fb7edoidYl0l0Mc11W6DGRjO+ToOkrFnd/x65NwMDz3c55dd1xgZtWFzjtWMfA
 IHp+blhESzxWcA+2OA2395
X-Received: by 2002:a53:b9d0:0:b0:635:4ed0:570d with SMTP id
 956f58d0204a3-63ccb904a86mr8657963d50.39.1760111935832; 
 Fri, 10 Oct 2025 08:58:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuFk7M3w3GxYEgx31yfZv2KptuZCeqWJ/vRHy+d7D16s8kvtiW8dT1BV6maG8wXZhgmu0zbG4Qznh1AqioFHk=
X-Received: by 2002:a53:b9d0:0:b0:635:4ed0:570d with SMTP id
 956f58d0204a3-63ccb904a86mr8657946d50.39.1760111935479; Fri, 10 Oct 2025
 08:58:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Oct 2025 11:58:53 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Oct 2025 11:58:53 -0400
From: Alexander Bulekov <alxndr@bu.edu>
References: <20251008191936.3069950-1-navidem@google.com>
MIME-Version: 1.0
In-Reply-To: <20251008191936.3069950-1-navidem@google.com>
Date: Fri, 10 Oct 2025 11:58:53 -0400
X-Gm-Features: AS18NWAElnO2MHNuJr4Cp-a37b-YLwcv2rEi2rrz3SdrYK1XRdYPum2OV_YMDdY
Message-ID: <CAHUE=o-X1sJXn6SWATUUjX2GHUsh8mufk3MZHVkKDzzFGtbSyA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libqos: pci: Avoid fatal assert on zero-sized BARs in
 fuzz builds
To: Navid Emamdoost <navidem@google.com>
Cc: qemu-devel@nongnu.org, zsm@google.com, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.137.83; envelope-from=alxndr@bu.edu;
 helo=esa13.hc2706-39.iphmx.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_BL_SPAMCOP_NET=1.347,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 251008 1919, Navid Emamdoost wrote:
> The qpci_iomap() function fails with a fatal g_assert(addr) if it
> probes a PCI BAR that has a size of zero. This is expected behavior
> for certain devices, like the Q35 PCI Host Bridge, which have valid but
> unimplemented BARs.
> This assertion blocks the creation of fuzz targets for complex machine
> types that include these devices.
> Make the check conditional on !CONFIG_FUZZ. In fuzzing builds, a
> zero-sized BAR is now handled gracefully by returning an empty BAR
> struct, allowing fuzzing to proceed. The original assertion is kept for
> all other builds to maintain strict checking for qtest and production
> environments.

Is there a way to determine whether a BAR is unimplememnted from the
PCIDev in generic_fuzz.c:pci_enum so that we can skip the call to iomap?

>
> Signed-off-by: Navid Emamdoost <navidem@google.com>
> ---
>  tests/qtest/libqos/pci.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
> index a59197b992..df9e2a3993 100644
> --- a/tests/qtest/libqos/pci.c
> +++ b/tests/qtest/libqos/pci.c
> @@ -541,6 +541,22 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
>          addr &= PCI_BASE_ADDRESS_MEM_MASK;
>      }
>
> +#ifdef CONFIG_FUZZ
> +    /*
> +     * During fuzzing runs, an unimplemented BAR (addr=0) is not a fatal
> +     * error. This occurs when probing devices like the Q35 host bridge. We
> +     * return gracefully to allow fuzzing to continue. In non-fuzzing builds,
> +     * we retain the original g_assert() to catch unexpected behavior.
> +     */
> +    if (!addr) {
> +        if (sizeptr) {
> +            *sizeptr = 0;
> +        }
> +        memset(&bar, 0, sizeof(bar));
> +        return bar;
> +    }
> +#endif
> +
>      g_assert(addr); /* Must have *some* size bits */
>
>      size = 1U << ctz32(addr);
> --
> 2.51.0.710.ga91ca5db03-goog
>
>

