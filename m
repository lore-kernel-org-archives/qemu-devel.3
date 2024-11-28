Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D5ED6910E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 13:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGekv-000781-KY; Thu, 28 Nov 2024 08:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGekt-00077e-R4
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:40:27 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGeks-0001Gy-2A
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:40:27 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ffb0bbe9c8so9866621fa.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 05:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732801223; x=1733406023; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mYIw5CzD29TTdhu3LNEWrtosWvih2LXv5lAAOq5ivNI=;
 b=wg7BQp9nHe6mIzZOGjHBO5IDWd+gFiqiRqja7qeeZ4gRpDD9UYh9APpBwDPn+Ysml7
 5GAqS1IlbpguyvBtDOpb7JNfVBGcRbepcIrMaEmFMaAfJ+9YROpsD89/pgwOS7XNelBc
 FqKL9ngxfCyDD4PQi7MUNcKNbGSgLsqz5A/4nkOIa0HnrLMLMW6cdWCJwLDU/f07o9dd
 KWoUqEG0wgE19ej0/eg2FTO0jVrYYiFEMhyi0aszblFWD6dLw4YjGnO9F3zja2KMLsdE
 spc7W2G+8aBiSWdgmOFWTZUPQgY/0Ei3+25WF3q2OCboib+Vi60SMHGUEdQgDMVWlzf2
 lFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732801223; x=1733406023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mYIw5CzD29TTdhu3LNEWrtosWvih2LXv5lAAOq5ivNI=;
 b=e0JN9RcmAu1A2lMhjIKQcODvN4i82+61QerCKk7zmdrldhC1CxWGAufXAFejSHZ8CP
 8ia0uU7bDfzjj44CMqR/e4Y4028LfP8xOKCQ5ZDipImIIZI6EjQfwf3821LO0/w+bQmU
 yqBOGbyfxwkb6Lx9367JjFngGFzFpgqjDwtNz4aTOenuiOFlB4VE00KjlFNuEegfz6yW
 jvmq3+K457Yt079VmjdoldWK/bq3Olm3haQVRGDYtXSoPqsIK2TqZS5SfaE7yIpfWJ9n
 McwvzxDIgaLWK+bDRO12St5QTL5CYCHjSqu5NcPWFW1Qki4h930wY6nntwkVGLUnYx0t
 nDsQ==
X-Gm-Message-State: AOJu0YzB9RT1LEXq+MtlUX6YXLDriDaJt6YnamOkXIvbhGzzUqTxQju7
 +ZUNvmsyQgX8gr6YUuT8667EuZ5CKmA6rHsYIl5FYUNP6ghRRCexEbipD0d+qwpndUsZOJwQYCp
 5+yEf3DMbQkX77llLA/7ZVPsVBiyC9fu8EBCuX1vs1bzRyWJO
X-Gm-Gg: ASbGncvLt6xg+KVe1D5jHRGSARqHtsjc4o501MTd0OKKgIgC7Ruj8mT6ROz/xUecFtM
 MPCxEZMWRl0YXXtVctcOAH5GWllM89ODC
X-Google-Smtp-Source: AGHT+IEAEz8At6bPv4MF7EOWYonxnQHRyh5kwsl0jcJ6zvhGow+abezDqO041TCRmZ2LSHYqKvf6rNjTyWFtClzMdsc=
X-Received: by 2002:a05:651c:993:b0:2ff:c757:70ec with SMTP id
 38308e7fff4ca-2ffd6099f54mr45586211fa.19.1732801223504; Thu, 28 Nov 2024
 05:40:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1732715823.git.mst@redhat.com>
In-Reply-To: <cover.1732715823.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Nov 2024 13:40:12 +0000
Message-ID: <CAFEAcA8+fqTg=_e7KOQ=aV8F68p2VOGsognYLmrymerXbp90-A@mail.gmail.com>
Subject: Re: [PULL 00/13] virtio,pc,pci: bug fixes, new test
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

On Wed, 27 Nov 2024 at 13:57, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 34754a3a627e1937be7f3daaa0c5e73d91c7d9b5:
>
>   Update version for v9.2.0-rc1 release (2024-11-20 18:27:48 +0000)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 571bdc97b83646dfd3746ec56fb2f70bca55b9a2:
>
>   vhost: fail device start if iotlb update fails (2024-11-26 17:18:07 -0500)
>
> ----------------------------------------------------------------
> virtio,pc,pci: bug fixes, new test
>
> Some small bug fixes, notably a fix for a regression
> in cpu hotplug after migration. I also included a
> new test, just to help make sure we don't regress cxl.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

