Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276ADCD4846
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 05:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smoL8-0006hK-Hp; Sat, 07 Sep 2024 01:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smoL6-0006gM-3O
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 01:50:28 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smoL4-00032E-2l
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 01:50:27 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a8a7cdfdd80so53178266b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 22:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725688224; x=1726293024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9EvNAN3VKhUIbIwlOo/kfqExboF5OQ89yEFXxnItzqU=;
 b=qVnLwm0ek4by5vkGr/tiAjB/5s0CpBBn6e571CfbaDJ3iAAeAuuRUv0H/AhFJ7Le7w
 w+gkopDeRdyHf45uYrXENMgWiRrXl/C6d58s6qkK4tI4pwB+saOcpHCUKMfbZXed+49X
 KvtKnhCo7+PbVJc1CgEdqmh9ZtKuSVZTnuHqG7dV/SFl79xgq0LTnyg6uKwCxTfHf3lB
 t5PObq634FLqnHZI0Gkm7t2UyenampZ03Mr1TjhG5ginvqwQuLUG+HcWukSjRZCzbm20
 UWk7+4hNVJng3RoxQ6NYb0UuEtZYtlOph0ZzBItKQ3DydqQ5ugxRhDM31v+t0rkey7mn
 BYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725688224; x=1726293024;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9EvNAN3VKhUIbIwlOo/kfqExboF5OQ89yEFXxnItzqU=;
 b=cP/YouNdfvvwIplfjJ733NEVHArUYcdEXzAgAkG/la3G4L5Q0pcLRGCybsVpqvkhxi
 IMCEr42QzHQ+/YPONTWw41SOPtQceDDr7jwm2RhWjpZmt25MLDYwuZR+KlNIoCrQBZPk
 +vnP4grILAdo8K+TBEvdyag5Flq2H01vxadliMfD4amwx0LYJ0hYj0QZqqvUNqLvxFm+
 L/EyGujE5ch+rGwYkpPCkR6oEJFkmVi1VtDHhluDUSzVEQEabL2coHlf/BGGoJBLYieP
 4+JfKCbEZTVOoNPX+7EtrF5HyMx2qfiE3apbxD13j0UPg5je54jHg0bhdOM+/rUEjFEy
 oI6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSRFb+YmpMXw7em+agon1U7WZJgzds/QIRuVhGw2p5Qw/Hl19RWwpX4Oy5Z/gAflWuk2Q4GEmOSt3h@nongnu.org
X-Gm-Message-State: AOJu0Yw1Z2b79ypzFngfGWyIKYQhtAjB/UGdY7r7EAbATndzkhb6RnLZ
 eu4wLT6zvoU0BffPB+dfKlUlq4KiDnXpdnq/np5dPGnNbZHaGcRYuV84xz+R4l4WznnxFtz3Ry3
 ENms=
X-Google-Smtp-Source: AGHT+IGVtqvI4HvQNMdsC4cdxuDkSX4f8cF72sLqIDA3qfiGUtSkuFZR4xHZdAC+GYWUWvW2tBA9lQ==
X-Received: by 2002:a17:907:36c7:b0:a86:8ec7:11b2 with SMTP id
 a640c23a62f3a-a8a888da999mr313045066b.59.1725688224214; 
 Fri, 06 Sep 2024 22:50:24 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.174])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c61210sm30636866b.113.2024.09.06.22.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 22:50:23 -0700 (PDT)
Message-ID: <613cd174-7437-4b4b-9ab5-c7cabc2b8513@linaro.org>
Date: Sat, 7 Sep 2024 07:50:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] make range overlap check more readable
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
 <897365b8-03b9-49d1-9822-3c99e146c670@linaro.org>
 <OSZPR01MB64531A7E8576610BDD603D3A8DA82@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <3d5d891c-7e8b-4b13-8fe2-c30c5d2223e1@linaro.org>
 <OSZPR01MB645378FB40C3E46D503182648DA82@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <OSZPR01MB645378FB40C3E46D503182648DA82@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

Hi Yao,

On 22/7/24 09:40, Xingtao Yao (Fujitsu) wrote:

>> Please add to scripts/coccinelle/range.cocci.
> OK, I will add this file in next revision.

Please Cc me on v3 (I'm dropping v2 from my queue).

Thanks,

Phil.

