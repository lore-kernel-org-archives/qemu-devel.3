Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDD5CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usySr-0002sj-AE; Mon, 01 Sep 2025 02:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1usySc-0002kl-Pq
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:56:19 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1usySW-0004td-I5
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:56:13 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b040df389easo231727166b.3
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 23:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756709762; x=1757314562; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qNbXwqLG6Y7c3wCCywsmaVJy7D/9jX0NIEoAahW0amI=;
 b=w9Gi99kV7h+VMOErdsakVoKgkHGQ8AHCOgTbgVFt3qJIjKgg4wpLboU6o0GRvwiQiy
 6RdOG6tlBWoO19y16OBsJ8wLZ5oJra+TJQ9OJlENm3KJxu0JYVTzohkemBtbcOWEz/CB
 +QBTuUICnxuQjK1itPu9uKp+eni2r+E/I9vjsNgAsWQNCx4lvk481Erl9UTXVEwoGEiY
 n7NCcQZw0byoZlDBkanJnToJgesNMftKRiEzWnUJWQ+8h78K7LHmDRPgjsv3LtL0J1Dj
 5qB/RKBn6X5AC7+yIBBG3xxPoW+TFFQDEBVmYLNQnFy5bGtVFYvDYolQ8XdoNny4Y9jf
 Rgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756709762; x=1757314562;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qNbXwqLG6Y7c3wCCywsmaVJy7D/9jX0NIEoAahW0amI=;
 b=eGS3LwNtS7CmJwtIb3X8v7MQFAfOdHXDLuShPMWT5r3UYbhrZtVin16yCxu1ZCmqC3
 S7GwMpj6yugGRwfhSR8DFasyXugJn4cBTSiz+fvEyotYycgtxHA3ws4iGhA2PBuYsnFJ
 //hmiYKKcMvuzhTUq2MBVfELzACSZfWA0HkjQiUF2SzuiO4tedPgKyd8lO3tNexp1Mkb
 vlyHj1olMilygZSDZLZyqckERolmPt3IyDkU6wZ8BQ/8RYKbS1bpgD5MeDCBfWFiZfdd
 UCUFK36AQLSESYblI2YdIx0MT6dBzLUS55Yjcr49X9vYnC97p7YHOCVkWFzpBdSC1l7x
 Tvnw==
X-Gm-Message-State: AOJu0YyvTIiB4/IKHPtH3poLFJiF5/mJmtxCE+FNIzzZX1MsAlJ/gxCN
 ZFhMIm2skfLLfuP3ozEcuQUquL8EXK//utIkHqG1pBI+h4EQHt+diisW6bqp9mreImtPcImo2AQ
 dl/Sp
X-Gm-Gg: ASbGncuJRskCioAuRCdH7REon8e/ZboIU5c//AuQ/uOxXoZeHPpJGVAVhK6bew9oORe
 owqnOTko2JL8DO/sL30+xxALUYv6YDr3lC0fkEt/1yZN9cSC21V/QrHb+KGBzRMR9MVsgMh4ERq
 QbUGJZtchnfpB/z6zd2zUzYeN0LQXg4aB4i8oZeRcMGhotau0lld0Ri6Hqe7KJcGsDTa4QELvOv
 0B8cl77kcbCiYXpaqv9lbrcLCjCzG5J/bpYhbb57QZSONZdnDK81PDTkEpL4tNgSMFTCdRTATdC
 tevzXqAfleZZRcxHLyia6iqaUJ04KUdhhDUx4U4Pb2Ekui2l3AvBlF/giw3qNf76veNWaO7uoVN
 tBmPige7rBORu+Lml3IQ1Vy48SfRPICjbx2a8spJqfelAjdb8TdSZqY0ODfz95lQ+ywKY/+hZH+
 qOgNYeoEw=
X-Google-Smtp-Source: AGHT+IE1pzzW0+yy6Uenxf/Yu+0Lwe5R/55dB9IpSI0UL0BlfK39Gr+Ds9BA2GpkhQEE0siWdNGvLg==
X-Received: by 2002:a17:907:934d:b0:afe:dbfb:b10e with SMTP id
 a640c23a62f3a-b01d979d48dmr598976366b.47.1756709761681; 
 Sun, 31 Aug 2025 23:56:01 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b04241b2e7esm236917366b.43.2025.08.31.23.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 23:56:01 -0700 (PDT)
Date: Mon, 01 Sep 2025 09:55:39 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: Re: [PATCH 38/61] target/arm: Define CP_REG_SIZE_U128
User-Agent: meli/0.8.12
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-43-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-43-richard.henderson@linaro.org>
Message-ID: <t1wdxc.1rr033zmra73t@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62b.google.com
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

On Wed, 27 Aug 2025 04:04, Richard Henderson <richard.henderson@linaro.org> wrote:
>Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> target/arm/kvm-consts.h | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
>index 54ae5da7ce..1b3c10c0d3 100644
>--- a/target/arm/kvm-consts.h
>+++ b/target/arm/kvm-consts.h
>@@ -30,6 +30,7 @@
> #define CP_REG_SIZE_MASK       0x00f0000000000000ULL
> #define CP_REG_SIZE_U32        0x0020000000000000ULL
> #define CP_REG_SIZE_U64        0x0030000000000000ULL
>+#define CP_REG_SIZE_U128       0x0040000000000000ULL
> #define CP_REG_ARM             0x4000000000000000ULL
> #define CP_REG_ARCH_MASK       0xff00000000000000ULL
> 
>@@ -37,6 +38,7 @@ MISMATCH_CHECK(CP_REG_SIZE_SHIFT, KVM_REG_SIZE_SHIFT);
> MISMATCH_CHECK(CP_REG_SIZE_MASK, KVM_REG_SIZE_MASK);
> MISMATCH_CHECK(CP_REG_SIZE_U32, KVM_REG_SIZE_U32);
> MISMATCH_CHECK(CP_REG_SIZE_U64, KVM_REG_SIZE_U64);
>+MISMATCH_CHECK(CP_REG_SIZE_U128, KVM_REG_SIZE_U128);
> MISMATCH_CHECK(CP_REG_ARM, KVM_REG_ARM);
> MISMATCH_CHECK(CP_REG_ARCH_MASK, KVM_REG_ARCH_MASK);
> 
>-- 
>2.43.0
>
>

