Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4789FC021B2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 02:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlJ8X-00062M-SO; Thu, 20 Feb 2025 21:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1tlJ8Q-00061w-Ij
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 21:51:26 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1tlJ8O-00027x-4f
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 21:51:26 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAnLAwg6rdnI+wbBA--.20134S2;
 Fri, 21 Feb 2025 10:51:12 +0800 (CST)
Received: from wangyuquan1236$phytium.com.cn ( [218.76.62.144] ) by
 ajax-webmail-mail (Coremail) ; Fri, 21 Feb 2025 10:51:11 +0800 (GMT+08:00)
X-Originating-IP: [218.76.62.144]
Date: Fri, 21 Feb 2025 10:51:11 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Yuquan Wang" <wangyuquan1236@phytium.com.cn>
To: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Cc: fan.ni@samsung.com, qemu-devel@nongnu.org, mst@redhat.com
Subject: Re: [PATCH] docs/cxl: Add serial number for persistent-memdev
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT6 build
 20240812(cfb32469) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <20250220161213.000049a9@huawei.com>
References: <20250217112039.138650-1-wangyuquan1236@phytium.com.cn>
 <20250220161213.000049a9@huawei.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: vMClcGZvb3Rlcl90eHQ9MzUwOjM4Mw==
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7bcd2928.1690.195266a8caf.Coremail.wangyuquan1236@phytium.com.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwB3foof6rdnN+otAA--.4030W
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAHAWe2OKwOi
	QA7s+
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrKryUAFWUGrWDtry3KF48Zwb_yoWxKrc_ua
 4qqF4xKa1rGF48XF4vyFnIyr98Jws5WF10grWxJw4xGa4rAFna9Fn09r9xJF1rAw17Jwnx
 KF93Ca45u3y7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

PiAKPiBMb29rcyBnb29kLiAgSSd2ZSBxdWV1ZWQgaXQgdXAgb24gbXkgZ2l0bGFiIHN0YWdpbmcg
dHJlZSwgYnV0Cj4gTWljaGFlbCBpZiB5b3Ugd2FudCB0byBwaWNrIHRoaXMgb25lIGRpcmVjdGx5
IHRoYXQncyBmaW5lIGFzIHdlbGwuCj4gCj4gSSBzaG91bGQgYmUgcHVzaGluZyBvdXQgbXkgZ2l0
bGFiIHRyZWUgc2hvcnRseSAoYml0IG9mIG5ldHdvcmtpbmcKPiBmdW4gdG8gZGVhbCB3aXRoKS4K
PiAKSGksIEpvbmF0aGFuCgpBYm91dCBxZW11IHNpZGUsIEkgaGF2ZSBhbm90aGVyIHF1ZXN0aW9u
OiBDb3VsZCB0aGUgcWVtdSBwcm92aWRlIHNpbXVsYXRlZApSQ0gtUkNEIHRvcG9sb2d5IG5vdz8K
Cll1cXVhbgoNCg0K5L+h5oGv5a6J5YWo5aOw5piO77ya5pys6YKu5Lu25YyF5ZCr5L+h5oGv5b2S
5Y+R5Lu25Lq65omA5Zyo57uE57uH5omA5pyJLOWPkeS7tuS6uuaJgOWcqOe7hOe7h+WvueivpemC
ruS7tuaLpeacieaJgOacieadg+WIqeOAguivt+aOpeaUtuiAheazqOaEj+S/neWvhizmnKrnu4/l
j5Hku7bkurrkuabpnaLorrjlj68s5LiN5b6X5ZCR5Lu75L2V56ys5LiJ5pa557uE57uH5ZKM5Liq
5Lq66YCP6Zyy5pys6YKu5Lu25omA5ZCr5L+h5oGv44CCDQpJbmZvcm1hdGlvbiBTZWN1cml0eSBO
b3RpY2U6IFRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBtYWlsIGlzIHNvbGVseSBw
cm9wZXJ0eSBvZiB0aGUgc2VuZGVyJ3Mgb3JnYW5pemF0aW9uLlRoaXMgbWFpbCBjb21tdW5pY2F0
aW9uIGlzIGNvbmZpZGVudGlhbC5SZWNpcGllbnRzIG5hbWVkIGFib3ZlIGFyZSBvYmxpZ2F0ZWQg
dG8gbWFpbnRhaW4gc2VjcmVjeSBhbmQgYXJlIG5vdCBwZXJtaXR0ZWQgdG8gZGlzY2xvc2UgdGhl
IGNvbnRlbnRzIG9mIHRoaXMgY29tbXVuaWNhdGlvbiB0byBvdGhlcnMu


