Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14BBCD3420
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 12:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slSrP-0000WV-Ae; Tue, 03 Sep 2024 08:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slSrN-0000VD-OQ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 08:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slSrL-0007Mt-Iu
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 08:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725367329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=w1GemxTFsONEv2KjJqE+TTM5MVbTvqBJMVyVZjkkY+I=;
 b=JD23d3U34bvAtiVsH6hhAKiSOJOasNrs4qLYXGE2dmdf+UTomeh/B1lSzF1kB+j6B1lyIK
 ltbNM+mkKiteBJw6ZKBmQ8TAut3vflqv7RmqTefXA9Xgi0OHe+ZVphby6LnqYIrZDoRyfS
 1CLVhKQXH44/yd6YISM/whvdDkK5Viw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-ou4EazeNP26vdawYnafg3Q-1; Tue, 03 Sep 2024 08:42:08 -0400
X-MC-Unique: ou4EazeNP26vdawYnafg3Q-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2052e7836a0so30145585ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 05:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725367327; x=1725972127;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w1GemxTFsONEv2KjJqE+TTM5MVbTvqBJMVyVZjkkY+I=;
 b=wCYoDpz5Y+Jpt4+WWzwkveMDSKcUi4SaSBnAjJTZwYXDb75E1MLROavKbvKCvTV3B8
 G2fQFAdo1vExIjoKGEQ6BGCwxINqmcCAoZLTNBojDNmIvBV23EVI+ctURBhjz38W8wln
 Hgqfp2f8fZEFDzqlfuYGxiaaSF8S+K0BCm+3PjOHbsIM9Bz7o0ub/yUr408RstiOwabB
 nKXqg/HuviXRLd1gPho7HOm2rB0ViVi2SbLrDvSYmceJm05hPz50cbkD+ybA4FdStcCk
 QnHImCvlVrzzUELqN+xUk0sBuT+Z22zozhsempTRhGlTIFpIICfWZmXcEqs+fO6gS/Py
 uIAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLAhdlfCgMpKCG+mIMc8lGDLDJXzkXG0P7MQCD/VfxB47Ai8lFwhs+nWb1ZB7V4QpaxFDgXZhuXePl@nongnu.org
X-Gm-Message-State: AOJu0Ywku5U4Cj59/JIfJIsMXR9RY/E6sDLQC423BPEWUKnAhLnApY5j
 crhIMgf/Tn4VT8A6Abufp88dYAQbNRuOKPKL1ARUDRkR7YGlUcXdhTOXnSvyySp0v4ucUBdoyVX
 1FADk05RYkr5GLV0wCagazGYDvuAs7nNvZ3NZqVNWu6sePbLKVV9c
X-Received: by 2002:a17:902:c40a:b0:205:63c5:74be with SMTP id
 d9443c01a7336-20563c57554mr62196405ad.49.1725367327626; 
 Tue, 03 Sep 2024 05:42:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDVJd/djxcrdfjh3cgK32uLwt43rMXO02RJFmG7Ytq7U9kEcnE5saN7Wt4NsiBzfaCahodZQ==
X-Received: by 2002:a17:902:c40a:b0:205:63c5:74be with SMTP id
 d9443c01a7336-20563c57554mr62196245ad.49.1725367327229; 
 Tue, 03 Sep 2024 05:42:07 -0700 (PDT)
Received: from localhost.localdomain ([115.96.207.26])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-20515542350sm80222025ad.213.2024.09.03.05.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 05:42:06 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] kvm/i386: Some code refactoring and cleanups for
 kvm_arch_init 
Date: Tue,  3 Sep 2024 18:11:41 +0530
Message-ID: <20240903124143.39345-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Some cleanups. Should be no functional impact.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Marcelo Tosatti <mtosatti@redhat.com>
CC: kvm@vger.kernel.org
CC: qemu-devel@nongnu.org

Ani Sinha (2):
  kvm/i386: refactor kvm_arch_init and split it into smaller functions
  kvm/i386: do not initialize identity_base variable

 target/i386/kvm/kvm.c | 339 ++++++++++++++++++++++++++----------------
 1 file changed, 212 insertions(+), 127 deletions(-)

-- 
2.42.0


