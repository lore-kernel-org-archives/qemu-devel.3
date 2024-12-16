Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47761E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAfO-0004no-KM; Mon, 16 Dec 2024 07:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNAf9-0004gM-Mh
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:57:28 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNAf8-0005Ox-0a
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:57:27 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9MsNj020634;
 Mon, 16 Dec 2024 12:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=D1JIV7lfb+CLMnleWL78DCQ/jHcwJ1kumGvPP7qW6DU=; b=
 NjMSeFqsPBlNzcNmaZ6elBy1nKZ/IwVNXyd2fNz/bb3LsqQcbFl8OrnqN07K2jC3
 UkPwCkdDvyZTkpprWYmgW94eIjngsjFwYE+PhOAP9iwubcpO0BKKQp60vXEWJk7v
 bOiR3vnGnSHLBwq5hPy1DQcKMqPfR2crg7Yi4cLreSjN4VkrFgmKW6Wg+DvBwVss
 DIO3o1uJgYvc8uoSXO5PzgU/oiNB9d300zHXQjsboOGXK9otKUAEAZ+M6r/B+Uec
 YfNxSNbCaYVvMIfCmdTbLBe4Vbxi7aQOvjN1cCbyv86pOyHMdxJuwfXnFBSJkXFd
 ZICx3th+NprKrLWT+/N9PQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0xau5y9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 12:57:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BGChJQm006502; Mon, 16 Dec 2024 12:57:23 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0f7yfma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 12:57:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IR/BsJ51MSYaPrX9Z21vlcpfq7pb7kKsclyFGvy1jWsai5e2A4zcZxQvdazVXLUxOeGqm4WQFnLf5ZYRDURhrruBPBpkNnsz2vEHlhHqItcAc7DDt3omAfrQxLa+DWhsqbJJquvJooRia9AesxpoSLN+SW4lbz4Jo5mvDURAdi5AQaxlc1shFZE4pa8rxWkWrcxisGfNDh7ON+SoXgEUt6olvfCqxC8kr84sw5GIBCWfYmDy0wthtRz0fht5VhxhZX4yjxfdvkTsgfcRJuZRXLc/irzojUw1OjhlMxle6937e2RkdweplLysIpOFLfSPPwOelZs3Vof3Xkdk0aV2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1JIV7lfb+CLMnleWL78DCQ/jHcwJ1kumGvPP7qW6DU=;
 b=wWiSE6Ej2/ToTndlVYsjcMCBvDgb39mExiY0P+iIWcirn5Pdi1bLtekWsqyw/nN6E8BxLkLjgfGBOD+MZiBGQ+vK6zwS7//7BzG76om5qwE9cGyDzZ9wdVmQWJqkT29lUyYE69cVE/rabOANPSsBfTdJdwtI2ANYJNqDm74j0su9XACF9ZzM+DWBjHVyOVF03WEIuxWwQlZPxSfSrWWanOg/qLiNOD+rE1hR5/l2waRxo+FkvrZYm121R89jDUoSB9r+tgOauIQImj4s4CaTPZJcwpW/qzDFQqik7u6qhhZ1C0owEKT/+0Y1n2CylVam/TnTREp0L7WEeE4yxBuVxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1JIV7lfb+CLMnleWL78DCQ/jHcwJ1kumGvPP7qW6DU=;
 b=nlFAPr3dLRmdDdtMLSzGRCtE84XyRIyyQ+v7bAarhusIRrWb7zlaci2vRO03jSYKG0C5DMm+X3UMFjZ7LD2LM8ms4cfnhC0VT15TcCtY+mS79oIOUde9gjkK9ivJW0mY+9sfanlj5xu+bCnMAkbK1vEBFOGg3M4QVAyqOK5hMDQ=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH8PR10MB6411.namprd10.prod.outlook.com (2603:10b6:510:1c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 12:57:21 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 12:57:21 +0000
Message-ID: <34bd8988-b9be-48fd-82bc-fab465f67f79@oracle.com>
Date: Mon, 16 Dec 2024 12:57:12 +0000
Subject: Re: [PATCH 5/9] vfio/migration: Drop
 vfio_dma_unmap_dirty_sync_needed()
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-6-avihaih@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20241216094638.26406-6-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0217.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::13) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH8PR10MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 1525675a-062e-4de2-a0e4-08dd1dd12dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clFLLzhJRXJxd0FId3pPWmZOeFZ5c2RmaStoNC92WjZ3S05yNTZKRTR4RlhS?=
 =?utf-8?B?Z28vcEZFeHBYSXBMN05Ydm1mVlhFME02d0c2a0ZuVVpiOEFUVGFPRklhY1NT?=
 =?utf-8?B?NVV1b3lYRVhXQnVRRkZRU3B1NU9PVFVrSEE5eFR1Z0lIcVhpWEpUR1pUcmRL?=
 =?utf-8?B?R2d2YjhjMEp5VGcySFRKWkFYMlM0YmV4MTI3Q0p1UDlPWmtzYUwyTFJZYWt3?=
 =?utf-8?B?cFNuT01QdVB6d2l2UFdrNGJzVCtMNzBBOGcxWm1wb0xOS0NrUDNNQVlHbUNu?=
 =?utf-8?B?YnB1ZHRGMTdzRWE5TVBQZDNVamR6N2hoVWZPbTlMN28vajlPK0VyZXBwQWZr?=
 =?utf-8?B?d0t4VXUvOG51MlRmU09FRS9Fb3FSUTlDV1pVbDVuMkczZXl5TGhvaGFYUHNo?=
 =?utf-8?B?QTlJSFd2WHpOdUF3QVZOcVNOMUF6WVBmaStidk1EaEdDMnArSytOQ2p3aFlW?=
 =?utf-8?B?M25rMVR2SGkyT0tabHJvWkQyTkdVWkJDMjY0OC95ck9TK0h0NXR1TkpPN3JM?=
 =?utf-8?B?eitrbldkUVIyaFhRTEZpMGJ1TjdDNkR1SEpqRjVCLzdTSEZ0UEVCdEZxMUds?=
 =?utf-8?B?eEdnOFlYUjFTNEpJM0xiR1VXNXA0WDZ1cmVlUWp5U1BzcXNCMlNGTDVpc3B3?=
 =?utf-8?B?RTVOdEdMekpvenBqZll0QjNsNUdGTHkyU3ZiNWNjUzd3VzNIbkNBK2hmK2lT?=
 =?utf-8?B?emVXOXBnME11azQvOVRTbmdJUFNMVlRnUmlFcThpcTE2SGQrckV1eFNYcEh2?=
 =?utf-8?B?U2lMYlJnejhDMnRyRHFTSUdMQmJNWko2enpiV3Q4N2RJOFhvZFRPMXFpcUxi?=
 =?utf-8?B?dTE5dkZ2T0YzUGdjUmdSU2xwSTdaM292VU9sdDMwaGZ4cDJtUmovSUx0R0Iy?=
 =?utf-8?B?YnZRS0tvcXV4N2llTzB4Nm40WjhXYnlFYm9jSDRLZUgrL0diMThwTXVVck1X?=
 =?utf-8?B?Myt4MkdHaTVRNVBXdTNEN2VLaU9CcWRDYVI0aTJ1VXVxV2tQcUs2dHdlcU1v?=
 =?utf-8?B?SnlOOXBFOFF2WEdwdEZGWVVsaEE3R3llNytNMUgyUm9mSDlhaEJwMDFZQUpx?=
 =?utf-8?B?cWo1cDVpOGIyUG85aHJRWEF3UmJjWTdVakl4Z1ZKWWorUG0xbmRlbWVoNjVq?=
 =?utf-8?B?RTJscEZFdFh5N1NqUS9VYmhvb2xzYmpzT0lGTitiWG1EVTdVL3BERnpwT3RV?=
 =?utf-8?B?L0x3M1pNcEg3SFpuSEw1RnpjRjNKbTRqNXNnNGNhaWVUUWtoMlNkOXU5a3JY?=
 =?utf-8?B?Uzk1R1gzMjZmOEtFUzRaOTFWQkZ6SG0vMmNIQ1hTdFZlN1VTdlhTVXN2NjF0?=
 =?utf-8?B?bGdTK3E5ZVVGbGpYSEt3QzI1RkRiNWpEQ0NnKzJpZnJMcjEyYzRUY0lVL0Fk?=
 =?utf-8?B?N1psaHV2RmdTajkrSXBjMzdVZzJWNjAxNUoxYzhTc0Y2MHphNEV4TzJieDkw?=
 =?utf-8?B?bHZhaVg5Z2MyeGFoVEJIUzNKRG9LcjJZYVZTbmlFWEt3WHpPZ3prKzBGV1N4?=
 =?utf-8?B?d05YQ29vdEdMUDRwVFZ2MHJCRFVCZWJGVXhJWUowYUxUQnVRbVJGZDBaSFNw?=
 =?utf-8?B?VDVhUDc4UnYrUWpXZlBiR1ZUN0RvTFBvZk5HeTkrZkk0Z0NUMWVRMTlYUUdj?=
 =?utf-8?B?SUIvNFZNTzRxUlE3aU50WStEMVNrVDRsMDhFSkNxdHhXYk9iUStyenZ5S2E2?=
 =?utf-8?B?SVhQN1k4OThzbFFWalB4QjNSQUlQM0ovRnMreVRUTHhIZ1A2eElNUDQrWXRo?=
 =?utf-8?B?aEFBcUUzVWdPdHVkVW5KRktuUExPUUYxUFlhQUNkMk1rK1l5Uk1GL1dSOHl5?=
 =?utf-8?B?SW96M21NbU9IWkp4cDF6dzhGYjU3UE1Sd1d0M1FCS21qZWEybXA5Wk9OTXdl?=
 =?utf-8?Q?GXiWzEUs8H9Ma?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXBzd0c2Q05SOG4vZHMwdlNoM3ZuUWtZeTZBZkQ2RUFScnZDL3FPMEw3Y3p3?=
 =?utf-8?B?L3lzTDY2Z2dTRFVjaENxUnVqZEpPWGdHOGdxNjFkQnJQVld2bmlxQ2RjaEtp?=
 =?utf-8?B?dkp1ZFJuVzZkcm9NcXZ4MUlHSmFCbFhxZHozS2J4UFJIZjdSUENMYkV5aUxG?=
 =?utf-8?B?TGpYdXNuUVk0SnB6d1NHdmR3Und2RUZISXpYZmozTkIvZzZaOGwzdlcrVjMr?=
 =?utf-8?B?alhxemY3ajNpdW9tVlNPanBmK09MQU1vWGdhbGhrTjlOeVhIUkRMVEdaM1VH?=
 =?utf-8?B?ckc0cmNibmpuOEZDdXlSZHVLNjZuZGRPeStBUnRvblJkUkxjMEd4QmMrdnNP?=
 =?utf-8?B?RFpjMklRL2lONGRIYUdYVFk2SnRlbDNsYWZBa2VRVkNvbmtSaU1MWDRjQUpV?=
 =?utf-8?B?eElSK1lwN3E2WEVscGJIeVA4NFBaTlVFS2M4MFpRS2h4RFN5aWh4KzByR3NL?=
 =?utf-8?B?ZTZIRUFISFFFQzBLZjBrVGtmWjdsR2tHczYrMVRaeWRMa0ovQjF5QkpkVE4w?=
 =?utf-8?B?ckgwa0pUczViaXg5N20xT0xMa1ZOM1pVZFJTT0ErcmpqVEtIRG9JQ3h5aFU4?=
 =?utf-8?B?REppd1J3RjE3Y0FOczhsNHh2cXY3cGtyaTdGZFBWZDdSRjBpVTBlYnY4b0Nm?=
 =?utf-8?B?dzdVMXh2UThMdG94aTlDOHJZcG9CQm82MU5kcXE0ZWJVbUVFb2F1bU5SOWN1?=
 =?utf-8?B?N0RZZnNWZC9odnFpby9BNnF4a1ZOeHZvS05ISHJ3dXlkWlV2bm1NMnhsS2dR?=
 =?utf-8?B?UjVpdHNQVTdrQlA5SU5rZDdOMUF6R1BPR2pmSk5OVnRoU2xVSGx3U01HTktt?=
 =?utf-8?B?MFV5eW1hQXdGMFA2VE5uKzdmY3FFbHhZT0YzMW5zbGxtallXNmNidTZxaEVh?=
 =?utf-8?B?TkpReE1UNjJYWWpseVI3NWZDZURZNVorb2RESmV5M2lHSDZsU2xRaVBNSytD?=
 =?utf-8?B?V0NXVkxSNkdrTXM5MzI3cklOOUcwTk5IdEFEaEthRlA4ZXZGQ2c1QmdBV05z?=
 =?utf-8?B?YWxtTjRoaTI1Zm1KcERQQmNqc3FXUWNwRzBEZzkzcmtab2Y2TmZoRHl4WTN6?=
 =?utf-8?B?SzlzaFBDK3I3TXZIcGk0djREbytZK3dCVlBPVVZMYWp4RXBra0ZhTHo1UDVh?=
 =?utf-8?B?TDNzSThUMnV5Z3ZwR2ZTWHRkb3lZUXJ0dnBGZzV4UDlOTEh6TXJEZys1Wktq?=
 =?utf-8?B?SnF6czB0engyOGFiZWhsdkY0MGdaU1FVaHNtbnJjb3A5MHBYbXVyRjlGSCtZ?=
 =?utf-8?B?ajVadjFBVTlUR2dqNmFlSkNUQnFzUTVhYXpYR1ZEMFFiNGg5dXB1UjJYQmhF?=
 =?utf-8?B?MGxiSGNrVUh5Vmk3YnFDY0ZEU3gyaDdPTGRMbTNNOVBkMi9qQStXa0xKQnlk?=
 =?utf-8?B?V1BTamw5cXE0RFk2VURHeFkyNVl5TzBkUkFmZFJSMzI1emFzTzk1R3R5Rkla?=
 =?utf-8?B?bmRLRzJpMm5uejVhQUNzVUhtYnJGdDVpNmVBQ1d5d0hVMGZidzFMeW9pekM5?=
 =?utf-8?B?VnVndGsxYTdkcE5UM01jRmhwRXlRbmJaZ3QvbzFvQlU1NTNYbE44clVteHdQ?=
 =?utf-8?B?eXNGS1A5QnJDb1NGMkhhcEdXRmRZNkRCMlUrVzIycS9CWFFhUEFYSkUxRnkv?=
 =?utf-8?B?bTNpSFhyNHdBWDlNcW1zV1RJWUh3TDZiTUVMeDlBZzFlN1NucWt4KzVlTU9x?=
 =?utf-8?B?WXhONG5aWnhsazN1eXI1WFZ6NzlnWXFsUElSVUF2MTdVOFQvT1BlZ1Nob2NG?=
 =?utf-8?B?bGFTUWRSc1J3MDk1dlluaWZrZmpFUVgydGh0RnR2T0RLTVdKdWhyV2h0YlpV?=
 =?utf-8?B?aytwSDlOWUJyWTM2ZUxoNGwyYkJlSnFrQlBSVDdTSG9SZmFRUEFxRFNMOUFt?=
 =?utf-8?B?eFVieGlyb3U1WnBERGtyTXBKdXNhTldldGlEQWJMOG43ME9UVlBSSEs0UkZF?=
 =?utf-8?B?Y3pFVHlwbFpMNTFDTm9NY2FiUTlSZnpJN1E0Nng1Q0RvQjBNU0hHdnh5WnZE?=
 =?utf-8?B?QlBpNmdZTWFKRVowekF5c3F5SjVNSTVYaUIrMHFxR3NPVWF4YjV2S3pmVXZt?=
 =?utf-8?B?bWovTnJESC9VR1RORkdqSmNzeFZXV20vZk5QWm02SXcybWZudEk1U3p6alRT?=
 =?utf-8?B?UUgydklYbEdEWUp2N0srSG80amRYZnlIZm9QOEhpemh1L1o3R3FNY2l6Y3dT?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: W65B29KVA1UUxsImZznWUVmDVdJQG94COfP2mBxxaENTPxCb3FevVqxhTlY3F1kwcXl4OF9GIDvrFOdrJIjTsqB6xY9ybip+q7aQ5rJ5JeVKdRJ6R+QQKHsNwcdbKkVJd5wJYZ8ZFOxwLNY7KEyyq58KMLz8iLNqBgMS8pGUvAxK1tysNIJ+eVSA/nVVq9Z6na8tpWQn3ywm3sgX3mEKO0LsJr8iQXMMYraGOfZTcHbLR+NN4nm2qt4248+hEEt3X4J0p+e1lea7UrMkRLqkQ9N71zLp33BGIi9zhIVPDfIh1RKZoBYTkjgqbRl5bvwTqbxwL4yqm8HeZSeDfeEhmdZihYT0TRAjJwEgxtUgeotZP1L+Z+yqFPaMLyNKI3DoDcAhl9JLxPWoTnD0UaVnl9keWsBaVLcHSQQgRFxB9dUl7UT9o6SdrJmlDS/5LJFgLa0Qf23DmyXQCpHvsw2/yscjjkV8XXDtlUVL4Qcy96XRgr9ch6WpGpko1mPtAXACbaw6KFSECHOf+dCm4+njAsq53HeHaFXM2gGBbvpzfQwqNQC3FE7Vf0wu22reGl3+2X4RpFyNzkv06toyBC/QAOBNebwpKCn2HA9seSUAWmQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1525675a-062e-4de2-a0e4-08dd1dd12dd5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 12:57:21.3675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCLPXfpihJDoDmOgWxVQxt0gvGqNx8SMSZtbHcQmy2aN8fjCMjMn5cr9y7mQIRnAnk2vzXpSY+oOgukIQdcH9Z22VmV/+gSgdMn8Ufszkpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_04,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412160109
X-Proofpoint-GUID: evFK0Ifq3TkBU8jxMx46DpmfcNVDK85E
X-Proofpoint-ORIG-GUID: evFK0Ifq3TkBU8jxMx46DpmfcNVDK85E
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.13,
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

On 16/12/2024 09:46, Avihai Horon wrote:
> There is no need for vfio_dma_unmap_dirty_sync_needed(), as it simply
> calls vfio_devices_all_dirty_tracking_started().
> 
> Drop vfio_dma_unmap_dirty_sync_needed(), export
> vfio_devices_all_dirty_tracking_started() and use it instead.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>  include/hw/vfio/vfio-common.h | 3 ++-
>  hw/vfio/common.c              | 9 ++-------
>  hw/vfio/container.c           | 2 +-
>  3 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index c23ca34871..c5aa606890 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -296,7 +296,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>  void vfio_migration_exit(VFIODevice *vbasedev);
>  
>  int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
> -bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer);
> +bool vfio_devices_all_dirty_tracking_started(
> +    const VFIOContainerBase *bcontainer);
>  bool
>  vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
>  int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 45783982c9..6e4654218a 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -184,8 +184,8 @@ static bool vfio_devices_all_device_dirty_tracking_started(
>      return true;
>  }
>  
> -static bool
> -vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer)
> +bool vfio_devices_all_dirty_tracking_started(
> +    const VFIOContainerBase *bcontainer)
>  {
>      if (!migration_is_running()) {
>          return false;
> @@ -235,11 +235,6 @@ bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
>      return true;
>  }
>  
> -bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer)
> -{
> -    return vfio_devices_all_dirty_tracking_started(bcontainer);
> -}
> -

Why not just renaming vfio_dma_unmap_dirty_sync_needed to
vfio_devices_all_dirty_tracking_started() off from the start? We are introducing
that helper name to just remove it again. And this patch wouldn't be needed anymore

>  static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>  {
>      return (!memory_region_is_ram(section->mr) &&
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 8107873534..15deffe3e4 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -131,7 +131,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>      int ret;
>      Error *local_err = NULL;
>  
> -    if (iotlb && vfio_dma_unmap_dirty_sync_needed(bcontainer)) {
> +    if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
>          if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
>              bcontainer->dirty_pages_supported) {
>              return vfio_dma_unmap_bitmap(container, iova, size, iotlb);


