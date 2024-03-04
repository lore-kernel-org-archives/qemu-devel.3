Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362CBC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 14:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh9dm-0005D7-7l; Mon, 04 Mar 2024 09:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rh9dO-00054X-NW
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:49:43 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rh9dN-0007NB-4X
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:49:42 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-564fd9eea75so6563539a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 06:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709563779; x=1710168579; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DnXwJ+2oj6ZInQuzEHozRJ+EE/lnYTg2w6W35/BMoVA=;
 b=rHR7lPgPsWEwNrN2kk0sGoPfUimqwQiKRHLUecqAoI//aSsK53tH987voZ+5dcscSO
 gubVtJk9thYMBZA9l2lKIe56mrkVAzVPAmrM3lQbeP4+Jh/YXIgsiHJmcm0RL59k50Tm
 MR6HVQYCaGvEiNhwY0cbhnnpPDC84LuK99MWZ9Qn+b2HCP6BGsX6K/7AU0yyDfiZkRPB
 dcmdcJaWF7SQYLinMz6chOvmn2YX/+Nw64+qtYZl5dAI6t1+t6oOOiJpFsdb78Q8vu51
 b4JVZrPDqVuxsIlf5D/zUcmXZStpqlq7vtk6Om9sJZwcQH4+cpBSEkHMyjBR8KQifkJG
 ejMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709563779; x=1710168579;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DnXwJ+2oj6ZInQuzEHozRJ+EE/lnYTg2w6W35/BMoVA=;
 b=lSKUqwjWUYqfPSJsTKhD52cWczf52GRexczONrVdrkuG/qmkX7gA2PcwoFgJQLiVgu
 6G7NVs+GprxHpPMO50SFc9tJEvNOtzWQxPQa1PwBT45goOTUgmWQe8KO6llKwe3C7IVR
 1g/RTJvMY4ZaOzGxNmcLHZ5Ob0/9bsP6n7tF4xqt3B0S1dhgkR83whvnQiw5j++gX1Aa
 2nokyX6okM9YUsKFilz6pbw/7Hi569hEwWHvrG/jWYYw8MKPeWeiRng0Zi3hMJCkHn7H
 aordPBaOySmScvE8qT4cv34JjG7wbeU5Ko9bk10jOJnKEpUiUU1lN+06VOQzIv9fFVpj
 vm6g==
X-Gm-Message-State: AOJu0YwWr/IYAhIPz5f3wnGzk+xgAzIv/VYA0Q3QqObq4QslHpNCJEow
 YBSB+MKrsQXR7Q3dhNrMaTNDzpMr5eQL1zA3Ad7mWY2kyMXzOzS4og3vFt7yQ+c3yfLmfvLtFPY
 k8ZcveN5K6iB2czaq57jNSyW8ENwBbyFyht3N+g==
X-Google-Smtp-Source: AGHT+IGIgKals/TgOHcNnnesQZSSiq4EkXu76qIrxYvUdasGtRv4foEVVpTRoX9WkWJm0uoazmCi3zL70OpaPg7FjFY=
X-Received: by 2002:a50:85c6:0:b0:566:4a85:ceb3 with SMTP id
 q6-20020a5085c6000000b005664a85ceb3mr6074285edh.9.1709563779583; Mon, 04 Mar
 2024 06:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20240304144456.3825935-1-berrange@redhat.com>
 <20240304144456.3825935-3-berrange@redhat.com>
In-Reply-To: <20240304144456.3825935-3-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 14:49:28 +0000
Message-ID: <CAFEAcA_92-kjjf2L_Z-+w+GX=kCQU+OnLMYp44eLwj8w2T-fpA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gitlab: update FreeBSD Cirrus CI image to 13.3
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 4 Mar 2024 at 14:46, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> The 13.2 images have been deleted from gcloud
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  .gitlab-ci.d/cirrus.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> index 64f2e25afa..b45f9de62f 100644
> --- a/.gitlab-ci.d/cirrus.yml
> +++ b/.gitlab-ci.d/cirrus.yml
> @@ -52,7 +52,7 @@ x64-freebsd-13-build:
>      NAME: freebsd-13
>      CIRRUS_VM_INSTANCE_TYPE: freebsd_instance
>      CIRRUS_VM_IMAGE_SELECTOR: image_family
> -    CIRRUS_VM_IMAGE_NAME: freebsd-13-2
> +    CIRRUS_VM_IMAGE_NAME: freebsd-13-3
>      CIRRUS_VM_CPUS: 8
>      CIRRUS_VM_RAM: 8G
>      UPDATE_COMMAND: pkg update; pkg upgrade -y
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

This one should be tagged
Cc: qemu-stable@nongnu.org
I guess?

thanks
-- PMM

