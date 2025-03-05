Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C84AC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 14:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpq0V-0007mU-68; Wed, 05 Mar 2025 09:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <benjamin.charlton@avanti.space>)
 id 1tpq0T-0007m7-1l
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:45:57 -0500
Received: from eu-smtp-delivery-113.mimecast.com ([185.58.86.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <benjamin.charlton@avanti.space>)
 id 1tpq0Q-0001jA-V6
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avanti.space;
 s=mimecast; t=1741185952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TUyBkW02G7rivP4qTIzQR6wgfVfMwE5ipAuYm/ThT58=;
 b=oCCP6VJqaSqKmUygurFM4oNDiiPGCjiGhL5EDknVZMkDWEN6Q2/2lE1xgWQdI3Rl+aPvXb
 6QHVTq0qAC+e5LsubYUe72HcKzTC3Fn4AqawTEY0dlZcYQBVLUbWVN/vZDdP78N3iLUPqu
 rmbpVPYB9YF1GCFgTZlJmfbppjWjO9QJ0F0D/IImNFTOs9KurZJ4jxB8zmDqUdRbn1wJwC
 ObrSIOI93TB1ABTGtNTC7dcv3n9mza5Bwk9eE4LdWMWLjlSmZeDxHve3J5IHd97Vf8sRea
 miJGEhUFGsPp36hCB7wXurQzuMK0VAUMMGEZt3eE4b0qRVvATXJ6b/tj7zehfA==
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazlp17010007.outbound.protection.outlook.com [40.93.68.7]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id uk-mta-203-ytoJ9L_YNA21wbM2D0gs9A-1; Wed,
 05 Mar 2025 14:45:50 +0000
X-MC-Unique: ytoJ9L_YNA21wbM2D0gs9A-1
X-Mimecast-MFC-AGG-ID: ytoJ9L_YNA21wbM2D0gs9A_1741185950
Received: from CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ab::5)
 by CWXP265MB3671.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Wed, 5 Mar
 2025 14:45:48 +0000
Received: from CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4ce0:4462:93f1:c448]) by CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4ce0:4462:93f1:c448%3]) with mapi id 15.20.8511.012; Wed, 5 Mar 2025
 14:45:48 +0000
From: Benjamin Charlton <Benjamin.Charlton@avanti.space>
To: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: QEMU and ia64
Thread-Topic: QEMU and ia64
Thread-Index: AduNqQoHF9c3rKgrRlW1uncurdpCowAM98IAAAAK5WA=
Date: Wed, 5 Mar 2025 14:45:48 +0000
Message-ID: <CWXP265MB5671956F2A0F0C4FE92072ED92CB2@CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB56711557D89741FDF97E192592CB2@CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM>
 <d498d57a-4b7a-41ff-86a0-4c704e2c1679@redhat.com>
In-Reply-To: <d498d57a-4b7a-41ff-86a0-4c704e2c1679@redhat.com>
Accept-Language: en-US, en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWXP265MB5671:EE_|CWXP265MB3671:EE_
x-ms-office365-filtering-correlation-id: 9358551f-27a0-4e08-a69b-08dd5bf46b58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018
x-microsoft-antispam-message-info: =?utf-8?B?N3RvMEZORFBMSStxZGsrWWJVWFIvcUVKOTRFcUNqU0JtQzgxOW0xTm5USFV4?=
 =?utf-8?B?VjQwVERUS1RCb2ZnQlgzRklNT08xSWVUMHh0cU5DRkc3aEFQVDdGVlZxMlZE?=
 =?utf-8?B?ampraEwxZVhBNXpuWmRSM3B3ejYwQnVQT3JaQ0dsT0hTQVEvMnB6M1ppc0tH?=
 =?utf-8?B?dzF6anYyNFM1cnBvbzF5QWZ5Mk1XNDc3K29BeXIrRTR2ZnZVdWkyRnBtc2ZF?=
 =?utf-8?B?MVYyeW9XUHI4bCtnRUl6anh2Q3ZpUG9VbHJSbXFZWHlsd2JNdzZvc2hLblU4?=
 =?utf-8?B?WE9JYmJIV1dxMklqcjhwekR1ZWgrbXVIZXNVQmc5OThzbzljWDMrL1FOVFgr?=
 =?utf-8?B?YnZkYmV5bWFXUmRTMmdMaWkwRU96aGp1aDNKWEhVWFZNb0hNRUF3MnZOcjB3?=
 =?utf-8?B?V0x6dHNhM1dxeUlZTHRlRWJiVXdabEkwaktnM2k4anRWckFJQWRvZlJqdUov?=
 =?utf-8?B?UytkZnUwUnoxL3JacE5yNG9IMGI4b0pwL29HZlBzTUZyNDlkcU0xQ29GOUxm?=
 =?utf-8?B?Zlo5QXY3bmpXTnMrWUFFUUF1V2tsSnNQeU1neVdMV1pLVEZIVlI3WmduWkFn?=
 =?utf-8?B?dEtRZzYreHQrL2ZjU3lPdUw4eVczdzl4eFN2VDlSSnlBOS84TEEvQkdXSHM1?=
 =?utf-8?B?aW5iM2pBRy84aThPWkVhaU04am9jSmZiUlp4a0NCa29tTTNRdFphUXZ2SzJk?=
 =?utf-8?B?ZURqTWhBeXVUd0QyRXAySjhjYlZTZ1hFd0M0ODRKUkVUQnRJSGxmUXFOcU81?=
 =?utf-8?B?M0J2TG1zby8zdWJPbFJNSk5hQzBobWJIWFpxaGhyTVpKb3RadUdxVENvMXpU?=
 =?utf-8?B?aDRVWTUxTmpvVnFtTndHTjVwN0gweHJWMGZnSEJJdzU2QmxxU0tJeUxxQWJw?=
 =?utf-8?B?Q2NXU3lmZWQwbkExMXM1eVZRMThOa2FPbjdCTkZjQzhiN2JCb085TzdUSmFG?=
 =?utf-8?B?bytOMnpyc1prME9ueG5lZTgybDJoUUNEMG9jd1RIUmpRVDE1L2NBSFh2MFgz?=
 =?utf-8?B?YUgrMFNyZ1VCT3RGcTRmcWdSeXNPaXJmYVBiNkJHdHpHOFF0L2xxaUs0cXFo?=
 =?utf-8?B?TjRpTGt2UTBySVdtdlBNT3VyNG5FWkdVM213Y2NrbHNyRGUyanFjUER3S3NM?=
 =?utf-8?B?TEErcmdObDgvaXYwcXE0Z1VMZithcjFYZUNQMElYZnJnemlHcnNscTg3aFdx?=
 =?utf-8?B?NDlyZys3c3RGVzR2d3lZL3pCTFFyd1MrSGJJYTRNbjlCU3NpWHRnM1VqVHli?=
 =?utf-8?B?TitQa0FDYVNxRHVJYnhuTkhaUS9LekVLZ3dtNHdlSERuem1QU05IR0VrWHls?=
 =?utf-8?B?ZjhWOVN6amx3VUZCMHVFY3ZSakxURmgxQ0JvS1RJaUVib2NiNmVndjU2UUxl?=
 =?utf-8?B?Qm9EZU9DRG1jV0pCbWZkZGovdlVNcDNGa1FqbFVHWnRoTDB3UjJ4UGpZV055?=
 =?utf-8?B?aFh1YkpkK1Y1NzNCUnU2ZWJTa0t3K3VrQXpUcnNXY1pseXM2RDZsaUxtcnJD?=
 =?utf-8?B?aEFiMUxyVDJGV3BZamcwNHF0NEp1L2hHdHZjSVR1ZG54eHB5WVV4R3VscjVM?=
 =?utf-8?B?WjVOak9WUGtUMjREMzA3MVUzK211SE5KMVZoZDdYYzUxeExQeVFoTnhPVVVL?=
 =?utf-8?B?S2tuT25kS3BFYzdEektodWFXSWxuN2VkdXE1U2pKZW1xS1Y4cmdmcTdaSlpt?=
 =?utf-8?B?UzJQOExSU1AwUXpyUytwOVJsS0luUmNXQ3d3SFJUSHA0MHorbzJhMVZIVXZn?=
 =?utf-8?B?UlNjMFkvcUpRYktuOHNnclBtcjBQL0ZjUVl1Z2xtVVJWVW9iTGVCK3krTU8v?=
 =?utf-8?B?RnFVZTQzdmluTjVya1VDUytjTC9aWDJNcE5TcDZYNlQzNllBSXR4anlZL0Vl?=
 =?utf-8?Q?z6H2sSVjKodOt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEF2bzBubUhkQXF1YmdIcFM5UjA2bjNESDJvbzBRWWxSZnF6VGdDZjJ1TWdP?=
 =?utf-8?B?bk5YNURHVmsyNDBMeENIamZ1K29HdE9OWnRuRHpzSUp5REJIektmZUM1cVFS?=
 =?utf-8?B?aytabXczd2pRYVV0V0svRjM1ZWp3QkduU0ZVQ1N3dnE3cVBiczFkcXo1NDV0?=
 =?utf-8?B?OHJ6eW5TZjlGbVlNaS9lanFTR3RHNjlQMWYzR1VZbjBxSW5CSC9lazNnaHcy?=
 =?utf-8?B?bG82SDA1Qitudm1yL1hIblhZNkRzeU51Tk9kRTE2VHRuV3ZNbzZBUEFsTDNh?=
 =?utf-8?B?MWlZSXNiS0dqell3cmZOS0krY0hpVjdVZ2VPVWhndC85emRhMVZIRzRoNGpj?=
 =?utf-8?B?M2I4V0xFVDJwWWtVMHc4eFR4dGFIS3R0S1N5UEs5VWZjVWVKbTY1a0hCbVZs?=
 =?utf-8?B?WVRDMFpncTMyVGxiMzFIdk42VkxRZnR3czM1NGo0KzYwQlJGUzcyOU94aVQ4?=
 =?utf-8?B?SEVoRCtUN0w0L0NtMUFsZlZROS9XNUowVUtNMjVYUmxXZTJOeUx2cXJWK3Va?=
 =?utf-8?B?R1hNUktKbVh1c01YcmF3STNHS3ZXUHZ3Q28xWXNabk9qbWQ4RWdLZXg2eEN4?=
 =?utf-8?B?K2ZHbEcyYWtveTBabGw1cUxCMVhPZVN1N0ZwMkk3ZWtCdUsxZENEREFJYWQx?=
 =?utf-8?B?b2tzckNEUnJrMWhGdFB3aHN5c29DTnpZSzg0eUoyY1JaNTJYTUZUKzNiK1BO?=
 =?utf-8?B?Nk1Qc21vZUVvWGlkSHpiYlNDWHY5RXBxNFhlK3pnN2FvZU00V2NLN0RtODhP?=
 =?utf-8?B?eFdybXdGdzl1bThGdnZNczRPYjNBR0liMTNnTU8ydVRQL1VlWS9YMEhyMndp?=
 =?utf-8?B?L1RtWjRURFVlN1RyL3dQTEkrb3luOGs2SVhLY0NrT1E1eVdOQS9PUzM3V2pP?=
 =?utf-8?B?UTRKb2JXbUFhS0tXSGRsa0QvQ2xSVGVxbUJYMlFGaWZKd2pLdkxBN0FBaCs3?=
 =?utf-8?B?cTkyZDdJQ3Y0RmQrS0x5Qnh0UVVQUFNWRWpGaEhUQVNoYjUwTE1Lekl2WUNh?=
 =?utf-8?B?YjJtSzRWTHNPYllvV3V1WmJNMUhJOGp2Mk1VWlZ5S1FGNkh0OUJaSWw0QnNM?=
 =?utf-8?B?QjlNY1JycStFNUowTjlBVEhBNy93OXlLTHZnWlNwaGpiQ3JlL2hSdjZ4cmRl?=
 =?utf-8?B?V1FTazR2RFYwcXk4SHFTY3NOMlVDNlArTjRrOWd5RUxycHBsZk9hbkdsVXAx?=
 =?utf-8?B?VURES0xPcHluV0xiSnJNczBURzFKNzVsUUwwZFpaOUszZllLT3daRENGMzht?=
 =?utf-8?B?Q0JTOWYxNE9jK1MzaVZEZFFOMFU0UlhhaThzZ1lReG1pMGtSbVNCSGFzSWhx?=
 =?utf-8?B?dU0wWmpYTzdCYmlwOWJxb25ONXdsT1RyVU9jYWp5YzZFSzhzSFB4WUJSR2tx?=
 =?utf-8?B?aWZtTm1lMkFnOHA2QTZ1UitpaFdxVkh6NzRoNHZkVExtK0FTNXVCdFRCcEUw?=
 =?utf-8?B?dFc3YVVJZnc3ZVVjanJIdmprTTh6NlgrNGtKR0ROMW5FWnJOZDFlN3Z4ZWMz?=
 =?utf-8?B?VlZic1dWUjNTUkoyaTdFVG1EN2EwTHl3S2o4cjhhd25MdlMyNlBDUDgxUi9Q?=
 =?utf-8?B?b21CcHBIT2FhSjBrREZ3N2dMcHlXRUQxM2dKazZpSU9iYVRCZG4xaFJHTHpm?=
 =?utf-8?B?ODdjcGtlWCt2ek5nZVczaXVYQjhtWkIwUS9SbGZWQWdCTDZ0SUdERjN4UFA3?=
 =?utf-8?B?V0ZOOXhibGhPalZscDFiOHNKWE4xTW9yVDBxM3VwK2NzMnpjZUdZeEJyanpX?=
 =?utf-8?B?SUdDTS9URDRTSFp0aE9WSkdNeFlhRHlaUENqbGxmYUg4ZVJlSzJSUTZVbUY3?=
 =?utf-8?B?NnNud0hpMTJxbUZ5NCtzNlhVLzF1aDJacEVFcklOS0VIeFZ2TmhhaXg4Q2ZQ?=
 =?utf-8?B?dHErTFhGVGtESjgzS1ZxR05TQXZDU2FubzlsVllyQ0tCREZqeWl1UmxJUUQ0?=
 =?utf-8?B?RW40MFdIcDBJVmNPWHlmZTNmYW9LQWZBUkx6NUR4L24zOWlFaGYvRkRiblAy?=
 =?utf-8?B?QWIyY0lmTVhOaElPK3RQZXBZYjlCNzJTRWUrWjVSd2JVZThkK25QOWttazRU?=
 =?utf-8?B?R29JTGYrVFJ6ZjVGQTFiRjVQdXNzZEp3WTVTcG8vUjc2UUh1QWlIUE5iK2FU?=
 =?utf-8?B?eFYzR0xBdmtsMjduVXZKR29VUkJyS2hxTHltVjJ5Y3lhTDZrWnpRRHlYUmpj?=
 =?utf-8?B?OFE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: avanti.space
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9358551f-27a0-4e08-a69b-08dd5bf46b58
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 14:45:48.7501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 65459471-455c-42b0-b4e2-298d6f2c5992
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dT1luIdkaCHqq4eaS4spvKFk3iF3AmF1yKuvAiWwauo6p4eO6IBI5PL8IN0CNJF1LjpXfHHRtPRJjPs1bVBBp3aDLXoXKlQIHYjZYDDULJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3671
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 510oPcqSacBfxJ8Z8l4cmrKscCTgpOfqD6XoQ1NrSnc_1741185950
X-Mimecast-Originator: avanti.space
Content-Type: multipart/alternative; boundary="MCBoundary=_12503051445513201"
Received-SPF: pass client-ip=185.58.86.113;
 envelope-from=benjamin.charlton@avanti.space;
 helo=eu-smtp-delivery-113.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_IMAGE_ONLY_32=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--MCBoundary=_12503051445513201
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGVsbG8sIA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXBseS4NCg0KWWVzIEkgd2FzIHN0YXJ0aW5n
IHRvIHRoaW5rIHRoYXQgd2FzIHRoZSBjYXNlLg0KDQpEZWFkIGVuZCB0aGVuIEkgZ3Vlc3MuDQoN
CkJlc3QgcmVnYXJkcywNCg0KDQpCZSBNb3JlLg0KQmVuamFtaW4gQ2hhcmx0b24NCkdyb3VuZMKg
Q29udHJvbMKgU3lzdGVtc8KgRW5naW5lZXINCkF2YW50aSBDb21tdW5pY2F0aW9ucw0KR29vbmhp
bGx5IFNhdGVsbGl0ZSBFYXJ0aCBTdGF0aW9uLCBHb29uaGlsbHkgRG93bnMsIEdvb25oaWxseSwg
SGVsc3RvbiwgQ29ybndhbGwsIFRSMTIgNkxRDQp0OiArNDQyMDc3NDkxNjAwDQp3OiB3d3cuYXZh
bnRpLnNwYWNlDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFRob21hcyBI
dXRoIDx0aHV0aEByZWRoYXQuY29tPiANClNlbnQ6IDA1IE1hcmNoIDIwMjUgMTQ6NDMNClRvOiBC
ZW5qYW1pbiBDaGFybHRvbiA8QmVuamFtaW4uQ2hhcmx0b25AYXZhbnRpLnNwYWNlPjsgcWVtdS1k
ZXZlbEBub25nbnUub3JnDQpTdWJqZWN0OiBSZTogUUVNVSBhbmQgaWE2NA0KDQpDQVVUSU9OOiBU
aGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIEF2YW50aS4gRG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pc2UgdGhlIHNlbmRl
ciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoNCk9uIDA1LzAzLzIwMjUgMDkuMzcs
IEJlbmphbWluIENoYXJsdG9uIHdyb3RlOg0KPiBIZWxsby4NCj4NCj4gU29ycnkgdG8gYm90aGVy
IHlvdSwgSSBhbSB2ZXJ5IG5ldyB0byBhbGwgb2YgdGhpcyBhbmQgYnV0IEkgYW0gbG9va2luZyAN
Cj4gZm9yIGENCj4gaWE2NCBlbXVsYXRvciwgc2FkbHkgaXQgaGFzIHRvIGJlIHRoaXMgdG8gcnVu
IGEgcGllY2Ugb2Ygb2xkIHNvZnR3YXJlLiANCj4gR1BUIHN1Z2dlc3RlZCBJIGNsb25lIHlvdXIg
cHJvamVjdCBhbmQgZW11bGF0ZSB0aGlzIHByb2Nlc3Nvci4gSG93ZXZlciANCj4gSSBhbSByZWNl
aXZpbmcgYW4gZXJyb3INCg0KV2VsY29tZSB0byB0aGUgd29uZGVyZnVsIHdvcmxkIG9mIEFJOiBD
aGF0R1BUIGxpZWQgdG8geW91LCB0aGF0IHdhcyBqdXN0IGEgaGFsbHVjaW5hdGlvbiwgUUVNVSBk
b2VzIG5vdCBzdXBwb3J0IHRoZSBpYTY0IGFyY2hpdGVjdHVyZSBhcyBhIHRhcmdldC4NCg0KICBU
aG9tYXMNCg==
--MCBoundary=_12503051445513201
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<html><body>Hello, <BR>
<BR>
Thank you for the reply.<BR>
<BR>
Yes I was starting to think that was the case.<BR>
<BR>
Dead end then I guess.<BR>
<BR>
Best regards,<BR>
<BR>
<BR>
Be More.<BR>
Benjamin Charlton<BR>
Ground&nbsp;Control&nbsp;Systems&nbsp;Engineer<BR>
Avanti Communications<BR>
Goonhilly Satellite Earth Station, Goonhilly Downs, Goonhilly, Helston, Cor=
nwall, TR12 6LQ<BR>
t: +442077491600<BR>
w: <a href=3D"http://www.avanti.space" target=3D"_blank">www.avanti.space</=
a><BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Thomas Huth &lt;thuth@redhat.com&gt; <BR>
Sent: 05 March 2025 14:43<BR>
To: Benjamin Charlton &lt;Benjamin.Charlton@avanti.space&gt;; <a href=3D"ma=
ilto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a><BR>
Subject: Re: QEMU and ia64<BR>
<BR>
CAUTION: This email originated from outside of Avanti. Do not click links o=
r open attachments unless you recognise the sender and know the content is =
safe.<BR>
<BR>
<BR>
On 05/03/2025 09.37, Benjamin Charlton wrote:<BR>
&gt; Hello.<BR>
&gt;<BR>
&gt; Sorry to bother you, I am very new to all of this and but I am looking=
 <BR>
&gt; for a<BR>
&gt; ia64 emulator, sadly it has to be this to run a piece of old software.=
 <BR>
&gt; GPT suggested I clone your project and emulate this processor. However=
 <BR>
&gt; I am receiving an error<BR>
<BR>
Welcome to the wonderful world of AI: ChatGPT lied to you, that was just a =
hallucination, QEMU does not support the ia64 architecture as a target.<BR>
<BR>
  Thomas<BR>


    <br>
    <br>
    <table border=3D"0" cellspacing=3D"0" cellpadding=3D"0"><tr><td><a href=
=3D"https://www.avanti.space"><IMG border=3D"0" src=3D"https://eu-api.mimec=
ast.com/s/store/8tiInYxF340R6JeVLWUTdpmCh441t-hlPzFwDArFFMEOVhst0cFFOumhi_4=
e_kI2pZtyA0bTWpmB0jcfK820H6RtaCm5BjcFcGscsTZHotvVi-9NqQbhIKfhy8n0FciGysn5mC=
YJZkfoTze2RGCzrr8hgYDuECFDg0r2EoSnyoqy_YbcNejDFyHZK_DKqCdG" ></A></td></tr>=
</table>
    <br>
    <br> =20
DISCLAIMER: This email including any attachments is intended only for the p=
erson(s) ("the intended recipient(s)") to whom it is addressed and it may c=
ontain confidential or privileged information. The contents of this email m=
ust not be disclosed to anyone else. If you are not the intended recipient =
please notify the sender immediately. Avanti Hylas 2 Limited (=E2=80=9Cthe =
Company=E2=80=9D), any subsidiary or holding company of the Company or any =
of its or their subsidiaries (each a =E2=80=9CGroup Member=E2=80=9D) will n=
ot be liable for any error in transmission. You should carry out your own v=
irus checks before opening any attachments. Opinions, conclusions and other=
 information that do not relate to the official business of the Company or =
any Group Member are neither given nor endorsed by it/them. Registered in E=
ngland No. 7072502 Registered Office: One Ariel Way, White City, London  W1=
2 7SL, United Kingdom

</body></html>

--MCBoundary=_12503051445513201--


