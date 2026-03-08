Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75673EA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMdc-0006vS-L7; Sun, 08 Mar 2026 18:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMda-0006up-VT
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:30:15 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMdY-0002CQ-LT
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:30:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so18285e9.3
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009010; x=1773613810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qXymsyrqckfe7W3araSAuUSLKMG7Xzif41UfCS6gntU=;
 b=tXQMEi1vl861ZqD0uSFcPtA9VKs0HLUXfFTOTO6ex0Y4QCowv0RZ79x7Vq8A87INGx
 2sIWxm+uflNMR0OO/7+npwV24p36+8sz9nEZywoLQ1aJyi1q4lj1Mu9493eqxhPUMAEz
 zg/cQUuxx8Vk4U/kRKyiATBXT2im9zil16KxLDI/5nxey+CgwSLEGASfZn6E462MfIlX
 zCrMpyAtRfGJUV6Yt8Y2FDMwUqdYNd1Lzln8M4u7hyiDLFPibH5Lwng4VK0fAtyvxDKC
 FAwm8NHdIGfYOe8qDTcxbuSSV71sjS8a6Xu+2QU8uizkdJRpaOhxl3ylANED2xHxYMuk
 3A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009010; x=1773613810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qXymsyrqckfe7W3araSAuUSLKMG7Xzif41UfCS6gntU=;
 b=dW9IiGNiwiBmZI/fi8upGHVqYtyKfJp3CWkLskwVAu9DOR2HTXwqhARFHdRYTKckZ/
 REbBV+lidImb+1gfNw2bI1lVrr4EQpTHTjW6XJizMQDfK8ohW2z5f8T18VKF2xq/jtN+
 rigjTKXGkzRvnzufcpTfGG2/tQx2f077fGmjzS1+uC3gNalXDWnn1WL82DN8Cyin4Pb/
 opt5GKbB2WyrQCdi4trIQJjqs/yXPt8SyyCns1sqi7SfdEONqWzZ4vcMYQFkK/j11kuq
 waMT1blbBLWhu8CEzU0hqtO7r5RGssS/QQJecTRMxxjgAQbt2CcZe3BUFUcIVJwu7LX1
 rfXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4rrR8efmiSr9ypADK4CNlhExNV2aX77Wc8jeSquGN4h9kPiho73oASLANaVvfZK7e84tjgEtnSOFC@nongnu.org
X-Gm-Message-State: AOJu0Yz8aFbmt9EtwUFEG36gEHx6JAs4g1lUKKPhiyvtFW+j2LT2HN+B
 yWgE9bY7psWlKURlW3SEQ/h9YBFW6zf56TGsXS10D8hDQ4QARNTn65kkyNJ/vwzhhbc=
X-Gm-Gg: ATEYQzzugT40IVoBTulcl231BFZYd9uzlxRDtf5jBtUqZPn6rG7V5v64w9YZy6VruaI
 +ArxYmdBl2mJxKg1haQ9NzAvhE8SKzCPgsBvuOePnvA3/SWP7AxZS1TdXx83CV+rOJEmo8oUYFz
 1d4e//5aXVpbRl621rJfv7fCpMzO9INiHaStijS2kr456+47T1y3kO2rAhzvF/1joB64A2759Fj
 bLtOVLy5/84CtB/ATTX6SUoxOwnBuFT/f4HK3CoYsqVVBJN67F/7uMCzLTfM2jMtsTmGcXMvYDv
 QaxzNTsNwJ+APjacHwaE4trFE1GDxKHzUl7i4XJY+cXJEJJVqZGvUSlXCzASac7apNsArvWLnHc
 /N+BTZatpp1me0uYuyromx7WCIcyRqa19JpuhWmszGUcT+5vhVAmLdGsebuaSyVJGtw0ivy9ZE+
 9eu2iJsMCWgEYXFLy8AZKDpn6e9eWfB1Xi7x+I0t/V8FYJv2/NNYqdqKo5wYBSxSO+mLba9dI=
X-Received: by 2002:a05:600c:3b0c:b0:483:ad56:8d16 with SMTP id
 5b1f17b1804b1-48526918944mr165877025e9.6.1773009010423; 
 Sun, 08 Mar 2026 15:30:10 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fae00absm289829215e9.4.2026.03.08.15.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2026 15:30:09 -0700 (PDT)
Message-ID: <45567d74-ecde-4af6-a2d6-f4d94b021df6@linaro.org>
Date: Sun, 8 Mar 2026 23:30:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] hppa: PA-8700, use 44 bit physical addresses
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20260305-hppa-c3600-v6-0-d51526e5269c@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260305-hppa-c3600-v6-0-d51526e5269c@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/3/26 23:54, Anton Johansson wrote:

> Anton Johansson (3):
>        hppa: Introduce HPPACPUDef
>        hppa: Get physical address space bits from HPPACPUDef
>        hppa: Use 44 bit physical addresses for PA-8700

Series queued, thanks.

