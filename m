Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D2EC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 11:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAoFh-00073G-Cr; Fri, 02 May 2025 07:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uAoFX-00070i-5T
 for qemu-devel@nongnu.org; Fri, 02 May 2025 07:08:15 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uAoFV-0003lL-5W
 for qemu-devel@nongnu.org; Fri, 02 May 2025 07:08:10 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so15223725e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 04:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746184087; x=1746788887; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Rpc911MSRyybCnIO826qwe1uZefKxahvBxjSAOaVQ2U=;
 b=GFujG4gDxligj6IP9EZlkVT8x7lXFCFiOiTa6c4IffRyjiG16fjFFZA3DDGkpYvzU5
 8mKi+SQ9l8k4va+fhQfXBwFzv2mJ5Ktg5cbueDVgPqhX234nUS7pGcpnDJR43dPPJKCM
 3dJ/eRext+yhXTTqWB8VFuNZi//2z6O0+6RfU/sVmQQtXN+yy3A3ooEjEzSd/vgk5CpT
 vmPhtb6hGgiopfIDPkZmhYiI8DJo/tssH19wtABlzb+1NqRlotsAx8RlDIK1EAS4HViK
 2Yxz4KwvEtQM8y+9DQsfccfTFbiGs7KXPffZZdwIjyWMEEz3eaYaAaZobnI2jznnQ2Sa
 1ZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746184087; x=1746788887;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rpc911MSRyybCnIO826qwe1uZefKxahvBxjSAOaVQ2U=;
 b=pcmfwbhSQyLr3CdyQity888fzpi8di3X9F89MN+gG6O5R+yp5oTlk5nhMMtdVdGPW5
 SkuwwPSt7vTWwt4Q9aAzroRwHkcjcW4CSayn4BOx56022zMb/ZoIwcm02RcVZQBpfwcR
 IEItl4lzxN/tp6CZoV+P1BPET5jP4VvWBPRpQ+e9jcJFN03XbiaZpvQjONCr0uMRWJfc
 BZrDq912xtnxJuB42iVUcnvsXTL9xiIJ9czXtDiW4GdO89e2pmbbwxnVlMe2uK3kSxvz
 vlPtfELhak5Uspu5ugU3LJhTgWp2aZzwDIE/XJBSmPJYGqqMmjjVSQvpb+sZ5m/VPFbD
 1lVg==
X-Gm-Message-State: AOJu0Ywjs8/i/RojersYyYajDfX6ml6T6PxPEdL9QuepZz8BIlyJYKwY
 j3x3hQYipljMDdEYgDXTutPWoEd8njm+AJsPTAdB+RlUhxokSJkDCJ5mih8iLOz/FBbhsxN+y46
 BoiA=
X-Gm-Gg: ASbGncswxTBZuou5QshFR31uQ9+lh2V/ic+5r8rNeEAe1StB/kAXA33SIO+VI2CCTSx
 2EO/UEItMGA/zIDf1ugN042TrlSJmcQTDgLl4pz67crhj2zOExVMOavHwA8ykcetnINgC6HtGV0
 aPEid1k3m6JBfGC8HVykxTnh7y3Hed9HcZ5lW3BmDkHgM2ee7g2lgkAxH9UHAbjH8vqqz2QynDB
 HPylmRRrSKVSJBlvoUVm8Y7kXfQDk3TtIG5AFwLCBmFlGJt0E5FKwrnVjjfcnthOs6Zxr5Lt1NT
 dte8C/0Gm8abaaDYXv0MbTcXtpudjJhydwO/4AjCOrj3VVK7yOQNtQ12ZGtbNOBlsORKvityuQY
 V7Uh4rg==
X-Google-Smtp-Source: AGHT+IHoZ7i2elVk+YwaAr62pmR6X6acZLybsbDLi/4nMXa1ztqTtwjcIbzyH4O+CBNyyIODC/vKKw==
X-Received: by 2002:a05:600c:cca:b0:43d:7bfa:2739 with SMTP id
 5b1f17b1804b1-441bbf34750mr17915975e9.23.1746184087371; 
 Fri, 02 May 2025 04:08:07 -0700 (PDT)
Received: from meli-email.org (adsl-37.37.6.161.tellas.gr. [37.6.161.37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a315fdsm40686455e9.34.2025.05.02.04.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 04:08:07 -0700 (PDT)
Date: Fri, 02 May 2025 14:01:42 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-rust@nongnu.org
Subject: Re: [PATCH 5/9] rust: use MaybeUninit::zeroed() in const context
User-Agent: meli/0.8.12
References: <20250502102323.104815-1-pbonzini@redhat.com>
 <20250502102323.104815-6-pbonzini@redhat.com>
In-Reply-To: <20250502102323.104815-6-pbonzini@redhat.com>
Message-ID: <svms9i.274a4or3m08g3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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

On Fri, 02 May 2025 13:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>---
> docs/devel/rust.rst              |   4 --
> rust/hw/timer/hpet/src/fw_cfg.rs |   6 +-
> rust/qemu-api/src/zeroable.rs    | 104 +++++--------------------------
> 3 files changed, 18 insertions(+), 96 deletions(-)

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

BTW There's this TODO in qom.rs, ObjectImpl trait

>   /// `&mut T`.  TODO: add a bound of 
>   //[`Zeroable`](crate::zeroable::Zeroable)
>   /// to T; this is more easily done once Zeroable does not require a manual
>   /// implementation (Rust 1.75.0).
>   const CLASS_INIT: fn(&mut Self::Class);

