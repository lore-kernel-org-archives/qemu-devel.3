Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5AECCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 17:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8j0I-0006uY-GQ; Tue, 14 Oct 2025 13:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1v8j09-0006oX-Vu
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1v8j04-00026n-0a
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760463588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hliqD4dhEXXuu2qUMeAR2zqCexonK+0uACESUm65DsI=;
 b=eCxQQwowTyY34SaYeAoYMf6q6gzTYlA2PZzUbRsaINjwEQZd7DEU4Jh7Tf7Ejg5p1UZPsB
 Fmc+Ob9RSouZ+nIQqHqOdfR5aHzidkb42fBIwr/JaIyH69hSTzwvz0JlHfO/K4YZtGoWn2
 9lR4W/BKRW1Jius9NEtMiTms7oE3KDQ=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-DBq8GgovNbmXE7ASg3AUVg-1; Tue, 14 Oct 2025 13:39:46 -0400
X-MC-Unique: DBq8GgovNbmXE7ASg3AUVg-1
X-Mimecast-MFC-AGG-ID: DBq8GgovNbmXE7ASg3AUVg_1760463586
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-63d241c46f0so1094377d50.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 10:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760463586; x=1761068386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hliqD4dhEXXuu2qUMeAR2zqCexonK+0uACESUm65DsI=;
 b=D6AzWNMD0M69leyoOcXjN1LHB5QQb/S53ZABEDz4zB//M8Z/Q230COnWIw9LpFYqNP
 ed4I6rIc6I7KOP1aXfklqXduP/q6yHBeHiBxnupEtWB4rk1v4wvB1del9GwMmYbKc7Fi
 J8c4MlUobWnaIScBmz290Q/IgUVmt62IqgWZNMehx3JnVj53d9kiPtSu/a5hU1AryBoM
 128Buw8U2gmkUn0y/jhqX8NPxkd5kZ2QnLWLBUhb2hz4Ronw8AIWUlJgyzElefWFQ5fu
 ENysgJqwIgxo/W0/VES+8irlGkk7UzBrqa0vDtQiFMTuIp5V5/jAQXDedOGJEpvvyFLR
 S/Bw==
X-Gm-Message-State: AOJu0YzrM0FPBii+4MqqCBdEtA08aKmCCNxsioVm4257DgGkkLkgxT3f
 C8ZO+XNHt4DGSWBzZNvkYYCHPc6soAcoBKHjBhW3x9WAKVb8kv9o+4P88kv2fGB2txadHZgofdb
 wLVBn3uq6M1RkivqWwcqcbaQVXORQL03Umu8utSPsGRkexZ9D1A/Z+T8+Y681712ud1VlZmp9E8
 I26OTg0OseaUue50ZVLliSF/DZGcr8D/s=
X-Gm-Gg: ASbGncsIPbvEfN1ZbvqXMGT1f10KsvKEtaVwM8MGRYkAM6uvq2YfYjYJJCYZuqT1DNx
 +s1Jk/CQIoYnuX+p1AIf4B3vGDU/Ym8KOS7/2gYRfHPXKRbq4yEq6JxLt6tPfVN7oAXya04Mrb2
 HyL0hrXY1o1eoSlps0+EKCVGkduSAFIqpv9vCsZ2iEFpR7fgyebVSc
X-Received: by 2002:a53:ec89:0:b0:629:9c6b:b3ab with SMTP id
 956f58d0204a3-63ccb825baamr16549526d50.1.1760463586123; 
 Tue, 14 Oct 2025 10:39:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvAZ3TlJumy+HFWgsNOzSn4+V/UatjmfATj0mAydNOUQQ5gO7+6JntTIRiCg6EuCyAe6kiiR8/Lb3wDRPMcBQ=
X-Received: by 2002:a53:ec89:0:b0:629:9c6b:b3ab with SMTP id
 956f58d0204a3-63ccb825baamr16549519d50.1.1760463585757; Tue, 14 Oct 2025
 10:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20251002020432.54443-1-gustavo.romero@linaro.org>
 <20251002020432.54443-3-gustavo.romero@linaro.org>
In-Reply-To: <20251002020432.54443-3-gustavo.romero@linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 14 Oct 2025 13:39:34 -0400
X-Gm-Features: AS18NWCaWYZ4L6ElMmgO0jciDGRjpiOivPXm_Z1wMeZuFPvn8Yi1E1Fdm7RRPXY
Message-ID: <CAFn=p-bscu00jtyfm+SmeYqB7gt6eA+F8uuYb8ng6rTe_a=HTA@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] python: Install pygdbmi in meson's venv
To: Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com, 
 berrange@redhat.com, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Oct 1, 2025 at 10:09=E2=80=AFPM Gustavo Romero
<gustavo.romero@linaro.org> wrote:
>
> The upcoming changes in the reverse_debugging functional test to remove
> Avocado as a dependency will require pygdbmi for interacting with GDB,
> so install it in meson's venv (located in the build dir's pyvenv/).
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  pythondeps.toml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/pythondeps.toml b/pythondeps.toml
> index 16fb2a989c..98e99e7900 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -33,3 +33,4 @@ sphinx_rtd_theme =3D { accepted =3D ">=3D0.5", installe=
d =3D "1.2.2" }
>
>  [testdeps]
>  qemu.qmp =3D { accepted =3D ">=3D0.0.3", installed =3D "0.0.3" }
> +pygdbmi =3D { accepted =3D ">=3D0.11.0.0", installed =3D "0.11.0.0" }
> --
> 2.34.1
>

Do we need to vendor pygdbmi? Currently, mkvenv does not consult
online sources and so if this package is missing, pulling in testdeps
will fail.

We can either:

(1) vendor pygdbmi, or
(2) change mkvenv arguments for the testdeps group specifically to
allow it to download missing deps.

--js


