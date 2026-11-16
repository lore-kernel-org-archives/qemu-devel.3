Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96108606A32A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JyW7+dEi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSt3q-0004Ug-SV; Mon, 16 Nov 2026 04:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xSt3H-0004SO-Mb
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 04:31:29 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xSt3F-0001Dq-MI
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 04:31:03 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso17522555e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 01:31:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794821459; cv=none;
 d=google.com; s=arc-20260327;
 b=SZfNq6S9+BR3cSV8iR2P3gDfq2LM1AjM7TOFslgTDuTF4QmvFuGnPLNnA8WseTdsHw
 C3efM+cQXV/ogBMbXuo17Aq0ZJNircxTOEPUXBOK5ZQORpctUQt36ZvkAuyW/kMaXJPa
 +8mUui5pV3U/xEU4NTNWbfFpueRd8/Ev2TSBFK3wrfl/MNmtimak9G2v/D3DH579YzgY
 XJVayrjHL56AJQ90WoVxM6k50sULbZEInlx3HbXdK1RZ2NagulHdVWNKXO1tjuHwS5Xl
 3gfdyC3QCF8nblfdldpk56UUuK16ewxKep7SpqumH1S55wVgf9wu7ee0Z705+FKvS3cW
 wuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Dbd43gDZLKOctg5OrfA/AcKcmZ+irjOSIdbH5JwaAlo=;
 fh=egrluJs177jJ7jVdGrIOi1IFJuy9RDFSWx+5SnqaTos=;
 b=p65844zptfen5vgnGACC0RCBPscti02v2OHTsRDRsLOot+wLv/ushVZAJiwHPusXX0
 HxdcRTJ5xgmysD6BCF5WR2QAfrrqj8BSVTRzpmW0KU7pX5R9+H5h/kl0U6OQFlmwHsYr
 umAdr5akuU59yMuAXN+cz8MFB2m5bo/UCVTwk52g/YPYlOpREAMoINZSZLkjOv29308Q
 EgkMv74C334FawZg7UFGxY6R4NpjS6A86lR59/JNA72LrLiItUN0Oum4dP+PCGIJ2LdE
 ntLgchwpW4vANPCfe3OnReB0DBFK7DqpLpGZrAqgDUFy1w2XKQ5iglLCUaKgCN1hDbH5
 szEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794821459; x=1795426259; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dbd43gDZLKOctg5OrfA/AcKcmZ+irjOSIdbH5JwaAlo=;
 b=JyW7+dEiKJOcfNz6g1YJbErerzARh2OMrN/A6llUFHxuEMJ7eds9pjPLYQTmWC2RLs
 93Nbj1jnt+U4AufRt1L2NPoN0WiwsDC9bi7CH2PS+bLLuQaPPTCZscT/kjAFaXwqpkUC
 Qf2mXiyG+hcKHA/ypUna2mjc9DvtARgDjUZUCwpQVNDAoIR+ei9BofdcZaJ8sAu41wvr
 83Acv3MCtMYjAWjFkm+ndooapiB0Fu+dvl40+jtkmNE3ChYlB5hyrFhi99XG4ybabO40
 BN/VOZvR9f6WGgM2hkQFhsWmng7oVZxuzYgEUpW+hI6LR/8A9z7SJ/pTEjXXwOjbNsnz
 UuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794821459; x=1795426259;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dbd43gDZLKOctg5OrfA/AcKcmZ+irjOSIdbH5JwaAlo=;
 b=FnKP/+/DxtQo59zPabMFqq+JcqWPKJPxWEUdOSN3ptdi8l1KnXCWLuAY83ZktO9+rJ
 +wLxCvF/1m6jrfEKYp8ktQ5/HITYBMgbLSj77hG6wYaCT2gU0ECuSrD0HMQ3W974RqPE
 GKT9rNdK4B0I4rn3hiciugjh+kTETcvL0OzoLTUpRZNee/RliC9eHXpVzDRR5vzgNgXW
 R0wcdqgM5nw5N6o47daKrhDJsn86CDlwVGQGQM80tzNLPiAmAZw4kcTySTCV4lwz67bh
 BJfBkMGuoLntgusMRrn10vlg8BK2Bz5cYE2HahjcRGLo0miSlMB185GqTlGpdz6QKcOT
 WMTA==
X-Gm-Message-State: APuU4Z822bat+Q3ucm8+eDG6vtJqgD+b6cVNH4mgHWLJ+PLgE0IGZcc+
 y9IpsvbVOmj9j3T6Y6uZXzag34pwO7AubMWlRC2cLIA1mtikRrueWoGsI9UhD+VCfXwjIfRfNUF
 VcmnH81YhyKHlBP9POWkbGZUUYb601Re4gMwhekTTyw==
X-Gm-Gg: AYBFou0FbV/AMG+ymawJnmgHrUoAC413avVu2lfcVIReEFGnlDeyvWzyKdoH6HPlU6f
 frC9gu6+7w6wtVXa7mJ/tDzNACgaYt9fMf1uvIOId7rYZs4vCUb5eDF+1pWRe2FABHQqrFZL+T+
 /CJTqtb5/X8aGaPoQtVeMKF1QVnOL02BeTTvp/1BAt44WMO1pBPkdvO3nOiX8lYgHzfypZ6F21O
 wJfELRttMwtg23Q6l7R1jFcw7L9xVaXNxljZXCbKGWU6lu5gxFmlQ/0XL4n1+/9dMihGi69vacK
 nbEDona06of0w+R6XkWhCDIFdHYk7VElIHoj6vv2JvV7dDo7FL9sDyr+lnqpOVMbUtOSUvljPy8
 Q9jKR5XtnbCEcnbHfWbK3/NleepE5ZdoyeHxugeIrM6FNADS5hY/jxV+/UZnCk9KX5hS/ADtiRy
 XPP6rrEKxBeUlk1PVjDj5nMmHHKBQa00eYmbWIcEE4x8dvpT3TJr5RC1wBfYoHe90BWqw/eUCof
 7sVIvy3mrnWZ3yJ0w==
X-Received: by 2002:a05:600c:c4a3:b0:4a1:9663:7639 with SMTP id
 5b1f17b1804b1-4bb55ab5526mr217570475e9.34.1794821459112; Mon, 16 Nov 2026
 01:30:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
 <de3cf993-74de-4710-8b5d-eacfb96a5a97@tls.msk.ru>
In-Reply-To: <de3cf993-74de-4710-8b5d-eacfb96a5a97@tls.msk.ru>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 16 Nov 2026 11:30:32 +0200
X-Gm-Features: Aa3M54rZdEThN_JenvtnjePlCXThoGgKjwtJdT5Oq23VEY4oFPDVDosHMaMtvTM
Message-ID: <CAAjaMXas-YpBPwQmnTuAMteG+UMFQ+EaCbZhLwMMfkNo1P2r3g@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Various virtio-snd fixes again
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 5:38=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 11/10/26 15:39, Manos Pitsidianakis wrote:
> > Some various virtio sound fixes.
> >
> > ---
> > Changes in v2:
> > - Moved fixup hunk to the patch it was meant to fixup
> > - Link to v1: https://lore.kernel.org/qemu-devel/20261110-virtio-snd-fi=
xes-v1-0-544d6f9eca38@linaro.org
> >
> > To: qemu-devel@nongnu.org
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> >
> > ---
> > Manos Pitsidianakis (6):
> >        virtio-snd: convert virtio_error to error_report
> >        virtio-snd: add pcm_state_to_str()
> >        virtio-snd: reject invalid feats in set_pcm_params
> >        virtio-snd: don't allocate pcm_info zero-count buf
> >        virtio-snd: cap maximum buffer_bytes to half a GiB
> >        virtio-snd: period_bytes divides buffer_bytes
> >
> >   hw/audio/virtio-snd.c | 91 ++++++++++++++++++++++++++++++++++++++++++=
++-------
> >   1 file changed, 80 insertions(+), 11 deletions(-)
> Should we pick something to the stable series perhaps?
> Dunno how widely virtio-snd is used, though..
>

Hi Michael, I don't think they are worth the trouble, half are fringe
cases and the other half depend on stuff that aren't in stable so the
patches might have trouble applying.

> Thanks,
>
> /mjt

