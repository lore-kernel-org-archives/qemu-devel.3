Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B8BC9EC80
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 12:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHCT-000271-Fi; Mon, 12 Jan 2026 07:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHCQ-000248-Ce
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 07:39:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHCO-0005SZ-Pe
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 07:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768221547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=5IxgGBGvEQRM2qTEflVeUu6lXn678C1hS4u+5tIrMt4=;
 b=CfZ7XUVAWhBMqFYeuFmkwZrhhQnD61mUj5w0/IE84rLXm+wiwmenl4vHh9ip04rWaTK/ew
 BZCk1s/dFYmuP6ruVzVK2cHqglCUgWtpVDvlAH090b6ku8a2t7wIjrEOsrMJiZ+H56hh73
 1uxeaUQ3eiWUcLhbZQmzE8jxIda0lRM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-w8kodSo3ObG0MVKy8OIb8A-1; Mon, 12 Jan 2026 07:39:05 -0500
X-MC-Unique: w8kodSo3ObG0MVKy8OIb8A-1
X-Mimecast-MFC-AGG-ID: w8kodSo3ObG0MVKy8OIb8A_1768221544
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477b8a667bcso78297305e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 04:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768221544; x=1768826344; darn=nongnu.org;
 h=content-transfer-encoding:cc:autocrypt:subject:from:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5IxgGBGvEQRM2qTEflVeUu6lXn678C1hS4u+5tIrMt4=;
 b=LTZPKYKXmpAqmRSlIjj/3d4MEAU0f5bdKd3ykn+U9PLK/AZmm7XzOe35MBXhawlAuE
 o0bw2sArltFwNHxTiCIpXnBcruXXiyn9ohO09sVtvjSXPGNrgYkHVqVjXTdUpGndmanv
 05cX1FvLu4a6fDOV5ST2+nnfBjm4foM5QyW/nt0/Q8YVxG6Br2hWkAayVxHEjP5GnmGo
 +x952ejWb50FlZ51PZ2RHzZHgoaPheUNLdBWZrc0VgbsIb7rKcw6ehSU3eeChDCUZ+Se
 Lz2IHz5mQ0fwUeWRB6xmxWQ4qbmVGtf2pScOqPBJaKXWffOehIoIZUGdGyYT2i6Yc8yI
 E0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768221544; x=1768826344;
 h=content-transfer-encoding:cc:autocrypt:subject:from:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5IxgGBGvEQRM2qTEflVeUu6lXn678C1hS4u+5tIrMt4=;
 b=bQ++bSQ6Ly5GGvDc9G8o4PEMF+3c7YHVNvY5jVBesoQk+j08rzJQH/I653E+TYw3l6
 TSnUkv8eXKaEVVjMYxPaysKa2U6NpMRfl1mFG2HIr6QmcJ/Hnb4CcdFknoiHNcQYyhp2
 HrjcqYZwAod9fD+xz6QHVMxvaiFO+wq25WEm/HdXscdmso1IwZH3pghp5KhWQd5s0mtz
 jR8LA8O0X2r3u5rpLNKPFC3Vu0NokcaaHiVfIX7uSJc+1i2RwsSHdGjnEie6wvjPLvoz
 4kGxBuOkXgVcGnuPUKTjBycbAjsGu0DImgRf/MUVZGsc/TdUhFAxtaG8wEMMULctcE1D
 5LqA==
X-Gm-Message-State: AOJu0YyLkq9mk/jBpcpqBPxPRMA73P4xpkwIma1YgPWBKVWbOeCJFOSE
 3zkbTF4QxWBd1yVYfZWktYC08WTORpmu4sBjLAjgXUlphGx2fzrYqoopiJ8SqqO/GnS78vyrgu5
 dpY5Oywpv17FLGvSlFTK71wQsRjYUtt3l6615juDwvcBQL9tDQcbweT+QNZGgre1iV8x/1vvAbI
 tKpKcRgF751W7XyN0fYy5ujgmRdueRuu1K3AvL
X-Gm-Gg: AY/fxX6iBLWJtfIA+GVokLnMecKyJxsPFbh+RMZnBStXnq7Bc3cmRF4ee5X3bSz6Qqi
 sFW2llaxcb1uPeII4RM9e7bypVdpBNcquCV9PYJ9XBCJsyFzYN3BBt79sfZ614ac3FZXTkjIMvg
 mjpaMppLBMRTcbg5dAxjPZTU6ooRU+I4pfVOnijEoGeeweuhxH9FnAKMAEpX42nDV9S76kQcKtc
 cJRUpmSAQGQlSmLsTS79UR+dLf9YZq6DxdSx3wERDhthu7sL4nPzmPofwETuWcZS1hwBkBFNe4E
 leDXZJDktcZLTfIGLPXGgTVuyICiOvKys1C4LnYLIlbu44c5x6+Dxxu43PMM+bZdfUFPKmLwfOG
 Ee/IcFg0=
X-Received: by 2002:a05:600c:699a:b0:47a:9560:ec28 with SMTP id
 5b1f17b1804b1-47d84b1fcd5mr215407295e9.13.1768221544357; 
 Mon, 12 Jan 2026 04:39:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJFPwZcNRUIo+TpMAoyY2rJEH/cRzClnl95KZVM83pShdxNtpVu8b8nTTmNeg4n2e3BGgaoQ==
X-Received: by 2002:a05:600c:699a:b0:47a:9560:ec28 with SMTP id
 5b1f17b1804b1-47d84b1fcd5mr215406825e9.13.1768221543888; 
 Mon, 12 Jan 2026 04:39:03 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f620ac8sm343833425e9.0.2026.01.12.04.39.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 04:39:03 -0800 (PST)
Message-ID: <e2f01894-dc75-411a-89ad-43af02847d41@redhat.com>
Date: Mon, 12 Jan 2026 13:39:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: meson.build:1:0: ERROR: prefix value '/qemu' must be an absolute path
Autocrypt: addr=thuth@redhat.com; keydata=
 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
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


  Hi,

looks like something in the latest version of MinGW (maybe the update to 
Python 3.13?) causes our meson configuration to fail, see e.g.:

  https://gitlab.com/qemu-project/qemu/-/jobs/12672816538#L397

  meson.build:1:0: ERROR: prefix value '/qemu' must be an absolute path

I guess this is similar to https://github.com/mesonbuild/meson/issues/14303 
... but the weird thing is that we don't use "--prefix" in our build, so I 
wonder where this /qemu is coming from?

Does anybody have got an idea how to fix this?

  Thomas


