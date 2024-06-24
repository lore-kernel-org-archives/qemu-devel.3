Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6170C30653
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 23:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLtBU-000074-Dk; Mon, 24 Jun 2024 19:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLtBS-00004t-ES
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 19:33:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLtBQ-0002y4-SM
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 19:33:14 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f70c457823so34327725ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 16:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719271991; x=1719876791; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=afxSaZmFeayTgYwudaIpDk9TVyzzQoJFS4ZZ17h8Zg0=;
 b=l1gvV88wJyT8ydM7QgMDFv658guvkcVNjrRpqSART7tJ9/MgUnGLa2yEH2G4LKK/zx
 09aA3yhnmc/iX2o2NC1ZZGtvo2PZk+RryG8TX33YfGhEs4iJoP+OnjT36rvrvYGvzRxJ
 pPdxGGXheZXKr/F58Ku1Qg63FLG3/tV/IVafglxO03pOtun821vJWvltb1oFLXa/thHB
 Esa7fqHE0s4dYheQ9qUQkURIMqKEp8ccLvRf/oDts6E6TKxRBW0JuKvSWeHGriP4Nitb
 gkGV2hEhzC7DTgTuzRg5eMf3K5jCKLyfgZ7+jt8f0EFtHwdj9LRWDLXPwFFFdUdMVuEv
 ULdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719271991; x=1719876791;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=afxSaZmFeayTgYwudaIpDk9TVyzzQoJFS4ZZ17h8Zg0=;
 b=QERaMjgXQ2UjjCed6ZgiqMsJ1CL49teYfIT/Gr/pVdb4umAo/zmfKfcWOCl1VF2kUL
 jFGS5ajRkGzAsyDAQunUh26ogORyiup0kHoIuApput0nFxOApMdclbo5SOzTnQWptFRU
 SbPQ/TsLFdcpUpoCgiJvgc32uGYz80s49KECEZNvQt85bkYWVSVL+Q82TwDoIFApXhwA
 IkqXBT+FBIB2T3R4ceyCGStrFewpqdhNKeAWWEEL3ZARnqkfl3Ptip7RRaREb6QtjOOb
 y6P06QDtzId827MaIYxlM/0I/Mr4uWX3GSaljBEHndS7cdg2p66f1rHC1V+2pY58G6yN
 AR8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC/flzY9XTIEldKTpH0zAlC+2rY29X9BR5Pj6tOhHgnG0SlC9VSB4npQESv4+Sn5b8Go2SGJ1Ekw9OR1vORvrSK/VF2jE=
X-Gm-Message-State: AOJu0YzfUd/cp06UnLNNmZfBuhSPxBxTLdpbPSahTybV2F1XGwDG28p4
 s4gcmYYGaL5UZ04Z4SvWBcCtBjofuQwgqvX+W5NFuZ3OQTbIbIvWW7ts7Q5v8QaXplXT3eyO47U
 c
X-Google-Smtp-Source: AGHT+IGfX1lIGKoy0ZqrtOpl18FCvKd8sHkwXTdmx7oiq7jbo9TXhGYUw8z9w2xhDnalU4yqcL+Svw==
X-Received: by 2002:a17:902:da8c:b0:1f6:daa6:e77b with SMTP id
 d9443c01a7336-1fa23f5a34emr63827455ad.68.1719271990564; 
 Mon, 24 Jun 2024 16:33:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3d49e9sm68161085ad.194.2024.06.24.16.33.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 16:33:10 -0700 (PDT)
Message-ID: <ab8beba8-658a-4359-bfb1-672e5782633d@linaro.org>
Date: Mon, 24 Jun 2024 16:33:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
From: Richard Henderson <richard.henderson@linaro.org>
Subject: Help improve 32-bit testing
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Hiya,

I've just discovered a 32-bit build issue that is probably 3 weeks old.

While we still support 32-bit builds at all, I would request that we improve our 
cross-i686 testing.  For instance: we have cross-i686-user and cross-i686-tci.  There is 
some system build testing in the tci job, but (rightfully) not everything.

I would like a full cross-i686-system target that builds all targets, and I would like the 
debian-i686-cross image on which we base these to be more complete -- ideally, exactly 
matching x86_64.  In particular, CONFIG_SEV is not detected within the current docker 
image, which is where the current build error is located.

Do you have time to look at this?


r~

