Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E14CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 14:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut5CT-0000rR-LR; Mon, 01 Sep 2025 10:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ut5CR-0000pG-E6
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 10:07:59 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ut5CO-0008Nc-Gr
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 10:07:59 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-afedbb49c26so671666666b.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 07:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756735674; x=1757340474; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2PHE4tDWICMpABeUd1pZW5Ag69gQXLtV4C2FyAibqdA=;
 b=FX9WofcEW8TWlLdn24w0jVz0/QaxXMWEfrGduJ/Otj+tflbS8Hr2YYuJA2JAeK3AZV
 C8yblByzs/izhTilbLZ41ZUjbD15yf+n0GwsDA8miqul8/ReCyQM8aKw0EW+KsjJpPnY
 8DuADRVh7rkALsvGATLa896AvS1jTb2Ia6a8wqsWdsrtmDcbRBzcLbz3jph8Dq2oP++A
 pwI00UWlboRAKFZza5XR1pyHAYxBK0Jh/Wb82HVeZQqGjtq3NpdTKWYYEgLZePQkZ3PO
 QplT5/fzCMkeO7rUvCxxcLM+BQ4zb5LlTU7qwNIwial/SfREz8KwrJESF8AVCzmd+Gun
 3kMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756735674; x=1757340474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2PHE4tDWICMpABeUd1pZW5Ag69gQXLtV4C2FyAibqdA=;
 b=O03hRnZttftcjOi7vYYWLxOAny5/MdbumvV1OvMgoNP8bDkainHRLLkkLzH6LCMqAb
 MsO8MIBYeeb+ZGvurmqlQNr+Zx/+8q5D/NptUA4vFe8Cuo2pEaaMV9gjpTm0u3t/kjFJ
 WRrTPMx+AFULz+xZfRe+IqdXeuqEQnomRjRcXj1SSGbD46qCRwyViwry/orwDimBNjBa
 xfS+kxXg7AsX3YDhrLgZIpzNRlKRvjCtvRfdf2UDWMDYg0sTT8eonYWDLtODgh2jKP33
 puv4IcRrfruCHWWI2DkRg9BHK4c8UVmhtIavS0bBAf06G4PP96qkzise6DKOGFRFr1Oc
 xK6Q==
X-Gm-Message-State: AOJu0Yw6j4SevExbkB+8DMggJ55oeK/eDuYZRhC7vfidc0ycf3XbrwCt
 zNbeXMLbX0Il9E/HWLdcYiBW/SEIenKb2cLkCnm+NgExh0ks5l1djOwCuu4wmuW7TGrOdsZx4Wb
 0KhIkx+FonExeNM/9gui7860wUPXImQ9FUKyQOowfPg==
X-Gm-Gg: ASbGncusV2xiPtJLxeoNIFUeRYlf7r9qVYEeRTB2w15y88ZVWEwoO2DL8Dxc6xN4acI
 Qg4mbc4YM0NVGubb1jUE2n0bLhLOx3faCbXLMXGATwcw291x2PvWxhZsJW/4rFSWn3YSLdeEm6t
 wSPGAHAbfupfiOyEuxe6pRa1djncmAm+vsXD4nEdChIqsyZpKj9e2PWyZ/AYFfRC+tfhrXN6nxs
 6nGIRP7
X-Google-Smtp-Source: AGHT+IFa9gNH32L7LfNpQ84Q5k35yE8UFMrugw7g5Fr7brDLMyX4Gt/1jIU8YVDpAnKuizEsRUUeIfpvuAtvPnZMatg=
X-Received: by 2002:a17:906:c10d:b0:b04:20c0:b219 with SMTP id
 a640c23a62f3a-b0420c0b768mr464735266b.64.1756735674498; Mon, 01 Sep 2025
 07:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250901132626.28639-1-philmd@linaro.org>
 <20250901132626.28639-2-philmd@linaro.org>
In-Reply-To: <20250901132626.28639-2-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 1 Sep 2025 17:07:28 +0300
X-Gm-Features: Ac12FXyXcB9TTDyJP7s_K0eNH_-x4lszy9_5dAVZ56g7L8xKCQskrvBjXzM-6Cc
Message-ID: <CAAjaMXYN2E8quZxyB3pE88o_erJZrQ4LXFO22jrx+mzRHjb5zA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] target/ppc/kvm: Avoid using alloca()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, kvm@vger.kernel.org, 
 Glenn Miles <milesg@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62a.google.com
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

On Mon, Sep 1, 2025 at 4:27=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> kvmppc_load_htab_chunk() is used for migration, thus is not
> a hot path. Use the heap instead of the stack, removing the
> alloca() call.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/ppc/kvm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index d145774b09a..937b9ee986d 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2760,11 +2760,10 @@ int kvmppc_save_htab(QEMUFile *f, int fd, size_t =
bufsize, int64_t max_ns)
>  int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
>                             uint16_t n_valid, uint16_t n_invalid, Error *=
*errp)
>  {
> -    struct kvm_get_htab_header *buf;
>      size_t chunksize =3D sizeof(*buf) + n_valid * HASH_PTE_SIZE_64;
> +    g_autofree struct kvm_get_htab_header *buf =3D g_malloc(chunksize);
>      ssize_t rc;
>
> -    buf =3D alloca(chunksize);
>      buf->index =3D index;
>      buf->n_valid =3D n_valid;
>      buf->n_invalid =3D n_invalid;
> --
> 2.51.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

