Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB513C0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 16:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taHLh-0004bS-9f; Tue, 21 Jan 2025 11:43:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1taHLd-0004Wc-F0
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:43:29 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1taHLb-0002un-3Z
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:43:29 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LFDumO019389;
 Tue, 21 Jan 2025 16:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=8D+jqduj/T3EmNsZHBU6/AwOrBX7t4cyMxm+3s55a38=; b=
 F04a8kKI0PJP8V73GjVDzZ3sHc+8J9VTn7GrkYbVvXuPhH/CtcqYGAi5MSEtBv1l
 BPclTPg7vWswnt/P2iwaJLgwrIgkUF5yMiZ3lf2aOQ1Mrs0on3guPJSr8TAb2E2i
 sJuJqlzdNyxcVGVtQkvSyr6BWY58NiSwUfUeIGZQlqaVO40oqLeL7Py/Il2ylxm7
 vYpBkT3ZW1NQU2L9VrZGjkPNDXyEFBRh6KKfayzkh+vj9y6eWdh8KYBhfQJXw3lS
 paDVPuJmEWp8DcKUkbTDUkfd7kUtC7GRXw2R/njQ9odzatrDzYLj1LYOdBDzW8QO
 PZ2p7PjGNpOjFsjJ60qqrQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485rddv8d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 16:43:23 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50LFlpdl029717; Tue, 21 Jan 2025 16:43:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4491fj1g04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 16:43:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrJNrryWVzQgMxMhmj9yVQkttTTDnS8vCNc34o1PYlxUpiU/cQ4d1KxzU5vx9aenw/5iysJhrNz6btdxJycBxpXqHslGivuE7SP4Pte/VPHSJPYBnCXekw5U8MWXkJkERkAn+w4Be2E7pfVGaWJgUbkCYf1+ZmzGZWC/Pteizbjx0MMAoW2OKrEuOmc/GmC70Y66HXdSd2Ayh9Z1avNN98QokN4HrCOI3GHI+H2JrTtSGa+3Q+Rs4ekUejQcxl94CXpoypLumPKdcRxDtEu9MGR1mNNQSxR9+I0GKT9PRYDPmMiePQ1rO2hxsUSiPcSt2xeGaZ/yNIst0yl/i7Ad5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8D+jqduj/T3EmNsZHBU6/AwOrBX7t4cyMxm+3s55a38=;
 b=l8Qep/H9cV8/N0Yq2QGdyehcoIT5tgHDFS55O1bS0u7sz+kcjFWE2DRtkPe5hko2/dDDkPxXnYbL/EBnxslHTFlSC6gAYA6d0jAg3cPwNavtVxtkas9tAYJgj5OvHolK9SNvWsKcUs+7xUGyQOlmoyr6XLjNjuzR4b+JQJ+rDBPWCgDShkJd8yxrEp+pkp7VVbCE1bn9jNVU8HgacOQ/ucGDkc3eOqt4KCRMPtgk7adj63Gkiwnlrh+1IJrjgxhN2Mam2fHRCEcVyh/rrL1M9ahcriesrOI+HPj7OaZnmZXKdxaLS/v7alY3W9Cs2nojaEIhb/7l3w1ezDETRG5meA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8D+jqduj/T3EmNsZHBU6/AwOrBX7t4cyMxm+3s55a38=;
 b=pi4LSd7uhi3Q7UVhSray4x822cPdmMns7uBIZy3Q6MQcYd3+pVn+IJJ/veMWs++fztQcZM+MwPpKAt72jC2b+/mgn/Ir1sfzX5RJYCpMnlzKcBxuANflCpeYQt9KyTSH3WD1s0Jfa2IQg/6SVxzB3MYjxv7n77/3c5tT9Cy+dKg=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by MW4PR10MB5881.namprd10.prod.outlook.com (2603:10b6:303:18e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 16:42:58 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 16:42:58 +0000
Message-ID: <62d4bffa-a912-48b4-9a7c-b16b21bffb7a@oracle.com>
Date: Tue, 21 Jan 2025 16:42:46 +0000
Subject: Re: [PATCH v4 00/15] vfio: VFIO migration support with vIOMMU
To: Zhangfei Gao <zhangfei.gao@gmail.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <CAMj5Bki73PNZdZvNAsK1YJiWGMeZugQCZ18QPekCM5EN61QqBg@mail.gmail.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <CAMj5Bki73PNZdZvNAsK1YJiWGMeZugQCZ18QPekCM5EN61QqBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0124.eurprd04.prod.outlook.com
 (2603:10a6:208:55::29) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|MW4PR10MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb687aa-11e0-41f9-57b0-08dd3a3aa948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXVBakUyMWovd0tBZDFvNWNiRmRpaXE0L2Z1TUFNWld5cXNra0oyMitDdVRK?=
 =?utf-8?B?YU1UaWlKZmt4djVJdERaN0ZrK1FLRUtIcGZwZ3MyOGhqMUsvL25ldTJML0dR?=
 =?utf-8?B?em0rbGQ3dGdUTk8xclVLQ1BScjMyLzBtMGdndjdCa04rYWI4aUhRZmMvWUNi?=
 =?utf-8?B?a0lXQXByanczL0trTVJZMlBzNkU4WDdwTGtIUnVxaG55d1RkMThOTHllcWdh?=
 =?utf-8?B?clR0MkZvVXFSRm5SRy9VL2xjQk5HUGtyUCs3WHRUQVUwV3M5LzFGQzZUbmF0?=
 =?utf-8?B?azdVUUdUbGRkcDJXSTI3T2pRSFU0MGMrUStOOHJkUXYyTzA1Rk9uK0VLOWxx?=
 =?utf-8?B?RkNYcjcxZXVrR0VlK3h0S3JPQmJibkdtYVJxWSsxT2xUSGtMNHJwV1pQYlBq?=
 =?utf-8?B?eEUwQ2dQTzdDWHJsb1Yzd2FaOUxvT2JadStPMjdEbGxiVXJZWHQreTlobThW?=
 =?utf-8?B?dUVVL0lWWnRPMW1ZK0NqYmhtckZJallISU1uY1UySE01Mkh5VjdFNGtRMU5s?=
 =?utf-8?B?eFRIY0pZMm5qd0VlcFl0ZjFKeFZ1cWRjb20zYVZ1SnJXeXhUdDduWUNlazVD?=
 =?utf-8?B?V1dacUl1Y0llT1R6TCtBTi9CSEhoVUwwSkduRDk1ZU5XaGZiV1JxSngxWjFZ?=
 =?utf-8?B?WU1HSCswSGJJbFVZUW4xdjRVcDVJdm5vU3IvUjVGVGRBN21yNXNzbkFOaWg4?=
 =?utf-8?B?RGYwK0NBWXQ0SVBBWTZ1UVI1VWxIdTR3dTQzZlpIZTEwS0VSU3FETERleUtz?=
 =?utf-8?B?SzFyZC9NRTdxZExTZ2l0ejZQdkk0T1hiUFhoUE8zbURXRyswcDZJUkxKUFBx?=
 =?utf-8?B?UmpRcGVMeFVWM3hhRENMdVowdGt3b1QxM2tHd1lmNnFmK3RyR1dHTFRSamJy?=
 =?utf-8?B?V1Noaitwdnl5YlEyRVV3azJIU3hzNnBFZ3o4V0dyZWgreUdkYUVHYk1KZUtj?=
 =?utf-8?B?VDl2TmpqSXB2Z0l6Q3lhcXdNMnBGYklrVGFxYURtUThXaWFEcXp1MDkvTTh2?=
 =?utf-8?B?ZWFXYW9BYWhEMG9HRktrSUYxZzhEVnR2OEgvcTAxVmxkSXl1SU0rcm0zWHlO?=
 =?utf-8?B?ci9TczFkVzdua3lDNVUzT1BvMzMwZU1zMDF5Qjl4SlZJbzVrVytzSTJTTWlJ?=
 =?utf-8?B?RTVSZVV1TjNucy9uQS85SEVGTjZ3SnB4RkNZbkZZeVhCQmhvS1BONTVLTWlG?=
 =?utf-8?B?THBkM2VFS0NZQ05wS3JNWS9SZFhya2ZKc3pId2kzL2k5RXdlSTJIMk5TVE8r?=
 =?utf-8?B?c04xNHVzcmJrYmU2dDltVnpSOENkV0NGVFQ0b3JycFEwUlVvTEVkQlQzcDRP?=
 =?utf-8?B?UlBLUi9xVk93UTIzNTk2eTBSUDQxQWowdVpEWk93bCtNU21nWTFkU01RbjVz?=
 =?utf-8?B?ZjV6dUszMjRBWlpjY1dsSXlYdVZkL2FKL29oK1lUUGNTU0hCb2g3eGVtRjlK?=
 =?utf-8?B?N1MvU0liSkFDMUhVZ0V6NjhNSk9WWUdWTThmcmZVYU1lZ21rcUwwS1lOamdz?=
 =?utf-8?B?VEo5Ukw1Z25PblEzRnUrUWJFMnA4NldpVUJNTzBOVTFmS0FUT0tEZDZMTkZV?=
 =?utf-8?B?TGsyeGFkNjlGenI4OUNSUXlkZFN0R0NjUkNVWFBGQjhnSnJMYkFzRHUxd2NH?=
 =?utf-8?B?RFgvc1hkclhnSUZsWGJMcGowcTRnWjBwTEd1Zmw2UGVtYzBDQVdoVHA2Ri9q?=
 =?utf-8?B?bFFpWXpJWkxpa0hIdFhPVTNnOEFZOEM3M29xNGVhQjFaOENLV1NLMnc4TGVC?=
 =?utf-8?B?MUtWcVlTMFA3aENQMnQ4VVVIS1NDUDlJb2s5cnArbi9JZDZZUUJtcnFPRFJz?=
 =?utf-8?B?ZXJySHg4NktCazB6NWZXWGNYeThmY2VxQ0I2MFAwc3NGTVgyMUg4a1RibGd5?=
 =?utf-8?Q?SyN+SKOlbEppW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1c4eXBMQlVubHhzSm1OMUg3dmFWam13RGZFaGRUdEo3V0xLL2duT1VkMFJH?=
 =?utf-8?B?MVpyQVFmVFFZNXAvb1ZMa2dYYW8zQVJ1ejAzYzYrZWkyWkVBVGwyVGdKZURm?=
 =?utf-8?B?L0NmVTEvSFVYdVZzczdYUXpSVUZzeWZsa3Vqa1BKNnF6S1o1ZmE4RzZpNkhS?=
 =?utf-8?B?bUJZeVRONUNUd01MUFEzb1FLQ0ZpQU1OeWpRMENQQVZwcDRRaFRTNmhPaWtK?=
 =?utf-8?B?UWtEUDNLVTJWU09YOVBQN29ORXN6cWg3QjVIZXFXdVN3WXF1OWtXRTE0TDE5?=
 =?utf-8?B?MzFaTHJFK0xsZnZCZ2FucUZ4eE5TTnpjSDhwSXFZNUptQzhGUDUrTXpOU0pv?=
 =?utf-8?B?SWMxQTFwOHBkY3ZvbnA3S0tqRlhudUZybmhtdmhaYUcwTEdRQ2tmWFlZWlVH?=
 =?utf-8?B?Mk9nN1RmRnJMdzFmZ1JIQXptc21VNHNaSXZCZ0U0aE5YT2phd1YzWE5JWVpD?=
 =?utf-8?B?VHdXWnRLTXRXS0E0S1MrZi9JN2pnVUpVWlFvWEJKbW9HbGxLN2JYajQ1UkNl?=
 =?utf-8?B?Y3pOK2NCZnB5bkxBVHlVSzVlUWZuTlN4cG1PcklMdWswMzVZd3A2dDdPZUtI?=
 =?utf-8?B?V3FNYlZDbStzMEZSTGp2anhMZ2EwK010T0l1dWdFQ0FXbUszY05CVzBSQjR6?=
 =?utf-8?B?Q2dVajJncWhmSXFJZWd6ekpoenk3ejVzcnBBUTJzVGNoTU96VVZiald3Mzg5?=
 =?utf-8?B?WEc2VnNCQkJjRDNxUnRnNlNPSmUyL28xUmtFZE1FcFFkemNZMDN6dHRhZm9F?=
 =?utf-8?B?N25DbjZoYVkvd2U2d01VeHlmNWpYbmVNa0YxcjV4VlplaVVHQnc1VjB0NUFR?=
 =?utf-8?B?Y1NHRGVqeHE4VWRjaTRkRm5DSEgydHUwUjFLdlJkSlBIMXZ5dGtVdlRwV2pN?=
 =?utf-8?B?dDFKNHJKODh3Q3A2UXo2Q0YzN3o0K21nWlBJbkF1OEdPTHljcy92ak5uSHh6?=
 =?utf-8?B?SFNpN2hkeFJWaEhGV3JVL3Fnc3BQcmJ4citXcXpEUk9zOGZ6dFRIS0hvb0JC?=
 =?utf-8?B?YUhLMm1pTnRSWnVpVXBwWXc2M0t6UGFFRGpQNmVOd1N6aFBGOHVvWmo3TXBD?=
 =?utf-8?B?RkZYWlgyV3Rxb2Yxc241QStScGZGRXNyOGE5VTBCbDRnd2F2VXZNM3JHM2Ra?=
 =?utf-8?B?RkNhMW9ZSXZVVXhwRENiaFNBZXJFcndkRjVCR2ZOUENjNHNpOWVVTUxScEdy?=
 =?utf-8?B?M1ZHV3dZcTNlcnU0V1J4RkZDaEdSdERuZTZDRTJFWG5lRDRGZ0VPaDVPRm9V?=
 =?utf-8?B?Y3ZkUnlJT09GRmg0dHhVbzVNbmRCTFI4OGY5Njl2d3ZuUnU3VmhZOGpFUzho?=
 =?utf-8?B?ZUs1bjFDc1RNM3RLTnFSWHdMUzRYRktFaVI2Sjd6RzR5ZWdHcGh2Z3Evelh3?=
 =?utf-8?B?M3pTd1B6Y0k4QkRydmJ1NjVDbmNSaVY1cHhQVFVCdXRxMkJTdEtyV25HT1FD?=
 =?utf-8?B?OHczd0ZNSFVPeWdsengxVHRJMEpPSFVaUzdKWWlJTnowbElZaDVKK3RBMHdZ?=
 =?utf-8?B?dHBGY1VGN1JVZk9MczEzaE1Ld0o2R0ZxWUVCeXdRd09oN09lV1VXaFFkbWRp?=
 =?utf-8?B?clAvUmxzNGZSRTBWVVVEMmtnL2RlNmJHcFZ1aEdUMzZDdGxBWTFaL1dDZm82?=
 =?utf-8?B?ZDZYTkNLUVpGK1Jteit4cmFaemNQbjlGWGpnc1dJeGs0SndKbnhLYy9JSkNr?=
 =?utf-8?B?aDUybGVLN0NHck5ydlZPY1pnUi9YeEpyRS9SY2szaDh0bWJUSEJJdTE4VWcz?=
 =?utf-8?B?RDkyenpsZlBaTUgxUDR0VHpWV1ExMkppN0lIbWJQQW9sVVorM3J6d2wyYTQ3?=
 =?utf-8?B?dDR2bzBvTnp0VTZNWUFSN3pnQUd5NllXTlNGM2JQRDIvTXdCVDk0UXVsV3Vk?=
 =?utf-8?B?aGc2QU1ZMEVlV1JtOUJ2cnJIY2FEVmNVa0tqM0VWeUdUS1RnYkU4Yitqd3oy?=
 =?utf-8?B?RG9MYnd0Zjk0dmtXYkk2YWpGSjRZdXJvRHdtSm1TMDhXbVlpUUxIbWpwUWp5?=
 =?utf-8?B?TkIvdUZTL21iSlVnZ29JYnkyd0dHVVY2QmowSzkyQjVjTlJWSTVZckRRZ253?=
 =?utf-8?B?NlBIWXFwMTVlUDlDZDBVZTc5RXNWNUNPaGZ1M24yN3oydXBWeE9qdUZnN1RL?=
 =?utf-8?B?VkRYbzBlOVlTbGhXYnRxZ21CbU4vT01IeWU2bENZL0hnNUN0b3BBSTJMNDY2?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4HfH2yvLJNIlZ6k+JaY6dlHSoqpsmyUjYqBdjneSDspT1P0rgkQUqauRqjLG+CHtgKQOL8TaMBaSGvQttJ4Mid/3M//mjX8BZV7wjX5pR8Y0eP9PCJl8TSt0yQjsBxGlhCtzXI003PqHrjoKi5PBtFWIOtLDQdks0x9KtLUMqff9k4cN5mDJxp7Ii1j1ti5PxMHm47J0qlm/mRBSEsy51k8mg6XGFIUslMyVKbt/XTBiH6R5Q5uZj3j2Vld3UAUwTh+JyZo+HalpbG2gxnY8UTe9+GDjZ0WvX8vcA9df5MFmyi+9GPbql9PWNmbzOLdVSFZWeGsqsgfjObCbdyV3X6zK8WYWa1KG1Q7eIc1Zvr9H/2VXU0s9b2mn3UxAZvbNUcB4waHWoCc4QWzhA6WT5Z1DSbWOa/adwhD2qs2tZxrujcc9gS+LW4j2gfXcbOs0TuIrreASmgrePDb3Jl80e0avrAFHOJClJMCTocv0IkhIPBblHQflEQ7oPwy2BlfT207LJTNZTGHOPWSNIyFCCzcMKavrSqgI8FPjHvLBj9Ybgig9gRTRTuH2DZ01ziHMOrzNE5w3dt0weSl25Sh7gQ4iOyN6kyTuO+GM01YpXhE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb687aa-11e0-41f9-57b0-08dd3a3aa948
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 16:42:58.1992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrRWAzbkqigIvEKYVk+B5SYZXtQvnM4il3RCImpw+El6OPW+ikXYBYM3paJy/lda+fXjsr6Trle4wD+VNHbyBf7bjwzcV++BE/VR6or2eJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5881
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_07,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501210136
X-Proofpoint-ORIG-GUID: HLbf9dC0Wb2MNGMBTCg0ON8VtHjBXOM0
X-Proofpoint-GUID: HLbf9dC0Wb2MNGMBTCg0ON8VtHjBXOM0
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 07/01/2025 06:55, Zhangfei Gao wrote:
> Hi, Joao
> 
> On Fri, Jun 23, 2023 at 5:51 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> Hey,
>>
>> This series introduces support for vIOMMU with VFIO device migration,
>> particurlarly related to how we do the dirty page tracking.
>>
>> Today vIOMMUs serve two purposes: 1) enable interrupt remaping 2)
>> provide dma translation services for guests to provide some form of
>> guest kernel managed DMA e.g. for nested virt based usage; (1) is specially
>> required for big VMs with VFs with more than 255 vcpus. We tackle both
>> and remove the migration blocker when vIOMMU is present provided the
>> conditions are met. I have both use-cases here in one series, but I am happy
>> to tackle them in separate series.
>>
>> As I found out we don't necessarily need to expose the whole vIOMMU
>> functionality in order to just support interrupt remapping. x86 IOMMUs
>> on Windows Server 2018[2] and Linux >=5.10, with qemu 7.1+ (or really
>> Linux guests with commit c40aaaac10 and since qemu commit 8646d9c773d8)
>> can instantiate a IOMMU just for interrupt remapping without needing to
>> be advertised/support DMA translation. AMD IOMMU in theory can provide
>> the same, but Linux doesn't quite support the IR-only part there yet,
>> only intel-iommu.
>>
>> The series is organized as following:
>>
>> Patches 1-5: Today we can't gather vIOMMU details before the guest
>> establishes their first DMA mapping via the vIOMMU. So these first four
>> patches add a way for vIOMMUs to be asked of their properties at start
>> of day. I choose the least churn possible way for now (as opposed to a
>> treewide conversion) and allow easy conversion a posteriori. As
>> suggested by Peter Xu[7], I have ressurected Yi's patches[5][6] which
>> allows us to fetch PCI backing vIOMMU attributes, without necessarily
>> tieing the caller (VFIO or anyone else) to an IOMMU MR like I
>> was doing in v3.
>>
>> Patches 6-8: Handle configs with vIOMMU interrupt remapping but without
>> DMA translation allowed. Today the 'dma-translation' attribute is
>> x86-iommu only, but the way this series is structured nothing stops from
>> other vIOMMUs supporting it too as long as they use
>> pci_setup_iommu_ops() and the necessary IOMMU MR get_attr attributes
>> are handled. The blocker is thus relaxed when vIOMMUs are able to toggle
>> the toggle/report DMA_TRANSLATION attribute. With the patches up to this set,
>> we've then tackled item (1) of the second paragraph.
> 
> Not understanding how to handle the device page table.
> 
> Does this mean after live-migration, the page table built by vIOMMU
> will be re-build in the target guest via pci_setup_iommu_ops?

AFAIU It is supposed to be done post loading the vIOMMU vmstate when enabling
the vIOMMU related MRs. And when walking the different 'emulated' address spaces
 it will replay all mappings (and skip non-present parts of the address space).

The trick in making this work largelly depends on individual vIOMMU
implementation (and this emulated vIOMMU stuff shouldn't be confused with IOMMU
nesting btw!). In intel case (and AMD will be similar) the root table pointer
that's part of the vmstate has all the device pagetables, which is just guest
memory that gets migrated over and enough to resolve VT-d/IVRS page walks.

The somewhat hard to follow part is that when it replays it walks all the whole
DMAR memory region and only notifies IOMMU MR listeners if there's a present PTE
or skip it. So at the end of the enabling of MRs the IOTLB gets reconstructed.
Though you would have to try to understand the flow with the vIOMMU you are using.

The replay in intel-iommu is triggered more or less this stack trace for a
present PTE:

vfio_iommu_map_notify
memory_region_notify_iommu_one
vtd_replay_hook
vtd_page_walk_one
vtd_page_walk_level
vtd_page_walk_level
vtd_page_walk_level
vtd_page_walk
vtd_iommu_replay
memory_region_iommu_replay
vfio_listener_region_add
address_space_update_topology_pass
address_space_set_flatview
memory_region_transaction_commit
vtd_switch_address_space
vtd_switch_address_space_all
vtd_post_load
vmstate_load_state
vmstate_load
qemu_loadvm_section_start_full
qemu_loadvm_state_main
qemu_loadvm_state
process_incoming_migration_co

