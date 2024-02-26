Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC306C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reX7Q-0004pL-0n; Mon, 26 Feb 2024 04:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1reX7E-0004mc-0w
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:17:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1reX7C-0005UN-BB
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708939057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5lyqTQms8lcEtXO6HjVUzjjAsHkbTP6GmJWziJqmtA=;
 b=Ucvn1d3gHRmKr+tXwlDpXuD3ts8FWLkCJOSV/nxtD9yzlI/yvomNh7n7UpVyFWCKhqW0rZ
 mMX8yLX4kuWhTax6KA96nOH0vlO0tWf8Ow8ztfk0F0Kmz8yphMdidG2d1T4uGml2yqvmsB
 p8FvTXfCEc4CijVBvlEuY7k8Qyjs8P4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-4q3F-FLMPAOsvXVIlqOVOg-1; Mon, 26 Feb 2024 04:17:35 -0500
X-MC-Unique: 4q3F-FLMPAOsvXVIlqOVOg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a43381a778aso60920766b.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 01:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708939054; x=1709543854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5lyqTQms8lcEtXO6HjVUzjjAsHkbTP6GmJWziJqmtA=;
 b=noHdu64Gw6TlibdcK05153rgTmG1/mcirwCRIPUJWfq6wmT7W4DDBv2tisZbxQFTGK
 fmDLUqq1INtsJrj3KPjpR7CJRchrNVK1NneA+MvwvdV2JroguhNXd1JWy+huR0NVsu5u
 npzbf70ztaP1yIfisSk1atnvO0mqIjKvzuRbhl1BBBl7rLCVnpa+Iwu0BzWmtENNTanH
 yDa5rKhom6NYCoLjzhVtonTvIptgODoumpOoA584QL5ySPT7wPWsCIeTvdnNzH0V80jn
 Dd0zP3GN7xeuH9hC7gwU7w3dmga7UwphNDvhrTt+D9X1cFMqs06xXpy30189r1KfPmBZ
 Nlng==
X-Gm-Message-State: AOJu0Yx3e2QgjrqNQaO+cmvS7vhOB4f2JM+tOtU/SafmISxhsFMTIGdW
 HykSR3vKjT1j5MrdQIbbCq9188MTnpAFE92uJmazqikbGLrwng91NacVemiCstA3Tx+PeDrxpRT
 xYGckO/uh+mEZdPgzoS5LAEFiTVlpFdOjXQyR7AllgFfmaPGSiOsvcI7VJgAjPpj9Rlj8hVLK7O
 9XxqNtkTUFaHQWsAruyorT19/BgaRvZu6J7Ek=
X-Received: by 2002:a17:906:408f:b0:a3f:d927:4c0d with SMTP id
 u15-20020a170906408f00b00a3fd9274c0dmr3939116ejj.26.1708939054196; 
 Mon, 26 Feb 2024 01:17:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPIlgYIAXHdjhP3j5IpWB01hZaAwQiu3RDgOy1pqC6BHx9RsaqTGZSWwpwkHHV7WudCSon0Tjm/6oC4vpGNAo=
X-Received: by 2002:a17:906:408f:b0:a3f:d927:4c0d with SMTP id
 u15-20020a170906408f00b00a3fd9274c0dmr3939106ejj.26.1708939053863; Mon, 26
 Feb 2024 01:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20240226082941.90364-1-pbonzini@redhat.com>
 <401e7d32-c39b-48dc-b06a-97a4af16e6c8@linaro.org>
 <365082ea-7835-4ff2-b1aa-48bb89cc1c8e@linaro.org>
In-Reply-To: <365082ea-7835-4ff2-b1aa-48bb89cc1c8e@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Feb 2024 10:17:21 +0100
Message-ID: <CABgObfZN0servOkQcr=Nq4Xi4OfspQdamm=W1P9CmRq9V+yQyA@mail.gmail.com>
Subject: Re: [PATCH 0/2] ide,
 vl: turn -win2k-hack into a property on IDE devices
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 26, 2024 at 9:50=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
> On 26/2/24 09:45, Philippe Mathieu-Daud=C3=A9 wrote:
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >
> > (This series will be queued in 24h)
>
> Need a rebase :/

The include/hw/ide/internal.h hunks simply have to move to
include/hw/ide/ide-dev.h. I'll send a pull request myself, thanks for
the review!

Paolo


