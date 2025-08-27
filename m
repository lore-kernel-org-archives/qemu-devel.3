Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D37C8303F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 05:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur8xI-0008Hu-DR; Wed, 27 Aug 2025 01:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ur8xG-0008HW-By
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 01:44:18 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ur8xC-0007S4-12
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 01:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1756273454; x=1787809454;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=suduNYsyvDUOMo8xm9EkT84RXBE+1+YmIqt89bbL0vM=;
 b=w2ON6bHvVQVBGtDt5xjXM14CX4g7Pn9qQN6XxniMpt0GTS6WiglXcFru
 apnKT/OmQ3HnyQW9ImvN27zvDEzdGbnokCf1uU73+q12bw6JyMlM79Kkc
 azIX4i/icEC2C4BV00fDhTZ0EFIsLCat+AmQ7uTQXCn6yaE24bxVV8KyD
 4rDVjgxMaWne2hyxZJISMqKmziS2NoWdxbcildjB+ZI4CJAZXUVaUg2Wr
 cgoDmiuHCgqGLxCf1RdGrRR5HX0+dIvzLqDATZ7xtt8hCkwB3FiswOaGl
 opkB/nEP93fSO6uq/W4k50sq5QFo8HdfYvD4rBvvORsvHVcVj6iWw2czF w==;
X-CSE-ConnectionGUID: Z8ohlulXQ0qy75AcF3rO9A==
X-CSE-MsgGUID: rBnzCjB5RoyLGlabcy4oSw==
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; d="scan'208";a="42364631"
X-MGA-submission: =?us-ascii?q?MDE4bPCQagviJ1473PeUzBZ+LW8T3cuBwA6IKl?=
 =?us-ascii?q?qWNtRG+gsHciZdmvhv3GMhMwbc6JrR2rk3Oo42nzY22A3ihRMkFhAhqE?=
 =?us-ascii?q?Ok8q8UOuMNghiDjNRO8eVfDXZJ1QjP5e039183w4eZuCrI/7lO1N0Bfh?=
 =?us-ascii?q?8Hj79nnplt2HxCZdeyH38tWg=3D=3D?=
Received: from mail-northeuropeazon11011020.outbound.protection.outlook.com
 (HELO DU2PR03CU002.outbound.protection.outlook.com) ([52.101.65.20])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Aug 2025 07:44:08 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhrBSw7AEoTqIZY0+swFvVCzahLuasTRHfp/s08oSSn5mVzxArUdglXgv+jqzTtZYP4PpKmDI0yyRGm+Vip/MqYDvfYGW1E/CwjSkcwJ9Zsj7ZNo3imJK+NNsIyMQKjdootmL5SjR0DPm5WGklZV+7AKXLBTtp2iy1Gsy7qt98LIwnfD5UY/8sw0xyONLD9Y4ojXYI64Z+Dplu8F4q3tLPgFbLxdHnQG2Pj/gAxmyRrWzit//G8oUwye+pApKmdxGjCGlw3/xvZwY9GsSabROT29mADaRTrm3pWdGJ3g9CgohQsFc0mbLYmIk+KBuGy0/5a3LDGnHVeX80ubeR0W0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suduNYsyvDUOMo8xm9EkT84RXBE+1+YmIqt89bbL0vM=;
 b=DuKXhUvDucnHNZqJEHD2lOQyB7nGbqx9/th4uXA9FprYRn5RHGQN8IezqrerP+0utLuF65C5opBgxbwebwqyUDb+JB8eacv+2P+9UNzGc1TC/72muWqkmDd8DSOPqWi9hylqW37yKe9LSyY5wCok7SqQA59KjYHVlg/UL/kGjyb6zaASyGz80Q7rGCSJ1TmdGv1UU603wj7G83D75cnvRY5Husgv/GCdXO5tMC9ko9xvQI0EM50uHYBgLf/B81pSxll2hQtwz6bm/vmykPnwnZKnlSNMfkWldT1PuNYfiZIO/0PSRT+Lxm2abDLBn/UBKYXPzUw1PucPh9MPalnn/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suduNYsyvDUOMo8xm9EkT84RXBE+1+YmIqt89bbL0vM=;
 b=SYrAG61IG4Fg4bHg21NWyYXvFn8daIJJvyGxUcMDpghN5ljS6ifnAlvW2mDuxLP9BmMooLa9Dzpw2DbyPq5+as11nQOgF/mhub1mozI+0+29zTFkiSHw9NnY/IfeQZpSx/SvdR3MtcdecTptHEGs335/S6w+G/6lV/o6IewxOgBZvL4QhHS9qiTc5S9oMP2fYTjJh2xn9P3NO7zmCJijn47qyv/8/lsCApSXwqG9qJ80riw71CFYZpAzXQ5h032sYx+krejaiPaiV2EYPe4Dh1n5WNUWdF7BF43wfW7ZHFNSqG157GiYb568MjVILcKwUEwBCK1WR1Meooe8fKWF/w==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GV1PR07MB9141.eurprd07.prod.outlook.com (2603:10a6:150:a7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 05:44:01 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 05:44:01 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, David
 Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Akihiko
 Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] memory: Fix leaks due to owner-shared MRs circular
 references
Thread-Topic: [PATCH] memory: Fix leaks due to owner-shared MRs circular
 references
Thread-Index: AQHcFxWXHA6d0vvlrkCTgt0aVNoM1g==
Date: Wed, 27 Aug 2025 05:44:01 +0000
Message-ID: <701c6352f101e224bb79f41984957cd4d1d62b69.camel@eviden.com>
References: <20250826221750.285242-1-peterx@redhat.com>
In-Reply-To: <20250826221750.285242-1-peterx@redhat.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GV1PR07MB9141:EE_
x-ms-office365-filtering-correlation-id: 3be7d09b-6d27-41df-48be-08dde52cb9d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SkFmVjlLUWQ3TS9hdWxIMk04NERVY1FaOFMzU2czWiszT3h5MlYrVGh6b1BQ?=
 =?utf-8?B?bTFCc3NPQStCdkh0QjJ2dTNSdHhnM05UT3ZvcjdHMW9TWHhiV3F1UENCWXNk?=
 =?utf-8?B?TnMvVE94aGczb1p4WW1OdytJZDJUeHJ0SzRhUHN6OUNaaTNkQWFrRWtLZC9o?=
 =?utf-8?B?SEZYdWhYWE9PSHdMSG9sMmNmNVVUd0l6aHRaUHY0VWFqeWdTY3lFNCtBNXJ4?=
 =?utf-8?B?VXdIb2JZRHVlblNHVlVheEpzR3ZjaFFhNmk3Z04rS0ZScmJ1WG1Ldm1rL0pY?=
 =?utf-8?B?NXYwT0pXSEZuRWVuNmZKV092eTZkNnhLSnBodlFJNkhENGVXTUp6OWhtNjE2?=
 =?utf-8?B?RHpuOUs2NFRCZVd4ekVka2lxNzlYSHVka052Qmt4UkRieitiblp4T0cvYVVI?=
 =?utf-8?B?SVdvdENRSTkwN0hsamsyUG5TaUVGZGllOVFVS0FaZ3daSjlENmtDd2VoQU1q?=
 =?utf-8?B?aHMxSzNBSjQvejBYc3JOU1psWE02bDFSc04yU2xxUGkydmJiZktPZC9yU3RX?=
 =?utf-8?B?NGxUd2NDL2tlWUNubEozWXlWL21uUCtKU1E3TDJuRUVQWmV0YXg3b1hsK0l5?=
 =?utf-8?B?UVhmdHExMCtpRXRyWGlRQldBZE1vdW9MN2lZRmZIY3FCa2poVkJ1YUx3bEZZ?=
 =?utf-8?B?QzZnLzlXT0I1VmI5ejdHK2V3cllUMmluZUtPMmt3Q2o4dm5UcVZvL1NPM1dE?=
 =?utf-8?B?aWhqL1VZK2I5LzZzWUhOVno1c3VWQ29CODVBUU9iRzhnaDhGQzdlVE9mL1kz?=
 =?utf-8?B?c0NNUytXM01ONVgvR3B5UDArNEVlM3pjSmkreTU1OXA3WGsxMFBGaWIvN1RZ?=
 =?utf-8?B?RmY4ZjU1dWRlM2hYVjhhUTZ0a1kxcmlUdzVzZ0trTzRaY0ZMMEp2ZU9vZGtX?=
 =?utf-8?B?ZjhEV3pJWFlMRCswSDJ6QXJxQitsclNIVU1UV1laWlpwczVUTkZXSmFOMUd0?=
 =?utf-8?B?K2lYVTlOUHRLUk15cVBzVTJINk9JU0hWZ1N0K3RrK3BIb0ttTlV0NTN1Nllq?=
 =?utf-8?B?ZFNoOUdQV3duc0haeS9wODNlOHQrZFpHOVpCcHpUdDdOUlM3NWU1M2YzdWhX?=
 =?utf-8?B?dkJrZDlqdG1QTHMxeHdwZU5qY3pNYUxMNkxWbEp4RWtPNVVUWkpkbEZ3SmdQ?=
 =?utf-8?B?SlVnTCtFS1h6N25vWnFMQTc3SkRWVXZtUUpMSzR0VTRYb05FSTgwZTlxY0pX?=
 =?utf-8?B?L1Bydm9lZmNFSnJqQlRvRDJKenYvK1BGTHlkRk0wTlBtbEJJS3R2SEtFdUl1?=
 =?utf-8?B?M3NkekdNemtlZ1lpb1Y1dzErL09UUW9ya0NrUyt2ckFMYmNNeGZTUDgreDFD?=
 =?utf-8?B?UGVwRk1ldndSbVBzYjB5V3EwdHM1SkVZeGluaUZ5WHdXQjQ4SWY0RXIwQmZV?=
 =?utf-8?B?T3JHY1ZJbmV2U2JzMEZVRGZwYWhnM2s1RXc3Ylpvb2xQT2hFNFhqV3FlK2w5?=
 =?utf-8?B?cTM1dGdWRU4zVGFFVFFWZHNmaWdjME5BSFFndHl0Q3QwT3JKTjhaNzdCOVV5?=
 =?utf-8?B?UmRjQnNNZkpVTUxPZjlUeGNQa0dTQ0RHTVErZ3JBMVRwSmx4dm53a1REZk5k?=
 =?utf-8?B?VVJsZDk1Rmg0NGI2c3JuaVFEdGY3dERoYW1UVEhtVG8zb2FxOVFYbkxWQU1y?=
 =?utf-8?B?WEdjOFBvYlJDRU93cjFpc21HNEtlZUNsU0Q1UWZDdksxVVV5bmNubENITElP?=
 =?utf-8?B?dHhxOG9xOHVEQ0VFci9iYklyUk92Vjh0UmkwVVJTcFFYSHRyWmJCMHM0amQ1?=
 =?utf-8?B?ZXNRUDlrNUluQ1lmWVcvUWdwS0RjTDVLZ0E3Z1ZRSjRLNmgrNjZ0ZG5Oa3Rh?=
 =?utf-8?B?aEJ1T3QxOTNIU3puckJyeEVhS2NYMzBJTzdIbC9NRXg3bGllL3lXOFBDSE5x?=
 =?utf-8?B?ckdaNWYvNGtTT25oSzNBdW5lQXB1UGpxQ3VyREFRRitwUWx3N1VaT1Y3Tk40?=
 =?utf-8?B?SjJHdTlhQ0RhOTlERHltRzNTSlB0VFphSytOa05vVEZFMDdjVkQ5WHJnS3kx?=
 =?utf-8?Q?0qH8wBGX3DfhxZQ18jQFBNBjJpl9KA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzU2bzAzcUgyc1ROSmV0MDY2bHBuY2hCd1dtSVdxdG5qbHVjSWxaVVI5TDUv?=
 =?utf-8?B?cnUxeVFBOUhheG5yZDJVNDcvZTRsN1hqOXlLekpNNWZxK0I2L0FoQitOZHpU?=
 =?utf-8?B?b0FqMkYxdTh1NG1USk84VTN4SHZ3WnNiNnBJdlhiSFU1bXA5VVhzSEJEazg3?=
 =?utf-8?B?bU9ORWxzY20wTlFCcGFjaDR2L3dkSzhyY0RCRW9zSW5DYXBxd3V1L1djand5?=
 =?utf-8?B?QzQwaVEvaGJPZEh5azNJNTI0aUFyWXNNT3Z4TjRBY3NIVjlBVXNFSTBvN2tG?=
 =?utf-8?B?Umt4ZE03YkdxMkxNbFVpb2VwSXo2S1FwVm9CQ0xQWUcyQk1CZ3BsQUhNSGc2?=
 =?utf-8?B?d3dmc0ZKeUdKRW5RcENYUUN6RFl4VVg0QlBSeU9YNWYzVDhyWVUxaHYxUStH?=
 =?utf-8?B?MmdkTTZGTXQvUDZYM3c4bC9FZERIVnBROTY2UGg0SVROc2kyMWRYZGRQTW15?=
 =?utf-8?B?aXBXZDRMVVMzcXlZMzdVMUVLSHd1Wm9KM1I4dEJnRnB3MW1RMml6Zm8xdVA5?=
 =?utf-8?B?ZTQ4eEQyUkNrL1p3cDBCdGJoYVdhcWRoeGx3dnFyODZnNkg3cFpqQnZDM3J1?=
 =?utf-8?B?SVhFMEpwRzh0ZWFqUys2NkxRNHFkWVhwYktoanYvZjBQQ292YUt1c2FoYi84?=
 =?utf-8?B?WS9MU2VYKzBrYnlNN2Y5eWNTUTI1bGVRMzU1MFJLbkRJTGJmVzY1OTMzSE5Y?=
 =?utf-8?B?MkFsWmlsZ053ZTRiVGtSU0JEMU9iZlp1Q1NEcnlTdDFhcXdGNGVnbURMclJs?=
 =?utf-8?B?UHVhc3Rzb1BpSVNRemJONUhiYmQ0Tm5wa3lsNHdKVzBnUVVTRG1YakZ4Ylds?=
 =?utf-8?B?cGdxZHZGTUUvTWtKUTVwUmpMWGtma3R6Z2dCOXpVdnBGQ2FYc2ZHSjM2dHht?=
 =?utf-8?B?bzdkVU5EckFRRzZ6OXlBSVFCK0RONE9maWptbElySDVqb3B4QXVSbVpabUZo?=
 =?utf-8?B?K0RFT25jMS9qTVdNUDhaMTdkY2RDMGJ3YkJ0VUFLNWRFOFg0dEMzTHhhaFNM?=
 =?utf-8?B?cFZVYllKTUs0ZE5SMkNZZFd0c0hzR2RJekt3MUxJczJRMENLZCtxQkczcFFZ?=
 =?utf-8?B?YmIyTUJlS3NYdFhobFZXTjBMWUYrZW1FenhZd3FaU0gzVHU3RlNoM1VBcExB?=
 =?utf-8?B?bVNSdnA5c0VxQ3dLVnd2c0lidytjV2lpdUlWS1dXUDFTT1RDYWZlWUZpNVUx?=
 =?utf-8?B?QU9GKzJ3NEk2TU1RQ2twVUhKQWFTU21JeEtnaGFYNEJtU3pRQUZ5R1BBZ2xY?=
 =?utf-8?B?ZW1GcFF0QW1HNGVZZjh1VVd3Z255ajgwakVvbXE5Qlg2bWpYYU0rejU5OFRE?=
 =?utf-8?B?YnhoWFB3dzg4L2FzVlR6aVE5bmJPNFpGTnpVM1UxWlB0TjZLaDFIOXQvVHRz?=
 =?utf-8?B?OURaZWtNZGlhSnp4WThxUDd3YjlSemw1M0crQVRTdy9HSzJUSDRhUUkzanhF?=
 =?utf-8?B?TUUwL0FZcDdvTFQ3eXRWblIwNEEreUE1UktTY1N4dFYwdWR6b2czZmtHeHBO?=
 =?utf-8?B?NCtWeVhuZUttWFExcHlPejBCb3RRUVVQZ3Z3OXBqRDNwNG9xOUs1ZHp3Mks3?=
 =?utf-8?B?dGEzNG5rNzRjaW1LRlQ1NW9RN2tUQUtRM2w3bjhDNWk0QkVJVEZ1SHl4bmt6?=
 =?utf-8?B?SmRMRmkxcnZkSXdRM0szbVo4R3ZkM25mcEE1NFQrUzFWNENrMmorb0hHYmYr?=
 =?utf-8?B?Vno3L2xhS0VaS0d4RXFqQlBjVWRTR3RaMERkaExVMGpJbWRPU3djVnMyOTc4?=
 =?utf-8?B?VEhnY0Z6NzFJODFCTmduSlY1S3A3V3U5ZzNpaGs4TFdkMVBmaExuVk5hYkhN?=
 =?utf-8?B?cGtnZHphOTc4dzFhK2dZZUlnN2NYZGF4dUZrRnh0b2kwazRwcmN1QytoaUZi?=
 =?utf-8?B?cGorckFDSjVxNXlCZXBycDBFSjFMbmFqWTU2ZSt1eFo5aVJkM2lPdzN5T05V?=
 =?utf-8?B?ZmwyaS9XcUtxaWw1YzVSZ2dheTBGNzZhcHpXbzN4L2kvbEI0ZnlLZk1FK0ZL?=
 =?utf-8?B?cnRjVHRXMmhOQzRBNjJJaFhyMEZzN1dRT0VWUzROY3ZrdmwrYnMzWFo3djl0?=
 =?utf-8?B?R20vTHR3dmFkQVdnaFNjdXhrZVNZUTBnbnBPQkFVNDdLM3JkZGZ6eEdkbDdj?=
 =?utf-8?B?VmJaOXM1VWt6R0Z3WEpNQ204TDlhS3J4N1R1d1o4USs5M1I3QTNNakhkZTN1?=
 =?utf-8?Q?GxQBF1Yg29fwqwQgUECzxNI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <993D9CD46B28514A8B5829A00C2EDF05@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be7d09b-6d27-41df-48be-08dde52cb9d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 05:44:01.5106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JAxUeLFMoNbybPVzHK81eEGAg9EEPJ7AwMskDR/tkW2U1fZ2RVgq1F668JmfXLPTvI1Wi3k+2/QnTIT/dUjAH5pcWt/wyvF3EzUAdm/9uhWSBgdwG5nsCnpT+gsG9ajz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB9141
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

T24gVHVlLCAyMDI1LTA4LTI2IGF0IDE4OjE3IC0wNDAwLCBQZXRlciBYdSB3cm90ZToNCj4gQ3Vy
cmVudGx5LCBRRU1VIHJlZmNvdW50cyB0aGUgTVIgYnkgYWx3YXlzIHRha2luZyBpdCBmcm9tIHRo
ZSBvd25lci4NCj4gDQo+IEl0J3MgY29tbW9uIHRoYXQgb25lIG9iamVjdCB3aWxsIGhhdmUgbXVs
dGlwbGUgTVIgb2JqZWN0cyBlbWJlZGVkIGluIHRoZSAgDQo+IG9iamVjdCBpdHNlbGYuwqAgQWxs
IHRoZSBNUnMgaW4gdGhpcyBjYXNlIHNoYXJlIHRoZSBzYW1lIGxpZmVzcGFuIG9mIHRoZSAgDQo+
IG93bmVyIG9iamVjdC4NCj4gDQo+IEl0J3MgYWxzbyBjb21tb24gdGhhdCBpbiB0aGUgaW5zdGFu
Y2VfaW5pdCgpIG9mIGFuIG9iamVjdCwgTVIgQSBjYW4gYmUgYSAgDQo+IGNvbnRhaW5lciBvZiBN
UiBCLCBDLCBELCBieSB1c2luZyBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24qKCkgc2V0IG9m
ICANCj4gbWVtb3J5IHJlZ2lvbiBBUElzLg0KPiANCj4gTm93IHdlIGhhdmUgYSBjaXJjdWxhciBy
ZWZlcmVuY2UgaXNzdWUsIGFzIHdoZW4gYWRkaW5nIHN1YnJlZ2lvbnMgZm9yIE1SIEEsICANCj4g
d2UgZXNzZW50aWFsbHkgaW5jcmVtZW50ZWQgdGhlIG93bmVyJ3MgcmVmY291bnQgd2l0aGluIHRo
ZSBpbnN0YW5jZV9pbml0KCksICANCj4gbWVhbmluZyB0aGUgb2JqZWN0IHdpbGwgYmUgc2VsZi1i
b29zdGVkIGFuZCBpdHMgcmVmY291bnQgY2FuIG5ldmVyIGdvIGRvd24gIA0KPiB0byB6ZXJvIGlm
IHRoZSBNUnMgd29uJ3QgZ2V0IGRldGFjaGVkIHByb3Blcmx5IGJlZm9yZSBvYmplY3QncyBmaW5h
bGl6ZSgpLg0KPiANCj4gRGVsZXRlIHN1YnJlZ2lvbnMgd2l0aGluIG9iamVjdCdzIGZpbmFsaXpl
KCkgd29uJ3Qgd29yayBlaXRoZXIsIGJlY2F1c2UgIA0KPiBmaW5hbGl6ZSgpIHdpbGwgYmUgaW52
b2tlZCBvbmx5IGlmIHRoZSByZWZjb3VudCBnb2VzIHRvIHplcm8gZmlyc3QuwqAgV2hhdCAgDQo+
IGlzIHdvcnNlLCBvYmplY3RfZmluYWxpemUoKSB3aWxsIGRvIG9iamVjdF9wcm9wZXJ0eV9kZWxf
YWxsKCkgZmlyc3QgYmVmb3JlICANCj4gb2JqZWN0X2RlaW5pdCgpLsKgIFNpbmNlIGVtYmVkZWQg
TVJzIHdpbGwgYmUgcHJvcGVydGllcyBvZiB0aGUgb3duZXIgb2JqZWN0LCAgDQo+IGl0IG1lYW5z
IHRoZXknbGwgYmUgZnJlZWQgX2JlZm9yZV8gdGhlIG93bmVyJ3MgZmluYWxpemUoKS4NCj4gDQo+
IFRvIGZpeCB0aGF0LCB0ZWFjaCBtZW1vcnkgQVBJIHRvIHN0b3AgcmVmY291bnQgb24gTVJzIHRo
YXQgc2hhcmUgdGhlIHNhbWUgIA0KPiBvd25lci7CoCBCZWNhdXNlIGlmIHRoZXkgc2hhcmUgdGhl
IGxpZmVjeWNsZSBvZiB0aGUgb3duZXIsIHRoZW4gdGhleSBzaGFyZSAgDQo+IHRoZSBzYW1lIGxp
ZmVjeWNsZSBiZXR3ZWVuIHRoZW1zZWx2ZXMsIGhlbmNlIHRoZSByZWZjb3VudCBkb2Vzbid0IGhl
bHAgYnV0ICANCj4gb25seSBpbnRyb2R1Y2UgdHJvdWJsZXMuDQo+IA0KPiBNZWFud2hpbGUsIGFs
bG93IGF1dG8tZGV0YWNobWVudHMgb2YgTVJzIGR1cmluZyBmaW5hbGl6ZSgpIG9mIE1ScyBldmVu
ICANCj4gYWdhaW5zdCBpdHMgY29udGFpbmVyLCBhcyBsb25nIGFzIHRoZXkgYmVsb25nIHRvIHRo
ZSBzYW1lIG93bmVyLg0KPiANCj4gVGhlIGxhdHRlciBpcyBuZWVkZWQgYmVjYXVzZSBub3cgaXQn
cyBwb3NzaWJsZSB0byBoYXZlIE1ScycgZmluYWxpemUoKSAgDQo+IGhhcHBlbiBpbiBhbnkgb3Jk
ZXIgd2hlbiB0aGV5IHNoYXJlIHRoZSBzYW1lIGxpZmVzcGFuIHdpdGggYSBzYW1lIG93bmVyLiAg
DQo+IEluIHRoaXMgY2FzZSwgd2Ugc2hvdWxkIGFsbG93IGZpbmFsaXplKCkgdG8gaGFwcGVuIGlu
IGFueSBvcmRlciBvZiBlaXRoZXIgIA0KPiB0aGUgcGFyZW50IG9yIGNoaWxkIE1SLsKgIExvb3Nl
IHRoZSBtci0+Y29udGFpbmVyIGNoZWNrIGluIE1SJ3MgZmluYWxpemUoKSAgDQo+IHRvIGFsbG93
IGF1dG8tZGV0YWNoLsKgIERvdWJsZSBjaGVjayBpdCBzaGFyZXMgdGhlIHNhbWUgb3duZXIuDQo+
IA0KPiBQcm9wZXIgZG9jdW1lbnQgdGhpcyBiZWhhdmlvciBpbiBjb2RlLg0KPiANCj4gVGhpcyBw
YXRjaCBpcyBoZWF2aWx5IGJhc2VkIG9uIHRoZSB3b3JrIGRvbmUgYnkgQWtpaGlrbyBPZGFraToN
Cj4gDQo+IFtodHRwczovL2xvcmUua2VybmVsLm9yZy9yL0NBRkVBY0E4RFY0MGZHc2NpNzZyNHll
UDFQLVNQX1FqTlJERDJPelB4ang1d1JzMEdFZ0BtYWlsLmdtYWlsLmNvbV0oaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvci9DQUZFQWNBOERWNDBmR3NjaTc2cjR5ZVAxUC1TUF9Rak5SREQyT3pQeGp4
NXdSczBHRWdAbWFpbC5nbWFpbC5jb20pDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBYdSA8
W3BldGVyeEByZWRoYXQuY29tXShtYWlsdG86cGV0ZXJ4QHJlZGhhdC5jb20pPiAgDQo+IC0tLSAg
DQo+IMKgZG9jcy9kZXZlbC9tZW1vcnkucnN0IHzCoCA3ICsrKysrLS0gIA0KPiDCoHN5c3RlbS9t
ZW1vcnkuY8KgwqDCoMKgwqDCoCB8IDQ1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0gIA0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgMTEg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZG9jcy9kZXZlbC9tZW1vcnkucnN0IGIv
ZG9jcy9kZXZlbC9tZW1vcnkucnN0ICANCj4gaW5kZXggNTdmYjJhZWM3Ni4uYTMyNWU5N2Q3YiAx
MDA2NDQgIA0KPiAtLS0gYS9kb2NzL2RldmVsL21lbW9yeS5yc3QgIA0KPiArKysgYi9kb2NzL2Rl
dmVsL21lbW9yeS5yc3QgIA0KPiBAQCAtMTU4LDggKzE1OCwxMSBAQCBpb2V2ZW50ZmQpIGNhbiBi
ZSBjaGFuZ2VkIGR1cmluZyB0aGUgcmVnaW9uIGxpZmVjeWNsZS7CoCBUaGV5IHRha2UgZWZmZWN0
ICANCj4gwqBhcyBzb29uIGFzIHRoZSByZWdpb24gaXMgbWFkZSB2aXNpYmxlLsKgIFRoaXMgY2Fu
IGJlIGltbWVkaWF0ZWx5LCBsYXRlciwgIA0KPiDCoG9yIG5ldmVyLiAgDQo+IMKgICANCj4gLURl
c3RydWN0aW9uIG9mIGEgbWVtb3J5IHJlZ2lvbiBoYXBwZW5zIGF1dG9tYXRpY2FsbHkgd2hlbiB0
aGUgb3duZXIgIA0KPiAtb2JqZWN0IGRpZXMuICANCj4gK0Rlc3RydWN0aW9uIG9mIGEgbWVtb3J5
IHJlZ2lvbiBoYXBwZW5zIGF1dG9tYXRpY2FsbHkgd2hlbiB0aGUgb3duZXIgb2JqZWN0ICANCj4g
K2RpZXMuwqAgV2hlbiB0aGVyZSBhcmUgbXVsdGlwbGUgbWVtb3J5IHJlZ2lvbnMgdW5kZXIgdGhl
IHNhbWUgb3duZXIgb2JqZWN0LCAgDQo+ICt0aGUgbWVtb3J5IEFQSSB3aWxsIGd1YXJhbnRlZSBh
bGwgbWVtb3J5IHJlZ2lvbnMgd2lsbCBiZSBwcm9wZXJseSBkZXRhY2hlZCAgDQo+ICthbmQgZmlu
YWxpemVkIG9uZSBieSBvbmUuwqAgVGhlIG9yZGVyIHdoaWNoIG1lbW9yeSByZWdpb24gd2lsbCBi
ZSBmaW5hbGl6ZWQgIA0KPiArZmlyc3QgaXMgbm90IGd1YXJhbnRlZWQuICANCj4gwqAgIA0KPiDC
oElmIGhvd2V2ZXIgdGhlIG1lbW9yeSByZWdpb24gaXMgcGFydCBvZiBhIGR5bmFtaWNhbGx5IGFs
bG9jYXRlZCBkYXRhICANCj4gwqBzdHJ1Y3R1cmUsIHlvdSBzaG91bGQgY2FsbCBvYmplY3RfdW5w
YXJlbnQoKSB0byBkZXN0cm95IHRoZSBtZW1vcnkgcmVnaW9uICANCj4gZGlmZiAtLWdpdCBhL3N5
c3RlbS9tZW1vcnkuYyBiL3N5c3RlbS9tZW1vcnkuYyAgDQo+IGluZGV4IDU2NDY1NDc5NDAuLmQ3
ZjZhZDliZTIgMTAwNjQ0ICANCj4gLS0tIGEvc3lzdGVtL21lbW9yeS5jICANCj4gKysrIGIvc3lz
dGVtL21lbW9yeS5jICANCj4gQEAgLTE3OTYsMTYgKzE3OTYsMzYgQEAgc3RhdGljIHZvaWQgbWVt
b3J5X3JlZ2lvbl9maW5hbGl6ZShPYmplY3QgKm9iaikgIA0KPiDCoHsgIA0KPiDCoMKgwqDCoCBN
ZW1vcnlSZWdpb24gKm1yID0gTUVNT1JZX1JFR0lPTihvYmopOyAgDQo+IMKgICANCj4gLcKgwqDC
oCBhc3NlcnQoIW1yLT5jb250YWluZXIpOyAgDQo+IC0gIA0KPiAtwqDCoMKgIC8qIFdlIGtub3cg
dGhlIHJlZ2lvbiBpcyBub3QgdmlzaWJsZSBpbiBhbnkgYWRkcmVzcyBzcGFjZSAoaXQgIA0KPiAt
wqDCoMKgwqAgKiBkb2VzIG5vdCBoYXZlIGEgY29udGFpbmVyIGFuZCBjYW5ub3QgYmUgYSByb290
IGVpdGhlciBiZWNhdXNlICANCj4gLcKgwqDCoMKgICogaXQgaGFzIG5vIHJlZmVyZW5jZXMsIHNv
IHdlIGNhbiBibGluZGx5IGNsZWFyIG1yLT5lbmFibGVkLiAgDQo+IC3CoMKgwqDCoCAqIG1lbW9y
eV9yZWdpb25fc2V0X2VuYWJsZWQgaW5zdGVhZCBjb3VsZCB0cmlnZ2VyIGEgdHJhbnNhY3Rpb24g
IA0KPiAtwqDCoMKgwqAgKiBhbmQgY2F1c2UgYW4gaW5maW5pdGUgbG9vcC4gIA0KPiArwqDCoMKg
IC8qICANCj4gK8KgwqDCoMKgICogRWFjaCBtZW1vcnkgcmVnaW9uICh0aGF0IGNhbiBiZSBkeW5h
bWljYWxseSBmcmVlZC4uKSBtdXN0IGhhcyBhbiAgDQoNCiJtdXN0IGhhdmUiIG9yICJoYXMiDQoN
Cj4gK8KgwqDCoMKgICogb3duZXIsIGFuZCBpdCBhbHdheXMgaGFzIHRoZSBzYW1lIGxpZmVjeWNs
ZSBvZiBpdHMgb3duZXIuwqAgSXQgbWVhbnMgIA0KPiArwqDCoMKgwqAgKiB3aGVuIHJlYWNoaW5n
IGhlcmUsIHRoZSBtZW1vcnkgcmVnaW9uJ3Mgb3duZXIgcmVmY291bnQgaXMgemVyby4gIA0KPiAr
wqDCoMKgwqAgKiAgDQo+ICvCoMKgwqDCoCAqIEhlcmUgaXQgaXMgcG9zc2libGUgdGhhdCB0aGUg
TVIgaGFzOiAgDQo+ICvCoMKgwqDCoCAqICANCj4gK8KgwqDCoMKgICogKDEpIG1yLT5jb250YWlu
ZXIgc2V0LCB3aGljaCBtZWFucyB0aGlzIE1SIGNhbiBiZSBhIHN1YnJlZ2lvbiBvZiBhICANCj4g
K8KgwqDCoMKgICrCoMKgwqDCoCBjb250YWluZXIgTVIsIGluIHRoaXMgY2FzZSBpdCBtdXN0IHNo
YXJlIHRoZSBzYW1lIG93bmVyICANCg0Kcy9pdC90aGV5ID8NCg0KPiArwqDCoMKgwqAgKsKgwqDC
oMKgIChvdGhlcndpc2UgdGhlIGNvbnRhaW5lciBzaG91bGQgaGF2ZSBrZXB0IGEgcmVmY291bnQg
b2YgdGhpcyAgDQo+ICvCoMKgwqDCoCAqwqDCoMKgwqAgTVIncyBvd25lciksIG9yLCAgDQo+ICvC
oMKgwqDCoCAqICANCj4gK8KgwqDCoMKgICogKDIpIG1yLT5zdWJyZWdpb25zIG5vbi1lbXB0eSwg
d2hpY2ggbWVhbnMgdGhpcyBNUiBjYW4gYmUgYSBjb250YWluZXIgIA0KPiArwqDCoMKgwqAgKsKg
wqDCoMKgIG9mIG90aGVyIE1ScyAoc2hhcmUgdGhlIG93bmVyIG9yIG5vdCkuICANCj4gK8KgwqDC
oMKgICogIA0KPiArwqDCoMKgwqAgKiBXZSBrbm93IHRoZSBNUiwgb3IgYW55IE1SIHRoYXQgaXMg
YXR0YWNoZWQgdG8gdGhpcyBvbmUgYXMgZWl0aGVyICANCj4gK8KgwqDCoMKgICogY29udGFpbmVy
IG9yIGNoaWxkcmVuLCBpcyBub3QgdmlzaWJsZSBpbiBhbnkgYWRkcmVzcyBzcGFjZSwgYmVjYXVz
ZSAgDQo+ICvCoMKgwqDCoCAqIG90aGVyd2lzZSB0aGUgYWRkcmVzcyBzcGFjZSBzaG91bGQgaGF2
ZSB0YWtlbiBhdCBsZWFzdCBvbmUgcmVmY291bnQgIA0KPiArwqDCoMKgwqAgKiBvZiB0aGlzIE1S
J3Mgb3duZXIuwqAgU28gd2UgY2FuIGJsaW5kbHkgY2xlYXIgbXItPmVuYWJsZWQuICANCj4gK8Kg
wqDCoMKgICogIA0KPiArwqDCoMKgwqAgKiBtZW1vcnlfcmVnaW9uX3NldF9lbmFibGVkIGluc3Rl
YWQgY291bGQgdHJpZ2dlciBhIHRyYW5zYWN0aW9uIGFuZCAgDQo+ICvCoMKgwqDCoCAqIGNhdXNl
IGFuIGluZmluaXRlIGxvb3AuICANCj4gwqDCoMKgwqDCoCAqLyAgDQo+IMKgwqDCoMKgIG1yLT5l
bmFibGVkID0gZmFsc2U7ICANCj4gwqDCoMKgwqAgbWVtb3J5X3JlZ2lvbl90cmFuc2FjdGlvbl9i
ZWdpbigpOyAgDQo+ICvCoMKgwqAgaWYgKG1yLT5jb250YWluZXIpIHsgIA0KPiArwqDCoMKgwqDC
oMKgwqAgLyogTXVzdCBzaGFyZSB0aGUgb3duZXI7IHNlZSBhYm92ZSBjb21tZW50cyAqLyAgDQo+
ICvCoMKgwqDCoMKgwqDCoCBhc3NlcnQobXItPmNvbnRhaW5lci0+b3duZXIgPT0gbXItPm93bmVy
KTsgIA0KPiArwqDCoMKgwqDCoMKgwqAgbWVtb3J5X3JlZ2lvbl9kZWxfc3VicmVnaW9uKG1yLT5j
b250YWluZXIsIG1yKTsgIA0KPiArwqDCoMKgIH0gIA0KPiDCoMKgwqDCoCB3aGlsZSAoIVFUQUlM
UV9FTVBUWSgmbXItPnN1YnJlZ2lvbnMpKSB7ICANCj4gwqDCoMKgwqDCoMKgwqDCoCBNZW1vcnlS
ZWdpb24gKnN1YnJlZ2lvbiA9IFFUQUlMUV9GSVJTVCgmbXItPnN1YnJlZ2lvbnMpOyAgDQo+IMKg
wqDCoMKgwqDCoMKgwqAgbWVtb3J5X3JlZ2lvbl9kZWxfc3VicmVnaW9uKG1yLCBzdWJyZWdpb24p
OyAgDQo+IEBAIC0yNjI1LDcgKzI2NDUsMTAgQEAgc3RhdGljIHZvaWQgbWVtb3J5X3JlZ2lvbl91
cGRhdGVfY29udGFpbmVyX3N1YnJlZ2lvbnMoTWVtb3J5UmVnaW9uICpzdWJyZWdpb24pICANCj4g
wqAgIA0KPiDCoMKgwqDCoCBtZW1vcnlfcmVnaW9uX3RyYW5zYWN0aW9uX2JlZ2luKCk7ICANCj4g
wqAgIA0KPiAtwqDCoMKgIG1lbW9yeV9yZWdpb25fcmVmKHN1YnJlZ2lvbik7ICANCj4gK8KgwqDC
oCBpZiAobXItPm93bmVyICE9IHN1YnJlZ2lvbi0+b3duZXIpIHsgIA0KPiArwqDCoMKgwqDCoMKg
wqAgbWVtb3J5X3JlZ2lvbl9yZWYoc3VicmVnaW9uKTsgIA0KPiArwqDCoMKgIH0gIA0KPiArICAN
Cj4gwqDCoMKgwqAgUVRBSUxRX0ZPUkVBQ0gob3RoZXIsICZtci0+c3VicmVnaW9ucywgc3VicmVn
aW9uc19saW5rKSB7ICANCj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoc3VicmVnaW9uLT5wcmlvcml0
eSA+PSBvdGhlci0+cHJpb3JpdHkpIHsgIA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUVRB
SUxRX0lOU0VSVF9CRUZPUkUob3RoZXIsIHN1YnJlZ2lvbiwgc3VicmVnaW9uc19saW5rKTsgIA0K
PiBAQCAtMjY4Myw3ICsyNzA2LDExIEBAIHZvaWQgbWVtb3J5X3JlZ2lvbl9kZWxfc3VicmVnaW9u
KE1lbW9yeVJlZ2lvbiAqbXIsICANCj4gwqDCoMKgwqDCoMKgwqDCoCBhc3NlcnQoYWxpYXMtPm1h
cHBlZF92aWFfYWxpYXMgPj0gMCk7ICANCj4gwqDCoMKgwqAgfSAgDQo+IMKgwqDCoMKgIFFUQUlM
UV9SRU1PVkUoJm1yLT5zdWJyZWdpb25zLCBzdWJyZWdpb24sIHN1YnJlZ2lvbnNfbGluayk7ICAN
Cj4gLcKgwqDCoCBtZW1vcnlfcmVnaW9uX3VucmVmKHN1YnJlZ2lvbik7ICANCj4gKyAgDQo+ICvC
oMKgwqAgaWYgKG1yLT5vd25lciAhPSBzdWJyZWdpb24tPm93bmVyKSB7ICANCj4gK8KgwqDCoMKg
wqDCoMKgIG1lbW9yeV9yZWdpb25fdW5yZWYoc3VicmVnaW9uKTsgIA0KPiArwqDCoMKgIH0gIA0K
PiArICANCj4gwqDCoMKgwqAgbWVtb3J5X3JlZ2lvbl91cGRhdGVfcGVuZGluZyB8PSBtci0+ZW5h
YmxlZCAmJiBzdWJyZWdpb24tPmVuYWJsZWQ7ICANCj4gwqDCoMKgwqAgbWVtb3J5X3JlZ2lvbl90
cmFuc2FjdGlvbl9jb21taXQoKTsgIA0KPiDCoH0NCg0KUmV2aWV3ZWQtYnk6IENsw6ltZW50IE1h
dGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg==

