Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4B5CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3gxI-0004JJ-M0; Tue, 30 Sep 2025 16:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3gxG-0004Gb-UM
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:28:10 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3gx1-0007o0-SL
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:28:10 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7835321bc98so3588499b3a.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 13:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759264067; x=1759868867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/mRpoLgFc8U26Jlg/SSZYXO8nFhlzFTCTlSmEDP24rk=;
 b=RveiHooXe+CNh/WRn/opBbTSbdP9Sf6dY552vkhvOxQnOQED5+i0amjUdPvsfgfSyK
 UMasYbM64J09Wy/mZ3QMmjnE7rBn7PFw7VzptY/MXTTkyyat4Ig0mQBCCQthVzthvgwB
 FFVmd22q0SfxXVXwlWT7dreJU/Ze7ltCw3/ctwXGPbZLvoYutibEuLy+aM2t6/LFQ+cI
 kCno+TuUFzDKlFedzBF9bRlyx0ZlVge+jovBr4l19Hpfvkr8GD/fK1Gq3+abDnNag+FL
 sDNbdEd0248zMD8JBzxjWYxKlpuE0Adv+banb+WQPPZZ+aLgKcOnjxxuufixG/zXCglW
 XDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759264067; x=1759868867;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/mRpoLgFc8U26Jlg/SSZYXO8nFhlzFTCTlSmEDP24rk=;
 b=i0wwDCR6v6aTPNq/Uz0Ol/6tySepzuK3ZPQ3qeS7ohGZ48KOMFFhK8b2j9x1gP7AJG
 LamXJhBC7LJ15tIYa8f5b2oodwzPQY09C1+Nxam82YKuxYdFFOOHyEcs23HmICpMc8Y+
 24RFErH5QRdBd5MNcZLqxVRbpXxNgGT0dtpZuRLHzM1Mvie3SXs+ZtHCxdxgGoPGOj7l
 UXrCTfhBak2xzlogv4li0Fv3CRc002TIfNsgjuRkw5V1uC1m9UdDukR2N+D7yv9+b8WL
 49ZEkYk/xHDoLHIoFHObkYGvNuh9RkN6iHUMwHX8+fM7uzetdJj2LiEB0A4uWcR9Cxj9
 JCYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxnW2biVlzAp/pgSa6ynFguYVdAQvlrvr03ccEXv2JCC7+j6pPMzmPGTjSTAzVpdxSQjZhZL7U0i36@nongnu.org
X-Gm-Message-State: AOJu0Yx//aPbAcxoiANFKkzUr2Tce1+GSNxtQwRxKjHVF2ooV/6c8lJU
 w/DOJBNMbXAyZppEBbljvg7xWoDlaQlZdYV2I8mdmZehu4xbY4h12c+7cOfPOkuC66s=
X-Gm-Gg: ASbGnctXQsRbeBUvI5Wl08CFnTpDvSNgTGYcswjQ3l19W/2t7J51kAf0YNREZ7Xrqhl
 7Ag7Si3q0O4EHT6tBrdMzO0SJXyL902u1lxMv814TwSIu1stesm9h4aZoaEvTcGjEJ75DTTQv/p
 VyRPG86k+fjCHxuJLkGbKTBLqfcZ5+sxDRn96IzrJA2wQFQGu7utXd7E5bziWGohIgM07rfaoUt
 u7i0yI9HAqbXmk3JbGLlH5IqCkBKDZXhE5RS7dBkH4XRXkTGsMyQs2B4F8djUwS24UWCbMXZmOL
 +a0TRh5SL888k4Kwf1MWhJMWoTuyRcjmN9aWoi5eI9MR5FjDxhc13QlND1ieO4Jj8EteZ4eINYB
 lcK2NV0Zv+1lCadKhzZOXdA9nsipE0n1zqJvCPBctOf78YP0SqXuWbrbM54dMQtDDE9PrT/I=
X-Google-Smtp-Source: AGHT+IGHwGdaI9/7x3FSGjAll2aiAsXQ51koCXbRJnhtoa+Tb/JHj9ZGjhNKi09HfL4J9l5mVWb8dA==
X-Received: by 2002:a05:6a00:1146:b0:781:2320:5a33 with SMTP id
 d2e1a72fcca58-78af3ffe1e5mr846993b3a.9.1759264066784; 
 Tue, 30 Sep 2025 13:27:46 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78102b64a87sm14613842b3a.69.2025.09.30.13.27.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 13:27:46 -0700 (PDT)
Message-ID: <429e61aa-a9af-4a97-a549-d7d782e34fe5@linaro.org>
Date: Tue, 30 Sep 2025 13:27:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/18] system/physmem: Un-inline
 cpu_physical_memory_read/write()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Xu <peterx@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Stefano Garzarella <sgarzare@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Jason Herne
 <jjherne@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>
References: <20250930082126.28618-1-philmd@linaro.org>
 <20250930082126.28618-15-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250930082126.28618-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 9/30/25 01:21, Philippe Mathieu-Daudé wrote:
> In order to remove cpu_physical_memory_rw() in a pair of commits,
> and due to a cyclic dependency between "exec/cpu-common.h" and
> "system/memory.h", un-inline cpu_physical_memory_read() and
> cpu_physical_memory_write() as a prerequired step.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cpu-common.h | 12 ++----------
>   system/physmem.c          | 10 ++++++++++
>   2 files changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

