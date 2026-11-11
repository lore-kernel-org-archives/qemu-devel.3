Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A6E606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=YLwV4P3D;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=tx83HUS2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQzB9-0002PT-Da; Tue, 10 Nov 2026 22:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xQzB6-0002OS-KV; Tue, 10 Nov 2026 22:39:17 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xQzB4-00069E-Pc; Tue, 10 Nov 2026 22:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794368354; x=1825904354;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=gCMA7V4Q8tbHLVpdWOLkJeZD9BKXzI6faW3QIRe45gc=;
 b=YLwV4P3DMzRqZsNgn0b2w3fT4R3NygoXIGBDCvgE57GCq2RfydPgOEvK
 qOdvT+GAr3Zy7J9fa2apXGLM3L3HhL/nQd3SjmyKjMqabgqvxCmQTcaru
 9hGLastrhascAvxp6g7GOUhCN81lkoUvAjc6IHhQGhQWiB5s9CCvpVB3Y
 TvTrs7Fe/O0xmmLyRORTet0g1sj7EkI2uNBZ6CrzQWVoVSXxtU3AHcWrn
 Ru0PCmI25TNTVM+7m+u8MEdkesCBvCRvphhTm3bUti+MeYCYUas4t7S2n
 G8XkZskWaYcAwtEL1Pb2y436qI34JaemX2AWC2Zvfn70WyfatFC9khSEH g==;
X-CSE-ConnectionGUID: b7aqrGYYS7K6FgNZHmeXTw==
X-CSE-MsgGUID: QDCuzKcwQI6zDysm3/MARA==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; d="scan'208";a="161571747"
Received: from mail-westus2azon11012069.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.69])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 11 Nov 2026 11:39:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luLdTTQ2vsucDAOflQm/gt6nYY4HPMthWfTCRD5+f++Nx03fQRmDXnTTbqSD70vO5R2f/HOuP6ck5PfeomOA62RqjCOkDKcAsoIK9OoHjqsFdJbKvEchy5qWleWYjUKH7NSPgnuJNRh3SInWEj6nC5PFX+MRfqrV71mIEcpwwF7KqcuTHN/w5QDSue8r5TK4IhNiJsUnsqWu5AMOZSzrrNzh5gRxCwYRYuVvp2XMD+4BT5zXxxgSwBjUPRlbokaBBth+zXYn/5GrLOuXhEPp9kIbq3FDX30zdrX0zSU0zvRdlAkyqdeKxtrAjUGzY8wxixxpcTqSr0m3dipBS2SBPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCMA7V4Q8tbHLVpdWOLkJeZD9BKXzI6faW3QIRe45gc=;
 b=lU5jJWupMHe2P3MuUixwMK3apGHzHNoCH+VeOElnWWanf4tH8VF2J9GXR4zYIAMjQ9vZe/7pTvMa9Js5Od70kLmPBh3iggEV/XH8h0gWJOcUW7ndtzjSDaHj6Qk5b71/4H8eBEbNGkEyJLR8ZU/JVExe4DXbSq3kfLuX25624C6LAZLmm4Y8yyYYeyux93YmtyCxc3r+gvbwwGi7nEbbMenfkRkEYdZ6InHs8G1BtAez1J8GHSYmL7jIuH7ni7k4+n8z3o/QLH/YKK8nF4sCW9xrQRSw2joWXs+9g66vaQqDyCEOyFAsHWlHhpxFbXwYOJ0Qhz7SLTL02sj69rJ8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCMA7V4Q8tbHLVpdWOLkJeZD9BKXzI6faW3QIRe45gc=;
 b=tx83HUS2jCNGCwmURb8lWAStJ2cnd3nATApBqlaZ0kMtvL9w7H0nVrPaJXZ4mpHF/d0UxZHM4lh+T8CymLXTPqUnJGFhDbkiQfvckGvr7/dodzRO79ROcUw6Vxk9UcpfnPv7IWMXshs16ADtQaPVR60RVphJjLrjVRmFo4XQCJw=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by CO6PR04MB8316.namprd04.prod.outlook.com (2603:10b6:303:137::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 03:39:10 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 03:39:10 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "wang.yechao255@zte.com.cn" <wang.yechao255@zte.com.cn>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 0/3] target/riscv/kvm: Add SBI STA register sync and
 migration support
Thread-Topic: [PATCH v2 0/3] target/riscv/kvm: Add SBI STA register sync and
 migration support
Thread-Index: AQHdYczOp44N8ji6wUK9L95HNjHR1bcoWNGA
Date: Wed, 11 Nov 2026 03:39:10 +0000
Message-ID: <6b54bd5bbc6376a5b07a2b092fabdfc94b849047.camel@wdc.com>
References: <20261022022535.437892-1-wang.yechao255@zte.com.cn>
In-Reply-To: <20261022022535.437892-1-wang.yechao255@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|CO6PR04MB8316:EE_
x-ms-office365-filtering-correlation-id: 4fa89213-f4f7-4595-7ccd-08df3fa558f8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|10070799003|1800799024|376014|19092799006|38070700021|11063799006|56012099006|261102123227099003|261021121427099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261022105027099003|22082099003|18002099003|6133799003|10067099003;
x-microsoft-antispam-message-info: A4wRVMjK7na9m1dbvlH8iMsRPJqEOJCS8yKj1uwIERIPSExuz46vASfmIGcVEu9INXybECo6vjern2EJnFF8ADP/qMXY3MPvKk5nvu2bYM4Sb/hsFkJCPWhYjW9hx8ztkdNz6xz1ljpYUV9c1trF9C1jsNlMRtcHaC9iNSuraluSECUVXqsaP4IOZhhPkA7Z0RrMb7CYU6xxgeyVF3psvwwLrpW//KKecGSFNqBLszsfvLs5SM5QVYIvJQDaIrRgcaQziWZP/LYRfcsBARmagot+KPtU9pSrh29PlEFyK7hfj8X4N1BYCQVwGkBDHepXlWBQrmexsANPqygUOOqhdg1hVx34+cbEcGdrdkodBv7Zh0MM9QNS8Ag1eUYiiz3zvH/cRynUK9cmZ0II/yFnKlCxJfHwEbBSsBvtH3Ji6GEOJx2ZeJaptRSp3Jd7OlRJDI7yahVvexlsVi1fjeLBh5oLB4P76EvYUZaTshsFfyB0tj0JTSS/mp+AqGxYEYRJc2ofn6KF1JCFlUqqZx9qco5G7VpfA+FtpehqrrxdnHyGy7JrwMhSOR4My1kp6iEmf9RnUhgL5s0F63FerOnINz1BYhByI3oa4+m06xJiCyxNx9h8CYF6WiAe5Y2L/rCtHv3Y0FonZJb60jE9Aux6Tlc0RTCDcLDG0qMoJnwGGZI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(10070799003)(1800799024)(376014)(19092799006)(38070700021)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(22082099003)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFVtVjcrb0loSFdkYkZtVVY4bzgxLzdwQ3o5RTQ1a085SU92dHd3MVE1dnFi?=
 =?utf-8?B?VFJoR01kYTlpNTlldndGbHdEemVDSVp1T250MjYvUTNvclZvSS9qaVlSRlZP?=
 =?utf-8?B?TVFsYldBS2xFS2ZwalhYbllVVzNtOWhzUldncmJPbkVwbEFudTg4WFduK1dr?=
 =?utf-8?B?ZzBQZy9YdXBjMmN2V1RBVjhjZDUwNjRMZWVrQUx2ZmFQZzlWT25HSE0razV0?=
 =?utf-8?B?K05KSzBYNXFmU3ZFMDUzSGhOUnRHT3JtczV2ZEhPUDdNbGVKaFE1UUZ6RTdF?=
 =?utf-8?B?OVExZm8wOUpweGx0ZE5BaVQrZWovQ3l2MkNvZ1VySW9qLzkwN3pvcHBSR2ZQ?=
 =?utf-8?B?QXpxOS9sdGpESTJPdzZFSEdDbDdnaVVFWm5YWHkrUHpVeEljVjZIUXRaNnYw?=
 =?utf-8?B?N29EQVNYcHJyUGFJczNxb3Rib2gwVTZta1VhL1ZST0VzZ0RpRHQ0eFF3eVA1?=
 =?utf-8?B?ZVNzUEhzQmZRVHNmMHBndlAxb2FnbEZyM3lRenZXcFRRR1R1ekdWUnAvTDlQ?=
 =?utf-8?B?Y21zMnU3QWN3cG9ZUm9KRzNxaCt3N2wzQ1c5bWlTUTFvaDQ0MWJ4Mk9SbVl4?=
 =?utf-8?B?ejVMYVdHRUxUU1E5YTdnd0YrcFUydFU0Q2w2Z2ExSjZaSlpDUHFhaDhKU01U?=
 =?utf-8?B?SmorcUl4UGhuUlIzNExZcjRidURUMkVSMDhFWUJDMFMweHJydjlHZXl4QWYr?=
 =?utf-8?B?dk55eHVXdVNwSnhHb1pkRmwyVjg1Z1RJQ3dmbHpCK1dhSTJOVWwzbGdvL2hH?=
 =?utf-8?B?bEJGcXdoalExbWpjOEZOREtGclA4bUE0TzVwQUdjTGc0SlZxaWVpWjlYUXlM?=
 =?utf-8?B?UkN0NnBpNGExaW94TXhvMVRjRTNYakdFOU8zWDJoU2dsMlRHalcxZlFkemhW?=
 =?utf-8?B?dmtXVEt2ZWk1UnhhTVA1eTAyd0hzdGd6UWNJdTl5WkVVekxCcjZ1L085bkcr?=
 =?utf-8?B?bVVRNW1SbE9HMElkd0tGcmlqNFRVaGdLWElwNkVwY01oK1FoZHpZUHA1VTcy?=
 =?utf-8?B?bzBGTHF3aEdGTEs1MU15UEt3WjdpWlRDdGY5RDd6TXdtWXVFKzJFWDhid2Ju?=
 =?utf-8?B?aDJIbk9KMU84UnlIMG1qTWZUeDNwemg4eGVqSHZWWkpVckVyOE1mNGJlcGU1?=
 =?utf-8?B?QTRVQ3BYMDRoSmFER2VFeGxWVEdLQVFuK0xuN2UrNVJ1a2xHbllmYi9BbjA4?=
 =?utf-8?B?N2JPS3d0RHhrOWRadHJZY3JmMmcxQmcrWHJKelBOdHYxMmRIK2F4ZjFlS1NQ?=
 =?utf-8?B?aHJJcEp0L0dIYnh4TlBGQTMvODdnMFM0UFV6NWsvN09lejEramVtcDA5eTk4?=
 =?utf-8?B?U2Y5Y1Npdk5jbEx6V1BXUWx2U2lwR1l5OTk5enhkYy9yZDY5UnM1MkFuMzFs?=
 =?utf-8?B?ZEFuNnQrU0FjODdySXB3dFppQnpFY2ZHUnRhSy81d0FRc1hNQVd5aDMvV0pG?=
 =?utf-8?B?VnN6NjRRb2hkVEhES093Nmgxcm9HakQ3UDVsMmlzNmxQSnFnNHk1TmdIT0Jh?=
 =?utf-8?B?dGxEOVVxSmVZZ1lmcm5EbmZ1blJiNStHVzdobTZlSlRVKzBhZmlZdWxFQkJD?=
 =?utf-8?B?ejBtdjY4SWd1WGwrdE8rVTRvMGl3Y1hTcnNDZVhLd3RwMmZkdDJreWZoWGli?=
 =?utf-8?B?TVpReTJFQkI4WXl1eVlCeUVtNS9ocmNSVVB0NzBYaXBQbkdNdEdlWmt6cXpK?=
 =?utf-8?B?VG5iOGQxNW5mSjRMRTVRMDRobUkrRVBEaWN0ZUNKQUZQODF1LzA4ZHM5R1g2?=
 =?utf-8?B?V0dJVGRaZndoZ1JOZU1sSlp4Q0JqSjFmcFp6aFJlSEZlc0pMMkhJajZISXZx?=
 =?utf-8?B?MW84akFoL1oyQ1E3dGxNc2dpZEx6Q3JTdVozTVg5dXEyQ2RiVytXMXBCdXdT?=
 =?utf-8?B?N1ZkWXZxUlNyZXppN3h5K0J2aDRIVWJ6ay9HdjBkWnA5Sm5KTDV3YVlUUTg2?=
 =?utf-8?B?NDhSSGN4dXBtZkdlaEFGSjJTRS8wSU9RMlllcGZxVDdGd0ZKaXVaNEhPWTZp?=
 =?utf-8?B?QzNFTEtLUUhzOUV0b2RLMlVTN1R0TmRQNGhPNDZOYzI0Q2FQYU52K0c1ZC9Z?=
 =?utf-8?B?bDMwbDhWZkhjZHRLcys5SkYwcVNSbzhXUGVUYmZINXNUcEEwTkVkc2F6Mjcv?=
 =?utf-8?B?L29oM0dQa3BPdmFUNE9kM1pSdEJoNjVheHNiY0hoUnpSbkoxOWsxTHlMWko4?=
 =?utf-8?B?UjF6REpKaWVrcVZhTkpKSERpY2NaaWc0WXVKRDBjam51c2QxVGlHRkkxOEpT?=
 =?utf-8?B?Tk1USDhoMWNVRmMzV25CNE5tZTR0ay93TG1nT0JKVmdyOUlVNVZwRGdZOW1j?=
 =?utf-8?B?VjlPek1FUURtWW1IVVRIVURFZjNvQnBQMHlDL21Zc01PWFVranZLUlFXQ1Fw?=
 =?utf-8?Q?YKfATimt/EEAxAfDu7p8yUwXFWzQpEogdTPh0bd3Humas?=
x-ms-exchange-antispam-messagedata-1: 4PqdSGik6rjwq8x08I3DpSCMS5eozgKzu8k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <347A6BEAE8C6124389537B817EA04421@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ntj8bYFCk+2nS2RKMgCCKvBPrVUmXAhaUnURvUG23O1pfnEnolV9gozq/HqJ0UXzjzHNeX30OnSlrBWokueouX8wP3OPcTM2TmHydrluf9nNwZFeGt/w2TX3htYSuHgdQo1pBp7PLPu3OoKImUem2VLnHuNfHzk2OASQyMdPDGGYaqC3uAF5BGfAFcZnpemWrb65+KCXwaUqHVC/poFzxg4CJvq0KS48WPvRgMHrOM5sQvpn3kVwN2kfcsELtXzUmS26mYeFRdOCBXAN1aNC+Gw4VHdKoSVrx6ywL5LgGsd71WBTSwLj500Fl4cGy3TT4cptZzuTxpoc2nOsK7UYpQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g9QHniENrnng5IpGaj0Mo/0yUBClHirEVCnjSc7SP7Vm1vtwsMlRLmgnLM0t8O2QiC/CdSncgTQH/1mLyKrQDzYD/+Vln9s9seo673doqY4RZWq0Kh9kJHx/h/htbd77W31koLsJ0CablF9vEYI4dkFqkEhTkP5GzjL8akkMfDHkRmIuTCQdBkJsMpbmxI1V4rrCFqiDPYNtAzOpF7JmCFoxnh1t3YQ4fcdoeMMdRBuhAzGO3y4bsJPEv5GG/p6sdjWpv6cDKYu8RmayT858qntb1HcOWvMM3dCyLrGhHg5esblSLmFMc9gNJiUTmos5hL0eR+3xrbNniyyMAHHJiNgpvC2AjkwqntNvCNrbpJo7bxVsYpgQb4pdPjivHdGV8Rsih3qzJBFJPOuEmGVegYOjhdKK9hYRcMZaKBBaGz5kmMnureyBgxn4GKsmIOp3MNo9so/3DsBE5b3boi+JR/rM1IwwAN9WoRiUvRXw5OfAcvZ0wwa/5eAecjk1ki5woT/vz4AvQFyHAPYm9flO0doN5Hv72g2vVY1EoSTTEg2GmDuIVEqSGCQX3xfRpWPVAmuYPc2t3Mt0B0ZcunwwKPtP220BPUuRkaL23j0WObTB7c3xjY11Y1j2p+KiKYDU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa89213-f4f7-4595-7ccd-08df3fa558f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 03:39:10.4591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BhWIvwzkWwjen2sqS+Z2SZgdWQL8+zEsaDPU8F34Cn5ujYeydsX3ek8TjR9jSo6X6EMl+945PlE+OdfUPH59ACFODpoSB8TXuqT3/XBlMzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8316
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=76810307e=Alistair.Francis@wdc.com;
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDEwOjI1ICswODAwLCBXYW5nIFllY2hhbyB3cm90ZToNCj4g
S1ZNIGFscmVhZHkgZXhwb3NlcyB0aGUgU0JJIFNUQSBleHRlbnNpb24gYW5kIGl0cyBzaG1lbSBh
ZGRyZXNzDQo+IHRocm91Z2gNCj4gdGhlIG9uZS1yZWcgaW50ZXJmYWNlLCBidXQgUUVNVSBkb2Vz
IG5vdCBjb25zdW1lIGl0LiBBcyBhIHJlc3VsdCwgdGhlDQo+IGd1ZXN0LWNvbmZpZ3VyZWQgc2ht
ZW0gYWRkcmVzcyBpcyBub3Qga2VwdCBpbiBzeW5jIGJldHdlZW4gS1ZNIGFuZA0KPiBRRU1VLA0K
PiBhbmQgaXMgbG9zdCBvbiBtaWdyYXRpb24sIGJyZWFraW5nIFNUQSBmb3IgdGhlIGd1ZXN0IGFm
dGVyIGxpdmUNCj4gbWlncmF0aW9uLg0KPiANCj4gVGhpcyBzZXJpZXMgcHJvYmVzIGZvciBTQkkg
U1RBIHN1cHBvcnQgdmlhIGdldC1yZWctbGlzdCwgc3luY2hyb25pemVzDQo+IHRoZSBzaG1lbSBh
ZGRyZXNzIChzaG1lbV9sby9zaG1lbV9oaSkgYmV0d2VlbiBLVk0gYW5kIFFFTVUgKHNraXBwaW5n
DQo+IHRoZQ0KPiBwdXQgYXQgcmVzZXQsIHNpbmNlIHRoZSBhZGRyZXNzIGlzIGNvbmZpZ3VyZWQg
YnkgdGhlIGd1ZXN0KSwgYW5kDQo+IHNhdmVzDQo+IHRoZSBhZGRyZXNzIGluIHZtc3RhdGUgc28g
U1RBIGtlZXBzIHdvcmtpbmcgYWZ0ZXIgbGl2ZSBtaWdyYXRpb24uDQo+IE9ubHkNCj4gdGhlIFNU
QSBzaG1lbSBhZGRyZXNzIGlzIHNhdmVkIGZvciBub3c7IG90aGVyIFNCSSBzdGF0ZSBjYW4gYmUN
Cj4gYXBwZW5kZWQNCj4gdG8ga3ZtX3NiaV9zdGF0ZSBsYXRlci4NCj4gDQo+IENoYW5nZXMgaW4g
djI6DQo+IMKgLSBwYXRjaDAzLCBvbmx5IHNhdmUgdGhlIHNiaSBzdGEgc3RhdGUgaWYga3ZtIHNi
aSBzdGEgc3VwcG9ydGVkLg0KPiDCoC0gcmViYXNlIG9uIHJpc2N2LXRvLWFwcGx5Lm5leHQuDQo+
IA0KPiDCoC0gTGluayB0byB2MToNCj4gwqANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVt
dS1kZXZlbC8yMDI2MTAxNzE0NTIxMS4yMTkyNTgtMS13YW5nLnllY2hhbzI1NUB6dGUuY29tLmNu
DQo+IC8NCj4gDQo+IFdhbmcgWWVjaGFvICgzKToNCj4gwqAgdGFyZ2V0L3Jpc2N2L2t2bTogRGV0
ZWN0IFNCSSBTVEEgZXh0ZW5zaW9uIHN1cHBvcnQNCj4gwqAgdGFyZ2V0L3Jpc2N2L2t2bTogU3lu
YyBTQkkgU1RBIHNobWVtIHJlZ2lzdGVycyB3aXRoIEtWTQ0KPiDCoCB0YXJnZXQvcmlzY3Y6IEFk
ZCBTQkkgU1RBIHN0YXRlIHRvIHZtc3RhdGUNCg0KVGhhbmtzIQ0KDQpBcHBsaWVkIHRvIHJpc2N2
LXRvLWFwcGx5Lm5leHQNCg0KQWxpc3RhaXINCg0KPiANCj4gwqB0YXJnZXQvcmlzY3YvY3B1LmjC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA2ICsrDQo+IMKgdGFyZ2V0L3Jpc2N2L2t2bS9rdm0t
Y3B1LmPCoMKgIHwgMTIyDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
IMKgdGFyZ2V0L3Jpc2N2L2t2bS9rdm1fcmlzY3YuaCB8wqDCoCAxICsNCj4gwqB0YXJnZXQvcmlz
Y3YvbWFjaGluZS5jwqDCoMKgwqDCoMKgIHzCoCAxOCArKysrKysNCj4gwqA0IGZpbGVzIGNoYW5n
ZWQsIDE0NyBpbnNlcnRpb25zKCspDQo=

