Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0050E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 15:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKfaW-0001Ey-H6; Mon, 09 Dec 2024 10:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tKfaU-0001Ek-Ui
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 10:22:18 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tKfaT-0004Dj-Hk
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 10:22:18 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-51882c83065so282252e0c.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 07:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733757736; x=1734362536; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqrk76ISHUMHFZfaJSNLISUTcBFKFThpXRU0mitByEs=;
 b=DP1VLvZBXTg9fOsRlBlqEcw5I9qUCf3Fmk08WewLhGNfOA1FGjb6R6ofd1hkkfOMqk
 V9FHVheZPn243nQkoDcECFQqjl+KExMfPjJFdvUG9KhuRZtRbCk9TtQ7GFQ8lQzOcB3b
 IJ3LAzLBkDDxEMzWNuNMPcLv4GngERvTVkOlfiUDsUFVjMzwAVVWEKQrj51ga3Nc0HKh
 Fybra4pT4x723ibjWI2k1tSG0sGoaj0Zy8qnJu2eF7HzQwrzhVDPAoN+5uZHfeymD5HX
 zIhrjczQXrUhHWFt8rWsYJJmC4wjLy01p8A1ejtqBuHqgJEZXyNkivxwyFadUAO7yLgQ
 9NBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733757736; x=1734362536;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xqrk76ISHUMHFZfaJSNLISUTcBFKFThpXRU0mitByEs=;
 b=NXYSxjek7b0e64evCTBl2mUqbHnAK4ry9YBTzHz7+D7+EItE9UD7uQ8zqdVmd9naZH
 je486UauynbbmVPOCLn869PVcXCyQd4WPx0MDYurI88N31eB/fyQcFNHViBW2Rdsmw8u
 XritLfQPTtXzYkEknumagBe4oaMLVRPzB0VL64IvCf430on9D3ELvWtNyCgZiHLN5PHp
 VQmCbCqswmVWZBOmJ10675oPpWEForfbkTxVSg8YW/lVrU56DfYuwVlW5crs3C1frT2t
 53Gl9rpOi/ZMcD9Lpi8PuVFTD0sGoiJGEu+UZNm8AvsUL/oMuGrcmI4dqYzCJs30/14R
 2lhg==
X-Gm-Message-State: AOJu0YxI+rhhMZ4T16ogteTC+lB4+ixaaG53SvbW1sB+dLwJ91WP7ugZ
 GI6/w2t6HMJ6krshdzK7kBlFvY72jZ07JZM1joq6h1vVar9ELniNOweDp7oOkXzyitKBaE+b82f
 JJ1kgP5C1ST3B6XbYmvhqY3/DNvE=
X-Gm-Gg: ASbGncvlBlZ2WML5jarRTXdwoE+CgT7iE5N32ESM8IHg07NHrsY2m5vIRK+xnJBiTYF
 SykxEg/FLWVsF6IkiTIU1Kl7e9Dt+Uhqrmw==
X-Google-Smtp-Source: AGHT+IFnc/iqUQSsGVuA47RF/Ysx+7FFrHAJux2Gd2m1aFwTBnbS8wDQ5ZOhWGhPeMsSR4sDchYNT1n5Cmsxr8xau1A=
X-Received: by 2002:a05:6122:885:b0:517:4fca:86df with SMTP id
 71dfb90a1353d-51888360b17mr1352449e0c.6.1733757736358; Mon, 09 Dec 2024
 07:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20241109123208.24281-1-dorjoychy111@gmail.com>
 <71578735-157b-4347-98cb-f899be535809@amazon.com>
In-Reply-To: <71578735-157b-4347-98cb-f899be535809@amazon.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 9 Dec 2024 21:22:26 +0600
Message-ID: <CAFfO_h66hASwGp3CGYcqghLG=5QE24RRdKYPmKx4xKL+wGzeRg@mail.gmail.com>
Subject: Re: [PATCH] device/virtio-nsm: Support string data for extendPCR
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Dec 2, 2024 at 9:37=E2=80=AFPM Alexander Graf <graf@amazon.com> wro=
te:
>
>
> On 09.11.24 13:32, Dorjoy Chowdhury wrote:
> > NSM device in AWS Nitro Enclaves supports extending with both
> > bytestring and string data.
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
>
>
> Reviewed-by: Alexander Graf <graf@amazon.com>
>

cc Paolo. This has been reviewed as well so can be picked up for
merging. Thanks!

Regards,
Dorjoy

