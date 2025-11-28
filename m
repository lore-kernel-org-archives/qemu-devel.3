Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FC6CFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 03:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOpSs-0001WX-Re; Thu, 27 Nov 2025 22:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hdijk@accesssoftek.com>)
 id 1vOp1G-0008OW-7P; Thu, 27 Nov 2025 22:19:38 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hdijk@accesssoftek.com>)
 id 1vOp1E-0000HC-K7; Thu, 27 Nov 2025 22:19:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6/6D1g+TnLesHyWY7uw4043ebi2KsJ0HGY5hmUclL6CbRCHdLtWqaPs3yJTcI+XgnvpB6d6wZnPoucRvxFJp10wQnpvbWbUTkPxOgOpdeFws6rez9g9bXZPJ5copZoLTwu2ePw3+jWQZDlLi/gU6RsnCH+ZhhbhEFMDLp5zxhls7Bk9efqEf2x4h5yOLsHzwKIQtG93fHbTd4SKYDN2ej5Yg9d6doC+7kl0dWGtyYo1AyvYTcE0fGKb/bQ+xHFFSji+0QOZH3U3dv0qBsH0a9TfujpPmLsfgYHe3hn/co2aZUjeXEnHQpXmbAbpymF7G3ykW7CyYUL/K9aPd1GuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYmZhaY30cIeDp7as3nEWH+6zMXQ062IlbnyM6z+ZFc=;
 b=H6sEQyN6qkUqsr+87ZOtdfi4Anl12YYu9Od3KZcpkSDFsKRRRiC7CmQrwEHuhIYmw2hUqD3LnFkkUix1cWgCO/IUgCCYaeYP97a40WQA8mHh+tnukibq3pCMOzc4WXPeVOFO++shPI4ZH+IfwqecwH6ZISdG8ajwaxuUqag7thHgsX0uO+tJ/u6uOfRhC1WH50Dq08ttXZLDg8HUo3zHH6nNxl2lfkLpCUmr1B5Pskw7udg30xC5cTizJVEUf40rvv4srHsR76s9cExRfcNaaQwxKxkhMRBpA+o/JxGUEWf79jBc9FBm/54upGat9oJ63CnZ0eu9mjBFvpbYg71BSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=accesssoftek.com; dmarc=pass action=none
 header.from=accesssoftek.com; dkim=pass header.d=accesssoftek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=accesssoftek.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYmZhaY30cIeDp7as3nEWH+6zMXQ062IlbnyM6z+ZFc=;
 b=R7LNqL9FpXia9Ux8WG7CA93kp9x+AazViUt5ut5Pb0ZJgHWk55E9ME3FwKInqj4PTzkY4NphgQ3zauR0DJkzat6JnmgppDYnYhMdo5ZC/jBMDh0UgvgZ3TJ+EoJzKqfUrAN03z4VXZ10HOK3B+OXqj1EeH63dW5MhrwzfDD0BQYF5CihxfdDfNhxtxOybkpqARsjnVrog1jkESBeJ5/WAJjVEg+YFLz+F4VjUAAhglVwamR/cbbLzHf1JME16K6x0zmyLCGjZkKYsZlJQUvS12kNiqZHOhz/IaFY0yq0OkawbMuJmEfeZ1FbUnpku9+fv4ULrwW7O1FoBGsi6ENe7Q==
Received: from PH0PR20MB6156.namprd20.prod.outlook.com (2603:10b6:510:2a1::7)
 by MW4PR20MB4545.namprd20.prod.outlook.com (2603:10b6:303:132::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 03:19:31 +0000
Received: from PH0PR20MB6156.namprd20.prod.outlook.com
 ([fe80::ae6e:9fbd:b45f:edac]) by PH0PR20MB6156.namprd20.prod.outlook.com
 ([fe80::ae6e:9fbd:b45f:edac%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 03:19:31 +0000
From: Harald van Dijk <hdijk@accesssoftek.com>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH] target/arm: Fix assert on BRA.
Thread-Topic: [PATCH] target/arm: Fix assert on BRA.
Thread-Index: AQHcYBXPmcExBwzAIUS/4iD/3O4YOQ==
Date: Fri, 28 Nov 2025 03:19:31 +0000
Message-ID: <b42ee4ad-2378-48bb-a18c-0b0a5f16b132@accesssoftek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=accesssoftek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR20MB6156:EE_|MW4PR20MB4545:EE_
x-ms-office365-filtering-correlation-id: 60b8b9a3-3a77-4069-31e3-08de2e2cf23d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?YmtPZGJBbVZYZHJTdkhGcTE1TURsSkE2UFA3Uk1jVGY3SnRMRzFueFRjYWJH?=
 =?utf-8?B?MmNkQ3huOGNkZ1RBWVpiNmlzZGo1cDlTUGpkVFFleXo2dTd4S1JPWFdjalpX?=
 =?utf-8?B?clVxUjFlRld2V2FVNnhuNTNYSVhhTG1lZnhWSVVSRzZ3eWc1SGczNGh1T3pK?=
 =?utf-8?B?dWlYRVdpaC81YjVXYllVbkZsK09RQzlCcTV6ZnBuYTF0UFk0am1LWWJsV3dz?=
 =?utf-8?B?c2g5eDFub1J2cU9Kdlg3elRnb1FGekZWM2M0L1BNYXdWcUlyVmFobHNMdExo?=
 =?utf-8?B?MFovRVdjdHZ4aGx6ZFlURGl3bmN0RzlnNmI3Y1RZSnNLNmQ1MXFSNzRFdHJ4?=
 =?utf-8?B?c2RESlVDWldaTFoyVmoydkc4dmk3WXBSUHNhR3FHSy9iSjhmdEU2dXhwaGZo?=
 =?utf-8?B?VnpjaStMV2lnZEp5MFFZZ0xRMzdTcTU5d2NXZml6VnlnWXNSTlkvRnVuQm9H?=
 =?utf-8?B?a0l3emZidDAwTUdtSE1UMURZNVAyZ2xsbVEwMU54c0ZVdklqTWVvdU9BbEpO?=
 =?utf-8?B?Qm1ZU0pDTk81MEJieHloZlRWSjNpZHlST3pzTFFEZXRoaHgxVG96cjFDdkVr?=
 =?utf-8?B?S1pYNUtDUWdqR3FFSnJNZy92YW9abXArYytKVXViUVFTb0JUb2RPNW5MK1Zj?=
 =?utf-8?B?dFZUY1AyWnBGUTJyUkFqT2x2MFZyVUxCNEpLUnFoRHlzTUltOVFMeHNWbk1N?=
 =?utf-8?B?VHBnZHhTQ2Vkb3VmenZPZURKNXlkNHRMVkJ6WVRDZzNjWnpCdzY4bXQ2Uldw?=
 =?utf-8?B?dlBjOFRVV0IzNzhPMGJoRENCcmozREE1Y2M3VHhLdHp0L0tjMmFXbHptZlNW?=
 =?utf-8?B?K01SMk9WWldFVXhrWXgzcW5URStYUTd0SWlGWGhJTjJBNzRRZW04ZmdHNW12?=
 =?utf-8?B?ajQzV2ZTZzdnbmJLeng4NzZsL0RLS0FJQ2w5MzFJU3NwYUR0eE5tV1lWQXFP?=
 =?utf-8?B?cFhrWTFWMzlUZDBVcFA5Z2pxUTVVYWRvL29TS2poZks3Y0Y4eDNrazJuZTFC?=
 =?utf-8?B?RzRhT3gweE0yOGR1dllaMittbFNPR0s5WVV3bnJpOVZjeWdyYkRBWkQrb3Yv?=
 =?utf-8?B?QjV1cURFN05GSTl4WldKaUtleE5rWnNwUEdoSVZETEZHVzBZaTk0T0F5N1ZV?=
 =?utf-8?B?UGZOVzk1NGwvYVVvdExTVEdEZW1PMVRJcVAySmFOQ2pZK2g5TTV5dEkyQzBw?=
 =?utf-8?B?N3JjRkplN09CaldnaHZ5bzRjUWdXSGthZEpBbTQ3NGxteEh2dENOc2dJeGQ0?=
 =?utf-8?B?R08zejNWSnVBd1E5U2sxQ01wSHB5NCsyZzhMNVN0Nk5wTndjR1cvT2Zzam9q?=
 =?utf-8?B?cHZKZnVTSGdRTndkbU1LWkFISHYwZitSbERKekhoZXB1bS9NaWlGam5Dd0Zk?=
 =?utf-8?B?WHhiZUdPOW9kbmlPL3lEVllnWGhZZmRiN093UWVOMEtWNFFJOUp4aHg2UmVP?=
 =?utf-8?B?OGdQbGNZOXNvQXEwTXdvSEFHeFcwd1F0ZXE2RHhsOWdwTmhxRzgyRHJxOC9j?=
 =?utf-8?B?aVRQRE1wY0lGcTVhUkF3aHJBTTN4cERkOXJPcU1hMjA0eTJDN21YMGxtalRx?=
 =?utf-8?B?WVZVZVlmOEJzSGFiV2o5TGRncC8xTUJWdmNNT2xTeWJvR0FhUERwa0xKV09p?=
 =?utf-8?B?L1VTNXFLS1dCRDkySFk2eVU5QjJNNTV6dHRmY0o4K0dmbnJyVEFWVFNDV1Iy?=
 =?utf-8?B?R2hqWGtuQ3A2cFFPOE04ZHVPRHBkTzdNMmR5VG1GT25Fc1JQcmJsY0FEVEhN?=
 =?utf-8?B?Q3laUnBLaFF5cGsyNkpZRGdSVmdvOTM1ZkxWU282cVgxQTZjSjN4S3h5dVhW?=
 =?utf-8?B?OWlTeGRqY2F4MXRMQXdJdUtNdDBPeDhSbXpJcThlK3FiREF4T0wzOWNZZy8r?=
 =?utf-8?B?R2FwTlhlM25pM0lFNlJZRnlEejJUTEdySHp6cm4vbkIyQ01Yb1I3QnVqWDZx?=
 =?utf-8?B?R0xpZWdmcnRaeld5V29pTldhUzFjejJ3OE1Sd056SEl3RUs1VjlmVkdZNW96?=
 =?utf-8?B?R3p4eFRzVDVRQ09kaU9xTlRBQXFCSlJXTCtPUlFCdDYyOGxIZEVsWUJXci9L?=
 =?utf-8?Q?PzbLfn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR20MB6156.namprd20.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTY1TnNWNlJycnV4NTdvQkVUUzF2czRVbnovZFhaa1JrT1NReDJCenc4Vkc0?=
 =?utf-8?B?MUhacWFFZTF0Qmo2Nml1a250Qlk4dkFuK21oNlRMS2dmcm9pRFdOd0g0T1Ri?=
 =?utf-8?B?OWlEL0Vxa1BoNlN3d2NXLzVQZHZUMWVLcEZWUmxkTjU1VlVKcWdKVzZHSmdJ?=
 =?utf-8?B?Y2U4Sm5IRVZpai8rNzlrUWVRMlZmYXJrVmI3cWxVcytoS1I2eWtvWnQ0NjRr?=
 =?utf-8?B?VHdEbVJXeFZVaUJuVU1MUkMzeVVKWjY1YVI1b21TODRMWTBvM1hXbFBIUlFF?=
 =?utf-8?B?VHp6b01nR0RwVmZlQUZ6enNteWlFSTdPT0tKTk5qUGh5WHIra1NmdUpKUDZI?=
 =?utf-8?B?Nm5QQzBSYS9udC9NMGVHNHNZYnZ2RzZjZGRQTkN4RWpJdlNHdGJUODZacTlN?=
 =?utf-8?B?NWQ3SHEvZjlVYTY3ZTE0RnZlQy8rVkcwT09RNXdaaDVoYmNRbUdRSTBwaHc4?=
 =?utf-8?B?T1JYTmE4MzdRUlBOYUkvNnBINCtwc1dyaHhFZ0F2VmpQRVZ5TUNJMWVRYzh0?=
 =?utf-8?B?QjlaUlFNdG9ydUxxMldqb056TkVIRHpOQ1o5SVdzdXpiOEx6dFhPNnNNMW15?=
 =?utf-8?B?M3hwd3h5WEYySkMyeW1Cb1c5TzhmUnVYTlRCT1RuNnVYTnVsN1ZUbVhLQWV4?=
 =?utf-8?B?bWRQNjdsTGU4OWxlTGVZY0R1UWlFVEhkRk9ubVFqVmpSYnBXNHlqZk8xT3FO?=
 =?utf-8?B?NGxEN3R3Y2F6cTZUZnVlZlJCRnNyWFZrcDVSZitXVFpJaTR0RmpESWx5WUZD?=
 =?utf-8?B?ZURUSWQrRjhBcVZ4MUplL2dOcHNrdk84SWhmb2JDd1lwbG5xUTVVZGtGTFVu?=
 =?utf-8?B?N3JqTFFrOVJ0NTVyUUdES2NXUFdrUERCazBacEE5WmZDM3dycUpwcjVDMUNU?=
 =?utf-8?B?QnhKc2F3VC96V05iMnQ3cTVOcE1IMkJJZXlYWGV1aWFpbkpVZEhNMmZpWnFm?=
 =?utf-8?B?Uzh2ZEZ0T0FGOUNkUGgxamJPY3dOM245NmtuK0QvbTU0TWlaWjlzb3hhUjRX?=
 =?utf-8?B?S3kxWXpCbFlFSUI0eXNZTDlDSys3L0NnVVpFVTJwRHV1V3VpejVQc1FrZk5G?=
 =?utf-8?B?S0ZvRVB0UC9JSVBxV3JFVFphNzI0NkhpaGNIWE9DcEE5Z0R6SklyN2pIOVlz?=
 =?utf-8?B?czVERDFZb3JYR1IwVktFZmpEWE9LR3diVHNHZi9EeW82Z05BNDRVZ2IwVHlO?=
 =?utf-8?B?L04rN1B1ZGtqempUVE5qc1J0S1NGbEhkL0FVeWR0U0ZqaHF5RWZqSHpGdUNy?=
 =?utf-8?B?UXdld1F0Q1RUcThZVS9TZVJGdjFsWmZSZEcycmJvdmo0d3IzcFcwcUFObzZ5?=
 =?utf-8?B?dmlvQ3JMQWxoYzdGaTdHUWdQN1hhbncyUkhvMVdHQ2NQc3RVRE1KVzZZT0Fq?=
 =?utf-8?B?Uy83cVMyb0lGQWMwT2RCdGRwL3VJMi8vR28wUm1sTFMrNm9iRk9vL1pocnlD?=
 =?utf-8?B?ZWw4WjU0SjBRRVo4eXZxMlE4NjlmSG1DMms4aVFpU1FkQ0tsRWFXaHNMSFln?=
 =?utf-8?B?NUx6Nld3ZGdEYXRBeE03dm52WWxFaXB2VXlsT1RIV2VKRjVIMVI1YmxWQS9s?=
 =?utf-8?B?Qk1GQ0N0N1R1SlQ2cUN1Wk43YW82VDBoZ0NzMytSWGRINjRTN2VxQzhkUWpk?=
 =?utf-8?B?MDlxRnJZbFB5WklIcnNiRXAxTy9IQ2tYdnJTaXJOYWdPQnoxOE5UWVVUNkt0?=
 =?utf-8?B?c0MzQWhwZlBhb3FnTmNwSzdwSElaYWNCeDNickZkWHAxTm0zc0l6ajFnQndF?=
 =?utf-8?B?eHNGeEg2anI0TXZRMnV0bFZUWGxDcGpjcnNzMCtDdk5XYjNvbENsZHgybDNl?=
 =?utf-8?B?UjIvc1Q2eU54c1BWZGxWaW1ic0pXVE1oWDFGQmJOWnV1QUtJbmRlOXZzQ0hZ?=
 =?utf-8?B?aGdNL2hrN0ZWTm53dUg5ZjVzK2hDODZYSkZtaHlObWZzMlprMXFEU1pvUUdm?=
 =?utf-8?B?UnlUMEh4TFluNlNkUlM1bDRKcmh1elROOEhpWUZWUjRnZnpGcVMwdWVkYzZo?=
 =?utf-8?B?MjBLZmE2YVZQTVRpS3RJdEhQdE8rVFRRYjNtenhqOEQ1enArcXU5RUV4SHJ3?=
 =?utf-8?B?UThnQ29lbDBHR3gyaXlSU0FaUEZPcjM3NnRmUWNTNkRxZmk5Z1pybWFaMERO?=
 =?utf-8?B?amNDaW4vcFdwYXVJMW9QUWxVL09lZTF5bFhEZ0hiTjZKZStsU0hHaHVJNDg1?=
 =?utf-8?Q?JylgeygNzHI8zXi34kAZNFhtJAMnH6j4EzRVkryEqr7B?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C505146E06C4064489A2D8A386098CCD@namprd20.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: accesssoftek.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR20MB6156.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b8b9a3-3a77-4069-31e3-08de2e2cf23d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 03:19:31.0194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c0629ff-77ca-4be4-816c-d880f9e12cba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IbHKjG2b/GruW/lWTkqEvpRprRo9Ko3hAe79qOucIH5wuhUB8VlHrRRWioSV1bbfc9eAoEiosNS4WPW9ZuU2Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB4545
Received-SPF: pass client-ip=2a01:111:f403:c10d::1;
 envelope-from=hdijk@accesssoftek.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 27 Nov 2025 22:48:10 -0500
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

dHJhbnNfQlJBIGRvZXMNCg0KICAgIGdlbl9hNjRfc2V0X3BjKHMsIGRzdCk7DQogICAgc2V0X2J0
eXBlX2Zvcl9icihzLCBhLT5ybik7DQoNCmdlbl9hNjRfc2V0X3BjIGRvZXMNCg0KICAgIHMtPnBj
X3NhdmUgPSAtMTsNCg0Kc2V0X2J0eXBlX2Zvcl9iciAoaWYgYWE2NF9idGkgaXMgZW5hYmxlZCBh
bmQgdGhlIHJlZ2lzdGVyIGlzIG5vdCB4MTYgb3INCngxNykgZG9lcw0KDQogICAgZ2VuX3BjX3Bs
dXNfZGlmZihzLCBwYywgMCk7DQoNCmdlbl9wY19wbHVzX2RpZmYgZG9lcw0KDQogICAgYXNzZXJ0
KHMtPnBjX3NhdmUgIT0gLTEpOw0KDQpIZW5jZSwgdGhpcyBhc3NlcnQgaXMgZ2V0dGluZyBoaXQu
IFdlIG5lZWQgdG8gY2FsbCBzZXRfYnR5cGVfZm9yX2JyDQpiZWZvcmUgZ2VuX2E2NF9zZXRfcGMs
IGFuZCB0aGVyZSBpcyBub3RoaW5nIGluIHNldF9idHlwZV9mb3JfYnIgdGhhdA0KZGVwZW5kcyBv
biBnZW5fYTY0X3NldF9wYyBoYXZpbmcgYWxyZWFkeSBiZWVuIGNhbGxlZCwgc28gdGhpcyBjb21t
aXQNCnNpbXBseSBzd2FwcyB0aGUgY2FsbHMuDQotLS0NCiB0YXJnZXQvYXJtL3RjZy90cmFuc2xh
dGUtYTY0LmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQoNCmRpZmYgLS1naXQgYS90YXJnZXQvYXJtL3RjZy90cmFuc2xhdGUtYTY0LmMgYi90
YXJnZXQvYXJtL3RjZy90cmFuc2xhdGUtYTY0LmMNCmluZGV4IDA4YjIxZDdkYmYuLmNkZTIyYTVj
Y2EgMTAwNjQ0DQotLS0gYS90YXJnZXQvYXJtL3RjZy90cmFuc2xhdGUtYTY0LmMNCisrKyBiL3Rh
cmdldC9hcm0vdGNnL3RyYW5zbGF0ZS1hNjQuYw0KQEAgLTE5MTYsOCArMTkxNiw4IEBAIHN0YXRp
YyBib29sIHRyYW5zX0JSQShEaXNhc0NvbnRleHQgKnMsIGFyZ19icmEgKmEpDQogICAgICAgICBy
ZXR1cm4gZmFsc2U7DQogICAgIH0NCiAgICAgZHN0ID0gYXV0aF9icmFuY2hfdGFyZ2V0KHMsIGNw
dV9yZWcocyxhLT5ybiksIGNwdV9yZWdfc3AocywgYS0+cm0pLCAhYS0+bSk7DQotICAgIGdlbl9h
NjRfc2V0X3BjKHMsIGRzdCk7DQogICAgIHNldF9idHlwZV9mb3JfYnIocywgYS0+cm4pOw0KKyAg
ICBnZW5fYTY0X3NldF9wYyhzLCBkc3QpOw0KICAgICBzLT5iYXNlLmlzX2ptcCA9IERJU0FTX0pV
TVA7DQogICAgIHJldHVybiB0cnVlOw0KIH0NCi0tIA0KMi40Ny4zDQoNCg==

