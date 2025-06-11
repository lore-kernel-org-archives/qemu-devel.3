Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4FDC71135
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 21:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPT1h-0007xh-8f; Wed, 11 Jun 2025 17:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uPT1f-0007xX-Dn
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 17:30:27 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uPT1d-0006f1-FM
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 17:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749677417;
 bh=PBkRlHG9zaSBnlCl7FIjE2V9Hm3aKB09/bexBn9Z1Ec=;
 h=Date:To:From:Subject:From;
 b=b8ti4mE+x4TTJnpQKsT9oIj57uClOWo5DqvzjkWX+sTUtwRhf/1XZ1YbQbrt5qDLH
 WxgEQpIqt5JN5gmW3Pu1VXkcyTp4Wqsmt5j0ATly38i0+WytyRQ5RWz9oJoPr8PIuC
 bmtGILZaKdIhL48w+8NT7ZzgKHDmlaxgRRSFaONHWSgogbKYrRhcvKuj0IJMGqE1jg
 Gvz6cm3y3rq+ptGc+tU4IgSG1MUdv7vS3Df6yeYhEq3SSsd5MITuzrh7R4NDLH4X80
 pBfhAOvn60/ryAanI5KpfaUHJulTuk8a5yNsWgxiXCfe7ml7/gOlYq0HIBEC3u+1xn
 xHg06aioos7cA==
Received: from [192.168.0.214] (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 97207700;
 Thu, 12 Jun 2025 05:30:16 +0800 (CST)
Message-ID: <bd4e4c8e-1686-43d7-8c46-66e6c0c79695@sean.taipei>
Date: Wed, 11 Jun 2025 17:29:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
From: Sean Wei <me@sean.taipei>
Subject: Request for QEMU Wiki Account
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-512; boundary="------------ms000002080600050603010908"
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a cryptographically signed message in MIME format.

--------------ms000002080600050603010908
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUUVNVSBNYWludGFpbmVycywNCg0KSSdtIG5ldyB0byB0aGUgUUVNVSBjb21tdW5pdHku
IFdoaWxlIGdvaW5nIHRocm91Z2ggdGhlIHdpa2kgdG8gZ2V0IHN0YXJ0ZWQsDQpJIG5vdGlj
ZWQgYSBmZXcgaXNzdWVzIGFuZCBJJ2QgbGlrZSB0byBoZWxwIGNvcnJlY3Q6DQoNCi0gU29t
ZSBsaW5rcyBwb2ludCB0byBkb2N1bWVudHMgdGhhdCBoYXZlIGJlZW4gcmVuYW1lZCBvciBy
ZW1vdmVkLg0KLSBDb21taXQgSURzIGFuZCBmaWxlbmFtZXMgY291bGQgYmUgaHlwZXJsaW5r
ZWQuDQotIFNvbWUgc3ViLXBhZ2VzIG1pZ2h0IGJlbmVmaXQgZnJvbSBhIHNob3J0IHN1bW1h
cnkgdGhhdCBsaW5rcyBiYWNrIHRvIA0KdGhlIG1haW4gcGFnZS4NCg0KQ291bGQgeW91IHBs
ZWFzZSBjcmVhdGUgYSB3aWtpIGFjY291bnQgZm9yIG1lIHNvIEkgY2FuIHN1Ym1pdCB0aGVz
ZSANCmltcHJvdmVtZW50cz8NClRoYW5rIHlvdSBmb3IgeW91ciB0aW1lIGFuZCBmb3IgbWFp
bnRhaW5pbmcgc3VjaCBhIGdyZWF0IHByb2plY3QhDQoNCk1heSB0aGUgc291cmNlIGJlIHdp
dGggeW91LA0KU2VhbiBXZWkNCg==

--------------ms000002080600050603010908
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ITAfBgNVBAoMGEFzc2VjbyBEYXRhIFN5c3RlbXMgUy5BLjEcMBoGA1UEAwwTQ2VydHVtIFNN
SU1FIFJTQSBDQTAeFw0yNDAyMjAxMDI0NTRaFw0yNjAyMTkxMDI0NTNaMDgxFzAVBgNVBAMM
Dm1lQHNlYW4udGFpcGVpMR0wGwYJKoZIhvcNAQkBFg5tZUBzZWFuLnRhaXBlaTCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBAMgBdqaX8wyudsaj+2/4E0Nrcn9H5D2ux8KpjEef
D7+Ae9mK/borSr7JTszEFurh3f5N+nXg0X6rr37yfXYvqWvov+Ci8PgexSPXyYLlndbsVcCO
Ca4Y+ikG1FtswWHPkXiwsIK8VPHXQvLUgUJWKPtYxc9/wFwMupX9Ziv1V3+gzxqVfqahy+x9
rZnpdqGvy/ITMTvrKW2qYJqp6GAQzlWlmu/VeTDN+rh4gUAKaLsJkhvDeNy44SEwX1WOqRWD
N3RlrDj5tmlC1Ew02HbeN3T33s/KG5qN9nimo4oJXHMSrivarkIsRqLhnm+jixqTpw5I2kUK
aE0k7O/nIZPRG3RtKhc6szZVGmqZrW3S0OJS2UpRC3CGdgmwF2jr1zC7xL11RWYQwyTMZLOr
9vY0yz9zemNHVNlI0aEKsFqcWw81/2zi56qkl/G9veaPST4UjsMomj5zvYiUT14lpJAut25V
rW/Q/gouSfGHtprks+FiNBBYh8qmqESJPYNT3KAhdFkQUwqwd2HVCCkstmv8+M+w+fJhSRKr
FPCXg/Ermms7fK1kl+i9l/uOgDwVMkGV+y0BGHUUkI6XdehBpillzMkPvRWBfHBEEl6StNKn
wKiJb70wKivclWSFnlEc+GaErKlZuGo5r3IrYKV20RpwdCOFtDlaPV7dH4CqsQt+j7jTAgMB
AAGjggGzMIIBrzAMBgNVHRMBAf8EAjAAMEEGA1UdHwQ6MDgwNqA0oDKGMGh0dHA6Ly9jc21p
bWVyc2FjYS5jcmwuY2VydHVtLnBsL2NzbWltZXJzYWNhLmNybDCBgwYIKwYBBQUHAQEEdzB1
MC4GCCsGAQUFBzABhiJodHRwOi8vY3NtaW1lcnNhY2Eub2NzcC1jZXJ0dW0uY29tMEMGCCsG
AQUFBzAChjdodHRwOi8vY3NtaW1lcnNhY2EucmVwb3NpdG9yeS5jZXJ0dW0ucGwvY3NtaW1l
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
--------------ms000002080600050603010908--

