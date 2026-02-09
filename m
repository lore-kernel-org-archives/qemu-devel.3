Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4CCE78D6F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNPQ-0005d0-55; Mon, 09 Feb 2026 04:18:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNPC-0005N7-HJ; Mon, 09 Feb 2026 04:18:11 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNP4-0007OW-W6; Mon, 09 Feb 2026 04:18:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFsdEENyJSYZalJ1fxVhNsBb6XSDSnd9nFEDtYEGXSwi2wY486KAvSqa4CbBJE11P5zHEdPUy3ownT7Muoxhc2oYg1BeWruIDv7f0Q3WsZ2xqIwy3T5T3J+pqq5rrC4IGK6LVXxu+SlsnEhyYze7OqGb8snm5P+a4aSA4XYW7Yp6GarX/TrkR+4lr35IO3n+t9wZhcjYdCRKvnMelrYpIRIKIsLx8ZZniBYHzwTLIiQsCkk6TC9Ky6lCxFvQt9svB093qsSHLSHZVlX+3XATmh9wnkl2Uu3nhJXOCnTBF3VmQuCWNOop+R66GOqyzPza1QsxtSxqOrDQKALgQML42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kw9Ko+sYD5Yc/0mwXwc9kuWdHl9V0at+3JWGDSWwD8A=;
 b=SjmdpWIqYa24Xb8gpoJlXBw9RdNxmxrKCe3tEv88cloOWyIwb0fpr5kR8PKJDNR/3rPrCxl9e624fT4SWRSFbj5neAvK8+uFouDeMWPeZmmPXKNl3H1g2ghF7TvTejPj9PUkjk/vDnk5cOcyaeELv9Hl5W8FmL1sn6ErsBB4XZ+v9MfADtEeTiRmcm2+FoDZsoKVa6lb/87XTbINJmflcIxnjUGsP0gBH6DnzuNht+OXvr7zPF+i/fjv1jogGn4v3me4dxh9sfvyRl+zgX/Mba4xjItxO9BwJvntAj2es7v0vpkSoTbZt+FJxWbx/myhZPJ/ckSuAxHXBIlqG6ZjSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kw9Ko+sYD5Yc/0mwXwc9kuWdHl9V0at+3JWGDSWwD8A=;
 b=MLQpcKDDIr6xgIUd2XdTTDqY+ArZz4s95hFlml5HUJap+3y6NCIyVxy4gDhNCLRV+epkVV/pDqSr53+lnTSN0MjHdU5sAp4j8e9hYI0HvpX+LWEfDWv+oHtix/OxEGYSQ19x9Sig3ULYGoaGEwKzOooBrc02fbooPG9ihyIORdsSFTGglJ6jzJZlEeQDuUjwrqHOL3e+yBkYcVdp+ircKnFXmgvFASfpTialY4pvpkPWePxpfXHI8QqiLKBhXScLhTYl+be08GMFzNUjVQ3Xgzg7Uyz+8hGMq9Ri3aVjuX3yBzeN9fNdQubGcvq0QgCSJ9ThySdwx360MsQZ144PBw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB7031.apcprd06.prod.outlook.com (2603:1096:990:6f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:17:51 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:17:51 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [PATCH v3 00/20] i3c: aspeed: Add I3C support
Thread-Topic: [PATCH v3 00/20] i3c: aspeed: Add I3C support
Thread-Index: AQHclxdmYyJyqQdIoUC/kDEZE0v29bV1eaAAgAQ7zPCAAEEaAIAAJOSA
Date: Mon, 9 Feb 2026 09:17:51 +0000
Message-ID: <TYPPR06MB8206490C7958A85920D630F7FC65A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
 <53224b36-db6a-4790-8abc-d6aa79b95358@kaod.org>
 <TYPPR06MB8206F2D0EAF733D287BB87D7FC65A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <c2a1b965-2329-4e5d-b0f0-7542ff5df1fc@kaod.org>
In-Reply-To: <c2a1b965-2329-4e5d-b0f0-7542ff5df1fc@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|JH0PR06MB7031:EE_
x-ms-office365-filtering-correlation-id: 4cab08c0-003a-4785-1eb8-08de67bc196c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?MDBrK3BLazI2T1VJa1Blc3FDRFNlOUdSTW8ydUNKcXhsdDZ3bmc0L0lwNDNi?=
 =?utf-8?B?d0ZaYkFGZnBFUkFJTWpKTXRURlRON25lZjJrRW8wVlZKSTczajJIa0R0S0VK?=
 =?utf-8?B?U2prSGF1ZjhNcW12U050dFpWT0JPY0krUkROMkQ2YVdBem5LUzlFNlFWSmsy?=
 =?utf-8?B?WW9ycG5IenNwQUtJRDZRMlZGYzh3MVRoSXdXcDJHb1k5bkdYZDgzdVBwU1NY?=
 =?utf-8?B?UzR3T0xVRFRaWGI3TnBLT09TeEZNTklWYzR2V3kwRGlQbEVyN09yMzh6dnFv?=
 =?utf-8?B?VENBbEtVS3NPWGladjVMSnFzM1dwVy93emtnWkRyMnM5bHhDZndRbHE4d0hC?=
 =?utf-8?B?bzkrWHBNbDcvK1BLQjgxS2ZrT0NhZTBHQ3F4KzhqRGNld0h1UmEvM2hsREtp?=
 =?utf-8?B?QlZBbGpJa3Z2aytuT25zY1FzUU5GRjFWTTFiMGVRU2xsblNnZ01Fd08vYkFF?=
 =?utf-8?B?Kzd4NnlLd1YySkgzUEp6bFpnMUs2L0x1TzJYb1Y2RHJ1VEtaalJNYWw4UWVF?=
 =?utf-8?B?UGRPaWY3cVJTYmMvY05Wc1prTXhqSkdWaFo5Z0l1Wk5zbVE0OHJmN2srWStE?=
 =?utf-8?B?N2JMZWp0U0krWldZM1Jya3lNZFJ1NEowazhveFVlNUlGeHpOZkRuSVl5em1y?=
 =?utf-8?B?amxnN2FQRERIRmdsWE1rY0Q5VDNRclNFNHQ5NCsySlFhRVBva2V1cWVzb3pK?=
 =?utf-8?B?cHVPYUFmWVBvZ2YxQ2FIdVlRQXhzWWRuVHRaaUJ0ZWZUYmt3cjM5d0d4VEdC?=
 =?utf-8?B?Q09PMlFPWHdpMWlSM05NU3ZIU2szOG5CMkhDK3RDUUVZSG16bEdTYjJWeHdh?=
 =?utf-8?B?NS91Y3VwNUpSbWdQM3MwRWxWTGQzcVorczdxRzRtSml1cE9rVmM1bFdxQ1ZO?=
 =?utf-8?B?SGM3QmgwMVZWTW84UGE3blJ3TklxRlRnSEZxSWFPOE1WZ2g3M3ZodWlhVlMy?=
 =?utf-8?B?emFKWlBXd1NmZ0Rkc001UWRJbTB3Rks1cGgvWTEyd3VEblFhUmhqMi95UjJU?=
 =?utf-8?B?QnFGZ2dIZnZHSG5oc1BJTi9DZFNRL3p2THhhd3pMV2FjSVZ4KzR4NGFYb0lq?=
 =?utf-8?B?RXFSVktpTloyQjdKMHRjNWQ0aXhzRlFPdVBpVk1xekZCU2FrUnJOcFBnQ0NF?=
 =?utf-8?B?YXhIY2ZpdGFxa3lqT0Ywa0hFZmlSZnhha3RrNEQwRlYyZGd4N1djQzlNcjh3?=
 =?utf-8?B?QXRFN2N5UGIwMlBrdGE0YWpVNWRoUFkwd1JKaFVSalZNWkkzbFdENDBjZWd4?=
 =?utf-8?B?djg1SVFEOWprYXFMUU9hKzU0RG1SMTg1WnZNS3Nwa2FUS0dqUTFnNHJhWThp?=
 =?utf-8?B?TG8rSnBPQTVnZ01iTlh6bDM1MlptUkNQUHZ4SHlYRFJUdnl2MWEzaFN4MGd1?=
 =?utf-8?B?akVIYllMM0YwaEhEN3JRTFpLRERqaXFrbUNqOXFscC9XWWFwRFdlelZ0YUlL?=
 =?utf-8?B?M3ljSFN5MTN1NFV0U1hkVXVRQWxydlpCQkI0QmduSFY3Ri9RUThYT0JXUW9Z?=
 =?utf-8?B?VEJCbVNjV2dmOUM0K0ZpMXU5b3QvQ05UR1NmcHJaWVZxQkJUWkJ5dXdjMFoy?=
 =?utf-8?B?dCtrZGp2S05jK1VON3p3dTl4QUxvTXo0ZnhhQjVsWTNiNk4yalhnNGFrQytx?=
 =?utf-8?B?bG5lMkJ4NDNxZE1qL2JWdkRwUjU2ZWo5RndxMzhRMnhXQitaMTJOWGIvYzV1?=
 =?utf-8?B?YUtNbmZzRCt0VDZSVHNsRzB6WXRwZ2FwZkp2Znc3Ly9TV2pPbVJVSDZhL290?=
 =?utf-8?B?ZGptNnk5UmdUOFg0S2ZxYVl4elRUNytqTE1Dd3pScDljMVZ3djhHY2pEQWpy?=
 =?utf-8?B?RmJseGpJbHR6V2d6aW5SMktBYkU3SHVoWU5KYjJiOGdIRTdPN2gvam5DS053?=
 =?utf-8?B?bVZsOHQvRkhzNXliTFcyc0pDUXFIZmVQVS9JSEU5ZHVKcjV1Qk9KL0pWRE5v?=
 =?utf-8?B?NVdIQ051azl0YWZqd0VqN1JUL1dMK2NEOXlXQUNtTCtmMHlzYTRZK3A5Z1l5?=
 =?utf-8?B?S3VlWVdYRVRiUnYrMDlJR2R6S25LMnZxRXRJNytpMTBxLzRURGNrM1liOGp1?=
 =?utf-8?B?WGc4RytRdW5vamluYUcyQ1BxdjBabjVvSkphbWVkWnZoOTVrSFNpeHpMNThN?=
 =?utf-8?B?ZzV6TnFob2Z3K1NWQ2RMenN3K1E5VktHeVIxVytwZEdibTRRaWhZSjZhKzdo?=
 =?utf-8?Q?rQTiKx5fS1KDC4ylxpVbNtG5r26olWot+YUU09LKmiDv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVFFcHhnd2FWUk96d2xPSTVvUFBpdUZTNisyMERYdlVxVysxWDZ5aDMxTWQ1?=
 =?utf-8?B?K3lKd1BLM09VWUliZHhvUDV0TkdITnFpcU9qTnE0bFZEWndtaDd6bTNxOC9t?=
 =?utf-8?B?OEtPMStWVlFpcEFvNEJVTG5wK1FkcTRYMTFvZGZrSDE0blBHQTlOanlabXJ0?=
 =?utf-8?B?dGNCSkhpY0FYRDhmb21uVTE1UXdYbzhJMUZnbUFLc3Y5QnFtb3RadldObFpP?=
 =?utf-8?B?dG5HVkxqVWV6UTlsQU9mMitOcjU1WEM0MTlHZnRNR0JIcklhckFJMU5RNjNF?=
 =?utf-8?B?UmpDYVVDdjdvdUN0c0dFeVM3SEtyMFh4bnhEYUJCd2REYnFmYVF6T2MrY2E0?=
 =?utf-8?B?emJabUM0TzdpWXZ5bXEwSzM5eit6SzBVUVFpM0VkbnJLeVFObkZLVDVMbEhV?=
 =?utf-8?B?S1Vqb3k4Y2crTFJlMC96SVZuMkF0c3prSmdNY0tmdU1jUWMxcVk0bGMxQ0RB?=
 =?utf-8?B?Y09tcDE2eTRqdVhJUGlPY2ZaTkkxU255SVVuQjh0cmN0VUViNW91MVJTSlVN?=
 =?utf-8?B?MlAyL1Y1UHEyZ2U5UzJBejJrSHFvZTJvZ0xJNlN6dXNDak9jcnA3WUp2d29T?=
 =?utf-8?B?Q0RBRVVyODgzM0F6cmxpbmd4VmdDSWgxaWcyUkdobmR5My9kWDZuRC9WYXZM?=
 =?utf-8?B?cmd4b3lFZW9sMXg0Uzd6bjNFTHhyRmNZTjBKZ0t0ZDJtNEJjTGVoUnBvbjZ6?=
 =?utf-8?B?bkhWYUhTdU93QThKNUZ0eEkvbEsrOVN6bjV1N21xRC9sRjdpWUpoRXpBZTh6?=
 =?utf-8?B?bkY5akZyRmJYZEJ6SkVqNXRkTFNZM01xclpDSWFiNmxJMGRVcnZmNXNpenpS?=
 =?utf-8?B?NVYyQWFkZFNHNTA3V3habmRSd2tWUzZUQUFRTXhFTmV5bUNlRmllQXBGaUlN?=
 =?utf-8?B?eUxHYzVrNTkrNWs5MHJUYkw5VlVwV2VUOVZ4TllCME1ITTdLcGFOSzVMRTlQ?=
 =?utf-8?B?L2pJRElzMnJZZndwcmdoZDdGdHJxMTlYbFNRdkQwV0o0QVBxS2orVGcrZFVz?=
 =?utf-8?B?N1o4aS9Kc3hWQTJWVm9PcWdQTVZRb3VMTy9icHdXM0RwV0NaQmZ6UUxYN3pv?=
 =?utf-8?B?dGY0SjBwU0JPeVljU0J5SGNmUDNIUmVya1Q2OW1GbGJqYXhaK2RCcDhJZy8x?=
 =?utf-8?B?TzVDUy8zYmZ4dDh4b1V4SGl0R2tETkxiOVF0SUlaemxlRW5lZm9aZE1tcWVP?=
 =?utf-8?B?aWplVml1UkZKUFFRWGJNajJaVGg3VURYd3NrNnBuVVJ0MXJ2NzhoNUhacWEy?=
 =?utf-8?B?VXRIMXA5RXpwMG83dEc4eTBuT282T2E4UUpIN0tLQVpoaTYzNnQ2NlVmZDk4?=
 =?utf-8?B?TTNlbXVDQmhoK0lhZitrR2N4bnRsYkZmamJoYmZnL1ZmMC9KTkFIWDR5YVZw?=
 =?utf-8?B?UWpKS00zRFhiT1ZhcFFObGVxV2xBMFIrOVhhRVlzbW5yeGlOSFNkQTdRam1t?=
 =?utf-8?B?a0NFSktLVmQ5V2FBTTNOWGY0Rk9tZVRkZThTajhrR0VlNWlYMHhwTVJtcW95?=
 =?utf-8?B?cmRtbHVDT0xQeXArSHRWQnZLQmVVSS9NRWlObmRpMGNOby9QT0pQTC8wcW54?=
 =?utf-8?B?a0MwZGNCTnpHWnQwRWE5eS8zU1ZQUFJ2elIvZVdXTHFqWkN2YmZWMTZWanR0?=
 =?utf-8?B?UEd3TXdEbk9KeGlXTlo3cmpibnRRdmRHU0R3Z1ZEZktlMDR1MWxxUGd3amg2?=
 =?utf-8?B?VTFaMzNpY09nS3cyZm91NUYzOHd4VllqczYyNnl0bGNRTWIxM3VxM0JwU3FL?=
 =?utf-8?B?OFExT1B2aytiTVk5dXhQZFJ2QUlBVkNLV0JpM1RrUkIrMlRadE5zZnhtelI0?=
 =?utf-8?B?YzcrOEJzSjcrWlJwNEpacmdTQnU1aU0yVFFuYzV6VzlYbUkyc3JGVDUrSk9s?=
 =?utf-8?B?NXRUaklDSHNQZzljOEFISFViZjY5SFlIdWlQcUZSSHMwUWY2eWN6SVluZzl3?=
 =?utf-8?B?VFNqSU9FbGdNTkFDTWJCUFZ0VEl4MTV0eWx0VTI3WmRFRS9HckJ2YUFvWEQ0?=
 =?utf-8?B?TndHdjB6SGFmYnY4TVBNVjFiRmcrOC9kT2NyRUdhU3QvSFdGb1pxdmVQVnBY?=
 =?utf-8?B?WktNN211UEFXWTBzaytuS1l6RTlkSkZOcTlKdjZYeCsyK3dOUGhSN245YVdQ?=
 =?utf-8?B?dkJLZEV4eHF1UCtNZkFtR0RrdXE0M1RobEtXNG0zcnB4MVRjWFdTcEZZSFJs?=
 =?utf-8?B?blQ3VEQyUzdXOE9GbE1xNVhEb3FYZGdCUEZuTWpRTnlpbjltSzZVY3c3ajRE?=
 =?utf-8?B?R1JUaDNidERSQk9oYU4xVTNlbkNMelhWYXFjWFdOdGUzcTVKS3F2cHkwSWNs?=
 =?utf-8?B?RzlTZXk2N0hTSENDRVZIVXArVGpIVG5NcUIzT1N0MGlxeldFTEFqQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cab08c0-003a-4785-1eb8-08de67bc196c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:17:51.1194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d87txwdFrAY4qIdQ+hbUO++zGKJA1XOsykmoAduP++u6LKzMQux2t45Mx3SN1XpI4Txxrh/s8/zv9FFGZy2KBvoaIaLdiPfNR8n52EE3xUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7031
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDAvMjBdIGkzYzogYXNwZWVk
OiBBZGQgSTNDIHN1cHBvcnQNCj4gDQo+IE9uIDIvOS8yNiAwNDoxNywgSmFtaW4gTGluIHdyb3Rl
Og0KPiA+IEhpIEPDqWRyaWMsDQo+ID4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwMC8y
MF0gaTNjOiBhc3BlZWQ6IEFkZCBJM0Mgc3VwcG9ydA0KPiA+Pg0KPiA+PiBPbiAyLzYvMjYgMDQ6
MTksIEphbWluIExpbiB3cm90ZToNCj4gPj4+IHYxOg0KPiA+Pj4gICAgIFRoZSBpbml0aWFsIHBh
dGNoIHNlcmllcyB3YXMgYmFzZWQgb24gd29yayBieSBKb2UgS29tbG9kaQ0KPiA+PiA8a29tbG9k
aUBnb29nbGUuY29tPi4NCj4gPj4+DQo+ID4+PiAgICAgVGhpcyBzZXJpZXMgYWRkcyBJM0MgYnVz
IHN1cHBvcnQgdG8gUUVNVSBhbmQgYWRkcyBtb3JlDQo+IGZ1bmN0aW9uYWxpdHkgdG8NCj4gPj4g
dGhlDQo+ID4+PiAgICAgQXNwZWVkIEkzQyBjb250cm9sbGVyLg0KPiA+Pj4NCj4gPj4+ICAgICBU
aGlzIGltcGxlbWVudGF0aW9uIGlzIGEgYmFzaWMgaW1wbGVtZW50YXRpb24gdGhhdCBpbnRyb2R1
Y2VzIElCSXMNCj4gPj4+ICAgICAoaW5jbHVkaW5nIGhvdC1qb2luKSwgQ0NDcywgYW5kIFNEUiBk
YXRhIHRyYW5zZmVyLiBBcy1pcywgaXQgZG9lc24ndA0KPiBzdXBwb3J0DQo+ID4+PiAgICAgbXVs
dGktY29udHJvbGxlciBidXNlcyBvciBIRFIgdHJhbnNmZXJzLg0KPiA+Pj4NCj4gPj4+ICAgICBG
aXJzdCB3ZSBhZGQgdGhlIEkzQyBidXMgYW5kIGNvbnRyb2xsZXIgbW9kZWwuIFdpdGggdGhhdCBh
ZGRlZCB3ZQ0KPiA+PiBleHRlbmQNCj4gPj4+ICAgICB0aGUgZnVuY3Rpb25hbGl0eSBvZiB0aGUg
QXNwZWVkIEkzQyBjb250cm9sbGVyIHNvIGl0IGNhbiBkbyB0cmFuc2ZlcnMNCj4gPj4+ICAgICBh
bmQgaGFuZGxlIElCSXMuDQo+ID4+Pg0KPiA+Pj4gICAgIE5leHQsIHdlIGFkZCBhIG1vY2sgSTND
IHRhcmdldC4gSXQncyBpbnRlbmRlZCB0byBiZSBhIHZlcnkgc2ltcGxlDQo+IHRhcmdldA0KPiA+
Pj4gICAgIGp1c3QgdG8gdmVyaWZ5IHRoYXQgSTNDIGlzIHdvcmtpbmcgb24gdGhlIGd1ZXN0LiBJ
bnRlcm5hbGx5LCB3ZSd2ZSB1c2VkDQo+IGl0DQo+ID4+PiAgICAgb24gTGludXggdG8gdmVyaWZ5
IHRoYXQgaTNDIGRldmljZXMgY2FuIGJlIHByb2JlZCBhbmQgY2FuDQo+IHNlbmQvcmVjZWl2ZQ0K
PiA+PiBkYXRhDQo+ID4+PiAgICAgYW5kIElCSXMuDQo+ID4+PiAgICAgVGhpcyB0YXJnZXQgaXMg
c29ydCBvZiBsaWtlIGFuIEVFUFJPTSwgYW5kIGl0IGNhbiBhbHNvIHNlbmQgSUJJcyB1cG9uDQo+
ID4+PiAgICAgcmVjZXB0aW9uIG9mIGEgdXNlci1kZWZpbmVkIG1hZ2ljIG51bWJlci4NCj4gPj4+
DQo+ID4+PiAgICAgTGFzdGx5IHdlIGFkZCAgaG90cGx1Z2dpbmcgc3VwcG9ydC4gVGhlIGhvdHBs
dWdnaW5nIGRvZXNuJ3QgZG8NCj4gPj4gYW55dGhpbmcgdG9vDQo+ID4+PiAgICAgY29tcGxpY2F0
ZWQsIGl0IGp1c3QgYWRkcyB0aGUgZGV2aWNlIGF0dGVtcHRpbmcgdG8gaG90cGx1ZyB0byB0aGUg
YnVzLg0KPiBJdA0KPiA+Pj4gICAgIGlzIHRoZSBkZXZpY2UncyByZXNwb25zaWJpbGl0eSB0byBo
b3Qtam9pbiBhbmQgZ28gdGhyb3VnaCB0aGUgREFBDQo+IHByb2Nlc3MNCj4gPj4+ICAgICB0byBw
YXJ0aWNpcGF0ZSBvbiB0aGUgYnVzLg0KPiA+Pj4NCj4gPj4+IHYyOg0KPiA+Pj4gICAgIEphbWlu
IExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPiBoYXMgdGFrZW4gb3duZXJzaGlwIG9mIHRo
ZQ0KPiBJM0MNCj4gPj4gcGF0Y2gNCj4gPj4+ICAgICBzZXJpZXMgZm9yIHVwc3RyZWFtIHN1Ym1p
c3Npb24uDQo+ID4+Pg0KPiA+Pj4gICAgIENoYW5nZXMgaW4gdGhpcyB2ZXJzaW9uIGluY2x1ZGU6
DQo+ID4+Pg0KPiA+Pj4gICAgIDEuIEFkZGVkIEkzQyBmdW5jdGlvbmFsIHRlc3RzLg0KPiA+Pj4g
ICAgIDIuIFVwZGF0ZWQgcGF0Y2ggNCB0byByZWZpbmUgcmVnaXN0ZXIgZmllbGQgZGVmaW5pdGlv
bnMuDQo+ID4+PiAgICAgMy4gVXBkYXRlZCBwYXRjaCA3IHRvIGNvcnJlY3QgcmVhZC1vbmx5IHJl
Z2lzdGVyIGZpZWxkIG1hc2tzLg0KPiA+Pj4NCj4gPj4+IHYzOg0KPiA+Pj4gICAgIDEuIEFkZCBT
aWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPj4N
Cj4gPj4gU29iIGlzIHN0aWxsIG1pc3NpbmcuDQo+ID4NCj4gPiBUaGFua3MgZm9yIHBvaW50aW5n
IHRoaXMgb3V0Lg0KPiA+IEkgY2hlY2tlZCBwYXRjaGVzIDEgLSAyMCBvZiB0aGlzIHBhdGNoIHNl
cmllcywgYW5kIHRoZXkgYWxsIGluY2x1ZGU6DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGlu
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9wcm9qZWN0L3FlbXUtZGV2ZWwvbGlzdC8/c2VyaWVzPTEwNTE0MDgNCj4gPg0KPiA+IERv
IHlvdSBtZWFuIHRoYXQgdGhlIFNpZ25lZC1vZmYtYnkgaXMgbWlzc2luZyBmcm9tIHRoZSBjb3Zl
ciBsZXR0ZXI/DQo+ID4gQ291bGQgeW91IHBsZWFzZSBsZXQgbWUga25vdyB3aGVyZSB0aGUgU2ln
bmVkLW9mZi1ieSBzaG91bGQgYmUgYWRkZWQ/DQo+IA0KPiBJIHdhcyBjb25mdXNlZCB3aXRoIHRo
ZSBwcmV2aW91cyBzZXJpZXMgLi4uIFNvcnJ5IGZvciB0aGUgbm9pc2UuDQo+IA0KPiBJZiB5b3Ug
cmVzZW5kLCBwbGVhc2UgYWRkIHlvdXIgU29iIGF0IHRoZSBlbmQuDQo+IA0KVXBkYXRlZCBhbmQg
cmVzZW5kIHY0Lg0KDQpUaGFua3MsDQpKYW1pbg0KDQo+IFRoYW5rcywNCj4gDQo+IEMuDQoNCg==

