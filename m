Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28611606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=f3gxgkJ4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLhNP-0003jN-Lf; Tue, 27 Oct 2026 09:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.alibaba.com>)
 id 1xLcfH-0004tA-RK
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 04:36:16 -0400
Received: from [115.124.30.124] (helo=out30-124.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.alibaba.com>)
 id 1xLcfB-00032o-97
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 04:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1793090146; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
 bh=s69eFhLNfIQfWLwU4zBQwqmKDaHXyoN/gEXr1hbgJW0=;
 b=f3gxgkJ4C80VAiDgzWn3U5eN3qfLPqn2VKkxD5A4xRERodRDz0gYU7OMJd+o4ZQt5fJU4RKnZBx3gLNEO0pPYnQ+IpLoXO67jVNNPM9M+ttWxTLsJ/uV1HHyHxFrI4bvScOSEwO0oFPyZZ02mFPno1asb+XpIemsEz6UVmnNBik=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=hao.xiang@linux.alibaba.com; NM=1; PH=DW; RN=6; SR=0;
 TI=alimail_imapd_hao.xiang@linux.alibaba.com-33.37.4.148-367-1793089112; 
Received: from WS-web
 (hao.xiang@linux.alibaba.com[alimail_imapd_hao.xiang@linux.alibaba.com-33.37.4.148-367-1793089112]
 cluster:ay36) at Tue, 27 Oct 2026 16:30:27 +0800
Date: Tue, 27 Oct 2026 16:30:27 +0800
From: "Hao Xiang" <hao.xiang@linux.alibaba.com>
To: "qemu-devel" <qemu-devel@nongnu.org>, "pbonzini" <pbonzini@redhat.com>,
 "zhao1.liu" <zhao1.liu@intel.com>, "mst" <mst@redhat.com>,
 "farosas" <farosas@suse.de>, "lvivier" <lvivier@redhat.com>
Message-ID: <11491981-b61f-453b-9c12-96ec85063c4a.hao.xiang@linux.alibaba.com>
Subject: =?UTF-8?B?W1BBVENIXSBpMzg2L2NwdTogUmVuYW1lIEFWWDEwX1ZOTklfSU5UIHRvIEFWWDEwX1YxX0FV?=
 =?UTF-8?B?WA==?=
X-Mailer: [Alimail-Mailagent revision 74][W4_0.2.3][v5ForWebDing][Chrome]
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_QvNTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzE1NS4wLjAuMCBTYWZhcmkvNTM3LjM2La
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.124 (deferred)
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=hao.xiang@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:37:53 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Hao Xiang <hao.xiang@linux.alibaba.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

UmVuYW1lIEFWWDEwX1ZOTklfSU5UIGlzIHRvIEFWWDEwX1YxX0FVWCB0byBtYXRjaCB0aGUgbW9z
dCByZWNlbnQgdmVyc2lvbgpvZiB0aGUgQVZYMTAuMiBzcGVjIChyZXZpc2lvbiA3LjApIFsqXS4g
IEludGVsIHJlbmFtZWQgdGhlIENQVUlEIGZsYWcgdG8KYXBwbHkgdG8gYSB2YXJpZXR5IG9mICJj
b252ZXJ0IiBpbnN0cnVjdGlvbnMgYXMgd2VsbCBhcyBWTk5JIGluc3RydWN0aW9ucy4KClRoZSBy
ZWNlbnQgS1ZNIHBhdGNoIGhhcyByZW5hbWVkIEFWWDEwX1ZOTklfSU5UIHRvIEFWWDEwX1YxX0FV
WC4gUUVNVSBuZWVkcwp0byB1cGRhdGUgdGhlIENQVUlEIG1hY3JvLCBmZWF0dXJlIHByb3BlcnR5
LCBBVlgxMC4yIGZlYXR1cmUgbW9kZWwgYW5kCkRpYW1vbmQgUmFwaWRzIENQVSBkZWZpbml0aW9u
LiBLZWVwIHRoZSBDUFVJRCBsb2NhdGlvbiBhbmQgYml0IHVuY2hhbmdlZC4KClsqXSBJbnRlbMKu
IEFkdmFuY2VkIFZlY3RvciBFeHRlbnNpb25zIDEwLjIgQXJjaGl0ZWN0dXJlIFNwZWNpZmljYXRp
b24gCihyZXYgNy4wKQoKU2lnbmVkLW9mZi1ieTogSGFvIFhpYW5nIDxoYW8ueGlhbmdAbGludXgu
YWxpYmFiYS5jb20+Ci0tLQogIHRhcmdldC9pMzg2L2NwdS5jIHwgNiArKystLS0KICB0YXJnZXQv
aTM4Ni9jcHUuaCB8IDQgKystLQogIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9pMzg2L2NwdS5jIGIvdGFyZ2V0L2kz
ODYvY3B1LmMKaW5kZXggOWI5ZWQyZDFlMy4uZTdlMzVjM2Y1YiAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2kzODYvY3B1LmMKKysrIGIvdGFyZ2V0L2kzODYvY3B1LmMKQEAgLTEzNjYsNyArMTM2Niw3IEBA
IEZlYXR1cmVXb3JkSW5mbyBmZWF0dXJlX3dvcmRfaW5mb1tGRUFUVVJFX1dPUkRTXSA9IHsKICAg
ICAgW0ZFQVRfMjRfMV9FQ1hdID0gewogICAgICAgICAgLnR5cGUgPSBDUFVJRF9GRUFUVVJFX1dP
UkQsCiAgICAgICAgICAuZmVhdF9uYW1lcyA9IHsKLSAgICAgICAgICAgIFsyXSA9ICJhdngxMC12
bm5pLWludCIsCisgICAgICAgICAgICBbMl0gPSAiYXZ4MTAtdjEtYXV4IiwKICAgICAgICAgIH0s
CiAgICAgICAgICAuY3B1aWQgPSB7CiAgICAgICAgICAgICAgLmVheCA9IDB4MjQsCkBAIC0yMzg3
LDcgKzIzODcsNyBAQCBzdGF0aWMgY29uc3QgQVZYMTBWZXJzaW9uRGVmaW5pdGlvbiAKYnVpbHRp
bl9hdngxMF9kZWZzW10gPSB7CiAgICAgICAgICAudmVyc2lvbiA9IDIsCiAgICAgICAgICAubWF4
X3N1YmxlYWYgPSAxLAogICAgICAgICAgLmZlYXR1cmVzID0gKEZlYXR1cmVNYXNrW10pIHsKLSAg
ICAgICAgICAgIHsgRkVBVF8yNF8xX0VDWCwgICAgICAgICBDUFVJRF8yNF8xX0VDWF9BVlgxMF9W
Tk5JX0lOVCB9LAorICAgICAgICAgICAgeyBGRUFUXzI0XzFfRUNYLCAgICAgICAgIENQVUlEXzI0
XzFfRUNYX0FWWDEwX1YxX0FVWCB9LAogICAgICAgICAgICAgIHsgLyogZW5kIG9mIGxpc3QgKi8g
fQogICAgICAgICAgfQogICAgICB9LApAQCAtNTUzOCw3ICs1NTM4LDcgQEAgc3RhdGljIGNvbnN0
IFg4NkNQVURlZmluaXRpb24gYnVpbHRpbl94ODZfZGVmc1tdID0gewogICAgICAgICAgICogVGhv
dWdoIHRoaXMgYml0IHdpbGwgYmUgc2V0IGJ5IGF2eF92ZXJzaW9uPTIsIGl0J3MgYmV0dGVyIHRv
CiAgICAgICAgICAgKiBleHBsaWNpdGx5IGVudW1lcmF0ZSB0aGlzIGZlYXR1cmUgaGVyZS4KICAg
ICAgICAgICAqLwotICAgICAgICAuZmVhdHVyZXNbRkVBVF8yNF8xX0VDWF0gPSBDUFVJRF8yNF8x
X0VDWF9BVlgxMF9WTk5JX0lOVCwKKyAgICAgICAgLmZlYXR1cmVzW0ZFQVRfMjRfMV9FQ1hdID0g
Q1BVSURfMjRfMV9FQ1hfQVZYMTBfVjFfQVVYLAogICAgICAgICAgLmZlYXR1cmVzW0ZFQVRfODAw
MF8wMDAxX0VDWF0gPQogICAgICAgICAgICAgIENQVUlEX0VYVDNfTEFIRl9MTSB8IENQVUlEX0VY
VDNfQUJNIHwgCkNQVUlEX0VYVDNfM0ROT1dQUkVGRVRDSCwKICAgICAgICAgIC5mZWF0dXJlc1tG
RUFUXzgwMDBfMDAwMV9FRFhdID0KZGlmZiAtLWdpdCBhL3RhcmdldC9pMzg2L2NwdS5oIGIvdGFy
Z2V0L2kzODYvY3B1LmgKaW5kZXggOWYyMjJhMGM5Zi4uNmY3MjMwMDMxYiAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2kzODYvY3B1LmgKKysrIGIvdGFyZ2V0L2kzODYvY3B1LmgKQEAgLTExMjYsOCArMTEy
Niw4IEBAIHVpbnQ2NF90IHg4Nl9jcHVfZ2V0X3N1cHBvcnRlZF9mZWF0dXJlX3dvcmQoWDg2Q1BV
IAoqY3B1LCBGZWF0dXJlV29yZCB3KTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIENQVUlEXzI0XzBfRUJYX0FWWDEwXzI1NiB8IFwKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIENQVUlEXzI0XzBfRUJYX0FWWDEwXzUxMikKCi0vKiBB
VlgxMF9WTk5JX0lOVCBpbnN0cnVjdGlvbiAqLwotI2RlZmluZSBDUFVJRF8yNF8xX0VDWF9BVlgx
MF9WTk5JX0lOVCAgICAgICAgICgxVSA8PCAyKQorLyogQVZYMTBfVjFfQVVYIGluc3RydWN0aW9u
ICovCisjZGVmaW5lIENQVUlEXzI0XzFfRUNYX0FWWDEwX1YxX0FVWCAgICAgICAgICAgKDFVIDw8
IDIpCgogIC8qCiAgICogTmV3IENvbmRpdGlvbmFsIEluc3RydWN0aW9ucyAoTkNJcyksIGV4cGxp
Y2l0IE5ldyBEYXRhIERlc3RpbmF0aW9uIAooTkREKQotLSAKMi41MS4x

