Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63241CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 16:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIUqT-0006Iq-Ik; Mon, 10 Nov 2025 11:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bobbyeshleman@gmail.com>)
 id 1vIUcw-0002Sz-BO
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 11:20:24 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bobbyeshleman@gmail.com>)
 id 1vIUcu-0006p4-EI
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 11:20:22 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-63fd0bf1f4aso2258779d50.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 08:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762791618; x=1763396418; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VEXAMCIMpvmXgD8uSaoHe5yaMdZjLyi2AGSnNcizk5w=;
 b=GU8vfqVMdPWeF7+15IumqttPXeedi4QZKbjXqy9U8LAvj5fUpJs0oqtsLSR40oonMd
 GpDalPaXON0pNDS7pdomYZoFblc6+ao5NAQuSKd3fUQSjmMABZ7OHrnwyDIh8TlQwfZ9
 tqNWQPcxrJTmC89GL0TUXy4wFnc7iJ9ILce2PvPKFOyJRpWt5kOYTktdeH9FJoCyL8uZ
 waNhBfyPrL1lIk/DSjpotjbN1kaEpyCi80mdkdo6sJzn6RDfuvnVk02K061raWoR3dPr
 xAdk+4tsH9LpvmmHlRuaQ042I2O/jzOu1nXKIr756zNjhosfB8Zs22L7y4wI4f6AQrI7
 8cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762791618; x=1763396418;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VEXAMCIMpvmXgD8uSaoHe5yaMdZjLyi2AGSnNcizk5w=;
 b=r/TI3Rg5IcPrx7BP8n2/A5IdiIRzZDZnB1dzdv96q7W87LH75flke0/jHq3W52wnSF
 JgLY64/UxrRefwSxiJhxr5DYlE+aalG+yrHcs5HYobfhKPNlNfZ7ZrGz36DXWntHSh87
 NJmrsV3YgadALX6/zZQJ/62aZ03X1dLkS4tla2z8LmbPuM+W7+1nYcI7rZ50tlF9cyFT
 ZUMctJqH/MVn0uVfgFpElqAg8co1JMxHw9mtqgud8ulDZHKt1u/TziA3lVwQeYhPpbgD
 xCWtOU457l72O1LeSUnVos6QkXXidVWirJWDK2V5xYKIOAmZzzAaVCqcCUiyiS09nPCY
 1Xow==
X-Forwarded-Encrypted: i=1;
 AJvYcCURC7S88o6l7jpSk6Ju7+0fUIys8q9faH3j0BA0XzlFksXsaEil4DTaYJRUrCPSvzJZglarepo36Ubh@nongnu.org
X-Gm-Message-State: AOJu0YxUzb4dna1Jyi1QFlKRnkOy+wYe9rgvEQNBT5jdoAlrkJS7XinG
 HFP/BK7Fa780lqIdBavASH3dk5d3O7yK9Bw6uIwIaR/NC/Eyc6iQz2/6
X-Gm-Gg: ASbGnctL/BYPf8nWYqexI26CEAgIPElpCd9741d1dFGJSF60rnuW2G0TbVXiv9e9pVO
 1MYFaWGjky/UGC/BtYxSQ/iirtSck8buHyfxoBM5/ePbvHczpnPp7jgQUGVzTMEZBY1LQte9it1
 I8/xNaUnGcHHdvPcdRwYAUayLUT2g1NJlbjFj5j1ac7GysIw5Uiuz82nH/15IjBm3aD6M8TEeyW
 QOI9JfO0DYI7wJbS+kd0luMolGFaUyG0mz3xxz+TQ76pwwyuRCOr7bOxFOxlxaiwdQ8/AxaCTCb
 +mWq36JojR6CwDPVzBLBQIZpI3MxqfooXUXRJ3Wn+ZklikPCh6M1aeSTcWajzcI1LU3Gj5g4+oH
 V6gBJqRdCKsjqCk9910IQ+97REciUyXFQRjhMeDSRFy15HG9GCCYaOdatKbWr9EIcZGbJFzvp8z
 09ESsnnvfkoL/J9A7HGk2FPyWD1cR9RpqCt6Cwa16JjvJl99k=
X-Google-Smtp-Source: AGHT+IHP+4oKTYSzDop/yvd+hBvBsIqpeqFKQ4QlLbHp2l5k4103+Qk7ZJjlyE3Yus8z/RAWdD/7kQ==
X-Received: by 2002:a05:690e:418e:b0:63f:b082:4d5a with SMTP id
 956f58d0204a3-640d45d3919mr7421357d50.57.1762791617709; 
 Mon, 10 Nov 2025 08:20:17 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:43::])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-787d69f0976sm24507857b3.45.2025.11.10.08.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 08:20:17 -0800 (PST)
Date: Mon, 10 Nov 2025 08:20:16 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Robert Hoo <robert.hoo.linux@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Subject: Re: vsock support for communication between guests
Message-ID: <aRIQwPIGIR/6CgeE@devvm11784.nha0.facebook.com>
References: <1943ea16-c3cb-4442-be72-5719026ee13a@gmail.com>
 <pkglizwznrfj6fm7tdyew4tzmomgtp2cetxwfj2fx7ge4vtwhv@kdlj2jdxqheo>
 <9535cd2e-239a-4002-be5b-b7c7fa85f081@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9535cd2e-239a-4002-be5b-b7c7fa85f081@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=bobbyeshleman@gmail.com; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 10 Nov 2025 11:34:02 -0500
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

On Sun, Nov 09, 2025 at 09:13:13PM +0800, Robert Hoo wrote:
> On 11/6/2025 10:32 PM, Stefano Garzarella wrote:
> > On Fri, Oct 10, 2025 at 09:00:21PM +0800, Robert Hoo wrote:
> > > Hi,
> > > 
> > > Does vsock support communication between guests?
> > > From man page, and my experiment, seems it doesn't.
> > > But why not?
> > > 
> > 
> > It depends, vhost-user vsock device, supports it.
> > See https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock#sibling-vm-communication
> > 
> > The vhost-vsock in-kernel device doesn't support it.
> > 
> > The main problem is that vsock is designed for host<->guest
> > communication, so implementing a guest<->guest communication is
> > possible, but requires more configuration (e.g. some kind of firewall,
> > etc.) and also an extension to the address (see the required
> > `.svm_flags = VMADDR_FLAG_TO_HOST` in the link).
> > 
> > The easy way to do that with vhost-vsock, is to use socat in the host to
> > concatenate 2 VMs (some examples here:
> > https://stefano-garzarella.github.io/posts/2021-01-22-socat-vsock/)
> > 
> > Cheers,
> > Stefano
> > 
> Nice, thanks Stefano. It sounds ideal for my VM <--> VM communication
> requirement. I'll read the doc carefully later.
> 

Though not as convenient as socat, VSOCK also supports sockmap which can
do this in-kernel (bpf), there are a few test cases for this in
selftests/bpf.

Best,
Bobby

