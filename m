Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA47606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Bm8B3D4P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOGNg-0003kx-D2; Tue, 03 Nov 2026 10:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOGNe-0003ka-Hk
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 10:24:58 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOGNc-0002cN-Oo
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 10:24:58 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cd67cc518a6so2982508a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 07:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793719495; x=1794324295; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z/GkfLboPFegzHwxzvt/ph04vp+Kejsu2Ian4LkFqUc=;
 b=Bm8B3D4PcnC/9yLEFj4MhSe0kpXvC7wjNaPPp+EVInLjnQRirahPpp2v6VOW3utwed
 szIBVg3YyxsJ7lt1Fz8f7iEbB+tO2H8dRMXjtXyU3ceOY1TYvcdppAKs0rwelQciId/O
 c4TKHnLJbm62tDCU6/W9DLK2FmuFsws5Qt6AmWYmzKdGXRZx4OcNsqSUk8y2LFv9xAPG
 97VIqtzApPvl0Jk2Sy8sGIA5BjWbKWg9IpNjVlWBRhNvbOgm+rGv14xFHximLL+oSh21
 3EKfj5sDqxiZOup2F6mQMDt925eQey3Hvnf+RbqNmnY+RB2CnJ1CT4ntrfJ8RGhTtDPg
 c93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793719495; x=1794324295;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z/GkfLboPFegzHwxzvt/ph04vp+Kejsu2Ian4LkFqUc=;
 b=p6zBWsQLUm9jL62ygrfPb9R9EHu5XZA5nCIgx6WKeCZwJ7DbESt6V0J5nz9MMzig5e
 cPsRY9f5Sq8VrPlIqyxQkGJMHOhF8B77t4NknkvSt6CUSBNh+Op+u+DNgYqCkbOKfWUG
 dNugXROy+FDgqOeJDcfccuDoPbVEOn5WdOHzVt62lAG5EMp1s1UB91wTFMNCVa3ToNIP
 M3OjS7nEKynapk2QTU8KkRtd21dGkc/P5WwhO/xU9bEo4v2MSbf98v3P/iKzCB6pWs/z
 izP5oBzauzv9lhq050Wcy7ynag+R4lZIS1UesjvIINrZhSQlmDgIkD02GUuoqSfd861M
 YYRw==
X-Forwarded-Encrypted: i=1;
 AKwUvByPo8GtKOK82ZN/FoCavn7781FCBSVLDQ/04xVOLvydGJnZR+27/Y3pkIAg7QSk5OaCYONXAdst5KII@nongnu.org
X-Gm-Message-State: APuU4Z/MZvZM2ZhZpdK8IqSytl65pqAQPOn7gZEs7Vpe5J2NeWNHBc5h
 HQU/lZUjNJNEF0iizBUCCf/XZkVewP10fAFwK4m1AO3x23lGfgnClyTwe+viBVsUTkc=
X-Gm-Gg: AYBFou04OIwPvnpdzW0y1jmSQfaYFzqHbqAQvPRwI/TjY2NfD95BbPl8S8DMPPTESpS
 nMyE0mtSnc3V55JGYjjcVQtl37OgAtWKHTq0rvJuJEty/yHk2ZNPYILVYXua0u3dSLrs3+lYSvY
 S77e+v0yxK966WzZAeSo8dfnfUI5kR3x15OMtwT+/NuRjFfhvZ8c4bHhMw96bMK9BM3bMUTeHva
 6Vd8KzUkloU3HcMLUP3M5yU6x2+N0izSnDSM9N0P4efA/w9rAkdQKCyO0rzItQxValZXgbb/CTh
 SOu+pssEp1vQfZgNgxWJCrebT/k6WIS8CPrs6iGXkWLycq+s4G3OnAhSqYKu7EBroAz1ENXadYh
 DZZvO00YT8TtEZvIV0clqwLx3ZMaRkYl4cKg6pBPOVQeX1aq1FpuwPtuny8FPGKdsPQ+PjOlWmc
 mh0CJijsMhknvPvzR47SePXfqV0qb1/IlFJ1kgot7qikUffcDpB3bXwKqk3rVo2uDRZYJdjJUR1
 GfEHkW8hoi042bZj8QiUNuA0q72AU0vKnETjAMU5ORa8Ms2e/T3oJB7uY/NeUaD83/wWnRkII9S
 pherFQUVm6mFaJc8qU5FS97jOGhFh2/f5weD+xIHyfNWJS/oRchpZOkiiMDbq8Ln871bYA==
X-Received: by 2002:a05:6a21:3a87:b0:3e0:b937:883d with SMTP id
 adf61e73a8af0-3e92892cd0fmr10495507637.25.1793719494331; 
 Tue, 03 Nov 2026 07:24:54 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb363a4be8sm1618055a12.3.2026.11.03.07.24.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 07:24:53 -0800 (PST)
Message-ID: <364e3469-0502-4c62-94a6-eb6c90d17bf0@linaro.org>
Date: Tue, 3 Nov 2026 07:24:51 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Misc patches before the v11.2 softfreeze
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Junjie Cao <junjie.cao@linux.dev>, Peter Maydell <peter.maydell@linaro.org>
References: <20261102163044.644663-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261102163044.644663-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 08:30, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:
> 
>    Merge tag 'qemu-sparc-20261101' ofhttps://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2026-11-02
> 
> for you to fetch changes up to 213c716c58738be9d39488e56e6d6ed25dacd14e:
> 
>    tests/qtest/usb-hcd-xhci: test Address Device with an unreadable DCBAA (2026-11-02 15:34:15 +0100)
> 
> ----------------------------------------------------------------
> * Add a "check-thorough" test target
> * Make sure that the next-cube machine shows a deprecation note
> * Reset the open retry count after a successful open in the usb-host code
> * Make sure that XHCI code does not ignore failure when reading the DCBAA
> 
>    Note: I really don't have time to look for USB patches anymore, so after
>          this pull request, I'll stop helping out here. We really need a
>          dedicated person acting as a maintainer for the USB code..

Applied, thanks.

r~

