Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E98C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 14:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAWOJ-0001C0-Ci; Fri, 24 May 2024 10:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAWOH-00013C-Hk
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:59:29 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAWOC-0000lI-GP
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:59:29 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f32864bcc7so21786085ad.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 07:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716562763; x=1717167563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1b1B7BzVs3TCTzUNEcLjt8zDnKKTiN5xRpU8C50PIoM=;
 b=FZ9yulGuTfXHYUkc+Wp1c2vpu5mmaION834iD/fhcE9k2KUSlQ3wjT8U454GxJ6vPr
 5twxGQp6qSt6VoHGG/nBFYBTyJuZFh8QqSkabVjTeh45mEBHODVGM86Fdbp249QuoQlg
 KU+87dkw2hyPRTrCRKIhV2jOvMe37wnd8vm8VXS4sU/ZEdB2ijJxQm6sQ0l1pNnZhrpP
 n5BCLqaMcfhZsVmPhJVYUasj66RtmMdmmhxLt2zAomHMLER8KNmt5ZGQtaNFEhlVct4n
 +ZP0X+5umKEFJsoFBloM5k1O7aqFK26E3r2Rncj48weqk3H46hgug1EyEad0GyFzHVeg
 cfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716562763; x=1717167563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1b1B7BzVs3TCTzUNEcLjt8zDnKKTiN5xRpU8C50PIoM=;
 b=LpG03T1tnf1tbctOA86QSZErgJiBnDR7tIxYKpZqnQekx0XUN8mjdePvkbaP+J52t8
 7GKnhgrW0ugSQTI3bZUXYM+AXMKnFTa91iCVQHWIpFTlELkBPtw2yw8lDlJGbRqMbiV3
 QD8qFPTgLMrvB7API39hbqzavMWECn/PHRO0K0w+kq4QrjXQ5EuusVa2h5N70swB3hxy
 HNTs0tf1BoUajUdFfG2PrYembDxzmjmArzX6KrpZbwyh2uxZKw/K9ic91kTS3E21KUMY
 LDU/MQdG2JVMbSktThSHVSxtw40lS/VajAgdRZQgs/d6EEZMCgLoz8t8RntchwJRCR+6
 h2Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/074o50QyuMQyQ0l2msf1m82V71ImP6FlORU5rmzejh+RW75VnCxOS7xFaG1Cxwz+NUFmsqsoZgKiLpZ5Z7bg8hwtdgo=
X-Gm-Message-State: AOJu0YxBB8sT42vungavqmm5clpCM8ibPzHJYoQn0o845XzJzgq+ikKb
 uG3H/DUCX+27I3iWnfPXTFE1s3QeJzznt4RPDBmFlBo5am2XJP70vaPERO59Ydc=
X-Google-Smtp-Source: AGHT+IHTXUxlN8LADWTZfiC1KglcR6vHGAkmwbXJZEAu0kh9d7dCzNmlCaoh6sRjpPAhzYGH/Cfy3Q==
X-Received: by 2002:a17:902:d492:b0:1ea:9585:a1d7 with SMTP id
 d9443c01a7336-1f44873dd8cmr30971115ad.37.1716562763025; 
 Fri, 24 May 2024 07:59:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c75697bsm14943505ad.34.2024.05.24.07.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 07:59:21 -0700 (PDT)
Message-ID: <991624a5-5ba8-41b1-87a2-8c6771f178dc@linaro.org>
Date: Fri, 24 May 2024 07:59:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] target/i386: remove aflag argument of gen_lea_v_seg
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-15-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524081019.1141359-15-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 5/24/24 01:10, Paolo Bonzini wrote:
> It is always s->aflag.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 20 ++++++++++----------
>   target/i386/tcg/emit.c.inc  |  6 +++---
>   2 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

