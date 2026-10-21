Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA83B606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=0NlzqJF5;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=K0k2dUIK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJYG0-0004bQ-Fo; Wed, 21 Oct 2026 11:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xJYFy-0004ae-OQ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 11:29:34 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xJYFv-0000Ar-95
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 11:29:34 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LEGuTC2154049; Wed, 21 Oct 2026 08:29:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=EyzUt4miw1h9iwxpYHYX+NSr9Iq8fmPl3drzE+roD
 tE=; b=0NlzqJF5ehxPK1CsCSkDaPmga0YuhTX/KXH53n8GyVzpEYj/kQpfmfezi
 fQG2PJ2PfMnuy0+r6VFiEV5ET2j9WFN8xenxKkufjRBgJP487X0LJftvC2his1a+
 dW5S0lWKWcjLMnxlH0MrYvZVY9KFbPAWDHxRk7wMYoyZUQ92jr5UFtt6l0uQtKyn
 EX+3vFs32RTeLi1leMd2zZhfXIAO4vmUeHMz/heCTtx04lZYOI48K/4dJ0hj+Y6z
 U+Yvgtn7/XOaYw3uzxtkpQEelig2WEY0P7G0P705Xc7nvJXs5HT80mVLnBWF+A9+
 PKcdkgEztLBMDBOvIf/6S9Q5rfIiw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021116.outbound.protection.outlook.com
 [40.93.194.116])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hdw5rd96g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2026 08:29:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tT9g8PfMCFwuvZ09YAElu71QHrCvdHleJLjQkSeJ0E89zb8ElSUoghmyB/JK5779u3D8G/IeGSl9ZGmLo2r/Xgup3d4+GwECCQ79aK7kf/wCN8JGO7VS/IWGcDWMHjP63u5cBxuKqr8Vuxlw5hxSseSBQ6WpVZfUzYibt/ifRjV4w6xPT+YSUfW6phqaAbLHxwZaktW9gNpgjJH4bBl1o4UhxmoHBTdNAoR1qLhmfmUdK1dlC+skiMn6ntEYtnkTYOiBVTkRY9vfuEWGvb2ONs/vzoWEoi+HZgtAuO9P7WogH7sRygrrDSErGlFZfbCXac3ROGf0UtzA2OdNis0vkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyzUt4miw1h9iwxpYHYX+NSr9Iq8fmPl3drzE+roDtE=;
 b=RySvdUL9oubRV8U7I6MngqIUneb4dEjUU70MBR/vU+hotRtRtDGXAE9bQpljwt7C3zrNdMGjwlmPuPwPevQGhXGO+vgSrv0hHpJdw1T1fBkfGJQeNKYG9wtzvnJUOKsD2cqE81/3ImlzrP7HQmbWeuPcv1d1PciLpDlYJdPA1FWK0XVqkHIqB/6pp8puj1NUTD3OXEDiOyYe9+jnDxw1abIzKTunzpRcxVLQL5wh6Lddy3jLfIgimUPxfFBlfSTWhFwPDwakmlII4HZotVei8ucreEiuQAFbkomzEQlL0WL8XIXXZG7PiTpHxg28rCGAiEADjwUtOOFFeFzJ8C5pUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyzUt4miw1h9iwxpYHYX+NSr9Iq8fmPl3drzE+roDtE=;
 b=K0k2dUIKMB38WOFiWeo2+1nDKTqetulQuAAMdl96jNP8WAHVrUwZGS0y2eR0P46uEI3XI/2DeyqsLXq3C6yauqPrNdkLqOKTqZnQPS6h21Os8X6tzzwjKUVV95jDqg+deg5mJ35NWVTl4OCXEH7QCoBkZLPHjyJTqnrDzj4GS+fkfKsUUJZe29vN146Onsr4xyYi+xP7s6dafkBMzIMT0k2IvxYVTRXHLhr9LlRlNloNQ69LlJC/vsQq6E4+V/gHjFVhj5goBFnaTOPJgl+Yxe3ioFNFtxCUh1Ivl2vJKIl43OeR7ToL8gUA+bug8fkTZSEmUgpYsTIhTNlhOA6s9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB6810.namprd02.prod.outlook.com (2603:10b6:5:214::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 21 Oct
 2026 15:28:52 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:28:52 +0000
Message-ID: <3148a8e1-8f5a-4773-a4d1-4aa5a5465531@nutanix.com>
Date: Wed, 21 Oct 2026 16:28:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/28] xen-hvm.c: rename
 xen_interrupt_controller_init() to xen_i8259_init()
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, xen-devel@lists.xenproject.org
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
 <20261019120517.1448687-23-mark.caveayland@nutanix.com>
 <22FB9414-4D72-4699-9FB4-107D9DF10F28@gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <22FB9414-4D72-4699-9FB4-107D9DF10F28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:217::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 3631a320-405f-4c14-de7e-08df2f880306
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|261009223027099003|56012099006|4143699003|22082099003|18002099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: QDuAtallgV8IK0HlyXoqwawdrE/5P7AEOqjz9yLFkfzr5DKu+eE/l7+gKW03kAGvs4Pn3PkPmCW7CRlSf838OYKH/CWaK1lhbnTjeUL8Tcj33/m2FGNDivlQ4SDl7W2hYrsecf++rfje0NsrP8Xutgmtia/J3eQxHM4GXxD1y4EiIyvvUW628j3OnuNT1AMwlvsbiORXJyWHpuocCiZhrKzImmpyCSdKNyDVdmVkequLF15JZHEiRGufKq65yh4QM7Vpmfm91l7yERPqXCP/fMZv4Wo8LAf+cHNzXa9j5IN9t0vSl4oZkOaf+XRRK9sc1vHtU31FtfsszWh9PORtCpbrcmDke21jPPj7jtZLv3vM4OMzLjSh6S0ulFUUS9VtGKJ7zyywULou2iuuA84Dnn8ur/zjNWq36jpU+cUsZ/eOqf856o9fAv0r/sBbnup+Zirn0QbSXRQy9if3+PbHBzN6OzZ581GFjFkL/wBb7OTaYazZaTBYHpSVYB17R0pxU6yyR8OACzghG/KPyHDw5pEucZDJZtFObFlympEf2ey/WQf2+rz8Drnip74IVuEDj76srl0BDSjNfeigbd88i449wEq0jDr0M14MHzv+Xv39FE9PehjWLONgQCd0MCwoHC9sD9Lcv7v6nfuzFQEFVqWWmRa48XMZuquuwOG9jXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261009223027099003)(56012099006)(4143699003)(22082099003)(18002099003)(10067099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1QrMjJGaHF5Y2dWVlBWYm9kbnUzZUlwQ2l3NzM0MU5yNkVWbng1MWFZeDE2?=
 =?utf-8?B?K09WT0ZRVW5NOWs0MVMyS2prYm5jcXArZkprVCs5R1VpTi9hQU1kekZLVUVV?=
 =?utf-8?B?QktmQUM5bll0YXJJOGYxb3RmeUJTMzBhM3M3d1lOb1ViWDMvSXppVWkwL3FU?=
 =?utf-8?B?Vkp4cGtqbWsrckRwa2pob1RMQjUxUU4xY1dKYXVlNmh3ZU9JSU1ndEh2SHRp?=
 =?utf-8?B?TDBDcmhYV055cXlQd0p6dENBb2ZOdWNVTjZySllSaXBIZFFnOXNFd3dBSnRs?=
 =?utf-8?B?S0Y3amg3VFdoS0hWQktBSWxWUHhYMHVZNWg4V3RyWEpzSDJyRDBURmJpNlg4?=
 =?utf-8?B?dFlteHJjaVpDYkRTbng0a3dlRG5aYTlabUhGZ05UeGZTNGdlR0llSnllRTBX?=
 =?utf-8?B?NC9QUlBCNUs3RjRKbDg5WlVvRWF5eXMyZlBpS25nRXBMYitmREpnelhBcHJC?=
 =?utf-8?B?eGtKOFBYTlZxanN5V2dHanJFOWJVZk9tc1dzdlUra0FkS3VZVHVIc3VUdWl2?=
 =?utf-8?B?dFl1RWh3Y3ZtTTMyM0h0SDVVbUd4anlGcmZQbE5rWlZoMTJTM3A4T3Y3OWVr?=
 =?utf-8?B?NlQyQ2NST1BFUzk5Tnh2a3ZlMUpsZnpEYW43ekRlR3lKZHVIWmRLUldoMnU2?=
 =?utf-8?B?L2tHQVJ6Qy90OEhrZ1g3TVk5WHpRVVhMOFNSSWRGemt4b25kdHU5S2RiYkdM?=
 =?utf-8?B?MEh4MXpWNUJLWWE0QVhmUitvdmpWODdkMWd5MjlXb1ArRHZBQ29STSt3c1hH?=
 =?utf-8?B?cU5qWUthSXovMjV5N2pCVzUvNjNtdUlMclBodHFJUE5QV3NKZnBIa2tvVDBm?=
 =?utf-8?B?dVB3cE1DVC9Ca09UdXptbTg1d3FNVnU4aGJoUU54RzZieEdBUlBMc1VrNVZM?=
 =?utf-8?B?emZwZWVwVXFHcDZZUEpwVlB2RlBRYjI2cWVLRnZOZFpUWUJkTUgrczRnNERF?=
 =?utf-8?B?bzZ3cDdySjFmZm9VMG0zSE4yVDNHR2ZYRU1hblFpODZPVnV4RW1vcE90SUpk?=
 =?utf-8?B?azlYS1dmN3lYZzZMV09sa2JqMFZUaTJNekJOYlRZNUpmNU9sZ2EzbUxmMk1H?=
 =?utf-8?B?T0dTVDJabDh3Kzc4cGlJekEyVkpPUEhSY2lkQkUyaThmK05NTE5UTk1rK3E2?=
 =?utf-8?B?b0xxS0lpc1RFdzZkVU9MTldrUlBJamg5ejNZNkEvQXp0b1pWSC9ZaThVdnlU?=
 =?utf-8?B?bllsN0QvTmdiaXhjOWVEaVdnTUJEU0RkMFNQK3c4OEp6eTRMNjg5WTVYK25n?=
 =?utf-8?B?ZmhkRlBxY2hRaTBmYUlhMXRONkpzSUxmUkJKN1F2QVNqT1FqK2gyMm5hTS9Z?=
 =?utf-8?B?WnBUV3ljcWxpUHhkWlQ4YWFSMFM2eXFvVElZckVJQXZMWDI4Z1pZSjBPWDI0?=
 =?utf-8?B?REZKVVM4cy85amhraENlb25DNFN6ZW1wYitKTjd6aGVmUVk0NFd4Mm1hTUlo?=
 =?utf-8?B?ZkJhdm56RkJnTmR4bFVVempxNU40YTZPalZPVVFBeitqdkxKdC9XeWt1S0ZN?=
 =?utf-8?B?d3FSRnk4bnV2RkFCMGNRQmNkckhLZlZucFZCVWhTNmFRT3BROHl1NlVoTlBO?=
 =?utf-8?B?OFVadjRVWVFVRmJLMXBHZkFmakJMWGdmMEkrZ3FnMjd6WXJVVyt5OE12Rksy?=
 =?utf-8?B?NVZvSDFidWxlK2NwQ0ZkV1FNMVRsWWhiWjIvUnVYZUFyTFBVRGRkdERQbUlj?=
 =?utf-8?B?VTI3Q3JlU0lSK1YyZlNMOWZja2JFc2dxeEhRQXRVaFNLOWh6SkU4RXhBMGlj?=
 =?utf-8?B?VXNOMEFybTJRTVdmajl4elQ4SU9OWER0a1lXM08vUzBvMGY1ei9lSUgwZXd1?=
 =?utf-8?B?dnllaDZNazBzOXFTMHNqRWEvNGIrMTA0dkRxTTdzVHcxempsaXc3Tlovenk1?=
 =?utf-8?B?bVc5L0k4NGxqT3lRVi92TUhSd3JoS1p2L0VMaTJLZ2tmdjlBRnYrUUllMEh2?=
 =?utf-8?B?NTJNVGhNWFRTZHdNU080SXBiUXBLcTc5dWdiZkJQZ0Vmbkg2ZUtsV1paYytm?=
 =?utf-8?B?OVNlTWlaSkY4WXJrTWNVWEdDQ1BnTGRjdHlJUTN5ODNCRGRTMzFrNC9TejVU?=
 =?utf-8?B?VVdUTzV3cDFNWEVWVGwwTFNTZ1hGb1R1UktLWmVkRHQ1b0pQajZuRDFOS2tu?=
 =?utf-8?B?VkE5dXZyMW05elVUdzhmQWFHTGNjQnplUU14R2NxeGVDK3BGOHkrbnVuc3BJ?=
 =?utf-8?B?MjI1TUY1YzhqbEtCZVgvNEhZRHJiMHpyNjZmOGtkNFFyT1FRazJPbVlvaS9U?=
 =?utf-8?B?NnpUckdQOExEYzVFUU9UZlVULy9tRFBwdHI4UHVuSDVNNmJBdStuSWx4Rzdz?=
 =?utf-8?B?TFVuZGlqMms1WWtsZ3JOYWtjb3c2bkM5Tk9jbW45R216UlBYa2R1dExEVjRG?=
 =?utf-8?Q?gaeJdo04MdrTKuME=3D?=
X-Exchange-RoutingPolicyChecked: dRqtH/O8RXCs6nJjm2T45m5Jnu4crSsQ+B8coVt6XD3F40sMTExgn04zZ2KMNK6xf/grt/bQZFu45WOVdK98w4NMaoZ6IQWi3rfqPXgXGgtd5U5gXKrKqz3kUvy7gFJlJT3CkUFjHEH8+qCnjtq9WcnWNsdl4IPfOUoLZpJZk35jsVjZv0fTKSNvZi4oA7qqLlc2XakrkycNKq2XDzjiJeHseSjfNy5uec7FFZx073MMAPeLxEDAupMiz5V+q3sdrHEvsWu+f11BNflQWvph2NXOP7Hadg2DIIpP9p6gu0ADnyPBNGXw2E14JSd5H5GBQh6OlFckfr/7q3sqmAK1/w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3631a320-405f-4c14-de7e-08df2f880306
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:28:52.7588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAMVlFxiAvGmuac9xkh9YdllWLQ4DTuiIt1ge1Kthjh3U+2RWMqKw4x5IwMIaT1mpHVO4r1DD5WrFjkxpAEedmlqud8HfmHfZ+j1s8Qq5rI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6810
X-Proofpoint-ORIG-GUID: 7TQJyx3FTLsyPtSWNx71hwwAmBNoDsu9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2MSBTYWx0ZWRfX90I+hzSomUgY
 eX5nxWqFNSSWc/+SPhhRX+uSxg5xnq0SdfhqdQ5w06oENBJY0S6TWVqXF0FQCus2IgFD0mEP38H
 8Ipu7jHXb9Nw5h7ssdIl1kOeAz6GSkE=
X-Proofpoint-GUID: 7TQJyx3FTLsyPtSWNx71hwwAmBNoDsu9
X-Authority-Analysis: v=2.4 cv=At97T+9P c=1 sm=1 tr=0 ts=6ad8da3f cx=c_pps
 a=U/cWNT7cGANcmDM7K3LxiQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=K7m7aL5B5UdGmL8ntpEA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2MSBTYWx0ZWRfXwGF1EAY1cisG
 jw8Zr8y+Q4rVTrbsxnTeLqDCmPUOEcqHXqTm5fJ/KgFx7qev3GIL+S4YXz0HWRqqCGlMp6O45tu
 Icbvsh1IYHVcA8fZGrg8F4n5qw4fc+tdQ9Shl4Pybj/abWsd0Uh6IiXTuiVfzKcYVsTt/+M4iQB
 f40GdKLuFS816NqoTZj4lqySHe6KIe5XGwea7JWPM+KN+VuWaeI3oGo+8E9jgNv+VCNa5ENkMPM
 NV7bxAXjl82XRl8gq3gPhMLV0aBK0Hy7kDMtegC/PbU56GprIXKZGVZMQTALf+jU4zut97a38bS
 OjpSH1KBWQbdRD09nAWUN+Gaz9UBkMmHgJkaxx4ct4MtyA32kGH5kvH+6o9IuUveJlDr1Gq8McG
 8Lujlf7Qg6u4QobGSUQHE2W7HgijC2+FKevf+8ObbxzwxTU7se+MH2b3LOaoF04hWidzlnyTugh
 O4tWtp37SkHa5tvIC6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/10/2026 18:39, Bernhard Beschow wrote:

> Am 19. Oktober 2026 12:04:54 UTC schrieb Mark Cave-Ayland <mark.caveayland@nutanix.com>:
>> This clarifies that the interrupt controller being modelled is an emulated
>> i8259 implementation, and brings the naming convention in line with the
>> in-built i8259 and KVM i8259 implementations.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> include/hw/xen/xen.h  | 2 +-
>> hw/i386/pc.c          | 2 +-
>> hw/i386/xen/xen-hvm.c | 2 +-
>> stubs/xen-hw-stub.c   | 2 +-
>> 4 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
>> index e94c6e5a31..ee4ed4f11b 100644
>> --- a/include/hw/xen/xen.h
>> +++ b/include/hw/xen/xen.h
>> @@ -42,7 +42,7 @@ void xen_intx_set_irq(void *opaque, int irq_num, int level);
>> void xen_hvm_inject_msi(uint64_t addr, uint32_t data);
>> int xen_is_pirq_msi(uint32_t msi_data);
>>
>> -qemu_irq *xen_interrupt_controller_init(void);
>> +qemu_irq *xen_i8259_init(void);
>>
>> void xen_register_framebuffer(struct MemoryRegion *mr);
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 2d8c87b0e3..dbfd55de30 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1167,7 +1167,7 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
>>      if (kvm_pic_in_kernel()) {
>>          i8259 = kvm_i8259_init(isa_bus);
>>      } else if (xen_enabled()) {
>> -        i8259 = xen_interrupt_controller_init();
>> +        i8259 = xen_i8259_init();
>>      } else {
>>          i8259 = i8259_init(isa_bus, x86_allocate_cpu_irq());
>>      }
>> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
>> index d3ce082e07..af3a90987c 100644
>> --- a/hw/i386/xen/xen-hvm.c
>> +++ b/hw/i386/xen/xen-hvm.c
>> @@ -112,7 +112,7 @@ static void xen_set_irq(void *opaque, int irq, int level)
>>      xen_set_isa_irq_level(xen_domid, irq, level);
>> }
>>
>> -qemu_irq *xen_interrupt_controller_init(void)
>> +qemu_irq *xen_i8259_init(void)
>> {
>>      return qemu_allocate_irqs(xen_set_irq, NULL, 16);
> 
> Since this function allocates 16 IRQs, the convention according to this series would be xen_i8259_pic_init(), no?

I've deliberately used the same naming here as KVM does in 
pc_i8259_create(), i.e. xen_i8259_init() to match kvm_i8259_init(). 
However ultimately it shouldn't matter as I'm planning to remove those 
*_i8259_init() functions in a future series.

> Otherwise, much appreciated clarification of the terminology.

Thanks!
> Best regards,
> Bernhard
> 
>> }
>> diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
>> index 6cf0e9a4c1..b3e27f0292 100644
>> --- a/stubs/xen-hw-stub.c
>> +++ b/stubs/xen-hw-stub.c
>> @@ -29,7 +29,7 @@ int xen_is_pirq_msi(uint32_t msi_data)
>>      return 0;
>> }
>>
>> -qemu_irq *xen_interrupt_controller_init(void)
>> +qemu_irq *xen_i8259_init(void)
>> {
>>      return NULL;
>> }


ATB,

Mark.


