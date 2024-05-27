Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9898C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 07:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUre-0007nT-6l; Mon, 27 May 2024 03:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sBUrZ-0007ji-Bn
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sBUrX-00081L-LO
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716795222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PFRGRZXJxFiPeyLb9nDNEyrLhBbAe/570Vr12fzLp3s=;
 b=Dx2ivx9lH1WoaWIAVHdLosQJSu0QyEnJbxD9/bDClAGAIdYxI1kCG6p3y+uOTWmF/Zg52G
 0CelRwefQxHGdWt4vXuiVj0lZUlUezIdOvhyKvAE6PF0qkpWBcHUbLo+NCrCgvOPct5IB1
 zj1mTXU3HBt6Yd2REcCmI8Y2qggbhRo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-uWraSibnOHiLJPcriA6SLg-1; Mon, 27 May 2024 03:32:59 -0400
X-MC-Unique: uWraSibnOHiLJPcriA6SLg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-421088569dcso10461755e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 00:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716795178; x=1717399978;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFRGRZXJxFiPeyLb9nDNEyrLhBbAe/570Vr12fzLp3s=;
 b=s9bCG2FKEy4qPWEmz/4rxkhc6BgjYjoVv0MbWdPvVPjviUcNPS4kC6o63Zp1AeORoM
 npt//Oh4EDhxMTQrTvFJpErnujHIlEb9oKG2kn+kf93MR3vUvlooZ6bn7WY3cr/sOzvK
 rL6DsFS/BVcM4MdFINkGFlq1tYrMY3yp9cwKvjrpquZCs0mc0P3SrflE5HS+7TEtGFAP
 EMzuLluPDtbnCAzwPk+0ROR1SBqFFKkWQiTIrYa0Kce9RGhZnYAEScavAAg4dMAfkN+A
 CCDI4RGXN/h+Y2m5phPiI+tWgUXyNsDoYggsJJ1K5VkqTRUXQOCSc6LdvNYZg3Mm9ubD
 6PWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXndizBxlW03iz42OYKdbxanQv84QtvrHxflf+mAdeoNojMSXVEQmvGtj+jyFUgCyserZPHIJo3j/ahgz07huSfdTTDCY8=
X-Gm-Message-State: AOJu0YzdFSpJWdte60qfajyGwrP9TqOCzRYDJ6FJkndRkHkJj25GqHWM
 QJf/T6UqKRnsuMS5GzePqbgq8t5sOmWs8HcRoQhlW/Q2DIRv0mYgvnWZkwK11Bb6vSfj93T/e4s
 F5nqbrGwakaAqFaWD554ye6uZ5KqqQOvf/pVY91yquHrIX27Jfd/l
X-Received: by 2002:a05:600c:3b84:b0:41b:8041:53c2 with SMTP id
 5b1f17b1804b1-421081df776mr76079275e9.15.1716795178169; 
 Mon, 27 May 2024 00:32:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvnpxm0NYqfoFFzNYtUPi/wKsw1WStQkaDFGMzcS0UJtWQ7iMFOLwupHpSIAzknEomyuxEfg==
X-Received: by 2002:a05:600c:3b84:b0:41b:8041:53c2 with SMTP id
 5b1f17b1804b1-421081df776mr76079125e9.15.1716795177799; 
 Mon, 27 May 2024 00:32:57 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-179-90.web.vodafone.de.
 [109.43.179.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100fb99e8sm131962795e9.43.2024.05.27.00.32.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 00:32:57 -0700 (PDT)
Message-ID: <98ec8131-2b81-4e40-abfc-d5fbcf1b41d8@redhat.com>
Date: Mon, 27 May 2024 09:32:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tests/qtest/migration-test: Quieten ppc64 QEMU
 warnigns
To: Nicholas Piggin <npiggin@gmail.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20240525031330.196609-1-npiggin@gmail.com>
 <20240525031330.196609-2-npiggin@gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240525031330.196609-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 25/05/2024 05.13, Nicholas Piggin wrote:
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/qtest/migration-test.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index b7e3406471..c13535c37d 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -21,6 +21,7 @@
>   #include "chardev/char.h"
>   #include "crypto/tlscredspsk.h"
>   #include "qapi/qmp/qlist.h"
> +#include "libqos/libqos-spapr.h"

It's a little bit unfortunate to include a libqos header in a non-qos test 
... so in case you respin, maybe add a comment at the end of the line like:

   /* just for PSERIES_DEFAULT_CAPABILITIES */

?

>   #include "migration-helpers.h"
>   #include "tests/migration/migration-test.h"
> @@ -742,7 +743,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                         "until'", end_address, start_address);
>           machine_alias = "pseries";
>           machine_opts = "vsmt=8";
> -        arch_opts = g_strdup("-nodefaults");
> +        arch_opts = g_strdup_printf("-nodefaults "
> +                        "-machine " PSERIES_DEFAULT_CAPABILITIES);
>       } else if (strcmp(arch, "aarch64") == 0) {
>           memory_size = "150M";
>           machine_alias = "virt";

  Reviewed-by: Thomas Huth <thuth@redhat.com>


