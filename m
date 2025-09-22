Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA368CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 15:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0imi-0006tt-Q1; Mon, 22 Sep 2025 11:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0imd-0006tO-EJ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:48:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0imZ-0003V7-Ra
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758556129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eKa/gyNy1Luxk6nbfqDez1DUbKJUO6IOJr0FQF8y5jk=;
 b=U7dtWSa0jeVfIzLCbB7fm3QxkGZ07xsF8eqlFRjCcol0W8EoysAt8dmufYKe3OvVrNhC91
 1fOUsXJWYQ8kHCAyBdB3SwHfjtWpb+AUWMSm469o7M0qWlwy9e3v4gIOKdu8elLpufNar7
 kMp9/UA0kGCXjlaXjQJoO2JjgCQ31QU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-vMfTi9EKMWacyPt7HdS1dw-1; Mon, 22 Sep 2025 11:48:48 -0400
X-MC-Unique: vMfTi9EKMWacyPt7HdS1dw-1
X-Mimecast-MFC-AGG-ID: vMfTi9EKMWacyPt7HdS1dw_1758556127
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46dfd711001so8595545e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 08:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758556126; x=1759160926;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eKa/gyNy1Luxk6nbfqDez1DUbKJUO6IOJr0FQF8y5jk=;
 b=YD2eZY1YkuxvHKCs+FMWiedIc76ofACAiQZRBRhLxdlnzhD5xk5uIoz5YCXmFp/o/u
 UXhJvrx4orMmq/MOFD4+A6KQJhlCvQTvWNtI3IaOq6swo1DiJGsEcoxJDbOdi86oj4Eu
 H8mjLgKoij8MQ2Lv/d5kIQrUYk2G9Tu6s2qqQyEmanvbc4F3UgON6+bu25nMkTiAQ20w
 RTy6xJ2kvmm9cNrbrtF4T1s2eeisjHAeMR6J8aMZQakYtKkKcxyy6U/mO8tkePJQXQfN
 B4kXiNSoVmD4injSGiJB1pvgDkELQE2PsVbc2+c194WksC4HcGFD8vhRwYe7MvhypMSr
 +NqA==
X-Gm-Message-State: AOJu0Yz1jYHH8+bq3w1oOMtEJqTqJ281tZjmAMqNRzE1/4SA4rah06en
 6ZzhhR3OpUzpwIvzeJQ5QzW3bHss848KZAaJgkx5X1zsA/E/Y6d6gM0sDPJZr6FQ94VJbWYXMve
 maryD9HXpuxLNKQEX7trxpqjUX8kCEDDJvT+JWdA4TGgAwghcB+CvWpTDkXZKcD5KOU2ANyytnX
 ZufSqTlEOVPb4bi5GpxfwdOM5YFfTQKNod2+L8BpLP
X-Gm-Gg: ASbGncstTglDD2ab9NM4RQF40+kHJzWX8R4TbLe4wA2Tm7yzKc2plk2sv1Ou+uh4VOv
 LbH9fr59eD9KBgZJ4vu7mVnwLwri7lGk2w9NaLiPexgiJ087ZQl5db73DU2czUPaRYI9euKfoKq
 /oILaHd7TnzrYNmloZ8IoO8Qdmn7FQy3IxeXt5cMCniVW8RLMA9fc3gBhKdSJfHIrWQzhM9NCGS
 o/ZuN2+wkjTHkytCAPdOgEi9ekhUH2pCXRlkXBxwD7Km0Qywr+5BZ7JRBx6X7Kl4XDXkCo8H9fp
 V7Qh8rrRVjhEsdyfDLZWuJpLIGm8fylEKhEToao11OJxDW0O72l3DBr7cvKpwMou1P3TJZRk3yh
 sl/Xw/nG5PtQZLSHvO5DK3rjSfa2ikJpjTDoIQiT7VQY=
X-Received: by 2002:a05:600c:8b4b:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-467e7f7d89dmr107979405e9.13.1758556126057; 
 Mon, 22 Sep 2025 08:48:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElx5OQNmUMHO96LSgnRhx9iwVz2WGW5xxhO5tIkSWTQoSJCEM6O5922rnN7FQY4l4UmMGgHw==
X-Received: by 2002:a05:600c:8b4b:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-467e7f7d89dmr107979165e9.13.1758556125660; 
 Mon, 22 Sep 2025 08:48:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46d1c97a87csm52369675e9.20.2025.09.22.08.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 08:48:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/3] docs/code-provenance: clarify AI exception process
Date: Mon, 22 Sep 2025 17:48:39 +0200
Message-ID: <20250922154843.60233-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some changes to QEMU's code provenance policy with respect to AI-generated
content.

First of all, clarify the intended scope: the policy is not about
content generators, it is about generated content (patch 1).

Second, establish the exception process as what it is meant to be:
a friendly/welcoming discussion where a contributor explains what they
would like to use AI for, and consensus is reached on why it is credible
for them to claim DCO compliance.

To this end, also clarify that AI exceptions are a description and not an
override of DCO compliance.

While the RFC had a motivating example of exception, leave it out as
these improvements are useful on their own.

Paolo

Supersedes: <20250922113219.32122-1-pbonzini@redhat.com>

Paolo Bonzini (3):
  docs/code-provenance: clarify scope very early
  docs/code-provenance: make the exception process more prominent
  docs/code-provenance: AI exceptions are in addition to DCO

 docs/devel/code-provenance.rst | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

-- 
2.51.0


