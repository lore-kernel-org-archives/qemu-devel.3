Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA95606A323
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BTgGRhTK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSBD6-0001VK-A3; Sat, 14 Nov 2026 05:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSBD3-0001SY-CJ
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 05:42:13 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSBD1-000671-LV
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 05:42:13 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-67da564d9f2so69119d50.1
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 02:42:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794652930; cv=none;
 d=google.com; s=arc-20260327;
 b=fuUOWtIjLCK5Ifp0gzgTklR1c1awj7nUijMYTyw63+qC1psw3DDsR3uGj8tHuR4Sbr
 Dhh4sC022vv7e6LPdqE1595k4ZJAww1oOdEcsqXsVAa+0DbCosKxK+4mwawrIx6VyKtj
 7ZO7qp84wfLyQQQHI1fcKAYSgQ5r2Qp984NatjCoVhlu2s5DQo37BjKxS1UzgvnuyH/6
 PKy4reX5OnQx+rL2mXYxsfe6VaNv8drgNTQxyAONNyNvcUAdPRTyzS6p/8MhMlcSeZQL
 QbJl6YHZJGexcEfIkZMxP56qxwJ9I8H8vAxTCArE9T8fIAFUkUqIAi4B36tDT5JEZmFR
 XX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZbMNu8rVVbpj1Wz6jokJjzS29iXhBMqfEtrbhhm3tH4=;
 fh=ic2umZ6Y/6W6kaBoo05PtRwwqgr3CSQEyu4S+EXZuAc=;
 b=oVDYQrdMU5mpX4YIopDXI6Igeiox5RHb6dy/h6kG3ovEVAPgkwsb44p+ni101TB2P4
 oxq0VCRa692kJPGqj9seQ2umzdYim8dYlgcNmtfeZLcYfVyfjlsmBCWF64hCjQ0hnaRH
 BLon6VBnaM/2h2U75ru6ykJYu1OFV8y1zy7bnumdKix4kyJsy626iYg56DZ2+3FqhsJi
 JdC3tzzt4nNdn12VxglTPhXxAPbDdSJHcME8DXzRnKWvD53jLlSp6D6K9qr7PcDzz/jW
 tUsG484K6/fmTbQ6TlJpvE+y4mw5/FZNqUufl2QF1jpWuh5ZVeaQPT/Xe/Iw1swSpUJa
 2lkw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794652930; x=1795257730; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZbMNu8rVVbpj1Wz6jokJjzS29iXhBMqfEtrbhhm3tH4=;
 b=BTgGRhTK9sHCTCI9lQU6q14VSQirKFrn42KG4yeqRtl96iZd/77zf7nJ3eW5gU/cD6
 97c0FAsXKgsIJlqwZKJzcrC4d/LgSOgv2HaYOVeFyn1QueVer9E8gKdxjVLkv2OS2p4+
 loW7cRz3MZiUUzS5ivwmhrW0STEH///NA8s/8GMXTOaYskwdtPlDjXApWTT0GcIWnw1f
 vJ5EjWG/W1yvibcvT/DIoWnC3t21mfTcmP82WDS5T5TWWP9LJXJW2dBGgsFtTX55RmHL
 ZDGGhvWQlbgHyH8VfKK3aOS+0M75JcDlFwOSSERh90Qr+Aq9I4Abw5Tm0+1k0659M2ka
 +SRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794652930; x=1795257730;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZbMNu8rVVbpj1Wz6jokJjzS29iXhBMqfEtrbhhm3tH4=;
 b=WAulpHTcYc6o1dIGc2+X9DzJB+wARmFMKF/P6xEggDMdGD30FLezIGdMzfsrvMCBvt
 lAdL2SlfCJoZw9djahwC0hOL+tRH8Bx5DR3agmxetbzoFBJ4cH6s5/+xacmxPq7DN+wq
 K6yAh0EpIYSwACNUtqi7nMfE1AHhTu7FtTPkXHGJfleyygRsZ8jGqAWra9piTA6hJNIf
 Dp4cdpjllB4OCQLh30h+/4u4o+swlwvxgGF52OmXM92EyLKb7ljgs9O0O3/3dRZ+uDw2
 OXw+msU1KBwz2oc8UfxvCxJ4mIzKYQNcsdDpE5f/SsbPpDMyXYaqKIpNhnj+rjFrDeJq
 pCww==
X-Gm-Message-State: APuU4Z86mCI/UUoC0pIZnbcOB+V/mpkUIRyFLv8JROBx5uREWiElm/+D
 Enake2I2pxHHVjKZJM/YVtHIFsXejp4RRJziJujqeQWH20faaa4z0p6zrvEwiTrzmrgaLG4LGf/
 B3EHiAmuVPqG6hWEpks+S7jJecjaNhzI8hCJPuUa0ipp+YccBcI2+ec0=
X-Gm-Gg: AYBFou1A+5J4yOq+vdt1qHNrEXu+cNhyERIfytNWpVJrZJ/jKlP/bdp+YOBDYaEJokZ
 o0ledSpU9caHB9Gf3ir7JMwVJfSawZEReo8sKZ9djd+P4Is5sQH4uRHOwNwTbYjTwcc6x+YG3Mf
 h9KwS8Hr1JRDKNBFql7Z1X7whpLNmCY+uN7pXSYAL+yBI+7v/HHz12kTaMYGSRmsqu2hWb4GFs0
 qyjDBiLdWPLa38WD3DKFB0nQ+9Sm78hFUSwfZfdSBmjxEtLHrkOrImeAr8Ye54o2HqrSJvEDD0Y
 Yw/VDqDosAXUtNdTTjdYJhuk+wue+HSFmYWKXW5r/BA5y7mAi3ZeQxH+pX0CMvEShYI2t1KZlaT
 pNXoWIjLKvcO5BKTiSOobNjR7NCXN7/nPR57JP7CgwNDDgsOn2PcD8+uffFN4UOrcKQEgjh/1Hx
 XA8gTR7Dj/6Fse1Uq4zodO
X-Received: by 2002:a05:690e:419a:b0:67c:37f:a846 with SMTP id
 956f58d0204a3-67d896dca75mr3071597d50.50.1794652929966; Sat, 14 Nov 2026
 02:42:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112180239.489819-1-peter.maydell@linaro.org>
 <20261112180239.489819-2-peter.maydell@linaro.org>
 <1c57a740-c743-4d1f-8709-a59455ec7cd4@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <1c57a740-c743-4d1f-8709-a59455ec7cd4@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 14 Nov 2026 10:41:58 +0000
X-Gm-Features: AclHuK-uhPWiTcCsYw8DGTpjT695mmNnsMzUu1I8cxizPsSWfundx0pNW0g1W10
Message-ID: <CAFEAcA83M8SQfPSMWw8sqpxNxRZK93Lr8zRHowmhcmC6DG1yjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] net/checksum.c: Correct handling of IP header length
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 at 20:19, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/11/12 13:02, Peter Maydell wrote:
> > In net_checksum_calculate() we are careless about handling of the IP
> > header length, in a way which can allow it to become negative for a
> > suitably crafted packet.  This bypasses the attempt to check that
> > it's big enough, because in comparisons like
> >    if (ip_len < sizeof(tcp_header))
> > ip_len is converted to size_t and we do this as an unsigned
> > comparison, so negative values of ip_len pass the check.
> >
> > This results in net_checksum_tcpudp() attempting to checksum nearly
> > 64K of memory (because it takes the length as a uint16_t), which will
> > typically be a read off the end of a buffer resulting in a segfault.
> > If the attacker is able to set up a situation where the read doesn't
> > fault, it's possible for some callers that the 2-byte store of the
> > updated checksum is an out-of-bounds write.
> >
> > This code is used by at least xen-nic, virtio-net, and the COLOj
> > filter-rewriter, all of which are in QEMU's security "virtualization
> > use case", though the write is probably only exploitable for the
> > filter-rewriter; otherwise it's just a theoretical "information leak
> > to guest" of a 2-byte checksum of 64K of host RAM.
> >
> > Improve the checking of lengths in this function:
> >   * assert that the caller provided us a positive buffer length
>
> The new assertion is reachable through eTSEC. It assumes callers always
> supply a nonnegative length. However, eTSEC accumulates descriptor
> lengths without a frame-size cap, then passes the unsigned length to
> this signed parameter in process_tx_fcb(). An aggregate exceeding 2 GiB
> can therefore abort QEMU.
>
> A natural way to fix it would be to change the type to an unsigned one
> that can contain that large length, which would also eliminate the need
> for the assertion.

Rats. The reason I didn't change the type was I was hoping to avoid
having to look at all the callsites and whether the type change
would make a difference to them :-)

The eTSEC behaviour seems like a bug in that device to me (of the
kind that I put the assertion in there to catch): if it has
no frame size cap then presumably the guest can also get it to
overflow its own uint32_t tx_buffer_len ...

thanks
-- PMM

