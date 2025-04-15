Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A33C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mOC-0003mL-5a; Tue, 15 Apr 2025 15:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <suchitrashankar07@gmail.com>)
 id 1u4lLk-0006QB-W0
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 14:49:37 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <suchitrashankar07@gmail.com>)
 id 1u4lLj-0002Zg-3D
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 14:49:36 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso46164885e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744742967; x=1745347767; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Uvie6TwrseJP+NZ3SXZ7VgtCFNbgpWKYrB58DfuAYtY=;
 b=Bvde6qIRv02N3nSeq59haAEmu2oDki7R8Qm6TizFHCBQdm6C7f89NJu0h3S3Y8n371
 OJWfbA+Cdh5w8Jf9w4yvHAlAIRYSb360VXdgeSSjDLHUu70cUT69CRCHOYeDyZIRUcPF
 wS++DV+SEBuRaOPBli3IilSRatNXw1U1mPxag0c52/w8NWyRfkS/tGsW8e4FyhZq+WvM
 QobvUaT0BkmQsB9E2LLW3hsAqqxKoXfvD+eSKBubUA0rQp6h8O7pRPtccZkMdaGceEjA
 Md8gGqd5OY+dUSuDD38NhHgWng445YNC4vX3WBAO5pRGtIyiqvfat9xI3AYSeAYRKoNB
 I5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744742967; x=1745347767;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uvie6TwrseJP+NZ3SXZ7VgtCFNbgpWKYrB58DfuAYtY=;
 b=bKT3UbsqLOpuo7zLW+uFmvhBgqDy2YwcQMG/EQ2CH3pXsMhKw0kPU8wK9sNkG+fVqm
 jLcu0GPejOhyiUl+ZH4jKNKB1GiFHJ2GOoofSyQIf3JTZHGErFBJ+XnksZbFrxC81hsO
 yARhqyBBXTRlCWQ0Vremuwe991z/wj+Woalor/rtrEARKxYFX/V/6PmiO4SIe3ExSxsn
 biCiONjsJqbMkoNo7sjsDb7mXNG8mKYmMPTAfIIzRrAPwPSx/wjXjypmBZkByOhXJF8B
 BwPiHIZA7uzFYbvZgvNmozMRGowco5kHDA2o5Z4NRZk7h8HkNvhKizL2xXPf9lCEAeGd
 l9Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPvjQQZiHrNy9rbgII8J7WvCZEn9Rg5H2ClIjfBqahT7id2nQmFq8TbASUFVrfOKdWNQruRBdRfLGq@nongnu.org
X-Gm-Message-State: AOJu0YzQgsaXXJ9r8VYaNadfHTLBB13laiiLYtKD9K1bpcAZlRJrDGp2
 4hysmtssCi8s1O+05oHEsZLj5lsmtkM3nm8705mZhl+IK48Ywo/OPWFY2OKhPPWSe5DgjXKfrbO
 9+GJX27YBiBsLexyt7o6ulnzrPEb7k/inCp8=
X-Gm-Gg: ASbGnctLj9lTQ3mm6Pd5ChTxbYwOWV6x7WrsqahMxjxDoTdVCzsqyCjdDaOzV715iWG
 nb+pP5vnw3yuIc2K4ELeIiHzeDbsdnFVCbpSp47jOk99Wt6qxDMjZZGsqg8Knx5oTSFOJdYkXYI
 o7YbE9kjEnEU/RkgSO1Tmh
X-Google-Smtp-Source: AGHT+IFH//akahVSnb66GMb9bF0y8QqQEnU0+WvUNRmz8iGEIgl5TxuXZVrohfGz7zc3lQKqCscGwLHHLvznv62IA8c=
X-Received: by 2002:a05:6000:22c4:b0:39c:1257:feb9 with SMTP id
 ffacd0b85a97d-39ee27694c2mr486647f8f.57.1744742967297; Tue, 15 Apr 2025
 11:49:27 -0700 (PDT)
MIME-Version: 1.0
From: Suchitra Shankar <suchitrashankar07@gmail.com>
Date: Wed, 16 Apr 2025 00:19:15 +0530
X-Gm-Features: ATxdqUEQQX3TD4pC30XrsirnbZIwrL5B9s_ruMIiO0WNOvxei5dfNIod9_rmZbQ
Message-ID: <CABru571BjFa_SX5xHXbJwxRjKOOm-eo_dBTuaZx+KHOJBNVR=g@mail.gmail.com>
Subject: [PATCH] Converting aio_set_event_notifier to use io_uring methods
To: Stefan Hajnoczi <stefanha@redhat.com>, kwolf@redhat.com,
 qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="000000000000cb06680632d5a022"
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=suchitrashankar07@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 15 Apr 2025 15:56:05 -0400
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

--000000000000cb06680632d5a022
Content-Type: multipart/alternative; boundary="000000000000cb06670632d5a020"

--000000000000cb06670632d5a020
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

Apologies for not using git send-email for submitting the patch =E2=80=94 I=
 had
some issues setting up my SMTP configuration, so I=E2=80=99m sending it man=
ually
for now. I hope that=E2=80=99s alright.

Thanks again for the guidance and for reviewing my contribution!
----
This patch updates aio_set_event_notifier to use IORING_OP_READ via
aio_add_sqe()
when CONFIG_LINUX_IO_URING is defined, in order to reduce the overhead of
reactor-based file descriptor monitoring. This switches the mechanism from
polling with eventfd to the more efficient io_uring proactor pattern.
When io_uring is not available, the existing behavior is preserved.

Signed-off-by: Suchitra Shankar <suchitrashankar07@gmail.com>

--000000000000cb06670632d5a020
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-">Hi Stefan,</p>
<p class=3D"gmail-">Apologies for not using <code>git send-email</code> for=
 submitting the patch =E2=80=94 I had some issues setting up my SMTP config=
uration, so I=E2=80=99m sending it manually for now. I hope that=E2=80=99s =
alright.</p>
<p class=3D"gmail-">Thanks again for the guidance and for reviewing my cont=
ribution!<br>----</p>This patch updates aio_set_event_notifier to use IORIN=
G_OP_READ via aio_add_sqe()<br>when CONFIG_LINUX_IO_URING is defined, in or=
der to reduce the overhead of<br>reactor-based file descriptor monitoring. =
This switches the mechanism from<br>polling with eventfd to the more effici=
ent io_uring proactor pattern.<br>When io_uring is not available, the exist=
ing behavior is preserved.<br><br>Signed-off-by: Suchitra Shankar &lt;<a hr=
ef=3D"mailto:suchitrashankar07@gmail.com">suchitrashankar07@gmail.com</a>&g=
t;<br><br><br><br></div>

--000000000000cb06670632d5a020--

--000000000000cb06680632d5a022
Content-Type: text/x-patch; charset="UTF-8"; name="contribution-task.patch"
Content-Disposition: attachment; filename="contribution-task.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m9iuwl8k0>
X-Attachment-Id: f_m9iuwl8k0

RnJvbSA2NmIzNDg1ODY3YzU0MzI1NzU2ZTMwNjkxNWUwNDFmNWVmNDcwNWQxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdWNoaXRyYSBTaGFua2FyIDxzdWNoaXRyYXNoYW5rYXIwN0Bn
bWFpbC5jb20+CkRhdGU6IFR1ZSwgMTUgQXByIDIwMjUgMjM6MjU6NDggKzA1MzAKU3ViamVjdDog
W1BBVENIXSBjaG9yZTogYWRoZXJlIHRvIHFlbXUgY29kaW5nIHN0ZHMKClNpZ25lZC1vZmYtYnk6
IFN1Y2hpdHJhIFNoYW5rYXIgPHN1Y2hpdHJhc2hhbmthcjA3QGdtYWlsLmNvbT4KLS0tCiB1dGls
L2Fpby1wb3NpeC5jIHwgMTQgKysrKysrKy0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdXRpbC9haW8tcG9zaXguYyBi
L3V0aWwvYWlvLXBvc2l4LmMKaW5kZXggZDFjNmE0NmEyNS4uNzdhZjZjODliMCAxMDA2NDQKLS0t
IGEvdXRpbC9haW8tcG9zaXguYworKysgYi91dGlsL2Fpby1wb3NpeC5jCkBAIC04MjksMTIgKzgy
OSwxMiBAQCB2b2lkIGFpb19hZGRfc3FlX3dpdGhfY3R4KEFpb0NvbnRleHQgKmN0eCwKICAgICB2
b2lkICgqcHJlcF9zcWUpKHN0cnVjdCBpb191cmluZ19zcWUgKnNxZSwgdm9pZCAqb3BhcXVlKSwK
ICAgICB2b2lkICpvcGFxdWUsIENxZUhhbmRsZXIgKmNxZV9oYW5kbGVyKQogewotIGlmICghY3R4
IHx8ICFjdHgtPmZkbW9uX29wcyB8fCAhY3R4LT5mZG1vbl9vcHMtPmFkZF9zcWUpIHsKLSBmcHJp
bnRmKHN0ZGVyciwgImN0eCBvciBmZG1vbl9vcHMgaXMgTlVMTCEgQ2Fubm90IGFkZCBTUUVcbiIp
OwotIGFib3J0KCk7CisgICAgaWYgKCFjdHggfHwgIWN0eC0+ZmRtb25fb3BzIHx8ICFjdHgtPmZk
bW9uX29wcy0+YWRkX3NxZSkgeworICAgICAgICBmcHJpbnRmKHN0ZGVyciwgImN0eCBvciBmZG1v
bl9vcHMgaXMgTlVMTCEgQ2Fubm90IGFkZCBTUUVcbiIpOworICAgICAgICBhYm9ydCgpOwogIH0K
LS8vCi0vL2ZwcmludGYoc3RkZXJyLCAiPj4+IGFpb19hZGRfc3FlX3dpdGhfY3R4IGNhbGxlZCEg
PDw8XG4iKTsKKworLypmcHJpbnRmKHN0ZGVyciwgIj4+PiBhaW9fYWRkX3NxZV93aXRoX2N0eCBj
YWxsZWQhIDw8PFxuIik7Ki8KIGN0eC0+ZmRtb25fb3BzLT5hZGRfc3FlKGN0eCwgcHJlcF9zcWUs
IG9wYXF1ZSwgY3FlX2hhbmRsZXIpOwogfQogCkBAIC04NDIsOCArODQyLDggQEAgdm9pZCBhaW9f
YWRkX3NxZSh2b2lkICgqcHJlcF9zcWUpKHN0cnVjdCBpb191cmluZ19zcWUgKnNxZSwgdm9pZCAq
b3BhcXVlKSwKICAgICAgICAgICAgICAgICAgdm9pZCAqb3BhcXVlLCBDcWVIYW5kbGVyICpjcWVf
aGFuZGxlcikKIHsKICAgICBBaW9Db250ZXh0ICpjdHggPSBxZW11X2dldF9jdXJyZW50X2Fpb19j
b250ZXh0KCk7ICAvLyDihpAgdGhpcyBpcyB0aGUgbWFnaWMKLQotICAgICBpZiAoIWN0eCB8fCAh
Y3R4LT5mZG1vbl9vcHMgfHwgIWN0eC0+ZmRtb25fb3BzLT5hZGRfc3FlKSB7CisgICAgaWYgKCFj
dHggfHwgIWN0eC0+ZmRtb25fb3BzIHx8ICFjdHgtPmZkbW9uX29wcy0+YWRkX3NxZSkgCisgICAg
IHsKICAgICAgICAgIGZwcmludGYoc3RkZXJyLCAiY3R4IG9yIGZkbW9uX29wcyBpcyBOVUxMISBD
YW5ub3QgYWRkIFNRRVxuIik7CiAgICAgICAgICBhYm9ydCgpOwogICAgICB9Ci0tIAoyLjQ5LjAK
Cg==
--000000000000cb06680632d5a022--

