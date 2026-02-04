Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762F6E83EE0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX9X-0006WE-EB; Wed, 04 Feb 2026 02:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZP-0004hm-1y; Wed, 04 Feb 2026 01:40:59 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZN-0004HR-Kg; Wed, 04 Feb 2026 01:40:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jq6CSghs1FOUo58ImzVSXG8nNYr8hZd8/kNdvereN+nopxFhoKjE/sizMAIgu6D7ADA61V7NF1FhL1vSXq09IF31KusiqbLb/jJMtpke1Pkffau7Jjn+8W7HkR3vkL5vCyzBzcybc2SdqytgGpLgczweEhyVgOBa8+9brt6cXCXe5hjhfODnUuw33OcxKApKeAZ/5QF+9JqzYuDNdCkJRHWZaiKyuBqwiofFG35YHmaPhkwNhD1tCNB9PtjrV7GleAH8ebaj/oY1Dhe7vjyYo2ic+xkBoR29xNmxr3k4eexlTtfJOUjlcIx2ZxmivaMD3MC/H+gpIBj03LUNgmZ46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4JSgmWSNnAvWAVdLeG3jwmCl1W1+Sb5r/vPZqikO38=;
 b=f4MHGj2MyE2VkLJJ604xtocJZQ+Be/MBIOI6lgwBktgbS22CR1zXF7h4sMlTrIjn+awboCznmS2yWVNHs+QN3JUTpjz3ivKP0KwJJTPVRMs2yVGNsRAhYE91wXIRWlAfrK3C6Tj6/WEWwJiA/nFk59JxQy+FSlviExlTtf4b5ElHFOwBLa97FLPk+bs9BiSHHJ72WSv/uDiBy/FarC01gJJ9+U2zyqlTtTnjfJkaRxKYKGqv4MkLClWKjrvRK5xfyQTbitqK7EO1OtGYwU03dIfuIG3AkZUOTO4Tq6yT1k310LsU1OEv0NlK/z67TpEFklQHCGqmldXvDXm+n1TjZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4JSgmWSNnAvWAVdLeG3jwmCl1W1+Sb5r/vPZqikO38=;
 b=cgllW06M96M4QgXh9MVczniyfyp6vINkg4fwov+BIMBMcud+kndtA7NYIoNU18fGiZIUcqW+5CG2HpFXyrUB61gzqYzWty7ySapqFYKVOKBo2P6TJSMO+BZ4ZabRviQuqOWlLi3pvD6trUIZKH2Nz/aGWhFdoLCN2Sr8lA33UhpOVGAZtEiQjuKUWxBeYlgTWJa4AQoT/6K4BWjWvTvKtzLWL1qQCfGqsUNap9PM92z06jOo6eirm+AKIgOy+Oqc87E9EseHTkYE4QSix9fdkR4v83pjhe3RsP2fh89VsSnpLeQuIOtX7geE9ALinobJp2VqucCa9yZB8Kd82Yx/TQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5901.apcprd06.prod.outlook.com (2603:1096:301:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 4 Feb
 2026 06:40:43 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:43 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v6 19/22] hw/arm/aspeed: Enable AST1700 IO expander support
Thread-Topic: [PATCH v6 19/22] hw/arm/aspeed: Enable AST1700 IO expander
 support
Thread-Index: AQHclaEvfZn/0L6D4EywBu+VEhKObQ==
Date: Wed, 4 Feb 2026 06:40:43 +0000
Message-ID: <20260204064016.3515639-20-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5901:EE_
x-ms-office365-filtering-correlation-id: 0fa2e967-dad0-430c-bc97-08de63b85228
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?czRJbHJJYUREZDAxeWk3a3F5NmlSeDBhRk1Pc050bVl5eFRmM0FrcWZDcmdw?=
 =?utf-8?B?eEdQRVRWUCt6d1BxMm1OdmZLSHBvb0IyeVR5MHNSaFllbFlYMGZ0MjNvZzhu?=
 =?utf-8?B?cnRhSmFmWHBzY2RRN1M2SGVNdi9URDN1Sjh3MGdZdlV1RDN4OHMzVWkvb1dF?=
 =?utf-8?B?NVM3NDN6Q3B2VVFGcyt6dlB0RGRBWGRtM0VjdGpjR0VMZWNaaVF3MUMrdnE4?=
 =?utf-8?B?ZjA4NGxwSnJ5cTA2dmJ5bk9ZeHRhM244K2xyMktkY0xlVEkyM2p0aTVGY2Zq?=
 =?utf-8?B?UDNENGVkV3gyWFo0Tkx6SUFLVEtnR3NtL3g0bVQyWUxQckdTd0xsTlNaSGwy?=
 =?utf-8?B?TWVpZXVqVHhRQk96bEJwTnd6eXMwcExmKy9SZU54U2NVdjNRWE1KNjRQRkpt?=
 =?utf-8?B?MU93Z1NHRkxmTVZ2TmlZNXUzeDVhV01BaEZ2MmZKWEE2VGpzQll5U3F3d01X?=
 =?utf-8?B?b2Q0QWpwWm9BOXAycFBPbTFpS2tzZU9tdDg3ZWo5bjk5eVBkSE1KQlZRbDQz?=
 =?utf-8?B?ZFdJZ3RWckdvUWhwOW1SKzhNeTVUYzk0NlVLQ0FBTzd4dTZlRjhMWE5rTUht?=
 =?utf-8?B?U3dRVWk1TGJhWTdvNktnV3hTY2NnckNWU1dUNmR2ekx4VTcvcFZkNGpOeWd1?=
 =?utf-8?B?Nmsyd3oyOHZyRnBZTTUzNS9EOG84OEtSZGlhNFpCRjM2WDRhQk94a0tkL3p3?=
 =?utf-8?B?ZkJoVU9GK1hIWG9oRE8vWTZFdFpCMDAxV2xNVElBZ0FUN2RnY2lpRzIzS2x4?=
 =?utf-8?B?aHd5RlhxU05SZTZGZy9CWGF5ZXRCN2hCWWZMMTdtYWNCdE1KUTVUNkRPVUtq?=
 =?utf-8?B?SFNsdnVxZ3diYmoxeU5nNmJWT2dQVmtWd1BMZW16a0sxRHZHUW8xVE5MMk1T?=
 =?utf-8?B?K3ZqR25yRnp4cThobWFGNTNNT0hMa0tjQmlIaVlNTE9QRDJjU3NhWVp0b2V5?=
 =?utf-8?B?cWN2UWF1UWkraDZDSkNIZ2pObTg5Zm4wK2pEcExpMUtNTG9ZRFM4Y2dKS0lS?=
 =?utf-8?B?TnUyc1phOWtTOGpqY1hyTmtwVnJpSHhqd2JTNU9BdGk3dzdCQkF4MS8ydTZ3?=
 =?utf-8?B?emFTZ1Q4NytWQXlJNWpuU2QvR2U4dTJpeEovWHJuZVd6ajNKd0xVNmdVaEZI?=
 =?utf-8?B?VnltUW5nVlhYVzVKc1VLanhKc0FwdWNibnhuZ3Mzejk5bHpzalgxb2YyalY3?=
 =?utf-8?B?RFVmblRQcmlXeHIzL3RjcHNqemdGZC83QW5XbTlVSGR4Rm9XQXFlS0V3N1BB?=
 =?utf-8?B?b3JQVUtFeXgyWk8yYTJhSklvZ0FzU285clNubmp2QlM0OXVudFdBR2NMbWMw?=
 =?utf-8?B?eXFHVU1iRzZDeWZoRmJsclBSRDJla1llTXhpVG0yUGNSeStRUyt2aWVUYXdu?=
 =?utf-8?B?d1BFZjQxTCt6clNlZVRaNFhQUzJxSUthcm9obXlVeFJMR3VtbllkRHdTUjRW?=
 =?utf-8?B?ZGdzMlZCSk51b1IxajZFWThFQTlxRW0wbUl2UWtJZnNVcUpHRnRKK1FEeldQ?=
 =?utf-8?B?dWttT3dKci80QXV0M0NKVlh5NDJQZ0hCVTJrb05LVWRyaTBZTW1VcUZzd0RF?=
 =?utf-8?B?VHI3MStHVjNnaDhibXpGYjhuc0p4WEU3Mkk4YmJENFFJNFd4TG5JNFFvb1pO?=
 =?utf-8?B?Z0Uvb2YzK2VtYS9GMmhNN1BsczJ5cWVIUmFUZDJMKzRNWkJaaGJGRHdJUnBM?=
 =?utf-8?B?LzArTlM0NmFHYUYrNkhIeUFITXBEamxYRDVIakJmZUpNaUx0WUI5KzNZckdU?=
 =?utf-8?B?K2lOeGR6NUhDVVFKYUNmbDh5bXdaTFZidFI0LzRsb2toTktqczNqQzhFQXNR?=
 =?utf-8?B?bUhTTTZCRDdMZ0xNMTYxQ0VmWjlQZHozR0pyUVgwRWx6Rlp4eS9TTG1ibzVw?=
 =?utf-8?B?aHJEWGNSVFRxYXBoVGVNTnpTTVRFZEZYMUNJdVV2RkRzbHV3ZWRlaEwxSzJ4?=
 =?utf-8?B?QkZ3emRtTDU4Y052NnhibW5xU3pNZHpCWkFCZnFGcTJXQy9mc1pqVU5BelZM?=
 =?utf-8?B?aG9ObjFVbmVkbWJoQ1hPdWc4Lzd5ZktpWCtrUzVWWWFaWVFENkJBL0dFS1RM?=
 =?utf-8?B?Y1dVblpsMzhwZUxxWjAwbzdpWGdyWFF3Rk5HS1BrRDkxRkMzejAveXlsekdo?=
 =?utf-8?B?R0dMdmFMZGVGMTMwYm9Rc0RHOFRiV2p4TVp2dVVkSjQrRXQzUmZlU3ZlWUk5?=
 =?utf-8?Q?7+9K3L5YBJmty6ZanhdwtqI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aExwQkxTWlpUV2V5TGZjclZXQXR5R0MrbkRXQ1ZUZzVLUjZrMzhYK2JqemdV?=
 =?utf-8?B?T2pUekJRaVZlblpKa3UraTdDV1lPQ1E0TkN5ZjcxZ1VJY21TVVBGUlAyUktM?=
 =?utf-8?B?TUQ5cjVTVERjSEFNVDU0aTNUSVdQWnpQN0szUDlhTGhVZjAxMFczNWhzNkN2?=
 =?utf-8?B?QWM2QlBqR3AybG11QVpxK09XL1lSMmg3emFacjArWnppUldyQXpKQmdidzR5?=
 =?utf-8?B?cHFLQTE3RE9qUXN3SnYwTmFFNnRBaW5zeHV6MWpXcC9WakcvV09valZIYzY1?=
 =?utf-8?B?R05lWk52TklxNU9EYURkbWgza1J5NkxrSDVoNDQ4YVpiV2QvcHMybTJBbm9V?=
 =?utf-8?B?WmNRcVlabjVWeGx3NFBGa0tLK3lQQWFsOStKK096NEpaM1FuU1F6TXFBSEN6?=
 =?utf-8?B?OHJBU0RBZm56My9jRjJtZXVRVnVOcjV5bGhBSDdsZDM1RjZwdE96R3o5a3ZN?=
 =?utf-8?B?MmhPTURGQUNXVytIdEhKbTFFbXF6L2ZxRWdsRmlLSDhsWDdnSk9aaURoUTZq?=
 =?utf-8?B?bVlEcGhXdGZKbXJSKzJ3M01wTkIrdGI3NGFCbW1rNFNvQWYyS2svQURsZnJ5?=
 =?utf-8?B?SDh5RkJZUUZLOWJWaFc4M3kwQSs0V1VKUEhPek5FbXJnbGxINFBYMDNURnhH?=
 =?utf-8?B?RnNIR3VDTTVkTmlWcks3bUJ3eXByL0gzYUlJUkxvcTkyOHJjeFk3Wi9CQXB5?=
 =?utf-8?B?ejVjTXJIVlhjWmtYUVFuU3NwWGxCYjhRN0puYzNvS3kwVmk2bTJac3ptZW9R?=
 =?utf-8?B?dDR4cDNoeUJIY3RKRnBUYnVtODdFWmlQZUIvcUFqTXNKQzNoOUxEMWpJWktU?=
 =?utf-8?B?ZlN0OHFBUnQ1akNlSHZQWXBPR2xQNFAxZ2krc2dtbFNwZE5aaEJPeVZCdGpN?=
 =?utf-8?B?b1dtM01ReEVtL2pzUENYYmZkMGVzY1BQNWxqOTJrOEgrSnVlQjZjWmN0RDRr?=
 =?utf-8?B?Mm5TNUFqdTZVUlpVVDZxUzhMZkxEMGozZFNjcUEycHRSdFFOZmRQOERWc0Q0?=
 =?utf-8?B?ZmMrRFdSQnc4R1Yrdk42aE5hQnQwTmUyTGlLTGxCWWxWNDlMdExPd2l0ajNz?=
 =?utf-8?B?eHVyRzl0djcvYjNVVXR5VTJqMU5BYkZFU2ZMRFFDTlE0R0EvY21GMk1WNGdy?=
 =?utf-8?B?SlpaNkZXeDNFT01BZytVOXEzaWZNSnFaaS92Q0l3M3daZkhkK2MxS01tVy9n?=
 =?utf-8?B?Yzh6LytQZFpoQk5mL2NEQVVLSitZYjhobDc1bG1WYkZ0cDB2VlZjV2haTk9T?=
 =?utf-8?B?cDBKWVo5SUdwM0NJZGY2enpRblVEMUJ6V2lsay9KLytONnM4TWIzV2MyeXJT?=
 =?utf-8?B?L01YQWNETnc0NHBvMWpMZ0VUMjg5clJkSE5obFlhTy9mMEdGZGpZSGVBeE0z?=
 =?utf-8?B?R0U0UnlTNE5WYXRseWdTaitWMWZsNTl3YXkwbDM4NUdJbUE3ekNJNEM2WDll?=
 =?utf-8?B?T1oranlFV24wQ1ZxQ3piRTYxakQ3em01ZkVxTFRYRDBLK21hOCtLUG9nVm9v?=
 =?utf-8?B?VXYxV1dGMmpmVkRxMmVrc284L2lUeEdTMnRGdm5yMlF1Mm9IK0hmUkdXdEtw?=
 =?utf-8?B?YnpBWFAvNXJoUFZ1cmxwU2xmampuWDZhTWxkK2ZMNkUzcm43YkxSWUlXWmo3?=
 =?utf-8?B?eXY0cktETG92Wi8zYnBxOFpwWjU3em9teXBSWlUxb3ZkT1V0RE5MODMxa1d0?=
 =?utf-8?B?d2dibHIwcU1EM1dQYTZPcEJGWkxNNE9VL2lNendFcS9zSzJ0N3B4YmRSYXJ2?=
 =?utf-8?B?WEFQanNsakdRZ25qNmdZK2hHeFY3cE1SMUVKTmNnV2lDYmNnYWc0SjhNVjZn?=
 =?utf-8?B?NHNsNndBa09PaFJqVVdpZURJeFZsVUhLbnZuQlAxQnB3Smt4NFNUbkg3NkUv?=
 =?utf-8?B?dVFXRExvSmFkckhvOTMrK3RpdjUxUnBwLzYxemF5OS9wa05qczZjcjd6UmxR?=
 =?utf-8?B?aFA1VzgxMEF3a2pQa2JQVmJSZHFBaEZ6Z0VuNmNWMEQvV2dDa21nRzN3bksy?=
 =?utf-8?B?UDNRTlIvQnphVWxTclMwOWVMNFlEU3lCSVhJcU40dDlpWDI3VzdIZTZxT0Na?=
 =?utf-8?B?S2cvU1IvNTkzVnMzTVlWVjgwWXBxQ2FYMTB1S2F5NUpMVkgrdVhpZHpTbFpi?=
 =?utf-8?B?aWMxNVYvd05LQnhvbGdPaGo2K3VGeTJ2cGxxeWVTWFNiMlVWWE9SMjQ1N0pa?=
 =?utf-8?B?L2tlSk1HL2VYNlN1NzduZGsxNEU1K1ZqN3pFcnhDOVlMTEJVQjhML0hpTlZU?=
 =?utf-8?B?Ym8wZHYzOTRqWU5FQUpUa0FCVzg1Ykw5dkVVZHpEYjBqV1RyTW5VVzJ3SVdv?=
 =?utf-8?B?enFRK0ZEbjlXZkRIY0NoWWxadkNxWVpZUFdzcFdpTDRSUkR2WXd5QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa2e967-dad0-430c-bc97-08de63b85228
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:43.6266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q+VFxoOIBSYzaBwbjDO3OFJJiQ4od5MMgeDTy0Vk6og4sqEXEgDdamCqbpa0KfEijcZ1O3UsTzHRzSUVSBNqohzfw8IW8lpybX5iENzE348=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5901
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:22 -0500
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

U2V0IGlvZXhwX251bSB0byAyIHRvIGVuYWJsZSBBU1QxNzAwIElPIGV4cGFuZGVyIHN1cHBvcnQu
CgpTaWduZWQtb2ZmLWJ5OiBLYW5lLUNoZW4tQVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4K
UmV2aWV3ZWQtYnk6IEPvv71kcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+ClJldmlld2Vk
LWJ5OiBOYWJpaCBFc3RlZmFuIDxuYWJpaGVzdGVmYW5AZ29vZ2xlLmNvbT4KVGVzdGVkLWJ5OiBO
YWJpaCBFc3RlZmFuIDxuYWJpaGVzdGVmYW5AZ29vZ2xlLmNvbT4KLS0tCiBody9hcm0vYXNwZWVk
X2FzdDI3eDAuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIGIvaHcvYXJtL2Fz
cGVlZF9hc3QyN3gwLmMKaW5kZXggZDNiMzA1ZmE3YS4uNjE3OTBlYTFjYyAxMDA2NDQKLS0tIGEv
aHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMKKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMKQEAg
LTExNjAsNyArMTE2MCw3IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9zb2NfYXN0MjcwMGExX2NsYXNz
X2luaXQoT2JqZWN0Q2xhc3MgKm9jLCBjb25zdCB2b2lkICpkYXRhKQogICAgIHNjLT5tYWNzX251
bSAgICAgPSAzOwogICAgIHNjLT51YXJ0c19udW0gICAgPSAxMzsKICAgICBzYy0+bnVtX2NwdXMg
ICAgID0gNDsKLSAgICBzYy0+aW9leHBfbnVtICAgID0gMDsKKyAgICBzYy0+aW9leHBfbnVtICAg
ID0gMjsKICAgICBzYy0+dWFydHNfYmFzZSAgID0gQVNQRUVEX0RFVl9VQVJUMDsKICAgICBzYy0+
aXJxbWFwICAgICAgID0gYXNwZWVkX3NvY19hc3QyNzAwYTFfaXJxbWFwOwogICAgIHNjLT5tZW1t
YXAgICAgICAgPSBhc3BlZWRfc29jX2FzdDI3MDBfbWVtbWFwOwotLSAKMi40My4wCg==

