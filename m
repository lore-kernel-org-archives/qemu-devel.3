Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D371ED2F7E5
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 04:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1HzP-0005T5-31; Thu, 17 Oct 2024 00:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tang2417236213@gmail.com>)
 id 1t1GPV-00079n-09; Wed, 16 Oct 2024 22:38:45 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tang2417236213@gmail.com>)
 id 1t1GPT-0000kc-Es; Wed, 16 Oct 2024 22:38:44 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20c70abba48so3847265ad.0; 
 Wed, 16 Oct 2024 19:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729132720; x=1729737520; darn=nongnu.org;
 h=to:subject:cc:from:content-language:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=BKK1yRnVj3Xv2iIO9Vp3JgKTH6IM4sEsmC9UA5DGA5I=;
 b=DSlU7pOFcsH4+3BiCiZ9KiTKHZUgZsjKO70z0N/cQnn2MS3YD4MrxdK/QOiipWP/ZK
 CkL6fwJZJD9EDgL8Awp+Wzc/M6B2dVDQCCO5Q7Xecs3c8r53CNKqnpZXPH8CbcEthrdG
 vlVFnIfGlCM7hW169NBm61887P6p9h1uSqQJZNYQE6+g2pG1MmxZoRZp6DLQ+AQcSUl5
 Qi96mWebG41Jbn3rhMT1QBWk+Z6Vx879ph9YDZ4c7qjnJ+iGm0Gd4a5+Cv6Q24bqbYo5
 DC5CJsbK3RsH54OB9Y5sEr+38NLDh1GqROWYnqB+Py6k7/pTQsqxJJIzbQe7WJhTLjK3
 CrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729132720; x=1729737520;
 h=to:subject:cc:from:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BKK1yRnVj3Xv2iIO9Vp3JgKTH6IM4sEsmC9UA5DGA5I=;
 b=t9UXL0NNNZAyqosqjCY4PHmAKxTwHkKzSoW50mjsRoLFrDvEiHZXY9nlD7iRpL66Z/
 IDy1KanFlur/r4V5Rn2aa+bGZkbZMOesaBI8vI4Wo9e6PMWA/H4HSUvLxGULKWjLZ2oh
 o+hrX9iaraRGGvuFFT75z3igIPhIbkpgMqCKOJR59BhlaONMGI2rcrSlEUJ5KRxay7xi
 fnRyX6dsGOzzEk/7avqTH2yCPfHvwntsQK86tZrS0l1LDAYiw5LoBkn6kkmarxLUg/Gu
 HVQxC8NrzlKZ1C7pfVQ7tskgYSA9ysMjFhxbWxGtzWTpnnopSxqnvjNf2fu3fyhPpJlm
 fk+A==
X-Gm-Message-State: AOJu0YwXylhNbiHVAw7Wdo7A+eG8pU0cRDqj380WpmAsuwOY7K+uRGHo
 R+BCsa/04eB1o3K1xTgxmuEOZBmbu19PnMNgh5E33tUvQdIxREhyy8sLe+vi7hPpTw==
X-Google-Smtp-Source: AGHT+IEii9TNDva324ol/F4nWjEfe7Pvf1WqYX7y6o+IJcxxEXE2zofQfEQ2+3o7tvHGjV002Ya/qA==
X-Received: by 2002:a17:902:e742:b0:205:8275:768 with SMTP id
 d9443c01a7336-20cbb1a91a3mr201636295ad.21.1729132719594; 
 Wed, 16 Oct 2024 19:38:39 -0700 (PDT)
Received: from [198.18.0.1] ([104.28.246.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f87e04sm35266515ad.24.2024.10.16.19.38.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2024 19:38:39 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------PHQH20DW7c6nxfU7V32sKYA3"
Message-ID: <7fa54ce9-ce9c-447b-a537-0b4abd63f51d@gmail.com>
Date: Thu, 17 Oct 2024 10:38:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: TangTianCheng <tang2417236213@gmail.com>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 richard.henderson@linaro.org
Subject: Re: [PATCH v6 00/14] tcg/riscv: Add support for vector
To: qemu-devel@nongnu.org
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=tang2417236213@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 17 Oct 2024 00:19:54 -0400
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

This is a multi-part message in MIME format.
--------------PHQH20DW7c6nxfU7V32sKYA3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Signed-off-by: Huang Shiyuan<swung0x48@outlook.com>
> Co-authored-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> Signed-off-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei<zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Swung0x48<swung0x48@outlook.com>
Hi,

We should remove the tag "Signed-off-by: Swung0x48swung0x48@outlook.com" since the author's real name, Huang Shiyuan, is already correctly included as "Signed-off-by: Huang Shiyuanswung0x48@outlook.com".

Thanks,
TianCheng.
> Message-ID: <20241007025700.47259-3-zhiwei_liu@linux.alibaba.com <https://lists.gnu.org/archive/html/qemu-riscv/2024-10/msg00141.html>>
> Signed-off-by: Richard Henderson<richard.henderson@linaro.org>

--------------PHQH20DW7c6nxfU7V32sKYA3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre><blockquote type="cite"><pre
style="color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Signed-off-by: Huang Shiyuan <a class="moz-txt-link-rfc2396E" href="mailto:swung0x48@outlook.com">&lt;swung0x48@outlook.com&gt;</a>
Co-authored-by: TANG Tiancheng <a class="moz-txt-link-rfc2396E" href="mailto:tangtiancheng.ttc@alibaba-inc.com">&lt;tangtiancheng.ttc@alibaba-inc.com&gt;</a>
Signed-off-by: TANG Tiancheng <a class="moz-txt-link-rfc2396E" href="mailto:tangtiancheng.ttc@alibaba-inc.com">&lt;tangtiancheng.ttc@alibaba-inc.com&gt;</a>
Reviewed-by: Liu Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@linux.alibaba.com">&lt;zhiwei_liu@linux.alibaba.com&gt;</a>
Reviewed-by: Richard Henderson <a class="moz-txt-link-rfc2396E" href="mailto:richard.henderson@linaro.org">&lt;richard.henderson@linaro.org&gt;</a>
Signed-off-by: Swung0x48 <a class="moz-txt-link-rfc2396E" href="mailto:swung0x48@outlook.com">&lt;swung0x48@outlook.com&gt;</a></pre></blockquote>Hi,

We should remove the tag "Signed-off-by: Swung0x48 <a class="moz-txt-link-abbreviated" href="mailto:swung0x48@outlook.com">swung0x48@outlook.com</a>" since the author's real name, Huang Shiyuan, is already correctly included as "Signed-off-by: Huang Shiyuan <a class="moz-txt-link-abbreviated" href="mailto:swung0x48@outlook.com">swung0x48@outlook.com</a>".

Thanks,
TianCheng.
<blockquote type="cite"><pre
style="color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
Message-ID: &lt;<a
href="https://lists.gnu.org/archive/html/qemu-riscv/2024-10/msg00141.html">20241007025700.47259-3-zhiwei_liu@linux.alibaba.com</a>&gt;
Signed-off-by: Richard Henderson <a class="moz-txt-link-rfc2396E" href="mailto:richard.henderson@linaro.org">&lt;richard.henderson@linaro.org&gt;</a></pre></blockquote></pre>
    <p></p>
  </body>
</html>

--------------PHQH20DW7c6nxfU7V32sKYA3--

