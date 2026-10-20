Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4C5606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tencent.com header.i=@tencent.com header.a=rsa-sha256 header.s=s201512 header.b=dvjwU8ai
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ3aE-0000Ih-T9; Tue, 20 Oct 2026 02:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sundayjiang@tencent.com>)
 id 1xJ3aC-0000IW-Jc
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:44:24 -0400
Received: from smtpbgau1.qq.com ([54.206.16.166])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sundayjiang@tencent.com>)
 id 1xJ3a6-0000JW-47
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1792478642;
 bh=A2ROvVMDOcZDt3pLy21H1WPcqnfTVjuC68omje0RqeE=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=dvjwU8ai4KO81n92a6XNNziZEQC8CrnX/R8jyVdBiWYNxpF5xMZR0u3o0CSHGf5Zn
 0vbxf1E20MDytD8YG6EIW1c7Sa1Z7aD3n8HkHllY0HxT3i6iJ/aZXzofLLVazOpggm
 S+RyQ/ttsZHZiV7cw9Jgst7Pud4zbqDUUOS/qYMs=
EX-QQ-RecipientCnt: 2
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqRqrX+K4iacs1Y3qa9KkqPtkDVHFdjJw6k=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: GkkiqHkUZpaMxaxackTB3hKe45/Ghrb6qwMew55MCd0=
X-QQ-STYLE: 
X-QQ-mid: lv5gz3a-0t1792478642t28cb7234
From: "=?utf-8?B?c3VuZGF5amlhbmcoc3VuZGF5amlhbmcp?=" <sundayjiang@tencent.com>
To: "=?utf-8?B?VGhvbWFzIEh1dGg=?=" <thuth@redhat.com>
Cc: "=?utf-8?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>
Subject: =?utf-8?B?5Zue5aSN77yaW0ludGVybmV0XVJlOiBbUEFUQ0gg?=
 =?utf-8?B?MC8yXSB1c2ItaG9zdDogZml4IHVzZS1hZnRlci1m?=
 =?utf-8?B?cmVlIGlzc3Vlcw==?=
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_6AD70DB2_C1E17860_126FC91A"
Content-Transfer-Encoding: 8Bit
Date: Tue, 20 Oct 2026 14:44:02 +0800
X-Priority: 3
Message-ID: <tencent_50AF80054E3ECAC0405374DB@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 730909776
X-BIZMAIL-ID: 6542732366966527117
X-Address-Ticket: version=; type=; ticket_id=; id_list=; display_name=;
 session_id=; 
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Tue, 20 Oct 2026 14:44:02 +0800 (CST)
Feedback-ID: lv:tencent.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: Mi0NhBPPe/4RluO78npGsgUgOs4yn0cv+E5zfBq8R4xBxQ+xj0TBjif3
 b/00qJEmfN0MNpFsXd5Nya3lOYN/xgLxUfV9AAo9948uNRxhdmfifL5ioh61gvEGtA2ehOc
 gRqqJ+wUiNeez6buaKtsb6Ad0Ga7a3NbCfCdZwwfGqd32vP4tfu1QFHV3O4iBXRjJOQhPNw
 QuFDlUfhNq7+btTFm9GkciQEruQs28atKGS4hsOzj8Mfpc+32AyhEbgalOUfbdgAJ/fae6+
 WFnMuF8pLvU9SdhS9PK78qu/Th0EguLyI89a3kIIQvGbnaPZR+9wbOy3njUHv1QV9AT5Zde
 i9UZttpwh7OhZdw9R7OUcRS8n1nTslWH/BVEZ9WGe/Z3deJjrnk1xDeDOYwbhBmsa6L46/m
 WFySHv9r7RKcyaKahbKsiNQJwFC4bYOvBMo6r1eSNqKVicg1sUF9w741fAajWQfOYMsRNR+
 YxOQW3UEwAOFEfNpFeIWQRMvmcXLdpe45Pv1sL7jRlJuxP/8boHZJ3yaKQ8IXiyIN7at33h
 GoEfvM9hjn/xNvEvANntQcsEJIIVTsx9BV0wvvXW2eqqmkjoDFolgUP/nlXThJKgq+QCq0Y
 nKT+xaOXGJa/Ae/nE29xhgz1VzfyRNNqU+EaUSuxkWeBFvHn1NbjTn6T7lvaruP8u/u8p2o
 EXz9axgtCmTqmvD7hFuGBtcdzQyF/iSbvWTh7SljuFWANTmiU294WcnudGEkYBQb+z0umtS
 7Dgp7LaUArrjoX0E1HsrAGLcABRc/D4lU0ta2uCpsqWjycmMirM9gQtZjWOUm2OOFa98ouJ
 8ik36jWUren3lufwGMINLYoyCC47HOhF7tRSGfDJyJMAUSXSiG5oRO0Bgl6DIXnSgEDGxDN
 dV8Q8bWVJof89FQ2nxISuHghx343nPjTItGOQJ0d4uKfTqDLMWd9YmzdRNmcGvRl66j/714
 JDQD+Qu/akBCdwQOivpdwwLTM1Q7fh1cUgUijWoKZq1Z5u0rJdKMCPNThHroK7e8sJmT+Ey
 TnCZfTb14Z4vB5AAIwV2HtQAlM4PmhaP/5uGCJsPwMC7ub1rEJ8b2pzTGs09Q=
X-QQ-XMRINFO: OWPUhxQsoeAVgyF9u6tQ93Fs4BHSpkCILw==
X-QQ-RECHKSPAM: 0
Received-SPF: pass client-ip=54.206.16.166;
 envelope-from=sundayjiang@tencent.com; helo=smtpbgau1.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.001, HTML_MESSAGE=0.001, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.

------=_NextPart_6AD70DB2_C1E17860_126FC91A
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

SGkmbmJzcDtUaG9tYXMsJm5ic3A7Jm5ic3A7DQpUaGFuayZuYnNwO3lvdSZuYnNwO2ZvciZu
YnNwO2FwcGx5aW5nJm5ic3A7YW5kJm5ic3A7cXVldWluZyZuYnNwO3RoZSZuYnNwO3BhdGNo
ZXMuJm5ic3A7U29ycnkmbmJzcDtmb3ImbmJzcDt0aGUmbmJzcDtmb3JtYXR0aW5nJm5ic3A7
aXNzdWUuJm5ic3A7SeKAmWxsJm5ic3A7dXNlJm5ic3A7Z2l0Jm5ic3A7c2VuZC1lbWFpbCZu
YnNwO25leHQmbmJzcDt0aW1lLiZuYnNwOyZuYnNwOw0KQmVzdCZuYnNwO3JlZ2FyZHMsDQpI
YW90aWFuJm5ic3A7SmlhbmcNCg0KDQoNCg0KDQogICAgICAgICAgICAgICAgICAgIFRob21h
cyBIdXRoPHRodXRoQHJlZGhhdC5jb20mZ3Q7Jm5ic3A75ZyoIDIwMjblubQxMOaciDE25pel
IOWRqOS6lCAyMToxNCDlhpnpgZPvvJoNCg0KT24gMTYvMTAvMjAyNiAwOS4zNywgc3VuZGF5
amlhbmcoc3VuZGF5amlhbmcpIHdyb3RlOg0KJmd0OyBGaXggdHdvIGluZGVwZW5kZW50IHVz
ZS1hZnRlci1mcmVlIGlzc3VlcyBpbiB0aGUgbGlidXNiIHVzYi1ob3N0DQomZ3Q7IGJhY2tl
bmQuDQomZ3Q7IA0KJmd0OyBUaGUgZmlyc3QgcGF0Y2ggZnJlZXMgVVNCSG9zdFJlcXVlc3Qg
b2JqZWN0cyB3aGVuDQomZ3Q7IGxpYnVzYl9zdWJtaXRfdHJhbnNmZXIoKSBmYWlscywgcHJl
dmVudGluZyBzdGFsZSBVU0JQYWNrZXQgcG9pbnRlcnMNCiZndDsgZnJvbSByZW1haW5pbmcg
b24gdGhlIHJlcXVlc3QgcXVldWUuDQomZ3Q7IA0KJmd0OyBUaGUgc2Vjb25kIHBhdGNoIGRl
bGV0ZXMgdGhlIGxhemlseSBhbGxvY2F0ZWQgYm90dG9tIGhhbHZlcyBkdXJpbmcNCiZndDsg
ZGV2aWNlIHVucmVhbGl6ZSwgcHJldmVudGluZyBjYWxsYmFja3MgZnJvbSBhY2Nlc3Npbmcg
YSBmcmVlZA0KJmd0OyBVU0JIb3N0RGV2aWNlLg0KJmd0OyANCiZndDsgVG9tbWFzbyBDYWxp
ZmFubyB0ZXN0ZWQgdGhlIG9yaWdpbmFsIGNvbWJpbmVkIHBhdGNoIGFuZCByZXBvcnRlZCB0
aGF0DQomZ3Q7IGl0IGxvb2tzIGNvcnJlY3QuICZuYnNwO1RoaXMgc2VyaWVzIHNwbGl0cyB0
aGUgdHdvIGZpeGVzIHNvIHRoYXQgZWFjaCBjaGFuZ2UNCiZndDsgaGFzIGl0cyBvd24gbG9n
aWNhbCBzY29wZSBhbmQgRml4ZXMgdGFnLg0KJmd0OyANCiZndDsgSGFvdGlhbiBKaWFuZyAo
Mik6DQomZ3Q7Jm5ic3A7ICZuYnNwOyB1c2ItaG9zdDogZnJlZSByZXF1ZXN0IG9uIGxpYnVz
YiBzdWJtaXQgZmFpbHVyZQ0KJmd0OyZuYnNwOyAmbmJzcDsgdXNiLWhvc3Q6IGRlbGV0ZSBi
b3R0b20gaGFsdmVzIGR1cmluZyB1bnJlYWxpemUNCiZndDsgDQomZ3Q7Jm5ic3A7ICZuYnNw
O2h3L3VzYi9ob3N0LWxpYnVzYi5jIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCiZndDsmbmJzcDsgJm5ic3A7MSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKykN
ClRoYW5rcyBmb3IgdGhlIGZpeGVzLiBJJ2xsIHF1ZXVlIHRoZXNlIGZvciBteSBuZXh0IHB1
bGwgcmVxdWVzdC4NCg0KQnV0IGlmIHlvdSBjb3VsZCBkbyBtZSBhIGZhdm9yOiBUaGUgbmV4
dCB0aW1lIHlvdSBzZW5kIHBhdGNoZXMsIHBsZWFzZSBkb24ndCANCnNlbmQgdGhlbSBhcyBt
aW1lLWVuY29kZWQgZS1tYWlscy4gSSBoYWQgdG8gYXBwbHkgdGhlc2UgcGF0Y2hlcyBtYW51
YWxseSANCnNpbmNlICJnaXQgYW0iIHJlZnVzZWQgdG8gcGFyc2UgeW91ciBtYWlsLiBJLmUu
IHRyeSB0byB1c2UgImdpdCBzZW5kLWVtYWlsIiANCnRoZSBuZXh0IHRpbWUsIHRoaXMgd2ls
bCBtYWtlIHN1cmUgdGhhdCB5b3VyIHBhdGNoZXMgY2FuIGJlIHByb2Nlc3NlZCBtb3JlIA0K
ZWFzaWx5LiBUaGFua3MhDQoNCiZuYnNwOyBUaG9tYXM=

------=_NextPart_6AD70DB2_C1E17860_126FC91A
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1zaXplOiAxNC42NjY3cHg7IGZvbnQtZmFtaWx5OiAtYXBwbGUt
c3lzdGVtLCBCbGlua01hY1N5c3RlbUZvbnQsICZxdW90O1BpbmdGYW5nIFNDJnF1b3Q7LCAm
cXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Ij48ZGl2PkhpJm5ic3A7VGhvbWFzLCZuYnNw
OyZuYnNwOzxicj5UaGFuayZuYnNwO3lvdSZuYnNwO2ZvciZuYnNwO2FwcGx5aW5nJm5ic3A7
YW5kJm5ic3A7cXVldWluZyZuYnNwO3RoZSZuYnNwO3BhdGNoZXMuJm5ic3A7U29ycnkmbmJz
cDtmb3ImbmJzcDt0aGUmbmJzcDtmb3JtYXR0aW5nJm5ic3A7aXNzdWUuJm5ic3A7SeKAmWxs
Jm5ic3A7dXNlJm5ic3A7Z2l0Jm5ic3A7c2VuZC1lbWFpbCZuYnNwO25leHQmbmJzcDt0aW1l
LiZuYnNwOyZuYnNwOzxicj5CZXN0Jm5ic3A7cmVnYXJkcyw8YnI+SGFvdGlhbiZuYnNwO0pp
YW5nPC9kaXY+PGJyPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZTogMTQuNjY2N3B4OyBm
b250LWZhbWlseTogLWFwcGxlLXN5c3RlbSwgQmxpbmtNYWNTeXN0ZW1Gb250LCAmcXVvdDtQ
aW5nRmFuZyBTQyZxdW90OywgJnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7OyI+PGJyPjwv
ZGl2PjxkaXY+PC9kaXY+PGRpdiBjbGFzcz0ibWFpbHBsdWdpbl9xdW90ZSBtYWlscGxpdWdp
bl9xdW90ZV9zcGxpdCIgc3R5bGU9Im1hcmdpbjogMDsiPgogICAgICAgICAgICAKICAgICAg
PGRpdiBjbGFzcz0ibWFpbHBsdWdpbl9xdW90ZV9oZWFkZXIiIHN0eWxlPSJmb250LXNpemU6
IDE0cHg7Y29sb3I6IHJnYmEoMTEsIDE4LCAyNiwgMC42KTsiPjxzcGFuPlRob21hcyBIdXRo
PC9zcGFuPjxzcGFuPiZsdDt0aHV0aEByZWRoYXQuY29tJmd0Ozwvc3Bhbj4mbmJzcDvlnKg8
c3Bhbj4gMjAyNuW5tDEw5pyIMTbml6Ug5ZGo5LqUIDIxOjE0IDwvc3Bhbj7lhpnpgZPvvJo8
L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46IDA7cGFkZGluZzogMHB4IDBweCAwcHggMTBweDti
b3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYmEoNywgMTUsIDI2LCAwLjE1KTttYXJnaW4tdG9w
OiAxNnB4OyI+PGRpdj48L2Rpdj48ZGl2IGNsYXNzPSJxbWJveCI+T24gMTYvMTAvMjAyNiAw
OS4zNywgc3VuZGF5amlhbmcoc3VuZGF5amlhbmcpIHdyb3RlOjxicj4mZ3Q7IEZpeCB0d28g
aW5kZXBlbmRlbnQgdXNlLWFmdGVyLWZyZWUgaXNzdWVzIGluIHRoZSBsaWJ1c2IgdXNiLWhv
c3Q8YnI+Jmd0OyBiYWNrZW5kLjxicj4mZ3Q7IDxicj4mZ3Q7IFRoZSBmaXJzdCBwYXRjaCBm
cmVlcyBVU0JIb3N0UmVxdWVzdCBvYmplY3RzIHdoZW48YnI+Jmd0OyBsaWJ1c2Jfc3VibWl0
X3RyYW5zZmVyKCkgZmFpbHMsIHByZXZlbnRpbmcgc3RhbGUgVVNCUGFja2V0IHBvaW50ZXJz
PGJyPiZndDsgZnJvbSByZW1haW5pbmcgb24gdGhlIHJlcXVlc3QgcXVldWUuPGJyPiZndDsg
PGJyPiZndDsgVGhlIHNlY29uZCBwYXRjaCBkZWxldGVzIHRoZSBsYXppbHkgYWxsb2NhdGVk
IGJvdHRvbSBoYWx2ZXMgZHVyaW5nPGJyPiZndDsgZGV2aWNlIHVucmVhbGl6ZSwgcHJldmVu
dGluZyBjYWxsYmFja3MgZnJvbSBhY2Nlc3NpbmcgYSBmcmVlZDxicj4mZ3Q7IFVTQkhvc3RE
ZXZpY2UuPGJyPiZndDsgPGJyPiZndDsgVG9tbWFzbyBDYWxpZmFubyB0ZXN0ZWQgdGhlIG9y
aWdpbmFsIGNvbWJpbmVkIHBhdGNoIGFuZCByZXBvcnRlZCB0aGF0PGJyPiZndDsgaXQgbG9v
a3MgY29ycmVjdC4gJm5ic3A7VGhpcyBzZXJpZXMgc3BsaXRzIHRoZSB0d28gZml4ZXMgc28g
dGhhdCBlYWNoIGNoYW5nZTxicj4mZ3Q7IGhhcyBpdHMgb3duIGxvZ2ljYWwgc2NvcGUgYW5k
IEZpeGVzIHRhZy48YnI+Jmd0OyA8YnI+Jmd0OyBIYW90aWFuIEppYW5nICgyKTo8YnI+Jmd0
OyZuYnNwOyAmbmJzcDsgdXNiLWhvc3Q6IGZyZWUgcmVxdWVzdCBvbiBsaWJ1c2Igc3VibWl0
IGZhaWx1cmU8YnI+Jmd0OyZuYnNwOyAmbmJzcDsgdXNiLWhvc3Q6IGRlbGV0ZSBib3R0b20g
aGFsdmVzIGR1cmluZyB1bnJlYWxpemU8YnI+Jmd0OyA8YnI+Jmd0OyZuYnNwOyAmbmJzcDto
dy91c2IvaG9zdC1saWJ1c2IuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
PGJyPiZndDsmbmJzcDsgJm5ic3A7MSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyk8
YnI+VGhhbmtzIGZvciB0aGUgZml4ZXMuIEknbGwgcXVldWUgdGhlc2UgZm9yIG15IG5leHQg
cHVsbCByZXF1ZXN0Ljxicj48YnI+QnV0IGlmIHlvdSBjb3VsZCBkbyBtZSBhIGZhdm9yOiBU
aGUgbmV4dCB0aW1lIHlvdSBzZW5kIHBhdGNoZXMsIHBsZWFzZSBkb24ndCA8YnI+c2VuZCB0
aGVtIGFzIG1pbWUtZW5jb2RlZCBlLW1haWxzLiBJIGhhZCB0byBhcHBseSB0aGVzZSBwYXRj
aGVzIG1hbnVhbGx5IDxicj5zaW5jZSAiZ2l0IGFtIiByZWZ1c2VkIHRvIHBhcnNlIHlvdXIg
bWFpbC4gSS5lLiB0cnkgdG8gdXNlICJnaXQgc2VuZC1lbWFpbCIgPGJyPnRoZSBuZXh0IHRp
bWUsIHRoaXMgd2lsbCBtYWtlIHN1cmUgdGhhdCB5b3VyIHBhdGNoZXMgY2FuIGJlIHByb2Nl
c3NlZCBtb3JlIDxicj5lYXNpbHkuIFRoYW5rcyE8YnI+PGJyPiZuYnNwOyBUaG9tYXM8YnI+
PGJyPjwvZGl2PjwvZGl2PjwvZGl2Pg==

------=_NextPart_6AD70DB2_C1E17860_126FC91A--


