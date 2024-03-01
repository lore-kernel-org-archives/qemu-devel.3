Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2138C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 06:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfwDf-0002W4-FN; Fri, 01 Mar 2024 01:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfwDd-0002Vd-HR
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 01:18:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfwDc-0003gO-29
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 01:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709273882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=neHNTRwHANP2KVREPCwC807L6REGT2KiyGk1gTxbUGo=;
 b=hXb3u4fQa8y1QXoedBu7Klhrwyqt24ZG0AMeuGFWsAroq60EqIzgnBRjur5Xhsm6lUXNFL
 ehIyjXQw8JHAzRBuWu5y7eIjy2JJFNEYMoxOUDD9JAecHXxNBXuF2agiYAT3TxNSF2h8XT
 C8HN1bKG0znyorKSc//WEsl8+E+gogg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-y8h86avcNGeDYnPxDBPVtQ-1; Fri, 01 Mar 2024 01:18:01 -0500
X-MC-Unique: y8h86avcNGeDYnPxDBPVtQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6db0e05548fso160157b3a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 22:18:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709273880; x=1709878680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=neHNTRwHANP2KVREPCwC807L6REGT2KiyGk1gTxbUGo=;
 b=qYyuXvOd3TP5JCqJhaFvvkY6OPbDouvn8WIdAEjGMNjPQdG9LKYVEP1SZLVT9pzydQ
 P1KhXEt2DEE0CVOAjVMZVL8KZXKGrVxRNb9GzANeJESSIGF6rGNZcRpj881CR1DYF5vL
 8zOvjR3t6GPcqzo+FTux+pX786CX59mEsKSeoRkPeVRbvZ907ayD3EinSux3806e0d1w
 oYaLbiWQUlKZGB6L+Eeoh35HxQUfYWuD7VPCibufK+adCHWl8sloFCnFwBYoK2ZDgpVS
 0kORVheOX1cFdRcYD0D33FOcsdnyfrxdcjJg5cxf+K79d9dmhCrntxBJRcdVpFAbjxia
 LZkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY7xm66SH4Y1WNDUx11p1Qyh6be5VZiE2E1hWV/D3UEiU/WngsJm0HoXWBheD9n9mGcXerurW/ERFXvt8bd3juSMSJBa8=
X-Gm-Message-State: AOJu0Yx86r7nbJfblZzn+G1GAbyOyu2U3K2uLuRjeXlbdmkGLT85eoLo
 wskDCgU60aq1v9yM3csG4le+pAO5LAj7vtBi3/k0I5IekQZ9Xoinngv6W8KSgRJ3Kv7jY0egtS6
 XKtAjbvDN4rLf74taZ7JR1ehrPCItKMc8L77Qnoy96BSEgNsCz+3vQmUQAm86VZc=
X-Received: by 2002:a05:6a00:2d9a:b0:6e5:109d:8373 with SMTP id
 fb26-20020a056a002d9a00b006e5109d8373mr1102625pfb.0.1709273879948; 
 Thu, 29 Feb 2024 22:17:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwkPGr/8Z6+x5Kigp4Xf+L4v/rfxFuLgmmaygjbMy7yPhXU+gCt/7Z89hvL+C0ipL2E7KgvA==
X-Received: by 2002:a05:6a00:2d9a:b0:6e5:109d:8373 with SMTP id
 fb26-20020a056a002d9a00b006e5109d8373mr1102609pfb.0.1709273879469; 
 Thu, 29 Feb 2024 22:17:59 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 d23-20020aa78697000000b006e484e13454sm2221991pfo.32.2024.02.29.22.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 22:17:59 -0800 (PST)
Date: Fri, 1 Mar 2024 14:17:50 +0800
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V2] migration: massage cpr-reboot documentation
Message-ID: <ZeFzDlgQxb-9pxxL@x1n>
References: <1709218462-3640-1-git-send-email-steven.sistare@oracle.com>
 <87edcusddf.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87edcusddf.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Mar 01, 2024 at 06:57:32AM +0100, Markus Armbruster wrote:
> Upper case "QEMU", please.  More of the same below.

Fixed five occurances in my queue, attached R-b.

https://gitlab.com/peterx/qemu/-/commit/87a2848715f5fc4fa114574dbbf7a5564cb4cdd7

Thanks!

-- 
Peter Xu


