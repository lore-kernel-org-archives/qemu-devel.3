Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9857D78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 15:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI8Tl-0007HH-AM; Mon, 02 Dec 2024 10:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=059b58481=graf@amazon.de>)
 id 1tI8Th-0007DI-CJ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 10:36:49 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=059b58481=graf@amazon.de>)
 id 1tI8Tf-0001Xk-QJ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 10:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1733153808; x=1764689808;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=DEAVnIV2d7CHUDZjhOqAOwoOBwtMs4GX00TPOyKnx2c=;
 b=KYwM5ywUr7YkKhEVYTeALa/jFz8pdgn5K6hI1GaWEDDZxXvpm/okGpaq
 EHkqv9vOG6q4F7NWfMgguU32pY0bHaEtDwqeeXuq9J+bfnQeg/4oI7Qau
 UcMQ8Z9w/d5wbUt6K3tzcRoi6OXFZDf7y0NAmJxcv/WIt1P1HwabOKC7h o=;
X-IronPort-AV: E=Sophos;i="6.12,202,1728950400"; d="scan'208";a="447486188"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
 by smtp-border-fw-2101.iad2.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 15:36:42 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:13728]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.181:2525]
 with esmtp (Farcaster)
 id 910d0dd9-e23c-4321-9fa6-964f88368cab; Mon, 2 Dec 2024 15:36:41 +0000 (UTC)
X-Farcaster-Flow-ID: 910d0dd9-e23c-4321-9fa6-964f88368cab
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 2 Dec 2024 15:36:41 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Mon, 2 Dec 2024
 15:36:40 +0000
Message-ID: <50eaf439-5812-41be-b279-55274bb3ca78@amazon.com>
Date: Mon, 2 Dec 2024 16:36:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/nitro-enclave: Fix terminal commands formatting
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>
References: <20241109122844.24057-1-dorjoychy111@gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20241109122844.24057-1-dorjoychy111@gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=72.21.196.25;
 envelope-from=prvs=059b58481=graf@amazon.de; helo=smtp-fw-2101.amazon.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Ck9uIDA5LjExLjI0IDEzOjI4LCBEb3Jqb3kgQ2hvd2RodXJ5IHdyb3RlOgo+Cj4gU2lnbmVkLW9m
Zi1ieTogRG9yam95IENob3dkaHVyeSA8ZG9yam95Y2h5MTExQGdtYWlsLmNvbT4KCgoobml0OiBQ
bGVhc2UgbWFrZSBzdXJlIHRvIGFsd2F5cyBoYXZlIGEgcGF0Y2ggZGVzY3JpcHRpb24gaW4gdGhl
IGJvZHkgb2YgCnRoZSBwYXRjaCwgZXZlbiBpZiBpdCBmZWVscyBsaWtlIHRoZSBzdWJqZWN0IHNh
eXMgaXQgYWxsKQoKUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+
CgpBbGV4CgoKCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFu
eSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENo
cmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJp
Y2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpTaXR6OiBCZXJsaW4KVXN0LUlE
OiBERSAzNjUgNTM4IDU5Nwo=


