Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C71C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 08:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF8QP-0005dj-N1; Thu, 06 Jun 2024 04:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF8QO-0005dP-3f
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF8QM-000201-MJ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717662281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnWHtkzTgU5+cM6hfgWLug4FTc+B1JE/rXI17PfKzQA=;
 b=QFoCKkZFY9VWUTWW6sVi7/CvM7DnWF4ak9voYllj8oKWNy4Dau+tPx+bRJh78hdUUG3S0N
 ZbESiqSwAmnyqNDlk3m9J4dTFMUFcaLwfFIWM8LBCvy50mB25gUVILf2DYsEER61PZYBCB
 JbRgrpEtr71VQrATnFEvg7Nh+fPbqvo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-qIj2HN-xMYe6iPkMUpEijQ-1; Thu, 06 Jun 2024 04:24:39 -0400
X-MC-Unique: qIj2HN-xMYe6iPkMUpEijQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a68c70ab413so57705066b.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 01:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717662278; x=1718267078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnWHtkzTgU5+cM6hfgWLug4FTc+B1JE/rXI17PfKzQA=;
 b=aTAxACw9nJ+ATDOdvb6YM/NhdN/poVkThCyhup4Bl05DqKt96W+dqgetqZ2IvMYaKu
 UINJ/zrTAVDWdYepESCNtYxhc+M8gb0JffZH5r8atHyDTj7LYi8SOSgSi3w2u5e26Shq
 tuAKPiacprtl7g8aBAT6KIjGT45sjse8YHGhIEkgaLulLaqihUhbfptusKtpfd8/X1UJ
 k09a1fy1+h9abdTGuoND3q1Iz+wZe+6unk0P/hJDKKnuyhQ2ClxyqqmH5rEw6pbaeGZs
 F/EZr3rZJ0OPbBk5YMAMh7WilVmATtAsRKCOtfG1v54YOpU0yYsxy5ywKZl8hM3enw8O
 ygQA==
X-Gm-Message-State: AOJu0YyB/0k0ccUikK6gBP0kSYPLwKgNIuBLwwExBoaZyIT/fmYWuTCg
 aEwfwTL6DWf371HoBGmvcT/Prpm1fSG6EkpxPjGprNS4JGb97QqWBeAEctr14b01gQrKTH6gZ3V
 oVZ1EomOZJYTX1iacijo+6AcKfEX1XsoTy/6R3CiLwe///E8KaEmg
X-Received: by 2002:a17:906:71c3:b0:a66:1f72:cbcd with SMTP id
 a640c23a62f3a-a6c763beaecmr149998866b.25.1717662278537; 
 Thu, 06 Jun 2024 01:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG69/Du8e4BENcjHHdAPfbw0e0CXZ7B0Dl0RWHNBimFYpU2XQQm+mKP+zESVfPbGlmyZotcLQ==
X-Received: by 2002:a17:906:71c3:b0:a66:1f72:cbcd with SMTP id
 a640c23a62f3a-a6c763beaecmr149997366b.25.1717662278061; 
 Thu, 06 Jun 2024 01:24:38 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80581b47sm63364066b.11.2024.06.06.01.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 01:24:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, dirty@apple.com, rbolshakov@ddn.com,
 lists@philjordan.eu
Subject: Re: [PATCH v3 0/7] hvf x86 correctness and efficiency improvements
Date: Thu,  6 Jun 2024 10:22:18 +0200
Message-ID: <20240606082217.2459102-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240605112556.43193-1-phil@philjordan.eu>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Queued, thanks.

Thanks for persisting!  It sucks that the hv_vcpu_interrupt() API docs
are not clear, but your tests are great.  The self-interrupt one is
the case that I was most worried about, and you're covering it.
Sorry for being a pain for nothing, at least retrospectively.

Paolo


