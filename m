Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF933C3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 10:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF9FD-0006Vi-Iw; Wed, 14 May 2025 06:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@littlemu.space>) id 1uF9FB-0006VV-IK
 for qemu-devel@nongnu.org; Wed, 14 May 2025 06:21:45 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@littlemu.space>) id 1uF9F8-00039E-12
 for qemu-devel@nongnu.org; Wed, 14 May 2025 06:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=littlemu.space;
 s=protonmail; t=1747218087; x=1747477287;
 bh=6BvNUVnQqOlWruyMo5RDXe+JZ1U2BRaIEzQo2bg01bU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=SZgem2vouHf5iOXfsulGYGXoN7090wIrgRTRMM8WoYXlZJnx0+64hze7ljPqOkeO3
 rN2ljxrRNbmEU8NzEYdZVIzdhdzlSYHN9yetw0KLEcG+w6YEQsZORYJyESjKRYVjc/
 mmgmxObqFjL4VzOETEYrXV1n5fslB/3cXXOq6Vwbn6Nf/A484QI2oN2oXcBkquAZqi
 UHq3h3cSwpYbHzxvtYa5FJHiPqlNfrjufjoAgKpCQRSniPOkunP5euTuFzE1b9G9xj
 RbhmoeuDC+nhv7ZdIIzea6N95C+VdcdVgo6VBQJe7w9FLXx6ElTyhboR94sWtu6dQs
 xpbuoKsf7Wtfg==
Date: Wed, 14 May 2025 10:21:21 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Little Mu <me@littlemu.space>
Cc: "kbastian@mail.upb.de" <kbastian@mail.upb.de>
Subject: Wiki account creation request
Message-ID: <7QToVN8NmNf6U7XhvLQTM6Bt2CQMQ_IjZLfiafc_9zTfRg9RBKaTnCm9YbMLy3WvcpYGGVLJjUJP4M3WBrlZPkYZpINGfr0ltB748sZXqCU=@littlemu.space>
Feedback-ID: 133108461:user:proton
X-Pm-Message-ID: 45456f9515a0938f2e46b92dc30344d0199b5f21
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="b1=_qEeTifDAe6F5Zlfpiw0ktGQwb5ezVrNQLpWdcw0W7A"
Received-SPF: pass client-ip=51.77.79.158; envelope-from=me@littlemu.space;
 helo=mail-0201.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--b1=_qEeTifDAe6F5Zlfpiw0ktGQwb5ezVrNQLpWdcw0W7A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SGVsbG8KCkkndmUgYmVlbiB3b3JraW5nIG9uIHRoZSBUcmlDb3JlIGFyY2hpdGVjdHVyZSBzdXBw
b3J0IG9uIFFFTVUgYW5kIHdpc2ggdG8gcmVxdWVzdCBhIHdpa2kgYWNjb3VudCB0byB1cGRhdGUg
dGhlIFRyaUNvcmUgcGFnZSBhcyBpdCBoYXMgYmVjb21lIHF1aXRlIG91dC1vZi1kYXRlLCBldmVu
IGNvbXBhcmVkIHRvIHRoZSBjdXJyZW50IHN0YXRlIG9mIFFFTVUuIEknbSBhbHNvIGluIGNvbW11
bmljYXRpb24gd2l0aCB0aGUgbWFpbnRhaW5lciBvZiB0aGUgVHJpQ29yZSBhcmNoaXRlY3R1cmUg
b24gUUVNVSB0byBpbnRlZ3JhdGUgdXBkYXRlcyB0byB0aGUgYXJjaGl0ZWN0dXJlJ3MgY29kZWJh
c2UuCgpCZXN0IHJlZ2FyZHM=

--b1=_qEeTifDAe6F5Zlfpiw0ktGQwb5ezVrNQLpWdcw0W7A
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0
cHg7Ij48YnI+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlm
OyBmb250LXNpemU6IDE0cHg7IGNvbG9yOiByZ2IoMCwgMCwgMCk7IGJhY2tncm91bmQtY29sb3I6
IHJnYigyNTUsIDI1NSwgMjU1KTsiPkhlbGxvPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6
IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0cHg7IGNvbG9yOiByZ2IoMCwgMCwgMCk7
IGJhY2tncm91bmQtY29sb3I6IHJnYigyNTUsIDI1NSwgMjU1KTsiPjxicj48L2Rpdj48ZGl2IHN0
eWxlPSJmb250LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsgY29s
b3I6IHJnYigwLCAwLCAwKTsgYmFja2dyb3VuZC1jb2xvcjogcmdiKDI1NSwgMjU1LCAyNTUpOyI+
SSd2ZSBiZWVuIHdvcmtpbmcgb24gdGhlIFRyaUNvcmUgYXJjaGl0ZWN0dXJlIHN1cHBvcnQgb24g
UUVNVSBhbmQgd2lzaCB0byByZXF1ZXN0IGEgd2lraSBhY2NvdW50IHRvIHVwZGF0ZSB0aGUgVHJp
Q29yZSBwYWdlIGFzIGl0IGhhcyBiZWNvbWUgcXVpdGUgb3V0LW9mLWRhdGUsIGV2ZW4gY29tcGFy
ZWQgdG8gdGhlIGN1cnJlbnQgc3RhdGUgb2YgUUVNVS4gSSdtIGFsc28gaW4gY29tbXVuaWNhdGlv
biB3aXRoIHRoZSBtYWludGFpbmVyIG9mIHRoZSBUcmlDb3JlIGFyY2hpdGVjdHVyZSBvbiBRRU1V
IHRvIGludGVncmF0ZSB1cGRhdGVzIHRvIHRoZSBhcmNoaXRlY3R1cmUncyBjb2RlYmFzZS48L2Rp
dj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTog
MTRweDsgY29sb3I6IHJnYigwLCAwLCAwKTsgYmFja2dyb3VuZC1jb2xvcjogcmdiKDI1NSwgMjU1
LCAyNTUpOyI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1z
ZXJpZjsgZm9udC1zaXplOiAxNHB4OyBjb2xvcjogcmdiKDAsIDAsIDApOyBiYWNrZ3JvdW5kLWNv
bG9yOiByZ2IoMjU1LCAyNTUsIDI1NSk7Ij5CZXN0IHJlZ2FyZHM8L2Rpdj4=


--b1=_qEeTifDAe6F5Zlfpiw0ktGQwb5ezVrNQLpWdcw0W7A--


