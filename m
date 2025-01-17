Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6A9C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 12:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYl43-0001iL-8C; Fri, 17 Jan 2025 07:03:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tYl3J-0001YE-TN
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:02:19 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tYl3I-00024z-Af
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:02:17 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3862f11a13dso239990f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 04:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737115334; x=1737720134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5Wn8IdIujOf9r+OIV59CwZZpGZD/iuYJPnVCpa5bUY=;
 b=JYqfPJU7YZVYbMmVUhOGjC2Jlnf8XAnWu0uRmnSq7VzNOR+2ZftHPB3k4J91sfYxD1
 ct2rM/yfLAgis9FhwyP9por1w7G/dfPAf9hXx4SvWOzY1+eh8el3lv3Lt5vHt9iyM4BW
 06Symy9wwmsCuJbMb6KXNJPR4N664O3wXGAKkKdeLSkeYnKaYw1Z/XeP0fK2mDyvfTns
 fJd/IUemNYX/jSr7j1EfEPp/+EwiHV0atEMq33sGAyTQEA4rpiBqmilxf+qmhyJBQq1r
 zztD0Dqau+42V546JgusL/ulO06GVyVwOQ7C25yiGA3F9Bj7OGvZK+xDSRROOVDaD+tk
 bnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737115334; x=1737720134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5Wn8IdIujOf9r+OIV59CwZZpGZD/iuYJPnVCpa5bUY=;
 b=QXHPQWc1FWtp7gp65aCf18XABgbXcVIjevw4tSAfZgjeYOYQgCEOO0PgDvArtWUt3L
 vyNvHMAsjCNwnFxSqRlHBRsxXv2XWogv/OwKqyVEb5pgrwpRECgHJKZOxfSI+FCk1gOX
 KYik61Cj9VbnadjGWM75W5HFIBJVYlqAMWtrHMFoUMUmBomAAEZMeuP2ZzsQZyVw5KjW
 cXDkLeqlUQkqMsULN/dsdSx14Ip/S5VJuZNpi/oho6aaJd8sq+S4LSxh186//imDZSRw
 XvmsMJYIK0jiIqT2piFKibPoarvfz+li1tkznIqMLZ3EMKrmQWmYMVAV6yOUxlYoiznY
 EAcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlgAsg+s4uieZwcr7mBBKOIZPZJSnCsHuz47L9H38NmQYMWnNQSANvhIkGD4vDTonk2qUbW0zaoFo4@nongnu.org
X-Gm-Message-State: AOJu0Yy9F23+h0fdC8TACYrWoiS+q0y/enOLYO13G5jKNLSLDMMmJoUE
 1NAh8FX+deRD1wV34otKvm/bJmJAwDOdmGe+EGQPWXn5rra6ltyF
X-Gm-Gg: ASbGncvGbUa2mvaBcuJFfcJyvooC7oAIADEqJzHceVbs1GXZDq5krFw6OcOJXpzxqyo
 y04bv+LRpRO3+1LaqTQaJr0EZ8bD6q3lmYI+a31hmqLk3y0IrGwXBruWMMJhydYZMSDBrzmMGpv
 TdgsiI55UTqQTq83JHsFO9BhaEw+jZoOBp2WcqY4nelBnTzCU+HGNkALAE6MUbZP5cRoR85JE7O
 BtMra5V+XdmUwP+wuPnnvJLEopbMHgUNULoFq5CEWlI91yHYhTThfgtGaKZ0ZfZM1yghOH18k/U
 mlNy
X-Google-Smtp-Source: AGHT+IE8Xz2TxvvtqWQvsCzdb6xLty5gf6aKmtIsS4iyiWQIYcUAvomwujW8DvHchTH0Rx8a6NDkCg==
X-Received: by 2002:a05:6000:4a06:b0:385:f909:eb33 with SMTP id
 ffacd0b85a97d-38bf57a9a78mr931425f8f.10.1737115333666; 
 Fri, 17 Jan 2025 04:02:13 -0800 (PST)
Received: from L-H2N0CV05D839062.. ([79.175.87.218])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38bf3275595sm2360702f8f.67.2025.01.17.04.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 04:02:13 -0800 (PST)
From: Aleksandar Rakic <rakicaleksandar1999@gmail.com>
X-Google-Original-From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: rakicaleksandar1999@gmail.com
Cc: aleksandar.rakic@htecgroup.com, alex.bennee@linaro.org, arikalo@gmail.com,
 aurelien@aurel32.net, berrange@redhat.com, cfu@mips.com,
 djordje.todorovic@htecgroup.com, fshahbazker@wavecomp.com,
 hreitz@redhat.com, jiaxun.yang@flygoat.com, kwolf@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, philmd@linaro.org,
 pierrick.bouvier@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/4] Skip NaN mode check for soft-float
Date: Fri, 17 Jan 2025 13:02:08 +0100
Message-Id: <20250117120208.795738-1-aleksandar.rakic@htecgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211151737.87765-1-aleksandar.rakic@htecgroup.com>
References: <20241211151737.87765-1-aleksandar.rakic@htecgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=rakicaleksandar1999@gmail.com; helo=mail-wr1-x436.google.com
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

Could you please let us know if you have any comments
on the latest version of this patch?

Kind regards,
Aleksandar Rakic

