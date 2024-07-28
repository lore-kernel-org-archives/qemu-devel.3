Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35C0C3DA49
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2024 15:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sY5oT-0005tJ-Ur; Sun, 28 Jul 2024 11:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sY5oP-0005rj-NB
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 11:27:54 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sY5oM-0005Zn-H2
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 11:27:52 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70d162eef54so1566788b3a.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722180468; x=1722785268;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RLNZtX5NhiWjh8pTpiHyCLdAqm/MusJQss3pc8cjtvA=;
 b=hTgTXBhgQtgWcNxQ51UBPDlUfoxfapYvS3rZFLEX8RlHJUJRa3yN/fqstSvrTWSNna
 zPGE82B5FWr7mcXYZY2ghI01mJozQtme0xj1/iC4KTs/ds6PtWqHtgEApOdnkF782GwY
 DNLlxvN7giQWGFvnEedoY4iNJ6p4X1HUFY1vSJ5a9L3MitNKYz7dT/bYNfPAuK/7uOBZ
 D3Y4ZqoaS8UAvu7f1G0SktsVR+WjkKRnuBhzwiHzXoZXiY7+lQ4vUsuarzPwsQIwueQt
 kllFRDXC4e4mJChbyqyDnjr7vSvPdTi5K6Z2lbwsopkK9Ge9O4VVs9lNc9bUgAuxgJQN
 x5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722180468; x=1722785268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RLNZtX5NhiWjh8pTpiHyCLdAqm/MusJQss3pc8cjtvA=;
 b=nqMlNndonWsTJ+dKUnYoyKjBcIQsx6CQxdGxUp/us12WyBNVbfzJ7alcjW78bR9Opm
 IYRCw2HMyPqRUu4/RugWgUYXjakh5a2CGDDGhD+tbZGMbFeTwVsRoRYzE6Y+vVCsQGvF
 rXM02jhz72EvIug1ic3eqeFzXlEos6RFm356u5xDIbN7FleZjx7Cw7jZMVBRyyqLAXLk
 jMDfJOV4yHGPJnIAeOsCFNC72kALxKZ4tHng//ZmYH/E3TsqTZ1dzjbjKV8l43hiWbhU
 Qp514BoLVxPJ68hYkjK0tdjbL9StIsGc1+H8IY4HDp4mV4CWxc3vRvqpApn7wnx+UKAE
 oMkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4vd22RrRovPRHt7vdSPNfFCdkrtvcX4Gna7S2h3u0so6ySokLGZHEMPT78UK1EuZ+XHDkia4OzEdRUB1I+ZWCuanng40=
X-Gm-Message-State: AOJu0YyudVbUD/Gq++LKytqN5g4M3WlZFZJp2swnM2MwJg/fBUTvKJ88
 mmvbU/ajW5Tha0UPHc2eSIOSxqdIXzci70fUsUAwyyD7H472oZARFRdz6mnW81s=
X-Google-Smtp-Source: AGHT+IF3ctAx7D4BmK/J3K8ksZbvsUjXa+3JPF7azc14f59vwyWxf75VXj4f3Ql1F8QaYpsSFuIiqQ==
X-Received: by 2002:a05:6a00:4fd2:b0:70b:3175:1f4f with SMTP id
 d2e1a72fcca58-70ecea40e8amr3771492b3a.16.1722180468007; 
 Sun, 28 Jul 2024 08:27:48 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead814233sm5419684b3a.124.2024.07.28.08.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jul 2024 08:27:47 -0700 (PDT)
Message-ID: <27dda662-baef-4f09-86e0-168ab1d47a87@daynix.com>
Date: Mon, 29 Jul 2024 00:27:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Bump Avocado to 103.0 LTS and update tests for
 compatibility and new features
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240726134438.14720-1-crosa@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240726134438.14720-1-crosa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/07/26 22:44, Cleber Rosa wrote:
> This is a *long* overdue update of the Avocado version used in QEMU.
> It comes a time where the role of the runner and the libraries are
> being discussed and questioned.
> 
> These exact commits have been staging on my side for over 30 days now,
> and I was exceeding what I should in terms of testing before posting.
> I apologize for the miscalculation.
> 
> Nevertheless, as pointed out, on the ML, these changes are needed NOW.
> 
> Some examples of runs in the CI can be seen below:
> 
> * Serial with 103.0 LTS (https://gitlab.com/cleber.gnu/qemu/-/jobs/7074346143#L220):
>     RESULTS    : PASS 46 | ERROR 0 | FAIL 0 | SKIP 2 | WARN 0 | INTERRUPT 0 | CANCEL 0
>     JOB TIME   : 432.63 s
> 
> * Parallel with 103.0 LTS (https://gitlab.com/cleber.gnu/qemu/-/jobs/7085879478#L222)
>     RESULTS    : PASS 46 | ERROR 0 | FAIL 0 | SKIP 2 | WARN 0 | INTERRUPT 0 | CANCEL 0
>     JOB TIME   : 148.99 s
> 
> Cleber Rosa (13):
>    tests/avocado: mips: fallback to HTTP given certificate expiration
>    tests/avocado: mips: add hint for fetchasset plugin
>    tests/avocado/intel_iommu.py: increase timeout
>    tests/avocado: add cdrom permission related tests
>    tests/avocado: machine aarch64: standardize location and RO access
>    tests/avocado: use more distinct names for assets
>    tests/avocado/kvm_xen_guest.py: cope with asset RW requirements
>    testa/avocado: test_arm_emcraft_sf2: handle RW requirements for asset
>    tests/avocado/boot_xen.py: fetch kernel during test setUp()
>    tests/avocado/tuxrun_baselines.py: use Avocado's zstd support
>    tests/avocado/machine_aarch64_sbsaref.py: allow for rw usage of image
>    Bump avocado to 103.0
>    Avocado tests: allow for parallel execution of tests
> 
>   docs/devel/testing.rst                   | 12 +++++++
>   pythondeps.toml                          |  2 +-
>   tests/Makefile.include                   |  6 +++-
>   tests/avocado/boot_linux_console.py      | 24 ++++++++------
>   tests/avocado/boot_xen.py                | 13 ++++----
>   tests/avocado/cdrom.py                   | 41 ++++++++++++++++++++++++
>   tests/avocado/intel_iommu.py             |  2 ++
>   tests/avocado/kvm_xen_guest.py           | 30 +++++++++++------
>   tests/avocado/machine_aarch64_sbsaref.py | 11 +++++--
>   tests/avocado/machine_aarch64_virt.py    | 14 ++++----
>   tests/avocado/netdev-ethtool.py          |  3 +-
>   tests/avocado/tuxrun_baselines.py        | 16 ++++-----
>   12 files changed, 125 insertions(+), 49 deletions(-)
>   create mode 100644 tests/avocado/cdrom.py
> 

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

