Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6DBC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 09:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryq6H-00038T-T4; Mon, 22 Apr 2024 05:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ryq6C-00030t-P8
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 05:36:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ryq67-0002Ni-DA
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 05:36:28 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41a5b68ed5cso6494895e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 02:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713778584; x=1714383384; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BuQMumohm/ogAuve84iiwk/V7/e5MdQbR5wv2ZnC/m0=;
 b=jtd99GvkUfvNW78tKfdCPIpjrxHY+lyUPQFww5gjUzWGNkuKLIDVX+x0O4O2iGlCZD
 Wf5pFZKqlTJYXeUmt6EP/Q5Tm2/SIuZwP2AsxE5yw1J1yulrVSzBo7YFto708nYfFHh0
 c6XCBX0ktbHAtKqpyP/BP072K42YF/VIjRqH7j9g/CuxucgRmTEyoSniDOJOptfUC0D5
 xZ0Ou7yGtsvxFJpp/hrL7wvekcBRPbUcioHGMTRGr28zAcR0LX9V2F30QHqUPqRPv6tt
 c+76NreBfdrqA00vutaZAC0sJWZCYaatXDhGB3YGUki8FiTVXMPGjVBEq+pgV2yIMDjv
 VQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713778584; x=1714383384;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BuQMumohm/ogAuve84iiwk/V7/e5MdQbR5wv2ZnC/m0=;
 b=I1scjUTK6+21gz0GxHl1ruSf51QqxmNhoiefC5yLRn92uu1eTUtv5OKc65QXHX46sT
 Quwa4h4lkcSZytLKBClCDQ1C7Fat4RaduFMlxQzKOwj7S8b/I5IKA45dV44II5wzIGtg
 hK7EhpTetjI6axupRP+C+y6/CdGtrpaW6196A8275a4v1V5zrYwv0WY67RzVUJa1k+JW
 4IWv/ia9k+cOmkzpem+/Sm1+3JaPeOW0OAc4aVmXb5eyOhyjEjuqszM5po8tNTZX/X4x
 THrqDHStHihI1yWLWtqQJVcGWypr1EjLqTmLenrm/QgWP7+IWxEo+UcuhqqYIcMScbGI
 B8Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaC5rTBOJ3YTKNuIj+UC5g8AYcvBz+2NOdeAh/ciWI3AAIdrRE+7qNWDK9wg/cDIllG2mATOUEDm3NMDyLCzwxvU2RqdA=
X-Gm-Message-State: AOJu0YxFOPrw4D+E0G8Ac+JyJDF9zGZK6HJYa3LBIu/v9NrmD9TrSA8a
 y7qHRXU5wUzDcM0fX3pipmbaPXGxyWFGInyTxMdhKfB8P7NRzILt7BRkrZ/8+bA=
X-Google-Smtp-Source: AGHT+IGpTWRbFv3J2MWre1NywRMvmRbq1HR2U+lK2uAVTO6FJyH20ReESHshfRIep3msas7l2yhsIQ==
X-Received: by 2002:a05:600c:4fcf:b0:418:ad02:913e with SMTP id
 o15-20020a05600c4fcf00b00418ad02913emr8384962wmq.12.1713778584332; 
 Mon, 22 Apr 2024 02:36:24 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 fc19-20020a05600c525300b00418981b59d4sm19863739wmb.10.2024.04.22.02.36.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 02:36:23 -0700 (PDT)
Message-ID: <38b8ee51-175f-4b62-b45b-7193246cdcf9@linaro.org>
Date: Mon, 22 Apr 2024 11:36:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cameron Esfahani <dirty@apple.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: incoming+qemu-project-qemu-11167699-6omcoo4o9xejcbr5oi76p76v3-issue-2295@incoming.gitlab.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Joelle van Dyne <j@getutm.app>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: Support Apple Silicon acceleration for x86 / x86_64 guests
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

(Cc'ing Cameron in case someone at Apple can help)
& @osy86 @rth7680 @agraf @akihiko.odaki

My understanding is binaries need to be signed to enable TSO (like 
Rosetta 2), but as an open source project we can not sign the 
qemu-system-x86_64 binary, thus QEMU can't use TSO.

IIUC we did the best we could, see for example 
https://gitlab.com/qemu-project/qemu/-/commit/664a79735e4.

