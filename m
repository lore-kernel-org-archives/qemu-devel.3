Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F0FC02192
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrpe-0007Fm-EY; Tue, 28 Jan 2025 15:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcrpd-0007EF-Ak
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:05:09 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcrpa-0000cJ-Vd
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:05:09 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so595085ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738094704; x=1738699504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NrMURijWdUs+plJn0+O/g599W4J/6E9e0YB54gRpbcU=;
 b=n+vIGJCsPGnPJi+8KcYDUPVAokaKsHB94GZCXV6w7BPzvc9QfGUYzpX51BmJWPYwKo
 KSntmXLXsvmyu8se28mYofkvm3BoCH8I5oSJgPXX/BPSQ9MYE3ttuLOu7nMPxTbeM9Ze
 k7pGe5Is/tMXNHsPqs9jQLLbEaQk6avpqMlsw0f/gYtjhWB46L0QmXcYdzIwpkGSV0SG
 5u6RxvpW1nHcykf3CtfpM4jxSjw0y8mfSEsEjO/+VnofTpPrg4JVta72azidWBp3UvhU
 HekTiee06ha2oo7nI8MoMrzw81Ck6o4A2FB8+58r3cEPhf6s4++BrnKhnO5tN0JxBZZi
 2Jlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738094704; x=1738699504;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NrMURijWdUs+plJn0+O/g599W4J/6E9e0YB54gRpbcU=;
 b=rwj9dUxA+ksB4cqFIlJuwIYEUtOkg/pwkEyB+ts+DYJuVIhVtwDTVnEl/a0UFHbgb/
 QysmKkILp1Z2fOWrKvBzHklylOGXeUh0LCCO32cbm4un97e64SkwXPAg2GWcZBgpKIgG
 IFiWUQ62pwaKcELT6zKDT9VbYWh9eqOgBhZTU6cEkrOq8LDjCCXH/X1HNEaKKFJrftec
 /nF3LYVAG3EuDTtSLxwPVcKJJJ56X24j2wnyiZxb+vJcFuWF0eCrUxsIjm0+awxh2H4H
 2rbARw+Q2X0VN9oa75vzqTFhtbrK7yOdnksbrB5BFIVsjYhZAt8v/Dmw+hkHPMbIIj5P
 r1bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0ah3hytU6riEK5C6oGqV+SK+Qx1G5wymcAkw0vGONwNtHRdH8GZ++Swr/1RnY6a0sN7n1tqgRAwPu@nongnu.org
X-Gm-Message-State: AOJu0YxhWlo0K03zlkhpMyYg5FHx7vmWXUB+MCDhRZAWrtc1H7Kax+BY
 Ro5VUaCRqHqGmoOrXx2k5mTK9Te5n1yQNf3tL1X/apxA2VLYT0e96TdP4jbCJLM=
X-Gm-Gg: ASbGnct/Vl1z1akmR52i8gxJEgW4+zUD+9LTvbQQumcf9XbWiseqkH2qAJoNgcRXsCX
 XUxl204mG3U4hk81oXKtX5U4mLIlFbjoPYhizwQyCB6zuMKnPMiO+Mt4S0Rera8QdA5b0R+Lvv/
 ZOyZDXW6E/MX2kNzLK6VzTuX7j8JU7bqsp0Sb+0rPi24ITISQcVr2BEgb4FT1OEDhAw7mH+UCkW
 Sxy0fmjt1pPeS1pu6NVa3SOReEL3e0stTZFPTP7ChSQDue/Il9KDyAiAD4pLGtFtT19Vlc/wGpt
 XsnlJyBH4vb2CEWux9MVIpnQjx9G+GdsXDu2vpjKOkX3XyTPxqYDgjI4xw==
X-Google-Smtp-Source: AGHT+IHd+NTlTxV6KMD27jhD57XSGRNJVXHIytl1bnq1Y790GKKq3cS/lQCgRGc2ZhYqUnxxhOI2eg==
X-Received: by 2002:a05:6a21:1394:b0:1e0:cc01:43da with SMTP id
 adf61e73a8af0-1ed7a332a6amr964283637.0.1738094703032; 
 Tue, 28 Jan 2025 12:05:03 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a69fbfasm9923136b3a.16.2025.01.28.12.05.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 12:05:02 -0800 (PST)
Message-ID: <0d743a68-aa29-4a0f-b24d-69ff4725ee22@linaro.org>
Date: Tue, 28 Jan 2025 12:05:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/9] accel/tcg: Invalidate TB jump cache with global
 vCPU queue locked
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250128142152.9889-1-philmd@linaro.org>
 <20250128142152.9889-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128142152.9889-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 1/28/25 06:21, Philippe Mathieu-Daudé wrote:
> Invalidate TB with global vCPU queue locked.
> 
> See commit 4731f89b3b9 ("cpu: free cpu->tb_jmp_cache with RCU"):
> 
>      Fixes the appended use-after-free. The root cause is that
>      during tb invalidation we use CPU_FOREACH, and therefore
>      to safely free a vCPU we must wait for an RCU grace period
>      to elapse.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tb-maint.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index 3f1bebf6ab5..64471af439d 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -891,6 +891,8 @@ static void tb_jmp_cache_inval_tb(TranslationBlock *tb)
>       } else {
>           uint32_t h = tb_jmp_cache_hash_func(tb->pc);
>   
> +        QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
> +
>           CPU_FOREACH(cpu) {
>               CPUJumpCache *jc = cpu->tb_jmp_cache;
>   

I can see how maybe this can appear to fix the bug, because one can't remove cpus at all 
while the lock is held.  But if the description is accurate that this is RCU related, then 
the proper locking is with rcu_read_lock/rcu_read_unlock.


r~

