Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0CBD75E34
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 19:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFIV1-0003mY-C9; Sun, 24 Nov 2024 14:42:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tFIUz-0003lW-Sz; Sun, 24 Nov 2024 14:42:25 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tFIUy-0004pF-CT; Sun, 24 Nov 2024 14:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=pXXdXylIjxO5K8y8Ou9nA/7acDh50JVYqsKfaUcWpIw=; b=fClFNh0VYthoI2aLZONBagpTEF
 I2mUTQtTbV9aunT9MKg+iFaP3lyvG8xxcdcI9fhUWmfCyfdFe+9SXnYWNtzZ6NZDG6/EVmbDiyczn
 R42wzYBE2TMDjo0WNjG9bJ7OoCm9mHgdNHudsa++If8Qbv+SEiGAh8oVR5ktT1d0NYaqPvJgyUeN4
 /U7i3UV0ujaPXdd9E2j4lVR7eBrJXWQYhBXWXvzQj6dlhPkQfXk0WHjsYg94DoAtRQrWOY2sJhkyc
 BXm3zof2sm1EX5sFWRctaGcnyKmfRxuIzCFWr6G7HDTXFtefmvJy8MEp+haGucq7pCsbU5nKPQhIz
 chTwfpqWaJ6CF3C12NNe7m/AdXeP91qitgdeXJxRSmIoDBk9drQHdafkGVE+F9mm0Bv/ztwV9h9MK
 PdJgF0fVOpLbFZT4TuH1Ypbgw6K2+UfzHCDoQwPFLzIrQv8UoL21eCon64DrrohlCqGIQS9KTlBKO
 7HfE7fNRags0jRm3ojt32rda9BGaaAERCd4sF1p8gEuwXnlc61v0GsTNOQ/u97oSX9bX1WT/7yNcm
 dgP3x+xG4IPzn3qGUU4k59qag5OqVnBuYdN000URq54jfIvg6HAeYz89lWgOfZrv1k31xPLxox5sj
 GN6EVQJ2vrlDjxQ/Zg1Tk9zGxX8Fs4IovA0sobAII=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 3/6] tests/9p: add missing Rgetattr response name
Date: Sun, 24 Nov 2024 20:42:22 +0100
Message-ID: <192498932.9YKMjn6Izl@silver>
In-Reply-To: <e183da80d390cfd7d55bdbce92f0ff6e3e5cdced.1732465720.git.qemu_oss@crudebyte.com>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
 <e183da80d390cfd7d55bdbce92f0ff6e3e5cdced.1732465720.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sunday, November 24, 2024 3:49:55 PM CET Christian Schoenebeck wrote:
> 'Tgetattr' 9p request and its 'Rgetattr' response types are already used
> by test client, however this response type is yet missing in function
> rmessage_name(), so add it.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Fixes: a6821b828404 ('tests/9pfs: compare QIDs in fs_walk_none() test')

>  tests/qtest/libqos/virtio-9p-client.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
> index c61632fcd3..98b77db51d 100644
> --- a/tests/qtest/libqos/virtio-9p-client.c
> +++ b/tests/qtest/libqos/virtio-9p-client.c
> @@ -235,6 +235,7 @@ static const char *rmessage_name(uint8_t id)
>          id == P9_RMKDIR ? "RMKDIR" :
>          id == P9_RLCREATE ? "RLCREATE" :
>          id == P9_RSYMLINK ? "RSYMLINK" :
> +        id == P9_RGETATTR ? "RGETATTR" :
>          id == P9_RLINK ? "RLINK" :
>          id == P9_RUNLINKAT ? "RUNLINKAT" :
>          id == P9_RFLUSH ? "RFLUSH" :
> 




