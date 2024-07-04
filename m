Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E7EC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJ4u-0007pz-Bi; Thu, 04 Jul 2024 05:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPJ4r-0007pk-El
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:48:34 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPJ4m-0003Af-AA
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:48:32 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-58b966b41fbso608435a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720086505; x=1720691305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FmBxvp/x4PDNZBOKMLeycxjwQekSbVXQLtq0NWh8g6g=;
 b=GaUVS/Y5ylC+wgR4PQN50He/ygxCmHLoosF06mNboOiibL8hu+V/s3HG7L6zXxYEud
 m34oXEYQpWAh90AKlo7DbedgyYqzfjcKkY7cQo4xjq4gSIh4DiQ+zwIgjb1HwhdpyqKv
 BbGvXTrURJBNbcfYxZiwHPEkna3iURr6xHSUOtalTJjuZbpi0pcvv67gN7Duti6LUGbx
 uih1GZqXzmENbDkz0gAHu6wlmnGJyuVBOHPiAwtanZ9otOgTfm6TXv2m3wcucK+hL7eR
 cvbIml6sYSj60QgldA5AGwZV2RHSa3wFCh32JBHXh4wvWklVRaMrf49w/CNxbR/PsB9t
 SFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720086505; x=1720691305;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FmBxvp/x4PDNZBOKMLeycxjwQekSbVXQLtq0NWh8g6g=;
 b=WK5jfaJsoNdGNsjkWaDQJrMY20jSZLaUQxuU3c/jPY+jP5GhPrE3EWkUqG+hhFPTd8
 PzBItjyJb0qq9GqdrdNcbUMeE30SEV5QktfXnOAbZlhj/2AI6LF3z+e5S3IHLZfmeduy
 SgfSV+zSGT1lX51PYt8oLNyMdugl2pRZ6nuQcip8pCzXG3D6TvtdZZu/KD07d5kGOoS5
 pDJm/cYU06d15JE7RRKQtLKyc+BqbankGGrSFnWXBxqRd2syJ4M1kwzgoFmWMkHG+Ytk
 fpcBgD1PETKRKHbhWI2sPQK+YG7HvZ29QFaD5+dV5MYgDDEyr+CjH675sXFs7Br/ENCC
 S2IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLnFPQu9wEi2F0GU5/eBhRySEZru612gUCVV9N7KSmIBZpikpJDKChmqRST1jIRjELDL2OD3tdUVSLTUlvhz51HIkEyPw=
X-Gm-Message-State: AOJu0YxI+tZ87wZpVUBLka6CCwI9uyN6YmreGDP+KN/O6fUcFwQj/3rK
 Ay0ewpUEeEZewKlG+pmBgOWxSbTmXKFWllbeKX5HGXjTi3pew7KOYqXMNmfLWG4=
X-Google-Smtp-Source: AGHT+IG8xsyIDIE1bBw2LSStgN9E8h2S3yiuZzMmI5ZWr1EIU2rHg6HHSeSD+ppYajFTjHWfbvNQXQ==
X-Received: by 2002:a05:6402:40c8:b0:58b:d7f2:eef3 with SMTP id
 4fb4d7f45d1cf-58e5965a9femr816946a12.12.1720086505076; 
 Thu, 04 Jul 2024 02:48:25 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58612c8371dsm8241771a12.9.2024.07.04.02.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:48:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E67215F839;
 Thu,  4 Jul 2024 10:48:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,  Laurent Vivier <laurent@vivier.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] util/oslib-posix: Fix superfluous trailing semicolon
In-Reply-To: <20240704084759.1824420-4-zhao1.liu@intel.com> (Zhao Liu's
 message of "Thu, 4 Jul 2024 16:47:58 +0800")
References: <20240704084759.1824420-1-zhao1.liu@intel.com>
 <20240704084759.1824420-4-zhao1.liu@intel.com>
Date: Thu, 04 Jul 2024 10:48:23 +0100
Message-ID: <874j95pjx4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Zhao Liu <zhao1.liu@intel.com> writes:

> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

