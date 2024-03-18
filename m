Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150B7C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 12:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmCE7-0001fe-Pc; Mon, 18 Mar 2024 08:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmCE1-0001fB-TP
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 08:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmCDh-0002M7-UQ
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 08:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710765356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=llrelHmHLMya7+Sg1IpwDO3ZI/P8PwP09g9PFgdqCYM=;
 b=btEktUwBnc2mWhARg4iiToDi/JGhundgnCdHhp0R4Iv67sPekbGdfJw1Ylhu2X8ASWaa0z
 sm4iskJ5DYMONcQkXt09cANQ/LkhlxwoC7oP+O00nfC+UFHF9J44dsuYSAqceN8ci1axpH
 B01ZNxpYEyDzefRrXTmS0egXhgdyvgQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-K0ebkLJkPWOWNrzNXQHEVw-1; Mon, 18 Mar 2024 08:35:52 -0400
X-MC-Unique: K0ebkLJkPWOWNrzNXQHEVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22B6E811E81;
 Mon, 18 Mar 2024 12:35:52 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F26FC40C6DB3;
 Mon, 18 Mar 2024 12:35:50 +0000 (UTC)
Date: Mon, 18 Mar 2024 13:35:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 yong.huang@smartx.com, berrange@redhat.com
Subject: Re: [PATCH] iotests: adapt to output change for recently introduced
 'detached header' field
Message-ID: <Zfg1ETU17_vDQIXS@redhat.com>
References: <20240216101415.293769-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216101415.293769-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Am 16.02.2024 um 11:14 hat Fiona Ebner geschrieben:
> Failure was noticed when running the tests for the qcow2 image format.
> 
> Fixes: 0bd779e27e ("crypto: Introduce 'detached-header' field in QCryptoBlockInfoLUKS")
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

Thanks, applied to the block branch.

Kevin


