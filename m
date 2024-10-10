Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8318CEDDA6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 01:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syhWt-00044F-3L; Wed, 09 Oct 2024 20:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <suda.kyoto@gmail.com>)
 id 1syhWq-00043D-Mu
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:59:44 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <suda.kyoto@gmail.com>)
 id 1syhWo-0001KO-PW
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:59:44 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e2b159c609so395960a91.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 17:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728521980; x=1729126780; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=maQCEem3a5Tdbu8zD0oc/hwxN1Oj3hExj3y7E7iqXBY=;
 b=VubEnfRA8tzUx+WvQry6D+K58hdiXTIqdJFuO8l89AH+Oi64XXNfwVEOjFy//CUxEs
 10tQQYvyGr6yk0E1u0x6udH5cwXslxIGL+xuhOgmE82c2qsUZm2BcXlRIjnoNjvp1GIz
 bxceHfNU74/ceJj/am60jTAHpWziPMPyGpId9FRrXkliEr3U7aF++F3KaoSI+7iwQMxl
 8ZP4JCVEIZ5cp4tqCWb28sRVm6ibqTylw94trw3lvsqbjouy9yATArJH/QzlB/+pLZD0
 RQIjqsErTrYL27e1Ea3UcAqKgz8tz1QpRPLESeqR8CwqO9gnDj5Jj+uEE08TWm8/8mHB
 ZgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728521980; x=1729126780;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=maQCEem3a5Tdbu8zD0oc/hwxN1Oj3hExj3y7E7iqXBY=;
 b=pLhCIQiNGCl4p3JE/myf18jzChUcc9WaP6IafZeyyOdJBPnTDN7nvNI5SFq+uZ3o26
 QRMWumHuAGOroDCd5AaBGPuj1/CHz/8UsJq2ge7cz6kjl7A+ymFsaQ6z4sNIxr98fn3c
 vSz8tq1tPxY4a1WYdU40dEk6uakvKdlen0WZSgJ15AWubVsngFcqRi0sRhVC3dWZwT7T
 TtJnRp3rhGXbafVoAZAbcFjL7ERZCp80o/mANm9VrxHcRM3f5QuMRktIf6Wdyb5yfpPp
 kJXm1uWEeD+bhufgOYxJL6+PqT3oz3bPGWMHKda009o3Q3y9GLKfOLi0E+bErHi1kNrC
 NmYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3HbG/mLicV8H9ZTY9lHk/LR+ob9u5PW/My9NUZQgAzf2HVYUeLGbyFfRvEDWS0NnqZ2Jm2xPHDH9L@nongnu.org
X-Gm-Message-State: AOJu0Yy3YyKqu0OU+IgNXq5M75aQIuZdPIGMDkVGRmc6yOGcTPpRiW2r
 f9obEK2SzOdSSG2Y7aCw5bsZeE+WLB2jkbJcnrc9Vu8blQFCcxdv40XvP/NrbXRFRlJm3vyEh98
 mfuH0S2yk/Tg6vqpE/BOrJZoV1V+u7xjL
X-Google-Smtp-Source: AGHT+IHZSRSX8Gje1yq6St4DKXXiHzvK9VU4pzgO+J/6yjLm1zhhiKelXUvxjhI55/vGaTZHwIdbrtW+2YipEO+B8oo=
X-Received: by 2002:a17:90b:1990:b0:2e2:cd65:de55 with SMTP id
 98e67ed59e1d1-2e2cd65dea4mr1126208a91.20.1728521980067; Wed, 09 Oct 2024
 17:59:40 -0700 (PDT)
MIME-Version: 1.0
From: Akihiro Suda <suda.kyoto@gmail.com>
Date: Thu, 10 Oct 2024 09:59:28 +0900
Message-ID: <CAG8fp8Rbh6a+asyt1iowS2U=HE_qicxUGZC1vz8wHdtB0OtNmQ@mail.gmail.com>
Subject: Re: [PATCH v17 00/13] Support blob memory and venus on qemu
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, dmitry.osipenko@collabora.com
Content-Type: multipart/alternative; boundary="0000000000009bc86f062414e20b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=suda.kyoto@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000009bc86f062414e20b
Content-Type: text/plain; charset="UTF-8"

> And I think this series is ready to merge once the tree re-opens.

Hi, is there any remaining blocker toward merging the patch set?

--0000000000009bc86f062414e20b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;=C2=A0<span style=3D"color:rgb(0,0,0)">And I think thi=
s series is ready to merge once the tree re-opens.</span><div><span style=
=3D"color:rgb(0,0,0)"><br></span></div><div><span style=3D"color:rgb(0,0,0)=
">Hi, is there any remaining blocker toward merging the patch set?</span></=
div></div>

--0000000000009bc86f062414e20b--

