Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851EA606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=df5mcEIh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMSxW-0005WO-Cl; Thu, 29 Oct 2026 12:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMSxT-0005S7-H9
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:26:31 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMSxG-00020O-1X
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:26:21 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8ac9d666d4eso21922867b3.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 09:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793291177; cv=none;
 d=google.com; s=arc-20260327;
 b=g1ddrv2UhnBFNfV6KNnnQ60fLqp8N4fCSnbRMAJWTZTxyC4klTqycjwzv0oSicaTyp
 kajdR7S7A9ELFReXvswg6JpPGHNo7xXnOUkC1yj0ycWi01AGqCIkeB26OwngppcOnbwu
 uLp2dBT+x/d+z1UY72xXMQhK2Gz8bJMhAcr39lZCZ5JHwoA6SG9UhjRw0E9pXYNG7fDa
 KG8Wj0zWDEdB5q7UuROuuslHDoMzg69Wz2wO7axUATFLadg9TiDtywk7Q7Rrr0lU6pS8
 8FX5cQYrtI/qfWwC/4e+JHf6LNO0MspjgMNjbh9Cxit9wZ5GSoSEv2y1TTzgGel70KFL
 4GNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rboMDpBeuMnweIqqF0da+F+NZQ37KR/cgbPO9n8wc+Q=;
 fh=awQMMknHcj1HIuFUrvcecN0YXHDVa/EdgcU1qdAHEHg=;
 b=d2NXIVNUTJpRFlV8RA9qi3IRyZxH/jC/UC0s40HkON6+2rWJaQXf2N77IYUNSWpA8+
 GGcdTvbJdkcyXeQn7sl5HcqqYTuttpuzxdixzD+6Dc1gyTO5wUCy4tSNLPVpSKPbGEUu
 Isq4NlSJ+n/bVAjSm0voxbpygH9RxocgKh/m2PdBrBAjYc89NBetTA386vC3h3CbxC73
 9pWPm+fhqMY/Gle6RsQ6ultrwEQBLmXn28fw7UUuDOnUB2rHrHatpUiSUl2UIHcbeF65
 3bfMb/0XdTLZ9P98MZHZg83lvlbGTy3CUnSjepG570btHpsX9SMN2tS/5Hiqcmip8FEG
 k/3A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793291177; x=1793895977; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rboMDpBeuMnweIqqF0da+F+NZQ37KR/cgbPO9n8wc+Q=;
 b=df5mcEIh3hGyyhQTRh5XN/wLvuaUvMEoxn8RmA2c7DGzjj330KDKLCAAu2bJyMvvei
 Odzn094e7pbiWCe9qOjpRR3zaxtjdKJWGo5URZLDdKJ21SfF3fRALduv9Z44maL4CSLd
 y0p9uUiXAWUyUh8/5DXjva2ARRI52yYa64iVuHN03SAyGHBVibHjfLwUtAkUjtoZdLVn
 5V91hcWhQTGJIdGMfsq+47xlKVgI054n/9G/Qemducgo5+ukDiLhg0evt7tqLNSblmbc
 Br8Qsff+JWKoRwoB634YbrLyIUqB8RAIGoXFendURaZZv3IAxpDB/XiDTvqmveiYUp2v
 zevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793291177; x=1793895977;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rboMDpBeuMnweIqqF0da+F+NZQ37KR/cgbPO9n8wc+Q=;
 b=Xnd+MbGJ/C4edYE0P4TcpPdWSL1iWAbop9smmYnTiFdSOO06qbL6sUdE7GrJvIwlKz
 pfsG5GawXq0IhVTYNXUWis5byumaxNzVtUNEGvNs0yEQ4YsN9CoSYy9xOp/juHe/UTOn
 PAx7BA/9biBByTe8Q7MAJBGM55QBE7/l4pIQhK5bywUa0AMabjJ+OhDoju08M3HhDPFT
 1EzVSaWj9dgvYGX5a2PJah2QybhXHSkG7EIENhtnFd7Mogp2Xkb/dYOEhCGMSHhrRqOw
 TTFQwWYSnnI4cPbiM4U+y3NvTGLNl1LAYWBVkWl+wqH53QgqeiQ/YCb2Ct6mGj2OD6kE
 uy4w==
X-Gm-Message-State: AFq9FYIuN6baA+hKiT2Ov6Nl+8ovTuJ3GtRSIOsZ/nvoYUmXqqA03XrA
 Zs8X3T9gv9uxvzih6XaZAPdDRuB14Ez1Zk1pW6J/EboRSZSXo7sQNYOiDXLQM0uENgOxmh8d/Ap
 0BwYWPdoxGnI5bELX3Mv/HBmac+F4zJtT5/9Yt6IriQ==
X-Gm-Gg: AYBFou2qeb16WSSFrR8Ep1af+GjuSL67R9lTzAMEl9dg4f0zYIxE4Cjm6Gki04I7w5X
 7ugEIs4ktoGtqcu/v01qR+fV3whilWqK3pX/GsHFnkMq4MmUpOth4n+/r1w7MnrGUuTM/IbV4Ke
 vN9aG/Yvuumlk/0TXp7QAUcBEwjJZhDKK+B9DCnTgF/PHain2R44DPL9di6yP834wVMNolnV4V2
 tUHRes5+0GFwIBr6bq+QDjF9bgqYMwCau7IbdDzLzAeByqk6g6guKnq/MbK2P9vG09KEFsguiMA
 CDu/R0ldxHqzzQBrvr2sWEeUezUIRansun7PB1wvC3CXWDcS22TmOdeZNiDu8VlQcM3bVhV26U3
 H/nB3DXmaixPs7ivKY0Mc8Z9pjVR8MfBXb5DCTbwmYcFdY5cJByLbhlYbQ/rq0Un1mneGBdg6/F
 bOLRmE9tswbDwrmq7dUViK
X-Received: by 2002:a05:690c:a418:20b0:8b1:691f:ab4d with SMTP id
 00721157ae682-8b1b5ba3a5emr25186867b3.35.1793291176643; Thu, 29 Oct 2026
 09:26:16 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
In-Reply-To: <20261029161310.2065290-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2026 16:26:05 +0000
X-Gm-Features: AclHuK9976iUpOpY-stlbaM0kWQ4mM3eEGmCkDu-jTwWO864DgDQWSG___DuduQ
Message-ID: <CAFEAcA94Fv1v2zZX6LaneTXd5+Zp=EsVRCL4NkCdcyJH6Hkwww@mail.gmail.com>
Subject: Re: [PATCH 0/8] fixes for 11.2 softfreeze (checkpatch, gdbstub, wfxt, 
 bcm fb)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Chao Liu <chao.liu@processmission.com>, Tyrone Ting <kfting@nuvoton.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Hao Wu <wuhaotsh@google.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Thu, 29 Oct 2026 at 16:13, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> A small selection of fixes as we approach softfreeze.
>
> The core changes are tweaks to the WxFT emulation which fixes a
> deadlock when the vCPU goes to sleep. There are some tidy ups in the
> following patches including an import of the test case from one of the
> bugs reported.
>
> The is a quick fix for a gdbstub test regression I inadvertently added
> in my last PR.
>
> While checking the series I also ran into an issue with checkpatch
> which I have a proposed fix for.
>
> Finally there is a random bug fix for the bcm2835 frame buffer.
>
> Alex.
>
> Alex Benn=C3=A9e (8):
>   scripts/checkpatch: validate fixes against origin/master
>   tests/functional: fix call to common_tuxrun_gdb
>   target/arm: hold bql when SEV sets the event_register
>   target/arm: don't pass env to the sev helper
>   target/arm: simplify wfxt_timer_cb to only trigger cpu_interrupt
>   tests/tcg: import arm wfe test cases for #4670
>   tests/functional: remove @skipSlowTest from quanta_gsj test
>   target/arm: fix bcm2835 migration issue

The WFE fixes are target-arm material -- could you post
them as their own series for review, not mixed in with
these other unrelated changes, please?

thanks
-- PMM

