Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A7A606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=weTne74p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNogI-0001Mq-2e; Mon, 02 Nov 2026 04:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNogG-0001LE-6J
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 04:50:20 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNogE-0003NX-80
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 04:50:19 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8aea7b7ca0cso23152637b3.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 01:50:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793613017; cv=none;
 d=google.com; s=arc-20260327;
 b=jWHE6ABhRQIyhBs5vjnuWwe5DliX0Zlm7Lmgac/PnwNBvvm8RdGlCQm8Uxnn/uN03R
 uo9fMjmDlm83jYbd4WvI1Vx3aXI4FmzJJK1LAhIHBiB5da3XvvQKQ6Rql9kKsPSguN5N
 FkEMb4xEoQDLXU83vbkd8OTCklgcfUGzgQkbW8BRSZjngiC8Metzx5eGhgWhAIXMyOrV
 dsFlleglsU5+pl5IkCoi5cqt7ztQCAYjUQy5QL2IBy1/PVPcp4WFNH2whA0koxzM3LKl
 GrTfPBR1OYQcMRTtXCFjAm2giBygHY6AI9snF80j7wFNhtE5fSUbYDi9LxJ8qWpE/8n4
 6bJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s1KE9DIUsCC33l/muao3WH+ErUCKJD4R+uV+Mla7g+0=;
 fh=vdyJviwiifLaY8kxY0aGat2P7QrP+XqQ46j3jwC26yI=;
 b=L1DVbxaZR8DKqsM+jFsioIWJWD93UsA58Mv0sM7U5rikro5rOCqRsgq72c0N5yzLYU
 vgFKKMuNwBh9MxTG2htmSWek+0ObW2BcUtGuubjDQo2ytz6gfizjc33g9xS2H/i2jUxJ
 AJ2cAu5hcEo1K6khrCiMiQFKv40xA0GY1mr4sTjass2Tr5cSYlYl4eQi7VCBiPaTlCFF
 CxyIj5Z9/vWwAOH0tdffnzsZe3kI9BW0tWOc5MmKdGzpSavNeAEj3V9Y5DpbUn5Qf63k
 kea+LtK9hnvwi3BMBy2JlOw9Ion4KphILjaCVNFgxV13APzheaROFUgaElpkOUwspnzV
 zIhA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793613017; x=1794217817; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s1KE9DIUsCC33l/muao3WH+ErUCKJD4R+uV+Mla7g+0=;
 b=weTne74pR7J77HK/rdqvRJpxevV7iiqO2KDQV51HhuLnURHcCrNKlhe7XWLOsQo0BA
 Q7nl20SqoQAxBhfpSB4qSgNfDlpRw7/RJiXVPWU/5pNvw4IFQ01tKqwpEpHC8nxHb4wW
 QfOqkAtzQoDdq5S9o7nbUbQ+jtRpEdBdkqBn/fBkYhwC7Cn4SmcpTTlZJagjq1f6uvDZ
 aO+tGRbNjkt4oM6EM3tPxCwzUaa/OckVRcgOlHTwjirQ7yOvOL6lmW3zonRxVoV2skLX
 wtbwJsDsUTw2Var3cQiKR17m/M7mOH2XNeDeQWjlsUWfcQ/M/zlIbTgVh2QimSgMfBMM
 15+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793613017; x=1794217817;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s1KE9DIUsCC33l/muao3WH+ErUCKJD4R+uV+Mla7g+0=;
 b=nz+525vz3MInqrhbtUDPmKE7VY5TYVIY/b/tthCuFAw0QoGJQ1H5zb5ELHv21IHcUI
 rIFC/MIegurhWI5qKvDAcadwxFYjko4UZ0YJ9Q6q1egYjGlDWMzrvFDY9Xgv9DwpCktP
 GmQA4zBhP3rX4mMICEFOncm6rSbQDZ+bB0tdt60t9kkLUHYU9GOVTojJmzc28L36DNwb
 zc58shgUYHpFycV3CYI22tjewU3ZbKd/jcHgTZGYDQ6IDcKHZ/T7HRG33gqHEfx1jOMy
 2MHdYHVL6qJTCU1IbeIQ+UqWgfXvc/FuJ4MoWY33nqsZm3rsx4KP83M06j/KTEthVyOz
 xuJw==
X-Gm-Message-State: APuU4Z/yLLm9Wm+8QB1tCHFwI6Mwqy6w1fumS22P3zIPpQMGFsFa9Riu
 aSYKkK4Edej7SYnG6ILcCJ3+ItrLLvh5RnGzDUlblIpqUnVaQMwoPJ5JhhuB0WKpIgleZOqTP+U
 X7OO0MLkuynm3Lp0Yg2MouRJ6vTmGf+Tb3x+1pNwYVQ==
X-Gm-Gg: AYBFou3L13RhsOvBQgU3ZBuZ12HfIpp9LD6VBU7c+pXNOTzXK94jlBh3M7W9i0N5Y5v
 eagDdnW/bRis4TCBk8uFJfzdXTMugQdc+g5EP/ff2L+QiuY19U3USxN+TXcUhyqWf0L0b3CRKZJ
 wQo2kU5yBQD6GVhIllFfK4/WS0X73LrSoPA0ZxVn/IB6uUCuFEJuYLVnLhbnjkft6G3Muj3II6k
 fYFsjj4Q0+IVgztKoMuktxLdJ2CcXaL0cQ/SWPfjJ8dUDcKkzelUsbUP4tO8rHNwTrbK+2AGLbm
 nXojvXD8iBIfCscy/yK8Yu7T4MeqY1390Yl8UvdR57+qT9e4kZpy2mBDXIcJ1Ota89pOrU/2sB6
 hI6JtJx8HTGZNJM0DQro2gI8ID5Z//IyDEpdqWr9oMcV7gWFwkHde8DTFZ2nogi9tp8yfQSq3NN
 Qsp4FzL7tDUlKtJWQCPYPC
X-Received: by 2002:a05:690c:389:b0:8b1:447c:cf05 with SMTP id
 00721157ae682-8b2b67cd1b4mr54587617b3.67.1793613016655; Mon, 02 Nov 2026
 01:50:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027174625.4025878-1-peter.maydell@linaro.org>
 <20261027174625.4025878-4-peter.maydell@linaro.org>
 <179360571624.2763172.7914119075103403787.b4-review@b4>
In-Reply-To: <179360571624.2763172.7914119075103403787.b4-review@b4>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2026 09:50:04 +0000
X-Gm-Features: AclHuK-nTRqjXzHNxSdQ_4AvwBDPbaqY5sD-kOrmVmV1EnYUQgI6Shfww359rX0
Message-ID: <CAFEAcA_BVUkFhAMOoXx=7-_MYuaW0695AkYJzbVvchM9eU_XpQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] net: Pad short packets in qemu_send_packet and
 qemu_sendv_packet
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Jason Wang <jasowangio@gmail.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 at 07:48, <marcandre.lureau@redhat.com> wrote:
>
> > Now that we can rely on do_not_pad being correct for all
> > NetClientInfo structs, we can pad short packets in the
> > qemu_send_packet() and qemu_sendv_packet() family of functions.
> >
> > If the callsite is already padding, then this will have no effect,
> > but callsites like the socket and dgram backends will now correctly
> > add padding.  This fixes the bug where when two QEMU instances are
> > connected via one of those backends a short ARP packet transmitted by
> > one is not correctly padded by the other and gets dropped.
> >
> > Note that if we pad a packet, our return value on success will
> > be the size of the padded packet, not the original. This is OK
> > because this function (like the NetQueueDeliverFunc function type
> > documented in include/net/queue.h and which we will eventually
> > end up calling and returning the return value of) returns
> >    >0 - success
> >     0 - queue packet for future redelivery
> >    <0 - failure (discard packet)
> > and doesn't guarantee to return exactly the size of the packet
> > sent. None of the callers try to use the return value as an
> > exact size.
> >
> > Cc: qemu-stable@nongu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2362
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > Message-ID: <20261027174625.4025878-4-peter.maydell@linaro.org>
> > ---
> >  include/net/eth.h | 22 ++++++++++++++++++++++
> >  net/eth.c         | 18 ++++++++++++++++++
> >  net/net.c         | 22 ++++++++++++++++++++++
> >  3 files changed, 62 insertions(+)
> >
> > diff --git a/include/net/eth.h b/include/net/eth.h
> > index 46dc9ed5acd9..042b2fc42db4 100644
> > --- a/include/net/eth.h
> > +++ b/include/net/eth.h
> > @@ -437,4 +437,26 @@ eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
> >  bool eth_pad_short_frame(uint8_t *padded_pkt, size_t *padded_buflen,
> >                           const void *pkt, size_t pkt_size);
> >
> > +/**
> > + * eth_pad_short_frame_iov - pad a short frame, iovec version
> > + *
> > + * This is equivalent to eth_pad_short_frame(), except that it works
> > + * on a packet stored in a struct iovec.
> > + *
> > + * If the Ethernet frame size is shorter than 60 bytes, it will be padded to
> > + * 60 bytes at the address @padded_pkt (and the caller will need to handle
> > + * it as a not-in-an-iovec packet).
> > + *
> > + * @padded_pkt: buffer address to hold the padded frame
> > + * @padded_buflen: pointer holding length of @padded_pkt. If the frame is
> > + *                 padded, the length will be updated to the padded one.
> > + * @iov: iovec holding the original Ethernet frame
> > + * @iovcnt: number of elements in @iov
> > + * @pkt_size: size of the original Ethernet frame (i.e. iov_size(iov, iovcnt))
> > + * @return true if the frame is padded, otherwise false
> > + */
> > +bool eth_pad_short_frame_iov(uint8_t *padded_pkt, size_t *padded_buflen,
> > +                             const struct iovec *iov, int iovcnt,
> > +                             size_t pkt_size);
> > +
> >  #endif
> > diff --git a/net/eth.c b/net/eth.c
> > index 12ec316e240e..14006222d68d 100644
> > --- a/net/eth.c
> > +++ b/net/eth.c
> > @@ -536,3 +536,21 @@ bool eth_pad_short_frame(uint8_t *padded_pkt, size_t *padded_buflen,
> >
> >      return true;
> >  }
> > +
> > +bool eth_pad_short_frame_iov(uint8_t *padded_pkt, size_t *padded_buflen,
> > +                             const struct iovec *iov, int iovcnt,
> > +                             size_t pkt_size)
> > +{
> > +    assert(padded_buflen && *padded_buflen >= ETH_ZLEN);
> > +
> > +    if (pkt_size >= ETH_ZLEN) {
> > +        return false;
> > +    }
> > +
> > +    /* pad to minimum Ethernet frame length */
> > +    iov_to_buf(iov, iovcnt, 0, padded_pkt, pkt_size);
> > +    memset(&padded_pkt[pkt_size], 0, ETH_ZLEN - pkt_size);
> > +    *padded_buflen = ETH_ZLEN;
> > +
> > +    return true;
>
> assert(pkt_size == iov_size(iov, iovcnt)) or just drop pkt_size
> argument and comput it?

The single callsite already computed it, so it seemed better
to just pass it in rather than re-run through the whole iov
to find it again. I don't expect this function to be called
from more callsites in future, so I don't think that the
assert that the caller upheld its end of the API requirement
is really necessary.

thanks
-- PMM

