Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1E8CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 12:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy7yS-0000qn-2f; Mon, 15 Sep 2025 08:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy7yL-0000fT-Vs
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 08:06:18 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy7yB-0005kh-NI
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 08:06:17 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45decc9e83eso44692775e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 05:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757937959; x=1758542759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4zI8XI0djD8xO6X0YKHxyYis7USTnYWl58EkRxshHQ=;
 b=YZGV+c/vGumbA/S9bcXoUM1w5JBqCrCux+ZDcNyVMVyrjAsCJZ3qIL21lxIKbzeSV+
 Tzi6QKTfL1HEA76s/bHnutzWfLNm2NMW3DM/e/J+6QJdYoQtbEvshrC28ugsWmxFlM3s
 GfkEO31Bd4/kxMUhOcpjyIKM7Y5FzoQGoXgze4QpI5W6ygYFH5GkRvRG+R+0u2UxFSq9
 Y2vyfSo34OnSPu38ICqlIw23XXRU5bca2m0hokhhHav6lZRXsSH5VPnTpDsK0zLqGtgj
 fY98E94VQdG7AfuaeQqLaXKnsCJG1r6LqqtC5faPdUYFB4vYZqWwYA+c8ZUp+ilIbsXM
 UFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757937959; x=1758542759;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a4zI8XI0djD8xO6X0YKHxyYis7USTnYWl58EkRxshHQ=;
 b=lyC+SrwnQpLwEto/iiambsbU9RxLoi2bB4P+IQ9xjL64ZM6ymEfIvNuQEh7/84uSQX
 XnQzO6DCw4NrMFbvgU+th1IcdhrYygmBYhCcvnKtTOApbNTAVy4M0Dbfigir09riCu5g
 uCU9Na+7hpqpi9J7r0b9KCYX8qDZQoMn3xm2rkZS6M1VXqOTxb4B6Iiv3B6Djy4qvOSL
 g0r7C2kDtFgHo1bjKJ9SRFt/8Lv1Hu6YEhc5Oo6VLSNWj/5XdI0ENRXDc2RYkZhRh2ru
 KhNIK/4fh14QwMyQ1UvDSqfnThEKqEtj8Cn5adndsBG5mo6LxxB6fly4cn+YrABwM/+E
 jUxg==
X-Gm-Message-State: AOJu0YzucPS9cdtquo3oyzpJ6+xoExtuSpUa/sqvAcPck4q+7BcniOVE
 6agBNOAkZWcyXmdpFB+mRDE+aINDWBsbrIDX6Cdnx/EWhy1sBnf90YLwOryQhzLisiUzm8WEdsP
 wetXFUPU=
X-Gm-Gg: ASbGncveHGbl1sD6b9r3LuXM5vSJnBKJNPLaXAU5HNzrNBkaAoqcdgEfodyEp+6OzO1
 6WsQ54orWixGmk+knY5GQZknkOKhjQT6izWPvH4ujtIsBz3USj0duA3CrbMy6EHR/Q2JxcFcE7y
 0rbaoWoViAbUR6OIdPwR3TKdjb0oQUZZ+0LvjgLrAwK9MGSx5cRFKU3D8KqjvxVGxPh87mcee2q
 QiDp6GlkMbfJg8XR8jqlEN47mJ5Hix073X47SZmvAjH+oGe2aGFW3ck9fLOEFVKs4uINiXFJJmB
 NUTSO5RYhnwXeeyYN9qmv/9eVj35LqMvpqQdMetwfIMOAl7BcAUvNTHjXIIjRsLHywUofoB5W+x
 NvcdpZ64e4nG7f3LaqqvC1BSim+Fxb+S/1A==
X-Google-Smtp-Source: AGHT+IGDwzfGZS5PyIwG4FFO7LYkh+MacHv4bxN2Ly8fbYZh9Akp/39TvXQl24P+UNSc2+svxSC+8A==
X-Received: by 2002:a05:600c:1c96:b0:45d:e135:6bb2 with SMTP id
 5b1f17b1804b1-45f211f9efdmr106133965e9.21.1757937959333; 
 Mon, 15 Sep 2025 05:05:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e8e7692c9asm8915026f8f.30.2025.09.15.05.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 05:05:58 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CB63F5F867;
 Mon, 15 Sep 2025 13:05:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 4/6] tests/functional: drop datadrainer class in reverse
 debugging
In-Reply-To: <20250912182200.643909-5-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 12 Sep 2025 19:21:58
 +0100")
References: <20250912182200.643909-1-berrange@redhat.com>
 <20250912182200.643909-5-berrange@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 15 Sep 2025 13:05:57 +0100
Message-ID: <87y0qfq5sq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The reverse debugging test uses the avocado datadrainer class to
> create a background thread that reads from the console socket and
> dumps it via python logger.
>
> Most tests log console output as a side effect of doing calls
> to match strings, but this test never tries to match anything.
>
> This isn't critical, so just drop the functionality.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

