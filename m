Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A42C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 10:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZU10-0003U5-Sw; Mon, 12 Feb 2024 05:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <owl129@126.com>) id 1rZU0y-0003Tw-Cl
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 05:58:20 -0500
Received: from m15.mail.126.com ([45.254.50.224])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <owl129@126.com>) id 1rZU0v-0007QZ-Bw
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 05:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=dhw1KNYw4wfTPYmPgZkF7P6yCpaZqX0BYdX3Ecb7+e8=; b=S
 gtkTTY0C9llgL8hh06BVH3KFokpJeghsRZReK2shvEsVw3XAI01qAu+AvfUy6NmN
 yE0IYNf5xCoR92mZ/4TvjFZfGh5cwJwOA1bDd6/WIKTQTbs2uNjkIQz0R71jYiUS
 wiX9YAXAomN1kuqBX7V7BoA+hv6BgIuqeKLP6BlDuo=
Received: from owl129$126.com ( [218.30.116.61] ) by
 ajax-webmail-wmsvr-41-117 (Coremail) ; Mon, 12 Feb 2024 18:57:03 +0800
 (CST)
X-Originating-IP: [218.30.116.61]
Date: Mon, 12 Feb 2024 18:57:03 +0800 (CST)
From: owl129  <owl129@126.com>
To: =?GBK?Q?Philippe_Mathieu-Daud=A8=A6?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Subject: Re:Re: [PATCH] This patch implements several Octeon +/II instructions.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 126com
In-Reply-To: <a616c83d-068e-46a0-80b7-878425005317@linaro.org>
References: <20240119045626.9698-1-owl129@126.com>
 <a616c83d-068e-46a0-80b7-878425005317@linaro.org>
X-NTES-SC: AL_Qu2bBfuYukwp5SObZekfm0sagO07UMe4v/0v1YdSOp9wjA7j9B4FU0F9IWDO0cO+LgOuoiapcxRw49hbQKp+UqsrdIyAbsP2ls4fpPWAtP7hyA==
Content-Type: multipart/alternative; 
 boundary="----=_Part_8647_1582789253.1707735423338"
MIME-Version: 1.0
Message-ID: <233bef0a.937.18d9cf6996a.Coremail.owl129@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD333mA+cllmFweAA--.42139W
X-CM-SenderInfo: przoijaz6rjloofrz/1tbi6BOCV2VLZ186cgANs9
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=45.254.50.224; envelope-from=owl129@126.com;
 helo=m15.mail.126.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

------=_Part_8647_1582789253.1707735423338
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGkgPiBIb3cgY2FuIHdlIHRlc3QgaXQ/IElzIHRoZXJlIGFueSBkaXN0cmlidXRpb24gcHJvZHVj
aW5nIGtlcm5lbCBmb3IKPiBPY3Rlb24rLzI/IFBlciBodHRwczovL2dpdGh1Yi5jb20vTWFydmVs
bEVtYmVkZGVkUHJvY2Vzc29ycy9tYXJ2ZWxsLWRwZGsKPiAgSSB1bmRlcnN0YW5kIHRoZXJlIGNv
dWxkIGJlIExpbnV4IGFuZCBGcmVlQlNELCBpcyB0aGF0IGNvcnJlY3Q/QWN0dWFsbHkgSSBkb24n
dCBrbm93IGhvdyB0byBmdWxseSB0ZXN0IGVhY2ggaW50cnVjdGlvbi4gCgoKVG8gdGhlIGJlc3Qg
b2YgbXkga25vd2xlZGdlLCB0aGUgT2N0ZW9uIEluc3RydWN0aW9uIGlzIG9wdGltaXplZCBmb3Ig
bmV0d29ya2luZyBzZWN1cml0eS9hcHBsaWNhdGlvbiBwcm9jZXNzb3IuCkFuZCB0aGUgbGF0ZXN0
IHJlZmVyZW5jZSBtYW51YWwgaXMgbm90IHB1YmxpYyBhdmFpbGFibGUuIChodHRwczovL2Rva3Vt
ZW4udGlwcy9kb2N1bWVudHMvY2F2aXVtLW5ldHdvcmtzLW9jdGVvbi1wbHVzLWNuNTB4eC1oYXJk
d2FyZS0yMDA4LWNhdml1bS1uZXR3b3Jrcy1vY3Rlb24tcGx1cy5odG1sP3BhZ2U9MSApCgoKSSBm
aW5kIHRoZSBJbnN0cnVjdGlvbiBzcGVjaWZpY2F0aW9uIGZyb20gTWFydmVsbCdzIHRvb2xjaGFp
biBhbmQgVmFyZ3JpbmQncyB2ZXggaXIgdHJhbnNsYXRpb24gKGh0dHBzOi8vc291cmNld2FyZS5v
cmcvZ2l0Lz9wPXZhbGdyaW5kLmdpdDthPWJsb2I7Zj1WRVgvcHJpdi9ndWVzdF9taXBzX3RvSVIu
YztoPTEyODVlZGFkMGI4M2IwZjBhNmIyMWZjNjNkMjIzNWQ1MGY5NGQyMDQ7aGI9SEVBRCNsMjkw
OSkKSSBoYXZlIHN1Y2Nlc3NmdWxseSBlbXVsYXRlZCBhbiBFTEYgYmluYXJ5IGNvbXBpbGVkIGZv
ciBDYXZpdW0gKE1hcnZlbGwpIG9uIHg4NiBhcmNoaXRlY3R1cmUuCgoKQ2FuIHlvdSBoZWxwIG9y
IGdpdmUgbWUgc29tZSBzdWdnZXN0aW9ucyBhYm91dCB0ZXN0aW5nPwoKCgoKCgpCZXN0CgoKb3ds
MTI5
------=_Part_8647_1582789253.1707735423338
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPjxwcmU+PHByZT5IaSA8
L3ByZT48cHJlPiZndDsgSG93IGNhbiB3ZSB0ZXN0IGl0PyBJcyB0aGVyZSBhbnkgZGlzdHJpYnV0
aW9uIHByb2R1Y2luZyBrZXJuZWwgZm9yCiZndDsgT2N0ZW9uKy8yPyBQZXIgaHR0cHM6Ly9naXRo
dWIuY29tL01hcnZlbGxFbWJlZGRlZFByb2Nlc3NvcnMvbWFydmVsbC1kcGRrCiZndDsgIEkgdW5k
ZXJzdGFuZCB0aGVyZSBjb3VsZCBiZSBMaW51eCBhbmQgRnJlZUJTRCwgaXMgdGhhdCBjb3JyZWN0
PzwvcHJlPjwvcHJlPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPkFjdHVhbGx5IEkgZG9u
J3Qga25vdyBob3cgdG8gZnVsbHkgdGVzdCBlYWNoIGludHJ1Y3Rpb24uJm5ic3A7PC9kaXY+PGRp
diBzdHlsZT0ibWFyZ2luOiAwOyI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPlRv
IHRoZSBiZXN0IG9mIG15IGtub3dsZWRnZSwgdGhlIE9jdGVvbiBJbnN0cnVjdGlvbiBpcyBvcHRp
bWl6ZWQgZm9yJm5ic3A7bmV0d29ya2luZyBzZWN1cml0eS9hcHBsaWNhdGlvbiBwcm9jZXNzb3Iu
PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOiAwOyI+QW5kIHRoZSBsYXRlc3QgcmVmZXJlbmNlIG1h
bnVhbCBpcyBub3QgcHVibGljIGF2YWlsYWJsZS4gKDxhIGhyZWY9Imh0dHBzOi8vZG9rdW1lbi50
aXBzL2RvY3VtZW50cy9jYXZpdW0tbmV0d29ya3Mtb2N0ZW9uLXBsdXMtY241MHh4LWhhcmR3YXJl
LTIwMDgtY2F2aXVtLW5ldHdvcmtzLW9jdGVvbi1wbHVzLmh0bWw/cGFnZT0xIiBfc3JjPSJodHRw
czovL2Rva3VtZW4udGlwcy9kb2N1bWVudHMvY2F2aXVtLW5ldHdvcmtzLW9jdGVvbi1wbHVzLWNu
NTB4eC1oYXJkd2FyZS0yMDA4LWNhdml1bS1uZXR3b3Jrcy1vY3Rlb24tcGx1cy5odG1sP3BhZ2U9
MSI+aHR0cHM6Ly9kb2t1bWVuLnRpcHMvZG9jdW1lbnRzL2Nhdml1bS1uZXR3b3Jrcy1vY3Rlb24t
cGx1cy1jbjUweHgtaGFyZHdhcmUtMjAwOC1jYXZpdW0tbmV0d29ya3Mtb2N0ZW9uLXBsdXMuaHRt
bD9wYWdlPTE8L2E+ICk8L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46IDA7Ij48YnI+PC9kaXY+PGRp
diBzdHlsZT0ibWFyZ2luOiAwOyI+SSBmaW5kIHRoZSBJbnN0cnVjdGlvbiBzcGVjaWZpY2F0aW9u
IGZyb20gTWFydmVsbCdzIHRvb2xjaGFpbiBhbmQgVmFyZ3JpbmQncyB2ZXggaXIgdHJhbnNsYXRp
b24gKDxhIGhyZWY9Imh0dHBzOi8vc291cmNld2FyZS5vcmcvZ2l0Lz9wPXZhbGdyaW5kLmdpdDth
PWJsb2I7Zj1WRVgvcHJpdi9ndWVzdF9taXBzX3RvSVIuYztoPTEyODVlZGFkMGI4M2IwZjBhNmIy
MWZjNjNkMjIzNWQ1MGY5NGQyMDQ7aGI9SEVBRCNsMjkwOSIgX3NyYz0iaHR0cHM6Ly9zb3VyY2V3
YXJlLm9yZy9naXQvP3A9dmFsZ3JpbmQuZ2l0O2E9YmxvYjtmPVZFWC9wcml2L2d1ZXN0X21pcHNf
dG9JUi5jO2g9MTI4NWVkYWQwYjgzYjBmMGE2YjIxZmM2M2QyMjM1ZDUwZjk0ZDIwNDtoYj1IRUFE
I2wyOTA5Ij5odHRwczovL3NvdXJjZXdhcmUub3JnL2dpdC8/cD12YWxncmluZC5naXQ7YT1ibG9i
O2Y9VkVYL3ByaXYvZ3Vlc3RfbWlwc190b0lSLmM7aD0xMjg1ZWRhZDBiODNiMGYwYTZiMjFmYzYz
ZDIyMzVkNTBmOTRkMjA0O2hiPUhFQUQjbDI5MDk8L2E+KTwvZGl2PjxkaXYgc3R5bGU9Im1hcmdp
bjogMDsiPkkgaGF2ZSBzdWNjZXNzZnVsbHkgZW11bGF0ZWQgYW4gRUxGIGJpbmFyeSBjb21waWxl
ZCBmb3IgQ2F2aXVtIChNYXJ2ZWxsKSBvbiB4ODYgYXJjaGl0ZWN0dXJlLjwvZGl2PjxkaXYgc3R5
bGU9Im1hcmdpbjogMDsiPjxicj48L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46IDA7Ij5DYW4geW91
IGhlbHAgb3IgZ2l2ZSBtZSBzb21lJm5ic3A7c3VnZ2VzdGlvbnMgYWJvdXQgdGVzdGluZz88L2Rp
dj48cCBzdHlsZT0ibWFyZ2luOiAwOyI+PGJyPjwvcD48ZGl2IHN0eWxlPSJwb3NpdGlvbjpyZWxh
dGl2ZTt6b29tOjEiPjwvZGl2PjxkaXYgaWQ9ImRpdk5ldGVhc2VNYWlsQ2FyZCI+PC9kaXY+PGRp
diBzdHlsZT0ibWFyZ2luOiAwOyI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPkJl
c3Q8L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46IDA7Ij48YnI+PC9kaXY+PGRpdiBzdHlsZT0ibWFy
Z2luOiAwOyI+b3dsMTI5PC9kaXY+PC9kaXY+
------=_Part_8647_1582789253.1707735423338--


