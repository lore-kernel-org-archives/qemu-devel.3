Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924D9C19F4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 20:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4R18-00006e-Ou; Tue, 07 May 2024 16:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4R16-00006A-Ro
 for qemu-devel@nongnu.org; Tue, 07 May 2024 16:02:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4R14-0006tW-Lr
 for qemu-devel@nongnu.org; Tue, 07 May 2024 16:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715112136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qh7wwIWHVIpIToPtb5udgp/4jTsX3l0YsYUXKqN3i4Y=;
 b=UHZ5bIM63QuyIUFLKXNLCiio2VsBUj8L/4XnDvKIPIEq2QvjqPg7FHDpQpC8IHViCzNY6y
 dtv4vOdSYmuuFiokdF6zmS69jmiWuqAyP50RwVDWsIzUUwo4sGoHiLj6zSevJS1fyWx51W
 cqB/5U6acI+JgakW8YDXa914MWTUaQo=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-c4IsaXFjM_Oj1HmIY7OHFw-1; Tue, 07 May 2024 16:02:14 -0400
X-MC-Unique: c4IsaXFjM_Oj1HmIY7OHFw-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3c706438578so183021b6e.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 13:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715112134; x=1715716934;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qh7wwIWHVIpIToPtb5udgp/4jTsX3l0YsYUXKqN3i4Y=;
 b=pKp+IqbfYwtlGwQyXBmBZ3YyaIveWqX95+Lg+V4mpxZ6qIWmj3Xhe9TVq/0Yj697yJ
 BbPM8aN6M5sCmmNyVwQptvMdJ1wUtlnVSzXe6uCSzuXHnbHVDFLinHthCTdwZivYhrnz
 DeF8/yRjRO5QZUNo8HHSp15Z2eIEQ0JF2p0XAH2iZLDZSrZlOdFSlidDAMA3Mk0rqyl7
 ldbULeXvFxxc4u5vnNtBbg/WfmKobZuHcepfUET4Q8Tn6EThXNY7+Ips7EJrTXWdnSEK
 +2ZlNU4icIUxSK10wrcO5knyF51kIh63NycGd5nr5AKg/3I7eBjvkGYsNwSkt0rQR7Ad
 QG0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGI+ETbdRQ4wdr5IgMawzvC4KuB+2YhtnoQ3YTBgTFpfdIlxRZefSmejcKOZUqhgQZzE3TIQK5xMtA1fjOwqFNOYhmJ4A=
X-Gm-Message-State: AOJu0YxI79ck9jRnBHX77EA1uyXvN9vW8iDG1zl/7iso3sRjriL85Ff+
 i6zeKW9k72WjOYK2MprdyKHfC5nCF4Twf8Rs6xz3TFu0KzK6Rprw92Gm6MxPzMNLeL43ckZDUru
 l9fdaef282B56+NH6GarYNfX4OxseuOWr16nC4LkNlhO2p/ki47VJ
X-Received: by 2002:a05:6871:33a7:b0:22d:fb4b:9d11 with SMTP id
 586e51a60fabf-24098cf492emr691701fac.4.1715112133627; 
 Tue, 07 May 2024 13:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWZNlNuNaKkz/AJdrKC0FZH6GWO2zqz66TwPuf0WYummJtgbvE0mHR5TxjRwjUo9gO88jnlw==
X-Received: by 2002:a05:6871:33a7:b0:22d:fb4b:9d11 with SMTP id
 586e51a60fabf-24098cf492emr691654fac.4.1715112133024; 
 Tue, 07 May 2024 13:02:13 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ch9-20020a05622a40c900b00436e193f408sm6737264qtb.28.2024.05.07.13.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 13:02:12 -0700 (PDT)
Date: Tue, 7 May 2024 16:02:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: jag.raman@oracle.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v10 1/7] system/physmem: Replace qemu_mutex_lock() calls
 with QEMU_LOCK_GUARD
Message-ID: <ZjqIwhejOEUJ5qf8@x1n>
References: <20240507143431.464382-1-mnissler@rivosinc.com>
 <20240507143431.464382-2-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507143431.464382-2-mnissler@rivosinc.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 07, 2024 at 07:34:25AM -0700, Mattias Nissler wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Simplify cpu_[un]register_map_client() and cpu_notify_map_clients()
> by replacing the pair of qemu_mutex_lock/qemu_mutex_unlock calls by
> the WITH_QEMU_LOCK_GUARD() macro.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> Reviewed-by: Mattias Nissler <mnissler@rivosinc.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


