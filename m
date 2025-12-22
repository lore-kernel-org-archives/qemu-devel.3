Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01676D711D5
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 05:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXYEt-00056h-3f; Mon, 22 Dec 2025 00:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vXYC9-0004hn-H5
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 00:12:11 -0500
Received: from mail-koreacentralazon11023089.outbound.protection.outlook.com
 ([40.107.44.89] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vXYBl-0004sL-OQ
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 00:10:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlmmvQPAfqVHdIy5HzJAXvX7NibIsPqK/ZcCFKBLfee0BGuDHFDZgxv9mVSd3WWZXeyU1ZGYHvKl0e6drUZ0kjS/2wAU4jhv6FFpCmWiGervO9XoWmZp8aSy6JOssePfALFc3WbjbljMxIcAReTxMRhI5nJQtcy6FuoPzb2cW7cD+Tj0gBQ8AVlN/uk4QvsRGkDmVPCih7Aqpi1gvWM+IwRFJkSjIgBhsKPNilW6xvbDuJy0Ih6636oW2Tm7aIxshFIVna3bgf1T5S9GSH5pUcCO0yVrlGmEhiImfey39iDxmzUL1+cmPf4FueszDPl3P5USN4PPdAziUwqWZXpEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxe6bLSmZrFRd4y344QGTfyHgLNyppmZRRNGz9mLXuI=;
 b=cmrzCxU1SQcXTk4N4XtH1cmmiztWDMAseAnLJs/7YO6uNaXuE6CS6YVcAxO9UNYcIJ7fUXeFHecIb8HW24lNApi7bCMGxJ+jAVAzJrm+U5mtel57Sn1Rynl+U3i9o7sbOWBE7BD/rSCj1p8ySx4tn1F4Et3LprUVFmscrGzjTR5i3dwfhjYFjXtu4KOcsrEbwunBqptQ4/HVnYsYoMVJNAZ/2nlpfGPj+RaYZTiWW6qSKHbCWviOhW/xU3Yn55W1IdUciBmUT15w8t0C0P6bcf616stvyp84WoxPiEufazh1dHxjiUR36RqoBsNwp1iISpHFRYmHzy7b0jL11yIqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxe6bLSmZrFRd4y344QGTfyHgLNyppmZRRNGz9mLXuI=;
 b=N9qWLnV33TLLCc7xe1BX7aMyKvBX4f85vSVGEF222ooBQVM3Y2ZXL/ADJvGcfWgQdI9/3iedV9jpi3jRIVUKw+cTad4AJOx9pFkPupHXTO/hnSTk/DqLgptArQdcqK3plZEiCzgWu4ORZ7kJatvR2sYlqwEd7imyqK4D1eXfHsV5WxE/MFmjO09L6/Q7Kfzcblib8oBMmy5q888T2msavGaTyR06NFEF/Jv+6sotoAl2Q/nvc0ncBdhrdL0RQqMz/cNM+jqcWzCutW5AsS/XWSD9Ppue9sRVW0nw/8hcsdaUpe4FJJOzS25opoeZD5XFp3mLGB4uRljtPjWyXGTx1w==
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by TYZPR06MB5527.apcprd06.prod.outlook.com (2603:1096:400:28d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 22 Dec
 2025 05:05:23 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 05:05:22 +0000
From: Wafer <wafer@jaguarmicro.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "leiyang@redhat.com" <leiyang@redhat.com>, "sgarzare@redhat.com"
 <sgarzare@redhat.com>, Angus Chen <angus.chen@jaguarmicro.com>
Subject: RE: [PATCH v3 1/4] vhost: add data structure of virtio indirect
 descriptors in SVQ
Thread-Topic: [PATCH v3 1/4] vhost: add data structure of virtio indirect
 descriptors in SVQ
Thread-Index: AQHcbi79gwD5KyTk10aPJGYFdg4SirUoogWAgARuXJA=
Date: Mon, 22 Dec 2025 05:05:22 +0000
Message-ID: <PUZPR06MB4713E1FC23482BF0BB503D23A2B4A@PUZPR06MB4713.apcprd06.prod.outlook.com>
References: <20251216015451.6479-1-wafer@jaguarmicro.com>
 <CAJaqyWcB1C=6Eo54pjiokEDfb0=eXYnii9Vc1NyAQxKaCwtGrA@mail.gmail.com>
In-Reply-To: <CAJaqyWcB1C=6Eo54pjiokEDfb0=eXYnii9Vc1NyAQxKaCwtGrA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB4713:EE_|TYZPR06MB5527:EE_
x-ms-office365-filtering-correlation-id: 65ed6037-81a4-418d-a297-08de4117b60c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MmJDa0NkOExMM2tCeGJSUXZndWs3dUh2cFNBZmJRTEVtd2pqREpMM3FkU1Jp?=
 =?utf-8?B?akh3OEFOOUtra1dwUG9taUJ5UHJqeXYvK3Z4WXdVQ3V4RkNPZExOYjZCUnhh?=
 =?utf-8?B?NS9WUksyMkRpcWFmZ0hEVnpkcHorMnp0WERVek0ySXdwdnNrb1lHNzdsSC9p?=
 =?utf-8?B?aUhYOGJDZlZaT0IwSXduQTVHWEJiVXJiRkpCbnczVElpdDYrQ1FncEZvRWwx?=
 =?utf-8?B?eTYyc1pKb2lOTHZWREVlMzk2SzllMjZNTWNUeG9sVmcxd01IN2liMHNhVDVi?=
 =?utf-8?B?dFluVWtNNVJ0aGgzWkQ4TEJxcmNzM0lhbWcwNmpDODhtZENWR09uS2VlSGFK?=
 =?utf-8?B?dGZuM1BZdXp0ZCtmUUFidVpNdFo4WmFPUVJqS3M5L3pTVXpLWUtqMTRIMWlN?=
 =?utf-8?B?RFB4c1hwYVNtV0NMOUljZ3llK0tmajF5SkhmSnVZSlhpM2pTOStQbEVjbWJS?=
 =?utf-8?B?UHRncHE4eWg2Sy9VNnRRdUlJRGZGN3p1NFYvUDZ6dzlmRXhhVnZGQUZ3V0NN?=
 =?utf-8?B?a2tqMFpnWEZYV0l4UHdVQXdrMmlJdVd3UkZETmw4Yk9lencwbHN2aFN5dmd3?=
 =?utf-8?B?TERNeFFHdDdOWmRyTEtmK0UxN3M0c3hFb3dxTTZ3MzBXK0RCbCt3UzRub3BW?=
 =?utf-8?B?MlVOZjUwWmdaaHJBQ2l1T1ZDZzkxc1lMb0dCaHZaT1dhMEpCK2gyNGhkWVNn?=
 =?utf-8?B?TWc1WW9ab1RNUUtrNTZpaTUxaUpoQkxCeG5PdXo3QUl1bWc4RDFaSklNWHNz?=
 =?utf-8?B?Vi84aUtrcU9RYkh1MFZOQ09pVWNMNTRFVjZya0c4QlBVc2VsMXN0REJ5M2Rn?=
 =?utf-8?B?OUpKOFNmaGRhU1VadHlDMk5hMSs0enFyWGllZXNOWlNYWmNmMXBQZFRQQ3d6?=
 =?utf-8?B?ZnZkN0VlQjJNK2pIdGFZbU5YZlhydEtvbUNwN3Jlb09ML3MxRXF4RkZsbCsv?=
 =?utf-8?B?ckZsN01ncXlkemNveDJqN3diY0ZoajdRTStzSDhFLzZ6dTB6c1Y0YnFyYjZn?=
 =?utf-8?B?clZVUTJyR1hLbXRrdEdlejE5dUlvcFJ2UEJlQ05iZkNYVUcvMHIwZ2JkdGtz?=
 =?utf-8?B?UWtsUkkvUi9nQnk3WUtBTWUvbXFKVHE0TVMvQms4V0czZGFidTkwQkVZREh3?=
 =?utf-8?B?VXpRQi9xSkkxYXlMc3VhM0k2TGJURUhBSmxWQno3R3VMM2dsdk9OWG4zdGJa?=
 =?utf-8?B?RnZwcFZDVGJIMVVPcTFSZ2wveG1GVjRvNzVHTTYvNm5DZEQ0VWIwTEhhcVJq?=
 =?utf-8?B?N2pMdXNWbUVRbGVlYWhGZi9GVVVEZFZuOW5Oc2FJa0Y5c1BJZGk5am84Zzh5?=
 =?utf-8?B?MG55V2l0RlJ3WFVHMFQ1WjVnSC93aGxhRVNkcm5FeE5PWWJ2TFdqVXJMajFx?=
 =?utf-8?B?dFc0VU94Y1dlanBQeTQzREZzc3hobHNiRUZ5R3dramNyTGc3U1ZzQkpQdTlK?=
 =?utf-8?B?NjZmdVRYczJNeVBtZ2JhMUtNbDVFSEZ4Tnp1THZucXNBL2lNRmF6SWNnbmg5?=
 =?utf-8?B?YmdPcGNodTVaOThWSWJNSklYbjZxMDlQZmwrajlzQ2pjc0tzRFJtamo3eXRZ?=
 =?utf-8?B?SDdhZmQ0U1VXbVpkVnFNNk1JdW1HRnRrK0NiVzJRckswSXVlblBoZTJucHBI?=
 =?utf-8?B?VVlLMUErblphU2pvK1hQYitWYkNCWWhRbUJFYXp6dVIrVkJpZGVGYmRjQzla?=
 =?utf-8?B?bkZaTlRyOUVLeU1qc0MrSkRXQWZDdmtTMXlVRERsU3NLOW1idEU3a0g0dGcw?=
 =?utf-8?B?RkdkT2NyeHI0ZERwK0JtdGdHZTE4QWc3Rk5lRDR0TGx0b2NBRnlWdHkrNW9u?=
 =?utf-8?B?NVZ4NUpFWnJ2ak5BYWI5Q0R1aFpPNGlUQmQrM0Z6WmVUNlA1WTViVHZ5OGpN?=
 =?utf-8?B?VzJhREdCMEhDaHNvTkc5andaeENjVGtYajE5eDdqUDJFS0wzc0dOYTgrVERI?=
 =?utf-8?B?MDZRTFR1OUpZKzQ5WUd1eUlxQ3NVZ3pYaTV4Tk9RbHphcXp4S05vOWtjdnNi?=
 =?utf-8?B?YWVraUFJVnd4SUFZUFlzYXlsQVlSTDMySjNIdlF6VkNSeDFMQkZHWmNKek5O?=
 =?utf-8?Q?TyTDGf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDcrUWRyeHBOdklJci92T1RSeDd5NnhYNGRJU2NnU0d1OVlrRjZKb2IvU2w5?=
 =?utf-8?B?WG1FQnJDK0pxZ0VvcVhSQWJ0RVFCblRPNUJzWC92SHpQRjkzTFBhOE15amlw?=
 =?utf-8?B?ZGxXakt2WFMrSGVzWGo0VytSZ2Rvb0pCeStrYXBKc0pMMWZRL2VQK2EzSTlN?=
 =?utf-8?B?RkE3aW1UYWdobkhwUThESzg3bm1JNWhvRm5XaWJOOWsrM3ZiN0ZDSVJMWlpi?=
 =?utf-8?B?em1HMHJBNzMzem0rQUZ1R3l3d1dGUklIclVmVlR1NS9YVVdPdFNCcWloVFlM?=
 =?utf-8?B?M2IyN0pUUXMwMU5OcEpEMktpWVFWUXNNU2ZMM3ZJZnJDcGZBUzJ0UjEzdisy?=
 =?utf-8?B?M2pkcllNVTNDaTI5cjNtc1B4MFdscGRSYlJSYmc1aGM2SEwreEZ0djV3Tjhr?=
 =?utf-8?B?U3Rkd09KT1A5MlBXZDk1N0NqazFQN3lFMXVUSmtSZjhIWVlsdjJsaU5VZDBE?=
 =?utf-8?B?UUI4MkNxR2ZTOGo2UEV1T0FhMi8wdVorNTV0clNoVS9UNU53N0VuaUVhK2tu?=
 =?utf-8?B?NlMzYkFZVEVncENIR01FaTRObzQwVU9rN3Q5RC9CdDdzRnFTQkRxVDRha2tQ?=
 =?utf-8?B?bmlRNlVMZmRGYlFnWkRXTVNsMFppd2ZBdkppMDVzQjQxS2pZWUsycjU5RkN6?=
 =?utf-8?B?SUZJWnRxcWoyaFJqNDZCdXdHdmlUK3R1QVdtRXN3d3VjKzI4V3FkZE5zM21Y?=
 =?utf-8?B?dmJEYmlPaW93bEx0VkVsZ1gweTZPYmVrM291MVM0VTR5VDE5c0dQSFNmaWZV?=
 =?utf-8?B?VFBTbXBiMGhuRjgrbzRkZVJVQ0ZlVjVWNi9YTHRUOXh2bEh3akw5cGNQT3NT?=
 =?utf-8?B?ZUFUbllkVnhMWk80NGNkREprYzRQL1lOdk1kbDBmZitSZWFiVWF5TWFtTTc0?=
 =?utf-8?B?b29vM25pcTYyTEcxQUNWZm04MmVsNVowb2FUSmVOU203c2hSOERyYjUrcUVL?=
 =?utf-8?B?eVVLSGhTdFcxTmltV2hmdTB0NFBzaXJyaGo3Qlh1bThUSS84OHdGZ0x0ZFBq?=
 =?utf-8?B?dkRtamFmZC84SEM4aER5N3V3dm8rTzZCRk83Q3h1NEtuWkl6ZUN5N1RBQ0pK?=
 =?utf-8?B?eWx2SThBaW01WmFqU0VQYm0xVlJ5bGh3K2lIUHo4clBmSUtFZEhOTDkvUEFy?=
 =?utf-8?B?TmZjMzM1MWxtNlU3Y3lXMnBaUjB6bmU4WktwTkg3VDJQTDN6MjY0cUtneVVF?=
 =?utf-8?B?d3V4VFV5MDM1SkNsOGpqUTZ3N05idkFkUmU3QXhKSStoTzhNT0EzSklnNDE3?=
 =?utf-8?B?bWl4RExlcjhyaFlyaXJLZHNLdTRaZUQ2K2lxTW9oRFZvRE9oUDFzVkxYWlhq?=
 =?utf-8?B?QkJoOVlVOGhvT3JiOHBoZ04yMzJZRHg1RVpkdlNGaFNsMXFXZS9RZlp6OHlV?=
 =?utf-8?B?SVFmMUdkR3pFV25Ed0VqQ21BeXRJdXpONDZtWXdhdDhFYTdPcEFwZXQ1YTFB?=
 =?utf-8?B?YWlEWGNoc2Vnc2NheUlSTkI0d1NjeTdqZzJGQUJ6eFAwN0NNVkNuUWlGMUps?=
 =?utf-8?B?anRUejllZUc2Sjh2WnB0RW84NFRSdDFnNk1vWGtpNGNqQnFvMUV5VnhEVWNk?=
 =?utf-8?B?S001YlZQSmNDWjdrYW9EV01tMXJqdWxXWDlqNjdWR1EvRFV1ZVlsYzhvY1ZV?=
 =?utf-8?B?bFZSOVpFUDFvVE1pT1YzNkpQamZ3ckZYUHk0aTlybDcyQlJyMWhNOWl5bTVY?=
 =?utf-8?B?Zm43Skw0SGNuWkNzWDJSd3JxVVpWN0RTMzF6YzQrWFd0TW5xWi96RUkxVm5m?=
 =?utf-8?B?dHpha1pwd2QwMmM5dHdjb09MS3gxazhXVXJOSFRnYWV4UTJXcWEvODgzdWRa?=
 =?utf-8?B?UkpTVjNzZFpYNVB6U1ZpR1hVemNRR1BvaDJ4ZEFlbzJ5cDdGZTZWclFGSmlt?=
 =?utf-8?B?dUlpRUdmQW9FRmxQNGVFRTg2bUNXR1plREZjekk2MTFxd0hHR2pxQ093ek5J?=
 =?utf-8?B?TlhmZFVrMmlxRkRJL1pFNTdUWmI4YnV2STJEcHJOVDcxbEdPMFh3NUUwME1L?=
 =?utf-8?B?UkYxRml3TkdnTkVjeDBXVWZkemdtbVp6eU9QZHpqdTArbXRtUjgzK2RHU3Fp?=
 =?utf-8?B?empmMjV1emRSaWFacThNK3ZyU0lzcEVIOGhMRGlwUnpDU0owNkhzT3ozbExK?=
 =?utf-8?B?OGZySStZbUYxR2hGcFhNc1ltQkljT2E0Zm1hUXd4WWFnNEVmQUxNeXNIZjg1?=
 =?utf-8?B?ZUxaVENvUGNHdlVlbGlEcFlMS1JXTXVwMUUxR3RkMVhVbUoyMGQyWCtTS1F0?=
 =?utf-8?B?TWx3MGlMQWdqTFd3QStDWVVycXNLT2gxTk5UajM3VVJEb0k3NTRDLzRjU3U2?=
 =?utf-8?Q?3HsSikF9y7aGVR1G/I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ed6037-81a4-418d-a297-08de4117b60c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2025 05:05:22.6780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fo8o/oCG5d1Qd4yWcmv2IVxAdgGn23xpAhN0iLvcJC3EsDxoz2auSy17UH46No/6AbiqsMH2ESWS2ouLEcwCbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5527
Received-SPF: pass client-ip=40.107.44.89; envelope-from=wafer@jaguarmicro.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXVnZW5pbyBQZXJleiBN
YXJ0aW4gPGVwZXJlem1hQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDIwMjXlubQxMuaciDE55pelIDE2
OjEyDQo+IFRvOiBXYWZlciA8d2FmZXJAamFndWFybWljcm8uY29tPg0KPiBDYzogbXN0QHJlZGhh
dC5jb207IGphc293YW5nQHJlZGhhdC5jb207IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gbGVp
eWFuZ0ByZWRoYXQuY29tOyBzZ2FyemFyZUByZWRoYXQuY29tOyBBbmd1cyBDaGVuDQo+IDxhbmd1
cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzRdIHZo
b3N0OiBhZGQgZGF0YSBzdHJ1Y3R1cmUgb2YgdmlydGlvIGluZGlyZWN0DQo+IGRlc2NyaXB0b3Jz
IGluIFNWUQ0KPiANCj4gRXh0ZXJuYWwgTWFpbDogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20g
T1VUU0lERSBvZiB0aGUgb3JnYW5pemF0aW9uIQ0KPiBEbyBub3QgY2xpY2sgbGlua3MsIG9wZW4g
YXR0YWNobWVudHMgb3IgcHJvdmlkZSBBTlkgaW5mb3JtYXRpb24gdW5sZXNzIHlvdQ0KPiByZWNv
Z25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+
IE9uIFR1ZSwgRGVjIDE2LCAyMDI1IGF0IDI6NTXigK9BTSBXYWZlciBYaWUgPHdhZmVyQGphZ3Vh
cm1pY3JvLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiB3YWZlciBYaWUgPHdhZmVyQGphZ3Vh
cm1pY3JvLmNvbT4NCj4gPg0KPiA+IFVzaW5nIG11bHRpcGxlIHN0YXRpY2FsbHkgYWxsb2NhdGVk
IGJ1ZmZlcnMgdG8gc3RvcmUgdmlydGlvIGluZGlyZWN0DQo+ID4gZGVzY3JpcHRvcnMNCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IHdhZmVyIFhpZSA8d2FmZXJAamFndWFybWljcm8uY29tPg0KPiA+
IC0tLQ0KPiA+ICBody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oIHwgNDYNCj4gPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQ2IGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93
LXZpcnRxdWV1ZS5oDQo+ID4gYi9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oDQo+
ID4gaW5kZXggOWMyNzM3MzlkNi4uYjBmMjM2ZjA0OSAxMDA2NDQNCj4gPiAtLS0gYS9ody92aXJ0
aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oDQo+ID4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXNo
YWRvdy12aXJ0cXVldWUuaA0KPiA+IEBAIC0yMyw2ICsyMywxMyBAQCB0eXBlZGVmIHN0cnVjdCBT
VlFEZXNjU3RhdGUgew0KPiA+ICAgICAgICogZ3Vlc3Qncw0KPiA+ICAgICAgICovDQo+ID4gICAg
ICB1bnNpZ25lZCBpbnQgbmRlc2NzOw0KPiA+ICsNCj4gPiArICAgIC8qDQo+ID4gKyAgICAgKiBJ
bmRleCBpbnRvIHRoZSBpbmRpcmVjdCBkZXNjcmlwdG9yDQo+ID4gKyAgICAgKiBidWZmZXIgKDAg
dG8gU1ZRX05VTV9JTkRJUkVDVF9CVUZTIC0gMSkgaWYgdXNpbmcgaW5kaXJlY3QuDQo+ID4gKyAg
ICAgKiAtMSBpZiBub3QgdXNpbmcgaW5kaXJlY3QgZGVzY3JpcHRvcnMuDQo+ID4gKyAgICAgKi8N
Cj4gPiArICAgIGludCBpbmRpcmVjdF9idWZfaWR4Ow0KPiA+ICB9IFNWUURlc2NTdGF0ZTsNCj4g
Pg0KPiA+ICB0eXBlZGVmIHN0cnVjdCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSBWaG9zdFNoYWRvd1Zp
cnRxdWV1ZTsgQEAgLTQ2LDYNCj4gPiArNTMsMzIgQEAgdHlwZWRlZiBzdHJ1Y3QgVmhvc3RTaGFk
b3dWaXJ0cXVldWVPcHMgew0KPiA+ICAgICAgVmlydFF1ZXVlQXZhaWxDYWxsYmFjayBhdmFpbF9o
YW5kbGVyOyAgfSBWaG9zdFNoYWRvd1ZpcnRxdWV1ZU9wczsNCj4gPg0KPiA+ICsvKioNCj4gPiAr
ICogU3RhdGUgb2YgYW4gaW5kaXJlY3QgZGVzY3JpcHRvciBidWZmZXIgICovIHR5cGVkZWYgZW51
bQ0KPiA+ICtTVlFJbmRpcmVjdEJ1ZlN0YXRlIHsNCj4gPiArICAgIFNWUV9JTkRJUkVDVF9CVUZf
RlJFRUQsICAgIC8qIEJ1ZmZlciBpcyBmcmVlIGFuZCBjYW4gYmUgdXNlZCAqLw0KPiA+ICsgICAg
U1ZRX0lORElSRUNUX0JVRl9GUkVFSU5HLCAgLyogQnVmZmVyIGlzIGJlaW5nIGZyZWVkICovIH0N
Cj4gPiArU1ZRSW5kaXJlY3RCdWZTdGF0ZTsNCj4gPiArDQo+ID4gKy8qKg0KPiA+ICsgKiBQcmUt
YWxsb2NhdGVkIGluZGlyZWN0IGRlc2NyaXB0b3IgYnVmZmVyDQo+ID4gKyAqIEVhY2ggU1ZRIGhh
cyB0d28gb2YgdGhlc2UgYnVmZmVycyBmb3IgZG91YmxlLWJ1ZmZlcmluZw0KPiANCj4gV2hhdCBk
b2VzIHRoZSBkb3VibGUgYnVmZmVyaW5nIGltcHJvdmUgaGVyZSBjb21wYXJlZCB0byBqdXN0IGRv
dWJsaW5nIHRoZQ0KPiBzaXplPw0KPiANCg0KQ29tcGFyZWQgdG8gc2ltcGx5IGRvdWJsaW5nIHRo
ZSBzaXplLCBkb3VibGUgYnVmZmVyaW5nIG1haW5seSBtYWtlcyBpbmRpcmVjdCBkZXNjcmlwdG9y
IG1hbmFnZW1lbnQgZWFzaWVyLiANCkZvciBpbmRpcmVjdCBkZXNjcmlwdG9ycywgdGhlIHZpcnRp
byBzcGVjaWZpY2F0aW9uIHJlcXVpcmVzIHRoZSBkZXNjcmlwdG9yIHRhYmxlIHRvIGJlIGNvbnRp
Z3VvdXMgaW4gbWVtb3J5Lg0KVGhlIGxhc3QgZGVzY3JpcHRvciBpbiB0aGUgYXJyYXkgY2Fubm90
IGJlIGNoYWluZWQgd2l0aCB0aGUgZGVzY3JpcHRvciBhdCBpbmRleCAwIHRvIGZvcm0gYW4gaW5k
aXJlY3QgZGVzY3JpcHRvciB0YWJsZS4NCg0KPiANCj4gPiArICovDQo+ID4gK3R5cGVkZWYgc3Ry
dWN0IFNWUUluZGlyZWN0RGVzY0J1ZiB7DQo+ID4gKyAgICB2cmluZ19kZXNjX3QgKmRlc2M7ICAg
ICAgICAgLyogRGVzY3JpcHRvciB0YWJsZSBzaXplID0gbnVtX2Rlc2NzKSAqLw0KPiA+ICsgICAg
aHdhZGRyIGlvdmE7ICAgICAgICAgICAgICAgIC8qIElPVkEgb2YgdGhlIGRlc2NyaXB0b3IgdGFi
bGUgKi8NCj4gPiArICAgIHNpemVfdCBzaXplOyAgICAgICAgICAgICAgICAvKiBTaXplIG9mIHRo
ZSBtbWFwJ2QgcmVnaW9uICovDQo+ID4gKyAgICBTVlFJbmRpcmVjdEJ1ZlN0YXRlIHN0YXRlOyAg
LyogQ3VycmVudCBzdGF0ZSBvZiB0aGlzIGJ1ZmZlciAqLw0KPiA+ICsgICAgdWludDE2X3QgbnVt
X2Rlc2NzOyAgICAgICAgIC8qIFRvdGFsIG51bWJlciBvZiBkZXNjcyAoTiAqIHZyaW5nLm51bSkg
Ki8NCj4gPiArICAgIHVpbnQxNl90IGZyZWVkX2Rlc2NzOyAgICAgICAvKiBOdW1iZXIgb2YgZGVz
Y3JpcHRvcnMgYXZhaWxhYmxlIGZvciB1c2UgKi8NCj4gPiArICAgIHVpbnQxNl90IGZyZWVpbmdf
ZGVzY3M7ICAgICAvKiBOdW1iZXIgb2YgZGVzY3MgYmVpbmcgZnJlZWQgZnJvbSB1c2VkDQo+IHJp
bmcgKi8NCj4gPiArICAgIHVpbnQxNl90IGZyZWVkX2hlYWQ7ICAgICAgICAvKiBOZXh0IGZyZWUg
ZGVzY3JpcHRvciBpbmRleCBpbiB0aGlzIGJ1ZmZlciAqLw0KPiA+ICt9IFNWUUluZGlyZWN0RGVz
Y0J1ZjsNCj4gPiArDQo+ID4gKy8qIE51bWJlciBvZiBpbmRpcmVjdCBkZXNjcmlwdG9yIGJ1ZmZl
cnMgcGVyIFNWUSBmb3IgZG91YmxlLWJ1ZmZlcmluZw0KPiA+ICsqLyAjZGVmaW5lIFNWUV9OVU1f
SU5ESVJFQ1RfQlVGUyAyDQo+ID4gKw0KPiA+ICAvKiBTaGFkb3cgdmlydHF1ZXVlIHRvIHJlbGF5
IG5vdGlmaWNhdGlvbnMgKi8gIHR5cGVkZWYgc3RydWN0DQo+ID4gVmhvc3RTaGFkb3dWaXJ0cXVl
dWUgew0KPiA+ICAgICAgLyogU2hhZG93IHZyaW5nICovDQo+ID4gQEAgLTk2LDYgKzEyOSwxOSBA
QCB0eXBlZGVmIHN0cnVjdCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSB7DQo+ID4gICAgICAvKiBDYWxs
ZXIgY2FsbGJhY2tzIG9wYXF1ZSAqLw0KPiA+ICAgICAgdm9pZCAqb3BzX29wYXF1ZTsNCj4gPg0K
PiA+ICsgICAgLyoNCj4gPiArICAgICAqIFByZS1hbGxvY2F0ZWQgaW5kaXJlY3QgZGVzY3JpcHRv
ciBidWZmZXJzIGZvciBkb3VibGUtYnVmZmVyaW5nLg0KPiA+ICsgICAgICogVGhlc2UgYXJlIGFs
bG9jYXRlZCB3aGVuIFNWUSBzdGFydHMgaWYNCj4gVklSVElPX1JJTkdfRl9JTkRJUkVDVF9ERVND
DQo+ID4gKyAgICAgKiBpcyBuZWdvdGlhdGVkLg0KPiA+ICsgICAgICovDQo+ID4gKyAgICBTVlFJ
bmRpcmVjdERlc2NCdWYgaW5kaXJlY3RfYnVmc1tTVlFfTlVNX0lORElSRUNUX0JVRlNdOw0KPiA+
ICsNCj4gPiArICAgIC8qIEluZGV4IG9mIHRoZSBjdXJyZW50IGFjdGl2ZSBpbmRpcmVjdCBidWZm
ZXIsIC0xIGlmIG5vdCB1c2luZyAqLw0KPiA+ICsgICAgaW50IGN1cnJlbnRfaW5kaXJlY3RfYnVm
Ow0KPiA+ICsNCj4gPiArICAgIC8qIFdoZXRoZXIgaW5kaXJlY3QgZGVzY3JpcHRvcnMgYXJlIGVu
YWJsZWQgKi8NCj4gPiArICAgIGJvb2wgaW5kaXJlY3RfZW5hYmxlZDsNCj4gPiArDQo+ID4gICAg
ICAvKiBOZXh0IGhlYWQgdG8gZXhwb3NlIHRvIHRoZSBkZXZpY2UgKi8NCj4gPiAgICAgIHVpbnQx
Nl90IHNoYWRvd19hdmFpbF9pZHg7DQo+ID4NCj4gPiAtLQ0KPiA+IDIuNDguMQ0KPiA+DQoNCg==

