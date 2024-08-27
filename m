Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9142AC54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0RV-0004fP-7y; Tue, 27 Aug 2024 13:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj0RO-0003xi-6r
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj0RL-0001gr-94
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724781430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w0Xkki3rEimb5GJg6vpPo8ZJMo7SCoI3424WNvjsAUE=;
 b=YIhVmnkZK9GZPPNGOng3Mdia6KNWia1Itoxu98WeQRB6wfrE8G1cuuPWNv00N7ia30IqqC
 r4l/7i/4ApwS1OY7E+s8zr9GTajoFGaLa6fcjyXAUQBDQqx9ma+I2bjhPdHU1TGx2KFb3Q
 bOHtRpcAX/HbJWoD7JOesFSJWqTp2J4=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-J22USouJNB6qVARQqETWzQ-1; Tue, 27 Aug 2024 13:57:08 -0400
X-MC-Unique: J22USouJNB6qVARQqETWzQ-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3d228774f59so541945b6e.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 10:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724781427; x=1725386227;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w0Xkki3rEimb5GJg6vpPo8ZJMo7SCoI3424WNvjsAUE=;
 b=sXV4irmccLidSL9sZRFcrB/io3h9BmeQ3eSYv4tsnIuHZ1nTyBisf9xc5mxfFCrg+J
 5jdMs6dSSsc48xRY8gXT98dPraTUmQWwoorvoy2Xtfo8yoI1QaiKqGf628q6KsGNy569
 BdX1+jjhMszU03RnvrI5WExhZgRkAB5NxmoY9PIALT2sM+hFXJAZnHPmVyBJU0O+UK/n
 +W7PQzodFd/c9D6noIMycA1pFSqgAmMNurb+OgvIc1binwa5ZrszWXe6RYlj0nKstanS
 GFPJ302Z5ekemfzLtEDnFD6K8aJH4XKPHgLyaCAuH3UXgBR2CAlCoo4ce2hdnq9e7xND
 WOnw==
X-Gm-Message-State: AOJu0YxNLUgRF6YOFxPCKnK+ep4bPa3Hgekub9P/mvNOLkRlca1Ed3Dz
 T5/N00TQN9OtG20dB3G2dvx+kTeFk7Fva2endbkgyiKlKcxpjIyE5OfuDSkAnue32RxNOwKDl5L
 9+h8Y3ufZ6cH9s8BV7vzpe88Zy2hsUUOJDsodeLTqAgNK4PD6gvw0
X-Received: by 2002:a05:6808:2384:b0:3d9:3b45:f56b with SMTP id
 5614622812f47-3defed136a9mr5695b6e.12.1724781427417; 
 Tue, 27 Aug 2024 10:57:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQSFwXsE92DlcXXEr39CnSUVD7IaFUIYaJ3IgXIhq4VaIZCGOC06qrb5KmobtpFbcYQMLIPg==
X-Received: by 2002:a05:6808:2384:b0:3d9:3b45:f56b with SMTP id
 5614622812f47-3defed136a9mr5690b6e.12.1724781427112; 
 Tue, 27 Aug 2024 10:57:07 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3de225c532fsm2602497b6e.43.2024.08.27.10.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 10:57:06 -0700 (PDT)
Date: Tue, 27 Aug 2024 13:57:04 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1] softmmu/physmem: fix memory leak in
 dirty_memory_extend()
Message-ID: <Zs4TcHvfwhBFSWvQ@x1n>
References: <20240827083715.257768-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827083715.257768-1-david@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 27, 2024 at 10:37:15AM +0200, David Hildenbrand wrote:
>  /* Called with ram_list.mutex held */
> -static void dirty_memory_extend(ram_addr_t old_ram_size,
> -                                ram_addr_t new_ram_size)
> +static void dirty_memory_extend(ram_addr_t new_ram_size)
>  {
> -    ram_addr_t old_num_blocks = DIV_ROUND_UP(old_ram_size,
> -                                             DIRTY_MEMORY_BLOCK_SIZE);
>      ram_addr_t new_num_blocks = DIV_ROUND_UP(new_ram_size,
>                                               DIRTY_MEMORY_BLOCK_SIZE);
>      int i;
>  
> -    /* Only need to extend if block count increased */
> -    if (new_num_blocks <= old_num_blocks) {
> -        return;
> -    }

One nitpick here: IMHO we could move the n_blocks cache in ram_list
instead, then we keep the check here and avoid caching it three times with
the same value.

> -
>      for (i = 0; i < DIRTY_MEMORY_NUM; i++) {
>          DirtyMemoryBlocks *old_blocks;
>          DirtyMemoryBlocks *new_blocks;
> +        ram_addr_t old_num_blocks = 0;
>          int j;
>  
>          old_blocks = qatomic_rcu_read(&ram_list.dirty_memory[i]);
> +        if (old_blocks) {
> +            old_num_blocks = old_blocks->num_blocks;
> +
> +            /* Only need to extend if block count increased */
> +            if (new_num_blocks <= old_num_blocks) {
> +                return;
> +            }
> +        }

-- 
Peter Xu


