Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C8BD32D9F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 12:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAq7I-0007XE-3x; Tue, 12 Nov 2024 07:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=039b511fc=graf@amazon.de>)
 id 1tAq7G-0007Wg-O9
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 07:35:30 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=039b511fc=graf@amazon.de>)
 id 1tAq7A-00081s-Nd
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 07:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1731414925; x=1762950925;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to;
 bh=mM+p/y2dqoBvIWUAj4Wzbp6fJJIVJrXBYHz9z3USUow=;
 b=n3rnJG+Ftt+u9o8coXCIVdXHWNVhGEkSNyyxX8q+L8drWtK4DOjifKX7
 wol7FC3tuXEc81S6KLRZ+Facis+azAfSp9tpUYp6XsnbfmXOqy+f/ifN7
 Q9p7Kz+2nMYw+OSWaxXLIi5yPju5O7nSMl6Mhujgk4bB5exKC0FqasDI2 s=;
X-IronPort-AV: E=Sophos;i="6.12,148,1728950400"; 
 d="scan'208,217";a="448078605"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
 by smtp-border-fw-6002.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 12:35:18 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:56549]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.163:2525]
 with esmtp (Farcaster)
 id 047c1ff2-05db-47a9-904a-41274633d34e; Tue, 12 Nov 2024 12:35:17 +0000 (UTC)
X-Farcaster-Flow-ID: 047c1ff2-05db-47a9-904a-41274633d34e
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 12:35:17 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Tue, 12 Nov 2024
 12:35:16 +0000
Content-Type: multipart/alternative;
 boundary="------------nSwa3U5k04AZH169j5nCi5Zh"
Message-ID: <2970cc68-a34c-4751-b4a3-d7fac416d7d3@amazon.com>
Date: Tue, 12 Nov 2024 13:35:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] device/virtio-nsm: Support string data for extendPCR
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
CC: <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241109123208.24281-1-dorjoychy111@gmail.com>
 <44fbe3d8-509c-47ad-b764-5c8016980bfe@amazon.com>
 <CAFfO_h5LHsgng5itQTEO30SUT_jn02Pdi-0uYvyZCgRPJfcueA@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAFfO_h5LHsgng5itQTEO30SUT_jn02Pdi-0uYvyZCgRPJfcueA@mail.gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=52.95.49.90;
 envelope-from=prvs=039b511fc=graf@amazon.de; helo=smtp-fw-6002.amazon.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

--------------nSwa3U5k04AZH169j5nCi5Zh
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGV5IERvcmpveSwKCk9uIDEyLjExLjI0IDEzOjMyLCBEb3Jqb3kgQ2hvd2RodXJ5IHdyb3RlOgoK
PiBIZXkgQWxleCwKPgo+Cj4gT24gVHVlLCBOb3YgMTIsIDIwMjQsIDY6MTQgUE0gQWxleGFuZGVy
IEdyYWYgPGdyYWZAYW1hem9uLmNvbT4gd3JvdGU6Cj4KPiAgICAgSGV5IERvcmpveSwKPgo+ICAg
ICBUaGFua3MgYSBsb3QgZm9yIHRoZSBwYXRjaCEgV291bGQgeW91IG1pbmQgdG8gc2VuZCB0byB0
aGUgTUwgc28gaXQKPiAgICAgY2FuCj4gICAgIGdvIHRocm91Z2ggdGhlIG5vcm1hbCByZXZpZXcg
KyBhcHBseSBjeWNsZT8gOikKPgo+ICAgICBTYW1lIGNvbW1lbnQgZm9yIHRoZSBvdGhlciBwYXRj
aGVzLgo+Cj4KPgo+IEkgZG9uJ3QgdW5kZXJzdGFuZC4gSSBzZW50IHRoZW0gdG8gdGhlIG1haWxp
bmcgbGlzdCB0b28sIG5vPyBJIHNlZSB0aGUgCj4gY2MncyBvbiB0aGUgcGF0Y2hlcy4KCgpZb3Ug
ZGlkIGluZGVlZCAtIEknbSBqdXN0IGJsaW5kIDopLiBMZXQgbWUgaGF2ZSBhbm90aGVyIGxvb2sg
YXQgdGhlIAphY3R1YWwgY29udGVudHMgb2YgdGhlIHBhdGNoZXMhCgoKQWxleAoKCgpBbWF6b24g
V2ViIFNlcnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4g
MzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwg
Sm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcg
dW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1MzggNTk3Cg==

--------------nSwa3U5k04AZH169j5nCi5Zh
MIME-Version: 1.0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIGh0bWw+CjxodG1sPgogIDxoZWFkPgogICAgPG1ldGEgaHR0cC1lcXVpdj0iQ29u
dGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9VVRGLTgiPgogIDwvaGVhZD4K
ICA8Ym9keT4KICAgIDxwPkhleSBEb3Jqb3ksPGJyPgogICAgICA8YnI+CiAgICA8L3A+CiAgICA8
ZGl2IGNsYXNzPSJtb3otY2l0ZS1wcmVmaXgiPk9uIDEyLjExLjI0IDEzOjMyLCBEb3Jqb3kgQ2hv
d2RodXJ5CiAgICAgIHdyb3RlOjwvZGl2PgogICAgPGJyPgogICAgPGJsb2NrcXVvdGUgdHlwZT0i
Y2l0ZSIKY2l0ZT0ibWlkOkNBRmZPX2g1TEhzZ25nNWl0UVRFTzMwU1VUX2puMDJQZGktMHVZdnla
Q2dSUEpmY3VlQUBtYWlsLmdtYWlsLmNvbSI+CiAgICAgIDxkaXY+CiAgICAgICAgPGRpdiBkaXI9
ImF1dG8iPgogICAgICAgICAgPGRpdj5IZXkgQWxleCwKICAgICAgICAgICAgPGRpdiBkaXI9ImF1
dG8iPjxicj4KICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICAgIDxicj4KICAgICAgICAgICAg
PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPgogICAgICAgICAgICAgIDxkaXYgZGlyPSJsdHIiIGNs
YXNzPSJnbWFpbF9hdHRyIj5PbiBUdWUsIE5vdiAxMiwgMjAyNCwKICAgICAgICAgICAgICAgIDY6
MTQgUE0gQWxleGFuZGVyIEdyYWYgJmx0OzxhCiAgICAgICAgICAgICAgICAgIGhyZWY9Im1haWx0
bzpncmFmQGFtYXpvbi5jb20iIG1vei1kby1ub3Qtc2VuZD0idHJ1ZSIKICAgICAgICAgICAgICAg
ICAgY2xhc3M9Im1vei10eHQtbGluay1mcmVldGV4dCI+Z3JhZkBhbWF6b24uY29tPC9hPiZndDsK
ICAgICAgICAgICAgICAgIHdyb3RlOjxicj4KICAgICAgICAgICAgICA8L2Rpdj4KICAgICAgICAg
ICAgICA8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiCnN0eWxlPSJtYXJnaW46MCAwIDAg
LjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KICAgICAg
ICAgICAgICAgIEhleSBEb3Jqb3ksPGJyPgogICAgICAgICAgICAgICAgPGJyPgogICAgICAgICAg
ICAgICAgVGhhbmtzIGEgbG90IGZvciB0aGUgcGF0Y2ghIFdvdWxkIHlvdSBtaW5kIHRvIHNlbmQg
dG8KICAgICAgICAgICAgICAgIHRoZSBNTCBzbyBpdCBjYW4gPGJyPgogICAgICAgICAgICAgICAg
Z28gdGhyb3VnaCB0aGUgbm9ybWFsIHJldmlldyArIGFwcGx5IGN5Y2xlPyA6KTxicj4KICAgICAg
ICAgICAgICAgIDxicj4KICAgICAgICAgICAgICAgIFNhbWUgY29tbWVudCBmb3IgdGhlIG90aGVy
IHBhdGNoZXMuPGJyPgogICAgICAgICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICAgICAgPC9k
aXY+CiAgICAgICAgICA8L2Rpdj4KICAgICAgICAgIDxkaXYgZGlyPSJhdXRvIj48YnI+CiAgICAg
ICAgICA8L2Rpdj4KICAgICAgICAgIDxkaXYgZGlyPSJhdXRvIj48YnI+CiAgICAgICAgICA8L2Rp
dj4KICAgICAgICAgIDxkaXYgZGlyPSJhdXRvIj5JIGRvbid0IHVuZGVyc3RhbmQuIEkgc2VudCB0
aGVtIHRvIHRoZSBtYWlsaW5nCiAgICAgICAgICAgIGxpc3QgdG9vLCBubz8gSSBzZWUgdGhlIGNj
J3Mgb24gdGhlIHBhdGNoZXMuPC9kaXY+CiAgICAgICAgPC9kaXY+CiAgICAgIDwvZGl2PgogICAg
PC9ibG9ja3F1b3RlPgogICAgPHA+PGJyPgogICAgPC9wPgogICAgPHA+WW91IGRpZCBpbmRlZWQg
LSBJJ20ganVzdCBibGluZCA6KS4gTGV0IG1lIGhhdmUgYW5vdGhlciBsb29rIGF0CiAgICAgIHRo
ZSBhY3R1YWwgY29udGVudHMgb2YgdGhlIHBhdGNoZXMhPGJyPgogICAgICA8YnI+CiAgICAgIDxi
cj4KICAgICAgQWxleDxicj4KICAgICAgPGJyPgogICAgPC9wPgogIDxicj48YnI+PGJyPkFtYXpv
biBXZWIgU2VydmljZXMgRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSDxicj4NCktyYXVz
ZW5zdHIuIDM4PGJyPg0KMTAxMTcgQmVybGluPGJyPg0KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJp
c3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzczxicj4NCkVpbmdldHJhZ2VuIGFtIEFtdHNn
ZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQjxicj4NClNpdHo6IEJlcmxp
bjxicj4NClVzdC1JRDogREUgMzY1IDUzOCA1OTc8L2JvZHk+CjwvaHRtbD4K

--------------nSwa3U5k04AZH169j5nCi5Zh--


