Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECF7D3CC83
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 22:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg94V-00025q-4S; Wed, 14 Jan 2026 17:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg94T-00023x-AG
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 17:10:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg94R-0006V5-Ui
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 17:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768428630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F1NuoYj6dBblmEO4O9WB2fMHZ6MBShJj7EXv7u4Cwtg=;
 b=Dt8RTVRztlcjBS+jarC/mh27eqY8zgaaCkNBBrXCB6ijeHedbUhSrwrTQizJWkjqbbjzKo
 6CjLDqvQ4MxmrhLk5+YfYn9VKOYjLwKxorfU0mHZ4H//8EDnQd+M+LJ0JxgrYPNJi+59sh
 MdyVx60FR2D+qhDmz6TYpUmhtyUzDao=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-THVDMSghNLqDijEmI-A-ZA-1; Wed, 14 Jan 2026 17:10:29 -0500
X-MC-Unique: THVDMSghNLqDijEmI-A-ZA-1
X-Mimecast-MFC-AGG-ID: THVDMSghNLqDijEmI-A-ZA_1768428628
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5635c09717bso736131e0c.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 14:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768428628; x=1769033428; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F1NuoYj6dBblmEO4O9WB2fMHZ6MBShJj7EXv7u4Cwtg=;
 b=cj0SKcJFO26KYC8ZFzSfLj659eNrbTnhydhEJWJT3OygHRXSN+p6hf4sVKZwXVdbeK
 GIXtrpyOSZucgZmVEoTdXYq78j6uc8j5KfE/ucBcQUSO5sdj+PGWPRfWAQ56fNN/ugIJ
 YPrjSJPDCd7XPILj/Gd4vhQ9hCFTLkqYI8qs8E6Glx6WKchWncBnQu2/RLSl8Cukludt
 4jA8VUr57vMsJ2NeTpYzgd2KGIx7N0GqronBTcUQf8rCIGgdQB57w85JCrcahdDjEEXX
 /P9C5NnfUKEKYO7jyKUN0NKWYrHIoLN/97GjLLgdsHtDM2s+BB9JjCgnXNLDaQTKB32c
 e0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768428628; x=1769033428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1NuoYj6dBblmEO4O9WB2fMHZ6MBShJj7EXv7u4Cwtg=;
 b=FJw8c5IqckltTBTuUZRXnCebCdEmB7HEAfeAxZZOKsNMXXhf2Xak0cc1Cjjf/My0DO
 /OdoPQldrU61Lxho9mXmYU56LhZ3Rr3LC2dibiQl36OKN3VIFcB0yARtRb6uJboqhO8u
 3X3Q+e9I1RKck03P8IrLH+QuVA4buaBpd6FjN0AXi/oUHmt+mbaOeLtTp458FTo9OhGo
 /L/p+30BVOf9Z24JcqjE4+bocjnuNH6odFab9nprSjpDQPLmq3EDavUrrAUWLnz1qOdy
 Yxvb23Ve93R28TbND9AuHnDvz7Oe98+mz7brGMPTPsMbw2eb1XFEk8cMIi66DuVaTWdh
 8Z+A==
X-Gm-Message-State: AOJu0YxmH/u5vM4UzMLTAYfYBi+/h/6UV2tThusEkxh08OYvbMZZv+lZ
 kigeOu8kHfLlxSp/5PzwwoiLTANntWh3doxN1lYkse0f8AMNLhOpZrpC79iUnltkVRXXWdgm70H
 U2aVFuHWo4oXPAjq7/+Hlyz7g0WveuV9zE6mkDx/t7nRl4slT2PVzPLsa3SfznQN+RfFEtBk9/G
 PPssmGcSA7qD0SUqier0+EljaZ5NrEXCprz0Opbg==
X-Gm-Gg: AY/fxX5n49e8fwl76oHLCS0y1GqcWWiz7joNSm/nTOIGTh6F3Zapv4HKCMP8MHcZmm1
 Ya2WJTUL5cbp3afp8QT85BnhuorDMKBmYoLTK++w4RLrO+bTSGZaHuJMHyZFw3L8eLMr3xEZYq+
 g960mHMx/5Tb4/sEivVZNLjgVD1XBt0iaHGkKuGEsUCgZV+9dOH3EPiP4+//WLG/Q3UkpsbkMRW
 VtTKqRbMLito2Ob7sNCHteJEt//CtZTuym+3HWllln1RtsB4dRoJDDJHxtzBN6RoTzD8x3pZrsW
 FgxDX7ydug8UB5FznObZt9SiriPN3w8u6fYmWGQLLgCTnTo08DNQx9jXINPy3z5n8WdJv/q0aNd
 rqM4=
X-Received: by 2002:a05:6122:178f:b0:557:ddc4:dea4 with SMTP id
 71dfb90a1353d-563a093db28mr1639389e0c.5.1768428628253; 
 Wed, 14 Jan 2026 14:10:28 -0800 (PST)
X-Received: by 2002:a05:6122:178f:b0:557:ddc4:dea4 with SMTP id
 71dfb90a1353d-563a093db28mr1639370e0c.5.1768428627735; 
 Wed, 14 Jan 2026 14:10:27 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5633a1ea48bsm24581599e0c.3.2026.01.14.14.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:10:27 -0800 (PST)
Date: Wed, 14 Jan 2026 17:10:21 -0500
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 3/3] migration: Remove fd: support on files
Message-ID: <aWgUTR0xSkH9aD--@x1.local>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114195659.2543649-4-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jan 14, 2026 at 02:56:59PM -0500, Peter Xu wrote:
> This feature was deprecated in 9.1.  Remove it in this release (11.0).
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

This will need to go with removal of the unit test..

/migration/precopy/fd/file

While I'll wait for any other comments / reviews for the other parts, I'll
add that change when repost.

-- 
Peter Xu


