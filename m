Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A91C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 15:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkmjZ-00028K-U0; Thu, 14 Mar 2024 11:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkmjY-000287-IA
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkmjT-0001H8-9y
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710429055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N6Erxny+hNpyBOaDSS8QYg0A9YF0tufPzKpzmDhOcN4=;
 b=AJcsHqILzr+PoaSD9Y0iAnXNsM27pxpg4YxAchDnjCjJFxjYKxA42zMabfKZRr6hfRXtjG
 r11ZK95m2UPzOoVC0FrB/WHj2k+8sxkSJf+qsQceQIN68WQ1yCmnpAVJ5W60Z6RSKWMsMK
 QFq7A6u6ajYsVape3fVrYmsZi+ZvXSc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-mFHfp2rnNEuQ3ehF_vE7tA-1; Thu, 14 Mar 2024 11:10:54 -0400
X-MC-Unique: mFHfp2rnNEuQ3ehF_vE7tA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-690b5ad0e61so3430656d6.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 08:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710429054; x=1711033854;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6Erxny+hNpyBOaDSS8QYg0A9YF0tufPzKpzmDhOcN4=;
 b=QejIFZkDMn1OlJg0rVXy5rU+VQD7SYORgyIZzMlvEDJ598Akos2Ng+vGIXPmLWPm1s
 59EYxw3+MfWkrPsVkYrUQXXX0dVLRDcLl6i0/IjErimMgvzwdYS6SSFtSaY4goBidc+c
 LkD/PQlOt3erDT4ShIkk+AnKf/Yasb5j1YfOoIprspiHS19zxMOabVHn8UC89ZJOWKel
 vDWLLT0N2WQ2zBF4ooRc5QSPrtphbHfNLkXZYQHrwurBbQsn+NF5WfsSSlwg/U10ArBC
 qHlHLbutT3sxStemiwXLv5gP0BYCERbJE2WLfZhC2b6aTv8jvGr/mz91/4ZJKioOrXfr
 3fdg==
X-Gm-Message-State: AOJu0Yx+TfS+TQKTSmI5MXwUuYM042bicodgCPPB2B6YxAOqTylMuZ02
 qS22mUij5/JrS68c5gVYDp3uLu5MpLmu4cCvUPUECeETk5SrJ+xPUwAyNvXXwq3/1wNiMHmVafr
 4ez3CN/+usYrskABg2sjh2nyjZtwhmuUMvZB5gqoo3EoNsJJZMrOp
X-Received: by 2002:a05:622a:15c9:b0:42f:30d1:f7e5 with SMTP id
 d9-20020a05622a15c900b0042f30d1f7e5mr2417933qty.2.1710429053861; 
 Thu, 14 Mar 2024 08:10:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuPYhuosDRP5To6V43cB2lL55227MQksDtlGJA6uN9y+MR+mWqHbe9mmIk2k33RyVHozfsVg==
X-Received: by 2002:a05:622a:15c9:b0:42f:30d1:f7e5 with SMTP id
 d9-20020a05622a15c900b0042f30d1f7e5mr2417889qty.2.1710429053238; 
 Thu, 14 Mar 2024 08:10:53 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 u18-20020ac87512000000b0042f09265a34sm868275qtq.91.2024.03.14.08.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 08:10:53 -0700 (PDT)
Date: Thu, 14 Mar 2024 11:10:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 1/2] migration: Fix iocs leaks during file and fd
 migration
Message-ID: <ZfMTfAXRDT7WsgtV@x1n>
References: <20240313212824.16974-1-farosas@suse.de>
 <20240313212824.16974-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240313212824.16974-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 13, 2024 at 06:28:23PM -0300, Fabiano Rosas wrote:
> The memory for the io channels is being leaked in three different ways
> during file migration:
> 
> 1) if the offset check fails we never drop the ioc reference;
> 
> 2) we allocate an extra channel for no reason;
> 
> 3) if multifd is enabled but channel creation fails when calling
>    dup(), we leave the previous channels around along with the glib
>    polling;
> 
> Fix all issues by restructuring the code to first allocate the
> channels and only register the watches when all channels have been
> created.
> 
> For multifd, the file and fd migrations can share code because both
> are backed by a QIOChannelFile. For the non-multifd case, the fd needs
> to be separate because it is backed by a QIOChannelSocket.
> 
> Fixes: 2dd7ee7a51 ("migration/multifd: Add incoming QIOChannelFile support")
> Fixes: decdc76772 ("migration/multifd: Add mapped-ram support to fd: URI")
> Reported-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


