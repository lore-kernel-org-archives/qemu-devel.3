Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEA2CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcUL-0000vV-R3; Wed, 06 May 2026 09:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKcUK-0000uF-0l
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKcUH-0007qT-P7
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778074828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iLH39jHv8OxYhzuAcdZjOpJEhvHV6CNvNZ1jnpH+NqQ=;
 b=DkB30p3idG4uS//wVvSsxgO3f8fJZoKqKUtHxs5VS8NSEo1LN56gS83jWClSiIJgwMjIYk
 CCFliOTis467xIG62x/Jj5RMeA8tFsaNtYDWvjMIYSi61dZR87DKsv0BQV+FMAwQmYJW8p
 SuHo66vJ6GFkzScHbIFyrXDyksnrcAU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-bpTkWKKkMTmFs7XyBJeAEg-1; Wed, 06 May 2026 09:40:24 -0400
X-MC-Unique: bpTkWKKkMTmFs7XyBJeAEg-1
X-Mimecast-MFC-AGG-ID: bpTkWKKkMTmFs7XyBJeAEg_1778074817
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5a12514a844so3486033e87.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778074817; x=1778679617; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iLH39jHv8OxYhzuAcdZjOpJEhvHV6CNvNZ1jnpH+NqQ=;
 b=ILYaCF9br05NyQS5AK/Oyn9MRs31KvE/2RwEb0YKPg9vNjN44hh94M8DfjmhjuxfMF
 WJnhzQ1qui3mVGGVdqghBIJ+ZF4aj4rKp8c87AJcYm85nXE/xBq5T8Y4lysFsu4ziUz3
 kYXT/Qsy/X+7FOTJtwO6VH5XmR+Oak4UfWuaDZyNUGXeXpXIykPKFSDRvVu+CNyR3KRS
 Baf2O6VxBHbvBJqFs8r25Q6/6PgqgkOrGJI2IV8q60+lnhfiijL7DwOXRdvQnfqz3JHL
 Bx9SKkQ/PoOFl39s8z4MdvhYATYLM1j9/UVwf/F8bbYVkBcubEgE/ErJz8nhNv954mrJ
 g3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778074817; x=1778679617;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iLH39jHv8OxYhzuAcdZjOpJEhvHV6CNvNZ1jnpH+NqQ=;
 b=jREoIS4EQH62QTNPkSanS5/anhaiLMfE1ICHmrYAsUKkd1LyL9VEPjQNn+goHot8LP
 e7vB+WWTHIZf2PRBlK3Ze73PiQ5PZX9rY3g+WhjIe8gk32xHCpVMrjQ28pmuhN3YzUlT
 ocGEDuD1lJ+RYy7w5ro3t7PmKEDVJmr+1eOVUlr1sb3tz9fGg8LD19f6tvMR5+SneC62
 CE/JexH1Bd92HO9kMLoubQVEEK3+58j4Ingzpss+ZPw9UenCD2Hyp/u7TF9mz8AfG2T2
 t6dVY2i3UOg64YmY4JZflpRqbwZ3YdSWHa0IvbivL/YBL5oapsKNb7n4CJyWiqGmfTM2
 S6Jg==
X-Gm-Message-State: AOJu0YyiWIrCeOw8NslleWp9GaRWhT5VgPuqg/L8Ng92/gG4iJ4QXey6
 77Y62v14IsFjN2D6oqjX2HOhTRUcPNzYWh8kJsiBwqvOS0eawXtffa2FkBZqZ9W9adD6/UNOqht
 Yw08ez1N6FqC0J/qvQT5oSk8BA5pTbQbB1vUuT3qxo6FndJpN7KafbAll
X-Gm-Gg: AeBDievwuH+z8Heidn7xz+xkbXuXcyfPBV0C3BWY2bo6X8Y+DUvgP6BVpZ4D8Sz/t2o
 TfYzco5v8nG1+IlU94Dgupa4g7K5AIgcMZxm21qW8Y6temjjk+6N7B5EKJpkLDiEHOr/mi+4L7I
 05xefSJXO10KGP99gL+TWLZ7yVpaKmxk/stGLutQbu13jhFpXqNIe8cwwbWRJ1pFoMyOFS5nP6P
 TCczuvuVGDc3OcVJhl6se2DsY0Gz1nl52zpyuSOcK6Z91Elwr9i9VnxVo1KmXAziooJopZi/TB0
 7giTEpTG/1EECIFH8AqrRp5g3wRY8lYCMAZkqjNvBbATUOp38N0DnDoB+nDWHwx56AjGv8rU04I
 39fpRtYhZ/vBZLXeS8Z5MKNsMo1WqGt6yuu5Q8BGlCtGQSNmOO3cX96bduw==
X-Received: by 2002:a05:6512:1081:b0:5a8:735f:aebd with SMTP id
 2adb3069b0e04-5a887ce6c98mr1301513e87.30.1778074816672; 
 Wed, 06 May 2026 06:40:16 -0700 (PDT)
X-Received: by 2002:a05:6512:1081:b0:5a8:735f:aebd with SMTP id
 2adb3069b0e04-5a887ce6c98mr1301489e87.30.1778074815917; 
 Wed, 06 May 2026 06:40:15 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a87791b4bdsm2260034e87.39.2026.05.06.06.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 06:40:15 -0700 (PDT)
Date: Wed, 6 May 2026 09:40:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, integration@gluster.org,
 Zhao Liu <zhao1.liu@intel.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Mark Kanda <mark.kanda@oracle.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Glenn Miles <milesg@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Ben Chaney <bchaney@akamai.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
Message-ID: <aftEt2S-Oxq93b_s@x1.local>
References: <87y0hwbvbp.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y0hwbvbp.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 06, 2026 at 02:01:46PM +0200, Markus Armbruster wrote:
>     MAINTAINERS:3746: RDMA Migration
>     R: Li Zhijian <lizhijian@fujitsu.com>
>     R: Peter Xu <peterx@redhat.com>
>     S: Odd Fixes

For this one, "Odd Fixes" should still be proper. Initially, Juan was the
M: listed and it was gone only because Juan's left..

Zhijian, do you want to be M: here?  I think you're the most suitable.
Otherwise I can switch to M:, just to say I'm still collecting patches.

-- 
Peter Xu


