Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3A9C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU110-0007ub-9d; Wed, 17 Jul 2024 05:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU10o-0007sI-CN
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:31:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU10k-0002VP-CD
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:31:49 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H9Kbnk016827;
 Wed, 17 Jul 2024 09:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=noksrDEL/xTXf3K3NwajSWgJEivKlTGD2OVjDvsjkZc=; b=
 SgjyhqyBetfm8Es3OEPIxjEyHua9mmKk2G0zraTHhKysf/BsxtZMER59hoYBpq+h
 ujKR93fsMHHXB6xr2ZD98DzU9S727WAfNyshx8w6l5pRNLfn+IflW+n6FSH53n+u
 Emo6f8KKWwP+tXOecqUBsj7vZICxig0hJlv64Rq/z2aRD0dBBWSjc2IzhJJHJyG+
 ZBL91MgGJ/rYVCwI1BtpFAmavG9uEaYmCHxacpep5c1pYYxjGUHgMDLGrJOEXp2g
 wgHOSEv9liARO5dFgKpQaDrbshufuHzcR/rCkuXWkA37DjDa9KkPpn3K0s4Zcb1C
 6HWDselVBHqPdZB//ePEMg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40eb80r19u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 09:31:09 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46H7qnLf004508; Wed, 17 Jul 2024 09:31:08 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwextvtp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 09:31:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkRtN0qiWzRXHZ4Jbd+l/JsvnII8rW6w4ZIhDWmnJax2K6FvdKMVonuLSzYd/qwCdcNCw7F9UTcSM+XdRzezNxeMj8Xm88d0e2TPSjTR2dNxIPk6o52OYpS+jUWKyL8977PBLXH4hdbPDgYiZuVbPEpyZIabZSXcw22EZa5RKY+Gkxn3uGKhFwh/1wsiA6N/s48IklbpJ+xI53GN/668RK8AiWzCWnly8G8mxwfy35t4mqEFSnCj4Tbx1ytwOUeDoB9HKAKYxxEV8cl4i8T1hKmfg6/9GF/jvLhMUqhId/c7BZsnSBqBmT+9yz6Fw9vUv+sPuKvUra4ZVGQAfrCzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noksrDEL/xTXf3K3NwajSWgJEivKlTGD2OVjDvsjkZc=;
 b=u8urOrLO0szpjZqL1rQe3aSdExtH8R3JvZNfwhxnON1el+zfjKSNBZhIK9et1iideh5CcxOuEeyxOEtjdIKYLQzcFwCeS6Hn4g4jwsbV5Uzn3aIqlypDvdB8lP5/wlYe2XBfbfKm221oQCmstDsBNzuHPsV9cuCcJ34BM+Qq2yLRQSXPaKyLhzFa8teudBFVYlXsnmkHvAIo4xzwT3DYoCSQdoWWNvxWs34ffxV3vsoAD54vdxjnRMM4rIzBz6AUlyy4xp3kRl7o/FiGQ6MKlFTApXWWEQpqv6air6+fKQIWBFo0KTTEmg0K4N/nt650HHt6cPiXmrLhysSvGuisEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noksrDEL/xTXf3K3NwajSWgJEivKlTGD2OVjDvsjkZc=;
 b=Ct/kiwnmF81D/zjKHx1YAubuOr/G4VzdPhADkB9KGYIpHrvWGJ148DXF1Cy28iD15+a+/OvIzVjV54A/gEuAGN4uQdIsl8jvBs4Rrr0DtZRm4xd7jqiF+JPMNF1IneY8PfZy3sGrl9cBI3cJ6lU1Ec66OJcF+aaaG5BIhnU2Nrc=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH0PR10MB4534.namprd10.prod.outlook.com (2603:10b6:510:30::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 09:31:06 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Wed, 17 Jul 2024
 09:31:06 +0000
Message-ID: <5f97ffc3-a7d2-4c4d-8420-112d1cf157c6@oracle.com>
Date: Wed, 17 Jul 2024 10:31:00 +0100
Subject: Re: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-6-joao.m.martins@oracle.com>
 <f98463ba-32d1-4d9c-876c-715d0ca6ae3c@redhat.com>
 <befcbcfb-2ec4-4ec7-bd14-504c9363b3ca@oracle.com>
 <a67edbc5-68ce-4967-b8b9-a440904ed1b1@oracle.com>
 <SJ0PR11MB674475CA28136228FE93072A92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <6ce29c92-d9f8-413d-92f3-8a30e937f746@oracle.com>
 <2bffe255-f5ae-4004-aa64-e62ccf201464@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <2bffe255-f5ae-4004-aa64-e62ccf201464@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0258.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::30) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH0PR10MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e71d3c-b894-4eb7-ac90-08dca6432efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFBzYnV3VlkzYWx4aXJuajl6YXN0N1VIZEpCeFQ3UEdzZGtEZTNBVFhTQ2RO?=
 =?utf-8?B?MFVpa3ZRSG1GWk1kbkwxU3JzNzZXZ1hVZE5OdXpCV3FhVks5ZnRFQWNrZWVu?=
 =?utf-8?B?T2dmVjJJVW1FbU0vT3FSRDZzbEJ5UUZKZXc1eWF3WEtyYzdWR1czeHhzNXM0?=
 =?utf-8?B?dkhxc09pMCtzZkJtcDFRRUQwakY0ZWxDSmYvdXhWOFV2RFhtNlVwU0F2N1c5?=
 =?utf-8?B?ejBDRC9NY0N6ODZNV1NLMGcxdmVZWktUR3ZVL1dRZkRPYkRLRnhrVGU0dXg4?=
 =?utf-8?B?cVJmaytNTlhmdVFMc0QrMmtlVUxMT2k2YmkrdG1mQjFhZitzR0ZMYnNxSGY2?=
 =?utf-8?B?eWUxdEFjN1VpVENzTUlrNjB4UkxOT0FzZVhEMEJmdk9HQ0p5TTZ3NVlLRmVj?=
 =?utf-8?B?dHk1dFJRUGhXR1hjMEgySU83L2U2WTNoSG5sWGdRN0VSdWloSURoRElYMm9J?=
 =?utf-8?B?a1JvUkZ0MXlFbHk5VzhFbExXdG5GNmU4dWJFZ3dKL2NrazdhWTJZbjJIaWZW?=
 =?utf-8?B?MklzWU04ZisyZTcrRWJQcDlzZGlOSS8vcmthU2d1MWQxWkwrWXB3d0cxckcy?=
 =?utf-8?B?aDZMcWgwa01xY0lpR3RuVnFManFDeTluajNLaTZyLytycHhjY2ZhNHJHYVpx?=
 =?utf-8?B?UDhyWGhpR3BteS9sUEtudm8rL0hrVE8rcThvN3owZ2w2UnJKSWpIa1FrVVVS?=
 =?utf-8?B?UkZUcVZUSFNDTTVUamtaTFZBZ0J6NlNNc2Y0bldiUk5iS21aQ2JETWtWUTZK?=
 =?utf-8?B?cjRhZHk5U3ZkQTk3V3Q2bFYzMWZnWGRzcjNrWHFiZHI1eFBKZkIvWVRiSjgy?=
 =?utf-8?B?VVVWM3cxOGExSzhGN0lYOWdrNXhMMmZRWlk5ZVZtODZST3laZlBsc1l5WmVy?=
 =?utf-8?B?L0RLT2MvblVvbG9XQVF4djUwQUhxRURHdGJBa3BlSnlyWis5L1IyZGNMMENL?=
 =?utf-8?B?eVBuNUZHei9DV2pERzVZai9rNy9MVEdHQUNIcWpIbkFqc0VBeHNSRVRjdURP?=
 =?utf-8?B?YnFCRm1IQXh0Y29WSU9HU0FtY3ViWVFZRkxFZUI0M0oxenYwWVpBYkdYMHBk?=
 =?utf-8?B?eVZOOUUxRUNRdmkvOFBtUnpaRVd1N1RQM1NGTU5QcDQrVUs2Z3RpSE9idkxG?=
 =?utf-8?B?eE5USUZQa3c2V3JUV2FrTDVHNW5IdklOTkpNaW1wVEFWSXNpSUduOHpEY0dU?=
 =?utf-8?B?bklFenlOMGRwQkQ0MkxmaFdZWDdRNEVNcFNvdTJmNWdtcnBGSTRYcVdTcXFv?=
 =?utf-8?B?ZWE2S1J6UjRReWFuRW9EektINlM1N2luQVFnb2xTcDBLOXNTVTA2aktNdFk2?=
 =?utf-8?B?eWZnS0FCZThwV3FzY1dxVnVkWUdjTzVRWVhMZ1lheituTTRvT3pJeFlERS9B?=
 =?utf-8?B?VGZCc0pwY05ka0lCczREZ2w1L2pndFpLTExaYXlBZ0RpM1N6cVVzcEMySk1m?=
 =?utf-8?B?MC9LMDlkUDFjRlQ4NVJVMXdsWlY4MW41NVlUMTBsNlhNNkNNZEVRZ082cTlp?=
 =?utf-8?B?Ukh1YWJ5L2lFU3AwYVZWbkEvVE94ay9BK3ZNNE5CSFl6bFhCY0UwSGtPVDdM?=
 =?utf-8?B?Vy95ZUZBSlQyV05Ud20rTWhPMS96aUluREtyMEhHekprTm1PWjhQTVI2eXFS?=
 =?utf-8?B?aWN0SnNyZklVV1pkU1pvRWUyY0JrU1pqaWhnT2F1MUNRZE5VenRrL3F6RXFx?=
 =?utf-8?B?SHJodnlEM0dRQ1JiR3JpRklmdkRNQVpxZ2lWYjZxaUtHSUM3enJtRndmdE16?=
 =?utf-8?B?emZxOW5FZ21HSUY1cWdBS3BONHhPbXMrY0JKc1k4S3VMNms5MjBPbGZlU21Y?=
 =?utf-8?B?eHE3cTBQbExuYXFOSFVwZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Skd1Y1dCYlBESXVTdWZ1QXBYM0pKMnhZMGtXclAyOFFZNW5WZ0xGcmJlZElz?=
 =?utf-8?B?ampza3c4OTNrVVprL0gxVlJzaGpBdDd4eDNBS1dSdWdjZjMvRzlxZ0ZOYzBZ?=
 =?utf-8?B?bFJaNmM0TXRiUWFVMFZzYXZZbVlYeEtqdktWNWIyTnNZeWMzOGc4OUVWZmpn?=
 =?utf-8?B?MXhIMEZtU3gwV05MS0lGVklZOHA2UlFSL2F4aFJsSytxeVVmSUhKSEFGdVhu?=
 =?utf-8?B?UWNzd2lMZXBHbk9OVHZtOFVia01hSzIyMnlGL3YyYXRPektOYlNBbGRQbzNi?=
 =?utf-8?B?T2E3b29YOU15VFY1ZC9jSFhuU0ZpODlLWjNOZkh2eXFvdldKeHgrUjYxaUFP?=
 =?utf-8?B?OU8wdVNkMWNPL1lIYndDanlydmxsVnlwaWZvV0Nxc3pBTXl0bXNrdkRSUzNw?=
 =?utf-8?B?dFhiYVEwWVNCaEUzU0lLTHBwZ2xRc0dKVktQZTlrdG5ZcnlUVE5QT3ArYVJE?=
 =?utf-8?B?emZzSDhqdE5hYTFUdWVKZDJwc2VkZ3lINldacEc0LzU2aG5JclQ2NFhZWjZI?=
 =?utf-8?B?Zkk4VE10NXNDK3p2N29VbDVIVXNTNU1CaFVaZTlQSnB5dm5VaTN3WlVNdnUy?=
 =?utf-8?B?M3lTbE0xYWtvL2F6d3dNN3M0eEpDSGozZzlab2xYUVV2QVlEalRXWVpMeVRP?=
 =?utf-8?B?d29oM0k3N3ZPdVg2VFYvTVlVWjFiR09leDQ1djFxaVBBUFNqZlNsb2F3SVM3?=
 =?utf-8?B?WitVdEdZdFdmbFhncTA5NlM2MG8vTmpIVjY3VkQ2Z0x5L0tHcDg3a1UvZnNs?=
 =?utf-8?B?UHB5Ykk4WTRzNVI5aU53VnJxekEveSt2SS96QVNFenJyUHhQS2VSSktrVWo5?=
 =?utf-8?B?L3NFZDdaaU9hYmdEbFpnS04xc3FtaXZTMmREV1VIRTUvbFBpYi9EODFIS2M5?=
 =?utf-8?B?OEx0VjE1b0x5YklLamp5dU9ZNGREOHdEVzdoa2pFeDcyWEV0eXpQUFZKcU43?=
 =?utf-8?B?T3Y3N1FjTm12S3FXZXVEVWNsUlg2Uy9xalQ0TVlwN2NoSTRMTkJtVjlxQVl3?=
 =?utf-8?B?ZTJrT09PMGliY24reTZCbHVwTFZGb0NwcWd4cENzclJZc2k1aHpsQXhTUGM2?=
 =?utf-8?B?OEQrRUk0QWc0Z0FBd3M2YXdTRzdTL3ZCV2pNMFh2R2lFeHU1SFZESHYrWGlS?=
 =?utf-8?B?dHZMQlpQdzZOb1dRYUsyRmc4aUwwZnMwRUtNYmtHWVhWQ0VZcHlzNUt5KzA3?=
 =?utf-8?B?R0ZWRndtd3Y2RTJIVC9QRWR4NitWbldkT252UGVDVFBuQ0lZbFc0cWo2ZitX?=
 =?utf-8?B?UE9SbFFwd0w3VDc0NHdCbmYyN2cwN0p1b2JtcWRwckRyMkN6VDRvRE1TeUF4?=
 =?utf-8?B?NEh6em05M0w3cWVxb0dBeGlsallVR2g5VmNVcCs2OTJnSytyTHNkNURVRXNK?=
 =?utf-8?B?TFV6ZEJOVzg4eXFZdWd3dElNbzF3anM2NlU2N1BmT2swZWdVMWNMY0lNZCs3?=
 =?utf-8?B?aG5KaXZCWVBxdGJCUHlQeFM1VlNjeFYvQWw4WWRMVWFEVUJOQUtFSnMrUlJP?=
 =?utf-8?B?cThudFpnQStkaHhYVHEraG84RTBqa2pqNHRWMFA2bnNGMmw4aThRUnlEY2tR?=
 =?utf-8?B?VGdGS0R2bzZFRk9PelAxUm1lc2RJdndnQ3BLQU14T2hWbW9vQi9WVnhtWDRC?=
 =?utf-8?B?MHZRcDM2Z05pZnBTc045UDgwSEtJd1dOVWN0YjZXTVB4ZGV4TmI0dUFBQnJB?=
 =?utf-8?B?dHpabm5JNm5weUtpd0g4bS9EL0RqZFphMUNBZHBMWENOUFRNTHZQc3U4cFNF?=
 =?utf-8?B?T0RXbzJXeEUrcWEzamhDUzdJY0VqMGY5cVNnREx1Zi9EY095S2UwOVM0T1Yx?=
 =?utf-8?B?Y05lUVZPa1JFNmtOLzgvMGd4cjEyUytjbUVMRjJFWndkR2pKd1ZZQkZ4VFdP?=
 =?utf-8?B?eVZsNTY0YW4zQWxCendCdG5KTlhteE1TL2IyeGZ1dVpuTDRkazlEZ0JOL1pJ?=
 =?utf-8?B?TndOUW9RRUZwYlFsTlhsWm5OUFJyT1E1ZHZyc0NDT1dSVGp1Znh6eHJSa3Ux?=
 =?utf-8?B?cnVndEJNOWlrS2pyQWhIKzh1ZGVJN3Zxa3NFaW9lb1NpdlcrM0hNclZGVXo0?=
 =?utf-8?B?TGVJMlZuR2QvMWhxbTVBS3F2dlNxcTBOR0RUZUM4WnJCQ2p6WnIvdUVwbXEy?=
 =?utf-8?B?TWhrNHJxQ0h3U3FtckRTa2x3OS8zWnE5RDd4ZElxbkFBbEJCenRWaVh1MEJD?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /QBm1+5Sm7NvQXyGTbQXYu6LRMWTY9aVsSXo8PWvPKDzNINK560VMmoRI1TGMDv1Jjp8VKbtuQ/hNOgM5i3EXmqnxC0ZC3Pwj0c+660O/t5h/Vdv7SjWo/WDsd9R7hGhcOlrq9ehahAd16Pwc8QdoRxB7lsFwEa9D22zPUkRbmfQRYajg1yCk9F4oiTDeo9gR0hBVWwGuiS33GHO2bKBhfEu58a2CxJ6qeop+pBtWj79HhM7Q7VneatDa85XktzRMBLUnhHIDMuAALedGTwdRH1Z3KXwl0WqqB9QkWZY/WtqIPEokjLpvVgTOw4j5fNPswN7PIvwU6aU/bE3oAfTGczyxm5mQ9HByAnXTaw7sNieC2iv0NdvncrMy5VwwBHfkvz5p5NGOh49nhII6YNMHXDc6ypoB+2piuNJsPruZiy7+wJUjMvtsjl0mCfiOjAfKdMUVWN3vzV/tWz9D4XYRs8DEx+MDFOoJdj4i10kOBVD2+umYWUu0C+zDxoyZNPpDwAHGvqYqcIM3IX/Rl8nS30zmJ6MiA8DzdajIzcBcxbDa5fsT5zaTjTpxhgAFrGitVEo/YPNewRPwTPN4SUuQebzJyih6AXvsqUXXTyoC9g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e71d3c-b894-4eb7-ac90-08dca6432efb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 09:31:06.3575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjIfLyl1wNYyt+NBWG1gnxT/yH42g4sREpnYjkjTe4/oqRotzYb4ioAnh61kJMHA7mdV/O/9uNaiD3iykto4hYJmz8LfA0QUp2j0d2RW2aE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4534
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_06,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170072
X-Proofpoint-GUID: KqHoYkReHP0Wwih7RTbk5bi_yzSe6NiX
X-Proofpoint-ORIG-GUID: KqHoYkReHP0Wwih7RTbk5bi_yzSe6NiX
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 17/07/2024 10:28, Cédric Le Goater wrote:
>>>>>>> @@ -224,6 +300,11 @@ static void
>>>> iommufd_cdev_detach_container(VFIODevice *vbasedev,
>>>>>>>   {
>>>>>>>       Error *err = NULL;
>>>>>>>
>>>>>>> +    if (vbasedev->hwpt) {
>>>>>>> +        iommufd_cdev_autodomains_put(vbasedev, container);
>>>>>>> +        return;
>>>>>> Where do we detach the device from the hwpt?
>>>>>>
>>>>> In iommufd_backend_free_id() for auto domains
>>>>>
>>>>
>>>> to clarify here I meant *userspace* auto domains
>>>>
>>>> *kernel* auto domains (mdev) goes via DETACH_IOMMUFD_PT
>>>
>>> If the device is still attached to the hwpt, will iommufd_backend_free_id()
>>> succeed?
>>> Have you tried the hot unplug?
>>>
>>
>> I have but I didn't see any errors. But I will check again for v5 as it could
>> also be my oversight.
>>
>> I was thinking about Eric's remark overnight and I think what I am doing is not
>> correct regardless of the above.
>>
>> I should be calling DETACH_IOMMUFD_PT pairing with ATTACH_IOMMUFD_PT, and the
>> iommufd_backend_free_id() is to drop the final reference pairing with
>> alloc_hwpt() when the device list is empty i.e. when there's no more devices in
>> that vdev::hwpt.
>>
>> DETACH_IOMMUFD_PT decrement the hwpt refcount and it doesn't differentiate
>> between auto domains vs manual domains.
>>
>> The code is already there anyhow it just has the order of
>> iommufd_cdev_autodomains_put vs detach invocation reversed; I'll fix that for
>> next version.
> 
> While at it, could you please move these routines :
> 
>   iommufd_cdev_detach_ioas_hwpt
>   iommufd_cdev_attach_ioas_hwpt
>  
> under backends/iommufd.c ? I think that's where they belong.

OK


