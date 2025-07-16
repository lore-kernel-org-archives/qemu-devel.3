Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E64C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzWI-0007V2-Ci; Wed, 16 Jul 2025 06:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1ubzLj-0005rI-J0
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:26:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1ubzLb-000506-3H
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752661603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/T/3j6pUwqcAqb15F2lx6cMRuPQcJ27cqsv5Mwoy+NI=;
 b=QHnj1LuwNl2hraleYT/U3s1jBIVPDwcqajcOFUCHtnnKouQOkgsCg13pOJvN7K/25DG9ng
 x1f4FaiOijc5j0grdGwQqf0rcIDoDydv6kbGMTKczgsBLT75a2dx0IVwRGNU421lBjxnC/
 /l8MmJTGC4A687G1b/d2lmWPlJHtalE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-Fjd011Q5PTmVbFklastDYA-1; Wed, 16 Jul 2025 06:26:42 -0400
X-MC-Unique: Fjd011Q5PTmVbFklastDYA-1
X-Mimecast-MFC-AGG-ID: Fjd011Q5PTmVbFklastDYA_1752661601
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45624f0be48so12202125e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752661601; x=1753266401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/T/3j6pUwqcAqb15F2lx6cMRuPQcJ27cqsv5Mwoy+NI=;
 b=lzjSXWqKuajPrf223yK6UPex6lG8j5lvRD9cAtcEJ1zxIFDtjnIdgvUw1sGjyHT22q
 G+1pyx4ghqea+1z1vtKbClZcZn5GfUIpyBaq36aJxQg5iapZAvYc36W2GmuE2OpAie9B
 k+qMTawazxgGKmkbxCwUvKohE/LFHUcdYlP1NutmZcM6j4M8UeonFFx3HiMtwRYK4MPq
 uvXkmDee3h72J32zPTQUJf6fnisdvVgMAnHbZjB+iAYLHTZO5820RZkJydZRRW7f8PXV
 4PhH7Tz7JMj7vnWSDslIa4wUVvJNM+ou9tftl0SxbatyLrgdRwrLjDc1SyB/pS4NOhhz
 Yfdg==
X-Gm-Message-State: AOJu0Yw5/emMellkOz61FtrtjYL7yRdJ1zz+zDbKGVCRLYyVdrx9tLXy
 E5VspqAf4BK6S2KHwfnjJf153vnCt/q0R++Xcb+BiiXhanuvKISerOzDBszpNXHkMbyI70NxooA
 +6BvrPq0qsGrEeZAvtJgJaTyrDo//cOrgPl2kIq0CiuQ5oKxwmuT8g2GARi7oKn5bWL4J9I/VTt
 QnNqAW5PR6BGSOjQj92vjBww0MPxyfHs0=
X-Gm-Gg: ASbGncsi+dfQJ+03ESzYolwIKINdqFD4t4GKE6IltWfhCiY+SXiSaIWP+IV12dVtbdG
 f7qx2SbTiUP+ZTvaUOlB+jf62WfavEuwrE7M3UyNv73/NvDUNvx5yv0jpmfh9AP96+i9OzlOaCB
 9aH1tTaT9Ke/a5QoYu1iFc
X-Received: by 2002:a05:600c:3496:b0:456:2832:f98d with SMTP id
 5b1f17b1804b1-4562e298b4amr20575755e9.27.1752661600750; 
 Wed, 16 Jul 2025 03:26:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq4NxhZF+7WF7/6CFmGQEUDjEi+/Vc6X17QHf0DEZOFle70o3j7H3m0eBpagSSM/C9Oyz4D4VgLldNrogidL8=
X-Received: by 2002:a05:600c:3496:b0:456:2832:f98d with SMTP id
 5b1f17b1804b1-4562e298b4amr20575485e9.27.1752661600288; Wed, 16 Jul 2025
 03:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250715124552.28038-1-farosas@suse.de>
 <20250715124552.28038-2-farosas@suse.de>
In-Reply-To: <20250715124552.28038-2-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 16 Jul 2025 15:56:23 +0530
X-Gm-Features: Ac12FXysa4QWkY2riWnFhW4-8F2gAddbAZd0Xj5fMICPlYRcoXwmAXu7hwHTFzc
Message-ID: <CAE8KmOzrFF79P4qUOxH4UtzuymGUWTcSLQan-ee=+EaVwv2dBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] migration: Fix postcopy latency distribution
 formatting computation
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, 15 Jul 2025 at 18:49, Fabiano Rosas <farosas@suse.de> wrote:
> @@ -57,11 +57,9 @@ static const gchar *format_time_str(uint64_t us)
>      const char *units[] = {"us", "ms", "sec"};
>      int index = 0;
>
> -    while (us > 1000) {
> +    while (us > 1000 && index + 1 < ARRAY_SIZE(units)) {
>          us /= 1000;
> -        if (++index >= (sizeof(units) - 1)) {
> -            break;
> -        }
> +        index++;
>      }
>
>      return g_strdup_printf("%"PRIu64" %s", us, units[index]);

* This loop is rather confusing.

* Is the while loop converting microseconds (us) to seconds with:  us
/= 1000 ?  ie. index shall mostly be 2 = "sec", except for the range =
1000000 - 1000999,  when us / 1000 => 1000 would break the while loop
and it'd return string "1000 ms".
===
#define MS  (1000)
#define US  (MS * 1000)
#define NS  (US * 1000)

    if (n >= NS)
        n /= NS;
    else if (n >= US)
        n /= US;
    else if (n >= MS)
        n /= MS;

    return g_strdup_printf("%"PRIu64" sec", n);
===

* Does the above simplification look right? It shall always return
seconds as:  "<n> sec"


Thank you.
---
  - Prasad


