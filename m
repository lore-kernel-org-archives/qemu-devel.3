Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0030CC369C2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 22:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5BRM-00026Q-Rl; Wed, 16 Apr 2025 18:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1u5BRK-00026B-Bq
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 18:41:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1u5BRF-000850-GE
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 18:41:06 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GLNaeR028473;
 Wed, 16 Apr 2025 22:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=+28zO8BCdiMmbAbhdgrG9I7zULx3spqlYGrNEJjrOpI=; b=
 DPuH06tXTX+ZalU97WWqCk4wmmVLfD4/L6ev/0KByFWoe4S037Y9+VuBlDF34fBg
 1i1SLziYOivo2VrVNAv/Eh9w2ARrexCwyShi4UZlRI7hFn//VVk4caZfJNeylzaZ
 xgP+fkvPnA97VCb8TuNWnThnRPzmbmBYrEG94k0buydxnWRWvSNYW3wu0Mwa1G36
 EMHz/sgcuu0X/PXQa64FmqPLWnmL5RzJKVm4ClirsOJ3zEEFCL6JKLjeq06EqLxV
 nZE45h/RAljHItRyAdgTQvqq6f2bz6NOUlopixm2yKPINioqjB90fPwwxp2RKDGH
 K86SphaiSSRxL4/BoTbOgg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46185mw2t0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 22:40:36 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53GL6cAn008496; Wed, 16 Apr 2025 22:40:36 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 460d2scvb8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 22:40:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TD5/CFlNGm3h54MWdJCcUOAo8KCTFC6Of5WgcT24MEajuLdIv32fogfO+jPCn+sjnjT+iCI/yyoQ0sF1a1ZFdiyL2IIJ94Eh0nfsE4r3b3yMSMCAGQw7NyzSN7Aj4EPkmpEgqy0A7NVMAgW7nod1Oqsa44+0x7eMqKLljIBdO0/j6fPTR8GActWdv0pfuwbBad4Dghb8uThBI6jFthMDTywQW9HWY+pvkDuGeHwyeIBF3O666un2qBZfC05Zj/9roC9SrBHdBKhBAO57NBH+ao32oo/HA3vth+8xX3lT7lJvMvAez6WvlWUSVnyGkyMEDcKwmmteIsTR7KPCmszj/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+28zO8BCdiMmbAbhdgrG9I7zULx3spqlYGrNEJjrOpI=;
 b=Nr76pFf1UMUd7nmRVUQ65b3Xgs6EOXuT96cdlSIb8EeTdVy1uMWj8lnH0HEIIWfj37OpawaAZHi/K9LdeV4A+lkPKYfPeitIA9jfHTLbq08GnLNTzHDE8D43Gfy5i4rtLo0IBjXdL9RkT8NTCnsb1IaBolilEG5GiGwJ3BwMLNKMgb3rLoezC3yRNTS9mISPioKuyl+oFdPqNfCErVDOOJ/PrPpt+GZa+bjTqK72vKmao72mb23cuyqFQ4rRiUtjFE53l8AkjQO24nsLA8HeoE7Evln/xESeAifT+CZedO/8YhBge5fn7WTeikX2bDFd1y41pRvW+mSVWOKtdMOxxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+28zO8BCdiMmbAbhdgrG9I7zULx3spqlYGrNEJjrOpI=;
 b=mKQK0ApPEsoR25mWN6wng8JaxfBEUEiob+f2sNDjWNPsnkSvfpAZ/PoIyG6LZSsWKruDvutUfOf2v5jwB8JYayg13KKBP0J1OTOGNJNwTdgMu4lGsXYiHNtk1u4776MvT5Q03/SnK3i7UHqOJk3kVppnpeaBM/xToF8fJeGGNCc=
Received: from DS7PR10MB7129.namprd10.prod.outlook.com (2603:10b6:8:e6::5) by
 PH7PR10MB6531.namprd10.prod.outlook.com (2603:10b6:510:202::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.21; Wed, 16 Apr 2025 22:40:33 +0000
Received: from DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c]) by DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c%5]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 22:40:33 +0000
Message-ID: <96a0b59c-2d54-453c-8907-3f8dc224db23@oracle.com>
Date: Wed, 16 Apr 2025 15:40:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] vhost-scsi: support VIRTIO_SCSI_F_HOTPLUG
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net, mst@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20250203005215.1502-1-dongli.zhang@oracle.com>
 <uut6fljzuwk6rwbzmnc7ieftwtyuwdjimehn5frluldt3cqudq@ndvyu6iu4gul>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <uut6fljzuwk6rwbzmnc7ieftwtyuwdjimehn5frluldt3cqudq@ndvyu6iu4gul>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::6) To DS7PR10MB7129.namprd10.prod.outlook.com
 (2603:10b6:8:e6::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB7129:EE_|PH7PR10MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 587ed6dc-d6a5-441d-57e9-08dd7d37b2c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnRJZGN6RUh2YUxPRHZoaVBXWGRCd2Irdk1JRTc4QnpWalVUVDA1eTZwcFVD?=
 =?utf-8?B?N2oxdm43OXFEZzlWdzJPcnlFYmQwM1VneTFHYVYvcEdkajFJTzAvd2tldkRv?=
 =?utf-8?B?OHNCSzU3RkNpRzFCQ1FYVFFJc0VPWHhmdUI4NmhEQ1JOZ3k5eGRSTUlHL1pB?=
 =?utf-8?B?R3lWd1hHUGhEUWRSU29uWUg2bzZvRWJvRlE0cDV3NXRDam12cUcxMm9iRzlq?=
 =?utf-8?B?eGQwTDI1dzh6Qnp4QXh6NWc4aUNZSnBCZXdKY3k2S0tROCtLWXhtTHV6ajly?=
 =?utf-8?B?cEtGblNQNmgycHBrenczNnZuL1dDbHhuUGRlREc4ZXVjaEN4emdTaUszRkVx?=
 =?utf-8?B?UWxZWGVvWmVlTU5nQ3ZNTHZ0MDU2YkRhNlpBUnlJOGpmdnNZSWpPUmtNUUxm?=
 =?utf-8?B?ZG1BQjlLaHJjaTFYOURKejk5M2lWdFlleHlmMTBvNkp0Y01BeW5zSjFKYStD?=
 =?utf-8?B?OXBoTkU1VC9KSEhwQ1hXZm0xMVB3OS9oUkZCMGEwNDUxSHJhY083MzhlNzkx?=
 =?utf-8?B?Wnh1THc4eXh0Y1FMRERuRVhORWJNeUZtTWljc2lOYS95NkFDSGE2eE1RUHJH?=
 =?utf-8?B?UGdZOU9Ic1h1a0hTQXBUVjY3b0FkT2ZTZmNGbjVsbkpYVVZjV1hYTTNZcXBt?=
 =?utf-8?B?QUtrWFBPMVdla1pleXhMdDVpU0FHeG9nTStaazdyc0h5Vzh0TTlYVW9qazNq?=
 =?utf-8?B?aGoyZ21mTVRqdnZmTnJkMkFHajNnY090N2E1Nmo4OFlFR0M2akRMMjFvRmRx?=
 =?utf-8?B?R3hsMjlDUnRoeXJuVDdCZ0N5UkhJTzlBUXo3bjNEdUxVd1YzcFMzbTltQXN2?=
 =?utf-8?B?dEQ0NDdOVU90K2FLQ3dlYmRJMWg1NncrSDk1eW5uUVpIVDVwbHVRcnI4bHZK?=
 =?utf-8?B?SXVKcFNyTE9BcFJjUTJSNkljSFVWN3h2cDYvOEhoMXUxT0Zodkt1VDg4am5J?=
 =?utf-8?B?NVYzVGRxWWNyT1pEVldJdzJlcVFWTkFkLzl2em5wOEEzdGM3YmFleWduakxN?=
 =?utf-8?B?UjA5RWlCbm9MdWY2NEpGTkd5T2dJUVJBRW1la2R3ZWFyV0d2ekhncW1HMUF2?=
 =?utf-8?B?bmN3YjRRMU5zcm1FMTFWeStkNFlabUJmWDVGdjByWVp4MDhqUmh4MWNMMHJa?=
 =?utf-8?B?S0RXbXYvSjRNRnFRZk0xei9NVytnN2FCYS95N0hvOGFNYlRnWkVONXR3TUcw?=
 =?utf-8?B?UmRnY0RxMDZrMTI3dUZGZUxMZjdqUGoyZHlCb0tBbG1kMGxCdHV1ZUFyRElV?=
 =?utf-8?B?WERjVUljRkV0TUtyS0FwNkswR041N0NFVE9WTlBSMEZEY0hwVVorc21QZ1dU?=
 =?utf-8?B?VEhCSEtzcWs2d2t6V3hjUTlrV1V1WDQ1RDBWN2VwN0FnTnVzWGYxK0tUSm82?=
 =?utf-8?B?bVAwVk5SbTRodFZTaEdmVnJUaEhyK29GK2V3Q1gvK0JIMm1mM01BOVc4RmNF?=
 =?utf-8?B?U3dveVNEZW9tNExkUzRQRGs0VlRUV3pTMCtBL3BwZmR0MlZvbE9yTWJsSlBT?=
 =?utf-8?B?TGJEM29lazVmQUQxWVB1M3A4STRPS3YzaHVmM2FONDNXN2dVeWFqdkx6T1h1?=
 =?utf-8?B?R05ON0l6TDY4UitRdU9YWFVXbHFxU1lCWDcyVDJFa1VuNVhRSmJWS0pJMVBM?=
 =?utf-8?B?ME9zeTl3NGpuUGdFVVZJM3l1cUxPRTRuTDNTYlQrTGl0L1JvL0l6MDFZYzMr?=
 =?utf-8?B?SkR6UjNoelQwWVBlVE9oWnU2Vi9zZldlZDdqZ3pQS0d6djhlOGU0blRzN2JP?=
 =?utf-8?B?TUNGMzhFakJRYzdQTGRocjdEYVZBaWhjZndtMDNHZlpleDN0Nk5Tdk50WTdE?=
 =?utf-8?B?Qm9LZTdEcE1NdDRENEEwVnN4WTFSRENwOXF0QWtVSUpMWUd2RlJrNDh0OXpO?=
 =?utf-8?B?RzZqSlpVQWs1N0pQbDdFelBXUGt5UGF6a2ZnejB0UFc3TytVM2M0bHhaSCsr?=
 =?utf-8?Q?ZF6Uq+QhVDs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB7129.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dURkQ1NUSnJ3ZEQ0WlRCalFYNzd1dXozWTJBZEd2dldXTHlFRjhMY0RQMWJl?=
 =?utf-8?B?SEh6aDE3QXl0ZXZ0VlBwNDlOODUyZWhaUCtPU2Jha0Ywb3B5VjMwVFYxWlkz?=
 =?utf-8?B?eHRJejVLSzVBa1BrMk5ZQ0RDcmxod29IbmdjYTJrQVN4c3ZaSXYraXNKemtN?=
 =?utf-8?B?dHRnNy9PZG9xVFdBajd2cnFLSzUrWUJnd0I3ZkV3Y2huOENybk1IOFI0SlRn?=
 =?utf-8?B?d3M2UmlPY2MwMHRsRE1UNmcvUlBkY1lOZnNFVjVLQThCWFZkY3NYckxEdGxa?=
 =?utf-8?B?MHlxNmlJY3AxbGluWTcyZldYMm5xSVIzUjdKREkxM09LbW9pRFJ5cnh5dHdP?=
 =?utf-8?B?MHoyYTdaSkFvY2ZURnhxRkptRjZ0dC9JbU0veldRMC8xazVoNkNPRDR0dm8x?=
 =?utf-8?B?M1FhRTlQR25iOTdqM2RPY1FsRlpnME1DRDE0OTB6ckFkcG1MWkFoWlVTQ2ZN?=
 =?utf-8?B?K3gwS3JwQ1YrNjQwUEZVQytJUzdjRW5iQjlHblFXN1pPZzlSYVlFdmMwb0dR?=
 =?utf-8?B?UUQvc3R0bFovNWMyTTAzeTR0SUlRUDlNS2JXUm50RDlyVTF6RlhLL29YNjNE?=
 =?utf-8?B?RFdJbFlSMkhKVWJWQXVvbDlsb1JvaHFBSHFyMkFLRit6M3oxV242Njg1dllW?=
 =?utf-8?B?Wkt1SURuS1NBbXpHY2JLWkhxZVFaWmgvb0d4c2dENHBzN21PbWFVNHNkTEln?=
 =?utf-8?B?YzNDc3QyaHpkNzFGdFlJYmtBbzlyeE1LYzE5RXdrS2UwcnNvNXg5MzdSR1o0?=
 =?utf-8?B?bHJlTzR0SityRlpNSTQ4TkYyZ3hYczRXSStLdVRkY2ttNkpuNGZzOXdkb1pw?=
 =?utf-8?B?bGZZOEhzaDJUeVZ3Y1pLRm0rbjUxSFdhR29kTFNlTVNwOE0xdXoxSFBEcmlq?=
 =?utf-8?B?aXloZUtUUU5tZ25KbXEwMTJWVXQ3VCsvRFBLQWxKdUtYcEkyWXBzaEV0bEU0?=
 =?utf-8?B?NjdkeDhrRDRqZW9nNS9YcTJxSCs0UWsvQlhCMTM3Z2djZ0Mzb0xIQXhOWGY1?=
 =?utf-8?B?WUVjQmlzSTVEWEFqdGZGRE1leEZuaUZRYlFRT1dpSXVzWEJEbmFJWVZsb1lC?=
 =?utf-8?B?a3JFS1ZCMmxCUU5YTFErZytleVpzcEtLN3VFSmdIdG9CWUd0alZSS0N6Z3NB?=
 =?utf-8?B?WVM1Wk5mRVFHWkxwUDVaQUJVZ1ZITjhoRjhBaldQTFR6VGErRlFtT1VucXdp?=
 =?utf-8?B?azE0RmFRVk5YWFJsWGIzaUJ3TTU1V2ZudGJkMHUxZzBsbFJ3M2FyUTRlNG1I?=
 =?utf-8?B?VmtJZSswcTQzaWtYUTU2am5reFVlbnVpeWNzTzI0WkNNVlV0aU9SYlZUZmtF?=
 =?utf-8?B?dHJiTXhNS0lQcFdFVWl6aEc3NUw5T25UY0lRek0vN0lLTjgvTVB2eHJaNnVJ?=
 =?utf-8?B?cWFpS012MU9xR09RVkZRQ2JuL2tGTDEyaHdGYVlpSnFDYVRCTEQ1cWpPMm02?=
 =?utf-8?B?UTA2VzQrYWwyQ3pqaEl6VzRDMDBUSmk4M2FJOG5pY1h2akJPNkF2MmZyNDdL?=
 =?utf-8?B?SHZFQjludktDWlRwM1RtVG9HeDRna2MwbEg1UjRjOVlqWm9xQnRXaDhsL2ds?=
 =?utf-8?B?bnBuQ2xNY09saE82NGZQOVM5QTAvRmh5bGtXbURoUzFWb29MMzhwL05rS3p5?=
 =?utf-8?B?dEtGUVVVbDJmY2hJdkpFMHVUUXJCQVVMUnhLSHdPNFdOSEJMbXlZVjhpRm1Q?=
 =?utf-8?B?RnQ3bVFyWWJpS1pyajdtak5RNkl3dmR6MjhHOU81S1FvNVFzMGNRVHI0dkJQ?=
 =?utf-8?B?bXdpclhKczFReVpUdzI2K1pLVlRuNkVFTEVRRldyQ1ZvMkxGVnRlVDRKWHo2?=
 =?utf-8?B?TERNc1E3OEQwaVRYRXRXVUZLdG50a1B6T2l2bHJYL0dsOU1IM3NpdlVUVGZh?=
 =?utf-8?B?OVZoY2txSVp5ZVVqMUFHelBVUTJyeWxCd3JrZW1qMHJickxvQTVsdHpQZEpj?=
 =?utf-8?B?OXEvOTVHRWJVRXlvYVpSckVmYWI1R3N3bFJERlprWTJVY1AzMnV4UVAyNE1l?=
 =?utf-8?B?eldLUG13anQxRmJwMnEvTGdNV2xNQk05TnF1WUVLUTNPTzRzRWtrbmRWY2hv?=
 =?utf-8?B?M0NDUHFkMERNdWJIcS9zUGZDMFdheE9nY1E0amtUTEZCa2hUQmtYdmhHVHQw?=
 =?utf-8?B?YTZHTDlqaU40QWVkU2FWNTQ4OFY0RThjUFRDTVAwNUprSWNzaGFYcmp5U0tm?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MTA0ugmxSctDkhTwBn8wOKkj+0Hprn6mlnl/cwJ/bY3Wf1g2rs32SZzSR9us1ER0T/ewwoEMhpxnjI0PExUoK71E2AAldQZQ51Yr/xdQoZ5NMc297RNKu7oxi10sE4t9K8Vy4GHDWhibJdVA6TnXC14xtnmZzWUFyZ/X2056jpAlpMowcLxnEK9zeJUTnQl4r+oXCGL1flNOmStbWpZFAFINus7yZ7mIF3WkUyPjueSG5Sjv++G0Zgt6tFsyTJsUwgVE7YWpxAcF9z/K6SkfB5Q3H+MRSPtr5E7XfwN8S9iHR/znXtd8IvQnqTKP92lvjkUZTeRt5l7B3FjLN8DqyLWWYyg48olnxnjGPDqqxF3doIC4iFo7ANX2m4Aufwd0cgKKm0OVuK+9hH98dGcgQiAbpbFN1+o4KGqTjMpEuGGQQ6ur6lIFN2H9Vw96qrF/AbAbUo9EYKorLsrQWPwElNRzdPY3xkf8yy/mJ/Io2oInNWloAb0fqOo+/3APdoJdego1XcZfZDAfm66N5/+Rn7xNqJpu3rqQuTIyF3P7Zn6Fv9MnehUO+uSeIyYYyHne1TBZlLV8ApA17B9zraYXsJiJ2zSkdChg6LvMBH7zej4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587ed6dc-d6a5-441d-57e9-08dd7d37b2c8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB7129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 22:40:33.4753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lf5h1IcvFm0q3FdKzLMbntsaPYhaAK4i3VeUdywLr0rJAcUwf+JUJLzkoZBiERxmPnLJtcebza/zT57q1yu5FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_09,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504160181
X-Proofpoint-ORIG-GUID: 2mYJgFjg3CxBXHM341tF_tTRikLyukQi
X-Proofpoint-GUID: 2mYJgFjg3CxBXHM341tF_tTRikLyukQi
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Ping?

Any chance to accept this property? It is acked by Stefano Garzarella.

It helped me test vhost-scsi event queue and live migration recently.

https://lore.kernel.org/all/20250403063028.16045-9-dongli.zhang@oracle.com/

Thank you very much!

Dongli Zhang

On 2/11/25 8:26 AM, Stefano Garzarella wrote:
> On Sun, Feb 02, 2025 at 04:52:15PM -0800, Dongli Zhang wrote:
>> So far there isn't way to test host kernel vhost-scsi event queue path,
>> because VIRTIO_SCSI_F_HOTPLUG isn't supported by QEMU.
>>
>> virtio-scsi.c and vhost-user-scsi.c already support VIRTIO_SCSI_F_HOTPLUG
>> as property "hotplug".
>>
>> Add support to vhost-scsi.c to help evaluate and test event queue.
>>
>> To test the feature:
>>
>> 1. Create vhost-scsi target with targetcli.
>>
>> targetcli /backstores/fileio create name=storage file_or_dev=disk01.raw
>> targetcli /vhost create naa.1123451234512345
>> targetcli /vhost/naa.1123451234512345/tpg1/luns create /backstores/fileio/storage
>>
>> 2. Create QEMU instance with vhost-scsi.
>>
>> -device vhost-scsi-pci,wwpn=naa.1123451234512345,hotplug=true
>>
>> 3. Once guest bootup, hotplug a new LUN from host.
>>
>> targetcli /backstores/fileio create name=storage02 file_or_dev=disk02.raw
>> targetcli /vhost/naa.1123451234512345/tpg1/luns create /backstores/fileio/
>> storage02
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>> hw/scsi/vhost-scsi.c | 3 +++
>> 1 file changed, 3 insertions(+)
> 
> LGTM:
> 
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> 
>>
>> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>> index 8039d13fd9..d3a260f6a7 100644
>> --- a/hw/scsi/vhost-scsi.c
>> +++ b/hw/scsi/vhost-scsi.c
>> @@ -359,6 +359,9 @@ static const Property vhost_scsi_properties[] = {
>>     DEFINE_PROP_BIT64("t10_pi", VHostSCSICommon, host_features,
>>                                                  VIRTIO_SCSI_F_T10_PI,
>>                                                  false),
>> +    DEFINE_PROP_BIT64("hotplug", VHostSCSICommon, host_features,
>> +                                                  VIRTIO_SCSI_F_HOTPLUG,
>> +                                                  false),
>>     DEFINE_PROP_BOOL("migratable", VHostSCSICommon, migratable, false),
>>     DEFINE_PROP_BOOL("worker_per_virtqueue", VirtIOSCSICommon,
>>                      conf.worker_per_virtqueue, false),
>> -- 
>> 2.39.3
>>
> 


