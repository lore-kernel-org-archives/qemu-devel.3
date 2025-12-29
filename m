Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9BBE92FCA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 17:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaHRT-0005yF-Hn; Mon, 29 Dec 2025 12:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaHRK-0005wH-Tq
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:53:56 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaHRI-0004ZP-Kx
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:53:54 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a0d5c365ceso121963885ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 09:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767030831; x=1767635631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lky3eRWjNVZKS+mrPVmhhZW7nvQlMJxhyck2GcA5NUA=;
 b=TlDleG3Sx69MemQlrm3XDoXoGiqK097toDgtYOGlxY3JnBUf1B7EgEWSG+Yg5G19eh
 FKKmr6tbmbQaRZaUixs5Jxg7eAYSaSB/G6oCDT/xSWyO5gsngkn8Q9cBjZqLV12zBkYu
 cCTb5zJBqOqsTWvToQpDNV4J++59n5TueuGGunTywiBopq24MfQSXYvnb5WjLUH8oPed
 8kVG/RWh7tpaiw7gooWHqFgTmWwfhV+Vd67PsLMF2F0KKny4DSZM7sXgwRv+WjDaOa1T
 L+9RWQT6cH3t4c/eBkh3BU8HK4K9fuq815emLNC5V1I4SjpnsFjicGzm2x9yRJelQp+n
 bX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767030831; x=1767635631;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lky3eRWjNVZKS+mrPVmhhZW7nvQlMJxhyck2GcA5NUA=;
 b=iFgmuDVdqZzpHEFJNSdiGQyvlFIO5XoLZVzUpek4//648MK+lLnijV4hovP8WAfnOx
 +C/U4Ggnt1Rs1UtglAFK3tkYqciBolJtjk0HxDJ4sWNCmQwg7nFst6QCoynqbbfN6nC4
 0M4kaPMOQfLskB4IigUWX8PRHyGZmt+F81KEVwHOntToOFx4aAdk5vHoJWiMc9j9P7SB
 53WkMCx2VU01IZkcxsPm+Jft/pZH3Fd1zwcpbDXDJYuAIXJour8f2VGoNqnEb2rep4/t
 WSRRqQeXjWdGhz5lqCfKL9jXV2cMf3cS/g2yuJCwawtuNHIfjLYy4NWwfx35lc/Qpv1I
 N0EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG3Jt7Ub6/xx7bpuNT8B7tLkRSyqveEidczyDwMHT3oEzSGa/Fr4ZxYGUPU3sfV3DrD6t8w40sYIeM@nongnu.org
X-Gm-Message-State: AOJu0YyIfQbN32rEc3XTpbptXTeWFeFR5PeVVqk3pWGE+DbzfXNoiv/J
 rHAOK35vCRtH2A+5VNMmuLJtjRNijCXU2SVMYsxO5KhcNbNKG3f8EEWb2aSf9mPgNP0=
X-Gm-Gg: AY/fxX46zR6x2J17+JpP5NSoQEShK0G1m/qnrMgU0ZAlkX/+203AY4H0awMieuv/0Xo
 J250QFdbwcO7Fws1Uh8O5m/J0W2YPzSHehqT6gEDJnzxKWBgGJ7Ykqg/YKQguTVxeDI9fXgTA1s
 +NV1Hs9KlYQh+qR/OAwgvABU9H7sSlE+p8Z6tOX4zgP4Mf/I7fwaWCNUg36PWZTrbUhvYIsbLOW
 zASC4cH0PfQtA6epe9K67pjesy014BqZ6s3aK7nKQxnHkHi/mIC5iAxT3MHYEP/P636zX6nxi4Q
 w395la0xBcZwZBxRTF5lSzuWSq4Tv5IM2Ks+rFRhpnWosn5ue25+cck8Gp5+1+x/zZnh0Nrrnb6
 9uOz8MiEO4FaG0mz3FBshE8pqZt+CbHz8vrwtWD4DaoJI/+tL/qQ6/vVCtsxA1/SJxhtS5izhfL
 QxzWBToFgJMboJoY0T2p1ttT1WjEuO2M8Yknzi6hfKk1q7XhuF9OP59aGhDKPV5MyxuYA=
X-Google-Smtp-Source: AGHT+IF3q1WBxBVC8iD6QACtpbZ43a201nZhMCGmysPIkpzipaQ8LOlenvNFJc0//WIB7MVZ2DNQXg==
X-Received: by 2002:a17:902:daca:b0:295:5dbe:f629 with SMTP id
 d9443c01a7336-2a2f21fc4c9mr274162615ad.8.1767030830730; 
 Mon, 29 Dec 2025 09:53:50 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d4d858sm282363275ad.57.2025.12.29.09.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Dec 2025 09:53:50 -0800 (PST)
Message-ID: <e5607e7b-3523-4d75-b0b6-d134c7c5d1cf@linaro.org>
Date: Mon, 29 Dec 2025 09:53:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/28] docs: arm: update virt machine model description
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
 <20251228235422.30383-10-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251228235422.30383-10-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 12/28/25 3:54 PM, Mohamed Mediouni wrote:
> Update the documentation to match current QEMU.
> 
> Remove the mention of pre-2.7 machine models as those aren't provided
> anymore.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   docs/system/arm/virt.rst | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


