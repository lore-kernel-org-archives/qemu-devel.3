Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9820BFA3750
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 13:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc1JG-0007vj-Io; Sat, 03 Jan 2026 08:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vc1It-0007n8-0e
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 08:04:30 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vc1Iq-0005Fr-Pt
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 08:04:22 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4327555464cso3816474f8f.1
 for <qemu-devel@nongnu.org>; Sat, 03 Jan 2026 05:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767445458; x=1768050258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Ia9R79yRNWopSD0AE0WK/bL7v8Z1Xq0elWnJQXQZtmk=;
 b=pDEcWwYwCPd/v9wgNnTx/5S7fzQVY/W/q0jK2lgf0BrNIL0OKDUa94X8+vBIMVba+3
 qw5NITLdidm6vXE9enT/nBryylI5qI/EDLliVqo3VR/7pVs5wSj9q7M9UeX0RVbEjxaD
 W9RNSpWpyo+IYI0VIQgxx21GTRpIT5xEg5BertMb7zbg5byYojl4EdrZoS3TDCTfZ3Cd
 FItrZDtifWC34GUHYkxm6PKpDEnrJB0Du0yqXz+VFWYVhT4XkCDFqddDVr+twYSqM6hG
 iEKvfDBZuWT9/4mQfz2l0Ra6nzodQ25RPld7MUqjCODYNfyFaLzR7KJKP4uhb3b0a1NO
 6Hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767445458; x=1768050258;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ia9R79yRNWopSD0AE0WK/bL7v8Z1Xq0elWnJQXQZtmk=;
 b=W76uj+mOIbvIB4KNcs7l9pIdHKgviIwbwZiWgYYDOGjhH40FdSUdCh/pb++TM+cxW2
 U0M8jEB60uJSq0U30LVVCHWFGp+8BUJtVMDy2dGGV9iOPFGZutinUmg4VjYXiE2bOC/E
 MMd5u7DjpQvm04AgGerNUMZg3apeBlOJL3WGyjzdFP00Y1Xg34N3bQ5i9at5W551ZqJi
 GVGjTlJzRgDenZt4rgcDfB8QhXpaMG3QXB16WoiphQVs5twLw03VD6OO7ffhLWMk3+eE
 AKnRvO42DhuM7Cf9iXRTiCRQwlI32JyMV1QCYSdqLV1JjXenm5t1XxLA2F1kr0kDvru+
 36xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9OgA4chEF5l24hPSyD7plMKTerkfdD5RhgtJiPKFQAB3CyoTqPBb9VeF9sUwFnk9zK/SlxbwfROeq@nongnu.org
X-Gm-Message-State: AOJu0Yw9fewVH7S8cyniauSr+etsyT0YFJJAh9M3/4QHX4WFCS47TC5i
 D79nqrPhx6WEutzlr+opEKN93B0M9CntuNTGJcQ2WpszJ0O1Unr1By7rapFZPCjq1fQ=
X-Gm-Gg: AY/fxX5mNRZg3kySNuRXqLo0MhdVsvf+Z4TWKDTVWIGEzBzcAcNPLEBcFZt/ZyVtfbN
 fs1K/xivcOXz3cay46szArLDNx6/KVEqpbVWDQIWSkoeOg7o4vqyt2ntiDIZ6bMPYTr6gLTm3vY
 uqwPrIJSrdUvtZYAW2zeXX6iV4pWGQk2gARGKFd2jTq1qSjxkPWmxlM6J9LO5Pfc221qW1UMvSr
 aUlkvbslH42C5NF77GIxGd1ONB6CC8ACjEicdFk5gPO4FYACJg1ntZ/qGLtln+/2UwE0yqkRbDx
 rKUm3YCzRZOy+DQe0yhlGUAX2wPjWKCTSqz8/Aby1oKF+mCaqAm2xzqTcjLjxjOsnFJAzv15HN4
 In5qn0sFU11nvFoE+MKHFZbKKbw5kwrO3LFiD3g+XkiS4GtDxHaFnmji9QXIhClZ6KcpIaTvn+I
 611ze8kxa6x2gTWI/bMOMVp6LJN0cQNazNmdBALQLZvUHKqsybV6nvRf3+3BLXtPcfsIphdA==
X-Google-Smtp-Source: AGHT+IFCr4QeyWfDno/wapVu60xAuyRC4gYSxRGj8waZDLpQSkXanWwVuOF8zDdvkyNzxgR3e50HUw==
X-Received: by 2002:adf:f10b:0:b0:432:58f5:fb36 with SMTP id
 ffacd0b85a97d-43258f5fc8bmr42036296f8f.47.1767445457675; 
 Sat, 03 Jan 2026 05:04:17 -0800 (PST)
Received: from meli-email.org ([109.178.218.84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1afbfsm90338671f8f.9.2026.01.03.05.04.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 03 Jan 2026 05:04:16 -0800 (PST)
Date: Sat, 03 Jan 2026 15:03:09 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P . Berrang=?UTF-8?B?w6kg?=<berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2 09/11] qga/vss-win32: fix clang warning with C++20
User-Agent: meli/0.8.12
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <20260102214724.4128196-10-pierrick.bouvier@linaro.org>
In-Reply-To: <20260102214724.4128196-10-pierrick.bouvier@linaro.org>
Message-ID: <t8ahn3.37pmnt55v78m0@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x431.google.com
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

On Fri, 02 Jan 2026 23:47, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>C++20 deprecated such constructs.
>
>../qga/vss-win32/requester.cpp:380:32: error: bitwise operation between different enumeration types ('_VSS_SNAPSHOT_CONTEXT' and '_VSS_VOLUME_SNAPSHOT_ATTRIBUTES') is deprecated [-Werror,-Wdeprecated-enum-enum-conversion]
>  380 |     ctx = VSS_CTX_APP_ROLLBACK | VSS_VOLSNAP_ATTR_TRANSPORTABLE |
>
>This is a false positive, since VSS_CTX_APP_ROLLBACK is not a value
>defined in _VSS_VOLUME_SNAPSHOT_ATTRIBUTES enum.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> qga/vss-win32/requester.cpp | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
>index 5615955b6f3..74489fcd0ae 100644
>--- a/qga/vss-win32/requester.cpp
>+++ b/qga/vss-win32/requester.cpp
>@@ -377,8 +377,10 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
>      * To prevent the final commit (which requires to write to snapshots),
>      * ATTR_NO_AUTORECOVERY and ATTR_TRANSPORTABLE are specified here.
>      */
>-    ctx = VSS_CTX_APP_ROLLBACK | VSS_VOLSNAP_ATTR_TRANSPORTABLE |
>-        VSS_VOLSNAP_ATTR_NO_AUTORECOVERY | VSS_VOLSNAP_ATTR_TXF_RECOVERY;
>+    ctx = VSS_CTX_APP_ROLLBACK;
>+    ctx |= VSS_VOLSNAP_ATTR_TRANSPORTABLE |
>+           VSS_VOLSNAP_ATTR_NO_AUTORECOVERY |
>+           VSS_VOLSNAP_ATTR_TXF_RECOVERY;
>     hr = vss_ctx.pVssbc->SetContext(ctx);
>     if (hr == (HRESULT)VSS_E_UNSUPPORTED_CONTEXT) {
>         /* Non-server version of Windows doesn't support ATTR_TRANSPORTABLE */
>-- 
>2.47.3
>

