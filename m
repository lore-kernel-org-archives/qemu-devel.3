Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325E2C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 20:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgs0K-00006N-J1; Wed, 21 Aug 2024 16:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgs0I-00005G-RK
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 16:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgs0H-0005Yz-2e
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 16:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724272343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4VmwTkSSV5Lx7pSA222ZVQE3BrzzWAJtm8007cfu8yY=;
 b=Z9LGeb3msT2BhetkqEM5M6kYQNLSz74eamLh/5u6Jq/19mnOtS0gyEqDKnco+UWQ/Pwuij
 22ZiHuFnJnwMql68j0IItpk8iq3gJX8yl4cjgY3tFlot7x01HdZ62QMM2/neemiZ7LTD9f
 Ien8iXqKAsVIrWv09Ewv+zVdbZRdtXQ=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-DkjQppJwOtyvgG6rEO_Xwg-1; Wed, 21 Aug 2024 16:32:17 -0400
X-MC-Unique: DkjQppJwOtyvgG6rEO_Xwg-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7092f2d50ceso117540a34.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 13:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724272337; x=1724877137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VmwTkSSV5Lx7pSA222ZVQE3BrzzWAJtm8007cfu8yY=;
 b=Tbjn9qdW1IMWgTFaGvoyPgFiawxXS9NMH3MgCSRatDLDY03qixC0CrqwmkrIO7Q4Cy
 VH2Lxz0+iUAdYyYe4pNbnPDzh32U03zHMA1DSSG5p2fuNKDgBxI1QXbpxxpwdkx1knph
 ubH3xmXlEyACJs7yWL+UpASO5/q+ybnjRPbtA0xSfwbkwhwIPGW4LYOys6t1sEzRzxVt
 ZufMYw0NR8WtzlLQyoh++xLTpkeMfG88HUn/Ciy46BWH/tjQkRYkwJNIYbNnmbB+Ieur
 7i46yMLM9clSo+bPg89Fz6brIkjrzx44DfVpbxV5X4DDJSFfd4vfnMKYpU11Ul+Itsee
 0I2A==
X-Gm-Message-State: AOJu0YybF1JPBtc9Pf5iKR6lM7wWFWZLUjUUVm+GCNFNQdxCCj+SBv/+
 eKsVXX3AJ+v697llEUxypZySOrsE3OHq3WnlctVNVGIanmyz7aTSWNdfzgZP4mDX6Gum/pVzM76
 IrzGJ3EFrXWzKRW7QNOLVmE30+BGXlyIqlw0+6BlkUC3uvcutaH4L
X-Received: by 2002:a05:6830:6a9b:b0:704:7b8c:ba0c with SMTP id
 46e09a7af769-70df888d456mr3869406a34.30.1724272337042; 
 Wed, 21 Aug 2024 13:32:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERTJYU7rPXW2sT2cWo7nKu2E5qsGaiOm6XOLyLOw2A04HK2Hi/d362M3RzN3pvv4M7iMe1ww==
X-Received: by 2002:a05:6830:6a9b:b0:704:7b8c:ba0c with SMTP id
 46e09a7af769-70df888d456mr3869396a34.30.1724272336762; 
 Wed, 21 Aug 2024 13:32:16 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162de8d39sm485276d6.146.2024.08.21.13.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 13:32:16 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:32:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 03/14] migration/multifd: Remove pages->allocated
Message-ID: <ZsZNaAokUw0cOjao@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801123516.4498-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Aug 01, 2024 at 09:35:05AM -0300, Fabiano Rosas wrote:
> This value never changes and is always the same as page_count. We
> don't need a copy of it per-channel plus one in the extra slot. Remove
> it.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


