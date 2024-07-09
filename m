Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8291CC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 09:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR7KG-0002SI-UL; Tue, 09 Jul 2024 05:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sR7KE-0002Ra-3s
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 05:39:54 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sR7KC-0005Ip-FZ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 05:39:53 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7527afa23cso612661466b.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 02:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720517990; x=1721122790; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gIeqpd0Ni+01y9GBfgzCBOOuLFSJIDHwjq65CNAIGK4=;
 b=HADURW/lKJt84cYxLjdiHUmf7qJFGrG44hHGa6uNAlgJNJlrNLiBj2zHigUR53h4EV
 KSNgWYlvR1GU2nWWqo2Z7p8KG5++FDx5qGwkEySZFU5Z6TPLtTv1gC+t6XRD01a8qveT
 A/xC8UtKnSJH5QVuZRwM61/iezRKy8PX/q+UJHHMYPkAIFqeONrcgD+fc6UFOhLVRjl5
 /FAAnE8gYzNZp1M2U69KaFzVfcIWCnhMkoEg35CYEcwWsuH9qBP0OAA92sGecVYzDrKp
 UmVJnNbtxEXYHEFr/gcs3XUzfwnfToOOB5gsJZfLAiDqizS8dKYj+SWTUEszcTtd/hs8
 3Ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517990; x=1721122790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gIeqpd0Ni+01y9GBfgzCBOOuLFSJIDHwjq65CNAIGK4=;
 b=IjBgmq2VjXbZ/PcijZdK+/Ek+Ij6l4oi++ep5NN21nHQU9hlz2PQJVALnb3zPAYc2T
 U8zs6W4z8vdzpQoSh7uvSDGVwAbh8fACnIxqpjXwh1UIj/ZeGbZnCcu0k+LOvoWLFnGm
 g6IuCfi2tx4MlgF9UuKHwTiqkkyibhVvwLUUWW4HPBRjgpmbPELUzn9dtCiC9QDSqC2o
 AbfKZK+ir3fsFkoNZujMbXs3yPvp/nvcAY+8OnOcZaluVRD0YjnZz1Q9eSUqu2fn+nCZ
 q22RtimMqiiB2O5rZ972Op/MHheVUgDZQHIPLr/h8gNf1LegKEg0HmlW89HYUWQNouBw
 i9xg==
X-Gm-Message-State: AOJu0YyYwJFs0nNJjOC1PsxTHBlQgK7VmdVFwDx4DBe8NUl2eBL/y59g
 zZc5Wa/5SbxMjNzBWh5yl25CHO5vPzsexxtax+waGfnPbhPJC+I5TgGjUY0ykMR41AIAXDNrcMm
 8h9dkBzlcezlGHtULXZf2RJfD5oUjIu5jfPeP1g==
X-Google-Smtp-Source: AGHT+IGSZjcSIIIX8CPK08iPwLxsI1eQMY+TqEjTJYHeXBqFjnRCJxP2/5hsQDAv3MhIbEVUF0EEJavxePlW+xFgKQc=
X-Received: by 2002:a17:906:b319:b0:a77:deb2:8b01 with SMTP id
 a640c23a62f3a-a780b6891ebmr175951266b.1.1720517989544; Tue, 09 Jul 2024
 02:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240708181709.27410-1-rkir@google.com>
In-Reply-To: <20240708181709.27410-1-rkir@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jul 2024 10:39:38 +0100
Message-ID: <CAFEAcA_r9ee+5VLSEVPN-g8AzFOb7j7ft+_GYCYLFVe=ieBMiA@mail.gmail.com>
Subject: Re: [PATCH] iov: don't use void* in pointer arithmetic in headers
To: Roman Kiryanov <rkir@google.com>
Cc: qemu-devel@nongnu.org, jansene@google.com, mett@google.com, 
 jpcottin@google.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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

On Mon, 8 Jul 2024 at 19:18, Roman Kiryanov <rkir@google.com> wrote:
>
> void* pointer arithmetic is a GCC extentension
> which could not be available in other build tools
> (e.g. C++). This changes removes this assumption.
>
> Signed-off-by: Roman Kiryanov <rkir@google.com>

We had the question on a previous "make this C++
compatible" patch of "how much of this stuff is there?".

https://lore.kernel.org/qemu-devel/ZnqPpqfBxlk9tEdX@redhat.com/

Please can you give us an idea of how much of this stuff
there is that you're planning to send out and what its
scope is, rather than just sending one "well this looks
small on its own" patch a week?

thanks
-- PMM

