Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27500C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 16:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKgO3-0005QV-5s; Thu, 29 May 2025 12:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uKgNm-0005Fh-OS
 for qemu-devel@nongnu.org; Thu, 29 May 2025 12:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uKgNk-00072d-Ir
 for qemu-devel@nongnu.org; Thu, 29 May 2025 12:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748537127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=buCry4UNVCTa92ygNHYyW79BgyG65e03L+X/cpwKkw8=;
 b=Z7TVkntTxJrci8XhnFyP1iEdshN+jaoYhCmNDIfhSynxFrJIGD9GEqfbseJSTw3ZUUJ6e0
 7nZ3J4gFgZaHaFj+m9BaGpfb7u2hIEVMfEILOswqWeOxLzUjfEj7AoCGLkUOG/f5/Ngm9S
 a2p/f8kRY30tOPDkVGMheZyHFcw27rQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-ladUIxhAOSKxIeFVfYlKKg-1; Thu, 29 May 2025 12:45:26 -0400
X-MC-Unique: ladUIxhAOSKxIeFVfYlKKg-1
X-Mimecast-MFC-AGG-ID: ladUIxhAOSKxIeFVfYlKKg_1748537124
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d209dc2d3so7568635e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 09:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748537124; x=1749141924;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=buCry4UNVCTa92ygNHYyW79BgyG65e03L+X/cpwKkw8=;
 b=aDlOzq3EOclHPTxA71beyAYC0x0Yn+AohWxpaTnF1pOjf9GRyshdhct45S8xodL66d
 M+bFLKHkAexkRAu99ZyflcSH4ab34dEV81Rh+NTPzog4MGU0x0d0l0APDVZd1usZYArf
 4zEudwxrdxnm334Soa8hRTo8jM+jCKu7eQUz22vXVnwvK12Fdlk8MQBD2qBkdcZEiNn9
 VCn4b/Pt+dOF44a1jhZx3LQNnEPz67TH4IeuYZXFfHYPoVmQplhcAwxWS2Z20EsbIyy7
 sMKvYYhjXUZMmMuczf/RAznCs/ntxv9SOhsyIWLAJLXuwU/i4PHN6ZIMq0war+5i/t8x
 QCLQ==
X-Gm-Message-State: AOJu0Yx3145h0DsupMgHo3w9YxUDFqcSpEY1paAnXXroM1hu0AwJhfsO
 2hyxyS6j9c/vsbfD2yGZDPupEMYunp9bskRKBuaX3+bgOeOF/HDx2UWIFZoWnXHXTMQKLIZuZP5
 uYfUy8tssn7VwVvJF6lpjW4hHS9tAtYfTdg0xvopzoTHJJnWKaqISYa3d
X-Gm-Gg: ASbGncs6HanSPU1xI3nPwtjlp3TRex6TqahYMOAVDXSPnLtDfCSAC4mkMeGDpndCftt
 gj4K5aBSXUTGjIxMz00gjdhpmtyQr6uEddsPWBjXWPbgxu1TSuTaxqVN7/Y3PKf4TpCv78Kv3LZ
 kUe6P9jUxaXr+31YhEhSmlrGCntnOZA24osjQSwsFaXYjl1kEV0au5wPOM636K8hJFAWgIWxRUc
 Ni1r9bO31yNAeE7+SodKHXsMw1h7ZtPib8uJMvHP10plwupuPEXNnDuBbxfKzSSC1nKwY3ym02m
X-Received: by 2002:a05:600c:8509:b0:43c:e467:d6ce with SMTP id
 5b1f17b1804b1-450d64c313cmr4816765e9.4.1748537123823; 
 Thu, 29 May 2025 09:45:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNY/nTvyJ6M1yebNl9y7APjYgQWCxBuIlTSA10zuS56RzXZcLNh38rZU28GuG4dk2Z9EAxkw==
X-Received: by 2002:a05:600c:8509:b0:43c:e467:d6ce with SMTP id
 5b1f17b1804b1-450d64c313cmr4816575e9.4.1748537123508; 
 Thu, 29 May 2025 09:45:23 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d63feb5fsm3186565e9.25.2025.05.29.09.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 09:45:22 -0700 (PDT)
Date: Thu, 29 May 2025 18:45:20 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 03/11] migration/docs: Move docs for postcopy blocktime
 feature
Message-ID: <ng5ndrdeaf3z4jkqj7a4ib335xxf5sywavskdodakeaa74wchh@wllaxzdwprlz>
References: <20250527215850.1271072-1-peterx@redhat.com>
 <20250527215850.1271072-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527215850.1271072-4-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2025-05-27 17:58, Peter Xu wrote:
> Move it out of vanilla postcopy session, but instead a standalone feature.
> When at it, removing the NOTE because it's incorrect now after introduction
> of max-postcopy-bandwidth, which can control the throughput even for
> postcopy phase.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/devel/migration/postcopy.rst | 36 +++++++++++++++----------------
>  1 file changed, 17 insertions(+), 19 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


