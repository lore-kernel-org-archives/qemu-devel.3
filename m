Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF80CAC58F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 16:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqbHz-0004ub-Du; Tue, 17 Sep 2024 12:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqbHy-0004qP-6q
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqbHw-0000gZ-Pg
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726591371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xXAoODM891WyCuZ2lqkot9OAEth3wXGCS4cYfWEQaLE=;
 b=MPdkuQET6cCp1mVWWMs2PFDtTGczHY5xylmop+SgW0oSuo5A8MBeLLiFz6wHJgW6qGzw0a
 HdhU0WFAjAVaK0Mq9tm0BwY9qJNWyYkqauehoCj4We/LuIcisopQjliSXvxMyuSRWjZEbD
 aII5z73OiXZOV1rs/vTDYX6uIuRE5zw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-uNItc66YNs2vRFPSb_qOiQ-1; Tue, 17 Sep 2024 12:42:50 -0400
X-MC-Unique: uNItc66YNs2vRFPSb_qOiQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4581253bd26so91612751cf.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 09:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726591370; x=1727196170;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xXAoODM891WyCuZ2lqkot9OAEth3wXGCS4cYfWEQaLE=;
 b=jJ/bt/93ox1tsIFIfLLdYoXC0v7bO4e8rAEuTLyWFm4XJ3XoyzfD9WXm1cQwo23gjm
 jWW3uxd5mHdhfVP01DdhfmnzaeNYXF8UNCgMPdT3+Y8xHUnDxxEf51eSuNATXlkaGvH2
 bfHSNhkF5mrtc8HxJTDlT/4jdFp1h2cMd7f9NUfnSAXWznmP0MEUf3t8p2ItthF6cy5c
 gnlJVxxL5mQrWe4VzJVsGuoYkMjWX9gMcyPskPp6ZsR+ftlnZV4wGTqqTsUTsgCLjHGo
 w264lT3rQFBblzbg+2u8pqiWwsRelZ+2vNIFStQ7P5vg13ouBOoRSnTFWaCXCm8uVQwH
 GwGA==
X-Gm-Message-State: AOJu0Yz0mmArPgPhIS1JqtCkFfRw+lYZMXgA0VLwVYSaWDao7rArPGjM
 cLH+ZiVzNmF5ZlpVZ0Za7088NNPzPwfR/5W3c+v86H+FMkGs56G9q5YbHTv0c0Nwc00OEM+6NXN
 Z3ZiL2EdPUfWkUsIpIJ0imiLRS7BBe9R6q+CG+3WH/UhG6izSlwg43m2YL8Ap7wY=
X-Received: by 2002:ac8:5a45:0:b0:458:37c4:dec0 with SMTP id
 d75a77b69052e-45860416d76mr305956431cf.53.1726591369945; 
 Tue, 17 Sep 2024 09:42:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjDS667fKgiyiFgr+NZYps9ec7sWON3H5+hSyfONeysdzf+cI8NwXSGACOU8IWrBDWVdu9BQ==
X-Received: by 2002:ac8:5a45:0:b0:458:37c4:dec0 with SMTP id
 d75a77b69052e-45860416d76mr305956141cf.53.1726591369597; 
 Tue, 17 Sep 2024 09:42:49 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aad0293asm40025591cf.74.2024.09.17.09.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 09:42:48 -0700 (PDT)
Date: Tue, 17 Sep 2024 12:42:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 1/2] migration/savevm: Remove extra load cleanup calls
Message-ID: <Zumxh3Ey56YhkXcW@x1n>
References: <20240913220542.18305-1-farosas@suse.de>
 <20240913220542.18305-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913220542.18305-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 13, 2024 at 07:05:41PM -0300, Fabiano Rosas wrote:
> There are two qemu_loadvm_state_cleanup() calls that were introduced
> when qemu_loadvm_state_setup() was still called before loading the
> configuration section, so there was state to be cleaned up if the
> header checks failed.
> 
> However, commit 9e14b84908 ("migration/savevm: load_header before
> load_setup") has moved that configuration section part to
> qemu_loadvm_state_header() which now happens before
> qemu_loadvm_state_setup().
> 
> Remove the cleanup calls that are now misplaced.
> 
> CC: qemu-stable@nongnu.org
> Fixes: 9e14b84908 ("migration/savevm: load_header before load_setup")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

We don't need to copy stable, am I right?  IIUC it's a good cleanup,
however not a bug fix, as qemu_loadvm_state_cleanup() can be invoked
without calling _setup() safely?

> ---
>  migration/savevm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index d500eae979..d0759694fd 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2732,13 +2732,11 @@ static int qemu_loadvm_state_header(QEMUFile *f)
>      if (migrate_get_current()->send_configuration) {
>          if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
>              error_report("Configuration section missing");
> -            qemu_loadvm_state_cleanup();
>              return -EINVAL;
>          }
>          ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
>  
>          if (ret) {
> -            qemu_loadvm_state_cleanup();
>              return ret;
>          }
>      }
> -- 
> 2.35.3
> 

-- 
Peter Xu


