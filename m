Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F57C021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 20:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkqpL-0002HW-5i; Wed, 19 Feb 2025 15:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1tkoIc-0007Wt-DG
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 12:55:56 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1tkoIZ-0001MX-Hl
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 12:55:53 -0500
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
 by m0050096.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id
 51J7iYnv017740; Wed, 19 Feb 2025 17:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=jan2016.eng; bh=HSB/oijyq
 feyYkTkpbZqGpPN0tKipFjdC52//K8cS+0=; b=dpWfHeYcPpr3pToyU1rfxa6m6
 /QDL8k2PZcIfD+idq6gy0ugQxTBcE+KLL37jFHvUM89SI+ceLfCZDbETbGXFcEog
 C/gcGNaQUeGWwLEvdLChDVlNotyrv+Age2th/sdErZD9VEIWFQNdyF1MV+rm3sda
 ++f0XBaoLuHh6GAGl1Sd2V4VU51U8RYIW7IEGT3+tehPXT63xb4YP5ObhCf3zXX3
 50UTtleSmq4t2AvKex1KuvoHjDiTcxtQw1+IvMTuzNA086ShNh8tltMcv1dUSE8p
 3y4XJf9ncs3OwPsFQJ6eMw0nxXgUaT3bPrlBGjUTcNAPJV3YS33ndxUtt7bAg==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19]
 (may be forged))
 by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 44w00dgvpw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 17:55:42 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
 by prod-mail-ppoint2.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 51JC9qcc024644; Wed, 19 Feb 2025 12:55:41 -0500
Received: from email.msg.corp.akamai.com ([172.27.91.26])
 by prod-mail-ppoint2.akamai.com (PPS) with ESMTPS id 44w01a3bgd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 12:55:41 -0500
Received: from usma1ex-dag4mb1.msg.corp.akamai.com (172.27.91.20) by
 usma1ex-dag4mb7.msg.corp.akamai.com (172.27.91.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 12:55:41 -0500
Received: from usma1ex-dag4mb1.msg.corp.akamai.com ([172.27.91.20]) by
 usma1ex-dag4mb1.msg.corp.akamai.com ([172.27.91.20]) with mapi id
 15.02.1544.014; Wed, 19 Feb 2025 12:55:41 -0500
From: "Chaney, Ben" <bchaney@akamai.com>
To: "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "armbru@redhat.com" <armbru@redhat.com>,
 "Glasgall, Anna" <aglasgal@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>,
 "Tottenham, Max" <mtottenh@akamai.com>
Subject: Live update: q35 and pc-i440fx support (vapic)
Thread-Topic: Live update: q35 and pc-i440fx support (vapic)
Thread-Index: AQHbgvd9Os1PgnTF8Umh4WvElKCc/g==
Date: Wed, 19 Feb 2025 17:55:41 +0000
Message-ID: <6290683B-76B5-42E1-AA17-1F3AC58FE9D7@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.27.164.43]
Content-Type: text/plain; charset="utf-8"
Content-ID: <75F82B13CD80F74AA303273F4008510D@akamai.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502190138
X-Authority-Analysis: v=2.4 cv=FIThx/os c=1 sm=1 tr=0 ts=67b61b1e cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=tuSJzH7BKwkA:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10
 a=bl9zty5O79DVsP0N3EYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eyPuUE2rrIYwQnOhXNpsJjhywSKcNguC
X-Proofpoint-ORIG-GUID: eyPuUE2rrIYwQnOhXNpsJjhywSKcNguC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 impostorscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502190139
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Feb 2025 15:37:46 -0500
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

SGVsbG8gU3RldmUsDQoNClRoYW5rIHlvdSBmb3IgcG9zdGluZyB0aGUgcWVtdSBjcHItdHJhbnNm
ZXIgcGF0Y2hlcyBvbiBxZW11LWRldmVsLiBJIGFtIGV4cGVyaW1lbnRpbmcgd2l0aCB0aGVtLCBh
bmQgSSBub3RpY2VkIHRoYXQgY3ByLXRyYW5zZmVyIGlzIGZhaWxpbmcgb24gc29tZSBxZW11IG1h
Y2hpbmUgdHlwZXMuIGNwci10cmFuc2ZlciBpcyB3b3JraW5nIGZvciBtZSBvbiB0aGUgbWljcm92
bSBtYWNoaW5lIHR5cGUgYnV0IGZhaWxpbmcgb24gcTM1IGFuZCBwYy1pNDQwZnguIFdoZW4gcnVu
bmluZyBpbiB0aG9zZSBjb25maWd1cmF0aW9ucyBJIGdldCB0aGUgZm9sbG93aW5nIGVycm9yIG9u
IHRoZSBuZXcgcWVtdSBwcm9jZXNzOg0KDQoNCiAgICBxZW11LXN5c3RlbS14ODZfNjQ6IGVycm9y
IHdoaWxlIGxvYWRpbmcgc3RhdGUgZm9yIGluc3RhbmNlIDB4MCBvZiBkZXZpY2UgJ2t2bS10cHIt
b3B0Jw0KICAgIDIwMjUtMDItMThUMTQ6NDY6NTIuNTUwMzE5WiBxZW11LXN5c3RlbS14ODZfNjQ6
IGxvYWQgb2YgbWlncmF0aW9uIGZhaWxlZDogT3BlcmF0aW9uIG5vdCBwZXJtaXR0ZWQNCg0KVGhl
IGlzc3VlIG9jY3VycyB3aGVuIGluaXRpYWxpemluZyB0aGUgdmFwaWMgZGV2aWNlIGluIHRoZSBu
ZXcgcWVtdSBwcm9jZXNzLiBJbiB2YXBpY19tYXBfcm9tX3dyaXRhYmxlLCByb21fc2l6ZSBpcyBz
ZXQgdG8gemVyby4gVGhpcyBjYXVzZXMgdGhlIGZvbGxvd2luZyBjb25kaXRpb24gdG8gYmUgdHJp
Z2dlcmVkOg0KDQogICAgcmFtID0gbWVtb3J5X3JlZ2lvbl9nZXRfcmFtX3B0cihzZWN0aW9uLm1y
KTsNCiAgICByb21fc2l6ZSA9IHJhbVtyb21fcGFkZHIgKyAyXSAqIFJPTV9CTE9DS19TSVpFOw0K
ICAgIGlmIChyb21fc2l6ZSA9PSAwKSB7DQogICAgcmV0dXJuIC0xOw0KICAgIH0NCg0KVGhpcyBv
Y2N1cnMgb24gdGhlIHFlbXUgbWFzdGVyIGJyYW5jaCAodGVzdGVkIG9uIGNvbW1pdCA5NzM2ZWUz
ODJlOTVlYWQwNmE4MzhmZTBiMDQ5OGUwY2IzODQ1MjcwKSB3aXRoIHRoZSBmb2xsb3dpbmcgcWVt
dSBjb21tYW5kIGxpbmUgb3B0aW9uczoNCg0KVGVybWluYWwgMToNCg0KICAgIC9vcHQvcWVtdS1i
dWlsZC9iaW4vcWVtdS1zeXN0ZW0teDg2XzY0IC1ub2dyYXBoaWMgLWNwdSBob3N0LG1pZ3JhdGFi
bGU9eWVzLC12bXgsLXN2bSxpbnZwY2lkPW9mZiAtZGlzcGxheSB2bmM9dW5peDovb3B0L2JjaGFu
ZXktdG1wL3ZuYy5zb2NrZXQgLWVuYWJsZS1rdm0gLW5hbWUgYmNoYW5leV90ZXN0MSxkZWJ1Zy10
aHJlYWRzPW9uIC1zbXAgNCAtb2JqZWN0IG1lbW9yeS1iYWNrZW5kLWZpbGUsaWQ9cmFtMCxzaXpl
PTRHLG1lbS1wYXRoPS9kZXYvc2htL3JhbTAsc2hhcmU9b24gLW0gNEcgLW1hY2hpbmUgYXV4LXJh
bS1zaGFyZT1vbiAtcnRjIGNsb2NrPXZtIC1uby11c2VyLWNvbmZpZyAtbm9kZWZhdWx0cyAtbXNn
IHRpbWVzdGFtcD1vbiAtYmlvcyAvb3B0L2xpbm9kZS1zZWFiaW9zL3JvbXMvYmlvcy5iaW4gLW1h
Y2hpbmUgcTM1LGFjY2VsPWt2bSAtY2Ryb20gL29wdC9iY2hhbmV5LXRtcC91YnVudHUtMjQuMDQu
MS1saXZlLXNlcnZlci1hbWQ2NC5pc28gLXFtcCBzdGRpbw0KDQpUZXJtaW5hbCAyOg0KDQogICAg
L29wdC9xZW11LWJ1aWxkL2Jpbi9xZW11LXN5c3RlbS14ODZfNjQgLW5vZ3JhcGhpYyAtY3B1IGhv
c3QsbWlncmF0YWJsZT15ZXMsLXZteCwtc3ZtLGludnBjaWQ9b2ZmIC1kaXNwbGF5IHZuYz11bml4
Oi9vcHQvYmNoYW5leS10bXAvdm5jLnNvY2tldCAtZW5hYmxlLWt2bSAtbmFtZSBiY2hhbmV5X3Rl
c3QxLGRlYnVnLXRocmVhZHM9b24gLXNtcCA0IC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtZmlsZSxp
ZD1yYW0wLHNpemU9NEcsbWVtLXBhdGg9L2Rldi9zaG0vcmFtMCxzaGFyZT1vbiAtbSA0RyAtbWFj
aGluZSBhdXgtcmFtLXNoYXJlPW9uIC1ydGMgY2xvY2s9dm0gLW5vLXVzZXItY29uZmlnIC1ub2Rl
ZmF1bHRzIC1tc2cgdGltZXN0YW1wPW9uIC1iaW9zIC9vcHQvbGlub2RlLXNlYWJpb3Mvcm9tcy9i
aW9zLmJpbiAtbWFjaGluZSBxMzUsYWNjZWw9a3ZtIC1jZHJvbSAvb3B0L2JjaGFuZXktdG1wL3Vi
dW50dS0yNC4wNC4xLWxpdmUtc2VydmVyLWFtZDY0LmlzbyAtaW5jb21pbmcgJ3siY2hhbm5lbC10
eXBlIjogIm1haW4iLCAiYWRkciI6IHsgInRyYW5zcG9ydCI6ICJzb2NrZXQiLCAidHlwZSI6ICJ1
bml4IiwgInBhdGgiOiAiL29wdC9iY2hhbmV5LXRtcC9tYWluLnNvY2sifX0nIC1pbmNvbWluZyAn
eyJjaGFubmVsLXR5cGUiOiAiY3ByIiwgImFkZHIiOiB7ICJ0cmFuc3BvcnQiOiAic29ja2V0Iiwg
InR5cGUiOiAidW5peCIsICJwYXRoIjogIi9vcHQvYmNoYW5leS10bXAvY3ByLnNvY2sifX0nIC1t
b25pdG9yIHN0ZGlvDQoNClFtcCBjb21tYW5kcyBleGVjdXRlZCAoaW4gVGVybWluYWwgMSk6DQoN
CiAgICB7ImV4ZWN1dGUiOiJxbXBfY2FwYWJpbGl0aWVzIn0NCiAgICB7ImV4ZWN1dGUiOiAicXVl
cnktc3RhdHVzIn0NCiAgICB7ImV4ZWN1dGUiOiJtaWdyYXRlLXNldC1wYXJhbWV0ZXJzIiwNCiAg
ICAgICAiYXJndW1lbnRzIjp7Im1vZGUiOiJjcHItdHJhbnNmZXIifX0NCiAgICB7ImV4ZWN1dGUi
OiAibWlncmF0ZSIsICJhcmd1bWVudHMiOiB7ICJjaGFubmVscyI6IFsNCiAgICAgICAgeyJjaGFu
bmVsLXR5cGUiOiAibWFpbiIsICJhZGRyIjogeyAidHJhbnNwb3J0IjogInNvY2tldCIsICJ0eXBl
IjogInVuaXgiLA0KICAgICAgICAgICAgICAgICAgICJwYXRoIjogIi9vcHQvYmNoYW5leS10bXAv
bWFpbi5zb2NrIn19LCAgICAgICAgICANCiAgICB7ImNoYW5uZWwtdHlwZSI6ICJjcHIiLA0KICAg
ICAgICAgImFkZHIiOiB7ICJ0cmFuc3BvcnQiOiAic29ja2V0IiwgInR5cGUiOiAidW5peCIsDQog
ICAgICAgICAgICAgICAgICAgICJwYXRoIjogIi9vcHQvYmNoYW5leS10bXAvY3ByLnNvY2sifX1d
fX0NCiAgICB7ImV4ZWN1dGUiOiAicXVlcnktc3RhdHVzIn0NCg0KSXMgdGhpcyBhIGhhcmR3YXJl
IGNvbmZpZ3VyYXRpb24gdGhhdCBpcyBjdXJyZW50bHkgaW50ZW5kZWQgdG8gYmUgc3VwcG9ydGVk
PyBJZiBub3QsIHdpbGwgaXQgYmUgc3VwcG9ydGVkIGluIHRoZSBmdXR1cmU/DQoNClRoYW5rIHlv
dSwNCkJlbiBDaGFuZXkNCg0KDQoNCg0KDQoNCg==

