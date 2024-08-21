Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C593FC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 13:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sglRh-0002e2-9V; Wed, 21 Aug 2024 09:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carisett@akamai.com>)
 id 1sglRe-0002Wg-MM; Wed, 21 Aug 2024 09:32:14 -0400
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carisett@akamai.com>)
 id 1sglRc-0005Fn-Du; Wed, 21 Aug 2024 09:32:14 -0400
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
 by m0050096.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id
 47L5aJYk009052; Wed, 21 Aug 2024 14:32:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
 content-type:date:from:message-id:mime-version:subject:to; s=
 jan2016.eng; bh=qveQyqyON5t8NzFRFhfRiffOQRGI5vp6t/veEFHHQp8=; b=
 I33z/1WTblQcDZT+pV8yTv0NltkF1ROB/xriYE3w3wMMk39ziYSnje/mlHdwPdFB
 voE9rOIINEaBjKfMX+yVe0D0HonlUUymacdG9a2+M3yEK2YDVmT5xkudUFHA4arY
 YgVOe4qEGmii0RWvvD1XAm1M4+5TG3d/CPPRSmttpezZlc4JIJo+HlInw8XzZ/zh
 FzoZmSrYo6elWXz8+M+oANTAG98GKQpiGVXynZ9b4+tPhvu8ovH3DKlFBOxvZcc1
 PQ1qaOvR5kuKnKOvOU8/bvfcyzlln7Db4vF/pDcpLx0yTzY2QmAeAkW2L1JlDRnL
 V6H6XqwubB7Atozzgg7Ygw==
Received: from prod-mail-ppoint7
 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be
 forged))
 by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 4149pfdx30-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Aug 2024 14:32:09 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
 by prod-mail-ppoint7.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 47LADsnC013376; Wed, 21 Aug 2024 09:32:09 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.201])
 by prod-mail-ppoint7.akamai.com (PPS) with ESMTPS id 412q6y6jt3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Aug 2024 09:32:09 -0400
Received: from ustx2ex-dag4mb8.msg.corp.akamai.com (172.27.50.207) by
 ustx2ex-dag4mb2.msg.corp.akamai.com (172.27.50.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 06:32:08 -0700
Received: from ustx2ex-dag4mb8.msg.corp.akamai.com ([172.27.50.207]) by
 ustx2ex-dag4mb8.msg.corp.akamai.com ([172.27.50.207]) with mapi id
 15.02.1544.011; Wed, 21 Aug 2024 06:32:08 -0700
From: "Arisetty, Chakri" <carisett@akamai.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Issue with QEMU Live Migration
Thread-Topic: Issue with QEMU Live Migration
Thread-Index: AQHa886FsqX6lMAdoUyRdLRWIRR0PQ==
Date: Wed, 21 Aug 2024 13:32:08 +0000
Message-ID: <1ABDAA2B-8582-4B98-81D3-8F71DE62718C@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.27.118.139]
Content-Type: multipart/alternative;
 boundary="_000_1ABDAA2B85824B9881D38F71DE62718Cakamaicom_"
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_10,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408210096
X-Proofpoint-ORIG-GUID: fvjMtqnHOATu6us8tZ_KhNKc9YEc1VBZ
X-Proofpoint-GUID: fvjMtqnHOATu6us8tZ_KhNKc9YEc1VBZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_10,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0
 spamscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=881 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408210098
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=carisett@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--_000_1ABDAA2B85824B9881D38F71DE62718Cakamaicom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCknigJltIGhhdmluZyB0cm91YmxlIHdpdGggbGl2ZSBtaWdyYXRpb24gYW5kIEni
gJltIHVzaW5nIFFFTVUgNy4yLjAgb24gRGViaWFuIDExLg0KDQpNaWdyYXRpb24gc3RhdGUgc3dp
dGNoZXMgdG8gcHJlLXN3aXRjaG92ZXIgc3RhdGUgZHVyaW5nIHRoZSBSQU0gbWlncmF0aW9uLg0K
DQpNeSBhc3N1bXB0aW9uIGlzIHRoYXQgZGlza3MgYXJlIGFscmVhZHkgbWlncmF0ZWQgYW5kIHRo
ZXJlIGFyZSBubyBmdXJ0aGVyIGRpcnR5IHBhZ2VzIHRvIGJlIHRyYW5zZmVycmVkIGZyb20gc291
cmNlIGhvc3QgdG8gZGVzdGluYXRpb24gaG9zdC4gVGhlcmVmb3JlLCBOQkQgY2xpZW50IG9uIHRo
ZSBzb3VyY2UgaG9zdCBjbG9zZXMgdGhlIGNvbm5lY3Rpb24gdG8gdGhlIE5CRCBzZXJ2ZXIgb24g
dGhlIGRlc3RpbmF0aW9uIGhvc3QuIEJ1dCB3ZSBvYnNlcnZlIHRoYXQgdGhlcmUgYXJlIHN0aWxs
IHNvbWUgZGlydHkgcGFnZXMgYmVpbmcgdHJhbnNmZXJyZWQuDQpDbG9zaW5nIHByZW1hdHVyZWx5
IE5CRCBjb25uZWN0aW9uIHJlc3VsdHMgaW4gQkxPQ0sgSk9CIGVycm9yLg0KSW4gdGhlIFJBTSBt
aWdyYXRpb24gY29kZSAobWlncmF0aW9uL21pZ3JhdGlvbi5jKSwgSeKAmWQgbGlrZSB0byBjaGVj
ayBmb3IgYmxvY2sgbWlycm9yIGpvYuKAmXMgc3RhdHVzIGJlZm9yZSBSQU0gbWlncmF0aW9uIHN0
YXRlIGlzIG1vdmVkIHRvIHByZS1zd2l0Y2hvdmVyLiBJ4oCZbSB1bmFibGUgdG8gZmluZCBhbnkg
YmxvY2sgam9iIHJlbGF0ZWQgY29kZSBpbiBSQU0gbWlncmF0aW9uIGNvZGUuDQoNCkNvdWxkIHNv
bWVvbmUgaGVscCBtZSBmaWd1cmluZyBvdXQgd2hhdCBtaWdodCBiZSBnb2luZyB3cm9uZyBvciBz
dWdnZXN0IGFueSB0cm91Ymxlc2hvb3Rpbmcgc3RlcHMgb3IgYWR2aWNlIHRvIGdldCBhcm91bmQg
dGhlIGlzc3VlPw0KDQpUaGFua3MNCkNoYWtyaQ0KDQoNCg==

--_000_1ABDAA2B85824B9881D38F71DE62718Cakamaicom_
Content-Type: text/html; charset="utf-8"
Content-ID: <C9EE4857A7897E469EF8B8780ED1A7B5@akamai.com>
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6bz0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6b2ZmaWNlIiB4
bWxuczp3PSJ1cm46c2NoZW1hcy1taWNyb3NvZnQtY29tOm9mZmljZTp3b3JkIiB4bWxuczptPSJo
dHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL29mZmljZS8yMDA0LzEyL29tbWwiIHhtbG5zPSJo
dHRwOi8vd3d3LnczLm9yZy9UUi9SRUMtaHRtbDQwIj4NCjxoZWFkPg0KPG1ldGEgaHR0cC1lcXVp
dj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPg0KPG1l
dGEgbmFtZT0iR2VuZXJhdG9yIiBjb250ZW50PSJNaWNyb3NvZnQgV29yZCAxNSAoZmlsdGVyZWQg
bWVkaXVtKSI+DQo8c3R5bGU+PCEtLQ0KLyogRm9udCBEZWZpbml0aW9ucyAqLw0KQGZvbnQtZmFj
ZQ0KCXtmb250LWZhbWlseToiQ2FtYnJpYSBNYXRoIjsNCglwYW5vc2UtMToyIDQgNSAzIDUgNCA2
IDMgMiA0O30NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6QXB0b3M7DQoJcGFub3NlLTE6MiAx
MSAwIDQgMiAyIDIgMiAyIDQ7fQ0KLyogU3R5bGUgRGVmaW5pdGlvbnMgKi8NCnAuTXNvTm9ybWFs
LCBsaS5Nc29Ob3JtYWwsIGRpdi5Nc29Ob3JtYWwNCgl7bWFyZ2luOjBpbjsNCglmb250LXNpemU6
MTEuMHB0Ow0KCWZvbnQtZmFtaWx5OiJBcHRvcyIsc2Fucy1zZXJpZjsNCgltc28tbGlnYXR1cmVz
OnN0YW5kYXJkY29udGV4dHVhbDt9DQpzcGFuLkVtYWlsU3R5bGUxNw0KCXttc28tc3R5bGUtdHlw
ZTpwZXJzb25hbC1jb21wb3NlOw0KCWZvbnQtZmFtaWx5OiJBcHRvcyIsc2Fucy1zZXJpZjsNCglj
b2xvcjp3aW5kb3d0ZXh0O30NCi5Nc29DaHBEZWZhdWx0DQoJe21zby1zdHlsZS10eXBlOmV4cG9y
dC1vbmx5Ow0KCWZvbnQtc2l6ZToxMS4wcHQ7fQ0KQHBhZ2UgV29yZFNlY3Rpb24xDQoJe3NpemU6
OC41aW4gMTEuMGluOw0KCW1hcmdpbjoxLjBpbiAxLjBpbiAxLjBpbiAxLjBpbjt9DQpkaXYuV29y
ZFNlY3Rpb24xDQoJe3BhZ2U6V29yZFNlY3Rpb24xO30NCi0tPjwvc3R5bGU+DQo8L2hlYWQ+DQo8
Ym9keSBsYW5nPSJFTi1VUyIgbGluaz0iIzQ2Nzg4NiIgdmxpbms9IiM5NjYwN0QiIHN0eWxlPSJ3
b3JkLXdyYXA6YnJlYWstd29yZCI+DQo8ZGl2IGNsYXNzPSJXb3JkU2VjdGlvbjEiPg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+SGVsbG8sPG86cD48L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPknigJltIGhhdmlu
ZyB0cm91YmxlIHdpdGggbGl2ZSBtaWdyYXRpb24gYW5kIEnigJltIHVzaW5nIFFFTVUgNy4yLjAg
b24gRGViaWFuIDExLjxvOnA+PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4m
bmJzcDs8L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5NaWdyYXRpb24gc3RhdGUgc3dp
dGNoZXMgdG8gcHJlLXN3aXRjaG92ZXIgc3RhdGUgZHVyaW5nIHRoZSBSQU0gbWlncmF0aW9uLjxv
OnA+PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5NeSBhc3N1bXB0aW9uIGlzIHRoYXQgZGlza3MgYXJlIGFs
cmVhZHkgbWlncmF0ZWQgYW5kIHRoZXJlIGFyZSBubyBmdXJ0aGVyIGRpcnR5IHBhZ2VzIHRvIGJl
IHRyYW5zZmVycmVkIGZyb20gc291cmNlIGhvc3QgdG8gZGVzdGluYXRpb24gaG9zdC4gVGhlcmVm
b3JlLCBOQkQgY2xpZW50IG9uIHRoZSBzb3VyY2UgaG9zdCBjbG9zZXMgdGhlIGNvbm5lY3Rpb24g
dG8gdGhlIE5CRCBzZXJ2ZXIgb24gdGhlIGRlc3RpbmF0aW9uDQogaG9zdC4gQnV0IHdlIG9ic2Vy
dmUgdGhhdCB0aGVyZSBhcmUgc3RpbGwgc29tZSBkaXJ0eSBwYWdlcyBiZWluZyB0cmFuc2ZlcnJl
ZC4gPG86cD4NCjwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkNsb3NpbmcgcHJlbWF0
dXJlbHkgTkJEIGNvbm5lY3Rpb24gcmVzdWx0cyBpbiBCTE9DSyBKT0IgZXJyb3IuPG86cD48L286
cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPjwvbzpwPjwvcD4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPkluIHRoZSBSQU0gbWlncmF0aW9uIGNvZGUgKG1pZ3JhdGlvbi9taWdyYXRpb24u
YyksIEnigJlkIGxpa2UgdG8gY2hlY2sgZm9yIGJsb2NrIG1pcnJvciBqb2LigJlzIHN0YXR1cyBi
ZWZvcmUgUkFNIG1pZ3JhdGlvbiBzdGF0ZSBpcyBtb3ZlZCB0byBwcmUtc3dpdGNob3Zlci4gSeKA
mW0gdW5hYmxlIHRvIGZpbmQgYW55IGJsb2NrIGpvYiByZWxhdGVkIGNvZGUgaW4gUkFNIG1pZ3Jh
dGlvbiBjb2RlLjxvOnA+PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJz
cDs8L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5Db3VsZCBzb21lb25lIGhlbHAgbWUg
ZmlndXJpbmcgb3V0IHdoYXQgbWlnaHQgYmUgZ29pbmcgd3Jvbmcgb3Igc3VnZ2VzdCBhbnkgdHJv
dWJsZXNob290aW5nIHN0ZXBzIG9yIGFkdmljZSB0byBnZXQgYXJvdW5kIHRoZSBpc3N1ZT88bzpw
PjwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+VGhhbmtzPG86cD48L286cD48L3A+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj5DaGFrcmk8bzpwPjwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+
Jm5ic3A7PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48
L3A+DQo8L2Rpdj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_1ABDAA2B85824B9881D38F71DE62718Cakamaicom_--

