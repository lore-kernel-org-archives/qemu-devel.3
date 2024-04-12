Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBA9C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 10:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDkG-0003XT-DB; Fri, 12 Apr 2024 06:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvDk0-0003RN-9f
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvDjq-0001Ic-L1
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712916149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=N9N2+Xw9+uZzy7RtpdGbmDGGzem8GWGnYm5T5wPlRSvPLV0mjzfXpUeF7/vqEcWwcVElPX
 wHCD0Sdoo7G53h8ipsWuXZNNTN5q7WTA2tfZTvrI0cXcltBfY6QdLcdc4ZPmnq43t7Vni5
 haJRSojODMLDcuZc76CFjSSwMFoTqck=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-p-uOWQ7zPJqoP1SEaqJz-g-1; Fri, 12 Apr 2024 06:02:28 -0400
X-MC-Unique: p-uOWQ7zPJqoP1SEaqJz-g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a5199cc13b2so76905766b.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 03:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712916147; x=1713520947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=wcmgYCYMr370s8kitQq6q9p4rHKmwqj8+oiBB9hWP5EKr78OApGHQetwDl0WCgTujj
 QNzlj3kBpY013jg7HSgc1uxMZ83Q2s4yYyq009rOrlZs/J1p3mDLMbCQ7PnpoIy00Obu
 Rlo/dZuIC3Rk/az4Z38VXEWaG5hLRKOR2WN11b6GsYTJ14sIJSynllpqTjrHaGolklXO
 p0dzJESRRklTqcXkHV67vumGX7FUsRrG7ZL3/TqP3jO4J2t3GvT+n9dlXVLlmyeQkMkY
 1BvMj8x+G4X1BaqrNuG/IqXpzGeeAFq8LKUUntVtdRRZVJkwMSE0qj5jHvRh3Oo6UynG
 VfMA==
X-Gm-Message-State: AOJu0Yz8CJwFc4ty3XgXwI2nO5ffQXGJNKGuUxtGmSprQycqpMNmhxhX
 0pGVEt7+GixdKhBjIzccWVHJCz6CU8PPg9H5x0lbSqozLYF3pQ6pRWSu2Sf4Z0U9OU9yyZX5wpN
 kEggNZPS0sgpc4ptgySemdMWut8/JPeGe06hhYH7zMPaEDQb7z70a
X-Received: by 2002:a17:906:2809:b0:a4e:946a:3b0a with SMTP id
 r9-20020a170906280900b00a4e946a3b0amr1418518ejc.34.1712916146584; 
 Fri, 12 Apr 2024 03:02:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYeNezYXD1U9Wrp5QFEMcb7tlU62WLs3CvWdJhBHuPqXfamXQaiq0Wlz1DnQzO1GCzLdr2HQ==
X-Received: by 2002:a17:906:2809:b0:a4e:946a:3b0a with SMTP id
 r9-20020a170906280900b00a4e946a3b0amr1418504ejc.34.1712916146217; 
 Fri, 12 Apr 2024 03:02:26 -0700 (PDT)
Received: from avogadro.local ([176.206.87.39])
 by smtp.gmail.com with ESMTPSA id
 cw4-20020a170906c78400b00a4e58c74c9fsm1630158ejb.6.2024.04.12.03.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 03:02:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH for-9.0] meson.build: Disable -fzero-call-used-regs on
 OpenBSD
Date: Fri, 12 Apr 2024 12:02:23 +0200
Message-ID: <20240412100223.19898-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411120819.56417-1-thuth@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Queued, thanks.

Paolo


