Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15089C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 10:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdS7R-0000Eu-7C; Mon, 12 Aug 2024 06:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sdS7N-0000CW-1x
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 06:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sdS7K-0001o1-EL
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 06:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723457853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lVcqCYPpo9W+fFj+K5rl8msH5Np6HFRkYMqj7Uwzb6g=;
 b=N8DiEVnw7Or0R/HB6v9wSshmcW+c6/0W++bqCDjrD+O9MIrL2l1bUrocc9nIMlGZTQ8sE3
 tOyndWVEnPMZLfVUAMNpjcgA8wFAKeOnURh7yZADOy4QkMYP/wgKN/e5Tvlw0cxhbZvxGT
 eSbhArBGNtap+QYNWJaMWJJyJ//bcq8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-yO1SNTulPr-boAPhC-w5dg-1; Mon, 12 Aug 2024 06:17:31 -0400
X-MC-Unique: yO1SNTulPr-boAPhC-w5dg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-428e48612acso49395085e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 03:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723457850; x=1724062650;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lVcqCYPpo9W+fFj+K5rl8msH5Np6HFRkYMqj7Uwzb6g=;
 b=njy6sDh5ZpZm3iQh5j9saI56h5tWsIWt5ndLnTDoKUKAyPG5p06zY3KicIKJv4CQWO
 G/k80qpupmOpFYjwNWAZXJ1mFSiHGu9iRPBYiU4QGVUML6pNtMu5KP0VOyMb6RnTovqJ
 6xKJNGKm1C+84cmrvO7SYP6klInPjCEP1nxh87nWdHCsQyw+3VlJzrGKtENgQIILXmJb
 mmB0QXf5q9AuIJZ3JesTzAnJ6X31+ouxDMfwBxZPfESbUg54yTFLOlbsMik1vzengYJi
 FgqC84B4NPf/pNxX1j8tzfzz4fCGzN8JmShcKhrGudj9PR5ofY8OmvCfA3zFRyGMTx/F
 1HUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBY7koiJzANjPXxJhn76T4osACuXz3LQHRprtzSHFj+v2vPOHcNWiYbqQEw3VXxz8NG7Q9dPWtPYjcZgCPLH7jOmGo2sc=
X-Gm-Message-State: AOJu0Yyqylfpn0piLav3OdfBqg8iXei4iMX+A+xBAebhkkpEndiqwLxv
 dOTzXW8utZbBrUwRjou+t1Wy8CDqFEAAFV0edmgA6o5aFKlelFBXGV9I+jz2CYXIo++GzQjClbU
 +FdvOKvGFNh+lwX52qZ/x60m44FI21Js8iym0dzJIPcJUE+fm2VOj
X-Received: by 2002:a05:600c:a48:b0:428:fcb:962 with SMTP id
 5b1f17b1804b1-429c3a5c30fmr69153575e9.36.1723457850102; 
 Mon, 12 Aug 2024 03:17:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9KaVH/YQWzNv+camNIPrJrOZ2kXGpngJmHnV3vUr3/NqX5jpx3SkoLO+uMuWYwLmMrltXnQ==
X-Received: by 2002:a05:600c:a48:b0:428:fcb:962 with SMTP id
 5b1f17b1804b1-429c3a5c30fmr69153255e9.36.1723457849535; 
 Mon, 12 Aug 2024 03:17:29 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-178-125.web.vodafone.de.
 [109.43.178.125]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c751b021sm97414005e9.21.2024.08.12.03.17.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 03:17:29 -0700 (PDT)
Message-ID: <1f645137-c621-4fa3-ace0-415087267a7b@redhat.com>
Date: Mon, 12 Aug 2024 12:17:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] Avocado tests: allow for parallel execution of
 tests
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Radoslaw Biernacki <rad@semihalf.com>, Troy Lee <leetroy@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Beraldo Leal <bleal@redhat.com>,
 kvm@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Paul Durrant
 <paul@xen.org>, Eric Auger <eric.auger@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>
References: <20240806173119.582857-1-crosa@redhat.com>
 <20240806173119.582857-10-crosa@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240806173119.582857-10-crosa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 06/08/2024 19.31, Cleber Rosa wrote:
> The updated Avocado version allows for the execution of tests in
> parallel.
> 
> While on a CI environment it may not be a good idea to increase the
> parallelization level in a single runner, developers may leverage that
> on specific CI runners or on their development environments.
> 
> This also multiplies the timeout for each test accordingly.  The
> reason is that more concurrency can lead to less resources, and less
> resources can lead to some specific tests taking longer to complete
> and then time out.  The timeout factor being used here is very
> conservative (being equal to the amount of parallel tasks).  The worst
> this possibly oversized timeout value can do is making users wait a
> bit longer for the job to finish if a test hangs.
> 
> Overall, users can expect a much quicker turnaround on most systems
> with a value such as 8 on a 12 core machine.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
...
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 537804d101..545b5155f9 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -94,6 +94,9 @@ TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
>   ifndef AVOCADO_TESTS
>   	AVOCADO_TESTS=tests/avocado
>   endif
> +ifndef AVOCADO_PARALLEL
> +	AVOCADO_PARALLEL=1
> +endif
>   # Controls the output generated by Avocado when running tests.
>   # Any number of command separated loggers are accepted.  For more
>   # information please refer to "avocado --help".
> @@ -141,7 +144,8 @@ check-avocado: check-venv $(TESTS_RESULTS_DIR) get-vm-images
>               --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
>               $(if $(AVOCADO_TAGS),, --filter-by-tags-include-empty \
>   			--filter-by-tags-include-empty-key) \
> -            $(AVOCADO_CMDLINE_TAGS) --max-parallel-tasks=1 \
> +            $(AVOCADO_CMDLINE_TAGS) --max-parallel-tasks=$(AVOCADO_PARALLEL) \
> +			-p timeout_factor=$(AVOCADO_PARALLEL) \
>               $(if $(GITLAB_CI),,--failfast) $(AVOCADO_TESTS), \
>               "AVOCADO", "tests/avocado")

I think it was nicer in the previous attempt to bump the avocado version:

https://gitlab.com/qemu-project/qemu/-/commit/ec5ffa0056389c3c10ea2de1e783

This re-used the "-j" option from "make", so you could do "make -j$(nproc) 
check-avocado" just like with the other "check" targets.

  Thomas


