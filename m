Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6510C02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 14:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgmDf-0002Y2-V7; Sat, 08 Feb 2025 09:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <buenodelgado83@gmail.com>)
 id 1tgl8q-0003cG-EX
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 08:45:05 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <buenodelgado83@gmail.com>)
 id 1tgl8l-0003Cf-Ny
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 08:45:03 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-51f405fce23so226935e0c.0
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 05:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739022293; x=1739627093; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=v+jIzSmGyCOgOPbI+VjX28ZGpOq8ISpyyQcfFet1R1w=;
 b=Q620kkdzR5Dmlj7dIjG0I9QFN1LYyES+qdwuAheUHhmKF3sczmcIKS/IA2QorDgMro
 eNEW+Nhse/YPOzhpWyREb1u/iMgF7UNy62kpMmkeqU4NcEAWBVc+04LcpjK2cA7mYYgM
 vBkU8oph44kFIiAaZ/KfDi8/kA7GHC/nrsxQCN6cZdO282YDNX9GOj1owC6qJ2dWwmBf
 MNNE+03mekpD1Z622o7XzqD8HmT27g4CcdlEJrxDkj/A0O/p0Z/ZBVZOVfP4F9yPnUdw
 gPTkAQqhw1eTaC8fLHBNlc/YFpE5624QDVXGXs3mUQqPYqFBBKE+HQUR5aXtL1fl/eur
 KFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739022293; x=1739627093;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v+jIzSmGyCOgOPbI+VjX28ZGpOq8ISpyyQcfFet1R1w=;
 b=WpVwkOdN+rnb/2JwE5rPvjWW81FGgim6811pWxLJ6Ftrrt0YcTxVZoPm2h1ITofQ4d
 TAqe46BC6CdYyApySzxTDeTGQcgG8w8VTg4wzwXJVm+8XJY8TvINyY/GkODsBpzgmKGf
 110E+4l9VaoU2dye8ntVSiJWs5KW0JpS1giozwkUojFf6FpD5cVWVnicb1pEsroLVCXk
 fMIdvfST9jjoeQqis3Cpje3JO1Fcw2v7Jr1pQbJxwPUgRrOJo8Ffnj36r14r4pzpz2Oy
 oSa2B1RiYYGqeB7VETsUkM2l+ItsI3ShgPUtNe6sB8k/zLMGA9tm9poOQVu1mKpz2gg6
 So8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxv2oZWRWSqCHz1jXyq2dFVFHrMqOJcEZSoZTYrvZZw+dz1yizOq9/h5jY0oBbtG1/hNIOcykIAY3e@nongnu.org
X-Gm-Message-State: AOJu0YwQabe3zfA8zgQVPsjKK+WjN9NQCpR1od5Bhw1+Nlf9/Y6j0B4+
 ustig7L8LU6gc2zZcB/WSNlL8w5oCOkb9h0UKiqNV1ZYGFd/nkyYBWAfJu0ZfsK+MZqiZKdH/Pa
 ufXQuOtn7J0rZ/YM5K9GahXUGv9Q=
X-Gm-Gg: ASbGncuSpOYbgh6pqJM+qrg0zfhJJhi9+gt41Pn9yoKb68MxGV2XcI3u7TT4dfepeFJ
 lx6z3lH6m4Db/H4KgHVut5DsYhYuBEL60GsssBKiQyQcwGTj3ATnuj9MevPIVM185QktrmBi4
X-Google-Smtp-Source: AGHT+IFZ0JrEtKDf+JjcQ51Ub1vI3zvBTZsMm8jvkGmKuZqfYZI+iNLhl2M74UfvFf7MYunql+aHxBzmA/H2H25iRkQ=
X-Received: by 2002:a05:6122:65aa:b0:50a:b728:5199 with SMTP id
 71dfb90a1353d-51f2e249b7amr5886327e0c.7.1739022292849; Sat, 08 Feb 2025
 05:44:52 -0800 (PST)
MIME-Version: 1.0
From: Alberto <buenodelgado83@gmail.com>
Date: Sat, 8 Feb 2025 14:44:41 +0100
X-Gm-Features: AWEUYZkD9Am_cqRZ6Dq2RiggCR18kFzwB8HKVmIP1Nzrf_brOZ7QVJKi41DIZh8
Message-ID: <CAETDB_fGMmgmTXcA8kTGtp9LEBG5oRv+gTP49L-xVyBkJ-B0vQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] hw/hppa/machine: Allow up to 3840 MB total memory
To: deller@kernel.org
Cc: beebe@math.utah.edu, bruno@clisp.org, deller@gmx.de, mjt@tls.msk.ru, 
 qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: multipart/alternative; boundary="000000000000059bc8062da1ae45"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=buenodelgado83@gmail.com; helo=mail-vk1-xa2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 08 Feb 2025 09:54:05 -0500
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

--000000000000059bc8062da1ae45
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Qui=C3=A9n sois

--000000000000059bc8062da1ae45
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Qui=C3=A9n sois</div>

--000000000000059bc8062da1ae45--

