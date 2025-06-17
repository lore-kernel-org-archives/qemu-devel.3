Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68A1C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYI7-0001Fg-D4; Tue, 17 Jun 2025 11:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uRYHH-0000vN-Jt; Tue, 17 Jun 2025 11:31:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uRYAW-0001yq-QF; Tue, 17 Jun 2025 11:24:15 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HEWvHv026851;
 Tue, 17 Jun 2025 15:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=xkzJM5PJCJQYF+9knd3PkY6pt1y4anlwvmnlzWRnBBE=; b=
 dT7Bzyw32t2pCzDJ5bPvyP48zkxlhuCDUb+3TvY5SIkGuR1wFAS7pEeIdeZl2z3Y
 dZZKZUYQ9sQMiQEAj2qBV5q+nzaUjGHe4IurNiFHNRFQyGrMTTqg7QBsIFlsQtBX
 3M+APdHv3Z12w1ksVhTxPYGL9V6g2MRk3CrTH8mMyD0Ywymn3ZTgTcjRKTaYLbEG
 pedvSwyyj290K1Aig8GK+O072zbrHurZJzY89AmL7o6NaKdlJHSRQ51dXn1bZrEx
 MS1vwr9PjoGkXpY7S3aJv+Wv9O+NUdyqPUt0NI/WXVIRFmWMW/Lmq9xrjLb5kkv6
 rbEyuA3oUxqpBvvkPEudRQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479hvn4xg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 15:24:00 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55HF2vLx032810; Tue, 17 Jun 2025 15:23:59 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11012037.outbound.protection.outlook.com
 [40.93.200.37])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 478yh9cmbr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 15:23:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmXFYw6L6DZnqo/vTl+XgFlLPceMGBXcGwprmle37nzb3p/qSHdSTkDmTSb1fAfohQBS6/Snfo2WHxnQ/2Gs+iVcrVh9oZBAnlag8y+lbVNZ6dLk3N4NYDKTVAogzsB5Ld9YUOJDmn2F320Im9R8xKW0fiMe/1G9M7XMje/gEXATxKwYHnKAfGhGaiDkwl0oiWx36M6RP5Q1yqMWPsffX+Q4mmU/j9qr90u9B944m6s0rvTWZGKHXNINcStuRSh7WIEIV+Q0wvxmeD8pV78B7oBlvdATSXzGLAzXGigiLNcQpGwc/BGs0GCcj+hQvJra3bpgwTltRGcEBU16rkYwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkzJM5PJCJQYF+9knd3PkY6pt1y4anlwvmnlzWRnBBE=;
 b=GjScHtoliRK0PsrVO6X/xSKuSw4L6iAVckoW0UOyp30n/hQvkeNZdPKm+Cx1jVfkyKaqXtvaGPabmX+ZcYqocrKeOlAJFMgMNWsSTHRnOQEg69RdZuB8r4U+UZ9TPw/+gJif62uEWevpOztLNXBvPJnx/XVVz60fuEkqP3KgCk8V76Lg4zAh147hQfJputoULD7pAvBMyQUlzEzhaPkQy60cBtoQiWK8pooL+SFxi3GceV/b/N5rF58o2PYApEMdoZYsds46ubyZNBP1D8P97CGfiNyPcde3BkwrHml+OMel+nTsa6k7yNUJ0k/sQcH6uOqTK+9w+IJQzHXSrAvdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkzJM5PJCJQYF+9knd3PkY6pt1y4anlwvmnlzWRnBBE=;
 b=l3QqIpsd08I/dnu0b+syIwUprGX8io+t+pTpK2Vv82LuRuXFXRLR8BAXo4xdQscBeiAhhihiOUkCOG3ns0x5ZnB9brlCpsPb6FeEjX8KxbrgZ6MHlIbOhJLeGn0eAahzglUQPbE82976I8SlFvJaO2yub/bfzBoLFL5maFXb8nc=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SJ0PR10MB5741.namprd10.prod.outlook.com (2603:10b6:a03:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 15:23:55 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 15:23:55 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Alyssa Ross <hi@alyssa.is>
CC: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "maz@kernel.org" <maz@kernel.org>,
 "gkulkarni@amperecomputing.com" <gkulkarni@amperecomputing.com>,
 "gankulkarni@os.amperecomputing.com" <gankulkarni@os.amperecomputing.com>
Subject: Re: [PATCH v5 5/5] hw/arm/virt: Allow virt extensions with KVM
Thread-Topic: [PATCH v5 5/5] hw/arm/virt: Allow virt extensions with KVM
Thread-Index: AQHbztBANNalBs/OM0mEgKpxsV1Eb7QHh2YAgAASmQA=
Date: Tue, 17 Jun 2025 15:23:55 +0000
Message-ID: <D3582F3A-B07A-4F05-827C-B030617B77EA@oracle.com>
References: <20250527062534.1186004-1-eric.auger@redhat.com>
 <20250527062534.1186004-6-eric.auger@redhat.com> <875xgutpuh.fsf@alyssa.is>
In-Reply-To: <875xgutpuh.fsf@alyssa.is>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|SJ0PR10MB5741:EE_
x-ms-office365-filtering-correlation-id: 88479015-8233-478c-ff6e-08ddadb2f910
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?V1dYUE9kSDFuMzhWenh1bi8wTmsrVTRRc24xV3ZPTmErdDBNNzVzTWtBWkVm?=
 =?utf-8?B?Y3RESDRXRFNIc1dxZlpWRXZxSlhGNjdTa214RVloOFZEUzRVaTM4Q2pFYXVP?=
 =?utf-8?B?NjZNVHZUYTV0NDcwNlk2bC9hY0dlWmMreE1vNzdZY0RWZG8yUlVpcEVaYTFo?=
 =?utf-8?B?aG1SQ3k5aktvOURMWHdCQ1ZidHVkWkwyQWE0c251UVBzZ2ttTlFsQjNZK25o?=
 =?utf-8?B?Y0dLZ0JuWi9xcDBOYkxZdkQ2T2FkTUdFREwzUEMxQTF5K1BKN21vNEN0bDdM?=
 =?utf-8?B?RlVjVnNyVnovTVY3UElVUDhaN2FkSUZpYVY0QTgrZFhPd0dkMnFvSVpUZ2Mw?=
 =?utf-8?B?dUR1MWhIdWh3dHBiaTNUVXhDTnlVS3A2SHRrS0pEK2NzYllLWkJpajR6NkZl?=
 =?utf-8?B?MVVJcXRWdXoyMC9jZkxXYW9XTXY0UVhPdytQUmN2U0RvTXdHZ3BjQjJ1K0p6?=
 =?utf-8?B?MFA4N0d1blBkaVljYk9ZZzhKVTlXbkc3aW9pUzIvWWtWbzZqUWFUbkI4OGRC?=
 =?utf-8?B?cHUvSVQvNUlCQVN4clcrY2E4cGlkd0l3dm9qMmV3d2dKVlJJdmpiQXdtQkZr?=
 =?utf-8?B?cVdNRWNWSG1abVBmM09wN3RjYWJsR08vL042ZHorYnNMTnp0dmJ1UDY0TDl1?=
 =?utf-8?B?WktPVS9XQ1dTa1RzS05vSm5ZdEh1QVIrL0dHTmRWYmk3OEtHNUJmNE1QZFJn?=
 =?utf-8?B?dEgwRnFnRGMxYk0xb0lMKzFScEQ1VzU1Z1FwRkVMa3lKRXJUckJ4VWdvYklJ?=
 =?utf-8?B?MXFYQTRwcHJ6MmRrTk9WSHl3SFBqM0Y0WEduS0dQN0ZMRTBiYjNCdjQyeW9B?=
 =?utf-8?B?RWs5RExFdDdYcFBzK0hLczhTNDYzUjhGMVM1RnZSWlJYYWljbmxUbXROTEFD?=
 =?utf-8?B?RWlaUzJ4R1ZReGIrNnRtV05xT21lQUxmL1dlTlVsN3c2aXF5OTd2ZkZ5RmVR?=
 =?utf-8?B?cTA2bkZuUUhRdEVkQlZ4SElxRzd6eUFCOE5RZXM3Z05VODVDc1hzeFBsaXcy?=
 =?utf-8?B?ZVNJekRadEZueWxBWStDSlVqcTJrbG1hd3N0V3hJY0krL1dyOVhpK09rejJh?=
 =?utf-8?B?bmtBMGlQS2VId0NRc0RkbnpzbkRpc3JZbTlUaEdBMFpINmxtTmJTL3BPWTU0?=
 =?utf-8?B?QjJVamJ3SVA0akQvM21ZMzJmSWxSeFJaZWxCSERTbStpQTNWVG16cHQwbnFi?=
 =?utf-8?B?Skwzd1VZc21hM1Jrc1pSejUxYVlOcXFNbkgxQWw3SW13V252UnBxNzgwRThN?=
 =?utf-8?B?Ynlsa0Iva3RMLzNkRzJ3SjlhUjVia25jQ2xRNUFoSzBwUEZkK0k2bHVFQkdR?=
 =?utf-8?B?dEVEZE56TVJSSUFPZFdNS2RQeXlHMFpGTHRoaFg0am1yc2lJaVMwKzFkZFRN?=
 =?utf-8?B?MUdUbFFwMTZMN0NGVElHUEtpY1FUY25sZXIvOGhsSS9oZEZDRU52SzVkcExT?=
 =?utf-8?B?SG5ubFhwUDRBSTRRRjBGN21FVW1lK2VyY0UybVpkdVFWdlorUUVQSGJ1VENC?=
 =?utf-8?B?NTBYT203NzYrYU53WjltSHUwRjhueUVkY0daZHEyNjVNRm9LYUlLWnY0RmxQ?=
 =?utf-8?B?OWE3ckYzUFZzVXQ3eUNuSS95aU9hNUhwMTExZlJnbVBrMWNoNVFZcFZBV3li?=
 =?utf-8?B?NHZqditOSnJ6MmNxcmFETm5pbmFsRGMyc2h1SlZLZEFTTDRJdEZ3SXVIK00y?=
 =?utf-8?B?cWI3WnMzUTFweFZHSlhsUE5YYnptMFZSWnN0czZYcnZ3Y1E3cVV0UG9WaXBi?=
 =?utf-8?B?Zk12Nm9oVU1xeDlnK1lpa1M5T3ltUW5EREdyK3BCYm1kN3AxVUNLb2gyNlA3?=
 =?utf-8?B?eHMwNHUzQTkwMzBZTTFLMXpDeTJQbVJRZTlMNXdzcWgvYU1tZW5Jem5uTC96?=
 =?utf-8?B?UzdhTEN5U0ltcHIzVTVrZWFpN3M4bmtuUENKKzNTN1FZUE1MWWdSOHFPN2hF?=
 =?utf-8?B?ZmxRVXFCSFVvS3llS29HWXRDdTFJK05EbTcvMjRwalUwZ0lYOFRuNXlzQUF5?=
 =?utf-8?B?NHN1cTRRT2p3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmxtdGdFZmJONUV0UStFZTE3MDhCRnEwMzFhSWZET0UvbmVGQjZkcE1RZUFi?=
 =?utf-8?B?SWEvOEVYVnJjZHlRbEd4QmhENlQvd1VIT0RjTlF6ZVpnUGNwOFRGUnJ4alA2?=
 =?utf-8?B?Wnk1QU1CZXFJajRuVVZzZ3ZtTGQwejVsdVNudE9tTncwd25naWFVSjNoYWpZ?=
 =?utf-8?B?YVRGQWxqUU1QV2tHaUY1YXhaeVZjeUpCTjNKSFJzcng4dEZRQUFsKzB1SE9O?=
 =?utf-8?B?a3h4L1NSSnowNWoxSDVERU91QWEzNStRU21LdHNCRmRNekZ0NUVVNUUreC9p?=
 =?utf-8?B?YmlpUlBuclpFMnFvaUJNWGtqR05nLysyUWZOblptTVFkZkFYOENnL3hrMjAy?=
 =?utf-8?B?ZitEd2F6bThreHdYODgyYzFNNzk5eXMzcUFQdkNXQkRpSTdYL2hmZUdicUk1?=
 =?utf-8?B?c0JDc1QxeGRiSUlXY0pQSnB2ZkVaR1NqaDB5VWYyREpja3cyYUxoSnh2WVl4?=
 =?utf-8?B?UGtEZ096cUppdTNYM2R5dTRzWU5tZU9qdmcvMGZqRDlTWnFqWmJ5UDFyR1Jk?=
 =?utf-8?B?dWZieGZLd1l5cEtNRGxKSC9QSDFYU2p3WXJEZmpJNEEva2NMYmt4elpmdWJt?=
 =?utf-8?B?YlV2cmZoaThuSjVLaGxQYU83S2IwYXRTUDRNeU0rTmRQNHlpQm5hSlg3MkJR?=
 =?utf-8?B?bFA1QWFMZlEzVnN6NS9vWUJWUTFNQmYwRXg5OEh1ZWppNVVwcjBCblB3OUxS?=
 =?utf-8?B?aUxXbzc4K2EwNjBaVEJ2MUoyWUlXMklNQ3FDT1AzZWRhVXprYytvanBLampr?=
 =?utf-8?B?c2RvZm9BYkVLNnl2WTNaTCt6MXp4eCtuR04wSTdyMGhpRTFKUGhJNEJxa2hu?=
 =?utf-8?B?YTQwNmZZbjdzdTFqdlpKa1hVVFNEeXM1YlBYWGQ5aXJ5S25sYnBYcEVON1pG?=
 =?utf-8?B?NUcvMUQ0RkhVNUZmbHByZnNtUTlvRjRXOS9PNVRqY0dLV1NTbkVVYjZuK2t6?=
 =?utf-8?B?NG9HT1UxWE9ONGNkVHNXZ2NqQm9zM09oOWJ5Ri9kQXZhTXN4cFMzQnp2MHF0?=
 =?utf-8?B?V0lkUTViVGtZTlNXZ0ptMllPajBENzlSVktaaHZJQ0NTdkZtUWxkY0d5ZHl2?=
 =?utf-8?B?dnppeXJFL281L2ZLTkZtRFdETllRdFQwajA1Ly9HdjlHMDdPM3FEVDFHTEdt?=
 =?utf-8?B?ZkNwYm5ZSk5BQkRBSS9XSGZGQ1Q2OWVNZ0QySjg0Nm9tMFMwM0xVMHJFR3BG?=
 =?utf-8?B?dURBVzdvMW9qLzFXaXd6M29OUC9PYnM0SURLR2xBeS9ISnN6M0RYd0ZlYzdK?=
 =?utf-8?B?VHRtZGYxd0VleW9LSDhRb08wVjhMc3RIakd2VDgyOGdjOWdFZEY3M1lwM0k0?=
 =?utf-8?B?S0hmQmxIL3lNMmhLY2pxZDA3MjhjL21pRVNWYUt6T0pjMUZmeDRKQTNjamll?=
 =?utf-8?B?QU4rbWVJUkNZbkNxZG80VTQwSnd4TjN6VzE3R3Y0NCsyMndEMC9sM3p3Qngv?=
 =?utf-8?B?TUUxOWphK0t4Z0UvU2lRd2V6TUs4NkZGTDZqOVIvd3VtNHdod25ZeGRGekpT?=
 =?utf-8?B?ODdTcnI0Rlg3SHNCUHpjQWpTTXJ6TWY2SHBLbWxBa0xkTEdpWVhiTktpM3dM?=
 =?utf-8?B?bEY4SmJ5dVRCMWZnM0FwMlRLOWo3emNGYkUrdmFQaTJwTHA3cEJoZE8xSW9Q?=
 =?utf-8?B?cFhOZTJNRFpYWTIwV0l2emFCeEVSVGVxMElnS2dFWDVGdHJ0TkEwWFZVck55?=
 =?utf-8?B?OEZZMkE1eVNId0xPSmRiQ2FMQmh3V1Z6TTVWQTVxQWhwRjlNeUZLS1RORW4w?=
 =?utf-8?B?azVXb2RZdzEzYmF3QlJVai8wOG1UODlEcjA0N3l3RHBhanRuY3hQaEN4S3lJ?=
 =?utf-8?B?YUlSb1c0Y0VCMmVGMFU0SnlLcC9DdmxVWGpUUzdaV2RReEZ5dU5zN1lJQzNt?=
 =?utf-8?B?UmVUVGdxd0I2ZVVoZG5PNld6R2FJVTYrUFVmTXI3SXdUWDdsK3VOb2VjTVFK?=
 =?utf-8?B?THpIK2tUWlVUUFJDY2JUcFZudld6VXZKUExlVzNFRm1ORGwrQkpwbFVtNmZl?=
 =?utf-8?B?dzF2N1NUenl2UThYOFlPdlhVTkJhNGRTU0RteWg3RC9MeEExYnFYQTZOZ2hK?=
 =?utf-8?B?MHU5Ylg4bXl0MjMxYUdJR1hDUFlPaHo2Z29Zd1RJVjF1WEJJN1M5bFE0emlk?=
 =?utf-8?Q?OmhHAf2LaUl+ysx974MEGV/rZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A875EDC2D6C49845B1F7781BA610CA21@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gKclPw5ephBqetTOFWNgsS78vszpcmdkVClyrGkl1nHguszYsrbU8USlM6kvN8biO/Fgy3DOWv0dCCQntGMUPNbYz0Se3VK8iB/J9Dym6TgkGQsS2SPbRkSjxfN4Xr0JJR/kFT7n5flk/FfremPLIbd16MbG0w+FKrI/Mjkg5F9Klv/p/PG4vlgr72MzfWWpFsYVV8eDHNZ8cv4zuTtoLwXfabNwHkOSKqL2ms7IqCMLJYpPSpiKms5/l2g1xr/KnzC4+wp2I3EJXS1qFBFGJODPmUyntOLaYN1Dm85zkMmRuod5k1gqmWa1vEUEklm01k1XeLHtoGSDqMX8wzI/neLsbSXlLNKJqoniltQKxtVzFkNR7CwKJNQfOhBYx8B+lrrnd+7/OIXk0kabgyADnHCvgTpC7ctiigMjdVBJGSLLR/D7mbV89oTfuFOKeSMuDAKzt3OQYIIP06SqsNirnfFNjDkPrkM1xPcKTEEVpNNY5NWaBrY4X1TVtQRpqX5gV4hb0MfifwnghNo/cTRG34hyO47/TzevOpsIsamcnqhEdBubQmQARQWXY4jurdTR8zBti+mAqlvT1Lbu8D1QQWRqUdAbj3/dogtm/x88Oeg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88479015-8233-478c-ff6e-08ddadb2f910
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 15:23:55.0296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JhrMY1nGem3GroSDmUyMhBZpuCciQNurZM8TEACMxZVKhnkLdYcu5EtEuwpn0sEoW7j7YW76kIzt6sBMsT00Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506170121
X-Authority-Analysis: v=2.4 cv=XeSJzJ55 c=1 sm=1 tr=0 ts=68518890 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8 a=o4LtG771aIQ1fRmmrdkA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nuMwTux0E58arzDM8eorTkbFdI5J6iZz
X-Proofpoint-GUID: nuMwTux0E58arzDM8eorTkbFdI5J6iZz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDEyMSBTYWx0ZWRfX5fzJaUY8EPgy
 NW3bNuNtD1QFQQJcRC+3aYBNLH0lZ49+jvgPsl93VYQqTGjw7uT0OFJoewmMdpMlnogkjyNsNGz
 gttJJjOse69QuqEdo158AIw/yo3pPencKrbfkagJDd+aOueIHQjkutVWJcQTqoqXub03kvdhjKq
 xwbjfV0dtesh2Jx39Z6SGhE6cwZtNK0gm0pc5iMYctmRqZ3zbBkrJ+78A6oqAs7B+oOGNQfpsx7
 6NG2vJCp2PxkpfcYaz8E+Ur8AM94Y5QeKjyg6f/6Kn2tTXXfB4FpnSdLNB6vMJzweuUTcEwV/rb
 44z4Sa4xfxoLQe0fJA7DgxDxme3riWf6lZ80/hUcCHysX1phwoWYXADv7KVkCHE+vvuTwi4W+YL
 dnEY8fgWPCWWSp402FxUwRajBiU5/R37uQQjcud14fgp4wsHo2EFnYaIKTAlRpxVG19lS4K8
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgQWx5c3NhLA0KDQo+IE9uIDE3IEp1biAyMDI1LCBhdCAxNDoxNywgQWx5c3NhIFJvc3MgPGhp
QGFseXNzYS5pcz4gd3JvdGU6DQo+IA0KPiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5j
b20+IHdyaXRlczoNCj4gDQo+PiBGcm9tOiBIYWlibyBYdSA8aGFpYm8ueHVAbGluYXJvLm9yZz4N
Cj4+IA0KPj4gVXAgdG8gbm93IHZpcnQgc3VwcG9ydCBvbiBndWVzdCBoYXMgYmVlbiBvbmx5IHN1
cHBvcnRlZCB3aXRoIFRDRy4NCj4+IE5vdyBpdCBiZWNvbWVzIGZlYXNpYmxlIHRvIHVzZSBpdCB3
aXRoIEtWTSBhY2NlbGVyYXRpb24uDQo+PiANCj4+IEFsc28gY2hlY2sgb25seSBpbi1rZXJuZWwg
R0lDdjMgaXMgdXNlZCBhbG9uZyB3aXRoIEtWTSBFTDIuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6
IEhhaWJvIFh1IDxoYWliby54dUBsaW5hcm8ub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogTWlndWVs
IEx1aXMgPG1pZ3VlbC5sdWlzQG9yYWNsZS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+PiBSZXZpZXdlZC1ieTogUmljaGFyZCBIZW5k
ZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IA0KPiBIaSEgIEZyb20gd2hh
dCBJIGNhbiB0ZWxsLCB0aGlzIHdpbGwgcHJvZHVjZSBhbiBlcnJvciBvbiBob3N0cyB0aGF0DQo+
IGRvbid0IHN1cHBvcnQgbmVzdGVkIHZpcnR1YWxpemF0aW9uIHdoZW4gUUVNVSBpcyBpbnZva2Vk
IHdpdGggLWFjY2VsDQo+IGt2bTp0Y2cNCg0KSSBkaWRu4oCZdCBrbm93ICctYWNlbGwga3ZtOnRj
Z+KAmSBjb3VsZCBiZSB1c2VkIGFzIGEgZmFsbGJhY2sgbWVjaGFuaXNtIGJldHdlZW4NCmFjY2Vs
ZXJhdGlvbiBtb2Rlcy4gTWF5IEkgYXNrIHdoZXRoZXIgZG8geW91IG1hbmFnZSB0aGUg4oCYLWNw
deKAmSB0eXBlIGZvciDigJgtYWNjZWwNCmt2bTp0Y2figJkgd2l0aCBjcHUg4oCYbWF44oCZID8N
Cg0KQnV0IG1vcmUgaW1wb3J0YW50bHksIGlzIHRoaXMgd2hhdCB5b3XigJlyZSByZWZlcnJpbmcg
dG8/DQoNCkFsdGhvdWdoLA0KDQo+IC1tYWNoaW5lIHZpcnR1YWxpemF0aW9uPW9uLA0KDQpzaG91
bGQgd29yayBmb3IgYm90aCAnLWFjY2VsIGt2beKAmSBhbmQg4oCYLWFjY2VsIHRjZ+KAmS4NCg0K
PiBidXQgSSBkb24ndCB0aGluayB0aGF0J3MgdGhlIGlkZWFsDQo+IGJlaGF2aW91ci4gIEl0IHdv
dWxkIG1ha2UgbW9yZSBzZW5zZSBmb3IgaXQgdG8gZmFsbCBiYWNrIHRvIHRoZSBmaXJzdA0KPiBw
ZXJtaXR0ZWQgYWNjZWwgb3B0aW9uIHRoYXQgZG9lcyBzdXBwb3J0IHJ1bm5pbmcgdGhlIG1hY2hp
bmUgYXMNCj4gY29uZmlndXJlZCwgc28gaWYgaGFyZHdhcmUgbmVzdGVkIHZpcnR1YWxpemF0aW9u
IGlzIG5vdCBzdXBwb3J0ZWQsIGl0DQo+IHNob3VsZCBmYWxsIGJhY2sgdG8gVENHLg0KPiANCj4g
SSBtYWludGFpbiBhbiBPUyBkZXZlbG9wbWVudCBlbnZpcm9ubWVudCB0aGF0IGluY2x1ZGVzIHNj
cmlwdHMgZm9yDQo+IHJ1bm5pbmcgaW1hZ2VzIGluIFFFTVUsIHdoZXJlIHJ1bm5pbmcgS1ZNIG9u
IHRob3NlIGltYWdlcyBpcyBhDQo+IHJlcXVpcmVtZW50LiAgQ3VycmVudGx5LCB0aG9zZSBzY3Jp
cHRzIHNpbXBseSBmb3JjZSBUQ0cgb24gYWFyY2g2NC4NCj4gV2l0aCB0aGlzIGNoYW5nZSwgdG8g
dGFrZSBhZHZhbnRhZ2Ugb2YgS1ZNIE5WIHN1cHBvcnQsIEknZCBoYXZlIHRvIHRyeQ0KPiB0byBp
ZGVudGlmeSBpbiB0aGUgc2NyaXB0IHdoZXRoZXIgTlYgd291bGQgYmUgc3VwcG9ydGVkLiAgUUVN
VSB3b3VsZCBiZQ0KPiBpbiBhIG11Y2ggYmV0dGVyIHBvc2l0aW9uIHRvIGRldGVybWluZSB0aGlz
IGFuZCBmYWxsIGJhY2sgdG8gVENHIGlmIGl0J3MNCj4gdW5zdXBwb3J0ZWQsIGxpa2UgaG93IHRo
ZSAtYWNjZWwgb3B0aW9uIHdpdGggbXVsdGlwbGUgdmFsdWVzIHVzdWFsbHkNCj4gd29ya3MuDQoN
ClRoYW5rcywNCk1pZ3VlbA==

