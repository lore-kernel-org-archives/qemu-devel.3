Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E81C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 16:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZCKo-0004Ax-TG; Wed, 31 Jul 2024 12:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1sZCKn-00049o-Qv
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 12:37:53 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1sZCKm-0006qr-G2
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 12:37:53 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-81f9339e52cso276515239f.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722443871; x=1723048671; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=MPj5D3FeavJB1KLt76BX0AIg5vpv2+XAOBZcmNwwztI=;
 b=a5oT1BDpHnud18/f5KO2cpAmdQnDpSWDGVGoQEviLsb+vne2Sq5MYwXk6Czf13atsY
 1j+RSPHeVYgKiIqkZtZGg2L0KqRxjXfVsBqZM/Ix1w9M2QrcXoLzeY9c0j0AhOFbtZFw
 I8ZNNUWSE/n+0j611/yPSBXySR9HDIdcOoujj+TfGGLGbihxZgyh9bDFp3wODqKWdV2g
 NUV4N1wa4afE++M898T8mFNYExxCUSpdW1Z1rEW+WHyYz6xlkJ5D2YKJVY9f5jHB2o8s
 WZRSFBH6oqv3EKSzj+HYU6xmUfFg2qUCUmcCbFCvtMsfklkrTu1w0QQcZmMtwrXNxEHW
 UGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722443871; x=1723048671;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MPj5D3FeavJB1KLt76BX0AIg5vpv2+XAOBZcmNwwztI=;
 b=RjALe1S/mbSEh7TahhnE6dAKCtIj9jX58dmq0EA5fuJ388Cih11EV9l0tl+iEjMe7y
 2K9o10Y4TtRDxGJPwzCkRCH/e8ZkPSLuFto468Rn7CbXnt2z3J0yNDRQ/3DeC5yfg4YS
 qdT7zA3v5SGFWTTV0JMcOc8HAdV0yuVoFmkZq4Aa+vzktoSLq3KC4u42g0jkZh3VvNhr
 c3KDT9K8w9WfwK4qVPgUo6qXM1M5I1qRAf4ghc4jeBBnthV6/Cj+Y3b9VVTbuGRmjY83
 6Z53h63h/YDR63eGIncszcFQJqALKcz1y7l4jNKTG3Q3FFeHoEzwTauqjgA04ZB0NEt4
 9HZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViOvXq/3jlsXe2giCOOe+zJdZLejhGCb2YhNsukic265Z0nJ4XIA1zb9UKovwcfYlHysgb8AIylC6CzrD7PmcwULwOMWw=
X-Gm-Message-State: AOJu0YwRhIEAeS/0xnRSsqZ4y9LD82kR7H6Cd+JxgceInYTdWCCZmQIE
 U4UCtvtjVTTzkEKW/GF9tva9JptwViJmXZ/LaAnI2+FDVbcts7Fo
X-Google-Smtp-Source: AGHT+IErG7U47TozZEIEi6d3kqTzMK1BY3tOrxcM2SZuYxpluYXvL61EgRisEmFXVC+eAw4cuuY9kw==
X-Received: by 2002:a05:6602:1350:b0:81f:8d5c:7325 with SMTP id
 ca18e2360f4ac-81f95be1db3mr2180570639f.16.1722443870874; 
 Wed, 31 Jul 2024 09:37:50 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2601:284:8201:81c0:e862:e2c8:b714:e7fb])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fbd9ff0sm3249394173.88.2024.07.31.09.37.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2024 09:37:50 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <bcain@quicinc.com>,
	<qemu-devel@nongnu.org>
Cc: <quic_mathbern@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>
References: <20240731010954.1959253-1-bcain@quicinc.com>
In-Reply-To: <20240731010954.1959253-1-bcain@quicinc.com>
Subject: RE: [PATCH] target/hexagon: define a v66 CPU
Date: Wed, 31 Jul 2024 10:37:49 -0600
Message-ID: <05d901dae367$fb967850$f2c368f0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLIxM81+CT2Jls09pXYAOOoA30nMbA1RjPA
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <bcain@quicinc.com>
> Sent: Tuesday, July 30, 2024 7:10 PM
> To: qemu-devel@nongnu.org
> Cc: bcain@quicinc.com; quic_mathbern@quicinc.com;
> sidneym@quicinc.com; quic_mliebel@quicinc.com;
> ltaylorsimpson@gmail.com
> Subject: [PATCH] target/hexagon: define a v66 CPU
> 
> For now, v66 behavior is the same as other CPUs.
> 
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>  target/hexagon/cpu-qom.h | 1 +
>  target/hexagon/cpu.c     | 2 ++
>  2 files changed, 3 insertions(+)

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


