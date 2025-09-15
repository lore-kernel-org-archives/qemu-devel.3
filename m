Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBC9CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 16:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyCCH-00005q-UJ; Mon, 15 Sep 2025 12:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uyCCA-0008Mz-Vj
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uyCBu-00081Y-GJ
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757954184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RQSnm7JRtKgv8ObQoCVj4CsUdbYR+71vHyRvMqhQW3E=;
 b=OvlC1zsNkVEEUixoK+OCLrn2Jqc/YoUWKvis5KJYAAaayWI2uuml3WfgXptfHLxxjhQhjc
 dUYuwOLJ+7CjAtzwTjoJN9stEQVQjLpjfGUYE1VJeJEKfTrs2S9j8Ep00mxOTawIFCQB1R
 bmwFk5FvOT9vG/FzL9Uk6RpdLYkIxT0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-zUAmSFl0O06GnoGrjdkyAQ-1; Mon, 15 Sep 2025 12:36:22 -0400
X-MC-Unique: zUAmSFl0O06GnoGrjdkyAQ-1
X-Mimecast-MFC-AGG-ID: zUAmSFl0O06GnoGrjdkyAQ_1757954181
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b07cd31252aso315437966b.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 09:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757954181; x=1758558981;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQSnm7JRtKgv8ObQoCVj4CsUdbYR+71vHyRvMqhQW3E=;
 b=hwt+xZeNcgiE8XxlxJGTWYVfHABWH6WdKOdM4xeaPONFz8DZryzgV6cfC0JkzbsWpi
 8nX14/c9rU0Fp02O3ggO3pUKLs1d6D9XgzStQPIGswxwQIFmUwKaXUjDKoFdyoCf7zjZ
 vtq4rHCdEevXVCWdPHSFnJmJFqm2d0QRoOs8h2/Bm86iOV44PKelo+pRUoEXmjOy+Ftp
 bmot+UUmFog8PBeNCXIYvxg+hB6u01vqkRA1MvGWXRVVBVnN0kNjnuL2NDChWB9rMWGC
 QLLOslbtMCPMug1IrlsGKpJVrck06xBBMsJawHIAh0Fubk1u56BrLtIodsKZiZ8EfC5z
 /HiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNn4muA7vjB1FnSHJ0KxcFyNCtbgm4fMg7wis+eifVvJ700siVLrjPa7DJ0Jna+xrliUL3/4rxMNsM@nongnu.org
X-Gm-Message-State: AOJu0YwwEjJaplMbDHq9P58G3WYIr99RDPTxAaW9Cem3ExbNvv3on900
 1Y3PFTiBzDVnR8oC1YzN7+XBE2PXgs0JzCmT86zXs6kxN7KkY0q0BiCsFBCJzyOROqDG2RN0DAt
 UfF9uMGAw16utHPwy8CRy9glt/oC3txgh6slf/xP3ZDeHDOYJuH3WO2hf
X-Gm-Gg: ASbGncs/twEKsT+gRS0XXa/VmmkmvdGXYWQRfeqC9y4PrnZtJ/s2IPbVgi3VVBL7mjU
 4+R1MnIvKo1hIqfKF/GaigHQU8aKNlifGrLHiC8NROmsj2hUYVqY4SpJP1d2i0V92IKUZXBtgCk
 DyFvhUB+Id6qrGfFfD8FUSa1lNluK/KFM3OUL18DBO39XwmiK0V5zWzMYtNmkmarPCoxtqcB0Gi
 lU9X2+wtKdZQEopn0R9x44RrdhfTEL9zMw1l7QWKhCFblCvBAJRtCD+gshHS7mzfTq6uZuSv75F
 TRA7TQUigQK2yQxALzNBaxwihLkM
X-Received: by 2002:a17:907:9694:b0:b04:2dd0:98 with SMTP id
 a640c23a62f3a-b07a6315eaamr1854101366b.12.1757954181360; 
 Mon, 15 Sep 2025 09:36:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyasPoJ3Az5mj9YM0/AfqXw2MelGa2mY0r7j38K5Dt6z1zKfsJdpmcvWhLXmdQAIUDTLCpsw==
X-Received: by 2002:a17:907:9694:b0:b04:2dd0:98 with SMTP id
 a640c23a62f3a-b07a6315eaamr1854096866b.12.1757954180691; 
 Mon, 15 Sep 2025 09:36:20 -0700 (PDT)
Received: from redhat.com ([31.187.78.47]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07d6bfa591sm626716066b.15.2025.09.15.09.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 09:36:20 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:36:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: amit@kernel.org, armbru@redhat.com, berrange@redhat.com,
 eblake@redhat.com, eduardo@habkost.net, filip.hejsek@gmail.com,
 lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, noh4hss@gmail.com, pbonzini@redhat.com,
 philmd@linaro.org, qemu-devel@nongnu.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, nsg@linux.ibm.com
Subject: Re: [PATCH v2] char-pty: add support for the terminal size
Message-ID: <20250915123544-mutt-send-email-mst@kernel.org>
References: <20250915162535.147642-1-maxbr@linux.ibm.com>
 <20250915163415.149190-1-maxbr@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915163415.149190-1-maxbr@linux.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

On Mon, Sep 15, 2025 at 06:34:15PM +0200, Maximilian Immanuel Brandtner wrote:
> Update the terminal size upon SIGWINCH delivery.
> 
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>


Maximilian, on  a related note, could you comment on the revert
of your patch that I posted to lkml? Thanks!

> ---
> 
> To be committed with the patch-set: [PATCH v4 00/10] virtio-console: notify about the terminal size
> 
> v1 -> v2: Move comment regarding patch dependencies to note section
> ---
>  chardev/char-pty.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index 674e9b3f14..802bae9037 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -28,6 +28,7 @@
>  #include "io/channel-file.h"
>  #include "qemu/sockets.h"
>  #include "qemu/error-report.h"
> +#include "qemu/main-loop.h"
>  #include "qemu/module.h"
>  #include "qemu/option.h"
>  #include "qemu/qemu-print.h"
> @@ -35,6 +36,8 @@
>  #include "chardev/char-io.h"
>  #include "qom/object.h"
>  
> +#include <sys/ioctl.h>
> +
>  struct PtyChardev {
>      Chardev parent;
>      QIOChannel *ioc;
> @@ -43,6 +46,8 @@ struct PtyChardev {
>      int connected;
>      GSource *timer_src;
>      char *path;
> +
> +    Notifier resize_notifier;
>  };
>  typedef struct PtyChardev PtyChardev;
>  
> @@ -85,6 +90,15 @@ static void pty_chr_rearm_timer(Chardev *chr, int ms)
>      g_free(name);
>  }
>  
> +static void pty_chr_resize(PtyChardev *s)
> +{
> +    struct winsize ws;
> +
> +    if (ioctl(QIO_CHANNEL_FILE(s->ioc)->fd, TIOCGWINSZ, &ws) != -1) {
> +        qemu_chr_resize(CHARDEV(s), ws.ws_col, ws.ws_row);
> +    }
> +}
> +
>  static void pty_chr_update_read_handler(Chardev *chr)
>  {
>      PtyChardev *s = PTY_CHARDEV(chr);
> @@ -331,6 +345,12 @@ static int qemu_openpty_raw(int *aslave, char *pty_name)
>      return amaster;
>  }
>  
> +static void term_resize_notify(Notifier *n, void *data)
> +{
> +    PtyChardev *s = container_of(n, PtyChardev, resize_notifier);
> +    pty_chr_resize(s);
> +}
> +
>  static void char_pty_open(Chardev *chr,
>                            ChardevBackend *backend,
>                            bool *be_opened,
> @@ -376,6 +396,10 @@ static void char_pty_open(Chardev *chr,
>              s->path = g_strdup(path);
>          }
>      }
> +
> +    pty_chr_resize(s);
> +    s->resize_notifier.notify = term_resize_notify;
> +    sigwinch_add_notifier(&s->resize_notifier);
>  }
>  
>  static void char_pty_parse(QemuOpts *opts, ChardevBackend *backend,
> -- 
> 2.50.1


