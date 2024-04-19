Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EC6C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 03:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxfEy-0006N0-1i; Thu, 18 Apr 2024 23:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangzw@tecorigin.com>)
 id 1rxfEw-0006Mq-DU
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 23:48:42 -0400
Received: from out28-52.mail.aliyun.com ([115.124.28.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangzw@tecorigin.com>)
 id 1rxfEu-0004Em-99
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 23:48:42 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08387199|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.00814468-0.00040141-0.991454;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047188; MF=jiangzw@tecorigin.com; NM=1;
 PH=DW; RN=3; RT=3; SR=0; TI=W4_0.2.3_21200A17_1713497077835_o7001c51n; 
Received: from WS-web
 (jiangzw@tecorigin.com[W4_0.2.3_21200A17_1713497077835_o7001c51n]) at Fri,
 19 Apr 2024 11:48:29 +0800
Date: Fri, 19 Apr 2024 11:48:29 +0800
From: "=?UTF-8?B?5aec5pm65Lyf?=" <jiangzw@tecorigin.com>
To: "Richard Henderson" <richard.henderson@linaro.org>,
 "qemu-devel" <qemu-devel@nongnu.org>
Cc: "pbonzini" <pbonzini@redhat.com>
Message-ID: <19458f9d-5833-418a-8665-80ab786102d7.jiangzw@tecorigin.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIXSB0Y2c6IEZpeCB0aGUgb3ZlcmZsb3cgaW4gaW5kZXhpbmcgdGNn?=
 =?UTF-8?B?X2N0eC0+dGVtcHM=?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][null][Chrome]
MIME-Version: 1.0
x-aliyun-im-through: {"mailThroughImNew":true}
References: <7c3b9a13-b503-47dc-ae02-ac9da8142605@linaro.org>
x-aliyun-mail-creator: W4_0.2.3_null_13aTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzkxLjAuNDQ3Mi4xNjQgU2FmYXJpLzUzNy4zNiBkaW5ndGFsay13aW4vMS4wLjAgbncoMC4xNC43KSBEaW5nVGFsayg3LjUuMTEtUmVsZWFzZS4zMTc5MTA2KSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAxMjAwIEFyY2hpdGVjdHVyZS94ODZfNjQ=sa
In-Reply-To: <7c3b9a13-b503-47dc-ae02-ac9da8142605@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=115.124.28.52; envelope-from=jiangzw@tecorigin.com;
 helo=out28-52.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Reply-To: =?UTF-8?B?5aec5pm65Lyf?= <jiangzw@tecorigin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PiBPbiA0LzE4LzI0IDAzOjI3LCBaaGl3ZWkgSmlhbmcgd3JvdGU6Cj4gPiBTb21ldGltZXMsIHdo
ZW4gdGhlIGFkZHJlc3Mgb2YgdGhlIHBhc3NlZCBUQ0dUZW1wICp0cyB2YXJpYWJsZSBpcyB0aGUg
c2FtZSBhcyB0Y2dfY3R4LAo+IAo+IFBhcmRvbj/CoCBXaGVuIHdvdWxkIFRDR1RlbXAgKnRzID09
IFRDR0NvbnRleHQgKnRjZ19jdHg/Cj4gCj4gCj4gPiB0aGUgaW5kZXggY2FsY3VsYXRlZCBpbiB0
aGUgdGVtcF9pZHggZnVuY3Rpb24sIGkuZS4sIHRzIC0gdGNnX2N0eC0+dGVtcHMsCj4gPiBjYW4g
cmVzdWx0IGluIGEgcGFydGljdWxhcmx5IGxhcmdlIHZhbHVlLCBjYXVzaW5nIG92ZXJmbG93IGlu
IHRoZSBzdWJzZXF1ZW50IGFycmF5IGFjY2Vzcy4KPiAKPiBPciwgYXNzZXJ0Ogo+IAo+IHNpemVf
dCB0ZW1wX2lkeChUQ0dUZW1wICp0cykKPiB7Cj4gIMKgIMKgIHB0cmRpZmZfdCBuID0gdHMgLSB0
Y2dfY3R4LT50ZW1wczsKPiAgwqAgwqAgYXNzZXJ0KG4gPj0gMCAmJiBuIDwgdGNnX2N0eC0+bmJf
dGVtcHMpOwo+ICDCoCDCoCByZXR1cm4gbjsKPiB9Cj4gCj4gPiDCoCBzdGF0aWMgaW5saW5lIFRD
R1RlbXAgKnRjZ3ZfaTMyX3RlbXAoVENHdl9pMzIgdikKPiA+IMKgIHsKPiA+IC3CoCDCoCByZXR1
cm4gKHZvaWQgKil0Y2dfY3R4ICsgKHVpbnRwdHJfdCl2Owo+ID4gK8KgIMKgIHJldHVybiAodm9p
ZCAqKXRjZ19jdHgtPnRlbXBzICsgKHVpbnRwdHJfdCl2Owo+ID4gwqAgfQo+IAo+IFRoaXMgd2ls
bCBnZW5lcmF0ZSAwIGZvciB0aGUgZmlyc3QgdGVtcCwgd2hpY2ggd2lsbCB0ZXN0IGFzIE5VTEwu
CgpIaSBSaWNoYXJkOgpZb3UgY2FuIHJlcHJvZHVjZSB0aGlzIGlzc3VlIG9uIHRoZSBsYXRlc3Qg
dXBzdHJlYW0gUUVNVSB2ZXJzaW9uLiBVc2luZyB0aGUgUklTQy1WIFFFTVUgdmVyc2lvbiwgCmlm
IHdlIGNvbXBpbGUgYSB0ZXN0IHByb2dyYW0gd2l0aCB0aGUgZmlyc3QgaW5zdHJ1Y3Rpb24gYmVp
bmcgJy5pbnNuIHIgMHhmLCAyLCAwLCB4MCwgeDAsIHgwJyx0aGF0IGlzIGEgUklTQy1WIENCTyBp
bnN0cnVjdGlvbiwgCnFlbXUgd2lsbCBjcmFzaCB3aXRoIGEgc2VnbWVudGF0aW9uIGZhdWx0IHVw
b24gZXhlY3V0aW9uLgoKV2hlbiB0aGUgZmlyc3QgaW5zdHJ1Y3Rpb24gaW4gdGhlIHByb2dyYW0g
aXMgYSBDQk8gaW5zdHJ1Y3Rpb24sICB0ZW1wX2lkeCBpbiBpbml0X3RzX2luZm8gZnVuYyByZXR1
cm5zIGEgdmVyeSBsYXJnZSB2YWx1ZSwgCmNhdXNpbmcgdGhlIHN1YnNlcXVlbnQgdGVzdF9iaXQg
ZnVuY3Rpb24gdG8gYWNjZXNzIG91dC1vZi1ib3VuZHMgbWVtb3J5LgoKc3RhdGljIHZvaWQgaW5p
dF90c19pbmZvKE9wdENvbnRleHQgKmN0eCwgVENHVGVtcCAqdHMpCnsKICAgIHNpemVfdCBpZHgg
PSB0ZW1wX2lkeCh0cyk7CiAgICBUZW1wT3B0SW5mbyAqdGk7CgogICAgaWYgKHRlc3RfYml0KGlk
eCwgY3R4LT50ZW1wc191c2VkLmwpKSB7CiAgICAgICAgcmV0dXJuOwogICAgfQouLi4KSSBjYW4g
Zml4IHRoaXMgc2VnbWVudGF0aW9uIGZhdWx0IGJ5IGFwcGx5aW5nIHRoZSBtb2RpZmljYXRpb24g
YWJvdmUsIAphbmQgaXQgc2VlbXMgbW9yZSBsb2dpY2FsIGluIHRlcm1zIG9mIGNvZGUgbG9naWMg
dG8gbWF0Y2ggdGhlIGFsbG9jYXRpb24gYW5kIGluZGV4aW5nIG9mIFRDR1RlbXAuCgpUaHMK

