Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFDCC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWYz-0000Pj-Py; Tue, 18 Mar 2025 09:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tuWYS-00008f-RW
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 09:00:26 -0400
Received: from mail-northeuropeazlp170110001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tuWYN-0007nu-ST
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 09:00:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oba2ya5ioiT5QsiMZMOQQnhnY0lCLegK80saR4toqu4gkz8IwFGqsM2l7LjrPJ2KLvQg6+rOffnOYolYQSLLIQCx9la8FpFAHUZDfyIUTJxLx2kTU2LQgjVq6KT32FY8PRm4RWH0pXeH6AOtIa5d/9GXgzDyek4ceFDgv25eB6QcdOiHZYonLN7GWMw2IJT8HFb0uDWloEdtQSdGFygs+vCgHlRGRDzUHVBM4fj/NYcI3jgxhP2nw1uO/Pzc7DHkITvoFuScUvyQdIoMjFdY9Hyn9Z5gBDZPg9pFBwagugzwg2ZLSNLJExSBvsq+38UKuhz8vlQ5xhb0TUnYACN/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7imSeYUZS3VkbYBoGzMK8h95cKagAvAN1oozd3jNso=;
 b=D+6mZ/ut4czh2/WM7zwLSadv1ncKJJwOF628ig7u5bhCNG58b0Jp0l9+tiah8K48Ws1a21h5wXh6oKVAgEPJC2q4A+C+9fhrpaU+RnUgI5nXgofPys96G4Lk4oJ4EmeuXaaOQCQnRJSzB8bw9rBDbgGX//40QXspuo9LkQGXgM86/8CUN8bCHTReRwOXJW3YIB8YBe9Y9l0tab/zar6Ue7hrvmSJNu4Lg3o61msQKgvQljppKpZxWoNAay6ignaB3LGVFgzWYqh1YEnufKXLlr37IhUDneeav7YaVFuJN0cEPgq1epUi33POgPQyNuLnio+3CRAVPkXWjx7ENnZrow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7imSeYUZS3VkbYBoGzMK8h95cKagAvAN1oozd3jNso=;
 b=gW8FPl12VOXpICrn3AlsyO0QX0MVrT1vrOt7E71tY6PycycW6Q4nr5AUpUifm5KmmgFjUHXQWZi/IVVQDFKsbEYsYeu+qpd6qPcAfjyZiQxiobLqIVZhpk9hOr0NGVw6DdJ1l2hbjelW0SxYGrWVujKF9bzjRBFs20dzVxPmYzdm3I9FEnBYKO8qFSEYqbYr5JC8t67+ExlAutPcXVU6lIeN+C/6GU4Hxep3nRhYX+BiMR+xOVrfUXlQzKRPe1lbUWswrmgXn6pLi2x1epeYG0Zx1WD6VwIyyrzwQO7UHRzfXWyLP3RgqAEgnK2juQiONoO+ZeJKuL6oGlKjjGVCeQ==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by DB3PR09MB6601.eurprd09.prod.outlook.com (2603:10a6:10:43b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 13:00:14 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 13:00:14 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Aleksandar Rakic
 <aleksandar.rakic@htecgroup.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 2/3] Skip NaN mode check for soft-float
Thread-Topic: [PATCH v5 2/3] Skip NaN mode check for soft-float
Thread-Index: AQHbiHBN9WWu61L0jUe8EWyWqAJpArNvr5MAgAlK0wA=
Date: Tue, 18 Mar 2025 13:00:14 +0000
Message-ID: <20250318125952.583908-1-aleksandar.rakic@htecgroup.com>
References: <CAFEAcA8RjNTZsuhShFwFUHa+YP5VKBUw2RneUPwAJ9eOVAL5Vw@mail.gmail.com>
In-Reply-To: <CAFEAcA8RjNTZsuhShFwFUHa+YP5VKBUw2RneUPwAJ9eOVAL5Vw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|DB3PR09MB6601:EE_
x-ms-office365-filtering-correlation-id: fe0292b4-71a7-45cd-e274-08dd661cd2fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RFZFNzdiSXFqTjIveDVoRlMwdTFxY3cxb2Q1cXdhbmVJVnh0QStoTDUxMTJk?=
 =?utf-8?B?cGNXWXk2YWZ3YnpyTzlyME9UV014eXRob2hHbUhuN2l3UE1YZ21tOXFGOENB?=
 =?utf-8?B?NGErZTlPUzFmT0RiTnRTOXloeVNDNzhXVjFacUt6Z2NKTmpKYVNQbFBQU1V1?=
 =?utf-8?B?dS94elpFN1JwdkcrWG1YQ05SaERhODNrSFpjdUNJTjBITFdScEVkeEE1bHhZ?=
 =?utf-8?B?WktqYlJhNkpOT0wvYXpMcjZPYlBoaXI4MkVPaTBXVWRFLzRJR0FMdG9haG9S?=
 =?utf-8?B?aWhoeHVqNkN5ZEVKOGZ6eExBeitHN3RUYjF1cGlHS3R5Z3JXajdQUU5MdG9Q?=
 =?utf-8?B?N2s3b1ZxREVJMXVPanZkUlhCV2s5c3JqMjJKcHdQTy9wWEdROWdqVFJQcTZt?=
 =?utf-8?B?bkdVdzlSQ1JVZDVvbkQzenNOa1JiVFlIV1JaaStnTU9HRHRJRXovdFd5TXV4?=
 =?utf-8?B?aEdGZVowQm1Zd05RbjVoTTk0Q1BDYWlCamNNYXMvaGVldktnRmxZc09iSzAx?=
 =?utf-8?B?QXZvR3daQ2ZZTlpxQTFZUCthUGFuQjhId280dGlzUlMvUmoyRVZaOVVvUWlw?=
 =?utf-8?B?QkFrUlVLVWpWNHR3T3pWSEpWMTdKamFWRHRSYzJvYjVSWUo5RkhZdWtnNW5z?=
 =?utf-8?B?anZIQzZET0lNem1CZzBJMUpLZU5GeG05RzRmS2p3ZURmS1JIMVAwMzNCenhT?=
 =?utf-8?B?U1gxSlRUNWszT0R0TGNFbWNqdzVaMDViUzdBcnh4cFdoY3dBTTJGOHlrTURJ?=
 =?utf-8?B?cExWSW5lSVFtMHNFemdrNmpQaHNBTW82YmI5eGVPMnd5c1JqZmlCTlZTdUx5?=
 =?utf-8?B?L2FDUzhMRklTb0kvSUlCVllqRWVtdVRENEUwNnh2Tzkva2cxcjBxWWdhcTAv?=
 =?utf-8?B?d0U4SjBXeXhyY3d2d0NpM2JWcnhmb3h1YU1QcDI1a1k1YXZ0c3ZQSWltZWpx?=
 =?utf-8?B?eEJYVW92Y0ptV3ltU25TbFFWQzNrWmZMdlZYVG1nSzBwb0RmQzlKU1RQajhP?=
 =?utf-8?B?SmNKWWI5RjJGZXF1T2d4bHBPaEdId3VweEhLMkJWZ3pFTEZGSzZ1K01ERDAw?=
 =?utf-8?B?WGU1dEo2SDkvOFI3RDdNU0pUWmFKVUpCNFl3SEZrMDBwMkJ6Vm9aeTFjZXd5?=
 =?utf-8?B?WkhDTi9VRTM2N3RSZ1N4THFZa1d6NHB2cXkzNzQ1NjIrYk1sSjZBOXNWYTll?=
 =?utf-8?B?eEpDcUwrcTBUNGFEQzJBRkxtNXJ1aGI0QVhHZXA5YWNvUG1VeWdHcUR4SDJs?=
 =?utf-8?B?SGlkL0hOWmNBMk4zRUNxeWpxcnY3TEdjQVR0YUh3S2FKTkY0RG95d0hISUFE?=
 =?utf-8?B?YnpQd2JxNVlsRm1Ba1NvOENWL0dMdzR3UU9BMXpGQUxYODJXRi9TQlFCYVpW?=
 =?utf-8?B?UU9WMzBsNXNkb2JzSkw5Q1o4WUFIRDg2SHk1MHBHanhlbTlTTk5WcXpyNzVw?=
 =?utf-8?B?VEM4WHBYVzJhZ0J2L3BqQkorTmFhWGlNZXhSMnNJcnlkbzJFT2NOWk9GS01t?=
 =?utf-8?B?S1Y0NHpMOWNsWndsZVRvaHJiRXZHZlhyazVoaXpsVkYyMmlkM1FJdU9TTnNS?=
 =?utf-8?B?RE9FWkZJa29ML2dRYmJsRzBxQWNaUU0wSUlXa3dnZWlmczJFY3NQejNTWGo5?=
 =?utf-8?B?Vi9ndktGZXFKMVlSNUZWb0FYZ1RsUXluUEZpR0hEcHdFOVFaak5GekRXaVV0?=
 =?utf-8?B?TDlNMHhFcGU4Y1RUNWZYOWVmTUMzbDNXNytlRjV4MkFtYjB3U3BQRHJTVTc3?=
 =?utf-8?B?cnMvazdUY3J6QXJWUHRDWjhUZmFiQ2R0K1dVNjBObW8xM2UydnRmU0RVazN6?=
 =?utf-8?B?NjRkdVBFYkVoVUdTUnBZOEUrWWdhdmdVMFhFZUREdHdoVG9nOXo3Y3ArMG9Q?=
 =?utf-8?B?TElYSUdaY0NVQ0FFb3Q4THVvSHRYZjBkY2RSSUd5TkU1QUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFcwQitDTEIzN3IyYi90UTNCaGxLTFgwQjl2Qmp6c3BBV3VERXQzbUMxNEli?=
 =?utf-8?B?cDRoalVhaVZTQ3ljaXNQMUEzVlpSRXFneVphYkx4WUU3RVA4Z25lTWZFWUZ1?=
 =?utf-8?B?M3VBV0o4RkxIMDhiWlhqNlI2WnJaQjllRTk1dVRXR1hLYmlRRjY4RGE4QlFp?=
 =?utf-8?B?U2FSd1RDcWphRWtEdURQdDl6WUJ5MytQWjZVbjU5bFBWNWl4VmJvdnQydE9P?=
 =?utf-8?B?d3orS2NRSFVKL2ZXNmVFZmVhWFR3dUlKSFN3YnB5eGJ3SmtHd0ZFT21jek1N?=
 =?utf-8?B?WUh4VCtWVTN1UlVpeTFwRldxNmhuS01MbnBmRFJzRjZURkFENVE0RlNCTlE2?=
 =?utf-8?B?emhxZ0FFbUVGekNFTWQva2lrUHpoRUhUb2RkOEZFQlRpVXlRUHVwY1gva3k5?=
 =?utf-8?B?U0FNckFRbis4OFFIQW1tN2hGQmw2TnFXNTk4UkgyajliTmd6emtlczVPRW5K?=
 =?utf-8?B?SGppaGU5Z0RjdHBuOFNJeEtOSlhLbUtLL3plWVh2ejJLaVlGM2x5U296UUR3?=
 =?utf-8?B?WUJjRGdOY25KalBVcFhraHVhelVmWlVkaUZGRFBVVnpXUkNUUGt4MmNmWVBs?=
 =?utf-8?B?U3Z0WXBuWk10K0pPMlQxd09ZdXlQVXlEZGRwdTduMFJWeXlQekQzZjVRY1kr?=
 =?utf-8?B?M3lubXdvRVlDazZSTitXN3VuYzBCeEc5bGd6NElwSndHTDNyU2Zyb0d3Uk0v?=
 =?utf-8?B?VTZqY0JjOWtadXpuTS9wNWpDYWs5Y1M1MHMzTzJ5VXVvVUIybVJqM1F2ZFQ4?=
 =?utf-8?B?TkI4dzVXMmFPNitPdjhzVjZzQk1HZHpHd3dFM1J4TkZxcUxGK3N3Nk1Qcjd3?=
 =?utf-8?B?NXlQYm1YNGpmLzhJMk1obGZLZktiUW14VC9jR3F5NW1FcFpRd2JOTFptMjdk?=
 =?utf-8?B?M0xkMm41TWpZZENNWTZDaWpvOEs1SXV0Z3I0RUh3VDY5RU5rMXFsV0pQZTJK?=
 =?utf-8?B?ODB2S3N1ODJUN3c1dmtWdkphbDgwcmZ3VmRNckswMFRIOGpwOEg0WGxWb2g5?=
 =?utf-8?B?R3BaaXpRRmQ3MzM2ZnVRUGFSckY4RktBTWhPK1RTQ2hwbUo1OTA0b2FZUzJi?=
 =?utf-8?B?OFlNeTZZeE1YSVZKcTQ1QTBLVlJSbE5xYzVWZHBMN0poZ2xZZG9oUUFVUlp5?=
 =?utf-8?B?WmZIY1hZWWRYc3Q1YnhIL0sraGMzYXFvMTgyS1lUK3oxc21mc0g2NzVTMTNQ?=
 =?utf-8?B?WVJ5bVF3QldWbDJuYmpKaEFkZEhOUXR5VUE0TWwwTDR4aGpoRlpjd2lUUnJF?=
 =?utf-8?B?YUhiMG1HeEVONWNscGJNQXFmYmtiUXF5N3NHR3cwN0cwTjdYbGdjcVV5RVNi?=
 =?utf-8?B?RUFCbjczOFJRQ2RWci9BbFZVb0kvalBwMUxTMW9za0ZkSHRxd1NleDVmcnN3?=
 =?utf-8?B?bnhjZHRmMUNGWW1JWFlYZUxyM0xJbC80VUNkRk9JM1F5M3VMUUswckkzdUdY?=
 =?utf-8?B?TGtKWi8wY2x5Z2NNVWRoT1VtWk1CTkErTkdjTURvdU5wWjNnL0xmNmN6bFZ0?=
 =?utf-8?B?NWcxQVlBNmV4TERNU3FFajRCRW9PR2NVZmRzcWY0MkY4L3dNenBHdUlxYVZr?=
 =?utf-8?B?MDJkbFFwUjU4YmM5NDFOS1E3amRhNG1VN0NnN001L0YrRXNHYlY2WkZXU050?=
 =?utf-8?B?ODNBK1M0ZTI5WS9WUk53dnlwM2lCOFBNSUtNNElVWlRyR3ZKc3pRUTlqYlNQ?=
 =?utf-8?B?M1AzQVVabzNkMU1odFpjTWdrRnRKdnVESWdHL0tmSTZ6U1ZCQ1JSd3dUd1ph?=
 =?utf-8?B?Tzk5NktCTHEyOE40ZW9TN3JTei95aVA1UFFvS2RSOWxtWjhvMXdnVmwzNkFh?=
 =?utf-8?B?UHh0TDJoWDljd0UxbjlZMlE0RHlveklqbWUzN0V0RUQ4SEFBZWYra2hFdDVV?=
 =?utf-8?B?bXF5WGRyZlNiOXpDOVNuQXlWd1FUeCtDQWk4TkFKRTFBUklLRlFtZzJjaFdR?=
 =?utf-8?B?aTU0SzF4dkZ0bnpsTzk1ajF6dS9oOEZ6VlRhNDFFSmN5NkhITHFhQW16L2ZV?=
 =?utf-8?B?bW40dzdCQmtGejZPS0F4Z3EwSEFQUmo4eXFxaTFQWWkzYThoKzdHemw1TFJr?=
 =?utf-8?B?QnQ0U3oxWTR4Q0dCYVRwT2xWMFFMUUpFQlJ6RENYWHVhZFI2NkZWRFFVSTZQ?=
 =?utf-8?B?NHFmbzg5cUFHeURua3JwVWluckZ0S1NEaEtQTEgydnVreUxBL3NwRkw5TFJY?=
 =?utf-8?Q?jkiCDbCuA3W+vLRwvlc2J7A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB278E37215AC444BCE0437978BA56D1@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0292b4-71a7-45cd-e274-08dd661cd2fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 13:00:14.0702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B5s86LcvIhS2xzeXOAMuPHqygF3lbGA3CuRyoYIFK3zBYUWfJKtWHQgOXolBgDE7shNd7HBNXZ/1mu9qEgw6wwj68uu6xpP+Wfu5IWzJ0vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR09MB6601
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGksDQoNClRoZSBzb2Z0KC1mbG9hdCkgcmVxdWlyZW1lbnQgbWVhbnMgdGhhdCB0aGUgcHJvZ3Jh
bSBiZWluZyBsb2FkZWQgaGFzIG5vDQpGUFUgZGVwZW5kZW5jeSBhdCBhbGwgKGkuZS4gaXQgaGFz
IG5vIEZQVSBpbnN0cnVjdGlvbnMpLg0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgv
djYuMTMuNi9zb3VyY2UvYXJjaC9taXBzL2tlcm5lbC9lbGYuYyNMMzQNCg0KV2hlbiAtbXNvZnQt
ZmxvYXQgaXMgdXNlZCwgdGhlIHByb2Nlc3NvciBkb2VzIG5vdCB1c2UgaGFyZHdhcmUNCmZsb2F0
aW5nLXBvaW50IGluc3RydWN0aW9ucyBidXQgcmVsaWVzIG9uIHNvZnR3YXJlIGVtdWxhdGlvbiBm
b3INCmZsb2F0aW5nLXBvaW50IGFyaXRobWV0aWMuIEluIHRoYXQgY2FzZSwgYSBOYU4gbW9kZSAo
c3VjaCBhcyBOYU4yMDA4KQ0KaW4gdGhlIGhhcmR3YXJlIEZQVSBoYXMgbm8gZWZmZWN0IGJlY2F1
c2UgdGhlIGhhcmR3YXJlIEZQVSBpcyBub3QNCmFjdGl2ZSBhbmQgYWxsIGZsb2F0aW5nLXBvaW50
IGV4cHJlc3Npb25zIGFuZCBvcGVyYXRpb25zIGFyZSBoYW5kbGVkIGJ5DQpmdW5jdGlvbnMgZnJv
bSBzb2Z0d2FyZSBsaWJyYXJpZXMsIHN1Y2ggYXMgdGhvc2Ugd2l0aGluIGdsaWJjIG9yIG90aGVy
DQplbXVsYXRpb24gbGlicmFyaWVzLiBIb3cgTmFOIHZhbHVlcyDigIvigIthcmUgaGFuZGxlZCBp
biBzb2Z0d2FyZSBlbXVsYXRpb24NCmRlcGVuZHMgb24gdGhlIGltcGxlbWVudGF0aW9uIG9mIHRo
b3NlIGxpYnJhcmllcyBhbmQgaXMgbm90IHJlbGF0ZWQgdG8NCkZQVSByZWdpc3RlcnMuDQoNCklm
IHRoZSBwcm9jZXNzb3IgdXNlcyAtbXNpbmdsZS1mbG9hdCwgTmFOMjAwOCBtb2RlIGNhbiBhZmZl
Y3QgdGhlIHdheQ0KTmFOIHZhbHVlcyDigIvigIthcmUgZW5jb2RlZCBhbmQgaW50ZXJwcmV0ZWQu
IFdoZW4gLW1zb2Z0LWZsb2F0IGlzIGFjdGl2ZSwNCnRoZSBlbXVsYXRpb24gaWdub3JlcyB0aGUg
aGFyZHdhcmUgRlBVIGFuZCB0aGUgTmFOIG1vZGUgaXMgbm90IHJlbGV2YW50DQpiZWNhdXNlIGZs
b2F0aW5nLXBvaW50IHByb2Nlc3NpbmcgaXMgbGVmdCB0byB0aGUgc29mdHdhcmUNCmltcGxlbWVu
dGF0aW9uLCBub3QgdGhlIGhhcmR3YXJlLg0KDQpLaW5kIHJlZ2FyZHMsDQpBbGVrc2FuZGFyIFJh
a2lj

