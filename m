Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A478606A32D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NH70zuxM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPJLR-0004UB-Mp; Fri, 06 Nov 2026 07:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1xPJL9-0004Tm-Lu
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:46:44 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1xPJL8-00025W-5F
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:46:43 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b547d6c07bso597416a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 04:46:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793969200; cv=none;
 d=google.com; s=arc-20260327;
 b=k/tmOWWgW09USmoS66C+LDpIkvvfENSs43BLd87O+vTwNEru5kg+H3Rrm3b9LVFxp4
 INhupxEIwI9Qcm9p+N9+XECud/k7r3KWr6i18yR97ikILM8nkgj68DezNt7AzAqE3iiq
 7vzSszGt0x55uOCNwG5MR6qGE0gwAXJ03mr26oww/dOtPVPkgaWmF2kflkLohlsN0sud
 in1pbxYmOSVVpPREwwDa+YNkYmj/nkOk9w92X0O9OKqVqtVCJJOrfqgD0a2FqObFEr8p
 xIMDzZjt+UDfaG6j2vWsQNzzdFZuqPvzJfwA0ekVT1AJsxWRkMhl0wM4a6+qPKDiodzX
 zrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Q2P9nvlhoQZ1sFoJgJTpZlVtUW0S9yeOMsNsiOmJZAI=;
 fh=3GxZEhEiZHrMGCV6zoe/Vh3loMDux5sYAANSfyKLYBY=;
 b=sCTHHmbriK+P1w2SRdRY3/7FZbDBCGWR8MDfgwpnyNkzkjEiMb2iAFoNgJ7C2nMmzm
 fwlPZ0QrUGqzZdTurdA45iwAn8nPpnH1F2GdNJSPVLeb5l8QIBaxti+cPSyQO07VAT5p
 tX1OTaZhhimWn6F0wvuPw1ilETngaxLGyWBixg91b1r9tj8Fv1X+NjFFN/771h7O2IHT
 TRJ+pUJeDdJbOPUvgdipGi/uOT07bpwHeQSqLGWOMw8Ho9tuXPrFii9LFVV64CkQB+sR
 1T3AYtPUwY3at9zZ7ojayF9OEMR1VHebrH9AFy2iEfpt+MnCt2wzsQfmoReFWdWxfqD4
 vmkQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793969200; x=1794574000; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q2P9nvlhoQZ1sFoJgJTpZlVtUW0S9yeOMsNsiOmJZAI=;
 b=NH70zuxMA/XZdBuOMaoMXbIzc7O+c2Ekq2wnXMu8pNEO0xmyrUhcRxXfy2gK7DKsge
 6XvXvbfvFLnoBikf6qGAMx5TKz1hdGKgbrGm/Hk3DjfXp8vCvE1CC1sARt1+q6LBN5qR
 OSnMXTrNfcC8PyzspDkMZfWhAaWy0ceDepjBOHVQ+e2cPzNma0yMBZVnFimuwoCtQtwz
 tx7/KdXP2KWbT+Oite82aA5a5jQd9fH+s/BSPiDUQ8/iBCeOeC5M1F2LHYf3sSBr1UoT
 dSGPnDA38EzyW1WqCJO7xZrpjepyazb3bF5StUtegCKgBjqtP1FeDS2CeoBB9I8bUEYX
 PugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793969200; x=1794574000;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q2P9nvlhoQZ1sFoJgJTpZlVtUW0S9yeOMsNsiOmJZAI=;
 b=DyC9G3AYlTye0TW3d4U4M942RlfRCyXunvn/9UnY/KIvqktJMY+UGB7k+rkpxOgW0y
 DiBOun8I8k6Rv3CJT3/CPIJoeE0qwYcmwtE7poE0tES+O4J5O8cbyXwHDpcTdboJDl5D
 Ck8HgP6ADk7OFjTnRi8ACpLg3fRYIdoMBdju1E28pxxfCATN+3g6Qqm8qwD0ByzIt26/
 QI6+TKKuo+VRx5wwIRKZjLL/lRX4+VQS8o+aur1mLB85t+CUIgQ/JKBRrx06laDCcYOi
 cuIJwn5ubblNnHbx1iyJTExNvP7IqO7JtZcuMHrnvh1/aZY+/R1luhcjIM0STFg7czht
 yEWg==
X-Gm-Message-State: APuU4Z8/BhwPLEh4u6tgd+uMNDq3DxQAcmfSfCdRqsaUms+Xg0IRwEI4
 2qdB5GWs3IrF7vjMNYWiP+zxHzRZLYOWq7Kp1FHRONoXi2Ebt2i5skHP0KBXG64q4yHli2YKhSw
 ZaT/umo2W3O1BL+Dh8mJeMIc9ND1wTb0=
X-Gm-Gg: AYBFou0WeFTcgjjcd7A0awmoTCNJPaxlg9E62crhfWxzBbWhRCx5CslS1Mb487SwCoW
 X7ObYzXww3HTkm8iTeQPGLqllyNElUXoOC3mLJJrj8noWfAj+23DToJPXxoJFqtPrjGn5fF6lQy
 ibMgx4YbCA/cTd3DVwP68J0W6+O+zoRlfZOPAh8tGytyi+O1trxV74ohJZe8QtIUefWRgCaxBXa
 9l0MsorE1qDvYxciZP89nczzIdTLmHDscfNijuEBbms0pJmnaXpQ6t7tuV9HeVPvYWjAx98IUzm
 /PDXKiO20zIWP1KRbKtjt8ymZ0bdR4ljzpaf9QxOrNLZ1/G9CxYlT4jibj9QkFLnftTivv7tbsU
 nVltf2mrzdgPjAGgCIbiDgJKokqmWkUoSEvYX3HyeKXrR0m208MEyr8TfDQX6F6/vS/4YCA==
X-Received: by 2002:a05:6402:158d:b0:6ac:72dc:c3c5 with SMTP id
 4fb4d7f45d1cf-6b59780da62mr1602890a12.30.1793969200269; Fri, 06 Nov 2026
 04:46:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAJSP0QXzingvqA1F2q-QH9GvtMz7YpxDK9RsDEF5JMCE6vA+Hg@mail.gmail.com>
 <au2X5ky4RKMe1gPw@redhat.com>
In-Reply-To: <au2X5ky4RKMe1gPw@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 6 Nov 2026 07:46:28 -0500
X-Gm-Features: AclHuK9LfAfHI3xk9yWRHnkBCc7bDKPXvzx6xrNEQX6Dd5liCf5XANATVmVaZaE
Message-ID: <CAJSP0QWZMFspQwp6sAXf+E38cEOQxtjECkKTwrqQFApRuYTSyQ@mail.gmail.com>
Subject: Re: Pierrick is maintaining the AWS GitLab runners
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 4:03=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Thu, Nov 05, 2026 at 04:04:14PM -0500, Stefan Hajnoczi wrote:
> > Hi,
> > Pierrick has volunteered to maintain the AWS GitLab runners that
> > QEMU's CI depends on for x86_64 jobs. I have given him access and
> > updated https://wiki.qemu.org/AdminContacts to reflect this.
> >
> > Thanks, Pierrick, for helping with this!
> >
> > I'll continue to handle the yearly Amazon sponsorship applications.
>
> Do we have a fixed quota cap for our AWS usage, and if so, are we
> at all close to that level with our current CI workload ?

QEMU requests a yearly allowance of $7,000. At the current usage rate
we have about 15% spare in case of spikes.

I will gather more detailed data and share it at QEMU Summit next week
and it will be sent out in the notes email afterwards.

Stefan

