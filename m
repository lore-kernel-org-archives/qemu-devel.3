Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EADCD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjtx-0001wM-Dq; Wed, 17 Jun 2026 02:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1wZjtv-0001vq-2L; Wed, 17 Jun 2026 02:37:27 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1wZjts-00074X-8R; Wed, 17 Jun 2026 02:37:26 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ggDfx3Vyvz5B12k;
 Wed, 17 Jun 2026 14:37:13 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
 by mse-fl2.zte.com.cn with SMTP id 65H6b5x6070819;
 Wed, 17 Jun 2026 14:37:05 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Wed, 17 Jun 2026 14:37:07 +0800
X-Zmail-TransId: 3e816a324092004-f1ef0
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Wang Yechao <wang.yechao255@zte.com.cn>
Subject: [PATCH] target/riscv/kvm: add extensions after v7.1-rc4 update
Date: Wed, 17 Jun 2026 14:36:30 +0800
Message-ID: <20260617063630.111472-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 65H6b5x6070819
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 17 Jun 2026 14:37:13 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A324099.001/4ggDfx3Vyvz5B12k
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Y2hhbyA8d2FuZy55ZWNoYW8yNTVAenRlLmNvbS5jbj4NCi0tLQ0KIHRhcmdldC9yaXNjdi9rdm0v
a3ZtLWNwdS5jIHwgMyArKysNCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQoNCmRp
ZmYgLS1naXQgYS90YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYyBiL3RhcmdldC9yaXNjdi9rdm0v
a3ZtLWNwdS5jDQppbmRleCA1M2Q4ODMzOWMxLi42YmViYmFmN2Q0IDEwMDY0NA0KLS0tIGEvdGFy
Z2V0L3Jpc2N2L2t2bS9rdm0tY3B1LmMNCisrKyBiL3RhcmdldC9yaXNjdi9rdm0va3ZtLWNwdS5j
DQpAQCAtMzAzLDEwICszMDMsMTMgQEAgc3RhdGljIEtWTUNQVUNvbmZpZyBrdm1fbXVsdGlfZXh0
X2NmZ3NbXSA9IHsNCiAgICAgS1ZNX0VYVF9DRkcoInppaGludG50bCIsIGV4dF96aWhpbnRudGws
IEtWTV9SSVNDVl9JU0FfRVhUX1pJSElOVE5UTCksDQogICAgIEtWTV9FWFRfQ0ZHKCJ6aWhpbnRw
YXVzZSIsIGV4dF96aWhpbnRwYXVzZSwgS1ZNX1JJU0NWX0lTQV9FWFRfWklISU5UUEFVU0UpLA0K
ICAgICBLVk1fRVhUX0NGRygiemlocG0iLCBleHRfemlocG0sIEtWTV9SSVNDVl9JU0FfRVhUX1pJ
SFBNKSwNCisgICAgS1ZNX0VYVF9DRkcoInppbHNkIiwgZXh0X3ppbHNkLCBLVk1fUklTQ1ZfSVNB
X0VYVF9aSUxTRCksDQogICAgIEtWTV9FWFRfQ0ZHKCJ6aW1vcCIsIGV4dF96aW1vcCwgS1ZNX1JJ
U0NWX0lTQV9FWFRfWklNT1ApLA0KICAgICBLVk1fRVhUX0NGRygiemNtb3AiLCBleHRfemNtb3As
IEtWTV9SSVNDVl9JU0FfRVhUX1pDTU9QKSwNCisgICAgS1ZNX0VYVF9DRkcoInpjbHNkIiwgZXh0
X3pjbHNkLCBLVk1fUklTQ1ZfSVNBX0VYVF9aQ0xTRCksDQogICAgIEtWTV9FWFRfQ0ZHKCJ6YWJo
YSIsIGV4dF96YWJoYSwgS1ZNX1JJU0NWX0lTQV9FWFRfWkFCSEEpLA0KICAgICBLVk1fRVhUX0NG
RygiemFjYXMiLCBleHRfemFjYXMsIEtWTV9SSVNDVl9JU0FfRVhUX1pBQ0FTKSwNCisgICAgS1ZN
X0VYVF9DRkcoInphbGFzciIsIGV4dF96YWxhc3IsIEtWTV9SSVNDVl9JU0FfRVhUX1pBTEFTUiks
DQogICAgIEtWTV9FWFRfQ0ZHKCJ6YXdycyIsIGV4dF96YXdycywgS1ZNX1JJU0NWX0lTQV9FWFRf
WkFXUlMpLA0KICAgICBLVk1fRVhUX0NGRygiemZhIiwgZXh0X3pmYSwgS1ZNX1JJU0NWX0lTQV9F
WFRfWkZBKSwNCiAgICAgS1ZNX0VYVF9DRkcoInpmYmZtaW4iLCBleHRfemZiZm1pbiwgS1ZNX1JJ
U0NWX0lTQV9FWFRfWkZCRk1JTiksDQotLSANCjIuMjcuMA==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

RXhwb3NlJm5ic3A7emlsc2QsJm5ic3A7emNsc2QmbmJzcDthbmQmbmJzcDt6YWxhc3IuPGJyIC8+
DTxiciAvPlNpZ25lZC1vZmYtYnk6Jm5ic3A7V2FuZyZuYnNwO1llY2hhbyZuYnNwOyZsdDt3YW5n
LnllY2hhbzI1NUB6dGUuY29tLmNuJmd0Ow08YnIgLz4tLS08YnIgLz4mbmJzcDt0YXJnZXQvcmlz
Y3Yva3ZtL2t2bS1jcHUuYyZuYnNwO3wmbmJzcDszJm5ic3A7KysrPGJyIC8+Jm5ic3A7MSZuYnNw
O2ZpbGUmbmJzcDtjaGFuZ2VkLCZuYnNwOzMmbmJzcDtpbnNlcnRpb25zKCspPGJyIC8+DTxiciAv
PmRpZmYmbmJzcDstLWdpdCZuYnNwO2EvdGFyZ2V0L3Jpc2N2L2t2bS9rdm0tY3B1LmMmbmJzcDti
L3RhcmdldC9yaXNjdi9rdm0va3ZtLWNwdS5jPGJyIC8+aW5kZXgmbmJzcDs1M2Q4ODMzOWMxLi42
YmViYmFmN2Q0Jm5ic3A7MTAwNjQ0PGJyIC8+LS0tJm5ic3A7YS90YXJnZXQvcmlzY3Yva3ZtL2t2
bS1jcHUuYzxiciAvPisrKyZuYnNwO2IvdGFyZ2V0L3Jpc2N2L2t2bS9rdm0tY3B1LmM8YnIgLz5A
QCZuYnNwOy0zMDMsMTAmbmJzcDsrMzAzLDEzJm5ic3A7QEAmbmJzcDtzdGF0aWMmbmJzcDtLVk1D
UFVDb25maWcmbmJzcDtrdm1fbXVsdGlfZXh0X2NmZ3NbXSZuYnNwOz0mbmJzcDt7PGJyIC8+Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7S1ZNX0VYVF9DRkcoJnF1b3Q7emloaW50bnRsJnF1
b3Q7LCZuYnNwO2V4dF96aWhpbnRudGwsJm5ic3A7S1ZNX1JJU0NWX0lTQV9FWFRfWklISU5UTlRM
KSw8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtLVk1fRVhUX0NGRygmcXVvdDt6
aWhpbnRwYXVzZSZxdW90OywmbmJzcDtleHRfemloaW50cGF1c2UsJm5ic3A7S1ZNX1JJU0NWX0lT
QV9FWFRfWklISU5UUEFVU0UpLDxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO0tW
TV9FWFRfQ0ZHKCZxdW90O3ppaHBtJnF1b3Q7LCZuYnNwO2V4dF96aWhwbSwmbmJzcDtLVk1fUklT
Q1ZfSVNBX0VYVF9aSUhQTSksPGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO0tWTV9FWFRf
Q0ZHKCZxdW90O3ppbHNkJnF1b3Q7LCZuYnNwO2V4dF96aWxzZCwmbmJzcDtLVk1fUklTQ1ZfSVNB
X0VYVF9aSUxTRCksPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7S1ZNX0VYVF9D
RkcoJnF1b3Q7emltb3AmcXVvdDssJm5ic3A7ZXh0X3ppbW9wLCZuYnNwO0tWTV9SSVNDVl9JU0Ff
RVhUX1pJTU9QKSw8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtLVk1fRVhUX0NG
RygmcXVvdDt6Y21vcCZxdW90OywmbmJzcDtleHRfemNtb3AsJm5ic3A7S1ZNX1JJU0NWX0lTQV9F
WFRfWkNNT1ApLDxiciAvPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtLVk1fRVhUX0NGRygmcXVv
dDt6Y2xzZCZxdW90OywmbmJzcDtleHRfemNsc2QsJm5ic3A7S1ZNX1JJU0NWX0lTQV9FWFRfWkNM
U0QpLDxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO0tWTV9FWFRfQ0ZHKCZxdW90
O3phYmhhJnF1b3Q7LCZuYnNwO2V4dF96YWJoYSwmbmJzcDtLVk1fUklTQ1ZfSVNBX0VYVF9aQUJI
QSksPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7S1ZNX0VYVF9DRkcoJnF1b3Q7
emFjYXMmcXVvdDssJm5ic3A7ZXh0X3phY2FzLCZuYnNwO0tWTV9SSVNDVl9JU0FfRVhUX1pBQ0FT
KSw8YnIgLz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7S1ZNX0VYVF9DRkcoJnF1b3Q7emFsYXNy
JnF1b3Q7LCZuYnNwO2V4dF96YWxhc3IsJm5ic3A7S1ZNX1JJU0NWX0lTQV9FWFRfWkFMQVNSKSw8
YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtLVk1fRVhUX0NGRygmcXVvdDt6YXdy
cyZxdW90OywmbmJzcDtleHRfemF3cnMsJm5ic3A7S1ZNX1JJU0NWX0lTQV9FWFRfWkFXUlMpLDxi
ciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO0tWTV9FWFRfQ0ZHKCZxdW90O3pmYSZx
dW90OywmbmJzcDtleHRfemZhLCZuYnNwO0tWTV9SSVNDVl9JU0FfRVhUX1pGQSksPGJyIC8+Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7S1ZNX0VYVF9DRkcoJnF1b3Q7emZiZm1pbiZxdW90
OywmbmJzcDtleHRfemZiZm1pbiwmbmJzcDtLVk1fUklTQ1ZfSVNBX0VYVF9aRkJGTUlOKSw8YnIg
Lz4tLSZuYnNwOw08YnIgLz4yLjI3LjA8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


