Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABEBE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 20:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUtZO-0002Rn-MF; Mon, 06 Jan 2025 15:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tUtZK-0002QP-Jo
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:19:22 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tUtZH-00059L-LV
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:19:22 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ef28f07dbaso16892900a91.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 12:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736194756; x=1736799556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a9p8hjeIMnEMUpmW04h0W7NoiD5E5c5Q5zI/Al9/E30=;
 b=At76ze0wv8w/xsOHgsyR38SaEK4qqmB6PULMbaNYy565Il0mnJ8nJ0Zw7JyPlMo74b
 Eurzp30dhGPUIvzntGS7so7YwHrEjcRKqsz0Aevn4fe5FCKH64N4uEHDtI2nx/PI0VOe
 1Np584k3n70csVcBnq6gTwNaNUMtWb8R1BBueylXlHtiEsmvouh8xzC5KkK9FCSFf8uI
 5hjfaxFKCj/0DtQuUpE4p8V9qun+BQQqbCk1KBVJrzwC8LrKc472hkeipAHkMROU1cYZ
 m73cIwtETFS23JR9yk0cHWSf/Dols2Rs+FgiAOEN3bR0SIQaJWLnwHpC+9jvtPyrJM/d
 8P/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736194756; x=1736799556;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a9p8hjeIMnEMUpmW04h0W7NoiD5E5c5Q5zI/Al9/E30=;
 b=H9Fx8A2L79839Fm+gYfcnT3xuUtkdvC+1TWxPyt+O9W12YKYnjr/IJ+LEEkhzL5bCv
 OnqSAUvVWloXNHjWi+uW9MbRJ2LIzBk5hKJ+bDqKwHJRKO2Gda2NDSF3arUvGzcfk0Rf
 C6SgtSVelgots8OCNpeorLET5AuUKYdTqQy78Ah53rwX9g6aLAMJ6yS8Gnqz8QNEDmkr
 JSSUGdohJx8XgumiVWnNvgBkEKk0rXq9+/jydX2ZeSjU/wzBtbx1svl8Uzvrf+2DCRw2
 sgpu5EW0mmzMJkDScn9W/pkw+bT1BTtZ0TP0KbnM1Lcw6kzLZOU36xIw/vwPiSxJiroq
 rCYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIKUJaB25fw86uN6n2XWXwCM9jPUGg4+gUlbo0LpTECvoQBSneapo8T0IdBUqDlicBDmiUwHHWFWTo@nongnu.org
X-Gm-Message-State: AOJu0YyIv0j03VAFyRPPuqDMkj4qkCvf6SSf4wglUWAbRiUtVi/dRP4p
 LK4arRLnr+Mse4UAjb+9rm7lTboGVyuTVa9phfwGUY32dr5hD/TW/yNqiMUXYxU=
X-Gm-Gg: ASbGncsJf4qFyJ3i1eBjvb5021ea4/Pf4xpB7p5rYUcQYMGU6oEPxiCbr74Noc5ZiwF
 GwJrzu/yqcALfZaCKvBk5ZrZ68+/sldXyGsMVEqie39AGQ5qg7c8hQPOm8KCbEAD3fpGHutLGXT
 tG4u0b6OGMhOO5LxoL6OwSxtpAfIr70iGL64Gw+exW8XCobs5GnQOXVGIfs1dpqQLAW7eTkso57
 6GXcvK0IYm5nqyb09lBM/dsgCjLHK/QTTMlfdAbvB72U+2pww7f9Tfu7FzzukZu5wjII/jAOzLm
 PlYjXLhsn4HlvADDP9p4HgjrU16HHMbik2U=
X-Google-Smtp-Source: AGHT+IEdi1WeRPTrXeJrhazkx/sBhP2RZVeyTSKqrV/o+q5vpCxn6bBHpDXsADAKiAGaa0ShcqYeAQ==
X-Received: by 2002:a17:90b:51c2:b0:2ee:ab29:1a57 with SMTP id
 98e67ed59e1d1-2f452def211mr85711065a91.2.1736194756055; 
 Mon, 06 Jan 2025 12:19:16 -0800 (PST)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26b125sm39870772a91.43.2025.01.06.12.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 12:19:15 -0800 (PST)
Message-ID: <69e79cef-214d-4795-b3ce-032529c9f7d6@ventanamicro.com>
Date: Mon, 6 Jan 2025 17:19:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/7] cpus: Restrict CPU_FOREACH_SAFE() to user
 emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>, Paul Durrant <paul@xen.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Anthony PERARD <anthony@xenproject.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, Zhao Liu
 <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 David Woodhouse <dwmw2@infradead.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anton Johansson <anjo@rev.ng>
References: <20250106200258.37008-1-philmd@linaro.org>
 <20250106200258.37008-2-philmd@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250106200258.37008-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Perhaps add in the commit msg something like "it's only being used in
bsd-user and linux-user code"

On 1/6/25 5:02 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   include/hw/core/cpu.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index c3ca0babcb3..48d90f50a71 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -594,8 +594,11 @@ extern CPUTailQ cpus_queue;
>   #define first_cpu        QTAILQ_FIRST_RCU(&cpus_queue)
>   #define CPU_NEXT(cpu)    QTAILQ_NEXT_RCU(cpu, node)
>   #define CPU_FOREACH(cpu) QTAILQ_FOREACH_RCU(cpu, &cpus_queue, node)
> +
> +#if defined(CONFIG_USER_ONLY)
>   #define CPU_FOREACH_SAFE(cpu, next_cpu) \
>       QTAILQ_FOREACH_SAFE_RCU(cpu, &cpus_queue, node, next_cpu)
> +#endif
>   
>   extern __thread CPUState *current_cpu;
>   


