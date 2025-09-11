Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35871CAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 21:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwohW-0000ti-7O; Thu, 11 Sep 2025 17:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwohR-0000se-EB
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 17:19:25 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwohN-0007lr-Ug
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 17:19:24 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45cb6180b60so8567675e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 14:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757625558; x=1758230358; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XELFhnmhFDDjlMzMRe7ALf4l79l1R20+2bGKsPZiXCQ=;
 b=V6jFjePW13VwPDeOtC/MDs2mAyO9T4CcrJuH/3zsUWbq6wu081k/Iw3QSYM7C6x9c7
 qmbf81gL6A6lOFkQQGpOL1ezDC6o0XCOttwzsbyANSwLt5nWEn94NH/ksox7c+uZA30v
 bnmdvtFYlHUaoSBbA7e8+PsnZlrahpPVz3LIjC+ZfVZy3pQQtUUPaMzHm4qh3ACLozlF
 GE9y5WQD/7WZpZl42teI2Kr+Y8nY+6z3ZONE02naAM4bTYkb9UixntkF4ykBlQqtsmUU
 auIVHjbyGP0gynW6qjx9yIS/61bVVYItQRjw3Zve+EoOYBnbM68znY4eOW3lthQMhib0
 0vGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757625558; x=1758230358;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XELFhnmhFDDjlMzMRe7ALf4l79l1R20+2bGKsPZiXCQ=;
 b=GH6DS9ebCn4QXznajq2sy9NxcnVzexuFHL9aOFc34fv4PywgrwTVmtDXu54ydmlNmZ
 vEJV3sGom0R9iUVmnXX8MPTV0Gxihc7rp8V1fGTTVk6h1NdGkxCT3bd3TQO8KPfpUIKB
 a2hAzti/+D9X/iVsrz4vH7vyhAUqQVDHSXdb/wTVfT4dBNYjfrDZdtDmHir2us9jd5Sf
 iwSiuPT+NpuvEiuDQJQ9XSQjgGaqPyeJAWUijCeVtHWwNn2wTYV/i/i94LQaFT+R9q8Y
 nec4XUu+0kC2YeYo6zAUK214ml5buc6XeAARRxFoSTgUYaupDhrxesKYgKujxFIKNFnA
 Q57A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWbnkDJGAvGlCMldgBNL1qalA/S/hyM7kzPTrDeAjyfrdBnQTUK6i5VJKhcI1FEKwnJoqIeJHpAwX0@nongnu.org
X-Gm-Message-State: AOJu0Yy8neScKB3JTPebjNCctdAU6JBUGAmyKH3c5xxMveoqPVHd/Bpa
 zO5EzoVjMw4ufCNcUo9T48Qzor0D/UPErnLlQc0Zmoim4WqnvxVByQIb
X-Gm-Gg: ASbGnctaptrXToRvwf48VFmhCAddGGHn8VZ4g1utGVk+vSeGPVCdyNSBN2v7s55UVlT
 H+q13dcAfFM4rR7/2ynj5ut/oMEMv+LNo5oh1Hf1YiJv7cyLKdZLSB+4/HmQ/tQnlSK0Qw+hLGA
 OtQMKqJNH/vKKcEdXaldFL7MDpL69vIgbRAE5FY7SdE14G1XJfOnkw8iv7czVR9w4clXAcM2zqw
 N0xfwwpYPAUx5fNnE7Nou/pvBQ/k0XZLMAlTc16QbfKT0L3aLpoUjY/+40pJuSsALdEFffU8WdY
 QNcWCE/CcT/nadml95M6XXNrM8A3d1Xykg2sBI4qHX0aGe3wGAnOTpe0MwtKlKY7Gl3KpVRzHJk
 +MyhMXaiPynf9LUAbJapxCUAsVgSAy3rb/t/rvNnDwG1Nb6wzVgcPEMJ5Xg==
X-Google-Smtp-Source: AGHT+IFaOkEtGDv6RGP4oVdmTnOu6vIkJi5NEFQ2NyCxmAfpV6rOT8UBupb+vWP5FBPEKl39Y/ETnQ==
X-Received: by 2002:a7b:ca5a:0:b0:45d:e0cf:41c9 with SMTP id
 5b1f17b1804b1-45f211f89d6mr5615195e9.22.1757625558253; 
 Thu, 11 Sep 2025 14:19:18 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e037b922csm40361955e9.15.2025.09.11.14.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 14:19:17 -0700 (PDT)
Message-ID: <e30c59563cce0fc8e4935c5b6aba6f85cf8a8288.camel@gmail.com>
Subject: Re: [PATCH v3 0/9] virtio-console: notify about the terminal size
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Szymon Lukasz <noh4hss@gmail.com>, qemu-devel@nongnu.org, 
 lvivier@redhat.com, berrange@redhat.com, amit@kernel.org, mst@redhat.com, 
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Date: Thu, 11 Sep 2025 23:19:15 +0200
In-Reply-To: <a5918eaa2d28d08ff3133dccb06c1966064e5579.camel@gmail.com>
References: <20200629164041.472528-1-noh4hss@gmail.com>
 <3913e8227c343a5d9bfcc2ac1f01d9bd8eceac7a.camel@gmail.com>
 <aMAwL8q0i6pqcAOn@codewreck.org>
 <7eadc2c7030c79923303a5b1b3f2bce0f27ded44.camel@gmail.com>
 <a5918eaa2d28d08ff3133dccb06c1966064e5579.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x332.google.com
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

On Thu, 2025-09-11 at 18:43 +0200, Filip Hejsek wrote:
> > I will try to merge it with the current master again, which should be
> > ready in a short time.
>=20
> Done. You can find an updated version of the patches at
> <https://gitlab.com/filip-hejsek/qemu/-/commits/console-resize>.
> I haven't tested the updated version though. I will maybe do some
> testing and then submit it to the mailing list for review, although if
> anyone else would like to take over then feel free to do so.

I have done some tests and it seems that lines and columns are swapped.
Maybe the implementation in the linux kernel was changed to conform to
the spec?

