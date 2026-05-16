Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8C1CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 14:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOGFK-0002t8-6z; Sat, 16 May 2026 10:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenglin@cqut.edu.cn>)
 id 1wOG13-0007Wx-N4; Sat, 16 May 2026 10:29:21 -0400
Received: from smtpbgbr1.qq.com ([54.207.19.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenglin@cqut.edu.cn>)
 id 1wOG0z-0002uQ-OU; Sat, 16 May 2026 10:29:21 -0400
EX-QQ-RecipientCnt: 2
X-QQ-GoodBg: 2
X-BAN-DOWNLOAD: 1
X-BAN-SHARE: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqSwD4GVK8+FENQpBvfeQOhITkbh209HYvU=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: BTc+qK9TmvpUN+Yqt6sAm/ZZDHcm73icUkhONYaeoyM=
X-Originating-IP: 183.228.32.101
X-QQ-STYLE: 
X-QQ-mid: lv3gz6b-6t1778941737td0b9c8a7
From: "=?utf-8?B?56iL5p6X?=" <chenglin@cqut.edu.cn>
To: "=?utf-8?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>
Cc: "=?utf-8?B?cWVtdS1yaXNjdg==?=" <qemu-riscv@nongnu.org>
Subject: RISC-V: TB exit failure after csrw satp when Sstc is enabled
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_6A087F29_47837D20_0898C1B0"
Content-Transfer-Encoding: 8Bit
Date: Sat, 16 May 2026 22:28:57 +0800
X-Priority: 3
Message-ID: <tencent_4C91E5E069059D335A45BAC7@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 7565087906875266195
X-Address-Ticket: version=; type=; ticket_id=; id_list=; display_name=;
 session_id=; 
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Sat, 16 May 2026 22:28:58 +0800 (CST)
Feedback-ID: lv:cqut.edu.cn:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MwqrwaLzgdebv2xr+LgCn78I+yZVS3u4knC+rnBZ/vFuO7tQqMC6SmR7
 5MxUxUtQJ6yo/+PGGzc5wnBZs4yHVOqablxwxb0/UQNFKDMiB5RsGAIXbd7SWwfJbgP1PEU
 ewsO8secoIkZb4I7JCiqXE0/N0EaroNDCvyfGZB3/zQje3NBcHwXtZM/0MROIaIwdAm8D5+
 cCzApvnIY8jbi+ZdrHkXaFcbq+JQLDcTHBj2nvSlC0QwWFrDreyRHD5XlSaMTbxgjHYrg3K
 9OL4Jd0TwI7rhlb+pEhM0HhwHxvTjsYSgcBFRw3cDY3sovXsNUL3r3Ybe1DKP9WA+jz1fMR
 ScYITJOor4rV1hoi3DHvCiEbJqU42hA7utMaZm8dyuhChxPIoDFF+A3JCziZmdr1YD9Tvu/
 v4lN7BJYlgcif3BCad95LkMlrS5G8XxCQlYUeGhq1EIAxZFyl2g1lxqlaK6LA3bzqQhrE1D
 0vINDeENcBozfxE0U2Zf376A6sf8Y5GXMWBWANe4inRhJq9AGxayW/YiQpizu5HxzUrZFbJ
 PcT9v8hCU/aQaAyduBl6GX0g5GkYCSv8Y28TuB1i4gA6H0BdcGhjmztXbdtwaq1RfIA9B8P
 C4v9NUXso1aDvu1VKlCtOwUSXOoZ+YWNG8t/nmtxGFELcoHx2pv1sGe4Q1hqH8YKTyDcYpo
 OShPanMEgVdufQqu4ghCeiqynjq/qj/840Pydf6EbgfAfiNiJ3XIQ5vLf+YDCrKgNMSaVo1
 SV32e2Bz32ozcDpabZjGPPFbfFVa8qvKjBPJroefOBZXDon/vhiHOtmjVf5EnGGgOm//4iF
 +DZB31UXPB7+Cuz/BXye0nZ7BvIQgF9TPgvFRUAGNAwhFHFB5wRR8PxdJIclvVD7nEn284u
 2A2OWDDBjbUj/fcTxedcqUUKwOpTrCY4l3M7aJ9CC2i4u6/d67RIY7uOb+Lo7n6xcncVCrC
 FzkLU8Yel4lO37wAF3GzgXvnUCmOkscaoFQLCBD9nU8mAi1fXa8qxan3Q1ygiluxuNJUVLt
 ArlkwCozYLMnpW0tKWLiceK5lVZHfrJhcE1BBn4yY+Hu1t2B1w
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
Received-SPF: pass client-ip=54.207.19.206; envelope-from=chenglin@cqut.edu.cn;
 helo=smtpbgbr1.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 16 May 2026 10:44:02 -0400
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

This is a multi-part message in MIME format.

------=_NextPart_6A087F29_47837D20_0898C1B0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

RGVhciBRRU1VIGRldmVsb3BlcnMsDQoNCkkgYmVsaWV2ZSBJIGhhdmUgZm91bmQgYSBidWcg
aW4gUUVNVSAxMC4wLjggZm9yIHRoZSBSSVNDLVYgdmlydCBtYWNoaW5lLiBXaGVuIHRoZSBT
c3RjIGV4dGVuc2lvbiBpcyBlbmFibGVkLCBhIHN1YnNlcXVlbnQgd3JpdGUgdG8gdGhlIHNh
dHAgQ1NSIGRvZXMgbm90IGNvcnJlY3RseSBlbmQgdGhlIFRyYW5zbGF0aW9uIEJsb2NrLCBj
YXVzaW5nIHRoZSBlbXVsYXRvciB0byBmYWlsIHdoZW4gdHJ5aW5nIHRvIGZldGNoIHRoZSBu
ZXh0IGluc3RydWN0aW9uLiZuYnNwO1RoZSBmb2xsb3dpbmcgbWluaW1hbCZuYnNwOyBiYXJl
LW1ldGFsIGNvZGUgc2VxdWVuY2UgY2F1c2VzIHRoZSBpc3N1ZToNCiZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAjIEVuYWJsZSBTc3RjIGZvciBTLW1vZGUNCiZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyBsaSB0MCwgMUwgPDwgNjMNCiZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyBjc3J3IG1lbnZjZmcsIHQwDQombmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgbGkg
dDAsIDINCiZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBjc3J3IG1jb3VudGVyZW4sIHQw
DQoNCg0KJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICMgc3dpdGNoIHRvIFMtbW9kZQ0K
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICMgU2V0dXAgYW4gaWRlbnRpdHkgcGFnZSB0
YWJsZSAocHQxIGFzc3VtZWQgdmFsaWQpDQombmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsm
bmJzcDsNCg0KJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICMgU3dpdGNoIHRvIHRoZSBu
ZXcgcGFnZSB0YWJsZQ0KJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IHNmZW5jZS52bWEg
emVybywgemVybw0KJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IGNzcncgc2F0cCwgYTAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsjIGEwIGhvbGRzIHRoZSBuZXcgc2F0cCB2YWx1
ZSZuYnNwOw0KJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IHNmZW5jZS52bWEgemVybywg
emVybyZuYnNwOyAjIDwtLS0gUUVNVSBmYWlscyB0byBmaW5kIHRoaXMgaW5zdHJ1Y3Rpb24N
Cg0KDQoNCk9ic2VydmVkIEJlaGF2aW9yOg0KDQoNClRoZSBzYW1lIGNvZGUgd29ya3MgcGVy
ZmVjdGx5IGlmIHRoZSBTc3RjIGVuYWJsZSBzZXF1ZW5jZSAodGhlIGZpcnN0IDQgaW5zdHJ1
Y3Rpb25zKSBpcyByZW1vdmVkLg0KDQoNClRoZSBzYW1lIGNvZGUgZG9lcyBub3Qgd29yayBp
ZiB0aGUgU3N0YyBlbmFibGUgc2VxdWVuY2UgKHRoZSBmaXJzdCA0IGluc3RydWN0aW9ucykg
aXMga2VwdC4gSXQgaGFuZ3MgYW5kIGdkYiBzYXlzIGl0IGNvdWxkIG5vdCBmaW5kIHRoZSBp
bnN0cnVjdGlvbiAic2ZlbnZlLnZtYSIgYWZ0ZXIgImNzcncgc2F0cCwgYTAiLg0KDQpUaGFu
ayB5b3UgZm9yIHlvdXIgdGltZSBhbmQgZm9yIG1haW50YWluaW5nIHRoaXMgZXhjZWxsZW50
IGVtdWxhdG9yLg==

------=_NextPart_6A087F29_47837D20_0898C1B0
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PHAgY2xhc3M9ImRzLW1hcmtkb3duLXBhcmFncmFwaCI+PHNwYW4gY2xhc3M9IiI+RGVhciBR
RU1VIGRldmVsb3BlcnMsPC9zcGFuPjwvcD48cCBjbGFzcz0iZHMtbWFya2Rvd24tcGFyYWdy
YXBoIj48c3BhbiBjbGFzcz0iIj5JIGJlbGlldmUgSSBoYXZlIGZvdW5kIGEgYnVnIGluIFFF
TVUgMTAuMC44IGZvciB0aGUgUklTQy1WIDwvc3Bhbj48Y29kZT52aXJ0PC9jb2RlPjxzcGFu
IGNsYXNzPSIiPiBtYWNoaW5lLiBXaGVuIHRoZSBTc3RjIGV4dGVuc2lvbiBpcyBlbmFibGVk
LCBhIHN1YnNlcXVlbnQgd3JpdGUgdG8gdGhlIDwvc3Bhbj48Y29kZT5zYXRwPC9jb2RlPjxz
cGFuIGNsYXNzPSIiPiBDU1IgZG9lcyBub3QgY29ycmVjdGx5IGVuZCB0aGUgVHJhbnNsYXRp
b24gQmxvY2ssIGNhdXNpbmcgdGhlIGVtdWxhdG9yIHRvIGZhaWwgd2hlbiB0cnlpbmcgdG8g
ZmV0Y2ggdGhlIG5leHQgaW5zdHJ1Y3Rpb24uPHNwYW4gc3R5bGU9ImZvbnQtd2VpZ2h0OiBi
b2xkOyI+Jm5ic3A7PC9zcGFuPlRoZSBmb2xsb3dpbmcgbWluaW1hbCZuYnNwOyBiYXJlLW1l
dGFsIGNvZGUgc2VxdWVuY2UgY2F1c2VzIHRoZSBpc3N1ZTo8L3NwYW4+PC9wPiZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAjIEVuYWJsZSBTc3RjIGZvciBTLW1vZGU8YnI+Jm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7IGxpIHQwLCAxTCAmbHQ7Jmx0OyA2Mzxicj4mbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgY3NydyBtZW52Y2ZnLCB0MDxicj4mbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgbGkgdDAsIDI8YnI+Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
IGNzcncgbWNvdW50ZXJlbiwgdDA8YnI+PGRpdj48YnI+PC9kaXY+PGRpdj4mbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgIyBzd2l0Y2ggdG8gUy1tb2RlPC9kaXY+Jm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICMgU2V0dXAgYW4gaWRlbnRpdHkgcGFnZSB0YWJsZSAocHQxIGFz
c3VtZWQgdmFsaWQpPGJyPiZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyZuYnNwOzxicj48
YnI+Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICMgU3dpdGNoIHRvIHRoZSBuZXcgcGFn
ZSB0YWJsZTxicj4mbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgc2ZlbmNlLnZtYSB6ZXJv
LCB6ZXJvPGJyPiZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBjc3J3IHNhdHAsIGEwJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IyBhMCBob2xkcyB0aGUgbmV3IHNhdHAgdmFsdWUm
bmJzcDs8YnI+PGRpdj4mbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgc2ZlbmNlLnZtYSB6
ZXJvLCB6ZXJvJm5ic3A7ICMgJmx0Oy0tLSBRRU1VIGZhaWxzIHRvIGZpbmQgdGhpcyBpbnN0
cnVjdGlvbjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHAgY2xhc3M9ImRzLW1hcmtkb3du
LXBhcmFncmFwaCI+PHN0cm9uZz48c3BhbiBjbGFzcz0iIj5PYnNlcnZlZCBCZWhhdmlvcjo8
L3NwYW4+PC9zdHJvbmc+PC9wPjx1bD48bGk+PHAgY2xhc3M9ImRzLW1hcmtkb3duLXBhcmFn
cmFwaCI+PHNwYW4gY2xhc3M9IiI+VGhlIHNhbWUgY29kZSB3b3JrcyBwZXJmZWN0bHkgaWYg
dGhlIFNzdGMgZW5hYmxlIHNlcXVlbmNlICh0aGUgZmlyc3QgNCBpbnN0cnVjdGlvbnM8L3Nw
YW4+PHNwYW4gY2xhc3M9IiI+KSBpcyByZW1vdmVkLjwvc3Bhbj48L3A+PC9saT48bGk+PHNw
YW4gY2xhc3M9IiI+VGhlIHNhbWUgY29kZSBkb2VzIG5vdCB3b3JrIGlmIHRoZSBTc3RjIGVu
YWJsZSBzZXF1ZW5jZSAodGhlIGZpcnN0IDQgaW5zdHJ1Y3Rpb25zKSBpcyBrZXB0LiBJdCBo
YW5ncyBhbmQgZ2RiIHNheXMgaXQgY291bGQgbm90IGZpbmQgdGhlIGluc3RydWN0aW9uICJz
ZmVudmUudm1hIiBhZnRlciAiY3NydyBzYXRwLCBhMCIuPC9zcGFuPjwvbGk+PC91bD48cCBj
bGFzcz0iZHMtbWFya2Rvd24tcGFyYWdyYXBoIj48c3BhbiBjbGFzcz0iIj5UaGFuayB5b3Ug
Zm9yIHlvdXIgdGltZSBhbmQgZm9yIG1haW50YWluaW5nIHRoaXMgZXhjZWxsZW50IGVtdWxh
dG9yLjwvc3Bhbj48L3A+PGJyPjwvZGl2PjxkaXY+PGluY2x1ZGV0YWlsPjwhLS08IVtlbmRp
Zl0tLT48L2luY2x1ZGV0YWlsPjwvZGl2Pg==

------=_NextPart_6A087F29_47837D20_0898C1B0--


