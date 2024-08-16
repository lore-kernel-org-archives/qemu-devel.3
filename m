Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D55C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 06:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seqi2-0001Bh-LD; Fri, 16 Aug 2024 02:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1seqhz-00016T-HQ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 02:45:11 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1seqhw-0007RX-US
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 02:45:11 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71275436546so1474869b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 23:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723790707; x=1724395507;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b8gzFgTVIAQH27qbQUKzyjCNxudgMwVzpsm/5gkSJBw=;
 b=p34wFRo0rp2Y0Gu9zqLy9J2k5aT+TAr+JphN2ptfe5660T6gyuWAwvK1lkTzlsUKxc
 S2T1jrn4XEY+7j8Pb8AzoU4RvqKoYybVsv/AHisnNo7RiTos6Z3YRgMHvWdKW9BPVCTc
 AJQgi01DEQbRJ5SE9/h51oHsBFOLnEi7g6WUI53BuRKvCny3uGki6ktjioWRi1c6zi/h
 fbFpYlofdnRn1a/YAQO6AsqCOpRoWU58s90Dn97xAk90RwMVZwDAUN9ZsE0PHuVDKz1g
 B/ch4vxIhShccPOhPV8UIOALGuzoNN2nym+8IBellnvftvCNB79BG5vAmYCh6eAoL04+
 JPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723790707; x=1724395507;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b8gzFgTVIAQH27qbQUKzyjCNxudgMwVzpsm/5gkSJBw=;
 b=nO8B8QdjIEd8dmVs89fEKSDuupBpWK/CVC2YQfedeWykBL7XtX4/sGZHfK7pOr7Mdn
 N9Fj303PdoYvf5PzxP48QiJ7fTudBKMfLOFm9K3xkxOBmoG4yo+rEAr/CRU9vIutWgDx
 5CrHMrgssQsvLvNuxmNyk9JiiZV6ZZ0ucF8XQ4MkOKdxxMezfAFaDGBZQcaq5SrMiYoO
 5wTgAFyKK1ka1HKIVdloVs6QpOdpIeqwg+EwT4Eruvl825iFsTqfQNPeLDTmdVQJoFbM
 woKYqhssTU9CrRi6K/OMSkHIPByyzqW/BpktD7WZpnNCqFqZvxaCjjKEyl509nG/GvPD
 i14Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9XzU5Q5nQazwwRvZZtTDNtoUGqwHbtGBWEfb0giKo8+euiDoliIoGfwCWa9Ji/KmlV0NUNLhwQaGAsGsTE6Y/jBz1r7k=
X-Gm-Message-State: AOJu0YyfbNH5A67woM5KPshOu1o5IxTFEkLTgaZD4B7lxaxCmCdeQRrS
 c4Bn9MMGg+YmLYDgX8BWZT3OtOGIpVQFRXjfH2IXjrUAO7gpMfpYeEtrPxfEajA=
X-Google-Smtp-Source: AGHT+IGxd4WawryhEfw/0jY/+4YuNJqoJwKDGVL+rZ3Kjm20pb791btHBmesd/LIhXgsy+QlgpqIgQ==
X-Received: by 2002:a05:6a21:3416:b0:1c4:b8a1:6d54 with SMTP id
 adf61e73a8af0-1c905026d34mr2169270637.36.1723790706690; 
 Thu, 15 Aug 2024 23:45:06 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae08027sm2003069b3a.66.2024.08.15.23.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 23:45:06 -0700 (PDT)
Date: Thu, 15 Aug 2024 23:45:04 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 pbonzini@redhat.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com
Subject: Re: [PATCH v4 03/16] target/riscv: save and restore elp state on
 priv transitions
Message-ID: <Zr71cBn6z/5Jnn7R@debug.ba.rivosinc.com>
References: <20240816010711.3055425-1-debug@rivosinc.com>
 <20240816010711.3055425-4-debug@rivosinc.com>
 <b56dc234-10da-4f65-9dc9-a205948ffff5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b56dc234-10da-4f65-9dc9-a205948ffff5@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 16, 2024 at 12:59:43PM +1000, Richard Henderson wrote:
>On 8/16/24 11:06, Deepak Gupta wrote:
>>@@ -546,6 +575,15 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
>>      }
>>      bool current_virt = env->virt_enabled;
>>+    /*
>>+     * If zicfilp extension available and henvcfg.LPE = 1,
>>+     * then apply SPELP mask on mstatus
>>+     */
>>+    if (env_archcpu(env)->cfg.ext_zicfilp &&
>>+        get_field(env->henvcfg, HENVCFG_LPE)) {
>>+        mstatus_mask |= SSTATUS_SPELP;
>>+    }
>>+
>
>I think this hunk belongs with the previous patch.
>

I kept it here because this save/restore of vsstatus with effective sstatus during
VS/VU <--> HS transition. ELP also needs to get saved/restored during these transitions.

>Otherwise.
>Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>r~
>

