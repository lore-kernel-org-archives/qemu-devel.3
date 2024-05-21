Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B194DC41513
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PIB-0000E5-Cg; Tue, 21 May 2024 09:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHZ-0007kZ-Q6
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:59 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHW-0001aH-Tm
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297115; x=1747833115;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=lokuilwH5N8vJsvnP4ToLvsgvaPjW/Dc0GK83AImbMY=;
 b=wsLVx3XrXhLo2oqHonW9iidFHrYBTcFbnbSngd7hjmqVt/xNVZc2ejO4
 bodveJuqsW35tkGDeDvdS62+vYlAcHP+g8nXmFPz8XS+34dqZW43rUTnN
 HAM7wwlOHQXocz+n3IDgdyYY5TU1oDIhKf7G8cotR86eQnvRuT9oZ3OiD
 JLg4m+M52EL0vXCDLydziRCGhnKIwhdBwZdakmRlyliUP9z/JD8CVNbXJ
 M4kikbt5BBlszrZKGc2cP2Anj5ZCA6KvNXxpVJpCxg+3BxcOxCiAKRELl
 c1P50M01D4l1b7taz4BHgDDLT3xl7XtQDLZyTP5B2LkNHVKg0LQJE8cy6 w==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13061517"
X-MGA-submission: =?us-ascii?q?MDGLs7tvvTd7BKGXP6TYAai9RNVbUU9xeHDbT1?=
 =?us-ascii?q?reEOCzq9fGgNqyZOK7BA3NTrYZZ0wKAhPg4SIJWAtiql9QcVEqxa6cxj?=
 =?us-ascii?q?0a0zsVx2fDfUpmN2uZYM6wfSEK7jSMJ0HxVagJaLNBVGYBLwsyjcmRGS?=
 =?us-ascii?q?1dFKbFgncBRLMjEUmvS8e1Tw=3D=3D?=
Received: from mail-dbaeur03lp2169.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.169])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DS4PnH0y94wIWUHIDxW3Xn0vsL7WdDCQDh4TCgJqtvK5E5FbpzzUu4e40172t+aY6m8hfEE/MtjJbhb+ju7xygrzajX5zxERs3Ve0ha82njzqV4GWUtxDtjnb63BsJM3JMZmYIGJY/y9c0AzawTBE4vjs64oPcXXiMt3Hl1YiZbi7kBCPa83wz9DUjvmBNuthLRHCnf09P7LnwnP71cn7FQLkxUdSHfXUjfNZbsoRh1Q6sPTXeU1202cEqhq0oXyIJd0BFt1E39ysr2SYszfjaFMnv/oBoeJMAIPC4SUepL94OssaJSEndaI6qu5lgiowEKdf8dJA5shS87jWVlxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lokuilwH5N8vJsvnP4ToLvsgvaPjW/Dc0GK83AImbMY=;
 b=aOB/hhAMRAvgsfuFF/d+1bgMJ1MJH1AreRF5/m6ihEzr42HwaFpuB16FUqNbEj2o+rBitIDxU27QSOCJPqhlHXBikQdhz9+Lp/Mn0L2l9HFT5uKA1r0ENkqScPyutLDDMi8TxzKIbpoYKYBiuSWQ9VSVnlqswCgwSj2x3pvLdYkkbE4iVcyuI7GXUfy4IDIqYgTMk3NqgVLDJeZtgajoEWrfrf1EEV5jPtsb9QQ1UFw+ZzNeMswrDBY+foHm+91Qs2eMDmaJoz+/4bF2yUVI+LooJfkDpUGD4Tf4dUk+D6YLDF5Iu0pNDbpEGVTSwfb2Dev0u3z0wvQNHWYrWsvxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6249.eurprd07.prod.outlook.com (2603:10a6:10:140::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Tue, 21 May
 2024 13:11:52 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:52 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 20/22] pci: add a pci-level API for ATS
Thread-Topic: [PATCH ats_vtd 20/22] pci: add a pci-level API for ATS
Thread-Index: AQHaq4ByZz976K1p+kGzAFoHDNZtkQ==
Date: Tue, 21 May 2024 13:11:52 +0000
Message-ID: <20240521130946.117849-21-clement.mathieu--drif@eviden.com>
References: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB8PR07MB6249:EE_
x-ms-office365-filtering-correlation-id: 6ad381df-f401-4ee7-6619-08dc79979517
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cFJSOTczNUNFTzZWQWZPOVdGRDdRbkZYTGlaZ0lXbFhMdEJUc2F2ZmtnaXBL?=
 =?utf-8?B?SXZncTFzM2FWOVNNMGxLN1k3OUwrNmMzRXZpS2FmWlFvbnJHQm4wLzF5ejBl?=
 =?utf-8?B?YmVTSy9IL2N5VjVDU3crdjRwOWs2eU4wUnhCeXJ2YXhOT1NYUVlNYkRWSEN0?=
 =?utf-8?B?OGFjSmxJQzVRbTl5NFkrZDNFcStxeFNEYnVocjg3QnpUOFJqNkZDVFBRbm41?=
 =?utf-8?B?YnhoWS9tQlZOU3dJVTdZNkppTitNR3NudXd3bVc3Nm9Eb095YXVaWkFaK1lG?=
 =?utf-8?B?RmdtTkMyeTN1SE1Xci9XMHZkam51VmxDZEhKM2RpSCtvY2xSQnZXczRmQ0Fw?=
 =?utf-8?B?T2VzTWRVdmJnTDBtVUp4U3BnZVlTSzFqWTlqTlg5VlFGRzZYeHhJNU9oVGNE?=
 =?utf-8?B?YXVUK3pEWHFiRkpGbnNKMHJQQy9neTRjYWFjSzdMdHJiQm5raHI1Y0JHWGFt?=
 =?utf-8?B?OXltTEZJZlUrdHZTVXhEOU5JK0JFMG9iV29NendqekxMckxDcmRHRXZUOWtC?=
 =?utf-8?B?UUJrc3ZpQ3pwZFZnRm9jdXRIaUZUcXhmVU5Qbmc4bGZtOHJ4SGcvczQrRThM?=
 =?utf-8?B?MHlFdXFNNjQyZ1ozdk5wVEU2T2JCRE8zOHlJT1NOV1hyMnJGRnpSQzdXb0wv?=
 =?utf-8?B?YTVLNFJjMEI4TEpFMzQ0TVByU1JmUDRFeUxtQTFpVVJhVFZVVG1iOVhkYVEx?=
 =?utf-8?B?VktuNTkzT1FHcDhuOEtWbmY4OFlNbkVXMi9nZi9ZSk5yRzJvSnZRQXRwMjQ5?=
 =?utf-8?B?UXBCWFlENGNFemVLaGZucDdrU2NYVEtHTm9PWi9aaC9POEtKQTVlanYrL2xJ?=
 =?utf-8?B?WWhYYkhzUHZsSkQxQjEwcExkblZKcklxNXRHVC93Um5XYUx0QlBRTXFrRjl5?=
 =?utf-8?B?L2JEYlJNUzJ6R2p6VkU5VUJGVXhlS1JOOERZZmtpZmkrOUdDNzA3cTZzMi9y?=
 =?utf-8?B?VnV2Ky9xRGNwQW16a2ErNkYvb3YrN01BZXM2dk5QdjAyTnlmM1JhOVBjWlBI?=
 =?utf-8?B?cG5taFh0Z1ZoUnQ3UFoyTXpiSVl3N2VoRFl4bUNJUUh5VGFPMWhDSHVDbnF1?=
 =?utf-8?B?WHcyVllCZ3F0TUJ0RnFCbEpQc0ZFdjVBVm5EcmxkS3N2OUFKa3JUaTdOanlB?=
 =?utf-8?B?bm9reDVXOWVLYWMrZkFUNWw1cDdYQ1UrSGpYK0JlUVRWMVJGejZuRzllM3k0?=
 =?utf-8?B?WE9FNjJINE5ENEhGR3ZhTXB4dHcyaG1NbmhwSFEreWdJa1E1M1ZITWYrUkNB?=
 =?utf-8?B?Wk1oYkZBVzc2cWl4NkJ3Tzh3aVJDeEYzRGNGTHFCRWlCcWFadmYvVVBGRzFt?=
 =?utf-8?B?UTRGOUxBbzU3QWdMUHVuTk5ObFkzbjJxWU5vaHZHa1V1N0F6Mm8ydXJmYm9o?=
 =?utf-8?B?dTBqV3BhNGg2Z3hOcEZNalpGZ0UzVVIwZGw2MlNZa3VSTFo3aHdwczZPM2NU?=
 =?utf-8?B?VENpWHZhN3VBWG0yWlVwQldWczFjT29La0ZZcVBRQnF4UTlsM3E5TEcxSXZx?=
 =?utf-8?B?R3l2RTJpVDl4Z3pERmVpT0J0RjBycmQybm9raDhBMk45WGNTbWtCSlJLSURv?=
 =?utf-8?B?ZnRXbmRBK0pSaDIyVVpEQjlOZ1pXZEFXcFJpMkZnbVZtbk4rRC85MGRmTHRO?=
 =?utf-8?B?UU9jK0NXcElycUxXRDVOdEVydXp3RGhib2R0cTlrdjF2L1JTWkV1NjBYV0I1?=
 =?utf-8?B?aVY5QjU4Sm5OWWVCYW9PN3p2U0hVOUczekZFbGJsRWdrUWRzQXArWEpXOERP?=
 =?utf-8?B?endmdms4eWp4Z3MyYzk2R3dWVGw0bVhDMW5BeCtibm10cXltaHJmb1M5c1Iz?=
 =?utf-8?B?OXc1TzZIUWZZSXhPVUJtUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmZaRlRzR0tmbnpjelpSM083eEdSdTk4VzZMWjNudkFGVEliM0NwdDZoZzM4?=
 =?utf-8?B?T2NONUpkTHJSaGQ2UXVjNDdmR2E5dURGQ1VjcHVpT3lpWklkOUdPYlhVY1hW?=
 =?utf-8?B?TjZTVWYxK09oY21UcGYwWCtqdC9IaUx3NVB5SjJnaG1PTGo4S09jN005U1JF?=
 =?utf-8?B?WklyT2dBdnFJY2FWb3AxWFYxZkRwN2xIVERab3ZUa0hyRCtNazVyNUpiWXFH?=
 =?utf-8?B?cmpkOUpzZ1JTQndFZFZjbGFaNXVCSlVoY1VCc3ZFY1lEbmxLcndRSEpwdVor?=
 =?utf-8?B?Y05YZ3BHTHJrYkVlUFVPSm16QUZQVnhIRWdMSWo1SFBnZElKamc0VlFhbGJI?=
 =?utf-8?B?K2NhU0ZKRzFyd0VQSGp4K3ozVlM5dVYwdWdIWjZKeVFZbEpSWGRnWXdOUWF6?=
 =?utf-8?B?QlNvVmE2emVMeC9oVm5tTllINWNPSFkwM1IwSTFPZzVhZGtQaTVQSkxPY3NH?=
 =?utf-8?B?Yzk4VFBxZ0t3UTZ0NzFhMENNUG1kbFpTelJRanhqeEVFM2lLUHBRelJYWFFq?=
 =?utf-8?B?cjhuMm4vUW9vMlpiVzIwb2NoQUVsOEJueGhTRnlmV2dWQ2R5QkhnTEVPclZ4?=
 =?utf-8?B?RlRpUjNpSnNnR2NZU2t4N2VRUkNmWDdBeUk3R0lpS29EMWtGM1dxTHBrSDFH?=
 =?utf-8?B?MFpPckY2aGVSSCtTa0ZQVU9MMUJFZWFUTHkwQVBvZmt4OHBkVXNOVDI5V0JN?=
 =?utf-8?B?UGQ2SjlHaDNNbFk4WmRuRGp2VkYzcG9kZ0dMa3hZUVI5WmFTcUw4dXBrT1JI?=
 =?utf-8?B?K0pmSFZpL1NIM0Y0N2pzY2pRVlZHRURZOWNYa1k2NzFWajdQUTcycDRHN0Ny?=
 =?utf-8?B?UDZBMzl2VWxRKzFZZW8rSEtLODM4b1R2VVpmWENWSkNjeDZ3Vkh0TjU2aGt6?=
 =?utf-8?B?bjhIVUFPN2E4NjJXWEFaNHhicTdJb2I1L2lQbkFnZUV4K3lkTUVkTFp5cjVD?=
 =?utf-8?B?YkhhblVjdnE5OTBPMmNucFRFWVNYWHNmNGhSbitoKzNpT21CdTBKVzR3eVVY?=
 =?utf-8?B?MnczbFdGcXEyOURBaXJtSkxJblJNMmlrSTBxRUtFNHAxWjA2RDFlcmh2WjM4?=
 =?utf-8?B?OVkwbzZFem5nUGd5enNQY2VhZFp2Rjc4cVJFUGcrWEwyTE96ZXpuektDbTE5?=
 =?utf-8?B?WFJYcTVVaFFRcnpvZmVWS0NxSzl6WUlWR2J1OUFSUVg1Z1hVK0t4WWU3Vzdi?=
 =?utf-8?B?dU1jOVZUcUI3cDRUVGZidS9MTkhuN3IwUUxBUURiQVBFVVBOOWJDOEozRXF5?=
 =?utf-8?B?MTJHaHFTcEM2NUtTZFVXMFdlMDgrdE5maVNIM29lb1RTS1ZBY3lidjFRREhN?=
 =?utf-8?B?bzlRUWw1SFJGOEozK0dpRXRwV3FBSnN0TnRkclhzYTFUbzU1UnBrdFJtNzBX?=
 =?utf-8?B?bDh3UlJmSS9DS0FlSm82MVRSZGs2bTI4Rm1qVFl5aDc0UXA0QlFHd1dPbzd1?=
 =?utf-8?B?OU41eHRSM29HRFJMUkZXMVVtc3NMQlZqbE1vcHArZktpa1k1T281blRtNEFs?=
 =?utf-8?B?amovTTM3OVZ2eWo0UzNJVndoK1FnZTJEQ0JVY2VhTi90eFdRSktTWFhIajNH?=
 =?utf-8?B?eS9GaFFadWI4V2dXYXhnQVYvZWhnbFpRemRWb1preEt6cG9jZDIvZ3I5UjdO?=
 =?utf-8?B?cnBJVTdqcXpnM3JJQzJsUFR5MmRZemtZamdvVFR6cTdLcU1LY2N5aTFSd2pU?=
 =?utf-8?B?TmhsUVNaNWFid2RrMVpJWGZ6ZitPVEpQcDJGQ3FQODBhWXJDQzlYNWZrMFk3?=
 =?utf-8?B?ZnRmV0RyakFWbE5XMUppZWFVb0lpcGExTEdQL3E3SjR6cGR0a2FkTTVXZlk0?=
 =?utf-8?B?Ym5RRm9ma1FRU0c3anZsQms5cXJTS1V4dDV1YklFdXZFd1dzMmRKTUFzVHRs?=
 =?utf-8?B?VmxMRFNLWkNIQW5QOGRYZzVuSDNmVXB2YU5URHpGaUNJbHFSUWk3RXhHSXJY?=
 =?utf-8?B?ajdtaHo0VkZuRERMQ0x4eXlFT0trdnAvdXVDVXo5NWNXMTN3aERSVVIzbFZ2?=
 =?utf-8?B?b1ZYYWZ2R3hYa3dhZWdmTkVEZ0pUZ3hVcmZNZjl4dFVxSkszRWs1WmUySEpX?=
 =?utf-8?B?a3B0WW9pYWU0TEt1TWR5Z2x1M3d5ZXFhNEJtQW5RbWdkZ3k4U3JjRklVNW5S?=
 =?utf-8?B?U3JCRk5yWkZvSDJNQzA2ZjgxRDZqNXE1UjgwSExEZDg4SEdTSWwwUUV2c3Nm?=
 =?utf-8?Q?FDxvXApESLoTZNaQTqMFlTM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D2A294620C75A45B134EF95D29AABD2@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad381df-f401-4ee7-6619-08dc79979517
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:52.7918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LOiCMTB7iiKb8kolVJhmaSOMTPYMqNI6SVlSuTNtjWFSvd23x/OnpMXzZXr9XB9E/ecg1dl3PqwOUscRTo0UbAM/AT6I8Y6JKlSUIJnm7B4ds7vOTOYJaNl0JonKVTyh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6249
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

RGV2aWNlcyBpbXBsZW1lbnRpbmcgQVRTIGNhbiBzZW5kIHRyYW5zbGF0aW9uIHJlcXVlc3RzIHVz
aW5nDQpwY2lfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb25fcGFzaWQuDQoNClRoZSBpbnZhbGlkYXRp
b24gZXZlbnRzIGFyZSBzZW50IGJhY2sgdG8gdGhlIGRldmljZSB1c2luZyB0aGUgaW9tbXUNCm5v
dGlmaWVyIG1hbmFnZWQgd2l0aCBwY2lfcmVnaXN0ZXJfaW9tbXVfdGxiX2V2ZW50X25vdGlmaWVy
IGFuZA0KcGNpX3VucmVnaXN0ZXJfaW9tbXVfdGxiX2V2ZW50X25vdGlmaWVyDQoNClNpZ25lZC1v
ZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlk
ZW4uY29tPg0KLS0tDQogaHcvcGNpL3BjaS5jICAgICAgICAgfCA0NCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9ody9wY2kvcGNpLmggfCA1MiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwg
OTYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvcGNpL3BjaS5jIGIvaHcvcGNpL3Bj
aS5jDQppbmRleCAwZTE0ZWY0YWIyLi4xMGIwNzA4MTMwIDEwMDY0NA0KLS0tIGEvaHcvcGNpL3Bj
aS5jDQorKysgYi9ody9wY2kvcGNpLmMNCkBAIC0yODMzLDYgKzI4MzMsNTAgQEAgdm9pZCBwY2lf
ZGV2aWNlX3Vuc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2UgKmRldikNCiAgICAgfQ0KIH0NCiAN
Citzc2l6ZV90IHBjaV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbl9wYXNpZChQQ0lEZXZpY2UgKmRl
diwgdWludDMyX3QgcGFzaWQsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYm9vbCBwcml2X3JlcSwgYm9vbCBleGVjX3JlcSwgaHdhZGRyIGFkZHIsDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IGxlbmd0aCwgYm9vbCBu
b193cml0ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01N
VVRMQkVudHJ5ICpyZXN1bHQsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc2l6ZV90IHJlc3VsdF9sZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDMyX3QgKmVycl9jb3VudCkNCit7DQorICAgIGFzc2VydChyZXN1
bHRfbGVuZ3RoKTsNCisgICAgSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11X21yID0gcGNpX2Rldmlj
ZV9pb21tdV9tZW1vcnlfcmVnaW9uX3Bhc2lkKGRldiwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYXNpZCk7
DQorICAgIGlmICghaW9tbXVfbXIgfHwgIXBjaWVfYXRzX2VuYWJsZWQoZGV2KSkgew0KKyAgICAg
ICAgcmV0dXJuIC1FUEVSTTsNCisgICAgfQ0KKyAgICByZXR1cm4gbWVtb3J5X3JlZ2lvbl9pb21t
dV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbihpb21tdV9tciwgcHJpdl9yZXEsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV4ZWNfcmVxLCBh
ZGRyLCBsZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG5vX3dyaXRlLCByZXN1bHQsDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlc3VsdF9sZW5ndGgsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVycl9jb3VudCk7
DQorfQ0KKw0KK2ludCBwY2lfcmVnaXN0ZXJfaW9tbXVfdGxiX2V2ZW50X25vdGlmaWVyKFBDSURl
dmljZSAqZGV2LCB1aW50MzJfdCBwYXNpZCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuKQ0KK3sNCisgICAgSU9NTVVNZW1vcnlSZWdp
b24gKmlvbW11X21yID0gcGNpX2RldmljZV9pb21tdV9tZW1vcnlfcmVnaW9uX3Bhc2lkKGRldiwN
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBwYXNpZCk7DQorICAgIGlmICghaW9tbXVfbXIpIHsNCisgICAgICAg
IHJldHVybiAtRVBFUk07DQorICAgIH0NCisgICAgcmV0dXJuIG1lbW9yeV9yZWdpb25fcmVnaXN0
ZXJfaW9tbXVfbm90aWZpZXIoTUVNT1JZX1JFR0lPTihpb21tdV9tciksIG4sDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZlcnJvcl9mYXRhbCk7DQor
fQ0KKw0KK2ludCBwY2lfdW5yZWdpc3Rlcl9pb21tdV90bGJfZXZlbnRfbm90aWZpZXIoUENJRGV2
aWNlICpkZXYsIHVpbnQzMl90IHBhc2lkLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIElPTU1VTm90aWZpZXIgKm4pDQorew0KKyAgICBJT01NVU1lbW9yeVJl
Z2lvbiAqaW9tbXVfbXIgPSBwY2lfZGV2aWNlX2lvbW11X21lbW9yeV9yZWdpb25fcGFzaWQoZGV2
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHBhc2lkKTsNCisgICAgaWYgKCFpb21tdV9tcikgew0KKyAgICAg
ICAgcmV0dXJuIC1FUEVSTTsNCisgICAgfQ0KKyAgICBtZW1vcnlfcmVnaW9uX3VucmVnaXN0ZXJf
aW9tbXVfbm90aWZpZXIoTUVNT1JZX1JFR0lPTihpb21tdV9tciksIG4pOw0KKyAgICByZXR1cm4g
MDsNCit9DQorDQogdm9pZCBwY2lfc2V0dXBfaW9tbXUoUENJQnVzICpidXMsIGNvbnN0IFBDSUlP
TU1VT3BzICpvcHMsIHZvaWQgKm9wYXF1ZSkNCiB7DQogICAgIC8qDQpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9ody9wY2kvcGNpLmggYi9pbmNsdWRlL2h3L3BjaS9wY2kuaA0KaW5kZXggMjE0Nzk4MTQy
My4uOGFkYmE2YWY5NyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvaHcvcGNpL3BjaS5oDQorKysgYi9p
bmNsdWRlL2h3L3BjaS9wY2kuaA0KQEAgLTQ3Myw2ICs0NzMsNTggQEAgYm9vbCBwY2lfaW9tbXVf
aW5pdF9pb3RsYl9ub3RpZmllcihQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuLCBJT01NVU5v
dGlmeSBmbiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQqIG9wYXF1
ZSk7DQogDQorLyoqDQorICogcGNpX2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uX3Bhc2lkOiBwZXJm
b3JtIGFuIEFUUyByZXF1ZXN0DQorICoNCisgKiBSZXR1cm4gdGhlIG51bWJlciBvZiB0cmFuc2xh
dGlvbnMgc3RvcmVkIGluIEByZXN1bHQgaW4gY2FzZSBvZiBzdWNjZXNzLA0KKyAqIGEgbmVnYXRp
dmUgZXJyb3IgY29kZSBvdGhlcndpc2UuDQorICogLUVOT01FTSBpcyByZXR1cm5lZCB3aGVuIHRo
ZSByZXN1bHQgYnVmZmVyIGlzIG5vdCBsYXJnZSBlbm91Z2ggdG8gc3RvcmUNCisgKiBhbGwgdGhl
IHRyYW5zbGF0aW9ucw0KKyAqDQorICogQGRldjogdGhlIEFUUy1jYXBhYmxlIFBDSSBkZXZpY2UN
CisgKiBAcGFzaWQ6IHRoZSBwYXNpZCBvZiB0aGUgYWRkcmVzcyBzcGFjZSBpbiB3aGljaCB0aGUg
dHJhbnNsYXRpb24gd2lsbCBiZSBtYWRlDQorICogQHByaXZfcmVxOiBwcml2aWxlZ2VkIG1vZGUg
Yml0IChQQVNJRCBUTFApDQorICogQGV4ZWNfcmVxOiBleGVjdXRlIHJlcXVlc3QgYml0IChQQVNJ
RCBUTFApDQorICogQGFkZHI6IHN0YXJ0IGFkZHJlc3Mgb2YgdGhlIG1lbW9yeSByYW5nZSB0byBi
ZSB0cmFuc2xhdGVkDQorICogQGxlbmd0aDogbGVuZ3RoIG9mIHRoZSBtZW1vcnkgcmFuZ2UgaW4g
Ynl0ZXMNCisgKiBAbm9fd3JpdGU6IHJlcXVlc3QgYSByZWFkLW9ubHkgYWNjZXNzIHRyYW5zbGF0
aW9uIChpZiBzdXBwb3J0ZWQgYnkgdGhlIElPTU1VKQ0KKyAqIEByZXN1bHQ6IGJ1ZmZlciBpbiB3
aGljaCB0aGUgVExCIGVudHJpZXMgd2lsbCBiZSBzdG9yZWQNCisgKiBAcmVzdWx0X2xlbmd0aDog
cmVzdWx0IGJ1ZmZlciBsZW5ndGgNCisgKiBAZXJyX2NvdW50OiBudW1iZXIgb2YgdW50cmFuc2xh
dGVkIHN1YnJlZ2lvbnMNCisgKi8NCitzc2l6ZV90IHBjaV9hdHNfcmVxdWVzdF90cmFuc2xhdGlv
bl9wYXNpZChQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBwcml2X3JlcSwgYm9vbCBleGVjX3JlcSwg
aHdhZGRyIGFkZHIsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c2l6ZV90IGxlbmd0aCwgYm9vbCBub193cml0ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBJT01NVVRMQkVudHJ5ICpyZXN1bHQsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IHJlc3VsdF9sZW5ndGgsDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKmVycl9jb3VudCk7
DQorDQorLyoqDQorICogcGNpX3JlZ2lzdGVyX2lvbW11X3RsYl9ldmVudF9ub3RpZmllcjogcmVn
aXN0ZXIgYSBub3RpZmllciBmb3IgY2hhbmdlcyB0bw0KKyAqIElPTU1VIHRyYW5zbGF0aW9uIGVu
dHJpZXMgaW4gYSBzcGVjaWZpYyBhZGRyZXNzIHNwYWNlLg0KKyAqDQorICogUmV0dXJucyAwIG9u
IHN1Y2Nlc3MsIG9yIGEgbmVnYXRpdmUgZXJybm8gb3RoZXJ3aXNlLg0KKyAqDQorICogQGRldjog
dGhlIGRldmljZSB0aGF0IHdhbnRzIHRvIGdldCBub3RpZmllZA0KKyAqIEBwYXNpZDogdGhlIHBh
c2lkIG9mIHRoZSBhZGRyZXNzIHNwYWNlIHRvIHRyYWNrDQorICogQG46IHRoZSBub3RpZmllciB0
byByZWdpc3Rlcg0KKyAqLw0KK2ludCBwY2lfcmVnaXN0ZXJfaW9tbXVfdGxiX2V2ZW50X25vdGlm
aWVyKFBDSURldmljZSAqZGV2LCB1aW50MzJfdCBwYXNpZCwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuKTsNCisNCisvKioNCisgKiBw
Y2lfdW5yZWdpc3Rlcl9pb21tdV90bGJfZXZlbnRfbm90aWZpZXI6IHVucmVnaXN0ZXIgYSBub3Rp
ZmllciB0aGF0IGhhcyBiZWVuDQorICogcmVnaXN0ZXJkIHdpdGggcGNpX3JlZ2lzdGVyX2lvbW11
X3RsYl9ldmVudF9ub3RpZmllcg0KKyAqDQorICogUmV0dXJucyAwIG9uIHN1Y2Nlc3MsIG9yIGEg
bmVnYXRpdmUgZXJybm8gb3RoZXJ3aXNlLg0KKyAqDQorICogQGRldjogdGhlIGRldmljZSB0aGF0
IHdhbnRzIHRvIHVuc3Vic2NyaWJlDQorICogQHBhc2lkOiB0aGUgcGFzaWQgb2YgdGhlIGFkZHJl
c3Mgc3BhY2UgdG8gYmUgdW50cmFja2VkDQorICogQG46IHRoZSBub3RpZmllciB0byB1bnJlZ2lz
dGVyDQorICovDQoraW50IHBjaV91bnJlZ2lzdGVyX2lvbW11X3RsYl9ldmVudF9ub3RpZmllcihQ
Q0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuKTsNCisNCiAvKioNCiAgKiBwY2lf
c2V0dXBfaW9tbXU6IEluaXRpYWxpemUgc3BlY2lmaWMgSU9NTVUgaGFuZGxlcnMgZm9yIGEgUENJ
QnVzDQogICoNCi0tIA0KMi40NC4wDQo=

