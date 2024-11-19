Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD886D62077
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 17:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDS7v-0004O5-50; Tue, 19 Nov 2024 12:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDS7t-0004Mi-3c
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 12:34:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDS7r-0006Jb-RN
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 12:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732037694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=i660Gj88KHzY5LMWBRxsK1qNmsI0dbnUjZpUFAm2xR8+/Mv0Gbuy0oOUsjX5QTki9KLITG
 x0izFIAIFsWFHBwfHHevK7Dh0/s39gGbZpkfzZe7UerbLfuwDeeoTc/U+l/nrka2PMuXau
 GfbOajof4my+Sk3q4REl+fJldpGtOwE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-EPUgk1uANPCeX9PhNIbEsg-1; Tue, 19 Nov 2024 12:34:50 -0500
X-MC-Unique: EPUgk1uANPCeX9PhNIbEsg-1
X-Mimecast-MFC-AGG-ID: EPUgk1uANPCeX9PhNIbEsg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-432d9b8503cso108125e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 09:34:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732037689; x=1732642489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=uPy5Dt2tHwU5ytsBOJxOyFPV83aqt/Pq/bI6yRXsoAk87qZPJ+bxTlJoC9mSVAiR9b
 Q1ene//ISYh31PxpATyc/39Au0N6B01XLFHaDpkLLm+ktpnAUwW4tOT36PHsvx0SGzNQ
 hzic50/MIY0sYYz6uSqqYix2veYILteedx1L5+7vlKtxdGVBXN9CjUoav8/1emqgvdDD
 MZdZstm0sdL5oNQJLGG1R3+uECA1vHhh8LHlFWOEaOg6VjOGvG83DomFRtRcAkPSk9Y8
 W9hX/6wN2Wi3Tj/uQw5afXE1Y383qDWPdTmL/sDz3ZgQL1FqCQ4S1r2efMGNW1NNam4s
 YsAQ==
X-Gm-Message-State: AOJu0Yygunt1VLaFNb6+D7Kaf0/RFmKfHzAKlT3WfW7uTk4+rm/hURqq
 UgdPSvSiO9nRwS5TEcX7DTdSYzvP8WCekmr8t7/xuG6RucPJV79zQjFqdoKqweJ3eaNaRAyEcc9
 bIVKP0Kcxld+e4UsUgaeOfmaV/ORbGH5BUnldXwJ/uNLyg35HlXkm
X-Received: by 2002:a05:600c:5008:b0:42c:b603:422 with SMTP id
 5b1f17b1804b1-432f57be31dmr34922605e9.8.1732037689375; 
 Tue, 19 Nov 2024 09:34:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtfd25DjLwF0AO2dKM9CYRJvlIv6Tr81sIvIISI6kA4sGivptS1XTr378fy54h/ClN+YbQuA==
X-Received: by 2002:a05:600c:5008:b0:42c:b603:422 with SMTP id
 5b1f17b1804b1-432f57be31dmr34922435e9.8.1732037689073; 
 Tue, 19 Nov 2024 09:34:49 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da27f4f8sm200818805e9.18.2024.11.19.09.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 09:34:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 alex.bennee@linaro.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Cameron Esfahani <dirty@apple.com>
Subject: Re: [PATCH] hvf: remove unused but set variable
Date: Tue, 19 Nov 2024 18:34:45 +0100
Message-ID: <20241119173445.54684-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023182922.1040964-1-pierrick.bouvier@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


