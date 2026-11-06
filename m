Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6917E606A339
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NtpEJK2o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPLmI-0003Ot-Fw; Fri, 06 Nov 2026 10:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPLmG-0003OY-RZ
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:22:52 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPLmF-0006I3-2i
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:22:52 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8b32daac9d7so6720237b3.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 07:22:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793978569; cv=none;
 d=google.com; s=arc-20260327;
 b=SPpRhb9HGhQikKqA23u7a8gN2wYDICM8+hM597W5Pr9xXMC7djztrA7iVBQciGNahl
 wSdL0tmB5TVf5CULst9nhovGKwreUDf1HFs2maTycUK7sc5xWiogwTpKsMjLNY39uI96
 iJ7euuzDWQSNp5/R9dqa/uOgCzXmf2hQxbILclzAcVxX7GuPJJPqs5gzi9q1YmQHijD9
 NP8v2d3MXgi9C8Suzph15G8v9i7GcbsJMyhv2n1XVLr/Qn9Rg8yR8doxLx4GV4ZY+iSh
 eeFm6GNTvuVip/oVUzYPpc7w1tja7+I+IOR9rm+ZjsWG3QCx8PgT9Zilmf4nSUj8g9VY
 yJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NgCynz2BTXsi7D6o3kCFYHP6eF5uA7H0LsUorveUV7g=;
 fh=MhcCqq5gAvn/L69t4A3ztshTIsi/F7yWQbULmDeqpjg=;
 b=Uke9ez9WHu+VmCur/RxrG3Eh/iflSo7Dj8s7OS4WRYAtVtw1gyFEJ+Fwat09JzZKh5
 gBMrkxnl9t8CqdXSUm7xeb5LcYTgTs6WU9pUZj0Zf7pzl7i682jqKCENvfhP7ks5PaaZ
 fxZnxQufdJgpDDSeijdFD1oI4B57L3VoxD7G9BykotiVSQZGqL7W29rmx5TJ7zoev5Lt
 IDb//YVXThW6WmMovRrLbAM/ZTK8RUrHhruaWa862eoNUxlYDkuRLVB8L1hT32Xm9Smr
 DBDwlhBxtiVQHo+AtSPU3PKwjv1i7qEFmUFurpu9OZ/HkbCcBucoKMN/Ea3yxCfWX4VL
 AccA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793978569; x=1794583369; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NgCynz2BTXsi7D6o3kCFYHP6eF5uA7H0LsUorveUV7g=;
 b=NtpEJK2o7U3Ixhlh2C/RHInUjTAfdokXKtp/nQIX3UyyhjMoMMbT6RKc8VnOKNBcSB
 JLdnwT6O+Nnjy8BCkL8cvO9QJXbjN6p8jS3rn3t4UyUbEO11mt/FSYn9NyXvD1EmQ9d2
 xuvxyXQG80PaELeuG2nQEIDyBZhF7JaT029/TBpWhyeXWdM1XcXYLmXWE1qqJFJubvgv
 9okyMgtYvdUJs6jbJNxLo7iLUWP3laJVSZk0BI1sf+kPtQPYqxe4Bfx5sj/mfeLJWWYi
 ySde4PB2E37uB4Mvbo0HWUHmSd991abN6B/9cxaU5bI7QiRSbJoER5FIE5EWbzyoLVxZ
 7owA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793978569; x=1794583369;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NgCynz2BTXsi7D6o3kCFYHP6eF5uA7H0LsUorveUV7g=;
 b=TVX/Up546sHc99kMiEu6L0iwt222sk3HxSyp1UfXXiUEJKMFLZ84kHOVp6uhLbguy/
 xHeyGQRpZ69LY5sPayu9pmL88r7+EtBPwzR27HG1WpaTcT14VG5cgj0HcB7+9D6sUeU4
 +OIuV8y7jz7hcorIRr0WDv89J6ZwwINb9aqCsCvPmDwASSSS8cqFatdgSaizGLnNLuqu
 zeFKADZOaPVnLHC0qW8n9f+E/SDxBfktgcDRaQMzzVExlbx1jYCdxmn+SB+Kgy6LGWUi
 VR2etF2WJrW8tl2OJGdTRW0z/LKVfDuhQDRWrBEHrHWW/dTYLlLEiEmFmbGr0LN34vKY
 oTkw==
X-Gm-Message-State: APuU4Z+sReCQ+RADR40rbgpVEkZ6qOhtgmw/ntmOQAofp4ViRqCFAyo0
 xCUP/whaopSQD2WfgxaHm5Ze5557m/5cGY01y8HJsVQZg+0tAmw37qnlHKNYNj7vdrTQMFL2tH2
 oq9d09pp8Flvip5mcqKQIqWMAIsvK2hSR3aymQ+11SQ==
X-Gm-Gg: AYBFou0j7AunnScZD4QvXymM7CuB1OcijGM3+MGge3KX9BULbqjAjyNqLChYePWBrrR
 zIKvLASa3yW861g/+CzYMuOgjywXLRhHcOnKLfzHbPFi5wXpPZgxsk7dc2AYanqpqjqTHEmkCc8
 jeYefDOrJg9MAyUhLiyQ4/0QGgx8AmbXG4KuDlNorHdYQiCvodXt5GIMH/F3FaAalkiVBFowPFU
 9mI57QCAbG3mVxx3J8OzWvsJ9GCFN5dVh8MyWxO6dWU1so3q3+SpKoAPqiRGsauvmaXhaolax7e
 rrBsBSyQJSpon38TnC/IH2Kt0/rCNYSW3JsNhQEK6gGEH6Qm8be61ZII5HG/uCiLbRWUoJYQ9ng
 z7mHTyCRxLHvJ6E6Jqy14uxIr71Zl0ay7OhU1rU1k9pnIOOKY+W13sdnV1mHmKtTOp+YpguT8un
 f6UaA/3mRhtP1ucdD9zk5r
X-Received: by 2002:a05:690c:dc8:b0:8ac:c329:682d with SMTP id
 00721157ae682-8b341917c9emr17131407b3.11.1793978569320; Fri, 06 Nov 2026
 07:22:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104140058.24068-1-marcelomanzo@gmail.com>
In-Reply-To: <20261104140058.24068-1-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2026 15:22:37 +0000
X-Gm-Features: AclHuK_U9J4G1p9ShG1MX9X2A8t5Zq8VUeUZoSsx1y9Hlnl9-74V58pyzlRfhqE
Message-ID: <CAFEAcA8ZMdOF0MphnEEYTNTRJPmzx6rw0Q9N0jgiBkb9W1tf7Q@mail.gmail.com>
Subject: Re: [PATCH] hw/net/bcm2838_genet: fit the RX frame within the guest's
 buffer
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>,
 "open list:Raspberry Pi" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 14:01, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> The RX path clamped the payload copied into each descriptor only
> against the whole RING_BUF_SIZE register (whose upper half is the ring
> size, not a buffer length) and against the size of the rx_packet
> staging buffer. It did not account for the status block and 2 byte pad
> that precede the payload, nor for the 4 byte CRC that is added to the
> reported BUFLENGTH when CRC forwarding is enabled. The BUFLENGTH
> written to the descriptor could therefore exceed the buffer the guest
> supplied.
>
> Clamp the payload to the guest's buffer size minus the status block,
> pad and CRC. BUFLENGTH is then at most the buffer size, which is at
> most MAX_FRAME_SIZE, so it fits its 12 bit field by construction.
> (It cannot overflow today, because receive() drops frames larger than
> MAX_PACKET_SIZE, but nothing in the descriptor code made that obvious.)
>
> This also fixes a hang: with a buffer size of 0 the old code copied
> zero bytes per iteration and never made progress through the frame.
> Treat a buffer too small to hold any payload as a guest error and drop
> the frame.
>
> Resolves: Coverity CID 1690161
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

