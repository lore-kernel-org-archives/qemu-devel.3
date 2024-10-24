Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1395BCFA456
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 10:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3uns-0005Ea-Fu; Thu, 24 Oct 2024 06:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1t3unq-0005EO-6J; Thu, 24 Oct 2024 06:10:50 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1t3unl-0005kO-V8; Thu, 24 Oct 2024 06:10:49 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwC3r6oaHRpnfCHmAA--.453S2;
 Thu, 24 Oct 2024 18:10:34 +0800 (CST)
Received: from WYQ-S (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDnOXYZHRpnuDo4AA--.8430S3;
 Thu, 24 Oct 2024 18:10:34 +0800 (CST)
Date: Thu, 24 Oct 2024 18:10:34 +0800
From: "Yuquan Wang" <wangyuquan1236@phytium.com.cn>
To: marcin.juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 jonathan.cameron <Jonathan.Cameron@Huawei.com>, 
 quic_llindhol <quic_llindhol@quicinc.com>, 
 peter.maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
	qemu-arm <qemu-arm@nongnu.org>
Subject: Re: [RFC PATCH 1/2] hw/arm/sbsa-ref: Enable CXL Host Bridge by pxb-cxl
References: <20240830041557.600607-1-wangyuquan1236@phytium.com.cn>, 
 <20240830041557.600607-2-wangyuquan1236@phytium.com.cn>, 
 <e632758d-893f-4a44-b081-9fdd92c19548@linaro.org>
X-Priority: 3
X-GUID: 1191C4AE-BEB1-41E7-9EEA-8322B08263CD
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.301[cn]
Mime-Version: 1.0
Message-ID: <2024102418103368919519@phytium.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
X-CM-TRANSID: AQAAfwDnOXYZHRpnuDo4AA--.8430S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAIAWcZU6AEuwABs7
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWrur17KF1xZr17Ar4rXryfCrg_yoW8JF1rpF
 ZxKaySkF4kJw18Aw1kua40qFW8Can3Xa15Xry3ur18Cw45ZFyFgFn2g342va4UGayvk340
 gayUAFy5Wr1rZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Ckhp77yMTWFyY2luCgpJIGFtIHVwZGF0aW5nIHRoaXMgcGF0Y2hlcyBpbnRvIHYyIHdpdGggU2Vw
YXJhdGUgTU1JTyBhZGRyZXNzIHNwYWNlIGZvciBDWEwsCmhvd2V2ZXIsIEknbSBub3QgY29uZmlk
ZW50IGFib3V0IHRoZSBhZGRyZXNzcyBkZXNpZ24gb24gc2JzYS1yZWYuIEJlbG93IGFyZSBzb21l
CnF1ZXN0aW9ucyBhYm91dCB0aGF0LgoKMSkgV2l0aCB0aGUgcHhiLWN4bC1ob3N0LCBhbnkgY3hs
IHJvb3QgcG9ydHMgYW5kIGN4bCBlbmRwb2ludCBkZXZpY2VzIHdvdWxkIG9jY3VweSB0aGUKQkRG
IG51bWJlciBvZiB0aGUgb3JpZ2luYWwgcGNpZSBkb21haW4uIEhlbmNlLCB0aGUgbWF4IGF2YWls
YWJsZSBwY2llIGRldmljZXMgb24gc2JzYS1yZWYKd291bGQgZGVjcmVhc2UsIHdoaWNoIHNlZW1z
IHRvIGJyaW5nIGEgc2VyaWVzIG9mICB0cm91YmxlLiAgRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rp
b25zPwoKMikgSW4gdGhlIHNpdHVhdGlvbiBkZXNjcmliZWQgYWJvdmUsIGlzIGl0IG5lY2Vzc2Fy
eSB0byBhZGQgYSBzZXBhcmF0ZSBlY2FtIHNwYWNlIGZvciBjeGwgaG9zdD8KCgoKLS0tLS0tLS0t
LS0tLS0KCk1hbnkgdGhhbmtzCgoKWXVxdWFuIFdhbmcKCgoKPk9uIDMwLjA4LjIwMjQgMDY6MTUs
IFl1cXVhbiBXYW5nIHdyb3RlOgoKCgo+PiBUaGUgbWVtb3J5IGxheW91dCBwbGFjZXMgMU0gc3Bh
Y2UgZm9yIDE2IGhvc3QgYnJpZGdlIHJlZ2lzdGVyIHJlZ2lvbnMKCgoKPj4gaW4gdGhlIHNic2Et
cmVmIG1lbW1hcC4gSW4gYWRkaXRpb24sIHRoaXMgY3JlYXRlcyBhIGRlZmF1bHQgcHhiLWN4bAoK
Cgo+PiAoYnVzX25yPTB4ZmUpIGJyaWRnZSB3aXRoIG9uZSBjeGwtcnAgb24gc2JzYS1yZWYuCgoK
Cj4KCgoKPldpdGggdGhpcyBwYXRjaHNldCBhcHBsaWVkIEkgbm8gbG9uZ2VyIGNhbiBhZGQgcGNp
ZSBkZXZpY2VzIHRvIHNic2EtcmVmLgoKCgo+CgoKCj4tZGV2aWNlIG52bWUsc2VyaWFsPWRlYWRi
ZWVmLGJ1cz1yb290X3BvcnRfZm9yX252bWUxLGRyaXZlPWhkZAoKCgo+LWRyaXZlIGZpbGU9ZGlz
a3MvZnVsbC1kZWJpYW4uaGRkaW1nLGZvcm1hdD1yYXcsaWQ9aGRkLGlmPW5vbmUKCgoKPgoKCgo+
Tm9ybWFsbHkgdGhpcyBhZGRzIE5WTUUgYXMgcGNpZSBkZXZpY2UgYnV0IG5vdyBpdCBwcm9iYWJs
eSBlbmRzIG9uIAoKCgo+cHhiLWN4bCBidXMgaW5zdGVhZC4KCgoKPgoKCgo+QWxzbyBwbGVhc2Ug
YnVtcCBwbGF0Zm9ybV92ZXJzaW9uLm1pbm9yIGFuZCBkb2N1bWVudCBhZGRpbmcgQ1hMIGluIAoK
Cgo+ZG9jcy9zeXN0ZW0vYXJtL3Nic2EucnN0IGZpbGUuCgoK


