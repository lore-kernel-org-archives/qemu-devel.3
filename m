Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7427DC36017
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 22:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzNGU-0006dW-LI; Mon, 31 Mar 2025 18:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzNGT-0006dG-Js
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:05:53 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzNGR-0006IV-PB
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:05:53 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22401f4d35aso95373515ad.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 15:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743458750; x=1744063550; darn=nongnu.org;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAN0dyvPPhxVDmuQdBtnpIYo0HkknDzVuK6vFmNI+W4=;
 b=otKqSM4tbhL4d8QP3H4AItQed3Zvo7L/rdX27j/R4PfVkWP9ttBybEJkb7LMCarYhI
 Vzva+Ebv/adhOjRrEzfIXLcHdtImiZwtOSIXTAgO5AP1jePcq5b20C/WO5i6FTU7Pxah
 +U+B+aA3gKZmtjZORhS1lyf6rJa7GWryYjr8PNcxnno1ty1lbNoGVU7707c0xpKu2CoM
 vFNazBDoqmb4JYVXLF9s9jYtZTf6DY601jKDS4D3cBt9G4eIuOIJGDwjdgm623s/qI39
 dy3kjr7vqUsBkdfUmi505JnlRxEQ/uZgYqwxebjnMdwWdWFRxFCF9Kn9WgYjrPQvApkG
 PirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743458750; x=1744063550;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mAN0dyvPPhxVDmuQdBtnpIYo0HkknDzVuK6vFmNI+W4=;
 b=NQFOddlXD7rmYyUHVoIfF2LZBX4EcQ0CnMXJJrykcpjh+AYADzbR2Sp5MQJnoC8DKw
 dYRGC85qkhimDZcmPkskgY3Zjfpne3ltsAWbtgNN+0otELK+kYbKfxF/36MsVl07LOkX
 XRRmLyKeUBkKYINQSBbszBC9B1rVJZ+z1aYHLMz0v37cSO4u2xmwgS/exmqM0e+sgdlL
 mRr6B2XSVcITLcbeNdfSPQoRrQHGalgJyoKeyE5N7VOeUtzNXUBFAzToX29W1xPTFMow
 heI1NYEik0/Dhvnt1YVPEbeGvddiWCkjVQNXTdd4e2/7mlr0UgQEo2WoD2M8y6IxKbeM
 vP9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAhWqr0qnE77BnFlLEXoBbXedqyMVobP6YofFb47NEnOhf+P+YkopeiTUhObVApDndNYOap3O0kBjk@nongnu.org
X-Gm-Message-State: AOJu0Yz564LHGXMiW8VJO0Oy7RyI5TZx/ttDyY43w68SXAXa5xQPzaBo
 KvCDIx08pSou/WbHlSrdFIHTeSxN3kVBr90SOOJ9Rmzy7iHrFoedShmmrALHO20=
X-Gm-Gg: ASbGncsLNdimJVOlWHpn++w+6srXLEbyxpSKpc1vVmSDr4G3CpoYgKlXoL0QvChcAQx
 bo2k7VFB2S70ZeayTRT4v8jEcUmsYQWWDJh7osbIXoeZR95UCPSJ/8EKgp7m9R169lRJCs8Uv7f
 jlE+XNP9yeErqSKetkCeIse4fzGZ60Ybx3NC8rlLCKU6GM4xkIW7XpOaV4GkGCwb8SBuomHWIXX
 r/iGedNCqODrUCO4MTq1xpz9ChH1/j4Vxn9ZlZ2cLm/KYxtZp4HnGpKljPiX983uv/aLBqqDS4y
 USyHm+yZ7ns40VxetYYAhQnS86S1HjUqJMBRztjVgeu087JUB33gYDPQHg==
X-Google-Smtp-Source: AGHT+IGTywBW3ll5ZYlKTn2WHQhKGruhwd8gkYYG3FRNBRHq9uIDxDvnW/YFaEb401U3csq+5My0gQ==
X-Received: by 2002:a05:6a00:1a89:b0:739:4a93:a5df with SMTP id
 d2e1a72fcca58-739803ac1f9mr17831871b3a.12.1743458749964; 
 Mon, 31 Mar 2025 15:05:49 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739710cce59sm7482463b3a.159.2025.03.31.15.05.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 15:05:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------gmkhk5M0wmSCWN7qN9Pk0uA3"
Message-ID: <aec3ea95-684f-4498-980e-0d3e0cd7d1a4@linaro.org>
Date: Mon, 31 Mar 2025 15:05:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/42] include/exec: Split out mmap-lock.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-16-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250318213209.2579218-16-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

This is a multi-part message in MIME format.
--------------gmkhk5M0wmSCWN7qN9Pk0uA3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/25 14:31, Richard Henderson wrote:
> Split out mmap_lock, et al from page-protection.h
> to a new header.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

This breaks bsd-user which needs some extra includes as well.

See here for details and a patch fixing it [1] (also attached to this
email).

[1]
https://github.com/pbo-linaro/qemu/commit/86581aa3a01b62f1cd7797fc9df6fbc98be565ef

Regards,
Pierrick
--------------gmkhk5M0wmSCWN7qN9Pk0uA3
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-FIX-bsd-user-missing-include-mmap-lock.h.patch"
Content-Disposition: attachment;
 filename="0001-FIX-bsd-user-missing-include-mmap-lock.h.patch"
Content-Transfer-Encoding: base64

RnJvbSA4NjU4MWFhM2EwMWI2MmYxY2Q3Nzk3ZmM5ZGY2ZmJjOThiZTU2NWVmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQGxpbmFyby5vcmc+CkRhdGU6IE1vbiwgMzEgTWFyIDIwMjUgMTQ6Mjg6MDUgLTA3MDAK
U3ViamVjdDogW1BBVENIXSBGSVggYnNkLXVzZXI6IG1pc3NpbmcgaW5jbHVkZSBtbWFwLWxv
Y2suaAoKU2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmll
ckBsaW5hcm8ub3JnPgotLS0KIGJzZC11c2VyL2JzZC1tZW0uaCB8IDEgKwogYnNkLXVzZXIv
bW1hcC5jICAgIHwgMSArCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL2JzZC11c2VyL2JzZC1tZW0uaCBiL2JzZC11c2VyL2JzZC1tZW0uaAppbmRl
eCA5MGNhMGUzMzc3NS4uMWJlOTA2YzU5MTQgMTAwNjQ0Ci0tLSBhL2JzZC11c2VyL2JzZC1t
ZW0uaAorKysgYi9ic2QtdXNlci9ic2QtbWVtLmgKQEAgLTU2LDYgKzU2LDcgQEAKICNpbmNs
dWRlIDxmY250bC5oPgogCiAjaW5jbHVkZSAicWVtdS1ic2QuaCIKKyNpbmNsdWRlICJleGVj
L21tYXAtbG9jay5oIgogI2luY2x1ZGUgImV4ZWMvcGFnZS1wcm90ZWN0aW9uLmgiCiAjaW5j
bHVkZSAidXNlci9wYWdlLXByb3RlY3Rpb24uaCIKIApkaWZmIC0tZ2l0IGEvYnNkLXVzZXIv
bW1hcC5jIGIvYnNkLXVzZXIvbW1hcC5jCmluZGV4IDNmMGRmNzljMzc1Li40N2UzMTc1MTdj
YiAxMDA2NDQKLS0tIGEvYnNkLXVzZXIvbW1hcC5jCisrKyBiL2JzZC11c2VyL21tYXAuYwpA
QCAtMTcsNiArMTcsNyBAQAogICogIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3Qs
IHNlZSA8aHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uCiAgKi8KICNpbmNsdWRlICJx
ZW11L29zZGVwLmgiCisjaW5jbHVkZSAiZXhlYy9tbWFwLWxvY2suaCIKICNpbmNsdWRlICJl
eGVjL3BhZ2UtcHJvdGVjdGlvbi5oIgogI2luY2x1ZGUgInVzZXIvcGFnZS1wcm90ZWN0aW9u
LmgiCiAKLS0gCjIuMzkuNQoK

--------------gmkhk5M0wmSCWN7qN9Pk0uA3--

