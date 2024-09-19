Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A796CE8D52
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 07:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srBFF-0006Tu-0R; Thu, 19 Sep 2024 03:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1srBFD-0006R0-EC
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 03:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1srBFB-000713-Cs
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 03:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726729584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qxbNmeE3LusfWiF21hWN8Ui5QNyTLC27qmunUfq4r/0=;
 b=NZ+nzu1jTp+vLND2V5rX6wsfGIqmejnhu3wmzNDZIRqlJiAVesv/ONPOvNGLiP9Gqm9wjF
 NYQJN8wHCVnZvZYR4ETYbnNdwNJOTXIX0Iy0VDL3U9oIv9g7P2K2Y/pNXQKmnM1pU8eiE1
 hP2galSWg0QwiRFjuTT8UUuzopFvGDA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-3OPRGPZWNPOm-vNk4WAw6w-1; Thu, 19 Sep 2024 03:06:22 -0400
X-MC-Unique: 3OPRGPZWNPOm-vNk4WAw6w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb830ea86so2994595e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 00:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726729581; x=1727334381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qxbNmeE3LusfWiF21hWN8Ui5QNyTLC27qmunUfq4r/0=;
 b=OkDhuC44pU1kaKgJnHX90/JEAiSnLD7H9nFQBV5sR4dy4MqeSmV1blueOBVhOPV+1K
 5fC4AWKxzDHHO2u9Bnynmh+/CaB7nLbvx3ku4FwfhbRNau7y5XGrSa8w3RG1ioV71hcU
 spfMvFnIN3hnYMFWZTFEOShVOVZTmeoeG0AjkB2L4ynKU/1IUQhjnUAueXxMmPMxEa2E
 KhHRKBqreX8tx+6xyuqI1sV9jYMTMgjh5R1fYILXR9cMdKzLbVI9NYjrh04jy+WwPZ48
 9TaRrQuqogBWAcOOhntSeaJeFud9wpqTLTF/B5Tr8KN1F9+lvI5Gix5e4y5Gp1kSzujY
 yqpw==
X-Gm-Message-State: AOJu0Yynmc5Dg9X9OlPxnG3TRph0TBBFbSNH5to5VlgxM0BTLBIXdbdQ
 +9z79/gEGg44dFpW14sNEZwf6r0Bq8Xq4KVFmwNkamxYNJPA/Xjz3hJmHFmP7bYqp8Vb07FIrSQ
 gMKgQEOu7n7ZTZHkVbmroew9ZrANL66B6Ay88PnwTPU1CGWhkByKV
X-Received: by 2002:adf:a45d:0:b0:374:c847:848 with SMTP id
 ffacd0b85a97d-378c2d5a70dmr12027882f8f.36.1726729581346; 
 Thu, 19 Sep 2024 00:06:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5RL3uMfBR8XLRh035DgdZQsypR0OykDYweXpRD8gyTZzlCHNC9WQ/o1VaFxqi09Id3WeT9Q==
X-Received: by 2002:adf:a45d:0:b0:374:c847:848 with SMTP id
 ffacd0b85a97d-378c2d5a70dmr12027859f8f.36.1726729580896; 
 Thu, 19 Sep 2024 00:06:20 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73e81a5sm14367890f8f.34.2024.09.19.00.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 00:06:20 -0700 (PDT)
Date: Thu, 19 Sep 2024 09:06:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>, Yipeng Yin
 <yinyipeng@bytedance.com>
Subject: Re: [PATCH v3] i386/cpu: fixup number of addressable IDs for
 logical processors in the physical package
Message-ID: <20240919090618.463a03e4@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240918131815.8543-1-xuchuangxclwt@bytedance.com>
References: <20240918131815.8543-1-xuchuangxclwt@bytedance.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 18 Sep 2024 21:18:15 +0800
Chuang Xu <xuchuangxclwt@bytedance.com> wrote:

> When QEMU is started with:
> -cpu host,migratable=on,host-cache-info=on,l3-cache=off
> -smp 180,sockets=2,dies=1,cores=45,threads=2
> 
> Try to execute "cpuid -1 -l 1 -r" in guest, we'll obtain a value of 90 for
> CPUID.01H.EBX[23:16], while the expected value is 128. And Try to
> execute "cpuid -1 -l 4 -r" in guest, we'll obtain a value of 63 for
> CPUID.04H.EAX[31:26] as expected.
> 
> As (1+CPUID.04H.EAX[31:26]) round up to the nearest power-of-2 integer,
> we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
> integer too. Otherwise we may encounter unexpected results in guest.
> 
> For example, when QEMU is started with CLI above and xtopology is disabled,
> guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
> calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
> as the result, even though theads-per-core should actually be 2.
> 
> So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
> to solve the unexpected result.
> 
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 4c2e6f3a71..3710ae5283 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6417,7 +6417,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          }
>          *edx = env->features[FEAT_1_EDX];
>          if (threads_per_pkg > 1) {
> -            *ebx |= threads_per_pkg << 16;
> +            *ebx |= pow2ceil(threads_per_pkg) << 16;
>              *edx |= CPUID_HT;
>          }
>          if (!cpu->enable_pmu) {


