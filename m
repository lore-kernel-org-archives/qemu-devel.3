Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6D5606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=pnT8Kq3n;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=n7DEAlbJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQzHA-0004cQ-GB; Tue, 10 Nov 2026 22:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xQzGs-0004X3-AQ; Tue, 10 Nov 2026 22:45:15 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xQzGo-0002lx-KF; Tue, 10 Nov 2026 22:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794368718; x=1825904718;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=C+EJ/Go0XTtjqLIMZWALsrY1Ljr2K8s8nhYAoJIYgbc=;
 b=pnT8Kq3naMBI4f9ZYYavorLiqp5rVOCjCb2BVUPA3KecC/sactDfOIXS
 rbUdmbvDH3JnSSQEZrW4LLStvDzSIL/iixb5Z7Ll3QYRRAepYVFPxJ7S8
 EJdNkSsspjIEGpFXVl57jOX4b8XJ/T0st7GKDGpIz9JZOY3mNg4Ool4/x
 LwyVUvE7rGeoTsmQtGXlRfciO6QVAZSsO+7y9VT/fmjF0Jp6xObSctYLY
 IFnL4mdSPnMP4/z509Ku6shnEwvR4VlC/J7YDWVT/1K+qscaRqtMQBDU3
 UWQz23pUrourPCCWtN6uKACG04CROwkBiIncj/4lzIIHQx6/SxIu1C+eH Q==;
X-CSE-ConnectionGUID: 4qZl94fXQMK9v3rVC8lzAQ==
X-CSE-MsgGUID: AaAwJlI7QOae96HvLLDiXA==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; d="scan'208";a="156362857"
Received: from mail-westus3azon11011058.outbound.protection.outlook.com (HELO
 PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.58])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 11 Nov 2026 11:45:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxXiPDi6q4iJ/qRFAxFIXca3hQvlPi0lIS3PKyhoyHYTWw5wzqVrRMEerwB8Y+8dXP+s6kxVCStH94wVaPzxQvsRWyAz2FMAeGch/8vV6ltq+AulVYUbO5sKREitOPVOjrQP1Awy86TCJDU9RtrLh//e1C17op1edPIZwJ6ESbrRE/xyBjACnnrl0ihyRW48tefuKIZpd5eReKhh5kGOHe5L4WTtSHTzRuxcUX+C2p3mYfZsWArOFrBMeEkSW6RKwmi5uGUz1Fg9w9dQZCdurCwefzymIHz29fZr4irOkx5WLj3rlYgd0QJ0b8LxswIoRYN/KnQ38UjPO3gA+mAAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+EJ/Go0XTtjqLIMZWALsrY1Ljr2K8s8nhYAoJIYgbc=;
 b=Ebd/DHqGnEAUbZZg1VamDi4pVTGfkgR27uq7kb+W6hFtD6OK+dLgUYcRrawA7ARwqjp6eTcMjjym23cQckb+4oes6984cx82JBb6aNZg3nKfPj9oM66bm3CzW3dts2tecZtqe1ef715Nshb9ukC4mg6P93yg3404r3NxHUWHRIv7u7MW/nLQ1MhmI4AhwB6mkQuluVjpEaq4dpq/LWV0U4SCykjfHjaPvM04qRxpcGpx5CaFFFanDBlNWYPaH1XyXzkYO4yZTaCUTKE82p05gklVD1fEOa7v4ggi55OpzyxJGarUqYGLlJ7IwKAx3CPf9DlyPOf5Oi3PDrHaRaf8lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+EJ/Go0XTtjqLIMZWALsrY1Ljr2K8s8nhYAoJIYgbc=;
 b=n7DEAlbJFukEH+m7I7E8cKLbK4l8VWQ45AsekGYiD3ijUyRj23wDr23WXYJVu0t9zFRy0WR4PwMi9ONyVVdiGyt7r48+ewo57KNPAbUzU278oZxrYkxWqM66WyGPEceCZ18dWdJh+Kl43svDAwtKId+FqxEZsHI/En63s2fAcQk=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by PH0PR04MB8280.namprd04.prod.outlook.com (2603:10b6:510:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 03:45:06 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 03:45:06 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "palmer@dabbelt.com" <palmer@dabbelt.com>, "wang.yechao255@zte.com.cn"
 <wang.yechao255@zte.com.cn>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3] target/riscv: Fix incorrect MMU_USER_IDX value
Thread-Topic: [PATCH v3] target/riscv: Fix incorrect MMU_USER_IDX value
Thread-Index: AQHdZbxddLqOpAigtkeV6z5i9UgwUrcoUpqA
Date: Wed, 11 Nov 2026 03:45:06 +0000
Message-ID: <9d945beaba8520aa1e26447e62f2caf19c902ceb.camel@wdc.com>
References: <20261027023729.680646-1-wang.yechao255@zte.com.cn>
In-Reply-To: <20261027023729.680646-1-wang.yechao255@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|PH0PR04MB8280:EE_
x-ms-office365-filtering-correlation-id: bc1f33fa-68cf-4a2b-6b44-08df3fa62cf3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|1800799024|10070799003|366016|376014|18002099003|22082099003|38070700021|56012099006|261026140227099003|261028144727099003|261022105027099003|261102123227099003|261021121427099003|261021123027099003|11063799006|261009223027099003|10067099003;
x-microsoft-antispam-message-info: tReJl83jVPT1xXcz6+d9ARbQWS/euQpxm6pVLTecOMwR+0PuT7wcDyfR0lpKL4ahJk5xN6EPKcT27xQx7VcLya8n0H42Tf/xy+evZx66QeQhUPUGwCuJbMTZ0WVdbVpq2OFNn8mSR+pzz09WhXZppr328PqqCCkWn3H8cuU9P7nRN1g8VUNwW6bA8T5lghu3yYOr1WAHVr3cdm0+F4lRVGI9qerhtZclWk+rzC2b8F3doon246rqDGZ/O7jSgMvCoQClBqmJomEb97XWA62or1n4tfU9E7PEoyRL0i89kBxzdxz64YR6mz0fUJQWTxJ6/AnNYD6YjPUfC4zNEjHQtBCFY9pX8fT5xPSqhe24SMa5rVUNmQYDiZgQWfGeLtWEkJKcK0RbPWqm7GDjPtBOZqXB0LHQ2kf1tNfeMLaaBrU5k3h5r2qOyLCu3hpZB8JXhjQ0pasuMrnT3sks9bJZ1hlHJ/UGNwy8ItnSyLQA0o2qx7lGydpj/J07bKQIben33pNh/7fI1BLz3NGTGYULfY4jZm/35puCctfYCgopIm4rYi2QslHi80vPg3Nb+SxnkV6ImY/Bpj52C0UnNX/0EasbRxLmOtpw/HN7yxaJ16roYU+i84hP2F1ThYMZ7MKoRMBLlpAAxGrNRJE7oB5JVPha2qfgr/F3taQqVTnA/8E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(38070700021)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261102123227099003)(261021121427099003)(261021123027099003)(11063799006)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjRIRGNSMzlkKzRtQzVwNXNobWVRV3R3U1E0cDNGYXVSQ2pIOVUvcW1CYjNM?=
 =?utf-8?B?UkdlQkZKeGo3cW1JcVFEQzhMZW1oM2Qzb3Nhd2N2YTcwbU41elZQSjdva3FH?=
 =?utf-8?B?Z2VsQUwzZU5lZlA2eHpIdHVVNE8vaTB2TkNQcjFUNmJCQjJ4bWJPclBXcUpu?=
 =?utf-8?B?OU9zR2h4NWh3VmRiL0ljZE5uUENabGdRT3ZjY1lZSVF1Um5MRzZFc3NuazhT?=
 =?utf-8?B?cjR1NktYbXY3WW1KQ3grbC9zc2wwM1JjVEVSL0t4V2ZHQlZnN0Fac2VsbGJn?=
 =?utf-8?B?b1F5S253RnZkd0tFeFluTWN3K1M3MWVPUVhZRHRpRmFnaEo1cjlzVS9jU2Fs?=
 =?utf-8?B?UjNJdEluNW5YM2pQNjRvcTlHOHpoOXh1NlBZTVltTHZqcm9DNUk0TUZTQTAx?=
 =?utf-8?B?UTJjV0tpeEtaOGNncW9RaVFVQStnaVVPVk1uaFZrY0hvTjNUdENEMUkwN0Y5?=
 =?utf-8?B?MTZyakUxdTFXMGg3VHorUHA0TDFqekxmWGVwT0diOHlFM2RtdEROdlZqV3FJ?=
 =?utf-8?B?WGtCc1hDQWRSQU5EbnNXNUhnTUk4VXRQdHFoemlSTFFXcUdIRFFkV1pGc21u?=
 =?utf-8?B?RWVocENsbTRLb1lBYStEUS9CRFJJSktmSnh4WUFnSkY4L0hiUUZDRDJ3SmUz?=
 =?utf-8?B?cUZJcXViRGNiS3hwNzVsOVk5cWFhcGQ4VDlUR2dsMHEyKzZyenRIVTVGNGtO?=
 =?utf-8?B?bXZVaWdUWmlZWVhyVmlWYkZ4OTdkVU53R0tIeXhQakVzY0RzWnZwczRTZkc4?=
 =?utf-8?B?c0dOM3ptNkYyd2NkT0dvZTNIa05RSUozanRMZEgrVHNlbGY0amlBUEFIQ25u?=
 =?utf-8?B?bFU4K01iU0dua2RVVmlkYitMdkRQZzJTMWVvdHRZem5vTHZ0K2Q2cVpNbEJQ?=
 =?utf-8?B?Q1NaYXJ2dGFpa0pRS0V6UkF5RGYxcTQ4UnYvODd4TWdtTjJGUUUydDJibXJY?=
 =?utf-8?B?cFd6WHBqeFFWeEFGcFdJRGV4bG9DenorYld0MG9zZ1Rhc2xNMlBheTJuN25y?=
 =?utf-8?B?QURlOGlqSUt6cnVack5hQnZiM0ZZRXpjOHcvc2d3aFh1cjlWeTN0VllaN1BM?=
 =?utf-8?B?eVc1UFg4Ym9lZGl2YWNXODlxcEpkRHRwZ2dwU1hUYmkwelFrbkNrV0JDbU1N?=
 =?utf-8?B?Q292ZUtJMTZQeWtqRzNlWjVHMFpwWkZIWXR0bWNKRlFYb0R0OWEveS9hSU0r?=
 =?utf-8?B?cHdFb1ovSWk2Q2ZBUm44ajduUzdlZzkyaGx0a3lrb0xPOXdiT0dZNXd6WEoy?=
 =?utf-8?B?WmtHNnRzNWhTQlRjbEZROWYyYUowdE1ic3JTOXZXekphbStqTlRoTHJOUTlj?=
 =?utf-8?B?d0ZkazdpSWREaDRNbys2aU1BNlNzakwwM0VOZURMTGRzbEp3c1JjTEMrYmJp?=
 =?utf-8?B?WmRPQjg0d1RVdkdpc2RKUC80VzVueEU5WG1aQnR0ZklJRlF4SE5PbmtrQy80?=
 =?utf-8?B?TGFUSlZoY09yRWJ2MWhDdVhPSEMyY1B6Qm5XSEUvNm15WElTZnV0MnVMVmxO?=
 =?utf-8?B?aHlCVEl4ekFyTEV4SFd2c1lXVHpQQlhzbDVzTmJPVjAzZ0RWOURkaGRvT1hZ?=
 =?utf-8?B?RXFtbnJRNlNiSU5KTXRkN0Zia1lMOFZNYXNEOU5BQTlXK0kvMGZLNWQwd21G?=
 =?utf-8?B?RGN2WjdyUk45eEVJZzVneTR3UTdaUUVpR1RMZGMrZ0V3NFNJTS9US0ZvdlZm?=
 =?utf-8?B?TERoTjJONjh6NjBmakNRdlU0blNidjVIRVlsQ285WWEvVDJQYzU2WHpoVXBX?=
 =?utf-8?B?L3c1V0IydG96V205OUx5WkdnMU83K2NnR2lQZEp3bjlXODEwM0VaUXV1KzRY?=
 =?utf-8?B?SnVjTzRSMWU4R2U3aDkzUEZDWFVpZDkwdWNuR2xIaVlSbDFpSk5hdStSanJv?=
 =?utf-8?B?Y1Y0OUdwY3NIZnNEU096djVMNFlWTHhVVHV3MUJYZkIrVVR1clgrMnV1WFpx?=
 =?utf-8?B?ZjZBU3p6WGlwdXNsYWRkclg5WWdxOFdZajZHK1lzN1lFNEc4cUU2MnFqZVht?=
 =?utf-8?B?Z1NEWFE5Uis0VnZPUFllNDZxK0lXUXdSYlN6NmV2b0UrMkNPYTdadlo5UUNO?=
 =?utf-8?B?ME1yN0ZDZ2lMZ3kwRkxIWjJ4dHNZUjhWZ1NhcmFEMmYrd05Ua1lFN3hEOHlv?=
 =?utf-8?B?SW1wWDJOQjh5S2xhNlRWS1VQbDN3cUdicXZHNHNqWHV5RnVWekM1OEhGeTE4?=
 =?utf-8?B?QTZjNTFiUll1d1dBNUVyYlM2S01peUN3eUlpeFFyQ3MwY2xVRVRlbHUrRHVH?=
 =?utf-8?B?L1htd2NOUjVTV0haeGN2OWlVM1hLK3lISGRlS2ViVVVUUnA4MGQ4d3FKOEkx?=
 =?utf-8?B?d3lLQjZtdGpnMzNJN040bUdTOGVvS0FlWi9VSTdicmxRYmRLdEI1S3AvbTdh?=
 =?utf-8?Q?07qoSz9zJ8MUIZdM8I/2xcNSXDksUqmJm4S2DTAa7lMUw?=
x-ms-exchange-antispam-messagedata-1: /QDrVCrWCVEgbYUzlcRnHLHqAtSM82PvsTA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19C37EC2B2347E48959C8F943C43A7BA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n5OXz7W9jyd66ok4V+bAA0WcZEYghwa8FG+REYNHeDhCkR9eMxBLm5YZZO7XVjn0JaJvZ0ld6T1y4tzOuqxkspidp1MUlmTgfjvkJfKlqX2lOM404lg7ddBcttvHjSUevazqIlqJSi/idbidV02Cq2WF5KvK1WC0KeiuoGwSezdx+HWDLNi9LLXkVe4sKRc3qybtSzR0ZMRq4ftePwICgUgByAvmLZJ+MsqPF7GHZowAuWGVdOYZeEJTvVPo1iwVg3xYHD3huXXmGaFXjJOXq0PVbZSSo5QATagXOfeiiyDVxNgAau63f4qbdf2SMcG3xXJmNMBceBxN/qZk5PsmuA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X9oqlfw0kZnELqJR3E/CgAjlvlfLChbhD/wBMXOtfvE8l4ZkXaEGUgpKyK23SyATGmIQ1nxZH9PKZo9raT1lqesIh/ylOMBt9YRUo4zBz5BcU+msCN/dZJR234eEebD0C0d36XBq2cWeZYpda7UJs215WCQVOSKR/KJSZv3qq9YT1SiLRThMlzypz5aIhOjC2qLM3l+ZsFkOWdMKC35Dg9YnqWsqeaC6DeGxavzM4CCj/dgvkE9cY1at/nl5y8rptI7ZUktdMcer3tyKH8YNxmJzqin7pwzoUc4G8EQoIU58hikcP2n5UPD82kQQnoMiMMYmwFWTmb8lwRfAEcu7EQIF+63dh9RIF6otHiOx4ZNNZCRGvGpqcp4N19NP7uK47xVgHGWizsQgEx76f3nuKsHJlW6y8EITE31UkVcceSpKqa15uzKhM3ZVBnRDHFWJ4ccUfgKpLwBBi7sJ3El3gBJPK8ahTkWcGtRFBoLJuilfmFVksee/9SPP+T4nYygZu/6Fjp2M2qXpnCkyFDkfbMH2RkyOpmHrneXbVn9gCtK8nWjKgNRgNR9AEXMqrn7cmp27apfuVjRV5mAgSXKyedpm9i/Om5oUBBmIghQgYXGt1WcXeji/Rw16jsy/VdGe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1f33fa-68cf-4a2b-6b44-08df3fa62cf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 03:45:06.1128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ToSnf1UVOJKZBWS03cHz+r0FXLVZPT1q5esb01jBnDeEmlhA9F9i/BxZyf5CPx4nRwE/sk/IYLE0ws3wbfrCu+lcC/xtmcqz7R+wh2MFNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8280
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=76810307e=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
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

T24gVHVlLCAyMDI2LTEwLTI3IGF0IDEwOjM3ICswODAwLCBXYW5nIFllY2hhbyB3cm90ZToNCj4g
TU1VX1VTRVJfSURYIGlzIGRlZmluZWQgYXMgMywgYnV0IHRoZSBSSVNDLVYgdXNlci1tb2RlIE1N
VSBpbmRleA0KPiBpcyBNTVVJZHhfVSwgd2hpY2ggaXMgMC4gVGhpcyBtYWNybyBpcyB1c2VkIGJ5
IHRoZSBnZW5lcmljDQo+IGNwdV9tbXVfaW5kZXgoKSBmb3IgQ09ORklHX1VTRVJfT05MWSBidWls
ZHMgYW5kIG11c3QgbWF0Y2gNCj4gcmlzY3ZfZW52X21tdV9pbmRleCgpLCBzbyBmaXggdGhlIHZh
bHVlIHRvIDAuDQo+IA0KPiBGaXhlczogZGM1YmQxOGZhNTcyICgiUklTQy1WIENQVSBDb3JlIERl
ZmluaXRpb24iKQ0KPiBTaWduZWQtb2ZmLWJ5OiBXYW5nIFllY2hhbyA8d2FuZy55ZWNoYW8yNTVA
enRlLmNvbS5jbj4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZy
YW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MzoNCj4g
LSBLZWVwIHRoZSBNTVVfVVNFUl9JRFggbWFjcm8gYmVjYXVzZSBjcHVfbW11X2luZGV4KCkgbmVl
ZHMgaXQuDQo+IC0gTGluayB0byB2MjoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1k
ZXZlbC8yMDI2MTAyNjAzMTE0NC42MzE5NjQtMS13YW5nLnllY2hhbzI1NUB6dGUuY29tLmNuLw0K
PiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBBZGp1c3QgdGhlIHBhdGNoIGRlc2NyaXB0aW9ucyBh
bmQgcmViYXNlZCBvbiByaXNjdi10by1hcHBseS5uZXh0Lg0KPiAtIExpbmsgdG8gdjE6DQo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjAxMDcxNjEzMzYxMDhSYnZnSUVK
MXB3d19mS1p0TXJlRnBAenRlLmNvbS5jbi8NCj4gDQo+IMKgdGFyZ2V0L3Jpc2N2L2NwdS5oIHwg
MiArLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUuaCBiL3RhcmdldC9yaXNjdi9jcHUu
aA0KPiBpbmRleCBiNjVkNjMxOTk0Li5hYWYxNjIzMWRlIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQv
cmlzY3YvY3B1LmgNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS5oDQo+IEBAIC0xODAsNyArMTgw
LDcgQEAgZXh0ZXJuIFJJU0NWQ1BVSW1wbGllZEV4dHNSdWxlDQo+ICpyaXNjdl9tdWx0aV9leHRf
aW1wbGllZF9ydWxlc1tdOw0KPiDCoA0KPiDCoCNkZWZpbmUgUklTQ1ZfSU1QTElFRF9FWFRTX1JV
TEVfRU5EIC0xDQo+IMKgDQo+IC0jZGVmaW5lIE1NVV9VU0VSX0lEWCAzDQo+ICsjZGVmaW5lIE1N
VV9VU0VSX0lEWCAwwqDCoCAvKiBNTVVJZHhfVSAqLw0KPiDCoA0KPiDCoCNpZiAhZGVmaW5lZChD
T05GSUdfVVNFUl9PTkxZKQ0KPiDCoCNpbmNsdWRlICJ0Y2cvcG1wLmgiDQo=

