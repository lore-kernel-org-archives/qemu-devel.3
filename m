Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F59C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 15:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4iCV-0004bi-6I; Tue, 15 Apr 2025 11:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u4iCR-0004bQ-IV
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 11:27:48 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u4iCO-0005bV-L9
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 11:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1744730864; x=1776266864;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=FsOl1xqrlAUgPaZyCuFFb2MlJfDJ9HtmyJod5Kqr06E=;
 b=MkG/4me+SMhRCijcNlaic0e1Uu/Q0BKdu7TkS4ERYn7+79eCH2sgpqed
 VKnA0wlX7nDydiC053U9Y5+uGRDYfR7qgzYH0sqm/xDIe2rkgvxK1P1Bb
 enPaOfcI61pEU+DTNmHLQ7IoBPIVxBMpbsf4iukYp9m/npKUIJLRJoxxr
 Hmzq5GwDbWHm2gGS3b0iogHB25ekCNFozgJBBiOboG7IYops91l7MBiNP
 0ankXdD6UQOSjEqynt0LUjOckZttSfu19zzCUWB1lAp2QhP48es1LpwE6
 0NVnOJkRQdVTYPSmueRuUaMsOn7Objh+7O0QPbtMIGg5acZ4FL/+DB8qP A==;
X-CSE-ConnectionGUID: oLfHGqbJSJWzrfcfdZ/f1w==
X-CSE-MsgGUID: kebHeL4ZTrGuPVSShbRqHw==
X-IronPort-AV: E=Sophos;i="6.15,213,1739833200"; d="scan'208";a="35104264"
X-MGA-submission: =?us-ascii?q?MDEa6C7CAcgAa0CI6LB5fEbG1cUFtPbnqrxbF1?=
 =?us-ascii?q?oueiRsPWVaiD/JTWwT3xdjWauT4MEphuk0hMsj+VIyOMeqrHXcLuuN2+?=
 =?us-ascii?q?WUFGfkHcoawRF4kngKBqbr+0rfoELFhTRY4lBU+PgR4btJ7rpirFOxAQ?=
 =?us-ascii?q?CquomZZvZKvla1EnaHRowciw=3D=3D?=
Received: from mail-vi1eur02lp2047.outbound.protection.outlook.com (HELO
 EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.47])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 15 Apr 2025 17:27:40 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFsUr03+xzO6el2mWrXxlKQQ/2HfzPFQRJe8qQizhZqvfna6et0wAhGdGy0L4Rdn0vEVNrQdQH+HsK0jO781ynbP2GIzZuVGcHxDhKvAFhC+UWcIgGxYWm34JnFs00nIldicsBJsd98d6e0eveBwGn6GtRdzGHOi+o2I88d8ajDq3AOBt3TVma4Sc4Tq206PVDG1CRjuQpfzU/KKd6/0lNshHyGgkHk/RuGptrqece3xJ5baSHaEiMagk8R9CvnUh+OwbtjdHEye2jJYYeCjc1rRMIPBVoPKoqYm7U5CY/fkH5Bs8A5mVv7i9tzzZq0k6dmVBnSntf3CLP7e45paGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsOl1xqrlAUgPaZyCuFFb2MlJfDJ9HtmyJod5Kqr06E=;
 b=fC53hhWINkzJKXboHVMVKiLCF/jCy3RGS9pkNzcAc8Qsa17tVBzKnV8vX7Hw/RxWIpMtIfCM6bMt6aoSyAn8U2uzYWyX/Z3gk1mWfKk0oDhlsRr2M0af080sQQJyfp8FokYIIxrF7xhqf4zHTuBg34lLkQOIRQ9yLw/WjbQ9GzzHvHxoTcCkpZfxmniWmacIf2ZYUD8h1CB5tjN4svmupj8RPUleL5G9vVjl7zJZFu5lAadSP0zmjJ1PJcO77aT15t9coBhxyg26Q8o5GKJd8giAPINVo0bbOvX/xMf7qgRJVDNNrvWr0otKFOhLeDU+JRSJ4QAa5CIm7UeKll77dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsOl1xqrlAUgPaZyCuFFb2MlJfDJ9HtmyJod5Kqr06E=;
 b=gQmuJGc0fukCwXUWgxAa8epHSGjQtFGpgwtwntbSFStzGIV9WIgBDZJ/yVBCJVl1QipuZq+VDG/AHA9RePkJl5aPanWT1EbmVV/FSn2IsFVEnj1c+2ikY/WhKclJVQxPIhD+LCtqQjiAEIFwJrwV3GDraoeoE+sytLmwhU5wYDn47rQiNuJ6arFa9Z9uDCvMhfEWvyjk65en3GMO0hXNTKiCEdOVG8mcjauwpJsVGJym5uOwe9U0Ctev2ZxQV3YSDY2QYbvhVgAhFYxnvU8R/9c6KP/2qGp+3uxdwDbLl3tAN81fPuHTEvdbYpwoXkrxySH38Ve5Uf2FNelNRwl0Rw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB8872.eurprd07.prod.outlook.com (2603:10a6:10:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 15:27:39 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 15:27:39 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, 
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
Thread-Topic: [PATCH] intel_iommu: Take the bql before registering a new
 address space
Thread-Index: AQHbrc4nGIHWbw444Um4nXxoEvkhVrOkdnQAgAAnMQCAAABHAIAAAOmAgAASFoCAAClNAA==
Date: Tue, 15 Apr 2025 15:27:39 +0000
Message-ID: <28b62fc0-4f31-4d19-ae71-3b5cb61db864@eviden.com>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
 <c6f8ace8-6dfe-4ca7-992c-2fd10faa6127@redhat.com>
 <ed082405-06a7-4407-9230-3a9b7e91406e@eviden.com>
 <CABgObfb4knJpLiPsQY35dFbT6kpS6p4iKcjHTeUn3_9A_8XSpw@mail.gmail.com>
 <88a62763-cb43-4984-91c1-ead8136c7d2a@linaro.org>
 <fd485969-cb3b-458b-a1c0-b461fab5f22d@redhat.com>
In-Reply-To: <fd485969-cb3b-458b-a1c0-b461fab5f22d@redhat.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB8872:EE_
x-ms-office365-filtering-correlation-id: 8efcf782-c1e2-4434-d47b-08dd7c320ea9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZFdYaUx0ZjI0eHF5bzVEaDJnVUtkeUZXS2FJVUkwbENOYUcyR0lTSE9wbHBR?=
 =?utf-8?B?aXF3b09GYW5KSGVyV0ZjSnREcUlOaEo3eXJUbnloNEtZWGVVb09oMkdVSUx6?=
 =?utf-8?B?VTRURlRFa08rNTl4V0JxekNpYythV29JbEdxK0dlajVERWRGUGR2MmF0cHFL?=
 =?utf-8?B?ajlEbXJDTkVuM25TZk9tYmI2UGt0cVhQbW96MFo0cmxjWFZQUEFwbUxGZlRW?=
 =?utf-8?B?RmljaDRoK0h3R0hNZUtHaXpVWXBaS3RKcDFHMXVWaHl5dG1Vbmw3VHpHVHNr?=
 =?utf-8?B?d0FQYVl6am4yVTZZVEsxOVZLMWh5QzF2U3pxblAxV1pxK2lpUkFoYlZGanN1?=
 =?utf-8?B?R3BCYWdWZkkwdnZvVUF1UGZBV241TWxteFRMdXM4VDlDcHdOU2JMK1Q4SDd6?=
 =?utf-8?B?aHJhanNuVWdEZnRzcC9rZ0xHeUxVUTJEOHVQcjZscjJTcUFMaWVaSGpaOTFG?=
 =?utf-8?B?dUpnR21Tc3Vha09WbkJkSjd1TFhjZWJpMTV6YnNoWk8rVFRsOG9ZZW9vN2ZO?=
 =?utf-8?B?K3A1c05QMHV1bEJvZzVBVWFjandKRkdoQkVEM0MrNU9sRERJeEh1ZHJRSFh3?=
 =?utf-8?B?b1h1WjgyRVFyRTMwMjFsVktoTU0vQVRqaWVaV0ZMb2txM2xZSUNiYityWWlx?=
 =?utf-8?B?eUJQUlo2V2xDbWtxMnNPNCtuY2FwZlByQllRQytPNXU0b05FWTFZVmkxT2JM?=
 =?utf-8?B?V2lXd1NQMmczZms0a3owYXVoaVBmWU5GU3VKdzBTWjJOcGRCRVNPUVgvYXZG?=
 =?utf-8?B?T1ZSU09FeWtnQWpHdEMra3dSdUtIVHNDd3pGY3lDYXdCZ1FQS01qYlNsMkxy?=
 =?utf-8?B?eTQrcWtwdmE0Z0RxSTdrT0lBL25BakpEUnB0QndlaHo2NW82ZVBnVDBBcjR4?=
 =?utf-8?B?d2IrSmFkK05qK1l0Y2RKb0FKY0Nic0tOODdMTFdJQytGZ1hhK2ExSW9RdG4w?=
 =?utf-8?B?YUg2c29mNE9FckNJQXFyTDlYYndOYkQ1b2JlTklBci92aW1TNFJmK3hzN2R4?=
 =?utf-8?B?Qys0ODhvMzRqYytpaUdxc045T1gzZi9Nd1N0dmQ4bzNzVEszSDJCZUNpaTJz?=
 =?utf-8?B?WkhLVGY0VXNmdHVWQk5pdVJ4ODZ6ODdYZ2JqaExWSTVHOVJ0TDhDeEdCZ0hB?=
 =?utf-8?B?NEk2Y3UyTWJpWXM5OU51YlUyaktkbkIzRGFpbzRSbXlFbVdEYTVjK3d0OXZr?=
 =?utf-8?B?MFhpVElPZGhaRlJhNGkrdVNHRFFmcFRJeFlGZWxJSG5GZjRPQ2lhZ0hSNVZM?=
 =?utf-8?B?My9OUy9CSVJIcUhqNUtObHJlbnRpa2h0d2ZSaWhacm1UVGNGU2tZYmJ0YXdE?=
 =?utf-8?B?c2tmQTdGMmlNQlRsVlF5aGE1cWJ5V3ZWVEsrYjBrUVVGZjh4SmIrRlpTYWNG?=
 =?utf-8?B?SmF3VW1idXBiWmtZOXVkQ25pWnhDUWFhWTJ5WmdOZlQ2QWNyWnFiMkpna1lo?=
 =?utf-8?B?ZHFSV1FZYjdXams4SjFLQXMyeGRraHJNOXhZblFDVTQ1V2EwdjhGQlRIcFda?=
 =?utf-8?B?bitabzRpUzNRVTBvM3VhdjlHR0RPZ2lNRzJLR2ZCUEo3aXhRT3FKTzBLS1Z1?=
 =?utf-8?B?SE1EUVRGKzdsemJ1UDR4bjN2b0JVeUJDTTE5YXY2WmZMYnB5S1JDdWpjcUlJ?=
 =?utf-8?B?Y3dBN0JRbkgxMDRvc250b3NPelFTMGY4eTBNZUJJT2U5aDdKR2swMFR0dWc5?=
 =?utf-8?B?ZGgxV0VMNDlJTER1UTBlOHMwTUQ5cHErdjlBRS9NSzFWdEtJZ2E4RXVJYVdp?=
 =?utf-8?B?UDk1RE5aeFQ2ZXhWTVVYdDR2M0VRN3F5dFBOZTZPWHBIU0hqdkMrRFJlZHBq?=
 =?utf-8?B?T2YrQlZ5d01ISGl3dkQ5b1NVRE5NYjYvQS9yMmRwckVjQzZWdHhmbm85US9r?=
 =?utf-8?B?a05GaDF0NTZJOE50UG13SzZZWTBZazcyTUlGRjh0bW14UTNlZDNWb0FWbDNO?=
 =?utf-8?B?cFNFMGhva2h5RS93eFIvcHJBNVI0UnhpdHdaMnY3WkpDaDN3SDBTcGlCc3hG?=
 =?utf-8?B?SGx6UDRtZEVRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmt4ZFNxT1VGUGo0OVE5cXdYTkhRRm5jZ21iVWo3REkweGE5TFVSZHdIVEhR?=
 =?utf-8?B?dG1OUTEwTDFxdTF5aFJDcnRDYit6bFg5b2o5R3NHWkdOTUMrQmQyNXkzRHVm?=
 =?utf-8?B?b0dodDJURFRzK2prTzlyWFpwS2hwbVljMng0UWZqNDhadTNGWmQxc2N5bEZR?=
 =?utf-8?B?cW9YVjV2dmt4WnhSMDJSNEFUVDl3MzhqQk5TcDNVTlk5eDZwNjYxMEVYSUcr?=
 =?utf-8?B?WlA2aGtrTC9LTWdWMlRzTTYwR0NPTUZvRk02WUxDNVRtZXdDS2pnV1VEeWxO?=
 =?utf-8?B?U3o3UDJIRm1ab3ZacW93OHN0ZnQzUE10TUtDdFdhbzM0WlpXcW1NY0xZM3JW?=
 =?utf-8?B?ZHZ0MFlJNGY4dmdQZWI0RVVkVUJzcjliTkxGNkRWZ25iWlFQUXB5Q1haNmdx?=
 =?utf-8?B?RXdpMk0zMzFWQ280a0RRWnFjY3ZvWEd0VlJSUktlc3B5dmsvSFJISE1vNWg1?=
 =?utf-8?B?YkhucTl6UGh3QllCRlNWdzVoVzJWUVNCVC9QL1ZINW5kL0xHa2dBZ0c5STBK?=
 =?utf-8?B?ZTAyd3VkTlB2U0Q0SVpIclFMemZEUzNjcWRsc3FjK0JyMi83Wk80U3NCQkda?=
 =?utf-8?B?UzVrQm9zV1FWb0RUSzcyUkhjbGwrQVkvUEV0czBRYW91R2luRlYwZzJxYTYz?=
 =?utf-8?B?RFU4clMrQ04vOUF2QVFac2tmVS8zMHRaMEkrS2xYRFRBREpIdXRyd0dHZ1hO?=
 =?utf-8?B?VUZYQk1wQTBzaTFHWFFEdDhsZWVzUUc0ZitEUjRDQzk5V3lkRHJ4U1ZaTDlF?=
 =?utf-8?B?K0tRTURTTXMxQWZTOGptNUVpNDNxNnlha2kzTEN0N2pFM2tWRWxjRGtSL24z?=
 =?utf-8?B?cnAvTEZGN01oRVIvbW5KMm1iOE0vZkw4YzljRHBzbDA4VWNlenlJZkpkODhE?=
 =?utf-8?B?NDU5WmIxZXFUZWpuUjM4SFp5ZFRxcGpDNmlSSU9ueGJFd21jUk9renVVZDU5?=
 =?utf-8?B?S2NCTWtCQzRLZzBGOGVESVZUbndoVnZqK0lLQzFNZFE1RVZhUUFZT1RIZStU?=
 =?utf-8?B?YnN3S0xBMFY2WS9jdkw2T0RkRjJ5SXA2ZjE2WnY3QXpQUmJsVGE4RzMrU3Ra?=
 =?utf-8?B?VDlVN0lTZ2hqVTB6YWxrVUY1c2hBTnNPS1krSW9JdGFFL2NtbEVxcXRIRzFq?=
 =?utf-8?B?MmV5dWtzUjMzUENmRDZsTElNdWh4OFVLRzdLWUNJVmJNSEw5NmdqN0dVYUNa?=
 =?utf-8?B?VXRIYzFnUUh2ZHZvakdKR3g0cENocGJuZnUwVXZVSlJiVFAwMXZyQUtVNS9n?=
 =?utf-8?B?bDlNSEFZbC9Bck1GTHVsU3lXS1lFRkNYejB4V0NLNTFaSHF5a1Y4ODR5NWFw?=
 =?utf-8?B?a1QwZk13aXpNc0dxTmhJUXFWZXhITnBlVGxxOHpLbWtoSGZybWpzTVVsZ1pv?=
 =?utf-8?B?TkowbnpIVHRGL3BkaVpxRWVZdGc3azduVlRWKzB3N05zRUZUWFR4aXlBNWxQ?=
 =?utf-8?B?Qm8vbXFIUFBjNDlzZ1dpVmFUcUVXcnRiVlJ5Szh3bW9MWDZ3RjlFV0VpV1oz?=
 =?utf-8?B?blE1aFpTZ21Kc1Z4OHkvWWtuOE4yR1VmNmRGaWlHeWNDS2owUXYzMkNLT0hD?=
 =?utf-8?B?b0NJVjRrWTdoWDBZYTRidTRoV1A2VkFoUkNNa3NWb0hxdGdEZDQ0NitqQjNz?=
 =?utf-8?B?czRESGtVWmVEbkFuRzFDNkk5NDJkNGtMU0wya09qZzlxOUZWQUJrSTFXQU95?=
 =?utf-8?B?dHNGUTZRQnV4ZVNsL0g0dTZxSmRHQ3luK1ZzV1RFdXBSRlBNcWE4ZGh6VHph?=
 =?utf-8?B?VklrZVZCbU12THlCcE9BaGM0UGJqVHFDT0g3WWVDMGZHMDFkS1ZzOUt2SU16?=
 =?utf-8?B?U1Q2WGQ2T3llM1hOY3pXY2JLUWRoYTZzZ0ZtenBveWt1cHRXb09XNmlSWXdZ?=
 =?utf-8?B?TlJZRjM0U1NXZ1pIaytNdVFTWHhWOHdjdXlNK1JxWTZrYzIzc0dXUWdFeFR3?=
 =?utf-8?B?SWZKcThBWTQwdjBUNGVnUllRYjk1bzZOWjMvbHIyYWpZSHY5NFhDNTFndmwx?=
 =?utf-8?B?dXgxcm5hR0lCNTR6SDd1Y1U4OWhheEltR240bzBLZzlZWUs5dWp5SFlsNURH?=
 =?utf-8?B?bjdjUHVDMGlLbXFWd2FBNU5FWS9IaS9qK3Z3V1FXaWQ1WjZvQ3hFYVNMSFc3?=
 =?utf-8?B?YUhsYzI2eUE4TXRoKy8vUit6S1IySmlzRkNLQ3lQVHdQMUNDY3ZEM2RBank4?=
 =?utf-8?Q?pVd3sVN4qYk++WkW4KxYtZk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6BB864A0ACA994D8E1956A8DAB2C5DA@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efcf782-c1e2-4434-d47b-08dd7c320ea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 15:27:39.2653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xacEwTk9l0Js6yBtypT3FwdQb60fvuzk+vR18i0D2pGdqhZAh0/tUUhp4E/Z9yfuVEiwCdN12l3rMBGNDn05sXI8XOV9tYdtEZarrixd+eZIM8sI76xEEDHRCDM8nNay
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8872
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

DQoNCk9uIDE1LzA0LzIwMjUgMjo1OSBwbSwgUGFvbG8gQm9uemluaSB3cm90ZToNCj4gQ2F1dGlv
bjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtz
LCB1bmxlc3MgDQo+IHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiBPbiA0LzE1LzI1IDEzOjU1LCBQ
aGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+IE9uIDE1LzQvMjUgMTM6NTEsIFBhb2xv
IEJvbnppbmkgd3JvdGU6DQo+Pj4gT24gVHVlLCBBcHIgMTUsIDIwMjUgYXQgMTo1MeKAr1BNIENM
RU1FTlQgTUFUSElFVS0tRFJJRg0KPj4+IDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNv
bT4gd3JvdGU6DQo+Pj4+IE9uIDE1LzA0LzIwMjUgMTE6MzAgYW0sIFBhb2xvIEJvbnppbmkgd3Jv
dGU6DQo+Pj4+PiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVu
dHMgb3IgY2xpY2sgbGlua3MsIA0KPj4+Pj4gdW5sZXNzDQo+Pj4+PiB0aGlzIGVtYWlsIGNvbWVz
IGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+
Pj4+Pg0KPj4+Pj4NCj4+Pj4+IE9uIDQvMTUvMjUgMDg6MTgsIENMRU1FTlQgTUFUSElFVS0tRFJJ
RiB3cm90ZToNCj4+Pj4+PiBBZGRyZXNzIHNwYWNlIGNyZWF0aW9uIG1pZ2h0IGVuZCB1cCBiZWlu
ZyBjYWxsZWQgd2l0aG91dCBob2xkaW5nIHRoZQ0KPj4+Pj4+IGJxbCBhcyBpdCBpcyBleHBvc2Vk
IHRocm91Z2ggdGhlIElPTU1VIG9wcy4NCj4+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IENs
ZW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS0NCj4+Pj4+PiBkcmlmQGV2aWRl
bi5jb20+DQo+Pj4+Pg0KPj4+Pj4gUGxlYXNlIHVzZSBhIHNlcGFyYXRlIGxvY2sgaW5zdGVhZCBv
ZiB0aGUgQlFMLg0KPj4+Pg0KPj4+PiBIaSBQYW9sbywNCj4+Pj4NCj4+Pj4gV2UgbmVlZCB0aGlz
IHBhcnRpY3VsYXIgbG9jayBiZWNhdXNlIHNvbWUgb2YgdGhlIGZ1bmN0aW9ucyB3ZSBjYWxsDQo+
Pj4+IHJlcXVpcmUgdGhlIGJxbCB0byBiZSBoZWxkLg0KPj4+DQo+Pj4gV2hhdCBmdW5jdGlvbnMg
ZG8geW91IG5lZWQ/DQo+Pj4NCj4+Pj4gSXMgaXQgYSBwcm9ibGVtPw0KPj4+DQo+Pj4gSXQgZGVw
ZW5kcyBvbiB0aGUgZnVuY3Rpb24uIDopDQo+Pg0KPj4gbWVtb3J5X3JlZ2lvbl9zZXRfZW5hYmxl
ZCgpDQo+PiDCoMKgIC0+IG1lbW9yeV9yZWdpb25fdHJhbnNhY3Rpb25fYmVnaW4oKQ0KPj4gwqDC
oMKgwqDCoCAtPiBhc3NlcnQoYnFsX2xvY2tlZCgpKQ0KPiANCj4gT2gsIEkgZm91bmQgWWkgTGl1
J3MgcmVwbHkgdGhhdCBjYW1lIGEgbGl0dGxlIGJlZm9yZSBtaW5lLg0KPiANCj4gWWVhaCwgdGhl
biBJIGd1ZXNzIHRoaXMgaXMgdW5hdm9pZGFibGUgKHNob3J0IG9mIGFkZGluZyBsb2NrcyB0byBh
bGwgb2YNCj4gbWVtb3J5LmMtLS13aGljaCB3b3VsZCBiZSBhIGdvb2QgdGhpbmcgYnV0Li4uKS7C
oCBCdXQgcGxlYXNlIG1lbnRpb24gdGhpcw0KPiBpbiB0aGUgY29tbWVudCB0aGF0IHlvdSBhcmUg
YWRkaW5nOyB0aGlzOg0KPiANCj4gLyogU29tZSBmdW5jdGlvbnMgaW4gdGhpcyBicmFuY2ggcmVx
dWlyZSB0aGUgYnFsLCBtYWtlIHN1cmUgd2Ugb3duIGl0ICovDQo+IA0KPiBkZXNjcmliZXMgdGhl
IGNvZGUgYnV0IGRvZXMgbm90IGV4cGxhaW4gaXQuDQoNClllcywgSSB3aWxsIHBvc3QgYSB2MiB3
aXRoIGEgYmV0dGVyIGNvbW1lbnQuDQpUaGFua3MNCg0KY21kDQoNCj4gDQo+IFBhb2xvDQo+IA0K

