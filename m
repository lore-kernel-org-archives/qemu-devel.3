Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E497CCA470
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 06:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5ekA-00006Z-3I; Mon, 06 Oct 2025 02:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5ek4-00005l-M6
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 02:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5ek2-0004HL-KQ
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 02:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759732237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lB120EpvNInxPpvYcMAZ+rI/mwe5jB68SwJ//QSBct0=;
 b=etab3qd4XHSmiuiLIHTFZrRxSEhJpVDqs4Io7iNC83kbkf1pT2vHfNUImzgzXGZm9ZoaCW
 k8bbIDxZMopKnw8niytb87LR3TDz4Yc0BGVgYDDMmtcAmWYODAcyiOXWKyloySQ6mzGnto
 etSQsVDJQMP/CzIKTRw5D24bERycP1E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-rVvBIzPiOHmrCNf7TtMxMQ-1; Mon, 06 Oct 2025 02:30:36 -0400
X-MC-Unique: rVvBIzPiOHmrCNf7TtMxMQ-1
X-Mimecast-MFC-AGG-ID: rVvBIzPiOHmrCNf7TtMxMQ_1759732233
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b3f2cfc26edso423020166b.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 23:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759732233; x=1760337033;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lB120EpvNInxPpvYcMAZ+rI/mwe5jB68SwJ//QSBct0=;
 b=r4tiD4c9SDKR6glHyPimg0n8lz1bwgAKscPPkjz4Q22eiwUEeNOI+VK3GXsRnMjK68
 giEvRLprYljjVdW7g186Ql7eKLbtGC/P/Gl7RsRLa9gD5D6wIdNBQaCL6OguWuR/94IX
 Kb/ukOn5rG3hk7oYoDMdIiN8X1zXB4VPZ5Tc13NEaFFA53pncFueebO3xh8IhBNViQV7
 0yFNPQ9HZDRaBKhVa7ntlv+R4pdrxfmRrUA8FyGYhzZCnAahZSS0TEL9bnvchoxF8lFi
 dhVOnnbPjWpWLiioc/DnuzK8V0E7STCpulgxvsoPIGgHJt4uz0J8XWBKqJEHaHdRBWMx
 W46A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2Co9zL41+IRlkXoRXCkxocT8XJg1xQeotb8IO4t6Fq3JcQwNwCxD6UUOn3d7LHCe14BbWHWRqQm5s@nongnu.org
X-Gm-Message-State: AOJu0YweLXL1BQYCtao+QyqpabQ8quvRWi1Hn8jnhuPAMDzTSV0uJ2lb
 4Nh1z11bIVjn0NzO+2JJrnqoBKTUq+AdlnQPXYLZ/ddm7dMEIYqFHnplZraFpw3TvHCYzdGXdVN
 mil94sBAwk5aOiVF06s6YShQmCgTs0vCT+e6X4yvEqlagTC1W5sNnUhUl
X-Gm-Gg: ASbGnctupJfblWUXY5QO+kBVoGYJbO5TsRbfeMzudbHQJqX/0Vt2gygg7n2J4hKQeEO
 9tBIa/+NPXJBGcGurpIV9TRv3RCPNA1L5Q4hnAiufNhUBk8c4RPJnHjIGdQkFKSdAUl0X2pClBR
 nshIA86hNrawm9iOFfiMOBXxkQcap3sj19RgV+DmrmnKoRs6soXUgvnmyA7Sxy9K/dSp5rv+3Bc
 Ukd8Mj1X0lL+Purr3Q/yTrZ/bZKmca4n+lUX1XdixBSTfPzo9DkRkx5dfdHEl0MLMU39UFfefAT
 snxLiP4bs4qD2Ojdiz43vaLs9UGnhtsyneDjgawF3Cs84ge/MFfGDGEDeoKrUQbo1+ZZMJxyl8d
 Csm9GMW6jww==
X-Received: by 2002:a17:907:3c89:b0:b3c:896:abdc with SMTP id
 a640c23a62f3a-b49c525eccamr1336933266b.60.1759732232816; 
 Sun, 05 Oct 2025 23:30:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvvtRHiGi+JN1dCDKNvRstMBdzNGVxT8oZI+lBCa0DHDMFHl93AfLw3V1NziSK6IGixR0ygw==
X-Received: by 2002:a17:907:3c89:b0:b3c:896:abdc with SMTP id
 a640c23a62f3a-b49c525eccamr1336930366b.60.1759732232364; 
 Sun, 05 Oct 2025 23:30:32 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b486606bd5csm1069244566b.44.2025.10.05.23.30.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Oct 2025 23:30:31 -0700 (PDT)
Message-ID: <7aae5daa-5e07-463c-bc3a-6581050688af@redhat.com>
Date: Mon, 6 Oct 2025 08:30:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] tests/functional: Add GDB class
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org
References: <20251003141820.85278-1-gustavo.romero@linaro.org>
 <20251003141820.85278-5-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251003141820.85278-5-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 03/10/2025 16.18, Gustavo Romero wrote:
> Add GDB class, which provides methods to run GDB commands and capture
> their output. The GDB class is a wrapper around the pygdbmi module and
> interacts with GDB via GDB's machine interface (MI).
> 
> Acked-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   tests/functional/qemu_test/__init__.py |  1 +
>   tests/functional/qemu_test/gdb.py      | 88 ++++++++++++++++++++++++++
>   2 files changed, 89 insertions(+)
>   create mode 100644 tests/functional/qemu_test/gdb.py
> 
> diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
> index 6e666a059f..60d19891bf 100644
> --- a/tests/functional/qemu_test/__init__.py
> +++ b/tests/functional/qemu_test/__init__.py
> @@ -18,3 +18,4 @@
>       skipIfMissingImports, skipIfOperatingSystem, skipLockedMemoryTest
>   from .archive import archive_extract
>   from .uncompress import uncompress
> +from .gdb import GDB
> diff --git a/tests/functional/qemu_test/gdb.py b/tests/functional/qemu_test/gdb.py
> new file mode 100644
> index 0000000000..05e4c29c2a
> --- /dev/null
> +++ b/tests/functional/qemu_test/gdb.py
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# A simple interface module built around pygdbmi for handling GDB commands.
> +#
> +# Copyright (c) 2025 Linaro Limited
> +#
> +# Author:
> +#  Gustavo Romero <gustavo.romero@linaro.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.

  Hi,

just as a reminder, this still needs the change requested by Daniel:

https://lore.kernel.org/qemu-devel/aN56GkbIFxs5IDRR@redhat.com/

  Thomas


