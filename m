Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C4DC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 11:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seugB-0001d8-QI; Fri, 16 Aug 2024 06:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seug0-0001Vt-B5
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 06:59:24 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seufy-0000oX-2v
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 06:59:24 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5320d8155b4so2518431e87.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 03:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723805960; x=1724410760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hU/uVaWgfZQJOk/mUvG+iaJnTI1WKVHF9Mzt6iOFQ24=;
 b=CZ5Eh2VhUQ+OOx8bZT4rJVWud/D2QqQzIcRqguuMpv9JI+Woj1P7CnZdcjixpqEaoJ
 ufzwUae2yK1qhTvk32/nk+QIAquirFLE1CScDYvhhEFSBYgyu6LoFTSTUdHbMEYKcbo/
 NdC1QHABd+vCZcLEc3CCdVDSxQN+G34Z+oZlXv+pLET5tlKVfQ3Tin2ls1FjYILpZVI3
 gTAYwm5gMs9QiQYoXg3obg5Pu6ZyyxJx2EtXP8Jhm8PmsgA0cylgo1V9O1qT0FoqmQ0/
 7uXzrN65bHZy8Km1TMJXQPOzMpVx+3ducMTQpDRQ5IpOBaSv25XcBayK7cJDkORD0/ge
 Mvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723805960; x=1724410760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hU/uVaWgfZQJOk/mUvG+iaJnTI1WKVHF9Mzt6iOFQ24=;
 b=mjaytV3v8xPRoeVOj/oqY43GVGnzyV+E/dHh+ahYhARNu0pC0kqJESwEes9GeSnGfp
 ZpWIfm3Ja/JCjxKkyUibbs8b8wYykjxYJRAkLAVAsHZLmv8iLBRrLUj4+qT7YtIGh4M2
 03Da9NAAnq+qY0two3Rd00jTQ7ZU8Hyl3biq/9RzFmZRloXAXxINH7fUGR10fPGSh5Gy
 pNOi7T0UaYr5cMC99NbwSpyTTYAdAZJFIAkHbextJPxoHyY/PS4V0eXFyG+QFXnLFlS0
 kI2235TE5+7Qq2PsNR43v/bgPWf15woNUruVUN5TgafSw2/dy7kTgJ1FQskGI9Qr/pev
 tGWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCriXG/a1OTGbbjI4goVOIPqdPj0Gl4z9cFkO1a0yFADip8r8yNTMvnBMzuNC3vwXAV1RFWLVm4nyOIJsXNf1WAz3ut4s=
X-Gm-Message-State: AOJu0YwiNutIHX2JHdx/RPg99nSFPzzg02jtumtcMj3K/eh6ivLMW/Nf
 /nD5G606W6+8ddiaTPXMuLhjrSWM5R749TJ9O+QzRM9ZskPPRCKcCWh5rU8xCUg=
X-Google-Smtp-Source: AGHT+IEOS3kFHiJPiY8IzuR/J2sByj96dr+W2TC3I0FEUQoT3zZgEqy/VPQW52LwCFIROr24jqAVhA==
X-Received: by 2002:a05:6512:3087:b0:52e:a7a6:ed7f with SMTP id
 2adb3069b0e04-5331c6f0099mr1216029e87.60.1723805959938; 
 Fri, 16 Aug 2024 03:59:19 -0700 (PDT)
Received: from [192.168.220.175] (143.red-88-28-5.dynamicip.rima-tde.net.
 [88.28.5.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429d780ec58sm71958615e9.0.2024.08.16.03.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 03:59:19 -0700 (PDT)
Message-ID: <54bb02a6-1b12-460a-97f6-3f478ef766c6@linaro.org>
Date: Fri, 16 Aug 2024 12:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] target/i386: fix build warning (gcc-12
 -fsanitize=thread)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
 <20240814224132.897098-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240814224132.897098-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

On 15/8/24 00:41, Pierrick Bouvier wrote:
> Found on debian stable.
> 
> ../target/i386/kvm/kvm.c: In function ‘kvm_handle_rdmsr’:
> ../target/i386/kvm/kvm.c:5345:1: error: control reaches end of non-void function [-Werror=return-type]
>   5345 | }
>        | ^
> ../target/i386/kvm/kvm.c: In function ‘kvm_handle_wrmsr’:
> ../target/i386/kvm/kvm.c:5364:1: error: control reaches end of non-void function [-Werror=return-type]
>   5364 | }
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/i386/kvm/kvm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

But what about the other cases?

$ git grep 'assert(false)'
block/qcow2.c:5302:        assert(false);
hw/hyperv/hyperv_testdev.c:91:    assert(false);
hw/hyperv/hyperv_testdev.c:190:    assert(false);
hw/hyperv/hyperv_testdev.c:240:    assert(false);
hw/hyperv/vmbus.c:1877:    assert(false);
hw/hyperv/vmbus.c:1892:    assert(false);
hw/hyperv/vmbus.c:1934:    assert(false);
hw/hyperv/vmbus.c:1949:    assert(false);
hw/hyperv/vmbus.c:1999:    assert(false);
hw/hyperv/vmbus.c:2023:    assert(false);
hw/net/e1000e_core.c:564:        assert(false);
hw/net/igb_core.c:400:        assert(false);
hw/net/net_rx_pkt.c:378:        assert(false);
hw/nvme/ctrl.c:1819:        assert(false);
hw/nvme/ctrl.c:1873:        assert(false);
hw/nvme/ctrl.c:4657:        assert(false);
hw/nvme/ctrl.c:7208:        assert(false);
hw/pci/pci-stub.c:49:    g_assert(false);
hw/pci/pci-stub.c:55:    g_assert(false);
hw/ppc/spapr_events.c:648:        g_assert(false);
include/hw/s390x/cpu-topology.h:60:    assert(false);
include/qemu/osdep.h:240: * assert(false) as unused.  We rely on this 
within the code base to delete
migration/dirtyrate.c:231:        assert(false); /* unreachable */
target/i386/kvm/kvm.c:5773:    assert(false);
target/i386/kvm/kvm.c:5792:    assert(false);


