Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B53C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 18:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0bn-0005KG-NE; Tue, 27 Aug 2024 14:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj0bh-0004uO-3Y
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 14:07:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj0bf-0002s0-JA
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 14:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724782070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4as5BxY7je6aEGwpA9nw+e9SgZyHoT5GcqfDszf0M8g=;
 b=XQXAYhI4fEklKbYKQEjIDUTX93jDWdnbfiJphPZmTIdFSZj5ShQJkRO2MfeyupIMnqAHWO
 B2qyf8hBSIO3NXL1MtyyWbQKjM15EKF7eM015bWoPidvFujO1RaEpom9dc7dAj41MKYfwV
 34DwCUrrUVFXUzYa5wm1hrpVrxDqyiQ=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-HloKZIAhMR-2rEO-p9HOeA-1; Tue, 27 Aug 2024 14:07:48 -0400
X-MC-Unique: HloKZIAhMR-2rEO-p9HOeA-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-27006d8b76fso8695248fac.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 11:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724782068; x=1725386868;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4as5BxY7je6aEGwpA9nw+e9SgZyHoT5GcqfDszf0M8g=;
 b=Nj8FqDM7pEeeP5y92PCgvhPqInLiHdCWYnNeo5OF+EWbsy6cFlgRwm162/OcLhay/C
 D2w4bmrVQAymr1Ithv5cf8+f1UNjq3l9rpUAPTogq9rKHGNVHx9Ip+bybrxEA7xNFL9o
 pciNSD1aUO8DNelYtai2B+MWzHETAAJLPh8GNKCapN3pdG+hL3A7vB7dFGd4k1aKkm4E
 +OO4Taze+/4Ts1f9JLbqb1c5goSiwPRIiMkdNRax6BCKlPxfPYxv+pIW1ZsWAC0diaB0
 qqu6hQ1fYYlnkMsnEPrZciQuzXp2A3NqNC/Rd+wmA6qYVqDSZ/gwUlqjWyMU9rGFCUvj
 ZARA==
X-Gm-Message-State: AOJu0YyZD023ClWUtK3l9kj/8OzmNCedgyhdlN9mgzDY/r9dzbVC+Lmy
 8XrZ1C3BkdcU+A26h22fTUY20YS+RDWoXawPSy0xvWwTAR1OfoVo3lR0bWYjpgnfVQJr+TQUQga
 NpTDU9CwRmfrLhk2qbHf4vrVxAKQZRwk+Ynr3tIthk55L/0vunGKT
X-Received: by 2002:a05:6870:ecab:b0:270:138a:5e57 with SMTP id
 586e51a60fabf-273e672614bmr16552749fac.44.1724782068200; 
 Tue, 27 Aug 2024 11:07:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbA/c3yk2IWsPoxnA9+lTuwOu1I3zg8tGMBJ8xwt93Cr0R6AHofCpddqim9qq9iUNo7A4ZmA==
X-Received: by 2002:a05:6870:ecab:b0:270:138a:5e57 with SMTP id
 586e51a60fabf-273e672614bmr16552730fac.44.1724782067861; 
 Tue, 27 Aug 2024 11:07:47 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-273cea242e5sm3217494fac.31.2024.08.27.11.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 11:07:47 -0700 (PDT)
Date: Tue, 27 Aug 2024 14:07:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 18/19] migration/multifd: Stop changing the packet on
 recv side
Message-ID: <Zs4V8HajCAzNS3ZZ@x1n>
References: <20240827174606.10352-1-farosas@suse.de>
 <20240827174606.10352-19-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827174606.10352-19-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 27, 2024 at 02:46:05PM -0300, Fabiano Rosas wrote:
> @@ -254,12 +250,10 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
>          return 0;
>      }
>  
> -    /* make sure that ramblock is 0 terminated */
> -    packet->ramblock[255] = 0;
> -    p->block = qemu_ram_block_by_name(packet->ramblock);
> +    ramblock_name = g_strndup(packet->ramblock, 255);

I understand we want to move to a const*, however this introduces a 256B
allocation per multifd packet, which we definitely want to avoid.. I wonder
whether that's worthwhile just to make it const. :-(

I don't worry too much on the const* and vars pointed being abused /
updated when without it - the packet struct is pretty much limited only to
be referenced in this unfill function, and then we will do the load based
on MultiFDRecvParams* later anyway.  So personally I'd rather lose the
const* v.s. one allocation.

Or we could also sanity check byte 255 to be '\0' (which, AFAIU, should
always be the case..), then we can get both benefits.

> +    p->block = qemu_ram_block_by_name(ramblock_name);
>      if (!p->block) {
> -        error_setg(errp, "multifd: unknown ram block %s",
> -                   packet->ramblock);
> +        error_setg(errp, "multifd: unknown ram block %s", ramblock_name);
>          return -1;
>      }

-- 
Peter Xu


