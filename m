Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF8606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sLD1Posd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTGMk-0007b4-OE; Tue, 17 Nov 2026 05:24:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTGMj-0007ao-1J
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:24:41 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTGMh-00064x-Ai
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:24:40 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-67db763cec7so2140274d50.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 02:24:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794911078; cv=none;
 d=google.com; s=arc-20260327;
 b=VzAL4girqcCFCSs+CyKR1Wpa+iU+Rm4UdYxjGAMwvReF/SvC6DfRTj1DRG8pJ37Nf2
 wolcI7PYnN4ThaNvYolUG04Al0zRzD2MjJmQBfOsC7Aa5piuZnfy67CslpAHiHKoEtfH
 7bIkR4WmQcEQOIvRzOwYxVRtHeFQsQU+gsUfu7MlzrXARzH1X0WTO3jiAaBpwn3LEwsv
 fUKx53TuBanGmJD7ARfAeBA5nEkTmMj3xzPrnMXaApeTn1lGdBubBOLRLJzTzfUmantr
 aAkOMZI/MwmvN0pOI6HHHEKk8Zw/EctJfWBqnAmfLhu07v++HxxbJ8AKbQCiqmnqczqe
 3ZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=srib1ftpPKdqXioQkWgEHyuPsSAaER6nQ6ACkMhpeEM=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=dFe18MHduLOb81UDEX1QS/SmAgRHt+hddbAhCc74l5KPTOOAenayM2mYsXZsvrw+g5
 QlHszvE1DLqrIE9Lw/ZGx9JG1iIcJBQHWdNyFVtv9flygu2kjp6ghRSRTTpiHcCOGTRE
 7en8MeHIriz/RcNbGCDSXdDrxiZprczKX0tuP9lyzPDTrFh9VI/qgTTIwz5vb3hjrSKd
 klgFRJeJ81fQZDDbtz5O+6XmWbJcDiAcC3rE5UNKP3WKV5DjktdUKbzCgFm036tAdBnv
 USFYA8K14AqDTtgf42i8YuCWengoX/hIJEaqUEOd7Pz0njr09E6F4eRJN0huCoA17f2e
 Pf9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794911078; x=1795515878; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=srib1ftpPKdqXioQkWgEHyuPsSAaER6nQ6ACkMhpeEM=;
 b=sLD1Posd8gS88xiFr1Amx7k7M83/yHg+8Qj9s7sL6VavmT6Ng4hoj/9yQhwiZX2nQ+
 EZ3O2lvrXQs0dQfEBCa6TP+pT5UJuoU8v0ztllouGVHvJtnXUqyT8OgwHpWwzJnYM0xr
 0hh6D3MJVXaWwqt8NtcX6B0zKFZZhx4EVLaRrgfaIZ4iZ/hof0QvQ17gzNoeYber/5Wg
 //7xKIAjgqRtAtrvS65Zmddp3eM3PzyFfRs48/e3M/GNNy7H3vheDpDl9MBX4FTSMjHN
 095szAZQ8BbOMT/f0WIToSBAZDJvG9j55o+2EZEJkkyy14/oKWWVVx5NinodtEewtAHf
 3wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794911078; x=1795515878;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=srib1ftpPKdqXioQkWgEHyuPsSAaER6nQ6ACkMhpeEM=;
 b=qQzgOSVzx5ZTY1R1gnGzW0TmUBjkMonJPwCHhLEmxPFIFv2t5yJLBR8iZPvenBmJws
 NYk6cRok2uXcdEuRJ3q2bNzjJPcZdpZTjM85FaGex9hDPmG2UT1OJHd3p7mO9Lo9gcV3
 0Gl9IzImFa5Jp4tFZ0L6/3IulL8xpT5wcGG3opXv44XzdpuD8a8V/FTMefgIGATerNx5
 OV0+P3ysi1whTT6FJLRZLMKEiUTxDK1n1GqAYQgJ8GcI0lH4VmDjq4nyMQ+QbXkBbBpa
 WLgk9muNC3TJ2zp0kaRZWcy6bOEGM/LUfvcTLv00rd18XpAXGqovELC3t08fwDH6zq9/
 F7dQ==
X-Gm-Message-State: APuU4Z9K5Z1l2aajUszLpniM+CzY2LBa2s0536XYRhiKc+AkAeD7Gnfu
 qSfHo+Oua6oSPbu7AUF3XNJiNoDi/gmXblXJTjpbA10pWqF2VAkI3uIQAezL5671KUmSAmk1WWm
 QqP3AFagm/kBFqREf2qQmehiMzw2rHV7mmbwNCEuJXw==
X-Gm-Gg: AZFdTZfsL28tN1Bm5ldRXWPmm4/HQa8Wo98s6wWH/ySkzpJzjMfFtPZCyiVL46NLRdc
 Md2tJAYQWjzTZa7aYmoQTKhQMCX8IuA2vUMRMUN8U/RStz8mULwS3Q0TbM7QNf/u/+ClB4e1UnP
 aqLzc21+WxnILYywZKPX/wBP88fgC2acsxtONwIGvb5G85JMh8yatPH0woBxfMjBjiqCkWmTsUc
 PP6Yk+d5ir+v9mdznJM6CNZrb5aDy2TzMB+NYROoLd8DhLqzi9qtQ2mU28cg4/QKEZIHZDJbywY
 inROZ+Po20Y/0rJQkmvzNBnDCXxLNlMwlYvNuqhTo4I4iRqZ6p3W6ackdTLqz+FQ1VvmEgo1Mp7
 tqFj3D9fa+z3kEDKmm2YCfNg/ttQYNFVlfCgIgyFcBApISbGjncbg5+PgQeLVbkzK7CTL/s6ysi
 KdUJsoIPoiQQ9evXmq8UlA
X-Received: by 2002:a05:690e:bcf:b0:67d:c37d:331e with SMTP id
 956f58d0204a3-67dc37d73d1mr1398404d50.119.1794911077589; Tue, 17 Nov 2026
 02:24:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <avwn7izLPHpSmVun@redhat.com>
In-Reply-To: <avwn7izLPHpSmVun@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Nov 2026 10:24:26 +0000
X-Gm-Features: AclHuK8YqN8TGo8Xj7axqIwLDp4HqiAHb9T7w3FD29HGCFkVkVLidBurvBSrIXc
Message-ID: <CAFEAcA9otxN=xhb7C8JRQ7HGNZqvzdpDjBaFQ7rCxDviip-rZA@mail.gmail.com>
Subject: Re: System emulator security boundary policy now enforceable
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 at 10:10, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> With the latest pull request of mine that is merged, we now have
> the mechanism for enforcement of the QEMU security boundary policy
> with annotations completed across QOM classes for machine types,
> devices and accelerators.
>
> For a bug disclosure affecting a system emulator to be accepted
> as a security flaw the reproducer scenario must now pass without
> warnings when adding the '-compat insecure-input' flag.

How does the marking work? I'm confused about what's going
on with the pl011 UART (which is on the security boundary
because the arm virt board uses it). Unlike hw/char/serial.c
and some others, there's no ".secure =3D true" in hw/char/pl011.c.
But it isn't being rejected by
./build/kvmonly/qemu-system-aarch64 -accel kvm -M virt -display none
-compat insecure-input=3Dreject -serial stdio

so presumably we have figured out it's secure somehow. What's
the mechanism here?

Speaking of pl011, there's also a rust implementation (which
I am not using in this test). Do we mark both the C and Rust
implementations as 'secure' ?

thanks
-- PMM

