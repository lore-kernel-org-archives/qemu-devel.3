Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20B7D2A53E
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 18:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t196e-0004xk-EO; Wed, 16 Oct 2024 14:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t196Y-0004wZ-O8
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 14:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t196X-0007E1-Eg
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 14:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729104640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gU9i1C9Aue71SbAzvGLEJdlu3vP+mqyy1BUKddErPYY=;
 b=Q+jfVXUEJvBpn18Rpu/p+HksyJ7LBM2viowRkP1kHWJ/Aje4V8FxWeKhB+fDk/107AjI04
 WVULwRVMjD4rAl1v0NFPVz80E1UyqFPjDcB9EM92CxC9HG0AIBkkT04vpGQMEkHzwCQfbt
 G+4Vd9VV3+riMn+5rjeX6ked58oHYVU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-LnYnjnPuN_mZxCGUOVLmoQ-1; Wed, 16 Oct 2024 14:50:38 -0400
X-MC-Unique: LnYnjnPuN_mZxCGUOVLmoQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b13ff957cbso18174485a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 11:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729104637; x=1729709437;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gU9i1C9Aue71SbAzvGLEJdlu3vP+mqyy1BUKddErPYY=;
 b=JPi51Nyd2diefxFwHhZG101YN7QHnbLA+crIUROgHaX9CN5kK4qVMMDORkZQgTyrxr
 0k9wk1HLuQ9/K8EpZJUNFiPpCWWFOaVtVmJEAs+aud9dh+Bc/oKNzolaDfKNPYurMz9q
 ZxWBJth7YxDSpmatjdUkWMkRrqs/RXGLSs5d7VbB/rK4JxRhYvEWvvkNqKZPaKL08vLF
 nVJyFJgGpn1zMrIgC5lRjCwAVlCcF990s9TcshXOeP0FQnot5Y7bMAmiEFxh+8djt//U
 WjO2Q8SPmT+sek+OXPodLvdukpBE+R4XGnD87398Q/NqTDYPrPA52jy5ozzoPHxGvN0e
 S7WQ==
X-Gm-Message-State: AOJu0Yyc72pSDUjE9KNYcMqcsqTm8uYr1L7TwGp7m71epvVz0tatjIdR
 QgucnP1JB8mTKB9dYg3lQi4yvMYFnq5LsF+on7lES/4QWwPG5rhe2iXXREXlcp0nFczhD4erlu3
 hOwhlSfh7sby6JK7mTb5Z1L39tQeB2yDrum/OGE2IpJvsygR6Q4qU
X-Received: by 2002:a05:620a:1a9b:b0:7a9:bcd1:527a with SMTP id
 af79cd13be357-7b14189f5f2mr829989785a.55.1729104637572; 
 Wed, 16 Oct 2024 11:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmQms0j2AQZzdrLNrnop1OfiaJZd0GDlSrw4xVMdigBALRPUvEuj0eKZ7x7nAZqPR/ufyeIA==
X-Received: by 2002:a05:620a:1a9b:b0:7a9:bcd1:527a with SMTP id
 af79cd13be357-7b14189f5f2mr829987085a.55.1729104637230; 
 Wed, 16 Oct 2024 11:50:37 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1363c9d24sm214163485a.133.2024.10.16.11.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 11:50:36 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:50:34 -0400
From: Peter Xu <peterx@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 4/4] tests/migration: Add case for periodic ramblock
 dirty sync
Message-ID: <ZxAK-tvLdSc67drF@x1n>
References: <cover.1729064919.git.yong.huang@smartx.com>
 <4252161b9ec3964330d91a15295abe9fb171145f.1729064919.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4252161b9ec3964330d91a15295abe9fb171145f.1729064919.git.yong.huang@smartx.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Oct 16, 2024 at 03:56:45PM +0800, yong.huang@smartx.com wrote:
> From: Hyman Huang <yong.huang@smartx.com>
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


