Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A88CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcLR4-0007g8-Vn; Wed, 24 Jun 2026 07:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wcLR3-0007fH-7k
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:06:25 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wcLR1-00062E-O2
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:06:24 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4631679f204so1027924f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 04:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782299181; x=1782903981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wPOA6V6NFF8mlPEknT5WIoMFATVeVr8cNISBv2odveI=;
 b=eAc9UTg1/6ujjvS8/O6Wk/5yztbnVpD6NDhTiikeyBozmmMOAcdwAMUT/nSIfZSJrm
 uJ7RsdkVlDcib4OhdEo9T5uY2YOijNEpJLTch4pMnIaXdcxLFMi9mjo7deaTDuaIl8DA
 H9IPqciLSOqas7zYOpQCd8asMQvLd6Lln0gVh03Ww98YY8JjE1r5nhgLXxK25jH0B0nH
 cqjdz8H+Ji/R+ZvBHx8MfUzqcWig0uMK+h+rFYq2fv9ARFTewNfLrW/AF/d1qqDZTqNK
 Mev40XmzUGGsRUe0CbHOxFrB/w1LKY3i9p9OJpPo13PWzWe55UgqIeo0vlr0HNof6rwd
 MNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782299181; x=1782903981;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wPOA6V6NFF8mlPEknT5WIoMFATVeVr8cNISBv2odveI=;
 b=iIUaoEaDZdPRHhEwSafo08W19zV78NFSQKr9bKBaB5mNuuE5t4bV53pxmDDZXrVBsM
 QyJRm7Gb4D6qwARpwhxRuVZEOa9ZqkfhJsMiWeht/czr6QjQ74HK9mXu1sWgNuxX7H9g
 W++2gBi7WQgUWYjuzCKaYEv5KIyH1D0QJBhRh0/Sg3WXjPZhSpFS/aLbD2mHfIbVuojx
 /DW9lEfKVEDJEhvuK/4JE/Lc06tzwXv0jANaVRmeMPNR67a3HuofQqUJg/SexPNEGI1C
 pHxT50JNwOJcYpizFzV3lLoeq7XcIQIIdokcde488vvdDTFgwKhk2iOVMyp+fJDOn9t/
 hoew==
X-Gm-Message-State: AOJu0YxBGaILRI1mOQ9wgKJ24/451nKliM+z2yp1jCL0qW15l1020J9W
 2O0kVxP1xvK7okB/Mkl3wtJ/UWO0s5NTxazJHMBv57h6Y1LQTMP/LL0vYTcKyDzWyFgGUVq6MEr
 HGdnAEuU=
X-Gm-Gg: AfdE7cktwyQqfmp5YR+q6m7uHsRETHdMx6lvw3zpZ12mHLa7uTty4KF05CwwZb9exyN
 DUfc/a+ZrbMJn+ymgNJfSNSvT8pkjKRNiZsYZBeapmMWneb/9KAiRjdDYgAa9CVBOIFjBTld+th
 +3iLqpeUqR3o3c4K9SkrnkKypt5bumtArZYhZ6v3PzqPPNVK1cvvrGDIw9F+bKxs4Y7sMnykhzP
 uBKlJA36Qo83n77v4yKamov1b8GK82/pkzykfF9AU2ZBBWayJMkP1WbRqBWVGZbz3/+kw20fH8G
 vxj5ZvCYEq598Uy9hOhOBirVmcB1EL77J2fN/Sr0T0EXz8azlP/orN0dW7hY7biIfOXJb5JDb8A
 lvAmPKO8kj1cfomH7Ix9b84WfP8KkiU8c+yyAxb0Cm243fm5EslGh8QNJ77tCoXNugfgWWmoXtx
 rui4Uu5lerV3mmWHwWI8pvBv81/It2kfPo4K+406OElyxmhWmnEeAfSar8BdN2dJnhcmt0byeG9
 arc2bUbzjInns1wd8l2cNq8U5GNWz4nPzZf8GC7mnk5aHSTuCof/2rGoELugBQpYwLsRHGI81Ys
 53OVDE1SJUSgWXve4a67P0U=
X-Received: by 2002:a05:6000:2506:b0:460:6a3d:a114 with SMTP id
 ffacd0b85a97d-46a81429c89mr12968662f8f.30.1782299181328; 
 Wed, 24 Jun 2026 04:06:21 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee018e8sm6203671f8f.11.2026.06.24.04.06.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jun 2026 04:06:20 -0700 (PDT)
Date: Wed, 24 Jun 2026 14:06:05 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@oss.qualcomm.com>
Cc: Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Ryan Zhang <ryan.zhang@nxp.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@oss.qualcomm.com>
Subject: Re: [PATCH] mailmap: Fix Ryan Zhang email address
User-Agent: meli/0.8.13
References: <20260619071422.99061-1-philmd@oss.qualcomm.com>
In-Reply-To: <20260619071422.99061-1-philmd@oss.qualcomm.com>
Message-ID: <th4uuj.15bdivro1jq9r@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 19 Jun 2026 10:14, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
>Add a .mailmap entry to fix the invalid email introduced
>in commit 490a3e1867f ("ui/sdl2: Set GL ES profile before
>creating initial GL context").
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> .mailmap | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/.mailmap b/.mailmap
>index 34c092714a2..120403aee00 100644
>--- a/.mailmap
>+++ b/.mailmap
>@@ -35,6 +35,7 @@ Jason Wang <jasowang@redhat.com> Jason Wang <jasowang>
> Marek Dolata <mkdolata@us.ibm.com> mkdolata@us.ibm.com <mkdolata@us.ibm.com>
> Michael Ellerman <mpe@ellerman.id.au> michael@ozlabs.org <michael@ozlabs.org>
> Nick Hudson <hnick@vmware.com> hnick@vmware.com <hnick@vmware.com>
>+Ryan Zhang <ryan.zhang@nxp.com> Ryan Zhang <mailto>
> Timothée Cocault <timothee.cocault@gmail.com> timothee.cocault@gmail.com <timothee.cocault@gmail.com>
> Stefan Weil <sw@weilnetz.de> <weil@mail.berlios.de>
> Stefan Weil <sw@weilnetz.de> Stefan Weil <stefan@kiwi.(none)>
>-- 
>2.53.0
>
>

