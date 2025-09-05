Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A973CA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 07:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuQrW-0004ER-Fs; Fri, 05 Sep 2025 03:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uuQrU-0004Dp-5T
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:27:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uuQrR-0000TO-W6
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757057272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0OOgrywLrTBv8v3f5936EmlOXrkza95Ygb/uLIFiQl4=;
 b=cIJhySkBrZiAOR2px8hRjHzRXqq0pig4JbP5W8jF/P26ugJLr7a/5MeohD9W0NyKAvL0jP
 PbyluCwa0EVyy9QNaXU/VBzo3hitzT8Wjp96uYkbn4KatR5jmDK53IiHIM84GZAZba4EDZ
 cO4J9fdJ9RkItyq11cfMkt0tOknzmzI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-OvL_EdMQNdKQjFMIrsOoqA-1; Fri, 05 Sep 2025 03:27:50 -0400
X-MC-Unique: OvL_EdMQNdKQjFMIrsOoqA-1
X-Mimecast-MFC-AGG-ID: OvL_EdMQNdKQjFMIrsOoqA_1757057270
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b9dc5c2ba0so962188f8f.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 00:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757057269; x=1757662069;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0OOgrywLrTBv8v3f5936EmlOXrkza95Ygb/uLIFiQl4=;
 b=klTXS0H2dtNWrhX9/QR2p/15Tn/mngCwiXPUbSF8GEZQH2caH4dCS0VPMtG20My/AG
 65CPOHfeizl5mYTtemfHqknNEWcaP2KdCqiOQfHSM4sCNaCn0el7S0BiPNv736gwPl4r
 QHQ7mt5UxLfzgydoNjo78MAJVu+rlaiM+ThdIf2EJDFq1D21nQjUNRgJBUwa+YpTXNPC
 xV2dwVFcez0218gHoZ/vdZuMJDl5m+BgbnSJ8nyRLcbIMu5H6GwbEvYxYyvQwkax/Cql
 6XCamNigK3myrRX3WAhxQnCmEayvxg318wRRAv5rlD8tKOndGniVuMoXd06spcTv3Kvr
 kf5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMuhhUxDnKTrq1v0XG7lgIKUsPggVYp6ZrLLhx89jLZPANeC/tgH+TI4rwrSnhADWrnRZ1seY6S39N@nongnu.org
X-Gm-Message-State: AOJu0Yyb6vAyJ/9S2hqMUwcl8jC9y8s0/385lcAFdRXXY5RiDmeuanMx
 ni+FAbY6AvXvMDS6AZNUuuHzyRdyFaVKMP4VlN265XeV0ckSKoXOMbKx6GPpEdEBGvT32j9l7g6
 EymqIVqLJoFZLL+LoyPjtkE/HaptMux/xbbYzOddUrt/melhwXbjoosor
X-Gm-Gg: ASbGncsRR5MruWHZwRCy7uamrW53ZHrd/awUHEzfSuFNAV7TOS0pZ5zBXlaE8RNzra+
 WG6yiUoT2zz/7jGuXh71iLVXJAJWB8jlHVMt3ikB23CUy86I/ggN3AYnqfzxkcyattmzKT9Admu
 fT7h+QCRrNuOP1BsqFoowrluBT6D+XUCw9/zaz5pZNj8KajProLL5fUw6OB0Al5aFD2DofvpUEd
 9EuEUxUE/Ce3JbQFhLUnqXQgOmVYodVe/ppHbN5A+gLwhQPAoQ7D8Cj2pp9SXjSPdcbt86teZwi
 ARfzdZC3wWGVtj04tz2WuS9ppP/0Xvc4j8BGvcphwvKOpASlp1jZyQYLqudqxhkHO1pgTUL0Yz3
 FJ3W8HPgf4BxvRxMABEMZChoPI+/DFifsp9EQPH4Oc1U=
X-Received: by 2002:adf:a19d:0:b0:3de:78c8:11fc with SMTP id
 ffacd0b85a97d-3de78c81422mr5347895f8f.63.1757057269475; 
 Fri, 05 Sep 2025 00:27:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8YTdeAdKU0bCFQmMiy7xGsjFlz9U0V7vXFegtTWlxYpBxrxutr3MKd0nVrstGC/gBIqklfA==
X-Received: by 2002:adf:a19d:0:b0:3de:78c8:11fc with SMTP id
 ffacd0b85a97d-3de78c81422mr5347883f8f.63.1757057269056; 
 Fri, 05 Sep 2025 00:27:49 -0700 (PDT)
Received: from [10.173.24.179] ([131.175.126.3])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45dda4f2a0dsm9192885e9.2.2025.09.05.00.27.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 00:27:48 -0700 (PDT)
Message-ID: <10c9a015-16a1-4f5a-a0fc-85d01cef8651@redhat.com>
Date: Fri, 5 Sep 2025 09:27:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9pfs: Include glib.h
To: Peter Foley <pefoley@google.com>, qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz
 <groug@kaod.org>, nabihestefan@google.com
References: <20250904-9p-v1-1-e634cb374c80@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250904-9p-v1-1-e634cb374c80@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/4/25 16:30, Peter Foley wrote:
> gstrfuncs.h is not intended to be included directly.

Indeed -- it works only because qemu/osdep.h actually already includes 
glib.h.  So the line can be removed altogether.

Thanks for looking at these papercuts and bringing attention to the QEMU 
upstream developers.

Paolo

> Signed-off-by: Peter Foley <pefoley@google.com>
> ---
>   hw/9pfs/9p-util-generic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/9p-util-generic.c b/hw/9pfs/9p-util-generic.c
> index 4c1e9c887d00c44bc073bec00c07ed09d3868bf5..93c38e40f693a945f979ca89555cd9b1ea3175d6 100644
> --- a/hw/9pfs/9p-util-generic.c
> +++ b/hw/9pfs/9p-util-generic.c
> @@ -2,7 +2,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "9p-util.h"
> -#include <glib/gstrfuncs.h>
> +#include <glib.h>
>   
>   char *qemu_open_flags_tostr(int flags)
>   {
> 
> ---
> base-commit: baa79455fa92984ff0f4b9ae94bed66823177a27
> change-id: 20250904-9p-11c0405ae7c5
> 
> Best regards,


