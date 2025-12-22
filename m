Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D14D711D5
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 13:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXgHA-0003gz-1n; Mon, 22 Dec 2025 08:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=444aa8e31=graf@amazon.de>)
 id 1vXgH7-0003gM-Ig
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 08:48:38 -0500
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.1.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=444aa8e31=graf@amazon.de>)
 id 1vXgH5-00031z-Ql
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 08:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1766411315; x=1797947315;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=A9x0FhXMgTfUpxe2qk4L/H9Llq0G6N34cpFNbCgOc58=;
 b=YyuA8wkcSDxV8cQiSeEZRfw3BE64I40p4Pi690KysST6QQhph6RT6yjw
 9nrIGPbSzeHtLrayyNu7VhZw+wGNG+2iUVtPzYzLCL+o+rkN028hFhy+A
 vs0jjj4ch62iIDJzdvQgvXDW8qC8FLu0s8D0LDtSbTcxERufMfenisuJG
 bQ6XHN8y3KQJcb/wS8klyWX1N9Xa8qcok6g9vHcJ1jVVPv5QoRRLOahxk
 It6uJ+G2bWCV8/tF00EnRBMh6wMq6HZjkH2EKwz9FEUZoS4PGALFy86Dw
 /m1FKIKjjcGYv0jAQCTe2asw6JNcvPcF7FbnyXidf6MWlb+PlpNy/XEAm g==;
X-CSE-ConnectionGUID: fA+3g7z+SsalgedHfGbTvg==
X-CSE-MsgGUID: uy6Mds2oRBCt/auXL9XkAA==
X-IronPort-AV: E=Sophos;i="6.21,168,1763424000"; 
   d="scan'208";a="9566175"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 13:48:29 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:9115]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.136:2525]
 with esmtp (Farcaster)
 id 849393d8-4a6d-4921-9499-d87ad9507609; Mon, 22 Dec 2025 13:48:28 +0000 (UTC)
X-Farcaster-Flow-ID: 849393d8-4a6d-4921-9499-d87ad9507609
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 22 Dec 2025 13:48:28 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Mon, 22 Dec 2025
 13:48:27 +0000
Message-ID: <1bb44ecd-9d1c-47e0-8ed1-3ce40530bac5@amazon.com>
Date: Mon, 22 Dec 2025 14:48:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/41] hw/misc/pvpanic: Add MMIO interface
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>, Phil Dennis-Jordan <phil@philjordan.eu>
CC: Akihiko Odaki <akihiko.odaki@daynix.com>, Thomas Huth <thuth@redhat.com>
References: <20250305012157.96463-1-philmd@linaro.org>
 <20250305012157.96463-3-philmd@linaro.org>
 <fd3ee75b-c1ef-44e8-999e-0f7adf8529e7@linaro.org>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <fd3ee75b-c1ef-44e8-999e-0f7adf8529e7@linaro.org>
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=44.246.1.125;
 envelope-from=prvs=444aa8e31=graf@amazon.de;
 helo=pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Ck9uIDIyLjEyLjI1IDEwOjI4LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToKPiBIaSBB
bGV4LCBQaGlsLAo+Cj4gT24gNS8zLzI1IDAyOjIxLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3
cm90ZToKPj4gRnJvbTogQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT4KPj4KPj4gSW4g
YWRkaXRpb24gdG8gdGhlIElTQSBhbmQgUENJIHZhcmlhbnRzIG9mIHB2cGFuaWMsIGxldCdzIGFk
ZCBhbiBNTUlPCj4+IHBsYXRmb3JtIGRldmljZSB0aGF0IHdlIGNhbiB1c2UgaW4gZW1iZWRkZWQg
YXJtIGVudmlyb25tZW50cy4KPgo+IFdlIG5lZ2xlY3RlZCB0byBzcGVjaWZ5IHRoZSBlbmRpYW5u
ZXNzIG9mIHRoaXMgZGV2aWNlLiBBcyBvdGhlcgo+IHZhcmlhbnRlcyBhcmUgbGl0dGxlLWVuZGlh
biBhbmQgSSBwcmVzdW1lIHRoZSAiZW1iZWRkZWQgYXJtIiBpcwo+IGFsc28gdXNpbmcgbGl0dGxl
IGVuZGlhbm5lc3MsIGlzIGl0IHNhZmUgdG8gZGVjbGFyZSBpdCBhbHNvIGluCj4gbGl0dGxlIGVu
ZGlhbiBvcmRlciwgZm9sbG93aW5nIHRoZSBQQ0lfREVWSUNFX0lEX1JFREhBVF9QVlBBTklDCj4g
ZGVmaW5pdGlvbj8KCgpZZXMsIG5vIGNvbmNlcm5zIHdpdGggZXhwb3NpbmcgaXQgYXMgbGl0dGxl
IGVuZGlhbi4KCkFsZXgKCgoKCgpBbWF6b24gV2ViIFNlcnZpY2VzIERldmVsb3BtZW50IENlbnRl
ciBHZXJtYW55IEdtYkgKVGFtYXJhLURhbnotU3RyLiAxMwoxMDI0MyBCZXJsaW4KR2VzY2hhZWZ0
c2Z1ZWhydW5nOiBDaHJpc3RvZiBIZWxsbWlzLCBBbmRyZWFzIFN0aWVnZXIKRWluZ2V0cmFnZW4g
YW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJl
cmxpbgpVc3QtSUQ6IERFIDM2NSA1MzggNTk3Cg==


