Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDFCCAC5A7
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Sep 2025 10:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0H0I-000084-NG; Sun, 21 Sep 2025 06:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <z_bajeer@yeah.net>)
 id 1v0H0C-000077-H5; Sun, 21 Sep 2025 06:09:04 -0400
Received: from mail-m16.yeah.net ([220.197.32.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <z_bajeer@yeah.net>)
 id 1v0H06-0001Pd-Eh; Sun, 21 Sep 2025 06:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-ID:Content-Type:
 MIME-Version; bh=lVt8AXSiBrU7EW7fu2iIpXiMqbYME6Hg87xOLP2QYFc=;
 b=hHAeQVetdK8W9f0KJjPB03dTFjuXJYJb9eoCeriIQsQRyKifH9yR80p2CqxFff
 GAEGA1AmDtYlbm85aLkNX+DQfJOy0t1ihGkz+3p+5hRQnZ1jy1j08v9M5NKI2dHq
 kk+Hc7pd/cX9QFlNu6OBpWDTzUPNu2k9TjjTMzN0HSmsk=
Received: from TYYPR01MB7759.jpnprd01.prod.outlook.com (unknown [])
 by gzsmtp1 (Coremail) with SMTP id Mc8vCgBnX7elzs9o6YvwBA--.27132S2;
 Sun, 21 Sep 2025 18:08:38 +0800 (CST)
From: "z_bajeer@yeah.net" <z_bajeer@yeah.net>
To: Alistair Francis <alistair23@gmail.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, Daniel Henrique
 Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, "yangjialong@rvcore.com"
 <yangjialong@rvcore.com>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGludGMvYWlhOiBmaXggdGhlIHJlYWQgb2YgaW5f?=
 =?utf-8?Q?clrip_register?=
Thread-Topic: [PATCH] intc/aia: fix the read of in_clrip register
Thread-Index: AXJfNC4w02qlPfV3ET33CTmGhkvOaWdITDcr0F0SYtk=
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Sun, 21 Sep 2025 10:08:35 +0000
Message-ID: <TYYPR01MB77592C2F37FC3A32A21FF14CF513A@TYYPR01MB7759.jpnprd01.prod.outlook.com>
References: <20250904060022.2828441-1-z_bajeer@yeah.net>
 <CAKmqyKNN_+zgALV_5aa7mW7Fs+XnwLwG2298xAuH5o-7BH9Obg@mail.gmail.com>
In-Reply-To: <CAKmqyKNN_+zgALV_5aa7mW7Fs+XnwLwG2298xAuH5o-7BH9Obg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CM-TRANSID: Mc8vCgBnX7elzs9o6YvwBA--.27132S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy8ArW5Aw1xtrW5uFWDXFb_yoW8Gw17pF
 WrGan8ZFs5tF1UWan7tr40qFs8G3Z3KFW5urs8u34xJa1DA3yftF4qk345uFykCF4rAr1F
 qF409ay5GayqyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRVT5QUUUUU=
X-Originating-IP: [2603:1046:c09:18e9::5]
X-CM-SenderInfo: p2betyxhhuq5hhdkh0dhw/1tbiNQbqDmjPzqaSKQAA3j
Received-SPF: pass client-ip=220.197.32.16; envelope-from=z_bajeer@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

T24gVGh1LCBTZXAgNCwgMjAyNSBhdCA0OjAy4oCvUE0gWWFuZyBKaWFsb25nIDx6X2JhamVlckB5
ZWFoLm5ldD4gd3JvdGU6Cj4+Cj4+IDQuNS43LiBSZWN0aWZpZWQgaW5wdXRzLCBjbGVhciBpbnRl
cnJ1cHQtcGVuZGluZyBiaXRzCj4+IEEgcmVhZCBvZiBhbiBpbl9jbHJpcCByZWdpc3RlciByZXR1
cm5zIHRoZSByZWN0aWZpZWQgaW5wdXQgdmFsdWVzIG9mIHRoZQo+PiBjb3JyZXNwb25kaW5nIGlu
dGVycnVwdCBzb3VyY2VzLgo+PiBBIHJlYWQgb2YgYW4gaW5fY2xyaXAgcmVnaXN0ZXIgZG9lc24n
dCBzaG91bGQgYmUgYW4gYWN0aXZlIGludGVycnVwdAo+PiBzb3VyY2UuCj4+IEEgd3JpdGUgb2Yg
YW4gaW5fY2xyaXAgcmVnaXN0ZXIgc2hvdWxkIGJlIGFuIGFjdGl2ZSBpbnRlcnJ1cHQgc291cmNl
Lgo+Cj5DYW4geW91IHBsZWFzZSBleHBsYWluIGluIHRoZSBjb21taXQgbWVzc2FnZSB3aGF0IGlz
IHdyb25nIHdpdGggdGhlCj5jdXJyZW50IGNvZGUgYW5kIHdoeSB5b3VyIHBhdGNoIGZpeGVzIGl0
Cj4KCkkgd2FudCB0byByZWFkIHRoZSByZWN0aWZpZWQgaW5wdXQgdmFsdWUgZnJvbSB0aGUgcmVn
aXN0ZXIgaW5fY2xyaXAuClRoZSBzcGVjaWZpY2F0aW9uIGFsbG93cyByZWFkaW5nICdpbl9jbHJp
cCcgaW4gYW55IHN0YXR1cywgYnV0IHRoZSBjb2RlCmluY29ycmVjdGx5IHByZXZlbnRzIGFjY2Vz
cyBkdXJpbmcgaW5hY3RpdmUgc3RhdHVzLgoKVGhhbmtzLgpZYW5nIEppYWxvbmcKCj5BbGlzdGFp
cgo+Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgSmlhbG9uZyA8el9iYWplZXJAeWVhaC5uZXQ+
Cj4+IC0tLQo+PiAgaHcvaW50Yy9yaXNjdl9hcGxpYy5jIHwgMyAtLS0KPj4gIDEgZmlsZSBjaGFu
Z2VkLCAzIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvaHcvaW50Yy9yaXNjdl9hcGxp
Yy5jIGIvaHcvaW50Yy9yaXNjdl9hcGxpYy5jCj4+IGluZGV4IGExZDlmYTUwODUuLjI1ODNkNmQz
MDUgMTAwNjQ0Cj4+IC0tLSBhL2h3L2ludGMvcmlzY3ZfYXBsaWMuYwo+PiArKysgYi9ody9pbnRj
L3Jpc2N2X2FwbGljLmMKPj4gQEAgLTIwNCw5ICsyMDQsNiBAQCBzdGF0aWMgYm9vbCByaXNjdl9h
cGxpY19pcnFfcmVjdGlmaWVkX3ZhbChSSVNDVkFQTElDU3RhdGUgKmFwbGljLAo+PiAgICAgIH0K
Pj4KPj4gICAgICBzbSA9IHNvdXJjZWNmZyAmIEFQTElDX1NPVVJDRUNGR19TTV9NQVNLOwo+PiAt
ICAgIGlmIChzbSA9PSBBUExJQ19TT1VSQ0VDRkdfU01fSU5BQ1RJVkUpIHsKPj4gLSAgICAgICAg
cmV0dXJuIGZhbHNlOwo+PiAtICAgIH0KPj4KPj4gICAgICByYXdfaW5wdXQgPSAoYXBsaWMtPnN0
YXRlW2lycV0gJiBBUExJQ19JU1RBVEVfSU5QVVQpID8gMSA6IDA7Cj4+ICAgICAgaXJxX2ludmVy
dGVkID0gKHNtID09IEFQTElDX1NPVVJDRUNGR19TTV9MRVZFTF9MT1cgfHwKPj4gLS0KPj4gMi4z
NC4xCj4+Cj4+Cg==


