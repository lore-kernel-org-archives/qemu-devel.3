Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01F5C88E42
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 05:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4XLV-0004yS-GD; Thu, 10 Sep 2026 01:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4XLT-0004xl-Gd
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 01:29:11 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4XLR-0007mw-VC
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 01:29:11 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a18e24ad25so8612243a12.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 22:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789018147; cv=none;
 d=google.com; s=arc-20260327;
 b=Y76o9UW6Tkov0fPw2lPVMbz6iPgdL8n7Kia18483QOTlJlAs5h12fy1ZZYqWxCFORd
 3vCRgsKB6xIzcRxxQxdH4wL8I97svN3DAw+zqPH9MnnmRgHOUhLWrqpPq7W+2JUo9GSa
 FcclHIB2stdjDQHACWgqNp0suObc0vooFgiTWSHs/mx1Qz6iHNDqZ95MdHtfVbalXFq7
 F3C2ut9zXXjD9NaB31coqAHnO+5MHpYHCtjs3ChmAB+rYc77swpQu+nScNFlqV5yB5T0
 gELsX+UY9FxwTX14Zz/Lw2Y2KLDoBmum7wg0DJRk441AKcxjh250mTo8VwsM/a8qIsD2
 wnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FLDBKKlTK3P/b6Xe07FypOMtFk82I/EeYuB71zKz5vw=;
 fh=/rmRE2pwoF9UqqVKCCEF35FDBeoPK9FXE3SEQmF/qGE=;
 b=crb3vWSSsEV8OKKorXqeO+dyg+mLE2loK357YpHyRdOXvkOB/IrO86RYIC0X/rKmqT
 SN4Fk45DnZKj+YvA7Q2zV3CFckNPwI+KeYpYMgwdGUqehSt1Xo+T1gGaRkAXObvUbzq2
 nn+kHbCg269BWi4hx22mvmTMWMWWiqDfO4Ox+f33YeLPcHZeg/VxS3SOFyAb5wMlx1XC
 YbJNJKoiGegsNMYlMZOQxBQU21MhUX50zHl9nSAF8+6U+iR3SDIRB3MY7umYSlX0L8Xi
 qrxk5y/SHzY/GA68SgzNLCn3QjcnXN+qfFGDCoaXTbAKzAYm2WijGAp9fxc6A+DFcwLx
 QAcg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789018147; x=1789622947; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FLDBKKlTK3P/b6Xe07FypOMtFk82I/EeYuB71zKz5vw=;
 b=MyVFn42gMDVXt3TKlFbS2+Oa6RWy/orReOh80qEa5w01sJSL4pawR/OmGfnGlH+rTV
 8vMXE8OhMh++mWxqMrNNHIMyTSnb8gK0B6CFP43gTTr2WB/2GT6c/1WOR/fPCIMmxH6h
 f319mFqe0iqDE6FMT1sGVkWMBjtY7uSU+Vz6D0LDYSRW6PERGcKRx9w/CD6J2jHLhLz3
 mRVippAKucL5Z7PO7G9X0pl7l4AYpHAe0RI6Koq2TgDuIXMEVbpMVmtqi93dAWUS6OWl
 RZN19U3mqSoGLfsYRn/dRq5gE0Yoi3gQkkKj+L+V2fe7ZWat5clIwTXvmN1gCLYIoDl7
 B+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789018147; x=1789622947;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FLDBKKlTK3P/b6Xe07FypOMtFk82I/EeYuB71zKz5vw=;
 b=laKo5d+gJejpKiLLjYZ+b7e76YCyp149aDBEetIm+r8TifBGPhzNxzlMmHPNBoZBSb
 leC1FiqZMSFE4+2cPEIwaZ64sWL28n5FL+L74Iv3Oi66cQRrv2pt1TSBIi87sfT8jH3x
 WbbCpNnudQiHMG9ioZD3fEbXm40zD5MCnCAUsHsdMv4Q4kL+Vxe1tEBmYQm2dMsKHYJE
 Af1uuXn3FGc1kj0eGz33rnRnyYLDU5iuzEjWyu9elw1W/LtySiLbkBrc0F6vFHX6KpC8
 bouqfVzJTWCfMpmhcAF4Jsb7tFBfPc3kfnXRpy7R5xBnNPfkFGn2ZpMjTQ2STXHrQDa9
 j55w==
X-Gm-Message-State: AFuF++kTCmY9NKmJl7flr0z+gpiHOjtX1h1pXcYadQxP8nQr5DHxflXe
 y0OnWpGJ8OhU5qERhVAUnEswFQs+rmOBzDcBHruJgXe6EPRnCYc4SgAP2paYgw+v4NAbLqFLKIM
 1FWUFKUQV70EIOCys51t3m+y09pGaB3s=
X-Gm-Gg: AYBFou03w2pMfVMjjLs+pX24gZAITlmjAynUR/qwK8A9n1tDPffmTf1E7ZvNZz4Bkzi
 vTU3l1XFl4arcUWXAs8xxctjArVkaMedFmlAy5hW1k/pLj9j7UfbCz3sB9W35wbdaxXcJy10rBG
 aieS3UgYwNiK5bhDCk276zk1sj8GcX443tSdGwC8QbNd2WcFYl8hWBETY7SwgoGAy2a7lnjiPvw
 Td3R3lNf2YX1VmlowH/F2KYeu+xm1KF2M4wkA9uoMp1QswYljPvdrmML3B0sfjUAp7NrKgQLFIY
 AP6DA10JdOH5BhO99Zw0F40rkOgaCNx1MzmpSekCZoo7JXTbWbS9iHVo
X-Received: by 2002:a05:6402:2353:b0:6a9:a2f0:a751 with SMTP id
 4fb4d7f45d1cf-6a9a2f0a9efmr1318514a12.7.1789018147043; Wed, 09 Sep 2026
 22:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260907063725.626685-1-zhangckid@gmail.com>
 <20260907063725.626685-2-zhangckid@gmail.com>
 <5ffaa368-e962-4fed-ac4e-62a8469d9cb2@tls.msk.ru>
In-Reply-To: <5ffaa368-e962-4fed-ac4e-62a8469d9cb2@tls.msk.ru>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 10 Sep 2026 13:28:30 +0800
X-Gm-Features: AcwNN1UbqM3VZZGrhCNfWoQZolDgV82lTD3ftp93MBYnD58-bZ_o55Q_5QEW_NU
Message-ID: <CAK3tnvKuYBi7gMsPCDFQtuVLMVhZ0c4PVQibv=aCgwV4i+5keQ@mail.gmail.com>
Subject: Re: [PATCH V15 01/14] qapi/misc: Fix missed query-iothreads items
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 7, 2026 at 3:24=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> On 9/7/26 09:37, Zhang Chen wrote:
> > The example is incomplete: it misses members @poll-max-ns, @poll-grow,
> > @poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
> > (monitor: add poll-* properties into query-iothreads result) and
> > commit 1793ad0247c (iothread: add aio-max-batch parameter).
> >
> > cc: qemu-stable@nongnu.org
> >
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>
>
> This is not technically a part of "iothread: Support tracking and queryin=
g
> IOThread holder" series, it's a bugfix by its own.  Can we apply this one
> without the rest?  I can do it through the trivial-patches tree but it
> looks like it should go to the qapi tree.

It's OK for me. It looks like the qapi maintainer isn't responding.
Please apply to the trivial-patches tree and I will drop this patch in
next version.

Thanks
Chen

>
> Thanks,
>
> /mjt

