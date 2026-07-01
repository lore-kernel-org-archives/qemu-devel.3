Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C7AC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wevWT-00015c-QH; Wed, 01 Jul 2026 10:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1wevWQ-00014q-Rg
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 10:02:38 -0400
Received: from m16.mail.163.com ([117.135.210.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1wevWO-0007fW-3g
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 10:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=npJbYZagLU3EcxpeZZauxlEfAUY5MlGb3+BKwT9N1K8=; b=Z
 ulv+f5hOtGrwIh14cpqJEHkXKHghPsATaLaz4qBfk72rR9rN13JZpQKqJhI0RoPD
 9yPjN3n4eEVY2FnZT1gBmoDtPtd5OHuh8NGO7qNUnU+Q5zhi3Nm0M+2xYbhw/8cn
 kUAWxcTQZP+dygG/dzUgESib9XXv16TfS/BndoemdE=
Received: from alanosong$163.com ( [59.172.119.226] ) by
 ajax-webmail-wmsvr-40-134 (Coremail) ; Wed, 1 Jul 2026 22:02:11 +0800 (CST)
X-Originating-IP: [59.172.119.226]
Date: Wed, 1 Jul 2026 22:02:11 +0800 (CST)
From: "Alano Song" <alanosong@163.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, pbonzini@redhat.com, zhao1.liu@intel.com
Subject: Re:[PATCH v2] target/i386/monitor: Refine `info tlb` command
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260619125602.17077-1-AlanoSong@163.com>
References: <20260619125602.17077-1-AlanoSong@163.com>
X-NTES-SC: AL_Qu2TAPWau00o5yaZYukcm0wQgOk5XsCwu/wk3YNec8MFvwDs+AQhZnJRM0PY9smuBCaJvz+UQhtu2M5Eba93yVkbto3uLdSTml9gSdw9Hw==
Content-Type: multipart/alternative; 
 boundary="----=_Part_155977_1901935478.1782914531624"
MIME-Version: 1.0
Message-ID: <6d54bb3d.a159.19f1dfcc129.Coremail.alanosong@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: higvCgAH11LjHUVqOhgVAA--.7W
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC9gNrf2pFHeOS6gAA3I
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=117.135.210.4; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

------=_Part_155977_1901935478.1782914531624
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

CgpBdCAyMDI2LTA2LTE5IDIwOjU2OjAyLCBBbGFub1NvbmdAMTYzLmNvbSB3cm90ZToKPldoZW4g
Ym9vdGluZyBhbiBpMzg2IHRhcmdldCwgdGhlIGBpbmZvIHRsYmAgY29tbWFuZAo+bWF5IHdhbGsg
dGhlIGVudGlyZSBwYWdlIHRhYmxlIGhpZXJhcmNoeSBhbmQgZW1pdAo+YW4gZW5vcm1vdXMgYW1v
dW50IG9mIG91dHB1dC4KPkl0IHdpbGwgdGFrZSBkb3plbnMgb2YgbWludXRlcyB0byBwcmludCBh
bGwgdGhlIGluZm8sCj5iZWNhdXNlIGVhY2ggbW9uaXRvciBwcmludCBmdW5jdGlvbiB3aWxsIGhv
bGRzICdtb25fbG9jaycuCj5UaGlzIGVmZmVjdGl2ZWx5IGhhbmdzIHRoZSBxZW11IG1vbml0b3Iu
Cj4KPkl0IG1heSBiZSBiZXR0ZXIgdG8gYWRkIHdhcm5pbmcgbm90ZSBpbiBoZWxwIG1lc3NhZ2Us
Cj5hbmQgYWRkIGEgYWRkcmVzcyByYW5nZSBieSBhcmd1bWVudCB0byBoZWxwIHVzZXIgY29udHJv
bAo+dGhlIG51bWJlciBvZiBvdXRwdXQgaXRlbXMuCj4KPlNpZ25lZC1vZmYtYnk6IEFsYW5vIFNv
bmcgPEFsYW5vU29uZ0AxNjMuY29tPgoKCgpQaW5nIGZvciBjb2RlIHJldmlldyA6KQ==
------=_Part_155977_1901935478.1782914531624
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBkYXRhLW50ZXM9Im50ZXNfbWFpbF9ib2R5X3Jvb3QiIHN0eWxlPSJsaW5lLWhlaWdodDox
Ljc7Y29sb3I6IzAwMDAwMDtmb250LXNpemU6MTRweDtmb250LWZhbWlseTpBcmlhbCI+PGRpdiBp
ZD0iZGl2TmV0ZWFzZU1haWxDYXJkIj48L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46IDA7Ij48YnI+
PC9kaXY+PHByZT5BdCAyMDI2LTA2LTE5IDIwOjU2OjAyLCBBbGFub1NvbmdAMTYzLmNvbSB3cm90
ZToKJmd0O1doZW4gYm9vdGluZyBhbiBpMzg2IHRhcmdldCwgdGhlIGBpbmZvIHRsYmAgY29tbWFu
ZAomZ3Q7bWF5IHdhbGsgdGhlIGVudGlyZSBwYWdlIHRhYmxlIGhpZXJhcmNoeSBhbmQgZW1pdAom
Z3Q7YW4gZW5vcm1vdXMgYW1vdW50IG9mIG91dHB1dC4KJmd0O0l0IHdpbGwgdGFrZSBkb3plbnMg
b2YgbWludXRlcyB0byBwcmludCBhbGwgdGhlIGluZm8sCiZndDtiZWNhdXNlIGVhY2ggbW9uaXRv
ciBwcmludCBmdW5jdGlvbiB3aWxsIGhvbGRzICdtb25fbG9jaycuCiZndDtUaGlzIGVmZmVjdGl2
ZWx5IGhhbmdzIHRoZSBxZW11IG1vbml0b3IuCiZndDsKJmd0O0l0IG1heSBiZSBiZXR0ZXIgdG8g
YWRkIHdhcm5pbmcgbm90ZSBpbiBoZWxwIG1lc3NhZ2UsCiZndDthbmQgYWRkIGEgYWRkcmVzcyBy
YW5nZSBieSBhcmd1bWVudCB0byBoZWxwIHVzZXIgY29udHJvbAomZ3Q7dGhlIG51bWJlciBvZiBv
dXRwdXQgaXRlbXMuCiZndDsKJmd0O1NpZ25lZC1vZmYtYnk6IEFsYW5vIFNvbmcgJmx0O0FsYW5v
U29uZ0AxNjMuY29tJmd0Owo8L3ByZT48YnI+PGRpdj48cHJlPjxzcGFuIHN0eWxlPSIiPlBpbmcg
Zm9yIGNvZGUgcmV2aWV3IDopPC9zcGFuPjwvcHJlPjwvZGl2PjwvZGl2Pg==
------=_Part_155977_1901935478.1782914531624--


