Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F983CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 20:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXmTL-0005fa-Bm; Thu, 11 Jun 2026 16:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wXmTB-0005f1-N2
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 16:57:48 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wXmSz-0004VJ-MH
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 16:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781211441; x=1781816241; i=deller@gmx.de;
 bh=gsM3Tjii6pn1sPUxd49ZswKbdWmkIMGmy6tjSlMHQFU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=l44bf1PzQsc/ddES75V+lvVfFjEgT3ESPp0d9/B76uyyf43fjeKS/XXPtJxvjCy+
 Sewwuu7sDxmA9CerFzKj5mFIDCqKL5aNxAdtAyle9T64D95Ja0n4HFSLClonc7uVG
 rQWURBBi4tZo0+0psWzo7AA/KIvLH9pfJXjdwrfnwpBgCI0o00rsRS68PAh+FC9KK
 Z6MDAiwGOQv4KvRxr5z4RFIOf71rUD1x/VlhZwj4qwr4PsSr2/58h3d55fW0Z7ndc
 mW1vol+5vOXwtbWKm8CfBRa83MSBohGc+OHbLGO7tfdv8synaQJfuNBhJRgUFcKl1
 ujriZvNhTvs6+Enq8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEV3I-1wQcmZ1Kzi-00FMue; Thu, 11
 Jun 2026 22:57:21 +0200
Message-ID: <49c7c9a8-f467-43fa-be24-0795af85d14c@gmx.de>
Date: Thu, 11 Jun 2026 22:57:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: add preadv2/preadv2
To: Dominique Martinet <dominique.martinet@atmark-techno.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260610-preadv2-v1-1-cac1737308bd@atmark-techno.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260610-preadv2-v1-1-cac1737308bd@atmark-techno.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A8fEpehKdBS8DGIWdZdHcYWkONqL4oiuyyI+qtH18NuzR7EhO7E
 7ci6nsj8Df/w1aRxrzdaD4biCx2eADCErDNxn0Jul+84lChZ9FQk+qSDNiJNHcMc6yi8/gz
 /1YF2MFUoemGqs82/mJJWRqbaR1pzesUufKlPfVrzC6W2x8CQhEP4x7+3w0Pgr+S2/Q0Yck
 EV/g3VuwZISSgGIOy0dnQ==
UI-OutboundReport: notjunk:1;M01:P0:D03SU6IsW5A=;CKh/8jSa6/LzYh5DLHl5XnFqnYf
 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
 fPS1EQ==
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 6/10/26 09:54, Dominique Martinet wrote:
> Some programs apparently use these, like the python test suite.
>=20
> The flags argument (rwf_t) is an int, with values shared on all arches
> and does not need translating.
>=20
> This was tested manually with the following python script:
> ```
> import os
> fd =3D os.open('test', os.O_RDWR|os.O_CREAT)
> os.pwritev(fd, [b'test', b'ok'], 0, os.RWF_HIPRI)
> buf =3D [bytearray(3), bytearray(10)]
> os.preadv(fd, buf, 0, os.RWF_HIPRI)
> print(buf[0])
> print(buf[1])
> ```
>=20
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> ---
> (the 80-column checkpatch warning made me wrap a couple of long lines
> I'd find easier to read with 81 columns, so if you prefer I'd be happy
> to resend without wrapping for pwrite2 safe_syscall6() declaration and
> call, but it doesn't matter much either way)
>=20
> Thanks!
> ---
>   linux-user/syscall.c | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)

Reviewed-by: Helge Deller <deller@gmx.de>

I've picked it up into the linux-user git tree as-is.
Thanks!
Helge

