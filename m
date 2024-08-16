Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5023DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 22:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf54T-0000av-MO; Fri, 16 Aug 2024 18:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sf54O-0000Yw-7d
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 18:05:16 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sf54K-0004Ui-Rg
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 18:05:15 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fee6435a34so19498295ad.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 15:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723845910; x=1724450710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0PsV83K2JHBIq/QpxJBZ4cNwVj10fWcrB7VaiPIWRb0=;
 b=ctHMEBt2xWr//RYIXEb3pJYpcD9SVJOorScx7OXGevBcRcNFFYgKZzW0+6hGC5X98o
 Fo+3qVb96X1jcOnYyL2SsmmO8TZ1suNDg/k0qZTxk8TMBh2ERmKfJ3rXhGVsLxSo9oCK
 tHn4sG0J4wyeZosbiFDYvwk/SZVjZCJZ7kcebPJCFtHi2vXzMuiYgr9H3hbMjDChxAJW
 EKaLeXa0JS0IK+v45va+n3AENBUlGjOhcYacZ08L6CMi3qlxFn5W3+Smn9RU3GmWXYn4
 hOnCdwsJXb3xh26J7z5l4Xitmlc2FQaAjUGgW9I5NFOyGNL5qFF42Igd5XDzpcLSTTdY
 XHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723845910; x=1724450710;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0PsV83K2JHBIq/QpxJBZ4cNwVj10fWcrB7VaiPIWRb0=;
 b=dS+gRmosfbNpSrQclDWeFWeyWdxuyGweQSbBqY+AanUHzAIl1gAp8OSJTv+Uz1ho+N
 WBw++XY8ImQDvnvAiHXu3XKdgj7hkPDL3TZnE5f2YmHFZhWnGbe1tLZ78PBpnpxEErPd
 6/mY7Y92qQjlPINYJo0RyF/Q2IBm5morhWRVLtZL/YlPj6GjXnDtxqwuUgtwsYEo4aju
 b0MrdQDXC6e+SBeWMaLNgmGe0thBg/HrTXhg+g4VlKWBHCToKyqAXYki8R1uZpH4R/aG
 CkpjCuBl7NjbOT5D9YYmu4QeyzNCMFYrwmut+UMIhYb+UiAQmNtCabOUtyjqwrtIeW/B
 9c0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRdq2egHMrjsIkQF8lrsdAGuBcrVxFgFNf4+tLXNbFK/eMRoFR56y4884ZVZB5U91i2KV8rusNpI29BAyBDb7tjEjSGsw=
X-Gm-Message-State: AOJu0YzIVnBATV6xgmB1m8Y36mkPgykB9Xucbxf1fkVAtFnPQze8ijpr
 JB9V57xHFcKmBsmCpN46O/4aGkDLuepNJjTYNHtxWJCwOe/cjgvG77eECWeQKPQ=
X-Google-Smtp-Source: AGHT+IFEhuOE74TnZAF+2QIK00TnwaYTPqpKK7HJsFWFUm2eELkpX+MgKdAeeHOmkWyQYyFSEYiIhg==
X-Received: by 2002:a17:902:f683:b0:1fb:8cab:ccc9 with SMTP id
 d9443c01a7336-20203f312a0mr61744805ad.45.1723845910262; 
 Fri, 16 Aug 2024 15:05:10 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f03a34c5sm29691455ad.280.2024.08.16.15.05.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 15:05:09 -0700 (PDT)
Message-ID: <092fdfde-7305-467c-9131-6f5d2128c58f@linaro.org>
Date: Sat, 17 Aug 2024 08:05:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v3 0/6] target/sparc: emulate floating point queue
 when raising fp traps
To: Carl Hauser <chauser@pullman.com>, qemu-devel@nongnu.org
References: <20240816072311.353234-1-richard.henderson@linaro.org>
 <501c22c3-d8e3-4439-a958-549e9a772ffd@pullman.com>
 <2c1d0942-1428-47a7-bd37-29c16d596761@pullman.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <2c1d0942-1428-47a7-bd37-29c16d596761@pullman.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/17/24 07:46, Carl Hauser wrote:
> OK, I think the problem is the handling of dc->fsr_qne in trans_STDFQ, lines 4583 and 4593 
> -- the code is evaluating dc->fsr_qne at translation time and not at runtime.

That's what patch 4 does, ensure that the runtime value is available at translation time.


r~

