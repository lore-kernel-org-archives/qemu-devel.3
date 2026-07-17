Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A8EC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfUi-0004h9-PR; Fri, 17 Jul 2026 06:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wkfUg-0004f1-W7
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:08:35 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wkfUf-0006gk-As
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:08:34 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so9513735e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 03:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784282911; x=1784887711; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WPYcDT7NBX3WsaIillj0axYKcvwlC8AzLwkYpRUGU4c=;
 b=r99uOmT7R/cUmQw8XcmDCSB5Zvh6ffqBM92k1tWwjdcG1vDmEqm+dB+TZxJ1akiN+h
 8QP2g2IExm06yWDhp/DbsVhf0t12F8aZsqkSc0JJ/e75VGS3m0JPfLDX9axyixQPHGqo
 5+7P6nc5lBw5u78ieqKhn4ZfI/9xtcCUFgZ3s+1Fn9pRnlHTKFMx9reqjM4CsgTxA23I
 J3WJGfGtrB+vV1obXDWZm6hPsoQ+eByXJNaHX/GuoTxSOLDRz8d5KEY+30T2EIiDXZAN
 5mouwlIAiEMq4g5EPegh2xgcMPhlEJFz1xbwgCE3BjUIh1sqL62fsMNNFW43VDwEAB1h
 l6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784282911; x=1784887711;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WPYcDT7NBX3WsaIillj0axYKcvwlC8AzLwkYpRUGU4c=;
 b=opLi2CmCiYrcBkJRhxPSVj2fohXPxVjicRbnPr4LwIOlbvtVA4gbXVL7yyp6CRt1dJ
 dAlvArSYd2K1U3Wd0JPc4UbKc+T5ZyPcxaYgezxglMNLCVWtIgGx8y9ZE/WtVzdKC7An
 qVPw2r4hoH/RR5a1mw2HP1EkyECq1cPO4uo9MQSleh3HGBI9J5LiSi4y2ctV8b50Ckbq
 6wi4ndsq9QduZKzdeDWl3edR+bzvNB8sHPasl+OVvRCtcp2X06LpCxCJQYPlIP9ZctMs
 P15PVGDcm+qrqWw9Yw/UJLondkW7idhz0+3FO3vDmgeb3yPEHYpbsQaj0hiUxYfQQ1Pe
 ivSw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRuRLjCskKLs3LKQTD+gMxYpz6Z7Mw3fEKMZ/pmxtwHlYqFe+VqgU84/EbDFDN1xbr4gEGMJAW1u/g@nongnu.org
X-Gm-Message-State: AOJu0Yz2RMyZcAKtqUryeMOtKxMQDFWttPGmtp1H7uD6JC8xh7JFOlEu
 ofX/7dKEIZwdNcUWE766E8p+uJPb89vbmmux01Pft0NOKby/vydXOa+aZihGXPcYdO8=
X-Gm-Gg: AfdE7cllzGjdG7NwfL7XHeFk8d++5xWcgd41abtDWrip+gYV/CoemOM4CCXjgAD5CZF
 ylSMQO4oVQ8GWsBOFAviNr/ZCYZjLX4Ow44k5ZGZRzkZM+zlB6zw1LtNiQUQEF/DzhwDWS9IUeG
 If4Rp5kgdEANDMZbeS7puomIw8c427kPhlvGMYJWeWuAB9U45EAfMnaaKYAPoedGxU/06Dl/rEh
 zG73ugjIj0EvgFXW6Uo73F4hq1rSS50q55ClfWfNMTvRNzquzTKSakvTy+Icjw03XIEu98ib1YE
 WOpqSAs1lRJ/rxtZ8nA4A4kkdPqvcIpupj/8dXUEPKQIklIv40v/66Q+xnbf70NMCAm+ihi5ena
 Chpdk7L/WWV29tlN88ZttDX1SHfT9LHP5mp4Q1OPJiu7avbanZBCY5IEjkPodWXirLuiNv800tM
 5PIg==
X-Received: by 2002:a05:600c:1d18:b0:495:3c6f:7c18 with SMTP id
 5b1f17b1804b1-4954a320080mr20552035e9.3.1784282910552; 
 Fri, 17 Jul 2026 03:08:30 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a47e64sm46431185e9.8.2026.07.17.03.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 03:08:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A46715F7DB;
 Fri, 17 Jul 2026 11:08:28 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jim Shu <jim.shu@sifive.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  David Hildenbrand <david@kernel.org>,  =?utf-8?Q?Cl?=
 =?utf-8?Q?=C3=A9ment?=
 Mathieu--Drif <clement.mathieu--drif@eviden.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,  "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,  =?utf-8?Q?Cl=C3=A9ment?= Chigot
 <chigot@adacore.com>,  Frederic Konrad <konrad.frederic@yahoo.fr>
Subject: Re: [PATCH] exec: Add RISC-V WorldGuard WID field to MemTxAttrs
In-Reply-To: <08c5f243-5aaa-4fe2-bc71-6a3fd9a1914e@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 18 Mar 2026 07:42:31
 +0100")
References: <20260209115846.2276651-1-jim.shu@sifive.com>
 <7be3b4f7-7516-40ab-8a95-b3b4a2aea095@linaro.org>
 <CALw707rbMvg1mf1S_3qiqDWbZ0qjzgx4UJ9pUGmQODKWttKFyQ@mail.gmail.com>
 <08c5f243-5aaa-4fe2-bc71-6a3fd9a1914e@linaro.org>
User-Agent: mu4e 1.14.3-pre1; emacs 30.1
Date: Fri, 17 Jul 2026 11:08:28 +0100
Message-ID: <87ik6e2ajn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 18/3/26 05:40, Jim Shu wrote:
>> On Tue, Feb 10, 2026 at 8:25=E2=80=AFAM Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>> ...
>>> Hmm.  This really overlaps the secure and space fields from arm, and po=
ssibly some of the
>>> others as well (e.g. user, requester_id, pid).
>>>
>>> I don't really have a good suggestion for that right now, but it would =
be nice to not keep
>>> expanding the count of these sorts of fields that somehow specify the o=
riginator, but
>>> clearly cannot overlap.
>>>
>>> I'm reasonably sure we've had this discussion before, but nothing has c=
ome of it.
>>>
>>> Time to paint the bikeshed again?
>
> Last discussion IIRC:
> https://lore.kernel.org/qemu-devel/CAFEAcA8vKNkfKgp_Yymo9NA1=3DE2XJYXAMTg=
O3z6q6DHgqkAwRw@mail.gmail.com/
>
> (see also a suggestion in
> https://lore.kernel.org/qemu-devel/Z4+P3eHXqcU4Dqdx@intel.com/)

Also somewhat related:

  Message-Id: <20221111182535.64844-1-alex.bennee@linaro.org>
  Date: Fri, 11 Nov 2022 18:25:15 +0000
  Subject: [PATCH for 8.0 v5 00/20] use MemTxAttrs to avoid current_cpu in =
hw/

Another case that was mentioned in a Core Collective meeting was
handling MMIO devices with IOMMUs (currently requester_id is tied to
PCI). I guess the WorldGuard WID field is a similar thing.

>
>>>
>> I can union the 'secure' and 'world_id' fields, as they are not used
>> together.
>> However, I have no idea about the 'space' fields.
>> I have seen CPUTLBEntryFull has the extra union to support
>> ARM-specific members.
>> Another idea is that also adding the extra union to MemTxAttrs to
>> place the RISC-V worid_id.
>> We can use this extra union to as SoC-specific signals in the bus,
>> like AXI AxUSER signal.
>> Do you think it is suitable?
>> Thanks,
>> Jim

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

