Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDBEC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 19:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2FAh-0007DB-Fw; Wed, 01 May 2024 14:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2FAf-0007Cz-KG
 for qemu-devel@nongnu.org; Wed, 01 May 2024 14:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2FAa-0000HV-Od
 for qemu-devel@nongnu.org; Wed, 01 May 2024 14:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714589947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ph8dMuRy8I+M0kBG5GSXPCBmQmidyeRxcpTmFJpenHE=;
 b=bMq0NVfgKqDCp349MRLgMnyY6FLCutGP9ktMwXHBfigso48YaTohtG4FH6LNsEMzTtizlR
 eMUr3Q72fp0s+GUEg+scK2GESyE1HYZY1U/2ljwN8WwArnNeOlaaH0AlpTmZBgWG1BblSF
 jXrV1ahx8OkApwI5u968o4qgoAreoM8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-peatXu9DM2mk3KvtWCe_FA-1; Wed, 01 May 2024 14:59:06 -0400
X-MC-Unique: peatXu9DM2mk3KvtWCe_FA-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3c82cfb8913so1637660b6e.2
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 11:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714589945; x=1715194745;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ph8dMuRy8I+M0kBG5GSXPCBmQmidyeRxcpTmFJpenHE=;
 b=W/eFeHw3zgRQ9E4HFPP0vpThVGkBMHp3KXi3iyYl/YNAXFF8WYYnXtiF2Ja2KQEgQT
 0rLvawyvHHFy7LlhcGKOMbZxDUjglGo8qH6p1KurEK0g0OIGf1E4BalDuOF24f3Nc7it
 mI7YHPpxKzS0H5vCoiDCEi14s+g0p3O0ojMXo+PaDH+aFk8vc+KvzSxEl0lZA1PzkA7B
 1G4MdgUaQPABzRWUJyjjS22H8Zf3w31Cl5r0SVTlQLx+KZ+oFPfKbTGihyNmT96gxoUG
 SswoM6Enhovt93T0JzK+gnyXff3isMUyofYKI26qAfUxHoWvPfMRwbmJtKz70yhtjpyL
 l0Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8mKMfcMQh939i8GCzdfGU+Qc+6XkP9QeDQALcGm7/k9NARaneS6RRu8w31dXQSm86tWvPXCgdlB6tLU4mbwXncZEgd1k=
X-Gm-Message-State: AOJu0YyHWTnMEVZ2rctvK2tyVV/V5Y38+CVegGCosiSTMXTCPj3iuQDg
 TeQ17HFESZx4dxmdtepze/Sqg4leZuenyCN6XxctjZsVsTcSZNwg1ZrpGWigKcNhXCZi6psEvVs
 QDek3oBHZE+jrymBV3fB3TUWOTOOh8VE2YVYtz5rx4lL8iJhcDUfD
X-Received: by 2002:a05:6808:1a17:b0:3c8:49ef:cdf0 with SMTP id
 bk23-20020a0568081a1700b003c849efcdf0mr4206950oib.2.1714589944924; 
 Wed, 01 May 2024 11:59:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9cAu5RrBlp+h2OREzzIq1ODhiyM43nYBoOaVmKmfK/NNtFJarm6+ep2kVTrjiv/B6srRwBw==
X-Received: by 2002:a05:6808:1a17:b0:3c8:49ef:cdf0 with SMTP id
 bk23-20020a0568081a1700b003c849efcdf0mr4206913oib.2.1714589944358; 
 Wed, 01 May 2024 11:59:04 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 n11-20020a0ce94b000000b006a0f9e2da38sm445632qvo.75.2024.05.01.11.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 11:59:03 -0700 (PDT)
Date: Wed, 1 May 2024 14:59:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@linux.dev>
Cc: marcandre.lureau@redhat.com, farosas@suse.de, armbru@redhat.com,
 lvivier@redhat.com, qemu-devel@nongnu.org,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: Re: [PATCH v4 07/14] util/dsa: Implement DSA task asynchronous
 submission and wait for completion.
Message-ID: <ZjKQ9Sf51OgzONKD@x1n>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
 <20240425022117.4035031-8-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240425022117.4035031-8-hao.xiang@linux.dev>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
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

On Thu, Apr 25, 2024 at 02:21:10AM +0000, Hao Xiang wrote:
> +/**
> + * @brief Performs buffer zero comparison on a DSA batch task asynchronously.
> + *
> + * @param batch_task A pointer to the batch task.
> + * @param buf An array of memory buffers.
> + * @param count The number of buffers in the array.
> + * @param len The buffer length.
> + *
> + * @return Zero if successful, otherwise non-zero.
> + */
> +int
> +buffer_is_zero_dsa_batch_async(struct dsa_batch_task *batch_task,
> +                               const void **buf, size_t count, size_t len)

It says it's "async", but then..

> +{
> +    if (count <= 0 || count > batch_task->batch_size) {
> +        return -1;
> +    }
> +
> +    assert(batch_task != NULL);
> +    assert(len != 0);
> +    assert(buf != NULL);
> +
> +    if (count == 1) {
> +        /* DSA doesn't take batch operation with only 1 task. */
> +        buffer_zero_dsa_async(batch_task, buf[0], len);
> +    } else {
> +        buffer_zero_dsa_batch_async(batch_task, buf, count, len);
> +    }
> +
> +    buffer_zero_dsa_wait(batch_task);

... it waits always.

Wrong function name?

> +    buffer_zero_cpu_fallback(batch_task);

Is this introducing yet another path even if it internally still uses
buffer_is_zero()?

Can we allow buffer_is_zero_dsa_batch_async() (or when it's renamed) fail
directly with a hint that it should fallback?  Ultimately something like:


    if (dsa_is_running() && zero_page_detect_dsa(p)) {
        /* Succeeded */
        return;
    }

    /* Use cpu detection by default, or as fallback */
    zero_page_detect_cpu();

> +
> +    return 0;
> +}
> +
>  #endif
>  
> -- 
> 2.30.2
> 
> 

-- 
Peter Xu


