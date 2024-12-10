Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11CDE77182
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 14:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL1CV-0005hi-0B; Tue, 10 Dec 2024 09:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <startergo@protonmail.com>)
 id 1tKwEa-0000oz-NY
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 04:08:48 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <startergo@protonmail.com>)
 id 1tKwEW-0005wx-3n
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 04:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1733821712; x=1734080912;
 bh=4MKgMQotj99akdwjVtTZPnAB5DY8hngcOzMbiAEp+f8=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=c/ZFa1U46YO2Stlxn9aPtSy+hH9H2YGxQzcssnEOqcU1FNeOPBJFbnGmaDf+jSXJg
 lqGppN3Jhf17W07GVkGttR8Tekoq69UOVLzLErin/mdSmEHmgutBFRSvpwT7++oFDE
 JQVWcJa8QsPBr9JBokfzpVZhxpkAy49HnR7SLLt8oC0MOGnPz9B1UDT4BMkChJJ+mJ
 DO3jUTBv9qG3T/zDglCaNmREpHilFUipwt++hYyzhJj8ldYXv0DoYfnFq6nREF//No
 aw+cyT1ayjppGWxLeLQ+Cl8rHtL1actQ9pVZeCLaMSJguwYqWnh/Bie3GWOiyYpo6H
 lm9HAmiLqUI3A==
Date: Tue, 10 Dec 2024 09:08:27 +0000
To: "hshan@google.com" <hshan@google.com>
Cc: "berrange@redhat.com" <berrange@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/6] Adding the Android Emulator hypervisor driver
 accelerator
Message-ID: <oS9fkAKjJs2F8XwMcRxBM85xp949aFeUtYSSokpL_r-s9eoqV6iDG44EXx1U8--iDiWaTRtHi5sG4G9Pe64Z0Yx4SkRTZhS2zwQSXdg3Flw=@protonmail.com>
Feedback-ID: 25315608:user:proton
X-Pm-Message-ID: 65a156622129b8b252f04761ea307e85f72a85fc
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="b1=_5EGb6Shh7hYZ1Wzy8LEbsgzYp6rOzwsj9Hvq5Ywx4ac"
Received-SPF: pass client-ip=185.70.40.135;
 envelope-from=startergo@protonmail.com; helo=mail-40135.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 10 Dec 2024 09:26:56 -0500
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
Reply-to:  startergo <startergo@protonmail.com>
From:  startergo via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--b1=_5EGb6Shh7hYZ1Wzy8LEbsgzYp6rOzwsj9Hvq5Ywx4ac
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SSBoYXZlIHRyaWVkIHRoZSBxZW11X3N0YWdpbmdfdmlyZ2xfYWVoZCB2ZXJzaW9uIG9uIFdpbjEx
IHdpdGggbWFjT1MgZ3Vlc3QsCkl0IGxvb2tzIGxpa2UgdGhlIEFWWDIgY3B1IGZlYXR1cmUgaXMg
bm90IHBhc3NlZCBjb3JyZWN0bHkgYXMgaXQgY2F1c2VzIEtQLiBTZWUgaGVyZSBmb3IgbW9yZSBk
ZXRhaWxzOgoKW01hdGV1c3pLcmF3Y3p1ay9xZW11IGF0IG1hc3Rlcl93aXBfYWVoZF0oaHR0cHM6
Ly9naXRodWIuY29tL01hdGV1c3pLcmF3Y3p1ay9xZW11L2lzc3Vlcy8yKQ==

--b1=_5EGb6Shh7hYZ1Wzy8LEbsgzYp6rOzwsj9Hvq5Ywx4ac
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0
cHg7Ij5JIGhhdmUgdHJpZWQgdGhlJm5ic3A7PHNwYW4+cWVtdV9zdGFnaW5nX3ZpcmdsX2FlaGQg
dmVyc2lvbiBvbiBXaW4xMSB3aXRoIG1hY09TIGd1ZXN0LDwvc3Bhbj48L2Rpdj48ZGl2IHN0eWxl
PSJmb250LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsiPjxzcGFu
Pkl0IGxvb2tzIGxpa2UgdGhlIEFWWDIgY3B1IGZlYXR1cmUgaXMgbm90IHBhc3NlZCBjb3JyZWN0
bHkgYXMgaXQgY2F1c2VzIEtQLiBTZWUgaGVyZSBmb3IgbW9yZSBkZXRhaWxzOjwvc3Bhbj48L2Rp
dj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTog
MTRweDsiPjxzcGFuPjxicj48L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFy
aWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0cHg7Ij48YnI+PC9kaXY+DQo8ZGl2IGNsYXNz
PSJwcm90b25tYWlsX3NpZ25hdHVyZV9ibG9jayIgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwg
c2Fucy1zZXJpZjsgZm9udC1zaXplOiAxNHB4OyI+DQogICAgPGRpdiBjbGFzcz0icHJvdG9ubWFp
bF9zaWduYXR1cmVfYmxvY2stdXNlciBwcm90b25tYWlsX3NpZ25hdHVyZV9ibG9jay1lbXB0eSI+
DQogICAgICAgIA0KICAgICAgICAgICAgPC9kaXY+DQogICAgDQogICAgICAgICAgICA8ZGl2IGNs
YXNzPSJwcm90b25tYWlsX3NpZ25hdHVyZV9ibG9jay1wcm90b24iPjxhIGhyZWY9Imh0dHBzOi8v
Z2l0aHViLmNvbS9NYXRldXN6S3Jhd2N6dWsvcWVtdS9pc3N1ZXMvMiI+TWF0ZXVzektyYXdjenVr
L3FlbXUgYXQgbWFzdGVyX3dpcF9hZWhkPC9hPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJwcm90b25t
YWlsX3NpZ25hdHVyZV9ibG9jay1wcm90b24iPjxicj48L2Rpdj4NCjwvZGl2Pg0K


--b1=_5EGb6Shh7hYZ1Wzy8LEbsgzYp6rOzwsj9Hvq5Ywx4ac--


