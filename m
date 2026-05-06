Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DF0CD342F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 01:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKQyP-0005zb-Rn; Tue, 05 May 2026 21:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wKQyN-0005yn-GP; Tue, 05 May 2026 21:22:47 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wKQyK-00086l-HD; Tue, 05 May 2026 21:22:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buDIywDGpbd4EVKK3XSgEp5rPqyvIZFX8iUEAHLgiPWlmVas6z7BDWAvKjnnsxBQLr5WXU77kkWlP7XrgxjQApSLjYMsBkn6yJ9zg9tHL1GLlJikVkF5y4J6KC1SMVBUZD4uION6gvWajGBbTpc2QhKnNijXr5cwvopIo4pYrk6eQuLpBXy5jVVucmwkG6wacyT0K5RUHirNlV0SZLCXQgoznT3MlmrA/f6RdHOVgFGy4pjnJOlafIVl/dq29M9uJzlxweTuLGHEPpvekctahZsa8gMwCbhpj0fRyuXF6HK0RaIjPoiqmoPPJafJ965QbTUFegEOl4gLMbX23Co/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4L7F7YigGl3x2RYcg82JSxm1UPDy5EtgT5DhPPbCwcA=;
 b=U63OIJZFJVQ4CRjirXTyYQjN46E56iT230Z/1YfhyU9lVEAhReLnmCY9m4/b+GRIABC4FYP0+DPpPXibWrtFzxHR40P0RAQdur2J3Zbct9YcnSKDqhrtP+3VwkPQKXDeQWNY5vq8Y2RsPfm4cHYZC9DK14OJahn7/6ktna71iKUGXwVjlOEFpd+Gm2C+iwZdhHpv7fi63Z6rzMQX4tPRI+zrR39Hfosa0I7mFhO8Sb2jNoBC8vvg7xIXFNUGqfL+F2kWndPGxbFgo8wb/RgMb6j/wrablKEwBD93jMkUi8uB75MS9iUQgn0Lt8QNpG0btpXJzftehzHgqIjDyFylZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4L7F7YigGl3x2RYcg82JSxm1UPDy5EtgT5DhPPbCwcA=;
 b=NNTQZLrKlNyrbGIF37y/QfIRv3sBG/rwHBmDxymA0ad9nymUKGAzYl38HztmEMWC84WppZUx9VJye1JNLSN+Lr8DFCXgOQs3qk9yic1Jo67WISTxaqlyIkjitmXkJV8WkrKIO+Zpd2SEDjpYlCdIj3BDRCyX7uZ88YSG8Ni0fPeeRd3kE8df0/R8dH1SHZguAKM0d3GdM0VtmaP/pOgJf0sOZpa8TOOeLAnf/lax+R8uvnnf8VVC1DhTEBmV8/Eu6+RssGc0enmK8KggshK4dIvQMTbVTyG4QZVDJ2eOCWyKjGpjKRK5U2B6oO/1dAPL38XGV4Wtj/QdMsqA746U4g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6454.apcprd06.prod.outlook.com (2603:1096:101:173::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 01:22:35 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 01:22:35 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "peterx@redhat.com" <peterx@redhat.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v6 08/11] hw/usb/hcd-ehci: Add ctrldssegment-default
 property
Thread-Topic: [PATCH v6 08/11] hw/usb/hcd-ehci: Add ctrldssegment-default
 property
Thread-Index: AQHc23E97LiOY55oYE6l1HWddzDthLX9uLSAgAAQegCAAAa9gIAACG8AgAJbLSA=
Date: Wed, 6 May 2026 01:22:35 +0000
Message-ID: <TYPPR06MB8206C0C6EBCAB79A77BDF3EFFC3F2@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
 <20260504025342.1452605-9-jamin_lin@aspeedtech.com>
 <67a45038-e4bb-48f8-af08-af0d5c308ece@linaro.org>
 <e45a4765-0c3d-4fc0-8080-cdad5f877a92@redhat.com>
 <d9c8bf73-70f3-4bb3-b1cc-0f64f1ee5bc2@linaro.org>
 <1ed28a9f-ad15-4109-88f8-e7657fe33235@redhat.com>
In-Reply-To: <1ed28a9f-ad15-4109-88f8-e7657fe33235@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6454:EE_
x-ms-office365-filtering-correlation-id: b53c8536-acb4-46fc-dfbd-08deab0df41a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021|13003099007|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: Uad2qig8uoju5qQQ2VHufvfRW/BdLqiBRb4ZFyl9rLUWA1usWwZoerc1Bbo7fHLJ6wFMuADBQawm5bRxS7ytVn181PihH67etxHJz0lN5Zgk0STMaqQlKR8bIv0ZUy/XY+xRog2WllhcqVqpQKTWY7F0tbKkZ7+gmjiwMF7m8xWYIfzokY/I2v4o80NygCBHa/P371vWb5m+fmm7LDboIRxgV1fHn922sqoX9od0EtXB9uNABRBEDBI6hX9vY3cYQ2Wub8oQBG8gheZNyaHkz8ZRfiDwcZbSHK2Ujz3/IZjijxJNSYoD1sxeCj2/wQPgKwdjoOURq8TGoiXa9iSYBXk5K5f5c44wmVgjjK1MvIxMx9zaKbA3FGbqzoBOlVdFErZy2O+olEP8tAEVTcRbx7y29SVgk3VFML1LZtFKCZ51EVCWGL+np4GEz3JvQzaNnMlXn0nZDWzlMrdoe86KJwXESKZ25xpsYingXaGrZXQACXB5nXJUVhTYk1GnJeq3uLacoSyYGpCX/XoP3UMV2ikTHRinsYwx3n/PHejdv9GMnn70ka0FtvY4vgNBY4b0s3A2Km4Lg24U/I7QAPEy8AF8y0P8qqKJaLBbeA1+W+Z1bBXMm8j3DYgZe8q7Gi33vSTryMfC9A2aDpUE/OdnnypiGJywiFUjx0jH6fQSGRNWk7luTxB7S2LxqwzyQCBKWYP2IeMiagzpoiy9xosQ9NyXVwSvZFmlG6VaPr5T4EY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021)(13003099007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVlkWGVLR2lVOHNIck9ObjhQbTBTb3VVelc3dUkwVGNZZ2tWbUVFOFpCNDUr?=
 =?utf-8?B?NDh4MXhiSmszcEpoVkhudlNtT2h1SDJXenlpSkloZmtnbzZCSWhXYkhFN2Z1?=
 =?utf-8?B?UjlRSDNnNXdDYjVZS0R4U3g0eW9KZXJvcDJHWnhrbUpEb2RiUjcyWGtXdEJC?=
 =?utf-8?B?WU0wcGV5VUZYc2Zhc0I0TFF0V0lMeXQ2bDByeUh5eHNITjRvUkFTajVNMGtC?=
 =?utf-8?B?aUUvUTNYcm1lVkhTbXlEU0t0NVRKa3JnOGRwQ2grTmlvd205K2h2OVozRURB?=
 =?utf-8?B?b0h4TnB5d0hJaHRxMjhnM21WT3NDUE9kaXU3Sm9sZk1qdm9ZbnNxczN2MG5H?=
 =?utf-8?B?L3N6Sll1MkdiK2RtUEFyaUQyN1pQditWYmowNCt4bnZ4OXd2RVdXUUdlZzdn?=
 =?utf-8?B?YnliQzBiSDhHV3JZU2xTa0JadjZqZms3dGJtTVNqVGl5ZjdNL2ZIODE3djI4?=
 =?utf-8?B?amdjMi9VcG9kNE52bDMyWmd2aStlaE9YSkpJMVp4OC8yZFJ0N3gvZTNscnFR?=
 =?utf-8?B?SjFPR0RRazZSVUhnMytlQnBwc3kwQ3pNRC95SUs0Y09iK2IwU1o5OUV1Y0JZ?=
 =?utf-8?B?RXprWDRoR3FhTkd6aWF4MmEzei9yRmxTNHBNejBROWU4a2YrUFBMT0N6aTRo?=
 =?utf-8?B?cGovVXh2TXJSTWN4ZXJYSXJVNXAvYkxIa29RVmxjeEJjbmlrbVpNWFR3ZE8x?=
 =?utf-8?B?WmZ6cWx3Mm9KOGNsOEovdlMzdFVrM0ttVUk2QzVKMXNLV2NOU2Vlb041TURO?=
 =?utf-8?B?SDBFRTQ2enNNbytuOXlxRk1HUmVkMm9uUzh4ek4zY0xEYk5hRzZYQXRNajB2?=
 =?utf-8?B?VFNjcnJydnp3bWhDZGxtNXM3eG9wTHMvZ3VQNlZoNlFrZ0xpR3BLSDFYbHZD?=
 =?utf-8?B?aG1GVzJKR3lmbFRJL0xXOFB4dzMrT3dmbkk1bDVYU1B5VDFVVzJrUytIayty?=
 =?utf-8?B?N0xkZFJDZ3NTR1pvNHJvMThwL3MwRk9lRlkxbzh6TVVxREdCZGZ5aVhMWnlo?=
 =?utf-8?B?dWlyOEFJVDRlOE5kK3k2ZDFDNTNvNjBpYVhrc2ZLbEs3OFYrOWhjRHlISVNS?=
 =?utf-8?B?SWZBVDA5d0cyMW1XTXNuR0FtZjJHcTdmUGpvVkRDbkZaalQ0dTF6a1RUOEx5?=
 =?utf-8?B?d3lvZDNSSjFveXRpVmdtOHNIRjR3cHZIQXNoQ1VObzdTTkY1Q1owdHlNRjVp?=
 =?utf-8?B?ZDVLaDVGMy9oZ3NodUdzazFkUzFnb3JsT2IyWHlZQ0ZwbDM5Q1kxYWRrK2hX?=
 =?utf-8?B?VXAya3ZUZlk2emQ0bERYVUlzaENROTZFYU03dkV4T0tvN1pUaHFTZ3J6eHFC?=
 =?utf-8?B?YU4xK1BaRVppOG5BRlBvQ1BzTmwvdnJTdGtNZmRrTDlCdXNzdlZVZExLTHg1?=
 =?utf-8?B?Qk1Rb0psR2NUYjFzMGFEMFF2dTF0b2hoZnNibEFLakVBcG1nMlQrNzZTeFN2?=
 =?utf-8?B?WFh1OC9BeWk1eXhnUHBmVEJRL2E3ZXJYUER1SUxGZVU0MVprajFxS2J5ZGxL?=
 =?utf-8?B?Z2M2NkRpS0NCUjJUMENOOEtUamNiM1Jmd0czb2NjeW1QYnRVWXV6SUNycFA3?=
 =?utf-8?B?WDU1R0hObm9VWEQyeDUxaTBmVzhjSnV0SzNSRGo0MFVCV0NtM3pqbHFJWC9U?=
 =?utf-8?B?eDBKSnpZZ2xKQ09sQS81M1ZZalNpZ3Vzck9KS2ltWEJBK2pzNThlejVLaEZV?=
 =?utf-8?B?M1N6OFZsY2FvZlNjYktwTHVMODFVNmVXOG9VRVFpMTN1b2hYRldLRWd0WStB?=
 =?utf-8?B?WFdrdUhYTW9pMHhhVDNTVjZCWG9pL1k3TDVsUUowNmt2dTRjeVI2UlNrQXNq?=
 =?utf-8?B?alZYQ2FMNSs0U0ozNWs4enV4WVhTeUtvOE9hdjlpdXV1ODRpS2xRVGpUYkV6?=
 =?utf-8?B?OC85Nm1LSVM5bCtFcjVhYnRNWElWT2pwQzd5STh0bVY1enNOUGdEazEyVThG?=
 =?utf-8?B?VHNkbDVPblY1QlBHb2Z4UFB2bUdFK3hBTzBRbDl3Q3Rzd3l3bjRpSVZ1MzRY?=
 =?utf-8?B?VlhtcXFSMHlxQStJY0tkMm9NS0w0K2MxK1FjYWYyUHNhL2Njd1R6RHgwQjZC?=
 =?utf-8?B?d3NCRnA1b3BIeUlVTE1jbnRadnRJT3E4S3g5L1E0QzR2dm5xd2VPYzh0dVVw?=
 =?utf-8?B?MXlJUDZveCtiWVBEbHdIZWlIRDJUcEttcHlrR2NxOC9hSHdveFdPMlJ2dWZp?=
 =?utf-8?B?VHV3cjR4OFVUQUI2MWltNkJtQkphdFJ0TTlyWDNwN2htZnF3WFNEK3JhZ3pj?=
 =?utf-8?B?cjRKTlUzUUVRMjNEUnJyWmlVWEJUalFPTnZMSDJtWjNVekdFL1FLWk9pczJZ?=
 =?utf-8?B?enU5aWhYTWZBL25vb2dBZHhyajJFbUlCckpsV1lFNFF3NUZsbjBjUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SE5NgubhZUv2Gy7av0P2TMvG/fZhcRFgeDW+HfJA8koR/8hDOeu2HCL0lSbvO73/xuKg+w/qR1A7hSvmRoy9LxsCROK/ZQe2+Uc2T+EN86xQQewepKfjLAWE4bnT1m3wcX+o1xTnvyEbgz4mFz8StjmI7gX09fQaaGwNB0TRXJbzjJ5VM7cokbJJQ+7m9RAGZBRo7nxfNni1AL9ijoYmIZWF0v+fc5XZulxFzrq6pXCZg3WMKC6IKaWvKjvEW3Hf2eKDUza0yOGHxsYvkL8Khtrcniie1K74VOeUFToLSVHRLLTGTpgpdfmXeAyyP6O1K/uPycqRDMynhRppAnM4TA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53c8536-acb4-46fc-dfbd-08deab0df41a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 01:22:35.0955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kzm7/ZFfF15T6daBgC7wgYInimSlYoDZuDCfFJKVU0Zutu8TjypcoF3LDKF6vLhnASjHUvbD4IpTkO5kob/lhx9EpaapYxly2IY+NTvXmss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6454
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYywgUGhpbGlwcGUNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDA4LzExXSBo
dy91c2IvaGNkLWVoY2k6IEFkZCBjdHJsZHNzZWdtZW50LWRlZmF1bHQNCj4gcHJvcGVydHkNCj4g
DQo+IE9uIDUvNC8yNiAxNDo0MiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+ID4g
T24gNC81LzI2IDE0OjE3LCBDw6lkcmljIExlIEdvYXRlciB3cm90ZToNCj4gPj4gT24gNS80LzI2
IDEzOjE4LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gPj4+IE9uIDQvNS8yNiAw
NDo1MywgSmFtaW4gTGluIHdyb3RlOg0KPiA+Pj4+IFdoZW4gNjQtYml0IGFkZHJlc3NpbmcgaXMg
c3VwcG9ydGVkLCB0aGUgTGludXggRUhDSSBkcml2ZXIgcHJvZ3JhbXMNCj4gPj4+PiB0aGUgc2Vn
bWVudCByZWdpc3RlciB0byB6ZXJvLiBTZWUgZWhjaV9ydW4gZnVuY3Rpb246DQo+ID4+Pj4gaHR0
cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2RyaXZlcnMvdXNiL2hv
c3QvZWhjaQ0KPiA+Pj4+IC0gaGNkLmMNCj4gPj4+Pg0KPiA+Pj4+IFRoZSBkcml2ZXIgY29tbWVu
dCBhbHNvIG5vdGVzIHRoYXQgZGVzY3JpcHRvciBzdHJ1Y3R1cmVzIGFsbG9jYXRlZA0KPiA+Pj4+
IGZyb20gdGhlIERNQSBwb29sIHVzZSBzZWdtZW50IHplcm8gc2VtYW50aWNzLg0KPiA+Pj4+DQo+
ID4+Pj4gRGVzY3JpcHRvciBtZW1vcnkgaXMgYWxsb2NhdGVkIHVzaW5nIHRoZSBETUEgQVBJLiBU
aGUgcGxhdGZvcm0NCj4gPj4+PiBkcml2ZXIgY29uZmlndXJlcyBhIDY0LWJpdCBETUEgbWFzayBz
byBtZW1vcnkgY2FuIGJlIGFsbG9jYXRlZCBhYm92ZQ0KPiA0R0IuDQo+ID4+Pj4gU2VlIGVoY2lf
cGxhdGZvcm1fcHJvYmUgZnVuY3Rpb246DQo+ID4+Pj4gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZh
bGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2RyaXZlcnMvdXNiL2hvc3QvZWhjaQ0KPiA+Pj4+IC0gcGxh
dGZvcm0uYw0KPiA+Pj4+DQo+ID4+Pj4gT24gQVNUMjcwMCBwbGF0Zm9ybXMsIHN5c3RlbSBEUkFN
IGlzIG1hcHBlZCBhYm92ZSA0R0IgYXQNCj4gMHg0MDAwMDAwMDAuDQo+ID4+Pj4gQXMgYSByZXN1
bHQsIGRlc2NyaXB0b3IgYWRkcmVzc2VzIGNvbnN0cnVjdGVkIGRpcmVjdGx5IGZyb20gdGhlDQo+
ID4+Pj4gZ3Vlc3QgRUhDSSByZWdpc3RlcnMgZG8gbm90IG1hdGNoIHRoZSBhY3R1YWwgc3lzdGVt
IGFkZHJlc3MgdXNlZCBieQ0KPiA+Pj4+IHRoZSBjb250cm9sbGVyIHdoZW4gZmV0Y2hpbmcgcXVl
dWUgaGVhZHMgKFFIKSBhbmQgcXVldWUgZWxlbWVudA0KPiA+Pj4+IHRyYW5zZmVyIGRlc2NyaXB0
b3JzIChxVEQpLg0KPiA+Pj4+DQo+ID4+Pj4gQWRkIGEgY3RybGRzc2VnbWVudC1kZWZhdWx0IHBy
b3BlcnR5IHNvIHBsYXRmb3JtcyBjYW4gcHJvdmlkZSBhDQo+ID4+Pj4gZGVzY3JpcHRvciBhZGRy
ZXNzIG9mZnNldCB3aGVuIGNvbnN0cnVjdGluZyBkZXNjcmlwdG9yIGFkZHJlc3Nlcy4NCj4gPj4+
PiBUaGlzIGFsbG93cyBzeXN0ZW1zIHdoZXJlIERSQU0gcmVzaWRlcyBhYm92ZSA0R0IgdG8gYWNj
ZXNzIEVIQ0kNCj4gPj4+PiBkZXNjcmlwdG9ycyBjb3JyZWN0bHkuDQo+ID4+Pj4NCj4gPj4+PiBU
aGUgZGVmYXVsdCB2YWx1ZSBpcyB6ZXJvLCBzbyBleGlzdGluZyBtYWNoaW5lcyBhcmUgbm90IGFm
ZmVjdGVkLg0KPiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9s
aW5AYXNwZWVkdGVjaC5jb20+DQo+ID4+Pj4gUmV2aWV3ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj4gPj4+PiAtLS0NCj4gPj4+PiDCoCBody91c2IvaGNkLWVoY2ku
aCB8IDUgKysrKy0NCj4gPj4+PiDCoCBody91c2IvaGNkLWVoY2kuYyB8IDEgKw0KPiA+Pj4+IMKg
IDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+Pj4N
Cj4gPj4+PiBkaWZmIC0tZ2l0IGEvaHcvdXNiL2hjZC1laGNpLmggYi9ody91c2IvaGNkLWVoY2ku
aCBpbmRleA0KPiA+Pj4+IDhlNmE4Y2RmYjAuLjNkNTdlMWRlNWYgMTAwNjQ0DQo+ID4+Pj4gLS0t
IGEvaHcvdXNiL2hjZC1laGNpLmgNCj4gPj4+PiArKysgYi9ody91c2IvaGNkLWVoY2kuaA0KPiA+
Pj4+IEBAIC0yNjQsNiArMjY0LDcgQEAgc3RydWN0IEVIQ0lTdGF0ZSB7DQo+ID4+Pj4gwqDCoMKg
wqDCoCB1aW50MzJfdCBtYXhmcmFtZXM7DQo+ID4+Pj4gwqDCoMKgwqDCoCBib29sIG1pZ3JhdGVf
ZmV0Y2hfYWRkcl82NGJpdDsNCj4gPj4+PiDCoMKgwqDCoMKgIGJvb2wgY2Fwc182NGJpdF9hZGRy
Ow0KPiA+Pj4+ICvCoMKgwqAgdWludDMyX3QgY3RybGRzc2VnbWVudF9kZWZhdWx0Ow0KPiA+Pj4+
IMKgwqDCoMKgwqAgLyoNCj4gPj4+PiDCoMKgwqDCoMKgwqAgKsKgIEVIQ0kgc3BlYyB2ZXJzaW9u
IDEuMCBTZWN0aW9uIDIuMyBAQCAtMzIyLDcgKzMyMyw5IEBADQo+ID4+Pj4gc3RydWN0IEVIQ0lT
dGF0ZSB7DQo+ID4+Pj4gwqDCoMKgwqDCoCBERUZJTkVfUFJPUF9CT09MKCJ4LW1pZ3JhdGUtZmV0
Y2gtYWRkci02NGJpdCIsIF9zdGF0ZSwgXA0KPiA+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVoY2kubWlncmF0ZV9mZXRjaF9hZGRyXzY0Yml0LCB0cnVl
KSwNCj4gXA0KPiA+Pj4+IMKgwqDCoMKgwqAgREVGSU5FX1BST1BfQk9PTCgiY2Fwcy02NGJpdC1h
ZGRyIiwgX3N0YXRlLCBcDQo+ID4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZWhjaS5jYXBzXzY0Yml0X2FkZHIsIGZhbHNlKQ0KPiA+Pj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVoY2kuY2Fwc182NGJpdF9hZGRyLCBmYWxz
ZSksIFwNCj4gPj4+PiArwqDCoMKgIERFRklORV9QUk9QX1VJTlQzMigiY3RybGRzc2VnbWVudC1k
ZWZhdWx0IiwgX3N0YXRlLCBcDQo+ID4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGVoY2kuY3RybGRzc2VnbWVudF9kZWZhdWx0LCAwKQ0KPiA+Pj4NCj4g
Pj4+IGN0cmwtZHMtc2VnbWVudC1kZWZhdWx0IGFuZCBjdHJsX2RzX3NlZ21lbnRfZGVmYXVsdD8N
Cj4gPj4+DQo+ID4+PiBPdGhlcndpc2UsDQo+ID4+PiBSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0
aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiA+Pj4NCj4gPj4NCj4gPj4geWVhaC4g
SSBhZ3JlZS4gVGhhdCdzIHRoZSBnZW5lcmFsIHBhdHRlcm4gZm9yIHByb3BlcnR5IG5hbWVzLg0K
PiA+DQo+ID4gSSBkb24ndCBnZXQgdGhlICctZGVmYXVsdCcgc3VmZml4LiBBbHRlcm5hdGl2ZXM6
DQo+ID4NCj4gPiBkcmFtLXNlZ21lbnQtYmFzZS1hZGRyIG9yIGV2ZW4geC1kcmFtLXNlZ21lbnQt
YmFzZS1hZGRyDQo+IA0KPiBXaGF0IGV2ZXIgbWFrZXMgc2Vuc2UuIEVIQ0kgc3BlY3MgaGF2ZSA6
DQo+IA0KPiAgICBDVFJMRFNTRUdNRU5UICA0RyBTZWdtZW50IFNlbGVjdG9yDQo+IA0KPiBUaGUg
cHVycG9zZSBvZiB0aGUgImN0cmxkc3NlZ21lbnQtZGVmYXVsdCIgcHJvcGVydHkgaXMgdG8gZm9y
Y2UgYSBkZWZhdWx0IHZhbHVlDQo+IG9mIHRoZSBDVFJMRFNTRUdNRU5UIHJlZ2lzdGVyIGZvciB0
aGUgYXN0MjcwMC4NCj4gDQo+IEphbWluLCBob3cgYXJlIHdlIHN1cmUgdGhlIERNQXMgYXJlIGFs
bG9jYXRlZCBpbiB0aGlzIDRHIHNlZ21lbnQgPw0KPiBiZWNhdXNlIFJBTSBjb3ZlcnMgOEcgOg0K
PiANCj4gICAgICAgIDAwMDAwMDA0MDAwMDAwMDAtMDAwMDAwMDVmZmZmZmZmZiAocHJpbyAwLCBy
YW0pOiByYW0NCj4gDQoNCkl0IGlzIGEgZmlybXdhcmUgaXNzdWUuIEFmdGVyIGRpc2N1c3Npbmcg
aXQgd2l0aCB0aGUgVVNCIGRyaXZlciBvd25lciwgd2UgZm91bmQgdGhhdCB0aGlzIGlzc3VlIG9j
Y3VycyB3aGVuIHVzZXJzIHVzZSA4R0IgRFJBTSBiZWNhdXNlIHRoZSBkcml2ZXIgZG9lcyBub3Qg
Y29uZmlndXJlIENUUkxEU1NFR01FTlQuDQpDdXJyZW50bHksIG91ciBTREsgb25seSBzdXBwb3J0
cyB1cCB0byAyR0IgRFJBTSwgc28gdXNlcnMgc2hvdWxkIG5vdCBlbmNvdW50ZXIgdGhpcyBpc3N1
ZSB1bmRlciBub3JtYWwgY29uZGl0aW9ucy4NCkhvd2V2ZXIsIHRoaXMgY291bGQgYmVjb21lIGEg
cG90ZW50aWFsIGlzc3VlIGlmIHVzZXJzIGNvbmZpZ3VyZSB0aGUgRFJBTSBzaXplIHRvIDhHQi4N
Cg0KPiANCj4gPiBzaW5jZSBJIHN0aWxsIGJlbGlldmUgdGhpcyBpcyBhIEFTVDI3MDAgaXNzdWUs
IGxpa2VseSBub3QgbWFwcGluZyBSQU0NCj4gPiBhcHByb3ByaWF0ZWx5Lg0KPiANCj4gT3RoZXIg
Y29udHJvbGxlcnMgd291bGQgYmUgaW1wYWN0ZWQgbm8gPw0KPiBMaW51eCAodXBzdHJlYW0pIGZv
cmNlcyB0aGUgQ1RSTERTU0VHTUVOVCB2YWx1ZSA6DQo+IA0KTGludXggKHVwc3RyZWFtKSBmb3Jj
ZXMgQ1RSTERTU0VHTUVOVCB0byAwLCB3aGljaCBtZWFucyBvbmx5IERSQU0gYWRkcmVzc2VzIGJl
bG93IDRHQiBhcmUgYWxsb3dlZC4NCg0KVGhlcmVmb3JlLCBBU1QyNzAwIGhhcmR3YXJlIHNldHMg
dGhlIGRlZmF1bHQgdmFsdWUgb2YgQ1RSTERTU0VHTUVOVCB0byA0LCB3aGljaCBtYXBzIHRvIHRo
ZSBBU1QyNzAwIERSQU0gcmVxdWlyZWQgYmFzZSBhZGRyZXNzIDB4NDAwMDAwMDAwLg0KDQpJbiBv
dGhlciB3b3JkcywgdGhlIEFTVDI3MDAgZmlybXdhcmUgb25seSBuZWVkcyB0byBjb25maWd1cmUg
Yml0cyAwIGFuZCAxIG9mIENUUkxEU1NFR01FTlQuDQoNCkhvd2V2ZXIsIHNldHRpbmcgb25seSBi
aXRzIDAgYW5kIDEgaW4gdGhlIGZpcm13YXJlIGlzIG5vdCBzdWZmaWNpZW50IGZvciBRRU1VLCBi
ZWNhdXNlIFFFTVUgaXMgbm90IGF3YXJlIHRoYXQgdGhlIEFTVDI3MDAgaGFyZHdhcmUgaW5pdGlh
bGl6ZXMgdGhlIGRlZmF1bHQgdmFsdWUgb2YgQ1RSTERTU0VHTUVOVCB0byA0Lg0KDQpJbiBjb25j
bHVzaW9uLCBzaG91bGQgSSByZW5hbWUgdGhpcyBwcm9wZXJ0eSB0byBjdHJsLWRzLXNlZ21lbnQt
ZGVmYXVsdCBhbmQgY3RybF9kc19zZWdtZW50X2RlZmF1bHQ/DQpBbHNvLCBzaG91bGQgSSBjcmVh
dGUgYSBuZXcgcGF0Y2ggZm9yIHRoaXMgY2hhbmdlLCBvciByZXNlbmQgdGhlIGVudGlyZSBwYXRj
aCBzZXJpZXM/DQoNClRoYW5rcywNCkphbWluDQo+IAkvKg0KPiAJICogaGNjX3BhcmFtcyBjb250
cm9scyB3aGV0aGVyIGVoY2ktPnJlZ3MtPnNlZ21lbnQgbXVzdCAoISEhKQ0KPiAJICogYmUgdXNl
ZDsgaXQgY29uc3RyYWlucyBRSC9JVEQvU0lURCBhbmQgUVREIGxvY2F0aW9ucy4NCj4gCSAqIGRt
YV9wb29sIGNvbnNpc3RlbnQgbWVtb3J5IGFsd2F5cyB1c2VzIHNlZ21lbnQgemVyby4NCj4gCSAq
IHN0cmVhbWluZyBtYXBwaW5ncyBmb3IgSS9PIGJ1ZmZlcnMsIGxpa2UgZG1hX21hcF9zaW5nbGUo
KSwNCj4gCSAqIGNhbiByZXR1cm4gc2VnbWVudHMgYWJvdmUgNEdCLCBpZiB0aGUgZGV2aWNlIGFs
bG93cy4NCj4gCSAqDQo+IAkgKiBOT1RFOiAgdGhlIGRtYSBtYXNrIGlzIHZpc2libGUgdGhyb3Vn
aCBkZXYtPmRtYV9tYXNrLCBzbw0KPiAJICogZHJpdmVycyBjYW4gcGFzcyB0aGlzIGluZm8gYWxv
bmcgLi4uIGxpa2UgTkVUSUZfRl9ISUdIRE1BLA0KPiAJICogU2NzaV9Ib3N0LmhpZ2htZW1faW8s
IGFuZCBzbyBmb3J0aC4gIEl0J3MgcmVhZG9ubHkgdG8gYWxsDQo+IAkgKiBob3N0IHNpZGUgZHJp
dmVycyB0aG91Z2guDQo+IAkgKi8NCj4gCWhjY19wYXJhbXMgPSBlaGNpX3JlYWRsKGVoY2ksICZl
aGNpLT5jYXBzLT5oY2NfcGFyYW1zKTsNCj4gCWlmIChIQ0NfNjRCSVRfQUREUihoY2NfcGFyYW1z
KSkgew0KPiAJCWVoY2lfd3JpdGVsKGVoY2ksIDAsICZlaGNpLT5yZWdzLT5zZWdtZW50KTsgICAg
ICAgPC0tLS0tLS0gaGVyZQ0KPiAjaWYgMA0KPiAvLyB0aGlzIGlzIGRlZXBseSBicm9rZW4gb24g
YWxtb3N0IGFsbCBhcmNoaXRlY3R1cmVzDQo+IAkJaWYgKCFkbWFfc2V0X21hc2soaGNkLT5zZWxm
LmNvbnRyb2xsZXIsIERNQV9CSVRfTUFTSyg2NCkpKQ0KPiAJCQllaGNpX2luZm8oZWhjaSwgImVu
YWJsZWQgNjRiaXQgRE1BXG4iKTsgI2VuZGlmDQo+IAl9DQo+IA0KPiANCj4gQy4NCg0K

