Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0952CC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 13:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYEm-00024H-Dx; Mon, 26 May 2025 09:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJYEj-000247-Ro
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJYEi-0003zp-39
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748267487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nwiMO0GmFW6gURifRC14A8WUqX/PLsbtDIA39chKSXM=;
 b=Y3LrrVJSpm7VLtpd5KTyI4EKSic2NYiUTusc23te2WghKrZUQojAamm4YZVj8ryhNuUZux
 q2dyU7PYi3Q4+wCHYm8Bdo3Llc0l8AcPV01d0GXTpRu5Q/KZLuTIIRtEBMVr7Wqi9ELWq/
 RK1UzqeLyBIr3GYO9lV31BvGyxMSMh4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-nihLdV-JP0S1mB0uQIMi2Q-1; Mon,
 26 May 2025 09:51:23 -0400
X-MC-Unique: nihLdV-JP0S1mB0uQIMi2Q-1
X-Mimecast-MFC-AGG-ID: nihLdV-JP0S1mB0uQIMi2Q_1748267482
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 846BB180048E; Mon, 26 May 2025 13:51:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C60071956095; Mon, 26 May 2025 13:51:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7006B21E675E; Mon, 26 May 2025 15:51:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Bernhard Beschow
 <shentey@gmail.com>,  Igor Mammedov <imammedo@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>
Subject: Re: [PATCH 1/4] hw/microblaze: Add endianness property to the
 petalogix_s3adsp1800 machine
In-Reply-To: <9f5fddbd-8989-4549-af89-87a19cb68a19@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sun, 25 May 2025 21:09:58
 +0200")
References: <20250515132019.569365-1-thuth@redhat.com>
 <20250515132019.569365-2-thuth@redhat.com>
 <00ec097f-b43a-4831-b4b6-c5d20aac236f@linaro.org>
 <9f5fddbd-8989-4549-af89-87a19cb68a19@linaro.org>
Date: Mon, 26 May 2025 15:51:19 +0200
Message-ID: <87o6vfzdig.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPiB3cml0ZXM6DQoNCj4g
K01hcmt1cw0KPg0KPiBPbiAyNC81LzI1IDEzOjU1LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToN
Cj4+IE9uIDUvMTUvMjUgMTQ6MjAsIFRob21hcyBIdXRoIHdyb3RlOg0KPj4+ICtzdGF0aWMgaW50
IG1hY2hpbmVfZ2V0X2VuZGlhbm5lc3MoT2JqZWN0ICpvYmosIEVycm9yICoqZXJycCBHX0dOVUNf
VU5VU0VEKQ0KPj4+ICt7DQo+Pj4gK8KgwqDCoCBTM0Fkc3AxODAwTWFjaGluZVN0YXRlICptcyA9
IFBFVEFMT0dJWF9TM0FEU1AxODAwX01BQ0hJTkUob2JqKTsNCj4+PiArwqDCoMKgIHJldHVybiBt
cy0+ZW5kaWFubmVzczsNCj4+PiArfQ0KPj4+ICsNCj4+PiArc3RhdGljIHZvaWQgbWFjaGluZV9z
ZXRfZW5kaWFubmVzcyhPYmplY3QgKm9iaiwgaW50IGVuZGlhbm5lc3MsIEVycm9yICoqZXJycCkN
Cj4+PiArew0KPj4+ICvCoMKgwqAgUzNBZHNwMTgwME1hY2hpbmVTdGF0ZSAqbXMgPSBQRVRBTE9H
SVhfUzNBRFNQMTgwMF9NQUNISU5FKG9iaik7DQo+Pj4gK8KgwqDCoCBtcy0+ZW5kaWFubmVzcyA9
IGVuZGlhbm5lc3M7DQo+Pj4gK30NCj4+PiArDQo+Pj4gwqAgc3RhdGljIHZvaWQgcGV0YWxvZ2l4
X3MzYWRzcDE4MDBfbWFjaGluZV9jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywNCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IHZvaWQg
KmRhdGEpDQo+Pj4gwqAgew0KPj4+IMKgwqDCoMKgwqAgTWFjaGluZUNsYXNzICptYyA9IE1BQ0hJ
TkVfQ0xBU1Mob2MpOw0KPj4+ICvCoMKgwqAgT2JqZWN0UHJvcGVydHkgKnByb3A7DQo+Pj4gwqDC
oMKgwqDCoCBtYy0+ZGVzYyA9ICJQZXRhTG9naXggbGludXggcmVmZGVzaWduIGZvciB4aWxpbngg
U3BhcnRhbiAzQURTUDE4MDAiOw0KPj4+IMKgwqDCoMKgwqAgbWMtPmluaXQgPSBwZXRhbG9naXhf
czNhZHNwMTgwMF9pbml0Ow0KPj4+IMKgwqDCoMKgwqAgbWMtPmlzX2RlZmF1bHQgPSB0cnVlOw0K
Pj4+ICsNCj4+PiArwqDCoMKgIHByb3AgPSBvYmplY3RfY2xhc3NfcHJvcGVydHlfYWRkX2VudW0o
b2MsICJlbmRpYW5uZXNzIiwgIkVuZGlhbk1vZGUiLA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICZFbmRpYW5Nb2RlX2xvb2t1cCwNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBtYWNoaW5lX2dldF9lbmRpYW5uZXNzLA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG1hY2hpbmVfc2V0X2VuZGlhbm5lc3MpOw0KPj4+ICvCoMKgwqAgb2JqZWN0X3Byb3BlcnR5X3Nl
dF9kZWZhdWx0X3N0cihwcm9wLCBUQVJHRVRfQklHX0VORElBTiA/ICJiaWciIDogImxpdHRsZSIp
Ow0KPj4+ICvCoMKgwqAgb2JqZWN0X2NsYXNzX3Byb3BlcnR5X3NldF9kZXNjcmlwdGlvbihvYywg
ImVuZGlhbm5lc3MiLA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJEZWZpbmVzIHdoZXRo
ZXIgdGhlIG1hY2hpbmUgcnVucyBpbiBiaWcgb3IgbGl0dGxlIGVuZGlhbiBtb2RlIik7DQo+PiBC
ZXR0ZXIgd2l0aCBQcm9wZXJ0eT/CoCBZb3UgZG9uJ3QgaGF2ZSB0byB3cml0ZSBnZXQvc2V0Li4u
DQo+PiAgwqAgc3RhdGljIGNvbnN0IFByb3BlcnR5IHByb3BzW10gPSB7DQo+PiAgwqDCoMKgIERF
RklORV9QUk9QX0VORElBTigiZW5kaWFubmVzcyIsIFMzQWRzcDE4MDBNYWNoaW5lU3RhdGUsIGVu
ZGlhbm5lc3MsDQo+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgVEFSR0VUX0JJR19FTkRJQU4gPyBFTkRJQU5fTU9ERV9CSUcgOiBFTkRJQU5fTU9ERV9MSVRU
TEUpLA0KPj4gIMKgIH07DQo+PiAgwqAgZGV2aWNlX2NsYXNzX3NldF9wcm9wcyhkYywgcHJvcHMp
Ow0KPg0KPiBERUZJTkVfUFJPUF9GT08oKSBhcmUgcmVzdHJpY3RlZCB0byBRRGV2IChEZXZpY2VD
bGFzcykuIEhlcmUgd2UgaGF2ZQ0KPiBhIE1hY2hpbmVDbGFzcywgd2hpY2ggb25seSBpbmhlcml0
cyBPYmplY3RDbGFzcywgbm90IERldmljZUNsYXNzLg0KPg0KPiBNYXJrdXMgb25jZSBleHBsYWlu
ZWQgbWUgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiBRRGV2IHByb3BlcnRpZXMNCj4gYW5kIGJhcmUg
b2JqZWN0IG9uZXM7IEkgYXNrZWQgd2h5IHdlIGNvdWxkbid0IG1ha2UgcWRldiBwcm9wZXJ0aWVz
DQo+IGdlbmVyaWMgdG8gb2JqZWN0cywgYnV0IEkgZG9uJ3QgcmVtZW1iZXIgdGhlIGhpc3Rvcmlj
YWwgcmF0aW9uYWxlLg0KPiBRRGV2IHByZWRhdGVzIFFPTSwgUURldiB1c2VkIHN0YXRpYyBwcm9w
ZXJ0aWVzLCBRT00gaW50cm9kdWNlZA0KPiBkeW5hbWljIG9uZXM/IFdlIGRlZmluaXRpdmVseSBz
aG91bGQgZG9jdW1lbnQgdGhhdC4uLg0KDQpZZXMuDQoNClFkZXYgcHJvcGVydGllcyBhcmUgZGVm
aW5lZCBpbiBkYXRhIGF0IGNvbXBpbGUgdGltZSwgYW5kIGFyZSBjb25uZWN0ZWQNCnRvIHRoZSBk
ZXZpY2UgY2xhc3MuICBTcGVjaWZpY2FsbHksIGEgRGV2aWNlQ2xhc3MgaGFzIGFuIGFycmF5IG9m
DQpQcm9wZXJ0eSwgd2hlcmUgZWFjaCBlbGVtZW50IHNwZWNpZmllcyBhIHByb3BlcnR5IG9mIGl0
cyBEZXZpY2VTdGF0ZQ0KaW5zdGFuY2VzLiAgVGhlIGFycmF5IG5ldmVyIGNoYW5nZXMuDQoNClRo
ZSBERUZJTkVfUFJPUF9GT08oKSBtYWNyb3MgZXhwYW5kIGludG8gUHJvcGVydHkgbGl0ZXJhbHMg
c3VpdGFibGUgZm9yDQp0aGUgYXJyYXkuICBCb2lsZXJwbGF0ZSBpcyByZWxhdGl2ZWx5IGxpZ2h0
OiBubyBuZWVkIHRvIHdyaXRlIHNldHRlcnMgb3INCmdldHRlcnMgdW5sZXNzIHlvdSBkZWZpbmUg
YSBuZXcgRk9PLg0KDQpRT00gcHJvcGVydGllcyBhcmUgZGVmaW5lZCBpbiBjb2RlIGF0IHJ1bnRp
bWUsIGFuZCBhcmUgY29ubmVjdGVkIHRvIHRoZQ0KT2JqZWN0LCBpLmUuIHRoZSBpbnN0YW5jZSwg
bm90IHRoZSBjbGFzcy4gIFRoZXkgc2hvdWxkIGJlIGNyZWF0ZWQgaW4NCi5pbnN0YW5jZV9pbml0
KCksIGJ1dCBub3RoaW5nIHByZXZlbnRzIGNyZWF0aW9uIGVsc2V3aGVyZS4gIE1vc3Qgb2YgdGhl
DQp0aW1lLCB3ZSBjcmVhdGUgdGhlIGV4YWN0IHNhbWUgcHJvcGVydGllcyBmb3IgYWxsIGluc3Rh
bmNlcyBvZiBhbg0KT2JqZWN0Q2xhc3MsIGJ1dCBub3QgYWx3YXlzLg0KDQpEZWZpbmluZyBwcm9w
ZXJ0aWVzIGF0IHJ1bnRpbWUgaXMgbW9yZSBmbGV4aWJsZSB0aGFuIGRlZmluaW5nIHRoZW0gaW4N
CmRhdGEgYXQgY29tcGlsZSB0aW1lLiAgSG93ZXZlcjoNCg0KKiBTdGF0aWMgZGF0YSBpcyBtdWNo
IGVhc2llciB0byByZWFzb24gYWJvdXQgdGhhbiBiZWhhdmlvciBvZiBjb2RlLg0KICBRZGV2IHBy
b3BlcnRpZXMgYXJlIHN0YXRpY2FsbHkga25vd24uICBkZXZpY2VfYWRkIEZPTyxoZWxwIGNhbg0K
ICByZWxpYWJseSBzaG93IHRoZW06IGl0IGR1bXBzIHRoZSB1bmNoYW5naW5nIGFycmF5LiAgUU9N
IHByb3BlcnRpZXMgY2FuDQogIGJlIGRpZmZlcmVudCBlYWNoIHRpbWUgeW91IGNyZWF0ZSBhbiBv
YmplY3QuICBkZXZpY2VfYWRkIEZPTyxoZWxwDQogIG5lZWRzIHRvIGNyZWF0ZSBhIHRlbXBvcmFy
eSBpbnN0YW5jZSwgYW5kIGR1bXBzIHdoYXRldmVyIHByb3BlcnRpZXMNCiAgdGhpcyBpbnN0YW5j
ZSBnb3QuICBUaGUgbmV4dCBpbnN0YW5jZSBtYXkgZ2V0IGRpZmZlcmVudCBvbmVzLg0KDQoqIFRo
ZSBwcm9wZXJ0eSBkZXNjcmlwdGlvbnMgYXJlIGR1cGxpY2F0ZWQgaW4gZXZlcnkgaW5zdGFuY2Us
IHdoaWNoIGlzIGENCiAgd2FzdGUgb2Ygc3BhY2UuICBTZWUgIlFPTSBjbGFzcyBwcm9wZXJ0aWVz
IiBiZWxvdy4NCg0KKiBUaGUgZnVuY3Rpb25zIHRvIGNyZWF0ZSBwcm9wZXJ0aWVzIHRha2UgZ2V0
dGVyIGFuZCBzZXR0ZXIgZnVuY3Rpb25zIGFzDQogIGFyZ3VtZW50cy4gIEZ1bmN0aW9ucyB5b3Ug
Z2V0IHRvIHdyaXRlIGJhc2ljYWxseSBmb3IgZWFjaCBwcm9wZXJ0eS4NCiAgTXVjaCBtb3JlIGJv
aWxlcnBsYXRlIHRoYW4gd2l0aCBxZGV2Lg0KDQpJIGNoYWxsZW5nZWQgdGhlIG5lZWQgZm9yIHRo
aXMgbXVjaCBmbGV4aWJpbGl0eSBhdCB0aGUgdGltZSwgd2l0aG91dA0Kc3VjY2Vzcy4gIFdlIGFj
dHVhbGx5IHVzZSB0aGUgZmxleGliaWxpdHkgb25seSByYXJlbHkuICBJIGJlbGlldmUgdGhpcw0K
YXNwZWN0IG9mIFFPTSdzIGRlc2lnbiB3YXMgYSBtaXN0YWtlLg0KDQpRT00gYWN0dWFsbHkgaGFz
IGEgc2Vjb25kIGtpbmQgb2YgcHJvcGVydHk6IFFPTSBjbGFzcyBwcm9wZXJ0aWVzIGFyZQ0KYWxz
byBkZWZpbmVkIGluIGNvZGUgYXQgcnVudGltZSwgYnV0IGNvbm5lY3RlZCB0byB0aGUgT2JqZWN0
Q2xhc3MuICBUaGV5DQpzaG91bGQgYmUgY3JlYXRlZCBpbiAuY2xhc3NfaW5pdCgpLCBidXQgbm90
aGluZyBwcmV2ZW50cyBjcmVhdGlvbg0KZWxzZXdoZXJlLiAgRGVzcGl0ZSB0aGVpciBuYW1lLCB0
aGV5IGFyZSBwcm9wZXJ0aWVzIG9mIHRoZSBpbnN0YW5jZSwNCmp1c3QgbGlrZSBvcmRpbmFyeSBR
T00gcHJvcGVydGllcy4gIFRoZSBkaWZmZXJlbmNlIGlzIG9ubHkgdGhlIHNoYXJpbmcuDQoNCk1v
c3QgcHJvcGVydGllcyBzaG91bGQgYmUgY2xhc3MgcHJvcGVydGllcywgYnV0IGFyZW4ndC4gIFRo
aXMgaXMgYmVjYXVzZQ0KY2xhc3MgcHJvcGVydGllcyB3ZXJlIGFkZGVkIGxhdGUsIGFuZCBhcmUg
dW5kZXJkb2N1bWVudGVkLg0KDQpRZGV2IGlzIGFjdHVhbGx5IGEgbGVha3kgbGF5ZXIgYWJvdmUg
UU9NLiAgSSBiZWNhbWUgb25lIHdoZW4gd2UgcmViYXNlZA0KaXQgb24gdG9wIG9mIFFPTS4NCg0K
QSBxZGV2J3MgLmluc3RhbmNlX2luaXQoKSBpdGVyYXRlcyBvdmVyIHRoZSBwcm9wZXJ0eSBhcnJh
eSBhbmQgYWRkcyBhDQpRT00gY2xhc3MgcHJvcGVydHkgZm9yIGVhY2ggZWxlbWVudFsqXS4NCg0K
VGhpcyBQcm9wZXJ0eSBwYXJ0IG9mIHFkZXYgaXNuJ3QgYWN0dWFsbHkgZGV2aWNlLXNwZWNpZmlj
LiAgV2UgY291bGQNCmxpZnQgaXQgaW50byBPYmplY3QuICBCdXQgd291bGQgdGhhdCBiZSBhbiBp
bXByb3ZlbWVudD8gIEknbSBub3Qgc3VyZTsNClFPTSBpcyBjb25mdXNpbmcgZW5vdWdoIGFzIGl0
IGlzLg0KDQo+ICAgICAgICAgICAgICAgV2UgZGVmaW5pdGl2ZWx5IHNob3VsZCBkb2N1bWVudCB0
aGF0Li4uDQoNCkkga25vdyBqdXN0IGVub3VnaCBhYm91dCBRT00gdG8gYmUgZGFuZ2Vyb3VzIDop
DQoNCg0KDQpbKl0gSXQgYWxzbyBhZGRzIGEgImxlZ2FjeSBwcm9wZXJ0eSIsIGJ1dCBJIGZvcmdv
dCB3aGF0IHRoYXQgaXMsIGFuZCB3aHkNCml0IGV4aXN0cy4NCg==


