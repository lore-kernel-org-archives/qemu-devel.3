Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D214C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 21:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsrVQ-0003pd-Tp; Fri, 05 Apr 2024 17:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rsrVP-0003pF-LG
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 17:53:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rsrVN-000094-Tz
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 17:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712354028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IlfCfa9FZJKlO/dZuPyAMvYhh5siFNH9Zczt66uAGJI=;
 b=Re9ffoNdPKqO+tDI+AWbT4IQlDeDapNkRzF+qpMDmS9BAstr/NrNBDkHRxWzYcWaWs4w1u
 BLEOKKbsFoEiTbK7TUifiEGJW1PaDZOJRtsQbQCUVzgAZI+UpLtYZz5SPaqE1LLQJbaaiF
 915hRd5i/F0xDIXPCotPLt8irWEylV0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-rAbM8gg4Mjmih1TYXbynQA-1; Fri, 05 Apr 2024 17:53:46 -0400
X-MC-Unique: rAbM8gg4Mjmih1TYXbynQA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-78d3ea0d2faso40690585a.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 14:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712354026; x=1712958826;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IlfCfa9FZJKlO/dZuPyAMvYhh5siFNH9Zczt66uAGJI=;
 b=MIZv7Z9JH74GopfwUYDODm19iFZBYFIr/jMZpH4r8fS1rrkPK8Tu5llYjgo+VuYp8K
 wdiQgJM2ER19QUw5nTdpTHTgrhQrQlEpuw9c6qupg/RiM3bhDPk3pycdFv4U9cis7Tji
 NZlpexb808lntRJdKCJFkiiLiFU5pP+zrg/aYBcwqHpeadMfviom2fu7oD3nTLsawS3U
 5Pr92QyCNUnSrpMUNUxzr1nOc+gqrf9zuy2B7m4qkM7OkJbZsO4VY3+ySFp/BBnvnAAM
 rwHgiGy5EG/BVQC/lTs52YEAtAT8LOZgo+Xu0HA+M5u5PWhYmkQCs8sVx71b2RNwohth
 HELQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWusdpjxECG4XFEKtxVNEbyk7YbgQ+zxjCeSjJ8549YIvocizprDBtlU0ajpDQabhLAI9WHRPY98dtJ8C6I1jL8T2zCeMM=
X-Gm-Message-State: AOJu0YwHBG1lNSFTWArPm8y4S0zfLbG5ku3JUtds93CDj7JlsJJ35sh7
 oIyx/k7Eb9szPFFAqv8garj+LQaMtMdhQ3KE9f/6e9WsKCJHjf5ae8y5cfOOp6fo3RaDOe3ISJI
 UHTekpI2A/LW4Kr9Xo2QoDxvWe0qWcif31kADmNeuoAvvqGqrv23F
X-Received: by 2002:a05:620a:370f:b0:78d:4404:20cb with SMTP id
 de15-20020a05620a370f00b0078d440420cbmr3187270qkb.3.1712354025733; 
 Fri, 05 Apr 2024 14:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHxmH40QAHK6IKkBJuIgeF6wtY5Q/FMS10EwqHNmsq/6rSpwlYlaX0cCuI3Jw12bEm7aY2ng==
X-Received: by 2002:a05:620a:370f:b0:78d:4404:20cb with SMTP id
 de15-20020a05620a370f00b0078d440420cbmr3187243qkb.3.1712354025157; 
 Fri, 05 Apr 2024 14:53:45 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 sq18-20020a05620a4ad200b00788428c2a97sm974238qkn.64.2024.04.05.14.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 14:53:29 -0700 (PDT)
Date: Fri, 5 Apr 2024 17:53:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: lei4.wang@intel.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] migration/postcopy: ensure preempt channel is ready
 before loading states
Message-ID: <ZhByy4YvYl9xLmRP@x1n>
References: <20240405034056.23933-1-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240405034056.23933-1-wei.w.wang@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Apr 05, 2024 at 11:40:56AM +0800, Wei Wang wrote:
> Before loading the guest states, ensure that the preempt channel has been
> ready to use, as some of the states (e.g. via virtio_load) might trigger
> page faults that will be handled through the preempt channel. So yield to
> the main thread in the case that the channel create event hasn't been
> dispatched.
> 
> Originally-by: Lei Wang <lei4.wang@intel.com>
> Link: https://lore.kernel.org/all/9aa5d1be-7801-40dd-83fd-f7e041ced249@intel.com/T/
> Suggested-by: Peter Xu <peterx@redhat.com>

The current version doesn't have any of my credits. :) Thanks, but I'll
just drop it to reflect reality, so we keep the credit to the right ones.

> Signed-off-by: Lei Wang <lei4.wang@intel.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  migration/savevm.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 388d7af7cd..63f9991a8a 100644
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
> +     * hasn't been dispatched.

I'll squash below into it.  If any of you disagree please shoot: valid
until this Sunday.

+     * TODO: if we can move migration loadvm out of main thread, then we
+     * won't block main thread from polling the accept() fds.  We can drop
+     * this as a whole when that is done.

Huge thanks to both!

> +     */
> +    do {
> +        if (!migrate_postcopy_preempt() || !qemu_in_coroutine() ||
> +            mis->postcopy_qemufile_dst) {
> +            break;
> +        }
> +
> +        aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
> +        qemu_coroutine_yield();
> +    } while (1);
> +
>      ret = qemu_loadvm_state_main(packf, mis);
>      trace_loadvm_handle_cmd_packaged_main(ret);
>      qemu_fclose(packf);
> -- 
> 2.27.0
> 

-- 
Peter Xu


