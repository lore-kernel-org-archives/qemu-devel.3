Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4086ED15D82
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 12:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2rMP-0003fE-2Q; Mon, 21 Oct 2024 08:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2rMB-0003eA-6l
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 08:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2rM8-0006e4-Vu
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 08:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729513071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=YN+0MLQSSKM3ahe62QfJMBXYHNPJw7Mpc0BqT0MZ8h7b+2cx69YXO5NN8Avu8fdTuldJkb
 edsUEoykI/uxu7wRLD7yDGQSjSWt/9jvcDi9ZIItj4R1TB3CFwjEiBWy5B8Perief/wZfr
 MHex6jFhWqrpyKygCq5MGqXfOuZ5zwE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-e3cUT83ROyWu7bWWLcOC-Q-1; Mon, 21 Oct 2024 08:17:49 -0400
X-MC-Unique: e3cUT83ROyWu7bWWLcOC-Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4316e350d6aso11342145e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 05:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729513068; x=1730117868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=eo+MscQqfjC3bVkKV8+acjg6MLRasRAh740RN3qNlo9TBxdeZ9XKdKkAl/zlV/qzAh
 STUNcIHCMOUKwAADpyOpvZWfZVmW0GhB//iwHwW2bCudsx0Lj7/xn7A7JTgKNdNXcam+
 1WC/s8E2/9od7pEyn9gaMGs5pcfV/5kj4N7+dG4yTYQXCNU159O8xvTk3ef5TgvK18K8
 YifkEk/Nu6xE/SQp5zr+7yNs1iO+QI06Bh7QSESCeNg+odmMUd7sphFmIKt7Ev6VAaMa
 3J7IBk4cY2zH9ea3ssTzR/gsf53L+mgbi5aGlH3dbfU8KT6x+mGzn7T+z+JXYMdvYx7D
 geLg==
X-Gm-Message-State: AOJu0YxU+BLQxx7cxlcbWt1R58Pw+xzF1Awj1STQ4KxK43FtBqs+RhJ4
 CJrMPTRxNjjJSlZ7xbA1DwwLXJjJTUrCGp0bI3zr9FoLpTcv2HAxjdBSQZCiryvnyOdVV8PEu2a
 62tEyuX7Ue0fgHBuZ4F/3ngGM9s8d7ElL9HldcNvftACvqtX6fpzp
X-Received: by 2002:a05:600c:190b:b0:431:57e5:b245 with SMTP id
 5b1f17b1804b1-4316169a587mr90687645e9.23.1729513068537; 
 Mon, 21 Oct 2024 05:17:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt8kOAbSECHosQYvlfaW7ajtEl9YFIqo/DsD9T1Fss1ehzf+KwZ6KweDs1AYWN57Rd2+Tx/A==
X-Received: by 2002:a05:600c:190b:b0:431:57e5:b245 with SMTP id
 5b1f17b1804b1-4316169a587mr90687405e9.23.1729513068155; 
 Mon, 21 Oct 2024 05:17:48 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f57ff39sm56863695e9.19.2024.10.21.05.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 05:17:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, pbonzini@redhat.com,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] configure: Replace literally printed '\n' with newline
Date: Mon, 21 Oct 2024 14:17:45 +0200
Message-ID: <20241021121745.74014-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018120557.43586-1-kwolf@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


