Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34181105F7A6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 15:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w14HV-0006OO-AC; Fri, 13 Mar 2026 11:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1w14HT-0006OC-KZ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 11:18:27 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1w14HR-0006Le-GG
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 11:18:27 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-89a6e6225e4so26460956d6.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 08:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1773415103; x=1774019903; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GsMlL0kdXtalaxNxMykNjsCSyBeWp3QFNec4VHlZd7o=;
 b=Se5eNLQNOhIZj+mEIxwGYZuguxBFIKIX+JfgmfHPs1uyC83LEkJVJxSJrnDfO/9t59
 tPqowIU1zKDJfAYhzS0QEVxDnw0ksfGj18QOGQkKJcwZ0033VpDTsXXFqlvVpLbCBx2o
 4gv6BLfaHTSkx77qpBJLxrHlMtYX6eydxc7lSudK+F8OWT5ieg6PQeXJCQDBpVvqu0Wg
 oCE0mYufOgr9w5POLd5faEv/8Hntmcp43l1PH6LrKD/8f1qVNaYP6Wpmpv9w81r2CtGb
 e2ZzbcSelWUKJiPrDNwftNVTYWc+XQYB+nunKptswEX7FqNwMjt0cjuq9IxYEuJva9sg
 LLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773415103; x=1774019903;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GsMlL0kdXtalaxNxMykNjsCSyBeWp3QFNec4VHlZd7o=;
 b=EBW3yxXa0ucnfV/lydiaZsu579MfbAYHGo4g02bdISXOIJkoGyNuvwO1rXKYPHlkxm
 1mEUxtgORKd/d/xYv4nYzN894978O5dwE2cfxzSltYmTbn7BUAXqe+A5M8jLxXOlxrXL
 Jv11Zq33AvFDdfNKzJDyf+mKfXs6hOkBIaGWagVbOruCH8oeKBgT0mBjaDIRP0LjfrU+
 QndAj9zxvHKaca5pJFdd/ZLpxlRtaUtHgPcnet3ymaVGeIOyRMUuKPLnEsb8NMDuZlTv
 xdP9TRj2ZcCJeVJSZPCvNewJ5uvFWaH/ao5qtBkeqnyeDmEW4+3YopIXv7Fzv+1oX5Aw
 sYTw==
X-Gm-Message-State: AOJu0Yxvjk9IZsDbxa2hVsWY9bEDk0YEgT+8hYJAPeJnxzuCQQ+4Cbhh
 Chr/ZrYHSp024IdZYBHb4re8wq+w1UHIxDAXp1wC+UZnmLduKyaCr9p+TGzFLlgon9k=
X-Gm-Gg: ATEYQzx4Q3bgZMslqQCjPbPPWGQm9ni6vZipezLgPPu5//MfYa2XKbydFxCv6U3fmWP
 oyCmgqu0vIKclVPKXuXNQPoUW9FxlTRH+yb3JBNW8RiXTpjZnowZm1VngrZUkrIDrmRbevqGOiU
 EqIkfHYdwBPrWnnTwW8LnypKE0tQW1vX6k3/d0wilO6Okl/WAfJTL+/Ts5fnq7RztmGKh8EfIwm
 ViKRzcz5779EHiA96aC0+knRJNQT9w5M65eZrH4Pms5qXfcPwa2plpLZMDrtoUjKE+/HwckUuT2
 V9vqKcYxqrYCjKKfuzfe43aOA1xEH7ysiflZH7PH4TEcE+6vacybe9LnQTf3iAg6CL4M1YwqLY7
 0SmV5AgvIXYV3ARiG7y+CAVS/ujqT8g0eY4igbd7mx1d0mxGkq5SXsADKhTXtDETxxfHstlzsCz
 N6oDNY+pbXi/9InynHCpf9i6A2tYem/7PJdGnC7+YqX4G0CUQy4RRiSgDtgZvEhNZsEZjvXwidk
 haoEH05fA==
X-Received: by 2002:ac8:5a88:0:b0:509:227d:2af9 with SMTP id
 d75a77b69052e-50957b9092bmr50522891cf.6.1773415102673; 
 Fri, 13 Mar 2026 08:18:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5093a11cc4esm65077351cf.27.2026.03.13.08.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 08:18:21 -0700 (PDT)
Date: Fri, 13 Mar 2026 11:18:18 -0400
From: Gregory Price <gourry@gourry.net>
To: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
Cc: qemu-devel@nongnu.org, apopple@nvidia.com, dan.j.williams@intel.com,
 Zhigang.Luo@amd.com, Lianjie.Shi@amd.com, david@redhat.com,
 imammedo@redhat.com, jonathan.cameron@huawei.com
Subject: Re: [PATCH v7 0/1] numa: add 'memmap-type' option for memory type
 configuration
Message-ID: <abQquiWHPoVgw-jt@gourry-fedora-PF4VCD3F>
References: <20260306082735.1106690-1-FangSheng.Huang@amd.com>
 <4609b0dc-4510-48c7-8190-e8fd5c53b658@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4609b0dc-4510-48c7-8190-e8fd5c53b658@amd.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=gourry@gourry.net; helo=mail-qv1-xf2a.google.com
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

On Fri, Mar 13, 2026 at 04:30:20PM +0800, Huang, FangSheng (Jerry) wrote:
> Hi Gregory,
> 
> Thanks again for the thorough review on v6 and for catching the hardcoded
> address issue — v7 has that fixed, now using x86ms->above_4g_mem_start as
> you suggested.
> 
> Just wanted to follow up and check if your Reviewed-by still applies to v7,
> since it's a minimal change from v6 (only the one-line fix you identified).
> 

Yes sorry, we're good to go

Reviewed-by: Gregory Price <gourry@gourry.net>

Thank you for this, this will be very helpful for testing

Jonathan would be able to answer more questions re: upstream

