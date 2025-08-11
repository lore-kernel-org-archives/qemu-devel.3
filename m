Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3304CA0ECD
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 15:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulUgP-0006iU-HM; Mon, 11 Aug 2025 11:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ulUgN-0006ho-Lg
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 11:43:31 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ulUgH-0003Uk-65
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 11:43:31 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6157c81ff9eso6874265a12.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754927001; x=1755531801; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qmN1qsKAFo4bJ21o8YBT6ZRNkg/AYUdzkGNlVV8ejKU=;
 b=FuCWzORHY4z9hf+aZ5pr3haWh5FK6UsDNv6+y5XqqwjdnOmZ0qtOELGscvkHKQV/o3
 AOe1i48Yc01cOpaUvRpby/aL1Z970E4mPjgCb3oxDf1O1Yml59KiL8M21pBI5Vs5kzcr
 N6MXLZ001Vft4Q3FCyXyNU6J69AadQzW1ZC5G2m5o3wQvyK537D9xtMq2480nFNDIfXP
 hf83eh8iRync36yFZxAp97j0F65XHvxx68YqfiPO05zrhLtKF7u6niaNl51B3oubZBgH
 rg2pN40M3iXO/gLc6/KUHkuX/f2E+DPcwX48JYT/sy3Glo6KBPeAL3cTxkN0dDKV7ro6
 R1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754927001; x=1755531801;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qmN1qsKAFo4bJ21o8YBT6ZRNkg/AYUdzkGNlVV8ejKU=;
 b=IGJYoWmvTi4IX9CtaFXz26HnrcqFFsu1l1LzJicJ+SsGmYNocy6IRInhQoV7fDNRtW
 gc8cfsyz++QL5RxV5OXUoa9/qTac/TBBy3pPY0n7bJ2n9V8EJJq0eGKjQdTei4SFtOW/
 /qf9/RA+lOBzHUi86YkRux+9DBHiOtNWlPm+Cj3l9q3cM3DRIZ5rr7dC8Ofg1NfnDN+L
 ho+XwvTOL7kc6JLkPVXFHIebns1Qi8dsClbvwUU1uVZanhFvkr6LFnka0OOaQWLFVWNS
 kjE4EZH9vbkh5ORBVDtgKn2GhmI4K6dNnZN1jhoH4g5Jgute/ytuxCpJlD9loor3Mmet
 d8XQ==
X-Gm-Message-State: AOJu0YyL0aThwHO3yqhV/dRESBbsFVWGppmrcC6O++BSnIo7cYxwpNFg
 WfmglE4S7UruaOT+gA+bY2r+nsxqntFCvWPrk22xV7RdOWMBSsZRDxSx0orT6TLHAFcfqSG/gV4
 XT7fVoW/pdsL3jvcS3hVDW6QJwOfCAf4=
X-Gm-Gg: ASbGncu6Q2vzcTlhV77Y6E7hqOU/hy+9ffT8+QBN9/Mha3Vvdu7IHHPYORBYpEpcZoH
 4NMwr4BgVRqikAMLGJ6oqnuhkfVr5/uM2g/viaa8kg7mpBdNNAfKyCAw80zAFSZ74LhKSYZUkd/
 kAdGdP4mqeoSjuJTxjpgtxK26f3mx1q292JHdQHeimEaFIq9oEix1GchRAceQA8BJhqeQzhcGwP
 qlQMQ==
X-Google-Smtp-Source: AGHT+IHewPeFz2Y7vDOb0QUflhm5LCRnNMZ2ndcyGH5LOi2awTLhITF2qiwYhEl3EcbaCsoyH8Rg1/jq5kiAU/LRsTc=
X-Received: by 2002:a17:907:6d22:b0:ae0:d332:f637 with SMTP id
 a640c23a62f3a-af9c64bede8mr1359349466b.31.1754927001107; Mon, 11 Aug 2025
 08:43:21 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 11 Aug 2025 11:43:09 -0400
X-Gm-Features: Ac12FXwQQIDgx_O9KJ9KqlO4k89sEjL3jEcNBkkxJ3whbgIhztVG0c87obfXrk0
Message-ID: <CAJSP0QUgej+GPQAcot0H19hGvuAwtA1DXmbRScSXw=h3+vOHGw@mail.gmail.com>
Subject: [QEMU v10.1 blocker] PCI hotplug test for aarch64 broken
To: Gustavo Romero <gustavo.romero@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Gustavo and Alex,
The PCI hotplug test for aarch64 is no longer working because the
Debian installer URL is 404:
https://gitlab.com/qemu-project/qemu/-/jobs/10981291922#L1129

QEMU v10.1.0-rc3 will be tagged tomorrow and this may be the final
release candidate. Please send a patch with a working Debian installer
URL so the QEMU test suite passes.

If no permalink exists then I will revert commit 374a245573b8
("tests/functional: Add PCI hotplug test for aarch64") for QEMU
v10.1.0-rc3 and a long-term solution can be found during the 10.2
development cycle.

I have created a GitLab issue to track this release blocker:
https://gitlab.com/qemu-project/qemu/-/issues/3073

Thanks for your help!

Stefan

