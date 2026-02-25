Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12ADFD3767
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 15:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvGcm-0006Sd-Dm; Wed, 25 Feb 2026 10:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vvGcj-0006SM-4D
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 10:16:25 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vvGch-0002Ir-8d
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 10:16:24 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b8f992167dcso811291066b.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 07:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772032581; x=1772637381; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HcyiiZc3MDvBei4ioUi0u03mWjRG/uRH4U3lirZ78f8=;
 b=rdf5yg+eUl7keADJcc1uQfulkD+g5G4zLiPaWqCxFB3vUg2rARr/O1klVJASaMzXKO
 M1llBC+NGDcdj4uwkwLX8L+wbW31d7/1nKzMAbl6aqBf/OKGZZ4tF8IAM3+vJdUdqKwn
 LMKpFB/u6/1cGIbD7UajtgY7zGKFDMQcO6WnbUOa1siGWAZjwDEPt4XDCE0G6sB1/qmL
 BgKZ+fpoQ8iPfAicbdAMdF0PeQORTSfSPpapc/4b3K/YDOav2Ys+ZcObGuKpGxCm5HL/
 u1G7fHTjMnXxFSg/Tr4yYtI2jHwzt9FRKGPf2c+k0hTO19hCO0wmtMQijsFEzmrcR5Tf
 PHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772032581; x=1772637381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcyiiZc3MDvBei4ioUi0u03mWjRG/uRH4U3lirZ78f8=;
 b=LZcA0wFtwG1Cq9NhxOCjbLhRY9SZOCa9ZN99bEV05bvIHJtFPA77u3Wp9grY4+odnU
 6dBA2ip5e0zXbjM1b70DbpTEc5k56FlMi15ayXLmjn/l9Ckl67o6GEpjh56sXdIfp0I+
 CKWfsHpwrsvpEaITqgmZ2MYg8qdWWtIspFXkRvJ5t5DxSt54IlAHAMoOBJ1ojyt4V86S
 59Ya00PurwBlCNiCGlKOXSs8b7MbF1QjPtgVrI/J5nGS7DJL5JWZOeUuA6ozuzONHqEm
 N87l60b9brnwp43ByQadN8RrFlt2CU5okeVTsdGuHI/+6GTT1gTnIqRzAbPBHgVBXAR+
 Z/sA==
X-Gm-Message-State: AOJu0YxGjmuhkIyolV18TkGSbf4fTL4T/xYl30jgHfBFJ4v51Be3f98t
 qVll5UoWJnKOlfDNSMBU7oF4e0Umn2SzXk2p8gRiqWZCxvIefaQOeWjvDCFqbZ7o5rWlgr254qq
 JFpPd
X-Gm-Gg: ATEYQzwkaFpdulq7dFWcA1NkqPhrysZ2BJBJ6pvJ77jR+2z5p7xDio9FnqPpmEjyhe4
 vIK0Vxm+H3DEH4+AsPX6XK5L6OSIW7QqyG48OggtNcKPrYHm9eoO9bCzvjdzuL3b9BgRXkoH1M2
 jcrB9ibAwkYykVxmKWkG5RbdpLNUNZKFSu6o1/EwmLE0dxKOdnwppr+E/mDeWfMqIdkEfpzXpY2
 Ezdl82Uop4RIenRIkIpk8fmamqEi+cXQGjFMBd3RAR07bJeytxtVfLTVA90Bjmg716c5o6QtUDj
 DPx1jxIR6c2GmbQ3vQ6b+x7hYOjCSys7Jr7KEdvQIxYtWArYHfdPOZkJeR32PcRuNF3Mr2/tISh
 haQ2vQAtkGxl4vtgg0tLJfrsx0ERzlZZASL8cmdMuZEyzeOHd3LWDbf1BOVfNKMz3U2ObIb4cD0
 lNCwI0DYKiGihGcr/mNewoWY8mAw/qwQL2m5W+
X-Received: by 2002:a17:907:944d:b0:b8f:b8e:4ad9 with SMTP id
 a640c23a62f3a-b9081953593mr1153755466b.10.1772032581170; 
 Wed, 25 Feb 2026 07:16:21 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:506c:58b9:ee75:9229])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9084e4bfe6sm528430666b.44.2026.02.25.07.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 07:16:20 -0800 (PST)
Date: Wed, 25 Feb 2026 15:16:19 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 5/6] tcg: target-dependent lowering of extract to
 shr/and
Message-ID: <aZ8SQ1Bz6aaDG6gv@linaro.org>
References: <20260204052456.970605-1-richard.henderson@linaro.org>
 <20260204052456.970605-6-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204052456.970605-6-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ej1-x635.google.com
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

On Wed, Feb 04, 2026 at 03:24:55PM +1000, Richard Henderson wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Instead of assuming only small immediates are available for AND,
> consult the backend in order to decide between SHL/SHR and SHR/AND.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> [rth: Split from a larger patch]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


