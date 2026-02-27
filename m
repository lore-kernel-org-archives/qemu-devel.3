Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7F9FEFB56
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 14:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvylt-0006C4-Td; Fri, 27 Feb 2026 09:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvylo-00068z-VV; Fri, 27 Feb 2026 09:24:45 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvyln-0003Ba-2i; Fri, 27 Feb 2026 09:24:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3XSRceLWsZXAR5y2iPDDn17IWJhT+4M1fjX2MuIAMTcXOXQTd1aBbCSAyvVj/P1c/uxKzrMShfX5KRDls7454BvM+qPnYr/aBU5hBqg3uIT9Sp1Vh2zo9PjPutzz9m4ASZKFKd6tVyITPapiAkXmwRdND08dqHurrPrwQ1Qh2PuAXtBcG0iVcBpOI78xAU6YbYfXdyjkQxbzeUmlAt2A6PRAtcTz2wRhDzhHGL7AUNeu69FFGQc2M08h+w19+Av6eY84Z1BxdYiinilT/M+z1ZGbqEJ9/peVF71PTG+17neG70An8RdX4lSjYN4fy1bRfX5Fp41if0njp0rBKUrXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ligwK0Rdc9PhOnrZz60yEealh3YTyXcXLtt46v+E/00=;
 b=MIDVdlnVIXIJGvBkHnZRjkipchmYNWoChktWifGDPmrqtxhG7n2/BDxzrpPU+M0j4L97QphHUFuL68cJI+wsPjkRB/7JI1hYhFY9t/ZPBdIF8canW/ruxzKol4xgwR4oMr7EBTd27gMMKlOxGs023cAl6nkyC9HN3jcqrXkUUdh7cNhlIBYmWKZydcEEc9ZguFixgEqCxr3Yu/m8TkrNcEGLeT6SSTFLExTmtWm6CpceLdRmVFQD/xDphRuFZt0kaXN5rDJ+8Zi3VTh4XHmyGg220IPNlIBD6VOTkhl6VqYhhkRE7xpRvwCB+9rcKGprz0mQKrgePvarfm4JnfCc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ligwK0Rdc9PhOnrZz60yEealh3YTyXcXLtt46v+E/00=;
 b=nIuwxdKpGXcjlz0Sw+dYtMW/j892A5cdiN8DeT+KgJBCSLsyWCnQZvvuar9MbPuFkNDWTtHxBpAmcjK8ppXKaH6cgjzQDWQvV75m1OE1znFOOdKg0P8be6/nFvwczNqLbvTCNRKzopclOyHJXWt+QzodErgZ6q7SxTBuj/+0i//o2PqfE+Bt/ELPdFt3YQgFNuMqp21ojs37wPxSOsmTK5FG8p6TjNEhrZoTOqPMWAfD9ErqDf14cBPL+B8dV2DB+0KskZ4FQAKVBVR3xPeQa+B6RBn/H7hzmi+yjmGE6sigXtKDI5il4XrSolFYk3vBTDhPXGxx47p36ZlnDivCvw==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by AS4PR09MB6562.eurprd09.prod.outlook.com (2603:10a6:20b:4f4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 14:24:38 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 14:24:38 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: Conor Dooley <conor@kernel.org>
CC: Alistair Francis <alistair23@gmail.com>, Mohamed Mediouni
 <mohamed@unpredictable.fr>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "thuth@redhat.com" <thuth@redhat.com>
Subject: Re: [PATCH v2 00/16] Add RISC-V big-endian target support
Thread-Topic: [PATCH v2 00/16] Add RISC-V big-endian target support
Thread-Index: AQHcpkBaA1l4l1CIU02NL47xpBxJMLWTSjoAgAJY6wCAAATbgIAAE2KAgADFJICAAAPwAIAAGKQA
Date: Fri, 27 Feb 2026 14:24:38 +0000
Message-ID: <e18fd3f3-30a7-4e19-ac54-b4caf68ee9fe@htecgroup.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <A02120BF-779D-4B2C-B29D-A9CB044EA895@unpredictable.fr>
 <CAKmqyKO6ioRt+h_tZrudbriv-QDVsOG1LNJ+GFQJ3ZO-fEhjiA@mail.gmail.com>
 <20260226-hangout-satin-fd7913f18f2b@spud>
 <CAKmqyKNST9ExmpcFE3iejmzZZRtMNSiVXkzfUK4GhhcketrCEw@mail.gmail.com>
 <de767b4f-93f2-47b1-8813-d1c063a30759@htecgroup.com>
 <20260227-dandruff-chemicals-4b3d22ca6354@spud>
In-Reply-To: <20260227-dandruff-chemicals-4b3d22ca6354@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|AS4PR09MB6562:EE_
x-ms-office365-filtering-correlation-id: b2e7c125-505a-4366-b234-08de760bf081
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: HAHtY1/HznZvdwtaFf7HcFAsAlIszZ+r+acZM5hkaic1/nC8dM2bN2wRoNVvwWLLtvuFpaClgKAQo0hIe50Ka9zy5qI5HorM35UNwx/99CrN6XU2RAEkMaA+evf3wB2eYHu/k20xEUUYwGQyiMGTpseA8hHM0CvbY9NusVzv/4zjr03Izy0khxtnNOdEZo7W+a8fh2rB+VmBt+GNSIKjVhJYL/+5TYDA1DiRfc9uuH1MarYf9zsEgbvnHoa9+jfM9RqQ/N3f8zn4VDRbXiGm/A3VeDCTuVYyFZLgU0AHoogsyxkUT3VpfnrvPzv4nAZ0MuXAuChgh1ilfk2XuIKflH/b5eRvF/HarHW1fVGF4PFEycBqKEhfC6LT/vnggdOrws7bcUYZHSmlvGQdyRyL2SxD+1t9A3ruqpW9UsQjLeG8yZVgFyDBhyYUbct9cb6KC1oGIEl5Z0NDGsUX2WALQesgjHmOL4vZmwhGkxD02dtcR+tVq9drmumRzywugPUml7GzsgKLXhgUH7Q7FV2R7AoG4qu66r6Qm1qG2QDSim6RpZM7QjKGrlE3psBxSidASh04sXP3sC/bLvOuyK95iDJ+cqzVBNFHqK4dUZQNohM0tIdDzplwEsYeigf2fxKCwS0q8Hp6Ai+bWjpO5uT3Db2u0ErHB5b7B0OwafOh+v3RzYAQN4ou2y5mSXjZaw0iPD0XIUObA4oKdvrn38NMuF+G8wO4FAvicHltiOgqQe/J6sv/jgA1Lg2EStk0MgOc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWl0V1dlWVgyNjRuU2FQekNVOW5NN2s5Y05YNElvS1ZpaWVaUUt4Q2locG15?=
 =?utf-8?B?QmxpbVNERWp6N256aVZZc1J2c1B2QmhOdlk1S0pEWUc3b1FHNnBSelhGbVF6?=
 =?utf-8?B?azdtK2hMT0NNQ2h6MnhyV3I5WnNQVGJzRmJpL0JPOXg3d1ErWEgwb2pzamE3?=
 =?utf-8?B?Vk5wUFl2WWtjMHFQNEUrV2FBYmMzZ2JUYlMxdTNMcDlYVUpKMm1TdlhVbFgx?=
 =?utf-8?B?STZKZ0ZBRXlkaGlGbGY0L1RzdTBMKzhaOCtMN2JsZ0JKNmFSa2hoeEpvMXBm?=
 =?utf-8?B?Mng5VmpYNHBQTzR2T1JaYkZ3MmhVOXQrM3c1UTZmOUdUMmZEYmxKQ21Lc0to?=
 =?utf-8?B?bVhMdW0yY2lsbXQ3aXlkRE5lN0Y4VTE1akdxcHZHck0rQzMycXY3YTZKb3VN?=
 =?utf-8?B?SW9BeGtOdVZ0dk1FVmpnSUdnclRtSVd4YUlucXBYV2tBRmJqNEdBNVhjY2x4?=
 =?utf-8?B?aVhyR2dJTkhmMGhpaUpCYmxuWWtSY0l5U2dzcnFBN1FQK3JZV0QyWWVmOGNS?=
 =?utf-8?B?ck1LRFBPclBraDJTanNEOUhiam40NmVwbWtXb0JOenpjRHVQZDNmRFhvLzBL?=
 =?utf-8?B?dEZveEQ1MmV1VFNBN1FNTG5aOVFPeUJzS1pQUTNKalRtNDI2bWhpYWI5V2dB?=
 =?utf-8?B?TFk2N2R3KyszSGY4UERud3YxQTEwdzhHLzAzRy9yVXUzQ0VoWEE4a3dEYzBx?=
 =?utf-8?B?YjRQaEN4eXk2cUNWS0R1Zi9Ud3c3MXNHdmZRVDIyT1F4cFRNYWc0QmJtN0VG?=
 =?utf-8?B?QzBEbTBEREYzSjFoK2tLSVlPVHBnckh6VGhZa0ZBZGx2SWphTUhTalFEWktL?=
 =?utf-8?B?UE1VV2x3QSs0TWkrV1JtWEZUellyZk5ZZjgycXA2Y3FlN1RZUWNXZ1h4UGdR?=
 =?utf-8?B?RWQvVlduaFJ6a1QxU0ZnOGdCdGlOODQ1QVQ3VEVhZ2M1Q0svWEJRWVZyRXNZ?=
 =?utf-8?B?UVNoUTRnVGRldkNzUlF6MEt6VTR1KzVEdmNCbkp3ZWlGUUUvakE4bkpzU01i?=
 =?utf-8?B?RjErWVJUQ3VNVHRlR2l2d2FUVlJ1MEhNakIzajlYY0lmcWs0bG5rQllKUVQ5?=
 =?utf-8?B?dVJXemFHWmtjK2FuUHJLMWM5WEtUQnNWSXR0UWtLbGk0bm1oQ1BMVGxwYzFB?=
 =?utf-8?B?dHR6Wmo2UEw1UkVYaGVSaUUvZGl3K2hPT0t4MWVsZHM3all6NDIrUkJvUERu?=
 =?utf-8?B?Mnd2M2dwajIwQ0hOaVpjWGd6K1FVNXV4QndKZFJEd0U1UUdTOEUyQndKSWZD?=
 =?utf-8?B?NUY0czYzZmVpenV4dTN0TnA5L0FLREVHN0hHa1Bya1VqaFdEUmRSV2VmSGhH?=
 =?utf-8?B?S1RUUmN3eG95aW1XZ2V6L3U3eDhKcVc5SXdMYVZ0K3VXd09DRE5KekJGSk1C?=
 =?utf-8?B?U01SOGxiVDF2SWRUbXBjR21WbGZORHExZXNQRlprVWxZWU5EeG91MzVCMlZ2?=
 =?utf-8?B?NTVZWHVvdlNNeXVoUHlkVnRza1J0MExDaXJrSE54aUNEOG5vMDBXS2VheHZL?=
 =?utf-8?B?YU5OUDlkNFlTNGVrN0N1cjJ2YzJCeTF1Y2Fqd01Pa0dvaVY3T3NZTDR3ZTBz?=
 =?utf-8?B?MExNUVBubTVWR2NXUnJyVU5qbDR2M2FWUWhON3BMV3J2ZFcyV2EwMitFVW9u?=
 =?utf-8?B?dWpDOXhhOEJUZjBZSUhLdEtjUW1EOEJibTBGZHIxaGhzOU9kZ2xvYTd5ZXU3?=
 =?utf-8?B?dHhCdUozanFFL2puT3o5SWJpSmpUUVNiSG9KOWZzWkJQUXQyR3BVQkRzWHNO?=
 =?utf-8?B?R3FBSmRpb1hreU4rSXVPZERBY1VUVEppM2owUlVnNjR6ODZXYkRmbUtQbGsx?=
 =?utf-8?B?VDdwUldhd2djbUl5ZWNiTGtMdGJpYm1OaXVPOXVSZUUrb1RHSVJNeHZQWHNF?=
 =?utf-8?B?bnBRN2trb1ZiS1cweHpxTGQxSnRuRThIbk5mVFZzQmtSQWgrMUE4aHlySkox?=
 =?utf-8?B?Wms1amIvc3FkL2ZoblJnN0dQaURXRnd6TU1sdjZOK3p3aG9aRmEza0tWZk1M?=
 =?utf-8?B?VzlxbVMweUczUThZbmlTWWhWaFBjTWcyOVJybkdQVkpyT3Z6YTl3amJYTnhr?=
 =?utf-8?B?S3FvdmpkMjVGcFkzOEZISzNSQzNENDh5VXMwbksrZ3VRMVo3NEFkckRGaFA2?=
 =?utf-8?B?RkN5QktYY3RzTUhjRGU3TGxhUE9ucEM4VCtQdFNVd0tRNFFOYWVtNW5aRlVE?=
 =?utf-8?B?eFBlWU5tdHpVclgvQmIwZ1djQnRqd2ZVbHhKUG9VYW5LSTZuTldYUFBiOUpu?=
 =?utf-8?B?RTVmd29xMHVSVXZ6bXVRTUVoN215UTdqVllvakZtZlR5b2RpNmk2ZnZQTnBk?=
 =?utf-8?B?bGFubHlCallIZlEwNjhtamtZcU5kRnlmeVhhbXp2eC9rY3dQRDIrcVZKd0tV?=
 =?utf-8?Q?uYXpRPUqMqau9qu8XF3RQMuu/T7KKkrtmk6bB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <818F06420BD81840B947ABF32F459783@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e7c125-505a-4366-b234-08de760bf081
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 14:24:38.4777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFCsDGtYF8cJA1V5OXkxsjCJ3gi6by4+OhbXZDNlMCBJ3ZxJXCBHlHGIXVEIE9FpE3wPdSqC2PElpObjxppDg93yugDiZOe3w1uAQMzRQ5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR09MB6562
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

DQpPbiAyLzI3LzI2IDEzOjU2LCBDb25vciBEb29sZXkgd3JvdGU6DQo+IE9uIEZyaSwgRmViIDI3
LCAyMDI2IGF0IDEyOjQyOjIxUE0gKzAwMDAsIERqb3JkamUgVG9kb3JvdmljIHdyb3RlOg0KPj4g
T24gMi8yNy8yNiAwMTo1NiwgQWxpc3RhaXIgRnJhbmNpcyB3cm90ZToNCj4+PiBDQVVUSU9OOiBU
aGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXpl
IHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4+Pg0KPj4+DQo+Pj4g
T24gRnJpLCBGZWIgMjcsIDIwMjYgYXQgOTo0N+KAr0FNIENvbm9yIERvb2xleTxjb25vckBrZXJu
ZWwub3JnPiB3cm90ZToNCj4+Pj4gT24gRnJpLCBGZWIgMjcsIDIwMjYgYXQgMDk6MzA6MDBBTSAr
MTAwMCwgQWxpc3RhaXIgRnJhbmNpcyB3cm90ZToNCj4+Pj4+IE9uIFdlZCwgRmViIDI1LCAyMDI2
IGF0IDk6MznigK9QTSBNb2hhbWVkIE1lZGlvdW5pDQo+Pj4+PiA8bW9oYW1lZEB1bnByZWRpY3Rh
YmxlLmZyPiB3cm90ZToNCj4+Pj4+Pj4gT24gMjUuIEZlYiAyMDI2LCBhdCAxMToyMCwgRGpvcmRq
ZSBUb2Rvcm92aWM8RGpvcmRqZS5Ub2Rvcm92aWNAaHRlY2dyb3VwLmNvbT4gd3JvdGU6DQo+Pj4+
Pj4+DQo+Pj4+Pj4+IFRoaXMgc2VyaWVzIGFkZHMgYmlnLWVuZGlhbiAoQkUpIFJJU0MtViB0YXJn
ZXQgc3VwcG9ydCB0byBRRU1VLA0KPj4+Pj4+PiBjb3ZlcmluZyBib3RoIHNvZnRtbXUgYW5kIGxp
bnV4LXVzZXIgZW11bGF0aW9uIGZvciByaXNjdjMyYmUgYW5kDQo+Pj4+Pj4+IHJpc2N2NjRiZS4N
Cj4+Pj4+PiBIZWxsbywNCj4+Pj4+Pg0KPj4+Pj4+IFRoZXJl4oCZcyBubyBMaW51eCBSSVNDLVYg
YmlnIGVuZGlhbi4gTWF5YmUgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvIGlzIHRvIG5vdA0KPj4+Pj4+
IHN1cHBvcnQgaXQgdW5sZXNzIHdl4oCZcmUgc3VyZSB0aGF0IGl0IGNhbiBnZXQgdG8gTGludXgg
dXBzdHJlYW0gKGZvciB0aGUgbGludXgtdXNlciBtb2RlKT8NCj4+Pj4+IEFncmVlZC4gV2UgcmVh
bGx5IG5lZWQgdXBzdHJlYW0gTGludXggc3VwcG9ydCBiZWZvcmUgdXNlciBtb2RlDQo+Pj4+IE9u
IHRoYXQgZnJvbnQsIEJlbiBwb3N0ZWQgcGF0Y2hlcyBmb3IgaXQgYW5kIExpbnVzIHdhcyByZWFs
bHkgcmVhbGx5IG5vdA0KPj4+PiBlbnRodXNlZCB3aGVuIGhlIGJlY2FtZSBhd2FyZSBvZiBpdDoN
Cj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmlzY3YvMDY2ZDcwYzctYjBhNy00
NWU1LTkzMzctMTc5MDFiYzk1NjY0QGNvZGV0aGluay5jby51aw0KPj4+PiBFdmVuIHdpdGhvdXQg
TGludXMnIHRha2UsIEkgZmVlbCBsaWtlIHRoZXJlJ3MgYWJzb2x1dGVseSBubyBjaGFuY2Ugb2YN
Cj4+Pj4gdXBzdHJlYW0gc3VwcG9ydCB3aXRob3V0IG1lYW5pbmdmdWwgc2hpcHBpbmcgaGFyZHdh
cmUgdGhhdCByZXF1aXJlcw0KPj4+PiBiaWcgZW5kaWFuIHN1cHBvcnQsIGJlY2F1c2UgYmFzaWNh
bGx5IGV2ZXJ5b25lIGVsc2Ugd2FzIGFsc28gb3Bwb3NlZCB0bw0KPj4+PiBhZGRpbmcgaXQuLi4N
Cj4+PiBZZWFoLi4uIEkgc2F3IHRoYXQuDQo+Pj4NCj4+PiBBIGZldyB0aG91Z2h0cywganVzdCBi
ZWNhdXNlIExpbnVzIGRvZXNuJ3QgbGlrZSBpdCBkb2Vzbid0IG1lYW4gUUVNVQ0KPj4+IGNhbid0
IHN1cHBvcnQgaXQuIEJ1dCBJIGFtIGhlc2l0YW50IHRvIHN1cHBvcnQgQkUgY29uc2lkZXJpbmcg
dGhlIGxhY2sNCj4+PiBvZiBlY29zeXN0ZW0gc3VwcG9ydCBldmVyeXdoZXJlIGVsc2UuDQo+PiBQ
bGVhc2UgYmUgYXdhcmUgdGhhdCBNSVBTIHdpbGwgc2hpcCBoYXJkd2FyZSBiYXNlZCBvbiByaXNj
diBCRQ0KPj4NCj4+IHNvb246aHR0cHM6Ly9taXBzLmNvbS9wcm9kdWN0cy9oYXJkd2FyZS9pODUw
MC8NCj4gTm90IHRoZSBtZWFuaW5nIG9mICJoYXJkd2FyZSIgSSB3YXMgdXNpbmcsIGFzIHRoaXMg
YXBwZWFycyB0byBiZSBhIGNvcmUNCj4gY29tcGxleCBJUCByYXRoZXIgdGhhbiBwaHlzaWNhbCBo
YXJkd2FyZT8gRG8geW91IGtub3cgb2YgYW55IGRldmljZXMsDQo+IG91dHNpZGUgb2YgYSBNSVBT
IHRlc3QgY2hpcCBvciB3L2UsIHRoYXQgYXJlIGdvaW5nIHRvIHVzZSB0aGlzIElQPw0KPg0KPiBP
biB0aGUgbGludXggc3VwcG9ydCBmcm9udCwgdGhlIGRldmlscyBhZHZvY2F0ZSB0YWtlIHdvdWxk
IGJlIHRoYXQNCj4gcGVvcGxlIHNob3VsZCBqdXN0IHJ1biB0aGlzIGNvcmUgaW4gTEUgbW9kZSwg
YnV0IHRoYXQncyBhIGJyaWRnZSB0byBiZQ0KPiBjcm9zc2VkIHdoZW4gc29tZW9uZSBwcm9kdWNl
cyBhbiBTb0MgdXNpbmcgdGhhdCBjb3JlIGNvbXBsZXggYW5kIG9uDQo+IGFub3RoZXIgbWFpbGlu
ZyBsaXN0IQ0KDQpZZXMsIHlvdSBhcmUgcmlnaHQsIHRoZSBpODUwMCBpcyBhbiBJUC4gQW5kIEkg
Y2FuIHNoYXJlIGZvciBub3cgdGhhdCANClFFTVUgYW5kIEZQR0ENCg0KYm9hcmQgd2l0aCB0aGUg
aTg1MDAgYml0ZmlsZSBhcmUgdGhlIHRhcmdldHMgZm9yIHRlc3Rpbmcgb2YgUklTQy1WIEJFIA0K
c29mdHdhcmUuDQoNCg0KQmVzdCByZWdhcmRzLA0KRGpvcmRqZQ0K

