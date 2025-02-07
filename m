Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F68C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQi4-0005v6-Fp; Fri, 07 Feb 2025 10:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tgQi2-0005ur-J4
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:56:02 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tgQhx-00047G-2o
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:56:02 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361f796586so26940885e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738943755; x=1739548555; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MSZ4dptb/XUGTZW9l+GO3/6hfDdSF+v7Rw+rW6p9JN0=;
 b=IM0mzj3LQDo5eNiEcAlce/mVcPALRY0Cf9XP5gqZC7gjId2jdva5p0fPmjBLAmz1m7
 qDZyGsJuDW1Q7zKm1TaP7fx04yG34bvp2vJcCCIIEDsrWBx1P1iH4OLttwcIPjRtF5Qj
 gXcXkxm2XMmeVy7SV8ec760j/lPcm00R4iv54fgKAYQ1YYsWJBI6BvxBhAZwa/MEWB1M
 Ghx9DZR3u3GaCUa25wDxTSC0G443uxnwRwknHgcy5lQwwtIkCorxHSdoS7PXtSJYW3+U
 nPYniBmAozMfQHM6gqQIIoK3IxL49GsW+DSCJIU6izjdZ8ggO9bfpW+YBXj3Sn0oRl/U
 weGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738943755; x=1739548555;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MSZ4dptb/XUGTZW9l+GO3/6hfDdSF+v7Rw+rW6p9JN0=;
 b=CS0pMSPcOQnXzPFVu2Iyf/LcusCXzEwnQBnadLDOrxZF572fTsWJqqbXbFBoG49vHv
 i9fulccxM8/cDRQCxPpdrcDKvEkOF/5y3IlZcF1UlsPRLQGmbsCf6VQBN2QaDCT3o4Cx
 WFUx8PazYT30cvMeP/ORKybHPcBn5at2K6p+6m8MDJl731SmvyICRZDupke2fbddAjmm
 KyyjSZUkZMw2S9Stc5ipSctHmVipUTLjEbEN9GR46pY+w79TmP8+49J/TVFqm60RMpzy
 R/8X3Oc4TzIajXFevDGj4RyZ2a+W2Zm9npvNQMfH8NV/qg0chww0CBLvzIh7Yf8HnYwv
 577A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQqJGXt831SoI3C9SP3lqEPH7BgZjKzvOAvpzcGerS+KGO/tm0eAgWUiozN6fAbkkW8V3KMAmXwPNC@nongnu.org
X-Gm-Message-State: AOJu0Yz0R0xj9bvhfh53RbT6l58ZtybUw0LSuDKixHEjnO6SQts+e8wj
 4RXXToeQGRAn8zhFmfrXYNXeENCKSH9o7a7XS6giPsvOff422yQr8QEoOZF7nlY=
X-Gm-Gg: ASbGncvblXKw2PiMdBtmFundttOb6YrxcjAXcM/t3qvowxk7l/8TSecRMCLIQXDJ3P3
 vZKa4xukYfYDqEws/gXN78dfnC5y3dzvf6mbOp35l/OtEr0DRhaWgG/0g3WRVWRIEfwk1MPxlik
 hRgGQBJspWesRkv1+l57QWFq0WmvAQWLdgmDsD5G7pNEb43UJT4f6RP3xxlzKS5Xuf4ZFGzeCGI
 JVAcvmPrCjVZzGlfdGhYVSjGHMFaHRh5EKhy+Gyw1wada+ZDcxfe2xGvGdVI/UBRg5+y4RK6G+q
 dCpxNjHlltzsAQ==
X-Google-Smtp-Source: AGHT+IGH7xY+Rmlbrhod6MMhjMCRL2N2l3zbaP3gJ43PnqqCRx3iRViMR60etQJqTMEk1LndR6IGig==
X-Received: by 2002:a05:600c:4f8e:b0:436:1baa:de1c with SMTP id
 5b1f17b1804b1-43924990cdbmr41947565e9.13.1738943754861; 
 Fri, 07 Feb 2025 07:55:54 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc0c5a894sm4336016f8f.95.2025.02.07.07.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:55:54 -0800 (PST)
Date: Fri, 7 Feb 2025 15:56:18 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Subject: Re: [PATCH v3 06/26] target/arm/kvm-rme: Initialize vCPU
Message-ID: <20250207155618.GB3546768@myrica>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-8-jean-philippe@linaro.org>
 <abb2bf76-2548-4c2b-a971-502ca623aee2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abb2bf76-2548-4c2b-a971-502ca623aee2@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x329.google.com
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

On Tue, Feb 04, 2025 at 03:02:41PM +1000, Gavin Shan wrote:
> > +    reg.id = AARCH64_CORE_REG(regs.pc);
> > +    reg.addr = (uintptr_t) &env->pc;
> > +    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> 
> Nice place to use kvm_set_one_reg(). With it, @reg can be dropped.

Ah indeed, that's nicer

Thanks,
Jean


