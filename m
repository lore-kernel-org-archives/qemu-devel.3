Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D382606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hc8lmDEx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWYAU-0001lb-Vc; Thu, 26 Nov 2026 07:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xWYAT-0001lJ-2x
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 07:01:37 -0500
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xWYAR-0006dQ-49
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 07:01:36 -0500
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-3863db981d4so9766363eec.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 04:01:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795694493; cv=none;
 d=google.com; s=arc-20260327;
 b=gSK0CGjyBmrCxSnb0R11q4miYSUMZL8JoHOle6o5ydVe7kZIo4UgWTw8S1fIeuKrQ5
 b7Bdg7TC5Mba+g+8tUnacwGeg9hkKvQYRritwwgVKxKCw4TfaqGusXvRHIZaHNCwPdzr
 qY7Oxhag0f49I4sCVuRRVfPPaQbrapBS0nOZvn6q/TjgdVGlS6N0/pjySJT+gl0t6cy6
 aPTBQJaaafZTMRcL1+oNXuXtBS+Fuq+oKMSlCCCfRUvmZ5iaEiGeHJraK0qx9VWRhuvv
 m2z3CRATsgkaINjkVNqcYZWd2LIBUjKPCJFZvYbu0/JHiy+FcJR0ksI1XW9ymosfKUGe
 h61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7yAMbxP47vhJXF87LxxODSSTpzJeboYGDH3qABNNcBk=;
 fh=6UTXXnx0J9GIoGhqrf61BU5KiBvsBNHmdk37ASzx+9s=;
 b=PTbPvXNytfnGdhnU2PKhG+B05Fw051caX4/2TQbAWl3xCBnADVGR4VXJUAPW5WoDxt
 ug2Iq3yArBd4sZNwg+XXL2AwIaK7ByYO9ltMXcRseA5gK9IfcxiRHAwHPq1QOSgFzwrG
 jqCr/c1PR2acRq1SmhMOdCfJi7HnZR80GEmYKTzENTC5tbzNnx1ucSPdhFmg813dgjnT
 gdfQJ+qhQIQHMygOt4stxlNLqWmyv8KWIG7meegjcAucpM+ssLJ+VwUltC6iR1N5fiKv
 cz26wcCqo2un3iDS73yeKlOd66dgI0XL0P/MOeiMOf1oAuT4TU3lbxrvbsbj0B1Zokca
 lAjA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795694493; x=1796299293; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7yAMbxP47vhJXF87LxxODSSTpzJeboYGDH3qABNNcBk=;
 b=hc8lmDExY359RXnLiCTFwQQKlQw5gc61pIlWDSf4l+7rEMIaeAJzHFsWfMvhZd2plU
 Uz1tOK94UjPZERZA4tBMf0j52A3oJ/sxRcr1ebpificxjdz5dHPxyoVeN29YlgI7lMEe
 MarL5Xef5N0gvqrOHF/TCXp0LxZKpU4r0IFibEjkT2LdQNLf3tckBm8ZB9PxPoH4DcDI
 t1CtmZ2duk2kG8jJHuRva8rDV8yvYY81UAVlnjTI6fAHPQ6ivvLPGLnBnXAOAQUpMVb0
 KfB8bAZfADdGxhOR2m6x8VCjoEvkmlHICBX4O6cFTDjmu4RPSdojang2sCOnqrkb3M89
 SdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795694493; x=1796299293;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7yAMbxP47vhJXF87LxxODSSTpzJeboYGDH3qABNNcBk=;
 b=t0SVhFxcD7OTZNLJRhf9I9/T6anxVsNnmZdlR0lV7zTE4AGo5IYqaGrg5G/gdb3MfY
 ONd1Jz/jKuHxmZcyaSbrUVGM2DgtZlb0FMQQI6kLixZxvWw4GPUZxzU7HAKPyTMJbKI8
 MnVrSCjpbgkpLXN2IrC5HIxSYKsAMECvDdhcRZaE0QTLJ7M4uAJjZgcNoVEXovfNzXE4
 ZQeYgc+35fCRMQhxUK8vEN1U2zTLd4/rlgd9HRbEph+DRXLGjvlWiM/HYzWZ/tPLE1Rd
 ItS7G9ZYUY0H+nUNP18ewy/D9DYz7rxEiK4K1IqeEdlovCD65apbw5qpSrTdPBvwIjmD
 P1cA==
X-Gm-Message-State: APuU4Z8T4GPNAq3PJM9EY+hDrpOfdf5hpSljUNb8N2QqzUCSknDWNWXI
 4xXzpW0CoxgkDjYaL3JP0fW7uG4z2Hm5Gm4qZK0GcrYficEQDryYECSG28b9nexXELTYNBgNSc/
 qVg2Dgpb/2OKyvhe4zcqG1QwYoo71uAg=
X-Gm-Gg: AZFdTZdwEkTvW3QCiUMIhUbv7TFjuYb/4DKSfyIw0lJ9WpWEofWJTWO1hukeigKL1Ys
 KxCyXEPOT61hyVMna0ajOUOOojEk19XhJCg1226mlk2jTDm17r9NYxpn/r1H0HjlnlgfqMIPmGx
 gmcl/y67/+QHZIA7bNm30QI4BXEC1Z+rqisw+AuGgBXmZJyVRnH/jYrYbnhzLL9VkWPa+DU7hzt
 p24/197AX0etr/+vicxD8DpzzDtlxlwPMOFz7kLy4SPqg3nkI4yWMUVn12uIinY2vwv4h8PeZaG
 WP3dTNkT20h402NbpfSl02f+mgU5VOyGzzNKVNfGWgmHnFEvuZnFWDe9NI2AfTXyaOJtqBfjbqU
 Bs/1G7ZqaDwaHbMI7Y7HmmZJNJs+S+MaxwVpDcIvXBZNA9NupuyZoUDXuhlzGsjrPlJ4h
X-Received: by 2002:a05:7301:6486:b0:378:1191:43ca with SMTP id
 5a478bee46e88-3863f1355b2mr17192356eec.18.1795694492854; Thu, 26 Nov 2026
 04:01:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124-issue-4848-v4-0-24993c4766fc@redhat.com>
 <179569369656.3375745.17238189610521746462@taktcycles.com>
In-Reply-To: <179569369656.3375745.17238189610521746462@taktcycles.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 26 Nov 2026 16:01:21 +0400
X-Gm-Features: Aa3M54plmmK4fwFQ1jff4aryZJ-MaSuhVzuRjk_aYsdY22bmRap38gmorCWbsQc
Message-ID: <CAJ+F1CKKiU4AJhHEudDaj=upv-N82tMyLgGRn9R55yvXctgT6Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] vhost-user-gpu fixes
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry R <rdmitry@taktcycles.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1334.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Akihiko

Can you ack/rb this series for 11.2?

thanks

On Thu, Nov 26, 2026 at 3:49=E2=80=AFPM Dmitry R <rdmitry@taktcycles.com> w=
rote:
>
> Hi Marc-Andr=C3=A9,
>
> I retested v4 on top of 2bfbe39d0fff on x86_64/KVM, with the same setup
> as for v3: vhost-user-vga with the contrib backend (--virgl), the D-Bus
> display with a listener attached, and a Debian 13 guest.
>
> - #4848: a fence reported while GET_EDID waits for its reply no longer
>   kills the backend.
> - #4847: the main loop no longer spins on the closed socket: no "failed
>   to read msg header" lines in 90 s, and QEMU used 7 s of CPU time.
> - #4849: stop/cont, then a guest reset, then another stop/cont keep the
>   backend alive with no sock_fd or wait_in assertions, and the guest
>   driver comes back after the reset.
> - For the queue-stop change in 2/6 I added a stress case: 60 cycles of
>   SetUIInfo on the console (the guest then sends GET_DISPLAY_INFO and
>   GET_EDID), each followed 0-4 ms later by QMP stop and cont. QEMU and
>   the backend stayed up, with no assertions and no hung tasks in the
>   guest, and the display kept updating afterwards. Four RESOURCE_FLUSH
>   commands and one SET_SCANOUT command hit a stop, and the new error
>   handling completed them with ERR_UNSPEC. None of the 60 stops caught a
>   GET_DISPLAY_INFO or GET_EDID while it waited for its reply, so that
>   exact window is still untested.
> - With the reset patches dropped, #4846 still reproduces as it does on
>   master: QEMU segfaults on the first system_reset with a D-Bus listener
>   attached. That matches the changelog.
>
> So the Tested-by on 1/6-3/6 still holds for v4.
>
> Dmitry
>
>

