Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10D5C021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 05:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkzNs-00027M-OI; Thu, 20 Feb 2025 00:46:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tkzNp-00026o-K4; Thu, 20 Feb 2025 00:46:01 -0500
Received: from mail-eastasiaazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c400::] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tkzNk-0006nA-0A; Thu, 20 Feb 2025 00:46:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZmI0pse3txPH49Qy1zs20vvGsQ66UGjUUyy5j4XG9zeQGphmDFpAYwn4MpVWeOmHHIgddiqXucvqAuiBrisfmeJepGQu3SuJqYozWTg91ZsyZNhbIUW9Gb/AvsZz2Z6h0tzXorbwvqmHe70w/saBAyBFNd/S8KRArDSi6VnuhJxMIdkaAljkz7+xI87c26ll+P6ddsQ/2MkYfCH/N/6Wo3cvVOarKI3jd5z2t7kFZA7QbDA2ecXtLOdecPMH2dBQToUTmhzG89B4TeA04mxuQhlmgp+0FtMFpf3mCJaE06pmq4xlvcpbgeecEOB7Ggw/+YipQlFAa6pXdEKVRN+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daTi2+Y+6dd6GvAAe/TtJigZIVfoiWSSLT/EOL1R7Ao=;
 b=YQ7a4mZYhD67seFZj8TWQgT6c0x4cmQlrmKcbhxPEkqzN1z3Zk4gGmRzUmpfElNUJ8WaxClaEozqvAj9x1ZsUmT4rGSc6w+C/GQW4JLi+tqmKTgO6gD3XsjJd/j4ei1xFEeUTzJpinNW0y89H+g/jsIJirpVh3fVnu/L1wZgCSNeM9GXXTh71xnOudqc20W8FqZvbtvu229tx2PUxi2kHMfk43jsN8LKsvdi1Ovpk/UU2it+lodL+0a22Hc3phHTRlarp3YHK0a/WWa6rtX+mD/HVV0jr947NaMHaWyagpNTApEhBXqX+auKVyAXvCceKs0gLLStrAYM8aaFaNttqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daTi2+Y+6dd6GvAAe/TtJigZIVfoiWSSLT/EOL1R7Ao=;
 b=OSGsIXsBR4VRGy8Q8ZNt7CS+wD/+BHS17TWsX2r+Vss/+6vLOyMxY2UItrA4UaNOjiUL9yFJzXjwR6PaPa5yRcW5gqJ+c8UJT8SWuzyzMWDLGnfhZLcIetsbiDKtpafUwo2+1OBY2RT2nR6RrztohEj5KM73JnAp2WZG8KiqHtMAT2O99d8+zGNjMkZLoI9vZzJONb0mYaceh1QCkn8AoDyCC+FwNC1rtVlI0TqkZRbQS+ODy0qhweZIC7xAxpL77wER9qZiQy1TmlixPpWwsHOv5SixZp2OUCHPRHgzFD/HDWQfXadM9xyaA7TIB34j1WeYd99c2RTE740F2PF2hA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY0PR06MB5628.apcprd06.prod.outlook.com (2603:1096:400:328::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Thu, 20 Feb 2025 05:45:44 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8466.009; Thu, 20 Feb 2025
 05:45:44 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 01/28] hw/intc/aspeed: Support setting different memory
 and register size
Thread-Topic: [PATCH v3 01/28] hw/intc/aspeed: Support setting different
 memory and register size
Thread-Index: AQHbfchZga/9C5EScU+3dWzlxIhcfLNMkcqAgAMfp/A=
Date: Thu, 20 Feb 2025 05:45:44 +0000
Message-ID: <SI2PR06MB5041068E28CC4DD8CFA24854FCC42@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
 <20250213033531.3367697-2-jamin_lin@aspeedtech.com>
 <d770b173-c9e8-46b0-9c36-4f3fd3005d92@kaod.org>
In-Reply-To: <d770b173-c9e8-46b0-9c36-4f3fd3005d92@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY0PR06MB5628:EE_
x-ms-office365-filtering-correlation-id: b4faf338-180c-42bb-67fa-08dd5171d181
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZkxzQUZZbGJucjhuNTZTNTk1SmRrUUNRZGRIbmthRW90QWUxbTlTaUlGbW9R?=
 =?utf-8?B?cWV4UDhKVFp6UTRtYmZkcUVscHk5TEw0TU83MmZXeDZGdWErTUtzZUwrUyt1?=
 =?utf-8?B?aFRTTUZ2UTd1dW9TWlpQUWt2aFVFVHVoM3RLNm0vemRFL3RLTkJBMzE4OTAz?=
 =?utf-8?B?UXlSWTE3dDgzL2k4SzNxMm1DcHh6dFc5ZUhoWms3ZzRXUW5seHVTK0hBNWlw?=
 =?utf-8?B?VW1wV1QzZURObVBwTGpQeXpWVGE1Mi92S2VxUGhMc2NYV3ZBN1VEaGhqSEhR?=
 =?utf-8?B?bWxzRndRS1JOb0xqb2d5WUwvd2E2NkQ1cisxNUNJQlg2NTdEMlQ3YUxsZjVr?=
 =?utf-8?B?cHRKeVhTU2Nxc0RzVVVleG5FbUo4K3ZlNVBqQUhpTXFFN3d5OUw4cGIyanZR?=
 =?utf-8?B?UzQyVHQrNTZDYUlBaU5URmxBYlpWNlV3WlQ4Y1ptaGVzdzIyMnpnS2RBS2JV?=
 =?utf-8?B?V0w3T2tNWTFSWXZYMk0vUWxiWXNJekN5RHRHaVh1OHBYQ3l6Z0lxRUpFOUpN?=
 =?utf-8?B?MTJwYjJ4U1RybGVpallDREhudVNHQlEzN2dkSG5UQ2ZJZU5mV29tOWlXVmwz?=
 =?utf-8?B?QzF1cjVHWTk3VDZEeE9zYml5M1ptTFYwSWdwZFh0b2xtZENEZzF0MExyUXZu?=
 =?utf-8?B?cGU5T05JNVhqK3kwTFRmMVErczBQLzRQVEg0a0JlZW43WHZVdFN5UnpJNTg5?=
 =?utf-8?B?djJiZXZBMUF0VWNMUWxOUVhkOE1hUFg0ZVBwVVdGc04wYmM2dzdPL2Z5MkI2?=
 =?utf-8?B?ZjhKMkx6cWtRT1JGRVhiZWhFdFJCK2FRREhTOWgyTFVHWjVxekJHWXU2Y1li?=
 =?utf-8?B?Q2dpV2hWK1FMdmNEVGM5dlRYMVdya01uUDNWZ1FJUlZkRzgwOFZTdVJwbHBL?=
 =?utf-8?B?RFJ6VWJvN3AyOTVzZXFidHRrbks0ZmdTWmNBenZaNnpLemNiQm1ONGdKVlZN?=
 =?utf-8?B?RzlwbzhhZEFVNkF3eUlaZlRSYWk5eHgxekJYcGFNZjhPVWZHSHFDMFJNUjNE?=
 =?utf-8?B?NEVzOHVUMk9EZFl4dHNadnZLczFBTUp1SHM2b01FdlN2bDRaUnlXR21hNmN1?=
 =?utf-8?B?T0VyZkJILzg5Z2Roa05SMHh1S0p3VlhkVE0xSVl4L29ESVQ3VEVYeks3N0tS?=
 =?utf-8?B?NGJ0OTFZeDU5SjNDSEMxeWVJVXNhWUZqSGt2SjdsWU1iN0haY0FYVkw5NTBS?=
 =?utf-8?B?azNIZU9VenFVblE3eTBTeVhHVHhpZDVrdXFkaVhnc2NuMXo1NWVkMDdkZExV?=
 =?utf-8?B?dEtIQTRhWHdhbGhRRG5oeFcvamxOclEvZW1lWkd5NitWR3lRelgwc09UYmdx?=
 =?utf-8?B?VDA3ZE5vUnBIK1kxZ3ArT1UyWlNRRlJ6TS9FK3ZlSE9RN0VWeUJoSjJ3SWFH?=
 =?utf-8?B?bkV2ZThnQkI5L3ZQTS9jclAwclk1M3UzVFhNRGJaaFJsb3M4bGI2N3hRUXEx?=
 =?utf-8?B?M294dmdYZ0VUcDVHcnlRVUJRRkRUSHhTMGxDeGtmUTBmejBWcW5WSEdwZHhn?=
 =?utf-8?B?QnhDV2pseHdSakQvUlZpamh6VFdlbWIxZXZyaVZuZUpwRkZxZCtMRnZuaHRo?=
 =?utf-8?B?Z3BWQ1Fjd0Mrbk8vNkZvQVJkMmEvUFIzYklOOTIyd09WR05DWng2eHdCZ296?=
 =?utf-8?B?c3hFUmovdW9WQXgrN0dCN2tnRWM5UDhoVWg4NXVNbTlnTmRCbnNBOGE3MGo0?=
 =?utf-8?B?Zm5jb29RQlJKN3hydm1acGxLTE04ZEJpZEpia1hNWnN5dkZUc1NFYzdBL0Qz?=
 =?utf-8?B?SW83TjV3WVQ1bUVXRWN2VlkzOVJaQVJSUjIyY05oU2tSdkZ5bEtuVjR2Rngr?=
 =?utf-8?B?ZTZmakFFS3JkWWFDVldpcmFtOEtuQis4WjZWOTJWTzRNMDFiYmxwd0hneWdP?=
 =?utf-8?B?M3hIU3N1RDJNS3p4eC8wK09ySHFKaHFrbGlKa284OE53RFJIcSt3TUJudlVT?=
 =?utf-8?Q?kkKlwfkXtuTDtWDtybIQBeckY0S6C2hO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFlWblJXb0ZyRWpLQk9lZVl2RmpQOGJaeVJrdzNNRlcrSm1Bd1ZiaUZQUksy?=
 =?utf-8?B?UTY3NDU1cEVROTB2OFJ3MEkwQ29BYUs4KzAyV0NPa1Q2LzErQUd6Nnl4QVdh?=
 =?utf-8?B?S3V0c1dZWHVBQndKZVBoWS96QjExM1FLZ1RuSFY2WDlpdWNhcitrUHhobytP?=
 =?utf-8?B?djhHN040alkxUjhPMHZHdUFnaHNRNkhodUdBZ0MrZjA0bUgvbEdwVXRoRFBG?=
 =?utf-8?B?VUFkSW8wRXFzMmNuSWV2RGxZWnFYVWNGdDYwa0RibGE2WWZ5QlFoN1lteElH?=
 =?utf-8?B?VEpSZERXZzNsTzd2Vm4wOVZTcWN4NHRRNHdZSEp0RmJINk9Iemxwd0l4dVpL?=
 =?utf-8?B?NzRiU2FicHRHSUQ5OE5KSm10YmxhSzh4cWIrbHFIZUVDblIrbldQWjhwclA2?=
 =?utf-8?B?ZGw2Q3pzaDdOWmdyWEVhZ0RqS3FFYkRqQzI1TXIyVzZZNEpPR2lCS3RXSXE4?=
 =?utf-8?B?bWMzeldmWXh2YzcwR09mMjhkMTg0aG5wM1NqRm12VXpwcFV3MHErTUZ1b3hi?=
 =?utf-8?B?RFJWenJPdUYxQXBNVTl2Ulp0QXJiMlphQ2xmRjM0TGZHUVp6ZUszYjVCT3oz?=
 =?utf-8?B?WVkxcnJDWXBFTUdLYm1EaWg4cjljdERQRDM4RXRPNEFBcjZZRG9lakRLZlFZ?=
 =?utf-8?B?WWRDMGI4NXNxR2pjYVAxaEdLNWJvNGNVekQ2MDJPV0wvbkZSaDhKWC9aWERR?=
 =?utf-8?B?dklzSjExSVlwd3pPRXQwU2U5cWpBM01TVkVSM0tQNkRqVlM2REVDbUJVeTdV?=
 =?utf-8?B?eUkzeXJZMVFOWHBZdFhCTVNka0xWcFkzc2l2ZGlhQXNSdlpvNkFuQTNSc3FL?=
 =?utf-8?B?YmtaWGpIZ3hTNGVEM1kzV2tjcVJRNXRaR2tRY0duZ292LytZUG1qZkw0R2RZ?=
 =?utf-8?B?Qmk5SDJFZG1JVEQ3SXVRQ1RYU0FKWjZyMmNsR3RhU1N5cVBleGVOaiszYXlF?=
 =?utf-8?B?WVd2enBVOWo3R1pxR29XMXdib25iQkcrNWV6bGdFbTNGV1V3OWE2M2x2ZVF2?=
 =?utf-8?B?ZDJKanE0ZFpXa0dnaTc0K0g1Mkx3bkVONzE0VXhRWXlEN0dtQjFidGE1VmNs?=
 =?utf-8?B?WHJpa2pOeStUbDNyN0h5MXRlSDR1bWNuSTg2UFlxd0M0d2hiTThJY25Ibysv?=
 =?utf-8?B?VVNVbXlpUVF1TEZUaHdtZkpmK010cDdhS2ZDSE9JRm5BbDF1eW9zRWlJcU1Q?=
 =?utf-8?B?RmdYWUxCZFJEVC9NSUhkTWUrcjh1a3U5aEZuQjR0Rk40aUZyN3lCV2FnS2ha?=
 =?utf-8?B?RHVERm5xTVhGQlYxdGNDOE9sV0NML2hZNy90SDdBRnFldzVRS3JaemdOOVJu?=
 =?utf-8?B?Vk5tTTZHKzRjZ3RDTEV3ZjYrMGxxWjBVaGpGS0RnZ3dMenZUUzRDTWxybUVz?=
 =?utf-8?B?NjRFSlRTZjFSSnJnU3B0U0xKQUVraVMrdWMvV2ZuNUN1N2dNbTl5ajNMMFlo?=
 =?utf-8?B?c2JMS3hvUWJyZmx6eEdWTVJ0ZUtHb1dVMkgwTlk4LzZvWlEyelRsN1V0Tk03?=
 =?utf-8?B?dmJmbmlweW5mZVo5Q1RaRkJHUWpaQ09wbTlUVis1NWNjM3d5bnhLRVgwUDNj?=
 =?utf-8?B?MlY0dW5CcnpOMmppSXVkVkVJeGVlcUk1aGVnMTMwa0psdUNsSTFQZEkxU20x?=
 =?utf-8?B?SWFDbG4wdmNJZjJpUUVzeXc1K2MwSU9MZXN6MVBScWtFcElQY252OGthdGhu?=
 =?utf-8?B?NmcwT29VN0dJWlNHWFdTc1l4cVg3OXlKZEJIeXowcXE1aEhZcGJQdGpuOWNT?=
 =?utf-8?B?VGFNbWt0R2IwZ1pYRkxsZVNORTVTczBHbVBiWkpHTUc1UU5LbFlqaDhOL3BQ?=
 =?utf-8?B?NVd2ZDI4czRENkRqV3dFcWdQVjYwSW1KYnp1SHZib1IxY3J2eEUyaVRtQkxh?=
 =?utf-8?B?N1R0bUNtYm5MSXgraTRpNTBVNjJObDMrRUthcm4wQjgwQXpJSjJ1a0NRd2hh?=
 =?utf-8?B?c0x3cUloWEREQlBGdXVFNWFsbnI1ZG5mbzNrSk9KY04xL2t0alBlTm1XVWpk?=
 =?utf-8?B?eCtBc2haM2lpZ2p4OEovMnFQdy9zTmlCRlVYSHVrRVE2L2NYaWg4cHpaWFds?=
 =?utf-8?B?ZmpjRU9FWitoMGxuT0lEaTBrMVJ4azdieTZWL05SWEZqTnNuZ3lDMWlOQ3lv?=
 =?utf-8?Q?jwNlTjA+jdy9FMJDBwqOQpfmk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4faf338-180c-42bb-67fa-08dd5171d181
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 05:45:44.4216 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x4vD+9lqg1/fag3QTuwhVeUtK36bFGhPwwlBPcmqRP7F+4siJ9vR5aULRMs9fHMk7xkfZq95JzhTXeZTG1LWAzzLBq6+G3JxwsRhTQisNIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5628
Received-SPF: pass client-ip=2a01:111:f403:c400::;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK2PR02CU002.outbound.protection.outlook.com
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

SGkgQ2VkcmljLCANCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAxLzI4XSBody9pbnRjL2Fz
cGVlZDogU3VwcG9ydCBzZXR0aW5nIGRpZmZlcmVudA0KPiBtZW1vcnkgYW5kIHJlZ2lzdGVyIHNp
emUNCj4gDQo+IEhlbGxvIEphbWluLA0KPiANCj4gT24gMi8xMy8yNSAwNDozNSwgSmFtaW4gTGlu
IHdyb3RlOg0KPiA+IEFjY29yZGluZyB0byB0aGUgQVNUMjcwMCBkYXRhc2hlZXQsIHRoZSBJTlRD
KENQVSBESUUpIGNvbnRyb2xsZXIgaGFzDQo+ID4gMTZLQg0KPiA+ICgweDQwMDApIG9mIHJlZ2lz
dGVyIHNwYWNlLCBhbmQgdGhlIElOVENJTyAoSS9PIERJRSkgY29udHJvbGxlciBoYXMNCj4gPiAx
S0IgKDB4NDAwKSBvZiByZWdpc3RlciBzcGFjZS4NCj4gPg0KPiA+IEludHJvZHVjZWQgYSBuZXcg
Y2xhc3MgYXR0cmlidXRlICJtZW1fc2l6ZSIgdG8gc2V0IGRpZmZlcmVudCBtZW1vcnkNCj4gPiBz
aXplcyBmb3IgdGhlIElOVEMgbW9kZWxzIGluIEFTVDI3MDAuDQo+ID4NCj4gPiBJbnRyb2R1Y2Vk
IGEgbmV3IGNsYXNzIGF0dHJpYnV0ZSAicmVnX3NpemUiIHRvIHNldCBkaWZmZXJlbnQgcmVnaXN0
ZXINCj4gPiBzaXplcyBmb3IgdGhlIElOVEMgbW9kZWxzIGluIEFTVDI3MDAuDQo+IA0KPiBTaG91
bGRuJ3QgdGhhdCBiZSBtdWx0aXBsZSBwYXRjaGVzID8NCj4gDQoNCkkgd2lsbCBhZGQgb25lIHBh
dGNoIGZvciByZWdfc2l6ZSBhbmQgYW5vdGhlciBmb3IgbWVtX3NpemUuDQoNCj4gPiBTaWduZWQt
b2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4g
PiAgIGh3L2ludGMvYXNwZWVkX2ludGMuYyAgICAgICAgIHwgMTcgKysrKysrKysrKysrKy0tLS0N
Cj4gPiAgIGluY2x1ZGUvaHcvaW50Yy9hc3BlZWRfaW50Yy5oIHwgIDQgKysrKw0KPiA+ICAgMiBm
aWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2h3L2ludGMvYXNwZWVkX2ludGMuYyBiL2h3L2ludGMvYXNwZWVkX2ludGMu
YyBpbmRleA0KPiA+IDEyNmI3MTFiOTQuLjMxNjg4NWEyN2EgMTAwNjQ0DQo+ID4gLS0tIGEvaHcv
aW50Yy9hc3BlZWRfaW50Yy5jDQo+ID4gKysrIGIvaHcvaW50Yy9hc3BlZWRfaW50Yy5jDQo+ID4g
QEAgLTExNywxMCArMTE3LDExIEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9pbnRjX3NldF9pcnEodm9p
ZCAqb3BhcXVlLCBpbnQNCj4gaXJxLCBpbnQgbGV2ZWwpDQo+ID4gICBzdGF0aWMgdWludDY0X3Qg
YXNwZWVkX2ludGNfcmVhZCh2b2lkICpvcGFxdWUsIGh3YWRkciBvZmZzZXQsIHVuc2lnbmVkDQo+
IGludCBzaXplKQ0KPiA+ICAgew0KPiA+ICAgICAgIEFzcGVlZElOVENTdGF0ZSAqcyA9IEFTUEVF
RF9JTlRDKG9wYXF1ZSk7DQo+ID4gKyAgICBBc3BlZWRJTlRDQ2xhc3MgKmFpYyA9IEFTUEVFRF9J
TlRDX0dFVF9DTEFTUyhzKTsNCj4gPiAgICAgICB1aW50MzJfdCBhZGRyID0gb2Zmc2V0ID4+IDI7
DQo+ID4gICAgICAgdWludDMyX3QgdmFsdWUgPSAwOw0KPiA+DQo+ID4gLSAgICBpZiAoYWRkciA+
PSBBU1BFRURfSU5UQ19OUl9SRUdTKSB7DQo+IA0KPiBTaWRlIG5vdGUsIEFTUEVFRF9JTlRDX05S
X1JFR1MgaXMgZGVmaW5lZCBhcw0KPiANCj4gICAgI2RlZmluZSBBU1BFRURfSU5UQ19OUl9SRUdT
ICgweDIwMDAgPj4gMikNCj4gDQo+IGFuZCB0aGUgcmVnaXN0ZXIgYXJyYXkgYXM6DQo+IA0KPiAg
ICB1aW50MzJfdCByZWdzW0FTUEVFRF9JTlRDX05SX1JFR1NdOw0KPiANCj4gVGhlIG51bWJlciBv
ZiByZWdzIGxvb2tzIHByZXR0eSBiaWcgZm9yIG1lLiBBcmUgdGhlIHJlZ2lzdGVycyBjb3Zlcmlu
ZyB0aGUNCj4gd2hvbGUgTU1JTyBhcGVydHVyZSA/DQo+IA0KQWNjb3JkaW5nIHRvIHRoZSBkYXRh
c2hlZXQsIHRoZSBlbnRpcmUgcmVnaXN0ZXIgYWRkcmVzcyBzcGFjZSBzaXplIG9mIElOVEMgKENQ
VSBESUUpIGlzIDE2S0INCigweDEyMTAwMDAwLTB4MTIxMDNGRkYpLiBUaGVyZWZvcmUsIEkgc2V0
IHRoZSBtZW1vcnkgc2l6ZSB0byAweDQwMDAuDQpDdXJyZW50bHksIHdlIG5lZWQgdG8gdXNlIHRo
ZSAiR0lDSU5UMTkyLTIwMSByYXcgc3RhdHVzIGFuZCBjbGVhciIgcmVnaXN0ZXIgSU5UQzFCMDQu
DQpUaHVzLCBhbiBhcnJheSBzaXplIG9mIDB4MjAwMCBpcyBzdWZmaWNpZW50Lg0KDQpIb3dldmVy
LCB3ZSBhcmUgZ29pbmcgdG8gaW5jcmVhc2UgdGhlIHNpemUgdG8gMHgzMDAwIHRvIHN1cHBvcnQg
dGhlIGNvLXByb2Nlc3NvcnMgU1NQIGFuZCBUU1ANCkluIHRoZSBhbm90aGVyIHBhdGNoIHNlcmll
cy4NCldlIGFsc28gbmVlZCB0byBpbmNsdWRlIHRoZSBmb2xsb3dpbmcgcmVnaXN0ZXIgZGVmaW5p
dGlvbnM6DQoNCi8qIFNTUCBJTlRDIFJlZ2lzdGVycyAqLw0KUkVHMzIoU1NQSU5UMTI4X0VOLCAg
ICAgICAgICAgICAweDIwMDApDQpSRUczMihTU1BJTlQxMjhfU1RBVFVTLCAgICAgICAgIDB4MjAw
NCkNClJFRzMyKFNTUElOVDEyOV9FTiwgICAgICAgICAgICAgMHgyMTAwKQ0KUkVHMzIoU1NQSU5U
MTI5X1NUQVRVUywgICAgICAgICAweDIxMDQpDQpSRUczMihTU1BJTlQxMzBfRU4sICAgICAgICAg
ICAgIDB4MjIwMCkNClJFRzMyKFNTUElOVDEzMF9TVEFUVVMsICAgICAgICAgMHgyMjA0KQ0KUkVH
MzIoU1NQSU5UMTMxX0VOLCAgICAgICAgICAgICAweDIzMDApDQpSRUczMihTU1BJTlQxMzFfU1RB
VFVTLCAgICAgICAgIDB4MjMwNCkNClJFRzMyKFNTUElOVDEzMl9FTiwgICAgICAgICAgICAgMHgy
NDAwKQ0KUkVHMzIoU1NQSU5UMTMyX1NUQVRVUywgICAgICAgICAweDI0MDQpDQpSRUczMihTU1BJ
TlQxMzNfRU4sICAgICAgICAgICAgIDB4MjUwMCkNClJFRzMyKFNTUElOVDEzM19TVEFUVVMsICAg
ICAgICAgMHgyNTA0KQ0KUkVHMzIoU1NQSU5UMTM0X0VOLCAgICAgICAgICAgICAweDI2MDApDQpS
RUczMihTU1BJTlQxMzRfU1RBVFVTLCAgICAgICAgIDB4MjYwNCkNClJFRzMyKFNTUElOVDEzNV9F
TiwgICAgICAgICAgICAgMHgyNzAwKQ0KUkVHMzIoU1NQSU5UMTM1X1NUQVRVUywgICAgICAgICAw
eDI3MDQpDQpSRUczMihTU1BJTlQxMzZfRU4sICAgICAgICAgICAgIDB4MjgwMCkNClJFRzMyKFNT
UElOVDEzNl9TVEFUVVMsICAgICAgICAgMHgyODA0KQ0KUkVHMzIoU1NQSU5UMTM3X0VOLCAgICAg
ICAgICAgICAweDI5MDApDQpSRUczMihTU1BJTlQxMzdfU1RBVFVTLCAgICAgICAgIDB4MjkwNCkN
ClJFRzMyKFNTUElOVDEzOF9FTiwgICAgICAgICAgICAgMHgyQTAwKQ0KUkVHMzIoU1NQSU5UMTM4
X1NUQVRVUywgICAgICAgICAweDJBMDQpDQpSRUczMihTU1BJTlQxNjBfMTY5X0VOLCAgICAgICAg
IDB4MkIwMCkNClJFRzMyKFNTUElOVDE2MF8xNjlfU1RBVFVTLCAgICAgMHgyQjA0KQ0KDQo+IA0K
PiA+ICsgICAgaWYgKG9mZnNldCA+PSBhaWMtPnJlZ19zaXplKSB7DQo+IA0KPiBUaGlzIGlzIGRl
YWQgY29kZSBzaW5jZSB0aGUgTU1JTyBhcGVydHVyZSBoYXMgdGhlIHNhbWUgc2l6ZS4gWW91IGNv
dWxkDQo+IHJlbW92ZSB0aGUgY2hlY2suDQoNCldpbGwgcmVtb3ZlLg0KPiANCj4gPiAgICAgICAg
ICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgIiVzOiBPdXQtb2YtYm91bmRzIHJlYWQgYXQgb2Zmc2V0IDB4JSINCj4gSFdBRERSX1BS
SXggIlxuIiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgb2Zmc2V0KTsg
QEAgLTE0Myw3ICsxNDQsNyBAQA0KPiBzdGF0aWMNCj4gPiB2b2lkIGFzcGVlZF9pbnRjX3dyaXRl
KHZvaWQgKm9wYXF1ZSwgaHdhZGRyIG9mZnNldCwgdWludDY0X3QgZGF0YSwNCj4gPiAgICAgICB1
aW50MzJfdCBjaGFuZ2U7DQo+ID4gICAgICAgdWludDMyX3QgaXJxOw0KPiA+DQo+ID4gLSAgICBp
ZiAoYWRkciA+PSBBU1BFRURfSU5UQ19OUl9SRUdTKSB7DQo+ID4gKyAgICBpZiAob2Zmc2V0ID49
IGFpYy0+cmVnX3NpemUpIHsNCj4gPiAgICAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1Rf
RVJST1IsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIiVzOiBPdXQtb2YtYm91bmRzIHdy
aXRlIGF0IG9mZnNldCAweCUiDQo+IEhXQUREUl9QUkl4ICJcbiIsDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgX19mdW5jX18sIG9mZnNldCk7IEBAIC0zMDIsMTAgKzMwMywxNiBAQA0KPiA+
IHN0YXRpYyB2b2lkIGFzcGVlZF9pbnRjX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3Ig
KiplcnJwKQ0KPiA+ICAgICAgIEFzcGVlZElOVENDbGFzcyAqYWljID0gQVNQRUVEX0lOVENfR0VU
X0NMQVNTKHMpOw0KPiA+ICAgICAgIGludCBpOw0KPiA+DQo+ID4gKyAgICBtZW1vcnlfcmVnaW9u
X2luaXQoJnMtPmlvbWVtX2NvbnRhaW5lciwgT0JKRUNUKHMpLA0KPiA+ICsgICAgICAgICAgICBU
WVBFX0FTUEVFRF9JTlRDICIuY29udGFpbmVyIiwgYWljLT5tZW1fc2l6ZSk7DQo+ID4gKw0KPiA+
ICsgICAgc3lzYnVzX2luaXRfbW1pbyhzYmQsICZzLT5pb21lbV9jb250YWluZXIpOw0KPiANCj4g
V2h5IGludHJvZHVjZSBhIGNvbnRhaW5lciA/IERvIHlvdSBwbGFuIHRvIGhhdmUgbXVsdGlwbGUg
c3ViLXJlZ2lvbnMgPw0KPiANCkkgY3JlYXRlZCBhIGNvbnRhaW5lciB0byBzYXZlIHRoZSBlbnRp
cmUgcmVnaXN0ZXIgYWRkcmVzcyBzcGFjZSBvZiBJTlRDIGFuZCBpdHMgc3ViLXJlZ2lvbiB0byBw
bGFjZSB0aGUNCmFjdHVhbCB1c2VkIHJlZ2lzdGVyIGFkZHJlc3Mgc3BhY2UuDQowMDAwMDAwMDEy
MTAwMDAwLTAwMDAwMDAwMTIxMDNmZmYgKHByaW8gMCwgaS9vKTogYXNwZWVkLmludGMuY29udGFp
bmVyDQogICAgICAwMDAwMDAwMDEyMTAwMDAwLTAwMDAwMDAwMTIxMDFmZmYgKHByaW8gMCwgaS9v
KTogYXNwZWVkLmludGMucmVncw0KMDAwMDAwMDAxNGMxODAwMC0wMDAwMDAwMDE0YzE4M2ZmIChw
cmlvIDAsIGkvbyk6IGFzcGVlZC5pbnRjLmNvbnRhaW5lcg0KICAgICAgMDAwMDAwMDAxNGMxODAw
MC0wMDAwMDAwMDE0YzE4M2Q3IChwcmlvIDAsIGkvbyk6IGFzcGVlZC5pbnRjLnJlZ3MNCg0KSWYg
SSBtaXN1bmRlcnN0b29kIHRoaXMgZGVzaWduLCBJIHdpbGwgY2hhbmdlIGl0IHRvIGhhdmUgdHdv
IG1lbW9yeSByZWdpb25zIGZvciBJTlRDIGFuZCBJTlRDSU8sIHJlc3BlY3RpdmVseS4NCklmIG5l
ZWQsIEkgd2lsbCBjaGFuZ2UgdG8gdGhlIGZvbGxvd2luZyBtZW1vcnkgcmVnaW9ucy4gIC0tPiBp
dCByZW1vdmVzIGNvbnRhaW5lcnMuDQogICAgICAwMDAwMDAwMDEyMTAwMDAwLTAwMDAwMDAwMTIx
MDFmZmYgKHByaW8gMCwgaS9vKTogYXNwZWVkLmludGMucmVncw0KICAgICAgMDAwMDAwMDAxNGMx
ODAwMC0wMDAwMDAwMDE0YzE4M2Q3IChwcmlvIDAsIGkvbyk6IGFzcGVlZC5pbnRjLnJlZ3MNCg0K
RG8geW91IGV4cGVjdCB0aGUgYWJvdmUgbWVtb3J5IHJlZ2lvbnMgZm9yIElOVEM/DQoNClRoYW5r
cyBmb3IgeW91ciByZXZpZXcgYW5kIHN1Z2dlc3Rpb24uDQpKYW1pbg0KPiANCj4gVGhhbmtzLA0K
PiANCj4gQy4NCj4gDQo+IA0KPiANCj4gPiArDQo+ID4gICAgICAgbWVtb3J5X3JlZ2lvbl9pbml0
X2lvKCZzLT5pb21lbSwgT0JKRUNUKHMpLCAmYXNwZWVkX2ludGNfb3BzLA0KPiBzLA0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgIFRZUEVfQVNQRUVEX0lOVEMgIi5yZWdzIiwNCj4gQVNQ
RUVEX0lOVENfTlJfUkVHUyA8PCAyKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICBU
WVBFX0FTUEVFRF9JTlRDICIucmVncyIsIGFpYy0+cmVnX3NpemUpOw0KPiA+ICsNCj4gPiArICAg
IG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbigmcy0+aW9tZW1fY29udGFpbmVyLCAweDAsDQo+
ICZzLT5pb21lbSk7DQo+ID4NCj4gPiAtICAgIHN5c2J1c19pbml0X21taW8oc2JkLCAmcy0+aW9t
ZW0pOw0KPiA+ICAgICAgIHFkZXZfaW5pdF9ncGlvX2luKGRldiwgYXNwZWVkX2ludGNfc2V0X2ly
cSwgYWljLT5udW1faW50cyk7DQo+ID4NCj4gPiAgICAgICBmb3IgKGkgPSAwOyBpIDwgYWljLT5u
dW1faW50czsgaSsrKSB7IEBAIC0zNDQsNiArMzUxLDggQEAgc3RhdGljDQo+ID4gdm9pZCBhc3Bl
ZWRfMjcwMF9pbnRjX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0K
PiA+ICAgICAgIGRjLT5kZXNjID0gIkFTUEVFRCAyNzAwIElOVEMgQ29udHJvbGxlciI7DQo+ID4g
ICAgICAgYWljLT5udW1fbGluZXMgPSAzMjsNCj4gPiAgICAgICBhaWMtPm51bV9pbnRzID0gOTsN
Cj4gPiArICAgIGFpYy0+bWVtX3NpemUgPSAweDQwMDA7DQo+ID4gKyAgICBhaWMtPnJlZ19zaXpl
ID0gMHgyMDAwOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgY29uc3QgVHlwZUluZm8gYXNw
ZWVkXzI3MDBfaW50Y19pbmZvID0geyBkaWZmIC0tZ2l0DQo+ID4gYS9pbmNsdWRlL2h3L2ludGMv
YXNwZWVkX2ludGMuaCBiL2luY2x1ZGUvaHcvaW50Yy9hc3BlZWRfaW50Yy5oIGluZGV4DQo+ID4g
MThjYjQzNDc2Yy4uZWNhZWIxNWFlYSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2h3L2ludGMv
YXNwZWVkX2ludGMuaA0KPiA+ICsrKyBiL2luY2x1ZGUvaHcvaW50Yy9hc3BlZWRfaW50Yy5oDQo+
ID4gQEAgLTI1LDYgKzI1LDggQEAgc3RydWN0IEFzcGVlZElOVENTdGF0ZSB7DQo+ID4NCj4gPiAg
ICAgICAvKjwgcHVibGljID4qLw0KPiA+ICAgICAgIE1lbW9yeVJlZ2lvbiBpb21lbTsNCj4gPiAr
ICAgIE1lbW9yeVJlZ2lvbiBpb21lbV9jb250YWluZXI7DQo+ID4gKw0KPiA+ICAgICAgIHVpbnQz
Ml90IHJlZ3NbQVNQRUVEX0lOVENfTlJfUkVHU107DQo+ID4gICAgICAgT3JJUlFTdGF0ZSBvcmdh
dGVzW0FTUEVFRF9JTlRDX05SX0lOVFNdOw0KPiA+ICAgICAgIHFlbXVfaXJxIG91dHB1dF9waW5z
W0FTUEVFRF9JTlRDX05SX0lOVFNdOyBAQCAtMzksNiArNDEsOCBAQA0KPiA+IHN0cnVjdCBBc3Bl
ZWRJTlRDQ2xhc3Mgew0KPiA+DQo+ID4gICAgICAgdWludDMyX3QgbnVtX2xpbmVzOw0KPiA+ICAg
ICAgIHVpbnQzMl90IG51bV9pbnRzOw0KPiA+ICsgICAgdWludDY0X3QgbWVtX3NpemU7DQo+ID4g
KyAgICB1aW50NjRfdCByZWdfc2l6ZTsNCj4gPiAgIH07DQo+ID4NCj4gPiAgICNlbmRpZiAvKiBB
U1BFRURfSU5UQ19IICovDQoNCg==

