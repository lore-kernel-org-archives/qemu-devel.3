Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238E5CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 18:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqy61-0006yI-BP; Tue, 26 Aug 2025 14:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uqy5x-0006xk-Tu
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 14:08:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uqy5o-0002GS-9C
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 14:08:33 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QGfq8W025214;
 Tue, 26 Aug 2025 18:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=4zexquj2ltlXuuyAI+wo4B9+xsK1vZPfe1xu8kwAQvA=; b=
 sNuFrse9MXybsDkmgDJmNFDQ2wglSXVIAQ0ks1fQokRFm/Ziy9YQf8WO+/H19ohF
 FV9D6GVvnGT45QDzYIHrqZQr8kwiN2AhCcxwLfdcnbTuOX55K34JTontDaV89Tll
 WyLdXHyvL46U1JSo1s0N+wd5yIA+E7Lp3vPJC6sI8IG1++hyVPADlCHDZjirwVLr
 +fcT0FyiO4lV137SwWciFU87bmc8TyJFUtwVnft/aaGham4HXGhvDf66RF7rg8wV
 UFCdegcho+k9pqfARFgPVXlcOf8BDoYnUjOTEb6y2DESrbyCuvDvOKu1AUgf5Q2+
 7DMLLVdVqzFMp9xSn4eT3Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q48en4hq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Aug 2025 18:08:12 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57QI29BF012336; Tue, 26 Aug 2025 18:08:11 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11012018.outbound.protection.outlook.com
 [40.93.200.18])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48q439u57n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Aug 2025 18:08:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtaOjboTQI7QrqzE84Rbsadlw3lokAz2cd8m7I0VXMEH9sqNMN7UWDF2C/8Yyhv3eeKmwTHkDMYf78YBebLec6v4sHkufSrsWPIkjvi5l0y84/t9pnZKK5vZy43oa5xaTdBDKeCVFZBKy8PWTLi9RyHKMO05OejIdzEmXeugnNfSKemQKvyfYiXmnv/FOs4UZINPo2RkJ5XdEKPz3zE171JHaW26tLXEELGq66bPoVQ2RSZk3/KaY0EPkWYXsDCU+JIoJD4faY9aiwJ+TJCFSqUI5sW3QN/4tI5HtSETSLccKguvFwi8b+GPf7joaNkU3zOscjoiaW2BZC4jPx5qXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zexquj2ltlXuuyAI+wo4B9+xsK1vZPfe1xu8kwAQvA=;
 b=eNHkgQFjspcj5TReKDzmsNNRVkP6PXZ7kGxSxDKzosCktllEgfoUwY1Jm7jKZGmTqQbmdqev/jthIUteMTpqviFL7/b4Ky99Yasnii9DG9hTGTwN/hs/pRmbQiEe9ufKebHquDxbNXULALnivFQoc/QG4YnaZ9nE9EZOLyAGGl8clDhGqe5N+54E8k8p4zty/wkq2p88qQlRmnQjRPFyZd8Y7Zn323+/HaCiA7l+tVgyoIPaOdAxn/acjY+jzblC4ky+IbLprMF9FDf0JMMIUV7glSYGzRuz96CjkOBuy57L3/3X+OSmwNeeejJDOJeg2zzuLI/QJVwxtOGU0vZw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zexquj2ltlXuuyAI+wo4B9+xsK1vZPfe1xu8kwAQvA=;
 b=OHjRA3z/udwutLERTKTjQYMxrKx30rEolXBQ5CZD/3OJW2L5BXmSNqtcghNhGyUvMNtNCVy7iYAJft+OrQ5ZwzJGXvebVSs2hpDrgTvWp3wFM+WRqIJhpo9Ju8volUNGtirwdRdRzGnaa8UXI1R1Y6NB58VwKZDXcjETPpZ1AQ4=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by IA0PR10MB7136.namprd10.prod.outlook.com (2603:10b6:208:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 18:08:06 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.9052.017; Tue, 26 Aug 2025
 18:08:06 +0000
Message-ID: <1636d435-d13d-489f-be59-5a225286b12a@oracle.com>
Date: Tue, 26 Aug 2025 14:08:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/6] migration: Add virtio-iterative capability
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, jasowang@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-2-jonah.palmer@oracle.com>
 <874iuihyxd.fsf@pond.sub.org>
 <5a8bb5ef-c500-4fac-b5fc-566408ae8ffc@oracle.com>
 <87h5xvsh9c.fsf@pond.sub.org>
 <2764b188-a4cd-40b8-95a7-ccec775d7db9@oracle.com>
 <87ecsypq85.fsf@pond.sub.org>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <87ecsypq85.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR15CA0004.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::15) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|IA0PR10MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: e8fe3aea-c741-47b1-d09d-08dde4cb81a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZktQSk0wczdFN2JieTZHaFlJSHoyVlpzRTQyemQ3M0s0cnB6QU5qRnBuVXRS?=
 =?utf-8?B?TTJhaTdOZHFOVk5RQkFodmdoSXZ4c1BsNVJGbHU5TGV3VzIweXpJeEJhbzRX?=
 =?utf-8?B?dExDTCtGUjBRNDdsRTFXdFhhSTBmang3cnBLaGpIckdvWnlRZnBTOVV0UEkx?=
 =?utf-8?B?bGVjZlgzODlOcTFUd0ZoUW0rRTZVZGhzVXVaVjFWcytWaStNOUMvNURwOFBN?=
 =?utf-8?B?bHFQa3ZvbFNZbSs5OVJVR0NmVEo2NUFCTksvcFhwUytERVhtTTFvN25nWjFK?=
 =?utf-8?B?QWtXQnBmWUxhWkJOQ0hPWXVhTFFZdE53dGMxYkFoYkJsOFY1SDJ2N2t2Zm9t?=
 =?utf-8?B?S3FJaGh3azBYcjJUelZ3U1Uwdjk1Zys5SE15QUxhZWV1SjFQNjRZN0xZc21x?=
 =?utf-8?B?cWxxZzBDSWhFeE03TWFBWWgrRXY2N0hWdFR4UVdpWm1uNXllc3IxcUZiTTdt?=
 =?utf-8?B?bFBkemZYTU1KeUZsZExadlVKUkRxeUlHajNnT0tJVDcyWUJ4M215WW54clJv?=
 =?utf-8?B?UzRXaURYQ1RNVXVVaEZ4emlXV25WTUJiR3M2clNCWFVrcVdIbnJzZGJyNVUv?=
 =?utf-8?B?NGpHc3FLak1ZNDBUSkVORGYvRW5YNDZoUjVIWTJOa0J5ZE1HOWpMM1h6YmxP?=
 =?utf-8?B?SmdWbWEyc2MyNFJQSHkvY1huekhuc0hPQWg2bTg5bEZNVUxMMTVnUDlZRW1t?=
 =?utf-8?B?b2YxYWNwRWppUWRORUlreDFnclVDMEhPelhrbTJ2WXdHRUhJaHgzNy8vOHBn?=
 =?utf-8?B?MEZqdXM5K3hjZHprUFl5ZE5jVFQwZi9vTzRiWmdOYldoSXlnY0RPbFE3UFdl?=
 =?utf-8?B?MFRENTkwK3dYYUtUMTduRWxHT1RnUjJJMWx4c2FIcC9DdG4vbWQwYWhERGpT?=
 =?utf-8?B?YWJMVG5uU3lRRnRqOGVFYVUwVUpoSS91dWxNZmFwK2V3SUsxTHdaWU43Mlo5?=
 =?utf-8?B?VWpYak42NHppUVplbk02S3NLSWFOR0xLNlkyejdzTmdGc0xOcDFBdUl5ZHhx?=
 =?utf-8?B?czNFREFRL3dXOVNmMEFGcU1FYzdVUWJpYWRQMG83NVBFRzd5N2RzdGh3WHU1?=
 =?utf-8?B?Z05NazZhb1lUWlptRU8rNnVGQUYveE43Z1FCS0d1RG9qY1FOUnZGNUNVNTM2?=
 =?utf-8?B?L2x2WGRRMmdUNDk0b2c1K0VhMXhFWGdvODB4QWhmK2tYa1IvSUlrY1VBYkJU?=
 =?utf-8?B?Mmt6YW9nNkFVNVpQL0tsVkI5ZUxwNWFRV2pRVVBYa2hOaFlkZWlYRm9RcjRE?=
 =?utf-8?B?UFhneHpCUUNTRjZEY2hKOWgxOXQvMXdZa2FFOUhvY3BmcStCd2l1QkxwK1ZC?=
 =?utf-8?B?bVZGcWJsVThidFZnQUtpd0U1cVZTSXJUVGd5bjFZQVlveWxVTmQxQjE2N0w5?=
 =?utf-8?B?SjNKbHR6c2t4YzNLSTB3cGZCMG55a2pFNkV2b3FabEwvRzd0bE5aVWNPNkRX?=
 =?utf-8?B?aTVteGw4cExLcWQ1NW1XWkUyWHJqRG5RT3Nmbmt2NkRnZ1VvUVhnWW81Y241?=
 =?utf-8?B?dzVXbzVWaXRlcEpqNHUwc3J1SXpxZDhBNzhjSU1lS2lFN2w5MTY0ZjgwQUwy?=
 =?utf-8?B?TlNWU2JRZWpoNUkzYllIdERlNHNTRjJ4RDVrb21jUFNEQUlEWThuQ1pJR3Y2?=
 =?utf-8?B?V2Z5bm92aXNyN3FxRGhUM29SOE8vTGRNcWN2NW5qYTQxcFZId3hqUnhvUUVX?=
 =?utf-8?B?SEMzeFIzRkxwNEhVbU9CdzNQb0Q2M0s1WHlPK1NaNWs1VEFXMmpnZ3ZJdVVt?=
 =?utf-8?B?T0xQc3VJaDY1SmdmSUFGemZsZnZjanlqSWxBeFNQZ0syTGlZNmJrcTZTOXdl?=
 =?utf-8?B?anYxdTRvandaRVhUbWc1Zkw4QVA3OGNaYjUxWDliMGR4bGE3RjJIMUYxc3hG?=
 =?utf-8?B?VHE2RU01S1NwWTJRdUhPeTFBQnZmVWxNWm5IaytOUDZUNU9tcVFHYVlyNXdr?=
 =?utf-8?Q?2L84Gfnlq6c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0tQblRxcytEdWNpS2ZubVEzaHVEaDdMZkFaMVRrRyt2ZytMWW02TXVvZ2ZC?=
 =?utf-8?B?R2NtaStxV0U3QjIrWDY3MDBycmswbGFLVEo5WVBtVU1CVEhaWll4OUdMYlY4?=
 =?utf-8?B?VVdFVkZHd0lCT3F5RGdURTFpU1pQSCs4aStRNmdidTc4SzllVkNHYndVUEdH?=
 =?utf-8?B?TkFIbDBjcnpGVjRVU2h3c1ZtanZLd3NwQ2pRbHZ2NEx4am1ISFNCL1RRdDN6?=
 =?utf-8?B?enVETDQzUjlDbkZ5NjhXK0JvU3RPZ21hTGFjeEpZQlR4YXE1SGFMcmdzVVk4?=
 =?utf-8?B?b2RuRUpsQThRWlRJaHFsN3BTNzB4SVRJbk9TUm44NjVjVDlzZjVpV2loVmpL?=
 =?utf-8?B?RVB5NG55SzR4Q29VTzFqWTJ5cWdkY0FSU0Zud1ZkU1FMZkJvemYxNTJ3dk1W?=
 =?utf-8?B?UU5mclBES3RCZzBiN3pXbE1RTGlDWUh6ZWJ5Mzc1aDM1ZWU1UDUxVjY2Wkxa?=
 =?utf-8?B?aWRrWVVKT1dlOGFlY2xDa2FOOUdxRkhoZ1dNNmE1UVBmUzROODU3RnFDVDA2?=
 =?utf-8?B?cXR2T3orL2dEN0M1WklmWkNGVDJMRHcrZVJ5SlJ2UzlVaGtyRW1BelhDc2dI?=
 =?utf-8?B?QTN6MWtia083WTY5SlZWMHR1eTZGNEw0aVNTNThTMndWSzIwTG05TVJMd0Vq?=
 =?utf-8?B?YUFZMFNtYzRxV1E5TUQ4VUxZekJYMkpWRGdHdlN1VVZhbUYzNmovZ3hxRWdi?=
 =?utf-8?B?am9lOWtCcDZDVUtBcC9IdFEwR09DSTN3M05HYXRVZCtvbDhBSEExWlBnVWRL?=
 =?utf-8?B?cU5tK2tmeWhyelZkTDFUdVE4SDFVNldlZWRxRnpFdnowZjZjWXhpZzI1UDNL?=
 =?utf-8?B?V0hHcFJSaUc2aDBXSGUxQkVvR0lmd2FVd2dRU3c4WWJ3Q1hSMzBuemxxMmFt?=
 =?utf-8?B?WXIxdXd1Y1JNK3hndHVGOE9KSUhqWkFPanB1QmFJVVZHN0xtWWQ0WlNZQzcv?=
 =?utf-8?B?azZGcFZRTklTa2FQYVBMbDhrS0lOVkx4U3o1YmFIbm5WUjlQUG5XZEJJeGh5?=
 =?utf-8?B?MVBTQ0JQT0R0WGNMbVB2RjdOV0J2Skd2bzV4Q0tnd3czSTJnM0VuTDNIaUdP?=
 =?utf-8?B?NEFKVnUvSWtkTFJxekgrNkZJbU5HT29Kc3U3NmNiWEF2STBiczhia2JsOWRz?=
 =?utf-8?B?UkVSN3BRNXJEL040RE8xdGI2QzRvbEI0QVcxTUZpQnAwblFoK3JPNU1NRy9X?=
 =?utf-8?B?SFhOVEwwNmlKRlBxMEUzTEZiVmI1MnVoVUExWWtGOTg4Y0FxSlRaK0VUVmoy?=
 =?utf-8?B?ckdpTTRMZ1dOVjRrL1FXSjFVK0pTMGVJVGdrTTZUWmtXZ2VIeVZNREpGTHJU?=
 =?utf-8?B?VlFuMW1GS1NiUTk2c0ttc1pqeWcvajVUanBPdldKK1A2NHZndnBaR09BSExG?=
 =?utf-8?B?VzB5UHBGQWd0cmdhTkJnWXpwRndoZ25VYVR4aTlIdGJvUkZSQ0Jtem40cHU3?=
 =?utf-8?B?THRCeHRRMEtSTHRtcnMza2xxWnhQeE16bng2ZGp3RGdYRzJZd1V1d3pTeHBs?=
 =?utf-8?B?ZnlzZDNsQlh3NDltTjRrVXpjNEhGcnRXd0lzMXZtUXB2dU5LcStudVpOeXpZ?=
 =?utf-8?B?MXhtOFFTS3Y5RmdlT2tCYzNoVTIxWmxFRU5TQWd4MkR0cVFxdnFlSUFrR2cz?=
 =?utf-8?B?enhWYm5qeEhrZC94TGFFblgzZUoxZ2lKdWhsSXRmWnoxcXN6Qm93Y1I0eCtt?=
 =?utf-8?B?N2FPTHNkRDY1SzBzTDlMTUZxYVdES2p6SlVHd2xNMVVXTklrTTZvSmxuTzVN?=
 =?utf-8?B?eE1HTHM4L1E3SmRzTm1XY3YzeUNESWtVUDZtZnhUNTNZa2pVVVlOS3M4WWxn?=
 =?utf-8?B?TzUySG9Ld2Rhc1VHcXlBbFo2ZzBnZy8xL01HaWpBeGU2L2ErV2N1bzBZQUZO?=
 =?utf-8?B?ZDhVdCtFemV4Y0hiOUNVTFFPWHFmbFJjeUxYSnM4UDBLd0lxcHYrSStCbDF0?=
 =?utf-8?B?WS9QU0psYWU2R0xFZlJnVUpyeFFXOW9sOEhsbVUrbXNnSm9NejV6NEZaSkgz?=
 =?utf-8?B?NnJjMWJyblNheitKM2NCVzAzVUMzU21jRmpaQlF2bjNPQno4QU9oa1R4dDBm?=
 =?utf-8?B?NHI4MnEycjFOeFE4b2wwTVg3eXcrOU1QL1NKcS92ZVdHcUZJNWNJWkRKbG0r?=
 =?utf-8?B?bU94WjFxVTF5OWR6MWNDTVRMc2MzU05XS2ljZkJ0UFQ2b1R4ekZGNkQxWmFD?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i25e0nS1nVHOzzbFWSVyBPalGSZZhYMcf9s02RFMF60Pr/WtOCsIZgsWRzhvi8BrRlvy1SD+wGx5KjprvcILk37pGtmLeHWkwW/eiJnjxX8DQXUIPLpKbSmKA+bUaaUYDdeeIgIIsRSInFoUgvhjHB8+VnwgyBA+zkxYpJLYcJHeHH9po8fMzTWScPJWAE5qzF2sSNAQeyR9y07LDl/75zl6mIeNhnEadu6hCNfTndHE59ZGMXA9Wv0fgqixVPghqG94re5kyRFN0iWAx/HT1QZ3DX3jpyaxmBq99zsfd039npJFGjT6OWlJxyt3xZTc678jHD+nh1RD1FVHH70vbqPyzy4apQDRDiHDAD1UMthVK4YZxezCfWU8OP8cAHw8Y7lvCLd/b3K0itEtElnova3d8L6Dq7dGxkX/InSJbRPZ5J5yNTasj1M5oJlZrwGURJ3cGQynofzGpd01LAlRUS16W+FI6L0NqfZwLvs8qfhMhQGJF0jbpA1ENtt1D+/5NQf8FX8czTqC/TlyM1be0ex1EgeMpiRChwctHUBoE0cXS6f8IjFmNwquGlCzn/hAFuH/8UW+hmTrlAN8yeKYc2WUqX9Ol7Z5gY83saRSD0c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fe3aea-c741-47b1-d09d-08dde4cb81a1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 18:08:06.3274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mqy/PaBUDxV1BKE+xaAazRwa8CIuME2xtY2QHhm5sks3BhcyOdBM6iujPe43RBqAM8QYKr+29t5khYJonUJh1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508260159
X-Proofpoint-GUID: s9-sD8Tr2vGU0BRdC8igSKc1RB_N8IY8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNCBTYWx0ZWRfXzBEWQHe4SwQg
 EbVWAM/M53MZt4UmWaD6/LnI/3mtXGXpVVMC1v2FoNu1QKWTENQmB7JNkjUPQ/CEwuO1NpqDxVK
 y0VglUoRWfWuh5D4lhBK+fYblQL7OY8RWyQOX2XOwREsu5W3AWTcTgWm5ppW5651xR0DmHx03A0
 0tODguJlPomaSAdiJiU9GqjGiMpC9X1BIpMD+AIknFjAn39q7g2SYjGFyG7fOQk/L1P9qZMRdYm
 Sdf9xwJ5mWJczNENavKHhite+icMzkfq9Euwd3T3w00SZ9vA6yTbeR9XPk7qPJVgb3YiHubYTet
 2MBizIq4QFVHjjUkGKGqWI4xWj32sfMjHBxpRvTa5P39p8V4csR39Y+PQ/iFhA90wt6KXgkk9Rp
 jPAvwBQfboBASeRvKWIZrAnvpDEc1w==
X-Authority-Analysis: v=2.4 cv=FtgF/3rq c=1 sm=1 tr=0 ts=68adf80c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=fgI0Ke_d68E63C9wQZ8A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12069
X-Proofpoint-ORIG-GUID: s9-sD8Tr2vGU0BRdC8igSKc1RB_N8IY8
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 8/26/25 2:11 AM, Markus Armbruster wrote:
> Jonah Palmer <jonah.palmer@oracle.com> writes:
> 
>> On 8/25/25 8:44 AM, Markus Armbruster wrote:
> 
> [...]
> 
>>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>>>
>>>> On 8/8/25 6:48 AM, Markus Armbruster wrote:
> 
> [...]
> 
>>>>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>>>>>> Adds a new migration capability 'virtio-iterative' that will allow
>>>>>> virtio devices, where supported, to iteratively migrate configuration
>>>>>> changes that occur during the migration process.
>>>>>
>>>>> Why is that desirable?
>>>>
>>>> To be frank, I wasn't sure if having a migration capability, or even
>>>> have it toggleable at all, would be desirable or not. It appears though
>>>> that this might be better off as a per-device feature set via
>>>> --device virtio-net-pci,iterative-mig=on,..., for example.
>>>
>>> See below.
>>>
>>>> And by "iteratively migrate configuration changes" I meant more along
>>>> the lines of the device's state as it continues running on the source.
>>>
>>> Isn't that what migration does always?
>>
>> Essentially yes, but today all of the state is only migrated at the end, once the source has been paused. So the final correct state is always sent to the destination.
> 
> As far as I understand (and ignoring lots of detail, including post
> copy), we have three stages:
> 
> 1. Source runs, migrate memory pages.  Pages that get dirtied after they
> are migrated need to be migrated again.
> 
> 2. Neither source or destination runs, migrate remaining memory pages
> and device state.
> 
> 3. Destination starts to run.
> 
> If the duration of stage 2 (downtime) was of no concern, we'd switch to
> it immediately, i.e. without migrating anything in stage 1.  This would
> minimize I/O.
> 
> Of course, we actually care for limiting downtime.  We switch to stage 2
> when "little enough" is left for stage two to migrate.
> 
>> If we're no longer waiting until the source has been paused and the initial state is sent early, then we need to make sure that any changes that happen is still communicated to the destination.
> 
> So you're proposing to treat suitable parts of the device state more
> like memory pages.  Correct?
> 

Not in the sense of "something got dirtied so let's immediately re-send 
that" like we would with RAM. It's more along the lines of "something 
got dirtied so let's make sure that gets re-sent at the start of stage 2".

The entire state of a virtio-net device (even with vhost-net / 
vhost-vDPA) is <10KB I believe. I don't believe there's much to gain by 
"iteratively" re-sending changes for virtio-net. It should be suitable 
enough to just re-send whatever changed during stage 1 (after the 
initial state was sent) at the start of stage 2.

This is why I'm currently looking into a solution that uses VMSD's 
.early_setup flag (that Peter recommended) rather than implementing a 
suite of SaveVMHandlers hooks (like this RFC does). We don't need this 
iterative capability as much as we need to start migrating the state 
earlier (and doing corresponding config/prep work) during stage 1.

> Cover letter and commit message of PATCH 4 provide the motivation: you
> observe a shorter downtime.  You speculate this is due to moving "heavy
> allocations and page-fault latencies" from stage 2 to stage 1.  Correct?
> 

Correct. But again I'd like to stress that this is just one part in 
reducing downtime during stage 2. The biggest reductions will come from 
the config/prep work that we're trying to move from stage 2 to stage 1, 
especially when vhost-vDPA is involved. And we can only do this early 
work once we have the state, hence why we're sending it earlier.

> Is there anything that makes virtio-net particularly suitable?
> 

Yes, especially with vhost-vDPA and configuring VQs. See Eugenio's 
comment here 
https://lore.kernel.org/qemu-devel/CAJaqyWdUutZrAWKy9d=ip+h+y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com/.

> I think this patch's commit message should at least hint at the
> motivation at a high level.  Details like measurements are best left to
> PATCH 4.
> 

You're right, this was my bad for not framing this RFC more clearly and 
the true motivations behind it. I will certainly be more direct and 
descriptive in the next RFC for this effort.

>> This RFC handles this by just re-sending the entire state again once the source has been paused. But of course this isn't optimal and I'm looking into how to better optimize this part.
> 
> How much is the entire state?
> 

I'm not exactly sure how large it is but it should be <10KB even with 
vhost-vDPA. It could be slightly larger if we really up the number of 
queue pairs and/or have huge MAC/multicast lists.

>>>> But perhaps actual configuration changes (e.g. changing the number of
>>>> queue pairs) could also be supported mid-migration like this?
>>>
>>> I don't know.
>>>
>>>>>> This capability is added to the validated capabilities list to ensure
>>>>>> both the source and destination support it before enabling.
>>>>>
>>>>> What happens when only one side enables it?
>>>>
>>>> The migration stream breaks if only one side enables it.
>>>
>>> How does it break?  Error message pointing out the misconfiguration?
>>>
>>
>> The destination VM is torn down and the source just reports that migration failed.
> 
> Exact same failure as for other misconfigurations, like missing a device
> on the destination?
> 

I hesitate to say "exact" but for example, when missing a device on one 
side you might see something like below (I removed a serial device):

qemu-system-x86_64: Unknown ramblock "0000:00:03.0/virtio-net-pci.rom", 
cannot accept migration
qemu-system-x86_64: error while loading state for instance 0x0 of device 
'ram'
qemu-system-x86_64: load of migration failed: Invalid argument
...

The expected order gets messed up and eventually the wrong data will end 
up somewhere else. In this case it was the RAM.

>> I don't believe the source/destination could be aware of the misconfiguration. IIUC the destination reads the migration stream and expects certain pieces of data in a certain order. If new data is added to the migration stream or the order has changed and the destination isn't expecting it, then the migration fails. It doesn't know exactly why, just that it read-in data that it wasn't expecting.
>>
>>>> This is poor wording on my part, my apologies. I don't think it's even
>>>> possible to know the capabilities between the source & destination.
>>>>
>>>>>> The capability defaults to off to maintain backward compatibility.
>>>>>>
>>>>>> To enable the capability via HMP:
>>>>>> (qemu) migrate_set_capability virtio-iterative on
>>>>>>
>>>>>> To enable the capability via QMP:
>>>>>> {"execute": "migrate-set-capabilities", "arguments": {
>>>>>>         "capabilities": [
>>>>>>            { "capability": "virtio-iterative", "state": true }
>>>>>>         ]
>>>>>>      }
>>>>>> }
>>>>>>
>>>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> 
> [...]
> 
>>>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>>>> index 4963f6ca12..8f042c3ba5 100644
>>>>>> --- a/qapi/migration.json
>>>>>> +++ b/qapi/migration.json
>>>>>> @@ -479,6 +479,11 @@
>>>>>>   #     each RAM page.  Requires a migration URI that supports seeking,
>>>>>>   #     such as a file.  (since 9.0)
>>>>>>   #
>>>>>> +# @virtio-iterative: Enable iterative migration for virtio devices, if
>>>>>> +#     the device supports it. When enabled, and where supported, virtio
>>>>>> +#     devices will track and migrate configuration changes that may
>>>>>> +#     occur during the migration process. (Since 10.1)
>>>>>
>>>>> When and why should the user enable this?
>>>>
>>>> Well if all goes according to plan, always (at least for virtio-net).
>>>> This should improve the overall speed of live migration for a virtio-net
>>>> device (and vhost-net/vhost-vdpa).
>>>
>>> So the only use for "disabled" would be when migrating to or from an
>>> older version of QEMU that doesn't support this.  Fair?
>>
>> Correct.
>>
>>> What's the default?
>>
>> Disabled.
> 
> Awkward for something that should always be enabled.  But see below.
> 
> Please document defaults in the doc comment.
> 

Ack.

>>>>> What exactly do you mean by "where supported"?
>>>>
>>>> I meant if both source's Qemu and destination's Qemu support it, as well
>>>> as for other virtio devices in the future if they decide to implement
>>>> iterative migration (e.g. a more general "enable iterative migration for
>>>> virtio devices").
>>>>
>>>> But I think for now this is better left as a virtio-net configuration
>>>> rather than as a migration capability (e.g. --device
>>>> virtio-net-pci,iterative-mig=on/off,...)
>>>
>>> Makes sense to me (but I'm not a migration expert).
> 
> A device property's default can depend on the machine type via compat
> properties.  This is normally used to restrict a guest-visible change to
> newer machine types.  Here, it's not guest-visible.  But it can get you
> this:
> 
> * Migrate new machine type from new QEMU to new QEMU (old QEMU doesn't
>    have the machine type): iterative is enabled by default.  Good.  User
>    can disable it on both ends to not get the improvement.  Enabling it
>    on just one breaks migration.
> 
>    All other cases go away with time.
> 
> * Migrate old machine type from new QEMU to new QEMU: iterative is
>    disabled by default, which is sad, but no worse than before.  User can
>    enable it on both ends to get the improvement.  Enabling it on just
>    one breaks migration.
> 
> * Migrate old machine type from new QEMU to old QEMU or vice versa:
>    iterative is off by default.  Good.  Enabling it on the new one breaks
>    migration.
> 
> * Migrate old machine type from old QEMU to old QEMU: iterative is off
> 
> I figure almost all users could simply ignore this configuration knob
> then.
> 

Oh, that's interesting. I wasn't aware of this. But couldn't this 
potentially cause some headaches and confusion when attempting to 
migrate between 2 guests where one VM is using a machine type does 
support it and the other isn't?

For example, the source and destination VMs both specify '-machine 
q35,...' and the q35 alias resolves into, say, pc-q35-10.1 for the 
source VM and pc-q35-10.0 for the destination VM. And say this property 
is supported on >= pc-q35-10.1.

IIUC, this would mean that iterative is enabled by default on the source 
VM but disabled by default on the destination VM.

Then a user attempts the migration, the migration fails, and then they'd 
have to try and figure out why it's failing.

Furthermore, since it's a device property that's essentially set at VM 
creation time, either the source would have to be reset and explicitly 
set this property to off or the destination would have to be reset and 
use a newer (>= pc-q35-10.1) machine type before starting it back up and 
perform the migration.

Am I understanding this correctly?

>>> [...]
> 


