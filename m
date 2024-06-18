Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67903C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWZa-00083e-22; Tue, 18 Jun 2024 07:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWZS-00081N-AO
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:00:15 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWZP-0002dr-Vd
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:00:14 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a63359aaaa6so798465166b.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 04:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718708409; x=1719313209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aEvL/9sIv43+Z+XtMOUxu7WbT04ANwedwP1dbaIujiw=;
 b=jcoR8T99Q9z69jssa0m+FoG6A4OI2OJSNUNKh3ulyWdNf0a2UGjOxW8Afc5CXOpr90
 E2vVusRm5TQliaG2zrsWnEpEyCMgIodnn4WrUWdsrRA/BikxHS+6MU7VwUUSAxXBGnWe
 XyGUDoBCq2g39DN0OjtD3rGyRlQuVtC8O9A0Q34VqrSrBtieNs+3I+9Mm639THyzHmog
 Dhg95xa6D2ecQIRLKF4Jjtcjm6xsBpnJH7LDUyE7G/nz792iNju4rCGXt4x5/6mU2kWP
 attHktBbvZ7RLWtUc9jkXLqXvddeajHymhcNyQqCov7PmpFBUn35m17u0D0h0ovjIcLh
 a8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718708409; x=1719313209;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aEvL/9sIv43+Z+XtMOUxu7WbT04ANwedwP1dbaIujiw=;
 b=fX3Mtof4CoxaMSQP8gsA0dFD1G6gWuEpc47KkaLYXgyBtTaqF3Z2ZsrdRe9hX/hgE3
 2PSMsNuD/7Nlh7EMJs92wdjl5/zujOUVkQrxu/kT4loZoDAiZJUw8iJPCPosb18oLYqz
 kH/y8MPRYGUgMpBPFSAjLbUi74mGvE2ZKC+7UFxRWHZDN0gAv2fAxzle+QU6voLCfMdz
 SUIzufgzWq5KWMLSH7RV+ByZRy0jVVeidErXhfX9iOwnX9ZbVnsaIYNxJfXhlW/pWWPa
 47CAn/eS08422LbrwfLSkj7kIhoHUrs7+mTTQQq1TeC0MV2D9pgHfgZwD+gTEuc7sN/C
 KSnw==
X-Gm-Message-State: AOJu0YzoW/JnNs5Y5rUEWGERu+OOjlRUMWGV4XT4nfgcUijkLy3wZcB0
 cMCxAxiPZDZF+0Joy1aOtHaxPhnC35inPri1AuhlQL3S+kI9UK+vVn3X6oD6jNrn6DRchbmWA0X
 2I74=
X-Google-Smtp-Source: AGHT+IGjunLBGd30cCL9Twn02hhsbgEcbko8ji/pJXNf5fLBj08neVVOi9NKU16y9wSXb7U+6DwHyg==
X-Received: by 2002:a17:906:22d7:b0:a6f:4d6b:c779 with SMTP id
 a640c23a62f3a-a6f60dc8007mr729743666b.52.1718708409343; 
 Tue, 18 Jun 2024 04:00:09 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f4170bsm603669566b.157.2024.06.18.04.00.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 04:00:08 -0700 (PDT)
Message-ID: <37cbd339-fef2-41aa-8f14-e7575bf5cb35@linaro.org>
Date: Tue, 18 Jun 2024 13:00:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/intc: Introduce x-query-interrupt-controllers QMP
 command
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Don Porter <porter@cs.unc.edu>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20240610063518.50680-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240610063518.50680-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 10/6/24 08:35, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (2):
>    hw/intc: Avoid using Monitor in INTERRUPT_STATS_PROVIDER::print_info()
>    hw/intc: Introduce x-query-interrupt-controllers QMP command

Series queued.

