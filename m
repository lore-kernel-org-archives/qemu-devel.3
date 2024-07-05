Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E7DC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 11:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPghk-0006OC-CE; Fri, 05 Jul 2024 07:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPghh-0006L1-6v
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 07:02:13 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPghf-0001TS-J5
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 07:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720177331; x=1751713331;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=AeMHdDD2JgrH72lseEwOWCypd9uhpcuWwFYYfigfsGk=;
 b=ADQ/qdIRjgFF9IecVshH2fFtO4G8rB0B8akKegUJEoOF58vKJHCzwzHE
 7P7DD8FeJamRQxOGOyZuCu8FB28SHPinaLUWtld68VErqhaOcSqKFMQKz
 5gpNzNJBhPfQVDhtGODYEySc3M1Algh2qw7poYdzCd+N6Q6ZBlnKc2peL
 MUd2Vbjt4can7xiG3qqRbe0ZpPfcaNQASGO4A3dSI1Sbb4MerCfCtE+eD
 Mbg/Woa/9Hgr5cXFWEuuiH6ZeAkEl8nB1miEoLUoWmgTu/K3cvZNLgncf
 N+tS2uMkT1JCUND2lTuP0pLkaud0QYSg3rK7z0qsvk6q/aCDIDeXLEee1 g==;
X-IronPort-AV: E=Sophos;i="6.09,184,1716242400"; d="scan'208";a="15949122"
X-MGA-submission: =?us-ascii?q?MDFzUaIKPWE+hRQq2wYdiXtMr4kH42e4/zidiT?=
 =?us-ascii?q?RGdoXkOJC+f+uoozUvo7eFMzpYdr2a5WfrjiRk4+I3hcyAnTIEtnHVWR?=
 =?us-ascii?q?zp+TkY8TXPDQs4x81KYojCWNeYeg14nyoRYoTIlV865qF8b0yNzL7kgn?=
 =?us-ascii?q?WT0ho3bEO7Kw7S2yXL+grn1w=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 13:01:56 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bq5zPpJwKpe4eLN8sVQMy1oOWB44QykFSKtAJFTQ3raU9MMzxHlLY+irU8nLf1yPEjJubNLfXWTfcAvpGj9Gxf+4XftO2J8RGNfhtPyeIyyOuhS0eFerhr2FMWbRXW7IiHsUa+0whziKf3zIH1WkQIkQfQ9C5vKAj4mu4OSnzo+AKoE8zrrqlZMK8I3BNOqZuyVF1LrnQ1DaGzMiL2CNEI24salImejCEZtQ7CDMeLDSi5sboBv2q8bMb/n0IoLypqjuVKyPYm073pET6MFag+pWyJ3t8B/PSnX0qvK5ulBR/3U4/eAgs9DAIgaZluXmKtM5NVSKbCjn262KOZqR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeMHdDD2JgrH72lseEwOWCypd9uhpcuWwFYYfigfsGk=;
 b=dB3KyWXhb0Z0+kEsNcncvgGnd0VGQJjbY4pqBz72h9tM017segCG5PB+BI7GlGVp/1aQRDAy91wOLPdw9bf+acOOcVMGdpuyX066vq6fnnpHg8CW5Zvo/27zHi9gyl5lGamtN0y1zGdCnxDNVkDnWMtatn0YTPQFn2aT+z3ONVkv7gUjjztkFiHF5mYXu4pIQTtzWy8dYNRoOdclSTKZZDEx3u0SMpZcLXZ8kzIZhDUPfj6QRHhV5eBCdeAWtZRJZJncXCgeWp8EC6G5YUoBGa4t8niy64TuwnPAK2wVWshwife1q1T4sXVHGdWb3VeGbnLJTHmztoKwjrTq1xo5NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeMHdDD2JgrH72lseEwOWCypd9uhpcuWwFYYfigfsGk=;
 b=EZizV10npJGeGuo+HcIUespSoWxlVydBsYY63EFx/dJbRYu3jWxI/aMPHfaUcQqvM8LMVHKfBatwNqeZ2dujkk2ucza50o6sEaG1YLARDhQ5b+gxAwNSY7ZXu/+7WG1U1svKVayYT726GcuDbiESf/BwqeBhhS7Dg58I0pRlprxCkHWi0s6U1v+kgSX68zdoCqkyF/fWmeU2jN4hAiwUmBPXlIhHw0NenXutIFIvR4OZ4KJJtrDflKJBnnpS4lcXHyRTVlZF+5BAlvmUec41WJIPhXJYgjD/hiCjRgtRnewwOYVYRi41GqLSPHKAxKI3Ig8WP3MckMcXhicHNVR0iw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7303.eurprd07.prod.outlook.com (2603:10a6:20b:259::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.11; Fri, 5 Jul
 2024 11:01:55 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 11:01:55 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v4 0/4] VT-d minor fixes
Thread-Topic: [PATCH  v4 0/4] VT-d minor fixes
Thread-Index: AQHazsq/xiSfTf87rUSQsMmkx4TMTg==
Date: Fri, 5 Jul 2024 11:01:55 +0000
Message-ID: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7303:EE_
x-ms-office365-filtering-correlation-id: e68ba930-e16c-4357-0a3e-08dc9ce1e1ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZkRjUTVoNEN1bXVYY1NrNTJLU25ma085Mkl2MjhFL0lid1lwbDd0eGswdWV5?=
 =?utf-8?B?V2NNaFRqb0JFV2tGYlZqWjJtZ2pRVDViWWhVYjZwM29ESmFqMDlxbkZkaHpS?=
 =?utf-8?B?TDRwR0FHVk91QWp0dDhYUjhPTGZGdVJGZ1JYcDJVNWhmWFd5NHlvQUhkNUlk?=
 =?utf-8?B?V0JuYjhPYXczajAvRW51ZTErOWFFVFY3MDRER2JuYVMwcm5FRU5DaGN5NGpD?=
 =?utf-8?B?T2I5SnpvZU44TC8yS1cyaThPdldZZUowWStyMjhCUlZvdEIza3JiRE5sUHVj?=
 =?utf-8?B?cmttTU1DOGVxNHBFQytMMXJuakFqMjMyeE5SRDAyNmFBczZKUVUvUGVyN3po?=
 =?utf-8?B?VUZRanFES0gwaTRPWkV1Yko0bTVpd2RyVC9oV2l5NWhVMTBMZlcvckNnazRt?=
 =?utf-8?B?SmltZ2FteHZiVUtWWmtNK1ZNY0M0Y0lPWEo3WjkzWUNNNElJejdnTzFDU3Ni?=
 =?utf-8?B?UFBYL1hMK2h3cjZTdktJN1B4WEFOb0ZKeE9wbk9VeXBRbHJERzNudEdMOE55?=
 =?utf-8?B?NHlYWksvcENMZ1oxRjFadDlWczRIYUZ1bnZ1cUlXVUZsblFxR2RrZjhEOXBU?=
 =?utf-8?B?NDUvY0tJeFVvR080QVBxWXcrNUJvZEI4ZUdONUZuV1dta1Rka3pjU240cVhy?=
 =?utf-8?B?VGEzb0ZOOHRaNEdaKzF6K01rdFNNWEI1NEgzeUFjQmFVRzVDRXNvbGJvWXJh?=
 =?utf-8?B?ZkhOSzRsaEVBZllhcW1WVi9lbVVCYm52UUJHenB1NmlpcFgzR21TMUttdE5a?=
 =?utf-8?B?ckpNeWN5dmV4ajlYcmZ1d2tZTXBTN1h0ek1wWVM3SmtsTks4YW1lWldHMmhB?=
 =?utf-8?B?elRiRE5DMTkvVHRIUktwUktQVGgzZC9rVGNZR3VNR0tFY1FjWjliKzlWL2ZT?=
 =?utf-8?B?cnZjVnhIRlBhdjNmdG55SGVyY0VqNWNIRmlZZk51VU9TNTF4c2ptM2V6Y3dV?=
 =?utf-8?B?WFpQZE5VT3BvNEdYalRQbFJUOEFhR1k1VGtYaFNqOHFUTVRTRE9rQ2x4Y2NN?=
 =?utf-8?B?YUlOS20vYXV1SHQyNXFFYjlDOE5ZSndkRm4zeTE4ZkxmWUVNUytqZ0l4akVx?=
 =?utf-8?B?S3dJV1M5TXMrUFRIQkZ0YkRmVmRucW9VYU9zUWZQMUNYbTlhdDRlNmpxQ2FJ?=
 =?utf-8?B?c2E3V3RzbXV4cStKMXl3cmp1V3JNc1o5MUFyeTlRdEJUNVR6Q0QvWVlobnRF?=
 =?utf-8?B?d24xb0p1bDdxZlVGVjFHeVRxYjBaNCtJRWROUkFmWmZJeXpMQWdDcGVGVjNU?=
 =?utf-8?B?bXZHTnFsd0xCUmZRbjNNdk5aNHU4c2JBOVR0SUFLdW5YVGpYZUJDYXVJRm9q?=
 =?utf-8?B?WGRGTTJVN2dHQVJHdDFQZlMxL2cyaDhaRGk0OEFiSmRvMVd6ZFBzRWlJdi8v?=
 =?utf-8?B?N0w5OVlUcnVTZW1WTnZqdkszNGpWeEg0ekowUzhWVlZOYzNJK3N4Y2dhTHBM?=
 =?utf-8?B?TytwVEE1Z2pseEUySjJjVFc0UFJXQmFlQ3lkL1p0ZHhwaURBT1dNYVpKMDJT?=
 =?utf-8?B?VUorR0dYWFhnUCtvd1BHcjV3Zld0ZmZQWnMzS2hzekFYWStNSUFraFp5TnM4?=
 =?utf-8?B?dmdMSEw3d0FFNmhacmVoYVRncDRDOGdGWEo2aDVUK1JmTXQwL3lFNUkxa21F?=
 =?utf-8?B?c0xGeng1YUNnRDdJK3l3eWNScDRKdXFSb0doSXByQkw0WFBKSUVidTczSitv?=
 =?utf-8?B?c0hhTWgrUnZ6aGE3NEI0VlBHMGxlZWlOaTVKVFJtSXNFQmR4b1g1Qi8wLzlS?=
 =?utf-8?B?aXJ4N2xjUnNORHlZQk5SYzNqcnBCODNLSUtPNHBlTXZsV2RVYllEWllIUktX?=
 =?utf-8?B?WW1TUHlOQjl3NGpFVjFYM01hU2Q4cThDazBmVUFmVnR4cHB5YlRUaFd6eEpu?=
 =?utf-8?B?RWRFc2V6RTF2U3Y2bkVXbXNLZXN1Sy9nL21CRVBJMkQ4Z1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0ovWG1zM0FnWGYxc1NUa09iUmxXWFJIaTIzSGkwWW9LeUZrWkJvZVV2dXgx?=
 =?utf-8?B?ZWNxYlRXQTVBUVptb3RhYjg3Y1hiVWphRUdPL1FPNEtHelpoMkltMDdSNkxo?=
 =?utf-8?B?U3pLZloraFBEL21CSU1EYkRjT2t3N3MyZ2dSLzJqMk9zRVNhQUFIRnVrcW9r?=
 =?utf-8?B?WlFxY25idVRGcVhZMThmc09iUnFxQkpDN3BGdEF2YmNCMTRaRnJkaTR1TEI3?=
 =?utf-8?B?NlZ3Nm1xR3J4VkI1VytoMUdKNUp2TGFxOGpESU9UYWlWaDYray9ZMzhnTXpQ?=
 =?utf-8?B?dTJIT2x6a0FieTVKWVNvdTZucGJJTEU3WHpqUkYrb1pMMkN3YUNoWGwvTGVa?=
 =?utf-8?B?VVl6QjNtYnZSMkJjVlh5c3BJVkRhUXJUQmtxZ1VUL0NmNDZIV2s4R29XYVpZ?=
 =?utf-8?B?anBpb255d01DaXNaL1JkeGJ4ZmFJWi84RlFCTnNaOEdNajJpUW1PcVcyc3FQ?=
 =?utf-8?B?aEcwS1VKSzJHZFUwdGRrVFpsaVJVeG5Jcld3LzZvM1hXczA4di9aczdiSHAy?=
 =?utf-8?B?QWVkMFAzK29DaEU5TVhiTkVtWWI5Q2QwcGsxZzUrNmFNbTVESjdBQUxFL2ZS?=
 =?utf-8?B?OFdLWWE0NWJ1eERJN3hIaDdpb2pLYjBGVWcyd1lDeUFHRUx1UWZ0Nk44UW9n?=
 =?utf-8?B?ZTlIQnk4M2F6ckFITXd5dittajNXZXk3MGdRcWZ4RnRBN0NqeVJrVm9ORHVH?=
 =?utf-8?B?OHRNb2p5Z1dNUlFDQmF4aldma0lHalpmRnVaRUFKbEJVVC9pTUpRUm12V0Za?=
 =?utf-8?B?YlczY0lSTmt6ZzJsSTJWN1hGY05ZS3RBZkcvQUpvL0k0VFJUeGtNd3liYzhZ?=
 =?utf-8?B?aDlsdzZiQ1VwZ2xUWHI2RGttRVVkR3dRT3pqVHV1TURwaXZBaTk5NDErWEdL?=
 =?utf-8?B?ODM1M21JQmhBR1Z1RE5LYWRERkVqMVJiZ3RBMTQ5QzFjOEhwbWxQOW91VXgx?=
 =?utf-8?B?bjdML1V6ZVFOOWlhVGIyUmpteUJOMlBxL1REMytRUVUvMUY2VXV5bWVRN29P?=
 =?utf-8?B?OW0wTSs1LzVrRG1uVFRQeGJtUkdLQTl4M09zWVppVGhPZThNNlBWMG14OHI5?=
 =?utf-8?B?Znd5dFBmaGZ3YzZKdkpCWndQTWJvbkVyeGF3bEtpR2dBa1ZUbWc5SE1MMnFt?=
 =?utf-8?B?d2JvM0tRNndnV0hGKzdJanFCdlFxYThyU3NUTm4xeWNpVi91ckYrMnY3cGdn?=
 =?utf-8?B?bDRyNnFQRFNBODZ2c0d0OWl5cUFwN2VEdEtUSVB1WnE3bDRqYkV5dVJiakFT?=
 =?utf-8?B?SjZiNU9IekZOS3dPT2ZOY1hJbDJuRit4VElaODQ3amZJc1B0T3BCMFJGRDlQ?=
 =?utf-8?B?ekJrcDlXV201empvTWlkcURDKzF6RzFyT1RCOTlVMk50ZHVPMFlwSm4yRlow?=
 =?utf-8?B?dzFSTmFndmQwZ0lRUE5VQUQ0dGpzSkFKNytpcTZkRFlIdmI4SzY1R1Iwdk1n?=
 =?utf-8?B?c1BrQ0Jyb3JzdmFBcHYyd2NWTXVVTHNRMGtSY2pDeWtSL1psUmJiN2sycHp1?=
 =?utf-8?B?dGVrV0NpQlVqZG0xV2ZYS3NtMGR4SllQQUoycEdJOTVwaTV0SytPZ08vdlFN?=
 =?utf-8?B?eElvN0tvSlZWNEhoaEpjSzhWanJMc3EzNGNoRHU1UGhEeTc5b0RyQzlqejFL?=
 =?utf-8?B?MkEzV1hFMjErOGpZWFExSlVoY2J3MlJsOFdJa2NWTk51SFY1enlRYU5SR0to?=
 =?utf-8?B?cFBlRjcrK3F0eWJZZFpCWTQrWjMxVTJzL2VkR1IvZW1VRVBwbXBrbUp5U2ty?=
 =?utf-8?B?T1VwdTR3K0NlMTI1RW5lYkxyKzE1U0IxYnp5Wnc5RFR4eVA0b1pyQWdqV25w?=
 =?utf-8?B?UnkwTW9zN2x0bWk1c2VtMXRtVk9TSDFFbkFZV1dXKy9rcnJnTHJ5TVFObWxH?=
 =?utf-8?B?bUV3eFJoRmhjTmQrckFGU1N3eS9IYWVNNWJHcDc1cEJMWTFwVjBnUk9IaWNT?=
 =?utf-8?B?TUkzTzFTbDhEZVJVd1FZVktndXJreWJkeDl3TVFPTHZsVk9pcXVRN3BtQzY3?=
 =?utf-8?B?aWpJcG9jRUd3cFYzcmhXU1cxcHp4NU1aQjRSRktQTTRaVVNJYUJ2QmRqSXpK?=
 =?utf-8?B?MTh2RmQ0bCtGVGpBUnZBNzhldWhxVzV2NnZ2RitpbExSazhyZDJ0UkZ0RVNz?=
 =?utf-8?B?cmhYN0lxTGtiaHNVNVQzWVRZdG1UTk1rSDIvZDZSRVIyTW1ZMWJOQXU0dlNX?=
 =?utf-8?Q?KyOrRjvrUhexUmQJT/cRPm0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB5C15125C7F004D812DCE733C4B3FC5@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68ba930-e16c-4357-0a3e-08dc9ce1e1ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 11:01:55.1268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZX+M/pJvSAZH/UCjUYpURC6gc2i/hRxjCqu6WcsHY/ecLtFf5jEtrcqV8cjgOjL+2GhB/2zzNQPWzCr13RlZ2OGQOv6R+clkc0bcGYzpuNKerGL/A+1iFQGtGG5PJxs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7303
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClZhcmlvdXMgZml4ZXMgZm9yIFZULWQNCg0KVGhpcyBzZXJpZXMgY29udGFpbnMg
Zml4ZXMgdGhhdCB3aWxsIGJlIG5lY2Vzc2FyeQ0Kd2hlbiBhZGRpbmcgaW4tZ3Vlc3QgKGZ1bGx5
IGVtdWxhdGVkKSBTVk0gc3VwcG9ydC4NCg0KdjQNCiAgICAtIE1vdmUgZGVjbGFyYXRpb25zIG9m
IFZURF9GUkNEX1BWIGFuZCBWVERfRlJDRF9QUA0KICAgIC0gaW50ZWxfaW9tbXU6IG1ha2UgdHlw
ZXMgbWF0Y2g6DQogICAgCS0gZWRpdCBjb21taXQgbWVzc2FnZSB0byBleHBsYWluIHRoYXQgd2Ug
YXJlIG5vdCBmaXhpbmcgYSBidWcNCiAgICAtIGludGVsX2lvbW11OiBmaXggdHlwZSBvZiB0aGUg
bWFzayBmaWVsZCBpbiBWVERJT1RMQlBhZ2VJbnZJbmZvDQogICAgCS0gZWRpdCBjb21taXQgbWVz
c2FnZQ0KDQp2Mw0KICAgIEZSQ0QgY29uc3RydWN0aW9uIG1hY3JvIDoNCiAgICAJLSBMb25nZXIg
c2hhMSBmb3IgdGhlICdGaXhlcycgdGFnDQogICAgCS0gQWRkICcuJyBhdCB0aGUgZW5kIG9mIHRo
ZSBzZW50ZW5jZQ0KICAgIA0KICAgIE1ha2UgdHlwZXMgbWF0Y2ggOg0KICAgIAktIFNwbGl0IGlu
dG8gMiBwYXRjaGVzIChvbmUgZm9yIHRoZSBmaXggYW5kIG9uZSBmb3IgdHlwZSBtYXRjaGluZykN
CiAgICANCiAgICBSZW1vdmUgcGF0Y2ggZm9yIHdhaXQgZGVzY3JpcHRvciBoYW5kbGluZyAod2ls
bCBiZSBpbiB0aGUgUFJJIHNlcmllcykNCg0KdjINCiAgICBNYWtlIGNvbW1pdCBhdXRob3IgY29u
c2lzdGVudA0KDQoNCg0KQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiAoNCk6DQogIGludGVsX2lvbW11
OiBmaXggRlJDRCBjb25zdHJ1Y3Rpb24gbWFjcm8NCiAgaW50ZWxfaW9tbXU6IG1vdmUgVlREX0ZS
Q0RfUFYgYW5kIFZURF9GUkNEX1BQIGRlY2xhcmF0aW9ucw0KICBpbnRlbF9pb21tdTogZml4IHR5
cGUgb2YgdGhlIG1hc2sgZmllbGQgaW4gVlRESU9UTEJQYWdlSW52SW5mbw0KICBpbnRlbF9pb21t
dTogbWFrZSB0eXBlcyBtYXRjaA0KDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwg
MiArLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDYgKysrLS0tDQogMiBmaWxl
cyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi40NS4y
DQo=

