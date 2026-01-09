Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6092ED1A63D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 22:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veKeI-0003Tt-Kb; Fri, 09 Jan 2026 17:08:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKe9-0003TC-8f
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:07:55 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKe3-0000xn-JU
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:07:50 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c46d68f2b4eso2836171a12.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 14:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767996466; x=1768601266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GNBw56sy+tdzyDhOSPMiyrmrDFbo5jM1yEwsN8T4mTs=;
 b=oowogtP5nprBE0NCaZBdRpywxJ7ocxavdX2EpmisNHqBOGDrd/60gjsBXnpb0SZ2Fq
 PWZft7m3sW3pc7Ip4LZrd++mFXoq/pbnD2eO/B1MmqO2+VBOjw+RQOXbjsCvwZleP0cL
 SZZX6Kj86nxx53xnjsw+oDUM97GvO5IysfB3X16zsVSYXR9OcaaN1emMQ4+LRNUL+77/
 1F6+U5BP8sXdNWb+Jel0t5Cg+LeWd6SAynwoi19ydNX7zGhSIAS5zNBsZneS7xhHHtuk
 5jmTHr0JwDRo9oaqGE/S8pX/CnFSszIM08E81uApW7tUX+PImEsABpzcOhGJcv+luxfe
 ytQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767996466; x=1768601266;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GNBw56sy+tdzyDhOSPMiyrmrDFbo5jM1yEwsN8T4mTs=;
 b=FqFkz/d8utryECWq8L6KlhzYZS+dwHEsyk3flmKjMfhA9959mdnP+OympJqMEiDV3/
 SrAMYuWTPbLCY01clF+sGRXRGqrclwAIw2NXurgp2TcbkMIBr+6riQLX5WIVUJcbRqsL
 OwhG7zJsEnANF+YtHpZJZGCyg7WI1hwuAStlPg1Z+0SYyOZZGrj20jwvtAuNocCKDnQq
 tRn2/OO9GMe9LtKIaI4zedOCI4X3wUykqI8dvlwaPvngYVwZHwg/b4mvsl6JmM2FzhWB
 82zWeHtWivP0R2vnGdFZPzW55j24JJWifYg0s0ouoRAcv2nUKgtOtv9SBgx8jgU3lrtG
 MDBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD2d2o0m4EXpgd43yP/vLk7mYcj7IA9+aIhS8ki37kvRiKsoC41/PAxUJ1WaRbrk7IQtmOGcEYRZYa@nongnu.org
X-Gm-Message-State: AOJu0YwtuJZ3S9/4dpU7EtmYeeYBI8GL5EJBcNg5oDwPOjytXHe+2gic
 FmvbEd5/Bj8+o+3KA4mh7CLAuMo/+NhDrXmao4vjje/E7R2PF8A2ZML8+ICrjhKKj18=
X-Gm-Gg: AY/fxX602p9rqZYfZV+2FKPK0pbo5+wGXp2RKkDfu0sn1VEa9rB1WYnUAMwb5rwY4Pt
 KdWToW8BHbGJCPFcYDRS35tKZsAxBDHjOclPxdHSwK7xcPrs1/dtnRLDGideEnGbI5PWzqCLtqI
 CRC5HNAFfFKRUnZfuptx/9eskpbLGYgfM1Qsdhv0PJ+L9nNZvGJjNU+zNAciHsutwUVdSLQ38vc
 xDYb68KX/1nYBCkmQC5oEGyW0seuNWvEjYtL4e9/zMVBV5nCEaL8pCe7OVDtVxr36kqc20H2+cA
 aas/+e6DU07gNmq3VrbJZuYF0+G0YyG7T30wjXRly6GUysKl/3lD6ZdPTSehE2vcwuT/Hxi3wJ8
 jn13ZuLGQmFt2PpZ4ZgMV3AAtvoriFnKZnIKLMRdlqWDQJLsAPm7ghtKTt9OiThEmFj8scmRejb
 gea6H0vsWNx11UtAEn9CLpgUWvfg==
X-Google-Smtp-Source: AGHT+IEmu897Kv4UsVpeO5xV9zKDVJtSEIJsIGjOX3WOWkGJ6/ngxdTR6O/mSl58FeTd1Zq4FeKX7w==
X-Received: by 2002:a17:90b:4c46:b0:34c:f92a:ad05 with SMTP id
 98e67ed59e1d1-34f68b9a0ffmr10884004a91.11.1767996465873; 
 Fri, 09 Jan 2026 14:07:45 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6b0dc3f9sm3204262a91.4.2026.01.09.14.07.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 14:07:45 -0800 (PST)
Message-ID: <ae3a0f48-99bb-4499-9f8d-e511182aaf58@linaro.org>
Date: Sat, 10 Jan 2026 09:07:38 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/29] include/tcg/tcg-op.h: introduce TARGET_ADDRESS_BITS
To: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-15-pierrick.bouvier@linaro.org>
 <5883ace8-ec8c-4632-9761-615462582254@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <5883ace8-ec8c-4632-9761-615462582254@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 1/10/26 02:36, Paolo Bonzini wrote:
> 
> And as a final third step, TCG should excise "_tl" definitions altogether if "!defined 
> TARGET_LONG_BITS".  For targets that want to use exclusively TCGv_{i32,i64,addr}, this 
> lets them stop including exec/target_longNN.h.

FWIW, this is why tcg-op-common.h exists, for TCGv_{i32,i64} without TCGv and *_tl.
The tcg-op.h helper is "legacy" for the 100% of targets that still use it.

The new tcg-op-common.h is currently only used in specific cases, like plugins.


r~

