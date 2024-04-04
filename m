Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18CDCD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNoh-0002Pt-MN; Thu, 04 Apr 2024 10:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rsNof-0002Pd-8D
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rsNod-0007Qu-El
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712239900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lDE6mx8GzSIBhPLhITZ5t94lnkwSf5gSOj3/4eVCzX0=;
 b=LbLXmLno1kzo9YLPfXHfPRz/oiARhHog5FMhnhjel7H7THL3vcFdajfn7xUdAXWrsBVALn
 fZFT3B1fnKSkeE0iD2np7iyvdBA65bgX8pH8bhoW79Pe4Zq9nHBOJhmbjVfn3oF2EROg2n
 DWM5F/Qn/7aOydJ+2Mz/WWhOsaqmB5U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-f_o3F2dJPbijH8ZQyLdalg-1; Thu, 04 Apr 2024 10:11:39 -0400
X-MC-Unique: f_o3F2dJPbijH8ZQyLdalg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6993921ae18so618466d6.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 07:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712239898; x=1712844698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDE6mx8GzSIBhPLhITZ5t94lnkwSf5gSOj3/4eVCzX0=;
 b=CKhzV8Eeto+0FwFG2cM5YCLBIxtR6sDngg3nc1Cul9M/BY32t0ZGLXJlyCqZ4WPLdG
 QThQYmOsx3wU+FgVJtM9/QpTYUQWJgtQFjJK1pLwO2Vm6esFUDVLfwgZL5JD8LJORmG9
 wnq9vjdx3axD7LenYop8uD8EDSnvvx6VuHwFY3UyV+g+xwWJ7woXnoAvbuL0nO7CrEed
 hmCVTNXxsXp+mcWuAuTV3Q8pBCtZGEfaax0i8MI7BgNDUi4Dx8cZb5MgLhmR3dK/WX6a
 NNe3NMZfkKgk/ekjauMHa3lJnqtP0TdSoKv/t3lDyEqZlKtDfyX6XZyY0qmw3PXatShe
 luDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLuWr4XH49XGDvzsd5EAbSaub2oYluWCoWhXK45ga1El69Qlds7JCXTxvbB2FPghm0xl9DWvvUIEC9dK6z7zIIb+cKjXw=
X-Gm-Message-State: AOJu0YyBSBqcviW15kyN6ycSQCez07DcxtnuUqt+Uql2J38dg63eX3XW
 J/STQF3sC8V6hQeyZi949CYiRJpJUCTbcYzqjNhimepewqa+AOYDfx4sDW4kAI9sFIpxtocGpbk
 Zn/5t5V0ubgX2rL+zvba5brPHvEbt/urgZjZkebo9Bqrhiy4xb+Nd
X-Received: by 2002:a05:6214:405:b0:699:1c74:bd54 with SMTP id
 z5-20020a056214040500b006991c74bd54mr2424583qvx.3.1712239897566; 
 Thu, 04 Apr 2024 07:11:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4KAtWPy5LMGnLX4F8f0xq136VtDjHN64pAFnZRZDtjFFVaKG0mlllRkAH7R063VTgNRLlIg==
X-Received: by 2002:a05:6214:405:b0:699:1c74:bd54 with SMTP id
 z5-20020a056214040500b006991c74bd54mr2424550qvx.3.1712239896959; 
 Thu, 04 Apr 2024 07:11:36 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 pt17-20020a056214049100b00699103a1cf1sm3296876qvb.119.2024.04.04.07.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 07:11:36 -0700 (PDT)
Date: Thu, 4 Apr 2024 10:11:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: lei4.wang@intel.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v1] migration/postcopy: ensure preempt channel is ready
 before loading states
Message-ID: <Zg61FnuPPAYAJs45@x1n>
References: <20240404100550.17777-1-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240404100550.17777-1-wei.w.wang@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Apr 04, 2024 at 06:05:50PM +0800, Wei Wang wrote:
> Before loading the guest states, ensure that the preempt channel has been
> ready to use, as some of the states (e.g. via virtio_load) might trigger
> page faults that will be handled through the preempt channel. So yield to
> the main thread in the case that the channel create event has been
> dispatched.
> 
> Originally-by: Lei Wang <lei4.wang@intel.com>
> Link: https://lore.kernel.org/all/9aa5d1be-7801-40dd-83fd-f7e041ced249@intel.com/T/
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Lei Wang <lei4.wang@intel.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  migration/savevm.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 388d7af7cd..fbc9f2bdd4 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2342,6 +2342,23 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
>  
>      QEMUFile *packf = qemu_file_new_input(QIO_CHANNEL(bioc));
>  
> +    /*
> +     * Before loading the guest states, ensure that the preempt channel has
> +     * been ready to use, as some of the states (e.g. via virtio_load) might
> +     * trigger page faults that will be handled through the preempt channel.
> +     * So yield to the main thread in the case that the channel create event
> +     * has been dispatched.
> +     */
> +    do {
> +        if (!migrate_postcopy_preempt() || !qemu_in_coroutine() ||
> +            mis->postcopy_qemufile_dst) {
> +            break;
> +        }
> +
> +        aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
> +        qemu_coroutine_yield();
> +    } while (!qemu_sem_timedwait(&mis->postcopy_qemufile_dst_done, 1));

I think we need s/!// here, so the same mistake I made?  I think we need to
rework the retval of qemu_sem_timedwait() at some point later..

Besides, this patch kept the sem_wait() in postcopy_preempt_thread() so it
will wait() on this sem again.  If this qemu_sem_timedwait() accidentally
consumed the sem count then I think the other thread can hang forever?

That's why I put the wait before creation of the preempt thread (in
postcopy_ram_incoming_setup()), as we can only consume the sem once, so we
must prepare the qemufile when the thread is created.

Thanks,

> +
>      ret = qemu_loadvm_state_main(packf, mis);
>      trace_loadvm_handle_cmd_packaged_main(ret);
>      qemu_fclose(packf);
> -- 
> 2.27.0
> 

-- 
Peter Xu


