Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C965D1266B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 09:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8FVR-0003FI-7u; Tue, 05 Nov 2024 04:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8FVP-0003F2-3P
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:05:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8FVM-0002Tl-BT
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730797539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=XwuZzBbIYKMV8ZFmcEFg42G8DeQkh3gaGdAvu0VnIc8SkEdAsZY0jDNf0djehs8CdhthbM
 3inScf1BDLnEp2oVXejHJsMD5LqMWM5AzpKDJRR0TqK983ppqcgbkfgfp4DpfpiblMtobT
 /LqaCBCVs2swDPitLBsankfRRquK+Q8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-gJZRY6XKMACoe90FBnIKOA-1; Tue, 05 Nov 2024 04:04:31 -0500
X-MC-Unique: gJZRY6XKMACoe90FBnIKOA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-431518ae047so34042815e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 01:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730797470; x=1731402270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=GosH3rEzmEJBqQ6tBRXhZmxGS6w97UPiCmIpHRaI9ff0i9ajt66MWOmFTuDqV36jrd
 DMAVPS9S5iXdJTUodcX5RpYrdiIkHic3qBxj/uG0HCAyO8HdL2rZatA5ZmbEcQAsMO9P
 +XCBMojjol0Iq+94oDt0LqzcpuLipA1x+6A1Ep8o0seg5BoF0qNNnk/PoUaKVXnHVdp/
 kTPatQlWhIqz6fvNf/IgzHuNEJrGUg6CkfcKxpZ27ETMTbWM8S1ugrq9bEEP8aPq4QeG
 GLm76wkA4kO9YvCymQGM88NALhYXyKwmx+RQ3vExP4bogxB90IrT3D3x7ca7KkgCVGKg
 ZB8A==
X-Gm-Message-State: AOJu0YzS67JxKmwUDfRTEex7l18C9Wwz18zSSKWzCjB/VbviDTpA2xJp
 yf1MTn2MkTgU8pZwTCo1UvCNQAN7kGBQVuJqSbGJJni4Nar7GOTsmawLB09gN0d2o5KTADZ7Q/3
 lOm3WA/rBt5NhIaZO/F9iafVapStJP9XTYY3kM6SAtuaospWQS+d+
X-Received: by 2002:a05:600c:3150:b0:431:3b80:6ca7 with SMTP id
 5b1f17b1804b1-432830849dfmr130609815e9.13.1730797470260; 
 Tue, 05 Nov 2024 01:04:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGODrEWT0Ao6ft3tOCtL23Sc4QARV7FK85RwzZnjBda+O3PB4DhqpbrUlX3skus8z7Rpy36xg==
X-Received: by 2002:a05:600c:3150:b0:431:3b80:6ca7 with SMTP id
 5b1f17b1804b1-432830849dfmr130609555e9.13.1730797469933; 
 Tue, 05 Nov 2024 01:04:29 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d6852d9sm180678675e9.37.2024.11.05.01.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 01:04:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>
Subject: Re: [PATCH] target/i386/hvf: fix clang compilation warning
Date: Tue,  5 Nov 2024 10:04:26 +0100
Message-ID: <20241105090427.235762-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104222102.1522688-1-pierrick.bouvier@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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


