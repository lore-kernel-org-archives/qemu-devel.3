Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDDBE7316D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmu06-00057X-31; Mon, 02 Feb 2026 08:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vmu04-000579-Me
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:29:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vmu03-0001wI-0S
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770038993;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BHBActfdr4ryjMOcT4E/azqPCem863y8anSz4A/jXvU=;
 b=HBc6s4L8dc+4+gmqwJjCVZNf9nr0E4Zj0caKd12J+0edTivuflPu8dPI6JLMJMbP+P0pr3
 dIxdyxavxU1SC2kr3blUwfroehtXFW4DDM7v29pULv8F4CdwsXiyup7hKCe/4G0YjCkeAu
 u+OOyUk/CZo28aCRU0LE29J5hbPXgwo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-fDZnrqf6PE6Ym58HMsJ7MQ-1; Mon, 02 Feb 2026 08:29:51 -0500
X-MC-Unique: fDZnrqf6PE6Ym58HMsJ7MQ-1
X-Mimecast-MFC-AGG-ID: fDZnrqf6PE6Ym58HMsJ7MQ_1770038990
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4806b12ad3fso37223565e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770038990; x=1770643790;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BHBActfdr4ryjMOcT4E/azqPCem863y8anSz4A/jXvU=;
 b=B0FjDkArmkc9EER5p+tDhWmHZ/amjYw2LrdZg+MF75vr5MVibF8OCHuh0d08aHXaZh
 GRLeKe8IeSUiWkapRM4Vb1YDy0rTTLfWCbFQUTKvzBsWUIBzG5/4166vJbnDDdUTik/4
 UGxUUE4LH+3GnLJqKQzs3y7ukGRVhpHT/d7etKVaxBvckdXXVYI/cbAKGntCzrFoAS98
 Fh/tuly1HF1iS42gjsS1AxhFutrYMbo+KYiLHpi2NpIA4LffCCl5NV82oT0eaYe1nNAc
 fcy7QplqkchEWNtFIuPapEpoOojeISjhBVU1r9yeGfxCNK5pMMLCQ+LYOpjvERYWT4wT
 nHOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9tpnLip2eNJrEJyDWqXfCOoR9dQHLq86XvZGBqNSokUIMdn1mmyFTAUp1fNp/ZHDiq4q1CQoKru/W@nongnu.org
X-Gm-Message-State: AOJu0YxL+8Bli6ZMnspbp6xXNj6bJ2sx10FoU1AbodqEl7u+KZPPe3lM
 kdLspmdLzCRXY13r8B94fHNIqge61jLlDNazHQV3fvOjAvLAjCBDTrvLf1lTZ89KsUQI2k5Ff7J
 ZRJ+vxYlk42lmcCEzsiK5gpwL5nLsCO+fYZAa78vd+VRa/dNQ/6PedR0h
X-Gm-Gg: AZuq6aIgpW+D4wljn6Stu3TJMUXjJLMiS8ViEAFU7UA2s6YEAZ3z3cKqGARKjjXEeyw
 1sTu+hneZKw39KzxQx585UEy2BaJVa6TA1+S1+bP7NYExee8IDP9Smsf+FFt5ilbvr+Y8C626cQ
 6DAodtxwbW7DqxAQ24TMy9wP59TNevQ0sJ29TuRnEbcsY7G6lN3wA77ywaI98Cy4jXicPTWGVT8
 CG5bW5tfTY6v2cwjS+i/7kS6rkkTXFKiQDiM5uUP7N1bmkvhVGZRWq1MknDeCoYfXvAQ3AhSZPy
 m8n/pRelYH+azgd8zzvLxaheN0MNDjTKlCNvBErvyz5sAt8fOAc94BNr1hnlBZ0kGSCpC6yLbSm
 wDKl+cfeGMCwlMnRo5VqTuxPOSFD25g56xgwUZskatSvN6Qb7dAaCC7HWXA==
X-Received: by 2002:a05:600c:1d1b:b0:479:3a86:dc1e with SMTP id
 5b1f17b1804b1-482db4973a8mr137964855e9.36.1770038990445; 
 Mon, 02 Feb 2026 05:29:50 -0800 (PST)
X-Received: by 2002:a05:600c:1d1b:b0:479:3a86:dc1e with SMTP id
 5b1f17b1804b1-482db4973a8mr137963865e9.36.1770038989788; 
 Mon, 02 Feb 2026 05:29:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c4f3edsm443286615e9.15.2026.02.02.05.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 05:29:48 -0800 (PST)
Message-ID: <2946621b-3d00-40dd-a80f-3f301a2e9564@redhat.com>
Date: Mon, 2 Feb 2026 14:29:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU Community call (3/2/26) agenda items?
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Markus Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, cw@f00f.org,
 demiobenour@gmail.com, dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>,
 eblot@rivosinc.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, felipe@nutanix.com,
 Alyssa Ross <hi@alyssa.is>, iggy@theiggy.com, Warner Losh <imp@bsdimp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Max Chou <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>,
 mdean@redhat.com, "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Thomas Huth <thuth@redhat.com>, wei.w.wang@intel.com, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com,
 Sebastian Ott <sebott@redhat.com>
References: <875x8fpa0x.fsf@draig.linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <875x8fpa0x.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Alex,
On 2/2/26 2:09 PM, Alex Bennée wrote:
> Hi,
>
> The KVM/QEMU community call is at:
>
> https://meet.jit.si/kvmcallmeeting
> @
> 03/02/2026 14:00 UTC
>
> Are there any agenda items for the sync-up?
>
I would be interested in discussing RH aarch64 cross kernel migration
issues.

[PATCH v6 00/11] Mitigation of "failed to load
cpu:cpreg_vmstate_array_len" migration failures <https://lore.kernel.org/all/20260126165445.3033335-1-eric.auger@redhat.com/#r>
(https://lore.kernel.org/all/20260126165445.3033335-1-eric.auger@redhat.com/)
and
[PATCH v4 0/2] arm: add kvm-psci-version vcpu property <https://lore.kernel.org/all/20251202160853.22560-1-sebott@redhat.com/#r>
(https://lore.kernel.org/all/20251202160853.22560-1-sebott@redhat.com/)

Thanks

Eric




