Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0236AC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3v5-0000qj-VQ; Tue, 12 Mar 2024 11:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk3ur-0000fN-6c
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:19:53 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk3uo-0006Yh-2m
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:19:43 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d2ab9c5e83so511521fa.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710256779; x=1710861579; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CxCUXgQp1yQbNg8+9a4J36TH+/bY+7NI/iLkDlba7Xo=;
 b=dcWuPvvIiF8gDkp0bRPZHtAla8Y0cM4YnUUdXYNp23ZoA9ew9LiYakeOQ9CGePa/JE
 uIKj4dkp1xKgexFrI+2mVbsIETMaJOjJCyTcJX3KjzOL4H8e1M7pZ25Dzlx4ry81kR2U
 Nbb77jL6QY8KYk+sF+kN5k6+cdqqjQEN5eJ3mXTXGVUn1PqflgZ09lmjhUskqqY3Bizx
 zzye5cAhwQUfDTRp1htqj7gG5lbWI9WHlEHmIkSP+kN0iI9TbzbcbVWBjmMrk4y2bQev
 wS+RLxD/m5UYeXT4p8e9wXmcF2wt/hnVd9xk6UdkWlUMjWuAQ1QsctarCJYEpY46BI2s
 GvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710256779; x=1710861579;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CxCUXgQp1yQbNg8+9a4J36TH+/bY+7NI/iLkDlba7Xo=;
 b=Lcl5pcCLn6oKzfaoAzRqolTJ8sAF3DBDGb28fbIN940lX+u0nASopGtC2UhqR1uK2s
 Te8tjUJRjnwMu+BhUhy0N/p4IkzS5mHyKfbDcSL6Mj7v4+OaSXwTCLCOKajuGSAaN/vw
 eEaIQZXZRGGB1WvC0UU5Rr0bMXdGbxeGwgt6yg7RYsz1Lv0u6DiYhjDLOJkt7U/vltU6
 vwvWb0tB7WlIYSAWYwH2pQ2A310zgY3JGrO67nvXEiauQ74FKbs5I/azwbMA6Wb0NtgW
 JhUOYqk8Np3aS8Id/hqH1dk1BqdS4rIKJVxL4AdDXfZXzy61q7fb91hWjMpxcKNs2Jd+
 zFgw==
X-Gm-Message-State: AOJu0Yzwacj8T2dNv8dCTphL2vVhWupuN+4pMQdo60/4LP+I7h2QV5cb
 nY7dvdeM5cUYQzU4/9PUyJrLRivrFoJTK+uuyudWw4uCp/6WYVBau986WhBB05QlI0QlEM0YQAq
 EINGlvXDGkpHjrroYp09d2fTCS8muKoPa7GLWrQ==
X-Google-Smtp-Source: AGHT+IEn8+WMg53gbdF9+OQ2scgjALsmwyDKaF9SV3BhnbUMdaMvMKllyePFt23xNruPSsT0qfaGWTVHeqKlg0j8mJA=
X-Received: by 2002:a2e:9985:0:b0:2d4:4f9d:b0e8 with SMTP id
 w5-20020a2e9985000000b002d44f9db0e8mr1986261lji.33.1710256779450; Tue, 12 Mar
 2024 08:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240312112532.1558319-1-alex.bennee@linaro.org>
 <CAFEAcA_Vok6GcphdFv_NZv7iCeLpebS9JWZW5yHeRx1w9EY00g@mail.gmail.com>
 <87jzm7o5or.fsf@draig.linaro.org>
In-Reply-To: <87jzm7o5or.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Mar 2024 15:19:28 +0000
Message-ID: <CAFEAcA_q_wUUVNtNV4=twx2jp7E9DaAfgdM34i7xvRkm7L9gzA@mail.gmail.com>
Subject: Re: [PULL for 9.0 0/8] final maintainer updates (testing, gdbstub)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
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

On Tue, 12 Mar 2024 at 15:01, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> That's annoying - I thought I had the s390 jobs in my matrix but it
> seems they don't appear anymore. That said I see:
>
>   root@qemu01 ~# cat /etc/lsb-release
>   DISTRIB_ID=3DUbuntu
>   DISTRIB_RELEASE=3D20.04
>   DISTRIB_CODENAME=3Dfocal
>   DISTRIB_DESCRIPTION=3D"Ubuntu 20.04.6 LTS"
>
> And as 24.04 is just round the corner maybe its time I update the system
> to a more recent ubuntu (with I assume a more recent git)?

Not until after we release 9.0, please.

thanks
-- PMM

