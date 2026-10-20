Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A4E606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dKTLHYnI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJDcH-0000Qf-UF; Tue, 20 Oct 2026 13:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oss.patchbox@gmail.com>)
 id 1xJDcG-0000QS-Hg
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 13:27:12 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oss.patchbox@gmail.com>)
 id 1xJDcF-00019q-0z
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 13:27:12 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-3a98fc80925so26339271fa.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 10:27:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792517229; cv=none;
 d=google.com; s=arc-20260327;
 b=g0+r7KzBJd8OleEn3CivoJbfQQzLcuJj6sdOn0/R3xx7aorm4sT3xvzTO6gxN5BPng
 WV59q/Yu8SIrPfqFa1/lU2JKxs6KPCVM4BadjQrKcH3tRpSl8eZD4g8ThroxUzttwPhP
 Nj+FTAkax6P+0LE0FnkQM3IRxLZRHXyfuDkS08R3L9/ncF5QeleaxLzdQw+pBkSil9vl
 5agA1k5NZA2ozJkuFYLXplXO4xuyzJl60WY8FU+96RARz6jE6GVhVw0/AUEfr3u1AcLd
 p8XcmFFKeGhK2aMiUc6GkmIe2wrUJN/6XrP8MRvkqSgKIOApNBfMwx+hQMa1MPFgr/ad
 kuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fwkC4v+aEdkAE5CHhl24e4071b2Nal2z/jgvsOFsCQo=;
 fh=1hyqocvq+0cpOtlfCvP9s6HelcDghpNL3wt7lWNrC4w=;
 b=Ge9c77vXtcVuq8blICjVQES7svB7hLQTjknROz5/2rZ5BRA+kO97VMxNG4mQZonUYw
 09B2PQD8hfHvPIkkvojcURzgmdVonxz0sv/tY9BpLq0z/CpDzw0xVXYTnwYMviUEYz3V
 BL595EK9JxXm5ikKHM4oob4HnzqfJd+XrZLRZlHqxqx9B8l13OCxGhicWwku+vrUyQ2y
 sxRIl/PdVwnZJkEJdG57FBAVawwJ4LCWbAJXpRPzglimWuUvGjsIR0JwVG0QBMTPWB9l
 6HSsJohRT0GmcIEEQq6aRA3RDB1bwnGc6AvbUegsMIrIc05YgvbLPmdrEnPgKHyEeyO6
 fKvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792517229; x=1793122029; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fwkC4v+aEdkAE5CHhl24e4071b2Nal2z/jgvsOFsCQo=;
 b=dKTLHYnIRezMJl7Rc/rqyU7jYyM8Uhak23YnXzJ7yHK2jIQciWAjOmJUnybCZtDio7
 cS+l4yE0T46vHA7RoaWMJt8pHHUr7QbH1zhjSDgJrHNA5QMc35OvsuQXNoerc7jvDlhC
 pCN42VLhEvBFx5/Sm9yo4eQ/pShiNemLJlh+SMU1ENICwseqQAEwEyyCj5HO+dhTKz5v
 wsKqtqsN74IrzsWcS7IK7vuOSPTIbsb7g7IT+T2LFKCPvzsEQ6yPKi8GQpO9QyRQz9JT
 3LS6qXsd/xdhAXcAiuFgBPoRkldDGPexGfxE064G9cBunIcURfj01x8G1uzCOYm6/VXh
 J2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792517229; x=1793122029;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fwkC4v+aEdkAE5CHhl24e4071b2Nal2z/jgvsOFsCQo=;
 b=fB58Ph7fCfglX5wqqzD8oxcukKACm7VtmwMNLhgC1qnMHrQhOfHj7kbum20bXbg7Pp
 YLzwdES9ApWKWS5+TwPXaLCOeIPvlyUaz+tYmMjAhAKmaa2sz2nwkvsQf8dUCtO8MXI0
 KoMwkI2OF4ELeqMhftST+JWWh9D3qR7iHKDEVjjOgWK5XHxfZcyPa3pM2L+w1uYrIiMy
 9nztvr3BZl9XWVhTgrHjSg183Ied25NJExp+2H28F09mCWTWosP7OZuLG9tICUi6Vmxf
 NBSrQvUnmSUMxpNKhWUjPasZjpygN+zAl5VxFGYkxfKW8rV0w86nvS0UrWUhLjYDASoG
 kHbA==
X-Gm-Message-State: AFq9FYK5fTKkksX4MWRPv4cmDmxWQ0FIGxFPheiihiuIX0FpoKWk2A83
 mIUjNnTj/zUStHtBh6W324axLEFMO0suWqjdeG8FzVfekQP3Pr74I99oA90qW4okVR7fH2sY7UT
 gM7xwJ84kI8/5B0uKB9jzbIP6y3Mz4NjVlZqK
X-Gm-Gg: AYBFou3g3oD9Hdy/5KPFHJEUTvVWM4ZUnx5Ae9NNydf/si4Q1tSiSQFWU/JyzKlWjul
 XCXQJBxT+SVEf4RSOE0mSANW5gmQGfIVbzzvnQvvi9iXbkyBueQsblyLUDOKnsbOnVrsHLPxD+P
 Zx1mR6v+X7UG2Hz1kfjh4ftNdqC4/cEi/MjlvG+06cF/MEoiwTxjCNHKp7sI//LZd0eSH4X1/em
 Fc+uCAHNUx/f5OYxjaN2PyGf08mOqNzvrKdnDcmRB5owbjT3uMpZxrzqD3QozBHKm1KYv/kvxcl
 IEUrUnwGU0Op/HaGXcL64xjqw89n8N7truJdg8yuoLIg8f8Zk0+8
X-Received: by 2002:a05:651c:324b:b0:3a9:74f3:17d5 with SMTP id
 38308e7fff4ca-3ab28f49124mr26249461fa.3.1792517229180; Tue, 20 Oct 2026
 10:27:09 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260922181548.499505-1-oss.patchbox@gmail.com>
In-Reply-To: <20260922181548.499505-1-oss.patchbox@gmail.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Tue, 20 Oct 2026 13:26:57 -0400
X-Gm-Features: AclHuK_KP-V0p6K9WmILh059x8CwFvWmsIyaWzIZ3fYrkQlvKwOS_gQGzCszKuU
Message-ID: <CAGG=RgCRNTqU90P=Ua_zEpQ3C7b5X44UgkOKV+XGAWSJLk2dcg@mail.gmail.com>
Subject: Re: [PATCH v1] backends/cryptodev-lkcf: fix teardown order of eventfd
 and workers
To: qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, zhenwei pi <zhenwei.pi@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=oss.patchbox@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Gentle ping on this patch.

Any feedback would be appreciated.

Thanks,
Yuho

On Tue, 22 Sept 2026 at 14:15, Yuho Choi <oss.patchbox@gmail.com> wrote:
>
> In cryptodev_lkcf_cleanup(), close(lkcf->eventfd) is called before
> joining worker threads via qemu_thread_join(), and the eventfd read
> handler registered with qemu_set_fd_handler() is never unregistered.
>
> If an LKCF async crypto task or a main-loop fd callback remains active
> during backend cleanup:
> 1. In-flight worker threads calling eventfd_write() may access a closed
>    or already reused file descriptor.
> 2. The main-loop fd handler may fire on a reused descriptor or
>    reference freed LKCF backend objects, resulting in use-after-free
>    (UAF) or crash.
>
> Fix this by unregistering the eventfd handler with qemu_set_fd_handler()
> prior to joining worker threads, and delaying close(lkcf->eventfd) until
> all worker threads have terminated.
>
> Fixes: 39fff6f3e8b3 ("cryptodev: Add a lkcf-backend for cryptodev")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
>  backends/cryptodev-lkcf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
> index 3fe29d3104c..2f85c382b21 100644
> --- a/backends/cryptodev-lkcf.c
> +++ b/backends/cryptodev-lkcf.c
> @@ -264,10 +264,11 @@ static void cryptodev_lkcf_cleanup(CryptoDevBackend *backend, Error **errp)
>      qemu_mutex_unlock(&lkcf->mutex);
>      qemu_cond_broadcast(&lkcf->cond);
>
> -    close(lkcf->eventfd);
> +    qemu_set_fd_handler(lkcf->eventfd, NULL, NULL, NULL);
>      for (i = 0; i < NR_WORKER_THREAD; i++) {
>          qemu_thread_join(&lkcf->worker_threads[i]);
>      }
> +    close(lkcf->eventfd);
>
>      QSIMPLEQ_FOREACH_SAFE(task, &lkcf->requests, queue, next) {
>          if (task->cb) {
> --
> 2.43.0
>

