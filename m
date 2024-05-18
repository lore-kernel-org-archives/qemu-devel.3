Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3E3C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 09:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8G0f-0006UC-Ss; Sat, 18 May 2024 05:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8G0d-0006SY-Pg; Sat, 18 May 2024 05:05:43 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8G0b-00011w-Cf; Sat, 18 May 2024 05:05:43 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5aa1bf6cb40so1839108eaf.1; 
 Sat, 18 May 2024 02:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716023138; x=1716627938; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PTIqho+egsNThN0f4mxOZMFV4aQVHrQQ27UIIon8+1A=;
 b=R8BfK6ziEMvOKQzAlmMdvERzM0espJNpHU4/OzsdChQ17swBuprQ/Nod+K8CJb9/aS
 JkPk2kRgk5xknJYEjFcGWA8SptMGFd3A6iHJKaiF3NQhIYATlF/TWjkHDba/h01LGGcY
 yt7XzOn7I6QWq81grWco9JwJOq9dWn2l+wzStMkwysPbiwGtLXGCN5nYxvEGR1FSCm4s
 e9Fx0H+q5xOf7V+ogEyfr6xEeW7hyGUvyz3SAQ8/jBJpp8MXHbkEzTqEH5GazqmKCepa
 LImwbakpo/2rQ9Zpz+udQ6IgC7lF3UHnYHXIdIhFph1zrx68NWIfHloFtEpMTP4/4vPo
 GrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716023138; x=1716627938;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PTIqho+egsNThN0f4mxOZMFV4aQVHrQQ27UIIon8+1A=;
 b=Jb3wF596DxgJfKXo6DXHp87OsgT6A5mb/pPwTSh3J9mz+POojzgbcciUwAEk7bxcg6
 vKecAzC5jBNnaOZZhJ6QwHr2qhmh+/9oEJ3C05JgWyDwaMBaI7Ml3uJVUaBrCXE/dBE5
 7hhi24ZYm7j5KJjB4nklMZkRxUjWj/m3kVEf3aqDhkQQAR8dyvhIriFAq4ko5mD+2CaL
 tqmnNxMByn7J8oU7eHKO5KFZG2L/OMIDaIuN95ysiDXyyM2MfT8kvtxhu3lKvVeYMtsZ
 ysualcJIKFga3xBveLVFdaz9K47cbyb1RWMn85pMphspn6TQjefP9Gv5R9ShzcGjLW6v
 Cyxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfUfRDd180cGWJKDARDLr9DcKVJ1xY3xlbqXC8QdKiFzoOri/M6wI9agq0JyoccqrozVego+XMKU5gttYUR/Ls1DUZ
X-Gm-Message-State: AOJu0YwBywAT4X/cRljJpYwK3lnEWArSTXbEO6/N/S/pa9zoBUHieysj
 yRjDS/X5GvyTDU93mRgF01FJRgletY+xmLyx0aTLLQ60U7+17UOK
X-Google-Smtp-Source: AGHT+IE24fRHsYD93Db0jT9hctNLaCQUO00popDdH4gGuSISYeuaS5atm0lGjDm1seEvxhNFh1XMaA==
X-Received: by 2002:a05:6870:f609:b0:241:640c:be5b with SMTP id
 586e51a60fabf-24172f50f8dmr28529885fac.41.1716023138213; 
 Sat, 18 May 2024 02:05:38 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a87bb1sm15920635b3a.87.2024.05.18.02.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 May 2024 02:05:37 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 May 2024 19:05:31 +1000
Message-Id: <D1CNFJJRDH00.1MTM5KDZH4N6U@gmail.com>
Cc: <qemu-devel@nongnu.org>, <danielhb413@gmail.com>,
 <richard.henderson@linaro.org>, <harshpb@linux.ibm.com>
Subject: Re: [PATCH 0/3] target/ppc: Moving VMX insns to decodetree
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Chinmay Rath" <rathc@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240429051317.289426-1-rathc@linux.ibm.com>
In-Reply-To: <20240429051317.289426-1-rathc@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon Apr 29, 2024 at 3:13 PM AEST, Chinmay Rath wrote:
> Moving VMX instructions of the following types to decodetree
> specification : storage access, integer logical & integer max/min.

FYI I've added these to

https://gitlab.com/npiggin/qemu/-/commits/ppc-next-test

With the 32-bit fixes. I'll send a PR with them after
some more testing.

Thanks,
Nick

