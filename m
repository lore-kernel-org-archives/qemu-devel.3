Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB757C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 05:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCAWz-0004f1-Oc; Tue, 06 May 2025 01:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uCAWy-0004em-AX
 for qemu-devel@nongnu.org; Tue, 06 May 2025 01:07:48 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uCAWv-0004bK-E9
 for qemu-devel@nongnu.org; Tue, 06 May 2025 01:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1746508065; x=1778044065;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=a6x4j/EMWi+/2iu7i0QD8xaGt6VZy4dv8ChRvIlq9T8=;
 b=mAMnfqrW6Qnd38RGGcmy+2LFqCYm5IzVdoKB4Qe5MABHiDw2r4Hikdvm
 nkNGQCxLwTBxsO+xyO1fT06JjqgwBLZCTty05pPki1cUpG6HrGquW4mMn
 s3TvXhCd+8JLxXwLTh1WgHYJ0AwGve/WKnhi5P3QNJhwFlIs6R7fRcAkZ
 iGKi3TJkAPhOvrkj4jvC0iZs8z/ko5aj1VSKNq1VxBCsjxxFEVb+xGXXZ
 tr8A1cn2mBhjZe9EcZVwjEIsGnnq4d8gF0uDobse3K8qkjIkgCemkeSgy
 q1OB5ZO9pcbfL996LA8dhCYCbIUy5I7xC0SOVBmPFkAvlGXvzCg+RT185 Q==;
X-CSE-ConnectionGUID: pasD3U4FRhecAqcAHtIJ8g==
X-CSE-MsgGUID: MqVmuplUSLSWds4wEEskmw==
X-IronPort-AV: E=Sophos;i="6.15,265,1739833200"; d="scan'208";a="36299414"
X-MGA-submission: =?us-ascii?q?MDGUiXB7BnQIc7kmXCDq74HFrPY26ptnw06t2f?=
 =?us-ascii?q?CXVuhd7oGnGoaaQWf+R4178DLeP663DHe5f0C3LH9xwh5yohrkryHrwF?=
 =?us-ascii?q?o5MoOSNJNcctJnQBZMIUY7Ql1aPIdlGUvC5RrGV8rklSvSSt3nPrjzH1?=
 =?us-ascii?q?F8mPx5G/+UQNaU0GxHEJ7sbw=3D=3D?=
Received: from mail-westeuropeazlp17010012.outbound.protection.outlook.com
 (HELO AM0PR83CU005.outbound.protection.outlook.com) ([40.93.65.12])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 06 May 2025 07:07:40 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMlygsY5OrVv+oog90xwUPSPWnpVgTjNWo6EleSTZti288wu/TpahyCMVNEvtj4UYgrkKhuDeV7sH+xa/eXZVbAN3e+Qsh/SlD4RCaB1/EoRnhCgNZR+g9qbrvJ1laCHOFsJXoPO2H0sqc1nbtdbUOokG1kVnJSWN51+j9uiGspybB7C+uMTZau6ED59shbD52PwXl5a7m4gYN6LYiQPKYjxgFMXsE7AwhIxDKFx9neeLKGF7WZs6BFQtgre2gguhZwnkZ59jqRSDWpHBoQBeg20/ohmOMRPx/DWm7dxG7hWXBvCYOtW4aGCw9UliQI2rdmqpEe1g3uPeg+02tL+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6x4j/EMWi+/2iu7i0QD8xaGt6VZy4dv8ChRvIlq9T8=;
 b=qZmW35tASF3rKro1V3bes9Z8nAURRLVTaZhP4ImL+/QyDsMm7XeTpkI7Bnk4bWJYW2n4mA5/wOYK9+vgq+QeD41RHScAlKlXLJrGInvvH9AjK8jvYqjPVgHYMAg7iBUvxjiLb/oCmb6NdM5KbkkAN2AUtB5SBhDXJJ4xJy2a8oaiT2dcf284PS6J+ca1kBmG2ArqTTlnSfbjUH6OQ3v1o+KD6PmKTJcoxiosAbfLlvlQBZ8WiwYcW5mcmkbVVQaqVNcopay5Q01QSFejNL+yJbpyPLQPoh7q+wFEXsxNwAoyJD7/cVMpR5rVdlNp0A+kiJdwU8NBdM84OCpEAvn61A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6x4j/EMWi+/2iu7i0QD8xaGt6VZy4dv8ChRvIlq9T8=;
 b=I4oP56el9cKAvWi5rDokZuiOY8mgZe9DljQIAo6wAmw8fwvNvqn9NujOrTpLFiy2Vako2kKc7PiytQYzrnaTyqVq9knIWJgIBASww0PPLVioeHXiMsX9lwsYriysRJGrp1GZHboIMVDgFyIZCeIAHnk1e1OlX5/S0+vFH4w0DP5bNqXDnAJCq9BOTyNQOldA73leff2bNkc944hBFpsSrIkxPI/KeK5Jw31z6UBG7jVncQ9ilvbYWKjCF/XIubPaA4ZaXQqTYdxCDYszBLDmmmqBO+vPLojQ8G6FvFpydT4X8r3Z7S44Dn71lLSQ4f6oKn7M9S72sLw6HVXyTS+eMg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM9PR07MB7683.eurprd07.prod.outlook.com (2603:10a6:20b:2c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 05:07:39 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8699.021; Tue, 6 May 2025
 05:07:38 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v5 0/2] intel_iommu: Fix locking issues
Thread-Topic: [PATCH v5 0/2] intel_iommu: Fix locking issues
Thread-Index: AQHbuc4dH+dO4qeI7EuJ1zAypjI1y7PFFeuA
Date: Tue, 6 May 2025 05:07:38 +0000
Message-ID: <64fb4fb6-758e-4c1d-82d4-e10add089461@eviden.com>
References: <20250430124750.240412-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250430124750.240412-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM9PR07MB7683:EE_
x-ms-office365-filtering-correlation-id: 1cb3ddae-f456-4002-22fc-08dd8c5bec26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SWFZUGUycGtrSlZHMDRwWEE3Snd4U0hkZ2Fnb1ZNY3FCNU54RWpNTklBYjB5?=
 =?utf-8?B?TnNrT3IvejdLZEk1ZGNWM05JZ3MxYnNidHRDelVWTFVybk12NXZvRC9CMFZj?=
 =?utf-8?B?dDBBalF3MlIvbXlwZGxFWVY4MEg5SW9sQ3RpQ1NhTHB0aStkeWpHMU5hRU5G?=
 =?utf-8?B?akZNbXBHSkRkdVMyK3JkVmNTUmhmZ3h5TU5UNWh0R2dpM0JoNDlWNjVCVnRS?=
 =?utf-8?B?dTV3QWRKMTUyVTdHcEltemFxbVdDMWtjd1pzYzNzYlN3L2hHZW1lVXk0RDRD?=
 =?utf-8?B?UjNFMWVTeG4yNHc0YkZGNUd4Qmhia2ZjN0dXRWRwOGRNMWVPYWgzTXBvaGRv?=
 =?utf-8?B?TGJWVitHRzMyRzhtN1ArWGxQek1vaWRUc3FFd3dKRXlSUjlhbnNEcXIzcmxq?=
 =?utf-8?B?L1UrY0o1ZmNyOHFWc1NscXVmWFQ4QldxL2I0bi9QSkZURDJPd3NuR2phbk5s?=
 =?utf-8?B?OTNWa2lMaWJmRU82U0hjK0RjS0trK1RteWpGSmwrWFErRGJubHAxZEpZemVi?=
 =?utf-8?B?NVVoTUEvVktxU0x3SGtBYzh1TkxhRWpwOTgyVGRjeXFUbFpXOXZFakFKWjc1?=
 =?utf-8?B?QW44NFZua0d6Ny9rMVBZMUlqVWRWUGh5STgrSE9udmtad2RsK0duRzNrVlNG?=
 =?utf-8?B?UUgrR3dTTkpJY1dGQVNjeDl4bnRYZkZPUjNnZ2UvYnhhQ2FyVHUxWk0zVTBO?=
 =?utf-8?B?ZTRuZFJZbCs3a2pMb005NmRXaXdLUkk3dTk0cnZBZEZuK3JOZVU4RUJzV2pl?=
 =?utf-8?B?VERadzV1TXBSNThPTkpzNURrdzdzSjduUEovKzVCeHd6MnJUTHRaaVVCVXlC?=
 =?utf-8?B?M3RlU25yTlFlYjhwNFlQNExaMksxR2pFSndqaGpmWUlNa0hQZEJZODNHZnho?=
 =?utf-8?B?cEQxS3Q1TFF2MjBsQkRmZHlsc1k0UUNjbDVONTl4OGNkNm1xbm1CUUtNbm16?=
 =?utf-8?B?QkFRbXJiTTFVZ3phUFVvdTJSalhydk9SazlzbEFGSlorVWdPbkN6RXVXSGlp?=
 =?utf-8?B?RzEyU1hidGYzYjFuekhTSmtRaUdsdWpkb3djYmpvb0F6OENPMXE4dzcwL2xY?=
 =?utf-8?B?ZlZrM3pJdnloM2RoZXZKcTVYMGRhNkJvOEJ5Slk5WFBNR1JvNG5SVVlDUnFD?=
 =?utf-8?B?SFJEY3huTW5GNUd2TDZEMEdVNHloQ09uWjMvd2t4SDlCbEh0dnltMjB3Q0hY?=
 =?utf-8?B?dHNCY2hmSkljamZWLzBxYjJWemw5TUswbVV6K00wYm9sdlFmbkpXZGhUaGtX?=
 =?utf-8?B?NmIxUjgzQ2tHaGFGNm9yQmJadWZnN0FJcDBXSG9UMUE0Z3Awcit5M2wwb0ZE?=
 =?utf-8?B?aEVKZlZ1M3d5U25reTBnOW1xVmJRS0hzdlFReGVSYnJJMXMyQ2lhYTdvaFkr?=
 =?utf-8?B?ZnVmOXAyRXZhR0FMQis2YktPU1dNRVZZaFpzTU9FazZNcERMMEM5Sk10eng4?=
 =?utf-8?B?SlZ0Y0g1eUdML2t4REl5bURFZ2xtZlR1amc1OXpZVzJkT09SL3VsTWhBWVhi?=
 =?utf-8?B?TVIyYUxDbzlSMkYwTUZhVFN3cEFkUHY0ZzVEQS9zcVFEWlhXRDBQV1FOOE5o?=
 =?utf-8?B?MUhRUmZJbkVYTUhhL2xEckxXdlJ3MVFGaHh2OTVvanBCcWNQbWNtNklsQ0t3?=
 =?utf-8?B?NzBsZzZUTHhaczRQdmJ0eGNoWnUwUjdVazdWOFhaYUZOQlJPSms1bUYxU0xu?=
 =?utf-8?B?VkszRnc5bGVITmN1UWNLTVE1aTBERXUrTXhvSisvMW53QktkMnJXMXBFL0tC?=
 =?utf-8?B?cEJGWW1FSFJXYkFZcG1wVVN4NFZtWHkvQjZnNS9uVVNXYUNzWE9IdWxmNDJF?=
 =?utf-8?B?L0o5VmpRSE9EMS93dk9teHBBRUV3ZUJQNThjTWxaZWF3WFJDTHp5bXkvTXgv?=
 =?utf-8?B?bmw0TVROUGJtRjVkSTJuRFNXd2lJZUwyTG1uZXpDVlpXbm5xSUUrQ2xNN29Q?=
 =?utf-8?B?R1ZtOE9naEI5amZSQVhYS2tYQjBmSXBpVWd0OGJmeWNNN3RDRklJZkJTbFdP?=
 =?utf-8?Q?7t9SQw6kT99ApdKeQNWX+8wjTTwhOg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0JmRlVObGFmRlpudjRlWHpzUWZsQm8xOENHUUpwZkFHNGNOVDBUdGNxQXJT?=
 =?utf-8?B?bGl1amxZcWFrUFk0THB6dndScXZ5S2lhOWZWblhKaVRDOFZ4dm5XSVVuSlhE?=
 =?utf-8?B?SGt3TFFPZUxLVEZQbjdtK0YzWUR4bDNQcVgxQkpISE5JNHRJOWFOVFhadWo5?=
 =?utf-8?B?RlRhdDF0WmZnZTZwOE1GVkNQcHdCZ24xNWt2eUZ1OE5na0NUcTJoM204NGtF?=
 =?utf-8?B?Q3FaLzFWNjZ4bHZyR2xFSi83eUkvaU1UcUJIcHlTR2Z0N2pwOUk1d1pQTEl4?=
 =?utf-8?B?a0tGV25wQnZ5bGUyYkgwdms4VEl2anVGS3RaMzMvYXlEZzdIZVJrV1ZpUXNO?=
 =?utf-8?B?ZGNXdXV5SmVQLzRUUFNOMFRaVEk5ZDBOYWltTUs3N0lLYURnU1FvU0FrcXM1?=
 =?utf-8?B?RnVuU3YwZnhSTTdVcUt2K1EwcERYUjNQUmU1MlFzclpRZVhLNHZSVnlTZk14?=
 =?utf-8?B?YnVoYXhvKzdrNkp4a1B1YVJEQzNieS82bndqeXVsVlo3cUc3a2Z5RlhEVGU1?=
 =?utf-8?B?bTVjYTcrbzM0MDNhNHVyaVpDcGVaL0xadE1OS3NGVGJBUjBXT0NLanZCQ25B?=
 =?utf-8?B?WFFrN2VaOGpEaC9taWRkMHhmUWN4Zkd2aE54RHdWOHNZenB5anVDOVFHNGtE?=
 =?utf-8?B?ZDc1SlVDUFgwR2VWU3R1RXU3Nks4QmtIeTREY0hJQmhWbjdMRUN1WFhQMVpw?=
 =?utf-8?B?a1A4SWRmU1dKaEtTK2NWTmlxR2JxMU1vUjlQYTZQSnhxbkpPc2JwTEdqNUxx?=
 =?utf-8?B?dk5PWWZyUnIzeVBYRHNEWkd1SHJUUjJwSDBIenRCbzRyNjZ4Sk8rWTB4cXhY?=
 =?utf-8?B?djZLRURXL1lhTUtQb05zNVVEb09CS3FNeXNwdm1mM0duT25lWHQwdlN1Zmc2?=
 =?utf-8?B?enhzWENKM09UUE1rZ01PRloxTnczOStrLzVrL01vMTNmTTdzb2ZkOEN5R0pY?=
 =?utf-8?B?VDhzbjVOM1loN3NkVVB3RVBnRkJZSzU2WkJPeHNaR2I1d0ZZaXUxZEtDYzZM?=
 =?utf-8?B?cDI0VVE2MlpTVjlFVGhEQmpyc2ZuUW5UeXhJa0QzdnIvZmxJNDVJb3VGczdY?=
 =?utf-8?B?eU9TaElyZDUrbnRJMXBnUEdkWDRiaVpNbUkzK1oySHVXVnA5VHlVRVRwdVg2?=
 =?utf-8?B?bnhLSWhoSWM1NlQwNnpZYnFMVEdaMTFZR09mZG5DRXVTMC8ra1ViV3V5aDQx?=
 =?utf-8?B?L2xIUmo0L0Z2S2lvVTN2a2RwRGFMWVNLNDU1UTYxRVl4S05WRGgrQjJZWEpB?=
 =?utf-8?B?SDdEWmkrZ3lhRU96eGw3V0k5QThoaWFNZ3FVVWR2a1ZXSFJZQXNQUzAyOWVs?=
 =?utf-8?B?ZmZlMXpxTTl2anlaTnNLbXM4TU11TUdSNWJ5R3VvNm9ZckRRK2t5aWxMUERw?=
 =?utf-8?B?NFAycWhMS2R4NzBibnl3bzZzaDZIWGtNL3N0b2RPWDM3c0dhbGVSd3paRzE0?=
 =?utf-8?B?blRmbThWTnA4aDM2ekdyeVZaeUhlZlRwbkNwME5nRUEzMDVJWkhuaVMxYzJV?=
 =?utf-8?B?NUh4NVI5LzZFamFtQld2S01TQ25OaFQrakZDOElGZTJyRndVOVBnY2VXTTFE?=
 =?utf-8?B?QlBpSWcrTHI0T0k2K0Z0UGpxeXRxUTg3ZlpaYmw0ODF4VFJ5VlcxeFI4SEpn?=
 =?utf-8?B?SHRyYzFmL2o2Wk5wbENXUm4zRlhZa0w2ME1tM3VJTXVtdE5iQkFaUGJaVVZR?=
 =?utf-8?B?cFRXNGc5aTU4YjJyWmp4OTc2ZGFmelJRVExYNndIdGdSTlZlNUJFQ2I0TTRJ?=
 =?utf-8?B?eFhqMnJUTXJLNm1kNHc0UlUyZXJoT3Z2VGZ2NkhnODBVZGJMOGNWd1RDV29B?=
 =?utf-8?B?dnA3WVRuVGExTWl4RytidmZJN3JweEIzazhBQ29zaElRM3VVdm1QVVBabUxB?=
 =?utf-8?B?aFVGMTlGZHFpY0h5bjVrUkZvNTZWWHpTRDY1c3Rta3VScTFMMHp3R3c5Q3pI?=
 =?utf-8?B?VmRlYmFoRjFGMVVzVVAwc0Z6L2dFQzN3czR4RmkyRXNDdzMvU3drU0JQZTdi?=
 =?utf-8?B?NS92amNoaTE1MlgwWVQybUg1eG9Bb2dXckl5Q2ZURHJYWUFiVGhWVnFvTE9R?=
 =?utf-8?B?aW9Pcng3MStIMUwyMS9FUDBCUkJyZDU3Y1FKM1c1VWtNUFZ0RjlhSlpvR25M?=
 =?utf-8?B?VzI5akVZVi9CbE1VYmpnREYzWHlpT0JzdDRkL2pWcFpwVmRPUS85TjBvUkp2?=
 =?utf-8?Q?FoE/U94gI3Z3fs3Xr1dyY98=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D0C3932E59A5A4C8646CFBCEF156A0A@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb3ddae-f456-4002-22fc-08dd8c5bec26
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 05:07:38.7970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LBPjaIzCZkDhvpgxch2SRGl0tIdmBe0Q7hziSXAiPYtjVZ8Als4/tgBs8WySVScoMeXawjGRfnA07r1B4Vsu0gRoTRzGUFbt80zDnKIx1EXmolfavjNxhMd/aDDt+0c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7683
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

Q2MnaW5nIFBhb2xvDQoNCk9uIDMwLzA0LzIwMjUgMjo0OCBwbSwgQ0xFTUVOVCBNQVRISUVVLS1E
UklGIHdyb3RlOg0KPiBUaGlzIHNlcmllcyBpbnRyb2R1Y2VzIDIgZml4ZXMgYW5kIGltcHJvdmVz
IGxvY2tpbmcgc3R5bGUNCj4gY29uc2lzdGVuY3kgaW4gdGhlIFZULWQgZGV2aWNlLg0KPiANCj4g
Q2hhbmdlcyBzaW5jZSB2NDoNCj4gCS0gUmUtY2hlY2sgaWYgdGhlIGFkZHJlc3Mgc3BhY2UgaXMg
cHJlc2VudCBvbmNlIGJvdGggYnFsIGFuZA0KPiAJICBpb21tdSBsb2NrIGFyZSBoZWxkLg0KPiAN
Cj4gDQo+IENsZW1lbnQgTWF0aGlldS0tRHJpZiAoMik6DQo+ICAgIGludGVsX2lvbW11OiBVc2Ug
QlFMX0xPQ0tfR1VBUkQgdG8gbWFuYWdlIGNsZWFudXAgYXV0b21hdGljYWxseQ0KPiAgICBpbnRl
bF9pb21tdTogVGFrZSBsb2NrcyB3aGVuIGxvb2tpbmcgZm9yIGFuZCBjcmVhdGluZyBhZGRyZXNz
IHNwYWNlcw0KPiANCj4gICBody9pMzg2L2ludGVsX2lvbW11LmMgfCAzNSArKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25z
KCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo=

