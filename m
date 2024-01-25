Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00F5C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 10:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSwWS-0007bq-Ex; Thu, 25 Jan 2024 04:59:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSwWN-0007bc-DQ
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 04:59:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSwWM-00066S-26
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 04:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706176780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=O8TEMM2f4pC+KWSBeifI0v3Lk2CVOvo8z9AHN30H1kbTXlF5AMCtFZwBxS2sBJFkWfdOtc
 akmOJMq2EyzCmhUDVJHC7xjJcGnKpwQo6Zw6BHpEF3G2GOL1AcXdbB3u/mwYZ7ZtsK4/yV
 tmS9VL0ifkjGUd7/dsN4i/nSxjGKsuE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-_qd7TFe_MuG5kGnQxTYm1g-1; Thu, 25 Jan 2024 04:59:38 -0500
X-MC-Unique: _qd7TFe_MuG5kGnQxTYm1g-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-558b84a7eeeso3718110a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 01:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706176777; x=1706781577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Qe9PKKAIXycfgEs5Sq1np5CpSj9Lr5fxnJtGzSIgFGeKvx3GtaoI+uhxM/0y9Ua0kA
 RKoBwr+28VvpiHI60WaxBr7+5fN9wLm3BapQ3SCRvOGwq8AWKKDmf0T7eD8/gQnBhHTE
 tUQR/j6bAN7fIk/Z2nC7IO4TiKHgK7XQqFdmcqZ2jlN4UbGvtzUv0V6r63T7dWDTGt7j
 20fOrx3RcHia5+P8ZZoN5p1Ke+HgcHLmm4McpXnuuCcuAbDc1/V5cPvXxWZH8gyQeBjX
 nD+iYW03QLcZO7D46ZPYFYF+oN9+PtNoqgD7IvOjfYMc8LMyuhnJcRNdKDeGOUZ565j3
 yEzA==
X-Gm-Message-State: AOJu0YyJM+363830bscc0J7j5gkcy6TbJPQPW1l4SWEb43JBC5MGE3LP
 t9tqCyoG0FllDk0vNQ3P0JqHLHk8af+ki78x9YeJvNV7Ai9JaRb+ez59gN3VfF3ntBSWH2qU/Nh
 1HpvVi4KIdjz3oi927WToe1QjfFaCsRnJIaGGL3gecGP+xOIxZfYZ
X-Received: by 2002:aa7:d713:0:b0:55c:c203:e883 with SMTP id
 t19-20020aa7d713000000b0055cc203e883mr403513edq.55.1706176777666; 
 Thu, 25 Jan 2024 01:59:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ8rqHqExrjKaF9lSexeIy81jeSnyRiF5ELSHChG3Fd2TLk4PLg5PJmPtT7Z+PTw9QgexRhw==
X-Received: by 2002:aa7:d713:0:b0:55c:c203:e883 with SMTP id
 t19-20020aa7d713000000b0055cc203e883mr403504edq.55.1706176777356; 
 Thu, 25 Jan 2024 01:59:37 -0800 (PST)
Received: from [192.168.1.174] ([151.48.72.171])
 by smtp.gmail.com with ESMTPSA id
 es18-20020a056402381200b00554b1d1a934sm17278712edb.27.2024.01.25.01.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 01:59:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] target/i386: Add support of KVM_FEATURE_ASYNC_PF_VMEXIT
 for guest
Date: Thu, 25 Jan 2024 10:59:34 +0100
Message-ID: <20240125095934.781153-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231024083354.1171308-1-xiaoyao.li@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Paolo


