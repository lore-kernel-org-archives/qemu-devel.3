Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4164C71135
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Jun 2025 20:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQXOZ-0000nJ-PH; Sat, 14 Jun 2025 16:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>)
 id 1uQXOY-0000mu-5g; Sat, 14 Jun 2025 16:22:30 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>)
 id 1uQXOW-00064i-86; Sat, 14 Jun 2025 16:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749932537;
 bh=GSxQYfm1gdokMAyZkoXT+q9J4n/xhUc7DC8eYZwlWy4=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=vTGlmxKgXkKFcMFwOXibnvZWA7TPd0Ob4hvd/DOEey2y2OixhVZ9u4Xy291OLziKO
 kAnYtuNSqyMxD6S49Q9A28WpMezLanvxxhn48QjHqC8dpZZ4DYh9Z2XaObahlijLgY
 0hx+N12gLP3ujtjdKUpWIRikjXrczouYMSrN9lyIenXeiyDGDdm8lcHqvIsiZo+nmx
 LMXa9NDeQ09ZWxk8DYOPxan20jlO0l7Y2KbjbEUmVNPCkipDepdnO9BgWI4XqpaTpu
 3m6mJ58YdgbMi268vOkJNeI6ov3l+k6whhYvpGtJiYszzaW0BJGl1iH1pqHaeBsHTk
 5dpGWJ0CaXu5Q==
Received: from [192.168.0.80] (unknown [207.191.242.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 9CBC769C8;
 Sun, 15 Jun 2025 04:22:11 +0800 (CST)
Message-ID: <3f4e8f04-c785-4374-913f-2dc200d1ea1e@sean.taipei>
Date: Sat, 14 Jun 2025 16:22:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sean Wei <me@sean.taipei>
Subject: Re: [PATCH 05/12] include/hw: replace FSF postal address with
 licenses URL
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "Daniel P . Berrange" <berrange@redhat.com>, Sean Wei <me@sean.taipei>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250613.qemu.patch@sean.taipei>
 <20250613.qemu.patch.05@sean.taipei>
 <3aa8de03-911e-4906-a0c5-5b8ea269ad28@kaod.org>
 <CAGvOXg_VK0+DA_OHy0oWGC4QuL6icFd7yabLKeRzQMc8OpU-rA@mail.gmail.com>
 <66a0c462-deb3-46c9-bcd1-1395137dc108@kaod.org>
Content-Language: en-US
In-Reply-To: <66a0c462-deb3-46c9-bcd1-1395137dc108@kaod.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-512; boundary="------------ms060100000705020503020401"
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

--------------ms060100000705020503020401
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQ8OpZHJpYywNCg0KVGhhbmtzIGZvciBwb2ludGluZyBtZSB0byB0aGUgZWFybGllciB0
aHJlYWQsIG1vdmluZyB0bw0KdGhlIGBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcmAgdGFncyBp
cyB0aGUgYmV0dGVyIGxvbmctdGVybSBmaXguDQoNCg0KID4gSSB0aGluayB5b3UgY2FuIGNv
bnZlcnQgYWxsIFFFTVUgZmlsZXMgd2hpbGUgYXQgaXQuDQoNClRvIGtlZXAgdHJhZmZpYyBv
biBxZW11LWRldmVsQCBtYW5hZ2VhYmxlLCBJJ2QgbGlrZSB0byB3b3JrDQpzdWJ0cmVlIGJ5
IHN1YnRyZWUsIGZvbGxvd2luZyB0aGUgc2VjdGlvbnMgaW4gTUFJTlRBSU5FUlMuDQoNCg0K
ID4gQXJlIHRoZXJlIGFueSBNSVQtbGljZW5zZWQgZmlsZXM/DQoNCkp1c3QgYSBoYW5kZnVs
IGluIHRoZSBBU1BFRUQgY29kZSBiYXNlIHVzaW5nIE1JVDoNCg0KICAgICBody9zc2kvYXNw
ZWVkX3NtYy5jDQogICAgIGluY2x1ZGUvaHcvc3NpL2FzcGVlZF9zbWMuaA0KICAgICB0ZXN0
cy9xdGVzdC9hc3BlZWRfZ3Bpby10ZXN0LmMNCiAgICAgdGVzdHMvcXRlc3QvYXNwZWVkX3Nt
Yy10ZXN0LmMNCiAgICAgdGVzdHMvcXRlc3QvYXNwZWVkLXNtYy11dGlscy5jDQogICAgIHRl
c3RzL3F0ZXN0L2FzcGVlZC1zbWMtdXRpbHMuaA0KDQoNCiMjIFByb3Bvc2VkIHN0ZXBzDQoN
CjEuIFN0YXJ0IHdpdGggdGhlIEFTUEVFRCBCTUMgc3VidHJlZS4NCg0KMi4gU3BsaXQgY29t
bWl0cyBieSBwYXRoIGFuZCBoZWFkZXIgc3R5bGUuDQogICAgcGF0aDogaHcvLCBpbmNsdWRl
L2h3LywgdGVzdHMvDQogICAgbGljZW5zZTogR1BMLTIuMC1vci1sYXRlciwgR1BMLTIuMC1v
bmx5LCBNSVQNCiAgICBzdHlsZTogYm9pbGVyIHBsYXRlLCBzZWUgQ09QWUlORw0KDQozLiBE
cm9wIHRoZSBib2lsZXItcGxhdGUsIHJlcGxhY2Ugd2l0aCB0aGUgY29ycmVjdA0KICAgIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyLCB3aXRob3V0IGNoYW5naW5nIGNvZGUuDQoNCkRvZXMg
dGhpcyBhcHByb2FjaCBzb3VuZCByZWFzb25hYmxlIGZvciB5b3U/DQoNCg0KVGhhbmtzIGFn
YWluIGZvciB0aGUgZ3VpZGFuY2UhDQoNCkJlc3QgcmVnYXJkcywNClNlYW4gV2VpDQo=

--------------ms060100000705020503020401
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
--------------ms060100000705020503020401--

