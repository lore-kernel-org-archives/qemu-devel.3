Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7869AD5B16F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 09:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5i9N-0006vV-Uv; Tue, 29 Oct 2024 05:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5i9H-0006uj-Ii
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 05:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5i9G-0001na-Bs
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 05:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730192660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=BS4TD/+Z7P4ygBJ0pLLXFqoq3raVYgYFXIY0ssVkis0n52aFz7/TfDiKyJXMaiNk/NEWVU
 KTspZ/fvhHcoHblbndMVGIl1aAL1cZrWeAwvz0CcuKjOD672Sz13gTGgNi2wCmXKD71DXS
 ab9EBZAY79VC6I/zlw1sKTB2+UTR7W8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-hT4dAiUmOSigHipSsZaHiQ-1; Tue, 29 Oct 2024 05:04:18 -0400
X-MC-Unique: hT4dAiUmOSigHipSsZaHiQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4316ac69e6dso40270885e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 02:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730192657; x=1730797457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=QdkX/LMlUGrXPJqatEDGsStsY4XuHX5slfvhJyprOD+drw/UyLr27rNg5mJfLGst2Q
 IvWJtd4MDFpqlvXULWeb+Vr+iI6UhDYhQ8p0UNu3KQdVPDru5qlo+AAokPm9LHOhTPiX
 JHm0nyoHO7IeDBoZxK7nwJDQmA8plvvJkc9WAIZe3WkMI3sRAZdX1NVu5p/4I0S5KZFm
 XNhe4ITXCDB1pe1h1XNo9h2HImeio4fQhxRwJfK6TS5GAoIXOB5lhjh9dTR1swOCJLvM
 Jlto4RPkb4drZ6Fh8e0z0IWz5mgX0vkBxcbltqpr21RFIxskjqTVcNZMRF67RhgA5eI1
 mgqg==
X-Gm-Message-State: AOJu0Yz60YvSxXOiPPRguQ+JxsLxfX2NoqII09CgQ0nqS/zElECQ8q77
 P+Ky9mwaLWSX0J8ZHwPpsTCeP7Ulos/hJzuZEKXqRYxLusDxsXZXRU7rvzqBYtwr2yXTRSZSiM9
 c2DmJF311SBzlj3OfOnRffrvIdFsUPDxljHPROwvaSmIfUc3bmjsl
X-Received: by 2002:adf:ff86:0:b0:37d:4818:f8b1 with SMTP id
 ffacd0b85a97d-380611e493bmr7322781f8f.39.1730192657216; 
 Tue, 29 Oct 2024 02:04:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESXjs3sJWhrcR6JLn9ghHmd7Xk43+lLlB6QMGLDX0tFBcUsqtD7e8fvNgcVZhZ5K5Nk6BmcA==
X-Received: by 2002:adf:ff86:0:b0:37d:4818:f8b1 with SMTP id
 ffacd0b85a97d-380611e493bmr7322756f8f.39.1730192656846; 
 Tue, 29 Oct 2024 02:04:16 -0700 (PDT)
Received: from [192.168.10.47] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b132ecsm11959729f8f.5.2024.10.29.02.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 02:04:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] rust/wrapper.h: define memory_order enum
Date: Tue, 29 Oct 2024 10:04:14 +0100
Message-ID: <20241029090414.450707-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241027-rust-wrapper-stdatomic-v2-1-dab27bbf93ea@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


