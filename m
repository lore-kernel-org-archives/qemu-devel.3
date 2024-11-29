Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B64D6EBE5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGvfi-00081I-EX; Fri, 29 Nov 2024 02:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfU-0007yG-Fc
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:00 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfS-0002fk-JB
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1732866238; x=1764402238;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rX+tJ+oComjbrky4DpyY1uHu/VCIFl2io6UCQg7jFHo=;
 b=O+vS8tGXThVPbi9+zg0thDpwzdF7jVZak0DYp3VbwsSk1oPW9AMnf3JS
 HZqyjb5x+s3fdjzgHPQXZ9F0OcXd6CT9GH9805vSwmUZ7dykbMrmA/gnB
 Bo+dfTfrBfX6mvEYwSzquC/gsuR4VseZ8kcDFmvKQ6Ib6s1Ql4IhetK12
 LiGnF4i0OQnzR0YEmS11kGJ8Xfh168N7+uHFn5H+QfvgCivc49MZ0NPXf
 wvKk7JyCftnRV3mNsA3cfOOYHVJRGV8viyfZPqeKdWE8EGKGjrnAtX/2w
 g4sByiHdMVHWVJoJT8zvpZD7tKvHK5PQYWDkEmYHvFhNM7GBIOKF1nif6 w==;
X-IronPort-AV: E=Sophos;i="6.12,194,1728943200"; d="scan'208";a="26377116"
X-MGA-submission: =?us-ascii?q?MDEdpAa2xxhhsoRkzAoa+W6H844oFiyu0JgeIu?=
 =?us-ascii?q?Umo161lkVPG8TP/DD82CariAphnXFokZhXMRaUgZoYtwH1IUREXbBi+S?=
 =?us-ascii?q?RXAlBepRSLaunSdlI8aoSalBaSO8DnV+CWnhHyqdqlhE63n467lOWjW9?=
 =?us-ascii?q?0Rn5X1KCZtSYOLMDup8FgChQ=3D=3D?=
Received: from mail-am6eur05lp2107.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.107])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2024 08:43:53 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jelfD5q2cHxiM4rBs9BFbahB9LbMyoO43TBPtcvMKVxd930rzrdgel15M2+TCMeZVZk8FoRVu7mIN3XbVs80YTYhZPu2vdTCq4YCSCNp/+IclUSGbBPAay1cwq5pW97b7Y+BpeuS2LduqMtW3fXjeAUmx1ezHJJ8E8mleFCIt61AmO8zx+rLGtFh4ZJjl3Q/XJauIS/8DybKsLL6FavQ8BnKcY8zQ9vGBtt9WrzaCfktzomthckmU/AY4NQutspRFVYVQxE/c6727Wzb1CrL+M4mStzo6zJs2ySSqM4VmvTmksOteKqwHmIQHi3v/KvIqqiWQJluz4iQ4w627oLeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rX+tJ+oComjbrky4DpyY1uHu/VCIFl2io6UCQg7jFHo=;
 b=Go/sOazKfF10geAhdduZMuYChCPHj0NJPCgKJQBs/StEXiiKUNjddVA7ml5cirQTBihwv3HxS/lB3L9ipXCKkYKZHZ7cGgW9HCagC1yk5dHX2XEdpzT7oOaNjhTY+7QGK2/61ScK3m1aTzyWm3dtRbDN9OHWPah+SgVnDbcnWEWtk1JS5fJc3HmlFM0Cyi6OLsJVOO4ApNsLmjVZHnutsDGkVh21WIAxZYwxcSCflKGyHbXcDiQNUnSIAxofn/6xdCYhdRzHLkEXQNTr+qscwRJAiTGi/Oh5L9Cv6pnw4k+QlBHJ66Ws5wYG7cZ7DRzGBWFOLVPAtWuk2fMyxvOFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX+tJ+oComjbrky4DpyY1uHu/VCIFl2io6UCQg7jFHo=;
 b=s0XLlyFo6Uw7DeVyRQZRSGgzC81Y7SE70MEXwE96cVgr6jCByvgO2JStKB5YuUyXTAN0mpCFz3MVCVB1ZsSSd5skDVLFI3UAObJTw1dzyaFnN7dqMY9OFY3ngSPUAljIOa4CM3bHcPV7wSzLe5/MIXNCy81ykOlS/EqJtIiiymiDOUjqRN0URuhaAE6e75cTvlfLx0qBC3OoKpe685b64POraozsfGIr6RAs+VGdq9DNJisp/44HVVsaZZqF4kJgG59pW5ipWhEy0/z3Gl3aPo1c6y+riFOB1z8yTx6wB/OcuITHrfQXzkbS4ED1laEd8O8LV1AdliyFV6Mr62rZ2w==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7847.eurprd07.prod.outlook.com (2603:10a6:20b:39e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 07:43:52 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 07:43:51 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 04/19] intel_iommu: Fill the PASID field when creating an
 IOMMUTLBEntry
Thread-Topic: [PATCH v1 04/19] intel_iommu: Fill the PASID field when creating
 an IOMMUTLBEntry
Thread-Index: AQHbQjJvXDmiXC52f0OTAvckNfcVmQ==
Date: Fri, 29 Nov 2024 07:43:51 +0000
Message-ID: <20241129074332.87535-5-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 4d8e5bf3-ef73-4967-7369-08dd104991b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZE9wT0F3MzRuMjZzeDlQZmdvU0hSWTdzZm0zYWFWSUNtZ0JoTWdiOVplNGt2?=
 =?utf-8?B?Nzc1ekx2dThOK2F5SEU3VlVNYU5raHVzb2VKMFZhYytzTVBLaEVlcWNHTjEy?=
 =?utf-8?B?TzM1bHlDWk5NczZkdHB0dkxtWFY1UnJIajRVeEVCcWhpVnpURzlSMGhOaDJi?=
 =?utf-8?B?THF0dXU0M2ZJK1dhUEhLNFhpNkhVOXBZUms2cndDKzNmajRmOXFqN1Bic0hi?=
 =?utf-8?B?K0dpbjY5M0pIL3AvUCtWelJpYk5PR0NDREl2RmxZaFRIZ3ZRQWwxRStKOVVQ?=
 =?utf-8?B?QWZ0b1RxUHQ5UzNtTzdhM2dLU2kxRHZJclNTRFptbkRHMmVOb0NrMjcvVzQv?=
 =?utf-8?B?RlF0ZVVGc25JNjk0NkZ3WGN1c3JhZFdPN2IxdUpNNGZ5TzBBM21Eb1lUelVu?=
 =?utf-8?B?VG5PTkFMRVpGY3RrakE1eTB0N21NTDRCaCtFQ1BmS3Fab1pNK3p0dWU4dXNs?=
 =?utf-8?B?TkJvbmpPcGsrajBTVmJacWxsRVhkdzlBcHdNOWhJdGRuS0pIWk9SUU5ZTWZm?=
 =?utf-8?B?aFREWDE0L2RibEY5OUIxckEwRTh4UElkWE5rS2d2bkVIZWZVRVREZ1BpZlhJ?=
 =?utf-8?B?Z2dJcFRrTDJsRnlpOXdsTEhYSG9KbmVHRGJvMC80bDQ4QWJCMFRXRXlSUUh6?=
 =?utf-8?B?SHQwYkxiMHJzNXpZRG1GM2FWSjNnSWNLeEhOc0pzRitYem8yZ1NlanNUV1FI?=
 =?utf-8?B?b3hXVzZQUU82ektQZ0RvMTR6Y0N4TmlwVGUrRkcraUFuZTZlaDc1SmxoZ0xG?=
 =?utf-8?B?OU90OGR2NG8yQWw1VjFpTUM3U1R2MkhHaEd2R0hDQXFNeElpY1JUOVVZYmh1?=
 =?utf-8?B?Q3dMemxxaG5NZWZSekZhNko0QXdUT28rNGFFMmxya3ViRDFGRVF1R1c4OXds?=
 =?utf-8?B?bGpIVW92YTkybkd0N2Z2L0FrQUM0WjRGQ2pGcXBSdHQzT092SW5wOGxaOFJY?=
 =?utf-8?B?MDJWZ3hJa2dkVU1qRFdvKzNyN1h6L1EvWGdJd3hJL2FNQ3JVUitSZjJqa29o?=
 =?utf-8?B?R3dYNTEyMDVudG5KdlBCdTJUYk8xRzVHdnFKSUMvWm5OcDNLVFJyOTR2OWYz?=
 =?utf-8?B?Y3ZnVDAwYUdCSldGcVFpcHhtdEhxYWZ5OEl5eXFEWWZKa1p0N01BQWR0S05x?=
 =?utf-8?B?Zzg3Y215aXIxRjZtTXZlT2FHbEh3UDEyZU00SEV3NEJrQ2x4cHR3MkdERWNX?=
 =?utf-8?B?VFpXQlpwYXB0S0hyeWdVWUwrK0RoOVd3MlV0ejNUMnN0RmVxVXRPZFRrNVpY?=
 =?utf-8?B?czlRTFNlZWM2Ty95c055R0w5a2l1NlVwbndUM0hRSEo3V1NiTHlCd3d4M21V?=
 =?utf-8?B?V21vWjQ0L0lRWnRndkVzWURKT0FhSDZhQUJxamJ5UlUxbTNQdFQyZW1VTWxK?=
 =?utf-8?B?cWY0dnN0MmpoZDVpWDJwZjBNMkQvUVhoUW1POEtNUnQzZDA3aVNhdExtRFlJ?=
 =?utf-8?B?cnBNZldJZXhTL1dQNUdXcGQ5U3ZWRzVFQ0pyMC9Xait1Uk1OWUpaQmhjenJn?=
 =?utf-8?B?b3h3WERtT1F0UHh1SmsxYUFnYWdPOVh0K2hJWU5kUjBJYkhwUDVnOGZkYVc5?=
 =?utf-8?B?WURCREl5QVpYNysyTGhNTzRNdlNKbkxXVk5RWHJhT3cyb0hlT1VOL3JRa0pQ?=
 =?utf-8?B?ZlVubytJZHlzWGNTU0RaUlBSaEd2L1Y3eXgzSDFENE5Qc2M0Y2sxOC9aa1ND?=
 =?utf-8?B?V2hmSXBYQXdOWjVnbERGT3J0SVRWRzJlVDVGWlZPdllzZHVCTDQ3cEdiVXc1?=
 =?utf-8?B?UnVFOUZCS05sRjlxTVJtSGpyTWkxY3FpVzZnend0UTN0bWx5UUNUVU5kaXRp?=
 =?utf-8?B?RmxUelBVeUU4cHBBRUZVdXFLS0dMWWhGQTg1TFpFSHZYTGlmdmR2VzkwUGxF?=
 =?utf-8?B?cTlhRU9lSW42ellYTzFab1dMQmlQc1NtQUVZbW1udVN6cVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEVITzc3RlY3TEV0TDNIbEt4cnNIblpEV3g1YmcvYkZaQVFINEFKR3NldE1N?=
 =?utf-8?B?N1MxeUs1RTlBV01HM3djZ3lhYlg4ZGJIK2VqcnNuZTZZSTd4ckJjUytqSk1L?=
 =?utf-8?B?cHpjbVMyV1QremVMbzMvMXlQN2gyWVpmMVM1QXdxR3hFellqUjg3bXJDSlJs?=
 =?utf-8?B?QkJsTG9GOW5XOG9ITWZ5V1ltMkRQWVlFWkUreVlJZGpvL1VvU2NyanByVk5Z?=
 =?utf-8?B?VlZEakluQjE0RUVZZWI2VHV0VmNpTEJDM2RrYlE2R3ZmY09XbE9NTmE5SDdi?=
 =?utf-8?B?WlZRMVlhdkM5MXdERlB0OHpKbFpnUDd2d2JhWnQ2NHVPWTkwUGxNcStEaWdZ?=
 =?utf-8?B?ZFY5UVNmNHBOem43dXlsbm00ZGQycDFCeGhsTVNOdGFCZEpndUVZUXdSOXQy?=
 =?utf-8?B?dTR0Tk41Rnc2cUs1ZWE2Si80amd3Vm0vMkdKc0VFc1NGVnNnNWUyN0ZzeG9a?=
 =?utf-8?B?R3VYUkkzSXJVY0Q1UmNJS2xHSGFpRTExZEFWRjBsMzZVMlBLUklmRkpaQ1lE?=
 =?utf-8?B?NWxRVXhpYVNYRTQ3TGp0eExVeWVUZUlkMFNaV29HYnlqNVZjYm1xejFKSUQ2?=
 =?utf-8?B?V3Jlc2dzSFVnWG9jMWwxZjFUNGlLTm4xVUo0RDA4UXFma1ZXOUlCT21WVy9j?=
 =?utf-8?B?V3Q4WDhxZ2g5QXBCcDFhcFppZnZnL0EwVytBUXRVeG9XSEFyR2E5d1lNa05o?=
 =?utf-8?B?dmo2eGRoZUlweHRlam9WOTNkK1hQbEl5Tlc4RFlkZzI1RjN6Ni9JQ2x1L0Nt?=
 =?utf-8?B?N01BVHVDS0hPMFdsMXorK3BZK1ZjTmtQazdUTjNxK0p1UjNCTWVmeGdiL2Y3?=
 =?utf-8?B?azk1VTFFZmhMZFFyem5hZzVNM0hFWDBlL2pqdktwVVkzWS9jdUV5cnRPVDlm?=
 =?utf-8?B?RkhsSkZnajJVV2ZaM1MwdkE0R0ZLZE5SeEhWQU5LMzNMd3l3dkQzM2VabWsx?=
 =?utf-8?B?Q0ZQNGUzR3lBdVRuVlFwL3FNTVl0eUNTUHVNOFRnbHNuaXVCcU1pWXRJQTRk?=
 =?utf-8?B?cjBLY0g3QnRNVVhZeHg0U3VjNUc3SUhIdFQ3TGNKMmRjTXdtTjE4YVlCQkRu?=
 =?utf-8?B?WmV3Zjg0WGlrakxQMHYxeEFNT0JwZGE2TEdNK042N1RybGZyZm1Ibm0vU3Fu?=
 =?utf-8?B?ZTAyK243VTVhU0ptNzNZZ1l6ZkZyL0RJRzBYUm0vME14dU9oUHdMdDFHOUhm?=
 =?utf-8?B?OTA1MlJyNVo0WUxYYy80MW5WTDdOT1NCVk1qRldHRGJuUEpFNTAvVHUybks5?=
 =?utf-8?B?N2xhcEtKYTM1NGlSR1JvVG4xNXNiMk5sVW5uaXFFY3dIRUVza2RMdi9yV0w0?=
 =?utf-8?B?bThUR3NmRjBBVFpJWjcxZHkzR0psTVRWUGQvSXV2eS9lRkhYalprcGJBdmJW?=
 =?utf-8?B?YWppcEE3dXdlc2R0ZWdPM1ZxVm1zTFNDR1QzTG11ZzRRdXBUWHlTT1QwRGtl?=
 =?utf-8?B?bUYzZTdrNFNFbWtYdDJCRnBMRmloN3BNZWhpMXhvay9PWnFiOFRlN3VKQ0Za?=
 =?utf-8?B?WGQ3SlE3OUlsVDA3bFBsbGRmY3Q5dHREc2Z6OGJybm5PeFBhbWFQUkdLRktC?=
 =?utf-8?B?STlBbDd3eUxwL2h0RUNQN002VU85cENoRlpGRVhCdEoyVTArSDZhVGZSZ1ls?=
 =?utf-8?B?cEl0VG1NQjFUWGdpTjQ4MmR4c2M5RFVRNUhxSGJ1blNobjRmVG9tclN3Y2Vr?=
 =?utf-8?B?WjB6RzJDQkF0Y3BORHB1ZDNjNjVaTjd6TWtxdWFXSjQxakZmQ25HSm1KRFRN?=
 =?utf-8?B?UVBndmMvNkhYREdDUkw0cDdGYnlVR3Jqcm1jSG92NUdlaUszUjJpOG5oalh6?=
 =?utf-8?B?cmFJTnFBUm5qU0NXekxobEdtR1NaWWFaa1FUY2tpSkF3MVRlaWtjZkxVQVZx?=
 =?utf-8?B?UHF1bzczeS9PdUNXeTR6VDVNOE9NUHkyL1hLYzZMZ3ZOM1UrZ3F6a2s1NnQv?=
 =?utf-8?B?UHFrbzdMRUNMTjhNWVBqV1NRS3VCZFkwY09xaWlCbkYvL0FuMWhDcFMxUXdv?=
 =?utf-8?B?a0xVM0E1SURBTUNOb2pxdWY2NmhQajJHdlhGR2Y1L2tpOC9hQXB1Nmx6eUVC?=
 =?utf-8?B?N0oyQVRRc2l1N3lUa2s0SEs0dXQya29md08wVG0zaXEvTGJZMTRwZ21QVUtB?=
 =?utf-8?B?UmtadUlpU0cvUkxnL3hYeFU5OThQQXBwWlNvSWdnL2xLa0ZGVGFKV2xFYzBI?=
 =?utf-8?Q?2CpKYooS0ki8k1VcMxedXf8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34EB571D86DA77448E459DE72B3909D7@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8e5bf3-ef73-4967-7369-08dd104991b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 07:43:51.9380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KvR+mpm145Ws1xMdjazB/e0wEFtZxj9x070V/6jbP54T/3wASZ8hi/r8qkcpZ5MjMX6wZoxdNBQPW76I1F68YdOj0dMDWfOTjwyRitEOkSZYHFaBLKhFPfO9EoDQ4x1w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7847
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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
bi5jb20+DQoNClBBU0lEIHZhbHVlIG11c3QgYmUgdXNlZCBieSBkZXZpY2VzIGFzIGEga2V5IChv
ciBwYXJ0IG9mIGEga2V5KQ0Kd2hlbiBwb3B1bGF0aW5nIHRoZWlyIEFUQyB3aXRoIHRoZSBJT1RM
QiBlbnRyaWVzIHJldHVybmVkIGJ5IHRoZSBJT01NVS4NCg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1l
bnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQotLS0N
CiBody9pMzg2L2ludGVsX2lvbW11LmMgfCA5ICsrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3
L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggYWFkMTMyZTM2Ny4uYTkyZWY5ZmU3NCAxMDA2NDQN
Ci0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQpAQCAtMjExOSw2ICsyMTE5LDkgQEAgc3RhdGljIGJvb2wgdnRkX2RvX2lvbW11X3RyYW5zbGF0
ZShWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywgUENJQnVzICpidXMsDQogDQogICAgIHZ0ZF9pb21t
dV9sb2NrKHMpOw0KIA0KKyAgICAvKiBmaWxsIHRoZSBwYXNpZCBiZWZvcmUgZ2V0dGluZyByaWQy
cGFzaWQgKi8NCisgICAgZW50cnktPnBhc2lkID0gcGFzaWQ7DQorDQogICAgIGNjX2VudHJ5ID0g
JnZ0ZF9hcy0+Y29udGV4dF9jYWNoZV9lbnRyeTsNCiANCiAgICAgLyogVHJ5IHRvIGZldGNoIHB0
ZSBmcm9tIElPVExCLCB3ZSBkb24ndCBuZWVkIFJJRDJQQVNJRCBsb2dpYyAqLw0KQEAgLTIyNjAs
NiArMjI2Myw3IEBAIG91dDoNCiAgICAgZW50cnktPnRyYW5zbGF0ZWRfYWRkciA9IHZ0ZF9nZXRf
cHRlX2FkZHIocHRlLCBzLT5hd19iaXRzKSAmIHBhZ2VfbWFzazsNCiAgICAgZW50cnktPmFkZHJf
bWFzayA9IH5wYWdlX21hc2s7DQogICAgIGVudHJ5LT5wZXJtID0gYWNjZXNzX2ZsYWdzOw0KKyAg
ICAvKiBwYXNpZCBhbHJlYWR5IHNldCAqLw0KICAgICByZXR1cm4gdHJ1ZTsNCiANCiBlcnJvcjoN
CkBAIC0yMjY4LDYgKzIyNzIsNyBAQCBlcnJvcjoNCiAgICAgZW50cnktPnRyYW5zbGF0ZWRfYWRk
ciA9IDA7DQogICAgIGVudHJ5LT5hZGRyX21hc2sgPSAwOw0KICAgICBlbnRyeS0+cGVybSA9IElP
TU1VX05PTkU7DQorICAgIGVudHJ5LT5wYXNpZCA9IFBDSV9OT19QQVNJRDsNCiAgICAgcmV0dXJu
IGZhbHNlOw0KIH0NCiANCkBAIC0yNTExLDYgKzI1MTYsNyBAQCBzdGF0aWMgdm9pZCB2dGRfaW90
bGJfcGFnZV9pbnZhbGlkYXRlX25vdGlmeShJbnRlbElPTU1VU3RhdGUgKnMsDQogICAgICAgICAg
ICAgICAgICAgICAgICAgLnRyYW5zbGF0ZWRfYWRkciA9IDAsDQogICAgICAgICAgICAgICAgICAg
ICAgICAgLmFkZHJfbWFzayA9IHNpemUgLSAxLA0KICAgICAgICAgICAgICAgICAgICAgICAgIC5w
ZXJtID0gSU9NTVVfTk9ORSwNCisgICAgICAgICAgICAgICAgICAgICAgICAucGFzaWQgPSBwYXNp
ZCwNCiAgICAgICAgICAgICAgICAgICAgIH0sDQogICAgICAgICAgICAgICAgIH07DQogICAgICAg
ICAgICAgICAgIG1lbW9yeV9yZWdpb25fbm90aWZ5X2lvbW11KCZ2dGRfYXMtPmlvbW11LCAwLCBl
dmVudCk7DQpAQCAtMzA5OCw2ICszMTA0LDcgQEAgc3RhdGljIHZvaWQgZG9faW52YWxpZGF0ZV9k
ZXZpY2VfdGxiKFZUREFkZHJlc3NTcGFjZSAqdnRkX2Rldl9hcywNCiAgICAgZXZlbnQuZW50cnku
aW92YSA9IGFkZHI7DQogICAgIGV2ZW50LmVudHJ5LnBlcm0gPSBJT01NVV9OT05FOw0KICAgICBl
dmVudC5lbnRyeS50cmFuc2xhdGVkX2FkZHIgPSAwOw0KKyAgICBldmVudC5lbnRyeS5wYXNpZCA9
IHZ0ZF9kZXZfYXMtPnBhc2lkOw0KICAgICBtZW1vcnlfcmVnaW9uX25vdGlmeV9pb21tdSgmdnRk
X2Rldl9hcy0+aW9tbXUsIDAsIGV2ZW50KTsNCiB9DQogDQpAQCAtMzY4MCw2ICszNjg3LDcgQEAg
c3RhdGljIElPTU1VVExCRW50cnkgdnRkX2lvbW11X3RyYW5zbGF0ZShJT01NVU1lbW9yeVJlZ2lv
biAqaW9tbXUsIGh3YWRkciBhZGRyLA0KICAgICBJT01NVVRMQkVudHJ5IGlvdGxiID0gew0KICAg
ICAgICAgLyogV2UnbGwgZmlsbCBpbiB0aGUgcmVzdCBsYXRlci4gKi8NCiAgICAgICAgIC50YXJn
ZXRfYXMgPSAmYWRkcmVzc19zcGFjZV9tZW1vcnksDQorICAgICAgICAucGFzaWQgPSB2dGRfYXMt
PnBhc2lkLA0KICAgICB9Ow0KICAgICBib29sIHN1Y2Nlc3M7DQogDQpAQCAtMzY5Miw2ICszNzAw
LDcgQEAgc3RhdGljIElPTU1VVExCRW50cnkgdnRkX2lvbW11X3RyYW5zbGF0ZShJT01NVU1lbW9y
eVJlZ2lvbiAqaW9tbXUsIGh3YWRkciBhZGRyLA0KICAgICAgICAgaW90bGIudHJhbnNsYXRlZF9h
ZGRyID0gYWRkciAmIFZURF9QQUdFX01BU0tfNEs7DQogICAgICAgICBpb3RsYi5hZGRyX21hc2sg
PSB+VlREX1BBR0VfTUFTS180SzsNCiAgICAgICAgIGlvdGxiLnBlcm0gPSBJT01NVV9SVzsNCisg
ICAgICAgIGlvdGxiLnBhc2lkID0gUENJX05PX1BBU0lEOw0KICAgICAgICAgc3VjY2VzcyA9IHRy
dWU7DQogICAgIH0NCiANCi0tIA0KMi40Ny4wDQo=

