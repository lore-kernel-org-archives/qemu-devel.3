Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C41E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLOQL-0007kM-QY; Wed, 11 Dec 2024 10:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tLOQJ-0007kC-SY
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:14:48 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tLOQI-0007FC-Bq
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:14:47 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d3ea2a5a9fso471047a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 07:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733930084; x=1734534884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DkFMQ5IUpPXHbUyHcc5o274RRCN41gtiFzl1FIq7oKA=;
 b=HwXzY+Etg67AWF1sdlhJN70vPx8hncJlV5GLbRuFkE4dThmJjot+IMWSYL03cLR5eQ
 /DutPbhAKp3aByN8jay4cuM364iMSgyIEbyFPnS6zoCSEt76iImMbjtuuIGC3ltzQ1bz
 c6Hr6lBlyft8lWU2YDOd36la5OgDkslH/5tZ4Pzem/6/GPz/XIUTB5DxxfQlxSOnSTHf
 7luuJvz4S6hoIT1+TyMNymEBSkVh/5lTIrjBaDO+eMYL6klwTTRl/gcbK+jii3UGZ0KL
 +FPuLZssKkNjd/FZ4Hg+D0V3fn3uMity28yNvhpjIkhKBa/l93x1jlLeZpj+xQGEMbT+
 37Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733930084; x=1734534884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DkFMQ5IUpPXHbUyHcc5o274RRCN41gtiFzl1FIq7oKA=;
 b=oxx9oaUtrXbHcnEqS0D+HfLu2y8X5ntXvlpj4mAikLyolweoddEAqEOPnCbW+wqROg
 0uw05u10mpLVRyEGKtR8mSP3dSVvPz4Z2meZYzswaPx62KmZNT/mZgkIwUHj6nKb/a0F
 3EtKhNsCK7g7CnErJTnxh/ujoZCm0bJihAZPV1HS3rzA+VOk/guLieCzeBfi/DTm8kDp
 yaXXO5ZYhCWGUe3sqZOgIDkuaTYo7IXfTuCMCZwfxzM/t6CTyuVHQoqno06sVzr+m7Xa
 /GphUkg6JpkscNJf0UB+5+4R1H6taMWxmOotisMNrpv3SAkEvafmJtsZNUEuYBe7Icew
 FSNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx2rDLGxDvuNOm2PnOq+GOns/KyvWtbpkux7qYOVxA2dBAjRw8+rDafocdcagKiRfHan7oeevpmbqO@nongnu.org
X-Gm-Message-State: AOJu0Yydrv6TMUkr1vuBpObyfGmEHWeskGGB8KQiseu6M3VcZ17w4mko
 eRWCVdqmHs9/unqKl98ThI8OzuAgoJw/lJW7JTfO/56VpYF340BO
X-Gm-Gg: ASbGncu41aoTfrrJjR4Of3MpZFBitVYijok5dxCf2poXoISm9hNhJOdjmtZJYv48SD1
 eCibpv8VAki4RsI/7ueOAA70hMecbZx3itXWAAAAOt8ex9LJK9D/cVCtWZ56VH+v7pcsu0TfriY
 4JCRKNkRB72PqR3m2Q6PXKqAYvwdtB6t7wnRhjCzqM8C6XjPtBnMh0hZidmU2HMTR0VgWt4M8Gl
 QU1tdOEQj2qY5y4w8B9ZbuqwFQM5QhlmQdiCdsGgENLvrLvFJiA1D3ymiMi7aywLwXGaZbgewgQ
 fA==
X-Google-Smtp-Source: AGHT+IHfquRmoLW6Z3IFjs+yK/D1C+BHlFzPjxPYwUQWdSZp+loI2FX5s026pGYTVF62aY10qcKsjw==
X-Received: by 2002:a05:6402:3484:b0:5d0:e852:dca0 with SMTP id
 4fb4d7f45d1cf-5d433192e50mr938294a12.11.1733930083365; 
 Wed, 11 Dec 2024 07:14:43 -0800 (PST)
Received: from L-H2N0CV05D839062.. ([79.175.87.218])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5d3db53b828sm6676669a12.74.2024.12.11.07.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 07:14:42 -0800 (PST)
From: Aleksandar Rakic <rakicaleksandar1999@gmail.com>
X-Google-Original-From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: rakicaleksandar1999@gmail.com
Cc: aleksandar.rakic@htecgroup.com, alex.bennee@linaro.org,
 amarkovic@wavecomp.com, arikalo@gmail.com, aurelien@aurel32.net,
 berrange@redhat.com, cfu@mips.com, djordje.todorovic@htecgroup.com,
 hreitz@redhat.com, jiaxun.yang@flygoat.com, kwolf@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, philmd@linaro.org,
 pierrick.bouvier@linaro.org, qemu-devel@nongnu.org, yongbok.kim@mips.com
Subject: Re: [PATCH v3 1/4] Add support for emulation of CRC32 instructions
Date: Wed, 11 Dec 2024 16:14:26 +0100
Message-Id: <20241211151426.87373-1-aleksandar.rakic@htecgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112164130.2396737-3-aleksandar.rakic@htecgroup.com>
References: <20241112164130.2396737-3-aleksandar.rakic@htecgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=rakicaleksandar1999@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

A kind remind/ping on the patch. Before we send v3,
do you have any comments on this patch?

Kind regards,
Aleksandar Rakic

