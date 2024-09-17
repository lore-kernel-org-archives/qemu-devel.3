Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B81CAC596
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 19:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqdhI-000121-64; Tue, 17 Sep 2024 15:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqdhC-00010v-Fa
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 15:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqdhA-0002sX-RR
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 15:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726600622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w/0oP6bo75SGXFP+PPXKHmGyt7oKdqfMxTDWfgdu5zc=;
 b=c1HlBTsNeuMbV7t00aW6l2cCxxFtZ9Ik+aY5w8fiFS03/fk9EFHepHdyUpqXqqYbALFiCf
 jGxpxWL72wRQIVARgQdyFkkjyIjCQntEBw/yySWUAciM59pBw+Ota078puJnry+T4LhTTy
 t5j/mO7bOToMAcywSTFWGQU7UKJVG5I=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-SopIYY2sNQmE0lB6morXTQ-1; Tue, 17 Sep 2024 15:17:00 -0400
X-MC-Unique: SopIYY2sNQmE0lB6morXTQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3e04ec015easo4652046b6e.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 12:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726600620; x=1727205420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/0oP6bo75SGXFP+PPXKHmGyt7oKdqfMxTDWfgdu5zc=;
 b=dPdnRPVrGU6+gcddk9Hz+g7/rVoOOf50Ihz1ZQtkAYmblWISnnpSMlOpkxhbc9abzn
 ssxr6fqigTdG9sihtuesprVZIseIIlsc6ejPwWkwowSpt0abPnCA39WlcqJbFk27bJUq
 vn/TpaM0lE5skU0zjE3hRNFaepitZpUuO6D0rZYgnSAvvGegzYjcIfUwNaLSUMlK83L1
 O0reDQycD/LZHi8COCBkJ/PSmNbv2rpe+zeFB4LxCka6VXboUJbl10aOQumv030LhwWm
 yVdcGaCeRb2+f9cSJiaQXteDA6dFwzjhZrlRMXDzMuui10MQtWpQcDWNpbuT0ShzLgcw
 Pm9Q==
X-Gm-Message-State: AOJu0YzKjF0vkqQ752D8S7pIYevjxJEHvyzDUHeIwiy42UOPjKNZj+/p
 uHxXcrQVDwj9cPMKd+GJcYg3kg9lOM4Bhnqafr+nLMunQE/Yxn0pcjbProY3FaTFj4E0xYIhF1E
 cXUEIwBoMK6HZScf94eAUus38rliBVtpzKncUaVOiSPmEFUim9Vtk
X-Received: by 2002:a05:6358:6184:b0:1b5:f81c:875f with SMTP id
 e5c5f4694b2df-1bb14dc25damr745977755d.5.1726600619971; 
 Tue, 17 Sep 2024 12:16:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPhRhKn3tvR6b3opXYvsP1NKsDvv5PO7Ru4rCkhyUN3GZF8TAqcN9G3kITD17hsKhTcQ15Gg==
X-Received: by 2002:a05:6358:6184:b0:1b5:f81c:875f with SMTP id
 e5c5f4694b2df-1bb14dc25damr745975055d.5.1726600619633; 
 Tue, 17 Sep 2024 12:16:59 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ab3eb62cefsm389793585a.102.2024.09.17.12.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 12:16:59 -0700 (PDT)
Date: Tue, 17 Sep 2024 15:16:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] migration/savevm: Remove extra load cleanup calls
Message-ID: <ZunVqQsnReeqnorV@x1n>
References: <20240917185802.15619-1-farosas@suse.de>
 <20240917185802.15619-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240917185802.15619-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, Sep 17, 2024 at 03:58:01PM -0300, Fabiano Rosas wrote:
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
> Fixes: 9e14b84908 ("migration/savevm: load_header before load_setup")

Considering it's a cleanup, do you mind if I further remove this Fixes but
just mention it in commit message (so as to make Michael's life easier when
backport)?

> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
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


