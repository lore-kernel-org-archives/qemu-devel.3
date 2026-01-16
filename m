Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB90C79FBF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 14:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkWL-0005Tm-Fc; Fri, 16 Jan 2026 09:09:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgkWG-0005Se-TK
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 09:09:45 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgkWC-0005nq-KM
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 09:09:43 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so1379726f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 06:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768572579; x=1769177379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AgSbVulJ1PCvqcq19AvJIFz1s1dFjKCRUz9jOCGwYB0=;
 b=a3kNojNRiGc4UVaDcPL+0YJ0jLbODyd/Cob79imnRiaFKilk2U3Z0NuvDO/mbQQ4U+
 FiLNY+iAn9Q6qznNGg5Fj2RAxW/l6b++Qsd1Be6K+sXWw3TxS1iTCcpvpG/tSm+dwLXK
 kuixsn9EFpYYsLndCXG6LP6eOvaQ2LEcQ0USCeurjztotb1f2u+9rN4pBAMDFeYY2h1f
 X0rdl4o3xBbaINRJ1uQWCDN68aYSM1qZLHCGMHwKKrSKmAfXtVXDXxf1BhTszQHy2myJ
 1p1U32uvjjH3YE+i9YEIPhC/FyklJjsVx8MD097zPUDmt02Be9CPzPl4KXb8vqeZYJfh
 qJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768572579; x=1769177379;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgSbVulJ1PCvqcq19AvJIFz1s1dFjKCRUz9jOCGwYB0=;
 b=P6bz294f4CjS+xCFgFHWMZXmOwiA//nH/sWSMK3/RTBgT5GqI87kKV/OM9eVj7TeE3
 tfORaVnG3Exg9G1R3NYFmtqH12DAcleGwAAwj1ERSzUtyy1pYfsqjVltDeRP6lwSND7S
 g47iNaWlo7nJVLq96UoeJT0Mtu+FMSOoa6CpgPaj0/dx9DRqSX5KeNZxTw8hDWoIhxeV
 QmsVTm59YkHs6Q3otRjQriE3d70w9pqfIKYtk7TV80GBU9G32R27H+paIq3yj+fgeeLw
 f9fylzzpvhiuhQgBQd9CpUsIHXsOePx7bj2WFmySmxZm/SRtGUcXo1aqvE08wLuIcFAy
 17pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXOEAZIxdSzPTzlvFU64ifLFgOgP1pLBfTr1QUT2rlCdVmtV/7Sw61eq9YZhbqWyby8ovKI+OeUOJL@nongnu.org
X-Gm-Message-State: AOJu0YzWLECXtIKVBtDslqOgpA3sBSq8gUbJBHj/VAJdT3wNwMg4VZIh
 6aS36aCg57QtlQhmEpLwJsuWatG4kc6l+ekRHZUctmPaexJk4uF1j8t++wVjaEdDKT0=
X-Gm-Gg: AY/fxX61p+eDnaa+WxobJ9u82T2a/9+z4IwSRjcYNUswJhKtb9biRoPXIO9F/9oI9r+
 HfQA1lsKdzDcc3Lmp2+FxeFP7ih9vdfJipR9sCxX8Q1cesZWUKF+yGzEwVpZGnwQOCFTe7yNxTd
 dKmY2uH3Oi2Gzq+toszQm7ujeqN9460KfdYi1wGpO0i/0YC5widt3TeuM1/PZlolz5kgvt9iTzZ
 JGG6ivquYl2EwWWWmIFcVqHmF1zHGTXf6aX2CWKC4kCUmtsIRH9YOKAEjoxCG0Pkh4cIktv6rog
 HlyB5GzMo+cUYjoixZosAHbAyxT8JiiwrrhLEuCU28mGKWFZZCazkjL9jfJW4gGLsCziqjyi4R2
 CR9FlB5JZ5//csdheRRvPVbOoYkD+/xUAw/FKgzCBC4gHouVGeov4Lg4yKIrATBukwaOoZ0LgQw
 QIVc/hk01tnODOn74yCjE1HlzkmXw+sgtVi72j2zowV/w/9GetumXgELLwD7kcvrBD
X-Received: by 2002:a05:6000:40e0:b0:42f:bb3f:c5f1 with SMTP id
 ffacd0b85a97d-43569bc7395mr3688873f8f.44.1768572578801; 
 Fri, 16 Jan 2026 06:09:38 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921dddsm5651653f8f.6.2026.01.16.06.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 06:09:38 -0800 (PST)
Message-ID: <aa9056fd-03e8-4ab9-9ce2-1c8a57fe599d@linaro.org>
Date: Fri, 16 Jan 2026 15:09:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 11/26] whpx: ifdef out winhvemulation on non-x86_64
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-12-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116135235.38092-12-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 16/1/26 14:52, Mohamed Mediouni wrote:
> winhvemulation is x86_64 only.
> 
> In the future, we might want to get rid of winhvemulation usage
> entirely.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   accel/whpx/whpx-common.c       | 14 ++++++++++++--
>   include/system/whpx-common.h   |  2 ++
>   include/system/whpx-internal.h |  7 ++++++-
>   3 files changed, 20 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

