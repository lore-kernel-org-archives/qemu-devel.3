Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B2BC624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Pf6-0003UN-J3; Tue, 01 Sep 2026 10:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x1Pf2-0003TW-T7
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:40:28 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x1Pex-0005ke-0M
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:40:25 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c255acff671so691436866b.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 07:40:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788273619; cv=none;
 d=google.com; s=arc-20260327;
 b=obnSA56zW8yIS1j1yZU9oC8p7xbgXEAFMz11rbp9y0aQc1T7JBq/vI81NvIOeLqzKQ
 YcS7FiMjKH6lpI4RB/+BtBJKxFt37vw20Erbs9MFqyz5zoATezybXULD/8D5zWel4QEe
 /RkA9WN2yTgWvkp5JXuZsKIoyLB85a5XxmQ+Ruu/i+OzfxaPj5nzlkrCJvOo3EqfEgwS
 w7j5+Ztps9HL+asCy++b2FmFhuaSqe4dpTEqOz8LWAWIoYdbvTvJ4h3W1QbnUZoi/cSQ
 OYQIQwEmj/4LZ+x4RDAyIG8tokGdU7af4dypnDSU2liWXy8SqVqeiVsuNk2zN7b1z3gH
 CW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qfqJIJwC+GF0giJFA8RR6zafgzzeMUNjTALFGNc7UE4=;
 fh=wGZeUYt39FdrjiyDvngBMA/6KW8toEkLMWKs7FzaIuY=;
 b=Urp9f7TfEkS5pgSj+vZWXGAwKDWdpeaVO+FBdhRr+0plaiKoIwG0f6soPYgFefwjBX
 RNTOq38Flvh9szyGahauvci+vjZJbsDcA5X9gJkhyD/nGwgUa36zZJch6Hwzj7JfEZup
 uhseLkFj7y8Zy+ilV+db7/Mhx5ICqHlHixSZQWCwd2pv6DvpQmRUFMtQcjDfoejZqcYh
 LzGuwC8zwiL44YsYxEM+o1X7PE+aoId5zphVTFV9ki8o0DnV5FOFS9/Ve0EH3HTc3Gv+
 ln/lcygpXbigDBmLqaxWiNjANtfhyoTTwVv1Th4RChIFY3qySgnusc+QPRe7BDtHiBZ/
 JZqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788273619; x=1788878419; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qfqJIJwC+GF0giJFA8RR6zafgzzeMUNjTALFGNc7UE4=;
 b=J/GfWG8PTUtWDRqnLmOAg6OJkwPJPCyxdoQPODdrf6irRdgzc7zm8S1Hd4iR7HcCBM
 P2VA3YZfCuRversAIwkbBk3j38+8rNBjICeGsFYXH6Ujz7k38FWq4VUrkHv2auW8sB0v
 qAF5WS3zCxCCDfRwePPgDP+m2rAHBdrhO6L7216A+wkGQmhU07T1nuCF4IFl9LkPzuZy
 bnMRFeHAQTSEK//i2DDgH16mM0w6/54t6db0hxzIxQdgdS6o6jNYrVN3eWlrxvPWKVAh
 pj9fYSlVz+SVxsecg6MCVvZJF/OksVvqmRPACsjOvktF1pE+GpcJ3dHfoQgsQfQjN2gh
 Ejhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273619; x=1788878419;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qfqJIJwC+GF0giJFA8RR6zafgzzeMUNjTALFGNc7UE4=;
 b=goAm64xrIWvmLVjqzcqkioKs6Jl5l8Zg32C5y+7rGtH+6ccn6JZ3j2QaQHvZeSDqT3
 SQsQmPievnDLMtbM+Q5ywh7Mg6h/HwFIVyJ1W97DwfRWeTDpvLXtDLM6OYPZxB/4vnek
 GaUOyRHmm74XyT69qHQxrdFzDvOEDNVBkYZ+ylOIIePI0RVJ0VCfSr5TjIBlWO0c5ZbY
 rmHwL3aPNn3+/2IEIXPIEAtGH7ttWr3x3KPIHREZIwzyNEzPyIudUbUDlYl2LwkzSjjP
 6TZBgI24aak1Mcz1ihHc4w7TlFglAaD/48jTnU23p5G9LMe0+ZRSdAKCRqE1cEPSSv8f
 NabQ==
X-Gm-Message-State: AFuF++lRkQDrz8klNdNQA2KUW77FD+7fJL9D6aZfIz2ynoFiaJ8uJ3fX
 6IU823B3gD2849oIslV48rL4cc3Zychugwcm2t1XKnP+PZ5xrLD1R+cNrMcbVeFU05KIxKBF1VP
 XwD6BjyHEA9WA2TC7IPrJO5pmPLDVBzA=
X-Gm-Gg: AR+sD13t+aEz6Ru/A5V4DtvNDiagJRokrk55k82Rsk2MtmOcdf7aLNP2ESZzbFu6xGp
 d9bntGC8HU8z2Ke50rZYMsH2jeexZBPVUg+O4g9IzFlgbu2PZ8uPDUaG1T4ixkVArKrn97bO65B
 NnmQCwKcCd8Iml+dz2GnsgmfRy0YpDGQ3DHdymXQop1L/Mi14i8Bx7ynHnl1T+lxJu3UerCblFk
 jp6tCJbR+/Id/3Ts5IsUHDbGw2CkPuZasiSRhrtTV1T8oV7/fiby+RTXKmG7Bl9AV8ftkZQedBc
 SLB2YcZCeSq0jrNow+iVhqOnFTT+7eodWOFEwFDlLYbQ3w==
X-Received: by 2002:a17:907:c08c:b0:c1c:3b06:ed03 with SMTP id
 a640c23a62f3a-c2557423bfemr2400919566b.23.1788273619036; Tue, 01 Sep 2026
 07:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260831160038.221776-1-zhangckid@gmail.com>
 <20260831160038.221776-5-zhangckid@gmail.com>
 <87bjahbksk.fsf@pond.sub.org>
In-Reply-To: <87bjahbksk.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 1 Sep 2026 22:39:42 +0800
X-Gm-Features: AcwNN1XC-IrL7Cetvp_Ft6jJmZmxKt09SIHbPQHfmlGW_uC4rvsafGsh2Fho7JA
Message-ID: <CAK3tnvKE14GhTcmQ5UPgQSCAvJhR8e=_F=ehukd4Mv9wXFuzrQ@mail.gmail.com>
Subject: Re: [PATCH V14 04/15] iothread: introduce
 iothread_unsafe_get_aio_context()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x629.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 1, 2026 at 1:30=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Add an explicitly unsafe accessor for legacy callers that cannot
> > provide a matching holder lifecycle, and convert blockdev.c to use it.
>
> Why is blockdev.c unable to "provide a matching holder lifecycle"?

x-blockdev-set-iothread only retains the AioContext in the block graph.
It does not retain the corresponding IOThread, and the eventual context
detach or block-node destruction happens outside this command. Therefore
there is no point in this call site where a matching put can be issued.
Supporting that properly would require adding IOThread ownership to the
block graph context lifecycle (and likely a block-node holder kind).

The unsafe accessor only makes the command's existing lifetime assumption
explicit; it does not make that lifetime safe. I will reword the commit
message accordingly in the new version of the patch 14.

>
> > Keep iothread_get_aio_context() temporarily so that later caller
> > conversions remain independently buildable. It will be removed after
> > all production callers have migrated.
>
> Which callers aren't "production callers"?

I meant the standalone IOThread implementation to the patch 14.

Thanks
Chen

>
> > New code should use iothread_ref_and_get_aio_context().
> >
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>

