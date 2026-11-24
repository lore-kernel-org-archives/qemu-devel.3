Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17855606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ufLC8fCQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqVH-0002tY-Sa; Tue, 24 Nov 2026 08:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqVG-0002tK-EA
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:24:10 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqVE-0006Lz-6G
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:24:09 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6767d92cde6so4847577d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 05:24:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795526647; cv=none;
 d=google.com; s=arc-20260327;
 b=owFobWcr/Jvk5nTFexVvrQS2mI64QORc58rYKimFOWpswsVJR/p1XgJceNYTwoU+00
 bhF9z/kNIJVjhwqbvEc8oEujWkxTS3Fgoo18bLgY7eFMi2VOADMYIUM0X4dMbidXnO8H
 4ZRMtlqdoUg9vzPs4l3xh45irhqJpCaGwU+iuNdD3K9dXSp/8Kd7sYltBHdqgkVPzXUG
 IkS+3SnsE0Q8Vw8SlWLDXrzNdQU7EudRga0WX1oYXCso/k5Z4kScHmS1B2ANxl07ln0P
 C4USaROIxEcC/O6gB577xKMQXMf8exuMX92n07/c0mT7g3qZQ9SQ1kU5smriFJuuUERN
 yBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1PIvKVm/9PMiiNfvrGshscRBFRehdozyDW1GHkg/J8Q=;
 fh=qySlbP2EumvRFebxn2uWqvlcT6kGdKu+9gtGGNXBSZc=;
 b=eKmogPAPOU9NDFj7dBole6sWewSf55leD76VJTJJTliHszIHVOUXBfEiOfeGAfaGRT
 7TRSr0BmYhGHH0wHLK3vd6UrV06CQsfcwlYe/x+Nj0zhgH3EhDOJ6xJ2KLhVhTF+8NQM
 zfdw4qD9qqF8Z14H23x/Ve+8/1Y+HTs54RhBcxLH9kuL9AxvpBvdV13fVRU2uqmVVmkW
 rnfkWLvUpPL7jlw17pQwZxT78MSrf46AnADYldQlqL9rwxrqURSfiXYfPKcq93FxC8OX
 d1co24z9wI7yz20K3NhcaOC0BJlHy6Wgb3Qiyll8lwptLN2DFf9rg9Tpqp1hryFfM/1m
 hAiQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795526647; x=1796131447; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1PIvKVm/9PMiiNfvrGshscRBFRehdozyDW1GHkg/J8Q=;
 b=ufLC8fCQRIaBijXHfLs2F7hMf4bRms+h+IVPYaVscqhOdBKLWp55V+LQ2NNfAENTGx
 HL6atCuHd2BVieRbwe9ltzoI39FkBUzkyDc3f3kGbW8dIb5DV3OJGiycWhqLH16KgjNc
 WvGTjxorjS0EC/VDy0vLcishXAHL6MgreerZGwbPG2CjlwFpbrkE3BRvgeKr53sF1byb
 UZ5oPkDkTSkooPwW5G9ijWOHZV2p6qR+JyunZRW/iV0qHV1B7cZYVK4NqrE1AnX0cAgh
 YKcPj1JLPY2Z+PupH5ecFrzTinmbqNis1jZZ26dzsXhnTxnY1DjcbhVYyr1NZg7EZOcH
 p76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795526647; x=1796131447;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1PIvKVm/9PMiiNfvrGshscRBFRehdozyDW1GHkg/J8Q=;
 b=doqsCIYW0avsPWgpko0nxPiytAq9e2kstF7CNdmwBSRVGAWrMu+LJTbuNEtuK5ZWgJ
 NI4oIToYqHk7dioCpd1Rk4SdjSpp0EbV1aeyNXWwLr1faS4OJX7gssvY30ke/1c4hmn+
 eUHTniLjhZ6O3rjqo5JEOJWkVMpuf+fqsSN+zI4pWFfmdPj55KfpPAANiHDBzrTNYRg3
 W21SYr5VderASgf4BjOdSrr5PcLfq/YiEr4v3/HUh/Ki63z0Td2cfuOxGjxANLRCkWRd
 UZOmA7/F6wbI+BEoBvolXaVdYdF2n+t1l707k4u96mK4wVgtUq2yJBFAHEgo8ObutyfH
 kBlw==
X-Gm-Message-State: APuU4Z+LG/5IgHHiLRphpxJm2ZcxpdAPpBE7phS7j3NObTIgkXZ+Ipo9
 tBG2xTfuKG63+S1yo23wr8UO/IRHA13yNOqYLiLqJzPzWb5z9MqGZsTZRUVdcDSYxGSsqAPF8pn
 0Ev88ziPy2zghQdFX6CLybjJH0SIskjXwz9KDLrCiDQ==
X-Gm-Gg: AZFdTZdNHmeaiuRVbcSabknH4gY4x2RP/Q/07gGd8KpBYwKY+jrWMCEDlHZhRtheeHQ
 nC1bADgLzIyXU6qYnbU2mOGyYXv8oCKjLFJ14yt3w0NWwweNvh+W4MdqEZpuaZ64tXfrEbhACJS
 WE8fHPj7kWPvfTgW2YEj+cCis54tZy5Lau/AnLKandMvnzPnwsdp0OXVIw7WDFxJKN+XfclE9gg
 CD6UICaFnqfvY3ZFXxb8J+QRezTezaBKnsgjRWGKA/ZqhBxNK1o8v+6CkrMFz/UajltaAFYZFcv
 AZi9mhWCGiSXbYXd3iP5wC9sc0jFaun0JOfhMTRKKvQYeNkuDoPbAm81c2G4yUmJa6LbFf7vzpL
 yuxl9lNgb5SxxBSeM+w58ZNLc4thjTPqGzrw0CzNTrcNsEBDfuWJdtONMxvjfwr+u09f7uaFHgI
 KIAjs7n8Zl8brUEFJtBmc7/wBDnwqzGMiqIeBI1x65tA==
X-Received: by 2002:a05:690e:438d:b0:67c:2491:3754 with SMTP id
 956f58d0204a3-67df4457d52mr3617489d50.81.1795526646727; Tue, 24 Nov 2026
 05:24:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124114127.790173-1-alex.brett@citrix.com>
In-Reply-To: <20261124114127.790173-1-alex.brett@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 13:23:52 +0000
X-Gm-Features: Aa3M54pUTYlH43epoTVTtiQPmEalk4v3uzCkqNdy4-2GI9JZak7LgHEgEP72zI0
Message-ID: <CAFEAcA8FLcSkUtFvRF+mc6U1kjJBBVB-iLyfDgcpKBuDuP8hog@mail.gmail.com>
Subject: Re: [PATCH] xen-mapcache: Fix a build error with -fexceptions
To: Alex Brett <alex.brett@citrix.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Tue, 24 Nov 2026 at 13:14, Alex Brett via qemu development
<qemu-devel@nongnu.org> wrote:
>
> When building with -Werror=maybe-uninitialized and -fexceptions, gcc can
> report:
> error: 'err' may be used uninitialized [-Werror=maybe-uninitialized]
>
> err gets assigned to g_new0() unconditionally, but under -fexceptions
> the calls to trace_xen_remap_bucket() or g_new0() might unwind, leading
> the g_autofree cleanup to run g_free() on an uninitialised err. Avoid
> the warning and any future issues by initialising it to NULL in the same
> pattern as other definitions.
>
> Signed-off-by: Alex Brett <alex.brett@citrix.com>
> ---
>  hw/xen/xen-mapcache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index e30c07c2ee..0a19cfdc1b 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -199,7 +199,7 @@ static void xen_remap_bucket(MapCache *mc,
>      uint8_t *vaddr_base;
>      g_autofree uint32_t *refs = NULL;
>      g_autofree xen_pfn_t *pfns = NULL;
> -    g_autofree int *err;
> +    g_autofree int *err = NULL;
>      unsigned int i;
>      hwaddr nb_pfn = size >> XC_PAGE_SHIFT;

Explicit init of a g_autofree pointer is the recommended pattern, so
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

but why are you building with "-fexceptions" ? Trying to throw
a C++ exception through QEMU's C code seems like it's likely
to run into all kinds of problems and corner cases...

thanks
-- PMM

