Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38154C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 18:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYVSx-0001sh-Op; Mon, 29 Jul 2024 14:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1sYVSp-0001rR-2t
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 14:51:21 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1sYVSn-0003Ou-LS
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 14:51:18 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-8076ef91d8eso170745939f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 11:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722279076; x=1722883876; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cz5Yu7Y7HtWOebd95sqanI999e0184WIrc0fKEIhgN0=;
 b=DQwMpf4pMFQOTVeQatj6YgM0q2A/m6GwzaWA7CdM/Obrc0fPgfliwlAHPr1n1KbkvR
 2cm9PGZrRcodneW1U5ulHHhiokzQbdTvDLJvJTKzfaMTm/YABn0zjuu7PWQMgruKpXUx
 5jHyWg4EXrXmectZS0yFbajCE9SrrN+9mB9QzxoMWGzxwlaMH62+dzUz4wuAfS7pNsHE
 s0IGrGBFv7VeKGQnnMwO+nQmUn8F4cxn+hF5BX6ZXJA7f4tjDbyjiNvUZGFLAgok3tYe
 X9xiHhVhEkw8PDh+aMM2OUfCT7klLjjnii33Sfd29DiTjmYpxdrirbsoSyVcY5ttHOet
 h14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722279076; x=1722883876;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cz5Yu7Y7HtWOebd95sqanI999e0184WIrc0fKEIhgN0=;
 b=KGa0cLSP/NnEqYesXkJusVw1Au1ZysB9k9NTwAGzYZaN7FRgf32HaVnvTVtTN2PUpO
 xtgKHicbFxszrJmlYTd0uktmYsLpN8Tc2Ms5WBrKS4LqtDYy8E/HbqqGDzlCcL4GuWqm
 hBpd+LXsuBWWlprxczKv96UBd9qq8cpX4fYkWSdRanGv36Ox8aD5jpy9jMeggCTNhF7f
 wmvlYO3ZsYGpxJf6/idtEXksKoGxIS/ZadhbolpxVSI33W1GPVS6GDIelNgzNttJY6yR
 d6Jtw2PP78SaEj/De8DXZS34AGpybt5SkbqKUn7fc/cOqzGJFwjfK8ZqGiz/2kD5GQED
 5fYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/HrfkJkVQItB15ojBXwM/e+3GTgvVuDdEbs4m2fG8e51NOflou63eFijRepDTMrPd55WkY7MrttOXGB2awWUWONlFptM=
X-Gm-Message-State: AOJu0Yx9FpSFGVmK8TT5N/km7DiniOZB8moeUarh5zEuurjONl+uzNLG
 kBYqa2Tt+m0PnBrqpvglXJbeqmaH5nan+h8FAPPGPJCIskSe/+9J
X-Google-Smtp-Source: AGHT+IEXb8gul2E2ZbG8pdyJWj3Fy5WlqnLpef8UwOeGhXmwTJ5uaS5UC1QZQip4O0q3Af9U+yAwJw==
X-Received: by 2002:a05:6602:1589:b0:7fa:b6c1:c35a with SMTP id
 ca18e2360f4ac-81f95c13037mr1107782339f.12.1722279075977; 
 Mon, 29 Jul 2024 11:51:15 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2601:284:8201:81c0:956c:72ae:2d78:e5d4])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fa41693sm2428041173.27.2024.07.29.11.51.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2024 11:51:15 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Matheus Tavares Bernardino'" <quic_mathbern@quicinc.com>,
 <qemu-devel@nongnu.org>
Cc: <bcain@quicinc.com>, <sidneym@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>
References: <9f3be6911db2dcff834ce6b530118fa383b9e46a.1722186937.git.quic_mathbern@quicinc.com>
In-Reply-To: <9f3be6911db2dcff834ce6b530118fa383b9e46a.1722186937.git.quic_mathbern@quicinc.com>
Subject: RE: [PATCH] Hexagon: fix F2_conv_* instructions for negative zero
Date: Mon, 29 Jul 2024 12:51:14 -0600
Message-ID: <03df01dae1e8$49f42410$dddc6c30$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJXKaSlQjlEaHbx2YjkbCLGaHxFdbEVfFSQ
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd34.google.com
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
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Sent: Sunday, July 28, 2024 11:16 AM
> To: qemu-devel@nongnu.org
> Cc: ltaylorsimpson@gmail.com; bcain@quicinc.com; sidneym@quicinc.com;
> ale@rev.ng; anjo@rev.ng
> Subject: [PATCH] Hexagon: fix F2_conv_* instructions for negative zero
> 
> The implementation for these instructions handles -0 as an invalid float
point
> value, whereas the Hexagon hardware considers it the same as +0 (which is
> valid). Let's fix that and add a regression test.
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
>  target/hexagon/op_helper.c | 16 ++++++++--------
>  tests/tcg/hexagon/usr.c    | 10 ++++++++++
>  2 files changed, 18 insertions(+), 8 deletions(-)


You should update the copyright year to 2024 in the files you changed.

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


