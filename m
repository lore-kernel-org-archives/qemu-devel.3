Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B751D6EBE2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGvfT-0007xv-9z; Fri, 29 Nov 2024 02:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfR-0007wx-I9
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:43:57 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfO-0002eL-JA
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1732866234; x=1764402234;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QWd2tkeHQbBwbBNdDBZH/aGLavqAFkrtdTaIu/gE1UU=;
 b=UCAqjRcpkrj24LZ2UPK1XySl1aKa6ZgZeuHgBxfolBBI14XIarKIJMeN
 mt4S0I2o9r+bWj3Lo1H/G7lujoszpvHppyyWB1/kpdx7eDftFGDgGaPtU
 jJcV+KijzWFB8swV5TA1YU30IF+7OdHu5V/Z/pIKVfh5XoGa5jrD/AKnR
 zh9qUb5mrYcadBmiUSqSQq/HYD8wUBQPKyL+RJbHeRohI8iS1b97Y5tvC
 eUPbbZZp9OKA1oeVpjP4H7jvV/atKDBVIJTQhfgCwy0jSVcMnNQI0hez9
 8ZdEBrPjdKZIGSofUkBkYT2DziMBGSqDY9rfT9RaVA/0pSWHT4tWRVgSn Q==;
X-IronPort-AV: E=Sophos;i="6.12,194,1728943200"; d="scan'208";a="25670793"
X-MGA-submission: =?us-ascii?q?MDHrc9yHZwufgdxk5QNh0KWEmN8lJhM0ovdCA2?=
 =?us-ascii?q?j/+g2WGFdsIypo51rtvf+xoDXAI7uWKeJOpuhFHzl3CDwvGh/t12Ieg/?=
 =?us-ascii?q?Q+qQUg97XnZqZ9W4qbvO1jzup59VurkcXqUPQ/UkdH/o3qvIzi/QxpZ7?=
 =?us-ascii?q?WjHwqjnmOyonIRPGURUkj1cw=3D=3D?=
Received: from mail-am6eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.105])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2024 08:43:51 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFJ93EnwlS6GFrynhraqbxx/WbCL4yTODxzg2AKiuJOdQC4c9JnNwcwSQRSVYP/0MMeUxgXXO1n751CQe7lCtK1ZZmm7XBwMd6I1mf34u8vcv+pmGMkbXJTqR9b25xKENjbQwK09bd2N5AUXAm9Q6fEWrsRO+C7hhIfSMssiM3q33tsaab1Jbtq8TPfkFyVc3nHyCvNrikXd45+pTPdSafoOsGtpynzyMmpcuV0nEEwO1HTXSuyVGetJUjHhr3Xl1bknBzQZDcZA0gdmj++Oeecd6j+z9kAupZhRGC/GpLMiR71ADS3RdJHuFGvEGqZvSlZ9MmJEk8w/Xz1sC3flpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWd2tkeHQbBwbBNdDBZH/aGLavqAFkrtdTaIu/gE1UU=;
 b=PwBrqrncBjHZn7rCgg4dFW6TgW0ySowcW6MWBw9JnPxe2mVh6hxwHpkaW7NWHVldS6B9urSnyaMVzcKJd7O69HHaN0bnKR+v4wTfHQ9KCa3cklTsCdeEefXDK0bDIrf3/Icl8QqMM2OW3DU+QcN4P1q/5fMwSBmXbEzJU1cpm2RwQeOFkHJXmBFvERm0MzlhdAVlnl5J7CW3/bZZ5YNhDOHeJeVCl4wmbKRcB98lkaG2DEaQLPAjuTg4POL0snUcVt+CacPv7GBMePtMlfX8sC5aSDFaJ8EpEBJH56PDffpOJQ1B8BPks9F9u5n4vbBPpp+JH+evk6ySyGBCQrBAOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWd2tkeHQbBwbBNdDBZH/aGLavqAFkrtdTaIu/gE1UU=;
 b=FquTm4/vuVY0T5oJSItpe7fZnpVoYhbstkqnuEXmgUplEVC+JP6WsmQ2vB8crpvbaKpC1SuO0ADoyAoJvvzZ6+HiupcOFpV7PhERHRjG1sP6OSPzWcLmQm1wM5e2kD1rci3lsus42YilwTQsrSZaFr/B/rM0NOTzUYTU6yEj1Zwuw07HAYsBzV6yLVIf6yg77tUzZKHXbmf6kiZN2cxkiHJoZj+zby67aPLefVy5KVR4PsYbnG8wDkLGt1CRMvkkyoyxaoG4X2d0O7pfGFrVyqZiecQpuheLbqPiK9yfL+UNQG2ev8aw/SHDeBQr9Ot/AiZBKkzwEC/TEsjsACGZWw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7847.eurprd07.prod.outlook.com (2603:10a6:20b:39e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 07:43:50 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 07:43:50 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 02/19] intel_iommu: Declare supported PASID size
Thread-Topic: [PATCH v1 02/19] intel_iommu: Declare supported PASID size
Thread-Index: AQHbQjJuc09ui8+1N0yV5gvXicUETw==
Date: Fri, 29 Nov 2024 07:43:50 +0000
Message-ID: <20241129074332.87535-3-clement.mathieu--drif@eviden.com>
References: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7847:EE_
x-ms-office365-filtering-correlation-id: 482a81b7-2561-457d-c727-08dd104990d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?a0JPc3NCYzRUblUwbXo0SXR6Yzh6OHdLcCtxNjNTOFR6dlRZSHVXYWU5a2pQ?=
 =?utf-8?B?amRZbFVRU1dmSU5FdUtvUkVEVVVoQm9mTVdKMWppY2JnMVBoNkR5WSs5NmJE?=
 =?utf-8?B?NVBMTEQvTDZaTFhRV3lVWFFSSmViN2F1QTFBMTBUYVFQaVJGWTdwVUxscGF2?=
 =?utf-8?B?NEJWTVVEeVAycmxmWjE4UGh3Q2tWS0JYMVRJbXFJSEY2Wk14NXVOVDN3Qjdm?=
 =?utf-8?B?YTBmTmtnVFlWQTA2MTZDS1JwM3d4VStQanNUQlhBUXdkckdTa1NWeUJUekVi?=
 =?utf-8?B?NlcxNVhSRjZKeWUvSDJXeWtpWjZsNmgyZUlIdDZUYWVNblhIekFFbUxJOUZv?=
 =?utf-8?B?ek5HQkNjc0lsWm9oMjYydDN0QUZFQWFEWjZTQ0dHcDlicEErN21NNjdPSFRx?=
 =?utf-8?B?bUpMSnJxVnZpU2t2aWs0V2tXbm5oYnpCazZOK3JMWkgwMStLYUEydVRlM3BV?=
 =?utf-8?B?QTBJNjlnZTV0T0ppMGkxZ2VEVjBwNkU4ZSszckVCa21QVnpzb2xHbkFHNFZX?=
 =?utf-8?B?RTN3dHh3M3dMV3pOTzNCaFJlNUYrVDhXSWt2OTVDZE5iaDlOSVl6REVFSHlz?=
 =?utf-8?B?cE9aMENSZkRvRE9SOGhxZ2NTdWtxVVlRbVV5OHhCYUF0ZTFRVGlKb1Yzc1lO?=
 =?utf-8?B?OGRFcXFXVk9pbDVGdEhlSFg1V2h6NkdnVmdnU3JOYlFEbzA0dU93Rlc0V1Nv?=
 =?utf-8?B?WDZ0aUVjbS9TaXNkRkwxV29nV2dLRUZITEQyajMwYWRnQzk3Wm5CVGZwdTJy?=
 =?utf-8?B?alFRWG1IK0dkbzZtQ2lGNHJwV01TVmhNTzVZODhERUtJVTdVdjdJUWR4OW82?=
 =?utf-8?B?WTJKeXlUVTNkdlZuSHlGaVlScmF3cHlkejJrOEtIaHd0aG5wdWUyYkV6ZzFJ?=
 =?utf-8?B?cndDbWN0MkR5Q0FqS1d3TFZTYzF5M29wek50NUJWU3ZNcmRGaGlpTmZiME1v?=
 =?utf-8?B?Y3VleUZFUC9jQzQwUzZkeTArbGI4dTFGVEw3ZGxMd1ZTV0pJT25tZzJkSkQ4?=
 =?utf-8?B?SFRGWDR1Q0NtNFFCL0FYQmZwbFdEenpmMTFmaCtPRjRNS2NNVE9iYk9OaWkz?=
 =?utf-8?B?QkNqTjNSZWhpRXBLem1jUnVZc2F1TmF5Mkw5SUN5RWlZUFNpc2hLY2cvZEM1?=
 =?utf-8?B?eURtakhpOVdqblBNbU9WRFhIeFJwblpFNjJMSXZVTlBySUN3eTZQMzhaQ3VL?=
 =?utf-8?B?SWs3RUtHMjlqNnQxbVo2THlDZDVvZUxaajV1dnZwaXRQWmszNHVpU1A2Rldk?=
 =?utf-8?B?TFJXNHM0bGdoTzYyRGRGd2FPMEpOOTFOTnl3bGYrYTFSejh4cFk1RitxVHdI?=
 =?utf-8?B?elRkbnd4ODV4MXFseVVpaHp0bUJib2hRYW41QUZIOXhRZUNGWU52Tml0d042?=
 =?utf-8?B?eEhJTzJ1aENSekp6eEpMTHI3OC81SGRqREpWWmlXbW9nUGVJUGc3b1BEcmY5?=
 =?utf-8?B?NVNxUmVoNkFmb0tIYUg2TUhCeVFqa3IrcEh3cVlmdEV5Y2NYVkNjNEZYQ3h5?=
 =?utf-8?B?ZjFaT0RUWVd2enpLS0pEdE9tSEhXS0ZOczU2bkdSV0JIaXNVeE4vU0tDTDlr?=
 =?utf-8?B?Tk1ZQ25PTXhsRVIxcjlPcDhpOEtVSys4QnZrOForNTVPYjhCWktmcDkrVjFx?=
 =?utf-8?B?ZlNuMXVzZUxOQUMrV1V3emlFbThrZEVTdHVuYmRGVENOMjV0TUxiZTFnMkFD?=
 =?utf-8?B?cCs0ZTVRa1hadjZsbzQya29aYjRBVkg0bVVJck1Eb1FsUTFMMlg5WGJPcUQv?=
 =?utf-8?B?R2hVb1lCa2ppVmUyZ3U4WGpyZitpSzVVYk1WY3V3UFpHekZYQUZoYW12MXFI?=
 =?utf-8?B?eEdPY1NWTXdkVHhGV092eGlLWmJTaW1FRXZ3Rk5CaG5jZHE5ZU1ZQTcyUlAx?=
 =?utf-8?B?MUNNZVNSNzhhdmhoWkNvd05CWjVFK0FoeHNQekZCaFhDdXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUNjRzUrbWpoUDFCOEhjOXRoczh0aGNiMnkvVzlzOFQrNXVlUFMyRkUyejB2?=
 =?utf-8?B?bFd6emp2aldySThudmtDalM2SWNkZTFQMkxRTXM5NWlaWExYWHNWR1JPKzRi?=
 =?utf-8?B?YUxSMFhNby8zYWM2eDdOQXE2UGwwZGNGNkx5MlI0ZElKKzJYdjdrL3BUd1Ev?=
 =?utf-8?B?eGg0L3lsdWU1WXAxa3RTbE1KTER3bmNZcUpHSk5VeXBMVVVNclZWSnBTNGVL?=
 =?utf-8?B?RDVvWExKbDFYUGNEY09RUEhkVWFIT3h0VUF1TGVxL3dkTzNsV2pWTG1oUy9Q?=
 =?utf-8?B?Q2FhdjQzVjdYVVVqUXVRRVJkdWFJSUxUait0T3gzblZ3Y0lXakN2R2IxeDlV?=
 =?utf-8?B?ZGQyZ2RMVXlLWHI3ZFdkMWFDN0hObE1qOFhFZjhKTFhGQUpmTEQzOTFqRDY3?=
 =?utf-8?B?QVFDMm9nZVRldUxLaEI0SE9uWWc3TzFFeHFsS2lldnEzSGo5NEN4ME5jd2Vt?=
 =?utf-8?B?cHh5c0s3SHA5OUh0M2V0TXpNSGd2YzVSVzhpRHJZRFIxRHlwb0FBTzlrUkNz?=
 =?utf-8?B?R29GTlZVOFpjc3FZeXVTZFU4ZVFDRWRnSzVOaXgwZ3VvNHYwY3pwZzU1V1Nu?=
 =?utf-8?B?VHBMa2IzMTh0UWpOb24rbkduSFk1S0dVRmJPaXNwbEcrLzJzZS9MSmRzVDUr?=
 =?utf-8?B?N1E1cFlZcGJ6K05oUVZNbjFJNnVkQUdVWVZtUXdpeE1hM1dVeWFlempvalg5?=
 =?utf-8?B?RGtNcUdpTHdrNDZCalZ5ZXBqNHByTTNZcExSQmZ5MXo0amxVbHRoWEZHK2lX?=
 =?utf-8?B?SU0rTmN4OFp2MkVGcTQ4K3FNNXV2M245VkdWUllNcG13SkRjS0dub2JvOWE1?=
 =?utf-8?B?UjBIakpmRDJ3aG1FNm16bDZMWVloUytHV0hIeDhsTzFkOFVESVZORk9wcXpM?=
 =?utf-8?B?RncxVHRJYUhCUnFPZjdxWTR3amVmR0NDQUJDSGZFdHhHL1REWHlGeFNXdTRu?=
 =?utf-8?B?MDhtZVlpb1JwQUdHN01kNjc3UUR6NUhsNnNYS284cHVnMHEyTGUvbE4vUzlx?=
 =?utf-8?B?UmxxK1ZoZG1hMXdTRUgyYlFEZnNyaWZyamtidzNZZCtpeXo4aUgyT3kzdWVD?=
 =?utf-8?B?clhEZmNkZ0N2VXpNL3A2bDJoZkZ4cC9VR2VmenV0RnNsVkpiVlk3bDExZUlP?=
 =?utf-8?B?cXpMa0hneHhSdjg3R1lYdnh5U1laVG1iZmRGT0czVHpZSWZqVVRBUnU2TDlW?=
 =?utf-8?B?YzBwU0dlOUxWdEQrNlpVd2dKUjFQb1FRWXVmbGhlbXZmOXdhalJwVmFqSGdz?=
 =?utf-8?B?eHp2eGdhUmR0WFI5ZlJZd1BuSGlSZzloTnBHZjMrVnRqWjhXL2ZSd1pZZ0tK?=
 =?utf-8?B?U2c0b09yMVZqSjhTalk0SjQrd1Y1S2VDM3R0dnVTNmVpanNoWEtIL1ZNS0ZJ?=
 =?utf-8?B?S2U2ZS85My9rdDU1WlBCSitscXdXUDhuS1g0emtkRllBbWhZdjMvR0h6WXZ6?=
 =?utf-8?B?dmxpUk02VUR0TVBZRlVPU2Rmb1JYc1dvQko2WEd4QUxMdFA2Tm44bEtNNzAv?=
 =?utf-8?B?UVBEOXNLdmRRbkgzVW1SKzk2c2ptd0xZVEgxVmNkNjg5TTU5VjlldjBnc1Q1?=
 =?utf-8?B?emFSZDRiWkNyNElBYUh4YllNenBBek5NMFllMkpVVS9GYUlLNEEzQmNtWDdG?=
 =?utf-8?B?MzdtVWxpQXlrbHZNNUlrVzFmZXo0T1NmYnhFZ0JrWERZVW0rYjd4a3ArWHhz?=
 =?utf-8?B?SmhUbEhHWFdzcFhtaUxSSjA2cnZpTWtKbjZjN3pnWEFXdmVtbXA1WEJnWVVu?=
 =?utf-8?B?TFVhVG5vOUYwUHJnMjZGdVB5NnVSbmNYak4vUUhnaVVnaTFmNVU5cDNBS01w?=
 =?utf-8?B?TUNqR3JyZld2Ny9YVTQ1OFRyRk45SENFKzRWTldyS21PSlkxV3JubTdvdzcz?=
 =?utf-8?B?WDFEdGxRWnhFRHVBOFlWT3hJUjRxeitWeWtTTVR5QUZZbUQrdkk3NWR1MXZD?=
 =?utf-8?B?N3VzVWdiTDBmOWRmSnR2WnkyMFdrVStsQVU4NkpuRVdFb3dXbjhWQjgrY2U4?=
 =?utf-8?B?SDlMbUxaQUsveU85OXBMUjB6eVBVcGNiN1lpQk1KSmpkclVhNUVYTmlTSjZu?=
 =?utf-8?B?QUZuS2dGNkE4d1NzZERGN0xORUJ0NzB5TUtzakg3ZTJZVS9XVWJTTGYxZW0r?=
 =?utf-8?B?cTRsdzZIOTFmV3BVRXVNdDhyazE1YmtWbXJoUmhIc1pKclpxS0dNYTZsMDBZ?=
 =?utf-8?Q?ZF2hjCqsKAc4V7L0jjn330o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB76F2580EC2B049B4D094E12E258804@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482a81b7-2561-457d-c727-08dd104990d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 07:43:50.5046 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4y1PUksNre6bx7Hvr4cRz07PVCzurKh9efFNKHBvmx+oGekAG3c7bNgeqX7XNq213VlYRpfCrTIl5idkmaicRlSRlEJ43skqoypJXFjwH2tn9WN2kxX//y2L0j03QppA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7847
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClBTUyBmaWVsZCBvZiB0aGUgZWNhcCByZWdpc3RlciBzdG9yZXMgdGhlIHN1cHBv
cnRlZCBQQVNJRCBzaXplIG1pbnVzIDEuDQpUaHVzLCB0aGlzIGNvbW1pdCBhZGRzIHN1cHBvcnQg
Zm9yIDIwYml0cyBQQVNJRHMuDQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURy
aWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRl
bF9pb21tdS5jICAgICAgICAgIHwgMiArLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aCB8IDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lv
bW11LmMNCmluZGV4IDA0MzQyNjAzMmMuLmFhZDEzMmUzNjcgMTAwNjQ0DQotLS0gYS9ody9pMzg2
L2ludGVsX2lvbW11LmMNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KQEAgLTQ1NzUsNyAr
NDU3NSw3IEBAIHN0YXRpYyB2b2lkIHZ0ZF9jYXBfaW5pdChJbnRlbElPTU1VU3RhdGUgKnMpDQog
ICAgIH0NCiANCiAgICAgaWYgKHMtPnBhc2lkKSB7DQotICAgICAgICBzLT5lY2FwIHw9IFZURF9F
Q0FQX1BBU0lEOw0KKyAgICAgICAgcy0+ZWNhcCB8PSBWVERfRUNBUF9QQVNJRCB8IFZURF9FQ0FQ
X1BTUzsNCiAgICAgfQ0KIH0NCiANCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2lu
dGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCmluZGV4IGU4YjIxMWU4
YjAuLjIzOGYxZjQ0M2YgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmgNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KQEAgLTE5Miw2ICsxOTIs
NyBAQA0KICNkZWZpbmUgVlREX0VDQVBfU0MgICAgICAgICAgICAgICAgICgxVUxMIDw8IDcpDQog
I2RlZmluZSBWVERfRUNBUF9NSE1WICAgICAgICAgICAgICAgKDE1VUxMIDw8IDIwKQ0KICNkZWZp
bmUgVlREX0VDQVBfU1JTICAgICAgICAgICAgICAgICgxVUxMIDw8IDMxKQ0KKyNkZWZpbmUgVlRE
X0VDQVBfUFNTICAgICAgICAgICAgICAgICgxOVVMTCA8PCAzNSkNCiAjZGVmaW5lIFZURF9FQ0FQ
X1BBU0lEICAgICAgICAgICAgICAoMVVMTCA8PCA0MCkNCiAjZGVmaW5lIFZURF9FQ0FQX1NNVFMg
ICAgICAgICAgICAgICAoMVVMTCA8PCA0MykNCiAjZGVmaW5lIFZURF9FQ0FQX1NMVFMgICAgICAg
ICAgICAgICAoMVVMTCA8PCA0NikNCi0tIA0KMi40Ny4wDQo=

