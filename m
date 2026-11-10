Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A68606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=j0YdTylU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQo6N-0002IK-L7; Tue, 10 Nov 2026 10:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQo6I-0002G1-Bh
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:49:34 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQo6F-0006sP-5R
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:49:33 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-67be4f2f4d4so2701202d50.2
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:49:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794325768; cv=none;
 d=google.com; s=arc-20260327;
 b=oJPn5jDmhTcNbcJVyfhfE8d80gfhyaHPpvBK37xXmU9b3SSlkq3bhBgSJ11lLwlHMq
 9Q27oUne2q+sVsUvbYsrvI51F7jWj6/LD923aVz9WgQ57LsakbrNHOd+VTZgBRoNgnEe
 FszlLB251UCdi56VuKQmdzGCLhZiga2VHLPrQ37XeD5G4BNbxG+NfZouowzqShK8PuWV
 sB60gTtuLNbqt2a9oT758btcsjfXKa4IlaIsF8iqA+ieZvv/ebe1v1zXw1qSn6IbbD6U
 n8novQsi5JPu8ulCtYoRLn5a/rIuyU9zMtP6o7jN6USOoLoEUfElf4lpeahShfExGZ9L
 Ibig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xawrD7DrMpKVi27vlDImDJwD/H2Q8tN5RxEq7Ktu62s=;
 fh=yL5eFPExM7gfBkmL7HwoRPBH+boDPmpHyxvIKNX9pqQ=;
 b=PQdeMPrtO54urUVmpPUSkHFolOzrZoI8HAkSbgIsg9tpvK7xLB+Kyj9wT/w0NvJceV
 fqMsOSE2lyPVDMUJj33DtxhhSGTEiLeyP6WWS7Rifiacw1rHMrtHd1WGmGEIDZ2znU/b
 viVuUCfUJSRjGDkbWommiQoOsFe3pXJPQr34qK2kErwSYiPzwRd/4az/oGj/8YJI5xDH
 q/KQzQ5xwAe07GRfwDxYmzsuHfBZCJeb3tERBeucB2aMOR+3uHcXOoRR6+SlVP64JSu/
 pNYEO3ddzQx1zV6hQnyVDcYzAmowXw61SYr8PiyfLf2GFV7RfCBypFtP5hIpmAJTWfj2
 5bhA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794325768; x=1794930568; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xawrD7DrMpKVi27vlDImDJwD/H2Q8tN5RxEq7Ktu62s=;
 b=j0YdTylUuJ+DjNELnC0HrPN0rrx8v058OtQqaOnN/BE1P+av6HJFUZ5tGAZVCZQfxf
 AvNgJKs2uM8rAkDJC2i6K20ArCo03G+AX0TsVAvD078FRiiuV8r8cn1YcpU38BjT9f74
 UCTpdl93LLYJKr1tDDSzY+2QgBOZhYh+kTDRBgnNwlgHt3blVKs3chjavEYb+w2AxoPx
 ggSyuy6EAbtlIc6sotXxOuxygLeIhIQKlOESaqROLD7RuDLL7apfyCGpTqByyPyOgI/8
 C2gyvFphOsToVxhgdS9Ri4BezZxZq501WF8ZRogaWprA8CvQNtteXCvtvmn5UDNiUoRy
 jqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794325768; x=1794930568;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xawrD7DrMpKVi27vlDImDJwD/H2Q8tN5RxEq7Ktu62s=;
 b=Krk3tLDZjBcPvt+G1NxPR12w4GR+aJxlDAqD+H921TnskFoYwqcrtzXuWns57DBOp0
 b8H6NYCX/y6nLw6tUtqe6vrEY9oVNdhsXLdrVNBItAMAnOiZYq5FCJPVaoSmKnj8MA2p
 C9V/Fa1awSXpOg77pBUteElAY1CBrCGCIUmoAwj0FR9tBvy/Wpech99m2J6BM0L9qTOm
 A7QphNHQXk7LYYmBXGhLov9+E8siSnvi9eEUuVIIOq9u24pdt6jCT2mIE5WuqZNi3Jda
 /FQJwT37msX2SK4UQ1WpHTQACuAfrgJGWdAYakHd3QKrzTygrWstWl1nsQbD93FO5P+z
 cqxg==
X-Gm-Message-State: APuU4Z8YxRcFuy4DEJmIm7Z0XOytOJyAMno6ZM/Fe316oF3tcv9SakOs
 tGtCOC9QVmiAwcK/fcABEYhgK9SrfavWBKAG5f3aJ144lhk0MxICboPRDaPUEpN+xchNA8Z1Fn3
 hevPji5jNZAWdCSHQPYJi+0ZYWaCELyA5Gn1JAmSfVQ==
X-Gm-Gg: AYBFou3foV6iiYuTf8hoQxiuqqqNGQk72lKOfCgw+EN7cJe84jLeZw1KxA2Vh3o96Bt
 Tc5bKOPiMwZR9hwBn5i7m14MookHMbfe5aqf9+AogzF+d4GhVZYFdUiH7GuPCsz+XEz5d69I9D2
 SGHr+2FNDYq5NJW+0CyIW1/kRwh11Ait+QA0Y1GbqlhzGoKWkpvkviW8DfizZeg4vtmNh4zxPE4
 GamMg8lBB7A3yUmmXgSUWvhHMdcmvYRUQgz69LW6+Sio/gqWEVWmWFdRUa8ElZftc2kNf3TW1t2
 Fe456Np8LmYK705Lx5Fj+x7Ll7P0LUamhpinAFDMKHheY/lCTy7I9E9YVlr3q2Y6zU4iQza4tYu
 w/0ptY+F3+cZz4XRn76uuy/e88Vv5c2mFEwkvAjBGhD0GBH/0sf+ENcG7WdHYvxlbc5OrgD3K/q
 XDzjn1s4mnHjaHgOqBQzP4k1okT87VS/nPOI9H7VlrIw==
X-Received: by 2002:a05:690e:4144:b0:677:c24d:ebdf with SMTP id
 956f58d0204a3-67c5615fe75mr1466423d50.0.1794325766771; Tue, 10 Nov 2026
 07:49:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109-eth-v2-0-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
 <20261109-eth-v2-7-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261109-eth-v2-7-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Nov 2026 15:49:15 +0000
X-Gm-Features: AclHuK_BunDJV2hUrJECDKNoECam1-CBwdFIp3Uny2HN7Tfp7i0vzvKEk2wEgL0
Message-ID: <CAFEAcA8Or1Y2Y6WMbDUZFiLH_+xNnhjCpu+3_cu6dSkdZf34-A@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] net/eth.c: Move the Routing Header Hdr Ext Len
 check
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 at 05:31, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> RFC 8200 - Internet Protocol, Version 6 (IPv6) Specification section
> 4.4 [1] says the Routing Header length depends on the Routing Type, so
> place the checks of the Hdr Ext Len and the Routing Type together.
>
> [1] https://datatracker.ietf.org/doc/html/rfc8200#section-4.4
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  net/eth.c | 13 ++++++-------

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

