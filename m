Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EBFCDB471
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbYcC-00080y-KI; Mon, 22 Jun 2026 02:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1wbYc1-00080L-6v; Mon, 22 Jun 2026 02:58:30 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1wbYbw-0002tE-4f; Mon, 22 Jun 2026 02:58:28 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4gkJtp5wbKz58fdY;
 Mon, 22 Jun 2026 14:58:10 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl2.zte.com.cn with SMTP id 65M6w40b014978;
 Mon, 22 Jun 2026 14:58:04 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Mon, 22 Jun 2026 14:58:06 +0800
X-Zmail-TransId: 3e816a38dcfd005-a9dad
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Wang Yechao <wang.yechao255@zte.com.cn>
Subject: [PATCH v2] target/riscv/kvm: add extensions after v7.1-rc4 update
Date: Mon, 22 Jun 2026 14:57:17 +0800
Message-ID: <20260622065717.15386-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 65M6w40b014978
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 22 Jun 2026 14:58:10 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A38DD02.000/4gkJtp5wbKz58fdY
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

RXhwb3NlIHppbHNkLCB6Y2xzZCBhbmQgemFsYXNyLg0KDQpTaWduZWQtb2ZmLWJ5OiBXYW5nIFll
Y2hhbyA8d2FuZy55ZWNoYW8yNTVAenRlLmNvbS5jbj4NCkFja2VkLWJ5OiBBbGlzdGFpciBGcmFu
Y2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQotLS0NCkNoYW5nZXMgaW4gdjI6DQotIFJl
YmFzZSBvbiBodHRwczovL2dpdGh1Yi5jb20vYWxpc3RhaXIyMy9xZW11L3RyZWUvcmlzY3YtdG8t
YXBwbHkubmV4dA0KDQotLS0NCiB0YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYyB8IDMgKysrDQog
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jp
c2N2L2t2bS9rdm0tY3B1LmMgYi90YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYw0KaW5kZXggZjBk
ZTVjMzA3MS4uNzA3Yjk5MmQ1NSAxMDA2NDQNCi0tLSBhL3RhcmdldC9yaXNjdi9rdm0va3ZtLWNw
dS5jDQorKysgYi90YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYw0KQEAgLTMwNCwxMCArMzA0LDEz
IEBAIHN0YXRpYyBLVk1DUFVDb25maWcga3ZtX211bHRpX2V4dF9jZmdzW10gPSB7DQogICAgIEtW
TV9FWFRfQ0ZHKCJ6aWhpbnRudGwiLCBleHRfemloaW50bnRsLCBLVk1fUklTQ1ZfSVNBX0VYVF9a
SUhJTlROVEwpLA0KICAgICBLVk1fRVhUX0NGRygiemloaW50cGF1c2UiLCBleHRfemloaW50cGF1
c2UsIEtWTV9SSVNDVl9JU0FfRVhUX1pJSElOVFBBVVNFKSwNCiAgICAgS1ZNX0VYVF9DRkcoInpp
aHBtIiwgZXh0X3ppaHBtLCBLVk1fUklTQ1ZfSVNBX0VYVF9aSUhQTSksDQorICAgIEtWTV9FWFRf
Q0ZHKCJ6aWxzZCIsIGV4dF96aWxzZCwgS1ZNX1JJU0NWX0lTQV9FWFRfWklMU0QpLA0KICAgICBL
Vk1fRVhUX0NGRygiemltb3AiLCBleHRfemltb3AsIEtWTV9SSVNDVl9JU0FfRVhUX1pJTU9QKSwN
CiAgICAgS1ZNX0VYVF9DRkcoInpjbW9wIiwgZXh0X3pjbW9wLCBLVk1fUklTQ1ZfSVNBX0VYVF9a
Q01PUCksDQorICAgIEtWTV9FWFRfQ0ZHKCJ6Y2xzZCIsIGV4dF96Y2xzZCwgS1ZNX1JJU0NWX0lT
QV9FWFRfWkNMU0QpLA0KICAgICBLVk1fRVhUX0NGRygiemFiaGEiLCBleHRfemFiaGEsIEtWTV9S
SVNDVl9JU0FfRVhUX1pBQkhBKSwNCiAgICAgS1ZNX0VYVF9DRkcoInphY2FzIiwgZXh0X3phY2Fz
LCBLVk1fUklTQ1ZfSVNBX0VYVF9aQUNBUyksDQorICAgIEtWTV9FWFRfQ0ZHKCJ6YWxhc3IiLCBl
eHRfemFsYXNyLCBLVk1fUklTQ1ZfSVNBX0VYVF9aQUxBU1IpLA0KICAgICBLVk1fRVhUX0NGRygi
emF3cnMiLCBleHRfemF3cnMsIEtWTV9SSVNDVl9JU0FfRVhUX1pBV1JTKSwNCiAgICAgS1ZNX0VY
VF9DRkcoInpmYSIsIGV4dF96ZmEsIEtWTV9SSVNDVl9JU0FfRVhUX1pGQSksDQogICAgIEtWTV9F
WFRfQ0ZHKCJ6ZmJmbWluIiwgZXh0X3pmYmZtaW4sIEtWTV9SSVNDVl9JU0FfRVhUX1pGQkZNSU4p
LA0KLS0gDQoyLjQzLjU=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

RXhwb3NlJm5ic3A7emlsc2QsJm5ic3A7emNsc2QmbmJzcDthbmQmbmJzcDt6YWxhc3IuPGJyIC8+
DTxiciAvPlNpZ25lZC1vZmYtYnk6Jm5ic3A7V2FuZyZuYnNwO1llY2hhbyZuYnNwOyZsdDt3YW5n
LnllY2hhbzI1NUB6dGUuY29tLmNuJmd0Ow08YnIgLz5BY2tlZC1ieTombmJzcDtBbGlzdGFpciZu
YnNwO0ZyYW5jaXMmbmJzcDsmbHQ7YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tJmd0Ow08YnIgLz4t
LS08YnIgLz5DaGFuZ2VzJm5ic3A7aW4mbmJzcDt2Mjo8YnIgLz4tJm5ic3A7UmViYXNlJm5ic3A7
b24mbmJzcDtodHRwczovL2dpdGh1Yi5jb20vYWxpc3RhaXIyMy9xZW11L3RyZWUvcmlzY3YtdG8t
YXBwbHkubmV4dDxiciAvPg08YnIgLz4tLS08YnIgLz4mbmJzcDt0YXJnZXQvcmlzY3Yva3ZtL2t2
bS1jcHUuYyZuYnNwO3wmbmJzcDszJm5ic3A7KysrPGJyIC8+Jm5ic3A7MSZuYnNwO2ZpbGUmbmJz
cDtjaGFuZ2VkLCZuYnNwOzMmbmJzcDtpbnNlcnRpb25zKCspPGJyIC8+DTxiciAvPmRpZmYmbmJz
cDstLWdpdCZuYnNwO2EvdGFyZ2V0L3Jpc2N2L2t2bS9rdm0tY3B1LmMmbmJzcDtiL3RhcmdldC9y
aXNjdi9rdm0va3ZtLWNwdS5jPGJyIC8+aW5kZXgmbmJzcDtmMGRlNWMzMDcxLi43MDdiOTkyZDU1
Jm5ic3A7MTAwNjQ0PGJyIC8+LS0tJm5ic3A7YS90YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYzxi
ciAvPisrKyZuYnNwO2IvdGFyZ2V0L3Jpc2N2L2t2bS9rdm0tY3B1LmM8YnIgLz5AQCZuYnNwOy0z
MDQsMTAmbmJzcDsrMzA0LDEzJm5ic3A7QEAmbmJzcDtzdGF0aWMmbmJzcDtLVk1DUFVDb25maWcm
bmJzcDtrdm1fbXVsdGlfZXh0X2NmZ3NbXSZuYnNwOz0mbmJzcDt7PGJyIC8+Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7S1ZNX0VYVF9DRkcoJnF1b3Q7emloaW50bnRsJnF1b3Q7LCZuYnNw
O2V4dF96aWhpbnRudGwsJm5ic3A7S1ZNX1JJU0NWX0lTQV9FWFRfWklISU5UTlRMKSw8YnIgLz4m
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtLVk1fRVhUX0NGRygmcXVvdDt6aWhpbnRwYXVz
ZSZxdW90OywmbmJzcDtleHRfemloaW50cGF1c2UsJm5ic3A7S1ZNX1JJU0NWX0lTQV9FWFRfWklI
SU5UUEFVU0UpLDxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO0tWTV9FWFRfQ0ZH
KCZxdW90O3ppaHBtJnF1b3Q7LCZuYnNwO2V4dF96aWhwbSwmbmJzcDtLVk1fUklTQ1ZfSVNBX0VY
VF9aSUhQTSksPGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO0tWTV9FWFRfQ0ZHKCZxdW90
O3ppbHNkJnF1b3Q7LCZuYnNwO2V4dF96aWxzZCwmbmJzcDtLVk1fUklTQ1ZfSVNBX0VYVF9aSUxT
RCksPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7S1ZNX0VYVF9DRkcoJnF1b3Q7
emltb3AmcXVvdDssJm5ic3A7ZXh0X3ppbW9wLCZuYnNwO0tWTV9SSVNDVl9JU0FfRVhUX1pJTU9Q
KSw8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtLVk1fRVhUX0NGRygmcXVvdDt6
Y21vcCZxdW90OywmbmJzcDtleHRfemNtb3AsJm5ic3A7S1ZNX1JJU0NWX0lTQV9FWFRfWkNNT1Ap
LDxiciAvPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtLVk1fRVhUX0NGRygmcXVvdDt6Y2xzZCZx
dW90OywmbmJzcDtleHRfemNsc2QsJm5ic3A7S1ZNX1JJU0NWX0lTQV9FWFRfWkNMU0QpLDxiciAv
PiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO0tWTV9FWFRfQ0ZHKCZxdW90O3phYmhhJnF1
b3Q7LCZuYnNwO2V4dF96YWJoYSwmbmJzcDtLVk1fUklTQ1ZfSVNBX0VYVF9aQUJIQSksPGJyIC8+
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7S1ZNX0VYVF9DRkcoJnF1b3Q7emFjYXMmcXVv
dDssJm5ic3A7ZXh0X3phY2FzLCZuYnNwO0tWTV9SSVNDVl9JU0FfRVhUX1pBQ0FTKSw8YnIgLz4r
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7S1ZNX0VYVF9DRkcoJnF1b3Q7emFsYXNyJnF1b3Q7LCZu
YnNwO2V4dF96YWxhc3IsJm5ic3A7S1ZNX1JJU0NWX0lTQV9FWFRfWkFMQVNSKSw8YnIgLz4mbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtLVk1fRVhUX0NGRygmcXVvdDt6YXdycyZxdW90Oywm
bmJzcDtleHRfemF3cnMsJm5ic3A7S1ZNX1JJU0NWX0lTQV9FWFRfWkFXUlMpLDxiciAvPiZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO0tWTV9FWFRfQ0ZHKCZxdW90O3pmYSZxdW90OywmbmJz
cDtleHRfemZhLCZuYnNwO0tWTV9SSVNDVl9JU0FfRVhUX1pGQSksPGJyIC8+Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7S1ZNX0VYVF9DRkcoJnF1b3Q7emZiZm1pbiZxdW90OywmbmJzcDtl
eHRfemZiZm1pbiwmbmJzcDtLVk1fUklTQ1ZfSVNBX0VYVF9aRkJGTUlOKSw8YnIgLz4tLSZuYnNw
Ow08YnIgLz4yLjQzLjU8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


