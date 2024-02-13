Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46704C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZtGc-00031Z-8F; Tue, 13 Feb 2024 08:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZtGa-00031B-Se
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:56:08 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZtGZ-0008HB-DU
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:56:08 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55a5e7fa471so5718291a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707832565; x=1708437365; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jITQEis0dQaE8o59sFirzHSiA7yWgIb3cE5iQp6Oqgs=;
 b=DekK+hX7c40Qtn4wDICCG3JyaYc2YuMmRqs4YUATBC618VQLwZIHtMKe71g3SXsp01
 LY25kQJ2Z7Wus03nSCK2GvOYaymxLsr4IJ8X90LJ+isd11GgiX+Su3yAg/t1QP0S9PMr
 dGVzijQBDnsBuL5g99uVOKF9pJQL4cqZIdfadXdPnUFirJMkoLMvTMIkH+cORLdcy4hT
 dCYar2X+Uum2QKFl6f5j0bHXx38p76+0BVdl5omjTE5+89THLA5uMKNIBYOZKv70WJZA
 lH+2+vkYAgjzCFAUg7lsapQrbzXMjZx76JNiHGaRFv7cB3vcYLFL6PT8KnzbEIKY6gEJ
 9sKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707832565; x=1708437365;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jITQEis0dQaE8o59sFirzHSiA7yWgIb3cE5iQp6Oqgs=;
 b=k+7CgqQmNXpr4ZMfG+rXgAHiLIL6b8s3xMuxUwcyJfYb+X7QOBu1i5O8VeExVGWLsl
 GNpl+8X+sxBALopj/5gbr7Fv+qBD9m5579/V+WGfSjatJUVLJGwkaHXuvgbggE4PvVb/
 48n4Ep8LD5350nSUiqhykW+GGyQ1SR1+bfcPsxI1AznhqcNX2Ez3hw+4Y3S292PhEdAw
 AO++sMxgupzik4ZYwVsPNYPrUc/iUzBLVnSxppbWyRRF6o6UIZtDpfxJHhbxZyFEHHQM
 uJt+gGuPL8IclqFpvX5QD6xEi3mZ850SVxbXaWWsVKcOY0aOSCsB3ctI7jOwGKoUHOW9
 IXNQ==
X-Gm-Message-State: AOJu0Yx2BZJ6zN6sQxZ69fyUnNnZmQIRgHFkRN+jSj5hEgiH1dtNy7Au
 lZTfnW1cOUzyUWmudTxMcW2i15zh0YgUUmp94cPUDL2JwV3t2YJjs5ujYMRGv0HUbb0QKp2LtAt
 pppDMnOruV1+P5WWXIRgGRCIY5kqivJVUCNyzrw==
X-Google-Smtp-Source: AGHT+IELbpY9TsXov75KDv+gMZUaEBv0iS5imksqDvu9BfM/dok2BTty8Ub6gzRIk73fxac8csPfIxONYZjOrXWoNIM=
X-Received: by 2002:aa7:c88e:0:b0:560:ecd5:968b with SMTP id
 p14-20020aa7c88e000000b00560ecd5968bmr7275872eds.23.1707832564934; Tue, 13
 Feb 2024 05:56:04 -0800 (PST)
MIME-Version: 1.0
References: <20240212091436.688598-1-armbru@redhat.com>
In-Reply-To: <20240212091436.688598-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2024 13:55:53 +0000
Message-ID: <CAFEAcA8VV1kEf=EYJ7sb8buU3amEFe89pe9A1eA2UcwMSWmijQ@mail.gmail.com>
Subject: Re: [PULL 00/18] QAPI patches patches for 2024-02-12
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 12 Feb 2024 at 09:14, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 5d1fc614413b10dd94858b07a1b2e26b1aa0296c:
>
>   Merge tag 'migration-staging-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-02-09 11:22:20 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-02-12
>
> for you to fetch changes up to 0afbba6c3255dbe954ef609987b610cdaaf48f24:
>
>   MAINTAINERS: Cover qapi/stats.json (2024-02-12 10:12:18 +0100)
>
> ----------------------------------------------------------------
> QAPI patches patches for 2024-02-12
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

