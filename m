Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222A1C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 13:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpT1L-0001kg-RO; Wed, 27 Mar 2024 09:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rpT1K-0001k9-JL
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:08:46 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rpT1J-0001VN-46
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:08:46 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a4751063318so458759666b.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 06:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711544921; x=1712149721; darn=nongnu.org;
 h=content-transfer-encoding:organization:subject:cc:from
 :content-language:to:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FcZi/KDLMsZfJMILiBuYVv6+Mx4XaUM84FgSub9tZ+U=;
 b=acCLjvqaJVUre8PVeg26LII4GqQHMbbj4Eff/uqNlcmmMzZuKH33tuaXYhFi4ewI5g
 hCiFQ/IirBrDd7477ckpObw1C+TLsReqgOcHZPUoFwRsGOeLnF0zv5U9elgreSgWJACh
 QM0eO538aRDLad9a1fxSDu/0TSG9TPkcIwWLbzTo0GYP4jNU6y7RuwMMQiSEJEhfnNUL
 sVvJIPxa5qloRy7uVIJPhbxPlaJDHVK7EZ6u2uLy8xYv+7MsP7gbUqJTIIrlgJ8OIzzm
 U6QCiMqr8d4HWM15On+bNKRCErs3wIvZ7VdIWlZK1abG9g80CHN5vtXCza+NvjiyZkLT
 t++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711544921; x=1712149721;
 h=content-transfer-encoding:organization:subject:cc:from
 :content-language:to:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FcZi/KDLMsZfJMILiBuYVv6+Mx4XaUM84FgSub9tZ+U=;
 b=VFIYrLbFjYWGjdpQQhFy18DtGUkfeyjshrs5V5xgaqb0frqHjdQICMO+y+MLQyStrz
 F2AMVqqy/jCu7U81woZ4YArQFU6Ck/rckFkY/JweakiL2khkRAO+y+skRxtO556d1Xvm
 WhYCPV9aaHrErQ1Ogy3caVTHSlCAIyNXfxBihJDpTSQSJGyaSmc+SW22jktsrnwWPR3B
 F2vdSadbopai2SSjDsrd05S9GWIhnw3+s6Do/8t5ADdq0jiFD0kH1ceL0W945zGcaEKm
 yz8X0LaaZvWj5a3ej2GMm/5g8PJup9nqyMRa1SS/N29hJjcgCJrplcUQ0PfUW6C0cnWZ
 Qq6Q==
X-Gm-Message-State: AOJu0YxavxbPVsHiczOLqRw26MAV/oyy7j6GzqnW0M2dzi22ipvDnzDl
 PUZJT0gsPryZumKkIZZxeM2hcEeRsShDHoUjBSkqGBpWzeHv1xMT8zCBpLuR5+ricsJ0TeR/c/4
 Zerk=
X-Google-Smtp-Source: AGHT+IFhCuzEshW8FcTtKHVzoQD4v0zKhPsKuEOTHaZrIR8StFkC+WKuNhv1aPJ6ssq5UNo1AA/YJg==
X-Received: by 2002:a17:906:c796:b0:a47:ea3:9a09 with SMTP id
 cw22-20020a170906c79600b00a470ea39a09mr3060942ejb.46.1711544921617; 
 Wed, 27 Mar 2024 06:08:41 -0700 (PDT)
Received: from [192.168.200.106] (83.11.22.169.ipv4.supernova.orange.pl.
 [83.11.22.169]) by smtp.gmail.com with ESMTPSA id
 kn16-20020a170906aa5000b00a4749a1de50sm4857726ejb.176.2024.03.27.06.08.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 06:08:41 -0700 (PDT)
Message-ID: <be2b51af-35a7-4eb8-89c0-b933563b5224@linaro.org>
Date: Wed, 27 Mar 2024 14:08:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: qemu-devel@nongnu.org
Content-Language: pl-PL, en-GB, en-HK
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: How to add pcie-root-port and device behind it in C?
Organization: Linaro
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x62b.google.com
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

I was going through Arm (S)BSA tests run against sbsa-ref. Many of them 
check for presence of other cards than "Root Complex Integrated 
Endpoint" ones.

The "-device root-pcie-port" etc arguments can be used to add such ones 
but I was wondering how to add them directly in C code. Tried to find is 
there any example but looks like all systems use flat structure.

So the question is: How to add pcie-root-port and device behind it in C?

Something like those two arguments but in C:

-device pcie-root-port,id=JBHBE,slot=0,chassis=0
-device igb,bus=JBHBE

# lspci -tv
-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
            +-01.0  Intel Corporation 82574L Gigabit Network Connection
            +-02.0  Device 1234:1111
            \-03.0-[01]----00.0  Intel Corporation 82576 Gigabit Network

