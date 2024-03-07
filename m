Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D3DC54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 11:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCNY-0000O6-C2; Thu, 07 Mar 2024 06:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1riCNU-0000NW-7H
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:57:36 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1riCNN-0003Q7-LQ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:57:35 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33d36736d4eso520996f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 03:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709812647; x=1710417447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=57A09yidrpDPUR1r7F8CHS4CvBdl9GurP/NjYKl3Cg4=;
 b=lcjz7ca8qZ+6Xd1sSWr3cGZ7Fklh8rvSlynyc3WO0NlBgvft9XmCk9W7hvdpzovjLp
 TunpoQJnSz+HXRRUUR6IOaJgvDvoA1jxn+2EZ+gPgrRRimBQY40yAueMLAVXrylhVeuk
 zsai9mJtAm1BgI1m1ITmDvmP5oc+SZ5L24hh+dpU5Y1MVpX8Yk8/l92Y85TaAn+lhJeX
 Xfd0fZfPI8JL9see6ckBz8JXe41jnt/uL8eT6lcP14T5xC1cpVg0txPWPhXCsJjCs2xP
 5vBSR1tVj6ARVSciP8S0OjkA/l4nNXO0d4llgHIL+3oPmeFccC6k2bvB/o3PzxieVtXz
 ChIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709812647; x=1710417447;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=57A09yidrpDPUR1r7F8CHS4CvBdl9GurP/NjYKl3Cg4=;
 b=ZYHnlhA2Q7OvE2T77eC2GvIL2VMmeJNnDgCRvSPwbOkzDjSTYiYGhaRhWzRyh+Gqgk
 ab8YssE9H+Z2bRiiCO6D3D4JNs/el/3fO9wDEz0A1g44msF6Ac2UY5mQhZPeEXMb8ggG
 hJp6MvkvvJm3mg2puUn7W3Fm4YrwwOJflLMpWSvY0UTCyv3dlx5NMzj4p4o96K9frNGU
 m6W5nJs5C9wWJa5bk03MSbqX7pTAirh8ew0QOAfscscttbBO3saa2/4DUriQKzSaTNtq
 USJubod93wq+XGsBIbEpYNQcqv80gRUAveg2fqAgKXrFxU577DgfjDk1d66GPftmB8oB
 UGNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7Tq5l9jrJl3p7JUtHhMxDWvtT8Y1TtX3X+y7+OIsHwaReKxcbO0S6QRIJBs3zQum1DzdD3l9mLdGQGmBcydUb0IoQBTo=
X-Gm-Message-State: AOJu0YzjTyBemTnNNSQzRNMTKpMyoEtW2KeXy7AzHDpGVLv8T/6aI1W7
 6ZeMrZoghYvM7COx/wyVHZ7NvCZSXvc02eR4MvjZRVVMShTpnjUbbryRlg2pGEM=
X-Google-Smtp-Source: AGHT+IESCFwpHQmPxOg130/0yHnqMR5/u93SMsub5nGrOR8b42+ayiblaPN9pioxp+dZdBxzB/xsng==
X-Received: by 2002:a5d:6e90:0:b0:33e:d27:4f8c with SMTP id
 k16-20020a5d6e90000000b0033e0d274f8cmr12927971wrz.6.1709812647026; 
 Thu, 07 Mar 2024 03:57:27 -0800 (PST)
Received: from meli.delivery (adsl-101.37.6.0.tellas.gr. [37.6.0.101])
 by smtp.gmail.com with ESMTPSA id
 ck4-20020a5d5e84000000b0033e2b9f647asm14506048wrb.31.2024.03.07.03.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 03:57:26 -0800 (PST)
Date: Thu, 07 Mar 2024 13:55:56 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-arm@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 xen-devel@lists.xenproject.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH-for-9.0 5/9] hw/xen/hvm: Expose xen_read_physmap()
 prototype
User-Agent: meli 0.8.5-rc.3
References: <20231114163123.74888-1-philmd@linaro.org>
 <20231114163123.74888-6-philmd@linaro.org>
In-Reply-To: <20231114163123.74888-6-philmd@linaro.org>
Message-ID: <9z7vo.cvkkbfxdigjz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 14 Nov 2023 18:31, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>In a pair of commit we are going to call xen_read_physmap()
>out of hw/i386/xen/xen-hvm.c.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> include/hw/xen/xen-hvm-common.h | 1 +
> hw/i386/xen/xen-hvm.c           | 4 ++--
> 2 files changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
>index 0fed15ed04..536712dc83 100644
>--- a/include/hw/xen/xen-hvm-common.h
>+++ b/include/hw/xen/xen-hvm-common.h
>@@ -97,6 +97,7 @@ void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
> 
> void cpu_ioreq_pio(ioreq_t *req);
> 
>+void xen_read_physmap(XenIOState *state);
> void xen_arch_handle_ioreq(XenIOState *state, ioreq_t *req);
> void xen_arch_set_memory(XenIOState *state,
>                          MemoryRegionSection *section,
>diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
>index a65a96f0de..789779d02c 100644
>--- a/hw/i386/xen/xen-hvm.c
>+++ b/hw/i386/xen/xen-hvm.c
>@@ -525,7 +525,7 @@ static void handle_vmport_ioreq(XenIOState *state, ioreq_t *req)
> }
> 
> #ifdef XEN_COMPAT_PHYSMAP
>-static void xen_read_physmap(XenIOState *state)
>+void xen_read_physmap(XenIOState *state)
> {
>     XenPhysmap *physmap = NULL;
>     unsigned int len, num, i;
>@@ -573,7 +573,7 @@ static void xen_read_physmap(XenIOState *state)
>     free(entries);
> }
> #else
>-static void xen_read_physmap(XenIOState *state)
>+void xen_read_physmap(XenIOState *state)
> {
> }
> #endif
>-- 
>2.41.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

