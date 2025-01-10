Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFE0E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHsq-0007fF-29; Fri, 10 Jan 2025 11:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWHsh-0007cd-9f
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:29:08 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWHsf-0007wB-Mn
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:29:06 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e3983426f80so3559294276.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736526544; x=1737131344; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4P3RvkgYEkN/PcKVgKotdpH2Ww4nP6EziPFXrkthcqQ=;
 b=am7H6AGOaoU+6F3k8lyBfBh+g1CxJJ9uQy8SSwxcujKurPd2MzKbnq+SYcCkCo/zC4
 Vph4wWuGcgvwr39UowGtWU6t/lfIBpC5ZeYsiU7QDUy5cVAWkdP9FKK8qim2lNM5Ohkp
 6hxTYuHBk6gRPBAA5DqRx/KWVXg9fha0buiPxvQKq9s/Fh75/zSVtd7rdpbpQPPL5Npq
 fDe8HZUqszIlBfBJCFCJpRDlYNt4QgG1oTTGeRJ6nAH99Sy75jw6kvx/SpMlFhOEwgmq
 I+Z0DcLRhDeb7V8oThuKmkL3ab/nLLNgN41jvVZNZYIOx/x/RkMtkTg+VxnDDR3eFax2
 +xKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736526544; x=1737131344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4P3RvkgYEkN/PcKVgKotdpH2Ww4nP6EziPFXrkthcqQ=;
 b=gbYtyMSkOjEDM1O4uexy+yBFN5Dwjl1NA83aIteRM138fciYkoJeuZ19/1ZSOXbH9O
 Q2p/ZgX4oYNAtEVvdFtLAaFe7wVQBL2c+WYv2qqgRtT+DKoos8Lc+rbelTZZCBN4GS15
 iu5nKqriyA2rktxtWBmSq1sNykIt5z7hVDuATI+VIdRZYi7xq0Is9xfobKbUi4vLzDSS
 oAaoNQM5VOKIsnM4bbMgiiQGEhBKzCRWULtsoqoEHvIjB0OaEiH+E+0WQsUqZLhzcFzk
 uaQj5PatMEIaXzXRMApozupxQdvHxd+dtW2Pgl80GIPUw/I37Qs3kYWjR+evhOS1SeQH
 hyOA==
X-Gm-Message-State: AOJu0YxYK/iszxIkcQ8aTeAMAGAicGMNuWjNtN7NkA0x0w7FqHulPbWG
 08siSx5rGSnoFdhrJ0S50NRHGntiGrHVnX0zYWV2PQFlT0Cgm8D2w/GpvVTfBsR/bicl1hVkSdP
 JPQ3NPD1KlN5K8o2MXht6wRBWApFty6Xwj9yd/w==
X-Gm-Gg: ASbGncuRBGh4VG16PotfaJlgsoEEWnfJPJqzfQ92aiLT/BLIK3X3Ar7vO+wF8ZBhZY/
 0ehw7EEHU9D1VrX7l9aPNYvCmqKJSNHBaOSMZE38=
X-Google-Smtp-Source: AGHT+IGSQPPb4p21lFIAsHRRJ1ufv0nZ2Pc++jBHHW+w1ROe0ZcRBLTQt3v4uupnXO5Mq2h/77PKQJWNHsec/oe1BtE=
X-Received: by 2002:a05:690c:4b05:b0:6ef:4a1f:36b7 with SMTP id
 00721157ae682-6f53125116fmr94441207b3.25.1736526544276; Fri, 10 Jan 2025
 08:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2025 16:28:53 +0000
X-Gm-Features: AbW1kvYBYorNd6K3Xev2CdPCyku8Ffe0oLMvXxGOtPD0myxvI_4y9l2HxcfuYfw
Message-ID: <CAFEAcA_ChARwKyvRXsEk1U3q1T2528753Eu7LgDSsDbF1s5tNQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Change default pointer authentication algorithm on
 aarch64 to impdef
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Fabiano Rosas <farosas@suse.de>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 alex.bennee@linaro.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 19 Dec 2024 at 18:32, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> qemu-system-aarch64 default pointer authentication (QARMA5) is expensive, we
> spent up to 50% of the emulation time running it (when using TCG).
>
> Switching to pauth-impdef=on is often given as a solution to speed up execution.
> Thus we talked about making it the new default.
>
> The first patch introduce a new property (pauth-qarma5) to allow to select
> current default algorithm.
> The second one change the default.
> The third one updates documentation.
>
> v2:
> - ensure we don't break migration compatibility, by using a specific backward
>   compatible property.
> - added some documentation about migration for arm virt machine model.

Other than a minor change to the 3rd docs patch which I'll note there:
applied to target-arm.next, thanks.

-- PMM

