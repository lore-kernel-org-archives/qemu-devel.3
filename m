Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C4FFED3E6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGIeH-0002MP-7f; Fri, 24 Apr 2026 11:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGIeE-0002MF-Mw
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:40:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGIeC-0006xB-LY
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:40:54 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891f625344so67148965e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777045251; x=1777650051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EpFpv4n6Y3DKM4I4+hNiHQHKaqyVHgS771PY0SEzWCU=;
 b=XyrVVGLdbeqpRFmGqGwBEqIkFJ6EMZnUx9deoB5gSFkVYRudojHcedHDF+6hxOCUb+
 3CG1TbrjoZR470gKIhwW5chSOSJpvzR1wnzB7UcnLxcir9tSChpb+Qj7x5U/tKIsca0x
 ScDyenxNrbAIKQPBjhMQXXIbB4gEXpCX5XQuK+oq/r0MrSvMUPQbhUHNEG2kciY1JSov
 Og/gIKwJXzREDOS20PDW//xCfKrehOIlbwNKgimRl+eLLAJDEOdhnPeme7DHtb+GdENC
 IgQH+y90WMaqUUOYQ4hxFqc8BmWPtu2r+EGVHdnkNAC37B528MvGqMlZ6PtAER7C8pAs
 TBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777045251; x=1777650051;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EpFpv4n6Y3DKM4I4+hNiHQHKaqyVHgS771PY0SEzWCU=;
 b=nIYMCf7q1B+9+E6CHI78lpVcWUqRF+riihjIwPNJHiPLLdVkTi4S0w+R48j1z9C3wA
 llRE1GVhiqD9qOpYy4NBhjXficSNGu5JDYSGBBUIghHs5bA4eyUHdVuvGIx7qM2dviCY
 HWQnto/x5WSr7iZkEsOzd2Ql204xFBb8BYT8t8q5n8c7arTtp1rrHyrkaBBptibL+bXK
 XBAYNjkSc+LNbuz6958QOMRu2UTVtvBpBOJqzvB9XrbfN9BKcbpCo2vMGsApFweKgfFJ
 rrN+OH/O8ft7BbXtzHAcxHAryfVDhGZk9X4FN2SxUzBqraORfGl19oBkvDsdibvJatrj
 4Eeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8H3evhW23sUKGgPIHo53PL6z6mPhAZu1g4S25vM2NP1KxKv2jGASvufrl457pPMAcvccWTsBUmpM6r@nongnu.org
X-Gm-Message-State: AOJu0YzgwYUItdLcaPZhxumYiJXNJzsSa5/D/mH3FRx/Nm3z5feymCUh
 8XeYnNM0tbgbFOsz0L2AJA4Mt1WKHAiliVobuAL7NH9Kp2Awez7ZUrZH423raQDkgbQ=
X-Gm-Gg: AeBDiev34/JFa2Rz1coLlrr/SoV4eghA2jGW0lE8Ch2MD6MZOHOxgLyzzZdpy8rV7BD
 Gcv/EFjmCn29AsD4h09GGU/slUkIFhuNsv/hoTmyNleaBpLU+BJ1OhfrJWrQJoRttPgc0qqKbk9
 zBzwAieaqrwsZPmq0zkjyyy0fkQ4s8zjeZtdoM85Mj3AXyqj+EmwUS7T7dkZ0mxFyO+FciStKsP
 6qoT2eVWXOYToOvTic4YNkH9QVqV2CYUdqoVf1t4QT3QjmFvGl8tr0lPJAcu7sBdVFPQKhB4PFl
 k02k0GY5uMRr2fhTfZguiPEELdPKfx6PdnV5oxksNMjm9BRMSO6dimN5JrC3PaHi7oDiB6W+QXe
 nnGHCdcMxLqj2P8pkCI79KtC/fZ4s6VubZ5vRQHvXzTZkWcs6YidkVZJz4T7BAA9CMGjbwe5GzH
 ln42VLE7sSGn5rw5oa8k9KtXOpdD21rxvAtlAJXjkQjfoJhSWQhSQUrQc8Vw+1a+ewXUb2ltFGq
 XH0
X-Received: by 2002:a05:600c:4e0c:b0:489:1d7a:4537 with SMTP id
 5b1f17b1804b1-4891d7a463emr308329765e9.3.1777045250641; 
 Fri, 24 Apr 2026 08:40:50 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5e52b2c0sm44556655e9.4.2026.04.24.08.40.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 08:40:50 -0700 (PDT)
Message-ID: <ce906d97-7022-4671-8590-2f8f58b098bf@linaro.org>
Date: Fri, 24 Apr 2026 17:40:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU community call 28/4/2026 agenda items?
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <874il05rwo.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Markus Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, cw@f00f.org,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Demi Marie Obenour <demiobenour@gmail.com>, dhedde@kalrayinc.com,
 Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 Alyssa Ross <hi@alyssa.is>, iggy@theiggy.com, Warner Losh <imp@bsdimp.com>,
 jacob.oursland@gmail.com, Jan Kiszka <jan.kiszka@web.de>,
 Jason Gunthorpe <jgg@nvidia.com>, jidong.xiao@gmail.com,
 Jim Shu <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 matthieu@minio.io, Max Chou <max.chou@sifive.com>,
 Mark Burton <mburton@qti.qualcomm.com>, mdean@redhat.com,
 "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
In-Reply-To: <874il05rwo.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 24/4/26 16:55, Alex Bennée wrote:

> The KVM/QEMU community call is at:
> 
> https://meet.jit.si/kvmcallmeeting
> @
> 28/04/2026 14:00 UTC
> 
> Are there any agenda items for the sync-up?

I'd like to have a discussion with Stefan and Pierrick about the
possible improvements that can be done on our CI system, and
review our git-forge use in general.

Pierrick: Stefan is available this Tuesday, are you?

Regards,

Phil.

