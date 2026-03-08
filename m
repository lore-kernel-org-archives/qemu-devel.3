Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C591CEA8545
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 21:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzM1Y-0004Uj-Fs; Sun, 08 Mar 2026 17:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzM1W-0004UM-MI
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 17:50:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzM1V-0005Z8-7G
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 17:50:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439bcec8613so5440296f8f.3
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 14:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773006651; x=1773611451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xNaQ285QaEXfCB4bHbNRM3rMGqNnY2DSr9BhZrcWs6o=;
 b=ZQ0XScDOfIUD/oCFZz9OG9vQXiXHlwQoCaCUDv5fT3bftr3bb5b5WL91o11CdhmTEs
 T2aN4W83XSXy3QOuAC2et/VDTBDqI8BQuJQvUJYTbzK8G9IQr2OWIk8Ov/Q+BMZxhcBz
 1PuwhZ2pDV3j4cOsawk1G7IC+YE1NtmbXcFOt3dI9ORmqNWsTT6IVpJAqRCYF/43o8ox
 p8j5dSllEydn2h7Ul0VmC97UzhRG8VFAUHULXB+9pP4e4keuWWLM5uG8/DWZHzt0+l0X
 X3vD9jLYOfROp8LmC0s+5luTur2R1kinY91DqVZyXx3YjxJAFmmLijjA/kn8/UV4dm7R
 y6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773006651; x=1773611451;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xNaQ285QaEXfCB4bHbNRM3rMGqNnY2DSr9BhZrcWs6o=;
 b=s/TvoFS4bRvRKVYNatocaA94xdIirIPAXAM9I4KKjheytLgs52xObJmAIcXzCYuUBJ
 Z2AH+KuS1p+NcKIROZGyI65hDEJUx8NVfVqDajSGVzMTxNt+w1/n95ns5kGsNKnCCnu9
 7F5AVFB3KZbCdKSgKLmfFu+ITstbjVkwQktApiA3epe881ij8bJNJLoF0dd0CgYUzMtw
 BApWjfkpI+0qX4HoMpxgCod2ANPQwP815x2moapi8sd8HR9BQxHUUQGnSamTgugpYpEC
 Kr6YvNMvOnb/lzJOZRgh1vfCVTpDtbn/bq83Cx7VbkxBKzSu17W4zEjHi9g1Nhc8BPNC
 6oGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwwAbXzAX+ivCLY8xLwEU5wGpXrsB2o0VEXNhxZolYHkUgn3dFFqWEiGLE/+/k1QfHEzxk9oBDQOc5@nongnu.org
X-Gm-Message-State: AOJu0YwqRTqyGeEK7ArqUv0G7MOLOfsX0atok9wWVZLFXO03So86p+rN
 EslPg61dIpw+sTQaM2HjWWDiOHHuqPEH4qBonsS+2xqTf/l49/y/iYGh5J7JYq36zpM=
X-Gm-Gg: ATEYQzytDIYUECadljk04mqTtcIWgCGnv9TXKyXOJJly/Q22/GeFBqlo8F4Flpsyjzx
 lOHrQK0y3kO5VuHYsgsR6jiDPCC3F4PwYIW+/BACrTaM47Vq76EwkWiXNYKCqkKEH3a9VvOGsQm
 a4tTc79OuZPZMDG4/2CQTZixMDjYvLvE3wFs0mCCyuDaVWZRvUlbvVVjxQ2+7n36oPcaWDeDQuN
 RYGNYJtXF/Q3Z8Tfv+PIbM87l18l15GEKVDMukD6Pf1gmc/pZopS1SkMrWc7nNYK+rxkZJpjeNS
 uX/z1Nta7LVRZ9il/KTw4y/yDm47R0hrUftqtkJ4Ftqx9PfiRqndyKNEVEloxgfN0vQHJOt8doT
 /fGxUKhKaaX4qValnlr3p5nPCrskEV57AljVkAB1Wzxcrn7BtSNMjwLksFNy8qQXofS+J3Kzpzg
 U1SDMPScmcpBHFZPmUrwmE5WalezgMgEMJAF1+XfP3emuuz0zQ9T/jQMR603IRmBpVwQ==
X-Received: by 2002:a05:600c:1f0f:b0:483:badb:618b with SMTP id
 5b1f17b1804b1-4852696758emr143128385e9.24.1773006651179; 
 Sun, 08 Mar 2026 14:50:51 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853044d849sm214091995e9.11.2026.03.08.14.50.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2026 14:50:50 -0700 (PDT)
Message-ID: <f50695b9-4736-4277-bcc8-801b1fc03317@linaro.org>
Date: Sun, 8 Mar 2026 22:50:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] linux-user and hppa patches
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller
 <deller@gmx.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260307195243.8813-1-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260307195243.8813-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 7/3/26 20:52, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Two patches which prevent memleaks when using Diva PCI
> cards,


Queuing those via hw-misc, thanks.

  all other patches are for linux-user emulation.
> 
> Please check...
> 
> Helge

