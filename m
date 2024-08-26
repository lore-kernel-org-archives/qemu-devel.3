Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536F0C5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 00:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siNFl-00086u-Tx; Sun, 25 Aug 2024 20:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1siNFk-00080d-9m
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 20:06:36 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1siNFi-00011U-Oq
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 20:06:36 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7093ba310b0so2150829a34.2
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 17:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724630793; x=1725235593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z3TGprxaOs69iMdtwifomapa7aCUOX2jqlR5UTjUs5U=;
 b=e0J43Nz088kcJDWK8rw+pJXDqZfL+a0S/udKEbdPxk6oRuvi+vUCfrk80tcOjEVQQ3
 WtHajOFt+75Q9Cn/J8lbOihEuLPxkcCbiww28UFE98kMa8KFMV9I9vcTbAmJQNIeEp5i
 e9z+kJuiKvoaNNbFbq9yHoY2G5+oylGeb5Wjc/ZbrLfFpafcLRzZWnkhkXgPjJJ9l0mr
 6bHhcmnNOmymkoK0//+k7+FQDTREfK6g8R/luGK4FC5rEIi3cszi9CrzZ42s0TvV8sqm
 v4+C9IEK3O0AysTcO7KMOYAau+4KHxYdaabAEntt6X4uo77d9jtxbScJuFSalpQrNXRC
 PbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724630793; x=1725235593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z3TGprxaOs69iMdtwifomapa7aCUOX2jqlR5UTjUs5U=;
 b=SXgGjWUSuaO4aRuEWq2sD0/EERHb4f6UeinBLQoRLXQzjnONuyVnOHHO8HEpa9aKqb
 khBQgji+mlWpIGwwbUUshpnxDGNrB1SAIx6ta1AM9NSFyxXvJ2If5yDftv4wmkm4Sdox
 Vt3qSWLN/6loCrJ0oZ9ybfJeVhR88VmiV5U05syLidL1GuGypjLobIajRrvW4LYa87pJ
 ZzdlDh+wa/velsy2l6BJM07A7e0zioaKpEU6OuhHFQaB9sESjojxiNj4POZKpfAzeQ5I
 BJLbELDYdAQEDqi7lU5lcXv+VoZ3NQdZfHWi28YqELk1M79Exb7Ormc7I/ZPwtY+uwbp
 jLyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuIAn4Ad95YZwGBbb4pKuk+5Eegp75r3GnIVHko0j+S3qxqFtw5aAqajoV2VMgTndEl7DZElUXLy5Y@nongnu.org
X-Gm-Message-State: AOJu0Yyxn0O6VeuSdY42HUbirBycOi4VN7asQEz9JL7p22e+5MsKsCDI
 uVP26SmHcfxjcYJJ2WXiE96feYQMQ4Rtt2qcW2MNojNtcbxUbGEJ
X-Google-Smtp-Source: AGHT+IFfJqYiW3sul3qQX9PuF9Blco7JAz4YQQbyUfrDR59ADR9j8kMgUCpfxxmATAEYbMRStJnMHg==
X-Received: by 2002:a05:6808:2e4b:b0:3d9:e1d1:157e with SMTP id
 5614622812f47-3de2a8e1285mr10543407b6e.35.1724630792764; 
 Sun, 25 Aug 2024 17:06:32 -0700 (PDT)
Received: from [192.168.0.22] ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9ad82c3dsm5621239a12.94.2024.08.25.17.06.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Aug 2024 17:06:32 -0700 (PDT)
Message-ID: <3b89ebdf-32dd-4cb9-9197-2b4137e4eb0d@gmail.com>
Date: Mon, 26 Aug 2024 09:06:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] hw/ufs: ufs device testing function added and
 modified
To: yc01.jeong@samsung.com, Jeuk Kim <jeuk20.kim@samsung.com>
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jeongyuchan0629@gmail.com" <jeongyuchan0629@gmail.com>
References: <CGME20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71@epcms1p1>
 <20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71@epcms1p1>
Content-Language: ko
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71@epcms1p1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Thank you for your contribution.

Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>


On 8/22/2024 5:08 PM, Yoochan Jeong wrote:
> Previously, it was only able to test virtual UFS devices if they properly
> read and write storage data. In this patch, three test functions are added
> to test if virtual UFS devices properly read and write its metadata.
> Each functions test reading and writing flags, attributes and descriptors.
> Related minor bugs and errors are also fixed.
>
> Yoochan Jeong (4):
>    hw/ufs: minor bug fixes related to ufs-test
>    hw/ufs: ufs flag read/write test implemented
>    hw/ufs: ufs attribute read/write test implemented
>    hw/ufs: ufs descriptor read test implemented
>
>   hw/ufs/ufs.c           |  19 +-
>   include/block/ufs.h    |   6 +
>   tests/qtest/ufs-test.c | 384 ++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 400 insertions(+), 9 deletions(-)
>

