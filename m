Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62095C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpigM-0002cE-9O; Wed, 05 Mar 2025 01:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpifr-0002Tj-7L
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:56:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpifp-0006Cw-EC
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741157768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2Kr6XjnTw+S1ctno2A9iBia5rbpn8+MxM4eZfV3fVw0=;
 b=RVY4lVIWtLkE8pUpIF/d6epWnjSuZHokQrMSvF2YhO3bc4QwDD7Fr9ccBKWsRH6+Fs8Lzn
 EWWwuBAvvuL+5LHZ4zSNvxsHQfR3WgfOByrZAC7MJiAfh26aR0uFwTHmGmEUz/4k89lwHw
 JUJ3bLWnvQNbY91WuCMPvHPGl9y558s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-iXhQlER0Mu6IqaSoqrfhgQ-1; Wed, 05 Mar 2025 01:55:52 -0500
X-MC-Unique: iXhQlER0Mu6IqaSoqrfhgQ-1
X-Mimecast-MFC-AGG-ID: iXhQlER0Mu6IqaSoqrfhgQ_1741157751
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43943bd1409so46296225e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 22:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741157751; x=1741762551;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Kr6XjnTw+S1ctno2A9iBia5rbpn8+MxM4eZfV3fVw0=;
 b=OO2o5Cy0j/4ZA+WbHsxVPOXNOoUD5k3hLnezzwZXnrftcqKDdv2bmHMY0Xe9brXK5j
 0NX1qFLRyL6A/CG0zaecq6HPnb6sxQPkJLHJjcP0X1OK1YWbZF81iM5a/roq2z2I0n+P
 iP7kHWJe3sPXXy4sr+twL3VN/zMikrv/K6PoysW14/Dhj/wrBmZmKkb/BDNKoxtltMr9
 0ZJGCZ+dZJ+Q0P+8w4xorz8dmSScNEV19/U4lHVCv0w//TKM0kGm/e1mg4hcn6kFNXar
 tzH6VqQLxUPxq7tRouEpmO5LTs3f7qFUnN8r2y/ETzgq7Cuj5MG08qWyTCBRquR336JI
 Dfnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUchF0sBiIRBf+dgKkeN/f03pADOfB3bAlzualmeMOkNDkX1PM72WxMZdajOSv15+in6r9SnFVaAkJ4@nongnu.org
X-Gm-Message-State: AOJu0YzhxpJra1gWEYVq39T6og7LeGDot9vSoaBEFn0/4qbngXFe/dR+
 kodP6Ks/CA6ufH5dDvNYYx/ugD7oZpDPWs08i2u/UnhW0tiQdVnskBTSVFHVmMFYU4SRA1S8gCP
 ox1f/xX3dM+NkMIOa67y/1zN3nLtQOReq3ml3OjTUPIUn43b+5aKJ
X-Gm-Gg: ASbGncvUuWuVRs3lWtqqxl7vdQIHf5Wf+a0laf+a/tRxhpBeMjoJpAqNb/jMxnBZNV5
 xDarm5f7krFpdxWeZNzmIsj5Vq1uYLAW/G6bK3JLFADYs2ouK1fIjqXMtE4vQH9NHtExHe983o/
 JJgu5bB0fZ9cbXRInS/CS0xaXQ+/rNzGfEyMGMJz8YYhabphFcjVkM7BlKr4+oUthSxg4r19dw/
 psQ7N9fyyyGXpa80QyFX+In1JtbWXUHSqmByzsSRnngcEOlc/W9CYR/zt3C+O0D0lgZbvZR0Mdo
 jfaKbVjxMhlsOqXA5iWKUUzHpSDIQJNbQ779UArSeXmGu18=
X-Received: by 2002:a05:600c:4f56:b0:43b:cd15:2ec6 with SMTP id
 5b1f17b1804b1-43bd298ed36mr11116885e9.14.1741157751088; 
 Tue, 04 Mar 2025 22:55:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUHWXdLTbPEE91ogwUNYLlRrhaNmBYx4NaHFK6d3fYoTcQjA6qNBpDMzGYaQ3NizRvfTgt2g==
X-Received: by 2002:a05:600c:4f56:b0:43b:cd15:2ec6 with SMTP id
 5b1f17b1804b1-43bd298ed36mr11116785e9.14.1741157750743; 
 Tue, 04 Mar 2025 22:55:50 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bcc186de4sm20448815e9.1.2025.03.04.22.55.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 22:55:50 -0800 (PST)
Message-ID: <ecfdf860-7bbd-4744-9195-2eee2c7a0d05@redhat.com>
Date: Wed, 5 Mar 2025 07:55:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: Defer trace init until after daemonization
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
References: <20250227220625.870246-2-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250227220625.870246-2-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/02/2025 23.06, Eric Blake wrote:
> At least the simple trace backend works by spawning a helper thread,
> and setting up an atexit() handler that coordinates completion with
> the helper thread.  But since atexit registrations survive fork() but
> helper threads do not, this means that qemu-nbd configured to use the
> simple trace will deadlock waiting for a thread that no longer exists
> when it has daemonized.
> 
> Better is to follow the example of vl.c: don't call any setup
> functions that might spawn helper threads until we are in the final
> process that will be doing the work worth tracing.
> 
> Tested by configuring with --enable-trace-backends=simple, then running
>    qemu-nbd --fork --trace=nbd_\*,file=qemu-nbd.trace -f raw -r README.rst
> followed by `nbdinfo nbd://localhost`, and observing that the trace
> file is now created without hanging.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   qemu-nbd.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 05b61da51ea..ed5895861bb 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -852,10 +852,6 @@ int main(int argc, char **argv)
>           export_name = "";
>       }
> 
> -    if (!trace_init_backends()) {
> -        exit(1);
> -    }
> -    trace_init_file();
>       qemu_set_log(LOG_TRACE, &error_fatal);
> 
>       socket_activation = check_socket_activation();
> @@ -1045,6 +1041,18 @@ int main(int argc, char **argv)
>   #endif /* WIN32 */
>       }
> 
> +    /*
> +     * trace_init must be done after daemonization.  Why? Because at
> +     * least the simple backend spins up a helper thread as well as an
> +     * atexit() handler that waits on that thread, but the helper
> +     * thread won't survive a fork, leading to deadlock in the child
> +     * if we initialized pre-fork.
> +     */
> +    if (!trace_init_backends()) {
> +        exit(1);
> +    }
> +    trace_init_file();

This also sounds like the best option to me!

Reviewed-by: Thomas Huth <thuth@redhat.com>


