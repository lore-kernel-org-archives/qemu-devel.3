Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABEFC30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 23:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMEGW-0005jo-MJ; Tue, 25 Jun 2024 18:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sMEEC-0004S4-Fx
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 18:03:42 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sMEDT-0004Nj-6b
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 18:01:19 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35f090093d8so4020678f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 14:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719352766; x=1719957566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TjW1GXTcGm9YmOJIxkA2iUtgfvQ8so7g3ogkHAqvClU=;
 b=DXmKgURH436u465PdFkMzUo1YQatVPPLNvepmHBkbe+YCFipHmk5MphlHaJ+WncdAz
 0o8MjqK+aOQ5g83q8h48V2soF+HzpYpwOUEGMRYgoNnoqnM+fwTiLgGZrTeDvSyN32Te
 X0X9Uhbh47Rju+tqoA8P6UPAVUZTMolFmLCB5IT/b3tr8Okuw1nHzzOBI22REOfYN/z5
 x1oRDLYaWFTy1dpgz3VTU1xXN0ozzPyFT+Ps3u8icPAfaWVPEIRyNoDU/Tk5OfzBsLVL
 CYsEzSbcIXqsu0ImQvtt6/psHE4KnvRhlfPj7Pj7zy1s0CCT8LU9IgwM2jJEM7Qt/IHx
 odyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719352766; x=1719957566;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TjW1GXTcGm9YmOJIxkA2iUtgfvQ8so7g3ogkHAqvClU=;
 b=QTefJJTByb5/o43KbaXFBJ4oqQXMERlf/UK4TQfOY5Xja/HNK1lmQDRoKZBRspXQiq
 TGCNXt9RYwjv9hOBX0nA9Xa3PAXqRiUxqoMs8muH0xtzmIoKsgc/xwoqKM7Mc85mLuMR
 t3tvi+gBidvQq+LcMu8sFt8Gkdkm0rG30ec7JdSpDHNGqyyY0kEsiNPL2joc3BLQaVBL
 vJB0vpppUEi8w5T7YVopDwvG/0x1v1tTR+oTEIxoagUCpgZBJGZsQ/IRi31ImXqKfCFC
 gE6+BlWBsxCtyB6qxZhJNQk/LupyEeeL0zgfO/mdSusRURkSYQZNaWvE2WpggPP51nVF
 bIRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2mc/u/fdAf6nKgH+Z16eRZuLcJSUVeoMNWfSph3QTsABRDGEpniP3e5Z2qLxFrQiL0gL4S7LYS9tvU05palSyeVSLrds=
X-Gm-Message-State: AOJu0Yxd5J+lsx0+tginU8CTlWLeOIfwt3i7wM7ApJgXirRmIflLMDQf
 Dx2CXDIMXeDw3tpPRVFjLN1j5VAF6FMHN8rfgf4cen2bsARKgLH9bTfHBO30FeFS2nZj0b0TgzS
 Z7L0=
X-Google-Smtp-Source: AGHT+IHW7qx95/o4A5F8y4GugXRfpn98849ocjNWvlLAQ6jbEJorWAFGOUqstJXb8yyRStj4HgeJvA==
X-Received: by 2002:a05:6512:3095:b0:52c:d7d9:9ba6 with SMTP id
 2adb3069b0e04-52ce06413c4mr7802025e87.50.1719352288169; 
 Tue, 25 Jun 2024 14:51:28 -0700 (PDT)
Received: from meli-email.org (adsl-73.109.242.224.tellas.gr. [109.242.224.73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c825e583sm2085035e9.21.2024.06.25.14.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 14:51:27 -0700 (PDT)
Date: Wed, 26 Jun 2024 00:47:01 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v3 1/5] build-sys: Add rust feature option
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <e74803e6b570ab36ebc538dd84dc7c4bc2fbe4e7.1718827153.git.manos.pitsidianakis@linaro.org>
 <ZnmkN2PL3r-2sxqe@redhat.com>
 <CABgObfbH4KpFv+eKr3BLpk0S9TOkQNiyQN5q6JAFGsMrWmSGnA@mail.gmail.com>
In-Reply-To: <CABgObfbH4KpFv+eKr3BLpk0S9TOkQNiyQN5q6JAFGsMrWmSGnA@mail.gmail.com>
Message-ID: <fnopq.orjfjqf36hxp@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Mon, 24 Jun 2024 20:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>Yes, I agree. However, considering we haven't even checked the 
>situation
>with what language features are required by any idiomatic bindings vs the
>1.63 version that we need to support for Debian, I think it's a bit
>premature to make it mandatory.
>

FWIW, I just ran

`cargo msrv -- cargo check --target x86_64-unknown-linux-gnu`

And the result was `The MSRV is: 1.77.2`

and the most important issue was that the mem::offset_of! macro was 
unstable till then.

