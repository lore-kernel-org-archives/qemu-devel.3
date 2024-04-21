Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F724C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 16:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryaNT-0004ck-Jy; Sun, 21 Apr 2024 12:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryaNR-0004bs-GV
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:49:17 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryaNO-0002Xc-Pv
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:49:17 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e9320c2ef6so5585825ad.2
 for <qemu-devel@nongnu.org>; Sun, 21 Apr 2024 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713718153; x=1714322953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/C8hv0IOFd/awOPzjrquTue1IcmbsUX9nXzs73BETrg=;
 b=lilpE5GSFh5FpOWcy5lIahghjv5a11zxgRkgtY+Vn5et80PtuL9ekfmem1MnKuMBJ2
 Be51uvrWrpxMSlRvbFr+Hkfp5Abj9ivphLovBDxluu1Zm7UWmYxNTKQj0vHEsGhjQtKN
 NQq5uxLCNoeFAbO0LeQ5nepbTFlTCfXPmz4ZW5k8Qj0UD48zZSIsuTX/MpForf8jZwyM
 xwaJft+aXxEtXawLmqR5s4KbHn8G2JDZonZLVdq2z+/XvrbuL8IWqYa52KTInPMD4kZW
 FIJQvzdSHTuDoqURnUPyYVpdj0MF1KL6v2jGLsU9ByqXj3lwRjYNpG37Rik40bgNFD2U
 LywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713718153; x=1714322953;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/C8hv0IOFd/awOPzjrquTue1IcmbsUX9nXzs73BETrg=;
 b=FLnSLVTBGcjFKQwDTEWh/qKjqzSMBh/AJGLqTbxDi5O1J1zFH8COAJqexAtbQzHLD9
 EcOIKvhnUbNrNv3qNpB5UH1rxWhfj3yY4RFLY9l6JSSQafmWA04l2lrBwN+QPq2mQnGO
 9UmPBvDfwfV7BrX0YqHNwaKE1LXnOl8antUwzPn572hRS4AFpTBoXBYD5BFLTW5Brx9Q
 OtF74yJPAO4O+z3Yn293OADGZ0ycF4lsVf4EqMXPGoXzsLmkjADFMXa+Y9/4ACHw6EH4
 OsJCrIzdE6o/Vacy3PmsZpejLOc5AbAdw8bXA37E/rmAq6awQ1xGjvHn9J+U9yosecvn
 fVXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcCNKPn+xvVGs3Lia1GvMIATHk4dp1Q+0MrlHoS5qjg3OXBPK2pfg6d3YAeRhZNBzGP/3tIFl0aERmCCkRU+pb/YI7hYU=
X-Gm-Message-State: AOJu0YySjFA6pchdnD97Ko+S/D70CsLRlwj9xfhFm5kFcxVWUaqwziNh
 LNAKx/iUiNwV0DwEEwNW+iXPxFXQ048rw8vU45YwK41tXaF7knMPxMrhAakmmzM=
X-Google-Smtp-Source: AGHT+IHtYrEaKSQb0pIMA7tUJm/1G4nF1gQ3bdx26rUJeKYeIVxZkY6OmPxhhvIYkAhIe/WUwQYjyg==
X-Received: by 2002:a17:903:32cf:b0:1e2:23b9:eb24 with SMTP id
 i15-20020a17090332cf00b001e223b9eb24mr9181869plr.33.1713718153276; 
 Sun, 21 Apr 2024 09:49:13 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a170903120f00b001e45b3539dbsm6523586plh.41.2024.04.21.09.49.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Apr 2024 09:49:12 -0700 (PDT)
Message-ID: <777db3c8-30cc-460d-875d-cf25ab873ca0@linaro.org>
Date: Sun, 21 Apr 2024 09:49:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/24] gdbstub: Avoid including 'cpu.h' in
 'gdbstub/helpers.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Michael Rolnik <mrolnik@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-20-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240418192525.97451-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/18/24 12:25, Philippe Mathieu-Daudé wrote:
> We only need the "exec/tswap.h" and "cpu-param.h" headers.
> Only include "cpu.h" in the target gdbstub.c source files.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/gdbstub/helpers.h | 3 ++-
>   target/avr/gdbstub.c      | 1 +
>   target/tricore/gdbstub.c  | 1 +
>   3 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

