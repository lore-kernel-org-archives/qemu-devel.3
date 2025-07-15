Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0169C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 08:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbKN-0001CY-2O; Tue, 15 Jul 2025 04:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubbKK-0001B6-Ip
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:47:53 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubbKI-0006rb-Eu
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:47:52 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e8b3cc12dceso3780773276.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 01:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752569266; x=1753174066; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NDWYp5uRg36j1j6M2yx12ZB0rnu5OtewTjypYGmZ0D8=;
 b=HpBEwtgjMLBm+eFSJPzdeR6eaLaMQcwxM0YtJCTz9aHNVuBlHHpXdmOWWlHVj+wTFf
 x4kUQp2UaBt+95zbkpqd+w+AQ/LsF7kVXWNKKBacA+3bjdq+T/F5pdLUrmbtrZwpb4bS
 2I43tOf/slH+6BwUN0fkO3cfbjSWbQS/B0BMDOlQMIEivWwczIS/NSNRUAaOZckmcwev
 7BlJmRqeKW5Io8qMBtl8aokU9CWm9aaYfGPCDbKQVmpEjTta7T4yW+oAyEmyHVmEPDRJ
 R5LvWaUd9nIRvr3ViwpI4Afhi2Iduvv44SPTcO/a1e/QDYym3Va550v9+GCFBq23goi3
 QJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752569266; x=1753174066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NDWYp5uRg36j1j6M2yx12ZB0rnu5OtewTjypYGmZ0D8=;
 b=RIM+Ai5A7d5Isi8MqG35tW2hEQ6/jucx6kXoK7jKAy8m/CB02HSaZsd5UqUmkKir1j
 vo9KmdStzoc5t0oX1wjX/+th9nXQpwvECRaSKFBxy7jE+7NiMVPuQol5iu4Yi2ebNDqB
 kiPkPF9Pb7VDhZyM4Mos3ds5KlYDFVjseclg6/rhuOwEOUNZ0+WqdLtA2MG31p21TILl
 YCiHG50FuivJtya1mhlC3jbIoljdrL5AohX5P39m7yhMOfZUBy/uKRWEHP3kmfgszhNs
 VNOROaRaq1pKN7qmRwjXfyzlDrQ1KAwGeLAvNrhdbrZYrn3IPR48Wbcd8Vnb9M5zcOpA
 bscg==
X-Gm-Message-State: AOJu0YyoxtjxVoK7FfxDpzi4Tp9xj1J2MxAjU5c6Xhwa2HvZY8oPnU4R
 4WjyW/0Wxk4cgYsGUuc9d3JeUR1SyUrP2vGCku13CK5PYM75Q0DvbmdPMVi9ISSi0aag+MojL3D
 UhDkWtCCDgBc8jiIilxdlwnRQjQrcsEWw9jMyzBWhkg==
X-Gm-Gg: ASbGncscTof6YJkRARScOjjP6S2qYsxOkwGdY5gKTadURIyn/WMq+fOTXt+jCvI3B7F
 8Wl4aJnHs871ES5z+V826GNWfM7cUTztcrGrlWRRwtIcoHQSXNeDUAkpEPqtHo2ukm7ncPGI1iA
 grpokTA57sqDpQk1tkKGnuhQYun01QUQp8zMh7HkmE+YCEvrFgXf3s+hcCkRF8GMdVwMSxL8ous
 am2gNyphQttc2qPZ70=
X-Google-Smtp-Source: AGHT+IG517GdFCBsr/+jYHaQ09bjyZVkffBBlluALAgfrxZIZIBXw2a11k2TdSCIaXhbB+3t9Kfd4QTHIsdkX+xenBQ=
X-Received: by 2002:a05:690c:6e88:b0:70e:7ae4:5a3e with SMTP id
 00721157ae682-717d78b2f33mr259435737b3.11.1752569266441; Tue, 15 Jul 2025
 01:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250715000045.57332-1-jcksn@duck.com>
In-Reply-To: <20250715000045.57332-1-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Jul 2025 09:47:35 +0100
X-Gm-Features: Ac12FXzr0IfTgiCuVk0EiFV6xVrK4e3kGDXup_g5WLVmtDNIuQ_0Ib7fANYTIzo
Message-ID: <CAFEAcA8gTeUs=ykj9rXAyopzfYyksA1DqEC9miZgs=TGi4jMkw@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] MAX78000FTHR Implementation
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Tue, 15 Jul 2025 at 01:00, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> v5:
>
> > > +    AES_KEY key;
> > > +    if ((s->ctrl & TYPE) == 0) {
> > > +        AES_set_encrypt_key(keydata, keylen, &key);
> > > +        AES_set_decrypt_key(keydata, keylen, &s->internal_key);
> > > +        AES_encrypt(s->data, s->result, &key);
> > Here we call AES_set_encrypt_key() and AES_set_decrypt_key()
> > before calling AES_encrypt()...
>
> > > +        s->result_index = 16;
> > > +    } else if ((s->ctrl & TYPE) == 1 << 8) {
> > > +        AES_set_decrypt_key(keydata, keylen, &key);
> > > +        AES_set_decrypt_key(keydata, keylen, &s->internal_key);
> > > +        AES_decrypt(s->data, s->result, &key);
> >
> > ...here we call AES_set_decrypt_key() twice before
> > calling AES_decrypt(). This looks a bit odd: should we either
> > (a) call both AES_set_decrypt_key() and AES_set_encrypt_key()
> > in each half of the if(), or (b) call AES_set_encyrypt_key()
> > twice in the AES_encrypt() code path ?
> >
> > (Coverity is sometimes wrong, as it's only using a heuristic
> > here, so the other option is "the code as written is correct",
> > but in that case a comment might be helpful for human readers.)
>
> > thanks
> > -- PMM
>
> The AES engine stores an internal key which it uses only for decryption
> when in the last TYPE. This results in the odd-looking call pairs.
> I've added the requested comment.

Your patches are already upstream, so rather than sending
a new version of the whole series, please rebase on
current head-of-git and just send a patch that adds the comment.

thnaks
-- PMM

