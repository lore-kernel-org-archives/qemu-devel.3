Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EECC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Sae-000627-1a; Mon, 29 Apr 2024 11:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Sac-00061Q-MH
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:06:46 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Saa-0002es-8x
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:06:46 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a5878caeb9eso570973566b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714403202; x=1715008002; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MMxatT6mdP/yLDqxHRUe08mP3A6Cixf9hW2JoyRhDrw=;
 b=BqMCjl7jixE7cOzxi+HT6xJJ2H4n8b7m8d8OMq/9pPGa1ZYOfFsgJRykNahXLkma71
 Le2dqeZuA8PkU1usfWYBr/OmiQRRQT2g6253gLnz8CSzwyZT/8K8Q78a+B0Mx0KJKy/6
 IUG3TxQeAls1Z41JWZDrqRtFGtWMr15AtLErYW6Lvk+9Q8JdKqp6MOT+hbVlA9fxr4OR
 0Gz7zUwDZZ6CLIfmuedQn6eXM9lG+4SpajLWJWXfPeqvxlqBr2L6nvdWiSMwRK7X6EPw
 IfohIPXEDTJovXjtnMmJCp5BedipoKb4mHbFVF663G4mRm1fEtMNb3G31Xe8Ri6XtStA
 mXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714403202; x=1715008002;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MMxatT6mdP/yLDqxHRUe08mP3A6Cixf9hW2JoyRhDrw=;
 b=dBwsUXM/C9FPglfU+sHsQMd3BM8hmITvL+BtG0DmAkZAcMIg7CefkjddFN52c/7wze
 CjM+vD4nN2wMA3lRywn/jxtQ2kNbymW7L8KQSdmxbjlQOhsL/hnsYIlSoecC+KSV9S68
 FHcCbtjs25Uk6hX+dv2fxxSoFhE64hsXAjQj6XmYtP3xMV0wUPIiYdPG3D2KzpV7+hkN
 kiBVTSv0RKlDL9ic+LfOYhnOSX78fpCcJBqsxswibmA21CUN79vDqs0/n/5f/Xpw+h6J
 a/lwz4jxJMcwu3Fq38iiFjYR42GREi49Bm93xZOuIw6FGqhlEPF3wWVxziOK4o52owXf
 aKFA==
X-Gm-Message-State: AOJu0YyrCx2gdIBAZs812PUPHB7atjwUEs/+PWuO69LpIDUVbfGDFdvq
 YMRgstM1PBY4fhY4jYOV1jp2nQVS9PVv6g5H5NzCFwWFAO5HnfulD5w/fzLNnHL9ho3Cb/IMykR
 Ez/g=
X-Google-Smtp-Source: AGHT+IGAZzulQEC8VbWZBHjiSCoME9EpH/Smu/Z4+hRdGyN1tJ7ldySWHRknF0rgmjlteano3CY5Xg==
X-Received: by 2002:a17:906:1544:b0:a55:5620:675c with SMTP id
 c4-20020a170906154400b00a555620675cmr5948017ejd.34.1714403202036; 
 Mon, 29 Apr 2024 08:06:42 -0700 (PDT)
Received: from [192.168.69.100] (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 l9-20020a17090615c900b00a555be38aaasm13918340ejd.164.2024.04.29.08.06.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 08:06:41 -0700 (PDT)
Message-ID: <ebdd9766-04d1-4908-996f-e93c0cd4e6d5@linaro.org>
Date: Mon, 29 Apr 2024 17:06:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU Community Call Agenda Items (April 30th, 2024)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: QEMU Developers <qemu-devel@nongnu.org>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>, armbru@redhat.com
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, afaerber@suse.de,
 ale@rev.ng, alistair.francis@wdc.com, Anton Johansson <anjo@rev.ng>,
 bbauman@redhat.com, bcain@quicinc.com, berrange@redhat.com,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com, clg@kaod.org,
 cw@f00f.org, Damien Hedde <dhedde@kalrayinc.com>, eblake@redhat.com,
 edgar.iglesias@gmail.com, eduardo@habkost.net,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, eric.auger@redhat.com,
 felipe@nutanix.com, iggy@theiggy.com, imp@bsdimp.com, jan.kiszka@web.de,
 jgg@nvidia.com, jidong.xiao@gmail.com, jim.shu@sifive.com,
 jjherne@linux.vnet.ibm.com, Joao Martins <joao.m.martins@oracle.com>,
 konrad.wilk@oracle.com, Luc Michel <luc@lmichel.fr>,
 mburton@qti.qualcomm.com, mdean@redhat.com, mimu@linux.vnet.ibm.com,
 paul.walmsley@sifive.com, pbonzini@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 shentey@gmail.com, stefanha@gmail.com, wei.w.wang@intel.com, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com,
 eblot@rivosinc.com, max.chou@sifive.com
References: <b534d873-9be3-4a24-800f-603ed25c0803@linaro.org>
Content-Language: en-US
In-Reply-To: <b534d873-9be3-4a24-800f-603ed25c0803@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Hi,

On 29/4/24 00:25, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> The KVM/QEMU community call is at:
> 
>    https://meet.jit.si/kvmcallmeeting
>    @
>    30/4/2024 14:00 UTC
> 
> Are there any agenda items for the sync-up?

I'd like to discuss two issues:

1/ Stability of QOM path
    ---------------------

   Currently we have 3 QOM containers:
    - /machine
      QOM objects properly parented go there
    - /machine/unattached
      Orphan QOM objects. Missing parent is usually easy
      to figure out, but we need to post patches to fix them.
    - /machine/peripheral[-anon]
      Devices created at runtime with CLI -device or QAPI device_add.
      (-anon is for devices with no explicit bus ID).
    See "Problem 4: The /machine/unattached/ orphanage" in [1].

   The /machine and /machine/unattached trees are stable, although
   by adding parent to orphan objects, their path will change.

   Objects in /machine/peripheral[-anon] depend on the order of
   the device_add commands / arguments used.

   In a dynamically created machine, everything depend on how the
   device_add commands are processed.

   How can be expect to easily reference a QOM object by its path?

2/ Is it safe to broadcast a QAPI event to all type of device/object?
    ------------------------------------------------------------------

    We have QMP commands such @rtc-reset-reinjection or @inject-nmi
    which expect a single RTC / NMI listener in the machine.

    When using heterogeneous machines, we might end with multiple RTC
    or NMI-aware devices. Should these commands be broadcasted to all
    devices, or should we explicitly pass a list of paths to devices
    we want to notify. Maybe we want both options.

    See threads around NMI [2] and RTC [3].

[1] https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/
[2] 
https://lore.kernel.org/qemu-devel/f4a6492b-cff4-439d-8f34-cdf04cb747ee@redhat.com/
[3] 
https://lore.kernel.org/qemu-devel/20240425133745.464091-1-d-tatianin@yandex-team.ru/

Regards,

Phil.

