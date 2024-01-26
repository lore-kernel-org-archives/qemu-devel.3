Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6137BC47258
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 03:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTCb5-0005wF-Td; Thu, 25 Jan 2024 22:09:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rTCb3-0005vl-W4
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 22:09:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rTCb2-0003nM-Ec
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 22:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706238574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DQ6aU0hBhJsSBKI4V+8lS/22slOoEFPlO+42UiaJ0+A=;
 b=N0EA3CnbyRQs4IuOq9QpeTevLYxHhEe6/jP0NQ30punT0QGifhy5X8B9cWwjT4AGNRb/aY
 asAo1cwctG3EURxn/p1ajUXQ2w1UqXFZLbCOPPXMnPrSRFN1NssciPlfX8R1ncFy097BL7
 TYBxEe6OyEU05Bn9R2lKKBr63Ix1VuQ=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-k7YXVQRsMDmMk_zd68pXKw-1; Thu, 25 Jan 2024 22:09:31 -0500
X-MC-Unique: k7YXVQRsMDmMk_zd68pXKw-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6dea8b7e74aso2237970a34.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 19:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706238571; x=1706843371;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQ6aU0hBhJsSBKI4V+8lS/22slOoEFPlO+42UiaJ0+A=;
 b=ML1q1oXmfVYm0UTzhwp6kzTPQraKLMOHI0Mq/FJrRd4BL4jmcleEwuU2Ywo55LY0h8
 kMxbfWqXzvwf2P/c+HC3myjYjR0YyETeCCk4rGAgeqypS5ffmEEWrLb0h/o0yUPuh9E5
 X//djHe8GIyhqKzNGq4U7dYo1Qk6eRjIO2h6YgFGYRaaZXAaV86ESig0a8Mv+0UXY5qJ
 I54Oo8sT+7mV9yvtkhxdv/yPRwp6uMKhzFuXmMcBEeFSYf9sD3p+cTuwLW4R/3mDrN7+
 htH3++8PxQuPJHZOl0HttvQHoLOBJsqJ8fjH/sRmNdOF2xKFysuy9ktun3Jyesw0F8Py
 QofA==
X-Gm-Message-State: AOJu0Yz8TxbdhTHj0QhVcp+wNPMhNpgBRx+FcTNtPdQYIVVO0OMW9iNH
 mmAwM9QFBuRyLLOosPFM6lwotASHJfDmm6SrupCO8mduru/plfP1cA4SYiGb+Ox4l6Q0G1n1D0S
 BuTewK3VuENSuSyiMxpU7GgIwXRwoA4qyhPCfVkBkzr0A6gCvR8qm
X-Received: by 2002:a05:6870:a2ca:b0:214:c78e:b69c with SMTP id
 w10-20020a056870a2ca00b00214c78eb69cmr1302867oak.0.1706238571098; 
 Thu, 25 Jan 2024 19:09:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEAtrkWdLn8hn/W3K32PR3OoXLoVxXzkd40MVOf9AQdgQ1gNy69V5x9Ls9UekaTOdq95w2ug==
X-Received: by 2002:a05:6870:a2ca:b0:214:c78e:b69c with SMTP id
 w10-20020a056870a2ca00b00214c78eb69cmr1302851oak.0.1706238570774; 
 Thu, 25 Jan 2024 19:09:30 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 m1-20020a634c41000000b005cfd70edc1bsm239797pgl.7.2024.01.25.19.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 19:09:30 -0800 (PST)
Date: Fri, 26 Jan 2024 11:09:26 +0800
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 01/17] migration: Fix logic of channels and transport
 compatibility check
Message-ID: <ZbMiZgvrSpkw1PvW@x1n>
References: <20240125162528.7552-1-avihaih@nvidia.com>
 <20240125162528.7552-2-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240125162528.7552-2-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jan 25, 2024 at 06:25:12PM +0200, Avihai Horon wrote:
> The commit in the fixes line mistakenly modified the channels and
> transport compatibility check logic so it now checks multi-channel
> support only for socket transport type.
> 
> Thus, running multifd migration using a transport other than socket that
> is incompatible with multi-channels (such as "exec") would lead to a
> segmentation fault instead of an error message.
> For example:
>   (qemu) migrate_set_capability multifd on
>   (qemu) migrate -d "exec:cat > /tmp/vm_state"
>   Segmentation fault (core dumped)
> 
> Fix it by checking multi-channel compatibility for all transport types.
> 
> Fixes: d95533e1cdcc ("migration: modify migration_channels_and_uri_compatible() for new QAPI syntax")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


