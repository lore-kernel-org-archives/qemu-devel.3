Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DF5606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OOu7G7KK;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fKsCQig0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJUeP-0004Ps-R0; Wed, 21 Oct 2026 07:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xJUeL-0004Ol-3D
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 07:38:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xJUeI-0002FO-5L
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 07:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792582704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VzfXTr0RAtPFYGhZOMc8E9mJynG/oxo4Z7d2pMzPcF0=;
 b=OOu7G7KK1Cmbk/m1nSF6S62n2qLp39hqcBPLfneRsPbneV9tpw9xEIi/S2pN3+2A/pZb2R
 jf8xTvI8W1HL/GwkNWSfcyasEe3myWDjZMTfBbooVxgB49E7Kd6v/I+bFf2ES7EVLlOOZY
 kHI6qAFHCJIfVM5kG9ELV99xMdO5M2w=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-lTbgkOL_MI22_IYLQ7rkBQ-1; Wed, 21 Oct 2026 11:38:23 +0000
X-MC-Unique: lTbgkOL_MI22_IYLQ7rkBQ-1
X-Mimecast-MFC-AGG-ID: lTbgkOL_MI22_IYLQ7rkBQ_1792582702
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ad704d4760so686779a91.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 04:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792582702; cv=none;
 d=google.com; s=arc-20260327;
 b=H0Av31qPikCsoehRXLUCFmb2LoWNXk1x9xEUbfFiS/zNa+iECFKtFuSVk4bZk/IoYG
 plYEZBHh5v1KRgNevwQv7LM6qTBBtx65iozSZoM9wRJSDavYqRmrYRSIa+iF6ElUq3J7
 98y1XM6ZJAOLXDHoIS8w1peWt2Bxf9+Qg0Dpb86lnCL4vjLueHHWv2JEmN/eg3/qLiUA
 agOyO54f3NCunzj64QaiJjOUBJd/jfI/5K/RTTDd3clX0orPty2UEQW5zIEyYKwDSDrG
 obtc3rfxxkSKOofpxnYrb+Xj8L6v5hm60Dx1JYXYLf8fLbsAT8QobEIvC+Gh89VIpN8u
 n5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VzfXTr0RAtPFYGhZOMc8E9mJynG/oxo4Z7d2pMzPcF0=;
 fh=HmFuZtnegahfpmvtAXSnyK1gdqcvbKBAeKI38w9VFHc=;
 b=RcVb38SH9PRHHDdaH+cREZzPmrwMGxP9scwDPUwL3T4plJigLbi4XXIQHycR58VKfS
 ObemS+uFHtEQ5AxR2XtI3qbWQEp09GJsYc25u5yI0UtdOwMR5Bc4wcty4xWJBQlM+JOj
 WeuCX+tZp792faB8Ei0hr6lRACKdvquWLYTtvWsawlf9z64rCh7l9kk/vpveEMdLOII8
 xoOzIAesMF59x6PmGjHjJcGgyEnqnV0BDWqEjyVIOla9ApvYL4h5mG7CcDrYcldFfOsP
 p2cFvPeZgcwHBiz6GQy0FUKLVIFHrN/cTcrOYBfGv/0dRi4/W2tjvqwxPQPI50xoPvka
 kb1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792582702; x=1793187502; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VzfXTr0RAtPFYGhZOMc8E9mJynG/oxo4Z7d2pMzPcF0=;
 b=fKsCQig0kTP3GtmX2nh0xP+cWHo1EEM3bl3C+ZQi9/QcqX5go1IuMwmbvVRpplX8Ao
 mQC4X2YaaODsY3fr6ywaD0cT594otUd4KI4PyGnXwL5+QTjoiS61Zmv2BawjeaINTOsf
 OXQHC002YQedxFeYNHqYsZwrMwbZvQKchDB/6MByqZ/Ne8rjtiv4V7uQphj2ZLA/uDIC
 z4yGhouw4N07YTnXPuuHZijuUVjH/EJM6RSLSGITqXParQPMsFq/5qaDZAe+D0sFpVGu
 qclq2E3yENmd8Vt33XdCslp5VVpaIJ8khNSK1AKOjRNDfPeXuU3YMs0gg+DsWecf1XPR
 XeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792582702; x=1793187502;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VzfXTr0RAtPFYGhZOMc8E9mJynG/oxo4Z7d2pMzPcF0=;
 b=BMfSAqsdjpry8qBPmnEoFVOvkWjHayQuGJlLxKd86/2IGZRdQokTkJh4Xaspt2Q2Nw
 mVHSrDFbiR+XkusVeXItPxvmeGqD0ND60h7z4xfTx2f970KEGEPeFn3rIe4VGKxwffVY
 +P9s7wAtlRp8haQ1wP3iIs1NPRWdiOsUFZV/cSFM77bGQQ/14rQzxhgFzieMvIr5yzZ+
 GbJTCxdcj1vFm38aSGkZ2eulJ4cLbbruQUVAb0deFQrSoXaOWS6fymYkfMsLpSepdbup
 harZ6e8J3S6H0D21Bcy5e/3jIZAfizpunSmrUc+XYX6UjQhbMd00/zRdmy54xDxzzjt6
 265Q==
X-Gm-Message-State: AFq9FYIwrRga0R2xV2cZLEimmAqUbpTMKDj0K2xkEjdq7yeFPYGXmFHl
 ++k9iDVyyS+h3TVbKCMgw2Letzd9AngmDHFJ3iasApCTBpQxB5KgpsGIsJNoT6vyLJ714Vy77Ft
 pgTpax4YmvyrbM+QqCQtk5kB6xxWph3nUqF9uPY4ExiZn1v/+j+H34YH4W23iB0HbsDj8u3AWdh
 6UBRHD4jxlq4eH+PU/lsIhIelPzby43HY=
X-Gm-Gg: AYBFou05jicg85+6c+wJpuj0O2AaWWystCdcUmnaAt/UitFTY1U4wCR+nT15Z1fx2w8
 Bhxs64eHGhMNk5Jp/NS8Zs2EhNNEwyqBqmp90l9RePBrFJaMNUkgQlrJR9qgEl/GyxTw5vD1YuJ
 rNAQrsLBnECrjq/sJCrFvwkGlbQLvyMn7AXMUKzdPqfkiOrs7zne5ayiqGlM2ilWF2G0f34bGGg
 z2OOnGUeNxiAuswIn3d83nK9X64x49ceBUpEHJ1hgzqV/LiF8G1E/T5nOWTbdhEV7F9jjaGLVVp
 aQ==
X-Received: by 2002:a17:90b:28cc:b0:39e:6c69:7777 with SMTP id
 98e67ed59e1d1-3ad86d1c951mr1432661a91.32.1792582701627; 
 Wed, 21 Oct 2026 04:38:21 -0700 (PDT)
X-Received: by 2002:a17:90b:28cc:b0:39e:6c69:7777 with SMTP id
 98e67ed59e1d1-3ad86d1c951mr1432640a91.32.1792582701170; Wed, 21 Oct 2026
 04:38:21 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021-nohmp-next-v2-0-85471fca83db@redhat.com>
 <20261021-nohmp-next-v2-8-85471fca83db@redhat.com>
 <874ief1eq2.fsf@draig.linaro.org>
In-Reply-To: <874ief1eq2.fsf@draig.linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Oct 2026 15:38:09 +0400
X-Gm-Features: AclHuK9p_OOLg1CkvcfbmCtnjktRI7nnYzKmy1-vda7O29YO6JuSntXmB9ppb1s
Message-ID: <CAMxuvawMwiz5=Wpa6C+e3OA7eNZpTTDv9OS215qX9Ju8gwo=-g@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] tests/exynos4210_uart_fifo-test: fix buffer leaks
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Wed, Oct 21, 2026 at 3:21=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Reported by ASAN.
> >
> > Fixes: 6d459c75cfc4 ("tests/qtest: add test for exynos4210 uart fifo ov=
erflow bug")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  tests/qtest/exynos4210_uart_fifo-test.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/tests/qtest/exynos4210_uart_fifo-test.c b/tests/qtest/exyn=
os4210_uart_fifo-test.c
> > index 54c09a6de723..c336ed22b028 100644
> > --- a/tests/qtest/exynos4210_uart_fifo-test.c
> > +++ b/tests/qtest/exynos4210_uart_fifo-test.c
> > @@ -52,8 +52,8 @@ static void enable_uart_fifo(QTestState *qts)
> >   */
> >  static void test_recv_large_str(void)
> >  {
> > -    int sock_fd;
> > -    char *sendbuf, *recvbuf;
> > +    g_autofd int sock_fd =3D -1;
> > +    g_autofree char *sendbuf =3D NULL, *recvbuf =3D NULL;
> >      QTestState *qts =3D qtest_init_with_serial("-M smdkc210", &sock_fd=
);
> >
> >      enable_uart_fifo(qts);
> > @@ -71,8 +71,6 @@ static void test_recv_large_str(void)
> >      g_assert_true(TEST_BUFFER_LEN - 1 =3D=3D strlen(recvbuf));
> >      g_assert_true(strcmp(sendbuf, recvbuf) =3D=3D 0);
> >
> > -    close(sock_fd);
> > -
>
> Did the close(sock_fd) fail or is this just adding another auto free
> while cleaning up the buffer pointers? Anyway:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

No, it's just a cleanup while touching this code. We can remove it, or
adjust the commit message


