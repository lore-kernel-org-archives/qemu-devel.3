Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05D2C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 13:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJvlk-0000bh-L0; Wed, 19 Jun 2024 09:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJvlj-0000bU-B3
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 09:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJvlh-0003N7-26
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 09:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718805270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BCVVor4nlUsEpk8D0oz9kWvacktwHRi9VY4XBK9Xmv8=;
 b=GDyxOI4ny0sOiP3UK+14+J+g6mV46Ip2nh9taAqCn/JpZFei93+qcrvpHA5KiA272UJ/B8
 e/C7DSHVDQfKhzOXJzA6Aav9ST6Ud49wM8fkWIrNDy7bE/JL/oVdQ8fNlGrOrJPzhPHVvq
 N+fJGhkiPKFOQCRijsfPFiWfvPQl7PQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-dJkY07qINJKSBFG4VAAeiQ-1; Wed, 19 Jun 2024 09:54:27 -0400
X-MC-Unique: dJkY07qINJKSBFG4VAAeiQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6ad803bc570so13910566d6.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 06:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718805267; x=1719410067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BCVVor4nlUsEpk8D0oz9kWvacktwHRi9VY4XBK9Xmv8=;
 b=qX1d0kmpWQKC7Sy2tg+iQk2GD7B8BqT3bwGR17slLLwKoiNtVIKjNmUq4jexCuQBLw
 rZi6d4YsZMSQftQB0izRmVEmHjnshfAhqTIlhlx4o0qIXrY7Vhh9OrULrzI+HuCwAY9J
 M5uCE3xS0cTbS1Ldpx0iJXLtRPcsJ5VwcoWPun0ROXpzFWIbxeBelHyglZEYBH6eWhZz
 8uYyxlCuFUuSQ40LOIZKk1oe3wTAnK6FutForMt4sZxmqsKNt31vNZoSNNq2K0iEVgLI
 jqR3mqUzZ8H1QshlBsb44BBFtQBcPjYTAy8f8cxohUVekJnh4FmQ519NhaxBWbEXa4Cy
 oJQg==
X-Gm-Message-State: AOJu0YxSPReUmkYZsQmofqpgj37irhaEwQX20kgqE+XWLTt3y/qU35c5
 8QPQOG41KR3BHJvj3fW3b8xktVlXkEPbDU3SxKWtAtOlytg2aGtm3XEvufOqpAGzy/4UZMniO42
 F7p1r0xP5c5vqx+lvrUvQ8095nwHuxf/ur37xXIt3+tvdJj2fG/Qj
X-Received: by 2002:ad4:5dc6:0:b0:6b2:ae54:7c88 with SMTP id
 6a1803df08f44-6b501e23be1mr28122376d6.2.1718805266833; 
 Wed, 19 Jun 2024 06:54:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwoPHZxhtIbPumdtM9SoZ5jkLBLmkDk2pSrxxEz5RkxV6x+5lVKE5l4TOo7FnY3Gd2q5j43g==
X-Received: by 2002:ad4:5dc6:0:b0:6b2:ae54:7c88 with SMTP id
 6a1803df08f44-6b501e23be1mr28122226d6.2.1718805266277; 
 Wed, 19 Jun 2024 06:54:26 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5f10739sm76691416d6.146.2024.06.19.06.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 06:54:25 -0700 (PDT)
Date: Wed, 19 Jun 2024 09:54:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Cover all tests/qtest/migration-* files
Message-ID: <ZnLjEAMoSkLagdK9@x1n>
References: <20240619055447.129943-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240619055447.129943-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Wed, Jun 19, 2024 at 07:54:47AM +0200, Thomas Huth wrote:
> Beside migration-test.c, there is nowadays migration-helpers.[ch],
> too, so update the entry in the migration section to also cover these
> files now.
> While we're at it, exclude these files in the common qtest section,
> since the migration test is well covered by the migration maintainers
> already. Since the test is under very active development, it was causing
> a lot of distraction to the generic qtest maintainers with regards to
> the patches that need to be reviewed by the migration maintainers anyway.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


