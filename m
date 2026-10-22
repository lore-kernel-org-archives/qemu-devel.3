Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2818A606A32D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=O5b6DXEN;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=La/xgsI9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJie0-0003sa-GA; Wed, 21 Oct 2026 22:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJidy-0003sJ-E7; Wed, 21 Oct 2026 22:35:02 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJidw-0004AD-5p; Wed, 21 Oct 2026 22:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792636506; x=1824172506;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=6859I+rNSubGO51UQJnpzc1J0PokkOZ2hdEGZuBVOzM=;
 b=O5b6DXENt9I44jeSZiIx2PPuBiuCTBnhi/FWMZ9QVhNa9uvaiz2zcbFA
 F5hxC7S/0mv7YgAk6IQeCbaqKjACGHivUBZhZctZaOrEVV+8q7x35Sw3v
 uPa//4snjiihWhZPJwk6uyoTby2BjbQ9y8BGExv8QkvVHjXGnbYEdPhvz
 SM+5Fphf1qzW8qYxztfzOfNSli0drQCojrJ05CAQ7iersWdOdsvwarI6l
 JOxIrIo26dplQhDRCkn7Z3KdAL6I84MHjtoe0A20QrvPJS+kjkAKFDCDe
 qilxHRsxC666oKEMz0SRLifaKHBJJzPUzJbRQL9R/YOQ04sM5PFDMa795 A==;
X-CSE-ConnectionGUID: EsYLI6OlTcuufEUYRPYQkg==
X-CSE-MsgGUID: EGkv5SFDQe2MPoHQvLffUg==
X-IronPort-AV: E=Sophos;i="6.27,171,1786982400"; d="scan'208";a="159654636"
Received: from mail-westcentralusazon11010035.outbound.protection.outlook.com
 (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.35])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Oct 2026 10:35:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1bo60b+eaW+RufwZafsQzRnzAwIhslLdUX9V3R7C/5YHYrSvitxxpvtSx3q5W711Z97C8KgYTZSEVkWAmmDcviiEhTSVTs4C77IECB5+QmyAPwLrejwzqThGTTAKmBfduz2/SKiQrhx7zcYLSi7F4uLpxdjiEzCYGr/Mkr+2vNFI/jVM5OlE5ivm2PG26wu2sHoP8lPELWR2StDRZHp2PNV0kYKx/EVl0oKMvMF0XbUussTfmlWDiLCWCBvIEl4jWqb4oUwHRhkWaxOMeBpHEqyo5dwHY1k+BZeeAvJiVD7xMaduo2JkJQV9WXybVCiBJGTTfUz8qfnwafBR1LQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6859I+rNSubGO51UQJnpzc1J0PokkOZ2hdEGZuBVOzM=;
 b=sgcioKCg4nFiBDljgDG7qiotglR58RPfYm93R5ewscIEkcNZCEYqUBemaOts3ZYV8zPt02cDjO3WmPYQvEwev9+j1yq+3FEFXD1B7uI2eEMfxiOP2BpnmuuqAXXM0JWde1CxMxV+ZRj/YN7u5JWixGQZFWmOYbtJFpNZb9BSxDeUosEsKYRP5KipbH3UyRDu2qZ8oTJiFnV8wFm0kwxtamgqdOLmVwjQ23Ar1nAIxjQXxoQVLT4jpOQekJ3xm2eMBzRjTOm81wt+zWN98pt2lnm2zSQrKzd/f64eOp/cxPRQlLueGpIeugqCxxlosiR/1lb5n47NoR9h2J1FN4hHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6859I+rNSubGO51UQJnpzc1J0PokkOZ2hdEGZuBVOzM=;
 b=La/xgsI9cdGffN5oxHKrQkbM9M6yi12WnQRVZgh0QKqjT9yh52etnR0OO3JcCElhle6aKbcOoTxmNkeMpBvwtj1XCiMWpS0NaXqpHKLa1UCyj0ClMX2c8zzkoDk/127YS15iY/LwueEmAS4hJdZEccbSS/BGEOVjN1lho5u1Xkk=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by PH0PR04MB8263.namprd04.prod.outlook.com (2603:10b6:510:104::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 22 Oct
 2026 02:34:55 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 02:34:54 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv/cpu.c: duct tape fix for QMP + RV profiles
 introspection
Thread-Topic: [PATCH] target/riscv/cpu.c: duct tape fix for QMP + RV profiles
 introspection
Thread-Index: AQHdYYIZE7nDV5di902s7yZQvCW9QbcI2NAA
Date: Thu, 22 Oct 2026 02:34:54 +0000
Message-ID: <49d3bab1586115b4316653bcb16f099e880086e2.camel@wdc.com>
References: <20261021173138.2388231-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261021173138.2388231-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|PH0PR04MB8263:EE_
x-ms-office365-filtering-correlation-id: 61978b95-d3fd-478a-2a14-08df2fe50e68
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|366016|23010399003|10070799003|6133799003|18002099003|10067099003|22082099003|261009223027099003|56012099006|261021121427099003|11063799006|38070700021;
x-microsoft-antispam-message-info: dhPWQqJi4MfTOOa0K6j5CiU3a2hQySlJbfYqLdMh25djxpZLCYwmo0+V9zdQgPgAcJARVHilaRLmhR1dpA6oDZHzO3aIgItyv6G3EJXr8KfzGVfkwYljeUcvNYZ387t6wv8V6RuCNlflTlXjuGfvRQdGtUhuLazPM0wu2sBbYXbKa+9m2gmYW3ga+tW1fobrvETl8w/7tLhm2WZJJd3gryVO1vFAcVs1erVHiTiSsmgs9zVX833WEn9dlgl6/8nrf3jvZVFyF8GUP/euuvr2AFPdaC5KFiZTXMoBA2/GCyCILh316GU/jssJRI/kdMRtGn62XQJQUK+3V/caO69x45caItIYiSwNYrfX66aApdYzsNBy3jT6kkwQ1qvxO1bpkKY4JFYPOHRRzh4Fkd1UaonaBNJJMjq9wgcbZuYYFsLGZd4hqNeBmMtBCm0PHsV2wwCslllyVfBtOcBsNgPfTE9gQkntVYd2qijQ5VRbSQbV+SPvOJDczf5t48RBgF77IKuwsWM3JrlrqW/DsvB/nIjGv5zT4blokxBhMuabvOLOaQPEUuDuR1cBrieexTVg/aWlNbKWpRGpOshAIX16fEVpBrO14h2LElxy7wJ2R3YUs5y72Ms2CjO+hN+GbFgGvJlSenSEKnge70SB2Ae4FmHgnISod96F/ci4bsF9HKM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(23010399003)(10070799003)(6133799003)(18002099003)(10067099003)(22082099003)(261009223027099003)(56012099006)(261021121427099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OStvbmVXaEdpQ1BUY1VXUTdqeHZMOVdpOXZ6MmVLOVdHTkw2TTZQeC9LM2FT?=
 =?utf-8?B?ZEJmMm02VGlNa2tqVEtGMUdKZC96eUR0ZFpKSjZLWUt6bWdDQWtqYVJGMDds?=
 =?utf-8?B?M3ZHN0V6U1F1ZkR5dFJsT1o4dXRmTUdGbUs1WThnRHZuT2FOYjk4YWtIcFJr?=
 =?utf-8?B?Z29GQlhteXk5Z2E2THBHT0lLa0tQOVQwTGc0bmgvVDVDNzVSZC9MZjRnV2s3?=
 =?utf-8?B?YVg5b0RsQk1EUWs5bDZaTENMMXppU1o5VVpyMFRtRHVmQjlWT2syQnN5dHox?=
 =?utf-8?B?cXNtcXQwWlZNSXNZZmM5Q3RhUkF4akh6cmxwVlB0aTQrT1Z3ZDRDUDdiWjhn?=
 =?utf-8?B?aWhBTXZsQ3hsUUlaN2VtU2JGR2dhYlV1RzNBSnVFaDI4Zi9BcTFzQW55Q0Js?=
 =?utf-8?B?eEVJT1JvUVpiZTdsZTZmYkpMb2tLUDFPYXVSekFJdGVmcHVqWEN6SmZvS0hR?=
 =?utf-8?B?MEYvcEcyTEhUT2NoVm5hVkFyYUZTdktuUUJnUzFvVGRRc2RjSWhkWXlyQk1x?=
 =?utf-8?B?UVp2WThqRWtqNEVkWWdsUS9Fd0gzVjNKYjViSnM0SEdjZk1tcGJ6clJvSFZh?=
 =?utf-8?B?RXQ0enFJd0lVWE96T21yNmdmcGE3dHJuT28xT21hUkc5S1RYWkdkVFp5SmxC?=
 =?utf-8?B?c3lyWDdYSDJuK2RjcEVlSFVjdStUdFRMdUNsZXZJSDBOOStNRTZZMXlrTkxu?=
 =?utf-8?B?azg2cHhBNTJJcUNqTS9NVzJpTDlYOHcrTFIzNkc2Ukh0eHpMR1V0TUk2YWRq?=
 =?utf-8?B?QU9IMUg4NStZd0FpZmRMVkppaURtelN3aldCNklYMUtMcDJ6T3dTK0pxYVdw?=
 =?utf-8?B?ZmU5VmlheE1oREhMSjd6bkFUbVBQTVdCdzgwb3JyQnMxRUZJeHc5RmJDUmhI?=
 =?utf-8?B?eDBDdGJSM2NXcGhvMzVIaDhxa2k4UmNLeEE4ckdGa3Z2ZE5yQktNZUNmZkFF?=
 =?utf-8?B?Ri92U0ZvclpzejdhL2tBZWF3TUtkc0xNUmNWNEE4T0lLUFlFc21jSEF1K0F2?=
 =?utf-8?B?Vzg1aEdFOXJDc05JR0xZb2FhTVUyaHcvWUdWZ3hnb0UySlZ6Z1d2SWg1NkRx?=
 =?utf-8?B?dWF4bzcxQU9wQklqcFRTNjdaMnRnbE1Jd0hiQXNPS2xKaDhpeE1oL2RnSGti?=
 =?utf-8?B?TlNXaHRHWHJyeThLVStVMTBKZGhmaWpaYTZwai82ek1Nb2dwSGpYMkZQSTBz?=
 =?utf-8?B?RlI2MjVsOE9mT05sd3RNcTNYV2tqMFd6dm83VWZpSzZSd0xMdXFPQ0pkZnBq?=
 =?utf-8?B?aHFkQzF2b0lPZGtYc1YveXlQVll1QWI2SDVoKzZXTVVFOGpCQ1N0WnVyR1ZU?=
 =?utf-8?B?NGo2SFd6NnRSV2c4eVZMU2QvSXlVRjlVUXJNUW9WVlBtTTM5dTU1RFFUcVZp?=
 =?utf-8?B?Lzg1WWk4TDdvWHR6N2FENU03cnhXaWgrNzBjRGhIQ0YvZW1FUnVKaWRLY3hY?=
 =?utf-8?B?bjkvV1I2TFpKNTZxeSt6a1Y1UXhPeXp5eDVFb3UyaGk1bEtwU3RoUFpQM2tv?=
 =?utf-8?B?ak5wYnZ5eGdHZFNzR3plN1phOURmOFBUOGdKZURlYkRUNWJERW1YSmdZVHhU?=
 =?utf-8?B?ZS9JL0tCUUkxQW0zTFIrdGRpQUhYRWlhSWIwekFGdXJXck9xS2RTRlZhd3Vj?=
 =?utf-8?B?TmdqWEI5QUpqb0NDeG1qK2ZOWFAxaXpLNGhKeVdQUFRhWnNOa0lJNnRmTWNn?=
 =?utf-8?B?STlpVzVlbTIxZXhsK3hZS1A1bkJHUXJna3VyY2VtRGFsWU9PRG9uc2dPeUg1?=
 =?utf-8?B?MGVEYVF4TGZjWW81bG1sUUtqMVhWV09RQnNNdjNLb0dnQTNLcU1UQ3l5QzUx?=
 =?utf-8?B?aXoxeHFUeDgyeW5GalJWWWI2NUgwa3U1cnE3K3gwUzN2NkFOeUZZaXlSRGdT?=
 =?utf-8?B?ZllMdnZwWmY5ZGgvTis5RVBaTVJwZFZ2dHVNbWZ0MmVZVEZDNVYxR0dZQUd6?=
 =?utf-8?B?Vk9pRWtrdjVGQ0prMCtFdTdJUW5lbFhPUC9nQjcwbmFhaVpXd1B4QlJEVStz?=
 =?utf-8?B?dlVpZlZMbnNMMXk1eUtnQlZCalhVR250dnBLRmkzUFFvRE9STVd3S0R6eTRB?=
 =?utf-8?B?VzY4NWIwYktBWGkyZlBCMzFPUGhnR2ZqSnBad3ZFUUZ3VVcwcE9LRHZNeDFm?=
 =?utf-8?B?U3NjTFhsaHhyOTZNWWs1VFZGY2Q1aGloVGNYMXg4T1FhemZlTWlOTnZyVngr?=
 =?utf-8?B?cUZXUk13K3liWW03MThkNFYyQURBKzQxSlFQaWZCQ3Z3dStHWWdBdDhlclBB?=
 =?utf-8?B?Z1VNZW85bWRWS1JWZ2xrN29lMVA4TDNXWFR3WkE2YS9IL2RNSlF3QkNPYXRK?=
 =?utf-8?B?eTJHVDNWWTA4OGNTYmFTazVXUWRSMStNd0twUDRLZzhTUFBiRHFTU3hJNzVk?=
 =?utf-8?Q?oZGmrUSJkSp+QYmnDrvNec3AuAJBG4sDahs5HytR9PbVE?=
x-ms-exchange-antispam-messagedata-1: 1CPwkdCcaTy3Ql/ezDCkV3i2CJbpttNCX2E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B64CD18C85B4BF469E4EA98C1CC45ADB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hkvMyAYFDqs5iTq/IELxzIUuxHbqUImojrPgC/R21hnx3OmiXcK1aQMn7VoJm2x0gPT9ED25k4XF+LRCXQ1CeswREibRcDH+vip4OW4CBUl4w34Gqa52GPJq6vHmRRZ89aEojwbv88p3m9g6xrFwJpW8l4zMVpBH8coMMzDbA0XeSJb+TJUw5KTUy15ln0LQMfJK5BgfBSfn6JKZkobv3D8dRBRHyPOs7Bz//n4D341vqSKHp/IEWicTRvHrqit2wSWsrkYero4Umg3D09FuGv0+HTTQ0eX+OvNZoqFiG9ar3POrCFYcfp+PL3WHQSSxeADvg7aBeUWQpk/h4qTFeQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pHDo2ZN41Uc7hIAZmhcdlk3IcxVueWQyREeUW7YCG6UrOhNSG9r05niyd9qr3YHC8i5hoE3uiilAI3a2wV/IqGpKbmRYGpXqhJmzyrFGQgE/TSQQ00fxJIoCjMbvJ8M1QJ69yGCVA1AV6pBgKmFU+XYyZo3YoovE0yqYihrkJtpJTWXJMOynsy+Q/A7aRrSI1PGHN1o91VX5QgEKoChnd/sNQWuD8EazrzcJvtu104sxIZJqAYlerLm5QfN3fi315mn49ZXKwNPU/KnszJjvk8H7kj6QTxIhyFaajjd7ab/bzMpjkP+4nfocKJO42Iu9z+Xm+5J9/+6KXM6euaAkEbqtJAcpAVE2VrcfQ4yO1E3j1ktHl1V89L99zZI8jP78kjgR7bGiaT9yNZoGu1wVeCBx4vtthjM8d0e76fb+YT4t3FolSQOKE0nDsMGo4eJEiTR6uPGk+DBDTN57tUati8qGEQr/vi6DuZz4amMrePbnE+vxKXxja1OEcUd/5wQ1RkXAVq2XadQZuAYHFBC45XbCNeKN4H4WlGcvsiccGLLSjxQGL/WNI3MI6fAKCmPYIT6wXJbBjyqpeLHAGsMTexn0aJVYdFXekCpMvlIkUebMOwN2eAV0jYr1BZm+jWPT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61978b95-d3fd-478a-2a14-08df2fe50e68
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 02:34:54.5133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 76sV/3CU45QYRmmqVjbLI0SkQL+rdKMY2kL+j8O3QKJ3554OlV8YGD1rQd/Pvv9+kxwclnUtSIojHwE4Q7ww9lajfrLUqam7lXQrj7ftrGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8263
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=748e7da1e=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTEwLTIxIGF0IDE0OjMxIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gTWFydWtzIHJlcG9ydGVkIGluIFsxXSBhIHByb2JsZW0gd2l0aCBRTVAgaW50
cm9zcGVjdGlvbiB3aXRoDQo+IHFlbXUtc3lzdGVtLXJpc2N2NjQgdGhhdCBoYXBwZW5zIGFmdGVy
IHF1ZXJ5aW5nIGEgcHJvZmlsZSBDUFUuwqAgUUVNVQ0KPiBjcmFzaGVzIGhpdHRpbmcgYW4gYWJv
cnQgZHVyaW5nIHNhdHBfbW9kZSBsb2dpYyB0aGF0LCBzb21laG93LCBpcw0KPiBiZWluZw0KPiB0
cmlnZ2VyZWQgdmlhIHByb2ZpbGUgY29kZS4NCj4gDQo+IEZvciBldmVyeSBwcm9maWxlIENQVSB0
aGF0IGdvZXMgdGhyb3VnaCBpbml0IHdlJ3JlIHNldHRpbmcgYW4NCj4gJ2VuYWJsZWQnDQo+IGZs
YWcgaW4gdGhlIHN0YXRpYyBSSVNDVlByb2ZpbGUgb2JqZWN0LsKgIFRoaXMgc291bmRlZCBsaWtl
IGFuIG9rYXkNCj4gaWRlYQ0KPiBiYWNrIHdoZW4gcHJvZmlsZXMgd2VyZSBpbnRyb2R1Y2VkLCBi
dXQgbm93IHdlJ3ZlIHJlYWxpemVkIHRoYXQgUU1QDQo+IHdpbGwNCj4gcXVlcnlpbmcgQ1BVcyB3
aXRob3V0IGV4aXRpbmcgdGhlIFFFTVUgcHJvY2VzcyB3aGlsZSBhbHNvIGdvaW5nDQo+IG11bHRp
cGxlDQo+IHRpbWVzIHRocm91Z2ggY3B1X2luaXQoKSBhbmQgZnJpZW5kcy7CoCBUaGUgcmVzdWx0
IGlzIHRoYXQgd2UncmUgaW4gYQ0KPiBzaXR1YXRpb24gd2hlcmUgd2UgaGF2ZSBydW50aW1lIGlu
Zm9ybWF0aW9uIGJlaW5nIHN0b3JlZCBpbiBzdGF0aWMNCj4gYXJyYXlzDQo+IHRoYXQgcGVyc2lz
dHMgYmV0d2VlbiBDUFUgZGVmaW5pdGlvbnMgYmVpbmcgaW50cm9zcGVjdGVkLg0KPiANCj4gQSBw
cm9wZXIgZml4IGlzIHRvIGdldCByaWQgb2YgcHJvZmlsZS0+ZW5hYmxlZCBhbmQgdHVybiBwcm9m
aWxlcyBpbnRvDQo+IGNwdS0+Y2ZnIGZsYWdzIGxpa2Ugd2UgZG8gd2l0aCBldmVyeSBvdGhlciBl
eHRlbnNpb24uwqAgVW5mb3J0dW5hdGVseQ0KPiB3ZSd2ZSBiZWVuIHVzaW5nIHByb2ZpbGUtPmVu
YWJsZWQgZm9yIGxvdHMgb2YgdGhpbmdzIGFuZCBhIHJlZGVzaWduDQo+IHdvdWxkIGJlIGluIG9y
ZGVyLCBvbmUgd2hpY2ggSSdtIG5vdCBjb21mb3J0YWJsZSBkb2luZyByaWdodCBub3cgLQ0KPiB3
ZSdyZQ0KPiB0b28gY2xvc2UgdG8gdGhlIFFFTVUgMTEuMiBjb2RlIGZyZWV6ZSBmb3Igc3VjaCBh
IGNoYW5nZS4NCj4gDQo+IEZvciBub3cgbGV0J3Mgc2lsdmVyIHRhcGUgYSBmaXggaW4gY3B1X2lu
aXQoKSB0byByZXNldCBwcm9maWxlLQ0KPiA+ZW5hYmxlZA0KPiBmb3IgYWxsIGF2YWlsYWJsZSBw
cm9maWxlcy7CoCBXZSdsbCBkbyBhIHByb3BlciByZWRlc2lnbiBpbiB0aGUgbmV4dA0KPiByZWxl
YXNlIGN5Y2xlLg0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwv
ODdsZDdybWRpNi5mc2ZAcG9uZC5zdWIub3JnLw0KPiANCj4gUmVwb3J0ZWQtYnk6IE1hcmt1cyBB
cm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEhl
bnJpcXVlIEJhcmJvemENCj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+DQoNClRo
YW5rcyENCg0KQXBwbGllZCB0byByaXNjdi10by1hcHBseS5uZXh0DQoNCkFsaXN0YWlyDQoNCj4g
LS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L2NwdS5jIHwgMTkgKysrKysrKysrKysrKysrKysrKw0KPiDC
oDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFy
Z2V0L3Jpc2N2L2NwdS5jIGIvdGFyZ2V0L3Jpc2N2L2NwdS5jDQo+IGluZGV4IDA4YTRkMTRlYTEu
LjQ2Yjc0MzAyZGIgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi9jcHUuYw0KPiArKysgYi90
YXJnZXQvcmlzY3YvY3B1LmMNCj4gQEAgLTE1NTAsNiArMTU1MCwyNSBAQCBzdGF0aWMgdm9pZCBy
aXNjdl9jcHVfaW5pdChPYmplY3QgKm9iaikNCj4gwqDCoMKgwqAgY3B1LT5lbnYudmV4dF92ZXIg
PSBWRVhUX1ZFUlNJT05fMV8wMF8wOw0KPiDCoMKgwqDCoCBjcHUtPmNmZy5tYXhfc2F0cF9tb2Rl
ID0gLTE7DQo+IMKgDQo+ICvCoMKgwqAgLyoNCj4gK8KgwqDCoMKgICogVGhlIHdheSB3ZSdyZSBo
YW5kbGluZyBwcm9maWxlcyBkb2VzIG5vdCBjb3BlIHdlbGwgd2l0aCBRTVANCj4gK8KgwqDCoMKg
ICogaW5zdHJvcGVjdGlvbi7CoCBXZSBoYXZlIGEgc3RhdGljIGFycmF5IHRoYXQgc3RvcmVzDQo+
IFJJU0NWQ1BVUHJvZmlsZXMNCj4gK8KgwqDCoMKgICogb2JqcyB0aGF0IGhvbGQgcnVudGltZSBz
dGF0ZSBmb3IgdGhlIGxpZmV0aW1lIG9mIHRoZSBRRU1VDQo+IHByb2Nlc3MuDQo+ICvCoMKgwqDC
oCAqIFRodXMgc2V0dGluZyBwcm9maWxlLT5lbmFibGVkIG9uY2UsIGUuZy4gd2hlbiBpbnN0cm9w
ZWN0aW5nIGENCj4gK8KgwqDCoMKgICogcHJvZmlsZSBDUFUsIHdpbGwgbGVhdmUgdGhlIGZsYWcg
c2V0IGZvciBzdWJzZXF1ZW50DQo+IGludHJvcGVjdGlvbnMuDQo+ICvCoMKgwqDCoCAqDQo+ICvC
oMKgwqDCoCAqIEZvciBub3csIGNsZWFyIGFsbCAnZW5hYmxlZCcgZmxhZ3MgdG8gYXZvaWQgbWlz
bGVhZGluZyBRTVANCj4gdy5yLnQNCj4gK8KgwqDCoMKgICogcHJvZmlsZXMgYmVpbmcgc2V0Lg0K
PiArwqDCoMKgwqAgKg0KPiArwqDCoMKgwqAgKiBGSVhNRTogYSBiZXR0ZXIgbG9uZyB0ZXJtIHNv
bHV0aW9uIGlzIHRvIHJlbW92ZSBwcm9maWxlLQ0KPiA+ZW5hYmxlZA0KPiArwqDCoMKgwqAgKiBh
bmQganVzdCB1c2UgcmVndWxhciBjcHUtPmNmZyBmbGFncywgYXZvaWRpbmcgc3RhdGljDQo+IHZh
cmlhYmxlcw0KPiArwqDCoMKgwqAgKiBzdG9yaW5nIGR5bmFtaWMgc3RhdGUuwqAgVGhpcyB3aWxs
IGhlbHAgdXMgbm90IG9ubHkgd2l0aCBRTVANCj4gYnV0DQo+ICvCoMKgwqDCoCAqIGFsc28gc2lu
Z2xlLWJpbmFyeSBzdXBwb3J0Lg0KPiArwqDCoMKgwqAgKi8NCj4gK8KgwqDCoCBmb3IgKGludCBp
ID0gMDsgcmlzY3ZfcHJvZmlsZXNbaV0gIT0gTlVMTDsgaSsrKSB7DQo+ICvCoMKgwqDCoMKgwqDC
oCByaXNjdl9wcm9maWxlc1tpXS0+ZW5hYmxlZCA9IGZhbHNlOw0KPiArwqDCoMKgIH0NCj4gKw0K
PiDCoMKgwqDCoCBpZiAobWNjLT5kZWYtPnByb2ZpbGUpIHsNCj4gwqDCoMKgwqDCoMKgwqDCoCBt
Y2MtPmRlZi0+cHJvZmlsZS0+ZW5hYmxlZCA9IHRydWU7DQo+IMKgwqDCoMKgIH0NCg==

