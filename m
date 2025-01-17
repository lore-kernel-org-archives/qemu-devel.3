Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9722EC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 12:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYl2C-0000qR-6Q; Fri, 17 Jan 2025 07:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tYl21-0000pg-Uk
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:01:02 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tYl1w-0001v2-9i
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:00:57 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3862f11a13dso239787f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 04:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737115239; x=1737720039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5Wn8IdIujOf9r+OIV59CwZZpGZD/iuYJPnVCpa5bUY=;
 b=NpdKo18etB2IetiMQiHAO7Rn3WpxFf661f+oalN5Yka3y5IcuEk85RJSLi8mvMoJrR
 0EMdsBqHfQNSzqxzAZ4tFQAhWs9bfv9zNWQqhzU73RnF8VrHJ6e1F8wILKtsBCXkhGU0
 l7pmaNPagbg6K3Vk4ic0EGx2gJ5vX+ZMK4y2xhkHgPR9C5q+dGNYDHxM1r02+ucELjEd
 ckLOurAg926DVAN1RvOFJSwm8kga3Ww3OpdVCSxjOxoa7uvwk2WrEPcjcVgDuf/KgnLs
 TRckPlrEjz23svSwnTkn3el+HrGivTjt0uyn0w0vCZSyoX1nGbTdYbCO1VjbREd5kf3C
 MwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737115239; x=1737720039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5Wn8IdIujOf9r+OIV59CwZZpGZD/iuYJPnVCpa5bUY=;
 b=qFLB4xGIo2+kCmCdH4x0O2M29okr20R5nsEYOdavWciuQ1IZUDekNYbp8urS5ydhkS
 hVtJwWA+++co/SjfcOWRIj/xWepYwsAGM4+r3Ujx+acLxbpBfAsBKLR1fQh6+q9vXn7v
 xTqAwQuKsBkenSRsr31lu7pRVhX/3ttdNkd/T5puY2/iypiwSXW1kcPe7xVG/FtMLpQT
 vQ2iROQe0aHxyQ6OZvecLjyRMqEJ0GXWnW/XaW9I9yIgfVjePEHKUWOQ1kaacIMH+8MC
 Fgr/asLlNEtxVYslMhO2HKLcT8aG7u19wJeTF3mIzyTk808okJYM7LlkCFNvwStwlm0V
 zmeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQH2clB36hdv5ywUqvlPRSOIKumkq3Dsxt8o4TFKvbBBMWtWpfmrgfqjeU1tkmP3OP3IqdQ5+SHSES@nongnu.org
X-Gm-Message-State: AOJu0YwALnNWsMnY12645cz99idPG5YZbi46JvRLeVlJL1jxVDJV26x5
 tyGEmDZyrspb3MJQfLSBHVubewNmxXs9d7Xxf+q6OuGYyeffsyst
X-Gm-Gg: ASbGncvt9ibH7qCtKnKH3plY+xmyf2+rvSA6jVMq3m7t7Acm09aDPy5+ueXcSZF+50Z
 LfEIGbGAFDEEGFqV/nn4rK/ZD9Ky0OTCeDOr+A7UG8G6ycHHHBbU+dQ45gqOkAikQ/OIA/S8B0A
 W5W8GsFeURdG7uArARgpLsCnTE4kehJ/PVn3XqeoQpMSKBRFmEuUlTT0lEoKldUhMJDLMmyItQC
 2JWzS9Sm4uSD84uYJ83PyGzy3VKNo306DKoIFgWhRJ2jh91m0mmFtbP/WslPYBNpDWoBtvMDNrx
 khSX
X-Google-Smtp-Source: AGHT+IG6LWnag+IxFRrZA95rHwQcT+9ocmhPc4ZmVhb1DBs2YxOrcEYoFGAoJTPyDTspHlQa3R3+qw==
X-Received: by 2002:a05:6000:2ad:b0:38a:888c:6785 with SMTP id
 ffacd0b85a97d-38bf566b484mr726632f8f.6.1737115238829; 
 Fri, 17 Jan 2025 04:00:38 -0800 (PST)
Received: from L-H2N0CV05D839062.. ([79.175.87.218])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38bf2fc5caasm2382574f8f.0.2025.01.17.04.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 04:00:38 -0800 (PST)
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
Date: Fri, 17 Jan 2025 13:00:19 +0100
Message-Id: <20250117120020.795440-1-aleksandar.rakic@htecgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211151426.87373-1-aleksandar.rakic@htecgroup.com>
References: <20241211151426.87373-1-aleksandar.rakic@htecgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=rakicaleksandar1999@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Could you please let us know if you have any comments
on the latest version of this patch?

Kind regards,
Aleksandar Rakic

