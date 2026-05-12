Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AEBCD4846
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 01:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMc6G-0006Xc-9N; Mon, 11 May 2026 21:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wMc6C-0006QJ-5b
 for qemu-devel@nongnu.org; Mon, 11 May 2026 21:39:52 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wMc6A-0004gc-5U
 for qemu-devel@nongnu.org; Mon, 11 May 2026 21:39:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZbwcHFOyMWhKpgbEgQIOMzgppZ6eYc6japGHSZVxVKS5sDo8PGhJDsW3jp7ahqj9cxrUX5SVxQH6XL/iTcvd39AcRRiFxgJGNtXo+cMfDpuAW6mJL5Rhl96SwjFRDiHeW+qHvvJpjHXD87muYPGLPphXUaJLmcvWh7rfOLR/Qm4k9sgTTvteUBPWWRO5dMkekiyezztAesqkBte116r3K4lU/isrI9+CTW034wlnw4OYxab0VkF45UkyRnuHsPHs/zpEB7j8ujH6XzWpvhufK4ndXjNr7CKbwENCKEFAC1/ZQcyQLPmT3XyhpxFd498hamTEhlBL80wuCIf5B/veQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntt3zNtchvA0upE0FypvekY+6Vcsvx8OawbLRM1aJLk=;
 b=WsDuExTk1oW0+DT3jXctv779xKwta9FDfe55fy1FBs0NblNBK06PIYD4+ro+W3d409NMzirLTMMULHtL7dJKkcc2ZG1MKR9KgtRlbzhTPzAWzdWTkt5IDSXb6TJx1c8XUh33bL60juTzlfi4MclF74f8/wzmrODttgMDee8Tc+FNBSws+cYOMOQe1YZl3NennKd4wjl4YwRZPzhp8R9RpsxLsUSZdXNs9mgg0rKwI1YjWkoU5d80QOPOYg+WEyKceqsNjL3L8cHjB7ppNw9/vEW3pf/2j42anxJWjo1KWId3Jqw5rcC/sBu804uzxN4TsgcUYnfz2PhibrZl+lGaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntt3zNtchvA0upE0FypvekY+6Vcsvx8OawbLRM1aJLk=;
 b=ispYk4IPGFF21hGslDFyjgheSddYbLb7iRUK+1FydLgym5c6jny7R9I84clr6zab8GDs8Nc691AEi07+ryCW1eKoyYBYZyyNYf91FH0NdglXr2iCtF75WdDs6WUspmXcy6MnJrkzH0LGOBgRXt8IBy7FCVHvrQuqdYAhXk/QsH+kF8q+FyG0mCQkAv47vfmFvP48YxhLnkaYrKtREf7ahqV1+fpO3Hcu81EM4Rmq4dp0nbGMDukOzIjXOtp6T4vjvh5rXGoI5fWeAnRGiHWrrPc7sB7evYWX1yYqwXjsTVHZjPXCfu3GMuWfIeb4D8ZMymDZ0A7YzqOVNIHHMhVzNg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5605.apcprd06.prod.outlook.com (2603:1096:101:c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 01:39:45 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 01:39:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Ashish Anand
 <ashish.a6@samsung.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "komlodi@google.com" <komlodi@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "saurabh@samsung.com" <saurabh@samsung.com>,
 "vishwa.mg@samsung.com" <vishwa.mg@samsung.com>, "y.kaushal@samsung.com"
 <y.kaushal@samsung.com>, "ashish.anand202@gmail.com"
 <ashish.anand202@gmail.com>
Subject: RE: [PATCH v2] hw/i3c/dw-i3c: Fix BCR/DCR extraction and PID assembly
 during ENTDAA
Thread-Topic: [PATCH v2] hw/i3c/dw-i3c: Fix BCR/DCR extraction and PID
 assembly during ENTDAA
Thread-Index: AQHc3JVFhNL1P1VkBEqJ+e+Qz/zKbrYF4OEAgAPGKqA=
Date: Tue, 12 May 2026 01:39:45 +0000
Message-ID: <TYPPR06MB820649D7812906E75DBA671FFC392@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <CGME20260505134412epcas5p1ccd2bd43c50ec651636847fa8c516072@epcas5p1.samsung.com>
 <20260505134002.509037-1-ashish.a6@samsung.com>
 <c04147a8-795c-420d-abd9-2f56c62dbd09@kaod.org>
In-Reply-To: <c04147a8-795c-420d-abd9-2f56c62dbd09@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5605:EE_
x-ms-office365-filtering-correlation-id: 3f79d8f1-80f1-4e53-6ee6-08deafc758c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: nS8qUEG3ExVwKLV/3ooSS/nFMl9mDeFMMx+Zgy3coKJfwGfiutVSUQ5ZOyRsSwgkYekvgkflHGZnJjqR2WJ6+74pVAkXhFSx+xepA5qV9x8LVzvELlkUhvDwfwcoVpcrirC3UQY83LMnQrsvRr3IzPkO1mCNSw/+Vxh5a/2MGcEkZocZnVv0C7DbyBOsKk2PAkJ1Ug2oDPyt/z90/hBMmmHJZ7thQrkqCNd+9+IdfARlCAwsGU7418EH/RpG8AeiNncLfRH7VJp7/w2pSGUZ5lSeSONSr4n6nlawlMCA/E/3E/vkoOXhBnFJX8kJCSF29x1ouBZAyHwv+w7098ICOv21hocp0kB9m9B7Ku2CWrifRPFe+2N8b/dSyDBBc49Fjl6dxJ82/kOHgORVLMUm/FI7yXsISlrLcHQkd5fYi5TU49eUyvTsso776vQEgW4x7ZG4tJerRbH9A9efPc6ci65jcMkHtDbXEWtHhtEaBekPfJwCIlzYYWb9tn7xHzXRKkeXjuwfZ4HUK4vX4Otd/AwAdlIFnC+hzDK/5WIEbhOngZalAUWG/ThFNH9C5cp6KAPy37RGvKlMEUTvF3zeczNh2JtbS1X1ZXJsUTsd3dFZW7JutH2YkmOLsNjES/IZsdJxRMKp0VOdjDSzEn+gSGJNTsoErL1h8O/EaTBKyH5GHJo5Fod/htho5p4MSgL/7h8W5IceQCVU6gP4uuHYpBS4iqq23unVZoBrdLGdsTgRra9JOZwoAubOV2AqKy41
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVFKVTNKVzVOSVYwWERCMDhjcUlFWHRoZUdCb015b1RHdGVLMWxHcGZjSE9C?=
 =?utf-8?B?eUFOUWJ5VmFycStaTEdONHNielBwSkN4ZENKQ2M1ZU15YWpGMDFxaENtUTly?=
 =?utf-8?B?UTgycmlmbnFLbWNBTFVXeDVlS05laHo4OW9uUzQvdU82M1pMTE9KQTNVck84?=
 =?utf-8?B?bDcyY2Y4bHQ2MDVPRGZCNVg2bHhYV3ZBVEJjVitiR3lyWkFnMFBDZlVGSFlo?=
 =?utf-8?B?bWxMaHQwa1c0UDYrQ2RGZmZnK0VQazR4aXZmWE1lZXVoQjd5djdOQ3V0U0gz?=
 =?utf-8?B?NFZzdXRpb0dxdTR3U0tFT2lqdkF0eThUYUQ4cnNBSnd4UTVWK2dnYmZjRVBl?=
 =?utf-8?B?VTNJTHA0SzdoNFBxYmsybE5yY24rMVBIYkxKQzlFa1d1dzYrWEl0MjNiRkc0?=
 =?utf-8?B?cjBQZHRwaXNQek82YzRzOS9CVGI1Zm1GZCtocUhkUlBCQ1hKbTRGZFBrZGpi?=
 =?utf-8?B?L0xUU3VUdktOOEd3SHZ2REVHeU5WdWlyT1dlby9Ycm8vMEJLU250RThUeW1N?=
 =?utf-8?B?TDIrcTg4Q2lOa01Rb3dGUkk1ejZQWHp0VnhidXp5bC9vMVFESnA4RXJqRndn?=
 =?utf-8?B?ZFAvaDc5RVRzYmU0amEwNHhMZzAxVkZEdUt0SGR1ck5xQkRmbHUvQ2pIcEdY?=
 =?utf-8?B?c1RKbnIybDNqRjRGZUVmNS95Nzk0dkxCbjlhbnRNaXRmOWl0cExsMDM1MkEr?=
 =?utf-8?B?b1RKVTJ5SE4vY053UVUrZjd2M244aXRsTHhVMXJvVzZRNG9taGNRVjhvSklk?=
 =?utf-8?B?bXRRU0g0SXhmRUxvTVRCNlBaelE1RWM1R2c4V2J5dFJ1eFVudDJyVm5PSDgz?=
 =?utf-8?B?WEhQbVVmNVByRU5hOEt2SWVPUWJJTUlEcmNnTHVuKy9WYm5zRWY0MENoZjNa?=
 =?utf-8?B?Mkg4Ym1CSkpQVVppa1BFeUtQQmpvNnQ4NWtDYlBmMmwzY2VxbnFCKzhuM1Jt?=
 =?utf-8?B?QVE3SHA3M0FhTk5rRllPc3Ridkt6QmNIcFhneU8vVUVObDQ4TWlnajJLTk4z?=
 =?utf-8?B?c0dVeGZQRTZFdmxCaDFYRWUzOWpjTDl2T2l3NGo4NFhYYlg1cmZBM2orcWFR?=
 =?utf-8?B?WGFlZXBnbStqMW1aa3hYQVcrc2NCMzJIZ0o2SFY1Z0JLbEg4L0FWOTA4bWUy?=
 =?utf-8?B?eVFiZjk0R1hJYzM2RVB3aEpKUHA0SEEzVk9Fb1BTSllvRDVCcWkzZnhIQ1JC?=
 =?utf-8?B?OW04Z0ZYWGp2Uk9zK254K0FvR0hKTkdIaDhzNjBMTmlZb3d3WDJRNzBxWXdN?=
 =?utf-8?B?RThheGl4Nmd4cUdmMThGWkZlZFJmQlFqeVc3K1FYdjV3MDJ0RVF3YWdoUUR5?=
 =?utf-8?B?N2ZZTGxzR2xJSDBNUTFkUERVaEFYOWx1am9xZlBmRDIvRUVJejJsRy9va1lh?=
 =?utf-8?B?cU16OTJFQWZLUFpYZzV3RlRPZWQ0cGxCU3YvcEQ1emVwZXRuV3dnd0hsdkRV?=
 =?utf-8?B?UVdGVE56WjVYYXlkdnpaczhBMWhpVWs1cHNiVldyNlBYekdvWEtBaWFoRE42?=
 =?utf-8?B?UTR4bCsxV3ZjTk93TitDeUd5WUVGaWZXb2ZTWHFvQUtsUWhQT2UvKzRWTnc1?=
 =?utf-8?B?eWNTdXJSZ2t5RzRBKzRXN3QwcGF4NzE0cmdrTjN0czZ4Y3VWSXVlUXB2cTBm?=
 =?utf-8?B?Nm9ZSnkyRy92NXBFa05zdGJZa0JEYWEzdElaRDJjNkt0RXc2NmtQWVdhdTJq?=
 =?utf-8?B?QTJQNlFLblp3YndvdWZmSDRkTVhsdmNwY0syUXIyUDcwdUpBS01aeWxFc29M?=
 =?utf-8?B?S2wxQUpDNENXc290aTlYb0lKdlcrWUs0Z0pHZGJSeVJNcUJXM3ZnZmtSWjA1?=
 =?utf-8?B?UnFvVEx5QlpuZkVuN2xIZnZySWJSMXZ6RTVhSlAwZXNaVmpva0dldGV4cjhT?=
 =?utf-8?B?dkhiMlloZzVSYzIxM3ZKdlVYcFo3SFkvMU1XZ24zY25PMzY4YkNKVkJsTUZu?=
 =?utf-8?B?WElIR3BYWTVkQTFwQ0FNUE1BdldqYlU1Z3pBMm1XaCtKdk9Na2Y4SWdqVWVK?=
 =?utf-8?B?V1VCTGY0RjloaEVmSlI5SVQ3ZGxqQTZyam4xSm9rbWR6eDZUYi9XRW00N1JG?=
 =?utf-8?B?Tlg1R0hGSGNwaEZGWFFBRzQzcUxnK0UwaHMrR0JQdTM4RU9FY3Q3STNra1Q2?=
 =?utf-8?B?UmUrZjlwWkhFaTRHWkZDYXRCT2REYmxGWWpHM2Q2TjBZS2pwMlVoWHFGUmZN?=
 =?utf-8?B?L21nUlhzRGtWMDR2aGI0YlloMVg0MjdCRzNQZi9YNjFKbUhVamJGTkN6U0pS?=
 =?utf-8?B?aTM1WFdaZ2NSeTY0UWpWMk1aNlJtOGRtNkJOZFNnUlBmZzdFUXNNY25yN0hl?=
 =?utf-8?B?R0RQdXFPWGhkSDVZbXh0UER3SExLdmZaUHczUnlWcGt1NEJ6OVA2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: G/3J1jj+vswzbnx3nbLuvhuxShgL+/nKqRvtXDYmla3muvHbSr/de1M2r29UhhQIpptheidlGJkvn7Oimwi2k1P2/IdRvwpTqnfsNzbmwOSwhwpNg2h7Sznv9TgbbeiqcnL2MEby2KAf66M1H17mfEgaYxjZcYQrkhgjMM5hVpNhfwCtESEKuQ/ZvquEC8cEdeiMhv3f/+T+d08IotplcLMcX2tug8O0Tge9R2I1PMXYj++vyyv0IgwnxaO2rDTHp4Jd/IeH0RdhwL/ZgurfGobrD7Vme35f0PgXEDVSsyrap52mwdyBLXFmJILu8AsdDgSFCVj7JLMIvQedThJcrQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f79d8f1-80f1-4e53-6ee6-08deafc758c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 01:39:45.5487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rludtI68m2EzIQLfPqMmeRc985BZu//djgFo/QMrseKJULDbwEIiiHNGgwpfDUTIG79ZXmm5JsuNIk8XBhRwXGa5WGov+/4WagTgMMgmuHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5605
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IA0KPiBKYW1pbiwNCj4gDQo+IERvZXMgdGhhdCBsb29rIGdvb2QgPw0K
PiANCj4gVGhhbmtzLA0KPiANCg0KTG9va3MgZ29vZCB0byBtZS4NCkFkZGVkIHJldmlldyB0YWcN
Cg0KVGhhbmtzLA0KSmFtaW4NCg0KPiBDLg0KPiANCj4gT24gNS81LzI2IDE1OjQwLCBBc2hpc2gg
QW5hbmQgd3JvdGU6DQo+ID4gVGhlIHRhcmdldF9pbmZvIHVuaW9uIGluIGR3X2kzY19hZGRyX2Fz
c2lnbl9jbWQoKSBkZWNsYXJlcyBwaWQsIGJjciwNCj4gPiBhbmQgZGNyIGFzIHNlcGFyYXRlIHVu
aW9uIG1lbWJlcnMsIGNhdXNpbmcgdGhlbSB0byBhbGwgYWxpYXMgYlswXQ0KPiA+IHJhdGhlciB0
aGFuIHRoZWlyIGNvcnJlY3QgcG9zaXRpb25zIGluIHRoZSBFTlREQUEgcmVzcG9uc2UgYnVmZmVy
Lg0KPiA+IFRoaXMgcmVzdWx0cyBpbiBkd19pM2NfdXBkYXRlX2NoYXJfdGFibGUoKSBiZWluZyBj
YWxsZWQgd2l0aCBCQ1IgYW5kDQo+ID4gRENSIGJvdGggcmVhZCBmcm9tIGJbMF0gaW5zdGVhZCBv
ZiBiWzZdIGFuZCBiWzddIHJlc3BlY3RpdmVseSwNCj4gPiBjb3JydXB0aW5nIHRoZSBkZXZpY2Ug
Y2hhcmFjdGVyaXN0aWNzIHRhYmxlIG9uIGV2ZXJ5IEVOVERBQSBvcGVyYXRpb24uDQo+ID4gRml4
IGJ5IHJlcGxhY2luZyB0aGUgYnJva2VuIG1lbWJlcnMgd2l0aCB1aW50NjRfdCBkIGFuZCBleHRy
YWN0aW5nDQo+ID4gZmllbGRzIHBlciB0aGUgSTNDIHNwZWMgRU5UREFBIHdpcmUgZm9ybWF0Lg0K
PiA+DQo+ID4gQWRkaXRpb25hbGx5LCBkd19pM2NfdXBkYXRlX2NoYXJfdGFibGUoKSBpbmNvcnJl
Y3RseSBzcGxpdHMgUElEIGFjcm9zcw0KPiA+IExPQzEgYW5kIExPQzIgYXQgYml0IDMyLiBQZXIg
dGhlIExpbnV4IGtlcm5lbCBIQ0kgZHJpdmVyDQo+ID4gKGRyaXZlcnMvaTNjL21hc3Rlci9taXBp
LWkzYy1oY2kvZGN0X3YxLmMpLCB0aGUgRENUIGxheW91dCByZXF1aXJlcw0KPiA+IExPQzEgdG8g
aG9sZCBwaWRbNDc6MTZdIGFuZCBMT0MyIHRvIGhvbGQgcGlkWzE1OjBdLiBGaXggdGhlIHNwbGl0
DQo+ID4gYWNjb3JkaW5nbHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBc2hpc2ggQW5hbmQg
PGFzaGlzaC5hNkBzYW1zdW5nLmNvbT4NCj4gPiAtLS0NCj4gPg0KPiA+IENoYW5nZXMgZnJvbSB2
MSA6DQo+ID4gMS4gUmVwbGFjZWQgYnJva2VuIHVuaW9uIG1lbWJlcnMgd2l0aCB1aW50NjRfdCBk
LCBhZGRlZCB3aXJlIGZvcm1hdA0KPiBjb21tZW50Lg0KPiA+IDIuIFJlcGxhY2VkIGxvb3Agd2l0
aCBiZTY0X3RvX2NwdSh0YXJnZXRfaW5mby5kKSA+PiAxNi4NCj4gPiAzLiBGaXhlZCBMT0MxL0xP
QzIgc3BsaXQgYXQgYml0IDE2IGluIGR3X2kzY191cGRhdGVfY2hhcl90YWJsZS4NCj4gPiA0LiBB
ZGRlZCBjb21tZW50IHRvIGkzYy5oIGNsYXJpZnlpbmcgaG93IGNvcmUuYyB0cmFuc21pdHMgdC0+
cGlkIGR1cmluZw0KPiBFTlREQUEuDQo+ID4NCj4gPiBMaW5rIHRvIHYxIC0NCj4gPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsL2V4ZHU1Mm11ZzZmaDNid2o3b2ZvM2psbHR5dXdq
Zm5kZHhvDQo+ID4gYmlvNHczamhhcTZ1djdrQGJveG8zajVvY2VmMi9ULyN0DQo+ID4NCj4gPiBU
aGlzIGJ1ZyB3YXMgZGlzY292ZXJlZCBkdXJpbmcgZW5kLXRvLWVuZCBFTlREQUEgdGVzdGluZyB3
aGVyZSBCQ1IgYW5kDQo+ID4gRENSIHZhbHVlcyBvYnNlcnZlZCBpbiB0aGUgY2hhciB0YWJsZSBy
ZWdpc3RlciBkaWQgbm90IG1hdGNoIHRoZQ0KPiA+IHRhcmdldCdzIGFjdHVhbCBCQ1IgYW5kIERD
UiB2YWx1ZXMuDQo+ID4NCj4gPiAgIGh3L2kzYy9kdy1pM2MuYyAgICAgIHwgMTYgKysrKysrKy0t
LS0tLS0tLQ0KPiA+ICAgaW5jbHVkZS9ody9pM2MvaTNjLmggfCAgNyArKysrKysrDQo+ID4gICAy
IGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvaHcvaTNjL2R3LWkzYy5jIGIvaHcvaTNjL2R3LWkzYy5jIGluZGV4DQo+
ID4gZDg3ZDQyYmU4OS4uMTdmZjQ4NGM1ZCAxMDA2NDQNCj4gPiAtLS0gYS9ody9pM2MvZHctaTNj
LmMNCj4gPiArKysgYi9ody9pM2MvZHctaTNjLmMNCj4gPiBAQCAtMTQ1OSwxMSArMTQ1OSwxMCBA
QCBzdGF0aWMgdm9pZCBkd19pM2NfdXBkYXRlX2NoYXJfdGFibGUoRFdJM0MNCj4gKnMsIHVpbnQ4
X3Qgb2Zmc2V0LCB1aW50NjRfdCBwaWQsDQo+ID4NCj4gUF9ERVZfQ0hBUl9UQUJMRV9TVEFSVF9B
RERSKSAvDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
aXplb2YodWludDMyX3QpKSArDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAob2Zmc2V0ICoNCj4gc2l6ZW9mKHVpbnQzMl90KSk7DQo+ID4gLSAgICBzLT5y
ZWdzW2Rldl9pbmRleF0gPSBwaWQgJiAweGZmZmZmZmZmOw0KPiA+IC0gICAgcGlkID4+PSAzMjsN
Cj4gPiArICAgIHMtPnJlZ3NbZGV2X2luZGV4XSA9IChwaWQgPj4gMTYpICYgMHhmZmZmZmZmZjsN
Cj4gPiAgICAgICBzLT5yZWdzW2Rldl9pbmRleCArIDFdID0gRklFTERfRFAzMihzLT5yZWdzW2Rl
dl9pbmRleCArIDFdLA0KPiA+DQo+IERFVklDRV9DSEFSQUNURVJJU1RJQ19UQUJMRV9MT0MyLA0K
PiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTVNCX1BJRCwgcGlk
KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1TQl9QSUQs
IHBpZCAmIDB4ZmZmZik7DQo+ID4gICAgICAgcy0+cmVnc1tkZXZfaW5kZXggKyAyXSA9IEZJRUxE
X0RQMzIocy0+cmVnc1tkZXZfaW5kZXggKyAyXSwNCj4gPg0KPiBERVZJQ0VfQ0hBUkFDVEVSSVNU
SUNfVEFCTEVfTE9DMywgRENSLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGRjcik7IEBAIC0xNTA3LDEwDQo+ICsxNTA2LDkgQEANCj4gPiBzdGF0aWMgdm9p
ZCBkd19pM2NfYWRkcl9hc3NpZ25fY21kKERXSTNDICpzLCBEV0kzQ0FkZHJBc3NpZ25DbWQgY21k
KQ0KPiA+ICAgICAgIGZvciAoaSA9IDA7IGkgPCBjbWQuZGV2X2NvdW50OyBpKyspIHsNCj4gPiAg
ICAgICAgICAgdWludDhfdCBhZGRyID0gZHdfaTNjX3RhcmdldF9hZGRyKHMsIGNtZC5kZXZfaW5k
ZXggKyBpKTsNCj4gPiAgICAgICAgICAgdW5pb24gew0KPiA+IC0gICAgICAgICAgICB1aW50NjRf
dCBwaWQ6NDg7DQo+ID4gLSAgICAgICAgICAgIHVpbnQ4X3QgYmNyOw0KPiA+IC0gICAgICAgICAg
ICB1aW50OF90IGRjcjsNCj4gPiArICAgICAgICAgICAgdWludDY0X3QgZDsNCj4gPiAgICAgICAg
ICAgICAgIHVpbnQzMl90IHdbMl07DQo+ID4gKyAgICAgICAgICAgIC8qIFBlciBJM0Mgc3BlYzog
YlswXT1QSUQgTVNCLCBiWzVdPVBJRCBMU0IsIGJbNl09QkNSLA0KPiA+ICsgYls3XT1EQ1IgKi8N
Cj4gPiAgICAgICAgICAgICAgIHVpbnQ4X3QgYls4XTsNCj4gPiAgICAgICAgICAgfSB0YXJnZXRf
aW5mbzsNCj4gPg0KPiA+IEBAIC0xNTQ0LDkgKzE1NDIsOSBAQCBzdGF0aWMgdm9pZCBkd19pM2Nf
YWRkcl9hc3NpZ25fY21kKERXSTNDICpzLA0KPiBEV0kzQ0FkZHJBc3NpZ25DbWQgY21kKQ0KPiA+
ICAgICAgICAgICAgICAgZXJyID0gRFdfSTNDX1JFU1BfUVVFVUVfRVJSX0RBQV9OQUNLOw0KPiA+
ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgICAgIH0NCj4gPiAtICAgICAgICBkd19p
M2NfdXBkYXRlX2NoYXJfdGFibGUocywgY21kLmRldl9pbmRleCArIGksDQo+ID4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGFyZ2V0X2luZm8ucGlkLA0KPiB0
YXJnZXRfaW5mby5iY3IsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdGFyZ2V0X2luZm8uZGNyLCBhZGRyKTsNCj4gPiArICAgICAgICB1aW50NjRfdCBw
aWQgPSBiZTY0X3RvX2NwdSh0YXJnZXRfaW5mby5kKSA+PiAxNjsNCj4gPiArICAgICAgICBkd19p
M2NfdXBkYXRlX2NoYXJfdGFibGUocywgY21kLmRldl9pbmRleCArIGksIHBpZCwNCj4gdGFyZ2V0
X2luZm8uYls2XSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGFyZ2V0
X2luZm8uYls3XSwgYWRkcik7DQo+ID4NCj4gPiAgICAgICAgICAgLyogUHVzaCB0aGUgUElELCBC
Q1IsIGFuZCBEQ1IgdG8gdGhlIFJYIHF1ZXVlLiAqLw0KPiA+ICAgICAgICAgICBkd19pM2NfcHVz
aF9yeChzLCB0YXJnZXRfaW5mby53WzBdKTsgZGlmZiAtLWdpdA0KPiA+IGEvaW5jbHVkZS9ody9p
M2MvaTNjLmggYi9pbmNsdWRlL2h3L2kzYy9pM2MuaCBpbmRleA0KPiA+IDZiYTkwNzkzYWQuLmRj
ZjhkOWIxNDMgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9ody9pM2MvaTNjLmgNCj4gPiArKysg
Yi9pbmNsdWRlL2h3L2kzYy9pM2MuaA0KPiA+IEBAIC0xMzgsNiArMTM4LDEzIEBAIHN0cnVjdCBJ
M0NUYXJnZXQgew0KPiA+ICAgICAgIHVpbnQ4X3Qgc3RhdGljX2FkZHJlc3M7DQo+ID4gICAgICAg
dWludDhfdCBkY3I7DQo+ID4gICAgICAgdWludDhfdCBiY3I7DQo+ID4gKyAgICAvKg0KPiA+ICsg
ICAgICogUHJvdmlzaW9uZWQgSUQuIFNpbmNlIGNvcmUuYyBzZW5kcyB0aGlzIExTQi1maXJzdCBk
dXJpbmcgRU5UREFBDQo+ID4gKyAgICAgKiB2aWEgKHBpZCA+PiAob2Zmc2V0ICogOCkpICYgMHhm
ZiwgdGFyZ2V0cyBtdXN0IHN0b3JlIGl0DQo+ID4gKyAgICAgKiBwcmUtcmV2ZXJzZWQgc28gdGhh
dCBwaWRbNDc6NDBdIGdvZXMgb24gdGhlIHdpcmUgZmlyc3QsIGFzDQo+ID4gKyAgICAgKiByZXF1
aXJlZCBieSB0aGUgSTNDIHNwZWMuDQo+ID4gKyAgICAgKiAgZS5nLiBmb3IgYSBkZXZpY2Ugd2l0
aCBwaWQgMHhBQUJCQ0NEREVFRkYsIHN0b3JlDQo+IDB4RkZFRUREQ0NCQkFBLg0KPiA+ICsgICAg
ICovDQo+ID4gICAgICAgdWludDY0X3QgcGlkOw0KPiA+DQo+ID4gICAgICAgLyogQ0NDIFN0YXRl
IHRyYWNraW5nLiAqLw0KDQo=

