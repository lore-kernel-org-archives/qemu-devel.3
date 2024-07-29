Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CC8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 07:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYKvk-0001HQ-09; Mon, 29 Jul 2024 03:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYKvi-00017V-9N
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 03:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYKvf-0007HV-MS
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 03:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722238579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5iySVyXd9yunlQx0WJsgUFIo7SVF4MwzJZaQMZrWmFk=;
 b=U6TxjXEQW8kblcvGAHdw1iCMjYeIJJvw5ivaAa/Ie8mi1WCijBRLMCBM4imQ9hDjRcc/s5
 G5rABNufXWsrD9h6W6lHvL+zVpFVyBi8asbOQ+2S5PLGeB5pfiq0g+bMFI+lcUpxJANzen
 3rJ1pbv6ijtFtBVUSsowVCMgLklmzgM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-xCsJLLYCMSqrO48lDWRF1Q-1; Mon, 29 Jul 2024 03:36:16 -0400
X-MC-Unique: xCsJLLYCMSqrO48lDWRF1Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4280cf2be19so14298485e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 00:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722238575; x=1722843375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5iySVyXd9yunlQx0WJsgUFIo7SVF4MwzJZaQMZrWmFk=;
 b=MCLeTD35k0kUrHJcFyz8GKu7EW/esEPv+vw2oHTXTOyPmp75+a5mJ+0Igp/uyb8qHT
 WA6JsBYm2dv3Bhdi69om9RMwHuarBjgvNghDeHgjhRM31mDC68SAH64Csk4PCfgOjP8Y
 udeKI++Dwyg+NyfyvJSvHYDJcSMsrB2FSFtSIwkwLvRFqILv08agDg+ueRnjg5tnaUVW
 HsjWYQwxJLjZGKCQyGMfLT9M3wmQvNA4IATq1SfoxWV1Vt9/PQLJfl+W5rDQC0kZ4znT
 JHhTuZw+qGhHIhZWMKmZtfXPr5RJSc0d9L7f9OWJLlt40ZBucysFuHyi3PkIfwWfPVPa
 UWEQ==
X-Gm-Message-State: AOJu0YxLWG64+t0iVVAT3xnvsk9/bTt85h70HhrkyYqmMOmaYnmHLnBm
 40YnGe5f8vKSS2A+ySyXe14dLR96wKMlk4djMqJxdZjSMFvpGH2OslRHuBAZopK4+3TmTiske1O
 EeAd0CzHm0akDldq2rCY/2gMbX7jdicvNjWjp1NnzRQVL+coEKa7r
X-Received: by 2002:a05:600c:4e54:b0:428:6f4:57ff with SMTP id
 5b1f17b1804b1-42811df95c7mr41674055e9.35.1722238575497; 
 Mon, 29 Jul 2024 00:36:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpzLC8cjLsPB4X5yE+0pvdQNBEd8/+lqDM1cjsq5TJSsvk9cTfvogeRZPdivUYtxkvzePQ4A==
X-Received: by 2002:a05:600c:4e54:b0:428:6f4:57ff with SMTP id
 5b1f17b1804b1-42811df95c7mr41673925e9.35.1722238575026; 
 Mon, 29 Jul 2024 00:36:15 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42805730c3dsm169532025e9.7.2024.07.29.00.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 00:36:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
	alex.bennee@linaro.org
Subject: Re: [PATCH for-9.1] tests/vm/openbsd: Install tomli
Date: Mon, 29 Jul 2024 09:35:50 +0200
Message-ID: <20240729073549.14715-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729051244.436851-1-richard.henderson@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Queued, thanks.  I adjust the commit message to point out that
OpenBSD still has Python 3.10 (tomli is not needed starting from
3.11).

Paolo


