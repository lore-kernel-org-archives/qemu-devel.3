Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34928C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKMjk-0004YA-Jm; Thu, 20 Jun 2024 14:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sKMjf-0004V8-VE
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:42:16 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sKMjd-00050K-0G
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:42:15 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3632a6437d7so778306f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718908930; x=1719513730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1WrcPu6ux6xTIzc9Spckyx2sySwM5IjSq2MtY54hdJk=;
 b=jKjHm85ICadYnvZjcpw8qP15vktZOcc63aMvcLEmxdfJ6tZKC6TcGcpkcjeuEJTChQ
 HwbVMKC2bfQcvENTdwr3iY0VehFIT2WGZVNgA99QLdNqsCFlnibNp8ACRoFA15TasUnR
 n5lGaAv81t05kyPGUhoqqjwMlSnsJpheE6gtM+ieyAZPu6ZjOKi7fT4Y0Hy1MHdJ+Vxk
 ZdYtH7nAw1wnALiPcsSCl+VzGEMYLwmUw60nuVioWRNjifaaySZekLS9BY3enTno9dq+
 hfEmIhp8nT7f2yuZLHa6PwEuC3n5Fg8mnAR3ATtVUaQP6uf/lIE4K5ZxMDRk7v+mgNRw
 25yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718908930; x=1719513730;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1WrcPu6ux6xTIzc9Spckyx2sySwM5IjSq2MtY54hdJk=;
 b=hTmr69t296eXZ36gBGeG91IVIxFxN7JPTnc5Ruf+yVnIHoUD6OEQ8Lag3wrEFXIUWK
 G6tatytz0U3ZbagImxsg3RJ3T77a2Ow6P7OifT1Y9C7Y4HdLnw1nIU9lSOV3Ey8SLGC2
 N2PglEy8U17j6XJ1dgscZF9dq3CQGJBVUT7V1c6ygKaLI3D/5OTftgOvbeC+Zd99MKuU
 UTA96CGx2ghHjxa5rGAc85sogVJv49Vn/6Y6Rr4vfVSvvwD2Smwq6zZQNNXZE6j5gr8T
 Fe2K9qhYxMvVfM4GzAF4WgaoSYm6Wh6z9tW1M4RFvv8ISaL6XuW6Pw0leLAPFeqhiRwj
 If2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHRI3wJnEb5t7QxeUUqBZvS/HqyXnt2s++3KC/+l4QDCr5VCEwP90UjUIYou40R7WMd61vaKG6NMQtUCujTSPq5qW1nRs=
X-Gm-Message-State: AOJu0YxKi7QCx4CRRkp4EcgGibGtT5Agb8jnUHTOIT5yIFSGTwmRqdNN
 ssotS7c/xvFLpiva+6irMwngwJ9snAGKiKVa29PeU3Qfh4vLEcKuMbRIDQlhNr/JfWsZmkX0SC2
 0OQM=
X-Google-Smtp-Source: AGHT+IESCbxBq//EbhUjCjtaspYgZpQC/pM3jxIvaBp1EccgI6dovnnctO7Pi0vRex2n/FupPweoJA==
X-Received: by 2002:a5d:45cf:0:b0:364:8f54:e0ec with SMTP id
 ffacd0b85a97d-3648f54e17dmr2719527f8f.19.1718908930066; 
 Thu, 20 Jun 2024 11:42:10 -0700 (PDT)
Received: from meli-email.org (adsl-31.37.6.1.tellas.gr. [37.6.1.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36431476efasm3700260f8f.1.2024.06.20.11.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 11:42:09 -0700 (PDT)
Date: Thu, 20 Jun 2024 21:36:47 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: 
Subject: Re: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
 <d32a653f-f741-4c59-8a6e-c2094e972009@linaro.org>
In-Reply-To: <d32a653f-f741-4c59-8a6e-c2094e972009@linaro.org>
Message-ID: <fe6m8.4d61etyid59f@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42e.google.com
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

On Thu, 20 Jun 2024 17:01, Richard Henderson <richard.henderson@linaro.org> wrote:
>On 6/19/24 13:13, Manos Pitsidianakis wrote:
>> +# FIXME: These are the latest stable versions, refine to actual minimum ones.
>> +msrv = {
>> +  'rustc': '1.79.0',
>> +  'cargo': '1.79.0',
>> +  'bindgen': '0.69.4',
>> +}
>
>A note for other rust newbies:
>
>These versions are pretty darn close to actual minima.  Ubuntu 24.04 packages rust 1.77, 
>which does not support (but has a warning reserving syntax for)
>
>> +    println!("cargo::rerun-if-env-changed=MESON_BUILD_DIR");
>


rerun-if-env-changed is not new, I think, but the `cargo::` instead of 
`cargo:` syntax is. Is this what the warning is saying?

Source 
<https://doc.rust-lang.org/cargo/reference/build-scripts.html#outputs-of-the-build-script>:

  Note: The old invocation prefix cargo: (one colon only) is deprecated
  and won’t get any new features. To migrate, use two-colons prefix
  cargo::, which was added in Rust 1.77. If you were using
  cargo:KEY=VALUE for arbitrary links manifest key-value pairs, it is
  encouraged to switch to cargo::metadata=KEY=VALUE. Stick to cargo:
  only if the support of Rust version older than 1.77 is required.

But this is not in any way necessary for us, we can ignore cargo's stale 
build detection and force it from meson.

