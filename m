Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89277C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 16:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZCN5-0008Nw-Fh; Wed, 31 Jul 2024 12:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1sZCN2-0008MY-Hi
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 12:40:12 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1sZCN0-0007bY-OF
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 12:40:12 -0400
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-81f860c6015so256532639f.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722444009; x=1723048809; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jN+xilhegKcoqd++zUPtCcuDyeo/VbQTm+5ftiniF0s=;
 b=CRAqQVZteGJ3jSo+48rlg8C6m+EURUTjSi3bOJjR7g7/UKLY0tbXm7yYskePzhiBeA
 DSmacm0qGQTcmUWFHs+lnD6ABh2YXoh2jrZj+qMsYm5G0qsW5uRbEO8wL0T62qRcZZqD
 9P9S7d2uow/4kAJiGhC59n4BrCDSSJJVLjX1vUaeqsXotAYsqO6t7fSD8xb7C/xwVgH4
 UKAEB5PE1kbeG/vEyrnB+xb7OD8KIi0X1so/aszwXYRY8e02/zmLUrYjM8hz1o/Xaqv3
 cT7xbG5PHgupQC2poGZcacYUy49UV9RLOFZ4A0t0xkOEKrt1sod1lFFKzxT1iLAEpCLL
 EukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722444009; x=1723048809;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jN+xilhegKcoqd++zUPtCcuDyeo/VbQTm+5ftiniF0s=;
 b=SAYO8dVSgUsvkON/iY/2F9DzLfE2WxvguyDHPWHXDczn65OtOGL3xI3T+8OdV7+37p
 KC39DY7PjzWETjJJv2PSv3a5ISBXi2wbRfcX+B6W1JjTGoOOP+zQDv9SI+V9vhffZGtO
 Hux/pd+2OofeangGfGGZnIiMQSBpZQIVHEaNj3H5cNIE+uAsK4DURMWl5iH+2DnylyRw
 BRUtZZBF1yStUOU/zPwkq0qa/RvMFoVNku6Ueeky06j7MQfHd3ORedPtJyFds2nRZSbF
 PFhRe8j0eW0QAntKrEGPZQDRA2f8RyelLL4QspFsItEloPJq9TWXu2tQlCWYkwN9Ztx9
 AIVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsTQh4ooExGLl0Udl5yGkK8QMpo0DKpVgL6liNMLPOsnJ78h4y9RDYgy+5iDM6qSBcX8DjIUSjlbFvFZMKSba7FyuIKIM=
X-Gm-Message-State: AOJu0YySKtiWUlFEXFnpyIBOFEjvOoyqHLMOUwidCs9YX3FZ9yh8rrSN
 S2NO1FmtXYOZoOS25ZvAwKefi5/bKFx2k1vIF5QIjfKIYHl6nc/L627E7w==
X-Google-Smtp-Source: AGHT+IEgTMpxgozLYnSeS/SD0DPyw64ZPb4kNYxuIrTszdzUKe8QwwSfxF1h1lNMLr/WthYaKjJOuQ==
X-Received: by 2002:a05:6602:26c8:b0:7fa:e23a:906c with SMTP id
 ca18e2360f4ac-81f95aba774mr2449971039f.12.1722444009325; 
 Wed, 31 Jul 2024 09:40:09 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2601:284:8201:81c0:e862:e2c8:b714:e7fb])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-81f88597d83sm387013739f.6.2024.07.31.09.40.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2024 09:40:08 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <bcain@quicinc.com>,
	<qemu-devel@nongnu.org>
Cc: <quic_mathbern@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>
References: <20240731011254.1961048-1-bcain@quicinc.com>
In-Reply-To: <20240731011254.1961048-1-bcain@quicinc.com>
Subject: RE: [PATCH] target/hexagon: switch to dc set_props() list
Date: Wed, 31 Jul 2024 10:40:07 -0600
Message-ID: <05da01dae368$4e36f760$eaa4e620$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHmEFxsMShejbXZ0clDeoIJw82b2bH6r8Aw
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd32.google.com
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
> Sent: Tuesday, July 30, 2024 7:13 PM
> To: qemu-devel@nongnu.org
> Cc: bcain@quicinc.com; quic_mathbern@quicinc.com;
> sidneym@quicinc.com; quic_mliebel@quicinc.com;
> ltaylorsimpson@gmail.com
> Subject: [PATCH] target/hexagon: switch to dc set_props() list
> 
> Define a hexagon_cpu_properties list to match the idiom used by other
> targets.
> 
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>  target/hexagon/cpu.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


