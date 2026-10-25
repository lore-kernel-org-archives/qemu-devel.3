Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0748606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j1aL7jgO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL5C7-0000SM-5n; Sun, 25 Oct 2026 16:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xL5C5-0000Rj-HZ
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 16:51:53 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xL5C3-0006AO-NB
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 16:51:53 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-35f036b17easo6320243eec.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 13:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792961508; x=1793566308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YGqxqQUAWKzre7etrWJb5GD7AmMrOx5V1C8BLM7XZY0=;
 b=j1aL7jgOrzEJF3FQ2g9fJ1m6dExbDOYPCjKJcOqVYyAoexdydsHHV/XPohVsajZoo7
 eWRGoe+EcP2VBs0lKaj/MSIvgy4mUbf3NQxpFbgZVGmDCNHMkVpnPgtKgO37A78xsWHh
 zsL5L2ge0zQ7YKrXaWXu6xfyMiDxMh4AieQsVdANAJNqgdp/G/L4HsGc/yhIKTgUWq15
 7w2wFOPC6fD99eFAsLyTARYtpKq5k9J+A2p/+6Yl+tswIGVGjcrX8r409yZr+pWDwoBb
 XrZmqMS8S4qCN/ReQ/KHPpaLD/z7j2d7OWLTH5viz+OoasqcEnzT9rE1DvbhWk2n/k8h
 decw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792961508; x=1793566308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YGqxqQUAWKzre7etrWJb5GD7AmMrOx5V1C8BLM7XZY0=;
 b=pAxtmwk/39aqRYNjnYHGtuvJU39Vji3lhcVeMjfR86Q6s0eW7jN6cAAUVI8wQ75iFC
 booBhjZvURwe820JYyJkuDHYcV98MtXL+l2xhFclgzcTg78zI0uR3KOWDGo51akqQS8Z
 sbW+6e+95an7+b32347yiKeyymuKRBNTe3iHEqq8KdqjunWlh1JaxHugXEqhk6Pp5nUn
 5GECZE0AK8AGGw/R1wZ3+2OKb54Wlqb1bipJkY9ws+FHdfnRFs7QFin2ymJ9TrB2AbOG
 w/I4ATIPRixagatJr4NOEizqPKOlRvWuXYUiFaE6T9rf2E7qDiD++TvsW3iuMRYq655/
 L+Rg==
X-Gm-Message-State: AFq9FYIFFwtCDJEceo6SXU8v3DrfjbXiHr3459dwi63RsKrpL9V3XhgL
 B6nbvIIeSzbrTZniKkQCE9My/JpZnWnnYLalb4DPO0ks9PMHodZuqYTZ
X-Gm-Gg: AYBFou1GRiZGE1D2N/YENs6vN/FON3bqe08H0Vf3A/zEexXVF/KAEZrHxH7Iy3yjBha
 Bwyu14P2h6oSwuUf7+2hKIXgUigZahfpV6WKWuvXD1fWrnGuOPEXJv/uPcT9OeZqfKX6XePcAv8
 lnh7ra6chaUbHNXOcYyQoXiS3yuiRUTqXGFhKWLg8DsRla/kkL5iIAVDVIweQnfJhejXKUPxRI9
 Nlg14i0fvLSfvNeuvLJPUZOujSEcThRqvuYl13Y5ObSrWY58N90hs1k7P/zUqb1zoDnSr2JdCn1
 aavdF/5hajWkdR2RSPwuLvAl471m6FIQgU+A9jDwCSZBokwdmB31lSzQQhs+7QGzKjkk1JWlmBc
 qWIN0GhRZFGyMzGMe7bjYV35DWQ/HxhQ3tMsa4Kzsj/Zf9bbU20QFgY1VNjz4/xCAAYJ53DhNLw
 iht/7u3FoBFn9JoB20D51+7RXFiz5SLPBKsEitaspZNou3E3GuW68RXxgCOpqTSYukQ4DAMkMCK
 YpUVeDaPWVBu8xEYTcFLClC3L6zKyBxgBBUqjjxWm9PNxc=
X-Received: by 2002:a05:7022:b05b:b0:196:aa86:fcf3 with SMTP id
 a92af1059eb24-19937da1c5cmr6737331c88.26.1792961507603; 
 Sun, 25 Oct 2026 13:51:47 -0700 (PDT)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a2a5937dsm18680738c88.20.2026.10.25.13.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 13:51:47 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 0/2] linux-user: validate the fd for a zero-length
 readv/writev
Date: Sun, 25 Oct 2026 20:51:42 +0000
Message-ID: <20261025205144.1781959-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87o6chn1nw.fsf@draig.linaro.org>
References: <87o6chn1nw.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=takano32@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alex,

thanks for the review.

> I can't imagine why we would want to leak an iovec structure every time
> this is called. All the callers seem to have handling for NULL. Why are
> we not just setting the right errno?

It is not leaked: every caller hands the vector to unlock_iovec(), which
g_free()s it, and with count == 0 the loop over the target vector does not
run.  But you are right that there is no reason to allocate at all, so v2
returns a shared, empty vector instead.  It is never dereferenced, and
unlock_iovec() now skips the free.

Setting errno in lock_iovec() does not work, though: the answer depends on
the descriptor, which lock_iovec() does not have.  readv(fd, NULL, 0) is a
successful no-op on a usable descriptor and EBADF on a wrong one, so the
syscall has to be issued for the host to answer.

Since "the kernel does X" is a strong claim, I checked both halves.

Kernel side, in this tree:

  - fs/read_write.c: vfs_readv()/vfs_writev() return -EBADF from the
    FMODE_READ/FMODE_WRITE test before import_iovec() is reached, so an
    empty vector still validates the descriptor.
  - net/socket.c: __sys_recvmsg() returns -EBADF from the fd lookup before
    the msghdr is parsed, so recvmsg() with iovlen 0 is affected too.
    do_sendrecvmsg() turned that zero count into a successful return for
    !send, which is why v2 covers recvmsg() in the test; sendmsg() already
    issued the syscall through the "allow sending packet without any iov"
    path.

Behaviour side.  I wrote a harness that calls readv, writev, preadv,
pwritev, preadv2, pwritev2, vmsplice, sendmsg and recvmsg with an empty
vector, plus readv/writev with a bogus vector pointer, on eleven fd states
(/dev/null opened O_RDONLY, O_WRONLY, O_RDWR and O_PATH, a directory, both
ends of a pipe, both ends of a datagram socketpair, one end of a stream
socketpair, and a closed fd).  That is 132 lines of output per run.

  - v2 matches the native kernel run line for line on aarch64, arm, i386,
    ppc (32-bit BE), s390x (64-bit BE) and x86_64.
  - unpatched 10.2.1 differs from the kernel in 64 of those 132 lines.
  - the only mismatch the harness still finds is readv(fd, NULL, -1),
    where qemu returns EINVAL and the kernel returns EBADF for a bad fd.
    That is the pre-existing "count > IOV_MAX is rejected before the fd is
    looked at" behaviour, which this series does not touch; doing it
    properly needs the fd in the caller, so it would be a separate change.

The regression comes from f287b2c2d4: before that commit lock_iovec()
succeeded for count == 0 (page_check_range() returns 0 for a zero length)
and the syscall was issued.  Hence the Fixes: tag.

Tests:
  - tests/tcg with the new test in the suite: aarch64 106/106, i386 78/78,
    arm 64/64, s390x 135/135, x86_64 73/73.
  - ppc-linux-user has no tests/tcg directory upstream, so I built the
    same test by hand with powerpc-linux-gnu-gcc: it passes with the
    series and aborts on 10.2.1.
  - the new test compiles warning-free with -Wall -Wextra -Werror for all
    six cross compilers.

Because the vector is shared now, I also checked memory and concurrency:
eight threads issuing 4.8 million empty readv/writev calls against valid
and wrong-mode descriptors finished with no failures, and qemu under
valgrind reports 0 errors and 0 bytes definitely lost.

Changes in v2:
  - return a shared empty vector instead of allocating one per call
  - explain in the comment why errno cannot be set here
  - cover recvmsg(), which had the same bug, in the test

If you think this corner is not worth carrying, say so and I will drop it
- the divergence is real but small.

Thanks,
Takano

TAKANO Mitsuhiro (2):
  linux-user: validate the fd for a zero-length readv/writev
  tests/tcg: check that a zero-length readv/writev validates the fd

 linux-user/syscall.c                          | 20 ++++++-
 .../multiarch/linux/linux-zero-len-iovec.c    | 56 +++++++++++++++++++
 tests/tcg/multiarch/meson.build               |  1 +
 3 files changed, 74 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/multiarch/linux/linux-zero-len-iovec.c

-- 
2.53.0

