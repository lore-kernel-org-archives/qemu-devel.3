Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB321061B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 03:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Psq-0003Z9-36; Mon, 30 Mar 2026 23:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1w7Pso-0003Xp-6q
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 23:35:14 -0400
Received: from mail-japaneastazon11011017.outbound.protection.outlook.com
 ([52.101.125.17] helo=TYVP286CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1w7Psm-0006pm-5Q
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 23:35:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E70eUts4TCQQKxoDlqExID/3j1KOjmaftH4ZDLnitc1z1ZOD7ZNopa7od18WOTrkP7SZU/aK2YU+Q15OgT1gRrfYy/TeHczAojZrotyzBu0kZXVXQt50x+RT7zCvRXRW8Xefa/7z8XIQT9PvXU1BT7YsLDu+zVH2hrX6bzwb+9oLdMwbezNs1MZ/0ceks+vnl7IrAZ7q53fgik0aliIuXJwhLCVJ4KwB5HNf54KfhRV6JFFcndcTSEtJOz6VlVw2hkoWh8ptgUkEJV4B8Q9UhuC3WZ5TLY4ZTFBf7LMMPF5CktC74CWJKC7fveiCutByyUjLueyKGbFSkgfyJ1Ycqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cvOpwzL9Yso88qTdlCAwftuZ+3im7ZWHT80xuwOIxU=;
 b=f6QtnBbsMG2hCrjna1FHSrQ21/hqReh4GNzotrvPAnCdywWh9q5CpkaO4c6jFlX55WiWwbkIrc9hKkcoc5kt2cdFXRLc2BdJ7TWd6M3Bz4wEoxKaf989ACg2stmMSfWULBXsdYVOna7LZAyER1KIdbQXWEyIVp1qxp+1RwtgdsTOoCJ14Y0xF7H0wOaQoBXW7KLltIuKTYFYkjDq6/3fIF20uSooO/M4A7Sv0QxCUBlSj6g+yqVEZo9Qu3SsE+PdsO5lqXo5MPr7GUR7l1V40HA4nhdbsRKWPUOBgyCpq9awHby8P137a8kzDaFamxsj+fW6ggxZ67JVlRsw5Mc4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cvOpwzL9Yso88qTdlCAwftuZ+3im7ZWHT80xuwOIxU=;
 b=Mn0f/tu9UkRu8Bi+UaifytkwVq2yu4GH0+L6R20gMHYZidoJUe6QsQMrafpJ7waupkc1PwqRuqiSALAqShEd2dvBwkV3vN18LBbLeHGQopYd9jTORmDILDonkt4KEEaT50hzQPMNREkIT6ijEfyRPcAte7b10CnXVI7m086JTtcv8Za+0rmVeSmr4SZ+Bk3Ni9T+Drap4eFTfRXfcWP1xT50M1XOFqqfqJlQH5cyrtfYT3ZHWXnJuf1+Ba88JA6cQSBXRkYV1sLNqCG3aZk9rOzklFI0Di7LRPMfUckRldF+LKKh4Jgm0lUVZh6dt2ubcuXJqlvxSCcFGk/UVa7o4A==
Received: from TY7PR01MB16837.jpnprd01.prod.outlook.com
 (2603:1096:405:32e::20) by OS3PR01MB7213.jpnprd01.prod.outlook.com
 (2603:1096:604:14b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 03:30:04 +0000
Received: from TY7PR01MB16837.jpnprd01.prod.outlook.com
 ([fe80::5812:babf:b430:670f]) by TY7PR01MB16837.jpnprd01.prod.outlook.com
 ([fe80::5812:babf:b430:670f%4]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 03:30:03 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Peter Xu <peterx@redhat.com>, Samuel Zhang <guoqing.zhang@amd.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "farosas@suse.de"
 <farosas@suse.de>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "Emily.Deng@amd.com"
 <Emily.Deng@amd.com>, "Victor.Zhao@amd.com" <Victor.Zhao@amd.com>,
 "PengJu.Zhou@amd.com" <PengJu.Zhou@amd.com>, "Qing.Ma@amd.com"
 <Qing.Ma@amd.com>
Subject: Re: [PATCH v3] migration/rdma: add x-rdma-chunk-size parameter
Thread-Topic: [PATCH v3] migration/rdma: add x-rdma-chunk-size parameter
Thread-Index: AQHcvbYDFS/bHmyF/0mRIclEy2/9xLXHQ/SAgAC98QA=
Date: Tue, 31 Mar 2026 03:30:03 +0000
Message-ID: <e3b261a3-25fa-42f9-a926-306e5a19cf75@fujitsu.com>
References: <20260327065006.2567463-1-guoqing.zhang@amd.com>
 <acqgZShXRkqzBU1C@x1.local>
In-Reply-To: <acqgZShXRkqzBU1C@x1.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB16837:EE_|OS3PR01MB7213:EE_
x-ms-office365-filtering-correlation-id: c5a94caa-9dab-41e9-5fec-08de8ed5cc46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|1580799027|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 82CD6clmYDYtDjS29sBB4i1pLwzwGOyc9RVGZBBpbY3I899zEB66k8zqyRspx14FCIjeMQqiUiMhXsQ/3LfWKsE4rd74QizOoZz++/Knr6Lrh72Jr7W5DCvOn3T/M2PpEz54PKoBbYqAwox6Wtdt0oZbTu36DvpbqE+GJ/XMQgmSUQso6dPo0wP8ceJ+rBnSWoR6/B3FM+gU2gNcnh9QETVaYAqnsvVETctmngmjFWKp5hzytzv6p8l0RdIOnvh7HkQrmlzuUEH7b8ecyhoHMNfkjx93bOGIXmLwc6+4HhL9VR0bSbG6xEHy3oIPKCsHZ7HbvFJqSmXKTADPDyXvEh44IV7bOFD6VTSpqgtM/yc4baUo8W/u3yG/oyJaU3FCFqV7qzRFLycJVnRvKyTnISiBg1riAiiLRYunhRHEJ/sZ9Ul1zOcDD/ddrEE0EC/731ertilwzkugf6EQ8YTxEhTtlxbwSGuTH/OSvc2NYq10DGQl3aOwozzXzNJBU2YWmdNyKVOyS/KUOCLVfFA/fFpmM/UA3N8CGwydwa0tFAvJKlSjoI75AN8QRHSLG7mVKaqSZo4696MHRAhRES1Bxge1kaT3724OSTHLUzpY69clg31joOMjVTsGxORtaooEuJBDMqkPMSIqg1a9NPf1VKl7cxveTAmbSU9sQZUI1lIOpe0ltWudgEb9rat0jhPRujVV9x1FhCiTVYT9pSoXVXx2oF6zmknhU3vgf+vtr7LIUXnpMcu+1GUteq9M6WRvVA9s2WWQelM1U+IsAozqPo7h3It0I/D9SACIdOCaK0RIGcExt9zlTIX0Nm5MIA/s
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY7PR01MB16837.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(1580799027)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHQzN3c3UVNuMi8xd0xXaWhZYVU0ZXVOb29pQWtTdnNFKzg5bndYaEJLd05U?=
 =?utf-8?B?MWNzMHgvY2ZIM3MrdFBTNXQ3Ym5Eb29YaUFTZkZsbXhPZjNlYzZHR0R3TS8v?=
 =?utf-8?B?S3JHTk5KMVNzNmRSMGVGb0dpVVkzMGdNbTczMGxWaEZkVmlkQmJQaXF1b0E1?=
 =?utf-8?B?d2N5QnUwSGlyMUE2VGZ2bW9SRVhUS2hpMUlaeVErT2FQdlUwb3hGc29raTJ0?=
 =?utf-8?B?TnN3V1kzZzhlOG1MZTN3ck9pOUFNemtWb0dMd2UwUC9ZRGIvT1A2ZW1kU3BM?=
 =?utf-8?B?RjBXeURrTkVQSFlnYytFUU9FeEJoa3lHV1FxRzBlZjJ3MjRqaGJmQlhEQ0U3?=
 =?utf-8?B?V1Axek5kTjk4aGlYa2VvbkpGV0xUVEZXV29BTmhFbUl1Vy96R3BidmcvMkJR?=
 =?utf-8?B?TWx6bGx6TEtzU2tZNTlGWUpMaTBXZWdNK2FUeVloM0VGckk0eDNlVHFCOXc3?=
 =?utf-8?B?bjhvam1MdjhGclk4UVNwS2NMbiszK3l2d3RzYS8xNTNJaWU2ZWtLejJXc2dD?=
 =?utf-8?B?ZnprbjFKMmtKb29IODFSMkhpSndsM1RUbDFFWnN4U3lNeGpUa2RiUUVrd3ZH?=
 =?utf-8?B?elp0OVZzZ0JSRlJDdEdBN1l5dzl2bFRlZjFtdmNpMWZoM2xJSGIvZndhb0Nt?=
 =?utf-8?B?VUNURTBvQ2hhRGVmNFE1Um8rY1NwbjJaQWkyVmZEMUk1cnVkY3ZtK1llbjFX?=
 =?utf-8?B?VVJFSW9JZ2JOdHdDN2NIMk9aaklvQjAxeGJXUU03emtId3d2N0g0SHoxSkR5?=
 =?utf-8?B?ZzlOWFYvU3ZjWEpvSTlFRTdUcGNIU2hDV01kZUp5aTdqUjhnNnFCQXhJWllt?=
 =?utf-8?B?Q2FFeXdHU3hSY0o3aU9MR1pLdFFFRWE2eTl1Z2RKeG5EY21xdmRUSDJjKzBB?=
 =?utf-8?B?NlM4MTRsTmU1a3MzVkVRMk12Y3JBMUh4S2tieHgvb1hsS1NONUlaaHFUd3hU?=
 =?utf-8?B?UmNYNGpPeEFIenhBRGFkeEtTdDlmWFJISE11MUgzcGNEZ01pMmJPQkF6RVRx?=
 =?utf-8?B?cDJvWWgyaWl3ZGJuT3lQRFpHcUVFUkF5TU12MHBONERMdU5HUDVSc2o1Z0h5?=
 =?utf-8?B?SnNiYUZOR29SSHV2NmNYSWt4VEhuTkFPTlRrWWlKNTRtTzFLTWNTeko4K3RN?=
 =?utf-8?B?U3VwVHBYRkxRSzROUU5qbWUxOFM2MnFqVEFZWHpLakZ1YVdma05KSHJQVEVD?=
 =?utf-8?B?NG1tdUk0cFQyaXpHUEF1ZTIram1UTG41TlJrck5lNld4aWpRUFBYUitlODVk?=
 =?utf-8?B?dU9lTmZpOUJjdTc2bWc0N0lkNVFWUjl4OXV6QWdpNXJvUkFvblE4ZGlWUzFN?=
 =?utf-8?B?WTFFdVA0dkhLZ0hNc2pDWFpYcXVDQythL2VYRW1hbFA2WFFaMEVzNEZhZEdl?=
 =?utf-8?B?NjBKUndxNnVoakorRzJZS0dQNU5rdEgxckVBdGlCcUdyMTdZcWFDQ2trNFRV?=
 =?utf-8?B?Uy9lMXR0bnhtTkpGQUdtcTU0VVczYTA3NHJDZ2tYckFqZkFIcUNacVhTTzdv?=
 =?utf-8?B?RGVya0UwNHFqdTAzRlBUTGprSXBtaStEbEJ6OXpRQ3JhQWRHV0h5dkx2aS9I?=
 =?utf-8?B?aHRXWXF4cDcvekNKVjNodm0vdFJtVkY3N1RuK3lGVzl0SHBsZlhhRDBWYURj?=
 =?utf-8?B?ZzRDYnRtZTFLWlZZTDhDaWFqMlJpL0Zac3lEdUdYOERORXJGRmYxdkloQi90?=
 =?utf-8?B?RFY1eFExOXhGd2xZTks2d240MXdkN29Tamc3T08xM3FOU25IY0NpcTNDMjJL?=
 =?utf-8?B?dSttWHJuTGJjVlo4Rll2MTh5WWQzUWplNjdzcElNWDNWa1hLb0l5Vi9PN3Zr?=
 =?utf-8?B?NVFpamNrQ0Vyb2lSYWhYSHZxcTlpcWN2NDN1TmFyUWVuOXRZanNmMjBROFVx?=
 =?utf-8?B?aGVyQUlJM2trWmdVdldVNGM0WjdCWWJpc1JhTFF0bGZkNUNUWkt1R0E0N1Bw?=
 =?utf-8?B?cm1sK3k0WGlIakZ1dmZmWEw0eHVDUGNWK1RuSE1sWFpNWDc3RGU3QlF4eEFC?=
 =?utf-8?B?ei9acHlQUFZmaThLU2MyS3pOT1BJSk9kcm5VUURrOGYyczVWb0Z3aVROQzh4?=
 =?utf-8?B?OFlHTHQvSFhISXhxOGsrTXlpclFRWDJCTWJzcmtxS2czclBaZExqeXdKZkJX?=
 =?utf-8?B?NWpsdVJVODV6dWlVYlZZbW5kZ3J0N2Vrc0prcW4vVjE5RDZDYjdKWWdZUnJs?=
 =?utf-8?B?MnpCWlpsSVlzKzFLMFVIMGhQODRBMitlUXlPYU1hZ3JkUkQvSXZlQ1N6bkVX?=
 =?utf-8?B?c0QrcmFadEs3UVEyeWwwbzJnVUlMa3VxYUx0MDMzOUNsZHoxclJpU2Z0cjUw?=
 =?utf-8?B?bFlCQ0tLbXFPQlVGaFU2OEg1cHNoaDk1ZTVkNERtdVQzR1Q2VXcyZThnVmc0?=
 =?utf-8?Q?FLPkuraVDF38U4F0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <771633768948234CAB3A255BFBC721C5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nl9Wz2dYB5/Zs+Rbj9ApCyQuaiqvjN1WCqa6p1SkevofKgb5+Rxp4BCycRzOJQ3cZs2KYUhrtrUcqItZkSa7478T4Kqt1Ws3A9fNwX9dAoCobqb4HajRT4PDSlyG0vAr3pZwoBcApgJiyS+DxUcxyfi+MjwQZ1Ajz3erCbOr/UpPR/82HcirSkgfFMcO5rZsEaYCY+6vZSZR10m50xoy93xdWClgO8sJTrEX7/cdzyQ1Zv2RUK3IQmfxrrhaizEwL/ztX6yGQq3V810otxLyUr10bB1qrbKUZMRRTvBJGNugB4T/xyP3M5Eaubtl94NTSGCMYK5ea+fEFjOcou/ngg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB16837.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a94caa-9dab-41e9-5fec-08de8ed5cc46
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 03:30:03.8966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PnVtfZcPiSH7W9w05waeeoiCLCwdK6XD8rbCT7qx5MOgk9EXUjmC+/NgKp2zA1M03ovAU3lQQ5R4J8vAZ36yng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7213
Received-SPF: pass client-ip=52.101.125.17; envelope-from=lizhijian@fujitsu.com;
 helo=TYVP286CU001.outbound.protection.outlook.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

DQoNCk9uIDMxLzAzLzIwMjYgMDA6MTAsIFBldGVyIFh1IHdyb3RlOg0KPiBIaSwgU2FtdWVsLA0K
PiANCj4gT24gRnJpLCBNYXIgMjcsIDIwMjYgYXQgMDI6NTA6MDZQTSArMDgwMCwgU2FtdWVsIFpo
YW5nIHdyb3RlOg0KPj4gVGhlIGRlZmF1bHQgMU1CIFJETUEgY2h1bmsgc2l6ZSBjYXVzZXMgc2xv
dyBsaXZlIG1pZ3JhdGlvbiBiZWNhdXNlDQo+PiBlYWNoIGNodW5rIHRyaWdnZXJzIGEgd3JpdGVf
Zmx1c2ggKGlidl9wb3N0X3NlbmQpLiBGb3IgOEdCIFJBTSwNCj4+IDFNQiBjaHVuayBzaXplIHBy
b2R1Y2VzIH4xNTAwMCBmbHVzaGVzIHZzIH4zNzAwIHdpdGggMTAyNE1CIGNodW5rIHNpemUuDQo+
Pg0KPj4gQWRkIHgtcmRtYS1jaHVuay1zaXplIHBhcmFtZXRlciB0byBjb25maWd1cmUgdGhlIFJE
TUEgY2h1bmsgc2l6ZSBmb3INCj4+IGZhc3RlciBtaWdyYXRpb24uDQo+PiBVc2FnZTogYG1pZ3Jh
dGVfc2V0X3BhcmFtZXRlciB4LXJkbWEtY2h1bmstc2l6ZSAxMDI0TWANCj4+DQo+PiBQZXJmb3Jt
YW5jZSB3aXRoIFJETUEgbGl2ZSBtaWdyYXRpb24gb2YgOEdCIFJBTSBWTToNCj4+DQo+PiB8IHgt
cmRtYS1jaHVuay1zaXplIChCKSB8IHRpbWUgKHMpIHwgdGhyb3VnaHB1dCAoTUIvcykgfA0KPj4g
fC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLXwN
Cj4+IHwgMU0gKGRlZmF1bHQpICAgICAgICAgIHwgMzcuOTE1ICAgfCAgMSwwMDcgICAgICAgICAg
ICB8DQo+IA0KPiBUaGlzIGlzIHRoZSBkZWZhdWx0LiBJdCBzdXJwcmlzZWQgbWUgYSBiaXQga25v
d2luZyBpdCBjYW4gb25seSByZWFjaCAxR0Ivcw0KPiB0aHJvdWdocHV0IHdpdGggdGhlIGN1cnJl
bnQgY29kZSBiYXNlLiAgRG8geW91IGtub3cgd2h5PyAgSSB0aG91Z2h0IFJETUENCj4gc2hvdWxk
IGJlIG11Y2ggZmFzdGVyIHRoYW4gdGhpcyBvbiB0aHJvdWdocHV0IHdpdGggd2hhdGV2ZXIgaGFy
ZHdhcmUgc2V0dXAuDQoNCiAgDQpSZWdhcmRpbmcgdGhlIGJhc2VsaW5lIHBlcmZvcm1hbmNlLCBT
YW11ZWwncyBudW1iZXJzIGxvb2sgcmVhc29uYWJsZS4gSSBjaGVja2VkDQpzb21lIG9mIG15IG9s
ZCB0ZXN0IGRhdGEgb24gYSBDb25uZWN0WC00IEx4IGNhcmQgeWVhcnMgYWdvLCBhbmQgdGhlIHRo
cm91Z2hwdXQNCndhcyBhcm91bmQgMTAgR2JwcyAofjEuMjUgR0IvcyksIHdoaWNoIGlzIGNvbnNp
c3RlbnQgd2l0aCB0aGUgMSBHQi9zIGhlIHJlcG9ydGVkLg0KDQo+IA0KPj4gfCAzMk0gICAgICAg
ICAgICAgICAgICAgfCAxNy44ODAgICB8ICAyLDI2MCAgICAgICAgICAgIHwNCj4+IHwgMTAyNE0g
ICAgICAgICAgICAgICAgIHwgIDQuMzY4ICAgfCAxNyw1MjkgICAgICAgICAgICB8DQoNCk15IGd1
ZXNzIGZvciB0aGUgZHJhbWF0aWMgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgaXMgdGhhdCBhIGxh
cmdlciBjaHVuayBzaXplDQphbGxvd3MgcWVtdV9yZG1hX3dyaXRlKCkgdG8gYmF0Y2ggbW9yZSAq
Y29udGlndW91cyBkaXJ0eSBwYWdlcyogaW50byBhIHNpbmdsZSwNCm1vcmUgZWZmaWNpZW50IFJE
TUEgc2VuZCBvcGVyYXRpb24uDQoNCklzIHRoZXJlIGFueSB3b3JrbG9hZHMgcnVubmluZyBvbiB0
aGUgZ3Vlc3QgZHVyaW5nIHRoZSBtaWdyYXRpb24sIG9yIGp1c3QgYW4gaWRsZSBndWVzdD8gQFNh
bXVlbA0KDQpHaXZlbiB0aGUgc2lnbmlmaWNhbnQgYmVuZWZpdCBhbmQgdGhlIGZhY3QgdGhhdCB0
aGUgcGF0Y2ggaXRzZWxmIGlzIHN0cmFpZ2h0Zm9yd2FyZCwNCkkgdGhpbmsgaXQncyBhIHdvcnRo
d2hpbGUgYWRkaXRpb24uDQogIA0KQWNrZWQtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWpp
dHN1LmNvbT4NCg0KDQoNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTYW11ZWwgWmhhbmcgPGd1b3Fp
bmcuemhhbmdAYW1kLmNvbT4NCj4gDQo+IE9uZSB0aGluZyB0byBtZW50aW9uIGlzIFJETUEgbWln
cmF0aW9uIGlzIGluIG9kZC1maXhlcyBzdGFnZSwgYWN0dWFsbHkgaXQNCj4gZG9lc24ndCBoYXZl
IGEgcmVhbCBtYWludGFpbmVyIHNvIGl0IGlzIGtpbmQgb2YgIm9ycGhhbmVkIi4gIEluIHRoaXMg
Y2FzZSwNCj4gSSBhY3R1YWxseSB3b24ndCBzdWdnZXN0IHdlIGFkZCBhbnkgbmV3IGtub2JzIGZv
ciBwZXJmb3JtYW5jZSByZWFzb25zLg0KPiANCj4gRG8geW91IGhhdmUgYSBzdHJvbmcgcmVhc29u
IHRvIHByb3Bvc2UgdGhpcyBwYXRjaCB0byBsYW5kIHVwc3RyZWFtPyAgSXMgaXQNCj4gdXNlZCBp
biBwcm9kdWN0aW9uIHN5c3RlbXMgYW5kIGl0IHNvbHZlcyBzb21lIHJlYWwgcHJvYmxlbXMgZm9y
IHlvdT8NCj4gDQo+IEkgYWxzbyB3b25kZXIgd2hhdCBaaGlqaWFuIHdvdWxkIHNheSBvbiB0aGlz
Lg0KPiANCj4gVGhhbmtzLA0KPiANCg==

