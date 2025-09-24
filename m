Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58ED5CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 08:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1KRG-0005pA-78; Wed, 24 Sep 2025 04:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1KR6-0005nS-O6; Wed, 24 Sep 2025 04:01:13 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1KQz-00018p-TT; Wed, 24 Sep 2025 04:01:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkcJGPc9hxVxO0rc1pZoG9lrxVsLL66vrePnKh2XS0PjStnUgqq8gXuBx2RfShcYSx+0EUi6kpVkipGBpbNlskFq5aX1aHtjQPryHQ7wY7zYlouCI/Myz9pSllWpQAeMdTH3GYOr9bKfSbmTM73Gq5UTr3+rP814CiXQdvINDTlG+PR+7zeYjEbtSxehEJWEvtxoHZBJwyoJAvrQXuvNWWTIjOoeN5x9V2/V8nKRm7P+qA6Q8wZPxhQGTN6dN0jSBShOmHgQ7UuomZTMwNmVCXejwMaM6/udhBB6PZwO43/NRvxM7AlqwY0jlhkLCU9jEHAUaNmUET3EoQ3K0QzvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wr14p/k+Tnz03IStguH8fm4IxsvMP77g7DzUXiE6SIc=;
 b=SFAdeXbchrPMXoKFChItTUMTMHh0chw44Ym8TcE4Bk0KnJg2NtMGw5Tye1cWWZBfDHrI+AZyZ9hGKqL7DXpa4aO6sWOspaeCwm+BM7iuED0F91wQqByMUjdHhUzjJup5cXbXlhYMvEAKmX7L9GO+rgZHx9Z6JAIUr/nZG9YRelXf6j0W6t7to8pPEq87NaLj0GmCqNy7hPfsTAhvNhPr4QsBe0HSPYcVCgwgFcbdHajkN7w80oyCo/1TBR3ZUtde/neWkIHJcqxZtrIweR3qQd+Qn6J7QbTPCNWuJhUv4hfQV3fNE/UpZ98BJyXGZa5zDjVtNA7WQP9JNwjf4zybDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wr14p/k+Tnz03IStguH8fm4IxsvMP77g7DzUXiE6SIc=;
 b=K0hjqowUEAOK8ljfdcxA8TlEwQn6qj4vOFeQS8yel+hcNg+8XekoWs5NfrNSdyfS23QZ1ETLI0ncVTItqOk6WaFlFFfRdjSXfm8GgpWCXCEbR4ASOXlmkbnXHGX4gqeEjjxD1BT1+i9zWh4qRuG/wXqzzuIaBX9Kq5gJmUhHfBEO/OemYwBk6fsOtO8ZBwcoU4tR0+RQ/Xpns4N38u94bDC5A9TcZAVFJBc8Y0HWlkKCRkcoiHUgmIOHxZuUD16+eVDrvDeUGm5B5RaUIcbgj9uP3nImERmPXIh8y3q2Ty1OH1iX7HbucrXShTMuQ1SlS8jn6fOcnqgoul+QHJN4XA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GV2PR09MB7971.eurprd09.prod.outlook.com (2603:10a6:150:27b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 08:00:48 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 08:00:48 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v6 01/14] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Topic: [PATCH v6 01/14] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Index: AQHb9v6UHa5Begn5/ESGcxg9plOYvrRZCs6AgCU40YCAAC8ngIADPdKAgB18UQCAAzfFgA==
Date: Wed, 24 Sep 2025 08:00:48 +0000
Message-ID: <0c8036d4-9599-4249-bb20-76e35b970477@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-2-djordje.todorovic@htecgroup.com>
 <5f0fb254-fa9c-4e29-a848-6e9b3bc8274d@linaro.org>
 <046d60ed-aa62-4357-a812-721de3412573@htecgroup.com>
 <ca5816d3-a0e7-4460-aead-8f0dbcb4bc92@linaro.org>
 <4d1e75d9-13b1-4fb8-b1f9-4917dbfb2415@htecgroup.com>
 <0a27b044-e7c2-4621-a2ad-e028d5ef31ec@linaro.org>
In-Reply-To: <0a27b044-e7c2-4621-a2ad-e028d5ef31ec@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GV2PR09MB7971:EE_
x-ms-office365-filtering-correlation-id: 0709f584-401c-486a-ea37-08ddfb407940
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bkl2QkVNWXRXdGZUanNkYnhFeExnN0F5c09nZmszMjUwUnNBdWVvRUgvSVEw?=
 =?utf-8?B?U1VUTmVOeFB2S2pXWThKajJ2ckJlOUQ2K2FPb0VXT1hWeTdNZktrWGhVbFF4?=
 =?utf-8?B?NVZtL0tNK2o0dTJnQzhRK2J0bGZSbTFSdVpJZi9seXlDb1lnQ3hXY2lrci8x?=
 =?utf-8?B?emZGVmFNVm4va3ozMUFZQ2dtMTc3Y3BUV2lZWTdYVzBHOUxnYWNvK01BYlM3?=
 =?utf-8?B?MHFmU2Q2VkRQZHNsWnNCcmoyaGM5RG5KV3IrN1B5YzFwaEtUSXhGc01mOFYr?=
 =?utf-8?B?c2ZFMW9JNDBFbGdxWGVMa0V2OFpmZzJoOVFOVzNtOE1RQ05jd2x2THZxNlVV?=
 =?utf-8?B?bE5lcHdPR0hLWGF4WWc5Mm5LSURXeFBxcGhOUmJPN2pLYmRmREhJbU1iSk9W?=
 =?utf-8?B?WW1iZDdIblF1OWdYOEhSQmNDSThYS20xVkpxaXEvQmt0WWtsMlUvMmhUbE9H?=
 =?utf-8?B?TTU4cTBreWFDU1I4ODdhL3NjSEhPQ2NITHdVd0dWTGtDdW90V0VOVWt5MzVF?=
 =?utf-8?B?UnA5Q3NhaEFGZHNnSG1RSHo1SU9tV05OWDR6NXNLYmdPb2xVSEdEVGg2WW5S?=
 =?utf-8?B?MXQ2bHV5QittVis4NndDNmVESkRsYTd6NWJnVnBnSkZrcmlXVUJTMElEbDF6?=
 =?utf-8?B?QzBlaXAwVGJqd3J2cjE5YUtCbHlhMXdRTzdyVWtrZG8rd0Q0Q1hXMVh5MVd2?=
 =?utf-8?B?akcrUkNsSHp5a0ZjOG44RTY0QmprVTlCdFY2YU1rTkQ0MVJGa1FJdVQ4Zmlr?=
 =?utf-8?B?aGQyM1A3clI0ZTJ3bnRwcEtoa3FUaUszdDAwWEpUYkZjcDdYcXl2ajhWUkxi?=
 =?utf-8?B?b21yb2kweXZVanRNbHd4eXJtS3gzVHpCZDVoRlRBUEdLZ2VadVNRZk9UZE1L?=
 =?utf-8?B?N05weUZEbTZPMkdXSnBETHVmQjdjZWRCNFREeWMwOFVFSyt5dEdhQjBPWDJT?=
 =?utf-8?B?bVhDTEZMUXgyU3BDWnNCS3J5OVk4OWMwV2o1c01XTkFaRlVPa0RKN2JEeFpa?=
 =?utf-8?B?NnA2d3c3blVIL1c1cE5PR044aVNwSG9JUEUvZEY0ejJSMmlTY2Q5VUg0bU14?=
 =?utf-8?B?Vjk4MkFhaVlaR25Hb3FObUNXNXBLTUc3MGNJekpyTW9zancyazZlYXZVMUo3?=
 =?utf-8?B?K2ZJZlV3djdiUHJDc2hITmxqSFhVTnB3Yk42bHpuajNueFZ2azlmb2dsdjkr?=
 =?utf-8?B?QVBmdUF2ZlRPeXdNUDVXQ2FSZ1VxRVoyNmsxSkZNM2g3bWdkWEtMV0RtSXQy?=
 =?utf-8?B?THpOMjZCWnZJcGhFamJkbnFzaWo0elBGWm81WDk4YVFXWUZVelVEZmtBREFi?=
 =?utf-8?B?TmpXUDh5VnRPWXJWWmd5RzJuYUhSakxLNUJ0V1BWRzNLdWdQbzByR2wvTFRJ?=
 =?utf-8?B?SG9PODBzQXNRamVpSkl6K3lFR09KTkVqakpyRm1CeUptTTRhb29sVTlzanVR?=
 =?utf-8?B?SlVOeUxXYnFPeWQxQUtvc3BuWkNUYU9PNWJuWXA2MmFoWkFLVlRFMlVkNWJx?=
 =?utf-8?B?bjlKT055Nk5ZYVJ5cWt4MFp2NndYeHorTEo3RlIxWTVxU2FzVFVXNDJFdGEw?=
 =?utf-8?B?UDF0czlkVGRPbGQ0VFc4VVNXQ0VkY1VicDVMYXpxYUVnamlZV05mZlZiQ3ZN?=
 =?utf-8?B?akxxZi9ZbDcybVE5VDA3M1hMUFpSVm5rYkptVVF2anYwT2g5QUFiM05JRllv?=
 =?utf-8?B?STR1RUJCd25kUFNNTVUyYTBnRzVpbDBkNjRLZXhOY2FQK0NJQlhua1VvWGY5?=
 =?utf-8?B?OURhU3hxa1lGU213enptTjR4YUNNcFRmVGFlTFVVQW5HOGttYkROdkdPSm9i?=
 =?utf-8?B?R0tXeUtmSU9ZZzVXSzlSdXlXaXpWWlBMQmNKTXR1amFaUjJ6dGRNMXp2RkRD?=
 =?utf-8?B?cXFvN3ZTcHRRUzRmUFV0aExSaXNlbUFlSVlpVjNidkIraytUYzlnWEJaQzBO?=
 =?utf-8?B?QWNrVWM5UXV1N2xQdzVNbEdvK2JZQUc1WUFTZkFxQWxpSnRWMVVIdnQxenBY?=
 =?utf-8?B?LzdMU214dDdRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NC9CQ3Q0RG14R0h0cDRvcXcybTlqV2xWQzA3WVh1ZnFTK3VTcURRdFN4a25N?=
 =?utf-8?B?UGlTVCtYVXZkaGw0UTZhVUR5bUZISUo0Vkc5ajI1ekVOYjVqazZoYVFiT3lZ?=
 =?utf-8?B?VEdZbGRDNGpPNXFsc1paYXV4c2t3UW16YXI1VzVHNGk3eThIQzRjaWIzSi9Y?=
 =?utf-8?B?VzVSand2dHJkb2ZCdG8vZWJNYWNrekdkWEljbmVGczlMMEhvYTFtemEyVGZ0?=
 =?utf-8?B?M2R6OWc5SEpoQVdNUVBabFpLZ0hUTm5QVFU3QXdORlFiMDd5aFVsUFp6WUor?=
 =?utf-8?B?NHdGV29KY2t0TFEzRE9DV0Rhd0VJUUNoQm0rU2o1bEx2ZXJ3L3l4NUhRTlNC?=
 =?utf-8?B?bHhDM0ZMekt6dTIxQzhwRUQweS9DWURHdjBuM2p3cjNDQktmUHpvYWtlMFlz?=
 =?utf-8?B?U0FsYkZDdlBVdCtnN3BkZlZ5eU1Zb0ROY1h1L2tKZVRuU2lOeTE4dzhGZm9Q?=
 =?utf-8?B?VWhGWnV6Y1JHaU5YRHcrU0ZDM0FqKzRJUXVGN2E0SU9sckJ1MElOVzgrcVgz?=
 =?utf-8?B?WWpNTDJGdEJHYWh1LzZ0U0pSUEdsZWtCRFkwVndIUWhYOUFxcVFvSDBOdnZ3?=
 =?utf-8?B?dXZkSkM1bmZva2FueFQ5SDcxd1BDd01mN2VOOVI4WmdxdzhncEI1NWpYVEZa?=
 =?utf-8?B?NmdVT0lIS3VicFZLb3ZCT3NGMllDV2EwWUpTWlEwRC9VWi81M1p2NmQvV0tY?=
 =?utf-8?B?VHVqREw5UE9QL0ovR0tDUkNQeVIxd0YwOFg5dUxoL1VJU3BsbmRUR0pGZks0?=
 =?utf-8?B?TStBS2JKS2JxbHNZeXI1NnBONERhd2lpeHZrUjBIY0JrcFM4cWgzK0taeXVR?=
 =?utf-8?B?QkliM2tCTTN2NUJVY0hJUk9SZTRTa0tOWHphb3VnQTh1b0IxUTgvN2dGYWUw?=
 =?utf-8?B?YmlhWjJxUGJZc00rOWpjVDJ4S3FpWWlBbmh4OEY2YTAyRitUMEh4cTJadWpy?=
 =?utf-8?B?c2w1ZmZXZUkwSmE5a2FzZG1TKzVDMDNvcm5nUnVtS2ZsdlN3QnFSb1RKSUd1?=
 =?utf-8?B?Z2wxQ2ZPb1RhMXFVdTlJa1dCWERPdHprL0l6dVB4WFlJV2ZaTW11VWtvWHd5?=
 =?utf-8?B?STVKdjFTOUFYeVM0Zi9YbDlPTVBhYkROU003RzVXNFVSNjNUaVJUNWpmdXJm?=
 =?utf-8?B?Z0FrcWtjenBkQWhEbjBxTVQrQzhOaUpJRHJSWk5UemdUdVlyUjFyQjlKQ29O?=
 =?utf-8?B?aHFTQUc1TXpYbWVkMEN1Y0thOE96c090aTNnT29qbEFaQzJuQTZ2WkJBbFBB?=
 =?utf-8?B?R0JZZkFWSVlXMUhDTy9IdCthUGVHOVY4blRSd0NEaXRxRzNPS0hnbkdDeFdV?=
 =?utf-8?B?d0lsZGFFZGRaRDlaV24wSCtYL0JveE5Vb1RSNmZJTU9UUEVUK0RoQmx1SzM0?=
 =?utf-8?B?aitXSlJKcWxpUytxV1ZSaVVIYmo0MjZHMUs3VFlZbGZzRG5hNGJtczJWUVFZ?=
 =?utf-8?B?NG8zbUs2bWdsSHp3NEwzdTZ0MkJFQ3ZIdmJyazFaSHcwV3ZxNjJWYks1QWlv?=
 =?utf-8?B?Q3BlQlVRWWNsd0tQZlJoTktoYVdxRmNDeG13RTZzd3JmT1k0ZFZ1Ty92Z3Qx?=
 =?utf-8?B?QkNQWWFLcjY2Y1BxZFZ6ZDZ5Y1p1STZtazMrY1lCanBxZ3pKWlpWUGV0MGVv?=
 =?utf-8?B?Q25EM2dJalB2d2RPeGNpRld4Qy9pWGlmblovR1NPSnZjanZwQ0ZDcmRFeUdF?=
 =?utf-8?B?Z1dOK0FpNis4clVmM1ZudkoyQm1ZUFl0b2VUd0MwbjNRWGE5dExFbVo2S0tJ?=
 =?utf-8?B?OEtLdXNvVnp6NERRM3RlT04zZy8wLzVFUVJSdFpiazFLTE9IeG9PTWw1bWhh?=
 =?utf-8?B?TGFpVkpUNUFodEwzaE9sT3pndVpzZ3ZDOFM1YWNpRmkvbjlFWjNhZ3VPNEh6?=
 =?utf-8?B?SWJEOU5NNUlSMjIwak9BUVBNWlRZdTc2dytnd2IzNVY0aFlLdFgvSk4xNmtY?=
 =?utf-8?B?VFcrRXJLY2wzWUl4UGNZdjhiaU5XcG04QzJ6bVFJM1ZtaWJ4NGRJUE1RdzUw?=
 =?utf-8?B?c0FkMHR4OFJMWE53d2M5OUhRUExWbHVnUjFzNUovejYzNVJSSzZETTdwQ1JB?=
 =?utf-8?B?SU50UHlQN0VEWFpkWFBvT25qeVN2T3dRQncvMUJHNnRVVkE4RVJpdUNsUDJE?=
 =?utf-8?B?bjcvT3UwYzdLNXlxc2xEa1BGVVNubXRsYkRJNnV0VVE0eVhoZ1J2bVNZaFNi?=
 =?utf-8?Q?27Sq8XGZSPyZYhhi3wnRLiY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0883491A33CD4942BE218EF5B5A2D11A@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0709f584-401c-486a-ea37-08ddfb407940
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 08:00:48.6875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRyjhyK0YbDoqj6Q5nhSVg6UfnUPhMGoSN0p4Qzm43AF33ucJLv44tUcfRAig1Pn6P+fA/gv6sEzVwIUpOysoFUYc/OVZwEIlhsXCRQbM8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR09MB7971
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

DQpPbiAyMi4gOS4gMjUuIDA4OjUyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4g
Q0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5p
emF0aW9uLiBEbyANCj4gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciANCj4gYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZS4NCj4NCj4NCj4gT24gMy85LzI1IDE0OjM1LCBEam9yZGplIFRvZG9yb3ZpYyB3cm90ZToNCj4+
DQo+PiBPbiAxLiA5LiAyNS4gMTM6MDUsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0K
Pj4+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9y
Z2FuaXphdGlvbi4gRG8NCj4+PiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyDQo+Pj4gYW5kIGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZS4NCj4+Pg0KPj4+DQo+Pj4gT24gMS85LzI1IDEwOjE3LCBEam9yZGplIFRvZG9yb3Zp
YyB3cm90ZToNCj4+Pj4gT24gOC4gOC4gMjUuIDE3OjUyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4+Pj4NCj4+Pj4+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9t
IG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8NCj4+Pj4+IG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXINCj4+Pj4+
IGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IE9uIDE3
LzcvMjUgMTE6MzgsIERqb3JkamUgVG9kb3JvdmljIHdyb3RlOg0KPj4+Pj4+IFRoaXMgaXMgbmVl
ZGVkIGZvciByaXNjdiBiYXNlZCBDUFVzIGJ5IE1JUFMgc2luY2UgdGhvc2UgbWF5IGhhdmUNCj4+
Pj4+PiBzcGFyc2UgaGFydC1JRCBsYXlvdXRzLiBBQ0xJTlQgYW5kIEFQTElDIHN0aWxsIGFzc3Vt
ZSBhIGRlbnNlDQo+Pj4+Pj4gcmFuZ2UsIGFuZCBpZiBhIGhhcnQgaXMgbWlzc2luZywgdGhpcyBj
YXVzZXMgTlVMTCBkZXJlZnMuDQo+Pj4+Pj4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBDaGFvLXlp
bmcgRnUgPGNmdUBtaXBzLmNvbT4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBEam9yZGplIFRvZG9y
b3ZpYyA8ZGpvcmRqZS50b2Rvcm92aWNAaHRlY2dyb3VwLmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+
PiDCoMKgwqAgaHcvaW50Yy9yaXNjdl9hY2xpbnQuYyB8IDIxICsrKysrKysrKysrKysrKysrKyst
LQ0KPj4+Pj4+IMKgwqDCoCBody9pbnRjL3Jpc2N2X2FwbGljLmPCoCB8IDExICsrKysrKysrLS0t
DQo+Pj4+Pj4gwqDCoMKgIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkNCj4+Pj4+Pg0KPj4+Pj4+IGRpZmYgLS1naXQgYS9ody9pbnRjL3Jpc2N2X2FjbGlu
dC5jIGIvaHcvaW50Yy9yaXNjdl9hY2xpbnQuYw0KPj4+Pj4+IGluZGV4IGIwMTM5ZjAzZjUuLjIy
YWM0MTMzZDUgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvaHcvaW50Yy9yaXNjdl9hY2xpbnQuYw0KPj4+
Pj4+ICsrKyBiL2h3L2ludGMvcmlzY3ZfYWNsaW50LmMNCj4+Pj4+PiBAQCAtMjkyLDcgKzI5Miwx
MyBAQCBzdGF0aWMgdm9pZA0KPj4+Pj4+IHJpc2N2X2FjbGludF9tdGltZXJfcmVhbGl6ZShEZXZp
Y2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqAgcy0+dGlt
ZWNtcCA9IGdfbmV3MCh1aW50NjRfdCwgcy0+bnVtX2hhcnRzKTsNCj4+Pj4+PiDCoMKgwqDCoMKg
wqDCoCAvKiBDbGFpbSB0aW1lciBpbnRlcnJ1cHQgYml0cyAqLw0KPj4+Pj4+IMKgwqDCoMKgwqDC
oMKgIGZvciAoaSA9IDA7IGkgPCBzLT5udW1faGFydHM7IGkrKykgew0KPj4+Pj4+IC3CoMKgwqDC
oMKgwqDCoCBSSVNDVkNQVSAqY3B1ID0gUklTQ1ZfQ1BVKGNwdV9ieV9hcmNoX2lkKHMtPmhhcnRp
ZF9iYXNlICsNCj4+Pj4+PiBpKSk7DQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIENQVVN0YXRlICpj
cHVfYnlfaGFydGlkID0gY3B1X2J5X2FyY2hfaWQocy0+aGFydGlkX2Jhc2UgDQo+Pj4+Pj4gKyBp
KTsNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGNwdV9ieV9oYXJ0aWQgPT0gTlVMTCkgew0K
Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VS
Uk9SLCAiYWNsaW50LW10aW1lcjogaW52YWxpZA0KPj4+Pj4+IGhhcnRpZDogJXUiLA0KPj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5o
YXJ0aWRfYmFzZSArIGkpOw0KPj4+Pj4NCj4+Pj4+IERldmljZVJlYWxpemUoKSBoYW5kbGVycyBh
cmUgcGFydCBvZiBtYWNoaW5lIG1vZGVsbGluZywgbm90IGd1ZXN0IA0KPj4+Pj4gdXNlcy4NCj4+
Pj4+DQo+Pj4+PiBJT1csIHRyaWdnZXJpbmcgdGhpcyBpcyBhIHByb2dyYW1taW5nIG1pc3Rha2Us
IHNvIHdlIHNob3VsZCBqdXN0DQo+Pj4+PiBhYm9ydCgpIGhlcmUuDQo+Pj4+DQo+Pj4+IFdlbGws
IGlmIHdlIGRvIGl0IHRoYXQgd2F5LCBvdXIgQm9zdG9uIGJvYXJkIHRhcmdldCBmb3IgUDg3MDAg
Y2Fubm90DQo+Pj4+IHJ1bi4NCj4+Pg0KPj4+IFNvIHRoZSBwcm9ibGVtIGlzIGVsc2V3aGVyZSA6
KQ0KPj4NCj4+DQo+PiBJIHNlZS4gV291bGQgc29tZXRoaW5nIGxpa2UgdGhpcyBiZSBhY2NlcHRh
YmxlOg0KPj4NCj4+IC0tLSBhL2h3L2ludGMvcmlzY3ZfYWNsaW50LmMNCj4+ICsrKyBiL2h3L2lu
dGMvcmlzY3ZfYWNsaW50LmMNCj4+IEBAIC0yNzksNyArMjc5LDcgQEAgc3RhdGljIGNvbnN0IFBy
b3BlcnR5DQo+PiByaXNjdl9hY2xpbnRfbXRpbWVyX3Byb3BlcnRpZXNbXSA9IHsNCj4+IMKgwqAg
c3RhdGljIHZvaWQgcmlzY3ZfYWNsaW50X210aW1lcl9yZWFsaXplKERldmljZVN0YXRlICpkZXYs
IEVycm9yIA0KPj4gKiplcnJwKQ0KPj4gwqDCoCB7DQo+PiDCoMKgwqDCoMKgwqAgUklTQ1ZBY2xp
bnRNVGltZXJTdGF0ZSAqcyA9IFJJU0NWX0FDTElOVF9NVElNRVIoZGV2KTsNCj4+IC3CoMKgwqAg
aW50IGk7DQo+PiArwqDCoMKgIENQVVN0YXRlICpjcHU7DQo+Pg0KPj4gwqDCoMKgwqDCoMKgIG1l
bW9yeV9yZWdpb25faW5pdF9pbygmcy0+bW1pbywgT0JKRUNUKGRldiksIA0KPj4gJnJpc2N2X2Fj
bGludF9tdGltZXJfb3BzLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcywgVFlQRV9SSVNDVl9BQ0xJTlRfTVRJTUVSLCANCj4+IHMt
PmFwZXJ0dXJlX3NpemUpOw0KPj4gQEAgLTI5MSwxOCArMjkxLDE1IEBAIHN0YXRpYyB2b2lkDQo+
PiByaXNjdl9hY2xpbnRfbXRpbWVyX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKipl
cnJwKQ0KPj4gwqDCoMKgwqDCoMKgIHMtPnRpbWVycyA9IGdfbmV3MChRRU1VVGltZXIgKiwgcy0+
bnVtX2hhcnRzKTsNCj4+IMKgwqDCoMKgwqDCoCBzLT50aW1lY21wID0gZ19uZXcwKHVpbnQ2NF90
LCBzLT5udW1faGFydHMpOw0KPj4gwqDCoMKgwqDCoMKgIC8qIENsYWltIHRpbWVyIGludGVycnVw
dCBiaXRzICovDQo+PiAtwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBzLT5udW1faGFydHM7IGkrKykg
ew0KPj4gLcKgwqDCoMKgwqDCoMKgIENQVVN0YXRlICpjcHVfYnlfaGFydGlkID0gY3B1X2J5X2Fy
Y2hfaWQocy0+aGFydGlkX2Jhc2UgKyBpKTsNCj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoY3B1X2J5
X2hhcnRpZCA9PSBOVUxMKSB7DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxZW11X2xvZ19t
YXNrKExPR19HVUVTVF9FUlJPUiwgImFjbGludC1tdGltZXI6IGludmFsaWQNCj4+IGhhcnRpZDog
JXUiLA0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHMtPmhhcnRpZF9iYXNlICsgaSk7DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250
aW51ZTsNCj4+IC3CoMKgwqDCoMKgwqDCoCB9DQo+PiAtwqDCoMKgwqDCoMKgwqAgUklTQ1ZDUFUg
KmNwdSA9IFJJU0NWX0NQVShjcHVfYnlfaGFydGlkKTsNCj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAo
cmlzY3ZfY3B1X2NsYWltX2ludGVycnVwdHMoY3B1LCBNSVBfTVRJUCkgPCAwKSB7DQo+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9yZXBvcnQoIk1USVAgYWxyZWFkeSBjbGFpbWVkIik7
DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBleGl0KDEpOw0KPj4gLcKgwqDCoMKgwqDCoMKg
IH0NCj4+ICvCoMKgwqAgQ1BVX0ZPUkVBQ0goY3B1KSB7DQo+PiArwqDCoMKgwqDCoCBpZiAoY3B1
ID09IE5VTEwpDQo+PiArwqDCoMKgwqDCoMKgwqAgYWJvcnQoKTsNCj4NCj4gV2h5IGRvIHlvdSBl
bmQgaGF2aW5nIGEgTlVMTCB2Y3B1IGluIHRoZSBnbG9iYWwgY3B1c19xdWV1ZT8NCj4gKHRoaXMg
aXMgdGhlICdlbHNld2hlcmUgcHJvYmxlbScpLg0KPg0KV2VsbCwgaXQgaXMgdHJ1ZSwgZm9yIG91
ciBjYXNlLCB3ZSB3b3VsZCBuZXZlciBnZXQgaW50byB2Y3B1ID09IE5VTEwgY2FzZS4NCg0KDQpB
ZnRlciBzZXZlcmFsIGF0dGVtcHRzIHRvIGNvbWUgdXAgd2l0aCBhIGJldHRlciBzb2x1dGlvbiBm
b3IgdGhpcywgSSB0aGluaw0KDQp3ZSBhcmUgYmFjayB0byB0aGUgZXhpc3Rpbmcgb25lLiBJIHdp
bGwgdHJ5IHRvIGVsYWJvcmF0ZSB3aHkuDQoNClRoZSBzcGFyc2UgaGFydC1JRCBsYXlvdXQgaW4g
dGhpcyBjYXNlIGlzIG5vdCBhIHByb2dyYW1taW5nIG1pc3Rha2UgYnV0DQoNCmFuIGludGVudGlv
bmFsIGhhcmR3YXJlIGRlc2lnbiBjaGFyYWN0ZXJpc3RpYyBvZiB0aGUgUDg3MDAuIFRoZSBQODcw
MA0KDQpSSVNDLVYgaW1wbGVtZW50YXRpb24gaGFzIGEgc3BhcnNlIGhhcnQtSUQgbGF5b3V0IHdo
ZXJlIG5vdCBhbGwgaGFydCBJRHMNCg0KaW4gYSByYW5nZSBhcmUgcG9wdWxhdGVkLiBUaGlzIGlz
IGV4cGxpY2l0bHkgc3VwcG9ydGVkIGJ5IHRoZSBSSVNDLVYgQVBMSUMNCg0Kc3BlY2lmaWNhdGlv
bi4gVGhlIGN1cnJlbnQgQUNMSU5UL0FQTElDIGltcGxlbWVudGF0aW9uIGFzc3VtZXMgYSBkZW5z
ZQ0KDQpyYW5nZSBvZiBoYXJ0IElEcyAoZnJvbSBoYXJ0aWRfYmFzZSB0byBoYXJ0aWRfYmFzZSAr
IG51bV9oYXJ0cyAtIDEpLg0KDQpGb3IgdGhlIFA4NzAwIGJvYXJkOg0KDQogwqAgLSBXZSBpdGVy
YXRlIHRocm91Z2ggdGhlIHRoZW9yZXRpY2FsIGhhcnQgSUQgcmFuZ2UgZm9yIGEgY2x1c3Rlcg0K
DQogwqAgLSBTb21lIGhhcnQgSURzIGxlZ2l0aW1hdGVseSBkb24ndCBoYXZlIGNvcnJlc3BvbmRp
bmcgQ1BVcyAoc3BhcnNlIA0KbGF5b3V0KQ0KDQogwqAgLSBXZSBuZWVkIHRvIHNraXAgdGhlc2Ug
d2l0aG91dCBmYWlsaW5nDQoNClRoZSBDUFVfRk9SRUFDSCBhcHByb2FjaCBkb2Vzbid0IHdvcmsg
aGVyZSBiZWNhdXNlOg0KDQogwqAgLSBUaGUgY3B1PT1OVUxMIHdpbGwgbmV2ZXIgaGFwcGVuDQoN
CiDCoCAtIEl0IGl0ZXJhdGVzIG92ZXIgYWxsIENQVXMgc3lzdGVtLXdpZGUsIG5vdCBqdXN0IHRo
b3NlIGluIHRoZSBjdXJyZW50DQoNCiDCoMKgwqAgY2x1c3Rlcg0KDQogwqAgLSBUaGUgaGFydGlk
X2Jhc2UgcGFyYW1ldGVyIGRlZmluZXMgd2hpY2ggY2x1c3RlcidzIGludGVycnVwdCBjb250cm9s
bGVyDQoNCiDCoMKgwqAgd2UncmUgaW5pdGlhbGl6aW5nDQoNCiDCoCAtIFdlIG5lZWQgdG8gbWFp
bnRhaW4gdGhlIGluZGV4LWJhc2VkIHJlZ2lzdGVyIGFycmF5IG1hcHBpbmcgZXZlbiBmb3INCg0K
IMKgwqDCoCBub24tZXhpc3RlbnQgaGFydHMNCg0KSSBhZ3JlZSB0aGUgTE9HX0dVRVNUX0VSUk9S
IHdhcyBpbmFwcHJvcHJpYXRlIHNpbmNlIHRoaXMgaXNuJ3QgYSBndWVzdA0KDQplcnJvciwgc28g
SSB3aWxsIGFkZCBhIGNvbW1lbnQgaW4gdjggdG8gZXhwbGFpbiB3aHkgd2UgYXJlIHNraXBwaW5n
Lg0KDQoNClRoYW5rcyBhIGxvdCwNCg0KRGpvcmRqZQ0KDQoNCj4+ICsNCj4+ICvCoMKgwqDCoMKg
IFJJU0NWQ1BVICpjcHVfcmlzY3YgPSBSSVNDVl9DUFUoY3B1KTsNCj4+ICvCoMKgwqDCoMKgIGlm
IChyaXNjdl9jcHVfY2xhaW1faW50ZXJydXB0cyhjcHVfcmlzY3YsIE1JUF9NVElQKSA8IDApIHsN
Cj4+ICvCoMKgwqDCoMKgwqDCoCBlcnJvcl9yZXBvcnQoIk1USVAgYWxyZWFkeSBjbGFpbWVkIik7
DQo+PiArwqDCoMKgwqDCoMKgwqAgZXhpdCgxKTsNCj4+ICvCoMKgwqDCoMKgIH0NCj4+IMKgwqDC
oMKgwqDCoCB9DQo+PiDCoMKgIH0NCj4+DQo+Pg0KPj4gVGhhbmtzLA0KPj4NCj4+IERqb3JkamUN
Cj4+DQo+Pg==

