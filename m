Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344E1E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 15:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJDkE-0005Cq-BA; Thu, 05 Dec 2024 10:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJDk0-0005Be-SM
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:26:11 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJDjq-0008Lr-Vj
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:26:02 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa5325af6a0so162415166b.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 07:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733412356; x=1734017156; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c5Fse5OsBmvfIkY1AuFXMstw0XskRJL+JDj7m30TyUk=;
 b=MPnmx9BhLXV7TFt90d1Ccs0GU3EO8Iu3t+9EUYWMDEuIsD3acvkQneDoMiXkbFq0wy
 WHTEKW6xnMTZaeDDeTM9ou6lq8udaJBvrwV4HuUBVPy4DWFATuGVyc84YizUCCeAAV65
 PJ4ZjLXWwrJie/W63ZyAuG3NdtPP4wzhj5ANj7ZRLIfnw8O34nPRvvdwFcpaLdtva+9G
 gosDaC0JRE75srbGtuCS4De1KT0v83IDBkADDbzLu5Ap2extmrmhY6fmZ40h3v8B/hs4
 MYSXH+lTRVlXrcjESGANmHx7v/Zh+pAcEpROJMtftCfuzaTCIE/1wo+HXoE+mI0+rUgP
 0kGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733412356; x=1734017156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c5Fse5OsBmvfIkY1AuFXMstw0XskRJL+JDj7m30TyUk=;
 b=gYr5PHbtuKdgjR74glJnVPCmROElkIF8pYbR67X3D86MZ+ugonaf0jTWf/19+mkPVw
 iMxx63RHlmUYrx0hQoVy4j7T9+5vWU/bMl0TbLIUGmQP2/j2gEjhg48AC4KCZvUqyQvv
 p/RTNeCbPcjXj+xyr+KzG9n5a3ST0SK/QjJPoqSS9h/dmXuXD11ystm8jaxMs21VhnN5
 hpHZHmI66VKvuyW6S0TSlU3AKl8Uauw4jscp9JEr8OBEqJGGdaEMceh/DM9dnbvyovJM
 i7N5kEzmD+Agdk9uVDKuN+f5cCGkpomyM6BPxpHUVhmkv2Hi/gDOCCLgV7dFOoZHIVrE
 sWJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUSo4v7WrYiZK+glQs9rnfqIOKiLvg3YtBVbfFin8Q6HbNUudrU8VkCFvw0YMLf0RxpYmerjdlgplb@nongnu.org
X-Gm-Message-State: AOJu0Yxr8EHlYC3PVeNADVAsKahJ4KvuLEtdscRZEVM5nszHptsQXU5o
 UnpTmn0d1H8obUXnFC0smrDi+T7RF3Vh1GyNNdWUP3YT9vNhxFpRMRJaVvhZp2qBVeEAASUd6qS
 tnBHJaI/NvizMaYS7OrQiHQqgD8YS44FhOLILWQ==
X-Gm-Gg: ASbGncsubs6FN7sQt2KeOsLLUpO1NGit9wXVgrHGmOquri9H0qMXPoyNDtjCoSi8N8u
 3NepilYWjSSqiPEWG6wjiRDTYO4NrCCyA
X-Google-Smtp-Source: AGHT+IG1ivTWjdkyyVPMWDrboRUXJ90f55YLMIzdZkNpTf7sYVjZyQPKvlKSDNiiybqQz7VNJVH4VB/eSil7g3ZCWv8=
X-Received: by 2002:a17:907:7850:b0:aa6:27ec:688d with SMTP id
 a640c23a62f3a-aa627ec6e53mr288023566b.10.1733412356662; Thu, 05 Dec 2024
 07:25:56 -0800 (PST)
MIME-Version: 1.0
References: <20241126084928.252067-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA_SkZ+ew8AAVpBHuw-9YW4S5wFbB0Vqx+dBzXf97JGDGw@mail.gmail.com>
 <cd635753-4e2c-42d6-bb7b-d558d90f59d7@linaro.org>
 <2106db77-88fb-4113-ae09-9bf77bce6ad7@quicinc.com>
 <c4245af0-3dd4-4cf6-a786-c15fa079ad05@linaro.org>
 <18ba737f-d669-4e6a-8319-fb5052223b26@linaro.org>
 <CAFEAcA-P5P4AJidWcGgUScBTe9-K_C4Qm9N2o2XWnfiT81LU=A@mail.gmail.com>
 <641a4d44-1406-4d3f-a87a-a12fe156b2fd@linaro.org>
In-Reply-To: <641a4d44-1406-4d3f-a87a-a12fe156b2fd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 15:25:45 +0000
Message-ID: <CAFEAcA_f5s8DgjgYpyfiwPXr=ACDAecTskMOg5K-5=RLxrhogg@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: bump default memory size to 2GB
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Mathieu Poirier <mathieu.poirier@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, leif.lindholm@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

On Thu, 5 Dec 2024 at 15:10, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> W dniu 5.12.2024 o 15:53, Peter Maydell pisze:
> >> This is sbsa-ref not sbc-ref. Let it just have that 2GB of ram.
> >> None of existing SBSA systems comes with such low amount.
>
> > Yes, I think I agree here. Changing the default RAM size based on
> > whether the CPU does or does not have a particular feature is
> > unusual and not something we do on other board types, and it
> > definitely doesn't match the general intention that sbsa-ref is a
> > "looks like real hardware" machine.
> >
> > The problem with using 2GB, though, is that it doesn't work on 32-
> > bit hosts, which have a max of 2047MB (and
>
> Do we do CI on 32-bit hosts?

We do at least some. In particular the qom-test tests run
by 'make check' include "start every machine in its default
configuration and check it doesn't fall over". This will fail
for a machine that defaults to 2GB RAM on a 32-bit host.

> RME tests (queued to testing/next by Alex) already use 2GB so in such
> environment we would have failure anyway.

I think we probably don't run the 'check-functional' tests on
32-bit hosts.

-- PMM

