Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F6DC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 20:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhxp1-00020v-L1; Wed, 06 Mar 2024 15:25:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rhxoz-00020U-Mr
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:25:01 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rhxou-0006J2-Jx
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:25:01 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-21f70f72fb5so23232fac.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 12:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709756694; x=1710361494; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OW9BBVNBgb82vsC6loZohU8IkohxnNTqJK9JrZBcelg=;
 b=VdBHQqirRxGQS6TEhtCwjy3E5+PZNrccmP1J2jX55ucUjje0TwNMqdgYI5rz1xG99W
 0kF88xTQk0Etn3chdB1q8BoGCl6FUZy69B1WUAXvPf3W7LZ0p5t6lCCQz6CqUURQGCfj
 V6GgXZmBCxpNKaEpJWYxmLVXU5zq9pqReJeDOMh/BvPDdITQKkATZqlbLq/h/BrblXWR
 jJJBaZ3ti2ozfRkmvDBAXbNgQY/hYLquOu2N7bilpq/s9Jge9zfFTFYc79cab6DtxrP+
 WAsysaVfQ/iGhNq893hKGkTHXG8Hb88SFK1vbPE/E5s1rpYGhSQW9D7WQ1C7ccWeNuFu
 Q9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709756694; x=1710361494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OW9BBVNBgb82vsC6loZohU8IkohxnNTqJK9JrZBcelg=;
 b=EmkHdDCUAo8lUPPN/jNDRsp+Iq+ZxVDzinp0xRHgIxKQ3P9pM54v1fVO4ntrf2Mj3c
 uV4/G92GfyKgTrVauQOTkz5bfN6jWI72fEF3aC0h3aietokAmVMkDI7AroFh3FvSRAr7
 owqafUjjIZiCauiOZ64e8ETZdMAHOrkk1EEsHk/42vE17gq7oSIixnvF0gpXbT68q4v9
 eqOY/j7j5yRtbxWkZBlGpSHtbyln0QJP+6bHZbnus9i0TODKi3jU2kehAzPTJ/gon7hj
 0XAhwozYxD0dazcd9s77JyqS0HOYZVG52TyF7SIVSbRMYwvMgrXqGI4mOk+cIWIGdHuU
 oZFg==
X-Gm-Message-State: AOJu0YyapKuiR/8iW3/832f1tLx4n18PjqZPhgWKZcCeGIcyLTQLiMJd
 GbokQhu2y9Pba6lI79Aio0y66qxS7HLEOaOE23eU/ho+ELC2HuFKmCxex5deam8cqVipvZlQq4F
 pR/KC9xjAale7q89bdWvCTkN0J6H0kJ0C
X-Google-Smtp-Source: AGHT+IFyOhGvW1xbXcOIeEX+9W1D3CHmHxryJbnUIARxrroMaQwitZ94BZd+xZjHgGngDq1yJRMXSnvSbSaeOGLgFUc=
X-Received: by 2002:a05:6870:b69c:b0:21e:392a:29e with SMTP id
 cy28-20020a056870b69c00b0021e392a029emr6776426oab.8.1709756694068; Wed, 06
 Mar 2024 12:24:54 -0800 (PST)
MIME-Version: 1.0
References: <2048170974.2556839.1709754757016@webmail.strato.de>
 <CAJSP0QWcE=SxYqFKj8XiGJgwSK40M9HZzAEAsvhNrTJWNR8T1A@mail.gmail.com>
 <994784261.2558198.1709755757517@webmail.strato.de>
In-Reply-To: <994784261.2558198.1709755757517@webmail.strato.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 6 Mar 2024 15:24:41 -0500
Message-ID: <CAJSP0QXYcw4CQf2NOqLqf0r0hVj8bB3kumfkXngL-FG2gkfZ0w@mail.gmail.com>
Subject: Re: no target for a link in the post "How to access libvirt domains
 in KubeVirt"
To: info@maximka.de
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, 6 Mar 2024 at 15:09, <info@maximka.de> wrote:
> BTW thank you for your meaningful posts.

Thanks for the kind words!

Stefan

