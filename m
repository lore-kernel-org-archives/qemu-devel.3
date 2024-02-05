Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B307BC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 05:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWrus-00046u-Lx; Mon, 05 Feb 2024 00:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWrur-00046P-9X
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 00:53:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWrup-0001gF-QH
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 00:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707112391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UcbqRLjvCb0c2dlrtuGN829YRBbkOEG91btAk1GqZWE=;
 b=TX63MoTb21Ag+opJWYvpUYizslMKtIoOOtdmzEeqWhXaq9gHc7Oy6PqtLzRbzenrRxrFsh
 1oGnVWExQeizlzpfZrsLjTbz5ZeKaCPeBAGUhmZYZO/Xd/MsfogNPDdwpOuYHgj4NIkC/7
 b2LVBgGzniOxyv6/JzXtG9q/JjBls0M=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-vxt-IzvnObCI5jMAOLIZ0Q-1; Mon, 05 Feb 2024 00:53:09 -0500
X-MC-Unique: vxt-IzvnObCI5jMAOLIZ0Q-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28c0765415eso598131a91.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 21:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707112387; x=1707717187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UcbqRLjvCb0c2dlrtuGN829YRBbkOEG91btAk1GqZWE=;
 b=ToIeWXpnoMqTSX7W6bvAjjTkNDJ1oJe1n48HMVaKpef282i9VxxZZNVc1xdiGcuoI3
 ogLsr9qtdKJaas10nNYSuxn+ue1FocoYzBF3JFt5a1tBeQeeWjj1djYa0QN8A2GqqHnI
 xIi4JsQZF2JDlBhHnKYr/cnE26G8DB3SZzrGM7jzYj4xFDwP7EFn3ehg5RBAIr4CPFdi
 GiwR1T7BQGx/aMy5XqDLfyKpL47OdC2ynbfhQwjEgdm+CO2xmbg247x4oCyDQkGsMUEv
 HMUAQNpWDCchxNmTsOy2HOrUw6y3ZX/urFVaiaXqJ2IxD1jqCqspqVJVRr2RIUP87kkF
 jjhQ==
X-Gm-Message-State: AOJu0Yx5/c/U8xHA7xB7o9cwd01OK2Olpu5kGhq78zEe2L93AKIpVGe+
 ClDGOY/CEjx++sS6VQAetCKIYDvWjTRZveWNuFV8dwbTBgBe1y5e+Qz1Nl51kjkIpGYSRaNm3iy
 2SMFoHXdjJavWo+rteI1dQpwyWP8SdJv+d19F7n6Q4RaKQxN3yaMfUEnQmFmLzvE=
X-Received: by 2002:a17:90a:ab8d:b0:290:f5f7:caff with SMTP id
 n13-20020a17090aab8d00b00290f5f7caffmr14720739pjq.3.1707112387639; 
 Sun, 04 Feb 2024 21:53:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElKFumvWMB5/+7PlZD6y8SQ4naoshGEsUYfKdz5bdPoZdZe21/ukWbhhpQPahkoYlUfuv35Q==
X-Received: by 2002:a17:90a:ab8d:b0:290:f5f7:caff with SMTP id
 n13-20020a17090aab8d00b00290f5f7caffmr14720729pjq.3.1707112387305; 
 Sun, 04 Feb 2024 21:53:07 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXFtqQPsXacByreFnyQc5SSVNROzR7e7d6wd7Z8i1yHwNooktBwXfDBzhbeTQhj3tlkzRlqtrwyLq8nG9BJJFadg/w=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 c10-20020a17090ae10a00b00296346845cdsm4271082pjz.18.2024.02.04.21.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 21:53:07 -0800 (PST)
Date: Mon, 5 Feb 2024 13:52:54 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH 4/5] migration/multifd: Move multifd_save_setup into
 migration thread
Message-ID: <ZcB3tpl-SApJ5738@x1n>
References: <20240202191128.1901-1-farosas@suse.de>
 <20240202191128.1901-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202191128.1901-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Feb 02, 2024 at 04:11:27PM -0300, Fabiano Rosas wrote:
> We currently have an unfavorable situation around multifd channels
> creation and the migration thread execution.
> 
> We create the multifd channels with qio_channel_socket_connect_async
> -> qio_task_run_in_thread, but only connect them at the
> multifd_new_send_channel_async callback, called from
> qio_task_complete, which is registered as a glib event.
> 
> So at multifd_save_setup() we create the channels, but they will only
> be actually usable after the whole multifd_save_setup() calling stack
> returns back to the main loop. Which means that the migration thread
> is already up and running without any possibility for the multifd
> channels to be ready on time.
> 
> We currently rely on the channels-ready semaphore blocking
> multifd_send_sync_main() until channels start to come up and release
> it. However there have been bugs recently found when a channel's
> creation fails and multifd_save_cleanup() is allowed to run while
> other channels are still being created.
> 
> Let's start to organize this situation by moving the
> multifd_save_setup() call into the migration thread. That way we
> unblock the main-loop to dispatch the completion callbacks and
> actually have a chance of getting the multifd channels ready for when
> the migration thread needs them.
> 
> The next patches will deal with the synchronization aspects.
> 
> Note that this takes multifd_save_setup() out of the BQL.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


