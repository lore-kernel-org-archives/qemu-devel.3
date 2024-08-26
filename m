Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E6BC5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 19:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sif1y-0004yF-Eq; Mon, 26 Aug 2024 15:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carisett@akamai.com>)
 id 1sif1v-0004uA-Qm; Mon, 26 Aug 2024 15:05:32 -0400
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carisett@akamai.com>)
 id 1sif1u-0004ZE-18; Mon, 26 Aug 2024 15:05:31 -0400
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
 by mx0b-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QDVMP4026615;
 Mon, 26 Aug 2024 20:05:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=AUt3JrFgwOnAVgh9Zc2GhBeaTrlIfi4poDe+97a3Y6k=; b=
 iL5qttLKTp86VmEn4ST4guv7uynOAt2MGL8NovePnR2jZ/B4HB2hbsfOwrDa35un
 0LYVx79rj4Yx9dSYxYeX70mAFjgtldFqCEl5TfGFfzZlRJsl39rij1/Rg6T1s/dk
 9N1lIUfExz1026N7A1tnlEDXsbADK+iopejSpPAPaP0q6beJoPx/pcZX0EZoso1q
 GQG9eScXJzl/zWrhDWyNDgOP1y8pRiv1KGzLLYRLebZBlO+Yiz7bBMsRRpq+9ovN
 7GMV/7bWgI+gT4PgXf3yZ7bngjcLBgd6CuKyAcW3oXtT+W+D+iZMAbqAkyWlTEC+
 QLVbUNxKIId0NoBe7Hq/fA==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60]
 (may be forged))
 by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 417969wpsq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Aug 2024 20:05:24 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
 by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 47QIcCvQ008679; Mon, 26 Aug 2024 12:05:24 -0700
Received: from email.msg.corp.akamai.com ([172.27.91.27])
 by prod-mail-ppoint5.akamai.com (PPS) with ESMTPS id 417dgb22gh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Aug 2024 12:05:23 -0700
Received: from usma1ex-dag4mb8.msg.corp.akamai.com (172.27.91.27) by
 usma1ex-dag4mb8.msg.corp.akamai.com (172.27.91.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Aug 2024 15:05:23 -0400
Received: from usma1ex-dag4mb8.msg.corp.akamai.com ([172.27.91.27]) by
 usma1ex-dag4mb8.msg.corp.akamai.com ([172.27.91.27]) with mapi id
 15.02.1544.011; Mon, 26 Aug 2024 15:05:23 -0400
From: "Arisetty, Chakri" <carisett@akamai.com>
To: Prasad Pandit <ppandit@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake
 <eblake@redhat.com>, "Blew III, Will" <wblewiii@akamai.com>, "Massry,
 Abraham" <amassry@akamai.com>, "Tottenham, Max" <mtottenh@akamai.com>,
 "Greve, Mark" <mgreve@akamai.com>
Subject: Re: Issue with QEMU Live Migration
Thread-Topic: Issue with QEMU Live Migration
Thread-Index: AQHa886FsqX6lMAdoUyRdLRWIRR0PbIyMZ0A//+8fICAAaDsAIABGGiAgAAC7ACAAIZxgIAC2EaAgAGyrYCAAAAmgA==
Date: Mon, 26 Aug 2024 19:05:23 +0000
Message-ID: <0800E26B-42EB-4E45-97BD-F7D6461D8131@akamai.com>
References: <1ABDAA2B-8582-4B98-81D3-8F71DE62718C@akamai.com>
 <874j7e0yjt.fsf@suse.de> <ACB0E3E9-BA69-4EC7-A4EB-3AF2F21D4C8A@akamai.com>
 <874j7czn33.fsf@suse.de> <3587C969-9BDB-4BBD-8A79-3679C3F3801A@akamai.com>
 <A658D108-2EC3-4BA1-900C-4FE9FB498B03@akamai.com> <87ed6fxpv0.fsf@suse.de>
 <5DBD942C-E192-46F8-9E73-20DD0A5D6983@akamai.com>
 <CAE8KmOzMFtw0oMQP2=EeiVic5TaK6dc2Fvy2=kcfp_nRg1bn9w@mail.gmail.com>
In-Reply-To: <CAE8KmOzMFtw0oMQP2=EeiVic5TaK6dc2Fvy2=kcfp_nRg1bn9w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.27.118.139]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E7A71A623443A43B4C0E4EC668B86E4@akamai.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_14,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=733
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260145
X-Proofpoint-GUID: ZDjOZukm_jSiPrw1K44hUGYAdWK3KuC-
X-Proofpoint-ORIG-GUID: ZDjOZukm_jSiPrw1K44hUGYAdWK3KuC-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_14,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=591
 suspectscore=0
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408260146
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=carisett@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

PiAqIEhvdyBpcyAnaXNzdWUgYmxvY2stam9iLWNhbmNlbCcgY29tbWFuZCBpc3N1ZWQgZXhhY3Rs
eSBhdCB0aGUNCj4gUFJFX1NXSVRDSE9WRVIgc3RhZ2U/IHZpcnNoIGJsb2Nram9iIC0tYWJvcnQ/
DQoNCldlIGFyZSBjdXJyZW50bHkgbm90IHVzaW5nIGxpYnZpcnQvdmlyc2ggdG8gaXNzdWUgUU1Q
IGNvbW1hbmQuIE91ciBzb2Z0d2FyZSBtYWtlcyB1cCBRTVAgY29ubmVjdGlvbiBhbmQgc2VuZHMg
dGhlIFFNUCBjb21tYW5kIHRvIGNhbmNlbCB0aGUgam9iIHdoZW4gUkFNIG1pZ3JhdGlvbiBzdGF0
ZSBpcyBpbiBwcmUtc3dpdGNob3Zlci4NCg0KcWVtdV9ibG9ja2Rldl9jYW5jZWwoJHVzZXIsICJu
b2RlLXNzY2ktZGlzay0wIik7DQoNCnN1YiBxZW11X2Jsb2NrZGV2X2NhbmNlbCB7DQogICAgbXkg
JHVzZXIgICA9IHNoaWZ0Ow0KICAgIG15ICRkZXZpY2UgPSBzaGlmdDsNCg0KICAgIHJldHVybiBx
ZW11X2NvbnRyb2woDQogICAgICAgICR1c2VyLA0KICAgICAgICB7DQogICAgICAgICAgICAiZXhl
Y3V0ZSIgICA9PiAiYmxvY2stam9iLWNhbmNlbCIsDQogICAgICAgICAgICAiYXJndW1lbnRzIiA9
PiB7DQogICAgICAgICAgICAgICAgImRldmljZSIgPT4gJGRldmljZSwNCiAgICAgICAgICAgIH0N
CiAgICAgICAgfQ0KICAgICk7DQp9DQoNCj4qIFJlY2VudGx5IGEgcG9zdGNvcHkgaXNzdWUsIHdo
ZXJlaW4gdGhlIG1pZ3JhdGVkIGd1ZXN0IG9uIHRoZQ0KPiBkZXN0aW5hdGlvbiBtYWNoaW5lIGhh
bmdzIHNvbWV0aW1lcyB3aXRoIG1pZ3JhdGUtcG9zdGNvcHkgYnV0IG5vdCB3aXRoDQo+IHZpcnNo
IC0tLXBvc3Rjb3B5LWFmdGVyLXByZWNvcHkuIEl0IHNlZW1zIHZpcnNoKDEpIGhhbmRsZXMgdGhl
IHN3aXRjaA0KPiBiZXR0ZXIuIFdvbmRlcmluZyBpZiBpdCdzIHNpbWlsYXIgd2l0aCAnYmxvY2st
am9iLWNhbmNlbCcuDQoNClRoYW5rIHlvdSBmb3IgdGhlIHBvaW50ZXIsIHdlIGFyZSBjdXJyZW50
bHkgdXNpbmcgcHJlLXN3aXRjaG92ZXIuIElJIHdpbGwgbG9vayBtb3JlIGludG8gbGlidmlydCBh
cyBob3cgaXQgaXMgaW1wbGVtZW50ZWQuDQoNClRoYW5rcw0KQ2hha3JpDQoNCg0K77u/T24gOC8y
Ni8yNCwgNTowNSBBTSwgIlByYXNhZCBQYW5kaXQiIDxwcGFuZGl0QHJlZGhhdC5jb20gPG1haWx0
bzpwcGFuZGl0QHJlZGhhdC5jb20+PiB3cm90ZToNCg0KDQohLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNClRoaXMgTWVz
c2FnZSBJcyBGcm9tIGFuIEV4dGVybmFsIFNlbmRlcg0KVGhpcyBtZXNzYWdlIGNhbWUgZnJvbSBv
dXRzaWRlIHlvdXIgb3JnYW5pemF0aW9uLg0KfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQoNCg0KT24gU3VuLCAyNSBB
dWcgMjAyNCBhdCAyMjo0MCwgQXJpc2V0dHksIENoYWtyaSA8Y2FyaXNldHRAYWthbWFpLmNvbSA8
bWFpbHRvOmNhcmlzZXR0QGFrYW1haS5jb20+PiB3cm90ZToNCj4gPiAtIHN0YXJ0IHRoZSBtaXJy
b3Igam9iDQo+ID4gLSBxbXBfbWlncmF0ZQ0KPiA+IC0gb25jZSBQUkVfU1dJVENIT1ZFUiBpcyBy
ZWFjaGVkLCBpc3N1ZSBibG9jay1qb2ItY2FuY2VsDQo+ID4gLSBxbXBfbWlncmF0ZV9jb250aW51
ZQ0KPg0KPiBXZSB1c2UgZXhhY3Qgc2FtZSBzdGVwcyB0byBkbyBsaXZlIG1pZ3JhdGlvbi4gSSBy
ZXBlYXRlZCB0aGUgdGVzdCBub3cNCj4NCj4gU3VyZSwgYXMgeW91IHN1Z2dlc3RlZCB0byBydWxl
IG91dCBhbnkgaW5jb3JyZWN0IHVzYWdlLCBJIHJlcGVhdGVkIHRoZSB0ZXN0IHdpdGggYWJvdmUg
c3RlcHMuDQo+IG9uY2UgUkFNIG1pZ3JhdGlvbiBzdGF0ZSBtb3ZlZCB0byBwcmUtc3dpdGNob3Zl
ciwgaXNzdWVkIGJsb2NrLWpvYi1jYW5jZWwuIFRoZXJlIGFyZSBubyBtb3JlIGRpcnR5IGJsb2Nr
cy4NCj4gQnV0IGFsbCB0aGUgZGlzayB3cml0ZXMgZnJvbSAncHJlLXN3aXRjaG92ZXInIHN0YXRl
IHRvICdjb21wbGV0ZScgc3RhdGUgYXJlIGxvc3QuDQo+IFRodXMsIGl0IGlzIGNyZWF0aW5nIGxv
c3Mgb2YgY3VzdG9tZXIgZGF0YS4NCj4NCg0KDQoqIEhvdyBpcyAnaXNzdWUgYmxvY2stam9iLWNh
bmNlbCcgY29tbWFuZCBpc3N1ZWQgZXhhY3RseSBhdCB0aGUNClBSRV9TV0lUQ0hPVkVSIHN0YWdl
PyB2aXJzaCBibG9ja2pvYiAtLWFib3J0Pw0KDQoNCiogUmVjZW50bHkgYSBwb3N0Y29weSBpc3N1
ZSwgd2hlcmVpbiB0aGUgbWlncmF0ZWQgZ3Vlc3Qgb24gdGhlDQpkZXN0aW5hdGlvbiBtYWNoaW5l
IGhhbmdzIHNvbWV0aW1lcyB3aXRoIG1pZ3JhdGUtcG9zdGNvcHkgYnV0IG5vdCB3aXRoDQp2aXJz
aCAtLS1wb3N0Y29weS1hZnRlci1wcmVjb3B5LiBJdCBzZWVtcyB2aXJzaCgxKSBoYW5kbGVzIHRo
ZSBzd2l0Y2gNCmJldHRlci4gV29uZGVyaW5nIGlmIGl0J3Mgc2ltaWxhciB3aXRoICdibG9jay1q
b2ItY2FuY2VsJy4NCg0KDQpUaGFuayB5b3UuDQotLS0NCi0gUHJhc2FkDQoNCg0KDQoNCg0K

