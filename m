Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66849C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 12:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raaxX-0008F7-Rn; Thu, 15 Feb 2024 07:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m_o_bz@163.com>)
 id 1raaxS-0008Ec-RE; Thu, 15 Feb 2024 07:35:19 -0500
Received: from m16.mail.163.com ([220.197.31.2])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <m_o_bz@163.com>)
 id 1raaxN-0000gw-Mv; Thu, 15 Feb 2024 07:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:Subject:Message-ID:From:MIME-Version:
 Content-Type; bh=H0WeqezjgFQFbDDwf8Yk/vW9a8NXWpe8xqC3ZAT9LSo=;
 b=AHhxqfchN9qygebuD6La0rwy69wD50L33DEXkHKWXLHwhvxFM8CuFC8Orc8bZd
 kLVd6OmLHJotikul9YcPEQVEPU1nE1evP1m3AoVSnw9Sm02yzL9drJn8yI0c6nIl
 goMlvgduO936izmEC59Wq4VRuArRb7VHAWi79WX++URtk=
Received: from [10.208.28.133] (unknown [140.243.150.78])
 by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wDnF2jfBM5lPOuSCQ--.45883S2;
 Thu, 15 Feb 2024 20:34:40 +0800 (CST)
Date: Thu, 15 Feb 2024 20:34:38 +0800
Subject: Re: double free or corruption (out) in iscsi virtual machine
Message-ID: <1mmaslugo8633964p2gq1di8.1708000054427@email.android.com>
From: m_o_bz <m_o_bz@163.com>
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-block <qemu-block@nongnu.org>
Cc: "deepa.srinivasan" <deepa.srinivasan@oracle.com>, qemu-devel
 <qemu-devel@nongnu.org>, ronniesahlberg <ronniesahlberg@gmail.com>,
 pbonzini <pbonzini@redhat.com>, pl <pl@kamp.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="--_com.android.email_1013616003729930"
X-CM-TRANSID: _____wDnF2jfBM5lPOuSCQ--.45883S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4UtFWftF4rXF4rZr13Arb_yoWkKwb_Ca
 4rta45CrWj9r40qanrJFnavry0k3W0gF4UJw1UGrsFv34fJr4xXrsY9r97Zw15Gw1xu3y3
 Z3W8ta1Ig3sxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjJUU7UUUUU==
X-Originating-IP: [140.243.150.78]
X-CM-SenderInfo: ppbrsur26rljoofrz/1tbisgKF9WVOB29BbAAAsu
Received-SPF: pass client-ip=220.197.31.2; envelope-from=m_o_bz@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

----_com.android.email_1013616003729930
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGRpdj55ZXDvvIxJIGZvdW5kIHRoaXMgY29tbWl0IHRvbywmbmJzcDsgYWxyZWFkeSBwYXRjaCB0
aGlzIGNvbW1pdCBhbmQgdGVzdCBpdCwgdGhlIGJ1ZyBjYW4gbm90IHJlcHJvZHVjZSBhbnkgbW9y
ZTwvZGl2PjxiciBpZD0ibXpEaXZpZGVyIj48YnI+PGJyPi0tLS0tLS0tIOWOn+Wni+mCruS7tiAt
LS0tLS0tLTxicj7lj5Hku7bkurrvvJpGaW9uYSBFYm5lciAmbHQ7Zi5lYm5lckBwcm94bW94LmNv
bSZndDs8YnI+5pe26Ze077yaMjAyNOW5tDLmnIgxNeaXpSAxODoyOTxicj7mlLbku7bkurrvvJpN
X09fQnogJmx0O21fb19iekAxNjMuY29tJmd0OyxxZW11LWJsb2NrICZsdDtxZW11LWJsb2NrQG5v
bmdudS5vcmcmZ3Q7PGJyPuaKhOmAge+8miZxdW90O2RlZXBhLnNyaW5pdmFzYW4mcXVvdDsgJmx0
O2RlZXBhLnNyaW5pdmFzYW5Ab3JhY2xlLmNvbSZndDsscWVtdS1kZXZlbCAmbHQ7cWVtdS1kZXZl
bEBub25nbnUub3JnJmd0Oyxyb25uaWVzYWhsYmVyZyAmbHQ7cm9ubmllc2FobGJlcmdAZ21haWwu
Y29tJmd0OyxwYm9uemluaSAmbHQ7cGJvbnppbmlAcmVkaGF0LmNvbSZndDsscGwgJmx0O3BsQGth
bXAuZGUmZ3Q7PGJyPuS4u+mimO+8mlJlOiBkb3VibGUgZnJlZSBvciBjb3JydXB0aW9uIChvdXQp
IGluIGlzY3NpIHZpcnR1YWwgbWFjaGluZTxicj48YnI+QW0gMTcuMDEuMjQgdW0gMDg6MjMgc2No
cmllYiBNX09fQno6PGJyPiZndDsgQmFzaWMgSW5mbzo8YnI+Jmd0OyAxLiBJc3N1ZTogSSBnb3Qg
YSAiIGRvdWJsZSBmcmVlIG9yIGNvcnJ1cHRpb24gKG91dCkiLCBoZWFkIGZvcjxicj4mZ3Q7IGF0
dGFjaG1lbnQgZGVidWcubG9nIGZvciBkZXRhaWxzLCB0aGUgZGVidWcubG9nIHByaW50IHRoZSBi
YWNrdHJhY2Ugb2Y8YnI+Jmd0OyBvbmUgdmlydHVhbCBtYWNoaW5lPGJyPiZndDsgMi4gUmVwcm9k
dWNlOiBjdXJyZW50bHkgSSBjYW5uJ3QgZGVzdHJpYmUgaG93IHRvIHJlcHJvZHVjZSB0aGlzIGJ1
Zyw8YnI+Jmd0OyBiZWNhdXNlIGl0J3MgaW4gbXkgcHJvZHVjdGl2ZSBlbnZpcm9tZW50IHdoaWNo
IGluY2x1ZGUgc29tZSBzcGVjaWFsIHN0dWZmczxicj4mZ3Q7IDMuIHFlbXUgdmVyc2lvbjrCoCBJ
J20gdXNpbmcgaXMgcWVtdS02LjAuMTxicj4mZ3Q7IDQuIHFlbXUgY2NtZGxpbmUgaW4gc2hvcnQ6
KGNoZWNrb3V0IGRldGFpbCBpbiB0aGUgdmlydHVhbCBtYWNoaW5lIGxvZzxicj4mZ3Q7IG1lc3Nh
Z2UpPGJyPjxicj5IaSw8YnI+c291bmRzIGxpa2UgaXQgbWlnaHQgYmUgdGhlIGlzc3VlIGZpeGVk
IGJ5Ojxicj48YSBocmVmPSJodHRwczovL2dpdGh1Yi5jb20vcWVtdS9xZW11L2NvbW1pdC81MDgw
MTUyZTJlZjZjZGU3YWE2OTJlMjk4ODBjNjJiZDU0YWNiNzUwIj5odHRwczovL2dpdGh1Yi5jb20v
cWVtdS9xZW11L2NvbW1pdC81MDgwMTUyZTJlZjZjZGU3YWE2OTJlMjk4ODBjNjJiZDU0YWNiNzUw
PC9hPjxicj48YnI+QmVzdCBSZWdhcmRzLDxicj5GaW9uYTxicj4=
----_com.android.email_1013616003729930
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

eWVw77yMSSBmb3VuZCB0aGlzIGNvbW1pdCB0b28sICBhbHJlYWR5IHBhdGNoIHRoaXMgY29tbWl0
IGFuZCB0ZXN0IGl0LCB0aGUgYnVnIGNhbiBub3QgcmVwcm9kdWNlIGFueSBtb3JlCgoKCgotLS0t
LS0tLSDljp/lp4vpgq7ku7YgLS0tLS0tLS0K5Y+R5Lu25Lq677yaRmlvbmEgRWJuZXIgPGYuZWJu
ZXJAcHJveG1veC5jb20+CuaXtumXtO+8mjIwMjTlubQy5pyIMTXml6UgMTg6MjkK5pS25Lu25Lq6
77yaTV9PX0J6IDxtX29fYnpAMTYzLmNvbT4scWVtdS1ibG9jayA8cWVtdS1ibG9ja0Bub25nbnUu
b3JnPgrmioTpgIHvvJoiZGVlcGEuc3Jpbml2YXNhbiIgPGRlZXBhLnNyaW5pdmFzYW5Ab3JhY2xl
LmNvbT4scWVtdS1kZXZlbCA8cWVtdS1kZXZlbEBub25nbnUub3JnPixyb25uaWVzYWhsYmVyZyA8
cm9ubmllc2FobGJlcmdAZ21haWwuY29tPixwYm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4s
cGwgPHBsQGthbXAuZGU+CuS4u+mimO+8mlJlOiBkb3VibGUgZnJlZSBvciBjb3JydXB0aW9uIChv
dXQpIGluIGlzY3NpIHZpcnR1YWwgbWFjaGluZQoKPkFtIDE3LjAxLjI0IHVtIDA4OjIzIHNjaHJp
ZWIgTV9PX0J6Ogo+PiBCYXNpYyBJbmZvOgo+PiAxLiBJc3N1ZTogSSBnb3QgYSAiIGRvdWJsZSBm
cmVlIG9yIGNvcnJ1cHRpb24gKG91dCkiLCBoZWFkIGZvcgo+PiBhdHRhY2htZW50IGRlYnVnLmxv
ZyBmb3IgZGV0YWlscywgdGhlIGRlYnVnLmxvZyBwcmludCB0aGUgYmFja3RyYWNlIG9mCj4+IG9u
ZSB2aXJ0dWFsIG1hY2hpbmUKPj4gMi4gUmVwcm9kdWNlOiBjdXJyZW50bHkgSSBjYW5uJ3QgZGVz
dHJpYmUgaG93IHRvIHJlcHJvZHVjZSB0aGlzIGJ1ZywKPj4gYmVjYXVzZSBpdCdzIGluIG15IHBy
b2R1Y3RpdmUgZW52aXJvbWVudCB3aGljaCBpbmNsdWRlIHNvbWUgc3BlY2lhbCBzdHVmZnMKPj4g
My4gcWVtdSB2ZXJzaW9uOsKgIEknbSB1c2luZyBpcyBxZW11LTYuMC4xCj4+IDQuIHFlbXUgY2Nt
ZGxpbmUgaW4gc2hvcnQ6KGNoZWNrb3V0IGRldGFpbCBpbiB0aGUgdmlydHVhbCBtYWNoaW5lIGxv
Zwo+PiBtZXNzYWdlKQo+Cj5IaSwKPnNvdW5kcyBsaWtlIGl0IG1pZ2h0IGJlIHRoZSBpc3N1ZSBm
aXhlZCBieToKPmh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUvY29tbWl0LzUwODAxNTJlMmVm
NmNkZTdhYTY5MmUyOTg4MGM2MmJkNTRhY2I3NTAKPgo+QmVzdCBSZWdhcmRzLAo+RmlvbmEK
----_com.android.email_1013616003729930--


