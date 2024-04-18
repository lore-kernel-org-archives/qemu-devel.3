Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10ED4C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 10:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxPM5-0002km-1y; Thu, 18 Apr 2024 06:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rxPM4-0002kc-8L
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 06:51:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rxPM2-0003Wh-65
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 06:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713437457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Nu/eCXRyNcZ2CQYvzalXFY8C+ATGw/U0ghj2w1W9xmf3hFTWGc66y35qLUiVbBuJYR2wOH
 DluDFTxRc5VRVKxtXxhGjF007W1Zozka+/5BzZ8Ar+BEX77InJc6G2fBPi8QpbS6nPmuCE
 gN7eGi8wZtZ0SLM4C1+iYqoGoyAxlfw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-ibNYRYaNMj6IU7sg4WVfkg-1; Thu, 18 Apr 2024 06:50:55 -0400
X-MC-Unique: ibNYRYaNMj6IU7sg4WVfkg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a524b774e39so86172166b.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 03:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713437455; x=1714042255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Qxxj36YLOmzspIERdPSXinNj0LFWuLjY8jBtFBL3jKqSboQAtcpqhO4QCzeNQL4tK1
 Aft4QaY9EWLhE08l7tbXZtK+5qb0AYH98cQRycWBZbtZGkaUj1O0XLko32BhkTb+Lw6b
 /fZn8opNwXQZn+3velxNiA2OvP2l+ZkcPRfUjFyn8uqqJ/Fz+DZCfGyWCyejQBqXnLxm
 s4lE30K6NX9yNgxwKN1bQr7vjoMdjEIsc7y/OkMJGfzk2siG4zi891gVumyNoWwYVqyL
 eZbVobq8bq+MuipS8Gc7Ap6UHOp5GABaL/GpIOD7VVWpEMEBSgmVXm5cPCHeCRS1qWzQ
 03ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ4UYNN97pgayhY+sP6od03/3t2wHk2RfILmjX5PZOlYE79OsqY9PM/TQEtxEwA0s6Bszcu1mQd4Fli72GU1wFqW0qRDs=
X-Gm-Message-State: AOJu0YysujMRXbuuefv7wtAcsVAL6AUuXbBBHot4Lk7k2+2vz18m5tat
 jwzG0q7dPp6ZXNji2jkBI+YOvyN1mqBNLmyUvvaN5DEIzY0O++eIgdb+OmwnuQJmKxurI8eGiqx
 8xVOhlx/54qf1KZUpdZ/ZQR4cSJqFnU+AsPZVfzmiEgYu31XDlT8/
X-Received: by 2002:a17:907:2d90:b0:a55:3463:ce54 with SMTP id
 gt16-20020a1709072d9000b00a553463ce54mr1865307ejc.8.1713437454931; 
 Thu, 18 Apr 2024 03:50:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqfHxff7+rBntXv9CoXYnoQ58cPUlzL0/N+eLP4evlPnzseDWLDyH8gpN8Sucqe4QcLLXBUg==
X-Received: by 2002:a17:907:2d90:b0:a55:3463:ce54 with SMTP id
 gt16-20020a1709072d9000b00a553463ce54mr1865295ejc.8.1713437454574; 
 Thu, 18 Apr 2024 03:50:54 -0700 (PDT)
Received: from avogadro.local ([176.206.84.58])
 by smtp.gmail.com with ESMTPSA id
 qs29-20020a170906459d00b00a5197fa2970sm721980ejc.25.2024.04.18.03.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 03:50:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] accel/tcg/icount-common: Consolidate the use of
 warn_report_once()
Date: Thu, 18 Apr 2024 12:06:21 +0200
Message-ID: <20240418100621.25379-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418100716.1085491-1-zhao1.liu@linux.intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

Queued, thanks.

Paolo


