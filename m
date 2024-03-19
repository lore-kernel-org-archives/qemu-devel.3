Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E77C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmaOC-0006CI-A8; Tue, 19 Mar 2024 10:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmaO4-00068e-S0
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:24:24 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmaNp-0005cJ-OD
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:24:19 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d109e82bd0so74214571fa.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710858243; x=1711463043; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F78pYZuEIlcMyE8oVto9/SRkyo4tMJX9S1Xx3WTQN18=;
 b=GQNGYrBav6tk+VSVB1WDFI+WiCyoHIeT2uG+jR7B8be/ZZpanq3qNC4oDg1gQhgETN
 6DGkqSP4Qyiaz/XLd6PkcdcKnbShBCSMtR/gvLZNQi4xXdU04BuSEO+adh8T3G+4Co1N
 jJ9h6hm9EfMAmL06VZn7V44/CNHmWw1fgoBW/uasealRkibljLRw+oesZENEgmxLeLkf
 B/3ogG96pGMiLTEvwbqAEGbXjRmgO2x6zyP5gKri6Czs4+ospwt8ilQbw/PVB7FbtADj
 vxe5mJVIiMxuvRdSdWL6z01mWUX9sbWnGbGw8cBveqAfnJFCjOrOujEJONU3hKt5M/bT
 68Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710858243; x=1711463043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F78pYZuEIlcMyE8oVto9/SRkyo4tMJX9S1Xx3WTQN18=;
 b=jgUEgRoEFzYUmB7ZFdbIStG7v3nV3waQX4AVbNK3+PXFO9OFs2cydtDi0gzoh2SoKl
 cf+/ASJ+0a3AS7+CuLR6z5kL/6HPkUmFyTI4JGkyq2Zl51Kugr6ZLqqXgzeW+ip1X/SX
 QLukUikOq05ei/Ea60a0GuMnDbE6HWQ13teEzXGvRfIGjRxhEoKoCygo2PvsfT/7F1j7
 1ZbQavm91QIEFpxiZtOX107D2DL+2jTXCYc7pRBNsK0T7MPr39R5Kjd+nHSZXb7KxpKf
 UpwsQLk1cR4j0/F2upCcn8+Lr/efuJCRH014XTqMcjtiVx1pW1IiAuCqcMi45LP62P//
 Uq5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWol/2Hko4u+EB0m+nF5tQY83zjtGjE5BzpgxmuQr0KsmUeiPYoJbbs4MFr3xP9m4pSrn6MOmh5vHWbt4aEU7+OPch8/Zo=
X-Gm-Message-State: AOJu0YxnSTT1jacD+aXKhu0GTcPyZDGPD8aBClcriLwpg4xeFmJA+FAU
 bxCDqBqDSkHyUtZjOge0rT9aGlceaCBpUwra+e1fi1rz4V1+Tno6zrdJLYK3pnymQcEj99gkATb
 VID54Q6Ng3W6CPgMW67iTYnHnZbS0rywoQxG4Og==
X-Google-Smtp-Source: AGHT+IHRDpoJs4z0lPz/Ku/I4P+Uy5cY/maQ4AP/tCeEJnywf/PYNT1BZX63jqKzb0CdbA6lmOu+4koimeVlaTqFrBg=
X-Received: by 2002:a2e:9211:0:b0:2d2:cb43:bc86 with SMTP id
 k17-20020a2e9211000000b002d2cb43bc86mr1766825ljg.45.1710858243015; Tue, 19
 Mar 2024 07:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240317083704.23244-1-zhukeqian1@huawei.com>
 <20240317083704.23244-2-zhukeqian1@huawei.com>
 <4d7795bb-1dfa-40e7-a98e-4c0bafdf3db0@redhat.com>
 <7387988008764735b2f1dd5f2c83a45a@huawei.com>
 <7cc3c19c-00f0-4ad2-b0de-ba42e9b20c2a@redhat.com>
In-Reply-To: <7cc3c19c-00f0-4ad2-b0de-ba42e9b20c2a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 14:23:52 +0000
Message-ID: <CAFEAcA9iBPBvZ-9cFVRdAJaFPZmPK3adn10v2LiS90+1iUzwXA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIHYxIDEvMl0gc3lzdGVtL2NwdXM6IEZpeCBwYXVzZV9hbA==?=
 =?UTF-8?B?bF92Y3B1cygpIHVuZGVyIGNvbmN1cnJlbnQgZW52aXJvbm1lbnQ=?=
To: David Hildenbrand <david@redhat.com>
Cc: zhukeqian <zhukeqian1@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Igor Mammedov <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Wanghaibin (D)" <wanghaibin.wang@huawei.com>, yuzenghui <yuzenghui@huawei.com>,
 jiangkunkun <jiangkunkun@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "Zengtao (B)" <prime.zeng@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 19 Mar 2024 at 09:24, David Hildenbrand <david@redhat.com> wrote:
> I spotted new pause_all_vcpus() / resume_all_vcpus() calls in hw/intc/arm_gicv3_kvm.c and
> thought they would be the problematic bit.
>
> Yeah, that's going to be problematic. Further note that a lot of code does not expect
> that the BQL is suddenly dropped.

Agreed; we already have one nasty set of bugs in the framebuffer
devices because a function drops the BQL briefly:
https://lore.kernel.org/qemu-devel/CAFEAcA9odnPo2LPip295Uztri7JfoVnQbkJ=Wn+k8dQneB_ynQ@mail.gmail.com/T/#u
so let's avoid introducing any more of a similar kind.

Side note, the pause_all_vcpus()/resume_all_vcpus() calls in
hw/i386/vapic.c are probably a bit suspect for similar reasons.

-- PMM

