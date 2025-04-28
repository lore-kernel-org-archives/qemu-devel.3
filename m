Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BFBC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 12:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9O3i-0006QT-BC; Mon, 28 Apr 2025 08:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9O3g-0006P5-Sq
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:58:04 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9O3e-000321-As
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:58:04 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso3723591f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745845080; x=1746449880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=97RDQAfuMTcRKVhGJG5xteR79pJFxtwoFA593j1SMoU=;
 b=EJJeOPN2bHTT9qE4EPJwHTWpJURTvKbXhsfKunH99eq5ay2DhwCYTVSfK53x1ma+Z/
 icuC93QOQAe6LIshGZWaH4n1Rc1fzAAdHLA5XMl+dcqVvsMwDwes9HjQJ2ghHcfx0OB4
 6aVESocDPNSBGIJUHRNGrehHBYeIPzb3k3B1H+2OhYdhuymuDIQEmbM9Ok9RL4CWL4bW
 +cLtfaf0ouzmHUaJg4IpBEbbg03zpe83W/ufw+bL4wfiSXq0zzT4NY8YulaWJfPEVQh1
 +DmqXH6U5VEqSeA7mmK8hBsW3U+jtyZ1DLX7AQUWaSb1EUIDwtFehxoZE3HEvn7Pa4ZH
 C+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745845080; x=1746449880;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=97RDQAfuMTcRKVhGJG5xteR79pJFxtwoFA593j1SMoU=;
 b=C4eJQkTJ4GhfrpQvI+adwkUalEd6TSQBe+CluxG2jlFrAMmoD2+GTh15G6z5mQfbu3
 PfHVWOU/bRTN5M+FUNu9NgIvUB3GkgD2nWpOUsRzRZ9JmfAka39apkQi60S94Lmwbo72
 AMpTvBvO9h0OQzBofqWZn56MvjYXn5BOMXfKlKLFLPd1vQxlKs2E/5dVNSLAg8M/OH1p
 Cs214VdAVl7ZgtZRT7TpTijE/vVolKFNdD4q5/8UzqcDLsTEnX+p3JjlYM/ohLwlG5PW
 dOtooCxkytaWestR5yc8llE86eWRJRrRCSPvYQCzkCLHgN0xKWTw2odnhz/33WzOZXeB
 /Kfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJLRDAi2OL4t/xfwc8DC7s+tcyfRcGnO+S8DVI5NoayNP9WRLgk5lwmHdeFEHACrXHJzmSbIDo8tnL@nongnu.org
X-Gm-Message-State: AOJu0Yz+0PUrMpMvw54iFy6ttE9qbnuR21aLzqyA8zubNnrq6McAsN+x
 dUCD+LXlKHYZ0Z/uFrZsFIDzkzruzUwuZhtz2dqU3I5UaWmG0BnLtaOatdeTSok=
X-Gm-Gg: ASbGncscOO52XbATJgbBZP5bVzXi5lhYUVt3eKgubCAShz3psTZ5+5YW4Pn7V0aBM0O
 xYE+0WnfwYMJQ9SrWcz5IwCDNwGgEA1J/C44WTdXz0lHBCXuQJMNjmilcMZFa7K//YX+msdU2Vy
 aQq1/Fe4u6eLRJrLAwFszIqHY53rJ6X5oaICCgYSGth6dvFnvcseHjMXokTROSkY7VEiguc34Tl
 9Thcskkgv3IvElV/v6vljUzG4p6kuDYABMe9LTJp/txURnFoFSoqckYpmwrkKDuWNqeugkuCOA+
 xBcIyOfcxjYKSxMrPU850HpCbiXDxECeST23sXpVBf52lzAIcS1RiOs3eOKqBFmQPKx+zDKVlKN
 PcuKeanSQhbSHQYLL8eb94xs5
X-Google-Smtp-Source: AGHT+IGqoeprmdF9Wbeve/28cfJJWX5O/itP2j0C4SK+y4ZiT9C9QA4Cf7nctBxCt/kYmzQTYW+y2A==
X-Received: by 2002:a5d:5f81:0:b0:39c:1f02:44d8 with SMTP id
 ffacd0b85a97d-3a074cdbae9mr10181975f8f.4.1745845079590; 
 Mon, 28 Apr 2025 05:57:59 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5d9f6sm11363274f8f.91.2025.04.28.05.57.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 05:57:59 -0700 (PDT)
Message-ID: <eefb308b-5cd8-4b30-bc32-e37f601cb07b@linaro.org>
Date: Mon, 28 Apr 2025 14:57:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU Community call 29/04/2025 agenda items?
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster <armbru@redhat.com>
References: <874iy85yx2.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, cw@f00f.org,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com, iggy@theiggy.com,
 Warner Losh <imp@bsdimp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Jason Gunthorpe <jgg@nvidia.com>, jidong.xiao@gmail.com,
 Jim Shu <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Max Chou <max.chou@sifive.com>, mdean@redhat.com, mimu@linux.vnet.ibm.com,
 "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>,
 z.huo@139.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 zwu.kernel@gmail.com
In-Reply-To: <874iy85yx2.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 28/4/25 13:05, Alex Bennée wrote:
> 
> Hi,
> 
> The KVM/QEMU community call is at:
> 
> https://meet.jit.si/kvmcallmeeting
> @
> 29/04/2025 14:00 UTC
> 
> Are there any agenda items for the sync-up?
> 

For single binary / heterogeneous emulation, we'd like QAPI to
be "feature-agnostic". In particular, using the example of KVM
accelerator, whether a binary can run with it built-in or not
should be is irrelevant for management applications: they should
only check if it is used (enabled).

The following series is adding KVM specific structures and commands:
https://lore.kernel.org/qemu-devel/20250409082649.14733-2-zhao1.liu@intel.com/
It could be interesting to discuss if this can be avoided. But this
can also be discussed on the mailing list (as it is still currently).

