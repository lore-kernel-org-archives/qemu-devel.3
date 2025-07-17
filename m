Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A54DC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLGj-00066K-20; Thu, 17 Jul 2025 05:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucKvS-0005yi-77
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 05:29:14 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucKvQ-0001KP-A9
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 05:29:13 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70f862dbeaeso7068357b3.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 02:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752744551; x=1753349351; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rvAHTPbULdw1cqaYPzluxpN/MB3/oKbzGjmLhAAMghw=;
 b=LaK5rZNpF+LyYnAFgbQP/6iSfqtFL/z+3wH/47Z0PMzaUd8GOJy2qmZ81V93e/0r/r
 i80gw4xdZpmFDmuaRWyrYNYGeOanI8ZFeR1yrUY12Z63uF5s1kwz7gMc9Yxu0axTSls/
 N/CcinRrTWX8Rlr8peK9tHnR9I0GZt960QpMEH67KDd7qyBpsZL4zSC98Utxl0B6kwQa
 AQ4gRPJu7ySO7UReMjItW59MfRYzbaNDU8lxEirCWCL6HNfup2sU3oHtMAUCHg6WIaSj
 RhphV3pFB3hibfe1lWWZwSOVA/dC34ZFIqUjTEJp7nkB+sut24UKb05vwdLddZ0TQQI7
 m8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752744551; x=1753349351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rvAHTPbULdw1cqaYPzluxpN/MB3/oKbzGjmLhAAMghw=;
 b=nkAQVmCimRpmY150hjLS2UzS0At+47cqVvkX3yyVVUTh+8yDL53HsSKvwLM9koyLAn
 6aMyvVMiUREtKdWulBesS5bWv1JVhZmyrbWUjoOpwlE6B+NWfucA35CFx1CkLpySHLZX
 xNLMOfjNC0duGB7RJfaehYKdBi+RO8f/xZ6BREb39PqDcEnZ+X7A/uKtYlmJa6SKtJ3B
 6KnwVBVXucx1JJ8lq2nDkRzy0DhP6GnzP1JG2LehbzRekNE4121ionx36kNKXPjbNDgY
 Sqv6bA6Lls3fVzEORX7yQE4+gdi3KUqJuifW4psS2Bf4NMyrKSeVlVedspqFSHgMFBZ9
 6t8Q==
X-Gm-Message-State: AOJu0Ywf0XvBrQqvCruTUjW4DoUKr8Mm3o+MpMmtEPMq3BVuXtjGNIsO
 o2LUIwMZBfLOXGwgshn7g+hatBZ+Ydr6HUPNqpTHh9H0eTwbXKkA7tMV807Na/VD1NKiI+hJ9J0
 7vqwcCWEoMjjkhrERr7Pn4L8H0mHyHiXglP6xEbrXow==
X-Gm-Gg: ASbGncut79K7MEzgaTIebqAH4RRwgfcRbeyOnYj5dcYwCENSZZDST7R4ThfFdR3Rrt6
 R9gmUop9GzYnWGunVyBwYSg3+w8/12c9PbiqqM060mFatSYg8XfEqwyuJ48eCujhObgC+nL/84G
 w2mE/zg2BVB6zwXC5bf6VJci34Dl6/CO2SIJ+oV5ocopvlW+M6nscHdmmMa/T7k04LQj5zBtcJx
 xZS0OsXQjcozN4m+yU=
X-Google-Smtp-Source: AGHT+IHFxjOYZW7t2KCapZdVT5UhGjOpwxUYtz5l/qoRSt5Zr/OGXN2OvnrSpPRLE3wQ7yPLrwlfPyownnRhQKJMfHY=
X-Received: by 2002:a05:690c:4b05:b0:719:3e4f:60f7 with SMTP id
 00721157ae682-7193e4f80e6mr14267097b3.26.1752744550508; Thu, 17 Jul 2025
 02:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250715043524.21719-1-jasowang@redhat.com>
 <20250715043524.21719-13-jasowang@redhat.com>
In-Reply-To: <20250715043524.21719-13-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jul 2025 10:28:58 +0100
X-Gm-Features: Ac12FXw8B2bFyd_lIo41UwkV22lSsTiAXgwZhLAECgZ-NXPt0riIL94yvU0wZhA
Message-ID: <CAFEAcA9OydUfi-sz+dEJ2w4OiudM-9bo6jNk+_zacyj9bos_-A@mail.gmail.com>
Subject: Re: [PULL V2 12/16] net: Add passt network backend
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Tue, 15 Jul 2025 at 05:42, Jason Wang <jasowang@redhat.com> wrote:
>
> From: Laurent Vivier <lvivier@redhat.com>
>
> This commit introduces support for passt as a new network backend.
> passt is an unprivileged, user-mode networking solution that provides
> connectivity for virtual machines by launching an external helper process.
>
> The implementation reuses the generic stream data handling logic. It
> launches the passt binary using GSubprocess, passing it a file
> descriptor from a socketpair() for communication. QEMU connects to
> the other end of the socket pair to establish the network data stream.
>
> The PID of the passt daemon is tracked via a temporary file to
> ensure it is terminated when QEMU exits.

Hi; Coverity points out some potential issues with this code:

> +static void net_passt_cleanup(NetClientState *nc)
> +{
> +    NetPasstState *s = DO_UPCAST(NetPasstState, data.nc, nc);
> +
> +    kill(s->pid, SIGTERM);

CID 1612369: we don't check the return value from kill().

> +    g_remove(s->pidfile);
> +    g_free(s->pidfile);
> +    g_ptr_array_free(s->args, TRUE);
> +}
> +
> +static ssize_t net_passt_receive(NetClientState *nc, const uint8_t *buf,
> +                                  size_t size)
> +{
> +    NetStreamData *d = DO_UPCAST(NetStreamData, nc, nc);
> +
> +    return net_stream_data_receive(d, buf, size);
> +}
> +
> +static gboolean net_passt_send(QIOChannel *ioc, GIOCondition condition,
> +                                gpointer data)
> +{
> +    if (net_stream_data_send(ioc, condition, data) == G_SOURCE_REMOVE) {
> +        NetPasstState *s = DO_UPCAST(NetPasstState, data, data);
> +        Error *error;

CID 1612368: you forgot to initialize error to NULL.

> +
> +        /* we need to restart passt */
> +        kill(s->pid, SIGTERM);

Another kill() without checking for failure.

> +        if (net_passt_stream_start(s, &error) == -1) {
> +            error_report_err(error);
> +        }
> +
> +        return G_SOURCE_REMOVE;
> +    }
> +
> +    return G_SOURCE_CONTINUE;
> +}

thanks
-- PMM

