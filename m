Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00657C3DA42
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 17:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sREbS-0004UY-OP; Tue, 09 Jul 2024 13:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sREbR-0004To-51
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 13:26:09 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sREbO-0003JX-Tm
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 13:26:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70af8062039so3317094b3a.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 10:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720545964; x=1721150764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RzSE50T9N8PHLTl0ySlfAZSrWt+jaKUEg4tCnAG1Fq0=;
 b=YJ+aAj8q4N/yILL2Pn2J8ort4CJ0q9bE7usFDXGg6v8KcwQ1h7YSqt2zcHf2h7z6vw
 1eHo8MDGZ+2isH2i+pfMJucRFKyuQ1VIyB0sN3/BzxhVyxvn4ciR8GEKEprj9+153AlR
 J+BdPUBdk2DiygC4eWpQ+nCIX4K1jHIzv6StVS1SbsOb+4KFSfOo9FbcriEGWdpQWENx
 B4mdO22YUrn2e4xrJaoPl9eB5MgRMimybsFsx1+SbEE7QXv88djyopsh5q7Mtq2YxtSC
 mJhQ+uejs9wF+77SNGAYzdRB/IpEyNmTjkhtV0JzttLQeu/rB9lJ+DfmsVKQodFkWAIr
 nf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720545964; x=1721150764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RzSE50T9N8PHLTl0ySlfAZSrWt+jaKUEg4tCnAG1Fq0=;
 b=EvxX2PmUQMKez2afUzxfl89bHJ1xKfj4OFqeEyLirhavD+N0kU+bmDzezJCFcWEkPu
 wyPH0W+C4RoVv/yP7QJf3FKk9AUwGuAtP0dMQkC+yEDs//DFWoK4XYhbIHvGr4SREn8I
 CJkKfky9GKxpMh7cuDuh+tiNk0fQZzHjRrZX4rtxys/2nOi+A2lSinv4JsKVCdkZwROE
 GXJSeRyVrpiHQGQ1PJhGOgGMDqm/wuSQOnruIX+/alXQdyqIKDGU5kDoE73Q90chQYG3
 PubjGwmslTumcQwwmIclR2pvyNnvxJTrdz77SmHKa/n+GqM1tWml6C6hFRN2Rzo+e6GU
 c9Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIYjU/2FgOsK4yHtBmMvDFRL4BOuJjogK+diLt+I3Icg8vO94K08SDFajM9/rjk5YjBCOrACNjrBhH5lTOoEAx+CZHJTQ=
X-Gm-Message-State: AOJu0YwvyHMmSPoW+rCSTZgiHxTiZm9vbXBQbfX9ralXGvbLdSvPLydB
 P/GsVish7epYrnJ3YEq+5OL5VdsTUMNtA/HbT86HErm/5iQpNb205NYxBD5F8TgEBERNYPcgLdD
 mv3g=
X-Google-Smtp-Source: AGHT+IEqiUUBHRfgo5dEMtfC/XCNKPLGJBkduVqKYq/HblQkcW61CjFdauvMkwc7tUD35LxhqZSiKw==
X-Received: by 2002:a05:6a00:2e87:b0:706:6272:417 with SMTP id
 d2e1a72fcca58-70b43543583mr3686917b3a.10.1720545963646; 
 Tue, 09 Jul 2024 10:26:03 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b4397c02fsm2156986b3a.143.2024.07.09.10.26.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 10:26:03 -0700 (PDT)
Message-ID: <7da70fe7-08e0-4715-bb69-079eb16cff70@linaro.org>
Date: Tue, 9 Jul 2024 10:26:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] vfio queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20240709115017.798043-1-clg@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240709115017.798043-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 7/9/24 04:50, Cédric Le Goater wrote:
> The following changes since commit 44b7329de469c121555a1acf9b288f3ae71b8e61:
> 
>    Merge tag 'pull-qapi-2024-07-06' ofhttps://repo.or.cz/qemu/armbru  into staging (2024-07-07 13:23:28 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/  tags/pull-vfio-20240709
> 
> for you to fetch changes up to 83d90192026eaded6319a6d27466ad7d606a27e0:
> 
>    vfio/display: Fix vfio_display_edid_init() error path (2024-07-09 11:50:37 +0200)
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * Fixes on VFIO display
> * VIRTIO-IOMMU/HostIOMMUDevice: Fixes and page size mask rework

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

