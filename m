Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E5DC02190
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 05:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tepEh-0004qJ-SF; Mon, 03 Feb 2025 00:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.sharikhin@yadro.com>)
 id 1tepEf-0004q0-KX; Mon, 03 Feb 2025 00:43:05 -0500
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.sharikhin@yadro.com>)
 id 1tepEc-0008I8-Na; Mon, 03 Feb 2025 00:43:05 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 6C75FE0006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1738561376; bh=XR+Qgb5RdAafKA3ZcekGXNrej0cUluA6kYTYApuad9I=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=m5y7gfcH1O/MyEJ8uc3wow5AkifRaKVgRK4dquXivTuRJAn37fzEle30jqDf5uGDy
 WtdgKkxGQ/nGPqC1mIp1TQsCqz7XMPtwYFejU/nWLaYaFs0W2pCzZqLFVn+5/69hZC
 ugMFfy2ciSwpuNwBKNRViMyvBgDfJ+vX7pxGR/X0dYL69pfSmwbxgadtk3T9IehtoQ
 zbcDeQbO7PxhHbDE0yUvuV49Xfk6eLhoPBi15EUzCPPtdHNakbgVEiORcXA477YLdz
 ZvaLUXdNpvHiD2XS2TTSs8RC+/cKPl3bEXv3WDaYpgCo3JLPGazLsGPSPqrFgTt5yz
 oMj2lFZV0DzrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1738561376; bh=XR+Qgb5RdAafKA3ZcekGXNrej0cUluA6kYTYApuad9I=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=JrMq9oPkO4snSSlQ65Ob246U+NRbqMwUpize4sHWTj8zbGsY1v3xpPd0WhvGnQpY2
 1t/58jMb4rqqoPZtT6MPLZMM0RLHCJ3YTESuKVvDgQGZLIltpMxCS3iJqlbER8qm2X
 nNyWzkmnG0IRw7N8l5v3IxGMaVRUheEAjS9TAHoqlhZNwfo4SfGO1t7M8xAMcukK/a
 PwEEVfGSmG6WYrgGN3AyTZytxpNJ/JRfasJL0vsy3rZlOiBWP/SRQiZkdYS53CVRoF
 O3TqDE3+cNeLUKi1+Qo5wzlSlkT4DX29v7/bEINl3OksdRAcbzQVNinee1XeWm2Ml5
 kiTpS6prsnMbA==
From: Dmitriy Sharikhin <d.sharikhin@yadro.com>
To: "sai.pavan.boddu@amd.com" <sai.pavan.boddu@amd.com>,
 "edgar.iglesias@amd.com" <edgar.iglesias@amd.com>,
 "francisco.iglesias@amd.com" <francisco.iglesias@amd.com>,
 "shentey@gmail.com" <shentey@gmail.com>, "philmd@linaro.org"
 <philmd@linaro.org>
CC: "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "edgar.iglesias@gmail.com"
 <edgar.iglesias@gmail.com>, "jcd@tribudubois.net" <jcd@tribudubois.net>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 20/21] hw/i2c: Import TCA6416 emulation from Xilinx
Thread-Topic: [PATCH 20/21] hw/i2c: Import TCA6416 emulation from Xilinx
Thread-Index: AQHbc2uGyayL9vQVLUO2O4IgflO+6LMyYrYAgAGufQCAANKYgA==
Date: Mon, 3 Feb 2025 05:42:55 +0000
Message-ID: <bfe7bca1df7d420266ec804d00a5352ef187c13c.camel@yadro.com>
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-21-shentey@gmail.com>
 <df0ed59a-fe1b-44b0-a0cc-c62303294d7b@linaro.org>
 <32A9B14A-A0F9-4768-A28F-80702FA93960@gmail.com>
 <9d957453-5749-47c7-aad1-6977dac9aeea@linaro.org>
In-Reply-To: <9d957453-5749-47c7-aad1-6977dac9aeea@linaro.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <605BF31B22CB7C479F05972E077AFCC3@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=89.207.88.253; envelope-from=d.sharikhin@yadro.com;
 helo=mta-03.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QXQgU3VuLCAwMi8wMi8yMDI1IGF0IDE4OjA5ICswMTAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cml0ZXM6DQo+IE5vIGNsdWUgYWJvdXQgY29tcGF0aWJpbGl0eS4gSWYgeW91IHVuZm9ydHVu
YXRlbHkgbmVlZCB0byBhZGQgaXQsDQo+IHRoZW4gcGxlYXNlIGFkZHJlc3MgbXkgY29tbWVudHMg
aW4gdGhlIG5leHQgdmVyc2lvbi4NClRDQTY0MTYgaXMgX3dheV8gbW9yZSBjb21wbGV4IGRldmlj
ZSB0aGFuIFBDRjg1NzQuIEJhc2ljYWxseSBQQ0Y4NTc0IGlzDQpzaGlmdCByZWdpc3RlciBkaXJl
Y3RseSBjb25uZWN0ZWQgdG8gSU8gbGluZXMsIHdoaWxlIFRDQTY0MTYgaXMgbW9yZSBsaWtlDQpm
dWxseS1mbGVkZ2VkIEdQSU8gY29udHJvbGxlciB3aXRoIG91dHB1dCBkaXJlY3Rpb24sIGRyaXZl
IHN0cmVuZ3RoLCBpbnRlcnJ1cHQNCm1hc2sgY29uZmlndXJhdGlvbiBldGMgZXRjLg0KDQpJbiBM
aW51eCBrZXJuZWwgdGhlc2UgZGV2aWNlcyBhcmUgaGFuZGxlZCBieSBmYW1pbHktY29tcGF0aWJs
ZSBkcml2ZXINCiAgIGRyaXZlcnMvZ3Bpby9ncGlvLXBjYTk1M3guYw0KQ2xvc2VzdCB0aGluZ3Mg
YnkgaW1wbGVtZW50YXRpb24gaW4gUUVNVSBzb3VyY2UgdHJlZSBhcmUNCiAgIGh3L2dwaW8vcGNh
OTU1Mi5jIGFuZA0KICAgaHcvZ3Bpby9wY2E5NTU0LmMNCkhvd2V2ZXIgdGhleSBhcmUgTk9UIHJl
Z2lzdGVyLWNvbXBhdGlibGUgd2l0aCBwY2E5NTN4LiBJIHN1cHBvc2UsIGJlc3QNCmRlY2lzaW9u
IHdvdWxkIGJlIG5ldyBkcml2ZXIgZm9yIFRDQTY0MTYgd2hpY2ggZXZlbnR1YWxseSBzaG91bGQg
c3VwcG9ydCB3aG9sZQ0KcGNhOTUzeCBmYW1pbHkgb2YgSTJDIEdQSU8gZXhwYW5kZXJzLg0KDQpC
ZXN0IHJlZ2FyZHMsDQpEbWl0cmlpDQo=

